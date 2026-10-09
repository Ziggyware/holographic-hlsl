#define MAX_NUM_MASSES 64

#define ZERO4 float4(0,0,0,0)
#define ZERO3 float3(0,0,0)
#define ZERO2 float2(0,0)
#define ZERO1 float(0)
#define ONE4 float4(1,1,1,1)
#define ONE3 float3(1,1,1)
#define ONE2 float2(1,1)
#define ONE1 float(1)

// Constants defining the number of layers and maximum parallax layers.
#define MAX_PARALLAX_LAYERS 40
#define EPSILON 1e-9
#define OneMinusEPSILON (1-EPSILON)
#define EPSILON2 float2(EPSILON,EPSILON)
#define EPSILON3 float3(EPSILON,EPSILON,EPSILON)
#define EPSILON4 float4(EPSILON,EPSILON,EPSILON,EPSILON)
#define OneMinusEPSILON2 float2(OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON3 float3(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON4 float4(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
// Epsilon value for floating point comparisons and clamping.

// Macros for finding the maximum and minimum components of a vector.
#define MaxComponent4(v) max(max(max(v.x, v.y), v.z), v.w)
#define MaxComponent3(v) max(max(v.x, v.y), v.z)
#define MaxComponent2(v) max(v.x, v.y)
#define MinComponent4(v) min(min(min(v.x, v.y), v.z), v.w)
#define MinComponent3(v) min(min(v.x, v.y), v.z)
#define MinComponent2(v) min(v.x, v.y)
// Macros for adding the components of a vector.
#define AddComponents4(v) (v.x + v.y + v.z + v.w)
#define AddComponents3(v) (v.x + v.y + v.z)
#define AddComponents2(v) (v.x + v.y)

//count of xyzw above f
#define CountAbove4(f, v4, epsilon) ((v4.x>f+epsilon?1:0)+(v4.y>f+epsilon?1:0)+(v4.z>f+epsilon?1:0)+(v4.w>f+epsilon?1:0))

//count of xyzw below f
#define CountBelow4(f, v4, epsilon) ((v4.x+epsilon<f-epsilon?1:0)+(v4.y+epsilon<f-epsilon?1:0)+(v4.z+epsilon<f-epsilon?1:0)+(v4.w+epsilon<f-epsilon?1:0))
#define MAX_GAUSSIAN_POINTS 2
#define MAX_INTERFERENCE_POINTS MAX_GAUSSIAN_POINTS
// Constants
#define TWO_PI 6.28318530717958647692

// Constants
#define SPEED_OF_LIGHT 299792458.0
#define PI 3.14159265



// Minimum and maximum wavelengths for R, G, B components (in nanometers)
#define RED_MIN_WAVELENGTH 620
#define RED_MAX_WAVELENGTH 750
#define GREEN_MIN_WAVELENGTH 495
#define GREEN_MAX_WAVELENGTH 570
#define BLUE_MIN_WAVELENGTH 450
#define BLUE_MAX_WAVELENGTH 495
#define FLT_MAX 1e+16
#define RED_WAVELENGTH 650
#define GREEN_WAVELENGTH 510
#define BLUE_WAVELENGTH 475
static const float3 MIN_WAVELENGTHS = float3(620, 495, 450);
static const float3 MAX_WAVELENGTHS = float3(750, 570, 495);
static const float3 RGB_WAVELENGTHS_NM = float3(650, 510, 475);
static const float3 RGB_WAVELENGTHS_M = float3(6.5e-7, 5.10e-7, 4.75e-7);
static const float3 RGB_WAVELENGTHS_MM = float3(6.5e-4, 5.10e-4, 4.75e-4);
static const float MAX_WAVELENGTH = 780.0;
static const float MIN_WAVELENGTH = 380.0;
// Number of wavelength samples
static const int NUM_SAMPLES = 471;
static const int SPECTRAL_LOCUS_COUNT = 471; // 380 nm to 780 nm at 5 nm intervals

static const float3 WAVELENGTH_RANGES = (MAX_WAVELENGTHS - MIN_WAVELENGTHS);
static const float WAVELENGTH_RANGE = float(MAX_WAVELENGTH - MIN_WAVELENGTH);
static const float WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE = float(float(SPECTRAL_LOCUS_COUNT) / WAVELENGTH_RANGE);

#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)

#define PassPct ((PassNum + 1) / NumPasses)


#define variation4(v) (MaxComponent4(v) - MinComponent4(v))
#define variation3(v) (MaxComponent3(v) - MinComponent3(v))
#define variation2(v) (MaxComponent2(v) - MinComponent2(v))

#define variation44(dc2, dc6) float4(max(dc2.x, dc6.x) - min(dc2.x, dc6.x), max(dc2.y, dc6.y) - min(dc2.y, dc6.y), max(dc2.z, dc6.z) - min(dc2.z, dc6.z), max(dc2.w, dc6.w) - min(dc2.w, dc6.w))
#define variation33(dc2, dc6) float3(max(dc2.x, dc6.x) - min(dc2.x, dc6.x), max(dc2.y, dc6.y) - min(dc2.y, dc6.y), max(dc2.z, dc6.z) - min(dc2.z, dc6.z))
#define variation22(dc2, dc6) float2(max(dc2.x, dc6.x) - min(dc2.x, dc6.x), max(dc2.y, dc6.y) - min(dc2.y, dc6.y))
#define variation11(dc2, dc6) max(dc2.x, dc6.x) - min(dc2.x, dc6.x)
#define variation21(v) max(v.x, v.y) - min(v.x, v.y)
#define variationSum4(dc2, dc6) AddComponents4(variation44(dc2, dc6))

#define GAMMA_VALUE 2.2

#define SWAY_AMPLITUDE .1
#define SWAY_FREQUENCY 2.0

// Maximum number of light sources
#define MAX_LIGHT_SOURCES 22

#define HOLOGRAM_SIZE_M f10

#define MAX_LAYERS 4

#define MIN_CHROMATICITY float3(0.1741, 0.0050, 1 - (0.1741 + 0.0050))
#define MAX_CHROMATICITY float3(0.0842, 0.0420, 1 - (0.0842 + 0.0420))
#define CHROMATICITY_RANGE (MAX_CHROMATICITY - MIN_CHROMATICITY)

// Mathematical constants.

cbuffer ConstantBuffer : register(b0)
{
    // Mouse position in uv coordinates (0.5, 0.5 is center screen, 0.0, 0.0 is top left)
    float2 LOOK_AT;
    // Change in mouse position since the last frame
    float2 LOOK_AT_DELTA;

    // Number of render passes, default = 3
    // Passes are madd together
    float NumPasses;

    // Total Time since program start, in seconds
    float TotalTime;

    // Scalar for the depth
    float DepthScale;

    // Fresnel Power scalar
    float FresnelPower;

    // Fresnel reflectance scalar
    float FresnelReflectance;

    // Animation speed scalar
    float AnimateSpeed;

    // Shader alpha is set to 1.0 / PassNum.
    float ShaderAlpha;

    // Mix of fresnel effect with diffuse effect, if needed.
    float FresnelMix;

    // 1 when control key is pressed, else 0.
    float KeyControl;

    // 1 when shift key is pressed, else 0.
    float KeyShift;

    // 1 when alt key is pressed, else 0.
    float KeyAlt;

    // 1 when left mouse button is pressed, else 0.
    float LButton;

    // 1 when right mouse button is pressed, else 0.
    float RButton;

    // The current pass number, out of NumPasses total, starts at Zero.
    float PassNum;

    // Specular power (default is 1.0).
    float SpecularPower;

    // Specular intensity (default is 1.0).
    float SpecularIntensity;

    // Radius to sample depthMap or normalMap when creating normals.
    float normalRadius;

    // Height scale for parallax effect.
    float HeightScale;

    // View Z position.
    float ViewZ;

    // Sun Z position.
    float SunZ;

    // Material index for selecting material properties.
    float MaterialIndex;

    // Parallax scale factors. for changing depth based values
    float ParallaxScale;
    
    //for changing values related to (1-depth)
    float ParallaxScaleOMD;
    float Mix3;

// General purpose float parameters (mapped to keyboard buttons f1 to f12).
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
};
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
SamplerState sampleTypeMirror2 : register(s1);
SamplerState sampleTypeMirror : register(s2);

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
MaterialSellmeier CreateMaterialSellmeier(float3 B1, float3 B2, float3 B3, float3 C1, float3 C2, float3 C3, float3 absorptionCoefficient, float roughness, float thicknessM, float nSurrounding, float polarizationAngle, float coherenceLengthM, float temperatureC)
{
    
    MaterialSellmeier material;
    material.B1 = B1;
    material.B2 = B2;
    material.B3 = B3;
    material.C1 = C1;
    material.C2 = C2;
    material.C3 = C3;
    material.absorptionCoefficient = absorptionCoefficient;
    material.roughness = roughness;
    material.thicknessM = thicknessM;
    material.nSurrounding = nSurrounding;
    material.polarizationAngle = polarizationAngle;
    material.coherenceLengthM = coherenceLengthM;
    material.temperatureC = temperatureC;
    return material;
}

// Function to define 5 holographic materials
MaterialSellmeier CreateMaterial(int index)
{
    index = fmod(index, 5);
    MaterialSellmeier ret = { (MaterialSellmeier) 0 };
    
    switch (index)
    {
        // Material 1: Diamond
        case 0:
        {
                ret = CreateMaterialSellmeier
                (float3(0.3306, 4.3356, 0.0), // B1
                    float3(0.0, 0.0, 0.0), // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00417, 0.1060, 0.0), // C1
                    float3(0.0, 0.0, 0.0), // C2
                    float3(0.0, 0.0, 120.0), // C3
                    float3(0.01, 0.01, 0.02), // absorptionCoefficient
                    0.1, // roughness
                    10e-9, // thicknessM
                    1.3, // nSurrounding
                    .05, // polarizationAngle
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
                    0.2, // roughness
                    150e-9, // thicknessM
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
                    float3(0.0, 0.0, 0.0), // B2
                    float3(0.0, 0.0, 0.0), // B3
                    float3(0.00315094, 0.00834422, 17.7932), // C1
                    float3(0.0, 0.0, 0.0), // C2
                    float3(0.0, 0.0, 0.0), // C3
                    float3(0.03, 0.02, 0.01), // absorptionCoefficient
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
                    float3(0.0, 0.0, 0.0), // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00171739, 0.00711506, 0.0), // C1
                    float3(0.0, 0.0, 0.0), // C2
                    float3(0.0, 0.0, 34.6490), // C3
                    float3(0.01, 0.005, 0.005), // absorptionCoefficient
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
                    float3(0.0, 0.0, 0.0), // B2
                    float3(0.0, 0.0, 1.0), // B3
                    float3(0.00130497, 0.00593559, 127.62), // C1
                    float3(0.0, 0.0, 0.0), // C2
                    float3(0.0, 0.0, 0.0), // C3
                    float3(0.04, 0.03, 0.02), // absorptionCoefficient
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
    float3x3 TBN;
    
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




// Convert wavelength from nanometers (nm) to meters (m)
inline float nmToM(float nm)
{
    return nm * 1e-9;
}
inline float2 nmToM(float2 nm)
{
    return nm * 1e-9;
}
inline float3 nmToM(float3 nm)
{
    return nm * 1e-9;
}
// Convert wavelength from meters (m) to nanometers (nm)
inline float mToNm(float m)
{
    return m * 1e+9;
}
inline float3 mToNm(float3 m)
{
    return m * 1e+9;
}
// Convert wavelength from millimeters (mm) to meters (m)
inline float mmToM(float mm)
{
    return mm * 1e-3;
}
inline float3 mmToM(float3 mm)
{
    return mm * 1e-3;
}

// Convert wavelength from meters (m) to millimeters (mm)
inline float mToMm(float m)
{
    return m * 1e3;
}
inline float3 mToMm(float3 m)
{
    return m * 1e3;
}

// Convert wavelength from nanometers (nm) to millimeters (mm)
inline float nmToMm(float nm)
{
    return nm * 1e-6;
}
inline float3 nmToMm(float3 nm)
{
    return nm * 1e-6;
}
// Convert wavelength from millimeters (mm) to nanometers (nm)
inline float mmToNm(float mm)
{
    return mm * 1e6;
}
inline float3 mmToNm(float3 mm)
{
    return mm * 1e6;
}
// Convert wavelength from nanometers (nm) to frequency (Hz)
inline float nmToHz1(float nm)
{
    return 2.99792458e14 / nm; // speed of light in m/s divided by wavelength in m
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
    return range > 0 ? (saturate(range) * WAVELENGTH_RANGE + MIN_WAVELENGTH) : 0;
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
    return 1.23984193e-19 / nm; // energy of photon in J = hc / λ
}

// Calculate the energy of a photon given its wavelength (m)
inline float photonEnergyFromM(float m)
{
    return 1.23984193e-27 / m; // energy of photon in J = hc / λ
}
inline float3 photonEnergyFromM(float3 m)
{
    return 1.23984193e-27 / m; // energy of photon in J = hc / λ
}
// Calculate the energy of a photon given its wavelength (mm)
inline float photonEnergyFromMm(float mm)
{
    return 1.23984193e-24 / mm; // energy of photon in J = hc / λ
}
inline float3 photonEnergyFromMm(float3 mm)
{
    return 1.23984193e-24 / mm; // energy of photon in J = hc / λ
}
// Calculate the wavelength (nm) of a photon given its energy (J)
inline float wavelengthFromEnergy(float energy)
{
    return 1.23984193e-19 / energy; // wavelength in nm = hc / E
}
inline float3 wavelengthFromEnergy(float3 energy)
{
    return 1.23984193e-19 / energy; // wavelength in nm = hc / E
}

// Calculate the period (s) of a wave given its frequency (Hz)
inline float periodFromHz(float hz)
{
    return 1 / hz; // period = 1 / frequency
}
inline float3 periodFromHz(float3 hz)
{
    return 1 / hz; // period = 1 / frequency
}

// Calculate the frequency (Hz) of a wave given its period (s)
inline float hzFromPeriod(float period)
{
    return 1 / period; // frequency = 1 / period
}
inline float3 hzFromPeriod(float3 period)
{
    return 1 / period; // frequency = 1 / period
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
    return 1 / nmToHz1(wavelengthNm); // period = 1 / frequency = 1 / (c / wavelength)
}
float3 periodFromWavelength(float3 wavelengthNm)
{
    return 1 / nmToHz(wavelengthNm); // period = 1 / frequency = 1 / (c / wavelength)
}

// Calculate the angular frequency (rad/s) of a wave given its frequency (Hz)
inline float angularFrequencyFromHz(float hz)
{
    return 2 * 3.14159265 * hz; // angular frequency = 2 * pi * frequency
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
    return angularFrequency / (2.0 * 3.14159265); // frequency = angular frequency / (2 * pi)
}
// Calculate the momentum (kg m/s) of a photon given its energy (J)
inline float momentumFromEnergy(float energy)
{
    return energy / (2.99792458e8); // momentum = energy / c
}
inline float3 momentumFromEnergy(float3 energy)
{
    return energy / (2.99792458e8); // momentum = energy / c
}
// Calculate the energy (J) of a photon given its momentum (kg m/s)
inline float energyFromMomentum(float momentum)
{
    return momentum * (2.99792458e8); // energy = momentum * c
}
inline float3 energyFromMomentum(float3 momentum)
{
    return momentum * (2.99792458e8); // energy = momentum * c
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
    float3 energy = 0;
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
    float3 momentum = 0;
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
    float energy = 0;
    for (int i = 0; i < N; i++)
    {
        energy += 0.5 * massesKg[i] * velocitiesMs[i] * velocitiesMs[i];
    }
    return energy;
}
inline float3 totalSystemEnergy(float3 massesKg[MAX_NUM_MASSES], float3 velocitiesMs[MAX_NUM_MASSES], int N)
{
    float3 energy = 0;
    for (int i = 0; i < N; i++)
    {
        energy += 0.5 * (massesKg[i] * velocitiesMs[i] * velocitiesMs[i]);
    }
    return energy;
}
// Calculate the total momentum (kg m/s) of a system of N particles given their masses (kg) and velocities (m/s)

inline float totalSystemMomentum(float massesKg[MAX_NUM_MASSES], float velocitiesMs[MAX_NUM_MASSES], int N)
{
    float momentum = 0;
    for (int i = 0; i < N; i++)
    {
        momentum += massesKg[i] * velocitiesMs[i];
    }
    return momentum;
}

inline float3 totalSystemMomentum(float3 massesKg[MAX_NUM_MASSES], float3 velocitiesMs[MAX_NUM_MASSES], int N)
{
    float3 momentum = 0;
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
}





// Returns the cosine of the total time multiplied by a given factor, normalize to the range [0, 1].
inline float cosTime01(float timeMul)
{
    return clamp((1.0 + cos(TotalTime * timeMul)) * 0.5, 0.0, 1.0);
}

// Returns the sine of the total time multiplied by a given factor, normalize to the range [0, 1].
inline float sinTime01(float timeMul)
{
    return clamp((1.0 + sin(TotalTime * timeMul)) * 0.5, 0.0, 1.0);
}
// Returns the cosine of the total time multiplied by a given factor, normalize to the range [1, 1].
inline float cosTime11(float timeMul)
{
    return clamp(cosTime01(timeMul) * 2.0 - 1.0, -1.0, 1.0);
}
// Returns the sine of the total time multiplied by a given factor, normalize to the range [0, 1].
inline float sinTime11(float timeMul)
{
    return clamp(sinTime01(timeMul) * 2.0 - 1.0, -1.0, 1.0);
}


inline float4 AdjustGamma(float4 color, float gammaValue = GAMMA_VALUE)
{
    float3 ret = pow(max(EPSILON3, color.rgb), 1.0 / gammaValue);
    return float4(ret, color.w);
}
inline float3 AdjustGamma(float3 color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON3, color), 1.0 / gammaValue);
}
inline float AdjustGamma(float color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON, color), 1.0 / gammaValue);
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
      1.42e-5, 1.21e-5, 1.0e-5, 7.73e-6, 5.4e-6, 3.2e-6, 1.33e-6, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0
}; // Constants

