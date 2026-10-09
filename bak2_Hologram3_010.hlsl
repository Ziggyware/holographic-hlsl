
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

#define PI 3.141592653579
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
static const int SPECTRAL_LOCUS_COUNT = 471; // 380 nm to 780 nm at 5 nm intervals

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

#define HOLOGRAM_SIZE_M HeightScale

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
inline uint2 GetSz3ui(Texture2D<float3> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return sz;
}
inline int2 GetSz3i(Texture2D<float3> tex)
{
    int2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return sz;
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

//gCoefficients for Dispersion

struct MaterialSellmeier
{
    float3 B1; // Sellmeier coefficient B1 for R, G, B
    float3 B2; // Sellmeier coefficient B2 for R, G, B
    float3 B3; // Sellmeier coefficient B3 for R, G, B

    float3 C1; // Sellmeier coefficient C1 for R, G, B
    float3 C2; // Sellmeier coefficient C2 for R, G, B
    float3 C3; // Sellmeier coefficient C3 for R, G, B

    // Optical Properties
    float3 absorptionCoefficient; // Absorption coefficients for R, G, B (1/m)
    float3 scatteringCoefficient;
    float roughness; // Surface roughness (0.0 to 1.0)
    float thicknessM; // Film thickness in meters

    // Environmental Properties
    float nSurrounding; // Refractive index of the surrounding medium
    float coherenceLengthM; // Coherence length in meters
    float polarizationAngle; // Polarization angle in radians

    // Material Conditions
    float temperatureC; // Temperature in Celsius
    
};




// Function to create a MaterialSellmeier struct with initialized values
MaterialSellmeier CreateMaterialSellmeier(float3 B1, float3 B2, float3 B3, float3 C1, float3 C2, float3 C3, float3 absorptionCoefficient, float3 scatteringCoefficient, float roughness, float thicknessM, float nSurrounding, float polarizationAngle, float coherenceLengthM, float temperatureC)
{
    
    MaterialSellmeier material;
    material.B1 = B1;
    material.B2 = B2;
    material.B3 = B3;
    material.C1 = C1;
    material.C2 = C2;
    material.C3 = C3;
    material.absorptionCoefficient = absorptionCoefficient;
    material.scatteringCoefficient = scatteringCoefficient;
    material.roughness = roughness;
    material.thicknessM = thicknessM;
    material.nSurrounding = nSurrounding;
    material.polarizationAngle = polarizationAngle;
    material.coherenceLengthM = coherenceLengthM;
    material.temperatureC = temperatureC;
    return material;
}

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
// Function to define 5 holographic materials
MaterialSellmeier CreateMaterial(int index, float4 color = ZERO4)
{
    index = fmod(index, 5);
    MaterialSellmeier ret = (MaterialSellmeier) 0;
    
    if (dot(color, color) > 0)
    {
        float3 linearRGB = SRGBToLinear(color.rgb);
        if (linearRGB.r > .75)
        {
            index = 0;
        }
        else if (linearRGB.g > .75)
        {
            index = 1;
        }
        else if (linearRGB.b > .75)
        {
            index = 2;
        }
        else if (linearRGB.r > .5)
        {
            index = 0;
        }
        else if (linearRGB.g > .5)
        {
            index = 1;
        }
        else if (linearRGB.b > .5)
        {
            index = 2;
        }
        else if (linearRGB.r > .25)
        {
            index = 0;
        }
        else if (linearRGB.g > .25)
        {
            index = 1;
        }
        else if (linearRGB.b > .25)
        {
            index = 2;
        }
        else if (linearRGB.r > .15)
        {
            index = 0;
        }
        else if (linearRGB.g > .15)
        {
            index = 1;
        }
        else if (linearRGB.b > .15)
        {
            index = 2;
        }
    }
   
    
    switch (index)
    {
        // Material 1: Diamond
        case 0:
        {
                ret = CreateMaterialSellmeier(
                    float3(0.3306, 4.3356, 0.0), // B1
                    ZERO3, // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00417, 0.1060, 0.0), // C1
                    ZERO3, // C2
                    float3(0.0, 0.0, 120.0), // C3
                    float3(0.01, 0.01, 0.02), // absorptionCoefficient
                    float3(0.91, 0.907, 0.98), // scatteringCoefficient scattering per meter
                    0.1 - 
                        0.05 *  clamp(safeNormalize(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0)), 0.0, 1.0).x, // roughness
                        10e-9 + clamp(safeNormalize(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0)), 0.0, 1.0).y * 1e-9 + 
                                clamp(safeNormalize(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0)), 0.0, 1.0).x * 1e-10, // thicknessM
                    1.3, // nSurrounding
                    0.05, // polarizationAngle
                    5e-6, // coherenceLengthM
                    25.0 // temperatureC
                );
            }
            break;
        case 1:
        {
                // Material 2: Borosilicate Glass
                ret = CreateMaterialSellmeier
                (float3(1.47522, 0.00419, 0.00262), // B1
                    float3(0.00616, 0.00202, 0.01017), // B2
                    float3(0.00936, 0.00891, 106.52), // B3
                    float3(0.00429, 0.01319, 0.00975), // C1
                    float3(0.03175, 0.05957, 89.752), // C2
                    float3(104.99, 107.54, 119.31), // C3
                    float3(0.02, 0.03, 0.04), // absorptionCoefficient
                    float3(0.091, 0.0907, 0.098), // scatteringCoefficient scattering per meter
                    0.2 - .05 * safeNormalize(clamp(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0), 0.0, 1.0)).x, // roughness
                    150e-9 + safeNormalize(clamp(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0), 0.0, 1.0)).y * 1e-9 + 
                        safeNormalize(clamp(noiseMap1.SampleLevel(sampleTypeMirror, float2(index, index), 0), 0.0, 1.0)).x * 1e-10, // thicknessM
                  
                    1.0, // nSurrounding
                    1.0, // polarizationAngle
                    4e-6, // coherenceLengthM
                    20.0 // temperatureC
                );
            }
            break;
        case 2:
        {
            
                // Material 3: Sapphire
                ret = CreateMaterialSellmeier(float3(1.023798, 1.058264, 5.280792), // B1
                    ZERO3, // B2
                    ZERO3, // B3
                    float3(0.00315094, 0.00834422, 17.7932), // C1
                    ZERO3, // C2
                    ZERO3, // C3
                    float3(0.03, 0.72, 0.71), // absorptionCoefficient
                    float3(0.51, 0.127, 0.198), // scatteringCoefficient scattering per meter
                        0.05, // roughness
                        300e-9, // thicknessM
                    1.0, // nSurrounding
                    0.0, // polarizationAngle
                    6e-6, // coherenceLengthM
                    30.0 // temperatureC
                );
            }
            break;
        case 3:
        {
                // Material 4: Fluorite
                ret = CreateMaterialSellmeier
                (float3(0.922831, 0.006135, 0.0), // B1
                    ZERO3, // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00171739, 0.00711506, 0.0), // C1
                    ZERO3, // C2
                    float3(0.0, 0.0, 34.6490), // C3
                    float3(0.01, 0.005, 0.005), // absorptionCoefficient
                    float3(0.65, 0.8, 0.92),
                    0.3, // roughness
                    100e-9, // thicknessM
                    1.0, // nSurrounding
                    1.5, // polarizationAngle
                    3e-6, // coherenceLengthM
                    22.0 // temperatureC
                );
            }
            break;
        
        // Material 5: Acrylic
        case 4:
        {
                ret = CreateMaterialSellmeier(float3(0.903339, 0.635647, 0.903971), // B1
                    ZERO3, // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00130497, 0.00593559, 127.62), // C1
                    ZERO3, // C2
                    ZERO3, // C3
                    float3(0.04, 0.03, 0.02), // absorptionCoefficient
                    float3(.1, .3, .4),
                    0.15, // roughness
                    250e-9, // thicknessM
                    1.0, // nSurrounding
                    0.8, // polarizationAngle
                    7e-6, // coherenceLengthM
                    28.0 // temperatureC
                );
            }
            break;
        
    }
    
    return ret;
   
}


// Structure to hold data related to gradient modulation calculations.
struct GradientModulationConfig
{
    float2 uv;
    float2 uv0;
    float2 oosz;
    float2 ooszd;
    float2 ooszrt;
    float3 viewPos;
    float3 viewPos0;
    float2 gradient;
    float2 gradient0;
    float2 modulation;
    float2 modulation0;
    float depth;
    float depth0;
    float invDepth;
    
    float3 normal;
    float3 tangent;
    float3 bitangent;
    float3x3 tangentToWorld;
    
    float3 normal0;
    float3 viewDir;
    float3 viewDir0;
    float3 pixelScaled;
    float3 pixel0Scaled;
    float viewDist;
    float3 pixelToSunSegment;
    float3 pixel0ToSunSegment;
    float3 sunPos;
    float3 pixelToSunDir;
    float3 pixel0ToSunDir;
    float3 sunHalfVec;
    float NdotV;
    float VdotL;
    float NdotL;
    float HdotV;
    float HdotN;
    float HdotL;
    
    float HdotR;
    float RdotL;
    float NdotR;
    
    
    float3 reflectDirTS;
    float3 normalTS;
    
    float3 lightDirTS;
    float3 viewDirTS;
    float3 halfDirTS;
    float NdotV_TS;
    float NdotL_TS;
    float HdotN_TS;
    float HdotV_TS;
    float NdotR_TS;
    float TdotV_TS;
    float TdotL_TS;
    float TdotN_TS;
    float TdotR_TS;
    float BdotV_TS;
    float BdotL_TS;
    float BdotN_TS;
    float BdotR_TS;
   
    float4 diffuse;
    float3 reflectDir;
    
};
// Global instance of the GradientModulationConfig structure.
static GradientModulationConfig config;
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
    return (clamp(value, lo, hi) - lo) / max(hi - lo, EPSILON);
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
    return lerp(a, b, sigmoid(safeNormalizeRange(r, value)));
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
// Convert wavelength from nanometers (nm) to frequency (Hz)
inline float nmToHz1(float nm)
{
    return 2.99792458e14 / max(nm, EPSILON); // speed of light in m/s divided by wavelength in m
}
inline float3 nmToHz(float3 nm)
{
    return float3(nmToHz1(nm.x), nmToHz1(nm.y), nmToHz1(nm.z)); // speed of light in m/s divided by wavelength in m
}

// Convert wavelength from meters (m) to frequency (Hz)
inline float mToHz(float m)
{
    return 2.99792458e8 / m; // speed of light in m/s divided by wavelength in m
}
inline float3 mToHz(float3 m)
{
    return 2.99792458e8 / m; // speed of light in m/s divided by wavelength in m
}
// Convert wavelength from millimeters (mm) to frequency (Hz)
inline float mmToHz(float mm)
{
    return 2.99792458e11 / mm; // speed of light in m/s divided by wavelength in m
}
inline float3 mmToHz(float3 mm)
{
    return 2.99792458e11 / mm; // speed of light in m/s divided by wavelength in m
}

// Convert frequency (Hz) to wavelength in nanometers (nm)
inline float hzToNm(float hz)
{
    return 2.99792458e14 / hz; // speed of light in m/s divided by frequency in Hz
}
inline float3 hzToNm(float3 hz)
{
    return 2.99792458e14 / hz; // speed of light in m/s divided by frequency in Hz
}

// Convert frequency (Hz) to wavelength in meters (m)
inline float hzToM(float hz)
{
    return 2.99792458e8 / hz; // speed of light in m/s divided by frequency in Hz
}
inline float3 hzToM(float3 hz)
{
    return 2.99792458e8 / hz; // speed of light in m/s divided by frequency in Hz
}
// Convert frequency (Hz) to wavelength in millimeters (mm)
inline float hzToMm(float hz)
{
    return 2.99792458e11 / hz; // speed of light in m/s divided by frequency in Hz
}
inline float3 hzToMm(float3 hz)
{
    return 2.99792458e11 / hz; // speed of light in m/s divided by frequency in Hz
}

inline float nmToRange01(float nm)
{
    return saturate(max(EPSILON, nm - MIN_WAVELENGTH) / WAVELENGTH_RANGE);
}
inline float mToRange01(float m)
{
    return nmToRange01(mToNm(m));
}
inline float3 nmToRange01(float3 nm)
{
    return saturate(max(EPSILON3, nm - MIN_WAVELENGTHS) / WAVELENGTH_RANGES);
}
inline float3 mToRange01(float3 m)
{
    return nmToRange01(mToNm(m));
}

inline float range01ToWavelengthNM(float range)
{
    return range > 0 ? (saturate(range) * WAVELENGTH_RANGE + MIN_WAVELENGTH) : EPSILON;
}
inline float range01ToWavelengthM(float range)
{
    return range01ToWavelengthNM(mToNm(range));
}
inline float3 range01ToWavelengthNM(float3 nm)
{
    return float3(range01ToWavelengthNM(nm.x), range01ToWavelengthNM(nm.y), range01ToWavelengthNM(nm.z));
}
inline float3 range01ToWavelengthM(float3 m)
{
    return range01ToWavelengthNM(mToNm(m));
}


// Calculate the energy of a photon given its wavelength (nm)
inline float photonEnergyFromNm(float nm)
{
    return 1.23984193e-19 / nm; // energy of photon in J = hc / λ
}
inline float3 photonEnergyFromNm(float3 nm)
{
    return ONE3 * 1.23984193e-19 / max(nm, EPSILON3); // energy of photon in J = hc / λ
}

// Calculate the energy of a photon given its wavelength (m)
inline float photonEnergyFromM(float m)
{
    return 1.23984193e-27 / m; // energy of photon in J = hc / λ
}
inline float3 photonEnergyFromM(float3 m)
{
    return ONE3 * 1.23984193e-27 / max(m, EPSILON3); // energy of photon in J = hc / λ
}
// Calculate the energy of a photon given its wavelength (mm)
inline float photonEnergyFromMm(float mm)
{
    return 1.23984193e-24 / mm; // energy of photon in J = hc / λ
}
inline float3 photonEnergyFromMm(float3 mm)
{
    return ONE3 * 1.23984193e-24 / max(mm, EPSILON3); // energy of photon in J = hc / λ
}
// Calculate the wavelength (nm) of a photon given its energy (J)
inline float wavelengthFromEnergy(float energy)
{
    return 1.23984193e-19 / energy; // wavelength in nm = hc / E
}
inline float3 wavelengthFromEnergy(float3 energy)
{
    return ONE3 * 1.23984193e-19 / max(energy, EPSILON3); // wavelength in nm = hc / E
}

// Calculate the period (s) of a wave given its frequency (Hz)
inline float periodFromHz(float hz)
{
    return 1.0 / max(hz, EPSILON); // period = 1 / frequency
}
inline float3 periodFromHz(float3 hz)
{
    return ONE3 / max(hz, EPSILON3); // period = 1 / frequency
}

// Calculate the frequency (Hz) of a wave given its period (s)
inline float hzFromPeriod(float period)
{
    return 1.0 / max(period, EPSILON); // frequency = 1 / period
}
inline float3 hzFromPeriod(float3 period)
{
    return ONE3 / max(period, EPSILON3); // frequency = 1 / period
}
// Calculate the wavelength (nm) of a wave given its period (s)
inline float wavelengthFromPeriod(float period)
{
    return hzToNm(hzFromPeriod(period)); // wavelength = c / frequency = c / (1 / period)
}
inline float3 wavelengthFromPeriod(float3 period)
{
    return hzToNm(hzFromPeriod(period)); // wavelength = c / frequency = c / (1 / period)
}

// Calculate the period (s) of a wave given its wavelength (nm)
inline float periodFromWavelength(float wavelengthNm)
{
    return 1.0 / nmToHz1(wavelengthNm); // period = 1 / frequency = 1 / (c / wavelength)
}
float3 periodFromWavelength(float3 wavelengthNm)
{
    return ONE3 / nmToHz(wavelengthNm); // period = 1 / frequency = 1 / (c / wavelength)
}

// Calculate the angular frequency (rad/s) of a wave given its frequency (Hz)
inline float angularFrequencyFromHz(float hz)
{
    return 2.0 * 3.14159265 * hz; // angular frequency = 2 * pi * frequency
}
inline float3 angularFrequencyFromHz(float3 hz)
{
    return float3(angularFrequencyFromHz(hz.x), angularFrequencyFromHz(hz.y), angularFrequencyFromHz(hz.z));
}
// Calculate the frequency (Hz) of a wave given its angular frequency (rad/s)
inline float hzFromAngularFrequency(float angularFrequency)
{
    return angularFrequency / (2.0 * 3.14159265); // frequency = angular frequency / (2 * pi)
}
inline float3 hzFromAngularFrequency(float3 angularFrequency)
{
    return float3(hzFromAngularFrequency(angularFrequency.x), hzFromAngularFrequency(angularFrequency.y), hzFromAngularFrequency(angularFrequency.z));
}
// Calculate the momentum (kg m/s) of a photon given its energy (J)
inline float momentumFromEnergy(float energy)
{
    return energy / (2.99792458e8); // momentum = energy / c
}
inline float3 momentumFromEnergy(float3 energy)
{
    return float3(momentumFromEnergy(energy.x), momentumFromEnergy(energy.y), momentumFromEnergy(energy.z));

}
// Calculate the energy (J) of a photon given its momentum (kg m/s)
inline float energyFromMomentum(float momentum)
{
    return momentum * (2.99792458e8); // energy = momentum * c
}
inline float3 energyFromMomentum(float3 momentum)
{
    return float3(energyFromMomentum(momentum.x), energyFromMomentum(momentum.y), energyFromMomentum(momentum.z));
}

// Calculate the energy (J) of a photon given its frequency (Hz)
inline float energyFromHz(float hz)
{
    return photonEnergyFromNm(hzToNm(hz)); // energy = hc / λ = hc / (c / frequency)
}
inline float3 energyFromHz(float3 hz)
{
    return float3(energyFromHz(hz.x), energyFromHz(hz.y), energyFromHz(hz.z)); // energy = hc / λ = hc / (c / frequency)
}

// Calculate the frequency (Hz) of a photon given its energy (J)
inline float hzFromEnergy(float energy)
{
    return nmToHz1(wavelengthFromEnergy(energy)); // frequency = c / λ = c / (hc / energy)
}
inline float3 hzFromEnergy(float3 energy)
{
    return nmToHz(wavelengthFromEnergy(energy)); // frequency = c / λ = c / (hc / energy)
}



// Calculate the energy (J) of a system of N photons given their frequencies (Hz)
inline float systemEnergy1(float frequenciesHz[MAX_NUM_MASSES], int N)
{
    float energy = 0;
    for (int i = 0; i < N; i++)
    {
        energy += energyFromHz(frequenciesHz[i]);
    }
    return energy;
}
inline float3 systemEnergy(float3 frequenciesHz[MAX_NUM_MASSES], int N)
{
    float3 energy = ZERO3;
    for (int i = 0; i < N; i++)
    {
        energy += energyFromHz(frequenciesHz[i]);
    }
    return energy;
}
// Calculate the momentum (kg m/s) of a system of N photons given their frequencies (Hz)
inline float systemMomentum1(float frequenciesHz[MAX_NUM_MASSES], int N)
{
    float momentum = 0;
    for (int i = 0; i < N; i++)
    {
        momentum += momentumFromEnergy(energyFromHz(frequenciesHz[i]));
    }
    return momentum;
}
inline float3 systemMomentum(float3 frequenciesHz[MAX_NUM_MASSES], int N)
{
    float3 momentum = ZERO3;
    for (int i = 0; i < N; i++)
    {
        momentum += momentumFromEnergy(energyFromHz(frequenciesHz[i]));
    }
    return momentum;
}
// Calculate the average energy (J) of a system of N photons given their frequencies (Hz)
inline float averageSystemEnergy(float frequenciesHz[MAX_NUM_MASSES], int N)
{
    return systemEnergy1(frequenciesHz, N) / N;
}
inline float3 averageSystemEnergy(float3 frequenciesHz[MAX_NUM_MASSES], int N)
{
    return systemEnergy(frequenciesHz, N) / N;
}

// Calculate the average momentum (kg m/s) of a system of N photons given their frequencies (Hz)
inline float averageSystemMomentum(float frequenciesHz[MAX_NUM_MASSES], int N)
{
    return systemMomentum1(frequenciesHz, N) / N;
}
inline float3 averageSystemMomentum(float3 frequenciesHz[MAX_NUM_MASSES], int N)
{
    return systemMomentum(frequenciesHz, N) / N;
}

// Calculate the total energy (J) of a system of N particles given their masses (kg) and velocities (m/s)
inline float totalSystemEnergy(float massesKg[MAX_NUM_MASSES], float velocitiesMs[MAX_NUM_MASSES], int N)
{
    float energy = 0.0;
    for (int i = 0; i < N; i++)
    {
        energy += 0.5 * massesKg[i] * velocitiesMs[i] * velocitiesMs[i];
    }
    return energy;
}
inline float3 totalSystemEnergy(float3 massesKg[MAX_NUM_MASSES], float3 velocitiesMs[MAX_NUM_MASSES], int N)
{
    float3 energy = ZERO3;
    for (int i = 0; i < N; i++)
    {
        energy += 0.5 * (massesKg[i] * velocitiesMs[i] * velocitiesMs[i]);
    }
    return energy;
}
// Calculate the total momentum (kg m/s) of a system of N particles given their masses (kg) and velocities (m/s)

inline float totalSystemMomentum(float massesKg[MAX_NUM_MASSES], float velocitiesMs[MAX_NUM_MASSES], int N)
{
    float momentum = 0.0;
    for (int i = 0; i < N; i++)
    {
        momentum += massesKg[i] * velocitiesMs[i];
    }
    return momentum;
}

inline float3 totalSystemMomentum(float3 massesKg[MAX_NUM_MASSES], float3 velocitiesMs[MAX_NUM_MASSES], int N)
{
    float3 momentum = ZERO3;
    for (int i = 0; i < N; i++)
    {
        momentum += massesKg[i] * velocitiesMs[i];
    }
    return momentum;
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


// ============================================================
// FIXED SCHLICK FRESNEL (PER-CHANNEL, STABLE, PHYSICALLY CORRECT)
// ============================================================
// cosThetaI      : float3, per-channel cos(theta_i)
// nIncident      : float3, incident refractive index
// nTransmitted   : float3, transmitted refractive index
// FresnelPower   : your exponent (e.g. 5)
// FresnelReflectance : your scalar multiplier for artistic control
// ============================================================

float3 CalculateFresnelReflectance(float3 cosThetaI, float3 nIncident, float3 nTransmitted)
{
    // Clamp cos(theta_i) per channel
    float3 c = saturate(cosThetaI);

    // Base reflectance R0 = ((n1 - n2) / (n1 + n2))^2
    float3 numerator   = nIncident - nTransmitted;
    float3 denominator = max(nIncident + nTransmitted, EPSILON3);
    float3 R0          = (numerator * numerator) / (denominator * denominator);

    // Artistic control: apply your FresnelReflectance scalar
    R0 = saturate(R0 * FresnelReflectance);

    // Schlick approximation: R = R0 + (1 - R0) * (1 - cosTheta)^FresnelPower
    float3 oneMinusC = max(ONE3 - c, EPSILON3);
    float3 fresnel   = R0 + (ONE3 - R0) * pow(oneMinusC, FresnelPower);

    return saturate(fresnel);
}

float fresnelEquation(float3 reflectedNormal, float3 refractedNormal, float eta)
{
  // Calculate the Fresnel reflection coefficient
    float cosThetaI = clamp(dot(reflectedNormal, refractedNormal), -1.0, 1.0);
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = sinThetaI / max(eta, EPSILON);
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    float r = (eta * cosThetaI - cosThetaT) / max((eta * cosThetaI + cosThetaT), EPSILON);
    return r * r;
}

float3 CalculateFresnelReflectance2(float3 n1, float3 n2, float3 cosThetaI, out float3 cosThetaT)
{
    cosThetaI = saturate(cosThetaI);
    // Snell's Law with float3
    float3 sinThetaT = (n1 / max(n2, EPSILON3)) * sqrt(max(EPSILON3, 1.0f - cosThetaI * cosThetaI));
    sinThetaT = saturate(sinThetaT);
    
    // Total internal reflection (using component-wise comparison)
    cosThetaT = sqrt(max(EPSILON3, 1.0f - sinThetaT * sinThetaT));
    float3 tir = step(1.0f, sinThetaT); // 1.0 if TIR occurs, 0.0 otherwise
    cosThetaT = moilerp(cosThetaT, 0.0f, tir);

    // Calculate Rs and Rp (with float3)
    float3 numeratorRs = (n1 * cosThetaI) - (n2 * cosThetaT);
    float3 denominatorRs = (n1 * cosThetaI) + (n2 * cosThetaT);
    float3 Rs = numeratorRs / max(denominatorRs, EPSILON3);

    float3 numeratorRp = (n2 * cosThetaI) - (n1 * cosThetaT);
    float3 denominatorRp = (n2 * cosThetaI) + (n1 * cosThetaT);
    float3 Rp = numeratorRp / max(denominatorRp, EPSILON3);

    // Reflectance is the average of Rs^2 and Rp^2 (with float3)
    float3 reflectance = (Rs * Rs + Rp * Rp) / 2.0f;

    return clamp(reflectance, EPSILON3, OneMinusEPSILON3);
}

// CIE 1931 color matching functions (xBar, yBar, zBar)
// These arrays should be filled with actual data for accurate results.
// For brevity, only a few sample values are included here.
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

float4 RotateAroundAxis(float4 v, float4 axis, float angle)
{
    // safeNormalize the axis
    axis = safeNormalize(axis);

    // Compute the cosine and sine of the angle
    float c = cos(angle);
    float s = sin(angle);

    // Compute the rotation matrix
    float4x3 R;
    R[0][0] = c + (1.0 - c) * axis.x * axis.x;
    R[0][1] = (1.0 - c) * axis.x * axis.y - s * axis.z;
    R[0][2] = (1.0 - c) * axis.x * axis.z + s * axis.y;
    
    R[1][0] = (1.0 - c) * axis.y * axis.x + s * axis.z;
    R[1][1] = c + (1.0 - c) * axis.y * axis.y;
    R[1][2] = (1.0 - c) * axis.y * axis.z - s * axis.x;
   
    R[2][0] = (1.0 - c) * axis.z * axis.x - s * axis.y;
    R[2][1] = (1.0 - c) * axis.z * axis.y + s * axis.x;
    R[2][2] = c + (1.0 - c) * axis.z * axis.z;
   
    // Multiply the vector by the rotation matrix
    return float4(mul(R, v.xyz).xyz, v.w);
}


float3 RotateAroundAxis(float3 v, float3 axis, float angle)
{
    // safeNormalize the axis
    axis = safeNormalize(axis);
    float s, c;
    sincos(angle, s, c);
    

    // Compute the rotation matrix
    float4x3 R;
    R[0][0] = c + (1.0 - c) * axis.x * axis.x;
    R[0][1] = (1.0 - c) * axis.x * axis.y - s * axis.z;
    R[0][2] = (1.0 - c) * axis.x * axis.z + s * axis.y;
    
    R[1][0] = (1.0 - c) * axis.y * axis.x + s * axis.z;
    R[1][1] = c + (1.0 - c) * axis.y * axis.y;
    R[1][2] = (1.0 - c) * axis.y * axis.z - s * axis.x;
   
    R[2][0] = (1.0 - c) * axis.z * axis.x - s * axis.y;
    R[2][1] = (1.0 - c) * axis.z * axis.y + s * axis.x;
    R[2][2] = c + (1.0 - c) * axis.z * axis.z;
   
    // Multiply the vector by the rotation matrix
    return float3(mul(R, v.xyz).xyz);
}

// Calculate the energy (J) of a system of N particles interacting with M photons
float interactingSystemEnergy(float particleMassesKg[MAX_NUM_MASSES], float particleVelocitiesMs[MAX_NUM_MASSES], int N, float photonFrequenciesHz[MAX_NUM_MASSES], int M)
{
    float energy = 0.0;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < M; j++)
        {
            energy += energyFromHz(photonFrequenciesHz[j]) * particleMassesKg[i] * particleVelocitiesMs[i];
        }
    }
    return energy;
}



// Calculate the momentum (kg m/s) of a system of N particles interacting with M photons
float interactingSystemMomentum(float particleMassesKg[MAX_NUM_MASSES], float particleVelocitiesMs[MAX_NUM_MASSES], int N, float photonFrequenciesHz[MAX_NUM_MASSES], int M)
{
    float momentum = 0.0;
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < M; j++)
        {
            momentum += momentumFromEnergy(energyFromHz(photonFrequenciesHz[j])) * particleMassesKg[i] * particleVelocitiesMs[i];
        }
    }
    return momentum;
}

// Calculate the energy (J) of a system of N particles interacting with M photons in a magnetic field (T)
float interactingSystemEnergyInMagneticField(float particleMassesKg[MAX_NUM_MASSES], float particleVelocitiesMs[MAX_NUM_MASSES], int N, float photonFrequenciesHz[MAX_NUM_MASSES], int M, float magneticFieldT)
{
    float energy = interactingSystemEnergy(particleMassesKg, particleVelocitiesMs, N, photonFrequenciesHz, M);
    
    energy += 0.5 * magneticFieldT * magneticFieldT * particleMassesKg[0] * particleVelocitiesMs[0];
    return energy;
}

// Calculate the momentum (kg m/s) of a system of N particles interacting with M photons in a magnetic field (T)
float interactingSystemMomentumInMagneticField(float particleMassesKg[MAX_NUM_MASSES], float particleVelocitiesMs[MAX_NUM_MASSES], int N, float photonFrequenciesHz[MAX_NUM_MASSES], int M, float magneticFieldT)
{
    float momentum = interactingSystemMomentum(particleMassesKg, particleVelocitiesMs, N, photonFrequenciesHz, M);
    momentum += magneticFieldT * particleMassesKg[0] * particleVelocitiesMs[0];
    return momentum;
}


