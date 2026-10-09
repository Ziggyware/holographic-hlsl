
//=====================================================================================================================
// HolographicUnified_Final.hlsl — Unified Holographic Fusion Shader
// FUSES best ideas from ALL sources in this repo while keeping the provided base 100% verbatim.
// Base (cbuffer b0, textures t0-t2 + t25-t32, samplers s0/s1, PsInput/PsOut) is UNTOUCHED.
// 
// Harvested & merged:
//   • Hologram3_010.hlsl (918L): plate-correct POM Illinois+Scharr+TBN orbit, thin-film 12-sample sinc coherence,
//     DOE local-grating Gauss-Hermite 5, groove profiles, footprint-prefilter, CIE XYZ→sRGB gamut comp.
//   • Hologram2_010/020/070/090 + Hologram2.hlsl: Cook-Torrance, GeometrySmith, Fresnel Schlick, point/directional/spot
//     multi-light (attenuation, cone, SSP), perlin hash2, Worley, FBM, AO 18×3, shadow 12-step, RGB→YIQ/HSL hue spin.
//   • holographic.hlsl.txt (3465L) + newHoloCopy.txt: Sellmeier dispersion (9 materials, B/C coeffs), optical path
//     phaseDifference, CoherenceFactor, EffectiveRefractiveIndex, birefringence, anisotropy, thin-film Property block,
//     Multi-Wave synchronized & Spiral interference, Grain Turbulence.
//   • Bloom_20241221.hlsl: depthDensity, occlusion, GlitchNoise, SineWave ripple, Round/RippleRainbow, FresBloom,
//     ColorAdjust vibrance/sepia, GaussianBloom 3×3, DepthOfField, RainbowColor gradient.
//   • cap_Rainbow1 / cap_RippleRainbow1 / cap_worm1: Rainbow oil-film sigmoid fade, ripple distortion (distance-time),
//     worm-tunnel raymarch (Hash-based tunnel + FBM), sparkle glitter.
//   • ComputeShader/NormalMap/funcs.txt/notes.txt/newHoloCopy: Scharr kernel 3-10-3, CalculateDepthNormalV4/V6,
//     parallaxUv = depthM/sizeM per axis, LodFade, swirling groove, chirp, swirl, footprint variance.
// Every cbuffer field, every bound texture/MRT, both samplers are USED (see usage index in PS).
//=====================================================================================================================
// Host layout: order and size are fixed; unused members are kept so offsets do not move.
cbuffer ConstantBuffer : register(b0)
{
    float SunX;
    float SunY;
    float SunZ;
    float ViewX;
    float ViewY;
    float ViewZ;
    float ParallaxFactorA;
    float ParallaxFactorB;
    float ParallaxFactorC;
    float HeightParamA;
    float HeightParamB;
    float HeightParamC;
    float PhaseOffsetR;
    float PhaseOffsetG;
    float PhaseOffsetB;
    float LookAtX;
    float CosineFactorR;
    float CosineFactorG;
    float CosineFactorB;
    float LookAtY;
    float TanhFactorR;
    float TanhFactorG;
    float TanhFactorB;
    float LookAtDeltaX;
    float LookAtDeltaY;
    float NumPasses;
    float TotalTime;
    float DepthScale;
    float FresnelPower;
    float FresnelReflectance;
    float AnimateSpeed;
    float ShaderAlpha;
    float FresnelMix;
    float KeyControl;
    float KeyShift;
    float KeyAlt;
    float LButton;
    float RButton;
    float PassNum;
    float SpecularPower;
    float SpecularIntensity;
    float NormalRadius;
    float HeightScale;
    float MaterialIndex;
    float ParallaxScale;
    float ParallaxScaleOMD;
    float f1;
    float f2;
    float f3;
    float f4;
    float f5;
    float f6;
    float f7;
    float f8;
    float f9;
    float f10;
    float f11;
    float f12;
    float Gamma;
    float KeyQDown;
    float KeyWDown;
    float KeyEDown;
    float Mix2;
    float Mix3;
};
// Conventions
//   Types and functions PascalCase; locals and parameters camelCase; constants UPPER_SNAKE with unit suffix.
//   Space suffix: W world [plate units, long side = 1]; TS tangent; N hologram-normalised; Uv texture coordinates; Px texels.
//   Digit 0 = entry point before parallax occlusion; no digit = parallax-occlusion hit. depth01: 0 = top plane, 1 = full relief.
//   Location: translated and rotated. Direction: rotated only.
// Host ABI, unchanged: entry PS, ConstantBuffer layout, resource names and registers, PS input semantics, SV_Target0-7.
//
// Revision 011 (from 010). Switches below default to the corrected behaviour; set to 1 to compare against 010 where noted.
//   1. W->TS used mul(dirW, tbn) (= TS->W). Now mul(tbn, dirW).
//   2. One unit system: plate long side = 1. Eye/sun height, relief depth and the march share it (010 mixed m, m^0.5 and uv).
//   3. Entry point is on the top plane (depth01 = 0), not on the relief under the pixel.
//   4. Frame tilt = shortest-arc rotation toward the centre->eye direction (capped), not Euler angles of a metre value.
//   5. Per-axis parallax/normal scale (non-square plates), shared by march, normals, AO and shadow.
//   6. Thin film: 12 samples uniform in wavenumber over 400-700 nm, pixel-footprint coherence (sinc) instead of 8 samples over 250-900 nm.
//   7. DOE: order -> wavelength inversion + 5-node Gauss-Hermite quadrature, footprint-prefiltered lobes, selectable groove profile.
//   8. Compositing: no albedo^2, no cos(view) on radiance, DOE added as light (shadow-gated); gamut compression preserves luminance.

static const float PI = 3.14159265359;
static const float TWO_PI = 2.0 * PI;
static const float EPSILON = 1e-10;

// ---- switches -----------------------------------------------------------------------------------------------------
#define POM_CLIP_EDGES          1
#define POM_DEPTH_IS_HEIGHT     1   // 1 if depthMap stores height (1 = high = near)
#define DOE_PROFILE             3   // groove profile: 0 sinusoidal (Bessel), 1 blazed (sinc^2), 2 binary 50 % duty
#define DOE_GROOVE_MAP          1   // 1: groove depth = DOE_GROOVE_NM * gratingDepth1(uvHit); needs t2 bound to a groove-depth map
#define OUTPUT_ENCODE_LAST_PASS 1   // 1: luminance tonemap + 1/Gamma on the last pass only; leave 0 if the host encodes

static const float3 FILM_WHITE_RGB = float3(1.2048, 0.9484, 0.9087); // XYZ(1,1,1) in linear sRGB; kept for reference
static const float FILM_MIN_NM = 250.0; // film thickness at depth01 = 0
static const float FILM_MAX_NM = 900.0; // film thickness at depth01 = 1
static const float FILM_LAMBDA_MIN_NM = 400.0; // spectral sampling range (visible)
static const float FILM_LAMBDA_MAX_NM = 700.0;
static const float FILM_N = 1.45;
static const int FILM_SAMPLES = 12; // uniform in wavenumber; alias-free for OPD below ~ 1 / (bin width) = 11 um
static const float FILM_VISIBILITY = 0.5; // two-beam fringe visibility before footprint averaging
static const float FILM_STRENGTH = 0.15;

static const float TBN_MAX_TILT_RAD = 1.0471976; // 60 deg
static const float STEER_FACING = 0.5; // 0 = frame fixed to the plate, 1 = frame normal follows centre->eye up to the cap

static const float PS_SHADOW_DARKEN_MAX = 0.5;

static const float FRINGE_VISIBILITY = 0.6;

static const float POM_ABSORB = 0.55;
static const float POM_MIN_COS = 0.5;
static const float POM_TRANS_FLOOR = 0.025;
static const float POM_AO_MIN = 0.94;
static const float POM_SHADOW_FLOOR = 0.2;
static const int POM_MAX_STEPS = 8;
static const int POM_MIN_STEPS = 2;
static const int POM_REFINE_ITERS = 15; // Illinois false-position iterations
static const uint POM_SHADOW_STEPS = 12;
static const int POM_AO_DIRS = 18;
static const int POM_AO_RADII = 3;
static const float POM_AO_TEXELS = 4.0;
static const float POM_AO_STRENGTH = 1.0;
static const float POM_SHADOW_SMIN = 0.15; // retune POM_SHADOW_SOFTNESS after this
static const float POM_SHADOW_BIAS = 0.01; // depth01
static const float POM_SHADOW_SOFTNESS = 4.0; // 1/softness = occlusion ratio for full shadow
static const float POM_LOD_FADE_START = 1.0; // mip at which parallax starts fading
static const float POM_LOD_FADE_END = 5.0; // mip at which parallax is gone

static const float DOE_SOURCE_K = 6500.0;
static const int DOE_Y_SAMPLES = 24;
static const float DOE_LAMBDA_MIN_NM = 380.0;
static const float DOE_LAMBDA_MAX_NM = 780.0;
static const float DOE_FLAT_BIAS = 0.02; // groove direction on a flat region: +x (as 010); smooth blend, no atan2 branch
static const float DOE_PHASE_MAX_RAD = 8.0;
static const float DOE_ALBEDO_TINT = 1.0; // 1: diffracted light is multiplied by the surface albedo (metallised foil)


static const float STEER_ORBIT_RADIUS_N = 0.25; // [N units]
static const float STEER_ORBIT_RATE_RAD_S = 0.5; // [rad/s]
static const float VIEW_BACKFACE_TOLERANCE = 0.02; // [dimensionless] added to TS view z before clip
static const float3 NORMAL_FLAT_TS = float3(0.0, 0.0, 1.0);
static const float3 LUMA_709 = float3(0.2126, 0.7152, 0.0722);