float4 RotateAroundAxis(float4 v, float4 axis, float angle)
{
    // Normalize the axis
    axis = normalize(axis);

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
    // Normalize the axis
    axis = normalize(axis);
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
    float energy = 0;
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
    float momentum = 0;
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
    
    float3 rotatedPos = pos * c + cross(axis, pos) * s + axis * dot(axis, pos) * (1.0 - c);
    return rotatedPos;
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
    float s, c;
    sincos(angle, s, c);
    
    return float2(v.x, c * v.y - s);
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
    float s, c;
    sincos(angle, s, c);
    
    return float2(c * v.x + s, v.y);
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

// Using half precision (16-bit)
float Determinant3x3_half(float3x3 m)
{
    return
        m._11 * (m._22 * m._33 - m._23 * m._32) -
        m._12 * (m._21 * m._33 - m._23 * m._31) +
        m._13 * (m._21 * m._32 - m._22 * m._31);
}

float3x3 InvertMatrix3x3_half(float3x3 m)
{
    float det = Determinant3x3_half(m);
    const float epsilon = 1e-6f;
    
    if (abs(det) < epsilon)
    {
        return float3x3(1.0f, 0.0f, 0.0f,
            0.0f, 1.0f, 0.0f,
            0.0f, 0.0f, 1.0f
        );
    }
    
    float invDet = 1.0f / det;
    
    float3x3 adjugate = float3x3((m._22 * m._33 - m._23 * m._32),
        -(m._12 * m._33 - m._13 * m._32),
        (m._12 * m._23 - m._13 * m._22),
        
        -(m._21 * m._33 - m._23 * m._31),
        (m._11 * m._33 - m._13 * m._31),
        -(m._11 * m._23 - m._13 * m._21),
        
        (m._21 * m._32 - m._22 * m._31),
        -(m._11 * m._32 - m._12 * m._31),
        (m._11 * m._22 - m._12 * m._21)
    );
    
    return adjugate * invDet;
}
inline float Determinant3x3_inline(float3x3 m)
{
    return
        m._11 * (m._22 * m._33 - m._23 * m._32) -
        m._12 * (m._21 * m._33 - m._23 * m._31) +
        m._13 * (m._21 * m._32 - m._22 * m._31);
}

// Function to compute the inverse of a 3x3 matrix
inline float3x3 inverse(float3x3 m)
{
    float det = Determinant3x3_inline(m);
    
    // If determinant is close to zero, return identity matrix or handle as needed
    if (abs(det) < EPSILON)
    {
        // Edge Case Handling:
        // Option 1: Return identity matrix
        return float3x3(1.0f, 0.0f, 0.0f,
            0.0f, 1.0f, 0.0f,
            0.0f, 0.0f, 1.0f
        );
        
        // Option 2: Return zero matrix
        // return float3x3(0.0f, 0.0f, 0.0f,
        //                0.0f, 0.0f, 0.0f,
        //                0.0f, 0.0f, 0.0f);
        
        // Option 3: Return a default inverse or handle error as per application needs
    }
    
    float invDet = 1.0f / det;
    
    // Compute the adjugate matrix (transpose of the cofactor matrix)
    float3x3 adjugate = float3x3( // First row
        (m._22 * m._33 - m._23 * m._32),
        -(m._12 * m._33 - m._13 * m._32),
        (m._12 * m._23 - m._13 * m._22),
        
        // Second row
        -(m._21 * m._33 - m._23 * m._31),
        (m._11 * m._33 - m._13 * m._31),
        -(m._11 * m._23 - m._13 * m._21),
        
        // Third row
        (m._21 * m._32 - m._22 * m._31),
        -(m._11 * m._32 - m._12 * m._31),
        (m._11 * m._22 - m._12 * m._21)
    );
    
    // Multiply adjugate by inverse determinant to get the inverse matrix
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
    float3 rgb = float3(0.0f, 0.0f, 0.0f);
    
    if (hsl.s == 0.0f)
    {
        // Achromatic color (gray)
        rgb = float3(hsl.l, hsl.l, hsl.l);
    }
    else
    {
        float q = (hsl.l < 0.5f) ? (hsl.l * (1.0f + hsl.s)) : (hsl.l + hsl.s - hsl.l * hsl.s);
        float p = 2.0f * hsl.l - q;
        float h = hsl.h / 360.0f; // Normalize hue to [0,1]
        
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
    return mul(color, hueRotation);
}


inline float3 LinearRGBToSRGB(float3 linearRGB)
{
    float3 srgb;
    linearRGB = clamp(linearRGB, EPSILON, 1 - EPSILON);
    srgb.x = max(EPSILON, (linearRGB.x <= 0.0031308) ? (linearRGB.x * 12.92) : (1.055 * pow(max(linearRGB.x, .01), 1.0 / 2.4) - 0.055));
    srgb.y = max(EPSILON, (linearRGB.y <= 0.0031308) ? (linearRGB.y * 12.92) : (1.055 * pow(max(linearRGB.y, .01), 1.0 / 2.4) - 0.055));
    srgb.z = max(EPSILON, (linearRGB.z <= 0.0031308) ? (linearRGB.z * 12.92) : (1.055 * pow(max(linearRGB.z, .01), 1.0 / 2.4) - 0.055));
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


// Color Space Conversion Functions
inline float3 SRGBToLinear(float3 srgb)
{
    return saturate(float3((srgb.r <= 0.04045) ? srgb.r / 12.92 : pow(abs((srgb.r + 0.055) / 1.055), 2.4),
        (srgb.g <= 0.04045) ? srgb.g / 12.92 : pow(abs((srgb.g + 0.055) / 1.055), 2.4),
        (srgb.b <= 0.04045) ? srgb.b / 12.92 : pow(abs((srgb.b + 0.055) / 1.055), 2.4)
    ));
}

const static column_major float3x3 RGBtoXYZ = float3x3(0.4124564, 0.3575761, 0.1804375,
    0.2126729, 0.7151522, 0.0721750,
    0.0193339, 0.1191920, 0.9503041
);
// Compute the inverse matrix M_inv (done outside the shader for performance)
// For illustration, suppose M_inv is calculated as follows:
static const column_major float3x3 XYZ_PRIMARIES_M_inv = inverse(RGBtoXYZ);

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
    index = fmod(index, 4);
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
    index = fmod(index, 4);
    if (index == 0)
        return gratingDepth1;
    else if (index == 1)
        return gratingDepth2;
    else if (index == 2)
        return gratingDepth3;
    else
        return gratingDepth4;
}

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
    return 1.0f / sz;
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float2> tex)
{
    float2 sz = GetSz2(tex);
    return 1.0f / sz;
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float3> tex)
{
    float2 sz = GetSz3(tex);
    return 1.0f / sz;
}
// Retrieves the inverse size of a texture (one over width and height).
inline float2 GetOosz(Texture2D<float4> tex)
{
    float2 sz = GetSz4(tex);
    return 1.0f / sz;
}


float3 FresnelSchlick(float3 F0, float3 VdotH, float power)
{
    return F0 + (1.0 - F0) * pow(1.0 - VdotH, power);
}
// Helper function for noise, if not using a built-in noise function
inline float noiseFast01(float2 v)
{
    // This would be replaced with an actual noise function like Simplex or Perlin noise
    return frac(sin(dot(v, float2(12.9898, 78.233))) * 43758.5453);
}
inline float noiseFast11(float2 v)
{
    return noiseFast01(v) * 2 - 1;

}


inline float sigmoid(float x)
{
    return 1.0 / (1.0 + exp(-x));
}
inline float3 sigmoid(float3 x)
{
    return 1.0 / (1.0 + exp(-x));
}
// Inverse sigmoid, useful for reversing the effect of sigmoid
float invSigmoid(float y)
{
    // Ensure y is within (0, 1) as sigmoid output is in this range
    y = clamp(y, 0.00001, 0.99999);
    return log(y / (1.0 - y));
}
// Remap a value from one range to another using sigmoid for smooth transition
float remapSigmoid(float value, float oldMin, float oldMax, float newMin, float newMax)
{
    // Normalize the value to [0, 1] range
    float normalized = (value - oldMin) / (oldMax - oldMin);
    // Apply sigmoid for smooth transition
    float sigmoidValue = sigmoid(normalized * 10 - 5); // Center at 0.5 with quick transition
    // Map back to the new range
    return newMin + sigmoidValue * (newMax - newMin);
}

// Smooth step function using sigmoid, smoother than traditional smoothstep
float smootherStep(float edge0, float edge1, float x)
{
    // Scale and shift x to fit into a range where sigmoid gives a nice curve
    x = (x - edge0) / (edge1 - edge0);
    return sigmoid(x * 12 - 6); // Adjust 12 and -6 for different steepness
}

// Use sigmoid for creating an ease-in-out effect
float easeInOutSigmoid(float t)
{
    // Here we use a scaled sigmoid to make the transition more pronounced
    return sigmoid((t * 2 - 1) * 5); // Scale to double the range and center, then apply sigmoid
}

// Constrains a value within a range with soft boundaries using sigmoid
float softClamp(float x, float min, float max)
{
    float mid = (min + max) * 0.5;
    float range = max - min;
    // Use sigmoid to create soft edges
    float s = sigmoid((x - mid) * 10 / range); // 10/range adjusts how "soft" the clamp is
    return min + s * range;
}
// Fade from one color to another using sigmoid for smooth transition
float3 sigmoidColorFade(float t, float3 colorStart, float3 colorEnd)
{
    float fadeFactor = smootherStep(0.0, 1.0, t);
    return lerp(colorStart, colorEnd, fadeFactor);
}

// Creates a pulsating effect for light or texture intensity
float pulsatingIntensity(float time, float minIntensity, float maxIntensity, float frequency)
{
    float cycle = sin(time * frequency * PI * 2) * 0.5 + 0.5; // Cycle from 0 to 1
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
        ((-t3 + 2 * t2 - u) * p0 +
         (3 * t3 - 5 * t2 + 2) * p1 +
         (-3 * t3 + 4 * t2 + u) * p2 +
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
    float b = noiseFast01(ip + float2(1, 0));
    float c = noiseFast01(ip + float2(0, 1));
    float d = noiseFast01(ip + float2(1, 1));
    
    float2 u = float2(easeInOutSigmoid(fp.x), easeInOutSigmoid(fp.y));
    
    float x1 = lerp(a, b, u.x);
    float x2 = lerp(c, d, u.x);
    return lerp(x1, x2, u.y) * softness + (1 - softness) * 0.5; // Adjust softness
}

// For creating a fog effect that fades objects into the distance with a sigmoid curve
float sigmoidFog(float distance, float start, float end, float fogDensity)
{
    float normalizedDistance = clamp((distance - start) / (end - start), 0.0, 1.0);
    float fogFactor = 1.0 - smootherStep(0.0, 1.0, normalizedDistance);
    return pow(fogFactor, fogDensity); // Adjust density for different falloff rates
}

// Use sigmoid for camera or object movement with anticipation and follow-through
float3 easeCameraPosition(float t, float3 start, float3 end, float anticipation, float followThrough)
{
    float ease = easeInOutSigmoid(t * (1 + anticipation) - anticipation);
    ease = remapSigmoid(ease, 0.0, 1.0, -followThrough, 1 + followThrough);
    return lerp(start, end, saturate(ease)); // Using saturate to clamp the result
}
float AtmosphericPerspective(float depth, float fog)
{
  // Calculate the distance from the camera to the object
    float distance = length(config.viewPos - float3(config.pixelScaled.xy, depth));

    // Calculate the atmospheric perspective
    float atmosphericPerspective = exp(-distance * fog);

    return atmosphericPerspective;
}
float DepthOfField(float depth, float3 cameraPosition, float focalLength, float aperture)
{
  // Calculate the distance from the camera to the object
    float distance = length(cameraPosition - float3(config.pixelScaled.xy, depth));

  // Calculate the depth of field
    float depthOfField = smoothstep(focalLength - aperture, focalLength + aperture, distance);

    return depthOfField;
}

inline float normalizeRange(float2 range, float value)
{
    return (clamp(value, range.x, range.y) - range.x) / ((range.y - range.x) + EPSILON);
}

inline float2 normalizeRange(float2 range, float2 value)
{
    return float2((clamp(value.x, range.x, range.y) - range.x) / ((range.y - range.x) + EPSILON), (clamp(value.y, range.x, range.y) - range.x) / ((range.y - range.x) + EPSILON));
}
inline float2 gradient(float2 range, float value)
{
    float2 n = normalizeRange(range, value);
    return float2(sigmoid(1.0 - n.x), sigmoid(1.0 - n.y));
}
inline float2 gradient(float2 range, float2 value)
{
    float2 n = normalizeRange(range, value);
    return float2(sigmoid(1.0 - n.x), sigmoid(1.0 - n.y));
}

inline float moilerp(float a, float b, float value)
{
    return lerp(a, b, sigmoid(normalizeRange(float2(a, b), value)));
}

inline float moilerp(float2 ab, float value)
{
    return moilerp(ab.x, ab.y, value);
}

inline float3 moilerp(float3 a, float3 b, float3 value)
{
    float2 r1 = float2(min(a.x, b.x), max(a.x, b.x));
    float2 r2 = float2(min(a.y, b.y), max(a.y, b.y));
    float2 r3 = float2(min(a.z, b.z), max(a.z, b.z));
   
    return float3(moilerp(r1, value.x),
        moilerp(r2, value.y),
        moilerp(r3, value.z));
}
inline float4 moilerp(float4 a, float4 b, float4 value)
{
    float2 r1 = float2(min(a.x, b.x), max(a.x, b.x));
    float2 r2 = float2(min(a.y, b.y), max(a.y, b.y));
    float2 r3 = float2(min(a.z, b.z), max(a.z, b.z));
    float2 r4 = float2(min(a.w, b.w), max(a.w, b.w));
    
    return float4(moilerp(r1, value.x),
        moilerp(r2, value.y),
        moilerp(r3, value.z),
        moilerp(r4, value.w));
}

inline float2 adjustDepthGradientSigmoid(float2 depthGradient, float2 nearFar)
{
    float2 gx = gradient(nearFar, depthGradient.x);
    float2 gy = gradient(nearFar, depthGradient.y);
    
    return float2(moilerp(nearFar, gx.x), moilerp(nearFar, gx.y));

}

static const float2 DepthRange = float2(0.001, 0.999 * DepthScale);

inline float projectDepth(float depth)
{
    return clamp(moilerp(DepthRange, clamp(depth, 0.001, 0.999)), DepthRange.x, DepthRange.y);
}

float3 LightSigmoid(float value, float scalar = 1)
{
    float d = moilerp(EPSILON, OneMinusEPSILON, (max(((value - .5) * SPEED_OF_LIGHT) - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE + .5)) / max(scalar, EPSILON);
    float3 v1 = (float3(d, d, d) - float3(.5, .5, .5)) * float3(SPEED_OF_LIGHT, SPEED_OF_LIGHT, SPEED_OF_LIGHT);
    float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + float3(.5, .5, .5);
    float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(moilerp(min(d, d2), max(d, d2), (OneMinusEPSILON3 - d2) * d)));
}
float3 LightSigmoid(float3 value, float scalar = 1)
{
    float3 d = moilerp(EPSILON3, OneMinusEPSILON3, (max(((value - .5) * SPEED_OF_LIGHT) - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + .5)) / max(scalar, EPSILON3);
    float3 v1 = (d - float3(.5, .5, .5)) * float3(SPEED_OF_LIGHT, SPEED_OF_LIGHT, SPEED_OF_LIGHT);
    float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + float3(.5, .5, .5);
    float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(moilerp(min(d, d2), max(d, d2), (OneMinusEPSILON3 - d2) * d)));
}


// **Depth Raw Function**
// =====================
inline float depthRaw(Texture2D<float> depthMap, float2 uv)
{
    float d = moilerp(EPSILON, OneMinusEPSILON, (max(((max(DepthScale, EPSILON) * depthMap.SampleLevel(sampleTypeMirror, uv, 0) - .5) * SPEED_OF_LIGHT) - MIN_WAVELENGTH, 0) / WAVELENGTH_RANGE + .5) / max(DepthScale, EPSILON));
    float3 d2 = clamp(max(((d - float3(.5, .5, .5)) * SPEED_OF_LIGHT) - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + float3(.5, .5, .5), EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(moilerp(min(d, d2), max(d, d2), (OneMinusEPSILON3 - d2) * d)));
}

// Calculates the gradient of a depth map at a given UV coordinate.
inline float2 GetGradient(Texture2D<float> depthMap, float2 uv)
{
    float2 oosz = GetOosz(depthMap);
    
    float f1 = depthRaw(depthMap, uv);
    float2 v1 = float2(ddx_fine(f1), ddy_fine(f1));
    
    float f2 = depthRaw(depthMap, uv + oosz);
    float2 v2 = float2(ddx_fine(f2), ddy_fine(f2));
    
    return moilerp(float3(v1.xy, f1), float3(v2.xy, f2), .5).xy;
}
inline float3 projectDepth(float3 depth)
{
    return clamp(float3(moilerp(DepthRange, clamp(depth.x * DepthScale, DepthRange.x, DepthRange.y)), moilerp(DepthRange, clamp(depth.y * DepthScale, DepthRange.x, DepthRange.y)), moilerp(DepthRange, clamp(depth.z * DepthScale, DepthRange.x, DepthRange.y))), 0.001, 0.999 * DepthScale);
}
inline float2 projectDepth(float2 depth)
{
    return float2(projectDepth(depth.x), projectDepth(depth.y));
}
inline float4 projectDepth(float4 depth)
{
    return float4(projectDepth(depth.xy), projectDepth(depth.zw));
}


inline float depthRaw(Texture2D<float4> depthNormalMap, float2 uv)
{
    return depthNormalMap.SampleLevel(sampleTypeMirror, uv, 0).w;
}

// **Depth Scaled Function**
// ========================
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
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
}


inline float2 GetGradientRT(Texture2D<float4> depthMap, float2 uv, int axis)
{
    float2 oosz = GetOosz(depthMap);
    
    float f = depthRawRT(depthMap, uv, axis);
    float2 v1 = float2(ddx_fine(f), ddy_fine(f));
    
    f = depthRawRT(depthMap, uv + oosz, axis);
    float2 v2 = float2(ddx_fine(f), ddy_fine(f));
    
    
    return moilerp(float3(v1, 0), float3(v2, 0), .5).xy;
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
    return exp(1 - distance / max(beamWidth, EPSILON));
}
float3 gaussianBeam(float3 distance, float beamWidth)
{
    return exp(1 - distance / max(beamWidth, EPSILON3));
}
float3 gaussianBeam(float3 distance, float2 beamWidth)
{
    return exp(1 - distance / length(max(beamWidth, EPSILON2)));
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

float3 gaussianBeamBasic(float2 uv, float beamWaist = 0.1, float peakIntensity = 1)
{
      // Center the UV coordinates
    float2 centeredUV = uv - float2(0.5, 0.5);
    
    // Calculate distance from beam center
    float distance = length(centeredUV);
    
    // Calculate intensity using Gaussian function
    float intensity = peakIntensity * gaussian(distance, beamWaist);
    
    return float3(intensity, intensity, intensity);
}

float3 gaussianBeamMoving(float2 uv, float time, float beamWaist = 0.1, float peakIntensity = 1.0, float speed = 0.2, float angle = PI / 4.0)
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

float3 gaussianBeamInterference(float2 uv, float time, float2 beam1Pos, float2 beam2Pos, float phaseOffset)
{
    // Normalize UV coordinates to range [-1,1]
    float2 normUV = (uv - float2(0.5, 0.5)) * 2.0;
    
    // Define Gaussian beam parameters
    float beamWaist = 0.2;
    float peakIntensity = 1.0;
    
    // Beam 1: Static Position
    float distance1 = length(normUV - beam1Pos);
    float3 intensity1 = peakIntensity * gaussian3D(float3(uv, distance1), float3(uv, beamWaist));
    
    // Beam 2: Oscillating Position
    float2 oscillation = 10 * float2(cos(time - depthRaw(depthMap, uv) * 0.01), sin(time + depthRaw(depthMap, uv) * 0.01));
    float2 beam2DynamicPos = fmod(beam2Pos, oscillation);
    float distance2 = length(normUV - beam2DynamicPos);
    float intensity2 = peakIntensity * gaussian(distance2, beamWaist);
    
    // Calculate interference based on phase difference
    float phase1 = 0.0; // Phase of Beam 1
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
    
    // Normalize and clamp the final color
    finalColor = saturate(finalColor);
    
    return finalColor;
}

float3 gaussianBeamComplex(float2 uv, float time, float2 beamCenter, float beamWaist, float beamDivergence, float3 phaseModulationFrequency, float polarizationAngle = PI / 2)
{
    // Normalize UV coordinates to range [-1,1]
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
        float2 sampleUV = uv + float2(x, 0) * oosz;
        color += tex.Sample(sampleTypeMirror, sampleUV).rgb * weight;
        totalWeight += weight;
    }
    
    color /= totalWeight;
    totalWeight = 0.0;
    
    // Vertical pass
    float3 finalColor = 0.0;
    for (int y = -radius; y <= radius; y++)
    {
        float weight = gaussian(float(y), sigma);
        float2 sampleUV = uv + float2(0, y) * oosz;
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
    offsets[0] = float2(fRange, 0) * oosz;
    offsets[1] = float2(-fRange, 0) * oosz;
    offsets[2] = float2(0, fRange) * oosz;
    offsets[3] = float2(0, -fRange) * oosz;
}

void CrossLRUDOffsetsMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range, out float2 offsets[4])
{
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
    float fRange = float(range);
    offsets[0] = float2(fRange, 0) * oosz * modulation;
    offsets[1] = float2(-fRange, 0) * oosz * modulation;
    offsets[2] = float2(0, fRange) * oosz * modulation;
    offsets[3] = float2(0, -fRange) * oosz * modulation;
}

void XCrossLRUDOffsets(float2 oosz, int range, out float2 offsets[4])
{
    float fRange = float(range);
    // Calculate normalized offsets (relative to pixel center)
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
    // Calculate normalized offsets (relative to pixel center)
    offsets[0] = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    offsets[1] = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    offsets[2] = float2(fRange - 0.5, fRange - 0.5) * oosz;
    offsets[3] = float2(-fRange + 0.5, fRange - 0.5) * oosz;
}

float4 XCrossLRUDfrawMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range)
{
    float2 gradient = GetGradient(depthMap, uv);
    float2 modulation = GetModulation(gradient);
 
    // Calculate normalized offsets (relative to pixel center)
    float2 offset0 = float2(-range + 0.5, -range + 0.5) * oosz;
    float2 offset1 = float2(range - 0.5, -range + 0.5) * oosz;
    float2 offset2 = float2(range - 0.5, range - 0.5) * oosz;
    float2 offset3 = float2(-range + 0.5, range - 0.5) * oosz;
    
    // Perform four separate texture samples
    float depth0 = depthMap.Sample(sampleTypeMirror, uv + offset0 * modulation);
    float depth1 = depthMap.Sample(sampleTypeMirror, uv + offset1 * modulation);
    float depth2 = depthMap.Sample(sampleTypeMirror, uv + offset2 * modulation);
    float depth3 = depthMap.Sample(sampleTypeMirror, uv + offset3 * modulation);
    
    // Combine the sampled depths into a float4
    float4 gatheredDepths = float4(depth0, depth1, depth2, depth3);
    
    // Return the inverse of the gathered depths
    return float4(1.0, 1.0, 1.0, 1.0) - clamp(gatheredDepths, 0.01, 0.99);
}


float4 XCrossLRUDfraw(float2 oosz, Texture2D<float> depthMap, float2 uv, int range)
{
    float fRange = float(range);
    // Calculate normalized offsets (relative to pixel center)
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
    return projectDepth(ret);

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
            float2 offset0 = float2(i, 0) * oosz;
            float2 offset1 = float2(-i, 0) * oosz;
            float2 offset2 = float2(0, i) * oosz;
            float2 offset3 = float2(0, -i) * oosz;
            
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
 
    float4 ret = float4(0, 0, 0, 0);
    int samples = 0;
    int sampleRate = SampleRateFromRange(range);
    for (int i = -range; i <= range; i += sampleRate)
    {
        if (i == 0)
            continue;
      
        ret += float4(GetModulatedDepth(depthMap, uv, float2(-i, 0)),
            GetModulatedDepth(depthMap, uv, float2(i, 0)),
            GetModulatedDepth(depthMap, uv, float2(0, -i)),
            GetModulatedDepth(depthMap, uv, float2(0, i))
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
    return moilerp(rangeStart, rangeStart + rangeSize, clamp((v - rangeStart) / max(rangeSize, EPSILON), 0, 1));

}


// Generates a normalized 3D noise vector based on input coordinates
// Parameters:
// - noiseMap1, noiseMap2, noiseMap3: Different noise textures for layering noise detail
// - sampler: SamplerState for texture sampling (e.g., linear, point filtering)
// - n: Input coordinates (e.g., position or normal vector in 3D space)
// - scalarUV: Scaling factor for UV components to control horizontal noise frequency
// - scalarZ: Scaling factor for Z component to control depth noise frequency
// - weight1, weight2, weight3: Weights for combining noise layers
float3 noise3(Texture2D<float3> noiseMap,
    float3 n,
    float scalarUV = 1.0,
    float scalarZ = 1.0
)
{
    float2 oosz = GetOosz(noiseMap);

    // Calculate sample coordinates with varying frequency for each noise layer
    float2 sampleCoord1 = (n.xy * scalarUV + n.z * scalarZ) * oosz;
    float2 sampleCoord2 = (n.xy * scalarUV + n.z * scalarZ * scalarZ) * oosz;
    float2 sampleCoord3 = (n.xy * scalarUV + n.z * scalarZ * scalarZ * scalarZ) * oosz;

    // Sample the noise textures at the calculated coordinates
    float3 v = clamp(noiseMap.SampleLevel(sampleTypeLinear, sampleCoord1, 0).xyz, .01, .99);
    
    return normalize(v * 2 - 1);
}

inline float3 noise3_01i1(int2 uv)
{
    return clamp(noiseMap1.Load(int3(uv, 0)), 0, 1);
}
inline float3 noise3_01i2(int2 uv)
{
    return clamp(noiseMap2.Load(int3(uv, 0)), 0, 1);
}
inline float3 noise3_01i3(int2 uv)
{
    return clamp(noiseMap3.Load(int3(uv, 0)), 0, 1);
}
inline float3 noise3_01i4(int2 uv)
{
    return clamp(noiseMap4.Load(int3(uv, 0)), 0, 1);
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
        xyz.y = xyz.y + 1;
    }
    if (xyz.y >= dim.y)
    {
        xyz.x = xyz.x - dim.x;
        xyz.y = xyz.y + 1;
    }
    if (xyz.z >= dim.z)
    {
        xyz.z = xyz.z - dim.z;
        xyz.x = xyz.x + 1;
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
    return clamp(noiseMap1.Load(int3(uv, 0)), 0, 1) * 2.0 - 1.0;
}
float3 noise3_11i2(int2 uv)
{
    return clamp(noiseMap2.Load(int3(uv, 0)), 0, 1) * 2.0 - 1.0;
}
inline float3 noise3_11i3(int2 uv)
{
    return clamp(noiseMap3.Load(int3(uv, 0)), 0, 1) * 2.0 - 1.0;
}
inline float3 noise3_11i4(int2 uv)
{
    return clamp(noiseMap4.Load(int3(uv, 0)), 0, 1) * 2.0 - 1.0;
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

// Gradient function
inline float grad(int hash, float x, float y, float z)
{
    int h = hash & 15; // Convert hash to 4 bits (0-15)
    float u = h < 8 ? x : y;
    float v = h < 4 ? y : ((h == 12 || h == 14) ? x : z);
    return ((h & 1) ? -u : u) + ((h & 2) ? -v : v);
}

// Fade function
inline float fade(float t)
{
    return t * t * t * (t * (t * 6 - 15) + 10);
}

// Linear interpolation
inline float lerpPN(float t, float a, float b)
{
    return a + t * (b - a);
}

// Perlin Noise function
float noisePerlin11(float x, float y, float z)
{
    // Find unit cube that contains point
    int X = int(floor(x)) & 255;
    int Y = int(floor(y)) & 255;
    int Z = int(floor(z)) & 255;

    // Find relative x, y, z of point in cube
    x -= floor(x);
    y -= floor(y);
    z -= floor(z);

    // Compute fade curves for each of x, y, z
    float u = fade(x);
    float v = fade(y);
    float w = fade(z);

    // Hash coordinates of the 8 cube corners
    int A = perm[X] + Y;
    int AA = perm[A] + Z;
    int AB = perm[A + 1] + Z;
    int B = perm[X + 1] + Y;
    int BA = perm[B] + Z;
    int BB = perm[B + 1] + Z;

    // Add blended results from 8 corners of cube
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

    return res; // Normalize to [0,1]
}
inline float noisePerlinAnimated113(float3 xyz)
{
    return noisePerlin11(xyz.x, xyz.y, xyz.z + TotalTime * AnimateSpeed);
}
inline float noisePerlinAnimated112(float2 xy)
{
    return noisePerlin11(xy.x, xy.y, TotalTime * AnimateSpeed);
}
inline float noisePerlin11(float2 xy)
{
    return noisePerlin11(xy.x, xy.y, 0);
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
    return noisePerlin01(xy.x, xy.y, 0);
}
inline float noisePerlin01(float2 xy, float z)
{
    return noisePerlin01(xy.x, xy.y, z);
}
inline float noisePerlinAnimated013(float3 xyz)
{
    return noisePerlin01(xyz.x, xyz.y, xyz.z + TotalTime * AnimateSpeed);
}
inline float noisePerlinAnimated012(float2 xy)
{
    return noisePerlin01(xy.x, xy.y, TotalTime * AnimateSpeed);
}

float noiseFbm11(float x, float y, float z, int octaves, float lacunarity, float gain)
{
    float sum = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;

    for (int i = 0; i < octaves; ++i)
    {
        sum += amplitude * noisePerlin11(x * frequency, y * frequency, z * frequency);
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return sum;
}
float noiseFbm01(float x, float y, float z, int octaves, float lacunarity, float gain)
{
    float sum = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;

    for (int i = 0; i < octaves; ++i)
    {
        sum += amplitude * noisePerlin01(x * frequency, y * frequency, z * frequency);
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return sum;
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


static const int MAX_BOUNCES = 4;



// Adjusts the depth value using a sigmoid function.
inline float adjustDepthSigmoid(float depth, float2 nearFar)
{
    nearFar = float2(min(nearFar.x, nearFar.y), max(nearFar.x, nearFar.y));
    float sigmoidValue = sigmoid(normalizeRange(nearFar, depth));
    return moilerp(nearFar.x, nearFar.y, sigmoidValue);
}

// Converts an HSV color to RGB.
float4 HSVtoRGB(float4 hsv)
{
    float h = hsv.x;
    float s = hsv.y;
    float v = hsv.z;
    if (s == 0.0f)
        return float4(v, v, v, 1.0);

    h /= 60.0f;
    int i = int(floor(h));
    float f = h - float(i);
    float p = v * (1.0f - s);
    float q = v * (1.0f - s * f);
    float t = v * (1.0f - s * (1.0f - f));

    if (i == 0)
        return float4(v, t, p, 1.0);
    if (i == 1)
        return float4(q, v, p, 1.0);
    if (i == 2)
        return float4(p, v, t, 1.0);
    if (i == 3)
        return float4(p, q, v, 1.0);
    if (i == 4)
        return float4(t, p, v, 1.0);

    return float4(v, p, q, 1.0);
}
// Converts an RGB color to HSV.
float3 RGBtoHSV(float3 rgb)
{
    float R = rgb.r;
    float G = rgb.g;
    float B = rgb.b;
    float maxC = max(max(R, max(G, B)), EPSILON);
    float minC = min(R, min(G, B));
    float delta = max(maxC - minC, EPSILON);
    float H = 0;
    if (delta == 0)
    {
        H = 0;
    }
    else if (maxC == R)
    {
        H = 60 * (fmod(((G - B) / delta), 6));
    }
    else if (maxC == G)
    {
        H = 60 * (((B - R) / delta) + 2);
    }
    else if (maxC == B)
    {
        H = 60 * (((R - G) / delta) + 4);
    }

    float S = (maxC == 0) ? 0 : (delta / maxC);
    float V = maxC;

    return float3(H, S, V);
}


// Rotates the hue of an RGB color by a given angle.
inline float4 rotateHue(float4 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB.xyz), 1); // Convert to HSV.
    hsv.x = fmod(hsv.x + angle, 360.0f); // Wrap the hue if it goes out of bounds.
    return HSVtoRGB(hsv); // Convert back to RGB and clamp.
}
// Rotates the hue of an RGB color by a given angle.
inline float3 rotateHue(float3 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB), 1); // Convert to HSV.
    hsv.x = fmod(hsv.x + angle, 360.0f); // Wrap the hue if it goes out of bounds.
    return HSVtoRGB(hsv).rgb; // Convert back to RGB and clamp.
}

float3x3 CalcTBN(Texture2D<float> depthMap, float2 uv, float radius = 1)
{
    float2 oosz = GetOosz(depthMap);
    float2 o1 = float2(0, -1);
    float2 o2 = float2(1, 0);
    // Compute offsets
    float2 offsetUp = o1 * radius * oosz;
    float2 offsetRight = o2 * radius * oosz;
    
     // Sample depths around the current pixel
    float centerDepth = projectedDepth(depthMap, uv);
    float upDepth = projectedDepth(depthMap, uv + offsetUp);
    float rightDepth = projectedDepth(depthMap, uv + offsetRight);
    
    // Calculate positions directly
    float3 centerPos = float3(uv, centerDepth);
    float3 upPos = float3(uv + offsetUp, upDepth);
    float3 rightPos = float3(uv + offsetRight, rightDepth);

    // Compute vectors
    float3 upDir = upPos - centerPos;
    float3 rightDir = rightPos - centerPos;

    // Compute normal with an epsilon for safety
    float3 normal = normalize(cross(rightDir, upDir) + EPSILON);
    
    if (dot(normal, centerPos) > 0.0)
    {
        normal = -normal;
    }
    // Compute tangent and bitangent
    // Note: The order in cross product for tangent might need adjustment based on handedness of your coordinate system
    float3 tangent = normalize(rightDir); // Assuming Y-up, might need to adjust
    float3 bitangent = normalize(upDir);

    // Construct TBN matrix
    return float3x3(tangent, bitangent, normal);
}

float3 CalcNormal(Texture2D<float> depthMap, float2 uv, int radius = 1)
{
    float2 oosz = GetOosz(depthMap); // UV increments per pixel

    // Sample depth at neighboring pixels
    float depthC = projectedDepth(depthMap, uv);
    float depthR = projectedDepth(depthMap, uv + float2(oosz.x * radius, 0.0));
    float depthU = projectedDepth(depthMap, uv + float2(0.0, -oosz.y * radius));

    // Compute depth differences
    float ddx = ddx_fine(depthR - depthC);
    float ddy = ddx_fine(depthU - depthC);
    
    return normalize(float3(-ddx, -ddy, -1));
}

float3 CalcNormal2(Texture2D<float> depthMap, float2 uv, float radius = 1)
{
    return CalcTBN(depthMap, uv, radius)[2];
}


float4 CrossLRUDNdotV(Texture2D<float> depthMap, float2 uv, float range)
{
    range = max(1, range);
    float2 oosz = GetOosz(depthMap);
    float2 modulation = GetModulation(GetGradient(depthMap, uv));
    
    float4 ret = float4(0, 0, 0, 0);
    int samples = 0;

    for (int i = 1; i <= min(max(range, 1), 30); i++)
    {
        if (i == 0)
            continue;
      
        ret += float4(
            dot(CalcNormal(depthMap, uv + oosz * float2(float(-i), 0)), config.viewDir),
            dot(CalcNormal(depthMap, uv + oosz * float2(float(i), 0)), config.viewDir),
            dot(CalcNormal(depthMap, uv + oosz * float2(0, float(-i))), config.viewDir),
            dot(CalcNormal(depthMap, uv + oosz * float2(0, float(i))), config.viewDir)
        );
       
        
        samples++;
    }


    return ret / max(float(samples), EPSILON);
}
float fresnelEquation(float3 reflectedNormal, float3 refractedNormal, float eta)
{
  // Calculate the Fresnel reflection coefficient
    float cosThetaI = clamp(dot(reflectedNormal, refractedNormal), -1, 1);
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = sinThetaI / max(eta, EPSILON);
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    float r = (eta * cosThetaI - cosThetaT) / max((eta * cosThetaI + cosThetaT), EPSILON);
    return r * r;
}


inline float3 _getNormal4(Texture2D<float4> normalMap, float2 uv)
{
   // return GaussianBlur(uv, normalMap, normalRadius);
    float3 ret = normalize(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz);
    return normalize(float3(ret.x, ret.y, ret.z));
   // return normalize(CalcNormal(uv, depthMap));
}
inline float3 _getNormal(Texture2D<float3> normalMap, float2 uv)
{
    return CalcNormal(depthMap, uv);

}

inline float3 normal2Dn4(float2 oosz, Texture2D<float4> normalMap, float2 uv)
{
    return _getNormal4(normalMap, uv);
}
inline float3 normal2Dn(Texture2D<float3> normalMap, float2 uv)
{
    return _getNormal(normalMap, uv);
    
}
inline float3 normal2D4(float2 oosz, Texture2D<float4> normalMap, float2 uv)
{
    return normal2Dn4(oosz, normalMap, uv);
}
inline float3 normal2D(float2 oosz, Texture2D<float3> normalMap, float2 uv)
{
    return normal2Dn(normalMap, uv);
}

inline float3 normal2D4(Texture2D<float4> normalMap, float2 uv)
{
    return normal2Dn4(GetOosz(normalMap), normalMap, uv);
}
inline float3 normal2D(Texture2D<float3> normalMap, float2 uv)
{
    return normal2Dn(normalMap, uv);
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
    ret.viewDir0 = normalize(ret.viewPos0 - ret.pixel0Scaled);
    ret.viewDir = normalize(ret.viewPos - ret.pixelScaled);
  
    // Calculate distance to the view position.
    ret.viewDist = distance(ret.pixelScaled, ret.viewPos);
    
    ret.sunPos = float3(.5, .5, SunZ);
         
// Calculate vector and direction from pixel to the sun.
    ret.pixelToSunSegment = ret.sunPos - ret.pixelScaled;
    ret.pixel0ToSunSegment = ret.sunPos - ret.pixel0Scaled;
    
    ret.pixel0ToSunDir = normalize(ret.pixel0ToSunSegment);
    ret.pixelToSunDir = normalize(ret.pixelToSunSegment);
// Calculate sun half vector.
    ret.sunHalfVec = normalize(ret.pixelToSunDir + ret.viewDir);
    
// Calculate dot products for lighting calculations.
    ret.HdotV = clamp(dot(ret.sunHalfVec, ret.viewDir), 0, 1);
    ret.VdotL = clamp(dot(ret.pixelToSunDir, ret.viewDir), 0, 1);
    ret.HdotN = clamp(dot(ret.sunHalfVec, ret.normal), 0, 1);
    ret.NdotV = clamp(dot(ret.normal, ret.viewDir), 0, 1);
    ret.NdotL = clamp(dot(ret.pixelToSunDir, ret.normal), 0, 1);
    ret.HdotL = clamp(dot(ret.sunHalfVec, ret.pixelToSunDir), 0, 1);
    
    
    ret.diffuse = mir2D(diffuseMap, ret.uv0);
    ret.reflectDir = normalize(-reflect(-ret.viewDir, ret.normal));
    
    ret.HdotR = clamp(dot(ret.sunHalfVec, ret.reflectDir), 0, 1);
    ret.RdotL = clamp(dot(ret.pixelToSunDir, ret.reflectDir), 0, 1);
    ret.NdotR = clamp(dot(ret.normal, ret.reflectDir), 0, 1);
    
    
    ret.normal = CalcNormal(depthMap, ret.uv, normalRadius);
    ret.tangent = normalize(float3(1, 0, 0) - dot(float3(1, 0, 0), ret.normal) * ret.normal);
    ret.bitangent = normalize(cross(ret.normal, ret.tangent));
    ret.TBN = float3x3(ret.tangent, ret.bitangent, ret.normal);
    
    
    ret.reflectDirTS = normalize(mul(ret.TBN, ret.reflectDir));
    ret.normalTS = normalize(mul(ret.TBN, ret.normal));
    
    ret.lightDirTS = normalize(mul(ret.TBN, ret.pixelToSunDir));
    ret.viewDirTS = normalize(mul(ret.TBN, ret.viewDir));
    ret.halfDirTS = normalize(mul(ret.TBN, ret.sunHalfVec));

    
    ret.NdotV_TS = max(dot(ret.normalTS, ret.viewDirTS), 0.0);
    ret.NdotL_TS = max(dot(ret.TBN[2], ret.lightDirTS), 0.0);
    ret.HdotN_TS = max(dot(ret.TBN[2], ret.halfDirTS), 0.0);
    ret.HdotV_TS = max(dot(ret.halfDirTS, ret.viewDirTS), 0.0);
    ret.NdotR_TS = max(dot(ret.TBN[2], ret.reflectDirTS), 0.0);
    
    ret.TdotV_TS = max(dot(ret.TBN[0], ret.viewDirTS), 0.0);
    ret.TdotL_TS = max(dot(ret.TBN[0], ret.lightDirTS), 0.0);
    ret.TdotN_TS = max(dot(ret.TBN[0], ret.halfDirTS), 0.0);
    ret.TdotR_TS = max(dot(ret.TBN[0], ret.reflectDirTS), 0.0);
    
    ret.BdotV_TS = max(dot(ret.TBN[1], ret.viewDirTS), 0.0);
    ret.BdotL_TS = max(dot(ret.TBN[1], ret.lightDirTS), 0.0);
    ret.BdotN_TS = max(dot(ret.TBN[1], ret.halfDirTS), 0.0);
    ret.BdotR_TS = max(dot(ret.TBN[1], ret.reflectDirTS), 0.0);
    
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
    ret.viewDir = normalize(ret.viewPos - ret.pixelScaled);
   
    
    ret.gradient = GetGradient(depthMap, ret.uv);
    ret.modulation = GetModulation(ret.gradient);
    ret.normal = CalcNormal(depthMap, ret.uv);
    
    ret.viewDist = distance(ret.pixelScaled, ret.viewPos);

    ret.sunPos = float3(.5, .5, SunZ);

    // Calculate vector and direction from pixel to the sun.
    ret.pixelToSunSegment = ret.sunPos - ret.pixelScaled;
    ret.pixelToSunDir = normalize(ret.pixelToSunSegment);

// Calculate sun half vector.
    ret.sunHalfVec = normalize(ret.pixelToSunDir + ret.viewDir);

    // Calculate dot products for lighting calculations.
    ret.HdotV = clamp(dot(ret.sunHalfVec, ret.viewDir), 0, 1);
    ret.VdotL = clamp(dot(ret.pixelToSunDir, ret.viewDir), 0, 1);
    ret.HdotN = clamp(dot(ret.sunHalfVec, ret.normal), 0, 1);
    ret.HdotL = clamp(dot(ret.sunHalfVec, ret.pixelToSunDir), 0, 1);
    ret.NdotV = clamp(dot(ret.normal, ret.viewDir), 0, 1);
    ret.NdotL = clamp(dot(ret.pixelToSunDir, ret.normal), 0, 1);
                                
    ret.reflectDir = normalize(reflect(-ret.viewDir, ret.normal));
                                
    ret.HdotR = clamp(dot(ret.sunHalfVec, ret.reflectDir), 0, 1);
    ret.RdotL = clamp(dot(ret.pixelToSunDir, ret.reflectDir), 0, 1);
    ret.NdotR = clamp(dot(ret.normal, ret.reflectDir), 0, 1);
    
    ret.reflectDirTS = normalize(mul(ret.TBN, ret.reflectDir));
    ret.normalTS = normalize(mul(ret.TBN, ret.normal));
    ret.lightDirTS = normalize(mul(ret.TBN, ret.pixelToSunDir));
    ret.viewDirTS = normalize(mul(ret.TBN, ret.viewDir));
    ret.halfDirTS = normalize(mul(ret.TBN, ret.sunHalfVec));
    
    ret.NdotV_TS = max(dot(ret.normalTS, ret.viewDirTS), 0.0);
    ret.NdotL_TS = max(dot(ret.TBN[2], ret.lightDirTS), 0.0);
    ret.HdotN_TS = max(dot(ret.TBN[2], ret.halfDirTS), 0.0);
    ret.HdotV_TS = max(dot(ret.halfDirTS, ret.viewDirTS), 0.0);
    ret.NdotR_TS = max(dot(ret.TBN[2], ret.reflectDirTS), 0.0);
                          
    ret.TdotV_TS = max(dot(ret.TBN[0], ret.viewDirTS), 0.0);
    ret.TdotL_TS = max(dot(ret.TBN[0], ret.lightDirTS), 0.0);
    ret.TdotN_TS = max(dot(ret.TBN[0], ret.halfDirTS), 0.0);
    ret.TdotR_TS = max(dot(ret.TBN[0], ret.reflectDirTS), 0.0);
                          
    ret.BdotV_TS = max(dot(ret.TBN[1], ret.viewDirTS), 0.0);
    ret.BdotL_TS = max(dot(ret.TBN[1], ret.lightDirTS), 0.0);
    ret.BdotN_TS = max(dot(ret.TBN[1], ret.halfDirTS), 0.0);
    ret.BdotR_TS = max(dot(ret.TBN[1], ret.reflectDirTS), 0.0);
    
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
    return frac(phase / TWO_PI) * TWO_PI;
}



float3 XYZToWavelength(float3 xyz)
{
    float3 rgb = XYZToLinearRGB(xyz);
   
    HSL hsl = RGBToHSL(rgb);
    
    hsl = AdjustHSL(hsl, 10, 2, 1.6);
    rgb = HSLToRGB(hsl);
   
    xyz = mul(RGBtoXYZ, rgb);
    
    // Perform the XYZ to Wavelengths (Red, Green, Blue) conversion
    float3 wavelengths = mul(xyz.xyz, transpose(XYZ_PRIMARIES_M_inv));

    // Clamp the wavelength intensities to [0, 1] to ensure valid output
    wavelengths = saturate(wavelengths);
    float3 oo = float3(wavelengths.x > 0 ? 1 : 0, wavelengths.y > 0 ? 1 : 0, wavelengths.z > 0 ? 1 : 0);
    return (wavelengths * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
}

inline float3 GetChromaticity(int index)
{
    return moilerp(MIN_CHROMATICITY, MAX_CHROMATICITY, MIN_CHROMATICITY + CHROMATICITY_RANGE * (1 + index) / SPECTRAL_LOCUS_COUNT);
    //float2(0.1741, 0.0050)//float2(0.0842, 0.0420), // 830nm
}



inline float addOver02(float2 v)
{
    int cnt = 0;
    float sum = 0;
    if (v.x > 0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0)
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
    float sum = 0;
    if (v.x > 0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0)
    {
        cnt++;
        sum += v.y;
    }
    if (v.z > 0)
    {
        cnt++;
        sum += v.z;
    }
    if (cnt > 0)
        return sum / max(float(cnt), EPSILON);
    return 0;
}

inline float addOver04(float4 v)
{
    int cnt = 0;
    float sum = 0;
    if (v.x > 0)
    {
        cnt++;
        sum += v.x;
    }
    if (v.y > 0)
    {
        cnt++;
        sum += v.y;
    }
    if (v.z > 0)
    {
        cnt++;
        sum += v.z;
    }
    if (v.w > 0)
    {
        cnt++;
        sum += v.w;
    }
    return cnt > 0 ? sum / max(float(cnt), EPSILON) : 0;
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
        float distance = d.x * chroma.x + d.y * chroma.y + (1 - d.x + d.y) * (1 - chroma.x + chroma.y) * (1 - d.x + d.y) * (1 - chroma.x + chroma.y);
        if (distance < minDistance)
        {
            minDistance = distance;
            bestWavelength = 380 + i;
        }
    }
    return bestWavelength;
}

float3 ChromaticityToWavelengthNM(float2 chroma)
{
    
    float dominantWavelength = ComputeDominantWavelength(chroma);
    
    bool xyDom = (chroma.x + chroma.y) >= .5;
    float chromaZ = (1 - saturate(chroma.x + chroma.y));
    bool xzDom = (chroma.x + chromaZ) >= .5;
    bool yzDom = (chroma.y + chromaZ) >= .5;
    
    float3 wavelengthsNM = float3(0.0, 0.0, 0.0);
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
        ret.x > 0 ? ret.x + MIN_WAVELENGTHS.x : 0,
        ret.y > 0 ? ret.y + MIN_WAVELENGTHS.y : 0,
        ret.z > 0 ? ret.z + MIN_WAVELENGTHS.z : 0);

    return ret;
}

float3 clampWavelengthsNM(float3 wavelengthsNM)
{
    return float3(
        wavelengthsNM.x > 0 ? clamp(wavelengthsNM.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x) : 0,
        wavelengthsNM.y > 0 ? clamp(wavelengthsNM.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y) : 0,
        wavelengthsNM.z > 0 ? clamp(wavelengthsNM.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z) : 0);

}

inline float3 WavelengthWeight(float3 wavelength)
{
    // This weighting function can be improved further based on empirical data
    // or specific requirements for military-grade applications.
    // Example: More precise weighting for human visibility sensitivity.
    //if (wavelength >= 380.0 && wavelength <= 780.0)
    {
        // Gaussian-like weighting for visible spectrum
        float3 mean = dot(wavelength, wavelength) / 2;
        float stddev = 60.0;
        return exp(-pow(max(wavelength - mean, EPSILON3), 2) / max((2.0 * pow(max(stddev, EPSILON), 2)), EPSILON));
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
    // Convert sRGB to linear RGB
    float3 linearRGB = SRGBToLinear(srgb);
    float3 oo = float3(srgb.x > 0 ? 1 : 0, srgb.y > 0 ? 1 : 0, srgb.z > 0 ? 1 : 0);

    return (linearRGB * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
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


inline float3 LinearRGBToSRGB2(float3 linearRGB)
{
    linearRGB = clamp(linearRGB, EPSILON, 1 - EPSILON);
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
    // Step 4: Normalize and clamp to avoid negative artifacts
    linearRGB = max(linearRGB, 0.0);
    
    // Step 5: Apply gamma correction to convert to sRGB
    float3 srgb = LinearRGBToSRGB(linearRGB);
    // Step 6: Clamp final RGB values to [0, 1]
    srgb = saturate(srgb);
    
    return srgb;*/
}

float3 XYZToLinearRGB(float3 XYZ0, float3 XYZ1, float3 XYZ2)
{
     // Use XYZ to RGB conversion matrix
    int3 cnt = 0;
    float3 RGB = float3(0, 0, 0);
    float3 l1 = XYZToLinearRGB(XYZ0);
    float3 l2 = XYZToLinearRGB(XYZ1);
    float3 l3 = XYZToLinearRGB(XYZ2);
   
    return AddOver0(l1, l2, l3);
}

float3 WavelengthsToRGB3(float3 wavelength)
{
    // Assuming chromaticity to RGB transformation is defined for white light
    float3 RGB = float3(0.0, 0.0, 0.0);

    wavelength.x = wavelength.x >= MIN_WAVELENGTHS.x ? clamp(wavelength.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x) : 0;
    wavelength.y = wavelength.y >= MIN_WAVELENGTHS.y ? clamp(wavelength.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y) : 0;
    wavelength.z = wavelength.z >= MIN_WAVELENGTHS.z ? clamp(wavelength.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z) : 0;
    
    float3 wl1 = wavelength.x >= MIN_WAVELENGTHS.x ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.x - MIN_WAVELENGTHS.x)).xy) : 0;
    float3 wl2 = wavelength.y >= MIN_WAVELENGTHS.y ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.y - MIN_WAVELENGTHS.y)).xy) : 0;
    float3 wl3 = wavelength.z >= MIN_WAVELENGTHS.z ? ChromaticityToWavelengthNM(GetChromaticity(int(wavelength.z - MIN_WAVELENGTHS.z)).xy) : 0;
    
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
    float3 RGB = float3(0.0, 0.0, 0.0);
    
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
float ComputeLightTravelTimeM(float distanceM)
{
    // Time = Distance / Speed of Light
    return distanceM / SPEED_OF_LIGHT;
}

