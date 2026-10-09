#define EPSILON 1e-6f
#define SIGMOID_NEAR .1
#define SIGMOID_FAR .9
#define vec4 float4
#define vec2 float2



cbuffer ConstantBuffer : register(b0)
{
    //Mouse position in UV coordinates. 0.5,0.5 is center screen
    float2 LOOK_AT;
    float2 LOOK_AT_DELTA;
    
    //Number of render passes
    float NumPasses;
    //Time for use in time related functions
    float TotalTime;
    //Scalar for the depth, default to 1.0
    float DepthScale;
    //Fresnel Power scalar, default to 1.0
    float FresnelPower;
    //Fresnel reflectance scalar. default to 1.0
    float FresnelReflectance;
    //Animation speed scalar. Default to 1.0
    float AnimateSpeed;
    //Shader alpha is set to 1.0 / PassNum
    float ShaderAlpha;
    //Mix of fresnel effect with diffuse effect, if needed
    float FresnelMix;
    //1 when control key is pressed, else 0
    float KeyControl;
    //1 when shift key is pressed, else 0
    float KeyShift;
    //1 when alt key is pressed, else 0
    float KeyAlt;
    //1 when left mouse button is pressed, else 0
    float LButton;
    //1 when right mouse button is pressed, else 0
    float RButton;
    //The current pass number, out of NumPasses total, starts at Zero
    float PassNum;
    //Specular power, default is 1.0
    float SpecularPower;
    //Specular intensity. default is 1.0
    float SpecularIntensity;
    //Radius to sample depthMap or normalMap when creating normals
    float normalRadius;
    //Mix1,2,3 are reserved for future use
    float HeightScale;
    float ViewZ;
    float SunZ;
    
    float MaterialIndex;
    float ParallaxScale;
    float ParallaxScaleOMD;
    float Mix3;
    
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


Texture2D diffuseMap : register(t0);
Texture2D<float> depthMap : register(t1);
Texture2D<float> gratingDepth1 : register(t2);
Texture2D<float> gratingDepth2 : register(t3);
Texture2D<float> gratingDepth3 : register(t4);
Texture2D<float> gratingDepth4 : register(t5);
Texture2D skylineMap : register(t6);
Texture2D rainbowMap2 : register(t7);
Texture2D gratingMap1 : register(t8);
Texture2D gratingMap2 : register(t9);
Texture2D gratingMap3 : register(t10);
Texture2D gratingMap4 : register(t11);
Texture2D gradient1 : register(t12);
Texture2D gradient2 : register(t13);
Texture2D gradient3 : register(t14);
Texture2D gradient4 : register(t15);
Texture2D<float3> noiseMap1 : register(t16);
Texture2D<float3> noiseMap2 : register(t17);
Texture2D<float3> noiseMap3 : register(t18);
Texture2D<float3> noiseMap4 : register(t19);

//Texture2D normalMap : register(t4);
Texture2D<float3> normalMap : register(t20);
Texture2D<float3> gratingNormal1 : register(t21);
Texture2D<float3> gratingNormal2 : register(t22);
Texture2D<float3> gratingNormal3 : register(t23);
Texture2D<float3> gratingNormal4 : register(t24);
//Texture2D normalMap2 : register(t5);
Texture2D rtMap1 : register(t25);
Texture2D rtMap2 : register(t26);
Texture2D rtMap3 : register(t27);
Texture2D rtMap4 : register(t28);
Texture2D rtMap5 : register(t29);
Texture2D rtMap6 : register(t30);
Texture2D rtMap7 : register(t31);
Texture2D rtMap8 : register(t32);
Texture2D rtMap9 : register(t33);
Texture2D rtMap10 : register(t34);
Texture2D rtMap11 : register(t35);
Texture2D rtMap12 : register(t36);
Texture2D rtMap13 : register(t37);
Texture2D rtMap14 : register(t38);
Texture2D rtMap15 : register(t39);
Texture2D rtMap16 : register(t40);
Texture2D computeMap : register(t41);

SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror2 : register(s1);
SamplerState sampleTypeMirror : register(s2);



struct VS_INPUT
{
    float3 Position : POSITION;
    float2 uv : TEXCOORD0;
};

struct PS_INPUT
{
    float4 Position : SV_Position;
    float2 uv : TEXCOORD0;
    float3 ViewDir : TEXCOORD1;
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

psout CreatePSOut(float2 uv)
{
    psout ret;
    if (PassNum == 0)
    {
        ret.rt1 = float4(0, 0, 0, 1);
        ret.rt2 = float4(0, 0, 0, 1);
        ret.rt3 = float4(0, 0, 0, 1);
        ret.rt4 = float4(0, 0, 0, 1);
        ret.rt5 = float4(0, 0, 0, 1);
        ret.rt6 = float4(0, 0, 0, 1);
        ret.rt7 = float4(0, 0, 0, 1);
        ret.rt8 = float4(0, 0, 0, 1);
    }
    else
    {
        ret.rt1 = rtMap1.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt2 = rtMap2.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt3 = rtMap3.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt4 = rtMap4.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt5 = rtMap5.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt6 = rtMap6.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt7 = rtMap7.SampleLevel(sampleTypeMirror, uv, 0);
        ret.rt8 = rtMap8.SampleLevel(sampleTypeMirror, uv, 0);
    }
    return ret;
}

inline float ClampEpsilon(float v)
{
    return clamp(v, EPSILON, 1 - EPSILON);
}
float SampleDepth(float2 oosz, Texture2D<float> tex, float2 uv, bool flipDepth, float depthScale, bool scale)
{
    float d = tex.SampleLevel(sampleTypeMirror, uv, 0).r;
    d = flipDepth ? (1 - d) : d;
    d = ClampEpsilon(d);
    return scale ? (depthScale * d) : d;
}

// Compute depth values in X, L, R, U, and D directions
void GetXLRUDDepths(float2 oosz, Texture2D<float> tex, float2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale, out float X, out float L, out float R, out float U, out float D)
{
    float2 offsetX = oosz * float2(range, 0) * depthGradient;
    float2 offsetY = oosz * float2(0, range) * depthGradient;

    X = SampleDepth(oosz, tex, uv, flipDepth, depthScale, scale);
    L = SampleDepth(oosz, tex, uv - offsetX, flipDepth, depthScale, scale);
    R = SampleDepth(oosz, tex, uv + offsetX, flipDepth, depthScale, scale);
    U = SampleDepth(oosz, tex, uv - offsetY, flipDepth, depthScale, scale);
    D = SampleDepth(oosz, tex, uv + offsetY, flipDepth, depthScale, scale);
}
// Compute average depth value using X, L, R, U, and D samples
float GetAverageDepth(float X, float L, float R, float U, float D)
{
    return (X + L + R + U + D) * 0.2f;
}

// Compute depth gradients
float2 GetGradient(float2 oosz, Texture2D<float> tex, float2 uv, float range, bool flipDepth, bool scale, float depthScale)
{
    float X, L, R, U, D;
    GetXLRUDDepths(oosz, tex, uv, range, float2(1, 1), flipDepth, scale, depthScale, X, L, R, U, D);

    float dX = R - L;
    float dY = D - U;

    return float2(dX, dY);
}

// Compute sigmoid function
float Sigmoid(float x, float steepness)
{
    return 2.0f / (1.0f + exp(-2.0f * steepness * x)) - 1.0f;
}

// Remap a value from one range to another
float Remap(float value, float inMin, float inMax, float outMin, float outMax, float outOffset, float outScale)
{
    float remapped = outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
    return (remapped + outOffset) * outScale;
}

// Compute smoothed sigmoid function with near and far values
float SmoothSigmoid(float x, float steepness, float nearValue, float farValue, float offset, float scale)
{
    float normalized = Sigmoid(x, steepness);
    return Remap(normalized, -1.0f, 1.0f, nearValue, farValue, offset, scale);
}

// Compute smoothed sigmoid function using default near and far values
float SmoothSigmoid(float x, float steepness)
{
    return SmoothSigmoid(x, steepness, SIGMOID_NEAR, SIGMOID_FAR, 0, 1);
}

// Compute modulation based on depth gradient and depth curve
float2 GetModulation(float2 depthGradient, float2 depthCurve)
{
    return float2(SmoothSigmoid(depthGradient.y, depthCurve.x),
                  SmoothSigmoid(depthGradient.x, depthCurve.y));
}

// Compute average gradient magnitude
float ComputeAverageGradientMagnitude(float2 oosz, Texture2D<float> depthMap, float2 uv, float radius, bool flipDepth, bool scale, float depthScale, float sigma = 3.0f)
{
    float totalMagnitude = 0.0f;
    float totalWeight = 0;
    int kernelRadius = max(1, (int) (radius - 1) / 2);
    int step = max(1, (int) (radius / 4));

    [unroll(10)]
    for (int i = -kernelRadius; i <= kernelRadius; i += step)
    {
        [unroll(10)]
        for (int j = -kernelRadius; j <= kernelRadius; j += step)
        {
            if (i == 0 || j == 0)
                continue;

            float dist = sqrt(i * i + j * j);
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            totalMagnitude += length(GetGradient(oosz, depthMap, uv + float2(i, j) * oosz, radius, flipDepth, scale, depthScale)) * weight;
            totalWeight += weight;
        }
    }

    return totalMagnitude / totalWeight;
}

// Select sigmoid steepness based on average gradient magnitude
float SelectSigmoidSteepness(float averageGradientMagnitude, float2 steepnessMinMax)
{
    float normalizedMagnitude = saturate(averageGradientMagnitude);
    return lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude);
}

// Adjust steepness based on gradient magnitude
float AdjustSteepness(float steepness, float gradientMagnitude, float threshold, float maxAdjustment)
{
    if (gradientMagnitude > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude - threshold) / maxAdjustment, 1.0f);
        return steepness * adjustmentFactor;
    }
    return steepness;
}
// Compute adjusted depth curve
float2 ComputeAdjustedDepthCurve(float2 oosz, Texture2D<float> depthTex, float2 uv, bool flipDepth, bool scale, float depthScale)
{
    float2 steepnessMinMax = float2(SIGMOID_NEAR, SIGMOID_FAR);
    float averageGradientMagnitude = ComputeAverageGradientMagnitude(oosz, depthTex, uv, normalRadius, flipDepth, scale, depthScale);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);

    float2 gradient = GetGradient(oosz, depthTex, uv, normalRadius, flipDepth, scale, depthScale);
    gradient = float2(SmoothSigmoid(gradient.x, steepnessMinMax.y), SmoothSigmoid(gradient.y, steepnessMinMax.y));

    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);

    return float2(SmoothSigmoid(gradient.x, adjustedSteepness),
                  SmoothSigmoid(gradient.y, adjustedSteepness));
}