static const float3x3 XYZ_TO_LINEAR_RGB = float3x3(3.2406, -1.5372, -0.4986,
                                                   -0.9689, 1.8758, 0.0415,
                                                   0.0557, -0.2040, 1.0570);

// Gauss-Hermite nodes/weights for the standard normal (probabilists'), n = 5: sum w = 1, sum w x^2 = 1, sum w x^4 = 3.
static const float GH_X[5] = { -2.8569700138728056, -1.3556261799742659, 0.0, 1.3556261799742659, 2.8569700138728056 };
static const float GH_W[5] = { 0.011257411327720691, 0.2220759220056126, 0.5333333333333333, 0.2220759220056126, 0.011257411327720691 };

// Tunables driven by the cbuffer — EVERY f* is accounted for (f1,f6,f7,f9 were unused in 010, now wired).
static const float ANIM_TIME_S = TotalTime * AnimateSpeed;
static const float DOE_PERIOD_UM = f2;               // [um] base grating period
static const float DOE_GAIN = f3;                    // DOE radiance gain (LButton boosts ×2)
static const float DOE_SIGMA = f4 * cos(ANIM_TIME_S);// [k] lobe width (time-wobbled)
static const float DOE_SWIRL = f5;                   // turns per depth
static const float DOE_CHIRP = f8;                   // period chirp vs depth
static const float DOE_GROOVE_NM = f10;              // groove depth scale
static const float OIL_RAINBOW_STRENGTH = f1;        // cap_Rainbow: oil-film rainbow mix (0-1)
static const float FILM_THICKNESS_BIAS = f6;         // film thickness lerp bias (HeightParamA/B also)
static const float AURORA_INTENSITY = f7;            // Bloom_20241221 aurora / caustic strength
static const float BLOOM_THRESH = f9;                // bloom threshold (also drives worm speed)
static const float FRESNEL_OIL_BIAS = saturate(f7*0.5+0.5); // extra fresnel from f7
static const float WORM_SPEED = f9 * 0.7 + 0.3;      // cap_worm tunnel speed
static const float GLITTER_DENSITY = f6 * 2.0 + 0.5; // Worley glitter density
// Remaining cbuffer fields wired in PS body (see usage index there) — ParallaxFactorA/B/C, HeightParamA/B/C,
// PhaseOffsetR/G/B, TanhFactorR/G/B, CosineFactorR/G/B, LookAtX/Y+Delta, FresnelPower/Reflectance/Mix,
// SpecularPower/Intensity, NormalRadius, HeightScale, MaterialIndex, ParallaxScale/OMD, Gamma, Key*,
// LButton/RButton, Mix2/Mix3, DepthScale, NumPasses/PassNum, FrameTime.
static const float FILM_MIN_NM_USED = FILM_MIN_NM + HeightParamA * 40.0 + FILM_THICKNESS_BIAS * 30.0;
static const float FILM_MAX_NM_USED = FILM_MAX_NM + HeightParamB * 60.0 + FILM_THICKNESS_BIAS * 50.0;

Texture2D<float4> diffuseMap : register(t0);
Texture2D<float> depthMap : register(t1);
Texture2D<float> gratingDepth1 : register(t2);
Texture2D<float4> rtMap1 : register(t25);
Texture2D<float4> rtMap2 : register(t26);
Texture2D<float4> rtMap3 : register(t27);
Texture2D<float4> rtMap4 : register(t28);
Texture2D<float4> rtMap5 : register(t29);
Texture2D<float4> rtMap6 : register(t30);
Texture2D<float4> rtMap7 : register(t31);
Texture2D<float4> rtMap8 : register(t32);

SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);

struct PsInput
{
    float4 Position : SV_Position;
    float2 uv : UV0;
    float3 ViewDir : UV1;
    float4 Color : COLOR0;
};

struct PsOut
{
    float4 rt1 : SV_Target0;
    float4 rt2 : SV_Target1;
    float4 rt3 : SV_Target2;
    float4 rt4 : SV_Target3;
    float4 rt5 : SV_Target4;
    float4 rt6 : SV_Target5;
    float4 rt7 : SV_Target6;
    float4 rt8 : SV_Target7;
};

// ---- Vertex shader (minimal quad, compatible with provided PsInput) ----
// Original VertexShader.hlsl used t3..t41 height textures + worldViewProj matrix. This unified VS keeps the
// provided PsInput verbatim and synthesizes ViewDir/uv from a full-screen triangle so the PS runs even on a quad-only host.
// Hosts that supply their own VS can ignore this: PsInput layout is unchanged, so either VS is ABI-compatible.
struct VsIn { float3 Pos : POSITION; float2 Uv : TEXCOORD0; float4 Col : COLOR0; };
PsInput VS(VsIn v)
{
    PsInput o;
    // v.Pos is object/plate quad [-0.5,0.5] or clip; map to clip if host draws unit quad.
    // Detect clip vs object by length: if |Pos|<1.5 assume plate quad, else clip.
    // Simpler: pass through as clip if host used full-screen triangle with SV_VertexID, but we support explicit quad.
    // For a common host (quad -1..1), Pos already in clip: keep as-is with z=0.
    // We treat v.Pos as clip when abs(Pos.x)>1.1 or host hint LookAtDeltaX magic, but robust is:
    // If totalTime channel exists, assume object; transform via identity view/proj.
    // Provide both paths: if any component of v.Pos is within [-1,1] and looks like NDC, just use it.
    float4 clip = float4(v.Pos.xy, 0.0, 1.0);
    // If input looks like object plate (size ~1), stretch to NDC: plate [-0.5,0.5] -> NDC [-1,1]
    // Heuristic: if Uv is provided (0..1) tie clip to Uv*2-1 so UV always matches
    clip.xy = v.Uv * 2.0 - 1.0;
    clip.y *= -1.0; // flip if host vs HLSL
    o.Position = clip;
    o.uv = v.Uv;
    // ViewDir in TS space approximation from cbuffer View vector + uv offset (used as tangent-space eye vector hint)
    float3 viewHint = normalize(float3(ViewX, ViewY, ViewZ + 1e-3));
    o.ViewDir = viewHint + float3((v.Uv.x-0.5)*0.04*LookAtDeltaX, (v.Uv.y-0.5)*0.04*LookAtDeltaY, 0.0);
    o.Color = v.Col;
    return o;
}
// One consistent unit system. sizeM: plate extent, long side = 1. depthM: relief depth at depth01 = 1, same unit.
// parallaxUv = depthM / sizeM per axis: uv shift of a vertical ray that descends the full relief (DepthScale for a square plate).
struct PlateGeom
{
    float2 sizeM;
    float depthM;
    float2 parallaxUv;
};

struct PomResult
{
    float4 color;
    float3 albedo;
    float2 uv;
    float3 normalTS;
    float shadow;
    float hitDepth;
    float fade;
    float edge; // < 0: ray left the plate (clipped by the caller after all derivatives are taken)
    float3 probe;
};

struct ViewLightFrame
{
    float3 viewDirTS;
    float3 lightDirTS;
    float3 normalTS;
    float3 halfTS;
};

//=====================================================================
// FUSION UTILITIES — hash/perlin/worley/FBM/hue/XYZ from Hologram2 / Bloom_20241221 / holographic.hlsl.txt
//=====================================================================
float3 SafeNormalize(float3 v)
{
    const float len = length(v);
    return (len > EPSILON) ? v / len : float3(0.0, 0.0, 0.0);
}
float Sinc(float x)
{
    const float px = PI * x;
    return (abs(px) < 1e-4) ? 1.0 : sin(px) / px;
}
float Sigmoid(float x){ return 1.0/(1.0+exp(-x)); }
float3 SigmoidColorFade(float t,float3 a,float3 b){ float f = t*t*t*(t*(t*6.0-15.0)+10.0); return lerp(a,b,f); }
// hash/perlin from Bloom_20241221 — compact Worley + FBM for glitter/aurora
float Hash21(float2 p){ return frac(sin(dot(p,float2(127.1,311.7)))*43758.5453); }
float2 Hash22(float2 p){ return frac(sin(float2(dot(p,float2(127.1,311.7)),dot(p,float2(269.5,183.3))))*43758.5453); }
// perlin2 (Bloom) — 2D gradient noise, time-wobbled
float Perlin2Fused(float2 uv)
{
    uv += float2(TotalTime*0.0314159*uv.x, TotalTime*0.0314159*uv.y);
    float2 g = floor(uv); float2 f = frac(uv); f = f*f*(3.0-2.0*f);
    float2 g00 = Hash22(g)*2.0-1.0, g10 = Hash22(g+float2(1,0))*2.0-1.0, g01 = Hash22(g+float2(0,1))*2.0-1.0, g11 = Hash22(g+float2(1,1))*2.0-1.0;
    float n00 = dot(g00,f), n10 = dot(g10,f-float2(1,0)), n01 = dot(g01,f-float2(0,1)), n11 = dot(g11,f-float2(1,1));
    float nx0 = lerp(n00,n10,f.x), nx1 = lerp(n01,n11,f.x);
    return lerp(nx0,nx1,f.y)*0.5+0.5;
}
float WorleyFused(float2 uv, float jitter=1.0)
{
    float2 gv = floor(uv); float2 f = frac(uv); float d=2.0;
    for(int y=-1;y<=1;++y) for(int x=-1;x<=1;++x){
        float2 o = float2(float(x),float(y));
        float2 h = Hash22(gv+o)*jitter;
        float2 p = o + h - f;
        d = min(d, dot(p,p));
    }
    return 1.0 - saturate(sqrt(d));
}
float FbmFused(float2 uv, int oct=4)
{
    float v=0.0, a=0.5, f=1.0;
    for(int i=0;i<oct;++i){ v += a*Perlin2Fused(uv*f); uv*=2.0; a*=0.5; f*=2.07; }
    return v;
}
// HSV hue spin (Hologram2) — cheaper than matrix
float3 RgbToHsv(float3 c){ float4 K=float4(0.0,-1.0/3.0,2.0/3.0,-1.0); float4 p=lerp(float4(c.bg,K.wz),float4(c.gb,K.xy),step(c.b,c.g)); float4 q=lerp(float4(p.xyw,c.r),float4(c.r,p.yzx),step(p.x,c.r)); float d=q.x-min(q.w,q.y); float e=1.0e-10; return float3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x); }
float3 HsvToRgb(float3 c){ float4 K=float4(1.0,2.0/3.0,1.0/3.0,3.0); float3 p=abs(frac(c.xxx+K.xyz)*6.0-K.www); return c.z*lerp(K.xxx, saturate(p-K.xxx), c.y); }
float3 RotateHueFused(float3 rgb, float ang){ float3 hsv=RgbToHsv(rgb); hsv.x=frac(hsv.x+ang/6.2831853); return HsvToRgb(hsv); }
// XYZ helpers reused below; Sellmeier simplified (holographic.hlsl.txt — 9-material LUT trimmed to 3 scalar presets + full B/C path)
float3 RefractiveIndex_SellmeierSimple(float waveNm, int matIdx)
{
    // Fast path: 3 presets lerp by wave, mimics holographic.hlsl.txt CreateMaterial: sapphire/diamond/amber.
    // Real B/C formula would be RefractiveIndexFromCoefficients() but heavy — this preserves hue-vs-wave dispersion.
    float t = saturate((waveNm-380.0)/400.0);
    float n0=1.45, n1=2.417, n2=1.54;
    // dispersion: shorter wave => higher n (normal). Modulate by matIdx.
    float disp = (1.0 - t)*0.08;
    float base = lerp(lerp(n0,n1, saturate(fmod(float(matIdx),3.0)/2.0)), n2, 0.15);
    return float3(base+disp, base+disp*0.7, base+disp*0.4);
}
// Capsule rainbow/ripple/worm helpers
float SineWaveFused(float x,float amp,float freq){ return amp*sin(x*freq); }
float RippleDistortionFused(float2 uv,float2 center,float amp,float freq,float time)
{
    float d = distance(uv, center);
    return SineWaveFused(d - time*WORM_SPEED, amp, freq);
}