float4 renderQuantumFluctuation(float2 uv, float energyJ, float momentumKgMs)
{
    float2 pos = uv * 2.0 - 1.0;
    float r = length(pos);
    float a = atan2(pos.y, pos.x);
    float f = sin(r * energyJ * 0.01 + a * momentumKgMs * 0.01);
    return float4(f * 0.5 + 0.5, f * 0.5 + 0.5, f * 0.5 + 0.5, 1.0);
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
    float3 srgb;
    linearRGB = clamp(linearRGB, EPSILON, 1.0 - EPSILON);
    srgb.x = max(EPSILON, (linearRGB.x <= 0.0031308) ? (linearRGB.x * 12.92) : (1.055 * pow(max(linearRGB.x, 0.01), 1.0 / 2.4) - 0.055));
    srgb.y = max(EPSILON, (linearRGB.y <= 0.0031308) ? (linearRGB.y * 12.92) : (1.055 * pow(max(linearRGB.y, 0.01), 1.0 / 2.4) - 0.055));
    srgb.z = max(EPSILON, (linearRGB.z <= 0.0031308) ? (linearRGB.z * 12.92) : (1.055 * pow(max(linearRGB.z, 0.01), 1.0 / 2.4) - 0.055));
    return saturate(AdjustGamma(srgb));
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

// Function to convert linear RGB to CIE XYZ using the CIE 1931 color matching functions
inline float3 LinearRGBToXYZ(float3 linearRGB)
{
    return mul(RGBtoXYZ, AdjustGamma(linearRGB));
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

// Function to calculate chromaticity coordinates from XYZ
inline float2 XYZToChromaticity(float3 xyz)
{
    float sum = xyz.x + xyz.y + xyz.z;
    // Guard against division by zero by checking if sum is greater than a small threshold
    if (sum > EPSILON)
    {
        return saturate(float2(xyz.x / sum, xyz.y / sum));
    }
    else
        return float2(0.3127f, 0.3290f);
}



Texture2D<float4> getGratingMap(int index)
{
    index = int(uint(index) % uint(4));
    if (index == 0)
        return gratingMap1;
    else if (index == 1)
        return gratingMap2;
    else if (index == 2)
        return gratingMap3;
    else
        return gratingMap4;
}
Texture2D<float3> getGratingNormalMap(int index)
{
    index = fmod(index, 4);
    if (index == 0)
        return gratingNormal1;
    else if (index == 1)
        return gratingNormal2;
    else if (index == 2)
        return gratingNormal3;
    else
        return gratingNormal4;
}
Texture2D<float> getGratingDepthMap(int index)
{
    index = int(uint(index) % uint(4));
    if (index == 0)
        return gratingDepth1;
    else if (index == 1)
        return gratingDepth2;
    else if (index == 2)
        return gratingDepth3;
    else
        return gratingDepth4;
}

// Helper function for noise, if not using a built-in noise function
inline float noiseFast01(float2 v)
{
    // This would be replaced with an actual noise function like Simplex or Perlin noise
    return frac(sin(dot(v, float2(12.9898, 78.233))) * 43758.5453);
}
inline float noiseFast11(float2 v)
{
    return noiseFast01(v) * 2.0 - 1.0;
}
inline float2 noiseFast012(float2 v)
{
    // This would be replaced with an actual noise function like Simplex or Perlin noise
    return float2(frac(sin(dot(v, float2(12.9898, 78.233))) * 43758.5453), frac(cos(dot(v, float2(7.3871, 137.197323))) * 73358.5483));
}
inline float2 noiseFast112(float2 v)
{
    return noiseFast012(v) * TWO - ONE;
}

// Remap a value from one range to another using sigmoid for smooth transition
float remapSigmoid(float value, float oldMin, float oldMax, float newMin, float newMax)
{
    // safeNormalize the value to [0, 1] range
    float safeNormalized = (value - oldMin) / (oldMax - oldMin);
    // Apply sigmoid for smooth transition
    float sigmoidValue = sigmoid(safeNormalized * 10.0 - 5.0); // Center at 0.5 with quick transition
    // Map back to the new range
    return newMin + sigmoidValue * (newMax - newMin);
}

// Smooth step function using sigmoid, smoother than traditional smoothstep
float smootherStep(float edge0, float edge1, float x)
{
    // Scale and shift x to fit into a range where sigmoid gives a nice curve
    x = (x - edge0) / (edge1 - edge0);
    return sigmoid(x * 12.0 - 6.0); // Adjust 12 and -6 for different steepness
}

// Use sigmoid for creating an ease-in-out effect
float easeInOutSigmoid(float t)
{
    // Here we use a scaled sigmoid to make the transition more pronounced
    return sigmoid((t * 2.0 - 1.0) * 5.0); // Scale to double the range and center, then apply sigmoid
}

// Constrains a value within a range with soft boundaries using sigmoid
float softClamp(float x, float min, float max)
{
    float mid = (min + max) * 0.5;
    float range = max - min;
    // Use sigmoid to create soft edges
    float s = sigmoid((x - mid) * 10.0 / range); // 10/range adjusts how "soft" the clamp is
    return min + s * range;
}
// Fade from one color to another using sigmoid for smooth transition
float3 sigmoidColorFade(float t, float3 colorStart, float3 colorEnd)
{
    float fadeFactor = smootherStep(0.0, 1.0, t);
    return moilerp(colorStart, colorEnd, fadeFactor);
}

// Creates a pulsating effect for light or texture intensity
float pulsatingIntensity(float minIntensity, float maxIntensity, float frequency)
{
    float cycle = sin(time * frequency * PI * 2.0) * 0.5 + 0.5; // Cycle from 0 to 1
    return remapSigmoid(cycle, 0.0, 1.0, minIntensity, maxIntensity);
}

// Parametric curve for 2D or 3D points with smooth interpolation, useful for path animations
float3 parametricSigmoidCurve(float t, float3 p0, float3 p1, float3 p2, float3 p3)
{
    // Assuming here we are doing some form of Catmull-Rom or similar spline with sigmoid easing
    float u = easeInOutSigmoid(t);
    float t2 = u * u;
    float t3 = t2 * u;
    
    float3 result =
        ((-t3 + 2.0 * t2 - u) * p0 +
         (3.0 * t3 - 5.0 * t2 + 2.0) * p1 +
         (-3.0 * t3 + 4.0 * t2 + u) * p2 +
         (t3 - t2) * p3) * 0.5;
    
    return result;
}

// Soft noise function for procedural texture or terrain generation
float softNoise(float2 uv, float scale, float softness)
{
    float2 ip = floor(uv * scale);
    float2 fp = frac(uv * scale);
    
    // Interpolate between noise values with sigmoid easing
    float a = noiseFast01(ip);
    float b = noiseFast01(ip + float2(1.0, 0.0));
    float c = noiseFast01(ip + float2(0.0, 1.0));
    float d = noiseFast01(ip + float2(1.0, 1.0));
    
    float2 u = float2(easeInOutSigmoid(fp.x), easeInOutSigmoid(fp.y));
    
    float x1 = moilerp(a, b, u.x);
    float x2 = moilerp(c, d, u.x);
    return moilerp(x1, x2, u.y) * softness + (1.0 - softness) * 0.5; // Adjust softness
}

// For creating a fog effect that fades objects into the distance with a sigmoid curve
float sigmoidFog(float distance, float start, float end, float fogDensity)
{
    float safeNormalizedDistance = clamp((distance - start) / (end - start), 0.0, 1.0);
    float fogFactor = 1.0 - smootherStep(0.0, 1.0, safeNormalizedDistance);
    return pow(fogFactor, fogDensity); // Adjust density for different falloff rates
}

// Use sigmoid for camera or object movement with anticipation and follow-through
float3 easeCameraPosition(float t, float3 start, float3 end, float anticipation, float followThrough)
{
    float ease = easeInOutSigmoid(t * (1.0 + anticipation) - anticipation);
    ease = remapSigmoid(ease, 0.0, 1.0, -followThrough, 1.0 + followThrough);
    return moilerp(start, end, saturate(ease)); // Using saturate to clamp the result
}
float AtmosphericPerspective(float2 uv, float3 viewPos, float depth, float fog)
{
  // Calculate the distance from the camera to the object
    float distance = length(viewPos - float3(uv, depth));

    // Calculate the atmospheric perspective
    float atmosphericPerspective = exp(-distance * fog);

    return atmosphericPerspective;
}
float DepthOfField(float2 uv, float depth, float3 cameraPosition, float focalLength, float aperture)
{
  // Calculate the distance from the camera to the object
    float distance = length(cameraPosition - float3(uv, depth));

  // Calculate the depth of field
    float depthOfField = smoothstep(focalLength - aperture, focalLength + aperture, distance);

    return depthOfField;
}

inline float2 gradient(float2 range, float value)
{
    float2 n = safeNormalizeRange(range, value);
    return float2(sigmoid(1.0 - n.x), sigmoid(1.0 - n.y));
}
inline float2 gradient(float2 range, float2 value)
{
    float2 n = safeNormalizeRange(range, value);
    return float2(sigmoid(1.0 - n.x), sigmoid(1.0 - n.y));
}


inline float2 adjustDepthGradientSigmoid(float2 depthGradient, float2 nearFar)
{
    float2 gx = gradient(nearFar, depthGradient.x);
    float2 gy = gradient(nearFar, depthGradient.y);
    
    return float2(moilerp(nearFar, gx.x), moilerp(nearFar, gx.y));

}

static const float2 DepthRange = float2(EPSILON, DepthScale - EPSILON);

inline float projectDepth(float depth)
{
    return moilerp(DepthRange, clamp(depth * DepthScale, DepthRange.x, DepthRange.y));
}

float3 LightSigmoid(float value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT)
{
    float d = moilerp(EPSILON, OneMinusEPSILON, (max(((value - .5) * speedOfLight) - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE + .5)) / max(scalar, EPSILON);
    float3 v1 = (float3(d, d, d) - float3(.5, .5, .5)) * float3(speedOfLight, speedOfLight, speedOfLight);
    float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + float3(.5, .5, .5);
    float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(moilerp(min(d, d2), max(d, d2), (OneMinusEPSILON3 - d2) * d)));
}
float3 LightSigmoid(float3 value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT)
{
    float3 d = moilerp(EPSILON3, OneMinusEPSILON3, (max(((value - .5) * speedOfLight) - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + .5)) / max(scalar, EPSILON3);
    float3 v1 = (d - float3(.5, .5, .5)) * float3(speedOfLight, speedOfLight, speedOfLight);
    float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + float3(.5, .5, .5);
    float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(moilerp(min(d, d2), max(d, d2), (OneMinusEPSILON3 - d2) * d)));
}


// **Depth Raw Function**
// =====================
inline float depthRaw(Texture2D<float> depthMap, float2 uv)
{
    float2 oosz = GetOosz(depthMap);
    float d = 
        (clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv, 0), EPSILON, 1.0-EPSILON)+
            (clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv+float2(oosz.x, 0), 0), EPSILON, 1.0-EPSILON) + 
             clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv-float2(oosz.x, 0), 0), EPSILON, 1.0-EPSILON) + 
             clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv+float2(0,oosz.y), 0), EPSILON, 1.0-EPSILON) +
             clamp(1.0-depthMap.SampleLevel(sampleTypeMirror, uv-float2(0,oosz.y), 0), EPSILON, 1.0-EPSILON)/ 4.0)) / 2.0;

    return d;
}

inline float3 depthRaw3(Texture2D<float> depthMap, float2 uv)
{
    float d =  clamp(depthRaw(depthMap, uv), EPSILON, 1.0-EPSILON);
    return float3(d, d, d);
}

// Calculates the gradient of a depth map at a given UV coordinate.
inline float2 GetGradient(Texture2D<float> depthMap, float2 uv)
{
    float2 oosz = GetOosz(depthMap);
    
    float grad1 = depthRaw(depthMap, uv);
    float2 v1 = float2(ddx_fine(grad1), ddy_fine(grad1));
    
    float grad2 = depthRaw(depthMap, uv + oosz);
    float2 v2 = float2(ddx_fine(grad2), ddy_fine(grad2));
    
    return moilerp(float3(v1.xy, grad1), float3(v2.xy, grad2), .5).xy;
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


inline float2 GetGradientRT(Texture2D<float4> depthMap, float2 uv, int axis)
{
    float2 oosz = GetOosz(depthMap);
    
    float f = depthRawRT(depthMap, uv, axis);
    float2 v1 = float2(ddx_fine(f), ddy_fine(f));
    
    f = depthRawRT(depthMap, uv + oosz, axis);
    float2 v2 = float2(ddx_fine(f), ddy_fine(f));
    
    
    return moilerp(float3(v1, 0.0), float3(v2, 0.0), .5).xy;
}

inline float ColorLuminance(float3 color)
{
    return dot(color, float3(0.299, 0.587, 0.114));
}


inline float3 rotatePolarization(float3 color, float angle)
{
    // Simple polarization rotation (assuming linear polarization)
    float2 rotated = float2(color.r * cos(angle) - color.g * sin(angle),
        color.r * sin(angle) + color.g * cos(angle)
    );
    return float3(rotated, color.b);
}

// Function to calculate the Gaussian beam profile
float gaussianBeam(float distance, float beamWidth)
{
    return exp(1.0 - distance / max(beamWidth, EPSILON));
}
float3 gaussianBeam(float3 distance, float beamWidth)
{
    return exp(1.0 - distance / max(beamWidth, EPSILON3));
}
float3 gaussianBeam(float3 distance, float2 beamWidth)
{
    return exp(1.0 - distance / length(max(beamWidth, EPSILON2)));
}
// Helper function to calculate the Gaussian weight

inline float gaussian(float x, float sigma)
{
    return exp(-(x * x) / max(2.0 * sigma * sigma, EPSILON));
}

inline float2 gaussian2D(float2 pos, float2 sigma)
{
    return exp(-(pos.x * pos.x) / max((2.0 * sigma.x * sigma.x), EPSILON) -
               (pos.y * pos.y) / max((2.0 * sigma.y * sigma.y), EPSILON));
}
inline float3 gaussian3D(float3 pos, float3 sigma)
{
    return exp(-(pos.x * pos.x) / max(2.0 * sigma.x * sigma.x, EPSILON) -
               (pos.y * pos.y) / max(2.0 * sigma.y * sigma.y, EPSILON) -
                (pos.z * pos.z) / max(2.0 * sigma.z * sigma.z, EPSILON));
}

float3 gaussianBeamBasic(float2 uv, float beamWaist = 0.1, float peakIntensity = 1.0)
{
      // Center the UV coordinates
    float2 centeredUV = uv - float2(0.5, 0.5);
    
    // Calculate distance from beam center
    float distance = length(centeredUV);
    
    // Calculate intensity using Gaussian function
    float intensity = peakIntensity * gaussian(distance, beamWaist);
    
    return float3(intensity, intensity, intensity);
}

float3 gaussianBeamMoving(float2 uv, float beamWaist = 0.1, float peakIntensity = 1.0, float speed = 0.2, float angle = PI / 4.0)
{
    // Center the UV coordinates
    float2 centeredUV = uv - float2(0.5, 0.5);
    
    // Calculate beam displacement based on time
    float displacement = speed * time;
    float2 movement = displacement * float2(cos(angle), sin(angle));
    
    // Update centered UV with movement
    float2 beamPos = centeredUV - movement;
    
    // Calculate distance from beam center
    float distance = length(beamPos);
    
    
    // Calculate intensity using Gaussian function
    float intensity = peakIntensity * gaussian(distance, beamWaist);
    
    // Assign color with a distinct beam color (e.g., red)
    return float3(intensity, 0.0, 0.0);
}

float3 gaussianBeamInterference(float2 uv, float2 beam1Pos, float2 beam2Pos, float phaseOffset)
{
    // safeNormalize UV coordinates to range [-1,1]
    float2 normUV = (uv - float2(0.5, 0.5)) * 2.0;
    
    // Define Gaussian beam parameters
    float beamWaist = 0.2*f5;
    float peakIntensity = 1.0*f6;
    
    // Beam 1: Static Position
    float distance1 = length(normUV - beam1Pos);
    float3 intensity1 = peakIntensity * gaussian3D(float3(normUV, distance1), float3(normUV, beamWaist));
    
    // Beam 2: Oscillating Position
    float2 oscillation = 10.0 * float2(cos(projectedDepth(depthMap, uv) * 0.01), sin(projectedDepth(depthMap, uv) * 0.05));
    float2 beam2DynamicPos = fmod(beam2Pos, oscillation);
    float distance2 = length(normUV - beam2DynamicPos);
    float intensity2 = peakIntensity * gaussian(distance2, beamWaist);
    
    // Calculate interference based on phase difference
    float phase1 = oscillation.x; // Phase of Beam 1
    float phase2 = phaseOffset; // Phase of Beam 2
    float interference = cos(phase1 - phase2);
    
    // Combine intensities with interference
    float3 combinedIntensity = intensity1 + intensity2 + 2.0 * sqrt(intensity1 * intensity2) * interference;
    
    // Assign color (e.g., blue and green beams)
    float3 color1 = float3(0.0, 0.0, 1.0) * intensity1;
    float3 color2 = float3(0.0, 1.0, 0.0) * intensity2;
    float3 interferenceColor = float3(1.0, 1.0, 1.0) * (2.0 * sqrt(intensity1 * intensity2) * interference);
    
    // Final color with interference
    float3 finalColor = color1 + color2 + interferenceColor;
    
    // safeNormalize and clamp the final color
    finalColor = saturate(finalColor);
    
    return finalColor;
}

float3 gaussianBeamComplex(float2 uv, float2 beamCenter, float beamWaist, float beamDivergence, float3 phaseModulationFrequency, float polarizationAngle = PI / 2.0)
{
    // safeNormalize UV coordinates to range [-1,1]
    float2 normUV = (uv - beamCenter) * 2.0;
    
    // Calculate distance from beam center
    float distance = length(normUV);
    
    // Calculate beam intensity using Gaussian function
    float intensity = gaussian(distance, beamWaist);
    
    // Calculate phase shift based on distance and divergence
    float3 phase = beamDivergence * distance + sin(phaseModulationFrequency) * 0.1;
    
    // Calculate phase modulation
    float2 phaseVectorR = float2(cos(phase.x), sin(phase.x));
    float2 phaseVectorG = float2(cos(phase.y), sin(phase.y));
    float2 phaseVectorB = float2(cos(phase.z), sin(phase.z));
    
    // Apply phase to beam color (e.g., white light)
    float3 beamColor = float3(1.0, 1.0, 1.0) * intensity;
    beamColor *= float3(phaseVectorR.x, phaseVectorG.x, phaseVectorB.x); // Real part of phase
    
    // Apply polarization rotation
    beamColor = rotatePolarization(beamColor, polarizationAngle);
    
    // Assign color with alpha
    return beamColor;
}

float3 GaussianBlurSeparable(Texture2D<float4> tex, float2 uv, float sigma, int radius, float2 oosz)
{
    float3 color = 0.0;
    float totalWeight = 0.0;
    
    // Horizontal pass
    for (int x = -radius; x <= radius; x++)
    {
        float weight = gaussian(float(x), sigma);
        float2 sampleUV = uv + float2(x, 0.0) * oosz;
        color += tex.SampleLevel(sampleTypeMirror, sampleUV, 0).rgb * weight;
        totalWeight += weight;
    }
    
    color /= totalWeight;
    totalWeight = 0.0;
    
    // Vertical pass
    float3 finalColor = 0.0;
    for (int y = -radius; y <= radius; y++)
    {
        float weight = gaussian(float(y), sigma);
        float2 sampleUV = uv + float2(0.0, y) * oosz;
        finalColor += color * weight;
        totalWeight += weight;
    }
    
    finalColor /= max(totalWeight, EPSILON);
    return finalColor;
}


// Calculates the modulation based on depth gradient using a sigmoid function.
inline float2 GetModulation(float2 depthGradient)
{
    return adjustDepthGradientSigmoid(depthGradient, DepthRange);
}


inline float GetModulatedDepthRaw(Texture2D<float> depthMap, float2 uv, int2 offset = int2(0, 0))
{
    float2 oosz = GetOosz(depthMap);
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
    return depthRaw(depthMap, uv + float2(offset) * oosz * modulation);
}

inline float GetModulatedDepth(Texture2D<float> depthMap, float2 uv, int2 offset = int2(0, 0))
{
    float2 oosz = GetOosz(depthMap);
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
    return projectedDepth(depthMap, uv + float2(offset) * oosz * modulation);
}


void CrossLRUDOffsets(float2 oosz, int range, out float2 offsets[4])
{
    float fRange = float(range);
    offsets[0] = float2(fRange, 0.0) * oosz;
    offsets[1] = float2(-fRange, 0.0) * oosz;
    offsets[2] = float2(0.0, fRange) * oosz;
    offsets[3] = float2(0.0, -fRange) * oosz;
}

void CrossLRUDOffsetsMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range, out float2 offsets[4])
{
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
    float fRange = float(range);
    offsets[0] = float2(fRange, 0.0) * oosz * modulation;
    offsets[1] = float2(-fRange, 0.0) * oosz * modulation;
    offsets[2] = float2(0.0, fRange) * oosz * modulation;
    offsets[3] = float2(0.0, -fRange) * oosz * modulation;
}

void XCrossLRUDOffsets(float2 oosz, int range, out float2 offsets[4])
{
    float fRange = float(range);
    // Calculate safeNormalized offsets (relative to pixel center)
    offsets[0] = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    offsets[1] = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    offsets[2] = float2(fRange - 0.5, fRange - 0.5) * oosz;
    offsets[3] = float2(-fRange + 0.5, fRange - 0.5) * oosz;
}

void XCrossLRUDOffsetsMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range, out float2 offsets[4])
{
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
    float fRange = float(range);
    // Calculate safeNormalized offsets (relative to pixel center)
    offsets[0] = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    offsets[1] = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    offsets[2] = float2(fRange - 0.5, fRange - 0.5) * oosz;
    offsets[3] = float2(-fRange + 0.5, fRange - 0.5) * oosz;
}

float4 XCrossLRUDfrawMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range)
{
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
 
    // Calculate safeNormalized offsets (relative to pixel center)
    float2 offset0 = float2(-range + 0.5, -range + 0.5) * oosz;
    float2 offset1 = float2(range - 0.5, -range + 0.5) * oosz;
    float2 offset2 = float2(range - 0.5, range - 0.5) * oosz;
    float2 offset3 = float2(-range + 0.5, range - 0.5) * oosz;
    
    // Perform four separate texture samples
    float depth0 = depthRaw(depthMap, uv + offset0 * modulation);
    float depth1 = depthRaw(depthMap, uv + offset1 * modulation);
    float depth2 = depthRaw(depthMap, uv + offset2 * modulation);
    float depth3 = depthRaw(depthMap, uv + offset3 * modulation);
    
    // Combine the sampled depths into a float4
    float4 gatheredDepths = float4(depth0, depth1, depth2, depth3);
    
    // Return the inverse of the gathered depths
    return float4(1.0, 1.0, 1.0, 1.0) - clamp(gatheredDepths, 0.01, 0.99);
}


float4 XCrossLRUDfraw(float2 oosz, Texture2D<float> depthMap, float2 uv, int range)
{
    float fRange = float(range);
    // Calculate safeNormalized offsets (relative to pixel center)
    float2 offset0 = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    float2 offset1 = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    float2 offset2 = float2(fRange - 0.5, fRange - 0.5) * oosz;
    float2 offset3 = float2(-fRange + 0.5, fRange - 0.5) * oosz;
    
    // Perform four separate texture samples
    float depth0 = depthRaw(depthMap, uv + offset0);
    float depth1 = depthRaw(depthMap, uv + offset1);
    float depth2 = depthRaw(depthMap, uv + offset2);
    float depth3 = depthRaw(depthMap, uv + offset3);
    
    // Combine the sampled depths into a float4
    float4 gatheredDepths = float4(depth0, depth1, depth2, depth3);
    
    // Return the inverse of the gathered depths
    return float4(1.0, 1.0, 1.0, 1.0) - clamp(gatheredDepths, 0.01, 0.909);
}

float4 XCrossLRUDf(float2 oosz, Texture2D<float> depthMap, float2 uv, float range)
{
    float4 ret = XCrossLRUDfraw(oosz, depthMap, uv, range);
    return float4(projectDepth(ret.x),projectDepth(ret.y),projectDepth(ret.z),projectDepth(ret.w));

}

inline int SampleRateFromRange(int range)
{
    int sampleRate = 1;
    if (range >= 50)
    {
        sampleRate = 10;
    }
    else if (range >= 10)
    {
        sampleRate = 5;
    }
    else if (range >= 4)
    {
        sampleRate = 2;
    }
    return sampleRate;
}

// Optimized CrossLRUDfraw with Dynamic Loop and Branching
float4 CrossLRUDfraw(Texture2D<float> depthMap, float2 uv, int range)
{
    range = max(1, range);
    float2 oosz = GetOosz(depthMap);
    float4 ret = 0.0;
    int samples = 0;

    range = clamp(range, 1, 100);
    int sampleRate = SampleRateFromRange(range);
    
    // Dynamic loop for variable range
    [loop]
    for (int i = -range; i <= range; i += sampleRate)
    {
        // Branching to avoid sampling the same point twice
        if (i != 0)
        {
            float2 offset0 = float2(float(i), 0.0) * oosz;
            float2 offset1 = float2(-float(i), 0.0) * oosz;
            float2 offset2 = float2(0.0, float(i)) * oosz;
            float2 offset3 = float2(0.0, -float(i)) * oosz;
            
            ret.x += depthRaw(depthMap, uv + offset0);
            ret.y += depthRaw(depthMap, uv + offset1);
            ret.z += depthRaw(depthMap, uv + offset2);
            ret.w += depthRaw(depthMap, uv + offset3);
            samples++;
        }
    }

    return ret / max(float(samples), EPSILON);
}

float4 CrossLRUDf(Texture2D<float> depthMap, float2 uv, int range)
{
    range = min(max(range, 1), 30);
 
    float4 ret = ZERO4;
    int samples = 0;
    int sampleRate = SampleRateFromRange(range);
    for (int i = -range; i <= range; i += sampleRate)
    {
        if (i == 0)
            continue;
      
        ret += float4(GetModulatedDepth(depthMap, uv, float2(-float(i), 0.0)),
            GetModulatedDepth(depthMap, uv, float2(float(i), 0.0)),
            GetModulatedDepth(depthMap, uv, float2(0.0, -float(i))),
            GetModulatedDepth(depthMap, uv, float2(0.0, float(i)))
        );
       
        samples++;
    }


    return ret / max(float(samples), EPSILON);
}

float calcRange(float2 v)
{
    float maxValue = max(v.x, v.y);
    float minValue = min(v.x, v.y);
    return maxValue - minValue;
}
float3 calcRange(float3 v)
{
    float3 maxValue = MaxComponent3(v);
    float minValue = MinComponent3(v);
    return maxValue - minValue;
}

