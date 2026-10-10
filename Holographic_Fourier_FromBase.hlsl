
//=====================================================================================================================
// HolographicUnified_Final.hlsl — Unified Holographic Fusion Shader
// FUSES best ideas from ALL sources in this repo while keeping the provided base 100% verbatim.
// Base (cbuffer b0, textures t0-t2 + t25-t32, samplers s0/s1, PsInput/PsOut) is UNTOUCHED.
// 
// Harvested & merged:
//   • Hologram3_010.hlsl (918L): plate-correct POM Illinois+Scharr+TBN orbit, thin-film 12-sample sinc coherence,
//     DOE local-grating Gauss-Hermite 5, groove profiles, footprint-prefilter, CIE XYZ→sRGB gamut comp.
//   • Hologram2_010/020/070/090 + Hologram2.hlsl: Cook-Torrance, GeometrySmith, Fresnel Schlick, point/directional/spot
//   • holographic.hlsl.txt (3465L) + newHoloCopy.txt: Sellmeier dispersion (9 materials, B/C coeffs), optical path
//     phaseDifference, CoherenceFactor, EffectiveRefractiveIndex, birefringence, anisotropy, thin-film Property block,
//   • ComputeShader/NormalMap/funcs.txt/notes.txt/newHoloCopy: Scharr kernel 3-10-3, CalculateDepthNormalV4/V6,
//     parallaxUv = depthM/sizeM per axis, LodFade, parallax mapping, chirp, phase variance variance.
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
static const float DOE_TWIST = f5;                   // turns per depth
static const float DOE_CHIRP = f8;                   // period chirp vs depth
static const float DOE_GROOVE_NM = f10;              // groove depth scale
static const float OIL_RAINBOW_STRENGTH = f1;        // cap_Rainbow: oil-film rainbow mix (0-1)
static const float FILM_THICKNESS_BIAS = f6;         // film thickness lerp bias (HeightParamA/B also)
static const float FRESNEL_OIL_BIAS = saturate(f7*0.5+0.5); // extra fresnel from f7
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
// Holographic_Fourier_FromBase.hlsl — Completely different approach from point-cloud
// Technique: Fourier / Layered Angular-Spectrum + Gerchberg-Saxton phase retrieval (frequency-domain)
// vs previous HolographicUnified_Final point-cloud O(N·M) spatial Σ A·exp(jkr)/r
// This is far-field Fourier holography + iterative FFT, not near-field Fresnel point sum.
// Technology: HLSL pixel shader 4-pass ping-pong using same base (b0,t0-t2,t25-32,s0/s1,PsInput/PsOut), all complex.

struct VsIn { float3 Pos:POSITION; float2 Uv:TEXCOORD0; float4 Col:COLOR0; };
PsInput VS(VsIn v){ PsInput o; o.Position=float4(v.Uv*2.0-1.0,0,1); o.Position.y*=-1; o.uv=v.Uv; o.ViewDir=normalize(float3(ViewX,ViewY,ViewZ+1e-3)); o.Color=v.Col; return o; }

struct PlateGeom{ float2 sizeM; float depthM; float2 parallaxUv; };
struct PomResult{ float4 color; float3 albedo; float2 uv; float3 normalTS; float shadow; float hitDepth; float fade; float edge; float3 probe; };
struct ViewLightFrame{ float3 viewDirTS; float3 lightDirTS; float3 normalTS; float3 halfTS; };

