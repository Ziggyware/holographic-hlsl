#define FILM_WHITE_RGB float3(1.2048, 0.9484, 0.9087)

#define SPECKLE_AMP_FLOOR 0.25


#define FILM_MIN_NM   250.0
#define FILM_MAX_NM   900.0   // keep <= ~900: 8 samples alias above ~1100 nm OPD/lambda slope
#define FILM_N        1.45
#define FILM_SAMPLES  8
#define FILM_STRENGTH .150

#define TBN_MAX_TILT 1.0471976   // 60 deg at |View*| = 1
#define EYE_HEIGHT   1.5         // eye height above plate center, footprint units



#define SPECTRAL_AMBIENT 0.02

#define TANGENT_EDGE_THRESHOLD 0.02

#define POM_ABSORB           0.5
#define POM_MIN_COS          0.15
#define POM_TRANS_FLOOR      0.25
#define POM_AO_MIN           0.4
#define POM_SHADOW_FLOOR     0.12
#define PS_MIN_FILM_FRACTION 0.3
#define PS_SHADOW_DARKEN_MAX 0.5

#define DOE_PERIOD_UM        (clamp(float(f2), 0.2, 1.0))
#define DOE_GAIN             (clamp(float(f3), 0.0, 100.0))
#define DOE_SIGMA            (clamp(float(f4), 0.01, 0.5))
#define DOE_SWIRL            (clamp(float(f5), -4.0, 4.0))
#define DOE_CHIRP            (clamp(float(f8), -1.0, 1.0))
#define DOE_GROOVE_NM        (clamp(float(f10), 20.0, 400.0))

#define HOLO_ETA_FLOOR 0.35


#define POM_MAX_STEPS        128
#define POM_TEMPORAL         0
#define POM_CLIP_EDGES       1
#define POM_AO_DIRS          8
#define POM_AO_RADII         3
#define POM_AO_TEXELS        4.0
#define POM_AO_STRENGTH      1.0

#define DOE_SOURCE_K         6500.0
#define DOE_SPEC_N           24
#define DOE_ORDERS           3
#define DOE_LAMBDA_MIN       380.0
#define DOE_LAMBDA_MAX       780.0

// ---------- compile-time knobs ----------
#define POM_MIN_STEPS        10
#define POM_REFINE_ITERS     5      // Illinois false-position iterations
#define POM_SHADOW_STEPS     12
#define POM_SHADOW_SMIN 0.15   // retune POM_SHADOW_SOFTNESS after this

#define POM_SHADOW_BIAS      0.01   // normalized-depth units
#define POM_SHADOW_SOFTNESS  4.0    // 1/softness = occlusion ratio for full shadow
#define POM_LOD_FADE_START   1.0    // mip at which parallax starts fading
#define POM_LOD_FADE_END     5.0    // mip at which parallax is gone
#define POM_DEPTH_IS_HEIGHT  1      // 1 if depthMap stores height (1 = high)


#define MAX_DIFFRACTION_ORDERS 3    // A: -1, 0, +1 typically sufficient
#define VOLUME_HOLOGRAM_THICKNESS_MM (Mix3 * 1e-3) // A: emulsion thickness
#define REFRACTIVE_INDEX_MODULATION (.0033)         // A: dn (typ 0.01-0.06)
#define AVERAGE_REFRACTIVE_INDEX 1.52              // A: n0 of dichromated gelatin
#define SPECKLE_SEED (f1)                         // A: temporal speckle seed


#define time (TotalTime*AnimateSpeed)

#define MAX_NUM_MASSES 64
#define TWO_PI (3.1415926535*2.0)
const float PlanckConstant = 6.62607015e-34; // Planck constant in J·s
const float PhotonMass = 1e-50; // Effective photon mass in kg
const float G = 6.67430e-11; // Gravitational constant in m^3 kg^-1 s^-2

#define SPECTRAL_COUNT 3

// Nanometers ↔ Meters
#define nmToM(nm)        ((nm) * 1e-9)
#define mToNm(m)         ((m)  * 1e9)

// Micrometers ↔ Meters
#define umToM(um)        ((um) * 1e-6)
#define mToUm(m)         ((m)  * 1e6)

// Millimeters ↔ Meters
#define mmToM(mm)        ((mm) * 1e-3)
#define mToMm(m)         ((m)  * 1e3)

// Nanometers ↔ Millimeters
#define nmToMm(nm)       ((nm) * 1e-6)
#define mmToNm(mm)       ((mm) * 1e6)


#define SPEED_OF_LIGHT 299792458.0

#define ZERO4 float4(0.0,0.0,0.0,0.0)
#define ZERO3 float3(0.0,0.0,0.0)
#define ZERO2 float2(0.0,0.0)
#define ZERO1 float(0.0)
#define ONE4 float4(1.0,1.0,1.0,1.0)
#define ONE3 float3(1.0,1.0,1.0)
#define ONE2 float2(1.0,1.0)
#define ONE float(1.0)
#define POINT54 float4(0.5,0.5,0.5,0.5)
#define POINT53 float3(0.5,0.5,0.5)
#define POINT52 float2(0.5,0.5)
#define POINT5 float(0.5)

#define PI 3.14159265359
#define PI2 float2(PI,PI)
#define PI3 float3(PI,PI,PI)
#define PI4 float4(PI,PI,PI,PI)
#define TWO 2.0
#define TWO2 float2(2.0,2.0)
#define TWO3 float3(2.0,2.0,2.0)
#define TWO4 float4(2.0,2.0,2.0,2.0)
#define TWOPI (TWO*PI)
#define TWOPI2 (TWO2*PI2)
#define TWOPI3 (TWO3*PI3)
#define TWOPI4 (TWO4*PI4)


// Constants defining the number of layers and maximum parallax layers.
#define MAX_PARALLAX_LAYERS 40
#define EPSILON 1e-10
#define OneMinusEPSILON (1.0-EPSILON)
#define EPSILON2 float2(EPSILON,EPSILON)
#define EPSILON3 float3(EPSILON,EPSILON,EPSILON)
#define EPSILON4 float4(EPSILON,EPSILON,EPSILON,EPSILON)
#define OneMinusEPSILON2 float2(OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON3 float3(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON4 float4(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
// Epsilon value for floating point comparisons and clamping.

// Macros for finding the maximum and minimum components of a vector.
#define MaxComponent4(v) max(max(max(v.x,v.y),v.z),v.w)
#define MaxComponent3(v) max(max(v.x,v.y),v.z)
#define MaxComponent2(v) max(v.x,v.y)
#define MinComponent4(v) min(min(min(v.x,v.y),v.z),v.w)
#define MinComponent3(v) min(min(v.x,v.y),v.z)
#define MinComponent2(v) min(v.x,v.y)
// Macros for adding the components of a vector.
#define AddComponents4(v) (v.x+v.y+v.z+v.w)
#define AddComponents3(v) (v.x+v.y+v.z)
#define AddComponents2(v) (v.x+v.y)

//count of xyzw above f
#define CountAbove4(f,v4,epsilon) ((v4.x>f+epsilon?1.0:0.0)+(v4.y>f+epsilon?1.0:0.0)+(v4.z>f+epsilon?1.0:0.0)+(v4.w>f+epsilon?1.0:0.0))

//count of xyzw below f
#define CountBelow4(f,v4,epsilon) ((v4.x+epsilon<f-epsilon?1.0:0.0)+(v4.y+epsilon<f-epsilon?1.0:0.0)+(v4.z+epsilon<f-epsilon?1.0:0.0)+(v4.w+epsilon<f-epsilon?1.0:0.0))
#define MAX_GAUSSIAN_POINTS 3
#define MAX_INTERFERENCE_POINTS MAX_GAUSSIAN_POINTS

// Constants


// Minimum and maximum wavelengths for R, G, B components (in nanometers)
#define RED_MIN_WAVELENGTH 620.0
#define RED_MAX_WAVELENGTH 750.0
#define RED_WAVELENGTH ((RED_MAX_WAVELENGTH+RED_MIN_WAVELENGTH)*.5)
#define GREEN_MIN_WAVELENGTH 495.0
#define GREEN_MAX_WAVELENGTH 570.0
#define GREEN_WAVELENGTH ((GREEN_MAX_WAVELENGTH+GREEN_MIN_WAVELENGTH)*.5)
#define BLUE_MIN_WAVELENGTH 450.0
#define BLUE_MAX_WAVELENGTH 495.0
#define BLUE_WAVELENGTH ((BLUE_MAX_WAVELENGTH+BLUE_MIN_WAVELENGTH)*.5)
#define FLT_MAX 3.402823466e+38



static const float3 MIN_WAVELENGTHS = float3(RED_MIN_WAVELENGTH, GREEN_MIN_WAVELENGTH, BLUE_MIN_WAVELENGTH);
static const float3 MAX_WAVELENGTHS = float3(RED_MAX_WAVELENGTH, GREEN_MAX_WAVELENGTH, BLUE_MAX_WAVELENGTH);
static const float3 RGB_WAVELENGTHS_NM = float3(RED_WAVELENGTH, GREEN_WAVELENGTH, BLUE_WAVELENGTH);
static const float3 RGB_WAVELENGTHS_M = nmToM(RGB_WAVELENGTHS_NM);
static const float3 RGB_WAVELENGTHS_MM = nmToMm(RGB_WAVELENGTHS_NM);
static const float MAX_WAVELENGTH = 780.0;
static const float MIN_WAVELENGTH = 380.0;
// Number of wavelength samples
static const int NUM_SAMPLES = 471;
static const int SPECTRAL_LOCUS_COUNT = 471; // 360 nm to 830 nm at 1 nm intervals

static const float3 WAVELENGTH_RANGES = (MAX_WAVELENGTHS - MIN_WAVELENGTHS);
static const float WAVELENGTH_RANGE = (MAX_WAVELENGTH - MIN_WAVELENGTH);
static const float WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE = (float(SPECTRAL_LOCUS_COUNT) / WAVELENGTH_RANGE);

#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)

#define PassPct ((PassNum+1)/NumPasses)

// Function to safely safeNormalize a vector, preventing division by zero
inline float4 safeNormalize(float4 v)
{
    float lengthV = length(v);
    return (lengthV > EPSILON) ? v / lengthV : ZERO4;
}

inline float3 safeNormalize(float3 v)
{
    float lengthV = length(v);
    return (lengthV > EPSILON) ? v / lengthV : ZERO3;
}
inline float2 safeNormalize(float2 v)
{
    float lengthV = length(v);
    return (lengthV > EPSILON) ? v / lengthV : ZERO2;
}


#define variation4(v) (MaxComponent4(v)-MinComponent4(v))
#define variation3(v) (MaxComponent3(v)-MinComponent3(v))
#define variation2(v) (MaxComponent2(v)-MinComponent2(v))

#define variation44(dc2,dc6) float4(max(dc2.x,dc6.x)-min(dc2.x,dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y),max(dc2.z,dc6.z)-min(dc2.z,dc6.z),max(dc2.w,dc6.w)-min(dc2.w,dc6.w))
#define variation33(dc2,dc6) float3(max(dc2.x,dc6.x)-min(dc2.x, dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y),max(dc2.z,dc6.z)-min(dc2.z,dc6.z))
#define variation22(dc2,dc6) float2(max(dc2.x,dc6.x)-min(dc2.x,dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y))
#define variation11(dc2,dc6) (max(dc2.x,dc6.x)-min(dc2.x,dc6.x))
#define variation21(v) (max(v.x,v.y)-min(v.x,v.y))
#define variationSum4(dc2,dc6) AddComponents4(variation44(dc2,dc6))

#define GAMMA_VALUE 2.2

#define SWAY_AMPLITUDE 0.1
#define SWAY_FREQUENCY 2.0

// Maximum number of light sources
#define MAX_LIGHT_SOURCES 22

#define HOLOGRAM_SIZE_M (HeightScale / GetSz1(depthMap).xy)

#define MAX_GRATING_LAYERS 4

#define MIN_CHROMATICITY float3(0.1741, 0.0050, 1.0 - (0.1741 + 0.0050))
#define MAX_CHROMATICITY float3(0.0842, 0.0420, 1.0 - (0.0842 + 0.0420))
#define CHROMATICITY_RANGE (MAX_CHROMATICITY - MIN_CHROMATICITY)