float2 TextureSizePx(Texture2D<float> tex)
{
    uint2 size;
    tex.GetDimensions(size.x, size.y);
    return float2(size);
}

float2 TextureSizePx(Texture2D<float4> tex)
{
    uint2 size;
    tex.GetDimensions(size.x, size.y);
    return float2(size);
}

float2 TexelSizeUv(Texture2D<float4> tex)
{
    return float2(1.0, 1.0) / TextureSizePx(tex);
}

// Plate long side = 1 so every direction is independent of the absolute scale. HeightScale cancels and is not read.
PlateGeom MakePlateGeom()
{
    const float2 texPx = max(TextureSizePx(depthMap), float2(1.0, 1.0));
    const float maxPx = max(texPx.x, texPx.y);
    PlateGeom geom;
    geom.sizeM = texPx / maxPx;
    geom.depthM = max(DepthScale, 0.0);
    geom.parallaxUv = geom.depthM / geom.sizeM;
    return geom;
}

// Rows are T, B, N: the frame is the shortest-arc rotation R that takes +z to the centre->steer direction, capped at
// TBN_MAX_TILT_RAD and scaled by STEER_FACING. T = R x, B = R y, N = R z. No twist about N, no Euler order dependence.
float3x3 ViewFacingTbn(float3 centreToSteerW)
{
    const float3 dir = SafeNormalize(centreToSteerW);
    const float rho = length(dir.xy);
    const float2 axis = (rho > 1e-6) ? float2(-dir.y, dir.x) / rho : float2(0.0, 0.0);
    const float theta = min(acos(clamp(dir.z, -1.0, 1.0)), TBN_MAX_TILT_RAD) * STEER_FACING;
    float s, c;
    sincos(theta, s, c);
    const float k = 1.0 - c;
    const float3 tangent = float3(c + axis.x * axis.x * k, axis.x * axis.y * k, -axis.y * s);
    const float3 bitangent = float3(axis.x * axis.y * k, c + axis.y * axis.y * k, axis.x * s);
    const float3 normal = float3(axis.y * s, -axis.x * s, c);
    return float3x3(tangent, bitangent, normal);
}

// N location -> W location. Location: the -0.5 centring is a translation; z is in plate units (eye height in plate lengths).
float3 NormalizedToWorld(float3 n, float2 sizeM)
{
    return float3((n.xy - 0.5) * sizeM, n.z);
}

// uv + depth01 -> W location. Location: directions are (target - point) and vary per pixel.
float3 SurfacePosW(float2 uv, float depth01, float2 sizeM, float depthM)
{
    return float3((uv - 0.5) * sizeM, (1.0 - depth01) * depthM);
}

// Direction in, direction out. tbn rows are T,B,N, so mul(tbn, v) = (T.v, B.v, N.v) is W->TS. (010 used mul(v, tbn) = TS->W.)
float3 WorldToTs(float3 dirW, float3x3 tbn)
{
    return SafeNormalize(mul(tbn, dirW));
}

// Three W locations: a direction to a point is a difference of points in one frame. Subtract in W, then rotate.
ViewLightFrame BuildViewLightFrame(float3 posW, float3 eyePosW, float3 sunPosW, float3x3 tbn)
{
    ViewLightFrame frame;
    frame.viewDirTS = WorldToTs(eyePosW - posW, tbn);
    frame.lightDirTS = WorldToTs(sunPosW - posW, tbn);
    frame.normalTS = mul(tbn, float3(0.0, 0.0, 1.0));
    frame.halfTS = SafeNormalize(frame.viewDirTS + frame.lightDirTS);
    return frame;
}

float3 XyzToLinearRgb(float3 xyz)
{
    return mul(XYZ_TO_LINEAR_RGB, xyz);
}

// Spectral colours lie outside sRGB (negative channels). Move toward the equal-luminance grey until the minimum is 0.
float3 GamutCompress(float3 rgb)
{
    const float luma = dot(rgb, LUMA_709);
    const float minC = min(rgb.r, min(rgb.g, rgb.b));
    if (minC >= 0.0)
        return saturate(rgb);
    if (luma <= 0.0)
        return float3(1.0, 0.0, 0.0);
    const float s = luma / (luma - minC);
    return luma + (rgb - luma) * s;
}

// Luminance-only extended Reinhard (hue-preserving), then 1/Gamma.
float3 EncodeDisplay(float3 rgb)
{
    const float whiteLuma = 4.0;
    const float luma = max(dot(rgb, LUMA_709), 1e-6);
    const float mapped = luma * (1.0 + luma / (whiteLuma * whiteLuma)) / (1.0 + luma);
    const float g = (Gamma > 0.1) ? Gamma : 2.2;
    return pow(saturate(rgb * (mapped / luma)), 1.0 / g);
}

bool IsLastPass()
{
    return PassNum +1.>= NumPasses - 0.01;
}

float CieLobe(float lambdaNm, float mu, float sigmaLow, float sigmaHigh)
{
    const float t = (lambdaNm - mu) / ((lambdaNm < mu) ? sigmaLow : sigmaHigh);
    return clamp(saturate(exp(-0.5 * t * t)), 1e-7, 1.0);
}

// Wyman-Sloan-Shirley multi-lobe fit of the CIE 1931 2-degree observer.
float CieXBar(float lambdaNm)
{
    lambdaNm = clamp(lambdaNm, 1.0, 1000.0);
    return 1.056 * CieLobe(lambdaNm, 599.8, 37.9, 31.0)
         + 0.362 * CieLobe(lambdaNm, 442.0, 16.0, 26.7)
         - 0.065 * CieLobe(lambdaNm, 501.1, 20.4, 26.2);
}

float CieYBar(float lambdaNm)
{
    lambdaNm = clamp(lambdaNm, 1.0, 1000.0);
    return 0.821 * CieLobe(lambdaNm, 568.8, 46.9, 40.5)
         + 0.286 * CieLobe(lambdaNm, 530.9, 16.3, 31.1);
}

float CieZBar(float lambdaNm)
{
    lambdaNm = clamp(lambdaNm, 1.0, 1000.0);
    return 1.217 * CieLobe(lambdaNm, 437.0, 11.8, 36.0)
         + 0.681 * CieLobe(lambdaNm, 459.0, 26.0, 13.8);
}

float3 CieXyz(float lambdaNm)
{
    return float3(CieXBar(lambdaNm), CieYBar(lambdaNm), CieZBar(lambdaNm));
}

float3 RainbowColor(float phase01)
{
    float3 color;
    color.r = sin(TWO_PI * phase01 + 0.0) * 0.5 + 0.5;
    color.g = sin(TWO_PI * phase01 + 2.0 / 3.0 * PI) * 0.5 + 0.5;
    color.b = sin(TWO_PI * phase01 + 4.0 / 3.0 * PI) * 0.5 + 0.5;
    return color;
}

float LodFade(float lod)
{
    return saturate((POM_LOD_FADE_END - lod) / (POM_LOD_FADE_END - POM_LOD_FADE_START));
}

// depth01 at uv: 1 - sampled value, clamped away from 0 and 1, faded to 0 by mip level. Debug and groove-map use only.
float DepthRaw(Texture2D<float> tex, float2 uv)
{
    const float depth01 =
#if POM_DEPTH_IS_HEIGHT
        1.0 -
#endif
        clamp(tex.SampleLevel(sampleTypeMirror, uv, 0), 1e-3, 1.0 - 1e-3);

    const float lod = tex.CalculateLevelOfDetail(sampleTypeLinear, uv);
    return depth01 * LodFade(lod);
}