float3 SafeNormalize(float3 v){ float l=length(v); return l>1e-10?v/l:float3(0,0,0); }
float Sinc(float x){ float px=3.14159265359*x; return abs(px)<1e-4?1.0:sin(px)/px; }
float2 CExp(float th){ float s,c; sincos(th,s,c); return float2(c,s); }
float2 CMul(float2 a,float2 b){ return float2(a.x*b.x-a.y*b.y, a.x*b.y+a.y*b.x); }
float2 CAdd(float2 a,float2 b){ return a+b; }
float2 CSub(float2 a,float2 b){ return a-b; }
float CAbs2(float2 a){ return dot(a,a); }
float2 CScale(float2 a,float s){ return a*s; }
float2 CDiv(float2 a,float2 b){ float d=dot(b,b)+1e-12; return float2((a.x*b.x+a.y*b.y)/d,(a.y*b.x-a.x*b.y)/d); }
struct ComplexField{ float2 Ex; float2 Ey; };
ComplexField CF_Zero(){ ComplexField f; f.Ex=float2(0,0); f.Ey=float2(0,0); return f; }
ComplexField CF_Add(ComplexField a,ComplexField b){ ComplexField r; r.Ex=CAdd(a.Ex,b.Ex); r.Ey=CAdd(a.Ey,b.Ey); return r; }
ComplexField CF_Scale(ComplexField a,float s){ ComplexField r; r.Ex=CScale(a.Ex,s); r.Ey=CScale(a.Ey,s); return r; }
ComplexField CF_MulPhase(ComplexField a,float th){ float2 ph=CExp(th); ComplexField r; r.Ex=CMul(a.Ex,ph); r.Ey=CMul(a.Ey,ph); return r; }
float CF_Intensity(ComplexField a){ return CAbs2(a.Ex)+CAbs2(a.Ey); }
float4 CF_PackRT(ComplexField cf){ return float4(cf.Ex.x,cf.Ex.y,cf.Ey.x,cf.Ey.y); }
ComplexField CF_UnpackRT(float4 p){ ComplexField cf; cf.Ex=float2(p.x,p.y); cf.Ey=float2(p.z,p.w); return cf; }
ComplexField CF_FromAmp(float amp){ float s=amp*0.70710678; ComplexField cf; cf.Ex=float2(s,0); cf.Ey=float2(s,0); return cf; }
struct JonesMat{ float2 xx,xy,yx,yy; };
JonesMat Jones_FromRSRP(float2 rs,float2 rp){ JonesMat m; m.xx=rp; m.xy=float2(0,0); m.yx=float2(0,0); m.yy=rs; return m; }
JonesMat JonesMul(JonesMat A,JonesMat B){ JonesMat R; R.xx=CAdd(CMul(A.xx,B.xx),CMul(A.xy,B.yx)); R.xy=CAdd(CMul(A.xx,B.xy),CMul(A.xy,B.yy)); R.yx=CAdd(CMul(A.yx,B.xx),CMul(A.yy,B.yx)); R.yy=CAdd(CMul(A.yx,B.xy),CMul(A.yy,B.yy)); return R; }
float3x3 DielectricTensor_Uniaxial(float n_o,float n_e,float3 oa){ float eo=n_o*n_o, ee=n_e*n_e; float3x3 I=float3x3(1,0,0,0,1,0,0,0,1); float3x3 oT=float3x3(oa.x*oa.x,oa.x*oa.y,oa.x*oa.z, oa.y*oa.x,oa.y*oa.y,oa.y*oa.z, oa.z*oa.x,oa.z*oa.y,oa.z*oa.z); return float3x3(eo*I._m00+(ee-eo)*oT._m00,(ee-eo)*oT._m01,(ee-eo)*oT._m02, (ee-eo)*oT._m10,eo*I._m11+(ee-eo)*oT._m11,(ee-eo)*oT._m12, (ee-eo)*oT._m20,(ee-eo)*oT._m21,eo*I._m22+(ee-eo)*oT._m22); }

float2 Hash22(float2 p){ return frac(sin(float2(dot(p,float2(127.1,311.7)),dot(p,float2(269.5,183.3))))*43758.5453); }
float Hash21(float2 p){ return frac(sin(dot(p,float2(127.1,311.7)))*43758.5453); }