cbuffer ConstantBuffer : register(b0)
{
float SunX;
		float SunY;
		float SunZ;
		float ViewX;      // Camera/view position (x, y, z)

		float ViewY;
		float ViewZ;
		// Parallax Occlusion Mapping Parameters
		float ParallaxFactorA;   // Factors for parallax mapping
		float ParallaxFactorB;

		float ParallaxFactorC;
		float HeightParamA;      // Parameters for height calculations
		float HeightParamB;
		float HeightParamC;

		// Phase Modulation Parameters
		float PhaseOffsetR;      // Phase offsets for R, G, B channels
		float PhaseOffsetG;
		float PhaseOffsetB;
		float LookAtX;

		float CosineFactorR;     // Cosine factors for R, G, B channels
		float CosineFactorG;
		float CosineFactorB;
		float LookAtY;

		float TanhFactorR;       // Tanh factors for R, G, B channels
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


// Mathematical constants.

// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetSz1(Texture2D<float> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetSz2(Texture2D<float2> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetSz3(Texture2D<float3> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}

inline int2 GetSz3i(Texture2D<float3> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return int2(sz);
} 

// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetSz4(Texture2D<float4> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float> tex)
{
    float2 sz = GetSz1(tex);
    return ONE2 / float2(sz.x, sz.y);
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float2> tex)
{
    float2 sz = GetSz2(tex);
    return ONE2 / sz;
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float3> tex)
{
    float2 sz = GetSz3(tex);
    return ONE2 / sz;
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float4> tex)
{
    float2 sz = GetSz4(tex);
    return ONE2 / sz;
}




// Texture resources used by the shader.
Texture2D<float4> diffuseMap : register(t0);
Texture2D<float> depthMap : register(t1);
Texture2D<float> gratingDepth1 : register(t2);
Texture2D<float> gratingDepth2 : register(t3);
Texture2D<float> gratingDepth3 : register(t4);
Texture2D<float> gratingDepth4 : register(t5);
Texture2D<float4> skylineMap : register(t6);
Texture2D<float4> rainbowMap2 : register(t7);
Texture2D<float4> gratingMap1 : register(t8);
Texture2D<float4> gratingMap2 : register(t9);
Texture2D<float4> gratingMap3 : register(t10);
Texture2D<float4> gratingMap4 : register(t11);
Texture2D<float3> gradient1 : register(t12);
Texture2D<float3> gradient2 : register(t13);
Texture2D<float3> gradient3 : register(t14);
Texture2D<float3> gradient4 : register(t15);
Texture2D<float3> noiseMap1 : register(t16);
Texture2D<float3> noiseMap2 : register(t17);
Texture2D<float3> noiseMap3 : register(t18);
Texture2D<float3> noiseMap4 : register(t19);
Texture2D<float3> normalMap : register(t20);
Texture2D<float3> gratingNormal1 : register(t21);
Texture2D<float3> gratingNormal2 : register(t22);
Texture2D<float3> gratingNormal3 : register(t23);
Texture2D<float3> gratingNormal4 : register(t24);
Texture2D<float4> rtMap1 : register(t25);
Texture2D<float4> rtMap2 : register(t26);
Texture2D<float4> rtMap3 : register(t27);
Texture2D<float4> rtMap4 : register(t28);
Texture2D<float4> rtMap5 : register(t29);
Texture2D<float4> rtMap6 : register(t30);
Texture2D<float4> rtMap7 : register(t31);
Texture2D<float4> rtMap8 : register(t32);
Texture2D<float4> rtMap9 : register(t33);
Texture2D<float4> rtMap10 : register(t34);
Texture2D<float4> rtMap11 : register(t35);
Texture2D<float4> rtMap12 : register(t36);
Texture2D<float4> rtMap13 : register(t37);
Texture2D<float4> rtMap14 : register(t38);
Texture2D<float4> rtMap15 : register(t39);
Texture2D<float4> rtMap16 : register(t40);
Texture2D<float4> computeMap : register(t41);

// Sampler states for texture sampling.
SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);
SamplerState sampleTypeClamp : register(s2);
SamplerState sampleTypeCube : register(s3);
SamplerState sampleTypePoint : register(s4);

//main return type
struct psout
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


inline float4 Sample(Texture2D<float4> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0.0);
}

inline float3 Sample(Texture2D<float3> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0.0);
}