inline float noiseFastRange21(float2 range, float2 v)
{
    // This ould be replaced with an actual noise function like Simplex or Perlin noise
    return moilerp(range, noiseFast01(v));
}
inline float3 noiseFastRange3(float3 rangeStart, float3 rangeSize, float3 v)
{
    // This ould be replaced with an actual noise function like Simplex or Perlin noise
    return moilerp(rangeStart, rangeStart + rangeSize, clamp((v - rangeStart) / max(rangeSize, EPSILON), 0.0, 1.0));

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

float3 noise3(Texture2D<float3> noiseMap, float2 n, float z = 0, float scalarUV = 1.0, float scalarZ = 1.0)
{
    return noise3(noiseMap, n.xy, z, scalarUV, scalarZ);
}

inline float3 noise3_01i1(int2 uv)
{
    return clamp(noiseMap1.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);
}
inline float3 noise3_01i2(int2 uv)
{
    return clamp(noiseMap2.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);
}
inline float3 noise3_01i3(int2 uv)
{
    return clamp(noiseMap3.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);
}
inline float3 noise3_01i4(int2 uv)
{
    return clamp(noiseMap4.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);
}

inline bool isOob(int3 xyz, int3 dim)
{
    return (xyz.x >= dim.x) || (xyz.y >= dim.y) || (xyz.z >= dim.z);
}
inline int3 overflowDim(int3 xyz, int3 dim)
{
    if (xyz.x >= dim.x)
    {
        xyz.x = xyz.x - dim.x;
        xyz.y = xyz.y + 1.0;
    }
    if (xyz.y >= dim.y)
    {
        xyz.x = xyz.x - dim.x;
        xyz.y = xyz.y + 1.0;
    }
    if (xyz.z >= dim.z)
    {
        xyz.z = xyz.z - dim.z;
        xyz.x = xyz.x + 1.0;
    }
    return xyz;
}

inline float3 noise3_01i(int3 uv)
{
    int3 sz = int3(GetSz3i(noiseMap1), 4);
    
    int x = uv.x;
    int y = uv.y;
    int z = uv.z;
    
    int shiftCount = 0;
    while (isOob(uv, sz) && shiftCount < 2)
    {
        uv = overflowDim(uv, sz);
        shiftCount++;
    }
    
    switch (int(fmod(uv.z, 4)))
    {
        case 3:
            return noise3_01i4(uv.xy);
        case 2:
            return noise3_01i3(uv.xy);
        case 1:
            return noise3_01i2(uv.xy);
        default:
            return noise3_01i1(uv.xy);
    }
    return noise3_01i1(uv.xy);
}
inline float3 noise3_11i1(int2 uv)
{
    return normalize(clamp(noiseMap1.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
float3 noise3_11i2(int2 uv)
{
    return normalize(clamp(noiseMap2.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
inline float3 noise3_11i3(int2 uv)
{
    return normalize(clamp(noiseMap3.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
inline float3 noise3_11i4(int2 uv)
{
    return normalize(clamp(noiseMap4.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
inline float3 noise3_11i(int3 uv)
{
    switch (uv.z)
    {
        case 3:
            return noise3_11i4(uv.xy);
        case 2:
            return noise3_11i3(uv.xy);
        case 1:
            return noise3_11i2(uv.xy);
        default:
            return noise3_11i1(uv.xy);
    }
}

// Permutation table
static const int perm[512] =
{
    151, 160, 137, 91, 90, 15,
		131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
		190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
		88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
		77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
		102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
		135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
		5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
		223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
		129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
		251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
		49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
		138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180, 151, 160, 137, 91, 90, 15,
		131, 13, 201, 95, 96, 53, 194, 233, 7, 225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23,
		190, 6, 148, 247, 120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
		88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134, 139, 48, 27, 166,
		77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220, 105, 92, 41, 55, 46, 245, 40, 244,
		102, 143, 54, 65, 25, 63, 161, 1, 216, 80, 73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196,
		135, 130, 116, 188, 159, 86, 164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123,
		5, 202, 38, 147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189, 28, 42,
		223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101, 155, 167, 43, 172, 9,
		129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232, 178, 185, 112, 104, 218, 246, 97, 228,
		251, 34, 242, 193, 238, 210, 144, 12, 191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107,
		49, 192, 214, 31, 181, 199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254,
		138, 236, 205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180
};



// Linear interpolation
inline float lerpPN(float t, float a, float b)
{
    return a + t * (b - a);
}
// Gradient function optimized for speed
inline float grad(int hash, float x, float y, float z)
{
    int h = hash & 15;
    float u = h < 8 ? x : y;
    float v = h < 4 ? y : (h == 12 || h == 14 ? x : z);
    return ((h & 1) ? -u : u) + ((h & 2) ? -v : v);
}

// Fade function using optimized polynomial
inline float fade(float t)
{
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

// Optimized Perlin Noise function
float noisePerlin11(float x, float y, float z)
{
    // Find unit cube that contains point
    int X = (int(floor(x)) & 255);
    int Y = (int(floor(y)) & 255);
    int Z = (int(floor(z)) & 255);
    
    // Find relative x, y, z of point in cube
    x -= floor(x);
    y -= floor(y);
    z -= floor(z);
    
    // Compute fade curves for each of x, y, z
    float u = fade(x);
    float v = fade(y);
    float w = fade(z);
    
    // Hash coordinates of the cube corners
    int A = perm[X] + Y;
    int AA = perm[A] + Z;
    int AB = perm[A + 1] + Z;
    int B = perm[X + 1] + Y;
    int BA = perm[B] + Z;
    int BB = perm[B + 1] + Z;
    
    // Add blended results from 8 corners of the cube
    float res = lerpPN(w,
                    lerpPN(v,
                        lerpPN(u, grad(perm[AA], x, y, z),
                                 grad(perm[BA], x - 1, y, z)),
                        lerpPN(u, grad(perm[AB], x, y - 1, z),
                                 grad(perm[BB], x - 1, y - 1, z))),
                    lerpPN(v,
                        lerpPN(u, grad(perm[AA + 1], x, y, z - 1),
                                 grad(perm[BA + 1], x - 1, y, z - 1)),
                        lerpPN(u, grad(perm[AB + 1], x, y - 1, z - 1),
                                 grad(perm[BB + 1], x - 1, y - 1, z - 1))));
    
    return res;
}


inline float3 noisePerlin113(float2 xy, float z = 0.0)
{
    return float3(noisePerlin11(xy.x * 23.543, xy.y * 342.234, z * 3134.323 + time), noisePerlin11(xy.x * 34.343, xy.y * 1343.23, z * 2341.324 + time), noisePerlin11(xy.x * 7.13423, xy.y * 1234.334, z * 1213.234 + time));
}
inline float3 noisePerlin113(float3 xyz)
{
    return noisePerlin113(xyz.xy, xyz.z);
}

inline float noisePerlin11(float2 xy)
{
    return noisePerlin11(xy.x, xy.y, 0.0);
}
inline float noisePerlin01(float x, float y, float z)
{
    return noisePerlin11(x, y, z) * .5 + .5;
}
inline float noisePerlin01(float3 xyz)
{
    return noisePerlin01(xyz.x, xyz.y, xyz.z);
}
inline float noisePerlin01(float2 xy)
{
    return noisePerlin01(xy.x, xy.y, 0.0);
}
inline float noisePerlin01(float2 xy, float z)
{
    return noisePerlin01(xy.x, xy.y, z);
}
inline float3 noisePerlin013(float3 xyz)
{
    return noisePerlin113(xyz.xy, xyz.z) * .5 + .5;
}
inline float2 noisePerlin012(float2 xy)
{
    return noisePerlin113(xy, time).xy * .5 + .5;
}


struct Material
{
    float wavelength;
// Reflection coefficient of the material.
    float reflection;
// Transmission coefficient of the material.
    float transmission;

// Absorption coefficient of the material.
    float absorption;

// Anisotropy factor for scattering.
    float g;

// Strength of the interference effect.
    float interferenceStrength;

// Reference point in the material (e.g., for parallax mapping).
    float3 referencePoint;

// Scattering coefficient of the material.
    float scatteringCoefficient;

// Normal vector at the surface of the material.
    float3 normal;

// Refractive index of the material.
    float refractiveIndex;

// Emission color of the material.
    float3 emission;

// Base color of the material.
    float3 baseColor;

// Smoothness of the material surface.
    float smoothness;

// Metalness of the material.
    float metalness;
};

// Adjusts the depth value using a sigmoid function.
inline float adjustDepthSigmoid(float depth, float2 nearFar)
{
    nearFar = float2(min(nearFar.x, nearFar.y), max(nearFar.x, nearFar.y));
    float sigmoidValue = sigmoid(safeNormalizeRange(nearFar, depth));
    return moilerp(nearFar.x, nearFar.y, sigmoidValue);
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
    float zM = (-depthRawVal + 1.) * max(worldSizeM.x, worldSizeM.y);
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

    float t = 0.02; // edge threshold in 0-1 depth
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
    if (N.z < 0) N = -N; // guard only; no longer expected to fire

    float3 T = normalize(edgeX - N * dot(edgeX, N));
    float3 B = cross(N, T);

    return float3x3(T, B, N);
}
float3 CalcNormal(Texture2D<float> depthMap, float2 uv, int radius = 1)
{
    return CalcTangentToWorld(depthMap, uv, (float)radius)[2];
}

// Optimized noise - your old one called CalcNormal inside noise = 300 samples
inline float3 noiseFast013(float3 v)
{
    float3 p = frac(v * 0.173);
    p += dot(p, p.yzx + 33.33);
    return frac((p.xxy + p.yzz) * p.zyx);
}

// Optimized Cross - was 120 normals = 360 depth fetches
float4 CrossLRUDNdotV(Texture2D<float> depthMap, float2 uv, float3 viewDir, int range)
{
    range = clamp(range, 1, 8);
    float2 oosz = GetOosz(depthMap) * range;

    float3 nL = CalcNormal(depthMap, uv + float2(-oosz.x, 0), 1);
    float3 nR = CalcNormal(depthMap, uv + float2( oosz.x, 0), 1);
    float3 nD = CalcNormal(depthMap, uv + float2(0, -oosz.y), 1);
    float3 nU = CalcNormal(depthMap, uv + float2(0, oosz.y), 1);

    return float4(dot(nL, viewDir), dot(nR, viewDir), dot(nD, viewDir), dot(nU, viewDir));
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


float3 WavelengthsToRGB(float3 wavelengthsNM)
{
    // Convert each wavelength in meters to nanometers
    float3 lambda = wavelengthsNM;

    // Step 1: Convert each wavelength to XYZ color representation with weighting
   //float3 weight = WavelengthWeight(lambda);
   
    return max(EPSILON3, moilerp(MIN_WAVELENGTHS, MAX_WAVELENGTHS, wavelengthsNM) - MIN_WAVELENGTHS) / WAVELENGTH_RANGES;
   /*
    float3 XYZ = float3(0, 0, 0);
    // Step 3: Convert XYZ to linear RGB
    float3 linearRGB = XYZToLinearRGB(XYZ);
    // Step 4: safeNormalize and clamp to avoid negative artifacts
    linearRGB = max(linearRGB, 0.0);
    
    // Step 5: Apply gamma correction to convert to sRGB
    float3 srgb = LinearRGBToSRGB(linearRGB);
    // Step 6: Clamp final RGB values to [0, 1]
    srgb = saturate(srgb);
    
    return srgb;*/
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


// Sample visible spectrum with importance sampling
void SampleSpectrum(float2 uv, float3 rgb, float seed, out Wavefront samples[SPECTRAL_COUNT])
{
    // Convert RGB peak to dominant wavelength + spectral spread
    float3 wavelengthsNM = RGBToWavelengthsNM(rgb);
    float dominantNM = dot(wavelengthsNM, float3(0.299, 0.587, 0.114));
    float spreadNM = abs(wavelengthsNM.x - wavelengthsNM.z) * 0.5 + 20.0;
    
    float temperatureK = lerp(3000.0, 7500.0, ColorLuminance(rgb));
    
    [unroll]
    for (int i = 0; i < SPECTRAL_COUNT; ++i)
    {
        float t = (float(i) + 0.5) / float(SPECTRAL_COUNT);
        // Stratified sampling with blue-noise jitter
        float jitter = frac(sin(dot(float2(t, seed), float2(12.9898, 78.233))) * 43758.5453);
        float3 lambdaNM = dominantNM + spreadNM * (t + jitter * 0.8 - 0.9);

        samples[i].color = WavelengthsToRGB(lambdaNM);
        samples[i].wavelengthMeters = nmToM(lambdaNM);
        samples[i].amplitude = SpectralPower(lambdaNM, temperatureK);
        // Speckle phase: random but deterministic per pixel for temporal stability
        samples[i].phase = frac(sin(dot(float3(uv, seed + float(i) * 0.618), 
            float3(43.123, 21.431, 09.132))) * 31415.92653) * TWO_PI;
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


// ---------------------------------------------------------------------------
// Kogelnik Coupled-Wave Theory for Volume Phase Holograms
// ---------------------------------------------------------------------------
float2 KogelnikDiffractionEfficiency(
    float  lambdaM,
    float  thetaObject,      // angle inside medium
    float  thetaReference,   // angle inside medium
    float  thicknessM,       // emulsion thickness
    float  dn,               // refractive index modulation
    float  n0,               // average refractive index
    float  polarizationAngle // 0 = S, PI/2 = P
)
{
    // Grating vector magnitude
    float K = (TWO_PI * n0 / lambdaM) * (cos(thetaObject) - cos(thetaReference));
    float beta = TWO_PI * n0 / lambdaM;
    
    // Coupling coefficient (kappa)
    float kappa = PI * dn / lambdaM;
    // Polarization dependence: S-pol has full coupling, P-pol reduced
    float polFactor = lerp(1.0, cos(thetaObject + thetaReference), 
        pow(sin(polarizationAngle), 2.0));
    kappa *= polFactor;
    
    // Detuning parameter (xi) - accounts for Bragg mismatch
    float deltaTheta = thetaObject - thetaReference;
    float xi = deltaTheta * beta * thicknessM * sin(thetaReference);
    
    // General solution for finite thickness
    float v = kappa * thicknessM;
    float sqrtTerm = sqrt(xi * xi - v * v + 0.000001);
    
    // Diffraction efficiency for transmission geometry
    float eta = pow(sin(sqrtTerm), 2.0) / (1.0 + xi * xi / (v * v + 0.000001));
    
    // Higher order suppression in thick holograms
    float orderSuppression = exp(-thicknessM * 1000.0 * abs(deltaTheta));
    
    return float2(eta * orderSuppression, 1.0 - eta); // (diffracted, transmitted)
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
    
    // Circular complex Gaussian random variable
    float2 noiseUV = uv * 512.0 + frac(seed) * 100.0;
    float theta1 = frac(sin(dot(noiseUV, float2(127.1, 311.7))) * 43758.5453) * TWO_PI;
    float theta2 = frac(sin(dot(noiseUV + 0.5, float2(269.5, 183.3))) * 43758.5453) * TWO_PI;
    
    // Box-Muller transform for Gaussian
    float u1 = frac(sin(dot(noiseUV, float2(17.0, 43.0))) * 43758.5453);
    float u2 = frac(sin(dot(noiseUV, float2(73.0, 91.0))) * 43758.5453);
    float radius = sqrt(-2.0 * log(max(u1, 0.0001)));
    float gaussReal = radius * cos(theta1);
    float gaussImag = radius * sin(theta1);
    
    // Intensity = |E|^2, but we want field amplitude
    float3 speckleAmplitude = sqrt(max(gaussReal * gaussReal + gaussImag * gaussImag, 0.0));
    speckleAmplitude = lerp(1.0, speckleAmplitude, contrast);
    
    // Phase from surface roughness
    float3 specklePhase = theta2 * contrast;
    
    // Combine: new field = base * speckle_amplitude * exp(i * speckle_phase)
    float3 result;
    result.r = baseField.r * speckleAmplitude.r * (0.5 + 0.5 * cos(time+specklePhase.r));
    result.g = baseField.g * speckleAmplitude.g * (0.5 + 0.5 * cos(time+specklePhase.g + 0.3));
    result.b = baseField.b * speckleAmplitude.b * (0.5 + 0.5 * cos(time+specklePhase.b + 0.6));
    
    return result;
}

// ---------------------------------------------------------------------------
// Your ReconstructHologram - fixed to work with above
// ---------------------------------------------------------------------------
float3 ReconstructHologram(float2 uv,
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
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, 1.0);
    float3 N = tangentToWorld[2];
    float3 reconDir = safeNormalize(lightPosM - pixelPosM);
    float3 objectDir = float3(0,0,1);

    float thicknessM = mmToM(thicknessMM);
    float thetaRef = acos(saturate(dot(reconDir, float3(0,0,1)))); // in TBN, N=(0,0,1)
    float thetaObj = 0;

    Wavefront spectrum[SPECTRAL_COUNT];
    SampleSpectrum(uv, wavelengthsNM, seed, spectrum);

    float3 accumulated = 0; float3 totalWeight = 0;

    [unroll]
    for (int s = 0; s < SPECTRAL_COUNT; ++s)
    {
        float3 lambdaM = spectrum[s].wavelengthMeters;
        float3 k = TWO_PI / lambdaM;
        float3 opd = dot(pixelPosM, objectDir - reconDir);
        float3 visibility = TemporalCoherenceEnvelope(opd, coherenceLengthM);

        
        // One Kogelnik eval per wavelength, not 3x
        float2 efficiencyX = KogelnikDiffractionEfficiency(
            lambdaM.x, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float2 efficiencyY = KogelnikDiffractionEfficiency(
            lambdaM.y, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float2 efficiencyZ = KogelnikDiffractionEfficiency(
            lambdaM.z, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float3 eta = float3(length(efficiencyX), length(efficiencyY), length(efficiencyZ)) * visibility;


        float3 orderColor = 0;
        [unroll]
        for (int m = -MAX_DIFFRACTION_ORDERS; m <= MAX_DIFFRACTION_ORDERS; ++m)
        {
            float ow = (m == 1)? 1.0 : 0.1 / (1.0 + abs(float(m-1))*2.0);
            float3 phase = k * opd + spectrum[s].phase;
            float3 interf = lerp(0.5, 0.5 + 0.5 * cos(phase), fringeScale);
            float3 rgb = WavelengthsToRGB(mToNm(lambdaM));
            orderColor += rgb * interf * eta * ow;
        }

        orderColor = GenerateSpeckleField(pixelPosM.xy, orderColor, 0.5e-6, lambdaM, seed + float(s));
        accumulated += orderColor * spectrum[s].amplitude;
        totalWeight += spectrum[s].amplitude;
    }
    return accumulated / max(totalWeight, EPSILON);
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
    float r = diffuseMap.SampleLevel(sampleTypeMirror, float2(uv + oosz * float2(radius, 0.0)), 0).r * rainbowColor(dot(viewDir, particleNormal)).r;
    float g = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).g;
    float b = diffuseMap.SampleLevel(sampleTypeMirror, float2(uv - oosz * float2(radius, 0.0)), 0).b * rainbowColor(dot(viewDir, particleNormal)).b;
    return float3(r, g, b);
}


// 2. Chromatic Aberration (RGB Split)
inline float3 ppChromaticAberration(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv, float radius, float3 viewDir = float3(0.0, 0.0, -1.0), float3 particleNormal = float3(0.0, 0.0, 1.0), float mix = 1.0)
{
    float pd = projectedDepth(depthMap, uv);
    float3 n33 = noise3(noiseMap1, float3(uv, pd + TotalTime * AnimateSpeed * .1));
    float n1 = noise3(noiseMap1, float3(uv, pd)).x;
    float2 oosz = GetOosz(diffuseMap);
    float4 offset = float4(radius * 3.0 * oosz.x, -radius * 3.0 * oosz.x, radius * oosz.y, -radius * oosz.y) * float4(n33, n1);
    return moilerp(
            mir2D(diffuseMap, uv).xyz,
                float3(
                    mir2D(diffuseMap, uv + offset.xy).r * rainbowColor(dot(viewDir, particleNormal)).r,
                    mir2D(diffuseMap, uv + offset.yz).g,
                    mir2D(diffuseMap, uv + offset.zw).b * rainbowColor(dot(viewDir, particleNormal)).b
    ), mix * .99);
}
inline float3 ppChromaticAberrationUV(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv, float amount, float speed = 1.0)
{
    float v = time * speed;
    float animatedAmount = amount * (1.0 + cos(v) * 0.1);
    return ppChromaticAberration(diffuseMap, depthMap, uv, animatedAmount);
}

float3 ApplyChromaticAberration(float2 oosz, Texture2D<float4> diffuseMap, float2 uv, float3 intensityPixels, float depth, float3 viewDir = float3(0.0, 0.0, -1.0), float3 particleNormal = float3(0.0, 0.0, 1.0))
{
    // Offsets for RGB channels
    float2 redOffset = uv + intensityPixels.x * float2(-5.0, -3.0) * oosz * depth;
    float2 greenOffset = uv;
    float2 blueOffset = uv + intensityPixels.z * float2(-5.0, 3.0) * oosz * depth;

    // Sample texture with offsets
    float3 color = float3(
        diffuseMap.SampleLevel(sampleTypeMirror, redOffset, 0).r * rainbowColor(dot(viewDir, particleNormal)).r,
        diffuseMap.SampleLevel(sampleTypeMirror, greenOffset, 0).g,
        diffuseMap.SampleLevel(sampleTypeMirror, blueOffset, 0).b * rainbowColor(dot(viewDir, particleNormal)).b);

    return color;
}

// ---------------------------------------------------------------------------
// Your PS_Interference - now uses correct tangentToWorld naming
// ---------------------------------------------------------------------------
float4 PS_Interference(PS_INPUT input) : SV_Target
{
    float2 uv = input.uv;

    float depthRaw = projectedDepth(depthMap, uv);
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, NormalRadius);
    
    float3 normal = normalize(tangentToWorld[2]);
    float2 pitchM = PixelPitchM(depthMap);
    float3 pixelPosM = UVDepthToMetersM(uv, depthRaw, pitchM);

    float3x3 worldToTangent = transpose(tangentToWorld);

    float3 viewPosW = float3(ViewX, ViewY, ViewZ);
    float3 lightPosW = float3(SunX, SunY, SunZ);

    float3 tbnViewPos = mul(worldToTangent, viewPosW - pixelPosM);
    float3 tbnLightPos = mul(worldToTangent, lightPosW - pixelPosM);
    float3 tbnPixelPos = float3(0,0,0);

    float3 pixelDiffuse = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).rgb;
    float3 baseWavelengths = RGBToWavelengthsNM(pixelDiffuse);

    float coherenceLengthM = f12;
    float3 fringeScale = saturate(RGBToWavelengthsNM(pixelDiffuse)*1e-9 / max(0.5*(pitchM.x+pitchM.y)*DepthScale, EPSILON));

    float3 hologram = ReconstructHologram(uv, tbnPixelPos, tbnViewPos, tbnLightPos,
        baseWavelengths, coherenceLengthM, fringeScale.x,
        VOLUME_HOLOGRAM_THICKNESS_MM, REFRACTIVE_INDEX_MODULATION, SPECKLE_SEED, f11);

    float3 viewDirW = safeNormalize(viewPosW - pixelPosM);
    float3 lightDirW = safeNormalize(lightPosW - pixelPosM);
    float NdotL = saturate(dot(normal, lightDirW));

    float3 baseColor = pixelDiffuse * NdotL;
    float3 finalColor = lerp(baseColor, hologram, NdotL); // vivid blend

    if (PassNum > 0)
    {
        float3 disp = abs(f11 * depthRaw) * fringeScale;
        finalColor += ChromaticAberration(rtMap1, uv, NormalRadius, disp) * f9;
    }
    
    finalColor = finalColor * (1.051 * finalColor + 0.03) / (finalColor * (0.43 * finalColor + 0.59) + 0.14);
    return float4(saturate(finalColor), 1.0);
}


inline float3 normal2D4(Texture2D<float4> normalMap, float2 uv)
{
    return safeNormalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz * 2.0 - 1.0);
}
inline float3 normal2D(Texture2D<float3> normalMap, float2 uv)
{
    return safeNormalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz * 2.0 - 1.0);
}



// Initializes the GradientModulationConfig structure with initial values.
GradientModulationConfig InitializeConfig(float3 viewPos, float2 uv0)
{
    GradientModulationConfig ret = config;
    // Set initial UV coordinates.
    ret.uv0 = ret.uv = uv0;

// Get inverse texture sizes.
    ret.oosz = GetOosz(depthMap);
    ret.ooszd = GetOosz(diffuseMap);
    ret.ooszrt = GetOosz(rtMap1);

    // Set initial view position.
    ret.viewPos = ret.viewPos0 = viewPos;

    // Calculate initial depth, normal, gradient, and modulation.
    
    ret.gradient = ret.gradient0 = GetGradient(depthMap, uv0);
    ret.modulation = ret.modulation0 = GetModulation(ret.gradient);
    ret.depth = ret.depth0 = projectedDepth(depthMap, ret.uv);
    ret.normal = ret.normal0 = CalcNormal(depthMap, ret.uv);
    // Calculate inverse depth.
    ret.invDepth = (1.0 - ret.depth0);

    // Calculate scaled pixel positions.
    ret.pixelScaled = ret.pixel0Scaled = float3(ret.uv, ret.depth);
    

// Calculate view direction.
    ret.viewDir0 = safeNormalize(ret.viewPos0 - ret.pixel0Scaled);
    ret.viewDir = safeNormalize(ret.viewPos - ret.pixelScaled);
  
    // Calculate distance to the view position.
    ret.viewDist = distance(ret.pixelScaled, ret.viewPos);
    
    ret.sunPos = float3(SunX,SunY,SunZ);
         
// Calculate vector and direction from pixel to the sun.
    ret.pixelToSunSegment = ret.sunPos - ret.pixelScaled;
    ret.pixel0ToSunSegment = ret.sunPos - ret.pixel0Scaled;
    
    ret.pixel0ToSunDir = safeNormalize(ret.pixel0ToSunSegment);
    ret.pixelToSunDir = safeNormalize(ret.pixelToSunSegment);
// Calculate sun half vector.
    ret.sunHalfVec = safeNormalize(ret.pixelToSunDir + ret.viewDir);
    
// Calculate dot products for lighting calculations.
    ret.HdotV = clamp(dot(ret.sunHalfVec, ret.viewDir), 0.0, 1.0);
    ret.VdotL = clamp(dot(ret.pixelToSunDir, ret.viewDir), 0.0, 1.0);
    ret.HdotN = clamp(dot(ret.sunHalfVec, ret.normal), 0.0, 1.0);
    ret.NdotV = clamp(dot(ret.normal, ret.viewDir), 0.0, 1.0);
    ret.NdotL = clamp(dot(ret.pixelToSunDir, ret.normal), 0.0, 1.0);
    ret.HdotL = clamp(dot(ret.sunHalfVec, ret.pixelToSunDir), 0.0, 1.0);
    
    
    ret.diffuse = mir2D(diffuseMap, ret.uv0);
    ret.reflectDir = safeNormalize(-reflect(-ret.viewDir, ret.normal));
    
    ret.HdotR = clamp(dot(ret.sunHalfVec, ret.reflectDir), 0.0, 1.0);
    ret.RdotL = clamp(dot(ret.pixelToSunDir, ret.reflectDir), 0.0, 1.0);
    ret.NdotR = clamp(dot(ret.normal, ret.reflectDir), 0.0, 1.0);
    
    
    ret.normal = CalcNormal(depthMap, ret.uv, NormalRadius);
    ret.tangent = safeNormalize(float3(1.0, 0.0, 0.0) - dot(float3(1.0, 0.0, 0.0), ret.normal) * ret.normal);
    ret.bitangent = safeNormalize(cross(ret.normal, ret.tangent));
    ret.tangentToWorld = float3x3(ret.tangent, ret.bitangent, ret.normal);
    
    
    ret.reflectDirTS = safeNormalize(mul(ret.tangentToWorld, ret.reflectDir));
    ret.normalTS = safeNormalize(mul(ret.tangentToWorld, ret.normal));
    
    ret.lightDirTS = safeNormalize(mul(ret.tangentToWorld, ret.pixelToSunDir));
    ret.viewDirTS = safeNormalize(mul(ret.tangentToWorld, ret.viewDir));
    ret.halfDirTS = safeNormalize(mul(ret.tangentToWorld, ret.sunHalfVec));

    
    ret.NdotV_TS = max(dot(ret.normalTS, ret.viewDirTS), 0.0);
    ret.NdotL_TS = max(dot(ret.tangentToWorld[2], ret.lightDirTS), 0.0);
    ret.HdotN_TS = max(dot(ret.tangentToWorld[2], ret.halfDirTS), 0.0);
    ret.HdotV_TS = max(dot(ret.halfDirTS, ret.viewDirTS), 0.0);
    ret.NdotR_TS = max(dot(ret.tangentToWorld[2], ret.reflectDirTS), 0.0);
    
    ret.TdotV_TS = max(dot(ret.tangentToWorld[0], ret.viewDirTS), 0.0);
    ret.TdotL_TS = max(dot(ret.tangentToWorld[0], ret.lightDirTS), 0.0);
    ret.TdotN_TS = max(dot(ret.tangentToWorld[0], ret.halfDirTS), 0.0);
    ret.TdotR_TS = max(dot(ret.tangentToWorld[0], ret.reflectDirTS), 0.0);
    
    ret.BdotV_TS = max(dot(ret.tangentToWorld[1], ret.viewDirTS), 0.0);
    ret.BdotL_TS = max(dot(ret.tangentToWorld[1], ret.lightDirTS), 0.0);
    ret.BdotN_TS = max(dot(ret.tangentToWorld[1], ret.halfDirTS), 0.0);
    ret.BdotR_TS = max(dot(ret.tangentToWorld[1], ret.reflectDirTS), 0.0);
    
    config = ret;
    
    return ret;
}


// Updates the GradientModulationConfig structure with new values.
GradientModulationConfig UpdateConfig(inout GradientModulationConfig ret, float2 uv0)
{
    
    // Get inverse texture sizes.
    ret.oosz = GetOosz(depthMap);
    ret.ooszd = GetOosz(diffuseMap);
    ret.ooszrt = GetOosz(rtMap1);

    ret.uv = uv0;
    ret.depth = projectedDepth(depthMap, ret.uv);
    ret.invDepth = (DepthScale - ret.depth);
    ret.diffuse = mir2D(diffuseMap, ret.uv);
    
    
    // Calculate scaled pixel position.
    
    ret.pixelScaled = float3(ret.uv, ret.depth);
    // Calculate view direction.
    ret.viewDir = safeNormalize(ret.viewPos - ret.pixelScaled);
   
    
    ret.gradient = GetGradient(depthMap, ret.uv);
    ret.modulation = GetModulation(ret.gradient);
    ret.normal = CalcNormal(depthMap, ret.uv);
    
    ret.viewDist = distance(ret.pixelScaled, ret.viewPos);

    ret.sunPos = float3(SunX,SunY,SunZ);

    // Calculate vector and direction from pixel to the sun.
    ret.pixelToSunSegment = ret.sunPos - ret.pixelScaled;
    ret.pixelToSunDir = safeNormalize(ret.pixelToSunSegment);

// Calculate sun half vector.
    ret.sunHalfVec = safeNormalize(ret.pixelToSunDir + ret.viewDir);

    // Calculate dot products for lighting calculations.
    ret.HdotV = clamp(dot(ret.sunHalfVec, ret.viewDir), 0.0, 1.0);
    ret.VdotL = clamp(dot(ret.pixelToSunDir, ret.viewDir), 0.0, 1.0);
    ret.HdotN = clamp(dot(ret.sunHalfVec, ret.normal), 0.0, 1.0);
    ret.HdotL = clamp(dot(ret.sunHalfVec, ret.pixelToSunDir), 0.0, 1.0);
    ret.NdotV = clamp(dot(ret.normal, ret.viewDir), 0.0, 1.0);
    ret.NdotL = clamp(dot(ret.pixelToSunDir, ret.normal), 0.0, 1.0);
                                
    ret.reflectDir = safeNormalize(reflect(-ret.viewDir, ret.normal));
                                
    ret.HdotR = clamp(dot(ret.sunHalfVec, ret.reflectDir), 0.0, 1.0);
    ret.RdotL = clamp(dot(ret.pixelToSunDir, ret.reflectDir), 0.0, 1.0);
    ret.NdotR = clamp(dot(ret.normal, ret.reflectDir), 0.0, 1.0);
    
    ret.reflectDirTS = safeNormalize(mul(ret.tangentToWorld, ret.reflectDir));
    ret.normalTS = safeNormalize(mul(ret.tangentToWorld, ret.normal));
    ret.lightDirTS = safeNormalize(mul(ret.tangentToWorld, ret.pixelToSunDir));
    ret.viewDirTS = safeNormalize(mul(ret.tangentToWorld, ret.viewDir));
    ret.halfDirTS = safeNormalize(mul(ret.tangentToWorld, ret.sunHalfVec));
    
    ret.NdotV_TS = max(dot(ret.normalTS, ret.viewDirTS), 0.0);
    ret.NdotL_TS = max(dot(ret.tangentToWorld[2], ret.lightDirTS), 0.0);
    ret.HdotN_TS = max(dot(ret.tangentToWorld[2], ret.halfDirTS), 0.0);
    ret.HdotV_TS = max(dot(ret.halfDirTS, ret.viewDirTS), 0.0);
    ret.NdotR_TS = max(dot(ret.tangentToWorld[2], ret.reflectDirTS), 0.0);
                          
    ret.TdotV_TS = max(dot(ret.tangentToWorld[0], ret.viewDirTS), 0.0);
    ret.TdotL_TS = max(dot(ret.tangentToWorld[0], ret.lightDirTS), 0.0);
    ret.TdotN_TS = max(dot(ret.tangentToWorld[0], ret.halfDirTS), 0.0);
    ret.TdotR_TS = max(dot(ret.tangentToWorld[0], ret.reflectDirTS), 0.0);
                          
    ret.BdotV_TS = max(dot(ret.tangentToWorld[1], ret.viewDirTS), 0.0);
    ret.BdotL_TS = max(dot(ret.tangentToWorld[1], ret.lightDirTS), 0.0);
    ret.BdotN_TS = max(dot(ret.tangentToWorld[1], ret.halfDirTS), 0.0);
    ret.BdotR_TS = max(dot(ret.tangentToWorld[1], ret.reflectDirTS), 0.0);
    
    return ret;
}



// Calculates the GGX (Trowbridge-Reitz) normal distribution function.
inline float GGXDistribution(float NdotH, float alphaRoughness)
{
    float alphaRoughness2 = alphaRoughness * alphaRoughness;
    float NdotH2 = NdotH * NdotH;
    float denom = NdotH2 * (alphaRoughness2 - 1.0) + 1.0;
    return alphaRoughness2 / max(PI * denom * denom, EPSILON);
}
// Calculates the Smith correlated GGX geometric shadowing function.
inline float SmithGGXCorrelated(float NdotL, float NdotV, float roughness2)
{
    roughness2 = max(roughness2, EPSILON);
    float a2 = max(roughness2 * roughness2, EPSILON);
    float sqrtNdotV = sqrt(max(NdotV, EPSILON));
    float sqrtNdotL = sqrt(max(NdotL, EPSILON));
    float GGXV = NdotL * (sqrtNdotV * sqrtNdotV * (1.0 - a2) + a2);
    float GGXL = NdotV * (sqrtNdotL * sqrtNdotL * (1.0 - a2) + a2);
    return 0.5 / max(GGXV + GGXL, EPSILON);
}

// Trowbridge-Reitz GGX Distribution
inline float DistributionGGX(float NdotH, float roughness)
{
    float a2 = roughness * roughness;
    float NdotH2 = NdotH * NdotH;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    return a2 / max(PI * denom * denom, EPSILON); // Avoid division by zero
}

// Geometry Smith with Schlick-GGX
inline float GeometrySmith(float NdotV, float NdotL, float roughness)
{
    float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
    float ggx2 = NdotV / max(NdotV * (1.0 - k) + k, EPSILON);
    float ggx1 = NdotL / max(NdotL * (1.0 - k) + k, EPSILON);
    return ggx1 * ggx2;
}

// Helper Function: HSV to RGB Conversion (Credit: Inigo Quilez)
inline float3 HsvToRgb(float3 hsv)
{
    float3 rgb = clamp(abs(hsv.x * 6.0 - 3.0) - 1.0, 1e-9, 0.9999);
    rgb = hsv.z * moilerp(float3(1.0, 1.0, 1.0), rgb, hsv.y);
    return rgb;
}

inline float variation(float3 dc2)
{
    return max(max(dc2.x, dc2.y), dc2.z) - min(min(dc2.x, dc2.y), dc2.z);
}
inline float variation(float4 dc2)
{
    return max(max(max(dc2.x, dc2.y), dc2.z), dc2.w) - min(min(min(dc2.x, dc2.y), dc2.z), dc2.w);
}


inline float RefractiveIndexMM(float wavelengthMicrometers, float A, float B)
{
    // Prevent division by zero
    float lambdaSq = max(wavelengthMicrometers * wavelengthMicrometers, EPSILON);
    return A + B / max(lambdaSq, EPSILON);
}

inline float3 RefractiveIndexMM(float3 wavelengthMicrometers, float3 A, float B)
{
    // Prevent division by zero
    float3 lambdaSq = max(wavelengthMicrometers * wavelengthMicrometers, EPSILON3);
    return A + B / max(lambdaSq, EPSILON3);
}

inline float3 CalculatePhaseShiftsHz(float3 frequenciesHz, float3 refractedDirs)
{
    return angularFrequencyFromHz(frequenciesHz) * length(refractedDirs);
}


inline float CalculatePhaseShiftM(float pathLengthM, float wavelengthM, float refractiveIndex)
{
    // Effective wavelength in the medium
    float effectiveWavelengthM = wavelengthM / max(refractiveIndex, EPSILON);

    // Phase shift (in radians)
    return (2.0 * PI * pathLengthM) / max(effectiveWavelengthM, EPSILON);
}

float3 CalculatePhaseShiftM(float3 pathLengthM, float3 wavelengthM, float3 refractiveIndex)
{
    // Effective wavelength in the medium
    float3 effectiveWavelengthM = wavelengthM / max(refractiveIndex, EPSILON3);

    // Phase shift (in radians)
    return (2.0 * PI * pathLengthM) / max(effectiveWavelengthM, EPSILON3);
}
inline float3 ThinFilmInterference(float3 wavelengthM, float filmThicknessM, float3 nFilm, float3 cosThetaT)
{
    // Optical path difference (OPD)
    float3 OPD = 2.0 * nFilm * filmThicknessM * cosThetaT;
    
    // Phase difference
    float3 phaseDiff = (2.0 * PI * OPD) / max(wavelengthM, EPSILON3);
    
    // Phase shift upon reflection at the first interface (assuming a pi phase shift for reflection from lower to higher index medium)
    float reflectionPhaseShift = PI; // 180 degrees
    
    // Total phase difference
    float3 totalPhase = phaseDiff + reflectionPhaseShift;
    
    // Interference term (constructive or destructive)
    return cos(totalPhase);
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

inline float ComputeDominantWavelength(float2 chroma)
{
    float closestWavelength = 0.0;
    float minDistance = FLT_MAX;
    float maxDistance = 0.001;
        
    for (int i = 0; i < SPECTRAL_LOCUS_COUNT; i++)
    {
        float3 spectralChroma = GetChromaticity(i);
        float distance = ChromaticityDistance(chroma, spectralChroma.xy);
        
        if (distance < minDistance && distance < maxDistance)
        {
            minDistance = distance;
            closestWavelength = MIN_WAVELENGTH + float(i);
        }
    }
    return closestWavelength;
}

float ChromaticityXToWavelength(float x)
{
    float wavelength = 0.0f;

    if (x < 0.2f)
    {
        // Region 1: 380 nm to 440 nm
        // λ = a * x + b
        wavelength = 380.0f + (x / 0.2f) * (440.0f - 380.0f);
    }
    else if (x < 0.3f)
    {
        // Region 2: 440 nm to 490 nm
        wavelength = 440.0f + ((x - 0.2f) / 0.1f) * (490.0f - 440.0f);
    }
    else if (x < 0.4f)
    {
        // Region 3: 490 nm to 510 nm
        wavelength = 490.0f + ((x - 0.3f) / 0.1f) * (510.0f - 490.0f);
    }
    else if (x < 0.5f)
    {
        // Region 4: 510 nm to 580 nm
        wavelength = 510.0f + ((x - 0.4f) / 0.1f) * (580.0f - 510.0f);
    }
    else if (x < 0.6f)
    {
        // Region 5: 580 nm to 645 nm
        wavelength = 580.0f + ((x - 0.5f) / 0.1f) * (645.0f - 580.0f);
    }
    else
    {
        // Region 6: 645 nm to 780 nm
        wavelength = 645.0f + ((x - 0.6f) / 0.2f) * (780.0f - 645.0f);
    }

    // Clamp the wavelength to the visible spectrum
    return clamp(wavelength, MIN_WAVELENGTH, MAX_WAVELENGTH);
    
}

float2 ChromaticityCoordinates(float3 XYZ)
{
    float sumXYZ = XYZ.x + XYZ.y + XYZ.z;
    return sumXYZ > 0 ? float2(XYZ.x / max(sumXYZ, EPSILON), XYZ.y / max(sumXYZ, EPSILON)) : 0;
}

float ChromaticityToWavelengthNM2(float3 rgb, float2 chroma)
{
    float bestWavelength = 0.0;
    float minDistance = FLT_MAX;
    
    for (int i = 0; i < NUM_SAMPLES; ++i)
    {
        float2 d = GetChromaticity(i).xy;
        float distance = d.x * chroma.x + d.y * chroma.y + (1.0 - d.x + d.y) * (1.0 - chroma.x + chroma.y) * (1.0 - d.x + d.y) * (1.0 - chroma.x + chroma.y);
        if (distance < minDistance)
        {
            minDistance = distance;
            bestWavelength = 380.0 + float(i);
        }
    }
    return bestWavelength;
}

float3 ChromaticityToWavelengthNM(float2 chroma)
{
    
    float dominantWavelength = ComputeDominantWavelength(chroma);
    
    bool xyDom = (chroma.x + chroma.y) >= .5;
    float chromaZ = (1.0 - saturate(chroma.x + chroma.y));
    bool xzDom = (chroma.x + chromaZ) >= .5;
    bool yzDom = (chroma.y + chromaZ) >= .5;
    
    float3 wavelengthsNM = ZERO3;
    float maxVal = max(max(chroma.x, chroma.y), chromaZ);
    wavelengthsNM.r = step(maxVal, chroma.x) * dominantWavelength;
    wavelengthsNM.g = step(maxVal, chroma.y) * dominantWavelength;
    wavelengthsNM.b = step(maxVal, chromaZ) * dominantWavelength;

    return wavelengthsNM;
}




float3 RGBToWavelengthsNM3(float3 srgb)
{
    srgb = clamp(srgb, 0.001, 0.999);
    
    // Convert sRGB to linear RGB
    float3 rgb = SRGBToLinear(srgb);

    // Convert linear RGB to XYZ
    float3 XYZ = LinearRGBToXYZ(rgb);

    // Calculate chromaticity coordinates
    float2 xy_ = ChromaticityCoordinates(XYZ);
    
    float3 ret = ChromaticityToWavelengthNM(xy_.xy) * srgb;
    ret = float3(
        ret.x > 0.0 ? ret.x + MIN_WAVELENGTHS.x : 0.0,
        ret.y > 0.0 ? ret.y + MIN_WAVELENGTHS.y : 0.0,
        ret.z > 0.0 ? ret.z + MIN_WAVELENGTHS.z : 0.0);

    return ret;
}

float3 clampWavelengthsNM(float3 wavelengthsNM)
{
    return float3(
        wavelengthsNM.x > 0.0 ? clamp(wavelengthsNM.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x) : 0.0,
        wavelengthsNM.y > 0.0 ? clamp(wavelengthsNM.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y) : 0.0,
        wavelengthsNM.z > 0.0 ? clamp(wavelengthsNM.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z) : 0.0);

}

inline float3 WavelengthWeight(float3 wavelength)
{
    // This weighting function can be improved further based on empirical data
    // or specific requirements for military-grade applications.
    // Example: More precise weighting for human visibility sensitivity.
    //if (wavelength >= 380.0 && wavelength <= 780.0)
    {
        // Gaussian-like weighting for visible spectrum
        float3 mean = dot(wavelength, wavelength) / 2.0;
        float stddev = 60.0;
        return exp(-pow(max(wavelength - mean, EPSILON3), 2.0) / max((2.0 * pow(max(stddev, EPSILON), 2.0)), EPSILON));
    }
    //return 0.01; // Outside visible range
}

float3 RGBToWavelengthsNM4(float3 srgb)
{
    srgb = clamp(srgb, 0.001, 0.999);
    
    // Convert sRGB to linear RGB
    float3 linearRGB = SRGBToLinear(srgb);
    
    // Convert linear RGB to XYZ
    float3 XYZ = LinearRGBToXYZ(linearRGB);
    
    float3 best = ChromaticityToWavelengthNM(XYZToChromaticity(XYZ));
    
    return AddOver0(best, XYZToWavelength(XYZ));
}

float3 RGBToWavelengthsNM2(float3 rgb)
{
    rgb = clamp(rgb, 0.001, 0.999);
    
    float3 linearRGB = SRGBToLinear(rgb);
    
    float3 xyz = LinearRGBToXYZ(linearRGB);
    
    float2 chroma = XYZToChromaticity(xyz);
    
    return ChromaticityToWavelengthNM(chroma);

}

inline float3 RGBToWavelengths(float3 srgb)
{
    float3 linearRGB = clamp(SRGBToLinear(srgb), EPSILON3, OneMinusEPSILON3);
    float3 oo = float3(srgb.x > EPSILON ? OneMinusEPSILON : EPSILON, srgb.y > EPSILON ? OneMinusEPSILON : EPSILON, srgb.z > EPSILON ? OneMinusEPSILON : EPSILON);
    return (linearRGB * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
}

float CIE_xbar(float l)
{
    float t1 = max(0,(l - 442.0) * ((l < 442.0) ? 0.0624 : 0.0374));
    float t2 = max(0,(l - 599.8) * ((l < 599.8) ? 0.0264 : 0.0323));
    float t3 = max(0,(l - 501.1) * ((l < 501.1) ? 0.0490 : 0.0382));
    return saturate(0.362 * exp(-0.5 * t1 * t1)
         + 1.056 * exp(-0.5 * t2 * t2)
         - 0.065 * exp(-0.5 * t3 * t3));
}

float CIE_ybar(float l)
{
    float t1 = max(0,(l - 568.8) * ((l < 568.8) ? 0.0213 : 0.0247));
    float t2 = max(0,(l - 530.9) * ((l < 530.9) ? 0.0613 : 0.0322));
    return saturate(0.821 * exp(-0.5 * t1 * t1)
         + 0.286 * exp(-0.5 * t2 * t2));
}

float CIE_zbar(float l)
{
    float t1 = max(0,(l - 437.0) * ((l < 437.0) ? 0.0845 : 0.0278));
    float t2 = max(0,(l - 459.0) * ((l < 459.0) ? 0.0385 : 0.0725));
    return saturate(1.217 * saturate(exp(-0.5 * t1 * t1))
         + 0.681 * saturate(exp(-0.5 * t2 * t2)));
}

float3 CIE_XYZ(float3 lambdaNM)
{
    return float3(
        CIE_xbar(lambdaNM.x),
        CIE_ybar(lambdaNM.y),
        CIE_zbar(lambdaNM.z)
    );
}


inline float3 LinearRGBToSRGB2(float3 linearRGB)
{
    linearRGB = clamp(linearRGB, EPSILON, 1.0 - EPSILON);
    float3 ret = float3((linearRGB.r <= 0.0031308) ? 12.92 * linearRGB.r : 1.055 * pow(linearRGB.r, 1.0 / 2.4) - 0.055,
        (linearRGB.g <= 0.0031308) ? 12.92 * linearRGB.g : 1.055 * pow(linearRGB.g, 1.0 / 2.4) - 0.055,
        (linearRGB.b <= 0.0031308) ? 12.92 * linearRGB.b : 1.055 * pow(linearRGB.b, 1.0 / 2.4) - 0.055
    );
    return AdjustGamma(ret);
}

inline float3 XYZToLinearRGB2(float3 XYZ)
{
    return float3(3.2406 * XYZ.x - 1.5372 * XYZ.y - 0.4986 * XYZ.z,
        -0.9689 * XYZ.x + 1.8758 * XYZ.y + 0.0415 * XYZ.z,
        0.0557 * XYZ.x - 0.2040 * XYZ.y + 1.0570 * XYZ.z);
}

inline float3 WavelengthToXYZ(float wavelength)
{
    // Ensure wavelength is within the visible spectrum
    wavelength = clamp(wavelength, MIN_WAVELENGTH, MAX_WAVELENGTH);

    int t = int((wavelength - MIN_WAVELENGTH) / (MAX_WAVELENGTH - MIN_WAVELENGTH));

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

float3 WavelengthsToRGB3(float3 wavelength)
{
    // Assuming chromaticity to RGB transformation is defined for white light
    float3 RGB = ZERO3;

    wavelength.x = wavelength.x >= MIN_WAVELENGTHS.x ? clamp(wavelength.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x) : 0.0;
    wavelength.y = wavelength.y >= MIN_WAVELENGTHS.y ? clamp(wavelength.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y) : 0.0;
    wavelength.z = wavelength.z >= MIN_WAVELENGTHS.z ? clamp(wavelength.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z) : 0.0;
    
    float3 wl1 = wavelength.x >= MIN_WAVELENGTHS.x ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.x - MIN_WAVELENGTHS.x)).xy) : 0.0;
    float3 wl2 = wavelength.y >= MIN_WAVELENGTHS.y ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.y - MIN_WAVELENGTHS.y)).xy) : 0.0;
    float3 wl3 = wavelength.z >= MIN_WAVELENGTHS.z ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.z - MIN_WAVELENGTHS.z)).xy) : 0.0;
    
    float3 XYZ0 = WavelengthToXYZ(wavelength.x);
    float3 XYZ1 = WavelengthToXYZ(wavelength.y);
    float3 XYZ2 = WavelengthToXYZ(wavelength.z);
    
    float3 linearRGB = XYZToLinearRGB(XYZ0, XYZ1, XYZ2);
    float3 XYZ_2_0 = AddOver0(WavelengthToXYZ(wl1.x), WavelengthToXYZ(wl2.x), WavelengthToXYZ(wl3.x));
    float3 XYZ_2_1 = AddOver0(WavelengthToXYZ(wl1.y), WavelengthToXYZ(wl2.y), WavelengthToXYZ(wl3.y));
    float3 XYZ_2_2 = AddOver0(WavelengthToXYZ(wl1.z), WavelengthToXYZ(wl2.z), WavelengthToXYZ(wl3.z));
    
    float3 linearRGB2 = XYZToLinearRGB(XYZ_2_0, XYZ_2_1, XYZ_2_2);

    return AddOver0(linearRGB, linearRGB2, .5);

}

float3 WavelengthsToRGB2(float3 wavelengthsM)
{
    // Convert each wavelength to XYZ
    float3 XYZ_R = WavelengthToXYZ(wavelengthsM.r * 1e9); // Convert back to nm
    float3 XYZ_G = WavelengthToXYZ(wavelengthsM.g * 1e9);
    float3 XYZ_B = WavelengthToXYZ(wavelengthsM.b * 1e9);
    
    // Sum the contributions
    float3 XYZ = AddOver0(XYZ_R, XYZ_G, XYZ_B);

    // Convert XYZ to linear RGB
    float3 linearRGB = XYZToLinearRGB(XYZ);

    // Clamp negative values
    linearRGB = max(linearRGB, EPSILON3);

    // Convert to sRGB
    float3 srgb = LinearRGBToSRGB(linearRGB);

    // Clamp to [0, 1]
    srgb = saturate(srgb);

    return srgb;
}
float3 WavelengthsToRGB4(float3 wavelengthsM)
{
    // Reference: http://www.noah.org/wiki/Wavelength_to_RGB_in_Phong
    float3 RGB = ZERO3;
    
    // Convert wavelength in meters to nanometers for the algorithm
    float3 lambda = mToNm(wavelengthsM);
    
    // Red channel
    RGB.r = (lambda.x >= 620.0 && lambda.x <= 750.0) ?
            moilerp(.9, 1.0, (lambda.x - 620.0) / (750.0 - 620.0)) :
            (lambda.x < 620.0 && lambda.x >= 595.0) ?
            (lambda.x - 595.0) / (620.0 - 595.0) :
            lambda.x > 750.0 ? 1 :
            moilerp(.1, 0.0, lambda.x / (595.0));
    
    // Green channel
    RGB.g = (lambda.y >= 495.0 && lambda.y <= 570.0) ?
            moilerp(.9, 1.0, (lambda.y - 495.0) / (570.0 - 495.0)) :
            (lambda.y < 495.0 && lambda.y >= 450.0) ?
            (lambda.y - 450.0) / (495.0 - 450.0) :
            lambda.y > 570.0 ? 1 :
            moilerp(.1, 0.0, lambda.y / (450.0));
    
    // Blue channel
    RGB.b = (lambda.z >= 380.0 && lambda.z <= 450.0) ?
            moilerp(.9, 1.0, (lambda.z - 380.0) / (450.0 - 380.0)) :
            (lambda.z < 450.0 && lambda.z >= 420.0) ?
            (lambda.z - 420.0) / (450.0 - 420.0) :
            lambda.z > 450.0 ? 1 :
            moilerp(.1, 0.0, lambda.z / 420.0);
    
    // Intensity correction (gamma correction)
    RGB = AdjustGamma(RGB, 2.2);
    
    return RGB;
}

float3 WavelengthToRGB(float wavelength)
{
    // Sum the XYZ contributions
    float3 XYZ = WavelengthToXYZ(wavelength);

    // Convert XYZ to linear RGB
    float3 linearRGB = XYZToLinearRGB(XYZ);

    // Clamp negative values to zero
    linearRGB = max(linearRGB, EPSILON);

    // Convert linear RGB to sRGB
    float3 srgb = LinearRGBToSRGB(linearRGB);

    // Clamp to [0, 1]
    srgb = saturate(srgb);

    return srgb;
}

float3 ComputeLightTravelTimeM(float3 distanceM, float speedOfLight = SPEED_OF_LIGHT)
{
    // Time = Distance / Speed of Light
    return distanceM / speedOfLight;
}

// Adjust the intensity of light based on travel time (simulating medium attenuation)
float3 AdjustIntensityByTravelTime(float3 intensity, float3 travelTimeS, float3 absorptionCoeffM, float speedOfLight = SPEED_OF_LIGHT)
{
    // Apply exponential attenuation: I = I0 * e^(-alpha * d)
    // Here, alpha is the absorption coefficient (1/m)
    float3 attenuation = exp(-absorptionCoeffM * speedOfLight * travelTimeS);
    return intensity * attenuation;
}



// Simulate light propagation considering the speed of light
float3 SimulateLightPropagation(float3 sourceColor, float distanceM, float3 intensity = ONE3, float absorptionCoeffM = 0.0, float speedOfLight = SPEED_OF_LIGHT)
{
    // Compute the travel time
    float3 travelTimeS = ComputeLightTravelTimeM(float3(distanceM, distanceM, distanceM), speedOfLight);
    
    // Adjust intensity based on travel time and absorption
    float3 adjustedIntensity = AdjustIntensityByTravelTime(intensity, travelTimeS, absorptionCoeffM, speedOfLight);
    
    // Apply adjusted intensity to the source color
    float3 adjustedColor = sourceColor * adjustedIntensity;
    
    return adjustedColor;
}

inline float3 SellmeierEquationNM(float3 wavelengthsNM, MaterialSellmeier material)
{
    wavelengthsNM = max(EPSILON3, wavelengthsNM);
    
    float3 lambdaSq = pow(max(wavelengthsNM, EPSILON3), 2.0);
    
    float3 nSquared = ONE3 +
                        (material.B1 * lambdaSq) / max(lambdaSq - material.C1, EPSILON3) +
                        (material.B2 * lambdaSq) / max(lambdaSq - material.C2, EPSILON3) +
                        (material.B3 * lambdaSq) / max(lambdaSq - material.C3, EPSILON3);
    return sqrt(nSquared);
}

// Sellmeier Equation for Dispersion
float3 SellmeierEquationM(float3 wavelengthsM, float3 B1, float3 B2, float3 B3, float3 C1, float3 C2, float3 C3)
{
    // Calculate lambda squared
    float3 lambdaSq = pow(max(wavelengthsM, EPSILON3), 2.0);

    // Prevent division by zero by adding a small epsilon where necessary
    float3 denominator1 = lambdaSq - C1 + EPSILON3;
    float3 denominator2 = lambdaSq - C2 + EPSILON3;
    float3 denominator3 = lambdaSq - C3 + EPSILON3;

    // Sellmeier equation: n^2 = 1 + (B1 * lambda^2) / (lambda^2 - C1) + ...
    float3 nSquared = ONE3 +
                      (B1 * lambdaSq) / max(denominator1, EPSILON3) +
                      (B2 * lambdaSq) / max(denominator2, EPSILON3) +
                      (B3 * lambdaSq) / max(denominator3, EPSILON3);

    // Return the refractive index
    return sqrt(nSquared);
}

// Helper to calculate the Euclidean distance light travels between two points
float CalculateLightDistance(float3 startPos, float3 endPos)
{
    return length(endPos - startPos);
}

// Helper to compute optical path length inside a medium based on refractive index and distance traveled
float3 CalculateOpticalPathLengthM(float distanceM, float3 refractiveIndex)
{
    return distanceM * refractiveIndex;
}

// Helper to calculate phase shift due to optical path difference
float3 CalculatePhaseShiftOpticalM(float3 opticalPathLengthM, float3 wavelengthsM)
{
    return (2.0 * PI * opticalPathLengthM) / max(wavelengthsM, EPSILON3);
}

// Helper to compute the angle of incidence given the surface normal and view direction
float CalculateIncidenceAngle(float3 normal, float3 viewDir)
{
    viewDir = safeNormalize(viewDir);
    normal = safeNormalize(normal);
    return acos(dot(normal, viewDir));
}

// Helper to apply Snell's Law and calculate the transmitted angle
float3 CalculateTransmittedAngle(float3 normal, float3 viewDir, float3 nIncident, float3 nTransmitted)
{
    float cosThetaI = dot(normal, viewDir);
    float sinThetaI = sqrt(1.0 - pow(max(cosThetaI, EPSILON), 2.0));
    return asin((nIncident / max(nTransmitted, EPSILON3)) * sinThetaI);
}

// Helper to calculate the intensity of light based on the inverse square law
float CalculateLightIntensity(float initialIntensity, float distance)
{
    return initialIntensity / max(distance * distance, EPSILON);
}

// Helper to compute the attenuation of light as it travels through a medium
float CalculateLightAttenuation(float distance, float attenuationCoefficient)
{
    return exp(-attenuationCoefficient * distance);
}

// Helper to compute the absorption of light based on medium properties and thickness
float3 CalculateLightAbsorption(float thickness, float3 absorptionCoefficient)
{
    return exp(-absorptionCoefficient * thickness);
}


// Snell + TIR + Doppler + polarization + coherence + usage — fixed and consistent

// Snell’s law: per-channel transmitted cos(theta_t), no asin, no scalar/vector confusion
float3 CalculateCosThetaT(float3 normal, float3 viewDir, float3 nIncident, float3 nTransmitted)
{
    float NdotV = max(dot(safeNormalize(normal), safeNormalize(viewDir)), EPSILON);
    float3 cosThetaI = float3(NdotV, NdotV, NdotV);

    float3 sinThetaI2 = 1.0 - cosThetaI * cosThetaI;
    float3 sinThetaT2 = (nIncident / max(nTransmitted, EPSILON3)) * sqrt(max(sinThetaI2, EPSILON3));

    // clamp to [0,1] to avoid NaNs
    sinThetaT2 = saturate(sinThetaT2);
    float3 cosThetaT = sqrt(max(1.0 - sinThetaT2 * sinThetaT2, EPSILON3));

    return cosThetaT;
}


bool IsTotalInternalReflection(float3 nIncident, float3 nTransmitted, float3 cosThetaI)
{
    float3 sinThetaI2 = 1.0 - cosThetaI * cosThetaI;
    float3 sinThetaT2 = (nIncident / max(nTransmitted, EPSILON3)) * sqrt(max(sinThetaI2, EPSILON3));
    // TIR if any channel exceeds 1
    float3 exceed = step(1.0, sinThetaT2);
    return (exceed.x > 0.0) || (exceed.y > 0.0) || (exceed.z > 0.0);
}


float3 CalculateDopplerShift(float3 sourceVelocity, float3 observerVelocity, float3 wavelengthM, float3 propagationDir)
{
    float3 relativeVelocity = observerVelocity - sourceVelocity;
    float vRadial = dot(relativeVelocity, safeNormalize(propagationDir));
    // non-relativistic approximation
    return wavelengthM * (1.0 + vRadial);
}

// Polarization: keep as-is, just ensure radians and [0,1] inputs
float3 CalculatePolarizationEffect(float polarizationAngle, float3 R12, float3 R23)
{
    return 1.0 + cos(2.0 * polarizationAngle) * (clamp(R12,0,1) - clamp(R23,0,1));
}

// Coherence: units-consistent, per-channel
float3 CalculateCoherenceFactor(float3 opticalPathLengthM, float3 coherenceLengthM)
{
    float3 L  = max(opticalPathLengthM, EPSILON3);
    float3 Lc = max(coherenceLengthM, EPSILON3);
    float3 ratio2 = (L * L) / (Lc * Lc);
    return exp(-ratio2);
}
// ============================================================
// PHASE SHIFT FROM OPTICAL PATH DIFFERENCE
// ============================================================
// deltaM       : optical path length in meters (per channel)
// wavelengthsM : wavelength in meters (per channel)
// returns      : phase in radians (per channel)
//
// φ = (2π / λ) * ΔL
// ============================================================
float3 CalculatePhaseShiftOptical(float3 opticalPathLengthM, float3 wavelengthsM)
{
    float3 L  = max(opticalPathLengthM, EPSILON3);   // meters
    float3 lambdaM  = max(wavelengthsM,      EPSILON3);    // meters

    float3 phaseRadians  = (2.0 * PI)* L / lambdaM+time;                     // wave number

    return phaseRadians;
}


// Helper to calculate the total interference color, including all light properties and effects
float3 CalculateInterferenceColor(float2 uv,float thicknessM,
    float3 normalTS,
    float3 viewPos,
    float3 lightPos,
    float3 viewDirTS,
    float3 wavelengthsM,
    float3 nIncident,
    float3 nFilm,
    float3 initialIntensity,
    float attenuationCoefficient,
    float3 coherenceLengthM,
    float polarizationAngle
)
{
    // safeNormalize vectors
    normalTS = safeNormalize(normalTS);
    viewDirTS = safeNormalize(viewDirTS);
    
    // Calculate light distance and attenuation
    float lightDistance = CalculateLightDistance(viewPos, lightPos);
    float lightAttenuation = CalculateLightAttenuation(lightDistance, attenuationCoefficient);
    




// Usage in your interference block — cleaned up

// cos(theta_i) per channel
float NdotV = max(dot(normalTS, viewDirTS), EPSILON);
float3 cosThetaI = float3(NdotV, NdotV,NdotV);

// transmitted cos(theta_t)
float3 cosThetaT = normalize(CalculateCosThetaT(normalTS, viewDirTS, nIncident, nFilm));

// TIR check
if (IsTotalInternalReflection(nIncident, nFilm, cosThetaI))
{
    return float3(1,0,0) + ZERO3;
}

// optical path (meters)
float3 deltaM = CalculateOpticalPathLengthM(f1*(depthRaw(depthMap,uv))+thicknessM, nFilm);

// phase (radians), wavelengthsM in meters
float3 phase = (CalculatePhaseShiftOptical(deltaM, wavelengthsM));

// Fresnel reflectances (assume a consistent Fresnel function)
float3 R12 = CalculateFresnelReflectance(cosThetaI, nIncident, nFilm);
float3 R23 = CalculateFresnelReflectance(cosThetaT, nFilm, nIncident);

// coherence + polarization
float3 coherenceFactor    = CalculateCoherenceFactor(deltaM, coherenceLengthM);
float3 polarizationEffect = CalculatePolarizationEffect(polarizationAngle, R12, R23);

// final reflectance with interference
float3 reflectance =
    (R12 + R23 + 2.0 * sqrt(R12 * R23) * cos(phase+time)) *
    coherenceFactor *
    polarizationEffect*f2 * (lightAttenuation)*(1.0-initialIntensity);



    return reflectance;
}


float4 Fresnel4(float4 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float fresnelReflectance, float3 refractiveIndices = float3(1.5, 1.5, 1.5), float dispersionCoefficient = 0.005)
{
    // safeNormalize vectors
    float3 N = safeNormalize(normal);
    float3 V = safeNormalize(viewDir);

    float NdotV = max(dot(N, V), EPSILON);
    float3 cosThetaI = float3(NdotV, NdotV, NdotV);
    
    
    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    
    // Refractive indices for the material (example values)
    float3 A = refractiveIndices; // Base refractive index
    float B = dispersionCoefficient; // Dispersion coefficient

    float3 sum = ZERO3;

    // Calculate refractive indices for each wavelength
    float3 n1 = float3(1.0, 1.0, 1.0);
    float3 n2 = RefractiveIndexMM(mToMm(wavelengthsM), A, B);

    float3 cosThetaT;
    // Fresnel reflectance for this wavelength
    float3 R = CalculateFresnelReflectance(n1, n2, cosThetaI, cosThetaT);

    // Thin-film interference
    float3 interference = ThinFilmInterference(wavelengthsM, filmThicknessM, clamp(n2, 1.0, 2.0), clamp(cosThetaT, EPSILON3, OneMinusEPSILON3));

    // Adjust reflectance with interference
    float3 reflectance = clamp(R, EPSILON3, OneMinusEPSILON3) + clamp(interference, EPSILON3, OneMinusEPSILON3) * fresnelPower;

    reflectance = fresnelReflectance + reflectance * (1.0 - fresnelReflectance);
        
    // Clamp reflectance between 0 and 1
    reflectance = clamp(reflectance, EPSILON3, OneMinusEPSILON3);

    // Apply base color and accumulate
    sum = reflectance * baseColor.rgb;
   
    return float4(sum, 1);
}

float3 Fresnel3(float3 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance, float3 baseRefractiveIndices = float3(1.5, 1.5, 1.5), float dispersionCoefficient = 0.005)
{
    // safeNormalize vectors
    float3 N = safeNormalize(normal);
    float3 V = safeNormalize(viewDir);

    // Cosine of the angle of incidence
    float3 cosThetaI = ONE3 * max(dot(N, V), EPSILON);

    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    
    // Refractive indices for the material (example values)
    
    float B = dispersionCoefficient; // Dispersion coefficient

    float3 sum = ZERO3;

    float3 A = baseRefractiveIndices; // Base refractive index
    // Calculate refractive indices for each wavelength
    float3 n1 = float3(1.25, 1.25, 1.25);
    float3 n2 = RefractiveIndexMM(mToMm(wavelengthsM), A, B);

    float3 cosThetaT;
    // Fresnel reflectance for this wavelength
    float3 R = CalculateFresnelReflectance(n1, n2, cosThetaI, cosThetaT);

    // Thin-film interference
    float3 interference = ThinFilmInterference(wavelengthsM, filmThicknessM, n2, cosThetaT);

    // Adjust reflectance with interference
    float3 reflectance = R + interference * fresnelPower;

    reflectance = fresnelReflectance + reflectance * (1.0 - fresnelReflectance);
        
    // Clamp reflectance between 0 and 1
    reflectance = clamp(reflectance, EPSILON3, OneMinusEPSILON3);

    // Apply base color and accumulate
    sum = reflectance * (baseColor);
    
    return sum;
}


// High-order helper to calculate the diffraction angle based on grating equation
float CalculateDiffractionAngle(float wavelength, float incidentAngle, float gratingSpacing, int diffractionOrder)
{
    return asin(diffractionOrder * wavelength / max(gratingSpacing, EPSILON) + sin(incidentAngle));
}


// Helper to calculate grating efficiency for a given wavelength and angle of diffraction
float CalculateGratingEfficiency(float wavelength, float incidentAngle, float diffractionAngle, float grooveDepth, float refractiveIndex)
{
    // Estimate efficiency based on grating depth and refractive index (simplified model)
    float blazeAngle = atan(grooveDepth / max(refractiveIndex, EPSILON));
    float efficiency = pow(cos(blazeAngle - diffractionAngle), 2.0) * exp(-wavelength * abs(blazeAngle - diffractionAngle));
    return max(efficiency, EPSILON);
}
// Helper to calculate diffraction grating phase shift for interference effects
float3 CalculateDiffractionGratingPhaseShift(float3 wavelengths, float incidentAngle, float3 diffractionAngles, float gratingSpacing)
{
    float3 opticalPathDiff = gratingSpacing * (sin(incidentAngle) - sin(diffractionAngles));
    return (2.0 * PI * opticalPathDiff) / max(wavelengths, EPSILON3);
}

// Fresnel and Thin-Film Interference Combined
float4 FresnelThinFilmInterference(float4 baseColor,
    float3 viewDirM,
    float3 normalM,
    float filmThicknessM,
    float fresnelPower,
    float fresnelReflectance,
    float3 refractiveIndices = float3(1.5, 1.35, 1.75),
    float dispersionCoefficient = 0.005
)
{
    // safeNormalize vectors
    float3 N = safeNormalize(normalM);
    float3 V = safeNormalize(viewDirM);
    
    // Cosine of the angle of incidence
    float NdotV = max(dot(N, V), 0.0);
    float3 cosThetaI = float3(NdotV, NdotV, NdotV);
    
    // Convert baseColor from sRGB to linear RGB
    float3 linearRGB = SRGBToLinear(baseColor.rgb);
    
    // Convert linear RGB to dominant wavelengths in meters
    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    MaterialSellmeier material = CreateMaterial(MaterialIndex);
    // Calculate refractive indices using the Sellmeier equation
    float3 n2 = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 n1 = float3(1.0, 1.0, 1.0); // Refractive index of air
    
    // Calculate Fresnel reflectance
    float3 cosThetaT;
    float3 R = CalculateFresnelReflectance2(n1, n2, cosThetaI, cosThetaT);
    
    // Calculate thin-film interference
    float3 interference = ThinFilmInterference(wavelengthsM, filmThicknessM, n2, cosThetaT);
    
    // Adjust reflectance with interference and Fresnel power
    float3 reflectance = R + interference * Fresnel3(baseColor.rgb, viewDirM, normalM, filmThicknessM, fresnelPower, fresnelReflectance, refractiveIndices, dispersionCoefficient);
    
    // Blend with base reflectance
    reflectance = fresnelReflectance + reflectance * (1.0 - fresnelReflectance);
    
    // Clamp reflectance to [0, 1]
    reflectance = clamp(reflectance, 0.0, 1.0);
    
    // Apply the reflectance to the base color channel
    float3 finalColor = reflectance * linearRGB;
    
    // Convert back to sRGB
    float3 finalColorSRGB = LinearRGBToSRGB(finalColor);
    
    return float4(saturate(finalColorSRGB), baseColor.a);
}

float2 RotateUV(float2 uv, float angleRadians)
{
    float cosAngle = cos(angleRadians);
    float sinAngle = sin(angleRadians);
    float2 center = float2(0.5, 0.5);
    float2 translatedUV = uv - center;
    float2 rotatedUV;
    rotatedUV.x = translatedUV.x * cosAngle - translatedUV.y * sinAngle;
    rotatedUV.y = translatedUV.x * sinAngle + translatedUV.y * cosAngle;
    return rotatedUV + center;
}

// Rotates UV coordinates with depth-based influence
float2 RotateUVWithDepth(float2 uv, float depth, float angleRadians)
{
    // Rotation matrix components
    float cosAngle = cos(angleRadians);
    float sinAngle = sin(angleRadians);

    // Translate UV to center (0.5, 0.5) before rotation
    float2 centeredUV = uv - 0.5;

    // Apply the rotation with depth influence
    float depthInfluence = saturate(1.0 - depth); // Clamp between 0 and 1
    float2 rotatedUV = float2(centeredUV.x * cosAngle - centeredUV.y * sinAngle,
        centeredUV.x * sinAngle + centeredUV.y * cosAngle
    );

    // Blend between rotated and original based on depth
    return moilerp(float3(centeredUV, depth), float3(rotatedUV, depth), depthInfluence).xy + 0.5;
}

// Rotates UV coordinates with depth-based influence
float2 RotateUVWithDepth(float2 uv, float3 depth, float angleRadians)
{
    // Rotation matrix components
    float cosAngle = cos(angleRadians);
    float sinAngle = sin(angleRadians);

    // Translate UV to center (0.5, 0.5) before rotation
    float2 centeredUV = uv - 0.5;

    // Apply the rotation with depth influence
    float3 depthInfluence = saturate(1.0 - depth); // Clamp between 0 and 1
    float2 rotatedUV =
        float2(centeredUV.x * cosAngle - centeredUV.y * sinAngle,
               centeredUV.x * sinAngle + centeredUV.y * cosAngle
    );

    // Blend between rotated and original based on depth
    return
        moilerp(float3(centeredUV, depthRaw(depthMap, centeredUV)), float3(rotatedUV, depthRaw(depthMap, rotatedUV)), depthInfluence).xy;
}


float ComputeFresnelPhase(float3 sourcePosM, float3 observationPosM, float wavelengthM)
{
    float distanceM = length(observationPosM - sourcePosM);
    float phase = (2.0 * PI * distanceM) / max(wavelengthM, EPSILON);
    return phase;
}


// Function to compute path difference in meters
float ComputePathDifferenceM(float3 pixel)
{
    // Center the UV coordinates around (0, 0)
    float2 sz = GetSz1(depthMap);

    float3 centeredUV = pixel - float3(.5, .5, .5);
    
    return length(centeredUV) * HOLOGRAM_SIZE_M;
}

float ComputePathDifferenceM(float3 pixel, float3 pixel2)
{
    return ComputePathDifferenceM(pixel) + ComputePathDifferenceM(pixel2);
}


float3 FresnelDiffraction(Texture2D<float4> sourceMap, float2 uv, float3 observationPos, float wavelength, float aperture)
{
    // Sample source intensity and position
    float4 sourceSample = sourceMap.SampleLevel(sampleTypeMirror, uv, 0);
    float3 sourcePos = float3(uv, depthRaw(depthMap, uv));

    // Calculate phase difference
    float phase = ComputeFresnelPhase(sourcePos, observationPos, wavelength);

    // Aperture function (e.g., circular aperture)
    float2 delta = uv - float2(0.5, 0.5);
    float apertureFunc = float(step(length(delta), float(aperture)));

    // Complex amplitude (using Euler's formula)
    float amplitude = sourceSample.r * apertureFunc;
    float real = amplitude * cos(phase);
    float imag = amplitude * sin(phase);

    return float3(real, imag, 0.0);
}


float2 ParallaxMapping(float2 uv, float3 viewDir)
{
    const int numLayers = 30;
    float layerDepth = 1.0 / numLayers;
    float2 P = viewDir.xy * DepthScale;
    float2 deltaTexCoord = P / numLayers;
    float2 currentTexCoord = uv;
    float currentLayerDepth = 0.0;
    float heightFromTexture = depthRaw(depthMap, currentTexCoord);

    [loop]
    for (int i = 0; i < numLayers; ++i)
    {
        currentLayerDepth += layerDepth;
        currentTexCoord -= deltaTexCoord;
        heightFromTexture = depthRaw(depthMap, currentTexCoord);
        if (heightFromTexture < currentLayerDepth)
        {
            break;
        }
    }
    return currentTexCoord;
}

// Parallax Occlusion Mapping for Enhanced Depth Effects
float2 ParallaxOcclusion(Texture2D<float> depthMap, float2 uv, float3 viewDir, int numLayers, float parallaxScale)
{
    float depth = depthRaw(depthMap, uv);
    float2 deltaUV = viewDir.xy / viewDir.z * parallaxScale;
    float2 currentUV = uv;
    float2 oosz = GetOosz(depthMap);
    
    for (int i = 0; i < numLayers; i++)
    {
        float currentDepth = moilerp(depth, depth - (float(i) / float(numLayers)), 0.75);
        if (currentDepth < 0.0)
            break;
        
        currentUV = moilerp(currentUV, currentUV + deltaUV * depth * parallaxScale * oosz, float2(.75, .75));
        depth = depthRaw(depthMap, currentUV);
    }
    return currentUV;
}

// Function to Perform Parallax Mapping
float2 ParallaxMapping(Texture2D<float> heightMap, float2 uv, float3 viewDir, float parallaxScale, float steps)
{
    float2 deltaTexCoords = viewDir.xy / max(viewDir.z, EPSILON) * max(parallaxScale, EPSILON);
    float2 currentTexCoords = uv;
    float currentDepth = 1.0f;
    float height = 1.0f;
    
    [unroll]
    for (int i = 0; i < 4; i++)
    {
        currentTexCoords -= deltaTexCoords / 4.0 * (1 - currentDepth);
        height = 1 - clamp(heightMap.SampleLevel(sampleTypeMirror, currentTexCoords, 0), EPSILON, 1.0- EPSILON);
        currentDepth -= 1.0f / 4.0;

        if (currentDepth <= height)
            break;
    }

    return currentTexCoords;
}
float2 ParallaxOcclusionMapping(Texture2D<float> depthMap, Texture2D<float4> diffuseMap, Texture2D<float3> normalMap, float2 uv, float3 viewDir, int numLayers, float parallaxStrength)
{
  // Calculate the parallax occlusion mapping (POM)
    float2 pom = uv;
    for (int i = 0; i < numLayers; i++)
    {
        float2 offset = parallaxStrength * viewDir.xy * (float(i) / max(float(numLayers), EPSILON));
        pom += offset;
        float depth = depthRaw(depthMap, pom);
        if (depth > 0.0)
            break;
    }
    return pom;
}

// Calculates the Henyey-Greenstein phase function for scattering.
inline float HenyeyGreensteinPhaseFunction(float g, float cosTheta)
{
    float denom = 1.0 + g * g - 2.0 * g * cosTheta;
    return (1.0 / (4.0 * PI)) * ((1.0 - g * g) / max((denom * sqrt(denom)), EPSILON));
}

/**
 * Parallax occlusion function using advanced mathematical concepts.
 *
 * @param oosz          Out-of-screen zoom factor
 * @param depthMap      Depth map texture
 * @param diffuseMap    Diffuse map texture
 * @param normalMap     Normal map texture
 * @param uv            UV coordinates
 * @param viewDir       View direction
 * @param numLayers     Number of parallax layers
 * @param parallaxStrength  Parallax strength factor
 * @param parallaxStrengthOMD  Parallax strength factor for out-of-screen zoom
 * @return              Parallax occlusion result structure
 */
float2 ParallaxOcclusion(float2 oosz,
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    Texture2D<float3> normalMap,
    float2 uv,
    float3 viewDir,
    int numLayers,
    float parallaxStrength,
    float parallaxStrengthOMD
)
{
    
    // **Non-Euclidean Space Mapping**
    // ==============================
    float odep = depthRaw(depthMap, uv);
    
    float2 curUV = uv;
    float2 offsetOMD = odep * viewDir.xy / viewDir.z * DepthScale*parallaxStrengthOMD * float2(cosTime11(AnimateSpeed), -.1);
    float2 offset = odep * viewDir.xy / viewDir.z * DepthScale*parallaxStrength * float2(cosTime11(AnimateSpeed), .1);
    
    // Precompute to save operations inside loop
    float2 deltaUV = oosz * moilerp(float3(offset, odep), float3(offsetOMD, 1 - odep), odep).xy;
    
    float layerDepth = 1.0 - 1.0 / max(numLayers, EPSILON);
    float currentLayerDepth = 1.0;
    
    // Loop unrolled for performance
    [unroll(20)]
    for (int i = 0; i < numLayers; ++i)
    {
        float depthFromMap = depthRaw(depthMap, curUV);
        
        float2 prevUV = curUV;
        currentLayerDepth -= layerDepth;
        
        // Calculate the next UV based on view direction and depth
       
        float2 nextUV = ((curUV - .5) + ((deltaUV) * parallaxStrength * depthFromMap * currentLayerDepth)) + .5;
        
        curUV = nextUV;

    }
    
    return curUV;
}

// 1. Lens Distortion
inline float2 ppLensDistort(float2 uv, float strength, float radius)
{
    float2 offset = (.25 + uv - 0.5);
    float r = length(offset);
    float pd = projectedDepth(depthMap, uv);
    float n1 = noise3(noiseMap1, float3(uv, pd)).x;
    float distortion = 1.0 + (strength * r * r) / max((1.0 + radius * r * r), EPSILON) * pd * n1;
    return 0.5 + offset * distortion - .25;
}


// 3. Vignette (Darkened Edges)
inline float ppVignette(float2 uv, float amount, float softness)
{
    float dist = distance(uv, float2(0.5, 0.5));
    return smoothstep(amount, amount - softness, dist);
}

// 4. Scanlines (Horizontal Lines)
inline float ppScanlines(float2 uv, float density, float thickness)
{
    float intensity = 1.0 - sin(uv.y * density * TotalTime * AnimateSpeed * 2.0 * 3.14159) * thickness;
    return intensity;
}

// 5. Film Grain (Noisy Texture)
inline float ppFilmGrain(float2 uv, float strength)
{
    return frac(sin(TotalTime * AnimateSpeed + uv.x * 100.0 + uv.y * 1000.0) * 43758.5453) * strength;
}

// 6. Pixelation (Blocky Effect)
inline float2 ppPixelate(float2 uv, float pixelSize)
{
    return floor(uv * pixelSize) / max(pixelSize, EPSILON);
}

// 7. Posterization (Limited Colors)
inline float3 ppPosterize(float3 color, float levels)
{
    return floor(color * levels) / max(levels, EPSILON);
}

// 8. Swirl (Twisting Distortion)
inline float2 ppSwirl(float2 uv, float angle)
{
    float2 offset = uv - 0.5;
    float radius = length(offset);
    float theta = atan2(offset.y, offset.x);
    theta += angle * radius;
    return 0.5 + radius * float2(cos(theta), sin(theta));
}

// 9. Color Tint (Shift Hues)
inline float3 ppColorTint(float3 color, float3 tint)
{
    return color * tint; // Simple multiplication
}

// 10. Bloom (Glowing Highlights)
inline float ppBloom(float value, float threshold, float intensity)
{
    return max(EPSILON, (value - threshold) * intensity);
}

inline float2 ppZoom2D(float2 uv, float2 zoom)
{
    return (uv - .5) * zoom + .5;
}
inline float2 ppZoomUV(float2 uv, float2 scale)
{
    float a = cosTime01(AnimateSpeed);
    float depth = 1.0 - projectedDepth(depthMap, uv);
    return ppZoom2D(uv,
        float2(1.0 - scale.x * depth * a,
               1.0 - scale.y * depth * a));
}
// Post-Processing Effect Helpers (with time-varying animation)

// 1. Lens Distortion Helper
inline float2 ppLensDistortUV(float2 uv, float strength, float radius, float speed = 1.0)
{
    float v = time * speed; // Time-based animation (adjust speed)
    float animatedStrength = strength * (1.0 + sin(v) * 0.2); // Oscillating strength
    return ppLensDistort(uv, animatedStrength, radius);
}


// 3. Vignette Helper
inline float ppVignetteUV(float2 uv, float amount, float softness, float speed = 0.5)
{
    float v = time * speed;
    float animatedAmount = amount * (1.0 + sin(v) * 0.1);
    return ppVignette(uv, animatedAmount, softness);
}

// 4. Scanlines Helper
inline float ppScanlinesUV(float2 uv, float density, float thickness, float speed = 2.0)
{
    return ppScanlines(uv, density, thickness * (1.0 + sin(TotalTime * AnimateSpeed * speed) * 0.2));
}

// 5. Film Grain Helper
inline float ppFilmGrainUV(float2 uv, float strength, float speed = 0.8)
{
    return ppFilmGrain(uv, strength * (1.0 + cos(TotalTime * AnimateSpeed * speed) * 0.1));
}

// 6. Pixelation Helper
inline float2 ppPixelateUV(float2 uv, float pixelSize)
{
    // Pixel size typically doesn't need animation, but you could add it if desired
    return ppPixelate(uv, pixelSize);
}

// 7. Posterization Helper
inline float3 ppPosterizeUV(float3 color, float levels, float speed = 0.3)
{
    float animatedLevels = levels * (1.0 + sin(TotalTime * AnimateSpeed * speed) * 0.1);
    return ppPosterize(color, animatedLevels);
}

// 8. Swirl Helper
inline float2 ppSwirlUV(float2 uv, float angle, float speed = 1.0)
{
    float v = time * speed;
    float animatedAngle = angle * (1.0 + sin(v) * 0.3); // More pronounced swirl animation
    return ppSwirl(uv, animatedAngle);
}

// 9. Color Tint Helper
inline float3 ppColorTintUV(float3 color, float3 tint, float speed = 0.2)
{
    float3 animatedTint = tint * (1.0 + sin(TotalTime * AnimateSpeed * speed) * 0.1);
    return ppColorTint(color, animatedTint);
}

// 10. Bloom Helper
inline float ppBloomUV(float value, float threshold, float intensity, float speed = 0.5)
{
    float animatedIntensity = intensity * (1.0 + cos(TotalTime * AnimateSpeed * speed) * 0.2);
    return ppBloom(value, threshold, animatedIntensity);
}



inline float3 GaussianBloom(Texture2D<float4> tex, float2 uv, float dist, float threshold, float3 minColor, float3 power, float sigma)
{
    float2 oosz = GetOosz(tex);
    float3 color = tex.SampleLevel(sampleTypeMirror, uv, 0).xyz; // Use a sampler for better quality
    float luminance = ColorLuminance(color);

    if (luminance >= threshold)
    {
        float3 blurColor = 0.0;
        float totalWeight = 0.0;

        // Dynamic radius based on sigma
        int radius = int(ceil(3.0 * sigma));

        // Precalculate some values to avoid redundant calculations in the loop
        float sigmaSq2 = 2.0 * sigma * sigma;
        float2 ooszDist = oosz * dist;

        for (int y = -radius; y <= radius; y++)
        {
            for (int x = -radius; x <= radius; x++)
            {
                float2 offset = float2(x, y) * ooszDist; // Use precalculated value
                float weight = gaussian(length(offset), sigma);
                blurColor += tex.SampleLevel(sampleTypeMirror, uv + offset, 0).xyz * weight;
                totalWeight += weight;
            }
        }

        blurColor /= totalWeight;
        color = moilerp(color, max(minColor, blurColor), luminance * power);
    }

    return color;
}

inline float3 HolographicBloom(Texture2D<float4> diffuseMap, float2 uv, float3 color, float depth, float threshold, float3 minColor, float3 power, float sigma, float dist)
{
    // Calculate bloom intensity based on depth
    float depthFactor = 1.0 / max(depth + 1.0, EPSILON); // Adjust the function as needed
    float bloomIntensity = saturate((depthFactor - threshold) / max(1.0 - threshold, EPSILON));

    // Apply Gaussian blur in 3D space (simplified)
    float3 blurColor = 0.0;
    float totalWeight = 0.0;
    int radius = int(ceil(3.0 * sigma));

    for (int y = -radius; y <= radius; y++)
    {
        for (int x = -radius; x <= radius; x++)
        {
            float2 offset = float2(x, y) * bloomIntensity * dist;
            float weight = gaussian(length(offset), sigma);
                // Sample color at the offset position (implementation depends on your holographic rendering technique)
            float3 sampleColor = diffuseMap.SampleLevel(sampleTypeMirror, uv + offset, 0).xyz;
            blurColor += sampleColor * weight;
            totalWeight += weight;
        }
    }
   
    blurColor /= totalWeight;
    return moilerp(color, max(minColor, blurColor), bloomIntensity * power);
}



float3 HueToRGB(float hue)
{
    float r = abs(hue * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(hue * 6.0 - 2.0);
    float b = 2.0 - abs(hue * 6.0 - 4.0);
    return saturate(float3(r, g, b));
}
float RGBtoHue(float3 rgb)
{
    float M = max(max(rgb.r, rgb.g), rgb.b);
    float m = min(min(rgb.r, rgb.g), rgb.b);
    float C = M - m; // Chroma

    float hue = 0.0; // Initialize hue

    if (C != 0)
    {
        if (M == rgb.r)
        {
            hue = fmod(((rgb.g - rgb.b) / max(C, EPSILON)), 6.0);
        }
        else if (M == rgb.g)
        {
            hue = ((rgb.b - rgb.r) / max(C, EPSILON)) + 2.0;
        }
        else
        {
            hue = ((rgb.r - rgb.g) / max(C, EPSILON)) + 4.0;
        }
        hue *= 60.0;
        if (hue < 0.0)
            hue += 360.0;
    }

    return fmod(hue, 360.0); // safeNormalize to [0, 1]
}






// Define the GGX distribution function
float GGX(float3 microfacetNormal, float roughness)
{
    // Calculate the GGX distribution
    float ggxDistribution = (roughness * roughness) / max((3.14159 * (microfacetNormal.z * microfacetNormal.z * (roughness * roughness - 1.0) + 1.0)), EPSILON);

    return ggxDistribution;
}

// Define the Fresnel function
float Fresnel(float3 viewDirection, float3 microfacetNormal, float refractiveIndex)
{
    // Calculate the Fresnel term
    float fresnelTerm = (refractiveIndex - 1.0) * (refractiveIndex - 1.0) / max(((refractiveIndex + 1.0) * (refractiveIndex + 1.0)), EPSILON);

    return fresnelTerm;
}


// Define the microfacet-based BRDF function
float3 MicrofacetBRDF(float3 materialSpecularColor, float3 normal, float3 viewDirection, float3 lightDirection, float roughness, float materialRefractiveIndex = 1.3, float thickness = 20.0, float dispersionCoefficient = 0.005)
{
    // Calculate the microfacet normal
    float3 microfacetNormal = safeNormalize(normal + roughness * (viewDirection + lightDirection));

    // Calculate the GGX distribution
    float ggxDistribution = GGX(microfacetNormal, roughness);

    // Calculate the Fresnel term
    float3 fresnelTerm = saturate(Fresnel3(materialSpecularColor, viewDirection, normal, thickness, FresnelPower, FresnelReflectance, materialRefractiveIndex, dispersionCoefficient));

    // Calculate the BRDF
    float3 brdf = materialSpecularColor.rgb * ggxDistribution * fresnelTerm;

    return brdf;
}



float4 LightPixel(float2 texCoord, float3 normal, float3 viewPos, float3 viewDir, float pixelScaled, float3 pixelToSunDir, float sunIntensity, float ambient)
{
    // Sample the diffuse color
    float4 color = mir2D(rtMap1, texCoord);
    
    // Sample depth
    float depth = projectedDepth(depthMap, texCoord);
    
    // Simplified world position reconstruction
    float3 worldPos = viewPos + viewDir * depth * pixelScaled;

    // Lighting calculations
    float3 safeNormalizeNormal = safeNormalize(normal);
    
    // Diffuse lighting
    float nDotL = max(dot(safeNormalizeNormal, safeNormalize(pixelToSunDir)), EPSILON);
    float3 diffuse = color.rgb * nDotL * sunIntensity;
    
    // Ambient light
    float3 ambientLight = color.rgb * ambient;
    
    // Combine lighting
    float3 finalColor = diffuse + ambientLight;

    return float4(finalColor, color.a);
}

// Geometry function using Schlick-GGX
float GeometrySchlickGGX(float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r * r) / 8.0;
    float denom = NdotV * (1.0 - k) + k;
    return NdotV / max(denom, EPSILON);
}



float3 FresnelSchlick(float3 F0, float VdotH, float power)
{
    return F0 + (ONE3 - F0) * pow(max(VdotH, EPSILON), power);
}

float3 MicrofacetBRDF(float3 albedo, float metallic, float3 normal, float3 viewDir, float3 lightDir, float roughness, float ao = 1.0)
{
    // Ensure vectors are safeNormalize
    viewDir = safeNormalize(viewDir);
    lightDir = safeNormalize(lightDir);
    normal = safeNormalize(normal);
    float3 halfDir = safeNormalize(viewDir + lightDir);
    
    float NdotH = max(EPSILON, dot(normal, halfDir));
    float NdotL = max(EPSILON, dot(normal, lightDir));
    float VdotH = max(EPSILON, dot(viewDir, halfDir));
    float NdotV = max(EPSILON, dot(normal, viewDir));
    
    // Cook-Torrance BRDF
    float D = DistributionGGX(NdotH, roughness);
    float G = GeometrySmith(NdotL, NdotV, roughness);
    float3 F = FresnelSchlick(albedo, VdotH, FresnelPower);

    // Specular BRDF
    float3 numerator = D * G * F;
    float denominator = 4.0 * NdotV * NdotL; // Add small constant to avoid div by zero
    float3 specular = numerator / max(denominator, EPSILON);

    // kS is equal to Fresnel
    float3 kS = F;
    // for energy conservation, the diffuse and specular light can't
    // be above 1.0 (unless the surface emits light); to preserve this relationship
    // the diffuse component (kD) should equal 1.0 - kS.
    float3 kD = float3(1.0, 1.0, 1.0) - kS;
    // multiply kD by the inverse metalness such that only non-metals 
    // have diffuse lighting, or a linear blend if partly metal (pure metals have no diffuse light).
    kD *= 1.0 - metallic;

    // Scale light by NdotL
    float3 diffuse = kD * albedo / PI;

    // Combine with ambient occlusion for final output
    return (diffuse + specular) * NdotL;
}


float3 colorMap(float v)
{
    return float3(smoothstep(0.0, 0.3, v) - smoothstep(0.7, 1.0, v),
            smoothstep(0.2, 0.5, v) - smoothstep(0.5, 0.8, v),
            smoothstep(0.4, 0.7, v)
        );
}
float GaussianWeight(float distance, float sigma)
{
    return exp(-(distance * distance) / max(2.0 * sigma * sigma, EPSILON));
}


// Structure to represent a single Gaussian point source with orientation
struct GaussianPointSource
{
    float3 position; // Position of the point source in world space
    float3 direction; // Orientation direction of the Gaussian beam
    float amplitude; // Intensity of the point source
    float3 color; // Color contribution of the point source (RGB)
    float2 beamWidth; // Beam waist (radius at which the field amplitude drops to 1/e)
};
struct GaussianBeam
{
    float3 position; // Beam origin in world space
    float3 direction; // Beam direction vector
    float beamWaist; // Beam waist (radius at 1/e^2 intensity)
    float divergence; // Beam divergence angle in radians
    float peakIntensity; // Peak intensity (I0)
};


// Structures
struct LightSource
{
    int LightSourceType;
    
    float3 position; // Position in 3D space (likely safeNormalized or in a shader-specific space)
    float3 color; // RGB color of the light
    float3 wavelengthNM; // Wavelength in nanometers for RGB components
    float intensity; // Light intensity
    float coherenceLength; // Coherence length in meters or safeNormalized units
    float phaseOffset; // Initial phase offset
    float3 direction; // Directionality for non-point light sources
    
    // For Gaussian or other beam profiles, consider using additional parameters if needed
    float beamWidth; // Width of the beam at its waist
    float divergenceAngle; // Angle of beam divergence
    
    GaussianBeam beamProperties;
};


static const int LIGHT_TYPE_POINT = 0;
static const int LIGHT_TYPE_DIRECTIONAL = 1;
static const int LIGHT_TYPE_SPOT = 2;
static const int LIGHT_TYPE_BEAM = 3;
static const int LIGHT_TYPE_AREA = 4;

static const int NUM_LIGHT_TYPES = 5;



struct HolographicLight
{
    float3 position; // Position in 3D space
    float3 direction; // Main direction of propagation
    float3 color; // RGB color of the light
    float3 wavelengthNM; // Wavelength in nanometers for each color channel
    float intensity; // Light intensity
    float coherenceLength; // Coherence length in meters or safeNormalized units
    float phaseOffset; // Initial phase offset for interference effects
    float4x4 lightSpaceMatrix; // Transformation matrix to light's local space, could be used for complex patterns or 3D encoding
    float2 textureUVScale; // Scale for UV mapping if texture-based interference is used
    float angularSpread; // For simulating divergence or spread of the holographic beam
};

 struct InterferencePattern
 {
    float3 amplitude;
                    
     float3 frequency;
     float phase;
 };
HolographicLight CreateHolographicLight(float3 pos, float3 dir, float3 col, float3 waveLen, float inten, float cohLen, float phaseOff, float4x4 lightMatrix, float2 uvScale, float angularSpread)
{
    HolographicLight light;
    light.position = pos;
    light.direction = safeNormalize(dir);
    light.color = col;
    light.wavelengthNM = waveLen;
    light.intensity = inten;
    light.coherenceLength = cohLen;
    light.phaseOffset = phaseOff;
    light.lightSpaceMatrix = lightMatrix;
    light.textureUVScale = uvScale;
    light.angularSpread = angularSpread;
    return light;
}
InterferencePattern CalculateInterference(HolographicLight light1, HolographicLight light2, float3 pointInSpaceM, float fringeLegibilityScale)
 {
     InterferencePattern pattern;

    // Calculate per-source phase at pointInSpaceM (each wave's own wavelength, own path)
    float distance1M = length(light1.position - pointInSpaceM);
    float distance2M = length(light2.position - pointInSpaceM);

    float3 wavelength1NM = light1.wavelengthNM * fringeLegibilityScale;
    float3 wavelength2NM = light2.wavelengthNM * fringeLegibilityScale;

    // Each wave accumulates phase over ITS OWN path length and ITS OWN
    // wavelength; only then do the two phases combine.
    float3 phase1 = (2.0 * PI * mToNm(distance1M)) / max(wavelength1NM, EPSILON3)*(.5+.5*cos(time)) + light1.phaseOffset;
    float3 phase2 = (2.0 * PI * mToNm(distance2M)) / max(wavelength2NM, EPSILON3)*(.5+.5*sin(time)) + light2.phaseOffset;
     float3 phaseDiffRGB = phase1 - phase2;
 
    // Two-beam coherent intensity, PER CHANNEL: I = I1+I2+2*sqrt(I1*I2)*cos(dPhi).
    // FIX (was: dot(phaseDiffRGB,1)/3 collapsed RGB phase to one scalar BEFORE
    // cos() -- cos(mean(x)) != mean(cos(x)), so this computed a different,
    // not-actually-achromatic-simplified quantity. Each channel now gets its
    // own cos() of its own phase difference, which is what genuine per-channel
    // two-beam interference (and real rainbow-hologram chromatic fringing) is.
    pattern.amplitude = 2.0 * sqrt(light1.intensity * light2.intensity) * cos(phaseDiffRGB);
    pattern.frequency = (wavelength1NM + wavelength2NM) / 2.0;
    pattern.phase = dot(phaseDiffRGB, ONE3) / 3.0; // diagnostic mean only, not consumed downstream
 
     return pattern;
 }

// Method to project a point into the light's local space, useful for texture-based interference or complex patterns
float2 ProjectToLightSpace(HolographicLight light, float3 worldPosition)
{
    float4 localPoint = mul(light.lightSpaceMatrix, float4(worldPosition - light.position, 1.0));
    return localPoint.xy * light.textureUVScale;
}

// Method to simulate the effect of angular spread on light intensity
float ApplyAngularSpread(float baseIntensity, float angularSpread, float angleToViewer)
{
    return baseIntensity * exp(-angleToViewer * angleToViewer / max(2.0 * angularSpread * angularSpread, EPSILON));
}
// Define a function to create different types of light sources
LightSource CreateLightSource(uint type, float3 position, float3 direction, float3 color, float3 wavelengthNM, float intensity, float coherenceLength,
                              float beamWidth, float divergenceAngle, float phaseOffset)
{
    LightSource light = (LightSource) 0;
    
    light.LightSourceType = type;
    // Common properties for all light types
    light.position = position;
    light.color = color;
    light.wavelengthNM = wavelengthNM;
    light.intensity = intensity;
    light.coherenceLength = coherenceLength;
    light.direction = safeNormalize(direction);
    light.beamWidth = beamWidth;
    light.divergenceAngle = divergenceAngle;
    light.phaseOffset = phaseOffset;
    
    // Specific profiles
    switch (light.LightSourceType)
    {
        case LIGHT_TYPE_POINT:
            // Point light sources emit light equally in all directions, so direction and divergence might not matter
            light.divergenceAngle = 0.0; // Not applicable, but set for clarity
            break;
        
        case LIGHT_TYPE_DIRECTIONAL:
            light.position = ZERO3; // Directional lights are considered to be infinitely far away
            break;
        
        case LIGHT_TYPE_SPOT:
            // For a spot light, ensure the divergence angle is set to something less than PI/2
            light.divergenceAngle = clamp(light.divergenceAngle, 0.0, PI / 2.0 - 0.01); // Small offset to avoid edge case
            break;
        
        case LIGHT_TYPE_BEAM:
            // Beam light, like a laser; narrow divergence, but could have a specific beam width
            light.divergenceAngle = min(light.divergenceAngle, 0.1); // Very narrow angle for beams
            break;
        
        case LIGHT_TYPE_AREA:
            // Area lights could be simulated by modifying the position to represent an area or using multiple point sources
            // Here, you might want to set up additional parameters or use the beamWidth as the area size
            light.beamWidth = max(light.beamWidth, 0.1); // Ensure there's some area
            break;
        
        default:
            // If an unsupported type is passed, default to a point light
            light.LightSourceType = LIGHT_TYPE_POINT;
            break;
    }
    
    return light;
}

// Utility Function: Convert UV and Depth to World Position
inline float3 UVToWorld(float2 uv, float depth)
{
    float3 worldPos;
    worldPos.x = (uv.x - .5) * HOLOGRAM_SIZE_M;
    worldPos.y = (uv.y - .5) * HOLOGRAM_SIZE_M;
    worldPos.z = ((depth)) * HOLOGRAM_SIZE_M;
    return worldPos;
}

void CreatePhasedLightsFromDepth(float2 uv, inout LightSource lights[MAX_LIGHT_SOURCES], inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    float depth = depthRaw(depthMap, uv);
    float3 worldPos = UVToWorld(uv, depth);
    float3 viewPosition = float3(ViewX,ViewY,ViewZ);
    float3 viewDir = safeNormalize(worldPos - viewPosition);
    float3 distanceToViewer = length(worldPos - viewPosition);
    
    
    // Number of lights should be able to represent the resolution of your depth map
    int lightsPerAxis = sqrt(MAX_LIGHT_SOURCES);
    
    // Loop over the area in front of the viewer
    for (int x = 0; x < lightsPerAxis; x++)
    {
        for (int y = 0; y < lightsPerAxis; y++)
        {
            int lightIndex = x * lightsPerAxis + y;
            
            if (lightIndex >= MAX_LIGHT_SOURCES)
                break;
            float3 localDepth0 = depth * HOLOGRAM_SIZE_M * nmToM(RGB_WAVELENGTHS_M) / MAX_LIGHT_SOURCES;
            
            // Convert loop counters to safeNormalized coordinates
            float2 lightUV = float2(x, y) / max(float(lightsPerAxis - 1), EPSILON) - .5;
            float3 lightWorldX = UVToWorld(lightUV, localDepth0.x);
            float3 lightWorldY = UVToWorld(lightUV, localDepth0.y);
            float3 lightWorldZ = UVToWorld(lightUV, localDepth0.z);
            float3 lightDir = safeNormalize(viewPosition - worldPos + lightWorldX);
            // Random seed update for pseudo-randomness in light properties
            randomSeeds[lightIndex] += float3(RotateUVWithDepth(lightUV, localDepth0 + lightWorldY, acos(dot(lightDir, CalcNormal(depthMap, lightUV)))), depthRaw(depthMap, lightUV + lightWorldZ.x));
            
            // Compute light's wavelength - here we'll simulate a simple wavelength distribution
            float3 wavelengthNM = MIN_WAVELENGTHS + clamp(randomSeeds[lightIndex] * WAVELENGTH_RANGES, MIN_WAVELENGTHS, MAX_WAVELENGTHS);
            randomSeeds[lightIndex] += nmToM(wavelengthNM) * dot(CalcNormal(depthMap, lightUV), viewDir);
            
            
            // Calculate light position so that phase converges at worldPos
            // Assuming lights spread in a grid, each light needs to be positioned such that its phase 
            // at worldPos is a multiple of 2PI more than at the last light
            float3 localDepth = depth * HOLOGRAM_SIZE_M * nmToM(wavelengthNM) / MAX_LIGHT_SOURCES;
            randomSeeds[lightIndex] += CalcNormal(depthMap, lightUV + .015 * dot(uv - lightUV, viewDir.xy) * dot(localDepth / max(nmToM(wavelengthNM), viewDir.xyz), EPSILON3));
            
            float3 lightPos = worldPos - lightDir * (localDepth + wavelengthNM * floor(distanceToViewer / wavelengthNM));
            
            // Here we simplify: we want light from all sources to arrive in phase at `worldPos`, 
            // so we place lights at distances ensuring this by integer multiples of their wavelength plus the depth offset
            
            // Set light properties
            lights[lightIndex].position = lightPos;
            lights[lightIndex].wavelengthNM = wavelengthNM;
            lights[lightIndex].intensity = dot(nmToM(wavelengthNM), nmToM(wavelengthNM));
            // Additional properties like direction, coherence length, etc., could be set here based on your needs
        }
    }
}
// Function to create light with reproducible properties from a seed
LightSource CreateDeterministicLight(float seed, float3 viewPosition)
{
    LightSource light = (LightSource) 0;
    
    // Seed manipulation for different properties
    float3 seeds = float3(hash11(seed),
        hash11(seed * 1.12345),
        hash11(seed * 1.34567)
    );

    // Light Type
    int lightType = fmod(int(seeds.x * 5), 5.0); // 5 types of light
    
    // Positioning the light in front of the viewer
    float3 direction = safeNormalize(float3(seeds.y - 0.5, seeds.z - 0.5, 1.0));
    light.position = viewPosition + direction * 1.25 * seeds.x;
    
    float3 lightRangeMin = float3(.01, .01, .01);
    float3 lightRangeMax = float3(0.95, 0.95, 0.75);
    float3 lightRange = lightRangeMax - lightRangeMin;
    
    // Color and wavelength
    light.color = float3(hash11(seed * 2.1),
        hash11(seed * 2.2),
        hash11(seed * 2.3)
    );
    light.wavelengthNM = moilerp(float3(380, 440, 675), float3(750, 675, 380), seeds);
    
    light.position += lightRange - direction * nmToM(light.wavelengthNM);
    
    // Intensity and other properties
    light.intensity = dot(nmToM(seeds * .652 * light.wavelengthNM), light.wavelengthNM);
    light.direction = safeNormalize(viewPosition - light.position + length((400 + light.wavelengthNM) / (1440 * light.wavelengthNM / 1000.0)) * (seeds.y - 0.5) * 0.2);
    light.coherenceLength = seeds.y * 10.0;
    light.phaseOffset = seeds.z * 2.0 * PI;
    
    // Adjust for light type
    switch (lightType)
    {
        case LIGHT_TYPE_POINT:
            light.divergenceAngle = 0.0;
            light.beamWidth = 0.0;
            break;
        
        case LIGHT_TYPE_DIRECTIONAL:
            light.position = viewPosition - light.direction * 1000.0;
            break;
        
        case LIGHT_TYPE_SPOT:
            light.divergenceAngle = seeds.y * 0.4 + 0.1;
            light.beamWidth = 0.0;
            break;
        
        case LIGHT_TYPE_BEAM:
            light.divergenceAngle = 0.01 + seeds.z * 0.05;
            light.beamWidth = 0.01;
            break;
        
        case LIGHT_TYPE_AREA:
            light.beamWidth = seeds.z * 0.5 + 0.1;
            light.divergenceAngle = 0.5;
            break;
    }
    
    return light;
}

// Usage in your shader or main function
void SetupHolographicLights(float3 viewPos, inout LightSource lights[MAX_LIGHT_SOURCES])
{
    float depthRange = f10; // You might want to define this based on your scene's scale
    
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        // Here, each light gets a unique seed based on its index, but you could also use any function 
        // of 'i' to make this deterministic across different runs or machines.
        lights[i] = CreateDeterministicLight(i * 0.1 + 3.14159, viewPos);
    }
}


void GeneratePhaseAlignedLightSources(Texture2D<float> depthMap, float2 uv, float3 viewPos, inout LightSource lights[MAX_LIGHT_SOURCES], inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        lights[i] = CreateDeterministicLight(i * 0.1 + PI, viewPos);
    }
}


// Helper to calculate chromatic dispersion (varying refractive index for different wavelengths)
float3 CalculateChromaticDispersion(float3 nFilmBase, float3 wavelengthsM)
{
    // Example of a simple chromatic dispersion: nFilm varies with wavelength
    return nFilmBase + float3(0.01 / max(wavelengthsM.r, 0.01), 0.01 / max(wavelengthsM.g, 0.01), 0.01 / max(wavelengthsM.b, 0.01));
}

// Helper to calculate diffraction grating effects based on wavelength and grating spacing
float3 CalculateDiffraction(float gratingSpacingM, float3 wavelengthsM, float incidentAngle)
{
    float3 diffractionAngle;
    diffractionAngle.r = asin(sin(incidentAngle) + wavelengthsM.r / max(gratingSpacingM, 0.00001));
    diffractionAngle.g = asin(sin(incidentAngle) + wavelengthsM.g / max(gratingSpacingM, 0.00001));
    diffractionAngle.b = asin(sin(incidentAngle) + wavelengthsM.b / max(gratingSpacingM, 0.00001));

    // Diffraction grating can cause light to spread, modulating intensity
    return abs(sin(diffractionAngle)); // Return diffraction pattern intensity
}

// Helper to calculate polarization effects based on incident and reflection angle
float3 CalculatePolarization(float polarizationAngle, float3 incidentAngle, float3 nIncident, float3 nFilm)
{
    float3 Rs = pow((nIncident * cos(incidentAngle) - nFilm * cos(polarizationAngle)) / (nIncident * cos(incidentAngle) + nFilm * cos(polarizationAngle)), 2.0);
    float3 Rp = pow((nFilm * cos(incidentAngle) - nIncident * cos(polarizationAngle)) / (nFilm * cos(incidentAngle) + nIncident * cos(polarizationAngle)), 2.0);
    return (Rs + Rp) / 2.0;
}

// Main interference calculation combining multiple effects
float3 InterferenceEffects(float thicknessM, float3 normal, float3 viewPos, float3 lightPos, float3 viewDir, float3 wavelengthsM, float3 nIncident, float3 nFilmBase, float gratingSpacingM, float polarizationAngle)
{
    // safeNormalize vectors
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    
    // Angle of incidence
    float cosThetaI = dot(normal, viewDir);
    cosThetaI = clamp(cosThetaI, -1.0, 1.0);
    
    // Apply chromatic dispersion (nFilm varies with wavelength)
    float3 nFilm = CalculateChromaticDispersion(nFilmBase, wavelengthsM);
    
    // Snell's law and transmission angle inside the film
    float3 sinThetaT = (nIncident / nFilm) * sqrt(max(EPSILON3, 1.0 - cosThetaI * cosThetaI));
    if (dot(sinThetaT, sinThetaT) >= 1.0)
    {
        return EPSILON3; // Total internal reflection
    }
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference due to thin-film interference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase difference based on wavelength
    float3 phase = (2.0 * PI * deltaM) / wavelengthsM;
    
    // Fresnel reflectance at first interface (air to film)
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / (nIncident * cosThetaI + nFilm * cosThetaT), 2.0);
    
    // Fresnel reflectance at second interface (film to air)
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / (nFilm * cosThetaT + nIncident * cosThetaI), 2.0);
    
    // Total reflectance including interference
    float3 reflectance = R12 + R23 + 2.0 * sqrt(R12 * R23) * cos(phase);
    
    // Apply diffraction grating effects
    float3 diffraction = CalculateDiffraction(gratingSpacingM, wavelengthsM, cosThetaI);
    
    // Apply polarization effects
    float3 polarization = CalculatePolarization(polarizationAngle, cosThetaI, nIncident, nFilm);
    
    // Combine the effects: interference, diffraction, and polarization
    float3 finalColor = reflectance * diffraction * polarization;
    
    return finalColor;
}
float3 CalculateReflectance(float thicknessM, float3 normal, float3 viewPos, float3 lightPos, float3 viewDir, float3 wavelengthsM, float3 nIncident, float3 nFilmBase)
{
    // safeNormalize vectors
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    
    // Angle of incidence
    float cosThetaI = dot(normal, viewDir);
    cosThetaI = clamp(cosThetaI, -1.0, 1.0);
    
    // Apply chromatic dispersion (nFilm varies with wavelength)
    float3 nFilm = CalculateChromaticDispersion(nFilmBase, wavelengthsM);
    
    // Snell's law and transmission angle inside the film
    float3 sinThetaT = (nIncident / nFilm) * sqrt(max(EPSILON3, 1.0 - cosThetaI * cosThetaI));
    if (dot(sinThetaT, sinThetaT) >= 1.0)
    {
        return EPSILON3; // Total internal reflection
    }
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference due to thin-film interference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase difference based on wavelength
    float3 phase = (2.0 * PI * deltaM) / max(wavelengthsM, EPSILON3);
    
    // Fresnel reflectance at first interface (air to film)
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / max((nIncident * cosThetaI + nFilm * cosThetaT), EPSILON3), 2.0);
    
    // Fresnel reflectance at second interface (film to air)
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / max((nFilm * cosThetaT + nIncident * cosThetaI), EPSILON3), 2.0);
    
    // Total reflectance including interference
    return R12 + R23 + 2.0 * sqrt(R12 * R23) * cos(phase);
    
}



float3 PolarizedInterference(float3 phaseShift, float3 polarAngle)
{
    float3 polarizationEffect = float3(sin(phaseShift.x + polarAngle.x),
        sin(phaseShift.y + polarAngle.y),
        sin(phaseShift.z + polarAngle.z)
    );
    return (polarizationEffect * float3(.5, .5, .5) + float3(0.5, 0.5, 0.5)) * float3(.8, .8, .8) + float3(0.2, 0.2, 0.2);
}


float3 LensFlare(float2 uv, float2 lightPos, float intensity)
{
    float2 delta = uv - lightPos;
    float dist = length(delta);
    float denom = (1.0 + 30.0 * dist * dist);
    if (denom == 0.0)
    {
        denom += EPSILON;
    }
    float flare = 1.0 / denom;
    return float3(1.0, 0.7, 0.4) * flare * intensity; // Warm color for flare
}



float2 HeatHaze(float2 uv, float intensity)
{
    float noise = noiseFast11(uv * 10.0 + time);
    return uv + 10.0 * noise * intensity * float2(sin(time), cos(time));
}


float2 FresnelKernel(float2 offset, float3 wavelength, float depth)
{
    // Calculate the squared distance from the sample point to the observation point
    float r2 = dot(offset, offset);
    
    // Compute the phase shift using the Fresnel approximation
    float3 phase = ONE3 * (PI * r2) / max(wavelength * depth, EPSILON3);
    
    // Return the complex exponential representing the phase shift
    return float2(cos(length(phase)), sin(length(phase)));
}



float3 ApplyDepthOfField(Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float focusDepth, float maxBlur)
{
    float sceneDepth = depthRaw(depthMap, uv);

    // Calculate blur amount based on depth difference
    float blurAmount = saturate(abs(sceneDepth - focusDepth) / max(maxBlur, EPSILON));

    // Sample neighboring pixels based on blur amount
    float3 color = ZERO3;
    int samples = 10;
    float totalWeight = 0.0;

    [loop]
    for (int i = 0; i < samples; i++)
    {
        float angle = (float) i / samples * 6.2831853; // 2*Pi
        float2 offset = blurAmount * float2(cos(angle), sin(angle)) * oosz;

        color += diffuseMap.Sample(sampleTypeMirror, uv + offset).rgb;
        totalWeight += 1.0;
    }

    return color / (totalWeight + EPSILON);
}



// Vertex Shader
PS_INPUT VSMain(VS_INPUT input)
{
    PS_INPUT output = (PS_INPUT) 0;
    output.Position = float4(input.Position, depthRaw(depthMap, input.Position.xy));
    output.uv = input.uv;
    output.ViewDir = safeNormalize(float3(ViewX,ViewY,ViewZ) - input.Position);
    output.Color = float4(1.0, 1.0, 1.0, 1.0);
    return output;
}



float3 ApplyIridescence(float3 normal, float3 viewDir, float scaledTime)
{
    float angle = acos(dot(normal, viewDir));
    float iridescence = sin(angle * 3.0 * scaledTime) * 0.5 + 0.5;
    return moilerp(float3(0.0, 0.5, 1.0), float3(1.0, dot(normal, viewDir), 0.5), iridescence);
}
float3 ApplyDynamicIridescence(float2 uv, float3 wavelengthNM, float3 normal, float3 viewDir, float scaledTime, float noiseScale, float noiseStrength)
{
    // Add noise to the iridescence pattern
    float noiseValue = noiseFast11(uv * noiseScale);
    float3 angle = acos(dot(normal, viewDir)) * noiseValue * (nmToM(wavelengthNM) - noiseStrength);

    float3 iridescence = float3(sin(angle.x * 3.0 * scaledTime) * 0.5 + 0.5, sin(angle.y * 3.0 * scaledTime) * 0.5 + 0.5, sin(angle.z * 3.0 * scaledTime) * 0.5 + 0.5);
    return moilerp(float3(0.0, 0.5, 1.0), float3(1.0, 0.0, 0.5), iridescence);
}

inline float3 GaussianBlur(Texture2D<float4> diffuseMap, float2 uv, float3 blurRadius, float2 oosz)
{
    float3 color = ZERO3;
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 offset = float2(x, y) * blurRadius.xy / oosz;
            color += diffuseMap.SampleLevel(sampleTypeMirror, uv + offset, 0).rgb;
        }
    }
    return color / 9.0;
}

float3 ApplyAnisotropicBloom(Texture2D<float4> tex, float2 uv, float dist, float threshold, float3 minColor, float3 power, float sigma, float anisotropy)
{
    float2 oosz = GetOosz(tex);
    float3 color = tex.Sample(sampleTypeMirror, uv).xyz;
    float luminance = ColorLuminance(color);

    if (luminance >= threshold)
    {
        float3 blurColor = 0.0;
        float totalWeight = 0.0;

        // Dynamic radius based on sigma
        int radius = int(ceil(3.0 * sigma));

        // Precalculate values
        float sigmaSq2 = 2.0 * sigma * sigma;
        float2 ooszDist = oosz * dist;
        int sampleRate = SampleRateFromRange(radius);
        
        [unroll(2)]
        for (int y = -radius; y <= radius; y += sampleRate)
        {
            [unroll(2)]
            for (int x = -radius; x <= radius; x += sampleRate)
            {
                // Apply anisotropy to the offset
                float2 offset = float2(x * (1.0 + anisotropy), y * (1.0 - anisotropy)) * ooszDist;
                float weight = gaussian(length(offset), sigma);
                blurColor += tex.Sample(sampleTypeMirror, uv + offset).xyz * weight;
                totalWeight += weight;
            }
        }

        blurColor /= totalWeight;
        color = moilerp(color, max(minColor, blurColor), luminance * power);
    }

    return color;
}

// Function to rotate a vector around an arbitrary axis using Rodrigues' rotation formula
float3 RotateVector(float3 v, float3 axis, float angle)
{
    axis = safeNormalize(axis);
    float cosA = cos(angle);
    float sinA = sin(angle);
    return v * cosA + cross(axis, v) * sinA + axis * dot(axis, v) * (1.0 - cosA);
}


// Helper function to create GaussianPointSource instances (for initialization)
GaussianPointSource CreateGaussianPointSource(float3 position,
    float3 direction,
    float amplitude,
    float3 color,
    float beamWidth,
    inout GaussianPointSource source
)
{
    source = (GaussianPointSource) 0;
    source.position = position;
    source.direction = safeNormalize(direction);
    source.amplitude = amplitude;
    source.color = color;
    source.beamWidth = beamWidth;
    return source;
}

// Example Initialization Function (to be called from application code)
void InitializeGaussianPointSources(inout int numGaussianPoints,
    inout GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS],
    float2 uv,
    float3 viewPos,
    float beamWidth,
    float radius,
    float3 color
)
{
    // Example: Initialize Gaussian point sources in a circular array
    int totalPoints = MAX_GAUSSIAN_POINTS;
    
    float2 oosz = GetOosz(depthMap);
    float2 sz = GetSz1(depthMap);
    
    for (int i = 0; i < totalPoints; ++i)
    {
        float angle = 2.0 * PI * float(i) / float(totalPoints);
        float3 pos = float3(oosz * float2(radius * cos(angle), radius * sin(angle)), depthRaw(depthMap, uv));
        
        float3 direction = safeNormalize(float3(cos(angle), sin(angle), depthRaw(depthMap, uv)));
        float amplitude = 1.0 / float(totalPoints); // Equal amplitude distribution
       
        gaussianPoints[i] = CreateGaussianPointSource(pos, direction, amplitude, color, beamWidth, gaussianPoints[i]);
    }
    numGaussianPoints = totalPoints;
}