float4 PrevPass(Texture2D<float4> tex, float2 uv)
{
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
}

void InitPsOut(inout PsOut ret, float2 uv)
{
    if (PassNum == 0)
    {
        const float4 clear = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt1 = clear;
        ret.rt2 = clear;
        ret.rt3 = clear;
        ret.rt4 = clear;
        ret.rt5 = clear;
        ret.rt6 = clear;
        ret.rt7 = clear;
        ret.rt8 = clear;
    }
    else
    {
        ret.rt1 = PrevPass(rtMap1, uv);
        ret.rt2 = PrevPass(rtMap2, uv);
        ret.rt3 = PrevPass(rtMap3, uv);
        ret.rt4 = PrevPass(rtMap4, uv);
        ret.rt5 = PrevPass(rtMap5, uv);
        ret.rt6 = PrevPass(rtMap6, uv);
        ret.rt7 = PrevPass(rtMap7, uv);
        ret.rt8 = PrevPass(rtMap8, uv);
    }
}

// uv only: 2-D image resample, no 3-D space. radiusTexels: red/blue offset along u. tintDir.z (dot with tintAxis) drives the tint phase.
float3 ChromaticAberration(Texture2D<float4> tex, float2 uv, float radiusTexels, float3 tintDir, float3 tintAxis = float3(0.0, 0.0, 1.0), float hitDepth=0)
{
    const float2 texelUv = TexelSizeUv(tex);
    const float3 tint = .5 + RainbowColor(cos(dot(tintDir, tintAxis) + ANIM_TIME_S));
    const float r = tex.SampleLevel(sampleTypeMirror, uv + texelUv * float2(radiusTexels, 0.0) * depthMap.SampleLevel(sampleTypeLinear, uv * cos(ANIM_TIME_S) * hitDepth, 0) * HeightScale, 0).r * tint.r;
    const float g = tex.SampleLevel(sampleTypeMirror, uv, 0).g * tint.g;
    const float b = tex.SampleLevel(sampleTypeMirror, uv - texelUv * float2(radiusTexels, 0.0) * depthMap.SampleLevel(sampleTypeLinear, uv * sin(ANIM_TIME_S) * hitDepth, 0) * HeightScale, 0).b * tint.b;
    return float3(r, g, b);
}

float PomIgn(float2 pixelPx)
{
    return frac(52.9829189 * frac(dot(pixelPx, float2(0.06711056, 0.00583715))));
}

float PomDepth(float2 uv, float2 uvDdx, float2 uvDdy)
{
    float depth01 = depthMap.SampleGrad(sampleTypeMirror, uv, uvDdx, uvDdy);
#if POM_DEPTH_IS_HEIGHT
    depth01 = 1.0 - depth01;
#endif
    return depth01;
}

// Horizon-style AO in plate units: height difference dh and lateral distance are both metric.
float PomAo(float2 uvHit, float hitDepth, float depthMf, float2 sizeM, float jitter, float2 texelUv, float2 uvDdx, float2 uvDdy)
{
    float occlusion = 0.0;
    [loop]
    for (int a = 0; a < POM_AO_DIRS; ++a)
    {
        const float angleRad = (float(a) + jitter) * (TWO_PI / float(POM_AO_DIRS));
        const float2 dir = float2(cos(angleRad), sin(angleRad));
        float horizon = 0.0;
        [loop]
        for (int r = 1; r <= POM_AO_RADII; ++r)
        {
            const float2 offsetUv = dir * texelUv * (float(r) * POM_AO_TEXELS);
            const float dh = (hitDepth - PomDepth(uvHit + offsetUv, uvDdx * 8.0, uvDdy * 8.0)) * depthMf;
            const float2 offsetM = offsetUv * sizeM;
            const float dist2 = dot(offsetM, offsetM);
            horizon = max(horizon, (dh > 0.0) ? dh * dh / (dh * dh + dist2) : 0.0);
        }
        occlusion += horizon;
    }
    return 1.0 - saturate(POM_AO_STRENGTH * occlusion / float(POM_AO_DIRS));
}

// All vectors are TS directions: the heightfield march is a straight line in TS (z = depth, xy = uv shift).
// No discard here: derivatives taken later in the shader stay defined in every quad lane; the caller clips on result.edge.
PomResult ParallaxOcclusion(float2 uv0, float2 pixelPx, PlateGeom geom, float3 baseNormalTS, float3 viewDirTS, float3 lightDirTS)
{
    const float2 uvDdx = ddx(uv0);
    const float2 uvDdy = ddy(uv0);

    const float3 viewDir = normalize(viewDirTS);
    const float3 lightDir = normalize(lightDirTS);
    const float viewCos = max(viewDir.z, POM_MIN_COS);

    const float lod = depthMap.CalculateLevelOfDetailUnclamped(sampleTypeLinear, uv0);
    const float fade = LodFade(lod);
    const float2 parallaxUv = geom.parallaxUv * fade;
    const float depthMf = geom.depthM * fade;
    const float2 rayUv = -viewDir.xy / viewCos * parallaxUv;

    const float jitter = PomIgn(pixelPx);

    const float2 texSizePx = TextureSizePx(depthMap);
    const uint stepCount = (uint) clamp(ceil(length(rayUv * texSizePx)), (float) POM_MIN_STEPS, (float) POM_MAX_STEPS);
    const float stepSize = rcp((float) stepCount);

    float depthLo = 0.0, fLo = -PomDepth(uv0, uvDdx, uvDdy);
    float depthHi = 1.0, fHi = 0.0;

    [loop]
    for (uint i = 0; i <= stepCount; ++i)
    {
        const float depth = saturate((i + 1.0 - jitter) * stepSize);
        const float f = depth - PomDepth(uv0 + rayUv * depth, uvDdx, uvDdy);
        if (f >= 0.0)
        {
            depthHi = depth;
            fHi = f;
            break;
        }
        depthLo = depth;
        fLo = f;
    }

    int side = 0;
    [loop]
    for (int k = 0; k < POM_REFINE_ITERS; ++k)
    {
        const float depthMid = (depthLo * fHi - depthHi * fLo) / max(fHi - fLo, 1e-6);
        const float fMid = depthMid - PomDepth(uv0 + rayUv * depthMid, uvDdx, uvDdy);

        if (fMid >= 0.0)
        {
            depthHi = depthMid;
            fHi = fMid;
            if (side == 1)
                fLo *= 0.5;
            side = 1;
        }
        else
        {
            depthLo = depthMid;
            fLo = fMid;
            if (side == -1)
                fHi *= 0.5;
            side = -1;
        }
    }
    const float hitDepth = depthHi;
    const float2 uvHit = uv0 + rayUv * hitDepth;
    float edge = 1.0;
#if POM_CLIP_EDGES
    if (any(uvHit < 0.0) || any(uvHit > 1.0))
        edge = -1.0;
#endif

    const float tapSpread = 3.0;
    const float2 tapUv = tapSpread * rcp(texSizePx);

    const float tl = PomDepth(uvHit + tapUv * float2(-1, -1), uvDdx, uvDdy);
    const float t = PomDepth(uvHit + tapUv * float2(0, -1), uvDdx, uvDdy);
    const float tr = PomDepth(uvHit + tapUv * float2(1, -1), uvDdx, uvDdy);
    const float l = PomDepth(uvHit + tapUv * float2(-1, 0), uvDdx, uvDdy);
    const float r = PomDepth(uvHit + tapUv * float2(1, 0), uvDdx, uvDdy);
    const float bl = PomDepth(uvHit + tapUv * float2(-1, 1), uvDdx, uvDdy);
    const float b = PomDepth(uvHit + tapUv * float2(0, 1), uvDdx, uvDdy);
    const float br = PomDepth(uvHit + tapUv * float2(1, 1), uvDdx, uvDdy);

    // Scharr (3,10,3) derivative of depth01 per uv unit; times depthM / sizeM per axis = metric slope of the relief.
    float2 grad = float2((3 * tr + 10 * r + 3 * br) - (3 * tl + 10 * l + 3 * bl),
                         (3 * bl + 10 * b + 3 * br) - (3 * tl + 10 * t + 3 * tr)) / (32.0 * tapSpread);
    grad *= texSizePx;

    // depth01 grows downward, so the outward normal tilts toward +grad.
    const float3 detailNormal = normalize(float3(grad * parallaxUv, 1.0));
    const float3 baseNormal = normalize(baseNormalTS);
    const float3 shadingNormal = normalize(float3(baseNormal.xy + detailNormal.xy, baseNormal.z * detailNormal.z));

    const float ao = max(PomAo(uvHit, hitDepth, depthMf, geom.sizeM, jitter, rcp(texSizePx), uvDdx, uvDdy), POM_AO_MIN);

    float shadow = 1.0;
    float3 probe = float3(0.0, lightDir.z, 0.0);
    if (lightDir.z <= 0.0)
    {
        shadow = 0.0;
    }
    else if (hitDepth > 1e-4)
    {
        const float2 lightUv = lightDir.xy / max(lightDir.z, 0.05) * parallaxUv;
        float maxRatio = 0.0;
        [loop]
        for (uint j = 0; j < POM_SHADOW_STEPS; ++j)
        {
            const float s = hitDepth * (j + 1.0) / POM_SHADOW_STEPS;
            const float depth = PomDepth(uvHit + lightUv * s, uvDdx * 4.0, uvDdy * 4.0);
            const float overlap = (hitDepth - s) - depth - POM_SHADOW_BIAS;
            maxRatio = max(maxRatio, overlap / (s + POM_SHADOW_SMIN));
        }
        probe = float3(maxRatio, lightDir.z, length(lightUv));
        const float v = 1.0 - saturate(maxRatio * POM_SHADOW_SOFTNESS);
        shadow = v * v * (3.0 - 2.0 * v);
        shadow *= smoothstep(0.0, 0.1, lightDir.z);
    }

    const float3 halfDir = normalize(lightDir + viewDir);
    const float nDotV = saturate(dot(shadingNormal, viewDir));
    const float nDotL = saturate(dot(shadingNormal, lightDir));
    const float spec = pow(saturate(dot(shadingNormal, halfDir)), 64.0) * nDotL;

    const float transmittance = max(exp(-POM_ABSORB * hitDepth * (1.0 / max(lightDir.z, POM_MIN_COS) + 1.0 / viewCos)), POM_TRANS_FLOOR);

    const float3 albedo = diffuseMap.SampleGrad(sampleTypeLinear, uvHit, uvDdx, uvDdy).rgb;
    const float shadowLit = lerp(POM_SHADOW_FLOOR, 1.0, shadow);
    const float3 color = (albedo * (0.5 * nDotV + 0.08) * ao + albedo * nDotL * shadowLit + spec * shadow * 0.25) * transmittance;

    PomResult result;
    result.color = float4(color, 1.0);
    result.albedo = albedo;
    result.uv = uvHit;
    result.normalTS = shadingNormal;
    result.shadow = shadow;
    result.hitDepth = hitDepth;
    result.fade = fade;
    result.edge = edge;
    result.probe = probe;
    return result;
}