void InitPSOut(inout psout ret, float2 uv)
{
    if (PassNum == 0)
    {
        ret.rt1 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt2 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt3 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt4 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt5 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt6 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt7 = float4(0.0, 0.0, 0.0, 1.0);
        ret.rt8 = float4(0.0, 0.0, 0.0, 1.0);
    }
    else
    {
        ret.rt1 = float4(rtMap1.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt2 = float4(rtMap2.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt3 = float4(rtMap3.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt4 = float4(rtMap4.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt5 = float4(rtMap5.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt6 = float4(rtMap6.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt7 = float4(rtMap7.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
        ret.rt8 = float4(rtMap8.SampleLevel(sampleTypeMirror, uv, 0.0).xyz, 1.0);
    }
}
// Input structure for the pixel shader.
struct PS_INPUT
{
    float4 Position : SV_Position;
    float2 uv : UV0;
    float3 ViewDir : UV1;
    float4 Color : COLOR0;
};
// Input structure for the vertex shader.
struct VS_INPUT
{
    float3 Position : SV_POSITION;
    float2 uv : UV0;
};


// Importance Sampling Function
float3 ImportanceSample(float3 normal, float density, float2 uv)
{
    // Generate a random direction biased towards the normal
    float3 randomDir = normalize(normal + float3(
        (noiseMap1.SampleLevel(sampleTypeLinear, uv + float2(0.1, 0.1), 0) - 0.5).x * density,
        (noiseMap1.SampleLevel(sampleTypeLinear, uv + float2(0.2, 0.2), 0) - 0.5).y * density,
        (noiseMap1.SampleLevel(sampleTypeLinear, uv + float2(0.3, 0.3), 0) - 0.5).z * density
    ));
    return randomDir;
}


// Structure to hold individual wavefront properties
struct Wavefront
{
    float3 wavelengthMeters; // [Meters] Wavelength
    float3 amplitude; // [Meters] Amplitude
    float3 color; // [RGB] Color based on wavelength
    float3 phase;
};
// Stratified Sampling Function
float3 StratifiedSample(float2 uv, int sampleIndex, int totalSamples)
{
    uint samplesPerRow = max(1, (uint) sqrt((float) totalSamples));
    uint row = sampleIndex / samplesPerRow;
    uint col = sampleIndex % samplesPerRow;

    float2 stratifiedUV = float2(
        float(col) + noiseMap1.SampleLevel(sampleTypeLinear, uv + float2(sampleIndex, 0), 0).x / float(samplesPerRow),
        float(row) + noiseMap1.SampleLevel(sampleTypeLinear, uv + float2(0, sampleIndex), 0).y / float(samplesPerRow)
    );

    return float3(stratifiedUV, 0.0);
}
// Color Space Conversion Functions
inline float3 SRGBToLinear(float3 srgb)
{
    return saturate(float3(
        (srgb.r <= 0.04045) ? srgb.r / 12.92 : pow(abs((srgb.r + 0.055) / 1.055), 2.4),
        (srgb.g <= 0.04045) ? srgb.g / 12.92 : pow(abs((srgb.g + 0.055) / 1.055), 2.4),
        (srgb.b <= 0.04045) ? srgb.b / 12.92 : pow(abs((srgb.b + 0.055) / 1.055), 2.4)
    ));
}
inline float sigmoid(float x)
{
    return 1.0 / (1.0 + exp(-x));
}

inline float2 sigmoid(float2 x)
{
    return 1.0.xx / (1.0.xx + exp(-x));
}

inline float3 sigmoid(float3 x)
{
    return 1.0.xxx / (1.0.xxx + exp(-x));
}

inline float4 sigmoid(float4 x)
{
    return 1.0.xxxx / (1.0.xxxx + exp(-x));
}

inline float invSigmoid(float y)
{
    y = clamp(y, EPSILON, 1.0 - EPSILON);
    return log(y / (1.0 - y));
}

inline float safeNormalizeRange(float2 range, float value)
{
    float lo = min(range.x, range.y);
    float hi = max(range.x, range.y);
    return (lerp(lo, hi, value) - lo) / max(hi - lo, EPSILON);
}

inline float2 safeNormalizeRange(float2 range, float2 value)
{
    float lo = min(range.x, range.y);
    float hi = max(range.x, range.y);
    float d  = max(hi - lo, EPSILON);
    return (clamp(value, lo, hi) - lo) / d;
}
inline float moilerp(float a, float b, float value)
{
    float2 r = float2(min(a, b), max(a, b));
    float n = safeNormalizeRange(r, value);
    float s0 = sigmoid(-3.0);
    float s1 = sigmoid(3.0);
    float t = (sigmoid(6.0 * (n - 0.5)) - s0) / (s1 - s0);
    return lerp(a, b, t);
}
inline float moilerp(float2 ab, float value)
{
    return moilerp(ab.x, ab.y, value);
}

inline float2 moilerp(float2 a, float2 b, float2 value)
{
    return float2(
        moilerp(a.x, b.x, value.x),
        moilerp(a.y, b.y, value.y)
    );
}

inline float3 moilerp(float3 a, float3 b, float3 value)
{
    return float3(
        moilerp(a.x, b.x, value.x),
        moilerp(a.y, b.y, value.y),
        moilerp(a.z, b.z, value.z)
    );
}

inline float4 moilerp(float4 a, float4 b, float4 value)
{
    return float4(
        moilerp(a.x, b.x, value.x),
        moilerp(a.y, b.y, value.y),
        moilerp(a.z, b.z, value.z),
        moilerp(a.w, b.w, value.w)
    );
}

struct Wavelength
{
    float value;
    uint unit; // 0 = NM, 1 = M, 2 = MM
};

// 0 = Nano Meters, 1 = Meters, 2 = Micro Meters
Wavelength wavelengthCreate(float value, uint unit)
{
    Wavelength w;
    w.value = value;
    w.unit = unit;
    return w;
}

Wavelength wavelengthConvert(Wavelength w, uint newUnit)
{
    switch (w.unit)
    {
        case 0: // NM
            switch (newUnit)
            {
                case 1: // M
                    return wavelengthCreate(nmToM(w.value), 1);
                case 2: // MM
                    return wavelengthCreate(nmToMm(w.value), 2);
                default:
                    return w;
            }
        case 1: // M
            switch (newUnit)
            {
                case 0: // NM
                    return wavelengthCreate(mToNm(w.value), 0);
                case 2: // MM
                    return wavelengthCreate(mToMm(w.value), 2);
                default:
                    return w;
            }
        case 2: // MM
            switch (newUnit)
            {
                case 0: // NM
                    return wavelengthCreate(mmToNm(w.value), 0);
                case 1: // M
                    return wavelengthCreate(mmToM(w.value), 1);
                default:
                    return w;
            }
    }
    return w;
}

// Returns the cosine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float cosTime01(float timeMul)
{
    return clamp((1.0 + cos(TotalTime * timeMul)) * 0.5, 0.0, 1.0);
}

// Returns the sine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float sinTime01(float timeMul)
{
    return clamp((1.0 + sin(TotalTime * timeMul)) * 0.5, 0.0, 1.0);
}
// Returns the cosine of the total time multiplied by a given factor, safeNormalize to the range [1, 1].
inline float cosTime11(float timeMul)
{
    return clamp(cosTime01(timeMul) * 2.0 - 1.0, -1.0, 1.0);
}
// Returns the sine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float sinTime11(float timeMul)
{
    return clamp(sinTime01(timeMul) * 2.0 - 1.0, -1.0, 1.0);
}


inline float4 AdjustGamma(float4 color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON4, color), ONE4 / gammaValue);
}
inline float3 AdjustGamma(float3 color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON3, color), ONE3 / gammaValue);
}
inline float AdjustGamma(float color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON, color), ONE / gammaValue);
}

//10. Volumetric Light Scatterings
float3 CalculateFresnelReflectance(float3 viewDir, float3 normal, float3 refractiveIndex, out float3 refractedDir)
{
    float3 V = normalize(viewDir);
    float3 N = normalize(normal);
    float cosThetaI = clamp(dot(V, N), 0.0, 1.0);
    float3 eta = refractiveIndex;
    float3 etaRatio = 1.0 / eta;
    
    // Snell's Law for Refraction
    refractedDir = refract(-V, N, etaRatio.x); // Assuming first component for simplicity
    
    // Compute Reflectance using Schlick's Approximation
    float3 R0 = pow((eta - 1.0) / (eta + 1.0), 2.0);
    float3 reflectance = R0 + (1.0 - R0) * pow(1.0 - cosThetaI, 5.0);
    return reflectance;
}

float hash11(float p)
{
    p = frac(p * .1031);
    p *= p + 33.33;
    p *= p + p;
    return frac(p);
}
float2 hash22(float2 p)
{
    p.x = frac(p.x * .1031);
    p.y = frac(p.y * .3377);
    p *= p + float2(33.33,55.55);
    p *= p + p;
    return frac(p);
}

float3 hash33(float3 p)
{
    p.x = frac(p.x * .1031);
    p.y = frac(p.y * .3110);
    p.z = frac(p.z * .0113);
    p *= p + float3(33.33,55.55,77.77);
    p *= p + p;
    return frac(p);
}

static const float xBar[NUM_SAMPLES] =
{
    0.0001299, 0.000145847, 0.000163802, 0.000184004, 0.00020669, 0.0002321,
      0.000260728, 0.000293075, 0.000329388, 0.000369914, 0.0004149, 0.000464159,
      0.000518986, 0.000581854, 0.000655235, 0.0007416, 0.00084503, 0.000964527,
      0.001094949, 0.001231154, 0.001368, 0.00150205, 0.001642328, 0.001802382,
      0.001995757, 0.002236, 0.002535385, 0.002892603, 0.003300829, 0.003753236,
      0.004243, 0.004762389, 0.005330048, 0.005978712, 0.006741117, 0.00765,
      0.008751373, 0.01002888, 0.0114217, 0.01286901, 0.01431, 0.01570443,
      0.01714744, 0.01878122, 0.02074801, 0.02319, 0.02620736, 0.02978248,
      0.03388092, 0.03846824, 0.04351, 0.0489956, 0.0550226, 0.0617188, 0.069212,
      0.07763, 0.08695811, 0.09717672, 0.1084063, 0.1207672, 0.13438, 0.1493582,
      0.1653957, 0.1819831, 0.198611, 0.21477, 0.2301868, 0.2448797, 0.2587773,
      0.2718079, 0.2839, 0.2949438, 0.3048965, 0.3137873, 0.3216454, 0.3285,
      0.3343513, 0.3392101, 0.3431213, 0.3461296, 0.34828, 0.3495999, 0.3501474,
      0.350013, 0.349287, 0.34806, 0.3463733, 0.3442624, 0.3418088, 0.3390941,
      0.3362, 0.3331977, 0.3300411, 0.3266357, 0.3228868, 0.3187, 0.3140251,
      0.308884, 0.3032904, 0.2972579, 0.2908, 0.2839701, 0.2767214, 0.2689178,
      0.2604227, 0.2511, 0.2408475, 0.2298512, 0.2184072, 0.2068115, 0.19536,
      0.1842136, 0.1733273, 0.1626881, 0.1522833, 0.1421, 0.1321786, 0.1225696,
      0.1132752, 0.1042979, 0.09564, 0.08729955, 0.07930804, 0.07171776,
      0.06458099, 0.05795001, 0.05186211, 0.04628152, 0.04115088, 0.03641283,
      0.03201, 0.0279172, 0.0241444, 0.020687, 0.0175404, 0.0147, 0.01216179,
      0.00991996, 0.00796724, 0.006296346, 0.0049, 0.003777173, 0.00294532,
      0.00242488, 0.002236293, 0.0024, 0.00292552, 0.00383656, 0.00517484,
      0.00698208, 0.0093, 0.01214949, 0.01553588, 0.01947752, 0.02399277, 0.0291,
      0.03481485, 0.04112016, 0.04798504, 0.05537861, 0.06327, 0.07163501,
      0.08046224, 0.08973996, 0.09945645, 0.1096, 0.1201674, 0.1311145, 0.1423679,
      0.1538542, 0.1655, 0.1772571, 0.18914, 0.2011694, 0.2133658, 0.2257499,
      0.2383209, 0.2510668, 0.2639922, 0.2771017, 0.2904, 0.3038912, 0.3175726,
      0.3314384, 0.3454828, 0.3597, 0.3740839, 0.3886396, 0.4033784, 0.4183115,
      0.4334499, 0.4487953, 0.464336, 0.480064, 0.4959713, 0.5120501, 0.5282959,
      0.5446916, 0.5612094, 0.5778215, 0.5945, 0.6112209, 0.6279758, 0.6447602,
      0.6615697, 0.6784, 0.6952392, 0.7120586, 0.7288284, 0.7455188, 0.7621,
      0.7785432, 0.7948256, 0.8109264, 0.8268248, 0.8425, 0.8579325, 0.8730816,
      0.8878944, 0.9023181, 0.9163, 0.9297995, 0.9427984, 0.9552776, 0.9672179,
      0.9786, 0.9893856, 0.9995488, 1.0090892, 1.0180064, 1.0263, 1.0339827,
      1.040986, 1.047188, 1.0524667, 1.0567, 1.0597944, 1.0617992, 1.0628068,
      1.0629096, 1.0622, 1.0607352, 1.0584436, 1.0552244, 1.0509768, 1.0456,
      1.0390369, 1.0313608, 1.0226662, 1.0130477, 1.0026, 0.9913675, 0.9793314,
      0.9664916, 0.9528479, 0.9384, 0.923194, 0.907244, 0.890502, 0.87292,
      0.8544499, 0.835084, 0.814946, 0.794186, 0.772954, 0.7514, 0.7295836,
      0.7075888, 0.6856022, 0.6638104, 0.6424, 0.6215149, 0.6011138, 0.5811052,
      0.5613977, 0.5419, 0.5225995, 0.5035464, 0.4847436, 0.4661939, 0.4479,
      0.4298613, 0.412098, 0.394644, 0.3775333, 0.3608, 0.3444563, 0.3285168,
      0.3130192, 0.2980011, 0.2835, 0.2695448, 0.2561184, 0.2431896, 0.2307272,
      0.2187, 0.2070971, 0.1959232, 0.1851708, 0.1748323, 0.1649, 0.1553667,
      0.14623, 0.13749, 0.1291467, 0.1212, 0.1136397, 0.106465, 0.09969044,
      0.09333061, 0.0874, 0.08190096, 0.07680428, 0.07207712, 0.06768664, 0.0636,
      0.05980685, 0.05628216, 0.05297104, 0.04981861, 0.04677, 0.04378405,
      0.04087536, 0.03807264, 0.03540461, 0.0329, 0.03056419, 0.02838056,
      0.02634484, 0.02445275, 0.0227, 0.02108429, 0.01959988, 0.01823732,
      0.01698717, 0.01584, 0.01479064, 0.01383132, 0.01294868, 0.0121292,
      0.01135916, 0.01062935, 0.009938846, 0.009288422, 0.008678854, 0.008110916,
      0.007582388, 0.007088746, 0.006627313, 0.006195408, 0.005790346,
      0.005409826, 0.005052583, 0.004717512, 0.004403507, 0.004109457,
      0.003833913, 0.003575748, 0.003334342, 0.003109075, 0.002899327,
      0.002704348, 0.00252302, 0.002354168, 0.002196616, 0.00204919, 0.00191096,
      0.001781438, 0.00166011, 0.001546459, 0.001439971, 0.001340042, 0.001246275,
      0.001158471, 0.00107643, 0.000999949, 0.000928736, 0.000862433, 0.00080075,
      0.000743396, 0.000690079, 0.000640516, 0.000594502, 0.000551865,
      0.000512429, 0.000476021, 0.000442454, 0.000411512, 0.000382981,
      0.000356649, 0.000332301, 0.000309759, 0.000288887, 0.000269539,
      0.000251568, 0.000234826, 0.000219171, 0.000204526, 0.000190841,
      0.000178065, 0.000166151, 0.000155024, 0.000144622, 0.00013491, 0.000125852,
      0.000117413, 0.000109552, 0.000102225, 9.54e-5, 8.9e-5, 8.31e-5, 7.75e-5,
      7.23e-5, 6.75e-5, 6.29e-5, 5.87e-5, 5.48e-5, 5.11e-5, 4.77e-5, 4.45e-5,
      4.15e-5, 3.87e-5, 3.61e-5, 3.37e-5, 3.15e-5, 2.94e-5, 2.74e-5, 2.55e-5,
      2.38e-5, 2.22e-5, 2.07e-5, 1.93e-5, 1.8e-5, 1.67e-5, 1.56e-5, 1.46e-5,
      1.36e-5, 1.27e-5, 1.18e-5, 1.1e-5, 1.03e-5, 9.56e-6, 8.91e-6, 8.31e-6,
      7.75e-6, 7.22e-6, 6.73e-6, 6.28e-6, 5.85e-6, 5.46e-6, 5.09e-6, 4.74e-6,
      4.42e-6, 4.12e-6, 3.84e-6, 3.58e-6, 3.34e-6, 3.11e-6, 2.9e-6, 2.71e-6,
      2.52e-6, 2.35e-6, 2.19e-6, 2.04e-6, 1.91e-6, 1.78e-6, 1.66e-6, 1.54e-6,
      1.44e-6, 1.34e-6, 1.25e-6
};

static const float yBar[NUM_SAMPLES] =
{
    3.92e-6, 4.39e-6, 4.93e-6, 5.53e-6, 6.21e-6, 6.97e-6, 7.81e-6, 8.77e-6,
      9.84e-6, 1.1e-5, 1.24e-5, 1.39e-5, 1.56e-5, 1.74e-5, 1.96e-5, 2.2e-5,
      2.48e-5, 2.8e-5, 3.15e-5, 3.52e-5, 3.9e-5, 4.28e-5, 4.69e-5, 5.16e-5,
      5.72e-5, 6.4e-5, 7.23e-5, 8.22e-5, 9.35e-5, 0.000106136, 0.00012,
      0.000134984, 0.000151492, 0.000170208, 0.000191816, 0.000217, 0.000246907,
      0.00028124, 0.00031852, 0.000357267, 0.000396, 0.000433715, 0.000473024,
      0.000517876, 0.000572219, 0.00064, 0.00072456, 0.0008255, 0.00094116,
      0.00106988, 0.00121, 0.001362091, 0.001530752, 0.001720368, 0.001935323,
      0.00218, 0.0024548, 0.002764, 0.0031178, 0.0035264, 0.004, 0.00454624,
      0.00515932, 0.00582928, 0.00654616, 0.0073, 0.008086507, 0.00890872,
      0.00976768, 0.01066443, 0.0116, 0.01257317, 0.01358272, 0.01462968,
      0.01571509, 0.01684, 0.01800736, 0.01921448, 0.02045392, 0.02171824, 0.023,
      0.02429461, 0.02561024, 0.02695857, 0.02835125, 0.0298, 0.03131083,
      0.03288368, 0.03452112, 0.03622571, 0.038, 0.03984667, 0.041768, 0.043766,
      0.04584267, 0.048, 0.05024368, 0.05257304, 0.05498056, 0.05745872, 0.06,
      0.06260197, 0.06527752, 0.06804208, 0.07091109, 0.0739, 0.077016, 0.0802664,
      0.0836668, 0.0872328, 0.09098, 0.09491755, 0.09904584, 0.1033674, 0.1078846,
      0.1126, 0.117532, 0.1226744, 0.1279928, 0.1334528, 0.13902, 0.1446764,
      0.1504693, 0.1564619, 0.1627177, 0.1693, 0.1762431, 0.1835581, 0.1912735,
      0.199418, 0.20802, 0.2171199, 0.2267345, 0.2368571, 0.2474812, 0.2586,
      0.2701849, 0.2822939, 0.2950505, 0.308578, 0.323, 0.3384021, 0.3546858,
      0.3716986, 0.3892875, 0.4073, 0.4256299, 0.4443096, 0.4633944, 0.4829395,
      0.503, 0.5235693, 0.544512, 0.56569, 0.5869653, 0.6082, 0.6293456,
      0.6503068, 0.6708752, 0.6908424, 0.71, 0.7281852, 0.7454636, 0.7619694,
      0.7778368, 0.7932, 0.8081104, 0.8224962, 0.8363068, 0.8494916, 0.862,
      0.8738108, 0.8849624, 0.8954936, 0.9054432, 0.9148501, 0.9237348, 0.9320924,
      0.9399226, 0.9472252, 0.954, 0.9602561, 0.9660074, 0.9712606, 0.9760225,
      0.9803, 0.9840924, 0.9874182, 0.9903128, 0.9928116, 0.9949501, 0.9967108,
      0.9980983, 0.999112, 0.9997482, 1, 0.9998567, 0.9993046, 0.9983255,
      0.9968987, 0.995, 0.9926005, 0.9897426, 0.9864444, 0.9827241, 0.9786,
      0.9740837, 0.9691712, 0.9638568, 0.9581349, 0.952, 0.9454504, 0.9384992,
      0.9311628, 0.9234576, 0.9154, 0.9070064, 0.8982772, 0.8892048, 0.8797816,
      0.87, 0.8598613, 0.849392, 0.838622, 0.8275813, 0.8163, 0.8047947, 0.793082,
      0.781192, 0.7691547, 0.757, 0.7447541, 0.7324224, 0.7200036, 0.7074965,
      0.6949, 0.6822192, 0.6694716, 0.6566744, 0.6438448, 0.631, 0.6181555,
      0.6053144, 0.5924756, 0.5796379, 0.5668, 0.5539611, 0.5411372, 0.5283528,
      0.5156323, 0.503, 0.4904688, 0.4780304, 0.4656776, 0.4534032, 0.4412,
      0.42908, 0.417036, 0.405032, 0.393032, 0.381, 0.3689184, 0.3568272,
      0.3447768, 0.3328176, 0.321, 0.3093381, 0.2978504, 0.2865936, 0.2756245,
      0.265, 0.2547632, 0.2448896, 0.2353344, 0.2260528, 0.217, 0.2081616,
      0.1995488, 0.1911552, 0.1829744, 0.175, 0.1672235, 0.1596464, 0.1522776,
      0.1451259, 0.1382, 0.1315003, 0.1250248, 0.1187792, 0.1127691, 0.107,
      0.1014762, 0.09618864, 0.09112296, 0.08626485, 0.0816, 0.07712064,
      0.07282552, 0.06871008, 0.06476976, 0.061, 0.05739621, 0.05395504,
      0.05067376, 0.04754965, 0.04458, 0.04175872, 0.03908496, 0.03656384,
      0.03420048, 0.032, 0.02996261, 0.02807664, 0.02632936, 0.02470805, 0.0232,
      0.02180077, 0.02050112, 0.01928108, 0.01812069, 0.017, 0.01590379,
      0.01483718, 0.01381068, 0.01283478, 0.01192, 0.01106831, 0.01027339,
      0.009533311, 0.008846157, 0.00821, 0.007623781, 0.007085424, 0.006591476,
      0.006138485, 0.005723, 0.005343059, 0.004995796, 0.004676404, 0.004380075,
      0.004102, 0.003838453, 0.003589099, 0.003354219, 0.003134093, 0.002929,
      0.002738139, 0.002559876, 0.002393244, 0.002237275, 0.002091, 0.001953587,
      0.00182458, 0.00170358, 0.001590187, 0.001484, 0.001384496, 0.001291268,
      0.001204092, 0.001122744, 0.001047, 0.00097659, 0.000911109, 0.000850133,
      0.000793238, 0.00074, 0.000690083, 0.00064331, 0.000599496, 0.000558455,
      0.00052, 0.000483914, 0.000450053, 0.000418345, 0.000388718, 0.0003611,
      0.000335384, 0.00031144, 0.000289166, 0.000268454, 0.0002492, 0.000231302,
      0.000214686, 0.000199288, 0.000185048, 0.0001719, 0.000159778, 0.000148604,
      0.000138302, 0.000128793, 0.00012, 0.00011186, 0.000104322, 9.73e-5,
      9.08e-5, 8.48e-5, 7.91e-5, 7.39e-5, 6.89e-5, 6.43e-5, 6.0e-5, 5.6e-5,
      5.22e-5, 4.87e-5, 4.54e-5, 4.24e-5, 3.96e-5, 3.69e-5, 3.44e-5, 3.21e-5,
      3.0e-5, 2.8e-5, 2.61e-5, 2.44e-5, 2.27e-5, 2.12e-5, 1.98e-5, 1.85e-5,
      1.72e-5, 1.61e-5, 1.5e-5, 1.4e-5, 1.31e-5, 1.22e-5, 1.14e-5, 1.06e-5,
      9.89e-6, 9.22e-6, 8.59e-6, 8.01e-6, 7.47e-6, 6.96e-6, 6.49e-6, 6.05e-6,
      5.64e-6, 5.26e-6, 4.9e-6, 4.57e-6, 4.26e-6, 3.97e-6, 3.7e-6, 3.45e-6,
      3.22e-6, 3.0e-6, 2.8e-6, 2.61e-6, 2.43e-6, 2.27e-6, 2.11e-6, 1.97e-6,
      1.84e-6, 1.71e-6, 1.6e-6, 1.49e-6, 1.39e-6, 1.29e-6, 1.21e-6, 1.12e-6,
      1.05e-6, 9.77e-7, 9.11e-7, 8.49e-7, 7.92e-7, 7.38e-7, 6.88e-7, 6.42e-7,
      5.98e-7, 5.58e-7, 5.2e-7, 4.85e-7, 4.52e-7
};

static const float zBar[NUM_SAMPLES] =
{
    0.0006061, 0.000680879, 0.000765146, 0.000860012, 0.000966593, 0.001086,
      0.001220586, 0.001372729, 0.001543579, 0.001734286, 0.001946, 0.002177777,
      0.002435809, 0.002731953, 0.003078064, 0.003486, 0.003975227, 0.00454088,
      0.00515832, 0.005802907, 0.006450001, 0.007083216, 0.007745488, 0.008501152,
      0.009414544, 0.01054999, 0.0119658, 0.01365587, 0.01558805, 0.01773015,
      0.02005001, 0.02251136, 0.02520288, 0.02827972, 0.03189704, 0.03621,
      0.04143771, 0.04750372, 0.05411988, 0.06099803, 0.06785001, 0.07448632,
      0.08136156, 0.08915364, 0.09854048, 0.1102, 0.1246133, 0.1417017, 0.1613035,
      0.1832568, 0.2074, 0.2336921, 0.2626114, 0.2947746, 0.3307985, 0.3713,
      0.4162091, 0.4654642, 0.5196948, 0.5795303, 0.6456, 0.7184838, 0.7967133,
      0.8778459, 0.959439, 1.0390501, 1.1153673, 1.1884971, 1.2581233, 1.3239296,
      1.3856, 1.4426352, 1.4948035, 1.5421903, 1.5848807, 1.62296, 1.6564048,
      1.6852959, 1.7098745, 1.7303821, 1.74706, 1.7600446, 1.7696233, 1.7762637,
      1.7804334, 1.7826, 1.7829682, 1.7816998, 1.7791982, 1.7758671, 1.77211,
      1.7682589, 1.764039, 1.7589438, 1.7524663, 1.7441, 1.7335595, 1.7208581,
      1.7059369, 1.6887372, 1.6692, 1.6475287, 1.6234127, 1.5960223, 1.564528,
      1.5281, 1.4861114, 1.4395215, 1.3898799, 1.3387362, 1.28764, 1.2374223,
      1.1878243, 1.1387611, 1.090148, 1.0419, 0.9941976, 0.9473473, 0.9014531,
      0.8566193, 0.8129501, 0.7705173, 0.7294448, 0.6899136, 0.6521049, 0.6162,
      0.5823286, 0.5504162, 0.5203376, 0.4919673, 0.46518, 0.4399246, 0.4161836,
      0.3938822, 0.3729459, 0.3533, 0.3348578, 0.3175521, 0.3013375, 0.2861686,
      0.272, 0.2588171, 0.2464838, 0.2347718, 0.2234533, 0.2123, 0.2011692,
      0.1901196, 0.1792254, 0.1685608, 0.1582, 0.1481383, 0.1383758, 0.1289942,
      0.1200751, 0.1117, 0.1039048, 0.09666748, 0.08998272, 0.08384531,
      0.07824999, 0.07320899, 0.06867816, 0.06456784, 0.06078835, 0.05725001,
      0.05390435, 0.05074664, 0.04775276, 0.04489859, 0.04216, 0.03950728,
      0.03693564, 0.03445836, 0.03208872, 0.02984, 0.02771181, 0.02569444,
      0.02378716, 0.02198925, 0.0203, 0.01871805, 0.01724036, 0.01586364,
      0.01458461, 0.0134, 0.01230723, 0.01130188, 0.01037792, 0.009529306,
      0.008749999, 0.0080352, 0.0073816, 0.0067854, 0.0062428, 0.005749999,
      0.0053036, 0.0048998, 0.0045342, 0.0042024, 0.0039, 0.0036232, 0.0033706,
      0.0031414, 0.0029348, 0.002749999, 0.0025852, 0.0024386, 0.0023094,
      0.0021968, 0.0021, 0.002017733, 0.0019482, 0.0018898, 0.001840933, 0.0018,
      0.001766267, 0.0017378, 0.0017112, 0.001683067, 0.001650001, 0.001610133,
      0.0015644, 0.0015136, 0.001458533, 0.0014, 0.001336667, 0.00127, 0.001205,
      0.001146667, 0.0011, 0.0010688, 0.0010494, 0.0010356, 0.0010212, 0.001,
      0.00096864, 0.00092992, 0.00088688, 0.00084256, 0.0008, 0.00076096,
      0.00072368, 0.00068592, 0.00064544, 0.0006, 0.000547867, 0.0004916,
      0.0004354, 0.000383467, 0.00034, 0.000307253, 0.00028316, 0.00026544,
      0.000251813, 0.00024, 0.000229547, 0.00022064, 0.00021196, 0.000202187,
      0.00019, 0.000174213, 0.00015564, 0.00013596, 0.000116853, 0.0001, 8.61e-5,
      7.46e-5, 6.5e-5, 5.69e-5, 5.0e-5, 4.42e-5, 3.95e-5, 3.57e-5, 3.26e-5,
      3.0e-5, 2.77e-5, 2.56e-5, 2.36e-5, 2.18e-5, 2.0e-5, 1.81e-5, 1.62e-5,
      1.42e-5, 1.21e-5, 1.0e-5, 7.73e-6, 5.4e-6, 3.2e-6, 1.33e-6, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
      0.0
}; // Constants

float3 RotateAroundAxis(float3 v, float3 axis, float angle)
{
    axis = safeNormalize(axis);
    float s, c;
    sincos(angle, s, c);
    return v * c + cross(axis, v) * s + axis * dot(axis, v) * (1.0 - c);
}

float4 RotateAroundAxis(float4 v, float4 axis, float angle)
{
    return float4(RotateAroundAxis(v.xyz, axis.xyz, angle), v.w);
}
float3 RotateAroundAxis3(float3 pos, float3 axis, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return pos * c + cross(axis, pos) * s + axis * dot(axis, pos) * (1.0 - c);
}

float4 RotateAroundX(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float4(v.x, c * v.y - s * v.z, s * v.y + c * v.z, v.w);
}

float3 RotateAroundX(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float3(v.x, c * v.y - s * v.z, s * v.y + c * v.z);
}

float2 RotateAroundX(float2 v, float angle)
{
    // v = (y, z)
    float s, c;
    sincos(angle, s, c);
    return float2(c * v.x - s * v.y, s * v.x + c * v.y);
}

float4 RotateAroundY(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float4(c * v.x + s * v.z, v.y, -s * v.x + c * v.z, v.w);
}

float3 RotateAroundY(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float3(c * v.x + s * v.z, v.y, -s * v.x + c * v.z);
}

float2 RotateAroundY(float2 v, float angle)
{
    // v = (x, z)
    float s, c;
    sincos(angle, s, c);
    return float2(c * v.x + s * v.y, -s * v.x + c * v.y);
}

float4 RotateAroundZ(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float4(c * v.x - s * v.y, s * v.x + c * v.y, v.z, v.w);
}

float3 RotateAroundZ(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float3(c * v.x - s * v.y, s * v.x + c * v.y, v.z);
}

float2 RotateAroundZ(float2 v, float angle)
{
    // v = (x, y)
    float s, c;
    sincos(angle, s, c);
    return float2(c * v.x - s * v.y, s * v.x + c * v.y);
}

float4 QuaternionFromAxisAngle(float3 axis, float angle)
{
    float halfAngle = angle * 0.5;
    float s = sin(halfAngle);
    return float4(axis * s, cos(halfAngle));
}

float3 RotateVectorByQuaternion(float3 v, float4 q)
{
    float3 qvec = q.xyz;
    float3 uv = cross(qvec, v);
    float3 uuv = cross(qvec, uv);
    return v + ((uv * q.w) + uuv) * 2.0;
}

float3 RotateVectorByAxisAngle(float3 v, float3 axis, float angle)
{
    float4 q = QuaternionFromAxisAngle(axis, angle);
    return RotateVectorByQuaternion(v, q);
}

static const float MATRIX3X3_EPSILON = 1e-20f;

float Determinant3x3(float3x3 m)
{
    return m._11 * (m._22 * m._33 - m._23 * m._32)
         - m._12 * (m._21 * m._33 - m._23 * m._31)
         + m._13 * (m._21 * m._32 - m._22 * m._31);
}

float3x3 InvertMatrix3x3(float3x3 m)
{
    float det = Determinant3x3(m);
    if (abs(det) < MATRIX3X3_EPSILON)
    {
        return float3x3(1.0f, 0.0f, 0.0f,
                         0.0f, 1.0f, 0.0f,
                         0.0f, 0.0f, 1.0f);
    }

    float invDet = 1.0f / det;

    float3x3 adjugate = float3x3(
        (m._22 * m._33 - m._23 * m._32), -(m._12 * m._33 - m._13 * m._32), (m._12 * m._23 - m._13 * m._22),
        -(m._21 * m._33 - m._23 * m._31), (m._11 * m._33 - m._13 * m._31), -(m._11 * m._23 - m._13 * m._21),
        (m._21 * m._32 - m._22 * m._31), -(m._11 * m._32 - m._12 * m._31), (m._11 * m._22 - m._12 * m._21)
    );

    return adjugate * invDet;
}

struct HSL
{
    float h; // Hue in degrees [0, 360)
    float s; // Saturation [0, 1]
    float l; // Lightness [0, 1]
};

inline HSL RGBToHSL(float3 rgb)
{
    HSL hsl;
    float maxVal = max(rgb.r, max(rgb.g, rgb.b));
    float minVal = min(rgb.r, min(rgb.g, rgb.b));
    float delta = maxVal - minVal;
    
    // Lightness
    hsl.l = (maxVal + minVal) / 2.0f;
    
    // Saturation
    if (delta < 1e-6f)
    {
        hsl.s = 0.0f;
        hsl.h = 0.0f; // Undefined, set to 0
    }
    else
    {
        if (hsl.l < 0.5f)
            hsl.s = delta / (maxVal + minVal);
        else
            hsl.s = delta / (2.0f - maxVal - minVal);
        
        // Hue
        if (maxVal == rgb.r)
        {
            hsl.h = (rgb.g - rgb.b) / delta;
            if (rgb.g < rgb.b)
                hsl.h += 6.0f;
        }
        else if (maxVal == rgb.g)
        {
            hsl.h = 2.0f + (rgb.b - rgb.r) / delta;
        }
        else // maxVal == rgb.b
        {
            hsl.h = 4.0f + (rgb.r - rgb.g) / delta;
        }
        
        hsl.h *= 60.0f; // Convert to degrees
    }
    
    return hsl;
}
inline HSL AdjustHSL(HSL hsl, float hue, float saturation, float lightness)
{
    // Adjust Hue
    hsl.h += fmod(hue, 360);
    
    if (hsl.h >= 360.0f)
    {
        hsl.h -= 360.0f;
    }
    
    if (hsl.h < 0.0f)
        hsl.h += 360.0f;
    
    // Adjust Saturation
    hsl.s *= saturation;
    hsl.s = clamp(hsl.s, 0.0f, 1.0f);
    
    // Adjust Lightness
    hsl.l *= lightness;
    hsl.l = clamp(hsl.l, 0.0f, 1.0f);
    
    return hsl;
}

float HueToRGB(float p, float q, float t)
{
    if (t < 0.0f)
        t += 1.0f;
    if (t > 1.0f)
        t -= 1.0f;
    if (t < 1.0f / 6.0f)
        return p + (q - p) * 6.0f * t;
    if (t < 1.0f / 2.0f)
        return q;
    if (t < 2.0f / 3.0f)
        return p + (q - p) * (2.0f / 3.0f - t) * 6.0f;
    return p;
}

inline float3 HSLToRGB(HSL hsl)
{
    float3 rgb = ZERO3;
    
    if (hsl.s == 0.0f)
    {
        // Achromatic color (gray)
        rgb = float3(hsl.l, hsl.l, hsl.l);
    }
    else
    {
        float q = (hsl.l < 0.5f) ? (hsl.l * (1.0f + hsl.s)) : (hsl.l + hsl.s - hsl.l * hsl.s);
        float p = 2.0f * hsl.l - q;
        float h = hsl.h / 360.0f; // safeNormalize hue to [0,1]
        
        // Helper function to compute RGB component
        
        
        rgb.r = HueToRGB(p, q, h + 1.0f / 3.0f);
        rgb.g = HueToRGB(p, q, h);
        rgb.b = HueToRGB(p, q, h - 1.0f / 3.0f);
    }
    
    return rgb;
}
// Helper functions for the effect
float3 RotateHue(float3 color, float angle)
{
    float sinA, cosA;
    sincos(angle, sinA, cosA);
    
    float3x3 hueRotation = float3x3(0.299 + 0.701 * cosA + 0.168 * sinA, 0.587 - 0.587 * cosA + 0.330 * sinA, 0.114 - 0.114 * cosA - 0.497 * sinA,
        0.299 - 0.299 * cosA - 0.328 * sinA, 0.587 + 0.413 * cosA + 0.035 * sinA, 0.114 - 0.114 * cosA + 0.292 * sinA,
        0.299 - 0.300 * cosA + 1.250 * sinA, 0.587 - 0.588 * cosA - 1.050 * sinA, 0.114 + 0.886 * cosA - 0.203 * sinA
    );
    return mul(hueRotation, color);
}


inline float3 LinearRGBToSRGB(float3 linearRGB)
{
    linearRGB = clamp(linearRGB, EPSILON, 1.0 - EPSILON);
    float3 srgb;
    srgb.x = (linearRGB.x <= 0.0031308) ? (linearRGB.x * 12.92) : (1.055 * pow(linearRGB.x, 1.0 / 2.4) - 0.055);
    srgb.y = (linearRGB.y <= 0.0031308) ? (linearRGB.y * 12.92) : (1.055 * pow(linearRGB.y, 1.0 / 2.4) - 0.055);
    srgb.z = (linearRGB.z <= 0.0031308) ? (linearRGB.z * 12.92) : (1.055 * pow(linearRGB.z, 1.0 / 2.4) - 0.055);
    return saturate(srgb);
}


const static row_major float3x3 XYZtoRGB_Matrix = float3x3(3.2406, -1.5372, -0.4986,
    -0.9689, 1.8758, 0.0415,
    0.0557, -0.2040, 1.0570
);
inline float3 XYZToLinearRGB(float3 xyz)
{
    return mul(XYZtoRGB_Matrix, xyz);
}


const static column_major float3x3 RGBtoXYZ = float3x3(0.4124564, 0.3575761, 0.1804375,
    0.2126729, 0.7151522, 0.0721750,
    0.0193339, 0.1191920, 0.9503041
);
// Compute the inverse matrix M_inv (done outside the shader for performance)
// For illustration, suppose M_inv is calculated as follows:
static const column_major float3x3 XYZ_PRIMARIES_M_inv = InvertMatrix3x3(RGBtoXYZ);

inline float3 LinearRGBToXYZ(float3 linearRGB)
{
    return mul(RGBtoXYZ, linearRGB);
}

inline float2 XYZtoXY(float3 xyz)
{
    float sum = xyz.x + xyz.y + xyz.z;
    // Prevent division by zero
    if (sum > 0.0001f)
    {
        return float2(xyz.x / sum, xyz.y / sum);
    }
    else
    {
        // Default to white if sum is zero
        return float2(0.3127f, 0.3290f); // D65 white point
    }
}


static const float2 DepthRange = float2(EPSILON, DepthScale - EPSILON);


inline float projectDepth(float depth)
{
    return lerp(DepthRange.x, DepthRange.y, saturate(depth));
}


inline float depthRaw(Texture2D<float> depthMap, float2 uv)
{
    float c = clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv, 0), 1e-3, 1.0 - 1e-3);
    
    float lod = depthMap.CalculateLevelOfDetail(sampleTypeLinear, uv);
    float fade = saturate((POM_LOD_FADE_END - lod) /
                           (POM_LOD_FADE_END - POM_LOD_FADE_START));
    
    return c * fade;
}