float3 ComputeLightTravelTimeM(float3 distanceM)
{
    // Time = Distance / Speed of Light
    return distanceM / SPEED_OF_LIGHT;
}

// Adjust the intensity of light based on travel time (simulating medium attenuation)
float AdjustIntensityByTravelTime(float intensity, float travelTimeS, float absorptionCoeff)
{
    // Apply exponential attenuation: I = I0 * e^(-alpha * d)
    // Here, alpha is the absorption coefficient (1/m)
    float attenuation = exp(-absorptionCoeff * SPEED_OF_LIGHT * travelTimeS);
    return intensity * attenuation;
}



// Simulate light propagation considering the speed of light
float3 SimulateLightPropagation(float3 sourceColor, float distanceM, float absorptionCoeff = 0.0)
{
    // Compute the travel time
    float travelTimeS = ComputeLightTravelTimeM(distanceM);
    
    // Adjust intensity based on travel time and absorption
    float adjustedIntensity = AdjustIntensityByTravelTime(1.0, travelTimeS, absorptionCoeff);
    
    // Apply adjusted intensity to the source color
    float3 adjustedColor = sourceColor * adjustedIntensity;
    
    return adjustedColor;
}

inline float3 SellmeierEquation_NM(float3 wavelengthsNM, MaterialSellmeier material)
{
    wavelengthsNM = max(EPSILON3, wavelengthsNM);
    float3 nSquared = ONE3 + (material.B1 * pow(max(wavelengthsNM, EPSILON3), 2)) / max(pow(max(wavelengthsNM, EPSILON3), 2) - material.C1, EPSILON3) + (material.B2 * pow(max(wavelengthsNM, EPSILON3), 2)) / max(pow(max(wavelengthsNM, EPSILON3), 2) - material.C2, EPSILON3) +
    (material.B3 * pow(max(wavelengthsNM, EPSILON3), 2)) / max(pow(max(wavelengthsNM, EPSILON3), 2) - material.C3, EPSILON3);
    return sqrt(nSquared);
}

// Sellmeier Equation for Dispersion
float3 SellmeierEquation(float3 wavelengthsM, float3 B1, float3 B2, float3 B3, float3 C1, float3 C2, float3 C3)
{
    // Calculate lambda squared
    float3 lambdaSq = pow(max(wavelengthsM, EPSILON3), 2.0);

    // Prevent division by zero by adding a small epsilon where necessary
    float3 denominator1 = lambdaSq - C1 + EPSILON3;
    float3 denominator2 = lambdaSq - C2 + EPSILON3;
    float3 denominator3 = lambdaSq - C3 + EPSILON3;

    // Sellmeier equation: n^2 = 1 + (B1 * lambda^2) / (lambda^2 - C1) + ...
    float3 nSquared = 1.0 +
                      (B1 * lambdaSq) / max(denominator1, EPSILON3) +
                      (B2 * lambdaSq) / max(denominator2, EPSILON3) +
                      (B3 * lambdaSq) / max(denominator3, EPSILON3);

    // Return the refractive index
    return sqrt(nSquared);
}

float3 SellmeierEquation(float3 wavelengthsM, MaterialSellmeier material)
{
    // Prevent division by zero by adding a small epsilon where necessary
    float3 lambdaSq = pow(max(wavelengthsM, EPSILON3), 2);
    float3 nSquared = 1.0 +
                      (material.B1 * lambdaSq) / max(lambdaSq - material.C1, EPSILON3) +
                      (material.B2 * lambdaSq) / max(lambdaSq - material.C2, EPSILON3) +
                      (material.B3 * lambdaSq) / max(lambdaSq - material.C3, EPSILON3);
    return sqrt(nSquared);
}
// Helper to calculate the Euclidean distance light travels between two points
float CalculateLightDistance(float3 startPos, float3 endPos)
{
    return length(endPos - startPos);
}

// Helper to compute optical path length inside a medium based on refractive index and distance traveled
float ComputeOpticalPathLength(float distance, float refractiveIndex)
{
    return distance * refractiveIndex;
}

// Helper to calculate phase shift due to optical path difference
float3 CalculatePhaseShiftOptical(float3 opticalPathLength, float3 wavelengths)
{
    return (2.0 * PI * opticalPathLength) / max(wavelengths, EPSILON3);
}

// Helper to compute the angle of incidence given the surface normal and view direction
float CalculateIncidenceAngle(float3 normal, float3 viewDir)
{
    viewDir = normalize(viewDir);
    normal = normalize(normal);
    return acos(dot(normal, viewDir));
}

// Helper to apply Snell's Law and calculate the transmitted angle
float3 CalculateTransmittedAngle(float3 normal, float3 viewDir, float3 nIncident, float3 nTransmitted)
{
    float cosThetaI = dot(normal, viewDir);
    float sinThetaI = sqrt(1.0 - pow(max(cosThetaI, EPSILON), 2.0));
    return asin((nIncident / max(nTransmitted, EPSILON3)) * sinThetaI);
}

// Helper to calculate the Fresnel reflectance (using the Schlick approximation)
float3 CalculateFresnelReflectance(float cosThetaI, float3 nIncident, float3 nTransmitted)
{
    float3 R0 = pow(max((nIncident - nTransmitted) / max(nIncident + nTransmitted, EPSILON3), EPSILON3), FresnelReflectance);
    return R0 + (1.0 - R0) * pow(max(1.0 - cosThetaI, EPSILON3), FresnelPower);
}

