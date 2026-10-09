
/*
    MaterialIndex2
    color = FinalPassToneMap(color, TanhFactorR);
    color = FinalPassApplyBloom(color, bloomColor, TanhFactorG);
    color *= FinalPassSharpen(rtMap, rtUV, TanhFactorB, samplerState);
    color = FinalPassColorGrade(color, ONE3 * CosineFactorR, ONE3 * CosineFactorG, ONE3 * CosineFactorB);
 
    color = FinalPassGammaCorrection(color, Gamma);
    color = FinalPassAdjustSaturation(color, HeightParamA);
    
    color = FinalPassApplyVignette(color, rtUV, GetSz_4(rtMap1), HeightParamB);
    color *= FinalPassChromaticAberration(color, rtMap1, rtUV, samplerState, HeightParamC * (1.0 - depth));
   
*/
#define MAX_PARALLAX_INTERSECTIONS 3
#define MAX_PARALLAX_REFINE_ITERATIONS 2
#define MAX_PARALLAX_LAYERS 2
#define MaterialIndex2 4

// Maximum number of light sources
#define MAX_LIGHT_SOURCES 32

#define HOLOGRAM_SIZE_M f10

#define MAX_GRATING_LAYERS 10
#define MAX_GAUSSIAN_POINTS 3
#define MAX_INTERFERENCE_POINTS MAX_GAUSSIAN_POINTS
#define MAX_SHADOW 3
#define MIN_DEPTH_RANGE 0.01
#define MAX_DEPTH_RANGE 0.99

#define DEPTH_RANGE (MAX_DEPTH_RANGE-MIN_DEPTH_RANGE)

#define MIN_DEPTH_RANGE_PROJECTED (DepthRange.x)
#define MAX_DEPTH_RANGE_PROJECTED (DepthRange.y)

#define DEPTH_RANGE_PROJECTED (MAX_DEPTH_RANGE_PROJECTED-MIN_DEPTH_RANGE_PROJECTED)

#define SPEED_OF_LIGHT 2.99792458e-8


#define ZERO4 float4(0.0,0.0,0.0,0.0)
#define ZERO3 float3(0.0,0.0,0.0)
#define ZERO2 float2(0.0,0.0)
#define ZERO1 float(0.0)

#define ZERO4h half4(0.0h,0.0h,0.0h,0.0h)
#define ZERO3h half3(0.0h,0.0h,0.0h)
#define ZERO2h half2(0.0h,0.0h)
#define ZERO1h half(0.0h)

#define ONE2 float2(1.0,1.0)
#define ONE3 float3(ONE2,1.0)
#define ONE4 float4(ONE3,1.0)
#define ONE float(1.0)
#define ONE2h half2(1.0h,1.0h)
#define ONE3h half3(ONE2h,1.0h)
#define ONE4h half4(ONE3h,1.0h)
#define ONEh half(1.0h)
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

#define PIh 3.141592653579h
#define PI2h half2(PIh,PIh)
#define PI3h half3(PIh,PIh,PIh)
#define PI4h half4(PIh,PIh,PIh,PIh)
#define TWOh 2.0h
#define TWO2h half2(2.0h,2.0h)
#define TWO3h half3(2.0h,2.0h,2.0h)
#define TWO4h half4(2.0h,2.0h,2.0h,2.0h)
#define TWOPIh (TWOh*PIh)
#define TWOPI2h (TWO2h*PI2h)
#define TWOPI3h (TWO3h*PI3h)
#define TWOPI4h (TWO4h*PI4h)

// Constants defining the number of layers and maximum parallax layers.

#define EPSILON 1e-9
#define EPSILONh 1e-9h
#define OneMinusEPSILON (1.0-EPSILON)
#define OneMinusEPSILONh (1.0h-EPSILONh)
#define EPSILON2 float2(EPSILON,EPSILON)
#define EPSILON3 float3(EPSILON,EPSILON,EPSILON)
#define EPSILON4 float4(EPSILON,EPSILON,EPSILON,EPSILON)
#define EPSILON2h half2(EPSILONh,EPSILONh)
#define EPSILON3h half3(EPSILONh,EPSILONh,EPSILONh)
#define EPSILON4h half4(EPSILONh,EPSILONh,EPSILONh,EPSILONh)
#define OneMinusEPSILON2 float2(OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON3 float3(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON4 float4(OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON,OneMinusEPSILON)
#define OneMinusEPSILON2h half2(OneMinusEPSILONh,OneMinusEPSILONh)
#define OneMinusEPSILON3h half3(OneMinusEPSILONh,OneMinusEPSILONh,OneMinusEPSILONh)
#define OneMinusEPSILON4h half4(OneMinusEPSILONh,OneMinusEPSILONh,OneMinusEPSILONh,OneMinusEPSILONh)
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
#define CountV3AboveV1(v3,f,epsilon) (step(f-epsilon,v3.x)+step(f-epsilon,v3.y)+step(f-epsilon,v3.z))
#define CountV4AboveV1(v4,f,epsilon) (CountV3AboveV1(v4.xyz,f,epsilon)+step(f-epsilon,v4.w))


//count of xyzw below f
#define CountV3BelowV1(v3,f,epsilon) (1.0-step(v3.x,f+epsilon)+1.0-step(v3.y,f+epsilon)+1.0-step(v3.z,f+epsilon))
#define CountV4BelowV1(v4,f,epsilon) (CountV3BelowV1(v4.xyz,f,epsilon)+1.0-step(v4.w,f+epsilon))


// Constants





#define MIN_CHROMATICITY float3(0.1741,0.0050,1.0-(0.1741+0.0050))
#define MAX_CHROMATICITY float3(0.0842,0.0420,1.0-(0.0842+0.0420))
#define CHROMATICITY_RANGE (MAX_CHROMATICITY-MIN_CHROMATICITY)


#define PassPct ((PassNum+1)/NumPasses)


#define variation4(v) (MaxComponent4(v)-MinComponent4(v))
#define variation3(v) (MaxComponent3(v)-MinComponent3(v))
#define variation2(v) (MaxComponent2(v)-MinComponent2(v))

#define variation44(dc2,dc6) float4(max(dc2.x,dc6.x)-min(dc2.x,dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y),max(dc2.z,dc6.z)-min(dc2.z,dc6.z),max(dc2.w,dc6.w)-min(dc2.w,dc6.w))
#define variation33(dc2,dc6) float3(max(dc2.x,dc6.x)-min(dc2.x, dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y),max(dc2.z,dc6.z)-min(dc2.z,dc6.z))
#define variation22(dc2,dc6) float2(max(dc2.x,dc6.x)-min(dc2.x,dc6.x),max(dc2.y,dc6.y)-min(dc2.y,dc6.y))
#define variation11(dc2,dc6) (max(dc2.x,dc6.x)-min(dc2.x,dc6.x))
#define variation21(v) (max(v.x,v.y)-min(v.x,v.y))
#define variationSum4(dc2,dc6) AddComponents4(variation44(dc2,dc6))

#define sum2(v) (v.x+v.y)
#define sum3(v) (v.x+v.y+v.z)
#define sum4(v) (v.x+v.y+v.z+v.w)

#define average2(v) (sum2(v)*0.5)
#define average3(v) (sum3(v)*0.33333)
#define average4(v) (sum4(v)*0.25)

#define GAMMA_VALUE 2.2

#define SWAY_AMPLITUDE 0.1
#define SWAY_FREQUENCY 2.0


#define SELLMEIER_COEFFICIENTS(ior,c) CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))))
#define SELLMEIER_THIN_FILM_PROPERTY(ior,thicknessM,c) CreateThinFilmProperties(float3(thicknessM,thicknessM,thicknessM),SELLMEIER_COEFFICIENTS(ior,c))



int decodeInt(float4 encoded)
{
    // Reconstruct the integer from the 4 bytes
    uint x = uint(encoded.x);
    uint y = uint(encoded.y);
    uint z = uint(encoded.z);
    uint w = uint(encoded.w);

    // Combine bytes back into a 32-bit integer
    uint unsignedValue = x | (y << 8u) | (z << 16u) | (w << 24u);

    // Interpret as signed integer
    return asint(unsignedValue);
}
float4 encodeInt(int value)
{
    uint unsignedValue = asuint(value); // Interpret the int as unsigned

    // Extract the 4 bytes of the integer
    float x = float(unsignedValue & 0xFFu); // Least significant byte
    float y = float((unsignedValue >> 8u) & 0xFFu); // Second byte
    float z = float((unsignedValue >> 16u) & 0xFFu); // Third byte
    float w = float((unsignedValue >> 24u) & 0xFFu); // Most significant byte

    // Return as a float4 with components in the range [0, 255]
    return float4(x, y, z, w);
}


inline float2 sincos2(float angle)
{
    float2 sc;
    sincos(angle, sc.x, sc.y);
    return sc;
}
inline float4 AdjustGamma(float4 color, float gammaValue = GAMMA_VALUE)
{
    return float4(pow(max(EPSILON3, color.rgb), ONE3 / max(EPSILON, gammaValue)), color.a);
}
inline float3 AdjustGamma(float3 color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON3, color), ONE3 / max(EPSILON, gammaValue));
}
inline float AdjustGamma(float color, float gammaValue = GAMMA_VALUE)
{
    return pow(max(EPSILON, color), ONE / max(EPSILON, gammaValue));
}


// Function to safely safeNormalize a vector, preventing division by zero
inline float4 safeNormalize(float4 x)
{
    float len = length(x.xyz);
    return float4(lerp(0, x.xyz / max(EPSILON, len), step(0, len)), x.w);
}

inline float3 safeNormalize(float3 x)
{
    float len = length(x);
    return lerp(0, x / max(EPSILON, len), step(0, len));
}

inline float2 safeNormalize(float2 x)
{
    float len = length(x);
    return lerp(0, x / max(EPSILON, len), step(0, len));
}

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
    return m * 1e9;
}

inline float2 mToNm(float2 m)
{
    return m * 1e9;
}

inline float3 mToNm(float3 m)
{
    return m * 1e9;
}

// Convert wavelength from nanometers (nm) to micrometers (µm)
inline float nmToUm(float nm)
{
    return nm * 1e-3;
}

inline float3 nmToUm(float3 nm)
{
    return nm * 1e-3;
}

inline float nmSqToUmSq(float nmSq)
{
    return nmSq * 1e-6;
}

inline float3 nmSqToUmSq(float3 nmSq)
{
    return nmSq * 1e-6;
}


// Convert wavelength from micrometers (µm) to nanometers (nm)
inline float umToNm(float um)
{
    return um * 1e3;
}

inline float3 umToNm(float3 um)
{
    return um * 1e3;
}

// Convert wavelength from micrometers (µm) to meters (m)
inline float umToM(float um)
{
    return um * 1e-6;
}

inline float3 umToM(float3 um)
{
    return um * 1e-6;
}

// Convert wavelength from meters (m) to micrometers (µm)
inline float mToUm(float m)
{
    return m * 1e6;
}

inline float3 mToUm(float3 m)
{
    return m * 1e6;
}


// ------------------------------
// Nanometers (nm) to Millimeters (mm)
// ------------------------------
inline float nmToMm(float nm)
{
    return nm * 1e-6f;
}

inline float3 nmToMm(float3 nm)
{
    return nm * 1e-6f;
}

// ------------------------------
// Millimeters (mm) to Nanometers (nm)
// ------------------------------
inline float mmToNm(float mm)
{
    return mm * 1e6f;
}

inline float3 mmToNm(float3 mm)
{
    return mm * 1e6f;
}
// ------------------------------
// Nanometers (nm) to Picometers (pm)
// ------------------------------
inline float nmToPm(float nm)
{
    return nm * 1e3f;
}

inline float3 nmToPm(float3 nm)
{
    return nm * 1e3f;
}

// ------------------------------
// Picometers (pm) to Nanometers (nm)
// ------------------------------
inline float pmToNm(float pm)
{
    return pm * 1e-3f;
}

inline float3 pmToNm(float3 pm)
{
    return pm * 1e-3f;
}

// ------------------------------
// Nanometers (nm) to Kilometers (km)
// ------------------------------
inline float nmToKm(float nm)
{
    return nm * 1e-12f;
}

inline float3 nmToKm(float3 nm)
{
    return nm * 1e-12f;
}

// ------------------------------
// Kilometers (km) to Nanometers (nm)
// ------------------------------
inline float kmToNm(float km)
{
    return km * 1e12f;
}

inline float3 kmToNm(float3 km)
{
    return km * 1e12f;
}

// ------------------------------
// Micrometers Squared (µm²) to Nanometers Squared (nm²)
// ------------------------------
inline float umSqToNmSq(float umSq)
{
    return umSq * 1e6f;
}

inline float3 umSqToNmSq(float3 umSq)
{
    return umSq * 1e6f;
}



const float PlanckConstant = 6.62607015e-34;
const float PhotonMass = 1e-50;
const float G = 6.67430e-11;


#define RED_MIN_WAVELENGTH 620.0
#define RED_MAX_WAVELENGTH 750.0
#define RED_WAVELENGTH ((RED_MAX_WAVELENGTH-RED_MIN_WAVELENGTH)*.5)
#define GREEN_MIN_WAVELENGTH 495.0
#define GREEN_MAX_WAVELENGTH 570.0
#define GREEN_WAVELENGTH ((GREEN_MAX_WAVELENGTH-GREEN_MIN_WAVELENGTH)*.5)
#define BLUE_MIN_WAVELENGTH 450.0
#define BLUE_MAX_WAVELENGTH 495.0
#define BLUE_WAVELENGTH ((BLUE_MAX_WAVELENGTH-BLUE_MIN_WAVELENGTH)*.5)
#define FLT_MAX 1e+16
#define FLT_MIN 1e-16

#define MIN_WAVELENGTHS float3(RED_MIN_WAVELENGTH, GREEN_MIN_WAVELENGTH, BLUE_MIN_WAVELENGTH)
#define MAX_WAVELENGTHS float3(RED_MAX_WAVELENGTH, GREEN_MAX_WAVELENGTH, BLUE_MAX_WAVELENGTH)
#define RGB_WAVELENGTHS_NM float3(RED_WAVELENGTH, GREEN_WAVELENGTH, BLUE_WAVELENGTH)
#define RGB_WAVELENGTHS_M nmToM(RGB_WAVELENGTHS_NM)
#define RGB_WAVELENGTHS_UM nmToUm(RGB_WAVELENGTHS_NM)
#define MAX_WAVELENGTH 780.0
#define MIN_WAVELENGTH 380.0
// Number of wavelength samples
#define NUM_SAMPLES 471
#define SPECTRAL_LOCUS_COUNT 471

#define WAVELENGTH_RANGES (MAX_WAVELENGTHS-MIN_WAVELENGTHS)
#define WAVELENGTH_RANGE (MAX_WAVELENGTH-MIN_WAVELENGTH)
#define WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE (CHROMATICITY_RANGE/WAVELENGTH_RANGES)


inline float RGBToWavelengthR(float srgb)
{
    float linearRGB = saturate(srgb);
    float oo = step(EPSILON, srgb);
    return (linearRGB * WAVELENGTH_RANGES.r + MIN_WAVELENGTHS.r * oo);
}
inline float RGBToWavelengthG(float srgb)
{
    float linearRGB = saturate(srgb);
    float oo = step(EPSILON, srgb);
    return (linearRGB * WAVELENGTH_RANGES.g + MIN_WAVELENGTHS.g * oo);
}
inline float RGBToWavelengthB(float srgb)
{
    float linearRGB = saturate(srgb);
    float oo = step(EPSILON, srgb);
    return (linearRGB * WAVELENGTH_RANGES.b + MIN_WAVELENGTHS.b * oo);
}

inline float RGBToWavelengthUnaligned(float srgb)
{
    float linearRGB = saturate(srgb);
    float oo = step(EPSILON, srgb);
    return (linearRGB * WAVELENGTH_RANGE + MIN_WAVELENGTH * oo);
}

inline float3 RGBToWavelengthsNM(float3 srgb)
{
    float3 linearRGB = saturate(srgb);
    float3 oo = step(EPSILON3, srgb);
    return (linearRGB * WAVELENGTH_RANGES + MIN_WAVELENGTHS * oo);
}

inline float Oscillate(float time, float frequency)
{
    // frequency controls how fast the oscillation occurs
    return sin(time * frequency * 2.0 * PI);
}

inline float addOver02(float2 v)
{
    float2 m = step(0.0, v); // 1 if component > 0, else 0
    float c = m.x + m.y;
    float s = m.x * v.x + m.y * v.y;
    return (s / max(c, EPSILON)) * step(0.0, c);
}

inline float addOver03(float3 v)
{
    float3 m = step(0.0, v);
    float c = m.x + m.y + m.z;
    float s = dot(m, v);
    return (s / max(c, EPSILON)) * step(0.0, c);
}

inline float addOver04(float4 v)
{
    float4 m = step(0.0, v);
    float c = m.x + m.y + m.z + m.w;
    float s = dot(m, v);
    return (s / max(c, EPSILON)) * step(0.0, c);
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


struct SellmeierCoefficientsBC
{
    float3 B;
    float3 C;
};
SellmeierCoefficientsBC CreateSellmeierCoefficientsBC(
    float3 B,
    float3 C)
{
    SellmeierCoefficientsBC ret = (SellmeierCoefficientsBC) 0;
    ret.B = B;
    ret.C = C;
    return ret;
}

struct SellmeierCoefficientsOE
{
    SellmeierCoefficientsBC O;
    SellmeierCoefficientsBC E;
};

SellmeierCoefficientsOE CreateSellmeierCoefficientsOE(
    SellmeierCoefficientsBC O,
     SellmeierCoefficientsBC E)
{
    SellmeierCoefficientsOE ret = (SellmeierCoefficientsOE) 0;
    ret.O = O;
    ret.E = E;
    return ret;
}

struct SellmeierCoefficients
{
    SellmeierCoefficientsOE OE1;
    SellmeierCoefficientsOE OE2;
    SellmeierCoefficientsOE OE3;
};

SellmeierCoefficients CreateSellmeierCoefficients(
    SellmeierCoefficientsOE OE1,
    SellmeierCoefficientsOE OE2,
    SellmeierCoefficientsOE OE3)
{
    SellmeierCoefficients ret = (SellmeierCoefficients) 0;
    ret.OE1 = OE1;
    ret.OE2 = OE2;
    ret.OE3 = OE3;
    return ret;
}

struct MaterialProperties
{
    SellmeierCoefficientsBC coeff;
    float3 k;
    float thicknessM;
    float3 absorptionM;
    float3 wavelengthsNM;
    float3 transmissionCoefficient;
};


struct MaterialSellmeier
{
    SellmeierCoefficients coeff;
    
    float3 absorptionCoefficient;
    float3 scatteringCoefficient;
    float roughness;
    float metallic;
    float3 metallicReflectance;
    float thicknessM;
    float3 albedo;
    float3 etaR;
    float3 etaI;
    float3 dispersionCoefficientsNm2[3];
    
    float3 etaO;
    float3 etaE;
    float3 opticalAxis;
    float nSurrounding;
    float coherenceLengthM;
    float polarizationAngle;
    float temperatureC;
    float3 density;
    float3 thermalConductivity;
    float3 elasticModulus;
};


MaterialSellmeier CreateMaterialSellmeier(
    SellmeierCoefficients coeff,
    float3 absorptionCoefficient,
    float3 scatteringCoefficient,
    float roughness, float metallic,
    float3 metallicReflectance,
    float3 albedo, float thicknessM,
    float3 etaR, float3 etaI,
	float3 dispersionCoefficientsD0,
    float3 dispersionCoefficientsD1,
    float3 dispersionCoefficientsD2,
	float3 etaO,
	float3 etaE,
	float3 opticalAxis,
	float nSurrounding,
    float polarizationAngle,
    float coherenceLengthM,
    float temperatureC, float3 density,
    float3 thermalConductivity,
    float3 elasticModulus)
{
    MaterialSellmeier material = (MaterialSellmeier) 0;

    material.coeff.OE1.O.B = coeff.OE1.O.B;
    material.coeff.OE2.O.B = coeff.OE2.O.B;
    material.coeff.OE3.O.B = coeff.OE3.O.B;
    material.coeff.OE1.O.C = coeff.OE1.O.C;
    material.coeff.OE2.O.C = coeff.OE2.O.C;
    material.coeff.OE3.O.C = coeff.OE3.O.C;
    
    material.coeff.OE1.E.B = coeff.OE1.E.B;
    material.coeff.OE2.E.B = coeff.OE2.E.B;
    material.coeff.OE3.E.B = coeff.OE3.E.B;
    material.coeff.OE1.E.C = coeff.OE1.E.C;
    material.coeff.OE2.E.C = coeff.OE2.E.C;
    material.coeff.OE3.E.C = coeff.OE3.E.C;
    
    material.absorptionCoefficient = absorptionCoefficient;
    material.scatteringCoefficient = scatteringCoefficient;
    material.roughness = roughness;
    material.metallic = metallic;
    material.metallicReflectance = metallicReflectance;
    material.albedo = albedo;
    material.thicknessM = thicknessM;
    material.etaR = etaR;
    material.etaI = etaI;


    material.dispersionCoefficientsNm2[0] = dispersionCoefficientsD0;
    material.dispersionCoefficientsNm2[1] = dispersionCoefficientsD1;
    material.dispersionCoefficientsNm2[2] = dispersionCoefficientsD2;

    material.etaO = etaO;
    material.etaE = etaE;
    material.opticalAxis = opticalAxis;
    material.nSurrounding = nSurrounding;
    material.polarizationAngle = polarizationAngle;
    material.coherenceLengthM = coherenceLengthM;
    material.temperatureC = temperatureC;
    material.density = density;
    material.thermalConductivity = thermalConductivity;
    material.elasticModulus = elasticModulus;
    return material;
}

cbuffer ConstantBuffer : register(b0)
{
	// Light and View Positions
    float SunX;
    float SunY;
    float SunZ;
    float ViewX; // Camera/view position (x, y, z)

    float ViewY;
    float ViewZ;
	// Parallax Occlusion Mapping Parameters
    float ParallaxFactorA; // Factors for parallax mapping
    float ParallaxFactorB;

    float ParallaxFactorC;
    float HeightParamA; // Parameters for height calculations
    float HeightParamB;
    float HeightParamC;

	// Phase Modulation Parameters
    float PhaseOffsetR; // Phase offsets for R, G, B channels
    float PhaseOffsetG;
    float PhaseOffsetB;
    float LookAtX;

    float CosineFactorR; // Cosine factors for R, G, B channels
    float CosineFactorG;
    float CosineFactorB;
    float LookAtY;

    float TanhFactorR; // Tanh factors for R, G, B channels
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

#define samplerState sampleTypeMirror
// Sampler states for texture sampling.
SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);
SamplerState sampleTypeClamp : register(s2);
SamplerState sampleTypeCube : register(s3);
SamplerState sampleTypePoint : register(s4);

inline float3 dot3(float3 a, float3 b)
{
    float dt = dot(a, b);
    return float3(dt * .95, dt, dt * .95);
}


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


struct Complex
{
    float real;
    float imag;
};

Complex CreateComplex(float real, float imag)
{
    Complex ret = (Complex) 0;
    ret.real = real;
    ret.imag = imag;
    return ret;
}


struct Complex2
{
    float2 real;
    float2 imag;
};

Complex2 CreateComplex2(float2 real, float2 imag)
{
    Complex2 ret = (Complex2) 0;
    ret.real = real;
    ret.imag = imag;
    return ret;
}


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

Complex3 CreateComplex3(float3 real, Complex3 imag)
{
    Complex3 ret;
    ret.real = real;
    ret.imag = imag.imag;
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
Complex3 ComplexMulCf(Complex3 a, float3 b)
{
    Complex3 result;
    result.real = a.real * b - a.imag * 0;
    result.imag = a.real * 0 + a.imag * b;
    return result;
}

Complex3 ComplexMulfC(float3 a, Complex3 b)
{
    Complex3 result;
    result.real = b.real * a - b.imag * 0;
    result.imag = b.real * 0 + b.imag * a;
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

float3 ComplexDot(Complex3 a, Complex3 b)
{
    // Real and imaginary contributions
    float3 realDot = a.real * b.real;
    float3 imagDot = a.imag * b.imag;

    // Combine contributions (sum of real and imaginary dot products)
    return realDot + imagDot;
}
Complex3 ComplexAddfC(float3 a, Complex3 b)
{
    Complex3 result;
    result.real = a + b.real;
    result.imag = 0 + b.imag;
    return result;
}
Complex3 ComplexAddCf(Complex3 a, float3 b)
{
    Complex3 result;
    result.real = a.real + b;
    result.imag = a.imag + 0;
    return result;
}

Complex3 ComplexCreateCf(Complex3 real, float3 imag)
{
    Complex3 c;
    c.real = real.real;
    c.imag = imag;
    return c;
}
Complex3 ComplexCreate(float3 real, float3 imag)
{
    Complex3 c;
    c.real = real;
    c.imag = imag;
    return c;
}

Complex3 ComplexCreate(float3 real)
{
    Complex3 c;
    c.real = real;
    c.imag = ZERO3;
    return c;
}

Complex3 Complex3Create(Complex3 real, Complex3 imag)
{
    Complex3 c;
    c.real = real.real;
    c.imag = imag.imag;
    return c;
}
Complex3 ComplexCreate(float x, float y, float z)
{
    Complex3 c;
    c.real = float3(x, y, z);
    c.imag = 0;
    return c;
}

Complex3 ComplexCreate(float x, float y)
{
    Complex3 c;
    c.real = float3(x, x, x);
    c.imag = float3(y, y, y);
    return c;
}
Complex3 ComplexSub(Complex3 a, Complex3 b)
{
    return ComplexCreate(a.real - b.real, a.imag - b.imag);
}
Complex3 ComplexSubfC(float3 a, Complex3 b)
{
    return ComplexCreate(a - b.real, 0 - b.imag);
}
Complex3 ComplexSubCf(Complex3 a, float3 b)
{
    return ComplexCreate(a.real - b, a.imag - 0);
}
Complex3 ComplexDiv(Complex3 a, Complex3 b)
{
    float3 denom = b.real * b.real + b.imag * b.imag + 1e-6f; // Avoid division by zero
    return ComplexCreate(
		(a.real * b.real + a.imag * b.imag) / denom,
		(a.imag * b.real - a.real * b.imag) / denom
	);
}
Complex3 ComplexDivfC(float3 a, Complex3 b)
{
    float3 denom = b.real * b.real + b.imag * b.imag + 1e-6f; // Avoid division by zero
    return ComplexCreate(
		(a * b.real + 0 * b.imag) / denom,
		(0 * b.real - a * b.imag) / denom
	);
}
Complex3 ComplexDivCf(Complex3 a, float3 b)
{
    float3 denom = b * b + 0 * 0 + 1e-6f; // Avoid division by zero
    return ComplexCreate(
		(a.real * b + a.imag * 0) / denom,
		(a.imag * b - a.real * 0) / denom
	);
}

float3 ComplexAbs(Complex3 a)
{
    return sqrt(a.real * a.real + a.imag * a.imag);
}

Complex3 ComplexConj(Complex3 a)
{
    return ComplexCreate(a.real, -a.imag);
}

Complex3 ComplexExp(Complex3 a)
{
    float3 magnitude = exp(a.real);
    return ComplexCreate(
        magnitude * cos(a.imag),
        magnitude * sin(a.imag)
    );
}

Complex3 ComplexSqrt(Complex3 a)
{
    float3 magnitude = sqrt(ComplexAbs(a));
    float3 angle = atan2(a.imag, a.real) * 0.5f;
    return ComplexCreate(magnitude * cos(angle), magnitude * sin(angle));
}

inline float ClampRefractiveIndex(float ri)
{
    return clamp(ri, 1.0, 5.0);
}

inline float3 ClampRefractiveIndex(float3 ri)
{
    return clamp(ri, 1.0, 5.0);
}

// SellmeierCoefficients
//
// B ResonanceStrength
//  Each B_i is a dimensionless coefficient that quantifies the strength of a particular resonance in the material's optical response.
//  Resonance Strength Coefficients. Alternatively, you can think of them as "Optical Resonance Factors".
//  In BK7 glass, typical B coefficients might be around 1.03961212 for all RGB channels, indicating uniform resonance strengths across visible wavelengths.
//
// C ResonanceWavelengthSq
//  Each C_i is associated with a characteristic wavelength (squared) where the material's response changes, often related to electronic transitions or vibrational modes.
//  Units:
//    C_i has units of micrometers squared (µm²).
//  Intuitive Name Suggestion:
//    Resonance Wavelength Coefficients or "Characteristic Wavelength Factors".
//  Real-World Example:
//    For BK7 glass, typical C coefficients might be around 0.00600069867 µm² for all RGB channels, setting the scale for where the refractive index changes with wavelength.

inline float3 RefractiveIndexFromCoefficients(float3 wavelengthsNM, SellmeierCoefficientsBC coeffs)
{
    // Convert wavelength from nanometers to micrometers
    float3 wavelengthsUM = nmToUm(wavelengthsNM); // 1 nm = 1e-3 µm

    // Compute wavelength squared
    float3 lambdaSq = wavelengthsUM * wavelengthsUM;

    // Apply Sellmeier Equation
    float3 nSq = 1.0f +
                 (coeffs.B.x * lambdaSq.x) / (lambdaSq.x - coeffs.C.x) +
                 (coeffs.B.y * lambdaSq.y) / (lambdaSq.y - coeffs.C.y) +
                 (coeffs.B.z * lambdaSq.z) / (lambdaSq.z - coeffs.C.z);

    // Ensure no negative values under square root
    float3 n = sqrt(max(nSq, EPSILON3));

    return n;
}


// Struct for Anisotropic Roughness Parameters
struct AnisotropicRoughness
{
    float alphaX; // Roughness along X-axis
    float alphaY; // Roughness along Y-axis
};
AnisotropicRoughness CreateAnisotropicRoughness(float alphaX, float alphaY)
{
    AnisotropicRoughness ret = (AnisotropicRoughness) 0;
    ret.alphaX = alphaX;
    ret.alphaY = alphaY;
    return ret;
}

// Struct for Thin-Film Properties
struct ThinFilmProperties
{
    float3 filmThicknessM; // Thickness of each thin film layer (meters)
    SellmeierCoefficients filmEta_coeffs; // Refractive index coefficients for thin film
};

ThinFilmProperties CreateThinFilmProperties(float3 filmThicknessM, SellmeierCoefficients filmEta_coeffs)
{
    ThinFilmProperties ret = (ThinFilmProperties) 0;
    ret.filmThicknessM = filmThicknessM;
    ret.filmEta_coeffs = filmEta_coeffs;
    ret.filmEta_coeffs.OE1 = filmEta_coeffs.OE1;
    ret.filmEta_coeffs.OE2 = filmEta_coeffs.OE2;
    ret.filmEta_coeffs.OE3 = filmEta_coeffs.OE3;
    return ret;
}

inline float AnisotropicNDF(float3 H, float3 N, float alphaX, float alphaY)
{
    float3 H_proj = safeNormalize(float3(H.x, H.y, 0.0f));
    float3 N_proj = safeNormalize(float3(N.x, N.y, 0.0f));

    float exponent = (H_proj.x * H_proj.x) / max(EPSILON, alphaX * alphaX) +
                     (H_proj.y * H_proj.y) / max(EPSILON, alphaY * alphaY);

    float D = (1.0f / (PI * alphaX * alphaY)) *
              exp(-exponent) / pow(abs(dot(N, H)), 4.0f);

    return D;
}

inline float AnisotropicNDF(float3 H, float3 N, AnisotropicRoughness roughness)
{
    return AnisotropicNDF(H, N, roughness.alphaX, roughness.alphaY);
}


// Helper to calculate chromatic dispersion (varying refractive index for different wavelengths)
inline float3 ChromaticDispersionFromFilm(float3 nFilmBase, float3 dispersionCoefficientsNm2, float3 wavelengthsM)
{
	// Example of a simple chromatic dispersion: nFilm varies with wavelength
    return nFilmBase + dispersionCoefficientsNm2 / max(wavelengthsM, EPSILON3);
}

// Apply Chromatic Dispersion to Light Directions
inline float3 ChromaticDispersionFromLight(float3 lightDir, float3 etaR)
{
	// Adjust light direction based on refractive index
    return normalize(lightDir * etaR);
}


half3 FresnelReflectanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out half3 cosThetaT)
{
    half3 cI = clamp(cosThetaI, -ONE3h, ONE3h);
    half3 N1 = max(n1, ZERO3h);
    half3 N2 = max(n2, ZERO3h);

    half3 sI = sqrt(max(ONE3h - cI * cI, ZERO3h));
    half3 ratio = N1 / N2;
    half3 sT = ratio * sI;
    half3 tir = step(ONE3h, sT); // TIR mask
    sT = min(sT, ONE3h);
    cosThetaT = sqrt(max(ONE3h - sT * sT, ZERO3h));

    half3 denomS = max(N1 * cI + N2 * cosThetaT, EPSILON3h);
    half3 denomP = max(N1 * cosThetaT + N2 * cI, EPSILON3h);

    half3 Rs = (N1 * cI - N2 * cosThetaT) / denomS;
    half3 Rp = (N1 * cosThetaT - N2 * cI) / denomP;
    Rs = Rs * Rs;
    Rp = Rp * Rp;

    half3 R = 0.5h * (Rs + Rp);
    R = lerp(R, ONE3h, tir);
    return clamp(R, ZERO3h, ONE3h);
}


half3 FresnelTransmittanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out half3 cosThetaT)
{
    return 1.0h - FresnelReflectanceFromFilm2(n1, n2, cosThetaI, cosThetaT);
}




// Compute Fresnel Reflectance for Each Color Channel
//cosThetaI: Cosine of the angle between the normal and the view direction for each RGB channel.
//etaR : Real part of the refractive index for each RGB channel.
//etaI : Imaginary part of the refractive index for each RGB channel(ignored in this reflectance calculation but can be used for absorption).
float3 FresnelReflectanceFromComplex(float3 cosThetaI, Complex3 eta)
{
	// Compute sinThetaT using Snell's Law
    float3 sinThetaI = sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    Complex3 sinThetaT = ComplexDiv(ComplexCreate(sinThetaI, cosThetaI), eta);

	// Compute cosThetaT
    Complex3 cosThetaT = ComplexSqrt(ComplexSub(ComplexCreate(ONE3, ZERO3), ComplexMul(sinThetaT, sinThetaT)));

	// Compute rs and rp
    Complex3 rs = ComplexDiv(ComplexSub(ComplexMul(eta, ComplexCreate(cosThetaI, sinThetaT.imag)), cosThetaT),
		ComplexAdd(ComplexMul(eta, ComplexCreate(cosThetaI, sinThetaT.imag)), cosThetaT));
    Complex3 rp = ComplexDiv(ComplexSub(ComplexMul(eta, cosThetaT), ComplexCreate(cosThetaI, sinThetaT.imag)),
		ComplexAdd(ComplexMul(eta, cosThetaT), ComplexCreate(cosThetaI, sinThetaT.imag)));

	// Compute reflectance for each channel
    float3 Rs = saturate(ComplexAbs(rs) * ComplexAbs(rs));
    float3 Rp = saturate(ComplexAbs(rp) * ComplexAbs(rp));

	// Blend reflectance based on polarization
    float3 R = saturate(lerp(Rs, Rp, cosThetaI));

    return saturate(R); // Transmittance
}



// Importance Sampling Function
float3 ImportanceSample(float3 normal, float density, float2 uv)
{
	// Generate a random direction biased towards the normal
    float3 dir = float3(
		(noiseMap1.Sample(sampleTypeLinear, uv + float2(0.1, 0.1)) - 0.5).x * density,
		(noiseMap1.Sample(sampleTypeLinear, uv + float2(-0.2, 0.2)) - 0.5).y * density,
		(noiseMap1.Sample(sampleTypeLinear, uv + float2(0.3, -0.3)) - 0.5).z * density
	);
    float3 v = normal + dir;
    float l = dot(v, v);
    return v / max(EPSILON, l);
}

// Stratified Sampling Function
float2 StratifiedSample(float2 uv, int sampleIndex, int totalSamples)
{
    uint samplesPerRow = max(1, (uint) sqrt((float) totalSamples));
    uint row = sampleIndex / samplesPerRow;
    uint col = sampleIndex % samplesPerRow;

    float2 stratifiedUV = float2(
		(float(col) + noiseMap1.Sample(sampleTypeLinear, uv + float2(sampleIndex, 0))).x / float(samplesPerRow),
		(float(row) + noiseMap1.Sample(sampleTypeLinear, uv + float2(0, sampleIndex))).y / float(samplesPerRow)
	);

    return stratifiedUV;
}
// Color Space Conversion Functions
inline float3 SRGBToLinear(float3 srgb)
{
    return saturate(lerp(srgb / 12.92, pow(max(EPSILON, (srgb + 0.055) / 1.055), 2.4), step(srgb, 0.04046)));
}

inline void CreateDispersionCoefficients(float3 D0Nm2, float3 D1Nm2, float3 D2Nm2, inout float3 ret[3])
{
    ret[0] = D0Nm2;
    ret[1] = D1Nm2;
    ret[2] = D2Nm2;
}


// Function to define 5 holographic materials
MaterialSellmeier CreateMaterial(int index)
{
    index = fmod(index, 9);
    MaterialSellmeier ret = (MaterialSellmeier) 0;

    switch (index)
    {
        //sapphire
        case 0:
{
                ret = CreateMaterialSellmeier(
                    CreateSellmeierCoefficients(
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(1.4313493, 0.65054713, 5.3414021), // float3 B1o
                                nmSqToUmSq(float3(0.0726631, 0.1193242, 18.028251)) // float3 C1o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(1.5039759, 1.132329, 0.0), // float3 B1e
                                nmSqToUmSq(float3(0.0758395, 20.226728, 0.0)) // float3 C1e
                            )
                        ),
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(1.4313493, 0.65054713, 5.3414021), // float3 B2o
                                nmSqToUmSq(float3(0.0726631, 0.1193242, 18.028251)) // float3 C2o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(1.5039759, 1.132329, 0.0), // float3 B2e
                                nmSqToUmSq(float3(0.0758395, 20.226728, 0.0)) // float3 C2e
                            )
                        ),
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(0.0, 0.0, 0.0), // float3 B3o
                                nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(0.0, 0.0, 0.0), // float3 B3e
                                nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                            )
                        )
                    ),
                    float3(0.3, 0.1, 0.05), // float3 absorptionCoefficient
                    float3(0.1, 0.1, 0.05), // float3 scatteringCoefficient
                    0.2, // float roughness, 
                    0.8, //float metallic
                    float3(0.8, 0.6, 0.5), // metallic reflectance
                    float3(0.2, 0.4, 0.8), // float3 albedo
                    nmToM(1200.0), // float thicknessM
                    float3(1.768, 1.768, 1.768), // float3 etaR
                    float3(0.0, 0.0, 0.0), // float3 etaI
                    float3(0.15, 0.25, 0.30), // float3 dispersionCoefficientNm2
                    float3(0.25, 0.30, 0.35), // float3 dispersionCoefficientNm2
                    float3(0.40, 0.50, 0.55), // float3 dispersionCoefficientNm2
                    float3(1.768, 1.768, 1.768), // float3 etaO
                    float3(1.748, 1.748, 1.748), // float3 etaE
                    normalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
                    1.0, // float nSurrounding
                    1.0, // float polarizationAngle
                    0.005, // float coherenceLengthM
                    25.0, // float temperatureC
                    float3(3980.0, 3980.0, 3980.0), // float3 density
                    float3(0.4, 0.4, 0.4), // float3 thermalConductivity
                    float3(300.0, 300.0, 300.0) // float3 elasticModulus
                );
            }
            break;

        //diamond
        case 1:
{
                ret = CreateMaterialSellmeier(
                    CreateSellmeierCoefficients(
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(0.3306, 4.3356, 0.0), // float3 B1o
                                nmSqToUmSq(float3(0.1750, 0.1060, 0.0)) // float3 C1o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(4.3356, 0.3306, 0.0), // float3 B1e
                                nmSqToUmSq(float3(0.1060, 0.1750, 0.0)) // float3 C1e
                            )
                        ),
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(0.3306, 4.3356, 0.0), // float3 B2o
                                nmSqToUmSq(float3(0.1750, 0.1060, 0.0)) // float3 C2o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(4.3356, 0.3306, 0.0), // float3 B2e
                                nmSqToUmSq(float3(0.1060, 0.1750, 0.0)) // float3 C2e
                            )
                        ),
                        CreateSellmeierCoefficientsOE(
                            CreateSellmeierCoefficientsBC(
                                float3(0.0, 0.0, 0.0), // float3 B3o
                                nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                            ),
                            CreateSellmeierCoefficientsBC(
                                float3(0.0, 0.0, 0.0), // float3 B3e
                                nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                            )
                        )
                    ),
                    float3(0.1, 0.05, 0.01), // float3 absorptionCoefficient
                    float3(0.05, 0.02, 0.01), // float3 scatteringCoefficient
                    0.05, 0.1, // float roughness, float metallic
                    float3(0.8, 0.9, 0.9), // metallic reflectance
                    float3(1.0, 1.0, 1.0), // float3 albedo
                    nmToM(1250.0), // float thicknessM
                    float3(2.417, 2.417, 2.417), // float3 etaR
                    float3(0.0, 0.0, 0.0), // float3 etaI
                    float3(0.1, 0.1, 0.1), // float3 dispersionCoefficientNm2
                    float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
                    float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
                    float3(2.417, 2.417, 2.417), // float3 etaO
                    float3(2.407, 2.407, 2.407), // float3 etaE
                    normalize(float3(1.0, 0.0, 0.0)), // float3 opticalAxis
                    1.0, // float nSurrounding
                    0.0, // float polarizationAngle
                    0.001, // float coherenceLengthM
                    20.0, // float temperatureC
                    float3(3510.0, 3510.0, 3510.0), // float3 density
                    float3(1200.0, 1200.0, 1200.0), // float3 thermalConductivity
                    float3(1200.0, 1200.0, 1200.0) // float3 elasticModulus
                );
            }
            break;
        
        //quartz
        case 2:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.6961663, 0.4079426, 0.8974994), // float3 B1o
                    nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.6961663, 0.4079426, 0.8974994), // float3 B1e
                    nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.6961663, 0.4079426, 0.8974994), // float3 B2o
                    nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.6961663, 0.4079426, 0.8974994), // float3 B2e
                    nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.2, 0.2, 0.2), // float3 absorptionCoefficient
        float3(0.05, 0.05, 0.05), // float3 scatteringCoefficient
        0.1, 0.7, // float roughness, float metallic
        float3(0.5, 0.6, 0.5), // metallic reflectance
        float3(0.9, 0.9, 0.9), // float3 albedo
        nmToM(1100.0), // float thicknessM
        float3(1.544, 1.544, 1.544), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
        float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
        float3(0.4, 0.4, 0.4), // float3 dispersionCoefficientNm2
        float3(1.544, 1.544, 1.544), // float3 etaO
        float3(1.534, 1.534, 1.534), // float3 etaE
        normalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        1.0, // float polarizationAngle
        0.002, // float coherenceLengthM
        20.0, // float temperatureC
        float3(2650.0, 2650.0, 2650.0), // float3 density
        float3(1278.0, 1278.0, 1278.0), // float3 thermalConductivity
        float3(78.0, 78.0, 78.0) // float3 elasticModulus
    );
            }
            break;


        //emarald
        case 3:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(1.4431997, 0.4065331, 2.8801242), // float3 B1o
                    nmSqToUmSq(float3(0.0937428, 0.2017152, 25.890623)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(1.482148, 0.549392, 0.0), // float3 B1e
                    nmSqToUmSq(float3(0.112315, 18.543127, 0.0)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(1.4431997, 0.4065331, 2.8801242), // float3 B2o
                    nmSqToUmSq(float3(0.0937428, 0.2017152, 25.890623)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(1.482148, 0.549392, 0.0), // float3 B2e
                    nmSqToUmSq(float3(0.112315, 18.543127, 0.0)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.25, 0.1, 0.05), // float3 absorptionCoefficient
        float3(0.15, 0.05, 0.03), // float3 scatteringCoefficient
        0.3, 0.6, // float roughness, float metallic
        float3(0.4, 0.8, 0.5), // metallic reflectance
        float3(0.3, 0.8, 0.4), // float3 albedo
        nmToM(3150.0), // float thicknessM
        float3(1.576, 1.576, 1.576), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.576, 1.576, 1.576), // float3 etaO
        float3(1.566, 1.566, 1.566), // float3 etaE
        normalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.2, // float nSurrounding
        0.8, // float polarizationAngle
        0.004, // float coherenceLengthM
        22.0, // float temperatureC
        float3(2680.0, 2680.0, 2680.0), // float3 density
        float3(0.3, 0.3, 0.3), // float3 thermalConductivity
        float3(120.0, 120.0, 120.0) // float3 elasticModulus
    );
            }
            break;

        //opal
        case 4:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.8683, 0.4401, 0.8797), // float3 B1o
                    nmSqToUmSq(float3(0.13359, 0.05644, 9.1806)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.8642, 0.4002, 0.0), // float3 B1e
                    nmSqToUmSq(float3(0.1165, 10.9453, 0.0)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.8683, 0.4401, 0.8797), // float3 B2o
                    nmSqToUmSq(float3(0.13359, 0.05644, 9.1806)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.8642, 0.4002, 0.0), // float3 B2e
                    nmSqToUmSq(float3(0.1165, 10.9453, 0.0)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.15, 0.08, 0.02), // float3 absorptionCoefficient
        float3(0.12, 0.08, 0.05), // float3 scatteringCoefficient
        0.4, 0.5, // float roughness, float metallic
        float3(0.5, 0.4, 0.7), // metallic reflectance
        float3(0.8, 0.6, 0.9), // float3 albedo
        nmToM(2200.0), // float thicknessM
        float3(1.452, 1.452, 1.452), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.12, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.452, 1.452, 1.452), // float3 etaO
        float3(1.442, 1.442, 1.442), // float3 etaE
        normalize(float3(1.0, 0.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.5, // float polarizationAngle
        0.006, // float coherenceLengthM
        25.0, // float temperatureC
        float3(2000.0, 2000.0, 2000.0), // float3 density
        float3(0.15, 0.15, 0.15), // float3 thermalConductivity
        float3(40.0, 40.0, 40.0) // float3 elasticModulus
    );
            }
            break;

        //amber
        case 5:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.815, 0.451, 0.897), // float3 B1o
                    nmSqToUmSq(float3(0.1306, 0.0553, 10.1234)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.815, 0.451, 0.0), // float3 B1e
                    nmSqToUmSq(float3(0.1306, 10.1234, 0.0)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.815, 0.451, 0.897), // float3 B2o
                    nmSqToUmSq(float3(0.1306, 0.0553, 10.1234)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.815, 0.451, 0.0), // float3 B2e
                    nmSqToUmSq(float3(0.1306, 10.1234, 0.0)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.12, 0.06, 0.03), // float3 absorptionCoefficient
        float3(0.10, 0.05, 0.02), // float3 scatteringCoefficient
        0.2, 0.4, // float roughness, float metallic
        float3(0.4, 0.3, 0.1), // metallic reflectance
        float3(0.8, 0.5, 0.2), // float3 albedo
        nmToM(3150.0), // float thicknessM
        float3(1.540, 1.540, 1.540), // float3 etaR
        float3(1.1540, 1.1540, 1.1540), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.540, 1.540, 1.540), // float3 etaO
        float3(1.530, 1.530, 1.530), // float3 etaE
        normalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        0.005, // float coherenceLengthM
        20.0, // float temperatureC
        float3(1200.0, 1200.0, 1200.0), // float3 density
        float3(0.1, 0.1, 0.1), // float3 thermalConductivity
        float3(30.0, 30.0, 30.0) // float3 elasticModulus
    );
            }
            break;
        
        //calcite
        case 6:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.6867, 0.3508, 0.4523), // float3 B1o
                    nmSqToUmSq(float3(0.2006, 0.1003, 25.1004)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.7789, 0.3761, 0.0), // float3 B1e
                    nmSqToUmSq(float3(0.2079, 18.3457, 0.0)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.6867, 0.3508, 0.4523), // float3 B2o
                    nmSqToUmSq(float3(0.2006, 0.1003, 25.1004)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.7789, 0.3761, 0.0), // float3 B2e
                    nmSqToUmSq(float3(0.2079, 18.3457, 0.0)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.12, 0.05, 0.02), // float3 absorptionCoefficient
        float3(0.10, 0.08, 0.06), // float3 scatteringCoefficient
        0.3, 0.2, // float roughness, float metallic
        float3(0.3, 0.2, 0.1), // metallic reflectance
        float3(0.9, 0.8, 0.7), // float3 albedo
        nmToM(6100.0), // float thicknessM
        float3(1.658, 1.658, 1.658), // float3 etaR (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaE (extraordinary index)
        float3(0.1, 0.15, 0.2), // float3 dispersionCoefficientNm2
        float3(0.2, 0.25, 0.3), // float3 dispersionCoefficientNm2
        float3(0.3, 0.35, 0.4), // float3 dispersionCoefficientNm2
        normalize(float3(0.0, 0.0, 1.0)), // float3 opticalAxis
        float3(1.658, 1.658, 1.658), // float3 etaR (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaE (extraordinary index)
        1.0, // float nSurrounding
        0.8, // float polarizationAngle
        0.005, // float coherenceLengthM
        20.0, // float temperatureC
        float3(2710.0, 2710.0, 2710.0), // float3 density
        float3(0.3, 0.3, 0.3), // float3 thermalConductivity
        float3(80.0, 80.0, 80.0) // float3 elasticModulus
    );
            }
            break;

        //Magnesium Fluoride (MgF2)
        case 7:
{
                ret = CreateMaterialSellmeier(
        CreateSellmeierCoefficients(
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.48755108, 0.39875031, 2.3120353), // float3 B1o
                    nmSqToUmSq(float3(0.04338408, 0.09461442, 23.793604)) // float3 C1o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.49755108, 0.39875031, 2.3420353), // float3 B1e
                    nmSqToUmSq(float3(0.04538408, 0.09331442, 24.193604)) // float3 C1e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.48755108, 0.39875031, 2.3120353), // float3 B2o
                    nmSqToUmSq(float3(0.04338408, 0.09461442, 23.793604)) // float3 C2o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.49755108, 0.39875031, 2.3420353), // float3 B2e
                    nmSqToUmSq(float3(0.04538408, 0.09331442, 24.193604)) // float3 C2e
                )
            ),
            CreateSellmeierCoefficientsOE(
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3o
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                ),
                CreateSellmeierCoefficientsBC(
                    float3(0.0, 0.0, 0.0), // float3 B3e
                    nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                )
            )
        ),
        float3(0.08, 0.05, 0.02), // float3 absorptionCoefficient
        float3(0.10, 0.06, 0.04), // float3 scatteringCoefficient
        0.1, 0.5, // float roughness, float metallic
        float3(0.5, 0.5, 0.5), // metallic reflectance
        float3(0.95, 0.92, 0.90), // float3 albedo
        nmToM(4100.0), // float thicknessM
        float3(1.377, 1.377, 1.377), // float3 etaR
        float3(1.393, 1.393, 1.393), // float3 etaE
        float3(0.10, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.377, 1.377, 1.377), // float3 etaR
        float3(1.393, 1.393, 1.393), // float3 etaE
        normalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        0.003, // float coherenceLengthM
        20.0, // float temperatureC
        float3(3180.0, 3180.0, 3180.0), // float3 density
        float3(0.3, 0.3, 0.3), // float3 thermalConductivity
        float3(60.0, 60.0, 60.0) // float3 elasticModulus
    );
            }
            break;

        case 8:
        {
                ret = CreateMaterialSellmeier(
                CreateSellmeierCoefficients(
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(1.53, 1.53, 1.53), // float3 B1o
                            nmSqToUmSq(float3(0.02, 0.02, 0.02)) // float3 C1o
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(0.0, 0.0, 0.0), // float3 B1e
                            nmSqToUmSq(float3(0.04, 0.05, 0.02)) // float3 C1e
                        )
                    ),
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(1.53, 1.53, 1.53), // float3 B2o
                            nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C2o
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(0.0, 0.0, 0.0), // float3 B2e
                            nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C2e
                        )
                    ),
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(0.0, 0.0, 0.0), // float3 B3o
                            nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3o
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(0.0, 0.0, 0.0), // float3 B3e
                            nmSqToUmSq(float3(0.0, 0.0, 0.0)) // float3 C3e
                        )
                    )
                ),
                float3(0.02, 0.02, 0.02), // float3 absorptionCoefficient
                float3(0.04, 0.05, 0.02), // float3 scatteringCoefficient
                0.35, 0.4, // float roughness, float metallic
                float3(0.08, 0.06, 0.05), // metallic reflectance
                float3(0.75, 0.75, 0.75), // float3 albedo
                nmToM(1500.0), // float thicknessM
                float3(1.53, 1.53, 1.53), // float3 etaR
                float3(1.53, 1.53, 1.53), // float3 etaI
               
                    float3(0.02, 0.03, 0.02), // float3 dispersionCoefficientNm2
                    float3(0.15, 0.26, 0.15), // float3 dispersionCoefficientNm2
                    float3(0.29, 0.29, 0.29), // float3 dispersionCoefficientNm2
                float3(1.53, 1.53, 1.53), // float3 etaO
                float3(1.53, 1.53, 1.53), // float3 etaE
                float3(0.0, 0.0, 1.0), // float3 opticalAxis
                1.0, // float nSurrounding
                0.0, // float polarizationAngle
                0.025, // float coherenceLengthM
                22.0, // float temperatureC
                float3(1200.0, 1200.0, 1200.0), // float3 density
                float3(0.25, 0.25, 0.25), // float3 thermalConductivity
                float3(2.3, 2.3, 2.3) // float3 elasticModulus
            );
            }
            break;
    }

/*
    switch(index)
    {
        case 0:
        {
            ret = CreateMaterialSellmeier(
                CreateSellmeierCoefficients(
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(0.3306,0.3306,0.3306),               //float3 B1o,
                            nmSqToUmSq(float3(175.0,175.0,175.0))      //float3 C1o,
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(0.3306,0.3306,0.3306),               //float3 B1e,
                            nmSqToUmSq(float3(175.0,175.0,175.0))      //float3 C1e, 
                        )
                    ),
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(4.3356,4.3356,4.3356),               // float3 B2o,
                            nmSqToUmSq(float3(106.0,106.0,106.0))      // float3 C2o,
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(4.3356,4.3356,4.3356),               // float3 B2e,
                            nmSqToUmSq(float3(106.0,106.0,106.0))      //float3 C2e,
                        )
                    ),
                    CreateSellmeierCoefficientsOE(
                        CreateSellmeierCoefficientsBC(
                            float3(0.0,0.0,0.0),                        // float3 B3o,
                            nmSqToUmSq(float3(0.0,0.0,0.0))            // float3 C3o,
                        ),
                        CreateSellmeierCoefficientsBC(
                            float3(0.0,0.0,0.0),                        // float3 B3e,
                            nmSqToUmSq(float3(0.0,0.0,0.0))            // float3 C3e,
                        )
                    )
                ),
                float3(0.02,0.03,0.01),                     //float3 absorptionCoefficient,
                float3(0.01,0.01,0.02),                     //float3 scatteringCoefficient,
                0.05, 0.04,                                 //float roughness, float metallic,
                float3(1.0,1.0,1.0),                        //float3 albedo,
                nmToM(60.0),                                // float thicknessM,
                float3(2.417,1.417,2.117),                  //float3 etaR, 
                float3(2.417,2.417,2.417),                  //float3 etaI,
                float3(0.0,0.0,0.0),                        //float3 dispersionCoefficient,
                float3(0.0,0.0,0.0),                        //float3 dispersionCoefficient,
                float3(0.0,0.0,0.0),                        //float3 dispersionCoefficient,
                float3(2.417,2.417,2.417),                  //float3 etaO,
                float3(2.417,2.417,2.417),                  //float3 etaE,
                float3(0.0,0.0,1.0),                        //float3 opticalAxis,
                1.0,                                        //float nSurrounding,
                0.0,                                        //float polarizationAngle,
                0.05,                                       //float coherenceLengthM, 
                25.0,                                       //float temperatureC, 
                float3(3500.0,3500.0,3500.0),               //float3 density,
                float3(1000.0,1000.0,1000.0),               //float3 thermalConductivity,
                float3(1050.0,1050.0,1050.0)                //float3 elasticModulus
            );
        }
        break;
        case 1:
        {
            ret=CreateMaterialSellmeier(float3(1.03961212,0.231792344,1.01046945),float3(0.231792344,1.01046945,0.0),float3(1.01046945,0.0,0.0),nmSqToUmSq(float3(6.00069867e1,2.00179144e2,1.03560653e6)),nmSqToUmSq(float3(2.00179144e2,1.03560653e6,0.0)),nmSqToUmSq(float3(1.03560653e6,0.0,0.0)),float3(1.03961212,0.231792344,1.01046945),float3(0.231792344,1.01046945,0.0),float3(1.01046945,0.0,0.0),nmSqToUmSq(float3(6.00069867e1,2.00179144e2,1.03560653e6)),nmSqToUmSq(float3(2.00179144e2,1.03560653e6,0.0)),nmSqToUmSq(float3(1.03560653e6,0.0,0.0)),float3(0.02,0.01,0.02),float3(0.06,0.07,0.04),0.045,0.04,float3(0.99,0.98,1.0),nmToM(150.0),float3(1.517,1.517,1.517),float3(1.517,1.517,1.517),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.517,1.517,1.517),float3(1.517,1.517,1.517),float3(0.0,0.0,1.0),1.0,0.0,0.04,20.0,float3(2200.0,2200.0,2200.0),float3(1.3,1.3,1.3),float3(64.0,64.0,64.0));
        }
        break;
        case 2:
        {
            ret=CreateMaterialSellmeier(float3(1.4313493,0.65054713,5.3414021),float3(0.65054713,5.3414021,0.0),float3(5.3414021,0.0,0.0),nmSqToUmSq(float3(0.0726631,0.1193242,18.028251)),nmSqToUmSq(float3(0.1193242,18.028251,0.0)),nmSqToUmSq(float3(18.028251,0.0,0.0)),float3(1.5039759,0.55069141,6.5927379),float3(0.55069141,6.5927379,0.0),float3(6.5927379,0.0,0.0),nmSqToUmSq(float3(0.0740288,0.1216529,20.072248)),nmSqToUmSq(float3(0.1216529,20.072248,0.0)),nmSqToUmSq(float3(20.072248,0.0,0.0)),float3(0.1,0.05,0.02),float3(0.07,0.09,0.1),0.05,0.05,float3(0.8,0.8,0.9),nmToM(300.0),float3(1.768,1.768,1.768),float3(1.768,1.768,1.768),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.768,1.768,1.768),float3(1.760,1.760,1.760),normalize(float3(0.0,0.0,1.0)),1.0,0.0,0.06,30.0,float3(4000.0,4000.0,4000.0),float3(34.0,34.0,34.0),float3(400.0,400.0,400.0));
        }
        break;
        case 3:
        {
            ret=CreateMaterialSellmeier(float3(0.5675888,0.4710914,3.8484723),float3(0.4710914,3.8484723,0.0),float3(3.8484723,0.0,0.0),nmSqToUmSq(float3(0.050263605,0.1003909,34.6490)),nmSqToUmSq(float3(0.1003909,34.6490,0.0)),nmSqToUmSq(float3(34.6490,0.0,0.0)),float3(0.5675888,0.4710914,3.8484723),float3(0.4710914,3.8484723,0.0),float3(3.8484723,0.0,0.0),nmSqToUmSq(float3(0.050263605,0.1003909,34.6490)),nmSqToUmSq(float3(0.1003909,34.6490,0.0)),nmSqToUmSq(float3(34.6490,0.0,0.0)),float3(0.1,0.0,0.0),float3(0.01,0.1,0.01),0.23,0.34,float3(0.7,0.9,1.0),nmToM(100.0),float3(1.43384,1.43384,1.43384),float3(1.33384,1.43384,1.73384),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.43384,1.43384,1.43384),float3(1.43384,1.43384,1.43384),normalize(float3(1.0,0.0,0.0)),1.0,1.5,0.03,22.0,float3(3100.0,3100.0,3100.0),float3(0.2,0.2,0.2),float3(200.0,200.0,200.0));
        }
        break;
        case 4:
        {
            ret=CreateMaterialSellmeier(float3(0.99654,0.18964,0.00411),float3(0.18964,0.00411,0.0),float3(0.00411,0.0,0.0),nmSqToUmSq(float3(0.00787,0.02135,4.182)),nmSqToUmSq(float3(0.02135,4.182,0.0)),nmSqToUmSq(float3(4.182,0.0,0.0)),float3(0.99654,0.18964,0.00411),float3(0.18964,0.00411,0.0),float3(0.00411,0.0,0.0),nmSqToUmSq(float3(0.00787,0.02135,4.182)),nmSqToUmSq(float3(0.02135,4.182,0.0)),nmSqToUmSq(float3(4.182,0.0,0.0)),float3(0.240,0.140,0.240),float3(0.180,0.180,0.1280),0.5,0.45,float3(0.75,0.70,0.70),nmToM(250.0),float3(1.489,1.489,1.489),float3(1.489,1.489,1.489),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.489,1.489,1.489),float3(1.489,1.489,1.489),float3(0.0,1.0,0.0),1.0,0.8,0.07,28.0,float3(1180.0,1180.0,1180.0),float3(0.2,0.2,0.2),float3(3.0,3.0,3.0));
        }
        break;
        case 5:
        {
            ret=CreateMaterialSellmeier(float3(1.5,1.5,1.5),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.5,1.5,1.5),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.50,0.40,0.50),float3(0.40,0.50,0.40),0.02,0.04,float3(1.0,1.0,1.0),nmToM(500.0),float3(1.5,1.5,1.5),float3(1.5,1.5,1.5),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.5,1.5,1.5),float3(1.5,1.5,1.5),float3(0.0,0.0,1.0),1.0,0.0,0.02,25.0,float3(1200.0,1200.0,1200.0),float3(0.5,0.5,0.5),float3(2.5,2.5,2.5));
        }
        break;
        case 6:
        {
            ret=CreateMaterialSellmeier(float3(1.6,1.6,1.6),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.6,1.6,1.6),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.02,0.01,0.0),float3(0.01,0.02,0.02),0.03,0.035,float3(0.8,0.8,0.8),nmToM(1000.0),float3(1.6,1.6,1.6),float3(1.6,1.6,1.6),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.6,1.6,1.6),float3(1.6,1.6,1.6),float3(0.0,0.0,1.0),1.0,0.0,0.03,25.0,float3(1100.0,1100.0,1100.0),float3(0.25,0.25,0.25),float3(2.3,2.3,2.3));
        }
        break;
        case 7:
        {
            ret=CreateMaterialSellmeier(float3(1.45,1.45,1.45),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.45,1.45,1.45),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.01,0.01,0.01),float3(0.03,0.02,0.02),0.02,0.14,float3(0.75,0.75,0.75),nmToM(280.0),float3(1.45,1.45,1.45),float3(1.45,1.45,1.45),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.45,1.45,1.45),float3(1.45,1.45,1.45),float3(0.0,0.0,1.0),1.0,0.0,0.02,20.0,float3(1300.0,1300.0,1300.0),float3(0.3,0.3,0.3),float3(2.8,2.8,2.8));
        }
        break;
        case 8:
        {
            ret=CreateMaterialSellmeier(float3(1.53,1.53,1.53),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.53,1.53,1.53),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.02,0.02,0.02),float3(0.04,0.05,0.02),0.03,0.04,float3(0.75,0.75,0.75),nmToM(1500.0),float3(1.53,1.53,1.53),float3(1.53,1.53,1.53),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(0.0,0.0,0.0),float3(1.53,1.53,1.53),float3(1.53,1.53,1.53),float3(0.0,0.0,1.0),1.0,0.0,0.025,22.0,float3(1200.0,1200.0,1200.0),float3(0.25,0.25,0.25),float3(2.3,2.3,2.3));
        }
        break;
    }*/

    return ret;

}

// Helper function for sinc
inline float3 sinc(float3 x)
{
    return sin(x) / max(EPSILON3, abs(x));
}


float3 CalculateGratingEfficiency(
    float3 gratingNormal,
    float3 wavelengthsNM,
    float3 incidentDir,
    float3 diffractionDir,
    float grooveDepthM,
    float3 refractiveIndex,
    float scalar)
{
    // Normalize input vectors
    gratingNormal = safeNormalize(gratingNormal);
    incidentDir = safeNormalize(incidentDir);
    diffractionDir = safeNormalize(diffractionDir);

    // Calculate angles
    float3 cosThetaI = dot3(gratingNormal, incidentDir);
    float3 cosThetaD = dot3(gratingNormal, diffractionDir);

    // Calculate grating equation terms
    float3 deltaBeta = (2.0 * PI / wavelengthsNM) * (cosThetaD - cosThetaI);

    // Calculate efficiency using a simplified model (e.g., scalar diffraction theory)
    float3 efficiency = (sinc(deltaBeta * grooveDepthM * 0.5)) * (sinc(deltaBeta * grooveDepthM * 0.5));
    efficiency *= exp(-scalar * deltaBeta * deltaBeta); // Gaussian envelope

    // Ensure efficiency is non-negative and normalized
    efficiency = saturate(efficiency);

    return efficiency;
}


inline float sigmoid(float x)
{
    return 1.0 / (1.0 + exp(-x));
}
inline float2 sigmoid(float2 x)
{
    return ONE2 / (ONE2 + exp(-x));
}
inline float3 sigmoid(float3 x)
{
    return ONE3 / (ONE3 + exp(-x));

}
inline float4 sigmoid(float4 x)
{
    return ONE4 / (ONE4 + exp(-x));

}
// Inverse sigmoid, useful for reversing the effect of sigmoid
float invSigmoid(float y)
{
	// Ensure y is within (0, 1) as sigmoid output is in this range
    y = clamp(y, 0.00001, 0.99999);
    return log(y / (1.0 - y));
}

inline float safeNormalizeRange(float edge0, float edge1, float x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / (edge1 - edge0));
}
inline float2 safeNormalizeRange(float2 edge0, float2 edge1, float2 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / (edge1 - edge0));
}
inline float3 safeNormalizeRange(float3 edge0, float3 edge1, float3 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / (edge1 - edge0));
}
inline float4 safeNormalizeRange(float4 edge0, float4 edge1, float4 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / (edge1 - edge0));
}
// Smootherstep function
inline float smootherstep(float edge0, float edge1, float x, float steepness = 1.0)
{
	// Scale, bias, and saturate x to 0..1 range
    x = saturate((x - edge0) / (edge1 - edge0));
	// Adjust steepness
    x = pow(x, steepness);
	// Evaluate polynomial
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}
inline float2 smootherstep(float2 edge0, float2 edge1, float2 x)
{
    return float2(smootherstep(edge0.x, edge1.x, x.x), smootherstep(edge0.y, edge1.y, x.y));

}
inline float3 smootherstep(float3 edge0, float3 edge1, float3 x)
{
    return float3(smootherstep(edge0.xy, edge1.xy, x.xy), smootherstep(edge0.z, edge1.z, x.z));
}
inline float4 smootherstep(float4 edge0, float4 edge1, float4 x)
{
    return float4(smootherstep(edge0.xyz, edge1.xyz, x.xyz), smootherstep(edge0.w, edge1.w, x.w));
}

// lerp function using smootherstep
inline float moilerpX(float2 range, float t, float stepRangeMin, float stepRangeMax, float steepness)
{
    float s = smootherstep(stepRangeMin, stepRangeMax, t);
    return lerp(range.x, range.y, s);
}
inline float moilerp01(float a, float b, float t)
{
    return moilerpX(float2(a, b), t, 0.0, 1.0, 1.0);
}
inline float moilerp01(float2 range, float t)
{
    return moilerpX(range, t, 0.0, 1.0, 1.0);
}

inline float moilerp11(float2 range, float t)
{
    return moilerpX(range, t, -1.0, 1.0, 1.0);
}
inline float moilerp11(float a, float b, float t)
{
    return moilerpX(float2(a, b), t, -1.0, 1.0, 1.0);
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


// Returns the cosine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float cosTime01(float timeMul)
{
    return clamp((1.0 + cos(fmod(TotalTime * timeMul, TWOPI))) * 0.5, EPSILON, OneMinusEPSILON);
}

// Returns the sine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float sinTime01(float timeMul)
{
    return clamp((1.0 + sin(fmod(TotalTime * timeMul, TWOPI))) * 0.5, EPSILON, OneMinusEPSILON);
}
// Returns the cosine of the total time multiplied by a given factor, safeNormalize to the range [1, 1].
inline float cosTime11(float timeMul)
{
    return clamp(cosTime01(timeMul) * 2.0 - 1.0, -OneMinusEPSILON, OneMinusEPSILON);
}
// Returns the sine of the total time multiplied by a given factor, safeNormalize to the range [0, 1].
inline float sinTime11(float timeMul)
{
    return clamp(sinTime01(timeMul) * 2.0 - 1.0, -OneMinusEPSILON, OneMinusEPSILON);
}

#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)



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
	  0.9980983, 0.999112, 0.9997482, 1.0, 0.9998567, 0.9993046, 0.9983255,
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



inline float2 RotateUV(float2 uv, float angleRadians)
{
    float cosAngle, sinAngle;
    sincos(angleRadians, sinAngle, cosAngle);
    float2 center = float2(0.5, 0.5);
    float2 translatedUV = uv - center;
    float2 rotatedUV;
    rotatedUV.x = translatedUV.x * cosAngle - translatedUV.y * sinAngle;
    rotatedUV.y = translatedUV.x * sinAngle + translatedUV.y * cosAngle;
    return rotatedUV + center;
}

inline float2 RotateAroundPoint(float2 segment, float angle, float2 center)
{
    // Translate point to origin
    float2 translated = segment - center;
    
    // Apply rotation
    float2 rotated;
    sincos(angle, rotated.x, rotated.y);
    rotated.x = translated.x * rotated.y - translated.y * sin(angle);
    rotated.y = translated.x * rotated.x + translated.y * cos(angle);
    
    // Translate back
    return rotated + center;
}

// Rotates UV coordinates with depth-based influence
inline float2 RotateUVWithDepth(float2 uv, float depth, float angleRadians)
{
	// Rotation matrix components
    float sinAngle, cosAngle;
    sincos(angleRadians, sinAngle, cosAngle);

	// Translate UV to center (0.5, 0.5) before rotation
    float2 centeredUV = uv - 0.5;

	// Apply the rotation with depth influence
    float depthInfluence = (1.0 - depth / DepthScale); // Clamp between 0 and 1
    float2 rotatedUV = float2(centeredUV.x * cosAngle - centeredUV.y * sinAngle,
		centeredUV.x * sinAngle + centeredUV.y * cosAngle
	);

	// Blend between rotated and original based on depth
    return lerp(float3(centeredUV, depth), float3(rotatedUV, depth), depthInfluence).xy + 0.5;
}


float4 matrixToQuaternion(float3x3 rotationMatrix)
{
    float4 quaternion;

    float trace = rotationMatrix._m00 + rotationMatrix._m11 + rotationMatrix._m22;

    // Calculate conditions
    bool tracePositive = trace > 0.0;

    // Initialize S, based on trace
    float S_trace = sqrt(trace + 1.0) * 2.0; // S=4*qw

    // Compute quaternion components when trace is positive
    float qw_trace = 0.25 * S_trace;
    float qx_trace = (rotationMatrix._m21 - rotationMatrix._m12) / S_trace;
    float qy_trace = (rotationMatrix._m02 - rotationMatrix._m20) / S_trace;
    float qz_trace = (rotationMatrix._m10 - rotationMatrix._m01) / S_trace;

    // Conditions for diagonal dominance
    bool m00Dominant = rotationMatrix._m00 > rotationMatrix._m11 && rotationMatrix._m00 > rotationMatrix._m22;
    bool m11Dominant = rotationMatrix._m11 > rotationMatrix._m22;

    // Compute S and quaternion components for each case
    float S_m00 = sqrt(1.0 + rotationMatrix._m00 - rotationMatrix._m11 - rotationMatrix._m22) * 2.0;
    float qw_m00 = (rotationMatrix._m21 - rotationMatrix._m12) / S_m00;
    float qx_m00 = 0.25 * S_m00;
    float qy_m00 = (rotationMatrix._m01 + rotationMatrix._m10) / S_m00;
    float qz_m00 = (rotationMatrix._m02 + rotationMatrix._m20) / S_m00;

    float S_m11 = sqrt(1.0 + rotationMatrix._m11 - rotationMatrix._m00 - rotationMatrix._m22) * 2.0;
    float qw_m11 = (rotationMatrix._m02 - rotationMatrix._m20) / S_m11;
    float qx_m11 = (rotationMatrix._m01 + rotationMatrix._m10) / S_m11;
    float qy_m11 = 0.25 * S_m11;
    float qz_m11 = (rotationMatrix._m12 + rotationMatrix._m21) / S_m11;

    float S_m22 = sqrt(1.0 + rotationMatrix._m22 - rotationMatrix._m00 - rotationMatrix._m11) * 2.0;
    float qw_m22 = (rotationMatrix._m10 - rotationMatrix._m01) / S_m22;
    float qx_m22 = (rotationMatrix._m02 + rotationMatrix._m20) / S_m22;
    float qy_m22 = (rotationMatrix._m12 + rotationMatrix._m21) / S_m22;
    float qz_m22 = 0.25 * S_m22;

    // Select the appropriate quaternion components based on conditions
    quaternion.w = (tracePositive) ? qw_trace : ((m00Dominant) ? qw_m00 : ((m11Dominant) ? qw_m11 : qw_m22));
    quaternion.x = (tracePositive) ? qx_trace : ((m00Dominant) ? qx_m00 : ((m11Dominant) ? qx_m11 : qx_m22));
    quaternion.y = (tracePositive) ? qy_trace : ((m00Dominant) ? qy_m00 : ((m11Dominant) ? qy_m11 : qy_m22));
    quaternion.z = (tracePositive) ? qz_trace : ((m00Dominant) ? qz_m00 : ((m11Dominant) ? qz_m11 : qz_m22));

    // Normalize the quaternion
    return normalize(quaternion);
}


inline float4 renderQuantumFluctuation(float2 uv, float energyJ, float momentumKgMs)
{
    float2 pos = uv * 2.0 - 1.0;
    float r = length(pos);
    float a = atan2(pos.y, pos.x);
    float f = sin(r * energyJ * 0.01 + a * momentumKgMs * 0.01);
    return float4(f * 0.5 + 0.5, f * 0.5 + 0.5, f * 0.5 + 0.5, 1.0);
}


inline float4 RotateAroundX(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float4(v.x, c * v.y - s * v.z, s * v.y + c * v.z, v.w);
}
inline float3 RotateAroundX(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float3(v.x, c * v.y - s * v.z, s * v.y + c * v.z);
}
inline float2 RotateAroundX(float2 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float2(v.x, c * v.y - s);
}
inline float4 RotateAroundY(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float4(c * v.x + s * v.z, v.y, -s * v.x + c * v.z, v.w);
}
inline float3 RotateAroundY(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float3(c * v.x + s * v.z, v.y, -s * v.x + c * v.z);
}
inline float2 RotateAroundY(float2 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float2(c * v.x + s, v.y);
}
inline float4 RotateAroundZ(float4 v, float angle)
{
    float s, c;
    sincos(angle, s, c);

    return float4(c * v.x - s * v.y, s * v.x + c * v.y, v.z, v.w);
}

// Function to safely normalize a vector
// Function to rotate a float3 vector around an arbitrary axis using Rodrigues' rotation formula
inline float3 RotateAxisAngle(float3 v, float3 axis, float angle)
{
    axis = safeNormalize(axis);
    float sinA, cosA;
    sincos(angle, sinA, cosA); // Compute sine and cosine of the angle
    
    // Rodrigues' rotation formula
    return v * cosA + cross(axis, v) * sinA + axis * dot(axis, v) * (1.0 - cosA);
}
inline float4 RotateAxisAngle(float4 v, float3 axis, float angle)
{
    return float4(RotateAxisAngle(v.xyz, axis, angle), v.w);
}
inline float3 RotateAroundXAxis(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    
    float3x3 Rx;
    Rx[0] = float3(1.0, 0.0, 0.0);
    Rx[1] = float3(0.0, c, -s);
    Rx[2] = float3(0.0, s, c);
    
    return mul(Rx, v);
}

inline float3 RotateAroundYAxis(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    
    float3x3 Ry;
    Ry[0] = float3(c, 0.0, s);
    Ry[1] = float3(0.0, 1.0, 0.0);
    Ry[2] = float3(-s, 0.0, c);
    
    return mul(Ry, v);
}

inline float3 RotateAroundZAxis(float3 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    
    float3x3 Rz;
    Rz[0] = float3(c, -s, 0.0);
    Rz[1] = float3(s, c, 0.0);
    Rz[2] = float3(0.0, 0.0, 1.0);
    
    return mul(Rz, v);
}

inline float2 RotateAroundZ(float2 v, float angle)
{
    return RotateAxisAngle(float3(v, 0), float3(0, 0, 1), fmod(angle, TWOPI)).xy;
}

inline float4 QuaternionFromAxisAngle(float3 axis, float angle)
{
    float halfAngle = angle * 0.5;
    float s = sin(halfAngle);
    return float4(axis * s, cos(halfAngle));
}

inline float3 RotateVectorByQuaternion(float3 v, float4 q)
{
    float3 qvec = q.xyz;
    float3 uv = cross(qvec, v);
    float3 uuv = cross(qvec, uv);
    return v + ((uv * q.w) + uuv) * 2.0;
}

// Using half precision (16-bit)
inline float Determinant3x3_half(float3x3 m)
{
    return
		m._11 * (m._22 * m._33 - m._23 * m._32) -
		m._12 * (m._21 * m._33 - m._23 * m._31) +
		m._13 * (m._21 * m._32 - m._22 * m._31);
}

inline float3x3 InvertMatrix3x3_half(float3x3 m)
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

inline float3 TransformNormal(float3 v, float4x4 m)
{
    return normalize(mul(transpose(inverse((float3x3) m)), v));
}

inline float3 TransformPoint(float3 v, float4x4 m)
{
    float4 transformed = mul(m, float4(v, 1.0));
    return transformed.xyz / transformed.w;
}

inline float4x4 CreateOrthographicMatrix(float left, float right, float bottom, float top, float zNear, float zFar)
{
    float2 invWidthHeight = 2.0 / float2(right - left, top - bottom);
    float invDepth = 1.0 / (zFar - zNear);
    
    return float4x4(
        float4(invWidthHeight.x, 0.0, 0.0, -(right + left) * 0.5 * invWidthHeight.x),
        float4(0.0, invWidthHeight.y, 0.0, -(top + bottom) * 0.5 * invWidthHeight.y),
        float4(0.0, 0.0, invDepth, -zNear * invDepth),
        float4(0.0, 0.0, 0.0, 1.0)
    );
}

inline float4x4 CreatePerspectiveMatrix(float fovY, float aspect, float zNear, float zFar)
{
    float yScale = 1.0 / tan(fovY * 0.5);
    float xScale = yScale / aspect;
    float zRange = zFar / (zNear - zFar);
    
    return float4x4(
        float4(xScale, 0.0, 0.0, 0.0),
        float4(0.0, yScale, 0.0, 0.0),
        float4(0.0, 0.0, zRange, (zNear * zFar) / (zNear - zFar)),
        float4(0.0, 0.0, -1.0, 0.0)
    );
}
inline float4x4 CreateLookAtMatrix(float3 eye, float3 target, float3 up)
{
    float3 zaxis = normalize(target - eye);
    float3 xaxis = normalize(cross(up, zaxis));
    float3 yaxis = cross(zaxis, xaxis);
    
    return float4x4(
        float4(xaxis, -dot(xaxis, eye)),
        float4(yaxis, -dot(yaxis, eye)),
        float4(zaxis, -dot(zaxis, eye)),
        float4(0.0, 0.0, 0.0, 1.0)
    );
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
        float q = lerp((hsl.l * (1.0f + hsl.s)), (hsl.l + hsl.s - hsl.l * hsl.s), step(hsl.l, 0.5f));
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
    return mul(color, hueRotation);
}

struct HologramData
{
    float3 Color;
    float3 WavelengthsNM;
    float3 Pixel;
};

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

struct PhasedLightSource
{
    float3 position;
    float3 worldPos;
    float3 diffuse;
    float3 wavelengthNM;
    float intensity;
    float3 phase; // phase at worldPos
    float amplitude; // amplitude
    float3 direction; // direction of light
    float re; // real part of complex amplitude
    float im; // imaginary part of complex amplitude
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
    float amplitude; // Strength of the interference pattern
    float3 frequency; // Frequency of the pattern in 3D space
    float phase; // Phase shift for the pattern
};

struct PathMeasurement
{
    float3 PathLengthM;
    float3 PathTotalLengthM;
    float3 PathDifferenceM;
};

struct PhaseInterference
{
    float3 opticalPathDifference;
    float3 phaseDifference;
    float3 phaseShift;
    float3 totalPhase;
    float3 cosThetaT;
};

PhaseInterference CreatePhaseInterference(
    float3 opticalPathDifference,
    float3 phaseDifference,
    float3 phaseShift,
    float3 totalPhase,
    float3 cosThetaT)
{
    PhaseInterference ret = (PhaseInterference) 0;
    ret.opticalPathDifference = opticalPathDifference;
    ret.phaseDifference = phaseDifference;
    ret.phaseShift = phaseShift;
    ret.totalPhase = totalPhase;
    ret.cosThetaT = cosThetaT;
    return ret;
}

inline PathMeasurement CreatePathMeasurement(float3 PathLengthM, float3 PathTotalLengthM, float3 PathDifferenceM)
{
    PathMeasurement ret;
    ret.PathLengthM = PathLengthM;
    ret.PathTotalLengthM = PathTotalLengthM;
    ret.PathDifferenceM = PathDifferenceM;
    return ret;
}

struct OpticalPathResult
{
    float3 wavelengthsNM;
    float3 refractiveIndex;
    PathMeasurement measurement;
    PathMeasurement opticalMeasurement;
    PhaseInterference phaseInterference;
    float3 intensityModulation;
    float3 absorptionEffect;
};

inline OpticalPathResult CreateOpticalPathResult(
    float3 wavelengthsNM,
    float3 refractiveIndex,
    PathMeasurement measurement,
    PathMeasurement opticalMeasurement,
    PhaseInterference phaseInterference,
    float3 intensityModulation,
    float3 absorptionEffect)
{
    OpticalPathResult ret;
    ret.wavelengthsNM = wavelengthsNM;
    ret.refractiveIndex = refractiveIndex;
    ret.measurement = measurement;
    ret.opticalMeasurement = opticalMeasurement;
    ret.phaseInterference = phaseInterference;
    ret.intensityModulation = intensityModulation;
    ret.absorptionEffect = absorptionEffect;
    return ret;
}
inline float3 ReinhardToneMapping(float3 color)
{
    return color / (color + 1.0);
}
inline float4 ReinhardToneMapping(float4 color)
{
    return float4(ReinhardToneMapping((color / (color + 1.0)).rgb), color.a);
}

inline float3 ApplyHDR(float3 color, float exposure)
{
    color *= exposure;
    return ReinhardToneMapping(color);
}

inline float4 ApplyHDR(float4 color, float exposure)
{
    return float4(ApplyHDR(color.rgb, exposure), color.a);
}
// Apply absorption using Beer-Lambert Law
inline float3 apply_absorption(float3 color, float distance, float3 absorptionCoefficient)
{
    return color * exp(-absorptionCoefficient * distance);
}

// Apply lighting with diffuse and ambient components
inline float3 apply_lighting(float3 color, float3 normal, float3 lightDir, float3 ambientLight, float3 lightColor)
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


// Accurate calculation of light travel distance
inline float calc_distance(float3 viewerPos, float3 pointPos)
{
    return length(viewerPos - pointPos);
}



inline float3 LinearRGBToSRGB(float3 linearRGB)
{
    float3 srgb;
    linearRGB = clamp(linearRGB, EPSILON3, OneMinusEPSILON3);
    srgb.x = max(EPSILON, lerp((linearRGB.x * 12.92), (1.055 * pow(max(linearRGB.x, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.x, 0.0031309)));
    srgb.y = max(EPSILON, lerp((linearRGB.y * 12.92), (1.055 * pow(max(linearRGB.y, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.y, 0.0031309)));
    srgb.z = max(EPSILON, lerp((linearRGB.z * 12.92), (1.055 * pow(max(linearRGB.z, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.z, 0.0031309)));
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

inline float3 XYZToLinearRGB2(float3 XYZ)
{
    return float3(3.2406 * XYZ.x - 1.5372 * XYZ.y - 0.4986 * XYZ.z,
		-0.9689 * XYZ.x + 1.8758 * XYZ.y + 0.0415 * XYZ.z,
		0.0557 * XYZ.x - 0.2040 * XYZ.y + 1.0570 * XYZ.z);
}

inline float3 XYZToLinearRGB_Combined(float3 XYZ0, float3 XYZ1, float3 XYZ2)
{
    // Convert each XYZ vector to linear RGB
    float3 RGB0 = XYZToLinearRGB2(XYZ0);
    float3 RGB1 = XYZToLinearRGB2(XYZ1);
    float3 RGB2 = XYZToLinearRGB2(XYZ2);
    
    // Combine the RGB values by summing them
    float3 combinedRGB = RGB0 + RGB1 + RGB2;
    
    // Optionally, clamp the combined RGB to [0,1]
    combinedRGB = clamp(combinedRGB, 0.0, 1.0);
    
    return combinedRGB;
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

inline float3 LinearRGBToXYZ2(float3 linearRGB)
{
    // Conversion matrix from linear RGB (sRGB D65) to XYZ
    float3 XYZ = float3(
        3.2406 * linearRGB.x - 1.5372 * linearRGB.y - 0.4986 * linearRGB.z,
        -0.9689 * linearRGB.x + 1.8758 * linearRGB.y + 0.0415 * linearRGB.z,
        0.0557 * linearRGB.x - 0.2040 * linearRGB.y + 1.0570 * linearRGB.z
    );
    
    // Optional: Clamp XYZ values to handle out-of-gamut colors
    XYZ = clamp(XYZ, 0.0, 1.0);
    
    return XYZ;
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

#define GET_SZ(postfix,texType,retType)                     \
inline retType GetSz##postfix(Texture2D<texType> tex)         \
{                                                           \
    retType sz;                                             \
    tex.GetDimensions(sz.x, sz.y);                          \
    return sz;                                              \
}

GET_SZ(_1i, float, int2)
GET_SZ(_1ui, float, uint2)
GET_SZ(_1, float, float2)

GET_SZ(_2i, float2, int2)
GET_SZ(_2ui, float2, uint2)
GET_SZ(_2, float2, float2)

GET_SZ(_3i, float3, int2)
GET_SZ(_3ui, float3, uint2)
GET_SZ(_3, float3, float2)

GET_SZ(_4i, float4, int2)
GET_SZ(_4ui, float4, uint2)
GET_SZ(_4, float4, float2)

#define GET_OOSZ(postfix, texType)              \
inline float2 GetOosz(Texture2D<texType> tex)     \
{                                               \
    float2 sz = GetSz##postfix(tex);            \
    return ONE2 / sz;                           \
}

GET_OOSZ(_1, float);
GET_OOSZ(_2, float2);
GET_OOSZ(_3, float3);
GET_OOSZ(_4, float4);

inline float3 RGBToGrayscale(float3 color)
{
    return dot3(color, float3(0.2989, 0.5870, 0.1140));
}

inline float3 RGBToLuminance(float3 color)
{
    return dot3(color, float3(0.299, 0.587, 0.114));
}

inline float3 RGBToBrightness(float3 color)
{
    return dot3(color, float3(0.2126, 0.7152, 0.0722));
}

inline float2 gradient(float2 range, float value)
{
    float2 n = safeNormalizeRange(range.x, range.y, value);
    return float2(sigmoid(1.0 - n.x), sigmoid(1.0 - n.y));
}

inline float2 gradient(float2 range, float2 value)
{
    float nx = smootherstep(range.x, range.y, value.x);
    float ny = safeNormalizeRange(range.x, range.y, value.y);
    return float2(sigmoid(1.0 - nx), sigmoid(1.0 - ny));
}

inline float2 adjustDepthGradientSigmoid(float2 depthGradient, float2 nearFar)
{
    float2 gx = gradient(nearFar, depthGradient.x);
    float2 gy = gradient(nearFar, depthGradient.y);

    return float2(lerp(nearFar.x, nearFar.y, saturate(gx.x)), lerp(nearFar.x, nearFar.y, saturate(gx.y)));
}


static float2 DepthRange = float2(MIN_DEPTH_RANGE, DepthScale);
inline float3 LightSigmoid(float value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT)
{
    scalar = max(scalar, EPSILON);
    float d = lerp(EPSILON, OneMinusEPSILON, (max(((value - 0.5) * speedOfLight) - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE) + 0.5) / scalar;
    float v1 = (d - 0.5) * speedOfLight;
    float v = max(v1 - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE + 0.5;
    float d2 = clamp(v, EPSILON, OneMinusEPSILON);
    return sigmoid(length(lerp(min(d, d2), max(d, d2), saturate((OneMinusEPSILON - d2) * d))));
}

inline float3 LightSigmoid(float3 value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT)
{
    scalar = max(scalar, EPSILON);
    float3 d = lerp(EPSILON3, OneMinusEPSILON3, ((max(((value - 0.5) * speedOfLight) - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES) + 0.5)) / max(scalar, EPSILON);
    float3 v1 = (d - 0.5) * speedOfLight;
    float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + 0.5;
    float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
    return sigmoid(length(lerp(min(d, d2), max(d, d2), saturate((OneMinusEPSILON3 - d2) * d))));
}
inline float2 toDepthRange(float2 depthRangeParam, bool useProjectedDepth)
{
    float distSqr = dot(depthRangeParam, depthRangeParam);
    float noRange = step(distSqr, EPSILON);
    float2 projectedRange = float2(MIN_DEPTH_RANGE, DepthScale);
    float2 normalRange = float2(MIN_DEPTH_RANGE, MAX_DEPTH_RANGE);
    float2 chosen = lerp(normalRange, projectedRange, (float) useProjectedDepth);
    return lerp(depthRangeParam, chosen, noRange);
}

inline float projectDepth(float depth)
{
    return lerp(DepthRange.x, DepthRange.y, clamp(depth, MIN_DEPTH_RANGE, MAX_DEPTH_RANGE));
}

inline float4 depthRaw4(Texture2D<float> depthMap, float2 uv, bool invertDepth)
{
    float2 oosz = GetOosz(depthMap);
    
    float d1 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(-oosz.x, -oosz.y), 0);
    float d2 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(oosz.x, -oosz.y), 0);
    float d3 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(oosz.x, oosz.y), 0);
    float d4 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(-oosz.x, oosz.y), 0);
    float4 d = clamp(float4(d1, d2, d3, d4), float4(MIN_DEPTH_RANGE, MIN_DEPTH_RANGE, MIN_DEPTH_RANGE, MIN_DEPTH_RANGE), float4(MAX_DEPTH_RANGE, MAX_DEPTH_RANGE, MAX_DEPTH_RANGE, MAX_DEPTH_RANGE));
  
    return lerp(d, 1.0 - d, invertDepth);
}

inline float depth2D(Texture2D<float> depthMap, float2 uv, bool invertDepth = true, bool useProjectedDepth = false)
{
    float4 d = depthRaw4(depthMap, uv, invertDepth);
    float d0 = depthMap.SampleLevel(sampleTypeMirror, uv, 0);
    d0 = lerp(d0, 1.0 - d0, invertDepth);
    float ret = lerp((d.x + d.y + d.z + d.w) * .25, d0, .6);
    ret = lerp(ret, DepthScale * ret, useProjectedDepth);
    return ret;

}

Complex3 Fresnel(float3 cosThetaI, Complex3 eta, float cosTheta)
{
    float3 sinThetaI = sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    Complex3 sinThetaT = ComplexDiv(ComplexCreate(sinThetaI, cosThetaI), eta);
    Complex3 cosThetaT = ComplexSqrt(ComplexSub(ComplexCreate(1.0, 1.0, 1.0), ComplexMul(sinThetaT, sinThetaT)));

    Complex3 rs_num = ComplexSub(ComplexMul(eta, ComplexCreate(cosThetaI, sinThetaT.imag)), cosThetaT);
    Complex3 rs_den = ComplexAdd(ComplexMul(eta, ComplexCreate(cosThetaI, sinThetaT.imag)), cosThetaT);
    Complex3 rs = ComplexDiv(rs_num, rs_den);

    Complex3 rp_num = ComplexSub(ComplexMul(eta, cosThetaT), ComplexCreate(cosThetaI, sinThetaT.imag));
    Complex3 rp_den = ComplexAdd(ComplexMul(eta, cosThetaT), ComplexCreate(cosThetaI, sinThetaT.imag));
    Complex3 rp = ComplexDiv(rp_num, rp_den);

    float3 Rs = ComplexAbs(rs) * ComplexAbs(rs);
    float3 Rp = ComplexAbs(rp) * ComplexAbs(rp);
    float3 R = lerp(Rs, Rp, cosTheta);

    return ComplexCreate(1.0 - R, ZERO3);
}



// Remap a value from one range to another using sigmoid for smooth transition
inline float remapSigmoid(float value, float oldMin, float oldMax, float newMin, float newMax)
{
	// safeNormalize the value to [0, 1] range
    float safeNormalized = (value - oldMin) / (oldMax - oldMin);
	// Apply sigmoid for smooth transition
    float sigmoidValue = sigmoid(safeNormalized * 10.0 - 5.0); // Center at 0.5 with quick transition
	// Map back to the new range
    return newMin + sigmoidValue * (newMax - newMin);
}

// Use sigmoid for creating an ease-in-out effect
inline float easeInOutSigmoid(float t)
{
	// Here we use a scaled sigmoid to make the transition more pronounced
    return sigmoid((t * 2.0 - 1.0) * 5.0); // Scale to double the range and center, then apply sigmoid
}

// Constrains a value within a range with soft boundaries using sigmoid
inline float softClamp(float x, float min, float max)
{
    float mid = (min + max) * 0.5;
    float range = max - min;
	// Use sigmoid to create soft edges
    float s = sigmoid((x - mid) * 10.0 / range); // 10/range adjusts how "soft" the clamp is
    return min + s * range;
}
// Fade from one color to another using sigmoid for smooth transition
inline float3 sigmoidColorFade(float t, float3 colorStart, float3 colorEnd)
{
    float fadeFactor = smootherstep(0.0, 1.0, t);
    return lerp(colorStart, colorEnd, fadeFactor);
}

// Creates a pulsating effect for light or texture intensity
inline float pulsatingIntensity(float time, float minIntensity, float maxIntensity, float frequency)
{
    float cycle = sin(time * frequency * PI * 2.0) * 0.5 + 0.5; // Cycle from 0 to 1
    return remapSigmoid(cycle, 0.0, 1.0, minIntensity, maxIntensity);
}

// Parametric curve for 2D or 3D points with smooth interpolation, useful for path animations
inline float3 parametricSigmoidCurve(float t, float3 p0, float3 p1, float3 p2, float3 p3)
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

    float x1 = lerp(a, b, u.x);
    float x2 = lerp(c, d, u.x);
    return lerp(x1, x2, u.y) * softness + (1.0 - softness) * 0.5; // Adjust softness
}



float3x3 CalcTBN(float3 normal)
{
    normal = safeNormalize(normal);
    float3 tangent = safeNormalize(cross(normal, float3(0, -1, 0)));
    float3 bitangent = safeNormalize(cross(normal, tangent));
    return float3x3(tangent, bitangent, normal);
}

float3x3 CalcTBN(Texture2D<float> depthMap, float2 depthUV, float3 viewPos, bool invertDepth, bool useProjectedDepth, float radius = 1.0)
{
    float2 oosz = GetOosz(depthMap);
    float2 o1 = float2(0.0, -1.0);
    float2 o2 = float2(1.0, 0.0);
	// Compute offsets
    float2 offsetUp = o1 * radius * oosz;
    float2 offsetRight = o2 * radius * oosz;

	// Sample depths around the current pixel
    float centerDepth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);
    float upDepth = depth2D(depthMap, depthUV + offsetUp, invertDepth, useProjectedDepth);
    float rightDepth = depth2D(depthMap, depthUV + offsetRight, invertDepth, useProjectedDepth);

	// Calculate positions directly
    float3 centerPos = float3(depthUV, centerDepth);
    float3 upPos = float3(depthUV + offsetUp, upDepth);
    float3 rightPos = float3(depthUV + offsetRight, rightDepth);

	// Compute vectors
    float3 upDir = upPos - centerPos;
    float3 rightDir = rightPos - centerPos;

	// Compute normal with an epsilon for safety
    float3 normal = safeNormalize(cross(rightDir, upDir) + EPSILON);

    normal = lerp(normal, 1.0 - normal, step(dot(normal, normalize(viewPos - centerPos)), 0));
    
	// Compute tangent and bitangent
	// Note: The order in cross product for tangent might need adjustment based on handedness of your coordinate system
    float3 tangent = safeNormalize(rightDir); // Assuming Y-up, might need to adjust
    float3 bitangent = safeNormalize(upDir);

	// Construct TBN matrix
    return float3x3(tangent, bitangent, normal);
}


inline void CreateTangentSpace01(float3 N, out float3 tangent, out float3 bitangent)
{
    // Step 1: Normalize the input normal
    float3 normal = normalize(N);
    
    // Step 2: Define the primary up vector
    float3 up = float3(0.0, 1.0, 0.0);
    
    // Step 3: Compute the first tangent candidate
    float3 tangent1 = cross(up, normal);
    
    // Step 4: Compute the length of the first tangent candidate
    float len = length(tangent1);
    
    // Step 5: Create a mask where 1.0 indicates the tangent is invalid (len < EPSILON)
    float mask = 1.0 - step(EPSILON, len);
    
    // Step 6: Define the fallback up vector (since up.x = 0.0, fallback is (1, 0, 0))
    float3 upFallback = float3(1.0, 0.0, 0.0);
    
    // Step 7: Compute the second tangent candidate using the fallback up vector
    float3 tangent2 = cross(upFallback, normal);
    
    // Step 8: Normalize both tangent candidates safely
    float3 tangent1_normalized = safeNormalize(tangent1);
    float3 tangent2_normalized = safeNormalize(tangent2);
    
    // Step 9: Blend between the two tangents based on the mask
    // If mask = 1.0, use tangent2; else, use tangent1
    tangent = lerp(tangent1_normalized, tangent2_normalized, mask);
    
    // Step 10: Compute the bitangent to form a right-handed coordinate system
    bitangent = normalize(cross(normal, tangent));
}



inline void CreateTangentSpace11(float3 N, out float3 tangent, out float3 bitangent)
{
    // Step 1: Normalize the input normal
    float3 normal = normalize(N);
    
    // Step 2: Define the primary up vector
    float3 up = float3(0.0, 1.0, 0.0);
    
    // Step 3: Compute the first tangent candidate
    float3 tangent1 = cross(up, normal);
    
    // Step 4: Compute the length of the first tangent candidate
    float len = length(tangent1);
    
    // Step 5: Create a mask where 1.0 indicates the tangent is invalid (len < EPSILON)
    float mask = 1.0 - step(EPSILON, len);
    
    // Step 6: Define the fallback up vector (since up.x = 0.0, fallback is (1, 0, 0))
    float3 upFallback = float3(1.0, 0.0, 0.0);
    
    // Step 7: Compute the second tangent candidate using the fallback up vector
    float3 tangent2 = cross(upFallback, normal);
    
    // Step 8: Normalize both tangent candidates safely
    float3 tangent1_normalized = safeNormalize(tangent1);
    float3 tangent2_normalized = safeNormalize(tangent2);
    
    // Step 9: Blend between the two tangents based on the mask
    // If mask = 1.0, use tangent2; else, use tangent1
    float3 blendedTangent = lerp(tangent1_normalized, tangent2_normalized, mask);
    
    // Step 10: Apply the additional transformation for CreateTangentSpace11
    // Transform the tangent from [0,1] to [-1,1] range if needed
    tangent = blendedTangent * 2.0 - 1.0;
    
    // Step 11: Compute the bitangent to form a right-handed coordinate system
    bitangent = normalize(cross(normal, tangent));
}

inline float3 ToTangentSpace11(float3 v)
{
    float3 T, B;
    CreateTangentSpace11(v, T, B);
    return normalize(T * T.x + B * T.y + v * T.z);
}
inline float3 ToTangentSpace01(float3 v)
{
    float3 T, B;
    CreateTangentSpace01(v, T, B);
    return normalize(T * T.x + B * T.y + v * T.z);
}
inline float RefractiveIndexFromDispersionCoefficients(
    float wavelengthNM, float3 dispersionCoeffsNm2)
{
    // Convert nm to μm and calculate λ² in μm²
    float um = nmToUm(wavelengthNM); // Convert wavelength from nm to μm
    float lambdaSq = um * um; // Compute λ² in μm²

    // Scale dispersion coefficients from nm² to μm²
    float3 dispersionCoeffsUm2 = dispersionCoeffsNm2 * 1e-6;

    // Calculate n² using a Sellmeier-like dispersion model
    float nSq = 1.0 +
        (dispersionCoeffsUm2[0] * lambdaSq) / max(EPSILON, abs(lambdaSq - dispersionCoeffsUm2[1])) +
        (dispersionCoeffsUm2[2] * lambdaSq) / max(EPSILON, abs(lambdaSq - dispersionCoeffsUm2[2]));

    // Clamp and return refractive index
    return ClampRefractiveIndex(sqrt(nSq));
}

inline float3 RefractiveIndexFromDispersionCoefficients(
    float3 wavelengthsNM,
    float3 dispersionCoeffsNm2)
{
    return float3(
        RefractiveIndexFromDispersionCoefficients(wavelengthsNM.x, dispersionCoeffsNm2),
        RefractiveIndexFromDispersionCoefficients(wavelengthsNM.y, dispersionCoeffsNm2),
        RefractiveIndexFromDispersionCoefficients(wavelengthsNM.z, dispersionCoeffsNm2));
}

inline float PhaseShiftM_Single(float wavelengthM, float distanceM, float refractiveIndex)
{
    float w = max(wavelengthM, EPSILON);
    float phaseShift = fmod((TWOPI * refractiveIndex * distanceM) / w, TWOPI);
    return fmod(phaseShift + TWOPI, TWOPI); // Normalize phase to [0, 2π]
}

inline float3 PhaseShiftM(float3 wavelengthsM, float3 distanceM, float3 refractiveIndex)
{
    float3 w = max(wavelengthsM, EPSILON3); // Avoid division by zero
    float3 phaseShift = fmod((TWOPI3 * refractiveIndex * distanceM) / w, TWOPI3);
    return fmod(phaseShift + TWOPI3, TWOPI3); // Normalize phase to [0, 2π]
}


inline float3 PhaseShiftWithReflection(float3 wavelengthM, float3 distanceM, float3 nSurrounding, float3 nFilm)
{
    // Compute base phase shift
    float3 phaseShift = PhaseShiftM(wavelengthM, distanceM, nFilm);

    // Add π if nFilm > nSurrounding (typical of Fresnel phase shift at boundary)
    // this applies only at normal incidence unless specifically adjusted for angle-dependent Fresnel coefficients.
    float3 additionalPhase = PI3 * step(nSurrounding, nFilm);

    return phaseShift + additionalPhase;
}

inline PhaseInterference OpticalPhaseInterference(float3 wavelengthsM, float3 etaR, float3 nSurrounding, float3 thicknessM, float3 cosThetaT)
{
    float3 w = max(wavelengthsM, EPSILON3);

    float3 OPD = 2.0f * etaR * thicknessM * cosThetaT;
    float3 phaseDifference = (TWOPI3 * OPD) / w;

    float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, etaR);

    float3 totalPhase = phaseDifference + reflectionPhaseShift;

    return CreatePhaseInterference(nmToM(OPD), phaseDifference, reflectionPhaseShift, totalPhase, cosThetaT);
}


inline OpticalPathResult OpticalPathDifference(
    float3 wavelengthsNM,
    float3 nSurrounding,
    PathMeasurement measurement,
    float3 dispersionCoeffs = ZERO3,
    float3 absorptionCoeff = ZERO3,
    float3 cosThetaT = ZERO3)
{
    
    
    float3 refractiveIndex = RefractiveIndexFromDispersionCoefficients(nmToM(wavelengthsNM), (dispersionCoeffs));

    PathMeasurement opticalMeasurement =
        CreatePathMeasurement(
            abs(measurement.PathLengthM) * refractiveIndex,
            abs(measurement.PathTotalLengthM) * refractiveIndex,
            abs(measurement.PathDifferenceM) * refractiveIndex);

    float3 phaseDifferenceM = max(EPSILON3, 2.0 * opticalMeasurement.PathLengthM) / max(nmToM(wavelengthsNM), EPSILON3);
    
    PhaseInterference pi = OpticalPhaseInterference(nmToM(wavelengthsNM), refractiveIndex, nSurrounding, opticalMeasurement.PathDifferenceM, cosThetaT);
    
    OpticalPathResult result = CreateOpticalPathResult(
        wavelengthsNM, refractiveIndex,
        measurement, opticalMeasurement, pi,
        cos(phaseDifferenceM),
        exp(-absorptionCoeff * opticalMeasurement.PathDifferenceM)
    );
    return result;
}

inline float DistanceMFromPointsNM(float3 point1NM, float3 point2NM)
{
    return nmToM(distance(point1NM, point2NM));
}

inline PathMeasurement DistanceMFromViewToAB(float3 viewPointNM, float3 pointA, float3 pointB)
{
    float3 d = float3(
        DistanceMFromPointsNM(viewPointNM, pointA),
        DistanceMFromPointsNM(viewPointNM, pointB),
        DistanceMFromPointsNM(pointA, pointB));
    return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));
}

inline PathMeasurement DifferenceMPathFromPointThicknessM(float3 viewPosNM, float3 pixelPosNM, float thicknessM, float3 pixelNormal = ZERO3)
{
    float3 dir = ToTangentSpace01(normalize(pixelPosNM - viewPosNM));

    float distanceFront = distance(viewPosNM, pixelPosNM);
    float3 pixelBackNM = pixelPosNM + dir * mToNm(thicknessM);
    float distanceBack = distance(viewPosNM, pixelBackNM);

    float3 d = float3(
        DistanceMFromPointsNM(viewPosNM, pixelPosNM),
        DistanceMFromPointsNM(viewPosNM, pixelBackNM),
        DistanceMFromPointsNM(pixelPosNM, pixelBackNM));

    // Corrected: path difference as absolute difference, not distance(distanceBack,distanceFront)
    float pathDifference = nmToM(abs(distanceBack - distanceFront));

    return CreatePathMeasurement(
        ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * pathDifference);
}

inline float FresnelDiffractionM(float distanceM, float wavelengthM)
{
    float fresnelTerm = (1.0 / sqrt(distanceM)) * cos(2.0 * PI * distanceM / wavelengthM);
    return fresnelTerm;
}

inline float3 fresnel_diffraction(float apertureRadius, float3 wavelength, float distance)
{
    float3 fresnelNumber = (apertureRadius * apertureRadius) / max(wavelength * distance, EPSILON3);
    return cos(PI3 * fresnelNumber);
}

//If refractive indices are wavelength-dependent, ensure the refractionIndex parameter corresponds to the same wavelength range used in the broader calculations.
inline float3 FresnelBase(float3 viewDir, float3 normal, float3 refractionIndex)
{
    float cosTheta = clamp(dot(viewDir, normal), -1.0f + EPSILON, 1.0f - EPSILON);
    float3 F0 = pow((ONE3 - refractionIndex) / (ONE3 + refractionIndex), 2.0f);

    float3 fresnelEffect = F0 + (ONE3 - F0) * pow(1.0f - abs(cosTheta), FresnelPower);
    return fresnelEffect;
}

inline half2 FresnelPolarized(half3 viewDir, half3 normal, half3 refractiveIndex)
{
    half3 N = normalize(normal);
    half3 V = normalize(viewDir);

    half cI = saturate(dot(N, V));
    half sI = sqrt(max(1.0h - cI * cI, EPSILONh));
    half3 n = max(refractiveIndex, EPSILON3h);
    half3 sT = sI / n;

    half averageST = dot(sT, half3(1.0h / 3.0h, 1.0h / 3.0h, 1.0h / 3.0h));
    half TIR = step(1.0h, averageST);

    half3 cT = sqrt(max(ONE3h - sT * sT, EPSILON3h));

    half3 numeratorRs = (n * cI - cT);
    half3 denominatorRs = max(n * cI + cT, EPSILON3h);
    half3 Rs = pow(max(numeratorRs / denominatorRs, EPSILON3h), 2.0h);

    half3 numeratorRp = (cI - n * cT);
    half3 denominatorRp = max(cI + n * cT, EPSILON3h);
    half3 Rp = pow(max(numeratorRp / denominatorRp, EPSILON3h), 2.0h);

    Rs = lerp(Rs, ONE3h, TIR);
    Rp = lerp(Rp, ONE3h, TIR);

    return half2(Rs.r, Rp.g);
}

inline float FresnelPhase(float3 sourcePosM, float3 observationPosM, float wavelengthM)
{
    half distanceM = half(length(observationPosM - sourcePosM));
    half phase = (2.0h * PI * distanceM) / max(half(wavelengthM), (half) EPSILON);
    return float(phase);
}

inline float3 PhaseShiftWavefront(float3 wavefront, float3 phaseShiftM)
{
    half3 phi = half3(wavefront + phaseShiftM);
    // sin(x)+cos(x) = sqrt(2)*sin(x+π/4), but we keep as-is for clarity
    half3 shifted;
    shifted.r = sin(phi.r) + cos(phi.r);
    shifted.g = sin(phi.g) + cos(phi.g);
    shifted.b = sin(phi.b) + cos(phi.b);

    return float3(safeNormalize(float3(shifted)));
}

inline float RefractiveIndexFromAB(float wavelengthNM, float A, float B)
{
    half lsq = max(half(wavelengthNM * wavelengthNM), EPSILONh);
    half ret = half(A + B) / lsq;
    return (half) ClampRefractiveIndex((float) ret);
}

inline float3 RefractiveIndexFromAB3(float3 wavelengthNM, float3 A, float3 B)
{
    half3 lsq = max(half3(wavelengthNM * wavelengthNM), EPSILON3h);
    half3 ret = half3(A + B) / lsq;
    return float3(ClampRefractiveIndex(float3(ret)));
}

/*
inline float3 RefractiveIndexFromWavelengths(float3 wavelengthsNM, bool isOrdinary, MaterialSellmeier mat)
{
    float3 wavelengthsUM = nmToUm(max(wavelengthsNM, EPSILON3));
    float3 lambdaSq = wavelengthsNM * wavelengthsNM;

    float3 denom1 = max(lambdaSq - mat.coeff.OE1.O.C, EPSILON3);
    float3 denom2 = max(lambdaSq - mat.coeff.OE2.O.C, EPSILON3);
    float3 denom3 = max(lambdaSq - mat.coeff.OE3.O.C, EPSILON3);

    float3 term1o = (mat.coeff.OE1.O.B * lambdaSq) / denom1;
    float3 term2o = (mat.coeff.OE2.O.B * lambdaSq) / denom2;
    float3 term3o = (mat.coeff.OE3.O.B * lambdaSq) / denom3;

    float3 term1e = (mat.coeff.OE1.E.B * lambdaSq) / max(lambdaSq - mat.coeff.OE1.E.C, EPSILON3);
    float3 term2e = (mat.coeff.OE2.E.B * lambdaSq) / max(lambdaSq - mat.coeff.OE2.E.C, EPSILON3);
    float3 term3e = (mat.coeff.OE3.E.B * lambdaSq) / max(lambdaSq - mat.coeff.OE3.E.C, EPSILON3);

    float sel = (float) (!isOrdinary);
    float3 term1 = lerp(term1o, term1e, sel);
    float3 term2 = lerp(term2o, term2e, sel);
    float3 term3 = lerp(term3o, term3e, sel);

    float3 nSquared = 1.0f + term1 + term2 + term3 + mat.D0 + mat.D1 * wavelengthsUM + mat.D2 * lambdaSq;
    nSquared = max(nSquared, EPSILON3);
    float3 n = sqrt(nSquared);

    // Clamp refractive index to [1,5]
    float3 inRange = step(1.0f, n) * step(n, 5.0f);
    n = lerp(mat.etaR, n, inRange);

    return ClampRefractiveIndex(n);
}
*/
inline float3 RefractiveIndexFromSellmeier(float3 wavelengthsNM, bool isOrdinaryRay, MaterialSellmeier mat)
{
    wavelengthsNM = max(wavelengthsNM, EPSILON3);
    float3 lambdaUM = nmToUm(wavelengthsNM); // nm to µm
    float3 lambdaSq = lambdaUM * lambdaUM;

    float sel = (float) (!isOrdinaryRay);

    float3 B1 = lerp(mat.coeff.OE1.O.B, mat.coeff.OE1.E.B, sel);
    float3 B2 = lerp(mat.coeff.OE2.O.B, mat.coeff.OE2.E.B, sel);
    float3 B3 = lerp(mat.coeff.OE3.O.B, mat.coeff.OE3.E.B, sel);
    float3 C1 = lerp(mat.coeff.OE1.O.C, mat.coeff.OE1.E.C, sel);
    float3 C2 = lerp(mat.coeff.OE2.O.C, mat.coeff.OE2.E.C, sel);
    float3 C3 = lerp(mat.coeff.OE3.O.C, mat.coeff.OE3.E.C, sel);

    float3 denom1 = max(lambdaSq - C1, EPSILON3);
    float3 denom2 = max(lambdaSq - C2, EPSILON3);
    float3 denom3 = max(lambdaSq - C3, EPSILON3);

    float3 term1 = (B1 * lambdaSq) / denom1;
    float3 term2 = (B2 * lambdaSq) / denom2;
    float3 term3 = (B3 * lambdaSq) / denom3;

    float3 nSquared = 1.0f + term1 + term2 + term3;
    nSquared = max(nSquared, EPSILON3);

    float3 n = sqrt(nSquared);
    float3 inRange = step(1.0f, n) * step(n, 5.0f);
    n = lerp(mat.etaR, n, inRange);

    return ClampRefractiveIndex(n);
}

inline float3 RefractiveIndexBirefringementFromView(float3 viewDir, MaterialSellmeier mat)
{
    float3 normalizedViewDir = safeNormalize(viewDir);
    float3 normalizedOpticalAxis = safeNormalize(mat.opticalAxis);

    float d = saturate(dot(normalizedViewDir, normalizedOpticalAxis));
    float angle = acos(d);

    float sa = sin(angle);
    float sa2 = sa * sa;
    float3 sinAngleSq = float3(sa2, sa2, sa2);

    float3 refractiveIndex = mat.etaO + (mat.etaE - mat.etaO) * sinAngleSq;

    // Clamp indices to [1,5] using step and lerp
    float3 inRange = step(1.0f, refractiveIndex) * step(refractiveIndex, 5.0f);
    refractiveIndex = lerp(mat.etaR, refractiveIndex, inRange);

    return ClampRefractiveIndex(refractiveIndex);
}


inline float3 RefractiveIndexBirefringementFromAxis(float3 viewDir, float3 opticalAxis, float3 etaR, float3 etaO, float3 etaE)
{
    float3 normalizedViewDir = safeNormalize(viewDir);
    float3 normalizedOpticalAxis = safeNormalize(opticalAxis);

    float d = saturate(dot(normalizedViewDir, normalizedOpticalAxis));
    float angle = acos(d);

    float sa = sin(angle);
    float sa2 = sa * sa;
    float3 sinAngleSq = float3(sa2, sa2, sa2);

    float3 refractiveIndex = etaO + (etaE - etaO) * sinAngleSq;

    // Clamp indices to [1,5] using step and lerp
    float3 inRange = step(1.0f, refractiveIndex) * step(refractiveIndex, 5.0f);
    refractiveIndex = lerp(etaR, refractiveIndex, inRange);

    return ClampRefractiveIndex(refractiveIndex);
}


inline float3 refract3(float3 i, float3 n, float3 ri)
{
    // Handle each component channel-wise
    float3 I = safeNormalize(i);
    float3 N = safeNormalize(n);

    // For wavelength-dependent refraction, we do it separately
    float3 outDir;
    float3 eta = max(ri, EPSILON3);

    // If you need fully channel-wise refract, 
    // you'd need a custom function. For demonstration:
    outDir.r = refract(I, N, eta.r).x; // using .x just to fetch some component
    outDir.g = refract(I, N, eta.g).y;
    outDir.b = refract(I, N, eta.b).z;

    return safeNormalize(outDir);
}

// Structure for complex numbers with polarization
struct ComplexPolarized
{
    float realHorizontal;
    float imagHorizontal;
    float realVertical;
    float imagVertical;
};

inline half3 Polarizationh(half polarizationAngle, half incidentAngle, half3 nIncident, half3 nFilm)
{
    half cI = cos(incidentAngle);
    half cP = cos(polarizationAngle);

    half3 nI = max(nIncident, EPSILON3h);
    half3 nF = max(nFilm, EPSILON3h);

    half3 denomS = max(nI * cI + nF * cP, EPSILON3h);
    half3 denomP = max(nF * cI + nI * cP, EPSILON3h);

    half3 Rs = (nI * cI - nF * cP) / denomS;
    half3 Rp = (nF * cI - nI * cP) / denomP;

    Rs = Rs * Rs;
    Rp = Rp * Rp;

    half3 result = (Rs + Rp) * 0.5h;
    return 1.0h - clamp(result, EPSILON3h, OneMinusEPSILON3h);
}

inline float3 Polarization(float polarizationAngle, float incidentAngle, float3 nIncident, float3 nFilm)
{
    half pA = half(polarizationAngle);
    half iA = half(incidentAngle);
    return float3(Polarizationh(pA, iA, half3(nIncident), half3(nFilm)));
}


// Function to perform smooth interpolation using smoothstep
inline float3 smoothInterpolate(float3 p0, float3 p1, float t)
{
    // Clamp t to [0, 1]
    t = clamp(t, 0.0, 1.0);
    
    // Apply smoothstep for smooth interpolation
    t = smoothstep(0.0, 1.0, t);
    
    return lerp(p0, p1, t);
}

// Hermite interpolation for higher-order smoothness
inline float hermiteInterpolate(float y0, float y1, float mu)
{
	// Hermite interpolation (cubic)
    float mu2 = mu * mu;
    float a0 = 2.0 * y0 - 2.0 * y1;
    float a1 = -3.0 * y0 + 3.0 * y1;
    float a2 = 0.0;
    float a3 = y0;
    return a0 * mu * mu2 + a1 * mu2 + a3;
}

// Gaussian Beam Function with Hermite Interpolation
inline float gaussianHermite(float x, float mean, float stddev)
{
    stddev = max(stddev, EPSILON);
    float hermite = hermiteInterpolate(exp(-pow(max((x - mean) / stddev, EPSILON), 2.0)), 0.0, clamp((x - mean) / stddev, 0.0, 1.0));
    return hermite * exp(-pow(max((x - mean), EPSILON), 2.0) / (2.0 * stddev * stddev));
}



ComplexPolarized MultiplyComplexPolarized(ComplexPolarized a, ComplexPolarized b)
{
    ComplexPolarized result;
    result.realHorizontal = a.realHorizontal * b.realHorizontal - a.imagHorizontal * b.imagHorizontal;
    result.imagHorizontal = a.realHorizontal * b.imagHorizontal + a.imagHorizontal * b.realHorizontal;
    result.realVertical = a.realVertical * b.realVertical - a.imagVertical * b.imagVertical;
    result.imagVertical = a.realVertical * b.imagVertical + a.imagVertical * b.realVertical;
    return result;
}

ComplexPolarized ApplyRotation(ComplexPolarized input, float angle)
{
    ComplexPolarized rotated;
    float cosA = cos(angle);
    float sinA = sin(angle);

    rotated.realHorizontal = input.realHorizontal * cosA - input.imagHorizontal * sinA;
    rotated.imagHorizontal = input.realHorizontal * sinA + input.imagHorizontal * cosA;

    rotated.realVertical = input.realVertical * cosA - input.imagVertical * sinA;
    rotated.imagVertical = input.realVertical * sinA + input.imagVertical * cosA;

    return rotated;
}

inline ComplexPolarized FresnelDiffractionPolarized(float distance, float wavelength, ComplexPolarized input)
{
    distance = max(distance, EPSILON);
    wavelength = max(wavelength, EPSILON);
    float phase = 2.0 * PI * distance / wavelength;
    float cosPhase = cos(phase);
    float sinPhase = sin(phase);
    float invSqrtDist = 1.0 / sqrt(distance);

    ComplexPolarized output;
    output.realHorizontal = (input.realHorizontal * cosPhase - input.imagHorizontal * sinPhase) * invSqrtDist;
    output.imagHorizontal = (input.realHorizontal * sinPhase + input.imagHorizontal * cosPhase) * invSqrtDist;
    output.realVertical = (input.realVertical * cosPhase - input.imagVertical * sinPhase) * invSqrtDist;
    output.imagVertical = (input.realVertical * sinPhase + input.imagVertical * cosPhase) * invSqrtDist;
    return output;
}


inline float sigmoidFog(float distance, float start, float end, float fogDensity)
{
    distance = max(distance, EPSILON);
    float safeNormalizedDistance = saturate((distance - start) / max(end - start, EPSILON));
    float fogFactor = 1.0 - smootherstep(0.0, 1.0, safeNormalizedDistance);
    return pow(max(EPSILON, fogFactor), fogDensity);
}

// placeholders for easeInOutSigmoid, remapSigmoid
inline float3 easeCameraPosition(float t, float3 start, float3 end, float anticipation, float followThrough)
{
    float ease = easeInOutSigmoid(t * (1.0 + anticipation) - anticipation);
    ease = remapSigmoid(ease, 0.0, 1.0, -followThrough, 1.0 + followThrough);
    return lerp(start, end, saturate(ease));
}

inline float AtmosphericPerspective(float2 uv, float3 viewPos, float depth, float fog)
{
    float distance = length(viewPos - float3(uv, depth));
    float atmosphericPerspective = exp(-distance * fog);
    return atmosphericPerspective;
}

inline float DepthOfField(float2 uv, float depth, float3 cameraPosition, float focalLength, float aperture)
{
    float distance = length(cameraPosition - float3(uv, depth));
    float depthOfField = smoothstep(focalLength - aperture, focalLength + aperture, distance);
    return depthOfField;
}
inline float GaussianWeight(float x, float scale)
{
    return exp(-x * x * scale);
}
// Function to calculate the Gaussian beam profile
inline float gaussianBeam(float distance, float beamWidth)
{
    return exp(1.0 - distance / max(beamWidth, EPSILON));
}
inline float3 gaussianBeam(float3 distance, float beamWidth)
{
    return exp(1.0 - distance / max(beamWidth, EPSILON3));
}
inline float3 gaussianBeam(float3 distance, float2 beamWidth)
{
    return exp(1.0 - distance / length(max(beamWidth, EPSILON2)));
}

// Gaussian function
inline float gaussian(float x, float sigma)
{
    return exp(-(x * x) / max(2.0 * sigma * sigma, EPSILON));
}

inline float gaussian3D(float3 pos, float sigma)
{
    return exp(-(pos.x * pos.x + pos.y * pos.y + pos.z * pos.z) / max(2.0 * sigma * sigma, EPSILON));
}

inline float2 gaussian3D(float2 pos, float2 sigma)
{
    return exp(-(pos.x * pos.x + pos.y * pos.y) / max(EPSILON, 2.0 * (sigma.x * sigma.x + sigma.y * sigma.y)));
}

inline float3 gaussian3D(float3 pos, float3 sigma)
{
    return exp(-(pos.x * pos.x + pos.y * pos.y + pos.z * pos.z) / max(EPSILON, 2.0 * (sigma.x * sigma.x + sigma.y * sigma.y + sigma.z * sigma.z)));
}


inline float3 gaussianBeamBasic(float2 uv, float beamWaist = 0.1, float peakIntensity = 1.0)
{
	// Center the UV coordinates
    float2 centeredUV = uv - float2(0.5, 0.5);

	// Calculate distance from beam center
    float distance = length(centeredUV);

	// Calculate intensity using Gaussian function
    float intensity = peakIntensity * gaussian(distance, beamWaist);

    return float3(intensity, intensity, intensity);
}

inline float3 gaussianBeamMoving(float2 uv, float time, float beamWaist = 0.1, float peakIntensity = 1.0, float speed = 0.2, float angle = PI / 4.0)
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


// Helper to compute the angle of incidence given the surface normal and view direction
inline float IncidenceAngle(float3 normal, float3 viewDir)
{
    viewDir = safeNormalize(viewDir);
    normal = safeNormalize(normal);
    // dot(normal, viewDir) returns cos(theta), ensure value is within [-1, 1] before acos
    float c = clamp(dot(normal, viewDir), -1.0, 1.0);
    return acos(c);
}

// Helper to apply Snell's Law and calculate the transmitted angle (per-channel)
inline float3 TransmittedAngle(float3 normal, float3 viewDir, float3 nIncident, float3 nTransmitted)
{
    float cosThetaI = dot(safeNormalize(normal), safeNormalize(viewDir));
    float sinThetaI = sqrt(saturate(1.0 - (cosThetaI * cosThetaI)));
    // Per-channel transmitted angle
    float3 ratio = nIncident / max(nTransmitted, EPSILON3);
    return asin(ratio * sinThetaI);
}

inline float IsTotalInternalReflectionFactor(float3 nIncident, float3 nTransmitted, float3 cosThetaI)
{
    // cosThetaI is per-channel; ensure computations are per-channel
    // Compute sinThetaT^2 per channel
    float3 sinThetaT2 = (nIncident / max(nTransmitted, EPSILON3)) * sqrt(max(ONE3 - pow(abs(cosThetaI), TWO3), EPSILON3));

    // If any channel's sinThetaT > 1, TIR occurs. Check via dot:
    // If any component > 1, sum of squares > 1. step(0.0, dot(...) - 1.0) detects that condition.
    float condition = dot(sinThetaT2, sinThetaT2) - 1.0;
    return step(0.0, condition);
}

inline float LightIntensity(float initialIntensity, float distance)
{
    return initialIntensity / max(distance * distance, EPSILON);
}

inline float3 LightIntensity(float initialIntensity, float3 distance)
{
    return initialIntensity / max(distance * distance, EPSILON3);
}

inline float LightAttenuation(float distance, float attenuationCoefficient)
{
    return exp(-attenuationCoefficient * distance);
}

inline float3 LightAttenuation(float3 distance, float attenuationCoefficient)
{
    return exp(-attenuationCoefficient * distance);
}

inline float3 CoherenceFactor(float3 opticalPathLength, float3 coherenceLength)
{
    return exp(-pow(abs(opticalPathLength), TWO3) / max(pow(abs(coherenceLength), TWO3), EPSILON3));
}

// Doppler shift per channel. Assumes a model where wavelength is a direction-like quantity.
// If this is intentional, we leave as is. Otherwise, consider normalizing relativeVelocity instead.
inline float3 DopplerShift(float3 sourceVelocity, float3 observerVelocity, float3 wavelength)
{
    float3 relativeVelocity = observerVelocity - sourceVelocity;
    // Assuming the user wants a simplistic approach: dot with normalized wavelength direction
    float3 wDir = safeNormalize(wavelength);
    return wavelength * (1.0 + dot(relativeVelocity, wDir));
}

inline float3 PolarizationEffect(float polarizationAngle, float3 R12, float3 R23)
{
    return ONE3 + cos(2.0 * polarizationAngle) * (R12 - R23);
}

inline float3 PolarizationEffect3(float3 polarizationAngle, float3 R12, float3 R23)
{
    return ONE3 + cos(TWO3 * polarizationAngle) * (R12 - R23);
}

float3 FresnelDiffraction(Texture2D<float4> sourceMap, float2 uv, bool invertDepth, bool useProjectedDepth, float3 observationPos, float wavelength, float aperture)
{
    // Assume depth2D, sampleTypeMirror defined elsewhere
    float depth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float4 sourceSample = sourceMap.Sample(sampleTypeMirror, uv);
    float3 sourcePos = float3(uv, depth);

    // Calculate phase difference
    float phase = FresnelPhase(sourcePos, observationPos, wavelength);

    // Aperture function (e.g., circular aperture)
    float2 delta = uv - float2(0.5, 0.5);
    float apertureFunc = step(length(delta), aperture);

    // Complex amplitude
    float amplitude = sourceSample.r * apertureFunc;
    float s, c;
    sincos(phase, s, c);
    float real = amplitude * c;
    float imag = amplitude * s;

    return float3(real, imag, 0.0);
}

// Fresnel equation per-channel (assuming eta per-channel for wavelength-dependent refractive index):
inline float3 fresnelEquation(float3 reflectedNormal, float3 refractedNormal, float3 eta)
{
    float3 N1 = safeNormalize(reflectedNormal);
    float3 N2 = safeNormalize(refractedNormal);

    float cosThetaI = clamp(dot(N1, N2), -1.0, 1.0);
    float sinThetaI = sqrt(saturate(1.0 - cosThetaI * cosThetaI));

    float3 sinThetaT = sinThetaI / max(eta, EPSILON3);
    float3 cosThetaT = sqrt(saturate(ONE3 - sinThetaT * sinThetaT));

    float3 cosThetaI3 = float3(cosThetaI, cosThetaI, cosThetaI);
    float3 numerator = (eta * cosThetaI3 - cosThetaT);
    float3 denominator = max(eta * cosThetaI3 + cosThetaT, EPSILON3);

    float3 r = numerator / denominator;
    return r * r;
}

#define CONVERTUV(UVa,UVb,texA,texB,postA,postB) \
float2 convert##UVa##To##UVb(Texture2D<texA> sourceMap, float2 mapUV, Texture2D<texB> targetMap) \
{ \
    return mapUV * GetSz##postA(sourceMap) / GetSz##postB(targetMap); \
}

CONVERTUV(UV4, UV4, float4, float4, _4, _4);
CONVERTUV(UV4, UV3, float4, float3, _4, _3);
CONVERTUV(UV4, UV2, float4, float2, _4, _2);
CONVERTUV(UV4, UV1, float4, float, _4, _1);

CONVERTUV(UV3, UV4, float3, float4, _3, _4);
CONVERTUV(UV3, UV3, float3, float3, _3, _3);
CONVERTUV(UV3, UV2, float3, float2, _3, _2);
CONVERTUV(UV3, UV1, float3, float, _3, _1);

CONVERTUV(UV2, UV4, float2, float4, _2, _4);
CONVERTUV(UV2, UV3, float2, float3, _2, _3);
CONVERTUV(UV2, UV2, float2, float2, _2, _2);
CONVERTUV(UV2, UV1, float2, float, _2, _1);

CONVERTUV(UV1, UV4, float, float4, _1, _4);
CONVERTUV(UV1, UV3, float, float3, _1, _3);
CONVERTUV(UV1, UV2, float, float2, _1, _2);
CONVERTUV(UV1, UV1, float, float, _1, _1);


// Calculates the gradient of a depth map at a given UV coordinate.
inline float2 GetGradient(Texture2D<float> depthMap, float2 uv, bool invertDepth, bool useProjectedDepth)
{
    float2 oosz = GetOosz(depthMap);

    float grad1 = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    grad1 = lerp(grad1, 1.0 - grad1, invertDepth);
    float2 v1 = float2(ddx_fine(grad1), ddy_fine(grad1));

    float grad2 = depth2D(depthMap, uv + oosz * NormalRadius, invertDepth, useProjectedDepth);
    grad2 = lerp(grad2, 1.0 - grad2, invertDepth);
    float2 v2 = float2(ddx_fine(grad2), ddy_fine(grad2));

    return lerp(float3(v1.xy, grad1), float3(v2.xy, grad2), 0.5).xy;
}



// **Mirror 2D Function**
// =====================
inline float4 diffuse2D(Texture2D<float4> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0);
}
inline float4 diffuse2D(Texture2D<float3> tex, float2 uv)
{
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0).xyz, 1.0);
}

inline void InitPSOut(inout psout ret, float2 uv)
{
    // Create a mask: 1.0 if PassNum > 0.5, else 0.0
    float mask = step(0.5, PassNum);
    
    // Define a zero vector with alpha 1.0
    float4 zeroVec = float4(0.0, 0.0, 0.0, 1.0);
    
    // Assign each render target using lerp based on the mask
    ret.rt1 = lerp(zeroVec, float4(diffuse2D(rtMap1, uv).xyz, 1.0), mask);
    ret.rt2 = lerp(zeroVec, float4(diffuse2D(rtMap2, uv).xyz, 1.0), mask);
    ret.rt3 = lerp(zeroVec, float4(diffuse2D(rtMap3, uv).xyz, 1.0), mask);
    ret.rt4 = lerp(zeroVec, float4(diffuse2D(rtMap4, uv).xyz, 1.0), mask);
    ret.rt5 = lerp(zeroVec, float4(diffuse2D(rtMap5, uv).xyz, 1.0), mask);
    ret.rt6 = lerp(zeroVec, float4(diffuse2D(rtMap6, uv).xyz, 1.0), mask);
    ret.rt7 = lerp(zeroVec, float4(diffuse2D(rtMap7, uv).xyz, 1.0), mask);
    ret.rt8 = lerp(zeroVec, float4(diffuse2D(rtMap8, uv).xyz, 1.0), mask);
}

inline float3 normal2DPoint01(Texture2D<float3> normalMap, float2 uv, bool invertDepth = false)
{
    return safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz));
}
inline float3 normal2DPoint11(Texture2D<float3> normalMap, float2 uv, bool invertDepth = false)
{
    return safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz)) * 2.0 - 1.0;
}

inline float3 normal2DPoint01W(Texture2D<float3> normalMap, float2 uv, bool invertDepth = false)
{
    return ToTangentSpace01(normal2DPoint01(normalMap, uv, invertDepth));
}

inline float3 normal2DPoint11W(Texture2D<float3> normalMap, float2 uv, bool invertDepth = false)
{
    return ToTangentSpace11(normal2DPoint11(normalMap, uv, invertDepth));
}

inline float3 viewDirW(float3 viewPos, float3 lookAtPoint)
{
    float3 viewDir = safeNormalize(viewPos - lookAtPoint);
    return ToTangentSpace11(viewDir);
}

float3 normal2DSobel(Texture2D<float> depthMap, float2 inputUV, float range = 0, bool invertDepth = false)
{
    float2 oosz = GetOosz(depthMap);
    range = lerp(range, NormalRadius, step(range, 0.5));
    // Sample neighboring depths
    // Row 1
    float d1 = depthMap.Sample(sampleTypeMirror, inputUV + float2(-oosz.x, -oosz.y) * range);
    float d2 = depthMap.Sample(sampleTypeMirror, inputUV + float2(0.0, -oosz.y) * range);
    float d3 = depthMap.Sample(sampleTypeMirror, inputUV + float2(oosz.x, -oosz.y) * range);

    // Row 2
    float d4 = depthMap.Sample(sampleTypeMirror, inputUV + float2(-oosz.x, 0.0) * range);
    // d5 is the center pixel (current pixel), which can be skipped for normal calculation
    float d6 = depthMap.Sample(sampleTypeMirror, inputUV + float2(oosz.x, 0.0) * range);

    // Row 3
    float d7 = depthMap.Sample(sampleTypeMirror, inputUV + float2(-oosz.x, oosz.y) * range);
    float d8 = depthMap.Sample(sampleTypeMirror, inputUV + float2(0.0, oosz.y) * range);
    float d9 = depthMap.Sample(sampleTypeMirror, inputUV + float2(oosz.x, oosz.y) * range);

    // Apply Sobel operator weights for X and Y gradients
    // gx = (-1 * d1) + (0 * d2) + (1 * d3)
    //      + (-2 * d4) + (0 * d5) + (2 * d6)
    //      + (-1 * d7) + (0 * d8) + (1 * d9)
    float gx = -d1 - 2.0 * d4 - d7 + d3 + 2.0 * d6 + d9;

    // gy = (-1 * d1) + (-2 * d2) + (-1 * d3)
    //      + (0 * d4) + (0 * d5) + (0 * d6)
    //      + (1 * d7) + (2 * d8) + (1 * d9)
    float gy = -d1 - 2.0 * d2 - d3 + d7 + 2.0 * d8 + d9;

    // Construct the gradient vector
    float3 gradient = float3(gx, gy, 1.0);
    gradient.z = lerp(gradient.z, 1 - gradient.z, invertDepth);
    
    // Fast normalization using rsqrt for inverse square root
    float invLength = rsqrt(dot(gradient, gradient));
    gradient *= invLength;

    return ToTangentSpace11(gradient);
}

inline float3 normal2D11W(Texture2D<float3> normalMap, float2 uv, float radius = 0, bool invertDepth = false)
{
    radius = lerp(NormalRadius, radius, step(radius, 1));
    
    // Sample the normal map at the given UV coordinates
    float2 oosz = GetOosz(normalMap);
    /*float3 sampledNormal1 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz));
    float3 sampledNormal2 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv + oosz * radius, 0).xyz));
    float3 sampledNormal3 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv - oosz * radius, 0).xyz));
    
    // Transform from [0, 1] range to [-1, 1] range
    return ToTangentSpace11(safeNormalize(lerp(safeNormalize((sampledNormal2 + sampledNormal3) * 0.5), sampledNormal1, 0.75)) * 2.0 - 1.0);
    */
    
    return normal2DSobel(depthMap, uv, radius, invertDepth);

}

inline float3 normal2D01W(Texture2D<float3> normalMap, float2 uv, float radius = 0, bool invertDepth = false)
{
    radius = lerp(NormalRadius, radius, step(radius, 1));
    
    // Sample the normal map at the given UV coordinates
    float2 oosz = GetOosz(normalMap);
    float3 sampledNormal1 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz));
    float3 sampledNormal2 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv + oosz * radius, 0).xyz));
    float3 sampledNormal3 = safeNormalize(saturate(normalMap.SampleLevel(sampleTypeMirror, uv - oosz * radius, 0).xyz));
    
    // Transform from [0, 1] range to [-1, 1] range
    return ToTangentSpace01(safeNormalize(lerp(safeNormalize((sampledNormal2 + sampledNormal3) * 0.5), sampledNormal1, 0.75)));
}

inline float3 normal2DFiniteDifferences(Texture2D<float> depthMap, float2 uv, float radius = 0, bool invertDepth = false)
{
    float2 oosz = GetOosz(depthMap);
    radius = lerp(radius, NormalRadius, step(radius, 0.5));
    
    // Sample depth at current pixel and neighboring pixels
    float depthC = depth2D(depthMap, uv);
    float depthR = depth2D(depthMap, uv + float2(oosz.x, 0.0));
    float depthD = depth2D(depthMap, uv + float2(0.0, -oosz.y));

    // Compute gradients
    float2 dxy = (depthR - depthC) / oosz;
    
    // Compute normal vector
    float3 normal = normalize(float3(-dxy.x, -dxy.y, 1.0));

    return normal * 2.0 - 1.0;
}

inline float3 normal2DCalc(Texture2D<float> depthMap, float2 uv, float radius = 0.0, bool invertDepth = false)
{
    radius = lerp(radius, NormalRadius, step(radius, 0.5));

    float2 oosz = GetOosz(depthMap); // UV increments per pixel

    // Sample depth at neighboring pixels
    float depthC = depth2D(depthMap, uv, invertDepth, false);
    float depthR = depth2D(depthMap, uv + float2(oosz.x * radius, 0.0), invertDepth, false);
    float depthU = depth2D(depthMap, uv + float2(0.0, -oosz.y * radius), invertDepth, false);

    // Compute depth differences
    float dx = (depthR - depthC);
    float dy = (depthU - depthC);

    // Compute normal
    float3 normal = normalize(float3(dx, dy, -2.0));

    // Invert normal if required
    normal.z = lerp(normal.z, 1.0 - normal.z, invertDepth);

    return normalize(normal) * 2.0 - 1.0;
}

inline float3 FresnelSchlick(float3 F0, float3 VdotH, float power)
{
    return F0 + (ONE3 - F0) * pow(abs(VdotH), power);
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
    return lerp(range.x, range.y, noiseFast01(v));
}
inline float3 noiseFastRange3(float3 rangeStart, float3 rangeSize, float3 v)
{
	// This ould be replaced with an actual noise function like Simplex or Perlin noise
    return lerp(rangeStart, rangeStart + rangeSize, clamp((v - rangeStart) / max(rangeSize, EPSILON), 0.0, 1.0));

}


// Generates a safeNormalized 3D noise vector based on input coordinates
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
    float3 v = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord1, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v2 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord2, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v3 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord3, 0).xyz, EPSILON3, OneMinusEPSILON3);
    return safeNormalize((v + v2 + v3) / 3.0 * TWO3 - ONE3);
}

float3 noise3(Texture2D<float3> noiseMap, float2 n, float z = 0.0, float scalarUV = 1.0, float scalarZ = 1.0)
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
    int3 sz = int3(GetSz_3i(noiseMap1), 4);

    int x = uv.x;
    int y = uv.y;
    int z = uv.z;

    int shiftCount = 0;
	[unroll(2)]
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
static const uint perm[512] =
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


// Constants for Simplex Noise (if needed)
static const float F3 = 1.0 / 3.0;
static const float G3 = 1.0 / 6.0;

// Fade function using a quintic polynomial for smooth transitions
inline float fade(float t)
{
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

// Fast floor function using bitwise operations for performance
inline int fastfloor(float x)
{
    return lerp(int(x), (int(x) - 1), step(x, -EPSILON));
}
const static float3 gradients[32] =
{
    float3(1.0, 1.0, 0.0), float3(-1.0, 1.0, 0.0), float3(1.0, -1.0, 0.0), float3(-1.0, -1.0, 0.0),
		float3(1.0, 0.0, 1.0), float3(-1.0, 0.0, 1.0), float3(1.0, 0.0, -1.0), float3(-1.0, 0.0, -1.0),
		float3(0.0, 1.0, 1.0), float3(0.0, -1.0, 1.0), float3(0.0, 1.0, -1.0), float3(0.0, -1.0, -1.0),
		float3(1.0, 1.0, 1.0), float3(-1.0, 1.0, 1.0), float3(1.0, -1.0, 1.0), float3(-1.0, -1.0, 1.0),
		float3(1.0, 1.0, -1.0), float3(-1.0, 1.0, -1.0), float3(1.0, -1.0, -1.0), float3(-1.0, -1.0, -1.0),
		float3(2.0, 0.0, 1.0), float3(-2.0, 0.0, 1.0), float3(2.0, 0.0, -1.0), float3(-2.0, 0.0, -1.0),
		float3(0.0, 2.0, 1.0), float3(0.0, -2.0, 1.0), float3(0.0, 2.0, -1.0), float3(0.0, -2.0, -1.0),
		float3(1.0, 2.0, 0.0), float3(-1.0, 2.0, 0.0), float3(1.0, -2.0, 0.0), float3(-1.0, -2.0, 0.0)
};
// Gradient function with improved randomness and isotropy
inline float grad(int hash, float x, float y, float z)
{
    int h = hash & 31; // 32 gradient directions

    return dot(float3(x, y, z), gradients[h]);
}

// Optimized lerp function leveraging HLSL's intrinsic if available
inline float lerpOpt(float a, float b, float t)
{
    return lerp(a, b, t);
}
inline float noisePerlin11(float x, float y, float z)
{
    const float F3 = 1.0 / 3.0;
    const float G3 = 1.0 / 6.0;
    float s = (x + y + z) * F3;
    int i = fastfloor(x + s);
    int j = fastfloor(y + s);
    int k = fastfloor(z + s);

    float t = (i + j + k) * G3;
    float X0 = i - t;
    float Y0 = j - t;
    float Z0 = k - t;

    float x0 = x - X0;
    float y0 = y - Y0;
    float z0 = z - Z0;

    // Rank each coordinate: how many are greater or equal to the others
    float ix = float(step(y0, x0) + step(z0, x0));
    float iy = float(step(x0, y0) + step(z0, y0));
    float iz = float(step(x0, z0) + step(y0, z0));

    // Assign simplex offsets based on ranks
    int i1 = int(step(1.0, ix));
    int i2 = int(step(2.0, ix));
    int j1 = int(step(1.0, iy));
    int j2 = int(step(2.0, iy));
    int k1 = int(step(1.0, iz));
    int k2 = int(step(2.0, iz));

    float x1 = x0 - i1 + G3;
    float y1 = y0 - j1 + G3;
    float z1 = z0 - k1 + G3;

    float x2 = x0 - i2 + 2.0 * G3;
    float y2 = y0 - j2 + 2.0 * G3;
    float z2 = z0 - k2 + 2.0 * G3;

    float x3 = x0 - 1.0 + 3.0 * G3;
    float y3 = y0 - 1.0 + 3.0 * G3;
    float z3 = z0 - 1.0 + 3.0 * G3;

    int ii = i & 255;
    int jj = j & 255;
    int kk = k & 255;

    int gi0 = perm[ii + perm[jj + perm[kk]]] % 12;
    int gi1 = perm[ii + i1 + perm[jj + j1 + perm[kk + k1]]] % 12;
    int gi2 = perm[ii + i2 + perm[jj + j2 + perm[kk + k2]]] % 12;
    int gi3 = perm[ii + 1 + perm[jj + 1 + perm[kk + 1]]] % 12;

    float t0 = 0.6 - x0 * x0 - y0 * y0 - z0 * z0;
    float m0 = step(0.0, t0);
    t0 *= t0;
    float n0 = m0 * t0 * t0 * grad(gi0, x0, y0, z0);

    float t1 = 0.6 - x1 * x1 - y1 * y1 - z1 * z1;
    float m1 = step(0.0, t1);
    t1 *= t1;
    float n1 = m1 * t1 * t1 * grad(gi1, x1, y1, z1);

    float t2 = 0.6 - x2 * x2 - y2 * y2 - z2 * z2;
    float m2 = step(0.0, t2);
    t2 *= t2;
    float n2 = m2 * t2 * t2 * grad(gi2, x2, y2, z2);

    float t3 = 0.6 - x3 * x3 - y3 * y3 - z3 * z3;
    float m3 = step(0.0, t3);
    t3 *= t3;
    float n3 = m3 * t3 * t3 * grad(gi3, x3, y3, z3);

    float noise = 32.0 * (n0 + n1 + n2 + n3);
    return clamp(noise, -1.0, 1.0);
}


// 3D Noise function returning a float3 with fractal Brownian motion (fBm)
inline float3 noisePerlin113(
	float2 xy, float z = 0.0, float time = 1.0,
	float lacunarity = 2.0, float gain = 0.5,
	float amplitude = 1.0, float frequency = 1.0, uint octaves = 2)
{
    float3 sum = float3(0.0, 0.0, 0.0);
    float totalAmplitude = 0.0;

	// Predefined offsets for each component to generate different noise patterns
    float3 offsetsX = float3(0.0, 31.34, 63.68);
    float3 offsetsY = float3(0.0, 47.76, 95.52);
    float3 offsetsZ = float3(0.0, 72.54, 125.08);
    float zTime = z + time;

    // Loop through octaves to create fractal noise
 
    for (uint i = 0; i < octaves; i++)
    {
			// Compute noise for each component with offsets
        float3 noiseValue;

        noiseValue[0] = noisePerlin11(
				xy.x * frequency + offsetsX[0],
				xy.y * frequency + offsetsY[0],
				zTime * frequency + offsetsZ[0]
			);

        noiseValue[1] = noisePerlin11(
				xy.x * frequency + offsetsX[1],
				xy.y * frequency + offsetsY[1],
				zTime * frequency + offsetsZ[1]
			);

        noiseValue[2] = noisePerlin11(
				xy.x * frequency + offsetsX[2],
				xy.y * frequency + offsetsY[2],
				zTime * frequency + offsetsZ[2]
			);


        sum += noiseValue * amplitude;
        totalAmplitude += amplitude;
        amplitude *= gain;
        frequency *= lacunarity;
    }

	// Normalize the result
    return sum / totalAmplitude;
}



inline float3 noisePerlin113(float3 xyz, float time = 0.0)
{
    return noisePerlin113(xyz.xy, xyz.z, time);
}

inline float noisePerlin11(float2 xy)
{
    return noisePerlin11(xy.x, xy.y, 0.0);
}
inline float noisePerlin01(float x, float y, float z)
{
    return noisePerlin11(x, y, z) * 0.5 + 0.5;
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
inline float3 noisePerlin013(float3 xyz, float time = 0.0, float lacunarity = 2.0, float gain = 0.5, float amplitude = 1.0, float frequency = 1.0, uint octaves = 2)
{
    return noisePerlin113(xyz.xy, xyz.z, time, lacunarity, gain, amplitude, frequency, octaves) * 0.5 + 0.5;
}
inline float2 noisePerlin012(float2 xy, float time = 0.0)
{
    return noisePerlin113(xy, time).xy * 0.5 + 0.5;
}


// ---------------------- fBm Implementations ----------------------

// 1. noiseFbm11: Returns a float in the range [-1, 1]
inline float noiseFbm11(float x, float y, float z, int octaves = 5, float lacunarity = 2.0, float gain = 0.5)
{
    float sum = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;
    float maxAmplitude = 0.0;

    [loop]
    for (int i = 0; i < octaves; i++)
    {
        sum += noisePerlin11(x * frequency, y * frequency, z * frequency) * amplitude;
        maxAmplitude += amplitude;
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return sum / maxAmplitude; // Normalized to [-1, 1]
}

// 2. noiseFbm01: Returns a float in the range [0, 1]
inline float noiseFbm01(float x, float y, float z, int octaves = 5, float lacunarity = 2.0, float gain = 0.5)
{
	// Utilize noiseFbm11 and map the result to [0, 1]
    float fbm = noiseFbm11(x, y, z, octaves, lacunarity, gain);
    return (fbm * 0.5) + 0.5;
}

// 3. noiseFbm113: Returns a float3 in the range [-1, 1] for each component
inline float3 noiseFbm113(float3 position, int octaves = 5, float lacunarity = 2.0, float gain = 0.5)
{
    float3 sum = float3(0.0, 0.0, 0.0);
    float amplitude = 1.0;
    float frequency = 1.0;
    float maxAmplitude = 0.0;

    // Unrolled loop for fixed octaves
    [loop]
    for (int i = 0; i < octaves; i++)
    {
        sum += float3(
				noisePerlin11(position.x * frequency, position.y * frequency, position.z * frequency),
				noisePerlin11(position.y * frequency, position.z * frequency, position.x * frequency),
				noisePerlin11(position.z * frequency, position.x * frequency, position.y * frequency)
			) * amplitude;

        maxAmplitude += amplitude;
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return sum / maxAmplitude; // Normalized to [-1, 1]
}

// 4. noiseFbm012: Returns a float2 in the range [0, 1] for each component
inline float2 noiseFbm012(float2 xy, float z = 0.0, int octaves = 5, float lacunarity = 2.0, float gain = 0.5)
{
    float2 sum = float2(0.0, 0.0);
    float amplitude = 1.0;
    float frequency = 1.0;
    float maxAmplitude = 0.0;

	// Precompute time factor if z is dynamic
	// Assuming 'z' can incorporate time or other dynamics externally

    // Unrolled loop for fixed octaves
    [loop]
    for (int i = 0; i < octaves; i++)
    {
        float noiseX = noisePerlin11(xy.x * frequency, xy.y * frequency, z * frequency);
        float noiseY = noisePerlin11(xy.y * frequency, z * frequency, xy.x * frequency);
        sum += float2(noiseX, noiseY) * amplitude;

        maxAmplitude += amplitude;
        amplitude *= gain;
        frequency *= lacunarity;
    }

	// Map the result from [-1, 1] to [0, 1]
    float2 fbm = (sum / maxAmplitude) * 0.5 + 0.5;
    return fbm;
}


float3 noiseTurbulence(
    float3 position,
    float time = 1.0,
    uint octaves = 4,
    float lacunarity = 2.0,
    float gain = 0.5)
{
    float amplitude = 1.0;
    float frequency = 1.0;
    float3 sum = 0.0;
    octaves = clamp(octaves, 1.0, 100.0);
    for (uint i = 0; i < octaves; ++i)
    {
        float3 noise = noisePerlin113(position * frequency, time);
        sum += abs(noise) * amplitude;
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return clamp(sum / octaves, -1.0, 1.0);
}


float3 noiseRidgedMF11(
    float3 position,
    float time,
    uint octaves = 4,
    float lacunarity = 2.0,
    float gain = 0.5,
    float offset = 1.0)
{
    float amplitude = 1.0;
    float frequency = 1.0;
    float3 sum = ZERO3;
    float3 prev = ONE3;

    [loop]
    for (uint i = 0; i < octaves; ++i)
    {
        float3 noise = noisePerlin113(position * frequency, time);
        noise = offset - abs(noise);
        noise *= noise;
        sum += noise * amplitude * prev;
        prev = noise;
        amplitude *= gain;
        frequency *= lacunarity;
    }

    return clamp(sum / octaves, -1.0, 1.0);
}
float3 noiseRidgedMF01(
    float3 position,
    float time,
    uint octaves = 4,
    float lacunarity = 2.0,
    float gain = 0.5,
    float offset = 1.0)
{
    return noiseRidgedMF11(position, time, octaves, lacunarity, gain, offset) * .5 + .5;

}
// Adjusts the depth value using a sigmoid function.
inline float adjustDepthSigmoid(float depth, float2 nearFar)
{
    nearFar = float2(min(nearFar.x, nearFar.y), max(nearFar.x, nearFar.y));
    float sigmoidValue = sigmoid(safeNormalizeRange(nearFar.x, nearFar.y, depth));
    return lerp(nearFar.x, nearFar.y, sigmoidValue);
}
inline float3 HSVtoRGB(float3 hsv)
{
    float H = hsv.x;
    float S = saturate(hsv.y); // Clamp S between 0 and 1
    float V = saturate(hsv.z); // Clamp V between 0 and 1

    float C = V * S; // Chroma
    float H_prime = fmod(H, 360.0f) / 60.0f; // H' = H / 60
    float X = C * (1.0f - abs(fmod(H_prime, 2.0f) - 1.0f));

    float3 rgb;

    if (0.0f <= H_prime && H_prime < 1.0f)
        rgb = float3(C, X, 0.0f);
    else if (1.0f <= H_prime && H_prime < 2.0f)
        rgb = float3(X, C, 0.0f);
    else if (2.0f <= H_prime && H_prime < 3.0f)
        rgb = float3(0.0f, C, X);
    else if (3.0f <= H_prime && H_prime < 4.0f)
        rgb = float3(0.0f, X, C);
    else if (4.0f <= H_prime && H_prime < 5.0f)
        rgb = float3(X, 0.0f, C);
    else // if (5.0f <= H_prime && H_prime < 6.0f)
        rgb = float3(C, 0.0f, X);

    float m = V - C;
    return rgb + m;
}

inline float4 HSVtoRGB(float4 hsv)
{
    float3 rgb = HSVtoRGB(hsv.rgb);
    return float4(rgb, hsv.a);
}

// ------------------------------
// RGB to HSV Conversion
// ------------------------------

// Further Optimized Branchless RGB to HSV Conversion (Version 3)
inline float3 RGBtoHSV(float3 rgb)
{
    float R = rgb.r;
    float G = rgb.g;
    float B = rgb.b;

    // Calculate max and min
    float maxC = max(R, max(G, B));
    float minC = min(R, min(G, B));
    float delta = maxC - minC;

    // Initialize S and V
    float S = lerp(0, (delta / maxC), step(EPSILON, maxC));
    float V = maxC;

    // Calculate hue
    // Using step() to identify max channel
    float isRMax = step(max(G, B), R);
    float isGMax = step(max(R, B), G);
    float isBMax = 1.0f - isRMax - isGMax;

    // Precompute (G - B), (B - R), (R - G)
    float GB = (G - B) / delta;
    float BR = (B - R) / delta;
    float RG = (R - G) / delta;

    // Compute hue contributions
    float hueR = 60.0f * fmod(GB, 6.0f);
    float hueG = 60.0f * (BR + 2.0f);
    float hueB = 60.0f * (RG + 4.0f);

    // Combine hues without branches
    float H = (isRMax * hueR) + (isGMax * hueG) + (isBMax * hueB);

    // Adjust hue to be positive
    float H_positive = H + step(H, 0.0f) * 360.0f;

    // If delta <= EPSILON, set H to 0
    H_positive = lerp(0.0f, H_positive, step(EPSILON, delta));

    return float3(H_positive, S, V);
}
inline float4 RGBtoHSV(float4 rgb)
{
    float3 hsv = RGBtoHSV(rgb.rgb);
    return float4(hsv, rgb.a);
}

// ------------------------------
// Saturation Adjustment
// ------------------------------

// Adjusts the saturation of an RGB color. 'sat' is the new saturation value (0 to 1).
inline float3 AdjustSaturation(float3 rgb, float sat)
{
    float3 hsv = RGBtoHSV(rgb);
    hsv.y = saturate(sat);
    return HSVtoRGB(hsv);
}

inline float4 AdjustSaturation(float4 rgba, float sat)
{
    float3 rgb = AdjustSaturation(rgba.rgb, sat);
    return float4(rgb, rgba.a);
}

// Function to perform Hermite-like interpolation without tangents
inline float3 hermiteInterpolate(float3 p0, float3 p1, float t)
{
    // Clamp t to [0, 1] to ensure smooth interpolation
    t = clamp(t, 0.0, 1.0);
    
    // Compute Hermite basis functions without tangents
    float t2 = t * t;
    float t3 = t2 * t;
    float h00 = 2.0 * t3 - 3.0 * t2 + 1.0;
    float h01 = -2.0 * t3 + 3.0 * t2;

    // Perform interpolation
    return h00 * p0 + h01 * p1;
}


// Function to perturb the normal based on parallax direction
inline float3 perturbNormalWithParallax(
    float3 normal,
    float2 parallaxDir,
    float2 perturbationStrength)
{
    // Normalize the parallax direction
    parallaxDir = safeNormalize(parallaxDir);
    
    // Apply perturbation by adding a scaled parallax direction
    float3 perturbedNormal = float3(normal.xy + parallaxDir * perturbationStrength, normal.z);
    
    // Normalize the resulting normal vector
    return safeNormalize(perturbedNormal);
}


float3 CalcNormal2(Texture2D<float> depthMap, float2 depthUV, float3 viewPos, bool invertDepth, bool useProjectedDepth, int radius = 1)
{
    return CalcTBN(depthMap, depthUV, viewPos, radius, invertDepth, useProjectedDepth)[2];
}

inline float3 noiseFast3D_01(float3 v, float speed = 0.0001)
{
    // Assumes TotalTime and AnimateSpeed are defined as external or uniform variables
    // Also assumes the existence of the tanh function (common in modern HLSL targets)
    // If tanh is not available, consider implementing your own approximation or using another function.

    float timeFactor = TotalTime * AnimateSpeed * speed;

    float n1 = frac(cos(dot(v.xy, float2(12.9898, 78.233))) * 43758.5453);

    float n2 = frac(sin(dot(float2(v.z, timeFactor), float2(7.3871, 137.197323))) * 73358.5483);

    // Separate the scalar multiplication from the dot operation:
    float val = (timeFactor * dot(v.xy, float2(27.32871, 13437.1973)));
    float n3 = frac(tanh(val) * 3158.542383);

    return float3(n1, n2, n3);
}
inline float3 noiseFast3D_11(float3 v, float speed = 0.0001)
{
    return noiseFast3D_01(v, speed) * 2.0 - 1.0;

}
// These versions assume TotalTime and AnimateSpeed are globally accessible.
// They are simplified examples using cosine-based pseudo-noise. 
// For more complex noise (e.g., Perlin, Simplex), replace the internals accordingly.

// 1D Noise in [0,1)
inline float noiseFast1D_01(float x, float speed = 0.0001)
{
    float timeFactor = TotalTime * AnimateSpeed * speed;
    float n = cos(x * 12.9898 + timeFactor * 78.233) * 43758.5453;
    return frac(n);
}

// 1D Noise in [-1,1]
inline float noiseFast1D_11(float x, float speed = 0.0001)
{
    return noiseFast1D_01(x, speed) * 2.0 - 1.0;
}

// 2D Noise in [0,1)
inline float noiseFast2D_01(float2 v, float speed = 0.0001)
{
    float timeFactor = TotalTime * AnimateSpeed * speed;
    float n = cos(dot(v, float2(12.9898, 78.233)) + timeFactor) * 43758.5453;
    return frac(n);
}

// 2D Noise in [-1,1]
inline float noiseFast2D_11(float2 v, float speed = 0.0001)
{
    return noiseFast2D_01(v, speed) * 2.0 - 1.0;
}


inline float InterferenceWavelengthShift(float baseWavelength, float thickness, float viewAngle)
{
    // Simulate interference by shifting wavelength based on thickness and angle
    float shift = thickness * sin(viewAngle * 10.0 + TotalTime * AnimateSpeed) * 20.0;
    return clamp(baseWavelength + shift, MIN_WAVELENGTH, MAX_WAVELENGTH);
}

// Function to compute dynamic interference patterns
float3 Interference(
    float3 position,
    float3 viewDir,
    float3 lightPos,
    float3 lightDir,
    float3 normal,
    float3 wavelengthsM,
    float thicknessM,
    float time)
{
    // Compute optical path differences
    float3 pathDifference = length(position - lightPos) - length(position - viewDir);

    // Compute phase shifts
    float3 phaseShift = (2.0 * PI * pathDifference) / wavelengthsM;

    // Include time for dynamic effect
    phaseShift += time * 2.0 * PI * 0.1; // Adjust speed as needed

    // Compute interference pattern
    float3 interference = 0.5 + 0.5 * cos(phaseShift);

    // Modulate with normal for surface orientation effect
    interference *= saturate(dot(normal, lightDir));

    return interference;
}


// Calculate time-based oscillations for dynamic holographic effects
float3 InterferenceTimeBased(float time, float frequency, float amplitude)
{
    return amplitude * sin(float3(frequency, frequency * 1.5, frequency * 2.0) * time);
}

float3 InterferenceMultiWave(
    float2 uv,
    float time,
    float3 waveFrequencies,
    float3 waveAmplitudes,
    float3 phaseOffsets
)
{
    // Initialize interference accumulator
    float interference = 0.0;
    
    // Combine multiple sine waves to create interference patterns
    interference += waveAmplitudes.x * sin(waveFrequencies.x * (uv.x + uv.y) + phaseOffsets.x + time);
    interference += waveAmplitudes.y * sin(waveFrequencies.y * (uv.x - uv.y) + phaseOffsets.y + time * 0.5);
    interference += waveAmplitudes.z * sin(waveFrequencies.z * (uv.x * uv.y) + phaseOffsets.z + time * 0.25);
    
    // Normalize interference to [0, 1]
    interference = 0.5 + 0.5 * interference;
    
    // Generate color based on interference pattern
    float3 interferenceColor = lerp(float3(1.0, 0.0, 0.0), float3(0.0, 0.0, 1.0), interference);
    
    // Apply amplitude to control the strength of the effect
    interferenceColor *= 0.3;
    
    return interferenceColor;
}


float InterferencePattern2(float2 uv, float time)
{
    float pattern = sin((uv.x * 500.0 + time * 50.0)) +
                    sin((uv.y * 500.0 + time * 50.0)) +
                    sin(((uv.x + uv.y) * 500.0 + time * 50.0));

    pattern = (pattern + 3.0) / 6.0;
    pattern = smoothstep(0.45, 0.55, pattern);
    return pattern;
}

//The interference result (interference) is applied directly to the diffuseColor.
// Depending on your material model, you might want to combine interference with
// other components like specular reflection or transmission.
inline float3 InterferenceThinFilm(
    float2 uv, float time,
    float3 wavelengthsM,
    float3 filmThicknessM,
    float3 nFilm,
    float3 cosThetaT, // float3(dot(normal, lightDir),dot(normal, lightDir),dot(normal, lightDir))
    float3 nSurrounding)
{
    // Prevent division by zero by ensuring wavelengths are above EPSILON
    float3 w = max(wavelengthsM, EPSILON3);
    
    // Calculate Optical Path Difference (OPD) = 2 * nFilm * d * cos(theta_t)
    float3 OPD = 2.0f * nFilm * filmThicknessM * cosThetaT;
    
    // Ensure OPD > 0 to avoid invalid phase calculations
    OPD = max(OPD, EPSILON3);
    
    // Calculate Phase Difference = 2π * OPD / wavelength
    float3 phaseDifference = (TWOPI3 * OPD) / w;
    
    // Calculate Reflection Phase Shift
    float3 reflectionPhaseShift = PhaseShiftWithReflection(w, OPD, nSurrounding, nFilm);
    
    // Total Phase = Phase Difference + Reflection Phase Shift
    float3 totalPhase = phaseDifference + reflectionPhaseShift;
    
    // Interference Result = cos(Total Phase)
    float3 interferenceResult = cos(totalPhase * InterferencePattern2(uv, time));
    
    return interferenceResult;
}


inline float3 InterferenceThinFilm(
    float2 uv, float time,
    float3 wavelengthsM,
    float3 filmThicknessM,
    SellmeierCoefficientsBC filmEta_coeffs)
{
    // Convert thickness from meters to micrometers for consistency with wavelengths
    float3 thicknessUM = mToUm(filmThicknessM); // 1 meter = 1e6 µm

    float3 wavelengthsUM = mToUm(wavelengthsM);

    // Calculate refractive index for thin film
    float3 eta_film = RefractiveIndexFromCoefficients(mToNm(wavelengthsM), filmEta_coeffs);

    // Calculate phase difference: delta = (4 * PI * thickness * eta_film) / lambda
    float3 delta = (4.0f * PI * thicknessUM * eta_film) / max(EPSILON3, wavelengthsUM);

    // Calculate interference pattern
    float3 interference = 0.5f * (1.0f + cos(InterferencePattern2(uv, time) * delta));

    return interference;
}

inline float3 InterferenceSpiral(
    float3 pixel,
    float time,
    float3 spiralFrequency,
    float3 spiralSpeed,
    float3 spiralAmplitude
)
{
    // Center the UV coordinates
    float2 centeredUV = pixel.xy - float2(0.5, 0.5);
    
    // Calculate polar coordinates
    float radius = length(centeredUV);
    float angle = atan2(centeredUV.y, centeredUV.x);
    
    // Dynamic phase based on time
    float3 dynamicPhase = spiralSpeed * time;
    
    // Create spiral interference pattern
    float3 interference = sin(spiralFrequency * angle + dynamicPhase) * spiralAmplitude;
    
    return saturate(interference);
}


// Gaussian Beam Interference Function
inline float3 InterferenceGaussianBeam(float3 position, float3 wavelength, float3 phase, float3 variance)
{
    float3 interference;
    interference.r = gaussianHermite(position.x, wavelength.r, max(2, variance.r)) * cos(phase.r);
    interference.g = gaussianHermite(position.y, wavelength.g, max(2, variance.g)) * sin(phase.g);
    interference.b = gaussianHermite(position.z, wavelength.b, max(2, variance.b)) * tanh(phase.b);
    return interference;
}


// Compute interference intensity based on phase shifts
float3 InterferenceIntensity(float3 phaseShift1, float3 phaseShift2)
{
    return 0.5 * (1.0 + cos(phaseShift1 - phaseShift2));
}
Complex InterferenceIntensityFromAmplitudeWave(float amplitude1, float phase1, float amplitude2, float phase2)
{
    // Resulting intensity I = |E1 + E2|^2
    // E1 = A1 * exp(i * φ1), E2 = A2 * exp(i * φ2)
    float s1, c1;
    sincos(phase1, s1, c1);
    float s2, c2;
    sincos(phase2, s2, c2);
    float realPart = amplitude1 * c1 + amplitude2 * c2;
    float imagPart = amplitude1 * s1 + amplitude2 * s2;

    return CreateComplex(realPart * realPart, imagPart * imagPart);
}

ComplexPolarized InterferencePolarized(ComplexPolarized a, ComplexPolarized b, float scalar)
{
    ComplexPolarized result;
    // Horizontal
    result.realHorizontal = scalar * (a.realHorizontal * b.realHorizontal - a.imagHorizontal * b.imagHorizontal);
    result.imagHorizontal = scalar * (a.realHorizontal * b.imagHorizontal + a.imagHorizontal * b.realHorizontal);
    // Vertical
    result.realVertical = scalar * (a.realVertical * b.realVertical - a.imagVertical * b.imagVertical);
    result.imagVertical = scalar * (a.realVertical * b.imagVertical + a.imagVertical * b.realVertical);
    return result;
}
inline float InterferenceComplex(float2 uv, float time, float frequency, float speed)
{
    float angle = atan2(uv.y - 0.5, uv.x - 0.5);
    float radius = length(uv - 0.5);
    float interference = sin(radius * frequency - time * speed + angle * frequency);
    return 0.5 + 0.5 * interference;
}


inline float3 InterferencePolarized(float3 phaseShift, float3 polarAngle)
{
    float3 polarizationEffect = sin(phaseShift + polarAngle);
    return (polarizationEffect * 0.5 + 0.5) * 0.8 + 0.2;
}


inline float3 InterferenceColor(
    float3 pixel,
    float thicknessM,
    float3 normal,
    float3 viewPos,
    float3 lightPos,
    float3 viewDir,
    float3 wavelengthsNM,
    float3 nIncident,
    float3 nFilm,
    float initialIntensity,
    float attenuationCoefficient,
    float3 coherenceLength,
    float polarizationAngle,
    float3 dispersionCoefficients,
    float absorptionCoefficient
)
{
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    
    float3 cosThetaI = saturate(dot3(normal, viewDir));
    
    float3 ratio = nIncident / max(nFilm, EPSILON3);
    float3 sinThetaI = sqrt(max(ONE3 - cosThetaI * cosThetaI, EPSILON3));
    float3 sinThetaT = ratio * sinThetaI;
    
    // Clamp sinThetaT to [0,1-EPSILON] if needed
    sinThetaT = min(sinThetaT, OneMinusEPSILON3);

    float3 cosThetaT = sqrt(max(ONE3 - sinThetaT * sinThetaT, EPSILON3));
    
    PathMeasurement measurement = DistanceMFromViewToAB(viewPos, pixel, lightPos);
    OpticalPathResult opd = OpticalPathDifference(wavelengthsNM, nIncident, measurement, dispersionCoefficients, absorptionCoefficient, cosThetaT);
    
    float3 lightDistanceM = opd.opticalMeasurement.PathLengthM;
    float3 lightAttenuation = LightAttenuation(lightDistanceM, attenuationCoefficient);

    // Determine TIR factor (0 or 1)
    float TIRMask = IsTotalInternalReflectionFactor(nIncident, nFilm, cosThetaI);

    
    float3 phase = PhaseShiftWithReflection(nmToM(wavelengthsNM), opd.opticalMeasurement.PathLengthM, nIncident, nFilm);

    float3 frCT12, frCT23;
    float3 R12 = FresnelReflectanceFromFilm2(nIncident, nFilm, cosThetaI, frCT12);
    float3 R23 = FresnelReflectanceFromFilm2(nFilm, nIncident, cosThetaT, frCT23);

    float3 coherenceFactor = CoherenceFactor(opd.opticalMeasurement.PathDifferenceM, coherenceLength);
    float3 polarizationEffect = PolarizationEffect(polarizationAngle, R12, R23);

    // Reflectance with interference
    // reflectance = R12 + R23 + 2 * sqrt(R12 * R23) * cos(phase)
    float3 reflectance = (R12 + R23 + 2.0 * sqrt(max(R12 * R23, EPSILON3)) * cos(phase)) * coherenceFactor * polarizationEffect;

    // Apply intensity and attenuation
    reflectance *= LightIntensity(initialIntensity, opd.opticalMeasurement.PathLengthM) * lightAttenuation;

    // If TIR occurs, we want final color = ZERO3, which implies reflectance=ONE3 so that final=1 - reflectance=0
    // Adjust reflectance based on TIRMask
    reflectance = lerp(reflectance, ONE3, TIRMask);

    float3 finalColor = 1.0 - reflectance;
    return saturate(finalColor);
}
InterferencePattern Interference(HolographicLight light1, HolographicLight light2, float3 pointInSpace)
{
    InterferencePattern pattern;

    float distance1 = length(light1.position - pointInSpace);
    float distance2 = length(light2.position - pointInSpace);
    float pathDifference = abs(distance1 - distance2);

    float3 wavelengthNM = max(light1.wavelengthNM, EPSILON3);
    float3 phaseDiff = (2.0 * PI * pathDifference) / wavelengthNM;

    float combinedPhase = dot(phaseDiff, ONE3) + light1.phaseOffset - light2.phaseOffset;

    // No if: just straightforward computations
    pattern.amplitude = 2.0 * sqrt(light1.intensity * light2.intensity) * cos(combinedPhase * 0.5);
    pattern.frequency = (light1.wavelengthNM + light2.wavelengthNM) * 0.5;
    pattern.phase = combinedPhase;

    return pattern;
}
inline float3 Interference(float2 uv, float2 beamCenter, float beamWaist, float hologramDepth, float hologramScale)
{
    float2 centeredUV = (uv - beamCenter) * hologramScale;
    float r = length(centeredUV);
    float theta = atan2(centeredUV.y, centeredUV.x);

    float interference = sin(2.0 * PI * hologramDepth * r + theta * 5.0);
    float intensity = gaussian(r, beamWaist) * interference;

    return float3(intensity, intensity, intensity);
}

float3 InterferenceGaussian(
    Texture2D<float> depthMap,
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float hologramDepth,
    float hologramScale,
    bool invertDepth, bool useProjectedDepth
)
{
    float depthVal = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float3 interferenceColor = Interference(uv, beamCenter, beamWaist, hologramDepth, hologramScale) * nmToM(depthVal);

    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = nmToM(length(centeredUV));
    float3 intensity = gaussian(r, beamWaist) * interferenceColor;

    float3 color = float3(0.5, 0.0, 0.5) * intensity;

    return saturate(color);
}

float3 InterferenceGaussianBeam(
    float2 uv,
    float time,
    float2 beam1Pos,
    float2 beam2Pos,
    float phaseOffset,
    bool invertDepth, bool useProjectedDepth
)
{
    float2 normUV = (uv - 0.5) * 2.0;
    float beamWaist = 0.2;
    float peakIntensity = 1.0;
    
    float distance1 = length(normUV - beam1Pos);
    // Just a placeholder intensity calculation:
    float intensity1 = peakIntensity * gaussian(distance1, beamWaist);

    // Oscillation: replaced if with arithmetic
    float dVal = depth2D(depthMap, uv, invertDepth, useProjectedDepth) * 0.01; // If depthMap needed
    float2 oscillation = 10.0 * float2(cos(time - dVal), sin(time + dVal));
    float2 beam2DynamicPos = fmod(beam2Pos, oscillation);
    float distance2 = length(normUV - beam2DynamicPos);
    float intensity2 = peakIntensity * gaussian(distance2, beamWaist);

    float phase1 = 0.0;
    float phase2 = phaseOffset;
    float interference = cos(phase1 - phase2);

    float3 color1 = float3(0.0, 0.0, 1.0) * intensity1;
    float3 color2 = float3(0.0, 1.0, 0.0) * intensity2;
    float3 interColor = ONE3 * (2.0 * sqrt(max(intensity1 * intensity2, EPSILON)) * interference);

    float3 finalColor = color1 + color2 + interColor;
    return saturate(finalColor);
}

inline float3 Iridescence(
    float3 viewDir,
    float3 normal,
    float3 baseColor,
    float thicknessM,
    MaterialSellmeier coeffs,
    float3 iorMedium)
{
    float3 V = safeNormalize(viewDir);
    float3 N = safeNormalize(normal);
    float3 baseColorWavelengthsNM = max(RGBToWavelengthsNM(baseColor), EPSILON3);

    float3 iorFilm = ClampRefractiveIndex(RefractiveIndexFromSellmeier(baseColorWavelengthsNM, true, coeffs));
    iorMedium = ClampRefractiveIndex(iorMedium);

    float3 cI = saturate(dot3(N, V));
    float3 sI = sqrt(max(1.0 - cI * cI, EPSILON3));

    float3 ratio = iorMedium / max(iorFilm, EPSILON3);
    float3 sT = ratio * sI;

    // TIR mask
    float3 TIRMask = step(ONE3, sT);
    sT = min(sT, ONE3 - EPSILON3);
    float3 cT = sqrt(ONE3 - sT * sT);

    float3 OPD = 2.0 * iorFilm * float3(thicknessM, thicknessM, thicknessM) * cT;
    float3 delta = (2.0 * PI * OPD) / nmToM(baseColorWavelengthsNM);

    // Phase shifts
    // Using step to determine sign:
    float3 phaseShift0 = PI * step(iorFilm, iorMedium);
    float3 phaseShift1 = PI * step(iorMedium, iorFilm);

    float3 totalPhase = delta + phaseShift0 + phaseShift1;

    float3 cosThetaTR0;
    float3 R0 = FresnelReflectanceFromFilm2(iorMedium, iorFilm, cI, cosThetaTR0);

    float3 cosThetaTR1;
    float3 R1 = FresnelReflectanceFromFilm2(iorFilm, iorMedium, cT, cosThetaTR1);

    float3 interference = 2.0 * sqrt(R0 * R1) * cos(totalPhase);

    float3 reflectance = R0 + R1 + interference;
    reflectance = lerp(reflectance, R0, TIRMask);

    reflectance = saturate(reflectance);

    float3 iridescentColor = baseColor * (1.0 - reflectance);
    return saturate(iridescentColor);
}

// Post-Processing Shader Function for Holographic Interference
float3 InterferenceHolographic(float2 uv, float time, float3 colorA, float3 colorB, float frequency, float amplitude, float phaseOffset)
{
    // Calculate the center of the screen for radial patterns
    float2 centerM = nmToM(float2(0.5, 0.5));
    
    // Compute the distance from the current pixel to the center
    float dist = distance(nmToM(uv), centerM);
    
    // Compute dynamic phase based on time for animation
    float dynamicPhase = phaseOffset + time * 2.0 * PI;
    
    // Calculate interference intensity using an assumed InterferenceFunction
    float interference = sin(dist * frequency * TWOPI + dynamicPhase);
    
    // Blend between two colors based on interference pattern
    float3 interferenceColor = lerp(colorA, colorB, 0.5 + 0.5 * interference);
    
    // Apply amplitude to control the strength of the effect
    interferenceColor *= amplitude;
    
    return interferenceColor;
}


float4 Fresnel4h(float2 uv, float time, float4 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance,
                float3 outsideRefractiveIndices, float3 refractiveIndices, float3 dispersionCoefficient)
{
    // Use half where precision is not critical
    half3 N = half3(safeNormalize(normal));
    half3 V = half3(safeNormalize(viewDir));
    half NdotV = max(dot(N, V), half(EPSILON));
    half3 cI = half3(NdotV, NdotV, NdotV);

    // Compute wavelengths in meters, add a small variation (softNoise), and clamp
    half3 baseRGB = half3(baseColor.rgb);
    half3 wl = half3(RGBToWavelengthsNM(float3(baseRGB))) + half3(0.1h, 0.1h, 0.1h) * RGB_WAVELENGTHS_M * half(softNoise(baseColor.xy, 1.0, 1.0));
    half3 wavelengthsM = half3(nmToM(float3(wl)));
    // Evaluate refractive indices per wavelength
    half3 A = half3(refractiveIndices);
    half3 B = half3(dispersionCoefficient);
    half3 n1 = ClampRefractiveIndex(outsideRefractiveIndices);
    half3 n2 = ClampRefractiveIndex(lerp(refractiveIndices, RefractiveIndexFromAB3(mToNm(float3(wavelengthsM)), A, B), 0.55));

    half3 cT;
    half3 R = FresnelReflectanceFromFilm2(n1, n2, cI, cT);
    half3 cT_clamped = clamp(cT, -OneMinusEPSILON3h, OneMinusEPSILON3h);

    // Thin film interference
    half3 interference = half3(InterferenceThinFilm(uv, time, float3(wavelengthsM), filmThicknessM, float3(n2), float3(cT_clamped), float3(n1)));

    // Combine Fresnel and interference
    half3 tempR = clamp(R, -OneMinusEPSILON3h, OneMinusEPSILON3h);
    half3 reflectance = clamp(OneMinusEPSILON3 - clamp(tempR * interference * fresnelPower, EPSILON3h, OneMinusEPSILON3h), EPSILON3h, OneMinusEPSILON3h);

    half3 fres = half3(fresnelReflectance);
    reflectance = reflectance * fres + reflectance * (1.0h - fres);
    reflectance = clamp(reflectance, EPSILON3h, OneMinusEPSILON3h);

    half3 finalColor = clamp(reflectance * baseRGB, EPSILON3h, OneMinusEPSILON3h);

    return float4(finalColor, baseColor.a);
}

inline float4 Fresnel4(float2 uv, float time, float4 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance, float3 outsideRefractiveIndices = ONE3, float3 refractiveIndices = float3(1.5, 1.5, 1.5), float3 dispersionCoefficient = float3(0.005, 0.006, 0.007))
{
    return Fresnel4h(uv, time, baseColor, viewDir, normal, filmThicknessM, fresnelPower, fresnelReflectance, outsideRefractiveIndices, refractiveIndices, dispersionCoefficient);
}


inline float3 Fresnel3(float2 uv, float time, float3 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance, float3 outsideRefractiveIndices, float3 refractiveIndices, float3 dispersionCoefficient)
{
    return Fresnel4h(uv, time, float4(baseColor, 1.0), viewDir, normal, filmThicknessM, fresnelPower, fresnelReflectance, outsideRefractiveIndices, refractiveIndices, dispersionCoefficient).xyz;
}


inline float3 InterferenceWavefront(float2 uv, float time, float3 viewDir, float3 position, float3 normal, float3 lightDir, float3 wavelengthsNM, MaterialSellmeier material, bool isOrdinary)
{
    float3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, isOrdinary, material);
    float3 rd = refract3(-lightDir, normal, refractiveIndex);

    float3 baseColor = diffuse2D(diffuseMap, position.xy).xyz; // Ensure diffuseMap etc. are defined
    float3 reflectance = Fresnel3(uv, time, baseColor, viewDir, normal, material.thicknessM, FresnelPower, FresnelReflectance, ONE3, refractiveIndex, material.scatteringCoefficient);

    float3 phase = saturate(dot(position, rd) * TWOPI3 / max(wavelengthsNM, EPSILON3));
    float3 interference = sin(phase) * reflectance;

    return interference;
}


inline float3 rotatePolarization(float3 color, float angle)
{
	// Simple polarization rotation (assuming linear polarization)
    float2 rotated = float2(color.r * cos(angle) - color.g * sin(angle),
		color.r * sin(angle) + color.g * cos(angle)
	);
    return float3(rotated, color.b);
}



// Rotates UV coordinates with depth-based influence
float2 RotateUVWithDepth(float2 uv, float depth, float angleRadians, bool invertDepth, bool useProjectedDepth)
{
    float2 sc = sincos2(angleRadians);
	// Translate UV to center (0.5, 0.5) before rotation
    float2 centeredUV = uv - 0.5;

	// Apply the rotation with depth influence
    float depthInfluence = saturate((1.0 - depth / DepthScale)); // Clamp between 0 and 1
    float2 rotatedUV =
        float2(centeredUV.x * sc.y - centeredUV.y * sc.x,
                centeredUV.x * sc.x + centeredUV.y * sc.y);
    
    float cd = depth2D(depthMap, centeredUV, invertDepth, useProjectedDepth);
    return lerp(
        float3(centeredUV, cd),
        float3(rotatedUV, depth), depthInfluence).xy;
}




inline float PhaseModulation(float wavelengthM, float thicknessM, float refractiveIndex)
{
    // Ensure parameters are positive to avoid invalid calculations.
    thicknessM = max(thicknessM, EPSILON);
    wavelengthM = max(EPSILON, wavelengthM);
    refractiveIndex = max(refractiveIndex, 1e-6);

    // Phase modulation φ = (2π * n * t) / λ
    float phaseModulation = (2.0 * PI * refractiveIndex * thicknessM) / wavelengthM;

    // Wrap the phase modulation to the range [0, 2π]
    phaseModulation = fmod(phaseModulation, 2.0 * PI);

    return phaseModulation;
}

inline float3 PhaseModulation(float3 wavelengthNM, float thicknessM, float3 refractiveIndex)
{
    return float3(
        PhaseModulation(nmToM(wavelengthNM.x), thicknessM, refractiveIndex.x),
        PhaseModulation(nmToM(wavelengthNM.y), thicknessM, refractiveIndex.y),
        PhaseModulation(nmToM(wavelengthNM.z), thicknessM, refractiveIndex.z)
    );
}

ComplexPolarized ApplyPhaseModulation(ComplexPolarized input, float phaseShift)
{
    ComplexPolarized output;
    float cosPhase = cos(phaseShift);
    float sinPhase = sin(phaseShift);
	// Phase modulation for horizontal polarization
    output.realHorizontal = input.realHorizontal * cosPhase - input.imagHorizontal * sinPhase;
    output.imagHorizontal = input.realHorizontal * sinPhase + input.imagHorizontal * cosPhase;
	// Phase modulation for vertical polarization
    output.realVertical = input.realVertical * cosPhase - input.imagVertical * sinPhase;
    output.imagVertical = input.realVertical * sinPhase + input.imagVertical * cosPhase;
    return output;
}

ComplexPolarized ComplexAdd(ComplexPolarized a, ComplexPolarized b)
{
    ComplexPolarized result;
    result.realHorizontal = a.realHorizontal + b.realHorizontal;
    result.imagHorizontal = a.imagHorizontal + b.imagHorizontal;
    result.realVertical = a.realVertical + b.realVertical;
    result.imagVertical = a.imagVertical + b.imagVertical;
    return result;
}

ComplexPolarized ComplexMultiply(ComplexPolarized a, ComplexPolarized b)
{
    ComplexPolarized result;
    result.realHorizontal = a.realHorizontal * b.realHorizontal;
    result.imagHorizontal = a.imagHorizontal * b.imagHorizontal;
    result.realVertical = a.realVertical * b.realVertical;
    result.imagVertical = a.imagVertical * b.imagVertical;
    return result;
}

ComplexPolarized ComplexMultiplyF(ComplexPolarized a, float b)
{
    ComplexPolarized result;
    result.realHorizontal = a.realHorizontal * b;
    result.imagHorizontal = a.imagHorizontal * b;
    result.realVertical = a.realVertical * b;
    result.imagVertical = a.imagVertical * b;
    return result;
}

inline float3 gaussianBeamComplex(
    float2 uv,
    float time,
    float2 beamCenter,
    float beamWaist,
    float beamDivergence,
    float3 phaseModulationFrequency,
    float polarizationAngle = PI / 2.0
)
{
    float2 normUV = (uv - beamCenter) * 2.0;
    float distance = nmToM(length(normUV));
    float intensity = gaussian(distance, beamWaist);

    float3 phase = beamDivergence * distance + sin(phaseModulationFrequency) * 0.1;
    
    float2 phaseVectorR = sincos2(phase.x);
    float2 phaseVectorG = sincos2(phase.y);
    float2 phaseVectorB = sincos2(phase.z);

    float3 beamColor = ONE3 * intensity;
    beamColor *= float3(phaseVectorR.x, phaseVectorG.x, phaseVectorB.x);

    beamColor = rotatePolarization(beamColor, polarizationAngle);

    return beamColor;
}
inline float3 GaussianBlurSeparable(Texture2D<float4> tex, float2 uv, float sigma, int radius, float2 oosz)
{
    float3 color = 0.0;
    float totalWeight = EPSILON;

    // Horizontal pass
    [unroll]
    for (int x = -radius; x <= radius; x++)
    {
        float weight = nmToM(gaussian(float(x), sigma));
        float2 sampleUV = uv + float2(x, 0.0) * oosz;
        float3 c = diffuse2D(tex, sampleUV).rgb;
        color += c * weight;
        totalWeight += weight;
    }

    color /= totalWeight;

    // Vertical pass
    float3 finalColor = 0.0;
    totalWeight = EPSILON;
    [unroll]
    for (int y = -radius; y <= radius; y++)
    {
        float weight = nmToM(gaussian(float(y), sigma));
        float2 sampleUV = uv + float2(0.0, y) * oosz;
        float3 c = diffuse2D(tex, sampleUV).rgb;
        finalColor += c * weight;
        totalWeight += weight;
    }

    finalColor /= totalWeight;
    return finalColor;
}
inline float2 GetModulation(float2 depthGradient)
{
    return adjustDepthGradientSigmoid(depthGradient, float2(EPSILON, OneMinusEPSILON));
}

inline float GetModulatedDepth(Texture2D<float> depthMap, float2 uv, bool invertDepth, bool useProjectedDepth, bool gradientUseProjectedDepth, int2 offset = int2(0, 0))
{
    float2 oosz = GetOosz(depthMap);
    float2 gradient = GetGradient(depthMap, uv, invertDepth, gradientUseProjectedDepth);
    float2 modulation = GetModulation(gradient);
    return depth2D(depthMap, uv + float2(offset) * oosz * modulation, invertDepth, useProjectedDepth);
}

// CrossLRUDOffsets - No if statements needed here
inline void CrossLRUDOffsets(float2 oosz, int range, out float2 offsets[4])
{
    float fRange = float(range);
    float2 baseX = float2(fRange, 0.0) * oosz;
    float2 negX = float2(-fRange, 0.0) * oosz;
    float2 baseY = float2(0.0, fRange) * oosz;
    float2 negY = float2(0.0, -fRange) * oosz;

    offsets[0] = baseX;
    offsets[1] = negX;
    offsets[2] = baseY;
    offsets[3] = negY;
}

// CrossLRUDOffsetsMod - No if
inline void CrossLRUDOffsetsMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range, bool invertDepth, bool gradientUseProjectedDepth, out float2 offsets[4])
{
    float2 gradient = GetGradient(depthMap, uv, invertDepth, gradientUseProjectedDepth);
    float2 modulation = GetModulation(gradient);
    float fRange = float(range);

    float2 baseX = float2(fRange, 0.0) * oosz * modulation;
    float2 negX = float2(-fRange, 0.0) * oosz * modulation;
    float2 baseY = float2(0.0, fRange) * oosz * modulation;
    float2 negY = float2(0.0, -fRange) * oosz * modulation;

    offsets[0] = baseX;
    offsets[1] = negX;
    offsets[2] = baseY;
    offsets[3] = negY;
}

// XCrossLRUDOffsets - No if
inline void XCrossLRUDOffsets(float2 oosz, int range, out float2 offsets[4])
{
    float fRange = float(range);
    // no if: just compute directly
    offsets[0] = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    offsets[1] = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    offsets[2] = float2(fRange - 0.5, fRange - 0.5) * oosz;
    offsets[3] = float2(-fRange + 0.5, fRange - 0.5) * oosz;
}

// XCrossLRUDOffsetsMod - No if
inline void XCrossLRUDOffsetsMod(float2 oosz, Texture2D<float> depthMap, float2 uv, int range, bool invertDepth, bool gradientUseProjectedDepth, out float2 offsets[4])
{
    float2 gradient = GetGradient(depthMap, uv, invertDepth, gradientUseProjectedDepth);
    float2 modulation = GetModulation(gradient);
    float fRange = float(range);

    offsets[0] = float2(-fRange + 0.5, -fRange + 0.5) * oosz;
    offsets[1] = float2(fRange - 0.5, -fRange + 0.5) * oosz;
    offsets[2] = float2(fRange - 0.5, fRange - 0.5) * oosz;
    offsets[3] = float2(-fRange + 0.5, fRange - 0.5) * oosz;

    // Apply modulation after computing offsets:
    offsets[0] *= modulation;
    offsets[1] *= modulation;
    offsets[2] *= modulation;
    offsets[3] *= modulation;
}

// XCrossLRUDfrawMod - no if
inline float4 XCrossLRUDfrawMod(Texture2D<float> depthMap, float2 uv, float range, bool invertDepth, bool useProjectedDepth, bool gradientUseProjectedDepth)
{
    float2 oosz = GetOosz(depthMap);
    float2 gradient = GetGradient(depthMap, uv, invertDepth, gradientUseProjectedDepth);
    float2 modulation = GetModulation(gradient);

    float2 offset0 = (float2(-range + 0.5, -range + 0.5)) * oosz;
    float2 offset1 = (float2(range - 0.5, -range + 0.5)) * oosz;
    float2 offset2 = (float2(range - 0.5, range - 0.5)) * oosz;
    float2 offset3 = (float2(-range + 0.5, range - 0.5)) * oosz;

    float depth0 = depth2D(depthMap, uv + offset0 * modulation, invertDepth, useProjectedDepth);
    float depth1 = depth2D(depthMap, uv + offset1 * modulation, invertDepth, useProjectedDepth);
    float depth2_ = depth2D(depthMap, uv + offset2 * modulation, invertDepth, useProjectedDepth);
    float depth3 = depth2D(depthMap, uv + offset3 * modulation, invertDepth, useProjectedDepth);

    return clamp(float4(depth0, depth1, depth2_, depth3), EPSILON4, OneMinusEPSILON4);
}
// XCrossLRUDf - Samples depth in an X-shaped pattern around the current location
inline float4 XCrossLRUDf(
    Texture2D<float> depthMap,
    float2 uv,
    float range,
    bool invertDepth,
    bool useProjectedDepth)
{
    // Clamp the range to ensure it's within [1, 10]
    range = clamp(range, 1.0f, 10.0f);
    
    // Obtain the reciprocal of the texture size (assuming GetOosz returns float2)
    float2 oosz = GetOosz(depthMap);
    
    // Initialize the return value to zero
    float4 ret = float4(0.0f, 0.0f, 0.0f, 0.0f);
    
    // Initialize variables for weighted averaging
    float weightSum = 0.0f;
    float sigma = 1.0f;
    
    // Define the convolution kernels for vertical (tensorV) and horizontal (tensorW) directions
    float3 tensorV[3] =
    {
        float3(-2, 0, 2),
        float3(-1, 0, 1),
        float3(-2, 0, 2)
    };

    float3 tensorW[3] =
    {
        float3(-2, -1, -2),
        float3(0, 0, 0),
        float3(2, 1, 2)
    };

    // Define an array to map each sample to a specific component in ret
    // Mapping: (x, y) -> component index
    // (-1, -1) -> ret.x
    // (-1, 1)  -> ret.y
    // (1, -1)  -> ret.z
    // (1, 1)   -> ret.w
    int componentIndex[2][2] = { { 0, 1 }, { 2, 3 } };

    int2 i = int2(0, 0);
    // Calculate the offset using the convolution tensors
    float2 ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    float sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    float weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    i = int2(1, 0);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    
    i = int2(0, 1);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    
    i = int2(2, 0);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    
    i = int2(0, 2);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    i = int2(1, 2);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    i = int2(2, 1);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    
    i = int2(2, 2);
    // Calculate the offset using the convolution tensors
    ofs = float2(tensorW[i.x][i.y] * range, tensorV[i.x][i.y] * range) * oosz;
    // Sample the depth map at the offset position
    sampledDepth = depthMap.SampleLevel(sampleTypeMirror, uv + ofs, 0);
    // Calculate the Gaussian weight based on the distance
    weight = gaussian(length(ofs), sigma);
    // Accumulate the weighted depth into the appropriate component of ret
    ret[componentIndex[i.x][i.y]] += sampledDepth * weight;
    // Accumulate the total weight
    weightSum += weight;
    
    
    // Normalize the accumulated depths by the total weight
    ret /= max(weightSum, EPSILON);

    // Optionally invert the depth
    ret = lerp(ret, 1.0f - ret, invertDepth);

    // Optionally apply projected depth scaling
    ret = lerp(ret, ret * DepthScale, useProjectedDepth);

    return ret;
}


// XCrossLRUD - no if
inline void XCrossLRUD(Texture2D<float4> diffuseMap, float2 uv, float range, inout float4 TL, inout float4 TR, inout float4 BR, inout float4 BL)
{
    float2 oosz = GetOosz(diffuseMap);
    float2 offset0 = float2(-range + 0.5, -range + 0.5) * oosz;
    float2 offset1 = float2(range - 0.5, -range + 0.5) * oosz;
    float2 offset2 = float2(range - 0.5, range - 0.5) * oosz;
    float2 offset3 = float2(-range + 0.5, range - 0.5) * oosz;

    TL = diffuse2D(diffuseMap, uv + offset0);
    TR = diffuse2D(diffuseMap, uv + offset1);
    BR = diffuse2D(diffuseMap, uv + offset2);
    BL = diffuse2D(diffuseMap, uv + offset3);
}
// Horizontal Gaussian blur pass
inline float4 GaussianBlurHorizontal(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range,
    float sigma)
{
    // Calculate one-over-size for proper offset scaling
    float2 oosz = GetOosz(diffuseMap);
    
    // Define horizontal offsets (left and right)
    float2 offsets[4] =
    {
        float2(-range, 0.0f) * oosz, // Left
        float2(-range * 0.5f, 0.0f) * oosz, // Left-Intermediate
        float2(range * 0.5f, 0.0f) * oosz, // Right-Intermediate
        float2(range, 0.0f) * oosz // Right
    };
    
    // Predefined Gaussian weights for a 1D kernel with 4 samples on each side
    float weights[4] =
    {
        GaussianWeight(range, sigma),
        GaussianWeight(range * 0.5f, sigma),
        GaussianWeight(range * 0.5f, sigma),
        GaussianWeight(range, sigma)
    };
    
    // Sample the center color and depth
    float4 centerColor = diffuse2D(diffuseMap, uv);
    float centerDepth = depth2D(depthMap, uv);
    
    // Initialize accumulators for color and total weight
    float4 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each horizontal sample
    for (int i = 0; i < 4; i++)
    {
        // Left sample
        float2 sampleUVLeft = uv + offsets[i];
        float4 sampleColorLeft = diffuse2D(diffuseMap, sampleUVLeft);
        float sampleDepthLeft = depth2D(depthMap, sampleUVLeft);
        
        // Depth-based weight for left sample
        float depthDifferenceLeft = abs(sampleDepthLeft - centerDepth);
        float depthWeightLeft = 1.0 - saturate(depthDifferenceLeft);
        
        // Combined weight for left sample
        float combinedWeightLeft = weights[i] * depthWeightLeft;
        
        accumColor += sampleColorLeft * combinedWeightLeft;
        totalWeight += combinedWeightLeft;
        
        // Right sample
        float2 sampleUVRight = uv - offsets[i];
        float4 sampleColorRight = diffuse2D(diffuseMap, sampleUVRight);
        float sampleDepthRight = depth2D(depthMap, sampleUVRight);
        
        // Depth-based weight for right sample
        float depthDifferenceRight = abs(sampleDepthRight - centerDepth);
        float depthWeightRight = 1.0 - saturate(depthDifferenceRight);
        
        // Combined weight for right sample
        float combinedWeightRight = weights[i] * depthWeightRight;
        
        accumColor += sampleColorRight * combinedWeightRight;
        totalWeight += combinedWeightRight;
    }
    
    // Normalize the accumulated color
    float4 finalColor = accumColor / totalWeight;
    
    // Ensure the color stays within valid range
    return saturate(finalColor);
}

// Vertical Gaussian blur pass
inline float4 GaussianBlurVertical(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range,
    float sigma)
{
    // Calculate one-over-size for proper offset scaling
    float2 oosz = GetOosz(diffuseMap);
    
    // Define vertical offsets (up and down)
    float2 offsets[4] =
    {
        float2(0.0f, -range) * oosz, // Up
        float2(0.0f, -range * 0.5f) * oosz, // Up-Intermediate
        float2(0.0f, range * 0.5f) * oosz, // Down-Intermediate
        float2(0.0f, range) * oosz // Down
    };
    
    // Predefined Gaussian weights for a 1D kernel with 4 samples on each side
    float weights[4] =
    {
        GaussianWeight(range, sigma),
        GaussianWeight(range * 0.5f, sigma),
        GaussianWeight(range * 0.5f, sigma),
        GaussianWeight(range, sigma)
    };
    
    // Sample the center color and depth
    float4 centerColor = diffuse2D(diffuseMap, uv);
    float centerDepth = depth2D(depthMap, uv);
    
    // Initialize accumulators for color and total weight
    float4 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each vertical sample
    for (int i = 0; i < 4; i++)
    {
        // Up sample
        float2 sampleUVUp = uv + offsets[i];
        float4 sampleColorUp = diffuse2D(diffuseMap, sampleUVUp);
        float sampleDepthUp = depth2D(depthMap, sampleUVUp);
        
        // Depth-based weight for up sample
        float depthDifferenceUp = abs(sampleDepthUp - centerDepth);
        float depthWeightUp = 1.0 - saturate(depthDifferenceUp);
        
        // Combined weight for up sample
        float combinedWeightUp = weights[i] * depthWeightUp;
        
        accumColor += sampleColorUp * combinedWeightUp;
        totalWeight += combinedWeightUp;
        
        // Down sample
        float2 sampleUVDown = uv - offsets[i];
        float4 sampleColorDown = diffuse2D(diffuseMap, sampleUVDown);
        float sampleDepthDown = depth2D(depthMap, sampleUVDown);
        
        // Depth-based weight for down sample
        float depthDifferenceDown = abs(sampleDepthDown - centerDepth);
        float depthWeightDown = 1.0 - saturate(depthDifferenceDown);
        
        // Combined weight for down sample
        float combinedWeightDown = weights[i] * depthWeightDown;
        
        accumColor += sampleColorDown * combinedWeightDown;
        totalWeight += combinedWeightDown;
    }
    
    // Normalize the accumulated color
    float4 finalColor = accumColor / totalWeight;
    
    // Ensure the color stays within valid range
    return saturate(finalColor);
}

// Full Gaussian blur using separable passes
inline float4 FullGaussianBlur(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range,
    float sigma)
{
    // First pass: Horizontal blur
    float4 horizontalBlur = GaussianBlurHorizontal(diffuseMap, depthMap, uv, range, sigma);
    
    // Assuming horizontalBlur is written to an intermediate texture,
    // perform the vertical blur by sampling from that intermediate texture.
    // For illustration, we'll reuse the same diffuseMap.
    // In practice, you should use a separate texture for the intermediate result.
    
    float4 finalBlur = GaussianBlurVertical( /* intermediateDiffuseMap */diffuseMap, depthMap, uv, range, sigma);
    
    return finalBlur;
}

// Modified SampleAvg function with Gaussian kernel and depth-based weighting
inline float4 SampleAvg(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range)
{
    return FullGaussianBlur(diffuseMap, depthMap, uv, range, 1.0);;

}


// SampleRateFromRange - no if
// Original logic:
// if (range≥30) sampleRate=3
// else if (range≥10) sampleRate=2
// else sampleRate=1
// Replace with step logic:
inline int SampleRateFromRange(int range)
{
    float fr = float(range);
    float atLeast30 = step(30.0, fr); //1 if fr≥30 else0
    float atLeast10 = step(10.0, fr); //1 if fr≥10 else0

    // If≥30 sampleRate=3
    // else if≥10 sampleRate=2 else1
    // The condition: sampleRate=3 if≥30 else if≥10 =>2 else1
    float sampleRateF = atLeast30 * 3.0 + (1.0 - atLeast30) * atLeast10 * 2.0 + (1.0 - atLeast30) * (1.0 - atLeast10) * 1.0;
    int sampleRate = int(sampleRateF);
    return sampleRate;
}


inline float4 CrossLRUDf(
    Texture2D<float> depthMap, // Changed to float4 for correct sampling
    float2 uv,
    int range,
    bool invertDepth = true,
    bool useProjectedDepth = false)
{
    // Clamp 'range' between 1 and 10 without branching
    range = clamp(range, 1, 10);

    // Get reciprocal texture size
    float2 oosz = GetOosz(depthMap);

    // Initialize return value to zero
    float4 ret = float4(0.0, 0.0, 0.0, 0.0);

    float weightSum = 0.0;
    float sigma = 1.0;

    // Define the Sobel operator tensors as constant arrays
    const float3 tensorV[3] =
    {
        float3(-1.0, 0.0, 1.0),
        float3(-2.0, 0.0, 2.0),
        float3(-1.0, 0.0, 1.0)
    };

    const float3 tensorW[3] =
    {
        float3(-1.0, -2.0, -1.0),
        float3(0.0, 0.0, 0.0),
        float3(1.0, 2.0, 1.0)
    };

    // Manually unrolled 3x3 convolution to eliminate loops
    // Sample offsets and accumulate depth samples and weights

    // Helper lambda to compute offsets, samples, and weights
    // Note: HLSL doesn't support lambdas; this is for illustrative purposes
    // In actual HLSL, you'd manually write out each sample as shown below

    // Sample at (-1, -1)
    float2 ofs_00 = float2(tensorW[0].x * range, tensorV[0].x * range) * oosz;
    float4 sample_00 = depthMap.SampleLevel(samplerState, uv + ofs_00, 0);
    float weight_00 = gaussian(length(ofs_00), sigma);
    ret += sample_00;
    weightSum += weight_00;

    // Sample at (-1, 0)
    float2 ofs_01 = float2(tensorW[0].y * range, tensorV[0].y * range) * oosz;
    float4 sample_01 = depthMap.SampleLevel(samplerState, uv + ofs_01, 0);
    float weight_01 = gaussian(length(ofs_01), sigma);
    ret += sample_01;
    weightSum += weight_01;

    // Sample at (-1, 1)
    float2 ofs_02 = float2(tensorW[0].z * range, tensorV[0].z * range) * oosz;
    float4 sample_02 = depthMap.SampleLevel(samplerState, uv + ofs_02, 0);
    float weight_02 = gaussian(length(ofs_02), sigma);
    ret += sample_02;
    weightSum += weight_02;

    // Sample at (0, -1)
    float2 ofs_10 = float2(tensorW[1].x * range, tensorV[1].x * range) * oosz;
    float4 sample_10 = depthMap.SampleLevel(samplerState, uv + ofs_10, 0);
    float weight_10 = gaussian(length(ofs_10), sigma);
    ret += sample_10;
    weightSum += weight_10;

    // Sample at (0, 0)
    float2 ofs_11 = float2(tensorW[1].y * range, tensorV[1].y * range) * oosz;
    float4 sample_11 = depthMap.SampleLevel(samplerState, uv + ofs_11, 0);
    float weight_11 = gaussian(length(ofs_11), sigma);
    ret += sample_11;
    weightSum += weight_11;

    // Sample at (0, 1)
    float2 ofs_12 = float2(tensorW[1].z * range, tensorV[1].z * range) * oosz;
    float4 sample_12 = depthMap.SampleLevel(samplerState, uv + ofs_12, 0);
    float weight_12 = gaussian(length(ofs_12), sigma);
    ret += sample_12;
    weightSum += weight_12;

    // Sample at (1, -1)
    float2 ofs_20 = float2(tensorW[2].x * range, tensorV[2].x * range) * oosz;
    float4 sample_20 = depthMap.SampleLevel(samplerState, uv + ofs_20, 0);
    float weight_20 = gaussian(length(ofs_20), sigma);
    ret += sample_20;
    weightSum += weight_20;

    // Sample at (1, 0)
    float2 ofs_21 = float2(tensorW[2].y * range, tensorV[2].y * range) * oosz;
    float4 sample_21 = depthMap.SampleLevel(samplerState, uv + ofs_21, 0);
    float weight_21 = gaussian(length(ofs_21), sigma);
    ret += sample_21;
    weightSum += weight_21;

    // Sample at (1, 1)
    float2 ofs_22 = float2(tensorW[2].z * range, tensorV[2].z * range) * oosz;
    float4 sample_22 = depthMap.SampleLevel(samplerState, uv + ofs_22, 0);
    float weight_22 = gaussian(length(ofs_22), sigma);
    ret += sample_22;
    weightSum += weight_22;

    // Normalize the accumulated depth samples
    ret /= max(weightSum, EPSILON);

    // Convert boolean flags to float masks (1.0 for true, 0.0 for false)
    float invertMask = invertDepth ? 1.0 : 0.0;
    float useProjectedMask = useProjectedDepth ? 1.0 : 0.0;

    // Apply inversion without branching
    // ret = lerp(ret, 1 - ret, invertDepth);
    ret = ret * (1.0 - invertMask) + (1.0 - ret) * invertMask;

    // Apply projected depth scaling without branching
    //ret = lerp(ret, ret * DepthScale, useProjectedDepth);
    ret = ret * (1.0 - useProjectedMask) + (ret * DepthScale) * useProjectedMask;

    return ret;
}

// CrossLRUD - no if
// clamp range with step logic:
inline void CrossLRUD(Texture2D<float4> diffuseMap, float2 uv, int range, inout float4 L, inout float4 R, inout float4 U, inout float4 D)
{
    // range = clamp(range,1,30) without if:
    // if≥30 => step(30,range)=1 else0
    // if≥1 => step(1,range)=1 always since range≥1 presumably
    float fr = float(range);
    float over30 = step(30.0, fr);
    float atLeast1 = step(1.0, fr); // range≥1 always presumably
    // clamp to [1,30]
    float top = lerp(fr, 30.0, over30); // if≥30 top=30 else fr
    float over1 = step(1.0, top);
    float finalRange = top * (over1) + (1.0 - over1) * 1.0; // ensure≥1 anyway
    int clampedRange = int(finalRange);

    float2 oosz = GetOosz(diffuseMap);
    float2 offsetL = float2(-float(clampedRange) + 0.5, -float(clampedRange) + 0.5) * oosz;
    float2 offsetR = float2(float(clampedRange) - 0.5, -float(clampedRange) + 0.5) * oosz;
    float2 offsetU = float2(0.0, -float(clampedRange)) * oosz + float2(0.0, 0.5) * oosz;
    float2 offsetD = float2(0.0, float(clampedRange)) * oosz + float2(0.0, -0.5) * oosz;

    // We must ensure no if for final adjustments:
    // The code depends on no if. Just trust these offsets.

    L = diffuse2D(diffuseMap, uv + (float2(-float(clampedRange), 0.0) * oosz));
    R = diffuse2D(diffuseMap, uv + (float2(float(clampedRange), 0.0) * oosz));
    U = diffuse2D(diffuseMap, uv + (float2(0.0, -float(clampedRange)) * oosz));
    D = diffuse2D(diffuseMap, uv + (float2(0.0, float(clampedRange)) * oosz));
}



inline float variation(float3 dc2)
{
    return max(max(dc2.x, dc2.y), dc2.z) - min(min(dc2.x, dc2.y), dc2.z);
}
inline float variation(float4 dc2)
{
    return max(max(max(dc2.x, dc2.y), dc2.z), dc2.w) - min(min(min(dc2.x, dc2.y), dc2.z), dc2.w);
}

float3 WavelengthsToRGB(float3 wavelengthsNM)
{
    return saturate(AdjustGamma(max(EPSILON3, clamp(wavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS) - MIN_WAVELENGTHS) / WAVELENGTH_RANGES, Gamma));
}

// Rotates the hue of an RGB color by a given angle.
inline float3 rotateHue(float3 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB), 1.0); // Convert to HSV.
    hsv.x = fmod(hsv.x + angle, 360.0f); // Wrap the hue if it goes out of bounds.
    return saturate(HSVtoRGB(hsv).rgb); // Convert back to RGB and clamp.
}
inline float3 rotateHue(float3 colorRGB, float3 angle)
{
    float4 hsv0 = float4(RGBtoHSV(colorRGB), 1.0); // Convert to HSV.
    float4 hsvR = hsv0;
    hsvR.x = fmod(hsvR.x + angle.x, 360.0f); // Wrap the hue if it goes out of bounds.
    float3 r = saturate(HSVtoRGB(hsvR).rgb); // Convert back to RGB and clamp.
    float4 hsvG = hsv0;
    hsvG.x = fmod(hsvG.x + angle.y, 360.0f); // Wrap the hue if it goes out of bounds.
    float3 g = saturate(HSVtoRGB(hsvG).rgb); // Convert back to RGB and clamp.
    float4 hsvB = hsv0;
    hsvB.x = fmod(hsvB.x + angle.z, 360.0f); // Wrap the hue if it goes out of bounds.
    float3 b = saturate(HSVtoRGB(hsvB).rgb); // Convert back to RGB and clamp.
    return float3(r.r, g.g, b.b);
}

// Rotates the hue of an RGB color by a given angle.
inline float4 rotateHue(float4 colorRGB, float angle)
{
    float4 hsv = float4(RGBtoHSV(colorRGB.xyz), 1.0); // Convert to HSV.
    hsv.x = fmod(hsv.x + angle, 360.0f); // Wrap the hue if it goes out of bounds.
    return saturate(float4(HSVtoRGB(hsv).xyz, colorRGB.a)); // Convert back to RGB and clamp.
}


// Compute diffraction pattern based on grating spacing and wavelength
float3 DiffractionPattern(float3 wavelengthNM, float gratingSpacingNM, float3 angle)
{
    float3 k = (TWOPI3 / nmToM(wavelengthNM)) * angle;
    return sin(k * gratingSpacingNM) / (k * gratingSpacingNM);
}


float3 XYZToWavelength(float3 xyz)
{
    float3 rgb = XYZToLinearRGB(xyz);

    HSL hsl = RGBToHSL(rgb);

    hsl = AdjustHSL(hsl, 10.0, 2.0, 1.6);
    rgb = HSLToRGB(hsl);

    xyz = mul(RGBtoXYZ, rgb);

	// Perform the XYZ to Wavelengths (Red, Green, Blue) conversion
    float3 wavelengths = mul(xyz.xyz, transpose(XYZ_PRIMARIES_M_inv));

	// Clamp the wavelength intensities to [0, 1] to ensure valid output
    wavelengths = saturate(wavelengths);
    float3 oo = float3(step(0.0, wavelengths.x), step(0.0, wavelengths.y), step(0.0, wavelengths.z));
    return (wavelengths * WAVELENGTH_RANGES + MIN_WAVELENGTHS) * oo;
}

inline float3 GetChromaticity(int index)
{
    return lerp(MIN_CHROMATICITY, MAX_CHROMATICITY, MIN_CHROMATICITY + CHROMATICITY_RANGE * float(1 + index) / SPECTRAL_LOCUS_COUNT);
	//float2(0.1741, 0.0050)//float2(0.0842, 0.0420), // 830nm
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

float2 ChromaticityCoordinates(float3 XYZ)
{
    float sumXYZ = XYZ.x + XYZ.y + XYZ.z;
    return lerp(0.0, float2(XYZ.x / max(sumXYZ, EPSILON), XYZ.y / max(sumXYZ, EPSILON)), step(0.0, sumXYZ));
}

float3 clampWavelengthsNM(float3 wavelengthsNM)
{
    return float3(
		lerp(0.0, clamp(wavelengthsNM.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x), step(0.0, wavelengthsNM.x)),
        lerp(0.0, clamp(wavelengthsNM.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y), step(0.0, wavelengthsNM.y)),
        lerp(0.0, clamp(wavelengthsNM.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z), step(0.0, wavelengthsNM.z)));
}


inline float3 LinearRGBToSRGB2(float3 linearRGB)
{
    linearRGB = clamp(linearRGB, EPSILON3, OneMinusEPSILON3);
    float3 ret = float3(
        lerp(12.92 * linearRGB.r, 1.055 * pow(max(EPSILON, linearRGB.r), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.r)),
        lerp(12.92 * linearRGB.g, 1.055 * pow(max(EPSILON, linearRGB.g), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.g)),
        lerp(12.92 * linearRGB.b, 1.055 * pow(max(EPSILON, linearRGB.b), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.b)));
    return AdjustGamma(ret);
}

inline float3 WavelengthToXYZ(float wavelength)
{
	// Ensure wavelength is within the visible spectrum
    wavelength = clamp(wavelength, MIN_WAVELENGTH, MAX_WAVELENGTH);

    int t = int((wavelength - MIN_WAVELENGTH) / (MAX_WAVELENGTH - MIN_WAVELENGTH));

    return float3(xBar[t], yBar[t], zBar[t]);
}


inline float3 WavelengthsToXYZ(float3 wavelengthsNM)
{
    // Convert each wavelength to XYZ
    float3 XYZ1 = WavelengthToXYZ(wavelengthsNM.x);
    float3 XYZ2 = WavelengthToXYZ(wavelengthsNM.y);
    float3 XYZ3 = WavelengthToXYZ(wavelengthsNM.z);
    
    // Combine the XYZ values, possibly averaging
    float3 combinedXYZ = (XYZ1 + XYZ2 + XYZ3) / 3.0;
    
    return combinedXYZ;
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

inline float3 LightTravelTimeM(float3 distanceM, float speedOfLight = SPEED_OF_LIGHT)
{
    return distanceM / speedOfLight;
}


inline float3 LightAbsorption(float thicknessM, float3 absorptionCoefficientM)
{
    return exp(-absorptionCoefficientM * thicknessM);
}
inline float3 LightAbsorption(float3 thicknessM, float3 absorptionCoefficientM)
{
    return exp(-absorptionCoefficientM * thicknessM);
}

inline float3 AdjustIntensity(float3 intensity, float3 factor, float3 absorptionCoeffM, float speedOfLight = SPEED_OF_LIGHT)
{
    // Compute attenuation based on absorption and travel time
    float3 attenuation = LightAbsorption(speedOfLight * factor, absorptionCoeffM);
    
    // Adjust intensity by attenuation
    return intensity * attenuation;
}


inline float3 PropogateLight(float3 sourceColor, float3 distanceM, float3 thicknessM, float3 intensity = ONE3, float3 absorptionCoeffM = ZERO3, float speedOfLight = SPEED_OF_LIGHT)
{
    // Compute light travel time
    float3 travelTimeS = LightTravelTimeM(distanceM, speedOfLight);
    
    // Adjust intensity based on travel time and absorption
    float3 adjustedIntensity = AdjustIntensity(intensity, travelTimeS, absorptionCoeffM, speedOfLight);
    
    // Adjust the source color by the attenuated intensity
    float3 adjustedColor = sourceColor * adjustedIntensity;
    
    return adjustedColor;
}



inline float3 HenyeyGreensteinPhaseFunction(float g, float3 cosTheta)
{
    // Calculate the denominator with clamping to prevent division by zero
    float3 denom = 1.0 + g * g - 2.0 * g * cosTheta;
    denom = max(denom, EPSILON3);
    
    // Compute the phase function
    float3 phaseFunction = (1.0 / (4.0 * PI)) * ((1.0 - g * g) / (denom * sqrt(denom)));
    
    return phaseFunction;
}

bool RayIntersectPlane(float3 rayOrigin, float3 rayDir, float3 planeNormal, float planeDistance, out float t)
{
    float d = dot(rayDir, planeNormal);

    if (abs(d) < EPSILON)
        return false;

    t = (planeDistance - dot(rayOrigin, planeNormal)) / d;
    return true;
}


// 1. Lens Distortion
inline float2 ppLensDistort(float2 uv, float strength, float radius, bool invertDepth, bool useProjectedDepth)
{
    float2 offset = (0.25 + uv - 0.5);
    float r = length(offset);
    float pd = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float n1 = noise3(noiseMap1, float3(convertUV1ToUV3(depthMap, uv, noiseMap1), pd)).x;
    float distortion = 1.0 + (strength * r * r) / max((1.0 + radius * r * r), EPSILON) * pd * n1;
    return 0.5 + offset * distortion - 0.25;
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
    return 0.5 + radius * sincos2(theta);
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
    return (uv - 0.5) * zoom + 0.5;
}
inline float2 ppZoomUV(float2 uv, float2 scale, bool invertDepth, bool useProjectedDepth)
{
    float a = cosTime01(AnimateSpeed);
    float depth = (1.0 - depth2D(depthMap, uv, invertDepth, useProjectedDepth) / DepthScale);
    return ppZoom2D(uv,
		float2(1.0 - scale.x * depth * a,
			1.0 - scale.y * depth * a));
}
// Post-Processing Effect Helpers (with time-varying animation)

// 1. Lens Distortion Helper
inline float2 ppLensDistortUV(float2 uv, float strength, float radius, bool invertDepth, bool useProjectedDepth, float speed = 1.0)
{
    float time = TotalTime * AnimateSpeed * speed; // Time-based animation (adjust speed)
    float animatedStrength = strength * (1.0 + sin(time) * 0.2); // Oscillating strength
    return ppLensDistort(uv, animatedStrength, radius, invertDepth, useProjectedDepth);
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



inline float3 GaussianBloom(Texture2D<float4> diffuseMap, float2 diffuseUV, float dist, float threshold, float3 minColor, float3 power, float sigma)
{
    float2 ooszDiffuse = GetOosz(diffuseMap);
    float3 color = diffuse2D(diffuseMap, diffuseUV).xyz; // Use a sampler for better quality
    float3 luminance = RGBToLuminance(color);

    if (CountV3AboveV1(luminance, threshold, EPSILON) > 0)
    {
        float3 blurColor = 0.0;
        float totalWeight = 0.0;

		// Dynamic radius based on sigma
        int radius = int(ceil(3.0 * sigma));

		// Precalculate some values to avoid redundant calculations in the loop
        float sigmaSq2 = 2.0 * sigma * sigma;
        float2 ooszDist = ooszDiffuse * dist;
	    [loop]
        for (int y = -radius; y <= radius; y++)
        {
			[loop]
            for (int x = -radius; x <= radius; x++)
            {
                float2 offset = float2(x, y) * ooszDist; // Use precalculated value
                float weight = gaussian(length(offset), sigma);
                blurColor += diffuse2D(diffuseMap, diffuseUV + offset).xyz * weight;
                totalWeight += weight;
            }
        }

        blurColor /= totalWeight;
        color = lerp(color, max(minColor, blurColor), luminance * power);
    }

    return color;
}



inline float3 WavelengthDependentBlurRadius(
    float3 wavelengthsNM,
    float3 baseRadius,
    float3 minBlurRadius = float3(0.0015, 0.0015, 0.0015),
    float3 maxBlurRadius = float3(0.025, 0.025, 0.025),
    float3 scalingFactors = float3(0.170, 0.140, 0.120)
)
{
    // Calculate scaling factors based on wavelength and reference wavelengths
    float3 scaling = scalingFactors * clamp((wavelengthsNM - MIN_WAVELENGTHS) / RGB_WAVELENGTHS_NM, EPSILON, OneMinusEPSILON3);
    
    // Compute preliminary blur radius
    float3 preliminaryBlur = baseRadius * scaling;
    
    // Clamp the blur radius between min and max values
    float3 blurRadius = clamp(preliminaryBlur, minBlurRadius, maxBlurRadius);
    
    return blurRadius;
}

/*
inline float3 ComputePathDifferenceM(
    float3 lightPos,      // Position of the light source (in meters)
    float3 pixelPos,      // Position of the pixel (in meters)
    float3 viewPos,       // Position of the viewer/camera (in meters)
    float3 wavelengthsM
)
{
    // Compute vectors for the paths
    float3 lightToPixel = pixelPos - lightPos;
    float3 pixelToView = viewPos - pixelPos;
    float3 lightToView = viewPos - lightPos;

    // Compute geometric path lengths
    float path1Length = length(lightToPixel) + length(pixelToView); // Light -> Pixel -> Viewer
    float path2Length = length(lightToView);                         // Light -> Viewer (Reference Path)

    // Compute geometric path difference
    float pathDifference = path1Length - path2Length;

    float3 phaseDifference = (2.0 * PI * pathDifference) / max(EPSILON3, wavelengthM);

    return phaseDifference; // Returns geometric phase differences per channel (R, G, B)
}*/

inline float ApplyAngularSpread(float baseIntensity, float angularSpread, float angleToViewer)
{
    // Compute denominator safely
    float denom = max(EPSILON, (2.0 * pow(abs(angularSpread), 2.0)));
    float attenuation = exp(-pow(abs(angleToViewer), 2.0) / denom);
    
    // Clamp attenuation
    attenuation = clamp(attenuation, EPSILON, OneMinusEPSILON);
    
    // Apply attenuation
    return baseIntensity * attenuation;
}

inline float3 GaussianBlurWavelengthDependent(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 blurRadius
)
{
    float3 accumulatedColor = ZERO3;
    float3 totalWeight = ZERO3;
    
    int kernelRadius = 2; // fixed radius
    float2 oosz = GetOosz(diffuseMap);

    // Horizontal blur pass
    [unroll]
    for (int i = -kernelRadius; i <= kernelRadius; i++)
    {
        float fi = float(i);
        // For R
        float denomR = max(blurRadius.r, EPSILON);
        float weightR = exp(-pow(abs(fi / denomR), 2.0));
        float2 offsetR = float2(fi * blurRadius.r * oosz.x, 0.0);
        float sample1R = diffuse2D(diffuseMap, inputUV + offsetR).r;
        float sample2R = diffuse2D(diffuseMap, inputUV - offsetR).r;
        float avgR = (sample1R + sample2R) * 0.5;
        
        // For G
        float denomG = max(blurRadius.g, EPSILON);
        float weightG = exp(-pow(abs(fi / denomG), 2.0));
        float2 offsetG = float2(fi * blurRadius.g * oosz.x, 0.0);
        float sample1G = diffuse2D(diffuseMap, inputUV + offsetG).g;
        float sample2G = diffuse2D(diffuseMap, inputUV - offsetG).g;
        float avgG = (sample1G + sample2G) * 0.5;
        
        // For B
        float denomB = max(blurRadius.b, EPSILON);
        float weightB = exp(-pow(abs(fi / denomB), 2.0));
        float2 offsetB = float2(fi * blurRadius.b * oosz.x, 0.0);
        float sample1B = diffuse2D(diffuseMap, inputUV + offsetB).b;
        float sample2B = diffuse2D(diffuseMap, inputUV - offsetB).b;
        float avgB = (sample1B + sample2B) * 0.5;
        
        float3 sampleColor = float3(avgR, avgG, avgB);
        float3 weight = float3(weightR, weightG, weightB);
        
        accumulatedColor += sampleColor * weight;
        totalWeight += weight;
    }

    // Normalize horizontal pass
    accumulatedColor /= max(totalWeight, EPSILON3);

    // Vertical blur pass
    float3 finalColor = ZERO3;
    totalWeight = ZERO3;

    [unroll]
    for (i = -kernelRadius; i <= kernelRadius; i++)
    {
        float fi = float(i);
        // R channel vertical
        float denomR = max(blurRadius.r, EPSILON);
        float weightR = exp(-pow(abs(fi / denomR), 2.0));
        float2 offsetR = float2(0.0, fi * blurRadius.r * oosz.y);
        float sample1R = diffuse2D(diffuseMap, inputUV + offsetR).r;
        float sample2R = diffuse2D(diffuseMap, inputUV - offsetR).r;
        float avgR = (sample1R + sample2R) * 0.5;
        
        // G channel vertical
        float denomG = max(blurRadius.g, EPSILON);
        float weightG = exp(-pow(abs(fi / denomG), 2.0));
        float2 offsetG = float2(0.0, fi * blurRadius.g * oosz.y);
        float sample1G = diffuse2D(diffuseMap, inputUV + offsetG).g;
        float sample2G = diffuse2D(diffuseMap, inputUV - offsetG).g;
        float avgG = (sample1G + sample2G) * 0.5;
        
        // B channel vertical
        float denomB = max(blurRadius.b, EPSILON);
        float weightB = exp(-pow(abs(fi / denomB), 2.0));
        float2 offsetB = float2(0.0, fi * blurRadius.b * oosz.y);
        float sample1B = diffuse2D(diffuseMap, inputUV + offsetB).b;
        float sample2B = diffuse2D(diffuseMap, inputUV - offsetB).b;
        float avgB = (sample1B + sample2B) * 0.5;
        
        float3 sample = float3(avgR, avgG, avgB);
        float3 weight = float3(weightR, weightG, weightB);

        finalColor += sample * weight;
        totalWeight += weight;
    }

    finalColor /= max(totalWeight, EPSILON3);

    // Combine horizontal and vertical passes
    float3 combinedBlur = lerp(accumulatedColor, finalColor, float3(0.5, 0.5, 0.5));

    return saturate(combinedBlur);
}



inline float3 AngleToViewer(float3 normal, float3 viewDir)
{
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    float cosTheta = abs(dot(normal, viewDir));
    float angle = acos(cosTheta);
    return float3(angle, angle, angle);
}

inline float3 ApplyAngularSpread(
    float3 baseIntensity,
    float3 angularSpread,
    float3 angleToViewer
)
{
    float3 spreadSq = pow(abs(angularSpread), 2.0);
    float3 denom = max(2.0 * spreadSq, EPSILON3);
    float3 attenuation = exp(-pow(abs(angleToViewer), 2.0) / denom);
    float3 adjustedIntensity = saturate(baseIntensity * attenuation);
    return adjustedIntensity;
}

float3 HolographicBloom(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 color,
    float3 phaseDifferenceM,
    float3 refractiveIndex,
    float threshold,
    float3 minColor,
    float3 power,
    float3 wavelengthsNM,
    float sigma,
    float3 dist,
    float3 lightPos,
    float3 viewPos,
    float3 worldPixelPos,
    float3 normal
)
{
    float brightness = dot(color, float3(0.2126, 0.7152, 0.0722));
    float bloomMask = step(threshold, brightness); // 1 if brightness≥threshold else 0

    // If brightness < threshold, bloom effect is zero
    // If brightness ≥ threshold, compute bloom
    float3 bloomColor = color * power * brightness * bloomMask;

    // Simple Gaussian approximation based on dist.x (assuming dist.x)
    // and sigma. If dist is a vector, choose one component or average.
    float g = exp(-(dist.x * dist.x) / max(2.0 * sigma * sigma, EPSILON)) * bloomMask;

    bloomColor *= g;

    // Combine with base color and ensure minColor
    float3 finalColor = lerp(color, max(minColor, bloomColor), saturate(power));
    return saturate(finalColor);
}


inline float3 HueToRGB(float hue)
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

    // If C=0, hue =0
    float Ceq0 = step(C, EPSILON); // 1 if C≤EPSILON (approx C=0), else 0
    float Cneq0 = 1.0 - Ceq0; // 1 if C>EPSILON

    float hueTemp = 0.0;
    // Compute hue if C≠0
    // To avoid if: 
    // If M == rgb.r:
    float Mr = step(M, rgb.r + EPSILON) * step(rgb.r - EPSILON, M); // M=rgb.r?
    // Actually simpler to determine hue for each case and blend:
    float isR = step(M, rgb.r + EPSILON) * step(rgb.r - EPSILON, M);
    float isG = step(M, rgb.g + EPSILON) * step(rgb.g - EPSILON, M);
    float isB = step(M, rgb.b + EPSILON) * step(rgb.b - EPSILON, M);

    // For R max
    float hueR = fmod(((rgb.g - rgb.b) / max(C, EPSILON)), 6.0);
    // For G max
    float hueG = ((rgb.b - rgb.r) / max(C, EPSILON)) + 2.0;
    // For B max
    float hueB = ((rgb.r - rgb.g) / max(C, EPSILON)) + 4.0;

    // Combine based on which channel is M
    float hueRaw = isR * hueR + isG * hueG + isB * hueB;

    // If C=0, hue=0 else use hueRaw
    float hue = (hueRaw * Cneq0) * 60.0;

    // Ensure hue≥0
    hue = fmod(hue + 360.0, 360.0);
    return hue;
}


float3 rainbowColor(float value)
{
    return saturate(float3(
        sin(TWOPI * value + 0.0f) * 0.5f + 0.5f,
        sin(TWOPI * value + 2.0f * PI / 3.0f) * 0.5f + 0.5f,
        sin(TWOPI * value + 4.0f * PI / 3.0f) * 0.5f + 0.5f
    ));
}

float3 rainbowColor(float2 value)
{
    return saturate(float3(
        sin(TWOPI * value.x + 0.0f) * 0.5f + 0.5f,
        sin(TWOPI * value.y + 2.0f * PI / 3.0f) * 0.5f + 0.5f,
        sin(TWOPI * value.x + 4.0f * PI / 3.0f) * 0.5f + 0.5f
    ));
}



inline float3 ApplyChromaticAberration(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap, // Added depthMap to parameters
    float2 inputUV,
    float3 viewDir,
    float3 normal,
    float3 iridescentColor,
    float radius,
    MaterialSellmeier mat,
    bool invertDepth, bool useProjectedDepth,
    int dispersionIndex)
{
    dispersionIndex = clamp(dispersionIndex, 0, 2);
    
    // Ensure radius is within [1,10] range
    float clampedRadius = clamp(radius, 1.0, 10.0);

    // Calculate shift amounts for each channel
    float2 shiftAmount = GetOosz(diffuseMap) * clampedRadius;

    // Shift each color channel differently
    float2 offsetR = inputUV + float2(1.0, 0.0) * shiftAmount;
    float2 offsetG = inputUV;
    float2 offsetB = inputUV - float2(1.0, 0.0) * shiftAmount;

    // Sample each channel separately
    float4 cR = diffuse2D(diffuseMap, offsetR);
    float4 cG = diffuse2D(diffuseMap, offsetG);
    float4 cB = diffuse2D(diffuseMap, offsetB);

    // Compute depth at green channel UV for reference
    float depthVal = depth2D(depthMap, offsetG, invertDepth, useProjectedDepth);
    float3 pixel = float3(offsetG, depthVal);
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    
    float3 ior = RefractiveIndexFromDispersionCoefficients(RGBToWavelengthsNM(iridescentColor), mat.dispersionCoefficientsNm2[dispersionIndex]);
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(ior, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, normal), cosThetaT);
    
    OpticalPathResult opd =
        OpticalPathDifference(
            RGBToWavelengthsNM(diffuse2D(diffuseMap, inputUV).rgb), float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
            DifferenceMPathFromPointThicknessM(viewPos, pixel, mat.thicknessM, normal2D11W(normalMap, offsetG.xy, NormalRadius, false)),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, cosThetaT);
    
    // Placeholder rotateHue function:
    float3 rotatedIridescence = iridescentColor;
    // If rotateHue is available, use:
    rotatedIridescence = rotateHue(iridescentColor, mToNm(opd.opticalMeasurement.PathDifferenceM));

    // Combine channels and apply iridescent color
    float3 baseColor = diffuse2D(diffuseMap, inputUV).xyz;
    float3 combinedRGB = float3(cR.r, cG.g, cB.b) * rotatedIridescence;

    // Lerp: 75% towards aberrated color
    float3 color = lerp(baseColor, combinedRGB, 0.75);

    return saturate(color);
}


inline float3 chromaticAberration(
    Texture2D<float4> diffuseMap,
    Texture2D<float3> noiseMap,
    float depth,
    float2 inputUV,
    float3 viewDir,
    float3 normal,
    float aberrationStrength,
    float aberrationOffsetStrength,
    float time
)
{
    float3 V = safeNormalize(viewDir);
    float3 N = safeNormalize(normal);
    float d = saturate(dot(V, N));
    float angle = acos(d) * aberrationStrength;
    float3 aberration = sin(angle.xxx);
    float3 animatedAberration = aberration * cos(time);

    float2 ooszDiffuse = GetOosz(diffuseMap);
    
    float2 offset = animatedAberration.xy * ooszDiffuse;

    float3 noiseSample = noiseMap.SampleLevel(sampleTypeLinear, inputUV, 0);
    float3 noiseFactor = noiseSample * 0.002;
    float3 rainbow = float3(1, 1, 1);

    float2 offsetR = aberrationOffsetStrength * ((offset - 0.5) * float2(-1, noiseFactor.r) * depth + 0.5) * 0.1;
    float2 offsetB = aberrationOffsetStrength * ((offset - 0.5) * float2(1, noiseFactor.b) * depth + 0.5) * 0.1;

    float4 cR = diffuse2D(diffuseMap, inputUV + offsetR);
    float4 cG = diffuse2D(diffuseMap, inputUV);
    float4 cB = diffuse2D(diffuseMap, inputUV + offsetB);

    float r = cR.r * rainbow.r;
    float g = cG.g;
    float b = cB.b * rainbow.b;

    return saturate(float3(r, g, b));
}


inline float IridescenceR(
    float albedo,
    float thicknessM,
    float ior)
{
    float wavelengthNM = max(RGBToWavelengthR(albedo), EPSILON);
    float phaseShift = PhaseShiftM_Single(nmToM(wavelengthNM), thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}

inline float IridescenceG(
    float albedo,
    float thicknessM,
    float ior)
{
    float wavelengthNM = max(RGBToWavelengthG(albedo), EPSILON);
    float phaseShift = PhaseShiftM_Single(nmToM(wavelengthNM), thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}

inline float IridescenceB(
    float albedo,
    float thicknessM,
    float ior)
{
    float wavelengthNM = max(RGBToWavelengthB(albedo), EPSILON);
    float phaseShift = PhaseShiftM_Single(nmToM(wavelengthNM), thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}


inline float3 Iridescence(
    float3 albedo,
    float thicknessM,
    float3 ior)
{
    float3 wavelengthsNM = max(RGBToWavelengthsNM(albedo), EPSILON3);
    float3 phaseShift = PhaseShiftM(nmToM(wavelengthsNM), thicknessM * (1.0 + PassNum), ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}


// Nonlinear term for enhanced realism
inline float3 nonlinear_effect(float3 amplitude, float dist)
{
    return amplitude * exp(-dist * dist);
}

// Gravitational phase shift due to photonic gravitation
inline float3 gravitational_phase_shift(float3 mass, float distance, float3 frequency, float time, float speedOfLight)
{

    float3 potential = -G * mass / max(distance, EPSILON);
	// Gravitational time dilation affects frequency
    float3 deltaFrequency = -potential * frequency / (speedOfLight * speedOfLight);
	// Phase shift due to change in frequency over time
    float3 deltaPhase = deltaFrequency * time * 2.0 * PI;
    return deltaPhase;
}

// Gaussian phase scattering function
inline float gaussian_phase_scattering(float3 position, float scatteringStrength)
{
	// Generate a random phase shift based on a Gaussian distribution
    float randomValue = frac(sin(dot(position.xyz, float3(12.9898, 78.233, 37.719))) * 43758.5453);
    float gaussian = exp(-pow(max((randomValue - 0.5) / max(EPSILON, scatteringStrength), EPSILON), 2.0));
    return gaussian;
}

// Utility Function: Apply Volumetric Scattering Based on Depth
inline float applyVolumetricScattering(float depth, float scatterIntensity, float scatterScale)
{
    return 1.0 - exp(-scatterIntensity * depth * scatterScale);
}

// Henyey-Greenstein Phase Function for Directional Scattering
inline float HGPhaseFunction(float cosTheta, float g)
{
    float denominator = 1.0 + g * g - 2.0 * g * cosTheta;
    return (1.0 - g * g) / (4.0 * PI * pow(abs(denominator), 1.5));
}

float3 ColorShiftHolographic(float3 color, float3 shiftAmplitude, float3 shiftSpeed, float time)
{
    // Compute dynamic color shifts for each channel
    float3 shiftedColor = float3(
        sin(time * shiftSpeed.x) * shiftAmplitude.x,
        sin(time * shiftSpeed.y + 2.0 * PI / 3.0) * shiftAmplitude.y,
        sin(time * shiftSpeed.z + 4.0 * PI / 3.0) * shiftAmplitude.z
    );
    
    // Apply color shifting to base color
    float3 finalColor = color * (color + shiftedColor);
    
    // Clamp the final color
    finalColor = saturate(finalColor);
    
    return finalColor;
}

float3 LensFlareHolographic(float2 inputUV, float3 position, float3 phaseShift, float3 flareColor, float radius, float intensity, float time)
{
    // Compute vector from flare position to current pixel
    float2 direction = inputUV - position.xy;
    float distance = length(direction);
    
    // Compute flare intensity based on distance and size
    float flareFactor = exp(-pow(abs(distance / max(EPSILON, radius)), 2.0));
    
    // Apply phase shifts for color modulation
    float3 dynamicPhase = float3(
        sin(time + phaseShift.x),
        sin(time + phaseShift.y),
        sin(time + phaseShift.z)
    );
    
    // Modulate flare color with dynamic phase
    float3 modulatedColor = flareColor * (0.5 + 0.5 * dynamicPhase);
    
    // Compute final flare color
    return modulatedColor * intensity * flareFactor;
}




float3 SeparableSSS(
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float3 albedo,
    float3 scatteringCoeff,
    float3 absorptionCoeff,
    float scatteringRadius = 0.1)
{
    // Normalize input vectors
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    lightDir = safeNormalize(lightDir);
    
    // Compute attenuation based on distance and scattering properties
    float3 us = scatteringCoeff; // Scattering coefficients for RGB
    float3 ua = absorptionCoeff; // Absorption coefficients for RGB
    float3 ut = us + ua; // Extinction coefficients
    
    // Compute the attenuation using the exponential decay law
    float3 attenuation = exp(-ut * scatteringRadius);
    
    // Compute the diffuse lighting contribution
    float3 diffuseLighting = albedo / PI * saturate(dot(normal, lightDir));
    
    // Compute the SSS contribution
    float3 SSS = diffuseLighting * us * attenuation;
    
    // Ensure the SSS contribution is within [0,1]
    return saturate(SSS);
}
float3 AdvancedSeparableSSS(
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float NdotL,
    float3 albedo,
    float3 scatteringCoeff,
    float3 absorptionCoeff,
    float g,
    float scatteringRadius)
{
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    lightDir = normalize(lightDir);

    // Extinction coefficients
    float3 us = scatteringCoeff;
    float3 ua = absorptionCoeff;
    float3 ut = us + ua;
    
    float3 attenuation = exp(-ut * scatteringRadius);
    float3 diffuseLighting = (albedo / PI) * NdotL;

    // Henyey-Greenstein phase function:
    float3 direction = reflect(lightDir, normal);
    float3 scatteringDir = normalize(direction + viewDir);
    float cosTheta = abs(dot(normal, scatteringDir));
    float phase = HGPhaseFunction(cosTheta, g);

    float3 SSS = diffuseLighting * us * phase * attenuation;
    return saturate(SSS);
}
float3 MieScattering(float3 viewDir, float3 lightDir, float3 wavelength, float g, float scale, float3 intensity)
{
    viewDir = normalize(viewDir);
    lightDir = normalize(lightDir);

    float cosTheta = abs(dot(viewDir, lightDir));
    float basePhaseMie = (3.0 / (16.0 * PI)) * (1.0 + pow(abs(cosTheta), 2.0));

    float gg = g * g;
    float denominator = 4.0 * PI * pow(abs(1.0 + gg - 2.0 * g * cosTheta), 1.5);
    denominator = max(denominator, EPSILON);
    float hgPhase = (1.0 - gg) / denominator;
    
    // If g≈0, use basePhaseMie, else use hgPhase
    float gMask = step(EPSILON, abs(g)); //1 if |g|≥EPSILON else 0
    float phaseMie = lerp(basePhaseMie, hgPhase, gMask);

    // Approximate wavelength dependence (Rayleigh-like)
    float3 refWavelength = float3(400, 500, 650);
    float3 scattering = pow(abs(refWavelength / max(wavelength, EPSILON3)), 4.0);
    
    float3 scatteringEffect = scattering * phaseMie * scale * intensity;
    return scatteringEffect;
}

float3 CombinedHolographicShading(
    Texture2D<float4> diffuseMap,
    Texture2D<float3> normalMap,
    Texture2D<float> depthMap,
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    float3 initialColor,
    float3 normal,
    float depth,
    float3 viewDir,
    float3 lightDir,
    MaterialSellmeier mat,
    float angularSpread,
    float scatteringRadius,
    float g, // anisotropy factor for scattering
    float3 scatteringCoeff,
    float3 absorptionCoeff,
    float chromaticAberrationStrength,
    float hueShift,
    float saturation,
    float gamma,
    float highlight,
    float time
)
{
    // Normalize input directions
    normal = normalize(normal);
    viewDir = normalize(viewDir);
    lightDir = normalize(lightDir);

    // Compute NdotL and NdotV
    float NdotL = saturate(dot(normal, lightDir));
    float NdotV = saturate(dot(normal, viewDir));

    // Wavelength-based computations:
    // Suppose we can derive wavelengths from initialColor or have a known wavelength triple
    float3 wavelengthsNM = RGBToWavelengthsNM(initialColor);
    wavelengthsNM = max(wavelengthsNM, EPSILON3);

    // Compute Fresnel reflectance: Using Fresnel3 or a similar function (no if)
    float3 fresnelReflectance = Fresnel3(inputUV, time, float3(mat.metallic, mat.metallic, mat.metallic), viewDir, normal, mat.thicknessM * (1.0 - depth / DepthScale), FresnelPower, FresnelReflectance, mat.nSurrounding, mat.etaR, 1.0 - mat.absorptionCoefficient);
    fresnelReflectance = saturate(fresnelReflectance);

    // Compute advanced SSS
    float3 SSS = AdvancedSeparableSSS(normal, viewDir, lightDir, NdotL, initialColor, scatteringCoeff, absorptionCoeff, g, scatteringRadius) + fresnelReflectance;

    // Combine initial color with SSS and Fresnel
    float3 combinedColor = initialColor + (1 - fresnelReflectance) + SSS;

    // Apply angular spread:
    // First compute angleToViewer (same angle for R, G, B)
    float cosTheta = abs(dot(normal, viewDir));
    float angleToViewer = acos(cosTheta);
    float adjustedIntensity = ApplyAngularSpread(1.0, angularSpread, angleToViewer);
    // For vector version of ApplyAngularSpread:
    // float3 angle3 = float3(angleToViewer, angleToViewer, angleToViewer);
    // float3 spread3 = float3(angularSpread, angularSpread, angularSpread);
    // float3 adjustedIntensityV = ApplyAngularSpread(ONE3, spread3, angle3);
    // combinedColor *= adjustedIntensityV; (if per-channel needed)
    combinedColor *= adjustedIntensity;

    // Apply wavelength-dependent Gaussian blur:
    float3 blurRadius = WavelengthDependentBlurRadius(wavelengthsNM, 25.0 * (1.0 - depth / DepthScale));
    float3 blurredColor = GaussianBlurWavelengthDependent(diffuseMap, inputUV, blurRadius);

    // Blend combinedColor with blurredColor for a bloom-like effect
    float bloomMask = step(0.7, dot(combinedColor, float3(0.2126, 0.7152, 0.0722))); // brightness threshold
    float3 bloomColor = lerp(combinedColor, blurredColor, saturate(0.3)) * bloomMask;
    combinedColor = (combinedColor + bloomColor * bloomMask * 0.5);

    // Add highlights if wavelength≥650 nm on average
    float avgW = (wavelengthsNM.x + wavelengthsNM.y + wavelengthsNM.z) / 3.0;
    float highlightMask = step(650.0, avgW);
    combinedColor += highlightMask * ONE3 * highlight * 0.3;

    // Apply hue shift, saturation, gamma:
  //  combinedColor = rotateHue(combinedColor, fmod(hueShift, 360.0));
   // combinedColor = AdjustSaturation(combinedColor, saturation);
    combinedColor = AdjustGamma(combinedColor, gamma);

    // Add subtle noise:
    //combinedColor += noiseFast2D_01(uvForNoise * 100.0) * 0.02;

    // Apply chromatic aberration:
    // For simplicity, shift red and blue channels horizontally
    float3 aberrationColor = diffuse2D(diffuseMap, inputUV).xyz + combinedColor; // if you have a function applyChroma, call it here
    // Example simple approach:
    // shift red channel right, blue channel left based on chromaticAberrationStrength
    float2 oosz = GetOosz(diffuseMap);
    float2 shiftAmount = oosz * chromaticAberrationStrength * 2.0; // 2.0 chosen arbitrarily
    float4 cR = diffuse2D(diffuseMap, inputUV + float2(shiftAmount.x, 0.0));
    float4 cG = diffuse2D(diffuseMap, inputUV);
    float4 cB = diffuse2D(diffuseMap, inputUV - float2(shiftAmount.x, 0.0));

    // Combine channels
    float3 caColor = float3(cR.r, cG.g, cB.b);
    // Lerp combinedColor and caColor
    combinedColor = lerp(combinedColor, caColor, 0.5);

    // Ensure final result is clamped
    return saturate(combinedColor);
}


static const float kernelR[7] = { 0.220, 0.100, 0.130, 0.115, 0.085, 0.040, 0.010 };
static const float kernelG[7] = { 0.233, 0.100, 0.118, 0.113, 0.082, 0.042, 0.009 };
static const float kernelB[7] = { 0.250, 0.110, 0.125, 0.120, 0.090, 0.050, 0.015 };


float3 PS_SSS_Vertical(
    float2 inputUV,
    float time,
    Texture2D<float4> diffuseMap,
    float2 diffuseUV,
    MaterialSellmeier mat,
    float3 viewDir,
    float3 lightDir,
    bool invertDepth, bool useProjectedDepth)
{
    // Retrieve one-over-size for required maps
    float2 ooszDiffuse = GetOosz(diffuseMap);
    float2 ooszNormal = GetOosz(normalMap);
    float2 ooszDepth = GetOosz(depthMap);

    // Convert UV for depth/normal maps as needed
    float2 depthUV = convertUV4ToUV1(diffuseMap, diffuseUV, depthMap);
    float2 normalUV = convertUV4ToUV3(diffuseMap, diffuseUV, normalMap);

    // Base sample
    float3 baseColor = diffuse2D(diffuseMap, diffuseUV).rgb;
    float3 color = baseColor * float3(kernelR[0], kernelG[0], kernelB[0]);

    // Compute normal and depth
    float3 N = normal2DPoint11W(normalMap, normalUV, false);
  
    float depth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    // Compute center reference for distance-based adjustments
    float3 center = float3(0.5, 0.5, depth2D(depthMap, float2(0.5, 0.5), invertDepth, useProjectedDepth));
    float3 currentPixelPos = float3(depthUV, depth);
    float centerDist = distance(center, currentPixelPos);
    
    float3 fresnelTerm = Fresnel3(inputUV, time,
        float3(mat.metallic, mat.metallic, mat.metallic),
        viewDir,
        N,
        mat.thicknessM,
        FresnelPower,
        FresnelReflectance,
        mat.nSurrounding,
        mat.etaR,
        1.0 - mat.absorptionCoefficient
    );

    // Iterate over kernel samples vertically
    // We rely on [unroll] and indexing, no if needed
    [unroll(7)]
    for (int i = 1; i < 7; ++i)
    {
        float offsetDiffuse = float(i) * ooszDiffuse.y;
        float offsetNormal = float(i) * ooszNormal.y;
        float offsetDepth = float(i) * ooszDepth.y; // if needed

        // Samples above and below
        float2 uvPlus = diffuseUV + float2(0.0, offsetDiffuse);
        float2 uvMinus = diffuseUV - float2(0.0, offsetDiffuse);

        float3 diffusePlus = diffuse2D(diffuseMap, uvPlus).xyz;
        float3 diffuseMinus = diffuse2D(diffuseMap, uvMinus).xyz;

        float3 normalPlus = normalize(normal2DPoint11W(normalMap, normalUV + float2(0.0, offsetNormal), false));
        float3 normalMinus = normalize(normal2DPoint11W(normalMap, normalUV - float2(0.0, offsetNormal), false));

        // Compute blendFactor for samples based on depth
        float blendFactorPos = 0.75;
        float blendFactorNeg = blendFactorPos; // symmetrical

        // Compute wavelength-dependent blur radius
        float3 radiusFactor = float3(5.0 * centerDist,
                                     5.0 * centerDist,
                                     5.0 * centerDist);

        // Blur samples for plus and minus
        float3 samplePlus = lerp(
            GaussianBlurWavelengthDependent(diffuseMap, uvPlus, WavelengthDependentBlurRadius(RGBToWavelengthsNM(diffusePlus), radiusFactor)),
            diffusePlus,
            blendFactorPos
        );

        float3 sampleMinus = lerp(
            GaussianBlurWavelengthDependent(diffuseMap, uvMinus, WavelengthDependentBlurRadius(RGBToWavelengthsNM(diffuseMinus), radiusFactor)),
            diffuseMinus,
            blendFactorNeg
        );

        float NdotLP = dot(normalPlus, N);
        float NdotLM = dot(normalMinus, N);
        
          // Accumulate weighted samples
        color.r += ((samplePlus.r * NdotLP + sampleMinus.r * NdotLM + fresnelTerm.r)) * kernelR[i];
        color.g += ((samplePlus.g * NdotLP + sampleMinus.g * NdotLM + fresnelTerm.g)) * kernelG[i];
        color.b += ((samplePlus.b * NdotLP + sampleMinus.b * NdotLM + fresnelTerm.b)) * kernelB[i];

    }


    // Clamp final color
    return saturate(color);
}


float3 PS_SSS_Horizontal(
    float2 inputUV,
    float time,
    Texture2D<float4> diffuseMap,
    float2 diffuseUV,
    MaterialSellmeier mat,
    float3 viewDir,
    float3 lightDir,
    bool invertDepth, bool useProjectedDepth)
{
    // Retrieve one-over-size for required maps
    float2 ooszDiffuse = GetOosz(diffuseMap);
    float2 ooszNormal = GetOosz(normalMap);
    float2 ooszDepth = GetOosz(depthMap);

    // Convert UV for depth/normal maps as needed
    float2 depthUV = convertUV4ToUV1(diffuseMap, diffuseUV, depthMap);
    float2 normalUV = convertUV4ToUV3(diffuseMap, diffuseUV, normalMap);

    // Base sample
    float3 baseColor = diffuse2D(diffuseMap, diffuseUV).rgb;
    float3 color = baseColor * float3(kernelR[0], kernelG[0], kernelB[0]);

    // Compute normal and depth
    float3 N = normal2DPoint11W(normalMap, normalUV, false);
  
    float depth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    // Compute center reference for distance-based adjustments
    float3 center = float3(0.5, 0.5, depth2D(depthMap, float2(0.5, 0.5), invertDepth, useProjectedDepth));
    float3 currentPixelPos = float3(depthUV, depth);
    float centerDist = distance(center, currentPixelPos);
    
    float3 fresnelTerm = Fresnel3(inputUV, time,
            float3(mat.metallic, mat.metallic, mat.metallic),
            viewDir,
            N,
            mat.thicknessM,
            FresnelPower,
            FresnelReflectance,
            mat.nSurrounding,
            mat.etaR,
            1.0 - mat.absorptionCoefficient
        );

    fresnelTerm = saturate(fresnelTerm);

    // Iterate over kernel samples vertically
    // We rely on [unroll] and indexing, no if needed
    [unroll(7)]
    for (int i = 1; i < 7; ++i)
    {
        float offsetDiffuse = float(i) * ooszDiffuse.x;
        float offsetNormal = float(i) * ooszNormal.x;
        float offsetDepth = float(i) * ooszDepth.x; // if needed

        // Samples above and below
        float2 uvPlus = diffuseUV + float2(offsetDiffuse, 0.0);
        float2 uvMinus = diffuseUV - float2(offsetDiffuse, 0.0);

        float3 diffusePlus = diffuse2D(diffuseMap, uvPlus).xyz;
        float3 diffuseMinus = diffuse2D(diffuseMap, uvMinus).xyz;

        float3 normalPlus = normal2DPoint11W(normalMap, normalUV + float2(offsetNormal, 0.0), false);
        float3 normalMinus = normal2DPoint11W(normalMap, normalUV - float2(offsetNormal, 0.0), false);

        // Compute blendFactor for samples based on depth
        float blendFactorPos = 0.75;
        float blendFactorNeg = blendFactorPos; // symmetrical

        // Compute wavelength-dependent blur radius
        float3 radiusFactor = float3(5.0 * centerDist,
                                     5.0 * centerDist,
                                     5.0 * centerDist);

        // Blur samples for plus and minus
        float3 samplePlus = lerp(
            GaussianBlurWavelengthDependent(diffuseMap, uvPlus, WavelengthDependentBlurRadius(RGBToWavelengthsNM(diffusePlus), radiusFactor)),
            diffusePlus,
            blendFactorPos
        );

        float3 sampleMinus = lerp(
            GaussianBlurWavelengthDependent(diffuseMap, uvMinus, WavelengthDependentBlurRadius(RGBToWavelengthsNM(diffuseMinus), radiusFactor)),
            diffuseMinus,
            blendFactorNeg
        );

        float NdotLP = abs(dot(normalPlus, N));
        float NdotLM = abs(dot(normalMinus, N));
        
        // Accumulate weighted samples
        color.r += ((samplePlus.r * NdotLP + sampleMinus.r * NdotLM + fresnelTerm.r)) * kernelR[i];
        color.g += ((samplePlus.g * NdotLP + sampleMinus.g * NdotLM + fresnelTerm.g)) * kernelG[i];
        color.b += ((samplePlus.b * NdotLP + sampleMinus.b * NdotLM + fresnelTerm.b)) * kernelB[i];

    }

    // Clamp final color
    return saturate(color);
}


// Define the chromatic aberration function
float3 ChromaticAberration(float3 viewDirection, float3 normal, float3 refractiveIndex, float abbeNumber)
{
	// Calculate the chromatic aberration
    float3 chromaticAberration = viewDirection * (ONE3 - (refractiveIndex - ONE3) / max((abbeNumber * (normal.z * normal.z)), EPSILON));

    return chromaticAberration;
}

float3 ChromaticAberration(Texture2D<float4> diffuseMap, float2 uv, int radius, float3 viewDir, float3 particleNormal, bool invertDepth, bool useProjectedDepth, MaterialSellmeier mat, int dispersionIndex)
{
    float2 oosz = GetOosz(diffuseMap);
    float3 diffuse = diffuse2D(diffuseMap, uv).rgb;
    
    float2 uvR = float2(uv + oosz * float2(float(radius), 0.0));
    float2 uvL = float2(uv - oosz * float2(float(radius), 0.0));

    float3 pixelC = float3(uv, depth2D(depthMap, uv));
    float3 pixelR = float3(uvR, depth2D(depthMap, uvR));
    float3 pixelL = float3(uvL, depth2D(depthMap, uvL));
    
    float3 diffuseC = diffuse2D(diffuseMap, uv).rgb;
    float3 diffuseR = diffuse2D(diffuseMap, uvR).rgb;
    float3 diffuseL = diffuse2D(diffuseMap, uvL).rgb;

    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float3 sunPos = float3(SunX, SunY, SunZ);
    
    float3 wavelengthsNM = RGBToWavelengthsNM(diffuse);
    PathMeasurement mR = DifferenceMPathFromPointThicknessM(viewPos, pixelR, 0.002, particleNormal);
    PathMeasurement mL = DifferenceMPathFromPointThicknessM(viewPos, pixelL, 0.002, particleNormal);
    
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(mat.etaR, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, particleNormal), cosThetaT);
    
    
    OpticalPathResult opdR = OpticalPathDifference(wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
        mR, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaT);
    OpticalPathResult opdL = OpticalPathDifference(wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), mL, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaT);
    
    float3 rbR = rainbowColor(mToNm(opdR.opticalMeasurement.PathDifferenceM.x));
    float3 rbL = rainbowColor(mToNm(opdL.opticalMeasurement.PathDifferenceM.x));

    float3 r = diffuseR.r * rbR;
    float3 g = diffuseC.g * diffuseC;
    float3 b = diffuseL.b * rbL;
    return (r + g + b) / 3.0;
}

Complex3 FresnelComplex(Complex3 ior, float3 normal, float3 lightDir)
{
    // Cosine of the incident angle
    float cosThetaI = saturate(dot(normal, lightDir));
    
    // Snell's law to calculate the transmitted angle (cosThetaT)
    Complex3 sinThetaT = ComplexMul(ior, ComplexCreate(sqrt(1.0 - cosThetaI * cosThetaI), ZERO3));
    Complex3 cosThetaT = ComplexSqrt(ComplexSub(ComplexCreate(1.0, ZERO3), ComplexMul(sinThetaT, sinThetaT)));
    
    // Parallel and Perpendicular Components
    Complex3 rParallel = ComplexDiv(
        ComplexSub(ComplexMul(ior, ComplexCreate(cosThetaI, ZERO3)), cosThetaT),
        ComplexAdd(ComplexMul(ior, ComplexCreate(cosThetaI, ZERO3)), cosThetaT)
    );

    Complex3 rPerpendicular = ComplexDiv(
        ComplexSub(ComplexCreate(cosThetaI, ZERO3), cosThetaT),
        ComplexAdd(ComplexCreate(cosThetaI, ZERO3), cosThetaT)
    );

    // Fresnel Reflectance (Average of Parallel and Perpendicular)
    return ComplexMul(ComplexCreate(0.5 * ONE3, ZERO3), ComplexAdd(ComplexMul(rParallel, rParallel), ComplexMul(rPerpendicular, rPerpendicular)));
}


// Complex Fresnel Reflectance Calculation
inline float3 FresnelComplex(
    float3 eta_ratio,
    float3 k_ratio,
    float cosTheta,
    float3 cosThetaT)
{
    // Rs = ((eta_ratio - cosThetaT)^2 + k_ratio^2) / ((eta_ratio + cosThetaT)^2 + k_ratio^2)
    float3 numeratorRs = (eta_ratio - cosThetaT) * (eta_ratio - cosThetaT) +
                         (k_ratio * k_ratio);
    float3 denominatorRs = (eta_ratio + cosThetaT) * (eta_ratio + cosThetaT) +
                           (k_ratio * k_ratio);
    float3 Rs = numeratorRs / max(denominatorRs, EPSILON3);

    // Rp = ((eta_ratio * cosTheta - cosThetaT)^2 + k_ratio^2) / ((eta_ratio * cosTheta + cosThetaT)^2 + k_ratio^2)
    float3 numeratorRp = (eta_ratio * cosTheta - cosThetaT) *
                         (eta_ratio * cosTheta - cosThetaT) +
                         (k_ratio * k_ratio);
    float3 denominatorRp = (eta_ratio * cosTheta + cosThetaT) *
                           (eta_ratio * cosTheta + cosThetaT) +
                           (k_ratio * k_ratio);
    float3 Rp = numeratorRp / max(denominatorRp, EPSILON3);

    // Fresnel reflectance for unpolarized light
    float3 F = (Rs + Rp) * 0.5f;

    return F;
}

inline float3 SpecularTransmission(
    float2 inputUV, float time,
    float3 eta_ratio,
    float3 k_ratio,
    float3 cosThetaT,
    float3 wavelengthsNM,
    float3 thicknessM,
    SellmeierCoefficientsBC filmEta_coeffs)
{
    // Transmission Fresnel term: T = 1 - F
    float3 F = FresnelComplex(eta_ratio, k_ratio, 1.0f, cosThetaT);
    float3 T = 1.0f - F;

    // Apply Beer-Lambert Law
    float3 absorption = exp(-k_ratio * thicknessM);

    // Apply Thin-Film Interference
    float3 interference = InterferenceThinFilm(inputUV, time, nmToM(wavelengthsNM), thicknessM, filmEta_coeffs);

    // Final Transmission
    float3 transmission = T * absorption * interference;

    return transmission;
}


//Simple Lambertian Subsurface Scattering
inline float3 SubsurfaceScattering(
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float3 albedo,
    float3 scatteringCoeff,
    float3 absorptionCoeff)
{
    float3 N = safeNormalize(normal);
    float3 L = safeNormalize(lightDir);
    float NdotL = saturate(dot(N, L));

    // Simple Lambertian SSS: albedo * scattering * NdotL
    // absorptionCoeff currently unused, can be integrated if needed
    return saturate(albedo * scatteringCoeff * NdotL);
}

//Texture-Based Scattering
float3 SubsurfaceScattering(Texture2D<float3> diffuseMap, float2 inputUV, float3 lightDir, float3 normal, float3 eta, float3 dispersion)
{
    // Compute scattering for each RGB channel
    float3 scatteredR = diffuse2D(diffuseMap, inputUV + lightDir.xy + dispersion.r).rgb;
    float3 scatteredG = diffuse2D(diffuseMap, inputUV + lightDir.xy + dispersion.g).rgb;
    float3 scatteredB = diffuse2D(diffuseMap, inputUV + lightDir.xy + dispersion.b).rgb;
    
    // Combine the scattered light
    return float3(scatteredR.r, scatteredG.g, scatteredB.b);
}


// Integrate Light Scattering using Gaussian Approximations
// Gaussian Approximation for Light Scattering
float3 ApplyLightScattering(float3 color, float3 normal, float3 lightDir, float3 viewDir)
{
	// Simple Gaussian scattering based on the angle between normal and light direction
    float scatter = exp(-pow(max(abs(dot(normal, lightDir)) - 0.5, EPSILON), 2.0) / 0.1);
    return color * scatter;
}

//Angle-Based Subsurface Scattering
inline float3 SubsurfaceScattering(
    float3 N,
    float3 V,
    float3 L,
    float3 diffuseColor,
    float3 sssColor,
    float sssStrength)
{
    // Compute the angle between normal and light direction
    float cosTheta = saturate(dot(N, L));

    // Compute the angle between normal and view direction
    float cosThetaV = saturate(dot(N, V));

    // Simple approximation: SSS depends on both angles
    float sssFactor = sssStrength * (cosTheta + cosThetaV) * 0.5f;

    // Combine diffuse and SSS
    float3 finalDiffuse = diffuseColor + sssColor * sssFactor;

    return finalDiffuse;
}


inline float3 SubsurfaceScatteringHybrid(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float3 albedo,
    float3 scatteringCoeff,
    float3 absorptionCoeff,
    float sssStrength,
    float3 dispersion)
{
    // Compute Lambertian scattering
    float3 N = safeNormalize(normal);
    float3 L = safeNormalize(lightDir);
    float3 V = safeNormalize(viewDir);
    float NdotL = saturate(dot(N, L));
    float NdotV = saturate(dot(N, V));

    // Angle-based scattering factor
    float sssFactor = sssStrength * (NdotL + NdotV) * 0.5f;

    // Texture-based spectral scattering
    float3 scatteredR = diffuse2D(diffuseMap, inputUV + dispersion.r).rgb;
    float3 scatteredG = diffuse2D(diffuseMap, inputUV + dispersion.g).rgb;
    float3 scatteredB = diffuse2D(diffuseMap, inputUV + dispersion.b).rgb;

    float3 spectralScattering = float3(scatteredR.r, scatteredG.g, scatteredB.b);

    // Combine diffuse, scattering, and absorption
    return saturate(albedo * scatteringCoeff * NdotL + spectralScattering * sssFactor - absorptionCoeff);
}



inline float3 MultiLayerTransmission(
    float2 inputUV, float time,
    float3 normal,
    float3 lightDir,
    float3 wavelengthsNM,
    float thicknessM,
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS],
    int numThinFilms)
{
    // Initialize transmission to 1
    float3 transmission = ONE3;
    float3 surrounding = ONE3;

    // Iterate through each thin film layer
    for (int i = 0; i < numThinFilms; i++)
    {
        // Calculate interference for the current layer
        float3 interference = InterferenceThinFilm(inputUV, time,
            nmToM(wavelengthsNM),
            thinFilms[i].filmThicknessM,
            thinFilms[i].filmEta_coeffs.OE1.O.B,
            dot(normal, lightDir),
            surrounding);
        
        // Multiply with transmission
        transmission *= interference;
        surrounding = thinFilms[i].filmEta_coeffs.OE1.O.B;
    }

    return transmission;
}
float DistributionGGX(float NdotH, float roughness)
{
    float alpha = roughness * roughness;
    float alpha2 = alpha * alpha;
    float denom = (NdotH * NdotH) * (alpha2 - 1.0) + 1.0;
    denom = PI * denom * denom; // Square the denominator

    return alpha2 / max(denom, EPSILON); // Prevent division by zero
}

float GeometrySchlickGGX(float NdotV, float roughness)
{
    float a = roughness;
    float k = (a * a) / 2.0; // Common approximation

    return NdotV / max((NdotV * (1.0 - k) + k), EPSILON);
}

// G1 function to compute the geometric attenuation term with normal `N`
float G1(float3 direction, float3 N, AnisotropicRoughness roughness)
{
    // Normalize the input vectors
    float3 D = normalize(direction);
    float3 normal = normalize(N);
    
    // Early exit if the direction is below the surface
    if (dot(D, normal) <= 0.0f)
        return 0.0f;

    // Compute tan(theta) safely
    float tanTheta = sqrt(max(1.0f - D.z * D.z, 0.0f)) / max(D.z, EPSILON);
    
    // Compute the horizontal component once to avoid redundant calculations
    float horizontal = sqrt(max(D.x * D.x + D.y * D.y, EPSILON));
    float cosPhi = D.x / horizontal;
    float sinPhi = D.y / horizontal;
    
    // Calculate alpha based on the direction's azimuth angle
    float alphaSquared = (cosPhi * cosPhi) / max(EPSILON, roughness.alphaX * roughness.alphaX) +
                         (sinPhi * sinPhi) / max(EPSILON, roughness.alphaY * roughness.alphaY);
    float alpha = sqrt(max(EPSILON, alphaSquared));
    
    // Compute 'a' safely
    float a = 1.0f / max(EPSILON, alpha * tanTheta);
    
    // Compute the G term based on the value of 'a'
    return lerp(
        (3.535f * a + 2.181f * a * a) / max(EPSILON, 1.0f + 2.276f * a + 2.577f * a * a),
        1.0f,
        step(1.6f, a));
    return G;
}


// Calculates the Smith correlated GGX geometric shadowing function.
inline float SmithGGXCorrelated(float NdotL, float NdotV, float roughness)
{
    roughness = max(roughness, EPSILON);
    float a2 = roughness * roughness;

    float GGXV = NdotV * sqrt(max(NdotL * (NdotL * (1.0 - a2) + a2), EPSILON));
    float GGXL = NdotL * sqrt(max(NdotV * (NdotV * (1.0 - a2) + a2), EPSILON));

    return 0.5 / max(GGXV + GGXL, EPSILON);
}


float G1f(float3 direction, float3 N, float roughnessX, float roughnessY)
{
    AnisotropicRoughness r = (AnisotropicRoughness) 0;
    r.alphaX = roughnessX;
    r.alphaY = roughnessY;
    return G1(direction, N, r);
}

float GeometrySmithVLNf(float3 V, float3 L, float3 N, float roughness)
{

// Ensure vectors are normalized
    N = normalize(N);
    L = normalize(L);
    V = normalize(V);

// Calculate dot products
    float NdotL = max(dot(N, L), EPSILON); // Prevent division by zero
    float NdotV = max(dot(N, V), EPSILON); // Prevent division by zero

// Return the Smith GGX Correlated visibility term
    return SmithGGXCorrelated(NdotL, NdotV, roughness);
   
}
// Combined Geometry Function using Smith's method for anisotropic materials
float GeometrySmithNVL(float3 N, float3 V, float3 L, AnisotropicRoughness roughness)
{
    // Reuse the GeometrySmithVLN function for consistency
    return GeometrySmithVLNf(V, L, N, roughness.alphaX);
}
float GeometrySmithNVLf(float3 N, float3 V, float3 L, float roughness)
{
    // Reuse the GeometrySmithVLN function for consistency
    return GeometrySmithVLNf(V, L, N, roughness);
}
void CreateThinFilms(inout ThinFilmProperties thinFilms[MAX_GRATING_LAYERS])
{
    thinFilms[0] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 0.0002, 0.012);
    thinFilms[1] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 0.0012, 0.01);
    thinFilms[2] = SELLMEIER_THIN_FILM_PROPERTY(1.75, 0.0102, 0.03);
    thinFilms[3] = SELLMEIER_THIN_FILM_PROPERTY(2.5, 0.0006, 0.001);
    thinFilms[4] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 0.0002, 0.012);
    thinFilms[5] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 0.0012, 0.001);
    thinFilms[6] = SELLMEIER_THIN_FILM_PROPERTY(1.75, 0.0102, 0.03);
    thinFilms[7] = SELLMEIER_THIN_FILM_PROPERTY(2.5, 0.0006, 0.001);
    thinFilms[8] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 0.0002, 0.012);
    thinFilms[9] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 0.0012, 0.001);
}

inline float3 FresnelMicrofacet(
    float2 inputUV, float time,
    float3 viewDirection,
    float3 lightDirection,
    float3 microfacetNormal,
    MaterialProperties material,
    AnisotropicRoughness roughness,
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS], // Array of thin film layers
    int numThinFilms,
    float3 diffuseColor,
    float3 sssColor,
    float sssStrength, float3 scatteringCoefficient, float3 absorptionCoefficient, float3 dispersionCoefficient, float thicknessM)
{
    // Normalize input vectors
    float3 V = normalize(viewDirection);
    float3 L = normalize(lightDirection);
    float3 N = normalize(microfacetNormal);

    // Half-vector
    float3 H = normalize(V + L);

    // Compute refractive indices using Sellmeier Equation
    float3 eta_i = RefractiveIndexFromCoefficients(material.wavelengthsNM, material.coeff);
    float3 eta_t = RefractiveIndexFromCoefficients(material.wavelengthsNM, material.coeff); // Assuming same coefficients for simplicity

    // Calculate ratio of indices
    float3 eta_ratio = eta_i / eta_t;
    float3 k_ratio = material.k / max(material.k, EPSILON3); // Prevent division by zero

    // Calculate cos(theta) and sin(theta)
    float cosTheta = saturate(dot(N, V));
    float sinThetaSq = 1.0f - cosTheta * cosTheta;
    float sinTheta = sqrt(max(sinThetaSq, 0.0f));

    // Calculate sin(theta_t) using Snell's law for complex refractive indices
    float3 sinThetaT = eta_ratio * sinTheta;

    // Compute Fresnel term based on whether TIR occurs, without branching
    float3 isTIR = step(1.0f, sinThetaT); // 1.0f if TIR, else 0.0f
    float3 oneMinusTIR = 1.0f - isTIR;

    // Calculate cos(theta_t)
    float3 cosThetaTSq = max(0.0f, 1.0f - sinThetaT * sinThetaT);
    float3 cosThetaT = sqrt(cosThetaTSq);

    // Fresnel Reflectance
    float3 F = FresnelComplex(eta_ratio, k_ratio, cosTheta, cosThetaT);

    // Specular Reflectance
    float3 specularReflectance = F * oneMinusTIR + isTIR;

    // Specular Transmission with Thin-Film Interference
    float3 specularTransmission = SpecularTransmission(
        inputUV, time,
        eta_ratio,
        k_ratio,
        cosThetaT,
        material.wavelengthsNM,
        thicknessM,
        material.coeff);

    // Apply Multi-Layer Transmission
    specularTransmission *= lerp(1.0,
        MultiLayerTransmission(
            inputUV, time,
            N, L, material.wavelengthsNM,
            thicknessM,
            thinFilms,
            numThinFilms), numThinFilms > 0);
    

    // Compute Specular Component (Cook-Torrance)
    float D = AnisotropicNDF(H, N, roughness);
    float G = GeometrySmithNVLf(V, L, N, roughness.alphaX);
    float3 specular = (D * specularReflectance * G) / max(4.0f * cosTheta * saturate(dot(N, L)), EPSILON);

    // Compute Diffuse Component with Subsurface Scattering
    float3 diffuse = SubsurfaceScatteringHybrid(diffuseMap, inputUV, N, V, L, diffuseColor, scatteringCoefficient, absorptionCoefficient, sssStrength, dispersionCoefficient) / PI;

    // Compute Specular Transmission Component
    float3 transmissionComponent = (specularTransmission * G) /
            max(4.0f * cosTheta * saturate(dot(N, L)), EPSILON);

    // Final Color Composition
    float3 finalColor = diffuse + specular + transmissionComponent;

    // Ensure energy conservation
    finalColor = saturate(finalColor);

    return finalColor;
}

// ----------------------------------
// 1. Structures and Enumerations
// ----------------------------------

struct FilmLayer
{
    SellmeierCoefficientsBC coefficients; // Sellmeier coefficients for the layer
    float3 thicknessM; // Thickness of the layer in meters
    float3 k; // Imaginary refractive indices (RGB)
};
inline FilmLayer CreateFilmLayer(SellmeierCoefficientsBC coefficients, float3 thicknessM, float3 k)
{
    FilmLayer ret = (FilmLayer) 0;
    ret.coefficients = coefficients;
    ret.thicknessM = thicknessM;
    ret.k = k;
    return ret;
}

struct DiffractionOrder
{
    int order; // Diffraction order (e.g., 1 for first-order)
    float strength; // Strength/intensity of the order
    float wavelengthFactor; // Factor to adjust wavelength for dispersion
};

inline DiffractionOrder CreateDiffractionOrder(int order, float strength, float wavelengthFactor)
{
    DiffractionOrder ret = (DiffractionOrder) 0;
    ret.order = order;
    ret.strength = strength;
    ret.wavelengthFactor = wavelengthFactor;
    return ret;
}

struct GratingLayer
{
    float period; // Grating period in UV space
    float orientation; // Grating orientation in radians
    float strength; // Strength of the diffraction effect
    float phaseOffset; // Phase offset in radians
};

inline GratingLayer CreateGratingLayer(
    float period,
    float orientation,
    float strength,
    float phaseOffset)
{
    GratingLayer ret = (GratingLayer) 0;
    ret.period = period;
    ret.orientation = orientation;
    ret.strength = strength;
    ret.phaseOffset = phaseOffset;
    return ret;
}

// Enumerations for Film Types

#define FILM_TYPE_THICK_GLASS 0
#define FILM_TYPE_OILY_GLASS 1
#define FILM_TYPE_THICK_OIL 2
#define FILM_TYPE_HOLOGRAPHIC 3
#define TOTAL_FILM_TYPES 4

// ----------------------------------
// 2. Pre-Fab Sellmeier Coefficients
// ----------------------------------

static const SellmeierCoefficientsBC PreFabSellmeierCoefficients[TOTAL_FILM_TYPES] =
{
    // FILM_TYPE_THICK_GLASS (BK7 Glass)
    {
        float3(1.03961212f, 1.03961212f, 1.03961212f), // B coefficients for R, G, B
        float3(0.00600069867f, 0.00600069867f, 0.00600069867f) // C coefficients (µm²) for R, G, B
    },
    // FILM_TYPE_OILY_GLASS (SiO₂-Oil Mixture)
    {
        float3(1.45f, 1.45f, 1.45f), // B coefficients for R, G, B (example values)
        float3(0.005f, 0.005f, 0.005f) // C coefficients (µm²) for R, G, B
    },
    // FILM_TYPE_THICK_OIL (Vegetable Oil)
    {
        float3(1.47f, 1.47f, 1.47f), // B coefficients for R, G, B (example values)
        float3(0.004f, 0.004f, 0.004f) // C coefficients (µm²) for R, G, B
    },
    // FILM_TYPE_HOLOGRAPHIC (TiO2/MgF2 Multilayer)
    {
        float3(2.4f, 2.4f, 2.4f), // B coefficients for R, G, B (TiO2)
        float3(0.0405f, 0.0405f, 0.0405f) // C coefficients (µm²) for R, G, B
    }
};

// Function to Calculate Fresnel Reflectance for S and P Polarizations
inline float2 FresnelPolarized(float3 n, float3 I, float3 L)
{
    // Normalize vectors
    float3 N = normalize(n);
    float3 incident = normalize(I);
    float3 light = normalize(L);
    
    // Calculate the cosine of the angle of incidence
    float cosThetaI = saturate(dot(-incident, N));
    
    // Calculate the sine of the angle of incidence using Snell's Law
    float sinThetaI = sqrt(1.0f - cosThetaI * cosThetaI);
    
    // Calculate the cosine of the angle of transmission
    float eta = 1.0f / n.x; // Assuming n is scalar for simplicity
    float sinThetaT = sinThetaI * eta;
    
    // Total internal reflection check
    if (sinThetaT >= 1.0f)
    {
        return float2(1.0f, 1.0f); // Total internal reflection
    }
    
    float cosThetaT = sqrt(1.0f - sinThetaT * sinThetaT);
    
    // Calculate reflection coefficients for s and p polarizations
    float Rs = pow((eta * cosThetaI - cosThetaT) / (eta * cosThetaI + cosThetaT), 2.0f);
    float Rp = pow((cosThetaI - eta * cosThetaT) / (cosThetaI + eta * cosThetaT), 2.0f);
    
    return float2(Rs, Rp);
}

// Function to Calculate Angle-Dependent Phase Shift
inline float PhaseShiftAngleDependent(float n, float d, float wavelengthM, float3 N, float3 L)
{
    // Calculate the angle of incidence
    float cosTheta = saturate(dot(N, L));
    
    // Adjust path length based on angle
    float effectivePath = d / cosTheta;
    
    // Calculate phase shift
    return 2.0f * 3.14159265359f * n * effectivePath / max(EPSILON, mToUm(wavelengthM)); // Convert wavelength to micrometers
}
inline float3 PhaseShiftAngleDependent(float3 n, float3 d, float3 wavelengthM, float3 N, float3 L)
{
    // Calculate the angle of incidence
    float cosTheta = saturate(dot(N, L));
    
    // Adjust path length based on angle
    float3 effectivePath = d / cosTheta;
    
    // Calculate phase shift
    return 2.0f * 3.14159265359f * n * effectivePath / max(EPSILON3, mToUm(wavelengthM)); // Convert wavelength to micrometers
}


inline void ThinFilmWithAngleDependentPhase(FilmLayer layers[MAX_GRATING_LAYERS], int numLayers,
    float3 wavelengthM, float3 I, float3 L, float3 N, inout float3 finalTransmission, inout float3 finalReflection)
{
    float3 cumulativeTransmission = float3(1.0f, 1.0f, 1.0f);
    float3 cumulativeReflection = float3(0.0f, 0.0f, 0.0f);
    
    float3 totalPhase = float3(0.0f, 0.0f, 0.0f);
    
    for (int i = 0; i < numLayers; i++)
    {
        // Calculate refractive index for the current layer
        float3 n = RefractiveIndexFromCoefficients(wavelengthM, layers[i].coefficients);
        
        // Calculate angle-dependent phase shift for each channel
        float3 phase = PhaseShiftAngleDependent(n, layers[i].thicknessM, wavelengthM, N, L);
        
        // Accumulate total phase
        totalPhase += phase;
        
        // Calculate Fresnel Reflectance for s and p polarizations
        float2 R_polarized = FresnelPolarized(n, I, L);
        
        // Average reflectance for unpolarized light
        float3 R = float3(R_polarized.x, R_polarized.x, R_polarized.x);
        float3 Rp = float3(R_polarized.y, R_polarized.y, R_polarized.y);
        float3 R_avg = (R + Rp) * 0.5f;
        
        // Transmission is complement of reflection
        float3 T = 1.0f - R_avg;
        
        // Ensure energy conservation by adjusting R and T
        R_avg = R_avg / max(R_avg + T, float3(1.0f, 1.0f, 1.0f));
        T = 1.0f - R_avg;
        
        // Incorporate angle-dependent phase into transmission (interference)
        float3 interferenceFactor = cos(totalPhase);
        cumulativeReflection += cumulativeTransmission * R_avg * interferenceFactor;
        cumulativeTransmission *= T * (1.0f + interferenceFactor);
    }
    
    // Combine reflection and transmission
    finalTransmission = cumulativeTransmission;
    finalReflection = cumulativeReflection;
    
    // Ensure that the sum does not exceed 1.0
    finalTransmission = saturate(finalTransmission);
    finalReflection = saturate(finalReflection);
    
}
// Function to Simulate Thin Films with Angle-Dependent Phase Shifts
inline float3 ThinFilmWithAngleDependentPhase(FilmLayer layers[MAX_GRATING_LAYERS], int numLayers,
    float3 wavelengthM, float3 I, float3 L, float3 N)
{
    float3 finalTransmission, finalReflection;
    ThinFilmWithAngleDependentPhase(layers, numLayers, wavelengthM, I, L, N, finalTransmission, finalReflection);
    
    // Combine reflection and transmission with energy conservation
    float3 finalColor = finalTransmission + finalReflection;
    
    return finalColor;
}

// Function to Simulate Subsurface Scattering (SSS)
inline float3 SimulateSSS(float3 diffuseColor, float3 sssColor, float sssStrength, float3 N, float3 V, float3 L)
{
    // Calculate the halfway vector
    float3 H = normalize(V + L);
    
    // Simple Lambertian diffuse
    float diffuse = saturate(dot(N, L));
    
    // SSS factor based on angles
    float sssFactor = sssStrength * (1.0f - dot(N, H));
    
    // Combine diffuse and SSS colors
    float3 finalColor = diffuseColor * diffuse + sssColor * sssFactor;
    
    return finalColor;
}

// Function to Adjust Reflectance and Transmittance for Energy Conservation
inline float3 AdjustReflectance(float3 R, float3 T)
{
    // Clamp the sum of R and T to 1.0 to ensure energy conservation
    float3 sum = R + T;
    return R / max(sum, float3(1.0f, 1.0f, 1.0f));
}

// Function to Generate a Sinusoidal Diffraction Grating
inline float GratingPattern(float2 uv, float period, float orientation)
{
    // Rotate UV coordinates based on orientation
    float2 rotatedUV = float2(
        dot(uv, float2(cos(orientation), -sin(orientation))),
        dot(uv, float2(sin(orientation), cos(orientation)))
    );
    
    // Generate sinusoidal pattern
    float pattern = sin(2.0f * 3.14159265359f * rotatedUV.x / period);
    
    // Normalize pattern to [0, 1]
    return (pattern + 1.0f) * 0.5f;
}

// Function to Apply Chromatic Aberration to UV Coordinates
inline float2 ApplyChromaticAberration(float3 viewPos, float3 pixel, float2 uv, float wavelengthM, float strength, float centerWavelengthNM = 550.0)
{
    // Calculate shift direction based on view direction and normal
    float3 viewDir = normalize(viewPos - pixel);
    float2 shiftDirection = float2(viewDir.x, viewDir.y);
    
    // Calculate shift magnitude based on wavelength
    float shiftMagnitude = (wavelengthM - nmToM(centerWavelengthNM)) * strength; // Reference wavelength = 550nm
    
    // Apply shift
    return uv + shiftDirection * shiftMagnitude;
}

// Function to Apply Chromatic Aberration to Color
inline float3 ApplyChromaticAberrationToColor(float3 viewPos, float3 pixel, float3 color, float2 uv, float3 wavelengthM, float strength)
{
    // Apply chromatic aberration to UV coordinates
    float2 uvR = ApplyChromaticAberration(viewPos, pixel, uv, wavelengthM.x, strength);
    float2 uvG = ApplyChromaticAberration(viewPos, pixel, uv, wavelengthM.y, strength);
    float2 uvB = ApplyChromaticAberration(viewPos, pixel, uv, wavelengthM.z, strength);
    
    // Sample environment map with shifted UVs for each channel
    float3 envColorR = skylineMap.Sample(sampleTypeMirror, uvR).rgb;
    float3 envColorG = skylineMap.Sample(sampleTypeMirror, uvG).rgb;
    float3 envColorB = skylineMap.Sample(sampleTypeMirror, uvB).rgb;
    
    float3 diffuseR = diffuse2D(diffuseMap, uvR).rgb;
    float3 diffuseG = diffuse2D(diffuseMap, uvG).rgb;
    float3 diffuseB = diffuse2D(diffuseMap, uvB).rgb;
    // Combine sampled colors
    float3 chromaticColor = lerp(float3(envColorR.r, envColorG.g, envColorB.b), float3(diffuseR.r, diffuseG.g, diffuseB.b), .5);
    
    // Blend with original color
    return lerp(color, chromaticColor, 0.05f); // Adjust blend factor as needed
}

// ----------------------------------
// 4. Utility Functions
// ----------------------------------

// Function to Adjust Grating Parameters Based on User Inputs
inline void AdjustGratingParameters(
    GratingLayer gratingLayers[MAX_GRATING_LAYERS],
    int numGratings, float2 uv, float2 mousePos,
    float3 userColor, float interactionStrength)
{
    [unroll(MAX_GRATING_LAYERS)]
    for (int i = 0; i < MAX_GRATING_LAYERS; i++)
    {
        if (i > numGratings - 1)
            break;
        // Example: Shift orientation based on mouse position
        gratingLayers[i].orientation += (mousePos.x - 0.5f) * interactionStrength;
        
        // Example: Modify strength based on distance from mouse position
        float d = distance(uv, mousePos);
        gratingLayers[i].strength += (1.0f - d) * interactionStrength * 1.1f;
        
        // Example: Tint hologram with user-selected color
        // (This could be applied in the diffraction pattern modulation)
    }
}

// Function to Animate Grating Orientation Over Time
inline float AnimateOrientation(float time, float baseOrientation, float speed)
{
    return baseOrientation + sin(time * speed) * 0.1f; // Adjust amplitude as needed
}

// Function to Animate Grating Period Over Time
inline float AnimatePeriod(float time, float basePeriod, float speed)
{
    return basePeriod + sin(time * speed) * 0.02f; // Adjust amplitude as needed
}


inline float GratingPatternProcedural(float2 uv, float time, float period, float orientation, float3 wavelengthM)
{
    // Introduce dynamic perturbations using procedural noise
    float noise = noisePerlin11(uv * 5.0f + float2(time * 0.1f, time * 0.1f)); // Animate noise over time
    float perturbedPattern = GratingPattern(uv, period, orientation) + (noise - 0.5f) * 0.1f; // Small perturbation
    
    // Normalize pattern to [0, 1]
    perturbedPattern = saturate((perturbedPattern + 1.0f) * 0.5f);
    
    return perturbedPattern;
}

inline float GratingPatternAnimated(float time, float2 uv, float basePeriod, float baseOrientation, float strength, float phaseOffset, float3 wavelengthM, float speed)
{
    // Animate grating parameters
    float animatedOrientation = AnimateOrientation(time, baseOrientation, speed);
    float animatedPeriod = AnimatePeriod(time, basePeriod, speed);
    
    // Generate procedurally varying grating pattern with animated parameters
    float pattern = GratingPatternProcedural(uv, time, animatedPeriod, animatedOrientation, wavelengthM);
    
    // Apply phase offset with time-based modulation
    float dynamicPhase = phaseOffset + sin(time * speed) * 3.14159265359f / 4.0f; // Example modulation
    pattern = sin(2.0f * 3.14159265359f * pattern + dynamicPhase);
    
    // Normalize pattern to [0, 1]
    pattern = saturate((pattern + 1.0f) * 0.5f);
    
    return pattern * strength;
}
// Function to Apply Procedural Grating Pattern with Animation



// Function to Apply Animated Grating Pattern
inline float GratingPatternAnimated(float2 uv, float time, float basePeriod, float baseOrientation,
 float strength, float phaseOffset, float3 wavelengthM, float speed)
{
    // Animate grating parameters
    float animatedOrientation = AnimateOrientation(time, baseOrientation, speed);
    float animatedPeriod = AnimatePeriod(time, basePeriod, speed);
    
    // Generate grating pattern with animated parameters
    float pattern = GratingPatternProcedural(uv, time, animatedPeriod, animatedOrientation, wavelengthM);
    
    // Apply phase offset with time-based modulation
    float dynamicPhase = phaseOffset + sin(time * speed) * 3.14159265359f / 4.0f; // Example modulation
    pattern = sin(2.0f * 3.14159265359f * pattern + dynamicPhase);
    
    // Normalize pattern to [0, 1]
    pattern = saturate((pattern + 1.0f) * 0.5f);
    
    return pattern * strength;
}


// Function to Apply Animated Diffraction Grating
inline float3 DiffractionGratingAnimated(float time, float2 uv, float3 color, float3 wavelengthM, GratingLayer gratingLayers[MAX_GRATING_LAYERS], int numGratings, float speed)
{
    float3 modulatedColor = color;
    
    [unroll(MAX_GRATING_LAYERS)]
    for (int i = 0; i < MAX_GRATING_LAYERS; i++)
    {
        if (i > numGratings - 1)
            break;
        GratingLayer layer = gratingLayers[i];
        
        // Generate animated grating pattern
        float pattern = GratingPatternAnimated(uv, time, layer.period, layer.orientation,
            layer.strength, layer.phaseOffset, wavelengthM, speed);
        
        // Modulate color based on grating pattern and diffraction strength
        modulatedColor = modulatedColor * (1.0f - layer.strength) + pattern * layer.strength;
    }
    
    return modulatedColor;
}

// Function to Calculate Dynamic Phase Offset
inline float CalculateDynamicPhaseOffset(float time, float basePhase, float frequency, float speed)
{
    return basePhase + sin(time * speed) * frequency;
}

inline float EnhancedGratingPatternWithPhase(float2 uv, float time, float period, float orientation, float phaseOffset, float3 wavelengthM)
{
    // Generate base grating pattern
    float basePattern = GratingPattern(uv, period, orientation);
    
    // Add procedural noise for complexity
    float noise = noisePerlin11(uv * 5.0f); // Scale UV for noise frequency
    float perturbedPattern = basePattern + (noise - 0.5f) * 0.1f; // Small perturbation
    
    // Apply phase offset
    perturbedPattern = sin(2.0f * 3.14159265359f * perturbedPattern + phaseOffset);
    
    // Normalize pattern to [0, 1]
    perturbedPattern = saturate((perturbedPattern + 1.0f) * 0.5f);
    
    return perturbedPattern;
}

// Update Diffraction Pattern with Dynamic Phase
inline float EnhancedGratingPatternWithDynamicPhase(float2 uv, float time, float period, float orientation, float basePhase, float frequency, float speed, float3 wavelengthM)
{
    // Calculate dynamic phase offset
    float dynamicPhase = CalculateDynamicPhaseOffset(time, basePhase, frequency, speed);
    
    // Generate grating pattern with dynamic phase
    return EnhancedGratingPatternWithPhase(uv, time, period, orientation, dynamicPhase, wavelengthM);
}

// Updated ApplyMultipleDiffractionOrders with Phase Control
inline float3 ApplyMultipleDiffractionOrdersWithPhase(float2 uv, float time, float3 color, float3 wavelengthM, GratingLayer gratingLayers[MAX_GRATING_LAYERS], int numGratings, DiffractionOrder orders[MAX_GRATING_LAYERS], int numOrders)
{
    float3 modulatedColor = color;
    
    [unroll(MAX_GRATING_LAYERS)]
    for (int i = 0; i < MAX_GRATING_LAYERS; i++)
    {
        if (i > numGratings - 1)
            break;
        GratingLayer layer = gratingLayers[i];
        
        [unroll(MAX_GRATING_LAYERS)]
        for (int j = 0; j < MAX_GRATING_LAYERS; j++)
        {
            if (j > numOrders - 1)
                break;
            DiffractionOrder order = orders[j];
            
            // Calculate effective wavelength for the current order
            float3 effectiveWavelength = wavelengthM * order.wavelengthFactor;
            
            // Generate enhanced grating pattern with procedural noise and dynamic phase
            float pattern = EnhancedGratingPatternWithDynamicPhase(uv, time, layer.period * order.order, layer.orientation, layer.phaseOffset, 1.0f, 2.0f, effectiveWavelength);
            
            // Modulate color based on grating pattern, order strength, and diffraction strength
            modulatedColor += pattern * layer.strength * order.strength;
        }
    }
    
    return modulatedColor;
}

// Cook-Torrance BRDF Implementation (Simplified)
inline float3 CookTorranceBRDF(float3 N, float3 V, float3 L, float3 albedo, float roughness)
{
    float3 H = normalize(V + L);
    float NdotH = saturate(dot(N, H));
    float NdotV = saturate(dot(N, V));
    float NdotL = saturate(dot(N, L));
    
    // Normal Distribution Function (NDF) - GGX
    float a = roughness * roughness;
    float a2 = a * a;
    float denom = (NdotH * NdotH) * (a2 - 1.0f) + 1.0f;
    float D = a2 / (3.14159265359f * denom * denom);
    
    // Geometry Function (Schlick-GGX)
    float k = (roughness + 1.0f) * (roughness + 1.0f) / 8.0f;
    float G_V = NdotV / (NdotV * (1.0f - k) + k);
    float G_L = NdotL / (NdotL * (1.0f - k) + k);
    float G = G_V * G_L;
    
    // Fresnel Term (Schlick's Approximation)
    float3 F0 = float3(0.04f, 0.04f, 0.04f); // Base reflectivity for dielectrics
    float3 F = F0 + (1.0f - F0) * pow(1.0f - dot(H, V), 5.0f);
    
    // Cook-Torrance BRDF
    float3 specular = (D * G * F) / (4.0f * NdotV * NdotL + EPSILON);
    
    // Lambertian Diffuse
    float3 diffuse = albedo / 3.14159265359f;
    
    return diffuse + specular;
}

inline float AdjustTransparency(float fragmentDepth, float sceneDepth, float transparencyFactor)
{
    return lerp(transparencyFactor, transparencyFactor * 0.5, step(sceneDepth, fragmentDepth));
}

inline float3 CalculateReflection(float3 viewDir, float3 normal)
{
    return reflect(-viewDir, normal);
}

// Function to Calculate Refraction Vector
inline float3 CalculateRefraction(float3 viewDir, float3 normal, float3 eta)
{
    return float3(
            refract(-viewDir, normal, eta.x).x,
            refract(-viewDir, normal, eta.y).y,
            refract(-viewDir, normal, eta.z).z);
}




// Function to compute Sobel magnitude for single-channel textures (Depth Map)
float Sobel1(Texture2D<float> depthMap, float2 inputUV, int radius, bool invertDepth, bool useProjectedDepth)
{
    float gx = 0.0;
    float gy = 0.0;
    
    // Define Sobel Kernels for Depth (Single Channel)
    float3 GxDepth[3] =
    {
        float3(-1, 0, 1),
        float3(-2, 0, 2),
        float3(-1, 0, 1)
    };
    
    float3 GyDepth[3] =
    {
        float3(-1, -2, -1),
        float3(0, 0, 0),
        float3(1, 2, 1)
    };
    
    float2 oosz = GetOosz(depthMap);
    float2 radiusOosz = float(radius) * oosz;
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 offset = float2(x, y) * radiusOosz;
            float v = depth2D(depthMap, inputUV + offset, invertDepth, useProjectedDepth);
            gx += v * GxDepth[y + 1].x;
            gy += v * GyDepth[y + 1].x;
        }
    }
    float magnitude = sqrt(gx * gx + gy * gy);
    return saturate(magnitude); // Clamp between 0 and 1
}

// Function to compute Sobel magnitude for multi-channel textures (Diffuse Map)
float Sobel4(Texture2D<float4> diffuseMap, float2 inputUV, int radius)
{
    float3 gx = float3(0, 0, 0);
    float3 gy = float3(0, 0, 0);
    
    // Define Sobel Kernels for RGB (Diffuse and Normal Maps)
    float3 GxRGB[3] =
    {
        float3(-1, 0, 1),
        float3(-2, 0, 2),
        float3(-1, 0, 1)
    };
    
    float3 GyRGB[3] =
    {
        float3(-1, -2, -1),
        float3(0, 0, 0),
        float3(1, 2, 1)
    };
    
    float2 oosz = GetOosz(diffuseMap);
    float2 radiusOosz = float(radius) * oosz;
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 offset = float2(x, y) * radiusOosz;
            float3 diffuse = diffuse2D(diffuseMap, inputUV + offset).rgb;
            gx += diffuse * GxRGB[y + 1].x;
            gy += diffuse * GyRGB[y + 1].x;
        }
    }
        
    // Compute magnitude for each channel
    float magR = sqrt(gx.r * gx.r + gy.r * gy.r);
    float magG = sqrt(gx.g * gx.g + gy.g * gy.g);
    float magB = sqrt(gx.b * gx.b + gy.b * gy.b);
        
    // Average the magnitudes across channels
    float averageMagnitude = (magR + magG + magB) / 3.0;
    return saturate(averageMagnitude); // Clamp between 0 and 1
}

// Function to compute Sobel magnitude for multi-channel textures (Normal Map)
float Sobel3(Texture2D<float3> normalMap, float2 inputUV, int radius, bool invertDepth, bool useProjectedDepth)
{
    float3 gx = float3(0, 0, 0);
    float3 gy = float3(0, 0, 0);
    
    // Define Sobel Kernels for RGB (Diffuse and Normal Maps)
    float3 GxRGB[3] =
    {
        float3(-1, 0, 1),
        float3(-2, 0, 2),
        float3(-1, 0, 1)
    };
    
    float3 GyRGB[3] =
    {
        float3(-1, -2, -1),
        float3(0, 0, 0),
        float3(1, 2, 1)
    };
    
    float2 oosz = GetOosz(normalMap);
    float2 radiusOosz = float(radius) * oosz;
    
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 offset = float2(x, y) * radiusOosz;
            float3 normal = normal2DPoint11W(normalMap, inputUV + offset, false);
            gx += normal * GxRGB[y + 1].x;
            gy += normal * GyRGB[y + 1].x;
        }
    }
    // Compute magnitude for each channel
    float magR = sqrt(gx.r * gx.r + gy.r * gy.r);
    float magG = sqrt(gx.g * gx.g + gy.g * gy.g);
    float magB = sqrt(gx.b * gx.b + gy.b * gy.b);
        
    // Average the magnitudes across channels
    float averageMagnitude = (magR + magG + magB) / 3.0;
    return saturate(averageMagnitude); // Clamp between 0 and 1
}



float3 Sobel2(Texture2D<float4> rtMap, float2 inputUV, int radius)
{
    float3 gx = float3(0, 0, 0);
    float3 gy = float3(0, 0, 0);

    // Sobel kernels for x and y directions
    const float3 GxRGB[3] =
    {
        float3(-1, 0, 1),
        float3(-2, 0, 2),
        float3(-1, 0, 1)
    };

    const float3 GyRGB[3] =
    {
        float3(-1, -2, -1),
        float3(0, 0, 0),
        float3(1, 2, 1)
    };

    // Get the texture's resolution inverse for proper scaling
    float2 oosz = GetOosz(rtMap);
    float2 radiusOosz = float(radius) * oosz;
    // Apply the Sobel filter by iterating through the kernel
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 offset = float2(x, y) * radiusOosz;

            // Fetch texture color and remap to [-1, 1]
            float3 uvColor = diffuse2D(rtMap, inputUV + offset).xyz;

            // Apply Sobel kernel weights
            gx += uvColor * GxRGB[y + 1].x;
            gy += uvColor * GyRGB[y + 1].x;
        }
    }

    // Calculate magnitude for RGB channels
    float magR = sqrt(gx.r * gx.r + gy.r * gy.r);
    float magG = sqrt(gx.g * gx.g + gy.g * gy.g);
    float magB = sqrt(gx.b * gx.b + gy.b * gy.b);

    // Combine results into a single value
    return float3(magR, magG, magB);
}
// Function to categorize variation levels based on gradient magnitudes
float3 CategorizeVariation(float3 gradients)
{
    float depthGradient = gradients.x;
    float diffuseGradient = gradients.y;
    float normalGradient = gradients.z;
    
    // Define thresholds for each texture type
    // These can be adjusted based on specific needs
    // Depth Map Thresholds
    float depthThreshold1 = 0.1;
    float depthThreshold2 = 0.8;
    
    // Diffuse Map Thresholds
    float diffuseThreshold1 = 0.1;
    float diffuseThreshold2 = 0.8;
    
    // Normal Map Thresholds
    float normalThreshold1 = 0.1;
    float normalThreshold2 = 1;
    
    // Categorize Depth Variation
    float depthLevel = (step(depthThreshold1, depthGradient) +
                        step(depthThreshold2, depthGradient));
    depthLevel = clamp(depthLevel, 0.0, 2.0);
    
    // Categorize Diffuse Variation
    float diffuseLevel = (step(diffuseThreshold1, diffuseGradient) +
                          step(diffuseThreshold2, diffuseGradient));
    diffuseLevel = clamp(diffuseLevel, 0.0, 2.0);
    
    // Categorize Normal Variation
    float normalLevel = (step(normalThreshold1, normalGradient) +
                         step(normalThreshold2, normalGradient));
    normalLevel = clamp(normalLevel, 0.0, 2.0);
    
    return float3(depthLevel, diffuseLevel, normalLevel);
}

// Main Function to Compute Variation Levels
float3 DiversityDepthDiffuseNormal(
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    Texture2D<float3> normalMap,
    float2 inputUV,
    bool invertDepth, bool useProjectedDepth
)
{
    // Check if inputUV is within [0,1] range
    // If not, return 0 variation for all textures
    bool isOutOfBounds = (inputUV.x < 0.1 || inputUV.x > 0.9 ||
                          inputUV.y < 0.1 || inputUV.y > 0.9);
    
    if (isOutOfBounds)
    {
        return ZERO3;
    }
    
    // Compute Gradient Magnitudes
    float depthGradient = Sobel1(depthMap, inputUV, 20, invertDepth, useProjectedDepth);
    float diffuseGradient = Sobel4(diffuseMap, inputUV, 20);
    float normalGradient = Sobel3(normalMap, inputUV, 20, invertDepth, useProjectedDepth);
    
    float3 gradients = float3(depthGradient, diffuseGradient, normalGradient);
    
    // Categorize Variation Levels
    float3 variationLevels = CategorizeVariation(gradients);
    
    return variationLevels;
}
float3 RenderLayers(int filmType, float3 viewPos, float3 pixel, float2 inputUV, float inputDepth, float time, float3 wavelengthsM, float3 viewDir, float3 lightDir, float3 normal,
        float3 userColor, float2 userMousePos, float interactionStrength, float3 nSurrounding,
        bool invertDepth, bool useProjectedDepth, MaterialSellmeier mat, float sssStrength)
{
    
    // Define Film Layers Based on Film Type
    FilmLayer filmLayers[MAX_GRATING_LAYERS] = (FilmLayer[MAX_GRATING_LAYERS]) 0; // Maximum 4 layers for holographic surfaces
    
    int numLayers = 0;
    
    if (filmType == FILM_TYPE_THICK_GLASS)
    {
        // Thick Glass: Single Layer (BK7 Glass)
        numLayers = 1;
        filmLayers[0] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_THICK_GLASS],
             ONE3 * 0.005f, float3(0.0f, 0.0f, 0.0f));
    }
    else if (filmType == FILM_TYPE_OILY_GLASS)
    {
        // Oily Glass: Two Layers (BK7 Glass + Oily Film)
        numLayers = 2;
        filmLayers[0] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_THICK_GLASS], ONE3 * 0.005f, float3(0.0f, 0.0f, 0.0f));
        filmLayers[1] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_OILY_GLASS], ONE3 * 0.0002f, float3(0.0f, 0.0f, 0.0f)); // 200 nm oil film
    }
    else if (filmType == FILM_TYPE_THICK_OIL)
    {
        // Thick Oil: Single Thick Oil Layer
        numLayers = 1;
        filmLayers[0] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_THICK_OIL], ONE3 * 0.01f, float3(0.05f, 0.05f, 0.05f)); // 10 mm oil layer with absorption
    }
    else if (filmType == FILM_TYPE_HOLOGRAPHIC)
    {
        // Holographic Surface: Multiple Layers (TiO2 and MgF2 Alternating)
        numLayers = 4;
        filmLayers[0] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_HOLOGRAPHIC], ct01 * ONE3 * 0.00175f, float3(0.2f, 0.0f, 0.0f)); // TiO2, 175 nm
        filmLayers[1] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_HOLOGRAPHIC], ONE3 * 0.000275f, float3(0.0f, 0.2f, 0.0f)); // MgF2, 175 nm
        filmLayers[2] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_HOLOGRAPHIC], ct01 * ONE3 * 0.0175f, float3(0.0f, 0.2f, 0.0f)); // TiO2, 175 nm
        filmLayers[3] = CreateFilmLayer(PreFabSellmeierCoefficients[FILM_TYPE_HOLOGRAPHIC], ONE3 * 0.000575f, float3(0.0f, 0.0f, 0.0f)); // MgF2, 175 nm
    }
    
    // Define Diffraction Orders
    DiffractionOrder diffractionOrders[MAX_GRATING_LAYERS] = (DiffractionOrder[MAX_GRATING_LAYERS]) 0;
    
    float diffraction_2_1 = ct01 * .05 + .05;
    float diffraction_2_2 = ct01 * .05 + .05;
    float diffraction_3_1 = ct01 * .25 + .05;
    float diffraction_3_2 = ct01 * .25 + .05;

    diffractionOrders[0] = CreateDiffractionOrder(1, 1.0f, 1.0f); // First-order
    diffractionOrders[1] = CreateDiffractionOrder(2, diffraction_2_1, diffraction_2_2); // Second-order with slight wavelength shift
    diffractionOrders[2] = CreateDiffractionOrder(3, diffraction_3_1, diffraction_3_2); // Third-order with more wavelength shift
    
    
    int numOrders = 3;
    
    // Define Diffraction Grating Layers with Phase Offsets
    GratingLayer gratingLayers[MAX_GRATING_LAYERS] = (GratingLayer[MAX_GRATING_LAYERS]) 0;
    gratingLayers[0] = CreateGratingLayer(0.1f, 0.0f, 0.3f, 0.0f); // Layer 1
    gratingLayers[1] = CreateGratingLayer(0.05f, 3.14159265359f / 3.0f, 0.2f, 1.57079632679f); // Layer 2
    gratingLayers[2] = CreateGratingLayer(0.025f, 3.14159265359f / 6.0f, 0.1f, 3.14159265359f / 2.0f); // Layer 3
    
    int numGratings = 3;
    
    float3 finalTransmission, finalReflection;
    ThinFilmWithAngleDependentPhase(filmLayers, numLayers, wavelengthsM, viewDir, lightDir, normal, finalTransmission, finalReflection);
    
    // Combine reflection and transmission with energy conservation
    float3 transmission = finalTransmission + finalReflection;
    

    // Apply Multiple Diffraction Orders with Phase Control
    float3 diffractionColor = ApplyMultipleDiffractionOrdersWithPhase(
        inputUV, time, finalTransmission, wavelengthsM, gratingLayers,
        numGratings, diffractionOrders, numOrders) +
        .05 * finalReflection * diffuse2D(skylineMap, inputUV.yx).xyz;
    
    float3 albedo = userColor;
    float3 sssColor = rainbowColor(inputUV) * (1 - distance(inputUV, userMousePos));
    
    float roughness = mat.roughness;
    
    // Adjust grating layers based on user input
    AdjustGratingParameters(gratingLayers, numGratings, inputUV,
        userMousePos, userColor, interactionStrength);
    
    // Calculate PBR Lighting
    float3 pbrColor = CookTorranceBRDF(normal, viewDir, lightDir, albedo, roughness);
    
    // Apply Transmission and Diffraction
    float3 finalColor = pbrColor * diffractionColor;
    
    // Simulate Subsurface Scattering
    finalColor += SimulateSSS(albedo, sssColor, sssStrength, normal, viewDir, lightDir) * diffractionColor;
    
    // Apply Multi-Layered Diffraction Grating with Procedural Patterns and Temporal Animation
    if (filmType == FILM_TYPE_HOLOGRAPHIC)
    {
        // Define multiple grating layers with procedural variation and animation
        GratingLayer gratingLayersProc[MAX_GRATING_LAYERS] = (GratingLayer[MAX_GRATING_LAYERS]) 0;
        gratingLayersProc[0] = CreateGratingLayer(0.1f, 0.0f, 0.3f, 0.0f); // Layer 1
        gratingLayersProc[1] = CreateGratingLayer(0.05f, 3.14159265359f / 3.0f, 0.2f, 1.57079632679f); // Layer 2
        gratingLayersProc[2] = CreateGratingLayer(0.025f, 3.14159265359f / 6.0f, 0.1f, 3.14159265359f / 2.0f); // Layer 3
        
        int numGratingsProc = 3;
        
        // Define Diffraction Orders
        DiffractionOrder diffractionOrdersProc[MAX_GRATING_LAYERS] = (DiffractionOrder[MAX_GRATING_LAYERS]) 0;
    
        diffractionOrdersProc[0] = CreateDiffractionOrder(1, 1.0f, 1.0f); // First-order
        diffractionOrdersProc[1] = CreateDiffractionOrder(2, 0.5f, 0.95f); // Second-order
        diffractionOrdersProc[2] = CreateDiffractionOrder(3, 0.3f, 0.9f); // Third-order
        
        
        int numOrdersProc = 3;
        
        // Apply multiple diffraction orders with phase control
        diffractionColor = ApplyMultipleDiffractionOrdersWithPhase(
            inputUV, time, transmission, wavelengthsM, gratingLayersProc,
            numGratingsProc, diffractionOrdersProc, numOrdersProc);
        
        // Apply animated diffraction grating with procedural patterns
        float4 proceduralDiffraction = float4(DiffractionGratingAnimated(
            time, inputUV, finalColor, wavelengthsM, gratingLayersProc, numGratingsProc, 1.0f), 1.0);

        
        // Apply chromatic aberration to enhance color dispersion
        proceduralDiffraction = float4(ApplyChromaticAberrationToColor(
            viewPos, pixel, proceduralDiffraction.rgb, inputUV, wavelengthsM, 0.005f), 1.0); // Example strength
        
        // Apply depth-based transparency
        float sceneDepth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
        float fragmentDepth = inputDepth; // Assuming input.depth is provided
        float transparency = AdjustTransparency(fragmentDepth, sceneDepth, 1.0f); // Full transparency initially
        proceduralDiffraction.a *= transparency; // Adjust alpha based on depth
        
        // Combine with existing color
        finalColor = proceduralDiffraction.rgb;
    }
    
    // Incorporate Environmental Reflections
    float3 reflectionVector = CalculateReflection(viewDir, normal);
    float3 reflectionColor = .05 * diffuse2D(skylineMap, inputUV + reflectionVector.xy).rgb;
    
    // Incorporate Environmental Refractions
    float3 eta = 1.0f / nSurrounding; // Assuming air outside (n=1.0)
    float3 refractionVector = CalculateRefraction(viewDir, normal, eta);
    float3 refractionColor = .05 * diffuse2D(skylineMap, inputUV + refractionVector.xy).rgb;
    
    // Blend Reflections and Refractions with Final Color
    float3 envColor = reflectionColor * 0.5f + refractionColor * 0.5f; // Adjust weights as needed
    finalColor = lerp(finalColor, envColor, 0.1f); // Blend based on desired influence
    
    // Incorporate Interactive Chromatic Aberration
    finalColor = ApplyChromaticAberrationToColor(viewPos, pixel, finalColor, inputUV, wavelengthsM, 0.005f * FresnelMix); // Example strength
    
    // Ensure energy conservation
    finalColor = saturate(finalColor);
    
    // Assign to Output with Alpha
    return finalColor;
}

inline float DistributionGGX(float3 N, float3 H, float alpha)
{
    float NdotH = saturate(dot(N, H));
    float alpha2 = alpha * alpha;
    
    // Calculate the denominator of the GGX NDF
    float denom = (NdotH * NdotH) * (alpha2 - 1.0) + 1.0;
    denom = PI * denom * denom;
    
    return alpha2 / denom;
}

MaterialProperties MaterialPropertiesFromMaterialSellmeier(MaterialSellmeier mat)
{
    MaterialProperties material = (MaterialProperties) 0;
    material.coeff.B = mat.coeff.OE1.O.B;
    material.coeff.B = mat.coeff.OE1.O.C;
    material.k = mat.nSurrounding;
    material.thicknessM = mat.thicknessM;
    material.absorptionM = mat.absorptionCoefficient;
    material.wavelengthsNM = RGBToWavelengthsNM(mat.albedo);
    material.transmissionCoefficient = mat.metallic;
    return material;
}

float3 MicrofacetBRDF1(
    MaterialSellmeier mat,
    float2 inputUV, float time,
    float3 materialSpecularColor,
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float3 outsideRefractiveIndex = ONE3,
    float3 materialRefractiveIndex = float3(1.3, 1.3, 1.3),
    float thicknessNM = 20.0,
    float3 dispersionCoefficient = float3(0.005, 0.006, 0.007),
    float3 absorptionIncomingM = ZERO3,
    float roughnessX = 0.1,
    float roughnessY = 0.001,
    int dispersionIndex = 0,
    float3 diffuseColor = float3(0.1f, 0.2f, 0.3f),
    float3 sssColor = float3(0.05f, 0.1f, 0.15f),
    float sssStrength = 0.5f
)
{
 
    // Define Anisotropic Roughness
    AnisotropicRoughness roughness = (AnisotropicRoughness) 0;
    roughness.alphaX = roughnessX;
    roughness.alphaY = roughnessY;


    float3 H = safeNormalize(viewDir + lightDir);

    float3 roughnessVec = float3(roughness.alphaX, roughness.alphaY, 1);

	// Calculate the microfacet normal
    float3 microfacetNormal = safeNormalize(normal + roughnessVec * H);

	// Calculate the GGX distribution
    float ggxDistribution = DistributionGGX(microfacetNormal, H, roughness.alphaX * roughness.alphaY);
    
    MaterialProperties material = MaterialPropertiesFromMaterialSellmeier(mat);


    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];
    CreateThinFilms(thinFilms);

	// Calculate the Fresnel term
    float3 fresnelTerm = saturate(
        FresnelMicrofacet(
            inputUV, time,
            viewDir,
            lightDir,
            microfacetNormal,
            material,
            roughness,
            thinFilms,
            MAX_GRATING_LAYERS,
            diffuseColor,
            sssColor,
            sssStrength, mat.scatteringCoefficient, mat.absorptionCoefficient, mat.dispersionCoefficientsNm2[dispersionIndex],
            nmToM(thicknessNM)));

	// Calculate the BRDF
    float3 brdf = materialSpecularColor * ggxDistribution * fresnelTerm;

    return brdf;
}

// Define the microfacet-based BRDF function
float3 MicrofacetBRDF2(
    MaterialSellmeier mat,
    float2 inputUV, float time,
    MaterialProperties material,
    AnisotropicRoughness roughness,
    float3 diffuseColor,
    float3 sssColor,
    float sssStrength,
    float3 normal, float3 viewDir, float3 lightDir,
    float3 outsideRefractiveIndex = ONE3,
    float3 materialRefractiveIndex = float3(1.3, 1.3, 1.3),
    float thicknessNM = 20.0,
    float3 dispersionCoefficient = float3(0.005, 0.006, 0.007),
    int dispersionIndex = 0)
{
    float3 H = safeNormalize(viewDir + lightDir);

	// Calculate the microfacet normal
    float3 roughnessVec = float3(roughness.alphaX, roughness.alphaY, 0);

    float3 microfacetNormal = safeNormalize(normal + roughnessVec);

	// Calculate the GGX distribution
    float v = dot(microfacetNormal, roughnessVec);
    if (v > 0)
    {
        v = sqrt(v);
    }
    float ggxDistribution = DistributionGGX(microfacetNormal, H, v);

    int numThinFilms = 6;
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];
    CreateThinFilms(thinFilms);
    
	// Calculate the Fresnel term
    float3 fresnelTerm = saturate(FresnelMicrofacet(inputUV, time, viewDir, lightDir, microfacetNormal, material,
        roughness, thinFilms, numThinFilms, diffuseColor, sssColor, sssStrength, mat.scatteringCoefficient, mat.absorptionCoefficient, mat.dispersionCoefficientsNm2[dispersionIndex], nmToM(thicknessNM)));

	// Calculate the BRDF
    float3 brdf = diffuseColor.rgb * ggxDistribution * fresnelTerm;

    return brdf;
}



float4 LightPixel(float2 texCoord, float3 normal, float3 viewPos, float3 viewDir, float pixelScaled, float3 pixelToSunDir, float sunIntensity, float ambient, bool invertDepth, bool useProjectedDepth)
{
	// Sample the diffuse color
    float4 color = diffuse2D(rtMap1, texCoord);

	// Sample depth
    float depth = depth2D(depthMap, texCoord, invertDepth, useProjectedDepth);

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




float3 MicrofacetBRDF3(float3 albedo, float metallic, float3 normal, float3 viewDir, float3 lightDir, float roughness, float ao = 1.0)
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
    float D = DistributionGGX(normal, halfDir, roughness);
    float3 G = GeometrySmithNVL(normal, viewDir, lightDir,
        CreateAnisotropicRoughness(roughness, roughness));
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
    float3 kD = ONE3 - kS;
	// multiply kD by the inverse metalness such that only non-metals 
	// have diffuse lighting, or a linear blend if partly metal (pure metals have no diffuse light).
    kD *= 1.0 - metallic;

	// Scale light by NdotL
    float3 diffuse = kD * albedo / PI;

	// Combine with ambient occlusion for final output
    return (diffuse + specular) * NdotL;
}


inline float3 colorMap(float v)
{
    return float3(smoothstep(0.0, 0.3, v) - smoothstep(0.7, 1.0, v),
		smoothstep(0.2, 0.5, v) - smoothstep(0.5, 0.8, v),
		smoothstep(0.4, 0.7, v)
	);
}

// Helper function to retrieve hologram data (placeholder for actual implementation)
inline float4 GetHologramDataRT(Texture2D<float4> rtMap, float2 uv)
{
    return rtMap.SampleLevel(sampleTypeMirror, uv, 0);
}

inline HolographicLight CreateHolographicLight(float3 pos, float3 dir, float3 col, float3 waveLen, float inten, float cohLen, float phaseOff, float4x4 lightMatrix, float2 uvScale, float angularSpread)
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

// Method to project a point into the light's local space, useful for texture-based interference or complex patterns
inline float2 ProjectToLightSpace(HolographicLight light, float3 worldPosition)
{
    float4 localPoint = mul(float4(worldPosition - light.position, 1.0), light.lightSpaceMatrix);
    return localPoint.xy * light.textureUVScale;
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

inline float hash11(float p)
{
    p = frac(p * 0.1031);
    p *= p + 33.33;
    p *= p + p;
    return frac(p);
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

    float3 lightRangeMin = float3(0.01, 0.01, 0.01);
    float3 lightRangeMax = float3(0.95, 0.95, 0.75);
    float3 lightRange = lightRangeMax - lightRangeMin;

	// Color and wavelength
    light.color = float3(hash11(seed * 2.1),
		hash11(seed * 2.2),
		hash11(seed * 2.3)
	);
    light.wavelengthNM = lerp(float3(380, 440, 675), float3(750, 675, 380), seeds);

    light.position += lightRange - direction * nmToM(light.wavelengthNM);

	// Intensity and other properties
    light.intensity = dot(nmToM(seeds * 0.652 * light.wavelengthNM), nmToM(light.wavelengthNM));
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
inline void SetupHolographicLights(float3 viewPos, inout LightSource lights[MAX_LIGHT_SOURCES])
{
    float depthRange = f10; // You might want to define this based on your scene's scale
    [loop]
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
			// Here, each light gets a unique seed based on its index, but you could also use any function 
			// of 'i' to make this deterministic across different runs or machines.
        lights[i] = CreateDeterministicLight(i * 0.1 + 3.14159, viewPos);
    }
}


inline void GeneratePhaseAlignedLightSources(Texture2D<float> depthMap, float2 uv, float3 viewPos, inout LightSource lights[MAX_LIGHT_SOURCES], inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    [loop]
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        lights[i] = CreateDeterministicLight(i * 0.1 + PI, viewPos);
    }
}



inline float3 LensFlare(float2 uv, float2 lightPos, float intensity)
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



inline float2 HeatHaze(float2 uv, float time, float intensity)
{
    float noise = noiseFast11(uv * 10.0 + time);
    float2 sc = sincos2(time);
    return uv + 10.0 * noise * intensity * sc;
}


inline float2 FresnelKernel(float2 offset, float3 wavelength, float depth)
{
	// Calculate the squared distance from the sample point to the observation point
    float r2 = dot(offset, offset);

	// Compute the phase shift using the Fresnel approximation
    float3 phase = ONE3 * (PI * r2) / max(wavelength * depth, EPSILON3);

	// Return the complex exponential representing the phase shift
    return sincos2(length(phase)).yx;
}

float3 ApplyDepthOfField(Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float focusDepth, float maxBlur, bool invertDepth, bool useProjectedDepth)
{
    float sceneDepth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);

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

        color += diffuse2D(diffuseMap, uv + offset).rgb;
        totalWeight += 1.0;
    }

    return color / (totalWeight + EPSILON);
}



// Vertex Shader
PS_INPUT VSMain(VS_INPUT input)
{
    PS_INPUT output = (PS_INPUT) 0;
    bool invertDepth = false;
    output.Position = float4(input.Position, depth2D(depthMap, input.Position.xy));
    output.uv = input.uv;
    output.ViewDir = safeNormalize(float3(ViewX, ViewY, ViewZ) - input.Position);
    output.Color = ONE4;
    return output;
}




float3 ApplyDepthOfFieldWithBokeh(Texture2D<float4> diffuseMap, float2 oosz, float2 uv, float focusDepth, float maxBlur, Texture2D<float4> bokehShape, bool invertDepth, bool useProjectedDepth)
{
    float sceneDepth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);

	// Calculate blur amount based on depth difference
    float blurAmount = saturate(abs(sceneDepth - focusDepth) / max(EPSILON, maxBlur));

	// Sample neighboring pixels based on blur amount and bokeh shape
    float3 color = ZERO3;
    int samples = 32; // Increase sample count for smoother bokeh
    float totalWeight = 0.0;

	[loop]
    for (int i = 0; i < samples; i++)
    {
        float angle = float(i) / float(samples) * 6.2831853; // 2*Pi
        float2 offset = blurAmount * float2(cos(angle), sin(angle)) * oosz;

			// Sample the bokeh shape texture
        float bokehValue = diffuse2D(bokehShape, uv + offset).r;

        color += diffuse2D(diffuseMap, uv + offset).rgb * bokehValue;
        totalWeight += bokehValue;
    }

    return color / max(EPSILON, totalWeight);
}


inline float3 ApplyIridescence(float3 normal, float3 viewDir, float scaledTime)
{
    float angle = acos(dot(normal, viewDir));
    float iridescence = sin(angle * 3.0 * scaledTime) * 0.5 + 0.5;
    return lerp(float3(0.0, 0.5, 1.0), float3(1.0, dot(normal, viewDir), 0.5), iridescence);
}
float3 ApplyDynamicIridescence(float2 uv, float3 wavelengthNM, float3 normal, float3 viewDir, float scaledTime, float noiseScale, float noiseStrength)
{
	// Add noise to the iridescence pattern
    float noiseValue = noiseFast11(uv * noiseScale);
    float3 angle = acos(dot(normal, viewDir)) * noiseValue * (nmToM(wavelengthNM) - noiseStrength);

    float3 iridescence = float3(sin(angle.x * 3.0 * scaledTime) * 0.5 + 0.5, sin(angle.y * 3.0 * scaledTime) * 0.5 + 0.5, sin(angle.z * 3.0 * scaledTime) * 0.5 + 0.5);
    return lerp(float3(0.0, 0.5, 1.0), float3(1.0, 0.0, 0.5), iridescence);
}

inline float3 GaussianBlur(Texture2D<float4> diffuseMap, float2 uv, float3 blurRadius, float2 oosz)
{
    float3 color = ZERO3;
    [loop]
    for (int x = -1; x <= 1; x++)
    {
        [loop]
        for (int y = -1; y <= 1; y++)
        {
            float2 offset = float2(x, y) * blurRadius.xy / oosz;
            color += diffuse2D(diffuseMap, uv + offset).rgb;
        }
    }
    return color / 9.0;
}

float3 ApplyAnisotropicBloom(Texture2D<float4> tex, float2 uv, float dist, float threshold, float3 minColor, float3 power, float sigma, float anisotropy)
{
    float2 oosz = GetOosz(tex);
    float3 color = diffuse2D(tex, uv).xyz;
    float3 luminance = RGBToLuminance(color);

    if (CountV3AboveV1(luminance, threshold, EPSILON) > 0)
    {
        float3 blurColor = 0.0;
        float totalWeight = 0.0;

		// Dynamic radius based on sigma
        int radius = int(ceil(3.0 * sigma));

		// Precalculate values
        float sigmaSq2 = 2.0 * sigma * sigma;
        
        [loop]
        for (int y = -radius; y <= radius; y += 2)
        {
            [loop]
            for (int x = -radius; x <= radius; x += 2)
            {
                // Apply anisotropy to the offset
                float2 offset = float2(x * (1.0 + anisotropy), y * (1.0 - anisotropy)) * dist * oosz;
                float weight = gaussian(length(offset), sigma);
                blurColor += diffuse2D(tex, uv + offset).xyz * weight;
                totalWeight += weight;
            }
        }

        blurColor /= max(EPSILON, totalWeight);
        color = lerp(color, max(minColor, blurColor), luminance * power);
    }

    return color;
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
	float3 color,
    bool invertDepth, bool useProjectedDepth
)
{
	// Example: Initialize Gaussian point sources in a circular array
    int totalPoints = MAX_GAUSSIAN_POINTS;

    float2 oosz = GetOosz(depthMap);
    float2 sz = GetSz_1(depthMap);
    [loop]
    for (int i = 0; i < totalPoints; ++i)
    {
        float angle = 2.0 * PI * float(i) / float(totalPoints);
        float s, c;
        sincos(angle, s, c);
        float2 ofs = oosz * float2(radius * c, radius * s);
        float3 pos = float3(uv + ofs, depth2D(depthMap, uv + ofs, invertDepth, useProjectedDepth));
        
        float3 direction = safeNormalize(viewPos - pos);
        float amplitude = 1.0 / float(totalPoints); // Equal amplitude distribution

        gaussianPoints[i] = CreateGaussianPointSource(pos, direction, amplitude, color, beamWidth, gaussianPoints[i]);
    }
    numGaussianPoints = totalPoints;
}


inline float3 photonAngularVelocity(float3 hz, float angularVelocityFactor = 1.0)
{
    return 2.0 * 3.14159 * hz * angularVelocityFactor;
}
inline float3 energyToForce(float3 energy, float3 distance)
{
	// Avoid division by zero by checking if distance is greater than a small threshold
    if (dot(distance, distance) > 1e-6)
    {
        return energy / distance;
    }
    return 0.0;
}
inline float3 modulateEnergy(float3 energy, float time, float3 waveAmplitude)
{
    return energy * (1.0 + waveAmplitude * sin(time * 3.14159 * 2.0));
}

inline float3 Displacement(float3 lightPos, float3 viewPos, float3 pixel,
    float3 wavelengthsNM, float currentPhase, float strength, MaterialSellmeier mat, int diffractionIndex012, bool invertDepth)
{
    float3 normalizedWavelength = saturate(saturate(wavelengthsNM - MIN_WAVELENGTHS) / WAVELENGTH_RANGES);
    
    float3 viewDir = viewDirW(viewPos, pixel);
    float3 normalW = normal2D11W(normalMap, pixel.xy, NormalRadius, false);
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(mat.etaR, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, normalW), cosThetaT);
    
    // Calculate path difference in meters (ensure ComputePathDifferenceM is defined)
    OpticalPathResult opd =
        OpticalPathDifference(
            wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
            DifferenceMPathFromPointThicknessM(viewPos, pixel, mat.thicknessM),
            mat.dispersionCoefficientsNm2[clamp(diffractionIndex012, 0, 2)],
            mat.absorptionCoefficient, cosThetaT);

    // Refractive index (assumed constant for simplicity)
    float3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, true, mat);

    // Calculate phase shift (ensure CalculatePhaseShiftM is defined)
    float3 phaseShiftM = PhaseShiftM(nmToM(wavelengthsNM), opd.opticalMeasurement.PathDifferenceM, refractiveIndex);

    // Calculate total phase
    float3 phase = currentPhase + normalizedWavelength * phaseShiftM;

    // Compute displacement using sine wave for smooth animation
    float3 displacement = sin(phase) * strength * normalizedWavelength;

    // Determine direction based on wavelength
    // Longer wavelengths (red) disperse more to the right in this example
    float3 angle = lerp(float3(-0.2, -0.2, -0.2), float3(0.2, 0.2, 0.2), normalizedWavelength); // Angle in radians

    // Apply directional adjustment
    return displacement * cos(angle);
}



// Define material properties
struct MaterialDispersion
{
    float3 refractiveIndexBase; // Base refractive index for R, G, B
    float3 dispersionCoefficient; // Dispersion coefficients for R, G, B
};

// Function to adjust refractive index based on wavelength
inline float3 AdjustRefractiveIndex(float3 wavelengthNM, MaterialDispersion material, float referenceWavelengthNM = 550.0)
{
	// Simple linear dispersion model: n = n0 + k * (1/λ - 1/λ0)
	// where λ0 is the reference wavelength (e.g., 550 nm for green)

    float3 refractiveIndex = material.refractiveIndexBase +
		material.dispersionCoefficient * (ONE3 / wavelengthNM - ONE3 / referenceWavelengthNM);
    return refractiveIndex;
}


inline float3 ChromaticBlurRadius(float3 wavelengthsNM, float baseRadius, float baseWavelengthNM)
{
    return baseRadius / (wavelengthsNM / baseWavelengthNM);
}

inline float nonlinearPhase(float intensity, float kappa)
{
    return kappa * intensity;
}
// Utility Function: Refract Direction Based on Refractive Index
inline float2 refractDir(float2 incident, float2 normal, float eta)
{
    float cosi = clamp(dot(incident, normal), -1.0, 1.0);
    float cost2 = 1.0 - eta * eta * (1.0 - cosi * cosi);
    if (cost2 < 0.0)
        return float2(0.0, 0.0); // Total internal reflection
    return eta * incident - (eta * cosi + sqrt(cost2)) * normal;
}

inline float2 applyRipple(float2 uv, float depth, float frequency, float amplitude)
{
    float ripple = sin(depth * frequency + amplitude);
    return uv + float2(ripple, ripple);
}
inline float2 Refraction(float2 uv, float2 beamCenter, float beamWaist, float refractionStrength)
{
    float2 centeredUV = uv - beamCenter;
    float2 gradient = safeNormalize(centeredUV) * refractionStrength;
    return gradient;
}

inline float Shadow(float currentDepth, float sampleDepth, float shadowIntensity)
{
    return lerp(0.0, shadowIntensity, step(currentDepth, sampleDepth));
}

// Utility Function: Calculate Shadow Factor Based on Depth
inline float Shadow(Texture2D<float> depthMap, float2 uv, float shadowIntensity, int shadowRadius, bool invertDepth, bool useProjectedDepth)
{
    float currentDepth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float shadowFactor = 0.0;
    float2 oosz = GetOosz(depthMap);
    [loop]
    for (int x = -1; x <= 1; x++)
    {
        [loop]
        for (int y = -1; y <= 1; y++)
        {
            if (x == 0 && y == 0)
                continue;
            float2 sampleUV = uv + float2(x, y) * float(shadowRadius) * oosz;
            float sampleDepth = depth2D(depthMap, sampleUV, invertDepth, useProjectedDepth);
            shadowFactor += lerp(0.0, shadowIntensity, step(sampleDepth, currentDepth));
        }
    }

    return shadowFactor;
}


// Utility Function: Calculate Glow Based on Depth Proximity
inline float Glow(float2 uv, float2 beamCenter, float depth, float glowRadius)
{
    float distance = length(uv - beamCenter);
    return lerp(0.0, smoothstep(glowRadius, glowRadius - 0.05, distance), step(distance, glowRadius));
}

// Pixel Shader: Depth Glow Gaussian Beam
float3 PS_DepthGlowGaussian(Texture2D<float> depthMap,
	float2 uv,
    float3 baseColor,
    float3 glowColor,
	float time,
	float2 beamCenter,
	float beamWaist,
	float glowRadius,
	float glowIntensity,
    bool invertDepth, bool useProjectedDepth
)
{
	// Sample surrounding depth
    float depth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);

	// Calculate glow factor based on depth proximity
    float glowFactor = Glow(uv, beamCenter, depth, glowRadius) * glowIntensity;

	// safeNormalize UV coordinates relative to beam center
    float2 centeredUV = (uv - beamCenter) * 2.0;

	// Calculate radial distance
    float r = length(centeredUV);

	// Apply Gaussian intensity profile
    float intensity = gaussian(r, beamWaist);

	// Assign base color (e.g., orange beam)
    baseColor = baseColor * intensity;

	// Apply glow effect
    glowColor = glowColor * glowFactor;

	// Combine base color with glow
    float3 color = baseColor + glowColor;

	// safeNormalize and clamp the color
    color = saturate(color);

    return color;
}
inline float2 applyLensDistortion(float2 uv, float depth, float lensStrength, float lensRadius)
{
    float distance = length(uv);
    if (distance > lensRadius)
        return uv;
    float factor = lensStrength * (1.0 - distance / lensRadius) * depth;
    return uv + safeNormalize(uv) * factor;
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

float3 GeneratePhotonDirection(float3 pixel, uint seed, bool invertDepth, bool useProjectedDepth)
{
    float2 uv1 = float2(noisePerlin11(pixel.xy), noisePerlin11(pixel.xy + seed));
    float3 pixel1 = float3(uv1, depth2D(depthMap, uv1));
    return safeNormalize(pixel1 - pixel);

}

// Function to generate quantum Gaussian beam with uncertainties
QuantumGaussianBeam GenerateQuantumBeam(float2 depthUV, uint seed, bool invertDepth, bool useProjectedDepth)
{
    QuantumGaussianBeam beam;
    beam.position = float3(depthUV, depth2D(depthMap, depthUV, invertDepth, useProjectedDepth));
    beam.direction = GeneratePhotonDirection(beam.position, seed, invertDepth, useProjectedDepth);

	// Introduce quantum uncertainty in beam waist and divergence
    beam.beamWaist = 0.1 + noiseFast01(float2(float(seed) * 0.1, float(seed) * 0.1)) * 0.05; // Beam waist with uncertainty
    beam.divergence = 0.1 + noiseFast01(float2(seed * 0.11, seed * 0.11)).x * 0.05; // Divergence with uncertainty

	// Peak intensity influenced by quantum fluctuations
    beam.peakIntensity = 1.0 + (noiseFast01(float2(seed * 0.12, seed * 0.12)) - 0.5).x * 0.2;

	// Quantum phase shift
    beam.phaseShift = 0.1 * noiseFast01(float2(seed * 0.13, seed * 0.13)).x * 2.0 * PI;

    return beam;
}
int PoissonRandom(float lambda, uint seed)
{
    int k = 0;
    float p = 1.0;
    float L = exp(-lambda);
    [loop]
    while (p > L)
    {
        p *= noiseMap1.Sample(sampleTypeMirror, float2(seed * 0.08, seed * 0.08) + float2(k * 0.01, k * 0.01)).x * 2.0 - 1.0;
        k++;
    }
    return k - 1;
}


float Noise(float2 uv)
{
    return noisePerlin01(1.5 + uv.x, 3.14159 + uv.y, TotalTime * AnimateSpeed);
}

float4 ReadOutput(inout psout ret, float2 uv, int rtIndex)
{
    float3 retv = ZERO3;
    bool first = true;
    rtIndex = ((uint) rtIndex) % 8;
    float findex = rtIndex;
    float3 v = ret.rt1.xyz;
    [unroll(7)]
    for (int i = 0; i < 7; ++i)
    {
        switch (int(findex))
        {
            case 0:
                v = diffuse2D(rtMap1, uv).xyz;
                break;
            case 1:
                v = diffuse2D(rtMap2, uv).xyz;
                break;
            case 2:
                v = diffuse2D(rtMap3, uv).xyz;
                break;
            case 3:
                v = diffuse2D(rtMap4, uv).xyz;
                break;
            case 4:
                v = diffuse2D(rtMap5, uv).xyz;
                break;
            case 5:
                v = diffuse2D(rtMap6, uv).xyz;
                break;
            case 6:
                v = diffuse2D(rtMap7, uv).xyz;
                break;
            case 7:
                v = diffuse2D(rtMap8, uv).xyz;
                break;
        }


        findex--;
        if (findex < 0.0)
        {
            findex = 7.0;
        }
        retv += v * (float(8 - i) / 8.0);

    }

    return float4(retv, 1.0);
}



void _writeOutput(inout psout ret, float2 uv, float4 val, int rtIndex)
{
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

void WriteOutput(inout psout ret, float2 uv, float4 c, int rtIndex)
{
    rtIndex = int(((uint) rtIndex) % 8);

    float4 o = ReadOutput(ret, uv, rtIndex - 1);
    float4 val = lerp(o, c, 0.75);

    _writeOutput(ret, uv, c, rtIndex);
    if (rtIndex == 0)
    {
        _writeOutput(ret, uv, val, PassNum);
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
    [loop]
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
    color = pow(max(color, EPSILON3), float3(gamma, gamma, gamma));
    return color;
}

//4. Rainbow Edge Highlights
float3 ApplyRainbowEdge(Texture2D<float> depthMap, Texture2D<float3> normalMap, float2 depthUV, float3 normal, float3 viewDir, float3 baseColor, bool invertDepth)
{
    float2 normalUV = convertUV1ToUV3(depthMap, depthUV, normalMap);
    float2 oosz = GetOosz(normalMap);
	// Detect edges based on normal variation
    float3 normalRight = normal2DPoint11W(normalMap, normalUV + float2(oosz.x, 0), false);
    float3 normalUp = normal2DPoint11W(normalMap, normalUV + float2(0, oosz.y), false);
    float edgeStrength = length(normal - normalRight) + length(normal - normalUp);

	// Apply rainbow gradient based on edge strength
    float3 rainbow = float3(
		sin(TWOPI * edgeStrength + 0.0) * 0.5 + 0.5,
		sin(TWOPI * edgeStrength + 2.0 * PI / 3.0) * 0.5 + 0.5,
		sin(TWOPI * edgeStrength + 4.0 * PI / 3.0) * 0.5 + 0.5
	);

    return lerp(baseColor, rainbow, ONE3 * edgeStrength * 0.5);
}


// Safe Secant Function Implementation
inline float sec(float x)
{
	// Compute cosine of x
    float cos_x = cos(x);

	// To prevent division by zero, clamp cos_x away from zero
    float safe_cos_x = clamp(cos_x, -1.0 + EPSILON, 1.0 - EPSILON);

	// Return the secant of x
    return 1.0 / safe_cos_x;
}

// Overloaded Secant Function for float3
inline float3 sec(float3 x)
{
    float3 cos_x = cos(x);
    float3 safe_cos_x = clamp(cos_x, -1.0 + EPSILON3, 1.0 - EPSILON3);
    return 1.0 / safe_cos_x;
}

// Overloaded Secant Function for float2
inline float2 sec(float2 x)
{
    float2 cos_x = cos(x);
    float2 safe_cos_x = clamp(cos_x, -1.0 + EPSILON2, 1.0 - EPSILON2);
    return 1.0 / safe_cos_x;
}




// Dichroic Filter Function
inline float3 DichroicFilter(float time, float3 color, float3 wavelength, float3 phase)
{
	// Simulate dichroic filtering by selectively modifying color based on wavelength and phase
    float3 filteredColor;
    filteredColor.r = color.r * (1.0 + 0.5 * cos(wavelength.r * PI * phase.r * CosineFactorR + PhaseOffsetR)) * TanhFactorR;
    filteredColor.g = color.g * (1.0 + 0.5 * sin(wavelength.g * PI * phase.g * CosineFactorG + PhaseOffsetG)) * TanhFactorG;
    filteredColor.b = color.b * (1.0 + 0.5 * tanh(wavelength.b * PI * phase.b * CosineFactorB + PhaseOffsetB)) * TanhFactorB;
    return filteredColor;
}


// Secant Rainbow Function for Chromatic Aberration
inline float3 SecantRainbow(float3 color, float3 variance, float3 factor)
{
    float3 rainbow;
    rainbow.r = sec(clamp((color.r + variance.x) * factor.r, 0.1, 1.0)) * sin(color.r * TWOPI * factor.r);
    rainbow.g = sec(clamp((color.g + variance.y) * factor.g, 0.1, 1.0)) * cos(color.g * TWOPI * factor.g);
    rainbow.b = sec(clamp((color.b + variance.z) * factor.b, 0.1, 1.0)) * tan(color.b * TWOPI * factor.b);
    return rainbow;
}


inline float3 PhotonTransport(float3 normal, float3 lightDir, float3 viewDir, float3 n1, float3 n2, float coherenceLength, float polarizationAngle)
{
	// Step 1: Compute the cosine and sine of the incident angle
    float cosThetaI = max(EPSILON, saturate(dot(normalize(normal), normalize(lightDir))));
    float sinThetaI = sqrt(max(EPSILON, 1.0 - cosThetaI * cosThetaI));

	// Step 2: Compute the refraction angle using Snell's Law per component
    float3 sinThetaT = (n1 / max(EPSILON3, n2)) * sinThetaI;

    float3 sinThetaTSq = sinThetaT * sinThetaT;

	// Step 3: Handle Total Internal Reflection (TIR) per component
    bool3 isTIR = step(OneMinusEPSILON3, sinThetaT);
	// Convert isTIR to float3 for visualization
    float3 TIRVisualization = float3(step(0.0, isTIR.x), step(0.0, isTIR.y), step(0.0, isTIR.z));

	// For non-TIR components, compute cosThetaT
    float3 cosThetaT = sqrt(max(EPSILON3, ONE3 - sinThetaTSq));

	// Step 4: Compute Fresnel reflectance using full equations per component
	// Numerators and denominators for Rs and Rp per component
    float3 numeratorRs = (n1 * cosThetaI) - (n2 * cosThetaT);
    float3 denominatorRs = max(EPSILON3, (n1 * cosThetaI) + (n2 * cosThetaT));

    float3 numeratorRp = (n2 * cosThetaI) - (n1 * cosThetaT);
    float3 denominatorRp = max(EPSILON3, (n2 * cosThetaI) + (n1 * cosThetaT));

	// Compute Rs and Rp per component
    float3 Rs = numeratorRs / denominatorRs;
    float3 Rp = numeratorRp / denominatorRp;

	// Compute Rperp and Rpar per component
    float3 Rperp = Rs * Rs;
    float3 Rpar = Rp * Rp;

	// For TIR components, set reflectance to 1.0
    Rperp = lerp(Rperp, ONE3, step(0.0, isTIR));
    Rpar = lerp(Rpar, ONE3, step(0.0, isTIR));

	// Step 5: Average the reflectance for unpolarized light
    float3 fresnel = 0.5 * (Rperp + Rpar);

	// Step 6: Improved polarization effects using Brewster's angle
    float3 brewsterAngle = atan(n2 / max(EPSILON3, n1));
    float3 polarization = abs(cos(2.0 * (polarizationAngle - brewsterAngle)));
    polarization += sin(coherenceLength * PI);
    polarization = saturate(polarization);

	// Step 7: Compute the final reflectance modulated by polarization
    float3 reflectance = fresnel * polarization;

	// Step 8: Microfacet BRDF model with GGX Normal Distribution Function (NDF)
	// Compute halfway vector
    float3 halfVector = normalize(lightDir + viewDir);

    float NdotH = max(EPSILON, dot(normal, halfVector));
    float NdotV = max(EPSILON, dot(normal, viewDir));
    float NdotL = cosThetaI; // Already computed
    float VdotH = max(EPSILON, saturate(dot(viewDir, halfVector)));

	// Roughness parameter (can be adjusted or passed as an argument)
    float roughness = 0.5;
    float alpha = roughness * roughness;
    float alphaSq = alpha * alpha;

	// GGX Normal Distribution Function
    float denom = max(EPSILON, NdotH * NdotH * (alphaSq - 1.0) + 1.0);
    float D = alphaSq / (PI * denom * denom);

	// Geometry term using Smith's method
    float k = (alpha + 1.0) * (alpha + 1.0) / 8.0;
    float G_V = NdotV / max(EPSILON, NdotV * (1.0 - k) + k);
    float G_L = NdotL / max(EPSILON, NdotL * (1.0 - k) + k);
    float G = G_V * G_L;

	// Combine terms to get the BRDF
    float3 numerator = reflectance * D * G;
    float denominator = max(EPSILON, 4.0 * NdotV * NdotL);
    float3 specular = numerator / denominator;

	// Return the combined reflectance
    return (specular);
}

// Function to simulate chromatic aberration with dynamic shifting
float3 DynamicChromaticAberration(Texture2D<float4> diffuseMap, float2 diffuseUV, float time, int radius, float depth)
{
    float2 oosz = GetOosz(diffuseMap);
    float2 chromaShift = 0.002 + float(radius) * oosz * sin(time * 0.1) * 0.5 + float(radius) * oosz * sin(time * 0.1) * 0.25;

	// Offset UV coordinates for RGB channels
    float2 uvR = diffuseUV + chromaShift * depth;
    float2 uvG = diffuseUV;
    float2 uvB = diffuseUV - chromaShift * depth;

	// Sample texture for each color channel
    float r = diffuse2D(diffuseMap, uvR).r;
    float g = diffuse2D(diffuseMap, uvG).g;
    float b = diffuse2D(diffuseMap, uvB).b;

    return float3(r, g, b);
}

// Function to simulate depth with parallax scrolling
float2 ParallaxUV(float2 uv, float time, float depth, float3 uvScalar)
{
    float2 offset = depth * uvScalar.z * float2(sin(time + uv.y * uvScalar.x), cos(time + uv.x * uvScalar.y));
    return uv + offset;
}

// Function to generate holographic noise
float HolographicNoise(float2 uv, float2 resolution)
{
    float noise = frac(sin(dot(uv * resolution, float2(12.9898, 78.233))) * 43758.5453);
    noise = smoothstep(0.0, 1.0, noise);
    return noise * 0.1;
}

// Function to add glow effect around bright areas
float3 GlowEffect(Texture2D<float4> diffuseMap, float2 uv, float glowAmount)
{
    float3 color = diffuse2D(diffuseMap, uv).rgb;
    float luminance = dot(color, float3(0.299, 0.587, 0.114));

	// Create a radial gradient for glow
    float radius = length(uv - 0.5);
    float glow = exp(-radius * 10.0) * glowAmount;

    return color + glow * float3(0.2, 0.5, 1.0); // Add bluish glow
}

// Function to combine all holographic effects
float3 EnhancedHolographicColor(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv,
	float time, int aberrationRadius, float frequency, float speed, float glowAmount, float3 uvScalar, float depth)
{
    float2 sz = GetSz_1(depthMap);
    float2 oosz = 1.0 / sz;

	// Apply parallax effect for depth simulation
    float2 parallaxUV = ParallaxUV(uv, time, depth, uvScalar);

	// Apply dynamic chromatic aberration
    float3 aberration = DynamicChromaticAberration(diffuseMap, convertUV1ToUV4(depthMap, parallaxUV, diffuseMap), time, aberrationRadius, depth);

	// Generate complex interference pattern
    float interference = InterferenceComplex(parallaxUV, time, frequency, speed);


	// Add holographic noise
    float noise = HolographicNoise(parallaxUV, sz);

	// Apply glow effect
    float3 glow = GlowEffect(diffuseMap, parallaxUV, glowAmount);

	// Combine all effects
    float3 holographicColor = (aberration * interference + glow) * (1.0 + noise);

	// Clamp the final color
    return saturate(holographicColor);
}

float4 GetAberration(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 uv, float time, int aberrationRadius, float frequency, float speed, float glowAmount, int uvOffset, float sinYScalar, float sinTimeScalar, float cosXScalar, float cosTimeScalar, float3 uvScalar, bool invertDepth, bool useProjectedDepth)
{
	// Apply additional UV distortion for a richer holographic effect
    float2 oosz = GetOosz(depthMap);
    uv += uvOffset * float2(sin(uv.y * sinYScalar + time * sinTimeScalar), cos(uv.x * cosXScalar + time * cosTimeScalar));

	// Get the final color using the enhanced holographic color function
    float3 color = EnhancedHolographicColor(diffuseMap, depthMap, uv, time, aberrationRadius, frequency, speed, glowAmount, uvScalar, depth2D(depthMap, uv, invertDepth, useProjectedDepth));

    return float4(color, 1.0);
}
float3 IridescentColor(float2 uv, float time, float2 offset = float2(0.5, 0.5), float sinScalar = 1.0, float angleScalar = 1.0, float offsetScalar = 1.0, float saturationScalar = 1.0, float valueScalar = 1.0, float fadeStart = 0.8, float fadeEnd = 0.0)
{
	// Calculate angle and distance from the center
    float2 center = offset;
    float2 coord = uv - center;
    float angle = atan2(coord.y, coord.x);
    float distance = length(coord);

	// Create a color spectrum using the angle and time
    float hue = (angle / 6.28318) * angleScalar + 0.5 * offsetScalar + sin(time * 0.5) * 0.1 * sinScalar;
    float saturation = 1.0 * saturationScalar;
    float value = 1.0 * valueScalar;

	// Convert HSV to RGB
    float4 color = HSVtoRGB(float4(hue, saturation, value, 1.0));

	// Fade the color based on distance from the center
    color *= smoothstep(fadeStart, fadeEnd, distance);

    return color.rgb;
}



// Function to apply chromatic aberration
float3 ChromaticAberration(Texture2D<float4> diffuseMap, float2 uv, float time, float2 direction, float amount)
{
    float3 color;
	// Shift each color channel differently based on direction and amount
    float2 offsetR = uv + direction * amount;
    float2 offsetG = uv;
    float2 offsetB = uv - direction * amount;

	// Sample each channel separately
    float r = diffuse2D(diffuseMap, offsetR).r;
    float g = diffuse2D(diffuseMap, offsetG).g;
    float b = diffuse2D(diffuseMap, offsetB).b;

    color = float3(r, g, b);
    return color;
}

// Function to create iridescent color shifting
float3 IridescentShift(float2 uv, float time)
{
	// Calculate angle and distance from the center
    float2 center = float2(0.5, 0.5);
    float2 coord = uv - center;
    float angle = atan2(coord.y, coord.x);
    float distance = length(coord);

	// Dynamic hue based on angle and time
    float hue = frac(angle / (2.0 * 3.1415926) + time * 0.05);
    float saturation = 1.0;
    float value = 1.0;

	// Convert HSV to RGB
    float3 iridescent = HSVtoRGB(float3(hue, saturation, value));

	// Modulate based on distance for depth
    iridescent += lerp(0.5, 0.8, distance);

    return iridescent;
}

// Function to apply glow/bloom effect
float3 ApplyGlow(float3 color, float threshold)
{
    float3 glow = float3(0.0, 0.0, 0.0);
	// Identify bright areas
    if (dot(color, float3(0.2126, 0.7152, 0.0722)) > threshold)
    {
		// Apply exponential falloff based on brightness
        glow += color * 2.0;
    }
    return glow;
}

// Function to create noise texture (simple pseudo-random noise)
float noiseFast2(float2 uv)
{
    float2 resolution = GetSz_1(depthMap);
    return frac(sin(dot(uv * resolution, float2(12.9898, 78.233))) * 43758.5453);
}

inline float3 SnellsLaw(float3 incidentRay, float3 normal, float n1, float n2)
{
    half3 I = normalize(half3(incidentRay));
    half3 N = normalize(half3(normal));
    half eta = half(n1) / max(half(n2), (half) EPSILON);
    half cosI = clamp(dot(-I, N), -1.0h, 1.0h);

    half sinT2 = eta * eta * (1.0h - cosI * cosI);
    half TIR = step(1.0h, sinT2); // 1 if TIR occurs

    // If TIR, we reflect; else refract
    half3 R = reflect(I, N);
    half cosT = sqrt(max(1.0h - sinT2, EPSILON));
    half3 T = eta * I + (eta * cosI - cosT) * N;

    // Use lerp to select TIR or transmitted ray without branching
    return lerp(T, R, TIR);
}


// Main Pixel Shader
/*
psout PS5(PS_INPUT input)
{
    bool invertDepth = true;
    bool useProjectedDepth = false;
    psout ret;
    InitPSOut(ret, input.uv);
    float3 accumulatedColor = float3(0.0, 0.0, 0.0);

    float2 uv = input.uv;
    uint numLayers = 10;


    float time = TotalTime * AnimateSpeed;


    float layerSize = 1.0 / float(numLayers);
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float4 diffuse = diffuse2D(diffuseMap, uv);
    float3 wavelengthsNM = RGBToWavelengthsNM(diffuse.xyz);
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    float3 ior = RefractiveIndexFromWavelengths(wavelengthsNM, true, mat);
    float depth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float3 pixel = float3(uv, depth);
    float3 viewDir = safeNormalize(viewPos - pixel);
    
    float3 normal = normal2D(normalMap, uv, invertDepth);


    depth = clamp(depth2D(depthMap, uv, invertDepth, useProjectedDepth),
    0, 1);

    float3 layerColor = diffuse2D(diffuseMap, uv).rgb;
    
    float amplitude = layerColor.r; // Red channel: Amplitude
    float phase = layerColor.g; // Green channel: Phase

    wavelengthsNM = RGBToWavelengthsNM(layerColor.xyz) - layerColor;
    ior = RefractiveIndexFromWavelengths(wavelengthsNM, true, mat);

    float4 hologramPoint = float4(uv, depth, 1.0);
    float3 distanceM = length(viewPos - hologramPoint.xyz);

    ComplexPolarized lightField[3];
    [unroll(3)]
    for (int i = 0; i < 3; i++)
    {
        lightField[i].realHorizontal = layerColor[i] * cos(phase);
        lightField[i].imagHorizontal = layerColor[i] * sin(phase);
        lightField[i].realVertical = layerColor[i] * cos(phase);
        lightField[i].imagVertical = layerColor[i] * sin(phase);
    }
    
    float3 phaseShiftM = PhaseShiftM(nmToM(wavelengthsNM), distanceM, ior);
   
    float3 fresnel;
    [unroll(3)]
    for (i = 0; i < 3; i++)
    {
        fresnel[i] = FresnelDiffractionPolarized(distanceM[i], wavelengthsNM[i], lightField[i]).realHorizontal; // Simplified
    }

    ComplexPolarized viewerLight[3];
	[unroll(3)]
    for (i = 0; i < 3; i++)
    {
        viewerLight[i].realHorizontal = wavelengthsNM[i];
        viewerLight[i].imagHorizontal = 0.0;
        viewerLight[i].realVertical = wavelengthsNM[i];
        viewerLight[i].imagVertical = 0.0;
    }

    ComplexPolarized interference[3];
    [unroll(3)]
    for (i = 0; i < 3; i++)
    {
        interference[i] = InterferencePolarized(
                FresnelDiffractionPolarized(distanceM[i], wavelengthsNM[i], lightField[i]),
                viewerLight[i],
                BirefringentShadingModel(fresnel[i],pixel,normal,viewDir,viewerLight[i].realHorizontal*lightField[i].realHorizontal,mat,wavelengthsNM,time));
    }

    float intensity[3];
    [unroll(3)]
    for (i = 0; i < 3; i++)
    {
        intensity[i] = interference[i].realHorizontal * interference[i].realHorizontal + interference[i].imagHorizontal * interference[i].imagHorizontal;
        intensity[i] += interference[i].realVertical * interference[i].realVertical + interference[i].imagVertical * interference[i].imagVertical;
    }


    [unroll(3)]
    for (i = 0; i < 3; i++)
    {
        intensity[i] += .1 * cos(phaseShiftM[i]);
    }

	// Accumulate color contributions from each layer
    accumulatedColor += layerColor * float3(intensity[0], intensity[1], intensity[2]);



	// Normalize accumulated color by number of layers

	// Clamp color values to [0,1]
	//ret.rt2 = diffuse + f10 * saturate(lerp(float4(saturate(accumulatedColor) * f6, 1.0), 1, 0.75));
    float3 final = (accumulatedColor / float(numLayers));
    final *= DynamicChromaticAberration(diffuseMap, convertUV1ToUV4(depthMap, uv, diffuseMap), time, NormalRadius, depth);

    float NdotV = max(EPSILON, dot(viewDir, normal));

    ret.rt1 = NdotV * float4((final +
		NdotV * Fresnel3(final, viewDir, normal, mat.thicknessM, FresnelPower, FresnelReflectance, ONE3, ior, mat.scatteringCoefficient)), 1.0);

    ret.rt1 = AdjustGamma(ret.rt1, Gamma);
    return ret;

}*/

// Structure to hold transmission coefficients for Ordinary and Extraordinary rays
struct TransmissionResult
{
    float3 TransmissionO; // Ordinary transmission coefficients (RGB)
    float3 TransmissionE; // Extraordinary transmission coefficients (RGB)
};

TransmissionResult BirefringentTransmission(
    float3 viewDir,
    float3 normal,
    float3 n_o,
    float3 n_e
)
{
    // Ensure vectors are normalized
    viewDir = normalize(viewDir);
    normal = normalize(normal);

    // Compute Fresnel reflectance for Ordinary and Extraordinary rays
    float3 cTo, cTe;
    float3 FresnelO = FresnelReflectanceFromFilm2(n_o, ONE3, dot3(normal, viewDir), cTo);
    float3 FresnelE = FresnelReflectanceFromFilm2(n_e, ONE3, dot3(normal, viewDir), cTe);

    // Transmission coefficients are (1 - Fresnel Reflectance)
    TransmissionResult result;
    result.TransmissionO = 1.0 - FresnelO;
    result.TransmissionE = 1.0 - FresnelE;

    
    return result;
}
float4 OpticalAxisQuaternion(float3 opticalAxis)
{
    float3 z = safeNormalize(opticalAxis);
    float3 up = lerp(float3(0.0, 1.0, 0.0), float3(1.0, 0.0, 0.0), step(abs(z.y), 0.999));
    float3 x = safeNormalize(cross(up, z));
    float3 y = cross(z, x);
    // Convert rotation matrix to quaternion
    return matrixToQuaternion(float3x3(x, y, z));
}

float3x3 OpticalAxisMatrix(float3 opticalAxis)
{
    // Step 1: Normalize the optical axis
    float3 z = safeNormalize(opticalAxis);
    
    // Step 2: Compute two candidate cross products with world up and right vectors
    float3 cross1 = cross(z, float3(0.0, 1.0, 0.0)); // Cross with world up
    float len1 = length(cross1);
    
    float3 cross2 = cross(z, float3(1.0, 0.0, 0.0)); // Cross with world right
    float len2 = length(cross2);
    
    // Step 3: Determine which cross product is larger to select the appropriate up vector
    // Using step to create a mask: step(edge, x) returns 0.0 if x < edge, else 1.0
    // If len1 >= len2, select cross1; else, select cross2
    float mask1 = step(len2, len1); // 1.0 if len1 >= len2, else 0.0
    float mask2 = 1.0 - mask1; // Complementary mask
    
    // Step 4: Blend the cross products based on the masks
    float3 x = cross1 * mask1 + cross2 * mask2;
    
    // Step 5: Normalize the x-axis vector
    x = safeNormalize(x);
    
    // Step 6: Compute the y-axis as orthogonal to both z and x
    float3 y = cross(z, x);
    
    // Step 7: Construct and return the rotation matrix with orthonormal axes
    return float3x3(x, y, z);
}


float3 EffectiveRefractiveIndex(float3 lightDir, float3 opticalAxis, float3 n_o, float3 n_e)
{
    // Normalize the inputs
    lightDir = safeNormalize(lightDir);
    opticalAxis = safeNormalize(opticalAxis);

    // Step 1: Create the rotation matrix to align with the optical axis
    float3x3 rotationMatrix = OpticalAxisMatrix(opticalAxis);
    
    // Step 2: Rotate the light direction into the optical axis-aligned coordinate system
    // Assuming row-major matrix multiplication: rotatedLightDir = lightDir * rotationMatrix
    // In HLSL, mul(a, b) where a is a row vector and b is a matrix
    float3 rotatedLightDir = mul(lightDir, rotationMatrix);
    
    // Step 3: Calculate the cosine of the angle between rotated light direction and the z-axis (optical axis)
    float3 cosTheta = abs(rotatedLightDir.z); // Since optical axis aligns with z-axis
    float3 sinTheta = sqrt(1.0 - cosTheta * cosTheta);
    
    // Step 4: Calculate 1 / n_eff^2 using the uniaxial crystal formula
    float3 invNeffSqr = (sinTheta * sinTheta) / max(EPSILON3, (n_e * n_e))
                        + (cosTheta * cosTheta) / max(EPSILON3, (n_o * n_o));
    
    // Step 5: Compute the effective refractive index
    float3 n_eff = sqrt(1.0 / max(EPSILON3, invNeffSqr));
    
    return n_eff;
}


float3 DispersionCorrection(float3 n_eff, float3 wavelengthNM, float3 B, float3 C)
{
    // Convert wavelengths from nanometers to micrometers
    float3 lambda_um = nmToUm(wavelengthNM);

    // Compute lambda squared
    float3 lambda_sq = lambda_um * lambda_um;

    // Compute the denominator (avoid division by zero)
    float3 denominator = lambda_sq - C;
    denominator = max(denominator, EPSILON3);

    // Compute the Sellmeier dispersion term
    float3 dispersion_term = (B * lambda_sq) / denominator;

    // Compute n_squared using the Sellmeier equation
    float3 n_sqr = ONE3 + dispersion_term;

    // Compute the refractive index
    float3 refractiveIndex = sqrt(n_sqr);
    
    return ClampRefractiveIndex(refractiveIndex);
}


// Simulates the evolution of polarization state through birefringent medium
float3 PolarizationStateEvolution0(
	float3 initialPolarization,
	float3 effectiveN,
	float thicknessM,
	float3 opticalAxis
)
{
	// Compute phase shift: phi = (2 * PI / lambda) * n * thickness
	// Assume a reference wavelength for phase calculation (e.g., 550 nm)
    float lambda = 550.0e-9; // 550 nm in meters
    float3 phi = (2.0 * PI / lambda) * effectiveN * mToNm(thicknessM);

	// Construct Jones matrix for birefringent material
	// Assuming optical axis aligned with local z-axis
    float3x3 JonesMatrix = float3x3(
		cos(phi.r), -sin(phi.r), 0.0,
		sin(phi.g), cos(phi.g), 0.0,
		0.0, 0.0, 1.0
	);

	// Apply Jones matrix to initial polarization
    float3 evolvedPolarization = mul(JonesMatrix, initialPolarization);

	// Normalize the evolved polarization vector
    return safeNormalize(evolvedPolarization);
}

float3 PolarizationStateEvolution(
    float3 initialPolarization,
    float3 effectiveN,
    float thicknessM,
    float3 wavelengthNM
)
{
    // Convert wavelength from nanometers to meters
    float3 wavelengthM = nmToM(wavelengthNM);

    // Compute phase shift: phi = (2 * PI / lambda) * n * thickness
    float3 phi = (2.0 * PI / max(EPSILON3, wavelengthM)) * effectiveN * thicknessM;

    // Since we cannot handle complex numbers, we can compute the intensity modulation
    // due to the phase shift between the ordinary and extraordinary rays

    // Assuming initial polarization is linear at 45 degrees
    float3 intensity = cos(phi) * cos(phi);

    // Apply intensity modulation to the initial polarization
    float3 evolvedPolarization = initialPolarization * intensity;

    return evolvedPolarization;
}



// Simulates propagation of wave's polarization state through birefringent medium
float3 PropagateWavePolarization(float3 localPolarization, float3 correctedN, float thicknessM)
{
	// Speed of light in vacuum (m/s)
    float3 c = float3(3e8, 3e8, 3e8);

	// Compute phase shift: phi = (2 * PI / lambda) * n * thickness
	// Assuming wavelengths are part of the dispersion correction
	// For simplicity, assume lambda = 500 nm for phase calculation
    float lambda = 500.0e-9; // 500 nm in meters
    float3 phi = (2.0 * PI / lambda) * correctedN * mToNm(thicknessM);

	// Apply phase shift to polarization components
    float3 phaseShifted = localPolarization * cos(phi) + cross(float3(0.0, 0.0, 1.0), localPolarization) * sin(phi);

	// Normalize the updated polarization vector
    return safeNormalize(phaseShifted);
}



// Simulates double refraction, returning ordinary and extraordinary refracted directions
void SimulateDoubleRefraction0(
	float3 incidentDir,
	float3 normal,
	float3 opticalAxis,
	float3 n_o,
	float3 n_e,
	out float3 refractedDirO,
	out float3 refractedDirE)
{
	// Ordinary ray uses standard Snell's Law
    refractedDirO = refract3(incidentDir, normal, ONE3 / n_o);

	// Extraordinary ray's refractive index depends on direction
    float3 n_eff = EffectiveRefractiveIndex(incidentDir, opticalAxis, n_o, n_e);
    refractedDirE = refract3(incidentDir, normal, ONE3 / n_eff);
}
void SimulateDoubleRefraction(
    float3 incidentDir,
    float3 normal,
    float3 opticalAxis,
    float3 n_o,
    float3 n_e,
    out float3 refractedDirO,
    out float3 refractedDirE)
{
    incidentDir = normalize(incidentDir);
    normal = normalize(normal);
    opticalAxis = normalize(opticalAxis);

    // Assuming incident medium is air with n_air = 1.0
    float3 n_air = ONE3;

    // Ordinary ray uses standard Snell's Law
    float3 eta_o = n_air / n_o;
    refractedDirO = float3(
        refract(incidentDir, normal, eta_o.x).r,
        refract(incidentDir, normal, eta_o.y).g,
        refract(incidentDir, normal, eta_o.z).b);

    // Extraordinary ray's refractive index depends on direction
    float3 n_eff = EffectiveRefractiveIndex(incidentDir, opticalAxis, n_o, n_e);
    float3 eta_e = n_air / n_eff;
    refractedDirE = float3(
        refract(incidentDir, normal, eta_e.r).r,
        refract(incidentDir, normal, eta_e.g).g,
        refract(incidentDir, normal, eta_e.b).b);
}



// Comprehensive birefringent shading model
float3 BirefringentShadingModel(
	float3 albedo,
	float3 position,
	float3 normal,
	float3 viewDir,
	float3 lightDir,
	MaterialSellmeier mat,
	float3 wavelengthNM,
	float time
)
{
	// Normalize vectors
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    lightDir = safeNormalize(lightDir);


	// Define initial polarization state (linear polarization)
    float3 initialPolarization = normalize(normal);

	// Calculate effective refractive index based on polarization
    float3 effectiveN = ClampRefractiveIndex(EffectiveRefractiveIndex(normal, initialPolarization, mat.etaO, mat.etaE));
        
    effectiveN = ClampRefractiveIndex(
        DispersionCorrection(effectiveN, wavelengthNM, mat.etaO, mat.etaE));

	// Simulate wave polarization evolution through material
    float3 evolvedPolarization = PolarizationStateEvolution(initialPolarization, effectiveN, mat.thicknessM, mat.opticalAxis);

	// Compute phase shift due to birefringence
    float3 phaseShiftM = PhaseShiftM(nmToM(wavelengthNM), mat.thicknessM, effectiveN);

	// Apply phase shift to polarization state
    float3 updatedPolarization = PhaseShiftWavefront(evolvedPolarization, phaseShiftM);
    
	// Simulate double refraction
    float3 refractedDirO;
    float3 refractedDirE;
    SimulateDoubleRefraction(
		-lightDir,
		normal, // Local normal aligned with z-axis
		mat.opticalAxis,
		mat.etaO,
		mat.etaE,
		refractedDirO,
		refractedDirE
	);
    
	// Calculate effective refractive indices
    float3 effectiveNO = ClampRefractiveIndex(EffectiveRefractiveIndex(refractedDirO, normalize(normal), mat.etaO, mat.etaE));
    float3 effectiveNE = ClampRefractiveIndex(EffectiveRefractiveIndex(refractedDirE, normalize(normal), mat.etaO, mat.etaE));

    float3 cTo, cTe;
    float3 FresnelO = FresnelReflectanceFromFilm2(effectiveNO, effectiveNE, dot3(viewDir, refractedDirO), cTo); // Simplified for demonstration
    float3 FresnelE = FresnelReflectanceFromFilm2(effectiveNE, effectiveNO, dot3(viewDir, refractedDirE), cTe);

	// Compute transmission coefficients
    TransmissionResult Transmission = BirefringentTransmission(viewDir, normal, effectiveNO, effectiveNE);

    float3 averageTransmission = (Transmission.TransmissionO + Transmission.TransmissionE) * 0.5;
    float3 diffuse = albedo * averageTransmission;

	// Compute specular reflection using Fresnel terms
    float3 specular = saturate((FresnelO + FresnelE) * 0.5);

	// Combine diffuse and specular components
    float3 color = diffuse * (1.0 - mat.roughness) + specular * mat.roughness;
    
    
	// Apply modulation based on material temperature and density
    float temperatureFactor = mat.temperatureC / 100.0; // Normalize temperature
    float3 densityFactor = mat.density / 1000.0; // Normalize density
    color += clamp(color * temperatureFactor * densityFactor * 0.1, 0.1, 0.3);

	// Clamp the final color to [0,1]
    color = saturate(color);

    return color;
}

float3 IncorporateBirefringenceIntoLighting(
	PS_INPUT input,
	Texture2D<float4> diffuseMap,
	float2 inputUV,
	float3 viewDir,
	float3 lightDir,
	float3 normal,
	MaterialSellmeier mat,
	MaterialSellmeier mat2,
	float3 wavelengthNM,
	float time)
{
	// Normalize directions
    viewDir = normalize(viewDir);
    lightDir = normalize(lightDir);
    normal = normalize(normal);

	// Calculate effective refractive indices for ordinary and extraordinary rays
    float3 n_o = RefractiveIndexFromSellmeier(wavelengthNM, true, mat); // true for ordinary ray
    float3 n_e = RefractiveIndexFromSellmeier(wavelengthNM, false, mat); // false for extraordinary ray

	// Compute effective refractive indices based on propagation direction
    float3 n_eff_o = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, n_o, n_e); //n_o; // For ordinary ray, n_eff = n_o
    float3 n_eff_e = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, n_e, n_o);
    
    float3 o_n_o = RefractiveIndexFromSellmeier(wavelengthNM, true, mat2); // true for ordinary ray
    float3 o_n_e = RefractiveIndexFromSellmeier(wavelengthNM, false, mat2); // false for extraordinary ray

	// Compute effective refractive indices based on propagation direction
    float3 o_n_eff_o = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, o_n_o, o_n_e); //n_o; // For ordinary ray, n_eff = n_o
    float3 o_n_eff_e = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, o_n_e, o_n_o);

	// Compute phase shifts
    float3 deltaPhi_o = PhaseShiftM(nmToM(wavelengthNM), mat.thicknessM, n_eff_o);
    float3 deltaPhi_e = PhaseShiftM(nmToM(wavelengthNM), mat.thicknessM, n_eff_e);
    
    float3 deltaPhi_o_o = PhaseShiftM(nmToM(wavelengthNM), mat2.thicknessM, o_n_eff_o);
    float3 deltaPhi_o_e = PhaseShiftM(nmToM(wavelengthNM), mat2.thicknessM, o_n_eff_e);

	// Compute interference term
    float3 interference = lerp(
        saturate(0.5 + 0.5 * cos(deltaPhi_o - deltaPhi_e)),
        saturate(0.5 + 0.5 * cos(deltaPhi_o_o - deltaPhi_o_e)),
        max(EPSILON, abs(dot(viewDir, normal))) * 0.5 + 0.5);

	// Compute Fresnel reflectance for both rays
    float3 FresnelO = Fresnel3(inputUV, time, float3(mat.roughness, mat.roughness, mat.roughness), viewDir, normal, mat.thicknessM, FresnelPower, FresnelReflectance, o_n_o, n_o, 1.0 - mat.absorptionCoefficient) * interference;
    float3 FresnelE = // FresnelSchlick(dot3(normal, lightDir) * 0.5 + 0.5, n_eff_e, FresnelPower);
        Fresnel3(inputUV, time, float3(mat.roughness, mat.roughness, mat.roughness), viewDir, normal, mat.thicknessM, FresnelPower, FresnelReflectance, o_n_e, n_e, 1.0 - mat.absorptionCoefficient) * interference;

	// Sample diffuse texture
    float3 albedo = diffuse2D(diffuseMap, inputUV).rgb;

	// Combine contributions from ordinary and extraordinary rays
    float3 colorI = albedo + FresnelO;
    float3 colorE = albedo + FresnelE;

    return saturate(lerp(colorE, colorI, max(EPSILON, dot(viewDir, normal) * .5 + .5)));
}


float3 DiffractionGrating(
    float3 gratingNormal,
    float3 baseColor,
    float3 viewDir,
    float3 incidentDir,
    float strength,
    float gratingSpacingNM)
{
    // Normalize input vectors
    gratingNormal = normalize(gratingNormal);
    incidentDir = normalize(incidentDir);
    viewDir = normalize(viewDir);

    // Precompute values
    float cosThetaI = dot(incidentDir, gratingNormal);
    float sinThetaI = sqrt(saturate(1.0 - cosThetaI * cosThetaI));

    // Fixed wavelengths in nanometers for RGB channels
    float3 wavelengthsNM = RGBToWavelengthsNM(baseColor); // Red, Green, Blue
    float3 wavelengthsM = nmToM(wavelengthsNM); // Convert to meters

    // Grating spacing in meters
    float d = gratingSpacingNM * 1e-9;

    // Tangent direction perpendicular to the grating normal
    float3 tangentDir = normalize(incidentDir - gratingNormal * cosThetaI);

    // Initialize the diffracted color
    float3 diffractedColor = float3(0.0, 0.0, 0.0);

    // Maximum diffraction order to consider
    int maxOrder = 2; // Adjust for performance (consider orders -2 to +2)

    // Precompute common terms to reduce computations
    float3 lambdaOverD = wavelengthsM / d;

    float strength2 = max(EPSILON, 2.0 * strength * strength);
    
    // Loop over diffraction orders (flattened into individual computations)
    [unroll]
    for (int m = -maxOrder; m <= maxOrder; m++)
    {
        if (m == 0)
            continue; // Skip zero order (direct transmission/reflection)

        // Compute sinThetaM using the grating equation: sin θ_m = sin θ_i + m λ / d
        float3 sinThetaM = sinThetaI + m * lambdaOverD;

        // Check if sinThetaM is within valid range [-1, 1]
        float3 validMask = step(-1.0, sinThetaM) * step(sinThetaM, 1.0);

        // Compute cosThetaM safely
        float3 cosThetaM = sqrt(saturate(1.0 - sinThetaM * sinThetaM));

        // Compute diffracted direction
        float3 diffractedDir = normalize(sinThetaM * tangentDir + cosThetaM * gratingNormal);

        // Compute the dot product between view direction and diffracted direction
        float3 viewAlignment = saturate(dot(viewDir, diffractedDir));

        // Approximate diffraction efficiency using a Gaussian function
        float3 diffractionEfficiency = exp(-pow(max(EPSILON3, m * wavelengthsNM - gratingSpacingNM), 2.0) / max(EPSILON, strength2));

        // Apply valid mask
        float3 intensity = diffractionEfficiency * viewAlignment * validMask;

        // Accumulate the diffracted color
        diffractedColor += baseColor * intensity;
    }

    // Normalize the accumulated color
    diffractedColor /= (2.0 * maxOrder); // Normalize based on the number of orders considered

    // Combine with the base color for the zero-order (non-diffracted light)
    float3 zeroOrderColor = baseColor * saturate(dot(viewDir, incidentDir)) * strength;

    // Final color combines zero-order and diffracted light
    float3 finalColor = zeroOrderColor + diffractedColor;

    return saturate(finalColor);
}

float3 DiffractionGrating(
    float3 gratingNormal,
    float3 baseColor,
    float3 viewDir,
    float3 incidentDir,
    float strength,
    float3 gratingSpacingNM)
{
    return float3(
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.r).r,
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.g).g,
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.b).b
    );
}

// Compute diffraction grating effect
float3 DiffractionGrating(
    float3 gratingNormal,
    float3 baseColor,
    float3 viewDir,
    float3 incidentDir,
    float strength,
    float gratingSpacingNM,
    float3 timeBasedPhase)
{
    // Calculate diffraction pattern based on grating spacing and wavelengths
    float3 diffraction = DiffractionPattern(RGBToWavelengthsNM(baseColor), gratingSpacingNM, viewDir);
    
    // Apply strength and time-based phase modulation
    diffraction *= strength * InterferenceTimeBased(timeBasedPhase.x, timeBasedPhase.y, timeBasedPhase.z);
    
    return baseColor * (0.5 + 0.5 * diffraction);
}
float3 DiffractionGrating(
    float3 gratingNormal,
    float3 baseColor,
    float3 viewDir,
    float3 incidentDir,
    float strength,
    float3 gratingSpacingNM,
    float3 timeBasedPhase)
{
    return float3(
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.r, timeBasedPhase.r).r,
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.g, timeBasedPhase.g).g,
        DiffractionGrating(gratingNormal, baseColor, viewDir, incidentDir, strength, gratingSpacingNM.b, timeBasedPhase.b).b
    );
}




float3 CalcNormalGaussian(Texture2D<float3> normalMap, float2 normalUV, float sigma, float dist, bool invertDepth, bool useProjectedDepth)
{
    float2 ooszNormal = GetOosz(normalMap);
    float3 blurNormal = ZERO3;
    float totalWeight = EPSILON;
    float radius = min(max(ceil(3.0 * sigma), 1), FresnelPower);

    float sigmaSq2 = 2.0 * sigma * sigma;
    float3 centerNormal = normal2DPoint11W(normalMap, normalUV, false);

    [loop]
    for (int y = -radius; y <= radius; y++)
    {
        [loop]
        for (int x = -radius; x <= radius; x++)
        {
            float2 offset = float2(x, y) * ooszNormal * sigma * dist;

            float3 sampleNormal = normalize(normal2DPoint11W(normalMap, normalUV + offset, false) + .1 * noise3(noiseMap3, float3(normalUV, depth2D(depthMap, convertUV3ToUV1(normalMap, normalUV + offset, depthMap), invertDepth, useProjectedDepth))));
            float spatialWeight = gaussian(length(offset), sigma);
            float rangeWeight = gaussian(length(sampleNormal - centerNormal), sigma);
            float weight = spatialWeight * rangeWeight;

            blurNormal += sampleNormal * weight;
            totalWeight += weight;
        }
    }

    blurNormal /= max(abs(totalWeight), 0.0001);
    return normalize(lerp(centerNormal, blurNormal, .5) * 2.0 - 1.0);
}
/* Updated ParallaxOcclusion0 function
inline ParallaxOcclusionResult ParallaxOcclusion2(
    Texture2D<float> depthMap,
    float2 depthUV,
    float2 parallaxDir, bool invertDepth, bool useProjectedDepth)
{
    ParallaxOcclusionResult ret;

    float numLayers = 10.0;
    float layerDepth = 1.0 / numLayers;

    // Arrays to store per-step values
    // Assume numLayers≤32
    float2 uvStack[32];
    float layerDepthStack[32];
    float depthValStack[32];

    // Initial values
    uvStack[0] = depthUV;
    layerDepthStack[0] = 0.0;
    depthValStack[0] = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    float2 deltaUVBase = parallaxDir / numLayers;
    float stop = 0.0;
    int maxSteps = (int) numLayers;

    // Coarse search to find intersection layer
    [loop]
    for (int i = 1; i <= maxSteps; i++)
    {
        float prevLayerDepth = layerDepthStack[i - 1];
        float prevVal = depthValStack[i - 1];
        float2 prevUV = uvStack[i - 1];

        float nextLayerDepth = prevLayerDepth + layerDepth;
        float2 nextUV = prevUV + deltaUVBase * (1.0 - stop);
        float nextVal = depth2D(depthMap, nextUV, invertDepth, useProjectedDepth);

        // found intersection if nextVal ≤ nextLayerDepth
        float found = step(nextVal, nextLayerDepth);
        stop = max(stop, found);
        float notFound = 1.0 - stop;

        // Freeze values once found=1
        uvStack[i] = lerp(nextUV, prevUV, stop);
        layerDepthStack[i] = lerp(nextLayerDepth, prevLayerDepth, stop);
        depthValStack[i] = lerp(nextVal, prevVal, stop);

        // Also freeze deltaUVBase after found
        deltaUVBase *= notFound;
    }

    // Determine intersection index
    // The intersection step is where we set stop=1
    // After finishing loop, intersection at final step where found=1
    // If no intersection found, we ended at bottom anyway
    float hasIntersection = 0.0;
    int iint = 0;

    [loop]
    for (int j = 1; j <= maxSteps; j++)
    {
        float prevVal = depthValStack[j - 1];
        float currVal = depthValStack[j];
        float prevL = layerDepthStack[j - 1];
        float currL = layerDepthStack[j];

        float ffound = step(currVal, currL);
        hasIntersection = max(hasIntersection, ffound);
        // Record first intersection
        iint = iint * (int) (1.0 - ffound) + j * (int) ffound;
    }

    // If no intersection found, use bottom
    int useIndex = (int) ((1.0 - hasIntersection) * maxSteps + hasIntersection * float(iint));
    useIndex = clamp(useIndex, 1, maxSteps);

    int prevIndex = max(useIndex - 1, 0);

    float3 curPos = float3(uvStack[useIndex], depthValStack[useIndex]);
    float3 prevPos = float3(uvStack[prevIndex], depthValStack[prevIndex]);
    float currL = layerDepthStack[useIndex];
    float prevL = layerDepthStack[prevIndex];

    // Binary refinement
    float depthDifference = curPos.z - prevPos.z;
    float layerDifference = currL - prevL;
    float weight = depthDifference / max(depthDifference + layerDifference, EPSILON);
    weight = clamp(weight, EPSILON, OneMinusEPSILON);

    float2 finalUV = lerp(curPos.xy, prevPos.xy, weight);

    ret.deltaUV = finalUV - depthUV;
    return ret;
}
// Updated ParallaxOcclusion0 function
inline ParallaxOcclusionResult ParallaxOcclusion3(
    Texture2D<float> depthMap,
    float2 depthUV,
    float2 parallaxDir,
    bool invertDepth, bool useProjectedDepth)
{
    ParallaxOcclusionResult ret;

    float numLayers = 10.0;
    float layerDepth = 1.0 / numLayers;

    // Arrays to store per-step values
    // Assume numLayers≤32
    float2 uvStack[32];
    float layerDepthStack[32];
    float depthValStack[32];

    // Initial values
    uvStack[0] = depthUV;
    layerDepthStack[0] = 0.0;
    depthValStack[0] = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    float2 deltaUVBase = parallaxDir / numLayers;
    float stop = 0.0;
    int maxSteps = (int) numLayers;

    // Coarse search to find intersection layer
    [loop]
    for (int i = 1; i <= maxSteps; i++)
    {
        float prevLayerDepth = layerDepthStack[i - 1];
        float prevVal = depthValStack[i - 1];
        float2 prevUV = uvStack[i - 1];

        float nextLayerDepth = prevLayerDepth + layerDepth;
        float2 nextUV = prevUV + deltaUVBase * (1.0 - stop);
        float nextVal = depth2D(depthMap, nextUV, invertDepth, useProjectedDepth);

        // found intersection if nextVal ≤ nextLayerDepth
        float found = step(nextVal, nextLayerDepth);
        stop = max(stop, found);
        float notFound = 1.0 - stop;

        // Freeze values once found=1
        uvStack[i] = lerp(nextUV, prevUV, stop);
        layerDepthStack[i] = lerp(nextLayerDepth, prevLayerDepth, stop);
        depthValStack[i] = lerp(nextVal, prevVal, stop);

        // Also freeze deltaUVBase after found
        deltaUVBase *= notFound;
    }

    // Determine intersection index
    // The intersection step is where we set stop=1
    // After finishing loop, intersection at final step where found=1
    // If no intersection found, we ended at bottom anyway
    float hasIntersection = 0.0;
    int iint = 0;

    [loop]
    for (int j = 1; j <= maxSteps; j++)
    {
        float prevVal = depthValStack[j - 1];
        float currVal = depthValStack[j];
        float prevL = layerDepthStack[j - 1];
        float currL = layerDepthStack[j];

        float ffound = step(currVal, currL);
        hasIntersection = max(hasIntersection, ffound);
        // Record first intersection
        iint = iint * (int) (1.0 - ffound) + j * (int) ffound;
    }

    // If no intersection found, use bottom
    int useIndex = (int) ((1.0 - hasIntersection) * maxSteps + hasIntersection * float(iint));
    useIndex = clamp(useIndex, 1, maxSteps);

    int prevIndex = max(useIndex - 1, 0);

    float3 curPos = float3(uvStack[useIndex], depthValStack[useIndex]);
    float3 prevPos = float3(uvStack[prevIndex], depthValStack[prevIndex]);
    float currL = layerDepthStack[useIndex];
    float prevL = layerDepthStack[prevIndex];

    // Binary refinement
    float depthDifference = curPos.z - prevPos.z;
    float layerDifference = currL - prevL;
    float weight = depthDifference / max(depthDifference + layerDifference, EPSILON);
    weight = clamp(weight, EPSILON, OneMinusEPSILON);

    float2 finalUV = lerp(curPos.xy, prevPos.xy, weight);

    ret.deltaUV = finalUV - depthUV;
    return ret;
}
inline float2 ParallaxOcclusion0(
    Texture2D<float> depthMap,
    float2 depthUV,
    float2 parallaxDir, bool invertDepth, bool useProjectedDepth)
{
    // Number of layers
    float numLayers = 10.0;
    float layerDepth = 1.0 / numLayers;
    
    float2 uvStack[32]; // assume numLayers ≤32
    float layerDepthStack[32];
    float depthValStack[32];

    float2 currentUV = depthUV;
    float currentLayerDepth = 0.0;

    // Sample initial depth
    float currentDepthMapValue = depth2D(depthMap, currentUV, invertDepth, useProjectedDepth);

    // Compute initial deltaUV
    // Move from top to bottom: 
    // If top is 0 and bottom is 1, we step through layers increasing currentLayerDepth.
    // We know we must move along parallaxDir scaled by the depth difference.
    // The initial logic: deltaUV = parallaxDir * currentDepthMapValue / numLayers might not reflect standard POM logic.
    // Typically, we move in fixed increments along parallaxDir per layer and refine when we find intersection.
    // Let's pick a stable approach: 
    // The total displacement along parallaxDir corresponds to the difference between surface depth and actual depth.
    // For coarse search: move in uniform steps: deltaUVBase = parallaxDir / numLayers.
    // We'll accumulate these steps until we surpass depth.

    float2 deltaUVBase = parallaxDir / numLayers;

    // Coarse Search Phase:
    // We want to loop until we find currentLayerDepth > currentDepthMapValue or we reach bottom.
    // Without while, use a fixed loop and break using step:
    int maxSteps = (int) numLayers;
    float stop = 0.0; // 0 means continue, 1 means stop
    [loop]
    for (int i = 0; i < maxSteps; i++)
    {
        float fi = float(i);
        // nextLayerDepth = currentLayerDepth+layerDepth
        float nextLayerDepth = currentLayerDepth + layerDepth;

        // Advance UV:
        float2 nextUV = currentUV + deltaUVBase;
        float nextVal = depth2D(depthMap, nextUV, invertDepth, useProjectedDepth);

        // Check if nextLayerDepth≥nextVal means we found intersection
        float found = step(nextVal, nextLayerDepth);
        // found=1 if nextVal≤nextLayerDepth (intersection or just passed it)
        // If found=1: we should stop advancing
        // Use lerp to conditionally update currentUV and currentDepth with found masks:
        // Actually, we want to do the update if not found:
        float notFound = 1.0 - found;

        // Update currentUV, currentDepthMapValue, currentLayerDepth if not found:
        currentUV = lerp(nextUV, currentUV, found);
        currentDepthMapValue = lerp(nextVal, currentDepthMapValue, found);
        currentLayerDepth = lerp(nextLayerDepth, currentLayerDepth, found);

        stop = max(stop, found); // once found=1, stop remains 1
        // If we want to effectively "break", we can multiply further increments by notFound:
        // We'll rely on notFound to freeze values.

        // If not found, continue. If found=1, we do no further updates:
        deltaUVBase *= notFound; // if found=1 => deltaUVBase=0 no more movement
    }

    // Redo coarse search with arrays:
    float2 currentUV2 = depthUV;
    float currentLayerDepth2 = 0.0;
    float currentVal2 = depth2D(depthMap, currentUV2, invertDepth, useProjectedDepth);
    float2 deltaUV2 = parallaxDir / numLayers;

    // store initial
    uvStack[0] = currentUV2;
    layerDepthStack[0] = currentLayerDepth2;
    depthValStack[0] = currentVal2;

    float stop2 = 0.0;
    int maxSteps2 = int(numLayers);
    [loop]
    for (i = 1; i <= maxSteps2; i++)
    {
        float fi = float(i);
        float nextLayerDepth2 = layerDepthStack[i - 1] + layerDepth;
        float2 nextUV2 = uvStack[i - 1] + deltaUV2 * (1.0 - stop2); // no updates if stopped
        float nextVal2 = depth2D(depthMap, nextUV2, invertDepth, useProjectedDepth);

        float found2 = step(nextVal2, nextLayerDepth2);
        // once found2=1, no more updates:
        stop2 = max(stop2, found2);

        // blend to freeze values if found:
        float notFound2 = 1.0 - stop2;
        uvStack[i] = lerp(nextUV2, uvStack[i - 1], stop2);
        layerDepthStack[i] = lerp(nextLayerDepth2, layerDepthStack[i - 1], stop2);
        depthValStack[i] = lerp(nextVal2, depthValStack[i - 1], stop2);

        // Also freeze deltaUV2 after found:
        deltaUV2 *= notFound2;
    }

    // Now at end of coarse search, we have arrays uvStack,layerDepthStack,depthValStack.
    // Intersection at last step i where found was set:
    // Let's find that intersection index:
    float intersectionIndex = 0.0;
   
    int iint = 0;
    float hasIntersection = 0.0;
    [loop]
    for (int j = 1; j <= maxSteps2; j++)
    {
        float prevVal = depthValStack[j - 1];
        float currVal = depthValStack[j];
        float prevDepthL = layerDepthStack[j - 1];
        float currDepthL = layerDepthStack[j];

        float ffound = step(currVal, currDepthL); // if final ended in intersection condition
        
        hasIntersection = max(hasIntersection, ffound);
        iint = iint * (int) (1.0 - ffound) + j * (int) ffound;
    }

    // If no intersection found (hasIntersection=0), iint=0 means bottom:
    int useIndex = (int) ((1.0 - hasIntersection) * maxSteps2 + hasIntersection * float(iint));
    useIndex = clamp(useIndex, 1, maxSteps2); // ensure valid

    // Now we have intersection at useIndex:
    // We need prev and current from arrays:
    int prevIndex = max(useIndex - 1, 0);

    float3 curPos = float3(uvStack[useIndex], depthValStack[useIndex]);
    float3 prevPos = float3(uvStack[prevIndex], depthValStack[prevIndex]);
    float currLayerDepth_ = layerDepthStack[useIndex];
    float prevLayerDepth_ = layerDepthStack[prevIndex];

    // refinement:
    float depthDifference = curPos.z - prevPos.z;
    float layerDifference = currLayerDepth_ - prevLayerDepth_;
    float weight = depthDifference / max(depthDifference + layerDifference, EPSILON);
    weight = clamp(weight, EPSILON, OneMinusEPSILON);
    float2 finalUV = lerp(curPos.xy, prevPos.xy, weight);

    return finalUV - depthUV;
}
*/

float3 RotateVector(float3 v, float3 axis, float angle)
{
    axis = normalize(axis);
    float cosA = cos(angle);
    float sinA = sin(angle);
    return v * cosA + cross(axis, v) * sinA + axis * dot(axis, v) * (1.0 - cosA);
}
float3 GaussianTexture(
    Texture2D<float4> diffuseMap,
    Texture2D<float3> normalMap,
    Texture2D<float> depthMap,
    float2 inputUV,
    float3 normal,
    float3 viewPos,
    float3 viewDir,
    int layerCount,
    float baseLayerSpacing,
    float parallaxScale,
    float depthScale,
    float baseGaussianScale,
    float depthInfluenceOnSpacing = 0.1,
    float depthInfluenceOnGaussian = 0.1,
    float angularVariation = 0.25,
    float multiAxisFactor = 0.3,
    float angle = 0.1
)
{
    float baseDepth = depth2D(depthMap, inputUV, true, false);

    // Initial direction based on normal and view direction
    float3 initialDir = normalize(lerp(normal, viewDir, 0.5f));

    // Rotation axes to spread layers
    float3 rotAxisPrimary = ToTangentSpace11(float3(0, 1, 0));
    float3 rotAxisSecondary = ToTangentSpace11(float3(0, 1, 0));

    // Rotate the initial direction by a given angle to produce a baseline orientation
    float3 primaryDir = RotateVector(initialDir, rotAxisPrimary, angle);

    // Depth-influenced parameters
    float layerSpacing = baseLayerSpacing * lerp(1.0f, baseDepth, depthInfluenceOnSpacing);
    float gaussianScale = baseGaussianScale * lerp(1.0f, baseDepth, depthInfluenceOnGaussian);

    float3 finalColor = float3(0, 0, 0);
    float finalAlpha = 0.0f;
    int halfLayers = (int) (layerCount * 0.5f);

    [loop]
    for (int i = -halfLayers; i <= halfLayers; i++)
    {
        float offsetIndex = (float) i;
        float perLayerAngle = offsetIndex * angularVariation + angle * 0.5f;

        // Rotate around a secondary axis per layer for a more scattered distribution
        float3 layerDir = RotateAxisAngle(primaryDir, rotAxisSecondary, perLayerAngle * multiAxisFactor);

        // Random jitter to break uniform patterns
        float jitterAmt = 0.001f;
        float2 jitter = noise3(noiseMap1, float3(inputUV, offsetIndex)).xy * jitterAmt;

        // Compute UV offset based on spacing, parallax, and jitter
        float2 offsetUV = inputUV + layerDir.xy * offsetIndex * layerSpacing * parallaxScale + jitter;

        // Depth-based offset for volumetric feel
        float currDepth = depth2D(depthMap, offsetUV, true, false);
        float depthDiff = (currDepth - baseDepth) * depthScale;
        offsetUV += layerDir.xy * depthDiff;

        // Sample diffuse color
        float3 sampColor = diffuse2D(diffuseMap, offsetUV).rgb;

        // Elliptical anisotropy: define elliptical coordinates
        float ellipseRatio = 0.5f;
        float2 ellipseCoord = float2(offsetIndex, offsetIndex * ellipseRatio);
        float cA = cos(perLayerAngle), sA = sin(perLayerAngle);
        float2 rotatedEllipse = float2(ellipseCoord.x * cA - ellipseCoord.y * sA,
                                       ellipseCoord.x * sA + ellipseCoord.y * cA);

        // Multi-lobe blending: two lobes for richer shape
        float lobeOffset = 0.3f;
        float2 lobeUV1 = rotatedEllipse;
        float2 lobeUV2 = rotatedEllipse + float2(lobeOffset, -lobeOffset);

        float layerGaussianScale = gaussianScale * (1.0f + currDepth);

        float w1 = GaussianWeight(length(lobeUV1), layerGaussianScale);
        float w2 = GaussianWeight(length(lobeUV2), layerGaussianScale * 1.1f);
        float totalLobeWeight = w1 * 0.7f + w2 * 0.3f;

        // Hue shift per layer for subtle color complexity
        float hueShift = offsetIndex * 0.02f;
        sampColor = rotateHue(sampColor, hueShift);

        // Distance-based fade: fade out with camera distance
        float distToCam = length(viewPos);
        float distanceFade = saturate(1.0f - distToCam * 0.0005f);

        // Curvature-based weighting: stronger splats where layerDir aligns with N
        float curvatureFactor = saturate(dot(normal, layerDir));

        // Depth-based tint: slightly tint deeper layers
        float depthTintFactor = saturate(currDepth * 0.5f);
        sampColor = lerp(sampColor, sampColor * float3(0.9f, 0.95f, 1.0f), depthTintFactor * 0.2f);

        // Combine all factors into alpha
        float alpha = saturate(totalLobeWeight * distanceFade * curvatureFactor);

        // Pre-multiplied alpha blending
        float oneMinusAlpha = (1.0f - alpha);
        finalColor = finalColor * oneMinusAlpha + sampColor * alpha;
        finalAlpha = finalAlpha * oneMinusAlpha + alpha;
    }

    if (finalAlpha > 1e-6f)
        finalColor /= finalAlpha;

    return finalColor;
}

/*
Newly Added Techniques for More 3D Output:
1) Normal-based elliptical axis reorientation:
   Tilt ellipse sampling based on normal alignment to give splats a more surface-following shape.

2) View-angle weighting:
   Adjust splat weights based on viewing angle to simulate more pronounced depth as view becomes more glancing.

3) Depth-based layering tint:
   Tint deeper layers slightly to create a sense of layered volume and atmospheric depth.

4) Temporal deformation:
   Scale splats over time (temporalFactor) to simulate dynamic "breathing" or shifting volumes.

5) Normal variance-based roughness:
   Use the variation in the local normal field to adjust Gaussian scale, making areas with more normal variation appear thicker and more volumetric.
*/

/*
Example usage:

float3 color = GaussianTexture(
    DiffuseMap,                        // Texture2D<float4>
    NormalMap,                         // Texture2D<float3>
    DepthMap,                          // Texture2D<float>
    inputUV,                           // float2 UV coords
    cameraPos,                         // float3 camera position
    normalize(cameraDir),              // float3 view direction
    11,                                // layerCount
    0.01,                              // baseLayerSpacing
    1.0,                               // parallaxScale
    0.05,                              // depthScale
    0.25,                              // baseGaussianScale
    0.1,                               // depthInfluenceOnSpacing
    0.1,                               // depthInfluenceOnGaussian
    0.25,                              // angularVariation
    0.3                                 // multiAxisFactor
);

// New 5 Gaussian Splatting Techniques:
// 6) Color-coded splats (hue shifting per layer).
// 7) Distance-based fade (reduced alpha as camera distance increases).
// 8) Curvature-based weighting using normal-direction alignment.
// 9) MIP-level sampling based on depth to simulate scale 
*/

struct ParallaxResult
{
    float2 prevUV;
    int intersectionCount;
    float2 deltaUVs[MAX_PARALLAX_INTERSECTIONS];
};
float CalculateDepthGradient(Texture2D<float> depthMap, float2 uv, float2 oosz, bool invertDepth, bool useProjectedDepth = false)
{
    float depthCenter = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float depthRight = depth2D(depthMap, uv + float2(oosz.x, 0.0f), invertDepth, useProjectedDepth);
    float depthUp = depth2D(depthMap, uv + float2(0.0f, oosz.y), invertDepth, useProjectedDepth);
    
    float gradientX = abs(depthRight - depthCenter);
    float gradientY = abs(depthUp - depthCenter);
    
    return max(gradientX, gradientY);
}

inline ParallaxResult ParallaxOcclusion(
    Texture2D<float> depthMap,
    float2 depthUV,
    float2 parallaxDir,
    bool invertDepth,
    bool useProjectedDepth,
    float scale)
{
    ParallaxResult ret = (ParallaxResult) 0;
    ret.intersectionCount = 0;
    ret.prevUV = depthUV; // Initialize prevUV

    // Local array for storing delta UVs
    float2 localDeltaUVs[MAX_PARALLAX_INTERSECTIONS] = (float2[MAX_PARALLAX_INTERSECTIONS]) 0;
    int localCount = 0;

    // Calculate one-over-size for proper offset scaling
    float2 oosz = GetOosz(depthMap); // Assume GetOosz is defined elsewhere
    
    float layerDepth = 1.0f / float(MAX_PARALLAX_LAYERS);

    // Initial depth read
    float currentDepthMapValue = depth2D(depthMap, depthUV, invertDepth);

    // Compute rotated direction based on depth
    float2 dir = ToTangentSpace11(float3(parallaxDir, 0)).xy;
    // Simple linear flip: near -> dir, far -> -dir
    float2 rotatedDir = normalize(lerp(dir, -dir, currentDepthMapValue)) * scale;

    float2 currentUV = depthUV;
    float currentLayerDepth = 0.0f;
    float prevDepthValue = currentDepthMapValue;

    // Coarse Search Phase
    float2 deltaUVBase = rotatedDir * scale / float(MAX_PARALLAX_LAYERS);
    float2 prevUV = currentUV;
    float prevLayerDepth = currentLayerDepth;
    float prevDepthVal = currentDepthMapValue;

    [unroll(MAX_PARALLAX_LAYERS)]
    for (int x = 0; x < MAX_PARALLAX_LAYERS; x++)
    {
        float2 sampleUV = currentUV + deltaUVBase;
        float sampleDepth = depth2D(depthMap, sampleUV, invertDepth);

        currentUV += deltaUVBase;
        currentLayerDepth += layerDepth;
        float previousDepthMapVal = prevDepthVal;
        currentDepthMapValue = sampleDepth;

        // Check if we've found an intersection
        if (currentLayerDepth >= currentDepthMapValue + EPSILON)
        {
            // Binary Refinement Phase
            float2 refinedUV = currentUV;
            float refinedLayerDepth = currentLayerDepth;

            float2 lowUV = currentUV - deltaUVBase;
            float lowLayerDepth = currentLayerDepth - layerDepth;
            float lowDepthValue = depth2D(depthMap, lowUV, invertDepth);

            float2 highUV = currentUV;
            float highLayerDepth = currentLayerDepth;
            float highDepthValue = sampleDepth;

            // Perform binary search to refine the intersection point
            [unroll(MAX_PARALLAX_REFINE_ITERATIONS)]
            for (int j = 0; j < MAX_PARALLAX_REFINE_ITERATIONS; j++)
            {
                float2 midUV = (lowUV + highUV) * 0.5;
                float midLayerDepth = (lowLayerDepth + highLayerDepth) * 0.5;
                float midDepthValue = depth2D(depthMap, midUV, invertDepth);

                if (midLayerDepth >= midDepthValue + EPSILON)
                {
                    highUV = midUV;
                    highLayerDepth = midLayerDepth;
                    highDepthValue = midDepthValue;
                }
                else
                {
                    lowUV = midUV;
                    lowLayerDepth = midLayerDepth;
                    lowDepthValue = midDepthValue;
                }
            }

            // Calculate the final UV offset with weighted interpolation
            float depthDifference = lowDepthValue - lowLayerDepth;
            float layerDifference = lowLayerDepth - highLayerDepth;
            float weight = clamp(depthDifference / max(depthDifference + layerDifference, EPSILON), 0.0, 1.0);
            float2 finalUV = lerp(lowUV, highUV, weight);

            // Store the deltaUV if we have space
            if (localCount < MAX_PARALLAX_INTERSECTIONS)
            {
                localDeltaUVs[localCount++] = finalUV - depthUV;
            }

            // Continue searching for additional intersections (High-to-Low)
            // Reset variables for the next search
            currentUV = finalUV;
            currentLayerDepth = lowLayerDepth + weight * layerDifference;
            currentDepthMapValue = lowDepthValue + weight * (highDepthValue - lowDepthValue);

            break; // Exit the loop after finding an intersection
        }

        // Update direction and scale with depth each layer
        rotatedDir = normalize(lerp(dir, -dir, currentDepthMapValue));
        
        deltaUVBase = rotatedDir.xy * (scale / float(MAX_PARALLAX_LAYERS));

        prevUV = currentUV;
        prevLayerDepth = currentLayerDepth;
        prevDepthVal = currentDepthMapValue;
    }

    // If no intersection was found during coarse search, store the deltaUV
    if (localCount < MAX_PARALLAX_INTERSECTIONS && (currentLayerDepth < currentDepthMapValue + EPSILON))
    {
        localDeltaUVs[localCount++] = currentUV - depthUV;
    }
    
    ret.prevUV = prevUV;

    ret.deltaUVs = localDeltaUVs;
    
    ret.intersectionCount = localCount;

    return ret;
}

float3 Specular(float3 N, float3 V, float3 L, MaterialSellmeier mat)
{
    float3 H = normalize(V + L);
    float NDF = DistributionGGX(N, H, mat.roughness);
    float3 G = GeometrySmithNVL(N, V, L, CreateAnisotropicRoughness(mat.roughness, mat.roughness));

	// Compute Fresnel reflectance for each RGB channel
    float3 NdotV = dot3(N, V);

    float3 reflectance = FresnelReflectanceFromComplex(NdotV, ComplexCreate(mat.etaR, mat.etaI));
    float3 FresnelR = clamp(reflectance, 0.0, 1.0);
    
	// Compute specular component
    float3 specular = (NDF * G * FresnelR) / (SpecularPower * NdotV) * SpecularIntensity;
    return specular;
}



// Main Birefringent Shading Function
float3 BirefringentShading(Texture2D<float4> diffuseMap, float2 diffuseUV, float3 gratingNormal, float3 normal, float3 viewDir,
    float3 lightDir, float time, float diffractionStrength, float gratingSpacingNM,
    float3 bloomIntensity, float thicknessM, float3 iorFilm, float3 iorMedium, MaterialSellmeier mat, bool invertDepth, bool useProjectedDepth, int dispersionIndex)
{
    float3 albedo = diffuse2D(diffuseMap, diffuseUV).rgb;

	// Apply chromatic aberration
    albedo = ApplyChromaticAberration(diffuseMap, depthMap, diffuseUV, viewDir, normal,
        Iridescence(viewDir, normal, albedo, thicknessM, mat, iorMedium), NormalRadius, mat, invertDepth, useProjectedDepth, dispersionIndex);

	// Apply diffraction grating effect
    float3 diffractedColor = DiffractionGrating(gratingNormal, albedo, viewDir, -lightDir, diffractionStrength, gratingSpacingNM);

	// Add volumetric scattering and bloom effect
    float3 scatter = abs(exp(-dot3(normal, viewDir)) * SpecularPower * 2.0);
    float3 bloom = scatter * bloomIntensity * SpecularIntensity;

    return albedo + diffractedColor * bloom;
}

inline float besselj(int n, float alpha)
{
    return cos(alpha - n * PI / 2.0) / sqrt(alpha);
}
// Modified Cook-Torrance BRDF for per-channel refractive indices
inline float3 CookTorranceBRDF_Spectral(
    MaterialSellmeier mat,
    float3 N,
    float3 V,
    float3 L,
    float3 H,
    float3 radiance)
{
    // Compute per-channel alpha from roughness
    float alpha = mat.roughness * mat.roughness;
    
    // Compute per-channel D, G, F
    float3 D = DistributionGGX(N, H, alpha);
    float3 G = GeometrySmithNVL(N, V, L, CreateAnisotropicRoughness(alpha, alpha));
    float3 F = FresnelSchlick(float3(mat.roughness, mat.roughness, mat.roughness), max(dot(H, V), 0.0), FresnelPower);
    
    // Compute specular component
    float3 numerator = D * G * F;
    float denominator = 4.0 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0) + 1e-6;
    float3 specular = numerator / denominator;
    
    // kS and kD
    float3 kS = F;
    float3 kD = 1.0 - kS;
    kD *= 1.0 - mat.roughness;
    
    // Diffuse component
    float3 diffuse = mat.albedo / PI;
    
    // Final BRDF
    float3 brdf = (kD * diffuse) + specular;
    
    // Multiply by radiance and NdotL
    return brdf * radiance * max(dot(N, L), 0.0);
}

// PBR Specular Reflection using Cook-Torrance BRDF
inline float3 CookTorranceSpecularPBR(
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float roughness,
    float3 F0,
    float metallic)
{
    // Normalize input vectors
    normal = safeNormalize(normal);
    viewDir = safeNormalize(viewDir);
    lightDir = safeNormalize(lightDir);

    // Compute the half-vector
    float3 H = safeNormalize(viewDir + lightDir);

    // Dot products
    float NdotV = saturate(dot(normal, viewDir));
    float NdotL = saturate(dot(normal, lightDir));
    float NdotH = saturate(dot(normal, H));
    float VdotH = saturate(dot(viewDir, H));

    // Avoid division by zero
    NdotV = max(NdotV, EPSILON);
    NdotL = max(NdotL, EPSILON);

    // Distribution function D using GGX/Trowbridge-Reitz
    float alpha = roughness * roughness;
    float alphaSq = alpha * alpha;
    float denom = NdotH * NdotH * (alphaSq - 1.0) + 1.0;
    float D = alphaSq / (PI * denom * denom);

    // Fresnel term F
    float3 F = FresnelSchlick(F0, VdotH, metallic);

    // Geometry function G using Smith's method with Schlick-GGX approximation
    float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
    float G_V = NdotV / (NdotV * (1.0 - k) + k);
    float G_L = NdotL / (NdotL * (1.0 - k) + k);
    float G = G_V * G_L;

    // Cook-Torrance BRDF
    float3 specularBRDF = (D * F * G) / (4.0 * NdotV * NdotL + EPSILON);

    // Ensure the specular BRDF is within valid range
    return saturate(specularBRDF);
}

float3 FresnelSchlickRoughness(float3 F0, float3 NdotV, float roughness)
{
    // Adjust F0 based on roughness
    F0 = lerp(F0, float3(1.0, 1.0, 1.0), roughness);

    // Fresnel-Schlick formula
    return F0 + (1.0 - F0) * pow(1.0 - NdotV, FresnelPower);
}
float3 CookTorranceSpecularPBR2(
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    float roughness,
    float3 NdotV,
    float3 F0
)
{
    // Half vector
    float3 halfDir = normalize(lightDir + viewDir);

    // Fresnel-Schlick approximation
    float NdotH = saturate(dot(normal, halfDir));
    float3 Fresnel = FresnelSchlickRoughness(F0, NdotH, roughness);

    // GGX Normal Distribution Function
    float NDF = DistributionGGX(normal, halfDir, roughness);

    // Geometry (Smith) function
    float G = GeometrySmithNVLf(normal, viewDir, lightDir, roughness);

    // Denominator for Cook-Torrance BRDF
    float3 denominator = 4.0 * NdotV * saturate(dot(normal, lightDir)) + EPSILON;

    // Cook-Torrance BRDF
    return (NDF * G * Fresnel) / denominator;
}

// PBR Diffuse Reflection using Lambertian BRDF
float3 DiffusePBR(
    float3 normal,
    float3 lightDir,
    float3 baseColor)
{
    // Normalize vectors
    normal = safeNormalize(normal);
    lightDir = safeNormalize(lightDir);
    
    // Calculate dot product for Lambertian reflection
    float NdotL = saturate(dot(normal, lightDir));
    
    // Lambertian diffuse reflection
    return baseColor * NdotL;
}
inline float3 HolographicLinearFalloff(
    float3 lightColor,
    float3 lightDir,
    float3 viewDir,
    float3 normal,
    float distance
)
{
    // Normalize vectors
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    normal = normalize(normal);

    // Calculate the half-vector between the light direction and the view direction
    float3 halfVector = normalize(lightDir + viewDir);

    // Calculate the angle between the normal and the half-vector
    float3 cosTheta = dot3(normal, halfVector);

    // Compute an interference pattern to simulate holographic color shifts
    float3 phase = cosTheta * 30.0; // Adjust the multiplier for different effects

    // Calculate color shifts using sine functions with phase offsets
    float3 holographicColor = float3(
        0.5 + 0.5 * sin(phase.x), // Red channel
        0.5 + 0.5 * sin(phase.y), // Green channel (2π/3 phase shift)
        0.5 + 0.5 * sin(phase.z) // Blue channel (4π/3 phase shift)
    );

    // Multiply by the light color to retain original lighting characteristics
    holographicColor *= lightColor;

    // Apply linear falloff based on distance
    float falloff = 1.0 / max(distance, 0.001);

    // Final light intensity with holographic effect
    return lerp(falloff, saturate(holographicColor * falloff), .5);
}

inline float3 HolographicLinearFalloff(
    float3 lightColor,
    float3 lightDir,
    float3 viewDir,
    float3 normal,
    float3 distance,
    float3 interference
)
{
    // Normalize vectors
    lightDir = normalize(lightDir);
    viewDir = normalize(viewDir);
    normal = normalize(normal);

    // Calculate the half-vector between the light direction and the view direction
    float3 halfVector = normalize(lightDir + viewDir);

    // Calculate the angle between the normal and the half-vector
    float3 cosTheta = dot3(normal, halfVector);

    // Compute an interference pattern to simulate holographic color shifts
    float3 phase = cosTheta * interference; // Adjust the multiplier for different effects

    // Calculate color shifts using sine functions with phase offsets
    float3 holographicColor = float3(
        0.5 + 0.5 * sin(phase.x), // Red channel
        0.5 + 0.5 * sin(phase.y), // Green channel (2π/3 phase shift)
        0.5 + 0.5 * sin(phase.z) // Blue channel (4π/3 phase shift)
    );

    // Multiply by the light color to retain original lighting characteristics
    holographicColor *= lightColor;

    // Apply linear falloff based on distance
    float3 falloff = ONE3 / max(abs(distance), EPSILON3);

    // Final light intensity with holographic effect
    return saturate(holographicColor * falloff);
}

inline float3 CalculateDiffractionDirection(
    float3 incidentDir, // Incident direction vector (normalized)
    float3 gratingNormal, // Grating normal vector (normalized)
    float wavelengthNM, // Wavelength in nanometers
    float gratingSpacingNM, // Grating spacing in nanometers
    int order // Order of diffraction (e.g., -1, 0, 1)
)
{
    // Ensure vectors are normalized
    incidentDir = normalize(incidentDir);
    gratingNormal = normalize(gratingNormal);

    // Calculate the angle of incidence (θ_i) relative to the grating normal
    float cosThetaI = dot(incidentDir, gratingNormal);
    float thetaI = acos(clamp(cosThetaI, -1.0, 1.0)); // Angle in radians

    // Calculate sine of the angle of incidence
    float sinThetaI = sin(thetaI);

    // Calculate the diffraction angle using the grating equation:
    // For transmission grating: d (sin θ_d - sin θ_i) = m λ
    // Solve for sin θ_d
    float sinThetaD = sinThetaI + (order * wavelengthNM) / gratingSpacingNM;

    // Check for valid diffraction orders (sin θ_d must be between -1 and 1)
    if (abs(sinThetaD) > 1.0)
    {
        // No valid diffraction order exists for this wavelength and order
        return float3(0.0, 0.0, 0.0); // Or handle appropriately
    }

    // Calculate the diffraction angle θ_d
    float thetaD = asin(clamp(sinThetaD, -1.0, 1.0));

    // Calculate the rotation angle Δθ = θ_d - θ_i
    float deltaTheta = thetaD - thetaI;

    // Calculate the rotation axis (perpendicular to the plane of incidence)
    float3 rotationAxis = normalize(cross(incidentDir, gratingNormal));

    // Handle cases where incidentDir is parallel to gratingNormal
    if (length(rotationAxis) < EPSILON)
    {
        // Incident direction is parallel to grating normal
        // Choose an arbitrary axis perpendicular to gratingNormal
        rotationAxis = normalize(cross(gratingNormal, float3(0.0, 1.0, 0.0)));
        if (length(rotationAxis) < EPSILON)
        {
            rotationAxis = normalize(cross(gratingNormal, float3(1.0, 0.0, 0.0)));
        }
    }

    // Construct the rotation matrix using Rodrigues' rotation formula
    float cosDeltaTheta = cos(deltaTheta);
    float sinDeltaTheta = sin(deltaTheta);
    float oneMinusCos = 1.0 - cosDeltaTheta;

    float3x3 rotationMatrix = float3x3(
        cosDeltaTheta + rotationAxis.x * rotationAxis.x * oneMinusCos,
        rotationAxis.x * rotationAxis.y * oneMinusCos - rotationAxis.z * sinDeltaTheta,
        rotationAxis.x * rotationAxis.z * oneMinusCos + rotationAxis.y * sinDeltaTheta,

        rotationAxis.y * rotationAxis.x * oneMinusCos + rotationAxis.z * sinDeltaTheta,
        cosDeltaTheta + rotationAxis.y * rotationAxis.y * oneMinusCos,
        rotationAxis.y * rotationAxis.z * oneMinusCos - rotationAxis.x * sinDeltaTheta,

        rotationAxis.z * rotationAxis.x * oneMinusCos - rotationAxis.y * sinDeltaTheta,
        rotationAxis.z * rotationAxis.y * oneMinusCos + rotationAxis.x * sinDeltaTheta,
        cosDeltaTheta + rotationAxis.z * rotationAxis.z * oneMinusCos
    );

    // Rotate the incident direction to get the diffraction direction
    float3 diffractionDir = mul(rotationMatrix, incidentDir);

    // Normalize the diffraction direction
    diffractionDir = normalize(diffractionDir);

    return diffractionDir;
}

float3 CalculateDiffractionDirection(float3 incidentDir, // Incident direction vector (normalized)
    float3 gratingNormal, // Grating normal vector (normalized)
    float3 wavelengthNM, // Wavelength in nanometers
    float gratingSpacingNM, // Grating spacing in nanometers
    int order // Order of diffraction (e.g., -1, 0, 1)
)
{
    return float3(
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.x, gratingSpacingNM, order).x,
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.y, gratingSpacingNM, order).y,
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.z, gratingSpacingNM, order).z
    );

}
float CalculateDiffractionAngle(float incidentAngle, float wavelength, float gratingSpacing, int diffractionOrder)
{
    // Ensure grating spacing is positive to avoid invalid calculations.
    gratingSpacing = max(gratingSpacing, 1e-9);

    // Grating equation: d * (sin θm) = d * sin θi + m * λ
    // Rearranged to find θm: sin θm = sin θi + (m * λ) / d
    float sinDiffractionAngle = sin(incidentAngle) + (diffractionOrder * wavelength) / gratingSpacing;

    // Clamp the value between -1 and 1 to handle total internal reflection cases.
    sinDiffractionAngle = clamp(sinDiffractionAngle, -1.0, 1.0);

    float diffractionAngle = asin(sinDiffractionAngle);

    return diffractionAngle;
}

void BirefringenceAndHolography(
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    float3 pixel,
    float3 normal,
    float3 albedo,
    float3 viewPosL,
    float3 viewPosR,
    float3 viewDirL,
    float3 viewDirR,
    float3 lightDir,
    MaterialSellmeier mat,
    float time,
    float3 NdotV,
    float3 lightPos,
    float2 diffuseUV,
    float3 gratingNormal,
    float chromaticAberrationStrength,
    float diffractionStrength,
    float gratingSpacingNM,
    float lightIntensity,
    float3 iorFilm,
    float3 ior,
    float phaseModulationScalar,
    float3 phaseShiftM,
    float3 gratingEfficiency,
    bool invertDepth, bool useProjectedDepth, int dispersionIndex,
    out float3 biref,
    out float3 brieF
)
{
    float3 albedoWavelengthsNM = RGBToWavelengthsNM(albedo);
    float3 birefL = BirefringentShadingModel(
        saturate(albedo),
        pixel,
        normal,
        viewDirL,
        lightDir,
        mat,
        albedoWavelengthsNM,
        time
    );
    birefL = saturate(birefL);

    float3 birefR = BirefringentShading(
        diffuseMap,
        diffuseUV,
        gratingNormal,
        normal,
        viewDirR,
        lightDir,
        time,
        diffractionStrength,
        gratingSpacingNM,
        lightIntensity,
        mat.thicknessM,
        iorFilm,
        ior,
        mat, invertDepth, useProjectedDepth, dispersionIndex
    );
    birefR = saturate(birefR);

    // Combine birefringent colors
    // Weighted combination, ensure no if
    biref = saturate(float3(birefL.r, birefL.g * birefR.g, birefR.b));

    // Further color modulation
    // Compute hue angles from sin(phaseShiftM + offsets)
    float3 angleR = fmod(phaseModulationScalar * sin(phaseShiftM.r + PhaseOffsetR) * gratingEfficiency.r + time, 360.0);
    float3 angleG = fmod(phaseModulationScalar * sin(phaseShiftM.g + PhaseOffsetG) * gratingEfficiency.g + time, 360.0);
    float3 angleB = fmod(phaseModulationScalar * sin(phaseShiftM.b + PhaseOffsetB) * gratingEfficiency.b + time, 360.0);

    // rotateHue expects a single angle, so we combine them or just pick one channel's angle
    // For a more stable approach, use the average angle:
    float hueAverage = (angleR.x + angleG.x + angleB.x) / 3.0;

    brieF = saturate(rotateHue(biref, hueAverage));
}
void BloomAndNoise(
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    float3 albedo,
    float phaseDifferenceM,
    float3 ior,
    float3 bloomPower,
    float sigma,
    float sigmaDist,
    float3 lightPos,
    float3 viewPos,
    float3 pixel,
    float3 normal,
    float time,
    float2 inputUV,
    out float3 bloomColor,
    out float3 noiseRidge
)
{
    noiseRidge = saturate(noiseRidgedMF11(saturate(float3(inputUV, 1.0)), time) * noiseTurbulence(saturate(float3(inputUV, 1.0)), time));

    bloomColor = HolographicBloom(
        diffuseMap,
        inputUV,
        saturate(albedo),
        phaseDifferenceM,
        ior,
        0.5,
        float3(0.1, 0.1, 0.1),
        bloomPower,
        RGBToWavelengthsNM(saturate(albedo)),
        sigma,
        sigmaDist,
        lightPos,
        viewPos,
        pixel,
        normal
    );
    bloomColor = saturate(bloomColor);
}



float3 ACESFilm(float3 x)
{
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    return saturate((x * (a * x + b)) / (x * (c * x + d) + e));
}
float3 RRTAndODTFit(float3 v)
{
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    return saturate((v * (a * v + b)) / (v * (c * v + d) + e));
}
float3 ACESFilmicToneMapping(float3 color)
{
    // sRGB to ACEScg color space conversion
    const float3x3 ACESInputMat = float3x3(
        0.59719, 0.35458, 0.04823,
        0.07600, 0.90834, 0.01566,
        0.02840, 0.13383, 0.83777
    );

    // ACEScg to sRGB color space conversion
    const float3x3 ACESOutputMat = float3x3(
        1.60475, -0.53108, -0.07367,
        -0.10208, 1.10813, -0.00605,
        -0.00327, -0.07276, 1.07602
    );

    // Apply input matrix
    color = mul(ACESInputMat, color);

    // Apply RRT and ODT fit
    color = RRTAndODTFit(color);

    // Apply output matrix
    color = mul(ACESOutputMat, color);

    // Clamp to [0, 1]
    return saturate(color);
}


float3 HableToneMapping(float3 color)
{
    // Exposure adjustment
    float exposure = 1.0; // Adjust if desired
    color *= exposure;

    // Filmic curve parameters (Hable curve)
    float3 x = max(color - 0.004, 0.0);
    // Ensure denominators never zero
    float3 denom = x * (6.2 * x + 1.7) + 0.06;
    denom = max(denom, EPSILON3);

    float3 numerator = (x * (6.2 * x + 0.5)) / denom;
    // Saturate and apply gamma correction (2.2)
    return pow(saturate(numerator), 1.0 / 2.2);
}
float3 Uncharted2ToneMapping(float3 color)
{
    float A = 0.15;
    float B = 0.50;
    float C = 0.10;
    float D = 0.20;
    float E = 0.02;
    float F = 0.30;
    float W = 11.2; // White point

    // Avoid division by zero
    float3 numerator = (color * (A * color + C * B) + D * E);
    float3 denominator = (color * (A * color + B) + D * F);
    denominator = max(denominator, EPSILON3);

    color = (numerator / denominator) - E / F;

    // Normalize to white point
    float exposureBias = 2.0;
    float whiteN = ((W * (A * W + C * B) + D * E) / (W * (A * W + B) + D * F)) - E / F;
    whiteN = max(whiteN, EPSILON);
    float whiteScale = 1.0 / whiteN;

    float3 result = color * exposureBias * whiteScale;

    return saturate(result);
}


float3 ReinhardToneMappingWhiteLevel(float3 color, float whiteLevel)
{
    whiteLevel = max(whiteLevel, EPSILON);
    color *= (1.0 / whiteLevel);
    float3 mapped = color / (1.0 + color);
    return saturate(mapped);
}


static const int MAX_KERNEL_SIZE = 15;
static const int MAX_HALF_KERNEL_SIZE = MAX_KERNEL_SIZE / 2;
struct HolographicKernel
{
    int kernelSize;
    int halfKernelSize;
    float amplitudeR[MAX_KERNEL_SIZE];
    float phaseR[MAX_KERNEL_SIZE];
    float amplitudeG[MAX_KERNEL_SIZE];
    float phaseG[MAX_KERNEL_SIZE];
    float amplitudeB[MAX_KERNEL_SIZE];
    float phaseB[MAX_KERNEL_SIZE];
};

void GenerateHolographicKernelRGB(
    out HolographicKernel hKernel,
    int desiredKernelSize,
    float sigmaR, float phaseShiftR,
    float sigmaG, float phaseShiftG,
    float sigmaB, float phaseShiftB)
{
    // Ensure kernel size is odd and within limits
    int kSize = min((desiredKernelSize | 1), MAX_KERNEL_SIZE);
    hKernel.kernelSize = kSize;
    hKernel.halfKernelSize = kSize / 2;

    float sumR = EPSILON;
    float sumG = EPSILON;
    float sumB = EPSILON;

    float invTwoSigmaSqR = 1.0 / (2.0 * sigmaR * sigmaR);
    float invTwoSigmaSqG = 1.0 / (2.0 * sigmaG * sigmaG);
    float invTwoSigmaSqB = 1.0 / (2.0 * sigmaB * sigmaB);

    [unroll]
    for (int idx = 0; idx < MAX_KERNEL_SIZE; idx++)
    {
        int i = idx - MAX_HALF_KERNEL_SIZE;

        // Create a mask: 1 if within range, 0 if outside
        float outMask = 1.0 - step(float(hKernel.halfKernelSize + 0.5), abs(float(i)));

        float x = float(i);

        // Red channel
        float amplitudeR = outMask * exp(-x * x * invTwoSigmaSqR);
        float phaseRVal = outMask * (phaseShiftR * x);
        hKernel.amplitudeR[idx] = amplitudeR;
        hKernel.phaseR[idx] = phaseRVal;
        sumR += amplitudeR;

        // Green channel
        float amplitudeG = outMask * exp(-x * x * invTwoSigmaSqG);
        float phaseGVal = outMask * (phaseShiftG * x);
        hKernel.amplitudeG[idx] = amplitudeG;
        hKernel.phaseG[idx] = phaseGVal;
        sumG += amplitudeG;

        // Blue channel
        float amplitudeB = outMask * exp(-x * x * invTwoSigmaSqB);
        float phaseBVal = outMask * (phaseShiftB * x);
        hKernel.amplitudeB[idx] = amplitudeB;
        hKernel.phaseB[idx] = phaseBVal;
        sumB += amplitudeB;
    }

    // Normalize the amplitude for each channel
    float invSumR = 1.0 / max(sumR, EPSILON);
    float invSumG = 1.0 / max(sumG, EPSILON);
    float invSumB = 1.0 / max(sumB, EPSILON);

    [unroll]
    for (idx = 0; idx < MAX_KERNEL_SIZE; idx++)
    {
        hKernel.amplitudeR[idx] *= invSumR;
        hKernel.amplitudeG[idx] *= invSumG;
        hKernel.amplitudeB[idx] *= invSumB;
    }
}



float4 HolographicBlurRGB(Texture2D<float4> diffuseMap, float2 inputUV, HolographicKernel hKernel)
{
    float2 diffuseOosz = GetOosz(diffuseMap);
    float2 resultR = ZERO2;
    float2 resultG = ZERO2;
    float2 resultB = ZERO2;

    [unroll]
    for (int i = -hKernel.halfKernelSize; i <= hKernel.halfKernelSize; i++)
    {
        float2 diffuseOffset = float2(i * diffuseOosz.x, 0.0);
        int kernelIndex = hKernel.halfKernelSize + i;

        float4 color = diffuse2D(diffuseMap, inputUV + diffuseOffset);

        float amplitudeR = hKernel.amplitudeR[kernelIndex];
        float phaseRVal = hKernel.phaseR[kernelIndex];
        float2 waveR = amplitudeR * sincos2(phaseRVal).yx;
        resultR += color.r * waveR;

        float amplitudeG = hKernel.amplitudeG[kernelIndex];
        float phaseGVal = hKernel.phaseG[kernelIndex];
        float2 waveG = amplitudeG * sincos2(phaseGVal).yx;
        resultG += color.g * waveG;

        float amplitudeB = hKernel.amplitudeB[kernelIndex];
        float phaseBVal = hKernel.phaseB[kernelIndex];
        float2 waveB = amplitudeB * sincos2(phaseBVal).yx;
        resultB += color.b * waveB;
    }

    float finalIntensityR = abs(dot(resultR, resultR));
    float finalIntensityG = abs(dot(resultG, resultG));
    float finalIntensityB = abs(dot(resultB, resultB));

    float maxIntensity = max(max(finalIntensityR, finalIntensityG), finalIntensityB);
    float normalizationFactor = lerp((1.0 / maxIntensity), 1.0, step(maxIntensity, 1.0));

    float4 finalColor = float4(finalIntensityR, finalIntensityG, finalIntensityB, 1.0) * normalizationFactor;
    return saturate(finalColor);
}

float3 RenderFilm(float2 inputUV, float3 diffuse, float3 lightDir, float3 normal, float time)
{
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
   
    float3 wavelengthsNM = RGBToWavelengthsNM(diffuse);
    float3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, true, mat);

    // Calculate cosine of transmission angles (simplified for demonstration)
    float3 cosThetaT = dot3(lightDir, normal); // Replace with accurate calculation

    // Define opdConfig dynamically
    float3 opdConfig = float3(
        1.0 + 0.2 * sin(time * 1.0), // Red channel
        1.0 + 0.2 * sin(time * 0.8), // Green channel
        1.0 + 0.2 * sin(time * 0.6) // Blue channel
    );

    // Define phaseConfig if needed (optional)
    float3 phaseConfig = ONE3; // Example: no additional scaling

    // Calculate thin-film interference factor
    float3 thinFilmInterference = InterferenceThinFilm(inputUV, time,
        nmToM(wavelengthsNM),
        0.001, // filmThicknessM in meters (1mm as an example)
        refractiveIndex,
        cosThetaT,
        float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding)
    );
    return thinFilmInterference;
}

/*
void CreatePhasedLightsFromDepth(
    Texture2D<float> depthMap,
    Texture2D<float3> normalMap,
    float2 inputUV,
    float3 viewPosition,
    bool invertDepth,
    bool useProjectedDepth,
    float parallaxScale,
    inout PhasedLightSource lights[MAX_LIGHT_SOURCES],
    inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    // Sample depth at inputUV
    float depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
    
    // Compute world position from UV and depth
    float3 worldPos = float3(inputUV, depth);
    
    // Compute view direction (from surface to viewer)
    float3 viewDir = safeNormalize(viewPosition - worldPos);
    float distanceToViewer = length(viewPosition - worldPos);
    
    // Compute number of lights per axis (assuming MAX_LIGHT_SOURCES is a perfect square)
    float fMaxLights = float(MAX_LIGHT_SOURCES);
    float axisCountF = sqrt(fMaxLights);
    int lightsPerAxis = (int) axisCountF;
    
    // Check if MAX_LIGHT_SOURCES is a perfect square
    if (lightsPerAxis * lightsPerAxis != MAX_LIGHT_SOURCES)
    {
        // Handle non-perfect square cases if necessary
        // For simplicity, assume it's a perfect square
    }
    
    float invMaxSources = 1.0 / max(fMaxLights, EPSILON);
    float invMaxSourcesSqrt = 1.0 / max(float(lightsPerAxis - 1), EPSILON);
    
    // Iterate over a grid to position lights
    
    for (int x = 0; x < lightsPerAxis; x++)
    {
        for (int y = 0; y < lightsPerAxis; y++)
        {
            int lightIndex = x * lightsPerAxis + y;
            
            // Check if lightIndex is within bounds
            if (lightIndex >= MAX_LIGHT_SOURCES)
                continue; // Skip if beyond maximum

            // Compute grid offsets ranging from -0.5 to +0.5
            float2 gridOffsets = float2(
                (float(x) / float(lightsPerAxis - 1)) - 0.5,
                (float(y) / float(lightsPerAxis - 1)) - 0.5);
            
            float2 lightOffset = gridOffsets * parallaxScale; // Adjust parallaxScale as needed

            // Compute light position around the surface position
            // Here, lights are placed on the same plane; adjust Z as needed for your use case
            float3 lightPos = worldPos + float3(lightOffset, 0.0);

            // Compute direction from surface to light (correct direction)
            float3 directionForLight = safeNormalize(lightPos - worldPos);

            // Compute distance from surface to light
            float distance = length(lightPos - worldPos);

            // Sample normal at the light's UV coordinates
            float2 lightUV = inputUV + lightOffset;
            float3 normal = normal2D(normalMap, lightUV, invertDepth);
            float3 diffuseColor = diffuse2D(diffuseMap, inputUV).rgb;
            
            float NdotV = abs(dot(viewDir, normal));
         
            // Rotate UV with depth (custom function; implement as needed)
            float2 rotateVal = RotateUVWithDepth(inputUV, viewDir.z, acos(NdotV), invertDepth, useProjectedDepth);

            // Modify randomSeeds based on rotation
            float3 lpos = float3(rotateVal, depth2D(depthMap, inputUV - viewDir.xy, invertDepth, useProjectedDepth)) * 1.0;
            
            randomSeeds[lightIndex] += lpos;

            // Compute wavelength from randomSeeds, clamp and scale
            float3 rnd = clamp(randomSeeds[lightIndex], MIN_WAVELENGTHS, MAX_WAVELENGTHS);
            float3 wavelengthNM = lerp(diffuseColor * WAVELENGTH_RANGES + MIN_WAVELENGTHS, RGBToWavelengthsNM(diffuseColor), .5);
          
            // Update randomSeeds with wavelength-based shift
            randomSeeds[lightIndex] += nmToM(wavelengthNM) * NdotV * 1.0;

            float3 phase = fmod((6.283185307 * distance) / max(wavelengthNM, EPSILON3), 6.283185307);

            // Position light so that at worldPos we get correct phase
            // Shift light position by an integer multiple of wavelength to adjust phase
            float3 finalLightPos = directionForLight * (-floor(
                float3(
                    distance / max(nmToM(wavelengthNM.x), EPSILON),
                    distance / max(nmToM(wavelengthNM.y), EPSILON),
                    distance / max(nmToM(wavelengthNM.z), EPSILON)
                ))) * nmToM(wavelengthNM) + (worldPos + nmToM(wavelengthNM));

            PhasedLightSource light = lights[lightIndex];
            // Assign light properties
            light.position = finalLightPos;
            light.wavelengthNM = wavelengthNM;
            light.intensity += 1.0; // Assign intensity as needed

            // Assign phase and amplitude
            light.phase += phase;
            light.amplitude += (sin(float(x)) + cos(float(y))) * 0.5; // Example amplitude

            // Assign direction
            light.direction = directionForLight;
            light.diffuse = noise3(noiseMap1, float3(inputUV, depth));
            
            // Compute NdotL for lighting calculations
            float NdotL = saturate(dot(normal, light.direction));

            // Compute sine and cosine of phase components
            float2 scR = sincos2(phase.r);
            float2 scG = sincos2(phase.g);
            float2 scB = sincos2(phase.b);
            
            light.re = NdotL * light.amplitude * exp(
                (scR.y * scR.y) * light.wavelengthNM.r +
                (scG.y * scG.y) * light.wavelengthNM.g +
                (scB.y * scB.y) * light.wavelengthNM.b);
            
            light.im = NdotL * light.amplitude * exp(
                (scR.x * scR.x) * light.wavelengthNM.r +
                (scG.x * scG.x) * light.wavelengthNM.g +
                (scB.x * scB.x) * light.wavelengthNM.b);
            
            lights[lightIndex] = light;
        }
    }
}
float3 CreateLighting(float2 inputUV, float2 hologramSize, float3 viewPos, bool invertDepth, bool useProjectedDepth, float parallaxScale, MaterialSellmeier mat)
{
    float3 randomSeeds[MAX_LIGHT_SOURCES];
    [unroll]
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
    // Initialize randomSeeds with some function of i, no if:
        float seedVal = frac(sin(float(i) * 12.9898 + 78.233) * 43758.5453);
        randomSeeds[i] = float3(seedVal, seedVal * 2.0, seedVal * 0.5);
    }
    PhasedLightSource lights[MAX_LIGHT_SOURCES] = (PhasedLightSource[MAX_LIGHT_SOURCES]) 0;
 
    CreatePhasedLightsFromDepth(depthMap, normalMap, inputUV, viewPos, invertDepth, useProjectedDepth, parallaxScale, lights, randomSeeds);

    // Now sum the coherent fields from all lights
    float reSum = 0.0;
    float imSum = 0.0;

    [unroll(MAX_LIGHT_SOURCES)]
    for (int li = 0; li < MAX_LIGHT_SOURCES; li++)
    {
        // no if: each light either valid or masked by amplitude zero if invalid
        reSum += lights[li].re;
        imSum += lights[li].im;
    }

    // Intensity is field magnitude squared
    float3 intensity = reSum * reSum + imSum * imSum;

    // saturate and possibly apply gamma correction if needed
    intensity = saturate(intensity);

    
    for (li = 0; li < MAX_LIGHT_SOURCES; li++)
    {
        PhasedLightSource light = lights[li];
    
        float3 diffuseWavelengthsNM = RGBToWavelengthsNM(diffuse2D(diffuseMap, inputUV).rgb); // Example frequencies
        float3 waveAmplitudes = light.amplitude * nmToM((diffuseWavelengthsNM + light.wavelengthNM) * .5); // Example amplitudes
        float3 phaseOffsets = float3(0.0, PI / 2.0, PI / 4.0) - light.phase; // Example phase offsets
        float time = TotalTime * AnimateSpeed;
        float3 lightPos = float3(SunX, SunY, SunZ);
        float depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
        float3 worldPos = float3(nmToM(inputUV), nmToM(depth));
        float3 viewDir = normalize(viewPos - worldPos);
        float3 shininess3 = 1.0 - mat.absorptionCoefficient;
        float3 specularColor = (mat.thermalConductivity + mat.temperatureC) / 1200.0;
        float3 diffuseColor = diffuse2D(diffuseMap, inputUV).rgb;
        
        // Compute lighting vectors
        float3 lightDir = normalize(lightPos - worldPos);
        float3 halfwayDir = normalize(lightDir + viewDir);
        float3 normal = normal2D(normalMap, inputUV, invertDepth);
    
        float NdotL = dot(normal, lightDir);
        float NdotH = dot(normal, halfwayDir);
        float NdotV = dot(normal, viewDir);
        
        // Specular lighting using Blinn-Phong model
        float3 spec = pow(max(NdotH, 0.0), SpecularPower);

        // Attenuation based on distance (optional)
        float distance = length(lightPos - worldPos);
        float attenuation = 1.0 / (distance * distance); // Quadratic attenuation

        // Standard lighting component
        float3 standardLighting = (diffuseColor + specularColor * spec) * attenuation * NdotL * SpecularIntensity;
    
        // Calculate interference color using multi-wave interference
        float3 holographicInterference = InterferenceMultiWave(inputUV, time, diffuseWavelengthsNM, waveAmplitudes, phaseOffsets);

        // Apply interference to the standard lighting
        float3 holographicLighting = standardLighting * holographicInterference;

        float3 iridescentColor = Iridescence(viewDir, normal, diffuseColor, mat.thicknessM, mat, mat.etaR);

        float3 refractiveIndex = RefractiveIndexFromSellmeier(diffuseWavelengthsNM, true, mat); // mat should be defined
        float3 cosThetaT = light.phase + nmToM(diffuseWavelengthsNM) * refractiveIndex; // Calculate based on geometry
        float3 opdConfig = float3(
            1.0 + 0.2 * sin(time * 1.0), // Red channel
            1.0 + 0.2 * sin(time * 0.8), // Green channel
            1.0 + 0.2 * sin(time * 0.6) // Blue channel
        );
            // Calculate interference factor
        float3 thinFilmInterference = InterferenceThinFilm(inputUV, time, nmToM(diffuseWavelengthsNM), mat.thicknessM,
             refractiveIndex, cosThetaT, mat.nSurrounding);

        // **Gaussian Beam Interference Integration**
        float3 gaussianBeamInterference = InterferenceGaussianBeam(
            inputUV,
            time,
            float2(0.5 + light.phase.y, 0.5 + light.phase.z) * NdotV, // Beam 1 Center
            float2(0.3, 0.7 - light.phase.x) * NdotV, // Beam 2 Initial Center
            light.phase.x, // Phase Offset
            invertDepth, // invertDepth
            useProjectedDepth // useProjectedDepth
        );
        
        
        // Combine standard, holographic, and iridescent lighting
        intensity = 
           (standardLighting * thinFilmInterference + holographicLighting * iridescentColor) * gaussianBeamInterference;
                    
    }
    return intensity;
}
*/
void CreatePhasedLightsFromDepth(
    Texture2D<float> depthMap,
    Texture2D<float3> normalMap,
    float2 inputUV,
    float3 viewPosition,
    bool invertDepth,
    bool useProjectedDepth,
    float parallaxScale,
    inout PhasedLightSource lights[MAX_LIGHT_SOURCES],
    inout float3 randomSeeds[MAX_LIGHT_SOURCES])
{
    float depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
    float3 worldPos = float3(inputUV, depth);
    float3 viewDir = ToTangentSpace11(safeNormalize(viewPosition - worldPos));

    int lightsPerAxis = (int) sqrt(MAX_LIGHT_SOURCES);
    float invMaxSourcesSqrt = 1.0 / max(float(lightsPerAxis - 1), EPSILON);

    for (int x = 0; x < lightsPerAxis; x++)
    {
        for (int y = 0; y < lightsPerAxis; y++)
        {
            int lightIndex = x * lightsPerAxis + y;
            if (lightIndex >= MAX_LIGHT_SOURCES)
                continue;

            float2 gridOffsets = float2(
                (float(x) * invMaxSourcesSqrt) - 0.5,
                (float(y) * invMaxSourcesSqrt) - 0.5);
            float2 lightOffset = gridOffsets * parallaxScale;

            float3 lightPos = worldPos + float3(lightOffset, 0.0);
            float3 lightDir = ToTangentSpace11(safeNormalize(lightPos - worldPos));
            float3 normal = normal2DPoint11W(normalMap, inputUV + lightOffset, false);

            float3 wavelengthNM = RGBToWavelengthsNM(diffuse2D(diffuseMap, inputUV).rgb);
            float distance = length(lightPos - worldPos);

            float3 phase = fmod((6.283185307 * distance) / max(wavelengthNM, EPSILON3), 6.283185307);

            lights[lightIndex].position = lightPos;
            lights[lightIndex].wavelengthNM = wavelengthNM;
            lights[lightIndex].phase = phase;
            lights[lightIndex].amplitude = 1.0;
            lights[lightIndex].direction = lightDir;
        }
    }
}
float3 CreateLighting(
    float2 inputUV,
    float2 hologramSize,
    float3 viewPos,
    bool invertDepth,
    bool useProjectedDepth,
    float parallaxScale,
    MaterialSellmeier mat,
    float3 normal,
    float3 lightDir,
    float3 viewDir,
    float time,
    float3 cosThetaT,
    float sssStrength, int dispersionIndex)
{
    float3 diffuseWavelengthsNM = RGBToWavelengthsNM(mat.albedo);
    float3 randomSeeds[MAX_LIGHT_SOURCES];
    for (int i = 0; i < MAX_LIGHT_SOURCES; i++)
    {
        float seedVal = frac(sin(float(i) * 12.9898 + 78.233) * 43758.5453);
        randomSeeds[i] = float3(seedVal, frac(seedVal * 1.37), frac(seedVal * 2.89));
    }

    PhasedLightSource lights[MAX_LIGHT_SOURCES] = (PhasedLightSource[MAX_LIGHT_SOURCES]) 0;
    CreatePhasedLightsFromDepth(depthMap, normalMap, inputUV, viewPos, invertDepth, useProjectedDepth, parallaxScale, lights, randomSeeds);

    float3 intensity = ZERO3;
    for (int li = 0; li < MAX_LIGHT_SOURCES; li++)
    {
        PhasedLightSource light = lights[li];
        float3 lightDir = light.direction;

        float3 interference = InterferenceMultiWave(inputUV, TotalTime, nmToM(diffuseWavelengthsNM), light.amplitude, light.phase);
        float3 thinFilm = InterferenceThinFilm(inputUV, TotalTime, nmToM(diffuseWavelengthsNM), mat.thicknessM, mat.etaR, cosThetaT, mat.nSurrounding);
        float3 iridescent = Iridescence(viewDir, normal, mat.albedo, mat.thicknessM, mat, mat.etaR);
        float3 scattering = SubsurfaceScatteringHybrid(diffuseMap, inputUV, normal, viewDir, lightDir, mat.albedo, mat.scatteringCoefficient, mat.absorptionCoefficient, sssStrength, mat.dispersionCoefficientsNm2[dispersionIndex]);

        intensity += (light.amplitude * thinFilm + iridescent) * scattering * interference;
    }

    return saturate(intensity / MAX_LIGHT_SOURCES);
}


float3 InterferenceMultiWaveSynchronized(
    float2 uv,
    float time,
    float3 waveFrequencies,
    float3 waveAmplitudes,
    float3 phaseOffsets,
    float swayFrequency
)
{
    // Phase synchronization with swaying
    float phaseShift = sin(time * swayFrequency) * PI / 2.0;
    
    // Combine multiple sine waves with synchronized phase
    float interference = 0.0;
    interference += waveAmplitudes.x * sin(waveFrequencies.x * uv.x + phaseOffsets.x + phaseShift);
    interference += waveAmplitudes.y * sin(waveFrequencies.y * uv.y + phaseOffsets.y + phaseShift);
    interference += waveAmplitudes.z * sin(waveFrequencies.z * (uv.x + uv.y) + phaseOffsets.z + phaseShift);
    
    // Normalize to [0,1]
    interference = 0.5 + 0.5 * interference;
    
    // Generate interference color
    float3 interferenceColor = lerp(float3(1.0, 0.0, 0.0), float3(0.0, 0.0, 1.0), interference);
    
    return interferenceColor;
}


float3 InterferenceMultiWaveSynchronized(
    float3 pixel,
    float time,
    float3 waveFrequencies,
    float3 waveAmplitudes,
    float3 phaseOffsets
)
{
    // Phase synchronization with swaying
    float phaseShift = 2.0 * PI + time;
    
    // Combine multiple sine waves with synchronized phase
    float interferenceX = waveAmplitudes.x * sin(waveFrequencies.x * pixel.x + phaseOffsets.x * phaseShift);
    float interferenceY = waveAmplitudes.y * sin(waveFrequencies.y * pixel.y + phaseOffsets.y * phaseShift);
    float interferenceZ = waveAmplitudes.z * sin(waveFrequencies.z * pixel.z + phaseOffsets.z * phaseShift);
    
    // Combine into a float3 interference vector
    float3 interference = clamp(float3(interferenceX, interferenceY, interferenceZ), -1, 1);
    return interference;
}

// Convert wavelength to wavenumber k
inline float Wavenumber(float wavelength)
{
    return (2.0 * PI) / wavelength;
}

// Compute angular frequency from frequency f (Hz)
inline float AngularFrequency(float f)
{
    return 2.0 * PI * f;
}

float3 StrobeRGB(float3 color, float time)
{
    // Normalize time to the [0,1) range if it's not already
    float normalizedTime = fmod(time, 1.0);
    return float3(
        step(0.0, normalizedTime) * step(normalizedTime, 0.3333) * step(0.5, color.r),
        step(0.3333, normalizedTime) * step(normalizedTime, 0.6666) * step(0.5, color.g),
        step(0.6666, normalizedTime) * step(normalizedTime, 1.0) * step(0.5, color.b));
}

float3 FinalPassToneMap(float3 hdrColor, float exposure)
{
    hdrColor *= exposure; // Apply exposure adjustment
    return hdrColor / (hdrColor + 1.0); // Reinhard tone mapping
}
float3 FinalPassGammaCorrection(float3 color, float gamma)
{
    return pow(color, abs(1.0 / gamma)); // Apply inverse gamma curve
}
float3 FinalPassAdjustSaturation(float3 color, float saturation)
{
    float luminance = dot(color, float3(0.3, 0.59, 0.11)); // Perceived luminance
    return lerp(float3(luminance, luminance, luminance), color, saturation);
}
float3 FinalPassColorGrade(float3 color, float3 lift, float3 gamma, float3 gain)
{
    color = color * gain; // Gain adjustment
    color = pow(max(EPSILON3, color), abs(gamma)); // Gamma adjustment
    color = color + lift; // Lift adjustment
    return saturate(color); // Clamp to [0,1]
}
float3 FinalPassApplyBloom(float3 color, float3 bloomColor, float bloomIntensity)
{
    return color + bloomColor * bloomIntensity; // Add bloom contribution
}
float3 FinalPassSharpen(Texture2D<float4> diffuseMap, float2 uv, float sharpness, SamplerState ssampler)
{
    float4 original = diffuseMap.Sample(ssampler, uv);
    float2 oosz = GetOosz(diffuseMap);
    float4 blurred = (
        diffuseMap.Sample(ssampler, uv + float2(1.0, 0.0) * oosz) +
        diffuseMap.Sample(ssampler, uv - float2(1.0, 0.0) * oosz) +
        diffuseMap.Sample(ssampler, uv + float2(0.0, 1.0) * oosz) +
        diffuseMap.Sample(ssampler, uv - float2(0.0, 1.0) * oosz)) * 0.25;
    return saturate(original + sharpness * (original - blurred)).rgb; // Sharpening
}
float3 FinalPassApplyVignette(float3 color, float2 uv, float2 screenSize, float intensity)
{
    float2 coords = (uv - 0.5) * (screenSize / min(screenSize.x, screenSize.y));
    float dist = length(coords);
    float vignette = smoothstep(1.0, 0.7, dist); // Soft edge vignette
    return color * lerp(1.0, vignette, intensity);
}
float3 FinalPassChromaticAberration(float3 color, Texture2D<float4> diffuseMap, float2 uv, SamplerState ssampler, int radius)
{
    float2 oosz = GetOosz(diffuseMap);
    float2 redUV = uv + float2(radius * oosz.x, 0.0); // Offset red channel
    float2 blueUV = uv - float2(radius * oosz.x, 0.0); // Offset blue channel
    color.r = lerp(color.r, diffuse2D(diffuseMap, redUV).r, .5);
    color.b = lerp(color.b, diffuse2D(diffuseMap, blueUV).b, .5);
    return color.rgb;
}

float4 FinalPass(Texture2D<float4> diffuseMap, float2 diffuseUV, Texture2D<float4> rtMap, float2 rtUV, Texture2D<float> depthMap, float2 depthUV, float3 color)
{
    float depth = depth2D(depthMap, depthUV);
    color = FinalPassToneMap(color, TanhFactorR);
    float3 bloomColor = color;
    bloomColor = saturate(color * 1.5);
    
    color = FinalPassApplyBloom(color, bloomColor, TanhFactorG);
    if (PassNum > 0)
    {
        color *= FinalPassSharpen(rtMap, rtUV, TanhFactorB, samplerState);
    }
    else
    {
        color *= FinalPassSharpen(diffuseMap, diffuseUV, TanhFactorB, samplerState);
    }
    color = FinalPassColorGrade(color, ONE3 * CosineFactorR, ONE3 * CosineFactorG, ONE3 * CosineFactorB);
    color = FinalPassGammaCorrection(color, Gamma);
    color = FinalPassAdjustSaturation(color, HeightParamA);
    if (PassNum > 0)
    {
        color = FinalPassApplyVignette(color, rtUV, GetSz_4(rtMap1), HeightParamB);
        color *= FinalPassChromaticAberration(color, rtMap1, rtUV, samplerState, HeightParamC * (1.0 - depth));
    }
    else
    {
        color = FinalPassApplyVignette(color, diffuseUV, GetSz_4(diffuseMap), HeightParamB);
        color *= FinalPassChromaticAberration(color, diffuseMap, diffuseUV, samplerState, HeightParamC * (1.0 - depth));
    }
    
    return float4(saturate(color), 1);
}

struct OffsetScalar
{
    float3 Offset;
    float3 Scalar;
};
OffsetScalar CreateOffsetScalar(float3 offset, float3 scalar)
{
    OffsetScalar ret = (OffsetScalar) 0;
    ret.Offset = offset;
    ret.Scalar = scalar;
    return ret;
}

struct ValueTransformFloat3
{
    float3 Value;
    OffsetScalar Transform;
};
ValueTransformFloat3 CreateValueTransformFloat3(float3 value, OffsetScalar transform)
{
    ValueTransformFloat3 ret = (ValueTransformFloat3) 0;
    ret.Value = value;
    ret.Transform = transform;
    return ret;
}

struct InterferenceSpiralConfig
{
    OffsetScalar Frequency;
    OffsetScalar Amplitude;
    OffsetScalar Color;
    OffsetScalar Pixel;
};

InterferenceSpiralConfig CreateInterferenceSpiralConfig(
    OffsetScalar frequency, OffsetScalar amplitude, OffsetScalar color, OffsetScalar pixel)
{
    InterferenceSpiralConfig ret = (InterferenceSpiralConfig) 0;
    ret.Frequency = frequency;
    ret.Amplitude = amplitude;
    ret.Color = color;
    ret.Pixel = pixel;
    return ret;

}

struct Lighting
{
    // 1. Material Information
    MaterialSellmeier material;
    float3 albedo;
    float3 albedoWavelengthsNM;
    float3 albedoWavelengthsM;
    float3 etaR;
    float3 nSurrounding;
    
    // 2. Geometry Information
    float2 inputUV;
    float3 pixelPos;
    float3 normal;
    float3 viewPos;
    float3 lightPos;
    float3 viewDir;
    float3 lightDir;
    float3 halfDir;

    // 3. Dot Products
    float VdotH;
    float3 NdotV3;
    float HdotN;
    float HdotL;
    float3 NdotL3;

    // 4. Index of Refraction (IOR) Calculations
    float3 iorAlbedoR;
    float3 iorAlbedoI;

    // Reflectance R
    float3 cosThetaTransmissionInsideReal;
    float3 cosThetaTransmissionOutsideReal;
    float3 internalFilmReflectanceReal;
    float3 externalFilmReflectanceReal;
    
    float3 fresnelReflectance;
    float3 diffuseContribution[3];
    
    float3 specularLighting;
        
    // Reflectance I
    float3 cosThetaTransmissionInsideImag;
    float3 cosThetaTransmissionOutsideImag;
    float3 internalFilmReflectanceImag;
    float3 externalFilmReflectanceImag;

    // 5. Microfacet Model Parameters
    float2 microfacetRoughness;
    float3 ggxDistributionTerm;
    float3 smithGeometryTerm;
    float3 microfacetDenominator;

    // 6. Lighting and Specular Components
    float3 calculatedLightIntensity;
    float3 microfacetSpecularTerm;
    float3 specularReflectanceResult;
    float3 CookTorrenceSpecular;
    // 7. Path Tracing Measurements
    PathMeasurement viewToPixel;

    
    Complex3 phaseShiftComplex[3];
    Complex3 internalComplex[3];
    Complex3 externalComplex[3];
    Complex3 totalReflectanceComplex[3];
    float3 interferenceIntensity[3];
    
    float3 interferenceColor;
   
    
    // 8. Dispersion and Optical Path Results (arrays for each dispersionIndex)
    OpticalPathResult opdAlbedoTransRealChannel[3];
    OpticalPathResult opdAlbedoTransImagChannel[3];
    
    float3 phaseShift[3];
    
    float3 phaseReal[3];
    float3 phaseImag[3];
    
    float3 reflectanceReal[3];
    float3 reflectanceImag[3];

    // 9. Transmittance Calculations
    float3 transmittanceReal[3];
    float3 transmittanceImag[3];

    // 10. Effective Refractive Indices
    float3 effectiveRefractiveIndexReflectReal[3];
    float3 effectiveRefractiveIndexReflectImag[3];
    float3 effectiveRefractiveIndexTransmitReal[3];
    float3 effectiveRefractiveIndexTransmitImag[3];
    
    // 18. Diffuse BRDF Components
    float3 diffuseRealTransmit[3];
    float3 diffuseImagTransmit[3];
    float3 diffuseRealReflect[3];
    float3 diffuseImagReflect[3];

    float3 lightingR;
    float3 lightingI;

    float3 lighting;
    
    // 20. Final Render Layer
    float3 renderLayer;

    float Config_Saturation;
    float Config_Gamma;
    float Config_Exposure;
    
    float depth;
    float invDepth01;
    float DepthScale;
    float2 DepthRange;
    
    // Depth Settings
    bool invertDepth;
    bool useProjectedDepth;
};


struct LightingComplex
{
    float Config_Saturation;
    float Config_Gamma;
    float Config_Exposure;
    
    float depth;
    float invDepth01;
    float DepthScale;
    float2 DepthRange;
    
    // Depth Settings
    bool invertDepth;
    bool useProjectedDepth;
    // 1. Material Information
    MaterialSellmeier material;
    float3 albedo;
    float3 albedoWavelengthsNM;
    float3 albedoWavelengthsM;
    float3 etaR;
    float3 nSurrounding;
    
    // 2. Geometry Information
    float2 inputUV;
    float3 pixelPos;
    float3 normal;
    float3 viewPos;
    float3 lightPos;
    float3 viewDir;
    float3 lightDir;
    float3 halfDir;

    // 3. Dot Products
    float VdotH;
    float3 NdotV3;
    float HdotN;
    float HdotL;
    float3 NdotL3;

    float3 interferenceIntensity[3];
    Complex3 internalFilmReflectance;
    Complex3 externalFilmReflectance;
    
    Complex3 lighting[3];
    float3 totalLighting[3];
    
    Complex3 phaseShiftComplex[3];
    Complex3 internalComplex[3];
    Complex3 externalComplex[3];
    Complex3 totalReflectanceComplex[3];
    
    Complex3 phaseShift[3];
   
    Complex3 internalReflectance;
    Complex3 externalReflectance;
    
    Complex3 totalReflectance[3];
    Complex3 diffuseReflectance[3];
    Complex3 diffuseTransmittance[3];
    Complex3 specularContribution[3];
    Complex3 interferenceContribution[3];
    
    float2 microfacetRoughness;
    float ggxDistribution;
    float smithGeometry;
    float3 microfacetSpecular;
    float3 dielectricReflectance;
    float3 metallicReflectance;
    float3 cookTorrenceSpecular;
    Complex3 polarization;
    float3 coherence;
    Complex3 cosThetaTransmissionInside;
    Complex3 cosThetaTransmissionOutside;
    
    
    Complex3 reflectance[3];
    Complex3 transmittance[3];
    Complex3 interferenceColorReflectance;
    Complex3 interferenceColorTransmittance;
    
};


float EffectiveRefractiveIndexCorrection(float3 refractiveIndex, float3 opticalAxis)
{
    // Cosine of the angle between refractive index vector and optical axis
    float cosTheta = saturate(dot(safeNormalize(refractiveIndex), safeNormalize(opticalAxis)));

    // Adjust correction factor based on angle
    float correction = 1.0 + (1.0 - cosTheta);

    return correction;
}

float3 EffectiveRefractiveIndexCorrection(float3 lightDir, float3 opticalAxis, float3 reflectance, float3 refractiveIndex)
{
    // Cosine of angle between light direction and optical axis
    float cosTheta = saturate(dot(safeNormalize(lightDir), safeNormalize(opticalAxis)));

    // Polarization factor based on reflectance
    float polarization = saturate(reflectance.r + reflectance.g + reflectance.b) / 3.0;

    // Effective refractive index adjustment
    float3 effectiveIndex = refractiveIndex * (1.0 + polarization * (1.0 - cosTheta));

    return effectiveIndex;
}
float3 CalculateEffectiveRefractiveIndexReflectReal(float3 lightDir, float3 opticalAxis, float3 reflectanceReal, float3 refractiveIndex)
{
    return EffectiveRefractiveIndexCorrection(lightDir, opticalAxis, reflectanceReal, refractiveIndex);
}
float3 CalculateEffectiveRefractiveIndexTransmitReal(float3 lightDir, float3 opticalAxis, float3 transmittanceReal, float3 refractiveIndex)
{
    return EffectiveRefractiveIndexCorrection(lightDir, opticalAxis, transmittanceReal, refractiveIndex);
}
float3 CalculateF0(float metallic, float3 dielectricReflectance, float3 metallicReflectance)
{
    // Dielectric reflectance is typically 0.04 for non-metals
    return lerp(dielectricReflectance, metallicReflectance, metallic);
}
float3 CalculateInterference(Lighting lighting)
{
    // Define Complex3 structures for internal and external reflectance
    Complex3 internalReflectance = ComplexCreate(
        lighting.internalFilmReflectanceReal,
        lighting.internalFilmReflectanceImag
    );
    Complex3 externalReflectance = ComplexCreate(
        lighting.externalFilmReflectanceReal,
        lighting.externalFilmReflectanceImag
    );

    // Calculate interference contribution
    return ComplexDot(internalReflectance, externalReflectance);
}

float3 ApplyReflectanceCoherence(float3 reflectance, OpticalPathResult opd, float coherenceLength)
{
    return reflectance * CoherenceFactor(opd.opticalMeasurement.PathLengthM, coherenceLength);
}
float3 ApplyTransmissionCoherence(float3 transmittance, OpticalPathResult opd, float coherenceLength)
{
    // Modulate the transmittance with coherence and path length factors
    return transmittance * CoherenceFactor(opd.opticalMeasurement.PathLengthM, coherenceLength);
}



float3 RedistributeExcessEnergy(float3 totalLight, float3 reflectance, float3 transmittance)
{
    // Compute the excess or deficit of energy
    float3 excessEnergy = saturate(totalLight - ONE3);

    // Redistribute excess energy equally to reflectance and transmittance
    reflectance += excessEnergy * 0.5;
    transmittance += excessEnergy * 0.5;

    return saturate(reflectance + transmittance); // Ensure final values are clamped
}
// Redistribute excess energy for real and imaginary components separately
void RedistributeExcessEnergyComplex(
    inout Complex3 lighting,
    inout Complex3 diffuse,
    inout Complex3 specular,
    inout Complex3 interference
)
{
    // Calculate total real and imaginary energy
    Complex3 totalEnergy = ComplexCreate(
        lighting.real + diffuse.real + specular.real + interference.real,
        lighting.imag + diffuse.imag + specular.imag + interference.imag
    );

    // Normalize real energy to conserve energy
    if (any(totalEnergy.real > 1.0))
    {
        float3 correctionFactor = max(totalEnergy.real, EPSILON3);
        lighting.real /= correctionFactor;
        diffuse.real /= correctionFactor;
        specular.real /= correctionFactor;
        interference.real /= correctionFactor;
    }
    if (any(totalEnergy.imag > 1.0))
    {
        float3 correctionFactor = max(totalEnergy.imag, EPSILON3);
        lighting.imag /= correctionFactor;
        diffuse.imag /= correctionFactor;
        specular.imag /= correctionFactor;
        interference.imag /= correctionFactor;
    }
}

float FractalNoise
        (
        float2 uv, float time)
{
    float n = 0.0;
    float scale = 1.0;
    float persistence = 0.5;
    for (int i = 0; i < 5; i++)
    {
        n += sin((uv.x + time * 0.1) * scale) * sin((uv.y - time * 0.2) * scale) * persistence;
        uv *= 2.0;
        scale *= 2.0;
        persistence *= 0.5;
    }
    return saturate(n * 0.5 + 0.5); // Normalize to [0, 1]
}

Lighting PopulateLighting(float2 inputUV,
                          float3 viewPos,
                          float3 lightPos,
                          bool invertDepth, bool useProjectedDepth,
                          float depthScale,
                          float2 depthRange,
                          int materialIndex,
                          float animateSpeed,
                          float parallaxScale,
                          float normalRadius, float sssStrength, int dispersionIndex,
                          float gamma, float exposure, float saturation,
                          inout float3 test)
{
    Lighting lighting = (Lighting) 0;
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    
    // Toggle states
    lighting.invertDepth = invertDepth;
    lighting.useProjectedDepth = useProjectedDepth;
    // Adjust depth parameters based on projection
    float currentDepthScale = lerp(1.0, depthScale, float(lighting.useProjectedDepth));
    float2 currentDepthRange = lerp(float2(0.1, 0.9), depthRange, float(lighting.useProjectedDepth));

    lighting.DepthScale = depthScale;
    lighting.DepthRange = depthRange;
    
    // Create material
    MaterialSellmeier mat = CreateMaterial(materialIndex);
    mat.albedo = diffuse2D(diffuseMap, inputUV).rgb;
    lighting.material = mat;
    // Albedo and wavelength conversions
    lighting.albedo = mat.albedo;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);

    lighting.etaR = mat.etaR;
    lighting.nSurrounding = ONE3 * mat.nSurrounding;
   
    // Time and sway calculations
    float time = TotalTime * animateSpeed;
   
    lighting.inputUV = inputUV;
    lighting.pixelPos = float3(inputUV, depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth));
    
    lighting.nSurrounding = ONE3 * mat.nSurrounding;

    // Pixel and normal calculations
    lighting.normal = normal2D11W(normalMap, inputUV, normalRadius, false);

    // View and light positions and directions
    lighting.viewPos = viewPos;
    lighting.lightPos = lightPos;
    lighting.viewDir = ToTangentSpace11(normalize(lighting.viewPos - lighting.pixelPos));
    lighting.lightDir = ToTangentSpace11(normalize(lighting.lightPos - lighting.pixelPos));
    lighting.halfDir = normalize(lighting.viewDir + lighting.lightDir);

    // Dot products
    lighting.VdotH = clamp(dot(lighting.viewDir, lighting.halfDir), EPSILON, OneMinusEPSILON);
    lighting.NdotV3 = clamp(dot3(lighting.viewDir, lighting.normal), EPSILON3, OneMinusEPSILON3);
    lighting.HdotN = clamp(dot(lighting.halfDir, lighting.normal), EPSILON, OneMinusEPSILON);
    lighting.HdotL = clamp(dot(lighting.halfDir, lighting.lightDir), EPSILON, OneMinusEPSILON);
    lighting.NdotL3 = clamp(dot3(lighting.lightDir, lighting.normal), EPSILON3, OneMinusEPSILON3);

    // Reflectance with interference
    lighting.iorAlbedoR = RefractiveIndexFromSellmeier(lighting.albedoWavelengthsNM, true, mat);
    lighting.iorAlbedoI = RefractiveIndexFromSellmeier(lighting.albedoWavelengthsNM, false, mat);

    // Reflectance R
    lighting.internalFilmReflectanceReal = FresnelReflectanceFromFilm2(
        mat.nSurrounding, lighting.iorAlbedoR, lighting.NdotL3, lighting.cosThetaTransmissionInsideReal);
    
    lighting.externalFilmReflectanceReal = FresnelReflectanceFromFilm2(
        lighting.iorAlbedoR, mat.nSurrounding, lighting.NdotL3, lighting.cosThetaTransmissionOutsideReal);

    // Reflectance I
    lighting.internalFilmReflectanceImag = FresnelReflectanceFromFilm2(mat.nSurrounding, lighting.iorAlbedoI, lighting.NdotL3, lighting.cosThetaTransmissionInsideImag);
    
    lighting.externalFilmReflectanceImag = FresnelReflectanceFromFilm2(lighting.iorAlbedoI, mat.nSurrounding, lighting.NdotL3, lighting.cosThetaTransmissionOutsideImag);
    
    
    lighting.phaseShift[dispersionIndex] = (lighting.opdAlbedoTransRealChannel[dispersionIndex].phaseInterference.totalPhase +
                     lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase) * 0.5;

    
    lighting.phaseReal[dispersionIndex] = (TWOPI3 * lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM;
    
    lighting.phaseImag[dispersionIndex] = (TWOPI3 * lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM;
    
    lighting.phaseShiftComplex[dispersionIndex] = ComplexCreate(
        lighting.phaseReal[dispersionIndex],
        lighting.phaseImag[dispersionIndex]);
    
    lighting.phaseShiftComplex[dispersionIndex] = ComplexMul(
        lighting.phaseShiftComplex[dispersionIndex],
        ComplexCreate(lighting.reflectanceReal[dispersionIndex], lighting.reflectanceImag[dispersionIndex])
    );

    
    lighting.internalComplex[dispersionIndex] = ComplexCreate(lighting.internalFilmReflectanceReal, lighting.internalFilmReflectanceImag);
    
    lighting.externalComplex[dispersionIndex] = ComplexCreate(lighting.externalFilmReflectanceReal, lighting.externalFilmReflectanceImag);
    
    lighting.totalReflectanceComplex[dispersionIndex] = ComplexAdd(lighting.internalComplex[dispersionIndex], ComplexMul(lighting.externalComplex[dispersionIndex], lighting.phaseShiftComplex[dispersionIndex]));
    
    lighting.totalReflectanceComplex[dispersionIndex] = ComplexMul(
        lighting.totalReflectanceComplex[dispersionIndex],
        ComplexCreate(lighting.reflectanceReal[dispersionIndex], lighting.reflectanceImag[dispersionIndex])
    );

    
    lighting.interferenceIntensity[dispersionIndex] = ComplexDot(lighting.totalReflectanceComplex[dispersionIndex], lighting.totalReflectanceComplex[dispersionIndex]);
    
    lighting.interferenceIntensity[dispersionIndex] *= exp(-mat.absorptionCoefficient *
        lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM);

    
    // BRDF Calculations
    lighting.microfacetRoughness = mat.roughness.xx;
    lighting.ggxDistributionTerm = DistributionGGX(lighting.normal, lighting.halfDir, lighting.microfacetRoughness.x);
    lighting.smithGeometryTerm = GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x);
    lighting.microfacetDenominator = max(float3(4.0, 4.0, 4.0) * lighting.NdotV3, float3(EPSILON3));

    lighting.microfacetSpecularTerm = saturate((lighting.ggxDistributionTerm * lighting.smithGeometryTerm) / lighting.microfacetDenominator);
    
    lighting.specularReflectanceResult = Specular(
        lighting.normal, lighting.viewDir, lighting.lightDir, mat) * lighting.microfacetSpecularTerm;

    float angularTerm = pow(1.0 - saturate(dot(lighting.normal, lighting.lightDir)), 5.0);
    lighting.specularReflectanceResult *= angularTerm;

    float metallic = mat.metallic; // Material's metallic factor (0 for dielectrics, 1 for metals)
    float3 dielectricReflectance = float3(0.04, 0.04, 0.04); // F0 for dielectrics
    float3 metallicReflectance = mat.metallicReflectance; // RGB F0 for metals
    
    float3 F0 = CalculateF0(metallic, dielectricReflectance, metallicReflectance);

    lighting.CookTorrenceSpecular = CookTorranceSpecularPBR2(
        lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x, lighting.NdotV3, F0);
    
    lighting.CookTorrenceSpecular *= FresnelSchlickRoughness(lighting.internalFilmReflectanceReal,
        lighting.NdotV3, lighting.microfacetRoughness.x);
    
    // Lighting Calculations
    lighting.calculatedLightIntensity = CreateLighting(inputUV, GetSz_1(depthMap), lighting.viewPos, lighting.invertDepth, lighting.useProjectedDepth, parallaxScale, mat, lighting.normal, lighting.lightDir, lighting.viewDir, time, lighting.cosThetaTransmissionInsideReal,
        sssStrength, dispersionIndex);
   
    // Path Tracing Measurements
    lighting.viewToPixel = DistanceMFromViewToAB(lighting.viewPos, lighting.pixelPos, lighting.pixelPos + lighting.viewDir * mToNm(mat.thicknessM));
    lighting.calculatedLightIntensity *= saturate(1.0 / (1.0 + pow(length(lighting.viewToPixel.PathLengthM), 2.0)));
    // Initialize accumulated lighting
    lighting.lightingR = mat.albedo * saturate(lighting.NdotV3);
    lighting.lightingI = mat.albedo * saturate(lighting.NdotV3);
    
    lighting.lighting = mat.albedo * saturate(lighting.NdotV3);
    
    
    lighting.reflectanceReal[dispersionIndex] = max(ApplyReflectanceCoherence(
            lighting.reflectanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex], mat.coherenceLengthM
            ), EPSILON3);
        
    float reflectanceCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis
        ), 0.0);
        
    lighting.reflectanceReal[dispersionIndex] *= reflectanceCorrection;
        

        // Apply coherence to transmittance
    lighting.transmittanceReal[dispersionIndex] = max(ApplyTransmissionCoherence(
            lighting.transmittanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex],
            mat.coherenceLengthM
        ), EPSILON3);

// Apply angular correction to transmittance
    float transmittanceCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis
        ), 0.0);
    lighting.transmittanceReal[dispersionIndex] *= transmittanceCorrection;

        // Ensure energy conservation
    float3 totalLight = max(lighting.reflectanceReal[dispersionIndex], ZERO3) + max(lighting.transmittanceReal[dispersionIndex], ZERO3);
    if (any(totalLight > 1.0))
    {
        lighting.reflectanceReal[dispersionIndex] /= max(totalLight, EPSILON3);
        lighting.transmittanceReal[dispersionIndex] /= max(totalLight, EPSILON3);
    }
    

    // Loop over dispersionIndex
    
    lighting.opdAlbedoTransRealChannel[dispersionIndex] = OpticalPathDifference(
            lighting.albedoWavelengthsNM,
            lighting.nSurrounding,
            lighting.viewToPixel,
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient,
            lighting.cosThetaTransmissionInsideReal
        );

    lighting.opdAlbedoTransImagChannel[dispersionIndex] = OpticalPathDifference(
            lighting.albedoWavelengthsNM,
            lighting.nSurrounding,
            lighting.viewToPixel,
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient,
            lighting.cosThetaTransmissionInsideImag
        );

    lighting.reflectanceReal[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceReal + lighting.externalFilmReflectanceReal + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceReal * lighting.externalFilmReflectanceReal, float3(EPSILON3))) * sin(lighting.opdAlbedoTransRealChannel[dispersionIndex].phaseInterference.totalPhase)) *
            CoherenceFactor(lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                cos(lighting.opdAlbedoTransRealChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceReal,
                lighting.externalFilmReflectanceReal 
            )
        );
        
        
    lighting.reflectanceReal[dispersionIndex] =
            max(ApplyReflectanceCoherence(lighting.reflectanceReal[dispersionIndex], lighting.opdAlbedoTransRealChannel[dispersionIndex], mat.coherenceLengthM
            ), EPSILON3);
        // Apply angular correction to reflectance
    float reflectanceCorrection2 = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis
            ), 0.0);
    lighting.reflectanceReal[dispersionIndex] *= reflectanceCorrection2;
        

    lighting.reflectanceImag[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceImag + lighting.externalFilmReflectanceImag + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceImag * lighting.externalFilmReflectanceImag, float3(EPSILON3))) * sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)) *
            CoherenceFactor(lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceImag * InterferenceComplex(inputUV, time, lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.phaseShift.x, lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.phaseDifference.x),
                lighting.externalFilmReflectanceImag 
            )
        );
        // Calculate reflectance imaginary
    lighting.reflectanceImag[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceImag + lighting.externalFilmReflectanceImag +
             (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceImag * lighting.externalFilmReflectanceImag, float3(EPSILON3))) *
             sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)
            ) *
            CoherenceFactor(
                lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                mat.coherenceLengthM
            ) *
            PolarizationEffect3(
                sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceImag,
                lighting.externalFilmReflectanceImag
            )
        );
        // Apply refractive index correction
    lighting.reflectanceImag[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectImag[dispersionIndex], mat.opticalAxis
            ), ZERO3);
        
    lighting.reflectanceImag[dispersionIndex] =
            max(ApplyReflectanceCoherence(lighting.reflectanceImag[dispersionIndex], lighting.opdAlbedoTransImagChannel[dispersionIndex], mat.coherenceLengthM
            ), EPSILON3);
        // Apply angular correction to reflectance
    float reflectanceImagCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectImag[dispersionIndex], mat.opticalAxis
            ), 0.0);
    lighting.reflectanceImag[dispersionIndex] *= reflectanceImagCorrection;
        
    lighting.transmittanceReal[dispersionIndex] = saturate(ONE3 - max(lighting.reflectanceReal[dispersionIndex], ZERO3));

        
       // Apply coherence factor to transmittance
    lighting.transmittanceReal[dispersionIndex] *=
            max(CoherenceFactor(
                lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                    mat.coherenceLengthM
                ), ZERO3);


        // Apply refractive index correction for angular effects
    lighting.transmittanceReal[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis
            ), ZERO3);
       
         // Compute total energy and apply excess contribution
    float3 totalLight2 = max(lighting.reflectanceReal[dispersionIndex], ZERO3) + max(lighting.transmittanceReal[dispersionIndex], ZERO3);
    if (any(totalLight2 > 1.0))
    {
        totalLight2 = max(RedistributeExcessEnergy(totalLight2, max(lighting.reflectanceReal[dispersionIndex], ZERO3), max(lighting.transmittanceReal[dispersionIndex], ZERO3)), ZERO3);
        lighting.reflectanceReal[dispersionIndex] = totalLight2 * 0.5; // Redistributed reflectance
        lighting.transmittanceReal[dispersionIndex] = totalLight2 * 0.5; // Redistributed transmittance
    }
        
        
        // Calculate transmittance imaginary
    lighting.transmittanceImag[dispersionIndex] = saturate(ONE3 - max(lighting.reflectanceImag[dispersionIndex], ZERO3));
        
        // Apply absorption effect
    lighting.transmittanceImag[dispersionIndex] *= max(exp(-mat.absorptionCoefficient *
            lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM), ZERO3);
        
        
        // Apply coherence corrections
    lighting.transmittanceImag[dispersionIndex] *=
            max(CoherenceFactor(lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                mat.coherenceLengthM
        ), ZERO3);

        // Apply refractive index correction
    lighting.transmittanceImag[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex], mat.opticalAxis
        ), ZERO3);
        
        
        
        // Calculate interference intensity
    lighting.interferenceIntensity[dispersionIndex] = max(ComplexDot(
            lighting.totalReflectanceComplex[dispersionIndex],
            lighting.totalReflectanceComplex[dispersionIndex]
        ), ZERO3);

// Include interference effects in energy conservation
    float3 interferenceEnergy = max(lighting.interferenceIntensity[dispersionIndex], ZERO3) * saturate(lighting.albedo);
    lighting.reflectanceImag[dispersionIndex] += max(interferenceEnergy, ZERO3);
    lighting.transmittanceImag[dispersionIndex] = max(max(lighting.transmittanceImag[dispersionIndex], ZERO3) - interferenceEnergy, ZERO3);

        // Combine real and imaginary components for total energy
    float3 totalRealEnergy = max(lighting.reflectanceReal[dispersionIndex], ZERO3) + max(lighting.transmittanceReal[dispersionIndex], ZERO3);
        
    float3 totalImagEnergy = max(lighting.reflectanceImag[dispersionIndex], ZERO3) + max(lighting.transmittanceImag[dispersionIndex], ZERO3);

        // Ensure conservation for real components
    if (any(totalRealEnergy > 1.0))
    {
        lighting.reflectanceReal[dispersionIndex] /= max(totalRealEnergy, EPSILON3);
        lighting.transmittanceReal[dispersionIndex] /= max(totalRealEnergy, EPSILON3);
    }

// Ensure conservation for imaginary components
    if (any(totalImagEnergy > 1.0))
    {
        lighting.reflectanceImag[dispersionIndex] /= max(totalImagEnergy, EPSILON3);
        lighting.transmittanceImag[dispersionIndex] /= max(totalImagEnergy, EPSILON3);
    }
        
        
    lighting.effectiveRefractiveIndexReflectReal[dispersionIndex] = CalculateEffectiveRefractiveIndexReflectReal(
            lighting.lightDir,
            mat.opticalAxis,
            lighting.reflectanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex].refractiveIndex
        );
        
        
    lighting.effectiveRefractiveIndexReflectImag[dispersionIndex] = CalculateEffectiveRefractiveIndexReflectReal(
            lighting.lightDir,
            mat.opticalAxis,
            lighting.reflectanceImag[dispersionIndex],
            lighting.opdAlbedoTransImagChannel[dispersionIndex].refractiveIndex
        );
      
        
    lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex] = CalculateEffectiveRefractiveIndexTransmitReal(
            lighting.lightDir,
            mat.opticalAxis,
            lighting.transmittanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex].refractiveIndex
        );
        
        
    lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex] = CalculateEffectiveRefractiveIndexTransmitReal(
            lighting.lightDir,
            mat.opticalAxis,
            lighting.transmittanceImag[dispersionIndex],
            lighting.opdAlbedoTransImagChannel[dispersionIndex].refractiveIndex
        );
      
        
    lighting.reflectanceReal[dispersionIndex] *= EffectiveRefractiveIndexCorrection(lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis);
        
    lighting.transmittanceReal[dispersionIndex] *= EffectiveRefractiveIndexCorrection(lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis);

        // Depth calculations
    lighting.depth = depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth);
    lighting.invDepth01 = (1.0 - (lighting.depth / lighting.DepthScale));

        // Lambertian Diffuse BRDF
    lighting.diffuseRealTransmit[dispersionIndex] = MicrofacetBRDF1(
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
            lighting.nSurrounding, lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, mat.albedo, lighting.interferenceColor, sssStrength
        );

    lighting.diffuseImagTransmit[dispersionIndex] = MicrofacetBRDF1(
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
            lighting.nSurrounding, lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex], mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, mat.albedo, lighting.interferenceColor, sssStrength
        );

    lighting.diffuseRealReflect[dispersionIndex] = MicrofacetBRDF1(
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
            lighting.nSurrounding, lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, mat.albedo, lighting.interferenceColor, sssStrength
        );

    lighting.diffuseImagReflect[dispersionIndex] = MicrofacetBRDF1(
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
            lighting.nSurrounding, lighting.effectiveRefractiveIndexReflectImag[dispersionIndex], mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, mat.albedo, lighting.interferenceColor, sssStrength
        );
        
        // Combine lighting components
    lighting.lightingR =
            lerp(
            max(float3(EPSILON3), (lighting.diffuseRealTransmit[dispersionIndex] + lighting.transmittanceReal[dispersionIndex]) * lighting.NdotV3),
            max(float3(EPSILON3), (lighting.diffuseRealReflect[dispersionIndex] + lighting.reflectanceReal[dispersionIndex]) * (ONE3 - lighting.NdotV3)), ONE3 - lighting.NdotV3);

    lighting.lightingI = lerp(
            max(float3(EPSILON3), lighting.diffuseImagTransmit[dispersionIndex] + lighting.transmittanceImag[dispersionIndex]) * (ONE3 - lighting.NdotV3) * lighting.HdotL,
            max(float3(EPSILON3), (lighting.diffuseImagReflect[dispersionIndex] + lighting.reflectanceImag[dispersionIndex]) * (ONE3 - lighting.NdotV3)) * (ONE3 - lighting.HdotL),
            saturate((lighting.transmittanceImag[dispersionIndex] + lighting.transmittanceReal[dispersionIndex]) * (ONE3 - lighting.NdotV3))
        );
        
    lighting.fresnelReflectance = FresnelSchlickRoughness(lighting.internalFilmReflectanceReal, lighting.NdotV3, mat.metallic);
        
    lighting.fresnelReflectance *= pow(1.0 - saturate(dot(lighting.normal, lighting.viewDir)), 5.0);
        // Fresnel Reflection Modulating Specular and Interference Terms
    float3 fresnelTerm = lighting.fresnelReflectance;

// Specular Contribution (Cook-Torrance Model)
    float3 specularContribution = CookTorranceSpecularPBR(
            lighting.normal,
            lighting.viewDir,
            lighting.lightDir,
            mat.roughness,
            dot(lighting.normal, lighting.viewDir),
            mat.metallic
        ) * lighting.CookTorrenceSpecular;

// Interference Modulation
    float3 interferenceContribution = lighting.interferenceIntensity[dispersionIndex];
    float3 interferenceColor = lighting.interferenceColor * lighting.albedo * interferenceContribution;

// Diffuse Reflectance Contribution
    float3 diffuseReal = lighting.diffuseRealReflect[dispersionIndex];
    float3 diffuseImaginary = lighting.diffuseImagReflect[dispersionIndex];

// Accumulate Real and Imaginary Lighting Contributions
    lighting.lightingR += fresnelTerm * (diffuseReal + interferenceColor) + specularContribution;
    lighting.lightingI += fresnelTerm * diffuseImaginary + interferenceContribution;

// Normalize Lighting for Energy Conservation
    float3 totalEnergy = lighting.lightingR + lighting.lightingI;
    lighting.lightingR /= max(dot(totalEnergy, ONE3), EPSILON3);
    lighting.lightingI /= max(dot(totalEnergy, ONE3), EPSILON3);

        // Chromatic UV perturbation
    float2 chromaticOffset[3];
        [unroll(3)]
    for (int i = 0; i < 3; i++)
    {
        // Offset based on wavelength, time, and interference
        chromaticOffset[i] = sin(float2(time + i * 2.0, time - i * 2.0)) * 0.01 * (i + 1);
    }
        // Apply chromatic UV shifts
    float3 chromaticAlbedo = float3(
            diffuse2D(diffuseMap, inputUV + chromaticOffset[0]).r,
            diffuse2D(diffuseMap, inputUV + chromaticOffset[1]).g,
            diffuse2D(diffuseMap, inputUV + chromaticOffset[2]).b
        );

    lighting.albedo = chromaticAlbedo;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);

    lighting.etaR = mat.etaR;
    lighting.nSurrounding = ONE3 * mat.nSurrounding;

    // Add dynamic color shift based on angle and interference
    float3 dynamicShift = sin(lighting.viewDir * time * 10.0) * 0.05;
    lighting.albedo += dynamicShift;
    lighting.albedo = saturate(lighting.albedo);

        // Time-dependent chromatic interference
    float3 chromaticInterference = float3(
            sin(lighting.phaseShift[dispersionIndex][0] + time) * 0.5 + 0.5,
            sin(lighting.phaseShift[dispersionIndex][1] + time * 1.1) * 0.5 + 0.5,
            sin(lighting.phaseShift[dispersionIndex][2] + time * 1.2) * 0.5 + 0.5
        );

    // Apply chromatic interference to the lighting
    lighting.lightingR += chromaticInterference * lighting.albedo;
    lighting.lightingI += chromaticInterference * lighting.albedo;

    float3 totalLighting = lighting.lightingR + lighting.lightingI;
    totalLighting += RedistributeExcessEnergy(totalLighting, lighting.diffuseContribution[dispersionIndex], lighting.specularLighting);
    lighting.lighting = saturate(totalLighting);
        
    totalEnergy = lighting.lightingR + lighting.lightingI;
    lighting.lightingR /= max(dot(totalEnergy, ONE3), EPSILON3);
    lighting.lightingI /= max(dot(totalEnergy, ONE3), EPSILON3);

        
        // Add diffuse and interference contributions
    lighting.diffuseContribution[dispersionIndex] = lighting.diffuseRealTransmit[dispersionIndex];
    lighting.interferenceColor = CalculateInterference(lighting);
        
    lighting.specularLighting = lighting.CookTorrenceSpecular * lighting.fresnelReflectance;
        
        
    float gradientWeight = f4;
    float fresnelGlowWeight = f5;
    float fractalColorWeight = f6;
    float auroraColorWeight = f7;
    float subsurfaceColorWeight = f8;
    float causticColorWeight = f9;
        
    float diffuseWeight = 1.0 - mat.metallic;
    float specularWeight = mat.metallic;
    float3 accumulatedLighting = ZERO3;
        
        // Apply a rainbow-like gradient based on dispersion
    float3 rainbowGradient = float3(
            saturate(lighting.albedo.r * 0.8 + sin(dispersionIndex * 2.0 + time)),
            saturate(lighting.albedo.g * 0.8 + sin(dispersionIndex * 2.0 + time * 1.1)),
            saturate(lighting.albedo.b * 0.8 + sin(dispersionIndex * 2.0 + time * 1.2))
        ) * gradientWeight;
    float2 anisotropicFactors = float2(f1, f2); // Controls anisotropic shape
    float anisotropicDot = saturate(dot(lighting.normal, lighting.lightDir) * anisotropicFactors.x + dot(ToTangentSpace11(CalcTBN(lighting.normal)[0]),
        (lighting.lightDir) * anisotropicFactors.y));
    float3 anisotropicHighlight = specularWeight * pow(anisotropicDot, mat.roughness * 128.0);
    lighting.lighting += anisotropicHighlight;
    lighting.diffuseRealTransmit[dispersionIndex] += anisotropicHighlight * diffuseWeight;
    lighting.interferenceColor += anisotropicHighlight;
        
    lighting.diffuseRealTransmit[dispersionIndex] += rainbowGradient * diffuseWeight;
    lighting.interferenceColor += rainbowGradient;
    lighting.lighting += rainbowGradient;
        
    float3 fresnel = pow(1.0 - abs(lighting.NdotV3), 3.0);
    float3 fresnelGlow = fresnel * float3(0.3, 0.6, 1.0) * fresnelGlowWeight; // Blue glow
    lighting.lighting += fresnelGlow;
    lighting.diffuseRealTransmit[dispersionIndex] += fresnelGlow * diffuseWeight;
    lighting.interferenceColor += fresnelGlow;

// Apply Fractal Noise Glow
    float fractalIntensity = FractalNoise(inputUV, time);
    float3 fractalColor = float3(1.0, 0.6, 0.3) * pow(fractalIntensity, 2.0) * fractalColorWeight; // Orange glow
    lighting.lighting += fractalColor;
    lighting.diffuseRealTransmit[dispersionIndex] += fractalColor * diffuseWeight;
    lighting.interferenceColor += fractalColor;
        // Ensure energy conservation
        
        
        // Aurora Bands
    float auroraBand = sin(inputUV.x * 10.0 + time) * 0.5 + 0.5;
    float auroraWave = sin(inputUV.y * 15.0 - time * 1.2) * 0.5 + 0.5;

// Aurora Colors (Dynamic Gradient)
    float3 auroraColor = lerp(float3(0.2, 0.8, 1.0), float3(1.0, 0.5, 0.9), auroraBand);
    auroraColor *= pow(auroraWave, 2.0); // Enhance intensity

// Flowing Effect
    float auroraFlow = sin(inputUV.x * 30.0 + time * 3.0) * 0.2 + 0.2;
    auroraColor *= auroraFlow;
    auroraColor *= auroraColorWeight;
// Add Aurora to Lighting
    lighting.lighting += auroraColor;
    lighting.diffuseRealTransmit[dispersionIndex] += auroraColor * diffuseWeight;
    lighting.interferenceColor += auroraColor;
        // Depth-Based Subsurface Effect
    float scatterFactor = saturate(1.0 - lighting.depth / lighting.DepthScale); // More scattering for closer surfaces
    float3 subsurfaceColor = float3(ct01, 0.8, 0.6) * scatterFactor; // Warm diffusion color

// Add wavelength variation
    subsurfaceColor *= float3(1.0 + 0.1 * sin(lighting.depth), 1.0, 1.0 - 0.1 * sin(lighting.depth)); // Shift based on depth
    subsurfaceColor *= subsurfaceColorWeight;
        
// Apply to lighting
    lighting.lighting += subsurfaceColor;
    lighting.diffuseRealTransmit[dispersionIndex] += subsurfaceColor * diffuseWeight;
    lighting.interferenceColor += subsurfaceColor;
        
        // Caustic Pattern with Depth
    float causticPattern = abs(sin(inputUV.x * 20.0 + lighting.depth * 5.0 + time * 2.0));
    float causticDepthFactor = saturate(1.0 - lighting.depth / lighting.DepthScale);

        // Wavelength-Dependent Caustics
    float3 causticColor = float3(
            causticPattern * pow(lighting.albedoWavelengthsNM.r / 700.0, -2.0), // Red
            causticPattern * pow(lighting.albedoWavelengthsNM.g / 540.0, -2.0), // Green
            causticPattern * pow(lighting.albedoWavelengthsNM.b / 480.0, -2.0) // Blue
        );

        // Modulate with Depth
    causticColor *= causticDepthFactor;
    causticColor *= causticColorWeight;
        
        // Add to Lighting
    lighting.lighting += causticColor;
    lighting.diffuseRealTransmit[dispersionIndex] += causticColor * diffuseWeight;
    lighting.interferenceColor += causticColor;
        
        
        
    totalLighting = lighting.lightingR + lighting.lightingI;
    totalLighting += RedistributeExcessEnergy(totalLighting, lighting.diffuseContribution[dispersionIndex], lighting.specularLighting);
    lighting.lighting = saturate(totalLighting);
        
        
    accumulatedLighting +=
                diffuseWeight * lighting.diffuseRealTransmit[dispersionIndex] +
            lighting.diffuseRealReflect[dispersionIndex] +
            +specularWeight * lighting.specularReflectanceResult +
            lighting.interferenceIntensity[dispersionIndex] * lighting.albedo;
        
    lighting.lighting += accumulatedLighting; // Average contributions
        // Add Fresnel reflectance to diffuse and interference contributions
        
    lighting.lighting += lighting.fresnelReflectance * lighting.CookTorrenceSpecular;

    float totalParallaxWeight = max(ParallaxFactorA + ParallaxFactorB + ParallaxFactorC, EPSILON);
    lighting.lighting += (
        (lighting.specularLighting * ParallaxFactorA / totalParallaxWeight) +
        (lighting.diffuseContribution[dispersionIndex] * ParallaxFactorB / totalParallaxWeight) +
        (lighting.interferenceColor * ParallaxFactorC / totalParallaxWeight)
    );

        
       // Accumulate final lighting with redistributed energy
    totalLighting = lighting.lightingR + lighting.lightingI;
    totalLighting += RedistributeExcessEnergy(totalLighting, lighting.diffuseContribution[dispersionIndex], lighting.specularLighting);

        // Apply tone mapping and gamma adjustments
    totalLighting = ReinhardToneMapping(totalLighting * lighting.Config_Exposure * 2.0);
    totalLighting = AdjustGamma(totalLighting, lighting.Config_Gamma);
    totalLighting = AdjustSaturation(totalLighting, lighting.Config_Saturation);

        // Assign to the final lighting output
    lighting.lighting = saturate(totalLighting);


    lighting.renderLayer = lighting.lightingR + lighting.lightingI + lighting.diffuseContribution[dispersionIndex] +
            lighting.interferenceColor;
        /*
        // Render Layers
        lighting.renderLayer = RenderLayers(
            FILM_TYPE_HOLOGRAPHIC,
            lighting.viewPos,
            lighting.pixelPos,
            inputUV,
            lighting.depth,
            time,
            nmToM(RGBToWavelengthsNM(lighting.albedo)),
            lighting.viewDir,
            lighting.lightDir,
            lighting.normal,
            lighting.lighting,
            float2(LookAtX, LookAtY),
            distance(float2(LookAtX, LookAtY), lighting.pixelPos.xy),
            lighting.nSurrounding,
            lighting.invertDepth,
            lighting.useProjectedDepth,
            mat, FresnelMix
        );
        */
        // Accumulate lighting results into the final render layer
        // This accumulation might need to be handled outside the function depending on your design
    

    return lighting;
}

void ApplyChromaticAlbedo(float chromaOffsetScale, float chromaOffsetShiftScale, Texture2D<float4> diffuseMap, float time, float2 inputUV, inout LightingComplex lighting)
{
    // Chromatic UV perturbation
    float2 chromaticOffset[3];
    [unroll(3)]
    for (int i = 0; i < 3; i++)
    {
    // Offset based on wavelength, time, and interference
        chromaticOffset[i] = sin(float2(time + i * 2.00,  time - i * 2.0)) * 0.01 * (i + 1);
    }

// Apply chromatic UV shifts to albedo
    float3 chromaticAlbedo = float3(
        diffuse2D(diffuseMap, inputUV + chromaticOffset[0] * chromaOffsetScale).r,
        diffuse2D(diffuseMap, inputUV + chromaticOffset[1] * chromaOffsetScale).g,
        diffuse2D(diffuseMap, inputUV + chromaticOffset[2] * chromaOffsetScale).b
    );

    // Adjust lighting with chromatic albedo
    lighting.albedo = chromaticAlbedo;
   
    // Dynamic angle-based shift
    float3 dynamicShift = sin(lighting.albedo + time * 10.0) * chromaOffsetShiftScale;
    lighting.albedo += dynamicShift;
    lighting.albedo = saturate(lighting.albedo);
    
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);

}

void ChromaticInterference(float diffuseWeight, float chromaWeight, float time, int dispersionIndex, inout
LightingComplex lighting)
{
    // Time-dependent chromatic interference
    Complex3 chromaticInterference = ComplexCreate(
        float3(
            cos(lighting.phaseShift[dispersionIndex].real[0] +time) * 0.5 + 0.5,
            cos(lighting.phaseShift[dispersionIndex].real[1] + time * 1.1) * 0.5 + 0.5,
            cos(lighting.phaseShift[dispersionIndex].real[2] + time * 1.2) * 0.5 + 0.5
        ),
        float3(
            sin(lighting.phaseShift[dispersionIndex].imag[0] + time) * 0.5 + 0.5,
            sin(lighting.phaseShift[dispersionIndex].imag[1] + time * 1.1) * 0.5 + 0.5,
            sin(lighting.phaseShift[dispersionIndex].imag[2] + time * 1.2) * 0.5 + 0.5
        )
    );

// Combine with lighting
    //lighting.lighting[dispersionIndex] = ComplexAdd(lighting.lighting[dispersionIndex], ComplexMulCf(chromaticInterference, float3(chromaWeight, chromaWeight, chromaWeight)));
    //lighting.diffuseTransmittance[dispersionIndex] = ComplexAdd(lighting.diffuseTransmittance[dispersionIndex], ComplexMulCf(ComplexMulCf(chromaticInterference, float3(chromaWeight, chromaWeight, chromaWeight)), float3(diffuseWeight, diffuseWeight, diffuseWeight)));
    Complex3 pss[3] = lighting.interferenceContribution;
    pss[dispersionIndex] = ComplexAdd(lighting.interferenceContribution[dispersionIndex], ComplexMulCf(chromaticInterference, float3(chromaWeight, chromaWeight, chromaWeight)));
    lighting.interferenceContribution = pss;

}

void GradientEffects(float2 anisotropicFactors, float diffuseWeight, float specularWeight, float gradientWeight, float time, int dispersionIndex, inout LightingComplex lighting)
{
// Anisotropic highlights based on lighting direction
    
    float anisotropicDot = saturate(
        dot(lighting.normal, lighting.lightDir) * anisotropicFactors.x +
        dot(ToTangentSpace11(CalcTBN(lighting.normal)[0]), (lighting.lightDir) * anisotropicFactors.y)
    );
    float3 anisotropicHighlight = specularWeight * pow(anisotropicDot, lighting.material.roughness * 128.0);

    // Combine with lighting
   // lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], anisotropicHighlight);
    //lighting.diffuseTransmittance[dispersionIndex] = ComplexAddCf(lighting.diffuseTransmittance[dispersionIndex], anisotropicHighlight * diffuseWeight);
    Complex3 pss[3] = lighting.interferenceContribution;
    pss[dispersionIndex]  = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], anisotropicHighlight);
    lighting.interferenceContribution = pss;
    
    // Apply a rainbow-like gradient based on dispersion
    float3 rainbowGradient = float3(
        saturate(lighting.albedo.r * 0.8 + sin((1.0 + dispersionIndex) * 2.0 + time)),
        saturate(lighting.albedo.g * 0.8 + sin((1.0 + dispersionIndex) * 2.0 + time * 1.1)),
        saturate(lighting.albedo.b * 0.8 + sin((1.0+dispersionIndex) * 2.0 + time * 1.2))
    ) * gradientWeight;

    // Add rainbow gradient
    //lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], rainbowGradient);
    pss = lighting.interferenceContribution;
    pss[dispersionIndex]  = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], rainbowGradient);
    lighting.interferenceContribution = pss;
    //lighting.interferenceContribution[dispersionIndex] = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], rainbowGradient);
   
    
}

void FractalAurora(float auroraColorWeight, float diffuseWeight, float fractalColorWeight, float2 inputUV, float time, int dispersionIndex, inout LightingComplex lighting)
{
    // Fractal Noise Glow
    float fractalIntensity = FractalNoise(inputUV, time * dot(lighting.normal, lighting.viewDir));
    float3 fractalColor = float3(1.0, 0.6, 0.3) * pow(fractalIntensity, 2.0) * fractalColorWeight; // Orange glow
   // lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], fractalColor);
    Complex3 pss[3] = lighting.diffuseTransmittance;
    pss[dispersionIndex]  = ComplexAddCf(lighting.diffuseTransmittance[dispersionIndex], fractalColor * diffuseWeight);
    lighting.diffuseTransmittance = pss;
    
    pss = lighting.interferenceContribution;
    pss[dispersionIndex]  = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], fractalColor);
    lighting.interferenceContribution = pss;
    
    // Aurora Bands
    float auroraBand = sin(inputUV.x * 10.0 + time) * 0.5 + 0.5;
    float auroraWave = sin(inputUV.y * 15.0 + time * 1.2) * 0.5 + 0.5;

    // Aurora Colors (Dynamic Gradient)
    float3 auroraColor = lerp(float3(0.2, 0.8, 1.0), float3(1.0, 0.5, 0.9), auroraBand);
    auroraColor *= pow(auroraWave, 2.0); // Enhance intensity

    // Flowing Effect
    float auroraFlow = sin(inputUV.x * 30.0 + time * 3.0) * 0.2 + 0.2;
    auroraColor *= auroraFlow;
    auroraColor *= auroraColorWeight;

    // Add Aurora to Lighting
   // lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], auroraColor);
    pss = lighting.diffuseTransmittance;
    pss[dispersionIndex]  = ComplexAddCf(lighting.diffuseTransmittance[dispersionIndex], auroraColor * diffuseWeight);
    lighting.diffuseTransmittance = pss;
    //lighting.interferenceContribution[dispersionIndex] = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], auroraColor);
    
}

void ScatterCaustics(float causticColorWeight, float subsurfaceColorWeight, float diffuseWeight, float2 inputUV, float time, int dispersionIndex, inout LightingComplex lighting)
{
    // Depth-Based Subsurface Scattering
    float scatterFactor = saturate(1.0 - lighting.depth / lighting.DepthScale); // More scattering for closer surfaces
    float3 subsurfaceColor = float3(ct01, 0.8, 0.6) * scatterFactor; // Warm diffusion color

    // Wavelength variation for depth
    subsurfaceColor *= float3(1.0 + 0.1 * sin(lighting.depth), 1.0, 1.0 - 0.1 * sin(lighting.depth));
    subsurfaceColor *= subsurfaceColorWeight;

    // Apply to lighting
   // lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], subsurfaceColor);
    Complex3 pss[3] = lighting.diffuseTransmittance;
    pss[dispersionIndex]  = ComplexAddCf(lighting.diffuseTransmittance[dispersionIndex], subsurfaceColor * diffuseWeight);
    lighting.diffuseTransmittance = pss;
    //lighting.interferenceContribution[dispersionIndex] = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], subsurfaceColor);

    // Depth-Based Caustics
    float causticPattern = abs(sin(inputUV.x * 20.0 + lighting.depth * 5.0 + time * 2.0));
    float causticDepthFactor = saturate(1.0 - lighting.depth / lighting.DepthScale);

// Wavelength-Dependent Caustics
    float3 causticColor = float3(
        causticPattern * pow(lighting.albedoWavelengthsNM.r / 700.0, -2.0), // Red
        causticPattern * pow(lighting.albedoWavelengthsNM.g / 540.0, -2.0), // Green
        causticPattern * pow(lighting.albedoWavelengthsNM.b / 480.0, -2.0) // Blue
    );

// Modulate with Depth
    causticColor *= causticDepthFactor;
    causticColor *= causticColorWeight;

// Add to Lighting
   // lighting.lighting[dispersionIndex] = ComplexAddCf(lighting.lighting[dispersionIndex], causticColor);
    //lighting.diffuseTransmittance[dispersionIndex] = ComplexAddCf(lighting.diffuseTransmittance[dispersionIndex], causticColor * diffuseWeight);
    pss = lighting.interferenceContribution;
    pss[dispersionIndex]  = ComplexAddCf(lighting.interferenceContribution[dispersionIndex], causticColor);
    lighting.interferenceContribution = pss;

}

LightingComplex PopulateLightingComplex(
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth, bool useProjectedDepth,
    float depthScale,
    float2 depthRange,
    int materialIndex,
    float animateSpeed,
    float parallaxScale,
    float normalRadius, float sssStrength, int dispersionIndex,
    float gamma, float exposure, float saturation,
    inout float3 test
)
{
    LightingComplex lighting = (LightingComplex) 0;
    
    // Configuration
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.DepthScale = depthScale;
    lighting.DepthRange = depthRange;
      // Normal, View, and Light Directions
    lighting.normal = normal2D11W(normalMap, inputUV, normalRadius, false);
    lighting.viewPos = viewPos;
    lighting.lightPos = lightPos;
    lighting.viewDir = normalize(lighting.viewPos - float3(inputUV, lighting.depth));
    lighting.lightDir = normalize(lighting.lightPos - float3(inputUV, lighting.depth));
    lighting.halfDir = normalize(lighting.viewDir + lighting.lightDir);

    lighting.depth = depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth);
    // Material Initialization
    MaterialSellmeier mat = CreateMaterial(materialIndex);
    mat.albedo = lerp(diffuse2D(diffuseMap, inputUV).rgb, 1.0 - diffuse2D(diffuseMap, inputUV).rgb, dot(lighting.normal, lighting.viewDir)) * dot(lighting.normal, lighting.viewDir);
    lighting.material = mat;

    float diffuseWeight = f1;
    float chromaWeight = f2;
    float specularWeight = f3;
    float gradientWeight = f4;
    float auroraWeight = f5;
    float fractalColorWeight = f6;
    float causticColorWeight = f7;
    float subsurfaceColorWeight = PhaseOffsetR;
    float2 anisotropicFactors = float2(PhaseOffsetG, PhaseOffsetB);
    float chromaOffsetScale = HeightParamB * (1 - lighting.depth);
    float chromaOffsetShiftScale = HeightParamC;
    
    // Wavelength and Depth Initialization
    lighting.albedo = mat.albedo;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);
    
    float time = TotalTime * animateSpeed;


    ApplyChromaticAlbedo(chromaOffsetScale, chromaOffsetShiftScale, diffuseMap, time, inputUV, lighting);
    
  
    // Dot Products
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.NdotV3 = saturate(dot3(lighting.viewDir, lighting.normal));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    lighting.NdotL3 = saturate(dot3(lighting.lightDir, lighting.normal));

    lighting.nSurrounding = float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding);
    
    
    // Phase Shift (Real and Imaginary)
    
    Complex3 ps = ComplexCreate(TWOPI * (1.0 - lighting.depth) / lighting.albedoWavelengthsM, mat.absorptionCoefficient * (1.0 - lighting.depth));
    Complex3 pss[3] = lighting.phaseShift;
    pss[dispersionIndex] = ps;
    lighting.phaseShift = pss;
    
    // Total Reflectance with Interference
    lighting.internalReflectance = ComplexMul(ComplexCreate(lighting.albedo, ZERO3),
    FresnelComplex(
        ComplexCreate(mat.etaR, ZERO3), lighting.normal, lighting.lightDir
    ));
    lighting.externalReflectance = ComplexMul(ComplexCreate(lighting.albedo, ZERO3),
    FresnelComplex(
        ComplexCreate(mat.nSurrounding, ZERO3), lighting.normal, lighting.lightDir
    ));

    pss = lighting.totalReflectance;
    pss[dispersionIndex] = ComplexAdd(
        lighting.internalReflectance,
        ComplexMul(
            lighting.externalReflectance,
            ComplexExp(lighting.phaseShift[dispersionIndex])
        )
    );
    lighting.totalReflectance = pss;
    
    float3 fss[3] = lighting.interferenceIntensity;
    fss[dispersionIndex] = ComplexDot(
        lighting.totalReflectance[dispersionIndex], lighting.totalReflectance[dispersionIndex]
    );
    lighting.interferenceIntensity = fss;
    
    
    // Microfacet Terms (GGX and Geometry)
    lighting.microfacetRoughness = float2(mat.roughness, mat.roughness);
    lighting.ggxDistribution = DistributionGGX(
        lighting.normal, lighting.halfDir, lighting.microfacetRoughness.x
    );
    lighting.smithGeometry = GeometrySmithNVLf(
        lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x
    );

    lighting.microfacetSpecular = saturate(
        (lighting.ggxDistribution * lighting.smithGeometry) / max(4.0 * lighting.NdotV3, EPSILON3)
    );

    // Dielectric and Metallic Reflectance
    lighting.dielectricReflectance = float3(0.04, 0.04, 0.04); // Default F0 for dielectrics
    lighting.metallicReflectance = mat.metallicReflectance;

    float3 F0 = CalculateF0(mat.metallic, lighting.dielectricReflectance, lighting.metallicReflectance);

    // Cook-Torrence Specular
    lighting.cookTorrenceSpecular = CookTorranceSpecularPBR(
        lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness, F0, mat.metallic
    );

    
    
    // Fresnel Reflectance for Internal and External Boundaries
    lighting.internalFilmReflectance = ComplexCreate(float3(FresnelReflectanceFromFilm2(
        lighting.nSurrounding, mat.etaR, lighting.NdotL3, lighting.cosThetaTransmissionInside.real
    )), float3(FresnelReflectanceFromFilm2(
        lighting.nSurrounding, mat.etaI, lighting.NdotL3, lighting.cosThetaTransmissionInside.imag
    )));

    lighting.externalFilmReflectance = ComplexCreate(float3(FresnelReflectanceFromFilm2(
        mat.etaR, lighting.nSurrounding, lighting.NdotL3, lighting.cosThetaTransmissionOutside.real
    )), FresnelReflectanceFromFilm2(lighting.material.etaI, lighting.nSurrounding, lighting.NdotL3, lighting.cosThetaTransmissionOutside.imag));
    
    // Polarization and Coherence
    lighting.polarization = ComplexCreate(
        PolarizationEffect3(
        cos( lighting.phaseShift[dispersionIndex].real), lighting.internalFilmReflectance.real, lighting.externalFilmReflectance.real
    ), PolarizationEffect3(
        sin(lighting.phaseShift[dispersionIndex].imag), lighting.internalFilmReflectance.imag, lighting.externalFilmReflectance.imag
    ));

    lighting.coherence = CoherenceFactor(
        lighting.depth, mat.coherenceLengthM
    );
    
    
    // Reflectance and Transmittance Corrections
    pss = lighting.reflectance;
    pss[dispersionIndex] = ComplexCreate(max(
        ApplyReflectanceCoherence(lighting.internalFilmReflectance.real,
            OpticalPathDifference(
                lighting.albedoWavelengthsNM, lighting.nSurrounding,
                    DifferenceMPathFromPointThicknessM(
                        lighting.viewPos, lighting.pixelPos, mat.thicknessM, lighting.normal),
                mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient,
                lighting.cosThetaTransmissionInside.real),
            length(lighting.coherence)
        ),
        EPSILON3), 
        max(
            ApplyReflectanceCoherence(lighting.internalFilmReflectance.imag,
                OpticalPathDifference(
                    lighting.albedoWavelengthsNM, lighting.nSurrounding,
                        DifferenceMPathFromPointThicknessM(
                            lighting.viewPos, lighting.pixelPos, mat.thicknessM, lighting.normal),
                    mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient,
                    lighting.cosThetaTransmissionInside.imag),
                length(lighting.coherence)
        ),
        EPSILON3)
    );
    lighting.reflectance = pss;
    
    
    pss = lighting.transmittance;
    pss[dispersionIndex]  = ComplexCreate(saturate(
        ONE3 - max(lighting.reflectance[dispersionIndex].real, ZERO3)
    ), ONE3 - max(lighting.reflectance[dispersionIndex].imag, ZERO3));
    lighting.transmittance = pss;
    
    // Energy Conservation
    float3 totalEnergy = max(
        lighting.reflectance[dispersionIndex].real + lighting.reflectance[dispersionIndex].imag, ZERO3
    ) + max(lighting.transmittance[dispersionIndex].real + lighting.transmittance[dispersionIndex].imag, ZERO3);

    if (any(totalEnergy > 1.0))
    {
        pss = lighting.reflectance;
        pss[dispersionIndex]  = ComplexDivCf(lighting.reflectance[dispersionIndex], totalEnergy);
        lighting.reflectance = pss;
        pss = lighting.transmittance;
        pss[dispersionIndex]  = ComplexDivCf(lighting.transmittance[dispersionIndex], totalEnergy);
        lighting.transmittance = pss;
    }

    // Calculate Final Lighting (Complex)
    pss = lighting.lighting;
    pss[dispersionIndex]  = ComplexCreateCf(
        ComplexMulCf(lighting.reflectance[dispersionIndex], lighting.albedo),
            (lighting.interferenceIntensity[dispersionIndex] * lighting.albedo));
    lighting.lighting = pss;
    
    lighting.interferenceColorReflectance = ComplexCreate(
        lighting.albedo * InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM, mat.thicknessM, mat.etaR, lighting.cosThetaTransmissionInside.imag, lighting.nSurrounding),
        lighting.albedo * InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM, mat.thicknessM, mat.etaI, lighting.cosThetaTransmissionOutside.imag, lighting.nSurrounding));
    
    lighting.interferenceColorTransmittance = ComplexCreate(
        lighting.albedo * InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM, mat.thicknessM, mat.etaR, lighting.cosThetaTransmissionInside.real, lighting.nSurrounding),
        lighting.albedo * InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM, mat.thicknessM, mat.etaI, lighting.cosThetaTransmissionOutside.real, lighting.nSurrounding));
    
    pss = lighting.interferenceContribution;
    pss[dispersionIndex]  = ComplexAdd(
        ComplexMul(
            lighting.diffuseReflectance[dispersionIndex],
            lighting.interferenceColorReflectance
        ),
        ComplexMul(
            lighting.diffuseTransmittance[dispersionIndex],
            lighting.interferenceColorTransmittance
        ));
    lighting.interferenceContribution = pss;
    
    
    // Diffuse Transmittance Contributions
    pss = lighting.diffuseTransmittance;
    pss[dispersionIndex]  = ComplexCreate(
        MicrofacetBRDF1(
            mat, inputUV, time, lighting.transmittance[dispersionIndex].real, lighting.normal,
            lighting.viewDir, lighting.lightDir, lighting.nSurrounding,
            lighting.material.etaR, mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex,
            lighting.albedo, lighting.interferenceContribution[dispersionIndex].real, sssStrength
        ),
        MicrofacetBRDF1(
            mat, inputUV, time, lighting.transmittance[dispersionIndex].imag, lighting.normal,
            lighting.viewDir, lighting.lightDir, lighting.nSurrounding,
            lighting.material.etaI, mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex,
            lighting.albedo, lighting.interferenceContribution[dispersionIndex].imag, sssStrength
        )
    );
    lighting.diffuseTransmittance = pss;
    
    
    // Diffuse Reflectance Contributions
    pss = lighting.diffuseReflectance;
    
    pss[dispersionIndex]  = ComplexCreate(
        MicrofacetBRDF1(
            mat, inputUV, time, lighting.reflectance[dispersionIndex].real, lighting.normal,
            lighting.viewDir, lighting.lightDir, lighting.nSurrounding,
            lighting.material.etaR, mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex,
            lighting.albedo, lighting.interferenceContribution[dispersionIndex].real, sssStrength
        ),
        MicrofacetBRDF1(
            mat, inputUV, time, lighting.reflectance[dispersionIndex].imag, lighting.normal,
            lighting.viewDir, lighting.lightDir, lighting.nSurrounding,
            lighting.material.etaI, mToNm(mat.thicknessM),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex,
            lighting.albedo, lighting.interferenceContribution[dispersionIndex].imag, sssStrength
        )
    );
    lighting.diffuseReflectance = pss;
    
    pss = lighting.specularContribution;
    
    pss[dispersionIndex]  = ComplexMul(
        lighting.diffuseReflectance[dispersionIndex],
        ComplexAdd(ComplexCreate(lighting.cookTorrenceSpecular, ZERO3),
            ComplexCreate(lighting.microfacetSpecular, ZERO3))
    );
    lighting.specularContribution = pss;
    
    GradientEffects(anisotropicFactors, diffuseWeight, specularWeight, gradientWeight, time, dispersionIndex, lighting);
    ChromaticInterference(diffuseWeight, chromaWeight, time, dispersionIndex, lighting);
    FractalAurora(auroraWeight, diffuseWeight, fractalColorWeight, inputUV, time, dispersionIndex, lighting);
    ScatterCaustics(causticColorWeight, subsurfaceColorWeight, diffuseWeight, inputUV, time, dispersionIndex, lighting);
    
    Complex3 lt[3] = lighting.lighting;
    Complex3 diffuse[3] = lighting.diffuseTransmittance;
    Complex3 specular[3] = lighting.specularContribution;
    Complex3 interferenceContribution[3] = lighting.interferenceContribution;
    RedistributeExcessEnergyComplex(
        lt[dispersionIndex],
        diffuse[dispersionIndex],
        specular[dispersionIndex],
        interferenceContribution[dispersionIndex]);
    lighting.lighting = lt;
    lighting.diffuseTransmittance = diffuse;
    lighting.specularContribution=specular;
    lighting.interferenceContribution = interferenceContribution;
    
    Complex3 reflectance[3] = lighting.totalReflectance;
    reflectance[dispersionIndex]  = ComplexMul(
        lighting.diffuseReflectance[dispersionIndex],
        ComplexAdd(lighting.specularContribution[dispersionIndex], lighting.interferenceContribution[dispersionIndex]));
    lighting.totalReflectance = reflectance;
    
    // Extract Real Part for Tone Mapping
    float3 finalLightingReal = lighting.lighting[dispersionIndex].real * lighting.lighting[dispersionIndex].imag;

    // Tone Mapping, Gamma Correction, and Saturation
    float3 totalLighting = ReinhardToneMapping(finalLightingReal * lighting.Config_Exposure);
    totalLighting = AdjustGamma(totalLighting, lighting.Config_Gamma);
    totalLighting = AdjustSaturation(totalLighting, lighting.Config_Saturation);

    fss = lighting.totalLighting;
    fss[dispersionIndex]  = totalLighting;
    lighting.totalLighting = fss;;

    return lighting;
}


/* Corrected Parallax Occlusion Mapping Function
inline ParallaxOcclusionResult ParallaxOcclusion4(
    Texture2D<float> depthMap,
    float2 inputUV,
    float2 parallaxDir,
    bool invertDepth,
    bool useProjectedDepth)
{
    ParallaxOcclusionResult ret;

    float numLayers = 10.0;
    float layerDepth = 1.0 / numLayers;

    // Compute the per-layer UV offset
    float2 deltaUVBase = parallaxDir / numLayers;

    // Initialize current UV and layer depth
    float2 currentUV = inputUV;
    float currentLayerDepth = 0.0;

    // Sample the initial depth value
    float currentDepthMapValue = depth2D(depthMap, currentUV, invertDepth, useProjectedDepth);

    // Store previous UV and depth values
    float2 prevUV = currentUV;
    float prevLayerDepth = currentLayerDepth;
    float prevDepthMapValue = currentDepthMapValue;

    float stop = 0.0;

    // Coarse Search Phase
    [loop]
    for (int i = 0; i < (int) numLayers; i++)
    {
        // Advance to the next layer
        float2 nextUV = currentUV + deltaUVBase * (1.0 - stop);
        float nextLayerDepth = currentLayerDepth + layerDepth;
        float nextVal = depth2D(depthMap, nextUV, invertDepth, useProjectedDepth);

        // Determine if we've found the intersection
        float found = step(nextLayerDepth, nextVal); // 1 if nextLayerDepth <= nextVal
        float notFound = 1.0 - found;

        // Update previous values if intersection is found
        prevUV = lerp(prevUV, currentUV, found);
        prevLayerDepth = lerp(prevLayerDepth, currentLayerDepth, found);
        prevDepthMapValue = lerp(prevDepthMapValue, currentDepthMapValue, found);

        // Update current values
        currentUV = lerp(nextUV, currentUV, found);
        currentLayerDepth = lerp(nextLayerDepth, currentLayerDepth, found);
        currentDepthMapValue = lerp(nextVal, currentDepthMapValue, found);

        // Update the stop flag
        stop = max(stop, found);

        // Freeze deltaUVBase if intersection is found
        deltaUVBase *= notFound;
    }

    // Binary Refinement Phase
    float2 midUV = (prevUV + currentUV) * 0.5;
    float midLayerDepth = (prevLayerDepth + currentLayerDepth) * 0.5;
    float midVal = depth2D(depthMap, midUV, invertDepth, useProjectedDepth);

    [loop]
    for (int j = 0; j < 15; j++)
    {
        // Determine if the midpoint is an intersection
        float found = step(midLayerDepth, midVal);
        float notFound = 1.0 - found;

        // Update previous or current based on the intersection
        prevUV = lerp(prevUV, midUV, found);
        prevLayerDepth = lerp(prevLayerDepth, midLayerDepth, found);
        prevDepthMapValue = lerp(prevDepthMapValue, midVal, found);

        // Recompute the midpoint
        midUV = (prevUV + currentUV) * 0.5;
        midLayerDepth = (prevLayerDepth + currentLayerDepth) * 0.5;
        midVal = depth2D(depthMap, midUV, invertDepth, useProjectedDepth);
    }

    // Calculate the final UV offset
    float depthDifference = prevDepthMapValue - prevLayerDepth;
    float layerDifference = prevLayerDepth - currentLayerDepth;
    float weight = clamp(depthDifference / max(depthDifference + layerDifference, 1e-6), 0.0, 1.0);
    float2 finalUV = lerp(prevUV, midUV, weight);

    // Set the deltaUV result
    ret.deltaUV = finalUV - inputUV;

    return ret;
}
inline ParallaxOcclusionResult ParallaxOcclusion5(
    Texture2D<float> depthMap,
    float2 inputUV,
    float2 parallaxDir, bool invertDepth, bool useProjectedDepth, float time)
{
    ParallaxOcclusionResult ret;

    float numLayers = 10.0;
    float layerDepth = 1.0 / numLayers;

    // Compute the per-layer UV offset
    float2 deltaUVBase = parallaxDir / numLayers;

    // Initialize current UV and layer depth
    float2 currentUV = inputUV;
    float currentLayerDepth = 0.0;

    // Sample the initial depth value
    float currentDepthMapValue = depth2D(depthMap, currentUV, invertDepth, useProjectedDepth);

    // Store previous UV and depth values
    float2 prevUV = currentUV;
    float prevLayerDepth = currentLayerDepth;
    float prevDepthMapValue = currentDepthMapValue;

    float stop = 0.0;

    // Coarse Search Phase
    [loop]
    for (int i = 0; i < (int) numLayers; i++)
    {
        // Advance to the next layer
        float2 nextUV = currentUV + deltaUVBase * (1.0 - stop);
        float nextLayerDepth = currentLayerDepth + layerDepth;
        float nextVal = depth2D(depthMap, nextUV, invertDepth, useProjectedDepth);

        // Determine if we've found the intersection
        float found = step(nextLayerDepth, nextVal); // 1 if nextLayerDepth <= nextVal
        float notFound = 1.0 - found;

        // Update previous values if intersection is found
        prevUV = lerp(prevUV, currentUV, found);
        prevLayerDepth = lerp(prevLayerDepth, currentLayerDepth, found);
        prevDepthMapValue = lerp(prevDepthMapValue, currentDepthMapValue, found);

        // Update current values
        currentUV = lerp(nextUV, currentUV, found);
        currentLayerDepth = lerp(nextLayerDepth, currentLayerDepth, found);
        currentDepthMapValue = lerp(nextVal, currentDepthMapValue, found);

        // Update the stop flag
        stop = max(stop, found);

        // Freeze deltaUVBase if intersection is found
        deltaUVBase *= notFound;
    }

    // Binary Refinement Phase
    float2 midUV = (prevUV + currentUV) * 0.5;
    float midLayerDepth = (prevLayerDepth + currentLayerDepth) * 0.5;
    float midVal = depth2D(depthMap, midUV, invertDepth, useProjectedDepth);

    [loop]
    for (int j = 0; j < 15; j++)
    {
        // Determine if the midpoint is an intersection
        float found = step(midLayerDepth, midVal);
        float notFound = 1.0 - found;

        // Update previous or current based on the intersection
        prevUV = lerp(prevUV, midUV, found);
        prevLayerDepth = lerp(prevLayerDepth, midLayerDepth, found);
        prevDepthMapValue = lerp(prevDepthMapValue, midVal, found);

        // Recompute the midpoint
        midUV = (prevUV + currentUV) * 0.5;
        midLayerDepth = (prevLayerDepth + currentLayerDepth) * 0.5;
        midVal = depth2D(depthMap, midUV, invertDepth, useProjectedDepth);
    }
    
      // Calculate the final UV offset
    float depthDifference = prevDepthMapValue - prevLayerDepth;
    float layerDifference = prevLayerDepth - currentLayerDepth;
    float weight = clamp(depthDifference / max(depthDifference + layerDifference, 1e-6), 0.0, 1.0);
    float2 finalUV = lerp(prevUV, midUV, weight);

    // Set the deltaUV result
    ret.deltaUV = finalUV - inputUV;

    // **Introduce Intricate Animation Using step()**
    // Example: Toggle additional shift based on time thresholds
    float animationThreshold1 = step(frac(time * 0.5), 0.25); // Toggle at intervals
    float animationThreshold2 = step(frac(time * 0.5), 0.75);

    // Apply conditional shifts
    ret.deltaUV += float2(animationThreshold1 - animationThreshold2, 0.0) * 0.005; // Small additional shift

    return ret;
}
// Function to perform Parallax Occlusion Mapping with Swaying and Wavelength Handling
void ParallaxOcclusionMappingSway3(
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 viewDir,
    float3 normal,
    float time,
    float swayFrequency,
    float swayAmplitude,
    bool invertDepth, bool useProjectedDepth,
    out float2 deltaUV
)
{
    // Sample diffuse color to get wavelength information
    float3 diffuse = diffuse2D(diffuseMap, inputUV).xyz;
    float3 wavelengthsNM = RGBToWavelengthsNM(diffuse);
    
    // Convert wavelengths to meters
    float3 wavelengthsM = nmToM(wavelengthsNM);
    
    // Calculate the swaying offset based on time and wavelength
    // Incorporate wavelength-dependent swaying for chromatic effects
    float3 swayOffset = sin(time * swayFrequency + wavelengthsNM * 0.01) * swayAmplitude * wavelengthsM;
    
    // Apply swaying to view direction (left-right swaying along X-axis)
    float3 swayDir = safeNormalize(viewDir + float3(swayOffset.x, 0.0, 0.0));
    
    // Initialize texture coordinates and depth
    float2 currentUV = inputUV;
    float currentDepth = EPSILON;
    const int MAX_DEPTH = OneMinusEPSILON;
    // Layer height based on number of layers
    float layerHeight = MAX_DEPTH / float(SWAY_LAYERS);
    
    // Ray marching loop for POM
    [unroll]
    for (int i = 0; i < SWAY_LAYERS; i++)
    {
        // Sample the height from depth map
        float height = clamp(depth2D(depthMap, currentUV, invertDepth, useProjectedDepth), MIN_DEPTH_RANGE, MAX_DEPTH_RANGE);
        
        if (currentDepth > height)
        {
            // Calculate the difference and backtrack for higher precision
            float overshoot = currentDepth - height;
            float2 prevUV = currentUV - swayDir.xy * layerHeight;
            
            // Linear interpolation to approximate the intersection point
            float t = overshoot / max(swayDir.z * layerHeight, EPSILON);
            deltaUV = lerp(prevUV, currentUV, t) - inputUV;
            return;
        }
        
        // Increment depth and offset texture coordinates
        currentUV += swayDir.xy * layerHeight;
        currentDepth += swayDir.z * layerHeight;
    }
    
    // If no intersection found, set deltaUV to zero
    deltaUV = float2(0.0, 0.0);
}
*/
psout PSb1(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);
    
    float sssStrength = HeightScale;
    float3 ViewPos = float3(ViewX, ViewY, ViewZ);
    float3 LightPos = float3(SunX, SunY, SunZ);

    // Toggle states
    bool invertDepth = !KeyWDown;
    bool useProjectedDepth = !KeyEDown;
    bool gradientUseProjectedDepth = KeyQDown;

    // Adjust depth parameters based on projection
    float currentDepthScale = lerp(1.0, DepthScale, int(useProjectedDepth));
    float2 currentDepthRange = lerp(float2(0.1, 0.9), DepthRange, useProjectedDepth);

    // Create material
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);

    // Time and sway calculations
    float time = TotalTime * AnimateSpeed;
    float swayFrequency = 1.0;
   

    float swayAmplitude = lerp(
        ParallaxScale * (1.0 - depth2D(depthMap, input.uv, invertDepth)),
        ParallaxScaleOMD * (depth2D(depthMap, input.uv, invertDepth)),
        depth2D(depthMap, input.uv, invertDepth)
    );

    float2 swayOffset = sin(time * swayFrequency) * swayAmplitude * float2(0.01, 0.001);

    // Parallax Occlusion
    ParallaxResult result = ParallaxOcclusion(depthMap, input.uv, swayOffset, invertDepth, useProjectedDepth, ParallaxScale);
    float2 deltaUV = result.deltaUVs[0];
    float2 adjustedUV = input.uv + deltaUV;
    
    float3 nSurrounding = float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding);
    // Pixel and normal calculations
    float3 pixelPos = float3(adjustedUV, depth2D(depthMap, adjustedUV, invertDepth, useProjectedDepth));
    
    float3 normal = normal2D11W(normalMap, adjustedUV, NormalRadius, false);

    // Albedo and wavelength conversions
    float3 albedo = mat.albedo * diffuse2D(diffuseMap, adjustedUV).rgb;
    float3 albedoWavelengthsNM = RGBToWavelengthsNM(albedo);
    float3 albedoWavelengthsM = nmToM(albedoWavelengthsNM);

    // View and light positions and directions
    float3 viewPos = ViewPos;
    float3 lightPos = LightPos;
    float3 viewDir = ToTangentSpace11(normalize(viewPos - pixelPos));
    float3 lightDir = ToTangentSpace11(normalize(lightPos - pixelPos));
    float3 halfDir = normalize(viewDir + lightDir);

    // Dot products
    float VdotH = abs(dot(viewDir, halfDir));
    float3 NdotV3 = clamp(dot3(viewDir, normal), EPSILON3, OneMinusEPSILON3);
    float HdotN = abs(dot(halfDir, normal));
    float HdotL = abs(dot(halfDir, lightDir));
    float3 NdotL3 = clamp(dot3(lightDir, normal), EPSILON3, OneMinusEPSILON3);
    
    // Reflectance with interference
    
    float3 iorAlbedoR = RefractiveIndexFromSellmeier(albedoWavelengthsNM, true, mat);
    float3 iorAlbedoI = RefractiveIndexFromSellmeier(albedoWavelengthsNM, false, mat);
    
    float3 cosThetaTInR, cosThetaTOutR;
    float3 ReflecInR = FresnelReflectanceFromFilm2(mat.nSurrounding, iorAlbedoR, NdotL3, cosThetaTInR);
    float3 ReflecOutR = FresnelReflectanceFromFilm2(iorAlbedoR, mat.nSurrounding, NdotL3, cosThetaTOutR);
    
    float3 cosThetaTInI, cosThetaTOutI;
    float3 ReflecInI = FresnelReflectanceFromFilm2(mat.nSurrounding, iorAlbedoI, NdotL3, cosThetaTInI);
    float3 ReflecOutI = FresnelReflectanceFromFilm2(iorAlbedoI, mat.nSurrounding, NdotL3, cosThetaTOutI);
    
     // BRDF Calculations
    float alpha = mat.roughness;
    
    float3 D = DistributionGGX(normal, halfDir, alpha);
    float3 G = GeometrySmithNVLf(normal, viewDir, lightDir, alpha);
    float3 denominator = max(float3(4.0, 4.0, 4.0) * NdotV3, EPSILON3);
    float3 specular = (D * G) / denominator;
   
    // Specular Color
    float3 specularColor = Specular(normal, viewDir, lightDir, mat) * specular;

    int dispersionIndex = 0;
    // Lighting Calculations
    float3 lightIntensity = CreateLighting(adjustedUV, GetSz_1(depthMap), viewPos, invertDepth, useProjectedDepth, ParallaxScale, mat, normal, lightDir, viewDir, time, cosThetaTInI, sssStrength, dispersionIndex);
    
    PathMeasurement distanceM = DistanceMFromViewToAB(viewPos, pixelPos, pixelPos + viewDir * mToNm(mat.thicknessM));
    output.rt1 = output.rt1 * .2;
        
    OpticalPathResult opdAlbedoTR = OpticalPathDifference(albedoWavelengthsNM, nSurrounding, distanceM, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaTInR);
        
    OpticalPathResult opdAlbedoTI = OpticalPathDifference(albedoWavelengthsNM, nSurrounding, distanceM, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaTInI);
        
    float3 phaseShiftTR = opdAlbedoTR.phaseInterference.totalPhase;
        
    float3 phaseShiftTI = opdAlbedoTI.phaseInterference.totalPhase;
        
    float3 reflectanceR = saturate(
            (ReflecInR + ReflecOutR + TWO3 * sqrt(max(ReflecInR * ReflecOutR, EPSILON3)) * sin(phaseShiftTR)) *
            CoherenceFactor(opdAlbedoTR.opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                fmod(time, cos(opdAlbedoTR.phaseInterference.totalPhase)),
                ReflecInR, ReflecOutR)
            );

    float3 reflectanceI = saturate(
            (ReflecInI + ReflecOutI + TWO3 *
            sqrt(max(ReflecInI * ReflecOutI, EPSILON3)) * sin(phaseShiftTI)) *
            CoherenceFactor(opdAlbedoTI.opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                fmod(time, sin(opdAlbedoTR.phaseInterference.totalPhase)),
            ReflecInR, ReflecOutR)
        );

        // Transmittance calculations
    float3 transmittanceR = saturate(1.0 - reflectanceR);
    float3 transmittanceI = saturate(1.0 - reflectanceI);

        // Effective Refractive Indices
    float3 eriReflectReal = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, reflectanceR, opdAlbedoTR.refractiveIndex);
    float3 eriReflectImag = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, reflectanceI, opdAlbedoTI.refractiveIndex);
        
    float3 eriTransmitReal = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, transmittanceR, opdAlbedoTR.refractiveIndex);
    float3 eriTransmitImag = EffectiveRefractiveIndex(lightDir, mat.opticalAxis, transmittanceI, opdAlbedoTI.refractiveIndex);
        
        // Apply Thin-Film Interference
    float3 interferenceColorR = albedo * InterferenceThinFilm(adjustedUV, time, (reflectanceR * albedoWavelengthsM), mat.thicknessM, eriReflectReal, NdotL3, mat.nSurrounding);
    float3 interferenceColorI = albedo * InterferenceThinFilm(adjustedUV, time, (reflectanceI * albedoWavelengthsM), mat.
        thicknessM, eriReflectImag, NdotL3, mat.nSurrounding);
        
    float3 interferenceColorTR = albedo * InterferenceThinFilm(adjustedUV, time, transmittanceR * albedoWavelengthsM, mat.thicknessM, eriTransmitReal, NdotL3, mat.nSurrounding);
    float3 interferenceColorTI = albedo * InterferenceThinFilm(adjustedUV, time, (transmittanceI * albedoWavelengthsM), mat.
        thicknessM, eriTransmitImag, NdotL3, mat.nSurrounding);

        // Wave frequencies and amplitudes
    float3 waveFrequenciesR = (float3(f1 + interferenceColorR.x, f2 + interferenceColorR.y, f3 + interferenceColorR.z) * reflectanceR * Mix3);
    float3 waveFrequenciesI = (float3(f1 + interferenceColorI.x, f2 + interferenceColorI.y, f3 + interferenceColorI.z) * reflectanceI * Mix3);
        
    float3 waveFrequenciesTR = (float3(f1 + interferenceColorTR.x, f2 + interferenceColorTR.y, f3 + interferenceColorTR.z) * transmittanceR * Mix3);
    float3 waveFrequenciesTI = (float3(f1 + interferenceColorTI.x, f2 + interferenceColorTI.y, f3 + interferenceColorTI.z) * transmittanceI * Mix3);

    float3 waveAmplitudesR = interferenceColorR * float3(f4, f5, f6);
    float3 waveAmplitudesI = interferenceColorI * float3(f4, f5, f6);
    float3 waveAmplitudesTR = interferenceColorTR * float3(f4, f5, f6);
    float3 waveAmplitudesTI = interferenceColorTI * float3(f4, f5, f6);
        
        // Phase offsets
    float3 phaseOffsets = float3(PhaseOffsetR, PhaseOffsetG + PI / 4.0, PhaseOffsetB + PI / 2.0);

        // Calculate Synchronized Multi-Wave Interference
    float3 multiWaveInterferenceR = InterferenceMultiWaveSynchronized(pixelPos, time, waveFrequenciesR, waveAmplitudesR, cos(phaseOffsets));
    float3 multiWaveInterferenceI = InterferenceMultiWaveSynchronized(pixelPos, time, waveFrequenciesI, waveAmplitudesI, sin(phaseOffsets));
    float3 multiWaveInterferenceTR = InterferenceMultiWaveSynchronized(pixelPos, time, waveFrequenciesTR, waveAmplitudesTR, cos(phaseOffsets));
    float3 multiWaveInterferenceTI = InterferenceMultiWaveSynchronized(pixelPos, time, waveFrequenciesTI, waveAmplitudesTI, sin(phaseOffsets));
        
        // Spiral Interference Calculations
    float3 spiralInterferenceRR = multiWaveInterferenceR *
            cos(SPEED_OF_LIGHT / (reflectanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(
                pixelPos + float3(0.003, 0.003, 0.0),
                time,
                CosineFactorR + waveFrequenciesR.r,
                CosineFactorG + interferenceColorR.g,
                CosineFactorB + waveAmplitudesR.b);

    float3 spiralInterferenceIR = multiWaveInterferenceI *
            sin(SPEED_OF_LIGHT / (reflectanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.003, 0.003, 0.0), time,
            sin(acos(CosineFactorR)) * waveFrequenciesI.r,
            sin(acos(CosineFactorG)) * interferenceColorI.g,
            sin(acos(CosineFactorB)) * waveAmplitudesI.b);

    float3 spiralInterferenceRG = multiWaveInterferenceR *
            cos(SPEED_OF_LIGHT / (reflectanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos + float3(0.015, 0.015, 0.0), time,
             CosineFactorR * waveFrequenciesR.r,
             CosineFactorG * interferenceColorR.g,
             CosineFactorB * waveAmplitudesR.b);

    float3 spiralInterferenceIG = multiWaveInterferenceI *
            sin(SPEED_OF_LIGHT / (reflectanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.015, 0.015, 0.0), time,
            sin(acos(CosineFactorR)) * waveFrequenciesI.g, sin(acos(CosineFactorG)) * interferenceColorI.g, sin(acos(CosineFactorB)) * waveAmplitudesI.g);

    float3 spiralInterferenceRB = multiWaveInterferenceR *
            cos(SPEED_OF_LIGHT / (reflectanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos + float3(0.0075, 0.0025, 0.0), time, CosineFactorR * waveFrequenciesR.b, CosineFactorG * interferenceColorR.b, CosineFactorB * waveAmplitudesR.b);

    float3 spiralInterferenceIB = multiWaveInterferenceI *
            sin(SPEED_OF_LIGHT / (reflectanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.0075, 0.0025, 0.0), time, sin(acos(CosineFactorR)) * waveFrequenciesI.b, sin(acos(CosineFactorG)) * interferenceColorI.b, sin(acos(CosineFactorB)) * waveAmplitudesI.b);

    float3 spiralInterferenceTR = multiWaveInterferenceTR *
            cos(SPEED_OF_LIGHT / (transmittanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos + float3(0.005, 0.01, 0.0), time, CosineFactorR * waveFrequenciesTR.r, CosineFactorG * interferenceColorTR.r, CosineFactorB * waveAmplitudesTR.r);

    float3 spiralInterferenceTIR = multiWaveInterferenceTI *
            sin(SPEED_OF_LIGHT / (transmittanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.005, 0.01, 0.0), time, sin(acos(CosineFactorR)) * waveFrequenciesTI.r, sin(acos(CosineFactorG)) * interferenceColorTI.g, sin(acos(CosineFactorB)) * waveAmplitudesTI.b);

    float3 spiralInterferenceTRG = multiWaveInterferenceTR *
            cos(SPEED_OF_LIGHT / (transmittanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos + float3(0.01, 0.005, 0.0), time, CosineFactorR * waveFrequenciesTR.g, CosineFactorG * interferenceColorTR.g, CosineFactorB * waveAmplitudesTR.g);

    float3 spiralInterferenceTIG = multiWaveInterferenceTI *
            sin(SPEED_OF_LIGHT / (transmittanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.01, 0.005, 0.0), time, sin(acos(CosineFactorR)) * waveFrequenciesTI.g, sin(acos(CosineFactorG)) * interferenceColorTI.g, sin(acos(CosineFactorB)) * waveAmplitudesTI.g);

    float3 spiralInterferenceTRB = multiWaveInterferenceTR *
            cos(SPEED_OF_LIGHT / (transmittanceR * albedoWavelengthsM) * opdAlbedoTR.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos + float3(0.02, 0.02, 0.0), time, CosineFactorR * waveFrequenciesTR.b, CosineFactorG * interferenceColorTR.b, CosineFactorB * waveAmplitudesTR.b);

    float3 spiralInterferenceTIB = multiWaveInterferenceTI *
            sin(SPEED_OF_LIGHT / (transmittanceI * albedoWavelengthsM) * opdAlbedoTI.phaseInterference.phaseDifference) *
            InterferenceSpiral(pixelPos - float3(0.2, 0.2, 0.0), time, sin(acos(CosineFactorR)) * waveFrequenciesTI.b, sin(acos(CosineFactorG)) * interferenceColorTI.b, sin(acos(CosineFactorB)) * waveAmplitudesTI.b);
        
       
    float depth = depth2D(depthMap, adjustedUV, invertDepth, useProjectedDepth);
    float invDepth01 = (1.0 - (depth / DepthScale));

        // Apply Chromatic Aberration
    float3 chromaticColorTR = transmittanceR * ApplyChromaticAberration(
            diffuseMap, depthMap, adjustedUV, viewDir, normal,
            interferenceColorTR * Iridescence(diffuse2D(diffuseMap, adjustedUV).rgb, mat.thicknessM, eriTransmitReal),
            12.0 * invDepth01, mat, invertDepth, useProjectedDepth, dispersionIndex);

    float3 chromaticColorTI = transmittanceI + ApplyChromaticAberration(
            diffuseMap, depthMap, adjustedUV, viewDir, normal,
            interferenceColorTI * Iridescence(diffuse2D(diffuseMap, adjustedUV).rgb, mat.thicknessM, eriTransmitImag),
            12.0 * invDepth01, mat, invertDepth, useProjectedDepth, dispersionIndex);

    float3 chromaticColorRR = reflectanceR + ApplyChromaticAberration(
            diffuseMap, depthMap, adjustedUV, viewDir, normal,
            interferenceColorR * Iridescence(diffuse2D(diffuseMap, adjustedUV).rgb, mat.thicknessM, eriReflectReal),
            12.0 * invDepth01, mat, invertDepth, useProjectedDepth, dispersionIndex);

    float3 chromaticColorRI = reflectanceI + ApplyChromaticAberration(
            diffuseMap, depthMap, adjustedUV, viewDir, normal,
            interferenceColorI * Iridescence(diffuse2D(diffuseMap, adjustedUV).rgb, mat.thicknessM, eriReflectImag),
            12.0 * invDepth01, mat, invertDepth, useProjectedDepth, dispersionIndex);
        
        
        
        
        // Lambertian Diffuse BRDF
    float3 diffuseTR = MicrofacetBRDF2(mat, adjustedUV, time, MaterialPropertiesFromMaterialSellmeier(mat), CreateAnisotropicRoughness(mat.roughness, mat.roughness), mat.albedo, rainbowColor(input.uv) * (1 - distance(input.uv, float2(LookAtX, LookAtY))), sssStrength, normal, viewDir, lightDir, ONE3 * mat.nSurrounding, eriTransmitReal, mToNm(mat.thicknessM), mat.dispersionCoefficientsNm2[dispersionIndex], dispersionIndex);
        
    float3 diffuseTI = MicrofacetBRDF2(mat, adjustedUV, time, MaterialPropertiesFromMaterialSellmeier(mat), CreateAnisotropicRoughness(mat.roughness, mat.roughness), mat.albedo, rainbowColor(input.uv) * (1 - distance(input.uv, float2(LookAtX, LookAtY))), sssStrength, normal, viewDir, lightDir, ONE3 * mat.nSurrounding, eriTransmitImag, mToNm(mat.thicknessM), mat.dispersionCoefficientsNm2[dispersionIndex], dispersionIndex);

    float3 diffuseRR = MicrofacetBRDF2(mat, adjustedUV, time, MaterialPropertiesFromMaterialSellmeier(mat), CreateAnisotropicRoughness(mat.roughness, mat.roughness), mat.albedo, rainbowColor(input.uv) * (1 - distance(input.uv, float2(LookAtX, LookAtY))), sssStrength, normal, viewDir, lightDir, ONE3 * mat.nSurrounding, eriReflectReal, mToNm(mat.thicknessM), mat.dispersionCoefficientsNm2[dispersionIndex], dispersionIndex);

    float3 diffuseRI = MicrofacetBRDF2(mat, adjustedUV, time, MaterialPropertiesFromMaterialSellmeier(mat), CreateAnisotropicRoughness(mat.roughness, mat.roughness), mat.albedo, rainbowColor(input.uv) * (1 - distance(input.uv, float2(LookAtX, LookAtY))), sssStrength, normal, viewDir, lightDir, ONE3 * mat.nSurrounding, eriReflectImag, mToNm(mat.thicknessM), mat.dispersionCoefficientsNm2[dispersionIndex], dispersionIndex);

    float3 lightingRR = max(EPSILON3, diffuseRR + reflectanceR +
            (SpecularIntensity * multiWaveInterferenceR));

    float3 lightingRI = max(EPSILON3, diffuseRI + reflectanceI +
            (SpecularIntensity * multiWaveInterferenceI));

    float3 lightingTR = max(EPSILON3, diffuseTR + reflectanceR + (SpecularIntensity * multiWaveInterferenceTR));

    float3 lightingTI = max(EPSILON3, diffuseTI + reflectanceR + (SpecularIntensity * multiWaveInterferenceTI));


        // Combine lighting components
    float3 lightingR = lerp(lightingRR, lightingTR, saturate(reflectanceR + reflectanceI));
    float3 lightingI = lerp(lightingRI, lightingTI, saturate(transmittanceI + transmittanceR));

        // Tone Mapping and Color Adjustments
    lightingR = ReinhardToneMapping(lightingR);
    lightingI = ReinhardToneMapping(lightingI);
    lightingR = AdjustGamma(lightingR, Gamma);
    lightingI = AdjustGamma(lightingI, Gamma);
    lightingR = AdjustSaturation(lightingR, Mix2);
    lightingI = AdjustSaturation(lightingI, Mix3);
       /*
        // Render Layers
        float3 renderLayer = RenderLayers(
            FILM_TYPE_HOLOGRAPHIC,
            viewPos,
            pixelPos,
            adjustedUV,
            depth2D(depthMap, adjustedUV, invertDepth, useProjectedDepth),
            time,
            RGBToWavelengthsNM(albedo),
            viewDir,
            lightDir,
            normal,
            lightingR * albedo,
            float2(LookAtX, LookAtY),
            FresnelMix,
            mat.nSurrounding, invertDepth, useProjectedDepth, mat
        );

        output.rt1.xyz += .3 * (renderLayer * NdotV3 * lightingR + renderLayer * HdotN * lightingI + float3(spiralInterferenceTIR.r, spiralInterferenceTIG.g, spiralInterferenceTIB.b));
        */
    
    // Debug Conditions
    if (KeyShift)
    {
        if (KeyQDown)
        {
            output.rt1 = float4(diffuseMap.Sample(sampleTypeMirror, input.uv).rgb, 1.0);
        }
        if (KeyWDown)
        {
            output.rt1 = float4(normalMap.Sample(sampleTypeMirror, input.uv).xyz, 1.0);
        }
        if (KeyEDown)
        {
            float sampledDepth = depth2D(depthMap, input.uv);
            output.rt1 = float4(sampledDepth.xxx, 1.0);
        }
    }

    return output;
}


struct OpticalProperties
{
    float n_real; // Real refractive index
    float n_imag; // Imaginary part (extinction coeff)
    float birefringence; // Difference between extraordinary and ordinary indices
    float3 opticAxis; // Optic axis for birefringent material
    float absorption; // Absorption factor within the material
    float diffusion; // Measures how much internal scattering occurs
    float coherence; // Coherence factor (0 = incoherent, 1 = coherent)
    float thicknessM; // Thickness in meters
    float polarizationAngle; // Defines initial polarization state
};

struct Material
{
    float3 diffuseReflectance;
    float3 specularReflectance;
    float roughness;
    float3 baseColor;
    OpticalProperties optics;
};

struct PolarizationState
{
    // Represent polarization using Jones vectors or Stokes vectors
    // For simplicity, use a Jones vector (Ex, Ey), complex numbers could be represented as float2
    float2 Ex; // (real, imag)
    float2 Ey; // (real, imag)
};

struct Light
{
    float3 direction;
    float3 color;
    float intensity;
};

struct RayData
{
    float3 direction;
    float3 polarizationBasisX;
    float3 polarizationBasisY;
    PolarizationState polState;
};


// Fresnel using complex refractive indices (n + i*k)
inline float3 FresnelComplex(float3 F0, float NdotH, float n_real, float n_imag)
{
    // Compute Fresnel reflectance using complex IOR
    // This is a simplified form:
    // F = ((n+ik)² - sin²θ) / ((n+ik)² + sin²θ)
    // Properly done: use known Fresnel equations for complex media
    // For brevity, we approximate or assume F0 is derived from these.
    // In reality, you'd compute R_parallel and R_perp.
    return F0 + (1.0 - F0) * pow(1.0 - NdotH, FresnelPower);
}

// Compute ordinary and extraordinary refracted directions
inline void ComputeBirefringentRays(float3 N, float3 I, float3 opticAxis, float birefringence,
                                    out float3 ordinaryRay, out float3 extraordinaryRay)
{
    // Compute refracted directions for a uniaxial crystal:
    // Ordinary ray is polarized perpendicular to the optic axis and behaves with one refractive index.
    // Extraordinary ray is polarized partly along optic axis with different index.
    // This is a placeholder for a real solution (which involves solving Fresnel’s equations for biaxial media).
    float3 Nn = safeNormalize(N);
    float3 On = safeNormalize(cross(opticAxis, cross(Nn, opticAxis)));
    float3 En = safeNormalize(cross(Nn, On));

    float no = 1.0; // Ordinary index (approx)
    float ne = no + birefringence; // Extraordinary index

    // Refract I into ordinary direction
    ordinaryRay = refract(-I, Nn, no);
    extraordinaryRay = refract(-I, Nn, ne);

    // Adjust extraordinary direction towards optic axis
    extraordinaryRay = safeNormalize(lerp(extraordinaryRay, En, 0.5));
}

// Gaussian approximation for internal scattering (diffusion)
inline float InternalDiffusion(float distance, float diffusion)
{
    // As distance inside the material grows, intensity decays
    // Simple exponential decay for illustration
    return exp(-distance * diffusion);
}

// Phase Shift and Interference calculation
inline float3 InterferenceFactor(float thickness, float coherence, float3 wavelengthsNM, float n_real, float n_imag)
{
    // Interference depends on path difference = 2*n*thickness
    // Phase shift φ = (4 * PI * n_real * thickness) / wavelength
    float3 phase = (4.0 * PI * n_real * thickness) / nmToM(wavelengthsNM);
    // Interference term: I = 1 + cos(phase)*coherence
    // Include absorption via n_imag as attenuation factor
    float3 absorptionFactor = exp(-4.0 * PI * n_imag * thickness / nmToM(wavelengthsNM));
    return 1.0 + coherence * cos(phase) * absorptionFactor;
}

// Compute polarization transformations
inline PolarizationState ApplyPolarizationEffects(PolarizationState inputPol, float polarizationAngle)
{
    // Rotate Jones vector by polarizationAngle
    // Jones rotation matrix:
    // [ cos(θ)  -sin(θ) ]
    // [ sin(θ)   cos(θ) ]
    float c = cos(polarizationAngle);
    float s = sin(polarizationAngle);

    float2 Ex_new = float2(inputPol.Ex.x * c - inputPol.Ey.x * s, inputPol.Ex.y * c - inputPol.Ey.y * s);
    float2 Ey_new = float2(inputPol.Ex.x * s + inputPol.Ey.x * c, inputPol.Ex.y * s + inputPol.Ey.y * c);

    PolarizationState outPol = inputPol;
    outPol.Ex = Ex_new;
    outPol.Ey = Ey_new;
    return outPol;
}

// BRDF calculations (Cook-Torrance as base)
inline float3 CookTorranceBRDF(float3 N, float3 V, float3 L, float3 F0, float roughness, float n_real, float n_imag)
{
    float3 H = safeNormalize(V + L);
    float NdotL = saturate(dot(N, L));
    float NdotV = saturate(dot(N, V));
    float NdotH = saturate(dot(N, H));
    float VdotH = saturate(dot(V, H));

    float alpha = roughness * roughness;
    float alpha2 = alpha * alpha;

    // NDF (GGX)
    float denom = (NdotH * NdotH * (alpha2 - 1.0) + 1.0);
    float D = alpha2 / (PI * denom * denom);

    // Geometry (Schlick-GGX)
    float k = (roughness + 1) * (roughness + 1) * 0.125;
    float G1V = NdotV / (NdotV * (1.0 - k) + k);
    float G1L = NdotL / (NdotL * (1.0 - k) + k);
    float G = G1V * G1L;

    // Fresnel with complex IOR
    float3 F = FresnelComplex(F0, NdotH, n_real, n_imag);

    float3 specular = (D * F * G) / max(4.0 * NdotL * NdotV, EPSILON);
    return specular;
}

inline float3 LambertianDiffuse(float3 baseColor)
{
    return baseColor / PI;
}
inline float3 GetDiffuseColor(Texture2D<float4> diffuseMap, float2 inputUV, Material mat)
{
    float3 diffuseSample = diffuseMap.Sample(sampleTypeMirror, inputUV).rgb;
    return diffuseSample.rgb * mat.baseColor;
}


float3 CalculateFinalColor(
    float2 inputUV,
    Material material,
    Light light,
    float3 viewPos, float3 pixelPos, float3 lightPos,
    float3 N,
    float3 V,
    float3 L,
    float3 wavelengthsNM,
    float3 dispersionCoefficients[3],
    float3 absorptionCoefficient,
    float3 nSurrounding
)
{
    N = safeNormalize(N);
    V = safeNormalize(V);
    L = safeNormalize(L);

    float NdotL = saturate(dot(N, L));
    float NdotV = saturate(dot(N, V));

    // Extract optical properties
    float n_real = material.optics.n_real;
    float n_imag = material.optics.n_imag;
    float biref = material.optics.birefringence;
    float absorption = material.optics.absorption;
    float diffusion = material.optics.diffusion;
    float coherence = material.optics.coherence;
    float thicknessM = material.optics.thicknessM;
    float polAngle = material.optics.polarizationAngle;

    // Initial polarization state (assume linear polarization for simplicity)
    PolarizationState pol;
    pol.Ex = float2(1.0, 0.0);
    pol.Ey = float2(0.0, 0.0);

    // Apply initial polarization rotation
    pol = ApplyPolarizationEffects(pol, polAngle);

    // Compute ordinary and extraordinary rays (for transmitted/refracted component)
    float3 ordinaryRay, extraordinaryRay;
    ComputeBirefringentRays(N, V, material.optics.opticAxis, biref, ordinaryRay, extraordinaryRay);

    // Calculate reflectance (specular) from Cook-Torrance
    float3 F0 = material.specularReflectance;
    float3 specular = CookTorranceBRDF(N, V, L, F0, material.roughness, n_real, n_imag);

    // Diffuse reflection (Lambertian or Oren-Nayar for rough surfaces)
    float3 diffuse = LambertianDiffuse(material.baseColor);

    // Combine ordinary and extraordinary contributions
    // For simplicity, assume half from ordinary and half from extraordinary, weighted by masks
    float birefringentMask = biref > EPSILON ? 1.0 : 0.0;

    // Transmission through material
    // Compute intensity drop due to absorption and diffusion
    // Assume some path length ~ thickness/cos(theta)
    float pathLength = thicknessM / max(dot(-V, N), EPSILON);
    float internalAttenuation = exp(-absorption * pathLength);
    
    float3 ior = RefractiveIndexBirefringementFromAxis(V, material.optics.opticAxis, 1.5, 1.3, 1.7);
    
    
    float3 cosThetaTInR, cosThetaTOutR;
    float3 ReflecInR = FresnelReflectanceFromFilm2(nSurrounding, ior, dot3(N, L), cosThetaTInR);
    float3 ReflecOutR = FresnelReflectanceFromFilm2(ior, nSurrounding, dot3(N, L), cosThetaTOutR);
    
    float3 cosThetaTInI, cosThetaTOutI;
    float3 ReflecInI = FresnelReflectanceFromFilm2(nSurrounding, ior, dot3(N, L), cosThetaTInI);
    float3 ReflecOutI = FresnelReflectanceFromFilm2(ior, nSurrounding, dot3(N, L), cosThetaTOutI);
    
    
    // Interference factor
    float3 interferenceFactor = InterferenceFactor(thicknessM, coherence, wavelengthsNM, n_real, n_imag);

    float time = TotalTime * AnimateSpeed;
    PathMeasurement distanceM = DistanceMFromViewToAB(viewPos, pixelPos, pixelPos + mToNm(thicknessM));
        
    float3 combinedReflectance = ZERO3;
    float3 combinedDiffuse = ZERO3;
    int dispersionIndex = 0;
    [unroll(3)]
    for (dispersionIndex = 0; dispersionIndex < 3; dispersionIndex++)
    {
        OpticalPathResult opdAlbedoTR = OpticalPathDifference(wavelengthsNM, nSurrounding, distanceM, dispersionCoefficients[dispersionIndex], absorptionCoefficient, cosThetaTInR);
        
        OpticalPathResult opdAlbedoTI = OpticalPathDifference(wavelengthsNM, nSurrounding, distanceM, dispersionCoefficients[dispersionIndex], absorptionCoefficient, cosThetaTInI);
        
        float3 phaseShiftR = opdAlbedoTR.phaseInterference.phaseShift;
        
        float3 phaseShiftI = opdAlbedoTI.phaseInterference.phaseShift;

        float3 reflectanceR = saturate(
            ReflecInR + ReflecOutR + TWO3 *
            sqrt(max(ReflecInR * ReflecOutR, EPSILON3)) * cos(phaseShiftR) *
            CoherenceFactor(opdAlbedoTR.opticalMeasurement.PathDifferenceM, material.optics.coherence) *
            PolarizationEffect3(
                fmod(time, opdAlbedoTR.phaseInterference.totalPhase),
                ReflecInR, ReflecOutR)
            );
        
        float3 reflectanceI = saturate(
            ReflecInI + ReflecOutI + TWO3 *
            sqrt(max(ReflecInI * ReflecOutI, EPSILON3)) * sin(phaseShiftI) *
            CoherenceFactor(opdAlbedoTR.opticalMeasurement.PathDifferenceM, material.optics.coherence) *
            PolarizationEffect3(
                fmod(time, opdAlbedoTI.phaseInterference.totalPhase),
                ReflecInI, ReflecOutI)
            );
    
    // Polarization effects on reflectance and transmittance
    // For simplicity, scale the intensity by polarization states (not fully physically accurate without Jones/Mueller calc)
    // Here we just show a placeholder:
       
    // Ordinary ray reflection/transmission
        float3 ordinarySpecular = (1.0 - reflectanceI) * specular; // For ordinary index
        float3 extraordinarySpecular = (1.0 - reflectanceI) * specular * (1.0 + birefringentMask * 0.1); // Slight variation for demonstration

    // Diffuse components might differ slightly due to internal scattering in O/E rays
        float3 ordinaryDiffuse = (1.0 - reflectanceR) * diffuse * InternalDiffusion(opdAlbedoTR.opticalMeasurement.PathDifferenceM.x, diffusion);
        float3 extraordinaryDiffuse = (1.0 - reflectanceR) * diffuse * InternalDiffusion(pathLength, diffusion * 1.1);

    // Combine ordinary and extraordinary reflectance
        combinedReflectance += 0.5 * reflectanceR * (ordinarySpecular + extraordinarySpecular) * birefringentMask + (1.0 - birefringentMask) * specular;
        combinedDiffuse += 0.5 * (1.0 - reflectanceR) * (ordinaryDiffuse + extraordinaryDiffuse) * birefringentMask + (1.0 - birefringentMask) * diffuse;
    }
    // Apply interference factor (mainly affects transmitted/reflected intensity)
    combinedReflectance *= interferenceFactor;
    combinedDiffuse *= .1 * interferenceFactor;

    // Apply internal attenuation
    combinedDiffuse += internalAttenuation;

    // Combine diffuse and specular
    float3 finalRadiance = (combinedDiffuse + combinedReflectance) * light.color * light.intensity * NdotL;
    
    
    float polarizationIntensityFactor = .6; // Could be computed from pol states and Fresnel parallel/perp components

    // Apply polarization intensity factor (placeholder)
    finalRadiance *= polarizationIntensityFactor;

    // Ensure energy conservation if needed (simple clamp)
    finalRadiance = diffuse * max(finalRadiance, float3(0.0, 0.0, 0.0));

    
    return finalRadiance;
    
}


inline float ComputeThicknessFromDepth(Texture2D<float> depthMap, float2 inputUV, Material mat)
{
    float depthVal = 1.0 - depthMap.SampleLevel(sampleTypeMirror, inputUV, 0);
    
    // Map depthVal [0,1] to a thickness range
    float baseThicknessM = mat.optics.thicknessM;
    float thicknessRangeM = 1.0;
    return baseThicknessM + depthVal * thicknessRangeM;
}

#define LP_CASE(n, prop) case n: {output.rt1 = FinalPass(diffuseMap, input.uv, diffuseMap, input.uv, depthMap, input.uv, lighting.##prop);}break;
#define LP_CASE2(n, prop) case n: output.rt1 = FinalPass(diffuseMap, input.uv, diffuseMap, input.uv, depthMap, input.uv, lighting.##prop);break;

#define ToFloat3(v) float3(v,v,v)
#define ToFloat3Bool(v) lerp(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),v)


#define CELL_W 64
#define CELL_H 56

// Macro for determining the grid index dynamically
#define MAP_TO_GRID_INDEX(uv, gridWidth, gridHeight) \
    (int((uv.y * gridHeight)) * int(gridWidth) + int((uv.x * gridWidth)))

// Macro to check if the UV is within the current cell
#define IS_IN_GRID_CELL(uv, cellX, cellY, gridWidth, gridHeight) \
    ((uv.x >= cellX / gridWidth) && (uv.x < (cellX + 1) / gridWidth) && \
     (uv.y >= cellY / gridHeight) && (uv.y < (cellY + 1) / gridHeight))


// Main function to populate grid dynamically
void PopulateLightingGridDynamic(
    float2 uv, float gridWidth, float gridHeight,
    Lighting lighting, int numCells, inout float4 output)
{
    // Iterate through grid cells
    for (int y = 0; y < gridHeight; ++y)
    {
        for (int x = 0; x < gridWidth; ++x)
        {
            if (IS_IN_GRID_CELL(uv, x, y, gridWidth, gridHeight))
            {
                // Write selected lighting properties to the output for the matching cell
                output = float4(lighting.lightingR, 1);
            }
        }
    }
}

void getColor(Texture2D<float4> diffuseMap, PS_INPUT input, Lighting lighting, int ix, int dispersionIndex, inout psout output)
{
    switch (fmod(ix, 37))
    {
        // Final render layer
        LP_CASE(0, renderLayer)

        // Combined lighting
        LP_CASE(1, lighting)

        // Separate lighting components
        LP_CASE(2, lightingR)
        LP_CASE(3, lightingI)

        // Film reflectance components (real and imaginary)
        LP_CASE(4, internalFilmReflectanceReal)
        LP_CASE(5, externalFilmReflectanceReal)
        LP_CASE(6, internalFilmReflectanceImag)
        LP_CASE(7, externalFilmReflectanceImag)

        // Optical Path Difference (OPD) contributions
        LP_CASE(8, opdAlbedoTransRealChannel[dispersionIndex].intensityModulation)
        LP_CASE(9, opdAlbedoTransRealChannel[dispersionIndex].absorptionEffect)
        LP_CASE(10, opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)
        LP_CASE(11, opdAlbedoTransImagChannel[dispersionIndex].intensityModulation)
        LP_CASE(12, opdAlbedoTransImagChannel[dispersionIndex].absorptionEffect)

        // Reflectance and Transmittance for current dispersion index
        LP_CASE(13, reflectanceReal[dispersionIndex])
        LP_CASE(14, reflectanceImag[dispersionIndex])
        LP_CASE(15, transmittanceReal[dispersionIndex])
        LP_CASE(16, transmittanceImag[dispersionIndex])

        // Diffuse BRDF components
        LP_CASE(17, diffuseRealTransmit[dispersionIndex])
        LP_CASE(18, diffuseImagTransmit[dispersionIndex])
        LP_CASE(19, diffuseRealReflect[dispersionIndex])
        LP_CASE(20, diffuseImagReflect[dispersionIndex])

        // Microfacet terms
        LP_CASE(21, ggxDistributionTerm)
        LP_CASE(22, smithGeometryTerm)
        LP_CASE(23, microfacetSpecularTerm)

        // Specular contributions
        LP_CASE(24, specularReflectanceResult)
        LP_CASE(25, CookTorrenceSpecular)

        // Interference components
        LP_CASE(26, interferenceIntensity[dispersionIndex])
        LP_CASE(27, interferenceColor)

        // Phase contributions
        LP_CASE(28, phaseShift[dispersionIndex])
        LP_CASE(29, phaseReal[dispersionIndex])
        LP_CASE(30, phaseImag[dispersionIndex])

        // Effective refractive indices
        LP_CASE(31, effectiveRefractiveIndexReflectReal[dispersionIndex])
        LP_CASE(32, effectiveRefractiveIndexReflectImag[dispersionIndex])
        LP_CASE(33, effectiveRefractiveIndexTransmitReal[dispersionIndex])
        LP_CASE(34, effectiveRefractiveIndexTransmitImag[dispersionIndex])

        // Fresnel reflectance
        LP_CASE(35, fresnelReflectance)

        // Depth and parallax-related values
        LP_CASE(36, depth)
        LP_CASE(37, invDepth01)
    }
}

void getColorComplex(Texture2D<float4> diffuseMap, PS_INPUT input, LightingComplex lighting, int ix, int dispersionIndex, inout psout output)
{
    switch (fmod(ix, 24))
    {
        LP_CASE(0, totalLighting[dispersionIndex])
        
        LP_CASE(1, lighting[dispersionIndex].real)
        LP_CASE(2, lighting[dispersionIndex].imag)

        LP_CASE(3, diffuseReflectance[dispersionIndex].real)
        LP_CASE(4, diffuseReflectance[dispersionIndex].imag)
        LP_CASE(5, specularContribution[dispersionIndex].real)
        LP_CASE(6, specularContribution[dispersionIndex].imag)
        LP_CASE(7, interferenceContribution[dispersionIndex].real)
        LP_CASE(8, interferenceContribution[dispersionIndex].imag)
        
        LP_CASE(9, totalReflectance[dispersionIndex].real)
        LP_CASE(10, totalReflectance[dispersionIndex].imag)
        LP_CASE(11, transmittance[dispersionIndex].real)
        LP_CASE(12, transmittance[dispersionIndex].imag)
        LP_CASE(13, reflectance[dispersionIndex].real)
        LP_CASE(14, reflectance[dispersionIndex].imag)
        LP_CASE(15, polarization.real)
        LP_CASE(16, polarization.imag)
        LP_CASE(17, cookTorrenceSpecular)
        LP_CASE(18, interferenceIntensity[dispersionIndex])
        LP_CASE(19, externalReflectance.real)
        LP_CASE(20, externalReflectance.imag)
        LP_CASE(21, internalReflectance.real)
        LP_CASE(22, internalReflectance.imag)
        LP_CASE(23, phaseShift[dispersionIndex].real)
        LP_CASE(24, phaseShift[dispersionIndex].imag)
        
    }
}
psout HoloLines(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    if (PassNum == 0)
    {
        // Pass 0: Calculate velocity and thickness
        float2 velocity = float2(sin(input.uv.y * 10.0 + TotalTime), cos(input.uv.x * 10.0 - TotalTime));
        float thickness = 0.5 + 0.5 * sin(input.uv.x * 5.0 + input.uv.y * 5.0 + TotalTime);

        // Store velocity (R, G) and thickness (B) in rt1
        output.rt1 = float4(velocity, thickness, 1.0);
    }
    else if (PassNum == 1)
    {
        // Pass 1: Generate interference colors based on thickness

        // Read thickness from rt1
        float3 baseData = diffuse2D(rtMap1, input.uv).rgb;
        float thickness = baseData.b;

        // Calculate wavelength-dependent phase shifts
        float phaseR = sin(thickness * 10.0 + TotalTime);
        float phaseG = sin(thickness * 12.0 + TotalTime);
        float phaseB = sin(thickness * 14.0 + TotalTime);

        // Map phase shifts to interference colors
        float3 interferenceColor = float3(
            0.5 + 0.5 * phaseR,
            0.5 + 0.5 * phaseG,
            0.5 + 0.5 * phaseB
        );

        // Store interference colors in rt2
        output.rt2 = float4(interferenceColor, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Perform a Gaussian blur on interference colors

        // Perform Gaussian blur
        float3 color = 0.0;
        float weightSum = 0.0;

        for (int x = -2; x <= 2; x++)
        {
            for (int y = -2; y <= 2; y++)
            {
                float2 offset = float2(x, y) * 0.002; // Blur radius
                float weight = exp(-length(offset) * 20.0); // Gaussian weight
                color += diffuse2D(rtMap2, input.uv + offset).rgb * weight;
                weightSum += weight;
            }
        }

        color /= weightSum;

        // Store smoothed interference colors in rt3
        output.rt3 = float4(color, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Add shimmer and distort the surface

        // Read velocity from rt1 and interference colors from rt3
        float3 baseData = diffuse2D(rtMap1, input.uv).rgb;
        float2 velocity = baseData.rg;

        float3 interferenceColor = diffuse2D(rtMap3, input.uv).rgb;

        // Distort UVs based on velocity
        float2 distortedUV = input.uv + velocity * 0.01 * sin(TotalTime);

        // Add shimmer effect to the interference colors
        float highlight = max(0.0, dot(normalize(float3(input.uv, 1.0)), normalize(float3(0.5, 0.5, 1.0))));
        float3 shimmer = highlight * float3(0.8, 0.9, 1.0);

        float3 finalColor = interferenceColor + shimmer * 0.3;

        // Store final result in rt4
        output.rt4 = float4(finalColor, 1.0);

        // Optionally display the final result in rt1
        output.rt1 = output.rt4;
    }

    return output;
}

psout BlueCircles(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    if (PassNum == 0)
    {
        // Pass 0: Calculate base thickness and noise for variation
        float thickness = 0.3 + 0.2 * sin(input.uv.x * 20.0 + TotalTime * 0.5) +
                          0.1 * sin(input.uv.y * 25.0 + TotalTime * 0.8);
        float noise = frac(sin(dot(input.uv * 43758.5453, float2(12.9898, 78.233))) * 43758.5453);
        thickness += noise * 0.05;

        // Store thickness in rt1
        output.rt1 = float4(0.0, 0.0, thickness, 1.0);
    }
    else if (PassNum == 1)
    {
        // Pass 1: Simulate thin-film interference

        // Read thickness from rt1
        float thickness = diffuse2D(rtMap1, input.uv).b;

        // Wavelengths for R, G, B (in micrometers)
        float lambdaR = 0.65; // Red
        float lambdaG = 0.55; // Green
        float lambdaB = 0.45; // Blue

        // Simulate interference
        float phaseR = frac(thickness / lambdaR) * 2.0 * 3.14159;
        float phaseG = frac(thickness / lambdaG) * 2.0 * 3.14159;
        float phaseB = frac(thickness / lambdaB) * 2.0 * 3.14159;

        float intensityR = abs(sin(phaseR));
        float intensityG = abs(sin(phaseG));
        float intensityB = abs(sin(phaseB));

        // Combine into interference color
        float3 interferenceColor = float3(intensityR, intensityG, intensityB);

        // Store interference colors in rt2
        output.rt2 = float4(interferenceColor, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Apply Fresnel reflectance for realistic sheen

        // Read interference color from rt2
        float3 interferenceColor = diffuse2D(rtMap2, input.uv).rgb;

        // Calculate Fresnel reflectance (Schlick's approximation)
        float3 viewDir = normalize(float3(input.uv, 1.0));
        float fresnel = pow(1.0 - abs(dot(viewDir, float3(0.0, 0.0, 1.0))), 5.0);

        // Enhance interference colors with Fresnel effect
        float3 fresnelColor = interferenceColor * (0.2 + fresnel * 0.8);

        // Store enhanced colors in rt3
        output.rt3 = float4(fresnelColor, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Add distortions for a fluid-like appearance

        // Read interference colors from rt3
        float3 fresnelColor = diffuse2D(rtMap3, input.uv).rgb;

        // Create dynamic distortion based on time and UV
        float2 distortion = float2(sin(input.uv.y * 30.0 + TotalTime), cos(input.uv.x * 30.0 - TotalTime)) * 0.01;

        // Apply distortion to UV
        float3 distortedColor = diffuse2D(rtMap3, input.uv + distortion).rgb;

        // Blend distortion with original color
        float3 finalColor = lerp(fresnelColor, distortedColor, 0.5);

        // Store final result in rt4
        output.rt4 = float4(finalColor, 1.0);

        // Display final result in rt1 for output
        output.rt1 = output.rt4;
    }

    return output;
}

psout InterferenceOil(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    if (PassNum == 0)
    {
        // Pass 0: Dynamic thickness map
        float thickness = mToUm(200e-9 + 100e-9 * sin(input.uv.x * 30.0 + TotalTime) +
                          50e-9 * cos(input.uv.y * 20.0 - TotalTime));

        // Add Perlin noise for surface turbulence
        float2 noiseUV = input.uv * 5.0 + float2(TotalTime * 0.3, TotalTime * 0.4);
        float noise = frac(sin(dot(noiseUV, float2(12.9898, 78.233))) * 43758.5453);
        thickness += mToUm(noise * 50e-9);

        // Store thickness in rt1
        output.rt1 = float4(thickness, 0.0, 0.0, 1.0);
    }
    else if (PassNum == 1)
    {
        // Pass 1: Calculate interference colors

        // Read thickness from rt1
        float thickness = diffuse2D(rtMap1, input.uv).r;

        // Wavelengths for RGB in micrometers
        float3 wavelengthsM = float3(650e-9, 550e-9, 450e-9);
        wavelengthsM = mToUm(wavelengthsM);

        // Film refractive index and surrounding refractive index
        float3 nFilm = float3(1.33, 1.33, 1.33); // Example: water-like film
        float3 nSurrounding = float3(1.0, 1.0, 1.0); // Air

        // Cosine of the transmission angle
        float3 cosThetaT = float3(0.9, 0.9, 0.9); // Assume nearly normal incidence

        // Calculate Optical Path Difference (OPD)
        float3 OPD = 2.0f * nFilm * thickness * cosThetaT;

        // Calculate Phase Difference = 2π * OPD / wavelength
        float3 phaseDifference = (TWOPI3 * OPD) / wavelengthsM;

        // Calculate Reflection Phase Shift
        float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, nFilm);

        // Total Phase = Phase Difference + Reflection Phase Shift
        float3 totalPhase = phaseDifference + reflectionPhaseShift;

        // Interference Result = cos(Total Phase)
        float3 interferenceResult = cos(totalPhase);

        // Store interference result in rt2
        output.rt2 = float4(interferenceResult, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Distort interference patterns with surface motion
        float3 interferenceResult = diffuse2D(rtMap2, input.uv).rgb;

        // Velocity field for dynamic surface distortion
        float2 velocity = float2(
            sin(input.uv.y * 20.0 + TotalTime),
            cos(input.uv.x * 20.0 - TotalTime)
        ) * 0.01;

        // Apply distortion
        float2 distortedUV = input.uv + velocity;

        // Sample distorted interference result
        float3 distortedResult = diffuse2D(rtMap2, distortedUV).rgb;

        // Blend original and distorted interference
        float3 blendedResult = lerp(interferenceResult, distortedResult, 0.5);

        // Store in rt3
        output.rt3 = float4(blendedResult, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Add Fresnel highlights for realism

        // Read distorted interference result
        float3 blendedResult = diffuse2D(rtMap3, input.uv).rgb;

        // Fresnel reflectance based on view angle
        float3 viewDir = normalize(float3(input.uv, 1.0));
        float fresnel = pow(1.0 - abs(dot(viewDir, float3(0.0, 0.0, 1.0))), 5.0);

        // Combine interference with Fresnel highlights
        float3 finalColor = blendedResult + fresnel * float3(1.0, 1.0, 1.0);

        // Store final color in rt1 for display
        output.rt1 = float4(finalColor, 1.0);
    }

    return output;
}
psout InterferenceOil2(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    if (PassNum == 0)
    {
        // Pass 0: Thickness map modulated by depth map
        float baseThickness = 200e-9;
        float waveThickness = 100e-9 * sin(input.uv.x * 30.0 + TotalTime) +
                              50e-9 * cos(input.uv.y * 20.0 - TotalTime);

        // Sample depth map using depth2D
        float depth = depth2D(depthMap, input.uv); // Depth map sampling
        float modulatedThickness = baseThickness + depth * waveThickness;

        // Convert to micrometers
        float thickness = mToUm(modulatedThickness);

        // Store thickness in rt1
        output.rt1 = float4(thickness, 0.0, 0.0, 1.0);
    }
    else if (PassNum == 1)
    {
        // Pass 1: Thin-film interference colors

        // Read thickness from rt1
        float thickness = diffuse2D(rtMap1, input.uv).r;

        // Sample diffuse map for base color
        float3 baseColor = diffuse2D(diffuseMap, input.uv).rgb;

        // Wavelengths for RGB in micrometers
        float3 wavelengthsM = mToUm(float3(650e-9, 550e-9, 450e-9));

        // Film and surrounding refractive indices
        float3 nFilm = float3(1.33, 1.33, 1.33); // Example: water-like film
        float3 nSurrounding = float3(1.0, 1.0, 1.0); // Air

        // Normal from normal map
        float3 normal = normalize(diffuse2D(normalMap, input.uv).rgb * 2.0 - 1.0); // Normalized normal map

        // Cosine of the transmission angle
        float3 cosThetaT = ONE3 * dot(normal, float3(0.0, 0.0, 1.0)); // Corrected to use ONE3

        // Calculate Optical Path Difference (OPD)
        float3 OPD = 2.0f * nFilm * thickness * cosThetaT;

        // Phase calculations
        float3 phaseDifference = (TWOPI3 * OPD) / wavelengthsM;
        float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, nFilm);
        float3 totalPhase = phaseDifference + reflectionPhaseShift;

        // Calculate interference result
        float3 interferenceResult = cos(totalPhase);

        // Combine with base color
        float3 combinedColor = baseColor * interferenceResult;

        // Store in rt2
        output.rt2 = float4(combinedColor, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Surface distortions with normal map and turbulence
        float3 combinedColor = diffuse2D(rtMap2, input.uv).rgb;

        // Velocity-based distortions
        float2 velocity = float2(
            sin(input.uv.y * 20.0 + TotalTime),
            cos(input.uv.x * 20.0 - TotalTime)
        ) * 0.01;

        // Normal map-based perturbation
        float3 normal = normal2D11W(normalMap, input.uv);
        float2 normalPerturb = normal.xy * 0.02;

        // Combine velocity and normal perturbations
        float2 distortedUV = input.uv + velocity + normalPerturb;

        // Sample distorted colors
        float3 distortedResult = diffuse2D(rtMap2, distortedUV).rgb;

        // Blend original and distorted results
        float3 blendedResult = lerp(combinedColor, distortedResult, 0.5);

        // Store in rt3
        output.rt3 = float4(blendedResult, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Specular effects with Fresnel and highlights

        // Read blended result
        float3 blendedResult = diffuse2D(rtMap3, input.uv).rgb;

        // Fresnel reflectance
        float3 normal = normal2D11W(normalMap, input.uv);
        float3 viewDir = normalize(float3(input.uv, 1.0));
        float fresnel = pow(1.0 - abs(dot(normal, viewDir)), 5.0);

        // Specular highlights
        float specular = pow(max(dot(normal, float3(0.0, 0.0, 1.0)), 0.0), 16.0);

        // Combine results
        float3 finalColor = blendedResult + fresnel * float3(1.0, 1.0, 1.0) + specular * float3(1.0, 1.0, 1.0);

        // Store final color in rt1 for display
        output.rt1 = float4(finalColor, 1.0);
    }

    return output;
}
psout InterferenceTurbulence(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    // Constants for fine-tuning
    const float BRIGHTNESS = 2; // Brightness multiplier
    const float TURBULENCE_SCALE = .25; // Reduced turbulence scale
    const float FRESNEL_INTENSITY = 1.5; // Fresnel contribution factor
    const float SUBSURFACE_INTENSITY = 2; // Subsurface scattering factor

    if (PassNum == 0)
    {
        // Pass 0: Dynamic thickness with softened turbulence
        float baseThickness = 200e-9;
        float waveThickness = 100e-9 * sin(input.uv.x * 20.0 + TotalTime) +
                              50e-9 * cos(input.uv.y * 15.0 - TotalTime);

        // Sample depth map using depth2D
        float depth = depth2D(depthMap, input.uv);
        float modulatedThickness = baseThickness + depth * waveThickness;

        // Add softened turbulence
        float2 uvNoise = input.uv * 3.0 + float2(TotalTime * 0.2, TotalTime * 0.15);
        float curlNoise = sin(dot(uvNoise, float2(12.9898, 78.233)) * 43758.5453) * 20e-9;
        modulatedThickness += curlNoise;

        // Convert to micrometers
        float thickness = mToUm(modulatedThickness);

        // Store thickness in rt1
        output.rt1 = float4(thickness, 0.0, 0.0, 1.0);
    }
    else if (PassNum == 1)
    {
        // Pass 1: Thin-film interference with normalized intensities

        // Read thickness from rt1
        float thickness = diffuse2D(rtMap1, input.uv).r;

        // Wavelengths for RGB in micrometers
        float3 wavelengthsM = mToUm(float3(650e-9, 550e-9, 450e-9));

        // Film and surrounding refractive indices
        float3 nFilm = float3(1.33, 1.33, 1.33); // Water-like oil film
        float3 nSurrounding = float3(1.0, 1.0, 1.0); // Air

        // Normal from normal map using normal2D11W
        float3 normal = normal2D11W(normalMap, input.uv);

        // Incident light vector (approximation)
        float3 lightDir = normalize(float3(-0.5, 0.5, 1.0));

        // Cosine of the transmission angle
        float3 cosThetaT = ONE3 * dot(normal, lightDir);

        // Calculate Optical Path Difference (OPD)
        float3 OPD = 2.0f * nFilm * thickness * cosThetaT;

        // Phase calculations
        float3 phaseDifference = (TWOPI3 * OPD) / wavelengthsM;
        float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, nFilm);
        float3 totalPhase = phaseDifference + reflectionPhaseShift;

        // Interference pattern (normalized)
        float3 interferenceResult = max(0.0, cos(totalPhase));

        // Combine with base diffuse map color
        float3 baseColor = diffuse2D(diffuseMap, input.uv).rgb;
        float3 combinedColor = BRIGHTNESS * baseColor * interferenceResult;

        // Store in rt2
        output.rt2 = float4(combinedColor, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Smoothed surface motion and turbulence

        // Read interference result
        float3 combinedColor = diffuse2D(rtMap2, input.uv).rgb;

        // Smoothed velocity perturbation
        float2 velocity = float2(
            sin(input.uv.y * 10.0 + TotalTime * 0.2),
            cos(input.uv.x * 10.0 - TotalTime * 0.2)
        ) * TURBULENCE_SCALE;

        // Normal map perturbation using normal2D11W
        float3 normal = normal2D11W(normalMap, input.uv);
        float2 normalPerturb = normal.xy * 0.01;

        // Combine velocity and normal perturbations
        float2 distortedUV = input.uv + velocity + normalPerturb;

        // Sample distorted interference pattern
        float3 distortedResult = diffuse2D(rtMap2, distortedUV).rgb;

        // Blend turbulence into the result
        float3 blendedResult = lerp(combinedColor, distortedResult, 0.4);

        // Store in rt3
        output.rt3 = float4(blendedResult, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Subsurface scattering and refined Fresnel reflectance

        // Read blended result
        float3 blendedResult = diffuse2D(rtMap3, input.uv).rgb;

        // Subsurface scattering (light diffusion under the oil film)
        float lightPenetration = exp(-dot(blendedResult, blendedResult) * 0.5);
        float3 subsurfaceColor = blendedResult * lightPenetration * SUBSURFACE_INTENSITY;

        // Fresnel reflectance for dynamic highlights
        float3 normal = normal2D11W(normalMap, input.uv);
        float3 viewDir = ToTangentSpace11(normalize(float3(input.uv, 1.0)));
        float fresnel = pow(1.0 - abs(dot(normal, viewDir)), 5.0) * FRESNEL_INTENSITY;

        // Combine all effects
        float3 finalColor = subsurfaceColor + fresnel * float3(1.0, 1.0, 1.0);

        // Store in rt1 for display
        output.rt1 = float4(finalColor, 1.0);
    }

    return output;
}
psout gratingRainbow(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    // Constants
    const float GRATING_SCALE = f1 + 20.0; // Frequency of grating pattern
    const float RAINBOW_SCALE = f2 + 1.5; // Controls rainbow dispersion
    const float INTERFERENCE_SPEED = f3 + 0.5; // Speed of wave motion
    const float INTERFERENCE_INTENSITY = f4 + 0.8; // Strength of interference waves
    const float FRESNEL_INTENSITY = f5 + 0.6; // Fresnel reflectance factor

    if (PassNum == 0)
    {
        // Pass 0: Procedural grating pattern
        float4 grating = diffuse2D(gratingMap1, input.uv);
        
        // Store grating pattern in rt1
        output.rt1 = grating;
    }
    else if (PassNum == 1)
    {
        // Pass 1: Rainbow refraction effect

        // Read grating pattern
        float grating = diffuse2D(rtMap1, input.uv).r;

        // Create wavelength-based refraction effect
        float3 rainbow = float3(
            grating * (1.0 + sin(TotalTime * AnimateSpeed * RAINBOW_SCALE) * 0.1),
            grating * (1.0 + cos(TotalTime * AnimateSpeed * RAINBOW_SCALE) * 0.1),
            grating * (1.0 + sin(TotalTime * AnimateSpeed * RAINBOW_SCALE + 1.57) * 0.1)
        );

        // Store rainbow effect in rt2
        output.rt2 = float4(rainbow, 1.0);
    }
    else if (PassNum == 2)
    {
        // Pass 2: Interference waves

        // Read rainbow effect
        float3 rainbow = diffuse2D(rtMap2, input.uv).rgb;

        // Add dynamic interference pattern
        float2 uvOffset = input.uv - 0.5;
        float radius = length(uvOffset) * INTERFERENCE_INTENSITY;
        float interference = sin(radius * 20.0 - TotalTime * AnimateSpeed * INTERFERENCE_SPEED);

        // Combine interference with rainbow
        float3 interferenceColor = rainbow * (0.8 + 0.2 * interference);

        // Store interference effect in rt3
        output.rt3 = float4(interferenceColor, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Fresnel reflectance and highlights

        // Read interference color
        float3 interferenceColor = diffuse2D(rtMap3, input.uv).rgb;

        // Fresnel reflectance
        float3 viewDir = safeNormalize(ToTangentSpace11(normalize(float3(input.uv, 1.0))));
        float3 normal = safeNormalize(normal2D11W(gratingNormal1, input.uv));
        float fresnel = pow(1.0 - saturate(abs(dot(normal, viewDir))), abs(FresnelPower)) * FRESNEL_INTENSITY;

        // Combine Fresnel reflectance with interference effect
        float3 finalColor = interferenceColor + fresnel;

        // Store final result in rt1 for display
        output.rt1 = float4(finalColor, 1.0);
    }

    return output;
}




psout PS(PS_INPUT input)
{
    float time = TotalTime * AnimateSpeed;
    psout output = (psout) 0;
    InitPSOut(output, input.uv);
    
    bool useProjectedDepth = !KeyQDown;
    bool invertDepth = !KeyEDown;

    float currentDepthScale = lerp(1.0, DepthScale, useProjectedDepth);
    float2 currentDepthRange = lerp(float2(MIN_DEPTH_RANGE, MAX_DEPTH_RANGE), DepthRange, useProjectedDepth);
    DepthRange = currentDepthRange;
    DepthScale = currentDepthScale;
    
    float2 oosz = GetOosz(diffuseMap);
   
    int2 sz = GetSz_1(depthMap);
    
    int item = 1;
    
    int2 cellSize = int2(int(f11), int(f12));
     
    int colsPerRow = int(floor(uint(sz.x) / uint(cellSize.x)));
    
    float2 uvI = float2(
        (input.uv.x * float(sz.x) / float(cellSize.x)),
        (input.uv.y * float(sz.y) / float(cellSize.y))
    );
    int2 uvIi = int2(uvI);

    int hCount = int(floor(uint(sz.x) / uint(cellSize.x)));
    int vCount = int(floor(uint(sz.y) / uint(cellSize.y)));
    
    int uvCol = uvI.x;
    int uvRow = uvI.y;
    
/*    if (any(uvIi != int2(uvI + oosz * 30)))
    {
        discard;
        output.rt1 = float4(0, 0, 0, 1);
    }
    else*/
    {
        float3 test = ZERO3;
        
        int ix = clamp(uvRow * colsPerRow + uvCol, 0, 37);
        
       /* Lighting lighting = PopulateLighting(input.uv, float3(ViewX, ViewY, ViewZ), float3(SunX, SunY, SunZ), invertDepth, useProjectedDepth, currentDepthScale, currentDepthRange, MaterialIndex, AnimateSpeed, ParallaxScale, NormalRadius, HeightScale, dispersionIndex, Gamma, Mix3, Mix2, test);*/
        
        int dispersionIndex = 0;
        if (PassNum > 0)
        {
        //    dispersionIndex = fmod(decodeInt(rtMap8.Load(int3(0, 0, 0))) + 1, 3.0);
        }
        LightingComplex lightingComplex = PopulateLightingComplex(input.uv, float3(ViewX, ViewY, ViewZ), float3(SunX, SunY, SunZ), invertDepth, useProjectedDepth, currentDepthScale, currentDepthRange, MaterialIndex, AnimateSpeed, ParallaxScale, NormalRadius, Mix3, dispersionIndex, Gamma, HeightScale, FresnelMix, test);
        
        getColorComplex(diffuseMap, input, lightingComplex, KeyWDown ? ix : MaterialIndex, dispersionIndex, output);
       
        output.rt1 = rotateHue(lerp(output.rt1, output.rt1 * gratingRainbow(input).rt1, .5) * dot(lightingComplex.viewDir, ToTangentSpace11(RotateAxisAngle(normalize(gratingNormal4.SampleLevel(sampleTypeMirror, input.uv - 0.5 - (1.0 - lightingComplex.depth), 0).xyz) * 2.0 - 1.0, float3(0, 0, 1), ct11 * .1))), time * 360);
        if (length(input.uv) <= length(GetOosz(rtMap8)))
        {
            output.rt8 = encodeInt(dispersionIndex);
        }
        //output.rt1 *= diffuse2D(diffuseMap, input.uv);
      /*
        output.rt1.rgb *= (1.0 - Fresnel3(input.uv, time, output.rt1.rgb * lightingComplex.totalLighting[dispersionIndex], lightingComplex.viewDir, lightingComplex.normal, lightingComplex.material.thicknessM, FresnelPower, FresnelReflectance, lightingComplex.nSurrounding, lightingComplex.material.etaR, lightingComplex.material.dispersionCoefficientsNm2[dispersionIndex])) * lightingComplex.NdotV3 * .75;*/
        
        if (KeyShift)
        {
            if (KeyQDown)
                output.rt1 = float4(diffuse2D(diffuseMap, input.uv).rgb, 1.0);
            if (KeyWDown)
                output.rt1 = float4(normalMap.Sample(sampleTypeMirror, input.uv).xyz, 1.0);
            if (KeyEDown)
            {
                float sampledDepth = depth2D(depthMap, input.uv);
                output.rt1 = float4(sampledDepth.xxx, 1.0);
            }
        }
    }
    return output;
}