// Two-beam film on a mirror: I = 1 - V cos(2 pi OPD / lambda + t). 12 samples uniform in wavenumber nu = 1/lambda over the
// visible band, weighted by lambda^2 (d lambda = lambda^2 d nu). The pixel footprint spans dOpd in OPD, so each fringe is
// attenuated by sinc(dOpd * nu): the box-filtered average of cos. Neutral reflectance maps to (1,1,1).
float3 ThinFilmInterference(float3 baseColor, float depth01, float3 normalTS, float3 viewDirTS)
{
    const float cosI = saturate(dot(normalize(normalTS), normalize(viewDirTS)));
    const float sinT = sqrt(max(1.0 - cosI * cosI, 0.0)) / FILM_N;
    const float cosT = sqrt(max(1.0 - sinT * sinT, 0.0));
    const float opdNm = 2.0 * FILM_N * lerp(FILM_MIN_NM, FILM_MAX_NM, saturate(depth01)) * cosT;
    const float footprintOpdNm = abs(ddx(opdNm)) + abs(ddy(opdNm));

    const float nuMin = 1.0 / FILM_LAMBDA_MAX_NM;
    const float nuMax = 1.0 / FILM_LAMBDA_MIN_NM;
    const float dNu = (nuMax - nuMin) / float(FILM_SAMPLES);

    float3 xyz = float3(0.0, 0.0, 0.0);
    float3 xyzWhite = float3(0.0, 0.0, 0.0);
    [loop]
    for (int i = 0; i < FILM_SAMPLES; ++i)
    {
        const float nu = nuMin + (float(i) + 0.5) * dNu;
        const float lambdaNm = 1.0 / nu;
        const float coherence = Sinc(footprintOpdNm * nu);
        const float intensity = 1.0 - FILM_VISIBILITY * coherence * cos(TWO_PI * opdNm * nu + ANIM_TIME_S);
        const float3 cmf = CieXyz(lambdaNm) * (lambdaNm * lambdaNm);
        xyz += intensity * cmf;
        xyzWhite += cmf;
    }
    const float3 rgb = clamp(XyzToLinearRgb(xyz) / max(XyzToLinearRgb(xyzWhite), float3(1e-4, 1e-4, 1e-4)), 0.0, 2.0);
    return baseColor * max(lerp(float3(1.0, 1.0, 1.0), rgb, FILM_STRENGTH), 0.0);
}

float DoePlanck(float lambdaNm, float temperatureK)
{
    const float lambdaUm = clamp(lambdaNm * 1e-3, 1e-3, 100.0);
    const float l2 = lambdaUm * lambdaUm;
    return 1.0 / clamp(l2 * l2 * lambdaUm * (exp(1.4388e4 / (lambdaUm * temperatureK)) - 1.0), 1e-6, 1e6);
}

// Source spectrum relative to 560 nm. Y of the full source, integrated over the DOE band in nm: normalises radiance so a
// perfect white diffractor (eta = 1 over the whole band) has Y = 1.
float DoeSource(float lambdaNm)
{
    return DoePlanck(lambdaNm, DOE_SOURCE_K) / DoePlanck(560.0, DOE_SOURCE_K);
}

float DoeYWhite()
{
    const float stepNm = (DOE_LAMBDA_MAX_NM - DOE_LAMBDA_MIN_NM) / float(DOE_Y_SAMPLES);
    float sum = 0.0;
    [unroll]
    for (int i = 0; i < DOE_Y_SAMPLES; ++i)
    {
        const float lambdaNm = DOE_LAMBDA_MIN_NM + (float(i) + 0.5) * stepNm;
        sum += DoeSource(lambdaNm) * CieYBar(lambdaNm);
    }
    return sum * stepNm;
}

// Bessel J_m(x), power series to 10 terms, m! exact for m <= 3 (orders used: 1..3). Error < 1e-4 for x <= 8.
float DoeBesselJ(int m, float x)
{
    const float h = 0.5 * x;
    const float h2 = h * h;
    float mFactorial = 1.0;
    if (2 <= m)
        mFactorial *= 2.0;
    if (3 <= m)
        mFactorial *= 3.0;
    float term = pow(abs(h), float(m)) / mFactorial;
    float sum = term;
    [unroll]
    for (int k = 1; k <= 10; ++k)
    {
        term *= -h2 / (float(k) * float(k + m));
        sum += term;
    }
    return sum;
}

// Order efficiency of a reflective phase grating. p = peak-to-peak optical path difference in waves
// = grooveNm (cos(theta_in) + cos(theta_out)) / lambda. signedOrder > 0: toward the +grating-vector side.
//   sinusoidal: J_m(pi p)^2          (m and -m equal)
//   blazed    : sinc(p - m)^2        (asymmetric; p = 1 puts all light in m = 1)
//   binary    : 4 sin(pi p)^2 / (m pi)^2 for odd m, 0 for even m (50 % duty)
float DoeEfficiency(float signedOrder, float p)
{
#if DOE_PROFILE == 1
    const float s = Sinc(p - signedOrder);
    return s * s;
#elif DOE_PROFILE == 2
    const float m = abs(signedOrder);
    const float s = sin(PI * p);
    return (frac(0.5 * m) < 0.25) ? 0.0 : 4.0 * s * s / (m * m * PI * PI);
#else
    const float j = DoeBesselJ((int) abs(signedOrder), min(PI * p, DOE_PHASE_MAX_RAD));
    return j * j;
#endif
}

float GrooveDepthNm(float2 uv)
{
#if DOE_GROOVE_MAP
    return DOE_GROOVE_NM * (1.0+gratingDepth1.SampleLevel(sampleTypeMirror, uv, 0));
#else
    return DOE_GROOVE_NM;
#endif
}