float3 photonAngularVelocity(float3 hz, float angularVelocityFactor = 1)
{
    return 2.0 * 3.14159 * hz * angularVelocityFactor;
}
float3 energyToForce(float3 energy, float3 distance)
{
    // Avoid division by zero by checking if distance is greater than a small threshold
    if (dot(distance, distance) > 1e-6)
    {
        return energy / distance;
    }
    return 0.0;
}
float3 modulateEnergy(float3 energy, float3 waveAmplitude)
{
    return energy * (1.0 + waveAmplitude * sin(time * 3.14159 * 2.0));
}


inline float3 ComputeDisplacement(float3 pixel, float3 wavelengths, float currentPhase, float strength)
{
    // safeNormalize wavelength to a range [400, 700] nm (visible spectrum)
    float3 safeNormalizedWavelength = saturate((wavelengths - MIN_WAVELENGTHS) / WAVELENGTH_RANGES); // 400-700 nm
    
    // Calculate phase based on wavelength and time
    float3 phase = currentPhase + safeNormalizedWavelength * CalculatePhaseShiftM(ComputePathDifferenceM(pixel), wavelengths, float3(1.75, 1.75, 1.75));
    
    // Compute displacement using sine wave for smooth animation
    float3 displacement = sin(phase) * strength * safeNormalizedWavelength;
    
    // Determine direction based on wavelength (e.g., longer wavelengths disperse more to the right)
    // You can customize this based on desired effect
    float3 angle = moilerp(float3(-0.2f, -0.2f, -0.2f), float3(0.2f, 0.2f, 0.2f), safeNormalizedWavelength); // Angle in radians
    
    return displacement * cos(angle);
}