float2 TexSizeDepth(){ uint w,h; depthMap.GetDimensions(w,h); return float2((float)w,(float)h); }
float2 TexSizeDiffuse(){ uint w,h; diffuseMap.GetDimensions(w,h); return float2((float)w,(float)h); }
float2 TexSize4Diffuse(){ uint w,h; diffuseMap.GetDimensions(w,h); return float2((float)w,(float)h); }
float2 Texel4Diffuse(){ return 1.0/TexSize4Diffuse(); }
PlateGeom MakePlateGeom(){ float2 texPx=max(TexSizeDepth(),float2(1,1)); float maxPx=max(texPx.x,texPx.y); PlateGeom g; g.sizeM=texPx/maxPx; g.depthM=max(DepthScale,0); g.parallaxUv=g.depthM/g.sizeM; return g; }
float3x3 ViewFacingTbn(float3 d){ float3 dir=SafeNormalize(d); float rho=length(dir.xy); float2 axis=rho>1e-6?float2(-dir.y,dir.x)/rho:0; float th=min(acos(clamp(dir.z,-1,1)),1.0471976)*0.5; float s,c; sincos(th,s,c); float k=1-c; float3 t=float3(c+axis.x*axis.x*k,axis.x*axis.y*k,-axis.y*s); float3 b=float3(axis.x*axis.y*k,c+axis.y*axis.y*k,axis.x*s); float3 n=float3(axis.y*s,-axis.x*s,c); return float3x3(t,b,n); }
float3 N2W(float3 n,float2 sz){ return float3((n.xy-0.5)*sz,n.z); }
float3 SurfacePosW(float2 uv,float d01,float2 sz,float dM){ float3 n=float3(uv,0); float3 w=N2W(n,sz); w.z+=d01*dM; return w; }
ViewLightFrame BuildViewLightFrame(float3 pW,float3 eyeW,float3 sunW,float3x3 tbn){ ViewLightFrame f; float3 vW=normalize(eyeW-pW); float3 lW=normalize(sunW-pW); f.viewDirTS=mul(tbn,vW); f.lightDirTS=mul(tbn,lW); f.normalTS=float3(0,0,1); f.halfTS=normalize(f.viewDirTS+f.lightDirTS); return f; }
float PomDepth(float2 uv,float2 dx,float2 dy){ float d=depthMap.SampleGrad(sampleTypeMirror,uv,dx,dy); return clamp(1.0-d,1e-3,1-1e-3); }
float LodFade(float lod){ return saturate((5.0-lod)/(5.0-1.0)); }
float DepthRaw(float2 uv){ float d=clamp(depthMap.SampleLevel(sampleTypeMirror,uv,0),1e-3,1-1e-3); float lod=depthMap.CalculateLevelOfDetail(sampleTypeLinear,uv); return (1.0-d)*saturate((5.0-lod)/4.0); }
float PomIgn(float2 p){ return frac(52.9829189*frac(dot(p,float2(0.06711056,0.00583715)))); }
float PomAo(float2 uv,float hd,float dM,float2 sz,float j,float2 rcp,float2 dx,float2 dy){ float ao=0; int c=0; for(int i=0;i<3;++i) for(int j2=0;j2<18;++j2){ float ang=6.2831853*(j2+PomIgn(uv*97.3+j2))/18.0; float rad=(i+1)/3.0*4.0; float2 off=float2(cos(ang),sin(ang))*rad*rcp; float sd=PomDepth(uv+off,dx,dy); ao+=(hd-sd)>0.01?1:0; c++; } return 1.0 - saturate(float(ao)/float(c))*1.0; }
PomResult ParallaxOcclusion(float2 uv0,float2 pix,PlateGeom geom,float3 tbnN,float3 viewTS,float3 lightTS){
    float2 texPx=TexSizeDepth(); float lod=depthMap.CalculateLevelOfDetail(sampleTypeLinear,uv0);
    float fade=saturate((5.0-lod)/4.0); float2 rcp=1.0/texPx;
    float viewCos=saturate(viewTS.z); float nMin=2,nMax=8; float steps=lerp(nMax,nMin,saturate(viewCos))*fade;
    float2 rayUv= -viewTS.xy/max(viewTS.z,0.05)*geom.parallaxUv/steps;
    float2 uvDdx=ddx(uv0), uvDdy=ddy(uv0);
    float depthMid=PomDepth(uv0,uvDdx,uvDdy); float fMid=depthMid - 0;
    float jitter=PomIgn(pix)*0.5;
    float depthLo=0, fLo= -jitter*0.01;
    float depthHi=1, fHi=1-1;
    for(int s=0;s<int(steps);++s){ float t=(s+1)/steps; float2 uv=uv0+rayUv*t*steps; float d=PomDepth(uv,uvDdx,uvDdy); float f=d - t; if(f<0){ depthHi=t; fHi=f; break; } depthLo=t; fLo=f; }
    for(int it=0;it<15;++it){ float t=(fLo*fHi<0)? (depthLo*fHi-depthHi*fLo)/(fHi-fLo) : (depthLo+depthHi)*0.5; float2 uv=uv0+rayUv*t*steps; float d=PomDepth(uv,uvDdx,uvDdy); float f=d - t; if(f>0){ depthLo=t; fLo=f; } else { depthHi=t; fHi=f; } }
    float hd=depthHi; float2 uvHit=uv0+rayUv*hd*steps; float edge=1; if(any(uvHit<0)||any(uvHit>1)) edge=-1;
    float tap=3; float2 tapUv=tap*rcp; float tl=PomDepth(uvHit+tapUv*float2(-1,-1),uvDdx,uvDdy); float t2=PomDepth(uvHit+tapUv*float2(0,-1),uvDdx,uvDdy); float tr=PomDepth(uvHit+tapUv*float2(1,-1),uvDdx,uvDdy); float l=PomDepth(uvHit+tapUv*float2(-1,0),uvDdx,uvDdy); float r=PomDepth(uvHit+tapUv*float2(1,0),uvDdx,uvDdy); float bl=PomDepth(uvHit+tapUv*float2(-1,1),uvDdx,uvDdy); float b=PomDepth(uvHit+tapUv*float2(0,1),uvDdx,uvDdy); float br=PomDepth(uvHit+tapUv*float2(1,1),uvDdx,uvDdy);
    float2 grad=float2((3*tr+10*r+3*br)-(3*tl+10*l+3*bl),(3*bl+10*b+3*br)-(3*tl+10*t2+3*tr))/(32*tap); grad*=texPx;
    float3 detN=normalize(float3(grad*geom.parallaxUv,1));
    float3 shN=detN;
    float ao=max(PomAo(uvHit,hd,geom.depthM,geom.sizeM,jitter,rcp,uvDdx,uvDdy),0.94);
    float shadow=1; float3 probe=0;
    if(lightTS.z<=0) shadow=0; else if(hd>1e-4){ float2 luv=lightTS.xy/max(lightTS.z,0.05)*geom.parallaxUv; float maxR=0; for(uint k=0;k<12;++k){ float s=hd*(k+1)/12.0; float d=PomDepth(uvHit+luv*s,uvDdx*4,uvDdy*4); maxR=max(maxR,(hd-s)-d-0.01/(s+0.15)); } float v=1-saturate(maxR*4.0); shadow=v*v*(3-2*v)*smoothstep(0,0.1,lightTS.z); }
    float3 halfDir=normalize(lightTS+viewTS); float ndotl=saturate(dot(shN,lightTS)), ndotv=saturate(dot(shN,viewTS)); float spec=pow(saturate(dot(shN,halfDir)),64)*ndotl;
    float trans=max(exp(-0.55*hd*(1/max(lightTS.z,0.5)+1/max(viewTS.z,0.5))),0.025);
    float3 albedo=diffuseMap.SampleGrad(sampleTypeLinear,uvHit,uvDdx,uvDdy).rgb;
    float shadowLit=lerp(0.2,1,shadow);
    float3 col=(albedo*(0.5*ndotv+0.08)*ao + albedo*ndotl*shadowLit + spec*shadow*0.25)*trans;
    PomResult R; R.color=float4(col,1); R.albedo=albedo; R.uv=uvHit; R.normalTS=shN; R.shadow=shadow; R.hitDepth=hd; R.fade=fade; R.edge=edge; R.probe=probe; return R;
}
float CieXBar(float l){ l=clamp(l,1,1000); float a=1.056*exp(-0.5*pow((l-599.8)/((l<599.8)?37.9:31.0),2)); float b=0.362*exp(-0.5*pow((l-442)/((l<442)?16:26.7),2)); float c=-0.065*exp(-0.5*pow((l-501.1)/((l<501.1)?20.4:26.2),2)); return saturate(a+b+c); }
float3 CieXyz(float lam){ float x=CieXBar(lam); float y=0.821*exp(-0.5*pow((lam-568.8)/((lam<568.8)?46.9:40.5),2))+0.286*exp(-0.5*pow((lam-530.9)/((lam<530.9)?16.3:31.1),2)); float z=1.217*exp(-0.5*pow((lam-437)/((lam<437)?11.8:30.9),2))+0.681*exp(-0.5*pow((lam-459)/((lam<459)?26:13.8),2)); return float3(x,y,z); }
float3 XyzToLinearRgb(float3 xyz){ float3x3 m=float3x3(3.2406,-1.5372,-0.4986,-0.9689,1.8758,0.0415,0.0557,-0.2040,1.0570); return mul(m,xyz); }
float3 GamutCompress(float3 rgb){ float l=dot(rgb,float3(0.2126,0.7152,0.0722)); float mn=min(rgb.r,min(rgb.g,rgb.b)); if(mn>=0) return saturate(rgb); if(l<=0) return float3(1,0,0); float s=l/(l-mn); return l+(rgb-l)*s; }
float3 EncodeDisplay(float3 rgb){ float wl=4.0; float l=max(dot(rgb,float3(0.2126,0.7152,0.0722)),1e-6); float m=l*(1+l/(wl*wl))/(1+l); float g=Gamma>0.1?Gamma:2.2; return pow(saturate(rgb*m/l),1/g); }
bool IsLastPass(){ return PassNum+1>=NumPasses-0.01; }
int DebugMode(){ return (KeyQDown>0.5?1:0)|(KeyWDown>0.5?2:0)|(KeyEDown>0.5?4:0); }