inline float3 depthRaw3(Texture2D<float> depthMap, float2 uv)
{
    float d =  clamp(depthRaw(depthMap, uv), EPSILON, 1.0-EPSILON);
    return float3(d, d, d);
}

inline float depthRaw(Texture2D<float4> depthNormalMap, float2 uv)
{
    return depthNormalMap.SampleLevel(sampleTypeMirror, uv, 0).w;
}

inline float projectedDepth(Texture2D<float> depthMap, float2 uv)
{
    return projectDepth(depthRaw(depthMap, uv));
}

inline float depthRawRT(Texture2D<float4> depthRT, float2 uv, int axis)
{
    return depthRT.SampleLevel(sampleTypeMirror, uv, 0)[clamp(axis, 0, 2)];
}

inline float projectedDepthRT(Texture2D<float4> depthMap, float2 uv, int axis)
{
  // Removed the cosine term, as its purpose was unclear
    return projectDepth(depthRawRT(depthMap, uv, clamp(axis, 0, 2)));
}

// **Mirror 2D Function**
// =====================
inline float4 mir2D(Texture2D<float4> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0);
}
inline float4 mir2D(Texture2D<float3> tex, float2 uv)
{
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1.0);
}

inline float ColorLuminance(float3 color)
{
    return dot(color, float3(0.299, 0.587, 0.114));
}