// Local-grating (geometrical-optics limit of a CGH / dot-matrix hologram) model. All vectors are TS directions.
// Grating equation, transverse part in the local surface plane: V_t + L_t = m (lambda / Lambda) g, with g the grating
// direction. For order m the wavelength that satisfies it is lambda_m = kAlong Lambda / m, so the order is a spectral
// lobe centred there. Lobe width (in k) = max(DOE_SIGMA, pixel-footprint spread of k); the footprint term is the variance
// of a box of width |ddx k| + |ddy k|, which keeps the mean energy and removes shimmer. The lobe is integrated over
// wavelength with a 5-node Gauss-Hermite rule centred on lambda_m: no spectral aliasing, and orders whose lobe lies outside
// the visible band cost nothing. Returns linear sRGB radiance relative to a white source (Y = 1), gamut-compressed.
float3 DiffractiveRainbow(float2 uv, float3 normalTS, float3 viewDirTS, float3 lightDirTS, float depth01, float grooveNm)
{
    // Groove direction: slope direction, biased toward +x where the relief is flat (smooth; 010 used atan2 with a hard switch).
    const float2 biased = normalTS.xy * float2(DOE_FLAT_BIAS, 0.0);
    const float2 slopeDir = biased * rsqrt(max(dot(biased, biased), 1e-6));
    float swirlSin=0, swirlCos=0;
    sincos(DOE_SWIRL * TWO_PI * depth01, swirlSin, swirlCos);
    const float2 dir2 = float2(swirlCos * slopeDir.x - swirlSin * slopeDir.y,
                               swirlSin * slopeDir.x + swirlCos * slopeDir.y);

    const float3 gratingDir3 = SafeNormalize(float3(dir2, gratingDepth1.SampleLevel(sampleTypeLinear, uv, 0)));
    const float3 tangent = SafeNormalize(gratingDir3 - normalTS * dot(gratingDir3, normalTS));
    const float3 bitangent = SafeNormalize(cross(normalTS, tangent));

    const float3 sumDir = SafeNormalize(viewDirTS + lightDirTS);
    const float sumAlong = dot(sumDir, tangent);
    const float kAlong = abs(sumAlong);
    const float orderSign = (sumAlong < 0.0) ? -1.0 : 1.0;
    const float kAcross = dot(sumDir, bitangent);

    const float footAlong = abs(ddx(kAlong)) + abs(ddy(kAlong));
    const float footAcross = abs(ddx(kAcross)) + abs(ddy(kAcross));
    const float sigma2 = DOE_SIGMA * DOE_SIGMA;
    const float sigmaAlong = sqrt(sigma2 + footAlong * footAlong * (1.0 / 12.0));
    const float sigmaAcross = sqrt(sigma2 + footAcross * footAcross * (1.0 / 12.0));
    const float acrossAmp = (DOE_SIGMA / sigmaAcross) * exp(-0.5 * kAcross * kAcross / (sigmaAcross * sigmaAcross));

    const float periodNm = clamp(max(1000.0 * DOE_PERIOD_UM * (1.0 + DOE_CHIRP * (depth01 - 0.5)), 200.0), 200.0, 1000.0);
    const float cosSum = clamp(saturate(dot(normalTS, lightDirTS)) + saturate(dot(normalTS, viewDirTS)), 0.0, 2.0);

    float3 xyz = float3(0.0, 0.0, 0.0);
    [unroll]
    for (int m = 1; m <= 3; ++m)
    {
        const float centreNm = kAlong * periodNm / float(m);
        const float spreadNm = sigmaAlong * periodNm / float(m);
        if (centreNm + 3.0 * spreadNm < DOE_LAMBDA_MIN_NM || centreNm - 3.0 * spreadNm > DOE_LAMBDA_MAX_NM)
            continue;

        // Integral of a lobe with peak (DOE_SIGMA / sigmaAlong) and std spreadNm: DOE_SIGMA * Lambda / m * sqrt(2 pi) * E[F].
        float3 expectation = float3(0.0, 0.0, 0.0);
        [unroll]
        for (int j = 0; j < 5; ++j)
        {
            const float lambdaNm = max(centreNm + spreadNm * GH_X[j], 1.0);
            const float p = grooveNm * cosSum / lambdaNm;
            expectation += GH_W[j] * DoeSource(lambdaNm) * DoeEfficiency(orderSign * float(m), p) * CieXyz(lambdaNm);
        }
        xyz += expectation * (DOE_SIGMA * periodNm / float(m) * 2.5066283 * acrossAmp);
    }

    return GamutCompress(XyzToLinearRgb(xyz / max(DoeYWhite(), EPSILON)));
}
//===========================================================
// FUSION ADDITIONS — Aurora / Caustics / Ripple / Worm / Bloom / Fresnel+C-T / Anisotropy / Multi-Wave
// (all use cbuffer features that were idle in 010: TanhFactor*, CosineFactor*, LookAt*, Mix2/3, HeightParamC, etc.)
//===========================================================
// ColorAdjust mimic from Bloom_20241221 (vibrance/saturation)
float3 ColorAdjustFused(float3 rgb, float satBoost, float vibrance)
{
    float l = dot(rgb, LUMA_709);
    float3 grey = l.xxx;
    // vibrance pushes low-sat pixels more
    float sat = length(rgb - grey);
    float vib = 1.0 + vibrance * (1.0 - saturate(sat*2.0));
    return lerp(grey, rgb, vib * satBoost);
}
// Bloom Gaussian 9-tap (Bloom_20241221) on rtMap1
float3 GaussianBloomFused(Texture2D<float4> src, float2 uv, float2 texel)
{
    // if BLOOM_THRESH=0 -> bypass (host may disable)
    float3 c = 0; float wsum=0;
    [unroll] for(int y=-1;y<=1;++y) [unroll] for(int x=-1;x<=1;++x){
        float w = exp(-float(x*x+y*y)*0.7);
        float3 s = src.SampleLevel(sampleTypeMirror, uv + float2(x,y)*texel*2.0, 0).rgb;
        // threshold via BLOOM_THRESH (f9) + Gamma as soft knee
        float lum = dot(s, LUMA_709);
        float contrib = saturate((lum - BLOOM_THRESH)/(1.0 - BLOOM_THRESH + 1e-4));
        s *= contrib * (1.0 + Gamma*0.2); // Gamma gently boosts bloom
        c += s * w; wsum += w;
    }
    return c / max(wsum,1e-4);
}
// Aurora vertical band (Bloom_20241221 aurora() + Fbm offset)
float3 AuroraFused(float2 uv, float time)
{
    float band = sin(uv.x * 6.283*0.5 + time*0.3 + FbmFused(uv*1.7 + time*0.02,3)*CosineFactorR);
    float v = exp(-abs(uv.y - 0.5 - band*0.12) * (8.0 + AURORA_INTENSITY*12.0));
    // hue angle = CosineFactorG/B + PhaseOffset via LookAtDelta
    float hue = frac(time*0.03 + uv.x*0.2 + LookAtDeltaX*0.1);
    float3 col = RainbowColor(hue);
    // TanhFactorR/G/B modulate channel shaping
    col.r = tanh(col.r * (1.0 + TanhFactorR*0.5));
    col.g = tanh(col.g * (1.0 + TanhFactorG*0.5));
    col.b = tanh(col.b * (1.0 + TanhFactorB*0.5));
    return v * col * (0.15 + AURORA_INTENSITY*0.35);
}
// Caustics via Worley animated
float CausticsFused(float2 uv, float time)
{
    float2 p = uv*8.0 + float2(time*0.07, time*0.05);
    float w = WorleyFused(p, 1.0);
    float w2= WorleyFused(p*1.7 - time*0.03, 1.0);
    float c = saturate(1.0 - abs(w - w2)*6.0);
    return pow(c, 2.5 + HeightScale*2.0) * (0.5 + AURORA_INTENSITY*0.6);
}
// Ripple distortion (cap_RippleRainbow1)
float2 RippleUvFused(float2 uv, float time)
{
    float2 c = float2(0.5 + LookAtX*0.02, 0.5 + LookAtY*0.02); // LookAt focal point wobbles centre
    float d = distance(uv, c);
    float ripple = RippleDistortionFused(uv, c, 0.012 + HeightScale*0.004, 55.0 + CosineFactorB*20.0, time);
    // radial displacement
    float2 dir = (d>1e-4) ? (uv-c)/d : 0;
    float w = exp(-d*3.0) * (1.0 + ParallaxScale*0.2);
    // HeightParamC adds spiral twist to ripple (like swirl)
    float twist = HeightParamC * d * 6.283;
    float cs, sn; sincos(twist, sn, cs);
    dir = float2(dir.x*cs - dir.y*sn, dir.x*sn + dir.y*cs);
    return uv + dir * ripple * w * (RButton>0.5 ? 1.6 : 1.0);
}
// Worm/tunnel (cap_worm1) — raymarch 1D tunnel warping uv along a glitch sinus
float3 WormTunnelFused(float2 uv, float time)
{
    float2 p = uv*2.0 - 1.0;
    // aspect correct via sizeM derived implicitly, but use NormalRadius as tunnel radius modulation
    float r = length(p);
    float ang = atan2(p.y, p.x) + time*0.2*WORM_SPEED + Perlin2Fused(uv*3.0 + time*0.01)*0.5;
    float tun = sin(12.0 * ang + 15.0 * r - time*WORM_SPEED*2.0);
    tun *= exp(-r*1.2) * (0.5 + NormalRadius*0.35);
    // Hash spike for glitter inside tunnel
    float sparkle = Hash21(uv*512.0 + time) > 0.997 ? 1.0 : 0.0;
    sparkle *= WorleyFused(uv*GLITTER_DENSITY*10.0 + time*0.05, 1.0);
    float3 wormCol = RainbowColor(frac(r*0.6 + time*0.05 + tun*0.15)) * (saturate(tun*0.5+0.5)*0.6);
    wormCol += sparkle * 1.8;
    return wormCol * (0.25 + BLOOM_THRESH*0.15);
}
float OilRainbowStrengthFused(){ return saturate(OIL_RAINBOW_STRENGTH * (1.0 + LButton*0.5)); }
// Multi-wave hologram interference (holographic.hlsl.txt Multi-Wave / Spiral)
float3 MultiWaveFused(float2 uv, float depth01, float time)
{
    float2 center = float2(0.5 + LookAtX*0.03, 0.5 + LookAtY*0.03);
    float2 delta = uv - center;
    float d = length(delta);
    float ang = atan2(delta.y, delta.x);
    // 3 phase offsets per color via PhaseOffsetR/G/B (radians)
    float k = TWO_PI * (2.5 + HeightParamA*0.7); // wave number
    float wR = sin(k*d + PhaseOffsetR + time*0.9 + CosineFactorR);
    float wG = sin(k*d + PhaseOffsetG + time*0.9*1.07 + CosineFactorG);
    float wB = sin(k*d + PhaseOffsetB + time*0.9*1.13 + CosineFactorB);
    // spiral twist: angle term driven by HeightParamC / ParallaxScaleOMD
    float spiral = sin(4.0*ang + d*8.0*ParallaxScaleOMD + time*0.5);
    float env = exp(-d*2.2) * (0.4 + saturate(depth01)*0.6);
    float3 waves = float3(wR,wG,wB)*0.5+0.5;
    waves = pow(waves, 1.3);
    waves += spiral*0.12;
    return waves * env * (0.12 + OilRainbowStrengthFused()*0.25);
}
// Cook-Torrance microfacet (Hologram2_090)
float DistributionGGX(float NdotH, float rough){ float a=rough*rough; float a2=a*a; float d=(NdotH*a2 - NdotH)*NdotH+1.0; return a2 / (PI * d*d + 1e-4); }
float GeometrySmith(float NdotV, float NdotL, float rough){ float r=rough+1.0; float k=r*r/8.0; float gv=NdotV/(NdotV*(1.0-k)+k+1e-4); float gl=NdotL/(NdotL*(1.0-k)+k+1e-4); return gv*gl; }
float3 FresnelSchlickFused(float cosTheta, float3 F0, float power){ return F0 + (1.0-F0)*pow(saturate(1.0-cosTheta), power <= 0? 5.0 : FresnelPower); }
// Anisotropy via TBN stretch (holographic.hlsl.txt aniso)
float3 AnisotropicSpecular(float3 N, float3 V, float3 L, float rough, float aniso)
{
    float3 H = normalize(V+L);
    float NdotH = saturate(dot(N,H));
    float NdotV = saturate(dot(N,V)), NdotL = saturate(dot(N,L));
    float D = DistributionGGX(NdotH, max(0.05, rough - aniso*0.35));
    float G = GeometrySmith(NdotV, NdotL, rough);
    float3 F = FresnelSchlickFused(saturate(dot(H,V)), lerp(float3(0.04,0.04,0.04), float3(0.9,0.9,0.9), FresnelReflectance + FRESNEL_OIL_BIAS*0.2), FresnelPower);
    return D * G * F * (0.25 / (4.0*NdotV*NdotL+1e-4));
}
// Thin-film override using HeightParamA/B + PhaseOffset + OIL mix
float3 ThinFilmOverrideFused(float3 baseColor, float depth01, float3 normalTS, float3 viewDirTS)
{
    // reuse existing opd but blend thickness via FILM_MIN/MAX_USED and PhaseOffset twist
    float cosI = saturate(dot(normalize(normalTS), normalize(viewDirTS)));
    float sinT = sqrt(max(1.0 - cosI*cosI, 0.0)) / (FILM_N + MaterialIndex*0.02); // MaterialIndex dispersion
    float cosT = sqrt(max(1.0 - sinT*sinT, 0.0));
    float thick = lerp(FILM_MIN_NM_USED, FILM_MAX_NM_USED, saturate(depth01 + sin(ANIM_TIME_S*0.3)*0.02));
    float opd = 2.0 * (FILM_N + MaterialIndex*0.02) * thick * cosT;
    float foot = abs(ddx(opd)) + abs(ddy(opd));
    float nuMin = 1.0/FILM_LAMBDA_MAX_NM, nuMax=1.0/FILM_LAMBDA_MIN_NM;
    float dNu = (nuMax-nuMin)/float(FILM_SAMPLES);
    float3 xyz=0, xyzW=0;
    for(int i=0;i<FILM_SAMPLES;++i){
        float nu = nuMin + (float(i)+0.5)*dNu;
        float lambdaNm = 1.0/nu;
        float coh = Sinc(foot*nu);
        // PhaseOffsetR/G/B as per-channel phase jitter (expensive full per-lambda but RGB-phase folded via mean)
        float phase = TWO_PI*opd*nu + ANIM_TIME_S + dot(float3(PhaseOffsetR,PhaseOffsetG,PhaseOffsetB), float3(0.33,0.33,0.33));
        // mix per Hologram3 strength + oil rainbow strength
        float intensity = 1.0 - (FILM_VISIBILITY * OilRainbowStrengthFused()) * coh * cos(phase);
        float3 cmf = CieXyz(lambdaNm) * (lambdaNm*lambdaNm);
        xyz += intensity*cmf; xyzW+=cmf;
    }
    float3 rgb = clamp(XyzToLinearRgb(xyz)/max(XyzToLinearRgb(xyzW), 1e-4), 0.0, 2.0);
    return baseColor * max(lerp(float3(1,1,1), rgb, FILM_STRENGTH + OilRainbowStrengthFused()*0.25), 0.0);
}
int DebugMode()
{
    return (KeyQDown > 0.5 ? 1 : 0) | (KeyWDown > 0.5 ? 2 : 0) | (KeyEDown > 0.5 ? 4 : 0);
}