// Helper to compute total internal reflection condition
bool IsTotalInternalReflection(float3 nIncident, float3 nTransmitted, float cosThetaI)
{
    float3 sinThetaT2 = (nIncident / max(nTransmitted, EPSILON3)) * sqrt(1.0 - pow(max(cosThetaI, EPSILON), 2.0));
    return dot(sinThetaT2, sinThetaT2) > 1.0;
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

// Helper to measure the coherence length of light in a medium, determining when interference fades
float3 CalculateCoherenceFactor(float3 opticalPathLength, float3 coherenceLength)
{
    return exp(-pow(max(opticalPathLength, EPSILON3), 2.0) / pow(max(coherenceLength, EPSILON3), 2.0));
}

// Helper to calculate the Doppler shift effect due to relative motion between source and observer
float3 CalculateDopplerShift(float3 sourceVelocity, float3 observerVelocity, float3 wavelength)
{
    float3 relativeVelocity = observerVelocity - sourceVelocity;
    return wavelength * (1.0 + dot(relativeVelocity, normalize(wavelength)));
}

// Helper to compute polarization effects on light intensity given an angle
float3 CalculatePolarizationEffect(float polarizationAngle, float3 R12, float3 R23)
{
    return 1.0 + cos(2.0 * polarizationAngle) * (R12 - R23);
}

// Helper to compute the absorption of light based on medium properties and thickness
float3 CalculateLightAbsorption(float thickness, float3 absorptionCoefficient)
{
    return exp(-absorptionCoefficient * thickness);
}

// Helper to calculate the total interference color, including all light properties and effects
float3 CalculateInterferenceColor(float thickness,
    float3 normal,
    float3 viewPos,
    float3 lightPos,
    float3 viewDir,
    float3 wavelengths,
    float3 nIncident,
    float nFilm,
    float initialIntensity,
    float attenuationCoefficient,
    float3 coherenceLength,
    float polarizationAngle
)
{
    // Normalize vectors
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    
    // Calculate light distance and attenuation
    float lightDistance = CalculateLightDistance(viewPos, lightPos);
    float lightAttenuation = CalculateLightAttenuation(lightDistance, attenuationCoefficient);
    
    // Angle of incidence and Snell's Law
    float cosThetaI = dot(normal, viewDir);
    float3 sinThetaT = (nIncident / max(nFilm, EPSILON)) * sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    if (IsTotalInternalReflection(nIncident, nFilm, cosThetaI))
    {
        return float3(0.0, 0.0, 0.0); // Total internal reflection, no transmission
    }
    float cosThetaT = sqrt(1.0 - dot(sinThetaT, sinThetaT));
    
    // Optical path length and phase shift
    float3 deltaM = ComputeOpticalPathLength(thickness, nFilm);
    float3 phase = CalculatePhaseShiftOptical(deltaM, wavelengths);
    
    // Fresnel reflectance at interfaces
    float3 R12 = CalculateFresnelReflectance(cosThetaI, nIncident, nFilm);
    float3 R23 = CalculateFresnelReflectance(cosThetaT, nFilm, nIncident);
    
    // Coherence factor and polarization effect
    float3 coherenceFactor = CalculateCoherenceFactor(deltaM, coherenceLength);
    float3 polarizationEffect = CalculatePolarizationEffect(polarizationAngle, R12, R23);
    
    // Total reflectance with interference, coherence, and polarization
    float3 reflectance = (R12 + R23 + 2.0 * sqrt(R12 * R23) * cos(phase)) * coherenceFactor * polarizationEffect;
    
    // Final light intensity based on distance, attenuation, and initial intensity
    reflectance *= CalculateLightIntensity(initialIntensity, lightDistance) * lightAttenuation;
    
    return reflectance;
}


float3 CalculateFresnelReflectance(float3 n1, float3 n2, float3 cosThetaI, out float3 cosThetaT)
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


float4 Fresnel4(float4 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float fresnelReflectance, float3 refractiveIndices = float3(1.5, 1.5, 1.5), float dispersionCoefficient = 0.005)
{
    // Normalize vectors
    float3 N = normalize(normal);
    float3 V = normalize(viewDir);

    float NdotV = max(dot(N, V), EPSILON);
    float3 cosThetaI = float3(NdotV, NdotV, NdotV);
    
    
    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    
    // Refractive indices for the material (example values)
    float3 A = refractiveIndices; // Base refractive index
    float B = dispersionCoefficient; // Dispersion coefficient

    float3 sum = float3(0.0, 0.0, 0.0);

    // Calculate refractive indices for each wavelength
    float3 n1 = float3(1.0, 1.0, 1.0);
    float3 n2 = RefractiveIndexMM(mToMm(wavelengthsM), A, B);

    float3 cosThetaT;
    // Fresnel reflectance for this wavelength
    float3 R = CalculateFresnelReflectance(n1, n2, cosThetaI, cosThetaT);

    // Thin-film interference
    float3 interference = ThinFilmInterference(wavelengthsM, filmThicknessM, clamp(n2, 1, 2), clamp(cosThetaT, EPSILON3, OneMinusEPSILON3));

    // Adjust reflectance with interference
    float3 reflectance = clamp(R, EPSILON3, OneMinusEPSILON3) + clamp(interference, EPSILON3, OneMinusEPSILON3) * fresnelPower;

    reflectance = fresnelReflectance + reflectance * (1.0 - fresnelReflectance);
        
    // Clamp reflectance between 0 and 1
    reflectance = clamp(reflectance, EPSILON3, OneMinusEPSILON3);

    // Apply base color and accumulate
    sum = reflectance * baseColor.rgb;
   
    return float4(sum, 1);
}

float3 Fresnel3(float3 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float fresnelReflectance, float3 baseRefractiveIndices = { 1.5, 1.5, 1.5 }, float dispersionCoefficient = 0.005)
{
    // Normalize vectors
    float3 N = normalize(normal);
    float3 V = normalize(viewDir);

    // Cosine of the angle of incidence
    float cosThetaI = max(dot(N, V), EPSILON);

    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    
    // Refractive indices for the material (example values)
    
    float B = dispersionCoefficient; // Dispersion coefficient

    float3 sum = float3(0.0, 0.0, 0.0);

    float3 A = baseRefractiveIndices; // Base refractive index
    // Calculate refractive indices for each wavelength
    float3 n1 = float3(1.0, 1.0, 1.0);
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

// High-order function to simulate the caustic patterns generated by a glass surface with diffraction gratings
float3 SimulateCausticPattern(float3 lightPos, float3 viewPos, float3 surfaceNormal, float3 wavelengths, float3 nIncident, float gratingSpacing, int diffractionOrder)
{
    // Normalize vectors
    surfaceNormal = normalize(surfaceNormal);
    float3 lightDir = normalize(lightPos - viewPos);

    // Calculate the incident angle (angle between light and surface normal)
    float incidentAngle = acos(dot(surfaceNormal, lightDir));

    // Calculate diffraction angles for R, G, B wavelengths
    float3 diffractionAngles;
    diffractionAngles.r = CalculateDiffractionAngle(wavelengths.r, incidentAngle, gratingSpacing, diffractionOrder);
    diffractionAngles.g = CalculateDiffractionAngle(wavelengths.g, incidentAngle, gratingSpacing, diffractionOrder);
    diffractionAngles.b = CalculateDiffractionAngle(wavelengths.b, incidentAngle, gratingSpacing, diffractionOrder);

    // Reflectance at first interface
    float3 R12 = CalculateFresnelReflectance(incidentAngle, nIncident, float3(1.0, 1.0, 1.0));

    // Combine diffraction and reflection to produce caustic effect
    float3 causticPattern;
    causticPattern.r = sin(diffractionAngles.r) * R12.r;
    causticPattern.g = sin(diffractionAngles.g) * R12.g;
    causticPattern.b = sin(diffractionAngles.b) * R12.b;

    return causticPattern;
}

// Helper to calculate diffraction grating phase shift for interference effects
float3 CalculateDiffractionGratingPhaseShift(float3 wavelengths, float incidentAngle, float3 diffractionAngles, float gratingSpacing)
{
    float3 opticalPathDiff = gratingSpacing * (sin(incidentAngle) - sin(diffractionAngles));
    return (2.0 * PI * opticalPathDiff) / max(wavelengths, EPSILON3);
}

// High-order function to simulate oily glass diffraction patterns with caustics and interference
float3 SimulateOilyGlassDiffraction(float3 lightPos,
    float3 viewPos,
    float3 surfaceNormal,
    float3 wavelengths,
    float3 nIncident,
    float nFilm,
    float gratingSpacing,
    float grooveDepth,
    int diffractionOrder,
    float absorptionCoefficient,
    float thickness
)
{
    // Normalize vectors
    surfaceNormal = normalize(surfaceNormal);
    float3 lightDir = normalize(lightPos - viewPos);

    // Incident angle between light and surface normal
    float incidentAngle = acos(dot(surfaceNormal, lightDir));

    // Calculate diffraction angles for R, G, B wavelengths
    float3 diffractionAngles;
    diffractionAngles.r = CalculateDiffractionAngle(wavelengths.r, incidentAngle, gratingSpacing, diffractionOrder);
    diffractionAngles.g = CalculateDiffractionAngle(wavelengths.g, incidentAngle, gratingSpacing, diffractionOrder);
    diffractionAngles.b = CalculateDiffractionAngle(wavelengths.b, incidentAngle, gratingSpacing, diffractionOrder);

    // Calculate phase shift for each wavelength due to diffraction grating
    float3 phaseShift = CalculateDiffractionGratingPhaseShift(wavelengths, incidentAngle, diffractionAngles, gratingSpacing);

    // Calculate Fresnel reflectance at the glass surface
    float3 reflectance = CalculateFresnelReflectance(incidentAngle, nIncident, float3(nFilm, nFilm, nFilm));

    // Apply diffraction grating efficiency
    float3 gratingEfficiency;
    gratingEfficiency.r = CalculateGratingEfficiency(wavelengths.r, incidentAngle, diffractionAngles.r, grooveDepth, nFilm);
    gratingEfficiency.g = CalculateGratingEfficiency(wavelengths.g, incidentAngle, diffractionAngles.g, grooveDepth, nFilm);
    gratingEfficiency.b = CalculateGratingEfficiency(wavelengths.b, incidentAngle, diffractionAngles.b, grooveDepth, nFilm);

    // Simulate light attenuation as it passes through the oily glass
    float attenuation = CalculateLightAttenuation(thickness, absorptionCoefficient);

    // Calculate final interference-based diffraction pattern with caustic effects
    float3 diffractionPattern;
    diffractionPattern.r = gratingEfficiency.r * reflectance.r * cos(phaseShift.r) * attenuation;
    diffractionPattern.g = gratingEfficiency.g * reflectance.g * cos(phaseShift.g) * attenuation;
    diffractionPattern.b = gratingEfficiency.b * reflectance.b * cos(phaseShift.b) * attenuation;

    return diffractionPattern;
}

// Higher-order function to handle multiple caustic layers and interactions between them
float3 SimulateMultiLayerCaustics(float3 lightPos,
    float3 viewPos,
    float3 surfaceNormal,
    float3 wavelengths,
    float3 nIncident,
    float nFilmLayers[MAX_LAYERS],
    float gratingSpacing[MAX_LAYERS],
    float grooveDepth[MAX_LAYERS],
    int diffractionOrder[MAX_LAYERS],
    float absorptionCoefficient[MAX_LAYERS],
    float thickness[MAX_LAYERS],
    int numLayers
)
{
    float3 totalDiffractionPattern = float3(0.0, 0.0, 0.0);
    
    for (int i = 0; i < numLayers; ++i)
    {
        // Simulate the diffraction for each layer
        float3 layerDiffraction = SimulateOilyGlassDiffraction(lightPos,
            viewPos,
            surfaceNormal,
            wavelengths,
            nIncident,
            nFilmLayers[i],
            gratingSpacing[i],
            grooveDepth[i],
            diffractionOrder[i],
            absorptionCoefficient[i],
            thickness[i]
        );

        // Accumulate the contribution from each layer
        totalDiffractionPattern += layerDiffraction;
    }

    // Final diffraction pattern from all layers combined
    return totalDiffractionPattern;
}

// Master function for rendering caustics and diffraction for thick oily glass with multiple layers and grating
float3 RenderOilyCausticGlass(float3 lightPos,
    float3 viewPos,
    float3 surfaceNormal,
    float3 wavelengths,
    float3 nIncident,
    float nFilmLayers[MAX_LAYERS],
    float gratingSpacing[MAX_LAYERS],
    float grooveDepth[MAX_LAYERS],
    int diffractionOrder[MAX_LAYERS],
    float absorptionCoefficient[MAX_LAYERS],
    float thickness[MAX_LAYERS],
    int numLayers
)
{
    // Simulate multi-layer caustics with diffraction
    return SimulateMultiLayerCaustics(lightPos,
        viewPos,
        surfaceNormal,
        wavelengths,
        nIncident,
        nFilmLayers,
        gratingSpacing,
        grooveDepth,
        diffractionOrder,
        absorptionCoefficient,
        thickness,
        numLayers
    );
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
    // Normalize vectors
    float3 N = normalize(normalM);
    float3 V = normalize(viewDirM);
    
    // Cosine of the angle of incidence
    float NdotV = max(dot(N, V), 0.0);
    float3 cosThetaI = float3(NdotV, NdotV, NdotV);
    
    // Convert baseColor from sRGB to linear RGB
    float3 linearRGB = SRGBToLinear(baseColor.rgb);
    
    // Convert linear RGB to dominant wavelengths in meters
    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(baseColor.rgb));
    MaterialSellmeier material = CreateMaterial(MaterialIndex);
    // Calculate refractive indices using the Sellmeier equation
    float3 n2 = SellmeierEquation(wavelengthsM, material);
    float3 n1 = float3(1.0, 1.0, 1.0); // Refractive index of air
    
    // Calculate Fresnel reflectance
    float3 cosThetaT;
    float3 R = CalculateFresnelReflectance(n1, n2, cosThetaI, cosThetaT);
    
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



// Holographic Interference Calculation
float3 HolographicInterference(Texture2D<float> depthMap,
    float2 uv, // Texture coordinates
    float3 wavelengthsM, // Wavelengths in meters for R, G, B
    float2 interferencePoints[MAX_INTERFERENCE_POINTS], // Interference point positions in texture space
    int numPoints, // Number of interference points
    float heightScaleM, // Scale to convert height map values to meters
    float3 refractiveIndices = float3(1.5, 1.35, 1.75) // Refractive indices for R, G, B
)
{
    numPoints = min(MAX_INTERFERENCE_POINTS, numPoints);
    
    // Sample the height map at the current UV coordinate
    float height = depthRaw(depthMap, uv);

    // Convert height to physical units (meters)
    float heightInMeters = height * heightScaleM;

    // Position of the current point in 3D space
    float3 pointPosM = float3(uv * HOLOGRAM_SIZE_M, heightInMeters);

    // Initialize the cumulative complex amplitude for each color channel
    float2 cumulativeAmplitudeR = float2(0.0, 0.0); // (real, imaginary)
    float2 cumulativeAmplitudeG = float2(0.0, 0.0);
    float2 cumulativeAmplitudeB = float2(0.0, 0.0);

    // Loop over all interference points
    for (int i = 0; i < numPoints; i++)
    {
        // Get the position of the interference point
        float2 sourceUV = interferencePoints[i];

        // Sample the height map at the source point
        float sourceHeight = depthRaw(depthMap, sourceUV);
        float sourceHeightM = sourceHeight * heightScaleM;

        // Position of the source point in 3D space
        float3 sourcePosM = float3(sourceUV * HOLOGRAM_SIZE_M, sourceHeightM);

        // Calculate the phase shift for each wavelength
        float3 phaseShift = CalculatePhaseShiftM(pointPosM - sourcePosM, wavelengthsM, refractiveIndices);
        

        // Convert phase shifts to complex amplitudes (unit amplitude)
        float2 amplitudeR = float2(cos(phaseShift.r), sin(phaseShift.r));
        float2 amplitudeG = float2(cos(phaseShift.g), sin(phaseShift.g));
        float2 amplitudeB = float2(cos(phaseShift.b), sin(phaseShift.b));

        // Accumulate the amplitudes
        cumulativeAmplitudeR += amplitudeR;
        cumulativeAmplitudeG += amplitudeG;
        cumulativeAmplitudeB += amplitudeB;
    }

    // Calculate the intensity (squared magnitude of the amplitude) for each color channel
    float intensityR = dot(cumulativeAmplitudeR, cumulativeAmplitudeR);
    float intensityG = dot(cumulativeAmplitudeG, cumulativeAmplitudeG);
    float intensityB = dot(cumulativeAmplitudeB, cumulativeAmplitudeB);

    // Normalize the intensities
    float maxIntensity = max(max(intensityR, intensityG), intensityB);
    if (maxIntensity > 0.0)
    {
        intensityR /= maxIntensity;
        intensityG /= maxIntensity;
        intensityB /= maxIntensity;
    }

    // Return the final color, clamped to [0, 1]
    return clamp(float3(intensityR, intensityG, intensityB), EPSILON, 1 - EPSILON);
}

float3 FresnelDiffraction(Texture2D<float4> sourceMap, float2 uv, float3 observationPos, float wavelength, float aperture)
{
    // Sample source intensity and position
    float4 sourceSample = float4(sourceMap.Sample(sampleTypeMirror, uv));
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


float4 HolographicEffect(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv, float time, float3 viewPos, float3 lightPos, int tbnRadius, float intensity, int effectRadius)
{
    float3 pixel = float3(uv, depthRaw(depthMap, uv));
    // Calculate the view direction in world space
    float3 viewDirWS = normalize(viewPos - pixel);

    // Calculate the light direction in world space
    float3 lightDirWS = normalize(lightPos - pixel);

    float3x3 tbn = CalcTBN(depthMap, uv, tbnRadius);
    
    // Transform the light direction to tangent space using the TBN matrix
    float3 lightDirTS = mul(tbn, lightDirWS);
    float2 oosz = GetOosz(depthMap);
    float4 vc = mir2D(diffuseMap, uv);
    
    float4 vl = mir2D(diffuseMap, uv + float2(-oosz.x, 0) * effectRadius);
    float4 vr = mir2D(diffuseMap, uv + float2(oosz.x, 0) * effectRadius);
    float4 vu = mir2D(diffuseMap, uv + float2(0, -oosz.y) * effectRadius);
    float4 vd = mir2D(diffuseMap, uv + float2(0, oosz.y) * effectRadius);
    
    float4 vlen = float4(length(vl.xyz), length(vr.xyz), length(vu.xyz), length(vd.xyz));
    float2 fangle = float2(1, 1);
    if (vlen.x < vlen.y && vlen.x < vlen.z && vlen.w < vlen.y && vlen.w < vlen.z)
        fangle = normalize(float2(1, 0) * (config.uv - config.uv0));
    else if (vlen.x > vlen.y && vlen.x > vlen.z && vlen.w > vlen.y && vlen.w > vlen.z)
        fangle = normalize(float2(-1, 0) * (config.uv - config.uv0));
    else if (vlen.y < vlen.x && vlen.y < vlen.w && vlen.z < vlen.x && vlen.z < vlen.w)
        fangle = normalize(float2(0, 1) * (config.uv - config.uv0));
    else if (vlen.y > vlen.x && vlen.y > vlen.w && vlen.z > vlen.x && vlen.z > vlen.w)
        fangle = normalize(float2(0, -1) * (config.uv - config.uv0));
    
    // Create a color shift effect based on the angle between the view direction and the holographic normal
    float angle = acos(dot(viewDirWS, float3(fangle, 1)));
    float3 colorShift = moilerp(float3(0.0, 0.7, 1.0), float3(1.0, 0.0, 0.5), angle);
    float3 rainbowColor = .5 + float3(sin(angle * 10.0 + time), sin(angle * 10.0 + time + 2.0), sin(angle * 10.0 + time + 4.0));

    // Intensify the colors and create a shimmering effect
    rainbowColor = pow(abs(rainbowColor), 2.0) * intensity;

    // Add a reflective sheen based on the light direction and modified normal
    float reflection = max(EPSILON, dot(tbn[2], lightDirTS)) * 0.5;
    rainbowColor += reflection * colorShift;

    // Apply a holographic intensity based on the light direction
    float holographicEffect = saturate(intensity * max(EPSILON, dot(tbn[2], lightDirTS))) * 0.5 + 0.5;

    // Combine the holographic effect with a base color
    float3 baseColor = float3(.3, .3, .5);
    float3 finalColor = moilerp(baseColor, rainbowColor, holographicEffect);
    
    return Fresnel4(float4(finalColor, reflection), normalize(config.viewPos - float3(uv, depthRaw(depthMap, uv))), CalcNormal(depthMap, uv, normalRadius), 0.002, FresnelPower, FresnelReflectance);
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
    float2 offsetOMD = viewDir.xy * HeightScale * parallaxStrengthOMD * float2(cosTime11(AnimateSpeed), -.1);
    float2 offset = (viewDir).xy * HeightScale * parallaxStrength * float2(cosTime11(AnimateSpeed), .1);
    
    // Precompute to save operations inside loop
    float2 deltaUV = oosz * moilerp(float3(offset, 0), float3(offsetOMD, 0), 1.0 - odep).xy;
    
    float layerDepth = 1.0 / max(numLayers, EPSILON);
    float currentLayerDepth = 0.0;
    
    // Loop unrolled for performance
    [unroll(20)]
    for (int i = 0; i < numLayers; ++i)
    {
        float depthFromMap = depthRaw(depthMap, curUV);
        
        float2 prevUV = curUV;
        currentLayerDepth += layerDepth;
        
        // Calculate the next UV based on view direction and depth
        float2 nextUV = curUV + deltaUV * parallaxStrength * (1.0 - depthFromMap); // Invert depth for correct parallax effect
        
        // Refraction effect
        float3 tangentViewDir = normalize(float3(deltaUV, parallaxStrength * (1.0 - depthFromMap)));
        float3 tangentNormal = float3(CalcNormal(depthMap, curUV).xy, 1);
        float2 refractedUV = curUV + refract(tangentViewDir, tangentNormal, 1.3).xy * depthFromMap; // Use depth for refraction strength
        
        curUV = moilerp(float3(nextUV, 0), float3(refractedUV, 0), max(EPSILON, dot(tangentViewDir, CalcNormal(depthMap, curUV)))).xy; // Blend between parallax and refraction for effect
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

// 2. Chromatic Aberration (RGB Split)
inline float3 ppChromaticAberration(Texture2D<float4> tex, float2 uv, float amount, float mix = 1)
{
    float pd = projectedDepth(depthMap, uv);
    float3 n33 = noise3(noiseMap1, float3(uv, pd + TotalTime * AnimateSpeed * .1));
    float n1 = noise3(noiseMap1, float3(uv, pd)).x;
    float4 offset = float4(amount * .003, -amount * .003, amount * 0.001, -amount * 0.001) * float4(n33, n1);
    return moilerp(mir2D(tex, uv).xyz, float3(mir2D(tex, uv + offset.xy).r,
        mir2D(tex, uv + offset.yz).g,
        mir2D(tex, uv + offset.zw).b
    ), mix * .9);
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
    float time = TotalTime * AnimateSpeed * speed; // Time-based animation (adjust speed)
    float animatedStrength = strength * (1.0 + sin(time) * 0.2); // Oscillating strength
    return ppLensDistort(uv, animatedStrength, radius);
}

// 2. Chromatic Aberration Helper
inline float3 ppChromaticAberrationUV(Texture2D<float4> tex, float2 uv, float amount, float speed = 1.0)
{
    float time = TotalTime * AnimateSpeed * speed;
    float animatedAmount = amount * (1.0 + cos(time) * 0.1);
    return ppChromaticAberration(tex, uv, animatedAmount);
}

// 3. Vignette Helper
inline float ppVignetteUV(float2 uv, float amount, float softness, float speed = 0.5)
{
    float time = TotalTime * AnimateSpeed * speed;
    float animatedAmount = amount * (1.0 + sin(time) * 0.1);
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
    float time = TotalTime * AnimateSpeed * speed;
    float animatedAngle = angle * (1.0 + sin(time) * 0.3); // More pronounced swirl animation
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
    float3 color = tex.Sample(sampleTypeMirror, uv).xyz; // Use a sampler for better quality
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
                blurColor += tex.Sample(sampleTypeMirror, uv + offset).xyz * weight;
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

    return fmod(hue, 360); // Normalize to [0, 1]
}


float3 HolographicRainbowColor(float3 viewDir, float3 particleNormal)
{
    float hueShift = atan2(viewDir.y, viewDir.x) / (2.0 * PI);
    float hue = frac(dot(viewDir, particleNormal) + hueShift);
    
    return HueToRGB(fmod(hue, PI)); // Convert hue to RGB using a suitable function
}


// Function to compute rainbow colors based on an input value
float3 rainbowColor(float value)
{
    float3 color;
    color.r = sin(2.0 * 3.14159265 * value + 0.0) * 0.5 + 0.5;
    color.g = sin(2.0 * 3.14159265 * value + 2.0 / 3.0 * 3.14159265) * 0.5 + 0.5;
    color.b = sin(2.0 * 3.14159265 * value + 4.0 / 3.0 * 3.14159265) * 0.5 + 0.5;
    return color;
}

// Define the GGX distribution function
float GGX(float3 microfacetNormal, float roughness)
{
    // Calculate the GGX distribution
    float ggxDistribution = (roughness * roughness) / max((3.14159 * (microfacetNormal.z * microfacetNormal.z * (roughness * roughness - 1) + 1)), EPSILON);

    return ggxDistribution;
}

// Define the Fresnel function
float Fresnel(float3 viewDirection, float3 microfacetNormal, float refractiveIndex)
{
    // Calculate the Fresnel term
    float fresnelTerm = (refractiveIndex - 1) * (refractiveIndex - 1) / max(((refractiveIndex + 1) * (refractiveIndex + 1)), EPSILON);

    return fresnelTerm;
}


// Define the microfacet-based BRDF function
float3 MicrofacetBRDF(float3 materialSpecularColor, float3 normal, float3 viewDirection, float3 lightDirection, float roughness, float materialRefractiveIndex = 1.3, float thickness = 20, float dispersionCoefficient = 0.005)
{
    // Calculate the microfacet normal
    float3 microfacetNormal = normalize(normal + roughness * (viewDirection + lightDirection));

    // Calculate the GGX distribution
    float ggxDistribution = GGX(microfacetNormal, roughness);

    // Calculate the Fresnel term
    float3 fresnelTerm = saturate(Fresnel3(materialSpecularColor, viewDirection, normal, thickness, FresnelPower, FresnelReflectance, materialRefractiveIndex, dispersionCoefficient));

    // Calculate the BRDF
    float3 brdf = materialSpecularColor.rgb * ggxDistribution * fresnelTerm;

    return brdf;
}

// Define the chromatic aberration function
float3 ChromaticAberration(float3 viewDirection, float3 normal, float refractiveIndex, float abbeNumber)
{
    // Calculate the chromatic aberration
    float3 chromaticAberration = viewDirection * (1.0 - (refractiveIndex - 1) / max((abbeNumber * (normal.z * normal.z)), EPSILON));

    return chromaticAberration;
}

// Define the pixel shader function
float4 DichroicOcularInclusionPixelShader(Texture2D<float4> diffuseMap, float3 position, float3 normal, float materialRefractiveIndex, float3 lightDirection, float materialShininess, float materialAbbeNumber, float3 materialDiffuseColor, float3 materialSpecularColor, float3 lightDiffuseColor)
{
    // Initialize the output structure
    float4 output;
    output = float4(0, 0, 0, 1);

    // Sample the texture
    float4 textureColor = diffuseMap.Sample(sampleTypeMirror, position.xy);

    // Calculate the view direction
    float3 viewDirection = normalize(position.xyz);

    // Calculate the reflection vector
    float3 reflectionVector = reflect(viewDirection, normal);

    // Calculate the transmission vector
    float3 transmissionVector = refract(viewDirection, normal, materialRefractiveIndex);

    // Calculate the microfacet-based BRDF
    float3 brdf = MicrofacetBRDF(materialSpecularColor, normal, viewDirection, lightDirection, materialShininess, materialRefractiveIndex);

    // Calculate the chromatic aberration
    float3 chromaticAberration = ChromaticAberration(viewDirection, normal, materialRefractiveIndex, materialAbbeNumber);

    // Calculate the dichroic ocular inclusion effect
    float3 dichroicColor = materialDiffuseColor.rgb * textureColor.rgb;
    dichroicColor += brdf * lightDiffuseColor.rgb * pow(max(EPSILON, dot(reflectionVector, lightDirection)), 2);
    dichroicColor += lightDiffuseColor.rgb * pow(max(EPSILON, dot(transmissionVector, lightDirection)), 2);
    dichroicColor += chromaticAberration * materialSpecularColor.rgb;

    // Assign the final color
    output.rgb = dichroicColor;
    output.a = textureColor.a;

    return output;
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
    float3 normalizeNormal = normalize(normal);
    
    // Diffuse lighting
    float nDotL = max(dot(normalizeNormal, normalize(pixelToSunDir)), EPSILON);
    float3 diffuse = color.rgb * nDotL * sunIntensity;
    
    // Ambient light
    float3 ambientLight = color.rgb * ambient;
    
    // Combine lighting
    float3 finalColor = diffuse + ambientLight;

    return float4(finalColor, color.a);
}

// Main pixel shader function
float4 light(float4 position, float2 tex)
{
    return LightPixel(tex,
                      config.normal,
                      config.viewPos,
                      config.viewDir,
                      .1,
                      config.pixelToSunDir,
                      .2,
                      .3);
}

// Geometry function using Schlick-GGX
float GeometrySchlickGGX(float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r * r) / 8.0;
    float denom = NdotV * (1.0 - k) + k;
    return NdotV / max(denom, EPSILON);
}

float3 MicrofacetBRDF(float3 albedo, float metallic, float3 normal, float3 viewDir, float3 lightDir, float roughness, float ao = 1.0)
{
    // Ensure vectors are normalize
    viewDir = normalize(viewDir);
    lightDir = normalize(lightDir);
    normal = normalize(normal);
    float3 halfDir = normalize(viewDir + lightDir);
    
    float NdotH = max(EPSILON, dot(normal, halfDir));
    float NdotL = max(EPSILON, dot(normal, lightDir));
    float VdotH = max(EPSILON, dot(viewDir, halfDir));
    float NdotV = max(EPSILON, dot(normal, viewDir));
    
    // Cook-Torrance BRDF
    float D = DistributionGGX(NdotH, roughness);
    float G = GeometrySmith(NdotL, NdotV, roughness);
    float3 F = FresnelSchlick(albedo, float3(VdotH, VdotH, VdotH), FresnelPower);

    // Specular BRDF
    float3 numerator = D * G * F;
    float denominator = 4.0 * NdotV * NdotL; // Add small constant to avoid div by zero
    float3 specular = numerator / max(denominator, EPSILON);

    // kS is equal to Fresnel
    float3 kS = F;
    // for energy conservation, the diffuse and specular light can't
    // be above 1.0 (unless the surface emits light); to preserve this relationship
    // the diffuse component (kD) should equal 1.0 - kS.
    float3 kD = float3(1.0, 1, 1) - kS;
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

// Helper function to retrieve hologram data (placeholder for actual implementation)
float4 GetHologramDataRT(Texture2D<float4> rtMap, float2 uv)
{
    return rtMap.SampleLevel(sampleTypeMirror, uv, 0);
}

struct HologramData
{
    float3 Color;
    float3 WavelengthsNM;
    float3 Pixel;
};

// Helper function to retrieve hologram data (placeholder for actual implementation)
HologramData GetHologramData(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv)
{
    // Sample diffuse and depth maps
    float4 diffuseColor = diffuseMap.SampleLevel(sampleTypeMirror, uv, 0);
    float depth = depthRaw(depthMap, uv);
    
    // Encode depth into hologramData.w and diffuse color into hologramData.rgb
    HologramData data = { (HologramData) 0 };
    data.Color = diffuseColor.rgb;
    data.Pixel = float3(uv, depth) * HOLOGRAM_SIZE_M;
    data.WavelengthsNM = RGBToWavelengthsNM(diffuseColor.rgb);
    return data;
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
    
    float3 position; // Position in 3D space (likely normalized or in a shader-specific space)
    float3 color; // RGB color of the light
    float3 wavelengthNM; // Wavelength in nanometers for RGB components
    float intensity; // Light intensity
    float coherenceLength; // Coherence length in meters or normalized units
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
    float coherenceLength; // Coherence length in meters or normalized units
    float phaseOffset; // Initial phase offset for interference effects
    float4x4 lightSpaceMatrix; // Transformation matrix to light's local space, could be used for complex patterns or 3D encoding
    float2 textureUVScale; // Scale for UV mapping if texture-based interference is used
    float angularSpread; // For simulating divergence or spread of the holographic beam
};

struct InterferencePattern
{
    float amplitude; // Strength of the interference pattern
    float3 frequency; // Frequency of the pattern in 3D space
    float phase; // Phase shift for the pattern
};
HolographicLight CreateHolographicLight(float3 pos, float3 dir, float3 col, float3 waveLen, float inten, float cohLen, float phaseOff, float4x4 lightMatrix, float2 uvScale, float angularSpread)
{
    HolographicLight light;
    light.position = pos;
    light.direction = normalize(dir);
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

// Method to simulate interference between two holographic light sources
InterferencePattern CalculateInterference(HolographicLight light1, HolographicLight light2, float3 pointInSpace)
{
    InterferencePattern pattern;
    
    // Calculate phase difference at pointInSpace
    float distance1 = length(light1.position - pointInSpace);
    float distance2 = length(light2.position - pointInSpace);
    float pathDifference = abs(distance1 - distance2);
    
    // Phase difference due to path length difference
    float3 phaseDiff = (2.0 * PI * pathDifference) / max(light1.wavelengthNM, EPSILON3);
    
    // Combine phases with initial offsets
    float combinedPhase = dot(phaseDiff, float3(1, 1, 1)) + light1.phaseOffset - light2.phaseOffset;
    
    // Simplistic interference - in reality, this would involve complex number arithmetic or more sophisticated models
    pattern.amplitude = 2.0 * sqrt(light1.intensity * light2.intensity) * cos(combinedPhase / 2.0);
    pattern.frequency = (light1.wavelengthNM + light2.wavelengthNM) / 2.0; // Average wavelength as a simple approximation for frequency
    pattern.phase = combinedPhase;
    
    return pattern;
}

// Method to project a point into the light's local space, useful for texture-based interference or complex patterns
float2 ProjectToLightSpace(HolographicLight light, float3 worldPosition)
{
    float4 localPoint = mul(float4(worldPosition - light.position, 1.0), light.lightSpaceMatrix);
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
    LightSource light = { (LightSource) 0 };
    
    light.LightSourceType = type;
    // Common properties for all light types
    light.position = position;
    light.color = color;
    light.wavelengthNM = wavelengthNM;
    light.intensity = intensity;
    light.coherenceLength = coherenceLength;
    light.direction = normalize(direction);
    light.beamWidth = beamWidth;
    light.divergenceAngle = divergenceAngle;
    light.phaseOffset = phaseOffset;
    
    // Specific profiles
    switch (light.LightSourceType)
    {
        case LIGHT_TYPE_POINT:
            // Point light sources emit light equally in all directions, so direction and divergence might not matter
            light.divergenceAngle = 0; // Not applicable, but set for clarity
            break;
        
        case LIGHT_TYPE_DIRECTIONAL:
            light.position = float3(0, 0, 0); // Directional lights are considered to be infinitely far away
            break;
        
        case LIGHT_TYPE_SPOT:
            // For a spot light, ensure the divergence angle is set to something less than PI/2
            light.divergenceAngle = clamp(light.divergenceAngle, 0.0, PI / 2 - 0.01); // Small offset to avoid edge case
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
    worldPos.z = ((1 - depth)) * HOLOGRAM_SIZE_M;
    return worldPos;
}

void CreatePhasedLightsFromDepth(float2 uv, float3 viewPosition, Texture2D<float> depthMap, inout LightSource lights[MAX_LIGHT_SOURCES], inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    float depth = depthRaw(depthMap, uv);
    float3 worldPos = UVToWorld(uv, depth);
    
    float3 viewDir = normalize(worldPos - viewPosition);
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
            
            // Convert loop counters to normalized coordinates
            float2 lightUV = float2(x, y) / max(float(lightsPerAxis - 1), EPSILON) - .5;
            float3 lightWorldX = UVToWorld(lightUV, localDepth0.x);
            float3 lightWorldY = UVToWorld(lightUV, localDepth0.y);
            float3 lightWorldZ = UVToWorld(lightUV, localDepth0.z);
            float3 lightDir = normalize(viewPosition - worldPos + lightWorldX);
            // Random seed update for pseudo-randomness in light properties
            randomSeeds[lightIndex] += float3(RotateUVWithDepth(lightUV, localDepth0 + lightWorldY, acos(dot(lightDir, CalcNormal(depthMap, lightUV)))), depthMap.SampleLevel(sampleTypeLinear, lightUV + lightWorldZ.x, 0).x);
            
            // Compute light's wavelength - here we'll simulate a simple wavelength distribution
            float3 wavelengthNM = MIN_WAVELENGTHS + clamp(randomSeeds[lightIndex] * WAVELENGTH_RANGES, MIN_WAVELENGTHS, MAX_WAVELENGTHS);
            randomSeeds[lightIndex] += nmToM(wavelengthNM) * dot(CalcNormal(depthMap, lightUV), viewDir);
            
            
            // Calculate light position so that phase converges at worldPos
            // Assuming lights spread in a grid, each light needs to be positioned such that its phase 
            // at worldPos is a multiple of 2PI more than at the last light
            float3 localDepth = depth * HOLOGRAM_SIZE_M * nmToM(wavelengthNM) / MAX_LIGHT_SOURCES;
            randomSeeds[lightIndex] += CalcNormal(depthMap, lightUV + .015 * dot(uv - lightUV, viewDir.xy) * dot(localDepth / max(nmToM(wavelengthNM), viewDir.xyz), EPSILON3));
            
            float3 lightPos = worldPos - lightDir * (localDepth + wavelengthNM.x * floor(distanceToViewer / wavelengthNM.x));
            
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

float hash11(float p)
{
    p = frac(p * .1031);
    p *= p + 33.33;
    p *= p + p;
    return frac(p);
}

// Function to create light with reproducible properties from a seed
LightSource CreateDeterministicLight(float seed, float3 viewPosition)
{
    LightSource light = { (LightSource) 0 };
    
    // Seed manipulation for different properties
    float3 seeds = float3(hash11(seed),
        hash11(seed * 1.12345),
        hash11(seed * 1.34567)
    );

    // Light Type
    int lightType = fmod(int(seeds.x * 5), 5); // 5 types of light
    
    // Positioning the light in front of the viewer
    float3 direction = normalize(float3(seeds.y - 0.5, seeds.z - 0.5, 1.0));
    light.position = viewPosition + direction * 1.25 * seeds.x;
    
    float3 lightRangeMin = float3(.01, .01, .01);
    float3 lightRangeMax = float3(0.95, 0.95, 0.75);
    float3 lightRange = lightRangeMax - lightRangeMin;
    
    // Color and wavelength
    light.color = float3(hash11(seed * 2.1),
        hash11(seed * 2.2),
        hash11(seed * 2.3)
    );
    light.wavelengthNM = lerp(float3(380, 440, 675), float3(750, 675, 380), seeds.y);
    
    light.position += lightRange - direction * nmToM(light.wavelengthNM);
    
    // Intensity and other properties
    light.intensity = dot(nmToM(seeds * .652 * light.wavelengthNM), light.wavelengthNM);
    light.direction = normalize(viewPosition - light.position + length((400 + light.wavelengthNM) / (1440 * light.wavelengthNM / 1000.0)) * (seeds.y - 0.5) * 0.2);
    light.coherenceLength = seeds.y * 10.0;
    light.phaseOffset = seeds.z * 2.0 * PI;
    
    // Adjust for light type
    switch (lightType)
    {
        case LIGHT_TYPE_POINT:
            light.divergenceAngle = 0;
            light.beamWidth = 0;
            break;
        
        case LIGHT_TYPE_DIRECTIONAL:
            light.position = viewPosition - light.direction * 1000.0;
            break;
        
        case LIGHT_TYPE_SPOT:
            light.divergenceAngle = seeds.y * 0.4 + 0.1;
            light.beamWidth = 0;
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
    return nFilmBase + float3(0.01 / wavelengthsM.r, 0.01 / wavelengthsM.g, 0.01 / wavelengthsM.b);
}

// Helper to calculate diffraction grating effects based on wavelength and grating spacing
float3 CalculateDiffraction(float gratingSpacingM, float3 wavelengthsM, float incidentAngle)
{
    float3 diffractionAngle;
    diffractionAngle.r = asin(sin(incidentAngle) + wavelengthsM.r / gratingSpacingM);
    diffractionAngle.g = asin(sin(incidentAngle) + wavelengthsM.g / gratingSpacingM);
    diffractionAngle.b = asin(sin(incidentAngle) + wavelengthsM.b / gratingSpacingM);

    // Diffraction grating can cause light to spread, modulating intensity
    return abs(sin(diffractionAngle)); // Return diffraction pattern intensity
}

// Helper to calculate polarization effects based on incident and reflection angle
float3 CalculatePolarization(float polarizationAngle, float3 incidentAngle, float3 nIncident, float3 nFilm)
{
    float3 Rs = pow((nIncident * cos(incidentAngle) - nFilm * cos(polarizationAngle)) / (nIncident * cos(incidentAngle) + nFilm * cos(polarizationAngle)), 2);
    float3 Rp = pow((nFilm * cos(incidentAngle) - nIncident * cos(polarizationAngle)) / (nFilm * cos(incidentAngle) + nIncident * cos(polarizationAngle)), 2);
    return (Rs + Rp) / 2.0;
}

// Main interference calculation combining multiple effects
float3 InterferenceEffects(float thicknessM, float3 normal, float3 viewPos, float3 lightPos, float3 viewDir, float3 wavelengthsM, float3 nIncident, float3 nFilmBase, float gratingSpacingM, float polarizationAngle)
{
    // Normalize vectors
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    
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
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / (nIncident * cosThetaI + nFilm * cosThetaT), 2);
    
    // Fresnel reflectance at second interface (film to air)
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / (nFilm * cosThetaT + nIncident * cosThetaI), 2);
    
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

// Example of scene usage: simulating rainbow-like sheen and glossy effects on an oily surface
float3 RenderOilySurface(float3 viewPos,
    float3 lightPos,
    float3 normal,
    float3 wavelengthsM,
    float thicknessM,
    float3 nIncident,
    float3 nFilmBase,
    float gratingSpacingM,
    float polarizationAngle
)
{
    // Calculate view direction
    float3 viewDir = normalize(viewPos - lightPos);

    // Simulate interference with diffraction, polarization, and dispersion effects
    float3 interferenceColor = InterferenceEffects(thicknessM, // Thickness of the oily film
        normal, // Surface normal
        viewPos, // View position
        lightPos, // Light position
        viewDir, // View direction
        wavelengthsM, // Wavelengths in Meters (RGB)
        nIncident, // Refractive index of incident medium (air)
        nFilmBase, // Base refractive index of the film
        gratingSpacingM, // Grating spacing in Meters
        polarizationAngle // Polarization angle of light
    );
    
    // Light intensity (for simplicity, assuming white light)
    float3 lightIntensity = dot(normal, viewDir);
    
    // Final rendered color with interference and light intensity
    return interferenceColor * lightIntensity;
}

float3 RenderOilySurface1(float3 viewPos, float3 lightPos, float2 uv, float3 wavelengthsM, float gratingSpacingM, float polarizationAngleRadians)
{

// Usage example: rendering an oily surface with rainbow sheens
    float3 finalColor = RenderOilySurface(viewPos,
        lightPos,
        CalcNormal(depthMap, uv),
        wavelengthsM,
        1.5e-7, // Film thickness in meters (0.15 micrometers)
        float3(1.0, 1.0, 1.0), // Refractive index of air (incident medium)
        float3(1.4, 1.4, 1.4), // Base refractive index of the oily film
        gratingSpacingM, // Grating spacing in meters (1 micrometer)
        polarizationAngleRadians // Polarization angle in radians
    );

// Output the final color
    return finalColor;
}

// Updated Interference Calculation using the Matrix Method
float3 InterferenceM(
    float thicknessM,
    float3 normal,
    float3 viewDir,
    float3 wavelengthsM,
    float nIncident,
    float nFilm,
    float nSubstrate
)
{
    // Normalize vectors
    normal = normalize(normal);
    viewDir = normalize(viewDir);

    // Calculate incident angle
    float cosThetaI = dot(viewDir, normal);
    cosThetaI = clamp(cosThetaI, .01, 1.0);
    float thetaI = acos(cosThetaI);

    // Snell's Law to find transmitted angles
    float sinThetaT1 = (nIncident / max(nFilm, EPSILON)) * sin(thetaI);
    float sinThetaT2 = (nFilm / max(nSubstrate, EPSILON)) * sin(asin(sinThetaT1));

    // Ensure total internal reflection doesn't occur
    if (sinThetaT1 >= 1.0 || sinThetaT2 >= 1.0)
    {
        return float3(0.0, 0.0, 0.0);
    }

    float cosThetaT1 = sqrt(1.0 - sinThetaT1 * sinThetaT1);
    float cosThetaT2 = sqrt(1.0 - sinThetaT2 * sinThetaT2);

    // Calculate phase change due to path difference
    float3 delta = (2.0 * PI * nFilm * thicknessM * cosThetaT1) / wavelengthsM;

    // Fresnel coefficients for s- and p-polarizations
    float Rs12 = pow(max((nIncident * cosThetaI - nFilm * cosThetaT1) / max(nIncident * cosThetaI + nFilm * cosThetaT1, EPSILON), EPSILON), 2);
    float Rp12 = pow(max((nFilm * cosThetaI - nIncident * cosThetaT1) / max(nFilm * cosThetaI + nIncident * cosThetaT1, EPSILON), EPSILON), 2);
    float Rs23 = pow(max((nFilm * cosThetaT1 - nSubstrate * cosThetaT2) / max(nFilm * cosThetaT1 + nSubstrate * cosThetaT2, EPSILON), EPSILON), 2);
    float Rp23 = pow(max((nSubstrate * cosThetaT1 - nFilm * cosThetaT2) / max(nSubstrate * cosThetaT1 + nFilm * cosThetaT2, EPSILON), EPSILON), 2);

    // Average reflectance over s and p polarizations
    float R12 = (Rs12 + Rp12) / 2.0;
    float R23 = (Rs23 + Rp23) / 2.0;

    // Calculate total reflectance using multiple beam interference
    float numerator = sqrt(R12 * R23);
    float denominator = 1.0 - R12 * R23;
    float3 reflectance = (R12 + R23 + 2.0 * numerator * cos(delta)) / max(1.0 + denominator, EPSILON);

    return reflectance;
}


float3 RenderOilySurface2(float3 viewPos,
    float3 viewDir,
    float3 lightPos,
    float2 uv,
    float time,
    float3 wavelengthsM,
    float gratingSpacingM,
    float polarizationAngleRadians,
    int numGaussianPoints,
    GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS])
{
    // Base depth in meters (M)
    float baseDepth = depthRaw(depthMap, uv);
    float2 oosz = GetOosz(depthMap); // Scale factor for depth map offsets
    float3 baseNormal = CalcNormal(depthMap, uv);
    
    // Initialize diffraction accumulation
    float3 diffractionAccum = float3(0, 0, 0);

    // Iterate over all active Gaussian point sources
    for (int i = 0; i < numGaussianPoints; ++i)
    {
        GaussianPointSource source = gaussianPoints[i];

        // Calculate vector from point source to viewer position in meters (M)
        float3 sourceToView = viewPos - source.position; // Position vectors assumed in meters
        
        // Distance in meters (M) directly from source to view position
        float3 distanceM = length(sourceToView) + EPSILON; // Avoid division by zero

        // Depth interpolation, assuming depth values in meters (M)
        float3 depth = lerp(float3(baseDepth, baseDepth, baseDepth),
            float3(depthRaw(depthMap, uv - oosz * 2), depthRaw(depthMap, uv), depthRaw(depthMap, uv + oosz * 2)),
            0.75);
        
        // Normalize direction vector
        float3 direction = normalize(sourceToView);
        
        // Recalculate surface normal based on view direction offsets
        float3 normal = normalize(lerp(baseNormal, CalcNormal(depthMap, uv + direction.xy * oosz), 0.75));
        
        // Calculate angle between the Gaussian beam direction and sourceToView vector (in radians)
        float angle = acos(dot(direction, viewDir)) * dot(viewDir, normal);

        // Apply Gaussian beam profile based on distance and beam width
        float3 beamProfile = gaussianBeam(distanceM, source.beamWidth) / wavelengthsM;
        
        // Phase calculation based on distance and wavelength
        float3 basePhase = (2 * PI * (1 + float(i)) * time) / beamProfile;
        
        // Apply phase modulation to simulate swaying effect
        float3 swayPhase = basePhase / float(numGaussianPoints);
        
        float3 totalPhase = basePhase + swayPhase;
        
        // Calculate interference from this Gaussian point source
        float3 interferenceM = source.color * source.amplitude * beamProfile * cos(totalPhase);
        
        // Simulate oily surface for this source and accumulate contribution
        float3 finalColor = RenderOilySurface1(viewPos,
            source.position,
            uv,
            wavelengthsM,
            gratingSpacingM, // Grating spacing in meters (M)
            polarizationAngleRadians
        );
        
        // Accumulate the diffraction result
        diffractionAccum += finalColor;
    }
    
    // Normalize accumulated diffraction
    float3 normalizedDiffraction = diffractionAccum / float(numGaussianPoints);
    
    // Return the final diffraction result
    return normalizedDiffraction;
}


float3 InterferenceColorM_Advanced(MaterialSellmeier material,
    float3 normal, // Surface normal vector
    float3 viewDir, // View direction vector
    float3 wavelengthsM, // Wavelengths for R, G, B in meters
    float time, // Time in seconds for swaying effect
    float swayAmplitude,
    float swayFrequency
)
{
    // Normalize vectors
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    
    // Angle of incidence (cos(theta_i)), clamp to [0,1]
    float cosThetaI = saturate(dot(normal, viewDir));
    
    // --- Dispersion using Sellmeier Equation ---
    float3 nFilmDispersed = SellmeierEquation(wavelengthsM, material);
    
    // Snell's Law with Dispersion: n1 * sin(theta_i) = n2 * sin(theta_t)
    float3 sinThetaI = sqrt(max(EPSILON3, 1.0 - pow(cosThetaI, 2)));
    float3 sinThetaT = (material.nSurrounding / nFilmDispersed) * sinThetaI;
    sinThetaT = saturate(sinThetaT); // Handle total internal reflection
    float3 cosThetaT = sqrt(1.0 - pow(sinThetaT, 2));
    
    // Optical path difference (delta) in meters with swaying modulation
    // Introducing swaying by modulating the phase based on time
    float swayPhase = swayAmplitude * sin(2.0 * PI * swayFrequency * time);
    float3 deltaM = 2.0 * nFilmDispersed * material.thicknessM * cosThetaT + swayPhase;
    
    // --- Phase Change on Reflection ---
    // Phase shift is pi radians if light reflects from a medium with higher refractive index
    float3 phaseChange1 = step(nFilmDispersed, float3(material.nSurrounding, material.nSurrounding, material.nSurrounding)) * PI; // Incident to film
    float3 phaseChange2 = step(float3(material.nSurrounding, material.nSurrounding, material.nSurrounding), nFilmDispersed) * PI; // Film to incident medium
    
    // --- Phase Difference with All Contributions ---
    float3 phase = (2.0 * PI * deltaM) / wavelengthsM + phaseChange1 + phaseChange2;
    
    // --- Fresnel Reflectance Calculation ---
    // Rs and Rp for each wavelength
    float3 Rs = pow((material.nSurrounding * cosThetaI - nFilmDispersed * cosThetaT) /
                    (material.nSurrounding * cosThetaI + nFilmDispersed * cosThetaT + EPSILON), 2.0);
    float3 Rp = pow((nFilmDispersed * cosThetaI - material.nSurrounding * cosThetaT) /
                    (nFilmDispersed * cosThetaI + material.nSurrounding * cosThetaT + EPSILON), 2.0);
    float3 R12 = (Rs + Rp) / 2.0; // Average reflectance at first interface
    
    // Reflectance at second interface (film to surrounding medium)
    float3 Rs23 = pow((nFilmDispersed * cosThetaI - material.nSurrounding * cosThetaT) /
                      (nFilmDispersed * cosThetaI + material.nSurrounding * cosThetaT + EPSILON), 2.0);
    float3 Rp23 = pow((material.nSurrounding * cosThetaI - nFilmDispersed * cosThetaT) /
                      (material.nSurrounding * cosThetaI + nFilmDispersed * cosThetaT + EPSILON), 2.0);
    float3 R23 = (Rs23 + Rp23) / 2.0; // Average reflectance at second interface
    
    // --- Polarization Factor ---
    // Adjust reflectance based on polarization angle and difference between R12 and R23
    float3 polarizationFactor = 1.0 + cos(2.0 * material.polarizationAngle) * (R12 - R23);
    
    // --- Coherence Factor ---
    // Models the loss of coherence over increasing optical path differences
    float3 coherenceFactor = exp(-pow(deltaM, 2) / pow(material.coherenceLengthM, 2));
    
    // --- Absorption ---
    // Accounts for material absorption over the film thickness
    float3 absorption = exp(-material.absorptionCoefficient * material.thicknessM);
    
    // --- Total Reflectance Including Interference, Absorption, Coherence, and Polarization ---
    float3 reflectance = (R12 + R23 + 2.0 * sqrt(R12 * R23) * cos(phase)) * absorption * coherenceFactor * polarizationFactor;
    
    // Clamp reflectance to [0, 1] to ensure valid color values
    //reflectance = clamp(reflectance, 0.0, 1.0);
    
    return reflectance;
}





float3 ApplyChromaticAberration(float2 oosz, Texture2D<float4> diffuseMap, float2 uv, float intensityPixels)
{
    // Offsets for RGB channels
    float2 redOffset = uv + intensityPixels * float2(-1.0, -.30) * oosz;
    float2 greenOffset = uv;
    float2 blueOffset = uv + intensityPixels * float2(1.0, .30) * oosz;

    // Sample texture with offsets
    float3 color = float3(
        diffuseMap.Sample(sampleTypeMirror, redOffset).r,
        diffuseMap.Sample(sampleTypeMirror, greenOffset).g,
        diffuseMap.Sample(sampleTypeMirror, blueOffset).b);

    return color;
}



float3 PolarizedInterference(float3 phaseShift, float3 polarAngle)
{
    float3 polarizationEffect = float3(sin(phaseShift.x + polarAngle.x),
        sin(phaseShift.y + polarAngle.y),
        sin(phaseShift.z + polarAngle.z)
    );
    return (polarizationEffect * 0.5 + 0.5) * 0.8 + 0.2;
}


float3 LensFlare(float2 uv, float2 lightPos, float intensity)
{
    float2 delta = uv - lightPos;
    float dist = length(delta);
    float denom = (1.0 + 30.0 * dist * dist);
    if (denom == 0)
    {
        denom += EPSILON;
    }
    float flare = 1.0 / denom;
    return float3(1.0, 0.7, 0.4) * flare * intensity; // Warm color for flare
}

float3 ChromaticAberration(Texture2D<float4> diffuseMap, float2 uv, float strength)
{
    float r = diffuseMap.Sample(sampleTypeMirror, float2(uv + float2(strength, 0))).r;
    float g = diffuseMap.Sample(sampleTypeMirror, uv).g;
    float b = diffuseMap.Sample(sampleTypeMirror, float2(uv - float2(strength, 0))).b;
    return float3(r, g, b);
}


float2 HeatHaze(float2 uv, float time, float intensity)
{
    float noise = noiseFast11(uv * 10.0 + time);
    return uv + 10 * noise * intensity * float2(sin(time), cos(time));
}


float4 renderMylar(float2 uv, float3 viewPos, float3 sunPos, float time, float thickness) : SV_Target
{
    float depth = depthRaw(depthMap, uv);
    float3 normal = CalcNormal(depthMap, uv);
    
    float3 viewDir = normalize(viewPos - float3(uv, depth));
    
    // Assuming refract function is defined elsewhere or replace with a simple offset for testing
    float2 refractedUV = uv + refract(viewDir, normal, 1.3).xy * 0.01; // Simplified refraction
    
    float4 baseColor = diffuseMap.Sample(sampleTypeMirror, refractedUV);
    float4 interference = float4(InterferenceM(thickness, normal, viewDir, RGB_WAVELENGTHS_M, 1.0, 1.75, f7), 1);
    
    float4 F0 = float4(0.04, 0.04, 0.04, 1);
    float ndotv = max(dot(normal, viewDir), EPSILON);
    float3 fresnel = FresnelSchlick(F0.rgb, float3(ndotv, ndotv, ndotv), FresnelPower);
    
    float3 mylarColor = baseColor.rgb + fresnel * 0.2; // Adjust 0.2 as needed for highlight intensity
    
    return float4(saturate(mylarColor), 1);
}



float2 FresnelKernel(float2 offset, float wavelength, float depth)
{
    // Calculate the squared distance from the sample point to the observation point
    float r2 = dot(offset, offset);
    
    // Compute the phase shift using the Fresnel approximation
    float phase = (3.14159265 * r2) / (wavelength * depth + EPSILON);
    
    // Return the complex exponential representing the phase shift
    return float2(cos(phase), sin(phase));
}

float4 CalcFresnelDiffraction(float3 diffuse, float2 uv, float wavelength)
{
    // Fetch amplitude (intensity) from the input image (rtMap1)
    float3 color = diffuse;
    float intensity = max(EPSILON, dot(color, float3(0.2989, 0.5870, 0.1140))); // Convert to grayscale

    // Fetch phase information from the depth map
    float depth = depthRaw(depthMap, uv);
    float phaseShift = depth * 2.0 * 3.14159265 / (wavelength + EPSILON);

    // Initialize the complex field
    float2 field = float2(intensity * cos(phaseShift), intensity * sin(phaseShift));
    
    // Accumulate the Fresnel diffraction pattern
    float2 diffractionSum = float2(0.0, 0.0);

    // Loop over the aperture (input image plane)
    const int sampleCount = 16; // Adjust for quality vs. performance
    float2 pixelSize = GetOosz(depthMap); // Assuming this returns 1.0 / textureSize

    [unroll(2)]
    for (int x = -sampleCount / 2; x < sampleCount / 2; x++)
    {
        [unroll(2)]
        for (int y = -sampleCount / 2; y < sampleCount / 2; y++)
        {
            float2 sampleOffset = float2(x, y) * pixelSize;
            float2 sampleUV = uv + sampleOffset;

            // Ensure sampleUV stays within [0, 1]
            sampleUV = clamp(sampleUV, float2(0.0, 0.0), float2(1.0, 1.0));

            // Fetch intensity and phase from neighboring samples
            float3 sampleColor = diffuseMap.Sample(sampleTypeMirror, sampleUV).rgb;
            float sampleIntensity = max(EPSILON, dot(sampleColor, float3(0.2989, 0.5870, 0.1140)));
            float sampleDepth = depthRaw(depthMap, sampleUV);
            float samplePhaseShift = sampleDepth * 2.0 * 3.14159265 / (wavelength + EPSILON);
            float2 sampleField = float2(sampleIntensity * cos(samplePhaseShift), sampleIntensity * sin(samplePhaseShift));

            // Compute the Fresnel diffraction contribution
            float2 fresnel = FresnelKernel(sampleOffset, wavelength, depth);
            diffractionSum += float2(sampleField.x * fresnel.x - sampleField.y * fresnel.y,
                sampleField.x * fresnel.y + sampleField.y * fresnel.x
            );
        }
    }

    // Compute the intensity of the diffraction pattern
    float diffractionIntensity = dot(diffractionSum, diffractionSum);

    // Normalize and adjust the intensity for visualization
    float normalizeIntensity = sqrt(diffractionIntensity) / (sampleCount + EPSILON);
    
    // Output the hologram
    return float4(normalizeIntensity, normalizeIntensity, normalizeIntensity, 1.0);
}

float3 ApplyDepthOfField(Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float focusDepth, float maxBlur)
{
    float sceneDepth = depthRaw(depthMap, uv);

    // Calculate blur amount based on depth difference
    float blurAmount = saturate(abs(sceneDepth - focusDepth) / (maxBlur + EPSILON));

    // Sample neighboring pixels based on blur amount
    float3 color = float3(0.0, 0.0, 0.0);
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



float2 ParallaxMapping(float2 uv, float3 viewDir)
{
    const int numLayers = 30;
    float layerDepth = 1.0 / numLayers;
    float2 P = viewDir.xy * HeightScale;
    float2 deltaTexCoord = P / numLayers;
    float2 currentTexCoord = uv;
    float currentLayerDepth = 0.0;
    float heightFromTexture = depthMap.Sample(sampleTypeMirror, currentTexCoord).r;

    [loop]
    for (int i = 0; i < numLayers; ++i)
    {
        currentLayerDepth += layerDepth;
        currentTexCoord -= deltaTexCoord;
        heightFromTexture = depthMap.Sample(sampleTypeMirror, currentTexCoord).r;
        if (heightFromTexture < currentLayerDepth)
        {
            break;
        }
    }
    return currentTexCoord;
}

// Vertex Shader
PS_INPUT VSMain(VS_INPUT input)
{
    PS_INPUT output = (PS_INPUT) 0;
    output.Position = float4(input.Position, depthRaw(depthMap, input.Position.xy));
    output.uv = input.uv;
    output.ViewDir = normalize(float3(f11, f12, ViewZ) - input.Position);
    output.Color = float4(1.0, 1.0, 1.0, 1.0);
    return output;
}


// Diffraction Grating Simulation Function
float3 DiffractionGrating(float3 incidentDir, float3 normal, float gratingSpacing)
{
    // Wavelengths for RGB channels (in meters)
    float3 wavelengths = RGB_WAVELENGTHS_M;

    // Compute the angle between the incident direction and the normal
    float cosThetaI = dot(incidentDir, normal);
    float thetaI = acos(cosThetaI);

    // Diffraction orders to consider
    int m = 1; // First-order diffraction

    /*The correct grating equation is:

    𝑑(sin𝜃𝑚−sin𝜃𝑖)=𝑚𝜆d(sinθ m −sinθ i)=mλ
       
        However, this might not make sense physically if sinThetaM becomes less than -1. Therefore, the correct calculation depends on the sign convention and whether the incident angle is on the same side as the diffracted angle. It's essential to carefully apply the grating equation based on the physical setup.
    */
    float3 sinThetaM = sin(thetaI) - m * wavelengths / gratingSpacing;
    // Handle total internal reflection cases
    sinThetaM = clamp(sinThetaM, -1.0, 1.0);

    float3 thetaM = asin(sinThetaM);

    // Compute the diffraction directions
    float3 diffractionDirX = incidentDir - normal * cosThetaI;
    diffractionDirX = normalize(diffractionDirX);

    float3 diffractionDirY = cross(normal, diffractionDirX);

    float3x3 rotationMatrix = float3x3(diffractionDirX, diffractionDirY, normal);

    float3 diffractionDirR = mul(rotationMatrix, float3(sin(thetaM.r), 0.0, cos(thetaM.r)));
    float3 diffractionDirG = mul(rotationMatrix, float3(sin(thetaM.g), 0.0, cos(thetaM.g)));
    float3 diffractionDirB = mul(rotationMatrix, float3(sin(thetaM.b), 0.0, cos(thetaM.b)));

    // Use the dot product with the view direction to get intensity
    float intensityR = saturate(dot(diffractionDirR, -incidentDir));
    float intensityG = saturate(dot(diffractionDirG, -incidentDir));
    float intensityB = saturate(dot(diffractionDirB, -incidentDir));

    return float3(intensityR, intensityG, intensityB);
}


float4 SimulateDiffractionWithAberration(HologramData hologramData, float2 uv, float3 wavelengthsM, float3 viewPos, float aberrationStrength)
{
    // Center the UV coordinates
    float2 centeredUV = uv - float2(0.5, 0.5);

    // Map UV coordinates to physical positions in meters
    float2 positionM = centeredUV * HOLOGRAM_SIZE_M;

    // Retrieve depth in meters from hologram data
    float depthM = hologramData.Pixel.z * HOLOGRAM_SIZE_M;

    // Position in 3D space
    float3 pointPosM = float3(positionM, depthM);

    // Observer position in meters (e.g., camera position)
    float3 observerPosM = viewPos * HOLOGRAM_SIZE_M;

    // Calculate the distance between the point and the observer
    float pathLengthM = length(pointPosM - observerPosM);

    // Introduce aberration: slightly modify path length for different wavelengths
    float3 aberratedPathLengthM = pathLengthM * (1.0 + aberrationStrength * (wavelengthsM - RGB_WAVELENGTHS_M.xyz));

    // Calculate the phase shift for each aberrated wavelength
    float3 phaseShift = (2.0 * PI * aberratedPathLengthM) / wavelengthsM;

    // Compute complex amplitudes
    float3 realPart = hologramData.Color * cos(phaseShift);
    float3 imagPart = hologramData.Color * sin(phaseShift);

    // Since we are interested in intensity, calculate magnitude squared
    float3 intensity = realPart * realPart + imagPart * imagPart;

    // Return the intensity with the original depth
    return float4(intensity, hologramData.Pixel.z);
}


float3 ApplyDepthOfFieldWithBokeh(Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float focusDepth, float maxBlur, Texture2D<float4> bokehShape)
{
    float sceneDepth = depthRaw(depthMap, uv);

    // Calculate blur amount based on depth difference
    float blurAmount = saturate(abs(sceneDepth - focusDepth) / (maxBlur + EPSILON));

    // Sample neighboring pixels based on blur amount and bokeh shape
    float3 color = float3(0.0, 0.0, 0.0);
    int samples = 32; // Increase sample count for smoother bokeh
    float totalWeight = 0.0;

    [loop]
    for (int i = 0; i < samples; i++)
    {
        float angle = (float) i / samples * 6.2831853; // 2*Pi
        float2 offset = blurAmount * float2(cos(angle), sin(angle)) * oosz;

        // Sample the bokeh shape texture
        float bokehValue = bokehShape.Sample(sampleTypeMirror, uv + offset).r;

        color += diffuseMap.Sample(sampleTypeMirror, uv + offset).rgb * bokehValue;
        totalWeight += bokehValue;
    }

    return color / (totalWeight + EPSILON);
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
    float3 color = float3(0.0, 0.0, 0.0);
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
                blurColor += tex.Sample(sampleTypeLinear, uv + offset).xyz * weight;
                totalWeight += weight;
            }
        }

        blurColor /= totalWeight;
        color = moilerp(color, max(minColor, blurColor), luminance * power);
    }

    return color;
}

float3 CombineHologramEffects(Texture2D<float4> bokehShape, float2 uv, float3 viewPos, float time, float aberrationStrength, float chromaticIntensity, float bloomDistance, float bloomThreshold, float3 minBloomColor, float3 bloomPower, float bloomSigma, float focusDepth, float maxBlur, float noiseScale, float noiseStrength, float anisotropy, float3 sunPos)
{
    float2 oosz = GetOosz(depthMap);

    // Retrieve base hologram data
    HologramData hologramData = GetHologramData(diffuseMap, depthMap, uv);

    // Reconstruct the hologram with aberration
    float3 wavelengthsM = nmToM(RGBToWavelengthsNM(mir2D(bokehShape, uv).xyz)); // Red, Green, Blue
    float4 reconstructedHologram = SimulateDiffractionWithAberration(hologramData, uv, wavelengthsM, viewPos, aberrationStrength);

    float depth = depthRaw(depthMap, uv);
    float filmThicknessM = 200e-9;
    float3 normal = CalcNormal(depthMap, uv);
    float3 viewDir = normalize(viewPos - float3(uv, depth));

    // Combine with Thin-Film Interference
    float3 interference = InterferenceM(filmThicknessM, normal, viewDir, wavelengthsM, 1.0, 1.75, f7);
    float3 combinedColor = reconstructedHologram.rgb * interference;

    // Apply Chromatic Aberration 
    float3 chromaticColor = ApplyChromaticAberration(oosz, diffuseMap, uv, chromaticIntensity);
    
    float cosTheta = max(dot(normal, viewDir), EPSILON);
    float3 fresnel = 1 - FresnelSchlick(float3(.04, .04, .04), float3(cosTheta, cosTheta, cosTheta), FresnelPower);
    float3 mylarColor = saturate(chromaticColor * fresnel);

    // Apply Additional Post-Processing Effects
    float3 iridescence = ApplyDynamicIridescence(uv, normal, nmToM(wavelengthsM), viewDir, time, noiseScale, noiseStrength);
    float3 bloom = ApplyAnisotropicBloom(diffuseMap, uv, bloomDistance, bloomThreshold, minBloomColor, bloomPower, bloomSigma, anisotropy);
    float3 dof = ApplyDepthOfFieldWithBokeh(gratingMap1, oosz, uv, focusDepth, maxBlur, bokehShape); // Assuming 'bokehShape' is a Texture2D

    // Final Color Composition
    float3 finalColor = saturate((combinedColor + mylarColor * iridescence + bloom) + dof);
    return finalColor;
}

// Example Function:  Combined Holographic Effects with Advanced Physics
float3 CombineHologramEffects_Advanced(float2 uv, float3 viewPos, float time, int gratingIndex,
    float aberrationStrength = 0.03, float chromaticIntensity = 0.1, float bloomDistance = 1.0,
    float bloomThreshold = 0.6, float3 minBloomColor = float3(0.2, 0.1, 0.05), float3 bloomPower = float3(1.2, 1.1, 1.0),
    float bloomSigma = 1.5, float focusDepth = 0.7, float maxBlur = 0.2, float noiseScale = 3.0,
    float noiseStrength = 0.2, float anisotropy = 0.3)
{
    // --- Texture Selection Based on gratingIndex ---
    Texture2D<float> gratingDepth = getGratingDepthMap(gratingIndex);
    Texture2D<float3> gratingNormal = getGratingNormalMap(gratingIndex);
    
    // ---  Calculate Basic Vectors and Values ---
    float2 oosz = GetOosz(depthMap);
    float depth = depthRaw(depthMap, uv);
    float3 normal = CalcNormal(depthMap, uv);
    float3 viewDir = normalize(viewPos - float3(uv, depth));

    // ---  Holographic and Physical Parameters ---
    
    // ---  Base wavelengths in meters ---
    float3 baseWavelengthsNM = RGBToWavelengthsNM(mir2D(diffuseMap, uv).xyz); // Red, Green, Blue

    // ---  Calculate Dispersion ---
  
    MaterialSellmeier material = CreateMaterial(MaterialIndex);
    
    float3 nFilmDispersed = SellmeierEquation(nmToM(baseWavelengthsNM), material);

    // ---  Calculate Interference ---
    float3 interferenceColor = InterferenceColorM_Advanced(material, normal, viewDir, RGB_WAVELENGTHS_M, time, ParallaxScale, ParallaxScaleOMD);
   
    // ---  Apply Other Effects ---
    float3 chromaticColor = ApplyChromaticAberration(oosz, diffuseMap, uv, chromaticIntensity);
    float3 bloomColor = ApplyAnisotropicBloom(diffuseMap, uv, bloomDistance, bloomThreshold, minBloomColor, bloomPower, bloomSigma, anisotropy);
    float3 dofColor = ApplyDepthOfFieldWithBokeh(gratingMap1, oosz, uv, focusDepth, maxBlur, rtMap1); // Use rtMap1 as bokeh shape
    float3 iridescenceColor = ApplyDynamicIridescence(uv, RGBToWavelengthsNM(chromaticColor), normal, viewDir, time, noiseScale, noiseStrength);

    // ---  Combine All Effects ---
    float3 finalColor = saturate(interferenceColor * 0.5 + // Blend interference
        chromaticColor * 0.8 + // Blend chromatic aberration
        bloomColor * 0.7 + // Blend bloom
        dofColor * 0.6 + // Blend depth of field
        iridescenceColor * 0.4 // Blend iridescence
    );

    return finalColor;
}

// Function to rotate a vector around an arbitrary axis using Rodrigues' rotation formula
float3 RotateVector(float3 v, float3 axis, float angle)
{
    axis = normalize(axis);
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
    source.direction = normalize(direction);
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
        
        float3 direction = normalize(float3(-cos(angle), cos(angle), depthRaw(depthMap, uv)));
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
float3 modulateEnergy(float3 energy, float time, float3 waveAmplitude)
{
    return energy * (1.0 + waveAmplitude * sin(time * 3.14159 * 2.0));
}


inline float3 ComputeDisplacement(float3 pixel, float3 wavelengths, float currentPhase, float strength)
{
    // Normalize wavelength to a range [400, 700] nm (visible spectrum)
    float3 normalizedWavelength = saturate((wavelengths - MIN_WAVELENGTHS) / WAVELENGTH_RANGES); // 400-700 nm
    
    // Calculate phase based on wavelength and time
    float3 phase = currentPhase + normalizedWavelength * CalculatePhaseShiftM(ComputePathDifferenceM(pixel), wavelengths, float3(1.75, 1.75, 1.75));
    
    // Compute displacement using sine wave for smooth animation
    float3 displacement = sin(phase) * strength * normalizedWavelength;
    
    // Determine direction based on wavelength (e.g., longer wavelengths disperse more to the right)
    // You can customize this based on desired effect
    float3 angle = lerp(-0.2f, 0.2f, normalizedWavelength); // Angle in radians
    
    return displacement * cos(angle);
}



// Function to calculate wavelength-dependent blur radius
float3 WavelengthDependentBlurRadius(float3 wavelengthsNM, float baseRadius)
{
    // Example: shorter wavelengths (blue) have smaller blur radii, longer (red) have larger
    float3 blurRadius = min(0.25, max(.015, baseRadius)) * float3((.170 * wavelengthsNM.r / RGB_WAVELENGTHS_MM.r), (.140 * wavelengthsNM.g / RGB_WAVELENGTHS_MM.g), (.120 * wavelengthsNM.b / RGB_WAVELENGTHS_MM.b));
    return blurRadius;
}

// Separable Gaussian Blur with Wavelength Dependency
float3 GaussianBlurWavelengthDependent(Texture2D<float4> tex, float2 uv, float3 blurRadius, float2 oosz)
{
    float3 color = float3(0.0, 0.0, 0.0);
    float3 totalWeight = float3(0.0, 0.0, 0.0);
    
    // Horizontal Blur
    [unroll]
    for (int i = -2; i <= 2; ++i)
    {
        float2 offset = float2(i * oosz.x * normalRadius, 0.0);
        float3 weight = exp(-pow(max(0.001, i / max(blurRadius, .001)), 2.0));
        float3 sample = lerp(tex.Sample(sampleTypeMirror, uv + offset).rgb, tex.Sample(sampleTypeMirror, uv - offset).rgb, depthRaw(depthMap, uv));
        color += sample * weight;
        totalWeight += weight;
    }
    
    // Normalize
    color /= max(totalWeight, float3(1e-6, 1e-6, 1e-6));
    
    // Vertical Blur
    float3 finalColor = float3(0.0, 0.0, 0.0);
    totalWeight = float3(0.0, 0.0, 0.0);
    [unroll]
    for (i = -2; i <= 2; ++i)
    {
        float2 offset = float2(0.0, i * oosz.y * normalRadius);
        float3 weight = exp(-pow(max(0.001, i / max(0.0025, blurRadius)), 2.0));
        float3 sample = lerp(tex.Sample(sampleTypeMirror, uv - offset).rgb, tex.Sample(sampleTypeMirror, uv + offset).rgb, float3(depthRaw(depthMap, uv), depthRaw(depthMap, uv), depthRaw(depthMap, uv)));
        finalColor += sample * min(.95, max(.05, weight));
        totalWeight += weight;
    }
    
    // Normalize
    finalColor = clamp(finalColor, 0.01, 0.99);
  
    return finalColor;
}
// Separable Gaussian Blur with Wavelength Dependency
float3 GaussianBlurWavelengthDependent(Texture2D<float> depthMap, Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float3 wavelengthNM, float3 blurRadius)
{
    float3 color = WavelengthsToRGB(wavelengthNM);
    float3 totalWeight = float3(0.0, 0.0, 0.0);
    
    // Horizontal Blur
    [unroll]
    for (int i = -2; i <= 2; ++i)
    {
        float depth = depthRaw(depthMap, uv);
        float2 offsetL =
            float2(-oosz.x * (i + 5) - noiseFastRange21(WAVELENGTH_RANGES.xy, float2(i * oosz.y, depth)),
                -oosz.y * (i + 7) - noiseFastRange21(WAVELENGTH_RANGES.xy, float2(i * oosz.x, depth)));
        float2 offsetR =
            float2(oosz.x * (i + 5) - noiseFastRange21(WAVELENGTH_RANGES.xy, float2(i * oosz.y, depth)),
                oosz.y * (i + 7) - noiseFastRange21(WAVELENGTH_RANGES.xy, float2(i * oosz.x, depth)));
        
        float3 weight = exp(-pow(max(0.001, i / max(blurRadius, .001)), 2.0));
        float3 sample = lerp(float3(diffuseMap.Sample(sampleTypeMirror, uv + offsetL).r,
                   diffuseMap.Sample(sampleTypeMirror, uv).g,
                   diffuseMap.Sample(sampleTypeMirror, uv + offsetR).b),
                   color, ((i + 2) / 5 + depth) / 2.0);
        color += sample * weight;
        totalWeight += weight;
    }
    
    // Normalize
    color /= max(totalWeight, float3(1e-6, 1e-6, 1e-6));
    
    // Vertical Blur
    float3 finalColor = float3(0.0, 0.0, 0.0);
    totalWeight = float3(0.0, 0.0, 0.0);
    [unroll]
    for (i = -2; i <= 2; ++i)
    {
        float2 offset = float2(0.0, i * oosz.y * normalRadius);
        float3 weight = exp(-pow(max(float3(0.01652, 0.00652, 0.01652), i / max(0.0025, blurRadius)), 2.0));
        float3 sample = lerp(mir2D(rtMap1, uv - offset - float2(i * 1e-3 * weight.x, -i * 1e-3 * weight.y)).rgb, mir2D(diffuseMap, uv + offset).rgb, mir2D(rtMap1, uv + offset + float2(i * 1e-3 * weight.x, -i * 1e-3 * weight.y)).rgb);
        finalColor += sample * min(.95, max(.05, weight));
        totalWeight += weight;
    }
    
    // Normalize
    finalColor = clamp(finalColor, 0.01, 0.99);
  
    return finalColor;
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
                              material.dispersionCoefficient * (1.0 / wavelengthNM - 1.0 / referenceWavelength);
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

// Main Pixel Shader Function with Chromatic Dispersion
float4 PS_Dispersion(PS_INPUT input) : SV_Target
{
    float2 uv = input.uv;
    
    // Sample depth and normal maps
    float depth = depthRaw(depthMap, uv);
    float3 normal = normalize(CalcNormal(depthMap, uv));
    
    // Calculate view direction
    float3 viewPos = float3(f11, f12, ViewZ);
    float3 viewDir = normalize(viewPos - float3(uv, depth));
    
    // Define light properties
    float3 lightPos = float3(f1, f2, SunZ);
    float3 lightDir = normalize(lightPos - float3(uv, depth));
    
    // Material properties for dispersion
    MaterialDispersion material;
    material.refractiveIndexBase = float3(1.52, 1.33, 1.55); // Example values for glass (R, G, B)
    material.dispersionCoefficient = float3(0.02, 0.01, 0.025); // Example dispersion coefficients
    
    // Define wavelengths for R, G, B in nm
    float3 wavelengthsNM = float3(700.0, 550.0, 450.0); // R, G, B wavelengths
    
    // Calculate frequencies from wavelengths
    float3 frequenciesHz = hzFromPeriod(periodFromWavelength(wavelengthsNM));
    
    // Calculate energies from frequencies
    float3 energies = energyFromHz(frequenciesHz);
    
    // Adjust refractive index based on wavelength
    float3 refractiveIndices = AdjustRefractiveIndex(wavelengthsNM, material);
    
    // Calculate refracted directions for each color channel
    float3 refractedDirs;
    refractedDirs.r = refract(-viewDir, normal, refractiveIndices.r / 1.0).r; // Assuming air (n=1.0)
    refractedDirs.g = refract(-viewDir, normal, refractiveIndices.g / 1.0).g;
    refractedDirs.b = refract(-viewDir, normal, refractiveIndices.b / 1.0).b;
    
    // Sample the diffuse color
    float3 baseColor = diffuseMap.Sample(sampleTypeMirror, uv).rgb;
    
    // Apply lighting (diffuse and specular) per channel
    float3 colorR = baseColor.r * max(dot(normal, lightDir), EPSILON) * (1.0 / refractiveIndices.r);
    float3 colorG = baseColor.g * max(dot(normal, lightDir), EPSILON) * (1.0 / refractiveIndices.g);
    float3 colorB = baseColor.b * max(dot(normal, lightDir), EPSILON) * (1.0 / refractiveIndices.b);
    
    // Combine the colors
    float3 finalColor = colorR + colorG + colorB;
    
    // Apply additional effects like chromatic aberration if desired
    finalColor *= ChromaticAberration(rtMap1, uv, 0.005);
    
    // Ensure the color is within [0,1] range
    finalColor = saturate(finalColor);
    
    return float4(finalColor, 1.0);
}
// Function to simulate interference based on photon energies and momenta
float3 SimulateInterference(float3 energies, float3 momenta, float3 phaseShifts)
{
    // Calculate the interference phase based on energies and momenta
    // For simplicity, assume phase shift is directly influenced by energy and momentum
    float3 interference = cos(phaseShifts + momenta * 1e-15); // Scale momentum to a manageable phase shift
    
    // Modulate interference with energies
    interference *= energies * 1e-19; // Scale energy to influence interference amplitude
    
    // Ensure interference remains within [0,1]
    interference = saturate(interference);
    
    return interference;
}

// Modified Pixel Shader Function with Interference
float4 PS_Interference(PS_INPUT input) : SV_Target
{
    float2 uv = input.uv;
    
    // Sample depth and normal maps
    float depth = depthRaw(depthMap, uv);
    float3 normal = normalize(CalcNormal(depthMap, uv));
    
    // Calculate view direction
    float3 viewPos = float3(f11, f12, ViewZ);
    float3 viewDir = normalize(viewPos - float3(uv, depth));
    
    // Define light properties
    float3 lightPos = float3(f1, f2, SunZ);
    float3 lightDir = normalize(lightPos - float3(uv, depth));
    
    // Material properties
    MaterialDispersion material;
    material.refractiveIndexBase = float3(1.52, 1.33, 1.55); // Example values
    material.dispersionCoefficient = float3(0.02, 0.01, 0.025);
    
    // Define wavelengths for R, G, B in nm
    float3 wavelengthsNM = float3(700.0, 550.0, 450.0); // R, G, B
    
    // Calculate frequencies from wavelengths
    float3 frequenciesHz = hzFromPeriod(periodFromWavelength(wavelengthsNM));
    
    // Calculate energies from frequencies
    float3 energies = energyFromHz(frequenciesHz);
    
    // Calculate momenta from energies
    float3 momenta = momentumFromEnergy(energies);
    
    // Adjust refractive index based on wavelength
    float3 refractiveIndices = AdjustRefractiveIndex(wavelengthsNM, material);
    
    // Calculate refracted directions for each color channel
    
    float3 refractedDirsR = refract(-viewDir, normal, refractiveIndices.r / 1.0); // Assuming air
    float3 refractedDirsG = refract(-viewDir, normal, refractiveIndices.g / 1.0);
    float3 refractedDirsB = refract(-viewDir, normal, refractiveIndices.b / 1.0);
    
    // Calculate phase shifts based on refracted directions
    float3 phaseShiftsR = angularFrequencyFromHz(frequenciesHz) * length(refractedDirsR);
    float3 interferenceR = SimulateInterference(energies, momenta, phaseShiftsR);
    
    float3 phaseShiftsG = angularFrequencyFromHz(frequenciesHz) * length(refractedDirsG);
    float3 interferenceG = SimulateInterference(energies, momenta, phaseShiftsG);
    
    float3 phaseShiftsB = angularFrequencyFromHz(frequenciesHz) * length(refractedDirsB);
    float3 interferenceB = SimulateInterference(energies, momenta, phaseShiftsB);
    
    // Sample the diffuse color
    float3 baseColor = diffuseMap.Sample(sampleTypeMirror, uv).rgb;
    
    // Apply lighting with interference modulation
    float3 color = baseColor * max(dot(normal, lightDir), EPSILON) * interferenceR;
    
    // Combine the colors
    float3 finalColor = color;
    
    // Apply post-processing effects
    finalColor *= ChromaticAberration(rtMap1, uv, 0.005);
    
    // Ensure the color is within [0,1] range
    finalColor = saturate(finalColor);
    
    return float4(finalColor, 1.0);
}
float3 PS_VortexGaussian(float2 uv, float3 viewDir, float time, float2 beamCenter, float beamWaist, float topologicalCharge, float rotationSpeed)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float3 intensity = gaussian3D(float3(uv - beamCenter, topologicalCharge + beamWaist - depthRaw(depthMap, uv)), float3(beamCenter.x - beamWaist * 2 * PI, beamCenter.y - beamWaist * 2 * PI, dot(beamCenter.xy, viewDir.xy) * beamWaist / 2));
    
    // Introduce helical phase based on topological charge
    float phase = topologicalCharge * theta + rotationSpeed * time;
    
    // Calculate complex amplitude
    float3 real = intensity * cos(phase);
    float3 imag = intensity * sin(phase);
    
    // Combine into RGB channels (using real and imaginary parts for color encoding)
    float3 color = float3(addOver03(float3(real.r, imag.r, 1 - (real.r + imag.r))),
        addOver03(float3(real.g, imag.g, 1 - (real.g + imag.g))),
        addOver03(float3(real.b, imag.b, 1 - (real.b + imag.b))));
    return color;
}

inline float nonlinearPhase(float intensity, float kappa)
{
    return kappa * intensity;
}
float3 PS_OpticalVorticesGaussian(float2 uv,
    float time,
    float2 beamCenter1,
    float beamWaist1,
    int topologicalCharge1,
    float rotationSpeed1,
    float2 beamCenter2,
    float beamWaist2,
    int topologicalCharge2,
    float rotationSpeed2
)
{
    // Normalize UV coordinates relative to beam centers
    float2 centeredUV1 = (uv - beamCenter1) * 2.0;
    float2 centeredUV2 = (uv - beamCenter2) * 2.0;
    
    // Convert to polar coordinates for Beam 1
    float r1 = length(centeredUV1);
    float theta1 = atan2(centeredUV1.y, centeredUV1.x);
    
    // Convert to polar coordinates for Beam 2
    float r2 = length(centeredUV2);
    float theta2 = atan2(centeredUV2.y, centeredUV2.x);
    
    // Apply Gaussian intensity profiles
    float intensity1 = gaussian(r1, beamWaist1);
    float intensity2 = gaussian(r2, beamWaist2);
    
    // Introduce helical phase based on topological charge and rotation speed
    float phase1 = topologicalCharge1 * theta1 + rotationSpeed1 * time;
    float phase2 = topologicalCharge2 * theta2 + rotationSpeed2 * time;
    
    // Calculate complex amplitudes with spiral phases
    float real1 = intensity1 * cos(phase1);
    float imag1 = intensity1 * sin(phase1);
    
    float real2 = intensity2 * cos(phase2);
    float imag2 = intensity2 * sin(phase2);
    
    // Combine into RGB channels (using real and imaginary parts for color encoding)
    // Beam 1: Red and Green channels
    float3 color1 = float3(real1, imag1, 0.0);
    
    // Beam 2: Green and Blue channels
    float3 color2 = float3(0.0, real2, imag2);
    
    // Combine both beams
    float3 combinedColor = color1 + color2;
    
    // Normalize and clamp the color
    combinedColor = saturate(combinedColor);
    
    return combinedColor;
}
float3 PS_NonlinearPhaseGaussian(float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float kappa // Nonlinear coefficient
)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate nonlinear phase shift based on local intensity
    float phaseShift = nonlinearPhase(intensity, kappa);
    
    // Apply phase modulation (e.g., temporal variation)
    float phase = phaseShift + sin(time + theta) * 0.5;
    
    // Calculate complex amplitude with nonlinear phase
    float real = intensity * cos(phase);
    float imag = intensity * sin(phase);
    
    // Create interference by combining original and phase-shifted amplitudes
    float3 interference = float3(real + intensity * cos(phaseShift),
        imag + intensity * sin(phaseShift),
        0.0
    );
    
    return interference;
}
float3 PS_BirefringentGaussian(float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float2 opticalAxis, // Unit vector defining the optical axis
    float n_o, // Refractive index for ordinary ray
    float n_e // Refractive index for extraordinary ray
)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Determine beam polarization angle relative to optical axis
    float polarizationAngle = theta; // For simplicity, align polarization with beam angle
    
    // Calculate polarization vectors
    float2 polarization_o = float2(-opticalAxis.y, opticalAxis.x); // Perpendicular to optical axis
    float2 polarization_e = opticalAxis; // Parallel to optical axis
    
    // Project polarization onto beam direction
    float dot_o = dot(polarization_o, centeredUV) / (r + 1e-6);
    float dot_e = dot(polarization_e, centeredUV) / (r + 1e-6);
    
    // Calculate amplitudes for o-ray and e-ray
    float amplitude_o = intensity * abs(dot_o);
    float amplitude_e = intensity * abs(dot_e);
    
    // Calculate refracted directions using Snell's Law
    float eta_o = 1.0 / n_o; // Assuming air to medium
    float eta_e = 1.0 / n_e;
    
    float2 normal = float2(0.0, 1.0); // Assuming horizontal interface
    
    float2 refractedDir_o = refract(-normalize(centeredUV), normal, eta_o);
    float2 refractedDir_e = refract(-normalize(centeredUV), normal, eta_e);
    
    // Offset positions based on refracted directions
    float2 offset_o = refractedDir_o * r * 0.05;
    float2 offset_e = refractedDir_e * r * 0.05;
    
    // Calculate intensity for each ray after refraction
    float intensity_o = amplitude_o * gaussian(length(centeredUV + offset_o), beamWaist);
    float intensity_e = amplitude_e * gaussian(length(centeredUV + offset_e), beamWaist);
    
    // Assign colors to each ray (e.g., o-ray: blue, e-ray: red)
    float3 color_o = float3(0.0, 0.0, 1.0) * intensity_o;
    float3 color_e = float3(1.0, 0.0, 0.0) * intensity_e;
    
    // Combine the two rays
    float3 finalColor = color_o + color_e;
    
    // Normalize and clamp the color
    finalColor = saturate(finalColor);
    
    return finalColor;
}
float3 PS_WavefrontDistortedGaussian(float2 uv, float time, float2 beamCenter, float beamWaist, float turbulenceScale, float turbulenceIntensity, float turbulenceSpeed, float beamDivergence)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float2 r = centeredUV;
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float2 intensity = 1 - gaussian(r.x, beamWaist) + gaussian(r.y, beamWaist);
    
    // Generate wavefront distortion using noise
    float2 turbulencePos = centeredUV * turbulenceScale;
    float2 distortion = turbulenceIntensity * noiseFast11(turbulencePos + float2(turbulenceSpeed * time, turbulenceSpeed * time));
    
    // Apply distortion to phase
    float2 phase = beamDivergence * r + distortion;
    
    // Calculate complex amplitude with distorted phase
    float2 real = intensity * cos(phase);
    float2 imag = intensity * sin(phase);
    
    // Combine into RGB channels (using real and imaginary parts for color encoding)
    float3 color = AddOver0(float3(real.x, imag.x, 0.0), // Blue channel can represent imaginary part
        float3(real.y, imag.y, 0.0),
        float3(1 - real.x, 1 - imag.y, 0.0));
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
// Pixel Shader: Gaussian Beam with Dynamic Polarization
float3 PS_DynamicPolarizationGaussian(float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float polarizationRotationSpeed,
    float initialPolarizationAngle
)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate dynamic polarization angle
    float polarizationAngle = initialPolarizationAngle + polarizationRotationSpeed * time;
    
    // Create initial color based on intensity (e.g., white beam)
    float3 color = float3(intensity, intensity, intensity);
    
    // Rotate polarization
    color = rotatePolarization(color, polarizationAngle);
    
    // Optionally modulate intensity based on polarization (e.g., simulate Malus's Law)
    // Here, we simply apply the rotated color
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
// Utility Function: Refract Direction Based on Refractive Index
inline float2 refractDir(float2 incident, float2 normal, float eta)
{
    float cosi = clamp(dot(incident, normal), -1.0, 1.0);
    float cost2 = 1.0 - eta * eta * (1.0 - cosi * cosi);
    if (cost2 < 0)
        return float2(0.0, 0.0); // Total internal reflection
    return eta * incident - (eta * cosi + sqrt(cost2)) * normal;
}

// Pixel Shader: Gaussian Beam with Chromatic Dispersion
float3 PS_ChromaticDispersionGaussian(float2 uv,
    float depth,
    float time,
    float2 beamCenter,
    float beamWaist,
    float3 wavelengthNM, // RGB wavelengths in nm
    float3 B, float3 C // Sellmeier coefficients for RGB
)
{
    // Normalize UV coordinates relative to beam center
    float3 centeredUV = float3((uv - beamCenter) * 2.0, depth);
    
    // Calculate refractive index for each wavelength using Sellmeier equation
    float3 refractiveIndices = float3(SellmeierEquation(wavelengthNM.x, B.x, B.y, B.z, C.x, C.y, C.z).x,
        SellmeierEquation(wavelengthNM.y, B.x, B.y, B.z, C.x, C.y, C.z).y,
        SellmeierEquation(wavelengthNM.z, B.x, B.y, B.z, C.x, C.y, C.z).z
    );
    // Apply Gaussian intensity profile
    float3 intensity = 1 - gaussian3D(float3(uv * refractiveIndices.xy, depthRaw(depthMap, uv) * refractiveIndices.z), beamWaist * refractiveIndices.z);
    
    
    // Define incident beam direction (e.g., coming from top)
    float2 incidentDir = normalize((uv - float2(0.5, 0.5)));
    
    // Define surface normal (e.g., flat surface)
    float3 normal = CalcNormal(depthMap, uv);
    
    float rdx = refractDir(incidentDir, normal.yz, 1.0 / refractiveIndices.x).x;
    float rdy = refractDir(incidentDir, normal.xz, 1.0 / refractiveIndices.y).y;
    float rdz = 1 - (rdx + rdy);
    
    // Calculate refracted directions for each wavelength
    float3 refractedDirs = float3(rdx, rdy, rdz);
    
    float3 offset = refractedDirs * 0.1;
    
    // Calculate intensity for each color channel
    float3 channelIntensity = intensity * gaussian3D(centeredUV + offset, float3(beamWaist * 2 * PI, beamWaist * 2, beamWaist * 2 * PI));
    
    
    // Assign colors based on intensities
    float3 color = moilerp(channelIntensity, (1 - channelIntensity), .75);
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}


// Pixel Shader: Gaussian Beam with Spiral Phase Plate (Optical Vortex)
float3 PS_SpiralPhasePlateGaussian(float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    int topologicalCharge, // Number of phase twists
    float rotation
)
{
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Convert to polar coordinates
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Apply spiral phase modulation
    float spiralPhase = topologicalCharge * theta + rotation;
    
    // Calculate complex amplitude with spiral phase
    float real = intensity * cos(spiralPhase);
    float imag = intensity * sin(spiralPhase);
    
    // Combine into RGB channels (using real and imaginary parts for color encoding)
    float3 color = float3(real, imag, intensity * (1 - (real + imag))); // Blue channel represents imaginary part
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
inline float2 applyRipple(float2 uv, float depth, float frequency, float amplitude)
{
    float ripple = sin(depth * frequency + amplitude);
    return uv + float2(ripple, ripple);
}
float3 PS_DepthRippleGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float rippleFrequency,
    float rippleAmplitude
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Apply ripple distortion based on depth
    float2 distortedUV = applyRipple(uv, depth, rippleFrequency, rippleAmplitude);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Assign color (e.g., cyan beam)
    float3 color = float3(0.0, 1.0, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
inline float2 calculateRefraction(float2 uv, float2 beamCenter, float beamWaist, float refractionStrength)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = normalize(centeredUV) * refractionStrength;
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


float3 PS_DepthShadowGaussian(Texture2D<float> depthMap,
    float2 uv,
    
    float time,
    float2 beamCenter,
    float beamWaist,
    float shadowIntensity,
    float shadowRadius
)
{
    float depth = depthRaw(depthMap, uv);
    // Initialize shadow factor
    float shadowFactor = 1.0;
    
    // Sample surrounding depths within shadow radius
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 sampleUV = uv + float2(x, y) * shadowRadius;
            float sampleDepth = depthRaw(depthMap, sampleUV);
            shadowFactor *= calculateShadow(depth, sampleDepth, shadowIntensity);
        }
    }
    
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with shadow factor
    float intensity = gaussian(r, beamWaist) * shadowFactor;
    
    // Assign color (e.g., magenta beam)
    float3 color = float3(1.0, 0.0, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}



float3 PS_DepthRefractionGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float refractionStrength
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Calculate refraction offset based on depth gradient
    float2 refractionOffset = calculateRefraction(uv, beamCenter, beamWaist, refractionStrength * depth);
    
    // Apply refraction offset to UV coordinates
    float2 refractedUV = uv + refractionOffset;
    
    // Normalize refracted UV coordinates relative to beam center
    float2 centeredUV = (refractedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Assign color (e.g., yellow beam)
    float3 color = float3(1.0, 1.0, 0.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Utility Function: Calculate Glow Based on Depth Proximity
inline float calculateGlow(float2 uv, float2 beamCenter, float depth, float glowRadius)
{
    float distance = length(uv - beamCenter);
    return distance < glowRadius ? smoothstep(glowRadius, glowRadius - 0.05, distance) : 0.0;
}

// Pixel Shader: Depth Glow Gaussian Beam
float3 PS_DepthGlowGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float glowRadius,
    float glowIntensity
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Calculate glow factor based on depth proximity
    float glowFactor = calculateGlow(uv, beamCenter, depth, glowRadius) * glowIntensity;
    
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Assign base color (e.g., orange beam)
    float3 baseColor = float3(1.0, 0.5, 0.0) * intensity;
    
    // Apply glow effect
    float3 glowColor = float3(1.0, 1.0, 0.0) * glowFactor;
    
    // Combine base color with glow
    float3 color = baseColor + glowColor;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
inline float2 applyLensDistortion(float2 uv, float depth, float lensStrength, float lensRadius)
{
    float distance = length(uv);
    if (distance > lensRadius)
        return uv;
    float factor = lensStrength * (1.0 - distance / lensRadius) * depth;
    return uv + normalize(uv) * factor;
}

// Pixel Shader: Depth-Based Dynamic Lensing Gaussian Beam
float3 PS_DynamicLensingGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float lensStrength,
    float lensRadius
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Apply lens distortion based on depth
    float2 distortedUV = applyLensDistortion(uv - beamCenter, depth, lensStrength, lensRadius);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = distortedUV * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Assign color (e.g., blue beam)
    float3 color = float3(0.0, 0.0, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Utility Function: Apply Volumetric Scattering Based on Depth
inline float applyVolumetricScattering(float depth, float scatterIntensity, float scatterScale)
{
    return 1.0 - exp(-scatterIntensity * depth * scatterScale);
}

// Pixel Shader: Depth-Based Volumetric Scattering Gaussian Beam
float3 PS_VolumetricScatteringGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float scatterIntensity,
    float scatterScale
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Calculate scattering factor based on depth
    float scatterFactor = applyVolumetricScattering(depth, scatterIntensity, scatterScale);
    
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with scattering
    float intensity = gaussian(r, beamWaist) * scatterFactor;
    
    // Assign color (e.g., green beam)
    float3 color = float3(0.0, 1.0, 0.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
inline float generateCaustics(float2 uv, float2 beamCenter, float beamWaist, float causticFrequency, float causticIntensity)
{
    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    return sin(causticFrequency * r) * exp(-pow(r / beamWaist, 2.0)) * causticIntensity;
}

// Pixel Shader: Depth-Based Caustics Gaussian Beam
float3 PS_CausticsGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float causticFrequency,
    float causticIntensity
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Generate caustic pattern influenced by depth
    float caustics = generateCaustics(uv, beamCenter, beamWaist, causticFrequency, causticIntensity) * depth;
    
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with caustics
    float intensity = gaussian(r, beamWaist) + caustics;
    
    // Assign color (e.g., orange beam)
    float3 color = float3(1.0, 0.5, 0.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}
inline float3 applyHolographicInterference(float2 uv, float2 beamCenter, float beamWaist, float hologramDepth, float hologramScale)
{
    float2 centeredUV = (uv - beamCenter) * hologramScale;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    float interference = sin(2.0 * PI * hologramDepth * r + theta * 5.0);
    float intensity = gaussian(r, beamWaist) * interference;
    return float3(intensity, intensity, intensity);
}

float3 PS_HolographicInterferenceGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float hologramDepth,
    float hologramScale
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Apply holographic interference influenced by depth
    float3 interferenceColor = applyHolographicInterference(uv, beamCenter, beamWaist, hologramDepth, hologramScale) * depth;
    
    // Normalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with interference
    float intensity = gaussian(r, beamWaist) + interferenceColor.r; // Using red channel for simplicity
    
    // Assign color (e.g., violet beam)
    float3 color = float3(0.5, 0.0, 0.5) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 1: Depth-Based Dynamic Lensing and Ripple Effect Gaussian Beam
float3 PS_DynamicLensingRippleGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float lensStrength,
    float lensRadius,
    float rippleFrequency,
    float rippleAmplitude
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Apply lens distortion based on depth
    float2 distortedUV = applyRipple(uv - beamCenter, depth, rippleFrequency, rippleAmplitude);
    distortedUV = applyRipple(distortedUV, depth, rippleFrequency, rippleAmplitude); // Double ripple for effect
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = distortedUV * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Apply lens distortion factor
    float2 lensDistortion = calculateRefraction(uv, beamCenter, beamWaist, lensStrength * depth);
    centeredUV += lensDistortion;
    
    // Recalculate radial distance after distortion
    r = length(centeredUV);
    intensity = gaussian(r, beamWaist);
    
    // Assign color (e.g., blue-green beam)
    float3 color = float3(0.0, 0.7, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 2: Combined Depth Shadow, Refraction, and Volumetric Scattering Gaussian Beam
float3 PS_ShadowRefractionScatteringGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float shadowIntensity,
    float shadowRadius,
    float refractionStrength,
    float scatterIntensity,
    float scatterScale
)
{
    // Sample current depth
    float currentDepth = depthRaw(depthMap, uv);
    
    // Initialize shadow factor
    float shadowFactor = 1.0;
    
    // Sample surrounding depths within shadow radius
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 sampleUV = uv + float2(x, y) * shadowRadius;
            float sampleDepth = depthRaw(depthMap, sampleUV);
            shadowFactor *= calculateShadow(currentDepth, sampleDepth, shadowIntensity);
        }
    }
    
    // Calculate refraction offset based on depth gradient
    float2 refractionOffset = calculateRefraction(uv, beamCenter, beamWaist, refractionStrength * currentDepth);
    
    // Apply refraction offset to UV coordinates
    float2 refractedUV = uv + refractionOffset;
    
    // Normalize refracted UV coordinates relative to beam center
    float2 centeredUV = (refractedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with shadow factor
    float intensity = gaussian(r, beamWaist) * shadowFactor;
    
    // Apply volumetric scattering based on depth
    float scatterFactor = 1.0 - exp(-scatterIntensity * currentDepth * scatterScale);
    intensity *= scatterFactor;
    
    // Assign color (e.g., magenta with scattering)
    float3 color = float3(1.0, 0.0, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 3: Combined Depth Caustics, Holographic Interference, and Refraction Gaussian Beam
float3 PS_CausticsHolographicRefractionGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float causticFrequency,
    float causticIntensity,
    float hologramDepth,
    float hologramScale,
    float refractionStrength,
    float hologramIntensity
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Generate caustic pattern influenced by depth
    float caustics = sin(causticFrequency * length(uv - beamCenter)) * exp(-pow(length(uv - beamCenter) / beamWaist, 2.0)) * causticIntensity * depth;
    
    // Generate holographic interference pattern
    float3 interference = sin(2.0 * PI * hologramDepth * length(uv - beamCenter) + atan2(uv.y - beamCenter.y, uv.x - beamCenter.x) * 5.0) * exp(-pow(length(uv - beamCenter) / beamWaist, 2.0)) * hologramIntensity;
    
    // Combine caustics and interference
    float combinedEffect = caustics + interference.r; // Using red channel for simplicity
    
    // Calculate refraction offset based on combined effects
    float2 refractionOffset = calculateRefraction(uv, beamCenter, beamWaist, refractionStrength * combinedEffect);
    
    // Apply refraction offset to UV coordinates
    float2 refractedUV = uv + refractionOffset;
    
    // Normalize refracted UV coordinates relative to beam center
    float2 centeredUV = (refractedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with combined effects
    float intensity = gaussian(r, beamWaist) + combinedEffect;
    
    // Assign color (e.g., violet with interference)
    float3 color = float3(0.5, 0.0, 0.5) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 4: Advanced Depth-Based Dynamic Lensing, Shadows, Scattering, Caustics, and Holographic Interference Gaussian Beam
float3 PS_AdvancedCombinedEffectsGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float lensStrength,
    float lensRadius,
    float rippleFrequency,
    float rippleAmplitude,
    float shadowIntensity,
    float shadowRadius,
    float refractionStrength,
    float scatterIntensity,
    float scatterScale,
    float causticFrequency,
    float causticIntensity,
    float hologramDepth,
    float hologramScale
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Apply lens distortion based on depth
    float2 distortedUV = applyRipple(uv - beamCenter, depth, rippleFrequency, rippleAmplitude);
    distortedUV = applyRipple(distortedUV, depth, rippleFrequency, rippleAmplitude); // Double ripple for effect
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = distortedUV * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Apply lens distortion factor
    float2 lensDistortion = calculateRefraction(uv, beamCenter, beamWaist, lensStrength * depth);
    centeredUV += lensDistortion;
    
    // Recalculate radial distance after distortion
    r = length(centeredUV);
    intensity = gaussian(r, beamWaist);
    
    // Initialize shadow factor
    float shadowFactor = 1.0;
    
    // Sample surrounding depths within shadow radius
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 sampleUV = uv + float2(x, y) * shadowRadius;
            float sampleDepth = depthRaw(depthMap, sampleUV);
            shadowFactor *= calculateShadow(depth, sampleDepth, shadowIntensity);
        }
    }
    
    // Apply shadow factor
    intensity *= shadowFactor;
    
    // Apply volumetric scattering based on depth
    float scatterFactor = 1.0 - exp(-scatterIntensity * depth * scatterScale);
    intensity *= scatterFactor;
    
    // Generate caustic pattern influenced by depth
    float caustics = sin(causticFrequency * r) * exp(-pow(r / beamWaist, 2.0)) * causticIntensity * depth;
    
    // Generate holographic interference pattern
    float3 interference = sin(2.0 * PI * hologramDepth * r + atan2(centeredUV.y, centeredUV.x) * 5.0) * exp(-pow(r / beamWaist, 2.0)) * 1.0;
    
    // Combine caustics and interference
    float combinedEffect = caustics + interference.r; // Using red channel for simplicity
    
    // Calculate refraction offset based on combined effects
    float2 combinedRefractionOffset = calculateRefraction(uv, beamCenter, beamWaist, refractionStrength * combinedEffect);
    
    // Apply combined refraction offset to UV coordinates
    float2 finalRefractedUV = uv + combinedRefractionOffset;
    
    // Normalize final refracted UV coordinates relative to beam center
    float2 finalCenteredUV = (finalRefractedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float finalR = length(finalCenteredUV);
    
    // Apply Gaussian intensity profile with combined effects
    float finalIntensity = gaussian(finalR, beamWaist) + combinedEffect;
    
    // Assign color (e.g., combination of blue, magenta, and violet)
    float3 baseColor = float3(0.0, 0.0, 1.0); // Blue
    float3 causticColor = float3(1.0, 0.0, 1.0); // Magenta
    float3 interferenceColor = float3(0.5, 0.0, 0.5); // Violet
    
    // Combine colors based on effects
    float3 color = baseColor * intensity + causticColor * caustics + interferenceColor * interference.r;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
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
    float2 gradient = normalize(centeredUV) * refractionStrength;
    float depth = depthRaw(depthMap, uv);
    return gradient * depth;
}

// Pixel Shader 1: Depth-Based Volumetric Scattering and Shadow Gaussian Beam
float3 PS_DepthVolumetricScatteringShadowGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float shadowIntensity,
    float shadowRadius,
    float scatterIntensity,
    float scatterScale
)
{
    // Apply ripple distortion based on depth
    float2 distortedUV = applyRipple(depthMap, uv, 10.0, 5.0);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate shadow factor
    float shadowFactor = calculateShadow(depthMap, distortedUV, shadowIntensity, shadowRadius);
    
    // Apply volumetric scattering based on depth
    float scatterFactor = 1.0 - exp(-scatterIntensity * depthRaw(depthMap, distortedUV) * scatterScale);
    intensity *= scatterFactor * shadowFactor;
    
    // Assign color (e.g., cyan beam)
    float3 color = float3(0.0, 1.0, 1.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 2: Multi-Vortex Interference Gaussian Beam with Depth Influence
float3 PS_MultiVortexInterferenceGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    int numVortices,
    float rotationSpeed,
    float vortexStrength
)
{
    float3 finalColor = float3(0.0, 0.0, 0.0);
    
    for (int i = 0; i < numVortices; i++)
    {
        // Calculate vortex position with rotation
        float angle = rotationSpeed * time + (2.0 * PI * i) / numVortices;
        float2 offset = float2(cos(angle), sin(angle)) * (beamWaist * 1.5);
        float2 vortexCenter = beamCenter + offset;
        
        // Normalize UV coordinates relative to vortex center
        float2 centeredUV = (uv - vortexCenter) * 2.0;
        
        // Calculate radial and angular distance
        float r = length(centeredUV);
        float theta = atan2(centeredUV.y, centeredUV.x);
        
        // Apply Gaussian intensity profile
        float intensity = gaussian(r, beamWaist);
        
        // Introduce helical phase based on vortex strength
        float phase = vortexStrength * theta + rotationSpeed * time;
        
        // Calculate complex amplitude
        float real = intensity * cos(phase);
        float imag = intensity * sin(phase);
        
        // Combine into RGB channels (using real and imaginary parts for color encoding)
        float3 color = float3(real, imag, 0.0); // Blue channel represents imaginary part
        
        // Accumulate color
        finalColor += color;
    }
    
    // Normalize and clamp the final color
    finalColor = saturate(finalColor);
    
    return finalColor;
}

// Pixel Shader 3: Holographic Refraction and Interference Gaussian Beam with Depth-Based Caustics
float3 PS_HolographicRefractionInterferenceGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float hologramDepth,
    float hologramScale,
    float refractionStrength,
    float causticFrequency,
    float causticIntensity
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Generate holographic interference pattern influenced by depth
    float3 interference = sin(2.0 * PI * hologramDepth * length(uv - beamCenter) + atan2(uv.y - beamCenter.y, uv.x - beamCenter.x) * 5.0) * exp(-pow(length(uv - beamCenter) / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depth;
    
    // Calculate refraction offset based on interference
    float2 refractionOffset = calculateRefraction(depthMap, uv, beamCenter, beamWaist, refractionStrength * interference.r);
    
    // Apply refraction offset to UV coordinates
    float2 refractedUV = uv + refractionOffset;
    
    // Normalize refracted UV coordinates relative to beam center
    float2 centeredUV = (refractedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with interference
    float intensity = gaussian(r, beamWaist) + interference.r;
    
    // Assign color (e.g., violet beam)
    float3 color = float3(0.5, 0.0, 0.5) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 4: Adaptive Caustic Optical Effects Gaussian Beam with Depth Feedback
float3 PS_AdaptiveCausticOpticsGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float causticFrequency,
    float causticIntensity,
    float adaptiveStrength,
    float adaptiveScale
)
{
    // Sample surrounding depth
    float depth = depthRaw(depthMap, uv);
    
    // Generate caustic pattern influenced by depth
    float caustics = sin(causticFrequency * length(uv - beamCenter)) * exp(-pow(length(uv - beamCenter) / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depth;
    
    // Calculate adaptive offset based on caustics and depth feedback
    float2 adaptiveOffset = normalize(uv - beamCenter) * caustics * adaptiveStrength;
    float2 finalUV = uv + adaptiveOffset * adaptiveScale;
    
    // Normalize final UV coordinates relative to beam center
    float2 centeredUV = (finalUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile with caustics
    float intensity = gaussian(r, beamWaist) + caustics;
    
    // Assign color (e.g., orange-red beam)
    float3 color = float3(1.0, 0.5, 0.0) * intensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}


// Utility Function: Apply Complex Ripple Distortion Based on Depth and Time
inline float2 applyComplexRipple(Texture2D<float> depthMap, float2 uv, float time, float frequency, float amplitude, float speed)
{
    float depth = depthRaw(depthMap, uv);
    float ripple = sin(depth * frequency + speed * time) * amplitude;
    return uv + float2(ripple, ripple * 0.5);
}


// Utility Function: Calculate Refraction Offset Based on Depth Gradient and Time
inline float2 calculateDynamicRefraction(Texture2D<float> depthMap, float2 uv, float2 beamCenter, float beamWaist, float refractionStrength, float time)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = normalize(centeredUV) * refractionStrength * sin(time);
    float depth = depthRaw(depthMap, uv);
    return gradient * depth;
}

// Utility Function: Generate Caustic Patterns Based on Depth and Beam Position
inline float generateDynamicCaustics(Texture2D<float> depthMap, float2 uv, float2 beamCenter, float beamWaist, float causticFrequency, float causticIntensity, float time)
{
    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);
    return sin(causticFrequency * r + time) * exp(-pow(r / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depthRaw(depthMap, uv);
}

// Pixel Shader 1: Exotic Depth-Based Dynamic Lensing and Caustics Gaussian Beam
float3 PS_ExoticDynamicLensingCausticsGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float lensStrength,
    float lensRadius,
    float causticFrequency,
    float causticIntensity
)
{
    // Apply complex ripple distortion based on depth and time
    float2 distortedUV = applyComplexRipple(depthMap, uv, time, 10.0, 0.02, 1.5);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate shadow factor
    float shadowFactor = calculateShadow(depthMap, distortedUV, 0.7, 0.05);
    
    // Calculate dynamic refraction offset
    float2 refractionOffset = calculateDynamicRefraction(depthMap, distortedUV, beamCenter, beamWaist, 0.1, time);
    
    // Apply refraction offset
    float2 refractedUV = uv + refractionOffset;
    
    // Recalculate centered UV after refraction
    float2 finalCenteredUV = (refractedUV - beamCenter) * 2.0;
    float finalR = length(finalCenteredUV);
   
    // Apply Gaussian intensity profile with shadow
    float3 finalIntensity = gaussian3D(float3(finalR * .5, finalR * 1.5, finalR * .5), beamWaist);
    // Generate dynamic caustics based on depth and beam position
    float caustics = generateDynamicCaustics(depthMap, refractedUV, beamCenter, beamWaist, causticFrequency, causticIntensity, time);
    
    // Combine intensity with caustics
    float3 totalIntensity = finalIntensity + caustics;
    
    // Assign color (e.g., vibrant cyan)
    float3 color = float3(0.0, 1.0, 1.0) * totalIntensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 2: Vivid Multi-Layered Depth Interaction Gaussian Beam
float3 PS_VividMultiLayerDepthGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float rippleFrequency,
    float rippleAmplitude,
    float shadowIntensity,
    float shadowRadius,
    float refractionStrength,
    float scatterIntensity,
    float scatterScale,
    float causticFrequency,
    float causticIntensity
)
{
    // Apply complex ripple distortion based on depth and time
    float2 distortedUV = applyComplexRipple(depthMap, uv, time, rippleFrequency, rippleAmplitude, 2.0);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate shadow factor
    float shadowFactor = calculateShadow(depthMap, distortedUV, shadowIntensity, shadowRadius);
    
    // Apply shadow factor to intensity
    intensity *= shadowFactor;
    
    // Calculate dynamic refraction offset
    float2 refractionOffset = calculateDynamicRefraction(depthMap, distortedUV, beamCenter, beamWaist, refractionStrength, time);
    
    // Apply refraction offset
    float2 refractedUV = uv + refractionOffset;
    
    // Recalculate centered UV after refraction
    float2 finalCenteredUV = (refractedUV - beamCenter) * 2.0;
    float finalR = length(finalCenteredUV);
    
    // Apply Gaussian intensity profile with shadow
    float finalIntensity = gaussian(finalR, beamWaist) * shadowFactor;
    
    // Apply volumetric scattering based on depth
    float scatterFactor = 1.0 - exp(-scatterIntensity * depthRaw(depthMap, refractedUV) * scatterScale);
    finalIntensity *= scatterFactor;
    
    // Generate dynamic caustics based on depth and beam position
    float caustics = sin(causticFrequency * finalR - time) * exp(-pow(finalR / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depthRaw(depthMap, refractedUV);
    
    // Combine intensity with caustics
    float totalIntensity = finalIntensity + caustics;
    
    // Assign color (e.g., vivid magenta)
    float3 color = float3(1.0, 0.0, 1.0) * totalIntensity;
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 3: Exotic Holographic Interference and Dynamic Lensing Gaussian Beam
float3 PS_ExoticHolographicInterferenceLensingGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float hologramDepth,
    float hologramScale,
    float lensStrength,
    float lensRadius,
    float interferenceFrequency,
    float interferenceIntensity
)
{
    // Apply complex ripple distortion based on depth and time
    float2 distortedUV = applyComplexRipple(depthMap, uv, time, 15.0, 0.03, 3.0);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate shadow factor
    float shadowFactor = calculateShadow(depthMap, distortedUV, 0.6, 0.07);
    
    // Apply shadow factor to intensity
    intensity *= shadowFactor;
    
    // Calculate dynamic refraction offset
    float2 refractionOffset = calculateDynamicRefraction(depthMap, distortedUV, beamCenter, beamWaist, lensStrength, time);
    
    // Apply refraction offset
    float2 refractedUV = uv + refractionOffset;
    
    // Recalculate centered UV after refraction
    float2 finalCenteredUV = (refractedUV - beamCenter) * 2.0;
    float finalR = length(finalCenteredUV);
    
    // Apply Gaussian intensity profile with shadow
    float finalIntensity = gaussian(finalR, beamWaist) * shadowFactor;
    
    // Generate holographic interference pattern influenced by depth
    float interference = sin(interferenceFrequency * finalR + time) * exp(-pow(finalR / max(beamWaist, EPSILON), 2.0)) * interferenceIntensity * depthRaw(depthMap, refractedUV);
    
    // Generate holographic interference pattern
    float3 holographicInterference = float3(interference, interference * 0.5, interference);
    
    // Generate holographic pattern based on depth and hologram parameters
    float3 hologram = sin(2.0 * PI * hologramDepth * r + hologramScale * time) * exp(-pow(r / max(beamWaist, EPSILON), 2.0));
    
    // Combine holographic interference with hologram
    float3 combinedHologram = holographicInterference * hologram;
    
    // Combine intensity with holographic patterns
    float3 color = float3(0.8, 0.2, 1.0) * (finalIntensity + combinedHologram);
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
}

// Pixel Shader 4: Ultra-Exotic Multi-Effect Gaussian Beam with Dynamic Depth Feedback
float3 PS_UltraExoticMultiEffectGaussian(Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float lensStrength,
    float lensRadius,
    float rippleFrequency,
    float rippleAmplitude,
    float shadowIntensity,
    float shadowRadius,
    float refractionStrength,
    float scatterIntensity,
    float scatterScale,
    float causticFrequency,
    float causticIntensity,
    float hologramDepth,
    float hologramScale,
    float interferenceFrequency,
    float interferenceIntensity
)
{
    // Apply complex ripple distortion based on depth and time
    float2 distortedUV = applyComplexRipple(depthMap, uv, time, rippleFrequency, rippleAmplitude, 4.0);
    float depth = depthRaw(depthMap, uv);
    
    // Normalize distorted UV coordinates relative to beam center
    float2 centeredUV = (distortedUV - beamCenter) * 2.0;
    
    // Calculate radial distance
    float r = length(centeredUV);
    
    // Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);
    
    // Calculate shadow factor
    float shadowFactor = calculateShadow(depthMap, distortedUV, shadowIntensity, shadowRadius);
    
    // Apply shadow factor to intensity
    intensity *= shadowFactor;
    
    // Calculate dynamic refraction offset
    float2 refractionOffset = calculateDynamicRefraction(depthMap, distortedUV, beamCenter, beamWaist, refractionStrength, time);
    
    // Apply refraction offset
    float2 refractedUV = uv + refractionOffset;
    
    // Recalculate centered UV after refraction
    float2 finalCenteredUV = (refractedUV - beamCenter) * 2.0;
    float finalR = length(finalCenteredUV);
    
    // Apply Gaussian intensity profile with shadow
    float finalIntensity = gaussian(finalR, beamWaist) * shadowFactor;
    
    // Apply volumetric scattering based on depth
    float scatterFactor = 1.0 - exp(-scatterIntensity * depthRaw(depthMap, refractedUV) * scatterScale);
    finalIntensity *= scatterFactor;
    
    // Generate dynamic caustics based on depth and beam position
    float caustics = sin(causticFrequency * finalR - time * 2.0) * exp(-pow(finalR / max(beamWaist, EPSILON), 2.0)) * causticIntensity * depthRaw(depthMap, refractedUV);
    
    // Generate holographic interference pattern influenced by depth
    float interference = sin(interferenceFrequency * finalR + time) * exp(-pow(finalR / max(beamWaist, EPSILON), 2.0)) * interferenceIntensity * depthRaw(depthMap, refractedUV);
    
    // Combine caustics and interference
    float combinedEffect = caustics + interference;
    
    // Generate holographic pattern based on depth and hologram parameters
    float3 hologram = sin(2.0 * PI * hologramDepth * finalR + hologramScale * time) * exp(-pow(finalR / max(beamWaist, EPSILON), 2.0));
    
    // Combine holographic interference with hologram
    float3 combinedHologram = float3(combinedEffect, combinedEffect * 0.5, combinedEffect) * hologram;
    
    // Combine intensity with holographic patterns
    float3 color = float3(1.0, 0.5, 0.8) * (finalIntensity + combinedHologram);
    
    // Apply additional chromatic effects based on depth
    color *= float3(1.0, 0.95, 0.9) * (1.0 - depth * 0.3);
    
    // Normalize and clamp the color
    color = saturate(color);
    
    return color;
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
    float cosTheta = dot(viewDir, lightDir); // Assuming viewDir and lightDir are defined and normalized elsewhere
    float phaseMie = (3.0 / (16.0 * PI)) * (1.0 + pow(max(0, cosTheta), 2.0)); // Henyey-Greenstein phase function for small particles

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



float4 HolographicDisplayWithGaussian(float2 uv, float3 viewPosition, float time,
                                       Texture2D depthMap, SamplerState depthMapSampler,
                                       LightSource lightSources[MAX_LIGHT_SOURCES])
{
 
    float depth = depthRaw(depthMap, uv) * HOLOGRAM_SIZE_M;
    float3 worldPos = UVToWorld(uv, depth);
    
    float3 cumulativeColor = float3(0, 0, 0);
    
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        LightSource light = lightSources[i];
        GaussianBeam beam = light.beamProperties; // Assuming beam properties are part of LightSource
        
        // Using the GaussianBeam for beam properties if available, otherwise default to point-like behavior
        float effectiveBeamWaist = beam.beamWaist > 0 ? beam.beamWaist : 0.001; // Avoid zero division
        float divergence = beam.divergence;
        
        // Calculate beam profile at worldPos
        float3 lightDirToPixel = normalize(worldPos - light.position);
        float distanceToBeamCenter = length(cross(lightDirToPixel, beam.direction));
        float beamProfile = exp(-2 * pow(distanceToBeamCenter / max(effectiveBeamWaist, EPSILON), 2));
        
        // Phase and coherence calculations remain similar, but now consider beam divergence
        float distanceToLight = length(light.position - worldPos);
        float phaseShift = (2.0 * PI * distanceToLight) / max(nmToM(light.wavelengthNM.x), EPSILON);
        
        // Simplified coherence factor with consideration for the beam's divergence
        float coherenceFactor = exp(-pow(max(distanceToLight / max(light.coherenceLength * (1 + divergence), EPSILON), EPSILON), 2));
        
        float3 interferenceColor = light.color * light.intensity * beamProfile *
                                   cos(phaseShift) * coherenceFactor;
        
        // Scattering, now potentially affected by beam properties (simplified)
        float3 scatteredLight = beamProfile * MieScattering(lightDirToPixel, -beam.direction,
                                          nmToM(light.wavelengthNM), 1.0, 1.0, float3(1.5, 0, 0));
        
        cumulativeColor += interferenceColor * scatteredLight;
    }
    
    // Convert to RGB, apply blur, etc., as before but now accounting for beam properties
    float3 finalColor = WavelengthsToRGB(cumulativeColor);

    // Using a simple wavelength-dependent blur, could be refined with beam properties
    float3 blurRadius = WavelengthDependentBlurRadius(nmToM(lightSources[0].wavelengthNM), depth);
    finalColor = GaussianBlurWavelengthDependent(rtMap1, uv, blurRadius * nmToM(cumulativeColor), depth);

    return float4(finalColor, 1.0);
}


float3 PS_AdvancedPhaseInterference(float2 uv, float3 viewPos, float3 viewDir, float3 normal, float time, MaterialSellmeier material, LightSource lightSources[MAX_LIGHT_SOURCES])
{
    float depth = depthRaw(depthMap, uv) * HOLOGRAM_SIZE_M;
    float3 worldPos = UVToWorld(uv, depth);
    
    float3 cumulativeAmplitude = float3(0, 0, 0);
    
    [unroll(4)]
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        float3 lightPos = lightSources[i].position;
        float3 wavelengthMeter = nmToM(lightSources[i].wavelengthNM);
        return lightPos / wavelengthMeter;
        int numGaussianPoints = MAX_GAUSSIAN_POINTS;
        GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS];
    
        InitializeGaussianPointSources(numGaussianPoints, gaussianPoints, uv, viewPos, f4, f5, f6 * WavelengthsToRGB(lightSources[i].wavelengthNM));
    
        [unroll(2)]
        for (int j = 0; j < numGaussianPoints; j++)
        {
            GaussianPointSource source = gaussianPoints[j];
            float3 sourceToView = (viewPos * HOLOGRAM_SIZE_M) - (source.position * HOLOGRAM_SIZE_M);
            float distanceM = max(length(sourceToView), EPSILON);
            
            // Advanced Gaussian Beam with astigmatism
            float3 beamProfile = gaussianBeamComplex(sourceToView.xy / max(distanceM, EPSILON), time, source.beamWidth, source.beamWidth.x, source.beamWidth.y, 2 * (mToHz(wavelengthMeter)));
            
            float3 localNormal = normalize(normal);
            float cosThetaI = dot(localNormal, normalize(sourceToView));
            
            // Phase shift including coherence length
            float coherenceLength = material.coherenceLengthM; // Assuming this property exists
            float pathDifference = mToNm(distanceM);
            float coherenceFactor = exp(-pow(max(abs(pathDifference / max(coherenceLength, EPSILON)), EPSILON), 2));
            
            // Phase calculation
            float3 basePhase = (2 * PI * pathDifference / wavelengthMeter) / wavelengthMeter;
            
            float3 phaseShift = PS_NonlinearPhaseGaussian(uv, time, lightPos.xy - source.position.xy, length(source.beamWidth) * coherenceFactor, 1.652);
            
            float3 totalPhase = max(0.1, basePhase + phaseShift);
            
            // Fresnel for complex refractive index interaction
            float3 nComplex = clamp(SellmeierEquation_NM(mToNm(wavelengthMeter), material)
                + 0.00003 * (i + j), 1.3, 2.0); // Complex refractive index
            float2 fresnel = clamp(FresnelEquations(nComplex.x, 1.0, cosThetaI), .3, .9);
            
            // Using simplified Mie Scattering approximation for visual effect
            float3 mieScattering = max(float3(.1, .1, .1), MieScattering(viewDir, normalize(viewPos - lightPos), wavelengthMeter, 1.0, 1.0, nComplex));
            
            // Interference calculation (simplified for real-time)
            float3 interference = max(source.color * source.amplitude * beamProfile *
                                  cos(totalPhase) / max(coherenceFactor, EPSILON) * mieScattering * (1 - (fresnel.x + fresnel.y) / 2), float3(.1, .1, .1));
            
            
            
    // Calculate blur radii based on wavelengths
            float3 blurRadius = WavelengthDependentBlurRadius(RGBToWavelengths(source.color), distanceM);
    // Apply wavelength-dependent Gaussian blur
            float3 blurredColor = GaussianBlurWavelengthDependent(diffuseMap, uv, blurRadius * interference, GetOosz(depthMap));
          
            cumulativeAmplitude += (source.color * blurredColor);
        }
    }

    // Convert to visible color through some form of mapping or spectral response function
    return nmToM(cumulativeAmplitude) / MAX_LIGHT_SOURCES / MAX_GAUSSIAN_POINTS;
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
    return normalize(float3(noisePerlin11(uv), noisePerlin11(uv + seed), projectDepth(ViewZ)) - float3(uv, projectedDepth(depthMap, uv)));

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
        return float3(0.0, 0.0, 0.0);
    }
    
    // Calculate cos(theta_t)
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase shift
    float3 phase = (2.0 * PI * deltaM) / wavelengthsM;
    
    // Reflectance coefficients using Fresnel equations
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / (nIncident * cosThetaI + nFilm * cosThetaT), 2);
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / (nFilm * cosThetaT + nIncident * cosThetaI), 2);
    
    // Complex phase shift
    Complex3 phaseComplex;
    phaseComplex.real = cos(phase);
    phaseComplex.imag = sin(phase);
    
    // Initialize reflectance
    float3 reflectance = float3(0.0, 0.0, 0.0);
    
    for (int i = 0; i < 3; i++) // RGB channels
    {
        float R12_i = R12[i];
        float R23_i = R23[i];
        
        // Complex amplitudes
        Complex3 R = CreateComplex3(float3(sqrt(R12_i), sqrt(R12_i), sqrt(R12_i)), float3(0.0, 0.0, 0.0));
        Complex3 S = CreateComplex3(float3(sqrt(R23_i), sqrt(R23_i), sqrt(R23_i)), float3(0.0, 0.0, 0.0));
        
        // Interference: R + 2 * sqrt(R12 * R23) * phaseComplex
        Complex3 interference = ComplexAdd(R, ComplexMul(CreateComplex3(float3(2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i)), float3(0.0, 0.0, 0.0)), phaseComplex));
        
        // Magnitude squared
        float interferenceMagSq = ComplexMagSq(interference).x; // Assuming real and imag are the same
        
        // Assign to reflectance
        if (i == 0)
            reflectance.x = interferenceMagSq;
        else if (i == 1)
            reflectance.y = interferenceMagSq;
        else
            reflectance.z = interferenceMagSq;
    }
    
    // Normalize
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
        return float3(0.0, 0.0, 0.0);
    }
    
    // Calculate cos(theta_t)
    float3 cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    // Optical path difference
    float3 deltaM = 2.0 * nFilm * thicknessM * cosThetaT;
    
    // Phase shift
    float3 phase = (2.0 * PI * deltaM) / max(wavelengthsM, EPSILON);
    
    // Reflectance coefficients using Fresnel equations
    float3 R12 = pow((nIncident * cosThetaI - nFilm * cosThetaT) / max(nIncident * cosThetaI + nFilm * cosThetaT, EPSILON), 2);
    float3 R23 = pow((nFilm * cosThetaT - nIncident * cosThetaI) / max(nFilm * cosThetaT + nIncident * cosThetaI, EPSILON), 2);
    
    // Complex phase shift
    Complex3 phaseComplex;
    phaseComplex.real = cos(phase);
    phaseComplex.imag = sin(phase);
    
    // Initialize reflectance
    float3 reflectance = float3(0.0, 0.0, 0.0);
    [unroll]
    for (int i = 0; i < 3; i++) // RGB channels
    {
        float R12_i = R12[i];
        float R23_i = R23[i];
        
        // Complex amplitudes
        Complex3 R = CreateComplex3(float3(sqrt(R12_i), sqrt(R12_i), sqrt(R12_i)), float3(0.0, 0.0, 0.0));
        Complex3 S = CreateComplex3(float3(sqrt(R23_i), sqrt(R23_i), sqrt(R23_i)), float3(0.0, 0.0, 0.0));
        
        // Interference: R + 2 * sqrt(R12 * R23) * phaseComplex
        Complex3 interference = ComplexAdd(R, ComplexMul(CreateComplex3(float3(2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i), 2.0 * sqrt(R12_i * R23_i)), float3(0.0, 0.0, 0.0)), phaseComplex));
        
        // Magnitude squared
        float3 interferenceMagSq = ComplexMagSq(interference); // Assuming real and imag are the same
        
        // Assign to reflectance
        reflectance[i] = length(interferenceMagSq);
    }
    
    // Normalize
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
        p *= noiseMap1.Sample(sampleTypeMirror, float2(seed * 0.08, seed * 0.08) + float2(k * 0.01, k * 0.01)).x * 2 - 1;
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
    float Rs = pow((refractiveIndex * cosThetaI - cosThetaT) / max(refractiveIndex * cosThetaI + cosThetaT, EPSILON), 2);
    float Rp = pow((cosThetaI - refractiveIndex * cosThetaT) / max(cosThetaI + refractiveIndex * cosThetaT, EPSILON), 2);
    return float2(Rs, Rp);
}


float Noise(float2 uv)
{
    return noisePerlin01(1.5 + uv.x, 3.14159 + uv.y, TotalTime * AnimateSpeed);
}




float4 ReadOutput(inout psout ret, float2 uv, int rtIndex)
{
    float3 retv = float3(0, 0, 0);
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
        uv += 100 * noisePerlin11(uv.x, uv.y, depthRaw(depthMap, uv) + TotalTime * AnimateSpeed);
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
    
    return float4(retv, 1);
}

// Helper function to retrieve hologram data (placeholder for actual implementation)
HologramData GetHologramData2(inout psout ret, float2 uv, float3 viewDir)
{
    config.viewDir = viewDir;
    config.uv = uv;
    uv = config.uv;
    // Sample diffuse and depth maps
    float4 output = ReadOutput(ret, uv, PassNum - 1);
    float3 normal = CalcNormal(depthMap, uv);
    
    float3 diffuseColor = output.xyz;
    float depth = depthRaw(depthMap, uv);
    
    depth = moilerp(0.1e-9, 1.0, 1 - depth);
    // Encode depth into hologramData.w and diffuse color into hologramData.rgb
    HologramData data = { (HologramData) 0 };
    data.Color = diffuseColor;
    data.Pixel = float3(uv, depth);
    data.WavelengthsNM = RGBToWavelengthsNM(diffuseColor) + depth * DepthScale * HOLOGRAM_SIZE_M;
    return data;
}
float3 SimulateDiffraction(
    HologramData hologramData,
    float2 uv,
    float3 wavelengthsM,
    float3 viewPos,
    float3 viewDir,
    float3 sunPos,
    float time,
    float swayAmplitude,
    float swayFrequency,
    inout psout ret,
    inout int numGaussianPoints,
    inout GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS]
)
{
    // Define EPSILON if not already defined
#ifndef EPSILON
#define EPSILON 1e-6
#endif

    // Initialize diffraction accumulation
    float3 diffractionAccum = float3(0.0, 0.0, 0.0);
    float3 baseNormal = CalcNormal(depthMap, uv);
    float baseDepth = depthRaw(depthMap, uv);

    // Iterate over all active Gaussian point sources
    for (int i = 0; i < numGaussianPoints; ++i)
    {
        GaussianPointSource source = gaussianPoints[i];
        QuantumGaussianBeam qb = GenerateQuantumBeam(uv, i);
        
        // Calculate vector from point source to viewer position
        float3 sourceToView = (viewPos * HOLOGRAM_SIZE_M - (source.position + qb.position) * HOLOGRAM_SIZE_M);

        // Calculate distance from source to view position
        float distanceM = length(sourceToView) + EPSILON;

        // Calculate the direction vector
        float3 direction = normalize(sourceToView + qb.direction);

        // Generate noise value
        float3 noiseValue = noise3(noiseMap4, float3(uv, i + PassNum));

        // Corrected depth offset calculation
        float2 depthOffset = 0.02 * (noiseValue.xy * 2.0 - 1.0);

        // Compute the offset along the direction with a random scalar
        
        float randomScalar = (noiseValue.x * 2.0 - 1.0);
        float2 directionOffset = direction.xy * DepthScale * randomScalar;

        // Compute the sample UV position
        float2 sampleUV = uv + depthOffset + directionOffset;

        // Sample the depth map at the new UV position
        float depthSample = depthRaw(depthMap, sampleUV);

        // Smoothly interpolate between the base depth and the sampled depth
        float depthLerped = lerp(baseDepth, depthSample, 0.75);

        // Convert interpolated depth to meters
        float depthM = depthLerped * HOLOGRAM_SIZE_M;

        // Calculate optical path length in terms of wavelengths
        float3 opticalPathLength = depthM / wavelengthsM;

        // Calculate the normal at the offset position
        float3 normalOffset = CalcNormal(depthMap, sampleUV);
        float3 normal = lerp(baseNormal, normalOffset, 0.75);

        // Calculate dot products with clamping
        float dotSourceDir = clamp(dot(source.direction, direction), -1.0, 1.0);
        float dotDirNormal = clamp(dot(direction, normal), -1.0, 1.0);
        float dotViewDir = clamp(dot(viewDir, direction), -1.0, 1.0);

        // Calculate the phase difference based on optical path length
        float3 phaseDifference = 2.0 * PI * opticalPathLength * qb.phaseShift;

        // Apply Gaussian beam profile based on the angle and beam width
        float beamWidth = length(source.beamWidth + qb.beamWaist);
        float amplitudeAdjusted = max(0.1, source.amplitude - 0.5);
        float distanceAdjusted = PI / 2.0 + distanceM;
        float3 beamProfile = gaussianBeamComplex(
            uv,
            time,
            source.position.xy + source.direction.xy * source.amplitude,
            beamWidth,
            amplitudeAdjusted,
            phaseDifference,
            distanceAdjusted
        ) / wavelengthsM;

        // Ensure beamProfile is positive to prevent division by zero
        beamProfile = max(beamProfile, float3(EPSILON, EPSILON, EPSILON));

        // Calculate phase based on distance and wavelength
        float3 phase = ((1.0 + float(i)) * time * 2.0 * PI) / (beamProfile * wavelengthsM);

        // Apply swaying modulation to phase
        float numPointsAdjusted = max(float(numGaussianPoints), 1.0);
        float3 swayPhase = ((1.0 + float(i)) * 2.0 * PI * distanceM * beamProfile * time) / (numPointsAdjusted * wavelengthsM);

        // Retrieve grating map value safely
        float3 gratingValue = mir2D(gratingMap1, uv).xyz * source.color;

        // Convert RGB to wavelengths and ensure no division by zero
        float3 rgbWavelengthsNM = RGBToWavelengthsNM(gratingValue);
        float3 rgbWavelengthsM = nmToM(rgbWavelengthsNM);

        // Calculate interference contribution from this Gaussian point source
        float3 interferenceM = source.amplitude * beamProfile * rgbWavelengthsM * cos(phase + swayPhase + time) / wavelengthsM;

        // Create material and calculate interference
        MaterialSellmeier mat = CreateMaterial(MaterialIndex);
        float3 c = InterferenceM(
            mat.thicknessM,
            normal,
            viewDir,
            wavelengthsM,
            1.3,
            1.75,
            0.001
        );

        // Accumulate the interference with clamping
        float3 interferenceClamped = clamp(interferenceM, 0.01, 1.0);
        float3 cClamped = clamp(c, 0.01, 1.0);
        diffractionAccum += (cClamped + interferenceClamped) / numPointsAdjusted;
    }

    // Normalize the accumulated diffraction by the number of Gaussian points
    float3 wavelengthsMAdjusted = max(wavelengthsM, float3(EPSILON, EPSILON, EPSILON));
    float3 diffractionNM = mToNm(diffractionAccum / wavelengthsMAdjusted);

    // Normalize diffraction by wavelength ranges, ensure no division by zero
    diffractionNM /= max(WAVELENGTH_RANGES, float3(EPSILON, EPSILON, EPSILON));

    // Project the diffraction pattern forward toward the viewer
    float3 projectionDir = normalize(CalcNormal(depthMap, uv));
    float projectionFactor = saturate(1.0 - dot(viewDir, projectionDir));
    diffractionNM *= projectionFactor;

    // Aggregate additional modulation from render target maps
    float4 additionalModulation = ReadOutput(ret, uv, PassNum);

    // Ensure additional modulation is not below a threshold
    float3 modulationAdjusted = max(additionalModulation.xyz, float3(0.2, 0.2, 0.2));

    // Combine the normalized diffraction with additional modulation
    float3 finalDiffraction = diffractionNM * modulationAdjusted;

    return finalDiffraction;
}




void WriteOutput(inout psout ret, float2 uv, float4 c, int rtIndex)
{
    float4 o = ReadOutput(ret, uv, rtIndex - 1);
    float4 val = lerp(o, c, .75);
    
    
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
    WriteOutput(ret, uv, float4(finalColor, 1), rtIndex);
}

// Enhanced ReconstructHologram Function Utilizing Precise Diffraction Simulation with Gaussian Points
float4 ReconstructHologram(HologramData hologramData,
    float2 uv,
    float3 viewPos,
    float3 viewDir,
    float3 sunPos,
    float3 normal,
    float time,
    float swayAmplitude,
    float swayFrequency,
    inout psout ret,
    inout int numGaussianPoints,
    GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS]
)
{
    // Step 1: Simulate diffraction with precise measurements and swaying interference patterns
    float3 diffractionColor = SimulateDiffraction(hologramData,
        uv,
        RGB_WAVELENGTHS_M,
        viewPos,
        sunPos,
        viewDir,
        time,
        swayAmplitude,
        swayFrequency,
        ret,
        numGaussianPoints,
        gaussianPoints
    );
    
    // Step 2: Convert diffraction color to RGB using wavelength-to-RGB conversion
    float3 reconstructedRGB = WavelengthsToRGB(RGBToWavelengthsNM(diffractionColor));
    
    // Step 3: Aggregate multiple render targets for enhanced holographic projection
    float3 aggregatedColor = (reconstructedRGB + ReadOutput(ret, uv, PassNum).xyz) * .5;
      
    // Step 4: Apply Thin-Film Interference using Fresnel equations
    float4 interferenceColor = FresnelThinFilmInterference(float4(aggregatedColor, hologramData.Pixel.z),
        viewDir,
        normal,
        200e-9, // Film thickness in meters
        FresnelPower, // Fresnel power
        FresnelReflectance, // Fresnel reflectance
        1 + (1 - dot(normal, viewDir)) * (1 - depthRaw(depthMap, uv)) * noisePerlin11((uv - .5) * TotalTime * AnimateSpeed * .01 + .5) * .1, // Refractive indices for R, G, B
        .05 // Dispersion coefficient
    );
    
    // Step 5: Combine interference with aggregated color
    float3 finalColor = saturate(interferenceColor.rgb * aggregatedColor);
    
    // Step 6: Apply additional post-processing effects (e.g., chromatic aberration, bloom)
    // Example: Chromatic Aberration

    finalColor *= ApplyChromaticAberration(float2(1.0 / 1920.0, 1.0 / 1080.0), diffuseMap, uv, 0.005);
    
    // Example: Bloom (Assuming a Gaussian blur function is implemented)
    // finalColor += GaussianBloom(diffuseMap, uv, 1.0, 0.6, float3(0.2, 0.1, 0.05), float3(1.2, 1.1, 1.0), 1.5);
    
    // Step 7: Return the final holographic color with depth information
    return float4(finalColor, hologramData.Pixel.z);
}
// Reconstruct Wavelengths Function with Enhanced Precision
float3 ReconstructWavelengthsM(float2 uv,
    float3 reconstructedWavefrontNM,
    float wavelengthShiftRangeNM = 250.0
)
{
    // Normalize the reconstructed wavefront to get intensity proportions
    float totalIntensity = max(reconstructedWavefrontNM.x + reconstructedWavefrontNM.y + reconstructedWavefrontNM.z, EPSILON);
    
    float3 intensityProportionsNM = totalIntensity > 0 ? reconstructedWavefrontNM / totalIntensity : 0;
    
    // Shift wavelengths based on intensity proportions
    float3 adjustedWavelengthsNM = mToNm(RGB_WAVELENGTHS_M) +
       (intensityProportionsNM - float3(1.0f / 3.0f, 1.0f / 3.0f, 1.0f / 3.0f)) * (2.0f * wavelengthShiftRangeNM);
    
    // Clamp the adjusted wavelengths to the valid range (360 nm to 830 nm)
    float3 clampedWavelengthsNM = clamp(adjustedWavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS);
    
    // Convert adjusted wavelengths back to meters
    float3 clampedWavelengthsM = nmToM(clampedWavelengthsNM);
    
    // Return the adjusted wavelengths and preserve alpha
    return clampedWavelengthsM;
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
                float2 t = ComplexMultiply(w, data[k + j + m / 2]);
                float2 u = data[k + j];
                data[k + j] = u + t;
                data[k + j + m / 2] = u - t;
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
    

    float kDotWind = max(dot(normalize(k), normalize(windDir)), EPSILON);
    float L = pow(max(length(windDir), EPSILON), 2) / 9.81;
    float damping = 0.001;
    float l = L * damping;

    float phillips = A * exp(-1.0 / (kLength * L * kLength * L)) / max(pow(kLength, 4), EPSILON) * pow(kDotWind, 2);
    phillips *= exp(-kLength * kLength * l * l);

    return phillips;
}
float2 InitializeHeightField(int2 n, float length, float2 windDir, float amplitude)
{
    float2 k = float2((n.x - N / 2), (n.y - N / 2)) * (2.0 * PI / max(length, EPSILON));
    float Ph = sqrt(PhillipsSpectrum(k, windDir, amplitude)) / sqrt(2.0);

    // Random phase
    float r = noisePerlin11(n);

    return float2(Ph * cos(r), Ph * sin(r));
}
float2 TimeEvolvingHeightField(int2 n, float time, float flength, float2 windDir, float amplitude)
{
    float2 k = float2((n.x - N / 2), (n.y - N / 2)) * (2.0 * PI / max(flength, EPSILON));
    float omega = sqrt(9.81 * length(k));

    float2 h0 = InitializeHeightField(n, flength, windDir, amplitude);
    float2 h0_conj = float2(h0.x, -h0.y);

    float2 exp_iwt = float2(cos(omega * time), sin(omega * time));
    float2 exp_neg_iwt = float2(cos(-omega * time), sin(-omega * time));

    return h0 * exp_iwt + h0_conj * exp_neg_iwt;
}
// Apply depth-based effects such as refraction, scattering, shadows, etc.
float3 ApplyDepthEffects(
    Texture2D<float> depthMap,
    float2 uv,
    float time,
    float3 viewDir,
    float2 beamCenter,
    float beamWaist,
    float3 refractedDirs,
    float3 normal
)
{
    // Sample the depth at the current UV coordinates
    float depth = 1 - depthRaw(depthMap, uv);

    // Compute the depth gradient (approximating the normal)
    float2 texelSize = GetOosz(depthMap);
    float depthLeft = depthRaw(depthMap, uv - float2(texelSize.x, 0));
    float depthRight = depthRaw(depthMap, uv + float2(texelSize.x, 0));
    float depthUp = depthRaw(depthMap, uv - float2(0, texelSize.y));
    float depthDown = depthRaw(depthMap, uv + float2(0, texelSize.y));

    float3 depthNormal = normalize(float3(depthLeft - depthRight, depthUp - depthDown, -2.0 * texelSize.x));

    // Calculate refraction offset based on depth gradient and refracted directions
    float3 refractionOffset = refractedDirs * (depth) * 0.05;

    // Apply refraction to UV coordinates
    float2 refractedUV = uv + refractionOffset.xy;

    // Simulate volumetric scattering based on depth
    float scatterAmount = exp(-depth * f9); // Adjust the exponent for desired effect
    float3 scatterColor = HolographicRainbowColor(refractedDirs, depthNormal) * scatterAmount;

    // Simulate shadowing based on depth differences
    float shadow = saturate(((1 - depth) - depthDown) * f8); // Adjust multiplier for desired effect
    float3 shadowColor = float3(0.0, 0.0, 0.0) * shadow;

    float3 baseColor = scatterColor;
    if (PassNum == 0)
    {
        baseColor = lerp(baseColor, diffuseMap.SampleLevel(sampleTypeLinear, refractedUV, 0).rgb, .5);
    }
    else
    {
        baseColor = lerp(baseColor, baseColor * rtMap1.SampleLevel(sampleTypeLinear, refractedUV, 0).rgb, .75);
    }
    float3 finalColor = baseColor * scatterColor * (1.0 - shadow) * dot(normal, viewDir);

    // Apply fog based on depth (optional)
    float fogFactor = exp(-depth * 5.0); // Adjust exponent for desired effect
    float3 fogColor = float3(0.5, 0.6, 0.7); // Ambient fog color
    finalColor = lerp(fogColor, finalColor, fogFactor) * dot(depthNormal, viewDir);

    return saturate(finalColor) * max(0, dot(normal, viewDir));
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

float3 HolographicEffect(float2 texCoord, float time)
{
    float3 hologramColor = float3(0.0, 0.8, 1.0);
    float wave = sin(texCoord.x * 20.0 + time * 2.0) * 0.05;
    float3 waveEffect = hologramColor + wave;
    return waveEffect;
}

float4 postEffect(float4 diffuse, float2 uv, float2 sz, float time, float exposure, float gamma)
{
    // Add subtle dithering to reduce banding
    float2 pixelCoord = uv * sz;
    float dither = frac(sin(dot(pixelCoord, float2(12.9898, 78.233))) * 43758.5453);
    diffuse.rgb += dither * 0.005;

    // Apply 3D Holographic Effect
    float3 holographicEffect = HolographicEffect(uv, time);
    float3 finalColor = lerp(diffuse.rgb, holographicEffect, 0.3);

    // Apply HDR and Tone Mapping
    finalColor = ApplyHDR(finalColor, exposure);

    // Apply Gamma Correction
    finalColor = AdjustGamma(finalColor, gamma);

    return float4(finalColor * mir2D(diffuseMap, uv).xyz, diffuse.a);
}

psout PS(PS_INPUT input)
{
    psout ret = (psout) 0;

    float2 oosz = GetOosz(depthMap);

    float2 uv = input.uv;
    float2 uvW = uv * HOLOGRAM_SIZE_M;
    // Initialize render target outputs (for multi-pass rendering)
    ret.rt1 = float4(rtMap1.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt2 = float4(rtMap2.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt3 = float4(rtMap3.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt4 = float4(rtMap4.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt5 = float4(rtMap5.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt6 = float4(rtMap6.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt7 = float4(rtMap7.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);
    ret.rt8 = float4(rtMap8.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1);

    // Projected depth calculations
    float2 nearFar = float2(0, 1);
    float2 nearFarScaled = float2(projectDepth(nearFar.x), projectDepth(nearFar.y));
    float2 nearFarM = nearFarScaled * HOLOGRAM_SIZE_M;

    float depth = depthRaw(depthMap, uv);
    float depthScaled = projectDepth(depth);
    float depthM = depthScaled * HOLOGRAM_SIZE_M;

    float invDepth = nearFar.y - depth;
    float invDepthScaled = nearFarScaled.y - depthScaled;
    float invDepthM = invDepthScaled * HOLOGRAM_SIZE_M;

    // View and pixel positions
    float3 viewPos = float3(f11, f12, ViewZ);
    float3 viewPosScaled = float3(viewPos.xy, projectDepth(viewPos.z));
    float3 viewPosM = viewPosScaled * HOLOGRAM_SIZE_M;

    float3 pixel = float3(uv, depth);
    float3 pixelScaled = float3(pixel.xy, projectDepth(pixel.z));
    float3 pixelM = pixelScaled * HOLOGRAM_SIZE_M;

    // Normal and view direction
    float3 normal = normalize(CalcNormal(depthMap, uv).xyz);
    float3 viewDir = normalize(viewPos - pixel);
    float3 normalM = normalize(CalcNormal(depthMap, uv).xyz);
    float3 viewDirM = normalize(viewPosM - pixelM);
    // Light properties
    float3 sunPos = float3(f1, f2, SunZ);
    float3 sunPosScaled = float3(sunPos.xy, projectDepth(sunPos.z));
    float3 sunPosM = sunPosScaled * HOLOGRAM_SIZE_M;

    float time = TotalTime * AnimateSpeed;
    float swayAmplitude = SWAY_AMPLITUDE;
    float swayFrequency = SWAY_FREQUENCY;

    // Sample diffuse texture
    float4 diffuse = float4(clamp(diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz, EPSILON3, OneMinusEPSILON3), 1);
    float3 diffuse3 = diffuse.xyz;

    // Light direction
    float3 lightPos = float3(f1, f2, SunZ);
    float3 lightPosScaled = float3(lightPos.xy, projectDepth(lightPos.z));
    float3 lightPosM = lightPosScaled * HOLOGRAM_SIZE_M;
    float3 lightDirM = normalize(lightPosM - pixelM);
    float3 lightDir = normalize(lightPos - pixel);

    // Center position for reference
    
    float3 center = float3(0.5, 0.5, depthRaw(depthMap, float2(0.5, 0.5)));
    float3 centerScaled = float3(center.xy, projectDepth(center.z));
    float3 centerM = centerScaled * HOLOGRAM_SIZE_M;

    float centerDist = distance(pixel, center);
    float centerDistScaled = distance(pixelScaled, centerScaled);
    float centerDistM = centerDistScaled * HOLOGRAM_SIZE_M;

    // Material properties
    MaterialSellmeier material = CreateMaterial(MaterialIndex);

    // Wavelengths in meters
    float3 wavelengthsNM = RGBToWavelengths(diffuse3);
    float3 wavelengthsM = nmToM(wavelengthsNM);

    // Initialize light sources
    LightSource lights[MAX_LIGHT_SOURCES];
    SetupHolographicLights(viewPos, lights);

    // Initialize Gaussian point sources
    int numGaussianPoints = MAX_GAUSSIAN_POINTS;
    GaussianPointSource gaussianPoints[MAX_GAUSSIAN_POINTS] = { (GaussianPointSource[MAX_GAUSSIAN_POINTS]) 0 };
    
    InitializeGaussianPointSources(numGaussianPoints, gaussianPoints, uv, viewPos, 0.002 + abs(Noise(uv) * .002), abs(Noise(uv)) + .2, diffuse3 + Fresnel3(diffuse3, viewDir, normal, 0.003 + abs(Noise(uv)) * .0004, FresnelPower + Noise(uv) * FresnelPower * .005, FresnelReflectance + Noise(uv) * FresnelReflectance * .025, float3(1, 1, 1) + Noise(uv) * .2, 0.005 + Noise(uv) * .001));
    // Initialize Gaussian points (implementation depends on the specific use case)

    // Hologram data
    HologramData hologramData = GetHologramData(diffuseMap, depthMap, uv);

    // Simulate diffraction and interference
    float3 diffractionColor = SimulateDiffraction(
        hologramData,
        uv,
        wavelengthsM,
        viewPos,
        viewDir,
        sunPos,
        time,
        swayAmplitude,
        swayFrequency,
        ret,
        numGaussianPoints,
        gaussianPoints
    );
    
    
    // Reconstruct wavelengths
   /// float3 reconstructedWavelengthsM = clamp(ReconstructWavelengthsM(uv, mmToM(diffractionColor)), 0.001, 0.999);

    // Convert reconstructed wavelengths to RGB
    //float3 reconstructedRGB = clamp( ret.rt1.rgb, 0.001, 0.999);
    
    //clamp(WavelengthsToRGB(mToNm(reconstructedWavelengthsM)), 0.1, 0.99);
    MaterialDispersion md;
    md.dispersionCoefficient = 0.02;
    md.refractiveIndexBase = 1.15;
    // Apply chromatic dispersion
    float3 refractiveIndices = clamp(AdjustRefractiveIndex(RGBToWavelengths(diffractionColor), md), 1.01, 3.0);
    float3 refractedDirs = normalize(clamp(refract3(-viewDir, normal, refractiveIndices), -1, 1));
    float2 rot = normalize(RotateUV(float2(1, 0), acos(dot(refractedDirs, viewDir))));
    // Apply depth-based effects
    float3 depthEffectsColor = clamp(ApplyDepthEffects(
        depthMap,
        uv,
        time,
        viewDir,
        rot,
        cosTime01(AnimateSpeed),
        refractedDirs,
        normal
    ), EPSILON3, OneMinusEPSILON3);

    float3 finalColor = diffractionColor;
    // Apply chromatic aberration
    
    // Combine colors
    finalColor = moilerp(clamp(finalColor, EPSILON3, OneMinusEPSILON3), clamp(depthEffectsColor, EPSILON3, OneMinusEPSILON3), finalColor);
    if (PassNum > 0)
    {
        finalColor *= clamp(ApplyChromaticAberration(oosz, rtMap1, uv, 15 - cosTime01(AnimateSpeed) * depth), EPSILON3, OneMinusEPSILON3);
    }
    else
    {
       
        finalColor = moilerp(finalColor, clamp(ApplyChromaticAberration(oosz, diffuseMap, uv, 12 + 3 * cosTime01(AnimateSpeed)), EPSILON3, OneMinusEPSILON3), .8);
    }
    
        
    ret.rt1 = postEffect(float4(finalColor, 1), uv, GetSz1(depthMap), TotalTime * AnimateSpeed, f3, f4);
    
    ret.rt1.xyz = ret.rt1.xyz * InterferenceM_Complex_Simplified(f5, normal, viewDir, RGBToWavelengths(ret.rt1.rgb), 1.2, 1.7);
    ret.rt1.a = (1 + PassNum) / NumPasses * depth;
    return ret;
}