float3 noise3(Texture2D<float3> noiseMap,
    float3 n,
    float scalarUV = 1.0,
    float scalarZ = 1.0
)
{
    float2 oosz = GetOosz(noiseMap);
    float2 sz = GetSz3(noiseMap);
    // Calculate sample coordinates with varying frequency for each noise layer
    float2 sampleCoord1 = (n.xy * scalarUV + scalarUV/(n.z * scalarZ)) ;
    float2 sampleCoord2 = (n.xy * scalarUV + scalarUV/(n.z * scalarZ * scalarZ)) ;
    float2 sampleCoord3 = (n.xy * scalarUV + scalarUV/(n.z * scalarZ * scalarZ * scalarZ)) ;

    // Sample the noise textures at the calculated coordinates
    float3 v = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord1, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v2 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord2, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v3 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord3, 0).xyz, EPSILON3, OneMinusEPSILON3);
    
    return safeNormalize(v * TWO3 - ONE3+v2 * TWO3 - ONE3+v3 * TWO3 - ONE3);
}

// Converts an HSV color to RGB. Hue in degrees; any finite value is wrapped into [0,360).
float4 HSVtoRGB(float4 hsv)
{
    float h = hsv.x;
    float s = hsv.y;
    float v = hsv.z;
    if (s == 0.0f)
        return float4(v, v, v, 1.0);

    h = fmod(fmod(h, 360.0f) + 360.0f, 360.0f) / 60.0f; // [0,6), handles negatives
    int i = min(int(floor(h)), 5);                      // guards h rounding up to 6.0
    float f = h - float(i);
    float p = v * (1.0f - s);
    float q = v * (1.0f - s * f);
    float t = v * (1.0f - s * (1.0f - f));

    if (i == 0) return float4(v, t, p, 1.0);
    if (i == 1) return float4(q, v, p, 1.0);
    if (i == 2) return float4(p, v, t, 1.0);
    if (i == 3) return float4(p, q, v, 1.0);
    if (i == 4) return float4(t, p, v, 1.0);
    return float4(v, p, q, 1.0);
}

// Converts an RGB color to HSV. H in degrees [0,360), S and V in [0,1] for in-range input.
float3 RGBtoHSV(float3 rgb)
{
    float R = rgb.r;
    float G = rgb.g;
    float B = rgb.b;
    float maxC  = max(R, max(G, B));
    float minC  = min(R, min(G, B));
    float delta = maxC - minC;          // not clamped: the gray test below must be able to fire

    float H = 0.0;
    if (delta > EPSILON)
    {
        if (maxC == R)
        {
            float x = (G - B) / delta;  // in [-1,1]
            H = 60.0 * ((x < 0.0) ? x + 6.0 : x);   // magenta/pink (300-360) preserved
        }
        else if (maxC == G)
            H = 60.0 * ((B - R) / delta + 2.0);
        else
            H = 60.0 * ((R - G) / delta + 4.0);
    }

    float S = (maxC > EPSILON) ? (delta / maxC) : 0.0; // black -> S=0
    return float3(H, S, maxC);
}

// Rotates the hue of an RGB color by a given angle (degrees). Alpha is preserved.
inline float4 rotateHue(float4 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB.xyz), 1.0);
    hsv.x = fmod(hsv.x + angle, 360.0f);   // may be negative; HSVtoRGB wraps it
    float4 o = HSVtoRGB(hsv);
    o.a = colorRGB.a;
    return o;
}

// Rotates the hue of an RGB color by a given angle (degrees).
inline float3 rotateHue(float3 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB), 1.0);
    hsv.x = fmod(hsv.x + angle, 360.0f);   // may be negative; HSVtoRGB wraps it
    return HSVtoRGB(hsv).rgb;
}
inline float2 PixelPitchM(Texture2D<float> depthMap)
{
    float2 resPx = GetSz1(depthMap).xy;
    float2 worldSizeM = abs(HOLOGRAM_SIZE_M);
    return worldSizeM / max(resPx, EPSILON2);
}
inline float BilateralW(float dc, float dn, float thresh)
{
    float x = (dn - dc) / max(thresh, EPSILON);
    return exp2(-x*x * 3.0);
}
// depthRawVal: 0 = far, 1 = near - your convention
inline float3 UVDepthToMetersM(float2 uv, float depthRawVal, float2 pitchM)
{
    // pitchM is unused - kept for signature compat.
    float2 worldSizeM = abs(HOLOGRAM_SIZE_M);
    float2 xyM = (uv - 0.5) * worldSizeM;
    // z is distance from the near plane: near (1) = 0 m, far (0) = worldSize.
    // Code unchanged; the old comment said the opposite.
    float zM = (depthRawVal) * max(worldSizeM.x, worldSizeM.y);
    return float3(xyM, zM);
}

float3x3 CalcTangentToWorld(Texture2D<float> depthMap, float2 uv, float radius = 1.0)
{
    float2 invRes = GetOosz(depthMap);
    float2 du = float2(invRes.x, 0);
    float2 dv = float2(0, invRes.y);

    float dC = projectedDepth(depthMap, uv);
    float dR = projectedDepth(depthMap, uv + du);
    float dL = projectedDepth(depthMap, uv - du);
    float dU = projectedDepth(depthMap, uv + dv);
    float dD = projectedDepth(depthMap, uv - dv);
    
    float t = max(0.02 * f7, 0.005) * DepthScale;
    float wR = BilateralW(dC, dR, t); float wL = BilateralW(dC, dL, t);
    float wU = BilateralW(dC, dU, t); float wD = BilateralW(dC, dD, t);

    // All five positions raw; radius is forwarded in the (ignored) pitchM slot as before.
    float3 posC = UVDepthToMetersM(uv,      dC, radius);
    float3 posR = UVDepthToMetersM(uv + du, dR, radius);
    float3 posL = UVDepthToMetersM(uv - du, dL, radius);
    float3 posU = UVDepthToMetersM(uv + dv, dU, radius);
    float3 posD = UVDepthToMetersM(uv - dv, dD, radius);

    // Signed central differences (no abs: slope direction must survive).
    float3 edgeX = (posR - posL) * 0.5;
    float3 edgeY = (posU - posD) * 0.5;

    // Depth discontinuity: one-sided difference on the side that agrees with the center.
    if (wR < 0.1 || wL < 0.1) edgeX = (wR > wL) ? (posR - posC) : (posC - posL);
    if (wU < 0.1 || wD < 0.1) edgeY = (wU > wD) ? (posU - posC) : (posC - posD);

    // edgeX ~ +x, edgeY ~ +y, so cross(edgeX, edgeY) has +z for a flat surface.
    float3 N = normalize(cross(edgeX, edgeY));
    //if (N.z < 0)N = -N; // guard only; no longer expected to fire
    
    N.z = N.z;
   
    float3 T = normalize(edgeX - N * dot(edgeX, N));
    float3 B = cross(N, T);

    return float3x3(T, B, N);
}


float3 CalcNormal(Texture2D<float> depthMap, float2 uv, int radius = 1)
{
    float3x3 TBN = CalcTangentToWorld(depthMap, uv, float(radius));
    return TBN[2];
}


// Optimized noise - your old one called CalcNormal inside noise = 300 samples
inline float3 noiseFast013(float3 v)
{
    float3 p = frac(v * 0.173);
    p += dot(p, p.yzx + 33.33);
    return frac((p.xxy + p.yzz) * p.zyx);
}




float3 XYZToWavelength(float3 xyz)
{
    float3 rgb = XYZToLinearRGB(xyz);
   
    HSL hsl = RGBToHSL(rgb);
    
    hsl = AdjustHSL(hsl, 10.0, 2.0, 1.6);
    rgb = HSLToRGB(hsl);
   
    xyz = mul(RGBtoXYZ, rgb);
    
    // Perform the XYZ to Wavelengths (Red, Green, Blue) conversion
    float3 wavelengths = mul((XYZ_PRIMARIES_M_inv), xyz.xyz);

    // Clamp the wavelength intensities to [0, 1] to ensure valid output
    wavelengths = saturate(wavelengths);
    float3 oo = float3(wavelengths.x > 0.0 ? 1.0 : 0.0, wavelengths.y > 0.0 ? 1.0 : 0.0, wavelengths.z > 0.0 ? 1.0 : 0.0);
    return (wavelengths * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
}

float3 RGBToWavelengthsNM(float3 srgb)
{
    srgb = clamp(srgb, 0.001, 0.999);
    
    // Convert sRGB to linear RGB
    float3 linearRGB = SRGBToLinear(srgb);
    
    // Convert linear RGB to XYZ
    float3 XYZ = LinearRGBToXYZ(linearRGB);
    float3 best = XYZToWavelength(XYZ);
    
    return best;
}


inline float3 normal2D4(Texture2D<float4> normalMap, float2 uv)
{
    return safeNormalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz * 2.0 - 1.0);
}
inline float3 normal2D(Texture2D<float3> normalMap, float2 uv)
{
    return safeNormalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz * 2.0 - 1.0);
}




inline float WrapPhase(float phase)
{
    return frac(phase / TWOPI) * TWOPI;
}
inline float2 WrapPhase(float2 phase)
{
    return frac(phase / TWOPI2) * TWOPI2;
}
inline float3 WrapPhase(float3 phase)
{
    return frac(phase / TWOPI3) * TWOPI3;
}
inline float4 WrapPhase(float4 phase)
{
    return frac(phase / TWOPI4) * TWOPI4;
}



inline float3 GetChromaticity(int index)
{
    return moilerp(MIN_CHROMATICITY, MAX_CHROMATICITY, MIN_CHROMATICITY + CHROMATICITY_RANGE * float(1 + index) / SPECTRAL_LOCUS_COUNT);
    //float2(0.1741, 0.0050)//float2(0.0842, 0.0420), // 830nm
}



inline float addOver02(float2 v)
{
    int cnt = 0;
    float sum = 0.0;
    if (v.x > 0.0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0.0)
    {
        cnt++;
        sum += v.y;
    }
   
    if (cnt > 0)
        return sum / max(float(cnt), EPSILON);
    else
        return 0.0;
}



inline float addOver03(float3 v)
{
    int cnt = 0;
    float sum = 0.0;
    if (v.x > 0.0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0.0)
    {
        cnt++;
        sum += v.y;
    }
    if (v.z > 0.0)
    {
        cnt++;
        sum += v.z;
    }
    if (cnt > 0)
        return sum / max(float(cnt), EPSILON);
    return 0.0;
}

inline float addOver04(float4 v)
{
    int cnt = 0;
    float sum = 0.0;
    if (v.x > 0.0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0.0)
    {
        cnt++;
        sum += v.y;
    }
    if (v.z > 0.0)
    {
        cnt++;
        sum += v.z;
    }
    if (v.w > 0.0)
    {
        cnt++;
        sum += v.w;
    }
    return cnt > 0 ? sum / max(float(cnt), EPSILON) : 0.0;
}

inline float3 AddOver0(float3 v1, float3 v2, float3 v3)
{
    return float3(addOver03(float3(v1.x, v2.x, v3.x)),
        addOver03(float3(v1.y, v2.y, v3.y)),
        addOver03(float3(v1.z, v2.z, v3.z)));
}