// Get normal from depth map
float3 GetNormal(float2 oosz, float2 uv, float dist)
{
    bool flipDepth = true;
    bool scaleDepth = true;
    float depthScale = DepthScale;

    float2 gradient = GetGradient(oosz, depthMap, uv, dist, flipDepth, scaleDepth, depthScale);
    float2 depthCurve = ComputeAdjustedDepthCurve(oosz, depthMap, uv, flipDepth, scaleDepth, depthScale);
    float2 modulation = GetModulation(gradient, depthCurve);

    float X, L, R, U, D;
    GetXLRUDDepths(oosz, depthMap, uv, dist, gradient, flipDepth, scaleDepth, depthScale, X, L, R, U, D);
    float centerDepth = GetAverageDepth(X, L, R, U, D);

    float2 tex1 = uv - float2(oosz.x, 0) * dist * modulation.x;
    float2 tex2 = uv - float2(0, oosz.y) * dist * modulation.y;

    GetXLRUDDepths(oosz, depthMap, tex1, dist, gradient, flipDepth, scaleDepth, depthScale, X, L, R, U, D);
    float xDepth = GetAverageDepth(X, L, R, U, D);

    GetXLRUDDepths(oosz, depthMap, tex2, dist, gradient, flipDepth, scaleDepth, depthScale, X, L, R, U, D);
    float yDepth = GetAverageDepth(X, L, R, U, D);

    float3 centerPos = float3(uv, centerDepth);
    float3 xPos = float3(tex1, xDepth);
    float3 yPos = float3(tex2, yDepth);

    float3 viewNormal = normalize(cross(yPos - centerPos, xPos - centerPos));

    return viewNormal * float3(1, 1, -1);
}


psout PS(PS_INPUT input)
{
    psout ret = CreatePSOut(input.uv);
    
    int2 sz;
    depthMap.GetDimensions(sz.x, sz.y);
    float2 oosz = 1.0f / sz;
   
    ret.rt2 = float4(GetNormal(oosz, input.uv, normalRadius), 1);
    ret.rt1 = float4(ret.rt2.xyz, 1);
   
    return ret;
}