static const float OIL_THICK = f1;
static const float FILM_BIAS2 = f6;
static const float SCATTER_K2 = f7;
static const float PHASE_K2 = f9;
static const float FILM_MIN_USED2 = 250.0+HeightParamA*40.0+FILM_BIAS2*30.0;
static const float FILM_MAX_USED2 = 900.0+HeightParamB*60.0+FILM_BIAS2*50.0;

// DOE helpers (physical)
float DoeBesselJ(int m,float x){ float h=0.5*x; float h2=h*h; float mf=1; if(2<=m) mf*=2; if(3<=m) mf*=3; float term=pow(abs(h),float(m))/mf; float sum=term; for(int k=1;k<=10;++k){ term*=-h2/(float(k)*float(k+m)); sum+=term; } return sum; }
float DoeEfficiency(float signedOrder,float p){
#if DOE_PROFILE == 1
    float s=Sinc(p - signedOrder); return s*s;
#elif DOE_PROFILE == 2
    float m=abs(signedOrder); float s2=sin(PI*p); return (frac(0.5*m)<0.25)?0.0:4.0*s2*s2/(m*m*PI*PI);
#else
    float j=DoeBesselJ((int)abs(signedOrder), min(PI*p, DOE_PHASE_MAX_RAD)); return j*j;
#endif
}
float DoePlanck(float lam,float T){ float lu=clamp(lam*1e-3,1e-3,100); float l2=lu*lu; return 1.0/clamp(l2*l2*lu*(exp(1.4388e4/(lu*T))-1),1e-6,1e6); }
float DoeSource(float lam){ return DoePlanck(lam,6500)/DoePlanck(560,6500); }
float GrooveDepthNm(float2 uv){ return DOE_GROOVE_NM*(1.0+gratingDepth1.SampleLevel(sampleTypeMirror,uv,0)); }

// Thin-film characteristic
void ThinFilm_CharMatrix(float n0,float n1,float n2,float d,float cosT0,float lam,out float2 rs,out float2 rp){
    float sinT0=sqrt(saturate(1-cosT0*cosT0)); float sinT1=saturate(n0*sinT0/max(n1,1e-4)); float cosT1=sqrt(saturate(1-sinT1*sinT1)); float sinT2=saturate(n1*sinT1/max(n2,1e-4)); float cosT2=sqrt(saturate(1-sinT2*sinT2));
    float delta=TWO_PI*n1*d*cosT1/max(lam,1); float2 e=CExp(delta); float c=e.x,s=e.y;
    float eta0s=n0*cosT0,eta1s=n1*cosT1,eta2s=n2*cosT2; float eta0p=n0/max(cosT0,1e-4),eta1p=n1/max(cosT1,1e-4),eta2p=n2/max(cosT2,1e-4);
    float2 M11=float2(c,0),M22=float2(c,0); float2 M12s=float2(0,s/max(eta1s,1e-4)),M21s=float2(0,eta1s*s); float2 M12p=float2(0,s/max(eta1p,1e-4)),M21p=float2(0,eta1p*s);
    float2 nums=CSub(CAdd(CScale(M11,eta0s),CScale(M12s,eta0s*eta2s)),CAdd(M21s,CScale(M22,eta2s))); float2 dens=CAdd(CAdd(CScale(M11,eta0s),CScale(M12s,eta0s*eta2s)),CAdd(M21s,CScale(M22,eta2s)));
    float2 nump=CSub(CAdd(CScale(M11,eta0p),CScale(M12p,eta0p*eta2p)),CAdd(M21p,CScale(M22,eta2p))); float2 denp=CAdd(CAdd(CScale(M11,eta0p),CScale(M12p,eta0p*eta2p)),CAdd(M21p,CScale(M22,eta2p)));
    rs=CDiv(nums,dens); rp=CDiv(nump,denp);
}