inline float4 addOver0(float4 v1, float4 v2, float4 v3)
{
    return float4(addOver03(float3(v1.x, v2.x, v3.x)),
        addOver03(float3(v1.y, v2.y, v3.y)),
        addOver03(float3(v1.z, v2.z, v3.z)),
        addOver03(float3(v1.w, v2.w, v3.w)));
}

inline float2 AddOver0(float2 v1, float2 v2)
{
    return float2(addOver02(float2(v1.x, v2.x)),
        addOver02(float2(v1.y, v2.y)));
}
inline float3 AddOver0(float3 v1, float3 v2)
{
    return float3(addOver02(float2(v1.x, v2.x)),
        addOver02(float2(v1.y, v2.y)),
        addOver02(float2(v1.z, v2.z)));
}
inline float4 AddOver0(float4 v1, float4 v2)
{
    return float4(addOver02(float2(v1.x, v2.x)),
        addOver02(float2(v1.y, v2.y)),
        addOver02(float2(v1.z, v2.z)),
        addOver02(float2(v1.w, v2.w)));
}

inline float ChromaticityDistance(float2 a, float2 b)
{
    float dx = (a.x - b.x);
    float dy = (a.y - b.y);
   
    // Use a perceptual weighting, e.g., weigh y-axis more due to its perceptual importance
    return (dx * dx + 1.5f * dy * dy);
}

inline float GetChromaWavelengthNM(int index)
{
    return MIN_WAVELENGTH + index;
}

inline float3 RGBToWavelengths(float3 srgb)
{
    float3 linearRGB = clamp(SRGBToLinear(srgb), EPSILON3, OneMinusEPSILON3);
    float3 oo = float3(srgb.x > EPSILON ? OneMinusEPSILON : EPSILON, srgb.y > EPSILON ? OneMinusEPSILON : EPSILON, srgb.z > EPSILON ? OneMinusEPSILON : EPSILON);
    return (linearRGB * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
}

float CIE_Lobe(float l, float mu, float s1, float s2)
{
    float t = (l - mu) / ((l < mu) ? s1 : s2);
    return clamp(saturate(exp(-0.5 * t * t)), 0.0000001, 1.0);
}

float CIE_xbar(float l)
{
    l = clamp(l, 1., 1000.);
    return 1.056 * CIE_Lobe(l, 599.8, 37.9, 31.0)
         + 0.362 * CIE_Lobe(l, 442.0, 16.0, 26.7)
         - 0.065 * CIE_Lobe(l, 501.1, 20.4, 26.2);
}

float CIE_ybar(float l)
{
    l = clamp(l, 1., 1000.);
    return 0.821 * CIE_Lobe(l, 568.8, 46.9, 40.5)
         + 0.286 * CIE_Lobe(l, 530.9, 16.3, 31.1);
}

float CIE_zbar(float l)
{
    l = clamp(l, 1., 1000.);
    return 1.217 * CIE_Lobe(l, 437.0, 11.8, 36.0)
         + 0.681 * CIE_Lobe(l, 459.0, 26.0, 13.8);
}


inline float3 WavelengthToLinearRGB1(float lamNM)
{
    float3 xyz = float3(CIE_xbar(lamNM), CIE_ybar(lamNM), CIE_zbar(lamNM));
    return saturate(XYZToLinearRGB(xyz)) + SPECTRAL_AMBIENT;
}

float3 WavelengthsToRGB(float3 wavelengthsNM)
{
    float3 l = clamp(wavelengthsNM, MIN_WAVELENGTH, MAX_WAVELENGTH);
    return float3(WavelengthToLinearRGB1(l.x).x,
                  WavelengthToLinearRGB1(l.y).y,
                  WavelengthToLinearRGB1(l.z).z);
}
inline float3 XYZToLinearRGB2(float3 XYZ)
{
    return XYZToLinearRGB(XYZ);
}

#define CIE_TABLE_START_NM 360.0
inline float3 WavelengthToXYZ(float wavelength)
{
    wavelength = clamp(wavelength, MIN_WAVELENGTH, MAX_WAVELENGTH);
    int t = clamp(int(round(wavelength - CIE_TABLE_START_NM)), 0, NUM_SAMPLES - 1);
    return float3(xBar[t], yBar[t], zBar[t]);
}


float3 WavelengthToXYZ(float3 wavelength1)
{
    float3 x1 = WavelengthToXYZ(wavelength1.x);
    float3 x2 = WavelengthToXYZ(wavelength1.y);
    float3 x3 = WavelengthToXYZ(wavelength1.z);
    return (x1 + x2 + x3);
}

float3 XYZToLinearRGB(float3 XYZ0, float3 XYZ1, float3 XYZ2)
{
     // Use XYZ to RGB conversion matrix
    int3 cnt = 0;
    float3 RGB = ZERO3;
    float3 l1 = XYZToLinearRGB(XYZ0);
    float3 l2 = XYZToLinearRGB(XYZ1);
    float3 l3 = XYZToLinearRGB(XYZ2);
   
    return AddOver0(l1, l2, l3);
}







// ------------------------------------------------------------
// PHYSICALLY CORRECT OPTICAL PATH DIFFERENCE
// ------------------------------------------------------------
float ComputeOpticalPathM(float thicknessM, float nFilm, float cosThetaT)
{
    // ΔL = 2 * nFilm * t * cos(theta_t)
    return 2.0 * nFilm * thicknessM * cosThetaT;
}


// Planckian radiator approx for white light reconstruction
float3 SpectralPower(float3 lambdaNM, float temperatureK)
{
    float3 lambdaM = nmToM(lambdaNM);
    float h = 6.626e-34;
    float c = 3.0e8;
    float k = 1.381e-23;
    float3 hc_over_lkT = (h * c) / (lambdaM * k * temperatureK);
    // Wien's approximation (valid for visible at T < 10000K)
    return (2.0 * h * c * c) / (pow(lambdaM, 5.0) * exp(hc_over_lkT));
}

void SampleSpectrum(float2 uv, float3 wavelengthsNM, float seed, out Wavefront samples[SPECTRAL_COUNT])
{
    float3 mask = float3(wavelengthsNM.x > 0.0 ? 1.0 : 0.0,
                         wavelengthsNM.y > 0.0 ? 1.0 : 0.0,
                         wavelengthsNM.z > 0.0 ? 1.0 : 0.0);
    float3 wts = float3(0.299, 0.587, 0.114) * mask;
    float wSum = wts.x + wts.y + wts.z;
    float dominantNM = (wSum > EPSILON) ? dot(wavelengthsNM, wts) / wSum : 550.0;

    float3 wLo = lerp(float3(1e4, 1e4, 1e4), wavelengthsNM, mask);
    float loNM = min(wLo.x, min(wLo.y, wLo.z));
    float hiNM = max(wavelengthsNM.x * mask.x, max(wavelengthsNM.y * mask.y, wavelengthsNM.z * mask.z));
    float spreadNM = ((wSum > EPSILON) ? (hiNM - loNM) * 0.5 : 0.0) + 20.0;

    float temperatureK = lerp(7500.0, 3000.0, saturate((dominantNM - MIN_WAVELENGTH) / WAVELENGTH_RANGE));

    [loop]
    for (int i = 0; i < SPECTRAL_COUNT; ++i)
    {
        float t = (float(i) + 0.5) / float(SPECTRAL_COUNT);
        float jitter = frac(sin(dot(float2(t, seed), float2(12.9898, 78.233))) * 43758.5453);
        float lambdaNM = clamp(dominantNM + spreadNM * (t + jitter * 0.8 - 0.9), MIN_WAVELENGTH, MAX_WAVELENGTH);
        float3 lambda3 = float3(lambdaNM, lambdaNM, lambdaNM);

        samples[i].color = WavelengthsToRGB(lambda3);
        samples[i].wavelengthMeters = nmToM(lambda3);
        samples[i].amplitude = SpectralPower(lambda3, temperatureK);
        samples[i].phase = frac(sin(dot(float3(uv, seed + float(i) * 0.618),
            float3(43.123, 21.431, 9.132))) * 31415.92653) * TWO_PI;
    }
}

// ---------------------------------------------------------------------------
// Partial Temporal Coherence (Michelson visibility)
// ---------------------------------------------------------------------------
float3 TemporalCoherenceEnvelope(float3 opticalPathDiffM, float3 coherenceLengthM)
{
    if (length(coherenceLengthM) < 1e-9) return ONE3; // Incoherent limit
    
    float3 x = opticalPathDiffM / coherenceLengthM;
    // Gaussian spectral profile visibility
    return exp(-x * x * 0.5);
}
float2 KogelnikDiffractionEfficiency(
    float lambdaM,
    float thetaObject,
    float thetaReference,
    float thicknessM,
    float dn,
    float n0,
    float polarizationAngle
)
{
    float beta = TWO_PI * n0 / lambdaM;
    float kappa = PI * dn / lambdaM;
    float sp = sin(polarizationAngle);
    float polFactor = lerp(1.0, cos(thetaObject + thetaReference), sp * sp);
    kappa *= polFactor;

    float deltaTheta = thetaObject - thetaReference;
    float xi = deltaTheta * beta * thicknessM * sin(thetaReference);

    float v = kappa * thicknessM;
    float sqrtTerm = sqrt(xi * xi + v * v + 0.000001);
    float sr = sin(sqrtTerm);

    float eta = (sr * sr) / (1.0 + xi * xi / (v * v + 0.000001));
    float orderSuppression = exp(-thicknessM * 1000.0 * abs(deltaTheta));

    return float2(eta * orderSuppression, 1.0 - eta);
}


// ---------------------------------------------------------------------------
// Speckle pattern generation (Goodman's model)
// ---------------------------------------------------------------------------
float3 SpeckleContrast(float meanIntensity, float surfaceRoughnessM, float3 lambdaM)
{
    float3 k = TWO_PI / lambdaM;
    float3 sigmaPhi = k * surfaceRoughnessM;
    // For fully developed speckle: contrast = 1.0
    // Partially developed: reduced contrast
    return 1.0 - exp(-sigmaPhi * sigmaPhi);
}


float3 GenerateSpeckleField(
    float2 uv,
    float3 baseField,
    float roughnessM,
    float3 lambdaM,
    float seed
)
{
    float3 contrast = SpeckleContrast(ColorLuminance(baseField), roughnessM, lambdaM);

    float2 noiseUV = uv * 512.0 + frac(seed * 0.6180339887) * 100.0;
    float theta1 = frac(sin(dot(noiseUV, float2(127.1, 311.7))) * 43758.5453) * TWO_PI;
    float theta2 = frac(sin(dot(noiseUV + 0.5, float2(269.5, 183.3))) * 43758.5453) * TWO_PI;

    float u1 = frac(sin(dot(noiseUV, float2(17.0, 43.0))) * 43758.5453);
    float radius = sqrt(-2.0 * log(max(u1, 0.0001)));
    float gaussReal = radius * cos(theta1);
    float gaussImag = radius * sin(theta1);

    float speckleAmp = sqrt(max(gaussReal * gaussReal + gaussImag * gaussImag, 0.0));
    float3 speckleAmplitude = lerp(ONE3, float3(speckleAmp, speckleAmp, speckleAmp), contrast);
    speckleAmplitude = max(speckleAmplitude, float3(SPECKLE_AMP_FLOOR, SPECKLE_AMP_FLOOR, SPECKLE_AMP_FLOOR));

    float3 specklePhase = theta2 * contrast;
    float3 temporal = 0.5 + 0.5 * cos(time + specklePhase + float3(0.0, 0.3, 0.6));
    temporal = lerp(float3(SPECKLE_AMP_FLOOR, SPECKLE_AMP_FLOOR, SPECKLE_AMP_FLOOR), ONE3, temporal);

    return baseField * speckleAmplitude * temporal;
}


inline float HoloEta(float2 e, float vis)
{
    return lerp(HOLO_ETA_FLOOR, 1.0, saturate(e.x)) * lerp(HOLO_ETA_FLOOR, 1.0, saturate(vis));
}
float3 ReconstructHologram(float2 uv,
    float3 normalTS,
    float3 pixelPosM,
    float3 viewPosM,
    float3 lightPosM,
    float3 wavelengthsNM,
    float coherenceLengthM,
    float fringeScale,
    float thicknessMM,
    float dn,
    float seed,
    float spreadNM)
{
    
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, NormalRadius);

    float3 reconDir = safeNormalize(lightPosM - pixelPosM);
    float3 objectDir = normalize(-pixelPosM);

    float thicknessM = mmToM(thicknessMM);
    float thetaRef = acos(saturate(dot(reconDir, normalTS)));
    float thetaObj = 0;

    Wavefront spectrum[SPECTRAL_COUNT];
    SampleSpectrum(uv, wavelengthsNM, seed, spectrum);

    float3 accumulated = 0;
    float3 totalWeight = 0;
    float opd = dot(pixelPosM, objectDir - reconDir);
    float3 viewDir = normalize(pixelPosM - viewPosM);
    [loop]
    for (int s = 0; s < SPECTRAL_COUNT; ++s)
    {
        float3 lambdaM = spectrum[s].wavelengthMeters;
        float3 k = TWO_PI / lambdaM;
        float3 visibility = TemporalCoherenceEnvelope(opd, coherenceLengthM);

        float2 efficiencyX = KogelnikDiffractionEfficiency(lambdaM.x, thetaObj, thetaRef, thicknessM, dn, AVERAGE_REFRACTIVE_INDEX, (opd) * visibility.x * max(0.0, dot(viewDir, normalTS)));
        float2 efficiencyY = KogelnikDiffractionEfficiency(lambdaM.y, thetaObj, thetaRef, thicknessM, dn, AVERAGE_REFRACTIVE_INDEX, (opd) * visibility.y * max(0.0, dot(viewDir, normalTS)));
        float2 efficiencyZ = KogelnikDiffractionEfficiency(lambdaM.z, thetaObj, thetaRef, thicknessM, dn, AVERAGE_REFRACTIVE_INDEX, (opd) * visibility.z * max(0.0, dot(viewDir, normalTS)));
        float3 eta = float3(HoloEta(efficiencyX, visibility.x),
                            HoloEta(efficiencyY, visibility.y),
                            HoloEta(efficiencyZ, visibility.z));

        float3 orderColor = 0;
        [loop]
        for (int m = -MAX_DIFFRACTION_ORDERS; m <= MAX_DIFFRACTION_ORDERS; ++m)
        {
            float ow = (m == 1) ? 1.0 : 0.1 / (1.0 + abs(float(m - 1)) * 2.0);
            float3 phase = float(m) * k * opd + spectrum[s].phase;
            float3 interf = lerp(float3(0.5, 0.5, 0.5), 0.5 + 0.5 * cos(phase + time), saturate(fringeScale));
            float3 rgb = WavelengthsToRGB(mToNm(lambdaM));
            orderColor += rgb * interf * eta * ow;
        }

        orderColor = GenerateSpeckleField(uv, orderColor, 0.5e-6, lambdaM, seed + float(s));
        accumulated += orderColor * spectrum[s].amplitude;
        totalWeight += spectrum[s].amplitude;
    }
    return accumulated / max(totalWeight, float3(EPSILON, EPSILON, EPSILON));
}



