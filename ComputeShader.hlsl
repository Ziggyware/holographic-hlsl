


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


// SM5.0: cs_5_0
// Bind: u0=Output, u1=Positions, u2=Velocities, t0=Depth, t1=Normal
RWTexture2D<float4> Output : register(u0);
RWStructuredBuffer<float2> Positions : register(u1);
RWStructuredBuffer<float2> Velocities : register(u2);
SamplerState LinearClamp : register(s0);

groupshared float2 s_Pos[64]; // 8x8 threadgroup ⊢
groupshared float s_Depth[64];

[numthreads(8,8,1)]
void CS(uint3 tid : SV_DispatchThreadID, uint3 gid : SV_GroupThreadID, uint lid : SV_GroupIndex)
{
    uint idx = tid.y * 32 + tid.x; // 32x32 grid from your C++ ⊢
    if(idx >= 1024) return;

    float2 pos = Positions[idx];
    float2 vel = Velocities[idx];

    // 1. Manual neighbor sampling instead of quadSwap ⊢
    int2 ipos = int2(pos * 1024); // assuming 1024x1024 texture
    float3 n00 = normalMap.Load(int3(ipos, 0));
    float3 n10 = normalMap.Load(int3(ipos + int2(1,0), 0));
    float3 n01 = normalMap.Load(int3(ipos + int2(0,1), 0));
    
	float3 nx1 = normalMap.Load(int3(ipos + int2( 1, 0),0));
float3 nx0 = normalMap.Load(int3(ipos + int2(-1, 0),0));

float3 ny1 = normalMap.Load(int3(ipos + int2(0,  1),0));
float3 ny0 = normalMap.Load(int3(ipos + int2(0, -1),0));

float3 lap =
    nx1 + nx0 +
    ny1 + ny0 -
    4.0 * n00;

	float h = depthMap.SampleLevel(sampleTypeLinear, pos, 0);

float hx =
    depthMap.SampleLevel(sampleTypeLinear, pos + f02, 0)
  - depthMap.SampleLevel(sampleTypeLinear, pos - f02, 0);

float hy =
    depthMap.SampleLevel(sampleTypeLinear, pos + f03, 0)
  - depthMap.SampleLevel(sampleTypeLinear, pos - f03, 0);

float2 grad = float2(hx, hy);
    // 2. Manual group reduction instead of WaveActiveSum ⊢
    float depth = depthMap.SampleLevel(sampleTypeLinear, pos, 0);

	float2 force = -grad;
    s_Pos[lid] = pos * depth;
    s_Depth[lid] = depth;
   

    // Reduce in shared mem - tree reduction
    [unroll]
    for(uint s = 32; s > 0; s >>= 1) {
		if(lid < s) {
            s_Pos[lid] += s_Pos[lid + s];
            s_Depth[lid] += s_Depth[lid + s];
        }
        
    }
    float2 mant = s_Pos[0] / s_Depth[0];

    // 4. Update
	vel += force * TotalTime*AnimateSpeed;
vel *= 0.995; // damping
pos += vel;

	GroupMemoryBarrierWithGroupSync();
    Positions[idx] = saturate(pos);
    Velocities[idx] = vel;
	GroupMemoryBarrierWithGroupSync();
    Output[tid.xy] = float4(mant.x, mant.y/127.0, lap.x, 1);
}