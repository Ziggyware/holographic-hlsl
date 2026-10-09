#define CSPEED_OF_LIGHT CV0(SPEED_OF_LIGHT)
#define C0VSPEED_OF_LIGHT C0V(SPEED_OF_LIGHT)
#define CV0SPEED_OF_LIGHT
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
#define mToNm(x) (x*1e+9)
#define AnimateTime TotalTime*AnimateSpeed
#define SetDV(name, val) {Complex3 _##name [3]; _##name = lighting.##name ; _##name [dispersionIndex] = val; lighting.##name = _##name;}
#define SetDVo(name, val) {OpticalPathResult _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name;}
#define SetDVf(name, val) {float3 _##name[3];_##name = lighting.##name;_##name[dispersionIndex] = val;lighting.##name = _##name;}
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
#define ComplexToTangent11(v) ToTangentSpace11(safeNormalize(ComplexAdd(Complex00,v)))
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
#define CSatMag(v) ComplexSaturatef(CMag(v))
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
#define CV0MulSOL(v) CMul(CV0(v),CSPEED_OF_LIGHT)
#define C0VMulSOL(v) CMul(C0V(v),C0VSPEED_OF_LIGHT)
#define CMulSOL(v) CMul(v,CSPEED_OF_LIGHT)
#define CV0DivSOL(v) CDiv(CV0(v),CSPEED_OF_LIGHT)
#define C0VDivSOL(v) CDiv(C0V(v),C0VSPEED_OF_LIGHT)
#define CDivSOL(v) CDiv(v,CSPEED_OF_LIGHT)
#define CV0SOLDiv(v) CDiv(CSPEED_OF_LIGHT,CV0(v))
#define C0VSOLDiv(v) CDiv(C0VSPEED_OF_LIGHT,C0V(v))
#define CSOLDiv(v) CDiv(CSPEED_OF_LIGHT,v)
#define EPSILON 0.000000001
#define ViewPos float3(ViewX,ViewY,ViewZ)
#define LightPos float3(SunX,SunY,SunZ)
#define linearSampler sampleTypeLinear
#define AnimateTime TotalTime * AnimateSpeed
#define SetDV(name, val) { Complex3 _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }
#define SetDVo(name, val) { OpticalPathResult _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }
#define SetDVf(name, val) { float3 _##name[3]; _##name = lighting.##name; _##name[dispersionIndex] = val; lighting.##name = _##name; }
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
#define SPEED_OF_LIGHT 2.99792458e8
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
#define EPSILON 1e-9
#define EPSILONh 1e-9h
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
#define MaxComponent4(v) max(max(max(v.x,v.y),v.z),v.w)
#define MaxComponent3(v) max(max(v.x,v.y),v.z)
#define MaxComponent2(v) max(v.x,v.y)
#define MinComponent4(v) min(min(min(v.x,v.y),v.z),v.w)
#define MinComponent3(v) min(min(v.x,v.y),v.z)
#define MinComponent2(v) min(v.x,v.y)
#define AddComponents4(v) (v.x+v.y+v.z+v.w)
#define AddComponents3(v) (v.x+v.y+v.z)
#define AddComponents2(v) (v.x+v.y)
#define CountV3AboveV1(v3,f,epsilon) (step(f-epsilon,v3.x)+step(f-epsilon,v3.y)+step(f-epsilon,v3.z))
#define CountV4AboveV1(v4,f,epsilon) (CountV3AboveV1(v4.xyz,f,epsilon)+step(f-epsilon,v4.w))
#define CountV3BelowV1(v3,f,epsilon) (1.0-step(v3.x,f+epsilon)+1.0-step(v3.y,f+epsilon)+1.0-step(v3.z,f+epsilon))
#define CountV4BelowV1(v4,f,epsilon) (CountV3BelowV1(v4.xyz,f,epsilon)+1.0-step(v4.w,f+epsilon))
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
const  float PlanckConstant = 6.62607015e-34;
const  float PhotonMass = 1e-50;
const  float G = 6.67430e-11;
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
#define RGB_WAVELENGTHS_M nmToM(RGB_WAVELENGTHS_NM)
#define RGB_WAVELENGTHS_UM nmToUm(RGB_WAVELENGTHS_NM)
#define MAX_WAVELENGTH 780.0
#define MIN_WAVELENGTH 380.0
#define NUM_SAMPLES 471
#define SPECTRAL_LOCUS_COUNT 471
#define WAVELENGTH_RANGES (MAX_WAVELENGTHS-MIN_WAVELENGTHS)
#define WAVELENGTH_RANGE (MAX_WAVELENGTH-MIN_WAVELENGTH)
#define WAVELENGTH_RANGE_TO_CHROMATICITY_RANGE (CHROMATICITY_RANGE/WAVELENGTH_RANGES)
#define FILM_TYPE_THICK_GLASS 0
#define FILM_TYPE_OILY_GLASS 1
#define FILM_TYPE_THICK_OIL 2
#define FILM_TYPE_HOLOGRAPHIC 3
#define TOTAL_FILM_TYPES 4
#define SHEEN_ROUGHNESS_MULTIPLIER HeightParamB
#define SHEEN_ALBEDO_TINT float3(0.3, 0.5, 0.7)
#define ADVANCED_SHEEN_ANISOTROPY 0.6
#define ADVANCED_SHEEN_POWER f5
#define CLEAR_COAT_THICKNESS 40
#define CLEAR_COAT_IOR 1.5
#define CLEAR_COAT_ROUGHNESS_MULTIPLIER 0.02
#define IRIDESCENCE_THICKNESS f9
#define IRIDESCENCE_IOR f10
#define LP_CASE(n, prop) case n: { output.rt1.xyz = lighting.##prop;}break;
#define LP_CASE2(n, prop) case n: output.rt1.xyz = lighting.##prop;break;
#define LP_CASE_MAG(n, prop) case n: {output.rt1.xyz = lighting.##prop##.real;}break;
#define ToFloat3(v) float3(v,v,v)
#define ToFloat3Bool(v) lerp(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),v)
#define CELL_W 64
#define CELL_H 56
#define MAP_TO_GRID_INDEX(uv, gridWidth, gridHeight) (int((uv.y * gridHeight)) * int(gridWidth) + int((uv.x * gridWidth)))
#define IS_IN_GRID_CELL(uv, cellX, cellY, gridWidth, gridHeight) ((uv.x >= cellX / gridWidth) && (uv.x < (cellX + 1) / gridWidth) && (uv.y >= cellY / gridHeight) && (uv.y < (cellY + 1) / gridHeight))
#define ct01 cosTime01(AnimateSpeed)
#define ct11 cosTime11(AnimateSpeed)
#define st01 sinTime01(AnimateSpeed)
#define st11 sinTime11(AnimateSpeed)
#define CONVERTUV(UVa,UVb,texA,texB) float2 convert##UVa##To##UVb(Texture2D<texA> sourceMap, float2 mapUV, Texture2D<texB> targetMap) { return mapUV * GetSz(sourceMap) / GetSz(targetMap); }
cbuffer ConstantBuffer : register(b0){
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
float Mix3;};
#define DepthScale vDepthScale
#define COHERENCE_LENGTH_M (f12 * 1e-6)
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
#define  samplerState sampleTypeMirror
SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);
SamplerState sampleTypeClamp : register(s2);
SamplerState sampleTypeCube : register(s3);
SamplerState sampleTypePoint : register(s4);
struct Complex3{
float3 real;
float3 imag;};
struct SellmeierCoefficientsBC{
float3 B;
float3 C;};
struct SellmeierCoefficientsOE{SellmeierCoefficientsBC O;SellmeierCoefficientsBC E;};
struct SellmeierCoefficients{SellmeierCoefficientsOE OE1;SellmeierCoefficientsOE OE2;SellmeierCoefficientsOE OE3;};
inline  float3 nmSqToUmSq(float3 nmSq){
return nmSq * 1e-6;}
struct MaterialProperties{SellmeierCoefficientsBC coeff;
float3 k;
float thicknessM;
float3 absorptionM;C3 wavelengthsNM;
float3 transmissionCoefficient;};
struct MaterialSellmeier{SellmeierCoefficients coeff;
float3 albedo;
float3 etaR;
float3 etaI;
float3 absorptionCoefficient;
float roughness;
float metallic;
float3 thicknessM;
float nSurrounding;
float coherenceLengthM;
float3 opticalAxis;
float3 dispersionCoefficientsNm2[3];};
struct AnisotropicRoughness{
float alphaX;
float alphaY;};
struct LightingComplex{
float Config_Saturation;
float Config_Gamma;
float Config_Exposure;
bool invertDepth;
bool useProjectedDepth;
float fDepthScale;
float coherenceLengthM;
float depth;
float3 pixelPos;
float3 lightPos;
float3 viewPos;
float3 normal;
float3x3 TBNf;
float3 viewDir;
float3 lightDir;
float3 halfDir;
float NdotV3;
float NdotL3;
float VdotH;
float HdotN;
float HdotL;
float LdotA;MaterialSellmeier material;
float3 albedo;
float3 albedoWavelengthsNM;
float3 albedoWavelengthsM;
float3 iridescenceO;
float3 iridescenceE;
float3 opticalAxis;
float3 nSurrounding;
float3 eta_ratio;
float3 k_ratio;
float3 cosTheta;C3 F_complex;
float3 dispersionFactor;
float3 n_o;C3 cosThetaOptic;
float3 n_e_effective;
float3 etaR_wavelength;
float3 etaI_wavelength;C3 cosThetaTR0;C3 R0;C3 cosThetaTR1;C3 R1;C3 qwave;C3 phaseShift_o;C3 phaseShift_e;C3 phaseShift;C3 D_complex;C3 G_complex;C3 spec_complex;
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
float3 F0;C3 refPol;C3 compositeSpecular;C3 specularContribution;C3 reflectance;C3 filmReflectedPolarization;C3 transmittance;C3 transmittanceCoherence;C3 diffuseReflectance;C3 diffuseTransmittance;C3 eeDiffuse;C3 eeSpecular;C3 eeInterference;
float3 ggxDistribution;
float3 cookTorrenceSpecular;C3 waveInterference;
float3 totalLighting[3];};
inline  float2 GetSz(Texture2D<float> tex){
float2 sz;tex.GetDimensions(sz.x, sz.y);
return sz;}
inline  float2 GetSz(Texture2D<float3> tex){
float2 sz;tex.GetDimensions(sz.x, sz.y);
return sz;}
inline  float2 GetOosz(Texture2D<float4> tex){
float2 sz;tex.GetDimensions(sz.x, sz.y);
return 1.0 / sz;}
inline  float2 GetOosz(Texture2D<float3> tex){
float2 sz;tex.GetDimensions(sz.x, sz.y);
return 1.0 / sz;}
inline  float2 GetOosz(Texture2D<float> tex){
float2 sz;tex.GetDimensions(sz.x, sz.y);
return 1.0 / sz;}
float3 noise3(Texture2D<float3> noiseMap,
float3 n,
float scalarUV = 1,
float scalarZ = 1){
float2 sz = GetSz(noiseMap);
float2 sampleCoord1 = (n.xy * scalarUV + n.z * scalarZ) * sz;
float2 sampleCoord2 = (n.xy * scalarUV + n.z * scalarZ * scalarZ) * sz;
float2 sampleCoord3 = (n.xy * scalarUV + n.z * scalarZ * scalarZ * scalarZ) * sz;
float3 v = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord1, 0).xyz, EPSILON3, OneMinusEPSILON3);
float3 v2 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord2, 0).xyz, EPSILON3, OneMinusEPSILON3);
float3 v3 = clamp(noiseMap.SampleLevel(sampleTypeMirror, sampleCoord3, 0).xyz, EPSILON3, OneMinusEPSILON3);
return ((v + v2 + v3) / 3.0 * TWO3 - ONE3);}
inline  float cosTime01(float timeMul){
return clamp((1.0 + cos(fmod(TotalTime * timeMul, TWOPI))) * 0.5, EPSILON, OneMinusEPSILON);}
inline  float sinTime01(float timeMul){
return clamp((1.0 + sin(fmod(TotalTime * timeMul, TWOPI))) * 0.5, EPSILON, OneMinusEPSILON);}
inline  float cosTime11(float timeMul){
return clamp(cosTime01(timeMul) * 2.0 - 1.0, -OneMinusEPSILON, OneMinusEPSILON);}
inline  float sinTime11(float timeMul){
return clamp(sinTime01(timeMul) * 2.0 - 1.0, -OneMinusEPSILON, OneMinusEPSILON);}
inline  float3 noise3_01i1(int2 uv){
return clamp(noiseMap1.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);}
inline  float3 noise3_01i2(int2 uv){
return clamp(noiseMap2.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);}
inline  float3 noise3_01i3(int2 uv){
return clamp(noiseMap3.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);}
inline  float3 noise3_01i4(int2 uv){
return clamp(noiseMap4.Load(int3(uv, 0)), EPSILON3, OneMinusEPSILON3);}
inline  float3 noise2D(Texture2D<float3> noiseMap, float2 uv, float z = 0){
return noise3(noiseMap, float3(uv, z)).xyz;}
inline  float3 safeNormalize(float3 v){
return normalize(v + EPSILON3);}
inline C3 ComplexCreate(float3 r, float3 i){C3 c;c.real = r;c.imag = i;
return c;}C3 ComplexMagnitudeSquared(C3 a){
return CV0(a.real * a.real + a.imag * a.imag);}
inline C3 ComplexMax(C3 a, C3 b){
return CV(max(a.real, b.real), max(a.imag, b.imag));}
inline C3 ComplexMin(C3 a, C3 b){
return CV(min(a.real, b.real), min(a.imag, b.imag));}
inline C3 ComplexDot(C3 a, C3 b){
float3 realPart = dot(a.real, b.real) + dot(a.imag, b.imag);
float3 imagPart = dot(a.real, b.imag) - dot(a.imag, b.real);
return CV(realPart, imagPart);}
inline C3 ComplexAdd(C3 a, C3 b){
return CV(a.real + b.real, a.imag + b.imag);}
inline C3 ComplexSub(C3 a, C3 b){
return CV(a.real - b.real, a.imag - b.imag);}
inline C3 ComplexMul(C3 a, C3 b){
return CV(a.real * b.real - a.imag * b.imag, a.real * b.imag + a.imag * b.real);}
inline C3 ComplexDiv(C3 a, C3 b){
float3 denom = max(abs(b.real * b.real + b.imag * b.imag), EPSILON3);
return CV((a.real * b.real + a.imag * b.imag) / denom, (a.imag * b.real - a.real * b.imag) / denom);}
inline  float3 ComplexMagnitude(C3 c){
return sqrt(c.real * c.real + c.imag * c.imag);}
inline C3 ComplexSaturatef(float3 c){
return CV0(saturate(c));}
inline C3 ComplexSaturate(C3 c){
return CV(saturate(c.real), saturate(c.imag));}
inline C3 ComplexNormalize(C3 v){C3 mag = CV0(CMag(v)+EPSILON3);
return CDiv(v, mag);}
inline C3 CSqrt(C3 z){
float3 magnitude = CMag(z);
float3 realPart = sqrt(0.5 * (magnitude + z.real));
float3 imagPart = sign(z.imag) * sqrt(0.5 * (magnitude - z.real));
return CV(realPart, imagPart);}
inline C3 CSin(C3 c){
return CV(sin(c.real) * cosh(c.imag), cos(c.real) * sinh(c.imag));}
inline C3 CCos(C3 c){
return CV(cos(c.real) * cosh(c.imag), -sin(c.real) * sinh(c.imag));}
inline C3 CAbs(C3 a){
return CV(abs(a.real), abs(a.imag));}
inline  float3 FresnelTerm(float3 F0, float3 cosTheta){
return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);}
inline  float3 SchlickGGXGeometry(float3 cosTheta, float k){
return cosTheta / (cosTheta * (1.0 - k) + k);}
inline  float3 GGXDistribution(float alpha, float3 cosTheta){
float3 alpha2 = alpha * alpha;
float3 denom = cosTheta * cosTheta * (alpha2 - 1.0) + 1.0;
return alpha2 / (PI * denom * denom);}
inline  float3 HSVtoRGB(float3 hsv){
float H = hsv.x;
float S = saturate(hsv.y);
float V = saturate(hsv.z);
float C = V * S;
float H_prime = fmod(H, 360.0f) / 60.0f;
float X = C * (1.0f - abs(fmod(H_prime, 2.0f) - 1.0f));
float3 rgb;
if (0.0f <= H_prime && H_prime < 1.0f)rgb = float3(C, X, 0.0f);
else  if (1.0f <= H_prime && H_prime < 2.0f)rgb = float3(X, C, 0.0f);
else  if (2.0f <= H_prime && H_prime < 3.0f)rgb = float3(0.0f, C, X);
else  if (3.0f <= H_prime && H_prime < 4.0f)rgb = float3(0.0f, X, C);
else  if (4.0f <= H_prime && H_prime < 5.0f)rgb = float3(X, 0.0f, C);
else
rgb = float3(C, 0.0f, X);
float m = V - C;
return rgb + m;}
inline  float4 HSVtoRGB(float4 hsv){
float3 rgb = HSVtoRGB(hsv.rgb);
return  float4(rgb, hsv.a);}
float3 RGBToWavelengthsNM(float3 rgb){
return  float3(lerp(620.0, 750.0, rgb.r),lerp(495.0, 570.0, rgb.g),lerp(450.0, 495.0, rgb.b));}
float3 RGBToWavelengthsM(float3 rgb){
return RGBToWavelengthsNM(rgb) * 1e-9;}
inline  float3 dot3(float3 a, float3 b){
float dt = dot(a, b);
return ONE3 * dt;}
inline C3 dot3(C3 a){
return CV(dot3(a.real, a.real), dot3(a.imag, a.imag));}
inline  float3 RGBToLuminance(float3 color){
return dot3(color, float3(0.299, 0.587, 0.114));}
inline  float3 RGBToBrightness(float3 color){
return dot3(color, float3(0.2126, 0.7152, 0.0722));}
inline  float3 RGBtoHSV(float3 rgb){
float R = rgb.r;
float G = rgb.g;
float B = rgb.b;
float maxC = max(R, max(G, B));
float minC = min(R, min(G, B));
float delta = maxC - minC;
float S = lerp(0, (delta / maxC), step(EPSILON, maxC));
float V = maxC;
float isRMax = step(max(G, B), R);
float isGMax = step(max(R, B), G);
float isBMax = 1.0f - isRMax - isGMax;
float GB = (G - B) / delta;
float BR = (B - R) / delta;
float RG = (R - G) / delta;
float hueR = 60.0f * fmod(GB, 6.0f);
float hueG = 60.0f * (BR + 2.0f);
float hueB = 60.0f * (RG + 4.0f);
float H = (isRMax * hueR) + (isGMax * hueG) + (isBMax * hueB);
float H_positive = H + step(H, 0.0f) * 360.0f;H_positive = lerp(0.0f, H_positive, step(EPSILON, delta));
return  float3(H_positive, S, V);}
inline  float4 RGBtoHSV(float4 rgb){
float3 hsv = RGBtoHSV(rgb.rgb);
return  float4(hsv, rgb.a);}
inline  float3 rotateHue(float3 colorRGB, float angle){
float4 hsv = float4(RGBtoHSV(colorRGB), 1.0);hsv.x = fmod(hsv.x + angle, 360.0f);
return saturate(HSVtoRGB(hsv).rgb);}
inline  float3 rotateHue(float3 colorRGB, float3 angle){
float4 hsv0 = float4(RGBtoHSV(colorRGB), 1.0);
float4 hsvR = hsv0;hsvR.x = fmod(hsvR.x + angle.x, 360.0f);
float3 r = saturate(HSVtoRGB(hsvR).rgb);
float4 hsvG = hsv0;hsvG.x = fmod(hsvG.x + angle.y, 360.0f);
float3 g = saturate(HSVtoRGB(hsvG).rgb);
float4 hsvB = hsv0;hsvB.x = fmod(hsvB.x + angle.z, 360.0f);
float3 b = saturate(HSVtoRGB(hsvB).rgb);
return  float3(r.r, g.g, b.b);}
inline  float4 rotateHue(float4 colorRGB, float angle){
float4 hsv = float4(RGBtoHSV(colorRGB.xyz), 1.0);hsv.x = fmod(hsv.x + angle, 360.0f);
return saturate(float4(HSVtoRGB(hsv).xyz, colorRGB.a));}C3 SnellsLaw(C3 eta1, C3 eta2, C3 sinThetaI){
return CDiv(CMul(eta1, sinThetaI), eta2);}
inline C3 FresnelReflectanceS(C3 eta1, C3 eta2, C3 cosThetaI, C3 cosThetaT){C3 numerator = CSub(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT));C3 denominator = CAdd(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT));C3 ratio = CDiv(numerator, denominator);
return CMul(ratio, ratio);}
inline C3 FresnelReflectanceP(C3 eta1, C3 eta2, C3 cosThetaI, C3 cosThetaT){C3 numerator = CSub(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI));C3 denominator = CAdd(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI));C3 ratio = CDiv(numerator, denominator);
return CMul(ratio, ratio);}
inline C3 CExp(C3 z){
float3 expReal = exp(z.real);
return CV(expReal * cos(z.imag), expReal * sin(z.imag));}
inline C3 ComplexConjugate(C3 z){
return CV(z.real, -z.imag);}
inline C3 ComplexLerp(C3 a, C3 b, C3 val){
return CV(lerp(a.real, b.real, val.real), lerp(a.imag, b.imag, val.imag));}C3 PhaseShift(MaterialSellmeier mat, float rawNdotL, C3 opd, C3 wavelengthsM, float3 coherenceLengthM, out C3 phaseShiftP){C3 phaseShiftReflect = ComplexLerp(CV(ONE3, ZERO3),CV(-ONE3, ZERO3),CVV(step(0, rawNdotL)));C3 phaseDiff =CDiv(CMul(CMul(C2PI,CMul(C20, opd)),CV0(coherenceLengthM)), wavelengthsM);C3 ret = ComplexLerp(phaseDiff, phaseShiftReflect,CSat(CSub(C10, CV0(rawNdotL))));C3 v = CMul(phaseShiftReflect, CV0(mat.coherenceLengthM));phaseShiftP = CMul(phaseDiff, v);
return ret;}
#define OneMinusEPSILON (1.0 - EPSILON)
static  const  float dx = 0.001;
static  const  float dy = 0.001;
inline  float safeNormalizeRange(float min, float max, float value){
return saturate((value - min) / (max - min));}
inline  float sigmoid(float x){
return 1.0 / (1.0 + exp(-x));}
inline  float smootherstep(float edge0, float edge1, float x){x = saturate((x - edge0) / (edge1 - edge0));
return x * x * x * (x * (x * 6 - 15) + 10);}
inline  float2 gradient(float2 range, float value){
float n = safeNormalizeRange(range.x, range.y, value);
return  float2(sigmoid(1.0 - n), sigmoid(n));}
inline  float2 gradient(float2 range, float2 value){
float nx = smootherstep(range.x, range.y, value.x);
float ny = safeNormalizeRange(range.x, range.y, value.y);
return  float2(sigmoid(1.0 - nx), sigmoid(ny));}
inline  float2 adjustDepthGradientSigmoid(float2 depthGradient, float2 nearFar){
float2 gx = gradient(nearFar, depthGradient.x);
float2 gy = gradient(nearFar, depthGradient.y);
return  float2(lerp(nearFar.x, nearFar.y, saturate(gx.x)), lerp(nearFar.x, nearFar.y, saturate(gy.x)));}
inline  float2 GetGradient(float2 uv){
float2 oosz = GetOosz(depthMap);
float grad1 = depthMap.SampleLevel(sampleTypeMirror, uv, 0);
float2 v1 = float2(ddx_fine(grad1), ddy_fine(grad1));
float grad2 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(oosz.x, -oosz.y), 0);
float2 v2 = float2(ddx_fine(grad2), 1 - ddy_fine(grad2));
return lerp(float3(v1.xy, 1 - grad1), float3(v2.xy, 1 - grad2), 0.5).xy;}
inline  float2 GetModulation(float2 depthGradient){
float2 nearFar = float2(EPSILON, OneMinusEPSILON);
return adjustDepthGradientSigmoid(depthGradient, nearFar);}
float SampleDepth(Texture2D<float> depthMap, float2 uv){
float depth = clamp(depthMap.Sample(sampleTypeLinear, uv), 0.001, 0.999);
if (!KeyQDown)depth = 1 - depth;
if (KeyWDown)depth *= DepthScale;
return (depth);}
float3x3 CalcTBN(float3 normal, float3 tangent){tangent = normalize(tangent - dot(tangent, normal) * normal);
float3 bitangent = normalize(cross(normal, tangent));
return  float3x3(tangent, bitangent, normal);}
float4 diffuse2D(Texture2D<float4> diffuseMap, float2 uv){
return diffuseMap.SampleLevel(sampleTypeLinear, uv, 0);}
struct PS_INPUT{
float4 Position : SV_Position;
float2 uv : UV0;
float3 ViewDir : UV1;
float4 Color : COLOR0;};
struct psout{
float4 rt1 : SV_Target0;
float4 rt2 : SV_Target1;
float4 rt3 : SV_Target2;
float4 rt4 : SV_Target3;
float4 rt5 : SV_Target4;
float4 rt6 : SV_Target5;
float4 rt7 : SV_Target6;
float4 rt8 : SV_Target7;};
static  float3 InputUV = ZERO3;
static  float3 PixelPos = ZERO3;
static  float3 ViewDir = ZERO3;
static  float3 HalfDir = ZERO3;
static  float3 LightDir = ZERO3;
static  float3 Normal = ZERO3;
static  float3x3 TBN;
float3 getNormal(Texture2D<float> depthMap, float2 uv, out  float3x3 tbn){
float2 texelSize = GetOosz(depthMap) * NormalRadius;
float depthRight = SampleDepth(depthMap, uv + float2(texelSize.x, 0.0));
float depthLeft = SampleDepth(depthMap, uv - float2(texelSize.x, 0.0));
float depthUp = SampleDepth(depthMap, uv + float2(0.0, texelSize.y));
float depthDown = SampleDepth(depthMap, uv - float2(0.0, texelSize.y));
float dX = (depthRight - depthLeft) * 0.5;
float dY = (depthUp - depthDown) * 0.5;
float3 tangent = normalize(float3(1.0, 0.0, -dX));
float3 bitangent = normalize(float3(0.0, 1.0, -dY));
float3 normal = normalize(cross(tangent, bitangent));tangent = normalize(tangent - normal * dot(normal, tangent));bitangent = normalize(cross(normal, tangent));tbn = float3x3(tangent, bitangent, normal);
return cross(tangent, bitangent);}
inline  void InitPSOut(out psout ret, float2 uv){ret = (psout) 0;
if (length(InputUV) < EPSILON){
float depth = SampleDepth(depthMap, uv);InputUV = float3(uv, depth);PixelPos = float3(uv.x, -uv.y, depth);ViewDir = normalize(EPSILON3 + ViewPos - PixelPos);LightDir = normalize(EPSILON3 + LightPos - PixelPos);HalfDir = normalize(EPSILON3 + LightDir + ViewDir);Normal = getNormal(depthMap, uv, TBN);}
float mask = step(0.1, PassNum);
float4 zeroVec = ZERO41;ret.rt1 = lerp(zeroVec, diffuse2D(rtMap1, uv), mask);ret.rt2 = lerp(zeroVec, diffuse2D(rtMap2, uv), mask);ret.rt3 = lerp(zeroVec, diffuse2D(rtMap3, uv), mask);ret.rt4 = lerp(zeroVec, diffuse2D(rtMap4, uv), mask);ret.rt5 = lerp(zeroVec, diffuse2D(rtMap5, uv), mask);ret.rt6 = lerp(zeroVec, diffuse2D(rtMap6, uv), mask);ret.rt7 = lerp(zeroVec, diffuse2D(rtMap7, uv), mask);ret.rt8 = lerp(zeroVec, diffuse2D(rtMap8, uv), mask);}
float3 sinc(float3 x){
return length(x) < EPSILON ? 1.0 : sin(x) / x;}
static  const  float c = 2.99792458e8;
float3 getNormal(Texture2D<float> depthMap, float2 uv){
float3x3 tbn;
return getNormal(depthMap, uv, tbn);}
float3 getNormal(Texture2D<float3> normalMap, float2 uv, out  float3x3 tbn){
const  float centerWeight = f7;
const  float sideWeight = f8;
const  float2 offset = GetOosz(normalMap) * NormalRadius;
float3 n1 = normalMap.Sample(linearSampler, uv).xyz * 2 - 1;
float3 n2 = normalMap.Sample(linearSampler, uv + float2(offset.x, 0)).xyz * 2 - 1;
float3 n3 = normalMap.Sample(linearSampler, uv - float2(offset.x, 0)).xyz * 2 - 1;
float3 n4 = normalMap.Sample(linearSampler, uv + float2(0, offset.y)).xyz * 2 - 1;
float3 n5 = normalMap.Sample(linearSampler, uv - float2(0, offset.y)).xyz * 2 - 1;
float3 smoothedNormal = centerWeight * n1 + sideWeight * ((n2 + n3 + n4 + n5) / 4) + EPSILON3;
float3 normal = safeNormalize(smoothedNormal);
float3 refAxis = abs(dot(normal, float3(0, -1, 0))) > 0.9 ? float3(1, 0, 0) : float3(0, -1, 0);
float3 tangent = safeNormalize(cross(refAxis, normal));tbn = CalcTBN(normal, tangent);
return mul(tbn, normal);}
float3 ProtrusionPS(Texture2D<float4> diffuseMap, Texture2D<float> depthMap, float2 inputUV, float flickerFreq, float time){
float3 baseColor = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb;
float depth = SampleDepth(depthMap, inputUV);
float dx = ddx(depth);
float dy = ddy(depth);
float depthGradMag = abs(dx) + abs(dy);
float depthVariance = (2 * PI * 2 * depth * 1e-9) / (saturate(depthGradMag * DepthScale * HeightScale) + sin(time));
float3 phaseOffset = depthVariance * float3(PhaseOffsetR, PhaseOffsetG, PhaseOffsetB);
float omega = 6.28318 * flickerFreq;
float globalFlicker = sin(time * omega);
float3 channelPhase = float3((2 * PI * 2 * depth) / TanhFactorR, TanhFactorG, (2 * PI * 2 * depth) / TanhFactorB);
float3 flicker = sin(time * omega + phaseOffset + channelPhase);flicker *= (2 * PI * 2 * (depthVariance) * DepthScale) / (1e-9 * 1000 * float3(f1, f2, f3));
float3 flicker01 = 0.5 * flicker + 0.5;
float3 intensityFactor = lerp(f4, f5, flicker01);
float2 ooszDiffuse = GetOosz(diffuseMap);
float2 offset = float2(f6, f7) * depthVariance * ooszDiffuse;
float2 redUV = inputUV + float2(-offset.x, 0);
float2 blueUV = inputUV + float2(offset.x, 0);
float2 greenUV = inputUV;
float redSample = diffuseMap.Sample(sampleTypeLinear, redUV).r;
float greenSample = diffuseMap.Sample(sampleTypeLinear, greenUV).g;
float blueSample = diffuseMap.Sample(sampleTypeLinear, blueUV).b;
float3 flickeredColor;flickeredColor.r = redSample * intensityFactor.r;flickeredColor.g = greenSample * intensityFactor.g;flickeredColor.b = blueSample * intensityFactor.b;
return flickeredColor;}LightingComplex CalculateLightingComplex(
Texture2D<float4> diffuseMap,
float2 inputUV,
float3 viewPos,
float3 lightPos,
bool invertDepth,
bool useProjectedDepth,
float depthScale,MaterialSellmeier mat,
float time,
float parallaxScale,
float normalRadius,
float sssStrength,
int dispersionIndex,
float gamma,
float exposure,
float saturation){LightingComplex lighting = (LightingComplex) 0;lighting.Config_Saturation = saturation;lighting.Config_Gamma = gamma;lighting.Config_Exposure = exposure;lighting.useProjectedDepth = useProjectedDepth;lighting.invertDepth = invertDepth;lighting.fDepthScale = depthScale;lighting.depth = SampleDepth(depthMap, inputUV);lighting.pixelPos = float3(float2(inputUV.x, -inputUV.y), lighting.depth);lighting.lightPos = lightPos;lighting.viewPos = viewPos;lighting.normal = getNormal(normalMap, inputUV, lighting.TBNf);lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);lighting.viewDir = safeNormalize(lighting.viewPos - lighting.pixelPos);lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));lighting.albedo = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb;lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);lighting.albedoWavelengthsM = lighting.albedoWavelengthsNM * 1e-9;lighting.material = mat;lighting.nSurrounding = mat.nSurrounding;C3 eta1 = CV(mat.etaR, mat.etaI);
float vB1 = mat.dispersionCoefficientsNm2[0].x;
float vC1 = mat.dispersionCoefficientsNm2[1].x;
float vB2 = mat.dispersionCoefficientsNm2[0].y;
float vC2 = mat.dispersionCoefficientsNm2[1].y;
float vB3 = mat.dispersionCoefficientsNm2[0].z;
float vC3 = mat.dispersionCoefficientsNm2[1].z;
float3 lambda = lighting.albedoWavelengthsNM;
float3 lambda2 = lambda * lambda;
float3 n2 =1.0 + vB1 * lambda2 / (lambda2 - vC1) +vB2 * lambda2 / (lambda2 - vC2) +vB3 * lambda2 / (lambda2 - vC3);mat.etaR = sqrt(max(1.0, n2));C3 eta2 = CV(mat.etaI, mat.etaR);C3 cosThetaI = CV(lighting.NdotL3, ZERO3);C3 sinThetaI = CSqrt(CSub(C11, CMul(cosThetaI, cosThetaI)));C3 sinThetaT = SnellsLaw(eta1, eta2, sinThetaI);C3 cosThetaT = CSqrt(CSub(C11, CMul(sinThetaT, sinThetaT)));
float2 sz;depthMap.GetDimensions(sz.x, sz.y);
float2 oosz = 1.0 / sz;
float3 light = ZERO3;
float3 diffuseColor = diffuse2D(diffuseMap, inputUV).xyz;
float3 objectPos = lighting.pixelPos + lighting.normal * sin((lighting.pixelPos - 0.5) + 2.0 * mat.coherenceLengthM + cos(time)) * .25;
float3 objectDir = safeNormalize(objectPos - lighting.pixelPos);
float objectDist = abs(length(objectPos - lighting.pixelPos));C3 coherenceFactor = CV((exp(-objectDist *mat.etaR/ mat.coherenceLengthM)), ZERO3);coherenceFactor.real = clamp(coherenceFactor.real, ZERO3, ONE3);
float refDist = length(lighting.viewPos - lighting.pixelPos);
float3 dispersionPhase = (2.0 * PI * 2.0 * mat.etaR * lighting.depth) / lighting.albedoWavelengthsM * coherenceFactor.real;C3 phi_object = CV0(dispersionPhase * f8);
float amplitude = max(0, dot(lighting.normal, lighting.lightDir));C3 E_object;E_object.real = CMul(CVV(amplitude), CCos(phi_object)).real;E_object.imag = CMul(CVV(amplitude), CSin(phi_object)).imag;E_object = CMul(E_object, coherenceFactor);
float3 refPhase = (2 * PI * 2.0 * refDist * mat.etaR) / (lighting.albedoWavelengthsM + SampleDepth(depthMap, inputUV) * mat.coherenceLengthM * .1 + .1);
float refAmplitude = objectDist * Mix2;
float3 magE_object = CMag(E_object);C3 coherenceFactor2 = CV(abs(exp(-refDist / mat.coherenceLengthM)), ZERO3);coherenceFactor2.real = clamp(coherenceFactor2.real, ZERO3, ONE3);C3 E_reference = CDiv(CExp(CV(cos(refPhase), sin(refPhase))), coherenceFactor2);C3 d = CV(max(mat.thicknessM, ZERO3), ZERO3);
float3 opd = max(2.0 * eta2.real * d.real * cosThetaT.real, ZERO3);C3 totalPhaseP;C3 totalPhaseS = PhaseShift(mat, dot(lighting.normal, lighting.lightDir), CV0(opd), CV0(lighting.albedoWavelengthsM), mat.coherenceLengthM, totalPhaseP);C3 totalPhaseP2;C3 totalPhaseS2 = PhaseShift(mat, dot(lighting.normal, lighting.lightDir), CV0(opd+totalPhaseS.real+time), CV0(lighting.albedoWavelengthsM), mat.coherenceLengthM, totalPhaseP2);totalPhaseP = ComplexLerp(totalPhaseP, totalPhaseP2, CVV(lighting.depth/DepthScale));totalPhaseS = ComplexLerp(totalPhaseS, totalPhaseS2, CVV(1-lighting.depth/DepthScale));C3 r_s12 = FresnelReflectanceS(eta1, eta2, cosThetaI, cosThetaT);C3 r_p12 = FresnelReflectanceP(eta1, eta2, cosThetaI, cosThetaT);C3 r_s23 = FresnelReflectanceS(eta2, eta1, cosThetaT, cosThetaI);C3 r_p23 = FresnelReflectanceP(eta2, eta1, cosThetaT, cosThetaI);r_s12.real = clamp(r_s12.real, ZERO3, ONE3);r_p12.real = clamp(r_p12.real, ZERO3, ONE3);r_s23.real = clamp(r_s23.real, ZERO3, ONE3);r_p23.real = clamp(r_p23.real, ZERO3, ONE3);C3 t_s12 = CSub(C11, r_s12);C3 t_p12 = CSub(C11, r_p12);C3 t_s21 = CSub(C11, r_s23);C3 t_p21 = CSub(C11, r_p23);t_s12.real = clamp(t_s12.real, ZERO3, ONE3);t_p12.real = clamp(t_p12.real, ZERO3, ONE3);t_s21.real = clamp(t_s21.real, ZERO3, ONE3);t_p21.real = clamp(t_p21.real, ZERO3, ONE3);C3 E_s_direct = r_s12;C3 E_p_direct = r_p12;C3 E_s_internal = CMul(CMul(t_s12, r_s23), t_s21);C3 E_p_internal = CMul(CMul(t_p12, r_p23), t_p21);
float3 magE_s_internal = CMag(E_s_internal);
float3 magE_p_internal = CMag(E_p_internal);C3 E_s_film = CAdd(E_s_direct, CMul(E_s_internal, CExp(totalPhaseS)));C3 E_p_film = CAdd(E_p_direct, CMul(E_p_internal, CExp(totalPhaseP)));
float3 magE_s_film = CMag(E_s_film);
float3 magE_p_film = CMag(E_p_film);C3 E_s_total = CAdd(CAdd(E_s_film, E_object), E_reference);C3 E_p_total = CAdd(CAdd(E_p_film, E_object), E_reference);C3 interferenceTerm = CAdd(CMul(E_s_total, ComplexConjugate(E_s_total)), CMul(E_p_total, ComplexConjugate(E_p_total)));
float3 magE_s_total = CMag(E_s_total);
float3 magE_p_total = CMag(E_p_total);
float3 intensity = saturate(dot(interferenceTerm.real, ONE3)) * 2.0 * lighting.albedo;interferenceTerm = CV0(intensity * saturate(lighting.NdotL3));C3 diffuse = CV0(magE_p_total * magE_p_total * lighting.NdotL3.xxx);
float alpha = mat.roughness * mat.roughness;
float D = 1.0 / (PI * alpha * alpha * pow(max(lighting.HdotN, EPSILON), SpecularPower));
float3 specularIntensity = abs(D * lighting.NdotL3 * SpecularIntensity * intensity);light = specularIntensity;
float3 exposed = lighting.albedo * 0.1 + lighting.albedo * light * exposure;
float3 gammaCorrected = pow(max(EPSILON3, exposed), max(EPSILON, 1.0 / gamma));SetDVf(totalLighting, gammaCorrected);
return lighting;
return lighting;}C3 COPD(C3 c, float2 uv, float2 pixelSize, float3 wavelengthsNM){wavelengthsNM = max(wavelengthsNM, EPSILON3);
return CV0(float3(2*PI*(c.real.x+uv.x)/pixelSize.x/wavelengthsNM.x+2*PI*(c.real.x+uv.y)/pixelSize.y/wavelengthsNM.x,2*PI*(c.real.y+uv.x)/pixelSize.x/wavelengthsNM.y+2*PI*(c.real.y+uv.y)/pixelSize.y/wavelengthsNM.y,2*PI*(c.real.z+uv.x)/pixelSize.x/wavelengthsNM.z+2*PI*(c.real.z+uv.y)/pixelSize.y/wavelengthsNM.z));}
float3 ComputeInterference(float3 wavelengthsNM, float depth, float2 uv, float time, float2 screenSize){
float2 pixelSize = 1.0 / screenSize;C3 wavelengths = CVV(wavelengthsNM);C3 opd = CV0(2.0 * depth);C3 phi_object = CDiv(CMul(C2PI, opd), wavelengths);C3 flickerFrequency = CV0(.1);C3 ctime = CVV(time);C3 cdepth = CVV(depth);C3 offset = C090180(fmod(time+float3(0.4,.1,.4), 1));C3 offset2 = CMod(CAdd(CPIo2, offset), PI/2);C3 phi_ref = COPD(offset, (float3((uv - .5), 1) * wavelengthsNM * 1e-24).xy + .5, pixelSize, wavelengthsNM);C3 phi_ref2 = COPD(offset2, (float3((uv - .5), 1) * wavelengthsNM * 1e-24).xy + .5, pixelSize, wavelengthsNM);C3 E_ref = CV(cos(phi_ref.real), sin(phi_ref.real));C3 E_ref2 = CV(cos(phi_ref2.real), sin(phi_ref2.real));E_ref = CAdd(E_ref, E_ref2);C3 amplitude = CCos(CV0(2*PI*2*depth+time));C3 E_object = CMul(amplitude, CCos(phi_object));C3 E_object_imag = CMul(amplitude, CSin(phi_object));C3 E_total = CAdd(E_object, E_ref);
return CMag(CMul(C10, E_total));}
float3 ComputeInterference2(float3 wavelengthsNM, float depth, float2 uv, float time, float2 screenSize){
float2 center = float2(0.5, 0.5);
float d = 1.0;
float3 distance = sqrt(pow(uv.x - center.x, 2) + pow(uv.y - center.y, 2) + pow(d, 2));C3 wavelengths = CV0(wavelengthsNM);C3 phi_ref = CDiv(CMul(C2PI, CV0(distance)), wavelengths);C3 opd = CV0(2.0 * depth);C3 phi_object = CDiv(CMul(C2PI, opd), wavelengths);
float flickerFrequency = f4;C3 timeTerm = (CDiv(CSin(CMul(CV0(time * flickerFrequency), CV0(f3))), C2PI));phi_object = CAdd(phi_object, timeTerm);C3 E_object = CMul(C10, CExp(CMul(C01, phi_object)));C3 E_ref_real = CCos(phi_ref);C3 E_ref_imag = CSin(phi_ref);C3 E_ref = CV(E_ref_real.real, E_ref_imag.real);C3 E_total = CAdd(E_object, E_ref);
float3 intensity = (E_total.imag * E_total.imag);
return (intensity);}LightingComplex CalculateLightingComplexInterference(
float3 diffuse,
float2 inputUV,
float3 viewPos,
float3 lightPos,
bool invertDepth,
bool useProjectedDepth,
float depthScale,MaterialSellmeier mat,
float time,
float parallaxScale,
float normalRadius,
float sssStrength,
int dispersionIndex,
float gamma,
float exposure,
float saturation){LightingComplex lighting = (LightingComplex) 0;lighting.Config_Saturation = saturation;lighting.Config_Gamma = gamma;lighting.Config_Exposure = exposure;lighting.useProjectedDepth = useProjectedDepth;lighting.invertDepth = invertDepth;lighting.fDepthScale = depthScale;lighting.depth = SampleDepth(depthMap, inputUV);lighting.pixelPos = float3(float2(inputUV.x, -inputUV.y), lighting.depth);lighting.lightPos = lightPos;lighting.viewPos = viewPos;lighting.normal = getNormal(normalMap, inputUV, lighting.TBNf);lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);lighting.viewDir = safeNormalize(viewPos - lighting.pixelPos);lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));lighting.albedo = float3(1, 1, 1);lighting.material = mat;
float2 screenSize;depthMap.GetDimensions(screenSize.x, screenSize.y);
float3 wavelengthsNM = RGBToWavelengthsNM(diffuse);
float3 intensity = ComputeInterference(wavelengthsNM, lighting.depth, inputUV, time, screenSize);
float3 intensity2 = ComputeInterference2(wavelengthsNM, lighting.depth, inputUV, time, screenSize);
float3 color = lighting.albedo * lighting.NdotL3 * intensity2;
float alpha = mat.roughness * mat.roughness;
float D = 1.0 / (PI * alpha * alpha * pow(max(lighting.HdotN, EPSILON), SpecularPower));
float3 specular = D * lighting.NdotL3 * SpecularIntensity;
float3 light = color + specular;
float3 exposed = light * exposure;
float3 gammaCorrected = pow(max(EPSILON3, exposed), max(EPSILON, 1.0 / gamma));SetDVf(totalLighting, gammaCorrected);lighting.totalLighting[0] = diffuse * gammaCorrected;
return lighting;}C3 ComputeInterference3(MaterialSellmeier mat, float3 pixelPos, float3 wavelengthsNM, float depth, float2 uv, float time){
float3 n = mat.etaR + mat.dispersionCoefficientsNm2[0] / (wavelengthsNM * wavelengthsNM);
float3 opdPhysical = 2.0 * n * depth * DepthScale * sin(time * f4 + depth);C3 opd = CV0(opdPhysical);
float3 k = 2 * PI / wavelengthsNM;C3 phi_base = CV0(k * opdPhysical + time / wavelengthsNM / SPEED_OF_LIGHT);
float flickerFrequency = max(f5, 0.1);C3 phi_flicker = C0V(sin(time * flickerFrequency + PhaseOffsetR) * 2 * PI);C3 phi_object = ComplexAdd(phi_base, phi_flicker);
float3 offsets = float3(PhaseOffsetR, PhaseOffsetG, PhaseOffsetB) * f6;
float3 r = pixelPos;C3 phi_ref_s = CV0(k * length(r + offsets));C3 phi_ref_p = CV0(k * length(r - offsets));C3 E_object = CExp(CMul(C01, phi_object));C3 E_ref_s = CV(cos(phi_ref_s.real), sin(phi_ref_s.real));C3 E_ref_p = CV(cos(phi_ref_p.real), sin(phi_ref_p.real));
float3 E_ref = CMag(CAdd(E_ref_s, E_ref_p));C3 E_total = CAdd(E_object, CV0(E_ref*.5));
float3 coherence = exp(-depth / max(mat.coherenceLengthM, EPSILON3));
float3 absorption = exp(-mat.absorptionCoefficient * depth);
float3 scale = coherence * absorption;E_total.real *= scale;E_total.imag *= scale;
return E_total;}LightingComplex CalculateLightingComplex3(
Texture2D<float4> diffuseMap, float2 inputUV, float3 pixelPos, float3 viewPos, float3 lightPos,
bool invertDepth, bool useProjectedDepth, float depthScale, MaterialSellmeier mat,
float time, float parallaxScale, float normalRadius, float sssStrength,
int dispersionIndex, float gamma, float exposure, float saturation){LightingComplex lighting = (LightingComplex) 0;
float depth = SampleDepth(depthMap, inputUV);lighting.Config_Saturation = saturation;lighting.Config_Gamma = max(gamma, EPSILON);lighting.Config_Exposure = exposure;lighting.useProjectedDepth = useProjectedDepth;lighting.invertDepth = invertDepth;lighting.fDepthScale = depthScale;lighting.depth = SampleDepth(depthMap, inputUV);lighting.pixelPos = pixelPos;lighting.lightPos = lightPos;lighting.viewPos = viewPos;lighting.normal = getNormal(normalMap, inputUV, lighting.TBNf);lighting.lightDir = safeNormalize(lighting.lightPos - lighting.pixelPos);lighting.viewDir = safeNormalize(viewPos - lighting.pixelPos);lighting.halfDir = safeNormalize(lighting.lightDir + lighting.viewDir);lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));lighting.NdotV3 = saturate(dot(lighting.normal, lighting.viewDir));lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));lighting.albedo = diffuseMap.Sample(sampleTypeLinear, inputUV).rgb;lighting.material = mat;lighting.totalLighting[0] = ZERO3;lighting.totalLighting[1] = ZERO3;lighting.totalLighting[2] = ZERO3;
float3 wavelengthsNM = RGBToWavelengthsNM(lighting.albedo);C3 interference = ComputeInterference3(mat, pixelPos, wavelengthsNM, lighting.depth, inputUV, time);
float3 intensity = ComplexMagnitude(interference);C3 eta1 = CVV(mat.nSurrounding);C3 eta2 = CV(mat.etaR, mat.etaI);C3 cosThetaI = CVV(lighting.NdotV3);C3 sinThetaI = CVV(sqrt(max(1.0 - cosThetaI.real * cosThetaI.real, EPSILON3)));C3 sinThetaT = CDiv(CMul(eta1, sinThetaI), eta2);C3 cosThetaT = CVV(sqrt(max(1.0 - sinThetaT.real * sinThetaT.real, EPSILON3)));C3 Rs = CDiv(CSub(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)),CAdd(CMul(eta1, cosThetaI), CMul(eta2, cosThetaT)));C3 Rp = CDiv(CSub(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI)),CAdd(CMul(eta1, cosThetaT), CMul(eta2, cosThetaI)));
float3 F = 0.5 * (CMag(Rs) * dot(normalize(viewPos - pixelPos), getNormal(depthMap, inputUV)) + CMag(Rp));
float alpha = mat.roughness * mat.roughness;
float3 T = lighting.TBNf[0];
float3 B = lighting.TBNf[1];
float alphaT = alpha * dot(lighting.halfDir, T);
float alphaB = alpha * dot(lighting.halfDir, B);
float D = alphaT * alphaB / (PI * pow(max(lighting.HdotN * lighting.HdotN * (alphaT * alphaB - 1.0) + 1.0, EPSILON), 2));
float k = alpha / 2.0;
float G_i = lighting.NdotL3 / max(lighting.NdotL3 * (1.0 - k) + k, EPSILON);
float G_o = lighting.NdotV3 / max(lighting.NdotV3 * (1.0 - k) + k, EPSILON);
float G = saturate(G_i * G_o);
float3 specular = (D * F * G) / (max(4.0 * lighting.NdotL3 * lighting.NdotV3, EPSILON));
float3 diffuse = (1.0 - mat.metallic) * lighting.albedo * lighting.NdotL3 * intensity / PI;
float3 sss = (sssStrength * exp(-depth / mat.thicknessM) * lighting.albedo);
float3 light = (diffuse) + (specular) + (sss);
float3 exposed = (light * exposure);
float3 gammaCorrected = pow(max(EPSILON3, exposed), 1.0 / lighting.Config_Gamma);lighting.totalLighting[0] = gammaCorrected;SetDVf(totalLighting, gammaCorrected);
return lighting;}psout PS222(PS_INPUT input){psout output;InitPSOut(output, input.uv);
float time = TotalTime * AnimateSpeed;MaterialSellmeier mat;mat.albedo = float3(1.0, 1.0, 1.0);mat.etaR = float3(1.5, 1.5, 1.5);mat.etaI = float3(0.01, 0.01, 0.01);mat.absorptionCoefficient = float3(0.1, 0.1, 0.1);mat.roughness = 0.3;mat.metallic = 0.5;mat.thicknessM = float3(2400, 1400, 2400) * 1e-9;mat.nSurrounding = 1.0;
float2 sz = GetSz(depthMap);mat.coherenceLengthM = COHERENCE_LENGTH_M;mat.opticalAxis = float3(0.0, 1.0, 0.0);mat.dispersionCoefficientsNm2[0] = ONE3 * 0.01;mat.dispersionCoefficientsNm2[1] = ONE3 * 0.01e+6;mat.dispersionCoefficientsNm2[2] = 0;
float3 viewPos = float3(ViewX, ViewY, ViewZ);
float3 lightPos = float3(SunX, SunY, SunZ);
float depth = SampleDepth(depthMap, input.uv);
float3 pixel = float3(input.uv.x, -input.uv.y, depth);
float3x3 tbn;
float3 normal = getNormal(normalMap, input.uv, tbn);
float3 viewDir = safeNormalize(viewPos - pixel);
float3 lightDir = safeNormalize(lightPos - pixel);
float3 diffuse = float3(diffuseMap.SampleLevel(sampleTypeLinear, input.uv - float2(0.001 * PhaseOffsetR, 0) * (1 - depth), 0).x,diffuseMap.SampleLevel(sampleTypeLinear, input.uv, 0).y,diffuseMap.SampleLevel(sampleTypeLinear, input.uv + float2(0.001 * PhaseOffsetB, 0) * (1 - depth), 0).z);
float exposure = 0;exposure = f9;LightingComplex lighting = CalculateLightingComplex3(diffuseMap,input.uv,pixel,viewPos,lightPos,!KeyQDown,KeyWDown,DepthScale,mat,time,0.1,NormalRadius,f6,0,Gamma,exposure,1.0);output.rt1.xyz = (max(0, dot(normal, viewDir)) * .5 + .5);
return output;}C3 ComputeHoloGratingDiffraction(MaterialSellmeier mat, float3 pixelPos, float3 wavelengthsNM, float2 uv, float time, float gratingDepth, float3 gratingNormal, float3 noise1){
const  float PhaseOffsetR = 0.0;
const  float PhaseOffsetG = 0.5;
float3 k = C2PI.real / wavelengthsNM;
float3 n = mat.etaR + mat.dispersionCoefficientsNm2[0] / (wavelengthsNM * wavelengthsNM);
float3 dynamicDepth = gratingDepth * (1.0 + 0.2 * sin(time * 2.0));C3 opd = CV0(2.0 * n * dynamicDepth * DepthScale * saturate(dot(gratingNormal, mat.opticalAxis)));
float3 gratingLines = gratingMap1.Sample(linearSampler, uv + float2(time * 0.05, 0)).rgb;C3 phi_grating = CMul(C2PI, CV0(gratingLines * 30.0 + time * 0.3 + 0.1 * sin(time * 5.0)));C3 phi_noise = C0V(noise1 * PI * time * 0.5);
float3 lightDist = length(pixelPos - LightPos);C3 phi_base = CV0(k * lightDist / SPEED_OF_LIGHT);C3 phi_total = CAdd(CAdd(phi_base, phi_grating), phi_noise);C3 E_object = CExp(CMul(C01, phi_total));C3 E_ref = CV(cos(phi_base.real + PhaseOffsetR + time), sin(phi_base.real + PhaseOffsetG + time));
float3 coherence = exp(-gratingDepth / max(mat.coherenceLengthM, EPSILON3));C3 E_total = CAdd(E_object, CMul(E_ref, CV0(coherence)));
float3 mag = CMag(E_total);E_total.real = E_total.real / max(mag, EPSILON3);E_total.imag = E_total.imag / max(mag, EPSILON3);
return E_total;}
static  const  float3 WAVELENGTHS = float3(700e-9, 550e-9, 450e-9);
static  const  float TWO_PI = 6.28318530718;
static  const  float SCREEN_WIDTH_M = .1;
static  const  float FRINGE_SCALE = 3088.0 / 20.0;Complex3 CalculateInterferenceComplex4(float2 pixelPos, float2 source1, float2 source2, float depth, float time){Complex3 result;result.real = float3(0.0, 0.0, 0.0);result.imag = float3(0.0, 0.0, 0.0);
float3 lambdaCoord = RGBToWavelengthsNM(diffuseMap.Sample(sampleTypeLinear, float2(pixelPos.x, -pixelPos.y)).xyz) * (SCREEN_WIDTH_M / FRINGE_SCALE);
float dist1 = length(pixelPos - source1) + depth * 0.1;
float dist2 = length(pixelPos - source2) + depth * 0.1;
float3 phase1 = TWO_PI * dist1 / lambdaCoord;
float3 phase2 = TWO_PI * dist2 / lambdaCoord;
float3 amp1Real = cos(phase1);
float3 amp1Imag = sin(phase1);
float3 amp2Real = cos(phase2);
float3 amp2Imag = sin(phase2);result.real = amp1Real + amp2Real;result.imag = amp1Imag + amp2Imag;
float shimmer = 0.1 * sin(time * 2.0);result.real += shimmer * result.real;result.imag += shimmer * result.imag;
return result;}
float Noise(float2 uv){
float n = frac(sin(dot(uv, float2(127.1, 311.7))) * 43758.5453);n += 0.5 * frac(sin(dot(uv * 2.0, float2(73.3, 241.9))) * 31415.9265);
return n;}Complex3 CalculateHologram(
float3 pixelWorldPos,
float3 lightPos,
float3 viewDir,
float3 diffuseRGB,
float depth,
float2 uv){Complex3 result;result.real = float3(0.0, 0.0, 0.0);result.imag = float3(0.0, 0.0, 0.0);
float3 lambdaNM = RGBToWavelengthsNM(diffuseRGB);
float3 lambdaM = lambdaNM * 1e-9;
float effectiveDepth = max(depth, 0.00001);
float depthFactor = saturate(effectiveDepth);
float3 coherenceLength = float3((depthFactor),(depthFactor),(depthFactor));
float3 k = TWO_PI / lambdaM;
float globalOscFreq = 0.5 * f2;
float globalOscAmp = 0.1 * f3;
float globalPhaseOffset = sin(AnimateTime * globalOscFreq * TWO_PI) * globalOscAmp;
float3 channelPhaseOffset = float3(0.0, 1.57, 3.14);
float3 refVec = lightPos - pixelWorldPos;
float distRef = abs(length(refVec));
float3 phaseRef = k * distRef;
float3 ampDampRef = exp(-distRef / coherenceLength);
float2 sz = GetSz(depthMap);
float oscillation = sin(pixelWorldPos.x * coherenceLength.x + AnimateTime);
float oscillation2 = cos(pixelWorldPos.y * coherenceLength.y + AnimateTime);
float3 oscillatoryOffset = float3(oscillation, oscillation2, depth * coherenceLength.z);
float3 objPos = pixelWorldPos + oscillatoryOffset;
float3 objVec = (objPos - pixelWorldPos);
float distObj = abs(length(objVec));
float3 phaseObj = k * distObj + globalPhaseOffset + channelPhaseOffset;viewDir = normalize(objPos - (pixelWorldPos + EPSILON3));
float viewAngle = dot(viewDir, normalize(objVec));phaseObj += k * viewAngle * 1.3;
float3 ampDampObj = exp(distObj / coherenceLength);
float3 n = float3(1.5, 1.5, 1.7);
float3 Rcoeff = pow((n - 1.0) / (n + 1.0), 2.0);
float3 ampRefReal = (Rcoeff) * ampDampRef * cos(phaseRef);
float3 ampRefImag = (Rcoeff) * ampDampRef * sin(phaseRef);
float3 ampObjReal = ampDampObj * cos(phaseObj);
float3 ampObjImag = ampDampObj * sin(phaseObj);result.real = (ampObjReal + ampRefReal);result.imag = (ampObjImag + ampRefImag);
return result;}
static  const  float3 wavelengths = float3(0.65, 0.55, 0.45);
float3 CalculateDepthCue(float2 uv, float depthSample, float3 coherenceFactor){
float3 depth = (1 - depthSample) * coherenceFactor;
float3 depthAttenuation = Mix2 - saturate(depth * Mix3);
return depth * depthAttenuation;}
float3 PhaseAlign(float2 uv, float t, float3 phaseShift, float3 oscillationAmplitude){
float3 phase = float3(sin(t + uv.x * 2.0 + phaseShift.x),sin(t + uv.y * 1.5 + phaseShift.y * 0.8),sin(t + uv.x * uv.y * 1.2 + phaseShift.z * 0.6));
return phase * oscillationAmplitude;}
float3 GenerateInterference(float2 uv, float t, float3 coherenceFactor, float3 wavelengths){
float3 interference = 0.0;[unroll(3)]
for (int i = 0; i < 3; i++){
float wave = sin((uv.x + uv.y) * wavelengths[i] * 10.0 + t);
float3 coherence = 1.0 / (1.0 + abs(float3(uv, vDepthScale) - 0.5) * coherenceFactor);interference[i] = wave * coherence[i];}
return interference;}psout PSn11(PS_INPUT input){psout output;InitPSOut(output, input.uv);
float2 uv = input.uv;
float depth = SampleDepth(depthMap, uv) / DepthScale;
float3 diffuseColor = diffuse2D(diffuseMap, uv).xyz;
float3 baseColor = diffuseColor;
float2 sz = GetSz(depthMap);
float3 pixelWorldPos = float3((uv.x - .5) * sz.x,(uv.y - .5) * sz.y, depth);
float3 viewDir = normalize(ViewPos - pixelWorldPos);
float3 lightDir[5];
float3 lightPos[5];lightPos[0] = LightPos;lightPos[1] = LightPos + float3(10, 0, ViewPos.z);lightPos[2] = LightPos + float3(-10, 0, ViewPos.z);lightPos[3] = LightPos + float3(-10, 10, ViewPos.z);lightPos[4] = LightPos + float3(10, 10, ViewPos.z);lightDir[0] = normalize(lightPos[0] - pixelWorldPos);lightDir[1] = normalize(lightPos[1] - pixelWorldPos);lightDir[2] = normalize(lightPos[2] - pixelWorldPos);lightDir[3] = normalize(lightPos[3] - pixelWorldPos);lightDir[4] = normalize(lightPos[4] - pixelWorldPos);
float3 len = float3(0, 0, 0);
for (int x = 0; x < 5; x++){
float3 wavelengthsMicroMeters = RGBToWavelengthsNM(diffuseColor) * 1e-3;
float3 coherenceFactor = float3(sz, 1);
float3 sceneColor = diffuse2D(diffuseMap, input.uv).xyz;
float depthSample = SampleDepth(depthMap, input.uv);
float3 screenPos = float3(input.uv * sz, depthSample);
float3 depthCue = CalculateDepthCue(input.uv.xy, screenPos.z, coherenceFactor);
float3 normal = getNormal(depthMap, input.uv);
float time = AnimateTime;
float3 phaseShift = time + depthSample * coherenceFactor;
float3 oscillationAmplitude = f2 * (depthSample * 1000 + cos(time));
float3 halfDir = normalize(lightDir[x] + viewDir);
float3 phase = PhaseAlign(input.uv, time, phaseShift, oscillationAmplitude);
float3 interference = GenerateInterference(input.uv, time, coherenceFactor, wavelengthsMicroMeters);
float3 oscillation = 2.0 * PI * 2.0 * depthCue + sin(time + (input.uv.x * sz.x)) * oscillationAmplitude;interference += oscillation * 0.0001;interference *= exp(-depthCue);
float3 effectColor = interference * float3(0.4, 0.6, 0.8);output.rt1.xyz += normalize(interference);len += length(normalize(effectColor));}
if (input.uv.x < .5){output.rt1.xyz /= len;}
else  if (input.uv.x < .70)output.rt1.xyz = getNormal(depthMap, input.uv) * .5 + .5;
else  if (input.uv.x < .85)output.rt1.xyz = (depth * .5 + .5);
else
output.rt1.xyz = diffuseColor;
float3 exposed = output.rt1.xyz * f9;output.rt1.xyz = pow(max(EPSILON3, exposed), max(EPSILON, 1.0 / Gamma));
return output;}
inline  float calc_distance(float3 viewerPos, float3 pointPos){
return length(viewerPos - pointPos);}C3 ComplexLog(C3 z){
float3 mag = ComplexMagnitude(z);
float3 angle = atan2(z.imag, z.real);
return CV(log(mag), angle);}C3 Complex3Asin(C3 z){C3 i_z = CMul(CV(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0)), z);C3 one = CV(float3(1.0, 1.0, 1.0), float3(0.0, 0.0, 0.0));C3 sqrtTerm = ComplexSqrt(ComplexSub(one, CMul(z, z)));C3 logArg = CAdd(i_z, sqrtTerm);C3 logVal = ComplexLog(logArg);
return CMul(CV(float3(0.0, 0.0, 0.0), float3(-1.0, -1.0, -1.0)), logVal);}C3 Complex3Acos(C3 z){C3 one = C10;C3 sqrtTerm = ComplexSqrt(ComplexSub(one, CMul(z, z)));C3 i_sqrt = CMul(CV(float3(0.0, 0.0, 0.0), float3(1.0, 1.0, 1.0)), sqrtTerm);C3 logVal = ComplexLog(CAdd(z, i_sqrt));
return CMul(CV(float3(0.0, 0.0, 0.0), float3(-1.0, -1.0, -1.0)), logVal);}C3 ComplexPow(C3 a, C3 b){C3 lnA = ComplexLog(a);C3 mul = CMul(b, lnA);
return CExp(mul);}
#define GAMMA_VALUE 2.2
inline C3 AdjustGamma(C3 color, float gammaValue = GAMMA_VALUE){
return CV(CPow(CMax(CEPSILON3, color), CDiv(C11, CMax(CEPSILON3,CVV(gammaValue)))).real, color.imag);}
inline  float3 AdjustGammaf(float3 color, float gammaValue = GAMMA_VALUE){
return AdjustGamma(CVV(pow(max(EPSILON3, color), ONE3/max(EPSILON3, gammaValue)))).real;}
inline C3 LinearRGBToSRGB(float3 linearRGB){
float3 srgb;linearRGB = clamp(linearRGB, EPSILON3, OneMinusEPSILON3);srgb.x = max(EPSILON, lerp((linearRGB.x * 12.92), (1.055 * pow(max(linearRGB.x, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.x, 0.0031309)));srgb.y = max(EPSILON, lerp((linearRGB.y * 12.92), (1.055 * pow(max(linearRGB.y, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.y, 0.0031309)));srgb.z = max(EPSILON, lerp((linearRGB.z * 12.92), (1.055 * pow(max(linearRGB.z, EPSILON), 1.0 / 2.4) - 0.055), step(linearRGB.z, 0.0031309)));
return CSat(AdjustGamma(CV0(srgb)));}
Texture2D<float4> getGratingMap(int index){index = int(uint(index) % uint(4));
if (index == 0)
return gratingMap1;
else  if (index == 1)
return gratingMap2;
else  if (index == 2)
return gratingMap3;
else
{
return gratingMap4;}}
Texture2D<float3> getGratingNormalMap(int index){index = fmod(index, 4);
if (index == 0)
return gratingNormal1;
else  if (index == 1)
return gratingNormal2;
else  if (index == 2)
return gratingNormal3;
else return gratingNormal4;}
Texture2D<float> getGratingDepthMap(int index){index = int(uint(index) % uint(4));
if (index == 0)
return gratingDepth1;
else  if (index == 1)
return gratingDepth2;
else  if (index == 2)
return gratingDepth3;
else
{
return gratingDepth4;}}
inline  float3 RGBToGrayscale(float3 color){
return dot3(color, float3(0.2989, 0.5870, 0.1140));}
inline  float3 LightSigmoid(float value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT){scalar = max(scalar, EPSILON);
float d = lerp(EPSILON, OneMinusEPSILON, (max(((value - 0.5) * speedOfLight) - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE) + 0.5) / scalar;
float v1 = (d - 0.5) * speedOfLight;
float v = max(v1 - MIN_WAVELENGTH, EPSILON) / WAVELENGTH_RANGE + 0.5;
float d2 = clamp(v, EPSILON, OneMinusEPSILON);
return sigmoid(length(lerp(min(d, d2), max(d, d2), saturate((OneMinusEPSILON - d2) * d))));}
inline  float3 LightSigmoid(float3 value, float scalar = 1.0, float speedOfLight = SPEED_OF_LIGHT){scalar = max(scalar, EPSILON);
float3 d = lerp(EPSILON3, OneMinusEPSILON3, ((max(((value - 0.5) * speedOfLight) - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES) + 0.5)) / max(scalar, EPSILON);
float3 v1 = (d - 0.5) * speedOfLight;
float3 v = max(v1 - MIN_WAVELENGTHS, EPSILON3) / WAVELENGTH_RANGES + 0.5;
float3 d2 = clamp(v, EPSILON3, OneMinusEPSILON3);
return sigmoid(length(lerp(min(d, d2), max(d, d2), saturate((OneMinusEPSILON3 - d2) * d))));}
inline  float depthSample(Texture2D<float> depthMap, float2 uv, float invertDepth = -1, float useProjectedDepth = -1){
float ret = depthMap.SampleLevel(sampleTypeMirror, uv, 0);ret = lerp(ret, 1.0 - ret, step(-.5, (uint(KeyQDown) |
uint(invertDepth))));ret = lerp(ret, DepthScale * ret, step(-.5, (uint(KeyWDown) ^ uint(useProjectedDepth))));
return ret;}
inline  float4 depthRaw4(Texture2D<float> depthMap, float2 uv, float radius = -1.0){
float2 oosz = GetOosz(depthMap);radius = NormalRadius;
float d1 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(-oosz.x * radius, 0.0), 0);
float d3 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(0.0, -oosz.y * radius), 0);
float d2 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(oosz.x * radius, 0.0), 0);
float d4 = depthMap.SampleLevel(sampleTypeMirror, uv + float2(0.0, oosz.y * radius), 0);
return clamp(0 + float4(d1, d2, d3, d4), EPSILON, 1.0 - EPSILON);}
inline  float4 depthRaw5(Texture2D<float> depthMap, float2 uv, out  float center, float radius = -1.0){center = clamp(0 + depthMap.SampleLevel(sampleTypeMirror, uv, 0), EPSILON, 1.0 - EPSILON);
return depthRaw4(depthMap, uv, radius);}
inline  float depth2D(Texture2D<float> depthMap, float2 uv, bool invertDepth = true, bool useProjectedDepth = false, float radius = -1.0){
float center;
float4 d = depthRaw5(depthMap, uv, center, radius);
float ret = lerp((d.x + d.y + d.z + d.w) * .25, center, 0.75);ret = lerp(ret, 1.0 - ret, step(0.5, invertDepth));ret = lerp(ret, DepthScale * ret, step(0.5, useProjectedDepth));
return ret;}
inline  float3 nmToUm(float3 nm){
return nm * 1e-3;}
inline C3 ComplexClamp(C3 a, float3 minVal, float3 maxVal){
return CV(clamp(a.real, minVal, maxVal), clamp(a.imag, minVal, maxVal));}
inline C3 ClampRefractiveIndex(C3 ri){
return ComplexClamp(ri, ONE3, ONE3 * 5.0);}
inline C3 RefractiveIndexFromSellmeier(C3 wavelengthsNM, bool isOrdinaryRay, MaterialSellmeier mat){wavelengthsNM = CMax(wavelengthsNM, CEPSILON3);
float3 lambdaUM = nmToUm(wavelengthsNM.real);
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
float3 term3 = (vB3 * lambdaSq) / denom3;C3 nSquared = CV0(1.0f + term1 + term2 + term3);nSquared = CMax(nSquared, CEPSILON3);C3 n = ComplexSqrt(nSquared);C3 inRange = CV0(step(1.0f, n.real) * step(n.real, 5.0f));n = ComplexLerp(CV0(mat.etaR), n, inRange);
return ClampRefractiveIndex(n);}
inline  float DistributionGGX(float NdotH, float roughness){roughness = clamp(roughness, EPSILON, 1.0);NdotH = clamp(NdotH, EPSILON, 1.0);
float alpha = roughness * roughness;
float alpha2 = alpha * alpha;
float denom = ((NdotH * NdotH) * (alpha2 - 1.0) + 1.0);denom = denom * denom;
return saturate(alpha2 / max(PI * denom, EPSILON));}C3 FresnelReflectanceFromFilm2(half3 n1, half3 n2, half3 cosThetaI, out C3 cosThetaT){C3 cI = CV0(clamp(cosThetaI, -ONE3h, ONE3h));C3 Cn1 = CVV(max(n1, ZERO3h));C3 Cn2 = CVV(max(n2, ZERO3h));C3 oneC = CVV(ONE3h);C3 cI2 = CMul(cI, cI);C3 diff = CSub(oneC, cI2);C3 sI = CSqrt(diff);C3 ratio = CDiv(Cn1, Cn2);C3 sT = CMul(ratio, sI);C3 sT_clamped = CMin(sT, CV0(ONE3h));cosThetaT = CSqrt(CMax(CSub(CV0(ONE3h), CMul(sT_clamped, sT_clamped)), CV0(ZERO3h)));C3 denomS = CMax(CAdd(CMul(Cn1, cI), CMul(Cn2, cosThetaT)), CV0(EPSILON3h));C3 denomP = CMax(CAdd(CMul(Cn1, cosThetaT), CMul(Cn2, cI)), CV0(EPSILON3h));C3 numS = CSub(CMul(Cn1, cI), CMul(Cn2, cosThetaT));C3 numP = CSub(CMul(Cn1, cosThetaT), CMul(Cn2, cI));C3 Rs = CDiv(numS, denomS);C3 Rp = CDiv(numP, denomP);C3 R_complex = CMul(CAdd(CPow(Rs, CV0(2)), CPow(Rp, CV0(2))), CV0(0.5));half3 tir = step(ONE3h, sT.real);C3 R = ComplexLerp(R_complex, CV0(ONE3h), CV0(tir));R = ComplexClamp(R, float3(ZERO3h), float3(ONE3h));
return R;}
inline  float3 Iridescence(
float2 uv,
float3 viewDir,
float3 normal,
float3 baseColor,
float thicknessM,MaterialSellmeier coeffs,
float3 iorMedium,
bool isOrdinary){
float time = AnimateTime;
float3 V = normalize(viewDir + EPSILON3);
float3 N = normalize(normal + EPSILON3);
float3 baseColorWavelengthsNM = RGBToWavelengthsNM(CMag(CV0(baseColor)));C3 ri = RefractiveIndexFromSellmeier(CV0(baseColorWavelengthsNM), isOrdinary, coeffs);
float3 iorFilm = CMag(ri);
float3 cI = saturate(dot3(N, V));
float3 sI = sqrt(max(ONE3 - cI * cI, EPSILON3));
float3 ratio = iorMedium / max(iorFilm, EPSILON3);
float3 sT = ratio * sI;
float3 TIRMask = step(0, sT);sT = min(sT, ONE3 - EPSILON3);
float3 cT = sqrt(ONE3 - sT * sT);
float3 OPD = TWO3 * iorFilm * thicknessM * cT;
float3 delta = (TWO3 * PI3 * OPD) / nmToM(baseColorWavelengthsNM);
float3 phaseShift0 = PI3 * step(iorFilm, iorMedium);
float3 phaseShift1 = PI3 * step(iorMedium, iorFilm);
float3 totalPhase = (delta + phaseShift0 + phaseShift1);C3 cosThetaTR0;C3 R0 = CV0(1 - FresnelReflectanceFromFilm2(iorMedium, iorFilm, cI, cosThetaTR0).real);C3 cosThetaTR1;C3 R1 = CV0(1 - FresnelReflectanceFromFilm2(iorFilm, iorMedium, cT, cosThetaTR1).real);
float3 interference = TWO3 * sqrt(R0.real * R1.real) * cos(totalPhase + cosThetaTR0.real + cosThetaTR1.real);
float3 reflectance = R0.real + R1.real + interference;reflectance = lerp(reflectance, R0.real, TIRMask);reflectance = saturate(reflectance);
float3 iridescentColor = baseColor * (reflectance);
return iridescentColor;}C3 FresnelComplex(float3 F0, float NdotH, float3 n_real, float3 n_imag, float FresnelPower){
float3 magnitude = sqrt(n_real * n_real + n_imag * n_imag);
float3 phase = atan2(n_imag, n_real);
float3 normPhase = (phase + 3.14159265) / (2.0 * 3.14159265);
float3 modulatedPower = FresnelPower * (0.75 + 0.5 * normPhase);
float3 amplitude = F0 + (1.0 - F0) * pow(1.0 - NdotH, modulatedPower);amplitude *= lerp(1.0, magnitude, 0.3);
float3 realPart = amplitude * cos(phase);
float3 imagPart = amplitude * sin(phase);
return CV(realPart, imagPart);}C3 ComplexScale(C3 c, float3 scale){
return CV(c.real * scale, c.imag * scale);}C3 FresnelComplex(float3 eta_ratio, float3 k_ratio, float3 cosTheta, float3 cosThetaT){C3 n = CV(eta_ratio, -k_ratio);C3 cT = CV(cosThetaT, ZERO3);C3 r_s = CDiv(ComplexSub(n, cT), CAdd(n, cT));C3 cTheta = CV(cosTheta, ZERO3);C3 r_p = CDiv(ComplexSub(CMul(cTheta, n), cT),CAdd(CMul(cTheta, n), cT));C3 F_complex = ComplexScale(CAdd(r_s, r_p), 0.5);
return F_complex;}
float3 CalculateRefractiveIndex(C3 wavelengthNM, const SellmeierCoefficients coeffs){
float3 wavelengthMicron = wavelengthNM.real * 1e-3;
float3 wavelengthSquared = wavelengthMicron * wavelengthMicron;
float3 term = coeffs.OE1.O.B * wavelengthSquared / (wavelengthSquared - coeffs.OE1.O.C);
float3 refractiveIndex = sqrt(1.0 + term);
return refractiveIndex;}
struct PathMeasurement{
float3 PathLengthM;
float3 PathTotalLengthM;
float3 PathDifferenceM;};
struct PhaseInterference{
float3 opticalPathDifference;
float3 phaseDifference;
float3 phaseShift;
float3 totalPhase;
float3 cosThetaT;};PhaseInterference CreatePhaseInterference(
float3 opticalPathDifference,
float3 phaseDifference,
float3 phaseShift,
float3 totalPhase,
float3 cosThetaT){PhaseInterference ret = (PhaseInterference) 0;ret.opticalPathDifference = opticalPathDifference;ret.phaseDifference = phaseDifference;ret.phaseShift = phaseShift;ret.totalPhase = totalPhase;ret.cosThetaT = cosThetaT;
return ret;}
inline PathMeasurement CreatePathMeasurement(float3 PathLengthM, float3 PathTotalLengthM, float3 PathDifferenceM){PathMeasurement ret;ret.PathLengthM = PathLengthM;ret.PathTotalLengthM = PathTotalLengthM;ret.PathDifferenceM = PathDifferenceM;
return ret;}
struct OpticalPathResult{C3 wavelengthsNM;
float3 refractiveIndex;PathMeasurement measurement;PathMeasurement opticalMeasurement;PhaseInterference phaseInterference;C3 intensityModulationM;
float3 absorptionEffect;};
inline OpticalPathResult CreateOpticalPathResult(C3 wavelengthsNM,
float3 refractiveIndex,PathMeasurement measurement,PathMeasurement opticalMeasurement,PhaseInterference phaseInterference,C3 intensityModulationM,
float3 absorptionEffect){OpticalPathResult ret;ret.wavelengthsNM = wavelengthsNM;ret.refractiveIndex = refractiveIndex;ret.measurement = measurement;ret.opticalMeasurement = opticalMeasurement;ret.phaseInterference = phaseInterference;ret.intensityModulationM = intensityModulationM;ret.absorptionEffect = absorptionEffect;
return ret;}
inline  float3 PhaseShiftM(float3 wavelengthsM, float3 distanceM, float3 refractiveIndex){
float3 w = max(wavelengthsM, EPSILON3);
float3 phaseShift = fmod((TWOPI3 * refractiveIndex * distanceM) / w, TWOPI3);
return fmod(phaseShift + TWOPI3, TWOPI3);}
inline  float3 PhaseShiftWithReflection(float3 wavelengthM, float3 distanceM, float3 nSurrounding, float3 nFilm){
float3 phaseShift = PhaseShiftM(wavelengthM, distanceM, nFilm);
float3 additionalPhase = PI3 * step(nSurrounding, nFilm);
return phaseShift + additionalPhase;}
inline PhaseInterference OpticalPhaseInterference(float3 wavelengthsM, float3 etaR, float3 nSurrounding, float3 thicknessM, float3 cosThetaT){
float3 w = max(wavelengthsM, EPSILON3);
float3 OPD = 2.0f * etaR * thicknessM * cosThetaT;
float3 phaseDifference = (TWOPI3 * OPD) / w;
float3 reflectionPhaseShift = PhaseShiftWithReflection(wavelengthsM, OPD, nSurrounding, etaR);
float3 totalPhase = phaseDifference + reflectionPhaseShift;
return CreatePhaseInterference(OPD, phaseDifference, reflectionPhaseShift, totalPhase, cosThetaT);}
inline C3 RefractiveIndexFromDispersionCoefficients(C3 wavelengthsNM, float3 dispersionCoeffsNm2){wavelengthsNM = CAdd(C00, wavelengthsNM);dispersionCoeffsNm2 = 0 + dispersionCoeffsNm2;C3 um = CV0(nmToUm(wavelengthsNM.real));C3 lambdaSq = CMul(um, um);C3 coeffUm = CV0(dispersionCoeffsNm2 * 1e-6);C3 nSq = CAdd(C10,CAdd(CDiv(CMul(lambdaSq,CMul(coeffUm, CV0(float3(1,0,0)))),CMax(CEPSILON3,CAbs(CSub(lambdaSq,CMul(coeffUm, CV0(float3(0,1,0))))))), CDiv(CMul(CMul(coeffUm, CV0(float3(0,0,1))),lambdaSq),CMax(CEPSILON3,CAbs(CSub(lambdaSq, CMul(coeffUm, CV0(float3(0,0,1)))))))));
return ClampRefractiveIndex(ComplexSqrt(nSq));}
inline OpticalPathResult OpticalPathDifference(C3 wavelengthsNM,
float3 nSurrounding,PathMeasurement measurement,
float3 dispersionCoeffs = ZERO3,
float3 absorptionCoeff = ZERO3,
float3 cosThetaT = ZERO3){C3 refractiveIndex = RefractiveIndexFromDispersionCoefficients(CV0(nmToM(wavelengthsNM.real)), (dispersionCoeffs));PathMeasurement opticalMeasurement =CreatePathMeasurement(abs(measurement.PathLengthM) * refractiveIndex.real,abs(measurement.PathTotalLengthM) * refractiveIndex.real,abs(measurement.PathDifferenceM) * refractiveIndex.real);C3 phaseDifferenceM = CDiv(CMax(CEPSILON3, CMul(C20, CV0(opticalMeasurement.PathLengthM))),CMax(CV0(nmToM(wavelengthsNM.real)), CEPSILON3));PhaseInterference pi = OpticalPhaseInterference(CAbs(CV0(nmToM(wavelengthsNM.real))).real, refractiveIndex.real, nSurrounding, opticalMeasurement.PathDifferenceM, cosThetaT);OpticalPathResult result = CreateOpticalPathResult(wavelengthsNM, refractiveIndex.real,measurement, opticalMeasurement, pi,ComplexCos(phaseDifferenceM),exp(-absorptionCoeff * opticalMeasurement.PathDifferenceM));
return result;}
inline C3 ComplexDistance(C3 a, C3 b){C3 result;result.real = ONE3 * distance(a.real, b.real);result.imag = ONE3 * distance(a.imag, b.imag);
return result;}
inline  float3 ComplexDistancef(C3 a, C3 b){
float3 diffReal = a.real - b.real;
float3 diffImag = a.imag - b.imag;
return sqrt(diffReal * diffReal + diffImag * diffImag);}
inline C3 DistanceMFromPointsNM(C3 point1NM, C3 point2NM){
return CV0(nmToM(ComplexDistance(point1NM, point2NM).real));}
inline C3 DistanceMFromPointsM(C3 point1M, C3 point2M){
return ComplexDistance(point1M, point2M);}
inline  float3 DistanceMFromPointsNMf(float3 point1NM, float3 point2NM){
return nmToM(distance(point1NM, point2NM));}
inline  float3 DistanceMFromPointsMf(float3 point1M, float3 point2M){
return distance(point1M, point2M);}
float ComplexLength(C3 a){
return length(sqrt(a.real * a.real + a.imag * a.imag));}
inline PathMeasurement DistanceMFromViewToAB(C3 viewPointNM, C3 pointA, C3 pointB){
float3 d =
float3(ComplexLength(DistanceMFromPointsNM(viewPointNM, pointA)),ComplexLength(DistanceMFromPointsNM(viewPointNM, pointB)),ComplexLength(DistanceMFromPointsNM(pointA, pointB)));
return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));}
inline PathMeasurement DistanceMFromViewToABf(float3 viewPointM, float3 point1M, float3 point2M){
float3 d = float3(length(DistanceMFromPointsMf(viewPointM, point1M)),length(DistanceMFromPointsMf(viewPointM, point2M)),length(DistanceMFromPointsMf(point1M, point2M)));
return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * abs(d.x - d.y));}
inline PathMeasurement DifferenceMPathFromPointThicknessM(C3 viewPosNM, C3 pixelPosNM, C3 thicknessM, float3 pixelNormal = ZERO3){C3 dir = CV0(safeNormalize(CSub(pixelPosNM, viewPosNM).real));C3 distanceFront = ComplexDistance(viewPosNM, pixelPosNM);C3 pixelBackNM = CAdd(pixelPosNM, CMul(dir, CV0(mToNm(thicknessM.real))));C3 distanceBack = ComplexDistance(viewPosNM, pixelBackNM);
float3 d =
float3(ComplexLength(DistanceMFromPointsNM(viewPosNM, pixelPosNM)),ComplexLength(DistanceMFromPointsNM(viewPosNM, pixelBackNM)),ComplexLength(DistanceMFromPointsNM(pixelPosNM, pixelBackNM)));
float3 pathDifferenceM = nmToM(abs(distanceBack.real - distanceFront.real));
return CreatePathMeasurement(ONE3 * min(d.x, d.y), ONE3 * (d.x + d.z), ONE3 * pathDifferenceM);}
inline  float3 CoherenceFactor(float3 opticalPathLength, float3 coherenceLength){
return exp(-pow(abs(opticalPathLength), TWO3) / max(pow(abs(coherenceLength), TWO3), EPSILON3));}
float3 ApplyReflectanceCoherence(float3 reflectance, OpticalPathResult opd, float coherenceLength){
return reflectance * CoherenceFactor(opd.phaseInterference.opticalPathDifference, coherenceLength);}
float3 ApplyTransmissionCoherence(float3 transmittance, OpticalPathResult opd, float3 coherenceLength){
return transmittance * CoherenceFactor(opd.phaseInterference.opticalPathDifference, coherenceLength);}C3 ComplexQuantumWave(C3 initialField, float2 uv, float time,
float potentialStrength, float waveNumber, float diffusion){
float hbar = 1.0545718e-34;
float m = 9.10938356e-31;
float k = waveNumber;
float omega = (k * k) / (2.0 * m);
float phase = -omega * time;
float cosP = cos(phase);
float sinP = sin(phase);
float3 rotatedReal = saturate(initialField.real) * cosP - saturate(initialField.imag) * sinP;
float3 rotatedImag = saturate(initialField.real) * sinP + saturate(initialField.imag) * cosP;
float diffusionFactor = exp(-diffusion * (uv.x * uv.x + uv.y * uv.y));C3 outField;outField.real = rotatedReal * diffusionFactor;outField.imag = rotatedImag * diffusionFactor;outField.real += float3(saturate(potentialStrength * cos(time)), 0.0, 0.0);
return outField;}C3 ComputeVolumetricWaveInterferencePhase(float3 wavelengthsNM, float2 uv, float time, float3x3 TBN, float depth, MaterialSellmeier mat, float parallaxScale, OpticalPathResult opr, float coherenceLengthM){
const  int numSteps = 16;
float3 wv = wavelengthsNM;C3 wave = CVV(wv);
float3 factor = exp(-(opr.phaseInterference.opticalPathDifference / max(EPSILON, coherenceLengthM)) * (opr.phaseInterference.opticalPathDifference / max(EPSILON, coherenceLengthM)));
float3 k = (6.2831853 * 2.0 * opr.phaseInterference.opticalPathDifference * mat.etaR * coherenceLengthM / max(EPSILON3, wavelengthsNM)) + opr.phaseInterference.totalPhase;
float3 stepSize = k * DepthScale / numSteps;
for (int i = 0; i < numSteps; i++){
float3 currentDepth = stepSize * float(i + 1) * 0.01;
float3 phaseR = sin(k * stepSize);
float3 phaseI = cos(k * stepSize);C3 phaseShift = CExp(CV(phaseR, phaseI));wave = CMul(wave, phaseShift);C3 attenuation = CExp(CMul(CV0(-mat.absorptionCoefficient), CV0(currentDepth)));wave = CMul(wave, attenuation);}
float3 noiseVal = wv * 0.1;
float3 oscillation = float3(sin((uv.x - 0.5) * noiseVal.x + 0.5 + time) * noiseVal.y,sin((uv.y - 0.5) * noiseVal.y + 0.5 + time) * noiseVal.z,cos((depth - 0.5) * noiseVal.z + 0.5 + time) * noiseVal.x) * parallaxScale;C3 displacement = CV0(mul(TBN, oscillation));wave = CAdd(wave, displacement);
return wave;}
inline C3 nmToHz(C3 nm){
return CDiv(CVV(2.99792458e8), CMax(CV0(nmToM(CAbs(nm).real)), CVVEPSILON3));}
inline C3 mToHz(C3 m){
return CDiv(CVV(2.99792458e8), m);}C3 ComplexThinFilmInterference(C3 baseField, float2 uv, float time,
float3 layerThicknesses, float3 refractiveIndices,
float3 absorptionCoefficients, C3 wavelengthNM){
float c = SPEED_OF_LIGHT;
float3 frequency = c / max(nmToHz(wavelengthNM).real, EPSILON);
float3 opticalPath = layerThicknesses * refractiveIndices;
float3 phaseShifts = (2.0 * PI / max(wavelengthNM.real, EPSILON)) * opticalPath;
float3 absorptionFactors = exp(-absorptionCoefficients * layerThicknesses);
float3 cosPhase = cos(phaseShifts);
float3 sinPhase = sin(phaseShifts);C3 outField = CV(baseField.real * cosPhase * absorptionFactors,baseField.imag * sinPhase * absorptionFactors);outField.real = outField.real * sin(uv.x * frequency + time * 2.0);outField.imag = outField.imag * cos(uv.y * frequency - time * 1.5);
return outField;}
float3 ComputeHolographicCaustics(LightingComplex lighting, float2 uv, float time, float parallaxScale){
float3 caustic = float3(0.0, 0.0, 0.0);
float totalWeight = 0.0;
float2 oosz = GetOosz(diffuseMap);
for (int ix = -1; ix <= 1; ix++){
for (int iy = -1; iy <= 1; iy++){
float2 offset = float2(ix, iy) * parallaxScale;
float2 sampleUV = uv + offset * oosz * cos(time) * 10;
float2 phase = (offset - 0.5) *.010 * cos(length(offset) + time);
float2 weight = sin(offset * phase);
float3 sampleIntensity = ((diffuse2D(diffuseMap, uv + depth2D(depthMap, uv)* oosz * 10 * offset * (1 - depth2D(depthMap, uv)* oosz * cos(time) * 10 * phase)).xyz)) * length(weight);caustic += sampleIntensity;totalWeight += length(weight);}}caustic /= max(totalWeight, 0.0001);
return caustic;}C3 ComplexFromMagnitudePhase(float magnitude, float3 phase){
return CV(magnitude * cos(phase), magnitude * sin(phase));}C3 MicrofacetDistribution_Complex(float3 N, float3 H, float alpha){
float NdotH = saturate(dot(N, H));
float denom = (NdotH * NdotH) * (alpha * alpha - 1.0) + 1.0;
float D = (alpha * alpha) / (PI * denom * denom);
float3 phi = noise2D(noiseMap1, H.xy * H.z * 10.0);phi = phi * TWO3 * PI3;
return ComplexFromMagnitudePhase(D, phi);}C3 GeometrySmith_Complex(float3 N, float3 V, float roughness){
float NdotV = saturate(dot(N, V));
float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
float G1 = NdotV / (NdotV * (1.0 - k) + k);
float3 psi = sin(V * 10.0);psi = psi * PI * 0.5;
return ComplexFromMagnitudePhase(G1, psi);}C3 GeometrySmith_ComplexCombined(float3 N, float3 V, float3 L, float roughness){C3 G_V = GeometrySmith_Complex(N, V, roughness);C3 G_L = GeometrySmith_Complex(N, L, roughness);
return CMul(G_V, G_L);}
float3 CalculateF0(float metallic, float3 dielectricReflectance, float3 metallicReflectance){
return lerp(dielectricReflectance, metallicReflectance, metallic);}
float3 FresnelSchlickRoughness(float3 F0, float3 NdotV, float roughness){F0 = lerp(F0, float3(1.0, 1.0, 1.0), roughness);
return F0 + (1.0 - F0) * pow(1.0 - NdotV, FresnelPower);}
inline  float SmithGGXCorrelated(float NdotL, float NdotV, float roughness){NdotL = saturate(NdotL);NdotV = saturate(NdotV);roughness = max(roughness, EPSILON);
float a2 = roughness * roughness;
float GGXV = NdotV * sqrt(max(NdotL * (NdotL * (1.0 - a2) + a2), EPSILON));
float GGXL = NdotL * sqrt(max(NdotV * (NdotV * (1.0 - a2) + a2), EPSILON));
return 2.0 * NdotL * NdotV / max(GGXV + GGXL, EPSILON);}
float GeometrySmithVLNf(float3 V, float3 L, float3 N, float roughness){N = safeNormalize(N);L = safeNormalize(L);V = safeNormalize(V);
if (length(N) < EPSILON || length(L) < EPSILON || length(V) < EPSILON){
return 0.0;}
float NdotL = max(dot(N, L), EPSILON);
float NdotV = max(dot(N, V), EPSILON);
return SmithGGXCorrelated(NdotL, NdotV, roughness);}
float GeometrySmithNVL(float3 N, float3 V, float3 L, AnisotropicRoughness roughness){
return GeometrySmithVLNf(V, L, N, roughness.alphaX);}
float GeometrySmithNVLf(float3 N, float3 V, float3 L, float roughness){
return GeometrySmithVLNf(V, L, N, roughness);}
float3 CookTorranceSpecularPBR2(
float3 normal,
float3 viewDir,
float3 lightDir,
float roughness,
float3 NdotV,
float3 F0){
float3 halfDir = safeNormalize(lightDir + viewDir);
float NdotH = saturate(dot(normal, halfDir));
float3 Fresnel = FresnelSchlickRoughness(F0, NdotH, roughness);
float NDF = DistributionGGX(saturate(dot(normal, halfDir)), roughness);
float G = GeometrySmithNVLf(normal, viewDir, lightDir, roughness);
float3 denominator = 4.0 * NdotV * saturate(dot(normal, lightDir)) + EPSILON;
return (NDF * G * Fresnel) / denominator;}
inline  float3 FresnelSchlick(float3 F0, float3 VdotH, float power){
return F0 + (ONE3 - F0) * pow(abs(VdotH), power);}
float3 CalculateBasicSheen(float3 normal, float3 lightDir, float3 viewDir, float roughness, float3 sheenAlbedoTint){
float3 halfDir = safeNormalize(lightDir + viewDir);
float NdotH = saturate(dot(normal, halfDir));
float LdotH = saturate(dot(lightDir, halfDir));
float sheenRoughness = roughness * SHEEN_ROUGHNESS_MULTIPLIER;
float sheenDistribution = DistributionGGX(NdotH, sheenRoughness);
float sheenFresnel = 0.04 + (1.0 - 0.04) * pow(1.0 - LdotH, 5.0);
return sheenAlbedoTint * sheenDistribution * sheenFresnel;}C3 FresnelComplex(C3 ior, float3 normal, float3 lightDir){
float cosThetaI = saturate(dot(normal, lightDir));C3 sinThetaT = CMul(ior, CV0(sqrt(1.0 - cosThetaI * cosThetaI)));C3 cosThetaT = ComplexSqrt(ComplexSub(C10, CMul(sinThetaT, sinThetaT)));C3 rParallel = CDiv(ComplexSub(CMul(ior, CV0(cosThetaI)), cosThetaT),CAdd(CMul(ior, CV0(cosThetaI)), cosThetaT));C3 rPerpendicular = CDiv(ComplexSub(CV0(cosThetaI), cosThetaT),CAdd(CV0(cosThetaI), cosThetaT));
return CMul(CV0(0.5 * ONE3), CAdd(CMul(rParallel, rParallel), CMul(rPerpendicular, rPerpendicular)));}
inline C3 CalculateFresnelReflectance(C3 eta, float3 normal, float3 lightDir, out C3 transmittance){C3 fresnelReflectance = FresnelComplex(eta, normal, lightDir);transmittance = CSub(C10, fresnelReflectance);
return AdjustGamma(CSat(fresnelReflectance), Gamma);}
float AnisotropicDistributionGGX(float NdotH, float dotHX, float dotHY, float roughnessLong, float roughnessShort){
float a2 = roughnessLong * roughnessShort;
float3 V = float3(roughnessShort * dotHX, roughnessLong * dotHY, a2 * NdotH);
float vDotH2 = saturate(dot(V, V));
float NdotH2 = NdotH * NdotH;
float chi = (NdotH > 0.0) ? 1.0 : 0.0;
return chi * a2 / (PI * vDotH2 * vDotH2);}
float3 CalculateAdvancedSheen(float3 normal, float3 lightDir, float3 viewDir, float3 tangent, float roughness, float3 sheenAlbedoTint){
float3 halfDir = safeNormalize(lightDir + viewDir);
float NdotH = saturate(dot(normal, halfDir));
float LdotH = saturate(dot(lightDir, halfDir));
float3 H = safeNormalize(halfDir);
float3 X = safeNormalize(tangent);
float3 Y = cross(normal, tangent);
float dotHX = saturate(dot(H, X));
float dotHY = saturate(dot(H, Y));
float aniso = ADVANCED_SHEEN_ANISOTROPY;
float roughnessLong = roughness * (1.0 + aniso);
float roughnessShort = roughness * (1.0 - aniso);
float D = AnisotropicDistributionGGX(NdotH, dotHX, dotHY, roughnessLong, roughnessShort);
float F = pow(1.0 - LdotH, ADVANCED_SHEEN_POWER);
return sheenAlbedoTint * D * F;}
float PhaseFactorDiffuse(){
return 0.9;}
float3 PhaseFactorInterference(float3 pathDifference, float3 coherenceLength){
float3 factor = exp(-(pathDifference / coherenceLength) * (pathDifference / coherenceLength));
return saturate(factor);}
float3 PhaseFactorSpecular(float roughness, float3 wavelengthsNM){
float3 factor = exp(-(6.2831853 * roughness / wavelengthsNM) * (6.2831853 * roughness / wavelengthsNM));
return saturate(factor);}
float3 PhaseFactorCaustics(float3 coherence, float exposureTime){
return saturate(coherence / (1.0 + exposureTime));}
float3 ClearCoatFresnel(float3 NdotV){
return 0.04 + (1.0 - 0.04) * pow(1.0 - NdotV, 5.0);}
inline  float3 CookTorranceSpecularPBR(
float3 normal,
float3 viewDir,
float3 lightDir,
float roughness,
float3 F0,
float metallic){normal = safeNormalize(normal);viewDir = safeNormalize(viewDir);lightDir = safeNormalize(lightDir);
float3 H = safeNormalize(viewDir + lightDir);
float NdotV = saturate(dot(normal, viewDir));
float NdotL = saturate(dot(normal, lightDir));
float NdotH = saturate(dot(normal, H));
float VdotH = saturate(dot(viewDir, H));NdotV = max(NdotV, EPSILON);NdotL = max(NdotL, EPSILON);
float alpha = roughness * roughness;
float alphaSq = alpha * alpha;
float denom = NdotH * NdotH * (alphaSq - 1.0) + 1.0;
float D = alphaSq / (PI * denom * denom);
float3 F = FresnelSchlick(F0, VdotH, metallic);
float k = (roughness + 1.0) * (roughness + 1.0) / 8.0;
float G_V = NdotV / (NdotV * (1.0 - k) + k);
float G_L = NdotL / (NdotL * (1.0 - k) + k);
float G = G_V * G_L;
float3 specularBRDF = (D * F * G) / (4.0 * NdotV * NdotL + EPSILON);
return saturate(specularBRDF);}AnisotropicRoughness CreateAnisotropicRoughness(float alphaX, float alphaY){AnisotropicRoughness ret = (AnisotropicRoughness) 0;ret.alphaX = alphaX;ret.alphaY = alphaY;
return ret;}C3 FresnelReflectanceFromComplex(C3 cosThetaI, C3 eta){C3 sinThetaI = CSqrt(CMax(C00, CSub(C11, CMul(cosThetaI, cosThetaI))));C3 sinThetaT = CDiv(CV(sinThetaI.real, cosThetaI.real), eta);C3 cosThetaT = ComplexSqrt(CSub(C10, CMul(sinThetaT, sinThetaT)));C3 rs = CDiv(CSub(CMul(eta, CV(cosThetaI.real, sinThetaT.imag)), cosThetaT),CAdd(CMul(eta, CV(cosThetaI.real, sinThetaT.imag)), cosThetaT));C3 rp = CDiv(CSub(CMul(eta, cosThetaT), CV(cosThetaI.real, sinThetaT.imag)),CAdd(CMul(eta, cosThetaT), CV(cosThetaI.real, sinThetaT.imag)));C3 Rs = CSat(CMul(CAbs(rs), CAbs(rs)));C3 Rp = CSat(CMul(CAbs(rp), CAbs(rp)));C3 R = CSat(ComplexLerp(Rs, Rp, cosThetaI));
return CV(saturate(R.real), saturate(R.imag));}
float3 Specular(float3 N, float3 V, float3 L, MaterialSellmeier mat){
float3 H = safeNormalize(V + L);
float NDF = DistributionGGX(max(0, dot(N, H)), mat.roughness);
float3 G = GeometrySmithNVL(N, V, L, CreateAnisotropicRoughness(mat.roughness, mat.roughness));
float3 NdotV = max(0, dot3(N, V));C3 reflectance = FresnelReflectanceFromComplex(CV0(NdotV), CV(mat.etaR, mat.etaI));
float3 FresnelR = clamp(CAbs(reflectance).real, ZERO3, ONE3);
float3 specular = (saturate(NDF * G * FresnelR) / max(EPSILON3, (SpecularPower * NdotV))) * SpecularIntensity;
return specular;}MaterialProperties MaterialPropertiesFromMaterialSellmeier(MaterialSellmeier mat){MaterialProperties material = (MaterialProperties) 0;material.coeff.B = mat.coeff.OE1.O.B;material.coeff.B = mat.coeff.OE1.O.C;material.k = mat.nSurrounding;material.thicknessM = length(mat.thicknessM);material.absorptionM = mat.absorptionCoefficient;material.wavelengthsNM = CV0(RGBToWavelengthsNM(mat.albedo));material.transmissionCoefficient = mat.metallic;
return material;}
struct ThinFilmProperties{C3 filmThicknessM;SellmeierCoefficients filmEta_coeffs;};SellmeierCoefficientsBC CreateSellmeierCoefficientsBC(
float3 B,
float3 C){SellmeierCoefficientsBC ret = (SellmeierCoefficientsBC) 0;ret.B = B;ret.C = C;
return ret;}SellmeierCoefficientsOE CreateSellmeierCoefficientsOE(SellmeierCoefficientsBC O,SellmeierCoefficientsBC E){SellmeierCoefficientsOE ret = (SellmeierCoefficientsOE) 0;ret.O = O;ret.E = E;
return ret;}SellmeierCoefficients CreateSellmeierCoefficients(SellmeierCoefficientsOE OE1,SellmeierCoefficientsOE OE2,SellmeierCoefficientsOE OE3){SellmeierCoefficients ret = (SellmeierCoefficients) 0;ret.OE1 = OE1;ret.OE2 = OE2;ret.OE3 = OE3;
return ret;}ThinFilmProperties CreateThinFilmProperties(C3 filmThicknessM, SellmeierCoefficients filmEta_coeffs){ThinFilmProperties ret = (ThinFilmProperties) 0;ret.filmThicknessM = filmThicknessM;ret.filmEta_coeffs = filmEta_coeffs;ret.filmEta_coeffs.OE1 = filmEta_coeffs.OE1;ret.filmEta_coeffs.OE2 = filmEta_coeffs.OE2;ret.filmEta_coeffs.OE3 = filmEta_coeffs.OE3;
return ret;}
#define SELLMEIER_COEFFICIENTS(ior,c) CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c)),CreateSellmeierCoefficientsBC(float3(ior,ior,ior),float3(c,c,c))))
#define SELLMEIER_THIN_FILM_PROPERTY(ior,thicknessM,c) CreateThinFilmProperties(thicknessM,SELLMEIER_COEFFICIENTS(ior,c));
void CreateThinFilms(inout ThinFilmProperties thinFilms[MAX_GRATING_LAYERS]){thinFilms[0] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);thinFilms[1] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0(0.0012), 0.01);thinFilms[2] = SELLMEIER_THIN_FILM_PROPERTY(1.75, CV0(0.0102), 0.03);thinFilms[3] = SELLMEIER_THIN_FILM_PROPERTY(2.5, CV0(0.0006), 0.001);thinFilms[4] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);thinFilms[5] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0(0.0012), 0.001);thinFilms[6] = SELLMEIER_THIN_FILM_PROPERTY(1.75, CV0(0.0102), 0.03);thinFilms[7] = SELLMEIER_THIN_FILM_PROPERTY(2.5, CV0(0.0006), 0.001);thinFilms[8] = SELLMEIER_THIN_FILM_PROPERTY(1.5, CV0(0.0002), 0.012);thinFilms[9] = SELLMEIER_THIN_FILM_PROPERTY(1.25, CV0(0.0012), 0.001);}C3 PhaseDifference(C3 wavelengthM, C3 thicknessM, float3 eta, float3 cosTheta){
return CDiv(CMul(CMul(CV0(TWO3 * PI3), thicknessM), CV0(eta * cosTheta)), wavelengthM);}C3 InterferenceThinFilmComplex(float2 inputUV, float time, float3 wavelengthsM, float3 thicknessM, float3 eta, float3 cosTheta, float3 nSurrounding){
float3 R = (eta - nSurrounding) / (eta + nSurrounding);
float3 phaseDiff = PhaseDifference(CV0(wavelengthsM), CV0(thicknessM), eta, cosTheta).real;
float3 amplitude = sqrt(R * R + (1.0 - R) * (1.0 - R) + 2.0 * R * (1.0 - R) * cos(phaseDiff));
float3 phase = atan2(-R * sin(phaseDiff), 1.0 - R * cos(phaseDiff));
return CV(amplitude * cos(phase), amplitude * sin(phase));}
inline C3 SpecularTransmission(
float2 inputUV,
float time,
float3 eta_ratio,
float3 k_ratio,
float3 cosThetaT,C3 wavelengthsNM,
float3 thicknessM,
float depth,SellmeierCoefficientsBC filmEta_coeffs){C3 F = FresnelComplex(eta_ratio, k_ratio, 1.0f, cosThetaT);C3 T = ComplexSub(C11, F);
float3 absorption = exp(-4.0f * k_ratio * thicknessM * depth);C3 interference = InterferenceThinFilmComplex(inputUV, time, nmToM(wavelengthsNM.real), thicknessM, eta_ratio, cosThetaT, ONE3 * 1.0f);C3 transmission = ComplexMul(CMul(T, interference), CVV(absorption));
return transmission;}C3 FresnelMicrofacet(
float2 inputUV, float time,
float3 viewDirection,
float3 lightDirection,
float3 microfacetNormal,MaterialSellmeier mat,MaterialProperties material,AnisotropicRoughness roughness,ThinFilmProperties thinFilms[MAX_GRATING_LAYERS],
int numThinFilms,
float sssStrength, float3 scatteringCoefficient, float3 absorptionCoefficient,
float3 dispersionCoefficient, float thicknessM, bool invertDepth, bool useProjectedDepth){
float3 V = safeNormalize(viewDirection);
float3 L = safeNormalize(lightDirection);
float3 N = safeNormalize(microfacetNormal);
float3 H = safeNormalize(V + L);
float cosTheta = saturate(dot(N, V));
float3 eta_i = mat.etaI;
float3 eta_t = mat.etaR;
float3 eta_ratio = eta_i / eta_t;
float3 k_ratio = material.k / max(material.k, EPSILON3);
float3 sinThetaT = eta_ratio * sqrt(1.0f - cosTheta * cosTheta);
float3 TIR = step(1.0f, sinThetaT);C3 F = FresnelComplex(eta_ratio, k_ratio, cosTheta, sqrt(1.0f - sinThetaT * sinThetaT));C3 transmission = SpecularTransmission(inputUV, time, eta_ratio, k_ratio, sqrt(1.0f - sinThetaT * sinThetaT),material.wavelengthsNM, thicknessM, depth2D(depthMap, inputUV, invertDepth, useProjectedDepth), material.coeff);
return CSat(CMul(transmission, CAdd(CV((1.0f - TIR), ZERO3), CMul(F, CVV(TIR)))));}C3 MicrofacetBRDF1(C3 diffuseColor,C3 sssColor,MaterialSellmeier mat,
float2 inputUV, float time,
float3 materialSpecularColor,
float3 normal,
float3 viewDir,
float3 lightDir,
bool invertDepth, bool useProjectedDepth,
float3 outsideRefractiveIndex,C3 materialRefractiveIndex,
float thicknessNM = 20.0,
float3 dispersionCoefficient = float3(0.005, 0.006, 0.007),
float3 absorptionIncomingM = ZERO3,
float roughnessX = 0.1,
float roughnessY = 0.001,
int dispersionIndex = 0,
float sssStrength = 0.5f){AnisotropicRoughness roughness;roughness.alphaX = max(roughnessX, 0.001f);roughness.alphaY = max(roughnessY, 0.001f);
float3 H = safeNormalize(viewDir + lightDir);
float ggxDistribution = DistributionGGX(dot(normal, H), roughness.alphaX * roughness.alphaY);MaterialProperties material = MaterialPropertiesFromMaterialSellmeier(mat);ThinFilmProperties thinFilms[MAX_GRATING_LAYERS];CreateThinFilms(thinFilms);
float scatteringCoef = 0.4;C3 fresnelTerm = FresnelMicrofacet(inputUV, time, viewDir, lightDir, normal, mat, material, roughness, thinFilms, MAX_GRATING_LAYERS,sssStrength, scatteringCoef, mat.absorptionCoefficient,mat.dispersionCoefficientsNm2[dispersionIndex], nmToM(thicknessNM).x, invertDepth, useProjectedDepth);C3 brdf = CMul(CV(materialSpecularColor * ggxDistribution, ZERO3), fresnelTerm);
return CSat(brdf);}
inline C3 CalculateMicrofacetSpecular(LightingComplex lighting, MaterialSellmeier mat, float3 albedo, int dispersionIndex, float time, float2 inputUV, bool invertDepth, bool useProjectedDepth, float sssStrength, float3 nSurrounding){
return
MicrofacetBRDF1(CV0(albedo), CV0(lighting.albedo), mat, inputUV, time, albedo, lighting.normal, lighting.viewDir, lighting.lightDir, invertDepth, useProjectedDepth, nSurrounding, CV(mat.etaR, mat.etaI), length(mToNm(mat.thicknessM)), mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength);}
inline C3 CalculateMicrofacetSpecular(LightingComplex lighting, MaterialSellmeier mat, float3 albedo, int dispersionIndex, float time, float2 inputUV, bool invertDepth, bool useProjectedDepth, float sssStrength){
return
MicrofacetBRDF1(CV0(albedo), CV0(lighting.albedo), mat, inputUV, time, albedo, lighting.normal, lighting.viewDir, lighting.lightDir, invertDepth, useProjectedDepth, mat.etaI, CV(mat.etaR, mat.etaI), length(mToNm(mat.thicknessM)), mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength);}
inline C3 CalculateDiffuseTransmittance(
float2 inputUV,
float time,
int dispersionIndex,LightingComplex lighting,MaterialSellmeier mat,
float sssStrength,
float3 baseDiffuseTex,C3 fresTransmittance){
return
CSatMag(CMul(CMul(CV(baseDiffuseTex, ZERO3),CSat(fresTransmittance)),CSatMag(CMul(CMul(MicrofacetBRDF1(CV(lighting.albedo, ZERO3), CV(lighting.albedo, ZERO3), mat, inputUV, time, lighting.albedo, lighting.normal, lighting.viewDir, lighting.lightDir, lighting.invertDepth, lighting.useProjectedDepth, lighting.nSurrounding, CV(mat.etaR, mat.etaI), length(mToNm(mat.thicknessM)), mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, mat.roughness, mat.roughness, dispersionIndex, sssStrength), CV(lighting.albedo, ZERO3)), CV(lighting.NdotV3 * sssStrength, ZERO3)))));}C3 CalculateReflectedTransmittedPolarization(float3 n1, float3 n2, float3 normal, float3 cosTheta_i, float3 cosTheta_t){
float3 R_perpendicular = (n1 * cosTheta_i - n2 * cosTheta_t) / (n1 * cosTheta_i + n2 * cosTheta_t);R_perpendicular = R_perpendicular * R_perpendicular;
float3 R_parallel = (n2 * cosTheta_i - n1 * cosTheta_t) / (n2 * cosTheta_i + n1 * cosTheta_t);R_parallel = R_parallel * R_parallel;
float3 reflectance = 0.5 * (R_perpendicular + R_parallel);
float3 transmittance = 1.0 - reflectance;
return CV(reflectance, transmittance);}LightingComplex PopulateLightingComplex(
Texture2D<float4> diffuseMap,
float2 inputUV,
float3 viewPos,
float3 lightPos,
bool invertDepth,
bool useProjectedDepth,
float depthScale,MaterialSellmeier mat,
float animateSpeed,
float parallaxScale,
float normalRadius,
float sssStrength,
int dispersionIndex,
float gamma,
float exposure,
float saturation){LightingComplex lighting = (LightingComplex) 0;
float time = AnimateTime;lighting.Config_Saturation = saturation;lighting.Config_Gamma = gamma;lighting.Config_Exposure = exposure;lighting.useProjectedDepth = useProjectedDepth;lighting.invertDepth = invertDepth;lighting.fDepthScale = depthScale;lighting.coherenceLengthM = mat.coherenceLengthM;lighting.depth = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth);lighting.pixelPos = float3(inputUV, lighting.depth);lighting.lightPos = lightPos;lighting.viewPos = viewPos;lighting.normal = getNormal(depthMap, inputUV, lighting.TBNf);lighting.nSurrounding = mat.nSurrounding;
float3 viewWorld = normalize(lighting.viewPos - lighting.pixelPos);lighting.viewDir = viewWorld;lighting.lightDir = normalize((lighting.lightPos - lighting.pixelPos) + EPSILON3);lighting.halfDir = normalize((lighting.viewDir + lighting.lightDir) + EPSILON3);lighting.NdotV3 = saturate(dot(lighting.viewDir, lighting.normal));lighting.NdotL3 = saturate(dot(lighting.normal, lighting.lightDir));lighting.VdotH = saturate(dot(lighting.viewDir, lighting.halfDir));lighting.HdotN = saturate(dot(lighting.halfDir, lighting.normal));lighting.HdotL = saturate(dot(lighting.halfDir, lighting.lightDir));
float3 baseDiffuse = mat.albedo * diffuse2D(diffuseMap, inputUV).rgb;lighting.albedo = baseDiffuse;lighting.material = mat;lighting.albedoWavelengthsNM = RGBToWavelengthsNM(lighting.albedo);lighting.albedoWavelengthsM = nmToM(lighting.albedoWavelengthsNM);lighting.ggxDistribution = GGXDistribution(lighting.HdotN, mat.roughness);lighting.iridescenceO = Iridescence(inputUV, lighting.viewDir, lighting.normal, lighting.albedo, mat.thicknessM.x, mat, ONE3 * mat.nSurrounding, true);lighting.iridescenceE = Iridescence(inputUV, lighting.viewDir, lighting.normal, lighting.albedo, mat.thicknessM.x, mat, ONE3 * mat.nSurrounding, false);lighting.opticalAxis = mat.opticalAxis;lighting.nSurrounding = ONE3 * mat.nSurrounding;lighting.eta_ratio = mat.nSurrounding / mat.etaR;lighting.k_ratio = mat.absorptionCoefficient / max(mat.absorptionCoefficient, EPSILON3);lighting.cosTheta = saturate(dot(lighting.normal, lighting.viewDir));lighting.F_complex = FresnelComplex(lighting.eta_ratio, lighting.k_ratio, lighting.cosTheta, sqrt(max(ONE3 - (1.0 - lighting.cosTheta) * (1.0 - lighting.cosTheta), EPSILON3)));lighting.dispersionFactor = lerp(float3(1.0, 1.0, 1.0),
float3(0.95, 1.0, 1.05),(lighting.NdotL3));lighting.n_o = CalculateRefractiveIndex(CV0(lighting.albedoWavelengthsNM), mat.coeff);lighting.cosThetaOptic = CV0(saturate(dot(lighting.lightDir, mul(lighting.TBNf,mat.opticalAxis))));lighting.n_e_effective = clamp((lighting.n_o + .5 + .5 * lighting.NdotL3) * CMul(lighting.cosThetaOptic, lighting.cosThetaOptic).real, ONE3, ONE3 * 2.5);lighting.etaR_wavelength = max(lighting.n_e_effective * lighting.dispersionFactor * lighting.material.etaR, EPSILON3);lighting.etaI_wavelength = max(abs(lighting.n_o * lighting.dispersionFactor * lighting.material.etaI), EPSILON3);lighting.R0 = FresnelReflectanceFromFilm2(lighting.etaR_wavelength, lighting.etaI_wavelength, dot(lighting.viewDir, lighting.normal), lighting.cosThetaTR0);lighting.R1 = FresnelReflectanceFromFilm2(lighting.etaI_wavelength, lighting.etaR_wavelength, dot(-lighting.viewDir, lighting.normal), lighting.cosThetaTR1);PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(CV0(lighting.viewPos), CV0(lighting.pixelPos), CV0(mat.thicknessM), lighting.normal);OpticalPathResult opticalPathDiff = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, pathMeasurement, mat.dispersionCoefficientsNm2[dispersionIndex], mat.absorptionCoefficient, lighting.cosThetaTR1.real);lighting.waveInterference = ComputeVolumetricWaveInterferencePhase(lighting.albedoWavelengthsNM, inputUV, time, lighting.TBNf, lighting.depth, mat, parallaxScale, opticalPathDiff, lighting.coherenceLengthM);C3 caustics = CV0(ComputeHolographicCaustics(lighting, inputUV, time, parallaxScale));lighting.totalLighting[0] = CMag(lighting.waveInterference);
return lighting;lighting.LdotA = abs(dot(mat.opticalAxis, lighting.lightDir));lighting.qwave = ComplexQuantumWave(CVV(lighting.albedo), inputUV, time, (.5 + .5 * sin(time * 3)) * 0.2 + 0.4, cos(time), lighting.LdotA);lighting.qwave = CAdd(lighting.qwave, ComplexQuantumWave(CVV(1-lighting.albedo), inputUV, time, (.5 + .5 * sin(time * 25)) * 0.2 + 0.4, cos(time), lighting.LdotA));lighting.phaseShift_o = ComplexThinFilmInterference(CMul(lighting.waveInterference, lighting.qwave), inputUV, time, mToNm(mat.thicknessM), mat.etaR, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM));lighting.phaseShift_e = ComplexThinFilmInterference(CMul(CVV(0.1 * CMag(lighting.waveInterference)), CMul(CVV(0.01), lighting.qwave)),inputUV, time, mToNm(mat.thicknessM), mat.etaI, mat.absorptionCoefficient * ONE3, CVV(lighting.albedoWavelengthsNM));lighting.phaseShift = ComplexLerp(lighting.phaseShift_o, lighting.phaseShift_e, CVV(lighting.NdotV3));lighting.D_complex = MicrofacetDistribution_Complex(lighting.normal, lighting.halfDir, mat.roughness);lighting.G_complex = GeometrySmith_ComplexCombined(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness);lighting.spec_complex = CMul(CMul(lighting.D_complex, lighting.G_complex), lighting.F_complex);lighting.complexSpecular = CAbs(lighting.spec_complex).real;lighting.complexSpecular = lighting.complexSpecular * lighting.complexSpecular;lighting.metallicReflectance = 0.2;lighting.cookTorrenceSpecular = lerp(CookTorranceSpecularPBR(lighting.normal, lighting.viewDir, lighting.lightDir, mat.roughness,CalculateF0(mat.metallic, float3(0.04, 0.04, 0.04), lighting.metallicReflectance), mat.metallic),lighting.complexSpecular, 0.5);lighting.sheen = CalculateBasicSheen(lighting.normal, lighting.lightDir, lighting.viewDir, mat.roughness, SHEEN_ALBEDO_TINT);
float3 tangent = lighting.TBNf[0];lighting.advancedSheen = CalculateAdvancedSheen(lighting.normal, lighting.lightDir, lighting.viewDir, tangent, mat.roughness, SHEEN_ALBEDO_TINT);lighting.clearCoatSpecular = saturate(CLEAR_COAT_THICKNESS * lighting.ggxDistribution) +DistributionGGX(lighting.HdotN, mat.roughness * CLEAR_COAT_ROUGHNESS_MULTIPLIER) * ClearCoatFresnel(lighting.NdotV3);lighting.specularWithSheen =lerp(lighting.VdotH * lighting.cookTorrenceSpecular +lighting.HdotL * lighting.iridescenceO +lighting.HdotN * lighting.sheen +lighting.NdotL3 * lighting.iridescenceE +lighting.LdotA * lighting.advancedSheen, 0, 0.5);lighting.microfacetRoughness = mat.roughness.xx;lighting.ggxDistributionTerm = DistributionGGX(max(0, dot(lighting.normal, lighting.halfDir)), lighting.microfacetRoughness.x);lighting.smithGeometryTerm = GeometrySmithNVLf(lighting.normal, lighting.viewDir, lighting.lightDir, lighting.microfacetRoughness.x);lighting.microfacetDenominator = max(abs((float3(2.0, 2.0, 2.0) + lighting.normal) * lighting.NdotV3), float3(EPSILON3));lighting.microfacetSpecularTerm = saturate((lighting.ggxDistributionTerm * lighting.smithGeometryTerm) / lighting.microfacetDenominator);lighting.n_real = CalculateRefractiveIndex(CVV(lighting.albedoWavelengthsNM), mat.coeff);lighting.refPol = CalculateReflectedTransmittedPolarization(lighting.nSurrounding, mat.etaR, -lighting.lightDir, lighting.normal, lighting.cosThetaTR0.real);lighting.compositeSpecular = C0V(CSat(CMul(lighting.refPol,CV0(lighting.NdotL3 * lighting.specularWithSheen + lighting.clearCoatSpecular * lighting.VdotH + lighting.iridescenceO * lighting.HdotN))).real);lighting.specularContribution = CV0(Specular(lighting.normal, lighting.viewDir, lighting.lightDir, mat) * lighting.microfacetSpecularTerm);lighting.F0 = pow(1.0 - saturate(lighting.NdotL3), FresnelPower);lighting.reflectance = CalculateFresnelReflectance(CV0(lighting.etaR_wavelength), lighting.normal, lighting.lightDir, lighting.transmittance);lighting.filmReflectedPolarization = CSat(CV(ApplyReflectanceCoherence(CMul(lighting.reflectance, lighting.compositeSpecular).real,opticalPathDiff, lighting.coherenceLengthM),ApplyReflectanceCoherence(CMul(lighting.reflectance, lighting.compositeSpecular).imag,opticalPathDiff, lighting.coherenceLengthM)));PathMeasurement viewToPixel = DistanceMFromViewToAB(CV0(lighting.viewPos), CV0(lighting.pixelPos),CV0(lighting.pixelPos + lighting.normal * mat.thicknessM));OpticalPathResult opdResInsideReal = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, viewToPixel,mat.dispersionCoefficientsNm2[dispersionIndex],mat.absorptionCoefficient, lighting.cosThetaTR0.real);OpticalPathResult opdResInsideImag = OpticalPathDifference(CV0(lighting.albedoWavelengthsNM), lighting.nSurrounding, viewToPixel,mat.dispersionCoefficientsNm2[dispersionIndex],mat.absorptionCoefficient, lighting.cosThetaTR1.real);C3 opdAlbedoTransInsideChannel = CV(opdResInsideReal.phaseInterference.opticalPathDifference, opdResInsideImag.phaseInterference.totalPhase);lighting.transmittanceCoherence = CV0(max(CoherenceFactor(opdResInsideReal.phaseInterference.opticalPathDifference, mat.coherenceLengthM), ZERO3) +max(CoherenceFactor(opdResInsideImag.phaseInterference.opticalPathDifference, mat.coherenceLengthM), ZERO3));lighting.diffuseReflectance =CSatMag(CAdd(lighting.reflectance,lighting.filmReflectedPolarization));lighting.diffuseTransmittance = CalculateDiffuseTransmittance(inputUV, time, dispersionIndex, lighting, mat, sssStrength, lighting.albedo, lighting.transmittance);lighting.eeDiffuse = CMul(lighting.diffuseTransmittance, CV0(lighting.albedo * ONE3 * PhaseFactorDiffuse()));lighting.eeSpecular = CMul(lighting.specularContribution, CV0(ONE3 * PhaseFactorSpecular(mat.roughness, lighting.albedoWavelengthsNM)));lighting.eeInterference = CMul(C0V(lighting.phaseShift.imag), C0V(ONE3 * ApplyTransmissionCoherence(lighting.diffuseTransmittance.imag, opdResInsideImag, mat.coherenceLengthM)));lighting.eeInterference = C00;
float3 combinedLighting = (lighting.F0) +max(0, dot(lighting.normal, lighting.halfDir))* lighting.albedo + (CSatMag(lighting.diffuseTransmittance).real + CSatMag(lighting.diffuseReflectance).real) +Mix3 * max(0, dot(lighting.normal, lighting.halfDir)) * saturate(1 - lighting.filmReflectedPolarization.imag) + (lighting.specularWithSheen + lighting.microfacetSpecularTerm);
if (any(lighting.diffuseTransmittance.real > 0.999)){}
float3 f = rotateHue(saturate(combinedLighting), fmod((lighting.phaseShift.real + time) * 360., 360.))* max(0, dot(lighting.halfDir, lighting.normal)) * max(0, dot(lighting.viewDir, lighting.halfDir));SetDVf(totalLighting, f);
return lighting;}MaterialSellmeier CreateMaterialSellmeier(SellmeierCoefficients coeff,
float3 absorptionCoefficient,
float3 scatteringCoefficient,
float roughness, float metallic,
float3 metallicReflectance,
float3 albedo,
float3 thicknessM,
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
float3 elasticModulus){MaterialSellmeier material = (MaterialSellmeier) 0;material.coeff.OE1.O.B = coeff.OE1.O.B;material.coeff.OE2.O.B = coeff.OE2.O.B;material.coeff.OE3.O.B = coeff.OE3.O.B;material.coeff.OE1.O.C = coeff.OE1.O.C;material.coeff.OE2.O.C = coeff.OE2.O.C;material.coeff.OE3.O.C = coeff.OE3.O.C;material.coeff.OE1.E.B = coeff.OE1.E.B;material.coeff.OE2.E.B = coeff.OE2.E.B;material.coeff.OE3.E.B = coeff.OE3.E.B;material.coeff.OE1.E.C = coeff.OE1.E.C;material.coeff.OE2.E.C = coeff.OE2.E.C;material.coeff.OE3.E.C = coeff.OE3.E.C;material.absorptionCoefficient = absorptionCoefficient;material.roughness = roughness;material.metallic = metallic;material.albedo = albedo;material.thicknessM = thicknessM;material.etaR = etaR;material.etaI = etaI;material.dispersionCoefficientsNm2[0] = dispersionCoefficientsD0;material.dispersionCoefficientsNm2[1] = dispersionCoefficientsD1;material.dispersionCoefficientsNm2[2] = dispersionCoefficientsD2;material.opticalAxis = opticalAxis;material.nSurrounding = nSurrounding;material.coherenceLengthM = coherenceLengthM;
return material;}MaterialSellmeier CreateMaterial(int index){index = fmod(index, 9);MaterialSellmeier ret = (MaterialSellmeier) 0;
switch (index){
case 0:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.4313493, 0.65054713, 5.3414021),nmSqToUmSq(float3(0.0726631, 0.1193242, 18.028251))),CreateSellmeierCoefficientsBC(
float3(1.5039759, 1.132329, 0.0),nmSqToUmSq(float3(0.0758395, 20.226728, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.4313493, 0.65054713, 5.3414021),nmSqToUmSq(float3(0.0726631, 0.1193242, 18.028251))),CreateSellmeierCoefficientsBC(
float3(1.5039759, 1.132329, 0.0),nmSqToUmSq(float3(0.0758395, 20.226728, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.3, 0.1, 0.05),
float3(0.1, 0.1, 0.05),0.5,0.8,
float3(0.8, 0.6, 0.5),
float3(1, 1, 1),nmToM(float3(1200.0,1200.0,1200.0)),
float3(1.768, 1.768, 1.768),
float3(1.2, 1.3, 1.1),
float3(0.15, 0.25, 0.30),
float3(0.25, 0.30, 0.35),
float3(0.40, 0.50, 0.55),
float3(1.768, 1.768, 1.768),
float3(1.748, 1.748, 1.748),safeNormalize(float3(0.0, 0.0, 1.0)),1.0,1.0,COHERENCE_LENGTH_M,25.0,
float3(3980.0, 3980.0, 3980.0),
float3(0.4, 0.4, 0.4),
float3(300.0, 300.0, 300.0));}
break;
case 1:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.3306, 4.3356, 0.0),nmSqToUmSq(float3(0.1750, 0.1060, 0.0))),CreateSellmeierCoefficientsBC(
float3(4.3356, 0.3306, 0.0),nmSqToUmSq(float3(0.1060, 0.1750, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.3306, 4.3356, 0.0),nmSqToUmSq(float3(0.1750, 0.1060, 0.0))),CreateSellmeierCoefficientsBC(
float3(4.3356, 0.3306, 0.0),nmSqToUmSq(float3(0.1060, 0.1750, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.1, 0.05, 0.01),
float3(0.05, 0.05, 0.04),0.15, 0.1,
float3(0.08, 0.09, 0.09),
float3(1.0, 1.0, 1.0),nmToM(1250.0),
float3(2.417, 2.417, 2.417),
float3(1.0, 1.2, 1.2),
float3(0.1, 0.1, 0.1),
float3(0.2, 0.2, 0.2),
float3(0.3, 0.3, 0.3),
float3(2.417, 2.417, 2.417),
float3(2.407, 2.407, 2.407),safeNormalize(float3(.0, .0, 1.)),1.0,0.0,COHERENCE_LENGTH_M,20.0,
float3(3510.0, 3510.0, 3510.0),
float3(1200.0, 1200.0, 1200.0),
float3(1200.0, 1200.0, 1200.0));}
break;
case 2:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.6961663, 0.4079426, 0.8974994),nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161))),CreateSellmeierCoefficientsBC(
float3(0.6961663, 0.4079426, 0.8974994),nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.6961663, 0.4079426, 0.8974994),nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161))),CreateSellmeierCoefficientsBC(
float3(0.6961663, 0.4079426, 0.8974994),nmSqToUmSq(float3(0.0684043, 0.1162414, 9.896161)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.2, 0.2, 0.2),
float3(0.05, 0.05, 0.05),0.1, 0.7,
float3(0.5, 0.6, 0.5),
float3(0.9, 0.9, 0.9),nmToM(1100.0),
float3(1.544, 1.544, 1.544),
float3(1.144, 1.244, 1.144),
float3(0.2, 0.2, 0.2),
float3(0.3, 0.3, 0.3),
float3(0.4, 0.4, 0.4),
float3(1.544, 1.544, 1.544),
float3(1.534, 1.534, 1.534),safeNormalize(float3(0.0, 1.0, 0.0)),1.0,1.0,COHERENCE_LENGTH_M,20.0,
float3(2650.0, 2650.0, 2650.0),
float3(1278.0, 1278.0, 1278.0),
float3(78.0, 78.0, 78.0));}
break;
case 3:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.4431997, 0.4065331, 2.8801242),nmSqToUmSq(float3(0.0937428, 0.2017152, 25.890623))),CreateSellmeierCoefficientsBC(
float3(1.482148, 0.549392, 0.0),nmSqToUmSq(float3(0.112315, 18.543127, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.4431997, 0.4065331, 2.8801242),nmSqToUmSq(float3(0.0937428, 0.2017152, 25.890623))),CreateSellmeierCoefficientsBC(
float3(1.482148, 0.549392, 0.0),nmSqToUmSq(float3(0.112315, 18.543127, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.25, 0.1, 0.05),
float3(0.15, 0.05, 0.03),0.3, 0.6,
float3(0.4, 0.8, 0.5),
float3(0.3, 0.8, 0.4),nmToM(3150.0),
float3(1.576, 1.576, 1.576),
float3(0.0, 0.0, 0.0),
float3(0.1, 0.2, 0.3),
float3(0.2, 0.3, 0.4),
float3(0.3, 0.4, 0.5),
float3(1.576, 1.576, 1.576),
float3(1.566, 1.566, 1.566),safeNormalize(float3(0.0, 1.0, 0.0)),1.2,0.8,COHERENCE_LENGTH_M,22.0,
float3(2680.0, 2680.0, 2680.0),
float3(0.3, 0.3, 0.3),
float3(120.0, 120.0, 120.0));}
break;
case 4:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.8683, 0.4401, 0.8797),nmSqToUmSq(float3(0.13359, 0.05644, 9.1806))),CreateSellmeierCoefficientsBC(
float3(0.8642, 0.4002, 0.0),nmSqToUmSq(float3(0.1165, 10.9453, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.8683, 0.4401, 0.8797),nmSqToUmSq(float3(0.13359, 0.05644, 9.1806))),CreateSellmeierCoefficientsBC(
float3(0.8642, 0.4002, 0.0),nmSqToUmSq(float3(0.1165, 10.9453, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.15, 0.08, 0.02),
float3(0.12, 0.08, 0.05),0.4, 0.5,
float3(0.5, 0.4, 0.7),
float3(0.8, 0.6, 0.9),nmToM(ONE3*2200.0),
float3(1.452, 1.452, 1.452),
float3(0.0, 0.0, 0.0),
float3(0.12, 0.15, 0.20),
float3(0.15, 0.20, 0.25),
float3(0.20, 0.25, 0.30),
float3(1.452, 1.452, 1.452),
float3(1.442, 1.442, 1.442),safeNormalize(float3(0.0, 0.0, 1.0)),1.0,0.5,COHERENCE_LENGTH_M,25.0,
float3(2000.0, 2000.0, 2000.0),
float3(0.15, 0.15, 0.15),
float3(40.0, 40.0, 40.0));}
break;
case 5:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.815, 0.451, 0.897),nmSqToUmSq(float3(0.1306, 0.0553, 10.1234))),CreateSellmeierCoefficientsBC(
float3(0.815, 0.451, 0.0),nmSqToUmSq(float3(0.1306, 10.1234, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.815, 0.451, 0.897),nmSqToUmSq(float3(0.1306, 0.0553, 10.1234))),CreateSellmeierCoefficientsBC(
float3(0.815, 0.451, 0.0),nmSqToUmSq(float3(0.1306, 10.1234, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.12, 0.06, 0.03),
float3(0.10, 0.05, 0.02),0.2, 0.4,
float3(0.4, 0.3, 0.1),
float3(0.8, 0.5, 0.2),nmToM(ONE3*3150.0),
float3(1.540, 1.540, 1.540),
float3(1.1540, 1.1540, 1.1540),
float3(0.1, 0.2, 0.3),
float3(0.2, 0.3, 0.4),
float3(0.3, 0.4, 0.5),
float3(1.540, 1.540, 1.540),
float3(1.530, 1.530, 1.530),safeNormalize(float3(0.0, 1.0, 0.0)),1.0,0.0,COHERENCE_LENGTH_M,20.0,
float3(1200.0, 1200.0, 1200.0),
float3(0.1, 0.1, 0.1),
float3(30.0, 30.0, 30.0));}
break;
case 6:{SellmeierCoefficients sc = CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.6867, 0.3508, 0.4523),nmSqToUmSq(float3(0.2006, 0.1003, 25.1004))),CreateSellmeierCoefficientsBC(
float3(0.7789, 0.3761, 0.0),nmSqToUmSq(float3(0.2079, 18.3457, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.6867, 0.3508, 0.4523),nmSqToUmSq(float3(0.2006, 0.1003, 25.1004))),CreateSellmeierCoefficientsBC(
float3(0.7789, 0.3761, 0.0),nmSqToUmSq(float3(0.2079, 18.3457, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0)))));ret = CreateMaterialSellmeier(sc,
float3(0.12, 0.05, 0.02),
float3(0.10, 0.08, 0.06),0.3, 0.2,
float3(0.3, 0.2, 0.1),
float3(0.9, 0.8, 0.7),nmToM(ONE3*6100.0),
float3(1.658, 1.658, 1.658),
float3(1.486, 1.486, 1.486),
float3(0.1, 0.15, 0.2),
float3(0.2, 0.25, 0.3),
float3(0.3, 0.35, 0.4),
float3(1.658, 1.658, 1.658),
float3(1.486, 1.486, 1.486),safeNormalize(float3(0.0, 0.0, 1.0)),1.0,0.8,COHERENCE_LENGTH_M,20.0,
float3(2710.0, 2710.0, 2710.0),
float3(0.3, 0.3, 0.3),
float3(80.0, 80.0, 80.0));}
break;
case 7:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.48755108, 0.39875031, 2.3120353),nmSqToUmSq(float3(0.04338408, 0.09461442, 23.793604))),CreateSellmeierCoefficientsBC(
float3(0.49755108, 0.39875031, 2.3420353),nmSqToUmSq(float3(0.04538408, 0.09331442, 24.193604)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.48755108, 0.39875031, 2.3120353),nmSqToUmSq(float3(0.04338408, 0.09461442, 23.793604))),CreateSellmeierCoefficientsBC(
float3(0.49755108, 0.39875031, 2.3420353),nmSqToUmSq(float3(0.04538408, 0.09331442, 24.193604)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.08, 0.05, 0.02),
float3(0.10, 0.06, 0.04),0.1, 0.5,
float3(0.5, 0.5, 0.5),
float3(0.95, 0.92, 0.90),nmToM(ONE3*4100.0),
float3(1.377, 1.377, 1.377),
float3(1.393, 1.393, 1.393),
float3(0.10, 0.15, 0.20),
float3(0.15, 0.20, 0.25),
float3(0.20, 0.25, 0.30),
float3(1.377, 1.377, 1.377),
float3(1.393, 1.393, 1.393),safeNormalize(float3(0.0, 1.0, 0.0)),1.0,0.0,COHERENCE_LENGTH_M,20.0,
float3(3180.0, 3180.0, 3180.0),
float3(0.3, 0.3, 0.3),
float3(60.0, 60.0, 60.0));}
break;
case 8:{ret = CreateMaterialSellmeier(CreateSellmeierCoefficients(CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.53, 1.53, 1.53),nmSqToUmSq(float3(0.02, 0.02, 0.02))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.04, 0.05, 0.02)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(1.53, 1.53, 1.53),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0)))),CreateSellmeierCoefficientsOE(CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))),CreateSellmeierCoefficientsBC(
float3(0.0, 0.0, 0.0),nmSqToUmSq(float3(0.0, 0.0, 0.0))))),
float3(0.02, 0.02, 0.02),
float3(0.04, 0.05, 0.02),0.35, 0.4,
float3(0.08, 0.06, 0.05),
float3(0.75, 0.75, 0.75),nmToM(1500.0),
float3(1.53, 1.53, 1.53),
float3(1.53, 1.53, 1.53),
float3(0.02, 0.03, 0.02),
float3(0.15, 0.26, 0.15),
float3(0.29, 0.29, 0.29),
float3(1.53, 1.53, 1.53),
float3(1.53, 1.53, 1.53),safeNormalize(float3(0.0, 0.0, -1.0)),1.0,0.0,COHERENCE_LENGTH_M,22.0,
float3(1200.0, 1200.0, 1200.0),
float3(0.25, 0.25, 0.25),
float3(2.3, 2.3, 2.3));}
break;}
return ret;}
float3 ComputeOpticalField(float2 uv, float3 i){
float3 viewPos = float3(ViewX, ViewY, ViewZ);
float depthVal = depth2D(depthMap, uv, !KeyQDown, !KeyWDown);
float3 depth = ONE3 * depthVal * DepthScale;
float3 amplitude = diffuse2D(diffuseMap, uv).rgb;
float3 normal = getNormal(depthMap, uv).rgb;
float3 wavelengths = RGBToWavelengthsNM(diffuse2D(diffuseMap, uv).rgb);
float3 phaseShift = (wavelengths / depth);
float3 totalPhase = (phaseShift);C3 phaseFactor = CExp(CV0(i*totalPhase));
float noise = noise2D(noiseMap1, uv).r;C3 field = phaseFactor;
float3 lightDir = normalize(viewPos - float3(float2(uv.x, -uv.y), length(depth)));phaseFactor.real *= saturate(dot(normal, lightDir));
return amplitude * phaseFactor.real;}C3 ComputeComplexOpticalField(float3 viewDir, float3x3 tbn, float2 uv, float depth, float NdotV, float3 wavelengthsNM){C3 phaseV = CMul(C2PIDiv(CV0(nmToM(wavelengthsNM))), CV0Mul2(depth));C3 mod = CV0(ComputeOpticalField(uv, length(nmToM(wavelengthsNM))));phaseV = CMul(phaseV, mod);C3 fs = C0V(phaseV.real);
return CV(CSatMag(CMul(CV0(diffuse2D(diffuseMap, uv).xyz), CMagSq(mod))).real, phaseV.real);}C3 ComputeComplexReferenceField(float2 uv, float3 tilt, float3x3 tbn){
float3 refPhase = mul(tbn, tbn[2]) * cos(AnimateTime) * f4;
return C0V(refPhase);}
inline C3 AngularFrequency(C3 f){
return CMul(CV0(2.0 * PI), f);}C3 ComputeOPDPhase(C3 cAngularFrequency, C3 cRefractiveIndex, C3 depth){C3 opL = CMul(cRefractiveIndex, depth);
return CMul(CDiv(cAngularFrequency, CV0(SPEED_OF_LIGHT)), opL);}C3 ComputeFresnelPhase(C3 R0, C3 viewDirTS, C3 normal){C3 cosTheta = CDot(viewDirTS, normal);C3 oneMinusCos = CSub(CV0(1.0), cosTheta);C3 term = CPow(oneMinusCos, CV0(FresnelPower));C3 oneMinusR0 = CMax(C0, CSub(CV0(1.0), R0));C3 fresnelContribution = CMul(oneMinusR0, term);
return CMin(C1, CAdd(R0, fresnelContribution));}C3 getColorComplex(LightingComplex lighting,
int ix,
int dispersionIndex){psout output = (psout) 0.;output.rt1.w = 1.;
switch (uint(ix) % 61){LP_CASE(0, totalLighting[dispersionIndex])LP_CASE(1, opticalAxis)LP_CASE(2, nSurrounding)LP_CASE(3, eta_ratio)LP_CASE(4, k_ratio)LP_CASE(5, cosTheta)LP_CASE(6, F_complex.real)LP_CASE(7, dispersionFactor)LP_CASE(8, n_o)LP_CASE(9, cosThetaOptic.real)LP_CASE(10, n_e_effective)LP_CASE(11, etaR_wavelength)LP_CASE(12, etaI_wavelength)LP_CASE(13, cosThetaTR0.real)LP_CASE(14, R0.real)LP_CASE(15, cosThetaTR1.real)LP_CASE(16, R1.real)LP_CASE(17, R1.real)LP_CASE(18, qwave.real)LP_CASE(19, phaseShift_o.real)LP_CASE(20, phaseShift_e.real)LP_CASE(21, phaseShift.real)LP_CASE(22, D_complex.real)LP_CASE(23, G_complex.real)LP_CASE(24, spec_complex.real)LP_CASE(25, complexSpecular)LP_CASE(26, metallicReflectance)LP_CASE(27, sheen)LP_CASE(28, advancedSheen)LP_CASE(29, clearCoatSpecular)LP_CASE(30, specularWithSheen)LP_CASE(31, ggxDistributionTerm)LP_CASE(32, smithGeometryTerm)LP_CASE(33, microfacetDenominator)LP_CASE(34, microfacetSpecularTerm)LP_CASE(35, n_real)LP_CASE(36, F0)LP_CASE(37, refPol.real)LP_CASE(38, compositeSpecular.real)LP_CASE(39, coherenceLengthM)LP_CASE(40, specularContribution.real)LP_CASE(41, reflectance.real)LP_CASE(42, filmReflectedPolarization.real)LP_CASE(43, transmittance.real)LP_CASE(44, transmittanceCoherence.real)LP_CASE(45, diffuseReflectance.real)LP_CASE(46, diffuseTransmittance.real)LP_CASE(47, eeDiffuse.real)LP_CASE(48, eeSpecular.real)LP_CASE(49, eeInterference.real)LP_CASE(50, ggxDistribution)LP_CASE(51, cookTorrenceSpecular)LP_CASE(52, waveInterference.real)LP_CASE(53, ggxDistribution)LP_CASE(54, cookTorrenceSpecular)LP_CASE(55, albedo)LP_CASE(56, albedoWavelengthsNM)LP_CASE(57, albedoWavelengthsM)LP_CASE(58, iridescenceO);LP_CASE(59, iridescenceE);
default:output.rt1.xyz = lighting.totalLighting[dispersionIndex];
break;}
return CV0(output.rt1.xyz);}
float ComputeCurvature(Texture2D<float> depthMap, float2 oosz, float2 inputUV, bool invertDepth, bool useProjectedDepth){
float center;
float4 d = depthRaw5(depthMap, inputUV, center, NormalRadius);
float dxx = (d.y + d.x - 2.0 * center) / (oosz.x * oosz.x);
float dyy = (d.z + d.w - 2.0 * center) / (oosz.y * oosz.y);
float curvature = dxx * dyy;
float ret = clamp(curvature, EPSILON, 1.0 - EPSILON);ret = lerp(ret, (1.0 - ret), step(0.5, invertDepth));
return ret;}C3 AccumulateColor(C3 currentColor, C3 previousAccum, float factor){C3 vfactor = CMul(CDiv(C11, CAdd(CV1(0.5), C11)), CV1(factor));C3 ret = CMMul(CV0(previousAccum.real), CAdd(CV0(0.5), CV0(currentColor.real)), vfactor);
return ret;}psout LightOutput(psout output, float2 inputUV){
float3 normal;
float depth = SampleDepth(depthMap, inputUV);
float2 depthMod = GetModulation(GetGradient(inputUV));MaterialSellmeier mat = CreateMaterial(MaterialIndex);;
float3x3 tbn;normal = normalize(getNormal(depthMap, inputUV, tbn));
float3 viewPos = ViewPos;
float3 pixel = float3(inputUV, depth);
float3 lightPos = LightPos;
float3 lightDir = normalize(lightPos - pixel);
float3 viewDir = normalize(viewPos - pixel);
float3 halfDir = normalize(lightDir + viewDir);
float3 diffuse = diffuse2D(diffuseMap, inputUV).xyz;
float3 wavelengthsNMf = RGBToWavelengthsNM(diffuse);
float nSurrounding = 1.7;C3 objectField = ComputeComplexOpticalField(viewDir, tbn, inputUV, depth,max(0, dot(normal, viewDir)), wavelengthsNMf);C3 referenceField = ComputeComplexReferenceField(inputUV, CMag(objectField), tbn);C3 holoField = CSatMag(CMul(objectField, CAdd(CV0(diffuse), referenceField)));C3 wavelengthsNM = CV0(RGBToWavelengthsNM(diffuse));C3 wavelengthsM = CV0(nmToM(wavelengthsNM.real));C3 frequency = CDiv(CV0(SPEED_OF_LIGHT), wavelengthsM);C3 angularFrequency = AngularFrequency(frequency);C3 oplPhase = ComputeOPDPhase(angularFrequency,CV0(mat.etaR), CV0(pixel));C3 fresnelPhaseFactor = CMul(CPI, CAdd(C1, Cp5));PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixel), CV0(mat.thicknessM), normal);OpticalPathResult opdResInsideReal = OpticalPathDifference(wavelengthsNM, nSurrounding, pathMeasurement,mat.dispersionCoefficientsNm2[0],mat.absorptionCoefficient, dot(viewDir, halfDir));OpticalPathResult opdResInsideImag = OpticalPathDifference(wavelengthsNM, nSurrounding, pathMeasurement,mat.dispersionCoefficientsNm2[0],mat.absorptionCoefficient, dot(viewDir, halfDir));C3 opdAlbedoTransInsideChannel = CV(opdResInsideReal.phaseInterference.opticalPathDifference, opdResInsideImag.phaseInterference.opticalPathDifference);C3 fresnelPhase = CAdd(opdAlbedoTransInsideChannel, CSub(C01, ComputeFresnelPhase(CV0(mat.metallic), CV0(viewDir), CV0(normal))));C3 curvaturePhase = C0V(ComputeCurvature(depthMap, GetOosz(depthMap), inputUV, !KeyQDown, !KeyWDown));
float offsetScalarI = f1;
float offsetScalarR = f2;C3 fastOffset =CMul(CSin(CAdd(CMAdd(CSub(CV0(pixel), Cp50),CCos(CTime),CV0(offsetScalarI)),Cp50)),CV0(offsetScalarR));C3 totalPhase = CAdd(CAdd(fresnelPhase, curvaturePhase), oplPhase);C3 centralPhase = CExp(totalPhase);C3 currentColor = CSatMag(CMul(referenceField, objectField));
int dispersionIndex = 0;
float curvatureFactor = f9 * .01;
float centralWeight = f8;
float fresnelFactor = f4;
float angularFrequencyScalar = f5;
float time = AnimateTime;
float ct0 = cos(time);
bool invertDepth = !KeyQDown, useProjectedDepth = !KeyWDown;
float2 sz = GetSz(depthMap);
float2 oosz = 1.0 / sz;
int item = 1;
bool xrayMode = true;
int szScale = 50;
int2 cellSize = int2(szScale, szScale);
int colsPerRow = int(floor(uint(sz.x) / uint(cellSize.x)));
float2 uvI = float2((inputUV.x * float(sz.x) / float(cellSize.x)),(inputUV.y * float(sz.y) / float(cellSize.y)));
int2 uvIi = int2(uvI);
int hCount = int(floor(float(sz.x) / uint(cellSize.x)));
int vCount = int(floor(float(sz.y) / uint(cellSize.y)));
int uvCol = uvI.x;
int uvRow = uvI.y;
float depth0 = depth2D(depthMap, inputUV, invertDepth, useProjectedDepth, NormalRadius);
float2 deltaUV = ZERO2;
float2 adjustedUV = deltaUV + inputUV;
float3 pixelPos = float3(adjustedUV, depth);
int ix = clamp(uvRow * colsPerRow + uvCol, 0.0, 61);LightingComplex lightingComplex =PopulateLightingComplex(diffuseMap, adjustedUV, viewPos, float3(SunX, SunY, SunZ), !KeyQDown, !KeyWDown, DepthScale, mat, AnimateSpeed, ParallaxScale, NormalRadius, 0.5, dispersionIndex, Gamma, f9, 0.7);currentColor = getColorComplex(lightingComplex, ix, dispersionIndex);C3 previousAccum = currentColor;
if (PassNum > 0.0)previousAccum = CSub(CMul(CV(output.rt3.xyz, output.rt4.xyz), C22), C11);C3 accumColor = AccumulateColor(currentColor, previousAccum, f3);output.rt1.xyz = AdjustGammaf(CMag(accumColor), Gamma);output.rt3.xyz = saturate(accumColor.real.xyz * .5 + .5);output.rt4.xyz = saturate(accumColor.imag.xyz * .5 + .5);
return output;}
float3 GenerateBaseInterference(float2 uv, float3 phase){
float3 interference = 0.0;
float2 sz = GetSz(depthMap);
float2 wavePos = uv * sz * f2;[unroll]
for (int i = 0; i < 3; i++){
float freq = wavelengths[i] * 3 * 1 / sz.x;interference[i] = sin(wavePos.x * freq + phase[i]) *sin(wavePos.y * freq * 0.7 + phase[i]);}
float _f4 = f4 - 0.01;[unroll]
for (i = 0; i < 3; i++){_f4 += 0.01;
float freq = wavelengths[i] * 3 * _f4 * 1 / sz.y;interference[i] += sin(wavePos.x * freq + phase[i]) *sin(wavePos.y * freq * 0.7 + phase[i]);}
return interference * .5;}
float3 GenerateSecondaryWaves(float2 uv, float t, float3 eta){
float3 wavelengthsM = RGBToWavelengthsM(gradient2.SampleLevel(sampleTypeMirror, uv, 0).xyz);
float3 waves;waves.x = sin(uv.x * 25.0 + t * 1.3) / (2. * 2. * PI / wavelengthsM.x * 0.3);waves.y = sin(uv.y * 20.0 + t * 0.9) / (0.3 * 2. * 2. * PI / wavelengthsM.y * 0.3);waves.z = sin(dot(uv, float2(15.0, 18.0)) + t * 0.6) / (0.3 * 2. * 2. * PI / wavelengthsM.z * 0.3);
return waves;}
float3 CalculatePhase(float2 uv, float3 t, C3 phaseShift, float3 oscillationAmplitude){
float3 diffuse = diffuse2D(diffuseMap, uv).xyz;
float3 wavelengthsNMf = RGBToWavelengthsNM(diffuse);MaterialSellmeier mat = CreateMaterial(MaterialIndex);
float3 phase;phase.x = (sin((t.x + .5 + (uv.x - .5) * 0.01 * CosineFactorR + CAdd(phaseShift, C0V(cos(AnimateTime))).real * oscillationAmplitude.x) * mat.etaR.x / wavelengthsNMf.x)).x;phase.y = (sin((t.y * 0.018 * cosTime01(AnimateSpeed) + 2.0 * (.5 + (-uv.y - .5) * sinTime01(AnimateSpeed) + phase.x * mat.coherenceLengthM) * 0.08 - phaseShift.real.y)) * oscillationAmplitude.y * mat.etaR.y / wavelengthsNMf.y * phaseShift.imag.y * CSatMag(CMul(phaseShift, CV0(mat.coherenceLengthM))).real).y;phase.z = C0V(sin(float3(float2(LookAtX, LookAtY), 1)*t.z + .5 + (uv.x - .5 + phaseShift.real.z) * oscillationAmplitude.z * mat.etaR) /(CAdd(C0V(EPSILON3), ComplexDiv(ComplexAdd(C0V(wavelengthsNMf),CMul(phaseShift, C0V(saturate(CMag(CDiv(phaseShift, CV0(mat.coherenceLengthM))))))),CV0(mat.coherenceLengthM))).real).z).real.z;phase.x += cos(phase.z * 2.0 * PI + AnimateTime);
return lerp(phase, 0, .95);}
float3 CalculateOpticalPhaseDifference(float3 pathDifference, float3 wavelength, float3 refractiveIndex){
return 2.0 * 3.14159 * refractiveIndex * pathDifference / wavelength;}
float SimulateDiffraction(float2 texCoord, float diffractionScale){
float2 oosz = GetOosz(depthMap);
return sin(SampleDepth(depthMap, texCoord + float2(oosz.x * diffractionScale, oosz.y * diffractionScale * 0.25)) * 3.14159 * diffractionScale) * sin(SampleDepth(depthMap, texCoord + float2(0.25 * oosz.x * diffractionScale, 0)) * 3.14159 * diffractionScale);}
float4 PS_FullDepthNormalMichelsonInterferometer(float4 position : SV_POSITION, float2 texCoord : TEXCOORD, float holographicDepth) : SV_TARGET{
float depth = holographicDepth;
float noiseStrength = f2;
float diffractionScale = cos(AnimateTime * Mix2) * Mix3;
float phaseOffset = f4;
float colorShiftX = (saturate(dot(ViewDir, getNormal(depthMap, texCoord))) * 0.1 - 0.05) * f5;
float colorShiftY = (saturate(dot(HalfDir, getNormal(depthMap, texCoord))) * 0.1 - 0.05) * f5;
float intensity = dot(ViewDir, getNormal(depthMap, texCoord));
float3 normal = getNormal(depthMap, texCoord);MaterialSellmeier mat = CreateMaterial(MaterialIndex);
float3 path1 = texCoord.x * depth * mat.coherenceLengthM * mat.etaR;
float3 path2 = texCoord.y * depth * mat.coherenceLengthM * mat.etaI;
float3 pathDifference = path1 - path2;
float3 wavelengthsNM = float3(RGBToWavelengthsNM(diffuseMap.SampleLevel(sampleTypeLinear, texCoord, 0).xyz) * mat.coherenceLengthM);
float3 refractiveIndex = mat.etaR;
float3 opticalPhaseDifference = CalculateOpticalPhaseDifference(pathDifference, wavelengthsNM, refractiveIndex);
float2 inputUV = texCoord;
int dispersionIndex = 0;
float curvatureFactor = f9 * .01;
float centralWeight = f8;
float fresnelFactor = f4;
float angularFrequencyScalar = f5;
float time = AnimateTime;
float ct0 = cos(time);
bool invertDepth = !KeyQDown, useProjectedDepth = !KeyWDown;
float2 sz = GetSz(depthMap);
float2 oosz = 1.0 / sz;
int item = 1;
bool xrayMode = true;
int szScale = 50;
int2 cellSize = int2(szScale, szScale);
int colsPerRow = int(floor(uint(sz.x) / uint(cellSize.x)));
float2 uvI = float2((inputUV.x * float(sz.x) / float(cellSize.x)),(inputUV.y * float(sz.y) / float(cellSize.y)));
int2 uvIi = int2(uvI);
int hCount = int(floor(float(sz.x) / uint(cellSize.x)));
int vCount = int(floor(float(sz.y) / uint(cellSize.y)));
int uvCol = uvI.x;
int uvRow = uvI.y;
int ix = clamp(uvRow * colsPerRow + uvCol, 0.0, 61);
float2 adjustedUV = inputUV;
float3 viewPos = ViewPos;LightingComplex lightingComplex =PopulateLightingComplex(diffuseMap, adjustedUV, ViewPos, LightPos, !KeyQDown, !KeyWDown, DepthScale, mat, AnimateSpeed, ParallaxScale, NormalRadius, 0.5, dispersionIndex, Gamma, f9, 0.7);
float3 noise = (noise3(noiseMap1, float3(float2(texCoord.x, -texCoord.y), depth)) - 0.5) * noiseStrength * DepthScale;
float3 diffraction = SimulateDiffraction(texCoord, diffractionScale);
float3 totalPhase = opticalPhaseDifference * mat.coherenceLengthM * lightingComplex.albedoWavelengthsNM + (phaseOffset + diffraction * lightingComplex.diffuseReflectance.real +noise);
float3 interference = intensity * (1.0 + cos(totalPhase)) * 0.5;
float3 lighting = max(dot(normalize(normal), ViewDir), 0.0);
float red = interference.x * lighting.x * (1.0 + colorShiftX * texCoord.x);
float green = interference.y * lighting.y * (1.0 - colorShiftY * texCoord.y);
float blue = interference.z * lighting.z;
float3 finalColor = diffuse2D(diffuseMap, texCoord).xyz * float3(red, green, blue) * depth * lightingComplex.totalLighting[0];
return  float4(saturate(finalColor), 1);}psout PSoo(PS_INPUT input){psout output;InitPSOut(output, input.uv);
float3 normal;
float depth = depth2D(depthMap, input.uv, !KeyQDown, !KeyWDown);
float2 depthMod = GetModulation(GetGradient(input.uv));MaterialSellmeier mat = CreateMaterial(MaterialIndex);;
float3x3 tbn;normal = normalize(getNormal(depthMap, input.uv, tbn));
float3 viewPos = float3(ViewX, ViewY, ViewZ);;
float3 pixel = float3(input.uv, depth);
float3 lightPos = float3(SunX, SunY, SunZ);
float3 lightDir = normalize(lightPos - pixel);
float3 viewDir = normalize(viewPos - pixel);
float3 halfDir = normalize(lightDir + viewDir);
float3 diffuse = diffuse2D(diffuseMap, input.uv).xyz;
float3 wavelengthsNMf = RGBToWavelengthsNM(diffuse);
float2 sz = GetSz(depthMap);
float3 sceneColor = diffuse2D(diffuseMap, input.uv).rgb;
float oscillationAmplitude = f11 + cos(AnimateTime) * f10;depth *= mat.etaR.z * mat.coherenceLengthM;PathMeasurement pathMeasurement = DifferenceMPathFromPointThicknessM(CV0(viewPos), CV0(pixel), CV0(mat.thicknessM * mat.coherenceLengthM), normal);PathMeasurement pathMeasurement2 = DifferenceMPathFromPointThicknessM(CV0(lightPos), CV0(pixel), CV0(mat.thicknessM * mat.coherenceLengthM), normal);OpticalPathResult opdResInsideReal = OpticalPathDifference(CV0(wavelengthsNMf * mat.coherenceLengthM), mat.nSurrounding, pathMeasurement,mat.dispersionCoefficientsNm2[0],mat.absorptionCoefficient, dot(viewDir, normal));OpticalPathResult opdResInsideImag = OpticalPathDifference(CV0(wavelengthsNMf * mat.coherenceLengthM), mat.nSurrounding, pathMeasurement2,mat.dispersionCoefficientsNm2[0],mat.absorptionCoefficient, dot(viewDir, normal));output.rt1.xyz += PS_FullDepthNormalMichelsonInterferometer(float4(float2(input.uv.x, -input.uv.y), depth, 1), input.uv, depth).xyz;output.rt1.xyz = AdjustGammaf(output.rt1.xyz, Gamma);
return output;}
void FFT8(inout Complex3 data[8]){Complex3 temp[8];temp[0] = data[0];temp[1] = data[4];temp[2] = data[2];temp[3] = data[6];temp[4] = data[1];temp[5] = data[5];temp[6] = data[3];temp[7] = data[7];[unroll]
for (int i = 0; i < 8; i++)data[i] = temp[i];
for (int stage = 1; stage <= 3; stage++){
int groupSize = 1 << stage;
int halfSize = groupSize >> 1;
for (int k = 0; k < 8; k += groupSize){
for (int j = 0; j < halfSize; j++){
int idx1 = k + j;
int idx2 = idx1 + halfSize;
float angle = -TWO_PI * j / groupSize;Complex3 twiddle = ComplexExp(CV0(angle));Complex3 t = ComplexMul(data[idx2], twiddle);data[idx2] = ComplexAdd(data[idx1], ComplexMul(data[idx2], ComplexExp(CV0(-angle))));data[idx1] = ComplexAdd(data[idx1], t);}}}}
void FFT16(inout C3 data[16]){
static  const  uint rev[16] = { 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15 };C3 temp[16];[unroll(16)]
for (uint i = 0; i < 16; i++)temp[i] = data[rev[i]];[unroll(16)]
for (i = 0; i < 16; i++)data[i] = temp[i];[unroll(4)]
for (uint stage = 1; stage <= 4; stage++){
uint groupSize = 1 << stage;
uint halfSize = groupSize >> 1;[unroll(16)]
for (uint k = 0; k < 16; k += groupSize){[unroll]
for (uint j = 0; j < halfSize; j++){
uint idx1 = k + j;
uint idx2 = idx1 + halfSize;
float angle = -TWO_PI * float(j) / (float(groupSize) + EPSILON);C3 twiddle = CExp(CV0(angle));C3 t = CMul(data[idx2], twiddle);data[idx2] = CSub(data[idx1], t);data[idx1] = CAdd(data[idx1], t);}}}}
float SampleDepth(float2 uv){
float depth = depthMap.Sample(linearSampler, uv);
return clamp(depth * DepthScale, EPSILON, 1.0 - EPSILON);}
float3 FresnelSchlick(float cosTheta, float3 F0){
return F0 + (1.0 - F0) * pow(max(1.0 - cosTheta, 0), max(FresnelPower, EPSILON));}
float GGXDistribution(float NdotH, float roughness){
float alpha = roughness * roughness;
float alpha2 = alpha * alpha;
float denom = NdotH * NdotH * (alpha2 - 1.0) + 1.0;
return alpha2 / (PI * denom * denom);}
float GeometrySmith(float NdotV, float NdotL, float roughness){
float r = roughness + 1.0;
float k = (r * r) / 8.0;
float gv = NdotV / (NdotV * (1.0 - k) + k);
float gl = NdotL / (NdotL * (1.0 - k) + k);
return gv * gl;}
void FresnelPolarization(float cosThetaI, float3 n1, float3 n2, out  float3 Rs, out  float3 Rp){
float3 sinThetaI = sqrt(max(0.0, 1.0 - cosThetaI * cosThetaI));
float3 sinThetaT = n1 * sinThetaI / n2;
float3 cosThetaT = sqrt(max(0.0, 1.0 - sinThetaT * sinThetaT));
float3 numS = n1 * cosThetaI - n2 * cosThetaT;
float3 denS = n1 * cosThetaI + n2 * cosThetaT;Rs = (numS * numS) / (denS * denS + EPSILON);
float3 numP = n1 * cosThetaT - n2 * cosThetaI;
float3 denP = n1 * cosThetaT + n2 * cosThetaI;Rp = (numP * numP) / (denP * denP + EPSILON);}C3 ThinFilmInterference(float3 opd, float3 wavelengthsM, float3 nFilm){
float3 phase = TWO_PI * nFilm * opd / wavelengthsM;C3 interference;interference.real = cos(phase.x) + cos(phase.y) + cos(phase.z);interference.imag = sin(phase.x) + sin(phase.y) + sin(phase.z);
return interference;}
float3 ComputeInterference(float2 uv, MaterialSellmeier mat, float depth, float time){
float3 wavelengthsM = RGBToWavelengthsM(diffuseMap.SampleLevel(sampleTypeLinear, uv, 0).xyz);C3 cosThetaTR1;C3 f0 = FresnelReflectanceFromFilm2(mat.etaR, mat.nSurrounding, max(0, dot(ViewDir, Normal)), cosThetaTR1);
float3 opd = length(PixelPos - ViewPos) * mat.etaR * 2.0 * mat.thicknessM * mat.coherenceLengthM * cosThetaTR1.real;C3 field[16];[unroll]
for (int i = 0; i < 16; i++){
float t = time + i * 0.1;
float3 phase = (TWO_PI * opd) / wavelengthsM + float3(t, t * PI / 4.0, t * PI / 8.0);field[i].real = cos(phase[min(i / 5, 2)]);field[i].imag = sin(phase[min(i / 5, 2)]);}FFT16(field);
float3 coherence = exp(-abs(opd) / mat.coherenceLengthM);C3 thinFilm = ThinFilmInterference(opd, wavelengthsM, mat.etaR);
float3 interference = float3(length(CMag(CAdd(field[1], thinFilm))),length(CMag(CAdd(field[3], thinFilm))),length(CMag(CAdd(field[7], thinFilm)))) * coherence;
return interference;}psout PS(PS_INPUT input){psout output;InitPSOut(output, input.uv);
float2 uv = input.uv;
float depth = SampleDepth(uv);
float3 diffuse = diffuseMap.Sample(linearSampler, uv).rgb;
float3x3 tbn;
float3 normal = getNormal(depthMap, uv, tbn);
float3 pixelPos = float3(float2(uv.x, -uv.y), depth);
float3 viewDir = normalize(ViewPos - pixelPos);
float3 lightDir = normalize(LightPos - pixelPos);
float3 halfDir = normalize(viewDir + lightDir);
float NdotL = max(dot(normal, lightDir), 0.0);
float NdotV = max(dot(normal, viewDir), 0.0);
float NdotH = max(dot(normal, halfDir), 0.0);
float VdotH = max(dot(viewDir, halfDir), 0.0);MaterialSellmeier mat = CreateMaterial(MaterialIndex);
float3 F0 = lerp(float3(0.04, 0.04, 0.04), mat.albedo, mat.metallic);
float3 diffuseTerm = mat.albedo * NdotL / PI;
float3 fresnel = FresnelSchlick(VdotH, F0);
float D = GGXDistribution(NdotH, mat.roughness);
float G = GeometrySmith(NdotV, NdotL, mat.roughness);
float3 specularTerm = (D * G * fresnel) / max(4.0 * NdotV * NdotL, EPSILON);
float3 interference = ComputeInterference(uv, mat, depth, AnimateTime);
float3 lighting = saturate(diffuseTerm + specularTerm);
float3 finalColor = diffuse * lighting * interference;output.rt1 = float4(saturate(finalColor), 1.0);
return output;}