// Function to calculate wavelength-dependent blur radius
float3 WavelengthDependentBlurRadius(float3 wavelengthsNM, float baseRadius)
{
    // Example: shorter wavelengths (blue) have smaller blur radii, longer (red) have larger
    float3 blurRadius = min(float3(0.25, 0.25, 0.25), max(float3(.015, .015, .015), float3(baseRadius, baseRadius, baseRadius))) * float3((.170 * wavelengthsNM.r / RGB_WAVELENGTHS_MM.r), (.140 * wavelengthsNM.g / RGB_WAVELENGTHS_MM.g), (.120 * wavelengthsNM.b / RGB_WAVELENGTHS_MM.b));
    return blurRadius;
}

// Define material properties
struct MaterialDispersion
{
    float3 refractiveIndexBase; // Base refractive index for R, G, B
    float3 dispersionCoefficient; // Dispersion coefficients for R, G, B
};

// Function to adjust refractive index based on wavelength
float3 AdjustRefractiveIndex(float3 wavelengthNM, MaterialDispersion material)
{
    // Simple linear dispersion model: n = n0 + k * (1/λ - 1/λ0)
    // where λ0 is the reference wavelength (e.g., 550 nm for green)
    float referenceWavelength = 550.0; // nm
    float3 refractiveIndex = material.refractiveIndexBase +
                              material.dispersionCoefficient * (ONE3 / wavelengthNM - ONE3 / referenceWavelength);
    return refractiveIndex;
}