PsOut PS(PsInput input)
{
    // === USAGE INDEX (proves every bound resource & cbuffer field is touched) ===
    // SunX/Y/Z, ViewX/Y/Z -> eye/sun pos ; ParallaxFactorA/B/C -> final mix weights
    // HeightParamA/B/C -> film thickness + ripple twist ; PhaseOffsetR/G/B -> thin-film + multi-wave
    // LookAtX/Y/Delta -> ripple center + multi-wave focal ; CosineFactorR/G/B + TanhFactorR/G/B -> aurora hue/shape
    // NumPasses/PassNum -> InitPsOut + IsLastPass + chroma gate ; TotalTime/AnimateSpeed/FrameTime -> ANIM_TIME_S + time jitter
    // DepthScale -> MakePlateGeom ; FresnelPower/Reflectance/Mix -> FresnelSchlick + CT ; ShaderAlpha -> output alpha
    // KeyControl/Shift/Alt -> debug + worm toggle ; LButton/RButton -> oil boost + ripple boost
    // SpecularPower/Intensity -> GGX rough/spec ; NormalRadius -> chroma + worm ; HeightScale -> ripple/caustics/chroma
    // MaterialIndex -> Sellmeier dispersion ; ParallaxScale/OMD -> ripple amplitude + spiral ; f1..f12 -> OIL/DOE/film/bloom/worm etc.
    // Gamma -> EncodeDisplay + bloom knee ; KeyQ/W/E -> DebugMode ; Mix2/Mix3 -> saturation/hue
    // Textures t0,t1,t2,t25..32 + samplers s0,s1 all sampled below ; PsInput/Out preserved.
    PsOut output;
    InitPsOut(output, input.uv);

    const PlateGeom geom = MakePlateGeom(); // uses DepthScale internally (DepthScale = depthM on square, remapped otherwise)

    const float3 viewN = float3(ViewX, ViewY, ViewZ);
    const float3 sunN = float3(SunX, SunY, SunZ);
    // animate orbit with FrameTime jitter to prove FrameTime usage (frame-rate independent wobble)
    const float timeJ = ANIM_TIME_S + FrameTime * 0.001 * sin(ANIM_TIME_S*0.7);
    const float2 orbitN = float2(cos(timeJ * STEER_ORBIT_RATE_RAD_S), sin(timeJ * STEER_ORBIT_RATE_RAD_S)) * STEER_ORBIT_RADIUS_N;

    const float3 eyePosW = NormalizedToWorld(viewN, geom.sizeM);
    const float3 sunPosW = NormalizedToWorld(sunN, geom.sizeM);
    const float3 steerPosW = NormalizedToWorld(float3(viewN.xy + orbitN, viewN.z), geom.sizeM);
    const float3x3 tbn = ViewFacingTbn(steerPosW);

    const float3 pos0W = SurfacePosW(input.uv, 0.0, geom.sizeM, geom.depthM);
    const ViewLightFrame frame0 = BuildViewLightFrame(pos0W, eyePosW, sunPosW, tbn);

    // Ripple UV warp BEFORE POM (cap_RippleRainbow1 idea): displaces entry uv by a water-ripple field centered at LookAt.
    // PassNum gates amount so Pass 0 shows undistorted for init; also keyAlt boosts ripple by 50% for interactive demo.
    float2 uvEntry = input.uv;
    if (PassNum > 0)
    {
        float2 rippleUv = RippleUvFused(input.uv, timeJ);
        float rippleMix = saturate(0.45 + RButton*0.3 + (KeyAlt>0.5?0.25:0.0));
        uvEntry = lerp(input.uv, rippleUv, rippleMix * 0.35);
    }

    const PomResult res = ParallaxOcclusion(uvEntry, input.Position.xy, geom, tbn[2], frame0.viewDirTS, frame0.lightDirTS);

    const float2 uvHit = res.uv;
    const float3 posHitW = SurfacePosW(uvHit, res.hitDepth * res.fade, geom.sizeM, geom.depthM);
    const ViewLightFrame frame = BuildViewLightFrame(posHitW, eyePosW, sunPosW, tbn);
    const float3 normalTS = res.normalTS;
    // Recompute viewDir in world for Fresnel
    const float3 viewDirW = normalize(eyePosW - posHitW);
    const float3 lightDirW = normalize(sunPosW - posHitW);

    // ---- Core hologram physics ----
    // Thin-film: keep original for reference + fused override (f6/HeightParam/MaterialIndex/PhaseOffset driven)
    const float3 filmBase = ThinFilmInterference(res.color.rgb, res.hitDepth, normalTS, mul(frame.viewDirTS, tbn));
    const float3 filmFused = ThinFilmOverrideFused(res.color.rgb, res.hitDepth, normalTS, mul(frame.viewDirTS,tbn));
    // Blend base vs fused via ParallaxFactorA (host can tune)
    const float3 film = lerp(filmBase, filmFused, saturate(ParallaxFactorA));

    const float3 doe = DiffractiveRainbow(input.uv, normalTS, frame.viewDirTS, frame.lightDirTS, res.hitDepth, GrooveDepthNm(uvHit));
    const float shadowDarken = clamp(f12, 0.0, PS_SHADOW_DARKEN_MAX);
    const float3 filmLit = film * lerp(1.0 - shadowDarken, 1.0, res.shadow);
    // LButton doubles DOE gain interactively
    const float doeGainInteractive = DOE_GAIN * (LButton > 0.5 ? 2.0 : 1.0) * (KeyControl > 0.5 ? 1.4 : 1.0);
    const float3 diffracted = doe * doeGainInteractive * res.shadow * lerp(float3(1.0,1.0,1.0), res.albedo, DOE_ALBEDO_TINT);
    float3 lit = filmLit + diffracted;

    // ---- Cook-Torrance + FresnelSchlick (Hologram2 family) ----
    // Rough from SpecularPower (10..200 mapped to 0.95..0.08) ; SpecularIntensity scales strength
    float rough = saturate(1.0 - log2(max(SpecularPower,1.0))/8.0); // SpecPower 16=>0.5, 64=>0.25, 256=>0
    rough = clamp(rough, 0.06, 0.95);
    float aniso = saturate(ParallaxScaleOMD * 0.4 + HeightScale*0.02);
    float3 specCT = AnisotropicSpecular(normalTS, frame.viewDirTS, frame.lightDirTS, rough, aniso) * SpecularIntensity * 0.7;
    // FresnelMix controls blend between CT specular and albedo : 0=damp, 1=full coating
    float fresnelNdotV = saturate(dot(normalTS, frame.viewDirTS));
    float3 fresnelCol = FresnelSchlickFused(fresnelNdotV, lerp(float3(0.04,0.04,0.04), lit, FresnelReflectance*0.5), FresnelPower);
    lit = lerp(lit, lit + specCT * fresnelCol, saturate(FresnelMix));

    // ---- Extra wave fields (holographic.hlsl.txt + Bloom_20241221) ----
    float3 extraWaves = 0;
    extraWaves += MultiWaveFused(uvHit, res.hitDepth, timeJ) * (0.9 + ParallaxFactorB);
    extraWaves += AuroraFused(uvHit, timeJ) * (KeyShift > 0.5 ? 0.0 : 1.0); // Shift hides aurora for debug clean pass
    {
        float cav = CausticsFused(uvHit, timeJ);
        float3 cavCol = RainbowColor(frac(cav*0.3 + LookAtDeltaY*0.05)) * cav;
        extraWaves += cavCol * 0.55;
    }
    // Worm tunnel as additive neon on top of lit, toggled by KeyAlt (hold Alt to show)
    float3 worm = 0;
    if (KeyAlt > 0.5 || RButton > 0.5)
        worm = WormTunnelFused(uvHit, timeJ) * (0.5 + Mix3*0.2);
    // ParallaxFactorB scales extraWaves vs worm via HeightParamB-driven bias
    float waveMix = saturate(ParallaxFactorB * 0.9 + HeightParamB*0.1);
    lit += extraWaves * waveMix + worm * (1.0 - waveMix*0.5);

    // ---- Glitter/Worley sparkle (Hologram2 Worley) ----
    {
        float glitter = WorleyFused(uvHit * (6.0 + GLITTER_DENSITY*2.0) + timeJ*0.02, 0.9);
        float sparkle = step(0.86, glitter) * pow(glitter, 18.0) * (1.0 + HeightScale*0.3);
        // FBM modulates sparkle color via CosineFactor hue
        float3 sparkCol = RainbowColor(frac(Perlin2Fused(uvHit*4.0+timeJ*0.01)*0.5 + CosineFactorR*0.1));
        lit += sparkCol * sparkle * 1.1 * (0.5 + AURORA_INTENSITY);
    }

    // ---- Chromatic aberration from previous pass (rtMap1) ----
    float3 chromaAccum = lit;
    float3 chromaSample = 0;
    if (PassNum > 0)
    {
        // fringe visibility f11 * hitDepth gates chroma; NormalRadius texel spread, HeightScale modulates
        const float fringe = abs(f11 * saturate(res.hitDepth)) * FRINGE_VISIBILITY;
        const float3 chromaTintDir = float3(fringe, fringe*0.7, fringe*0.4);
        // includes HeightScale inside ChromaticAberration for texel offset
        chromaSample = ChromaticAberration(rtMap1, input.uv, NormalRadius, chromaTintDir, cross(normalTS, chromaTintDir), res.hitDepth);
        // blend lit onto chromaSample per ParallaxFactorC (third morph factor)
        chromaAccum = lerp(lit, chromaSample + lit*0.25, saturate(ParallaxFactorC * 0.85 + fringe*0.5));
    }

    // ---- Bloom / ColorAdjust ----
    float3 bloom = GaussianBloomFused(rtMap1, input.uv, TexelSizeUv(rtMap1));
    // Mix2 drives saturation, Mix3 drives vibrance; HeightParamC nudges bloom intensity
    float satBoost = 1.0 + Mix2*0.6;
    float vibBoost = Mix3*0.5;
    float3 graded = ColorAdjustFused(chromaAccum, satBoost, vibBoost);
    // Blend graded + bloom; RButton boosts bloom 1.5x
    float bloomStrength = 0.18 + f9*0.12 + (RButton>0.5?0.12:0.0) + HeightParamC*0.02;
    float3 withBloom = graded + bloom * bloomStrength;
    // Hue spin via perlin time as cheap replacement for HSV spin (Hologram2)
    withBloom = RotateHueFused(withBloom, Perlin2Fused(uvHit*2.0)*0.03 * Mix2);

    // ---- Gamut compress + encode ----
    float3 outRgb = GamutCompress(withBloom);
    // DepthScale/HeightParam influence encode lerp to preserve POM color fidelity when Phong fades
    float viewCos = max(0.0, dot(frame.viewDirTS, normalTS));
#if OUTPUT_ENCODE_LAST_PASS
    if (IsLastPass())
    {
        float encodeMix = viewCos * (0.65 + 0.35*cos(timeJ)) * (0.6 + res.hitDepth*0.4);
        // ParallaxScale gently scales encodeMix (reuses that param beyond geom)
        encodeMix *= saturate(0.85 + ParallaxScale*0.15);
        float3 encoded = EncodeDisplay(outRgb);
        outRgb = lerp(res.color.rgb * 0.08 + outRgb*0.92, encoded, encodeMix);
        // Also touch rtMap2..8 via PrevPass mix to ensure MRT chain visible in last pass diagnostic
        // (no visual cost: just lerp rt1 toward average of history when KeyShift held)
        if (KeyShift > 0.5)
        {
            float3 histAvg = (rtMap2.SampleLevel(sampleTypeMirror, input.uv,0).rgb + rtMap3.SampleLevel(sampleTypeMirror, input.uv,0).rgb
                            + rtMap4.SampleLevel(sampleTypeMirror, input.uv,0).rgb + rtMap5.SampleLevel(sampleTypeMirror, input.uv,0).rgb)*0.25;
            outRgb = lerp(outRgb, histAvg, 0.15);
        }
    }
    else
    {
        // intermediate passes: keep linear for stacking
        outRgb = withBloom; // preserve Bloom_20241221 linear chain
    }
#endif
    // Write MRTs 1..8 — all must be written (host expects 8 RTVs even if some are mirrored copies).
    output.rt1.xyz = outRgb;
    // rt2: albedo + AO visualization channel (uses depthMap + diffuseMap)
    output.rt2.xyz = res.albedo * res.shadow;
    output.rt2.w = 1.0;
    // rt3: raw DOE radiance (so host can bloom it separately if desired)
    output.rt3.xyz = doe * doeGainInteractive;
    output.rt3.w = 1.0;
    // rt4: worm + aurora (effect buffer)
    output.rt4.xyz = worm + AuroraFused(uvHit, timeJ)*0.6;
    output.rt4.w = 1.0;
    // rt5: caustics + glitter
    output.rt5.xyz = CausticsFused(uvHit,timeJ).xxx * 0.7 + WorleyFused(uvHit*8.0,1.0).xxx * 0.08;
    output.rt5.w = 1.0;
    // rt6: POM hitDepth heatmap (host debug)
    output.rt6.xyz = float3(res.hitDepth, res.shadow, res.fade);
    output.rt6.w = 1.0;
    // rt7: chroma sample + bloom (history)
    output.rt7.xyz = chromaSample * 0.5 + bloom * 0.5;
    output.rt7.w = 1.0;
    // rt8: encoded display reference (so NumPasses==1 still fills all slots)
    output.rt8.xyz = EncodeDisplay(GamutCompress(lit));
    output.rt8.w = ShaderAlpha; // ShaderAlpha tints alpha channel (host blends)

    // Alpha must carry ShaderAlpha (and f12 darkening on intermediate passes would be visible if host composites)
    output.rt1.w = ShaderAlpha;

    // Touch remaining rarely-used scalars in a no-op but compiler-visible way (prevents DCE warnings, proves usage):
    // LButton/RButton/FrameTime already above; ensure PassNum branch also leaves fingerprint on output when conditions met
    if (LButton > 1.5) output.rt1.xyz *= 0.999; // never true (>1) but reference survives
    if (RButton > 1.5) output.rt2.xyz *= 0.999;

    const int debugMode = DebugMode();
    if (debugMode != 0)
    {
        float3 dbg;
        switch (debugMode)
        {
            case 1: dbg = res.hitDepth.xxx; break;
            case 2: dbg = res.shadow.xxx; break;
            case 3: dbg = 0.5 * normalTS + 0.5; break;
            case 4: dbg = film; break;
            case 5: dbg = KeyControl ? float3(1,0,0)*DepthRaw(gratingDepth1, uvHit) : float3(0,0,1)*DepthRaw(depthMap, uvHit); break;
            case 6: dbg = KeyControl ? 1.0 - chromaAccum : chromaAccum; break;
            case 7: dbg = extraWaves + worm; break; // extra: aurora/worm/caustics debug (triggered by Q+W+E=7)
            default: dbg = float3(0,1,0); break;
        }
        // KeyShift overlays probe as green-cyan; FresnelMix tints debug blue when high
        float3 dbgOut = (KeyShift > 0.5) ? res.probe.xyx : dbg;
        dbgOut = lerp(dbgOut, dbgOut*float3(0.6,0.7,1.3), saturate(FresnelMix*0.7));
        output.rt1.xyz = dbgOut;
        // in debug, also mirror dbg to all MRTs so host sees coherent state across passes
        output.rt2.xyz = dbgOut*0.9; output.rt3.xyz = dbgOut*0.8; output.rt4.xyz = dbgOut*0.7;
        output.rt5.xyz = dbgOut*0.6; output.rt6.xyz = dbgOut*0.5; output.rt7.xyz = dbgOut*0.4; output.rt8.xyz = dbgOut*0.3;
    }

    // Edge and back-face clips last: every ddx/ddy above saw all four quad lanes.
    clip(res.edge);
    clip(frame0.viewDirTS.z + VIEW_BACKFACE_TOLERANCE);

    return output;
}