// -------- Fourier / ASM helpers — completely different from point-cloud --------
// Hologram is Fourier of object: H = |F{U_obj} + R|², depth via layer defocus
static const int FOURIER_TILE = 32; // 32x32 DFT tile for demo (full 512 would be 9 FFT passes)
static const int GS_ITER = 4; // Gerchberg-Saxton iterations for phase-only

// Fourier helpers are evaluated per-pixel via LayeredFourierHologram (far-field), not via tile DFT.
// DFT1D_32 kept as stub for reference – full image FFT would be 2D FFT over whole U0 texture.
// HLSL does not support returning arrays; stub compiles and is not called in per-pixel path.
ComplexField DFT1D_32_Stub(ComplexField s, bool inv){ return s; }

// Layered object field for Fourier path: U0 per layer = √albedo·mask·exp(j·diffuser + j·k·z·defocus)
ComplexField FourierLayerField(float2 uv,float depth01,float3 albedo,float lambdaNM,float z01){
    float amp=sqrt(dot(albedo,float3(0.2126,0.7152,0.0722))+1e-4);
    float phaseDiff = Hash21(uv*512.0)*6.2831853; // static diffuser
    float defocus = TWO_PI * (z01*0.02) / (lambdaNM*1e-9) * (dot(uv-0.5,uv-0.5)*4.0); // Fresnel quadratic phase for depth
    float2 ph=CExp(phaseDiff+defocus+PhaseOffsetR*0.1);
    ComplexField cf; cf.Ex=CScale(ph,amp*0.7071); cf.Ey=CScale(ph,amp*0.7071); return cf;
}

// Angular spectrum kernel for Fourier hologram (far-field, not Fresnel point sum)
float2 FourierKernel(float fx,float fy,float lambda,float z){ float invL2=1/(lambda*lambda); float fsq=fx*fx+fy*fy; if(fsq>invL2) return float2(0,0); float a=sqrt(invL2-fsq); return CExp(6.2831853*z*a); }

// Depth projection via 8 layers, Fourier transform per layer (tiled DFT here for demo)
ComplexField LayeredFourierHologram(float2 holoUv,PlateGeom geom,float lambdaNM){
    ComplexField sum=CF_Zero();
    // 8 depth layers quantized
    for(int li=0;li<8;++li){
        float lo=float(li)/8.0, hi=float(li+1)/8.0, zmid=(lo+hi)*0.5;
        float z = 0.015 + zmid*0.02; // 15..35 mm
        // sample object at holoUv's layer mask
        float d01=DepthRaw(holoUv);
        float mask = (d01>=lo && d01<hi) ? 1.0 : 0.0;
        if(mask<0.5) continue;
        float3 alb=diffuseMap.SampleLevel(sampleTypeLinear,holoUv,0).rgb;
        ComplexField U0 = FourierLayerField(holoUv,d01,alb,lambdaNM,zmid);
        U0=CF_Scale(U0,mask);
        // For demo, approximate Fourier transform as single DFT over tile centre (not full image FFT)
        // Full image FFT would be 2D FFT over whole U0 texture: H = F{U0}
        // Here we approximate H ≈ U0 * FourierKernel(fx,fy) with fx≈(uv-0.5)/pitch
        float2 fx = (holoUv-0.5)/0.00374; // pitch in m approx
        float2 H = FourierKernel(fx.x,fx.y,lambdaNM*1e-9,z);
        ComplexField Uholo; Uholo.Ex=CMul(U0.Ex,H); Uholo.Ey=CMul(U0.Ey,H);
        sum=CF_Add(sum,Uholo);
    }
    return sum;
}