float3 refract3(float3 i, float3 n, float3 ri)
{
    return AddOver0(refract(i, n, ri.x), refract(i, n, ri.y), refract(i, n, ri.z));
}

inline float3 ChromaticBlurRadius(float3 wavelengthsNM, float baseRadius, float baseWavelengthNM)
{
    return baseRadius / (wavelengthsNM / baseWavelengthNM);
}

float4 PS_Dispersion(PS_INPUT input) : SV_Target
{
    float2 uv = input.uv;

    // Depth and normal
    float depth = projectedDepth(depthMap, uv);
    float3 normal = CalcNormal(depthMap, uv);
    float3x3 tangentToWorld   = CalcTangentToWorld(depthMap, uv, NormalRadius);

    // View and light directions
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float3 viewDir = safeNormalize(viewPos - float3(uv, depth));
    float3 lightPos = float3(SunX, SunY, SunZ);
    float3 lightDir = safeNormalize(lightPos - float3(uv, depth));

    // Approximate wavelengths (nm)
    float3 wavelengths = RGBToWavelengthsNM(diffuseMap.SampleLevel(sampleTypeMirror,uv,0).xyz);

    // Dispersion model: simple Cauchy equation
    float3 refractiveIndices = 1.5 + (0.05 / (wavelengths * 1e-3)); 

    // Independent refraction per channel
    float3 refrDirR = refract(-viewDir, normal, refractiveIndices.r);
    float3 refrDirG = refract(-viewDir, normal, refractiveIndices.g);
    float3 refrDirB = refract(-viewDir, normal, refractiveIndices.b);

    // UV offsets scaled by depth
    float2 uvOffsetR = refrDirR.xy * depth;
    float2 uvOffsetG = refrDirG.xy * depth;
    float2 uvOffsetB = refrDirB.xy * depth;

    // Sample scene separately per channel
    float colorR = diffuseMap.SampleLevel(sampleTypeMirror, uv + uvOffsetR, 0).r;
    float colorG = diffuseMap.SampleLevel(sampleTypeMirror, uv + uvOffsetG, 0).g;
    float colorB = diffuseMap.SampleLevel(sampleTypeMirror, uv + uvOffsetB, 0).b;

    // Lighting contribution
    float3 lit = max(dot(normal, mul(tangentToWorld, lightDir)), EPSILON).xxx;
    float3 finalColor = float3(colorR, colorG, colorB) * lit;

    return float4(saturate(finalColor), 1.0);
}



inline float2 calculateRefraction(float2 uv, float2 beamCenter, float beamWaist, float refractionStrength)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = safeNormalize(centeredUV) * refractionStrength;
    return gradient;
}

inline float calculateShadow(float currentDepth, float sampleDepth, float shadowIntensity)
{
    return currentDepth > sampleDepth ? shadowIntensity : 1.0;
}

// Utility Function: Calculate Shadow Factor Based on Depth
inline float calculateShadow(Texture2D<float> depthMap, float2 uv, float shadowIntensity, float shadowRadius)
{
    float currentDepth = depthRaw(depthMap, uv);
    float shadowFactor = 1.0;
    
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 sampleUV = uv + float2(x, y) * shadowRadius;
            float sampleDepth = depthRaw(depthMap, sampleUV);
            shadowFactor *= (currentDepth > sampleDepth) ? shadowIntensity : 1.0;
        }
    }
    
    return shadowFactor;
}



// Utility Function: Calculate Glow Based on Depth Proximity
inline float calculateGlow(float2 uv, float2 beamCenter, float depth, float glowRadius)
{
    float distance = length(uv - beamCenter);
    return distance < glowRadius ? smoothstep(glowRadius, glowRadius - 0.05, distance) : 0.0;
}


inline float2 applyLensDistortion(float2 uv, float depth, float lensStrength, float lensRadius)
{
    float distance = length(uv);
    if (distance > lensRadius)
        return uv;
    float factor = lensStrength * (1.0 - distance / lensRadius) * depth;
    return uv + safeNormalize(uv) * factor;
}


// Utility Function: Apply Volumetric Scattering Based on Depth
inline float applyVolumetricScattering(float depth, float scatterIntensity, float scatterScale)
{
    return 1.0 - exp(-scatterIntensity * depth * scatterScale);
}
inline float generateCaustics(float2 uv, float2 beamCenter, float beamWaist, float causticFrequency, float causticIntensity)
{
    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    return sin(causticFrequency * r) * exp(-pow(r / beamWaist, 2.0)) * causticIntensity;
}

// Utility Function: Apply Ripple Distortion Based on Depth
inline float2 applyRipple(Texture2D<float> depthMap, float2 uv, float frequency, float amplitude)
{
    float depth = depthRaw(depthMap, uv);
    float ripple = sin(depth * frequency + amplitude);
    return uv + float2(ripple, ripple);
}


// Utility Function: Calculate Refraction Offset Based on Depth Gradient
inline float2 calculateRefraction(Texture2D<float> depthMap, float2 uv, float2 beamCenter, float beamWaist, float refractionStrength)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = safeNormalize(centeredUV) * refractionStrength;
    float depth = depthRaw(depthMap, uv);
    return gradient * depth;
}

// Utility Function: Apply Complex Ripple Distortion Based on Depth and Time
inline float2 applyComplexRipple(Texture2D<float> depthMap, float2 uv, float frequency, float amplitude, float speed)
{
    float depth = depthRaw(depthMap, uv);
    float ripple = sin(depth * frequency + speed * time) * amplitude;
    return uv + float2(ripple, ripple * 0.5);
}


// Utility Function: Calculate Refraction Offset Based on Depth Gradient and Time
inline float2 calculateDynamicRefraction(Texture2D<float> depthMap, float2 uv, float2 beamCenter, float beamWaist, float refractionStrength)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = safeNormalize(centeredUV) * refractionStrength * sin(time);
    float depth = depthRaw(depthMap, uv);
    return gradient * depth;
}

// Utility Function: Generate Caustic Patterns Based on Depth and Beam Position
inline float generateDynamicCaustics(Texture2D<float> depthMap, float2 uv, float2 beamCenter, float beamWaist, float causticFrequency, float causticIntensity)
{
    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    return sin(causticFrequency * r + time) * exp(-pow(r / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depthRaw(depthMap, uv);
}


float2 FresnelEquations(float nReal, float nImaginary, float cosThetaI)
{
    // Complex refractive index
    float2 nComplex = float2(nReal, nImaginary); // Assuming the real part is n and imaginary is k
    float n2 = 1.0; // Refractive index of the incident medium (air or vacuum typically)

    // Compute sinThetaI from cosThetaI using Pythagorean identity
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);

    // Complex refractive index calculation for the transmitted medium
    float2 nComplexT = nComplex / n2; // Complex refractive index ratio

    // Calculate complex sine of thetaT using Snell's law in complex form
    float2 sinThetaTComplex = sinThetaI / max(nComplexT, EPSILON2);
    float2 cosThetaTComplex = sqrt(1.0 - sinThetaTComplex * sinThetaTComplex); // Complex sqrt for cosine

    // Fresnel coefficients
    float2 Rs = ((nComplexT * cosThetaI - cosThetaTComplex) / max(nComplexT * cosThetaI + cosThetaTComplex, EPSILON2));
    float2 Rp = ((nComplex * cosThetaTComplex - n2 * cosThetaI) / max(nComplex * cosThetaTComplex + n2 * cosThetaI, EPSILON2));

    // Magnitude squared gives reflectance for s and p polarization
    return float2(dot(Rs, Rs), dot(Rp, Rp));
}
float3 MieScattering(float3 viewDir, float3 lightDir, float3 wavelength, float g, float scale, float3 intensity)
{
    // g is the anisotropy factor, typically between -0.75 and 0.99 for real materials
    // scale adjusts the overall impact of scattering
    // intensity controls the strength of the scattering effect
    
    // Simplified phase function for Mie scattering
    float cosTheta = dot(viewDir, lightDir); // Assuming viewDir and lightDir are defined and safeNormalized elsewhere
    float phaseMie = (3.0 / (16.0 * PI)) * (1.0 + pow(max(0.0, cosTheta), 2.0)); // Henyey-Greenstein phase function for small particles

    if (g != 0.0)
    {
        float gg = g * g;
        phaseMie = (1.0 - gg) / max((4.0 * PI * pow(max(EPSILON, 1.0 + gg - 2.0 * g * cosTheta), 1.5)), EPSILON);
    }

    // Wavelength-dependent scattering: typically, scattering is more pronounced for shorter wavelengths (blue light)
    // This is a very rough approximation since actual Mie scattering depends on particle size relative to wavelength
    float3 scattering = pow(float3(400, 500, 650) / wavelength, 4.0); // Rayleigh-like wavelength dependence for visual effect

    // Apply the phase function and wavelength scaling
    float3 scatteringEffect = scattering * phaseMie * scale * intensity;

    return scatteringEffect;
}


struct QuantumGaussianBeam
{
    float3 position;
    float3 direction;
    float beamWaist;
    float divergence;
    float peakIntensity;
    float phaseShift;
};

float3 GeneratePhotonDirection(float2 uv, uint seed)
{
    return safeNormalize(float3(noisePerlin11(uv), noisePerlin11(uv + seed), projectDepth(ViewZ)) - float3(uv, projectedDepth(depthMap, uv)));

}

// Function to generate quantum Gaussian beam with uncertainties
QuantumGaussianBeam GenerateQuantumBeam(float2 uv, uint seed)
{
    QuantumGaussianBeam beam;
    beam.position = float3(uv, depthRaw(depthMap, uv));
    beam.direction = GeneratePhotonDirection(uv, seed);
    
    // Introduce quantum uncertainty in beam waist and divergence
    beam.beamWaist = 0.1 + noiseFast01(float2(float(seed) * 0.1, float(seed) * 0.1)) * 0.05; // Beam waist with uncertainty
    beam.divergence = 0.1 + noiseFast01(float2(seed * 0.11, seed * 0.11)).x * 0.05; // Divergence with uncertainty
    
    // Peak intensity influenced by quantum fluctuations
    beam.peakIntensity = 1 + (noiseFast01(float2(seed * 0.12, seed * 0.12)) - 0.5).x * 0.2;
    
    // Quantum phase shift
    beam.phaseShift = 0.1 * noiseFast01(float2(seed * 0.13, seed * 0.13)).x * 2.0 * PI;
    
    return beam;
}
struct Complex
{
    float real;
    float imag;
};
struct Complex3
{
    float3 real;
    float3 imag;
};
Complex3 CreateComplex3(float3 real, float3 imag)
{
    Complex3 ret;
    ret.real = real;
    ret.imag = imag;
    return ret;
}

// Function to multiply two complex numbers
Complex ComplexMul(Complex a, Complex b)
{
    Complex result;
    result.real = a.real * b.real - a.imag * b.imag;
    result.imag = a.real * b.imag + a.imag * b.real;
    return result;
}
Complex3 ComplexMul(Complex3 a, Complex3 b)
{
    Complex3 result;
    result.real = a.real * b.real - a.imag * b.imag;
    result.imag = a.real * b.imag + a.imag * b.real;
    return result;
}
float3 ComplexMagSq(Complex3 a)
{
    return a.real * a.real + a.imag * a.imag;
}
// Function to add two complex numbers
Complex ComplexAdd(Complex a, Complex b)
{
    Complex result;
    result.real = a.real + b.real;
    result.imag = a.imag + b.imag;
    return result;
}
Complex3 ComplexAdd(Complex3 a, Complex3 b)
{
    Complex3 result;
    result.real = a.real + b.real;
    result.imag = a.imag + b.imag;
    return result;
}


float3 InterferenceM_Complex_Simplified(float thicknessM,
    float3 normal,
    float3 viewDir,
    float3 wavelengthsM,
    float3 nIncident,
    float3 nFilm
)
{
    // Calculate cos(theta_i)
    float3 cosThetaI = dot(normal, viewDir);
    cosThetaI = clamp(cosThetaI, -1.0, 1.0);
    
    // Snell's Law to find sin(theta_t)
    float3 sinThetaT = (nIncident / max(nFilm, EPSILON)) * sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    
    // Check for total internal reflection
    if (dot(sinThetaT, sinThetaT) >= 1.0)
    {
        return ZERO3;
    }
    
    // Calculate cos(theta_t)
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase shift
    float3 phase = (2.0 * PI * deltaM) / wavelengthsM;
    
    // Reflectance coefficients using Fresnel equations
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / (nIncident * cosThetaI + nFilm * cosThetaT), 2.0);
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / (nFilm * cosThetaT + nIncident * cosThetaI), 2.0);
    
    // Complex phase shift
    Complex3 phaseComplex;
    phaseComplex.real = cos(phase);
    phaseComplex.imag = sin(phase);
    
    // Initialize reflectance
    float3 reflectance = ZERO3;
    
    for (int i = 0; i < 3; i++) // RGB channels
    {
        float R12_i = R12[i];
        float R23_i = R23[i];
        
        // Complex amplitudes
        Complex3 R = CreateComplex3(float3(sqrt(R12_i), sqrt(R12_i), sqrt(R12_i)), ZERO3);
        Complex3 S = CreateComplex3(float3(sqrt(R23_i), sqrt(R23_i), sqrt(R23_i)), ZERO3);
        
        // Interference: R + 2 * sqrt(R12 * R23) * phaseComplex
        Complex3 interference = ComplexAdd(R, ComplexMul(CreateComplex3(float3(2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i)), ZERO3), phaseComplex));
        
        // Magnitude squared
        float3 interferenceMagSq = ComplexMagSq(interference); // Assuming real and imag are the same
        
        // Assign to reflectance
        if (i == 0)
            reflectance.x = interferenceMagSq.x;
        else if (i == 1)
            reflectance.y = interferenceMagSq.y;
        else
            reflectance.z = interferenceMagSq.z;
    }
    
    // safeNormalize
    reflectance /= 3.0;
    
    return reflectance;
}
float3 InterferenceM_Simplified(float thicknessM,
    float3 normal,
    float3 viewDir,
    float3 wavelengthsM,
    float3 nIncident,
    float3 nFilm
)
{
    // Calculate cos(theta_i)
    float3 cosThetaI = dot(normal, viewDir);
    cosThetaI = clamp(cosThetaI, -1.0, 1.0);
    
    // Snell's Law to find sin(theta_t)
    float3 sinThetaT = (nIncident / nFilm) * sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    
    // Check for total internal reflection
    if (dot(sinThetaT, sinThetaT) >= 1.0)
    {
        return ZERO3;
    }
    
    // Calculate cos(theta_t)
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase shift
    float3 phase = (2.0 * PI * deltaM) / max(wavelengthsM, EPSILON);
    
    // Reflectance coefficients using Fresnel equations
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / max(nIncident * cosThetaI + nFilm * cosThetaT, EPSILON), 2.0);
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / max(nFilm * cosThetaT + nIncident * cosThetaI, EPSILON), 2.0);
    
    // Complex phase shift
    Complex3 phaseComplex;
    phaseComplex.real = cos(phase);
    phaseComplex.imag = sin(phase);
    
    // Initialize reflectance
    float3 reflectance = ZERO3;
    [unroll]
    for (int i = 0; i < 3; i++) // RGB channels
    {
        float R12_i = R12[i];
        float R23_i = R23[i];
        
        // Complex amplitudes
        Complex3 R = CreateComplex3(float3(sqrt(R12_i), sqrt(R12_i), sqrt(R12_i)), ZERO3);
        Complex3 S = CreateComplex3(float3(sqrt(R23_i), sqrt(R23_i), sqrt(R23_i)), ZERO3);
        
        // Interference: R + 2 * sqrt(R12 * R23) * phaseComplex
        Complex3 interference = ComplexAdd(R, ComplexMul(CreateComplex3(float3(2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i)), ZERO3), phaseComplex));
        
        // Magnitude squared
        float3 interferenceMagSq = ComplexMagSq(interference); // Assuming real and imag are the same
        
        // Assign to reflectance
        reflectance[i] = length(interferenceMagSq);
    }
    
    // safeNormalize
    reflectance /= 3.0;
    
    return reflectance;
}


int PoissonRandom(float lambda, uint seed)
{
    int k = 0;
    float p = 1.0;
    float L = exp(-lambda);
    [unroll(4)]
    while (p > L)
    {
        p *= noiseMap1.SampleLevel(sampleTypeMirror, float2(seed * 0.08, seed * 0.08) + float2(k * 0.01, k * 0.01), 0).x * 2.0 - 1.0;
        k++;
    }
    return k - 1;
}
int GetPhotonCount(float3 intensity, float2 uv, uint seed)
{
    float3 lambda = intensity * 10.0; // Scale intensity to lambda (mean photon count)
    return PoissonRandom(lambda.x, seed) + PoissonRandom(lambda.y, seed) - PoissonRandom(lambda.z, seed);
}
float3 QuantumPhaseShift(float3 pathDifference, float3 wavelength)
{
    return (2.0 * PI * pathDifference) / wavelength;
}
float2 FresnelPolarized(float3 viewDir, float3 normal, float refractiveIndex)
{
    float cosThetaI = clamp(dot(normal, viewDir), .10, 1.0);
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = sinThetaI / max(refractiveIndex, EPSILON);
    if (sinThetaT > 1.0)
    {
        // Total internal reflection
        return float2(1.0, 1.0);
    }
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    float Rs = pow((refractiveIndex * cosThetaI - cosThetaT) / max(refractiveIndex * cosThetaI + cosThetaT, EPSILON), 2.0);
    float Rp = pow((cosThetaI - refractiveIndex * cosThetaT) / max(cosThetaI + refractiveIndex * cosThetaT, EPSILON), 2.0);
    return float2(Rs, Rp);
}


float Noise(float2 uv)
{
    return noisePerlin01(1.5 + uv.x, 3.14159 + uv.y, TotalTime * AnimateSpeed);
}




