#define EPSILON 1e-10
#define EPSILON3 float3(EPSILON,EPSILON,EPSILON)


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
    float3 Position : POSITION;
    float2 uv : UV0;
};
#define clampEpsilon(x) clamp(x, EPSILON, 1.0-EPSILON)

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
#define linearSampler sampleTypeLinear

float3 calcNormal(Texture2D<float> depthMap, float2 uv)
{
    float2 oosz = GetOosz(depthMap);

    float depth = clampEpsilon(depthMap.SampleLevel(sampleTypeMirror,uv,0));
    float depthXR = clampEpsilon(depthMap.SampleLevel(sampleTypeMirror,uv+float2(oosz.x,0)*NormalRadius,0));
    float depthXL = clampEpsilon(depthMap.SampleLevel(sampleTypeMirror,uv-float2(oosz.x,0)*NormalRadius,0));
    float depthYU = clampEpsilon(depthMap.SampleLevel(sampleTypeMirror,uv-float2(0,oosz.y)*NormalRadius,0));
    float depthYD = clampEpsilon(depthMap.SampleLevel(sampleTypeMirror,uv+float2(0,oosz.y)*NormalRadius,0));
   
    float3 dx = float3(oosz.x, 0, depthXR - depthXL);
    float3 dy = float3(0, oosz.y, depthYD - depthYU);
    float3 normal = normalize(EPSILON3+cross(dx,dy) * 2.0 - 1.0);
 
    float k = aureateStep(saturate(dot(normal, normalize(float3(0,0,1)))), 0.8);
    float3 Nt = normalize(lerp(normal, reflect(normal, normalize(float3(0,0,1))), k));

    return normalize(cross(dx,dy));
}

float4 PS(PS_INPUT input) : SV_Target0
{
    return float4(saturate(calcNormal(depthMap, input.uv) * .5 + .5), 1.0);
}