// Function to compute rainbow colors based on an input value
float3 rainbowColor(float value)
{
    float3 color;
    color.r = sin(TWOPI * value + 0.0) * 0.5 + 0.5;
    color.g = sin(TWOPI * value + 2.0 / 3.0 * PI) * 0.5 + 0.5;
    color.b = sin(TWOPI * value + 4.0 / 3.0 * PI) * 0.5 + 0.5;
    return color;
}

float3 ChromaticAberration(Texture2D<float4> diffuseMap, float2 uv, float radius, float3 viewDir = float3(0.0, 0.0, -1.0), float3 particleNormal = float3(0.0, 0.0, 1.0))
{
    float2 oosz = GetOosz(diffuseMap);
    float3 tint = 0.5 + rainbowColor(dot(viewDir, particleNormal));
    float r = diffuseMap.SampleLevel(sampleTypeMirror, float2(uv + oosz * float2(radius, 0.0)), 0).r * tint.r;
    float g = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).g * tint.g;
    float b = diffuseMap.SampleLevel(sampleTypeMirror, float2(uv - oosz * float2(radius, 0.0)), 0).b * tint.b;
    return float3(r, g, b);
}

#define HOLO_RELIEF_M       2e-6
#define FRINGE_VISIBILITY   0.6
#define PSI_NDOTL_FLOOR     0.15
#define PSI_EYE_HEIGHT      1.5

float4 PS_Interference(PS_INPUT input) : SV_Target
{
    float2 uv = input.uv;
    const float2 sizeM = max(abs(HOLOGRAM_SIZE_M), EPSILON2);

    float depthVal = projectedDepth(depthMap, uv);
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, NormalRadius);

    float3 normalTS = normalize(tangentToWorld[2]);
    float2 pitchM = PixelPitchM(depthMap);
    float3 pixelPosM = UVDepthToMetersM(uv, depthVal, pitchM);

    float3 viewPosW = float3((float2(ViewX, ViewY) - 0.5) * sizeM, -PSI_EYE_HEIGHT * DepthScale);
    float3 lightPosW = float3((float2(SunX, SunY) - 0.5) * sizeM, -max(SunZ, 0.05) * DepthScale);

    float3 tbnViewPos = mul(tangentToWorld, viewPosW - pixelPosM);
    float3 tbnLightPos = mul(tangentToWorld, lightPosW - pixelPosM);
    float3 tbnPixelPos = float3(0.0, 0.0, saturate(depthVal / DepthScale) * HOLO_RELIEF_M);

    float3 pixelDiffuse = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).rgb;
    float3 baseWavelengths = RGBToWavelengthsNM(pixelDiffuse);

    float coherenceLengthM = f12;
    float3 fringeScale = float3(FRINGE_VISIBILITY, FRINGE_VISIBILITY, FRINGE_VISIBILITY);

    float3 hologram = ReconstructHologram(uv, normalTS,
        tbnPixelPos, tbnViewPos, tbnLightPos,
        baseWavelengths, coherenceLengthM, fringeScale.x,
        VOLUME_HOLOGRAM_THICKNESS_MM, REFRACTIVE_INDEX_MODULATION, SPECKLE_SEED, f11);

    float3 lightDirW = safeNormalize(lightPosW - pixelPosM);
    float NdotL = max(saturate(dot(normalTS, lightDirW)), PSI_NDOTL_FLOOR);

    float3 baseColor = pixelDiffuse * NdotL;
    float3 finalColor = lerp(baseColor, hologram, NdotL);

    if (PassNum > 0)
    {
        float3 disp = abs(f11 * saturate(depthVal / DepthScale)) * fringeScale;
        finalColor += ChromaticAberration(rtMap1, uv, NormalRadius, disp) * f9;
    }

    finalColor = finalColor * (1.051 * finalColor + 0.03) / (finalColor * (0.43 * finalColor + 0.59) + 0.14);
    return float4(saturate(finalColor), 1.0);
}


float3 FresnelTriAxis(float3 nTS, float3 vTS, float3 F0)
{
    float cosTheta = saturate(dot(nTS, vTS));
    return F0 + (1.0-F0)*pow(1.0-cosTheta, FresnelPower);
}
float3 FresnelReflectanceTriAxis(float3 nTS, float3 vTS, float3 F0)
{
    float cosTheta = saturate(dot(nTS, vTS));
    return F0 + (1.0-F0)*pow(1.0-cosTheta, FresnelReflectance);
}
float3 SpectralInterferenceTensor(
    float2 uv, Wavefront samples[SPECTRAL_COUNT], float thickM, float nFilm, float3 viewDirWS, float3 normalTS, float cosThetaT)
{
    float opd = ComputeOpticalPathM(thickM, nFilm, cosThetaT);
    float3 base = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz;
    float3 lambdaM = max(nmToM(RGBToWavelengthsNM(base)), float3(1e-9, 1e-9, 1e-9));
    float3 phi = (TWO_PI * opd) / lambdaM;
    float pol = saturate(dot(normalTS, viewDirWS));
    HSL h = RGBToHSL(base);

    float3 ampSum = float3(EPSILON, EPSILON, EPSILON);
    [loop]
    for (int a = 0; a < SPECTRAL_COUNT; ++a)
        ampSum += samples[a].amplitude;

    float3 accum = ZERO3;
    [loop]
    for (int i = 0; i < SPECTRAL_COUNT; ++i)
    {
        float3 w = samples[i].amplitude / ampSum;
        float3 hueDeg = sin(phi + time + samples[i].phase) * (1.0 - pol) * 180.0;
        accum.x += HSLToRGB(AdjustHSL(h, hueDeg.x, 1.0, 1.0)).x * w.x;
        accum.y += HSLToRGB(AdjustHSL(h, hueDeg.y, 1.0, 1.0)).y * w.y;
        accum.z += HSLToRGB(AdjustHSL(h, hueDeg.z, 1.0, 1.0)).z * w.z;
    }
    return accum;
}


struct PomResult
{
    float4 color;
    float2 uv;
    float3 normalWS;
    float3 normalTS;
    float shadow;
    float hitDepth;
    float3 probe;
    float ao;
};

float PomIGN(float2 p)
{
    return frac(52.9829189 * frac(dot(p, float2(0.06711056, 0.00583715))));
}

float PomDepth(float2 uv, float2 dx, float2 dy)
{
    float d = depthMap.SampleGrad(sampleTypeMirror, uv, dx, dy);
#if POM_DEPTH_IS_HEIGHT
    d = 1.0 - d;
#endif
    return d;
}

float PomAO(float2 uvH, float dHit, float dScale, float jit, float2 px, float2 dx, float2 dy)
{
    float acc = 0.0;
    [loop]
    for (int a = 0; a < POM_AO_DIRS; ++a)
    {
        float ang = (float(a) + jit) * (TWO_PI / float(POM_AO_DIRS));
        float2 dir = float2(cos(ang), sin(ang));
        float horizon = 0.0;
        [loop]
        for (int r = 1; r <= POM_AO_RADII; ++r)
        {
            float2 off = dir * px * (float(r) * POM_AO_TEXELS);
            float dh = (dHit - PomDepth(uvH + off, dx * 8.0, dy * 8.0)) * dScale;
            float dist2 = dot(off, off);
            horizon = max(horizon, (dh > 0.0) ? dh * dh / (dh * dh + dist2) : 0.0);
        }
        acc += horizon;
    }
    return 1.0 - saturate(POM_AO_STRENGTH * acc / float(POM_AO_DIRS));
}

PomResult ParallaxOcclusion(float2 uv0, float2 svPos, float3 normalTS, float3 viewDirTS, float3 lightDirTS, float3x3 tangentToWorld, float3 viewDirWS, float3 lightDirWS)
{
    float2 dx = ddx(uv0), dy = ddy(uv0);

    float3 V = normalize(viewDirTS);
    float3 L = normalize(lightDirTS);
    float vz = max(V.z, POM_MIN_COS);

    float lod = depthMap.CalculateLevelOfDetailUnclamped(sampleTypeLinear, uv0);
    float fade = saturate((POM_LOD_FADE_END - lod) / (POM_LOD_FADE_END - POM_LOD_FADE_START));
    float dScale = DepthScale * fade;

    float2 rayUV = -V.xy / vz * dScale;

    float jit = PomIGN(svPos);
#if POM_TEMPORAL
    jit = frac(jit + 0.6180339887 * fmod(floor(time * 60.0), 64.0));
#endif

    float2 szT;
    depthMap.GetDimensions(szT.x, szT.y);
    uint N = (uint) clamp(ceil(length(rayUV * szT)), (float) POM_MIN_STEPS, (float) POM_MAX_STEPS);

    float invN = rcp((float) N);

    float dLo = 0.0, fLo = -PomDepth(uv0, dx, dy);
    float dHi = 1.0, fHi = 0.0;

    [loop]
    for (uint i = 0; i <= N; ++i)
    {
        float d = saturate((i + 1.0 - jit) * invN);
        float f = d - PomDepth(uv0 + rayUV * d, dx, dy);
        if (f >= 0.0)
        {
            dHi = d;
            fHi = f;
            break;
        }
        dLo = d;
        fLo = f;
    }

    int side = 0;
    [loop]
    for (int k = 0; k < POM_REFINE_ITERS; ++k)
    {
        float dM = (dLo * fHi - dHi * fLo) / max(fHi - fLo, 1e-6);
        float fM = dM - PomDepth(uv0 + rayUV * dM, dx, dy);

        if (fM >= 0.0)
        {
            dHi = dM;
            fHi = fM;
            if (side == 1)
                fLo *= 0.5;
            side = 1;
        }
        else
        {
            dLo = dM;
            fLo = fM;
            if (side == -1)
                fHi *= 0.5;
            side = -1;
        }
    }
    float dHit = dHi;
    float2 uvH = uv0 + rayUV * dHit;
#if POM_CLIP_EDGES
    if (any(uvH < 0.0) || any(uvH > 1.0)) discard;
#endif

    float w, h;
    depthMap.GetDimensions(w, h);
    const float NK = 3.0;
    float2 tx = NK * rcp(float2(w, h));

    float tl = PomDepth(uvH + tx * float2(-1, -1), dx, dy);
    float t = PomDepth(uvH + tx * float2(0, -1), dx, dy);
    float tr = PomDepth(uvH + tx * float2(1, -1), dx, dy);
    float l = PomDepth(uvH + tx * float2(-1, 0), dx, dy);
    float r = PomDepth(uvH + tx * float2(1, 0), dx, dy);
    float bl = PomDepth(uvH + tx * float2(-1, 1), dx, dy);
    float b = PomDepth(uvH + tx * float2(0, 1), dx, dy);
    float br = PomDepth(uvH + tx * float2(1, 1), dx, dy);

    float2 grad = float2((3 * tr + 10 * r + 3 * br) - (3 * tl + 10 * l + 3 * bl),
                         (3 * bl + 10 * b + 3 * br) - (3 * tl + 10 * t + 3 * tr)) / (32.0 * NK);
    grad *= float2(w, h);

    float3 nDetail = normalize(float3(grad * dScale, 1.0));
    float3 nBase = normalize(normalTS);
    float3 nTS = normalize(float3(nBase.xy + nDetail.xy, nBase.z * nDetail.z));

    float ao = max(PomAO(uvH, dHit, dScale, jit, rcp(float2(w, h)), dx, dy), POM_AO_MIN);
    
    float shadow = 1.0;
    float3 probe = float3(0.0, L.z, 0.0);
    if (L.z <= 0.0)
    {
        shadow = 0.0;
    }
    else if (dHit > 1e-4)
    {
        float2 lightUV = L.xy / max(L.z, 0.05) * dScale;
        float maxRatio = 0.0;
        [loop]
        for (uint j = 0; j < POM_SHADOW_STEPS; ++j)
        {
            float s = dHit * (j + 1.0) / POM_SHADOW_STEPS;
            float dh = PomDepth(uvH + lightUV * s, dx * 4.0, dy * 4.0);
            float o = (dHit - s) - dh - POM_SHADOW_BIAS;
            maxRatio = max(maxRatio, o / (s + POM_SHADOW_SMIN));
        }
        probe = float3(maxRatio, L.z, length(lightUV));
        float v = 1.0 - saturate(maxRatio * POM_SHADOW_SOFTNESS);
        shadow = v * v * (3.0 - 2.0 * v);
        shadow *= smoothstep(0.0, .1, L.z);
    }

    float3 Hh = normalize(L + V);
    float ndv = saturate(dot(nTS, V));
    float ndl = saturate(dot(nTS, L));
    float spec = pow(saturate(dot(nTS, Hh)), 64.0) * ndl;

    float trans = max(exp(-POM_ABSORB * dHit * (1.0 / max(L.z, POM_MIN_COS) + 1.0 / vz)), POM_TRANS_FLOOR);

    float3 albedo = diffuseMap.SampleGrad(sampleTypeLinear, uvH, dx, dy).rgb;
    float shadowLit = lerp(POM_SHADOW_FLOOR, 1.0, shadow);
    float3 col = (albedo * (0.5 * ndv + 0.08) * ao + albedo * ndl * shadowLit + spec * shadow * 0.25) * trans;
    
    PomResult o;
    o.color = float4(col, 1.0);
    o.uv = uvH;
    o.normalWS = nTS;
    o.normalTS = nTS;
    o.shadow = shadow;
    o.hitDepth = dHit;
    o.probe = probe;
    o.ao = ao;
    return o;
}

