#define AnimateTime TotalTime*AnimateSpeed
#define SetDV(name,val) { Complex3 _##name [3]; _##name = lighting.##name; _##name [dispersionIndex] = val; lighting.##name = _##name; }


#define SetDVo(name,val) { OpticalPathResult _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }

#define SetDVf(name,val) { float3 _##name[3];_##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }

#define C3 Complex3
#define CV(v1,v2) ComplexCreate(v1,v2)
#define CV0(v) CV(v,ZERO3)
#define C0V(v) CV(ZERO3,v)
#define CVV(v) CV(v,v)

#define CEPSILON3 CV0(EPSILON3)
#define C0VEPSILON3 C0V(EPSILON3)
#define CVEPSILON3 CV0(EPSILON3)
#define CVVEPSILON3 CVV(EPSILON3)

#define CVVOneMinusEPSILON3 CVV(OneMinusEPSILON3)
#define COneMinusEPSILON3 CV0(OneMinusEPSILON3)
#define CVOneMinusEPSILON3 CV0(OneMinusEPSILON3)
#define C0VOneMinusEPSILON3 C0V(OneMinusEPSILON3)

#define ComplexToTangent11(v) ToTangentSpace11(safeNormalize(ComplexAdd(Complex00, v)))
#define CTime CV0(AnimateTime)
#define CVVTime CVV(AnimateTime)
#define CV0Time CV0(AnimateTime)
#define C0VTime C0V(AnimateTime)
#define C00 CVV(ZERO3)
#define C0 C00
#define C10 CV0(ONE3)
#define C01 C0V(ONE3)
#define C11 CVV(ONE3)
#define C1 C11
#define C2 C22
#define C20 CV0(TWO3)
#define C02 C0V(TWO3)
#define C22 CVV(TWO3)
#define CPI CVV(PI3)
#define C2PI CVV(TWO3*PI3)
#define C2PI0 CV0(TWO3*PI3)
#define C02PI C0V(TWO3*PI3)
#define CPI0 CV0(PI3)
#define C0PI C0V(PI3)
#define CV1(v) CV(v,ONE3)

#define C0p5 C0V(0.5)
#define Cp50 CV0(0.5)
#define Cp5 CVV(0.5)
#define C0p25 C0V(0.25)
#define Cp250 CV0(0.25)
#define Cp25 CVV(0.25)
#define C0p125 C0V(0.125)
#define Cp1250 CV0(0.125)
#define Cp125 CVV(0.125)



#define CSat(v) ComplexSaturate(v)
#define CSatMag(v) CSat(CMag(v))
#define CVVSat(v) CSat(v)
#define CV0Sat(v) CSat(CV0(v.real))
#define C0VSat(v) CSat(C0V(v.imag))

#define CV0Satf(v) CV0Sat(CV0(v)).real
#define C0VSatf(v) C0VSat(C0V(v)).imag




#define CAdd(v1,v2) ComplexAdd(v1,v2)
#define CSub(v1,v2) ComplexSub(v1,v2)
#define CSubMaxE(v1,v2) CMax(CSub(v1,v2),CEPSILON3)
#define CSubMax0(v1,v2) CMax(CSub(v1,v2),C0)
#define CDiv(v1,v2) ComplexDiv(v1,v2)
#define CMul(v1,v2) ComplexMul(v1,v2)
#define CAbs(v) ComplexAbs(v)
#define CCos(v) ComplexCos(v)
#define CSin(v) ComplexSin(v)
#define CVSubp5(v) CSub(CV0(v)), Cp50)
#define C0VSubp5(v) CSub(C0V(v.imag)), C0p5)
#define CSubp50(v) CSub(v,Cp50)
#define CMulp50(v) CMul(v,Cp50)
#define CAddp50(v) CAdd(v,Cp50)
#define CMulp250(v) CMul(v,Cp250)
#define CVMulp50(v) CMul(CV0(v)), Cp50)
#define C0VMulp5(v) CMul(C0V(v)), C0p5)
#define CSqrt(v) ComplexSqrt(v)
#define CMax(a,b) ComplexMax(a,b)
#define CMin(a,b) ComplexMin(a,b)
#define CVRed CV0(float3(1,0,0))
#define CVGreen CV0(float3(0,1,0))
#define CVBlue CV0(float3(0,0,1))
#define CVVSatAbs(v) CSat(CAbs(CVV(v)))
#define CVSatAbs(v) CSat(CAbs(CV0(v)))
#define C0VSatAbs(v) CSat(CAbs(C0V(v)))
#define CVSatMag(v) CSat(CMag(CV0(v)))
#define C0VSatMag(v) CSat(CMag(C0V(v)))
#define CVSatMag(v) CSat(CMag(CV0(v)))

#define CLenSatMag(v) CLength(CSat(CMag(v)))

#define CV0Sub10(v) CSub(CV0(v),C10)
#define C0VSub01(v) CSub(C0V(v),C01)
#define CVVSub11(v) CSub(CVV(v),C11)

#define C01Sub0V(v) CSub(C01,C0V(v))
#define C10SubV0(v) CSub(C10,CV0(v))
#define C11SubVV(v) CSub(C11,CVV(v))

#define C0VAdd01(v) CAdd(C01,C0V(v))
#define CV0Add10(v) CAdd(C10,CV0(v))
#define CVVAdd11(v) CAdd(C11,CVV(v))
#define CClamp01(v) CMin(CMax(v,CEPSILON3),COneMinusEPSILON3)

#define CMulp5(v) CMul(v,Cp5)
#define CMulp25(v) CMul(v,Cp25)
#define CMulp125(v) CMul(v,Cp125)

#define CMulPI(v) CMul(v,CPI)
#define CMul2PI(v) CMul(v,C2PI)
#define CDivPI(v) CDiv(v,CPI)
#define CDiv2PI(v) CDiv(v,C2PI)
#define CPIDiv(v) CDiv(CPI,v)
#define C2PIDiv(v) CDiv(C2PI,v)
#define CMul2(v) CMul(v,C22)
#define CMul02(v) CMul(v,C02)
#define CMul20(v) CMul(v,C20)

#define CV0MulPI(v) CMul(CV0(v),CPI)
#define CV0Mul2PI(v) CMul(CV0(v),C2PI)
#define CV0DivPI(v) CDiv(CV0(v),CPI)
#define CV0Div2PI(v) CDiv(CV0(v),C2PI)
#define CV0PIDiv(v) CDiv(CPI,CV0(v))
#define CV02PIDiv(v) CDiv(C2PI,CV0(v))
#define CVVMul2(v) CMul(CVV(v),C22)
#define CV0Mul2(v) CMul(CV0(v),C20)

#define C0VMulPI(v) CMul(C0V(v),C0PI)
#define C0VMul2PI(v) CMul(C0V(v),C02PI)
#define C0VDivPI(v) CDiv(C0V(v),C0PI)
#define C0VDiv2PI(v) CDiv(C0V(v),C02PI)
#define C0VPIDiv(v) CDiv(C0PI,C0V(v))
#define C0V2PIDiv(v) CDiv(C02PI,C0V(v))
#define C0VMul2(v) CMul(C0V(v),C02)

#define C0VMul2Sub1(v) CSub(CMul(C0V(v),C02),C01)
#define CV0Mul2Sub1(v) CSub(CMul(CV0(v),C20),C10)
#define CVVMul2Sub1(v) CSub(CMul(CVV(v),C22),C11)
#define CV0Mulp5Addp5(v) CAdd(CMul(CV0(v),Cp50),Cp50)
#define C0VMulp5Addp5(v) CAdd(CMul(C0V(v),C0p5),C0p5)
#define CVVMulp5Addp5(v) CAdd(CMul(CVV(v),Cp5),Cp5)

#define CMul20Sub10(v) CSub(CMul(v,C20),C10)
#define CMul02Sub01(v) CSub(CMul(v,C02),C01)
#define CMul2Sub1(v) CSub(CMul(v,C2),C1)
#define CMulp50Addp50(v) CAdd(CMul(v,Cp50),Cp50)
#define CMul0p5Add0p5(v) CAdd(CMul(v,C0p5),C0p5)
#define CMulp5Addp5(v) CAdd(CMul(v,Cp5),Cp5)

#define C0VRange11ToRange01(v) C0VMul0p5Add0p5(v)
#define CV0Range11ToRange01(v) CV0Mulp50Addp50(v)
#define CV0Range01ToRange11(v) CV0Mul20Sub10(v)
#define C0VRange01ToRange11(v) C0VMul02Sub01(v)

#define CV0Normalize11(v) safeNormalize(CV0Mul2Sub1(v))
#define CNormalize01f(v) safenormalize(CV01f(v))
#define CNormalize11(v) safeNormalize(CV11(v))
#define CNormalize01(v) safenormalize(CV01(v))

#define CExp(v) ComplexExp(v)
#define CPow(v,n) ComplexPow(v,n)
#define CLen(v) ComplexLength(v)
#define CDot(v1,v2) ComplexDot(v1,v2)
#define CDot3(v1,v2) ComplexDot3(v1,v2)
#define CDotSat(v1,v2) CSat(CDot(v1,v2))
#define CMag(v) ComplexMagnitude(v)
#define CMagf(v) length(CMag(v).real)
#define CMagSq(v) ComplexMagnitudeSquared(v)
#define ComplexIntensity(a) ComplexMagnitudeSquared(a)

#define CMMul(m1,m2,m3) CMul(CMul(m1,m2),m3)
#define CMAdd(m1,m2,a1) CAdd(CMul(m1,m2),a1)
#define CAAdd(v1,v2,v3) CAdd(CAdd(v1,v2),v3)
#define CAddM(a1,a2,m3) CMul(CAdd(a1,a2),m3)
#define CAddMA(a1,a2,m3,a4) CAdd(CMul(CAdd(a1,a2),m3),a4)

#define CSPEED_OF_LIGHT CV0(SPEED_OF_LIGHT)
#define C0VSPEED_OF_LIGHT C0V(SPEED_OF_LIGHT)
#define CV0SPEED_OF_LIGHT CSPEED_OF_LIGHT

#define CV0MulSOL(v) CMul(CV0(v),CSPEED_OF_LIGHT)
#define C0VMulSOL(v) CMul(C0V(v),C0VSPEED_OF_LIGHT)
#define CMulSOL(v) CMul(v,CSPEED_OF_LIGHT)

#define CV0DivSOL(v) CDiv(CV0(v),CSPEED_OF_LIGHT)
#define C0VDivSOL(v) CDiv(C0V(v),C0VSPEED_OF_LIGHT)
#define CDivSOL(v) CDiv(v,CSPEED_OF_LIGHT)

#define CV0SOLDiv(v) CDiv(CSPEED_OF_LIGHT,CV0(v))
#define C0VSOLDiv(v) CDiv(C0VSPEED_OF_LIGHT,C0V(v))
#define CSOLDiv(v) CDiv(CSPEED_OF_LIGHT,v)




#define MAX_PARALLAX_INTERSECTIONS 3
#define MAX_PARALLAX_REFINE_ITERATIONS 8
#define MAX_PARALLAX_LAYERS 8
#define MaterialIndex2 4

// Maximum number of light sources
#define MAX_LIGHT_SOURCES 8

#define HOLOGRAM_SIZE_M f10

#define MAX_GRATING_LAYERS 10
#define MAX_GAUSSIAN_POINTS 3
#define MAX_INTERFERENCE_POINTS MAX_GAUSSIAN_POINTS
#define MAX_SHADOW 3
#define MIN_DEPTH_RANGE 0
#define MAX_DEPTH_RANGE DepthScale

#define DepthScale vDepthScale
#define DEPTH_RANGE DepthScale

#define MIN_DEPTH_RANGE_PROJECTED 0
#define MAX_DEPTH_RANGE_PROJECTED DepthScale

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
#define SELLMEIER_THIN_FILM_PROPERTY(ior,thicknessM,c) CreateThinFilmProperties(thicknessM,SELLMEIER_COEFFICIENTS(ior,c))



struct Complex3
{
    float3 real;
    float3 imag;
};

struct Complex2
{
    float2 real;
    float2 imag;
};
struct Polar3
{
    float3 magnitude;
    float3 angle;
};

struct SellmeierCoefficientsBC
{
    float3 B;
    float3 C;
};

struct SellmeierCoefficientsOE
{
    SellmeierCoefficientsBC O;
    SellmeierCoefficientsBC E;
};

struct SellmeierCoefficients
{
    SellmeierCoefficientsOE OE1;
    SellmeierCoefficientsOE OE2;
    SellmeierCoefficientsOE OE3;
};

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

struct MaterialProperties
{
    SellmeierCoefficientsBC coeff;
    float3 k;
    float thicknessM;
    float3 absorptionM;
    C3 wavelengthsNM;
    float3 transmissionCoefficient;
};

// Struct for Anisotropic Roughness Parameters
struct AnisotropicRoughness
{
    float alphaX; // Roughness along X-axis
    float alphaY; // Roughness along Y-axis
};
// Struct for Thin-Film Properties
struct ThinFilmProperties
{
    C3 filmThicknessM; // Thickness of each thin film layer (meters)
    SellmeierCoefficients filmEta_coeffs; // Refractive index coefficients for thin film
};

struct HSL
{
    float h; // Hue in degrees [0, 360)
    float s; // Saturation [0, 1]
    float l; // Lightness [0, 1]
};

struct HologramData
{
    float3 Color;
    C3 wavelengthsNM;
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
    C3 wavelengthNM; // Wavelength in nanometers for RGB components
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
    C3 wavelengthNM;
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
    C3 wavelengthNM; // Wavelength in nanometers for each color channel
    float intensity; // Light intensity
    float coherenceLength; // Coherence length in meters or safeNormalized units
    float phaseOffset; // Initial phase offset for interference effects
    float4x4 lightSpaceMatrix; // Transformation matrix to light's local space, could be used for complex patterns or 3D encoding
    float2 textureUVScale; // Scale for UV mapping if texture-based interference is used
    float angularSpread; // For simulating divergence or spread of the holographic beam
};


struct InterferencePattern
{
    C3 amplitude; // Strength of the interference pattern
    C3 frequency; // Frequency of the pattern in 3D space
    C3 phase; // Phase shift for the pattern
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

struct MaterialSellmeier
{
    SellmeierCoefficients coeff;
    
    float3 absorptionCoefficient;
    float3 scatteringCoefficient;
    float roughness;
    float metallic;
    float3 metallicReflectance;
    C3 thicknessM;
    float3 albedo;
    float3 etaR;
    float3 etaI;
    float3 dispersionCoefficientsNm2[3];
    
    float3 etaO;
    float3 etaE;
    C3 opticalAxis;
    float nSurrounding;
    C3 coherenceLengthM;
    float polarizationAngle;
    float temperatureC;
    float3 density;
    float3 thermalConductivity;
    float3 elasticModulus;
};



struct OpticalPathResult
{
    C3 wavelengthsNM;
    float3 refractiveIndex;
    PathMeasurement measurement;
    PathMeasurement opticalMeasurement;
    PhaseInterference phaseInterference;
    C3 intensityModulationM;
    float3 absorptionEffect;
};

struct Complex3x3
{
    C3 tangent;
    C3 bitangent;
    C3 normal;
};

// Structure for complex numbers with polarization
struct ComplexPolarized
{
    float realHorizontal;
    float imagHorizontal;
    float realVertical;
    float imagVertical;
};
struct FilmLayer
{
    SellmeierCoefficientsBC coefficients; // Sellmeier coefficients for the layer
    float3 thicknessM; // Thickness of the layer in meters
    float3 k; // Imaginary refractive indices (RGB)
};
struct DiffractionOrder
{
    int order; // Diffraction order (e.g., 1 for first-order)
    float strength; // Strength/intensity of the order
    float wavelengthFactor; // Factor to adjust wavelength for dispersion
};
struct GratingLayer
{
    float period; // Grating period in UV space
    float orientation; // Grating orientation in radians
    float strength; // Strength of the diffraction effect
    float phaseOffset; // Phase offset in radians
};
// Define material properties
struct MaterialDispersion
{
    float3 refractiveIndexBase; // Base refractive index for R, G, B
    float3 dispersionCoefficient; // Dispersion coefficients for R, G, B
};
struct QuantumGaussianBeam
{
    float3 position;
    float3 direction;
    float beamWaist;
    float divergence;
    float peakIntensity;
    float phaseShift;
};


    ////////////////////////////////////////////////////////////////////////////////
// Configuration & Pass Data
////////////////////////////////////////////////////////////////////////////////



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



////////////////////////////////////////////////////////////////////////////////
// Complex3Pol for TE/TM
////////////////////////////////////////////////////////////////////////////////
struct Complex3Pol
{
    float3 realTE;
    float3 imagTE;
    float3 realTM;
    float3 imagTM;
};


// Structure to hold transmission coefficients for Ordinary and Extraordinary rays
struct TransmissionResult
{
    float3 TransmissionO; // Ordinary transmission coefficients (RGB)
    float3 TransmissionE; // Extraordinary transmission coefficients (RGB)
};

struct ParallaxResult
{
    float2 prevUV;
    int intersectionCount;
    float2 deltaUVs[MAX_PARALLAX_INTERSECTIONS];
};
struct Complex2ParallaxResult
{
    Complex2 prevUV; // The previous complex UV coordinate.
    int intersectionCount; // Number of detected holographic intersections.
    Complex2 deltaUVs[MAX_PARALLAX_INTERSECTIONS]; // Array of complex offsets (delta UVs).
};
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

struct OffsetScalar
{
    float3 Offset;
    float3 Scalar;
};


struct ValueTransformFloat3
{
    float3 Value;
    OffsetScalar Transform;
};

struct InterferenceSpiralConfig
{
    OffsetScalar Frequency;
    OffsetScalar Amplitude;
    OffsetScalar Color;
    OffsetScalar Pixel;
};


struct Lighting
{
    // 1. Material Information
    MaterialSellmeier material;
    float3 albedo;
    float3 albedoWavelengthsNM;
    float3 albedoWavelengthsM;
    
    float3 nSurrounding;
    
    // 2. Geometry Information
    
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

    
    C3 phaseShiftComplex[3];
    C3 internalComplex[3];
    C3 externalComplex[3];
    C3 totalReflectanceComplex[3];
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
    float fDepthScale;
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
    float fDepthScale;
    float2 DepthRange;
    
    // Depth Settings
    bool invertDepth;
    bool useProjectedDepth;
    // 1. Material Information
    MaterialSellmeier material;
    float3 albedo;
    float3 albedoWavelengthsNM;
    float3 albedoWavelengthsM;
    
    float3 nSurrounding;
    C3 waveInterference;
    C3 caustics;
    // 2. Geometry Information
    
    float3 pixelPos;
    float3 normal;
    float3x3 TBNf;
    C3 opticalAxis;
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
    C3 compositeSpecular;
    C3 filmReflectedPolarization;
    C3 transmittedPolarization;
    C3 internalFilmReflectance;
    C3 externalFilmReflectance;
    C3 interferenceColorReflectance;
    C3 interferenceColorTransmittance;
    
    float3 interferenceIntensity[3];
    
    float3 totalLighting[3];
    
    C3 phaseShiftComplex[3];
    C3 internalComplex[3];
    C3 externalComplex[3];
    C3 totalReflectanceComplex[3];
    C3 phase[3];
    C3 phaseShift[3];
    C3 diffuseReflectance[3];
    C3 diffuseTransmittance[3];
    C3 specularContribution[3];
    C3 interferenceContribution[3];
    
    float ggxDistribution;
    
    float3 cookTorrenceSpecular;
    float3 sheen;

    float3 advancedSheen;
    float3 clearCoatSpecular;
    float3 iridescence;
    float3 specularWithSheen;
    
    C3 cosThetaTransmissionInside;
    C3 cosThetaTransmissionOutside;
    
    float3 microfacetSpecular;
    C3 HeatHazeRainbowCaustics;
    
    PathMeasurement viewToPixel;
    OpticalPathResult opdAlbedoTransInsideRealChannel[3];
    OpticalPathResult opdAlbedoTransInsideImagChannel[3];
    OpticalPathResult opdAlbedoTransOutsideRealChannel[3];
    OpticalPathResult opdAlbedoTransOutsideImagChannel[3];
    C3 reflectance[3];
    C3 transmittance[3];
    
    C3 iorEffectiveInsideReflectance[3];
    C3 iorEffectiveInsideTransmittance[3];
    C3 iorEffectiveOutsideReflectance[3];
    C3 iorEffectiveOutsideTransmittance[3];
    
 
};

/*
CAPS 
	f4 0 to 1(50)
	F7 0 TO 1
	Z0 0 TO 1 (BRIGHTNESS)
	F12 0 TO 10 (BRIGHTNESS)
	
f4 = .1 to 1.0
f5 = 0 to 1
f6, f7


    MaterialIndex2
    color = FinalPassToneMap(color, TanhFactorR);
    color = FinalPassApplyBloom(color, bloomColor, TanhFactorG);
    color *= FinalPassSharpen(rtMap, rtUV, TanhFactorB, samplerState);
    color = FinalPassColorGrade(color, ONE3 * CosineFactorR, ONE3 * CosineFactorG, ONE3 * CosineFactorB);
 
    color = FinalPassGammaCorrection(color, Gamma);
    color = FinalPassAdjustSaturation(color, HeightParamA);
    
    color = FinalPassApplyVignette(color, rtUV, GetSz_4(rtMap1), HeightParamB);
    color *= FinalPassChromaticAberration(color, rtMap1, rtUV, samplerState, HeightParamC * (1.0 - depth));
   

You are the leading expert at HLSL Shader Model 5.0 Holography. You understand the mathematics behind holographic rendering, including interference wavefronts. Create pixel shaders using HLSL SM 5 (Shader Model 5). You have advanced knowledge of wave interference patterns, RGB wavelengths, XYZ to linear RGB, light travel time, Chromaticity, calculus, matrix transposing, diffraction patterns, HSV rotations, Gaussian sampling, Optical Path Difference, Phase Shift with Reflection, Effective Refractive Indices, Tangent, Bitangent, Normals, world space to object space, advanced sigmoid easing, Complex numbers, CosThetaI, CosThetaT, Chromatic Dispersion, Gratings, Tone Mapping, Phase Interference, Intensity Modulation, absorption, Gaussian Beams, divergence, coherence, amplitude, frequency, measurements in nanometers (Nm), Meters (M), Micrometers (Um), HSL (Hue, Saturation, Lightness), Sellmeier Coefficients, D1/D2/D3 dispersion coefficients, Stratified Sampling, Snells Law, Fresnel Reflectance, Fresnel Transmittance, Fresnel Film Reflectance, optimization using Half, Half2, Half3, Anisotropic NDF, Anisotropic Roughness, Refractive Index, Vibrational Modes, grating maps, gradient maps, diffuse maps,normal maps, depth maps, render targets, constant buffer, Planck Constant, Safe Normalization, Gamma Adjustment, sincos, encoding int, decoding int, using #define for advanced programming, EPSILON for safe divisions, clamping for safe sqrt, multiple parallax intersections, simplification using defined constants such as ZERO3 for float3(0.0, 0.0, 0.0), floating point values using 0.0 in instead of just 0 so the compiler knows the difference between a float and an integer, sub surface scattering, wavelength dependent blur, gaussian wavelength dependent operations, aberrations, Fresnel term, horizontal and vertical blur sampling, UV size awareness, specular transmission, multilayer thin film transmission, GGX distribution, Geometry Smith GGX, Smith GGX Correlated, Microfacet, Film Layers, Diffraction Orders, Polarization, Angle Dependent Phase Shifting, Procedural Grating Patterns, Cook Torrance BRDF, Sobel Kernels, Microfacet BRDF, Deterministic Lighting, Phase Aligned Light Sources, Heat Haze, Bokeh Depth of Field, Iridescence, Anisotropic Bloom, Gaussian Depth Glow, Rainbows, Dichroism, Secant Rainbows, Photon Transport, Birefringent Transmission, Optical Axis, Dispersion Correction, Polarization State Evolution, Polarization Wave Propagation, Double Refraction, Delta Phi, Real, Imaginary, Ordinary, Extraordinary, CosThetaM, SinThetaM, Masking, UV Stacks, loop, unroll, coarse and fine intersection refinement, Vector Rotation, tangent space, elliptical anisotropy, elliptical axis reorientation, temporal deformation, splatting, specular PBR, Linear Falloff, diffraction direction, noise ridged MF, filmic tone mapping, synchronized multi wave interference, wavenumber, spiral interference, Lambertian BRDF diffuse, parallax occlusion mapping, Birefringent Rays, internal diffusion. Knowledge allows for precise programming, using correct data types and parameters required for operations, such as pow requiring values above zero, hue rotation using values between 0 and 360, measurements of light position distance to the viewpoint, the addition and subtraction of waves, as well as meticulous knowledge of shader model 5.0 limitations such as indexing of properties in a loop.



When creating your shaders, consider these factors:



- Target Platform: Determine the specific hardware and software requirements for your holographic application.

- Performance Optimization: Optimize your shaders for efficient rendering and minimal resource consumption.

- Code Readability: Maintain clear and well-commented code for easy understanding and collaboration.

- Testing and Debugging: Thoroughly test your shaders on various devices and configurations to ensure functionality and stability.



By following these guidelines, you can create high-quality holographic shaders that deliver immersive and visually stunning experiences.
*/

C3 ComplexCreateCS(float3 amplitude, float3 angle)
{
    C3 c;
    c.real = amplitude * cos(angle);
    c.imag = amplitude * sin(angle);
    return c;
}

// Core C3 versions

inline C3 ComplexCreate(float3 r, float3 i)
{
    C3 c;
    c.real = r;
    c.imag = i;
    return c;
}

C3 ComplexLerp(C3 a, C3 b, C3 n)
{
    return CV(
        lerp(a.real, b.real, n.real),
        lerp(a.imag, b.imag, n.imag));
}
inline C3 ComplexAdd(C3 a, C3 b)
{
    C3 result;
    result.real = a.real + b.real;
    result.imag = a.imag + b.imag;
    return result;
}
C3 ComplexSub(C3 c, C3 f)
{
    C3 r;
    r.real = c.real - f.real;
    r.imag = c.imag - f.imag;
    return r;
}

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
inline float3 ComplexPhaseUnwrap(float3 prevPhase, float3 currentPhase)
{
    float3 delta = currentPhase - prevPhase;
    // Assume PI3 is a float3 with the value (pi, pi, pi)
    // Wrap delta into the interval [-pi, pi]
    delta = delta - 2.0 * PI3 * round(delta / (2.0 * PI3));
    return prevPhase + delta;
}

// Computes the wrapped phase difference between two complex numbers.
inline float3 ComplexArgDiff(C3 a, C3 b)
{
    float3 phaseA = atan2(a.imag, a.real);
    float3 phaseB = atan2(b.imag, b.real);
    float3 diff = phaseA - phaseB;
    // Wrap diff to [-pi, pi]: assumes PI3 is defined.
    diff = diff - 2.0 * PI3 * floor((diff + PI3) / (2.0 * PI3));
    return diff;
}


// Normalizes the phase of a complex number to the interval [0, 2π).
inline float3 NormalizeComplexPhase(C3 c)
{
    float3 phase = atan2(c.imag, c.real);
    // fmod returns the remainder after division. Adding 2π ensures a positive result.
    return fmod(phase + 2.0 * PI3, 2.0 * PI3);
}


inline float2 sincos2(float angle)
{
    float2 sc;
    sincos(angle, sc.x, sc.y);
    return sc;
}


inline C3 ComplexMax(C3 a, C3 b)
{
    return CV(max(a.real, b.real), max(a.imag, b.imag));
}
inline C3 ComplexMin(C3 a, C3 b)
{
    return CV(min(a.real, b.real), min(a.imag, b.imag));
}


float ComplexLength(C3 a)
{
    return length(sqrt(a.real * a.real + a.imag * a.imag));
}

C3 ComplexMagnitudeSquared(C3 a)
{
    return CV0(a.real * a.real + a.imag * a.imag);
}


C3 ComplexSqrt(C3 z)
{
    // Compute the magnitude (r) for each component.
    float3 r = sqrt(z.real * z.real + z.imag * z.imag);
    
    // Compute u and v using the standard formulas.
    float3 u = sqrt(0.5 * (r + z.real));
    float3 v = sqrt(0.5 * (r - z.real));
    
    // Adjust the sign of v based on z.imag (component-wise)
    v.x = (z.imag.x < 0.0) ? -v.x : v.x;
    v.y = (z.imag.y < 0.0) ? -v.y : v.y;
    v.z = (z.imag.z < 0.0) ? -v.z : v.z;
    
    C3 result;
    result.real = u;
    result.imag = v;
    
    return result;
}


inline C3 ComplexConjugate(C3 c)
{
    return CV(c.real, -c.imag);
}


inline C3 ComplexMul(C3 a, C3 b)
{
    C3 r;
    r.real = a.real * b.real - a.imag * b.imag;
    r.imag = a.real * b.imag + a.imag * b.real;
    return r;
}

inline float3 CMagnitude3f(C3 wavelength)
{
    C3 conj = ComplexConjugate(wavelength);
    C3 product = CMul(wavelength, conj);
    // The real part now contains the squared magnitude (per channel).
    return sqrt(product.real);
}
inline float3 CMagnitudeSquared(C3 wavelength)
{
    C3 conj = ComplexConjugate(wavelength);
    C3 product = CMul(wavelength, conj);
    // The real part now contains the squared magnitude (per channel).
    return sqrt(product.real);
}


inline C3 ComplexMagnitude(C3 a)
{
    return CV0(sqrt((a.real * a.real)+(a.imag * a.imag)));
}


// Assuming you have a CDiv function defined as below:
inline C3 ComplexDiv(C3 a, C3 b)
{
    a.real = (0 + a.real);
    a.imag = (0 + a.imag);
    b.real = (0 + b.real);
    b.imag = (0 + b.imag);
    float3 denom = max(EPSILON3, b.real * b.real) + max(EPSILON3, b.imag * b.imag);
    denom = max(denom, EPSILON3); // Avoid division by zero
    float3 invDenom = 1.0 / denom;
    C3 r;
    r.real = (a.real * b.real + a.imag * b.imag) * invDenom;
    r.imag = (a.imag * b.real - a.real * b.imag) * invDenom;
    return r;
}


C3 ComplexSin(C3 c)
{
    return CV(sin(c.real) * cosh(c.imag), cos(c.real) * sinh(c.imag));
}

C3 ComplexSinh(C3 c)
{
    return CV(sinh(c.real) * cos(c.imag), cosh(c.real) * sin(c.imag));
}

C3 ComplexCosh(C3 c)
{
    return CV(cosh(c.real) * cos(c.imag), sinh(c.real) * sin(c.imag));
}

C3 ComplexCos(C3 c)
{
    return CV(cos(c.real) * cosh(c.imag), -sin(c.real) * sinh(c.imag));
}

// Computes the tangent of a complex number: tan(c) = sin(c) / cos(c)
inline C3 ComplexTangent(C3 c)
{
    return CDiv(CSin(c), ComplexCos(c));
}

inline float3 safeNormalizef(float3 x)
{
    return normalize(x + EPSILON3);
}

inline float2 safeNormalizef(float2 x)
{
    return normalize(x + EPSILON2);
}
inline float4 safeNormalizef4(float4 x)
{
    return normalize(x + EPSILON4);
}


float3 ComplexToFloat3(C3 a)
{
    float3 magSq = ComplexMagnitudeSquared(a).real;
    magSq = sqrt(magSq);
    return magSq;
}

float ComplexToFloat(C3 a)
{
    return length(ComplexToFloat3(a));
}

inline C3 safeNormalize(C3 x)
{
    return CV(normalize(x.real+EPSILON3), normalize(x.imag+EPSILON3));
}

C3 ComplexLog(C3 z)
{
    C3 mag = ComplexMagnitude(z);
    float3 angle = atan2(z.imag, z.real);
    return CV(log(mag.real), angle);
}
// Complex Arcsine: arcsin(z) = -i * log( i*z + sqrt(1 - z^2) )
C3 Complex3Asin(C3 z)
{
    C3 i_z = CMul(CV(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0)), z);
    C3 one = CV(float3(1.0, 1.0, 1.0), float3(0.0, 0.0, 0.0));
    C3 sqrtTerm = ComplexSqrt(ComplexSub(one, CMul(z, z)));
    C3 logArg = CAdd(i_z, sqrtTerm);
    C3 logVal = ComplexLog(logArg);
    // Multiply by -i: -i * logVal = Complex3Mul(Complex3Create(0,-1), logVal)
    return CMul(CV(float3(0.0, 0.0, 0.0), float3(-1.0, -1.0, -1.0)), logVal);
}

// Complex Arccosine: arccos(z) = -i * log( z + i*sqrt(1 - z^2) )
C3 Complex3Acos(C3 z)
{
    C3 one = C10;
    C3 sqrtTerm = ComplexSqrt(ComplexSub(one, CMul(z, z)));
    C3 i_sqrt = CMul(CV(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0)), sqrtTerm);
    C3 logVal = ComplexLog(CAdd(z, i_sqrt));
    return CMul(CV(float3(0.0, 0.0, 0.0), float3(-1.0, -1.0, -1.0)), logVal);
}



// Convert wavelength from nanometers (nm) to meters (m)
//inline float nmToM(float nm)
//{
//    return nm * 1e-9;
//}

//inline float2 nmToM(float2 nm)
//{
//    return nm * 1e-9;
//}

//inline float3 nmToM(float3 nm)
//{
//    return nm * 1e-9;
//}

// Convert wavelength from meters (m) to nanometers (nm)
inline float mToNmf(float m)
{
    return m * 1e9;
}

inline float2 mToNmf(float2 m)
{
    return m * 1e9;
}
inline float3 mToNmf(float3 m)
{
    return m * 1e9;
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
#define RED_WAVELENGTH (RED_MIN_WAVELENGTH+(RED_MAX_WAVELENGTH-RED_MIN_WAVELENGTH)*.5)
#define GREEN_MIN_WAVELENGTH 495.0
#define GREEN_MAX_WAVELENGTH 570.0
#define GREEN_WAVELENGTH (GREEN_MIN_WAVELENGTH+(GREEN_MAX_WAVELENGTH-GREEN_MIN_WAVELENGTH)*.5)
#define BLUE_MIN_WAVELENGTH 450.0
#define BLUE_MAX_WAVELENGTH 495.0
#define BLUE_WAVELENGTH (BLUE_MIN_WAVELENGTH+(BLUE_MAX_WAVELENGTH-BLUE_MIN_WAVELENGTH)*.5)
#define FLT_MAX 1e+16
#define FLT_MIN 1e-16

#define MIN_WAVELENGTHS float3(RED_MIN_WAVELENGTH, GREEN_MIN_WAVELENGTH, BLUE_MIN_WAVELENGTH)
#define MAX_WAVELENGTHS float3(RED_MAX_WAVELENGTH, GREEN_MAX_WAVELENGTH, BLUE_MAX_WAVELENGTH)
#define RGB_WAVELENGTHS_NM float3(RED_WAVELENGTH, GREEN_WAVELENGTH, BLUE_WAVELENGTH)
#define RGB_WAVELENGTHS_M nmToM(CV0(RGB_WAVELENGTHS_NM))
#define RGB_WAVELENGTHS_UM nmToUm(RGB_WAVELENGTHS_NM)
#define MAX_WAVELENGTH 780.0
#define MIN_WAVELENGTH 380.0
// Number of wavelength samples
#define NUM_SAMPLES 471
#define SPECTRAL_LOCUS_COUNT 471

#define WAVELENGTH_RANGES (MAX_WAVELENGTHS-MIN_WAVELENGTHS)
#define WAVELENGTH_RANGE (MAX_WAVELENGTH-MIN_WAVELENGTH)
#define WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE (CHROMATICITY_RANGE/WAVELENGTH_RANGES)



// Enumerations for Film Types

#define FILM_TYPE_THICK_GLASS 0
#define FILM_TYPE_OILY_GLASS 1
#define FILM_TYPE_THICK_OIL 2
#define FILM_TYPE_HOLOGRAPHIC 3
#define TOTAL_FILM_TYPES 4


// --- Constants for Sheen Calculation (configurable) ---
#define SHEEN_ROUGHNESS_MULTIPLIER HeightParamB  
#define SHEEN_ALBEDO_TINT float3(0.3, 0.5, 0.7) 
#define ADVANCED_SHEEN_ANISOTROPY 0.6
#define ADVANCED_SHEEN_POWER f5

// --- Constants for Clear Coat (configurable) ---
 // Affects the strength of the clear coat effect
#define CLEAR_COAT_THICKNESS 40
// IOR of the clear coat layer (typical value for polymers)
#define CLEAR_COAT_IOR 1.5
#define CLEAR_COAT_ROUGHNESS_MULTIPLIER 0.02

// --- Iridescence Parameters ---
 //300.0 // Thickness of the iridescent layer in nanometers
#define IRIDESCENCE_THICKNESS f9
//300
         // IOR of the iridescent layer
#define IRIDESCENCE_IOR f10
//1.7

#define LP_CASE(n, prop) case n: {output.rt1.xyz = lighting.##prop;}break;
#define LP_CASE2(n, prop) case n: output.rt1.xyz = lighting.##prop;break;
#define LP_CASE_MAG(n, prop) case n: {output.rt1.xyz = lighting.##prop##.real;}break;

#define ToFloat3(v) float3(v,v,v)
#define ToFloat3Bool(v) lerp(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),v)


#define CELL_W 64
#define CELL_H 56

// Macro for determining the grid index dynamically
#define MAP_TO_GRID_INDEX(uv, gridWidth, gridHeight) (int((uv.y * gridHeight)) * int(gridWidth) + int((uv.x * gridWidth)))

// Macro to check if the UV is within the current cell
#define IS_IN_GRID_CELL(uv, cellX, cellY, gridWidth, gridHeight) ((uv.x >= cellX / gridWidth) && (uv.x < (cellX + 1) / gridWidth) && (uv.y >= cellY / gridHeight) && (uv.y < (cellY + 1) / gridHeight))



#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)


#define CONVERTUV(UVa,UVb,texA,texB) float2 convert##UVa##To##UVb(Texture2D<texA> sourceMap, float2 mapUV, Texture2D<texB> targetMap) { return mapUV * GetSz(sourceMap) / GetSz(targetMap); }

inline float2 GetSz(Texture2D<float4> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}


inline float2 GetOosz(Texture2D<float4> tex)
{
    float2 sz = GetSz(tex);
    return ONE2 / sz;
}

inline float2 GetSz(Texture2D<float3> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}


inline float2 GetOosz(Texture2D<float3> tex)
{
    float2 sz = GetSz(tex);
    return ONE2 / sz;
}

inline float2 GetSz(Texture2D<float2> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}


inline float2 GetOosz(Texture2D<float2> tex)
{
    float2 sz = GetSz(tex);
    return ONE2 / sz;
}

inline float2 GetSz(Texture2D<float> tex)
{
    uint2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return float2(float(sz.x), float(sz.y));
}


inline float2 GetOosz(Texture2D<float> tex)
{
    float2 sz = GetSz(tex);
    return ONE2 / sz;
}

CONVERTUV(UV4, UV4, float4, float4);
CONVERTUV(UV4, UV3, float4, float3);
CONVERTUV(UV4, UV2, float4, float2);
CONVERTUV(UV4, UV1, float4, float);

CONVERTUV(UV3, UV4, float3, float4);
CONVERTUV(UV3, UV3, float3, float3);
CONVERTUV(UV3, UV2, float3, float2);
CONVERTUV(UV3, UV1, float3, float);

CONVERTUV(UV2, UV4, float2, float4);
CONVERTUV(UV2, UV3, float2, float3);
CONVERTUV(UV2, UV2, float2, float2);
CONVERTUV(UV2, UV1, float2, float);

CONVERTUV(UV1, UV4, float, float4);
CONVERTUV(UV1, UV3, float, float3);
CONVERTUV(UV1, UV2, float, float2);
CONVERTUV(UV1, UV1, float, float);

#define noise11(uv) noise2D(noiseMap1,uv)
#define noise01(uv) (noise2D(noiseMap1,uv)*.5+.5)

#define NUM_SCATTER_PHASES 4

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

inline float3 RGBToWavelengthsNMf(float3 srgb)
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


SellmeierCoefficientsBC CreateSellmeierCoefficientsBC(
    float3 B,
    float3 C)
{
    SellmeierCoefficientsBC ret = (SellmeierCoefficientsBC) 0;
    ret.B = B;
    ret.C = C;
    return ret;
}

SellmeierCoefficientsOE CreateSellmeierCoefficientsOE(
    SellmeierCoefficientsBC O,
     SellmeierCoefficientsBC E)
{
    SellmeierCoefficientsOE ret = (SellmeierCoefficientsOE) 0;
    ret.O = O;
    ret.E = E;
    return ret;
}

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


MaterialSellmeier CreateMaterialSellmeier(
    SellmeierCoefficients coeff,
    float3 absorptionCoefficient,
    float3 scatteringCoefficient,
    float roughness, float metallic,
    float3 metallicReflectance,
    float3 albedo,
    C3 thicknessM,
    float3 etaR, float3 etaI,
	float3 dispersionCoefficientsD0,
    float3 dispersionCoefficientsD1,
    float3 dispersionCoefficientsD2,
	float3 etaO,
	float3 etaE,
	C3 opticalAxis,
	float nSurrounding,
    float polarizationAngle,
    C3 coherenceLengthM,
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
    float vDepthScale;

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
    return ONE3 * dt;
}

inline C3 dot3(C3 a)
{
    return CV(dot3(a.real, a.real), dot3(a.imag, a.imag));
}
// HLSL SM 5.0


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
    return saturate((x - edge0) / max(EPSILON, abs(edge1 - edge0)));
}
inline float2 safeNormalizeRange(float2 edge0, float2 edge1, float2 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / max(EPSILON2, abs(edge1 - edge0)));
}
inline float3 safeNormalizeRange(float3 edge0, float3 edge1, float3 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / max(EPSILON3, abs(edge1 - edge0)));
}
inline float4 safeNormalizeRange(float4 edge0, float4 edge1, float4 x)
{
	// Scale, bias, and saturate x to 0..1 range
    return saturate((x - edge0) / max(EPSILON4, abs(edge1 - edge0)));
}
// Smootherstep function
inline float smootherstep(float edge0, float edge1, float x, float steepness = 1.0)
{
	// Scale, bias, and saturate x to 0..1 range
    x = saturate((x - edge0) / max(EPSILON, abs(edge1 - edge0)));
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

//---------------------------------------------------------------------------
// 1. Exponential and Logarithm Functions
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// 1. Exponential, Logarithm, and Power Functions
//---------------------------------------------------------------------------

// Computes: exp(realExp) * exp(i * c.imag)
// This uses an externally provided exponent (realExp) instead of c.real.
inline C3 ComplexExpReal(C3 c, float3 realExp)
{
    // Compute exp(realExp) once.
    float3 eX = exp(realExp);
    // Multiply by the oscillatory part exp(i*c.imag).
    return CV(eX * cos(c.imag), eX * sin(c.imag));
}


// Computes the complex exponential:
// exp(c) = exp(c.real) * (cos(c.imag) + i*sin(c.imag))
inline C3 ComplexExp(C3 c)
{
    // Compute the exponential of the real part.
    float3 expReal = exp(c.real);
    // Multiply exp(c.real) by cos(c.imag) and sin(c.imag) respectively.
    return CV(expReal * cos(c.imag), expReal * sin(c.imag));
}

// Computes a^f where f is purely real (i.e. f + i*0) using: a^f = exp(f * ln(a))
C3 ComplexPowCf(C3 a, float3 f)
{
    C3 lnA = ComplexLog(a);
    // Create a complex number b = f + i*0.
    C3 b;
    b.real = f;
    b.imag = 0; // The imaginary part is zero.
    // Multiply b and lnA, then take the exponential.
    C3 mul = CMul(b, lnA);
    return CExp(mul);
}

// Computes a^b for a complex exponent b using: a^b = exp(b * ln(a))
C3 ComplexPow(C3 a, C3 b)
{
    C3 lnA = ComplexLog(a);
    C3 mul = CMul(b, lnA);
    return CExp(mul);
}

// Linearly blend two C3 values using a scalar weight.
C3 ComplexBlend(C3 a, C3 b, float weight)
{
    return CV(lerp(a.real, b.real, weight),
                         lerp(a.imag, b.imag, weight));
}

// Create a complex wave packet from an amplitude and phase.
// This returns: amplitude * exp(i*phase)
C3 ComplexWavePacket(float amplitude, float phase)
{
    float r = amplitude * cos(phase);
    float i = amplitude * sin(phase);
    // Multiply by ONE3 (assumed to be a float3 of ones) to broadcast the scalar.
    return CV(r * ONE3, i * ONE3);
}

//---------------------------------------------------------------------------
// 2. "Cf" Versions: Apply a float3 (purely real) to Both Components
//---------------------------------------------------------------------------

// Add a purely real float3 value to both the real and imaginary parts.
C3 ComplexAddCf(C3 c, float3 f)
{
    c.real = c.real + f;
    c.imag = c.imag + f;
    return c;
}

// Subtract a purely real float3 value from both the real and imaginary parts.
C3 ComplexSubCf(C3 c, float3 f)
{
    C3 r;
    r.real = c.real - f;
    r.imag = c.imag - f;
    return r;
}

// Multiply both the real and imaginary parts by a float3 value.
C3 ComplexMulCf(C3 c, float3 f)
{
    c.real = c.real * f;
    c.imag = c.imag * f;
    return c;
}

// Divide both the real and imaginary parts by a float3 value.
C3 ComplexDivCf(C3 c, float3 f)
{
    c.real = c.real / f;
    c.imag = c.imag / f;
    return c;
}

// Compute a dot product between a C3 and a float3 by summing the dot products 
// of the real and imaginary components.
float ComplexDotCf(C3 c, float3 f)
{
    return dot(c.real, f) + dot(c.imag, f);
}

//---------------------------------------------------------------------------
// 4. Inverse, Normalize, and Scalar Multiplication
//---------------------------------------------------------------------------

inline C3 ComplexInverse(C3 c)
{
    float3 denom = c.real * c.real + c.imag * c.imag;
    // Clamp to avoid division by zero.
    denom = max(denom, EPSILON3);
    float3 invDenom = 1.0 / denom;
    return CV(c.real * invDenom, -c.imag * invDenom);
}

inline C3 ComplexNormalize(C3 c)
{
    float3 mag = sqrt(c.real * c.real + c.imag * c.imag);
    mag = max(mag, EPSILON3);
    float3 invMag = 1.0 / mag;
    return CV(c.real * invMag, c.imag * invMag);
}

inline C3 ComplexMulScalar(C3 c, float s)
{
    C3 r;
    r.real = c.real * s;
    r.imag = c.imag * s;
    return r;
}

inline C3 ComplexMulScalar(C3 c, float3 s)
{
    C3 r;
    r.real = c.real * s;
    r.imag = c.imag * s;
    return r;
}

//---------------------------------------------------------------------------
// 5. Interpolation, Clamping, and Saturation Functions
//---------------------------------------------------------------------------

inline C3 ComplexLerpf(C3 a, C3 b, float3 n)
{
    return CV(lerp(a.real, b.real, n), lerp(a.imag, b.imag, n));
}

inline C3 ComplexSmoothstep(C3 a, C3 b, C3 n)
{
    return CV(smootherstep(a.real, b.real, n.real),
                           smootherstep(a.imag, b.imag, n.imag));
}

inline C3 ComplexClamp(C3 a, float3 minVal, float3 maxVal)
{
    return CV(clamp(a.real, minVal, maxVal), clamp(a.imag, minVal, maxVal));
}

inline C3 ComplexSaturate(C3 c)
{
    C3 result;
    result.real = saturate(c.real);
    result.imag = saturate(c.imag);
    return result;
}

inline C3 ComplexDistance(C3 a, C3 b)
{
    C3 result;
    result.real = ONE3 * distance(a.real, b.real);
    result.imag = ONE3 * distance(a.imag, b.imag);
    return result;
}

inline float3 ComplexDistancef(C3 a, C3 b)
{
    float3 diffReal = a.real - b.real;
    float3 diffImag = a.imag - b.imag;
    return sqrt(diffReal * diffReal + diffImag * diffImag);
}

//---------------------------------------------------------------------------
// 6. Phase, Projection, and Conjugate Filtering
//---------------------------------------------------------------------------

// Computes the angle (in radians) of each component of a C3.
inline float3 ComplexPhase(C3 c)
{
    return atan2(c.imag, c.real);
}

inline C3 ComplexProjectReal(C3 c)
{
    return CV0(c.real);
}

inline C3 ComplexProjectImag(C3 c)
{
    return CV0(c.imag);
}

inline C3 ApplyConjugateFilter(C3 signal, C3 filterCoefficient)
{
    return CMul(signal, ComplexConjugate(filterCoefficient));
}

// Computes the phase difference between two complex signals.
inline float3 ComputePhaseDifference(C3 a, C3 b)
{
    C3 product = CMul(a, ComplexConjugate(b));
    return ComplexPhase(product);
}

//---------------------------------------------------------------------------
// 7. Unit Conversions for Wavelengths
//---------------------------------------------------------------------------

inline C3 nmToM(C3 nm)
{
    return CMul(nm, CVV(1e-9));
}

inline float3 nmToMf(float3 nm)
{
    return nm * 1e-9;
}
//---------------------------------------------------------------------------
// 7. Unit Conversions for Wavelengths
//---------------------------------------------------------------------------

// Convert wavelength from nanometers (nm) to micrometers (µm)
// This function multiplies each component of the C3 by 1e-3.
inline C3 nmToUm(C3 nm)
{
    return CMul(nm, CV0(1e-3));
}

//---------------------------------------------------------------------------
// 8. Magnitude and Dot Functions
//---------------------------------------------------------------------------



inline C3 ComplexAbs(C3 a)
{
    return CV(abs(a.real), abs(a.imag));
}

// Computes the difference in magnitude between two C3 values on a 
// per-channel basis. It returns a float3 computed as:
// sqrt( (abs(a.real - b.real))^2 + (abs(a.imag - b.imag))^2 ).
float3 ComplexAbsDifference(C3 a, C3 b)
{
    float3 diffReal = abs(a.real - b.real);
    float3 diffImag = abs(a.imag - b.imag);
    return sqrt(diffReal * diffReal + diffImag * diffImag);
}

// Computes a scalar dot product between two C3 values.
// It is defined as the sum of the dot product of the real parts plus the dot of the imag parts
C3 ComplexDot(C3 a, C3 b)
{
    return CAdd(CV0(dot(a.real, b.real)), CV0(dot(a.imag, b.imag)));
}



//---------------------------------------------------------------------------
// 9. RGB to Wavelength Conversion
//---------------------------------------------------------------------------

inline C3 RGBToWavelengthsNM(C3 srgb)
{
    // Clamp sRGB to [0,1]
    C3 linearRGB = CV0Sat(srgb);
    
    // Map the clamped value into the wavelength range:
    // wavelength = MIN_WAVELENGTHS + linearRGB * WAVELENGTH_RANGES
    return CAdd(CMul(linearRGB, CV0(WAVELENGTH_RANGES)), CV0(MIN_WAVELENGTHS));
}
//---------------------------------------------------------------------------
// 4. Other complex functions
//---------------------------------------------------------------------------


C3 ComplexScale(C3 c, float3 scale)
{
    return CV(c.real * scale, c.imag * scale);
}

Polar3 ComplexToPolar(C3 c)
{
    float3 mag = sqrt(c.real * c.real + c.imag * c.imag);
    float3 angle = atan2(c.imag, c.real);
    Polar3 ret;
    ret.magnitude = mag;
    ret.angle = angle;
    return ret;
}

C3 PolarToComplex(Polar3 p)
{
    float3 real = p.magnitude * cos(p.angle);
    float3 imag = p.magnitude * sin(p.angle);
    return CV(real, imag);
}


//---------------------------------------------------------------------------
// 5. Rotation and Phase Functions
//---------------------------------------------------------------------------

// Rotate a C3 value using component‐wise angles.
// Each channel in c is rotated by the corresponding angle in 'angle'.
C3 ComplexRotateVec(C3 c, float3 angle)
{
    float3 cosTheta = cos(angle);
    float3 sinTheta = sin(angle);
    // Apply rotation elementwise:
    // newReal = c.real * cosTheta - c.imag * sinTheta
    // newImag = c.real * sinTheta + c.imag * cosTheta
    return CV(c.real * cosTheta - c.imag * sinTheta,
                         c.real * sinTheta + c.imag * cosTheta);
}

// Rotate a C3 value uniformly by a scalar angle.
C3 ComplexRotate(C3 c, float angle)
{
    float cosAngle = cos(angle);
    float sinAngle = sin(angle);
    // Uniform rotation on all components.
    C3 rotated;
    rotated.real = c.real * cosAngle - c.imag * sinAngle;
    rotated.imag = c.real * sinAngle + c.imag * cosAngle;
    return rotated;
}

// Alias for polarization rotation (identical to scalar rotation).
C3 ComplexPolarizationRotate(C3 c, float angle)
{
    return ComplexRotate(c, angle);
}

// Modulate the phase of a C3 value by adding a phase shift.
// Note: This is mathematically equivalent to a rotation.
C3 ComplexPhaseModulation(C3 c, float phase)
{
    // Rotate by the given phase.
    return ComplexRotate(c, phase);
}



C3 PhaseDifference(C3 wavelengthM, C3 thicknessM, float3 eta, float3 cosTheta)
{
    return CDiv(CMul(CMul(CV0(TWO3 * PI3), thicknessM), CV0(eta * cosTheta)), wavelengthM);
}


inline C3 ClampRefractiveIndex(C3 ri)
{
    return ComplexClamp(ri, ONE3, ONE3 * 5.0);
}

inline C3 AdjustGamma(C3 color, float gammaValue = GAMMA_VALUE)
{
    return CV(CPow(CMax(CEPSILON3, color), CDiv(C11, CMax(CEPSILON3,CVV(gammaValue)))).real, color.imag);
    //return ComplexPow(CMax(ComplexEPSILON3VV, color.real), CDiv(Complex11, CMax(ComplexEPSILON3VV, ComplexVV(gammaValue))));
}
inline float3 AdjustGammaf(float3 color, float gammaValue = GAMMA_VALUE)
{
    return AdjustGamma(CVV(pow(max(EPSILON3, color), ONE3/max(EPSILON3, gammaValue)))).real;

}

// Applies a phase shift to a complex wavelength signal based on propagation depth.
inline C3 ApplyDepthPhaseShift(C3 wavelength, float depth, float refractiveIndex)
{
    // Obtain an effective wavelength (assumed to be stored or computed from the C3 signal)
    float3 lambda = ComplexToFloat3(wavelength); // For example, using the magnitude or a designated channel.
    // Compute wave number: k = 2π/λ
    float3 k = (2.0 * PI3) / lambda;
    // Create phase shift: phase = -k * refractiveIndex * depth
    C3 phaseFactor = CExp(CV(float3(0, 0, 0), -k * refractiveIndex * depth));
    // Propagate the wavelength by applying the phase factor.
    return CMul(wavelength, phaseFactor);
}

C3 AdvancedModulationWithConjugatePhaseCorrection(C3 signal, C3 modulationSignal)
{
    // Obtain the conjugate of the modulation signal.
    C3 modConj = ComplexConjugate(modulationSignal);
    // Extract phase correction from the conjugated modulation signal.
    float3 phaseCorrection = ComplexPhase(modConj);
    // Construct a correction factor: exp(-i * phaseCorrection)
    // Here, CV(0, -phaseCorrection) represents a purely imaginary number.
    C3 correctionFactor = CExp(CV(float3(0, 0, 0), -phaseCorrection));
    // Apply the correction factor to the original signal.
    return CMul(signal, correctionFactor);
}

inline C3 AttenuateWavelengthByDepth(C3 wavelength, float depth, float attenuationCoefficient)
{
    // Compute attenuation factor: exp(-attenuationCoefficient * depth)
    // Extend scalar to float3 if needed.
    float3 attenuationFactor = exp(-attenuationCoefficient * depth);
    // Multiply the complex wavelength by the attenuation factor.
    return ComplexMulScalar(wavelength, attenuationFactor);
}


inline float3 InterferencePatternAtDepth(
    C3 wavelength1, float depth1,
    C3 wavelength2, float depth2,
    float refractiveIndex, float attenuationCoefficient)
{
    // Propagate each wavelength to its depth.
    C3 propagated1 = AttenuateWavelengthByDepth(ApplyDepthPhaseShift(wavelength1, depth1, refractiveIndex), depth1, attenuationCoefficient);
    C3 propagated2 = AttenuateWavelengthByDepth(ApplyDepthPhaseShift(wavelength2, depth2, refractiveIndex), depth2, attenuationCoefficient);
    
    // Combine the two waves.
    C3 combined = CAdd(propagated1, propagated2);
    // Interference intensity is given by the magnitude squared of the combined wave.
    return ComplexMagnitudeSquared(combined).real;
}

inline C3 DepthBasedFocus(C3 wavelength, float localDepth, float desiredFocusDepth, float refractiveIndex)
{
    // Calculate the depth difference.
    float depthDifference = localDepth - desiredFocusDepth;
    // Apply a phase shift corresponding to the depth difference.
    return ApplyDepthPhaseShift(wavelength, depthDifference, refractiveIndex);
}

// Modulates a complex wavelength signal by incorporating both linear depth propagation
// and a quadratic phase term representing curvature effects.
inline C3 WavelengthDepthModulation(C3 wavelength, float depth, float refractiveIndex, float curvature)
{
    // Derive effective wavelength and compute wave number.
    float3 lambda = ComplexToFloat3(wavelength);
    float3 k = (2.0 * PI3) / lambda;
    // Total phase shift: linear term due to propagation and quadratic term for curvature.
    float3 totalPhase = k * refractiveIndex * depth + curvature * depth * depth;
    // Construct the phase factor (note the negative sign to represent phase delay).
    C3 phaseFactor = CExp(CV(float3(0, 0, 0), -totalPhase));
    // Return the modulated signal.
    return CMul(wavelength, phaseFactor);
}



inline C3 mToNm(C3 m)
{
    return CMul(m, CVV(1e9));
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

inline float3 RefractiveIndexFromCoefficients(C3 wavelengthsNM, SellmeierCoefficientsBC coeffs)
{
    // Convert wavelength from nanometers to micrometers
    C3 wavelengthsUM = nmToUm(wavelengthsNM); // 1 nm = 1e-3 µm

    // Compute wavelength squared
    C3 lambdaSq = CMul(wavelengthsUM, wavelengthsUM);

    // Apply Sellmeier Equation
    float3 nSq = 1.0f +
                 (coeffs.B.x * lambdaSq.real.x) / (lambdaSq.real.x - coeffs.C.x) +
                 (coeffs.B.y * lambdaSq.real.y) / (lambdaSq.real.y - coeffs.C.y) +
                 (coeffs.B.z * lambdaSq.real.z) / (lambdaSq.real.z - coeffs.C.z);

    // Ensure no negative values under square root
    float3 n = sqrt(max(nSq, EPSILON3));

    return n;
}


AnisotropicRoughness CreateAnisotropicRoughness(float alphaX, float alphaY)
{
    AnisotropicRoughness ret = (AnisotropicRoughness) 0;
    ret.alphaX = alphaX;
    ret.alphaY = alphaY;
    return ret;
}

ThinFilmProperties CreateThinFilmProperties(C3 filmThicknessM, SellmeierCoefficients filmEta_coeffs)
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
    float3 H_proj = safeNormalizef(float3(H.x, H.y, 0.0f));
    float3 N_proj = safeNormalizef(float3(N.x, N.y, 0.0f));

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
    return safeNormalizef(lightDir * etaR);
}

half3 FresnelReflectanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out half3 cosThetaT)
{
    //--------------------------------------------------------------------------
    // 1. Wrap and Clamp the Incident Angle
    //--------------------------------------------------------------------------

    // Clamp the input cosine to [-1, 1] and wrap as a C3.
    half3 cI_real = clamp(cosThetaI, -ONE3h, ONE3h);
    C3 cI = CVV(cI_real);

    //--------------------------------------------------------------------------
    // 2. Wrap the Refractive Indices
    //--------------------------------------------------------------------------

    // Ensure the refractive indices are non-negative.
    C3 Cn1 = CVV(max(n1, ZERO3h));
    C3 Cn2 = CVV(max(n2, ZERO3h));

    //--------------------------------------------------------------------------
    // 3. Compute the Sine of the Incident Angle Using Complex Math
    //--------------------------------------------------------------------------

    // sin(theta_i) = sqrt( max(1 - cosThetaI^2, 0) )
    C3 oneC = CVV(ONE3h);
    C3 cI2 = CMul(cI, cI);
    C3 diff = ComplexSub(oneC, cI2);
    C3 sI = ComplexSqrt(diff);

    //--------------------------------------------------------------------------
    // 4. Compute the Sine of the Transmitted Angle
    //--------------------------------------------------------------------------

    // ratio = n1 / n2; then sT = ratio * sI
    C3 ratio = CDiv(Cn1, Cn2);
    C3 sT = CMul(ratio, sI);

    // For transmitted cosine, we need to clamp the sine value to [0, 1] and then compute:
    // cosThetaT = sqrt( max(1 - min(sT, 1)^2, 0) )
    half3 sT_clamped = min(sT.real, ONE3h);
    cosThetaT = sqrt(max(ONE3h - sT_clamped * sT_clamped, ZERO3h));
    C3 cCosThetaT = CVV(cosThetaT);

    //--------------------------------------------------------------------------
    // 5. Compute the Reflection Coefficients for s- and p-Polarizations
    //--------------------------------------------------------------------------

    // Denominators for s- and p-polarized components (computed in the real domain).
    half3 denomS_real = max(n1 * cI_real + n2 * cosThetaT, EPSILON3h);
    half3 denomP_real = max(n1 * cosThetaT + n2 * cI_real, EPSILON3h);
    C3 denomS = CVV(denomS_real);
    C3 denomP = CVV(denomP_real);

    // Numerators for s- and p-polarizations.
    half3 numS_real = n1 * cI_real - n2 * cosThetaT;
    half3 numP_real = n1 * cosThetaT - n2 * cI_real;
    C3 numS = CVV(numS_real);
    C3 numP = CVV(numP_real);

    // Compute the reflection coefficients (Rs and Rp).
    C3 Rs = CDiv(numS, denomS);
    C3 Rp = CDiv(numP, denomP);

    
    //--------------------------------------------------------------------------
    // 6. Average the s- and p-Polarized Reflectances and Apply TIR
    //--------------------------------------------------------------------------

    // Average reflectance: R = 0.5*(Rs^2 + Rp^2)
    C3 R_complex = CMul(CAdd(CVV(pow(Rs.real,2)), CVV(pow(Rp.real,2))), CVV(0.5));

    // Total Internal Reflection (TIR): if sT > 1, then use full reflectance (1).
    half3 tir = step(ONE3h, sT.real); // yields 1 where sT >= 1, else 0.
    half3 R_real = lerp(R_complex.real, ONE3h, tir);

    // Clamp the final reflectance.
    R_real = clamp(R_real, ZERO3h, ONE3h);
    return R_real;
}

C3 FresnelReflectanceFromFilmC2(half3 n1, C3 n2, half3 cosThetaI, out C3 cosThetaT)
{
    half3 cI = clamp(cosThetaI, -ONE3h, ONE3h);
    
    // Convert real indices to complex numbers.
    C3 Cn1 = CV(n1, ZERO3h);
    C3 Cn2 = n2;
    
    // Calculate sine of incident angle per channel.
    half3 sI = sqrt(max(ONE3h - cI * cI, ZERO3h));
    
    // Compute ratio as complex division.
    C3 ratio = CDiv(Cn1, Cn2);
    
    // Multiply ratio by sI per channel.
    C3 sT = ComplexMulScalar(ratio, sI); // Note: overload for half3 is defined.
    
    // Create a TIR mask: if |sT| >= 1, use full reflection.
    C3 sTmag = ComplexMagnitude(sT);
    half3 tirMask = step(ONE3h, half3(sTmag.real));
    
    // Clamp sT's magnitude to avoid NaN.
    // (You might consider using a lerp or blend function here.)
    sT = ComplexLerp(sT, CV(ONE3h, ZERO3h), CV0(float3(tirMask)));
    
    // Compute transmitted cosine via complex square root.
    cosThetaT = ComplexSqrt(ComplexSub(C10, CMul(sT, sT)));
    
    // Denominators for s- and p-polarized light.
    C3 denomS = CAdd(CMul(Cn1, CV(cI, ZERO3h)),
                                  CMul(Cn2, cosThetaT));
    C3 denomP = CAdd(CMul(Cn1, cosThetaT),
                                  CMul(Cn2, CV(cI, ZERO3h)));
    
    // Reflection coefficients for s and p.
    C3 rs = CDiv(ComplexSub(CMul(Cn1, CV(cI, ZERO3h)), cosThetaT), denomS);
    C3 rp = CDiv(ComplexSub(CV(cI, ZERO3h), cosThetaT), denomP);
    
    // Average the squared magnitudes.
    float3 Rs = CAbs(rs).real * CAbs(rs).real;
    float3 Rp = CAbs(rp).real * CAbs(rp).real;
    float3 R = 0.5 * (Rs + Rp);
    
    // Apply TIR: if TIR occurs, return full reflection (1).
    R = lerp(R, ONE3h, tirMask);
    
    return CV(clamp(R, ZERO3h, ONE3h), ZERO3);
}

C3 ComplexCreateCf(C3 real, float3 imag)
{
    C3 c;
    c.real = real.real;
    c.imag = imag;
    return c;
}

half3 FresnelTransmittanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out half3 cosThetaT)
{
    return 1.0h - FresnelReflectanceFromFilm2(n1, n2, cosThetaI, cosThetaT);
}




// Compute Fresnel Reflectance for Each Color Channel
//cosThetaI: Cosine of the angle between the normal and the view direction for each RGB channel.
//etaR : Real part of the refractive index for each RGB channel.
//etaI : Imaginary part of the refractive index for each RGB channel(ignored in this reflectance calculation but can be used for absorption).
C3 FresnelReflectanceFromComplex(C3 cosThetaI, C3 eta)
{
	// Compute sinThetaT using Snell's Law
    C3 sinThetaI = CSqrt(CMax(C00, CSub(C11, CMul(cosThetaI, cosThetaI))));
    C3 sinThetaT = CDiv(CV(sinThetaI.real, cosThetaI.real), eta);

	// Compute cosThetaT
    C3 cosThetaT = ComplexSqrt(CSub(C10, CMul(sinThetaT, sinThetaT)));

	// Compute rs and rp
    C3 rs = CDiv(CSub(CMul(eta, CV(cosThetaI.real, sinThetaT.imag)), cosThetaT),
		CAdd(CMul(eta, CV(cosThetaI.real, sinThetaT.imag)), cosThetaT));
    C3 rp = CDiv(CSub(CMul(eta, cosThetaT), CV(cosThetaI.real, sinThetaT.imag)),
		CAdd(CMul(eta, cosThetaT), CV(cosThetaI.real, sinThetaT.imag)));

	// Compute reflectance for each channel
    C3 Rs = CSat(CMul(CAbs(rs), CAbs(rs)));
    C3 Rp = CSat(CMul(CAbs(rp), CAbs(rp)));

	// Blend reflectance based on polarization
    C3 R = CSat(ComplexLerp(Rs, Rp, cosThetaI));

    return CV(saturate(R.real), saturate(R.imag)); // Transmittance
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
                    0.5, // float roughness, 
                    0.8, //float metallic
                    float3(0.8, 0.6, 0.5), // metallic reflectance
                    float3(0.2, 0.4, 0.8), // float3 albedo
                    nmToM(CV0(float3(1200.0,1200.0,1200.0))), // float thicknessM
                    float3(1.768, 1.768, 1.768), // float3 etaR
                    float3(0.0, 0.0, 0.0), // float3 etaI
                    float3(0.15, 0.25, 0.30), // float3 dispersionCoefficientNm2
                    float3(0.25, 0.30, 0.35), // float3 dispersionCoefficientNm2
                    float3(0.40, 0.50, 0.55), // float3 dispersionCoefficientNm2
                    float3(1.768, 1.768, 1.768), // float3 etaO
                    float3(1.748, 1.748, 1.748), // float3 etaE
                    safeNormalize(CV0(float3(0.0, 1.0, 0.0))), // float3 opticalAxis
                    1.0, // float nSurrounding
                    1.0, // float polarizationAngle
                    CV0(ONE3*0.005), // float coherenceLengthM
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
                    nmToM(CV0(1250.0)), // float thicknessM
                    float3(2.417, 2.417, 2.417), // float3 etaR
                    float3(0.0, 0.0, 0.0), // float3 etaI
                    float3(0.1, 0.1, 0.1), // float3 dispersionCoefficientNm2
                    float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
                    float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
                    float3(2.417, 2.417, 2.417), // float3 etaO
                    float3(2.407, 2.407, 2.407), // float3 etaE
                    safeNormalize(CV0(float3(1.0, 0.0, 0.0))), // float3 opticalAxis
                    1.0, // float nSurrounding
                    0.0, // float polarizationAngle
                    CV0(0.001), // float coherenceLengthM
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
        nmToM(CV0(1100.0)), // float thicknessM
        float3(1.544, 1.544, 1.544), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
        float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
        float3(0.4, 0.4, 0.4), // float3 dispersionCoefficientNm2
        float3(1.544, 1.544, 1.544), // float3 etaO
        float3(1.534, 1.534, 1.534), // float3 etaE
        safeNormalize(CV0(float3(0.0, 1.0, 0.0))), // float3 opticalAxis
        1.0, // float nSurrounding
        1.0, // float polarizationAngle
       CV0(0.002), // float coherenceLengthM
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
        nmToM(CV0(3150.0)), // float thicknessM
        float3(1.576, 1.576, 1.576), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.576, 1.576, 1.576), // float3 etaO
        float3(1.566, 1.566, 1.566), // float3 etaE
        safeNormalize(CV0(float3(0.0, 1.0, 0.0))), // float3 opticalAxis
        1.2, // float nSurrounding
        0.8, // float polarizationAngle
        CV0(0.004), // float coherenceLengthM
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
        nmToM(CV0(ONE3*2200.0)), // float thicknessM
        float3(1.452, 1.452, 1.452), // float3 etaR
        float3(0.0, 0.0, 0.0), // float3 etaI
        float3(0.12, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.452, 1.452, 1.452), // float3 etaO
        float3(1.442, 1.442, 1.442), // float3 etaE
        safeNormalize(CV0(float3(1.0, 0.0, 0.0))), // float3 opticalAxis
        1.0, // float nSurrounding
        0.5, // float polarizationAngle
        CV0(0.006), // float coherenceLengthM
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
        nmToM(CV0(ONE3*3150.0)), // float thicknessM
        float3(1.540, 1.540, 1.540), // float3 etaR
        float3(1.1540, 1.1540, 1.1540), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.540, 1.540, 1.540), // float3 etaO
        float3(1.530, 1.530, 1.530), // float3 etaE
        safeNormalize(CV0(float3(0.0, 1.0, 0.0))), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        CV0(0.005), // float coherenceLengthM
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
                SellmeierCoefficients sc = CreateSellmeierCoefficients(
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
        );
            
                ret = CreateMaterialSellmeier(
        sc,
        float3(0.12, 0.05, 0.02), // float3 absorptionCoefficient
        float3(0.10, 0.08, 0.06), // float3 scatteringCoefficient
        0.3, 0.2, // float roughness, float metallic
        float3(0.3, 0.2, 0.1), // metallic reflectance
        float3(0.9, 0.8, 0.7), // float3 albedo
        nmToM(CV0(ONE3*6100.0)), // float thicknessM
        float3(1.658, 1.658, 1.658), // float3 etaR (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaI (extraordinary index)
        float3(0.1, 0.15, 0.2), // float3 dispersionCoefficientNm2
        float3(0.2, 0.25, 0.3), // float3 dispersionCoefficientNm2
        float3(0.3, 0.35, 0.4), // float3 dispersionCoefficientNm2
        float3(1.658, 1.658, 1.658), // float3 etaO (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaE (extraordinary index)
        safeNormalize(CV0(float3(0.0, 0.0, 1.0))), // float3 opticalAxis
        1.0, // float nSurrounding
        0.8, // float polarizationAngle
        CV0(ONE3*0.005), // float coherenceLengthM
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
        nmToM(CV0(ONE3*4100.0)), // float thicknessM
        float3(1.377, 1.377, 1.377), // float3 etaR
        float3(1.393, 1.393, 1.393), // float3 etaI
        float3(0.10, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.377, 1.377, 1.377), // float3 etaO
        float3(1.393, 1.393, 1.393), // float3 etaE
        safeNormalize(CV0(float3(0.0, 1.0, 0.0))), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        CV0(0.003), // float coherenceLengthM
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
                nmToM(CV0(1500.0)), // float thicknessM
                float3(1.53, 1.53, 1.53), // float3 etaR
                float3(1.53, 1.53, 1.53), // float3 etaI
               
                    float3(0.02, 0.03, 0.02), // float3 dispersionCoefficientNm2
                    float3(0.15, 0.26, 0.15), // float3 dispersionCoefficientNm2
                    float3(0.29, 0.29, 0.29), // float3 dispersionCoefficientNm2
                float3(1.53, 1.53, 1.53), // float3 etaO
                float3(1.53, 1.53, 1.53), // float3 etaE
                safeNormalize(CV0(float3(0.0, 0.0, -1.0))), // float3 opticalAxis
                1.0, // float nSurrounding
                0.0, // float polarizationAngle
                CV0(0.025), // float coherenceLengthM
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
    C3 wavelengthsNM,
    float3 incidentDir,
    float3 diffractionDir,
    float grooveDepthM,
    float3 refractiveIndex,
    float scalar)
{
    // Normalize input vectors
    gratingNormal = safeNormalizef(gratingNormal);
    incidentDir = safeNormalizef(incidentDir);
    diffractionDir = safeNormalizef(diffractionDir);

    // Calculate angles
    float3 cosThetaI = dot3(gratingNormal, incidentDir);
    float3 cosThetaD = dot3(gratingNormal, diffractionDir);

    // Calculate grating equation terms
    float3 deltaBeta = CAbs(CMul(CDiv(CV0(2.0 * PI), wavelengthsNM), CV0(cosThetaD - cosThetaI))).real;

    // Calculate efficiency using a simplified model (e.g., scalar diffraction theory)
    float3 efficiency = (sinc(deltaBeta * grooveDepthM * 0.5)) * (sinc(deltaBeta * grooveDepthM * 0.5));
    efficiency *= exp(-scalar * deltaBeta * deltaBeta); // Gaussian envelope

    // Ensure efficiency is non-negative and normalized
    efficiency = saturate(efficiency);

    return efficiency;
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
inline C3 nmToHz(C3 nm)
{
    return CDiv(CVV(2.99792458e8), CMax(nmToM(CAbs(nm)), CVVEPSILON3)); // speed of light in m/s divided by wavelength in m
}

// Convert wavelength from meters (m) to frequency (Hz)
inline C3 mToHz(C3 m)
{
    return CDiv(CVV(2.99792458e8), m); // speed of light in m/s divided by wavelength in m
}
inline float3 mToHz(float3 m)
{
    return 2.99792458e8 / m; // speed of light in m/s divided by wavelength in m
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
    return safeNormalizef4(quaternion);
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
    axis = safeNormalizef(axis);
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
    return safeNormalizef(mul(transpose(inverse((float3x3) m)), v));
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
    float3 zaxis = safeNormalizef(target - eye);
    float3 xaxis = safeNormalizef(cross(up, zaxis));
    float3 yaxis = cross(zaxis, xaxis);
    
    return float4x4(
        float4(xaxis, -dot(xaxis, eye)),
        float4(yaxis, -dot(yaxis, eye)),
        float4(zaxis, -dot(zaxis, eye)),
        float4(0.0, 0.0, 0.0, 1.0)
    );
}


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

inline OpticalPathResult CreateOpticalPathResult(
    C3 wavelengthsNM,
    float3 refractiveIndex,
    PathMeasurement measurement,
    PathMeasurement opticalMeasurement,
    PhaseInterference phaseInterference,
    C3 intensityModulationM,
    float3 absorptionEffect)
{
    OpticalPathResult ret;
    ret.wavelengthsNM = wavelengthsNM;
    ret.refractiveIndex = refractiveIndex;
    ret.measurement = measurement;
    ret.opticalMeasurement = opticalMeasurement;
    ret.phaseInterference = phaseInterference;
    ret.intensityModulationM = intensityModulationM;
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



inline C3 LinearRGBToSRGB(float3 linearRGB)
{
    float3 srgb;
    linearRGB = clamp(linearRGB, EPSILON3, OneMinusEPSILON3);
    srgb.x = max(EPSILON, lerp((linearRGB.x * 12.92), (1.055 * pow(max(linearRGB.x, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.x, 0.0031309)));
    srgb.y = max(EPSILON, lerp((linearRGB.y * 12.92), (1.055 * pow(max(linearRGB.y, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.y, 0.0031309)));
    srgb.z = max(EPSILON, lerp((linearRGB.z * 12.92), (1.055 * pow(max(linearRGB.z, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.z, 0.0031309)));
    return CSat(AdjustGamma(CV0(srgb)));
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


inline float depthSample(Texture2D<float> depthMap, float2 uv, float invertDepth = -1, float useProjectedDepth = -1)
{
    float ret = depthMap.SampleLevel(sampleTypeMirror, uv, 0);
   
    ret = lerp(ret, 1.0 - ret, step(-.5, (uint(KeyQDown) |
    uint(invertDepth))));
    ret = lerp(ret, DepthScale * ret, step(-.5, (uint(KeyWDown) ^ uint(useProjectedDepth))));
    
    return ret;
}

inline float4 depthRaw4(Texture2D<float> depthMap, float2 uv, float radius = -1.0)
{
    float2 oosz = GetOosz(depthMap);
    
    radius = NormalRadius;
   
    float d1 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(-oosz.x * radius, 0.0), 0);
    float d3 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(0.0, -oosz.y * radius), 0);
    float d2 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(oosz.x * radius, 0.0), 0);
    float d4 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(0.0, oosz.y * radius), 0);
    return clamp(0 + float4(d1, d2, d3, d4), EPSILON, 1.0 - EPSILON);
}

inline float4 depthRaw5(Texture2D<float> depthMap, float2 uv, out float center, float radius = -1.0)
{
    center = clamp(0 + depthMap.SampleLevel(sampleTypeMirror, uv, 0), EPSILON, 1.0 - EPSILON);
    
    return depthRaw4(depthMap, uv, radius);
}

inline float depth2D(Texture2D<float> depthMap, float2 uv, bool invertDepth = true, bool useProjectedDepth = false, float radius = -1.0)
{
    float center;
    float4 d = depthRaw5(depthMap, uv, center, radius);
   
    float ret = lerp((d.x + d.y + d.z + d.w) * .25, center, 0.75);
    ret = lerp(ret, 1.0 - ret, step(0.5, invertDepth));
    ret = lerp(ret, DepthScale * ret, step(0.5, useProjectedDepth));
    
    return ret;
}



float ComputeCurvature(Texture2D<float> depthMap, float2 oosz, float2 inputUV, bool invertDepth, bool useProjectedDepth)
{
    // Compute curvature using second-order finite differences (Laplacian approximation).
    // 'oosz' is the reciprocal of the texture dimensions (i.e. texel size).

    // depthRaw5 returns a float4 'd' with neighboring depth samples and sets 'center' to the central depth.
    // For example, we assume:
    //    d.x = left, d.y = right, d.z = up, d.w = down.
    float center;
    float4 d = depthRaw5(depthMap, inputUV, center, NormalRadius);

    // Compute second-order derivatives:
    // dxx approximates the second derivative in the x direction.
    float dxx = (d.y + d.x - 2.0 * center) / (oosz.x * oosz.x);
    // dyy approximates the second derivative in the y direction.
    float dyy = (d.z + d.w - 2.0 * center) / (oosz.y * oosz.y);
    
    // Combine the second derivatives to estimate a curvature measure.
    float curvature = dxx * dyy;
    
    // Clamp the curvature to a reasonable range to avoid extreme values.
    float ret = clamp(curvature, EPSILON, 1.0 - EPSILON);
    
    // If depth is inverted, optionally flip the curvature.
    ret = lerp(ret, (1.0 - ret), step(0.5, invertDepth));
    
    // Optionally, if using projected depth, adjust the curvature scaling.
    // For example:
    // ret = useProjectedDepth ? (DepthScale * ret) : ret;
    
    return ret;
}

//---------------------------------------------------------------------------
// 1) Complex Fresnel for metallic or multi-layer surfaces
//    F_complex = |(eta - k) - cosθ|^2 / |(eta + k) + cosθ|^2, but extended to C3

C3 FresnelComplex(float3 F0, float NdotH, float3 n_real, float3 n_imag, float FresnelPower)
{
    // 1. Extract the magnitude and phase from the complex refractive index.
    float3 magnitude = sqrt(n_real * n_real + n_imag * n_imag);
    float3 phase = atan2(n_imag, n_real); // Phase in radians.

    // 2. Normalize phase to [0, 1] for modulating the Fresnel exponent.
    float3 normPhase = (phase + 3.14159265) / (2.0 * 3.14159265);

    // 3. Modulate the Fresnel exponent using the normalized phase.
    //    This variation subtly adjusts the angular falloff.
    float3 modulatedPower = FresnelPower * (0.75 + 0.5 * normPhase);

    // 4. Compute the base reflectance amplitude using Schlick's approximation.
    float3 amplitude = F0 + (1.0 - F0) * pow(1.0 - NdotH, modulatedPower);

    // 5. Introduce a creative boost using the magnitude.
    //    This amplifies the reflectance for materials with a higher refractive "strength."
    amplitude *= lerp(1.0, magnitude, 0.3); // Blends 30% of the magnitude into the amplitude.

    // 6. Construct the complex reflectance: amplitude * exp(i * phase)
    float3 realPart = amplitude * cos(phase);
    float3 imagPart = amplitude * sin(phase);
    
    return CV(realPart, imagPart);
}

C3 FresnelComplex(float3 eta_ratio, float3 k_ratio, float3 cosTheta, float3 cosThetaT)
{
    // Construct the complex refractive index for the transmitted medium:
    // n = eta_ratio - i*k_ratio
    C3 n = CV(eta_ratio, -k_ratio);
    
    // Represent cosThetaT as a complex number (real, zero imaginary)
    C3 cT = CV(cosThetaT, ZERO3);
    
    // For s-polarization: r_s = (n - cT) / (n + cT)
    C3 r_s = CDiv(ComplexSub(n, cT), CAdd(n, cT));
    
    // For p-polarization: multiply the incident cosine by n.
    // Represent cosTheta as a complex number (same for all channels).
    C3 cTheta = CV(cosTheta, ZERO3);
    // r_p = (cTheta * n - cT) / (cTheta * n + cT)
    C3 r_p = CDiv(ComplexSub(CMul(cTheta, n), cT),
                                CAdd(CMul(cTheta, n), cT));
    
    // Average the two polarizations for unpolarized light:
    C3 F_complex = ComplexScale(CAdd(r_s, r_p), 0.5);
    
    return F_complex;
}

//---------------------------------------------------------------------------
// 2) Thin-Film Interference using a known film thickness d, film ior filmIor
//    Basic approach: reflectance from film + substrate. This is a simplified
//    single-layer formula using complex arithmetic for the layer.

C3 FresnelThinFilm(C3 filmIor, float3 cosTheta, float d, float lambda_nm)
{
    // Convert nm to same scale as your geometry if needed
    float twoPi = 6.2831853;
    float3 phase = twoPi * d * filmIor.real / lambda_nm; // ignoring absorption for brevity
    // Incorporate absorption if filmIor.imag != 0
    C3 iorCos = CV(filmIor.real * cosTheta, filmIor.imag * cosTheta);
    // r12: boundary air->film, r21: boundary film->air. Very simplified
    C3 top = CSub(iorCos, C10);
    C3 bot = CAdd(iorCos, C10);
    C3 r12 = CDiv(top, bot);

    // Complex exponent for phase shift: e^( i*2*phase )
    // We'll treat phase shift in real part = 0, imag part = 2*phase
    C3 ePhase = C0V(2.0 * phase);
    ePhase = CExp(ePhase);

    // Net reflection = r12 + r12* e^(i 2 phase) / (1 + r12^2 e^(i 2 phase) ) ...
    // A standard interference formula. This is just an example, not a final solution
    C3 r12sqr = CMul(r12, r12);
    C3 r12e = CMul(r12sqr, ePhase);
    C3 oneC = C10;

    C3 num = CAdd(r12, CMul(r12, ePhase));
    C3 den = CAdd(oneC, r12e);
    C3 net = CDiv(num, den);

    // Return magnitude^2 in real, ignoring sign
    float3 intens = net.real * net.real + net.imag * net.imag;
    return CV0(intens);
}

inline float DistributionGGX(float NdotH, float roughness)
{
    // Clamp roughness and NdotH to avoid degenerate cases
    roughness = clamp(roughness, EPSILON, 1.0);
    NdotH = clamp(NdotH, EPSILON, 1.0);

    // Compute alpha = roughness^2 and its square (alpha2 = roughness^4)
    float alpha = roughness * roughness;
    float alpha2 = alpha * alpha;

    // GGX NDF denominator: ((NdotH^2 * (alpha2 - 1) + 1)^2)
    float denom = ((NdotH * NdotH) * (alpha2 - 1.0) + 1.0);
    denom = denom * denom;

    // Return normalized GGX distribution, saturating the result
    return saturate(alpha2 / max(PI * denom, EPSILON));
}

//---------------------------------------------------------------------------
// 3) Example Microfacet Distribution: Beckmann or custom multi-lobe
//    D_beckmann = (1 / (α^2 cos^4θh)) * exp( (tan^2θh) / α^2 ), etc.

float MicrofacetDist_Beckmann(float roughness, float NoH)
{
    // NoH = dot(N, H)
    float alpha = roughness * roughness;
    float cos2 = NoH * NoH;
    float tan2 = (1 - cos2) / (cos2 + 1e-6) * 1.0; // approximate
    float denom = 3.14159 * alpha * alpha * cos2 * cos2;
    float exponent = -tan2 / alpha / alpha;
    float D = exp(exponent) / max(denom, 1e-6);
    return D;
}
float ErfApprox(float x)
{
    // Constants
    const float a1 = 0.254829592;
    const float a2 = -0.284496736;
    const float a3 = 1.421413741;
    const float a4 = -1.453152027;
    const float a5 = 1.061405429;
    const float p = 0.3275911;
    
    float s = sign(x);
    x = abs(x);
    float t = 1.0 / (1.0 + p * x);
    float y = 1.0 - (a1 * t + a2 * t * t + a3 * t * t * t + a4 * t * t * t * t + a5 * t * t * t * t * t) * exp(-x * x);
    return s * y;
}

// For float3:
float3 ErfApprox(float3 v)
{
    return float3(ErfApprox(v.x), ErfApprox(v.y), ErfApprox(v.z));
}
//---------------------------------------------------------------------------
// 4) Masking/Shadowing (Smith, etc.). This is just an example variant.

float G_SmithBeckmann(float NoV, float NoL, float roughness)
{
    float alpha = roughness * roughness + 1e-6;
    float lambdaV = 0.5 * ErfApprox((1 - NoV) / (NoV * alpha));
    float lambdaL = 0.5 * ErfApprox((1 - NoL) / (NoL * alpha));
    return 1.0 / (1.0 + lambdaV + lambdaL);
}

//---------------------------------------------------------------------------
// 5) Combined Specular BRDF using complex Fresnel + Beckmann + Smith

C3 SpecularBRDFComplex(
    float3 N, float3 V, float3 L, float roughness,
    C3 iorMetal /* or film if you want */
)
{
    N = normalize(N);
    V = normalize(V);
    L = normalize(L);
    
    float3 H = normalize(V + L + EPSILON3);
    float NoV = saturate(dot(N, V));
    float NoL = saturate(dot(N, L));
    float NoH = saturate(dot(N, H));
    float VoH = saturate(dot(V, H));

    float D = MicrofacetDist_Beckmann(roughness, NoH);
    
    float G = G_SmithBeckmann(NoV, NoL, roughness);
    
    // --- Compute normal incidence reflectance F0 per channel using the metal Fresnel equation ---
    // F0 = ((n - 1)² + k²) / ((n + 1)² + k²)
    float3 F0 = ((iorMetal.real - 1.0) * (iorMetal.real - 1.0) + (iorMetal.imag * iorMetal.imag)) /
                ((iorMetal.real + 1.0) * (iorMetal.real + 1.0) + (iorMetal.imag * iorMetal.imag));
    
    // --- Compute complex Fresnel reflectance per color channel ---
    // Each call returns a float2 where x is the real part and y is the imaginary part.
    C3 F = FresnelComplex(F0, VoH, iorMetal.real, iorMetal.imag, FresnelPower);
    
    // --- For the BRDF, use the magnitude of the complex reflectance per channel ---
    C3 F_complex_mag = CSatMag(F);
    
    // --- Combine the terms to form the specular BRDF ---
    // Standard microfacet BRDF: specular = (D * G * F) / (4 * NoV * NoL)
    C3 specular = CMul(CVV(NoV), CDiv(CMul(CMul(CV0(D), CV0(G)), F_complex_mag), CMul(CV0(4.0), CMul(CV0(NoV), CV0(NoL)))));
    specular = CMul(CVV(SpecularIntensity), CSatMag(CPow(specular, CVV(SpecularPower))));
    return specular;
    
}

C3 Fresnel(float3 cosThetaI, C3 eta, float cosTheta)
{
    float3 sinThetaI = sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    C3 sinThetaT = CDiv(CV(sinThetaI, cosThetaI), eta);
    C3 cosThetaT = ComplexSqrt(ComplexSub(C10, CMul(sinThetaT, sinThetaT)));

    C3 rs_num = ComplexSub(CMul(eta, CV(cosThetaI, sinThetaT.imag)), cosThetaT);
    C3 rs_den = CAdd(CMul(eta, CV(cosThetaI, sinThetaT.imag)), cosThetaT);
    C3 rs = CDiv(rs_num, rs_den);

    C3 rp_num = ComplexSub(CMul(eta, cosThetaT), CV(cosThetaI, sinThetaT.imag));
    C3 rp_den = CAdd(CMul(eta, cosThetaT), CV(cosThetaI, sinThetaT.imag));
    C3 rp = CDiv(rp_num, rp_den);

    C3 Rs = CMul(CAbs(rs), CAbs(rs));
    C3 Rp = CMul(CAbs(rp), CAbs(rp));
    C3 R = ComplexLerp(Rs, Rp, CV0(cosTheta));

    return CSub(CV0(1.0), R);
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

float3x3 CalcTBN(C3 normal)
{
    normal = safeNormalize(normal);
    C3 tangent = CV0(safeNormalizef(cross(normal.real, float3(0, -OneMinusEPSILON, 0))));
    C3 bitangent = CV0(safeNormalizef(cross(normal.real, tangent.real)));
    
    return float3x3(tangent.real, bitangent.real, normal.real);
    /*
    normal = (safeNormalize(normal));
    float3 tangent = (safeNormalize(cross(normal, float3(0, -1, 0))));
    float3 bitangent = safeNormalize(cross(normal, tangent));
    return float3x3(tangent, bitangent, normal);*/
}


// Computes the cross product for C3 values using their real parts.
// The result is returned as a C3 with the imaginary part set to ZERO3.
inline C3 ComplexCross(C3 a, C3 b)
{
    float3 crossReal = cross(a.real, b.real);
    return CV0(crossReal); // Creates a complex vector with real=crossReal, imag=ZERO3.
}

// Safe normalization for a C3 value based on its magnitude.
// It uses CAbs to compute the magnitude (assumed to return a C3 whose real part holds the magnitude)
// and then scales the real part appropriately.
inline C3 CSafeNormalize(C3 v)
{
    float mag = ComplexLength(v);
    // Avoid division by zero.
    mag = max(mag, EPSILON);
    // Normalize the real part; the imaginary part remains zero.
    return CV0(v.real / mag);
}


// Multiplies a Complex3x3 matrix by a C3 column vector.
// Uses both the real and imaginary parts of v.
inline C3 CMul3x3(Complex3x3 m, C3 v)
{
    // Construct complex scalars from each component of v (broadcast to float3).
    C3 scalarX = CV(v.real.xxx, v.imag.xxx);
    C3 scalarY = CV(v.real.yyy, v.imag.yyy);
    C3 scalarZ = CV(v.real.zzz, v.imag.zzz);
    
    // Multiply each column by the corresponding complex scalar.
    C3 col0 = CMul(m.tangent, scalarX);
    C3 col1 = CMul(m.bitangent, scalarY);
    C3 col2 = CMul(m.normal, scalarZ);
    
    // Sum the three contributions.
    return CAdd(CAdd(col0, col1), col2);
}

inline Complex3x3 Transpose(Complex3x3 m)
{
    Complex3x3 t;
    t.tangent = CV(float3(m.tangent.real.x, m.bitangent.real.x, m.normal.real.x),
                                 float3(m.tangent.imag.x, m.bitangent.imag.x, m.normal.imag.x));
    t.bitangent = CV(float3(m.tangent.real.y, m.bitangent.real.y, m.normal.real.y),
                                 float3(m.tangent.imag.y, m.bitangent.imag.y, m.normal.imag.y));
    t.normal = CV(float3(m.tangent.real.z, m.bitangent.real.z, m.normal.real.z),
                                 float3(m.tangent.imag.z, m.bitangent.imag.z, m.normal.imag.z));
    return t;
}

// Multiply a C3 row vector by a Complex3x3 matrix by transposing the matrix.
inline C3 mulRow(C3 v, Complex3x3 m)
{
    Complex3x3 mt = Transpose(m);
    return CMul3x3(mt, v);
}




C3 ComplexRefractiveIndexFromDispersionCoefficients(
    C3 wavelengthNM, float3 dispersionCoeffsNm2)
{
    wavelengthNM = CAdd(C00, wavelengthNM);
    C3 coef = CAdd(C00, CV0(dispersionCoeffsNm2));
    
    
    // Convert nm to μm and calculate λ² in μm²
    C3 um = nmToUm(wavelengthNM); // Convert wavelength from nm to μm
    C3 lambdaSq = CMul(um, um); // Compute λ² in μm²

    // Scale dispersion coefficients from nm² to μm²
    C3 coefUm = nmToUm(coef);

    C3 nSq = CAdd(C10,
            CAdd(CDiv(CMul(lambdaSq, coef), CMax(CEPSILON3, CSub(lambdaSq, coef))),
            CDiv(CMul(coef, lambdaSq), CMax(CEPSILON3, CAbs(CSub(lambdaSq, coef))))));
    
    // Clamp and return refractive index
    return ClampRefractiveIndex(CSqrt(nSq));
}


inline C3 RefractiveIndexFromDispersionCoefficients(
    C3 wavelengthsNM, float3 dispersionCoeffsNm2)
{
    wavelengthsNM = CAdd(C00, wavelengthsNM);
    dispersionCoeffsNm2 = 0 + dispersionCoeffsNm2;
    
    
    // Convert nm to μm and calculate λ² in μm²
    C3 um = nmToUm(wavelengthsNM); // Convert wavelength from nm to μm
    C3 lambdaSq = CMul(um, um); // Compute λ² in μm²

    // Scale dispersion coefficients from nm² to μm²
    C3 coeffUm = CV0(dispersionCoeffsNm2 * 1e-6);
    
    // Calculate n² using a Sellmeier-like dispersion model
    C3 nSq = CAdd(C10,
            CAdd(
                CDiv(
                        CMul(lambdaSq,
                        CMul(coeffUm, CV0(float3(1,0,0)))),
                    CMax(CEPSILON3,
                            CAbs(CSub(lambdaSq,
                                CMul(coeffUm, CV0(float3(0,1,0)))))))
                , CDiv(
                        CMul(
                        CMul(coeffUm, CV0(float3(0,0,1))),
                            lambdaSq),
                        CMax(CEPSILON3,
                            CAbs(CSub(lambdaSq, CMul(coeffUm, CV0(float3(0,0,1)))))))
    ));

    // Clamp and return refractive index
    return ClampRefractiveIndex(ComplexSqrt(nSq));
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
    float3 additionalPhase = PI3 * step(nSurrounding, nFilm);

    return phaseShift + additionalPhase;
}

C3 CreateWaveWithDepth(float depth, float3 absorptionCoefficient, C3 wavelengthsNM)
{
    // Calculate the wave number, k = 2*pi / wavelength
    C3 k = CDiv(C2PI, wavelengthsNM);

    // Phase shift due to depth
    C3 phase = CMul(nmToM(k), ComplexMagnitude(CV0(depth)));

    // Amplitude attenuation from absorption (exponential decay)
    C3 attenuation = CV0(exp(-absorptionCoefficient * depth));

    // Create a complex number: attenuation * exp(i * phase)
    // (i.e., real = attenuation * cos(phase), imag = attenuation * sin(phase))
    return CMul(attenuation, phase);
}


C3 InterferenceWithDepthEffect(
    float2 uv,
    float depth,
    float3 absorptionCoefficient,
    C3 wavelengthsNM,
    float3 initialIntensity)
{
    // Create a complex wave that encodes both depth (phase) and absorption.
    C3 wave = CreateWaveWithDepth(depth, absorptionCoefficient, wavelengthsNM);

    // For demonstration, assume we have a reference complex wave (e.g. from another surface).
    // In practice, this might come from another calculation.
    C3 refWave = CV(initialIntensity, ZERO3);

      // Interference: multiply the waves (phase addition and amplitude modulation)
    C3 mixedWave = CMul(wave, refWave);

    // Map the intensity to a color scale (for example, as a grayscale value).
    return CV(dot3(mixedWave.real, mixedWave.real), dot3(mixedWave.imag, mixedWave.imag));
}


inline PhaseInterference OpticalPhaseInterference(float3 wavelengthsM, float3 etaR, float3 nSurrounding, float3 thicknessM, float3 cosThetaT)
{
    float3 w = max(wavelengthsM, EPSILON3);

    float3 OPD = 2.0f * etaR * thicknessM * cosThetaT;
    float3 phaseDifference = (TWOPI3 * OPD) / w;

    float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, etaR);

    float3 totalPhase = phaseDifference + reflectionPhaseShift;

    return CreatePhaseInterference(OPD, phaseDifference, reflectionPhaseShift, totalPhase, cosThetaT);
}


inline OpticalPathResult OpticalPathDifference(
    C3 wavelengthsNM,
    float3 nSurrounding,
    PathMeasurement measurement,
    float3 dispersionCoeffs = ZERO3,
    float3 absorptionCoeff = ZERO3,
    float3 cosThetaT = ZERO3)
{
    
    
    C3 refractiveIndex = RefractiveIndexFromDispersionCoefficients(nmToM(wavelengthsNM), (dispersionCoeffs));

    PathMeasurement opticalMeasurement =
        CreatePathMeasurement(
            abs(measurement.PathLengthM) * refractiveIndex.real,
            abs(measurement.PathTotalLengthM) * refractiveIndex.real,
            abs(measurement.PathDifferenceM) * refractiveIndex.real);

    C3 phaseDifferenceM = CDiv(CMax(CEPSILON3, CMul(C20, CV0(opticalMeasurement.PathLengthM))),
    CMax(nmToM(wavelengthsNM), CEPSILON3));
    
    PhaseInterference pi = OpticalPhaseInterference(CAbs(nmToM(wavelengthsNM)).real, refractiveIndex.real, nSurrounding, opticalMeasurement.PathDifferenceM, cosThetaT);
    
    OpticalPathResult result = CreateOpticalPathResult(
        wavelengthsNM, refractiveIndex.real,
        measurement, opticalMeasurement, pi,
        ComplexCos(phaseDifferenceM),
        exp(-absorptionCoeff * opticalMeasurement.PathDifferenceM)
    );
    return result;
}

inline C3 DistanceMFromPointsNM(C3 point1NM, C3 point2NM)
{
    return nmToM(ComplexDistance(point1NM, point2NM));
}
inline C3 DistanceMFromPointsM(C3 point1M, C3 point2M)
{
    return ComplexDistance(point1M, point2M);
}
inline float3 DistanceMFromPointsNMf(float3 point1NM, float3 point2NM)
{
    return nmToMf(distance(point1NM, point2NM));
}

inline float3 DistanceMFromPointsMf(float3 point1M, float3 point2M)
{
    return distance(point1M, point2M);
}

inline PathMeasurement DistanceMFromViewToAB(C3 viewPointNM, C3 pointA, C3 pointB)
{
    float3 d =
        float3(ComplexLength(DistanceMFromPointsNM(viewPointNM, pointA)),
        ComplexLength(DistanceMFromPointsNM(viewPointNM, pointB)),
        ComplexLength(DistanceMFromPointsNM(pointA, pointB)));
    return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));
}
inline PathMeasurement DistanceMFromViewToABf(float3 viewPointM, float3 point1M, float3 point2M)
{
    float3 d = float3(
        length(DistanceMFromPointsMf(viewPointM, point1M)),
        length(DistanceMFromPointsMf(viewPointM, point2M)),
        length(DistanceMFromPointsMf(point1M, point2M)));
    return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));
}

inline PathMeasurement DifferenceMPathFromPointThicknessM(C3 viewPosNM, C3 pixelPosNM, C3 thicknessM, float3 pixelNormal = ZERO3)
{
    C3 dir = safeNormalize(CSub(pixelPosNM, viewPosNM));

    C3 distanceFront = ComplexDistance(viewPosNM, pixelPosNM);
    C3 pixelBackNM = CAdd(pixelPosNM, CMul(dir, mToNm(thicknessM)));
    C3 distanceBack = ComplexDistance(viewPosNM, pixelBackNM);

    float3 d =
        float3(ComplexLength(DistanceMFromPointsNM(viewPosNM, pixelPosNM)),
        ComplexLength(DistanceMFromPointsNM(viewPosNM, pixelBackNM)),
        ComplexLength(DistanceMFromPointsNM(pixelPosNM, pixelBackNM)));

    // Corrected: path difference as absolute difference, not distance(distanceBack,distanceFront)
    float3 pathDifferenceM = nmToMf(abs(distanceBack.real - distanceFront.real));

    return CreatePathMeasurement(
        ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * pathDifferenceM);
}

inline float3 FresnelDiffractionM(float distanceM, float3 wavelengthM)
{
    float3 fresnelTerm = (1.0 / sqrt(distanceM)) * cos(2.0 * PI * distanceM / wavelengthM);
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
    half3 N = safeNormalizef(normal);
    half3 V = safeNormalizef(viewDir);

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

inline float3 FresnelPhase(float3 sourcePosM, float3 observationPosM, float3 wavelengthM)
{
    half distanceM = half(length(observationPosM - sourcePosM));
    half3 phase = (2.0h * PI * distanceM) / max(half3(wavelengthM), (half3) EPSILON3);
    return float3(phase);
}

inline float3 PhaseShiftWavefront(float3 wavefront, float3 phaseShiftM)
{
    half3 phi = half3(wavefront + phaseShiftM);
    // sin(x)+cos(x) = sqrt(2)*sin(x+π/4), but we keep as-is for clarity
    half3 shifted;
    shifted.r = sin(phi.r) + cos(phi.r);
    shifted.g = sin(phi.g) + cos(phi.g);
    shifted.b = sin(phi.b) + cos(phi.b);

    return float3(safeNormalizef(float3(shifted)));
}

inline C3 RefractiveIndexFromAB3(C3 wavelengthNM, C3 A, C3 B)
{
    C3 lsq = CMax(CMul(wavelengthNM, wavelengthNM), CV0(EPSILON3h));
    C3 ret = CDiv(CAdd(A, B), lsq);
    return ClampRefractiveIndex(ret);
}

/*
inline float3 RefractiveIndexFromWavelengths(C3 wavelengthsNM, bool isOrdinary, MaterialSellmeier mat)
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
inline C3 RefractiveIndexFromSellmeier(C3 wavelengthsNM, bool isOrdinaryRay, MaterialSellmeier mat)
{
    wavelengthsNM = CMax(wavelengthsNM, CEPSILON3);
    float3 lambdaUM = nmToUm(wavelengthsNM).real; // nm to µm
    float3 lambdaSq = lambdaUM * lambdaUM;

    float sel = (float) (!isOrdinaryRay);

    float3 vB1 = lerp(mat.coeff.OE1.O.B, mat.coeff.OE1.E.B, sel);
    float3 vB2 = lerp(mat.coeff.OE2.O.B, mat.coeff.OE2.E.B, sel);
    float3 vB3 = lerp(mat.coeff.OE3.O.B, mat.coeff.OE3.E.B, sel);
    float3 vC1 = lerp(mat.coeff.OE1.O.C, mat.coeff.OE1.E.C, sel);
    float3 vC2 = lerp(mat.coeff.OE2.O.C, mat.coeff.OE2.E.C, sel);
    float3 vC3 = lerp(mat.coeff.OE3.O.C, mat.coeff.OE3.E.C, sel);

    float3 denom1 = max(lambdaSq - vC1, EPSILON3);
    float3 denom2 = max(lambdaSq - vC2, EPSILON3);
    float3 denom3 = max(lambdaSq - vC3, EPSILON3);

    float3 term1 = (vB1 * lambdaSq) / denom1;
    float3 term2 = (vB2 * lambdaSq) / denom2;
    float3 term3 = (vB3 * lambdaSq) / denom3;

    C3 nSquared = CV0(1.0f + term1 + term2 + term3);
    nSquared = CMax(nSquared, CEPSILON3);

    C3 n = ComplexSqrt(nSquared);
    C3 inRange = CV0(step(1.0f, n.real) * step(n.real, 5.0f));
    n = ComplexLerp(CV0(mat.etaR), n, inRange);

    return ClampRefractiveIndex(n);
}


inline float3 RefractiveIndexBirefringementFromAxis(float3 viewDir, float3 opticalAxis, float3 etaR, float3 etaO, float3 etaE)
{
    float3 normalizedViewDir = safeNormalizef(viewDir);
    float3 normalizedOpticalAxis = safeNormalizef(opticalAxis);

    float d = saturate(dot(normalizedViewDir, normalizedOpticalAxis));
    float angle = acos(d);

    float sa = sin(angle);
    float sa2 = sa * sa;
    float3 sinAngleSq = float3(sa2, sa2, sa2);

    float3 refractiveIndex = etaO + (etaE - etaO) * sinAngleSq;

    // Clamp indices to [1,5] using step and lerp
    float3 inRange = step(1.0f, refractiveIndex) * step(refractiveIndex, 5.0f);
    refractiveIndex = lerp(etaR, refractiveIndex, inRange);

    return ClampRefractiveIndex(CV0(refractiveIndex)).real;
}


inline float3 refract3(float3 i, float3 n, float3 ri)
{
    // Handle each component channel-wise
    float3 I = safeNormalizef(i);
    float3 N = safeNormalizef(n);

    // For wavelength-dependent refraction, we do it separately
    float3 outDir;
    float3 eta = max(ri, EPSILON3);

    // If you need fully channel-wise refract, 
    // you'd need a custom function. For demonstration:
    outDir.r = refract(I, N, eta.r).x; // using .x just to fetch some component
    outDir.g = refract(I, N, eta.g).y;
    outDir.b = refract(I, N, eta.b).z;

    return safeNormalizef(outDir);
}




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
    viewDir = safeNormalizef(viewDir);
    normal = safeNormalizef(normal);
    // dot(normal, viewDir) returns cos(theta), ensure value is within [-1, 1] before acos
    float c = clamp(dot(normal, viewDir), -1.0, 1.0);
    return acos(c);
}

// Helper to apply Snell's Law and calculate the transmitted angle (per-channel)
inline float3 TransmittedAngle(float3 normal, float3 viewDir, float3 nIncident, float3 nTransmitted)
{
    float cosThetaI = dot(safeNormalizef(normal), safeNormalizef(viewDir));
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
    float3 wDir = safeNormalizef(wavelength);
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

C3 FresnelDiffraction(Texture2D<float4> sourceMap, float2 uv, bool invertDepth, bool useProjectedDepth, float3 observationPos, float wavelength, float aperture)
{
    // Assume depth2D, sampleTypeMirror defined elsewhere
    float depth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float4 sourceSample = sourceMap.Sample(sampleTypeMirror, uv);
    float3 sourcePos = float3(uv, depth);

    // Calculate phase difference
    float3 phase = FresnelPhase(sourcePos, observationPos, wavelength);

    // Aperture function (e.g., circular aperture)
    float2 delta = uv - float2(0.5, 0.5);
    float apertureFunc = step(length(delta), aperture);

    // Complex amplitude
    float3 amplitude = sourceSample.xyz * apertureFunc;
    float3 s, c;
    sincos(phase, s, c);
    float3 real = amplitude * c;
    float3 imag = amplitude * s;

    return CV(real, imag);
}

// Fresnel equation per-channel (assuming eta per-channel for wavelength-dependent refractive index):
inline float3 fresnelEquation(float3 reflectedNormal, float3 refractedNormal, float3 eta)
{
    float3 N1 = safeNormalizef(reflectedNormal);
    float3 N2 = safeNormalizef(refractedNormal);

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
	float scalarUV = 1,
	float scalarZ = 1
)
{
    float2 sz = GetSz(noiseMap);

	// Calculate sample coordinates with varying frequency for each noise layer
    float2 sampleCoord1 = (n.xy * scalarUV + n.z * scalarZ) * sz;
    float2 sampleCoord2 = (n.xy * scalarUV + n.z * scalarZ * scalarZ) * sz;
    float2 sampleCoord3 = (n.xy * scalarUV + n.z * scalarZ * scalarZ * scalarZ) * sz;

	// Sample the noise textures at the calculated coordinates
    float3 v = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord1, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v2 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord2, 0).xyz, EPSILON3, OneMinusEPSILON3);
    float3 v3 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord3, 0).xyz, EPSILON3, OneMinusEPSILON3);
    return ((v + v2 + v3) / 3.0 * TWO3 - ONE3);
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
inline float3 noise2D(Texture2D<float3> noiseMap, float2 uv, float z = 0)
{
    return noise3(noiseMap, float3(uv, z)).xyz;
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
    int3 sz = int3(int2(GetSz(noiseMap1).xy), 4);

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
    return (clamp(noiseMap1.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
float3 noise3_11i2(int2 uv)
{
    return (clamp(noiseMap2.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
inline float3 noise3_11i3(int2 uv)
{
    return (clamp(noiseMap3.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
}
inline float3 noise3_11i4(int2 uv)
{
    return (clamp(noiseMap4.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3)) * TWO3 - ONE3;
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


// **Mirror 2D Function**
// =====================
inline float4 diffuse2D(Texture2D<float4> diffuseMap, float2 inputUV)
{
    return saturate(
        (diffuseMap.SampleLevel(sampleTypeMirror, inputUV, 0) * 1.5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + 0.00125, 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0, 0.0025), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0, -0.0025), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0.0025, 0), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(-0.0025, 0), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV - 0.00125, 0) * .5) * 1.0 / 4.5);
    
}
inline float4 diffuse2D(Texture2D<float3> diffuseMap, float2 inputUV)
{
    return float4(saturate(
        (diffuseMap.SampleLevel(sampleTypeMirror, inputUV, 0) * 1.5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + 0.00125, 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0, 0.0025), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0, -0.0025), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(0.0025, 0), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV + float2(-0.0025, 0), 0) * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, inputUV - 0.00125, 0) * .5) * 1.0 / 4.5), 1);
}

inline void InitPSOut(out psout ret, float2 uv)
{
    ret = (psout) 0;
    // Create a mask: 1.0 if PassNum > 0.5, else 0.0
    float mask = step(0.1, PassNum);
    
    // Define a zero vector with alpha 1.0
    float4 zeroVec = float4(0.0, 0.0, 0.0, 1.0);
    
    // Assign each render target using lerp based on the mask
    ret.rt1 = lerp(zeroVec, diffuse2D(rtMap1, uv), mask);
    ret.rt2 = lerp(zeroVec, diffuse2D(rtMap2, uv), mask);
    ret.rt3 = lerp(zeroVec, diffuse2D(rtMap3, uv), mask);
    ret.rt4 = lerp(zeroVec, diffuse2D(rtMap4, uv), mask);
    ret.rt5 = lerp(zeroVec, diffuse2D(rtMap5, uv), mask);
    ret.rt6 = lerp(zeroVec, diffuse2D(rtMap6, uv), mask);
    ret.rt7 = lerp(zeroVec, diffuse2D(rtMap7, uv), mask);
    ret.rt8 = lerp(zeroVec, diffuse2D(rtMap8, uv), mask);
    

}


inline float3 sampleNormal2D(Texture2D<float3> normalMap, float2 inputUV, bool invertDepth)
{
    float3 nm = saturate(normalMap.SampleLevel(sampleTypeMirror, inputUV, 0).xyz);
    nm.x = 1.0 - nm.x;
    nm = lerp(1 - nm, nm, step(0.5, invertDepth));
    return normalize(nm * 2 - 1);
}

inline float3 normal2D(Texture2D<float3> normalMap, float2 inputUV, bool invertDepth = true, float radius = -1)
{
    float2 oosz = GetOosz(normalMap);
    float3 n = noise2D(noiseMap1, inputUV);;
    radius = lerp(NormalRadius, radius, step(0.5, radius));
    
    float3 nm = sampleNormal2D(normalMap, inputUV, invertDepth);
    float3 nm2 = sampleNormal2D(normalMap, inputUV + radius * oosz, invertDepth);
    float3 nm3 = sampleNormal2D(normalMap, inputUV - radius * oosz, invertDepth);
    return normalize(lerp(lerp(nm2, nm3, 0.5), nm, 0.75));
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

    return gradient;
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
    float3 normal = safeNormalizef(float3(-dxy.x, -dxy.y, 1.0));

    return normal * 2.0 - 1.0;
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




inline C3 PhaseModulation(C3 wavelengthM, C3 thicknessM, C3 refractiveIndex)
{
    // Ensure parameters are positive to avoid invalid calculations.
    thicknessM = CMax(CAdd(C00, thicknessM), CEPSILON3);
    wavelengthM = CMax(CEPSILON3, wavelengthM);
    refractiveIndex = CV0(max(refractiveIndex.real, 1e-6));

    // Phase modulation φ = (2π * n * t) / λ
    float3 phaseModulation = (2.0 * PI * refractiveIndex.real * thicknessM.real) / wavelengthM.real;

    // Wrap the phase modulation to the range [0, 2π]
    phaseModulation = fmod(phaseModulation, 2.0 * PI);

    return CV0(phaseModulation);
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

ComplexPolarized ComplexPolarizedAdd(ComplexPolarized a, ComplexPolarized b)
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
    float3 distance = nmToMf(length(normUV));
    float intensity = gaussian3D(distance, beamWaist);

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
    float3 totalWeight = EPSILON3;

    // Horizontal pass
    [unroll]
    for (int x = -radius; x <= radius; x++)
    {
        float3 weight = nmToMf(gaussian(float(x), sigma));
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
        float3 weight = nmToMf(gaussian(float(y), sigma));
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
    return adjustDepthGradientSigmoid(depthGradient, lerp(float2(OneMinusEPSILON, EPSILON), float2(EPSILON, OneMinusEPSILON), step(0.5, !KeyQDown)));
}


// Calculates the gradient of a depth map at a given UV coordinate.
inline float2 GetGradient(Texture2D<float> depthMap, float2 uv, bool invertDepth, bool useProjectedDepth)
{
    float2 oosz = GetOosz(depthMap);

    float grad1 = depthMap.SampleLevel(sampleTypeMirror, uv, 0);
    grad1 = lerp(grad1, 1.0 - grad1, invertDepth);
    float2 v1 = float2(ddx_fine(grad1), ddy_fine(grad1));

    float grad2 = depthMap.SampleLevel(sampleTypeMirror, uv + oosz, 0);
    grad2 = lerp(grad2, 1.0 - grad2, invertDepth);
    float2 v2 = float2(ddx_fine(grad2), ddy_fine(grad2));

    return lerp(float3(v1.xy, grad1), float3(v2.xy, grad2), 0.5).xy;
}

inline float GetModulatedDepth(Texture2D<float> depthMap, float2 uv, bool invertDepth, bool useProjectedDepth, bool gradientUseProjectedDepth, int2 offset = int2(0, 0))
{
    float2 oosz = GetOosz(depthMap);
    float2 gradient = GetGradient(depthMap, uv, invertDepth, gradientUseProjectedDepth);
    float2 modulation = GetModulation(gradient);
    return depth2D(depthMap, uv + float2(offset) * oosz * modulation, invertDepth, useProjectedDepth);
}


//---------------------------------------------------------------------------
// Diffraction Weight Function
//---------------------------------------------------------------------------
// Computes the squared sinc function (sinc^2) as a diffraction weight.
// For a kernel offset (dx, dy) and a given kernelRadius, returns
// the squared value of sin(PI*(dist/kernelRadius))/(PI*(dist/kernelRadius)).
float ComputeDiffractionWeight(int dx, int dy, float kernelRadius)
{
    float dist = sqrt((float) (dx * dx + dy * dy));
    // For very small distances, return 1.0 (limiting value sinc(0)=1)
    if (dist < 1e-4)
        return 1.0;
    float x = PI * (dist / kernelRadius);
    float sinc = sin(x) / x;
    return sinc * sinc;
}

//---------------------------------------------------------------------------
// Curvature Computation Function
//---------------------------------------------------------------------------
// Computes the curvature at a given UV coordinate using a simple Laplacian 
// (4-neighbor) approximation from a depth map.
float CalcCurvature(
    Texture2D<float> depthMap, // Depth map texture.
    float2 uv, // Texture coordinates.
    float2 texelSize, // Reciprocal of the texture dimensions.
    bool invertDepth, // Depth inversion flag.
    bool useProjectedDepth // Projected depth flag.
)
{
    // Sample the central depth.
    float center = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    

    // Sample neighboring depths.
    float left = depth2D(depthMap, uv - float2(texelSize.x, 0.0), invertDepth, useProjectedDepth);
    float right = depth2D(depthMap, uv + float2(texelSize.x, 0.0), invertDepth, useProjectedDepth);
    float up = depth2D(depthMap, uv + float2(0.0, texelSize.y), invertDepth, useProjectedDepth);
    float down = depth2D(depthMap, uv - float2(0.0, texelSize.y), invertDepth, useProjectedDepth);
    
    // Calculate the Laplacian (sum of neighbors minus 4 times the center).
    float laplacian = left + right + up + down - 4.0 * center;
    return laplacian;
}

//---------------------------------------------------------------------------
// Optical Path Length (OPL) Phase Function
//---------------------------------------------------------------------------
// Computes the optical path length phase contribution as:
// phase = (cAngularFrequency / SPEED_OF_LIGHT) * (cRefractiveIndex * depth)
C3 ComputeOPLPhase(C3 cAngularFrequency, C3 cRefractiveIndex, C3 depth)
{
    // Multiply the refractive index by the depth.
    C3 opL = CMul(cRefractiveIndex, depth);
    // Scale the angular frequency by 1/SPEED_OF_LIGHT and multiply by opL.
    return CMul(CDiv(cAngularFrequency, CV0(SPEED_OF_LIGHT)), opL);
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
    parallaxDir = safeNormalizef(parallaxDir);
    
    // Apply perturbation by adding a scaled parallax direction
    float3 perturbedNormal = float3(normal.xy + parallaxDir * perturbationStrength, normal.z);
    
    // Normalize the resulting normal vector
    return safeNormalizef(perturbedNormal);
}



inline float3 noiseFast3D_01(float3 v, float speed = 0.0001)
{
    // Assumes TotalTime and AnimateSpeed are defined as external or uniform variables
    // Also assumes the existence of the tanh function (common in modern HLSL targets)
    // If tanh is not available, consider implementing your own approximation or using another function.

    float timeFactor = AnimateTime * speed;

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
    float timeFactor = AnimateTime * speed;
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
    float timeFactor = AnimateTime * speed;
    float n = cos(dot(v, float2(12.9898, 78.233)) + timeFactor) * 43758.5453;
    return frac(n);
}

// 2D Noise in [-1,1]
inline float noiseFast2D_11(float2 v, float speed = 0.0001)
{
    return noiseFast2D_01(v, speed) * 2.0 - 1.0;
}

// Compute angular frequency from frequency f (Hz)
inline C3 AngularFrequency(C3 f)
{
    return CMul(CV0(2.0 * PI), f);
}


inline float InterferenceWavelengthShift(float baseWavelength, float thickness, float viewAngle)
{
    // Simulate interference by shifting wavelength based on thickness and angle
    float shift = thickness * sin(viewAngle * 10.0 + AnimateTime) * 20.0;
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


//---------------------------------------------------------------------------
// Fresnel Phase Function (Schlick Approximation)
//---------------------------------------------------------------------------
// Computes the Fresnel phase using Schlick's approximation:
// F(θ) = R0 + (1 - R0) * (1 - cosθ)^FresnelPower
// where cosθ is computed as the dot product between the view direction 
// (in tangent space) and the surface normal.
C3 ComputeFresnelPhase(C3 R0, C3 viewDirTS, C3 normal)
{
    // Compute the cosine of the incidence angle.
    C3 cosTheta = CDot(viewDirTS, normal);
    // Compute (1 - cosθ)
    C3 oneMinusCos = CSub(CV0(1.0), cosTheta);
    // Raise (1 - cosθ) to the Fresnel power. Assume FresnelPower is defined.
    C3 term = CPow(oneMinusCos, CV0(FresnelPower));
    // Multiply by (1 - R0)
    C3 oneMinusR0 = CMax(C0, CSub(CV0(1.0), R0));
    C3 fresnelContribution = CMul(oneMinusR0, term);
    // Add R0 back in.
    return CMin(C1, CAdd(R0, fresnelContribution));
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


float3 InterferencePattern2(float2 uv, float time)
{
    C3 pattern = CV0(float3(
        sin(uv.x * 500.0 + time * 50.0),
        sin(uv.y * 500.0 + time * 50.0),
        sin((uv.x + uv.y) * 500.0 + time * 50.0)));

    pattern = CDiv(CAdd(pattern, CV0(3.0)), CV0(6.0));
    return ComplexSmoothstep(CV0(0.45), CV0(0.55), pattern).real;
}

inline C3 nmToNormalizedHz(C3 nm)
{
    // Compute frequency in Hz (using your nmToHz function)
    C3 freq = nmToHz(nm);
    // Define the expected min and max frequencies based on your wavelength range.
    float3 minFreq = float3(3.0e14, 3.0e14, 3.0e14);
    float3 maxFreq = float3(3.0e15, 3.0e15, 3.0e15);
    // Normalize: (f - minFreq) / (maxFreq - minFreq)
    float3 norm = saturate((freq.real - minFreq) / (maxFreq - minFreq));
    // Return the normalized value in both real and imaginary parts.
    return CV(norm, norm);
}


float3x3 CalcTBN3f(
    Texture2D<float> depthMap, // Depth map texture.
    float2 depthUV, // Input UV coordinates.
    bool invertDepth, // Whether to invert depth values.
    bool useProjectedDepth,
    float normalRadius,
    out float3 normalWorld)         // Output: computed world-space normal.
{
    float radius = lerp(NormalRadius, normalRadius, step(1.0, normalRadius));
    
    float2 oosz = GetOosz(depthMap);
    // Define offsets for sampling neighboring pixels (up and right).
    float2 offsetUp = float2(0.0, -1.0);
    float2 offsetRight = float2(1.0, 0.0);
    
    float2 dd = GetModulation(GetGradient(depthMap, depthUV, invertDepth, true));
    
    float centerDepth = depthMap.SampleLevel(sampleTypePoint, depthUV, 0);
    float upDepth = depthMap.SampleLevel(sampleTypePoint, depthUV + dd * offsetUp * radius * oosz - offsetUp * oosz * radius * .5, 0);
    float rightDepth = depthMap.SampleLevel(sampleTypePoint, depthUV + dd * offsetRight * radius * oosz - offsetRight * oosz * radius * .5, 0);
    
    float upDepth2 = depthMap.SampleLevel(sampleTypePoint, depthUV + dd * offsetUp * radius * oosz * 2 - offsetUp * oosz * radius, 0);
    float rightDepth2 = depthMap.SampleLevel(sampleTypePoint, depthUV + dd * offsetRight * radius * oosz * 2 - offsetRight * oosz * radius, 0);
    
    float3 d = (lerp(float3(centerDepth, upDepth2, rightDepth2),
    float3(centerDepth, upDepth, rightDepth), 0.75) * 2 - 1);
    d = lerp(1 - d, d, step(0.5, invertDepth));
   
    // Construct positions in 3D space using the UV coordinates as (x,y) and depth as z.
    float3 centerPos = float3(depthUV, d.x);
    float3 upPos = float3(depthUV - offsetUp * dd, d.y);
    float3 rightPos = float3(depthUV + offsetRight * dd, d.z);
    
    // Compute directional differences using complex subtraction and normalize them.
    float3 dUp = -normalize(upPos - centerPos);
    float3 dRight = normalize(rightPos - centerPos);
    
    // Compute the surface normal using a complex cross product (computed on the real parts).
    float3 normal = normalize(cross(dUp, dRight));
    // Define tangent and bitangent as the normalized directional differences.
    float3 tangent = dRight;
    float3 bitangent = dUp;
    
    float3x3 tbnf;
    tbnf[0] = tangent;
    tbnf[1] = bitangent;
    tbnf[2] = normal;
    
    // Transform computed normal to world space if needed (here, we use the TBN as transformation).
    // Depending on your pipeline, you might simply output computedNormal (a float3) instead.
    normalWorld = normalize(mul(tbnf, normal));
   
    return tbnf;
}

float3x3 CalcTBN3f(
    Texture2D<float> depthMap, // Depth map texture.
    float2 depthUV, // Input UV coordinates.
    bool invertDepth = true,
    bool useProjectedDepth = true,
    float normalRadius = -1)
{
    float3 normal;
    return CalcTBN3f(depthMap, depthUV, invertDepth, useProjectedDepth, normalRadius, normal);
}


float3 CalcNormal(
    Texture2D<float> depthMap, // Depth map texture.
    float2 depthUV, // Input UV coordinates.
    bool invertDepth,
    bool useProjectedDepth,
    float normalRadius = -1)
{
    float3 normal;
    CalcTBN3f(depthMap, depthUV, invertDepth, useProjectedDepth, normalRadius, normal);
    return normal;
}


//------------------------------------------------------------------------------
// CalcTBN3_Stable: Compute a robust TBN matrix from a depth map using a Sobel operator.
// The function uses a 3x3 neighborhood to compute spatial derivatives.
// It returns the TBN matrix (in Complex3x3 form) and outputs the computed world-space normal.
Complex3x3 CalcTBN3(
    Texture2D<float> depthMap, // Depth map texture.
    float2 depthUV, // Input UV coordinates.
    bool invertDepth, // Whether to invert depth values.
    bool useProjectedDepth,
    out C3 normalWorld)         // Output: computed world-space normal.
{
    float3 normal;
    float3x3 tbnf = CalcTBN3f(depthMap, depthUV, invertDepth, useProjectedDepth, NormalRadius, normal);

    Complex3x3 tbn;
    tbn.tangent = CV0(tbnf[0]);
    tbn.bitangent = CV0(tbnf[1]);
    tbn.normal = CV0(tbnf[2]);

    normalWorld = CV0(normal);
   
    return tbn;
}
Complex3x3 CalcTBN3(
    Texture2D<float> depthMap, // Depth map texture.
    float2 depthUV, // Input UV coordinates.
    bool invertDepth = true,
    bool useProjectedDepth = true)         // Output: computed world-space normal.
{
    C3 normal;
    return CalcTBN3(depthMap, depthUV, invertDepth, useProjectedDepth, normal);
}

float3 CalcNormal2(Texture2D<float> depthMap, float2 depthUV, float3 viewPos, bool invertDepth, bool useProjectedDepth, int radius = 1)
{
    float3 normal;
    CalcTBN3f(depthMap, depthUV, invertDepth, useProjectedDepth, radius, normal);
    return normal;
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
C3 InterferenceIntensityFromAmplitudeWave(float amplitude1, float phase1, float amplitude2, float phase2)
{
    // Resulting intensity I = |E1 + E2|^2
    // E1 = A1 * exp(i * φ1), E2 = A2 * exp(i * φ2)
    float s1, c1;
    sincos(phase1, s1, c1);
    float s2, c2;
    sincos(phase2, s2, c2);
    float realPart = amplitude1 * c1 + amplitude2 * c2;
    float imagPart = amplitude1 * s1 + amplitude2 * s2;

    return CV(ONE3 * realPart, ONE3 * imagPart);
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
inline float3 InterferenceComplex(float2 uv, float time, float3 frequency, float3 speed)
{
    float angle = atan2(uv.y - 0.5, uv.x - 0.5);
    float radius = length(uv - 0.5);
    float3 interference = sin(radius * frequency - time * speed + angle * frequency);
    return 0.5 + 0.5 * interference;
}

inline float3 InterferencePolarized(float3 phaseShift, float3 polarAngle)
{
    float3 polarizationEffect = sin(phaseShift + polarAngle);
    return (polarizationEffect * 0.5 + 0.5) * 0.8 + 0.2;
}


inline float3 InterferenceColor(
    float2 inputUV,
    float time,
    float3 pixel,
    float thicknessM,
    float3 normal,
    float3 viewPos,
    float3 lightPos,
    float3 viewDir,
    C3 wavelengthsNM,
    float3 nIncident,
    float3 nFilm,
    float initialIntensity,
    float attenuationCoefficient,
    float3 coherenceLength,
    float polarizationAngle,
    float3 dispersionCoefficients,
    float absorptionCoefficient,
    MaterialSellmeier mat
)
{
    // Compute the necessary geometric quantities:
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);

    float3 cosThetaI = saturate(dot3(normal, viewDir));
    float3 ratio = nIncident / max(nFilm, EPSILON3);
    float3 sinThetaI = sqrt(max(ONE3 - cosThetaI * cosThetaI, EPSILON3));
    float3 sinThetaT = ratio * sinThetaI;
    sinThetaT = min(sinThetaT, OneMinusEPSILON3);
    float3 cosThetaT = sqrt(max(ONE3 - sinThetaT * sinThetaT, EPSILON3));

// Get the optical path information.
    PathMeasurement measurement = DistanceMFromViewToAB(CV0(viewPos), CV0(pixel), CV0(lightPos));
    OpticalPathResult opd = OpticalPathDifference(wavelengthsNM, nIncident, measurement,
                                               dispersionCoefficients, absorptionCoefficient, cosThetaT);
    float3 lightDistanceM = opd.opticalMeasurement.PathLengthM;
    float3 lightAttenuation = LightAttenuation(lightDistanceM, attenuationCoefficient);

// Determine whether we are in total internal reflection (TIR).
    float TIRMask = IsTotalInternalReflectionFactor(nIncident, nFilm, cosThetaI);

// Now compute the complex reflectance all at once.
// (Here we assume you have overloaded InterferenceThinFilm_Complex so it accepts
// float3 values per channel – it returns a C3 whose real and imaginary parts
// are computed from the film phase shift and Fresnel reflection.)
    C3 cosThetaT2;
    C3 R_complex = FresnelReflectanceFromFilmC2(half3(nIncident),
        CV(mat.etaR, mat.etaI),
        half3(cosThetaI), cosThetaT2);

// The reflectance is the squared magnitude:
    float3 reflectance = CMagnitude3f(R_complex);

// Apply coherence and polarization effects:
    float3 coherenceFactor = CoherenceFactor(opd.opticalMeasurement.PathDifferenceM, coherenceLength);
    float3 polarizationEffect = PolarizationEffect(polarizationAngle, R_complex.real, R_complex.real); // (or however you want to combine)

// Now combine everything:
    reflectance *= coherenceFactor * polarizationEffect;
    reflectance *= LightIntensity(initialIntensity, opd.opticalMeasurement.PathLengthM) * lightAttenuation;
    reflectance = lerp(reflectance, ONE3, TIRMask);

// The final interference “color” is given by 1 - reflectance:
    float3 finalColor = 1.0 - reflectance;
    return saturate(finalColor);

}




InterferencePattern Interference(HolographicLight light1, HolographicLight light2, float3 pointInSpace)
{
    InterferencePattern pattern;

    float distance1 = length(light1.position - pointInSpace);
    float distance2 = length(light2.position - pointInSpace);
    float pathDifference = abs(distance1 - distance2);

    C3 wavelengthNM = CMax(light1.wavelengthNM, CEPSILON3);
    C3 phaseDiff = CDiv(CV0(2.0 * PI * pathDifference), wavelengthNM);

    C3 combinedPhase = ComplexSub(
        CAdd(
            CDot(phaseDiff, C11),
            CV0(light1.phaseOffset)), CV0(light2.phaseOffset));

    // No if: just straightforward computations
    pattern.amplitude = CMul(C20, CMul(ComplexSqrt(CV0(light1.intensity)), CV0(light2.intensity))),
        ComplexCos(CMul(combinedPhase, CV0(0.5)));
    pattern.frequency = CV0((light1.wavelengthNM.real + light2.wavelengthNM.real) * 0.5);
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

void AccumulateInterference(Texture2D<float3> noiseMap, Texture2D<float> depthMap, Texture2D<float4> diffuseMap, float2 uv,
 // Expected to be in the same space as adjustedUV.
 bool invertDepth, bool useProjectedDepth, float time, bool xrayMode, float offsetScalarI, float offsetScalarR, float offsetDepth, float centralWeight,
 // Scalar weight for central contribution
 float3 fresnelFactor,
 // Scalar factor for Fresnel phase
 float angularFrequencyScalar, MaterialSellmeier mat, Complex3x3 tbn, C3 viewPos, C3 curvatureFactor, float oplFactor, C3 normal, out C3 accum, out C3 weightSum)
{
    accum = C00;
    weightSum = C00;
    int halfKernel = 4;
    float2 oosz = GetOosz(depthMap);
    float2 ooszD = GetOosz(diffuseMap);
    float2 ooszN = GetOosz(noiseMap);
    [loop]
    for (int i = -halfKernel; i <= halfKernel; i++)
    {
        [loop]
        for (int j = -halfKernel; j <= halfKernel; j++)
        {
            if (i == 0 && j == 0)
                continue;
            
            float2 uv2 = uv + float2(i, j) * oosz;
            float2 uvD2 = uv + float2(i, j) * ooszD;
            float2 uvN = uv + float2(i, j) * ooszN;

	         // Sample depth at the current kernel position and add an offset
	         C3 depth2 = CAdd(CV0(offsetDepth), CV0(depth2D(depthMap, uv2, invertDepth, useProjectedDepth)));
	         // Create a 3D pixel position (using uv2 and the sampled depth)
	         C3 pixel2 = CV0(float3(uv2, depth2.real.x));
	         // Compute the view direction for this sample
	         C3 viewDir2 = ComplexNormalize(CSub(viewPos, pixel2));
	         // Retrieve diffuse albedo at a slightly offset coordinate
	         C3 albedo = CV0(diffuse2D(diffuseMap, uvD2).rgb);

	        // Convert diffuse albedo to effective wavelengths (in nm) and then to meters 
            C3 wavelengthsNM2 = RGBToWavelengthsNM(albedo);
            C3 wavelengthsM2 = nmToM(wavelengthsNM2);
	        // Compute frequency and angular frequency
            float3 c = SPEED_OF_LIGHT;
            float3 frequency = c / max(nmToHz(wavelengthsNM2).real, EPSILON3);
            float3 angularFrequency2 = fmod(AngularFrequency(CV0(frequency)).real, 2 * PI);
            angularFrequency2 = angularFrequency2 < 0 ? angularFrequency2 + 2.0 * PI : angularFrequency2;
	        // Compute the optical path length phase contribution using the absolute depth 
	        C3 oplComplex = ComputeOPLPhase(CV0(angularFrequency2), CV0(mat.etaR), CAbs(depth2));
	        // Extract the phase (angle) from the complex value. 
            float3 phaseRadians = ComplexPhase(oplComplex);
            // Wrap the phase to [0, 2π) and normalize (optionally). 
            //float3 wrappedPhase = fmod(abs(phaseRadians), 2.0 * PI);
            //	 wrappedPhase = wrappedPhase < 0 ? wrappedPhase + 2.0 * PI : wrappedPhase;
            // Ensure positive
            // Normalize phase to [0, 1]
            // float3 normalizedPhase = wrappedPhase / (2.0 * PI); 
            // Accumulate the contributions.
	        C3 oplPhase = CV0(phaseRadians);
	        // Compute diffraction and apply weights 
            float weight2 = ComputeDiffractionWeight(i, j, (float) halfKernel * 1.5);
	 
            // 2. Fresnel phase.
            C3 fresnelPhase2 = ComputeFresnelPhase(CVV(saturate(mat.metallicReflectance * FresnelReflectance)),
             viewDir2, normal);
            if (TanhFactorR > 0)
            {
                fresnelPhase2 = CSub(C0V(1.0), fresnelPhase2);
            }
            



            fresnelPhase2 = CMul(fresnelPhase2, CV0(fresnelFactor));

            // 4. Fast offset phase.
           C3 fastOffset2 = CAdd(CMul(CV0(offsetScalarR),CMul(CAdd(CVV(uv2.x-0.5), CCos(CV0(time))),CV0(offsetScalarI))), CV0(0.5));

            C3 localCurvature = CV0(ComputeCurvature(depthMap, GetOosz(depthMap), uv2, invertDepth, useProjectedDepth));

            // 3. Curvature phase.
            C3 curvaturePhase2 = CMul(CMul(CV0(2.0*PI+CosineFactorR),localCurvature), curvatureFactor);
            oplPhase = CMul(CAdd(oplPhase, CMul(localCurvature, CV0(CosineFactorG))), CV0(oplFactor));

            C3 oplOffset = CMul(localCurvature, CV0(CosineFactorB)); // Tuning factor for OPL offset
            C3 modifiedOPL = CAdd(oplPhase, oplOffset);


            // Optionally, add a small spatial noise offset.
            float3 noiseOffset = noise2D(noiseMap, uvN);
            C3 noisePhaseOffset = CMul(CVV(noiseOffset), CVV(0.02)); // Small modulation

            // Combine the curvature phase with the noise offset.
            C3 modifiedCurvature = CAdd(curvaturePhase2, noisePhaseOffset);


    
	        C3 v1 = CAdd(modifiedOPL, CMul(CAdd(CV0(noiseOffset), CDot(normal, viewDir2)), CV0(0.01)));
	        C3 v2 = fresnelPhase2;
	        C3 v3 = modifiedCurvature;

            // Combine phase contributions.
            C3 totalPhase2 = CDiv(CAdd(CAdd(v1, v2),v3), CV0(3.0*PhaseOffsetB));


            // Optionally apply a final phase modulation.
            C3 finalPhase = ComplexPhaseModulation(totalPhase2, sin(time * PhaseOffsetR) * 0.2 * PhaseOffsetG);


            //C3 totalPhase2 = albedo;
            C3 phaseSample2 = finalPhase;
    


            // Example: accumulate the phase contribution.
            // accum = CAdd(accum, oplPhase2);
            // weightSum = CAdd(weightSum, CV0(1.0));


            if (i == 0 && j == 0)
            {
                // Accumulate weighted contributions.
                //accum = CAdd(accum, CMul(albedo, CMul(phaseSample2, CV0(centralWeight))));
              //  weightSum = CAdd(weightSum, CV0(centralWeight));
            }
            else
            {
                // Compute diffraction weight.
                float weight2 = ComputeDiffractionWeight(i, j, (float) halfKernel * 1.5);
            
                // Accumulate weighted contributions.
                accum = CAdd(accum, CMul(CMul(albedo,  phaseSample2), CV0(weight2)));
                weightSum = CAdd(weightSum, CV0(weight2));
            }
        }
    }
}




//------------------------------------------------------------------------------
// InterferenceHolographic_Modular: Main interference function using modular phase contributions
//------------------------------------------------------------------------------
C3 InterferenceHolographic_Modular(
    Texture2D<float3> noiseMap,
    Texture2D<float> depthMap,
    Texture2D<float4> diffuseMap,
    float2 uv,
    float2 deltaUV,
    bool invertDepth,
    bool useProjectedDepth,
    C3 lightPos,
    C3 viewPos,
    float depthScale,
    float time,
    bool xrayMode,
    float centralWeight, // Scalar weight for central contribution
    float offsetScalarI,
    float offsetScalarR,
    float offsetDepth,
    MaterialSellmeier mat,
    float angularFrequencyScalar,
    float fresnelReflectance,
    float fresnelPower, float fresnelFactor,
    C3 curvatureFactor, float oplFactor, C3 normal)
{
   
    C3 accum = C00;
    C3 weightSum = C00;
    float2 oosz = GetOosz(depthMap);
    float2 ooszD = GetOosz(diffuseMap);
    C3 depth = CAdd(CV0(offsetDepth), CV0(depth2D(depthMap, uv+deltaUV, invertDepth, useProjectedDepth)));

    float3 pixelPos = float3(uv + deltaUV, depth.real.z + offsetDepth);
    C3 normal2;
    Complex3x3 tbn = CalcTBN3(depthMap, uv + deltaUV, invertDepth, useProjectedDepth, normal2);


    AccumulateInterference(noiseMap, depthMap, diffuseMap, pixelPos.xy,
        invertDepth, useProjectedDepth, time, xrayMode, offsetScalarI, offsetScalarR, offsetDepth,
        centralWeight, fresnelFactor, angularFrequencyScalar, mat, tbn, viewPos, curvatureFactor, oplFactor, normal2,
        accum, weightSum);
    
    C3 finalPhase = CDiv(accum, weightSum);
    float3 viewDir = normalize(viewPos.real - pixelPos);
    float3 lightDir = normalize(lightPos.real - pixelPos);
    return CV0(finalPhase.real*max(0, dot(normalize(viewPos.real - pixelPos),normal2.real))*max(0, dot(viewDir,-normalize(viewDir + lightDir))));
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

C3 InterferenceThinFilmComplex(float2 inputUV, float time, float3 wavelengthsM, float3 thicknessM, float3 eta, float3 cosTheta, float3 nSurrounding)
{
    float3 R = (eta - nSurrounding) / (eta + nSurrounding); // Reflection coefficient (simplified)
    
    float3 phaseDiff = PhaseDifference(CV0(wavelengthsM), CV0(thicknessM), eta, cosTheta).real;
    float3 amplitude = sqrt(R * R + (1.0 - R) * (1.0 - R) + 2.0 * R * (1.0 - R) * cos(phaseDiff));
    float3 phase = atan2(-R * sin(phaseDiff), 1.0 - R * cos(phaseDiff));

    return CV(amplitude * cos(phase), amplitude * sin(phase));
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
    float3 interferenceColor = Interference(uv, beamCenter, beamWaist, hologramDepth, hologramScale) * nmToM(CV0(depthVal)).real;

    float2 centeredUV = (uv - beamCenter) * 2.0;
    float r = length(nmToM(CV0(length(centeredUV))).real);
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
    float2 uv,
    float3 viewDir,
    float3 normal,
    float3 baseColor,
    float thicknessM,
    MaterialSellmeier coeffs,
    float3 iorMedium)
{
    float time = AnimateTime;
    float3 V = normalize(viewDir + EPSILON3);
    float3 N = normalize(normal + EPSILON3);
    float3 baseColorWavelengthsNM = RGBToWavelengthsNM(CMag(CV0(baseColor))).real;

    float3 iorFilm = CMag(RefractiveIndexFromSellmeier(CV0(baseColorWavelengthsNM), true, coeffs)).real;
    
    float3 cI = saturate(dot3(N, V));
    float3 sI = sqrt(max(ONE3 - cI * cI, EPSILON3));

    float3 ratio = iorMedium / max(iorFilm, EPSILON3);
    float3 sT = ratio * sI;

    // TIR mask
    float3 TIRMask = step(0, sT);
    sT = min(sT, ONE3 - EPSILON3);
    float3 cT = sqrt(ONE3 - sT * sT);

    float3 OPD = TWO3 * iorFilm * thicknessM * cT;
    float3 delta = (TWO3 * PI3 * OPD) / nmToM(CV0(baseColorWavelengthsNM)).real;

    // Phase shifts
    // Using step to determine sign:
    float3 phaseShift0 = PI3 * step(iorFilm, iorMedium);
    float3 phaseShift1 = PI3 * step(iorMedium, iorFilm);

    float3 totalPhase = delta + phaseShift0 + phaseShift1;

    float3 cosThetaTR0;
    float3 R0 = 1 - FresnelReflectanceFromFilm2(iorMedium, iorFilm, cI, cosThetaTR0);

    float3 cosThetaTR1;
    float3 R1 = 1 - FresnelReflectanceFromFilm2(iorFilm, iorMedium, cT, cosThetaTR1);
    
    float3 interference = TWO3 * sqrt(R0 * R1) * cos(totalPhase + cosThetaTR0);

    float3 reflectance = R0 + R1 + interference;
    reflectance = lerp(reflectance, R0, TIRMask);

    reflectance = saturate(reflectance);

    float3 iridescentColor = baseColor * (1.0 - reflectance);
       
    return iridescentColor;
}

// Post-Processing Shader Function for Holographic Interference
float3 InterferenceHolographic1(float2 uv, float time, float3 colorA, float3 colorB, float frequency, float amplitude, float phaseOffset)
{
    // Calculate the center of the screen for radial patterns
    float2 centerM = nmToM(CV0(float3(float2(0.5, 0.5), 0))).real.xy;
    
    // Compute the distance from the current pixel to the center
    float dist = distance(nmToM(CV0(float3(uv,0))).real.xy, float3(centerM, 0).xy);
    
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

C3 Fresnel4h(
    float2 uv,
    float time,
    C3 baseColor,
    float3 viewDir,
    float3 normal,
    float filmThicknessM,
    float fresnelPower,
    float3 fresnelReflectance,
    float3 outsideRefractiveIndices,
    float3 refractiveIndices,
    float3 dispersionCoefficient)
{
    //--------------------------------------------------------------------------
    // 1. Setup: Compute the incident cosine from view direction.
    //--------------------------------------------------------------------------
    half3 N = half3(safeNormalizef(normal));
    half3 V = half3(safeNormalizef(viewDir));
    half NdotV = max(dot(N, V), half(EPSILON));
    half3 cI = half3(NdotV, NdotV, NdotV);

    //--------------------------------------------------------------------------
    // 2. Compute Wavelengths with Dispersion & Noise
    //--------------------------------------------------------------------------
    C3 baseRGB = CSat(baseColor);
    // Convert the base RGB to wavelengths (in nm) and add a slight noise variation.
    C3 wl = CAdd(RGBToWavelengthsNM(baseRGB),
               CMul(C10, RGB_WAVELENGTHS_M));
    // Convert wavelengths from nm to meters.
    C3 wavelengthsM = nmToM(wl);

    //--------------------------------------------------------------------------
    // 3. Evaluate Refractive Indices with Dispersion
    //--------------------------------------------------------------------------
    half3 A = half3(refractiveIndices);
    half3 B = half3(dispersionCoefficient);
    half3 n1 = half3(ClampRefractiveIndex(CV0(outsideRefractiveIndices)).real);
    C3 n2 = ClampRefractiveIndex(ComplexLerp(CV0(refractiveIndices), RefractiveIndexFromAB3(mToNm(wavelengthsM), CV0(A), CV0(B)), CV0(0.75)));

    //--------------------------------------------------------------------------
    // 4. Fresnel Reflectance (Real Domain)
    //--------------------------------------------------------------------------
    C3 cT;
    C3 R = FresnelReflectanceFromFilmC2(n1, n2, cI, cT);
    // Clamp the transmitted component as needed.
    //half3 cT_clamped = clamp(CAbs(cT), -OneMinusEPSILON3h, OneMinusEPSILON3h);

    //--------------------------------------------------------------------------
    // 5. Thin Film Interference in the Complex Domain
    //--------------------------------------------------------------------------
    // Wrap the wavelengths into C3 (with zero imaginary part).
    C3 cWavelengths = wavelengthsM;
    // Wrap film thickness and refractive index n2 as C3 values.
    C3 cFilmThickness = CV0(filmThicknessM);
 
    // Compute the phase due to the optical path difference in the film.
    // For reflected light, a common thin film phase is: phase = 4π * n2 * filmThickness / wavelength.
    C3 cNumerator = CMul(CMul(n2, cFilmThickness), CV0(4.0 * 3.14159265));
    C3 cPhase = CDiv(cNumerator, cWavelengths);
    // Add a time‐dependent phase modulation (which can also simulate dynamic changes).
    C3 cTimePhase = CMul(CV0(time), CV0(4.0 * 3.14159265));
    C3 cTotalPhase = CAdd(cPhase, cTimePhase);
    // Compute the complex interference term as the exponential of the total phase.
    C3 interference = CExp(cTotalPhase);

    //--------------------------------------------------------------------------
    // 6. Combine Fresnel Reflectance with Interference using Complex Arithmetic
    //--------------------------------------------------------------------------
    
    // Multiply the Fresnel term with the interference term.
    C3 cCombined = CMul(R, interference);
    // Scale by fresnelPower.
    cCombined = ComplexMulScalar(cCombined, fresnelPower);

    // Optionally blend with the provided artist-controlled fresnelReflectance.
    C3 cFres = CMul(R, CV0(fresnelReflectance));
    // Here we use a linear blend with a 50% weight. (Adjust as needed or use a different blend.)
    C3 cReflectance = ComplexLerp(cCombined, cFres, CV0(max(0.0, dot(viewDir, normal))));

    return CMul(baseColor, cReflectance);
}

inline C3 Fresnel4(float2 uv, float time, C3 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance, float3 outsideRefractiveIndices = ONE3, float3 refractiveIndices = float3(1.5, 1.5, 1.5), float3 dispersionCoefficient = float3(0.005, 0.006, 0.007))
{
    return Fresnel4h(uv, time, baseColor, viewDir, normal, filmThicknessM, fresnelPower, fresnelReflectance, outsideRefractiveIndices, refractiveIndices, dispersionCoefficient);
}


inline C3 Fresnel3(float2 uv, float time, C3 baseColor, float3 viewDir, float3 normal, float filmThicknessM, float fresnelPower, float3 fresnelReflectance, float3 outsideRefractiveIndices, float3 refractiveIndices, float3 dispersionCoefficient)
{
    return Fresnel4h(uv, time, baseColor, viewDir, normal, filmThicknessM, fresnelPower, fresnelReflectance, outsideRefractiveIndices, refractiveIndices, dispersionCoefficient);
}


inline C3 InterferenceWavefront(float2 uv, float time, float3 viewDir, float3 position, float3 normal, float3 lightDir, C3 wavelengthsNM, MaterialSellmeier material, bool isOrdinary)
{
    float3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, isOrdinary, material).real;
    float3 rd = refract3(-lightDir, normal, refractiveIndex);

    C3 baseColor = CV0(diffuse2D(diffuseMap, position.xy).xyz); // Ensure diffuseMap etc. are defined
    C3 reflectance = Fresnel3(uv, time, baseColor, viewDir, normal, length(material.thicknessM.real), FresnelPower, FresnelReflectance, ONE3, refractiveIndex, material.scatteringCoefficient);

    C3 phase = CV0(saturate(dot(position, rd) * TWOPI3 / max(wavelengthsNM.real, EPSILON3)));
    C3 interference = CMul(CSin(phase), reflectance);

    return interference;
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
    float sigma, bool invertDepth, bool useProjectedDepth)
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
    float centerDepth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    
    // Initialize accumulators for color and total weight
    float4 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each horizontal sample
    for (int i = 0; i < 4; i++)
    {
        // Left sample
        float2 sampleUVLeft = uv + offsets[i];
        float4 sampleColorLeft = diffuse2D(diffuseMap, sampleUVLeft);
        float sampleDepthLeft = depth2D(depthMap, sampleUVLeft, invertDepth, useProjectedDepth);
        
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
        float sampleDepthRight = depth2D(depthMap, sampleUVRight, invertDepth, useProjectedDepth);
        
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
    float sigma, bool invertDepth, bool useProjectedDepth)
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
    float centerDepth = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    
    // Initialize accumulators for color and total weight
    float4 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each vertical sample
    for (int i = 0; i < 4; i++)
    {
        // Up sample
        float2 sampleUVUp = uv + offsets[i];
        float4 sampleColorUp = diffuse2D(diffuseMap, sampleUVUp);
        float sampleDepthUp = depth2D(depthMap, sampleUVUp, invertDepth, useProjectedDepth);
        
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
        float sampleDepthDown = depth2D(depthMap, sampleUVDown, invertDepth, useProjectedDepth);
        
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
    float sigma, bool invertDepth, bool useProjectedDepth)
{
    // First pass: Horizontal blur
    float4 horizontalBlur = GaussianBlurHorizontal(diffuseMap, depthMap, uv, range, sigma, invertDepth, useProjectedDepth);
    
    // Assuming horizontalBlur is written to an intermediate texture,
    // perform the vertical blur by sampling from that intermediate texture.
    // For illustration, we'll reuse the same diffuseMap.
    // In practice, you should use a separate texture for the intermediate result.
    
    float4 finalBlur = GaussianBlurVertical( /* intermediateDiffuseMap */diffuseMap, depthMap, uv, range, sigma, invertDepth, useProjectedDepth);
    
    return finalBlur;
}

// Modified SampleAvg function with Gaussian kernel and depth-based weighting
inline float4 SampleAvg(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range, bool invertDepth, bool useProjectedDepth)
{
    return FullGaussianBlur(diffuseMap, depthMap, uv, range, 1.0, invertDepth, useProjectedDepth);

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

C3 WavelengthsToRGB(C3 wavelengthsNM)
{
    return CSat(CDiv(CMax(CEPSILON3, CSub(ComplexClamp(wavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS), CV0(MIN_WAVELENGTHS))), CV0(WAVELENGTH_RANGES)));
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
float3 DiffractionPattern(C3 wavelengthNM, float gratingSpacingNM, float3 angle)
{
    float3 k = (TWOPI3 / nmToMf(wavelengthNM.real)) * angle;
    return sin(k * gratingSpacingNM) / (k * gratingSpacingNM);
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

float3 clampWavelengthsNM(C3 wavelengthsNM)
{
    return float3(
		lerp(0.0, clamp(wavelengthsNM.real.x, MIN_WAVELENGTHS.x, MAX_WAVELENGTHS.x), step(0.0, wavelengthsNM.real.x)),
        lerp(0.0, clamp(wavelengthsNM.real.y, MIN_WAVELENGTHS.y, MAX_WAVELENGTHS.y), step(0.0, wavelengthsNM.real.y)),
        lerp(0.0, clamp(wavelengthsNM.real.z, MIN_WAVELENGTHS.z, MAX_WAVELENGTHS.z), step(0.0, wavelengthsNM.real.z)));
}


inline C3 LinearRGBToSRGB2(float3 linearRGB)
{
    linearRGB = clamp(linearRGB, EPSILON3, OneMinusEPSILON3);
    float3 ret = float3(
        lerp(12.92 * linearRGB.r, 1.055 * pow(max(EPSILON, linearRGB.r), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.r)),
        lerp(12.92 * linearRGB.g, 1.055 * pow(max(EPSILON, linearRGB.g), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.g)),
        lerp(12.92 * linearRGB.b, 1.055 * pow(max(EPSILON, linearRGB.b), 1.0 / 2.4) - 0.055, step(0.0031308, linearRGB.b)));
    return AdjustGamma(CV0(ret));
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
    float intensity = 1.0 - sin(uv.y * density * AnimateTime * 2.0 * 3.14159) * thickness;
    return intensity;
}

// 5. Film Grain (Noisy Texture)
inline float ppFilmGrain(float2 uv, float strength)
{
    return frac(sin(AnimateTime + uv.x * 100.0 + uv.y * 1000.0) * 43758.5453) * strength;
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
    float time = AnimateTime * speed; // Time-based animation (adjust speed)
    float animatedStrength = strength * (1.0 + sin(time) * 0.2); // Oscillating strength
    return ppLensDistort(uv, animatedStrength, radius, invertDepth, useProjectedDepth);
}


// 3. Vignette Helper
inline float ppVignetteUV(float2 uv, float amount, float softness, float speed = 0.5)
{
    float time = AnimateTime * speed;
    float animatedAmount = amount * (1.0 + sin(time) * 0.1);
    return ppVignette(uv, animatedAmount, softness);
}

// 4. Scanlines Helper
inline float ppScanlinesUV(float2 uv, float density, float thickness, float speed = 2.0)
{
    return ppScanlines(uv, density, thickness * (1.0 + sin(AnimateTime * speed) * 0.2));
}

// 5. Film Grain Helper
inline float ppFilmGrainUV(float2 uv, float strength, float speed = 0.8)
{
    return ppFilmGrain(uv, strength * (1.0 + cos(AnimateTime * speed) * 0.1));
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
    float animatedLevels = levels * (1.0 + sin(AnimateTime * speed) * 0.1);
    return ppPosterize(color, animatedLevels);
}

// 8. Swirl Helper
inline float2 ppSwirlUV(float2 uv, float angle, float speed = 1.0)
{
    float time = AnimateTime * speed;
    float animatedAngle = angle * (1.0 + sin(time) * 0.3); // More pronounced swirl animation
    return ppSwirl(uv, animatedAngle);
}

// 9. Color Tint Helper
inline float3 ppColorTintUV(float3 color, float3 tint, float speed = 0.2)
{
    float3 animatedTint = tint * (1.0 + sin(AnimateTime * speed) * 0.1);
    return ppColorTint(color, animatedTint);
}

// 10. Bloom Helper
inline float ppBloomUV(float value, float threshold, float intensity, float speed = 0.5)
{
    float animatedIntensity = intensity * (1.0 + cos(AnimateTime * speed) * 0.2);
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
    C3 wavelengthsNM,
    float3 baseRadius,
    float3 minBlurRadius = float3(0.0015, 0.0015, 0.0015),
    float3 maxBlurRadius = float3(0.025, 0.025, 0.025),
    float3 scalingFactors = float3(0.170, 0.140, 0.120)
)
{
    // Calculate scaling factors based on wavelength and reference wavelengths
    float3 scaling = scalingFactors * clamp((wavelengthsNM.real - MIN_WAVELENGTHS) / RGB_WAVELENGTHS_NM, EPSILON, OneMinusEPSILON3);
    
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
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);
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
    C3 wavelengthsNM,
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
    
    float3 ior = RefractiveIndexFromDispersionCoefficients(RGBToWavelengthsNM(CV0(iridescentColor)), mat.dispersionCoefficientsNm2[dispersionIndex]).real;
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(ior, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, normal), cosThetaT);
    
    OpticalPathResult opd =
        OpticalPathDifference(
            RGBToWavelengthsNM(CV0(diffuse2D(diffuseMap, inputUV).rgb)), float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
            DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixel), mToNm(mat.thicknessM), CalcNormal(depthMap, offsetG.xy, invertDepth, NormalRadius)),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient, cosThetaT);
    
    // Placeholder rotateHue function:
    float3 rotatedIridescence = iridescentColor;
    // If rotateHue is available, use:
    rotatedIridescence = rotateHue(iridescentColor, mToNmf(opd.opticalMeasurement.PathDifferenceM));

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
    float3 V = safeNormalizef(viewDir);
    float3 N = safeNormalizef(normal);
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
    float phaseShift = PhaseShiftM_Single(nmToMf(wavelengthNM).x, thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}

inline float IridescenceG(
    float albedo,
    float thicknessM,
    float ior)
{
    float wavelengthNM = max(RGBToWavelengthG(albedo), EPSILON);
    float phaseShift = PhaseShiftM_Single(nmToMf(wavelengthNM).x, thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}

inline float IridescenceB(
    float albedo,
    float thicknessM,
    float ior)
{
    float wavelengthNM = max(RGBToWavelengthB(albedo), EPSILON);
    float phaseShift = PhaseShiftM_Single(nmToMf(wavelengthNM).x, thicknessM, ior);
    return saturate(albedo * (0.5 + 0.5 * cos(phaseShift)));
}


inline float3 Iridescence(
    float3 albedo,
    float thicknessM,
    float3 ior)
{
    C3 wavelengthsNM = CMax(RGBToWavelengthsNM(CV0(albedo)), CEPSILON3);
    float3 phaseShift = PhaseShiftM(nmToM(wavelengthsNM).real, thicknessM * (1.0 + PassNum), ior);
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
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);
    
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
C3 AdvancedSeparableSSS(
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
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);

    // Extinction coefficients
    float3 us = scatteringCoeff;
    float3 ua = absorptionCoeff;
    float3 ut = us + ua;
    
    float3 attenuation = exp(-ut * scatteringRadius);
    float3 diffuseLighting = (albedo / PI) * NdotL;

    // Henyey-Greenstein phase function:
    float3 direction = reflect(lightDir, normal);
    float3 scatteringDir = safeNormalizef(direction + viewDir);
    float cosTheta = abs(dot(normal, scatteringDir));
    float phase = HGPhaseFunction(cosTheta, g);

    float3 SSS = diffuseLighting * us * phase * attenuation;
    return CV0(saturate(SSS));
}
float3 MieScattering(float3 viewDir, float3 lightDir, float3 wavelength, float g, float scale, float3 intensity)
{
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);

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

C3 CombinedHolographicShading(
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
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);

    // Compute NdotL and NdotV
    float NdotL = saturate(dot(normal, lightDir));
    float NdotV = saturate(dot(normal, viewDir));

    // Wavelength-based computations:
    // Suppose we can derive wavelengths from initialColor or have a known wavelength triple
    C3 wavelengthsNM = CV0(RGBToWavelengthsNMf(initialColor));
    wavelengthsNM = CMax(wavelengthsNM, CEPSILON3);

    // Compute Fresnel reflectance: Using Fresnel3 or a similar function (no if)
    C3 fresnelReflectance = Fresnel3(inputUV, time, CV0(float3(mat.metallic, mat.metallic, mat.metallic)), viewDir, normal, length(mat.thicknessM.real), FresnelPower, FresnelReflectance, mat.nSurrounding, mat.etaR, 1.0 - mat.absorptionCoefficient);
    fresnelReflectance = CSat(fresnelReflectance);

    // Compute advanced SSS
    C3 SSS = CAdd(AdvancedSeparableSSS(normal, viewDir, lightDir, NdotL, initialColor, scatteringCoeff, absorptionCoeff, g, scatteringRadius), fresnelReflectance);

    // Combine initial color with SSS and Fresnel
    C3 combinedColor = CAdd(CV0(initialColor), CAdd(ComplexSub(C10, fresnelReflectance), SSS));

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
    combinedColor = CMul(combinedColor, CV0(adjustedIntensity));

    // Apply wavelength-dependent Gaussian blur:
    float3 blurRadius = WavelengthDependentBlurRadius(wavelengthsNM, 25.0 * (1.0 - depth / DepthScale));
    float3 blurredColor = GaussianBlurWavelengthDependent(diffuseMap, inputUV, blurRadius);

    // Blend combinedColor with blurredColor for a bloom-like effect
    float bloomMask = step(0.7, CDot(combinedColor, CV0(float3(0.2126, 0.7152, 0.0722))).real.x); // brightness threshold
    C3 bloomColor = CMul(ComplexLerp(combinedColor, CV0(blurredColor), CV0(saturate(0.3))), CV0(bloomMask));
    
    
    combinedColor = CAdd(combinedColor, CMul(CMul(bloomColor, CV0(bloomMask)), CV0(0.5)));

    // Add highlights if wavelength≥650 nm on average
    float avgW = (wavelengthsNM.real.x + wavelengthsNM.real.y + wavelengthsNM.real.z) / 3.0;
    float highlightMask = step(650.0, avgW);
    combinedColor = CAdd(combinedColor, CV0(highlightMask * ONE3 * highlight * 0.3));

    // Apply hue shift, saturation, gamma:
  //  combinedColor = rotateHue(combinedColor, fmod(hueShift, 360.0));
   // combinedColor = AdjustSaturation(combinedColor, saturation);
    combinedColor = AdjustGamma(combinedColor, gamma);

    // Add subtle noise:
    //combinedColor += noiseFast2D_01(uvForNoise * 100.0) * 0.02;

    // Apply chromatic aberration:
    // For simplicity, shift red and blue channels horizontally
    
    // Example simple approach:
    // shift red channel right, blue channel left based on chromaticAberrationStrength
    float2 oosz = GetOosz(diffuseMap);
    float2 shiftAmount = oosz * chromaticAberrationStrength * 2.0; // 2.0 chosen arbitrarily
    float4 cR = diffuse2D(diffuseMap, inputUV + float2(shiftAmount.x, 0.0));
    float4 cG = diffuse2D(diffuseMap, inputUV);
    float4 cB = diffuse2D(diffuseMap, inputUV - float2(shiftAmount.x, 0.0));

    // Combine channels
    C3 caColor = CV0(float3(cR.r, cG.g, cB.b));
    // Lerp combinedColor and caColor
    combinedColor = ComplexLerp(combinedColor, caColor, CV0(ONE3*0.5));

    // Ensure final result is clamped
    return CSat(combinedColor);
}


static const float kernelR[7] = { 0.220, 0.100, 0.130, 0.115, 0.085, 0.040, 0.010 };
static const float kernelG[7] = { 0.233, 0.100, 0.118, 0.113, 0.082, 0.042, 0.009 };
static const float kernelB[7] = { 0.250, 0.110, 0.125, 0.120, 0.090, 0.050, 0.015 };


C3 PS_SSS_Vertical(
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
    //float3 N = normal2DPoint11W(normalMap, normalUV);
    float3 N = (CV0(CalcNormal2(depthMap, normalUV, float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2))).real;
    
    float depth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    // Compute center reference for distance-based adjustments
    float3 center = float3(0.5, 0.5, depth2D(depthMap, float2(0.5, 0.5), invertDepth, useProjectedDepth));
    float3 currentPixelPos = float3(depthUV, depth);
    float centerDist = distance(center, currentPixelPos);
    C3 c = CV0(float3(mat.metallic, mat.metallic, mat.metallic));
    C3 fresnelTerm = Fresnel3(inputUV, time,
        c,
        viewDir,
        N,
        length(mat.thicknessM.real),
        FresnelPower,
        FresnelReflectance * ONE3,
        mat.nSurrounding * ONE3,
        mat.etaR,
        1.0 - mat.dispersionCoefficientsNm2[0]
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

        float3 normalPlus = safeNormalize((CV0(CalcNormal2(depthMap, normalUV + float2(0.0, offsetNormal), float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2)))).real;
        float3 normalMinus = safeNormalize((CV0(CalcNormal2(depthMap, normalUV - float2(0.0, offsetNormal), float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2)))).real;

        // Compute blendFactor for samples based on depth
        float blendFactorPos = 0.75;
        float blendFactorNeg = blendFactorPos; // symmetrical

        float NdotLP = dot(normalPlus, N);
        float NdotLM = dot(normalMinus, N);
        
        // Accumulate weighted samples
        color.r += ((diffusePlus.r * NdotLP + diffuseMinus.r * NdotLM + CAbs(fresnelTerm).real.r)) * kernelR[i];
        color.g += ((diffusePlus.g * NdotLP + diffuseMinus.g * NdotLM + CAbs(fresnelTerm).real.g)) * kernelG[i];
        color.b += ((diffusePlus.b * NdotLP + diffuseMinus.b * NdotLM + CAbs(fresnelTerm).real.b)) * kernelB[i];

    }


    // Clamp final color
    return CMul(CSat(CV0(color)), fresnelTerm);
}


C3 PS_SSS_Horizontal(
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
    //float3 N = normal2DPoint11W(normalMap, normalUV);
    float3 N = CalcNormal2(depthMap, normalUV, float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2);
   
    float depth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);

    // Compute center reference for distance-based adjustments
    float3 center = float3(0.5, 0.5, depth2D(depthMap, float2(0.5, 0.5), invertDepth, useProjectedDepth));
    float3 currentPixelPos = float3(depthUV, depth);
    float centerDist = distance(center, currentPixelPos);
    
    C3 fresnelTerm = Fresnel3(inputUV, time,
        CV0(float3(mat.metallic, mat.metallic, mat.metallic)),
        viewDir,
        N,
        length(mat.thicknessM.real),
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
        float offsetDiffuse = float(i) * ooszDiffuse.x;
        float offsetNormal = float(i) * ooszNormal.x;
        float offsetDepth = float(i) * ooszDepth.x; // if needed

        // Samples above and below
        float2 uvPlus = diffuseUV + float2(offsetDiffuse, 0.0);
        float2 uvMinus = diffuseUV - float2(offsetDiffuse, 0.0);

        float3 diffusePlus = diffuse2D(diffuseMap, uvPlus).xyz;
        float3 diffuseMinus = diffuse2D(diffuseMap, uvMinus).xyz;

        float3 normalPlus = safeNormalizef((CalcNormal2(depthMap, normalUV + float2(offsetNormal, 0.0), float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2)));
        float3 normalMinus = safeNormalizef((CalcNormal2(depthMap, normalUV - float2(offsetNormal, 0.0), float3(ViewX, ViewY, ViewZ), invertDepth, useProjectedDepth, 2)));

        // Compute blendFactor for samples based on depth
        float blendFactorPos = 0.75;
        float blendFactorNeg = blendFactorPos; // symmetrical

        float NdotLP = dot(normalPlus, N);
        float NdotLM = dot(normalMinus, N);
        
        // Accumulate weighted samples
        color.r += ((diffusePlus.r * NdotLP + diffuseMinus.r * NdotLM + CAbs(fresnelTerm).real.r)) * kernelR[i];
        color.g += ((diffusePlus.g * NdotLP + diffuseMinus.g * NdotLM + CAbs(fresnelTerm).real.g)) * kernelG[i];
        color.b += ((diffusePlus.b * NdotLP + diffuseMinus.b * NdotLM + CAbs(fresnelTerm).real.b)) * kernelB[i];

    }

    // Clamp final color
    return CMul(CSat(CV0(color)), fresnelTerm);
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
    
    float2 uvR = float2(uv + oosz * float2(float(max(1, radius)), 0.0));
    float2 uvL = float2(uv - oosz * float2(float(max(1, radius)), 0.0));

    float3 pixelC = float3(uv, depth2D(depthMap, uv, invertDepth, useProjectedDepth));
    float3 pixelR = float3(uvR, depth2D(depthMap, uvR, invertDepth, useProjectedDepth));
    float3 pixelL = float3(uvL, depth2D(depthMap, uvL, invertDepth, useProjectedDepth));
    
    float3 diffuseC = diffuse2D(diffuseMap, uv).rgb;
    float3 diffuseR = diffuse2D(diffuseMap, uvR).rgb;
    float3 diffuseL = diffuse2D(diffuseMap, uvL).rgb;

    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float3 sunPos = float3(SunX, SunY, SunZ);
    
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(diffuse));
    PathMeasurement mR = DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixelR), CV0(0.002), particleNormal);
    PathMeasurement mL = DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixelL), CV0(0.002), particleNormal);
    
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(mat.etaR, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, particleNormal), cosThetaT);
    
    
    OpticalPathResult opdR = OpticalPathDifference(wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
        mR, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaT);
    OpticalPathResult opdL = OpticalPathDifference(wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), mL, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, cosThetaT);
    
    float3 rbR = rainbowColor(length(mToNmf(opdR.opticalMeasurement.PathDifferenceM.x)));
    float3 rbL = rainbowColor(length(mToNmf(opdL.opticalMeasurement.PathDifferenceM.x)));

    float3 r = diffuseR.r * rbR;
    float3 g = diffuseC.g * diffuseC;
    float3 b = diffuseL.b * rbL;
    return (r + g + b) / 3.0;
}

C3 FresnelComplex(C3 ior, float3 normal, float3 lightDir)
{
    // Cosine of the incident angle
    float cosThetaI = saturate(dot(normal, lightDir));
    
    // Snell's law to calculate the transmitted angle (cosThetaT)
    C3 sinThetaT = CMul(ior, CV0(sqrt(1.0 - cosThetaI * cosThetaI)));
    C3 cosThetaT = ComplexSqrt(ComplexSub(C10, CMul(sinThetaT, sinThetaT)));
    
    // Parallel and Perpendicular Components
    C3 rParallel = CDiv(
        ComplexSub(CMul(ior, CV0(cosThetaI)), cosThetaT),
        CAdd(CMul(ior, CV0(cosThetaI)), cosThetaT)
    );

    C3 rPerpendicular = CDiv(
        ComplexSub(CV0(cosThetaI), cosThetaT),
        CAdd(CV0(cosThetaI), cosThetaT)
    );

    // Fresnel Reflectance (Average of Parallel and Perpendicular)
    return CMul(CV0(0.5 * ONE3), CAdd(CMul(rParallel, rParallel), CMul(rPerpendicular, rPerpendicular)));
}



inline C3 SpecularTransmission(
    float2 inputUV,
    float time,
    float3 eta_ratio, // Real part of the refractive index ratio (η)
    float3 k_ratio, // Imaginary part (absorption factor, k)
    float3 cosThetaT, // Cosine of the transmitted angle
    C3 wavelengthsNM, // Wavelengths in nanometers
    float3 thicknessM, // Film thickness (in meters)
    float depth, // Depth scaling factor (e.g. from a depth map)
    SellmeierCoefficientsBC filmEta_coeffs // (Unused here but available for further film-specific effects)
)
{
    // Calculate complex Fresnel reflectance. 
    // (Assuming FresnelComplex is defined to take: 
    //  (real index ratio, imaginary index ratio, FresnelPower, cosThetaT))
    C3 F = FresnelComplex(eta_ratio, k_ratio, 1.0f, cosThetaT);
    
    // Transmission (T) is simply 1 minus the Fresnel reflectance
    C3 T = ComplexSub(C11, F);
    
    // Compute absorption using a Beer-Lambert style law:
    // The factor 4.0 comes from the two-way path through the film.
    float3 absorption = exp(-4.0f * k_ratio * thicknessM * depth);
    
    // Compute interference from thin-film effects.
    // Convert wavelengths from nanometers to meters.
    C3 interference = InterferenceThinFilmComplex(inputUV, time, nmToM(wavelengthsNM).real, thicknessM, eta_ratio, cosThetaT, k_ratio);
    
    // Final specular transmission is the product of transmission,
    // absorption, and the interference modulation.
    C3 transmission = ComplexMulScalar(CMul(T, interference), absorption);
    
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
    float3 N = safeNormalizef(normal);
    float3 L = safeNormalizef(lightDir);
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
    float3 N = safeNormalizef(normal);
    float3 L = safeNormalizef(lightDir);
    float3 V = safeNormalizef(viewDir);
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
    C3 wavelengthsNM,
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
            nmToMf(wavelengthsNM.real),
            thinFilms[i].filmThicknessM.real,
            thinFilms[i].filmEta_coeffs.OE1.O.B,
            dot(normal, lightDir),
            surrounding);
        
        // Multiply with transmission
        transmission *= interference;
        surrounding = thinFilms[i].filmEta_coeffs.OE1.O.B;
    }

    return transmission;
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
    float3 D = safeNormalizef(direction);
    float3 normal = safeNormalizef(N);
    
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


inline float SmithGGXCorrelated(float NdotL, float NdotV, float roughness)
{
    // Clamp NdotL and NdotV to the valid range
    NdotL = saturate(NdotL);
    NdotV = saturate(NdotV);

    // Ensure roughness is non-zero
    roughness = max(roughness, EPSILON);
    float a2 = roughness * roughness;

    // GGX visibility functions for V and L
    float GGXV = NdotV * sqrt(max(NdotL * (NdotL * (1.0 - a2) + a2), EPSILON));
    float GGXL = NdotL * sqrt(max(NdotV * (NdotV * (1.0 - a2) + a2), EPSILON));

    // Return the correlated GGX visibility term
    return 2.0 * NdotL * NdotV / max(GGXV + GGXL, EPSILON); // Energy-conserving factor of 2
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
    // Normalize inputs safely
    N = safeNormalizef(N);
    L = safeNormalizef(L);
    V = safeNormalizef(V);

    // If any of the vectors are degenerate, return 0
    if (length(N) < EPSILON || length(L) < EPSILON || length(V) < EPSILON)
    {
        return 0.0;
    }

    // Compute dot products and clamp
    float NdotL = max(dot(N, L), EPSILON);
    float NdotV = max(dot(N, V), EPSILON);

    // Return the Smith GGX correlated geometry term
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
    thinFilms[0] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);
    thinFilms[1] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0( 0.0012), 0.01);
    thinFilms[2] = SELLMEIER_THIN_FILM_PROPERTY(1.75, CV0( 0.0102), 0.03);
    thinFilms[3] = SELLMEIER_THIN_FILM_PROPERTY(2.5, CV0(0.0006), 0.001);
    thinFilms[4] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);
    thinFilms[5] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0( 0.0012), 0.001);
    thinFilms[6] = SELLMEIER_THIN_FILM_PROPERTY(1.75, CV0( 0.0102), 0.03);
    thinFilms[7] = SELLMEIER_THIN_FILM_PROPERTY(2.5, CV0(0.0006), 0.001);
    thinFilms[8] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);
    thinFilms[9] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0( 0.0012), 0.001);
}

C3 FresnelMicrofacet(
    float2 inputUV, float time,
    float3 viewDirection,
    float3 lightDirection,
    float3 microfacetNormal,
    MaterialSellmeier mat,
    MaterialProperties material,
    AnisotropicRoughness roughness,
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS],
    int numThinFilms,
    
    float sssStrength, float3 scatteringCoefficient, float3 absorptionCoefficient,
    float3 dispersionCoefficient, float thicknessM, bool invertDepth, bool useProjectedDepth)
{
    float3 V = safeNormalizef(viewDirection);
    float3 L = safeNormalizef(lightDirection);
    float3 N = safeNormalizef(microfacetNormal);
    float3 H = safeNormalizef(V + L);

    float cosTheta = saturate(dot(N, V));

    float3 eta_i = mat.etaO; // Incoming
    float3 eta_t = mat.etaR; // Transmission

    float3 eta_ratio = eta_i / eta_t;
    float3 k_ratio = material.k / max(material.k, EPSILON3);

    float3 sinThetaT = eta_ratio * sqrt(1.0f - cosTheta * cosTheta);
    float3 TIR = step(1.0f, sinThetaT); // Total internal reflection flag

    C3 F = FresnelComplex(eta_ratio, k_ratio, cosTheta, sqrt(1.0f - sinThetaT * sinThetaT));
    C3 transmission = SpecularTransmission(
        inputUV, time, eta_ratio, k_ratio, sqrt(1.0f - sinThetaT * sinThetaT),
        material.wavelengthsNM, thicknessM, depth2D(depthMap, inputUV, invertDepth, useProjectedDepth), material.coeff);

    return CSat(CMul(transmission, CAdd(CV((1.0f - TIR), ZERO3), ComplexMulScalar(F, TIR))));
}

// ----------------------------------
// 1. Structures and Enumerations
// ----------------------------------



inline FilmLayer CreateFilmLayer(SellmeierCoefficientsBC coefficients, float3 thicknessM, float3 k)
{
    FilmLayer ret = (FilmLayer) 0;
    ret.coefficients = coefficients;
    ret.thicknessM = thicknessM;
    ret.k = k;
    return ret;
}



inline DiffractionOrder CreateDiffractionOrder(int order, float strength, float wavelengthFactor)
{
    DiffractionOrder ret = (DiffractionOrder) 0;
    ret.order = order;
    ret.strength = strength;
    ret.wavelengthFactor = wavelengthFactor;
    return ret;
}



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
    float3 N = safeNormalizef(n);
    float3 incident = safeNormalizef(I);
    float3 light = safeNormalizef(L);
    
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
        float3 n = RefractiveIndexFromCoefficients(mToNm(CV0(wavelengthM)), layers[i].coefficients);
        
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
    float3 H = safeNormalizef(V + L);
    
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
    float3 viewDir = safeNormalizef(viewPos - pixel);
    float2 shiftDirection = float2(viewDir.x, viewDir.y);
    
    // Calculate shift magnitude based on wavelength
    float shiftMagnitude = (wavelengthM - nmToMf(centerWavelengthNM).x) * strength; // Reference wavelength = 550nm
    
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
    float3 H = safeNormalizef(V + L);
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
            float3 normal = CalcNormal(depthMap, inputUV + offset, invertDepth, NormalRadius);
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


MaterialProperties MaterialPropertiesFromMaterialSellmeier(MaterialSellmeier mat)
{
    MaterialProperties material = (MaterialProperties) 0;
    material.coeff.B = mat.coeff.OE1.O.B;
    material.coeff.B = mat.coeff.OE1.O.C;
    material.k = mat.nSurrounding;
    material.thicknessM = length(mat.thicknessM.real);
    material.absorptionM = mat.absorptionCoefficient;
    material.wavelengthsNM = RGBToWavelengthsNM(CV0(mat.albedo));
    material.transmissionCoefficient = mat.metallic;
    return material;
}

C3 MicrofacetBRDF1(
    C3 diffuseColor,
    C3 sssColor,
    MaterialSellmeier mat,
    float2 inputUV, float time,
    float3 materialSpecularColor,
    float3 normal,
    float3 viewDir,
    float3 lightDir,
    bool invertDepth, bool useProjectedDepth,
    float3 outsideRefractiveIndex,
    C3 materialRefractiveIndex,
    float thicknessNM = 20.0,
    float3 dispersionCoefficient = float3(0.005, 0.006, 0.007),
    float3 absorptionIncomingM = ZERO3,
    float roughnessX = 0.1,
    float roughnessY = 0.001,
    int dispersionIndex = 0,
    float sssStrength = 0.5f
)
{
    // Validate roughness
    AnisotropicRoughness roughness;
    roughness.alphaX = max(roughnessX, 0.001f); // Prevent zero roughness
    roughness.alphaY = max(roughnessY, 0.001f);

    // Compute Half-Vector
    float3 H = safeNormalizef(viewDir + lightDir);

    // GGX Distribution
    float ggxDistribution = DistributionGGX(dot(normal, H), roughness.alphaX * roughness.alphaY);
    //ggxDistribution = MicrofacetDist_Beckmann(roughness.alphaX, abs(dot(normal, H)));

    // Fresnel Term
    MaterialProperties material = MaterialPropertiesFromMaterialSellmeier(mat);

    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];
    CreateThinFilms(thinFilms);

    C3 fresnelTerm = FresnelMicrofacet(
        inputUV, time, viewDir, lightDir, normal, mat, material, roughness, thinFilms, MAX_GRATING_LAYERS,
        sssStrength, mat.scatteringCoefficient, mat.absorptionCoefficient,
        mat.dispersionCoefficientsNm2[dispersionIndex], nmToMf(thicknessNM).x, invertDepth, useProjectedDepth);

    // Final BRDF
    C3 brdf = CMul(CV(materialSpecularColor * ggxDistribution, ZERO3), fresnelTerm);
    return CSat(brdf);
}


// Define the microfacet-based BRDF function
C3 MicrofacetBRDF2(
    MaterialSellmeier mat,
    float2 inputUV, float time,
    MaterialProperties material,
    AnisotropicRoughness roughness,
    float3 diffuseColor,
    float3 sssColor,
    float sssStrength,
    float3 normal, float3 viewDir, float3 lightDir,
    bool invertDepth, bool useProjectedDepth,
    float3 outsideRefractiveIndex = ONE3,
    float3 materialRefractiveIndex = float3(1.3, 1.3, 1.3),
    float thicknessNM = 20.0,
    float3 dispersionCoefficient = float3(0.005, 0.006, 0.007),
    int dispersionIndex = 0)
{
    float3 H = safeNormalizef(viewDir + lightDir);

	// Calculate the microfacet normal
    float3 roughnessVec = float3(roughness.alphaX, roughness.alphaY, 0);

    float3 microfacetNormal = safeNormalizef(normal + roughnessVec);

	// Calculate the GGX distribution
    float v = dot(microfacetNormal, roughnessVec);
    if (v > 0)
    {
        v = sqrt(v);
    }
    float ggxDistribution = DistributionGGX(dot(microfacetNormal, H), v);

    int numThinFilms = 6;
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];
    CreateThinFilms(thinFilms);
    
	// Calculate the Fresnel term
    C3 fresnelTerm = FresnelMicrofacet(inputUV, time, viewDir, lightDir, microfacetNormal, mat, material,
        roughness, thinFilms, numThinFilms, sssStrength, mat.scatteringCoefficient, mat.absorptionCoefficient, mat.dispersionCoefficientsNm2[dispersionIndex], nmToMf(thicknessNM).x, invertDepth, useProjectedDepth);

	// Calculate the BRDF
    C3 brdf = CMul(CV(diffuseColor.rgb * ggxDistribution, ZERO3), fresnelTerm);

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
    float3 safeNormalizeNormal = safeNormalizef(normal);

	// Diffuse lighting
    float nDotL = max(dot(safeNormalizeNormal, safeNormalizef(pixelToSunDir)), EPSILON);
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
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);
    normal = safeNormalizef(normal);
    float3 halfDir = safeNormalizef(viewDir + lightDir);

    float NdotH = max(EPSILON, dot(normal, halfDir));
    float NdotL = max(EPSILON, dot(normal, lightDir));
    float VdotH = max(EPSILON, dot(viewDir, halfDir));
    float NdotV = max(EPSILON, dot(normal, viewDir));

	// Cook-Torrance BRDF
    float D = DistributionGGX(dot(normal, halfDir), roughness);
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
    light.direction = safeNormalizef(dir);
    light.color = col;
    light.wavelengthNM = CV0(waveLen);
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
LightSource CreateLightSource(uint type, float3 position, float3 direction, float3 color, C3 wavelengthNM, float intensity, float coherenceLength,
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
    light.direction = safeNormalizef(direction);
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
    float3 direction = safeNormalizef(float3(seeds.y - 0.5, seeds.z - 0.5, 1.0));
    light.position = viewPosition + direction * 1.25 * seeds.x;

    float3 lightRangeMin = float3(0.01, 0.01, 0.01);
    float3 lightRangeMax = float3(0.95, 0.95, 0.75);
    float3 lightRange = lightRangeMax - lightRangeMin;

	// Color and wavelength
    light.color = float3(hash11(seed * 2.1),
		hash11(seed * 2.2),
		hash11(seed * 2.3)
	);
    light.wavelengthNM = CV0(lerp(float3(380, 440, 675), float3(750, 675, 380), seeds));

    light.position += lightRange - direction * nmToMf(light.wavelengthNM.real);

	// Intensity and other properties
    light.intensity = dot(nmToMf(seeds * 0.652 * light.wavelengthNM.real), nmToMf(light.wavelengthNM.real));
    light.direction = safeNormalizef(viewPosition - light.position + length((400 + light.wavelengthNM.real) / (1440 * light.wavelengthNM.real / 1000.0)) * (seeds.y - 0.5) * 0.2);
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
    output.ViewDir = safeNormalizef(float3(ViewX, ViewY, ViewZ) - input.Position);
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
float3 ApplyDynamicIridescence(float2 uv, C3 wavelengthNM, float3 normal, float3 viewDir, float scaledTime, float noiseScale, float noiseStrength)
{
	// Add noise to the iridescence pattern
    float noiseValue = noiseFast11(uv * noiseScale);
    float3 angle = acos(dot(normal, viewDir)) * noiseValue * (nmToM(wavelengthNM).real - noiseStrength);

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
    source.direction = safeNormalizef(direction);
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
    float2 sz = GetSz(depthMap);
    [loop]
    for (int i = 0; i < totalPoints; ++i)
    {
        float angle = 2.0 * PI * float(i) / float(totalPoints);
        float s, c;
        sincos(angle, s, c);
        float2 ofs = oosz * float2(radius * c, radius * s);
        float3 pos = float3(uv + ofs, depth2D(depthMap, uv + ofs, invertDepth, useProjectedDepth));
        
        float3 direction = safeNormalizef(viewPos - pos);
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
    C3 wavelengthsNM, float currentPhase, float strength, MaterialSellmeier mat, int diffractionIndex012, bool invertDepth)
{
    float3 normalizedWavelength = saturate(saturate(wavelengthsNM.real - MIN_WAVELENGTHS) / WAVELENGTH_RANGES);
    
    float3 viewDir = safeNormalizef(viewPos - pixel);
    float3 normalW = CalcNormal(depthMap, pixel.xy, invertDepth, NormalRadius);
    float3 cosThetaT;
    float3 R0 = FresnelReflectanceFromFilm2(mat.etaR, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding), dot3(viewDir, normalW), cosThetaT);
    
    // Calculate path difference in meters (ensure ComputePathDifferenceM is defined)
    OpticalPathResult opd =
        OpticalPathDifference(
            wavelengthsNM, float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding),
            DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixel), mat.thicknessM),
            mat.dispersionCoefficientsNm2[clamp(diffractionIndex012, 0, 2)],
            mat.absorptionCoefficient, cosThetaT);

    // Refractive index (assumed constant for simplicity)
    C3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, true, mat);

    // Calculate phase shift (ensure CalculatePhaseShiftM is defined)
    float3 phaseShiftM = PhaseShiftM(nmToMf(wavelengthsNM.real), opd.opticalMeasurement.PathDifferenceM, refractiveIndex.real);

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



// Function to adjust refractive index based on wavelength
inline float3 AdjustRefractiveIndex(C3 wavelengthNM, MaterialDispersion material, float referenceWavelengthNM = 550.0)
{
	// Simple linear dispersion model: n = n0 + k * (1/λ - 1/λ0)
	// where λ0 is the reference wavelength (e.g., 550 nm for green)

    float3 refractiveIndex = material.refractiveIndexBase +
		material.dispersionCoefficient * (ONE3 / wavelengthNM.real - ONE3 / referenceWavelengthNM);
    return refractiveIndex;
}


inline float3 ChromaticBlurRadius(C3 wavelengthsNM, float baseRadius, float baseWavelengthNM)
{
    return baseRadius / (wavelengthsNM.real / baseWavelengthNM);
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
    float2 gradient = safeNormalizef(centeredUV) * refractionStrength;
    return gradient;
}

inline float Shadow(float currentDepth, float sampleDepth, float shadowIntensity)
{
    return lerp(0.0, shadowIntensity, step(currentDepth, sampleDepth));
}

// Utility Function: Calculate Shadow Factor Based on Depth
inline float Shadow(Texture2D<float> depthMap, float2 uv, float shadowIntensity, int shadowRadius, bool invertDepth)
{
    float currentDepth = depth2D(depthMap, uv, invertDepth, false);
    float shadowFactor = 0.0;
    float2 oosz = GetOosz(depthMap);
    float weight = 0;
    [loop]
    for (int x = -1; x <= 1; x++)
    {
        [loop]
        for (int y = -1; y <= 1; y++)
        {
            
            if (x == 0 && y == 0)
            {
            }
            else
            {
                float2 sampleUV = uv + float2(x, y) * float(shadowRadius * 2 * PI) * oosz;
                float sampleDepth = depth2D(depthMap, sampleUV, invertDepth, false);
                sampleUV = uv + float2(x, y) * float(shadowRadius * 2 * PI * (1 - sampleDepth)) * oosz;
                sampleDepth = depth2D(depthMap, sampleUV, invertDepth, false);
                float v = shadowIntensity * step(sampleDepth, currentDepth - .01);
                shadowFactor += v;
                weight += v * shadowIntensity;

            }
            
        }
    }

    return shadowFactor / weight;
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
    return uv + safeNormalizef(uv) * factor;
}




float3 GeneratePhotonDirection(float3 pixel, uint seed, bool invertDepth, bool useProjectedDepth)
{
    float2 uv1 = float2(noisePerlin11(pixel.xy), noisePerlin11(pixel.xy + seed));
    float3 pixel1 = float3(uv1, depth2D(depthMap, uv1, invertDepth, useProjectedDepth));
    return safeNormalizef(pixel1 - pixel);

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
    return noisePerlin01(1.5 + uv.x, 3.14159 + uv.y, AnimateTime);
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

    float kDotWind = max(dot(safeNormalizef(k), safeNormalizef(windDir)), EPSILON);
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
    float2 oosz = GetOosz(depthMap);
	// Detect edges based on normal variation
    float3 normalRight = CalcNormal(depthMap, depthUV + float2(oosz.x, 0), invertDepth, NormalRadius);
    
    float3 normalUp = CalcNormal(depthMap, depthUV + float2(0, -oosz.y), invertDepth, NormalRadius);
    
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
    float cosThetaI = max(EPSILON, saturate(dot(safeNormalizef(normal), safeNormalizef(lightDir))));
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
    float3 halfVector = safeNormalizef(lightDir + viewDir);

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
float3 HolographicNoise(float3 uv, float2 resolution, float dist)
{
    float3 noise1 = noiseMap1.Sample(sampleTypeMirror, uv.xy * resolution);
    float3 noiseL = noiseMap1.Sample(sampleTypeMirror, uv.xy * resolution - uv.z * dist / resolution);
    float3 noiseR = noiseMap1.Sample(sampleTypeMirror, uv.xy * resolution + uv.z * dist / resolution);
    return smoothstep(ZERO3, ONE3, float3(noiseL.x, noise1.y, noiseL.z));
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
    float2 sz = GetSz(depthMap);
    float2 oosz = 1.0 / sz;

	// Apply parallax effect for depth simulation
    float2 parallaxUV = ParallaxUV(uv, time, depth, uvScalar);

	// Apply dynamic chromatic aberration
    float3 aberration = DynamicChromaticAberration(diffuseMap, convertUV1ToUV4(depthMap, parallaxUV, diffuseMap), time, aberrationRadius, depth);

	// Generate complex interference pattern
    float interference = InterferenceComplex(parallaxUV, time, frequency, speed);


	// Add holographic noise
    float3 noise = HolographicNoise(float3(parallaxUV, depth), sz, HeightScale);

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
    float2 resolution = GetSz(depthMap);
    return frac(sin(dot(uv * resolution, float2(12.9898, 78.233))) * 43758.5453);
}

inline float3 SnellsLaw(float3 incidentRay, float3 normal, float n1, float n2)
{
    half3 I = safeNormalizef(half3(incidentRay));
    half3 N = safeNormalizef(half3(normal));
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


    float time = AnimateTime;


    float layerSize = 1.0 / float(numLayers);
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float4 diffuse = diffuse2D(diffuseMap, uv);
    C3 wavelengthsNM = RGBToWavelengthsNM(diffuse.xyz);
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

TransmissionResult BirefringentTransmission(
    float3 viewDir,
    float3 normal,
    float3 n_o,
    float3 n_e
)
{
    // Ensure vectors are normalized
    viewDir = safeNormalizef(viewDir);
    normal = safeNormalizef(normal);

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

float3 EffectiveBirefringentTransmission(
    float3 viewDir,
    float3 normal,
    float3 n_o,
    float3 n_e,
    float3 polarizationBlend
)
{
    TransmissionResult trans = BirefringentTransmission(viewDir, normal, n_o, n_e);
    // Blend per channel:
    float3 effectiveTransmission = lerp(trans.TransmissionO, trans.TransmissionE, polarizationBlend);
    return effectiveTransmission;
}


float4 OpticalAxisQuaternion(float3 opticalAxis)
{
    float3 z = safeNormalizef(opticalAxis);
    float3 up = lerp(float3(0.0, 1.0, 0.0), float3(1.0, 0.0, 0.0), step(abs(z.y), 0.999));
    float3 x = safeNormalizef(cross(up, z));
    float3 y = cross(z, x);
    // Convert rotation matrix to quaternion
    return matrixToQuaternion(float3x3(x, y, z));
}

float3x3 OpticalAxisMatrix(float3 opticalAxis)
{
    // Step 1: Normalize the optical axis
    float3 z = safeNormalizef(opticalAxis);
    
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
    x = safeNormalizef(x);
    
    // Step 6: Compute the y-axis as orthogonal to both z and x
    float3 y = cross(z, x);
    
    // Step 7: Construct and return the rotation matrix with orthonormal axes
    return float3x3(x, y, z);
}


float3 EffectiveRefractiveIndex(float3 lightDir, float3 opticalAxis, float3 n_o, float3 n_e)
{
    // Normalize the inputs
    lightDir = safeNormalizef(lightDir);
    opticalAxis = safeNormalizef(opticalAxis);

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


float3 DispersionCorrection(float3 n_eff, C3 wavelengthNM, float3 B, float3 C)
{
    // Convert wavelengths from nanometers to micrometers
    float3 lambda_um = nmToUm(wavelengthNM).real;

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
    
    return ClampRefractiveIndex(CV0(refractiveIndex)).real;
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
    float3 phi = (2.0 * PI / lambda) * effectiveN * mToNm(CV0(thicknessM)).real;

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
    return safeNormalizef(evolvedPolarization);
}

float3 PolarizationStateEvolution(
    float3 initialPolarization,
    float3 effectiveN,
    float thicknessM,
    C3 wavelengthNM
)
{
    // Convert wavelength from nanometers to meters
    float3 wavelengthM = nmToM(wavelengthNM).real;

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
    float3 phi = (2.0 * PI / lambda) * correctedN * mToNm(CV0(thicknessM)).real;

	// Apply phase shift to polarization components
    float3 phaseShifted = localPolarization * cos(phi) + cross(float3(0.0, 0.0, 1.0), localPolarization) * sin(phi);

	// Normalize the updated polarization vector
    return safeNormalizef(phaseShifted);
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
    incidentDir = safeNormalizef(incidentDir);
    normal = safeNormalizef(normal);
    opticalAxis = safeNormalizef(opticalAxis);

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




float3 BirefringentShadingModel(
    float3 albedo, // base color
    float3 position, // not used in this simple example, but could affect polarization
    float3 normal, // surface normal (in world or tangent space)
    float3 viewDir, // direction from surface to viewer
    float3 lightDir, // direction from surface to light source
    MaterialSellmeier mat, // material properties (includes refractive indices, thickness, etc.)
    C3 wavelengthsNM, // wavelengths for the color channels
    float time, // time (for any time–dependent phase or modulation)
    float3 polarizationBlend // blend factor: 0=ordinary; 1=extraordinary (per channel)
)
{
    // Compute refractive indices for each channel.
    // (Here we assume RefractiveIndexFromSellmeier returns a float3 per channel.)
    C3 n_o = RefractiveIndexFromSellmeier(wavelengthsNM, true, mat);
    C3 n_e = RefractiveIndexFromSellmeier(wavelengthsNM, false, mat);

    // Get the effective transmission per channel using our updated function.
    float3 effectiveTrans = EffectiveBirefringentTransmission(viewDir, normal, n_o.real, n_e.real, polarizationBlend);

    // In a simple model, you might let the transmitted (or refracted) light be modulated by this.
    // For example, assume that the effective transmission determines the blend between
    // “reflected” (specular) and “transmitted” (diffuse) contributions.
    float3 specularComponent = albedo * (1.0 - effectiveTrans); // reflected light
    float3 transmittedComponent = albedo * effectiveTrans; // transmitted light

    // Blend them according to the polarization state.
    float3 finalShading = lerp(specularComponent, transmittedComponent, polarizationBlend);
    return saturate(finalShading);
}

C3 IncorporateBirefringenceIntoLighting(
	PS_INPUT input,
	Texture2D<float4> diffuseMap,
	float2 inputUV,
	float3 viewDir,
	float3 lightDir,
	float3 normal,
	MaterialSellmeier mat,
	MaterialSellmeier mat2,
	C3 wavelengthNM,
	float time)
{
	// Normalize directions
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);
    normal = safeNormalizef(normal);

	// Calculate effective refractive indices for ordinary and extraordinary rays
    float3 n_o = RefractiveIndexFromSellmeier(wavelengthNM, true, mat).real; // true for ordinary ray
    float3 n_e = RefractiveIndexFromSellmeier(wavelengthNM, false, mat).real; // false for extraordinary ray

	// Compute effective refractive indices based on propagation direction
    float3 n_eff_o = EffectiveRefractiveIndex(lightDir, mat.opticalAxis.real, n_o, n_e); //n_o; // For ordinary ray, n_eff = n_o
    float3 n_eff_e = EffectiveRefractiveIndex(lightDir, mat.opticalAxis.real, n_e, n_o);
    
    float3 o_n_o = RefractiveIndexFromSellmeier(wavelengthNM, true, mat2).real; // true for ordinary ray
    float3 o_n_e = RefractiveIndexFromSellmeier(wavelengthNM, false, mat2).real; // false for extraordinary ray

	// Compute effective refractive indices based on propagation direction
    float3 o_n_eff_o = EffectiveRefractiveIndex(lightDir, mat.opticalAxis.real, o_n_o, o_n_e); //n_o; // For ordinary ray, n_eff = n_o
    float3 o_n_eff_e = EffectiveRefractiveIndex(lightDir, mat.opticalAxis.real, o_n_e, o_n_o);

	// Compute phase shifts
    float3 deltaPhi_o = PhaseShiftM(nmToM(wavelengthNM).real, mat.thicknessM.real, n_eff_o);
    float3 deltaPhi_e = PhaseShiftM(nmToM(wavelengthNM).real, mat.thicknessM.real, n_eff_e);
    
    float3 deltaPhi_o_o = PhaseShiftM(nmToM(wavelengthNM).real, mat2.thicknessM.real, o_n_eff_o);
    float3 deltaPhi_o_e = PhaseShiftM(nmToM(wavelengthNM).real, mat2.thicknessM.real, o_n_eff_e);

	// Compute interference term
    float3 interference = lerp(
        saturate(0.5 + 0.5 * cos(deltaPhi_o - deltaPhi_e)),
        saturate(0.5 + 0.5 * cos(deltaPhi_o_o - deltaPhi_o_e)),
        max(EPSILON, abs(dot(viewDir, normal))) * 0.5 + 0.5);

	// Compute Fresnel reflectance for both rays
    C3 FresnelO = CMul(Fresnel3(inputUV, time, CV0(float3(mat.roughness, mat.roughness, mat.roughness)), viewDir, normal, length(mat.thicknessM.real), FresnelPower, FresnelReflectance, o_n_o, n_o, 1.0 - mat.absorptionCoefficient), CV0(interference));
    C3 FresnelE = // FresnelSchlick(dot3(normal, lightDir) * 0.5 + 0.5, n_eff_e, FresnelPower);
       CMul(Fresnel3(inputUV, time, CV0(float3(mat.roughness, mat.roughness, mat.roughness)), viewDir, normal, length(mat.thicknessM.real), FresnelPower, FresnelReflectance, o_n_e, n_e, 1.0 - mat.absorptionCoefficient), CV0(interference));

	// Sample diffuse texture
    C3 albedo = CV0(diffuse2D(diffuseMap, inputUV).rgb);

	// Combine contributions from ordinary and extraordinary rays
    C3 colorI = CAdd(albedo, FresnelO);
    C3 colorE = CAdd(albedo, FresnelE);

    return CSat(ComplexLerp(colorE, colorI, CV0(ONE3 * max(EPSILON, dot(viewDir, normal) * .5 + .5))));
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
    gratingNormal = safeNormalizef(gratingNormal);
    incidentDir = safeNormalizef(incidentDir);
    viewDir = safeNormalizef(viewDir);

    // Precompute values
    float cosThetaI = dot(incidentDir, gratingNormal);
    float sinThetaI = sqrt(saturate(1.0 - cosThetaI * cosThetaI));

    // Fixed wavelengths in nanometers for RGB channels
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(baseColor)); // Red, Green, Blue
    float3 wavelengthsM = nmToM(wavelengthsNM).real; // Convert to meters

    // Grating spacing in meters
    float d = gratingSpacingNM * 1e-9;

    // Tangent direction perpendicular to the grating normal
    float3 tangentDir = safeNormalizef(incidentDir - gratingNormal * cosThetaI);

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
        float3 diffractedDir = safeNormalizef(sinThetaM * tangentDir + cosThetaM * gratingNormal);

        // Compute the dot product between view direction and diffracted direction
        float3 viewAlignment = saturate(dot(viewDir, diffractedDir));

        // Approximate diffraction efficiency using a Gaussian function
        float3 diffractionEfficiency = exp(-pow(max(EPSILON3, m * wavelengthsNM.real - gratingSpacingNM), 2.0) / max(EPSILON, strength2));

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
    float3 diffraction = DiffractionPattern(RGBToWavelengthsNM(CV0(baseColor)), gratingSpacingNM, viewDir);
    
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
    float3 centerNormal = CalcNormal(depthMap, normalUV, invertDepth, useProjectedDepth);

    [loop]
    for (int y = -radius; y <= radius; y++)
    {
        [loop]
        for (int x = -radius; x <= radius; x++)
        {
            float2 offset = float2(x, y) * ooszNormal * sigma * dist;

            float3 sampleNormal = normalize(CalcNormal(depthMap, normalUV + offset, invertDepth, useProjectedDepth) + .1 * noise3(noiseMap3, float3(normalUV, depth2D(depthMap, convertUV3ToUV1(normalMap, normalUV + offset, depthMap), invertDepth, useProjectedDepth))));
            float spatialWeight = gaussian(length(offset), sigma);
            float rangeWeight = gaussian(length(sampleNormal - centerNormal), sigma);
            float weight = spatialWeight * rangeWeight;

            blurNormal += sampleNormal * weight;
            totalWeight += weight;
        }
    }

    blurNormal /= max(abs(totalWeight), 0.0001);
    return safeNormalizef(lerp(centerNormal, blurNormal, .5) * 2.0 - 1.0);
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
    axis = safeNormalizef(axis);
    float cosA = cos(angle);
    float sinA = sin(angle);
    return v * cosA + cross(axis, v) * sinA + axis * dot(axis, v) * (1.0 - cosA);
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

float CalculateDepthGradient(Texture2D<float> depthMap, float2 uv, float2 oosz, bool invertDepth, bool useProjectedDepth = false)
{
    float depthCenter = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    float depthRight = depth2D(depthMap, uv + float2(oosz.x, 0.0f), invertDepth, useProjectedDepth);
    float depthUp = depth2D(depthMap, uv + float2(0.0f, oosz.y), invertDepth, useProjectedDepth);
    
    float gradientX = abs(depthRight - depthCenter);
    float gradientY = abs(depthUp - depthCenter);
    
    return max(gradientX, gradientY);
}

Complex2 Complex2Create(float2 real, float2 imag = ZERO2)
{
    Complex2 ret;
    ret.real = real;
    ret.imag = imag;
    return ret;
}

Complex2 Complex2Create1fXY(float v)
{
    Complex2 ret;
    ret.real = float2(v, v);
    ret.imag = ZERO2;
    return ret;
}

Complex2 Complex2Create1fX(float v)
{
    Complex2 ret;
    ret.real = float2(v, 0.0);
    ret.imag = ZERO2;
    return ret;
}

Complex2 Complex2Create1fY(float v)
{
    Complex2 ret;
    ret.real = float2(0.0, v);
    ret.imag = ZERO2;
    return ret;
}
// Adds two Complex2 numbers.
Complex2 Complex2Add(Complex2 a, Complex2 b)
{
    return Complex2Create(a.real + b.real, a.imag + b.imag);
}

// Subtracts Complex2 b from a.
Complex2 Complex2Sub(Complex2 a, Complex2 b)
{
    return Complex2Create(a.real - b.real, a.imag - b.imag);
}
// Multiplies a Complex2 number by a scalar.
Complex2 Complex2Mul1f(Complex2 a, float s)
{
    return Complex2Create(a.real * s, a.imag * s);
}

Complex2 Complex2Mul(Complex2 a, Complex2 b)
{
    float2 realPart = a.real * b.real - a.imag * b.imag;
    float2 imagPart = a.real * b.imag + a.imag * b.real;
    return Complex2Create(realPart, imagPart);
}

// Linearly interpolates between two Complex2 numbers.
Complex2 Complex2Lerp(Complex2 a, Complex2 b, float t)
{
    return Complex2Add(Complex2Mul1f(a, 1.0 - t), Complex2Mul1f(b, t));
}
// Normalizes a Complex2 number.
Complex2 Complex2Normalize(Complex2 a)
{
    // Compute the magnitude from both components.
    float mag = sqrt(dot(a.real, a.real) + dot(a.imag, a.imag));
    // Use a small constant to avoid division by zero.
    return Complex2Mul1f(a, 1.0 / max(mag, EPSILON));
}
// Returns a Complex2 representing e^(i * angle).
Complex2 Complex2Expf(float angle)
{
    return Complex2Create(ONE2 * cos(angle), ONE2 * sin(angle));
}
Complex2 Complex2Exp(float2 angle)
{
    return Complex2Create(cos(angle), sin(angle));
}

// Computes the complex exponential of a Complex2 value.
// For z = a + i*b, returns e^(z) = e^(a) * (cos(b) + i*sin(b)).
Complex2 Complex2Exp(Complex2 z)
{
    // Compute the exponential of the real part, component-wise.
    float2 expReal = exp(z.real);
    
    // Compute cosine and sine of the imaginary part, component-wise.
    float2 cosImag = cos(z.imag);
    float2 sinImag = sin(z.imag);
    
    // Multiply the exponential of the real part with cosine and sine of the imaginary part.
    return Complex2Create(expReal * cosImag, expReal * sinImag);
}

//------------------------------------------------------------------------------
// Additional Helper Functions for the Imaginary Parts
//------------------------------------------------------------------------------

// Computes the magnitude of a Complex2 value by combining both the real and imaginary parts.
// This scalar can be used to gauge the overall intensity or offset in the holographic domain.
float Complex2Magnitude(Complex2 a)
{
    return sqrt(dot(a.real, a.real) + dot(a.imag, a.imag));
}

// Computes a phase angle for each component of the Complex2.
// The result is a float2 where each element is computed via atan2(imag, real),
// capturing the directional phase in each corresponding axis.
float2 Complex2Phase(Complex2 a)
{
    return float2(atan2(a.imag.x, a.real.x), atan2(a.imag.y, a.real.y));
}



inline Complex2ParallaxResult ComplexParallaxOcclusion(
    Texture2D<float> depthMap,
    Complex2 depthUV, // Starting complex UV coordinate.
    Complex2 parallaxDir, // Holographically infused parallax direction.
    bool invertDepth,
    bool useProjectedDepth,
    float scale)
{
    Complex2ParallaxResult ret;
    ret.intersectionCount = 0;
    ret.prevUV = depthUV; // Initialize the previous holographic coordinate.

    // Local array for storing holographic delta UVs.
    Complex2 localDeltaUVs[MAX_PARALLAX_INTERSECTIONS];
    int localCount = 0;

    // Obtain one-over-size for proper offset scaling (real-space information).
    float2 oosz = GetOosz(depthMap); // (Assumed to be defined elsewhere)

    float layerDepth = 1.0 / float(MAX_PARALLAX_LAYERS);

    // Read the initial depth from the real projection of our complex coordinate.
    float currentDepthMapValue = depth2D(depthMap, depthUV.real, invertDepth, useProjectedDepth);
    
    // Determine the depth sign (for zero, assume positive).
    float depthSign = (currentDepthMapValue > 0.0) ? 1.0 : -1.0;

    // Holographic phase modulation: twist the parallax direction based on depth.
    Complex2 rotatedDir = Complex2Mul(
        Complex2Normalize(Complex2Mul(parallaxDir, Complex2Exp(Complex2Create1fX(3.14159265 * currentDepthMapValue)))),
        Complex2Create1fXY(scale)
    );

    Complex2 currentUV = depthUV;
    // Start at 0, then accumulate with the appropriate sign.
    float currentLayerDepth = 0.0;
    float prevDepthValue = currentDepthMapValue;

    // --- Coarse Search Phase ---
    // Calculate the initial delta in the complex plane.
    Complex2 deltaUVBase = Complex2Mul1f(rotatedDir, (scale / float(MAX_PARALLAX_LAYERS)));
    Complex2 prevUV = currentUV;
    float prevLayerDepth = currentLayerDepth;
    float prevDepthVal = currentDepthMapValue;

    [unroll(MAX_PARALLAX_LAYERS)]
    for (int x = 0; x < MAX_PARALLAX_LAYERS; x++)
    {
        // Advance in the complex plane.
        Complex2 sampleUV = Complex2Add(currentUV, deltaUVBase);
        float sampleDepth = depth2D(depthMap, sampleUV.real, invertDepth, useProjectedDepth);

        // Update currentUV.
        currentUV = Complex2Add(currentUV, deltaUVBase);
        // Accumulate layer depth in the direction of the initial depth.
        currentLayerDepth += depthSign * layerDepth;

        // Update currentDepthMapValue and depthSign.
        prevDepthVal = currentDepthMapValue;
        currentDepthMapValue = sampleDepth;
        depthSign = (currentDepthMapValue >= 0.0) ? 1.0 : -1.0;

        // Check for an intersection using sign-aware comparisons.
        bool intersect = false;
        if (depthSign > 0.0)
        {
            intersect = (currentLayerDepth >= currentDepthMapValue + EPSILON);
        }
        else // depthSign < 0.0
        {
            intersect = (currentLayerDepth <= currentDepthMapValue - EPSILON);
        }

        if (intersect)
        {
            // --- Binary Refinement Phase ---
            Complex2 refinedUV = currentUV;
            float refinedLayerDepth = currentLayerDepth;

            Complex2 lowUV = Complex2Sub(currentUV, deltaUVBase);
            float lowLayerDepth = currentLayerDepth - depthSign * layerDepth;
            float lowDepthValue = depth2D(depthMap, lowUV.real, invertDepth, useProjectedDepth);

            Complex2 highUV = currentUV;
            float highLayerDepth = currentLayerDepth;
            float highDepthValue = sampleDepth;

            [unroll(MAX_PARALLAX_REFINE_ITERATIONS)]
            for (int j = 0; j < MAX_PARALLAX_REFINE_ITERATIONS; j++)
            {
                // Interpolate between low and high UV positions.
                Complex2 midUV = Complex2Lerp(lowUV, highUV, 0.5);
                float midLayerDepth = (lowLayerDepth + highLayerDepth) * 0.5;
                float midDepthValue = depth2D(depthMap, midUV.real, invertDepth, useProjectedDepth);

                bool refineIntersect = false;
                if (midDepthValue >= 0.0)
                {
                    refineIntersect = (midLayerDepth >= midDepthValue + EPSILON);
                }
                else
                {
                    refineIntersect = (midLayerDepth <= midDepthValue - EPSILON);
                }

                if (refineIntersect)
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

            // Compute a weight for blending based on depth differences.
            float depthDifference = lowDepthValue - lowLayerDepth;
            float layerDifference = lowLayerDepth - highLayerDepth;
            float weight = clamp(depthDifference / max(depthDifference + layerDifference, EPSILON), 0.0, 1.0);
            Complex2 finalUV = Complex2Lerp(lowUV, highUV, weight);

            // Save the holographic delta offset.
            if (localCount < MAX_PARALLAX_INTERSECTIONS)
            {
                localDeltaUVs[localCount++] = Complex2Sub(finalUV, depthUV);
            }

            // Update current position with the refined result.
            currentUV = finalUV;
            currentLayerDepth = lowLayerDepth + weight * layerDifference;
            currentDepthMapValue = lowDepthValue + weight * (highDepthValue - lowDepthValue);

            break; // Exit after finding the dominant intersection.
        }

        // Update the parallax direction and delta based on the new depth.
        rotatedDir = Complex2Normalize(
            Complex2Mul(parallaxDir, Complex2Exp(Complex2Create1fX(3.14159265 * currentDepthMapValue)))
        );
        deltaUVBase = Complex2Mul1f(rotatedDir, (scale / float(MAX_PARALLAX_LAYERS)));

        prevUV = currentUV;
        prevLayerDepth = currentLayerDepth;
        prevDepthVal = currentDepthMapValue;
    }

    // If no clear intersection was found, record the cumulative offset.
    if (localCount < MAX_PARALLAX_INTERSECTIONS &&
        ((currentDepthMapValue >= 0.0 && currentLayerDepth < currentDepthMapValue + EPSILON) ||
         (currentDepthMapValue < 0.0 && currentLayerDepth > currentDepthMapValue - EPSILON)))
    {
        localDeltaUVs[localCount++] = Complex2Sub(currentUV, depthUV);
    }
    
    ret.prevUV = prevUV;
    ret.deltaUVs = localDeltaUVs;
    ret.intersectionCount = localCount;

    return ret;
}

float3 Specular(float3 N, float3 V, float3 L, MaterialSellmeier mat)
{
    float3 H = safeNormalizef(V + L);
    float NDF = DistributionGGX(max(0, dot(N, H)), mat.roughness);
    float3 G = GeometrySmithNVL(N, V, L, CreateAnisotropicRoughness(mat.roughness, mat.roughness));

	// Compute Fresnel reflectance for each RGB channel
    float3 NdotV = max(0, dot3(N, V));

    C3 reflectance = FresnelReflectanceFromComplex(CV0(NdotV), CV(mat.etaR, mat.etaI));
    float3 FresnelR = clamp(CAbs(reflectance).real, ZERO3, ONE3);
    
	// Compute specular component
    float3 specular = (saturate(NDF * G * FresnelR) / max(EPSILON3, (SpecularPower * NdotV))) * SpecularIntensity;
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
        Iridescence(diffuseUV, viewDir, normal, albedo, thicknessM, mat, iorMedium), NormalRadius, mat, invertDepth, useProjectedDepth, dispersionIndex);

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
    float3 D = DistributionGGX(dot(N, H), alpha);
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
    normal = safeNormalizef(normal);
    viewDir = safeNormalizef(viewDir);
    lightDir = safeNormalizef(lightDir);

    // Compute the half-vector
    float3 H = safeNormalizef(viewDir + lightDir);

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
    float3 halfDir = safeNormalizef(lightDir + viewDir);

    // Fresnel-Schlick approximation
    float NdotH = saturate(dot(normal, halfDir));
    float3 Fresnel = FresnelSchlickRoughness(F0, NdotH, roughness);

    // GGX Normal Distribution Function
    float NDF = DistributionGGX(saturate(dot(normal, halfDir)), roughness);

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
    normal = safeNormalizef(normal);
    lightDir = safeNormalizef(lightDir);
    
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
    lightDir = safeNormalizef(lightDir);
    viewDir = safeNormalizef(viewDir);
    normal = safeNormalizef(normal);

    // Calculate the half-vector between the light direction and the view direction
    float3 halfVector = safeNormalizef(lightDir + viewDir);

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
    lightDir = safeNormalizef(lightDir);
    viewDir = safeNormalizef(viewDir);
    normal = safeNormalizef(normal);

    // Calculate the half-vector between the light direction and the view direction
    float3 halfVector = safeNormalizef(lightDir + viewDir);

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
    incidentDir = safeNormalizef(incidentDir);
    gratingNormal = safeNormalizef(gratingNormal);

    // Calculate the angle of incidence (θ_i) relative to the grating normal
    float cosThetaI = saturate(dot(incidentDir, gratingNormal));
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
    float3 rotationAxis = safeNormalizef(cross(incidentDir, gratingNormal));

    // Handle cases where incidentDir is parallel to gratingNormal
    if (length(rotationAxis) < EPSILON)
    {
        // Incident direction is parallel to grating normal
        // Choose an arbitrary axis perpendicular to gratingNormal
        rotationAxis = safeNormalizef(cross(gratingNormal, float3(0.0, 1.0, 0.0)));
        if (length(rotationAxis) < EPSILON)
        {
            rotationAxis = safeNormalizef(cross(gratingNormal, float3(1.0, 0.0, 0.0)));
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
    diffractionDir = safeNormalizef(diffractionDir);

    return diffractionDir;
}

float3 CalculateDiffractionDirection(float3 incidentDir, // Incident direction vector (normalized)
    float3 gratingNormal, // Grating normal vector (normalized)
    C3 wavelengthNM, // Wavelength in nanometers
    float gratingSpacingNM, // Grating spacing in nanometers
    int order // Order of diffraction (e.g., -1, 0, 1)
)
{
    return float3(
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.real.x, gratingSpacingNM, order).x,
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.real.y, gratingSpacingNM, order).y,
        CalculateDiffractionDirection(incidentDir, gratingNormal, wavelengthNM.real.z, gratingSpacingNM, order).z
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
    float3 albedoWavelengthsNM = RGBToWavelengthsNMf(albedo);
    float3 birefL = BirefringentShadingModel(
        saturate(albedo),
        pixel,
        normal,
        viewDirL,
        lightDir,
        mat,
        CV0(albedoWavelengthsNM),
        time, NdotV * 0.5 + 0.25 * gratingEfficiency + 0.25 * chromaticAberrationStrength
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
        length(mat.thicknessM.real),
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
        RGBToWavelengthsNM(CV0(saturate(albedo))),
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
   
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(diffuse));
    float3 refractiveIndex = RefractiveIndexFromSellmeier(wavelengthsNM, true, mat).real;

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
        nmToMf(wavelengthsNM.real),
        0.001, // filmThicknessM in meters (1mm as an example)
        refractiveIndex,
        cosThetaT,
        ONE3 * mat.nSurrounding
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
            C3 wavelengthNM = lerp(diffuseColor * WAVELENGTH_RANGES + MIN_WAVELENGTHS, RGBToWavelengthsNM(diffuseColor), .5);
          
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
        float time = AnimateTime;
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
    float3 viewDir = safeNormalizef(viewPosition - worldPos);

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
            float3 lightDir = safeNormalizef(lightPos - worldPos);
            float3 normal = CalcNormal(depthMap, inputUV + lightOffset, invertDepth, useProjectedDepth);

            C3 wavelengthNM = RGBToWavelengthsNM(CV0(diffuse2D(diffuseMap, inputUV).rgb));
            float distance = length(lightPos - worldPos);

            float3 phase = fmod((6.283185307 * distance) / max(wavelengthNM.real, EPSILON3), 6.283185307);

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
    float3 diffuseWavelengthsNM = RGBToWavelengthsNM(CV0(mat.albedo)).real;
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

        float3 interference = InterferenceMultiWave(inputUV, AnimateTime, nmToMf(diffuseWavelengthsNM), light.amplitude, light.phase);
        float3 thinFilm = InterferenceThinFilm(inputUV, AnimateTime, nmToMf(diffuseWavelengthsNM), mat.thicknessM.real, mat.etaR, cosThetaT, mat.nSurrounding);
        float3 iridescent = Iridescence(inputUV, viewDir, normal, mat.albedo, length(mat.thicknessM.real), mat, mat.
        etaR);
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
    float dept = depth2D(depthMap, uv);
    float4 blurred = (
        .25 * (diffuseMap.Sample(ssampler, uv + float2(-1.0, -1.0) * oosz * dept) +
        diffuseMap.Sample(ssampler, uv - float2(-1.0, 1.0) * oosz) * dept +
        diffuseMap.Sample(ssampler, uv + float2(1.0, 1.0) * oosz) * dept +
        diffuseMap.Sample(ssampler, uv - float2(1.0, -1.0) * oosz) * dept) +
    
        diffuseMap.Sample(ssampler, uv + float2(1.0, 0.0) * oosz) +
        diffuseMap.Sample(ssampler, uv - float2(1.0, 0.0) * oosz) +
        diffuseMap.Sample(ssampler, uv + float2(0.0, 1.0) * oosz) +
        diffuseMap.Sample(ssampler, uv - float2(0.0, 1.0) * oosz)) * 0.25 * .25;
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
    if (PassNum > 0)
    {
        color.r = lerp(color.r, diffuse2D(rtMap1, redUV).r, .75);
        color.b = lerp(color.b, diffuse2D(rtMap1, blueUV).b, .75);
    }
    return color.rgb;
}

float4 FinalPass(Texture2D<float4> diffuseMap, float2 diffuseUV, Texture2D<float4> rtMap, float2 rtUV, Texture2D<float> depthMap, float2 depthUV, float3 color, bool invertDepth, bool useProjectedDepth)
{
    float depth = depth2D(depthMap, depthUV, invertDepth, useProjectedDepth);
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
    color = FinalPassAdjustSaturation(color, HeightParamA * saturate(dot(normalize(float3(ViewX, ViewY, ViewZ) - float3(rtUV, depth2D(depthMap, rtUV, invertDepth, useProjectedDepth))), CalcNormal(depthMap, rtUV, invertDepth, useProjectedDepth))));
    
    if (PassNum > 0)
    {
        color *= FinalPassChromaticAberration(color, rtMap1, rtUV, samplerState, 12 * (1.0 - depth));
    }
    else
    {
        color *= FinalPassChromaticAberration(color, diffuseMap, diffuseUV, samplerState, 12 * (1.0 - depth));
    }
        
    
    color = FinalPassColorGrade(color, ONE3 * CosineFactorG, Gamma, ONE3 * CosineFactorB);
   
    return float4(saturate(color), 1);
}


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


OffsetScalar CreateOffsetScalar(float3 offset, float3 scalar)
{
    OffsetScalar ret = (OffsetScalar) 0;
    ret.Offset = offset;
    ret.Scalar = scalar;
    return ret;
}
ValueTransformFloat3 CreateValueTransformFloat3(float3 value, OffsetScalar transform)
{
    ValueTransformFloat3 ret = (ValueTransformFloat3) 0;
    ret.Value = value;
    ret.Transform = transform;
    return ret;
}


float3 EffectiveRefractiveIndexCorrection(float3 refractiveIndex, float3 opticalAxis)
{
    // Cosine of the angle between refractive index vector and optical axis
    float3 cosTheta = ONE3 * saturate(dot(safeNormalizef(refractiveIndex), safeNormalizef(opticalAxis)));

    // Adjust correction factor based on angle
    float3 correction = ONE3 + (ONE3 - cosTheta);

    return correction;
}

float3 EffectiveRefractiveIndexCorrection(float3 lightDir, float3 opticalAxis, float3 reflectance, float3 refractiveIndex)
{
    // Cosine of angle between light direction and optical axis
    float cosTheta = saturate(dot(safeNormalizef(lightDir), safeNormalizef(opticalAxis)));

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
float3 CalculateEffectiveRefractiveIndexReflectImag(float3 lightDir, float3 opticalAxis, float3 reflectanceImag, float3 refractiveIndex)
{
    return EffectiveRefractiveIndexCorrection(lightDir, opticalAxis, reflectanceImag, refractiveIndex);
}
float3 CalculateEffectiveRefractiveIndexTransmitImag(float3 lightDir, float3 opticalAxis, float3 transmittanceImag, float3 refractiveIndex)
{
    return EffectiveRefractiveIndexCorrection(lightDir, opticalAxis, transmittanceImag, refractiveIndex);
}
float3 CalculateF0(float metallic, float3 dielectricReflectance, float3 metallicReflectance)
{
    // Dielectric reflectance is typically 0.04 for non-metals
    return lerp(dielectricReflectance, metallicReflectance, metallic);
}
float3 CalculateInterference(Lighting lighting)
{
    // Define C3 structures for internal and external reflectance
    C3 internalReflectance = CV(
        lighting.internalFilmReflectanceReal,
        lighting.internalFilmReflectanceImag
    );
    C3 externalReflectance = CV(
        lighting.externalFilmReflectanceReal,
        lighting.externalFilmReflectanceImag
    );

    // Calculate interference contribution
    return CDot(internalReflectance, externalReflectance).real;
}

float3 ApplyReflectanceCoherence(float3 reflectance, OpticalPathResult opd, float coherenceLength)
{
    return reflectance * CoherenceFactor(opd.opticalMeasurement.PathLengthM, coherenceLength);
}
float3 ApplyTransmissionCoherence(float3 transmittance, OpticalPathResult opd, float3 coherenceLength)
{
    // Modulate the transmittance with coherence and path length factors
    return transmittance * CoherenceFactor(opd.opticalMeasurement.PathLengthM, coherenceLength);
}



float3 RedistributeExcessEnergy(float3 totalLight, inout float3 reflectance, inout float3 transmittance)
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
    inout C3 diffuseReflectance,
    inout C3 diffuseTransmittance,
    inout C3 specular,
    inout C3 interference
)
{
    // Calculate total real and imaginary energy
    C3 totalEnergy = CV(
        diffuseReflectance.real + diffuseTransmittance.real + specular.real + interference.real,
        diffuseReflectance.imag + diffuseTransmittance.imag + specular.imag + interference.imag
    );

    // Normalize real energy to conserve energy
    if (any(totalEnergy.real > 1.0))
    {
        float3 correctionFactor = max(totalEnergy.real, EPSILON3);
        
        diffuseReflectance.real /= correctionFactor;
        diffuseTransmittance.real /= correctionFactor;
        specular.real /= correctionFactor;
        interference.real /= correctionFactor;
    }
    if (any(totalEnergy.imag > 1.0))
    {
        float3 correctionFactor = max(totalEnergy.imag, EPSILON3);
      
        diffuseReflectance.imag /= correctionFactor;
        diffuseTransmittance.imag /= correctionFactor;
        specular.imag /= correctionFactor;
        interference.imag /= correctionFactor;
    }
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
    
    lighting.fDepthScale = depthScale;
    lighting.DepthRange = depthRange;
    
    // Create material
    MaterialSellmeier mat = CreateMaterial(materialIndex);
    mat.albedo = diffuse2D(diffuseMap, inputUV).rgb;
    lighting.material = mat;
    // Albedo and wavelength conversions
    lighting.albedo = mat.albedo;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(CV0(lighting.albedo)).real;
    lighting.albedoWavelengthsM = nmToM(CV0(lighting.albedoWavelengthsNM)).real;
    
    lighting.nSurrounding = ONE3 * mat.nSurrounding;
   
    // Time and sway calculations
    float time = AnimateTime;
   
    lighting.pixelPos = float3(inputUV, depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth));
    
    lighting.nSurrounding = ONE3 * mat.nSurrounding;

    // Pixel and normal calculations
    lighting.normal = CalcNormal(depthMap, inputUV, invertDepth, normalRadius);

    // View and light positions and directions
    lighting.viewPos = viewPos;
    lighting.lightPos = lightPos;
    lighting.viewDir = safeNormalizef(lighting.viewPos - lighting.pixelPos);
    lighting.lightDir = safeNormalizef(lighting.lightPos - lighting.pixelPos);
    lighting.halfDir = safeNormalizef(lighting.viewDir + lighting.lightDir);

    // Dot products
    lighting.VdotH = clamp(dot(lighting.viewDir, lighting.halfDir), EPSILON, OneMinusEPSILON);
    lighting.NdotV3 = clamp(dot3(lighting.viewDir, lighting.normal), EPSILON3, OneMinusEPSILON3);
    if (all(lighting.NdotV3 > 0.5))
    {
        lighting.NdotV3 = lighting.NdotV3 * 0.5 + 0.5;

    }
    lighting.HdotN = clamp(dot(lighting.halfDir, lighting.normal), EPSILON, OneMinusEPSILON);
    lighting.HdotL = clamp(dot(lighting.halfDir, lighting.lightDir), EPSILON, OneMinusEPSILON);
    lighting.NdotL3 = clamp(dot3(lighting.lightDir, lighting.normal), EPSILON3, OneMinusEPSILON3);

    // Reflectance with interference
    lighting.iorAlbedoR = RefractiveIndexFromSellmeier(CV0(lighting.albedoWavelengthsNM), true, mat).real;
    lighting.iorAlbedoI = RefractiveIndexFromSellmeier(CV0(lighting.albedoWavelengthsNM), false, mat).real;

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
    
    lighting.phaseShiftComplex[dispersionIndex] = CV(
        lighting.phaseReal[dispersionIndex],
        lighting.phaseImag[dispersionIndex]);
    
    lighting.phaseShiftComplex[dispersionIndex] = CMul(
        lighting.phaseShiftComplex[dispersionIndex],
        CV(lighting.reflectanceReal[dispersionIndex], lighting.reflectanceImag[dispersionIndex])
    );

    
    lighting.internalComplex[dispersionIndex] = CV(lighting.internalFilmReflectanceReal, lighting.internalFilmReflectanceImag);
    
    lighting.externalComplex[dispersionIndex] = CV(lighting.externalFilmReflectanceReal, lighting.externalFilmReflectanceImag);
    
    lighting.totalReflectanceComplex[dispersionIndex] = CAdd(lighting.internalComplex[dispersionIndex], CMul(lighting.externalComplex[dispersionIndex], lighting.phaseShiftComplex[dispersionIndex]));
    
    lighting.totalReflectanceComplex[dispersionIndex] = CMul(
        lighting.totalReflectanceComplex[dispersionIndex],
        CV(lighting.reflectanceReal[dispersionIndex], lighting.reflectanceImag[dispersionIndex])
    );

    
    lighting.interferenceIntensity[dispersionIndex] = CDot(lighting.totalReflectanceComplex[dispersionIndex], lighting.totalReflectanceComplex[dispersionIndex]).real.x;
    
    lighting.interferenceIntensity[dispersionIndex] *= exp(-mat.absorptionCoefficient *
        lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM);

    
    // BRDF Calculations
    lighting.microfacetRoughness = mat.roughness.xx;
    lighting.ggxDistributionTerm = DistributionGGX(dot(lighting.normal, lighting.halfDir), lighting.microfacetRoughness.x);
    lighting.smithGeometryTerm = GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x);
    lighting.microfacetDenominator = max(float3(4.0, 4.0, 4.0) * lighting.NdotV3, float3(EPSILON3));

    lighting.microfacetSpecularTerm = saturate((lighting.ggxDistributionTerm * lighting.smithGeometryTerm) / lighting.microfacetDenominator);
    
    lighting.specularReflectanceResult = Specular(
        lighting.normal, lighting.viewDir, lighting.lightDir, mat) * lighting.microfacetSpecularTerm;

    float3 angularTerm = pow(1.0 - saturate(lighting.NdotL3), 5.0);
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
    lighting.calculatedLightIntensity = CreateLighting(inputUV, GetSz(depthMap), lighting.viewPos, lighting.invertDepth, lighting.useProjectedDepth, parallaxScale, mat, lighting.normal, lighting.lightDir, lighting.viewDir, time, lighting.cosThetaTransmissionInsideReal,
        sssStrength, dispersionIndex);
   
    // Path Tracing Measurements
    lighting.viewToPixel = DistanceMFromViewToAB(CV0(lighting.viewPos), CV0(lighting.pixelPos), CV0(lighting.pixelPos + lighting.viewDir * mat.thicknessM.real));
    lighting.calculatedLightIntensity *= saturate(1.0 / (1.0 + pow(length(lighting.viewToPixel.PathLengthM), 2.0)));
    
    
    lighting.reflectanceReal[dispersionIndex] = max(ApplyReflectanceCoherence(
            lighting.reflectanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex], length(mat.coherenceLengthM.real)
            ), EPSILON3);
        
    float3 reflectanceCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis.real
        ), ZERO3);
        
    lighting.reflectanceReal[dispersionIndex] *= reflectanceCorrection;
        

        // Apply coherence to transmittance
    lighting.transmittanceReal[dispersionIndex] = max(ApplyTransmissionCoherence(
            lighting.transmittanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex],
            length(mat.coherenceLengthM.real)
        ), EPSILON3);

// Apply angular correction to transmittance
    float3 transmittanceCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis.real
        ), ZERO3);
    lighting.transmittanceReal[dispersionIndex] *= transmittanceCorrection;

        // Ensure energy conservation
    float3 totalLight = abs(lighting.reflectanceReal[dispersionIndex]) + abs(lighting.transmittanceReal[dispersionIndex]);
    if (any(totalLight > 1.0))
    {
        lighting.reflectanceReal[dispersionIndex] /= max(totalLight, EPSILON3);
        lighting.transmittanceReal[dispersionIndex] /= max(totalLight, EPSILON3);
    }
    

    // Loop over dispersionIndex
    
    lighting.opdAlbedoTransRealChannel[dispersionIndex] = OpticalPathDifference(
            CV0(lighting.albedoWavelengthsNM),
            lighting.nSurrounding,
            lighting.viewToPixel,
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient,
            lighting.cosThetaTransmissionInsideReal
        );

    lighting.opdAlbedoTransImagChannel[dispersionIndex] = OpticalPathDifference(
            CV0(lighting.albedoWavelengthsNM),
            lighting.nSurrounding,
            lighting.viewToPixel,
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.absorptionCoefficient,
            lighting.cosThetaTransmissionInsideImag
        );

    lighting.reflectanceReal[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceReal + lighting.externalFilmReflectanceReal + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceReal * lighting.externalFilmReflectanceReal, float3(EPSILON3))) * sin(lighting.opdAlbedoTransRealChannel[dispersionIndex].phaseInterference.totalPhase)) *
            CoherenceFactor(lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM, mat.coherenceLengthM.real) *
            PolarizationEffect3(
                cos(lighting.opdAlbedoTransRealChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceReal,
                lighting.externalFilmReflectanceReal 
            )
        );
        
        
    lighting.reflectanceReal[dispersionIndex] =
            max(ApplyReflectanceCoherence(lighting.reflectanceReal[dispersionIndex], lighting.opdAlbedoTransRealChannel[dispersionIndex], length(mat.coherenceLengthM.real)
            ), EPSILON3);
        // Apply angular correction to reflectance
    float3 reflectanceCorrection2 = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis.real
            ), ZERO3);
    lighting.reflectanceReal[dispersionIndex] *= reflectanceCorrection2;
        

    {
        lighting.reflectanceImag[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceImag + lighting.externalFilmReflectanceImag + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceImag * lighting.externalFilmReflectanceImag, float3(EPSILON3))) * sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)) *
            CoherenceFactor(lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM, length(mat.coherenceLengthM.real))) *
            PolarizationEffect3(
                sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceImag * InterferenceComplex(inputUV, time, lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.phaseShift.x, lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.phaseDifference.x),
                lighting.externalFilmReflectanceImag 
            );
    }
        // Calculate reflectance imaginary
    lighting.reflectanceImag[dispersionIndex] = saturate(
            (lighting.internalFilmReflectanceImag + lighting.externalFilmReflectanceImag +
             (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectanceImag * lighting.externalFilmReflectanceImag, float3(EPSILON3))) *
             sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)
            ) *
            CoherenceFactor(
                lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                length(mat.coherenceLengthM.real)
            ) *
            PolarizationEffect3(
                sin(lighting.opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectanceImag,
                lighting.externalFilmReflectanceImag
            )
        );
        // Apply refractive index correction
    lighting.reflectanceImag[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectImag[dispersionIndex], mat.opticalAxis.real
            ), ZERO3);
        
    lighting.reflectanceImag[dispersionIndex] =
            max(ApplyReflectanceCoherence(lighting.reflectanceImag[dispersionIndex], lighting.opdAlbedoTransImagChannel[dispersionIndex], length(mat.coherenceLengthM.real)
            ), EPSILON3);
        // Apply angular correction to reflectance
    float3 reflectanceImagCorrection = max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexReflectImag[dispersionIndex], mat.opticalAxis.real
            ), ZERO3);
    lighting.reflectanceImag[dispersionIndex] *= reflectanceImagCorrection;
        
    lighting.transmittanceReal[dispersionIndex] = saturate(ONE3 - max(lighting.reflectanceReal[dispersionIndex], ZERO3));

        
       // Apply coherence factor to transmittance
    lighting.transmittanceReal[dispersionIndex] *=
            max(CoherenceFactor(
                lighting.opdAlbedoTransRealChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                   length(mat.coherenceLengthM.real)
                ), ZERO3);


        // Apply refractive index correction for angular effects
    lighting.transmittanceReal[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis.real
            ), ZERO3);
       
         // Compute total energy and apply excess contribution
    float3 totalLight2 = max(lighting.reflectanceReal[dispersionIndex], ZERO3) + max(lighting.transmittanceReal[dispersionIndex], ZERO3);
    if (any(totalLight2 > 1.0))
    {
        float3 rr = max(lighting.reflectanceReal[dispersionIndex], ZERO3);
        float3 tr = max(lighting.transmittanceReal[dispersionIndex], ZERO3);
        
        totalLight2 = max(RedistributeExcessEnergy(totalLight2, rr, tr), ZERO3);
        lighting.reflectanceReal[dispersionIndex] = rr; // Redistributed reflectance
        lighting.transmittanceReal[dispersionIndex] = tr; // Redistributed transmittance
    }
        
        
        // Calculate transmittance imaginary
    lighting.transmittanceImag[dispersionIndex] = saturate(ONE3 - max(lighting.reflectanceImag[dispersionIndex], ZERO3));
        
        // Apply absorption effect
    lighting.transmittanceImag[dispersionIndex] *= max(exp(-mat.absorptionCoefficient *
            lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM), ZERO3);
        
        
        // Apply coherence corrections
    lighting.transmittanceImag[dispersionIndex] *=
            max(CoherenceFactor(lighting.opdAlbedoTransImagChannel[dispersionIndex].opticalMeasurement.PathLengthM,
                mat.coherenceLengthM.real
        ), ZERO3);

        // Apply refractive index correction
    lighting.transmittanceImag[dispersionIndex] *= max(EffectiveRefractiveIndexCorrection(
            lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex], mat.opticalAxis.real
        ), ZERO3);
        
        
        
        // Calculate interference intensity
    lighting.interferenceIntensity[dispersionIndex] = max(CDot(
            lighting.totalReflectanceComplex[dispersionIndex],
            lighting.totalReflectanceComplex[dispersionIndex]
        ).real, ZERO3);

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
            mat.opticalAxis.real,
            lighting.reflectanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex].refractiveIndex
        );
        
        
    lighting.effectiveRefractiveIndexReflectImag[dispersionIndex] = CalculateEffectiveRefractiveIndexReflectReal(
            lighting.lightDir,
            mat.opticalAxis.real,
            lighting.reflectanceImag[dispersionIndex],
            lighting.opdAlbedoTransImagChannel[dispersionIndex].refractiveIndex
        );
      
        
    lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex] = CalculateEffectiveRefractiveIndexTransmitReal(
            lighting.lightDir,
            mat.opticalAxis.real,
            lighting.transmittanceReal[dispersionIndex],
            lighting.opdAlbedoTransRealChannel[dispersionIndex].refractiveIndex
        );
        
        
    lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex] = CalculateEffectiveRefractiveIndexTransmitReal(
            lighting.lightDir,
            mat.opticalAxis.real,
            lighting.transmittanceImag[dispersionIndex],
            lighting.opdAlbedoTransImagChannel[dispersionIndex].refractiveIndex
        );
      
        
    lighting.reflectanceReal[dispersionIndex] *= EffectiveRefractiveIndexCorrection(lighting.effectiveRefractiveIndexReflectReal[dispersionIndex], mat.opticalAxis.real);
        
    lighting.transmittanceReal[dispersionIndex] *= EffectiveRefractiveIndexCorrection(lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], mat.opticalAxis.real);

        // Depth calculations
    lighting.depth = depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth);
    
    C3 diffuseTransmit = MicrofacetBRDF1(CV(mat.albedo, ZERO3), CV0((lighting.interferenceColor)),
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
              invertDepth, useProjectedDepth,
                lighting.nSurrounding, CV(
                    lighting.effectiveRefractiveIndexTransmitReal[dispersionIndex], lighting.effectiveRefractiveIndexTransmitImag[dispersionIndex]
            ), length(mToNm(mat.thicknessM).real),
            mat.dispersionCoefficientsNm2[dispersionIndex],
          mat.roughness, mat.roughness, dispersionIndex, sssStrength
        );
    lighting.diffuseRealTransmit[dispersionIndex] = diffuseTransmit.real;

    lighting.diffuseImagTransmit[dispersionIndex] = diffuseTransmit.imag;
    C3 c = CV0(lighting.interferenceColor);
    C3 diffuseReflect = MicrofacetBRDF1(CV((mat.albedo), ZERO3), c,
            mat, inputUV, time, lighting.microfacetSpecularTerm, lighting.normal, lighting.viewDir, lighting.lightDir,
            invertDepth, useProjectedDepth, lighting.nSurrounding, CV(lighting.effectiveRefractiveIndexReflectReal[dispersionIndex],
                lighting.effectiveRefractiveIndexReflectImag[dispersionIndex]
            ), length(mToNm(mat.thicknessM).real),
            mat.dispersionCoefficientsNm2[dispersionIndex],
            mat.roughness, mat.roughness, dispersionIndex, sssStrength
        );
    lighting.diffuseRealReflect[dispersionIndex] = diffuseReflect.real;

    lighting.diffuseImagReflect[dispersionIndex] = diffuseReflect.imag;
    
    // Initialize accumulated lighting
    lighting.lightingR = mat.albedo * saturate(lighting.NdotV3) + diffuseReflect.real + lighting.diffuseRealTransmit[dispersionIndex] + lighting.transmittanceReal[dispersionIndex] + lighting.reflectanceReal[dispersionIndex] + lighting.diffuseRealReflect[dispersionIndex];
    
    lighting.lightingI = mat.albedo * saturate(lighting.NdotV3) + diffuseReflect.imag + lighting.diffuseImagTransmit[dispersionIndex] + lighting.transmittanceImag[dispersionIndex] + lighting.reflectanceImag[dispersionIndex] + lighting.diffuseImagReflect[dispersionIndex];
    
    lighting.lighting = mat.albedo * saturate(lighting.NdotV3) + lighting.lightingR + lighting.lightingI;
    
        
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
    lighting.albedoWavelengthsNM = RGBToWavelengthsNMf(lighting.albedo);
    lighting.albedoWavelengthsM = nmToMf(lighting.albedoWavelengthsNM);

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
        
    float diffuseWeight = PhaseOffsetR;
    float specularWeight = PhaseOffsetG;
    float interferenceWeight = PhaseOffsetB;
    
    float3 accumulatedLighting = ZERO3;
        
        // Apply a rainbow-like gradient based on dispersion
    float3 rainbowGradient = float3(
            saturate(lighting.albedo.r * 0.8 + sin(dispersionIndex * 2.0 + time)),
            saturate(lighting.albedo.g * 0.8 + sin(dispersionIndex * 2.0 + time * 1.1)),
            saturate(lighting.albedo.b * 0.8 + sin(dispersionIndex * 2.0 + time * 1.2))
        ) * gradientWeight;
    float2 anisotropicFactors = float2(f1, f2); // Controls anisotropic shape
    float anisotropicDot = saturate(dot(lighting.normal, lighting.lightDir) * anisotropicFactors.x + saturate(dot(CalcTBN3(depthMap, inputUV, invertDepth, useProjectedDepth).tangent.real, lighting.lightDir * anisotropicFactors.y)));
    float3 anisotropicHighlight = specularWeight * pow(anisotropicDot, mat.roughness * 128.0);
    lighting.lightingR += anisotropicHighlight;
    lighting.diffuseRealTransmit[dispersionIndex] += anisotropicHighlight * diffuseWeight;
    lighting.interferenceColor += anisotropicHighlight;
        
    lighting.diffuseRealTransmit[dispersionIndex] += rainbowGradient * diffuseWeight;
    lighting.interferenceColor += rainbowGradient;
    lighting.lightingR += rainbowGradient;
        
    float3 fresnel = pow(1.0 - abs(lighting.NdotV3), 3.0);
    float3 fresnelGlow = fresnel * float3(0.3, 0.6, 1.0) * fresnelGlowWeight; // Blue glow
    lighting.lightingR += fresnelGlow;
    lighting.diffuseRealTransmit[dispersionIndex] += fresnelGlow * diffuseWeight;
    lighting.interferenceColor += fresnelGlow;

// Apply Fractal Noise Glow
    float3 fractalColor = float3(1.0, 0.6, 0.3) * fractalColorWeight; // Orange glow
    lighting.lightingR += fractalColor;
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
    lighting.lightingR += auroraColor;
    lighting.diffuseRealTransmit[dispersionIndex] += auroraColor * diffuseWeight;
    lighting.interferenceColor += auroraColor;
        // Depth-Based Subsurface Effect
    float scatterFactor = saturate(1.0 - lighting.depth); // More scattering for closer surfaces
    float3 subsurfaceColor = float3(ct01, 0.8, 0.6) * scatterFactor; // Warm diffusion color

// Add wavelength variation
    subsurfaceColor *= float3(1.0 + 0.1 * sin(lighting.depth), 1.0, 1.0 - 0.1 * sin(lighting.depth)); // Shift based on depth
    subsurfaceColor *= subsurfaceColorWeight;
        
// Apply to lighting
    lighting.lightingR += subsurfaceColor;
    lighting.diffuseRealTransmit[dispersionIndex] += subsurfaceColor * diffuseWeight;
    lighting.interferenceColor += subsurfaceColor;
        
        // Caustic Pattern with Depth
    float causticPattern = abs(sin(inputUV.x * 20.0 + lighting.depth * 5.0 + time * 2.0));
    float causticDepthFactor = 0.1 * saturate(1.0 - lighting.depth);

        // Wavelength-Dependent Caustics
    float3 causticColor =
        causticPattern * pow(lighting.albedoWavelengthsNM / RGB_WAVELENGTHS_NM, -2.0);
        

        // Modulate with Depth
    causticColor *= causticDepthFactor;
    causticColor *= causticColorWeight;
        
        // Add to Lighting
    lighting.lightingR += causticColor;
    lighting.diffuseRealTransmit[dispersionIndex] += causticColor * diffuseWeight;
    lighting.interferenceColor += causticColor;
        
        
    accumulatedLighting +=
                diffuseWeight * lighting.diffuseRealTransmit[dispersionIndex] +
            lighting.diffuseRealReflect[dispersionIndex] +
            +specularWeight * lighting.specularReflectanceResult +
            lighting.interferenceIntensity[dispersionIndex] * lighting.albedo;
        
    lighting.lightingR += accumulatedLighting; // Average contributions
        // Add Fresnel reflectance to diffuse and interference contributions
        
    lighting.lightingR += lighting.fresnelReflectance * lighting.CookTorrenceSpecular;

    float totalParallaxWeight = max(ParallaxFactorA + ParallaxFactorB + ParallaxFactorC, EPSILON);
    lighting.lightingR += (
        (lighting.specularLighting * ParallaxFactorA / totalParallaxWeight) +
        (lighting.diffuseContribution[dispersionIndex] * ParallaxFactorB / totalParallaxWeight) +
        (lighting.interferenceColor * ParallaxFactorC / totalParallaxWeight)
    );
    
    float3 totalLighting = lighting.lightingR + lighting.lightingI;
    totalLighting += RedistributeExcessEnergy(totalLighting, lighting.diffuseContribution[dispersionIndex], lighting.specularLighting);
    lighting.lighting = saturate(totalLighting);
        
    totalEnergy = lighting.lightingR + lighting.lightingI;
    lighting.lightingR /= max(dot(totalEnergy, ONE3), EPSILON3);
    lighting.lightingI /= max(dot(totalEnergy, ONE3), EPSILON3);

        
        
        // Apply tone mapping and gamma adjustments
    totalLighting = ReinhardToneMapping(totalLighting * lighting.Config_Exposure * 2.0);
    totalLighting = CAbs(AdjustGamma(CV0(totalLighting), lighting.Config_Gamma)).real;
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
        chromaticOffset[i] = sin(float2(time + i * 2.00, time - i * 2.0)) * 0.01 * (i + 1);
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
    
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(CV0(lighting.albedo)).real;
    lighting.albedoWavelengthsM = nmToM(CV0(lighting.albedoWavelengthsNM)).real;

}

C3 ChromaticInterference(float chromaPower, float time, int dispersionIndex, LightingComplex lighting)
{
    // Compute time-dependent interference based on the stored phaseShift for the given channel.
    float3 phaseShift = CSatMag(lighting.phaseShift[dispersionIndex]).real;
    C3 chromaticInterference = CV(
        float3(
            cos(phaseShift[0] * chromaPower + time) * 0.5 + 0.5,
            cos(phaseShift[1] * chromaPower + time * 1.01) * 0.5 + 0.5,
            cos(phaseShift[2] * chromaPower + time * 1.03) * 0.5 + 0.5
        ),
        float3(
            sin(phaseShift[0] * chromaPower + time * 1.9135) * 0.5 + 0.5,
            sin(phaseShift[1] * chromaPower + time * 1.9125) * 0.5 + 0.5,
            sin(phaseShift[2] * chromaPower + time * 1.9115) * 0.5 + 0.5
        )
    );
    return chromaticInterference;
}



float3 GradientEffects(float highlightWeight, float time, int dispersionIndex, LightingComplex lighting)
{
    float3 anisotropicHighlight = pow(lighting.NdotL3, lighting.material.roughness * 128.0);

    // Apply a rainbow-like gradient based on dispersion
    float3 rainbowGradient = float3(
        saturate(lighting.albedo.r * 0.8 + sin((1.0 + dispersionIndex) * 2.0 + time)),
        saturate(lighting.albedo.g * 0.8 + sin((1.0 + dispersionIndex) * 2.0 + time * 1.1)),
        saturate(lighting.albedo.b * 0.8 + sin((1.0 + dispersionIndex) * 2.0 + time * 1.2))
    );

   
    return (rainbowGradient + anisotropicHighlight) * highlightWeight;

}
float3 FractalAurora(float auroraColorWeight, float2 inputUV, float time, uint dispersionIndex, LightingComplex lighting)
{
    // Aurora Parameters
    float horizontalFlowScale = 20.0; // Controls horizontal wave flow
    float verticalFadeScale = 1.0; // Minimizes vertical influence
    float waveSpeed = 0.3; // Speed of aurora motion
    float turbulenceStrength = 0.5; // Adds randomness to break repetition
    float intensityBoost = 2.0; // Overall brightness boost
    float fadeEdgeStrength = 3.0; // Softens edges to reduce harsh lines
    float layerOverlap = 0.7; // Controls overlap intensity of layers

    // Aurora Colors
    float3 auroraGreen = float3(0.3, 0.9, 0.4); // Dominant Green
    float3 auroraRed = float3(0.8, 0.3, 0.4); // High-altitude Red
    float3 auroraBlue = float3(0.2, 0.4, 1.0); // Low-altitude Blue
    float3 auroraPurple = float3(0.5, 0.3, 0.8); // Subtle Purple for variation

    // Initialize aurora color
    float3 auroraColor = float3(0.0, 0.0, 0.0);

    // Loop through multiple overlapping layers for depth
    for (uint i = 0; i < 6; ++i)
    {
        // Layer-specific parameters for variation
        float layerSpeed = waveSpeed + i * 0.05; // Different speeds per layer
        float layerWidth = 0.4 + i * 0.1; // Slightly wider patterns
        float layerIntensity = 0.6 + i * 0.15; // Slightly brighter for higher layers
        float layerOffset = float(i) * 0.2; // Randomized offset for each layer

        // Horizontal Flow (Auroras cascade left-to-right)
        float horizontalWave = sin((inputUV.x * horizontalFlowScale + time * layerSpeed + layerOffset));

        // Vertical Fade (Auroras originate at the top and fade downward)
        float verticalFade = exp(-inputUV.y * verticalFadeScale);

        // Add Random Turbulence for Natural Variation
        float turbulence = sin(inputUV.x * 15.0 + inputUV.y * 15.0 + time * turbulenceStrength + layerOffset) * 0.3;

        // Combine Patterns for Layer Dynamics
        float dynamicPattern = horizontalWave * verticalFade + turbulence;

        // Smooth Out Edges
        float softenedPattern = smoothstep(0.1, 0.7, dynamicPattern) * exp(-pow(dynamicPattern, 2.0) * fadeEdgeStrength);

        // Dynamic Color Blending for Each Layer
        float3 layerColor = lerp(auroraGreen, auroraRed, frac(time * 0.1 + i * 0.3));
        layerColor = lerp(layerColor, auroraBlue, smoothstep(0.4, 0.8, frac(inputUV.y + i * 0.2)));
        layerColor = lerp(layerColor, auroraPurple, smoothstep(0.5, 1.0, frac(inputUV.x + time * 0.15)));

        // Combine Layer Color and Intensity
        auroraColor += layerColor * softenedPattern * layerIntensity * layerOverlap;
    }

    // Normalize and Adjust Brightness
    auroraColor = auroraColor / (1.0 + auroraColor);
    auroraColor *= intensityBoost * auroraColorWeight;

    // Clamp Final Color
    return saturate(auroraColor);
}






float3 ScatterCaustics(float causticColorWeight, float subsurfaceColorWeight, float diffuseWeight, float2 inputUV, float time, int dispersionIndex, inout LightingComplex lighting)
{
    // Depth-Based Subsurface Scattering
    float scatterFactor = saturate(1.0 - lighting.depth); // More scattering for closer surfaces
    float3 subsurfaceColor = float3(ct01, 0.8, 0.6) * scatterFactor; // Warm diffusion color

    // Wavelength variation for depth
    subsurfaceColor *= float3(1.0 + 0.1 * sin(lighting.depth), 1.0, 1.0 - 0.1 * sin(lighting.depth));
    subsurfaceColor *= subsurfaceColorWeight;

  
    // Depth-Based Caustics
    float causticPattern = abs(sin(inputUV.x * 20.0 + lighting.depth * 5.0 + time * 2.0));
    float causticDepthFactor = saturate(lighting.depth);

// Wavelength-Dependent Caustics
    float3 causticColor =
        causticPattern * pow(lighting.albedoWavelengthsNM / RGB_WAVELENGTHS_NM, -2.0);
    

// Modulate with Depth
    causticColor *= causticDepthFactor;
    causticColor *= causticColorWeight;

    return causticColor + subsurfaceColor;

}

C3 ComplexMultiLayerReflection(
    C3 ior[3],
    float thicknessM[3],
    float3 cosTheta,
    float lambda,
    int layerCount
)
{
    C3 rTot = C00;
    C3 oneC = C10;
    C3 accum = oneC;

    for (int i = 0; i < layerCount; i++)
    {
        // Multiply ior[i] by (cosTheta, 0)
        C3 top = ComplexSub(
            CMul(ior[i], CV0(cosTheta)),
            oneC
        );

        C3 bot = CAdd(
            CMul(ior[i], CV0(cosTheta)),
            oneC
        );

        C3 r = CDiv(top, bot);

        // phase is a float3 => (2*pi*n*d / lambda)
        float3 phase = 6.2831853 * ior[i].real * thicknessM[i] / lambda;

        // Create the complex exponent (0 + i * phase)
        C3 ePh = C0V(0);

        // Exponentiate
        ePh = CExp(ePh);

        // Multiply accum by r
        C3 term = CMul(accum, r);
        rTot = CAdd(rTot, term);

        // accum *= ePh for next iteration
        accum = CMul(accum, ePh);
    }

    return rTot;
}


float3 MicrofacetNLobe(float3 NoH, float roughness, int lobes)
{
    float a2 = roughness * roughness;
    float3 cos2 = NoH * NoH;
    float3 r = float3(0.0, 0.0, 0.0);
    // Loop over the lobe count and accumulate a per-channel weight.
    for (int i = 0; i < lobes; i++)
    {
        // Since 'i' is scalar, multiplying it by (1.0 - cos2) gives a float3.
        float3 f = exp(-i * (1.0 - cos2) / (a2 + 1e-6))
                   / max(float3(3.14159 * (a2 + 0.001) * cos2 * cos2), float3(1e-6, 1e-6, 1e-6));
        r += f;
    }
    return r;
}

// C3 version of MicrofacetNLobe: all math is performed in the complex domain.
C3 MicrofacetNLobe_Complex(C3 NoH, float roughness, int lobes)
{
    // Square of roughness
    float a2 = roughness * roughness;
    
    // Compute cos² as a complex number (each channel computed separately)
    C3 cos2 = CMul(NoH, NoH);
    
    // Initialize the accumulation to zero (a C3 with zero real and imaginary parts)
    C3 sumR = CV(float3(0, 0, 0), float3(0, 0, 0));
    
    // Set a small epsilon to avoid division by zero.
    float epsilon = 1e-6;
    
    // Precompute a scalar factor for the denominator.
    float scalarDenom = 3.14159 * (a2 + 0.001);
    
    // Loop over each lobe
    for (int i = 0; i < lobes; i++)
    {
        // Compute (1 - cos2) in the complex domain.
        C3 one = CV(float3(1, 1, 1), float3(0, 0, 0));
        C3 diff = ComplexSub(one, cos2);
        
        // Scale factor: -i / (a2 + epsilon)
        float scale = -float(i) / (a2 + epsilon);
        
        // Scale the difference to form the exponent.
        C3 exponent = ComplexScale(diff, scale);
        
        // Compute the complex exponential.
        C3 expVal = CExp(exponent);
        
        // Compute the denominator using the magnitude squared of cos2.
        // (Since the original denominator was: 3.14159*(a2+0.001)*cos2*cos2)
        float3 cos2Mag = CAbs(cos2).real;
        float3 denom = max(scalarDenom * (cos2Mag * cos2Mag), float3(epsilon, epsilon, epsilon));
        
        // Represent the denominator as a complex number (zero imaginary part)
        C3 denomComplex = CV(denom, float3(0, 0, 0));
        
        // Divide expVal by the denominator.
        C3 f = CDiv(expVal, denomComplex);
        
        // Accumulate the result.
        sumR = CAdd(sumR, f);
    }
    
    return sumR;
}


// 3) Polarization shift
C3 ComplexPolarize(C3 z, float3 deltaPhase)
{
    C3 shift = C0V(deltaPhase);
    shift = CExp(shift);
    return CMul(z, shift);
}

// 4) Rayleigh-Gans scattering amplitude
C3 ComplexRayleighGans(C3 ior, float radius, float3 k)
{
    float3 kr = k * radius;
    C3 iork = CMul(ior, CV0(kr));
    return ComplexSub(CExp(iork), C10);
}

// 5) Chromatic dispersion compensation
C3 ComplexDispersionComp(C3 signal, C3 dispersion, float distance)
{
    C3 phi = CMul(dispersion, CV0(distance));
    phi = CExp(phi);
    return CMul(signal, phi);
}

// 6) Coherent multiple scattering with phase
C3 ComplexCoherentScatter(C3 baseAmp, float3 scatterPhases[NUM_SCATTER_PHASES])
{
    C3 accum = C00;
    for (int i = 0; i < NUM_SCATTER_PHASES; i++)
    {
        C3 ph = C0V(scatterPhases[i]);
        ph = CExp(ph);
        accum = CAdd(accum, CMul(baseAmp, ph));
    }
    return accum;
}

// 7) Kramers-Kronig phase retrieval
C3 ComplexKramersKronig(C3 amplitude, float3 freq, float refFreq)
{
    float3 diff = freq - refFreq;
    C3 lnAmp = ComplexLog(amplitude);
    float3 shift = lnAmp.real + diff * 0.001; // example shift
    C3 r;
    r.real = shift;
    r.imag = lnAmp.imag;
    return CExp(r);
}
// 8) Complex reflect/transmit solver
void ComplexReflectTransmit(C3 iorInc, C3 iorTrn, float3 cosI, out C3 R, out C3 T)
{
    C3 cosC = CV0(cosI);
    C3 numR = CSub(CMul(iorInc, cosC), iorTrn);
    C3 denR = CAdd(CMul(iorInc, cosC), iorTrn);
    R = CDiv(numR, denR);
    C3 numT = CMul(CMul(CV0(2), iorInc), cosC);
    T = CDiv(numT, denR);
}

// 9) Multi-lobe reflection with phase
C3 ComplexPhaseReflect(C3 ior, C3 cosTheta, float roughness, int lobes)
{
    C3 sumR = C00;
    for (int i = 0; i < lobes; i++)
    {
        C3 factor = MicrofacetNLobe_Complex(cosTheta, roughness, lobes);
        C3 top = ComplexSub(CMul(ior, cosTheta), C10);
        C3 bot = CAdd(CMul(ior, cosTheta), C10);
        C3 r = CDiv(top, bot);
        C3 ph = C0V(float3(i * 0.2, i * 0.2, i * 0.2));
        r = CMul(r, CExp(ph));
        sumR = CAdd(sumR, CMul(factor, r));
    }
    return sumR;
}

// 10) Complex wave transport
C3 ComplexTransport(C3 field, float distance, C3 attenuation)
{
    C3 shift = CMul(attenuation, CV0(distance));
    shift = CExp(shift);
    return CMul(field, shift);
}

// Example: 
// field.real = (Rr, Gr, Br), field.imag = (Ri, Gi, Bi)
// diffractionTensor is a float4x4
// waveDir is a float3 direction (normalized)

C3 ComplexTensorDiffraction(C3 field, float4x4 diffractionTensor, float3 waveDir)
{
    // Convert field.real into a 4D homogeneous vector
    float4 realVec = float4(field.real, 1.0);
    float4 imagVec = float4(field.imag, 1.0);

    // Transform them via the 4x4 tensor
    float4 newReal4 = mul(diffractionTensor, realVec);
    float4 newImag4 = mul(diffractionTensor, imagVec);

    // Discard w or keep it if desired
    float3 newReal = newReal4.xyz;
    float3 newImag = newImag4.xyz;

    // Minor amplitude modulation by waveDir
    // e.g., scale by dot(waveDir, (0.577,0.577,0.577)) or any other approach
    float scale = dot(waveDir, safeNormalizef(float3(0.577, 0.577, 0.577)));
    newReal *= scale;
    newImag *= scale;

    // Return updated complex wave
    C3 outField;
    outField.real = newReal;
    outField.imag = newImag;
    return outField;
}
// baseField: existing wave amplitude (real, imag)
// uv: surface coordinates
// time: global or local time
// hologramStrength: scale factor for the holographic pattern

C3 ComplexHolographicInterference(
    C3 baseField,
    float2 uv,
    float time,
    float hologramStrength
)
{
    // Example: create a 2D fringe pattern
    float2 fringe = sin(float2(uv.x * 5.0 + time, uv.y * 5.0 - time));

    // We'll add separate offsets to real & imag
    // This is purely illustrative; feel free to expand or refine
    float3 realOffset = float3(fringe.x * hologramStrength, 0, fringe.y * hologramStrength);
    float3 imagOffset = float3(0, fringe.y * hologramStrength, fringe.x * hologramStrength);

    // Combine with base wave
    C3 outField;
    outField.real = baseField.real + realOffset;
    outField.imag = baseField.imag + imagOffset;

    // Additional subtle shape
    // e.g., modulate the amplitude by a small cos wave
    float modAmt = cos(uv.x * 2.0 + uv.y * 1.5 + time);
    outField.real *= 1.0 + 0.1 * modAmt;
    outField.imag *= 1.0 + 0.1 * modAmt;

    return outField;
}

// baseField: initial C3 wave (real, imag) for R/G/B
// uv: texture coordinates
// time: global time
// principalAxis: axis in uv-space that sets the birefringence direction
// retardation: factor controlling phase shift differences
// scaleStrength: overall intensity for the effect

C3 ComplexBirefringentInterference(
    C3 baseField,
    float2 uv,
    float time,
    float2 principalAxis,
    float3 retardation,
    float scaleStrength
)
{
    // 1) Compute orientation along principalAxis vs. perpendicular
    float alongAxis = dot(uv, principalAxis);
    float perpAxis = dot(uv, float2(-principalAxis.y, principalAxis.x)); // orth axis

    // 2) Phase modifications: each color might get different extra phase offset
    //    based on the two directions (like ordinary & extraordinary rays).
    float3 extraPhaseOrd = float3(alongAxis + time, alongAxis - time, alongAxis * 1.5 + time);
    float3 extraPhaseExt = float3(perpAxis - time, perpAxis * 1.2 + time, -perpAxis);

    // 3) Compute partial wave expansions
    float3 cosOrd = cos(extraPhaseOrd * retardation);
    float3 sinOrd = sin(extraPhaseOrd * retardation);
    float3 cosExt = cos(extraPhaseExt * retardation);
    float3 sinExt = sin(extraPhaseExt * retardation);

    // 4) Weighted blend for real/imag
    //    We interpret baseField.real, baseField.imag each as (R, G, B).
    //    Then combine them with the new partial waves.
    C3 outField;
    outField.real =
        baseField.real + cosOrd * scaleStrength - sinExt * (scaleStrength * 0.5);
    outField.imag =
        baseField.imag + sinOrd * scaleStrength + cosExt * (scaleStrength * 0.5);

    return outField;
}
// baseField: incoming wave amplitude
// uv: texture coordinates
// time: global time
// metasurfacePhase: base phase offset for plasmonic oscillations
// nanoPatternFreq: frequency of sub-wavelength pattern
// metallicity: influences how strongly the field is absorbed and re-emitted
// swirlFactor: adds swirl/hue shift to real & imag

C3 ComplexMetasurfacePlasmonics(
    C3 baseField,
    float2 uv,
    float time,
    float metasurfacePhase,
    float3 nanoPatternFreq,
    float metallicity,
    float swirlFactor
)
{
    // 1) Sub-wavelength pattern in uv
    float3 patternPhase = float3(
        uv.x * nanoPatternFreq.r + time,
        uv.y * nanoPatternFreq.g - time * 0.5,
        (uv.x + uv.y) * nanoPatternFreq.b + time * 1.5
    );

    float3 cosPat = cos(patternPhase + metasurfacePhase);
    float3 sinPat = sin(patternPhase - metasurfacePhase);

    // 2) Metallic amplitude boost: 
    //    high metallicity -> stronger reflection-like intensification
    float3 metallicBoost = lerp(float3(1, 1, 1), float3(1.5, 1.5, 1.5), metallicity);

    // 3) Construct plasmonic swirl
    //    swirlFactor rotates R/G/B channels in real & imag
    float3 swirl = float3(
        sinPat.r * swirlFactor + cosPat.g * swirlFactor * 0.5,
        cosPat.b * swirlFactor - sinPat.r * swirlFactor * 0.5,
        sinPat.g * swirlFactor + cosPat.r * swirlFactor * 0.3
    );

    // 4) Combine with base wave
    C3 outField;
    // Real part picks up metallic boost plus swirl
    outField.real = baseField.real * metallicBoost + swirl;

    // Imag part is modulated by sub-wavelength patterns 
    // with a partial swirl offset
    outField.imag = baseField.imag + (sinPat * swirlFactor * 0.5) + (cosPat * swirlFactor * 0.3);

    return outField;
}


// Helper function for radial blur based on frequency content (simple example)
float3 ApplyFourierEffect(float2 uv, float3 color, Texture2D renderedImage)
{
    float3 lowFreq = GaussianBlur(renderedImage, uv, 5.0, GetOosz(renderedImage)); // Use GaussianBlur or another blur function
    float3 highFreq = color - lowFreq;

    float blurAmount = length(highFreq) * 0.1; // Adjust the blur amount based on high-frequency content

    float2 blurDir = safeNormalizef(uv - 0.5); // Radial blur direction (from center)
    float2 blurredUV = uv + blurDir * blurAmount;

    return diffuse2D(renderedImage, blurredUV).rgb;
}

// Helper function for Gaussian blur (simplified for this example)
float3 GaussianBlur(float2 uv, float3 color, float radius, Texture2D<float4> diffuseMap)
{
    float3 sum = float3(0.0, 0.0, 0.0);
    float weightSum = 0.0;

    for (float x = -radius; x <= radius; x += 1.0)
    {
        for (float y = -radius; y <= radius; y += 1.0)
        {
            float2 offset = float2(x, y);
            float weight = exp(-(dot(offset, offset) / (2.0 * radius * radius))); // Gaussian weight
            sum += weight * diffuse2D(diffuseMap, uv + offset * GetOosz(diffuseMap)).rgb; // Sample with offset, assuming you have TextureSize defined
            weightSum += weight;
        }
    }
    return sum / weightSum;
}

// Function to calculate the refractive index using the Sellmeier equation
float3 CalculateRefractiveIndex(C3 wavelengthNM, const SellmeierCoefficients coeffs)
{
    float3 wavelengthMicron = wavelengthNM.real * 1e-3; // Convert to microns
    float3 wavelengthSquared = wavelengthMicron * wavelengthMicron;

    float3 term = coeffs.OE1.O.B * wavelengthSquared / (wavelengthSquared - coeffs.OE1.O.C);
   
    float3 refractiveIndex = sqrt(1.0 + term);
    return refractiveIndex;
}

// Function to calculate the group velocity dispersion (GVD)
float3 CalculateGVD(MaterialSellmeier mat)
{
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(mat.albedo));
    
    float h = 1e-3; // Small increment for numerical differentiation
    float3 n1 = CalculateRefractiveIndex(CV0(wavelengthsNM.real - h), mat.coeff);
    float3 n2 = CalculateRefractiveIndex(CV0(wavelengthsNM.real + h), mat.coeff);

    // Numerical differentiation to approximate the second derivative of n with respect to lambda
    float3 d2n_dlambda2 = (n1 - 2.0 * CalculateRefractiveIndex(wavelengthsNM, mat.coeff) + n2) / (h * h);

    // Calculate GVD (in ps^2/km)
    float c = 299792458.0; // Speed of light in m/s
    float3 gvd = -(nmToM(wavelengthsNM).real) / (c * c) * (d2n_dlambda2 * 1e-3); // Convert lambda to meters, multiply by 1e-3 for ps^2/km

    return gvd;
}

// Function to calculate group delay
float3 CalculateGroupDelay(C3 wavelengthNM, float distanceM, const SellmeierCoefficients coeffs)
{
    float c = 299792458.0; // Speed of light in m/s
    float3 n = CalculateRefractiveIndex(wavelengthNM, coeffs);
    float3 vg = c / (n + wavelengthNM.real * 1e-9 * (CalculateRefractiveIndex(CV0(wavelengthNM.real + 1e-3), coeffs) - n) / 1e-3); // Group velocity
    return distanceM / vg;
}

// Function to calculate the phase velocity
float3 CalculatePhaseVelocity(C3 wavelengthNM, SellmeierCoefficients coeffs)
{
    float c = 299792458.0; // Speed of light in m/s
    float3 n = CalculateRefractiveIndex(wavelengthNM, coeffs);
    return c / n;
}

// Function to calculate the walk-off between two polarizations (simplified model)
float3 CalculateWalkOff(C3 wavelengthNM, float distanceM, float birefringence, const SellmeierCoefficients coeffs)
{
    float c = 299792458.0; // Speed of light in m/s
    float3 n_o = CalculateRefractiveIndex(wavelengthNM, coeffs);
    float3 n_e = n_o + birefringence; // Approximate extraordinary refractive index

    float3 groupDelay_o = distanceM / (c / n_o);
    float3 groupDelay_e = distanceM / (c / n_e);

    return abs(groupDelay_e - groupDelay_o); // Return the absolute difference in group delays
}

// Function to calculate the absorption coefficient based on wavelength and Sellmeier coefficients
float3 CalculateAbsorption(MaterialSellmeier mat)
{
    // Example absorption calculation based on the imaginary part of the refractive index
    // This is a SIMPLIFIED model and might not be accurate for all materials

    // 1. Calculate the complex refractive index using the Sellmeier equation
    //    We'll use a simplified approach here and assume the imaginary part is small
    //    In reality, you might need a more complex model for the imaginary part
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(mat.albedo));
    
    float3 n_real = CalculateRefractiveIndex(wavelengthsNM, mat.coeff); // Calculate the real part

    // 2. Estimate the imaginary part of the refractive index (k)
    //    This is a very rough approximation. You might need to use experimental data or
    //    a more sophisticated model for the imaginary part based on your material
    
    float3 k = 0.001 * exp(-wavelengthsNM.real / 100.0); // Example: Exponential decay with wavelength
    // This is just an example. Replace this with a more accurate model if you have one.
    // For instance, you might have a table of k values for different wavelengths
    // and interpolate between them.

    // 3. Calculate the absorption coefficient (alpha) from k
    //    alpha = 4 * pi * k / lambda
    float3 alpha = (4.0 * PI * k) / nmToM(wavelengthsNM).real; // Convert wavelength to meters

    return alpha;
}

// --- Function for Basic Sheen Calculation ---
float3 CalculateBasicSheen(float3 normal, float3 lightDir, float3 viewDir, float roughness, float3 sheenAlbedoTint)
{
    // Compute the half vector
    float3 halfDir = safeNormalizef(lightDir + viewDir);

    // Dot products
    float NdotH = saturate(dot(normal, halfDir));
    float LdotH = saturate(dot(lightDir, halfDir));

    // Adjust roughness for wider sheen
    float sheenRoughness = roughness * SHEEN_ROUGHNESS_MULTIPLIER;

    // GGX microfacet distribution for sheen
    float sheenDistribution = DistributionGGX(NdotH, sheenRoughness);

    // Fresnel term (Schlick's approximation)
    float sheenFresnel = 0.04 + (1.0 - 0.04) * pow(1.0 - LdotH, 5.0); // More realistic Fresnel

    // Combine sheen components
    return sheenAlbedoTint * sheenDistribution * sheenFresnel;
}

// --- Anisotropic GGX Distribution Function ---
float AnisotropicDistributionGGX(float NdotH, float dotHX, float dotHY, float roughnessLong, float roughnessShort)
{
    float a2 = roughnessLong * roughnessShort;
    float3 V = float3(roughnessShort * dotHX, roughnessLong * dotHY, a2 * NdotH);
    float vDotH2 = saturate(dot(V, V));
    float NdotH2 = NdotH * NdotH;
    float chi = (NdotH > 0.0) ? 1.0 : 0.0;
    return chi * a2 / (PI * vDotH2 * vDotH2);
}

// --- Function to calculate the tangent vector (simplified example) ---
float3 CalculateTangent(float3 normal)
{
    // Choose a fixed axis that is not collinear with the normal
    float3 up = abs(normal.y) < 0.9 ? float3(0.0, 1.0, 0.0) : float3(1.0, 0.0, 0.0);
    return safeNormalizef(cross(up, normal));
}
// --- Function for Advanced Sheen with Anisotropy ---
float3 CalculateAdvancedSheen(float3 normal, float3 lightDir, float3 viewDir, float3 tangent, float roughness, float3 sheenAlbedoTint)
{
    float3 halfDir = safeNormalizef(lightDir + viewDir);
    float NdotH = saturate(dot(normal, halfDir));
    float LdotH = saturate(dot(lightDir, halfDir));

    // Anisotropic GGX distribution for sheen
    float3 H = safeNormalizef(halfDir);
    float3 X = safeNormalizef(tangent);
    float3 Y = cross(normal, tangent);
    float dotHX = saturate(dot(H, X));
    float dotHY = saturate(dot(H, Y));
    float aniso = ADVANCED_SHEEN_ANISOTROPY;
    float roughnessLong = roughness * (1.0 + aniso);
    float roughnessShort = roughness * (1.0 - aniso);
    float D = AnisotropicDistributionGGX(NdotH, dotHX, dotHY, roughnessLong, roughnessShort);

    // Fresnel term
    float F = pow(1.0 - LdotH, ADVANCED_SHEEN_POWER);

    return sheenAlbedoTint * D * F;
}

// --- Function for Iridescence Effect ---
C3 CalculateIridescence(float3 normal, float3 viewDir, float3 lightDir, float3 baseColor)
{
    float NdotV = max(0, dot(normalize(normal + EPSILON3), normalize(viewDir + EPSILON3)));
    float NdotL = max(0, dot(normalize(normal + EPSILON3), normalize(lightDir + EPSILON3)));

    // Calculate the path difference based on the incident angle and film thickness
    float cosThetaI = NdotL * NdotV; // Simplified for performance
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = sinThetaI / IRIDESCENCE_IOR;
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    float pathDifference = 2.0 * IRIDESCENCE_THICKNESS * IRIDESCENCE_IOR * cosThetaT;

    // Convert path difference to phase shift for different wavelengths (simplified)
    C3 wavelengths = RGBToWavelengthsNM(CV0(baseColor)); // Example wavelengths: Red, Green, Blue
    C3 phaseShift = CDiv(CV0(2.0 * PI * pathDifference), wavelengths);

    // Calculate interference factor for each wavelength
    return phaseShift;
}

// --- Function for Clear Coat Fresnel ---
float3 ClearCoatFresnel(float3 NdotV)
{
    // Simplified Schlick Fresnel approximation for the clear coat layer
    return 0.04 + (1.0 - 0.04) * pow(1.0 - NdotV, 5.0);
}
// Calculate the polarization vector (simplified example)
float3 CalculatePolarizationVector(float3 lightDir, float3 normal)
{
    // Assume the polarization vector is perpendicular to both the light direction and the surface normal
    float3 polarization = cross(lightDir, normal);
    return safeNormalizef(polarization);
}

// Calculate the reflected and transmitted polarization components
// based on the angle of incidence and the polarization state of the incident light
// (simplified example using Fresnel equations for unpolarized light)
C3 CalculateReflectedTransmittedPolarization(float3 n1, float3 n2, float3 normal, float3 cosTheta_i, float3 cosTheta_t)
{
    // float3 n1 = nSurrounding;
    // float3 n2 = etaR_wavelength;
    // float3 cosTheta_i = lighting.NdotL3;
    // float3 cosTheta_t = lighting.cosThetaTransmissionInside.real;

    // Fresnel reflectance for perpendicular polarization
    float3 R_perpendicular = (n1 * cosTheta_i - n2 * cosTheta_t) / (n1 * cosTheta_i + n2 * cosTheta_t);
    R_perpendicular = R_perpendicular * R_perpendicular;

    // Fresnel reflectance for parallel polarization
    float3 R_parallel = (n2 * cosTheta_i - n1 * cosTheta_t) / (n2 * cosTheta_i + n1 * cosTheta_t);
    R_parallel = R_parallel * R_parallel;

    // Assume unpolarized incident light, so average the two components
    float3 reflectance = 0.5 * (R_perpendicular + R_parallel);

    // Transmittance is 1 - reflectance (assuming no absorption)
    float3 transmittance = 1.0 - reflectance;

    return CV(reflectance, transmittance);
}
// ... (All your helper functions, including AnisotropicDistributionGGX, CalculateTangent, etc.)
C3 ComplexDiffractionGrating(C3 baseField, float2 uv, float time, float3 gratingFreq, float gratingStrength)
{
    float3 phaseShift = ONE3 * (uv.x * gratingFreq.r + uv.y * gratingFreq.g + time * gratingFreq.b);
    float3 cosPhase = cos(phaseShift);
    float3 sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real + cosPhase * gratingStrength;
    outField.imag = baseField.imag + sinPhase * gratingStrength;

    return outField;
}
C3 ComplexChromaticDispersion(C3 baseField, float2 uv, float time, float3 dispersionCoeff, float dispersionStrength)
{
    float3 dispersionPhase = dispersionCoeff * float3(uv.x, uv.y, uv.x + uv.y) * time;
    float3 cosPhase = cos(dispersionPhase);
    float3 sinPhase = sin(dispersionPhase);

    C3 outField;
    outField.real = baseField.real + cosPhase * dispersionStrength;
    outField.imag = baseField.imag + sinPhase * dispersionStrength;

    return outField;
}
C3 ComplexFresnelEffect(C3 baseField, float2 uv, float angleOfIncidence, float refractiveIndex, float fresnelStrength)
{
    float fresnelReflectance = pow((refractiveIndex - 1.0) / (refractiveIndex + 1.0), 2.0);
    float modulation = fresnelReflectance + (1.0 - fresnelReflectance) * pow(1.0 - cos(angleOfIncidence), 5.0);

    C3 outField;
    outField.real = baseField.real * (1.0 + fresnelStrength * modulation);
    outField.imag = baseField.imag * (1.0 + fresnelStrength * modulation);

    return outField;
}
C3 ComplexCaustics(C3 baseField, float2 uv, float time, float distortionStrength, float causticsStrength)
{
    float2 distortion = float2(sin(uv.x * 10.0 + time), cos(uv.y * 10.0 - time)) * distortionStrength;

    float3 phaseShift = float3(uv.x + distortion.x, uv.y + distortion.y, uv.x - uv.y);
    float3 cosPhase = cos(phaseShift);
    float3 sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real * (1.0 + causticsStrength * cosPhase);
    outField.imag = baseField.imag * (1.0 + causticsStrength * sinPhase);

    return outField;
}
C3 ComplexSpiralInterference(C3 baseField, float2 uv, float time, float spiralStrength, float frequency)
{
    float angle = atan2(uv.y - 0.5, uv.x - 0.5);
    float radius = length(uv - 0.5);

    float phaseShift = radius * frequency + angle * spiralStrength + time;
    float cosPhase = cos(phaseShift);
    float sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real + cosPhase * spiralStrength;
    outField.imag = baseField.imag + sinPhase * spiralStrength;

    return outField;
}
C3 ComplexPhaseGradient(C3 baseField, float2 uv, float2 gradientDir, float gradientStrength)
{
    float phaseShift = dot(uv, gradientDir) * gradientStrength;
    float cosPhase = cos(phaseShift);
    float sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real * cosPhase - baseField.imag * sinPhase;
    outField.imag = baseField.real * sinPhase + baseField.imag * cosPhase;

    return outField;
}
C3 ComplexAnisotropicInterference(C3 baseField, float2 uv, float time, float2 anisotropyDir, float anisotropyStrength)
{
    float alongDir = dot(uv, anisotropyDir);
    float perpDir = dot(uv, float2(-anisotropyDir.y, anisotropyDir.x));

    float3 phaseShift = float3(alongDir * anisotropyStrength + time, perpDir * anisotropyStrength - time, alongDir * perpDir * anisotropyStrength);
    float3 cosPhase = cos(phaseShift);
    float3 sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real + cosPhase * anisotropyStrength;
    outField.imag = baseField.imag + sinPhase * anisotropyStrength;

    return outField;
}

C3 ComplexQuantumWave(C3 initialField, float2 uv, float time,
                              float potentialStrength, float waveNumber, float diffusion)
{
    // Constants (note: these are extremely small, but scaled for GPU artistic effects)
    float hbar = 1.0545718e-34;
    float m = 9.10938356e-31;
    float k = waveNumber; // Wave number
    float omega = (k * k) / (2.0 * m); // Angular frequency

    // Time-dependent phase rotation
    float phase = -omega * time;
    float cosP = cos(phase);
    float sinP = sin(phase);

    // Rotate the complex field using the phase
    float3 rotatedReal = saturate(initialField.real) * cosP - saturate(initialField.imag) * sinP;
    float3 rotatedImag = saturate(initialField.real) * sinP + saturate(initialField.imag) * cosP;

    // Apply diffusion uniformly to both components
    float diffusionFactor = exp(-diffusion * (uv.x * uv.x + uv.y * uv.y));
    C3 outField;
    outField.real = rotatedReal * diffusionFactor;
    outField.imag = rotatedImag * diffusionFactor;

    // Simulate potential influence by adding a small offset (creative, non-physical twist)
    outField.real += float3(saturate(potentialStrength * cos(time)), 0.0, 0.0);

    return outField;
}

C3 ComplexThinFilmInterference(C3 baseField, float2 uv, float time,
                                float3 layerThicknesses, float3 refractiveIndices,
                                float3 absorptionCoefficients, C3 wavelengthNM)
{
    // Speed of light constant.
    float c = SPEED_OF_LIGHT;

    // Convert wavelength (in nm) to Hz. (Assumes nmToHz1 returns a C3.)
    // Use the real part and clamp with EPSILON.
    float3 frequency = c / max(nmToHz(wavelengthNM).real, EPSILON);

    // Calculate the optical path per layer.
    float3 opticalPath = layerThicknesses * refractiveIndices;
    
    // Compute phase shifts per layer:
    // phaseShifts = (2π / wavelength) * opticalPath
    // Replace 3.14159265 with PI.
    float3 phaseShifts = (2.0 * PI / max(wavelengthNM.real, EPSILON)) * opticalPath;

    // Compute amplitude attenuation due to absorption.
    float3 absorptionFactors = exp(-absorptionCoefficients * layerThicknesses);

    // Compute cosine and sine for the phase shifts.
    float3 cosPhase = cos(phaseShifts);
    float3 sinPhase = sin(phaseShifts);

    // Interfere the base field with the computed phase and absorption.
    // Construct a C3 using the real and imaginary parts.
    C3 outField = CV(baseField.real * cosPhase * absorptionFactors,
                      baseField.imag * sinPhase * absorptionFactors);

    // Introduce additional temporal modulation for dynamic effects.
    // Here, the modulation factors are computed on a per-channel basis.
    outField.real = outField.real * sin(uv.x * frequency + time * 2.0);
    outField.imag = outField.imag * cos(uv.y * frequency - time * 1.5);

    return outField;
}


C3 ComplexMetamaterialSurface(C3 baseField, float2 uv, float time, float3 nonlinearCoeffs, float refractiveIndex, float modulationStrength)
{
    // Nonlinear phase modulation based on intensity
    float intensity = length(baseField.real) + length(baseField.imag);
    float nonlinearPhase = nonlinearCoeffs.r * intensity + nonlinearCoeffs.g * pow(intensity, 2.0) + nonlinearCoeffs.b * pow(intensity, 3.0);

    // Refractive index modulation
    float refractiveMod = refractiveIndex + modulationStrength * sin(uv.x * 10.0 + time * 5.0);

    // Phase oscillation and distortion
    float phase = nonlinearPhase * refractiveMod;
    float cosPhase = cos(phase);
    float sinPhase = sin(phase);

    C3 outField;
    outField.real = baseField.real * cosPhase - baseField.imag * sinPhase;
    outField.imag = baseField.real * sinPhase + baseField.imag * cosPhase;

    return outField;
}
C3 ComplexDynamicGrating(C3 baseField, float2 uv, float time, float gratingStrength, int maxOrders)
{
    C3 outField = baseField;

    for (int n = -maxOrders; n <= maxOrders; n++)
    {
        float phaseShift = n * 2.0 * 3.14159265 * uv.x + time * n * 0.1;
        float cosPhase = cos(phaseShift);
        float sinPhase = sin(phaseShift);

        float orderStrength = gratingStrength / (1.0 + abs(float(n))); // Decay strength with higher orders

        outField.real += float3(orderStrength * cosPhase, 0, 0);
        outField.imag += float3(orderStrength * sinPhase, 0, 0);
    }

    return outField;
}
C3 ComplexLensAberration(C3 baseField, float2 uv, float time, float3 chromaticCoeffs, float lensDistortion)
{
    float radialDist = length(uv - 0.5);
    float chromaticPhase = chromaticCoeffs.r * pow(radialDist, 2.0) + chromaticCoeffs.g * pow(radialDist, 3.0) + chromaticCoeffs.b * pow(radialDist, 4.0);

    // Lens distortion
    float distortion = lensDistortion * radialDist * sin(time);

    // Combined phase effect
    float phase = chromaticPhase + distortion;
    float cosPhase = cos(phase);
    float sinPhase = sin(phase);

    C3 outField;
    outField.real = baseField.real * cosPhase - baseField.imag * sinPhase;
    outField.imag = baseField.real * sinPhase + baseField.imag * cosPhase;

    return outField;
}
C3 ComplexQuantumHolography(C3 baseField, float2 uv, float time, float entanglementStrength, float phaseOffset)
{
    float entangledPhase = sin(uv.x * 10.0 + uv.y * 5.0 + time) * entanglementStrength;
    float interferencePattern = sin(uv.x * 3.0 + uv.y * 7.0 + phaseOffset) * entanglementStrength;

    float cosPhase = cos(entangledPhase + interferencePattern);
    float sinPhase = sin(entangledPhase + interferencePattern);

    C3 outField;
    outField.real = baseField.real * cosPhase - baseField.imag * sinPhase;
    outField.imag = baseField.real * sinPhase + baseField.imag * cosPhase;

    return outField;
}
C3 ComplexParametricOscillation(C3 baseField, float2 uv, float time, float3 nonlinearTerms, float pumpStrength)
{
    float intensity = length(baseField.real) + length(baseField.imag);
    float nonlinearity = pumpStrength * (nonlinearTerms.r * intensity + nonlinearTerms.g * pow(intensity, 2.0) + nonlinearTerms.b * pow(intensity, 3.0));

    float phase = uv.x * nonlinearity + time;
    float cosPhase = cos(phase);
    float sinPhase = sin(phase);

    C3 outField;
    outField.real = baseField.real * cosPhase - baseField.imag * sinPhase;
    outField.imag = baseField.real * sinPhase + baseField.imag * cosPhase;

    return AdjustGamma(outField, Gamma);
}
C3 ComplexMultiWaveInterference(C3 baseField, float2 uv, float time, C3 wavelengthsNM, float3 amplitudes, float3 dispersionCoeffs)
{
    float3 dispersion = dispersionCoeffs * nmToM(wavelengthsNM).real;
    float3 phaseShifts = (uv.x + uv.y) / nmToM(wavelengthsNM).real + dispersion * time;
    
    float3 cosPhase = cos(phaseShifts);
    float3 sinPhase = sin(phaseShifts);
    
    // Combine the waves with weighted amplitudes
    C3 outField;
    outField.real = baseField.real + amplitudes * cosPhase;
    outField.imag = baseField.imag + amplitudes * sinPhase;

    return AdjustGamma(outField, Gamma);
}
C3 ComplexDynamicHologram(C3 baseField, float2 uv, float time, float hologramStrength, float phaseOffset)
{
    float2 fringePattern = sin(float2(uv.x * 10.0 + time, uv.y * 10.0 - time)) * hologramStrength;
    
    float3 realOffset = float3(fringePattern.x, 0, fringePattern.y);
    float3 imagOffset = float3(0, fringePattern.y, fringePattern.x);
    
    C3 outField;
    outField.real = baseField.real + realOffset;
    outField.imag = baseField.imag + imagOffset;

    float modAmplitude = cos(uv.x * 3.0 + uv.y * 2.0 + time + phaseOffset);
    outField.real *= 1.0 + modAmplitude * 0.1;
    outField.imag *= 1.0 + modAmplitude * 0.1;

    return AdjustGamma(outField, Gamma);
}
C3 ComplexPolarizedRainbow(C3 baseField, float2 uv, float time, float3 wavelengths, float3 polarizationAngles, float rainbowStrength)
{
    float3 phaseShifts = uv.x / wavelengths + sin(time + uv.y * 5.0) * rainbowStrength;
    float3 polarization = cos(polarizationAngles) * cos(phaseShifts) + sin(polarizationAngles) * sin(phaseShifts);

    C3 outField;
    outField.real = baseField.real * polarization;
    outField.imag = baseField.imag * polarization;

    return AdjustGamma(outField, Gamma);
}
C3 ComplexDoubleRefraction(C3 baseField, float2 uv, float time, float2 principalAxis, float3 refractiveIndices, float strength)
{
    float ordinaryPhase = dot(uv, principalAxis) * refractiveIndices.r + time;
    float extraordinaryPhase = dot(uv, float2(-principalAxis.y, principalAxis.x)) * refractiveIndices.g + time;

    float3 cosOrd = cos(ordinaryPhase * refractiveIndices);
    float3 sinOrd = sin(ordinaryPhase * refractiveIndices);
    float3 cosExt = cos(extraordinaryPhase * refractiveIndices);
    float3 sinExt = sin(extraordinaryPhase * refractiveIndices);

    C3 outField;
    outField.real = baseField.real + cosOrd * strength - sinExt * (strength * 0.5);
    outField.imag = baseField.imag + sinOrd * strength + cosExt * (strength * 0.5);

    return AdjustGamma(outField, Gamma);
}
C3 ComplexSpiralHologram(C3 baseField, float2 uv, float time, float spiralStrength, float frequency)
{
    float angle = atan2(uv.y - 0.5, uv.x - 0.5);
    float radius = length(uv - 0.5);

    float phaseShift = radius * frequency + angle * spiralStrength + time;
    float cosPhase = cos(phaseShift);
    float sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real + cosPhase * spiralStrength;
    outField.imag = baseField.imag + sinPhase * spiralStrength;

    return AdjustGamma(outField, Gamma);
}
C3 ComplexFresnelHologram(C3 baseField, float2 uv, float time, float refractiveIndex, float fresnelStrength)
{
    float incidentAngle = dot(uv, float2(1.0, 0.0));
    float fresnelReflectance = pow((refractiveIndex - 1.0) / (refractiveIndex + 1.0), 2.0);
    fresnelReflectance += (1.0 - fresnelReflectance) * pow(1.0 - cos(incidentAngle), 5.0);

    float phaseShift = sin(uv.x * 10.0 + time * 2.0) * fresnelStrength;

    float cosPhase = cos(phaseShift);
    float sinPhase = sin(phaseShift);

    C3 outField;
    outField.real = baseField.real * (1.0 + fresnelReflectance * cosPhase);
    outField.imag = baseField.imag * (1.0 + fresnelReflectance * sinPhase);

    return AdjustGamma(outField, Gamma);
}
C3 ComplexHolographicGrating(C3 baseField, float2 uv, float time, float gratingStrength, int maxOrders)
{
    C3 outField = baseField;

    for (int n = -maxOrders; n <= maxOrders; n++)
    {
        float phaseShift = n * 2.0 * 3.14159265 * uv.x + time * n * 0.1;
        float cosPhase = cos(phaseShift);
        float sinPhase = sin(phaseShift);

        float orderStrength = gratingStrength / (1.0 + abs(float(n))); // Decay strength with higher orders

        outField.real += float3(orderStrength * cosPhase, 0, 0);
        outField.imag += float3(orderStrength * sinPhase, 0, 0);
    }

    return AdjustGamma(outField, Gamma);
}
C3 ComplexChromaticRainbow(C3 baseField, float2 uv, float time, float3 wavelengths, float rainbowIntensity)
{
    float3 phaseShifts = uv.x / wavelengths + sin(time + uv.y * 5.0) * rainbowIntensity;
    float3 cosPhase = cos(phaseShifts);
    float3 sinPhase = sin(phaseShifts);

    C3 outField;
    outField.real = baseField.real + cosPhase * rainbowIntensity;
    outField.imag = baseField.imag + sinPhase * rainbowIntensity;

    return AdjustGamma(outField, Gamma);
}
// Rainbow holographic grating: generates a grating field and overlays a chromatic rainbow.
C3 RainbowHolographicGrating(C3 baseField, float2 uv, float time, float3 wavelengths, float gratingStrength, int maxOrders, float rainbowIntensity)
{
    // Generate the grating field.
    C3 grating = ComplexHolographicGrating(baseField, uv, time, gratingStrength, maxOrders);
    // Apply chromatic rainbow interference.
    C3 rainbow = ComplexChromaticRainbow(grating, uv, time, wavelengths, rainbowIntensity);
    return AdjustGamma(rainbow, Gamma);
}

// Double refraction Fresnel hologram: applies double refraction for birefringence
// then combines it with a Fresnel holographic reflection.
C3 DoubleRefractionFresnelHologram(C3 baseField, float2 uv, float time, float2 principalAxis, float3 refractiveIndices, float refractiveIndex, float fresnelStrength, float strength)
{
    C3 refracted = ComplexDoubleRefraction(baseField, uv, time, principalAxis, refractiveIndices, strength);
    C3 fresnel = ComplexFresnelHologram(refracted, uv, time, refractiveIndex, fresnelStrength);
    return AdjustGamma(fresnel, Gamma);
}

// Spiral rainbow interference: generates a spiral pattern and overlays chromatic rainbow interference.
C3 SpiralRainbowInterference(C3 baseField, float2 uv, float time, float spiralStrength, float frequency, float3 wavelengths, float rainbowIntensity)
{
    C3 spiral = ComplexSpiralHologram(baseField, uv, time, spiralStrength, frequency);
    C3 rainbow = ComplexChromaticRainbow(spiral, uv, time, wavelengths, rainbowIntensity);
    return AdjustGamma(rainbow, Gamma);
}

// Holographic metasurface dispersion: applies nonlinear metasurface modulation then adds chromatic dispersion.
C3 HolographicMetasurfaceDispersion(C3 baseField, float2 uv, float time, float3 nonlinearCoeffs, float refractiveIndex, float modulationStrength, float3 dispersionCoeffs, float dispersionStrength)
{
    C3 metasurface = ComplexMetamaterialSurface(baseField, uv, time, nonlinearCoeffs, refractiveIndex, modulationStrength);
    C3 dispersion = ComplexChromaticDispersion(metasurface, uv, time, dispersionCoeffs, dispersionStrength);
    return AdjustGamma(dispersion, Gamma);
}

// Quantum rainbow field: simulates quantum wave evolution then overlays chromatic rainbow interference.
C3 QuantumRainbowField(C3 initialField, float2 uv, float time, float potentialStrength, float waveNumber, float diffusion, float3 wavelengths, float rainbowIntensity)
{
    C3 quantumWave = ComplexQuantumWave(initialField, uv - .5, time, potentialStrength, waveNumber, diffusion);
    C3 rainbow = ComplexChromaticRainbow(quantumWave, uv, time, wavelengths, rainbowIntensity);
    return AdjustGamma(rainbow, Gamma);
}

// Multi-wave holographic interference: generates a multi-wave interference pattern and applies dynamic phase modulation.
C3 MultiWaveHolographicInterference(C3 baseField, float2 uv, float time, float3 wavelengths, float3 amplitudes, float3 dispersionCoeffs, float hologramStrength, float phaseOffset)
{
    C3 multiWave = ComplexMultiWaveInterference(baseField, uv, time, CV0(wavelengths), amplitudes, dispersionCoeffs);
    C3 dynamicHologram = ComplexDynamicHologram(multiWave, uv, time, hologramStrength, phaseOffset);
    return AdjustGamma(dynamicHologram, Gamma);
}

// Fresnel rainbow caustics: applies Fresnel reflection with holographic modulation, then overlays rainbow interference,
// and finally adds a caustics simulation.
C3 FresnelRainbowCaustics(C3 baseField, float2 uv, float time, float refractiveIndex, float fresnelStrength, float3 wavelengths, float rainbowIntensity, float causticsStrength, float distortionStrength)
{
    C3 fresnel = ComplexFresnelHologram(baseField, uv, time, refractiveIndex, fresnelStrength);
    C3 rainbow = ComplexChromaticRainbow(fresnel, uv, time, wavelengths, rainbowIntensity);
    C3 caustics = ComplexCaustics(rainbow, uv, time, distortionStrength, causticsStrength);
    return AdjustGamma(caustics, Gamma);
}

// Spiral quantum hologram: generates a spiral pattern then applies a quantum holography simulation.
C3 SpiralQuantumHologram(C3 baseField, float2 uv, float time, float spiralStrength, float frequency, float entanglementStrength, float phaseOffset)
{
    C3 spiral = ComplexSpiralHologram(baseField, uv, time, spiralStrength, frequency);
    C3 quantum = ComplexQuantumHolography(spiral, uv, time, entanglementStrength, phaseOffset);
    return AdjustGamma(quantum, Gamma);
}

// Prismatic holographic universe: combines multi-wave interference, Fresnel reflection, and dynamic caustics,
// then applies a quantum-like diffraction modulation.
C3 PrismaticHolographicUniverse(C3 baseField, float2 uv, float time, float3 wavelengths, float3 amplitudes, float3 dispersionCoeffs, float fresnelStrength, float refractiveIndex, float distortionStrength, float causticsStrength)
{
    C3 multiWave = ComplexMultiWaveInterference(baseField, uv, time, CV0(wavelengths), amplitudes, dispersionCoeffs);
    C3 fresnel = ComplexFresnelHologram(multiWave, uv, time, refractiveIndex, fresnelStrength);
    C3 caustics = ComplexCaustics(fresnel, uv, time, distortionStrength, causticsStrength);
    // Apply an additional quantum-like diffraction modulation.
    float phase = sin(uv.x * 15.0 + uv.y * 20.0 + time * 2.0);
    caustics.real *= cos(phase);
    caustics.imag *= sin(phase);
    return AdjustGamma(caustics, Gamma);
}

// Chromatic spiral supernova: generates a spiral holographic pattern, overlays chromatic rainbow dispersion,
// applies polarization rotation (iteratively), and then modulates via a nonlinear metasurface.
C3 ChromaticSpiralSupernova(C3 baseField, float2 uv, float time, float spiralStrength, float frequency, float3 wavelengths, float3 polarizationAngles, float metasurfaceStrength, float refractiveIndex)
{
    C3 spiral = ComplexSpiralHologram(baseField, uv, time, spiralStrength, frequency);
    C3 rainbow = ComplexChromaticRainbow(spiral, uv, time, wavelengths, metasurfaceStrength);
    // Apply polarization rotation iteratively.
    for (int i = 0; i < 3; i++)
    {
        rainbow = ComplexPolarizationRotate(rainbow, polarizationAngles[i] * sin(time));
    }
    // Apply nonlinear metasurface phase modulation.
    rainbow = ComplexMetamaterialSurface(rainbow, uv, time, float3(1.5, 2.5, 3.0), refractiveIndex, metasurfaceStrength);
    return AdjustGamma(rainbow, Gamma);
}

// Quantum lightstorm: simulates quantum wave evolution, adds double refraction interference,
// applies chromatic dispersion, and then adds diffraction-limited caustics.
C3 QuantumLightstorm(C3 baseField, float2 uv, float time, float potentialStrength, float waveNumber, float diffusion, float2 principalAxis, float3 refractiveIndices, float dispersionStrength, float causticsStrength)
{
    C3 quantumWave = ComplexQuantumWave(baseField, uv, time, potentialStrength, waveNumber, diffusion);
    C3 birefringence = ComplexDoubleRefraction(quantumWave, uv, time, principalAxis, refractiveIndices, causticsStrength);
    C3 dispersion = ComplexChromaticDispersion(birefringence, uv, time, refractiveIndices, dispersionStrength);
    float2 distortion = float2(sin(uv.x * 8.0), cos(uv.y * 8.0)) * causticsStrength;
    dispersion.real += distortion.x;
    dispersion.imag += distortion.y;
    return AdjustGamma(dispersion, Gamma);
}

// Polarized rainbow galaxy: applies Fresnel reflection, then a series of polarization rotations,
// and finally introduces chromatic aberration and phase-shifting caustics.
C3 PolarizedRainbowGalaxy(C3 baseField, float2 uv, float time, float refractiveIndex, float fresnelStrength, float3 polarizationAngles, float causticsStrength, float3 wavelengths)
{
    C3 fresnel = ComplexFresnelHologram(baseField, uv, time, refractiveIndex, fresnelStrength);
    C3 polarized = fresnel;
    for (int i = 0; i < 3; i++)
    {
        polarized = ComplexPolarizationRotate(polarized, polarizationAngles[i] * time);
    }
    float3 chromaticPhase = uv.x / wavelengths + sin(uv.y * 3.0 + time);
    polarized.real *= cos(chromaticPhase);
    polarized.imag *= sin(chromaticPhase);
    float phaseShift = sin(uv.x * 10.0 + uv.y * 5.0) * causticsStrength;
    polarized.real *= cos(phaseShift);
    polarized.imag *= sin(phaseShift);
    return AdjustGamma(polarized, Gamma);
}

// Interference nebula: combines multi-wave interference, spiral holography,
// thin-film interference, and quantum holography.
C3 InterferenceNebula(C3 baseField, float2 uv, float time, C3 wavelengthsNM, float3 amplitudes, float hologramStrength, float spiralStrength, float thinFilmStrength, float3 layerThicknesses, float3 refractiveIndices, float3 absorptionCoefficients)
{
    C3 multiWave = ComplexMultiWaveInterference(baseField, uv, time, wavelengthsNM, amplitudes, refractiveIndices);
    C3 spiral = ComplexSpiralHologram(multiWave, uv, time, spiralStrength, 1.0);
    C3 thinFilm = ComplexThinFilmInterference(spiral, uv, time, layerThicknesses, refractiveIndices, absorptionCoefficients, wavelengthsNM);
    C3 quantumHolo = ComplexQuantumHolography(thinFilm, uv, time, hologramStrength, 0.5);
    return AdjustGamma(quantumHolo, Gamma);
}

// Aurora wavefield: applies a sequence of chromatic and Fresnel effects
// followed by nonlinear phase modulation and multi-wave diffraction.
C3 AuroraWavefield(C3 baseField, float2 uv, float time, float3 wavelengths, float3 amplitudes, float fresnelStrength, float3 polarizationAngles, float nonlinearStrength, float diffractionStrength)
{
    C3 rainbow = ComplexPolarizedRainbow(baseField, uv, time, wavelengths, polarizationAngles, fresnelStrength);
    C3 fresnel = ComplexFresnelHologram(rainbow, uv, time, 1.5, fresnelStrength);
    C3 nonlinear = ComplexMetamaterialSurface(fresnel, uv, time, float3(1.0, 2.0, 3.0), 1.5, nonlinearStrength);
    C3 diffraction = ComplexMultiWaveInterference(nonlinear, uv, time, CV0(wavelengths), amplitudes, float3(1.2, 1.1, 0.9));
    return AdjustGamma(diffraction, Gamma);
}

// Chromatic wave hologram: combines thin-film interference, rainbow enhancement,
// and microfacet lighting (using a lighting structure).
C3 ChromaticWaveHologram(LightingComplex lighting, float2 inputUV, float time, float3 waveAmplitudes, float3 waveFrequencies, float thinFilmStrength, float rainbowIntensity, float hologramStrength, int dispersionIndex)
{
    float3 wavePhases = float3(
        sin(inputUV.x * waveFrequencies.r + time * waveFrequencies.r),
        sin(inputUV.y * waveFrequencies.g + time * waveFrequencies.g),
        sin((inputUV.x + inputUV.y) * waveFrequencies.b + time * waveFrequencies.b)
    );
    float3 interference = waveAmplitudes * wavePhases;
    C3 thinFilmEffect = InterferenceThinFilmComplex(inputUV, time, nmToMf(lighting.albedoWavelengthsNM * waveAmplitudes), lighting.material.thicknessM.real, lighting.material.etaR, lighting.cosThetaTransmissionInside.real, lighting.nSurrounding);
    C3 rainbowEffect = CV(lighting.interferenceIntensity[dispersionIndex] * rainbowIntensity, ZERO3);
    C3 hologramColor = CAdd(CAdd(CV(lighting.albedo, ZERO3), ComplexMulScalar(thinFilmEffect, hologramStrength)), rainbowEffect);
    return AdjustGamma(ComplexSpiralInterference(CMul(CMul(hologramColor, thinFilmEffect), rainbowEffect), inputUV, time, cos(time), cos(time)), Gamma);
}

// Quantum interference rainbow: combines a quantum wave evolution with chromatic dispersion.
C3 QuantumInterferenceRainbow(LightingComplex lighting, float2 inputUV, float time, float quantumStrength, float3 wavelengths, float rainbowShift, int dispersionIndex)
{
    C3 quantumWave = ComplexMagnitude(ComplexQuantumWave(CV0(lighting.albedo), inputUV, time, quantumStrength, 0.01, 0.02));
    C3 chromaticRainbow = ComplexChromaticRainbow(quantumWave, inputUV, time, wavelengths, rainbowShift);
    return AdjustGamma(chromaticRainbow, Gamma);
}

// Polarized rainbow refraction: combines polarization-based refraction with chromatic interference.
C3 PolarizedRainbowRefraction(LightingComplex lighting, float2 inputUV, float time, float polarizationStrength, float3 refractiveIndices, float rainbowIntensity, int dispersionIndex)
{
    C3 polarRefraction = CalculateReflectedTransmittedPolarization(lighting.nSurrounding, refractiveIndices, lighting.normal, lighting.NdotL3, lighting.cosThetaTransmissionInside.real);
    C3 rainbow = ChromaticInterference(rainbowIntensity, time, dispersionIndex, lighting);
    return AdjustGamma(CMul(polarRefraction, rainbow), Gamma);
}

// Heat haze rainbow caustics: simulates dynamic heat haze distortion, modulates by albedo brightness,
// and applies caustics simulation.
C3 HeatHazeRainbowCaustics(inout LightingComplex lighting, float2 inputUV, float time, float heatHazeStrength, float rainbowIntensity, float causticsStrength, int dispersionIndex)
{
    float2 distortedUV = inputUV + float2(
        sin(inputUV.x * 1000 + time * 0.75) * heatHazeStrength,
        cos(inputUV.y * 1000 - time * 0.75) * heatHazeStrength
    );
    float albedoBrightness = dot(lighting.albedo, float3(0.333, 0.333, 0.333));
    float dynamicRainbowIntensity = rainbowIntensity * (1.0 + 0.5 * albedoBrightness);
    C3 rainbow = ChromaticInterference(dynamicRainbowIntensity, time, dispersionIndex, lighting);
    float subsurfaceWeight = lerp(0.3, 0.8, saturate(albedoBrightness));
    float diffuseWeight = 0.6;
    float3 causticsColor = ScatterCaustics(causticsStrength, subsurfaceWeight, diffuseWeight, distortedUV, time, dispersionIndex, lighting);
    return AdjustGamma(CMul(CV0(causticsColor), rainbow), Gamma);
}

// Advanced fractal aurora: generates a fractal aurora pattern and overlays a chromatic rainbow.
C3 AdvancedFractalAurora(LightingComplex lighting, float2 inputUV, float time, float fractalStrength, float auroraWeight, float rainbowIntensity, int dispersionIndex)
{
    float3 fractalAurora = FractalAurora(auroraWeight, inputUV, time, dispersionIndex, lighting);
    C3 rainbow = ChromaticInterference(rainbowIntensity, time, dispersionIndex, lighting);
    return AdjustGamma(CMul(CV0(fractalAurora), rainbow), Gamma);
}

// Chromatic wave hologram: computes holographic interference using a combination of thin-film effects and microfacet lighting.
C3 QuantumInterferenceRainbow(LightingComplex lighting, float2 inputUV, float time, float quantumStrength, float3 wavelengths, float rainbowShift, int dispersionIndex);
C3 PolarizedRainbowGalaxy(LightingComplex lighting, float2 inputUV, float time, float refractiveIndex, float fresnelStrength, float3 polarizationAngles, float causticsStrength, float3 wavelengths);

inline C3 CalculateFresnelReflectance(C3 eta, float3 normal, float3 lightDir)
{
    // Calculate Fresnel reflectance using the complex refractive index
    C3 fresnelReflectance = FresnelComplex(eta, normal, lightDir);

    // Calculate Fresnel transmittance (1 - reflectance) for complex numbers
    C3 fresnelTransmittance = ComplexSub(CV(ONE3, ZERO3), fresnelReflectance);

    // Return the reflectance
    return AdjustGamma(CSat(fresnelReflectance), Gamma);
}

inline C3 CalculateMicrofacetSpecular(LightingComplex lighting, MaterialSellmeier mat, float3 albedo, int dispersionIndex, float time, float2 inputUV, bool invertDepth, bool useProjectedDepth, float sssStrength)
{
    return
        MicrofacetBRDF1(CV0(albedo), CV0(lighting.albedo), mat, inputUV, time, albedo, lighting.normal, lighting.viewDir, lighting.lightDir, invertDepth, useProjectedDepth, lighting.nSurrounding, CV(mat.etaR, mat.etaI), length(mToNm(mat.thicknessM).real), mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength);
}
inline C3 CalculateDiffuseTransmittance(
    float2 inputUV,
    float time,
    int dispersionIndex,
    LightingComplex lighting,
    MaterialSellmeier mat,
    float sssStrength,
    float3 baseDiffuseTex,
    C3 fresTransmittance
)
{
    return
        CSatMag(
              CMul(  CMul(
                    CV(baseDiffuseTex * lighting.NdotV3 * sssStrength, ZERO3),
                    CAdd(fresTransmittance,
                            CalculateMicrofacetSpecular(lighting, mat, lighting.albedo, dispersionIndex, time, inputUV, lighting.invertDepth, lighting.useProjectedDepth, sssStrength)
                        )
                    )
                
        ,
        //CMul(CSatMag(lighting.interferenceColorTransmittance),
            CSatMag(lighting.transmittance[dispersionIndex])));
                /*CSatMag(
                    CMul(CMul(MicrofacetBRDF1(CV(lighting.albedo, ZERO3), CV(lighting.albedo, ZERO3), mat, inputUV, time, lighting.albedo, lighting.normal, lighting.viewDir, lighting.lightDir, lighting.invertDepth, lighting.useProjectedDepth, lighting.nSurrounding, CV(mat.etaR, mat.etaI), length(mToNm(mat.thicknessM).real), mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength), CV(lighting.albedo, ZERO3)), CV(lighting.NdotV3 * sssStrength, ZERO3))
                )*/
            
        
    ;
}





// Improved RainbowFactor using complex math macros
inline C3 RainbowFactor(C3 color, C3 inputUV, C3 time, C3 speed, C3 intensity)
{
    // Compute the shift factor based on time and speed.
    C3 shift = CMul(time, speed);

    // Get the x-component from the saturated absolute value of inputUV.
    // (Assumes that CSat(CAbs(inputUV)).real.x extracts a scalar value from the real part.)
    C3 uvX = CV0(CSat(CAbs(inputUV)).real.x);

    // Combine the x-component with the time shift.
    C3 baseUV = CAdd(uvX, shift);

    // Define common constants.
    C3 halfV = Cp50;
    C3 twoPi = C2PI; // Equivalent to CV0(2.0*PI)
    
    // Define phase offsets for each channel:
    // Red: no extra offset beyond twoPi scaling and a slight frequency adjustment.
    // Green: approximately 120° offset (2.094 radians).
    // Blue: approximately 240° offset (4.188 radians).
    C3 redPhaseFactor = CV0(1.012);
    C3 greenPhaseFactor = CV0(1.094); // 120° offset
    C3 bluePhaseFactor = CV0(4.188); // 240° offset

    // Compute the sine-based modulation for each color channel.
    C3 r = CAdd(halfV, CMul(halfV, CSin(CMul(CMul(baseUV, redPhaseFactor), twoPi))));
    C3 g = CAdd(halfV, CMul(halfV, CSin(CMul(CMul(baseUV, greenPhaseFactor), twoPi)))); // Using green-phase offset
    C3 b = CAdd(halfV, CMul(halfV, CSin(CMul(CMul(baseUV, bluePhaseFactor), twoPi)))); // Using blue-phase offset

    // Combine the computed channels with their color multipliers.
    // Make sure that CVRed, CVGreen, and CVBlue are defined correctly.
    C3 colorContribution = CAdd(
                                CAdd(CMul(r, CVRed), CMul(g, CVGreen)),
                                CMul(b, CVBlue)
                             );
    // Scale the contribution by the given intensity and add to the original color.
    return CAdd(color, CMul(colorContribution, intensity));
}


// Example: near the end of your pixel shader, after computing 'finalColor'.
C3 ApplyRainbowLighting(LightingComplex lighting, float2 inputUV, float time, C3 finalColor)
{
    // Simple example: combine the rainbow factor with the existing color.
    C3 rainbow = RainbowFactor(finalColor, CV0(float3(inputUV,0)), CV0(time), CV0(length(lighting.phase[0].real + lighting.phase[0].imag) * 0.33),
    CV0(length(lighting.interferenceIntensity[0]) * 0.33));
    // You can modulate further if desired.
    C3 blendFactor = CSat(CAbs(lighting.reflectance[0])); // how strongly to blend in the rainbow
    return ComplexLerp(finalColor, rainbow, blendFactor);
}
float3 ComputeGradient(Texture2D<float> tex, float2 inputUV, bool invertDepth, bool useProjectedDepth)
{
    // Sample points for gradient calculation using partial derivatives
    float d = 0.001;
    // Small offset for finite differences
    float left = depth2D(tex, inputUV + float2(-d, 0), invertDepth, useProjectedDepth);
    float right = depth2D(tex, inputUV + float2(d, 0), invertDepth, useProjectedDepth);
    float up = depth2D(tex, inputUV + float2(0, -d), invertDepth, useProjectedDepth);
    float down = depth2D(tex, inputUV + float2(0, d), invertDepth, useProjectedDepth);
    // Compute partial derivatives
    float dx = (right - left) / (2.0 * d);
    float dy = (down - up) / (2.0 * d);
    return float3(dx, dy, 0.0);
}

float3 ComputeLaplacian(Texture2D<float> tex, float2 inputUV, bool invertDepth, bool useProjectedDepth)
{
    // Compute the Laplacian to capture second-order derivatives
    float2 d = GetOosz(tex);
    // Small offset for finite differences
    float center = depth2D(tex, inputUV, invertDepth, useProjectedDepth);
    float left = depth2D(tex, inputUV + float2(-d.x, 0), invertDepth, useProjectedDepth);
    float right = depth2D(tex, inputUV + float2(d.x, 0), invertDepth, useProjectedDepth);
    float up = depth2D(tex, inputUV + float2(0, -d.y), invertDepth, useProjectedDepth);
    float down = depth2D(tex, inputUV + float2(0, d.y), invertDepth, useProjectedDepth);
    return float3((left + right - 2.0 * center) / (d.x * d.y), (up + down - 2.0 * center) / (d.x * d.y), 0.0);
}


float3 laplatianCurvature(Texture2D<float> depthMap, float2 inputUV, bool invertDepth, bool useProjectedDepth)
{
    float3 normal = CalcNormal(depthMap, inputUV, useProjectedDepth, NormalRadius);
    float depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
    // Compute gradient, Laplacian, and curvature from the depth map
    float3 gradient = ComputeGradient(depthMap, inputUV, invertDepth, useProjectedDepth);
    float3 laplacian = ComputeLaplacian(depthMap, inputUV, invertDepth, useProjectedDepth);
    float curvature = ComputeCurvature(depthMap, GetOosz(depthMap), inputUV, invertDepth, useProjectedDepth);
    // Create a higher-order texture by combining normal, depth, gradient, Laplacian, and curvature
    float3 higherOrderTexture = normalize(normal + depth * gradient + 0.5 * laplacian + 0.2 * curvature);
    return higherOrderTexture;
}

float4 iterate(float4 z, float4 c)
{
    // A complex, iterative function inspired by the Mandelbrot set
    // Extended to 4 dimensions, using the w component.
    // The specifics can be varied for different visual results.

    float4 zSquared;
    zSquared.x = z.x * z.x - z.y * z.y - z.z * z.z - z.w * z.w;
    zSquared.y = 2 * z.x * z.y;
    zSquared.z = 2 * z.x * z.z;
    zSquared.w = 2 * z.x * z.w;

    return zSquared + c;
}


//provide flawless hlsl sm 5.0 pixel shader modifications and improvements, to the level of specificity analogous to the order at which the UPU operates at, the required changes to the code below to function properly and produce results that are of THAT degree of specificity functional.
/*
LightingComplex PopulateLightingComplex(
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    int materialIndex,
    float animateSpeed,
    float parallaxScale,
    float normalRadius,
    float sssStrength,
    int dispersionIndex,
    float gamma,
    float exposure,
    float saturation,
    inout float3 test
)
{
    LightingComplex lighting = (LightingComplex) 0;
    float time = AnimateTime;
    MaterialSellmeier mat = CreateMaterial(materialIndex);

    float lightingWeight = HeightParamC;
    float diffuseTransmittanceWeight = PhaseOffsetR;
    float diffuseReflectanceWeight = PhaseOffsetG;
    float specularWeight = PhaseOffsetB;
    float interferenceWeight = CosineFactorR;
    
    // --- Initialization ---
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.DepthScale = depthScale;
    lighting.DepthRange = depthScale;

    // --- Depth, Position, and Normal ---
    lighting.depth = depth2D(depthMap, inputUV, lighting.invertDepth, lighting.useProjectedDepth);
    lighting.viewPos = viewPos;
    lighting.pixelPos = float3(inputUV, lighting.depth);
    lighting.normal = safeNormalize(normal2D11W(normalMap, inputUV, normalRadius) - .1 * ToTangentSpace11(viewPos - lighting.pixelPos));
    lighting.viewDir = safeNormalize(ToTangentSpace11(viewPos - float3(inputUV, lighting.depth)));
    lighting.lightDir = safeNormalize(ToTangentSpace11(lightPos - float3(inputUV, lighting.depth)));
    lighting.halfDir = safeNormalize(lighting.viewDir + lighting.lightDir);

    // --- Dot Products ---
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.NdotV3 = saturate(dot(lighting.viewDir, lighting.normal));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    lighting.NdotL3 = saturate(dot(lighting.lightDir, lighting.normal));

    // --- Material Properties and Fresnel ---
    // Calculate base diffuse texture
    float3 baseDiffuseTex = mat.albedo * diffuse2D(diffuseMap, inputUV).rgb;

    // Invert diffuse color for Fresnel calculation
    float3 invertedDiffuse = 1.0 - baseDiffuseTex;

    // Calculate Fresnel term using Schlick's approximation
    float NdotV = saturate(dot(lighting.normal, lighting.viewDir));
    float3 Fresnel = lerp(FresnelSchlick(baseDiffuseTex, NdotV, FresnelPower), FresnelSchlick(invertedDiffuse, 1.0 - NdotV, FresnelReflectance), 1.0 - NdotV);

    // Update material albedo with Fresnel
    mat.albedo = baseDiffuseTex + Fresnel;
    lighting.material = mat;
    lighting.albedo = mat.albedo;

    // --- Constants ---

    static const float BIREFRINGENCE_STRENGTH = 0.5;

    // --- Refractive Indices ---

    // Calculate ordinary and effective extraordinary refractive indices
    float3 dispersionFactor = lerp(float3(1.0, 1.0, 1.0), float3(0.95, 1.0, 1.05), saturate(f8));
    float3 n_o = CalculateRefractiveIndex(lighting.albedoWavelengthsNM, mat.coeff);
    float cosThetaOptic = dot(lighting.lightDir, mat.opticalAxis);
    float3 n_e_effective = n_o + BIREFRINGENCE_STRENGTH * float3(1.0, 1.0, 1.0) * cosThetaOptic * cosThetaOptic;

    // --- Wavelengths and Surrounding Refractive Index ---
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);
    lighting.nSurrounding = float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding);
    
    // --- Microfacet Specular ---
    lighting.ggxDistribution = DistributionGGX(dot(lighting.normal, lighting.halfDir), mat.roughness);
    
    // Calculate microfacet specular
    lighting.microfacetSpecular = saturate((lighting.ggxDistribution * GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness)) / max(4.0 * lighting.NdotV3, EPSILON3));

    // --- Phase Shift and Interference ---

    // Calculate phase shift for ordinary and extraordinary rays
    float opticalThickness = clamp(1.0 - lighting.depth * mat.thicknessM, 0.1, 0.9);

    C3 phaseShift_o = ComplexThinFilmInterference(ComplexQuantumWave(CV(lighting.albedo, ZERO3), inputUV, time, 1.0, 1, 1.0), inputUV, time, mToNm(mat.thicknessM), mat.etaO, mat.absorptionCoefficient * ONE3);
    C3 phaseShift_e = ComplexThinFilmInterference(ComplexQuantumWave(CV(lighting.albedo, ZERO3), inputUV, time, 1.0, 1, 1.0), inputUV, time, mToNm(mat.thicknessM), mat.etaE, mat.absorptionCoefficient * ONE3);

    // Combine phase shifts based on depth
    SetDV(phaseShift, ComplexLerp(phaseShift_o, phaseShift_e, lighting.depth));
    
    // --- Transmission Coefficients ---
    float3 etaR_wavelength = n_e_effective * dispersionFactor;
    float3 etaI_wavelength = n_o * dispersionFactor;

    float3 sinThetaIncident = sqrt(saturate(ONE3 - lighting.NdotL3 * lighting.NdotL3));
    lighting.cosThetaTransmissionInside = CV(sqrt(saturate(ONE3 - (lighting.nSurrounding / etaR_wavelength) * (lighting.nSurrounding / etaR_wavelength) * sinThetaIncident * sinThetaIncident)), sqrt(saturate(ONE3 - (lighting.nSurrounding / etaI_wavelength) * (lighting.nSurrounding / etaI_wavelength) * sinThetaIncident * sinThetaIncident)));
    lighting.cosThetaTransmissionOutside = CV(sqrt(saturate(ONE3 - (etaR_wavelength / lighting.nSurrounding) * (etaR_wavelength / lighting.nSurrounding) * sinThetaIncident * sinThetaIncident)), sqrt(saturate(ONE3 - (etaI_wavelength / lighting.nSurrounding) * (etaI_wavelength / lighting.nSurrounding) * sinThetaIncident * sinThetaIncident)));
    lighting.HeatHazeRainbowCaustics = HeatHazeRainbowCaustics(lighting, inputUV, time, f1, f2, f3, dispersionIndex);
    // --- Fresnel Reflectance ---

    lighting.internalFilmReflectance = CV(
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaR, lighting.NdotL3, lighting.cosThetaTransmissionInside.real),
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaI, lighting.NdotL3, lighting.cosThetaTransmissionInside.imag)
    );

    lighting.externalFilmReflectance = CV(
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaR, lighting.NdotL3, lighting.cosThetaTransmissionOutside.real),
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaI, lighting.NdotL3, lighting.cosThetaTransmissionOutside.imag)
    );
    
    // --- Polarization, Interference, and Specular ---
    
    // Calculate composite specular
    float3 dielectricReflectance = float3(0.04, 0.04, 0.04);
    float3 metallicReflectance = mat.metallicReflectance;
    float3 F02 = CalculateF0(mat.metallic, dielectricReflectance, metallicReflectance);
    lighting.cookTorrenceSpecular = CookTorranceSpecularPBR(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness, F02, mat.metallic);
    lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
    float3 tangent = CalcTBN(lighting.normal)[0];
    lighting.advancedSheen = CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, tangent, mat.roughness, SHEEN_ALBEDO_TINT);
    lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) + DistributionGGX(dot(lighting.normal, lighting.halfDir), mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER) * ClearCoatFresnel(lighting.NdotV3);
    lighting.iridescence = CalculateIridescence(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.albedo);
    lighting.specularWithSheen = lighting.cookTorrenceSpecular + lighting.sheen + lighting.advancedSheen;
    lighting.compositeSpecular = CSat(CMul(CalculateReflectedTransmittedPolarization(lighting.nSurrounding, etaR_wavelength, -lighting.lightDir, lighting.normal, lighting.NdotL3, lighting.cosThetaTransmissionInside.real),
        CAdd(Complex00, CV(rotateHue(lighting.specularWithSheen + lighting.clearCoatSpecular + lighting.iridescence, time), rotateHue(lighting.specularWithSheen + lighting.clearCoatSpecular + lighting.iridescence, time)))));

    // Calculate film reflected polarization
    PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(
        lighting.viewPos,
        lighting.pixelPos,
        mat.thicknessM,
        lighting.normal
    );

    OpticalPathResult opticalPathDiff = OpticalPathDifference(
        lighting.albedoWavelengthsNM,
        lighting.nSurrounding,
        pathMeasurement,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient,
        lighting.cosThetaTransmissionInside.real
    );

    float coherenceLengthM = mat.coherenceLengthM;

    lighting.filmReflectedPolarization = CSat(CV(ApplyReflectanceCoherence(
        CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).real,
        opticalPathDiff,
        coherenceLengthM
    ), ApplyReflectanceCoherence(
        CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).imag,
        opticalPathDiff,
        coherenceLengthM
    )));

    // --- Interference Color ---

    // Calculate interference color for reflectance and transmittance
    float3 interferenceColorReflectanceR = (1.0 - lighting.albedo) * (InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor, mat.thicknessM, etaR_wavelength, lighting.cosThetaTransmissionOutside.real, lighting.nSurrounding));
    float3 interferenceColorReflectanceI = (1.0 - lighting.albedo) * (InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor, mat.thicknessM, etaI_wavelength, lighting.cosThetaTransmissionOutside.imag, lighting.nSurrounding));
    lighting.interferenceColorReflectance = CSat(CV(interferenceColorReflectanceR, interferenceColorReflectanceI));

    // --- Transmitted Polarization ---

    lighting.transmittedPolarization = CSat(ComplexSub(Complex11, lighting.filmReflectedPolarization));

    // --- Interference Color Transmittance ---
    float3 interferenceColorTransmittanceR = lighting.albedo * (InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor, mat.thicknessM, etaR_wavelength, lighting.cosThetaTransmissionInside.real, lighting.nSurrounding) + lighting.transmittedPolarization.real);
    float3 interferenceColorTransmittanceI = lighting.albedo * (InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor, mat.thicknessM, etaI_wavelength, lighting.cosThetaTransmissionInside.imag, lighting.nSurrounding) + lighting.transmittedPolarization.imag);
    lighting.interferenceColorTransmittance = CSat(CV(interferenceColorTransmittanceR, interferenceColorTransmittanceI));

    // --- Fresnel Reflectance and Transmittance ---

    // Calculate Fresnel reflectance and transmittance
    C3 fresReflectance = CalculateFresnelReflectance(CV(etaR_wavelength, ZERO3), lighting.normal, lighting.lightDir);
    C3 fresTransmittance = ComplexSub(Complex11, fresReflectance);

    // --- View-to-Pixel Distance and Optical Path ---

    // Calculate the distance from the view position to the pixel
    lighting.viewToPixel = DistanceMFromViewToAB(lighting.viewPos, lighting.pixelPos, lighting.pixelPos + lighting.viewDir * mToNm(mat.thicknessM));
    // --- Calculate optical path differences for different channels
    OpticalPathResult opdResReal = OpticalPathDifference(
        lighting.albedoWavelengthsNM,
        lighting.nSurrounding,
        lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient,
        lighting.cosThetaTransmissionInside.real
    );
    SetDVo(opdAlbedoTransInsideRealChannel, opdResReal);

    OpticalPathResult opdResImag = OpticalPathDifference(
        lighting.albedoWavelengthsNM,
        lighting.nSurrounding,
        lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient,
        lighting.cosThetaTransmissionInside.imag
    );
    SetDVo(opdAlbedoTransInsideImagChannel, opdResImag);

    OpticalPathResult opdResOutsideReal = OpticalPathDifference(
        lighting.albedoWavelengthsNM,
        lighting.nSurrounding,
        lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient,
        lighting.cosThetaTransmissionOutside.real
    );
    SetDVo(opdAlbedoTransOutsideRealChannel, opdResOutsideReal);

    OpticalPathResult opdResOutsideImag = OpticalPathDifference(
        lighting.albedoWavelengthsNM,
        lighting.nSurrounding,
        lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient,
        lighting.cosThetaTransmissionOutside.imag
    );
    SetDVo(opdAlbedoTransOutsideImagChannel, opdResOutsideImag);
    // --- Reflectance Calculation ---
    // Calculate reflectance using internal and external film reflectance, phase, coherence, and polarization
    SetDV(reflectance,
   
        CV(saturate(
            (lighting.internalFilmReflectance.real + lighting.externalFilmReflectance.real + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectance.real * lighting.externalFilmReflectance.real, EPSILON3))) * sin(lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].phaseInterference.totalPhase) *
            CoherenceFactor(lighting.opdAlbedoTransOutsideRealChannel[dispersionIndex].opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                cos(lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectance.real * InterferenceComplex(inputUV, time, lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].phaseInterference.phaseShift, lighting.opdAlbedoTransOutsideRealChannel[dispersionIndex].phaseInterference.phaseDifference),
                lighting.externalFilmReflectance.real
            )
        ), saturate(
            (lighting.internalFilmReflectance.imag + lighting.externalFilmReflectance.imag + (2.0 / 3.0) * sqrt(max(lighting.internalFilmReflectance.imag * lighting.externalFilmReflectance.imag, EPSILON3))) * sin(lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].phaseInterference.totalPhase)) *
            CoherenceFactor(lighting.opdAlbedoTransOutsideImagChannel[dispersionIndex].opticalMeasurement.PathLengthM, mat.coherenceLengthM) *
            PolarizationEffect3(
                sin(lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].phaseInterference.totalPhase),
                lighting.internalFilmReflectance.imag * InterferenceComplex(inputUV, cos(time), lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].phaseInterference.phaseShift, lighting.opdAlbedoTransOutsideImagChannel[dispersionIndex].phaseInterference.phaseDifference),
                lighting.externalFilmReflectance.imag
            )
        ));
    // --- Effective Refractive Index ---

    // Calculate effective refractive indices for inside and outside reflectance
    SetDV(iorEffectiveInsideReflectance,
        CV(
            CalculateEffectiveRefractiveIndexReflectReal(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.reflectance[dispersionIndex].real,
                lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].refractiveIndex
            ),
            CalculateEffectiveRefractiveIndexReflectImag(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.reflectance[dispersionIndex].imag,
                lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].refractiveIndex
            )));
    
    SetDV(iorEffectiveOutsideReflectance,
        CV(
            CalculateEffectiveRefractiveIndexReflectReal(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.reflectance[dispersionIndex].real,
                lighting.opdAlbedoTransOutsideRealChannel[dispersionIndex].refractiveIndex
            ),
            CalculateEffectiveRefractiveIndexReflectImag(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.reflectance[dispersionIndex].imag,
                lighting.opdAlbedoTransOutsideImagChannel[dispersionIndex].refractiveIndex
            )));

    // Calculate effective refractive indices for inside and outside transmittance
    SetDV(iorEffectiveInsideTransmittance,
        CV(
            CalculateEffectiveRefractiveIndexTransmitReal(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.transmittance[dispersionIndex].real,
                lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].refractiveIndex
            ),
            CalculateEffectiveRefractiveIndexTransmitImag(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.transmittance[dispersionIndex].imag,
                lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].refractiveIndex
            )));

    SetDV(iorEffectiveOutsideTransmittance,
        CV(
            CalculateEffectiveRefractiveIndexTransmitReal(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.transmittance[dispersionIndex].real,
                lighting.opdAlbedoTransOutsideRealChannel[dispersionIndex].refractiveIndex
            ),
            CalculateEffectiveRefractiveIndexTransmitImag(
                lighting.lightDir,
                mat.opticalAxis,
                lighting.transmittance[dispersionIndex].imag,
                lighting.opdAlbedoTransOutsideImagChannel[dispersionIndex].refractiveIndex
            )));

    // --- Reflectance and Transmittance Corrections ---

    // Correct reflectance and transmittance based on effective refractive indices
    float3 reflectanceCorrectionInside = max(EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideReflectance[dispersionIndex].real, lighting.iorEffectiveInsideReflectance[dispersionIndex].real, 0.5), mat.opticalAxis), ZERO3);
    float3 reflectanceCorrectionOutside = max(EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideReflectance[dispersionIndex].imag, lighting.iorEffectiveInsideReflectance[dispersionIndex].imag, 0.5), mat.opticalAxis), ZERO3);
    float3 transmittanceCorrectionInside = max(EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideTransmittance[dispersionIndex].real, lighting.iorEffectiveInsideTransmittance[dispersionIndex].real, 0.5), mat.opticalAxis), ZERO3);
    float3 transmittanceCorrectionOutside = max(EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideTransmittance[dispersionIndex].imag, lighting.iorEffectiveInsideTransmittance[dispersionIndex].imag, 0.5), mat.opticalAxis), ZERO3);

    {
        SetDV(reflectance, CMul(lighting.reflectance[dispersionIndex], CV(reflectanceCorrectionInside, reflectanceCorrectionOutside)));
    }
    {
        SetDV(transmittance, CV(lighting.albedo, 1.0 - lighting.albedo));
    }
    {
        SetDV(transmittance, CMul(lighting.transmittance[dispersionIndex], CV(transmittanceCorrectionInside, transmittanceCorrectionOutside)));
    }

    // Apply coherence factor to reflectance
    float3 reflectanceCoherence = max(ApplyReflectanceCoherence(lighting.reflectance[dispersionIndex].imag, lighting.opdAlbedoTransInsideImagChannel[dispersionIndex], mat.coherenceLengthM), EPSILON3);
   {
        SetDV(reflectance, CSat(CMul(CSat(lighting.reflectance[dispersionIndex]), CV(reflectanceCoherence, reflectanceCoherence))));
    }
    // Apply coherence factor to transmittance
    float3 transmittanceCoherence = max(CoherenceFactor(
        lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].opticalMeasurement.PathLengthM,
        mat.coherenceLengthM
    ), ZERO3) +
        max(CoherenceFactor(
            lighting.opdAlbedoTransOutsideRealChannel[dispersionIndex].opticalMeasurement.PathLengthM,
            mat.coherenceLengthM
        ), ZERO3);
    {
        SetDV(transmittance, CSat(CMul(CSat(lighting.transmittance[dispersionIndex]), CV(transmittanceCoherence, transmittanceCoherence))));
    }
    // --- Energy Conservation ---

    // Ensure energy conservation by redistributing excess energy
    float3 energyReal = max(lighting.reflectance[dispersionIndex].real, ZERO3);
    float3 energyImag = max(lighting.reflectance[dispersionIndex].imag, ZERO3);
    {
        SetDV(reflectance, CSat(CMul(CSat(lighting.reflectance[dispersionIndex]), CV(energyReal, energyImag))));
        
    }
    energyReal = max(lighting.transmittance[dispersionIndex].real, ZERO3);
    energyImag = max(lighting.transmittance[dispersionIndex].imag, ZERO3);
    {
    SetDV(transmittance, CSat(CMul(CSat(lighting.transmittance[dispersionIndex]), CV(energyReal, energyImag))));
    }
    // Apply absorption effect
    float3 absorption = max(exp(-mat.absorptionCoefficient *
        lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].opticalMeasurement.PathLengthM), ZERO3) +
        max(exp(-mat.absorptionCoefficient *
            lighting.opdAlbedoTransOutsideImagChannel[dispersionIndex].opticalMeasurement.PathLengthM), ZERO3);
    {
    SetDV(transmittance, CMul(CSat(lighting.transmittance[dispersionIndex]), CV(absorption, absorption)));
    }
    // --- Diffuse Reflectance ---

    // Calculate diffuse reflectance
    SetDV(diffuseReflectance,
        CAdd(
            CSat(lighting.reflectance[dispersionIndex]),
            CSat(
                CAdd(
                        CSat(lighting.filmReflectedPolarization),
                        CSat(fresReflectance)))));

    // --- Specular Contribution ---
    // Calculate specular contribution
    SetDV(specularContribution,
        CSat(
            
                CAdd(
                    CSat(lighting.compositeSpecular),
                    CSat(
                        CV(
                            CalculateMicrofacetSpecular(lighting, mat, lighting.albedo, dispersionIndex, time, inputUV, lighting.invertDepth, lighting.useProjectedDepth, sssStrength),
                            CalculateMicrofacetSpecular(lighting, mat, lighting.albedo, dispersionIndex, time, inputUV, lighting.invertDepth, lighting.useProjectedDepth, sssStrength)
                        )
                    )
                )
            
        )
    );

    SetDV(interferenceContribution,
        CAdd(
            CSat(lighting.interferenceColorReflectance),
            CSat(lighting.interferenceColorTransmittance))
    );
    // --- Diffuse Transmittance ---

    // Calculate diffuse transmittance
    
    C3 diffTrans = CalculateDiffuseTransmittance(inputUV, time, dispersionIndex, lighting, mat, sssStrength, baseDiffuseTex, fresTransmittance);
    SetDV(diffuseTransmittance, CAdd(diffTrans, lighting.transmittance[dispersionIndex]));

    // --- Interference Contribution ---
    
    // --- Lighting Calculation ---

   
    // --- Energy Redistribution ---
    // --- Energy Redistribution ---

    // Redistribute excess energy among the different components
    C3 eeDr = lighting.diffuseReflectance[dispersionIndex];
    C3 eeDt = lighting.diffuseTransmittance[dispersionIndex];
    C3 eeSc = ComplexMulCf(lighting.specularContribution[dispersionIndex], ONE3 * specularWeight);
    C3 eeIc = ComplexMulCf(CAdd(lighting.HeatHazeRainbowCaustics, lighting.interferenceContribution[dispersionIndex]), ONE3 * interferenceWeight);
    eeDr = ComplexMulCf(eeDr, ONE3 * diffuseReflectanceWeight);
    eeDt = ComplexMulCf(eeDt, ONE3 * diffuseTransmittanceWeight);
    eeSc = ComplexMulCf(eeSc, ONE3 * specularWeight * laplatianCurvature(depthMap, inputUV, invertDepth, useProjectedDepth).xyz);
    eeIc = ComplexMulCf(eeIc, ONE3 * interferenceWeight);
    
    RedistributeExcessEnergyComplex(eeDr, eeDt, eeSc, eeIc);

    // Assign the redistributed energy back to the lighting components using SetDV
    
    {
        SetDV(diffuseReflectance, eeDr);
    }
    {
        SetDV(diffuseTransmittance, eeDt);
    }
    {
        SetDV(specularContribution, eeSc);
    }
    {
        SetDV(interferenceContribution, eeIc);
    }
    
    {
        SetDV(phaseShift, CV((lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].phaseInterference.totalPhase +
                     lighting.opdAlbedoTransInsideRealChannel[dispersionIndex].phaseInterference.totalPhase) * 0.5,
            (lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].phaseInterference.totalPhase +
                     lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].phaseInterference.totalPhase) * 0.5));
    }
    
    SetDV(phase, CV((TWOPI3 * opdResOutsideReal.opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM, (TWOPI3 * lighting.opdAlbedoTransInsideImagChannel[dispersionIndex].opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM));
    
    SetDV(phaseShiftComplex, lighting.phase[dispersionIndex]);
    {
        SetDV(phaseShiftComplex, CMul(
            lighting.phaseShiftComplex[dispersionIndex],
            lighting.reflectance[dispersionIndex]
        ));
    }
    SetDV(internalComplex, lighting.internalFilmReflectance);
    SetDV(externalComplex, lighting.externalFilmReflectance);
    
    SetDV(totalReflectanceComplex,
        CAdd(
            lighting.internalComplex[dispersionIndex], 
            CMul(
                lighting.externalComplex[dispersionIndex],
                lighting.phaseShiftComplex[dispersionIndex])));
    {
        SetDV(totalReflectanceComplex, CMul(
            lighting.totalReflectanceComplex[dispersionIndex],
            lighting.reflectance[dispersionIndex])
        );
    }
    
    
    {
        SetDV(phaseShiftComplex, lighting.phase[dispersionIndex]);
    }
    {
        SetDV(phaseShiftComplex, CMul(
            lighting.phaseShiftComplex[dispersionIndex],
            lighting.reflectance[dispersionIndex]));
    }
    // Assign the interference intensity using SetDVf
    C3 ic = CAdd(CAdd(
        ComplexPhaseReflect(
            CV(mat.etaR, ZERO3), lighting.cosThetaTransmissionInside.real, mat.roughness, (cos(AnimateTime)*0.5+0.5)), ComplexPhaseReflect(
            CV(mat.etaR, ZERO3), lighting.cosThetaTransmissionOutside.real, mat.roughness, (sin(AnimateTime)*0.5+0.5)))), lighting.interferenceContribution[dispersionIndex]);
    {
        SetDV(interferenceContribution, ic);
    }
    float3 mag = ComplexMagnitude(ic);
    SetDVf(interferenceIntensity, mag);

    // Combine all lighting components into the final result
    float3 combinedLighting =
        (rotateHue(
            saturate(lighting.diffuseReflectance[dispersionIndex].real) +
            saturate(lighting.diffuseTransmittance[dispersionIndex].real) +
            saturate(lighting.specularContribution[dispersionIndex].real) +
            saturate(lighting.interferenceContribution[dispersionIndex].real), lighting.advancedSheen * lighting.NdotV3 + lighting.sheen * lighting.NdotV3)
        );

     // Combine everything into final lighting
    combinedLighting =
        ApplyRainbowLighting(inputUV, time, combinedLighting) *
            lighting.NdotL3;

    // Assign the final lighting result using SetDVf
    SetDVf(totalLighting, combinedLighting);

    return lighting;
}
    
    */




C3 ComplexFromMagnitudePhase(float magnitude, float3 phase)
{
    return CV(magnitude * cos(phase), magnitude * sin(phase));
}

// ---------------------------------------------------------------------------
// Complex microfacet distribution using GGX with an extra phase term.
// (Here, we assume CV() creates a Complex value from real and imag parts.)
C3 MicrofacetDistribution_Complex(float3 N, float3 H, float alpha)
{
    float NdotH = saturate(dot(N, H));
    float denom = (NdotH * NdotH) * (alpha * alpha - 1.0) + 1.0;
    float D = (alpha * alpha) / (PI * denom * denom);

    // Compute an extra phase from the microfacet orientation.
    // For example, use a simple noise based on the H.xy coordinates.
    float3 phi = noise2D(noiseMap1, H.xy * H.z * 10.0); // noise() returns a value in [0, 1]
    phi = phi * TWO3 * PI3; // Map noise to a full phase range

    return ComplexFromMagnitudePhase(D, phi);
}

// ---------------------------------------------------------------------------
// Complex geometry term (G1) for a single direction (view or light).
// We add an extra phase shift psi based on the vector’s xy components.
C3 GeometrySmith_Complex(float3 N, float3 V, float roughness)
{
    float NdotV = saturate(dot(N, V));
    float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
    float G1 = NdotV / (NdotV * (1.0 - k) + k);

    // Add an extra phase from V.xy (for example, a simple oscillatory term).
    float3 psi = sin(V * 10.0); // This is an arbitrary choice.
    psi = psi * PI * 0.5; // Scale the phase shift

    return ComplexFromMagnitudePhase(G1, psi);
}

// ---------------------------------------------------------------------------
// Compute a complex geometry term for both view and light directions.
// We multiply the two complex G1 terms.
C3 GeometrySmith_ComplexCombined(float3 N, float3 V, float3 L, float roughness)
{
    C3 G_V = GeometrySmith_Complex(N, V, roughness);
    C3 G_L = GeometrySmith_Complex(N, L, roughness);
    return CMul(G_V, G_L); // Multiply complex numbers (phases add, amplitudes multiply)
}

// BRDF calculations (Cook-Torrance as base)
inline float3 CookTorranceBRDF(float3 N, float3 V, float3 L, float3 F0, float roughness, float3 n_real, float3 n_imag)
{
    float3 H = safeNormalizef(V + L);
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
    float3 F = CMag(FresnelComplex(F0, NdotH, n_real, n_imag)).real;

    float3 specular = (D * F * G) / max(4.0 * NdotL * NdotV, EPSILON);
    return specular;
}

// ---------------------------------------------------------------------------
// Complex BRDF function that uses complex D and complex G, plus a complex Fresnel term F_complex.
// (Assume F_complex is computed elsewhere using your complex Fresnel calculations.)
C3 ComplexSpecularBRDF(
    float3 N, float3 V, float3 L,
    float alpha, // roughness parameter
    C3 fresnel // complex Fresnel term
)
{
    float3 H = safeNormalizef(V + L);
    C3 D_complex = MicrofacetDistribution_Complex(N, H, alpha);
    C3 G_complex = GeometrySmith_ComplexCombined(N, V, L, alpha);

    // Denominator term: 4 * (N dot V) * (N dot L)
    float denominator = 4.0 * max(dot(N, V), EPSILON) * max(dot(N, L), EPSILON);

    // Multiply the three complex terms: D * G * F.
    C3 spec_complex = CMul(CMul(D_complex, G_complex), fresnel);

    // Get the final specular reflectance by taking the squared magnitude.
    C3 specular = CAbs(spec_complex);
    specular = CMul(specular, specular); // amplitude squared

    return CDiv(specular, CMax(CVV(denominator), CVV(EPSILON3)));
}


LightingComplex PopulateLightingComplexv1(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    int materialIndex,
    float animateSpeed,
    float parallaxScale,
    float normalRadius,
    float sssStrength,
    int dispersionIndex,
    float gamma,
    float exposure,
    float saturation
)
{
    LightingComplex lighting = (LightingComplex) 0;
    float time = AnimateTime;
    MaterialSellmeier mat = CreateMaterial(materialIndex);
    
    // === Weights & Config ===
    float lightingWeight = HeightParamC;
    float diffuseTransmittanceWeight = PhaseOffsetR;
    float diffuseReflectanceWeight = PhaseOffsetG;
    float specularWeight = PhaseOffsetB;
    float interferenceWeight = CosineFactorR;
    
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;
    
    // === Depth, Positions & Normals ===
    lighting.depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    lighting.pixelPos = float3(inputUV, lighting.depth);
    
    float3 normal;
    lighting.TBNf = CalcTBN3f(depthMap, inputUV, invertDepth, useProjectedDepth, NormalRadius, normal);
    lighting.normal = safeNormalizef(normal);
    
    // === Directions (in Tangent Space) ===
    float3 viewWorld = safeNormalizef(viewPos - lighting.pixelPos);
    lighting.viewDir = safeNormalizef(viewWorld);
    lighting.lightDir = safeNormalizef(lightPos - lighting.pixelPos + EPSILON3);
    lighting.halfDir = safeNormalizef(lighting.viewDir + lighting.lightDir + EPSILON3);
    
    // === Dot Products ===
    float NdotV = saturate(dot(lighting.viewDir, lighting.normal));
    float NdotL = saturate(dot(lighting.normal, lighting.lightDir));
    float VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    float HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    float HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    
    lighting.VdotH = VdotH;
    lighting.NdotV3 = NdotV;
    lighting.HdotN = HdotN;
    lighting.HdotL = HdotL;
    lighting.NdotL3 = NdotL;
    
    // === Diffuse Setup ===
    float3 baseDiffuseTex = mat.albedo * diffuse2D(diffuseMap, inputUV).rgb;
    float3 invertedDiffuse = 1.0 - baseDiffuseTex;
    float3 fresnel = lerp(
        FresnelSchlick(baseDiffuseTex, NdotV, FresnelPower),
        FresnelSchlick(invertedDiffuse, 1.0 - NdotV, FresnelReflectance),
        1.0 - NdotV
    );
    mat.albedo = baseDiffuseTex;
    lighting.material = mat;
    lighting.albedo = mat.albedo;
    
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(CV0(lighting.albedo)).real;
    lighting.albedoWavelengthsM = nmToM(CV0(lighting.albedoWavelengthsNM)).real;
    
    // === Dispersion & Optical Axis ===
    float3 dispersionFactor = lerp(
        float3(1.0, 1.0, 1.0),
        float3(0.95, 1.0, 1.05),
        (NdotL * 0.5 + 0.5) * saturate(f8)
    );
    float3 n_o = CalculateRefractiveIndex(CV0(lighting.albedoWavelengthsNM), mat.coeff);
    lighting.opticalAxis = mat.opticalAxis;
    float cosThetaOptic = CDot(CV0(lighting.lightDir), lighting.opticalAxis).real.x;
    float3 n_e_effective = clamp(n_o + NdotL * 0.5 * ONE3 * (cosThetaOptic * cosThetaOptic), ONE3, ONE3 * 2.5);
    
    float3 etaR_wavelength = max(n_e_effective * dispersionFactor, EPSILON3);
    float3 etaI_wavelength = max(n_o * dispersionFactor, EPSILON3);
    
    lighting.nSurrounding = float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding);
    
    // === Microfacet & Specular Terms ===
    lighting.ggxDistribution = DistributionGGX(HdotN, mat.roughness);
    lighting.microfacetSpecular = saturate((lighting.ggxDistribution * GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness))
                                            / max(4.0 * NdotV, EPSILON3));
    
    C3 interference =
        CAbs(InterferenceWithDepthEffect(
            inputUV,
            lighting.depth,
            mat.absorptionCoefficient,
            CV0(lighting.albedoWavelengthsNM),
            etaR_wavelength / SPEED_OF_LIGHT));
    // === Thin Film Interference Phase Shift (Common Calculation) ===
    C3 phaseShift_o = ComplexThinFilmInterference(
        CAdd(interference, ComplexQuantumWave(CV(lighting.albedo, lighting.albedoWavelengthsNM / 1000.0),
                           inputUV, time, (.5 + .5 * cos(time)) * .2 + .2, 1, max(0.0, dot(lighting.opticalAxis.real, lighting.lightDir)))),
        inputUV, time, mToNm(mat.thicknessM).real, mat.etaO, mat.absorptionCoefficient * ONE3, CV0(lighting.albedoWavelengthsNM)
    );
    
    
    C3 phaseShift_e = ComplexThinFilmInterference(
        CAdd(interference, ComplexQuantumWave(CV(lighting.albedo, ZERO3),
                           inputUV, time, (.5 + .5 * sin(time)) * .2 + .2, 2, max(0.0, dot(lighting.opticalAxis.real, lighting.lightDir)))),
        inputUV, time, mToNm(mat.thicknessM).real, mat.etaE, mat.absorptionCoefficient * ONE3, CV0(lighting.albedoWavelengthsNM)
    );
    {SetDV(phaseShift, ComplexLerp(phaseShift_o, phaseShift_e, CV0(lighting.depth)));
    }
    
    float3 eta_ratio = mat.nSurrounding / mat.etaR; // assuming these are per-channel
    float3 k_ratio = mat.absorptionCoefficient / max(mat.absorptionCoefficient, EPSILON3); // if you use a complex absorption term

// Compute cosine of the incident angle:
    float cosTheta = saturate(dot(lighting.normal, lighting.viewDir));

// Half-vector from view and light directions:
    float3 H = safeNormalizef(lighting.viewDir + lighting.lightDir);

//
    C3 F_complex = FresnelComplex(eta_ratio, k_ratio, cosTheta, /*cosThetaT*/sqrt(max(ONE3 - (1.0 - cosTheta) * (1.0 - cosTheta), EPSILON3)));
    
    
    // === Transmission Calculations ===
    float3 sinThetaIncident = sqrt(saturate(ONE3 - NdotL * NdotL));
    lighting.cosThetaTransmissionInside = CV(
        sqrt(saturate(ONE3 - (lighting.nSurrounding / etaR_wavelength) * (lighting.nSurrounding / etaR_wavelength) * sinThetaIncident * sinThetaIncident)),
        sqrt(saturate(ONE3 - (lighting.nSurrounding / etaI_wavelength) * (lighting.nSurrounding / etaI_wavelength) * sinThetaIncident * sinThetaIncident))
    );
    lighting.cosThetaTransmissionOutside = CV(
        sqrt(saturate(ONE3 - (etaR_wavelength / lighting.nSurrounding) * (etaR_wavelength / lighting.nSurrounding) * sinThetaIncident * sinThetaIncident)),
        sqrt(saturate(ONE3 - (etaI_wavelength / lighting.nSurrounding) * (etaI_wavelength / lighting.nSurrounding) * sinThetaIncident * sinThetaIncident))
    );
    
    
    lighting.internalFilmReflectance = CV(
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaR, NdotL, lighting.cosThetaTransmissionInside.real),
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaI, NdotL, lighting.cosThetaTransmissionInside.imag)
    );
    lighting.externalFilmReflectance = CV(
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaR, NdotL, lighting.cosThetaTransmissionOutside.real),
        FresnelReflectanceFromFilm2(mat.nSurrounding, mat.etaI, NdotL, lighting.cosThetaTransmissionOutside.imag)
    );
    
    float3 dielectricReflectance = float3(0.04, 0.04, 0.04); // F0 for dielectrics
    float3 metallicReflectance = mat.metallicReflectance; // RGB F0 for metals
    
    C3 specularBRDF = ComplexSpecularBRDF(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness,
        CV0(CalculateF0(mat.metallic, dielectricReflectance, metallicReflectance)));
    
    // === Specular BRDF Components ===
   /* float3 dielectricReflectance = float3(0.04, 0.04, 0.04);
    float3 metallicReflectance = mat.metallicReflectance;
    float3 F02 = CalculateF0(mat.metallic, dielectricReflectance, metallicReflectance);
    
    lighting.cookTorrenceSpecular = CookTorranceSpecularPBR(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness, F02, mat.metallic);
    lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
    float3 tangent = CalcTBN(lighting.normal)[0];
    lighting.advancedSheen = CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, tangent, mat.roughness, SHEEN_ALBEDO_TINT);
    lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) +
                                   DistributionGGX(HdotN, mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER) * ClearCoatFresnel(NdotV);
    lighting.iridescence = CalculateIridescence(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.albedo);
    lighting.specularWithSheen = lighting.cookTorrenceSpecular + lighting.sheen + lighting.advancedSheen;
    
    C3 reflectedTransmittedPolarization = CalculateReflectedTransmittedPolarization(lighting.nSurrounding, etaR_wavelength, lighting.normal, NdotL, lighting.cosThetaTransmissionInside.real);
    C3 spec0 = CV(ZERO3, lighting.specularWithSheen + lighting.clearCoatSpecular + lighting.iridescence);
    lighting.compositeSpecular = CSat(CAdd(reflectedTransmittedPolarization, spec0));
    */
    
    
    
// --- Now compute our complex microfacet specular term ---

// 1. Complex GGX distribution D with an extra phase.
    C3 D_complex = MicrofacetDistribution_Complex(lighting.normal, H, mat.roughness);

// 2. Complex geometry term G that multiplies the view and light geometry.
    C3 G_complex = GeometrySmith_ComplexCombined(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness);

// 4. Multiply these complex terms together:
    C3 spec_complex = CMul(CMul(D_complex, G_complex), F_complex);

// 5. Extract the specular reflectance by taking the squared magnitude.
    float3 complexSpecular = CAbs(spec_complex).real;
    complexSpecular = complexSpecular * complexSpecular; // now in the same “units” as Cook–Torrance

// --- Now blend with your additional effects as before ---

// Compute the real-valued contributions (sheen, clear-coat, iridescence)
    lighting.cookTorrenceSpecular = inputUV.y > 0.5 ? specularBRDF.real : complexSpecular; // our new specular from complex math
    lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
    Complex3x3 tbn = CalcTBN3(depthMap, inputUV, invertDepth, useProjectedDepth);;
    float3 tangent = CMul3x3(tbn, tbn.tangent).real;
    lighting.advancedSheen = saturate(CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, tangent, mat.roughness, SHEEN_ALBEDO_TINT));
    lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) +
                               DistributionGGX(HdotN, mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER) * ClearCoatFresnel(NdotV);
    lighting.iridescence = CSatMag(CalculateIridescence(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.albedo)).real;
    lighting.specularWithSheen = lighting.cookTorrenceSpecular + lighting.sheen + lighting.advancedSheen;

// Optionally, combine with a polarization term as before:
    C3 reflectedTransmittedPolarization = CalculateReflectedTransmittedPolarization(lighting.nSurrounding, etaR_wavelength, lighting.normal, NdotL, lighting.cosThetaTransmissionInside.real);
    C3 spec0 = CV(ZERO3, lighting.specularWithSheen + lighting.clearCoatSpecular + lighting.iridescence);

// Final composite specular is the complex sum:
    lighting.compositeSpecular = CSat(CAdd(reflectedTransmittedPolarization, spec0));
    
    
    // === Optical Path & Film Interference ===
    PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(CV0(lighting.viewPos), CV0(lighting.pixelPos), mat.thicknessM, lighting.normal);
    OpticalPathResult opticalPathDiff = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, pathMeasurement,
                                                               mat.dispersionCoefficientsNm2[dispersionIndex],
                                                               mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.real);
    C3 coherenceLengthM = mat.coherenceLengthM;
    lighting.filmReflectedPolarization = CSat(
        CV(
            ApplyReflectanceCoherence(CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).real, opticalPathDiff, length(coherenceLengthM.real)),
            ApplyReflectanceCoherence(CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).imag, opticalPathDiff, length(coherenceLengthM.real))
        )
    );
    
    // === Interference Contributions ===
    float3 interferenceColorReflectanceR = max(
        (1.0 - lighting.albedo) *
            InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor,
                                 mat.thicknessM.real, etaR_wavelength, lighting.cosThetaTransmissionOutside.real, lighting.nSurrounding),
        ZERO3
    );
    float3 interferenceColorReflectanceI = max(
        (1.0 - lighting.albedo) *
            InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor,
                                 mat.thicknessM.real, etaI_wavelength, lighting.cosThetaTransmissionOutside.imag, lighting.nSurrounding),
        ZERO3
    );
    lighting.interferenceColorReflectance = CSat(CV(interferenceColorReflectanceR, interferenceColorReflectanceI));
    
    float3 interferenceColorTransmittanceR = lighting.albedo *
        InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor,
                             mat.thicknessM.real, etaR_wavelength, lighting.cosThetaTransmissionInside.real, lighting.nSurrounding);
    float3 interferenceColorTransmittanceI = lighting.albedo *
        InterferenceThinFilm(inputUV, time, lighting.albedoWavelengthsM * dispersionFactor,
                             mat.thicknessM.real, etaI_wavelength, lighting.cosThetaTransmissionInside.imag, lighting.nSurrounding);
    lighting.interferenceColorTransmittance = CSat(CV(interferenceColorTransmittanceR, interferenceColorTransmittanceI));
    
    lighting.transmittedPolarization = CSat(ComplexSub(C11, CMul(lighting.filmReflectedPolarization, lighting.interferenceColorTransmittance)));
    
    C3 fresReflectance = CalculateFresnelReflectance(CV(etaR_wavelength, ZERO3), lighting.normal, lighting.lightDir);
    C3 fresTransmittance = ComplexSub(C11, fresReflectance);
    lighting.viewToPixel = DistanceMFromViewToAB(CV0(lighting.viewPos), CV0(lighting.pixelPos),
                                                 CV0(lighting.pixelPos + lighting.viewDir * mat.thicknessM.real));
    
    // Compute optical path differences once and reuse
    OpticalPathResult opdResInsideReal = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
                                                                mat.dispersionCoefficientsNm2[dispersionIndex],
                                                                mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.real);
    OpticalPathResult opdResInsideImag = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
                                                                mat.dispersionCoefficientsNm2[dispersionIndex],
                                                                mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.imag);
    SetDVo(opdAlbedoTransInsideRealChannel, opdResInsideReal);
    SetDVo(opdAlbedoTransInsideImagChannel, opdResInsideImag);
    SetDVo(opdAlbedoTransOutsideRealChannel, OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
                                                                    mat.dispersionCoefficientsNm2[dispersionIndex],
                                                                    mat.absorptionCoefficient, lighting.cosThetaTransmissionOutside.real));
    SetDVo(opdAlbedoTransOutsideImagChannel, OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
                                                                    mat.dispersionCoefficientsNm2[dispersionIndex],
                                                                    mat.absorptionCoefficient, lighting.cosThetaTransmissionOutside.imag));
    
    // === Effective Refractive Indices (Grouped) ===
    SetDV(iorEffectiveInsideReflectance, CV(
        CalculateEffectiveRefractiveIndexReflectReal(lighting.lightDir, lighting.opticalAxis.real, lighting.reflectance[dispersionIndex].real, opdResInsideReal.refractiveIndex),
        CalculateEffectiveRefractiveIndexReflectImag(lighting.lightDir, lighting.opticalAxis.real, lighting.reflectance[dispersionIndex].imag, opdResInsideImag.refractiveIndex)
    ));
    SetDV(iorEffectiveOutsideReflectance, CV(
        CalculateEffectiveRefractiveIndexReflectReal(lighting.lightDir, lighting.opticalAxis.real, lighting.reflectance[dispersionIndex].real, opdResInsideReal.refractiveIndex),
        CalculateEffectiveRefractiveIndexReflectImag(lighting.lightDir, lighting.opticalAxis.real, lighting.reflectance[dispersionIndex].imag, opdResInsideImag.refractiveIndex)
    ));
    SetDV(iorEffectiveInsideTransmittance, CV(
        CalculateEffectiveRefractiveIndexTransmitReal(lighting.lightDir, lighting.opticalAxis.real, lighting.transmittance[dispersionIndex].real, opdResInsideReal.refractiveIndex),
        CalculateEffectiveRefractiveIndexTransmitImag(lighting.lightDir, lighting.opticalAxis.real, lighting.transmittance[dispersionIndex].imag, opdResInsideImag.refractiveIndex)
    ));
    SetDV(iorEffectiveOutsideTransmittance, CV(
        CalculateEffectiveRefractiveIndexTransmitReal(lighting.lightDir, lighting.opticalAxis.real, lighting.transmittance[dispersionIndex].real, opdResInsideReal.refractiveIndex),
        CalculateEffectiveRefractiveIndexTransmitImag(lighting.lightDir, lighting.opticalAxis.real, lighting.transmittance[dispersionIndex].imag, opdResInsideImag.refractiveIndex)
    ));
    
    
    
    lighting.HeatHazeRainbowCaustics = HeatHazeRainbowCaustics(lighting, inputUV, time, f1, f2, f3, dispersionIndex);
    
    
    
    float3 reflectanceCorrectionInside = max(
        EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideReflectance[dispersionIndex].real,
                                                 lighting.iorEffectiveInsideReflectance[dispersionIndex].real, 0.5),
                                             lighting.opticalAxis.real), ZERO3);
    float3 reflectanceCorrectionOutside = max(
        EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideReflectance[dispersionIndex].imag,
                                                 lighting.iorEffectiveInsideReflectance[dispersionIndex].imag, 0.5),
                                             lighting.opticalAxis.real), ZERO3);
    float3 transmittanceCorrectionInside = max(
        EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideTransmittance[dispersionIndex].real,
                                                 lighting.iorEffectiveInsideTransmittance[dispersionIndex].real, 0.5),
                                             lighting.opticalAxis.real), ZERO3);
    float3 transmittanceCorrectionOutside = max(
        EffectiveRefractiveIndexCorrection(lerp(lighting.iorEffectiveOutsideTransmittance[dispersionIndex].imag,
                                                 lighting.iorEffectiveInsideTransmittance[dispersionIndex].imag, 0.5),
                                             lighting.opticalAxis.real), ZERO3);
    
    // Apply corrections
    {

    SetDV(transmittance, CMul(lighting.transmittance[dispersionIndex],
                                    CV(transmittanceCorrectionInside, transmittanceCorrectionOutside)));
    }
    
    // === Coherence, Energy & Absorption Adjustments (Grouped) ===
    {
        float3 reflectanceCoherence = max(ApplyReflectanceCoherence(lighting.reflectance[dispersionIndex].imag,
                                                                opdResInsideImag, length(mat.coherenceLengthM.real)), EPSILON3);
    
        SetDV(reflectance, CSat(
            CMul(CSat(lighting.reflectance[dispersionIndex]),
                       CV(reflectanceCoherence, reflectanceCoherence))
        ));
    }
    
    float3 transmittanceCoherence = max(CoherenceFactor(opdResInsideReal.opticalMeasurement.PathLengthM, length(mat.coherenceLengthM.real)), ZERO3) +
                                    max(CoherenceFactor(opdResInsideReal.opticalMeasurement.PathLengthM, length(mat.coherenceLengthM.real)), ZERO3);
    {SetDV(transmittance, CSat(
        CMul(CSat(lighting.transmittance[dispersionIndex]),
                   CSat(CAbs(CV(transmittanceCoherence, transmittanceCoherence))))
    ));
    }
    
    float3 energyReal = max(lighting.reflectance[dispersionIndex].real, ZERO3);
    float3 energyImag = max(lighting.reflectance[dispersionIndex].imag, ZERO3);
    {SetDV(reflectance, CSat(
        CMul(CSat(CAbs(lighting.reflectance[dispersionIndex])),
                   CSat(CAbs(CV(energyReal, energyImag)))
    )));
    }
    energyReal = max(lighting.transmittance[dispersionIndex].real, ZERO3);
    energyImag = max(lighting.transmittance[dispersionIndex].imag, ZERO3);
    {
            
        
        C3 vTp[3];
        vTp = lighting.transmittance;
        vTp[dispersionIndex] = CSat(
        CMul(CSat(CAbs(lighting.transmittance[dispersionIndex])),
                   CSat(CAbs(CV(energyReal, energyImag)))));
        lighting.transmittance = vTp;
    }
    
    float3 absorption = max(exp(-mat.absorptionCoefficient * opdResInsideImag.opticalMeasurement.PathLengthM), ZERO3) +
                        max(exp(-mat.absorptionCoefficient * opdResInsideImag.opticalMeasurement.PathLengthM), ZERO3);
    {SetDV(transmittance, CMul(CSat(CAbs(lighting.transmittance[dispersionIndex])),
                                    CSat(CAbs(CV(absorption, absorption)))));
    }
    // === Diffuse & Specular Contributions ===
    {SetDV(diffuseReflectance, CAdd(CSat(CAbs(lighting.reflectance[dispersionIndex])),
                                          CSat(CAbs(CAdd(CSat(CAbs(lighting.filmReflectedPolarization)),
                                                                      CSat(CAbs(fresReflectance)))))));
    }
    C3 microSpecular = CalculateMicrofacetSpecular(lighting, mat, lighting.albedo, dispersionIndex, time, inputUV, invertDepth, useProjectedDepth, sssStrength);
    SetDV(specularContribution, CSat(
        CAbs(CAdd(CSat(lighting.compositeSpecular), CSat(microSpecular)))
    ));
    SetDV(interferenceContribution, CAdd(CSat(CAbs(lighting.interferenceColorReflectance)),
                                               CSat(CAbs(lighting.interferenceColorTransmittance))));
    
    C3 diffTrans = CalculateDiffuseTransmittance(inputUV, time, dispersionIndex, lighting, mat, sssStrength, mat.albedo, fresTransmittance);
    SetDV(diffuseTransmittance, CAdd(diffTrans, lighting.transmittance[dispersionIndex]));
    
    // === Energy Redistribution ===
    C3 eeDr = ComplexMulCf(lighting.diffuseReflectance[dispersionIndex], ONE3 * diffuseReflectanceWeight);
    C3 eeDt = ComplexMulCf(lighting.diffuseTransmittance[dispersionIndex], ONE3 * diffuseTransmittanceWeight);
    C3 eeSc = ComplexMulCf(lighting.specularContribution[dispersionIndex], ONE3 * specularWeight);
    C3 eeIc = ComplexMulCf(CAdd(lighting.HeatHazeRainbowCaustics, lighting.interferenceContribution[dispersionIndex]), ONE3 * interferenceWeight);
    
    float totalWeight = diffuseReflectanceWeight + diffuseTransmittanceWeight + specularWeight + interferenceWeight;
    float normalizationFactor = max(totalWeight, 1.0);
    
    eeDr = ComplexMulCf(eeDr, ONE3 * diffuseReflectanceWeight / normalizationFactor);
    eeDt = ComplexMulCf(eeDt, ONE3 * diffuseTransmittanceWeight / normalizationFactor);
    eeSc = ComplexMulCf(eeSc, ONE3 * specularWeight / normalizationFactor);
    eeIc = ComplexMulCf(eeIc, ONE3 * interferenceWeight / normalizationFactor);
    
    RedistributeExcessEnergyComplex(eeDr, eeDt, eeSc, eeIc);
    {SetDV(diffuseReflectance, eeDr);
    }
    {SetDV(diffuseTransmittance, eeDt);
    }
    {SetDV(specularContribution, eeSc);
    }
    {SetDV(interferenceContribution, eeIc);
    }
    
    // === Final Phase Adjustments ===
    C3 phaseCombined = CV(
        0.5 * (opdResInsideReal.phaseInterference.totalPhase + opdResInsideReal.phaseInterference.totalPhase),
        0.5 * (opdResInsideImag.phaseInterference.totalPhase + opdResInsideImag.phaseInterference.totalPhase)
    );
    {SetDV(phaseShift, phaseCombined);
    }
    C3 phaseVal = CV(
        TWOPI3 * min(opdResInsideReal.opticalMeasurement.PathDifferenceM, opdResInsideReal.opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM,
        TWOPI3 * min(opdResInsideImag.opticalMeasurement.PathDifferenceM, opdResInsideImag.opticalMeasurement.PathDifferenceM) / lighting.albedoWavelengthsM
    );
    
    {
        SetDV(phase, phaseVal);
    }
    
    SetDV(phaseShiftComplex, lighting.phaseShift[dispersionIndex]);
    {
        SetDV(phaseShiftComplex, CMul(lighting.phaseShiftComplex[dispersionIndex], lighting.reflectance[dispersionIndex]));
    }
    SetDV(internalComplex, lighting.internalFilmReflectance);
    SetDV(externalComplex, lighting.externalFilmReflectance);
    SetDV(totalReflectanceComplex, CAdd(lighting.internalComplex[dispersionIndex],
                                               CMul(lighting.externalComplex[dispersionIndex], lighting.phaseShiftComplex[dispersionIndex])));
    {
        SetDV(totalReflectanceComplex, CMul(lighting.totalReflectanceComplex[dispersionIndex], lighting.reflectance[dispersionIndex]));
    }
    {
        SetDV(phaseShiftComplex, lighting.phaseShift[dispersionIndex]);
    }
    {
        SetDV(phaseShiftComplex, CMul(lighting.phaseShiftComplex[dispersionIndex], lighting.reflectance[dispersionIndex]));
    }
    
    C3 ic = CAdd(
        CAdd(
            ComplexPhaseReflect(CV(mat.etaR, mat.etaI),
                lighting.cosThetaTransmissionInside, mat.roughness, cos(time)),
            ComplexPhaseReflect(CV(mat.etaR, mat.etaI), lighting.cosThetaTransmissionOutside, mat.roughness, sin(time))
        ),
        lighting.interferenceContribution[dispersionIndex]
    );
    {
        SetDV(interferenceContribution, ic);
    }
    
    C3 interferenceIntensity = CSatMag(ic);
   { SetDVf(interferenceIntensity, interferenceIntensity.real);
    }
    
    // === Final Combined Lighting Calculation ===
    float3 combinedLighting = saturate(
        saturate(CMag(lighting.diffuseReflectance[dispersionIndex]).real) +
        saturate(CMag(lighting.diffuseTransmittance[dispersionIndex]).real) +
        saturate(CMag(lighting.specularContribution[dispersionIndex]).real) +
        saturate(CMag(lighting.interferenceContribution[dispersionIndex]).real)
    );
   // combinedLighting = saturate(ApplyRainbowLighting(lighting, inputUV, time, combinedLighting) * NdotL + combinedLighting);
    SetDVf(totalLighting, combinedLighting);
    
    // Final saturation of reflectance/transmittance
    {
        SetDV(reflectance, CMag(lighting.reflectance[dispersionIndex]));
    }
    {
        SetDV(transmittance, CMag(lighting.transmittance[dispersionIndex]));
    }
    
    return lighting;
}


//------------------------------------------------------------------------------
// C3 Structure (assumed defined elsewhere):
// struct C3 { float3 real; float3 imag; };
//------------------------------------------------------------------------------

// ComputeVolumetricWaveInterference:
// Propagates a unit-amplitude complex wave field through a volume of given depth,
// applying phase shifts (via diffraction-like propagation) and absorption.
// The final wave field encodes the resulting amplitude and phase.
// Parameters:
//   uv            - The input texture coordinates (for spatial modulation)
//   time          - The current time (used for animation)
//   TBN           - Tangent-Bitangent-Normal matrix (for orientation, if needed)
//   depth         - The optical depth the wave must travel
//   mat           - Material properties (must include absorptionCoefficient)
//   parallaxScale - A scale factor for additional displacement effects
C3 ComputeVolumetricWaveInterferencePhase(float3 wavelengthsNM, float2 uv, float time, float3x3 TBN, float depth, MaterialSellmeier mat, float parallaxScale)
{
    // Number of propagation steps: higher number yields more accurate simulation.
    const int numSteps = 8;
    float stepSize = depth / numSteps;
    
    // Initialize the wave with unit amplitude and zero phase.
    float3 wv = normalize(noise2D(noiseMap1, uv, cos(time)));
    C3 wave = CVV(wv);
    
    // Wavenumber: k = 2*pi / wavelength.
    // Here we assume a representative wavelength of 550nm (green light) in normalized units.
    float3 k = 6.2831853 / wavelengthsNM;
    
    // Propagate the wave in numSteps steps.
    for (int i = 0; i < numSteps; i++)
    {
        // Current depth for this step (for absorption calculation)
        float currentDepth = stepSize * float(i + 1) * .1;
        
        // Compute the phase shift for this step.
        float3 phase = k * stepSize;
        // Generate the complex phase shift: exp(i * phase).
        C3 phaseShift = CExp(CV0(phase));
        // Apply the phase shift to the current wave.
        wave = CMul(wave, phaseShift);
        
        // Attenuate the wave amplitude based on the material's absorption coefficient.
        C3 attenuation = CExp(CMul(CV0(-mat.absorptionCoefficient), CV0(currentDepth)));
        wave = CMul(wave, attenuation);
    }
    
    // Optional: Add a small displacement oscillation modulated by the texture coordinate and time.
    // This can simulate a subtle parallax or dynamic wavefront distortion.
    float3 noiseVal = wv * 0.1;
    float3 oscillation = float3(
        sin((uv.x - 0.5) * noiseVal.x + 0.5 + time) * noiseVal.y,
        sin((uv.y - 0.5) * noiseVal.y + 0.5 + time) * noiseVal.z,
        cos((depth - 0.5) * noiseVal.z + 0.5 + time) * noiseVal.x) * parallaxScale;
    C3 displacement = CV0(mul(TBN, oscillation));
    
    // Combine the displacement with the propagated wave.
    wave = CAdd(wave, displacement);
    
    return wave;
}

// Assumed C3 structure:
// struct C3 { float3 real; float3 imag; };

// Computes the complex wave field after propagating through a volume.
// Parameters:
//   uv           - texture coordinate (for spatial variation)
//   time         - current time (for animation)
//   TBN          - tangent-bitangent-normal matrix for orientation
//   depth        - depth value at the pixel (distance through the medium)
//   mat          - material properties (includes absorptionCoefficient, etc.)
//   parallaxScale- scale factor for any additional displacement effects
C3 ComputeVolumetricWaveInterference2(float3 wavelengthsNM, float2 uv, float time, float3x3 TBN, float depth, MaterialSellmeier mat, float parallaxScale)
{
    // Number of propagation steps (adjust for quality/performance)
    const int numSteps = 8;
    float stepSize = depth / numSteps;
    
    // Start with a unit amplitude wave (phase = 0)
    C3 wave = CV(float3(1.0, 1.0, 1.0), float3(0.0, 0.0, 0.0));
    
    // Representative wavenumber (assume 550nm light in normalized units)
    float3 k = 6.2831853 / wavelengthsNM; // 2*pi / wavelength
    
    // Propagate the wave through the volume, accumulating phase and absorption.
    for (int i = 0; i < numSteps; i++)
    {
        float currentDepth = stepSize * (i + 1);
        // Compute the phase shift for this step.
        float3 phase = k * stepSize;
        // Create the complex phase shift: exp(i * phase)
        C3 phaseShift = CExp(CV0(phase));
        // Multiply the current wave by the phase shift.
        wave = CMul(wave, phaseShift);
        
        // Apply absorption: attenuate amplitude exponentially.
        float3 attenuation = exp(-mat.absorptionCoefficient * currentDepth);
        wave.real *= attenuation;
        wave.imag *= attenuation;
    }
    
    // Optional additional modulation: a small displacement oscillation.
    float3 oscillation = ONE3 * sin(uv.x * 10.0 + time) * 0.1 * parallaxScale;
    C3 displacement = CV(oscillation, float3(0.0, 0.0, 0.0));
    wave = CAdd(wave, displacement);
    
    return wave;
}

// Computes a caustic intensity (RGB) based on holographic diffraction effects.
// Parameters:
//   lighting     - lighting structure containing, e.g., NdotL for light incidence
//   uv           - texture coordinate for the current pixel
//   time         - animated time factor
//   parallaxScale- scale factor for spatial offsets
float3 ComputeHolographicCaustics(LightingComplex lighting, float2 uv, float time, float parallaxScale)
{
    float3 caustic = float3(0.0, 0.0, 0.0);
    float totalWeight = 0.0;
    
    float2 oosz = GetOosz(diffuseMap);
    // For simplicity, sample a 3x3 grid around the pixel.
    for (int ix = -1; ix <= 1; ix++)
    {
        for (int iy = -1; iy <= 1; iy++)
        {
            float2 offset = float2(ix, iy) * parallaxScale;
            
            float2 sampleUV = uv + offset * oosz * cos(time) * 10;
            
            // Compute a phase based on the offset magnitude and time.
            float2 phase = (offset - 0.5) *
            .010 * cos(length(offset) + time);
            float2 weight = sin(offset * phase);
            // For demonstration, assume unit white intensity modulated by weight.
            float3 sampleIntensity = ((diffuse2D(diffuseMap, uv + depth2D(depthMap, uv)
            * oosz * 10 * offset * (1 - depth2D(depthMap, uv)
            * oosz * cos(time) * 10 * phase)).
            xyz)) * length(weight);
            caustic += sampleIntensity;
            totalWeight += length(weight);
        }
    }
    
    caustic /= max(totalWeight, 0.0001);
    // Modulate caustics by the cosine of the light incidence angle.
   // caustic *= lighting.NdotL3;
    return caustic;
}

// Computes a specular reflection term using a Cook-Torrance microfacet model
// with added holographic interference modulation.
// Parameters:
//   normal   - surface normal at the pixel
//   viewDir  - normalized view direction
//   lightDir - normalized light direction
//   roughness- material roughness [0,1]
//   F0       - base Fresnel reflectance at normal incidence (RGB)
float3 CookTorranceSpecularPBR(float3 normal, float3 viewDir, float3 lightDir, float roughness, float3 F0)
{
    float3 halfDir = normalize(viewDir + lightDir);
    float NdotH = saturate(dot(normal, halfDir));
    
    // GGX normal distribution function (NDF)
    float alpha = roughness * roughness;
    float alphaSqr = alpha * alpha;
    float denom = max(EPSILON, NdotH * NdotH * (alphaSqr - 1.0) + 1.0);
    float D = alphaSqr / (3.14159265 * denom * denom);
    
    // Geometry term using Smith's approximation
    float NdotV = saturate(dot(normal, viewDir));
    float NdotL = saturate(dot(normal, lightDir));
    float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
    float G_V = NdotV / max(EPSILON, NdotV * (1.0 - k) + k);
    float G_L = NdotL / max(EPSILON, NdotL * (1.0 - k) + k);
    float G = G_V * G_L;
    
    // Fresnel term using Schlick's approximation
    float HdotV = saturate(dot(halfDir, viewDir));
    float3 F = F0 + (1.0 - F0) * pow(max(EPSILON, 1.0 - HdotV), 5.0);
    
    // --- Holographic Interference Enhancement ---
    // Modulate Fresnel reflectance with a sinusoidal interference factor,
    // simulating spectral dispersion or thin-film effects.
    float interference = 0.5 + 0.5 * sin(10.0 * NdotH + roughness * 5.0);
    F *= interference;
    
    float denominator = max(EPSILON, 4.0 * NdotV * NdotL);
    float3 specular = (D * G * F) / denominator;
    return specular;
}

// Returns the phase factor for diffuse reflections.
// Diffuse light is incoherent so interference is effectively absent.
float PhaseFactorDiffuse()
{
    return 0.9;
}


// Computes a phase factor for interference between coherent light paths.
// Parameters:
//   pathDifference - difference in optical path length between two interfering beams
//   coherenceLength - characteristic coherence length of the light source
float3 PhaseFactorInterference(float3 pathDifference, float3 coherenceLength)
{
    // A Gaussian falloff for coherence
    float3 factor = exp(-(pathDifference / coherenceLength) * (pathDifference / coherenceLength));
    return saturate(factor);
}


// Computes the phase factor for specular reflection.
// As surface roughness increases, microfacet phase differences reduce coherence.
float3 PhaseFactorSpecular(float roughness, float3 wavelengthsNM)
{
    // Use a simple model: higher roughness relative to wavelength lowers coherence.
    float3 factor = exp(-(6.2831853 * roughness / wavelengthsNM) * (6.2831853 * roughness / wavelengthsNM));
    return saturate(factor);
}

// Returns a phase factor for caustic interference.
// For highly coherent light sources, return 1.0; otherwise, reduce based on exposure.
float3 PhaseFactorCaustics(float3 coherence, float exposureTime)
{
    // A simple model: higher exposure time (averaging) reduces visible interference.
    return saturate(coherence / (1.0 + exposureTime));
}

// ApplyPostProcessing:
// Applies gamma correction, exposure scaling, and saturation adjustment
// to the computed lighting intensity.
// Parameters:
//    combinedLighting - the computed RGB lighting intensity (pre tone-mapping)
//    gamma            - gamma correction factor (e.g., 2.2)
//    exposure         - exposure multiplier (e.g., 1.0)
//    saturation       - saturation adjustment factor (1.0 = no change)
float3 ApplyPostProcessing(float3 combinedLighting, float gamma, float exposure, float saturation)
{
    // --- Exposure ---
    // Multiply the computed lighting intensity by an exposure factor.
    float3 color = combinedLighting * exposure;

    // --- Gamma Correction ---
    // Apply gamma correction by raising the color to the power of (1/gamma).
    color = pow(abs(color), max(EPSILON, 1.0 / gamma));

    // --- Saturation Adjustment ---
    // Compute the grayscale luminance using standard Rec. 709 weights.
    float luminance = max(0, dot(color, float3(0.2126, 0.7152, 0.0722)));
    // Mix the original color with its grayscale version based on saturation.
    // A saturation value of 1.0 leaves the color unchanged, while lower values desaturate.
    color = lerp(float3(luminance, luminance, luminance), color, saturation);

    return saturate(color);
}


LightingComplex PopulateLightingComplex(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    MaterialSellmeier mat,
    float animateSpeed,
    float parallaxScale,
    float normalRadius,
    float sssStrength,
    int dispersionIndex,
    float gamma,
    float exposure,
    float saturation
)
{
    // Initialize our complex lighting structure.
    LightingComplex lighting = (LightingComplex) 0;
    float time = AnimateTime;
    
    // === Configuration & Global Weights ===
    // (These values can be tuned for greater interference/diffraction emphasis.)
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;
    
    // === Geometry, Depth, and TBN Calculation ===
    lighting.depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);
    lighting.pixelPos = float3(inputUV, lighting.depth);
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    
    float3 normal;
    lighting.TBNf = CalcTBN3f(depthMap, inputUV, invertDepth, useProjectedDepth, NormalRadius, normal);
    
    
    // === Tangent Space Directions ===
    float3 viewWorld = normalize(lighting.viewPos - lighting.pixelPos);
    lighting.viewDir = viewWorld;
    lighting.lightDir = normalize((lighting.lightPos - lighting.pixelPos) + EPSILON3);
    lighting.halfDir = normalize((lighting.viewDir + lighting.lightDir) + EPSILON3);
    lighting.normal = normalize(normal);
    
    // === Dot Products for Shading ===
    float NdotV = saturate(dot(lighting.viewDir, lighting.normal));
    float NdotL = saturate(dot(lighting.normal, lighting.lightDir));
    float VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    float HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    float HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    
    lighting.VdotH = VdotH;
    lighting.NdotV3 = NdotV;
    lighting.HdotN = HdotN;
    lighting.HdotL = HdotL;
    lighting.NdotL3 = NdotL;
    
    // === Base Diffuse and Albedo Setup ===
    float3 baseDiffuse = mat.albedo * diffuse2D(diffuseMap, inputUV).rgb;
    lighting.albedo = baseDiffuse;
    lighting.material = mat;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(CV0(lighting.albedo)).real;
    lighting.albedoWavelengthsM = nmToM(CV0(lighting.albedoWavelengthsNM)).real;
    
    lighting.ggxDistribution = DistributionGGX(lighting.HdotN, mat.roughness);
    
    lighting.iridescence = Iridescence(inputUV, lighting.viewDir, lighting.normal, lighting.albedo, mat.thicknessM.real.x, mat, mat.etaR);
    lighting.opticalAxis = mat.opticalAxis;
    lighting.nSurrounding = ONE3 * mat.nSurrounding;
    
    
    float3 eta_ratio = mat.nSurrounding / mat.etaR; // assuming these are per-channel
    float3 k_ratio = mat.absorptionCoefficient / max(mat.absorptionCoefficient, EPSILON3); // if you use a complex absorption term

// Compute cosine of the incident angle:
    float cosTheta = saturate(dot(lighting.normal, lighting.viewDir));

    C3 F_complex = FresnelComplex(eta_ratio, k_ratio, cosTheta, /*cosThetaT*/sqrt(max(ONE3 - (1.0 - cosTheta) * (1.0 - cosTheta), EPSILON3)));
    
    //C3 F_complex = FresnelComplex(mat.nSurrounding / mat.etaR, mat.absorptionCoefficient, saturate(dot(lighting.normal, lighting.viewDir)), sqrt(max(ONE3 - (1.0 - saturate(dot(lighting.normal, lighting.viewDir))) * (1.0 - saturate(dot(lighting.normal, lighting.viewDir))), EPSILON3)));
    
    // === Dispersion, Optical Axis & Polarization Setup ===
    // Simulate dispersion via slight RGB shifts – ideal for meta-materials.
    float3 dispersionFactor = lerp(float3(1.0, 1.0, 1.0),
                                   float3(0.95, 1.0, 1.05),
                                   (NdotL));
    
    float3 n_o = CalculateRefractiveIndex(CV0(lighting.albedoWavelengthsNM), mat.coeff);
    
    
      
    float3 cosThetaOptic = CSat(CDot(CV0(lighting.lightDir), lighting.opticalAxis)).real;
    
    float3 n_e_effective = clamp(n_o + NdotL * 0.5 * ONE3 * (cosThetaOptic * cosThetaOptic), ONE3, ONE3 * 1.5);
    
    float3 etaR_wavelength = max(n_e_effective * dispersionFactor, EPSILON3);

    float3 etaI_wavelength = max(n_o * dispersionFactor, EPSILON3);
  
     
    float3 sinThetaIncident = sqrt(saturate(ONE3 - NdotL * NdotL));
    lighting.cosThetaTransmissionInside = CV(
        sqrt(saturate(ONE3 - (lighting.nSurrounding / etaR_wavelength) * (lighting.nSurrounding / etaR_wavelength) * sinThetaIncident * sinThetaIncident)),
        sqrt(saturate(ONE3 - (lighting.nSurrounding / etaI_wavelength) * (lighting.nSurrounding / etaI_wavelength) * sinThetaIncident * sinThetaIncident))
    );
    
    
    // === Optical Path & Film Interference ===
    PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(CV0(lighting.viewPos), CV0(lighting.pixelPos), mat.thicknessM, lighting.normal);
    
    OpticalPathResult opticalPathDiff = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, pathMeasurement, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.real);
    
    C3 coherenceLengthM = mat.coherenceLengthM;
    lighting.filmReflectedPolarization = CSat(
        CV(
            ApplyReflectanceCoherence(
                CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).real,
                    opticalPathDiff, length(coherenceLengthM.real)),
            ApplyReflectanceCoherence(
                CMul(lighting.internalFilmReflectance, lighting.compositeSpecular).imag,
                    opticalPathDiff, length(coherenceLengthM.real))
        )
    );
    
    
    
    // === Advanced Holographic Volumetric Wave Interference ===
    // Here we simulate volumetric wave interference by summing coherent wavefronts,
    // incorporating phase delays, diffraction, and even quantum phase shifts.
   
    C3 waveInterferencePhase = ComputeVolumetricWaveInterferencePhase(lighting.albedoWavelengthsNM, inputUV, time, lighting.TBNf, lighting.depth, mat, parallaxScale);
    lighting.waveInterference = waveInterferencePhase;
    
    
    // === Holographic Caustics & Diffraction Patterns ===
    // Compute shimmering, volumetric caustics that result from diffraction through meta-surfaces.
    float3 caustics = ComputeHolographicCaustics(lighting, inputUV, time, parallaxScale);
    lighting.caustics = CV0(caustics);
    
    
    // === Thin Film Interference & Quantum Phase Shifts ===
    // Compute phase shifts for both ordinary and extraordinary rays,
    // incorporating complex quantum interference and thin-film effects.
    
    float LdotA = abs(dot(lighting.opticalAxis.real, lighting.lightDir));
    
    C3 qwave = ComplexQuantumWave(
        CVV(lighting.albedo),
        inputUV, time, (.5 + .5 * sin(time)) * 0.2 + 0.4, cos(time)*PassNum+PassNum,
        LdotA);
    
    C3 phaseShift_o = ComplexThinFilmInterference(
        CAdd(waveInterferencePhase, qwave),
        inputUV, time, mToNm(mat.thicknessM).real, mat.etaO, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM)
    );
    C3 phaseShift_e = ComplexThinFilmInterference(
        CAdd(waveInterferencePhase, qwave),
        inputUV, time, mToNm(mat.thicknessM).real, mat.etaE, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM)
    );
    // Blend phase shifts based on the depth-dependent polarization.
    SetDV(phaseShift, ComplexLerp(phaseShift_o, phaseShift_e, CVV(LdotA)));
    
    // === Holographic Microfacet Specular with Polarization ===
    // Compute a complex specular term using a holographic microfacet model,
    // incorporating polarization effects via complex Fresnel and geometry terms.
    C3 D_complex = MicrofacetDistribution_Complex(lighting.normal, lighting.halfDir, mat.roughness);
    C3 G_complex = GeometrySmith_ComplexCombined(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness);
    
    
    C3 spec_complex = CMul(CMul(D_complex, G_complex), F_complex);
    float3 complexSpecular = CAbs(spec_complex).real;
    complexSpecular = complexSpecular * complexSpecular; // Bring into Cook–Torrance units.
    
    // Blend traditional Cook–Torrance specular with our holographic specular.
    lighting.cookTorrenceSpecular = lerp(
        CookTorranceSpecularPBR(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness,
                                CalculateF0(mat.metallic, float3(0.04, 0.04, 0.04), mat.metallicReflectance), mat.metallic),
        complexSpecular, 0.5
    );
    
    lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
    float3 tangent = lighting.TBNf[0];
    lighting.advancedSheen = CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, tangent, mat.roughness, SHEEN_ALBEDO_TINT);
    lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) +
                               DistributionGGX(lighting.HdotN, mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER) * ClearCoatFresnel(NdotV);
    
    lighting.specularWithSheen = (lighting.cookTorrenceSpecular + (lighting.sheen * lighting.iridescence * lighting.advancedSheen) * .5);
    
    
    float2 microfacetRoughness = mat.roughness.xx;
    float3 ggxDistributionTerm = DistributionGGX(max(0,dot(lighting.normal, lighting.halfDir)), microfacetRoughness.x);
    float3 smithGeometryTerm = GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, microfacetRoughness.x);
    float3 microfacetDenominator = max(float3(4.0, 4.0, 4.0) * lighting.NdotV3, float3(EPSILON3));

    float3 microfacetSpecularTerm = saturate((ggxDistributionTerm * smithGeometryTerm) / microfacetDenominator);
    
    
    float3 n_real = CalculateRefractiveIndex(CVV(lighting.albedoWavelengthsNM), mat.coeff);

    SetDV(specularContribution, CV0(Specular(
        lighting.normal, lighting.viewDir, lighting.lightDir, mat) * microfacetSpecularTerm
        ));

    float3 angularTerm = pow(1.0 - saturate(lighting.NdotL3), 5.0);
    float3 F0 = angularTerm;
    
    C3 fresReflectance = CalculateFresnelReflectance(CV0(etaR_wavelength), lighting.normal, lighting.lightDir);
    
     SetDV(reflectance, fresReflectance);
    
    C3 fresTransmittance = CSub(C11, fresReflectance);
    SetDV(transmittance, fresTransmittance);
    
    lighting.viewToPixel = DistanceMFromViewToAB(CV0(lighting.viewPos), CV0(lighting.pixelPos),
                                                 CV0(lighting.pixelPos + lighting.viewDir * mat.thicknessM.real));
    
    // Compute optical path differences once and reuse
    OpticalPathResult opdResInsideReal = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.real);
    OpticalPathResult opdResInsideImag = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, lighting.viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient, lighting.cosThetaTransmissionInside.imag);
    SetDVo(opdAlbedoTransInsideRealChannel, opdResInsideReal);
    SetDVo(opdAlbedoTransInsideImagChannel, opdResInsideImag);
    
    
    float3 transmittanceCoherence = max(CoherenceFactor(opdResInsideReal.opticalMeasurement.PathLengthM, length(mat.coherenceLengthM.real)), ZERO3) +
                                    max(CoherenceFactor(opdResInsideImag.opticalMeasurement.PathLengthM, length(mat.coherenceLengthM.real)), ZERO3);
    
    
     {SetDV(diffuseReflectance,CSatMag(CMul(lighting.reflectance[dispersionIndex],lighting.filmReflectedPolarization)));; //CAdd(
            //CSatMag(lighting.reflectance[dispersionIndex]),
            //CSatMag(CAdd(//CSatMag(lighting.filmReflectedPolarization),
            //CSatMag(fresReflectance));
    }
    
    C3 eeDiffuse = ComplexMulCf(lighting.diffuseTransmittance[dispersionIndex], lighting.albedo * ONE3 * PhaseFactorDiffuse());
    C3 eeSpecular = CMul(lighting.specularContribution[dispersionIndex], CV0(ONE3 * PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM)));
    //C3 eeCaustics = CMul(CV0(caustics), CV0(ONE3 * PhaseFactorCaustics(transmittanceCoherence, Mix2)));
    
    
    
    C3 diffTrans = CalculateDiffuseTransmittance(inputUV, time, dispersionIndex, lighting, mat, sssStrength, lighting.albedo, lighting.transmittance[dispersionIndex]);
    C3 dt = CMul(diffTrans, CV0(PhaseFactorDiffuse()));
    SetDV(diffuseTransmittance, dt);
   
    C3 eeInterference = CMul(C0V(lighting.phaseShift[dispersionIndex].imag), C0V(ONE3 * ApplyTransmissionCoherence(diffTrans.imag, opdResInsideImag, mat.coherenceLengthM.real)));
    
  //  float3 totalWeight = max(EPSILON3,
//        PhaseFactorDiffuse() + 
        //PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM) +
        //PhaseFactorCaustics(transmittanceCoherence, Mix2));
       // PhaseFactorInterference(opdResInsideImag.opticalMeasurement.PathDifferenceM, mat.coherenceLengthM.real));
    
 //   eeDiffuse = ComplexMulCf(eeDiffuse, PhaseFactorDiffuse() / totalWeight);
    
   // eeCaustics = ComplexMulCf(eeCaustics, ONE3 * PhaseFactorCaustics(transmittanceCoherence, Mix2) / totalWeight);
    
    eeInterference = CSatMag(HeatHazeRainbowCaustics(lighting, inputUV, time, f1,f2,f3, dispersionIndex));;
   // eeInterference = ComplexMulCf(eeInterference, ONE3 * PhaseFactorInterference(opdResInsideImag.opticalMeasurement.PathDifferenceM, mat.coherenceLengthM.real) / totalWeight);
    eeInterference = C00;

    //eeSpecular.real = PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM) / totalWeight;
    C3 eeDiffuseReflectance = lighting.diffuseReflectance[dispersionIndex];
    //RedistributeExcessEnergyComplex(eeDiffuse, eeDiffuseReflectance, eeSpecular, eeInterference);
    //SetDV(diffuseTransmittance, eeDiffuse);
    //SetDV(specularContribution, eeSpecular);
    //SetDV(interferenceContribution, eeInterference);
    //SetDV(diffuseReflectance, eeDiffuseReflectance);

    Complex3 vals[4];
    if (inputUV.x > .8)
    {
        
        if (inputUV.y < .25)
            vals[0] = CSatMag(lighting.diffuseTransmittance[dispersionIndex]);
        else
        {
            vals[0] = C00;
            if (inputUV.y < .5)
                vals[1] = CSatMag(lighting.diffuseReflectance[dispersionIndex]);
            else
            {
                vals[1] = C00;
                if (inputUV.y < .75)
                    vals[2] = CSatMag(eeSpecular);
                else
                {
                    vals[2] = C00;
                    vals[3] = CSatMag(lighting.phaseShift[dispersionIndex]);
                   // vals[3] = CV0(CMag(lighting.interferenceContribution[dispersionIndex]).real);
                }
            }
        }
    }
    // === Final Composite Lighting Calculation ===
    float3 combinedLighting =
        saturate(
        CSatMag(CAdd(CAdd(vals[0], vals[1]), vals[2])).real);
            
    SetDVf(totalLighting, combinedLighting);
    // === Post-Processing: Gamma, Exposure & Saturation Correction ===
   // SetDVf(totalLighting, ApplyPostProcessing(combinedLighting, gamma, exposure, saturation));
    
    return lighting;
}

LightingComplex PopulateLightingComplexAdvanced
(float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    MaterialSellmeier mat,
    float animateSpeed,
    float parallaxScale,
    float normalRadius,
    float sssStrength,
    int dispersionIndex,
    float gamma,
    float exposure,
    float saturation)
{
    LightingComplex lighting = PopulateLightingComplex(diffuseMap, inputUV, viewPos, lightPos, invertDepth, useProjectedDepth,
            depthScale, mat, animateSpeed,
            parallaxScale, normalRadius, sssStrength, dispersionIndex,
            gamma, exposure, saturation);

    // Step 1: Calculate Thin-Film Interference
    float3 thinFilm = InterferenceThinFilm(
        inputUV,
        AnimateTime,
        lighting.albedoWavelengthsNM,
        lighting.material.thicknessM.real,
        lighting.material.etaR,
        lighting.cosThetaTransmissionInside.real,
        lighting.nSurrounding
    );

    // Step 2: Compute Chromatic Interference
    C3 chromaticEffect = ChromaticInterference(
        saturate(f5),
        AnimateTime,
        dispersionIndex,
        lighting
    );

    // Step 3: Add Caustics Effect
    float3 caustics = ScatterCaustics(
        saturate(f7),
        saturate(f9),
        saturate(f1),
        inputUV,
        AnimateTime,
        dispersionIndex,
        lighting
    );

    // Step 6: Compute Iridescence
    float3 iridescence = CalculateIridescence(
        lighting.normal,
        lighting.viewDir,
        lighting.lightDir,
        lighting.albedo
    ).real;

    // Step 7: Integrate Heat Haze
    float2 distortedUV = inputUV;
    float heatHazeStrength = 0.02 * saturate(1.0 - inputUV.y);
    float heatHazeNoise = noisePerlin11(
        inputUV.x,
        inputUV.y,
        cos(AnimateTime)
    );
    distortedUV += heatHazeNoise * heatHazeStrength;

    // Step 8: Combine All Effects
    float3 combinedEffects = thinFilm + chromaticEffect.real + caustics + iridescence;

    float3 finalDistortedColor = diffuse2D(diffuseMap, distortedUV).rgb;

    // Step 9: Integrate Specular and Reflective Contributions
    float3 compositeSpecular = lighting.cookTorrenceSpecular + CalculateAdvancedSheen(
        lighting.normal,
        lighting.lightDir,
        lighting.viewDir,
        CalculateTangent(lighting.normal),
        lighting.material.roughness,
        SHEEN_ALBEDO_TINT
    );

    float3 clearCoatSpecular = ClearCoatFresnel(lighting.NdotV3 * .5 + .5) *
                               DistributionGGX(abs(dot(lighting.normal, lighting.viewDir)), lighting.material.roughness * 0.5) *
                               saturate(CLEAR_COAT_THICKNESS);

    float3 finalSpecular = compositeSpecular * clearCoatSpecular;

    // Combine everything into final lighting
    lighting.totalLighting[dispersionIndex] +=
        saturate(
            (combinedEffects +
            finalDistortedColor +
            finalSpecular) *
            lighting.NdotL3
        );

    // Post-Processing Effects
    lighting.totalLighting[dispersionIndex] = ACESFilm(lighting.totalLighting[dispersionIndex] * lighting.Config_Exposure);
    lighting.totalLighting[dispersionIndex] = saturate(lighting.totalLighting[dispersionIndex]);
    lighting.totalLighting[dispersionIndex] = chromaticEffect.real;
    return lighting;
}

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
    float3 Nn = safeNormalizef(N);
    float3 On = safeNormalizef(cross(opticAxis, cross(Nn, opticAxis)));
    float3 En = safeNormalizef(cross(Nn, On));

    float no = 1.0; // Ordinary index (approx)
    float ne = no + birefringence; // Extraordinary index

    // Refract I into ordinary direction
    ordinaryRay = refract(-I, Nn, no);
    extraordinaryRay = refract(-I, Nn, ne);

    // Adjust extraordinary direction towards optic axis
    extraordinaryRay = safeNormalizef(lerp(extraordinaryRay, En, 0.5));
}

// Gaussian approximation for internal scattering (diffusion)
inline float InternalDiffusion(float distance, float diffusion)
{
    // As distance inside the material grows, intensity decays
    // Simple exponential decay for illustration
    return exp(-distance * diffusion);
}

// Phase Shift and Interference calculation
inline float3 InterferenceFactor(float thickness, float coherence, C3 wavelengthsNM, float n_real, float n_imag)
{
    // Interference depends on path difference = 2*n*thickness
    // Phase shift φ = (4 * PI * n_real * thickness) / wavelength
    float3 phase = (4.0 * PI * n_real * thickness) / nmToM(wavelengthsNM).real;
    // Interference term: I = 1 + cos(phase)*coherence
    // Include absorption via n_imag as attenuation factor
    float3 absorptionFactor = exp(-4.0 * PI * n_imag * thickness / nmToM(wavelengthsNM).real);
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
    C3 wavelengthsNM,
    float3 dispersionCoefficients[3],
    float3 absorptionCoefficient,
    float3 nSurrounding
)
{
    N = safeNormalizef(N);
    V = safeNormalizef(V);
    L = safeNormalizef(L);

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

    float time = AnimateTime;
    PathMeasurement distanceM = DistanceMFromViewToAB(CV0(viewPos), CV0(pixelPos), CV0(pixelPos + mToNm(CV0(thicknessM)).real));
        
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

void getColor(Texture2D<float4> diffuseMap, float2 inputUV, float2 adjustedUV, Lighting lighting, int ix, int dispersionIndex, bool invertDepth, bool useProjectedDepth, inout psout output)
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
        LP_CASE(8, opdAlbedoTransRealChannel[dispersionIndex].intensityModulationM.real)
        LP_CASE(9, opdAlbedoTransRealChannel[dispersionIndex].absorptionEffect)
        LP_CASE(10, opdAlbedoTransImagChannel[dispersionIndex].phaseInterference.totalPhase)
        LP_CASE(11, opdAlbedoTransImagChannel[dispersionIndex].intensityModulationM.real)
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
    }

}

// Example: now we have 58 unique cases, so use `% 58`:
float3 getColorComplex(
    LightingComplex lighting,
    int ix,
    int dispersionIndex
)
{
    psout output = (psout) 0;
    output.rt1.w = 1;
    
    switch (uint(ix) % 30)
    {
        // 0..6
        LP_CASE(0, totalLighting[dispersionIndex])
        LP_CASE(1, diffuseTransmittance[dispersionIndex].real)
        LP_CASE(2, specularContribution[dispersionIndex].real)
        LP_CASE(3, interferenceContribution[dispersionIndex].real)

        // 7..12
        LP_CASE(4, compositeSpecular.real)
        LP_CASE(5, filmReflectedPolarization.real)
        LP_CASE(6, transmittedPolarization.real)

        // 13..20
        LP_CASE(7, internalFilmReflectance.real)
        LP_CASE(8, externalFilmReflectance.real)
        LP_CASE(9, interferenceColorReflectance.real)
        LP_CASE(10, interferenceColorTransmittance.real)

        // 21
        LP_CASE(11, interferenceIntensity[dispersionIndex])

        // 22..33 (old 23..34)
        LP_CASE(12, phaseShiftComplex[dispersionIndex].real)
        LP_CASE(13, internalComplex[dispersionIndex].real)
        LP_CASE(14, externalComplex[dispersionIndex].real)
        LP_CASE(15, totalReflectanceComplex[dispersionIndex].real)
        LP_CASE(16, phaseShift[dispersionIndex].real)
        LP_CASE(17, diffuseReflectance[dispersionIndex].real)

        // 34..41 (old 39..46) - removing duplicates 35..38
        LP_CASE(18, ggxDistribution)
        LP_CASE(19, cookTorrenceSpecular)
        LP_CASE(20, sheen)
        LP_CASE(21, advancedSheen)
        LP_CASE(22, clearCoatSpecular)
        LP_CASE(23, iridescence)
        LP_CASE(24, specularWithSheen)
        LP_CASE(25, microfacetSpecular)

        // 42..45 (old 47..50)
        LP_CASE(26, cosThetaTransmissionInside.real)
        LP_CASE(27, cosThetaTransmissionOutside.real)

        // 46..49 (old 51..54)
        LP_CASE(28, reflectance[dispersionIndex].real)
        LP_CASE(29, transmittance[dispersionIndex].real)
        default:
            output.rt1.xyz = lighting.totalLighting[dispersionIndex];
            break;
    }
    return output.rt1.xyz;
}

psout HoloLines(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    if (PassNum == 0)
    {
        // Pass 0: Calculate velocity and thickness
        float2 velocity = float2(sin(input.uv.y * 10.0 + AnimateTime), cos(input.uv.x * 10.0 - AnimateTime));
        float thickness = 0.5 + 0.5 * sin(input.uv.x * 5.0 + input.uv.y * 5.0 + AnimateTime);

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
        float phaseR = sin(thickness * 10.0 + AnimateTime);
        float phaseG = sin(thickness * 12.0 + AnimateTime);
        float phaseB = sin(thickness * 14.0 + AnimateTime);

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
        float2 distortedUV = input.uv + velocity * 0.01 * sin(AnimateTime);

        // Add shimmer effect to the interference colors
        float highlight = max(0.0, dot(safeNormalizef(float3(input.uv, 1.0)), safeNormalizef(float3(0.5, 0.5, 1.0))));
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
        float thickness = 0.3 + 0.2 * sin(input.uv.x * 20.0 + AnimateTime * 0.5) +
                          0.1 * sin(input.uv.y * 25.0 + AnimateTime * 0.8);
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
        float3 viewDir = safeNormalizef(float3(input.uv, 1.0));
        float fresnel = pow(1.0 - abs(dot(viewDir, float3(0.0, 0.0, 1.0))), 5.0);

        // Enhance interference colors with Fresnel effect
        float3 fresnelColor = interferenceColor + fresnel;

        // Store enhanced colors in rt3
        output.rt3 = float4(fresnelColor, 1.0);
    }
    else if (PassNum == 3)
    {
        // Pass 3: Add distortions for a fluid-like appearance

        // Read interference colors from rt3
        float3 fresnelColor = diffuse2D(rtMap3, input.uv).rgb;

        // Create dynamic distortion based on time and UV
        float2 distortion = float2(sin(input.uv.y * 30.0 + AnimateTime), cos(input.uv.x * 30.0 - AnimateTime)) * 0.01;

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
        float thickness = mToUm(200e-9 + 100e-9 * sin(input.uv.x * 30.0 + AnimateTime) +
                          50e-9 * cos(input.uv.y * 20.0 - AnimateTime));

        // Add Perlin noise for surface turbulence
        float2 noiseUV = input.uv * 5.0 + float2(AnimateTime * 0.3, AnimateTime * 0.4);
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
            sin(input.uv.y * 20.0 + AnimateTime),
            cos(input.uv.x * 20.0 - AnimateTime)
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
        float3 viewDir = safeNormalizef(float3(input.uv, 1.0));
        float fresnel = pow(1.0 - abs(dot(viewDir, float3(0.0, 0.0, 1.0))), 5.0);

        // Combine interference with Fresnel highlights
        float3 finalColor = blendedResult + fresnel * float3(1.0, 1.0, 1.0);

        // Store final color in rt1 for display
        output.rt1 = float4(finalColor, 1.0);
    }

    return output;
}


float multiOctaveNoise(float3 p, int octaves, float persistence)
{
    float total = 0.0;
    float frequency = 1.0;
    float amplitude = 1.0;
    float maxAmplitude = 0.0;

    for (int i = 0; i < octaves; i++)
    {
        total += frac(sin(dot(p * frequency, float3(12.9898, 78.233, 37.719))) * 43758.5453) * amplitude;
        maxAmplitude += amplitude;
        frequency *= 2.0; // Double frequency
        amplitude *= persistence; // Decrease amplitude
    }

    return total / maxAmplitude; // Normalize to [0, 1]
}
    // Helper function to warp UV coordinates dynamically with added smoothing
float2 warpUV
    (
    float2 uv, float time, float intensity)
{
    float noiseX = sin(uv.x * 10.0 + time * 0.3) * intensity;
    float noiseY = cos(uv.y * 12.0 + time * 0.4) * intensity;
    float offset = sin((uv.x + uv.y) * 5.0 + time * 0.2) * intensity * 0.5;
    return uv + float2(noiseX, noiseY + offset);
}

    // Multi-octave turbulence function with smoothed transitions
float turbulence
    (
    float2 uv, float time)
{
    float value = 0.0;
    float frequency = 0.50;
    float amplitude = .1;
    float maxAmplitude = 10.0;

    for (int i = 0; i < 4; i++)
    {
        float2 warpedUV = warpUV(uv * frequency, time, 0.15 / (i + 1));
        float noise = sin(dot(warpedUV, float2(12.9898 + i, 78.233 - i * 3.14)) + time * (0.1 + i * 0.05));
        value += smoothstep(0.0, 1.0, abs(noise)) * amplitude; // Smoother noise transitions
        maxAmplitude += amplitude;
        frequency *= 12.0;
        amplitude *= 0.5;
    }

    return value / maxAmplitude; // Normalize to [0, 1]
}
////////////////////////////////////////////////////////////////////////////////
// "Ultimate" Holographic Rendering - UPU Aligned, Euler-Level Grand Complexity
// HLSL SM5 Pixel Shader
//
// In this shader, we extend the multi-plane, multi-wavelength, partial-
// polarization approach yet further, layering on additional wave-based
// transformations. We aim for a complexity and grandeur on par with the
// universal position of the UPU and the awe of Euler's identity. This includes:
//   • 3-plane wave combination (near, mid, far) — conceptual, but we'll unify
//     within single pass for demonstration.
//   • Partial polarization TE/TM expansions, including pseudo-Brewster logic.
//   • Time, frequency, parallax, and multi-phase expansions for real+imag wave
//     data with 13 advanced steps plus expansions reminiscent of TCP/IP's
//     layered approach (additional “layers” of wave transformations).
//
// DISCLAIMER:
// True physical holography still requires offline wave propagation (Fresnel/FFT)
// or specialized hardware. This “ultimate” demonstration pushes real-time HLSL
// to a conceptually maximal wave-optics approach using your existing 2D
// textures. It is computationally heavy and for demonstration/education.
//
// The code is structured similarly to earlier versions but adds new expansions:
//   (A) Additional multi-plane data (for near, mid, far planes) combined
//       conceptually. 
//   (B) Additional wave-layer steps (#14..#16) for multi-plane coupling and
//       pseudo-Brewster expansions, following the “TCP/IP layered” analogy.
//   (C) More advanced partial polarization interactions in steps #9..#13.
//
// Usage with your standard f1..f12 config, plus some expansions. The final
// color is placed in psout.rt1.
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
// 4) Complex3Pol: TE/TM partial polarization
////////////////////////////////////////////////////////////////////////////////
    

Complex3Pol C3PZero()
{
    Complex3Pol Z;
    Z.realTE = 0;
    Z.imagTE = 0;
    Z.realTM = 0;
    Z.imagTM = 0;
    return Z;
}

Complex3Pol C3PAdd(Complex3Pol A, Complex3Pol B)
{
    Complex3Pol R;
    R.realTE = A.realTE + B.realTE;
    R.imagTE = A.imagTE + B.imagTE;
    R.realTM = A.realTM + B.realTM;
    R.imagTM = A.imagTM + B.imagTM;
    return R;
}

Complex3Pol C3PSub(Complex3Pol A, Complex3Pol B)
{
    Complex3Pol R;
    R.realTE = A.realTE - B.realTE;
    R.imagTE = A.imagTE - B.imagTE;
    R.realTM = A.realTM - B.realTM;
    R.imagTM = A.imagTM - B.imagTM;
    return R;
}

void C3PMulTE(inout float3 rA, inout float3 iA, float3 rB, float3 iB)
{
    float3 r = rA * rB - iA * iB;
    float3 i = rA * iB + iA * rB;
    rA = r;
    iA = i;
}

void C3PMulTM(inout float3 rA, inout float3 iA, float3 rB, float3 iB)
{
    float3 r = rA * rB - iA * iB;
    float3 i = rA * iB + iA * rB;
    rA = r;
    iA = i;
}

Complex3Pol C3PMul(Complex3Pol A, Complex3Pol B)
{
    Complex3Pol R = A;
    C3PMulTE(R.realTE, R.imagTE, B.realTE, B.imagTE);
    C3PMulTM(R.realTM, R.imagTM, B.realTM, B.imagTM);
    return R;
}

Complex3Pol C3PScale(Complex3Pol A, float s)
{
    Complex3Pol R;
    R.realTE = A.realTE * s;
    R.imagTE = A.imagTE * s;
    R.realTM = A.realTM * s;
    R.imagTM = A.imagTM * s;
    return R;
}

// e^( i * TEphase ), e^( i * TMphase )
Complex3Pol C3PExp(float3 TEphase, float3 TMphase)
{
    Complex3Pol R;
    R.realTE = cos(TEphase);
    R.imagTE = sin(TEphase);
    R.realTM = cos(TMphase);
    R.imagTM = sin(TMphase);
    return R;
}

// Combine TE & TM => final color
float3 CombinePol(Complex3Pol wave, float imagWeight)
{
    float3 realSum = wave.realTE + wave.realTM;
    float3 imagSum = wave.imagTE + wave.imagTM;
    return realSum + imagSum * imagWeight;
}

////////////////////////////////////////////////////////////////////////////////
// Example packing/unpacking from RTs (conceptual)
////////////////////////////////////////////////////////////////////////////////
Complex3Pol UnpackWave12(float4 data2, float4 data3)
{
    // Suppose we store TE real in data2.xyz, TE imag in data2.wxx
    // TM real in data3.xyz, TM imag in data3.wxx
    // (This is just an example, adapt as needed.)

    Complex3Pol R;
    R.realTE = data2.xyz * 2.0 - 1.0;
    R.imagTE = float3(data2.w, data2.w, data2.w) * 2.0 - 1.0;

    R.realTM = data3.xyz * 2.0 - 1.0;
    R.imagTM = float3(data3.w, data3.w, data3.w) * 2.0 - 1.0;
    return R;
}

void PackWave12(in Complex3Pol wave, out float4 rt2, out float4 rt3)
{
    rt2 = saturate(float4(wave.realTE, wave.imagTE.x)) * 0.5 + 0.5; // TE real + TE imag.x
    rt3 = saturate(float4(wave.realTM, wave.imagTM.x)) * 0.5 + 0.5; // TM real + TM imag.x
}

////////////////////////////////////////////////////////////////////////////////
// Interference Steps (#1..#16)
////////////////////////////////////////////////////////////////////////////////

// 1) Hilbert
Complex3Pol Interf1_Hilbert(Complex3Pol inC)
{
    Complex3Pol R = inC;
    float3 oldRTE = R.realTE;
    R.realTE = -R.imagTE;
    R.imagTE = oldRTE;

    float3 oldRTM = R.realTM;
    R.realTM = -R.imagTM;
    R.imagTM = oldRTM;
    return R;
}

// 2) Rayleigh
Complex3Pol Interf2_Rayleigh(Complex3Pol inC, float dist, float factor)
{
    Complex3Pol R = inC;
    float scTE = 1.f / (1.f + dist * factor);
    float scTM = 1.f / (1.f + dist * (factor * 0.5));
    R.realTE *= (scTE);
    R.imagTE *= (scTE);
    R.realTM *= (scTM);
    R.imagTM *= (scTM);
    return R;
}

// 3) Mie
Complex3Pol Interf3_Mie(Complex3Pol inC, float3 offset, float factor)
{
    Complex3Pol R = inC;
    R.realTE += offset * (0.1 * factor);
    R.imagTE += offset * (0.05 * factor);
    R.realTM += offset * (0.08 * factor);
    R.imagTM += offset * (0.04 * factor);
    return R;
}

// 4) Bragg
Complex3Pol Interf4_Bragg(Complex3Pol inC, float dotNL)
{
    float b = 0.5 + 0.5 * dotNL;
    return C3PScale(inC, b);
}

// 5) ThinFilm
Complex3Pol Interf5_ThinFilm(Complex3Pol inC, float dist, float shift, float factor)
{
    Complex3Pol P = C3PExp(dist * factor.xxx,
                           dist * factor.xxx + shift * (factor * 0.85));
    return C3PMul(inC, P);
}

// 6) Michelson
Complex3Pol Interf6_Michelson(Complex3Pol inC)
{
    return C3PScale(inC, 0.5);
}

// 7) MultiPath
Complex3Pol Interf7_MultiPath(Complex3Pol inC, float dist, float factor)
{
    Complex3Pol p = C3PExp(dist * factor.xxx, dist * (factor + 0.1).xxx);
    return C3PMul(inC, p);
}

// 8) SubSurface
Complex3Pol Interf8_SubSurface(Complex3Pol inC, float ndv, float factor)
{
    float3 phTE = ndv.xxx * factor;
    float3 phTM = ndv.xxx * (factor + 0.15);
    Complex3Pol P = C3PExp(phTE, phTM);
    return C3PMul(inC, P);
}

// 9) Fresnel
Complex3Pol Interf9_Fresnel(Complex3Pol inC, float fresFactor)
{
    Complex3Pol R = inC;
    R.realTE *= fresFactor;
    return R; // keep imagTE, realTM, imagTM unchanged
}

// 10) PhaseRetard
Complex3Pol Interf10_PhaseRetard(Complex3Pol inC, float dist)
{
    float3 te = dist.xxx * 0.2;
    float3 tm = dist.xxx * 0.3;
    Complex3Pol P = C3PExp(te, tm);
    return C3PMul(inC, P);
}

// 11) ChromDispersion
Complex3Pol Interf11_ChromaticDispersion(Complex3Pol inC, float factor)
{
    Complex3Pol R = inC;
    float3 oldRte = R.realTE;
    float3 oldRtm = R.realTM;
    R.realTE = lerp(oldRte, float3(oldRte.g, oldRte.b, oldRte.r), factor);
    R.realTM = lerp(oldRtm, float3(oldRtm.b, oldRtm.r, oldRtm.g), factor * 0.6);
    return R;
}

// 12) Maxwell
Complex3Pol Interf12_Maxwell(Complex3Pol inC, float freq, float dotNL)
{
    float3 te = freq * (dotNL).xxx;
    float3 tm = freq * ((dotNL) + 0.15).xxx;
    Complex3Pol S = C3PExp(te, tm);
    return C3PMul(inC, S);
}

// 13) Holo
Complex3Pol Interf13_Holo(Complex3Pol inC, float3 hv)
{
    Complex3Pol H = C3PExp(hv, hv + 0.2);
    return C3PMul(inC, H);
}

// 14) MultiPlane
Complex3Pol Interf14_MultiPlane(Complex3Pol inC, float zN, float zM, float zF, float factor)
{
    float3 te = float3(zN, zM, zF) * factor;
    float3 tm = float3(zN + 0.2, zM + 0.1, zF) * factor;
    Complex3Pol P = C3PExp(te, tm);
    return C3PAdd(inC, P);
}

// 15) Brewster
Complex3Pol Interf15_Brewster(Complex3Pol inC, float dotNV)
{
    float brew = saturate(dotNV * 1.5);
    Complex3Pol R = inC;
    R.realTM *= (1.f - brew * 0.7);
    return R;
}

// 16) TcpIpLayer
Complex3Pol Interf16_TcpIpLayer(Complex3Pol inC, float freqOffset, float timeVal)
{
    float3 te = ONE3 * (freqOffset * (timeVal + 0.3));
    float3 tm = ONE3 * (freqOffset * (timeVal + 0.5));
    Complex3Pol P = C3PExp(te, tm);
    return C3PMul(inC, P);
}
C3 CreateWave(float theta_sin, float theta_cos)
{
    return CV(sin(theta_sin), cos(theta_cos));
}


//-----------------------------------------------------------------------------
// ProjectiveInterferenceShader
// Uses physically inspired wavelengths and precise timing to create a 
// holographic interference pattern with a convincing 3D projection.
//-----------------------------------------------------------------------------

C3 HolographicPS2(float2 inputUV, float time, float3 depthScalar, float3 phaseScalar, float3 phaseOffset, float3 fringeFactor, bool invertDepth, bool useProjectedDepth)
{
    //---------------------------------------------------------------------------
    // 1) UV & Depth Setup
    //---------------------------------------------------------------------------
    // Get the UV coordinates and center them about (0.5, 0.5)
    float2 uv = inputUV;
    float2 centeredUV = uv - 0.5;
    float radialUV = length(centeredUV); // used for interference fringes

    // Sample the depth (0..1) and map it to a physical distance.
    // The scale factor is chosen to exaggerate the 3D effect.
    C3 depthSample = CV0(depth2D(depthMap, uv, invertDepth, useProjectedDepth));
    C3 distance = depthSample; // in our virtual scene units

    C3 lambda = RGBToWavelengthsNM(CV0(RotateHue(diffuse2D(diffuseMap, uv).rgb, 2*fmod((AnimateTime/(1-depthSample.real.x+EPSILON)),PI))));

    //---------------------------------------------------------------------------
    // 3) Compute Precise Phase for Each Channel
    //---------------------------------------------------------------------------
    // The phase is determined by the optical path length (distance/wavelength)
    // and an exact time offset, plus a fringe term from the radial UV.
    // k is an arbitrary factor to control fringe density.
   
    C3 phase = CMul(CV0(2.0 * PI), CAdd(CDiv(distance, lambda), CMul(CV0(radialUV), CV0(fringeFactor))));

    //---------------------------------------------------------------------------
    // 4) Compute Interference Intensity via Sinusoidal Oscillations
    //---------------------------------------------------------------------------
    // Interference intensity is computed from the sine of the phase.
    // We map the sine function from [-1, 1] to [0, 1].
    C3 intensity = CAdd(CV0(phaseOffset), CMul(CV0(phaseScalar), CSin(phase)));
 

    C3 interference = intensity;

    //---------------------------------------------------------------------------
    // 5) Projective 3D Look & Final Color Composition
    //---------------------------------------------------------------------------
    // The 3D appearance is enhanced by modulating with a distance-based falloff.
    // This mimics atmospheric or volumetric attenuation.
    C3 falloff = CSat(CAbs(CSub(C10, CMul(distance, CV0(depthScalar)))));

    // A slight boost at the edges adds a sense of projection.
    C3 edgeBoost = CAdd(C10, CMul(CV0(radialUV), CV0(0.2)));

    // Compose the final color.
    C3 finalColor = CMul(CMul(interference, falloff), edgeBoost);

    // Clamp to [0,1] range.
    return finalColor;
}

C3 AberrationsEnhancedPS(float4 pos : SV_Position, float2 texCoord : TEXCOORD, Texture2D<float4> g_interferencePattern, C3 g_chromaticAberrationStrength, float time, C3 g_distortionStrength) : SV_Target
{
    C3 ctime = CV0(time);
    // Time-varying distortion
    C3 distortion = CMul(
    
    CSin(
        CAdd(
                CAdd(CV0(.5),
                        CMul(CV0(.5), CSin(ctime))
                ), CMul(CMul(CV0(float3(texCoord, 1.0)), C20), CPI)))
        , g_distortionStrength);

    // Time-varying chromatic aberration
    C3 chromaticAberration = CSin(CMul(CAdd(CAdd(CV0(.5),
                        CMul(CV0(.5), ComplexCos(ctime))), CV0(texCoord.y * 2.0 * PI)), g_chromaticAberrationStrength));

  
    float red = g_interferencePattern.SampleLevel(sampleTypeMirror, CAbs(CAdd(CMul(CV0(float3(texCoord, 0)), distortion), chromaticAberration)).real.xy, 0).r;
    
    float green = g_interferencePattern.SampleLevel(sampleTypeMirror, CAbs(ComplexSub(CMul(CV0(float3(texCoord, 0)), distortion), chromaticAberration)).real.xy, 0).g;
    
    float blue = g_interferencePattern.SampleLevel(sampleTypeMirror, CAbs(CMul(CMul(CV0(float3(texCoord, 0)), distortion), chromaticAberration)).real.xy, 0).b;
    
    C3 color = CV0(float3(red, green, blue) * 2 - 1);
    
    // Introduce some noise (optional)
    float noise = frac(sin(dot(texCoord, float2(12.9898, 78.233) * time)) * 43758.5453);
    C3 finalColor = CSat(CAbs(CAdd(color, CMul(CV0(noise), CV0(0.005)))));

    return finalColor;
}


/*
psout xxPS(PS_INPUT input)
{
    
    // read from pass data
    float time = AnimateTime;
    float ct0 = cos(time);
    
    psout output;
    float2 uv0 = input.uv;
    InitPSOut(output, input.uv);
    bool invertDepth = !KeyQDown, useProjectedDepth = !KeyWDown;
  
    float3 LightPos = float3(SunX, SunY, SunZ);
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
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

    int hCount = int(floor(float(sz.x) / uint(cellSize.x)));
    int vCount = int(floor(float(sz.y) / uint(cellSize.y)));
    
    int uvCol = uvI.x;
    int uvRow = uvI.y;
    // Carefully chosen parameters
    float LightIntensity = HeightParamB;
    float SpecOffset = HeightParamC;
    float MaxwellFreq = FresnelMix;
    
   
    // Distances for multi-plane steps
    float zNear = CosineFactorR;
    float zMid = CosineFactorG;
    float zFar = CosineFactorB;

    // Light & View positions
    
   
    // For demonstration, sample your diffuse/normal/depth
    
    // Additional factors for wave expansions
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    float depth0 = depth2D(depthMap, input.uv);
    ParallaxResult res = ParallaxOcclusion(depthMap, input.uv, float2(lerp(-0.001, 0.001, 1.0 - depth0), 0), invertDepth, useProjectedDepth, ParallaxScale * ct0);
    
    float2 adjustedUV = res.deltaUVs[res.intersectionCount - 1] + input.uv;
   
    float3 normal = CalcNormal2(depthMap, adjustedUV, viewPos, invertDepth, useProjectedDepth, NormalRadius);
    float depth = depth2D(depthMap, adjustedUV, invertDepth, useProjectedDepth);
    float FresnelHighlight = f7;
    float3 fragPos = float3(adjustedUV, depth);
    float3 baseColor = diffuse2D(diffuseMap, adjustedUV).rgb;
    
    float3 L = (normalize(LightPos - fragPos));
    float3 V = (normalize(viewPos - fragPos));
    float3 H = safeNormalize(L + V);

    float ndl = saturate(dot(normal, L));
    float ndv = saturate(dot(normal, V));
    float ndh = saturate(dot(normal, H));
    
    float ReflectIndex = f8 * depth;
    
    float3 nSurrounding = float3(mat.nSurrounding, mat.nSurrounding, mat.nSurrounding);
        
        // Pixel and normal calculations
    float3 pixelPos = fragPos;
   
         // Albedo and wavelength conversions
    float3 albedo = mat.albedo * diffuse2D(diffuseMap, adjustedUV).rgb;
    float3 albedoWavelengthsNM = RGBToWavelengthsNM(albedo);
    float3 albedoWavelengthsM = nmToM(albedoWavelengthsNM);
    float3 viewDir = normalize(float3(ViewX, ViewY, ViewZ) - saturate(float3(adjustedUV, depth)));
    float3 lightPos = LightPos;
    
    float3 lightDir = normalize(lightPos - pixelPos);
    float3 halfDir = normalize(viewDir + lightDir);
    
    
    
    //output.rt8;
    // Pass-based logic
    if (PassNum == 0)
    {
       
        ///////////////////////////////////////////////
        // PASS 0 - Initialize wave data (TE/TM)
        ///////////////////////////////////////////////
        Complex3Pol wave0;
        // Start with amplitude => baseColor * LightIntensity, zero phase
        wave0.realTE = (saturate(baseColor * LightIntensity * max(0.0, dot(viewDir, halfDir))));
        wave0.imagTE = float3(0.0, 0.0, 0.0);
        wave0.realTM = (saturate(baseColor * (LightIntensity - 0.1) * max(0.0, dot(viewDir, lightDir))));
        wave0.imagTM = float3(0.151, 0.125, 0.18); // small offset

        // Optionally apply 1..2 steps for wave
        // E.g. Interf1_Hilbert + Interf2_Rayleigh
        Complex3Pol wave02 = Interf1_Hilbert(wave0);
        
        // pack wave0 into rt2, rt3
        float4 out2, out3;
        PackWave12(wave02, out2, out3);
        output.rt7 = out2;
        output.rt8 = out3;
        output.rt1 = float4(diffuse2D(diffuseMap, adjustedUV).xyz, 1.0);

        if (NumPasses == 1)
        {
            output.rt1 =
                input.uv.x < .2 ? float4(CombinePol(wave0, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .4 ? float4(CombinePol(wave02, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                 output.rt1;
        }

    }
    else if (PassNum == 1)
    {
        
            ///////////////////////////////////////////////
            // PASS 1 - Intermediate pass
            ///////////////////////////////////////////////
            // read wave from pass 0
        
        Complex3Pol waveMid0 = UnpackWave12(
            rtMap7.SampleLevel(sampleTypeMirror, input.uv, 0),
            rtMap8.SampleLevel(sampleTypeMirror, input.uv, 0));

            // apply more steps e.g. Mie, ThinFilm
        Complex3Pol waveMid1 = Interf3_Mie(waveMid0, mat.thicknessM, sin(time));
        Complex3Pol waveMid2 = Interf5_ThinFilm(waveMid1, mat.thicknessM, (PhaseOffsetR * ndl * ndv) * mat.coherenceLengthM, cos(time)));

            // store into rt4, rt5
        float4 out4, out5;
        PackWave12(waveMid2, out4, out5);
        output.rt5 = saturate(out4);
        output.rt6 = saturate(out5);

        
        if (NumPasses == 2)
        {
            output.rt1 =
                input.uv.x < .2 ? float4(CombinePol(waveMid0, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .4 ? float4(CombinePol(waveMid1, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .6 ? float4(CombinePol(waveMid2, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                 output.rt1;
        }

        
    }
    else if (PassNum == 2)
    {
        Complex3Pol wave0 = UnpackWave12(
            rtMap7.SampleLevel(sampleTypeMirror, input.uv, 0),
            rtMap8.SampleLevel(sampleTypeMirror, input.uv, 0));
        Complex3Pol wave1 = UnpackWave12(
            rtMap5.SampleLevel(sampleTypeMirror, input.uv, 0),
            rtMap6.SampleLevel(sampleTypeMirror, input.uv, 0));

            // Combine
        Complex3Pol sumC0 = C3PAdd(wave0, wave1);

        // apply more steps e.g. Fresnel, Maxwell, Holo, MultiPlane, Brewster, etc.
        // demonstration of final chain:

        // 9) Fresnel
        float specPow = SpecularPower;
        float sv = pow(max(ndh, 0.0), specPow);
        float f0 = pow((1 - ReflectIndex) / (1 + ReflectIndex), 2);
        f0 += (1 - f0) * pow(1 - ndh, SpecularIntensity);
        float fresVal = sv * f0 * FresnelHighlight;
        Complex3Pol sumC1 = Interf9_Fresnel(sumC0, fresVal);

            // 12) Maxwell
        Complex3Pol sumC2 = Interf12_Maxwell(sumC1, MaxwellFreq, ndl);

            // 13) Holo
       // float3 hv = max(0.0, dot(L, V)) * float3(0.08, 0.08, 0.08) * HeightScale * depth * ndv;
      // sumC = Interf13_Holo(sumC, hv);

            // 14) MultiPlane
        Complex3Pol sumC3 = Interf14_MultiPlane(sumC2, zNear * length(CombinePol(wave0, dot(viewDir, halfDir)) * 0.5 + 0.5), length(CombinePol(sumC1, dot(viewDir, halfDir)) * 0.5 + 0.5) * zMid, zFar * length(CombinePol(wave1, dot(viewDir, halfDir)) * 0.5 + 0.5), dot(normal, CombinePol(sumC2, dot(normal, lightDir))));

            // 15) Brewster
        Complex3Pol sumC4 = Interf15_Brewster(sumC3, ndv);

            // 16) TcpIpLayer
           // sumC = Interf16_TcpIpLayer(sumC,0.2 + MaxwellFreq, depth);

            // final color
        float3 finalColor = CombinePol(sumC4, dot(viewDir, halfDir)) * 0.5 + 0.5;
        finalColor = saturate(finalColor);

            // output
        output.rt4 = float4(finalColor, 1.0);
        
        float4 oc = 0.0;
        float3 vp = viewPos;
        for (int ik = 0; ik < 3; ik++)
        {
         // View and light positions and directions
            viewPos = vp + (ik == 0 ? float3(0.05, 0, 0) * ParallaxScaleOMD : ik == 1 ? -float3(0, 0.05, 0) * ParallaxScaleOMD : ZERO3);
            viewDir = (normalize(viewPos - pixelPos));
            lightDir = (normalize(lightPos - pixelPos));
            halfDir = normalize(viewDir + lightDir);
           
            oc += AberrationsEnhancedPS(float4(adjustedUV, depth, 1), adjustedUV, diffuseMap, Mix2 * max(0.0, dot(lightDir, normal)), time, Mix3 * max(0.0, dot(viewDir, halfDir))) * max(0.0, dot(viewDir, normal));
       
            //output.rt1
           // output.rt1 += output.rt1;
        }
        output.rt3 = oc * 0.25;
        
        if (NumPasses == 3)
        {
            output.rt1 =
                input.uv.x < .1 ? float4(CombinePol(sumC0, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .20 ? float4(CombinePol(sumC1, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .3 ? float4(CombinePol(sumC2, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .4 ? float4(CombinePol(sumC3, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
                input.uv.x < .5 ? float4(CombinePol(sumC4, dot(normal, lightDir)) * 0.5 + 0.5, 1.0) :
		input.uv.x < .6 ? float4(output.rt4.xyz, 1.0) :
                input.uv.x < .6 ? float4(output.rt3.xyz, 1.0) :
                 output.rt1;
        }

    }
    else if (PassNum == 3)
    {
        Complex3Pol wave0 = UnpackWave12(
            rtMap7.SampleLevel(sampleTypeMirror, input.uv, 0),
            rtMap8.SampleLevel(sampleTypeMirror, input.uv, 0));
        Complex3Pol wave1 = UnpackWave12(
            rtMap5.SampleLevel(sampleTypeMirror, input.uv, 0),
            rtMap6.SampleLevel(sampleTypeMirror, input.uv, 0));


            // Combine
        Complex3Pol sumC = C3PAdd(wave0, wave1);

        float swirlAngle = acos(dot(lightDir, halfDir) * dot(lightDir, normal));
        float intensityBoost = HeightParamA * 
            length(CombinePol(sumC, dot(lightDir, normal)) * 0.5 + 0.5)*0.333;
        float3 lightColor = output.rt1.xyz * HeightParamB;
        float3 baseTint = mat.albedo;
        float4 hps2 = HolographicPS2(input, swirlAngle, intensityBoost, lightColor, baseTint, invertDepth, useProjectedDepth);
        
        output.rt8 = hps2 * 0.5 + 0.5;
        output.rt7 = float4((CombinePol(sumC, dot(viewDir, lightDir)) * 0.5 + 0.5), 1.0);
        
        
        if (NumPasses == 4)
        {
            output.rt1 = input.uv.x < .3 ? output.rt7 : input.uv.x < .6 ? output.rt8 : output.rt1;
        }


    }
    else if (PassNum == 4)
    {

        float3 sss = (PS_SSS_Horizontal(
            input.uv,
            time,
            rtMap8,
            input.uv,
            mat,
            viewDir,
            lightDir,
            invertDepth, useProjectedDepth) * max(0.0, dot(viewDir * float3(1, 0, 1), halfDir * float3(1, 0, 1))) +
             PS_SSS_Vertical(
            input.uv,
            time,
            rtMap8,
            input.uv,
            mat,
            viewDir,
            lightDir,
            invertDepth, useProjectedDepth) * max(0.0, dot(viewDir * float3(0.0, 1.0, 1.0), lightDir * float3(0.0, 1.0, 1.0)))) * 0.5;
        output.rt2 = float4(sss, 1.0);
        
        if (KeyControl && KeyAlt && KeyShift)
        {
            if (input.uv.x < 0.1)
            {
                output.rt1 = output.rt2;
            }
            else if (input.uv.x < 0.2)
            {
                output.rt1 = output.rt3;
            }
            else if (input.uv.x < .3)
            {
                output.rt1 = output.rt4;
            }
            else if (input.uv.x < .4)
            {
                output.rt1 = output.rt5;
            }
            else if (input.uv.x < 0.5)
            {
                output.rt1 = output.rt6;
            }
            else if (input.uv.x < 0.6)
            {
                output.rt1 = float4(sss, 1.0);
            }
            else if (input.uv.x < 0.7)
            {
                output.rt1 = output.rt8;
            }
            else
            {
                output.rt1 = output.rt1 * float4(lerp(lerp((output.rt2 + output.rt3 + output.rt4 + output.rt5 + output.rt6 + output.rt7 + output.rt8).xyz, 0.0, 0.5), 0.0, 0.5), 1.0);
            }

        }
        else
        {
            output.rt1 = output.rt1 * output.rt8 * TanhFactorR +
            output.rt2 * TanhFactorG + output.rt3 * TanhFactorB + (max(0.0, 0.25 * dot(viewDir, normal)) * output.rt7 * Mix3);
            output.rt1 = AdjustGamma(output.rt1, Gamma);
        }
    }
    
        float3 test = ZERO3;
        
        int ix = clamp(uvRow * colsPerRow + uvCol, 0.0, 50.0);
       
        
        Texture2D<float4> grating = gratingMap4;
        Texture2D<float3> gratingNormal = gratingNormal4;
        Texture2D<float> gratingDepth = gratingDepth4;
        float4 ae = float4(0, 0, 0, 1);
        int dispersionIndex = 0;
        
        LightingComplex lightingComplex =
            PopulateLightingComplex(adjustedUV, viewPos, float3(SunX, SunY, SunZ), invertDepth, useProjectedDepth, currentDepthScale, currentDepthRange, MaterialIndex, AnimateSpeed, ParallaxScale * (1 - depth), NormalRadius, 0.5, dispersionIndex, Gamma, 0.5, FresnelMix, test);
        
        
            
       // for (int i = 4; i > 0; i--)
        {
            float4 c = output.rt1;
            getColorComplex(diffuseMap, input.uv, adjustedUV, lightingComplex, ix, dispersionIndex, invertDepth, useProjectedDepth, output);
            output.rt1 = output.rt1 + c;
        }
       
        

    return output;

}

*/















float2 ToPolar(float2 uv)
{
    float r = length(uv);
    float theta = atan2(uv.y, uv.x);
    return float2(r, theta);
}

C3 TranscendentInterferenceComplex(
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float3 viewPos,
    float time,
    bool invertDepth,
    bool useProjectedDepth)
{
    //--------------------------------------------------------------------------
    // 1. Universal Coordinate Remapping
    //--------------------------------------------------------------------------
    // Map the UV coordinates from screen space into a centered, universal frame.
   
    uv = (uv / GetSz(diffuseMap)) * 2.0 - 1.0;
    uv = uv * 0.5 + 0.5;

    //--------------------------------------------------------------------------
    // 2. Sample Scene Data
    //--------------------------------------------------------------------------
    float4 diffuse = diffuse2D(diffuseMap, uv);
    float depth0 = depth2D(depthMap, uv, invertDepth, useProjectedDepth);
    // Wrap the scalar depth value into a C3 and offset by PhaseOffsetG.
    C3 depth = CAdd(CAdd(CV0(depth0), CV0(-0.5)), CV0(0.5));
    C3 normal;
    Complex3x3 tbn = CalcTBN3(depthMap, uv, invertDepth, useProjectedDepth, normal);


    //--------------------------------------------------------------------------
    // 3. Establish a Fixed, Cosmic Reference
    //--------------------------------------------------------------------------
    // A universal axis to anchor our interference beyond local orientation.
    C3 cosmicAxis = CMul3x3(tbn, CV0(normalize(float3(1,0, 0) + viewPos)));

    // Derive polar coordinates from uv (representing angular parameters)
    float2 polar = ToPolar(uv);

    // Compute base wavelengths (in nm) from the diffuse color,
    // and modulate them by depth. Now lifted to C3.
    C3 cWavelengths = RGBToWavelengthsNM(CV0(diffuse.rgb));
    
    //--------------------------------------------------------------------------
    // 4. Initialize the Hyperdimensional Signal
    //--------------------------------------------------------------------------
    C3 signal;
    signal.real = float3(0.0, 0.0, 0.0);
    signal.imag = float3(0.0, 0.0, 0.0);

    const int iterations = 14;
    float basePhase = 6.28318530718; // 2π constant

    // Pre-wrap constants used in the loop.
    C3 one = CV0(1.0);
    C3 cMinWavelengths = CV0(MIN_WAVELENGTHS);
    C3 cWavelengthRange = CV0(WAVELENGTH_RANGES);
    // Compute wavelength scale factor: ((wavelengths - MIN_WAVELENGTHS) / WAVELENGTH_RANGES)
    C3 wavelengthScale = CDiv(CSat(CSub(cWavelengths, cMinWavelengths)), cWavelengthRange);

    //--------------------------------------------------------------------------
    // 5. Accumulate Hyperwave Interference
    //--------------------------------------------------------------------------
    [unroll(4)]
    for (int i = 0; i < iterations; i++)
    {
        // --- Temporal Phase Blending ---
        // Original: t = depth.real + depth.imag * (i * 0.1 * HeightScale)
        // Lift into C3: note that CV0(depth.real) wraps the real part.
        C3 cT = CV(depth.real, (depth.imag * (float(i) * 0.0001 * HeightScale)));

        // --- Hyper-Space Position Computation ---
        // Base spatial position: combine UV and depth.
        C3 basePos = CV0(float3(uv, depth.real.x));
        // Phase factor from iteration and temporal blend:

        // (1.0 - cT)
        C3 diffT = CSub(C11, cT);
        C3 phaseFactor = CAdd(CVV(i*0.01), diffT);
        // Multiply to get primary positional contribution.
        C3 posPart = CMul(phaseFactor, basePos);

        // Normal contribution.
        C3 normalContribution = CMul(normal, CVV(float(i) * 0.001));
        // Cosmic (TBN-anchored) contribution.
        C3 cosmicContribution = CMul(cosmicAxis, CVV(float(i) * 0.01));
       
        // Sum the spatial contributions.
        C3 posSum = CAdd(CAdd(posPart, normalContribution), cosmicContribution);
        // Apply the wavelength scaling.
        C3 pos = CMul(posSum, wavelengthScale);

        // --- Compose Hyperphase ---
        // Wrap the angular component: extend polar (float2) to float3 with a fixed 1.0.
        C3 cPolar = CVV(float3(polar, 1.0));
        // Multiply basePhase * cPolar.
        C3 phaseMult = ComplexMulScalar(cPolar, basePhase);
        // Combine with the temporal blend cT.
        C3 multiplier = CMul(phaseMult, cT);
        // Final hyperphase: pos * multiplier.
        C3 cPhase = CMul(pos, multiplier);

        // Compute the hyper-exponential interference wave.
        C3 wave = CExp(cPhase);

        // --- Noise & Parallax Modulation ---
        // Use the xy of the real part of pos as sample coordinates.
        C3 modSample = CV0(noise2D(noiseMap1, pos.real.xy).xyz*.5+.5);
        C3 mod = CMul(ComplexMulCf(modSample, ParallaxFactorB), depth);

        // Modulate the wave and accumulate.
        wave = CMul(wave, mod);
        signal = CAdd(signal, wave);
    }

    // Return the final, normalized interference pattern.
    return signal;
}

psout PSnew(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);
    
    float2 uv = input.uv;
    
    // Time-dependent values.
    float time = AnimateTime;
    bool xrayMode = !KeyEDown;
    bool invertDepth = !KeyQDown;
    bool useProjectedDepth = KeyWDown;
   
    // Basic parameters from your variables.
    float centralWeight = f8; // Central weight for kernel accumulation.
    float offsetScalarI = f1;
    float offsetScalarR = f2;
    float offsetDepth = f3;
    float depthScale = DepthScale;
    float angularFrequencyScalar = f5;
    
    C3 curvatureFactor = CV0(f10);
    float fresnelFactor = f11; // Used for phase modulation.
    float oplFactor = f12; // Optical path length factor.
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    
    // Sample depth at the input UV.
    float d = depthMap.SampleLevel(sampleTypeMirror, uv, 0);
    d = invertDepth ? 1.0 - d : d;
    d = useProjectedDepth ? DepthScale * d : d;
    C3 depth0 = CV0(d);
    
    
    
    float3 viewPosf = float3(ViewX, ViewY, ViewZ);
    float3 pixelPosf = float3(uv, depth0.real.x);
    float3 viewDirf = safeNormalizef(viewPosf - pixelPosf);;
    
    C3 viewPos = CV0(viewPosf);
   // Compute pixel world position and view direction.
    C3 pixelPos = CV0(pixelPosf);
    C3 lightPos = CV0(float3(SunX, SunY, SunZ));
    C3 viewDir = CV0(viewDirf);
    // Compute the surface normal and TBN matrix.
    C3 normal;
    if (input.uv.x > 0.5)
    {
        Complex3x3 tbn3 = CalcTBN3(depthMap, uv, invertDepth, useProjectedDepth, normal);
    
        output.rt1.xyz = CMul(CV0(diffuse2D(diffuseMap, uv).xyz), CMax(C00, CDot(viewDir, CMul3x3(tbn3, normal)))).real;
    }
    else
    {
        
        float3 normalf;
        float3x3 tbn3f = CalcTBN3f(depthMap, uv, invertDepth, useProjectedDepth, NormalRadius, normalf);
        Complex3x3 tbn3;
        tbn3.normal = CV0(tbn3f[2]);
        tbn3.bitangent = CV0(tbn3f[1]);
        tbn3.tangent = CV0(tbn3f[0]);
        output.rt1.xyz = CMul(CV0(diffuse2D(diffuseMap, uv).xyz), CMax(C00, CDot(viewDir, CMul3x3(tbn3, CV0(normalf))))).real;
    }
    return output;

    /*
    
    // Retrieve diffuse albedo.
    float3 albedo = diffuse2D(diffuseMap, uv).rgb;
  
    // Accumulate kernel contributions.
    C3 kernelAccum = C00;
    C3 kernelWeight = C00;
    AccumulateInterference(noiseMap1, depthMap, diffuseMap, uv, invertDepth, useProjectedDepth,
                           time, xrayMode, offsetScalarI, offsetScalarR, offsetDepth,
                           centralWeight, fresnelFactor, angularFrequencyScalar,
                           mat, tbn3, viewPos, curvatureFactor, oplFactor, normal,
                           kernelAccum, kernelWeight);
    


    // Compute intermediate field from kernel accumulation.
    C3 intermediate = CDiv(kernelAccum, kernelWeight);
    intermediate = CMul(intermediate, CDot(normal,viewDir));
   
    
    // Optionally modulate final color by the dot product between the normal and the transformed view direction.
  //  
    
   // output.rt1.xyz = intermediate.real * dot(normal.real, viewDir.real);
    output.rt1.xyz = diffuse2D(diffuseMap, uv).xyz * max(0.0, dot(normal.real, viewDir.real));
    output.rt1.xyz = AdjustGamma(CV0(output.rt1.xyz), Gamma).real;
    

    return output;*/
}



//------------------------------------------------------------------------------
// Final Pixel Shader (PS) Function
//------------------------------------------------------------------------------
psout PS993(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);

    // Time-dependent values.
    float time = AnimateTime;
    bool xrayMode = !KeyEDown;
    bool invertDepth = KeyQDown;
    bool useProjectedDepth = !KeyWDown;
    
    // Parameter constants.
    float curvatureFactorValue = f9;
    float centralWeight = f8;
    float offsetScalarI = f1;
    float offsetScalarR = f2;
    float offsetDepth = f3;
    float fresnelFactor = f4;
    float angularFrequencyScalar = f5;
    float depthScale = DepthScale;
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    C3 depth0 = CAdd(CV0(depth2D(depthMap, input.uv, invertDepth, useProjectedDepth)), CV0(offsetDepth));
    C3 viewPos = CV0(float3(ViewX, ViewY, ViewZ));
    
    // Compute TBN using input.uv.
    C3 normal;
    Complex3x3 tbn = CalcTBN3(depthMap, input.uv, invertDepth, useProjectedDepth, normal);

    
    C3 pixelPos = CV0(float3(input.uv, depth0.real.x));
    C3 viewDir = safeNormalize(CSub(viewPos, pixelPos));
    
    // Retrieve diffuse albedo.
    float3 albedo = diffuse2D(diffuseMap, input.uv).rgb;
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(albedo));
    C3 wavelengthsM = nmToM(wavelengthsNM);
    
    // Compute frequency and angular frequency.
    C3 frequency = CDiv(CV0(SPEED_OF_LIGHT), wavelengthsM);
    C3 angularFrequency = CMul(AngularFrequency(frequency), CV0(angularFrequencyScalar));
    
    // Phase Contributions.
    C3 oplPhase = ComputeOPLPhase(angularFrequency, CV0(mat.etaR), pixelPos);
    C3 fresnelPhaseFactor = CV0(PI * (xrayMode ? 1.5 : 1.0) * FresnelPower);
    C3 fresnelPhase = ComputeFresnelPhase(CVV(mat.metallicReflectance * FresnelReflectance), viewDir, normal);
    C3 curvature = CV0(ComputeCurvature(depthMap, GetOosz(depthMap), input.uv, invertDepth, useProjectedDepth));
    C3 curvaturePhase = CMul(curvature, CV0(curvatureFactorValue));
    C3 fastOffset =
            CMul(
                CSin(
                    CAdd(CMul(
                        CAdd(
                            CSub(pixelPos, CV0(0.5)),
                            CCos(CV0(time))
                        ),
                        CV0(offsetScalarI)
                    ), CV0(0.5))
                ),
                CV0(offsetScalarR)
            );
    
    C3 totalPhase = CAdd(oplPhase, CAdd(fresnelPhase, CAdd(curvaturePhase, fastOffset)));
    C3 centralPhase = CExp(totalPhase);
    
    // Diffraction kernel accumulation.
    C3 accum = CMul(centralPhase, CV0(centralWeight));
    C3 weightSum = CV0(centralWeight);
    float2 oosz = GetOosz(depthMap);
    float2 ooszD = GetOosz(diffuseMap);
    
    for (int i = -4; i <= 4; i++)
    {
        for (int j = -4; j <= 4; j++)
        {
            if (i == 0 && j == 0)
                continue;;
            
            float2 sampleUV = input.uv + float2(i, j) * oosz;
            C3 sampleDepth = CAdd(CV0(depth2D(depthMap, sampleUV, invertDepth, useProjectedDepth)), CV0(offsetDepth));
            C3 samplePixel = CV0(float3(sampleUV, sampleDepth.real.x));
            C3 sampleCurvature = CV0(ComputeCurvature(depthMap, GetOosz(depthMap), sampleUV, invertDepth, useProjectedDepth));
            
            C3 sampleCurvaturePhase = CMul(sampleCurvature, CV0(curvatureFactorValue));
            C3 sampleFastOffset =
                    CMul(
                        CSin(
                            CAdd(CMul(
                                CAdd(
                                    CSub(samplePixel, CV0(0.5)),
                                    CCos(CV0(time))
                                ),
                                CV0(offsetScalarI)
                            ), CV0(0.5))
                        ),
                        CV0(offsetScalarR)
                    );
            C3 totalPhase = CAdd(oplPhase, CAdd(CMul(fresnelPhase, CV0(fresnelFactor)), CAdd(sampleCurvaturePhase, fastOffset)));
            C3 samplePhase = CExp(totalPhase);

            float weight = ComputeDiffractionWeight(i, j, 4.0);
            accum = CAdd(accum, CMul(samplePhase, CV0(weight)));
            weightSum = CAdd(weightSum, CV0(weight));
        }
    }
    
    C3 finalPhase = CDiv(accum, weightSum);
    C3 finalColor = finalPhase;
    
    // Optionally modulate finalColor by a dot product of normal and transformed viewDir.
    finalColor = CMul(finalColor, CV0(CDot(normal, viewDir).real));
    
    finalColor = AdjustGamma(finalColor, Gamma);
    output.rt1.xyz = CSat(CAbs(finalColor)).real;
    
    return output;
}


psout PS9932(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv);
    
    float2 uv = input.uv;

    if (uv.x > 0.5)
    {
        // Time-dependent values.
        float time = AnimateTime;
        bool xrayMode = !KeyEDown;
        bool invertDepth = KeyQDown;
        bool useProjectedDepth = !KeyWDown;
   

        C3 curvatureFactor = CV0(f9);
        float centralWeight = f8;
        float offsetScalarI = f1;
        float offsetScalarR = f2;
        float offsetDepth = f3;
        float fresnelFactor = f4;;
        float angularFrequencyScalar = f5;
        float depthScale = DepthScale;
        float oplFactor = f12;

        MaterialSellmeier mat = CreateMaterial(MaterialIndex);
        // Sample raw depth at the input UV.
        C3 depth0 = CAdd(CV0(offsetDepth), CV0(depth2D(depthMap, uv, invertDepth, useProjectedDepth)));
        C3 viewPos = CV0(float3(ViewX,ViewY,ViewZ));
    
        // Compute the surface normal and the tangent-bitangent-normal (TBN) matrix.
    //    float3 normal = CalcNormal2(depthMap, uv, viewPos, invertDepth, useProjectedDepth, NormalRadius);

        C3 normal = C00;

        Complex3x3 tbn = CalcTBN3(depthMap, uv, invertDepth, useProjectedDepth, normal);
    
        // Compute the pixel's world position using the depth.
        C3 pixelPos = CV0(float3(uv, depth0.real.x));
        C3 lightPos = CV0(float3(SunX,SunY,SunZ));
        // Compute the view direction vector.
        C3 viewDir = CSafeNormalize(CSub(viewPos, pixelPos));

        // Retrieve diffuse albedo from the diffuse map.
        float3 albedo = diffuse2D(diffuseMap, uv).rgb;
        
        
        C3 finalColor = CSat(CAbs(InterferenceHolographic_Modular(noiseMap1, 
            depthMap, 
            diffuseMap, 
            uv, 
            float2(0,0),
            invertDepth, 
            useProjectedDepth, 
            lightPos, 
            viewPos,
            depthScale, 
            time, 
            xrayMode,
            centralWeight,
            offsetScalarI,
            offsetScalarR, offsetDepth,mat, angularFrequencyScalar,
            FresnelReflectance,
            FresnelPower, fresnelFactor, curvatureFactor, oplFactor, normal)));

        
        finalColor = CMul(finalColor, CV0(CDot(normal, CMul3x3(tbn, viewDir)).real));
   
    
        finalColor = AdjustGamma(finalColor, Gamma);
        output.rt1.xyz = CSat(CAbs(finalColor)).real;
    }
    else
    {
        
        // Time-dependent values.
        float time = AnimateTime;
        bool xrayMode = !KeyEDown;
        bool invertDepth = KeyQDown;
        bool useProjectedDepth = !KeyWDown;
   

        C3 curvatureFactor = CV0(f9);
        float centralWeight = f8;
        float offsetScalarI = f1;
        float offsetScalarR = f2;
        float offsetDepth = f3;
        float fresnelFactor = f4;
        float angularFrequencyScalar = f5;
        float depthScale = DepthScale;
        float oplFactor = f12;
        MaterialSellmeier mat = CreateMaterial(MaterialIndex);
        // Sample raw depth at the input UV.
        C3 depth0 = CAdd(CV0(offsetDepth), CV0(depth2D(depthMap, uv, invertDepth, useProjectedDepth)));
        C3 viewPos = CV0(float3(ViewX,ViewY,ViewZ));
    
        // Compute the surface normal and the tangent-bitangent-normal (TBN) matrix.
        //    float3 normal = CalcNormal2(depthMap, uv, viewPos, invertDepth, useProjectedDepth, NormalRadius);

        C3 normal;
        Complex3x3 tbn = CalcTBN3(depthMap, uv, invertDepth, useProjectedDepth, normal);

        // Compute the pixel's world position using the depth.
        C3 pixelPos = CV0(float3(uv, depth0.real.x));
        C3 lightPos = CV0(float3(SunX,SunY,SunZ));
        // Compute the view direction vector.
        C3 viewDir = CSafeNormalize(CSub(viewPos, pixelPos));

        // Retrieve diffuse albedo from the diffuse map.
        float3 albedo = diffuse2D(diffuseMap, uv).rgb;

        // Convert albedo to effective wavelengths (in nanometers), then to meters.
        C3 wavelengthsNM = RGBToWavelengthsNM(CV0(albedo));
        C3 wavelengthsM = nmToM(wavelengthsNM);

        // Compute frequency and angular frequency.
        C3 frequency = CDiv(CV0(SPEED_OF_LIGHT), wavelengthsM);
        C3 angularFrequency = CMul(AngularFrequency(frequency), CV0(angularFrequencyScalar));

        //------------------------------------------------------------------------------
        // Phase Contributions (Modularized)
        //------------------------------------------------------------------------------
        // 1. Optical Path Length (OPL) phase.
        C3 oplPhase = ComputeOPLPhase(angularFrequency, CV0(mat.etaR), pixelPos);

        // 2. Fresnel phase (using a Schlick approximation).
        //    Note: 'mat' is assumed to be set elsewhere (e.g., via CreateMaterial(MaterialIndex)).
        C3 fresnelPhaseFactor = CV0(PI * (xrayMode ? 1.5 : 1.0));

        C3 fresnelPhase = ComputeFresnelPhase(CVV(mat.metallicReflectance * FresnelReflectance), viewDir, normal);

        // 3. Curvature phase.
        C3 curvature = CV0(ComputeCurvature(depthMap, GetOosz(depthMap), uv, invertDepth, useProjectedDepth));
        C3 curvaturePhase = CMul(curvature, curvatureFactor);
        
        // 4. Fast offset phase from animated offsets.
        C3 fastOffset =
            CMul(
                CSin(
                    CAdd(
                        CMul(
                            CAdd(
                                CSub(pixelPos,CV0(0.5)),
                                CCos(CV0(time))
                            ),
                        CV0(offsetScalarI)
                    ), 
                    CV0(0.5))
                ),
                CV0(offsetScalarR)
            );
  

        // Combine phase contributions.
        C3 totalPhase = CAdd(oplPhase, CAdd(CMul(fresnelPhase, CV0(fresnelFactor)), CAdd(curvaturePhase, fastOffset)));
        C3 centralPhase = CMul(CExp(totalPhase), CV0(centralWeight));


        // Accumulate contributions over a kernel neighborhood.
        C3 kernelAccum = C00;
        C3 kernelWeight = C00;
        AccumulateInterference(noiseMap1, depthMap, diffuseMap, uv, invertDepth, useProjectedDepth, time, xrayMode, offsetScalarI, offsetScalarR, offsetDepth, centralWeight, fresnelFactor, angularFrequencyScalar, mat, tbn, viewPos, curvatureFactor, oplFactor, normal, kernelAccum, kernelWeight);



        // Normalize the accumulated complex signal.
        //  kernelAccum = CDiv(CAdd(kernelAccum,  centralPhase), CAdd(kernelWeight, CV0(centralWeight)));

        //------------------------------------------------------------------------------
        // Final Color Conversion and Gamma Correction
        //------------------------------------------------------------------------------
        // For display purposes, convert the complex interference signal into a color.
        // Here we extract the magnitude as an example; you could encode phase as color too.
        C3 finalColor = CDiv(CAdd(kernelAccum, centralPhase), CAdd(kernelWeight,CV0(centralWeight)));
   
        //finalColor = CV0(finalColor.real * dot(normal.real, viewDir.real));
   
    
        finalColor = AdjustGamma(finalColor, Gamma);
        output.rt1.xyz = CSat(CAbs(finalColor)).real;
    
    }

    return output;
}



////////////////////////////////////////////////////////////////////////////////
// 4) Pixel Shader
////////////////////////////////////////////////////////////////////////////////
psout PSold8(PS_INPUT input)
{
    
    
    float curvatureFactor = f9 * .01;
    float centralWeight = f8;
    float offsetScalarI = f1;
    float offsetScalarR = f2;
    float offsetDepth = f3;
    float fresnelFactor = f4;
    float angularFrequencyScalar = f5;
    
    // read from pass data
    float time = AnimateTime;
    float ct0 = cos(time);

    psout output;
    float2 uv0 = input.uv;
    InitPSOut(output, input.uv);
    
    
    bool invertDepth = !KeyQDown, useProjectedDepth = !KeyWDown;
   
    float3 lightPos = float3(SunX, SunY, SunZ);
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
  
    float2 sz = GetSz(depthMap);
    
    float2 oosz = 1.0 / sz;
   
    int item = 1;
    bool xrayMode = true;
    int szScale = 50;
    int2 cellSize = int2(szScale, szScale);
     
    int colsPerRow = int(floor(uint(sz.x) / uint(cellSize.x)));
    
    float2 uvI = float2(
        (input.uv.x * float(sz.x) / float(cellSize.x)),
        (input.uv.y * float(sz.y) / float(cellSize.y))
    );
    int2 uvIi = int2(uvI);

    int hCount = int(floor(float(sz.x) / uint(cellSize.x)));
    int vCount = int(floor(float(sz.y) / uint(cellSize.y)));
    
    int uvCol = uvI.x;
    int uvRow = uvI.y;
    // Carefully chosen parameters
    
    float SpecOffset = HeightParamC;
    float MaxwellFreq = FresnelMix;
    
   
    // Distances for multi-plane steps
    float zNear = CosineFactorR;
    float zMid = CosineFactorG;
    float zFar = CosineFactorB;

    // Light & View positions
    
   
    // For demonstration, sample your diffuse/normal/depth
    
    // Additional factors for wave expansions
  
    float depth0 = depth2D(depthMap, input.uv, invertDepth, useProjectedDepth, NormalRadius);
    
  //  Complex2ParallaxResult res = ComplexParallaxOcclusion(depthMap, Complex2Create(input.uv), Complex2Create(float2(lerp(-0.001, 0.001, 1.0 - depth0), 0.0)), invertDepth, useProjectedDepth, ParallaxScale * ct0);
    
    float2 deltaUV = float2(0, 0); //res.deltaUVs[res.intersectionCount - 1].real;
    float2 adjustedUV = deltaUV + input.uv;
   
    
    float3 normal = CalcNormal(depthMap, adjustedUV, useProjectedDepth, invertDepth);
    //normal =  -CalcNormal(depthMap, adjustedUV, invertDepth);

        // Pixel and normal calculations
    float depth = depth2D(depthMap, adjustedUV, invertDepth, useProjectedDepth, NormalRadius);
   
    float3 pixelPos = float3(adjustedUV, depth);
    
    float3 viewDir = normalize(viewPos - pixelPos);
  
    float3 lightDir = normalize(lightPos - pixelPos);
    float3 halfDir = normalize(viewDir + lightDir);
    
//    float3x3 tbn = CalcTBN(CV0(normal));
    float FresnelHighlight = f7;
    float3 normal4;
    float3x3 tbnf = CalcTBN3f(depthMap, adjustedUV, invertDepth, useProjectedDepth, NormalRadius, normal4);
    float3 normal3 = normalize(CalcNormal(depthMap, adjustedUV, useProjectedDepth, invertDepth));
    float3 diffuse =
        (diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV, 0).rgb * 1.5 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV + 0.00125, 0).rgb * .75 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV + float2(0, 0.0025), 0).rgb * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV + float2(0, -0.0025), 0).rgb * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV + float2(0.0025, 0), 0).rgb * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV + float2(-0.0025, 0), 0).rgb * .5 +
        diffuseMap.SampleLevel(sampleTypeMirror, adjustedUV - 0.00125, 0).rgb * .75) * 1.0 / 4;
    float3 wvNM = CMag(RGBToWavelengthsNM(CV0(diffuse))).real;
    MaterialSellmeier mat = CreateMaterial(fmod(MaterialIndex, 9));
  
    float3 normal2 = normal2D(normalMap, adjustedUV);
   
    float3 baseColor = diffuse;
    
    
    float3 albedo = baseColor * mat.albedo;
   
    C3 albedoWavelengthsNM = RGBToWavelengthsNM(CV0(albedo));
    C3 albedoWavelengthsM = nmToM(albedoWavelengthsNM);
    
    float ReflectIndex = f8 * depth;
    
    float3 nSurrounding = ONE3 * mat.nSurrounding;
        
  
    int ix = clamp(uvRow * colsPerRow + uvCol, 0.0, 50.0);
    
        
        //output.rt1 = lerp(output.rt1, float4(diffuse2D(diffuseMap, adjustedUV + float2(0.01 * depth, 0)).r,output.rt1.g,diffuse2D(diffuseMap, adjustedUV - float2(0.01 * depth / cos(time), 0)).b, 1.0), 0.5+depth/cos(time)*0.5);
        //return output;
    
   // return output;
/*    if (any(uvIi != int2(uvI + oosz * 30)))
    {
        discard;
        output.rt1 = float4(0, 0, 0, 1);
    }
    else
    {
    */
     // Compute the interference field using your advanced holographic function.
        // Compute the interference field.
        // Compute the interference field.
       
       /*
    
    //output.rt8;
    // Pass-based logic
        if (PassNum == 0)
        {
       
        ///////////////////////////////////////////////
        // PASS 0 - Initialize wave data (TE/TM)
        ///////////////////////////////////////////////
            Complex3Pol wave0;
        // Start with amplitude => baseColor * LightIntensity, zero phase
            wave0.realTE = (saturate(baseColor * LightIntensity * max(0.0, dot(viewDir, halfDir))));
            wave0.imagTE = float3(0.0, 0.0, 0.0);
            wave0.realTM = (saturate(baseColor * (LightIntensity - 0.1) * max(0.0, dot(viewDir, lightDir))));
            wave0.imagTM = float3(0.151, 0.125, 0.18); // small offset

        // Optionally apply 1..2 steps for wave
        // E.g. Interf1_Hilbert + Interf2_Rayleigh
            Complex3Pol wave02 = Interf1_Hilbert(wave0);
        
            
            Complex3Pol wave1;
            wave1.realTE = (saturate(baseColor * LightIntensity * max(0.0, dot(viewDir, halfDir))));
            wave1.imagTE = float3(0.0, 0.0, 0.0);
            wave1.realTM = (saturate(baseColor * (LightIntensity - 0.1) * max(0.0, dot(viewDir, lightDir))));
            wave1.imagTM = float3(0.151, 0.125, 0.18);
            
            
            
            float4 oc = AberrationsEnhancedPS(float4(adjustedUV, depth, 1), adjustedUV, diffuseMap, Mix2 * max(0.0, dot(viewDirTS, normal.real)), time, Mix3 * max(0.0, dot(viewDir, halfDir))) * max(0.0, dot(viewDir, normal.real));
            
            
            // small offset
            // apply more steps e.g. Mie, ThinFilm
            Complex3Pol waveMid1 = Interf3_Mie(wave1, mat.thicknessM, PhaseOffsetR);
            Complex3Pol waveMid2 = Interf5_ThinFilm(waveMid1, mat.thicknessM, (ndl + ndv) * mat.coherenceLengthM, PhaseOffsetG );

            
            
            // Combine
            Complex3Pol sumC0 = C3PAdd(C3PAdd(C3PAdd(wave0, wave1), waveMid1), waveMid2);

        // apply more steps e.g. Fresnel, Maxwell, Holo, MultiPlane, Brewster, etc.
        // demonstration of final chain:

        // 9) Fresnel
            float3 specPow = SpecularPower;
            float3 sv = pow(max(ndh, 0.0), specPow);
            float3 f0 = pow((1 - mat.etaR) / (1 + mat.etaR), 2);
            f0 += (1 - f0) * pow(1 - ndh, SpecularIntensity);
            float3 fresVal = sv * f0 * FresnelHighlight;
            Complex3Pol sumC1 = Interf9_Fresnel(sumC0, fresVal);

            // 12) Maxwell
            Complex3Pol sumC2 = Interf12_Maxwell(sumC1, MaxwellFreq, ndl);

            // 13) Holo
       // float3 hv = max(0.0, dot(L, V)) * float3(0.08, 0.08, 0.08) * HeightScale * depth * ndv;
      // sumC = Interf13_Holo(sumC, hv);

            // 14) MultiPlane
          //  Complex3Pol sumC3 = Interf14_MultiPlane(sumC2, zNear * length(CombinePol(waveMid2, dot(viewDir, halfDir)) * 0.5 + 0.5), length(CombinePol(sumC1, dot(viewDir, halfDir)) * 0.5 + 0.5) * zMid, zFar * length(CombinePol(sumC2, dot(viewDir, halfDir)) * 0.5 + 0.5), dot(normal.real, CombinePol(wave0, dot(normal.real, lightDir))));

            // 15) Brewster
            Complex3Pol sumC4 = Interf15_Brewster(sumC2, ndv);
        
        
        output.rt1 = float4(CombinePol(sumC4, 1.0), 1.0);
            
*/
   
    if (PassNum > 0)
    {
        C3 hps2 = CV0(output.rt1.xyz*2-1.0);
        C3 hps1 = CV0(output.rt2.xyz*2-1.0);
        C3 cm3 = CV0(output.rt3.xyz);
        C3 oc5 = AberrationsEnhancedPS(float4(adjustedUV, depth, 1), adjustedUV, rtMap2, hps2, time, hps1);
       
        C3 oc6 = AberrationsEnhancedPS(float4(adjustedUV, depth, 1), adjustedUV, rtMap1, hps1, time, hps2);
     
  
        output.rt1.xyz = hps2.real;

            //if (adjustedUV.x > 0.25)
            {
                /*if (adjustedUV.x > 0.5)
                {
                    LightingComplex lightingComplex =
             PopulateLightingComplex(adjustedUV, viewPos, float3(SunX, SunY, SunZ), invertDepth, useProjectedDepth, DepthScale,
                MaterialIndex, AnimateSpeed, ParallaxScaleOMD, NormalRadius, 0.5, 0, Gamma,
                0.5, FresnelMix, test);
        
                    float3 cout = output.rt1.xyz;
                    getColorComplex(rtMap1, adjustedUV, adjustedUV, lightingComplex, 0, 0, invertDepth, useProjectedDepth, output);
                
                    if (adjustedUV.x > 0.75)
                    {
                        float3 cout2 = output.rt1.xyz;
                        getColorComplex(rtMap2, adjustedUV, adjustedUV, lightingComplex, 0, 0, invertDepth, useProjectedDepth, output);
                    
                    }
                }*/
            float3 wvNM = RGBToWavelengthsNM(CMag(hps2)).real;
            LightingComplex lightingComplex = PopulateLightingComplex(diffuseMap, adjustedUV, viewPos, lightPos, invertDepth, useProjectedDepth, DepthScale, mat, AnimateSpeed, ParallaxScaleOMD, NormalRadius, 0.5, 0, Gamma, 0.5, FresnelMix);
        
            output.rt2.xyz = CMag(hps2).real;
            output.rt1.xyz = adjustedUV.y < .1 ? getColorComplex(lightingComplex, ix, 0) : (1 - diffuse2D(rtMap2, adjustedUV + oc6.real.xy * .005).xyz * depth * lightingComplex.NdotL3) * lightingComplex.totalLighting[0];
            
            //output.rt1.xyz = (diffuse + oc6.real * cm3.real * 0.01 + (lightingComplex.phaseShift[0]).real*0.01 + lightingComplex.specularWithSheen*0.01) * max(0.0, dot(lightingComplex.normal, lightingComplex.lightDir));
            if (adjustedUV.y > .8)
            {
              //  output.rt1.xyz = hps1.real * max(0, dot(viewDir, normal.real)) + cout * CMul(CSat(CAbs(oc6)), CSat(CAbs(CMul(CV0(output.rt1.xyz),CAdd(cm3, hps2))))).real; //CAbs(CMul(CAdd(CV0(output.rt1.xyz), oc5), CMul(hps1, hps2))).real;
            }
       
        
            if (NumPasses == 2 && PassNum == 1)
            {
                float w = 0.12;
                float cx = 0;
                if (adjustedUV.y > .9)
                {
                    if (adjustedUV.x < (cx += w))
                    {
                    }
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = hps1.real.xyz * .5 + .5;
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = hps2.real.xyz * .5 + .5;
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = oc5.real.xyz * .5 + .5;
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = oc6.real.xyz * .5 + .5;
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = cm3.real.xyz * .5 + .5;
                    else if (adjustedUV.x < (cx += w))
                        output.rt1.xyz = output.rt7.xyz;
                    else
                        output.rt1.xyz = output.rt8.xyz;
                }
            }
        }
        //lerp(saturate(((oc5.xyz * (hps2.real * .5 + .5)))), saturate(((oc6.xyz * (hps2.real * .5 + .5)))), depth);
       
    }
    else
    {

        float oplFactor = f12;
 
        C3 lightColor = HolographicPS2(adjustedUV, time, f5, f6, f7, f8, invertDepth, useProjectedDepth);
        
        
        C3 holo =
            HolographicPS2(adjustedUV, time, f1, f2, f3, f4, invertDepth, useProjectedDepth);
            
        C3 hps1 = CAdd(lightColor, holo);
       
        C3 hps2 = CAdd(hps1, CV0(diffuse*2-1));
        
        
        output.rt1.xyz = hps2.real;
        
        output.rt5.xyz = lightColor.real;
        output.rt6.xyz = holo.real;
       
        if (NumPasses == 1)
        {
            float w = 0.12;
            float cx = 0;
            if (adjustedUV.y < .2)
            {
                if (adjustedUV.x < (cx += w))
                {
                }
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt2.xyz;
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt3.xyz;
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt1.xyz * output.rt2.xyz;
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt1.xyz * output.rt3.xyz;
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt1.xyz * output.rt2.xyz * output.rt3.xyz;
                else if (adjustedUV.x < (cx += w))
                    output.rt1.xyz = output.rt2.xyz * output.rt3.xyz;
                else
                    output.rt1.xyz = output.rt8.xyz;
            }
            
        }
        
    }
    output.rt1.xyz = adjustedUV.x > .5 && adjustedUV.y > .5 ? diffuse2D(diffuseMap, adjustedUV).xyz : AdjustGamma(CV0(output.rt1.xyz), Gamma).real - .2 * saturate(dot(normal, viewDir));
    return output;
        /*
            
            return output;
            
            // 16) TcpIpLayer
           // sumC = Interf16_TcpIpLayer(sumC,0.2 + MaxwellFreq, depth);

            
            float3 finalColor = CombinePol(sumC4, 1.0) * 0.5 + 0.5;
            finalColor = saturate(finalColor);

            // output
            output.rt4 = float4(finalColor, 1.0);
            
            
            
            // store into rt4, rt5
            float4 out4, out5;
            PackWave12(sumC0, out4, out5);
            output.rt5 = saturate(out4);
            output.rt6 = saturate(out5);

        // pack wave0 into rt2, rt3
            float4 out2, out3;
            PackWave12(sumC4, out2, out3);
            output.rt7 = out2;
            output.rt8 = out3;
            
            // store into rt4, rt5
            float4 out6, out7;
            PackWave12(waveMid1, out6, out7);
            output.rt3 = saturate(out6);
            output.rt4 = saturate(out7);
            
            
            
            
            C3 cm = InterferenceHolographic(noiseMap1, depthMap, diffuseMap,
    adjustedUV, deltaUV, invertDepth, useProjectedDepth, lightPos, viewPos,
    cos(time), AnimateTime, KeyEDown);
                
            int dispersionIndex = int(clamp(FresnelMix, 0, 3));
                
            LightingComplex lightingComplex =
            PopulateLightingComplex(adjustedUV, viewPos, float3(SunX, SunY, SunZ), invertDepth, useProjectedDepth, cos(time), currentDepthRange, MaterialIndex, AnimateSpeed, ParallaxScale * (1 - depth), NormalRadius, 0.5, dispersionIndex, Gamma, 0.5, FresnelMix, test);
        
        
            
       // for (int i = 4; i > 0; i--)
        
            float4 c = output.rt1;
            output.rt1 = diffuse2D(diffuseMap, adjustedUV);
            getColorComplex(diffuseMap, adjustedUV, adjustedUV, lightingComplex, ix, dispersionIndex, invertDepth, useProjectedDepth, output);
            float4 oc2 = output.rt1;
            
            output.rt1 = lerp(output.rt1, hps2, 0.5) * max(0.0, dot(halfDir, viewDir)) +
                float4(float3(max(0.0, dot(viewDir, normal.real)) * CAbs(cm)), float(dot(halfDir, viewDir)));
            if (NumPasses == 1)
            {
                
                
                if (adjustedUV.x < 0.25)
                {
                    output.rt1 += oc2 * 0.01;
                }
            }
            else
            {
                output.rt1 = float4(diffuse2D(diffuseMap, adjustedUV).xyz, 1.0);

            }
        }

        return output;

    }*/
    
}



// This function computes a scalar intensity value from a micro-textured surface,
// using complex arithmetic to represent phase and amplitude. It returns a float3
// (per-channel intensity) based on the diffuse amplitude modulated by interference.
float3 ComputeOpticalField(float2 uv, float3 i)
{
    // Assume viewPos is constructed from global ViewX, ViewY, ViewZ.
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    // (SamplerState and MaterialSellmeier are not further used in this snippet.)
    
    // Sample the depth map and scale.
    float depthVal = depth2D(depthMap, uv, !KeyQDown, !KeyWDown); // user-supplied function
    float3 depth = ONE3 * depthVal * DepthScale;
    
    // Sample the diffuse color as the base amplitude.
    float3 amplitude = diffuse2D(diffuseMap, uv).rgb;
    
    // Sample the normal map and remap from [0,1] to [-1,1].
    float3 normal = CalcNormal(depthMap, uv, !KeyQDown, !KeyWDown).rgb; // user-supplied
    
    // Compute phase shift from depth.
    // RGBToWavelengthsNMf converts diffuse color into effective wavelengths per channel.
    float3 wavelengths = RGBToWavelengthsNMf(diffuse2D(diffuseMap, uv).rgb);
    float3 phaseShift = (wavelengths / depth); // user-supplied
    
    // Modulate the phase with time.
    float3 totalPhase = (phaseShift); // user-supplied
    
    // Create a complex phase factor: exp(i * totalPhase) per channel.
    C3 phaseFactor = CExp(CV0(i*totalPhase));
    
    // Construct the complex field: amplitude * exp(i*phase)
    
    // Optionally, add noise modulation for partial coherence.
    float noise = noise2D(noiseMap1, uv).r;
    
    C3 field = phaseFactor;
    // Incorporate angular dependence: modulate by dot(normal, lightDir)
    float3 lightDir = normalize(viewPos - float3(uv, length(depth) * 0.3));
    phaseFactor.real *= saturate(dot(normal, lightDir));
    
    
    // Return the diffuse amplitude modulated by the computed intensity.
    return amplitude * phaseFactor.real;
}

//////////////////////////////////////////////////////////////
// Advanced Complex Optical Field Computation
//////////////////////////////////////////////////////////////

// Computes the object beam as a full C3 field,
// incorporating dispersion (via per-channel wavelengths), depth, and view-dependent phase.
C3 ComputeComplexOpticalField(float3 viewDir, float3x3 tbn, float2 uv, float depth, float NdotV, float3 wavelengthsNM)
{
    // Compute phase shifts: Δφ = (2π/λ) * (2 * depth) + modulation.
    C3 phaseV = CMul(C2PIDiv(CVV(wavelengthsNM)), CVVMul2(depth));
    C3 mod = CV0(ComputeOpticalField(uv, length(nmToM(CVV(wavelengthsNM)).real)));
    phaseV = CMul(phaseV, mod);
    //float3 phaseV = ((2.0 * PI / wavelengthsNM) * (2.0 * (depth)) + (sin(AnimateTime) * (PI))) * SPEED_OF_LIGHT;
    
    // Construct the C3 phase vector.
    // Here, the real part encodes an amplitude modifier per channel (with slight dispersion),
    // and the imaginary part is the computed phase.
    C3 phase = C0V(phaseV.real);
    
    // Return the object beam: diffuse amplitude (with a minor bias) times the phase factor.
    return CV(CSatMag(CMul(CV0(diffuse2D(diffuseMap, uv).xyz), CMagSq(mod))).real, phase.real);
}

// Computes the coherent reference beam as a C3 field.
// This is a plane wave with adjustable tilt and time-varying phase.
C3 ComputeComplexReferenceField(float2 uv, float3 tilt, float3x3 tbn)
{
    float3 refPhase = mul(tbn, tbn[2]) * cos(AnimateTime) * f4;
    return C0V(refPhase);
}

//////////////////////////////////////////////////////////////
// Multi-Pass Accumulation
//////////////////////////////////////////////////////////////

// Accumulate colors from successive passes for progressive refinement.
C3 AccumulateColor(C3 currentColor, C3 previousAccum, float factor)
{
    C3 vfactor = CMul(CDiv(C11, CAdd(CV1(PassNum), C11)), CV1(factor));
    C3 ret = CMMul(CV0(previousAccum.real), CAdd(CV0(PassNum), CV0(currentColor.real)), vfactor);
    
    return ret;
}

//////////////////////////////////////////////////////////////
// Final Holographic Pixel Shader
//////////////////////////////////////////////////////////////



// The final holographic shader that uses complex arithmetic to produce interference fringes.
psout PS(PS_INPUT input)
{
    psout output;
    InitPSOut(output, input.uv); // Assume this function initializes the psout structure.
    
    float3 normal;
    float depth = depth2D(depthMap, input.uv, !KeyQDown, !KeyWDown);
    float2 depthMod = GetModulation(GetGradient(depthMap, input.uv, !KeyQDown, !KeyWDown));
   
    depth = depth2D(depthMap, input.uv, !KeyQDown, !KeyWDown);
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);;
    
        
    if (PassNum == 0)
    {
        normal = normalize(CalcNormal(depthMap, input.uv, !KeyQDown, !KeyWDown));
        output.rt8.xyz = normal * .5 + .5;
    }
    else
    {
        normal = normalize(output.rt8.xyz * 2 - 1);
    }
    float3 viewPos = float3(ViewX, ViewY, ViewZ);;
    
    float3 pixel = float3(input.uv, depth);
    float3 lightPos = float3(SunX, SunY, SunZ);
    float3 lightDir = normalize(lightPos - pixel);
    float3 viewDir = normalize(viewPos - pixel);
    float3 halfDir = normalize(lightDir + viewDir);
    
    float3 diffuse = diffuse2D(diffuseMap, input.uv).xyz;
    float3 wavelengthsNMf = RGBToWavelengthsNMf(diffuse);
    float3x3 tbn = CalcTBN3f(depthMap, input.uv, !KeyQDown, !KeyWDown);
    // 1. Compute the object beam as a full complex field.
    C3 objectField = ComputeComplexOpticalField(viewDir, tbn, input.uv, depth,
        max(0, dot(normal, viewDir)), wavelengthsNMf);
    // 2. Compute the coherent reference beam.
    C3 referenceField = ComputeComplexReferenceField(input.uv, CMag(objectField).real, tbn);
    
    // 3. Holographic interference: complex summation.
    C3 holoField = CSatMag(CMul(objectField, CAdd(CV0(diffuse), referenceField)));
    
    C3 wavelengthsNM = RGBToWavelengthsNM(CV0(diffuse));
    C3 wavelengthsM = nmToM(wavelengthsNM);

        // Compute frequency and angular frequency.
    C3 frequency = CDiv(CV0(SPEED_OF_LIGHT), wavelengthsM);
    C3 angularFrequency = AngularFrequency(frequency);

        //------------------------------------------------------------------------------
        // Phase Contributions (Modularized)
        //------------------------------------------------------------------------------
        // 1. Optical Path Length (OPL) phase.
    C3 oplPhase = ComputeOPLPhase(angularFrequency,
        CV0(mat.etaR), CV0(pixel));

    // 2. Fresnel phase (using a Schlick approximation).
    //    Note: 'mat' is assumed to be set elsewhere (e.g., via CreateMaterial(MaterialIndex)).
    C3 fresnelPhaseFactor = CMul(CPI, CAdd(C1, Cp5));

    C3 fresnelPhase = CSub(C01, ComputeFresnelPhase(CV0(mat.metallicReflectance), CV0(viewDir), CV0(normal)));

        // 3. Curvature phase.
    C3 curvaturePhase = C0V(ComputeCurvature(depthMap, GetOosz(depthMap), input.uv, !KeyQDown, !KeyWDown));
    float offsetScalarI = f1;
    float offsetScalarR = f2;
        // 4. Fast offset phase from animated offsets.
    C3 fastOffset =
            CMul(
                CSin(
                    CAdd(
                        CMAdd(
                            CSub(CV0(pixel), Cp50),
                            CCos(CTime),
                            CV0(offsetScalarI)
                        ),
                        Cp50
                    )
                ),
                CV0(offsetScalarR)
            );
  

        // Combine phase contributions.
    C3 totalPhase = fresnelPhase; //CAAdd(fresnelPhase, curvaturePhase, oplPhase);
    C3 centralPhase = CExp(totalPhase);

    
    
    
    // 4. Compute intensity from the complex holographic field.
    // Per-channel intensity: |holoField|^2 = (real^2 + imag^2)
    C3 currentColor = CSatMag(CMul(referenceField,objectField));
    
    int dispersionIndex = 0;
        
    LightingComplex lightingComplex =
            PopulateLightingComplex(diffuseMap, input.uv, viewPos, float3(SunX, SunY, SunZ), !KeyQDown, !KeyWDown, DepthScale, mat, AnimateSpeed, ParallaxScale, NormalRadius, 0.5, dispersionIndex, Gamma, 0.5, 0.7);
   
    currentColor = CV0(max(0, dot(normal, lightDir)) * max(0, dot(normal, viewDir)) * max(0, dot(viewDir, halfDir)) * CSatMag(CAdd(CV0(max(0, dot(normal, lightDir)) * max(0, dot(normal, viewDir)) * max(0, dot(viewDir, halfDir)) * lightingComplex.specularWithSheen),
        CSatMag(lightingComplex.diffuseTransmittance[dispersionIndex]))).real);
    
    // 5. Multi-pass accumulation.
    C3 previousAccum = currentColor;
    if (PassNum > 0)
        previousAccum = CV(output.rt3.xyz*2-1, output.rt4.xyz*2-1);
    
    C3 accumColor = AccumulateColor(currentColor, previousAccum, f3);
    
    // 7. Write to output render accumColor.
    output.rt3.xyz = saturate(accumColor.real);
    output.rt4.xyz = saturate(accumColor.imag * .5 + .5);
    // Example: conditionally update another render target based on uv.x.
    //C3 specular = SpecularBRDFComplex(normal, viewDir, lightDir, mat.roughness, CVV(mat.etaR));
    output.rt1.xyz = AdjustGamma(CMag(accumColor), Gamma).real;

    output.rt1.xyz += FractalAurora(f7, input.uv, AnimateTime, 0, lightingComplex);
    
   /* if (input.uv.x < .25)
        output.rt1.xyz = CMag(objectField).real;
    else if (input.uv.x < .5)
        output.rt1.xyz = CMag(referenceField).real;
   */
    return output;
}



