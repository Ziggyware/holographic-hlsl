#define DepthScale (DepthScale0)
#define CENTER float3(0.5, 0.5, 0.5)

#define dFdx(x) ddx_fine(x)
#define dFdy(y) ddy_fine(y)

#define COHERENCE_LENGTH_M f12

#define FLT_MAX 1e+16
#define FLT_MIN 1e-16

#define EPSILON 1e-12
#define EPSILONh 1e-12h
#define CSPEED_OF_LIGHT CV0(SPEED_OF_LIGHT)
#define C0VSPEED_OF_LIGHT C0V(SPEED_OF_LIGHT)
#define CV0SPEED_OF_LIGHT 
#define time (AnimateSpeed*TotalTime)
#define resolution GetSz(depthMap)

#define RED_MIN_WAVELENGTH 620.0
#define RED_MAX_WAVELENGTH 750.0
#define RED_WAVELENGTH (RED_MIN_WAVELENGTH+(RED_MAX_WAVELENGTH-RED_MIN_WAVELENGTH)*.5)
#define GREEN_MIN_WAVELENGTH 495.0
#define GREEN_MAX_WAVELENGTH 570.0
#define GREEN_WAVELENGTH (GREEN_MIN_WAVELENGTH+(GREEN_MAX_WAVELENGTH-GREEN_MIN_WAVELENGTH)*.5)
#define BLUE_MIN_WAVELENGTH 450.0
#define BLUE_MAX_WAVELENGTH 495.0
#define BLUE_WAVELENGTH (BLUE_MIN_WAVELENGTH+(BLUE_MAX_WAVELENGTH-BLUE_MIN_WAVELENGTH)*.5)


#define MIN_WAVELENGTHS float3(RED_MIN_WAVELENGTH, GREEN_MIN_WAVELENGTH, BLUE_MIN_WAVELENGTH)
#define MAX_WAVELENGTHS float3(RED_MAX_WAVELENGTH, GREEN_MAX_WAVELENGTH, BLUE_MAX_WAVELENGTH)
#define RGB_WAVELENGTHS_NM float3(RED_WAVELENGTH, GREEN_WAVELENGTH, BLUE_WAVELENGTH)
#define RGB_WAVELENGTHS_M nmToM(RGB_WAVELENGTHS_NM)
#define RGB_WAVELENGTHS_UM nmToUm(RGB_WAVELENGTHS_NM)
#define MAX_WAVELENGTH 780.0
#define MIN_WAVELENGTH 380.0


#define WAVELENGTH_RANGES (MAX_WAVELENGTHS-MIN_WAVELENGTHS)
#define WAVELENGTH_RANGE (MAX_WAVELENGTH-MIN_WAVELENGTH)
#define WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE (CHROMATICITY_RANGE/WAVELENGTH_RANGES)

#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)

#define MAX_GRATING_LAYERS 10
#define MAX_GAUSSIAN_POINTS 3
#define MAX_INTERFERENCE_POINTS MAX_GAUSSIAN_POINTS
#define MAX_SHADOW 3
#define MIN_DEPTH_RANGE 0
#define MAX_DEPTH_RANGE DepthScale

#define nmToM(x) (x*1e-9)
#define mToNm(x) (x*1e9)
#define nmToUm(nm) (nm*1e-3)
#define umToNm(um) (um*1e3)

#define umToM(um) (um*1e-6)
#define mToUm(m) (m*1e6)


#define Depth01 clamp(Depth, EPSILON, 1.0-EPSILON)


//#define ViewPos float3(ViewX,ViewY,ViewZ)
//#define LightPos float3(SunX,SunY,SunZ)

#define ViewDir normalize(ViewPosM - PixelWorldM)
#define HalfDir normalize(LightDir + ViewDir)
#define LightDir normalize(LightPosM - PixelWorldM)

#define Grating1Diffuse SampleDiffuse(gratingMap1, InputUV)
#define Grating1DepthM umToM(SampleDepth(gratingDepth1, InputUV))

#define Grating1Normal calcNormal(gratingDepth1, InputUV)
#define RightDir normalize(EPSILON3+cross(ViewDir, float3(0,1,0)))
#define UpDir normalize(EPSILON3+cross(ViewDir, RightDir))

#define Grating4Diffuse SampleDiffuse(gratingMap4, InputUV)
#define Grating4DepthM umToM(SampleDepth(gratingDepth4, InputUV))
#define Grating4PixelWorldM float3(PixelWorldM.xy, Grating4DepthM)

#define TO_WORLD_UM(uv, depth) float3((uv)-0.5, -abs((depth*.5+.5) * sqrt(DepthScale)))

#define DepthUM Depth
#define DepthM umToM(DepthUM)
#define DepthNM umToNm(DepthUM)
#define ViewPosUM TO_WORLD_UM(float2(ViewX,ViewY), ViewZ)
#define LightPosUM TO_WORLD_UM(float2(SunX,SunY), SunZ)
#define ViewPosM umToM(ViewPosUM)
#define ViewPosNM umToNm(ViewPosUM)
#define LightPosM umToM(LightPosUM)
#define LightPosNM umToNm(LightPosUM)
#define PixelWorldUM TO_WORLD_UM(InputUV, Depth)
#define PixelWorldNM umToNm(PixelWorldUM)
#define PixelWorldM umToM(PixelWorldUM)


#define CViewPosUM CV0(ViewPosUM)
#define CLightPosUM CV0(LightPosUM)
#define CViewPosNM CV0(ViewPosNM)
#define CLightPosNM CV0(LightPosNM)
#define CDepthNM CV0(DepthNM)
#define CPixelWorldNM CV0(PixelWorldNM)
#define clampEpsilon(x) clamp(x, EPSILON, 1.0-EPSILON)



#define SetDV(name, val) {Complex3 _##name [3]; _##name = lighting.##name ; _##name [dispersionIndex] = val; lighting.##name = _##name;}


#define SetDVo(name, val) {OpticalPathResult _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name;}

#define SetDVf(name, val) {float3 _##name[3];_##name = lighting.##name;_##name[dispersionIndex] = val;lighting.##name = _##name;}


#define linearSampler sampleTypeLinear

#define SetDV(name, val) { Complex3 _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }
#define SetDVo(name, val) { OpticalPathResult _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }
#define SetDVf(name, val) { float3 _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }

// Complex Number Macros
#define C3 Complex3
#define CV0Norm(v) CV0(normalize(v.real+EPSILON3))
#define CV(v1,v2) ComplexCreate(v1, v2)
#define CV0(v) CV(v,ZERO3)
#define C0V(v) CV(ZERO3, v)
#define CVV(v) CV(v,v)
#define C00 CVV(ZERO3)
#define C11 CVV(ONE3)
#define CN1 CV0(-ONE3)
#define C10 CV0(ONE3)
#define C01 C0V(ONE3)
#define CPI CVV(PI3)
#define CPIo2 CVV(PI3/2)
#define C2PI CVV(TWO3 * PI3)
#define CSat(v) ComplexSaturate(v)
#define CAdd(v1,v2) ComplexAdd(v1, v2)
#define CSub(v1,v2) ComplexSub(v1, v2)
#define CMul(v1,v2) ComplexMul(v1, v2)

#define CDiv(v1,v2) ComplexDiv(v1, v2)
#define CAbs(v) ComplexAbs(v)
#define CMag(v) ComplexMagnitude(v)
#define C090180(v) CVV(float3((v).x, (v).y+1.5708, (v).z+3.1416))
#define CMod(v,m) CV(fmod((v).real,(m)),fmod((v).imag,(m)))
// Constants
#define SPEED_OF_LIGHT 2.99792458e+8
#define PI 3.141592653589793
#define PI3 float3(PI, PI, PI)
#define TWO3 float3(2.0, 2.0, 2.0)
#define ZERO3 float3(0.0, 0.0, 0.0)
#define ONE3 float3(1.0, 1.0, 1.0)
#define EPSILON3 float3(1e-9, 1e-9, 1e-9)

#define ZERO41 float4(0.0,0.0,0.0,1.0)
#define ZERO4 float4(0.0,0.0,0.0,0.0)
#define ZERO3 float3(0.0,0.0,0.0)
#define ZERO2 float2(0.0,0.0)
#define ZERO1 float(0.0)

#define ZERO4h half4(0.0h,0.0h,0.0h,0.0h)
#define ZERO3h half3(0.0h,0.0h,0.0h)
#define ZERO2h half2(0.0h,0.0h)
#define ZERO1h half(0.0h)

#define ONE2 float2(1.0,1.0)
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

#define OneMinusEPSILON (1.0-EPSILON)
#define OneMinusEPSILONh (1.0h-EPSILONh)
#define EPSILON2 float2(EPSILON,EPSILON)
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


#define C3 Complex3
#define CV(v1,v2) ComplexCreate(v1,v2)
#define CNorm(v1) CV(normalize(v1.real+EPSILON3), ZERO3)

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
#define CSatMag(v) saturate(CMag(v))
#define CVVSat(v) CSat(v)
#define CV0Sat(v) CSat(CV0(v.real))
#define C0VSat(v) CSat(C0V(v.imag))

#define CV0Satf(v) CV0Sat(CV0(v)).real
#define C0VSatf(v) C0VSat(C0V(v)).imag

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


#define CV0MulSOL(v) CMul(CV0(v),CSPEED_OF_LIGHT)
#define C0VMulSOL(v) CMul(C0V(v),C0VSPEED_OF_LIGHT)
#define CMulSOL(v) CMul(v,CSPEED_OF_LIGHT)

#define CV0DivSOL(v) CDiv(CV0(v),CSPEED_OF_LIGHT)
#define C0VDivSOL(v) CDiv(C0V(v),C0VSPEED_OF_LIGHT)
#define CDivSOL(v) CDiv(v,CSPEED_OF_LIGHT)

#define CV0SOLDiv(v) CDiv(CSPEED_OF_LIGHT,CV0(v))
#define C0VSOLDiv(v) CDiv(C0VSPEED_OF_LIGHT,C0V(v))
#define CSOLDiv(v) CDiv(CSPEED_OF_LIGHT,v)



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






const float PlanckConstant = 6.62607015e-34;
const float PhotonMass = 1e-50;
const float G = 6.67430e-11;





#define FLT_MAX 1e+16
#define FLT_MIN 1e-16


// Number of wavelength samples
#define NUM_SAMPLES 471
#define SPECTRAL_LOCUS_COUNT 471

// Enumerations for Film Types

#define FILM_TYPE_THICK_GLASS 0
#define FILM_TYPE_OILY_GLASS 1
#define FILM_TYPE_THICK_OIL 2
#define FILM_TYPE_HOLOGRAPHIC 3
#define TOTAL_FILM_TYPES 4


// --- Constants for Sheen Calculation (configurable) ---
#define SHEEN_ROUGHNESS_MULTIPLIER HeightParam.y  
#define SHEEN_ALBEDO_TINT float3(0.3, 0.5, 0.7) 
#define ADVANCED_SHEEN_ANISOTROPY 0.6
#define ADVANCED_SHEEN_POWER f05

// --- Constants for Clear Coat (configurable) ---
 // Affects the strength of the clear coat effect
#define CLEAR_COAT_THICKNESS 40
// IOR of the clear coat layer (typical value for polymers)
#define CLEAR_COAT_IOR 1.5
#define CLEAR_COAT_ROUGHNESS_MULTIPLIER 0.02


#define LP_CASE(n, prop) case n: { output.rt1.xyz = lighting.##prop;}break;
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


#define CONVERTUV(UVa,UVb,texA,texB) float2 convert##UVa##To##UVb(Texture2D<texA> sourceMap, float2 mapUV, Texture2D<texB> targetMap) { return mapUV * GetSz(sourceMap) / GetSz(targetMap); }


#define PhaseOffset float3(PhaseOffsetR,PhaseOffsetG,PhaseOffsetB)
#define CosineFactor float3(CosineFactorR,CosineFactorG,CosineFactorB)
#define TanhFactor float3(TanhFactorR,TanhFactorG,TanhFactorB)
#define HeightParam float3(HeightParamA,HeightParamB,HeightParamC)
#define ParallaxFactor float3(ParallaxFactorA,ParallaxFactorB,ParallaxFactorC)


#define GAMMA_VALUE 2.2

#define SELLMEIER_COEFFICIENTS(ior,c) CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))))

#define SELLMEIER_THIN_FILM_PROPERTY(ior,thicknessNM,c) CreateThinFilmProperties(thicknessNM,SELLMEIER_COEFFICIENTS(ior,c));

static const float SCREEN_WIDTH_M = .1; // Approx physical width of Samsung Ultra screen
static const float FRINGE_SCALE = 3088.0 / 20.0; // 20 fringes across 3088 pixels

// How much the R, G, B components of the input color can shift their respective wavelengths
#define WAVELENGTH_SENSITIVITY_R 60.0f
#define WAVELENGTH_SENSITIVITY_G 40.0f
#define WAVELENGTH_SENSITIVITY_B 35.0f

// Minimum separation to maintain some distinctness for grayscale colors
#define MIN_SPECTRAL_SEPARATION_NM f08

static float3 Diffuse = ZERO3;
static float Depth = EPSILON;
static float Height = EPSILON;
static float2 OffsetUV = ZERO2;
static float2 InputUV = ZERO2;



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
		float DepthScale0;

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
		float f01;
		float f02;

		float f03;
		float f04;
		float f05;
		float f06;

		float f07;
		float f08;
		float f09;
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


struct PS_INPUT
{
    float4 Position : SV_Position;
    float2 uv : UV0;
    float3 VSViewDir : UV1;
    float4 Color : COLOR0;
};
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


struct C3
{
    float3 real;
    float3 imag;
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
// Struct for Thin-Film Properties
struct ThinFilmProperties
{
    float filmThicknessNM; // Thickness of each thin film layer (meters)
    SellmeierCoefficients filmEta_coeffs; // Refractive index coefficients for thin film
};


inline float3 nmSqToUmSq(float3 nmSq)
{
    return nmSq * 1e-6;
}


struct MaterialProperties
{
    SellmeierCoefficientsBC coeff;
    float3 k;
    float thicknessNM;
    float3 absorptionM;
    C3 wavelengthsNM;
    float3 transmissionCoefficient;
};

struct MaterialSellmeier
{
    SellmeierCoefficients coeff;
    
    float3 albedo;
    float3 etaR; // Real refractive index
    float3 etaI; // Imaginary refractive index (extinction coefficient)
    float3 absorptionCoefficient;
    float3 scatteringCoefficient;
    float roughness;
    float metallic;
    float3 metallicReflectance;
    float thicknessNM;
    float nSurrounding;
    float coherenceLengthM;
    float3 opticalAxis;
    float3 dispersionCoefficientsNm2[3];
};

// Struct for Anisotropic Roughness Parameters
struct AnisotropicRoughness
{
    float alphaX; // Roughness along X-axis
    float alphaY; // Roughness along Y-axis
};

struct LightingComplex
{
    // Configuration Parameters
    float Config_Saturation; // Saturation adjustment for final color output
    float Config_Gamma; // Gamma correction factor
    float Config_Exposure; // Exposure level for tone mapping
    bool invertDepth; // Flag to invert depth values
    bool useProjectedDepth; // Flag to use projected depth scaling
    float fDepthScale; // Depth scaling factor
    float coherenceLengthM;
    // Geometry and Depth
    float depth; // Depth value of the pixel
    float3 pixelPos; // 3D position of the pixel
    float3 lightPos; // Position of the light source
    float3 viewPos; // Position of the viewer

    // Normals and TBN Matrix
    float3 normal; // Surface normal at the pixel
    //float3x3 TBNf; // Tangent, Bitangent, Normal matrix for normal mapping

    // Direction Vectors
    float3 viewDir; // Direction from pixel to viewer
    float3 lightDir; // Direction from pixel to light
    float3 halfDir; // Half-vector between viewDir and lightDir

    // Dot Products
    float NdotV3; // Dot product of normal and viewDir
    float NdotL3; // Dot product of normal and lightDir
    float VdotH; // Dot product of viewDir and halfDir
    float HdotN; // Dot product of halfDir and normal
    float HdotL; // Dot product of halfDir and lightDir
    float LdotA;
    // Material Properties
    MaterialSellmeier material; // Material properties (refractive index, thickness, etc.)
    float3 albedo; // Base color of the material
    float3 albedoWavelengthsNM; // Wavelengths corresponding to albedo (in nm)
    float3 albedoWavelengthsM; // Wavelengths corresponding to albedo (in meters)
    
    float3 iridescenceO;
    float3 iridescenceE;
    float3 opticalAxis;
    float3 nSurrounding;
    float3 eta_ratio;
    
    float3 k_ratio;
    float3 cosTheta;
    C3 F_complex;
    
    float3 dispersionFactor;
    float3 n_o;
      
    C3 cosThetaOptic;
    
    
    float3 n_e_effective;
    float3 etaR_wavelength;
    float3 etaI_wavelength;
    C3 cosThetaTR0;
    C3 R0;
    C3 cosThetaTR1;
    C3 R1;
 
    C3 qwave;
    C3 phaseShift_o;
    C3 phaseShift_e;
    
    // Blend phase shifts based on the depth-dependent polarization.
    C3 phaseShift;
    C3 D_complex;
    C3 G_complex;
    
    C3 spec_complex;
    float3 complexSpecular;
    float metallicReflectance;

    
    float3 sheen;
    float3 advancedSheen;
    float3 clearCoatSpecular;
    float3 specularWithSheen;
    
    
    float2 microfacetRoughness;
    float3 ggxDistributionTerm;
    float3 smithGeometryTerm;
    float3 microfacetDenominator;
    float3 microfacetSpecularTerm;
    float3 n_real;
    
    float3 F0;
    
    C3 refPol;
    C3 compositeSpecular;
    C3 specularContribution;

    C3 reflectance;
    C3 filmReflectedPolarization;
    C3 transmittance;
    C3 transmittanceCoherence;
    
    C3 diffuseReflectance;
    C3 diffuseTransmittance;
    C3 eeDiffuse;
    C3 eeSpecular;
    C3 eeInterference;
    // Lighting Terms
    float3 ggxDistribution; // GGX distribution term for specular lighting
    float3 cookTorrenceSpecular; // Cook-Torrance specular term

    // Wave Interference
    C3 waveInterference; // Complex wave interference term for holographic effects

    // Total Lighting Output
    float3 totalLighting[3]; // Final lighting output (per-channel or per-light)
};


inline float2 GetSz(Texture2D<float> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return sz;
}
inline float2 GetSz(Texture2D<float3> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return sz;
}
inline float2 GetSz(Texture2D<float4> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return sz;
}
inline float2 GetOosz(Texture2D<float4> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return 1.0 / sz;
}
inline float2 GetOosz(Texture2D<float3> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return 1.0 / sz;
}
inline float2 GetOosz(Texture2D<float> tex)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    return 1.0 / sz;
}


float quinticSmooth(float x)
{
    x = saturate(x);
    return x * x * x * (x * (x * 6 - 15) + 10);
}

float aureateStep(float x, float inflect)
{
    x = saturate(x);
    float k = x * x * (3 - 2 * x); // classic smoothstep
    float q = quinticSmooth(x);
    return lerp(k, q, inflect);
}

float logisticStep(float x, float steepness)
{
    x = saturate(x);
    float ev = exp(-steepness * (x - 0.5));
    return 1.0 / (1.0 + ev);
}

float escherStep(float x, int iterations)
{
    float r = x;
    [unroll]
    for(int i = 0; i < iterations; i++)
    {
        r = quinticSmooth(r);
        r = frac(r * 1.61803398875);
    }
    return r;
}

float catenaryStep(float x)
{
    x = saturate(x);
    float t = (x * 2 - 1);
    return (cosh(t) - 1) / (cosh(1) - 1);
}

float bezierStep(float x, float c1, float c2)
{
    x = saturate(x);
    float u = 1 - x;
    return
        3 * u * u * x * c1 +
        3 * u * x * x * c2 +
        x * x * x;
}

float voronoiHash(float2 p)
{
    return frac(sin(dot(p, float2(12.9898, 78.233))) * 43758.5453);
}

float voronoiStep(float2 uv, float x)
{
    float2 g = floor(uv);
    float2 f = frac(uv);
    float d = 1e9;

    [unroll]
    for(int j = -1; j <= 1; j++)
    {
        [unroll]
        for(int i = -1; i <= 1; i++)
        {
            float2 o = float2(i, j);
            float2 p = frac(voronoiHash(g + o));
            d = min(d, length(f - o - p));
        }
    }

    return quinticSmooth(saturate(x - d));
}



float2 quinticSmooth(float2 x)
{
    x = saturate(x);
    return x * x * x * (x * (x * 6 - 15) + 10);
}

float2 aureateStep(float2 x, float2 inflect)
{
    x = saturate(x);
    float2 k = x * x * (3 - 2 * x); // classic smoothstep
    float2 q = quinticSmooth(x);
    return lerp(k, q, inflect);
}

float2 logisticStep(float2 x, float2 steepness)
{
    x = saturate(x);
    float2 ev = exp(-steepness * (x - 0.5));
    return 1.0 / (1.0 + ev);
}

float2 escherStep(float2 x, int iterations)
{
    float2 r = x;
    [loop]
    for(int i = 0; i < iterations; i++)
    {
        r = quinticSmooth(r);
        r = frac(r * 1.61803398875);
    }
    return r;
}

float2 catenaryStep(float2 x)
{
    x = saturate(x);
    float2 t = (x * 2 - 1);
    return (cosh(t) - 1) / (cosh(1) - 1);
}

float2 bezierStep(float2 x, float2 c1, float2 c2)
{
    x = saturate(x);
    float2 u = 1 - x;
    return
        3 * u * u * x * c1 +
        3 * u * x * x * c2 +
        x * x * x;
}

float2 voronoiHash2(float2 p)
{
    return normalize(float2(frac(sin(dot(p, float2(127.1, 311.7))) * 43758.5453),
            0.5 * frac(sin(dot(p * 2.0, float2(73.3, 241.9))) * 31415.9265)));
}

float2 voronoiStep2(float2 uv, float x)
{
    float2 g = floor(uv);
    float2 f = frac(uv);
    float d = 1e9;

    [unroll]
    for(int j = -1; j <= 1; j++)
    {
        [unroll]
        for(int i = -1; i <= 1; i++)
        {
            float2 o = float2(i, j);
            float2 p = frac(voronoiHash2(g + o));
            d = min(d, length(f - o - p));
        }
    }
    // ViewConstants + DepthTex from previous code...
    return quinticSmooth(saturate(x - d));
}


inline float SampleDepth(Texture2D<float> depthMap, float2 uv)
{
    return 1.0 - clamp(depthMap.Sample(sampleTypeMirror, uv), EPSILON, 1.0-EPSILON);
}

float3 noise3(Texture2D<float3> noiseMap,
	float3 n,
    float scalarZ = 1
)
{
   
	// Calculate sample coordinates with varying frequency for each noise layer
    float2 sampleCoord1 = (n.xy / n.z * scalarZ);
    float2 sampleCoord2 = (n.xy / n.z * scalarZ * scalarZ);
    float2 sampleCoord3 = (n.xy / n.z * scalarZ * scalarZ * scalarZ);

	// Sample the noise textures at the calculated coordinates
    float3 v = normalize(noiseMap.SampleLevel(sampleTypeLinear, sampleCoord1, 0).xyz + EPSILON3);
    float3 v2 = normalize(noiseMap2.SampleLevel(sampleTypeLinear, sampleCoord2, 0).xyz + EPSILON3);
    float3 v3 = normalize(noiseMap3.SampleLevel(sampleTypeLinear, sampleCoord3, 0).xyz + EPSILON3);
    return clamp(normalize(v + v2 + v3) * TWO3 - ONE3, -1, 1);
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


inline float3 noise3_01(Texture2D<float3> noiseMap, float3 uv)
{
    return saturate(noise3(noiseMap, uv) * .5 + .5);
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


// Utility Functions
inline float3 safeNormalize(float3 v)
{
    return normalize(v + EPSILON3);
}

inline C3 ComplexCreate(float3 r, float3 i)
{
    C3 c;
    c.real = r;
    c.imag = i;
    return c;
}

float3 ComplexMagnitudeSquared(C3 a)
{
    return (a.real * a.real + a.imag * a.imag);
}

inline C3 ComplexMax(C3 a, C3 b)
{
    return CV(max(a.real, b.real), max(a.imag, b.imag));
}
inline C3 ComplexMin(C3 a, C3 b)
{
    return CV(min(a.real, b.real), min(a.imag, b.imag));
}

inline C3 ComplexDot(C3 a, C3 b)
{
    float3 realPart = dot(a.real, b.real) + dot(a.imag, b.imag);
    float3 imagPart = dot(a.real, b.imag) - dot(a.imag, b.real);
    return CV(realPart, imagPart);
}

inline C3 ComplexAdd(C3 a, C3 b)
{
    return CV(a.real + b.real, a.imag + b.imag);
}

inline C3 ComplexSub(C3 a, C3 b)
{
    return CV(a.real - b.real, a.imag - b.imag);
}

inline C3 ComplexMul(C3 a, C3 b)
{
    return CV(a.real * b.real - a.imag * b.imag, a.real * b.imag + a.imag * b.real);
}

inline C3 ComplexDiv(C3 a, C3 b)
{
    float3 denom = max(abs(b.real * b.real + b.imag * b.imag), EPSILON3);
    return CV((a.real * b.real + a.imag * b.imag) / denom, (a.imag * b.real - a.real * b.imag) / denom);
}

inline float3 ComplexMagnitude(C3 c)
{
    return sqrt(c.real * c.real + c.imag * c.imag);
}
inline C3 ComplexSaturatef(float3 c)
{
    return CV0(saturate(c));
}
inline C3 ComplexSaturate(C3 c)
{
    return CV(saturate(c.real), saturate(c.imag));
}


inline C3 ComplexNormalize(C3 v)
{
    C3 mag = CV0(CMag(v)+EPSILON3); // Compute magnitude
    return CDiv(v, mag); // Normalize with epsilon to avoid division by zero
}

inline C3 ComplexSqrt(C3 z)
{
    float3 magnitude = CMag(z);
    float3 realPart = sqrt(0.5 * (magnitude + z.real));
    float3 imagPart = sign(z.imag) * sqrt(0.5 * (magnitude - z.real));
    return CV(realPart, imagPart);
}
inline C3 ComplexSin(C3 c)
{
    return CV(sin(c.real) * cosh(c.imag), cos(c.real) * sinh(c.imag));
}

inline C3 ComplexCos(C3 c)
{
    return CV(cos(c.real) * cosh(c.imag), -sin(c.real) * sinh(c.imag));
}

inline C3 ComplexAbs(C3 a)
{
    return CV(abs(a.real), abs(a.imag));
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
// Function to rotate a float3 vector around an arbitrary axis using Rodrigues` rotation formula
inline float3 RotateAxisAngle(float3 v, float3 axis, float angle)
{
    axis = (axis + EPSILON3);
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

inline float3 RotateAroundZ(float3 v, float angle)
{
    return RotateAxisAngle(float4(v, 0), float3(0, 0, 1), fmod(angle, TWOPI)).xyz;
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

float2 calcSlope(Texture2D<float> depthMap, float2 uv)
{
    // Get texture size and inverse size

    float2 sz = GetSz(depthMap);

    const float2 oosz = 1.0 / sz;

    // Central differences with 1-pixel offsets

    float left = SampleDepth(depthMap, uv - float2(oosz.x, 0.0));

    float right = SampleDepth(depthMap, uv + float2(oosz.x, 0.0));

    float up = SampleDepth(depthMap, uv - float2(0.0, oosz.y));

    float down = SampleDepth(depthMap, uv + float2(0.0, oosz.y));

    float dX = (right - left) * 0.5 / oosz.x;

    float dY = (down - up) * 0.5 / oosz.y;

    return float2(dX, dY);
}


inline float3 dot3(float3 a, float3 b)
{
    return float3(dot(a.x, b.x), dot(a.y, b.y), dot(a.z, b.z));
}

float3 SampleGray(Texture2D<float> tex, float2 uv) {
    float3 c = ONE3 * clampEpsilon(tex.Sample(samplerState, uv));
    return dot3(c, float3(0.299, 0.587, 0.114));
}

float3 SampleGray(Texture2D<float3> tex, float2 uv) {
    float3 c = tex.Sample(samplerState, uv).rgb;
    return dot3(c, float3(0.299, 0.587, 0.114));
}

float3 SampleGray(Texture2D<float4> tex, float2 uv) {
    float3 c = tex.Sample(samplerState, uv).rgb;
    return dot3(c, float3(0.299, 0.587, 0.114));
}

float3x3 OpticalFlow(Texture2D<float3> tex0,Texture2D<float3> tex1, float2 uv) {
    float2 o = 1.0 / GetSz(tex0);

    float3 g00 = SampleGray(tex0, uv + float2(-o.x, -o.y));
    float3 g10 = SampleGray(tex0, uv + float2( 0.0, -o.y));
    float3 g20 = SampleGray(tex0, uv + float2( o.x, -o.y));
    float3 g01 = SampleGray(tex0, uv + float2(-o.x,  0.0));
    float3 g21 = SampleGray(tex0, uv + float2( o.x,  0.0));
    float3 g02 = SampleGray(tex0, uv + float2(-o.x,  o.y));
    float3 g12 = SampleGray(tex0, uv + float2( 0.0,  o.y));
    float3 g22 = SampleGray(tex0, uv + float2( o.x,  o.y));

    float2 g[3];
    
    g[0] = float2(
        (-g00[0] + g20[0]) + (-2.0*g01[0] + 2.0*g21[0]) + (-g02[0] + g22[0]),
        (-g00[0] - 2.0*g10[0] - g20[0]) + (g02[0] + 2.0*g12[0] + g22[0])
    );
    g[1] = float2(
        (-g00[1] + g20[1]) + (-2.0*g01[1] + 2.0*g21[1]) + (-g02[1] + g22[1]),
        (-g00[1] - 2.0*g10[1] - g20[1]) + (g02[1] + 2.0*g12[1] + g22[1])
    );
    g[2] = float2(
        (-g00[2] + g20[2]) + (-2.0*g01[2] + 2.0*g21[2]) + (-g02[2] + g22[2]),
        (-g00[2] - 2.0*g10[2] - g20[2]) + (g02[2] + 2.0*g12[2] + g22[2])
    );
    
    // Temporal gradient It
    const float3 I0 = SampleGray(tex0, uv);
    const float3 I1 = SampleGray(tex1, uv);
    const float3 It = I1 - I0;

    float3x3 ret;
    ret[0][0] = g[0].x;
    ret[1][0] = g[0].y;
    ret[2][0] = It.x;

    ret[0][1] = g[1].x;
    ret[1][1] = g[1].y;
    ret[2][1] = It.y;
    
    ret[0][2] = g[2].x;
    ret[1][2] = g[2].y;
    ret[2][2] = It.z;

    return ret;
}

float3x3 OpticalFlow(Texture2D<float4> tex0,Texture2D<float3> tex1, float2 uv) {
    float2 o = 1.0 / GetSz(tex0);

    float3 g00 = SampleGray(tex0, uv + float2(-o.x, -o.y));
    float3 g10 = SampleGray(tex0, uv + float2( 0.0, -o.y));
    float3 g20 = SampleGray(tex0, uv + float2( o.x, -o.y));
    float3 g01 = SampleGray(tex0, uv + float2(-o.x,  0.0));
    float3 g21 = SampleGray(tex0, uv + float2( o.x,  0.0));
    float3 g02 = SampleGray(tex0, uv + float2(-o.x,  o.y));
    float3 g12 = SampleGray(tex0, uv + float2( 0.0,  o.y));
    float3 g22 = SampleGray(tex0, uv + float2( o.x,  o.y));

    float2 g[3];
    
    g[0] = float2(
        (-g00[0] + g20[0]) + (-2.0*g01[0] + 2.0*g21[0]) + (-g02[0] + g22[0]),
        (-g00[0] - 2.0*g10[0] - g20[0]) + (g02[0] + 2.0*g12[0] + g22[0])
    );
    g[1] = float2(
        (-g00[1] + g20[1]) + (-2.0*g01[1] + 2.0*g21[1]) + (-g02[1] + g22[1]),
        (-g00[1] - 2.0*g10[1] - g20[1]) + (g02[1] + 2.0*g12[1] + g22[1])
    );
    g[2] = float2(
        (-g00[2] + g20[2]) + (-2.0*g01[2] + 2.0*g21[2]) + (-g02[2] + g22[2]),
        (-g00[2] - 2.0*g10[2] - g20[2]) + (g02[2] + 2.0*g12[2] + g22[2])
    );
    
    // Temporal gradient It
    const float3 I0 = SampleGray(tex0, uv);
    const float3 I1 = SampleGray(tex1, uv);
    const float3 It = I1 - I0;

    float3x3 ret;
    ret[0][0] = g[0].x;
    ret[1][0] = g[0].y;
    ret[2][0] = It.x;

    ret[0][1] = g[1].x;
    ret[1][1] = g[1].y;
    ret[2][1] = It.y;
    
    ret[0][2] = g[2].x;
    ret[1][2] = g[2].y;
    ret[2][2] = It.z;

    return ret;
}


float3x3 OpticalFlow(Texture2D<float> tex0,Texture2D<float> tex1, float2 uv) {
    float2 o = 1.0 / GetSz(tex0);

    float3 g00 = SampleDepth(tex0, uv + float2(-o.x, -o.y));
    float3 g10 = SampleDepth(tex0, uv + float2( 0.0, -o.y));
    float3 g20 = SampleDepth(tex0, uv + float2( o.x, -o.y));
    float3 g01 = SampleDepth(tex0, uv + float2(-o.x,  0.0));
    float3 g21 = SampleDepth(tex0, uv + float2( o.x,  0.0));
    float3 g02 = SampleDepth(tex0, uv + float2(-o.x,  o.y));
    float3 g12 = SampleDepth(tex0, uv + float2( 0.0,  o.y));
    float3 g22 = SampleDepth(tex0, uv + float2( o.x,  o.y));

    float2 g[3];
    
    g[0] = float2(
        (-g00[0] + g20[0]) + (-2.0*g01[0] + 2.0*g21[0]) + (-g02[0] + g22[0]),
        (-g00[0] - 2.0*g10[0] - g20[0]) + (g02[0] + 2.0*g12[0] + g22[0])
    );
    g[1] = float2(
        (-g00[1] + g20[1]) + (-2.0*g01[1] + 2.0*g21[1]) + (-g02[1] + g22[1]),
        (-g00[1] - 2.0*g10[1] - g20[1]) + (g02[1] + 2.0*g12[1] + g22[1])
    );
    g[2] = float2(
        (-g00[2] + g20[2]) + (-2.0*g01[2] + 2.0*g21[2]) + (-g02[2] + g22[2]),
        (-g00[2] - 2.0*g10[2] - g20[2]) + (g02[2] + 2.0*g12[2] + g22[2])
    );
    
    // Temporal gradient It
    const float3 I0 = SampleGray(tex0, uv);
    const float3 I1 = SampleGray(tex1, uv);
    const float3 It = I1 - I0;

    float3x3 ret;
    ret[0][0] = g[0].x;
    ret[1][0] = g[0].y;
    ret[2][0] = It.x;

    ret[0][1] = g[1].x;
    ret[1][1] = g[1].y;
    ret[2][1] = It.y;
    
    ret[0][2] = g[2].x;
    ret[1][2] = g[2].y;
    ret[2][2] = It.z;

    return ret;
}


float2 calcSlopeFast(Texture2D<float> depthMap, float2 uv)
{
    const float2 sz = GetSz(depthMap);
    const float2 oosz = 1.0 / sz; // inverse texture size (size of one pixel in UV space)

    // Sample 3x3 neighborhood
    float z[3][3];
    
    z[0][0] = SampleDepth(depthMap, uv + float2(-oosz.x,-oosz.y));
    z[1][0] = SampleDepth(depthMap, uv + float2(0.0, -oosz.y));
    z[2][0] = SampleDepth(depthMap, uv + float2(oosz.x, -oosz.y));
    
    z[0][1] = SampleDepth(depthMap, uv + float2(-oosz.x,0.0));
    z[1][1] = SampleDepth(depthMap, uv + float2(0.0, 0.0));
    z[2][1] = SampleDepth(depthMap, uv + float2(oosz.x, 0.0));
    
    z[0][2] = SampleDepth(depthMap, uv + float2(-oosz.x,oosz.y));
    z[1][2] = SampleDepth(depthMap, uv + float2(0.0, oosz.y));
    z[2][2] = SampleDepth(depthMap, uv + float2(oosz.x, oosz.y));

    
    // Sobel filter for gradients (dX and dY)
    // The coefficients (1, 2, 1) are standard for a 3x3 Sobel filter.
    float dX = (z[0][2] + 2.0 * z[1][2] + z[2][2]) - (z[0][0] + 2.0 * z[1][0] + z[2][0]); // Sum of right column - Sum of left column
    float dY = (z[2][0] + 2.0 * z[2][1] + z[2][2]) - (z[0][0] + 2.0 * z[0][1] + z[0][2]); // Sum of bottom row - Sum of top row

    dX *= 0.5 / oosz.x;
    dY *= 0.5 / oosz.y;

    return float2(dX, dY);
}


float3 GradientBlend(Texture2D<float3> src, float2 uv) {
    float2 o = GetOosz(src);

    // Sobel on source
    float3 s00 = src.SampleLevel(samplerState, uv + float2(-o.x, -o.y), 0.0);
    float3 s10 = src.SampleLevel(samplerState, uv + float2( 0.0, -o.y), 0.0);
    float3 s20 = src.SampleLevel(samplerState, uv + float2( o.x, -o.y), 0.0);
    float3 s01 = src.SampleLevel(samplerState, uv + float2(-o.x,  0.0), 0.0);
    float3 s21 = src.SampleLevel(samplerState, uv + float2( o.x,  0.0), 0.0);
    float3 s02 = src.SampleLevel(samplerState, uv + float2(-o.x,  o.y), 0.0);
    float3 s12 = src.SampleLevel(samplerState, uv + float2( 0.0,  o.y), 0.0);
    float3 s22 = src.SampleLevel(samplerState, uv + float2( o.x,  o.y), 0.0);

    float3 gx = (-1*s00 + 1*s20) + (-2*s01 + 2*s21) + (-1*s02 + 1*s22);
    float3 gy = (-1*s00 - 2*s10 - 1*s20) + (1*s02 + 2*s12 + 1*s22);

    // Here we just visualize gradient magnitude; in a real Poisson solver
    // you’d feed gx, gy into a reconstruction pass.
    float3 mag = sqrt(gx*gx + gy*gy);
    return mag * 0.25;
}


float2 calcSlope2(Texture2D<float> depthMap, float2 uv)
{
    // Get texture size and inverse size
    float2 sz = GetSz(depthMap);
    const float2 oosz = 1.0 / sz; // inverse texture size (size of one pixel in UV space)

    // Offsets for the 5x5 kernel
    const int kernelRadius = 2;
    const int kernelSize = kernelRadius * 2 + 1; // This will be 5

    // Initialize accumulators for the normal equations A * x = b
    // A is a 6x6 symmetric matrix, b is a 6-element vector.
    // Initialized to zero automatically by the compiler or explicit initialization.
    float A[6][6] =
    {
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0 }
    };
    float b[6] = { 0, 0, 0, 0, 0, 0 };

    // Coordinate offsets for the 5x5 kernel centered at 0
    const float offsets[5] = { -2.0, -1.0, 0.0, 1.0, 2.0 };

    // Iterate over the 5x5 neighborhood to build the normal equations
    [loop]
    for (int i_idx = 0; i_idx < kernelSize; i_idx++)
    {
        const float y_offset = offsets[i_idx];
        [loop]
        for (int j_idx = 0; j_idx < kernelSize; j_idx++)
        {
            const float x_offset = offsets[j_idx];

            // Compute UV coordinates for the current sample point
            float2 offsetUV = uv + float2(x_offset, y_offset) * oosz;

            // Handle edge cases by clamping UV coordinates
            // Clamp to [0.0, 1.0] to prevent sampling outside the texture.
            offsetUV = clamp(offsetUV, 0.0, 1.0);

            // Sample the height map ( depth for convention where 0 is far, 1 is near)
            float z_val = SampleDepth(depthMap, offsetUV);

            // Basis functions for a quadratic surface: z = ax^2 + by^2 + cxy + dx + ey + f
            // The coefficients we are solving for are stored in x: x[0]=a, x[1]=b, x[2]=c, x[3]=d, x[4]=e, x[5]=f
            float x_sq = x_offset * x_offset;
            float y_sq = y_offset * y_offset;
            float xy = x_offset * y_offset;
            
            float basis_vector[6] = { x_sq, y_sq, xy, x_offset, y_offset, 1.0 };

            // Build the normal equations (A * x = b)
            // A[u][v] += basis_vector[u] * basis_vector[v]
            // b[u] += basis_vector[u] * z_val
            [loop]
            for (int u = 0; u < 6; u++)
            {
                b[u] += basis_vector[u] * z_val;
                [loop]
                for (int v = u; v < 6; v++) // Only fill upper triangle due to symmetry
                {
                    A[u][v] += basis_vector[u] * basis_vector[v];
                }
            }
        }
    }

    // Add a small regularization term to the diagonal of A to improve numerical stability.
    // This is often called "damping" or "Tikhonov regularization".
    // 1e-6 is a reasonable small value.
    [unroll(6)]
    for (int i = 0; i < 6; i++)
    {
        A[i][i] += 1e-6;
    }

    // Since A is symmetric, fill the lower triangle from the upper triangle
    [unroll(5)]
    for (int row = 1; row < 6; row++)
    {
        [loop]
        for (int col = 0; col < row; col++)
        {
            A[row][col] = A[col][row];
        }
    }

    // Solve the normal equations using Gaussian elimination (forward elimination)
    float x[6] = { 0, 0, 0, 0, 0, 0 }; // Solution vector for a, b, c, d, e, f
    bool success = true;

    [unroll(6)]
    for (int i_elim = 0; i_elim < 6; i_elim++)
    {
        // Find the pivot element
        float pivot = A[i_elim][i_elim];
        if (abs(pivot) < 1e-9) // Use a slightly larger epsilon for pivot check
        {
            success = false;
            break; // Break if a pivot is too small (matrix is singular or ill-conditioned)
        }

        float invPivot = 1.0 / pivot;
        [loop]
        for (int j_norm = i_elim; j_norm < 6; j_norm++)
        {
            A[i_elim][j_norm] *= invPivot;
        }
        b[i_elim] *= invPivot;

        // Eliminate elements below the pivot
        [loop]
        for (int k_row = i_elim + 1; k_row < 6; k_row++)
        {
            float factor = A[k_row][i_elim]; // Factor to multiply the pivot row by
            
            [loop]
            for (int j_sub = i_elim; j_sub < 6; j_sub++)
            {
                A[k_row][j_sub] -= factor * A[i_elim][j_sub];
            }
            
            b[k_row] -= factor * b[i_elim];
        }
    }

    // Back substitution to solve for x
    if (success)
    {
        [loop]
        for (int i_sub = 5; i_sub >= 0; i_sub--)
        {
            x[i_sub] = b[i_sub];
            if (i_sub < 5)
            {
                [loop]
                for (int j_sub_inner = i_sub + 1; j_sub_inner < 6; j_sub_inner++)
                {
                    x[i_sub] -= A[i_sub][j_sub_inner] * x[j_sub_inner];
                }
            }
        }
    }
    else
    {
        // If Gaussian elimination failed, set x to all zeros.
        // This means we couldn't fit a surface, so the slope will be zero.
        [unroll(6)]
        for (int i_fail = 0; i_fail < 6; i_fail++)
        {
            x[i_fail] = 0.0;
        }
    }

    // The partial derivatives (slopes) of z = ax^2 + by^2 + cxy + dx + ey + f are:
    // dZ/dX = 2ax + cy + d
    // dZ/dY = 2by + cx + e
    // At the center of the kernel (x=0, y=0), these simplify to:
    // dZ/dX = d  (which is x[3])
    // dZ/dY = e  (which is x[4])
    float dX = x[3]; // Coefficient 'd'
    float dY = x[4]; // Coefficient 'e'
    
    return float2(dX, dY);
}



float noiseSimple2(float2 uv, float t, float2 scale = float2(20.0, 20.0))
{
    return sin(scale.x * uv.x + t) + cos(scale.y * uv.y + t);
}

float noiseSimple3(float3 uv, float t, float3 scale = float3(20.0,20.0,20.0))
{
    return sin(scale.x * uv.x + t) + cos(scale.y * uv.y + t) + cos(scale.z * uv.z + t);
}

float3x3 CalcTBN_ScreenDerivative(float3 N, float3 worldPos, float2 uv)
{
    float3 dp1 = ddx(worldPos);
    float3 dp2 = ddy(worldPos);
    float2 duv1 = ddx(uv);
    float2 duv2 = ddy(uv);

    float3 dp2perp = cross(dp2, N);
    float3 dp1perp = cross(N, dp1);
    float3 T = dp2perp * duv1.x + dp1perp * duv2.x;
    float3 B = dp2perp * duv1.y + dp1perp * duv2.y;

    float invMax = rsqrt(max(dot(T,T), dot(B,B)));
    return float3x3(T * invMax, B * invMax, N);
}
//Duff
float3x3 CalcTBN(float3 N)
{
    float sign_ = N.z >= 0.0 ? 1.0 : -1.0;
    float a = -1.0 / (sign_ + N.z);
    float b = N.x * N.y * a;
    float3 T = float3(1.0 + sign_ * N.x * N.x * a,
                      sign_ * b,
                     -sign_ * N.x);
    float3 B = float3(b,
                      sign_ + N.y * N.y * a,
                     -N.y);
    return float3x3(T, B, N);
}
float3 getTangent(float3x3 tbn, float3 normal)
{
    return normalize(tbn[0] - normal * dot(tbn[0], normal));
}
float3 getBitangent(float3x3 tbn, float3 normal)
{
    float3 T = getTangent(tbn, normal);
    return normalize(cross(normal, T));
}
float3 calcNormal(Texture2D<float> depthMap, float2 uv)
{
    float depth = clampEpsilon(1.0 - depthMap.SampleLevel(linearSampler,uv,0));
    float2 oosz = GetOosz(depthMap);
    float3 dx = float3(oosz.x, 0, ddx(depth));
    float3 dy = float3(0, oosz.y, ddy(depth));
    float3 normal = normalize(EPSILON3+cross(dx,dy));
    float3x3 tbn = CalcTBN(normal);

    float3 V = normalize(ViewDir);
    float k = aureateStep(saturate(dot(normal, V)), 0.8);
    float3 Nt = normalize(lerp(normal, reflect(normal, V), k));
    return normalize(Nt);
}
float3 calcNormal(Texture2D<float> depthMap, float2 uv, out float3x3 tbn)
{
    float depth = clampEpsilon(1.0 - depthMap.SampleLevel(linearSampler,uv,0));
    float2 oosz = GetOosz(depthMap);
    float3 dx = float3(oosz.x, 0, ddx(depth));
    float3 dy = float3(0, oosz.y, ddy(depth));
    float3 normal = normalize(EPSILON3+cross(dx,dy));
    tbn = CalcTBN(normal);

    return normal;
}
float3 getNormal(Texture2D<float3> normalMap, float2 uv, out float3x3 tbn)
{
    float3 normal = normalize(clampEpsilon(normalMap.SampleLevel(sampleTypeLinear, uv, 0)));

    tbn = CalcTBN(normal);
    return normal;
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


float3 RGBToWavelengthsNM(float3 rgb)
{
    return lerp(MIN_WAVELENGTHS, MAX_WAVELENGTHS, saturate(rgb));
}

float3 RGBToWavelengthsM(float3 rgb)
{
    return RGBToWavelengthsNM(rgb) * 1e-9;
}

float3 WavelengthsToRGB(float3 wavelengthsNM)
{
    return (clamp(wavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS) - MIN_WAVELENGTHS) / WAVELENGTH_RANGES;
}


inline C3 dot3(C3 a)
{
    return CV(dot3(a.real, a.real), dot3(a.imag, a.imag));
}

inline float3 RGBToLuminance(float3 color)
{
    return dot3(color, float3(0.299, 0.587, 0.114));
}

inline float3 RGBToBrightness(float3 color)
{
    return dot3(color, float3(0.2126, 0.7152, 0.0722));
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


C3 SnellsLaw(C3 eta1, C3 eta2, C3 sinThetaI)
{
    return CDiv(CMul(eta1, sinThetaI), eta2);
}

inline C3 ComplexExp(C3 z)
{
    float3 expReal = exp(z.real);
    return CV(expReal * cos(z.imag), expReal * sin(z.imag));
}

inline C3 ComplexConjugate(C3 z)
{
    return CV(z.real, -z.imag);
}

inline C3 ComplexLerp(C3 a, C3 b, C3 val)
{
    return CV(lerp(a.real, b.real, val.real), lerp(a.imag, b.imag, val.imag));
}

inline C3 ComplexClamp(C3 a, float3 minVal, float3 maxVal)
{
    return CV(clamp(a.real, minVal, maxVal), clamp(a.imag, minVal, maxVal));
}

inline C3 ClampRefractiveIndex(C3 ri)
{
    return ComplexClamp(ri, ONE3, TWO3);
}

C3 ComplexLog(C3 z)
{
    float3 mag = ComplexMagnitude(z);
    float3 angle = atan2(z.imag, z.real);
    return CV(log(mag), angle);
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



// Computes a^b for a complex exponent b using: a^b = exp(b * ln(a))
C3 ComplexPow(C3 a, C3 b)
{
    C3 lnA = ComplexLog(a);
    C3 mul = CMul(b, lnA);
    return CExp(mul);
}

C3 FresnelReflectanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out C3 cosThetaT)
{
    //--------------------------------------------------------------------------
    // 1. Wrap and Clamp the Incident Angle
    //--------------------------------------------------------------------------

    // Clamp the input cosine to [-1, 1] and wrap as a C3.
    C3 cI = CV0(clamp(cosThetaI, -ONE3h, ONE3h));
    
    //--------------------------------------------------------------------------
    // 2. Wrap the Refractive Indices
    //--------------------------------------------------------------------------

    // Ensure the refractive indices are non-negative.
    C3 Cn1 = CV0(clamp(n1, ONE3h, TWO3h));
    C3 Cn2 = CV0(clamp(n2, ONE3h, TWO3h));

    //--------------------------------------------------------------------------
    // 3. Compute the Sine of the Incident Angle Using Complex Math
    //--------------------------------------------------------------------------

    // sin(theta_i) = sqrt( max(1 - cosThetaI^2, 0) )
    C3 oneC = CV0(ONE3h);
    C3 cI2 = CMul(cI, cI);
    C3 diff = CSub(oneC, cI2);
    C3 sI = CSqrt(diff);

    //--------------------------------------------------------------------------
    // 4. Compute the Sine of the Transmitted Angle
    //--------------------------------------------------------------------------

    // ratio = n1 / n2; then sT = ratio * sI
    C3 ratio = CDiv(Cn1, Cn2);
    C3 sT = CMul(ratio, sI);

    // For transmitted cosine, we need to clamp the sine value to [0, 1] and then compute:
    // cosThetaT = sqrt( max(1 - min(sT, 1)^2, 0) )
    C3 sT_clamped = CMin(sT, CV0(ONE3h));
    cosThetaT = CSqrt(CMax(CSub(CV0(ONE3h), CMul(sT_clamped, sT_clamped)), CV0(ZERO3h)));
    

    //--------------------------------------------------------------------------
    // 5. Compute the Reflection Coefficients for s- and p-Polarizations
    //--------------------------------------------------------------------------

    // Denominators for s- and p-polarized components (computed in the real domain).
    C3 denomS = CMax(CAdd(CMul(Cn1, cI), CMul(Cn2, cosThetaT)), CV0(EPSILON3h));
    C3 denomP = CMax(CAdd(CMul(Cn1, cosThetaT), CMul(Cn2, cI)), CV0(EPSILON3h));
    
    // Numerators for s- and p-polarizations.
    C3 numS = CSub(CMul(Cn1, cI), CMul(Cn2, cosThetaT));
    C3 numP = CSub(CMul(Cn1, cosThetaT), CMul(Cn2, cI));
    
    // Compute the reflection coefficients (Rs and Rp).
    C3 Rs = CDiv(numS, denomS);
    C3 Rp = CDiv(numP, denomP);

    
    //--------------------------------------------------------------------------
    // 6. Average the s- and p-Polarized Reflectances and Apply TIR
    //--------------------------------------------------------------------------

    // Average reflectance: R = 0.5*(Rs^2 + Rp^2)
    C3 R_complex = CMul(CAdd(CPow(Rs, CV0(2)), CPow(Rp, CV0(2))), CV0(0.5));

    // Total Internal Reflection (TIR): if sT > 1, then use full reflectance (1).
    half3 tir = step(ONE3h, sT.real); // yields 1 where sT >= 1, else 0.
    C3 R = ComplexLerp(R_complex, CV0(ONE3h), CV0(tir));

    // Clamp the final reflectance.
    R = ComplexClamp(R, float3(ZERO3h), float3(ONE3h));
    
    return R;
}

inline C3 FresnelReflectanceP(C3 eta1, C3 eta2, C3 cosThetaI)
{
    C3 cosThetaT;
    C3 reflectance = FresnelReflectanceFromFilm2(eta1.real, eta2.real, cosThetaI.real, cosThetaT);
    C3 numerator = CSub(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI));
    C3 denominator = CAdd(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI));
    C3 ratio = CDiv(numerator, denominator);
    return CMul(ratio, ratio);
}

inline C3 FresnelReflectanceS(C3 eta1, C3 eta2, C3 cosThetaI)
{
    C3 cosThetaT;
    return FresnelReflectanceFromFilm2(eta1.real, eta2.real, cosThetaI.real, cosThetaT);
}

C3 PhaseShift(float rawNdotL, C3 opd, C3 wavelengthsM, float3 coherenceLengthM, out C3 phaseShiftP)
{
    C3 phaseShiftReflect = ComplexLerp(
        CV(ONE3, ZERO3),
        CV(-ONE3, ZERO3),
        CVV(step(0, rawNdotL)));
    
    C3 phaseDiff =
        CDiv(
            CMul(
                CMul(C2PI,
                    CMul(C20, opd)
                ),
            CV0(coherenceLengthM)
        ), wavelengthsM);
    
    C3 ret = ComplexLerp(phaseDiff, phaseShiftReflect,
        CSat(CSub(C10, CV0(rawNdotL))));
    
    C3 v = CMul(phaseShiftReflect, CV0(coherenceLengthM));
    phaseShiftP = CMul(phaseDiff, v);
    return ret;
}


inline float safeNormalizeRange(float min, float max, float value)
{
    return saturate((value - min) / (max - min));
}

inline float sigmoid(float x)
{
    return 1.0 / (1.0 + exp(-x));
}
inline float3 sigmoid(float3 x)
{
    return 1.0 / (1.0 + exp(-x));
}

inline float smootherstep(float edge0, float edge1, float x)
{
    x = saturate((x - edge0) / (edge1 - edge0));
    return x * x * x * (x * (x * 6 - 15) + 10);
}
inline float2 smootherstep(float2 edge0, float2 edge1, float2 x)
{
    x = saturate((x - edge0) / (edge1 - edge0));
    return x * x * x * (x * (x * 6 - 15) + 10);
}
inline float3 smootherstep(float3 edge0, float3 edge1, float3 x)
{
    x = saturate((x - edge0) / (edge1 - edge0));
    return x * x * x * (x * (x * 6.0 - 15.0) + 10.0);
}


inline float2 gradient(float2 range, float value)
{
    float n = safeNormalizeRange(range.x, range.y, value);
    return float2(sigmoid(1.0 - n), sigmoid(n));
}

inline float2 gradient(float2 range, float2 value)
{
    float nx = smootherstep(range.x, range.y, value.x);
    float ny = safeNormalizeRange(range.x, range.y, value.y);
    return float2(sigmoid(1.0 - nx), sigmoid(ny));
}

inline float2 adjustDepthGradientSigmoid(float2 depthGradient, float2 nearFar)
{
    float2 gx = gradient(nearFar, depthGradient.x);
    float2 gy = gradient(nearFar, depthGradient.y);
    return float2(smootherstep(nearFar.x, nearFar.y, saturate(gx.x)), smootherstep(nearFar.x, nearFar.y, saturate(gy.x)));
}

inline float2 GetGradient(Texture2D<float> depthMap, float2 uv)
{
    float2 oosz = GetOosz(depthMap);
 
    float grad1 = SampleDepth(depthMap, uv);
    float2 v1 = float2(ddx_fine(grad1), ddy_fine(grad1));

    float grad2 = SampleDepth(depthMap, uv + float2(oosz.x, -oosz.y));
    float2 v2 = float2(ddx_fine(grad2), ddy_fine(grad2));

    return smootherstep(float3(v1.xy,  grad1), float3(v2.xy,  grad2), 0.5).xy;
}

inline float2 GetGradient(float2 uv)
{
    return GetGradient(depthMap, uv);

}

inline float2 GetModulation(float2 depthGradient)
{
    float2 nearFar = float2(EPSILON, 1.0 - EPSILON);
    return adjustDepthGradientSigmoid(depthGradient, nearFar);
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




float4 diffuse2D(Texture2D<float4> diffuseMap, float2 uv)
{
    return clamp(diffuseMap.SampleLevel(sampleTypeLinear, uv, 0), EPSILON, 1.0-EPSILON);
}


inline float3 SampleDiffuse(float2 uv)
{
    return clampEpsilon(diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz);
}
inline float3 SampleDiffuse(Texture2D<float3> fdiffuseMap, float2 uv)
{
    return clampEpsilon(diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz);
}
inline float3 SampleDiffuse(Texture2D<float4> diffuseMap, float2 uv)
{
    return clampEpsilon(diffuseMap.SampleLevel(sampleTypeMirror, uv, 0).xyz);
}


struct AdvancedPOMResult {
    float2 uv;
    float height;           // 0 = surface, 1 = max depth
    float occlusion;        // self-occlusion factor
    float3 normalVS;        // final perturbed normal
    float depthOffset;      // for SV_Depth output
};
AdvancedPOMResult AdvancedParallaxOcclusionMapping(
    Texture2D heightTex, Texture2D normalTex,
    SamplerState samp,
    float2 baseUV,
    float3 viewDirTS,           // normalized, tangent space
    float3 viewDirVS,           // view-space direction (from surface toward camera)
    float3 viewPosVS,           // view-space position of the shaded point
    float3x3 TBNView,
    float4x4 Proj,              // view-space → clip-space projection
    float heightScale,          // meters scale, e.g. 0.02–0.15
    float minSteps, float maxSteps)
{
    AdvancedPOMResult r = (AdvancedPOMResult)0;
    float3 Vts = normalize(viewDirTS);
    
    if (abs(Vts.z) < 0.01) {
        r.uv         = baseUV;
        r.height     = 0.0;
        r.occlusion  = 0.0;
        r.normalVS   = mul(float3(0,0,1), TBNView);
        r.depthOffset = 0.0;
        return r;
    }
    
    // === 1. Adaptive sampling + relaxed cone safety ===
    float numSteps  = lerp(maxSteps, minSteps, saturate(abs(Vts.z)));   // more steps at grazing
    float stepSize  = 1.0 / numSteps;
    float2 deltaUV  = Vts.xy * (heightScale / (Vts.z * numSteps));
    
    // Relaxed cone max step (prevents tunneling in deep features)
    float coneSafety = saturate(1.0 - abs(Vts.z) * 0.7);   // tunable
    deltaUV *= (1.0 + coneSafety * 0.5);
    
    float2 uv         = baseUV;
    float  curHeight  = heightTex.SampleLevel(samp, uv, 0).r;
    float  layerHeight = 1.0;
    float  prevHeight  = curHeight;
    float  prevLayer   = layerHeight + stepSize;
    
    // Linear search with early exit
    [loop] for (int i = 0; i < (int)numSteps; ++i) {
        if (layerHeight <= curHeight) break;
        
        prevHeight = curHeight;
        prevLayer  = layerHeight;
        
        uv         += deltaUV;
        layerHeight -= stepSize;
        curHeight   = heightTex.SampleLevel(samp, uv, 0).r;
    }
    
    // === 2. High-precision piecewise linear refinement ===
    float denom = (prevLayer - curHeight) - (layerHeight - prevLayer) + 1e-6;
    float t     = (prevLayer - prevHeight) / denom;
    float2 uvPrev = uv - deltaUV;
    uv        = lerp(uvPrev, uv, t);
    curHeight = heightTex.SampleLevel(samp, uv, 0).r;
    
    r.uv     = uv;
    r.height = curHeight;
    
    // === 3. Soft self-shadowing (light vector trace) ===
    float3 lightDirTS = normalize(mul(transpose(TBNView), LightDir)); // LightDir: VS or WS pre-rotated to VS
    float  shadow     = 1.0;
    
    if (dot(lightDirTS, float3(0,0,1)) > 0.0) {   // light not behind surface
        float2 shadowDelta = lightDirTS.xy * (heightScale / max(lightDirTS.z * 16.0, 0.01));
        float2 shadowUV    = uv + shadowDelta * 0.1;  // start offset
        
        [unroll] for (int s = 1; s < 12; ++s) {   // soft penumbra steps
            float shadowHeight = heightTex.SampleLevel(samp, shadowUV, 0).r;
            if (shadowHeight > (curHeight + s * 0.08)) {
                shadow = lerp(0.3, 1.0, (float)s / 12.0);  // soft transition
                break;
            }
            shadowUV += shadowDelta;
        }
    }
    r.occlusion = shadow;
    
    // === 4. Normal reconstruction from height derivatives (curvature) ===
    float2 off = 1.0 / 1024.0;   // assume 1k heightmap or use ddx/ddy
    float hL = heightTex.SampleLevel(samp, uv + float2(-off.x, 0), 0).r;
    float hR = heightTex.SampleLevel(samp, uv + float2( off.x, 0), 0).r;
    float hU = heightTex.SampleLevel(samp, uv + float2(0, -off.y), 0).r;
    float hD = heightTex.SampleLevel(samp, uv + float2(0,  off.y), 0).r;
    
    float3 tsNormal = normalize(float3(hL - hR, hU - hD, 0.1));  // scale Z for strength
    r.normalVS      = normalize(mul(tsNormal, TBNView));
    
    // === 5. Depth offset for SV_Depth (silhouette correctness) ===
    // Move the view-space point along -viewDirVS by the parallax depth,
    // then compute the difference in clip-space depth (z/w).
    float3 viewDirVSNorm = normalize(viewDirVS);
    float  parallaxDepth = curHeight * heightScale * dot(viewDirVSNorm, mul(float3(0,0,1), TBNView));
    
    float3 newViewPosVS = viewPosVS - viewDirVSNorm * parallaxDepth;
    
    float4 clipOrig = mul(float4(viewPosVS,    1.0), Proj);
    float4 clipNew  = mul(float4(newViewPosVS, 1.0), Proj);
    
    float depthOrig = clipOrig.z / clipOrig.w;
    float depthNew  = clipNew.z  / clipNew.w;
    
    r.depthOffset = depthNew - depthOrig;
    
    return r;
}


float3 SampleDiffuseAberration(Texture2D<float4> diffuseMap, float2 uv, float2 offsetLR, float3 offsetStrength, float3 strength){
    float2 oosz = GetOosz(diffuseMap);

    float3 offsets[2];
    
    offsets[0] = float3(
        clamp(offsetLR.x * offsetStrength.x, oosz.x * 2, oosz.x * 20),
        clamp(offsetLR.x * offsetStrength.y, oosz.x * 2, oosz.x * 20),
        clamp(offsetLR.x * offsetStrength.z, oosz.x * 2, oosz.x * 20));
    
    offsets[1] = float3(
        clamp(offsetLR.y * offsetStrength.x, oosz.x * 2, oosz.x * 20),
        clamp(offsetLR.y * offsetStrength.y, oosz.x * 2, oosz.x * 20),
        clamp(offsetLR.y * offsetStrength.z, oosz.x * 2, oosz.x * 20));
    
    float3 aberrations[2];
    
    aberrations[0] = float3(0,0,0);
    aberrations[1] = float3(0,0,0);
    for(int k=0;k<3;k++)
    {
        float depthL = clamp(abs(EPSILON + SampleDepth(depthMap, uv - float2(offsets[0][k],0) )), .2, .8);
        float depthR = clamp(abs(EPSILON + SampleDepth(depthMap, uv + float2(offsets[1][k],0) )), .2, .8);
        float3 normalL = calcNormal(depthMap, uv - float2(offsets[0][k],0));
        float3 normalR = calcNormal(depthMap, uv + float2(offsets[1][k],0));
        float3 diffuseL = SampleDiffuse(diffuseMap, uv - float2(offsets[0][k],0)).xyz;
        float3 diffuseR = SampleDiffuse(diffuseMap, uv + float2(offsets[1][k],0)).xyz;

        aberrations[0] += diffuseL/3;
        aberrations[1] += diffuseR/3;
    }
    
    float3 diffuse = SampleDiffuse(diffuseMap, uv);
    float3 val0 = lerp(diffuse, .75 * (aberrations[0] + aberrations[1] * .5), strength);
    float3 val1 = lerp(diffuse, .75 * (aberrations[0]*.5 + aberrations[1]), strength);
    return clampEpsilon(float3(val0.x, lerp(diffuse.y, (val0.y+val1.y)*.5, strength.x), val1.z));
}

float DepthCurveAdjustment(float depth, float a, float b, float c)
{
    
    // Example: Simple quadratic curve for depth adjustment
    // Adjust the constants for the desired curve shape
    return a * depth * depth + b * depth + c;
}
float RandomNoise(float2 uv)
{
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}
float RandomNoiseAvg(float3 worldM, float size = 1.0)
{
    float centerDist = clamp(length(worldM- 0.5),EPSILON,1.0-EPSILON)/4.0;
    float2 oosz = GetOosz(depthMap);
    return DepthCurveAdjustment( worldM.z/DepthScale, 0.9f, 0.045f, 0.01f) * 
    (
        RandomNoise(worldM.xy) +
        (RandomNoise(worldM.xy + float2(oosz.x, 0) * size) +
            RandomNoise(worldM.xy + float2(-oosz.x, 0)* size) +
            RandomNoise(worldM.xy + float2(0, -oosz.y)* size) +
            RandomNoise(worldM.xy + float2(0, oosz.y)* size)
        ) / 4.0
    ) / 2.0;
    
}


// Helper function for sinc (sin(x)/x) used in diffraction
float3 sinc(float3 x)
{
    return length(x) < EPSILON ? 1.0 : sin(x) / x;
}


inline void InitPSOut(out psout ret, float2 inputUV, float2 offsetUV = float2(0,0))
{
    ret = (psout) 0;
    OffsetUV = offsetUV;
    InputUV = inputUV;

    Depth = SampleDepth(depthMap, inputUV + offsetUV);
    Diffuse = SampleDiffuse(inputUV + offsetUV);
    
    // Create a mask: 1.0 if PassNum > 0.5, else 0.0
    const float mask = step(0.1, PassNum);
    
    // Define a zero vector with alpha 1.0
    const float4 zeroVec = ZERO41;
    
    // Assign each render target using lerp based on the mask
    ret.rt1 = lerp(zeroVec, diffuse2D(rtMap1, InputUV), mask);
    ret.rt2 = lerp(zeroVec, diffuse2D(rtMap2, InputUV), mask);
    ret.rt3 = lerp(zeroVec, diffuse2D(rtMap3, InputUV), mask);
    ret.rt4 = lerp(zeroVec, diffuse2D(rtMap4, InputUV), mask);
    ret.rt5 = lerp(zeroVec, diffuse2D(rtMap5, InputUV), mask);
    ret.rt6 = lerp(zeroVec, diffuse2D(rtMap6, InputUV), mask);
    ret.rt7 = lerp(zeroVec, diffuse2D(rtMap7, InputUV), mask);
    ret.rt8 = lerp(zeroVec, diffuse2D(rtMap8, InputUV), mask);
}


float3 ProtrusionPS(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 inputUV, float flickerFreq)
{
    float3 baseColor = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb;

    float depth = SampleDepth(depthMap, inputUV);
    float dx = ddx(depth);
    float dy = ddy(depth);
    float depthGradMag = abs(dx) + abs(dy);
    float depthVariance = (2 * PI * 2 * depth * 1e-9) / (saturate(depthGradMag) + sin(time)); // tune 10.0 as needed to map to [0,1]
    float3 phaseOffset = depthVariance * PhaseOffset;
    float omega = 6.28318 * flickerFreq; // 2π * frequency
    float globalFlicker = sin(time * omega);

    float3 channelPhase = float3((2 * PI * 2 * depth) / TanhFactor.r, TanhFactor.g, (2 * PI * 2 * depth) / TanhFactor.b);
    float3 flicker = sin(time * omega + phaseOffset + channelPhase);
    
    flicker *= (2 * PI * 2 * depthVariance) / (1e-9 * 1000 * float3(f01, f02, f03));
    float3 flicker01 = 0.5 * flicker + 0.5;
    float3 intensityFactor = lerp(f04, f05, flicker01);
    
    float2 ooszDiffuse = GetOosz(diffuseMap);
    
    float2 offset = float2(f06, f07) * depthVariance * ooszDiffuse;
    float2 redUV = inputUV + float2(-offset.x, 0); // shift left for red
    float2 blueUV = inputUV + float2(offset.x, 0); // shift right for blue
    float2 greenUV = inputUV; // green stays central (or could have slight offset or vertical shift if desired)

    float redSample = diffuseMap.Sample(sampleTypeLinear, redUV).r;
    float greenSample = diffuseMap.Sample(sampleTypeLinear, greenUV).g;
    float blueSample = diffuseMap.Sample(sampleTypeLinear, blueUV).b;
    float3 flickeredColor;
    flickeredColor.r = redSample * intensityFactor.r;
    flickeredColor.g = greenSample * intensityFactor.g;
    flickeredColor.b = blueSample * intensityFactor.b;
    
    return flickeredColor;
}

LightingComplex CalculateLightingComplex(
    Texture2D<float4> diffuseMap,
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    MaterialSellmeier mat,
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
   
    // **Configuration**
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;

    // **Geometry Setup**
    lighting.depth = SampleDepth(depthMap, inputUV);
    lighting.pixelPos = PixelWorldM;
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    //lighting.TBNf = TBN;
    float3x3 TBN;
    lighting.normal = calcNormal(depthMap, inputUV, TBN);
    

    lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);
    lighting.viewDir = safeNormalize(lighting.viewPos - lighting.pixelPos);
    lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);

    lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));
    lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));

    // **Material Setup**
    lighting.albedo = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb * mat.albedo;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);
    
    lighting.material = mat;
    lighting.nSurrounding = mat.nSurrounding;
    
    // **Refractive Indices**
    C3 eta1 = CV(mat.etaR, mat.etaI);
    // Compute refractive index using Sellmeier equation for each wavelength
    float vB1 = mat.dispersionCoefficientsNm2[0].x; // Sellmeier coefficients B1, B2, B3
    float vC1 = mat.dispersionCoefficientsNm2[1].x;
    float vB2 = mat.dispersionCoefficientsNm2[0].y;
    float vC2 = mat.dispersionCoefficientsNm2[1].y;
    float vB3 = mat.dispersionCoefficientsNm2[0].z;
    float vC3 = mat.dispersionCoefficientsNm2[1].z;
    float3 lambda = lighting.albedoWavelengthsNM; // Wavelengths in nm
    float3 lambda2 = lambda * lambda;
    float3 n2 =
        1.0 + vB1 * lambda2 / (lambda2 - vC1) +
              vB2 * lambda2 / (lambda2 - vC2) +
              vB3 * lambda2 / (lambda2 - vC3);
    mat.etaR = sqrt(max(1.0, n2)); // Update etaR per wavelength, ensure n >= 1
    
    C3 eta2 = CV(mat.etaI, mat.etaR);

    C3 cosThetaI = CV(lighting.NdotL3, ZERO3);
    C3 sinThetaI = CSqrt(CSub(C11, CMul(cosThetaI, cosThetaI)));
    C3 sinThetaT = SnellsLaw(eta1, eta2, sinThetaI);
    C3 cosThetaT = CSqrt(CSub(C11, CMul(sinThetaT, sinThetaT)));

    
    float2 sz;
    depthMap.GetDimensions(sz.x, sz.y);
    float2 oosz = 1.0 / sz;
   
    // **Holographic Interference**
    float3 light = ZERO3;
    float3 diffuseColor = diffuse2D(diffuseMap, inputUV).xyz;
    
    float3 objectPos = lighting.pixelPos + lighting.normal * sin((lighting.pixelPos - 0.5) + 2.0 * mat.coherenceLengthM + cos(time)) * .25;
    float3 objectDir = safeNormalize(objectPos - lighting.pixelPos);

    float objectDist = abs(length(objectPos - lighting.pixelPos));
   
   // Object Phase for visible interference
  
   C3 coherenceFactor = CV((exp(-objectDist *mat.etaR/ mat.coherenceLengthM)), ZERO3);
    // Adjusted coherence lengthcoherence length
   // C3 coherenceFactor = CV(ONE3, ZERO3); // No decay
    coherenceFactor.real = clamp(coherenceFactor.real, ZERO3, ONE3);
    
    float refDist = length(lighting.viewPos - lighting.pixelPos);
    
    float3 dispersionPhase = (2.0 * PI * 2.0 * mat.etaR * lighting.depth) / lighting.albedoWavelengthsM * coherenceFactor.real;
 
    // Object wave phase: 2 * depth / wavelength (reflection OPD) + animation
    C3 phi_object = CV0(dispersionPhase * f08);
    // Amplitude based on diffuse lighting
    float amplitude = max(0, dot(lighting.normal, lighting.lightDir));
  
    // Compute object wave
    C3 E_object;
    E_object.real = CMul(CVV(amplitude), CCos(phi_object)).real;
    E_object.imag = CMul(CVV(amplitude), CSin(phi_object)).imag;
    E_object = CMul(E_object, coherenceFactor); // Apply coherence

    
    float3 refPhase = (2 * PI * 2.0 * refDist * mat.etaR) / (lighting.albedoWavelengthsM + SampleDepth(depthMap, inputUV) * mat.coherenceLengthM * .1 + .1);
    
    float refAmplitude = objectDist * Mix2;
   
    float3 magE_object = CMag(E_object);
   
    C3 coherenceFactor2 = CV(abs(exp(-refDist / mat.coherenceLengthM)), ZERO3);
    coherenceFactor2.real = clamp(coherenceFactor2.real, ZERO3, ONE3);
    
    C3 E_reference = CDiv(CExp(CV(cos(refPhase), sin(refPhase))), coherenceFactor2); // Amplitude = 1
   
    C3 d = CV(max(nmToM(mat.thicknessNM), ZERO3), ZERO3);
 
    float3 opd = max(2.0 * eta2.real * d.real * cosThetaT.real, ZERO3);
    
    C3 totalPhaseP;
    C3 totalPhaseS = PhaseShift(dot(lighting.normal, lighting.lightDir), CV0(opd), CV0(lighting.albedoWavelengthsM), mat.coherenceLengthM, totalPhaseP);
    
    C3 totalPhaseP2;
    C3 totalPhaseS2 = PhaseShift(dot(lighting.normal, lighting.lightDir), CV0(opd+
    totalPhaseS.real+time), CV0(lighting.albedoWavelengthsM), mat.coherenceLengthM, totalPhaseP2);
    
    totalPhaseP = ComplexLerp(totalPhaseP, totalPhaseP2, CVV(lighting.depth/DepthScale));
    totalPhaseS = ComplexLerp(totalPhaseS, totalPhaseS2, CVV(lighting.depth/DepthScale));
    
    C3 r_s12 = FresnelReflectanceS(eta1, eta2, cosThetaI);
   
    C3 r_p12 = FresnelReflectanceP(eta1, eta2, cosThetaI);
    C3 r_s23 = FresnelReflectanceS(eta2, eta1, cosThetaT);
    C3 r_p23 = FresnelReflectanceP(eta2, eta1, cosThetaT);
    r_s12.real = clamp(r_s12.real, ZERO3, ONE3);
    r_p12.real = clamp(r_p12.real, ZERO3, ONE3);
    r_s23.real = clamp(r_s23.real, ZERO3, ONE3);
    r_p23.real = clamp(r_p23.real, ZERO3, ONE3);

    C3 t_s12 = CSub(C11, r_s12);
    C3 t_p12 = CSub(C11, r_p12);
    C3 t_s21 = CSub(C11, r_s23);
    C3 t_p21 = CSub(C11, r_p23);
    t_s12.real = clamp(t_s12.real, ZERO3, ONE3);
    t_p12.real = clamp(t_p12.real, ZERO3, ONE3);
    t_s21.real = clamp(t_s21.real, ZERO3, ONE3);
    t_p21.real = clamp(t_p21.real, ZERO3, ONE3);

    C3 E_s_direct = r_s12;
    C3 E_p_direct = r_p12;
    C3 E_s_internal = CMul(CMul(t_s12, r_s23), t_s21);
    C3 E_p_internal = CMul(CMul(t_p12, r_p23), t_p21);
    float3 magE_s_internal = CMag(E_s_internal);
    float3 magE_p_internal = CMag(E_p_internal);
  
    C3 E_s_film = CAdd(E_s_direct, CMul(E_s_internal, CExp(totalPhaseS)));
    C3 E_p_film = CAdd(E_p_direct, CMul(E_p_internal, CExp(totalPhaseP)));
    float3 magE_s_film = CMag(E_s_film);
    float3 magE_p_film = CMag(E_p_film);
 

    C3 E_s_total = CAdd(CAdd(E_s_film, E_object), E_reference);
    C3 E_p_total = CAdd(CAdd(E_p_film, E_object), E_reference);
    C3 interferenceTerm = CAdd(CMul(E_s_total, ComplexConjugate(E_s_total)), CMul(E_p_total, ComplexConjugate(E_p_total)));
    float3 magE_s_total = CMag(E_s_total);
    float3 magE_p_total = CMag(E_p_total);
   
    float3 intensity = saturate(dot(interferenceTerm.real, ONE3)) * 2.0 * lighting.albedo;
    interferenceTerm = CV0(intensity * saturate(lighting.NdotL3));
    
    
    C3 diffuse = CV0(magE_p_total * magE_p_total * lighting.NdotL3.xxx);
    

    float alpha = mat.roughness * mat.roughness;
    float D = 1.0 / (PI * alpha * alpha * pow(max(lighting.HdotN, EPSILON), SpecularPower));
   
    float3 specularIntensity = abs(D * lighting.NdotL3 * SpecularIntensity * intensity);
    
    light = specularIntensity;
    
    float3 exposed = lighting.albedo * 0.1 + lighting.albedo * light * exposure;
    float3 gammaCorrected = pow(max(EPSILON3, exposed), max(EPSILON, 1.0 / gamma));

    SetDVf(totalLighting, gammaCorrected);
       

    return lighting;
}

// Updated CalculateLightingComplex function
LightingComplex CalculateLightingComplexInterference(
    float3 diffuse,
    float2 inputUV,
    float3 viewPos,
    float3 lightPos,
    bool invertDepth,
    bool useProjectedDepth,
    float depthScale,
    MaterialSellmeier mat,
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
    
    // Existing initialization
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;
    lighting.depth = SampleDepth(depthMap, inputUV);
    lighting.pixelPos = float3(float2(inputUV.x, -inputUV.y), lighting.depth);
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    lighting.normal = calcNormal(depthMap, inputUV);
    lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);
    lighting.viewDir = safeNormalize(viewPos - lighting.pixelPos);
    lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);
    
    lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));
    lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    lighting.albedo = float3(1, 1, 1); // Default albedo
    lighting.material = mat;
    
    // Get screen size for pixel size calculations
    float2 screenSize;
    depthMap.GetDimensions(screenSize.x, screenSize.y);
    
    float3 wavelengthsNM = RGBToWavelengthsNM(diffuse);
    
    // Modulate lighting with interference
    float3 color = lighting.albedo * lighting.NdotL3;
    float alpha = mat.roughness * mat.roughness;
    float D = 1.0 / (PI * alpha * alpha * pow(max(lighting.HdotN, EPSILON), SpecularPower));
    float3 specular = D * lighting.NdotL3 * SpecularIntensity;
    float3 light = color + specular;
    
    
    // Apply post-processing
    float3 exposed = light * exposure;
    float3 gammaCorrected = pow(max(EPSILON3, exposed), max(EPSILON, 1.0 / gamma));
    SetDVf(totalLighting, gammaCorrected);
    lighting.totalLighting[0] = diffuse * gammaCorrected;
    //diffuse * gammaCorrected;
    
    return lighting;
}

float j1(float x)
{
    float x2 = pow(x * 0.5f, 2); // (x/2)^2
    float sum = x * 0.5f; // First term: x/2
    float term = sum;
    for (int m = 1; m < 10; ++m)
    {
	 // Limited terms for performance
        int mBang = m;
        int mBangSum = 0;
        int mBangP1 = m + 1;
        int mBangSumP1 = 0;
        while (mBang > 0)
        {
            mBangSum += mBang;
            mBang--;
            mBangSumP1 += mBangP1;
            mBangP1--;
        }
        mBangSumP1 += mBangP1;
        mBangP1--;
        term *= -pow(1, m) * pow(abs(x) * .5f, 2.0f * m + 1.0) / (mBangSum * mBangSumP1); //-x2 / (m * (m + 1)); // (-1)^m * (x/2)^(2m+1) / (m! * (m+1)!)
        sum += term;
    }
    return sum;
}
float3 j1(float3 arg)
{
    return float3(j1(arg.x), j1(arg.y), j1(arg.z));
}

// Computes interference for a Sellmeier material with realistic physics
// Computes holographic interference with realistic wavefront reconstruction
C3 ComputeInterference3(
    MaterialSellmeier mat,
    float3 pixelPos,
    float3 wavelengthsNM,
    float depth,
    float2 uv
)
{
    // Numerical safeguards
    wavelengthsNM = max(wavelengthsNM, EPSILON3);
    depth = max(depth, EPSILON);
    uv = clamp(uv, 0.0f, 1.0f); // Ensure uv is in [0,1]

    // 1. Refractive Index (Sellmeier Model)
    float3 lambda2 = wavelengthsNM * wavelengthsNM;
    float3 n = mat.etaR;
    for (
int i = 0; i < 3; ++i)
    {
        n += mat.dispersionCoefficientsNm2[i] /
lambda2;
    }
    n = max(n, 1.0f); // Ensure physically valid refractive index

    // 2. Wave Number and Optical Path Difference
    float3 k = 2.0f * PI / wavelengthsNM; // Wave number (per meter)
    
    
    float cosTheta = dot(normalize(ViewDir), normalize(LightDir)); // Incidence angle cosine
    

    cosTheta = clamp(cosTheta, -1.0f, 1.0f);
    float3 opdPhysical = 2.0f * n * depth / max(cosTheta, EPSILON); // Two-way OPD
    C3 opd = CV0(opdPhysical);

    // 3. Object Wave with Virtual Scene Encoding
    // Simulate a 3D object with a depth map (parabolic profile)
    float3 objDepth = 1e-6f * (1.0f + 0.5f * (uv.x * uv.x + uv.y * uv.y)); // Parabolic depth (meters)
    float3 objPhase = k * objDepth; // Phase from object depth
    // Add spatial and temporal modulation for dynamic hologram
    float3 scenePhase = lerp(1e-6 * cos(time), 1e-3 * cos(time), sin(time)) *
    2.0f * PI * sin(5.0f * uv.x + 3.0f * uv.y + 0.2f * time);
    C3 phi_object = CV0(opdPhysical + objPhase + scenePhase); // Total object phase

    // 4. Reference Wave with Fresnel Polarization
    float3 n_air = 1.0f; // Refractive index of air
    float3 cosThetaT = sqrt(1.0f - (n_air / n) * (n_air / n) * (1.0f - cosTheta * cosTheta));
    cosThetaT = max(cosThetaT, EPSILON);

    // Fresnel amplitude reflectivities
    float3 rs = (n_air * cosTheta - n * cosThetaT) / (n_air * cosTheta + n * cosThetaT);
    float3 rp = (n * cosTheta - n_air * cosThetaT) / (n * cosTheta + n_air * cosThetaT);

    // Reference beam with dynamic tilt and Gaussian profile
    float3 r = length(pixelPos - ViewPosM) * 2.0; // Distance to viewer
    r = max(r, EPSILON3);
    float3 refPhase = k * dot(r, ViewDir); // Reference beam phase
   
    C3 phi_ref_s = CV0(refPhase); // S-polarized phase
    C3 phi_ref_p = CV0(refPhase + 0.5f * PI); // P-polarized phase (90° shift)

    // 5. Wave Amplitudes
    C3 E_object = CExp(phi_object); // Object wave: e^(i * phi)
   
    // 6. Holographic Interference
    C3 E_total = CAdd(E_object, phi_object); // Interference: object + reference
    float3 intensity = CMag(E_total); // Intensity = |E_total|^2

    // 7. Coherence and Absorption
    float3 coherenceFactor = exp(-opdPhysical / max(mat.coherenceLengthM, EPSILON3));
    intensity *= coherenceFactor;
    float3 absorptionFactor = exp(-mat.absorptionCoefficient * depth); // Beer's law
    intensity *= absorptionFactor;

    // 8. Fresnel Diffraction with Bessel Function
    float3 rho = sqrt(uv.x * uv.x + uv.y * uv.y); // Radial distance in uv-plane
    float3 arg = k * rho * 0.015f; // Scaled for visible fringes
    float3 diffraction = 1.0f + 0.6f * (2.0f * j1(arg) / max(arg, EPSILON3)) + cos(phi_ref_p.real) + sin(phi_ref_s.real); // Bessel J1 for diffraction
    intensity *= diffraction;

    
    // 11. Return intensity as C3 (real component only)
    return CV0(intensity);
}
    
    
LightingComplex CalculateLightingComplex3(Texture2D<float4> diffuseMap, float2 inputUV, float3 pixelPos, float3 viewPos, float3 lightPos,
    bool invertDepth, bool useProjectedDepth, float depthScale, MaterialSellmeier mat,
    float parallaxScale, float normalRadius, float sssStrength,
    int dispersionIndex, float gamma, float exposure, float saturation
)
{
    LightingComplex lighting = (LightingComplex) 0;
    float depth = SampleDepth(depthMap, inputUV);
    
    // Initialize Basics
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = max(gamma, EPSILON);
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;
    lighting.depth = SampleDepth(depthMap, inputUV);
    lighting.pixelPos = pixelPos;
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    lighting.normal = calcNormal(depthMap, inputUV);
    lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);
    lighting.viewDir = safeNormalize(viewPos - lighting.pixelPos);
    lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);
    
    lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));
    lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    lighting.albedo = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb;
    lighting.material = mat;
    lighting.totalLighting[0] = ZERO3;
    lighting.totalLighting[1] = ZERO3;
    lighting.totalLighting[2] = ZERO3;
    
    // Interference
    float3 wavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    C3 interference = ComputeInterference3(mat, pixelPos, wavelengthsNM, lighting.depth, inputUV);
    float3 intensity = ComplexMagnitude(interference);
    
    // Physics: Complex Fresnel
    C3 eta1 = CVV(mat.nSurrounding); // Real surrounding index
    C3 eta2 = CV(mat.etaR, mat.etaI); // Complex material index
    C3 cosThetaI = CVV(lighting.NdotV3); // Real cosine
    C3 sinThetaI = CVV(sqrt(max(1.0 - cosThetaI.real * cosThetaI.real, EPSILON3)));
    C3 sinThetaT = CDiv(CMul(eta1, sinThetaI), eta2);
    C3 cosThetaT = CVV(sqrt(max(1.0 - sinThetaT.real * sinThetaT.real, EPSILON3)));
    C3 Rs = CDiv(CSub(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)),
                       CAdd(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)));
    C3 Rp = CDiv(CSub(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI)),
                       CAdd(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI)));
    float3 F = 0.5 * (CMag(Rs) * dot(normalize(viewPos - pixelPos), 
        lighting.normal) + CMag(Rp));
    
    // Math: Anisotropic GGX
    float alpha = mat.roughness * mat.roughness;
    //float3 T = lighting.TBNf[0];
    //float3 B = lighting.TBNf[1];
    float alphaT = alpha * dot(lighting.halfDir, ViewDir);
    float alphaB = alpha * dot(lighting.halfDir, lighting.normal);
    float D = alphaT * alphaB / (PI * pow(max(lighting.HdotN * lighting.HdotN * (alphaT * alphaB - 1.0) + 1.0, EPSILON), 2));
    float k = alpha / 2.0;
    float G_i = lighting.NdotL3 / max(lighting.NdotL3 * (1.0 - k) + k, EPSILON);
    float G_o = lighting.NdotV3 / max(lighting.NdotV3 * (1.0 - k) + k, EPSILON);
    float G = saturate(G_i * G_o);
    float3 specular = (D * F * G) / (max(4.0 * lighting.NdotL3 * lighting.NdotV3, EPSILON));
    
    // Diffuse and SSS
    float3 diffuse = (1.0 - mat.metallic) * lighting.albedo * lighting.NdotL3 * intensity / PI;
    
    float3 sss = (sssStrength * exp(-depth / nmToM(mat.thicknessNM)) * lighting.albedo);
    float3 light = (diffuse) + (specular) + (sss);
    
    // Post-Processing
    float3 exposed = (light * exposure);
    float3 gammaCorrected = pow(max(EPSILON3, exposed), 1.0 / lighting.Config_Gamma);
    lighting.totalLighting[0] = gammaCorrected;
    SetDVf(totalLighting, gammaCorrected);
    
    return lighting;
}
C3 ComputeHoloGratingDiffraction
    (MaterialSellmeier
    mat,
    float3 pixelPosM, float3 wavelengthsNM, float2 uv, float gratingDepth, float3 gratingNormal, float3 noise1)
{
    
    // Wave number and refractive index with dispersion
    float3 k = C2PI.real / wavelengthsNM;
    float3 n = mat.etaR + mat.dispersionCoefficientsNm2[0] / (wavelengthsNM * wavelengthsNM);

    // Optical path difference with dynamic variation
    float3 dynamicDepth = gratingDepth * (1.0 + 0.2 * sin(time * 2.0)); // Adds pulsing effect
    C3 opd = CV0(2.0 * n * dynamicDepth * DepthScale * saturate(dot(gratingNormal, mat.opticalAxis)));

    // Enhanced grating periodicity with iridescence
    float3 gratingLines = gratingMap1.Sample(linearSampler, uv + float2(time * 0.05, 0)).rgb;
    C3 phi_grating = CMul(C2PI, CV0(gratingLines * 30.0 + time * 0.3 + 0.1 * sin(time * 5.0))); // Subtle shimmer

    // Noise interference with controlled amplitude
    C3 phi_noise = C0V(noise1 * PI * time * 0.5); // Reduced f04 to 0.5 for subtlety

    // Base phase from light travel
    float3 lightDist = length(PixelWorldM - LightPosM);
    C3 phi_base = CV0(k * lightDist / SPEED_OF_LIGHT);

    // Total phase with coherence
    C3 phi_total = CAdd(CAdd(phi_base, phi_grating), phi_noise);

    // Wave amplitudes with coherence decay
    C3 E_object = CExp(CMul(C01, phi_total));
    C3 E_ref = CV(cos(phi_base.real + PhaseOffset.r + time), sin(phi_base.real + PhaseOffset.g + time)); // Dynamic reference wave
    float3 coherence = exp(-gratingDepth / max(mat.coherenceLengthM, EPSILON3));
    C3 E_total = CAdd(E_object, CMul(E_ref, CV0(coherence)));

    // Normalize amplitude to prevent blowout
    float3 mag = CMag(E_total);
    E_total.real = E_total.real / max(mag, EPSILON3);
    E_total.imag = E_total.imag / max(mag, EPSILON3);

    return E_total;
}


Complex3 CalculateInterferenceComplex4(float2 pixelPos, float2 source1, float2 source2, float depth)
{
    Complex3 result;
    result.real = float3(0.0, 0.0, 0.0);
    result.imag = float3(0.0, 0.0, 0.0);

    // Scale wavelengths to coordinate space for visible fringes
    float3 lambdaCoord = RGBToWavelengthsNM(diffuseMap.Sample(sampleTypeLinear, float2(pixelPos.x, -pixelPos.y)).xyz) * (SCREEN_WIDTH_M / FRINGE_SCALE);

    // Distance from pixel to each source (in UV space, approximated as 2D for performance)
    float dist1 = length(pixelPos - source1) + depth * 0.1; // Simplified depth influence
    float dist2 = length(pixelPos - source2) + depth * 0.1;

    // Phase per channel (2π * distance / wavelength)
    float3 phase1 = TWOPI * dist1 / lambdaCoord;
    float3 phase2 = TWOPI * dist2 / lambdaCoord;

    // Wave amplitudes (complex exponentials: cos(phase) + i*sin(phase))
    float3 amp1Real = cos(phase1);
    float3 amp1Imag = sin(phase1);
    float3 amp2Real = cos(phase2);
    float3 amp2Imag = sin(phase2);

    // Sum contributions from both sources
    result.real = amp1Real + amp2Real;
    result.imag = amp1Imag + amp2Imag;

    // Optional: Add subtle time-based modulation for holographic shimmer
    float shimmer = 0.1 * sin(time * 2.0);
    result.real += shimmer * result.real;
    result.imag += shimmer * result.imag;

    return result;
}




//==================================================================
// Hologram Calculation Function
//==================================================================
Complex3 CalculateHologram
    (

    float3 pixelWorldPos, // World-space position of the pixel
    float3 lightPos, // Position of the light source
    float3 viewDir, // View direction (from pixel to camera)
    float3 diffuseRGB, // Base diffuse color used for wavelength conversion
    float depth, // Depth value for the pixel
    float2 uv // UV coordinates (for controlled oscillation)
)
{
    Complex3 result;
    result.real = float3(0.0, 0.0, 0.0);
    result.imag = float3(0.0, 0.0, 0.0);

    // --- Multi-Wavelength Optimization ---
    // Convert the diffuse color to wavelengths (nm) then to meters.
    float3 lambdaNM = RGBToWavelengthsNM(diffuseRGB);
    float3 lambdaM = lambdaNM * 1e-9;

    // --- Coherence-Tailored Depth Cues ---
    // Base coherence length from f12 (e.g., f12 = 0.04 implies 4 cm).
    // Modulate slightly by depth (using a saturate on depth, minimum to avoid division by zero).
    float effectiveDepth = max(depth, 0.00001);
    float depthFactor = saturate(effectiveDepth);
    float3 coherenceLength = float3((depthFactor),
                                    (depthFactor),
                                    (depthFactor));

    // --- Wave Number ---
    // k = 2π/λ for each channel.
    float3 k = TWOPI / lambdaM;

    // --- Dynamic Phase Alignment ---
    // Global oscillation: a gentle sinusoidal phase offset (0.5 Hz, 0.1 rad amplitude).
    float globalOscFreq = 0.5 * f02;
    float globalOscAmp = 0.1 * f03;
    float globalPhaseOffset = sin(time * globalOscFreq * TWOPI) * globalOscAmp;
    // Fixed per-channel offsets to slightly separate the RGB channels.
    float3 channelPhaseOffset = float3(0.0, 1.57, 3.14);

    // --- Reference Wave (Spherical Wave from Light Source) ---
    float3 refVec = lightPos - pixelWorldPos;
    float distRef = abs(length(refVec));
    // Compute phase for each channel and add global and per-channel offsets.
    float3 phaseRef = k * distRef;
    // Amplitude damping using the coherence length.
    float3 ampDampRef = exp(-distRef / coherenceLength);

    // --- Object Wave (Reflection from Virtual Plane) ---
    // Introduce a controlled oscillatory offset (based on UV) rather than random noise.
    float2 sz = GetSz(depthMap);
    float oscillation = sin(pixelWorldPos.x * coherenceLength.x + time);
    float oscillation2 = cos(pixelWorldPos.y * coherenceLength.y + time);
    float3 oscillatoryOffset = float3(oscillation, oscillation2, depth * coherenceLength.z);
    float3 objPos = pixelWorldPos + oscillatoryOffset;
    float3 objVec = (objPos - pixelWorldPos);
    float distObj = abs(length(objVec));
    // Compute the object phase and add the global and per-channel offsets.
    float3 phaseObj = k * distObj + globalPhaseOffset + channelPhaseOffset;
    // Add a view-dependent phase term (small factor for gentle modulation).
    viewDir = normalize(objPos - (pixelWorldPos + EPSILON3));
    float viewAngle = dot(viewDir, normalize(objVec));
    phaseObj += k * viewAngle * 1.3;
    float3 ampDampObj = exp(distObj / coherenceLength);

    // --- Reflection Coefficient ---
    // Use a fixed hologram medium index to compute reflectance.
    float3 n = float3(1.5, 1.5, 1.7);
    float3 Rcoeff = pow((n - 1.0) / (n + 1.0), 2.0);

    // --- Amplitude Calculation ---
    // Reference wave amplitude: moderate boost for visibility.
    float3 ampRefReal = (Rcoeff) * ampDampRef * cos(phaseRef);
    float3 ampRefImag = (Rcoeff) * ampDampRef * sin(phaseRef);
    // Object wave amplitude: use the diffuse color as the base.
    float3 ampObjReal = ampDampObj * cos(phaseObj);
    // Animate the imaginary part slowly (0.2 * time for smooth evolution).s
    float3 ampObjImag = ampDampObj * sin(phaseObj);

    // --- Interference ---
    // Sum the reference and object contributions.
    result.real = (ampObjReal + ampRefReal);
    result.imag = (ampObjImag + ampRefImag);

    return result;
}

// Coherence-tailored depth function
float3 CalculateDepthCue
    (
    float2 uv, float depthSample, float3 coherenceFactor)
{
    float3 depth = (depthSample) * coherenceFactor;
    float3 depthAttenuation = Mix2 - saturate(depth);
    return depth * depthAttenuation;
}

// Dynamic phase alignment function
float3 PhaseAlign
    (
    float2 uv, float t, float3 phaseShift, float3 oscillationAmplitude)
{
    float3 phase = float3(
        sin(t + uv.x * 2.0 + phaseShift.x),
        sin(t + uv.y * 1.5 + phaseShift.y * 0.8),
        sin(t + uv.x * uv.y * 1.2 + phaseShift.z * 0.6)
    );
    return phase * oscillationAmplitude;
}

// Interference pattern generator
float3 GenerateInterference(float2 uv, float t, float3 coherenceFactor, float3 wavelengths)
{
    float3 interference = 0.0;
    
    // Multi-wavelength interference
    [unroll(3)]
    for (int i = 0; i < 3; i++)
    {
        float wave = sin((uv.x + uv.y) * wavelengths[i] * 10.0 + t);
        float3 coherence = 1.0 / (1.0 + abs(float3(uv, DepthScale) - 0.5) * coherenceFactor);
        interference[i] = wave * coherence[i];
    }
    
    return interference;
}

// Accurate calculation of light travel distance
inline float calc_distance
    (
    float3 viewerPos, float3 pointPos)
{
    return length(viewerPos - pointPos);
}



inline C3 AdjustGamma(C3 color, float gammaValue = GAMMA_VALUE)
{
    float3 cr = pow(abs(max(EPSILON3, color.real)), 1.0 / gammaValue);
    float3 ci = pow(abs(max(EPSILON3, color.imag)), 1.0 / gammaValue);
    return CV(cr, ci);
    //return ComplexPow(CMax(ComplexEPSILON3VV, color.real), CDiv(Complex11, CMax(ComplexEPSILON3VV, ComplexVV(gammaValue))));
}
inline C3 CAdjustGamma(C3 color, C3 gammaValue)
{
    float3 cr = pow(abs(max(EPSILON3, color.real)), 1.0 / gammaValue.real);
    float3 ci = pow(abs(max(EPSILON3, color.imag)), 1.0 / gammaValue.imag);
    return CV(cr, ci);
    //return ComplexPow(CMax(ComplexEPSILON3VV, color.real), CDiv(Complex11, CMax(ComplexEPSILON3VV, ComplexVV(gammaValue))));
}

inline float4 AdjustGammaf(float4 color, float3 gammaValue = GAMMA_VALUE)
{
    return float4(AdjustGamma(CVV(pow(abs(max(EPSILON3, color.xyz)), ONE3/max(EPSILON3, gammaValue)))).real, color.a);
}
inline float3 AdjustGammaf(float3 color, float3 gammaValue = GAMMA_VALUE)
{
    return AdjustGamma(CVV(pow(abs(max(EPSILON3, color)), ONE3/max(EPSILON3, gammaValue)))).real;
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
    {
        return gratingMap4;
    }
}
Texture2D<float3> getGratingNormalMap(int index)
{
    index = int(uint(index) % uint(4));
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
    {
        return gratingDepth4;
    }
}

inline float3 RGBToGrayscale(float3 color)
{
    return dot3(color, float3(0.2989, 0.5870, 0.1140));
}




inline C3 RefractiveIndexFromSellmeier
    (C3
    wavelengthsNM,
    bool isOrdinaryRay, MaterialSellmeier
    mat)
{
    wavelengthsNM = CMax(wavelengthsNM, CEPSILON3);
    float3 lambdaUM = nmToUm(wavelengthsNM.real); // nm to µm
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



inline float3 Iridescence(
    float2 uv,
    float3 viewDir,
    float3 normal,
    float3 baseColor,
    float thicknessNM,
    MaterialSellmeier
    coeffs,
    float3 iorMedium,
    bool isOrdinary)
{
    float3 V = normalize(viewDir + EPSILON3);
    float3 N = normalize(normal + EPSILON3);
    float3 baseColorWavelengthsNM = nmToUm(RGBToWavelengthsNM(baseColor));
    
    C3 ri = RefractiveIndexFromSellmeier(CV0(nmToM(baseColorWavelengthsNM)), isOrdinary, coeffs);
    float3 iorFilm = CMag(ri);
    
    float3 cI = saturate(dot3(N, V));
    float3 sI = max(sqrt(ONE3 - cI * cI), EPSILON3);

    float3 ratio = iorMedium / max(iorFilm, EPSILON3);
    float3 sT = ratio * sI;

    // TIR mask
    float3 TIRMask = step(0, sT);
    sT = min(sT, ONE3 - EPSILON3);
    float3 cT = sqrt(ONE3 - sT * sT);

    float3 OPD = TWO3 * iorFilm * (thicknessNM) * cT;
    float3 delta = (TWO3 * PI3 * OPD) / (baseColorWavelengthsNM);

    // Phase shifts
    // Using step to determine sign:
    float3 phaseShift0 = PI3 * step(iorFilm, iorMedium);
    float3 phaseShift1 = PI3 * step(iorMedium, iorFilm);

    float3 totalPhase = (delta + phaseShift0 + phaseShift1);

    C3 cosThetaTR0;
    C3 R0 = CV0(1.0 - CMag(FresnelReflectanceFromFilm2(iorMedium, iorFilm, cI, cosThetaTR0)));

    C3 cosThetaTR1;
    C3 R1 = CV0(1.0 - CMag(FresnelReflectanceFromFilm2(iorFilm, iorMedium, cT, cosThetaTR1)));
    
    float3 interference =
        TWO3 * sqrt(CMag(R0) + CMag(R1)) *
            cos(totalPhase + CMag(cosThetaTR0) + CMag(cosThetaTR1) + time);

    float3 reflectance = (CMag(R0) + CMag(R1)) * interference;
    reflectance = lerp(reflectance, CMag(R0), TIRMask);

    reflectance = saturate(reflectance);

    return (reflectance * interference);
}


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


C3 ComplexScale(C3 c, float3 scale)
{
    return CV(c.real * scale, c.imag * scale);
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


// Function to calculate the refractive index using the Sellmeier equation
float3 CalculateRefractiveIndex(C3 wavelengthNM, const SellmeierCoefficients coeffs)
{
    float3 wavelengthMicron = nmToUm(wavelengthNM.real); // Convert to microns
    float3 wavelengthSquared = wavelengthMicron * wavelengthMicron;

    float3 n_squared_minus_1 = 0; // Initialize to zero

    // Assuming coeffs contains multiple B and C pairs, e.g., for a 3-term Sellmeier
    // Example for a 3-term Sellmeier (adapt based on your coeffs struct)
    n_squared_minus_1 += coeffs.OE1.O.B * wavelengthSquared / max(EPSILON3, wavelengthSquared - coeffs.OE1.O.C);
    n_squared_minus_1 += coeffs.OE2.O.B * wavelengthSquared / max(EPSILON3, wavelengthSquared - coeffs.OE2.O.C);
    n_squared_minus_1 += coeffs.OE3.O.B * wavelengthSquared / max(EPSILON3, wavelengthSquared - coeffs.OE3.O.C);
    // ... add more terms if your coeffs struct has them

    float3 refractiveIndexSquared = 1.0 + n_squared_minus_1;

    // Ensure non-negative before sqrt and clamp to a reasonable range
    float3 refractiveIndex = sqrt(max(EPSILON3, refractiveIndexSquared));

    // Optional additional clamping if needed, but the sqrt(max(EPSILON3, ...)) should handle most
    refractiveIndex = clamp(refractiveIndex, 1.0 + EPSILON3, 5.0 - EPSILON3);

    return refractiveIndex;
}

struct PathMeasurement
{
    float3 PathLength;
    float3 PathTotalLength;
    float3 PathDifference;
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

inline PathMeasurement CreatePathMeasurement(float3 PathLength, float3 PathTotalLength, float3 PathDifference)
{
    PathMeasurement ret;
    ret.PathLength = PathLength;
    ret.PathTotalLength = PathTotalLength;
    ret.PathDifference = PathDifference;
    return ret;
}

struct OpticalPathResult
{
    C3 wavelengthsNM;
    float3 refractiveIndex;
    PathMeasurement measurement;
    PathMeasurement opticalMeasurement;
    PhaseInterference phaseInterference;
    C3 intensityModulation;
    float3 absorptionEffect;
};

inline OpticalPathResult CreateOpticalPathResult(
    C3 wavelengthsNM,
    float3 refractiveIndex,
    PathMeasurement measurement,
    PathMeasurement opticalMeasurement,
    PhaseInterference phaseInterference,
    C3 intensityModulation,
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

inline PhaseInterference OpticalPhaseInterference(float3 wavelengthsM, float3 etaR, float3 nSurrounding, float3 thicknessNM, float3 cosThetaT)
{
    float3 w = max(wavelengthsM, EPSILON3);

    float3 OPD = 2.0f * etaR * nmToM(thicknessNM) * cosThetaT;
    float3 phaseDifference = (TWOPI3 * OPD) / w;

    float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, etaR);

    float3 totalPhase = phaseDifference + reflectionPhaseShift;

    return CreatePhaseInterference(OPD, phaseDifference, reflectionPhaseShift, totalPhase, cosThetaT);
}


inline C3 RefractiveIndexFromDispersionCoefficients(
    C3 wavelengthsNM, float3 dispersionCoeffsNm2)
{
    wavelengthsNM = CAdd(C00, wavelengthsNM);
    dispersionCoeffsNm2 = 0 + dispersionCoeffsNm2;
    
    
    // Convert nm to μm and calculate λ² in μm²
    C3 um = CV0(nmToUm(wavelengthsNM.real)); // Convert wavelength from nm to μm
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


inline OpticalPathResult OpticalPathDifferenceM(
    C3 wavelengthsNM,
    float3 nSurrounding,
    PathMeasurement measurement,
    float3 dispersionCoeffs = ZERO3,
    float3 absorptionCoeff = ZERO3,
    float3 cosThetaT = ZERO3)
{
    C3 refractiveIndex = RefractiveIndexFromDispersionCoefficients(CV0(nmToM(wavelengthsNM.real)), (dispersionCoeffs));

    PathMeasurement opticalMeasurement =
        CreatePathMeasurement(
            abs(measurement.PathLength) * refractiveIndex.real,
            abs(measurement.PathTotalLength) * refractiveIndex.real,
            (measurement.PathDifference) * refractiveIndex.real);

    C3 phaseDifferenceM = CDiv(CMax(CEPSILON3, CMul(C20, CV0(opticalMeasurement.PathLength))),
    CMax(CV0(nmToM(wavelengthsNM.real)), CEPSILON3));
    
    PhaseInterference pi = OpticalPhaseInterference(CAbs(CV0(nmToM(wavelengthsNM.real))).real, refractiveIndex.real, nSurrounding, opticalMeasurement.PathDifference, cosThetaT);
    
    OpticalPathResult result = CreateOpticalPathResult(
        wavelengthsNM, refractiveIndex.real,
        measurement, opticalMeasurement, pi,
        ComplexCos(phaseDifferenceM),
        exp(-absorptionCoeff * opticalMeasurement.PathDifference)
    );
    return result;
}



inline OpticalPathResult OpticalPathDifferenceNM(
    C3 wavelengthsNM,
    float3 nSurrounding,
    PathMeasurement measurement,
    float3 dispersionCoeffs = ZERO3,
    float3 absorptionCoeff = ZERO3,
    float3 cosThetaT = ZERO3)
{
    C3 refractiveIndex = RefractiveIndexFromDispersionCoefficients(CV0(wavelengthsNM.real), dispersionCoeffs);

    PathMeasurement opticalMeasurement =
        CreatePathMeasurement(
            abs(measurement.PathLength) * refractiveIndex.real,
            abs(measurement.PathTotalLength) * refractiveIndex.real,
            (measurement.PathDifference) * refractiveIndex.real);

    C3 phaseDifference = CDiv(CMax(CEPSILON3, CMul(C20, CV0(opticalMeasurement.PathLength))),
    CMax(CV0(wavelengthsNM.real), CEPSILON3));
    
    PhaseInterference pi = OpticalPhaseInterference(CAbs(CV0(wavelengthsNM.real)).real, refractiveIndex.real, nSurrounding, opticalMeasurement.PathDifference, cosThetaT);
    
    OpticalPathResult result = CreateOpticalPathResult(
        wavelengthsNM, refractiveIndex.real,
        measurement, opticalMeasurement, pi,
        ComplexCos(phaseDifference),
        exp(-absorptionCoeff * opticalMeasurement.PathDifference)
    );
    return result;
}

inline float3 ComplexDistance(C3 a, C3 b)
{
    return ComplexMagnitude(CAbs(ComplexSub(a, b)));
}

inline float3 DistanceFromPoints(C3 point1, C3 point2)
{
    return ComplexDistance(point1, point2);
}

float ComplexLength(C3 a)
{
    return length(CMag(a));
}

inline PathMeasurement DistanceFromViewToAB_NM(C3 pointA_NM, C3 pointB_NM)
{
    float3 d = float3(
        length(DistanceFromPoints(CViewPosNM, pointA_NM)),
        length(DistanceFromPoints(CViewPosNM, pointB_NM)),
        length(DistanceFromPoints(pointA_NM, pointB_NM)));
    return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));
}

inline PathMeasurement DistanceFromViewToAB_M(C3 pointA_NM, C3 pointB_NM)
{
    float3 d = float3(
        nmToM(length(DistanceFromPoints(CViewPosNM, pointA_NM))),
        nmToM(length(DistanceFromPoints(CViewPosNM, pointB_NM))),
        nmToM(length(DistanceFromPoints(pointA_NM, pointB_NM))));
    return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));
}


inline PathMeasurement DifferenceNMPathFromPointThicknessNM(float3 viewPosNM, C3 pixelPosNM, C3 thicknessNM, float3 pixelNormal = ZERO3)
{
    C3 dir = CV0(safeNormalize(CSub(CV0(viewPosNM), pixelPosNM).real));

    float3 distanceFront = ComplexDistance(CV0(viewPosNM), pixelPosNM);
    C3 pixelBackNM = CAdd(pixelPosNM, CMul(dir, CV0(thicknessNM.real)));
    float3 distanceBack = ComplexDistance(CV0(viewPosNM), pixelBackNM);

    float3 d = float3(
        length(DistanceFromPoints(CV0(viewPosNM), pixelPosNM)),
        length(DistanceFromPoints(CV0(viewPosNM), pixelBackNM)),
        length(DistanceFromPoints(pixelPosNM, pixelBackNM)));

    // Corrected: path difference as absolute difference, not distance(distanceBack,distanceFront)
    float3 pathDifferenceNM = abs(distanceBack - distanceFront);

    return CreatePathMeasurement(
        ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * pathDifferenceNM);
}

inline PathMeasurement DifferenceMPathFromPointThicknessNM(float3 viewPosNM, C3 pixelPosNM, C3 thicknessNM, float3 pixelNormal = ZERO3)
{
    PathMeasurement ret = DifferenceNMPathFromPointThicknessNM(viewPosNM, pixelPosNM, thicknessNM, pixelNormal);
    ret.PathDifference = nmToM(ret.PathDifference);
    ret.PathLength = nmToM(ret.PathLength);
    ret.PathTotalLength = nmToM(ret.PathTotalLength);
    return ret;
}

inline float3 CoherenceFactor(float3 opticalPathLength, float3 coherenceLength)
{
    return exp(-pow(abs(opticalPathLength), TWO3) / max(pow(abs(coherenceLength), TWO3), EPSILON3));
}


float3 ApplyReflectanceCoherence(float3 reflectance, OpticalPathResult opd, float coherenceLength)
{
    return reflectance * CoherenceFactor(opd.phaseInterference.opticalPathDifference, coherenceLength);
}
float3 ApplyTransmissionCoherence(float3 transmittance, OpticalPathResult opd, float3 coherenceLength)
{
    // Modulate the transmittance with coherence and path length factors
    return transmittance * CoherenceFactor(opd.phaseInterference.opticalPathDifference, coherenceLength);
}


C3 ComplexQuantumWave(C3 initialField, float2 uv,
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
C3 ComputeVolumetricWaveInterferencePhase(float3 wavelengthsNM, float2 uv, float depth, MaterialSellmeier mat, float parallaxScale, OpticalPathResult opr, float coherenceLengthM)
{
    // Number of propagation steps: higher number yields more accurate simulation.
    const int numSteps = 16;
    
    // Initialize the wave with unit amplitude and zero phase.
    float3 wv = wavelengthsNM;
    C3 wave = CVV(wv);
    
    float3 factor = exp(-(opr.phaseInterference.opticalPathDifference / max(EPSILON, mToNm(coherenceLengthM))) * (opr.phaseInterference.opticalPathDifference / max(EPSILON, mToNm(coherenceLengthM))));
    
    // Wavenumber: k = 2*pi / wavelength.
    // Here we assume a representative wavelength of 550nm (green light) in normalized units.
    float3 k = (6.2831853 * 2.0 * opr.phaseInterference.opticalPathDifference * mat.etaR * mToNm(coherenceLengthM) / max(EPSILON3, wavelengthsNM)) + opr.phaseInterference.totalPhase;
    float3 stepSize = k * DepthScale / numSteps;
    
    // Propagate the wave in numSteps steps.
    for (int i = 0; i < numSteps; i++)
    {
        // Current depth for this step (for absorption calculation)
        float3 currentDepth = stepSize * float(i + 1) * 0.01;
        
        // Compute the phase shift for this step.
        float3 phaseR = sin(k * stepSize);
        float3 phaseI = cos(k * stepSize);
        // Generate the complex phase shift: exp(i * phase).
        C3 phaseShift = CExp(CV(phaseR, phaseI));
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
    C3 displacement = CV0(oscillation);
    
    // Combine the displacement with the propagated wave.
    wave = CAdd(wave, displacement);
    
    return wave;
}


// Convert wavelength from nanometers (nm) to frequency (Hz)
inline C3 nmToHz(C3 nm)
{
    return CDiv(CVV(2.99792458e8), CMax(CV0(nmToM(CAbs(nm).real)), CVVEPSILON3)); // speed of light in m/s divided by wavelength in m
}

// Convert wavelength from meters (m) to frequency (Hz)
inline C3 mToHz(C3 m)
{
    return CDiv(CVV(2.99792458e8), m); // speed of light in m/s divided by wavelength in m
}

C3 ComplexThinFilmInterference(C3 baseField, float2 uv,
                                float3 layerThicknessesNM, float3 refractiveIndices,
                                float3 absorptionCoefficients, C3 wavelengthM)
{
    // Speed of light constant.
    float c = SPEED_OF_LIGHT;

    // Convert wavelength (in nm) to Hz. (Assumes nmToHz1 returns a C3.)
    // Use the real part and clamp with EPSILON.
    float3 frequency = SPEED_OF_LIGHT / max(nmToHz(CV0(mToNm(wavelengthM.real))).real, EPSILON);

    // Calculate the optical path per layer.
    float3 opticalPath = layerThicknessesNM * refractiveIndices;
    
    // Compute phase shifts per layer:
    // phaseShifts = (2π / wavelength) * opticalPath
    float3 phaseShifts = (2.0 * PI * 2.0 * layerThicknessesNM * mToNm(f12) / max(mToNm(wavelengthM.real), EPSILON)) * opticalPath;

    // Compute amplitude attenuation due to absorption.
    float3 absorptionFactors = exp(-absorptionCoefficients * nmToM(layerThicknessesNM));

    // Compute cosine and sine for the phase shifts.
    float3 cosPhase = cos(phaseShifts);
    float3 sinPhase = sin(phaseShifts);

    // Interfere the base field with the computed phase and absorption.
    // Construct a C3 using the real and imaginary parts.
    C3 outField = CV(baseField.real * cosPhase * absorptionFactors,
                      baseField.imag * sinPhase * absorptionFactors);

    // Introduce additional temporal modulation for dynamic effects.
    // Here, the modulation factors are computed on a per-channel basis.
    outField.real = outField.real * (sin(frequency + time * 2.0));
    outField.imag = outField.imag * (cos(frequency - time * 1.5));

    return outField;
}


// Computes a caustic intensity (RGB) based on holographic diffraction effects.
// Parameters:
//   lighting     - lighting structure containing, e.g., NdotL for light incidence
//   uv           - texture coordinate for the current pixel
//   time         - animated time factor
//   parallaxScale- scale factor for spatial offsets
float3 ComputeHolographicCaustics(LightingComplex lighting, float2 uv, float parallaxScale)
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
            float3 sampleIntensity = ((diffuse2D(diffuseMap, uv + SampleDepth(depthMap, uv)
            * oosz * 10 * offset * (SampleDepth(depthMap, uv)
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


float3 CalculateF0(float metallic, float3 dielectricReflectance, float3 metallicReflectance)
{
    // Dielectric reflectance is typically 0.04 for non-metals
    return lerp(dielectricReflectance, metallicReflectance, metallic);
}


inline float3 FresnelTerm(float3 F0, float3 cosTheta)
{
    return F0 + (1.0 - F0) * pow(abs(1.0 - cosTheta), FresnelPower);
}

inline float3 FresnelSchlick(float3 F0, float3 VdotH, float power)
{
    return F0 + (ONE3 - F0) * pow(abs(VdotH), power);
}



float3 FresnelSchlickRoughness(float3 F0, float3 NdotV, float roughness)
{
    // Adjust F0 based on roughness
    F0 = lerp(F0, float3(1.0, 1.0, 1.0), roughness);

    // Fresnel-Schlick formula
    return FresnelTerm(F0, NdotV);
}



inline float3 SchlickGGXGeometry(float3 cosTheta, float k)
{
    return cosTheta / (cosTheta * (1.0 - k) + k);
}


inline float3 GGXDistribution(float alpha, float3 cosTheta)
{
    float3 alpha2 = alpha * alpha;
    float3 denom = cosTheta * cosTheta * (alpha2 - 1.0) + 1.0;
    return alpha2 / (PI * denom * denom);
}

// GGX Distribution for Microfacet Specular
float GGXDistribution(float NdotH, float roughness)
{
    float alpha = roughness * roughness;
    float alpha2 = alpha * alpha;
    float denom = NdotH * NdotH * (alpha2 - 1.0) + 1.0;
    return alpha2 / (PI * denom * denom);
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

inline float3 DistributionGGX(float3 normal, float3 viewDir, float NdotH, float roughness, float nSurrounding, float3 etaR, float3 etaI)
{
    
    // Physics: Complex Fresnel
    C3 eta1 = CV(nSurrounding, etaI); // Real surrounding index
    C3 eta2 = CV(etaR, etaI); // Complex material index
    C3 cosThetaI = CVV(dot(normal, ViewDir)); // Real cosine
    C3 sinThetaI = CVV(sqrt(max(1.0 - cosThetaI.real * cosThetaI.real, EPSILON3)));
    C3 sinThetaT = CDiv(CMul(eta1, sinThetaI), eta2);
    C3 cosThetaT = CVV(sqrt(max(1.0 - sinThetaT.real * sinThetaT.real, EPSILON3)));
    C3 Rs = CDiv(CSub(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)),
                 CAdd(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)));
    C3 Rp = CDiv(CSub(CMul(eta2, cosThetaT), CMul(eta1, cosThetaI)),
                 CAdd(CMul(eta2, cosThetaT), CMul(eta1, cosThetaI)));
    float3 F = saturate(0.5 * (CMag(Rs) * dot(ViewDir, normal) + CMag(Rp)));
    
    // Math: Anisotropic GGX
    float alpha = roughness * roughness;
    //float3 T = TBN[0];
    //float3 B = TBN[1];
    float alphaT = alpha * (dot(HalfDir, normal));
    float alphaB = alpha * (dot(HalfDir, ViewDir));
    float D = alphaT * alphaB / (PI * pow(max(dot(HalfDir, normal) * dot(HalfDir, normal) * (alphaT * alphaB - 1.0) + 1.0, EPSILON),
    2));
    float k = alpha / 2.0;
    float G_i = dot(normal, LightDir) / max(dot(normal, LightDir) * (1.0 - k) + k, EPSILON);
    float G_o = dot(normal, ViewDir) / max(dot(normal, ViewDir) * (1.0 - k) + k, EPSILON);
    float G = saturate(G_i * G_o);
    float3 specular = (D * F * G) / (max(4.0 * dot(normal, LightDir) * dot(normal, ViewDir), EPSILON));
    
    return specular;
}

// Geometry Term (Smith with GGX)
float GeometrySmith(float NdotV, float NdotL, float roughness)
{
    float r = roughness + 1.0;
    float k = (r * r) / 8.0;
    float gv = NdotV / (NdotV * (1.0 - k) + k);
    float gl = NdotL / (NdotL * (1.0 - k) + k);
    return gv * gl;
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

ThinFilmProperties CreateThinFilmProperties(float filmThicknessNM, SellmeierCoefficients filmEta_coeffs)
{
    ThinFilmProperties ret = (ThinFilmProperties) 0;
    ret.filmThicknessNM = filmThicknessNM;
    ret.filmEta_coeffs = filmEta_coeffs;
    ret.filmEta_coeffs.OE1 = filmEta_coeffs.OE1;
    ret.filmEta_coeffs.OE2 = filmEta_coeffs.OE2;
    ret.filmEta_coeffs.OE3 = filmEta_coeffs.OE3;
    return ret;
}




float GeometrySmithVLNf(float3 V, float3 L, float3 N, float roughness)
{
    // Normalize inputs safely
    N = safeNormalize(N);
    L = safeNormalize(L);
    V = safeNormalize(V);

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

MaterialSellmeier CreateMaterialSellmeier(
    SellmeierCoefficients coeff,
    float3 absorptionCoefficient,
    float3 scatteringCoefficient,
    float roughness, float metallic,
    float3 metallicReflectance,
    float3 albedo,
    float thicknessNM,
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
    material.thicknessNM = thicknessNM;
    material.etaR = etaR;
    material.etaI = etaI;
    
    material.dispersionCoefficientsNm2[0] = dispersionCoefficientsD0;
    material.dispersionCoefficientsNm2[1] = dispersionCoefficientsD1;
    material.dispersionCoefficientsNm2[2] = dispersionCoefficientsD2;

    //material.etaO = etaO;
    //material.etaE = etaE;
    material.opticalAxis = opticalAxis;
    material.nSurrounding = nSurrounding;
    //material.polarizationAngle = polarizationAngle;
    material.coherenceLengthM = coherenceLengthM;
    //material.temperatureC = temperatureC;
    //material.density = density;
    //material.thermalConductivity = thermalConductivity;
    //material.elasticModulus = elasticModulus;
    

    return material;
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
                    float3(0.03, 0.01, 0.05), // float3 absorptionCoefficient
                    float3(0.1, 0.1, 0.05), // float3 scatteringCoefficient
                    0.5, // float roughness, 
                    0.8, //float metallic
                    float3(0.8, 0.6, 0.5), // metallic reflectance
                    float3(1, 1, 1), // float3 albedo
                    120.0, // float thicknessM
                    float3(1.768, 1.768, 1.768), // float3 etaR
                    float3(1.2, 1.3, 1.1), // float3 etaI
                    float3(0.15, 0.25, 0.30), // float3 dispersionCoefficientNm2
                    float3(0.25, 0.30, 0.35), // float3 dispersionCoefficientNm2
                    float3(0.40, 0.50, 0.55), // float3 dispersionCoefficientNm2
                    float3(1.768, 1.768, 1.768), // float3 etaO
                    float3(1.748, 1.748, 1.748), // float3 etaE
                    safeNormalize(float3(0.0, 0.0, 1.0)), // float3 opticalAxis
                    1.0, // float nSurrounding
                    1.0, // float polarizationAngle
                    COHERENCE_LENGTH_M, // float coherenceLengthM
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
                    float3(0.01, 0.05, 0.01), // float3 absorptionCoefficient
                    float3(0.05, 0.05, 0.04), // float3 scatteringCoefficient
                    0.15, 0.1, // float roughness, float metallic
                    float3(0.08, 0.09, 0.09), // metallic reflectance
                    float3(1.0, 1.0, 1.0), // float3 albedo
                    1250.0, // float thicknessM
                    float3(2.417, 2.417, 2.417), // float3 etaR
                    float3(1.0, 1.2, 1.2), // float3 etaI
                    float3(0.1, 0.1, 0.1), // float3 dispersionCoefficientNm2
                    float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
                    float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
                    float3(2.417, 2.417, 2.417), // float3 etaO
                    float3(2.407, 2.407, 2.407), // float3 etaE
                    safeNormalize(float3(.0, .0, 1.)), // float3 opticalAxis
                    1.0, // float nSurrounding
                    0.0, // float polarizationAngle
                    COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (1100.0), // float thicknessM
        float3(1.544, 1.544, 1.544), // float3 etaR
        float3(1.144, 1.244, 1.144), // float3 etaI
        float3(0.2, 0.2, 0.2), // float3 dispersionCoefficientNm2
        float3(0.3, 0.3, 0.3), // float3 dispersionCoefficientNm2
        float3(0.4, 0.4, 0.4), // float3 dispersionCoefficientNm2
        float3(1.544, 1.544, 1.544), // float3 etaO
        float3(1.534, 1.534, 1.534), // float3 etaE
        safeNormalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0002, // float nSurrounding
        1.0, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (3150.0), // float thicknessM
        float3(1.576, 1.576, 1.576), // float3 etaR
        float3(1.0, 1.0, 1.0), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.576, 1.576, 1.576), // float3 etaO
        float3(1.566, 1.566, 1.566), // float3 etaE
        safeNormalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.2, // float nSurrounding
        0.8, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (2200.0), // float thicknessM
        float3(1.452, 1.452, 1.452), // float3 etaR
        float3(1.0, 1.0, 1.0), // float3 etaI
        float3(0.12, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.452, 1.452, 1.452), // float3 etaO
        float3(1.442, 1.442, 1.442), // float3 etaE
        safeNormalize(float3(0.0, 0.0, 1.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.5, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (3150.0), // float thicknessM
        float3(1.540, 1.540, 1.540), // float3 etaR
        float3(1.1540, 1.1540, 1.1540), // float3 etaI
        float3(0.1, 0.2, 0.3), // float3 dispersionCoefficientNm2
        float3(0.2, 0.3, 0.4), // float3 dispersionCoefficientNm2
        float3(0.3, 0.4, 0.5), // float3 dispersionCoefficientNm2
        float3(1.540, 1.540, 1.540), // float3 etaO
        float3(1.530, 1.530, 1.530), // float3 etaE
        safeNormalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (6100.0), // float thicknessM
        float3(1.658, 1.658, 1.658), // float3 etaR (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaI (extraordinary index)
        float3(0.1, 0.15, 0.2), // float3 dispersionCoefficientNm2
        float3(0.2, 0.25, 0.3), // float3 dispersionCoefficientNm2
        float3(0.3, 0.35, 0.4), // float3 dispersionCoefficientNm2
        float3(1.658, 1.658, 1.658), // float3 etaO (ordinary index)
        float3(1.486, 1.486, 1.486), // float3 etaE (extraordinary index)
        safeNormalize(float3(0.0, 0.0, 1.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.8, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
        (4100.0), // float thicknessM
        float3(1.377, 1.377, 1.377), // float3 etaR
        float3(1.393, 1.393, 1.393), // float3 etaI
        float3(0.10, 0.15, 0.20), // float3 dispersionCoefficientNm2
        float3(0.15, 0.20, 0.25), // float3 dispersionCoefficientNm2
        float3(0.20, 0.25, 0.30), // float3 dispersionCoefficientNm2
        float3(1.377, 1.377, 1.377), // float3 etaO
        float3(1.393, 1.393, 1.393), // float3 etaE
        safeNormalize(float3(0.0, 1.0, 0.0)), // float3 opticalAxis
        1.0, // float nSurrounding
        0.0, // float polarizationAngle
        COHERENCE_LENGTH_M, // float coherenceLengthM
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
                (1500.0), // float thicknessM
                float3(1.53, 1.53, 1.53), // float3 etaR
                float3(1.53, 1.53, 1.53), // float3 etaI
               
                    float3(0.02, 0.03, 0.02), // float3 dispersionCoefficientNm2
                    float3(0.15, 0.26, 0.15), // float3 dispersionCoefficientNm2
                    float3(0.29, 0.29, 0.29), // float3 dispersionCoefficientNm2
                float3(1.53, 1.53, 1.53), // float3 etaO
                float3(1.53, 1.53, 1.53), // float3 etaE
                safeNormalize(float3(0.0, 0.0, -1.0)), // float3 opticalAxis
                1.0, // float nSurrounding
                0.0, // float polarizationAngle
                COHERENCE_LENGTH_M, // float coherenceLengthM
                22.0, // float temperatureC
                float3(1200.0, 1200.0, 1200.0), // float3 density
                float3(0.25, 0.25, 0.25), // float3 thermalConductivity
                float3(2.3, 2.3, 2.3) // float3 elasticModulus
            );
            }
            break;
    }
    
    return ret;

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
    float3 halfDir = safeNormalize(lightDir + viewDir);

    // Fresnel-Schlick approximation
    float NdotH = saturate(dot(normal, halfDir));
    float3 Fresnel = FresnelSchlickRoughness(F0, NdotH, roughness);
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    // GGX Normal Distribution Function
    float3 NDF = DistributionGGX(normal, viewDir, saturate(dot(normal, halfDir)), roughness, mat.nSurrounding, mat.etaR, mat.etaI);

    // Geometry (Smith) function
    float G = GeometrySmithNVLf(normal, viewDir, lightDir, roughness);

    // Denominator for Cook-Torrance BRDF
    float3 denominator = 4.0 * NdotV * saturate(dot(normal, lightDir)) + EPSILON;

    // Cook-Torrance BRDF
    return (NDF * G * Fresnel) / denominator;
}


// --- Function for Basic Sheen Calculation ---
float3 CalculateBasicSheen(float3 normal, float3 lightDir, float3 viewDir, float roughness, float3 sheenAlbedoTint)
{
    // Compute the half vector
    float3 halfDir = safeNormalize(lightDir + viewDir);

    // Dot products
    float NdotH = saturate(dot(normal, halfDir));
    float LdotH = saturate(dot(lightDir, halfDir));

    // Adjust roughness for wider sheen
    float sheenRoughness = roughness * SHEEN_ROUGHNESS_MULTIPLIER;
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    // GGX microfacet distribution for sheen
    float3 sheenDistribution = DistributionGGX(normal, viewDir, NdotH, sheenRoughness, mat.nSurrounding, mat.etaR, mat.etaI);

    // Fresnel term (Schlick's approximation)
    float3 sheenFresnel = 0.04 + (1.0 - 0.04) * pow(1.0 - LdotH, 5.0); // More realistic Fresnel

    // Combine sheen components
    return sheenAlbedoTint * sheenDistribution * sheenFresnel;
}

C3 FresnelComplex(C3 ior, float3 normal, float3 lightDir)
{
    // Cosine of the incident angle
    float cosThetaI = saturate(dot(normal, normalize(lightDir)));
    
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


inline C3 CalculateFresnelReflectance(C3 eta, float3 normal, float3 lightDir, out C3 transmittance)
{
    // Calculate Fresnel reflectance using the complex refractive index
    C3 fresnelReflectance = FresnelComplex(eta, normal, lightDir);

    // Calculate Fresnel transmittance (1 - reflectance) for complex numbers
    transmittance = CSub(C10, fresnelReflectance);

    // Return the reflectance
    return AdjustGamma(CSat(fresnelReflectance), Gamma);
}

// --- Function for Advanced Sheen with Anisotropy ---
float3 CalculateAdvancedSheen(float3 normal, float3 lightDir, float3 viewDir, float3 tangent, float roughness, float3 sheenAlbedoTint)
{
    float3x3 tbn = CalcTBN(normal);
    float3 halfDir = safeNormalize(lightDir + viewDir);
    float NdotH = saturate(dot(normal, normalize(halfDir)));
    float LdotH = saturate(dot(lightDir, halfDir));

    // Anisotropic GGX distribution for sheen
    float3 H = safeNormalize(halfDir);
    float3 X = safeNormalize(tangent);
    float3 Y = cross(normal, tangent);
    float dotHX = saturate(dot(H, X));
    float dotHY = saturate(dot(H, Y));
    float aniso = ADVANCED_SHEEN_ANISOTROPY;
    float roughnessLong = roughness * (1.0 + aniso);
    float roughnessShort = roughness * (1.0 - aniso);
    float3 D = AnisotropicDistributionGGX(NdotH, dotHX, dotHY, roughnessLong, roughnessShort);

    // Fresnel term
    float3 F = pow(1.0 - LdotH, ADVANCED_SHEEN_POWER);

    return sheenAlbedoTint * D * F;
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


// --- Function for Clear Coat Fresnel ---
float3 ClearCoatFresnel(float3 NdotV)
{
    // Simplified Schlick Fresnel approximation for the clear coat layer
    return 0.04 + (1.0 - 0.04) * pow(1.0 - NdotV, 5.0);
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
    float3x3 tbn = CalcTBN(normal);
    // Dot products
    float NdotV = saturate(dot(normal, normalize(viewDir)));
    float NdotL = saturate(dot(normal, normalize(lightDir)));
    float NdotH = saturate(dot(normal, normalize(H)));
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


AnisotropicRoughness CreateAnisotropicRoughness(float alphaX, float alphaY)
{
    AnisotropicRoughness ret = (AnisotropicRoughness) 0;
    ret.alphaX = alphaX;
    ret.alphaY = alphaY;
    return ret;
}


// Compute Fresnel Reflectance for Each Color Channel
//cosThetaI: Cosine of the angle between the normal and the view direction for each RGB channel.
//etaR : Real part of the refractive index for each RGB channel.
//etaI : Imaginary part of the refractive index for each RGB channel(ignored in this reflectance calculation but can be used for absorption).
C3 FresnelReflectanceFromComplex(C3 cosThetaI, C3 eta)
{
    //
    // 1) sin^2 θ_i = 1 - cos^2 θ_i
    //
    C3 cos2 = CMul(cosThetaI, cosThetaI); // cos^2 θ_i
    C3 one = C11; // (1.0 + i·0) per‐channel
    C3 minusCos2 = CSub(one, cos2); // 1 - cos^2 θ_i
    C3 sin2i = CMax(minusCos2, C00); // clamp to ≥ 0 on real part
    C3 sinTi = CSqrt(sin2i); // √(sin^2 θ_i)

    //
    // 2) Snell’s law: sin θ_t = sin θ_i / η
    //
    C3 sinT = CDiv(sinTi, eta);

    //
    // 3) cos^2 θ_t = 1 - sin^2 θ_t,  then cos θ_t = √(…)
    //
    C3 sin2T = CMul(sinT, sinT);
    C3 minusSin2T = CSub(one, sin2T); // 1 - sin^2 θ_t
    C3 cosT = CSqrt(minusSin2T);

    //
    // 4) Build the numerator/denominator for r_s and r_p:
    //    r_s = (η·cosθ_i - cosθ_t) / (η·cosθ_i + cosθ_t)
    //    r_p = (η·cosθ_t - cosθ_i) / (η·cosθ_t + cosθ_i)
    //
    C3 etaCosI = CMul(eta, cosThetaI);
    C3 num_s = CSub(etaCosI, cosT);
    C3 den_s = CAdd(etaCosI, cosT);
    C3 r_s = CDiv(num_s, den_s);

    C3 etaCosT = CMul(eta, cosT);
    C3 num_p = CSub(etaCosT, cosThetaI);
    C3 den_p = CAdd(etaCosT, cosThetaI);
    C3 r_p = CDiv(num_p, den_p);

    //
    // 5) Reflectance magnitude² for each channel:
    //    Rs = |r_s|²,   Rp = |r_p|²
    //
    C3 Rs_cplx = CV0(CMagSq(r_s));
    C3 Rp_cplx = CV0(CMagSq(r_p));
    //
    // 6) Unpolarized reflectance:  (Rs + Rp) * 0.5
    //
    C3 sumRsRp = CAdd(Rs_cplx, Rp_cplx);

    C3 Rout = CMul(sumRsRp, Cp5);

    return Rout;
}

float3 F_Schlick(float3 F0, float VdotH)
{
    // Original Schlick: F0 + (1.0 - F0) * pow(1.0 - VdotH, 5.0)
    // Optimized version (spherical Gaussian approximation, often used for performance and good results)
    // Also, F90 (reflectivity at 90 degrees grazing angle) is often clamped to 1.0 for typical materials.
    float factor = pow(1.0f - saturate(VdotH), FresnelPower);
    return F0 + (max(F0, float3(1.0f, 1.0f, 1.0f)) - F0) * factor; // Ensure F90 is at least F0, typically 1.0
    // A common variation for F90 = 1.0:
    // return F0 + (1.0f - F0) * factor;
}
// NdotH: Dot product between surface normal and halfway vector.
// roughness: Material roughness value [0,1].
float D_GGX(float NdotH, float roughness)
{
    float alpha = roughness * roughness; // Perceptual roughness to alpha
    float alphaSq = alpha * alpha;
    float NdotHSq = NdotH * NdotH;

    float denominator = (NdotHSq * (alphaSq - 1.0f) + 1.0f);
    denominator = PI * denominator * denominator; // Denominator must be non-zero

    return alphaSq / max(denominator, EPSILON); // EPSILON to prevent division by zero
}

float G_Smith_GGX_Correlated_Term(float NdotW, float roughness)
{
    // Ensure NdotW is non-negative for stability with the formula
    NdotW = max(NdotW, EPSILON); // EPSILON is a small float like 1e-5 or smaller

    float alpha = roughness * roughness; // Remap roughness to alpha
    float alphaSq = alpha * alpha;
    float NdotWSq = NdotW * NdotW;

    // The Smith GGX Correlated (or "height-correlated Smith") formula:
    // Vis = 2 * NdotW / (NdotW + sqrt(alphaSq + (1 - alphaSq) * NdotWSq))
    // This is generally more robust and physically plausible than the non-correlated version.
    return (2.0f * NdotW) / (NdotW + sqrt(alphaSq + (1.0f - alphaSq) * NdotWSq));
}

// G_Smith: Combines the geometry terms for both view and light directions.
float G_Smith(float NdotV, float NdotL, float roughness)
{
    // Calculate the geometry term for the view direction
    float G_V = G_Smith_GGX_Correlated_Term(NdotV, roughness);
    
    // Calculate the geometry term for the light direction
    float G_L = G_Smith_GGX_Correlated_Term(NdotL, roughness);
    
    // The combined Smith geometry term
    return G_V * G_L;
}


struct SpecularResult{
    float3 Value;
    C3 FresnelReflectance;
    float GeometrySmithResultG;
    float GGXResultD;
    C3 cosThetaI;
};

// ----------------------------------------------------------------------------------
// 2) float3 Specular(...)
// ----------------------------------------------------------------------------------
// A Cook–Torrance / GGX specular BRDF that uses our wavelength‐dependent C3 Fresnel.
// Replaces your original “SpecularPower*NdotV” term with the canonical (4 N·L N·V).
SpecularResult Specular(float3 N, float3 V, float3 L, MaterialSellmeier mat)
{
    SpecularResult result = (SpecularResult)0;

    // 1) Compute half-vector
    float3 H = normalize(V + L); // Use normalize, safeNormalize should only be used if V+L could be zero vector
    float3x3 tbn = CalcTBN(N);

    // 2) Dot products (all clamped to [0,1])
    float NdotH = saturate(dot(N, normalize(H)));
    float NdotV = saturate(dot(N, normalize(V)));
    float NdotL = saturate(dot(N, normalize(L)));
    float VdotH = saturate(dot(V, H));

    // Numerical stability for dot products in denominators
    NdotV = max(NdotV, 1e-10);
    NdotL = max(NdotL, 1e-10);
    result.GGXResultD = D_GGX(NdotH, mat.roughness);

    // 4) Smith geometry term
    // Using the G_Smith function from your previously prov`ided code
    result.GeometrySmithResultG = G_Smith(NdotV, NdotL, mat.roughness);

    result.cosThetaI = C0V(-pow(NdotV,2.0));
    C3 etaC = CV(mat.etaR-1., mat.etaI-1.);

    // Compute complex Fresnel reflectance
    result.FresnelReflectance = FresnelReflectanceFromComplex(result.cosThetaI, etaC);
    float3 F = CMag(CMul(CVV((1.0-VdotH)*(1.0-SampleDiffuse(diffuseMap, InputUV))),result.FresnelReflectance));

    // 6) Cook–Torrance denominator = 4 * N·L * N·V
    float denom = 4.0 * NdotL * NdotV;

    // 7) Final specular = (D * G * F) / denom
    // This is the core microfacet specular equation.
    float3 spec = (result.GGXResultD * result.GeometrySmithResultG * F) / denom;

    // 8) Scale by your SpecularIntensity factor
    spec *= SpecularIntensity;

    // 9) Clamp final result to [0,1]
    result.Value = spec;
    return result;
}
MaterialProperties MaterialPropertiesFromMaterialSellmeier(MaterialSellmeier mat)
{
    MaterialProperties material = (MaterialProperties) 0;
    material.coeff.B = mat.coeff.OE1.O.B;
    material.coeff.B = mat.coeff.OE1.O.C;
    material.k = mat.nSurrounding;
    material.thicknessNM = mat.thicknessNM;
    material.absorptionM = mat.absorptionCoefficient;
    material.wavelengthsNM = CV0(RGBToWavelengthsNM(mat.albedo));
    material.transmissionCoefficient = mat.metallic;
    return material;
}


void CreateThinFilms(inout ThinFilmProperties thinFilms[MAX_GRATING_LAYERS])
{
    thinFilms[0] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 200, 0.012);
    thinFilms[1] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 12, 0.01);
    thinFilms[2] = SELLMEIER_THIN_FILM_PROPERTY(1.75, 200, 0.03);
    thinFilms[3] = SELLMEIER_THIN_FILM_PROPERTY(2.5, 406, 0.001);
    thinFilms[4] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 20, 0.012);
    thinFilms[5] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 12, 0.001);
    thinFilms[6] = SELLMEIER_THIN_FILM_PROPERTY(1.75, 102, 0.03);
    thinFilms[7] = SELLMEIER_THIN_FILM_PROPERTY(2.5, 600, 0.001);
    thinFilms[8] = SELLMEIER_THIN_FILM_PROPERTY(1.5, 20, 0.012);
    thinFilms[9] = SELLMEIER_THIN_FILM_PROPERTY(1.25, 12, 0.001);
}

C3 PhaseDifference(C3 wavelengthNM, C3 thicknessNM, C3 coherenceLengthNM, float3 eta, float3 cosTheta)
{
    return CAdd(CMul(CDiv(CMul(CMul(C2PI0, CMul(C20, thicknessNM)), CV0(eta * cosTheta)), CMul(coherenceLengthNM , CV0(float3(GetModulation(GetGradient(InputUV)), DepthScale)))), wavelengthNM), CV0(time));
}



C3 InterferenceThinFilmComplex(float2 inputUV, float3 wavelengthsNM, float3 thicknessNM, float3 eta, float3 cosTheta, float3 nSurrounding, float coherenceLengthNM)
{
    C3 R = CVV((eta - nSurrounding) / (eta + nSurrounding)); // Reflection coefficient (simplified)
    
    C3 phaseDiff = PhaseDifference(CV0(wavelengthsNM), CV0(thicknessNM), CV0(coherenceLengthNM), eta, cosTheta);
    C3 amplitude = ComplexSqrt(CAdd(CAdd(CMul(R, R), CMul(CSub(CV0(1.0),R), CSub(CV0(1.0), R))), CMul(CMul(CMul(CV0(2.0), R), CSub(CV0(1.0), R)), CCos(phaseDiff))));
    float3 phase = atan2(CMul(CMul(CV0(-1), R), CSin(phaseDiff)).real, CSub(CV0(1.0), CMul(CV0(-1), CMul(R, CCos(phaseDiff)))).real);

    return CV(CMag(amplitude) * cos(phase), CMag(amplitude) * sin(phase));
}



inline C3 SpecularTransmission(
    float2 inputUV,
    float coherenceLengthM,
    float3 eta_ratio, // Real part of the refractive index ratio (η)
    float3 k_ratio, // Imaginary part (absorption factor, k)
    float3 cosThetaT, // Cosine of the transmitted angle
    C3 wavelengthsNM, // Wavelengths in nanometers
    float thicknessNM, // Film thickness (in meters)
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
    float3 absorption = exp(-4.0f * k_ratio * nmToM(thicknessNM) * depth);
    
    // Compute interference from thin-film effects.
    // Convert wavelengths from nanometers to meters.
    
    C3 interference = InterferenceThinFilmComplex(inputUV, wavelengthsNM.real, thicknessNM, eta_ratio, cosThetaT, ONE3 * 1.0f, mToNm(coherenceLengthM));
    
    // Final specular transmission is the product of transmission,
    // absorption, and the interference modulation.
    C3 transmission = ComplexMul(CMul(T, interference), CVV(absorption));
    
    return transmission;
}



C3 FresnelMicrofacet(
    float2 inputUV,
    float3 viewDirection,
    float3 lightDirection,
    float3 microfacetNormal,
    MaterialSellmeier mat,
    MaterialProperties material,
    AnisotropicRoughness roughness,
    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS],
    int numThinFilms,
    
    float sssStrength, float3 scatteringCoefficient, float3 absorptionCoefficient,
    float3 dispersionCoefficient, float thicknessNM, bool invertDepth, bool useProjectedDepth)
{
    float3 V = safeNormalize(viewDirection);
    float3 L = safeNormalize(lightDirection);
    float3 N = safeNormalize(microfacetNormal);
    float3 H = safeNormalize(V + L);

    float cosTheta = saturate(dot(N, V));

    float3 eta_i = mat.etaI; // Incoming
    float3 eta_t = mat.etaR; // Transmission

    float3 eta_ratio = eta_i / eta_t;
    float3 k_ratio = material.k / max(material.k, EPSILON3);

    float3 sinThetaT = eta_ratio * sqrt(1.0f - cosTheta * cosTheta);
    float3 TIR = step(1.0f, sinThetaT); // Total internal reflection flag

    C3 F = FresnelComplex(eta_ratio, k_ratio, cosTheta, sqrt(1.0f - sinThetaT * sinThetaT));
    C3 transmission = SpecularTransmission(
        inputUV, mat.coherenceLengthM, eta_ratio, k_ratio, sqrt(1.0f - sinThetaT * sinThetaT),
        material.wavelengthsNM, thicknessNM, SampleDepth(depthMap, inputUV), material.coeff);

    return CSat(CMul(transmission, CAdd(CV((1.0f - TIR), ZERO3), CMul(F, CVV(TIR)))));
}


C3 MicrofacetBRDF1(
    C3 diffuseColor,
    C3 sssColor,
    MaterialSellmeier mat,
    float2 inputUV,
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
    float3 H = safeNormalize(viewDir + lightDir);
   
    // GGX Distribution
    float3 ggxDistribution = DistributionGGX(normal, viewDir, dot(normal, normalize(H)), roughness.alphaX * roughness.alphaY, mat.nSurrounding, mat.etaR, mat.etaI);
    
    // Fresnel Term
    MaterialProperties material = MaterialPropertiesFromMaterialSellmeier(mat);

    ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];
    CreateThinFilms(thinFilms);
    float scatteringCoef = 0.4;
    
    C3 fresnelTerm = FresnelMicrofacet(
        inputUV, viewDir, lightDir, normal, mat, material, roughness, thinFilms, MAX_GRATING_LAYERS,
        sssStrength, scatteringCoef, mat.absorptionCoefficient,
        mat.dispersionCoefficientsNm2[dispersionIndex], nmToM(thicknessNM).x, invertDepth, useProjectedDepth);

    // Final BRDF
    C3 brdf = CMul(CV(materialSpecularColor * ggxDistribution, ZERO3), fresnelTerm);
    return CSat(brdf);
}



inline C3 CalculateMicrofacetSpecular(LightingComplex lighting, MaterialSellmeier mat, float3 albedo, int dispersionIndex, float2 inputUV, bool invertDepth, bool useProjectedDepth, float sssStrength, float3 nSurrounding)
{
    return
        MicrofacetBRDF1(CV0(albedo), CV0(lighting.albedo), mat, inputUV, albedo, lighting.normal, lighting.viewDir, lighting.lightDir, invertDepth, useProjectedDepth, nSurrounding, CV(mat.etaR, mat.etaI), mat.thicknessNM, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength);
}

inline C3 CalculateMicrofacetSpecular(LightingComplex lighting, MaterialSellmeier mat, float3 albedo, int dispersionIndex, float2 inputUV, bool invertDepth, bool useProjectedDepth, float sssStrength)
{
    return
        MicrofacetBRDF1(CV0(albedo), CV0(lighting.albedo), mat, inputUV, albedo, lighting.normal, lighting.viewDir, lighting.lightDir, invertDepth, useProjectedDepth, mat.etaI, CV(mat.etaR, mat.etaI), mat.thicknessNM, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength);
}

inline C3 CalculateDiffuseTransmittance(
    float2 inputUV,
    int dispersionIndex,
    LightingComplex lighting,
    MaterialSellmeier mat,
    float sssStrength,
    float3 baseDiffuseTex,
    C3 fresTransmittance
)
{
    return
        
            CMul(CMul(
                CV(baseDiffuseTex, ZERO3),
                CSat(fresTransmittance))
                ,
                
                    CMul(CMul(MicrofacetBRDF1(CV(lighting.albedo, ZERO3), CV(lighting.albedo, ZERO3), mat, inputUV, lighting.albedo, lighting.normal, lighting.viewDir, lighting.lightDir, lighting.invertDepth, lighting.useProjectedDepth, lighting.nSurrounding, CV(mat.etaR, mat.etaI), mat.thicknessNM, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength), CV(lighting.albedo, ZERO3)), CV(lighting.NdotV3 * sssStrength, ZERO3))
                );
}


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
        
    // === Configuration & Global Weights ===
    // (These values can be tuned for greater interference/diffraction emphasis.)
    lighting.Config_Saturation = saturation;
    lighting.Config_Gamma = gamma;
    lighting.Config_Exposure = exposure;
    lighting.useProjectedDepth = useProjectedDepth;
    lighting.invertDepth = invertDepth;
    lighting.fDepthScale = depthScale;
    lighting.coherenceLengthM = mat.coherenceLengthM;
    
    // === Geometry, Depth, and TBN Calculation ===
    lighting.depth = SampleDepth(depthMap, inputUV);
    lighting.pixelPos = float3(inputUV, lighting.depth);
    lighting.lightPos = lightPos;
    lighting.viewPos = viewPos;
    
    lighting.normal = calcNormal(depthMap, inputUV);
    lighting.nSurrounding = mat.nSurrounding;
    
    // === Tangent Space Directions ===
    float3 viewWorld = normalize(lighting.viewPos - lighting.pixelPos);
    lighting.viewDir = viewWorld;
    lighting.lightDir = normalize((lighting.lightPos - lighting.pixelPos) + EPSILON3);
    lighting.halfDir = normalize((lighting.viewDir + lighting.lightDir) + EPSILON3);
  
    // === Dot Products for Shading ===
    lighting.NdotV3 = saturate(dot(lighting.viewDir, lighting.normal));
    lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));
    lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));
    lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));
    lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
    
    
    // === Base Diffuse and Albedo Setup ===
    float3 baseDiffuse = mat.albedo * diffuse2D(diffuseMap, inputUV).rgb;
    lighting.albedo = baseDiffuse;
    lighting.material = mat;
    lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);
    lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);
    
    lighting.ggxDistribution = GGXDistribution(lighting.HdotN, mat.roughness);
    
    lighting.iridescenceO = Iridescence(inputUV, lighting.viewDir, lighting.normal, lighting.albedo, mat.thicknessNM, mat, ONE3 * mat.nSurrounding, true);
    lighting.iridescenceE = Iridescence(inputUV, lighting.viewDir, lighting.normal, lighting.albedo, mat.thicknessNM, mat, ONE3 * mat.nSurrounding, false);
    lighting.opticalAxis = mat.opticalAxis;
    lighting.nSurrounding = ONE3 * mat.nSurrounding;
    
    
    lighting.eta_ratio = mat.nSurrounding / mat.etaR; // assuming these are per-channel
    lighting.k_ratio = mat.absorptionCoefficient / max(mat.absorptionCoefficient, EPSILON3); // if you use a complex absorption term

// Compute cosine of the incident angle:
    lighting.cosTheta = saturate(dot(lighting.normal, lighting.viewDir));

    float3 sinThetaI = sqrt(max(ONE3 - lighting.cosTheta * lighting.cosTheta, EPSILON3));
    float3 sinThetaT = lighting.eta_ratio * sinThetaI;
    float3 cosThetaT = sqrt(max(ONE3 - sinThetaT * sinThetaT, EPSILON3));
    lighting.F_complex = FresnelComplex(lighting.eta_ratio, lighting.k_ratio, lighting.cosTheta, cosThetaT);
    
    //C3 F_complex = FresnelComplex(mat.nSurrounding / mat.etaR, mat.absorptionCoefficient, saturate(dot(lighting.normal, lighting.viewDir)), sqrt(max(ONE3 - (1.0 - saturate(dot(lighting.normal, lighting.viewDir))) * (1.0 - saturate(dot(lighting.normal, lighting.viewDir))), EPSILON3)));
    
    // === Dispersion, Optical Axis & Polarization Setup ===
    // Simulate dispersion via slight RGB shifts – ideal for meta-materials.
    lighting.dispersionFactor = lerp(float3(1.0, 1.0, 1.0),
                                   float3(0.95, 1.0, 1.05),
                                   (lighting.NdotL3));
    
    lighting.n_o = CalculateRefractiveIndex(CV0(lighting.albedoWavelengthsNM), mat.coeff);
    
    
      
    lighting.cosThetaOptic = CV0(saturate(dot(lighting.lightDir, mat.opticalAxis)));
    
    lighting.n_e_effective = clamp((lighting.n_o + .5 + .5 * lighting.NdotL3) * CMul(lighting.cosThetaOptic, lighting.cosThetaOptic).real, ONE3, ONE3 * 2.5);
    
    lighting.etaR_wavelength = max(1.0 + max(0, lighting.n_e_effective * lighting.dispersionFactor * lighting.material.etaR), 1.);

    lighting.etaI_wavelength = max(1.0 + max(0, lighting.n_o * lighting.dispersionFactor * lighting.material.etaI), 1.);
  
    lighting.R0 = FresnelReflectanceFromFilm2(lighting.etaR_wavelength, lighting.etaI_wavelength, abs(dot(ViewDir, lighting.normal)), lighting.cosThetaTR0);
    
    lighting.R1 = FresnelReflectanceFromFilm2(lighting.etaI_wavelength, lighting.etaR_wavelength, abs(dot(ViewDir, HalfDir)), lighting.cosThetaTR1);
    
    // === Optical Path & Film Interference ===
    PathMeasurement pathMeasurement = DifferenceNMPathFromPointThicknessNM(ViewPosNM, CV0(PixelWorldNM), CV0(mat.thicknessNM), lighting.normal);
    
    OpticalPathResult opticalPathDiff = OpticalPathDifferenceNM(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, pathMeasurement, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, lighting.cosThetaTR1.real);
    
    
    
    
    // === Advanced Holographic Volumetric Wave Interference ===
    // Here we simulate volumetric wave interference by summing coherent wavefronts,
    // incorporating phase delays, diffraction, and even quantum phase shifts.
   
    lighting.waveInterference = ComputeVolumetricWaveInterferencePhase(lighting.albedoWavelengthsNM, inputUV, Depth, mat, parallaxScale, opticalPathDiff, lighting.coherenceLengthM);
    
    // === Holographic Caustics & Diffraction Patterns ===
    // Compute shimmering, volumetric caustics that result from diffraction through meta-surfaces.
   
    C3 caustics = CV0(ComputeHolographicCaustics(lighting, inputUV, parallaxScale));
    
    
    
    // === Thin Film Interference & Quantum Phase Shifts ===
    // Compute phase shifts for both ordinary and extraordinary rays,
    // incorporating complex quantum interference and thin-film effects.
    
    lighting.LdotA = abs(dot(mat.opticalAxis, lighting.lightDir));
    
    lighting.qwave = CAdd(lighting.waveInterference, ComplexQuantumWave(CVV(lighting.albedo), inputUV, (.5 + .5 * sin(time * 3)) * 0.2 + 0.4, cos(time), lighting.LdotA));
    
    lighting.phaseShift_o = ComplexThinFilmInterference(CAdd(lighting.waveInterference, lighting.qwave), inputUV, mat.thicknessNM, mat.etaR, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM)
    );
    lighting.phaseShift_e = ComplexThinFilmInterference(
        CAdd(CVV(0.1 * CMag(lighting.waveInterference)), CMul(CVV(0.01), lighting.qwave)),
        inputUV, mat.thicknessNM, mat.etaI, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM)
    );
    // Blend phase shifts based on the depth-dependent polarization.
    lighting.phaseShift = ComplexLerp(lighting.phaseShift_o, lighting.phaseShift_e, CVV(lighting.NdotV3));
    
    // === Holographic Microfacet Specular with Polarization ===
    // Compute a complex specular term using a holographic microfacet model,
    // incorporating polarization effects via complex Fresnel and geometry terms.
    lighting.D_complex = MicrofacetDistribution_Complex(lighting.normal, lighting.halfDir, mat.roughness);
    lighting.G_complex = GeometrySmith_ComplexCombined(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness);
    
    
    lighting.spec_complex = CMul(CMul(lighting.D_complex, lighting.G_complex), lighting.F_complex);
    lighting.complexSpecular = CAbs(lighting.spec_complex).real;
    lighting.complexSpecular = lighting.complexSpecular * lighting.complexSpecular; // Bring into Cook–Torrance units.
    
    lighting.metallicReflectance = 0.2;
    
    // Blend traditional Cook–Torrance specular with our holographic specular.
    lighting.cookTorrenceSpecular = lerp(
        CookTorranceSpecularPBR(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness,
                                CalculateF0(mat.metallic, float3(0.04, 0.04, 0.04), lighting.metallicReflectance), mat.metallic),
        lighting.complexSpecular, 0.5
    );
    
    lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
    //float3 tangent = lighting.TBNf[0];
    lighting.advancedSheen = CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, cross(lighting.viewDir,float3(0,1,0)), mat.roughness, SHEEN_ALBEDO_TINT);
    lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) +
                               DistributionGGX(lighting.normal, lighting.viewDir, lighting.HdotN, mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER, mat.nSurrounding, mat.etaR, mat.etaI) * ClearCoatFresnel(lighting.NdotV3);
    
    lighting.specularWithSheen =
        lerp(
            lighting.VdotH * lighting.cookTorrenceSpecular +
            lighting.HdotL * lighting.iridescenceO +
            lighting.HdotN * lighting.sheen +
            lighting.NdotL3 * lighting.iridescenceE +
            lighting.LdotA * lighting.advancedSheen, 0, 0.5);
    
    
    lighting.microfacetRoughness = mat.roughness.xx;
    lighting.ggxDistributionTerm = DistributionGGX(lighting.normal, lighting.viewDir, max(0, dot(lighting.normal, lighting.halfDir)), lighting.microfacetRoughness.x, mat.nSurrounding, mat.etaR, mat.etaI);
    lighting.smithGeometryTerm = GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x);
    lighting.microfacetDenominator = max(abs((float3(2.0, 2.0, 2.0) + lighting.normal) * lighting.NdotV3), float3(EPSILON3));

    lighting.microfacetSpecularTerm = saturate((lighting.ggxDistributionTerm * lighting.smithGeometryTerm) / lighting.microfacetDenominator);
    
    
    lighting.n_real = CalculateRefractiveIndex(CVV(lighting.albedoWavelengthsNM), mat.coeff);

    
    lighting.refPol = CalculateReflectedTransmittedPolarization(lighting.nSurrounding, mat.etaR, -lighting.lightDir, lighting.normal, lighting.cosThetaTR0.real);
    

    lighting.compositeSpecular = C0V(CSat(CMul(lighting.refPol,
        CV0(lighting.NdotL3 * lighting.specularWithSheen + lighting.clearCoatSpecular * lighting.VdotH + lighting.iridescenceO * lighting.HdotN))).real);
    
    SpecularResult spec = Specular(
        lighting.normal, lighting.viewDir, lighting.lightDir, mat);
        
    lighting.specularContribution = CV0(spec.Value * lighting.microfacetSpecularTerm);

    lighting.F0 = pow(1.0 - saturate(lighting.NdotL3), FresnelPower);
   
    
    lighting.reflectance = CalculateFresnelReflectance(CV0(lighting.etaR_wavelength), lighting.normal, lighting.lightDir, lighting.transmittance);
    
    lighting.filmReflectedPolarization = CSat(
        CV(
            ApplyReflectanceCoherence(
                CMul(lighting.reflectance, lighting.compositeSpecular).real,
                    opticalPathDiff, lighting.coherenceLengthM),
            ApplyReflectanceCoherence(
                CMul(lighting.reflectance, lighting.compositeSpecular).imag,
                    opticalPathDiff, lighting.coherenceLengthM)
        )
    );
   
    PathMeasurement viewToPixel = DistanceFromViewToAB_NM(
        CV0(PixelWorldNM),
        CV0(PixelWorldNM + lighting.normal * mat.thicknessNM));
    
    // Compute optical path differences once and reuse
    OpticalPathResult opdResInsideReal = OpticalPathDifferenceNM(
        CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient, lighting.cosThetaTR0.real);
    OpticalPathResult opdResInsideImag = OpticalPathDifferenceNM(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, viewToPixel,
        mat.dispersionCoefficientsNm2[dispersionIndex],
        mat.absorptionCoefficient, lighting.cosThetaTR1.real);
    C3 opdAlbedoTransInsideChannel = CV(opdResInsideReal.phaseInterference.opticalPathDifference, opdResInsideImag.phaseInterference.totalPhase);
    
    
    lighting.transmittanceCoherence = CV0(
        max(CoherenceFactor(opdResInsideReal.phaseInterference.opticalPathDifference, mat.coherenceLengthM), ZERO3) +
                                    max(CoherenceFactor(opdResInsideImag.phaseInterference.opticalPathDifference, mat.coherenceLengthM), ZERO3));
    
    
     
    lighting.diffuseReflectance =
            CAdd(
                lighting.reflectance,
                lighting.filmReflectedPolarization);
        //CAdd(
            //CSatMag(lighting.reflectance[dispersionIndex]),
            //CSatMag(CAdd(//CSatMag(lighting.filmReflectedPolarization),
            //CSatMag(fresReflectance));
    
    lighting.diffuseTransmittance = CalculateDiffuseTransmittance(inputUV, dispersionIndex, lighting, mat, sssStrength, lighting.albedo, lighting.transmittance);
    
    lighting.eeDiffuse = CMul(lighting.diffuseTransmittance, CV0(lighting.albedo * ONE3 * PhaseFactorDiffuse()));
    lighting.eeSpecular = CMul(lighting.specularContribution, CV0(ONE3 * PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM)));
    //C3 eeCaustics = CMul(CV0(caustics), CV0(ONE3 * PhaseFactorCaustics(transmittanceCoherence, Mix2)));
    
    lighting.eeInterference = CMul(C0V(lighting.phaseShift.imag), C0V(ONE3 * ApplyTransmissionCoherence(lighting.diffuseTransmittance.imag, opdResInsideImag, mat.coherenceLengthM)));
    
  //  float3 totalWeight = max(EPSILON3,
//        PhaseFactorDiffuse() + 
        //PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM) +
        //PhaseFactorCaustics(transmittanceCoherence, Mix2));
       // PhaseFactorInterference(opdResInsideImag.opticalMeasurement.PathDifferenceM, mat.coherenceLengthM.real));
    
 //   eeDiffuse = ComplexMulCf(eeDiffuse, PhaseFactorDiffuse() / totalWeight);
    
   // eeCaustics = ComplexMulCf(eeCaustics, ONE3 * PhaseFactorCaustics(transmittanceCoherence, Mix2) / totalWeight);
    
    //eeInterference = CSatMag(HeatHazeRainbowCaustics(lighting, inputUV, f01, f02, f03, dispersionIndex));;
   // eeInterference = ComplexMulCf(eeInterference, ONE3 * PhaseFactorInterference(opdResInsideImag.opticalMeasurement.PathDifferenceM, mat.coherenceLengthM.real) / totalWeight);
    lighting.eeInterference = C00;

    //eeSpecular.real = PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM) / totalWeight;
    //C3 eeDiffuseReflectance = diffuseReflectance;
    //RedistributeExcessEnergyComplex(eeDiffuse, eeDiffuseReflectance, eeSpecular, eeInterference);
    //SetDV(diffuseTransmittance, eeDiffuse);
    //SetDV(specularContribution, eeSpecular);
    //SetDV(interferenceContribution, eeInterference);
    //SetDV(diffuseReflectance, eeDiffuseReflectance);

    // === Final Composite Lighting Calculation ===
       
    float3 combinedLighting = lighting.F0 +
     max(0, dot(lighting.normal, lighting.halfDir))
     * lighting.albedo + 
     (lighting.diffuseTransmittance.real + lighting.diffuseReflectance.real)+
        max(0, dot(lighting.normal, lighting.halfDir)) * 
        saturate(1 - lighting.filmReflectedPolarization.imag) +
        (lighting.specularWithSheen + lighting.microfacetSpecularTerm);
        
        //(CMag(lighting.eeSpecular) + lighting.transmittanceCoherence.real + );
    
    if (any(lighting.diffuseTransmittance.real > 0.999))
    {
      //  combinedLighting = float3(1, 0, 0);

    }
    
    float3 f = rotateHue(saturate(combinedLighting)
      //transmittanceCoherence.real
      
       , fmod((lighting.phaseShift.imag + time), 360.))
    
      //phaseShift_e.real
      //phaseShift.real
      //D_complex.real
      //G_complex.real
      //spec_complex.real
      //complexSpecular
      //metallicReflectance
      //sheen
      //advancedSheen
      //clearCoatSpecular
      //specularWithSheen
      //ggxDistributionTerm
      //smithGeometryTerm
      //microfacetDenominator
      //microfacetSpecularTerm
      //n_real
      //refPol.real
      //compositeSpecular.real
      //coherenceLengthM.real
      //specularContribution.real
      //reflectance.real
      //filmReflectedPolarization.real
      
    //diffuseReflectance.imag
     // diffuseTransmittance.real
      
      //albedo // Base color of the material
      //albedoWavelengthsNM // Wavelengths corresponding to albedo (in nm
      //albedoWavelengthsM // Wavelengths corresponding to albedo (in meters
      //iridescenceO
      //iridescenceE
    //phaseShift.real
    
    * max(0, dot(lighting.halfDir, lighting.normal)) * max(0, dot(lighting.viewDir, lighting.halfDir));
    
    
    SetDVf(totalLighting, f);
    
    // === Post-Processing: Gamma, Exposure & Saturation Correction ===
   // SetDVf(totalLighting, ApplyPostProcessing(combinedLighting, gamma, exposure, saturation));
    
    return lighting;
}


// This function computes a scalar intensity value from a micro-textured surface,
// using complex arithmetic to represent phase and amplitude. It returns a float3
// (per-channel intensity) based on the diffuse amplitude modulated by interference.
float3 ComputeOpticalField(float2 uv, float3 i)
{
    // Assume viewPos is constructed from global ViewX, ViewY, ViewZ.
    float3 viewPos = ViewPosM;
    // (SamplerState and MaterialSellmeier are not further used in this snippet.)
    
    // Sample the depth map and scale.
    float depthVal = SampleDepth(depthMap, uv);
    float3 depth = ONE3 * depthVal * DepthScale;
    
    // Sample the diffuse color as the base amplitude.
    float3 amplitude = diffuse2D(diffuseMap, uv).rgb;
    
    // Sample the normal map and remap from [0,1] to [-1,1].
    float3 normal = calcNormal(depthMap, uv).rgb; // user-supplied
    
    // Compute phase shift from depth.
    // RGBToWavelengthsNMf converts diffuse color into effective wavelengths per channel.
    float3 wavelengths = RGBToWavelengthsNM(diffuse2D(diffuseMap, uv).rgb);
    float3 phaseShift = (wavelengths / depth); // user-supplied
    
    // Modulate the phase with time.
    float3 totalPhase = (phaseShift); // user-supplied
    
    // Create a complex phase factor: exp(i * totalPhase) per channel.
    C3 phaseFactor = CExp(CV0(i*totalPhase));
    
    // Construct the complex field: amplitude * exp(i*phase)
    
    // Optionally, add noise modulation for partial coherence.
    float noise = noise2D(noiseMap1, uv).r;
    
    C3 field = phaseFactor;
    float3 lightDir = normalize(viewPos - float3(float2(uv.x, -uv.y), length(depth)));
    phaseFactor.real *= saturate(dot(normal, normalize(lightDir)));
    
    
    // Return the diffuse amplitude modulated by the computed intensity.
    return amplitude * phaseFactor.real;
}

// Computes the object beam as a full C3 field,
// incorporating dispersion (via per-channel wavelengths), depth, and view-dependent phase.
C3 ComputeComplexOpticalField(float3 viewDir, float3x3 tbn, float2 uv, float depth, float NdotV, float3 wavelengthsNM)
{
    // Compute phase shifts: Δφ = (2π/λ) * (2 * depth) + modulation.
    C3 phaseV = CMul(C2PIDiv(CV0(nmToM(wavelengthsNM))), CV0Mul2(depth));
    C3 mod = CV0(ComputeOpticalField(uv, length(nmToM(wavelengthsNM))));
    phaseV = CMul(phaseV, mod);
    //float3 phaseV = ((2.0 * PI / wavelengthsNM) * (2.0 * (depth)) + (sin(time) * (PI))) * SPEED_OF_LIGHT;
    
    // Construct the C3 phase vector.
    // Here, the real part encodes an amplitude modifier per channel (with slight dispersion),
    // and the imaginary part is the computed phase.
    C3 fs = C0V(phaseV.real);
    
    // Return the object beam: diffuse amplitude (with a minor bias) times the phase factor.
    return CV(
            CMul(
                CV0(
                    diffuse2D(diffuseMap, uv).xyz
                ),
                CV0(
                    CMagSq(mod)
                )
            ).real,
            phaseV.real);
}

// Computes the coherent reference beam as a C3 field.
// This is a plane wave with adjustable tilt and time-varying phase.
C3 ComputeComplexReferenceField(float2 uv, float3 tilt, float3x3 tbn)
{
    float3 refPhase = mul(tbn, tbn[2]) * cos(time) * f04;
    return C0V(refPhase);
}

inline C3 AngularFrequency(C3 f)
{
    return CMul(CV0(2.0 * PI), f);
}

//---------------------------------------------------------------------------
// Optical Path Distance (OPD) Phase Function
//---------------------------------------------------------------------------
// Computes the optical path length phase contribution as:
// phase = (cAngularFrequency / SPEED_OF_LIGHT) * (cRefractiveIndex * depth)
C3 ComputeOPDPhase(C3 cAngularFrequency, C3 cRefractiveIndex, C3 depth)
{
    // Multiply the refractive index by the depth.
    C3 opL = CMul(cRefractiveIndex, depth);
    // Scale the angular frequency by 1/SPEED_OF_LIGHT and multiply by opL.
    return CMul(CDiv(cAngularFrequency, CV0(SPEED_OF_LIGHT)), opL);
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



// Example: now we have 58 unique cases, so use `% 58`:
C3 getColorComplex(
    LightingComplex lighting,
    int ix,
    int dispersionIndex
)
{
    psout output = (psout) 0.;
    output.rt1.w = 1.;
    
    switch (uint(ix) % 61)
    {
        // 0..6
        LP_CASE(0, totalLighting[dispersionIndex])
        LP_CASE(1, opticalAxis)
        LP_CASE(2, nSurrounding)
        LP_CASE(3, eta_ratio)
        LP_CASE(4, k_ratio)
        LP_CASE(5, cosTheta)
        LP_CASE(6, F_complex.real)
        LP_CASE(7, dispersionFactor)
         
        LP_CASE(8, n_o)
        LP_CASE(9, cosThetaOptic.real)
        
        LP_CASE(10, n_e_effective)
        LP_CASE(11, etaR_wavelength)
        LP_CASE(12, etaI_wavelength)
        LP_CASE(13, cosThetaTR0.real)
       
       LP_CASE(14, R0.real)
           
        LP_CASE(15, cosThetaTR1.real)
        LP_CASE(16, R1.real)
        LP_CASE(17, R1.real)
        LP_CASE(18, qwave.real)
        LP_CASE(19, phaseShift_o.real)
        LP_CASE(20, phaseShift_e.real)
        LP_CASE(21, phaseShift.real)
        LP_CASE(22, D_complex.real)
        LP_CASE(23, G_complex.real)
        LP_CASE(24, spec_complex.real)
        LP_CASE(25, complexSpecular)
        LP_CASE(26, metallicReflectance)
        LP_CASE(27, sheen)
        LP_CASE(28, advancedSheen)
        LP_CASE(29, clearCoatSpecular)
        LP_CASE(30, specularWithSheen)
        LP_CASE(31, ggxDistributionTerm)
        LP_CASE(32, smithGeometryTerm)
        LP_CASE(33, microfacetDenominator)
        LP_CASE(34, microfacetSpecularTerm)
        LP_CASE(35, n_real)
        LP_CASE(36, F0)
        LP_CASE(37, refPol.real)
        LP_CASE(38, compositeSpecular.real)
        LP_CASE(39, coherenceLengthM)
        LP_CASE(40, specularContribution.real)
        LP_CASE(41, reflectance.real)
        LP_CASE(42, filmReflectedPolarization.real)
        LP_CASE(43, transmittance.real)
        LP_CASE(44, transmittanceCoherence.real)
        LP_CASE(45, diffuseReflectance.real)
        LP_CASE(46, diffuseTransmittance.real)
        LP_CASE(47, eeDiffuse.real)
        LP_CASE(48, eeSpecular.real)
        LP_CASE(49, eeInterference.real)
      
        LP_CASE(50, ggxDistribution)
        LP_CASE(51, cookTorrenceSpecular)
      
        LP_CASE(52, waveInterference.real)
       

        LP_CASE(53, ggxDistribution)
        LP_CASE(54, cookTorrenceSpecular)
        LP_CASE(55, albedo) // Base color of the material
        LP_CASE(56, albedoWavelengthsNM) // Wavelengths corresponding to albedo (in nm)
        LP_CASE(57, albedoWavelengthsM) // Wavelengths corresponding to albedo (in meters)
        LP_CASE(58, iridescenceO);
        LP_CASE(59, iridescenceE);
        default:
            output.rt1.xyz = lighting.totalLighting[dispersionIndex];
            break;
    
        //output.rt1.xyz = lighting.totalLighting.real;
        
    }
    return CV0(output.rt1.xyz);
}


inline float4 depth4(Texture2D<float> depthMap, float2 uv, float radius = -1.0)
{
    float2 oosz = GetOosz(depthMap);
    radius = radius == -1.0 ? NormalRadius : radius;
    float d1 = SampleDepth(depthMap, uv + float2(-oosz.x * radius, 0.0));
    float d3 = SampleDepth(depthMap, uv + float2(0.0, -oosz.y * radius));
    float d2 = SampleDepth(depthMap, uv + float2(oosz.x * radius, 0.0));
    float d4 = SampleDepth(depthMap, uv + float2(0.0, oosz.y * radius));
    return float4(d1, d2, d3, d4);
}

inline float4 depth5(Texture2D<float> depthMap, float2 uv, out float center, float radius = -1.0)
{
    center = SampleDepth(depthMap, uv);
    return depth4(depthMap, uv, radius);
}

inline float4 depth4x(Texture2D<float> depthMap, float2 uv, float radius = -1.0)
{
    float2 oosz = GetOosz(depthMap);
    radius = radius == -1.0 ? NormalRadius : radius;
    float d1 = SampleDepth(depthMap, uv + float2(-oosz.x * radius, oosz.y * radius));
    float d3 = SampleDepth(depthMap, uv + float2(-oosz.x * radius, -oosz.y * radius));
    float d2 = SampleDepth(depthMap, uv + float2(oosz.x * radius, -oosz.y * radius));
    float d4 = SampleDepth(depthMap, uv + float2(oosz.x * radius, oosz.y * radius));
    return float4(d1, d2, d3, d4);
}

inline float4 depth5x(Texture2D<float> depthMap, float2 uv, out float center, float radius = -1.0)
{
    center = SampleDepth(depthMap, uv);
    return depth4x(depthMap, uv, radius);
}

float ComputeCurvature(Texture2D<float> depthMap, float2 oosz, float2 inputUV, bool invertDepth, bool useProjectedDepth)
{
    // Compute curvature using second-order finite differences (Laplacian approximation).
    // 'oosz' is the reciprocal of the texture dimensions (i.e. texel size).

    // depthRaw5 returns a float4 'd' with neighboring depth samples and sets 'center' to the central depth.
    // For example, we assume:
    //    d.x = left, d.y = right, d.z = up, d.w = down.
    float center;
    float4 d = depth5(depthMap, inputUV, center, 1.0);

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
    ret = lerp(ret, (ret), step(0.5, invertDepth));
    
    // Optionally, if using projected depth, adjust the curvature scaling.
    // For example:
    // ret = useProjectedDepth ? (DepthScale * ret) : ret;
    
    return ret;
}

// Accumulate colors from successive passes for progressive refinement.
C3 AccumulateColor(C3 currentColor, C3 previousAccum, float factor)
{
    C3 vfactor = CMul(CDiv(C11, CAdd(CV1(0.5), C11)), CV1(factor));
    C3 ret = CMMul(CV0(previousAccum.real), CAdd(CV0(0.5), CV0(currentColor.real)), vfactor);
    
    return ret;
}


// Base interference pattern
float3 GenerateBaseInterference(float3 wavelengths, float2 uv, float3 phase)
{
    float3 interference = 0.0;
    float2 sz = GetSz(depthMap);
    float2 wavePos = uv * sz * f02;
    
    [unroll]
    for (int i = 0; i < 3; i++)
    {
        float freq = wavelengths[i] * 3 * 1 / sz.x;
        interference[i] = sin(wavePos.x * freq + phase[i]) *
                         sin(wavePos.y * freq * 0.7 + phase[i]);
    }
    
    float _f4 = f04 - 0.01;
    [unroll]
    for (i = 0; i < 3; i++)
    {
        _f4 += 0.01;
        float freq = wavelengths[i] * 3 * _f4 * 1 / sz.y;
        interference[i] += sin(wavePos.x * freq + phase[i]) *
                         sin(wavePos.y * freq * 0.7 + phase[i]);
    }
    return interference * .5;
}

// Secondary wave enhancement
float3 GenerateSecondaryWaves(float2 uv, float t, float3 eta)
{
    float3 wavelengthsM = RGBToWavelengthsM(gradient2.SampleLevel(sampleTypeMirror, uv, 0).xyz);
    float3 waves;
    waves.x = sin(uv.x * 25.0 + t * 1.3) / (2. * 2. * PI / wavelengthsM.x * 0.3);
    waves.y = sin(uv.y * 20.0 + t * 0.9) / (0.3 * 2. * 2. * PI / wavelengthsM.y * 0.3);
    waves.z = sin(dot(uv, float2(15.0, 18.0)) + t * 0.6) / (0.3 * 2. * 2. * PI / wavelengthsM.z * 0.3);
    return waves;
}

// Phase field calculation
float3 CalculatePhase(float2 uv, float3 t, C3 phaseShift, float3 oscillationAmplitude)
{
    float3 diffuse = diffuse2D(diffuseMap, uv).xyz;
    float3 wavelengthsNMf = RGBToWavelengthsNM(diffuse);
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    float3 phase;
    
    
    phase.x = (sin((t.x + .5 + (uv.x - .5) * 0.01 * CosineFactor.x + CAdd(phaseShift, C0V(cos(time))).real * oscillationAmplitude.x) * mat.etaR.x / wavelengthsNMf.x)).x;
    
    phase.y = (sin((t.y * 0.018 * cosTime01(AnimateSpeed) + 2.0 * (.5 + (-uv.y - .5) * sinTime01(AnimateSpeed) + phase.x * mat.coherenceLengthM) * 0.08 - phaseShift.real.y)
    ) * oscillationAmplitude.y * mat.etaR.y / wavelengthsNMf.y * phaseShift.imag.y * CMag(CMul(phaseShift, CV0(mat.coherenceLengthM)))).y;
    
    phase.z = C0V(sin(float3(float2(LookAtX, LookAtY)
    , 1)*
    t.z + .5 + (uv.x - .5 + phaseShift.real.z) * oscillationAmplitude.z * mat.etaR) /
       (CAdd(C0V(EPSILON3), ComplexDiv(
            ComplexAdd(
                C0V(wavelengthsNMf),
                CMul(phaseShift, C0V(saturate(CMag(CDiv(phaseShift, CV0(mat.coherenceLengthM))))))
            ),
        CV0(mat.coherenceLengthM))).real).z).real.z;
    
    phase.x += cos(phase.z * 2.0 * PI + time);
    return lerp(phase, 0, .95);

}
// Function to calculate optical phase difference
float3 CalculateOpticalPhaseDifference(float3 pathDifference, float3 wavelength, float3 refractiveIndex)
{
    return 2.0 * 3.14159 * refractiveIndex * pathDifference / wavelength;
}

// Pixel shader
// Visualization:
// - Red: Phase gradient magnitude (R channel)
// - Green: Coherence between R and G
// - Blue: Entropy

// Depth Sampling

// Fresnel Term (Schlick's Approximation)
float3 FresnelSchlick(float cosTheta, float3 F0)
{
    return F0 + (1.0 - F0) * pow(max(1.0 - cosTheta, 0), max(FresnelPower, EPSILON));
}

void FresnelPolarization(float cosThetaI, float3 n1, float3 n2, out float3 Rs, out float3 Rp)
{
    float3 sinThetaI = sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
    float3 sinThetaT = n1 * sinThetaI / n2;
    float3 cosThetaT = sqrt(max(0.0, 1.0 - sinThetaT * sinThetaT));
    
    float3 numS = n1 * cosThetaI - n2 * cosThetaT;
    float3 denS = n1 * cosThetaI + n2 * cosThetaT;
    Rs = (numS * numS) / (denS * denS + EPSILON);
    
    float3 numP = n1 * cosThetaT - n2 * cosThetaI;
    float3 denP = n1 * cosThetaT + n2 * cosThetaI;
    Rp = (numP * numP) / (denP * denP + EPSILON);
}

C3 ThinFilmInterference(float3 opd, float3 wavelengthsM, float3 nFilm)
{
    float3 phase = TWOPI * nFilm * opd / wavelengthsM;
    C3 interference;
    interference.real = cos(phase.x) + cos(phase.y) + cos(phase.z);
    interference.imag = sin(phase.x) + sin(phase.y) + sin(phase.z);
    return interference;
}


float3 spectral_zucconi6(float3 w)
{
    float3 x = saturate((w - 400.0) / 300.0);
    const float3 c1 = float3(3.54585104, 2.93225262, 2.41593945);
    const float3 x1 = float3(0.69549072, 0.49228336, 0.27699880);
    const float3 y1 = float3(0.02312639, 0.15225084, 0.52607955);
    const float3 c2 = float3(3.90307140, 3.21182957, 3.96587128);
    const float3 x2 = float3(0.11748627, 0.86755042, 0.66077860);
    const float3 y2 = float3(0.84897130, 0.88445281, 0.73949448);
    float3 t1 = c1 * (x - x1);
    float3 t2 = c2 * (x - x2);
    return saturate(1.0 - t1 * t1) * y1 + saturate(1.0 - t2 * t2) * y2;
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
// Thin film interference reflectance
float ThinFilmReflectance(float cos0, float d, float n0, float n1, float n2, float lambda)
{
    float delta = 2.0 * n1 * d * cos0 / lambda;
    float phi = 2.0 * 3.14159 * delta;
    float r01 = (n0 - n1) / (n0 + n1);
    float r12 = (n1 - n2) / (n1 + n2);
    float interference = 1.0 + r01 * r12 + 2.0 * sqrt(abs(r01 * r12)) * cos(phi);
    return saturate(interference);
}
inline float3 GaussianBlurHorizontal(
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
    float3 centerColor = SampleDiffuse(diffuseMap, uv);
    float centerDepth = SampleDepth(depthMap, uv);
    
    // Initialize accumulators for color and total weight
    float3 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each horizontal sample
    for (int i = 0; i < 4; i++)
    {
        float2 sampleUVLeft = uv + offsets[i];
        float2 sampleUVRight = uv - offsets[i];

        float3 sampleColorLeft = SampleDiffuse(diffuseMap, sampleUVLeft);
        float3 sampleColorRight = SampleDiffuse(diffuseMap, sampleUVRight);
        
        float sampleDepthLeft = SampleDepth(depthMap, sampleUVLeft);
        float sampleDepthRight = SampleDepth(depthMap, sampleUVRight);
        
        // Depth-based weight for left sample
        float depthDifferenceLeft = abs(sampleDepthLeft - centerDepth);
        float depthDifferenceRight = abs(sampleDepthRight - centerDepth);
        float depthWeightLeft = 1.0 - saturate(depthDifferenceLeft);
        float depthWeightRight = 1.0 - saturate(depthDifferenceRight);
        
        // Combined weight for left sample
        float combinedWeightLeft = weights[i] * depthWeightLeft;
        float combinedWeightRight = weights[i] * depthWeightRight;
        
        accumColor += sampleColorLeft * combinedWeightLeft;
        accumColor += sampleColorRight * combinedWeightRight;
        
        totalWeight += combinedWeightLeft;
        totalWeight += combinedWeightRight;
    }
    
    // Normalize the accumulated color
    float3 finalColor = accumColor / totalWeight;
    
    // Ensure the color stays within valid range
    return saturate(finalColor);
}

// Vertical Gaussian blur pass
inline float3 GaussianBlurVertical(
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
    float3 centerColor = SampleDiffuse(diffuseMap, uv);
    float centerDepth = SampleDepth(depthMap, uv);
    
    // Initialize accumulators for color and total weight
    float3 accumColor = centerColor * 1.0; // Center has a weight of 1.0
    float totalWeight = 1.0;
    
    // Iterate through each vertical sample
    for (int i = 0; i < 4; i++)
    {
         // Up sample
        float2 sampleUVUp = uv + offsets[i];
        float2 sampleUVDown = uv - offsets[i];
        
        float sampleDepthUp = SampleDepth(depthMap, sampleUVUp);
        float sampleDepthDown = SampleDepth(depthMap, sampleUVDown);
       
        float3 sampleColorUp = SampleDiffuse(diffuseMap, sampleUVUp);
        float3 sampleColorDown = SampleDiffuse(diffuseMap, sampleUVDown);
        
        // Depth-based weight for up sample
        float depthDifferenceUp = abs(sampleDepthUp - centerDepth);
        float depthDifferenceDown = abs(sampleDepthDown - centerDepth);
        
        float depthWeightUp = 1.0 - saturate(depthDifferenceUp);
        float depthWeightDown = 1.0 - saturate(depthDifferenceDown);
       
        float combinedWeightUp = weights[i] * depthWeightUp;
        float combinedWeightDown = weights[i] * depthWeightDown;
        
        accumColor += sampleColorUp * combinedWeightUp;
        accumColor += sampleColorDown * combinedWeightDown;
        
        totalWeight += combinedWeightUp;
        totalWeight += combinedWeightDown;
    }
    
    // Normalize the accumulated color
    float3 finalColor = accumColor / totalWeight;
    
    // Ensure the color stays within valid range
    return saturate(finalColor);
}

// Full Gaussian blur using separable passes
inline float3 FullGaussianBlur(
    Texture2D<float4> rtMap,
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range,
    float2 sigma)
{

    float3 horizontalBlur = SampleDiffuse(rtMap, uv);
    if (PassNum < 1)
        horizontalBlur = GaussianBlurHorizontal(diffuseMap, depthMap, uv, range, sigma.x);
    
    // Assuming horizontalBlur is written to an intermediate texture,
    // perform the vertical blur by sampling from that intermediate texture.
    // For illustration, we'll reuse the same diffuseMap.
    // In practice, you should use a separate texture for the intermediate result.

    float3 finalBlur = horizontalBlur;

    if (PassNum > 0)
    {
        finalBlur = GaussianBlurVertical(rtMap3, depthMap, uv, range, sigma.y);
    }
    
    return finalBlur;
}

// Modified SampleAvg function with Gaussian kernel and depth-based weighting
inline float3 SampleAvg(
    Texture2D<float4> rtMap,
    Texture2D<float4> diffuseMap,
    Texture2D<float> depthMap,
    float2 uv,
    float range)
{
    float2 minSz = min(min(GetSz(rtMap), GetSz(diffuseMap)), GetSz(depthMap));

    return FullGaussianBlur(rtMap, diffuseMap, depthMap, uv, range, 1.0 / minSz);

}


float3 ComputeIridescence(float3 pixelM, float3 baseColor, float filmThicknessNM, MaterialSellmeier mat)
{
    // Get the base wavelengths from the diffuse color (in nanometers),
    // then convert them to meters exactly once.
    float3 wavelengthsNM = RGBToWavelengthsNM(baseColor);
    
    float3 phase = 2.0 * PI * nmToM(filmThicknessNM) * mat.etaR / max(1e-10, nmToM(wavelengthsNM));
    
    return sin(phase + time);
}


float3 ComputeDynamicInterference(float3 wavelengthsNM, float depth, float3 pixelPos, float2 textureSize)
{
    // Convert wavelengths from nanometers to meters exactly once.
    float3 wavelengthsM = nmToM(wavelengthsNM);
    
    // depth is in meters; phase = 2π * (depth in m) / (wavelength in m)
    float3 basePhase = 2.0 * PI * depth / wavelengthsM;
    
    // Introduce a time-dependent modulation.
    float3 timeModulation = sin(time * float3(0.5, 0.7, 0.9) + pixelPos);
    
    float3 phase = basePhase + timeModulation;
    return (sin(phase) + cos(phase * 0.5)) * 0.5;
}

float3 ComputeVolumetricCaustics(float3 pixelNM, int numSteps)
{
    float3 accumulated = float3(0.0, 0.0, 0.0);
    float3 weightSum = float3(0.0, 0.0, 0.0);
    for (int i = 0; i < numSteps; i++)
    {
        float depthStep = (float(i) / numSteps);
        float phase = time * 0.1 + depthStep * 2.0 * PI;
        float3 causticSample = float3(sin(phase + pixelNM.x), sin(phase + pixelNM.y), cos(phase + pixelNM.z));
        float weight = exp(-depthStep * 3.0);
        accumulated += causticSample * weight;
        weightSum += float3(weight, weight, weight);
    }
    return accumulated / weightSum;
}

float3 ApplyDynamicHue(float3 color, float intensity)
{
    // Rotate hue dynamically.
    float angle = fmod(time * intensity, 360.0);
    return rotateHue(color, angle + 90);
}
float Shadow(Texture2D<float> depthMap, float2 uv, float shadowIntensity, int shadowRadius)
{
    float currentDepth = SampleDepth(depthMap, uv);
    float shadowFactor = 0.0;
    float2 oosz = GetOosz(depthMap);
    float weight = 0;
    
    float v = 0;
    
    v = step(SampleDepth(depthMap, uv + float2(-1.0, -1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    v = step(SampleDepth(depthMap, uv + float2(-1.0, 0.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    v = step(SampleDepth(depthMap, uv + float2(-1.0, 1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    
    v = step(SampleDepth(depthMap, uv + float2(0.0, -1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    v = step(SampleDepth(depthMap, uv + float2(0.0, 1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;

    v = step(SampleDepth(depthMap, uv + float2(1.0, -1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    v = step(SampleDepth(depthMap, uv + float2(1.0, 0.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;
    v = step(SampleDepth(depthMap, uv + float2(1.0, 1.0) * float(shadowRadius + 1) * oosz), currentDepth) * shadowIntensity;
    shadowFactor += v;
    weight += v;

    return shadowFactor / weight;
}




// Blackman window for edge tapering
float2 BlackmanWindow(float2 uv)
{
    float2 a0 = 0.42;
    float2 a1 = 0.5;
    float2 a2 = 0.08;
    float2 x = 2.0 * PI * uv;
    float2 y = 4.0 * PI * uv;
    return a0 - a1 * cos(x) + a2 * cos(y);
}


float3 SchlickFresnel(float3 F0, float cosTheta)
{
    float3 f = max(0, F0 + (1.0 - F0) * pow(1.0 - saturate(cosTheta), FresnelPower));
    float3 fr = max(0, F0 + (1.0 - F0) * pow(1.0 - saturate(1.0 - cosTheta), FresnelReflectance));
    return lerp(f, fr, saturate(1 - cosTheta));
}

float CharlieD(float NdotH, float roughness)
{
    float invR = 1.0 / max(roughness * roughness, 0.01);
    float cos2h = NdotH * NdotH;
    float sin2h = max(1.0 - cos2h, 0.0078125);
    return (2.0 + invR) * pow(sin2h, invR * 0.5) / (2.0 * 3.14159);
}

float CharlieV(float NdotL, float NdotV, float roughness)
{
    float lambdaV = NdotV < 0.5 ? exp(2.0 * NdotV - 1.0) : 1.0;
    float lambdaL = NdotL < 0.5 ? exp(2.0 * NdotL - 1.0) : 1.0;
    return 1.0 / ((1.0 + lambdaV + lambdaL) * (4.0 * NdotV * NdotL + 0.01));
}

float3 ComputeSheen(float3 vN, float3 V, float3 L, float3 baseColor, float roughness, float intensity, float tint)
{
    float3 H = normalize(L + V);
    float NdotL = saturate(dot(vN, L));
    float NdotV = saturate(dot(vN, V));
    float NdotH = saturate(dot(vN, H));
    float LdotH = saturate(dot(L, H));

    if (NdotL <= 0.0 || NdotV <= 0.0)
        return float3(0, 0, 0);

    float D = CharlieD(NdotH, roughness);
    float vV = CharlieV(NdotL, NdotV, roughness);
    float3 F0 = lerp(float3(0.04, 0.04, 0.04), baseColor, tint);
    float3 F = SchlickFresnel(F0, LdotH);

    return D * vV * F * NdotL * intensity;
}



// Slice 1: Base dark-blue gradient
float3 Slice1(float2 uv)
{
    float gradient = uv.y;
    return float3(0.0, 0.0, gradient);
}

// Slice 2: Swirling dynamics using polar coordinates
float3 Slice2(float2 uv)
{
    float2 centered = uv - 0.5;
    float angle = atan2(centered.y, centered.x);
    float radius = length(centered);
    float r = (sin(3.0 * radius + angle) + 1.0) * 0.5;
    float g = (cos(4.0 * radius) + 1.0) * 0.5;
    float b = (sin(5.0 * angle) + 1.0) * 0.5;
    return float3(r, g, b);
}

// Slice 3: High-frequency interference patterns
float3 Slice3(float2 uv)
{
    // Scale uv to introduce frequency based on resolution
    float freqX = 10.0 * uv.x * (resolution.x / 100.0);
    float freqY = 10.0 * uv.y * (resolution.y / 100.0);
    float interference = sin(freqX) * sin(freqY);
    float r = (interference + 1.0) * 0.5;
    float g = (sin(freqX + interference) + 1.0) * 0.5;
    float b = (cos(freqY + interference) + 1.0) * 0.5;
    return float3(r, g, b);
}

// Slice 4: Holographic interference fringes with time modulation
float3 Slice4(float2 uv)
{
    float2 centered = uv - 0.5;
    float radius = length(centered);
    float fringe = sin(Depth * radius + f12 * time) * f12;
    float r = (fringe + 1.0) * 10.5;
    float g = (sin(1.50 * radius + time) + 1.0) * 10.05;
    float b = (cos(2.50 * radius + time) + 1.0) * 10.05;
    return float3(r, g, b);
}

// Slice 5: Composite synthesis of the previous four slices
float3 Slice5(float2 uv)
{
    float3 color1 = Slice1(uv);
    float3 color2 = Slice2(uv);
    float3 color3 = Slice3(uv);
    float3 color4 = Slice4(uv);
    return (color1 + color2 + color3 + color4) / 4.0;
}
float3 HolographicShimmer(float3 baseColor, float2 uv)
{
    // Define a small offset factor for chromatic dispersion
    float offset = 0.005;
    float f = f12;
    // Calculate separate UV offsets for each channel
    float2 uvR = uv + offset * float2(sin(time + uv.y * (DepthM) * f), cos(time + uv.x * ( DepthM) * f));
    float2 uvG = uv + offset * float2(sin(time + uv.y * (DepthM) * f + 0.5), -cos(time + uv.x * ( DepthM) * f + 0.5));
    float2 uvB = uv + offset * float2(sin(time + uv.y * (DepthM) * f + 1.0), cos(time + uv.x * ( DepthM) * f + 1.0));
    
    // Generate a dynamic interference pattern for each channel
    float interferenceR = (sin(2.0 * f * (uvR.x + uvR.y) + time) + 1.0) * 0.5;
    float interferenceG = (sin(2.0 * f * (uvG.x + uvG.y) + time) + 1.0) * 0.5;
    float interferenceB = (sin(2.0 * f * (uvB.x + uvB.y) + time) + 1.0) * 0.5;
    
    // Mix the interference patterns with the base color to yield a shimmering, refractive effect
    return float3(baseColor.r * interferenceR, baseColor.g * interferenceG, baseColor.b * interferenceB);
}




// Holographic surface data
struct HolographicSurface
{
    float3 position; // World-space position
    float3 normal; // Surface normal
    float3 diffuseColor; // Diffuse color
    float interferencePhase; // Interference phase
    float depth; // Depth from map
};

// Interference point for holographic waves
struct InterferencePoint
{
    float3 position; // Wave source position
    float3 amplitude; // Wave amplitude
    float3 phase; // Phase offset (RGB)
    float3 wavelengthM; // Wavelength in meters (RGB)
    float3 coherenceFactor; // Coherence factor (RGB)
    float gratingModulation; // Grating modulation
};

// Holographic surface computation (stub, assumes external definition)
HolographicSurface ComputeHolographicSurface(float2 uv, LightingComplex lighting)
{
    HolographicSurface surface;
    surface.position = lighting.pixelPos;
    surface.normal = lighting.normal;
    surface.diffuseColor = lighting.albedo;
    surface.interferencePhase = 1.0;
    surface.depth = lighting.depth;
    return surface;
}

// Fresnel complex term (simplified for demo)
C3 FresnelComplex2(float3 n1, float3 n2, C3 cosTheta, float3 k2)
{
    float3 n_ratio = n1 / n2;
    C3 c;
    c.real = (n_ratio.x * cosTheta.real - k2.x) / (n_ratio.x * cosTheta.real + k2.x);
    c.imag = 0.0; // Simplified for HLSL
    return c;
}

// Thin film interference (simplified for demo)
C3 ThinFilmInterference(float thicknessM, float3 wavelengthsM, float3 n_effective)
{
    float3 phase = 2.0 * C2PI.real * thicknessM / wavelengthsM;
    C3 c;
    c.real = cos(phase.x) * n_effective.x;
    c.imag = sin(phase.x) * n_effective.x;
    return c;
}

//Holographic projection : sumpoint‐source contributions
C3 ComputeHologramProjection(
    float2 uv,
    float3 srcPos[4], // world‐space positions
    float3 srcAmp[4], // per‐source amplitude
    int count,
    float3 wavelengthNM // single wavelength in meters
)
{
    C3 sum = CV0(float3(0,0,0));
    // reconstruct pixel world position (assume orthographic onto z=0 plane)
    float3 pixPos = float3(uv * resolution, 0);
    for (int i = 0; i < count; ++i)
    {
        float3 d = pixPos - srcPos[i];
        float3 dist = (d);
        float3 phase = TWOPI * dist / nmToM(wavelengthNM) + time;
        C3 ph;
        ph.real = cos(phase);
        ph.imag = sin(phase);
        C3 amp = CV0(srcAmp[i] / max(EPSILON, dist * dist));
        sum = CAdd(sum, CMul(amp, ph));
    }
    return sum;
}


// Convert wavelength (nm) to RGB with enhanced spectral accuracy
float3 WavelengthToRGB(float wavelength)
{
    float lambda = clamp(wavelength, 400.0, 700.0);
    float3 rgb = float3(0.0, 0.0, 0.0);
    
    if (lambda >= 400.0 && lambda < 440.0)
    {
        float t = (440.0 - lambda) / 40.0;
        rgb = float3(t, 0.0, 1.0);
    }
    else if (lambda >= 440.0 && lambda < 490.0)
    {
        float t = (490.0 - lambda) / 50.0;
        rgb = float3(0.0, t, 1.0);
    }
    else if (lambda >= 490.0 && lambda < 510.0)
    {
        float t = (510.0 - lambda) / 20.0;
        rgb = float3(0.0, 1.0, t);
    }
    else if (lambda >= 510.0 && lambda < 580.0)
    {
        float t = (580.0 - lambda) / 70.0;
        rgb = float3(t, 1.0, 0.0);
    }
    else if (lambda >= 580.0 && lambda < 645.0)
    {
        float t = (645.0 - lambda) / 65.0;
        rgb = float3(1.0, t, 0.0);
    }
    else
    {
        float t = (700.0 - lambda) / 55.0;
        rgb = float3(1.0, 0.0, t);
    }
    
    float intensity = 1.0;
    if (lambda < 420.0)
        intensity = 0.3 + 0.7 * (lambda - 400.0) / 20.0;
    else if (lambda > 680.0)
        intensity = 0.3 + 0.7 * (700.0 - lambda) / 20.0;
    
    return rgb * intensity;
}

// Enhanced parallax occlusion mapping with self-shadowing
float2 ParallaxOcclusionUV(float2 uv, float3 viewDirTangent, float3 lightDirTangent)
{
    const float numLayers = 32.0;
    const float layerDepth = 1.0 / numLayers;
    const int2 dim = GetSz(depthMap);
    const float2 oosz = 1.0 / dim;
    float3 normal = calcNormal(depthMap, uv);
    float depth = SampleDepth(depthMap, uv);
    float3 wl1 = 
        WavelengthsToRGB(
            RGBToWavelengthsNM(
                float3(SampleDiffuse(uv - float2(oosz.x, 0) * 7. * depth).x,
                RGBToWavelengthsNM(SampleDiffuse(uv)).y,
                RGBToWavelengthsNM(SampleDiffuse(uv + float2(oosz.x, 0) * 7. * depth)).z
            )
        ) )* max(0,dot(normal, normalize(HalfDir)));
    float3 deltaUV = 
        float3(cos(time), 1, sin(time)) * 
            wl1 * float3(oosz, 1) * 
            lerp(normal * float3(-1, 0, 0) * depth,
                normal * -float3(1, 0, 0) * depth, 
                .5 + .5 * cos(time));
    float2 currentUV = uv - 0.5;
   
    float sourceDepth = depth;
    float currentDepth = sourceDepth;
    float currentLayerDepth = currentDepth;
    float2 uvOffset = currentUV;
    [unroll(32)]
    for (int i = 0; i < numLayers; i++)
    {
        float3 wl = WavelengthsToRGB(RGBToWavelengthsNM(SampleDiffuse(uvOffset)));
        uvOffset += deltaUV.xy * (currentLayerDepth) * (wl.xy / wl.z * 2.0 - 1.0);
        currentDepth = SampleDepth(depthMap, uvOffset);
        currentLayerDepth -= layerDepth;
        if (currentLayerDepth < EPSILON)
            break;
    }
    
    currentUV = uvOffset;
            
    return currentUV + 0.5;
}


float3 InterferencePattern(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float coherenceLength)
{
    // Convert wavelengths to meters (visible spectrum: 380-780 nm)
    float3 lambda = clamp(wavelengthsNM, 380.0, 780.0) * 1e-9;

    // Derive grating spacings from material properties
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float3 baseSpacing = 0.1 + nmToM(RGBToWavelengthsNM(diffuseColor));
    float3 fineGratingSpacing = baseSpacing;
    float3 broadGratingSpacing = baseSpacing * 1.5; // Reduced factor for subtle distinction
    float3 gratingNormal = calcNormal(depthMap, uv);
    float3 gratingDir = normalize(gratingNormal);
    float3 perpGratingDir = normalize(float3(-gratingDir.y, gratingDir.x, gratingDir.z));

    // Adaptive anti-aliasing setup
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.25, -0.25), float2(0.25, -0.25),
        float2(-0.25, 0.25), float2(0.25, 0.25)
    };
    float3 interferenceSum = ZERO3;
    static const float3 center = float3(0.5, 0.5, 0.0);

    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with AA offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = SampleDepth(depthMap, sampleUV);
        float3 sampleNormal = normalize(calcNormal(depthMap, sampleUV));

        // Compute phase coordinate
        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale) - center;
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with Fresnel enhancement
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(halfDir, sampleNormal));
        float theta = acos(cosTheta);
        float fresnel = pow(1.0 - cosTheta, 5.0); // Schlick's approximation

        // Optical path differences
        float fineProj = dot(phaseCoord, perpGratingDir);
        float3 finePath = fineProj / fineGratingSpacing;
        float3 finePhase = 2.0 * 3.141592653589793 * finePath / lambda;

        float broadProj = dot(phaseCoord, gratingDir);
        float3 broadPath = broadProj / broadGratingSpacing;
        float3 broadPhase = 2.0 * 3.141592653589793 * broadPath / lambda;

        // Total phase with temporal modulation
        float3 totalPhase = finePhase + broadPhase + theta + 0.1 * time;

        // Advanced coherence model (Voigt profile approximation)
        float3 pathDiff = (abs(finePath + broadPath) * lambda);
        float3 coherenceFactor = coherenceLength / (coherenceLength + 0.5 * pathDiff * pathDiff + 0.5 * coherenceLength * abs(finePath + broadPath));

        // Interference pattern with polarization and material modulation
        float3 interference = diffuseColor * cos(totalPhase) * coherenceFactor * (0.5 + 0.5 * fresnel);

        interferenceSum += interference;
    }

    // Normalize and apply spectral dispersion
    interferenceSum /= N_AA_SAMPLES;
    float3 dispersion = saturate(1.0 + 0.05 * (lambda / (780.0 * 1e-9) - 1.0));
    return saturate(interferenceSum * dispersion);
}
float3 InterferencePattern2(float3 viewDir, float3 lightDir, float3 normal, 
    float2 uv, float3 wavelengthsNM, float coherenceLength)
{
    // Convert wavelengths to meters with high-precision visible spectrum clamping
    float3 lambda = clamp(wavelengthsNM, 380.0, 780.0) * 1e-9;

    // Derive grating parameters with material-driven modulation
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float baseSpacing = nmToM(length(RGBToWavelengthsNM(diffuseColor)));
    float fineGratingSpacing = baseSpacing * (1.0 + 0.1 * dot(normal, float3(0.0, 0.0, 1.0))); // Normal-modulated spacing
    float broadGratingSpacing = baseSpacing * 1.618; // Golden ratio for aesthetic distinction
    float3 gratingNormal = calcNormal(depthMap, uv);
    float3 gratingDir = normalize(gratingNormal);
    float3 perpGratingDir = normalize(float3(-gratingDir.y, gratingDir.x, gratingDir.z));

    // Anti-aliasing setup with stratified jittering
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.276393, -0.276393), float2(0.276393, -0.276393),
        float2(-0.276393, 0.276393), float2(0.276393, 0.276393)
    }; // Halton sequence (base 2,3) for optimal distribution
    float3 interferenceSum = ZERO3;
    
    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with jittered offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = clamp(SampleDepth(depthMap, sampleUV), 0.0, 1.0);
        float3 sampleNormal = normalize(calcNormal(depthMap, sampleUV));

        // Compute phase coordinate in world space
        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with full Fresnel term (polarized)
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(halfDir, sampleNormal));
        float theta = acos(cosTheta);
        float fresnelS = pow(1.0 - cosTheta, 5.0); // Schlick's approximation (s-polarized)
        float fresnelP = fresnelS * (1.0 - 0.2 * dot(viewDirSample, sampleNormal)); // p-polarized adjustment
        float fresnel = 0.5 * (fresnelS + fresnelP); // Average for unpolarized light

        // Optical path differences with grating modulation
        float fineProj = dot(phaseCoord, perpGratingDir);
        float3 finePath = fineProj / fineGratingSpacing;
        float3 finePhase = 2.0 * 3.14159265358979323846 * finePath / lambda;

        float broadProj = dot(phaseCoord, gratingDir);
        float3 broadPath = broadProj / broadGratingSpacing;
        float3 broadPhase = 2.0 * 3.14159265358979323846 * broadPath / lambda;

        // Total phase with anisotropic temporal modulation
        float3 totalPhase = finePhase + 0.618 * broadPhase + theta + 0.05 * lambda / (550.0 * 1e-9) + time; // Wavelength-dependent animation

        // Advanced coherence model (Gaussian-Lorentzian hybrid)
        float3 pathDiff = abs(finePath + 0.618 * broadPath) * lambda;
        float3 gaussianTerm = exp(-pow(pathDiff / coherenceLength, 2.0));
        float3 lorentzianTerm = coherenceLength / (coherenceLength + 0.5 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.7 * gaussianTerm + 0.3 * lorentzianTerm;

        // Interference pattern with PBR integration
        float3 baseIntensity = diffuseColor * (0.5 + 0.5 * fresnel);
        float3 interference = baseIntensity * cos(totalPhase) * coherenceFactor;

        interferenceSum += interference;
    }

    // Normalize and apply physically-based spectral dispersion
    interferenceSum /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + 0.08 * (lambda / (780.0 * 1e-9) - 1.0) * (1.0 + 0.2 * dot(normal, viewDir));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}


float3 InterferencePattern3(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float coherenceLength)
{
    // Convert wavelengths to meters with rigorous spectral bounds (Euler-inspired precision)
    float3 lambda = clamp(wavelengthsNM, 380.0, 780.0) * 1e-9;

    // Grating parameters with material-driven modulation (Gauss-inspired material coupling)
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float baseSpacing = nmToM(length(RGBToWavelengthsNM(diffuseColor)));
    float fineGratingSpacing = baseSpacing * (1.0 + 0.05 * dot(normalize(normal), float3(0.0, 0.0, 1.0))); // Surface-modulated spacing
    float broadGratingSpacing = baseSpacing * 1.4142135623730951; // sqrt(2) for harmonic distinction
    float3 gratingNormal = calcNormal(depthMap, uv);
    float3 gratingDir = normalize(gratingNormal);
    float3 perpGratingDir = normalize(float3(-gratingDir.y, gratingDir.x, gratingDir.z));
    
    
    // Anti-aliasing setup with Gaussian quadrature-inspired sampling (Gauss-Legendre nodes)
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.8611363115940526, -0.8611363115940526), // Gauss-Legendre quadrature points
        float2(0.8611363115940526, -0.8611363115940526),
        float2(-0.8611363115940526, 0.8611363115940526),
        float2(0.8611363115940526, 0.8611363115940526)
    };
    float3 interferenceSum = ZERO3;

    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with quadrature offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = SampleDepth(depthMap, sampleUV);
        float3 sampleNormal = calcNormal(depthMap, sampleUV);

        // Phase coordinate in world space
        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with Fresnel-Polarization (Euler’s trigonometric elegance)
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = dot(halfDir, sampleNormal);
        float theta = acos(cosTheta);
        float fresnelS = pow(1.0 - cosTheta, 5.0); // Schlick’s approximation for s-polarized
        float fresnelP = fresnelS * (1.0 - 0.15 * dot(viewDirSample, sampleNormal)); // p-polarized
        float fresnel = 0.5 * (fresnelS + fresnelP);

        // Optical path differences (Fourier-inspired wave superposition)
        float fineProj = dot(phaseCoord, perpGratingDir);
        float3 finePath = fineProj / fineGratingSpacing;
        float3 finePhase = 2.0 * 3.1415926535897932384626433832795 * finePath / lambda;

        float broadProj = dot(phaseCoord, gratingDir);
        float3 broadPath = broadProj / broadGratingSpacing;
        float3 broadPhase = 2.0 * 3.1415926535897932384626433832795 * broadPath / lambda;

        // Total phase with harmonic modulation (Euler’s exponential form)
        float3 totalPhase = finePhase + 0.7071067811865475 * broadPhase + theta + 0.02 * lambda / (550.0 * 1e-9) + time;

        // Coherence model with Gaussian-Lorentzian convolution (Gauss’s statistical rigor)
        float3 pathDiff = abs(finePath + 0.7071067811865475 * broadPath) * lambda;
        float3 gaussianTerm = exp(-pow(pathDiff / coherenceLength, 2.0) * 0.6931471805599453); // ln(2) for half-width
        float3 lorentzianTerm = coherenceLength / (coherenceLength + 0.3 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.6 * gaussianTerm + 0.4 * lorentzianTerm;

        // Interference pattern with spectral and PBR integration (Fourier series summation)
        float3 baseIntensity = diffuseColor * (0.4 + 0.6 * fresnel); // PBR-balanced
        float3 interference = baseIntensity * cos(totalPhase) * coherenceFactor;

        interferenceSum += interference;
    }

    // Normalize and apply spectral dispersion (Fourier’s spectral decomposition)
    interferenceSum /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + 0.06 * (lambda / (780.0 * 1e-9) - 1.0) * (1.0 + 0.15 * dot(normalize(normal), viewDir));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}
float3 InterferencePattern4(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float coherenceLength)
{
    // Convert wavelengths to meters with precise spectral clamping
    float3 lambda = nmToM(wavelengthsNM);

    // Grating parameters with multi-scale modulation
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float3 baseSpacing = (2.0 * PI * 2.0 * SampleDepth(depthMap, uv)) / (wavelengthsNM);
    float3 fineGratingSpacing = Mix2 * baseSpacing * (1.0 + 0.08 * dot(normalize(normal), calcNormal(gratingDepth1, uv)));
    float3 broadGratingSpacing = baseSpacing * 1.7320508075688772; // sqrt(3) for harmonic richness
    float3 gratingNormal = calcNormal(depthMap, uv);
    float3 gratingDir = normalize(gratingNormal);
    float3 perpGratingDir = normalize(float3(-gratingDir.y, gratingDir.x, gratingDir.z));
    
    // Anti-aliasing setup with adaptive low-discrepancy sampling
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.3872983346207417, -0.3872983346207417), // Sobol sequence for uniform coverage
        float2(0.3872983346207417, -0.3872983346207417),
        float2(-0.3872983346207417, 0.3872983346207417),
        float2(0.3872983346207417, 0.3872983346207417)
    };
    float3 interferenceSum = ZERO3;
    float fresnelResult = 0.0;
    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with Sobol offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = SampleDepth(depthMap, sampleUV);
        float3 sampleNormal = calcNormal(depthMap, sampleUV);

        // Phase coordinate with depth-aware projection
        float3 phaseCoord = float3(sampleUV-0.5, depth*DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with enhanced polarization
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(halfDir, viewDirSample));
        float theta = acos(cosTheta);
        float fresnelS = pow(abs(1.0 - cosTheta), EPSILON + FresnelPower); // Schlick’s s-polarized
        float fresnelP = fresnelS * (1.0 - 0.18 * dot(viewDirSample, sampleNormal) * (1.0 + 0.1 * sin(time * 0.2))); // Dynamic p-polarized
        float fresnel = 0.5 * (fresnelS + fresnelP);
        fresnelResult += fresnel;
        // Optical path differences with multi-scale grating interaction
        float fineProj = dot(normalize(phaseCoord - 0.5), perpGratingDir);
        float3 finePath = fineProj / fineGratingSpacing;
        float3 finePhase = 2.0 * 3.14159265358979323846 * finePath / lambda;

        float broadProj = dot(normalize(phaseCoord - 0.5), gratingDir);
        float3 broadPath = broadProj / broadGratingSpacing;
        float3 broadPhase = 2.0 * 3.14159265358979323846 * broadPath / lambda;

        // Total phase with cross-grating modulation
        float3 crossModulation = 0.1 * sin(finePhase * broadPhase * 0.5); // Non-linear grating interaction
        float3 totalPhase = finePhase + 0.5773502691896257 * broadPhase + theta + 0.03 * lambda / (550.0 * 1e-9) + crossModulation + time;

        // Dynamic coherence model with temporal decay
        float3 pathDiff = abs(finePath + 0.5773502691896257 * broadPath) * lambda;
        float dynamicCoherence = coherenceLength * (1.0 + 0.05 * cos(time * 0.1)); // Temporal coherence variation
        float3 gaussianTerm = exp(-pow(pathDiff / dynamicCoherence, 2.0) * 0.6931471805599453);
        float3 lorentzianTerm = dynamicCoherence / (dynamicCoherence + 0.25 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.65 * gaussianTerm + 0.35 * lorentzianTerm;

        // Interference pattern with PBR and iridescence
        float3 baseIntensity = diffuseColor * (0.35 + 0.65 * fresnel);
        float3 interference = baseIntensity * cos(totalPhase) * coherenceFactor;

        interferenceSum += interference;
    }

    // Normalize and apply polarization-dependent spectral dispersion
    interferenceSum /= N_AA_SAMPLES;
    fresnelResult /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + saturate(0.07 * (lambda / (780.0 * 1e-9) - 1.0)) * (1.0 + 0.2 * fresnelResult * saturate(dot(normalize(normal), viewDir)));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}

float3 InterferencePattern5(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float3 coherenceLengths)
{
    float3x3 tbn = CalcTBN(normal);
    // Convert wavelengths to meters with precise spectral clamping
    float3 lambda = clamp(nmToM(wavelengthsNM), 380.0e-9, 780.0e-9); // Visible spectrum in meters

    // Grating parameters with multi-scale modulation
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float baseSpacing = nmToM(length(RGBToWavelengthsNM(diffuseColor))); // Material-driven base period
    float3 fineGratingSpacing = Mix2 * baseSpacing * (1.0 + 0.06 * dot(normalize(normal), normalize(calcNormal(gratingDepth1, uv))));
    float3 broadGratingSpacing = baseSpacing * 1.7320508075688772; // sqrt(3) for harmonic richness
    float3 gratingNormal = calcNormal(depthMap, uv);
    float3 gratingDir = normalize(float3(gratingNormal.xy, 0.0)); // 2D grating direction
    float3 perpGratingDir = normalize(float3(-gratingDir.y, gratingDir.x, 0.0)); // Strict 2D orthogonality
    
    // Anti-aliasing setup with adaptive low-discrepancy sampling
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.3872983346207417, -0.3872983346207417), // Sobol sequence for uniform coverage
        float2(0.3872983346207417, -0.3872983346207417),
        float2(-0.3872983346207417, 0.3872983346207417),
        float2(0.3872983346207417, 0.3872983346207417)
    };
    float3 interferenceSum = ZERO3;
    float fresnelResult = 0.0;
    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with Sobol offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = clamp(SampleDepth(depthMap, sampleUV), 0.0, 1.0);
        float3 sampleNormal = normalize(calcNormal(depthMap, sampleUV));
        
        float3x3 sampleTbn = CalcTBN(sampleNormal);

        // Phase coordinate with depth-aware projection
        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with enhanced polarization
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(normalize(halfDir), sampleNormal));
        float theta = acos(cosTheta);
        float fresnelS = pow(1.0 - cosTheta, 5.0); // Schlick’s s-polarized
        float fresnelP = fresnelS * (1.0 - 0.15 * dot(normalize(viewDirSample), sampleNormal) * (1.0 + 0.08 * cos(time * 0.15))); // Dynamic p-polarized
        float fresnel = 0.5 * (fresnelS + fresnelP);
        fresnelResult += fresnel;

        // Optical path differences with multi-angle diffraction
        float fineProj = dot(phaseCoord, perpGratingDir);
        float3 finePath = fineProj / fineGratingSpacing;
        float3 finePhase = 2.0 * 3.14159265358979323846 * finePath / lambda * (1.0 + 0.05 * cosTheta);

        float broadProj = dot(phaseCoord, gratingDir);
        float3 broadPath = broadProj / broadGratingSpacing;
        float3 broadPhase = 2.0 * 3.14159265358979323846 * broadPath / lambda * (1.0 + 0.03 * cosTheta);

        // Total phase with refined cross-grating modulation
        float3 crossModulation = 0.05 * sin(0.3 * (finePhase + broadPhase));
        float3 totalPhase = finePhase + 0.5773502691896257 * broadPhase + theta + 0.025 * lambda / (550.0 * 1e-9) + crossModulation + time;

        // Vectorized coherence model with waveform transformations
        float3 pathDiff = abs(finePath + 0.5773502691896257 * broadPath) * lambda;
        float t = time * 0.08; // Temporal driver for coherence
        float3 waveformMod = float3(
            0.04 * sin(t), // Sinusoidal for red
            0.04 * frac(t) * 2.0 - 0.04, // Sawtooth for green
            0.04 * (1.0 - 2.0 * abs(frac(t) - 0.5)) // Triangular for blue
        );
        float3 dynamicCoherence = clamp(coherenceLengths * (1.0 + waveformMod), 1e-7, 1e-5); // Per-channel waveform modulation
        float3 gaussianTerm = exp(-pow(pathDiff / dynamicCoherence, 2.0) * 0.6931471805599453);
        float3 lorentzianTerm = dynamicCoherence / (dynamicCoherence + 0.2 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.7 * gaussianTerm + 0.3 * lorentzianTerm;

        // Interference pattern with PBR and iridescence
        float3 baseIntensity = diffuseColor * (0.3 + 0.7 * fresnel);
        float3 interference = baseIntensity * cos(totalPhase) * coherenceFactor;

        interferenceSum += interference;
    }

    // Normalize and apply polarization-dependent spectral dispersion
    interferenceSum /= N_AA_SAMPLES;
    fresnelResult /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + 0.06 * (lambda / (780.0 * 1e-9) - 1.0) * (1.0 + 0.25 * fresnelResult * saturate(dot(normalize(normal), normalize(viewDir))));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}


float3 InterferencePattern6(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float3 coherenceLengths)
{
    // Convert wavelengths to meters with precise spectral clamping
    float3 lambda = clamp(nmToM(wavelengthsNM), 380.0e-9, 780.0e-9); // Visible spectrum in meters

    // Grating parameters with multi-scale modulation
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float baseSpacing = nmToM(length(RGBToWavelengthsNM(diffuseColor))); // Material-driven base period
    float FineInterferenceDensity = 0.01; // Example: 0.01 means 100 periods across 1 unit UV
    float BroadInterferenceDensity = 0.007; // Slightly different for the broad pattern

    float3 gratingNormalMapSample = calcNormal(depthMap, uv);
    float2 GratingDirection1 = normalize(gratingNormalMapSample.xy); // Primary grating direction from normal map
    float2 GratingDirection2 = normalize(float2(-GratingDirection1.y, GratingDirection1.x)); // Orthogonal to GratingDirection1

    // Scale grating spacing by these density factors
    float fineGratingSpacing = FineInterferenceDensity * baseSpacing * (1.0 + 0.06 * dot(normalize(normal), normalize(float3(GratingDirection1, 0.0))));
    float broadGratingSpacing = BroadInterferenceDensity * baseSpacing * 1.7320508075688772; // sqrt(3) for harmonic richness

    // Anti-aliasing setup with adaptive low-discrepancy sampling
    static const float N_AA_SAMPLES = 4.0;
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.3872983346207417, -0.3872983346207417), // Sobol sequence for uniform coverage
        float2(0.3872983346207417, -0.3872983346207417),
        float2(-0.3872983346207417, 0.3872983346207417),
        float2(0.3872983346207417, 0.3872983346207417)
    };
    float3 interferenceSum = ZERO3;
    float fresnelResult = 0.0;

    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        // Sample with Sobol offset
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = clamp(SampleDepth(depthMap, sampleUV), 0.0, 1.0);
        float3 sampleNormal = normalize(calcNormal(depthMap, sampleUV));

        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        // Diffraction angle with enhanced polarization
        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(halfDir, sampleNormal));
        float theta = acos(cosTheta);
        float fresnelS = pow(1.0 - cosTheta, FresnelPower); // Schlick’s s-polarized
        float fresnelP = fresnelS * (1.0 - 0.15 * dot(viewDirSample, sampleNormal) * (1.0 + 0.08 * cos(time)));
        float fresnel = 0.5 * (fresnelS + fresnelP);
        fresnelResult += fresnel;

        // Optical path differences with explicit spatial frequency
        // These are now purely based on the UV coordinates projected onto the grating directions.
        float fineProj = dot(sampleUV, GratingDirection1);
        float broadProj = dot(sampleUV, GratingDirection2);

        // The 'path' here is now effectively a normalized position along the grating direction.
        // It's scaled by the 'spacing' to convert into an optical path length.
        float3 finePath = fineProj * fineGratingSpacing;
        float3 broadPath = broadProj * broadGratingSpacing;

        // The optical path difference (OPD) is crucial for interference.
        // For simple gratings, OPD is often a function of position * grating_period / wavelength.
        // We're essentially calculating (position_in_UV * density_factor)
        float3 finePhase = 2.0 * 3.14159265358979323846 * finePath / lambda * (1.0 + 0.05 * cosTheta);
        float3 broadPhase = 2.0 * 3.14159265358979323846 * broadPath / lambda * (1.0 + 0.03 * cosTheta);

        // Total phase with refined cross-grating modulation
        float3 crossModulation = 0.05 * sin(0.3 * (finePhase + broadPhase));
        float3 totalPhase = finePhase + 0.5773502691896257 * broadPhase + theta + 0.025 * time * lambda / (550.0 * 1e-9) + crossModulation;

        // Vectorized coherence model with waveform transformations
        // Ensure pathDiff is also based on the new finePath/broadPath
        float3 pathDiff = abs(finePath + 0.5773502691896257 * broadPath); // Removed * lambda here, as path is already length
        float t = time * 0.08; // Temporal driver for coherence
        float3 waveformMod = float3(
            0.04 * sin(t), // Sinusoidal for red
            0.04 * frac(t) * 2.0 - 0.04, // Sawtooth for green
            0.04 * (1.0 - 2.0 * abs(frac(t) - 0.5)) // Triangular for blue
        );
        float3 dynamicCoherence = clamp(coherenceLengths * (1.0 + waveformMod), 1e-7, 1e-5); // Per-channel waveform modulation
        float3 gaussianTerm = exp(-pow(pathDiff / dynamicCoherence, 2.0) * 0.6931471805599453);
        float3 lorentzianTerm = dynamicCoherence / (dynamicCoherence + 0.2 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.7 * gaussianTerm + 0.3 * lorentzianTerm;

        // Interference pattern with PBR and iridescence
        float3 baseIntensity = diffuseColor * (0.3 + 0.7 * fresnel);
        float3 interference = baseIntensity * cos(totalPhase) * coherenceFactor;

        interferenceSum += interference;
    }

    // Normalize and apply polarization-dependent spectral dispersion
    interferenceSum /= N_AA_SAMPLES;
    fresnelResult /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + 0.06 * (lambda / (780.0 * 1e-9) - 1.0) * (1.0 + 0.25 * fresnelResult * saturate(dot(normalize(normal), viewDir)));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}
// Advanced holographic attenuation function returning float3 for RGB contributions
float3 HolographicAttenuation(float distance, float3 wavelengths, float3 interference, float2 uv, float3 viewDir, float3 lightDir, float3 normal, float coherence)
{
    // Base attenuation with softened decay
    float baseAttenuation = 1.0 / (1.0 + 0.1 * distance + 0.03 * distance * distance);
    float3x3 tbn = CalcTBN(normal);

    // Fresnel-like interference term
    float NdotV = max(dot(normal, normalize(viewDir)), EPSILON);
    float fresnel = saturate(1.0 - pow(abs(1.0 - NdotV + EPSILON), abs(max(FresnelPower, EPSILON)))); // Simplified Fresnel for holographic sheen
    
    // Depth-based scattering from depthMap
    float depth = SampleDepth(depthMap, uv);
    
    float3 channelLambda = max((clamp((wavelengths - MIN_WAVELENGTHS), 0, WAVELENGTH_RANGES)) / (WAVELENGTH_RANGES), EPSILON3);
    // Multi-scale diffraction with two grating scales
    
    // Coherence factor with polarization-like term
    
    float3 polarization = .5 + .5 * sin(2.0 * 3.14159 * dot(normalize(viewDir + lightDir), normal) + time);
        
    float3 waveModulation1 = .5 + .5 * cos((2.0 * 3.14159 * (distance * coherence) / (channelLambda) + time));
  
    // Combine terms
    float3 attenuations =
       max(baseAttenuation, EPSILON) *
        max(waveModulation1, EPSILON) *
       max(coherence, EPSILON) *
       max(polarization, EPSILON) *
        max(interference, EPSILON) *
        max(fresnel, EPSILON);
   
    return clamp(abs(attenuations), 0.0, 1.0);
}




float3 RGBToWavelengthsNM_Enhanced(float3 rgb)
{
    // Normalize RGB components to be safe, though typically they are [0,1]
    rgb = saturate(rgb);

    // Base wavelengths
    float3 base_wavelengths = RGBToWavelengthsNM(rgb);

    // Calculate shifts based on color intensity (centric shift)
    // A brighter component could mean a more "pure" or slightly shifted primary.
    // Using (component * 2 - 1) to map [0,1] to [-1,1] range for bidirectional shift.
    float r_shift = (rgb.r * 2.0f - 1.0f) * WAVELENGTH_SENSITIVITY_R * 0.5f * cos(time);
    float g_shift = (rgb.g * 2.0f - 1.0f) * WAVELENGTH_SENSITIVITY_G * 0.5f * sin(time);
    float b_shift = (rgb.b * 2.0f - 1.0f) * WAVELENGTH_SENSITIVITY_B * 0.5f * tan(time);

    float3 shifted_wavelengths = base_wavelengths + float3(r_shift, g_shift, b_shift);

    // Ensure some minimum separation if colors are very similar (e.g., grayscale)
    // This is a simple way to force some chromatic spread.
    // For grayscale (r=g=b), the shifts might be similar.
    if (abs(shifted_wavelengths.r - shifted_wavelengths.g) < MIN_SPECTRAL_SEPARATION_NM)
    {
        shifted_wavelengths.r -= MIN_SPECTRAL_SEPARATION_NM * 0.7f;
        shifted_wavelengths.g += MIN_SPECTRAL_SEPARATION_NM * 0.3f; // Keep G somewhat central
    }
    if (abs(shifted_wavelengths.g - shifted_wavelengths.b) < MIN_SPECTRAL_SEPARATION_NM)
    {
        shifted_wavelengths.g -= MIN_SPECTRAL_SEPARATION_NM * 0.3f;
        shifted_wavelengths.b += MIN_SPECTRAL_SEPARATION_NM * 0.7f;
    }
    // Re-check R-B separation after G adjustments (less critical but good for wide spreads)
    if (abs(shifted_wavelengths.r - shifted_wavelengths.b) < MIN_SPECTRAL_SEPARATION_NM * 2.0f)
    {
        // if R and B became too close after G moved
        if (shifted_wavelengths.r < shifted_wavelengths.b)
        {
            shifted_wavelengths.r -= MIN_SPECTRAL_SEPARATION_NM * 0.5f;
            shifted_wavelengths.b += MIN_SPECTRAL_SEPARATION_NM * 0.5f;
        }
        else
        {
            shifted_wavelengths.r += MIN_SPECTRAL_SEPARATION_NM * 0.5f;
            shifted_wavelengths.b -= MIN_SPECTRAL_SEPARATION_NM * 0.5f;
        }
    }
    
    // Clamp to a reasonable overall visible spectrum (e.g., 380nm to 780nm)
    // MIN_WAVELENGTHS and MAX_WAVELENGTHS should be defined elsewhere e.g. float3(380,380,380)
    // shifted_wavelengths = clamp(shifted_wavelengths, MIN_WAVELENGTHS_GLOBAL, MAX_WAVELENGTHS_GLOBAL);

    return shifted_wavelengths;
}



float3 ToneMapACESFilmic(float3 linearHDRColor)
{
    // Tunable parameters for the curve:
    // These are common starting points from the Narkowicz/Uncharted 2 presentation,
    // adapted for a more general ACES-like feel.
    // Different sets of coefficients can give slightly different looks.
    const float A = 2.51f; // Shoulder Strength
    const float B = 0.03f; // Linear Strength
    const float C = 2.43f; // Linear Angle
    const float D = 0.59f; // Toe Strength
    const float E = 0.14f; // Toe Numerator
    // F = Toe Denominator (E/F = Toe Angle), usually derived or implicit

    // Apply exposure if needed (can be a global shader constant)
    // float exposure = 1.0f;
    // float3 exposedColor = linearHDRColor * exposure;

    float3 tempColor = linearHDRColor; // Use exposedColor if you add exposure

    // ( (x*(A*x+B)) / (x*(C*x+D)+E) )
    // The formula aims to map an input 'x' (our color) to a new range.
    // It's applied per-channel.
    tempColor = (tempColor * (A * tempColor + B)) / (tempColor * (C * tempColor + D) + E);

    // Output is typically in a range that's good for LDR displays, but still linear.
    // Saturation is important to avoid colors becoming washed out after tone mapping.
    // A common practice is to saturate the result to prevent negative or overly bright values
    // if the input HDR color was extremely out of typical range or coefficients are aggressive.
    return saturate(tempColor);
}

// Holographic Shader Defines & Mappings

// --- Precision and Common Math Constants ---
#define PI_PRECISE 3.14159265359f
#define PIOver2 (PI_PRECISE / 2.0f)
#define PIOver4 (PI_PRECISE / 4.0f)
#define PIOver8 (PI_PRECISE / 8.0f)

// Small epsilon values for numerical stability
#define EPSILON_WAVELENGTH 1.0e-7f          // For preventing division by zero with wavelengths
#define EPSILON_REFRACTION 1.0e-7f          // For refractive index calculations
#define EPSILON_BEAM 1.0e-6f                // For Gaussian beam waist
#define EPSILON_THICKNESS 1.0e-7f           // For effective thickness
#define EPSILON_SPECULAR_DIV 1.0e-5f        // For PBR specular denominator
#define EPSILON_DEFAULT 1.0e-6f             // General small number

#define MIN_WAVELENGTHS_PRECISE float3(380.0f, 380.0f, 380.0f) // Min representable wavelengths in nm
#define MAX_WAVELENGTHS_PRECISE float3(780.0f, 780.0f, 780.0f) // Max representable wavelengths in nm (for clamping in RGBToWavelengths)

// Refractive index of base medium (e.g., air/vacuum)
#define N_MEDIUM_BASE 1.000293f
// Controls how strongly medium's refractive index changes with wavelength (Cauchy-like B coefficient)
#define N_MEDIUM_DISPERSION_FACTOR 0.15f // Tunable: higher for more medium dispersion

// For ComputePrismaticEffect's surfaceDepthGradientNM_per_UV influence
#define GRADIENT_THICKNESS_SENSITIVITY 0.001 // Tunable: How much surface gradient affects optical thickness variation

// Grating scales (higher values = denser/finer gratings)
#define USER_UV_TO_GRATING_FINE_SCALE 500.0    // Tunable: e.g., 500.0f to 5000.0f
#define USER_UV_TO_GRATING_BROAD_SCALE 50.0   // Tunable: e.g., 50.0f to 500.0f

// Toggle for the "Exotic Interactions" / E_obj2 in ComputePrismaticEffect
#define ENABLE_EXOTIC_INTERACTIONS (KeyQDown > 0.5f ? 0 : 1) // Use KeyQDown from cbuffer as a toggle (0 or 1)

#define GlobalQuantumPhaseOffset float3(f06 * PI_PRECISE, f07 * PI_PRECISE, f08 * PI_PRECISE)

#define N_AA_SAMPLES 4 // Example: No stochastic AA. Set to 2, 3, or 4 for AA.
#define MAX_HOLO_FILM_THICKNESS_METERS_PARAM DepthScale
#define UV_TO_SURFACE_METERS 1 // Example mapping to an existing cbuffer var
#define LightColor float3(1.0f, 1.0f, 1.0f)   // Assume white light, or take from cbuffer if available
#define LightIntensity f11                     // Tunable light brightness, mapped to f11

// Ambient Light
#define AmbientColor float3(0.05f, 0.05f, 0.08f) // Default cool ambient, or take from cbuffer


#if N_AA_SAMPLES == 2
static const float2 blue_noise_offsets[N_AA_SAMPLES] = { float2(-0.25f, -0.25f), float2(0.25f, 0.25f) };
#elif N_AA_SAMPLES == 3 // Asymmetrical, usually 2, 4, 8, 16 are better for patterns
static const float2 blue_noise_offsets[N_AA_SAMPLES] = { float2(-0.3f, -0.15f), float2(0.0f, 0.3f), float2(0.3f, -0.15f) };
#elif N_AA_SAMPLES == 4
static const float2 blue_noise_offsets[N_AA_SAMPLES] =
{
    float2(-0.375f, -0.125f), float2(0.125f, -0.375f),
    float2(0.375f, 0.125f), float2(-0.125f, 0.375f)
};
#elif N_AA_SAMPLES == 1 || N_AA_SAMPLES == 0 // Only one sample, effectively no AA loop for this part
static const float2 blue_noise_offsets[N_AA_SAMPLES] = { float2(0.0f, 0.0f) };
#endif


// (Assuming C3, MaterialSellmeier, etc. are defined)
// (User parameters like USER_UV_TO_GRATING_FEATURE_SCALE should be fine-tuned for extreme detail)

// High-quality hash for procedural seeding (deterministic)
uint Hash(uint3 state)
{
    state ^= (state.yzx << 11u);
    state.yzx ^= (state.yzx >> 7u);
    state.xyz ^= (state.xyz << 7u);
    state.xyz ^= (state.xyz >> 5u);
    state.yzx ^= (state.yzx << 9u);
    state.yzx ^= (state.yzx >> 11u);
    return state.x ^ state.y ^ state.z;
}
float HashToFloat(uint3 state, uint seedOffset)
{ // Returns [0,1)
    return float(Hash(state + seedOffset)) / 4294967296.0f;
}


C3 ComputePrismaticEffect2(
    float3 pixelPosNM, // Interaction point in nm
    float3 wavelengthsNM, // Effective wavelengths for R, G, B (nm)
    float baseInteractionDepthNM, // Base thickness of holographic medium in nm
    float2 uv, // UV coordinates (0-1)
    float2 surfaceDepthGradientNM_per_UV, // Gradient of holographic surface (nm / UV unit)
    float3 surfaceNormalVecW, // Geometric normal (World)
    float3 viewDirW, // View direction (World)
    float3 lightPosNM_Ref, // Origin of reference wave in nm
    // --- Hacker Additions ---
    uint passSeed, // Seed based on PassNum for deterministic variation
    C3 E_in_from_prev_layer // Complex field from previous layer/pass (C0 if first pass)
)
{
    float depth = SampleDepth(depthMap, uv);
    float3 pixel = float3(uv, depth);
    float3 pixelNM = mToNm(pixel);
    
    // 1. Numerical Safeguards & Hyper-Precise Constants
    wavelengthsNM = clamp(wavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS); // Use a very small, non-zero float3
    float3 k0_nm = (2.0f * PI_PRECISE) / wavelengthsNM; // PI_PRECISE, EPSILON_WAVELENGTH

    // 2. Procedurally Generated "Exotic" Material Properties
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    mat.metallic = saturate(mat.metallic);
    mat.albedo = saturate(mat.albedo);
    
    float3 n_material = CalculateRefractiveIndex(CV0(wavelengthsNM), mat.coeff);
    
    float3 plasmaNoise = sin(time * 0.5f + pixelPosNM * 0.001f); // Simple placeholder noise
    float3 n_medium_dynamic = 0.4f * abs(
        plasmaNoise + 0.5f * (plasmaNoise.yzx * 1.5f)
    );

    float3 n_medium = N_MEDIUM_BASE + N_MEDIUM_DISPERSION_FACTOR * (550.0f / wavelengthsNM - 1.0f) + n_medium_dynamic;
    n_medium = max(n_medium, 1.0f + EPSILON_REFRACTION);
    float3 k_medium = k0_nm * n_medium;

    float passFactor = saturate((float) PassNum / NumPasses); // Assuming PassNum, NumPasses are global
    float3 refBeamDynamicOffset = float3( /* ... sophisticated dynamic offset from before ... */
        0.1f * sin(PIOver8 * PassNum + time + passFactor * PI_PRECISE + noise3_01(noiseMap1, nmToM(pixelNM)).x),
        0.1f * cos(PIOver4 * PassNum + time - passFactor * PIOver2 + noise3_01(noiseMap1, nmToM(pixelNM)).y),
        0.03f * sin(time + PassNum + noise3_01(noiseMap1, nmToM(pixelNM)).z)
    );
    float3 refBeamDir = normalize(viewDirW - refBeamDynamicOffset);
    float3 refPhase = PhaseOffset.g * k_medium * dot(normalize(pixelPosNM - lightPosNM_Ref), refBeamDir);
    
    
    float3 beamWaistParam = 5.0; // Tightly controlled beam width parameter
    float dist_sq_from_center = dot(uv - .5, uv - .5);
    float3 gaussianBeamAmplitudeScalar = exp(-dist_sq_from_center / max(EPSILON_BEAM, beamWaistParam));
    float3 refInteractionFactor = saturate(dot(viewDirW, surfaceNormalVecW)) * (0.7f + 0.3f * passFactor);
    float3 E_ref_amplitude = PhaseOffset.r * refInteractionFactor * gaussianBeamAmplitudeScalar * (passFactor > EPSILON ? 0.5f : 1.0f); // Ref beam is primary only on first pass

    C3 E_ref_field;
    E_ref_field.real = E_ref_amplitude * cos(refPhase);
    E_ref_field.imag = E_ref_amplitude * sin(refPhase);
    C3 E_incident = E_ref_field;
    if (PassNum != 0) 
        E_incident = CMul(E_in_from_prev_layer, E_ref_field); // E_ref modulates incoming or acts as source
   
    // 5. Object Wave 1 (E_obj1): Hyper-Detailed Diffraction Grating & Volumetric Phase
    float2 gradientMagnitudeNM_per_UV = surfaceDepthGradientNM_per_UV;
    float2 gradientContributionToThickness = 100 * gradientMagnitudeNM_per_UV * GRADIENT_THICKNESS_SENSITIVITY;
    float3 effectiveThicknessNM = baseInteractionDepthNM + float3(gradientContributionToThickness, 0);
    effectiveThicknessNM = max(effectiveThicknessNM, EPSILON);
    float3 phase_prism_dispersion = (k0_nm * (n_medium - n_material) * nmToM(effectiveThicknessNM));

    // Multi-scale, wavelength-dependent, animated procedural grating phase
    float uv_grating_scale_fine = USER_UV_TO_GRATING_FINE_SCALE * (1.0f + 0.1f * noise3_01(noiseMap1, pixelNM).x);
    float uv_grating_scale_broad = USER_UV_TO_GRATING_BROAD_SCALE * (1.0f + 0.1f * noise3_01(noiseMap1, pixelNM).y);

    float2 gratingVec1 = float2(sin(passFactor * PI_PRECISE + time), cos(passFactor * PI_PRECISE + time)); // Orientation varies per layer
    float2 gratingVec2 = float2(-gratingVec1.y, gratingVec1.x);

    float3 phase_grating = 0.0f;
    phase_grating.r += 0.5f * noiseSimple2(gratingVec2 * uv * uv_grating_scale_broad + TanhFactor.x * (wavelengthsNM.x / 550.0f), time);
    phase_grating.g += 0.5f * noiseSimple2(gratingVec2 * uv * uv_grating_scale_broad + TanhFactor.y * (wavelengthsNM.y / 550.0f), time);
    phase_grating.b += 0.5f * noiseSimple2(gratingVec2 * uv * uv_grating_scale_broad + TanhFactor.z * (wavelengthsNM.z / 550.0f), time);

   
    float3 totalObjectPhase1 = phase_prism_dispersion;
    totalObjectPhase1 += (totalObjectPhase1 * CosineFactor.z + .1 * phase_grating);
    // Diffraction efficiency with micro-roughness considerations (stochastic amplitude modulation)
    float base_diff_efficiency = 0.8f;
    float micro_roughness_mod = 1.0f - 0.1f * (noise3_01(noiseMap1, nmToM(pixelNM)).y); // Simulates slight scattering loss
    float3 diffraction_amplitude_factor = base_diff_efficiency * micro_roughness_mod * saturate(dot(viewDirW, surfaceNormalVecW));
    
    // E_obj1 is the field component generated by this layer's structure, from E_incident
    C3 E_obj1 = CMul(CExp(CV0(totalObjectPhase1)), CVV(diffraction_amplitude_factor)); // Phase shift applied
    E_obj1 = CMul(E_incident, E_obj1); // This layer's structure modulates the incident field


    C3 E_obj2 = C00;
    if (PassNum > 0)
    { // Only on deeper layers
        uint3 remoteSeedState = uint3(asuint(pixelPosNM.z), asuint(pixelPosNM.x), asuint(pixelPosNM.y) ^ (passSeed + 100u));
        float remote_phase_influence = HashToFloat(remoteSeedState, 59u) * 2.0f * PI_PRECISE;
        float3 phase_entangled = totalObjectPhase1 * 0.1f + remote_phase_influence + wavelengthsNM * GlobalQuantumPhaseOffset.xyz;
        float3 amplitude_entangled = 0.1f * HashToFloat(remoteSeedState, 61u) * diffraction_amplitude_factor;
        E_obj2.real = amplitude_entangled * cos(phase_entangled + time);
        E_obj2.imag = amplitude_entangled * sin(phase_entangled + time);
    }
    
    C3 transmitted_field = CAdd(E_in_from_prev_layer, CExp(CVV(totalObjectPhase1))); // E_in gets phase shifted by this layer
    transmitted_field = CAdd(transmitted_field, CVV(diffraction_amplitude_factor)); // And attenuated/modulated
    
    // If E_ref_field is a separate illumination source *within* this layer (e.g. for active media)
    C3 internally_generated_field = CAdd(E_ref_field, CExp(CVV(totalObjectPhase1 * 0.5f))); // E.g. reference beam excites this layer
    internally_generated_field = CAdd(internally_generated_field, CVV(diffraction_amplitude_factor * 0.2f));


    C3 E_total_output_from_layer = E_obj1;
    if (PassNum != 0)
        E_total_output_from_layer = CAdd(E_total_output_from_layer, transmitted_field); // E_obj1 used E_incident which was E_ref on pass 0
    if (PassNum > 0)
        E_total_output_from_layer = CMul(E_total_output_from_layer, internally_generated_field);
    E_total_output_from_layer = CAdd(E_total_output_from_layer, E_obj2);
    
    // Master scaling - perhaps remove if amplitudes are well controlled, or make it pass-dependent
    //E_total_output_from_layer = CMul(E_total_output_from_layer, CVV(1.0f + 0.1f * passFactor));


    return E_total_output_from_layer;
}



// Define precise constants
static const float PI_PRECISE_PS = 3.14159265359f;

// ... other constants ...

float3 InterferencePattern7(float3 viewDir, float3 lightDir, float3 normal, float2 uv, float3 wavelengthsNM, float3 coherenceLengths)
{
    // Convert wavelengths to meters with precise spectral clamping
    float3 lambda = clamp(nmToM(wavelengthsNM), 380.0e-9, 780.0e-9); // Visible spectrum in meters

    // Grating parameters with multi-scale modulation
    float3 diffuseColor = SampleDiffuse(diffuseMap, uv);
    float baseSpacing = nmToM(length(RGBToWavelengthsNM(diffuseColor))); // Material-driven base period

    float FineInterferenceDensity = 0.01; // Example: 0.01 means 100 periods across 1 unit UV
    float BroadInterferenceDensity = 0.007; // Slightly different for the broad pattern

    float3 gratingNormalMapSample = calcNormal(depthMap, uv);
    float2 GratingDirection1 = normalize(gratingNormalMapSample.xy); // Primary grating direction from normal map
    float2 GratingDirection2 = normalize(float2(-GratingDirection1.y, GratingDirection1.x)); // Orthogonal to GratingDirection1

    float fineGratingSpacing = FineInterferenceDensity * baseSpacing * (1.0 + 0.06 * dot(normal, normalize(float3(GratingDirection1, 0.0))));
    float broadGratingSpacing = BroadInterferenceDensity * baseSpacing * 1.7320508075688772; // sqrt(3) for harmonic richness

    // --- NEW: Volumetric Depth Parameters ---
    // Controls the "depth" of the interference pattern. Higher values mean more layers/bands in depth.
    float DepthInterferenceDensity = 0.05; // Adjust this to control how many "volumetric" layers you see
    float DepthModulationStrength = 0.5; // How strongly depth modulates color/intensity
    
    // Define a richer color gradient or palette for interference
    // We'll use a series of colors to interpolate between based on the phase.
    // Example colors:
    // Magenta, Blue, Cyan, Green, Yellow, Red
    static const float3 InterferenceColors[6] =
    {
        float3(1.0, 0.0, 1.0), // Magenta
        float3(0.0, 0.0, 1.0), // Blue
        float3(0.0, 1.0, 1.0), // Cyan
        float3(0.0, 1.0, 0.0), // Green
        float3(1.0, 1.0, 0.0), // Yellow
        float3(1.0, 0.0, 0.0) // Red
    };
    static const int NumInterferenceColors = 6;
    // --- END NEW ---

    // Anti-aliasing setup with adaptive low-discrepancsampling
    
    float2 oosz = GetOosz(depthMap);
    static const float2 aaOffsets[4] =
    {
        float2(-0.3872983346207417, -0.3872983346207417),
        float2(0.3872983346207417, -0.3872983346207417),
        float2(-0.3872983346207417, 0.3872983346207417),
        float2(0.3872983346207417, 0.3872983346207417)
    };
    float3 interferenceSum = ZERO3;
    float fresnelResult = 0.0;
    [unroll]
    for (int i = 0; i < N_AA_SAMPLES; ++i)
    {
        float2 sampleUV = uv + oosz * aaOffsets[i];
        float depth = clamp(SampleDepth(depthMap, sampleUV), 0.0, 1.0);
        float3 sampleNormal = normalize(calcNormal(depthMap, sampleUV));
        
        float3x3 tbn = CalcTBN(sampleNormal);

        float3 phaseCoord = float3(sampleUV-0.5, depth * DepthScale);
        float3 viewDirSample = normalize(ViewPosUM - phaseCoord);
        float3 lightDirSample = normalize(LightPosUM - phaseCoord);

        float3 halfDir = normalize(viewDirSample + lightDirSample);
        float cosTheta = saturate(dot(normalize(halfDir), sampleNormal));
        float theta = acos(cosTheta);
        float fresnelS = pow(1.0 - cosTheta, 5.0);
        float fresnelP = fresnelS * (1.0 - 0.15 * dot(normalize(viewDirSample), sampleNormal) * (1.0 + 0.08 * cos(time * 0.15)));
        float fresnel = 0.5 * (fresnelS + fresnelP);
        fresnelResult += fresnel;

        float fineProj = dot(sampleUV, GratingDirection1);
        float broadProj = dot(sampleUV, GratingDirection2);

        float3 finePath = fineProj * fineGratingSpacing;
        float3 broadPath = broadProj * broadGratingSpacing;

        // --- NEW: Depth-dependent phase ---
        // Project depth onto a "depth grating"
        float depthPhaseProj = depth * DepthInterferenceDensity;
        float3 depthPhase = 2.0 * 3.14159265358979323846 * depthPhaseProj / lambda;
        // --- END NEW ---

        float3 finePhase = 2.0 * 3.14159265358979323846 * finePath / lambda * (1.0 + 0.05 * cosTheta);
        float3 broadPhase = 2.0 * 3.14159265358979323846 * broadPath / lambda * (1.0 + 0.03 * cosTheta);

        // --- NEW: Integrate depthPhase into totalPhase ---
        float3 crossModulation = 0.05 * sin(0.3 * (finePhase + broadPhase));
        float3 totalPhase = finePhase + 0.5773502691896257 * broadPhase + depthPhase + theta + 0.025 * time * lambda / (550.0 * 1e-9) + crossModulation;
        // --- END NEW ---
        
        // totalPhase already updated above

        float3 pathDiff = abs(finePath + 0.5773502691896257 * broadPath + depthPhaseProj); // Include depth for coherence as well
        float t = time * 0.08;
        float3 waveformMod = float3(
            0.04 * sin(t),
            0.04 * frac(t) * 2.0 - 0.04,
            0.04 * (1.0 - 2.0 * abs(frac(t) - 0.5))
        );
        float3 dynamicCoherence = clamp(coherenceLengths * (1.0 + waveformMod), 1e-7, 1e-5);
        float3 gaussianTerm = exp(-pow(pathDiff / dynamicCoherence, 2.0) * 0.6931471805599453);
        float3 lorentzianTerm = dynamicCoherence / (dynamicCoherence + 0.2 * pathDiff * pathDiff);
        float3 coherenceFactor = 0.7 * gaussianTerm + 0.3 * lorentzianTerm;

        // Interference pattern with PBR and iridescence
        float3 baseIntensity = diffuseColor * (0.3 + 0.7 * fresnel);
        
        // --- NEW: Richer color mapping based on totalPhase ---
        // Remap totalPhase from (-PI, PI) or similar to [0, 1] for color lookup
        // We'll use the red channel of totalPhase for a primary lookup,
        // but remember totalPhase is float3, so you might want to average or pick one.
        float phaseNormalized = frac(totalPhase.r / (2.0 * 3.14159265358979323846)); // Normalize phase to [0, 1)

        // Interpolate through the color array
        float colorIndex = phaseNormalized * (NumInterferenceColors - 1);
        int idx1 = floor(colorIndex);
        int idx2 = min(idx1 + 1, NumInterferenceColors - 1);
        float fracPart = frac(colorIndex);
        
        float3 interferenceColor = lerp(InterferenceColors[idx1], InterferenceColors[idx2], fracPart);

        // Modulate color by coherence and base intensity
        float3 interference = interferenceColor * baseIntensity * coherenceFactor;
        // Apply intensity based on cosine of phase for 'wave' effect, but now coloring is independent
        interference *= (0.5 + 0.5 * cos(totalPhase)); // Still keep the constructive/destructive interference intensity
        // --- END NEW ---

        interferenceSum += interference;
    }

    interferenceSum /= N_AA_SAMPLES;
    fresnelResult /= N_AA_SAMPLES;
    float3 dispersion = 1.0 + 0.06 * (lambda / (780.0 * 1e-9) - 1.0) * (1.0 + 0.25 * fresnelResult * saturate(dot(normal, viewDir)));
    return clamp(interferenceSum * dispersion, 0.0, 1.0);
}


// Holographic effect computation per layer/pass
Complex3 ComputePrismaticEffect3(
    float3 pixelPosNM, // Interaction point in nm (e.g., PixelWorldNM)
    float3 wavelengthsNM, // Effective wavelengths for R, G, B (nm)
    float baseInteractionDepthNM, // Base thickness of holographic medium in nm
    float2 uv, // UV coordinates (0-1)
    float2 surfaceDepthGradientNM_per_UV, // Gradient of holographic surface (nm / UV unit)
    float3 surfaceNormalVecW, // Geometric normal (World)
    float3 viewDirW, // View direction (World)
    float3 lightPosNM_Ref, // Origin of reference wave in nm (e.g., LightPosNM)
    // --- Hacker Additions ---
    uint passSeed, // Seed based on PassNum for deterministic variation
    Complex3 E_in_from_prev_layer // Complex field from previous layer/pass (C00 if first pass)
)
{
    // Local aliases for convenience (assuming these are globally available or passed in)
 
    // 1. Numerical Safeguards & Hyper-Precise Constants
    // Clamp wavelengths to prevent division by zero and keep within visible spectrum
    wavelengthsNM = clamp(wavelengthsNM, MIN_WAVELENGTHS_PRECISE + EPSILON_WAVELENGTH, MAX_WAVELENGTHS_PRECISE - EPSILON_WAVELENGTH);
    float3 k0_nm = (2.0f * PI_PRECISE) / wavelengthsNM;

  
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);

    float3 n_material = CMag(RefractiveIndexFromSellmeier(CV0(wavelengthsNM), true, mat));
    n_material = clamp(n_material, 1.0f + EPSILON_REFRACTION, 2.0);
    float3 plasmaNoise = sin(time * 0.5f + pixelPosNM * 0.001f); // Simple placeholder noise
    float3 n_medium_dynamic = 0.4f * abs(
        plasmaNoise + 0.5f * (plasmaNoise.yzx * 1.5f)
    );

    float3 n_medium = mat.nSurrounding + mat.dispersionCoefficientsNm2[0] * (550.0f / wavelengthsNM - 1.0f) + n_medium_dynamic;
    n_medium = clamp(n_medium, 1.0f + EPSILON_REFRACTION, 2.0);
    float3 k_medium = k0_nm * n_medium;

    // 4. Reference Wave (E_ref) - Interacts with incoming field from previous layer
    float passFactor = saturate((float) PassNum / max(1.0f, (float) NumPasses));

    float3 refBeamDynamicOffset = float3(
        0.1f * sin(PIOver8 * PassNum + time + passFactor * PI_PRECISE + plasmaNoise.x),
        0.1f * cos(PIOver4 * PassNum + time - passFactor * PIOver2 + plasmaNoise.y),
        0.03f * sin(time + PassNum + plasmaNoise.z)
    );
    float3 refBeamDir = normalize(viewDirW - refBeamDynamicOffset);
    float3 refPhase = PhaseOffset.g * k_medium * dot(normalize(pixelPosNM - lightPosNM_Ref), refBeamDir);
    
    float3 beamWaistParam = 5.0f; // Tightly controlled beam width parameter
    float dist_sq_from_center = dot(uv - 0.5f, uv - 0.5f);
    float3 gaussianBeamAmplitudeScalar = exp(-dist_sq_from_center / max(EPSILON_BEAM, beamWaistParam));
    float3 refInteractionFactor = saturate(dot(viewDirW, surfaceNormalVecW)) * (0.7f + 0.3f * passFactor);
    float3 E_ref_amplitude = PhaseOffset.r * refInteractionFactor * gaussianBeamAmplitudeScalar * (passFactor > EPSILON_DEFAULT ? 0.5f : 1.0f);

    Complex3 E_ref_field;
    E_ref_field.real = E_ref_amplitude * cos(refPhase);
    E_ref_field.imag = E_ref_amplitude * sin(refPhase);

    Complex3 E_incident = E_ref_field; // E_ref is the primary source for this layer
    if (PassNum != 0)
        E_incident = CMul(E_in_from_prev_layer, E_ref_field); // E_ref modulates incoming or acts as source

    // 5. Object Wave 1 (E_obj1): Hyper-Detailed Diffraction Grating & Volumetric Phase
    // Ensure effectiveThicknessNM handles float2 gradientContributionToThickness correctly
    float gradientMagnitudeScalar = length(surfaceDepthGradientNM_per_UV);
    float3 effectiveThicknessNM = baseInteractionDepthNM + gradientMagnitudeScalar * GRADIENT_THICKNESS_SENSITIVITY;
    effectiveThicknessNM = max(effectiveThicknessNM, EPSILON_THICKNESS); // Use specific epsilon

    float3 phase_prism_dispersion = (k0_nm * (n_medium - n_material) * (effectiveThicknessNM * 1.0e-9f)); // nmToM conversion applied here: 1.0e-9f for nm to meters

    // Multi-scale, wavelength-dependent, animated procedural grating phase
    float uv_grating_scale_fine = USER_UV_TO_GRATING_FINE_SCALE * (1.0f + 0.1f * plasmaNoise.x);
    float uv_grating_scale_broad = USER_UV_TO_GRATING_BROAD_SCALE * (1.0f + 0.1f * plasmaNoise.y);

    float2 gratingVec1 = float2(sin(passFactor * PI_PRECISE + time), cos(passFactor * PI_PRECISE + time));
    float2 gratingVec2 = float2(-gratingVec1.y, gratingVec1.x);

    float3 phase_grating = 0.0f;
    // Simplified noise for simpleNoise:
    float simpleNoiseVal = sin(dot(uv * gratingVec2, gratingVec2) * uv_grating_scale_broad + wavelengthsNM.x * TanhFactor.x + time);

    phase_grating += 0.8f * sin((dot(uv - 0.5f, normalize(gratingVec2)) * uv_grating_scale_fine) * TanhFactor.g * (wavelengthsNM / lerp(400.0f, 800.0f, plasmaNoise.x)) + time + passSeed * 0.5f);
    phase_grating += 0.5f * simpleNoiseVal * (wavelengthsNM / 550.0f);
    
    float3 totalObjectPhase1 = phase_prism_dispersion;
    totalObjectPhase1 += (totalObjectPhase1 * CosineFactor.z + 0.1f * phase_grating);

    // Diffraction efficiency with micro-roughness considerations
    float base_diff_efficiency = 0.8f;
    float micro_roughness_mod = 1.0f - 0.1f * (plasmaNoise.y);
    float3 diffraction_amplitude_factor = base_diff_efficiency * micro_roughness_mod * saturate(dot(viewDirW, surfaceNormalVecW));

    // E_obj1 is the field component generated by this layer's structure, from E_incident
    Complex3 E_obj1 = CMul(CExp(C0V(totalObjectPhase1)), C0V(diffraction_amplitude_factor)); // Phase shift applied
    E_obj1 = CMul(E_incident, E_obj1); // This layer's structure modulates the incident field

    // 6. Object Wave 2 (E_obj2): Non-Local Interactions / Quantum Entanglement inspired (Artistic)
    Complex3 E_obj2 = C00;
    if (ENABLE_EXOTIC_INTERACTIONS > 0) // Use the define
    {
        uint3 remoteSeedState = uint3(asuint(pixelPosNM.z), asuint(pixelPosNM.x), asuint(pixelPosNM.y) ^ (passSeed + 100u));
        float remote_phase_influence = HashToFloat(remoteSeedState, 59u) * 2.0f * PI_PRECISE;
        float3 phase_entangled = totalObjectPhase1 * 0.1f + remote_phase_influence + wavelengthsNM * GlobalQuantumPhaseOffset.xyz;
        float3 amplitude_entangled = 0.1f * HashToFloat(remoteSeedState, 61u) * diffraction_amplitude_factor;
        E_obj2.real = amplitude_entangled * cos(phase_entangled + time);
        E_obj2.imag = amplitude_entangled * sin(phase_entangled + time);
    }

    // 7. Total Field for This Layer: Sum of transmitted incident and newly generated/modulated fields
    // E_obj1 already represents the modulated incoming field. E_obj2 is an added component.
    Complex3 E_total_output_from_layer = E_obj1;
    if (ENABLE_EXOTIC_INTERACTIONS > 0)
    {
        E_total_output_from_layer = CAdd(E_total_output_from_layer, E_obj2);
    }

    return E_total_output_from_layer;
}

C3 ComputeWaveInterference(float2 inputUV, float2 offset, float3 worldPosM,
    float3 wavelengthsNM, float3 normal, out float3 coherenceFactor, out float3 noiseV,
    float3x3 tbn, float3 viewPosM, float3 lightPosM)
{
    float2 oosz = GetOosz(depthMap);
    float3 wl_m = nmToM(wavelengthsNM);
    float depth = worldPosM.z;
    float noiseVx = RandomNoiseAvg(worldPosM);
    
    float noiseVy = RandomNoiseAvg(worldPosM+float3(0,.1,0));

    float noiseVz = RandomNoiseAvg(worldPosM+float3(0,0,.1));

    noiseV = float3(noiseVx, noiseVy, noiseVz);

    float3 pathPixelToLightM = abs(LightPosM - worldPosM);
    float3 pathPixelToEyeM = abs(ViewPosM - worldPosM);
    float totalPathM = length(pathPixelToLightM+ pathPixelToEyeM);

    float3 wavelengthsM = nmToM(clamp(wavelengthsNM, MIN_WAVELENGTHS, MAX_WAVELENGTHS));
    float3 k = 2.0 * PI / wavelengthsM;
        
    // Get textuwere sizes for noise sampling UV scalingG9268
    float2 szDepth = GetSz(depthMap);
    float2 szNoise = GetSz(noiseMap1);
    
    float3 pathDiff = mToUm(abs(totalPathM));
    coherenceFactor = ONE3*saturate(exp(-pathDiff));
    
    // --- 4. Wavelength-dependent Absorption ---
    float3 extinction = clamp(abs(depth), EPSILON, 1-EPSILON);
    float3 absorption = exp(-(extinction * pathDiff));
        
    // --- 5. Phase Calculation ---
    // Base phase from optical path length.
    // The noise is now used to directly modulate the phase, making the interference pattern itself noisy.
    float3 phase = k * totalPathM + noiseV + time;
    
    float3 real = float3(
        cos(phase.x+time) * absorption.x * coherenceFactor.x,
        cos(phase.y+time)* absorption.y * coherenceFactor.y,
        cos(phase.z+time) * absorption.z * coherenceFactor.z);

    float3 imag = sin(phase+time) * absorption * coherenceFactor;
    return CV(real, imag);
}

//--------------------------------------------------------------------------------------
// Main PS
//--------------------------------------------------------------------------------------
float3 HolographicPS(Texture2D<float4> diffuseMap, float2 inputUV, float2 offset, 
    float3 worldPosM, out float3 interference, out float3 fresnel, 
    out float3 fresnelReflectance, out float3 diffraction, out float3 coherenceFactor, out float3 noiseV,
    out float3 viewDir, out float3 lightDir, out float3 pixWorldM, out float3 normal,
    out float3 aberration) : SV_Target
{
    // Combine with albedo
    float2 oosz = GetOosz(depthMap);
    float depth = worldPosM.z;
    float2 aberrationOffset = offset*float2(f07,f07);
    float2 originalOffset = offset;
    offset *= depth;
    MaterialSellmeier mat = CreateMaterial(MaterialIndex);
    
    float3 diffuse = diffuseMap.SampleLevel(sampleTypeMirror, inputUV+offset, 0).rgb;
    float3 wavelengthsNM = clamp(RGBToWavelengthsNM(diffuse * mat.albedo), MIN_WAVELENGTHS, MAX_WAVELENGTHS);
    float3 wavelengthsM = nmToM(wavelengthsNM);
    
            
    depth = SampleDepth(depthMap, inputUV+offset);
    offset = originalOffset;
    depth = SampleDepth(depthMap, inputUV+offset);
    normal = calcNormal(depthMap, inputUV+offset);
    pixWorldM = umToM(float3(inputUV+offset-0.5,depth));
    viewDir = normalize(ViewPosM - pixWorldM);
    lightDir = normalize(LightPosM - pixWorldM);
    float3 halfDir = normalize(viewDir + lightDir);
    float3x3 tbn = CalcTBN(normal);
    
    C3 interference2 = ComputeWaveInterference(inputUV, offset, pixWorldM*PhaseOffset, wavelengthsNM, normal, coherenceFactor, noiseV,
        tbn, lightDir, viewDir);
    
    
    aberration = saturate(SampleDiffuseAberration(diffuseMap, 
            inputUV+offset,aberrationOffset, f08, f09));
   

   wavelengthsNM = RGBToWavelengthsNM(aberration * mat.albedo);
    float NdotV = (max(0, dot(normalize(normal),normalize(viewDir))));
    float NdotH = (max(0, dot(normalize(normal),normalize(halfDir))));
    float NdotL = (max(0, dot(normalize(normal),normalize(halfDir))));
    float HdotV = (max(0, dot(normalize(halfDir),normalize(viewDir))));
    float HdotL = (max(0, dot(normalize(halfDir),normalize(lightDir))));
    
    interference = CSatMag(interference2);
    SpecularResult spec = Specular(normal,viewDir,lightDir, CreateMaterial(MaterialIndex));
    fresnelReflectance = (1.0-NdotV)*CSatMag(spec.FresnelReflectance) * FresnelReflectance;
    
    fresnel = (max(0,dot(normalize(normal),normalize(viewDir)))*CMag(FresnelComplex(CV(mat.etaR, mat.etaI), normal, normalize(lightDir)))) * FresnelPower;
    float3 wavelengthsFinalM = 
        nmToM(RGBToWavelengthsNM(spec.Value * fresnel * max(0, dot(normal,normalize(halfDir)))));
    float3 GratingEffectiveLengthM = wavelengthsFinalM * fresnelReflectance;
    float3 k = 2.0 * PI / wavelengthsFinalM;
    float3 gratingPhase = sin(k * GratingEffectiveLengthM);
    diffraction = noiseSimple3(pixWorldM,time)* 
        gratingPhase*(1.0 - gratingPhase);
    
    float3 finalColor = spec.Value;
    
    
    return aberration * fresnel + finalColor  * fresnelReflectance ;
}

#ifndef FRESNEL_TENSOR_HLSL
#define FRESNEL_TENSOR_HLSL



struct ComplexTensorRGB {
    float3x3 r_real;   // Red   channel — real      part of tensor
    float3x3 g_real;   // Green channel — real      part of tensor
    float3x3 b_real;   // Blue  channel — real      part of tensor

    float3x3 r_imag;   // Red   channel — imaginary part of tensor (extinction)
    float3x3 g_imag;   // Green channel — imaginary part of tensor (extinction)
    float3x3 b_imag;   // Blue  channel — imaginary part of tensor (extinction)
};

struct FresnelTensorRGB {
    ComplexTensorRGB r_s_real;   // s-pol reflection — real  part
    ComplexTensorRGB r_s_imag;   // s-pol reflection — imag  part
    ComplexTensorRGB t_s_real;   // s-pol transmission — real part
    ComplexTensorRGB t_s_imag;   // s-pol transmission — imag part
};

// -----------------------------------------------------------------------------
//  ZERO / IDENTITY CONSTRUCTORS
// -----------------------------------------------------------------------------

ComplexTensorRGB CTensorRGB_Zero() {
    ComplexTensorRGB c;
    c.r_real = (float3x3)0; c.g_real = (float3x3)0; c.b_real = (float3x3)0;
    c.r_imag = (float3x3)0; c.g_imag = (float3x3)0; c.b_imag = (float3x3)0;
    return c;
}

// Identity: real part = I, imaginary part = 0.  Represents n=1, k=0 (vacuum).
ComplexTensorRGB CTensorRGB_Identity() {
    ComplexTensorRGB c = CTensorRGB_Zero();
    c.r_real = float3x3(1,0,0, 0,1,0, 0,0,1);
    c.g_real = c.r_real;
    c.b_real = c.r_real;
    return c;
}

// Isotropic scalar constructor: n + ik, same for all axes and all channels.
ComplexTensorRGB CTensorRGB_Isotropic(float3 n_rgb, float3 k_rgb) {
    ComplexTensorRGB c = CTensorRGB_Zero();
    c.r_real = float3x3(n_rgb.r,0,0, 0,n_rgb.r,0, 0,0,n_rgb.r);
    c.g_real = float3x3(n_rgb.g,0,0, 0,n_rgb.g,0, 0,0,n_rgb.g);
    c.b_real = float3x3(n_rgb.b,0,0, 0,n_rgb.b,0, 0,0,n_rgb.b);
    c.r_imag = float3x3(k_rgb.r,0,0, 0,k_rgb.r,0, 0,0,k_rgb.r);
    c.g_imag = float3x3(k_rgb.g,0,0, 0,k_rgb.g,0, 0,0,k_rgb.g);
    c.b_imag = float3x3(k_rgb.b,0,0, 0,k_rgb.b,0, 0,0,k_rgb.b);
    return c;
}

// -----------------------------------------------------------------------------
//  COMPLEX MATRIX ARITHMETIC
// -----------------------------------------------------------------------------

// Complex 3x3 multiply: (A_r + i*A_i)(B_r + i*B_i)
//   = (A_r*B_r - A_i*B_i) + i*(A_r*B_i + A_i*B_r)
void CMatrix3x3_Mul(
    float3x3 Ar, float3x3 Ai,
    float3x3 Br, float3x3 Bi,
    out float3x3 Cr, out float3x3 Ci)
{
    Cr = mul(Ar, Br) - mul(Ai, Bi);
    Ci = mul(Ar, Bi) + mul(Ai, Br);
}

// Per-channel complex tensor multiply: C = A * B
ComplexTensorRGB CTensorRGB_Mul(ComplexTensorRGB A, ComplexTensorRGB B) {
    ComplexTensorRGB C = CTensorRGB_Zero();
    CMatrix3x3_Mul(A.r_real, A.r_imag, B.r_real, B.r_imag, C.r_real, C.r_imag);
    CMatrix3x3_Mul(A.g_real, A.g_imag, B.g_real, B.g_imag, C.g_real, C.g_imag);
    CMatrix3x3_Mul(A.b_real, A.b_imag, B.b_real, B.b_imag, C.b_real, C.b_imag);
    return C;
}

// Per-channel add
ComplexTensorRGB CTensorRGB_Add(ComplexTensorRGB A, ComplexTensorRGB B) {
    ComplexTensorRGB C = CTensorRGB_Zero();
    C.r_real = A.r_real + B.r_real; C.r_imag = A.r_imag + B.r_imag;
    C.g_real = A.g_real + B.g_real; C.g_imag = A.g_imag + B.g_imag;
    C.b_real = A.b_real + B.b_real; C.b_imag = A.b_imag + B.b_imag;
    return C;
}

// Per-channel subtract
ComplexTensorRGB CTensorRGB_Sub(ComplexTensorRGB A, ComplexTensorRGB B) {
    ComplexTensorRGB C = CTensorRGB_Zero();
    C.r_real = A.r_real - B.r_real; C.r_imag = A.r_imag - B.r_imag;
    C.g_real = A.g_real - B.g_real; C.g_imag = A.g_imag - B.g_imag;
    C.b_real = A.b_real - B.b_real; C.b_imag = A.b_imag - B.b_imag;
    return C;
}

// Hermitian conjugate (conjugate transpose): A† — physical meaning: time-reversal
ComplexTensorRGB CTensorRGB_Hermitian(ComplexTensorRGB A) {
    ComplexTensorRGB C = CTensorRGB_Zero();
    C.r_real =  transpose(A.r_real); C.r_imag = -transpose(A.r_imag);
    C.g_real =  transpose(A.g_real); C.g_imag = -transpose(A.g_imag);
    C.b_real =  transpose(A.b_real); C.b_imag = -transpose(A.b_imag);
    return C;
}

// Scale by a real scalar
ComplexTensorRGB CTensorRGB_Scale(ComplexTensorRGB A, float s) {
    ComplexTensorRGB C = CTensorRGB_Zero();
    C.r_real = A.r_real * s; C.r_imag = A.r_imag * s;
    C.g_real = A.g_real * s; C.g_imag = A.g_imag * s;
    C.b_real = A.b_real * s; C.b_imag = A.b_imag * s;
    return C;
}

float3 CTensorRGB_FrobeniusNormSq(ComplexTensorRGB A) {
    float3 result;
    // Red
    float3x3 rr = A.r_real * A.r_real + A.r_imag * A.r_imag;
    result.r = rr[0][0]+rr[0][1]+rr[0][2]+rr[1][0]+rr[1][1]+rr[1][2]+rr[2][0]+rr[2][1]+rr[2][2];
    // Green
    float3x3 gr = A.g_real * A.g_real + A.g_imag * A.g_imag;
    result.g = gr[0][0]+gr[0][1]+gr[0][2]+gr[1][0]+gr[1][1]+gr[1][2]+gr[2][0]+gr[2][1]+gr[2][2];
    // Blue
    float3x3 br = A.b_real * A.b_real + A.b_imag * A.b_imag;
    result.b = br[0][0]+br[0][1]+br[0][2]+br[1][0]+br[1][1]+br[1][2]+br[2][0]+br[2][1]+br[2][2];
    return result;
}

// Extract diagonal (principal axes) — n,k per axis for each channel
// Returns: (n_xx, n_yy, n_zz) per channel
float3x3 CTensorRGB_DiagonalReal(ComplexTensorRGB A) {
    return float3x3(
        A.r_real[0][0], A.g_real[0][0], A.b_real[0][0],
        A.r_real[1][1], A.g_real[1][1], A.b_real[1][1],
        A.r_real[2][2], A.g_real[2][2], A.b_real[2][2]
    );
}

float3x3 CTensorRGB_DiagonalImag(ComplexTensorRGB A) {
    return float3x3(
        A.r_imag[0][0], A.g_imag[0][0], A.b_imag[0][0],
        A.r_imag[1][1], A.g_imag[1][1], A.b_imag[1][1],
        A.r_imag[2][2], A.g_imag[2][2], A.b_imag[2][2]
    );
}

// Anisotropy measure per channel: deviation of diagonal from isotropy.
// Returns 0 for isotropic media.  Law: Δ = (n_xx - n_zz) / n_avg
float3 CTensorRGB_Birefringence(ComplexTensorRGB A) {
    float3x3 d = CTensorRGB_DiagonalReal(A);
    // Each row: (r,g,b) value at axis index. d[0]=xx, d[1]=yy, d[2]=zz
    float3 n_xx = float3(d[0][0], d[0][1], d[0][2]);
    float3 n_zz = float3(d[2][0], d[2][1], d[2][2]);
    float3 n_avg = (float3(d[0][0]+d[1][0]+d[2][0],
                           d[0][1]+d[1][1]+d[2][1],
                           d[0][2]+d[1][2]+d[2][2])) / 3.0;
    return (n_xx - n_zz) / max(n_avg, 1e-6);
}

// Trace per channel (sum of eigenvalues — mean refractive index proxy)
float3 CTensorRGB_TraceReal(ComplexTensorRGB A) {
    return float3(
        A.r_real[0][0] + A.r_real[1][1] + A.r_real[2][2],
        A.g_real[0][0] + A.g_real[1][1] + A.g_real[2][2],
        A.b_real[0][0] + A.b_real[1][1] + A.b_real[2][2]
    );
}

float3 CTensorRGB_TraceImag(ComplexTensorRGB A) {
    return float3(
        A.r_imag[0][0] + A.r_imag[1][1] + A.r_imag[2][2],
        A.g_imag[0][0] + A.g_imag[1][1] + A.g_imag[2][2],
        A.b_imag[0][0] + A.b_imag[1][1] + A.b_imag[2][2]
    );
}

// Isotropic effective N per channel (1/3 * Trace)
float3 CTensorRGB_EffectiveN(ComplexTensorRGB A) {
    return CTensorRGB_TraceReal(A) / 3.0;
}

float3 CTensorRGB_EffectiveK(ComplexTensorRGB A) {
    return CTensorRGB_TraceImag(A) / 3.0;
}

// Apply tensor to a polarization vector for a given channel (0=R,1=G,2=B)
// Returns: (E_out_real, E_out_imag) from E_in_real, E_in_imag
// Physical meaning: propagation of a polarized field through the medium
void CTensorRGB_ApplyToField(
    ComplexTensorRGB A, int channel,
    float3 E_in_real, float3 E_in_imag,
    out float3 E_out_real, out float3 E_out_imag)
{
    float3x3 Ar, Ai;
    if      (channel == 0) { Ar = A.r_real; Ai = A.r_imag; }
    else if (channel == 1) { Ar = A.g_real; Ai = A.g_imag; }
    else                   { Ar = A.b_real; Ai = A.b_imag; }

    // (Ar + i*Ai)(Er + i*Ei) = (Ar*Er - Ai*Ei) + i*(Ar*Ei + Ai*Er)
    E_out_real = mul(Ar, E_in_real) - mul(Ai, E_in_imag);
    E_out_imag = mul(Ar, E_in_imag) + mul(Ai, E_in_real);
}

void CSqrt1(float a, float b, out float sr, out float si) {
    float mag = sqrt(a*a + b*b);
    sr = sqrt(max(0.0, (mag + a) * 0.5));
    si = (b >= 0.0 ? 1.0 : -1.0) * sqrt(max(0.0, (mag - a) * 0.5));
}

// Helper: complex division (a+ib)/(c+id)
void CDiv1(float ar, float ai, float br, float bi, out float cr, out float ci) {
    float denom = br*br + bi*bi + EPSILON;
    cr = (ar*br + ai*bi) / denom;
    ci = (ai*br - ar*bi) / denom;
}

void FresnelS_Complex(
    float n1r, float n1i,
    float n2r, float n2i,
    float sinThetaI,
    out float rs_r, out float rs_i,
    out float ts_r, out float ts_i)
{
    // cosθ_i is real (in lossless incident medium for simplicity)
    float cosThetaI = sqrt(max(0.0, 1.0 - sinThetaI * sinThetaI));

    // Snell generalised: sin²θ_t = (Ñ1/Ñ2)² * sin²θ_i
    // sin²θ_t = (n1r+in1i)²/(n2r+in2i)² * sin²θ_i
    float s2 = sinThetaI * sinThetaI;

    // (Ñ1)² = n1r²-n1i² + i*2*n1r*n1i
    float N1sq_r = n1r*n1r - n1i*n1i;
    float N1sq_i = 2.0*n1r*n1i;
    // (Ñ2)²
    float N2sq_r = n2r*n2r - n2i*n2i;
    float N2sq_i = 2.0*n2r*n2i;
    // sin²θ_t = (Ñ1²/Ñ2²) * s2
    float ratio_r, ratio_i;
    CDiv1(N1sq_r, N1sq_i, N2sq_r, N2sq_i, ratio_r, ratio_i);
    float sinTsq_r = ratio_r * s2;
    float sinTsq_i = ratio_i * s2;
    // cos²θ_t = 1 - sin²θ_t
    float cosTsq_r = 1.0 - sinTsq_r;
    float cosTsq_i = -sinTsq_i;
    // cosθ_t = √(cos²θ_t)
    float cosT_r, cosT_i;
    CSqrt1(cosTsq_r, cosTsq_i, cosT_r, cosT_i);

    // Ñ1 * cosθ_i  (n1i=0 incident medium approximation: Ñ1=n1r+in1i)
    float A_r = n1r * cosThetaI - n1i * 0.0;  // Ñ1*cosθ_i real
    float A_i = n1i * cosThetaI + n1r * 0.0;  // imag

    // Ñ2 * cosθ_t
    float B_r = n2r*cosT_r - n2i*cosT_i;
    float B_i = n2r*cosT_i + n2i*cosT_r;

    // r_s = (Ñ1 cosθ_i - Ñ2 cosθ_t) / (Ñ1 cosθ_i + Ñ2 cosθ_t)
    float num_r = A_r - B_r; float num_i = A_i - B_i;
    float den_r = A_r + B_r; float den_i = A_i + B_i;
    CDiv1(num_r, num_i, den_r, den_i, rs_r, rs_i);

    // t_s = 2 * Ñ1 * cosθ_i / (Ñ1 cosθ_i + Ñ2 cosθ_t)
    float two_A_r = 2.0 * A_r;
    float two_A_i = 2.0 * A_i;
    CDiv1(two_A_r, two_A_i, den_r, den_i, ts_r, ts_i);
}

// Build full FresnelTensorRGB from two anisotropic media and angle of incidence.
// medium1, medium2: complex refractive index tensors (diagonal = principal axes)
// sinThetaI: sin(angle of incidence) from surface normal
FresnelTensorRGB FresnelTensor_Build(
    ComplexTensorRGB medium1,
    ComplexTensorRGB medium2,
    float sinThetaI)
{
    FresnelTensorRGB F;
    F.r_s_real = CTensorRGB_Zero();
    F.r_s_imag = CTensorRGB_Zero();
    F.t_s_real = CTensorRGB_Zero();
    F.t_s_imag = CTensorRGB_Zero();

    // For each axis (diagonal element) and each channel, compute Fresnel s-pol.
    // Off-diagonal cross-coupling terms are zero here (decoupled axes approx).
    // A full 4x4 transfer-matrix method is required for coupled biaxial media.
    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        float rs_r, rs_i, ts_r, ts_i;

        // RED
        FresnelS_Complex(
            medium1.r_real[ax][ax], medium1.r_imag[ax][ax],
            medium2.r_real[ax][ax], medium2.r_imag[ax][ax],
            sinThetaI, rs_r, rs_i, ts_r, ts_i);
        F.r_s_real.r_real[ax][ax] = rs_r;
        F.r_s_imag.r_imag[ax][ax] = rs_i;
        F.t_s_real.r_real[ax][ax] = ts_r;
        F.t_s_imag.r_imag[ax][ax] = ts_i;

        // GREEN
        FresnelS_Complex(
            medium1.g_real[ax][ax], medium1.g_imag[ax][ax],
            medium2.g_real[ax][ax], medium2.g_imag[ax][ax],
            sinThetaI, rs_r, rs_i, ts_r, ts_i);
        F.r_s_real.g_real[ax][ax] = rs_r;
        F.r_s_imag.g_imag[ax][ax] = rs_i;
        F.t_s_real.g_real[ax][ax] = ts_r;
        F.t_s_imag.g_imag[ax][ax] = ts_i;

        // BLUE
        FresnelS_Complex(
            medium1.b_real[ax][ax], medium1.b_imag[ax][ax],
            medium2.b_real[ax][ax], medium2.b_imag[ax][ax],
            sinThetaI, rs_r, rs_i, ts_r, ts_i);
        F.r_s_real.b_real[ax][ax] = rs_r;
        F.r_s_imag.b_imag[ax][ax] = rs_i;
        F.t_s_real.b_real[ax][ax] = ts_r;
        F.t_s_imag.b_imag[ax][ax] = ts_i;
    }

    return F;
}

// -----------------------------------------------------------------------------
//  FRESNEL TENSOR OBSERVABLES
// -----------------------------------------------------------------------------

// Reflectance (power) per channel from FresnelTensorRGB.
// R = |r_s|² = r_s_real² + r_s_imag² (diagonal terms averaged over axes)
// Law: Energy conservation — R + T = 1 for lossless interfaces.
float3 FresnelTensor_Reflectance(FresnelTensorRGB F) {
    float3 R = 0.0;
    // Average over the 3 principal axes
    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        R.r += F.r_s_real.r_real[ax][ax]*F.r_s_real.r_real[ax][ax]
             + F.r_s_imag.r_imag[ax][ax]*F.r_s_imag.r_imag[ax][ax];
        R.g += F.r_s_real.g_real[ax][ax]*F.r_s_real.g_real[ax][ax]
             + F.r_s_imag.g_imag[ax][ax]*F.r_s_imag.g_imag[ax][ax];
        R.b += F.r_s_real.b_real[ax][ax]*F.r_s_real.b_real[ax][ax]
             + F.r_s_imag.b_imag[ax][ax]*F.r_s_imag.b_imag[ax][ax];
    }
    return R / 3.0;
}

// Transmittance (power) per channel.
// T = (n2 cosθ_t)/(n1 cosθ_i) * |t_s|²
// For real n, cosθ (lossless medium 1 approximation):
float3 FresnelTensor_Transmittance(
    FresnelTensorRGB F,
    ComplexTensorRGB medium1,
    ComplexTensorRGB medium2,
    float sinThetaI)
{
    float cosThetaI = sqrt(max(0.0, 1.0 - sinThetaI*sinThetaI));
    float3 T = 0.0;
    [unroll(3)]
    for (int ax = 0; ax < 3; ax++) {
        // Use real part of n2 / real part of n1 as approximation (Im small)
        float cosT_approx = sqrt(max(0.0,
            1.0 - sinThetaI*sinThetaI *
            (medium1.r_real[ax][ax]*medium1.r_real[ax][ax]) /
            max(medium2.r_real[ax][ax]*medium2.r_real[ax][ax], 1e-6)));

        float scale_r = (medium2.r_real[ax][ax] * cosT_approx) /
                        max(medium1.r_real[ax][ax] * cosThetaI, 1e-6);
        float ts_r_r = F.t_s_real.r_real[ax][ax];
        float ts_i_r = F.t_s_imag.r_imag[ax][ax];
        T.r += scale_r * (ts_r_r*ts_r_r + ts_i_r*ts_i_r);

        float cosT_g = sqrt(max(0.0,
            1.0 - sinThetaI*sinThetaI *
            (medium1.g_real[ax][ax]*medium1.g_real[ax][ax]) /
            max(medium2.g_real[ax][ax]*medium2.g_real[ax][ax], 1e-6)));
        float scale_g = (medium2.g_real[ax][ax] * cosT_g) /
                        max(medium1.g_real[ax][ax] * cosThetaI, 1e-6);
        float ts_r_g = F.t_s_real.g_real[ax][ax];
        float ts_i_g = F.t_s_imag.g_imag[ax][ax];
        T.g += scale_g * (ts_r_g*ts_r_g + ts_i_g*ts_i_g);

        float cosT_b = sqrt(max(0.0,
            1.0 - sinThetaI*sinThetaI *
            (medium1.b_real[ax][ax]*medium1.b_real[ax][ax]) /
            max(medium2.b_real[ax][ax]*medium2.b_real[ax][ax], 1e-6)));
        float scale_b = (medium2.b_real[ax][ax] * cosT_b) /
                        max(medium1.b_real[ax][ax] * cosThetaI, 1e-6);
        float ts_r_b = F.t_s_real.b_real[ax][ax];
        float ts_i_b = F.t_s_imag.b_imag[ax][ax];
        T.b += scale_b * (ts_r_b*ts_r_b + ts_i_b*ts_i_b);
    }
    return T / 3.0;
}

// Phase shift on reflection per channel (arg of r_s = atan2(imag, real))
// Law: At normal incidence on a denser medium, phase flips by π (r_s < 0 → real).
// For absorbing media this generalises to a continuous complex argument.
float3 FresnelTensor_PhaseShift(FresnelTensorRGB F) {
    float3 phase = 0.0;
    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        phase.r += atan2(F.r_s_imag.r_imag[ax][ax], F.r_s_real.r_real[ax][ax]);
        phase.g += atan2(F.r_s_imag.g_imag[ax][ax], F.r_s_real.g_real[ax][ax]);
        phase.b += atan2(F.r_s_imag.b_imag[ax][ax], F.r_s_real.b_real[ax][ax]);
    }
    return phase / 3.0;
}

#define getLuminance(v) dot(v, float3(0.2126, 0.7152, 0.0722))

// Brewster angle check (r_p → 0).  Here approximated from reflectance tensor.
// Returns scalar measure: 0 = at Brewster, 1 = far from it.
// (Exact Brewster requires r_p — extend with p-pol Fresnel for full treatment.)
float FresnelTensor_BrewsterProximity(FresnelTensorRGB F) {
    float3 R = FresnelTensor_Reflectance(F);
    return getLuminance(R);
}

// Spectral color of reflected light given incident spectral radiance L_in (RGB)
float3 FresnelTensor_ReflectedColor(FresnelTensorRGB F, float3 L_in) {
    float3 R = FresnelTensor_Reflectance(F);
    return R * L_in;
}

// Spectral color of transmitted light
float3 FresnelTensor_TransmittedColor(
    FresnelTensorRGB F,
    ComplexTensorRGB medium1,
    ComplexTensorRGB medium2,
    float sinThetaI,
    float3 L_in)
{
    float3 T = FresnelTensor_Transmittance(F, medium1, medium2, sinThetaI);
    return T * L_in;
}

// -----------------------------------------------------------------------------
//  CANONICAL MATERIAL PRESETS
//  All values are physically measured at RGB wavelengths ≈ (650, 532, 450) nm.
// -----------------------------------------------------------------------------

// Air / vacuum: n=1, k=0 everywhere
ComplexTensorRGB Material_Air() {
    return CTensorRGB_Isotropic(float3(1.0, 1.0, 1.0), float3(0.0, 0.0, 0.0));
}

// Crown glass (BK7): isotropic, dispersion approximated
ComplexTensorRGB Material_CrownGlass() {
    return CTensorRGB_Isotropic(float3(1.5143, 1.5191, 1.5282), float3(0,0,0));
}

// Fused silica: ultralow absorption
ComplexTensorRGB Material_FusedSilica() {
    return CTensorRGB_Isotropic(float3(1.4570, 1.4600, 1.4670), float3(0,0,0));
}

// Aluminum (metal): high k, strong absorption
ComplexTensorRGB Material_Aluminum() {
    return CTensorRGB_Isotropic(
        float3(1.097, 0.765, 0.212),   // n
        float3(6.992, 6.383, 5.300));  // k
}

// Gold (Au): characteristic reddish-yellow reflectance
ComplexTensorRGB Material_Gold() {
    return CTensorRGB_Isotropic(
        float3(0.180, 0.344, 1.658),   // n
        float3(3.070, 2.290, 1.930));  // k
}

// Silver (Ag): broadband high reflectance
ComplexTensorRGB Material_Silver() {
    return CTensorRGB_Isotropic(
        float3(0.142, 0.128, 0.148),   // n
        float3(3.975, 3.275, 2.390));  // k
}

// Copper (Cu): reddish, absorbs blue strongly
ComplexTensorRGB Material_Copper() {
    return CTensorRGB_Isotropic(
        float3(0.217, 0.916, 1.244),   // n
        float3(3.576, 2.590, 2.159));  // k
}

// Water: slight dispersion, zero absorption in visible
ComplexTensorRGB Material_Water() {
    return CTensorRGB_Isotropic(float3(1.332, 1.336, 1.341), float3(0,0,0));
}

// Diamond: high refractive index, strong dispersion, isotropic
ComplexTensorRGB Material_Diamond() {
    return CTensorRGB_Isotropic(float3(2.410, 2.426, 2.465), float3(0,0,0));
}

// Calcite (CaCO3): birefringent — ordinary/extraordinary axes differ.
// Principal axes: x,y = ordinary (n_o), z = extraordinary (n_e)
ComplexTensorRGB Material_Calcite() {
    ComplexTensorRGB m = CTensorRGB_Zero();
    // n_o ≈ 1.658 (R), 1.667 (G), 1.681 (B)
    // n_e ≈ 1.486 (R), 1.490 (G), 1.497 (B)
    float3 no = float3(1.658, 1.667, 1.681);
    float3 ne = float3(1.486, 1.490, 1.497);
    m.r_real = float3x3(no.r,0,0, 0,no.r,0, 0,0,ne.r);
    m.g_real = float3x3(no.g,0,0, 0,no.g,0, 0,0,ne.g);
    m.b_real = float3x3(no.b,0,0, 0,no.b,0, 0,0,ne.b);
    // k ≈ 0 for calcite in visible
    return m;
}

// ITO (Indium Tin Oxide): transparent conductor, wavelength-dependent k
ComplexTensorRGB Material_ITO() {
    return CTensorRGB_Isotropic(
        float3(1.950, 1.870, 1.790),   // n
        float3(0.005, 0.020, 0.060));  // k (small but nonzero)
}

// -----------------------------------------------------------------------------
//  COMPLETE INTERFACE EVALUATION
//  High-level entry point: given two materials, angle, and incident light,
//  returns (reflected, transmitted) spectral RGB.
// -----------------------------------------------------------------------------
void EvaluateInterface(
    ComplexTensorRGB mat_incident,
    ComplexTensorRGB mat_transmitted,
    float3 incident_dir,       // world-space, pointing TOWARD surface
    float3 surface_normal,     // world-space, pointing OUT of surface
    float3 L_in,               // incident spectral radiance (RGB)
    out float3 L_reflected,
    out float3 L_transmitted)
{
    float cosTheta = saturate(-dot(incident_dir, surface_normal));
    float sinTheta = sqrt(max(0.0, 1.0 - cosTheta*cosTheta));

    FresnelTensorRGB F = FresnelTensor_Build(mat_incident, mat_transmitted, sinTheta);

    L_reflected    = FresnelTensor_ReflectedColor(F, L_in);
    L_transmitted  = FresnelTensor_TransmittedColor(F, mat_incident, mat_transmitted, sinTheta, L_in);
}


#endif // FRESNEL_TENSOR_HLSL

// Pixel Shader
psout PS88(PS_INPUT input)
{
    psout output;
    float2 uv = input.uv;
    // Assuming InitPSOut takes a uv and a second float2 for offset (ZERO2)
    InitPSOut(output, input.uv, float2(0.0f, 0.0f));
    
    if (PassNum < 3)
    {
        
    
    MaterialSellmeier mat = CreateMaterial(MaterialIndex+PassNum);
    float3 coherenceFactor = float3(GetOosz(depthMap), 1./DepthScale)/COHERENCE_LENGTH_M*100.;
    float2 ooszDepth = GetOosz(depthMap);
    float2 ooszDiffuse = GetOosz(diffuseMap);

    
        float3 noiseV;
        float3 interference;
        float3 fresnel;
        float3 fresnelReflectance;
        float3 diffraction;
        float depth = clamp(DepthScale*SampleDepth(depthMap, input.uv), .2, .8);
        float3 normal0 = calcNormal(depthMap, input.uv);
        float3x3 tbn0 = CalcTBN(normal0);

        float3 normal, viewDir, lightDir, pixWorldM;
        
        float2 offset = lerp(
                float3(float2(-ooszDiffuse.x, 0) * depth*normal0.x, 0.0).x,
                0,
                0.5+0.5*f03);
        offset.y = 0;
        depth = SampleDepth(depthMap, input.uv+offset);
        normal0 = calcNormal(depthMap, input.uv+offset);
        tbn0 = CalcTBN(normal0);
        float3 diffuse = SampleDiffuse(diffuseMap, input.uv+offset);
        float3 aberration;
        float3 holo = HolographicPS(diffuseMap, input.uv, offset,
            PixelWorldM+float3(offset,0), interference, fresnel,
            fresnelReflectance, diffraction, coherenceFactor, noiseV,
            viewDir, lightDir, pixWorldM, normal, aberration);
        float3x3 tbn1 = CalcTBN(normal);

        if(KeyEDown){
            if(input.uv.y < .1){
               output.rt1.xyz = 
                     saturate(
                           uv.x < .1 ? dot(normal, viewDir):
                           uv.x < .2 ? max(0,dot(normal, viewDir)):
                           uv.x < .3 ? normal:
                           uv.x < .4 ? viewDir:
                           uv.x < .5 ? lightDir:
                           uv.x < .6 ? depth:
                           uv.x < .7 ? abs(depth):
                           uv.x < .8 ? abs(depth)/DepthScale: Diffuse);
            }
            else if(input.uv.y < .2)
            {
               output.rt1.xyz = 
                     saturate(
                           uv.x < .1 ? dot(normal, lightDir):
                           uv.x < .2 ? noiseV:
                           uv.x < .3 ? interference:
                           uv.x < .4 ? 1.0+interference:
                           uv.x < .5 ? interference/2:
                           uv.x < .6 ? saturate(interference):
                           uv.x < .7 ? 0+interference:
                           uv.x < .8 ? 1.0-interference: Diffuse);
            }
        }
        else
        {
            output.rt1.xyz = aberration + holo + fresnelReflectance;
            output.rt2.xyz = diffraction;
            output.rt3.xyz = fresnel;
            output.rt4.xyz = noiseV;
            output.rt5.xyz = interference;
            output.rt6.xyz = holo;
            output.rt7.xyz = interference;
            output.rt8.xyz = fresnelReflectance;
        }
        if(KeyWDown){
            output.rt1.xyz = saturate(
               uv.x < .1 ? output.rt1.xyz:
               uv.x < .2 ? output.rt2.xyz:
               uv.x < .3 ? output.rt3.xyz:
               uv.x < .4 ? output.rt4.xyz:
               uv.x < .5 ? output.rt5.xyz:
               uv.x < .6 ? output.rt6.xyz:
               uv.x < .7 ? output.rt7.xyz:
               uv.x < .8 ? output.rt8.xyz : noiseV);
               
        }
    }
    else if (PassNum == 1)
    {
            output.rt1.xyz = 
         saturate(
               uv.x < .1 ? output.rt1.xyz:
               uv.x < .2 ? output.rt2.xyz:
               uv.x < .3 ? output.rt3.xyz:
               uv.x < .4 ? output.rt4.xyz:
               uv.x < .5 ? output.rt5.xyz:
               uv.x < .6 ? output.rt6.xyz:
               uv.x < .7 ? output.rt7.xyz:
               uv.x < .8 ? output.rt8.xyz : Diffuse);
    }
    else if (PassNum == 2)
    {

        output.rt1.xyz = output.rt1.xyz+
                        output.rt2.xyz+
                        output.rt3.xyz+
                        output.rt4.xyz+
                        output.rt5.xyz+
                        output.rt6.xyz+
                        output.rt7.xyz+
                        output.rt8.xyz;
    
    }
    if (KeyQDown)
    {
        
        output.rt1.xyz =
            (uv.y < .25 ? Diffuse :
            (uv.x < .1 ? output.rt1.xyz:
            uv.x < .2 ? output.rt2.xyz:
            uv.x < .3 ? output.rt3.xyz:
            uv.x < .4 ? output.rt4.xyz:
            uv.x < .5 ? output.rt5.xyz:
            uv.x < .6 ? output.rt6.xyz:
            uv.x < .7 ? output.rt7.xyz:
            uv.x < .8 ? output.rt8.xyz :
                        output.rt1.xyz+
                        output.rt2.xyz+
                        output.rt3.xyz+
                        output.rt4.xyz+
                        output.rt5.xyz+
                        output.rt6.xyz+
                        output.rt7.xyz+
                        output.rt8.xyz));
    }
    
    return output;
}

struct FresnelCoeffsRGB {
    ComplexTensorRGB rs;  // s-pol reflection
    ComplexTensorRGB rp;  // p-pol reflection
    ComplexTensorRGB ts;  // s-pol transmission
    ComplexTensorRGB tp;  // p-pol transmission
};


// -----------------------------------------------------------------------------
//  ARITHMETIC BASEMENT  (float3 — one lane per RGB channel)
//  Private implementation detail; never appear at call sites above Fresnel.
// -----------------------------------------------------------------------------

// Complex square root:  sqrt(a + ib)
void CSqrt3(float3 a, float3 b, out float3 sr, out float3 si) {
    float3 mag = sqrt(a*a + b*b);
    sr = sqrt(max((float3)0, (mag + a) * 0.5));
    si = sign(b + EPSILON) * sqrt(max((float3)0, (mag - a) * 0.5));
}

// Complex division:  (ar+i·ai) / (br+i·bi)
void CDiv3(float3 ar, float3 ai, float3 br, float3 bi,
          out float3 cr, out float3 ci) {
    float3 denom = br*br + bi*bi + EPSILON;
    cr = (ar*br + ai*bi) / denom;
    ci = (ai*br - ar*bi) / denom;
}

// Complex multiplication:  (ar+i·ai) * (br+i·bi)
void CMul3(float3 ar, float3 ai, float3 br, float3 bi,
          out float3 cr, out float3 ci) {
    cr = ar*br - ai*bi;
    ci = ar*bi + ai*br;
}

// -----------------------------------------------------------------------------
//  ComplexTensorRGB CONSTRUCTORS / UTILITIES
// -----------------------------------------------------------------------------

ComplexTensorRGB CTensor_Zero() {
    ComplexTensorRGB c;
    c.r_real = (float3x3)0; c.g_real = (float3x3)0; c.b_real = (float3x3)0;
    c.r_imag = (float3x3)0; c.g_imag = (float3x3)0; c.b_imag = (float3x3)0;
    return c;
}

// Isotropic medium: n+ik scalar per channel → identity-scaled diagonal tensor
ComplexTensorRGB CTensor_Isotropic(float3 n_rgb, float3 k_rgb) {
    ComplexTensorRGB c = CTensor_Zero();
    c.r_real = float3x3(n_rgb.r,0,0, 0,n_rgb.r,0, 0,0,n_rgb.r);
    c.g_real = float3x3(n_rgb.g,0,0, 0,n_rgb.g,0, 0,0,n_rgb.g);
    c.b_real = float3x3(n_rgb.b,0,0, 0,n_rgb.b,0, 0,0,n_rgb.b);
    c.r_imag = float3x3(k_rgb.r,0,0, 0,k_rgb.r,0, 0,0,k_rgb.r);
    c.g_imag = float3x3(k_rgb.g,0,0, 0,k_rgb.g,0, 0,0,k_rgb.g);
    c.b_imag = float3x3(k_rgb.b,0,0, 0,k_rgb.b,0, 0,0,k_rgb.b);
    return c;
}

// Read axis diagonal — real part — as float3 (r,g,b lanes)
float3 CTensor_DiagReal(ComplexTensorRGB A, int ax) {
    return float3(A.r_real[ax][ax], A.g_real[ax][ax], A.b_real[ax][ax]);
}

// Read axis diagonal — imaginary part — as float3
float3 CTensor_DiagImag(ComplexTensorRGB A, int ax) {
    return float3(A.r_imag[ax][ax], A.g_imag[ax][ax], A.b_imag[ax][ax]);
}

// Write float3 into axis diagonal — real part
void CTensor_SetDiagReal(inout ComplexTensorRGB A, int ax, float3 v) {
    A.r_real[ax][ax] = v.r;
    A.g_real[ax][ax] = v.g;
    A.b_real[ax][ax] = v.b;
}

// Write float3 into axis diagonal — imaginary part
void CTensor_SetDiagImag(inout ComplexTensorRGB A, int ax, float3 v) {
    A.r_imag[ax][ax] = v.r;
    A.g_imag[ax][ax] = v.g;
    A.b_imag[ax][ax] = v.b;
}

// Trace of imaginary part → float3 (one scalar per channel)
float3 CTensor_TraceImag(ComplexTensorRGB A) {
    return float3(
        A.r_imag[0][0] + A.r_imag[1][1] + A.r_imag[2][2],
        A.g_imag[0][0] + A.g_imag[1][1] + A.g_imag[2][2],
        A.b_imag[0][0] + A.b_imag[1][1] + A.b_imag[2][2]);
}

// Mean extinction coefficient across principal axes (for Beer-Lambert)
float3 CTensor_EffectiveK(ComplexTensorRGB A) {
    return CTensor_TraceImag(A) / 3.0;
}

// Per-axis |z|² of diagonal, stored in real part of returned tensor
ComplexTensorRGB CTensor_DiagAbs2(ComplexTensorRGB A) {
    ComplexTensorRGB R = CTensor_Zero();
    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        float3 re = CTensor_DiagReal(A, ax);
        float3 im = CTensor_DiagImag(A, ax);
        CTensor_SetDiagReal(R, ax, re*re + im*im);
    }
    return R;
}

// Sum diagonal real entries across all axes → float3 spectrum
float3 CTensor_DiagSumReal(ComplexTensorRGB A) {
    float3 s = 0;
    [unroll]
    for (int ax = 0; ax < 3; ax++)
        s += CTensor_DiagReal(A, ax);
    return s;
}

// Collapse diagonal-only tensor to display float3 (average over axes)
float3 CTensor_CollapseToSpectrum(ComplexTensorRGB A) {
    return CTensor_DiagSumReal(A) / 3.0;
}

// Scale all entries of A by a per-channel scalar spectrum
ComplexTensorRGB CTensor_ScaleBySpectrum(ComplexTensorRGB A, float3 s) {
    ComplexTensorRGB R = A;
    R.r_real *= s.r; R.r_imag *= s.r;
    R.g_real *= s.g; R.g_imag *= s.g;
    R.b_real *= s.b; R.b_imag *= s.b;
    return R;
}

// Elementwise multiply real parts of two tensors (e.g. apply attenuation)
ComplexTensorRGB CTensor_MulReal(ComplexTensorRGB A, ComplexTensorRGB B) {
    ComplexTensorRGB R = CTensor_Zero();
    R.r_real = A.r_real * B.r_real;
    R.g_real = A.g_real * B.g_real;
    R.b_real = A.b_real * B.b_real;
    return R;
}

// Additive blend of two tensors (real parts only, for combining contributions)
ComplexTensorRGB CTensor_AddReal(ComplexTensorRGB A, ComplexTensorRGB B) {
    ComplexTensorRGB R = CTensor_Zero();
    R.r_real = A.r_real + B.r_real;
    R.g_real = A.g_real + B.g_real;
    R.b_real = A.b_real + B.b_real;
    return R;
}

// -----------------------------------------------------------------------------
//  SNELL — fully complex cosθt per axis
//
//  sinθt² = (N1²/N2²) · sinθi²
//  cosθt  = sqrt(1 − sinθt²)
//
//  Outputs float3 pairs (real, imag) for use inside Fresnel functions.
//  Not exposed as a public ComplexTensorRGB because it is an intermediate
//  value on a single axis, not a full tensor.
// -----------------------------------------------------------------------------
void CTensor_ComplexCosT(
    ComplexTensorRGB N1,
    ComplexTensorRGB N2,
    float            sinTI,
    int              ax,
    out float3       cosTr,
    out float3       cosTi)
{
    float3 n1r = CTensor_DiagReal(N1, ax),  n1i = CTensor_DiagImag(N1, ax);
    float3 n2r = CTensor_DiagReal(N2, ax),  n2i = CTensor_DiagImag(N2, ax);

    float3 N1sq_r = n1r*n1r - n1i*n1i,  N1sq_i = 2.0*n1r*n1i;
    float3 N2sq_r = n2r*n2r - n2i*n2i,  N2sq_i = 2.0*n2r*n2i;

    float3 ratio_r, ratio_i;
    CDiv3(N1sq_r, N1sq_i, N2sq_r, N2sq_i, ratio_r, ratio_i);

    float3 s2 = sinTI * sinTI;
    CSqrt3(1.0 - ratio_r*s2, -ratio_i*s2, cosTr, cosTi);
}


void CTensor_FresnelS(
    ComplexTensorRGB     N1,
    ComplexTensorRGB     N2,
    float                cosTI,   // real — incident medium non-absorbing
    float3               cosTr,   // complex cosθt real part
    float3               cosTi,   // complex cosθt imag part
    int                  ax,
    inout ComplexTensorRGB rs,
    inout ComplexTensorRGB ts)
{
    float3 n1r = CTensor_DiagReal(N1, ax),  n1i = CTensor_DiagImag(N1, ax);
    float3 n2r = CTensor_DiagReal(N2, ax),  n2i = CTensor_DiagImag(N2, ax);

    // A = N1 · cosθi
    float3 Ar = n1r * cosTI,  Ai = n1i * cosTI;

    // B = N2 · cosθt
    float3 Br, Bi;
    CMul3(n2r, n2i, cosTr, cosTi, Br, Bi);

    float3 den_r = Ar + Br,  den_i = Ai + Bi;

    float3 rs_r, rs_i, ts_r, ts_i;
    CDiv3(Ar - Br, Ai - Bi, den_r, den_i, rs_r, rs_i);
    CDiv3(2.0*Ar,  2.0*Ai,  den_r, den_i, ts_r, ts_i);

    CTensor_SetDiagReal(rs, ax, rs_r);  CTensor_SetDiagImag(rs, ax, rs_i);
    CTensor_SetDiagReal(ts, ax, ts_r);  CTensor_SetDiagImag(ts, ax, ts_i);
}

void CTensor_FresnelP(
    ComplexTensorRGB     N1,
    ComplexTensorRGB     N2,
    float                cosTI,
    float3               cosTr,
    float3               cosTi,
    int                  ax,
    inout ComplexTensorRGB rp,
    inout ComplexTensorRGB tp)
{
    float3 n1r = CTensor_DiagReal(N1, ax),  n1i = CTensor_DiagImag(N1, ax);
    float3 n2r = CTensor_DiagReal(N2, ax),  n2i = CTensor_DiagImag(N2, ax);

    // A = N1 · cosθi  (numerator of tp)
    float3 Ar = n1r * cosTI,  Ai = n1i * cosTI;

    // C = N1 · cosθt
    float3 Cr, Ci;
    CMul3(n1r, n1i, cosTr, cosTi, Cr, Ci);

    // D = N2 · cosθi
    float3 Dr = n2r * cosTI,  Di = n2i * cosTI;

    float3 den_r = Dr + Cr,  den_i = Di + Ci;

    float3 rp_r, rp_i, tp_r, tp_i;
    CDiv3(Dr - Cr, Di - Ci, den_r, den_i, rp_r, rp_i);
    CDiv3(2.0*Ar,  2.0*Ai,  den_r, den_i, tp_r, tp_i);

    CTensor_SetDiagReal(rp, ax, rp_r);  CTensor_SetDiagImag(rp, ax, rp_i);
    CTensor_SetDiagReal(tp, ax, tp_r);  CTensor_SetDiagImag(tp, ax, tp_i);
}

// -----------------------------------------------------------------------------
//  BUILD FRESNEL COEFFICIENT TENSORS
// -----------------------------------------------------------------------------
FresnelCoeffsRGB CTensor_BuildFresnel(
    ComplexTensorRGB N1,
    ComplexTensorRGB N2,
    float sinTI)
{
    FresnelCoeffsRGB F;
    F.rs = CTensor_Zero();
    F.rp = CTensor_Zero();
    F.ts = CTensor_Zero();
    F.tp = CTensor_Zero();

    float cosTI = sqrt(max(0.0, 1.0 - sinTI*sinTI));

    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        float3 cosTr, cosTi;
        CTensor_ComplexCosT(N1, N2, sinTI, ax, cosTr, cosTi);
        CTensor_FresnelS(N1, N2, cosTI, cosTr, cosTi, ax, F.rs, F.ts);
        CTensor_FresnelP(N1, N2, cosTI, cosTr, cosTi, ax, F.rp, F.tp);
    }

    return F;
}

// -----------------------------------------------------------------------------
//  REFLECTANCE TENSOR   R = (|rs|² + |rp|²) / 2
//  Real part = power reflectance per axis/channel. Imag part zero.
// -----------------------------------------------------------------------------
ComplexTensorRGB CTensor_Reflectance(FresnelCoeffsRGB F) {
    ComplexTensorRGB Rs = CTensor_DiagAbs2(F.rs);
    ComplexTensorRGB Rp = CTensor_DiagAbs2(F.rp);
    ComplexTensorRGB R  = CTensor_Zero();
    R.r_real = (Rs.r_real + Rp.r_real) * 0.5;
    R.g_real = (Rs.g_real + Rp.g_real) * 0.5;
    R.b_real = (Rs.b_real + Rp.b_real) * 0.5;
    return R;
}

// -----------------------------------------------------------------------------
//  TRANSMITTANCE TENSOR   T = (n2·Re[cosθt]/n1·cosθi) · (|ts|² + |tp|²) / 2
//  Uses Re[cosθt] for power flux projection. Real part only.
// -----------------------------------------------------------------------------
ComplexTensorRGB CTensor_Transmittance(
    FresnelCoeffsRGB F,
    ComplexTensorRGB N1,
    ComplexTensorRGB N2,
    float            sinTI)
{
    float cosTI = sqrt(max(0.0, 1.0 - sinTI*sinTI));
    ComplexTensorRGB T = CTensor_Zero();

    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        float3 cosTr, cosTi;
        CTensor_ComplexCosT(N1, N2, sinTI, ax, cosTr, cosTi);

        float3 n1r  = CTensor_DiagReal(N1, ax);
        float3 n2r  = CTensor_DiagReal(N2, ax);
        float3 scale = (n2r * cosTr) / max(n1r * cosTI, EPSILON);

        float3 ts_r = CTensor_DiagReal(F.ts, ax),  ts_i = CTensor_DiagImag(F.ts, ax);
        float3 tp_r = CTensor_DiagReal(F.tp, ax),  tp_i = CTensor_DiagImag(F.tp, ax);

        float3 Ts = scale * (ts_r*ts_r + ts_i*ts_i);
        float3 Tp = scale * (tp_r*tp_r + tp_i*tp_i);

        CTensor_SetDiagReal(T, ax, (Ts + Tp) * 0.5);
    }

    return T;
}

// -----------------------------------------------------------------------------
//  BEER–LAMBERT TENSOR   A = exp(−4πk/λ · d)
//  Real diagonal = transmittance attenuation per channel/axis.
// -----------------------------------------------------------------------------
ComplexTensorRGB CTensor_BeerLambert(
    ComplexTensorRGB N,
    float3           lambda_m,
    float            thickness_m)
{
    ComplexTensorRGB A = CTensor_Zero();
    [unroll]
    for (int ax = 0; ax < 3; ax++) {
        float3 k     = CTensor_DiagImag(N, ax);
        float3 alpha = (4.0 * PI * k) / max(lambda_m, EPSILON);
        CTensor_SetDiagReal(A, ax, exp(-alpha * thickness_m));
    }
    return A;
}

// -----------------------------------------------------------------------------
//  MATERIAL LIBRARY  (measured n,k: R=650 nm, G=532 nm, B=450 nm)
// -----------------------------------------------------------------------------


ComplexTensorRGB Material_Glass() {
    return CTensor_Isotropic(float3(1.515, 1.519, 1.528), float3(0.000, 0.000, 0.000));
}

// int index — no float-comparison branching
ComplexTensorRGB SelectMaterial(int idx) {
    switch (idx) {
        case 0:  return Material_Air();
        case 1:  return Material_Gold();
        case 2:  return Material_Silver();
        case 3:  return Material_Copper();
        case 4:  return Material_Diamond();
        case 5:  return Material_Glass();
        default: return Material_Air();
    }
}

// -----------------------------------------------------------------------------
//  INTERFACE EVALUATOR
//  All quantities remain ComplexTensorRGB until the pixel shader collapses them.
// -----------------------------------------------------------------------------
void EvaluateInterface(
    ComplexTensorRGB     matI,
    ComplexTensorRGB     matT,
    float3               incident_dir,
    float3               surface_normal,
    ComplexTensorRGB     L_in,          // incident radiance as tensor
    float3               lambda_m,
    float                thickness_m,
    out ComplexTensorRGB L_reflected,
    out ComplexTensorRGB L_transmitted,
    out ComplexTensorRGB R_tensor,
    out ComplexTensorRGB T_tensor,
    out ComplexTensorRGB Abs_tensor)
{
    float cosTheta = saturate(-dot(incident_dir, surface_normal));
    float sinTheta = sqrt(max(0.0, 1.0 - cosTheta*cosTheta));

    FresnelCoeffsRGB F = CTensor_BuildFresnel(matI, matT, sinTheta);

    R_tensor   = CTensor_Reflectance(F);
    T_tensor   = CTensor_Transmittance(F, matI, matT, sinTheta);
    Abs_tensor = CTensor_BeerLambert(matT, lambda_m, thickness_m);

    L_reflected   = CTensor_MulReal(R_tensor, L_in);
    L_transmitted = CTensor_MulReal(CTensor_MulReal(T_tensor, Abs_tensor), L_in);
}

// =============================================================================
//  PIXEL SHADER
//  float3 appears here ONLY to collapse tensors to display RGB at the boundary.
// =============================================================================

psout PS99(PS_INPUT input)
{
    psout o;
    InitPSOut(o, input.uv, float2(0,0));
    float2 uv = input.uv;

    // 1. Parallax UV shift
    float h_unit = DepthUM;
    float h_m    = umToM(h_unit);
    uv += ParallaxFactor.xy * (h_m * ParallaxScale);

    // 2. Surface normal
    float3 N = calcNormal(depthMap, input.uv);

    // 3. Incident direction
    float3 V = ViewDir;

    // 4. Build incident radiance tensor from separate spectrum cbuffer.
    //    LightColor is float3 power spectrum (not a direction).
    ComplexTensorRGB L_in = CTensor_Isotropic(CosineFactor, float3(0,0,0));

    // 5. Media  (MaterialIndex is int cbuffer)
    ComplexTensorRGB matI = Material_Air();
    ComplexTensorRGB matT = SelectMaterial(MaterialIndex);

    // 6. Wavelengths per channel [m]
    float3 lambda_m = RGBToWavelengthsM(Diffuse);

    // 7. Full interface evaluation — all tensors
    ComplexTensorRGB L_reflected, L_transmitted, R_tensor, T_tensor, Abs_tensor;
    EvaluateInterface(
        matI, matT, V, N,
        L_in, lambda_m, h_m,
        L_reflected, L_transmitted,
        R_tensor, T_tensor, Abs_tensor);

    // 8. Combine reflected + transmitted (TransmitWeight cbuffer, 0=opaque)
    float3 TransmitWeight = ParallaxFactor;
    ComplexTensorRGB L_out_tensor = CTensor_AddReal(
        L_reflected,
        CTensor_ScaleBySpectrum(L_transmitted, TransmitWeight));

    // 9. Vertex color mask — VertexColorFloor cbuffer guards against black default
    float3 VertexColorFloor = float3(TanhFactorR,TanhFactorG,TanhFactorB);
    ComplexTensorRGB L_masked = CTensor_ScaleBySpectrum(
        L_out_tensor,
        max(input.Color.rgb, VertexColorFloor));

    // 10. Collapse to float3 — ONLY float3 at this level
    float3 L_out = lerp(Diffuse, CTensor_CollapseToSpectrum(L_masked), max(0, dot(N, HalfDir)));

    // 11. Gamma correction
    float invGamma = (Gamma > 0.0) ? (1.0 / Gamma) : 1.0;
    o.rt1 = float4(pow(saturate(L_out*max(0,dot(HalfDir,N))), invGamma), ShaderAlpha);

    o.rt2 = float4(CTensor_CollapseToSpectrum(R_tensor),      1.0);
    o.rt3 = float4(CTensor_CollapseToSpectrum(T_tensor),      1.0);
    o.rt4 = float4(CTensor_CollapseToSpectrum(Abs_tensor),    1.0);
    o.rt5 = float4(CTensor_CollapseToSpectrum(L_reflected),   1.0);
    o.rt6 = float4(CTensor_CollapseToSpectrum(L_transmitted), 1.0);
    o.rt7 = 0;
    o.rt8 = 0;

    return o;
}




// Exact sRGB ↔ linear (IEC 61966-2-1)
float3 srgbToLinear(float3 c)
{
    float3 lo = c / 12.92;
    float3 hi = pow((c + 0.055) / 1.055, 2.4);
    float3 useHi = step(0.04045, c);
    return lerp(lo, hi, useHi);
}

float3 linearToSrgb(float3 c)
{
    c = saturate(c);
    float3 lo = 12.92 * c;
    float3 hi = 1.055 * pow(c, 1.0 / 2.4) - 0.055;
    float3 useHi = step(0.0031308, c);
    return lerp(lo, hi, useHi);
}

// Exact Fresnel for conductors
float3 FresnelConductor(float3 cosTheta, float3 n, float3 k)
{
    float3 cos2 = cosTheta * cosTheta;
    float3 n2   = n * n;
    float3 k2   = k * k;
    float3 n2k2 = n2 + k2;
    float3 twoNC = 2.0 * n * cosTheta;

    float3 rPerpNum = n2k2 - twoNC + cos2;
    float3 rPerpDen = n2k2 + twoNC + cos2;
    float3 Rperp    = rPerpNum / rPerpDen;

    float3 rParNum  = (n2k2 * cos2) - twoNC + 1.0;
    float3 rParDen  = (n2k2 * cos2) + twoNC + 1.0;
    float3 Rpar     = rParNum / rParDen;

    return 0.5 * (Rperp + Rpar);
}

// σ_a = 4πk / λ
inline float3 SigmaAFromK(float3 k, float3 lambda)
{
    return 4.0f * PI * k / lambda;
}

// Rayleigh air attenuation ~ 1 / λ^4
float3 SigmaA_Rayleigh(float3 lambda, float scale)
{
    float  lambda0 = 550e-9; // reference wavelength
    float3 ratio   = lambda0.xxx / lambda;
    float3 ratio4  = ratio * ratio * ratio * ratio;
    return scale * ratio4;
}

psout PS23(
    PS_INPUT input
)
{
float3 gN = HeightParam;
float3 gK = ParallaxFactor;
float3 gLambda = PhaseOffset;
float gRayleighScale = f05;

    psout output;
    // Depth: 1 = near, 0 = far → distance along v
    InitPSOut(output, input.uv, float2(0,0));
    float depth = SampleDepth(depthMap, input.uv);
    float distance = length(ViewPosM - DepthScale - PixelWorldM);

    // View-space normal (orthographic camera along -Z)
    float3 Nvs = calcNormal(depthMap,input.uv);
    float3 Vvs = normalize(ViewPosM-PixelWorldM); // view direction
    float  cosThetaScalar = saturate(dot(Nvs, -Vvs));
    float3 cosTheta = cosThetaScalar.xxx;

    // Diffuse reflectance at λR, λG, λB
    float3 diffuse_srgb = SampleDiffuse(diffuseMap, input.uv);
    float3 R = srgbToLinear(diffuse_srgb);

    // Fresnel from measured n,k and true cosθ (within ortho model)
    float3 F = FresnelConductor(cosTheta, gN, gK);

    // Surface extinction from measured k, λ
    float3 sigmaA_surface = SigmaAFromK(gK, gLambda);

    // Rayleigh air extinction (wavelength-dependent)
    float3 sigmaA_air = SigmaA_Rayleigh(gLambda, gRayleighScale);

    // Total extinction coefficient
    float3 sigmaA_total = sigmaA_surface + sigmaA_air;

    // Beer–Lambert transmission
    float3 T = exp(-sigmaA_total * distance);

    // Energy-conserving diffuse + specular split:
    //  - diffuse gets (1 - F)
    //  - specular gets F
    //  - both attenuated by T
    float3 diffuseTerm  = T * R * (1.0 - F);
    float3 specularTerm = T * F; // assuming unit incident radiance

    float3 C_lin = diffuseTerm + specularTerm;
    float3 C_srgb = linearToSrgb(C_lin);

    output.rt1 = float4(C_srgb, 1.0);
    return output;
}


float3 QuantumPhaseNoise(float wavelength, float2 uv, float seed)
{
    // Sub-wavelength jitter scale (fraction of wl)
    float jitter = frac(sin(dot(uv, float2(12.9898, 78.233)) + seed) * 43758.5453);

    // Convert jitter into a phase offset in radians
    float phaseOffset = jitter * (2.0 * 3.14159265359);

    // True photon phase = 2PI * (path / wl) + jitter
    float basePhase = (2.0 * 3.14159265359 + jitter +time*f09) / wavelength;

    return basePhase + phaseOffset;
}

float4 PS2(float2 uv : TEXCOORD0) : SV_Target
{
    float wl = f01*1e-9; // 550 nm green light
    float3 phase = QuantumPhaseNoise(wl, (uv-0.5)*float2(f03,f04)+0.5, f02);

    float wl2 = f05*1e-9; // 550 nm green light
    float3 phase2 = QuantumPhaseNoise(wl2, (uv-0.5)*float2(f07,f08)+0.5, f06);

    // Convert phase to intensity via cosine interference
    float3 intensity = 0.5 + 0.5 * (cos(phase+TotalTime));
    float3 intensity2 = 0.5 + 0.5 * (cos(phase2+TotalTime));
    
    return float4(float3(length(intensity), length(intensity+intensity2) * .5, length(intensity2))*.33, 1.0);
}



// ============================================================
//  Trans-Spectral Phase-Commutation Operator  (Omega_ts)
//
//  Acts on a multi-wavelength complex wavefield Psi(x, y, lambda).
//  Enforces a non-commutative phase-ordering constraint across
//  all wavelengths simultaneously, such that:
//
//      Omega_ts * Phi1 * Phi2  !=  Phi2 * Phi1 * Omega_ts
//
//  for any pair of phase operators Phi1, Phi2 acting on
//  distinct lambda-bands.
// ============================================================

// --- Complex number helpers ---------------------------------

float2 CMul(float2 a, float2 b)
{
    return float2(a.x * b.x - a.y * b.y,
                  a.x * b.y + a.y * b.x);
}

float2 CExp(float theta)
{
    return float2(cos(theta), sin(theta));
}

// Phase operator Phi(psi, theta): multiplies a complex wavefield
// sample by e^{i * theta}.
float2 PhaseOp(float2 psi, float theta)
{
    return normalize(float2(cos(theta) * psi.x, psi.y * sin(theta)));
}

// ============================================================
//  Band structure
//  We discretise the continuous lambda axis into N_BANDS bands.
//  Each band carries its own complex amplitude sample.
// ============================================================

#define N_BANDS 6

// Spectral wavelength centres (normalised, 0..1)
static const float Lambda[N_BANDS] =
{
    0.0f,          // band 0  – deep violet
    0.2f,          // band 1  – blue
    0.4f,          // band 2  – green
    0.6f,          // band 3  – yellow
    0.8f,          // band 4  – orange-red
    1.0f           // band 5  – deep red
};

// ============================================================
//  Commutator kernel
//
//  For bands i and j (i < j) the ordering-asymmetry angle is:
//
//      delta_ij = theta_i * theta_j * (lambda_i - lambda_j)
//
//  This makes Phi_i * Phi_j ≠ Phi_j * Phi_i when projected
//  through Omega_ts, because Omega_ts introduces the spectral
//  cross-coupling that breaks symmetry.
// ============================================================

float CommutatorAngle(float theta_i, float theta_j,
                      float lambda_i, float lambda_j)
{
    return theta_i * theta_j * (lambda_i - lambda_j);
}

// ============================================================
//  Trans-Spectral Phase-Commutation Operator
//
//  Input
//      psi[N_BANDS]    – complex wavefield samples per band
//      theta[N_BANDS]  – intrinsic phase per band (radians)
//      x, y            – spatial coordinates (used to modulate
//                        the ordering constraint spatially)
//
//  Output
//      result[N_BANDS] – transformed wavefield after Omega_ts
//
//  Algorithm
//  1.  Apply Phi_i to every band in ascending lambda order
//      (ordered application).
//  2.  For each ordered pair (i, j) compute the commutator
//      residual angle delta_ij and inject it back as a
//      cross-band phase correction — this is the term that
//      would vanish if the operator were commutative.
//  3.  Re-apply the corrected phase so that swapping the
//      application order produces a different result.
// ============================================================

void OmegaTS(inout float2 psi[N_BANDS],
             in    float  theta[N_BANDS],
             in    float  x,
             in    float  y)
{
    // --- Step 1: ordered forward phase application -----------
    //     Apply bands from lowest to highest lambda.
    //     The spatial modulation couples (x,y) into the ordering.

    [unroll]
    for (int i = 0; i < N_BANDS; ++i)
    {
        float spatial = sin(x * (1.0f + Lambda[i]+time) + y * Lambda[i]);
        psi[i] = PhaseOp(psi[i], theta[i] + spatial * 0.1f);
    }

    // --- Step 2: non-commutative cross-band correction -------
    //     For every ordered pair (i < j), compute delta_ij and
    //     apply it to band j.  If Phi_i and Phi_j commuted,
    //     delta_ij would be 0 for all pairs.

    [unroll]
    for (int ii = 0; ii < N_BANDS - 1; ++ii)
    {
        [unroll]
        for (int jj = ii + 1; jj < N_BANDS; ++jj)
        {
            float delta = CommutatorAngle(theta[ii], theta[jj],
                                          Lambda[ii], Lambda[jj]);

            // Spatial weighting: the commutation asymmetry
            // varies over the wavefield.
            float w = cos(time+x * (Lambda[jj] - Lambda[ii])
                        + y * (Lambda[ii] + Lambda[jj]));

            psi[jj] = PhaseOp(psi[jj], delta * w);
        }
    }

    // --- Step 3: reverse-order normalisation -----------------
    //     Apply bands from highest to lowest lambda with the
    //     negated phase so that  Omega_ts * Phi1 * Phi2  and
    //     Phi2 * Phi1 * Omega_ts  accumulate different residuals.

    [unroll]
    for (int k = N_BANDS - 1; k >= 0; --k)
    {
        float spatial = cos(time+x * Lambda[k] - y * (1.0f - Lambda[k]));
        psi[k] = PhaseOp(psi[k], -theta[k] * 0.5f + spatial * 0.05f);
    }
}

// ============================================================
//  Entry point — pixel / fragment shader
//
//  Demonstrates Omega_ts on a synthetic wavefield initialised
//  from uv coordinates, producing a spectrally-ordered
//  interference pattern whose colours encode the non-commutative
//  phase residuals across bands.
// ============================================================

#define Time time
#define PhaseScale f01
psout PS22(PS_INPUT input)
{
    float4 pos = input.Position;
    psout output;
    InitPSOut(output, input.uv, float2(0,0));
    
    float2 Resolution = GetSz(depthMap);
    // Normalised, centred coordinates
    float2 uv = (pos.xy / Resolution.xy) * 2.0f - 1.0f;
    uv.x *= Resolution.x / Resolution.y;   // aspect-correct

    // ---- Initialise wavefield Psi(x, y, lambda) -------------
    float2 psi[N_BANDS];
    [unroll]
    for (int b = 0; b < N_BANDS; ++b)
    {
        // Radially-modulated initial amplitude
        float r    = length(uv + float2(cos(Time + Lambda[b] * 6.2832f),
                                        sin(Time + Lambda[b] * 6.2832f)) * 0.3f);
        float amp  = exp(-r * r * 2.0f);
        float phi0 = r * 8.0f + (1.0f + Lambda[b]);
        psi[b]     = float2(amp * cos(Time + phi0), amp * sin(Time + phi0));
    }

    // ---- Per-band intrinsic phases ---------------------------
    float theta[N_BANDS];
    [unroll]
    for (int t = 0; t < N_BANDS; ++t)
    {
        theta[t] = PhaseScale * Lambda[t];
    }

    // ---- Apply Omega_ts -------------------------------------
    OmegaTS(psi, theta, uv.x, uv.y);

    // ---- Map wavefield intensities to visible spectrum -------
    //  Band 0-1 → blue,  2-3 → green,  4-5 → red
    float intensity[N_BANDS];
    [unroll]
    for (int m = 0; m < N_BANDS; ++m)
        intensity[m] = dot(psi[m], psi[m]);   // |psi|^2

    float3 diffuse = SampleDiffuse(diffuseMap, input.uv).xyz;
    float3 c = WavelengthsToRGB(RGBToWavelengthsNM(diffuse));

    float3 col = float3(
        (intensity[4] + intensity[5]) *.5,   // R
        (intensity[2] + intensity[3]) *.35,   // G
        (intensity[0] + intensity[1]) *.5    // B
    );
    col += diffuse*.25; // modulate by diffuse texture for visual interest

    // Tone-map and gamma
    col  = col / (col + 1.0f);
    col  = pow(saturate(col), 0.4545f);

    output.rt1 = float4(col, 1.0f);
    return output;
}



// ============================================================
//  Sigma_pi  — Holographic Path-Integral Rewrite Operator
//
//  Rewrites a holographic wavefield  Psi(x, y)  into a
//  path-integral representation over an extended configuration
//  space C' = C x Lambda x Phi, where:
//
//      C       – spatial configuration space  (x, y)
//      Lambda  – wavelength manifold
//      Phi     – phase-wrapping manifold
//
//  The operator maps:
//
//      Psi(x,y)  →  ∫ exp( i · S[path] ) d[path]
//
//  where S is a holographically defined action functional.
//
//  Discretisation strategy
//  ·  C       sampled by N_SPATIAL neighbouring lattice sites
//  ·  Lambda  sampled by N_LAMBDA wavelength nodes
//  ·  Phi     sampled by N_PHI    wrapping nodes  (0 … 2π)
//  ·  Paths   are sequences of (C, Lambda, Phi) triples;
//             we marginalise over Lambda and Phi analytically
//             per spatial hop to keep the integral tractable.
// ============================================================

// ---- compile-time lattice dimensions ----------------------
#define N_SPATIAL   8     // neighbours in C
#define N_LAMBDA    6     // nodes on Lambda manifold
#define N_PHI       8     // nodes on Phi manifold
#define N_PATH_HOPS 4     // depth of the path integral

// ---- complex helpers --------------------------------------

float2 oCMul(float2 a, float2 b)
{
    return float2(a.x*b.x - a.y*b.y,
                  a.x*b.y + a.y*b.x);
}

float2 oCExp(float theta)          // e^{i*theta}
{
    return float2(cos(theta), sin(theta));
}

float2 oCConj(float2 a)            // complex conjugate
{
    return float2(a.x, -a.y);
}

float oCNorm2(float2 a)            // |a|^2
{
    return dot(a, a);
}

// ============================================================
//  Extended configuration space  C' = C x Lambda x Phi
// ============================================================

// Lambda manifold: N_LAMBDA normalised wavelengths in [0,1]
static const float LambdaNodes[N_LAMBDA] =
{
    0.0f, 0.2f, 0.4f, 0.6f, 0.8f, 1.0f
};

// Phi manifold: N_PHI wrapping phases in [0, 2π)
static const float PhiNodes[N_PHI] =
{
    0.0f,
    0.7854f,   // pi/4
    1.5708f,   // pi/2
    2.3562f,   // 3pi/4
    3.1416f,   // pi
    3.9270f,   // 5pi/4
    4.7124f,   // 3pi/2
    5.4978f    // 7pi/4
};

// Spatial neighbour offsets on the C lattice
static const float2 CNeighbours[N_SPATIAL] =
{
    float2( 1, 0), float2(-1, 0),
    float2( 0, 1), float2( 0,-1),
    float2( 1, 1), float2(-1, 1),
    float2( 1,-1), float2(-1,-1)
};

// ============================================================
//  Holographic action functional  S[path]
//
//  S is decomposed into three additive terms reflecting the
//  three manifold factors of C':
//
//      S = S_C  +  S_Lambda  +  S_Phi
//
//  S_C      – kinetic term: spatial hop length squared
//  S_Lambda – spectral curvature: second difference of lambda
//             along the path (penalises rapid spectral jumps)
//  S_Phi    – winding term: accumulated phase wrapping modulo
//             2π (encodes topological winding number)
//
//  All three terms are weighted and summed to give the total
//  action for a single (hop, lambda_i, phi_k) triple.
// ============================================================

float ActionFunctional(float2 pos_curr, float2 pos_next,
                       float  lambda_prev, float lambda_curr, float lambda_next,
                       float  phi_curr,    float phi_next,
                       float  hologram_amplitude)
{
    // S_C: spatial kinetic term
    float2 hop    = pos_next - pos_curr;
    float  S_C    = dot(hop, hop);                           // |Δx|^2

    // S_Lambda: spectral curvature (second difference)
    float  S_Lam  = (lambda_next - 2.0f*lambda_curr + lambda_prev)
                  * (lambda_next - 2.0f*lambda_curr + lambda_prev);

    // S_Phi: phase-winding cost
    //   wrap the phase difference into (-pi, pi]
    float  dphi   = phi_next - phi_curr;
    dphi          = dphi - 6.2832f * floor((dphi + 3.1416f) / 6.2832f);
    float  S_Phi  = dphi * dphi;

    // Holographic coupling: the local wavefield amplitude
    // modulates the action (the hologram "encodes" the paths).
    float  S_holo = hologram_amplitude * S_C * (1.0f + lambda_curr);

    return S_holo + 0.3f * S_Lam + 0.15f * S_Phi;
}

// ============================================================
//  Path propagator  K(pos, lambda_i, phi_k → pos')
//
//  For a single hop from (pos, lambda_i, phi_k) to a neighbour
//  in C, marginalised over all (lambda_next, phi_next) nodes,
//  compute the complex propagator amplitude:
//
//      K = Σ_{lambda'} Σ_{phi'} exp( i · S ) · w(lambda', phi')
//
//  where w is a measure factor (flat = 1/N here).
// ============================================================
float2 PathPropagator(float2 pos_curr, float2 pos_next,
                      float  lambda_prev, float lambda_curr,
                      float  phi_curr,
                      float  hologram_amplitude)
{
    float2 K = float2(0.0f, 0.0f);
    float  measure = 1.0f / (float)(N_LAMBDA * N_PHI);

    [loop]
    for (int li = 0; li < N_LAMBDA; ++li)
    {
        [loop]
        for (int pi = 0; pi < N_PHI; ++pi)
        {
            float S = ActionFunctional(pos_curr,    pos_next,
                                       lambda_prev,  lambda_curr,
                                       LambdaNodes[li],
                                       phi_curr,     PhiNodes[pi],
                                       hologram_amplitude);

            // exp(i·S) with flat measure
            K += oCMul(oCExp(S), float2(measure, 0.0f));
        }
    }
    return K;
}


// ============================================================
//  Sigma_pi  — the full operator
//
//  Psi(x,y)  →  ∫ exp(i·S[path]) d[path]
//
//  Implemented as a discrete sum over all paths of length
//  N_PATH_HOPS in C', starting from (pos, lambda_0, phi_0).
//
//  Each path contributes:
//      A_path = Psi(x,y) · Π_{hops} K(hop)
//
//  The final result is the coherent sum over all paths.
// ============================================================

float2 SigmaPi(float2 pos,
               float2 psi_in,           // Psi(x,y) — input wavefield
               float  lambda_init,      // starting node on Lambda
               float  phi_init,         // starting node on Phi
               float  hologram_amp)     // |Psi| used in action
{
    // Seed the integral with the input wavefield amplitude
    float2 integral = psi_in ;

    float lam_prev = lambda_init;
    float lam_curr = lambda_init;
    float phi_curr = phi_init;
    float2 pos_curr = pos;

    // Iterate hops, accumulating the product of propagators
    [unroll]
    for (int hop = 0; hop < N_PATH_HOPS; ++hop)
    {
        float2 hop_sum = float2(0.0f, 0.0f);
        float  inv_N   = 1.0f / (float)N_SPATIAL;

        [unroll]
        for (int nb = 0; nb < N_SPATIAL; ++nb)
        {
            float2 pos_next = pos_curr + CNeighbours[nb] * 0.15f;

            float2 K = PathPropagator(pos_curr, pos_next,
                                      lam_prev,  lam_curr,
                                      phi_curr,
                                      hologram_amp);

            hop_sum += oCMul(K, float2(inv_N, 0.0f));
          
        }

        // Advance the manifold state along the dominant node
        // (we re-use lam_curr as "prev" for the next hop)
        lam_prev  = lam_curr;
        //lam_curr  = frac(lam_curr + 0.17f);   // walk on Lambda
        //phi_curr  = fmod(phi_curr + 0.7854f, 6.2832f); // walk on Phi

        // walk on Phi, wrapped to [0, 2π)
        phi_curr = fmod(phi_curr + 0.7854f, 6.2832f);
        if (phi_curr < 0.0f) phi_curr += 6.2832f;
       // phi_curr *= f03;

        // walk on Lambda, wrapped to [0,1)
        lam_curr = frac(lam_curr + 0.17f);


        pos_curr  = pos_curr + float2(cos(phi_curr), sin(phi_curr)) * 0.05f;

        // Multiply accumulated integral by this hop's propagator sum
        integral  = oCMul(integral, hop_sum);
        
    }

    return integral;
}

// ============================================================
//  Pixel shader entry point
//
//  Constructs a synthetic holographic wavefield Psi(x,y),
//  applies Sigma_pi, and maps the resulting complex amplitude
//  to colour via phase-wheel + intensity encoding.
// ============================================================


    #define  LambdaGlobal DepthScale
    //;   // global lambda seed  [0,1]
    #define PhiGlobal HeightScale
    //;      // global phi seed      [0, 2pi]

// Phase-to-colour: maps complex number to hue (phase) + luminance (|z|)
float3 ComplexToRGB(float2 z)
{
    float phase = atan2(clamp(z.y,-1,1), clamp(z.x,-1,1));                 // [-pi, pi]
    // map to [0,1], then clamp to a safe hue band
    float hue   = (phase / 6.2832f) + 1.0f;        // [0,1]
    hue         = clamp(hue, 0.1f, 1.0f);

    float mag2  = dot(z, z);
    float mag   = sqrt(max(mag2, 0.0f));           // |z|
    mag         = clamp(mag, 0.1f, 1.0f);         // avoid absurd magnitudes

    float3 rgb;
    float  h6 = hue * 6.0f;
    float  f  = frac(h6);
    float  q  = 1.0f - f;
    int   hi = (uint)h6 % 6;

    if      (hi == 0) rgb = float3(1, f, 0);
    else if (hi == 1) rgb = float3(q, 1, 0);
    else if (hi == 2) rgb = float3(0, 1, f);
    else if (hi == 3) rgb = float3(0, q, 1);
    else if (hi == 4) rgb = float3(f, 0, 1);
    else              rgb = float3(1, 0, q);

    float lum = mag / (mag + 1.0f);                // in (0,1)
    rgb       = saturate(rgb * lum);
    rgb       = pow(rgb, 0.4545f);                 // gamma

    return rgb;
}

#define Resolution GetSz(depthMap)
psout PS33(PS_INPUT input)
{
    psout ret;
    InitPSOut(ret, input.uv);

    float2 svpos = ((input.uv-0.5));
    float2 uv = svpos;

    // ---- Construct holographic wavefield Psi(x,y) ----------
    //  Superposition of three coherent spherical waves
    float2 src0 = float2(-0.4f,  0.3f);
    float2 src1 = float2( 0.5f, -0.2f);
    float2 src2 = float2( 0.0f,  0.5f);

    float  k    = 12.0*f10;    // spatial frequency

    float2 psi  = float2(0.0f, 0.0f);
    [unroll]
    for (int s = 0; s < 3; ++s)
    {
        float2 src = (s == 0) ? src0 : (s == 1) ? src1 : src2;
        float  r   = length(uv - src) + EPSILON;
        float  amp = 1.0f / (r+EPSILON);
        float  phi = k * r - Time * (1.0f + 0.2f * (float)s);
        psi       += float2(amp * cos(phi), amp * sin(phi));
    }

    float holo_amp = (oCNorm2(psi));

    // ---- Apply Sigma_pi ------------------------------------
    float lam0 = (LambdaGlobal + length(uv) * 0.3f);
    float phi0 = fmod(PhiGlobal + atan2(uv.y, uv.x) + 3.1416f, 6.2832f);

    float2 result = SigmaPi(uv, psi, lam0, phi0, holo_amp);
    
    // ---- Encode output -------------------------------------
    float3 col = ComplexToRGB(result);
    ret.rt1.xyz = 
        input.uv.x < .1 ? lam0 :
        input.uv.x < .2 ? phi0:
        input.uv.x < .3 ? holo_amp:
        input.uv.x < .4 ? float3(psi,0.0):
        input.uv.x < .5 ? float3(result,0.0):
        col;
    return ret;
}

   // decay λ > 0
    #define  Lambda f01
    
    //       // step Δt
    #define Dt f02
    #define Steps NormalRadius
    #define ScreenScale float2(f03,f04)


float BulkPhi(float3 p)
{
    float r2 = dot(p, p);
    return 1.0 / (1.0 + r2);
}

float HoloIntegral(float2 uv, float lambda, float dt, int steps)
{
    float3 dir = float3(uv, 1.0); // ray into bulk
    float  t   = 0.0;
    float  acc = 0.0;

    [loop]
    for (int k = 0; k < steps; ++k)
    {
        float3 p   = t * dir;
        float  phi = BulkPhi(p);
        float  w   = exp(-lambda * t);
        acc += w * phi;
        t   += dt;
    }

    return acc * dt;
}

// -----------------------------------------------------------------------------
// Ω-echelon holographic pixel shader (advanced, multi-grating, multi-RT)
// Boundary UV encodes a holographic plate; bulk-like structure emerges from
// parallax, phase-modulated gratings, and Fresnel-weighted interference.
// -----------------------------------------------------------------------------

psout PS4444(PS_INPUT IN)
{
    psout OUT;
    InitPSOut(OUT, IN.uv);
    
    // --- Unpack camera / light ------------------------------------------------
    float3 sunDir  = normalize(float3(SunX, SunY, SunZ));
    float3 viewPos = float3(ViewX, ViewY, ViewZ);
    float3 lookAt  = float3(LookAtX, LookAtY, LookAtY + LookAtDeltaY);
    float3 V       = normalize(IN.VSViewDir);

    float2 uv      = IN.uv;

    // --- Parallax / height field ----------------------------------------------
    float baseHeight = SampleDepth(depthMap, uv);
    float parallax   = (baseHeight * ParallaxScale + HeightScale * HeightParamA);
    float2 viewXY    = normalize(V.xy + 1e-5);
    float2 uvPar     = uv + viewXY * parallax;

    // Clamp to avoid sampling garbage
    uvPar = saturate(uvPar);

    // --- Base normal & diffuse -------------------------------------------------
    float3 nBase = normalize(normalMap.Sample(samplerState, uvPar) * 2.0f - 1.0f);
    float3 nView = normalize(nBase); // tangent-space already approximated as view-space

    float3 baseAlbedo = diffuseMap.Sample(samplerState, uvPar).rgb;

    // --- Noise / gradient fields for phase modulation -------------------------
    float3 g1 = gradient1.Sample(samplerState, uvPar);
    float3 g2 = gradient2.Sample(samplerState, uvPar);
    float3 g3 = gradient3.Sample(samplerState, uvPar);
    float3 g4 = gradient4.Sample(samplerState, uvPar);

    float3 nG = normalize(g1 + g2 + g3 + g4 + 1e-5);

    float3 noise1 = noiseMap1.Sample(samplerState, uvPar);
    float3 noise2 = noiseMap2.Sample(samplerState, uvPar);
    float3 noise3 = noiseMap3.Sample(samplerState, uvPar);
    float3 noise4 = noiseMap4.Sample(samplerState, uvPar);

    // --- Grating depths (height-like phase carriers) --------------------------
    float d1 = gratingDepth1.Sample(samplerState, uvPar).r;
    float d2 = gratingDepth2.Sample(samplerState, uvPar).r;
    float d3 = gratingDepth3.Sample(samplerState, uvPar).r;
    float d4 = gratingDepth4.Sample(samplerState, uvPar).r;

    // --- Time / animation ------------------------------------------------------
    float t  = TotalTime * AnimateSpeed;
    float t2 = t * 0.5f;

    // --- Phase construction per channel (R,G,B) --------------------------------
    // Phase = base offset + cosine + tanh + noise + depth coupling
    float phaseR =
        PhaseOffsetR
      + CosineFactorR * cos(ParallaxFactorA * d1 + t)
      + TanhFactorR   * tanh(HeightParamB * d2 + noise1.r * HeightParamC)
      + dot(noise2,  float3(0.7, 0.2, 0.1));

    float phaseG =
        PhaseOffsetG
      + CosineFactorG * cos(ParallaxFactorB * d3 + t2)
      + TanhFactorG   * tanh(HeightParamB * d4 + noise3.g * HeightParamC)
      + dot(noise4,  float3(0.3, 0.6, 0.1));

    float phaseB =
        PhaseOffsetB
      + CosineFactorB * cos(ParallaxFactorC * (d1 + d4) + t)
      + TanhFactorB   * tanh(HeightParamC * (d2 + d3) + noise2.b)
      + dot(noise1,  float3(0.2, 0.3, 0.5));

    // --- Grating color carriers ------------------------------------------------
    float3 gCol1 = gratingMap1.Sample(samplerState, uvPar).rgb;
    float3 gCol2 = gratingMap2.Sample(samplerState, uvPar).rgb;
    float3 gCol3 = gratingMap3.Sample(samplerState, uvPar).rgb;
    float3 gCol4 = gratingMap4.Sample(samplerState, uvPar).rgb;

    // --- Grating normals (microstructure) -------------------------------------
    float3 gn1 = normalize(gratingNormal1.Sample(samplerState, uvPar) * 2.0f - 1.0f);
    float3 gn2 = normalize(gratingNormal2.Sample(samplerState, uvPar) * 2.0f - 1.0f);
    float3 gn3 = normalize(gratingNormal3.Sample(samplerState, uvPar) * 2.0f - 1.0f);
    float3 gn4 = normalize(gratingNormal4.Sample(samplerState, uvPar) * 2.0f - 1.0f);

    // --- Local holographic normal (bulk-like micro-geometry) -------------------
    float3 nHolo = normalize(nBase +
                             NormalRadius * (gn1 + gn2 + gn3 + gn4) +
                             NormalRadius * nG);

    // --- Fresnel term (boundary/bulk coupling) --------------------------------
    float NdotV = saturate(dot(nHolo, -V));
    float fresnel =
        FresnelReflectance +
        (1.0f - FresnelReflectance) * pow(1.0f - NdotV, FresnelPower);

    // --- Specular lobe ---------------------------------------------------------
    float3 H = normalize(-V + sunDir);
    float NdotL = saturate(dot(nHolo, sunDir));
    float NdotH = saturate(dot(nHolo, H));
    float spec  = SpecularIntensity * pow(NdotH, SpecularPower) * NdotL;

    // --- Complex holographic amplitude per color channel ----------------------
    float2 A_R = float2(cos(phaseR), sin(phaseR)) * dot(gCol1, float3(0.3, 0.6, 0.1));
    float2 A_G = float2(cos(phaseG), sin(phaseG)) * dot(gCol2, float3(0.2, 0.5, 0.3));
    float2 A_B = float2(cos(phaseB), sin(phaseB)) * dot(gCol3, float3(0.4, 0.3, 0.5));

    // Optional 4th grating as cross-channel interference booster
    float2 A_X = float2(cos(phaseR + phaseG), sin(phaseR + phaseG)) *
                 dot(gCol4, float3(0.33, 0.33, 0.34));

    float2 A_totR = A_R + 0.5f * A_X;
    float2 A_totG = A_G + 0.3f * A_X;
    float2 A_totB = A_B + 0.2f * A_X;

    float I_R = dot(A_totR, A_totR);
    float I_G = dot(A_totG, A_totG);
    float I_B = dot(A_totB, A_totB);

    float3 holoIntensity = float3(I_R, I_G, I_B);

    // --- Base + holographic mix ------------------------------------------------
    float3 diffuseLit = baseAlbedo * NdotL;
    float3 holoColor  = holoIntensity * Mix2 + diffuseLit * (1.0f - Mix2);

    // Add specular and skyline reflection
    float3 sky = skylineMap.Sample(sampleTypeClamp, uvPar).rgb;
    float3 refl = lerp(holoColor, sky, fresnel * FresnelMix);

    float3 finalRGB = refl + spec;

    // Gamma correction
    finalRGB = pow(saturate(finalRGB), 1.0f / max(Gamma, 1e-3));

    // --- Outputs to MRTs -------------------------------------------------------
    OUT.rt1 = float4(finalRGB,1.0);
    (IN.uv.x < .1 ? float4(finalRGB, ShaderAlpha):                 // main color
   IN.uv.x < .2 ?  float4(nHolo * 0.5f + 0.5f, 1.0f):             // encoded normal
    IN.uv.x < .3 ? float4(phaseR, phaseG, phaseB, 1.0f):          // phase field
    IN.uv.x < .4 ? float4(holoIntensity, 1.0f):                   // raw holographic intensity
    IN.uv.x < .5 ? rtMap1.Sample(samplerState, uv):               // passthrough / feedback
    IN.uv.x < .6 ? rtMap2.Sample(samplerState, uv):               // passthrough / feedback
    IN.uv.x < .7 ? float4(NdotL, fresnel, spec, 1.0f):            // lighting diagnostics
    IN.uv.x < .8 ? float4(uvPar, baseHeight, PassNum / NumPasses):// UV/height/debug
    float4(finalRGB,1.0));

    return OUT;
}

float3 ComputePhaseTriplet(float2 uv)
{
    float d1 = gratingDepth1.Sample(sampleTypeLinear, uv).r;
    float d2 = gratingDepth2.Sample(sampleTypeLinear, uv).r;
    float d3 = gratingDepth3.Sample(sampleTypeLinear, uv).r;
    float d4 = gratingDepth4.Sample(sampleTypeLinear, uv).r;

    float t = TotalTime * AnimateSpeed;

    float phaseR =
        PhaseOffsetR +
        CosineFactorR * cos(ParallaxFactorA * d1 + t) +
        TanhFactorR * tanh(HeightParamA * d2);

    float phaseG =
        PhaseOffsetG +
        CosineFactorG * cos(ParallaxFactorB * d3 + t * 0.5) +
        TanhFactorG * tanh(HeightParamB * d4);

    float phaseB =
        PhaseOffsetB +
        CosineFactorB * cos(ParallaxFactorC * (d1 + d4) + t) +
        TanhFactorB * tanh(HeightParamC * (d2 + d3));

    return float3(phaseR, phaseG, phaseB);
}

float3 ComputeHolographicAmplitude(float2 uv, float3 phase)
{
    float3 g1 = gratingMap1.Sample(sampleTypeLinear, uv).rgb;
    float3 g2 = gratingMap2.Sample(sampleTypeLinear, uv).rgb;
    float3 g3 = gratingMap3.Sample(sampleTypeLinear, uv).rgb;
    float3 g4 = gratingMap4.Sample(sampleTypeLinear, uv).rgb;

    float3 carrier = g1 + g2 + g3 + g4;

    float3 Areal = carrier * cos(phase);
    float3 Aimag = carrier * sin(phase) * 0.5;
    return Areal * Areal + Aimag * Aimag; // |A|^2 per channel
}

psout PS(PS_INPUT IN)
{
    float2 uv = IN.uv;

    psout OUT;
    InitPSOut(OUT, uv);

    // If you need TBN, build it here; otherwise remove tbn/m
    float3x3 tbn;
    float3 normal = calcNormal(depthMap, uv, tbn);

    // OpticalFlow result currently unused; remove if not needed
    // float3x3 m = OpticalFlow(depthMap, gratingDepth1, uv);



    // --- Parallax reconstruction (pseudo‑bulk geometry) -----------------------
    float h = SampleDepth(depthMap, uv);
    float2 uvP = uv; // + parallax if desired
    uvP = saturate(uvP);

    // --- Holographic normal ---------------------------------------------------
    float3 nH = calcNormal(depthMap, uv);

    // --- Phase field ----------------------------------------------------------
    float3 phase = ComputePhaseTriplet(uvP);

    // --- Holographic amplitude ------------------------------------------------
    float3 holo = ComputeHolographicAmplitude(uvP, phase);

    // --- Lighting -------------------------------------------------------------
    float3 sunDir = normalize(float3(SunX + cos(TotalTime), SunY + 5.0 * sin(TotalTime), SunZ));
    float NdotL = saturate(dot(nH, sunDir));

    float3 base = diffuseMap.Sample(sampleTypeLinear, uvP).rgb;

    // --- Fresnel --------------------------------------------------------------
    float3 V = normalize(IN.VSViewDir * 2.0 - 1.0);
    float NdotV = saturate(dot(nH, V));
    float fres = saturate(FresnelReflectance +
                 (1.0 - FresnelReflectance) * pow(1.0 - saturate(max(0.0, dot(nH, V))), FresnelPower));
    float3 H = normalize(V + sunDir);
    float3 NdotH = saturate(dot(normal,H));
    float3 fresColor = fres;

    // --- Final mix ------------------------------------------------------------
    float3 finalRGB = 
    lerp(holo, base, saturate(NdotH+.5) );

    // --- Outputs --------------------------------------------------------------
    OUT.rt1 = float4(finalRGB, 1.0);
    OUT.rt2 = float4(nH * 0.5 + 0.5, 1.0);
    OUT.rt3 = float4(phase, 1.0);
    OUT.rt4 = float4(holo, 1.0);
    OUT.rt5 = float4(uvP, h, 1.0);
    OUT.rt6 = float4(0.0, 0.0, 0.0, 1.0);
    OUT.rt7 = float4(NdotL, fres, 0.0, 1.0);
    OUT.rt8 = float4(0.0, 0.0, 0.0, 1.0);

    return OUT;
}