float4 ReadOutput(inout psout ret, float2 uv, int rtIndex)
{
    float3 retv = ZERO3;
    bool first = true;
    
    float findex = rtIndex;
    float3 v = ret.rt1.xyz;
    [unroll(4)]
    for (int i = 0; i < 7; ++i)
    {
        switch (int(findex))
        {
            case 0:
                v = (rtMap1.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 1:
                v = (rtMap2.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 2:
                v = (rtMap3.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 3:
                v = (rtMap4.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 4:
                v = (rtMap5.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 5:
                v = (rtMap6.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 6:
                v = (rtMap7.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
            case 7:
                v = (rtMap8.SampleLevel(sampleTypeMirror, uv, 0).xyz);
                break;
        }
        float offset = .01 * noisePerlin11(uv.x, uv.y, depthRaw(depthMap, uv) + TotalTime * AnimateSpeed);
        uv += float2(offset, offset);
        if (first)
        {
            retv = v * 1.0 / 8.0;
            first = false;
            
        }
        else
        {
            retv *= v * 1.0 / 8.0;
            
        }
       
        findex--;
        if (findex < 0)
        {
            findex = 7;
        }
    }
    
    return float4(retv, 1.0);
}
void WriteOutput(inout psout ret, float2 uv, float4 c, int rtIndex)
{
    float4 o = ReadOutput(ret, uv, rtIndex - 1);
    float4 val = moilerp(o, c, f10);
    
    
    switch (rtIndex)
    {
        case 0:
            ret.rt1 = val;
            break;
        case 1:
            ret.rt2 = val;
            break;
        case 2:
            ret.rt3 = val;
            break;
        case 3:
            ret.rt4 = val;
            break;
        case 4:
            ret.rt5 = val;
            break;
        case 5:
            ret.rt6 = val;
            break;
        case 6:
            ret.rt7 = val;
            break;
        case 7:
            ret.rt8 = val;
            break;
    }
}

void WriteOutput(inout psout ret, float2 uv, float3 finalColor, int rtIndex)
{
    WriteOutput(ret, uv, float4(finalColor, 1.0), rtIndex);
}

// Bit reversal function
int BitReverse(int x, int log2N)
{
    int result = 0;
    for (int i = 0; i < log2N; i++)
    {
        result = (result << 1) | (x & 1);
        x >>= 1;
    }
    return result;
}

// Helper function for complex multiplication
float2 ComplexMultiply(float2 a, float2 b)
{
    return float2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

// Constants
static const int N = 8; // Texture size N x N (must be a power of two)
// 1D FFT function using Cooley-Tukey
void FFT1D(inout float2 data[N])
{
    int log2N = (int) log2(N);

    // Bit reversal permutation
    for (int i = 0; i < N; i++)
    {
        int j = BitReverse(i, log2N);
        if (j > i)
        {
            float2 temp = data[i];
            data[i] = data[j];
            data[j] = temp;
        }
    }

    // Cooley-Tukey FFT
    for (int s = 1; s <= log2N; s++)
    {
        int m = 1 << s;
        float2 wm = float2(cos(-2.0 * PI / m), sin(-2.0 * PI / m));
        for (int k = 0; k < N; k += m)
        {
            float2 w = float2(1.0, 0.0);
            for (int j = 0; j < m / 2; j++)
            {
                float2 t = ComplexMultiply(w, data[k + j + m / 2.0]);
                float2 u = data[k + j];
                data[k + j] = u + t;
                data[k + j + m / 2.0] = u - t;
                w = ComplexMultiply(w, wm);
            }
        }
    }
}



// 2D FFT function
float2 FFT2D(Texture2D<float2> inputField, float2 uv)
{
    // Convert UV to integer coordinates
    int2 coord = int2(uv * N);

    // Temporary arrays for row and column data
    float2 rowData[N];
    float2 colData[N];

    // Perform FFT on rows
    for (int y = 0; y < N; y++)
    {
        // Load row data
        for (int x = 0; x < N; x++)
        {
            rowData[x] = inputField.Load(int3(x, y, 0));
        }
        // Perform 1D FFT on the row
        FFT1D(rowData);
        // Store transformed row in a temporary texture or buffer
        // tempBuffer[y][x] = rowData[x];
    }

    // Perform FFT on columns
    for (int x = 0; x < N; x++)
    {
        // Load column data from transformed rows
        for (int y = 0; y < N; y++)
        {
            // colData[y] = tempBuffer[y][x];
        }
        // Perform 1D FFT on the column
        FFT1D(colData);
        // Store the final result
        if (coord.x == x && coord.y == y)
        {
            return colData[coord.y];
        }
    }

    return float2(0.0, 0.0);
}
float PhillipsSpectrum(float2 k, float2 windDir, float A)
{
    float kLength = max(length(k), EPSILON);
    

    float kDotWind = max(dot(safeNormalize(k), safeNormalize(windDir)), EPSILON);
    float L = pow(max(length(windDir), EPSILON), 2) / 9.81;
    float damping = 0.001;
    float l = L * damping;

    float phillips = A * exp(-1.0 / (kLength * L * kLength * L)) / pow(max(kLength, EPSILON), 4.0) * pow(max(kDotWind, EPSILON), 2.0);
    phillips *= exp(-kLength * kLength * l * l);

    return phillips;
}
float2 InitializeHeightField(int2 n, float length, float2 windDir, float amplitude)
{
    float2 k = float2((n.x - N / 2.0), (n.y - N / 2.0)) * (2.0 * PI / max(length, EPSILON));
    float Ph = sqrt(PhillipsSpectrum(k, windDir, amplitude)) / sqrt(2.0);

    // Random phase
    float r = noisePerlin11(n);

    return float2(Ph * cos(r), Ph * sin(r));
}
float2 TimeEvolvingHeightField(int2 n, float flength, float2 windDir, float amplitude)
{
    float2 k = float2((n.x - N / 2.0), (n.y - N / 2)) * (2.0 * PI / max(flength, EPSILON));
    float omega = sqrt(9.81 * length(k));

    float2 h0 = InitializeHeightField(n, flength, windDir, amplitude);
    float2 h0_conj = float2(h0.x, -h0.y);

    float2 exp_iwt = float2(cos(omega * time), sin(omega * time));
    float2 exp_neg_iwt = float2(cos(-omega * time), sin(-omega * time));

    return h0 * exp_iwt + h0_conj * exp_neg_iwt;
}

float3 ReinhardToneMapping(float3 color)
{
    return color / (color + 1.0);
}

float3 ApplyHDR(float3 color, float exposure)
{
    color *= exposure;
    return ReinhardToneMapping(color);
}

float3 ApplyGammaCorrection(float3 color, float gamma)
{
    return pow(max(color, EPSILON), 1.0 / gamma);
}

float3 HolographicEffect(float2 texCoord)
{
    float3 hologramColor = float3(0.0, 0.8, 1.0);
    float wave = sin(texCoord.x * 20.0 + time * 2.0) * 0.05;
    float3 waveEffect = hologramColor + wave;
    return waveEffect;
}

float4 postEffect(float4 diffuse, float2 uv, float2 sz, float exposure, float gamma)
{
    // Add subtle dithering to reduce banding
    float2 pixelCoord = uv * sz;
    float dither = frac(sin(dot(pixelCoord, float2(12.9898, 78.233))) * 43758.5453);
    diffuse.rgb += dither * 0.005;

    // Apply 3D Holographic Effect
    float3 holographicEffect = HolographicEffect(uv);
    float3 finalColor = moilerp(diffuse.rgb, holographicEffect, 0.3);

    // Apply HDR and Tone Mapping
    finalColor = ApplyHDR(finalColor, exposure);

    // Apply Gamma Correction
    finalColor = AdjustGamma(finalColor, gamma);

    return float4(finalColor * mir2D(diffuseMap, uv).xyz, diffuse.a);
}


// Fresnel effect function for holographic depth using Schlick's approximation
float3 fresnel(float3 viewDir, float3 normal, float3 refractionIndex)
{
    float cosTheta = clamp(dot(viewDir, normal), EPSILON, OneMinusEPSILON);
    float3 F0 = pow(max((ONE3 - refractionIndex) / max((ONE3 + refractionIndex), EPSILON3), EPSILON3), ONE3 * 2.0);
    float3 fresnelEffect = F0 + (ONE3 - F0) * pow(max(ONE3 - float3(cosTheta, cosTheta, cosTheta), EPSILON3), ONE3 * float3(FresnelPower, FresnelPower, FresnelPower));
    return fresnelEffect;
}

// Plasmative oscillations function to enhance realism
float3 plasmative_oscillations(float3 color, float2 uv, float3 freq, float3 amp, float3 scatterCoeff)
{
    float3 wave = sin(dot(uv, uv) * angularFrequencyFromHz(hzFromPeriod(periodFromWavelength(RGBToWavelengths(color)))) + time) * cos(time * amp);
    return color * (ONE3 + wave * scatterCoeff);
}

// Apply absorption using Beer-Lambert Law
inline float3 apply_absorption(float3 color, float distance, float3 absorptionCoefficient)
{
    return color * exp(-absorptionCoefficient * distance);
}

// Apply lighting with diffuse and ambient components
float3 apply_lighting(float3 color, float3 normal, float3 lightDir, float3 ambientLight, float3 lightColor)
{
    float diff = max(dot(normal, lightDir), 0.0);
    float3 diffuse = diff * color * lightColor;
    return ambientLight + diffuse;
}

// Calculate photon energy contribution
inline float3 photon_energy(float3 wavelength, float speedOfLight)
{
    return (float3(PlanckConstant, PlanckConstant, PlanckConstant) * float3(speedOfLight, speedOfLight, speedOfLight)) / max(wavelength, EPSILON3);
}

// Quantum interference term


// Nonlinear term for enhanced realism
inline float3 nonlinear_effect(float3 amplitude, float dist)
{
    return amplitude * exp(-dist * dist);
}

// Gravitational phase shift due to photonic gravitation
float3 gravitational_phase_shift(float3 mass, float distance, float3 frequency, float speedOfLight)
{
    
    float3 potential = -G * mass / max(distance, EPSILON);
    // Gravitational time dilation affects frequency
    float3 deltaFrequency = -potential * frequency / (speedOfLight * speedOfLight);
    // Phase shift due to change in frequency over time
    float3 deltaPhase = deltaFrequency * time * 2.0 * PI;
    return deltaPhase;
}

// Fresnel diffraction modulation
float3 fresnel_diffraction(float apertureRadius, float3 wavelength, float distance)
{
    float3 fresnelNumber = (apertureRadius * apertureRadius) / max(wavelength * distance, EPSILON3);
    // Simplified modulation based on Fresnel number
    return cos(PI3 * fresnelNumber);
}

// Gaussian phase scattering function
inline float gaussian_phase_scattering(float3 position, float scatteringStrength)
{
    // Generate a random phase shift based on a Gaussian distribution
    float randomValue = frac(sin(dot(position.xyz, float3(12.9898, 78.233, 37.719))) * 43758.5453);
    float gaussian = exp(-pow(max((randomValue - 0.5) / scatteringStrength, EPSILON), 2.0));
    return gaussian;
}

// Accurate calculation of light travel distance
inline float calc_distance(float3 viewerPos, float3 pointPos)
{
    return length(viewerPos - pointPos);
}

// Advanced lightwave simulation including Gaussian phase scattering
float3 lightwave_simulation(
    float3 color,
    float3 viewerPos,
    float3 pointPos,
    float3 wavelength,
    float speedOfLight,
    
   
    float3 refractionIndex,
    float3 scatteringCoefficient,
    float3 absorptionCoefficient,
    float3 ambientLight,
    float3 normal,
    float3 reflectNormal,
    float3 lightDir,
    float3 lightColor,
    float apertureRadius,
    float scatteringStrength)
{
    float dist = calc_distance(viewerPos, pointPos);
    float3 frequency = ONE3 * nmToM(wavelength) / speedOfLight * 1.0 / dist;
    
    // Gravitational phase shift
    float3 deltaPhase = gravitational_phase_shift(f5 * (PhotonMass * nmToM(wavelength) * cos(time * frequency * 2.0 * PI) / (speedOfLight * 2.0)),
    dist, frequency, speedOfLight);
    
    // Fresnel diffraction modulation
    float3 fresnelModulation = fresnel_diffraction(apertureRadius, wavelength, dist);
    
    // Gaussian phase scattering
    float gaussianScattering = gaussian_phase_scattering(pointPos, scatteringStrength);
    
    
    float3 wave = sin((sqrt(2.0 * PI * frequency * time * dist * (1.0 + PassNum)) + max(deltaPhase, EPSILON3) + float3(gaussianScattering, gaussianScattering, gaussianScattering)));
    // Apply Fresnel diffraction modulation
    wave *= fresnelModulation;
    
    // Apply the wave equation with phase shift
    float3 result = color * (ONE3 + wave);
    result = apply_absorption(result, dist, absorptionCoefficient);
    float d = dot(safeNormalize(viewerPos - pointPos), -reflectNormal);
//    result += FresnelSchlick(refractionIndex, d, FresnelPower);
    result = d * plasmative_oscillations(result, pointPos.xy, frequency, EPSILON3, scatteringCoefficient);
    result *= apply_lighting(result, normal, lightDir, ambientLight, lightColor);
//    result *= quantum_interference(dist, wavelength, time, phase, speedOfLight);
//    result *= nonlinear_effect(deltaPhase, dist);
   
    /*
    
    // Apply lighting
    
    
    // Apply quantum interference
    
    
    // Apply nonlinear effects
    
    */
    // Incorporate particle (photon) behavior
    
    
    return result;
}

    // Monitor properties
static float MonitorRefreshRate = f3; // in Hz
static float2 PixelDensity = mToMm(GetOosz(depthMap)); // in pixels per meter (px/m)


const float pi = PI;

float3 ComputeWaveNumber(float3 direction, float3 wavelengthsM)
{
    return (2.0 * pi) * direction / mToNm(wavelengthsM);
}

void ComputeObjectWave(float depth, float plateDistance, float3 r, float3 wavelengthsM, out float U_O_real, out float U_O_imag, float A_O)
{
    float2 uv = float2(r.x, r.y) / plateDistance;
 
    float z = depth + plateDistance;

    float3 objectPos = float3(r.x, r.y, z);

    float3 delta_r = (objectPos - r);
    float dist = length(delta_r);
    dist = max(dist, EPSILON);

    float3 direction = delta_r / dist;
    float3 k_O = ComputeWaveNumber(direction, wavelengthsM);

    float phi_O = dot(k_O, delta_r);

    float amplitude = A_O / dist;

    U_O_real = amplitude * cos(phi_O);
    U_O_imag = amplitude * sin(phi_O);
}


inline float3 wrapPhase(float3 phase)
{
    float3 wrappedPhase = fmod(phase, TWOPI3);
    if (wrappedPhase.x < 0.0)
    {
        wrappedPhase.x += TWOPI;
    }
    if (wrappedPhase.y < 0.0)
    {
        wrappedPhase.y += TWOPI;
    }
    if (wrappedPhase.z < 0.0)
    {
        wrappedPhase.z += TWOPI;
    }
    return wrappedPhase;
}

// Function to map wavelength (nm) to RGB color using CIE 1931 approximation
float3 WavelengthToRGB4(float wavelength)
{
    float3 color = ZERO3;
    float gamma = 0.8; // Gamma correction factor

    // Spectral color mapping based on wavelength ranges
    if (wavelength >= 380.0 && wavelength < 440.0)
    {
        color.r = -(wavelength - 440.0) / (440.0 - 380.0);
        color.g = 0.0;
        color.b = 1.0;
    }
    else if (wavelength >= 440.0 && wavelength < 490.0)
    {
        color.r = 0.0;
        color.g = (wavelength - 440.0) / (490.0 - 440.0);
        color.b = 1.0;
    }
    else if (wavelength >= 490.0 && wavelength < 510.0)
    {
        color.r = 0.0;
        color.g = 1.0;
        color.b = -(wavelength - 510.0) / (510.0 - 490.0);
    }
    else if (wavelength >= 510.0 && wavelength < 580.0)
    {
        color.r = (wavelength - 510.0) / (580.0 - 510.0);
        color.g = 1.0;
        color.b = 0.0;
    }
    else if (wavelength >= 580.0 && wavelength < 645.0)
    {
        color.r = 1.0;
        color.g = -(wavelength - 645.0) / (645.0 - 580.0);
        color.b = 0.0;
    }
    else if (wavelength >= 645.0 && wavelength <= 780.0)
    {
        color.r = 1.0;
        color.g = 0.0;
        color.b = 0.0;
    }

    // Intensity correction based on wavelength
    if (wavelength >= 380.0 && wavelength < 420.0)
    {
        float factor = 0.3 + 0.7 * (wavelength - 380.0) / (420.0 - 380.0);
        color *= factor;
    }
    else if (wavelength >= 420.0 && wavelength < 701.0)
    {
        // Full intensity; no modification
    }
    else if (wavelength >= 701.0 && wavelength <= 780.0)
    {
        float factor = 0.3 + 0.7 * (780.0 - wavelength) / (780.0 - 700.0);
        color *= factor;
    }
    else
    {
        color = ZERO3; // Outside visible spectrum
    }

    // Apply gamma correction for display accuracy
    color = pow(max(color, EPSILON), float3(gamma, gamma, gamma));
    return color;
}

// Function to process a single wavefront, calculating its phase and color
void ProcessWavefront(float3 baseAmplitude, int i, float3 positionMeters, float3 refractedDir, float waveSpeed, float3 wavelengthMeters, out Wavefront wf)
{
    wf = (Wavefront) 0;

    // Phase calculation: Determines the wave's oscillation at the given point and time
    // Formula: Phase = (dot(position, direction) - waveSpeed * time) * (2π / wavelength)
    wf.phase = wrapPhase((dot(positionMeters, normalize(refractedDir)) - waveSpeed * time) * (TWOPI / max(float3(1, 1, 1), wavelengthMeters))
);

    // Amplitude variation: Introduce slight temporal fluctuations for dynamic patterns
    wf.amplitude = baseAmplitude * (float3(0.8, 0.8, 0.8) + float3(0.4, 0.4, 0.4) * cos(float3(time, time, time) + float3(float(i) * 1.5, float(i) * 1.5, float(i) * 1.5))); // [Meters]

    wf.wavelengthMeters = wavelengthMeters; // [Meters]

    // Spectral color based on wavelength in nanometers
    wf.color = WavelengthsToRGB(mToNm(wavelengthMeters)); // Convert [Meters] to [Nanometers]

}


float3 RefractDirection(float3 incident, float n, float3 normal)
{
    float3 I = safeNormalize(incident); // Incident vector [Unit Vector] - [Spatial]
    float3 N = safeNormalize(normal); // Normal vector [Unit Vector] - [Spatial]
    float cosI = dot(-I, N); // Cosine of incident angle [Dimensionless]
    float sinT2 = (1.0 - cosI * cosI) * (n * n); // Sine squared of transmission angle [Dimensionless]

    // Total Internal Reflection (TIR) condition
    if (sinT2 > 1.0)
    {
        // Reflect the incident direction to simulate TIR
        return reflect(I, N); // [Unit Vector] - [Spatial]
    }

    float cosT = sqrt(1.0 - sinT2); // Cosine of transmission angle [Dimensionless]
    return n * I + (n * cosI - cosT) * N; // Refracted direction [Unit Vector] - [Spatial]
}



float3 ApplyChromaticAberration(float2 oosz, Texture2D<float4> tex, float2 uv, float intensity)
{
    // Dynamic offsets based on time for animated aberration
    float2 redOffset = uv + intensity * float2(-1.0, -0.3) * oosz + float2(sin(time), cos(time)) * 0.001;
    float2 greenOffset = uv;
    float2 blueOffset = uv + intensity * float2(1.0, 0.3) * oosz + float2(cos(time), sin(time)) * 0.001;
    
    float3 color = float3(
        tex.SampleLevel(sampleTypeMirror, redOffset, 0).r,
        tex.SampleLevel(sampleTypeMirror, greenOffset, 0).g,
        tex.SampleLevel(sampleTypeMirror, blueOffset, 0).b
    );
    return color;
}
//2. Dynamic Fresnel Reflections
float3 DynamicFresnel(float3 viewDir, float3 normal, float3 refractiveIndex, out float3 refractedDir)
{
    float3 reflectance = CalculateFresnelReflectance2(viewDir, normal, refractiveIndex, refractedDir);
    // Modulate reflectance based on time for dynamic effect
    reflectance *= 1.0 + 0.5 * sin(time * 2.0 * PI);
    return reflectance;
}
//3. Enhanced Wave Interference Patterns
float3 EnhancedWaveInterference(float3 lightPos, float3 viewDir, float3 position, float3 viewPos,
    float3 wavelengthsM, MaterialSellmeier material)
{
    float3 refractiveIndex = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 refractedDir;
    float3 reflectance = CalculateReflectance(material.thicknessM, CalcNormal(depthMap, position.xy), viewPos, lightPos, viewDir, wavelengthsM, refractiveIndex, float3(1.21, 1.22, 1.35));
    
    // Increased frequency and animated phase
    float3 phase = saturate(dot(position, refractedDir) * TWOPI / wavelengthsM + time * PI);
    float3 interference = sin(phase * 3.0) * reflectance * 1.5;
    
    return interference;
}
//4. Rainbow Edge Highlights
float3 ApplyRainbowEdge(float2 uv, float3 normal, float3 viewDir, float3 baseColor, float2 texelSize)
{
    // Detect edges based on normal variation
    float3 normalRight = normal2D(normalMap, uv + float2(texelSize.x, 0));
    float3 normalUp = normal2D(normalMap, uv + float2(0, texelSize.y)).xyz;
    float edgeStrength = length(normal - normalRight) + length(normal - normalUp);
    
    // Apply rainbow gradient based on edge strength
    float3 rainbow = float3(
        sin(TWOPI * edgeStrength + 0.0) * 0.5 + 0.5,
        sin(TWOPI * edgeStrength + 2.0 * PI / 3.0) * 0.5 + 0.5,
        sin(TWOPI * edgeStrength + 4.0 * PI / 3.0) * 0.5 + 0.5
    );
    
    return moilerp(baseColor, rainbow, ONE3 * edgeStrength * 0.5);
}
//5. Anisotropic Lighting
float3 AnisotropicLighting(float3 normal, float3 viewDir, float3 lightDir, float3 lightColor, float roughness, float specularIntensity)
{
    // Calculate halfway vector
    float3 halfwayDir = normalize(lightDir + viewDir);
    
    // Anisotropic specular reflection based on tangent space
    float spec = pow(max(dot(normal, halfwayDir), 0.0), roughness * 128.0);
    float3 specular = spec * specularIntensity * lightColor;
    
    // Diffuse component
    float diff = max(dot(normal, lightDir), 0.0);
    float3 diffuse = diff * lightColor;
    
    return diffuse + specular;
}
//6. Dynamic Grating Map Animations
float3 AnimatedDiffraction(Texture2D<float4> gratingMap, float2 uv, float3 wavelengths, float3 normal, float3 viewDir)
{
    // Animate grating maps by shifting UV coordinates over time
    float2 animatedUV1 = uv + float2(sin(time), cos(time)) * 0.01;
    float2 animatedUV2 = uv + float2(cos(time * 0.5), sin(time * 0.5)) * 0.01;
    float2 animatedUV3 = uv + float2(sin(time * 1.5), cos(time * 1.5)) * 0.01;
    float2 animatedUV4 = uv + float2(cos(time * 2.0), sin(time * 2.0)) * 0.01;
    
    float4 grating1 = gratingMap1.SampleLevel(sampleTypeMirror, animatedUV1, 0);
    float4 grating2 = gratingMap2.SampleLevel(sampleTypeMirror, animatedUV2, 0);
    float4 grating3 = gratingMap3.SampleLevel(sampleTypeMirror, animatedUV3, 0);
    float4 grating4 = gratingMap4.SampleLevel(sampleTypeMirror, animatedUV4, 0);
    
    // Combine grating maps with weighted intensities
    float4 combinedGrating = (grating1 * 0.4 + grating2 * 0.3 + grating3 * 0.2 + grating4 * 0.1);
    
    // Apply diffraction based on grating intensity and wavelength
    float3 diffraction = combinedGrating.rgb * sin(TWOPI * combinedGrating.rgb * dot(normal, viewDir)) * wavelengths;
    diffraction *= 2.0; // Increased diffraction intensity
    
    return diffraction;
}
//7. Thin- Film Interference
float3 ThinFilmInterference(float3 viewPos, float3 lightPos, float3 lightDir, float3 wavelengthsNM, float thicknessM, float3 normal, float3 viewDir, MaterialSellmeier material,
inout float3 refractedDirA, inout float3 refractedDirB, inout float3 refractedDirC)
{
    float3 refractiveIndex = SellmeierEquationM(nmToM(wavelengthsNM), material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

   
    float3 reflectance = CalculateReflectance(material.thicknessM, normal, viewPos, lightPos, viewDir, nmToM(wavelengthsNM), refractiveIndex, float3(1.3, 1.35, 1.33));
    
    refractedDirA = refract(-lightDir, normal, refractiveIndex.x);
    refractedDirB = refract(-lightDir, normal, refractiveIndex.y);
    refractedDirC = refract(-lightDir, normal, refractiveIndex.z);
    // Calculate optical path difference
    float3 deltaR = refractedDirA * mToNm(thicknessM);
    float3 phaseR = TWOPI3 * deltaR / max(EPSILON3, wavelengthsNM);
    
    float3 deltaG = refractedDirB * mToNm(thicknessM);
    float3 phaseG = TWOPI3 * deltaG / max(EPSILON3, wavelengthsNM);
    
    float3 deltaB = refractedDirC * mToNm(thicknessM);
    float3 phaseB = TWOPI3 * deltaB / max(EPSILON3, wavelengthsNM);
    // Interference based on phase
    float3 interference = cos(phaseR * dot(refractedDirA, viewDir) + phaseG * dot(refractedDirB, viewDir) + phaseB * dot(refractedDirC, viewDir)) * reflectance;
    
    return interference;
}
//8. Subsurface Scattering
float3 SubsurfaceScattering(float3 color, float depth, float3 normal, float3 lightDir, float3 viewDir, float scatteringCoefficient)
{
    // Simple subsurface scattering approximation
    float3 scattering = color * scatteringCoefficient * max(dot(normal, lightDir), 0.0);
    return scattering;
}
//9. Polarization- Based Color Shifts
float3 PolarizationColorShift(float3 color, float3 viewDir, float3 normal, float polarizationAngle)
{
    // Calculate polarization based on view and normal directions
    float angle = atan2(dot(viewDir, float3(1, 0, 0)), dot(viewDir, float3(0, 1, 0)));
    float3 polarizedColor = color * (1.0 + sin(angle + radians(polarizationAngle)) * 0.5);
    return polarizedColor;
}

float3 VolumetricScattering(float3 lightColor, float3 position, float3 viewDir, float density, float scatteringCoefficient)
{
    // Simple volumetric scattering based on density and angle
    float scatter = exp(-dot(position, viewDir) * density);
    return lightColor * scatter * scatteringCoefficient;
}
//11. Birefringence Simulation
float3 BirefringenceEffect(float3 viewDir, float3 viewPos, float3 lightPos, float3 normal, float3 wavelengthsM, MaterialSellmeier material)
{
    // Simulate double refraction
    float3 refractiveIndex = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 refractedDir1;
    float3 reflectance1 = CalculateFresnelReflectance2(viewDir, normal, material.B1, refractedDir1);
    
    float3 refractedDir2;
    float3 reflectance2 = CalculateFresnelReflectance2(viewDir, normal, material.B2, refractedDir2);
    
    float3 refractedDir3;
    float3 reflectance3 = CalculateFresnelReflectance2(viewDir, normal, material.B3, refractedDir3);
    // Combine both refracted directions
    float3 birefringentColor = reflectance1 + reflectance2 + reflectance3;
    
    return birefringentColor;
}
//12. Tensor- Based Normal Variations
float3 AdvancedTensorNormalMap(Texture2D<float3> normalMap, float2 uv, float3 tangent, float3 bitangent, float3 normal, float3 tensorScale)
{
    float3 tangentNormal = normal2D(normalMap, uv);
    // Construct tangentToWorld matrix
    float3x3 tangentToWorld = float3x3(tangent, bitangent, normal);
    // Apply tensor scaling
    float3 scaledTangentNormal = tangentNormal * tensorScale;
    // Transform normal from tangent space to world space
    return normalize(mul(tangentToWorld, scaledTangentNormal));
}


//13. Quantum Interference Patterns
float3 QuantumInterference(float3 position, float3 lightDir, float3 wavelengthsM, MaterialSellmeier material)
{
    float3 refractiveIndex = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 refractedDir;
    float3 reflectance = CalculateFresnelReflectance2(lightDir, position, refractiveIndex, refractedDir);
    
    // Quantum-inspired interference with multiple wave sources
    float3 phase1 = saturate(dot(position, refractedDir) * TWOPI / max(wavelengthsM, EPSILON) + time * PI);
    float3 phase2 = saturate(dot(position, refractedDir) * TWOPI / max(wavelengthsM, EPSILON) - time * PI);
    float3 interference = sin(phase1) + sin(phase2);
    
    return interference * reflectance;
}
//14. Dynamic Wavefront Modulation
float3 DynamicWavefrontModulation(float3 position, float3 lightDir, float3 wavelengthsM, MaterialSellmeier material)
{
    float3 refractiveIndex = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 refractedDir;
    float3 reflectance = CalculateFresnelReflectance2(lightDir, position, refractiveIndex, refractedDir);
    
    // Modulate wavefront dynamically with a moving phase shift
    float3 phase = saturate(dot(position, refractedDir) * TWOPI / max(wavelengthsM, EPSILON) + time * PI * 0.5);
    float3 interference = sin(phase) * reflectance;
    
    return interference;
}
//15. Holographic Lens Flares
float3 HolographicLensFlare(float2 uv, float3 color, float3 lightDir, float3 viewDir, float intensity)
{
    float3 lightPos = normalize(lightDir);
    float2 uvFlare = uv + lightPos.xy * 0.05;
    float flare = exp(-dot(uvFlare - 0.5, uvFlare - 0.5) * 100.0);
    float3 flareColor = float3(1.0, 0.8, 0.5) * flare * intensity;
    
    // Animate flare over time
    flareColor *= (0.5 + 0.5 * sin(time * PI));
    
    return color + flareColor;
}

//16. Multi-Layered Holography
float3 MultiLayerHolography(float3 baseColor, float3 interference1, float3 interference2, float3 diffraction1, float3 diffraction2)
{
    // Blend multiple layers of interference and diffraction
    float3 holographicLayer1 = interference1 + diffraction1;
    float3 holographicLayer2 = interference2 + diffraction2;
    
    // Combine layers with additive blending
    float3 finalHologram = holographicLayer1 * 0.7 + holographicLayer2 * 0.3;
    
    return baseColor + finalHologram;
}
// 17.Advanced Light Tunneling Effects
float3 LightTunneling(float3 color, float3 normal, float3 viewDir, float3 lightDir, float tunnelingStrength)
{
    // Calculate tunneling based on angle and material properties
    float angle = dot(normal, lightDir);
    float tunnelFactor = saturate(angle * tunnelingStrength);
    
    // Blend original color with tunneled light color
    float3 tunneledColor = color * tunnelFactor + lightDir * (1.0 - tunnelFactor);
    
    return tunneledColor;
}


//18.Procedural NoiseIntegration for Randomness
float3 ProceduralNoiseHolography(Texture2D<float3> noiseMap, float2 uv, float3 baseColor, float3 interference, float3 diffraction, float3 timeFactors)
{
    // Sample procedural noise for randomness
    float3 noiseValue = safeNormalize(noiseMap.SampleLevel(sampleTypeMirror, uv * 10.0, 0).xyz) * 2.0 - 1.0;
    
    // Modulate interference and diffraction with noise
    interference *= noiseValue;
    diffraction *= (1.0 - noiseValue);
    
    // Blend with base color
    float3 finalColor = baseColor + interference + diffraction;
    
    return finalColor;
}



//19. Temporal Light Fading and Pulsing hlsl
float3 TemporalPulsing(float3 color, float pulseFrequency, float pulseAmplitude)
{
    // Create a pulsing effect using a sine wave
    float pulse = sin(time * pulseFrequency * TWOPI) * pulseAmplitude + 1.0;
    
    // Modulate color intensity
    return color * pulse;
}


//20.Advanced Integrals for Light Scattering Simulation hlsl
float3 IntegralLightScattering(float3 position, float3 lightDir, float3 viewDir, float3 wavelengths, MaterialSellmeier material)
{
    // Numerical approximation of integrals for light scattering
    float3 scattering = float3(0.0, 0.0, 0.0);
    int samples = 10;
    for (int i = 0; i < samples; i++)
    {
        float t = float(i) / float(samples);
        float3 samplePos = position + lightDir * t;
        scattering += sin(dot(samplePos, lightDir) * TWOPI / wavelengths) * material.scatteringCoefficient;
    }
    scattering /= float(samples);
    
    return scattering;
}// Wave Interference Simulation
float3 WaveInterference(float3 viewDir, float3 position, float3 lightDir, float3 wavelengthsM, MaterialSellmeier material)
{
    float3 refractiveIndex = SellmeierEquationM(wavelengthsM, material.B1, material.B2, material.B3, material.C1, material.C2, material.C3);

    float3 refractedDir = refract3(-lightDir, CalcNormal(depthMap, position.xy), refractiveIndex);
    float3 reflectance = Fresnel3(mir2D(diffuseMap, position.xy).xyz, viewDir, CalcNormal(depthMap, position.xy), material.thicknessM, FresnelPower, FresnelReflectance);
    
    // Simulate interference pattern (simplified)
    float3 phase = saturate(dot(position, refractedDir) * TWOPI / max(wavelengthsM, EPSILON3));
    float3 interference = sin(phase) * reflectance;
    
    return interference;
}
// Advanced Lighting Model combining Diffuse and Specular
float3 AdvancedLighting(float3 normal, float3 viewDir, float3 lightDir, float3 lightColor, MaterialSellmeier material)
{
    // Diffuse Component (Lambertian)
    float diff = max(dot(normal, lightDir), 0.0);
    float3 diffuse = diff * lightColor;
    
    // Specular Component (Blinn-Phong)
    float3 halfwayDir = normalize(lightDir + viewDir);
    float spec = pow(max(dot(normal, halfwayDir), 0.0), material.roughness * 128.0);
    float3 specular = spec * SpecularPower * lightColor;
    
    // Combine Diffuse and Specular
    return diffuse + specular;
}

// Gamma Correction Function
float3 GammaCorrection(float3 color, float gamma)
{
    return pow(max(color, EPSILON3), float3(1.0 / gamma, 1.0 / gamma, 1.0 / gamma));
}

// Integrate Light Scattering using Gaussian Approximations
float3 ApplyLightScattering(float3 color, float3 normal, float3 lightDir, float3 viewDir)
{
    // Simple Gaussian scattering based on the angle between normal and light direction
    float scatter = exp(-pow(max(dot(normal, lightDir) - 0.5, EPSILON), 2.0) / 0.1);
    return color * scatter;
}

float3 TensorNormalMap(Texture2D<float3> normalMap, float2 uv, float3 tangent, float3 bitangent, float3 normal)
{
    float3 tangentNormal = safeNormalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0) * 2.0 - 1.0);
    // Construct tangentToWorld matrix
    float3x3 tangentToWorld = float3x3(tangent, bitangent, normal);
    // Transform normal from tangent space to world space
    return safeNormalize(mul(tangentToWorld, tangentNormal));
}
// Self-Shadowing Function
float3 SelfShadowing(float3 normal, float3 lightDir, float sigmaShadow)
{
    // Ensure normal and lightDir are normalized
    normal = safeNormalize(normal);
    lightDir = safeNormalize(lightDir);
    
    // Calculate the cosine of the angle between normal and light direction
    float cosTheta = clamp(dot(normal, lightDir), 0.0, 1.0);
    
    // Calculate the angle in radians
    float theta = acos(cosTheta);
    
    // Apply Gaussian attenuation
    float attenuation = gaussian(theta, sigmaShadow);
    
    // Return attenuation factor (same for RGB channels)
    return float3(attenuation, attenuation, attenuation);
}

struct DichroismCoefficients
{
    float absorptionRed;
    float absorptionGreen;
    float absorptionBlue;
};

// Function to Generate Wave-Based Displacement
float WaveDisplacement(float2 uv, float frequency, float amplitude, float speed)
{
    return sin(uv.x * frequency + time * speed) * amplitude;
}

// Function to Apply Physical Force Influence
float3 ApplyPhysicalForce(float3 normal, float3 forceDir, float intensity)
{
    // Calculate the influence based on the force direction and normal
    float influence = saturate(dot(normal, forceDir));
    // Apply displacement to the normal based on force intensity
    return normal + forceDir * influence * intensity;
}

// Function to Apply Noise-Based Deformation
float3 NoiseBasedDeformation(Texture2D<float3> noiseTexture, float2 uv, float frequency, float amplitude)
{
    // Sample noise texture
    float3 noiseValue = noiseTexture.SampleLevel(sampleTypeLinear, uv * frequency + time, 0);
    // Apply deformation based on noise
    return float3(amplitude * noiseValue.x, amplitude * noiseValue.y, amplitude * noiseValue.z);
}

// Function to Adjust Absorption Coefficients Based on Normal and Depth
DichroismCoefficients AdjustDichroism(
    DichroismCoefficients baseCoeffs,
    float3 normalR, float depthR,
    float3 normalG, float depthG,
    float3 normalB, float depthB,
    float3 lightDir,
    float exponent)
{
    DichroismCoefficients adjustedCoeffs;

    // Angle-based modulation
    float angleModR = saturate(dot(normalR, lightDir));
    float angleModG = saturate(dot(normalG, lightDir));
    float angleModB = saturate(dot(normalB, lightDir));

    // Non-linear depth attenuation
    float attenR = pow(max(depthR, EPSILON), exponent);
    float attenG = pow(max(depthG, EPSILON), exponent);
    float attenB = pow(max(depthB, EPSILON), exponent);

    // Adjust absorption
    adjustedCoeffs.absorptionRed = baseCoeffs.absorptionRed * (1.0f - angleModR) * attenR;
    adjustedCoeffs.absorptionGreen = baseCoeffs.absorptionGreen * (1.0f - angleModG) * attenG;
    adjustedCoeffs.absorptionBlue = baseCoeffs.absorptionBlue * (1.0f - angleModB) * attenB;

    // Clamp to [0,1]
    adjustedCoeffs.absorptionRed = saturate(adjustedCoeffs.absorptionRed);
    adjustedCoeffs.absorptionGreen = saturate(adjustedCoeffs.absorptionGreen);
    adjustedCoeffs.absorptionBlue = saturate(adjustedCoeffs.absorptionBlue);

    return adjustedCoeffs;
}

// Function to Apply Dichroism
float3 ApplyDichroism(float3 inputColor, DichroismCoefficients coeffs)
{
    // Ensure the input color is normalized
    float3 normalizedColor = SRGBToLinear(inputColor);

    // Apply absorption per channel
    float3 absorbedColor;
    absorbedColor.r = normalizedColor.r * (1.0f - coeffs.absorptionRed);
    absorbedColor.g = normalizedColor.g * (1.0f - coeffs.absorptionGreen);
    absorbedColor.b = normalizedColor.b * (1.0f - coeffs.absorptionBlue);

    return ApplyGammaCorrection(LinearRGBToSRGB(absorbedColor), 1.2);
}


#define MAX_LAYERS 64     // Maximum number of layers supported
#define MAX_ITERATIONS 4  // Maximum iterations for Newton-Raphson
#define BINARY_SEARCH_DEPTH 5 // Binary search iterations for initial approximation


// Smootherstep function for smooth interpolation
float smootherstep(float edge0, float edge1, float x)
{
    // Scale, and clamp x to 0..1 range
    x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    // Evaluate polynomial
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}


// Hermite interpolation for higher-order smoothness
float hermiteInterpolate(float y0, float y1, float mu)
{
    // Hermite interpolation (cubic)
    float mu2 = mu * mu;
    float a0 = 2.0 * y0 - 2.0 * y1;
    float a1 = -3.0 * y0 + 3.0 * y1;
    float a2 = 0.0;
    float a3 = y0;
    return a0 * mu * mu2 + a1 * mu2 + a3;
}

// Newton-Raphson method to refine intersection depth
float2 refineIntersection(
    float2 uv,
    float2 deltaTexCoord,
    float layerDepth,
    float currentLayerDepth,
    float heightFromTexture,
    float2 initialTexCoord
)
{
    // Initial guess based on linear search
    float2 refinedTexCoord = initialTexCoord;
    
    // Newton-Raphson iterations
    for (int i = 0; i < MAX_ITERATIONS; ++i)
    {
        // Sample height at current texture coordinates
        float height = depthRaw(depthMap, refinedTexCoord);
        
        // Compute the function value: f(x) = height - layerDepth
        float f = height - currentLayerDepth;
        
        // Compute the derivative using central differences
        float delta = 0.001;
        float height_dx = (depthRaw(depthMap, refinedTexCoord + float2(delta, 0.0)) - depthRaw(depthMap, refinedTexCoord - float2(delta, 0.0))) / (2.0 * delta);
        float height_dy = (depthRaw(depthMap, refinedTexCoord + float2(0.0, delta)) - depthRaw(depthMap, refinedTexCoord - float2(0.0, delta))) / (2.0 * delta);
        float2 df = float2(height_dx, height_dy);
        
        // Avoid division by zero
        float denominator = dot(df, deltaTexCoord);
        if (abs(denominator) < EPSILON)
            break;
        
        // Update texture coordinates
        refinedTexCoord -= deltaTexCoord * (f / max(denominator, EPSILON));
        
        // Clamp texture coordinates to [0,1]
        refinedTexCoord = clamp(refinedTexCoord, 0.0, 1.0);
    }
    
    return refinedTexCoord;
}

// Main Advanced POM function
float2 AdvancedParallaxOcclusionMapping_POM(
    float heightScale,
    float depthScale,
    float2 uv, // Original texture coordinates
    float3 viewDir, // View direction in tangent space
    int numLayers = 30, // Number of depth layers
    float parallaxScale = 1.0, // Scale of parallax effect
    float F0 = 0.04, // Fresnel reflectance at normal incidence
    float fresnelPower = 5.0
)
{
    // Normalize the view direction
    float3 V = safeNormalize(viewDir.xyz);
    float depth0 = depthRaw(depthMap, uv);
    float3 n = CalcNormal(depthMap, uv);
    float NdotV = saturate(dot(V, safeNormalize(n.xyz)));
    
    // Calculate Fresnel factor and adjust parallax scale accordingly
   
    float3 diffuse0 = mir2D(diffuseMap, uv).xyz;
    
    float3 fresnelFactor = f6*FresnelSchlick(F0, dot(V, n), FresnelPower); // Assuming normal is (0,0,1) in tangent space
    float3 scale = fresnelFactor * (1 - depth0) * depthScale;
    
    // Calculate the view direction's magnitude in the tangent plane
    float2 Vt = scale.xy * float2(1, 0.1);
    
    // Example of dynamic layer count based on texture coordinate derivatives
    float2 dx = ddx(uv);
    float2 dy = ddy(uv);
    float pixelArea = max(dot(dx, dx) + dot(dy, dy), EPSILON);
    int dynamicLayers = clamp(int(log2(pixelArea) * -10.0) + 30, 16, MAX_LAYERS);
    
    
    // Calculate the size of each layer step
    float layerDepth = 1.0 / float(dynamicLayers);
    float2 deltaTexCoord = Vt / float(dynamicLayers);
    
    // Initialize current texture coordinates and depth
    float2 currentTexCoord = uv;
    float currentLayerDepth = 0.0;
    float heightFromTexture = depth0;
    
    // Initial linear search to find the intersection layer
    int layer;
    [unroll]
    for (layer = 0; layer < dynamicLayers; ++layer)
    {
        currentLayerDepth += layerDepth;
        currentTexCoord += deltaTexCoord * (1 - heightFromTexture);
        heightFromTexture = depthRaw(depthMap, currentTexCoord);
        
        if (heightFromTexture < currentLayerDepth)
            break;
      
            
    }
    
    // Perform Newton-Raphson refinement for precise intersection
    float2 refinedTexCoord = refineIntersection(
        uv,
        deltaTexCoord,
        currentLayerDepth,
        heightFromTexture,
        currentLayerDepth,
        currentTexCoord + deltaTexCoord // Initial guess is previous texture coord
    );
    
    // Ensure texture coordinates are within [0,1]
    refinedTexCoord = clamp(refinedTexCoord, 0.0, 1.0);
    
    // Higher-order interpolation using Hermite
    float heightCurrent = depthRaw(depthMap, refinedTexCoord);
    float heightNext = depthRaw(depthMap, refinedTexCoord + deltaTexCoord);
    
    float mu = (currentLayerDepth - heightNext) / (heightCurrent - heightNext + EPSILON);
    mu = smootherstep(0.0, 1.0, mu);
    
    // Final interpolated texture coordinates
    float2 finalTexCoord = float2(hermiteInterpolate(
        refinedTexCoord.x - deltaTexCoord.x,
        refinedTexCoord.x,
        mu
    ), hermiteInterpolate(
        refinedTexCoord.y - deltaTexCoord.y,
        refinedTexCoord.y,
        mu
    ));
    
    return finalTexCoord;
}


// Combines texture sampling with procedural height generation
float GetHeight(float2 texCoords, float frequency, float amplitude, float proceduralWeight)
{
    float heightFromMap = depthRaw(depthMap, texCoords);
    float proceduralHeight = noisePerlin012(texCoords * frequency).x * amplitude;
    return moilerp(heightFromMap, proceduralHeight, proceduralWeight);
}

// Secant method for intersection refinement
float2 RefineIntersectionSecant(
    float2 prevTexCoords,
    float prevHeight,
    float prevDepth,
    float2 currTexCoords,
    float currHeight,
    float currDepth,
    float frequency, float amplitude, float proceduralWeight,
    int numRefinementSteps)
{
    for (int i = 0; i < numRefinementSteps; i++)
    {
        // Compute the secant slope
        float slope = (currHeight - prevHeight) / (currDepth - prevDepth + EPSILON);
        // Avoid division by zero
        if (abs(slope) < EPSILON)
            break;
        // Compute the new depth estimate
        float depthEstimate = currDepth - currHeight / slope;
        // Interpolate texture coordinates
        float t = (depthEstimate - prevDepth) / (currDepth - prevDepth + EPSILON);
        float2 newTexCoords = lerp(prevTexCoords, currTexCoords, t);
        newTexCoords = clamp(newTexCoords, 0.0, 1.0);
        // Sample height at new texture coordinates
        float newHeight = GetHeight(newTexCoords, frequency, amplitude, proceduralWeight);
        // Update variables for next iteration
        prevTexCoords = currTexCoords;
        prevHeight = currHeight;
        prevDepth = currDepth;
        currTexCoords = newTexCoords;
        currHeight = newHeight;
        currDepth = depthEstimate;
    }
    return currTexCoords;
}


// Enhanced Parallax Occlusion Mapping Function
float2 ParallaxOcclusionMappingAdvanced(
    float2 texCoords,
    float3 viewDir,
    int minSamples,
    int maxSamples,
    float heightScale,
    float frequency, float amplitude, float proceduralWeight,
    int numRefinementSteps,
    out float parallaxDepth)
{
    parallaxDepth = 0;
    // Normalize view direction
    viewDir = safeNormalize(viewDir);

    // Calculate the number of samples based on the viewing angle
    float viewAngle = dot(CalcNormal(depthMap, texCoords), viewDir);
    int numSamples = 10; //(int) moilerp(maxSamples, minSamples, saturate(viewAngle));

    // Calculate the size of each step
    float3 deltaTexCoords = normalize(viewDir.xyz) / numSamples;

    // Initialize variables for the loop
    float2 currentTexCoords = texCoords;
    float currentDepth = 0.0;
    float stepDepth = 1.0 / numSamples;

    // Height from height map at the current texture coordinates
    float heightFromMap = GetHeight(currentTexCoords, frequency, amplitude, proceduralWeight);

    // Perform linear search to find the initial depth interval
    [loop]
    for (int i = 0; i < numSamples; i++)
    {
        if (currentDepth >= heightFromMap)
        {
            // Found the depth interval; proceed to refinement
            break;
        }

        currentTexCoords += deltaTexCoords.xy;
        currentDepth += stepDepth;

        // Early exit if texture coordinates are out of bounds
        if (any(currentTexCoords < 0.0) || any(currentTexCoords > 1.0))
        {
            currentTexCoords = clamp(currentTexCoords, 0.0, 1.0);
            return currentTexCoords;
            break;
        }

        heightFromMap = GetHeight(currentTexCoords, frequency, amplitude, proceduralWeight);
    }

    // Intersection refinement using Secant method
    float2 prevTexCoords = currentTexCoords - deltaTexCoords.xy;
    float prevHeight = GetHeight(prevTexCoords, frequency, amplitude, proceduralWeight);
    float prevDepth = currentDepth - stepDepth;

    float2 refinedTexCoords = RefineIntersectionSecant(
        prevTexCoords, prevHeight, prevDepth,
        currentTexCoords, heightFromMap, currentDepth, frequency, amplitude, proceduralWeight, numRefinementSteps);

    // Output the parallax depth for further effects
    parallaxDepth = currentDepth;

    return currentTexCoords;
}




float3 SimulateInterferenceReal(float3 surfacePosM, float3 viewPosM, float3 wavelengthsNM,
    float3 refPosM, float coherenceLengthM, float refPhaseOffset, float objPhaseOffset,
    float fringeLegibilityScale)
{
    HolographicLight refBeam = CreateHolographicLight(
        refPosM, safeNormalize(viewPosM - refPosM), ONE3, wavelengthsNM,
        1.0, coherenceLengthM, refPhaseOffset,
        (float4x4)0, float2(1.0, 1.0), 0.0);

    HolographicLight objBeam = CreateHolographicLight(
        refPosM, safeNormalize(viewPosM - surfacePosM), ONE3, wavelengthsNM,
        1.0, coherenceLengthM, objPhaseOffset,
        (float4x4)0, float2(1.0, 1.0),	TanhFactorG);

    InterferencePattern pattern = CalculateInterference(refBeam, objBeam, viewPosM, fringeLegibilityScale);
    return pattern.amplitude;
}
// ============================================================================
// UPPERMOST ECHELON HOLOGRAPHIC SHADER
// Volume-phase holography with Kogelnik coupled-wave theory,
// spectral Monte-Carlo sampling, partial coherence, and speckle statistics.
// ============================================================================


// [STRIPPED 75 bytes]
// Full Holographic Reconstruction - FIXED
// Assumptions: all positions in meters, wavelengths in meters inside
// Depends on: SampleSpectrum(), KogelnikDiffractionEfficiency(),
// WavelengthsToRGB(), GenerateSpeckleField(), TemporalCoherenceEnvelope()
// [STRIPPED 75 bytes]

float3 ReconstructHologram(
    float2 uv,
    float3 pixelPosM, // Object point in tangentToWorld space, origin = surface
    float3 viewPosM, // Observer in tangentToWorld space
    float3 lightPosM, // Reconstruction source in tangentToWorld space
    float3 peakWavelengthsNM,// UI input, nanometers
    float coherenceLengthM, // meters
    float fringeScale, // 0-1 anti-aliasing
    float thicknessMM,
    float dn,
    float seed)
{
    // Cache - was evaluated 2x per spectral sample
    float3 N = CalcNormal(depthMap, uv);

    float3 reconDir = safeNormalize(lightPosM - pixelPosM);
    float3 objectDir = float3(0,0,1); // normal-incidence recording. Replace with CB if needed

    float thicknessM = thicknessMM * 1e-3;

    float cosThetaRef = saturate(dot(reconDir, N));
    float cosThetaObj = saturate(dot(objectDir, N));
    float thetaRef = acos(cosThetaRef);
    float thetaObj = acos(cosThetaObj);

    Wavefront spectrum[SPECTRAL_COUNT];
    SampleSpectrum(uv, peakWavelengthsNM * 1e-9, seed, spectrum);

    float3 accumulated = 0.0;
    float3 totalWeight = 0.0;

    [unroll]
    for (int s = 0; s < SPECTRAL_COUNT; ++s)
    {
        float3 lambdaM = spectrum[s].wavelengthMeters; // single wavelength per bin
        float3 k = TWO_PI / lambdaM;

        // Correct OPD - not length(pixelPosM * 0.001)
        float3 opticalPathDiff = dot(pixelPosM, objectDir - reconDir);
        float3 visibility = TemporalCoherenceEnvelope(opticalPathDiff, coherenceLengthM);

        // One Kogelnik eval per wavelength, not 3x
        float2 efficiencyX = KogelnikDiffractionEfficiency(
            lambdaM.x, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float2 efficiencyY = KogelnikDiffractionEfficiency(
            lambdaM.y, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float2 efficiencyZ = KogelnikDiffractionEfficiency(
            lambdaM.z, thetaObj, thetaRef, thicknessM, dn,
            AVERAGE_REFRACTIVE_INDEX, 0.0
        );
        float3 eta = float3(length(efficiencyX), length(efficiencyY), length(efficiencyZ)) * visibility;

        float3 orderColor = 0.0;
        [unroll]
        for (int m = -MAX_DIFFRACTION_ORDERS; m <= MAX_DIFFRACTION_ORDERS; ++m)
        {
            float orderWeight = (m == 1)? 1.0 : 0.1 / (1.0 + abs(float(m - 1)) * 2.0);
            float3 thisEta = eta * orderWeight;
            if (length(thisEta) < 1e-4) continue;

            // Bragg detuning for order m
            float3 braggDetune = float(m - 1) * lambdaM / (2.0 * thicknessM * AVERAGE_REFRACTIVE_INDEX + 1e-12);

            float3 phase = k * opticalPathDiff + spectrum[s].phase + braggDetune * k;
            float3 interference = 0.5 + 0.5 * cos(phase);

            interference = lerp(0.5, interference, fringeScale);

            float3 rgbContrib = WavelengthsToRGB(lambdaM * 1e9);
            orderColor += rgbContrib * interference * thisEta;
        }

        float surfaceRoughness = 0.5e-6;
        orderColor = GenerateSpeckleField(pixelPosM.xy, orderColor, surfaceRoughness, lambdaM, seed + float(s));

        accumulated += orderColor * spectrum[s].amplitude;
        totalWeight += spectrum[s].amplitude;
    }

    return accumulated / max(totalWeight, EPSILON);
}

float2 ParallaxOffset(float2 uv, float3 viewDirTS, float depthSample)
{
    float height = depthSample * HeightParamA * ParallaxScale;
    return uv - viewDirTS.xy * height;
}


// ============================================================
// PART 1/3 — Holographic diffraction color core
// ============================================================

// Combines 4 grating channels with per-channel phase/cosine/tanh
// modulation to approximate angle- and wavelength-dependent
// diffraction shimmer. T=heur C=0.6 — this is a plausible
// diffraction-look approximation, not a physically derived
// grating equation (no actual wavelength/groove-spacing math).
float3 HoloDiffraction(float2 uv, float3 normal, float3 viewDir)
{
    // View-angle term drives the "color shifts as you look from
    // different angles" hologram signature.
    float NdotV = saturate(dot(normal, viewDir));
    float grazing = 1.0 - NdotV; // 0 = face-on, 1 = grazing

    // Sample 4 grating maps — each contributes one interference band.
    // A: grating*Map/*Depth/*Normal are float3/float4/float per original
    // register list; using .r on float3 gratingMap samples below —
    // V: unconfirmed whether grating maps store grayscale-in-rgb or
    // meaningful per-channel data. Treating as grayscale-encoded.
    float3 g1 = gratingMap1.SampleLevel(sampleTypeLinear, uv + ParallaxScaleOMD*GetOosz(gratingDepth1)*float2(cos(time), 0.0), 0).rgb;
    float3 g2 = gratingMap2.SampleLevel(sampleTypeLinear, uv - ParallaxScaleOMD*GetOosz(gratingDepth2)*float2(sin(time), 0.0), 0).rgb;
    float3 g3 = gratingMap3.SampleLevel(sampleTypeLinear, uv + ParallaxScaleOMD*GetOosz(gratingDepth3)*float2(0.0, cos(time)), 0).rgb;
    float3 g4 = gratingMap4.SampleLevel(sampleTypeLinear, uv - ParallaxScaleOMD*GetOosz(gratingDepth4)*float2(0.0, sin(time)), 0).rgb;

    // Per-channel phase modulation — this is the actual "holography"
    // trick: R/G/B get independently phase-shifted cosine terms,
    // producing the shifting-rainbow-band look as grazing angle changes.
    float phaseR = PhaseOffsetR + grazing * 6.28318530718 + time;
    float phaseG = PhaseOffsetG + grazing * 6.28318530718 + time;
    float phaseB = PhaseOffsetB + grazing * 6.28318530718 + time;

    float3 bandR = cos(phaseR * CosineFactorR + (g1 + g3) * 3.14159265);
    float3 bandG = cos(phaseG * CosineFactorG + (g2 + g4) * 3.14159265);
    float3 bandB = cos(phaseB * CosineFactorB + (g1 + g2 + g3 + g4) * 1.5707963);

    // Tanh soft-clip per channel — compresses the cosine bands into
    // punchier, more saturated interference stripes rather than
    // smooth sinusoids. T=heur C=0.55 — stylistic choice, not
    // derived from any physical diffraction model.
    float3 bands = float3(
        tanh(bandR.r * TanhFactorR),
        tanh(bandG.g * TanhFactorG),
        tanh(bandB.b * TanhFactorB)
    );

    // Remap [-1,1] -> [0,1] and pull in the rainbow gradient texture
    // as a color LUT driven by the combined band signal, for a
    // controllable palette instead of raw RGB cosine output.
    float bandLum = saturate(dot(bands, float3(0.299, 0.587, 0.114)) * 0.5 + 0.5);
    float3 rainbow = rainbowMap2.Sample(sampleTypeLinear, float2(bandLum, 0.5)).rgb;

    return rainbow * (bands * 0.5 + 0.5);
}

// Full per-pixel holographic surface evaluation.
float3 EvaluateHoloSurface(float2 uv)
{
    float3 viewPos = float3(ViewX, ViewY, ViewZ);

    // Reconstruct normal + tangentToWorld using prior-turn-fixed functions.
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, NormalRadius);
    float3 normal = normalize(tangentToWorld[2]);

    // View direction in tangent space for parallax offsetting.
    // A: centerPos from CalcTangentToWorld's internal space (uv,depth) is being
    // reused here as a stand-in world/view position — same open
    // question as prior turn's #4/#9 (depth-space ambiguity).
    // C=0.4 T=[modality-inferred] — this is the weakest link in
    // the whole chain; flagging loudly rather than hiding it in
    // a working-looking formula.
    float3 pseudoPos = float3(uv, projectedDepth(depthMap, uv));
    float3 viewDirWS = safeNormalize(viewPos - pseudoPos);
    float3 viewDirTS = safeNormalize(mul(tangentToWorld, viewDirWS)); // project into tangent space via tangentToWorld rows

    float depthSample = projectedDepth(depthMap, uv);
    float2 uvParallax = ParallaxOffset(uv, viewDirTS, f3*depthSample);

    float NdotV = saturate(dot(normal, viewDirTS));
    float3 fresnel = FresnelSchlick(ONE3*FresnelReflectance, NdotV, FresnelPower);

    float3 holo = HoloDiffraction(uvParallax, normal, viewDirWS);
    float4 base = diffuseMap.Sample(sampleTypeLinear, uvParallax);

    // FresnelMix as final blend weight between base albedo and
    // holographic shimmer — A: chosen interpretation, not the
    // only valid one (could instead be an exponent modifier on
    // fresnel itself; going with blend-weight as more common/
    // more controllable from a UI slider standpoint).
    float3 result = lerp(base.rgb, holo,  FresnelMix*fresnel	);

    return result * base.rgb;
}
















// ============================================================
// PHYSICALLY CORRECT THIN-FILM INTERFERENCE CORE
// ============================================================

// ------------------------------------------------------------
// COMPLEX FIELD FROM AMPLITUDE + PHASE
// ------------------------------------------------------------
float2 ComplexFromAmpPhase(float3 amplitude, float phase)
{
    float ph = phase + TotalTime * AnimateSpeed;
    return clamp(float2(length(amplitude) * cos(ph), length(amplitude) * sin(ph)), -1, 1.);
}

void ComplexFromAmpPhase3(float3 amplitude, float3 phase, out float2 ampR, out float2 ampG, out float2 ampB)
{
    float3 ph = phase + TotalTime * AnimateSpeed;
    ampR = clamp(float2(length(amplitude) * cos(ph.r), length(amplitude) * sin(ph.r)), -1, 1.);
    ampG = clamp(float2(length(amplitude) * cos(ph.g), length(amplitude) * sin(ph.g)), -1, 1.);
    ampB = clamp(float2(length(amplitude) * cos(ph.b), length(amplitude) * sin(ph.b)), -1, 1.);
}


// ------------------------------------------------------------
// PHYSICALLY CORRECT THICKNESS (nanometers → meters)
// ------------------------------------------------------------
float ComputeFilmThicknessM(float2 uv, float3 normalTS, float3 viewTS)
{
    // Depth-driven smooth variation
    float d = saturate(projectedDepth(depthMap,uv));   // 0–1
    float depthNM = 2.+d;          // up to 20 µm

    // Curvature-driven iridesc1ence
    float c = 1.0 - dot(normalize(normalTS), normalize(viewTS));
    float curvatureNM = c * 80.0;                     // up to 800 nm

    // Noise-driven chaotic variation
    float n = noise3(noiseMap1, float3(uv, TotalTime * AnimateSpeed)).x;
    float noiseNM = n * 30.0;                         // up to 300 nm

    // Parameter-driven modulation (safe for 1e-20 → 1e+20)
    float p = abs(Mix2);
    float normalizedP = saturate(log10(1.0+p) * 0.5 + 0.5);
    float paramNM = normalizedP * 2000.;              // up to 1.2 µm

    // Combine all contributions
    float thicknessNM = depthNM + curvatureNM + noiseNM + paramNM;

    // Convert nanometers → meters
    return thicknessNM * 1e-9;
}


// ------------------------------------------------------------
// PHYSICALLY CORRECT OPTICAL PATH DIFFERENCE
// ------------------------------------------------------------
float ComputeOpticalPathM(float thicknessM, float nFilm, float cosThetaT)
{
    // ΔL = 2 * nFilm * t * cos(theta_t)
    return 2.0 * nFilm * thicknessM * cosThetaT;
}


// ------------------------------------------------------------
// PHASE ACCUMULATION (with diffraction + aberration)
// ------------------------------------------------------------
// ============================================================
// FULL PHASE CALCULATION (PHYSICALLY CORRECT)
// ============================================================

// k = 2π / λ
// φ = k * ΔL + φ_stokes + φ_diffraction + φ_aberration + φ_time

float3 ComputePhaseFull(
    float3 viewDirTS,
    float3 normalTS,
    float2 uv,
    float3 lambdaM,
    float opticalPathM,
    float stokesShift
){
    // ------------------------------------------------------------
    // 1. Wave number (k = 2π / λ)
    // ------------------------------------------------------------
    float3 k = 2.0 * PI / lambdaM;

    
    // ------------------------------------------------------------
    // 2. Diffraction grating term (angular)
    //    This simulates CD‑like spectral streaks.
    // ------------------------------------------------------------
    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv);

    float depth = projectedDepth(depthMap, uv);
    float gratingAxis = dot(CalcNormal(gratingDepth1, uv), normalize(viewDirTS));
    float3 diffractionNM = gratingAxis * mToNm(lambdaM);
    opticalPathM += nmToM(length(diffractionNM));

    // ------------------------------------------------------------
    // 3. Micro-aberration noise (surface microstructure)
    //    Produces natural rainbow distortions.
    // ------------------------------------------------------------
    float aberration = dot(viewDirTS, normalize(tangentToWorld[1]));
    float3 aberrationNM = aberration * mToNm(lambdaM);
    opticalPathM += nmToM(aberrationNM.r);
    float aberration2 = dot(viewDirTS, normalize(tangentToWorld[2]));
    float3 aberration2NM = aberration2 * mToNm(lambdaM);
    opticalPathM += nmToM(aberration2NM.b);	

    // ------------------------------------------------------------
    // 4. Polarization modulation (tilt-dependent amplitude)
    //    This affects amplitude, not phase, but we include it here
    //    so the caller can apply it consistently.
    // ------------------------------------------------------------
    float pol = abs(dot(viewDirTS, normalize(mul(tangentToWorld, CalcNormal(gratingDepth2, uv)))));           // 0–1
    float polarizationFactor = lerp(0.5, .7234, pol);      // amplitude scaling




    // ------------------------------------------------------------
    // 6. Final phase accumulation
    // ------------------------------------------------------------
    float3 phase =
        k * opticalPathM +     // wavelength-dependent phase
        stokesShift * polarizationFactor;             // animated phase offset


    return phase;
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
    float2 uv, Wavefront samples[8], float thickM, float nFilm, float3 viewDirTS, float3 normalTS, float cosThetaT)
{
    float thick = ComputeOpticalPathM(thickM, nFilm, cosThetaT);
    float3 accum = 0;
    
    for(int i=0;i<8;i++){
        float3 surfPos = UVDepthToMetersM(uv, projectedDepth(depthMap, uv), 0);

        float3 base = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz;
        float3 lambdaNM = RGBToWavelengthsNM(base);
        float3 lambdaM = nmToM(lambdaNM);
        float3 phi = (TWO_PI * thick) / lambdaM;

        // Proper complex rotation, not rotR.xx
        float2 rotX = float2(cos(phi.z), sin(phi.z));
        float3 amp = samples[i].amplitude;

        // Interference intensity = |amp * e^i phi|^2 = dot
        float3 intensity = amp * (0.5 + 0.5 * rotX.x);

        // Pol weighting
        float pol = saturate(dot(normalTS, viewDirTS));
        intensity *= lerp(0.6, 1.0, pol);

        accum += WavelengthsToRGB(lambdaNM) * intensity;
    }
    return accum / 8.0;
}

// [STRIPPED 66 bytes]
// PS - FIXED: spaces, + vs -, mul order
// [STRIPPED 66 bytes]
psout PS(PS_INPUT input)
{
    psout output; InitPSOut(output, input.uv);
    float2 uv = input.uv;

    float3x3 tangentToWorld = CalcTangentToWorld(depthMap, uv, NormalRadius);
    float3x3 worldToTangent = transpose(tangentToWorld);

    float3 surfPos = UVDepthToMetersM(uv, projectedDepth(depthMap, uv), 0);
    float3 viewPos = UVDepthToMetersM(float2(ViewX,ViewY),projectDepth(ViewZ),0);
    float3 lightPos = UVDepthToMetersM(float2(SunX,SunY),projectDepth(SunZ),0);

    float3 normalTS = float3(0,0,1); // in tangent space, normal IS (0,0,1)
    float3 normalWS = normalize(mul(tangentToWorld,normalTS));

    float3 viewDirWS = safeNormalize(viewPos - surfPos); // was + surfPos
    float3 lightDirWS = safeNormalize(lightPos - surfPos);

    float3 viewDirTS = safeNormalize(mul(worldToTangent, viewDirWS)); // was mul(tangentToWorld)
    float3 lightDirTS = safeNormalize(mul(worldToTangent, lightDirWS));

    Wavefront samples[8];
    // Use your SampleSpectrum if you have, else init
    float3 baseColor = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).rgb;
    for(int i=0;i<8;i++){
        float3 wl = RGBToWavelengthsNM(baseColor) + i*5.0;
        samples[i].wavelengthMeters = nmToM(wl);
        samples[i].amplitude = dot(baseColor, 0.333);
        samples[i].phase = hash33((viewPos - surfPos)/samples[i].wavelengthMeters) * TWO_PI;
        samples[i].color = WavelengthsToRGB(wl);
    }

    float cosThetaT = saturate(dot(normalTS, viewDirTS)); // both in TS

    float thickM = mmToM(VOLUME_HOLOGRAM_THICKNESS_MM);
    float3 interferenceRGB = SpectralInterferenceTensor(uv, samples, thickM, surfPos.z-viewPos.z, viewDirTS, normalTS, cosThetaT);

    float3 F0 = float3(0.04,0.04,0.04); // dielectric, not cosThetaT
    float3 fresnel = FresnelTriAxis(normalTS, viewDirTS, interferenceRGB+F0);
    float3 fresnelRef = 1.0-FresnelReflectanceTriAxis(normalTS, viewDirTS, (1.0-interferenceRGB)+F0);

    // Vivid blend
    float3 blend = saturate(interferenceRGB);
    float3 final =  dot(normalTS, viewDirTS);

    final = pow(abs(final), 1.2); // vivid pop
    output.rt1.xyz = final;
    return output;
}