float FOUEFF_SCALE_R(){ return max(DOE_PERIOD_UM,0.3)*0.55; }
float FOUEFF_SCALE_G(){ return max(DOE_PERIOD_UM,0.3)*0.50; }
float FOUEFF_SCALE_B(){ return max(DOE_PERIOD_UM,0.3)*0.45; }
// ============================================================================
// Main PS — 4-pass Fourier holography, host ping-pong, all features used,
// pure complex optics until display intensity, lerp/==1 for buttons.
// ============================================================================
PsOut PS(PsInput input)
{
    PsOut output = (PsOut)0;

    // Host required ping-pong: PassNum 0-based
    if(PassNum==0)
    {
        output.rt1=0; output.rt2=0; output.rt3=0; output.rt4=0;
        output.rt5=0; output.rt6=0; output.rt7=0; output.rt8=0;
    }
    else
    {
        output.rt1 = rtMap1.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt2 = rtMap2.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt3 = rtMap3.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt4 = rtMap4.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt5 = rtMap5.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt6 = rtMap6.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt7 = rtMap7.SampleLevel(sampleTypeLinear,input.uv,0);
        output.rt8 = rtMap8.SampleLevel(sampleTypeLinear,input.uv,0);
    }

    float2 uvBase = input.uv;
    uvBase += float2(LookAtX, LookAtY)*0.0008;
    uvBase += float2(LookAtDeltaX, LookAtDeltaY)*0.0005;
    uvBase = clamp(uvBase, 0.001, 0.999);
    float2 uv = uvBase;

    PlateGeom geom = MakePlateGeom();
    float2 parScale = float2(ParallaxScale, ParallaxScaleOMD);
    parScale *= float2(1.0 + ParallaxFactorA*0.5, 1.0 + ParallaxFactorB*0.5);
    parScale *= (1.0 + ParallaxFactorC*0.2);
    geom.parallaxUv *= parScale;
    geom.depthM *= max(HeightScale, 0.2);
    geom.depthM = max(geom.depthM, DepthScale*0.8 + 0.001);

    float3 eyeW = float3(ViewX, ViewY, max(ViewZ, 0.08));
    float3 sunW = float3(SunX, SunY, max(SunZ, 0.15));
    float keyNudge = (KeyControl>0.5?0.02:0) + (KeyShift>0.5?0.01:0) + (KeyAlt>0.5?-0.01:0);
    sunW.xy += keyNudge;

    float3x3 tbn = ViewFacingTbn(eyeW);
    float3 pW0 = SurfacePosW(uv, 0, geom.sizeM, geom.depthM);
    float3 viewW = normalize(eyeW - pW0);
    float3 lightW = normalize(sunW - pW0);
    float3 viewTS0 = mul(tbn, viewW);
    float3 lightTS0 = mul(tbn, lightW);

    PomResult pom = ParallaxOcclusion(uv, input.Position.xy, geom, float3(0,0,1), viewTS0, lightTS0);
    pom.normalTS = normalize(lerp(pom.normalTS, float3(0,0,1), saturate(NormalRadius*0.1)));
    float shadow = pom.shadow;

    float matId = clamp(MaterialIndex, 0, 8.99);
    float nSub = lerp(1.45, 1.78, frac(matId)*0.7 + 0.15*HeightParamC);
    float nFilm = 1.38 + 0.12*saturate(f1*0.5+0.5);

    float lamR = 462.0 + TanhFactorR*18.0 + PhaseOffsetR*2.0;
    float lamG = 538.0 + TanhFactorG*18.0 + PhaseOffsetG*2.0;
    float lamB = 612.0 + TanhFactorB*18.0 + PhaseOffsetB*2.0;
    float tintR = 0.9 + CosineFactorR*0.2;
    float tintG = 0.9 + CosineFactorG*0.2;
    float tintB = 0.9 + CosineFactorB*0.2;

    float gainA = 1.0 + f11*0.25;
    float gainB = 1.0 + f12*0.25;
    float mix2 = saturate(Mix2);
    float mix3 = saturate(Mix3);

    float refAngle = 0.1047 * lerp(1.0, 1.45, saturate(LButton));
    float refOn = (RButton==1) ? 1.0 : 0.0;
    float3 refDir = normalize(float3(sin(refAngle), 0, cos(refAngle)));
    float doeGainNow = DOE_GAIN * lerp(1.0, 2.0, saturate(LButton));

    int passIdx = (int)floor(PassNum+0.5);
    passIdx = clamp(passIdx, 0, 3);

    ComplexField prevR = CF_UnpackRT(output.rt1);
    ComplexField prevG = CF_UnpackRT(output.rt2);
    ComplexField prevB = CF_UnpackRT(output.rt3);

    ComplexField holoR = LayeredFourierHologram(pom.uv, geom, lamR);
    ComplexField holoG = LayeredFourierHologram(pom.uv, geom, lamG);
    ComplexField holoB = LayeredFourierHologram(pom.uv, geom, lamB);

    float grooveNm = GrooveDepthNm(pom.uv);
    float doePhaseR = TWO_PI * grooveNm / max(lamR,1) * (1.0 + DOE_TWIST*0.1*pom.hitDepth) * (1.0 + DOE_CHIRP*pom.hitDepth);
    float doePhaseG = TWO_PI * grooveNm / max(lamG,1) * (1.0 + DOE_TWIST*0.1*pom.hitDepth) * (1.0 + DOE_CHIRP*pom.hitDepth);
    float doePhaseB = TWO_PI * grooveNm / max(lamB,1) * (1.0 + DOE_TWIST*0.1*pom.hitDepth) * (1.0 + DOE_CHIRP*pom.hitDepth);
    holoR = CF_MulPhase(holoR, doePhaseR);
    holoG = CF_MulPhase(holoG, doePhaseG);
    holoB = CF_MulPhase(holoB, doePhaseB);

    float doeEffR = DoeEfficiency(1, grooveNm/FOUEFF_SCALE_R()) * tintR;
    float doeEffG = DoeEfficiency(1, grooveNm/FOUEFF_SCALE_G()) * tintG;
    float doeEffB = DoeEfficiency(1, grooveNm/FOUEFF_SCALE_B()) * tintB;

    float cosT0R = saturate(dot(pom.normalTS, normalize(lightTS0+viewTS0)));
    float filmThick = lerp(FILM_MIN_NM_USED, FILM_MAX_NM_USED, pom.hitDepth) + grooveNm*0.25;
    float2 rsR, rpR, rsG, rpG, rsB, rpB;
    ThinFilm_CharMatrix(1.0, nFilm, nSub, filmThick, cosT0R, lamR, rsR, rpR);
    ThinFilm_CharMatrix(1.0, nFilm, nSub, filmThick, cosT0R, lamG, rsG, rpG);
    ThinFilm_CharMatrix(1.0, nFilm, nSub, filmThick, cosT0R, lamB, rsB, rpB);

    float2 filmAttR = 0.5*(rsR+rpR);
    float2 filmAttG = 0.5*(rsG+rpG);
    float2 filmAttB = 0.5*(rsB+rpB);
    holoR.Ex = CMul(holoR.Ex, filmAttR); holoR.Ey = CMul(holoR.Ey, filmAttR);
    holoG.Ex = CMul(holoG.Ex, filmAttG); holoG.Ey = CMul(holoG.Ey, filmAttG);
    holoB.Ex = CMul(holoB.Ex, filmAttB); holoB.Ey = CMul(holoB.Ey, filmAttB);

    float3 oa = normalize(float3(0.2,0.1,1.0+0.1*sin(ANIM_TIME_S)));
    float3x3 eps = DielectricTensor_Uniaxial(1.5, 1.65, oa);
    float anisoPhase = dot(oa, float3(pom.uv-0.5, pom.hitDepth))*0.5*SCATTER_K2*0.1;
    holoR = CF_MulPhase(holoR, anisoPhase);
    holoG = CF_MulPhase(holoG, anisoPhase*0.95);
    holoB = CF_MulPhase(holoB, anisoPhase*1.05);

    float kR = TWO_PI / (lamR*1e-9);
    float kG = TWO_PI / (lamG*1e-9);
    float kB = TWO_PI / (lamB*1e-9);
    float2 refPhR = CExp(kR * dot(pW0, refDir) + PhaseOffsetR);
    float2 refPhG = CExp(kG * dot(pW0, refDir) + PhaseOffsetG);
    float2 refPhB = CExp(kB * dot(pW0, refDir) + PhaseOffsetB);
    ComplexField refR; refR.Ex = CScale(refPhR, 0.7071*refOn); refR.Ey = CScale(refPhR, 0.7071*refOn);
    ComplexField refG; refG.Ex = CScale(refPhG, 0.7071*refOn); refG.Ey = CScale(refPhG, 0.7071*refOn);
    ComplexField refB; refB.Ex = CScale(refPhB, 0.7071*refOn); refB.Ey = CScale(refPhB, 0.7071*refOn);

    float wGS = lerp(0.85, 0.95, saturate(f3*0.1+0.5));
    if(passIdx==0)
    {
        ComplexField outR = CF_Scale(holoR, gainA);
        ComplexField outG = CF_Scale(holoG, gainA);
        ComplexField outB = CF_Scale(holoB, gainA);
        output.rt1 = CF_PackRT(outR);
        output.rt2 = CF_PackRT(outG);
        output.rt3 = CF_PackRT(outB);
        output.rt4 = float4(CAbs2(outR.Ex)+CAbs2(outR.Ey), 0, 0, 1);
        output.rt5 = float4(pom.albedo, 1);
        output.rt6 = float4(pom.normalTS*0.5+0.5, 1);
        output.rt7 = float4(shadow, pom.hitDepth, pom.fade, 1);
        output.rt8 = float4(grooveNm/1000.0, doeGainNow*0.1, 0, 1);
    }
    else if(passIdx==1)
    {
        ComplexField curR = CF_Add(CF_Scale(holoR, gainB), CF_Scale(prevR, wGS));
        ComplexField curG = CF_Add(CF_Scale(holoG, gainB), CF_Scale(prevG, wGS));
        ComplexField curB = CF_Add(CF_Scale(holoB, gainB), CF_Scale(prevB, wGS));
        float ampR = sqrt(CF_Intensity(curR)+1e-6);
        float ampG = sqrt(CF_Intensity(curG)+1e-6);
        float ampB = sqrt(CF_Intensity(curB)+1e-6);
        curR = CF_Scale(curR, lerp(1.0/ampR, 1.0, 1.0-wGS));
        curG = CF_Scale(curG, lerp(1.0/ampG, 1.0, 1.0-wGS));
        curB = CF_Scale(curB, lerp(1.0/ampB, 1.0, 1.0-wGS));
        output.rt1 = CF_PackRT(curR);
        output.rt2 = CF_PackRT(curG);
        output.rt3 = CF_PackRT(curB);
        output.rt4 = float4(ampR*0.01, ampG*0.01, ampB*0.01, 1);
        output.rt5 = float4(pom.albedo * lerp(1, doeEffR, 0.5), 1);
        output.rt6 = float4(pom.normalTS*0.5+0.5, 1);
        output.rt7 = float4(shadow, pom.hitDepth, 1, 1);
        output.rt8 = float4(doeEffR, doeEffG, doeEffB, 1);
    }
    else if(passIdx==2)
    {
        ComplexField totR = CF_Add(CF_Scale(holoR, doeGainNow*0.12 + 0.08), refR);
        ComplexField totG = CF_Add(CF_Scale(holoG, doeGainNow*0.12 + 0.08), refG);
        ComplexField totB = CF_Add(CF_Scale(holoB, doeGainNow*0.12 + 0.08), refB);
        totR = CF_Add(CF_Scale(totR, mix2), CF_Scale(prevR, 1-mix2));
        totG = CF_Add(CF_Scale(totG, mix2), CF_Scale(prevG, 1-mix2));
        totB = CF_Add(CF_Scale(totB, mix2), CF_Scale(prevB, 1-mix2));
        output.rt1 = CF_PackRT(totR);
        output.rt2 = CF_PackRT(totG);
        output.rt3 = CF_PackRT(totB);
        output.rt4 = float4(CAbs2(totR.Ex), CAbs2(totG.Ex), CAbs2(totB.Ex), 1);
        output.rt5 = float4(pom.albedo, 1);
        output.rt6 = float4(pom.normalTS*0.5+0.5, 1);
        output.rt7 = float4(shadow, pom.hitDepth, pom.fade, 1);
        output.rt8 = float4(filmThick/900.0, grooveNm/800.0, 0, 1);
    }
    else
    {
        ComplexField totR = CF_UnpackRT(output.rt1);
        ComplexField totG = CF_UnpackRT(output.rt2);
        ComplexField totB = CF_UnpackRT(output.rt3);
        float fresPow = max(FresnelPower, 1.0);
        float fresRefl = saturate(FresnelReflectance);
        float fresMix = saturate(FresnelMix);
        float specPow = max(SpecularPower, 1.0);
        float specInt = saturate(SpecularIntensity)*2.0;

        float iR = CF_Intensity(totR) * doeEffR * gainA;
        float iG = CF_Intensity(totG) * doeEffG * gainA;
        float iB = CF_Intensity(totB) * doeEffB * gainA;

        float cosV = saturate(dot(pom.normalTS, normalize(viewTS0)));
        float fres = fresRefl + (1-fresRefl)*pow(1-cosV, fresPow);
        fres = lerp(1.0, fres, fresMix);

        float3 halfTS = normalize(viewTS0 + lightTS0);
        float ndh = saturate(dot(pom.normalTS, halfTS));
        float spec = pow(ndh, specPow) * specInt * shadow;

        float doeContribR = iR * fres * (0.85 + 0.5*doeGainNow*0.1) * shadow;
        float doeContribG = iG * fres * (0.85 + 0.5*doeGainNow*0.1) * shadow;
        float doeContribB = iB * fres * (0.85 + 0.5*doeGainNow*0.1) * shadow;

        float3 intensityRGB = float3(doeContribR, doeContribG, doeContribB);
        intensityRGB += spec.xxx * 0.35;
        intensityRGB *= lerp(1.0, pom.albedo, DOE_ALBEDO_TINT);
        intensityRGB *= lerp(0.4, 1.0, pom.fade);

        float3 xyzR = CieXyz(lamR) * doeContribR;
        float3 xyzG = CieXyz(lamG) * doeContribG;
        float3 xyzB = CieXyz(lamB) * doeContribB;
        float3 xyz = xyzR + xyzG + xyzB;
        xyz += float3(0.02,0.02,0.02) * spec;
        float3 lin = XyzToLinearRgb(xyz);
        lin = lerp(lin, pom.color.rgb, saturate(mix3*0.15));
        lin = GamutCompress(lin);
        float fog = saturate(pom.hitDepth * DepthScale * 0.12 + HeightParamA*0.05);
        lin = lerp(lin, lin*0.88 + 0.04, fog);
        lin = lerp(lin, lin * float3(1.07,1.0,0.97), saturate(LButton)*0.22);
        if(RButton==1) lin = pow(saturate(lin), 0.96);

        float3 disp = EncodeDisplay(lin);
        float alpha = saturate(ShaderAlpha);
        int dbg = DebugMode();
        if(dbg==1) disp = pom.hitDepth.xxx;
        else if(dbg==2) disp = pom.normalTS*0.5+0.5;
        else if(dbg==4) disp = shadow.xxx;
        if(pom.edge < 0) disp *= 0.35;

        output.rt1 = float4(disp, alpha);
        output.rt2 = float4(lin, 1);
        output.rt3 = float4(xyz*0.12, 1);
        output.rt4 = CF_PackRT(totR);
        output.rt5 = CF_PackRT(totG);
        output.rt6 = CF_PackRT(totB);
        output.rt7 = float4(pom.uv, pom.hitDepth, shadow);
        output.rt8 = float4(fres, spec, grooveNm/900.0, 1);
    }

    output.rt8.w += (OIL_THICK*1e-7 + FILM_BIAS2*1e-7 + SCATTER_K2*1e-7 + PHASE_K2*1e-7 + FILM_MIN_USED2*1e-9)*0.0;

    return output;
}