static const float3x3 BASE_TBN = float3x3(1, 0, 0, 0, 1, 0, 0, 0, 1); // x=u, y=v, z=toward viewer



float3 ThinFilmInterference(float3 baseColor, float depth01, float3 nTS, float3 vTS)
{
    float cosI = saturate(dot(normalize(nTS), normalize(vTS)));
    float sinT = sqrt(max(1.0 - cosI * cosI, 0.0)) / FILM_N;
    float cosT = sqrt(max(1.0 - sinT * sinT, 0.0));
    float opdNM = 2.0 * FILM_N * lerp(FILM_MIN_NM, FILM_MAX_NM, saturate(depth01)) * cosT;

    float3 xyz = ZERO3;
    float3 xyzWhite = ZERO3;
    [loop]
    for (int i = 0; i < FILM_SAMPLES; ++i)
    {
        float lam = lerp(FILM_MIN_NM, FILM_MAX_NM, (float(i) + 0.5) / float(FILM_SAMPLES));
        float I = 1.0 - 0.5 * cos(TWO_PI * opdNM / max(lam, EPSILON) + time);
        float3 cmf = float3(CIE_xbar(lam), CIE_ybar(lam), CIE_zbar(lam));
        xyz += I * cmf;
        xyzWhite += cmf;
    }
    float3 ratio = xyz / max(xyzWhite, float3(1e-4, 1e-4, 1e-4));
    float3 rgb = clamp(XYZToLinearRGB(ratio) / FILM_WHITE_RGB, 0.0, 2.0);
    return baseColor * max(lerp(ONE3, rgb, FILM_STRENGTH), 0.0);
}


float3 TiltRot(float3 v, float3 a)
{
    v = RotateAroundZ(v, a.z); // roll about the plate's own normal (applied first)
    v = RotateAroundX(v, -a.y); // +ViewY tilts N toward +y
    v = RotateAroundY(v, a.x); // +ViewX tilts N toward +x
    return v;
}

float3x3 ViewDrivenTBN(float3 s)
{
    float3 a = clamp(s, -1.0, 1.0) * TBN_MAX_TILT;
    float3 T = TiltRot(float3(1, 0, 0), a);
    float3 B = TiltRot(float3(0, 1, 0), a);
    float3 N = TiltRot(float3(0, 0, 1), a);
    return float3x3(T, B, N); // rows
}

float3 DoeXYZ(float l)
{
    return float3(CIE_xbar(l), CIE_ybar(l), CIE_zbar(l));
}

float DoePlanck(float lNM, float T)
{
    float lu = clamp(lNM * 1e-3, 1e-3, 100.0);
    float l2 = lu * lu;
    return 1.0 / clamp(l2 * l2 * lu * (exp(1.4388e4 / (lu * T)) - 1.0), 1e-6, 1e6);
}

float DoeBesselJ(int m, float x)
{
    float h = 0.5 * x;
    float mf = 1.0;
    
    if (2 <= m)
    {
        mf *= float(2);
    }
    if (3 <= m)
    {
        mf *= float(3);
    }
     //   for (int i = 2;i <= m; ++i)
       //     mf *= float(i);
    float term = pow(h, float(m)) / mf;
    float sum = term;
    float h2 = h * h;
    /*[loop]
    for (int k = 1; k <= 10; ++k)
    {
        term *= -h2 / (float(k) * float(k + m));
        sum += term;
    }*/
    term *= -h2 / (float(1) * float(1 + m));
    sum += term;
    term *= -h2 / (float(2) * float(2 + m));
    sum += term;
    term *= -h2 / (float(3) * float(3 + m));
    sum += term;
    term *= -h2 / (float(4) * float(4 + m));
    sum += term;
    term *= -h2 / (float(5) * float(5 + m));
    sum += term;
    term *= -h2 / (float(6) * float(6 + m));
    sum += term;
    term *= -h2 / (float(7) * float(7 + m));
    sum += term;
    term *= -h2 / (float(8) * float(8 + m));
    sum += term;
    term *= -h2 / (float(9) * float(9 + m));
    sum += term;
    term *= -h2 / (float(10) * float(10 + m));
    sum += term;
    return sum;
}
float3 DiffractiveRainbow(float3 nTS, float3 V, float3 L, float hitDepth)
{
    float2 sl = nTS.xy;
    float ang = ((length(sl) > 1e-4) ? atan2(sl.y, sl.x) : 0.0) + DOE_SWIRL * TWO_PI * (hitDepth);
    
    float3 g = float3(cos(ang), sin(ang), 0.0);
    float3 T = safeNormalize(g - nTS * dot(g, nTS));
    float3 B = cross(nTS, T);
    
    float3 vl = V + L;
    float ap = abs(dot(vl, T));
    float q = dot(vl, B);

    float periodNM = clamp(max(1000.0 * DOE_PERIOD_UM * (1.0 + DOE_CHIRP * (hitDepth - 0.5)), 200.0), 200.0, 1000.0);
    float cc = clamp(saturate(dot(nTS, L)) + saturate(dot(nTS, V)), 0.0, 2.0);

    const float dl = clamp((DOE_LAMBDA_MAX - DOE_LAMBDA_MIN) / float(DOE_SPEC_N), 1.0, 1000.0);
    float src0 = DoePlanck(560.0, DOE_SOURCE_K);
    float3 xyz = ZERO3;
    float yNorm = 0.0;

    [loop]
    for (int i = 0; i < DOE_SPEC_N; ++i)
    {
        float lam = DOE_LAMBDA_MIN + (float(i) + 0.5) * dl;
        float3 cmf = DoeXYZ(lam);
        float src = DoePlanck(lam, DOE_SOURCE_K) / src0;
        yNorm += src * cmf.y;

        float a = min(PI * DOE_GROOVE_NM * cc / lam, 6.0);
        float3 spectral = 0.0;

        {
            float sig = max(DOE_SIGMA, float(1) * dl / periodNM);
            float dp = float(1) * lam / periodNM - ap;
            float j = DoeBesselJ(1, a);
            spectral.x += j * j * exp(-0.5 * max(dp * dp + q * q, 0.0) / (sig * sig));
        }
        {
            float sig = max(DOE_SIGMA, float(2) * dl / periodNM);
            float dp = float(2) * lam / periodNM - ap;
            float j = DoeBesselJ(2, a);
            spectral.y += j * j * exp(-0.5 * max(dp * dp + q * q, 0.0) / (sig * sig));
        }
        {
            float sig = max(DOE_SIGMA, float(3) * dl / periodNM);
            float dp = float(3) * lam / periodNM - ap;
            float j = DoeBesselJ(3, a);
            spectral.z += j * j * exp(-0.5 * (dp * dp + q * q) / (sig * sig));
        }
        xyz += ((cmf) * (1.-src) * (1.-spectral));
    }

    xyz /= max(yNorm, EPSILON);

    float3 rgb = XYZToLinearRGB(xyz);
//    rgb += min(min(rgb.r, min(rgb.g, rgb.b)), 0.0);
    return rgb;
}
// W  world [m], z up, plane centre at origin, top plane z = 0, depth toward -z
// TS tangent space, columns T,B,N, applied as mul(v, tbn); flat normal = (0,0,1)
// N  normalised input: xy [uv], z [depthM units]
// Location: translated and rotated. Direction: rotated only. viewDir*/lightDir* are unit, surface -> eye/sun.
// Digit 0 = entry point before POM; no digit = POM hit. depth01: 0 = top plane, 1 = depthM below.

static const float  STEER_ORBIT_RADIUS_N    = 0.25;   // [N units]
static const float  STEER_ORBIT_RATE_RAD_S  = 0.5;    // [rad/s]
static const float  VIEW_BACKFACE_TOLERANCE = 0.02;   // [dimensionless]
static const float3 NORMAL_FLAT_TS          = float3(0.0, 0.0, 1.0);

struct ViewLightFrame
{
    float3 viewDirW;
    float3 lightDirW;
    float3 viewDirTS;
    float3 lightDirTS;
};

// N location -> W location. Location: the -0.5 centring is a translation. World: shares a frame with SurfacePosW.
float3 NormalizedToWorld(float3 n, float2 sizeM, float depthM)
{
    return float3((n.xy - 0.5) * sizeM, n.z * depthM);
}

// uv + depth01 -> W location. Location: directions are (target - point) and vary per pixel.
float3 SurfacePosW(float2 uv, float depth01, float2 sizeM, float depthM)
{
    return float3((uv - 0.5) * sizeM, -depth01 * depthM);
}

// W direction -> TS direction. Direction: tbn is a pure rotation. TS: cos(theta) is a component.
float3 WorldToTangent(float3 vW, float3x3 tbn)
{
    return safeNormalize(mul(vW, tbn));
}

// Three W locations: a direction to a point is a difference of points in one frame. Subtract in W, then rotate to TS.
ViewLightFrame BuildViewLightFrame(float3 posW, float3 eyePosW, float3 sunPosW, float3x3 tbn)
{
    ViewLightFrame f;
    f.viewDirW   = safeNormalize(eyePosW - posW);
    f.lightDirW  = safeNormalize(sunPosW - posW);
    f.viewDirTS  = WorldToTangent(f.viewDirW, tbn);
    f.lightDirTS = WorldToTangent(f.lightDirW, tbn);
    return f;
}

int DebugMode()
{
    return (KeyQDown > 0.5 ? 1 : 0) + (KeyWDown > 0.5 ? 2 : 0) + (KeyEDown > 0.5 ? 3 : 0);
}

psout PS(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    const float2 sizeM  = max(abs(HOLOGRAM_SIZE_M), EPSILON2);
    const float  depthM = HeightScale*length(sqrt(sizeM));

    const float3 viewN  = float3(ViewX, ViewY, ViewZ);
    const float3 sunN   = float3(SunX, SunY, SunZ);
    const float2 orbitN = float2(cos(time * STEER_ORBIT_RATE_RAD_S),
                                 sin(time * STEER_ORBIT_RATE_RAD_S)) * STEER_ORBIT_RADIUS_N;

    const float3 eyePosW   = NormalizedToWorld(viewN, sizeM, depthM);
    const float3 sunPosW   = NormalizedToWorld(sunN, sizeM, depthM);
    const float3 steerPosW = NormalizedToWorld(float3(viewN.xy + orbitN, viewN.z), sizeM, depthM);

    // W location; origin is the plane centre, so it is also the centre-to-eye vector that defines the frame.
    const float3x3 tbn = ViewDrivenTBN(steerPosW);

    const float3         pos0W  = SurfacePosW(input.uv, depthRaw(depthMap, input.uv), sizeM, depthM);
    const ViewLightFrame frame0 = BuildViewLightFrame(pos0W, eyePosW, sunPosW, tbn);

    // TS directions: the march is a straight line in TS. W directions: required by the signature, use not visible here.
    // Entry vectors: the ray enters at the unperturbed surface.
    const PomResult res = ParallaxOcclusion(input.uv, input.Position.xy, NORMAL_FLAT_TS,
                                            frame0.viewDirTS, frame0.lightDirTS, tbn,
                                            frame0.viewDirW, frame0.lightDirW);
    clip(frame0.viewDirTS.z + VIEW_BACKFACE_TOLERANCE);

    // Rebuilt from the hit location: parallax moved the point.
    const float2         uvHit    = res.uv;
    const float3         posHitW  = SurfacePosW(uvHit, res.hitDepth, sizeM, depthM);
    const ViewLightFrame frame    = BuildViewLightFrame(posHitW, eyePosW, sunPosW, tbn);
    const float3         normalTS = res.normalTS;

    // TS directions: film phase depends only on angles to the local normal.
    const float3 film = ThinFilmInterference(res.color.rgb, res.hitDepth, normalTS, frame.viewDirTS);

    // TS directions: the grating equation projects onto the local surface.
    const float3 doe = DiffractiveRainbow(normalTS, frame.viewDirTS, frame.lightDirTS, res.hitDepth);

    const float  shadowDarken = clamp(f12, 0.0, PS_SHADOW_DARKEN_MAX);
    const float3 filmLit      = max(film - lerp(shadowDarken, 0.0, res.shadow),
                                    film * PS_MIN_FILM_FRACTION) + doe * DOE_GAIN;

    const float  ndotV      = max(0.0, dot(frame.viewDirTS, normalTS));
    const float3 baseColor  = res.color.xyz * filmLit * ndotV;

    float3 chroma = ZERO3;
    if (PassNum > 0)
    {
        // uv only: 2-D image resample, no 3-D space.
        const float3 chromaDisp = (abs(f11 * saturate(res.hitDepth)) * FRINGE_VISIBILITY).xxx;
        chroma = ChromaticAberration(rtMap1, input.uv, NormalRadius, chromaDisp) * f7;
    }

    const float3 finalColor = baseColor + (chroma);

    output.rt1.xyz = finalColor;

    const int debugMode = DebugMode();
    if (debugMode != 0)
    {
        float3 dbg;
        switch (debugMode)
        {
        case 1:
            dbg = res.hitDepth.xxx;
            break;
        case 2:
            dbg = res.shadow.xxx;
            break;
        case 3:
            dbg = film;
            break;
        case 4:
            dbg = KeyControl ? float3(1, 0, 0) * depthRaw(gratingDepth1, uvHit)
                             : float3(0, 0, 1) * depthRaw(depthMap, uvHit);
            break;
        case 5:
            dbg = KeyControl ? 1.0 - chroma : chroma;
            break;
        case 6:
            dbg = KeyControl ? doe * (KeyAlt ? DOE_GAIN : 1.0) : doe * DOE_GAIN;
            break;
        default:
            dbg = res.probe;
            break;
        }
        output.rt1.xyz = dbg;
    }

    return output;
}