
#define SCATTER_NUM_STEPS 3
#define ILLUMINATE_NUM_RAYS 7
#define ILLUMINATE_RAY_LENGTH 25
#define MAX_SPIN 3.14159265/2

#define MAX_DEPTH 25

#define SCREEN_REGIONS_X 2
#define SCREEN_REGIONS_Y 2

#define MAX_LIGHTS 4

#define NORMAL_SAMPLE_RADIUS 12
#define OCCLUSION_MIN_DIFFERENCE 0.05

#define MAX_SPIN 1
#define ViewportWidth 1024
#define ViewportHeight 970
#define PI 3.14159265358979
#define MATH_E 2.71828
#define timr (AnimateSpeed)
#define OCCLUSION_MIN_DIFFERENCE 0.001
#define texture2D(x, uv) x.Sample(sampleTypeMirror, uv)
#define vec2 float2 
#define vec3 float3 
#define vec4 float4
#define ivec2 int2
#define clamp011(x) clamp(x, epsilon, (1-epsilon))
#define clamp012(x) clamp(x, vec2(epsilon, epsilon), vec2((1-epsilon), (1-epsilon)))
#define clamp013(x) clamp(x, vec3(epsilon, epsilon, epsilon), vec3((1-epsilon), (1-epsilon), (1-epsilon)))
#define clamp014(x) clamp(x, vec4(epsilon, epsilon, epsilon, epsilon), vec4((1-epsilon), (1-epsilon), (1-epsilon), (1-epsilon)))
#define ENABLE_CHROM_ABERR epsilon
#define ENABLE_RED_BLUE_DEPTH 0x0002
#define ENABLE_CHROMATIC_ABERRATION 0x0004
#define ENABLE_LIGHTING_CALCULATION 0x0008
#define ENABLE_ROTATE_HUE 0x0010
#define ENABLE_BLOOM 0x0020
#define ENABLE_TRIP_BLUR 0x0040
#define MATH_E 2.71828
#define max2(x, y) vec2(max(x.x,y.x),max(x.y,y.y))
#define max3(x, y) vec3(max(x.x,y.x),max(x.y,y.y),max(x.z,y.z))
#define max4(a, b) vec4(max(a.x,b.x),max(a.y,b.y),max(a.z,b.z),max(a.w,b.w))
#define max43(a) max(max(a.x, a.y), a.z)
#define max44(a) max(max(max(a.x, a.y), a.z), a.w)
#define max33(a) max(max(a.x, a.y), a.z)
#define noise Noise
#define NUM_LAYERS 6
#define tex2D mir2D


static const float epsilon = 1e-6;
inline float ClampEpsilon(float v)
{
    return clamp(v, epsilon, 1 - epsilon);
}
inline float2 ClampEpsilon(float2 v)
{
    return clamp(v, epsilon, 1 - epsilon);
}
inline float3 ClampEpsilon(float3 v)
{
    return clamp(v, epsilon, 1 - epsilon);
}
inline float4 ClampEpsilon(float4 v)
{
    return clamp(v, epsilon, 1 - epsilon);
}
inline float ClampEpsilon11(float v)
{
    return clamp(v, epsilon - 1, 1 - epsilon);
}
inline float2 ClampEpsilon11(float2 v)
{
    return clamp(v, epsilon - 1, 1 - epsilon);
}
inline float3 ClampEpsilon11(float3 v)
{
    return clamp(v, epsilon - 1, 1 - epsilon);
}
inline float4 ClampEpsilon11(float4 v)
{
    return clamp(v, epsilon - 1, 1 - epsilon);
}


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

cbuffer ScreenSizeBuffer : register(b0)
{
    
    float2 LookAt;
    float2 LookAtDelta;
    
    float FrameTime;
    float TotalTime;
    float DepthScale;
    float DepthMode;
    
    float SceneAlpha;
    float SceneAlphaMul;
    float ShaderAlpha;
    float HueColorMix;
    
 
};

struct VS_INPUT
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

struct PS_INPUT
{
    float4 Position : SV_POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Color : COLOR0;
};
SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);

Texture2D diffuseMap : register(t0);
Texture2D depthMap : register(t1);
Texture2D rainbowMap : register(t2);
Texture2D rainbowMap2 : register(t3);
Texture2D lightingMap1 : register(t4);
Texture2D lightingDepthMap1 : register(t5);
Texture2D depthStencilMap : register(t6);

float sinTime01(float timeMul)
{
    return ((1 + sin(TotalTime * timeMul)) / 2);
}
float cosTime01(float timeMul)
{
    return ((1 + cos(TotalTime * timeMul)) / 2);
}
float cosTime01cos01(float timeMul, float timeMul2)
{
    return ((1 + cos(TotalTime * timeMul * cosTime01(TotalTime * timeMul2))) / 2);
}

float4 CalculateDepthDensityColors(
    float2 texCoord,
    float threshold, float curveExponent,
    float4 depthCross, float4 depthNormal)
{
    float milr = min(depthCross.x, depthCross.y);
    float miud = min(depthCross.z, depthCross.w);
    float micl = min(depthCross.x, depthNormal.w);
    float micr = min(depthCross.z, depthNormal.y);
    float ma = max(milr, depthNormal.w);
    float mb = max(miud, depthNormal.w);
    float mc = max(micl, depthNormal.w);
    float md = max(micr, depthNormal.w);
    if (milr + miud + micl + micr > threshold)
    {
        return pow(10000000000 +
            100000 + (ma * 0.5 * (-0.000032 + (cos(TotalTime * 0.05) * 0.00212)) + mb * 20 +
                micl * 0.0024 +
                md * (0.0012 + (cos(TotalTime * 0.032342) * 30.12015))),
                (milr * (0.031 + -(atan(TotalTime * 10.00010341) * 0.00004141)) +
                miud * (-0.011 + (sin(TotalTime * 0.000313) * -0.152)) + mc * 2 - micr)
        );
    }
    else
    {
    
        return pow(
           0.00000023343433 + (ma * 2.5 * (240.32 + (cos(TotalTime * -10.02) * 0.2)) + mb * -320 +
                micl * -2 +
                md * (-10.002 + (cos(TotalTime * -10.22) * 220.5))),
                (milr * (-30.31 + (atan(TotalTime * -0.03) * 123.41)) +
                miud * (-23000.21 + (sin(FrameTime * -30.3) * -1)) + mc * -
32 - micr)
        );
    }
};



// Struct for Configurable Values in Gradient Modulation
struct GradientModulationConfig
{
    float timeFactor; // Range: 0.0 to infinity
    bool flipDepth;
    bool scaleDepth;
    
    float4 depthCross;
    float depthRange;
    
    float depthScale;
    float2 uv0;
    float2 uv;
    
    int2 isz;
    float2 oosz;
    float2 ooszd;
    float2 ooszrt;
    
    float3 sunPos;
    float3 pixelToSunSegment;
    float3 pixel0ToSunSegment;
    float3 pixelToSunDir;
    float3 pixel0ToSunDir;
    float3 pixelScaled;
    float3 pixel0Scaled;
    float3 sunHalfVec;
    
    float3 viewPos;
    float3 viewPos0;
    float3 viewDir;
    float3 viewDir0;
    float4 diffuse;
    float4 diffuse0;
    
    float centerDist0;
    float centerDist;
    
    float3 reflectDir;
    float reflectFactor;
    
    
    float NdotV;
    float NdotL;
    float HdotV;
    float NdotH;
    float VdotL;
    float2 gradient;
    float2 modulation;
    float depth;
    float invDepth;
    float3 normal;
    float2 depthCurve;
    
    float2 gradient0;
    float2 modulation0;
    float depth0;
    float3 normal0;
    float2 depthCurve0;
    
};

static GradientModulationConfig config;

float3 CalculateDepthNormalV1(float4 depthCross)
{
    float l = depthCross.x;
    float r = depthCross.y;
    float u = depthCross.z;
    float d = depthCross.w;

    float3 du = float3(1, 0, (r - l) * 0.5);
    float3 dv = float3(0, 1, (u - d) * 0.5);

    float3 normal = cross(du, dv);
    return normalize(normal);
}

float3 CalculateDepthNormalV2(float4 dc, float c)
{
    float l = dc.x;
    float r = dc.y;
    float u = dc.z;
    float d = dc.w;
    
    float3 normal;
    normal = cross(
        normalize(float3((r - c), 1, (d - c))),
        normalize(float3(-1, (u - c), (l - c))));
    
    // You can modify this value based on the relative scale of depth

    return normalize(normal);
}

float3 CalculateDepthNormalV3(float4 depthCross)
{
    float l = depthCross.x;
    float r = depthCross.y;
    float u = depthCross.z;
    float d = depthCross.w;

    float3 normal;
    normal.x = (r - l) * 0.5;
    normal.y = (u - d) * 0.5;
    normal.z = 1.0; // Adjust based on the scale of your depth

    return normalize(normal);
}

float3 CalculateDepthNormal2(float4 depthCross)
{
    float l = depthCross.x;
    float r = depthCross.y;
    float u = depthCross.z;
    float d = depthCross.w;
    
    float3 vd = normalize(float3(u, r, 0));
    float3 vu = normalize(float3(0, l, u - d));
    float3 vl = normalize(float3(r - l, u, 0));
    float3 vr = normalize(float3(0, d - u, l - r));
    return normalize(cross(normalize(cross(vu, vd)), normalize(cross(vr, vl))));
};


float3 CalculateDepthNormalV4(float depthMatrix[3][3])
{
    float3 normal;
    normal.x = (depthMatrix[0][2] + 2 * depthMatrix[1][2] + depthMatrix[2][2]) -
               (depthMatrix[0][0] + 2 * depthMatrix[1][0] + depthMatrix[2][0]);
    normal.y = (depthMatrix[0][0] + 2 * depthMatrix[0][1] + depthMatrix[0][2]) -
               (depthMatrix[2][0] + 2 * depthMatrix[2][1] + depthMatrix[2][2]);
    normal.z = 1.0;
    return normalize(normal);
}


float3 CalculateDepthNormalV6(float4 depthCross, float4 depthNormal)
{
    float c = depthNormal.w;
    float l = depthCross.x;
    float r = depthCross.y;
    float u = depthCross.z;
    float d = depthCross.w;

    float3 tangentX = float3(1, 0, r - l);
    float3 tangentY = float3(0, 1, u - d);

    float3 normal = cross(tangentX, tangentY);
    return normalize(normal);
}

float3 CalculateDepthNormalUnrolled(int2 sz, int3 iuv)
{
    float depthMatrix[3][3];
    depthMatrix[0][0] = depthMap.Load(iuv, -int2(1, 1)).r;
    depthMatrix[0][1] = depthMap.Load(iuv, int2(0, -1)).r;
    depthMatrix[0][2] = depthMap.Load(iuv, int2(1, -1)).r;
    depthMatrix[1][0] = depthMap.Load(iuv, int2(-1, 0)).r;
    depthMatrix[1][1] = depthMap.Load(iuv, int2(0, 0)).r;
    depthMatrix[1][2] = depthMap.Load(iuv, int2(1, 0)).r;
    depthMatrix[2][0] = depthMap.Load(iuv, int2(-1, 1)).r;
    depthMatrix[2][1] = depthMap.Load(iuv, int2(0, 1)).r;
    depthMatrix[2][2] = depthMap.Load(iuv, int2(1, 1)).r;
    
    // Use one of the methods to calculate the normal
    return CalculateDepthNormalV4(depthMatrix);
}

float3 CalculateDepthNormalWithKernel(int3 iuv)
{
    const float kernel[] =
    {
        { 0.0625, 0.125, 0.0625 },
        { 0.125, 0.25, 0.125 },
        { 0.0625, 0.125, 0.0625 }
    };
    
    const int2 offsets[9] =
    {
        int2(-1, -1), int2(0, -1), int2(1, -1),
        int2(-1, 0), int2(0, 0), int2(1, 0),
        int2(-1, 1), int2(0, 1), int2(1, 1)
    };

    float3 normal = float3(0, 0, 0);
    for (int i = 0; i < 9; i++)
    {
        normal += float3(offsets[i].x, offsets[i].y,
            depthMap.Load(iuv, offsets[i]).r) * kernel[i];
    }

    return normalize(normal.rgb);
}


float3 CalculateDepthNormalWithKernel2(int3 iuv)
{
    const float kernel[] =
    {
        { 0.0125, 0.125, 0.0125 },
        { 0.125, 0.25, 0.125 },
        { 0.0125, 0.125, 0.0125 }
    };
    
    const int2 offsets[9] =
    {
        -int2(1, 1), int2(0, -1), int2(1, 1),
        int2(-1, 0), int2(0, 0), int2(1, 0),
        -int2(1, 1), int2(0, 1), int2(1, 1)
    };
    float3 normal = float3(0, 0, 0);
    [unroll]
    for (int i = 0; i < 9; i++)
    {
        normal += depthMap.Load(iuv, offsets[i]).r * kernel[i];
    }

    return normalize(normal);
}

float3 RotateAroundAxis(float3 v, float3 axis, float angle)
{
    // Normalize the axis
    axis = normalize(axis);

    // Compute the cosine and sine of the angle
    float c = cos(angle);
    float s = sin(angle);

    // Compute the rotation matrix
    float3x3 R;
    R[0][0] = c + (1 - c) * axis.x * axis.x;
    R[0][1] = (1 - c) * axis.x * axis.y - s * axis.z;
    R[0][2] = (1 - c) * axis.x * axis.z + s * axis.y;

    R[1][0] = (1 - c) * axis.y * axis.x + s * axis.z;
    R[1][1] = c + (1 - c) * axis.y * axis.y;
    R[1][2] = (1 - c) * axis.y * axis.z - s * axis.x;

    R[2][0] = (1 - c) * axis.z * axis.x - s * axis.y;
    R[2][1] = (1 - c) * axis.z * axis.y + s * axis.x;
    R[2][2] = c + (1 - c) * axis.z * axis.z;

    // Multiply the vector by the rotation matrix
    return mul(R, v);
}
float3 HSVtoRGB(float3 hsv)
{
    float h = hsv.x;
    float s = hsv.y;
    float v = hsv.z;

    if (s == 0.0f)
        return float3(v, v, v);

    h /= 60.0f;
    int i = floor(h);
    float f = h - float(i);
    float p = v * (1.0f - s);
    float q = v * (1.0f - s * f);
    float t = v * (1.0f - s * (1.0f - f));

    if (i == 0)
        return float3(v, t, p);
    if (i == 1)
        return float3(q, v, p);
    if (i == 2)
        return float3(p, v, t);
    if (i == 3)
        return float3(p, q, v);
    if (i == 4)
        return float3(t, p, v);

    return float3(v, p, q);
}

float3 RGBToYIQ(float3 rgb)
{
    float3x3 yiqMatrix = float3x3(
        0.299, 0.587, 0.114,
        0.596, -0.274, -0.322,
        0.211, -0.523, 0.312
    );
    return mul(yiqMatrix, rgb);
}
float3 YIQtoRGB(float3 yiq)
{
    float3x3 rgbMatrix = float3x3(
        1.0, 0.956, 0.621,
        1.0, -0.272, -0.647,
        1.0, -1.106, 1.703
    );
    return mul(rgbMatrix, yiq);
}

// Function to convert RGB to HSV
float3 RGBtoHSV(float3 rgb)
{
    float maxVal = max(rgb.r, max(rgb.g, rgb.b));
    float minVal = min(rgb.r, min(rgb.g, rgb.b));
    float delta = maxVal - minVal;

    float h = 0.0f;
    float s = (maxVal == 0.0f) ? 0.0f : (delta / maxVal);
    float v = maxVal;

    if (delta != 0.0f)
    {
        if (rgb.r == maxVal)
            h = (rgb.g - rgb.b) / delta;
        else if (rgb.g == maxVal)
            h = 2.0f + (rgb.b - rgb.r) / delta;
        else
            h = 4.0f + (rgb.r - rgb.g) / delta;

        h *= 60.0f;
        if (h < 0.0f)
            h += 360.0f;
    }

    return float3(h, s, v);
}

float3 RotateAroundX(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(v.x, c * v.y - s * v.z, s * v.y + c * v.z);
}
float3 RotateAroundY(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(c * v.x + s * v.z, v.y, -s * v.x + c * v.z);
}
float3 RotateAroundZ(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(c * v.x - s * v.y, s * v.x + c * v.y, v.z);
}

float3 RotateYIQ(float3 yiq, float angle)
{
    // Perform some YIQ manipulation - for example, rotate the color in YIQ space
    float c = cos(angle);
    float s = sin(angle);
    yiq.yz = float2(c * yiq.y - s * yiq.z, s * yiq.y + c * yiq.z);
    return yiq;
}


// Function to perform hue rotation
float3 RotateHue(float3 colorRGB, float angle)
{
    float3 hsv = RGBtoHSV(colorRGB); // Convert to HSV
    hsv.x += angle; // Rotate the hue
    hsv.x = fmod(hsv.x, 360.0f); // Wrap the hue if it goes out of bounds
    return HSVtoRGB(hsv); // Convert back to RGB
}

float3 FresnelSchlick(float3 F0, float3 V, float3 N, float fresnelPower = 5.0)
{
    float cosTheta = dot(V, N);
    return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
}
float3 FresnelSchlick2(float3 F0, float3 V, float3 N, float fresnelPower)
{
    float cosTheta = dot(V, N);
    return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
}

float4 FresnelSchlick4(float4 F0, float4 V, float4 N, float fresnelPower)
{
    float cosTheta = dot(V, N);
    return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
}



float4 CalculateDepthDensity(
    int depthMode, float2 uv, float3 viewDir,
    float threshold, float curveExponent,
    float4 depthCross, float4 depthNormal)
{
    const float depth = depthNormal.w;
    float4 variance = float4(
        (depthCross.x - depth),
        (depthCross.y - depth),
        (depthCross.z - depth),
        (depthCross.w - depth));
    float4 varianceABS = float4(
        abs(depthCross.x - depth),
        abs(depthCross.y - depth),
        abs(depthCross.z - depth),
        abs(depthCross.w - depth));
    
    float sum = variance.x + variance.y + variance.z + variance.w;
    float sumABS = varianceABS.x + varianceABS.y + varianceABS.z + varianceABS.w;
    float4 lt = float4(
        variance.x < 0 ? 1 : 0,
        variance.y < 0 ? 1 : 0,
        variance.z < 0 ? 1 : 0,
        variance.w < 0 ? 1 : 0);
    float sumNeg = lt.x + lt.y + lt.z + lt.w;
    
    float3 f = normalize(FresnelSchlick2(
        sumNeg > threshold ? pow(sumNeg, curveExponent) : sumNeg,
        viewDir, depthNormal.xyz, 5));
    float3 f2 = FresnelSchlick2(f, viewDir, depthNormal.xyz, 5);
    /*
    int ix = (uv.x / SCREEN_REGIONS_X) + (uv.y / SCREEN_REGIONS_Y) * SCREEN_REGIONS_X;
    
    for (int x = 0; x < MAX_LIGHTS; x++)
    {
        Light l = lights[x];
        if (l.RegionIndex == ix)
        {
        }
    }
    */
    return lt;
    
}
float3 CalcNormals(int depthMode, float2 texCoord, float2 texelSize, float3 curPixel,
    float3 viewDir, float3 normal, float4 LRUD, float4 dn, float reflectMix, float yiqMix)
{
    
    float4 density = CalculateDepthDensity(depthMode, texCoord, viewDir, 0, 200, LRUD, dn);
    
    float3 f1 = FresnelSchlick2(normalize(density.xyz), viewDir, normal, 5);
    return f1;
    float3 fresnel2 = FresnelSchlick(normalize(f1), viewDir, dn.xyz, 12);
    float3 fresnel3 = FresnelSchlick(fresnel2, viewDir, dn.
    xyz, 15);
    float3 fresnel4 = FresnelSchlick(reflect(normalize(-fresnel2), viewDir), viewDir, dn.xyz, 1000);
    float3 dX2 = float3(1.0, 0.0, ddx(fresnel4.x));
    float3 dY2 = float3(0.0, 1.0, ddy(fresnel4.y));
	
	// Compute the cross product to get the normal
    float3 fresNormal = normalize(cross(normalize(dX2), normalize(dY2)));
    fresNormal = float3(fresNormal.x, fresNormal.y, -abs(fresNormal.z));
	
    float3 distortedReflectionDir = reflect(FresnelSchlick(fresNormal,
        -reflect(-viewDir, normal), normal), viewDir).xyz;
	
    float3 v = diffuseMap.Sample(sampleTypeLinear,
        texCoord + reflect(viewDir, distortedReflectionDir).xy * 10 * texelSize).xyz;
	
    float3 yiq = RGBToYIQ(curPixel);
    float3 rgb = YIQtoRGB(RotateAroundAxis(yiq, distortedReflectionDir, TotalTime * 0.5));
    return float3(LRUD.x - dn.x, LRUD.y - dn.y, LRUD.z - dn.z) *
		 (1 - normalize(density)).xyz;
}

float LightFalloff(float distance, float radius, float exponent)
{
    float falloff = pow(1.0 - clamp(distance / radius, 0.0, 1.0), exponent);
    return falloff;
}


struct Light
{
    float GetRefractionIncident(float3 position, float3 viewDir, float3 pixelPos)
    {
        return dot(viewDir, normalize(position.xyz - pixelPos));
    }
    float3 GetRefractionAmount(float3 viewDir, float3 pixelPos, float3 normal, float rfi)
    {
        return refract(-normal, normalize(pixelPos + viewDir), rfi);
    }
    
    float3 GetRefractionVector(float3 position, float3 viewDir, float3 pixelPos, float3 normal)
    {
        // Get the refraction incident angle
        float rfi = GetRefractionIncident(position, viewDir, pixelPos);

        // Calculate and return the refraction vector
        return GetRefractionAmount(viewDir, pixelPos, normal, rfi);
    }
    
    float3 ComputeColorWithRefraction(float diffuseColor, float3 refractionVector)
    {
        return RotateHue(diffuseColor, sin(refractionVector.z));
    }

    
    float3 GetFresnelSchlick(float3 position, float3 viewDir,
        float3 pixelPos, float3 normal, float fresnelPower)
    {
        float rfi = GetRefractionIncident(position, viewDir, pixelPos);
        return FresnelSchlick2(rfi, viewDir, normal, fresnelPower);
    }
    
    float FresnelSchlick(float rfi, float3 viewDir, float3 normal, float fresnelPower)
    {
        float f0 = (1 - rfi) / (1 + rfi);
        f0 = f0 * f0;
    
        float cosTheta = max(dot(viewDir, normal), 0.0);

        return f0 + (1 - f0) * pow(1 - cosTheta, fresnelPower);
    }
};


float4 GetDepthCrossLRUD(int3 iuv, int sampleRadius)
{
    return float4(
        depthMap.Load(iuv, int2(-sampleRadius, 0)).r,
        depthMap.Load(iuv, int2(sampleRadius, 0)).r,
        depthMap.Load(iuv, int2(0, -sampleRadius)).r,
        depthMap.Load(iuv, int2(0, sampleRadius)).r);
}

struct LightCast
{
    Light Source;
    float DiffuseComponent;
    
    float RefractionIncidentAngle;
    float3 FresnelTerm;
    
    float4 Diffuse;
    float3 LightAmount;
    float3 LightColor;
    float4 TotalLightCast;
    float3 RefractionAmount;
    float3 RotatedLight;
    float4 Scattering;
    
    
};



float3 FresnelSchlick(float3 F0, float3 H, float3 N, float3 V)
{
    float cosTheta = saturate(dot(V, H));
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, 5.0);
}

float GeometrySchlickGGX(float NdotV, float k)
{
    return NdotV / (NdotV * (1.0 - k) + k);
}

float GeometrySmith(float3 N, float3 V, float3 L, float alpha)
{
    float k = alpha * alpha * 0.5;
    float NdotV = saturate(dot(N, V));
    float NdotL = saturate(dot(N, L));
    return GeometrySchlickGGX(NdotV, k) * GeometrySchlickGGX(NdotL, k);
}


struct Camera
{
    float3 Position;
    float3 Direction;
    float3 PixelDir;
};


struct Scene
{
    int DepthMode;
    PS_INPUT Input;
    Camera View;
    
    float2 ScreenSize;
    float2 TexelSize;
    float2 UV;
    float3 PixelPos;
    float4 OcclusionsLRUD;
    float OcclusionAmount;
    float4 DepthLRUD;
    float Depth;
    float3 Normal;
    float4 DN;
    float4 DiffuseColor;
    float Thickness;
    float Concentration;
    float4 AmbientColor;
    
    
};
float4 GetDepthNormalGradient(int depthMode, float2 texCoord, float scale, float sampleRadius)
{
    float w, h;
    depthMap.GetDimensions(w, h);

    // Define offsets for the 8 surrounding points in texture space
    const float2 offsets[8] =
    {
        float2(-1, -1), float2(0, -1), float2(1, -1),
            float2(-1, 0), float2(1, 0),
            float2(-1, 1), float2(0, 1), float2(1, 1)
    };

    // Sample the 8 surrounding depths
    float depths[8];
    for (int i = 0; i < 8; ++i)
    {
        float2 offsetTexCoord = texCoord + offsets[i] * (sampleRadius / float2(w, h));
        depths[i] = depthMap.Load(
            int3(offsetTexCoord.x * w, offsetTexCoord.y * h, 0)).r;
    }

    // Calculate the central depth
    float centralDepth = depthMap.Load(int3(texCoord.x * w, texCoord.y * h, 0)).r;

    // Calculate gradients using central differences
    float gradientX = (depths[2] + 2 * depths[4] + depths[7]) - (depths[0] + 2 * depths[3] + depths[5]);
    float gradientY = (depths[5] + 2 * depths[6] + depths[7]) - (depths[0] + 2 * depths[1] + depths[2]);

    // Normalize the gradients
    gradientX /= 4 * sampleRadius;
    gradientY /= 4 * sampleRadius;

    // Compute the normal using the gradients
    float3 normal = normalize(float3(gradientX, gradientY, scale));
    
    normal = float3(normal.x, normal.y, normal.z);
    
    return float4(normal, centralDepth);
}

    



    

struct SceneManager
{
    
    
    void Create(int depthMode, out Scene scene,
        PS_INPUT input)
    {
        
        scene.DepthMode = depthMode;
        scene.Input = input;
        float3 viewPos = float3(0, 0, 1200);
        scene.View.Position = viewPos;
        float3 viewDir = float3(0, 0, -1);
        scene.View.Direction = viewDir;
        
        float w, h;
        depthMap.GetDimensions(w, h);
        float2 dim = float2(w, h);
        
        float depth = depthMap.Sample(sampleTypeMirror, input.TexCoord).r;
        scene.Depth = depth;
        
        
        float2 screenSize = float2(w, h);
        scene.ScreenSize = screenSize;
        
        float2 texelSize = float2(1 / w, 1 / h);
        scene.TexelSize = texelSize;
        
        float2 uv = input.TexCoord;
        scene.UV = uv;
        
        float3 pixelPos = float3(uv * screenSize, depth);
        scene.PixelPos = pixelPos;
        
        int3 iuv = int3(uv.x * w, uv.y * h, 0);
        float4 depthCross = GetDepthCrossLRUD(iuv, NORMAL_SAMPLE_RADIUS);
     
        scene.DepthLRUD = depthCross;
        
        float4 dn = GetDepthNormalGradient(depthMode, scene.UV, 25, 8);
        //float4(CalculateDepthNormalV1(depthCross, depth), depth);
        scene.DN = dn;
        scene.Normal = float3(dn.xyz);
        
        scene.View.PixelDir = normalize(pixelPos - viewPos);
        
        float c = 0;
        float4 diffs;
        float occlusionTotal = 0;
        [unroll]
        for (int i = 0; i < 4; ++i)
        {
            if (depthCross[i] < dn.w)
            {
                diffs[i] = (depthCross[i] - dn.w);
            
                if (diffs[i] > OCCLUSION_MIN_DIFFERENCE)
                {
                    occlusionTotal += 1;
                }
                c += diffs[i];
            }
        }
        c /= 4;
        scene.OcclusionAmount = c;
        scene.OcclusionsLRUD = diffs;
        
        scene.Thickness = max(0.05, min(0.95, (1 - c) + 0.1));
        scene.Concentration = min(1, max(0.05, 0.05 + (1 - c)));
        scene.AmbientColor = float4(dn.xyz * 2, c);
        
        //scene.DiffuseColor = diffuseMap.Sample(sampleTypeLinear, uv);
        float4 ddens = CalculateDepthDensity(depthMode, uv, scene.View.Direction,
            0.01f, 10.0f, depthCross, dn);
        
   
        scene.DiffuseColor = diffuseMap.Sample(sampleTypeMirror, uv);
        
        scene.Normal = scene.DN.xyz;
    }

    
    float3 fresnelSchlick(float3 F0, float3 V, float3 N, float fresnelPower)
    {
        float cosTheta = dot(V, N);
        return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
    }
    
    float4 outputValues(float2 uv, float4 v1, float4 v2, float4 v3, float4 v4)
    {
        if (uv.x < 0.25)
        {
            return v1;
        } // First column
        else if (uv.x < 0.5)
        {
            return v2;
        } // Second column
        else if (uv.x < 0.75)
        {
            return v3;
        } // Third column
        else
        {
            return v4;
        } // Fourth column
    }
    
    float3 Reflect(float3 normal, float3 lightDir)
    {
        return 2 * dot(normal, lightDir) * normal - lightDir;
    }
    
    
    /*
    float4 Illuminate(
        in Scene scene,
        in Light lights[MAX_LIGHTS],
        out LightCast CastedLight[MAX_LIGHTS])
    {
        float4 ret = float4(0, 0, 0, 1);
        
        
        int lightIndex = 0;
        
        float3 viewDir = scene.View.Direction;
        float3 viewPos = scene.View.Position;
            
        float3 pixelPos = scene.PixelPos;
        float normal = scene.DN.xyz;
        
        float3 lightToPixelDir = normalize(light.Position.xyz - scene.PixelPos);
        float3 pixelToLightDir = -normalize(lightToPixelDir);
        float3 reflectDir = normalize(reflect(lightToPixelDir, normal));
        float diffuseComponent = max(dot(normal, lightToPixelDir), 0);
        float specularComponent = pow(max(dot(reflectDir, viewDir), 0.0), light.Shininess);
        
            
        float3 diffuseFresnel = DiffuseFresnel(normal, pixelToLightDir,
        viewDir, light.FresnelReflectance);
            
        float3 fresnelTerm = FresnelSchlick2(
        light.FresnelReflectance,
        viewDir, normal, light.FresnelPower);
            
        float falloff = LightFalloff(distance(scene.PixelPos, light.Position.xyz)
        , light.Radius, light.Exponent);
            
            
        float4 diffuseLight = diffuseComponent;
            
        float refractionIncidentAngle =
        dot(viewDir, normalize(lightToPixelDir));
            
        float3 refractionAmount =
        clamp(refract(-scene.Normal, normalize(scene.PixelPos + viewDir),
        refractionIncidentAngle), 0, 0.9);
        
    // Subsurface Scattering
        float scatterScale = pow(clamp(scene.Concentration, 0.01, 0.9), clamp(scene.Thickness, 0.01, 0.9));
        float scatterComponent = exp(-clamp(scene.Concentration, 0.01, 0.9) * clamp(scene.Thickness, 0.01, 0.9)) * scatterScale;
        float4 scattering = clamp(float4(scatterComponent * float3(scene.DiffuseColor.xyz), 0.8), 0, 0.5);

        float4 refractedLightCast = clamp(float4(refractionAmount, 0.2), 0, 0.2);
        
        float4 rotatedLight =
        clamp(float4(RotateAroundAxis(refractedLightCast.xyz,
            normalize(scene.PixelPos - scene.View.Position),
                diffuseComponent), refractedLightCast.a), 0, 0.1);

    // Total Lighting
        float4 totalLightCast =
        (diffuseLight * float4(1 - diffuseFresnel, 1) +
        refractedLightCast * float4(1 - diffuseFresnel, 1) +
        scattering * float4(1 - diffuseFresnel, 1)) * light.Intensity;
        
                
    // Test Total Light Cast
        if (any(totalLightCast < 0) || any(totalLightCast > 1))
        {
            totalLightCast = clamp(totalLightCast, 0, 1);
              
        } // Teal

    // Storing the calculated values
        CastedLight[x].Source = light;
        CastedLight[x].LightColor = scene.DiffuseColor;
        CastedLight[x].DiffuseComponent = diffuseComponent;
        CastedLight[x].RefractionIncidentAngle = refractionIncidentAngle;
        CastedLight[x].RefractionAmount = refractionAmount;
        CastedLight[x].FresnelTerm = fresnelTerm;
        CastedLight[x].Diffuse = diffuseLight;
        CastedLight[x].Scattering = scattering;
        CastedLight[x].RotatedLight = rotatedLight;
        float4 amt =
        clamp(((clamp(totalLightCast * falloff, 0, 1)) *
            clamp(scene.DiffuseColor, 0, 1)) *
            float4(1 - diffuseFresnel, 1) +
            scattering, 0, 1);
                
        CastedLight[x].LightAmount = amt;
        CastedLight[x].TotalLightCast = amt;
           
        // Clamp the result if necessary
        ret += clamp(amt, 0, 1);
        
        return ret;

    }

    */
};


float Fresnel1(float3 viewDir, float3 normal, float fresnelPower)
{
    float cosTheta = dot(normal, viewDir);
    return fresnelPower + (1 - fresnelPower) * pow(1 - cosTheta, 5);
}
float4 CrossLRUD(Texture2D tex, int3 uv, int range)
{
    return
        float4(tex.Load(uv, int2(-range, 0)).r,
                tex.Load(uv, int2(range, 0)).r,
                tex.Load(uv, int2(0, -range)).r,
                tex.Load(uv, int2(0, range)).r
            );

}

void CrossLRUD_RGB(Texture2D tex, int3 iuv, int range,
    out float4 l, out float4 r, out float4 u, out float4 d)
{
    l = tex.Load(iuv, int2(-range, 0));
    r = tex.Load(iuv, int2(range, 0));
    u = tex.Load(iuv, int2(0, -range));
    d = tex.Load(iuv, int2(0, range));
}

void CrossLRUD_RGB2(Texture2D tex, float2 uv, float2 szD, float dep,
    out float4 l, out float4 r, out float4 u, out float4 d)
{
    float rangeX = cosTime01(2) * 7 * (1 - dep);
    float rangeX2 = cosTime01(2) * 6 * (1 - dep);
    float rangeY = cosTime01(1) * 9 * (1 - dep);
    float rangeY2 = cosTime01(1) * 6 * (1 - dep);
    l = tex.Sample(sampleTypeMirror, uv + szD * float2(-rangeX, 0));
    r = tex.Sample(sampleTypeMirror, uv + szD * float2(rangeX2, 0));
    u = tex.Sample(sampleTypeMirror, uv + szD * float2(0, -rangeY));
    d = tex.Sample(sampleTypeMirror, uv + szD * float2(0, rangeY2));
}

static const int LightType_PointLight = 0;
static const int LightType_DirectionalLight = 1;
static const int LightType_SpotLight = 2;
static const int LightType_AmbientLight = 3;
static const int LightType_AreaLight = 4;
static const int LightType_EnvironmentLight = 5;

float3 FresnelReflection(float3 lightColor, float fresnel)
{
    return float3(lightColor * fresnel);
}



float3 DiffuseLighting(float3 normal, float3 lightDir, float3 lightColor, float fresnel,
    float lightIntensity)
{
    float diffFactor = max(0, dot(normal, lightDir));
    return (1 - fresnel) * diffFactor * lightColor * lightIntensity;
}

float4 CombineLighting(float4 diffuse, float4 reflection)
{
    return diffuse + reflection;
}

float GetRandomSpin(int rayIndex)
{
    // Seed the random function with ray index
    float seed = (float) rayIndex * 98765.4321;

    // Generate random value
    float spin = frac(cos(seed) * 95123.4567);

    // Scale and bias to range [-MAX_SPIN, MAX_SPIN]
    return spin * 2.0 * MAX_SPIN - MAX_SPIN;
}

struct BaseLight
{
    bool Enabled;
    int LightType;
    float3 Position; // Position of the light
    float3 Direction; // Direction the light is pointing
    float3 LightColor; // Color of the light
    float Intensity; // Light intensity
    bool CastShadows; // Whether the light casts shadows
    float Exponent; // Exponent for falloff
    float FresnelPower; // Fresnel power
    float FresnelReflectance; // Fresnel reflectance
};

struct PointLight
{
    BaseLight Base;
    float Radius; // Radius of the light influence
    float3 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
    
    
    float4 PointLightDiffuse(
        float3 normal,
        float3 viewDir,
        float3 position,
        float4 occlusionFactor,
        float scatteringCoefficient)
    {
    // Direction to the light
        float3 toLight = (Base.Position - position);
        float3 lightDir = normalize(-toLight);
        
        
        float4 penetrationDepth = length(toLight) * occlusionFactor;
        
        // randomPerturbation is a small random vector
        float4 scatteredDirection = float4(Base.Direction, 1) +
            float4(GetRandomSpin(TotalTime), GetRandomSpin(int(TotalTime * 3)),
                GetRandomSpin(int(TotalTime)), 1);
        
        float attenuation = exp((-(length(occlusionFactor) * scatteringCoefficient))) * penetrationDepth;
        
        float scatterDiffFactor = max(0, dot(normal, scatteredDirection.xyz));
        float3 scatterDiffuse = scatterDiffFactor * Base.LightColor * attenuation;
        
        
    // Basic diffuse calculation
        float diffFactor = occlusionFactor * 0.02 * max(0, dot(normal, lightDir));
    
    // Distance to the light
        float distance = length(toLight);
  
    // Attenuation
        float attenuationFactor = 1 /
            (Attenuation.x +
             Attenuation.y * distance +
             Attenuation.z * distance * distance);
    
    // Fresnel calculation
        float fresnel = Fresnel1(viewDir, lightDir, Base.FresnelPower);
    
        float3 viewDir2 = normalize(reflect(normalize(toLight), normal));
      
        float R0 = pow((Base.FresnelPower - 1) / (Base.FresnelPower + 1), 2);
        float fresnel2 = Fresnel1(normal, viewDir, R0);
        
        float3 reflection = Base.LightColor * Base.Intensity *
            Base.FresnelReflectance * attenuationFactor;

        
        float3 light = fresnel2 * (scatterDiffuse +
                reflection +
                Base.LightColor *
                diffFactor *
                Base.Intensity *
                attenuationFactor);
        
        return
            float4(light, 1) - (1 - occlusionFactor);
        
        
    }
};
struct DirectionalLight
{
    BaseLight Base;
    
    float4 DirectionalLight(float3 normal, float3 viewDir)
    {
        if (!Base.Enabled)
            return float4(0, 0, 0, 0);

    // Fresnel calculation
        float fresnel = Fresnel1(viewDir, normal, Base.FresnelPower);
        float3 reflectDir = -normalize(reflect(-Base.Direction, viewDir));
        
        float fresnel2 = Fresnel1(reflectDir, viewDir, Base.FresnelPower);
        
        float diffFactor = max(0, dot(normal, Base.Direction));
        
        float diffFactor2 = max(0, dot(reflectDir, normal));
        
        float3 diffuseLight = diffFactor * (1 - fresnel) *
            Base.Intensity * Base.LightColor;
        
    // Fresnel reflection calculation
        float3 reflection =
            diffFactor * (fresnel2) * Base.Intensity *
            Base.FresnelReflectance * Base.LightColor;

        return float4(
            (diffuseLight + reflection)
            , 1);
    }
};
struct SpotLight
{
    BaseLight Base;
    float3 TargetPosition; // Radius of the light influence
    float ConeAngle; // Cone angle for spotlights
    float CutOffAngle; // CutOff angle for spotlights
    float3 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
    
    float4 SpotLightDiffuse(float3 normal,
        float3 position, float3 viewDir,
        float3 lightDir, float3 toLight, float fresnel)
    {
        
        float diffFactor = max(0, dot(normal,
            normalize(Base.Direction)));
        
        float distance = length(Base.Position - position);
        
    // Attenuation factors
        float attenuation =
        1 /
            (Attenuation.x +
                Attenuation.y * distance +
                    Attenuation.z * distance * distance);
        
    // Spotlight effect
        float spotEffect = max(dot(normalize(normal), -normalize(Base.Direction)), 0);
        
        float spotFactor = (spotEffect > CutOffAngle) ?
            pow(spotEffect, Base.Exponent) :
            0.1;
       
    // Cone attenuation
        float coneAttenuation =
            //spotEffect > CutOffAngle ? 
            LightFalloff(length(toLight),
                length(Base.Position - TargetPosition),
        //        Base.Exponent
        0.8
        );
        
        return float4(
            diffFactor *
            Base.LightColor *
            spotFactor *
                coneAttenuation *
            Base.Intensity, 1);
        
    }
    
    float4 SpotLight(float3 normal, float3 position, float3 viewDir)
    {
       
        float3 toLight = Base.Position - position;
       
        float3 lightDir = normalize(position - Base.Position);
      
    // Fresnel calculation
        float fresnel = Fresnel1(viewDir, normal, Base.FresnelPower);
        
    // Diffuse lighting calculation
        float4 diffuse = SpotLightDiffuse(normal, position,
            viewDir, lightDir, toLight, fresnel);
     
        float3 reflectDir = normalize(reflect(normalize(toLight), normal));
        
        float fresnel2 = Fresnel1(viewDir, reflectDir, Base.FresnelPower);
        
        float diffFactor2 = max(0, dot(reflectDir, viewDir));

    // Fresnel reflection calculation
        float3 reflection = Base.LightColor * (fresnel2) *
            Base.FresnelReflectance
            * Base.Intensity * diffFactor2;

        return float4(diffuse.rgb + reflection.rgb, 1);

    }
};
struct AmbientLight
{
    BaseLight Base;
    // No specific properties, all properties are common
};
struct AreaLight
{
    BaseLight Base;
    float2 AreaSize; // Size of an area light
    float3 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
};
struct EnvironmentLight
{
    BaseLight Base;
    float VolumetricDensity; // Volumetric light density
    float Temperature; // Color temperature
};



BaseLight InitializeBaseLight(
    bool enabled,
    int lightType,
    float3 position,
    float3 direction,
    float3 lightColor,
    float intensity,
    bool castShadows,
    float exponent,
    float fresnelPower,
    float fresnelReflectance)
{
    BaseLight light;
    light.Enabled = enabled;
    light.LightType = lightType;
    light.Position = position;
    light.Direction = direction;
    light.LightColor = lightColor;
    light.Intensity = intensity;
    light.CastShadows = castShadows;
    light.Exponent = exponent;
    light.FresnelPower = fresnelPower;
    light.FresnelReflectance = fresnelReflectance;
    return light;
}

PointLight InitializePointLight(BaseLight base, float radius, float3 attenuation)
{
    PointLight light;
    light.Base = base;
    light.Radius = radius;
    light.Attenuation = attenuation;
    return light;
}

SpotLight InitializeSpotLight(BaseLight base, float3 targetPosition, float coneAngle, float cutOffAngle, float3 attenuation)
{
    SpotLight light;
    light.Base = base;
    light.TargetPosition = targetPosition;
    light.ConeAngle = coneAngle;
    light.CutOffAngle = cutOffAngle;
    light.Attenuation = attenuation;
    return light;
}
AmbientLight InitializeAmbientLight(BaseLight base)
{
    AmbientLight light;
    light.Base = base;
    return light;
}

AreaLight InitializeAreaLight(BaseLight base, float2 areaSize, float3 attenuation)
{
    AreaLight light;
    light.Base = base;
    light.AreaSize = areaSize;
    light.Attenuation = attenuation;
    return light;
}
EnvironmentLight InitializeEnvironmentLight(BaseLight base, float volumetricDensity, float temperature)
{
    EnvironmentLight light;
    light.Base = base;
    light.VolumetricDensity = volumetricDensity;
    light.Temperature = temperature;
    return light;
}

// A function that creates a spotlight with a red color and a narrow cone angle
SpotLight CreateRedSpotLight(float3 position, float3 targetPosition)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        2, // LightType (spotlight)
        position, // Position of the light
        normalize(targetPosition - position), // Direction the light is pointing
        float3(1, 0, 0), // LightColor (red)
        1, // Intensity
        true, // CastShadows
        1, // Exponent
        1, // FresnelPower
        0.5 // FresnelReflectance
    );

    // Initialize the spotlight properties
    SpotLight light;
    light.Base = base;
    light.TargetPosition = targetPosition; // Radius of the light influence
    light.ConeAngle = 15; // Cone angle for spotlights
    light.CutOffAngle = 10; // CutOff angle for spotlights
    light.Attenuation = float3(1, 0.1, 0.01); // Attenuation coefficients (constant, linear, quadratic)

    // Return the spotlight
    return light;
}

// A function that creates an ambient light with a low intensity and a blue color
AmbientLight CreateBlueAmbientLight()
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        3, // LightType (ambientlight)
        float3(0, 0, 0), // Position of the light (not used for ambient lights)
        float3(0, 0, 0), // Direction the light is pointing (not used for ambient lights)
        float3(0, 0, 1), // LightColor (blue)
        0.2, // Intensity
        false, // CastShadows (not used for ambient lights)
        0, // Exponent (not used for ambient lights)
        0, // FresnelPower (not used for ambient lights)
        0 // FresnelReflectance (not used for ambient lights)
    );

    // Initialize the ambient light properties
    AmbientLight light;
    light.Base = base;

    // Return the ambient light
    return light;
}

// A function that creates a directional light with a high intensity and a yellow color
DirectionalLight CreateDirectionalLight(float3 direction,
    float3 color, float intensity, float fresnelPower, float fresnelReflectance)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        1, // LightType (directionallight)
        float3(0, 0, 0), // Position of the light (not used for directional lights)
        direction, // Direction the light is pointing
        color, // LightColor (yellow)
        intensity, // Intensity
        true, // CastShadows
        1, // Exponent
        fresnelPower, // FresnelPower
        fresnelReflectance // FresnelReflectance
    );

    // Initialize the directional light properties
    DirectionalLight light;
    light.Base = base;

    // Return the directional light
    return light;
}

// A function that creates a red point light
PointLight CreateRedPointLight(float3 position)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        0, // LightType (pointlight)
        position, // Position of the light
        float3(0, 0, 0), // Direction the light is pointing (not used for point lights)
        float3(1, 0, 0), // LightColor (red)
        0.5, // Intensity
        false, // CastShadows
        1, // Exponent
        1, // FresnelPower
        0.5 // FresnelReflectance
    );

    // Initialize the point light properties
    PointLight light;
    light.Base = base;
    light.Radius = 5; // Radius of the light influence
    light.Attenuation = float3(1, 0.1, 0.01); // Attenuation coefficients (constant, linear, quadratic)

    // Return the point light
    return light;
}
// A function that creates a suspenseful mood with different types of lights
void CreateSuspensefulMood()
{
    // Create a red spotlight that points to the main character from behind a door or a window
    SpotLight redSpotLight = CreateRedSpotLight(float3(10, 10, -10), float3(-1, -1, 1));

    // Create a blue ambient light that fills the scene with a cold and dark atmosphere
    AmbientLight blueAmbientLight = CreateBlueAmbientLight();

    // Create a yellow directional light that simulates a lightning strike or a flash of fire from outside the scene
    DirectionalLight yellowDirectionalLight =
        CreateDirectionalLight(float3(-1, -1, -1), float3(1, 1, 0), 1, 1, 0.5);

    // Use these lights to create a contrast between warm and cool colors and between bright and dark areas in the scene

}

float WavePattern(float2 uv, float frequency, float amplitude, float speed, float offset)
{
    return frequency * uv.x + uv.y * speed * offset * amplitude;
}
float WavePattern2(float2 uv, float frequency, float amplitude, float speed, float offset)
{
    return (frequency * uv.y + speed * uv.x * offset) * amplitude;
}

float WavePattern3(float2 uv, float frequency, float amplitude, float speed, float offset)
{
    return (frequency * uv.x * speed + offset * amplitude * uv.y);
}
float WavePattern4(float2 uv, float frequency, float amplitude, float speed, float offset)
{
    return (frequency * uv.y + speed * TotalTime + offset) * amplitude;
}
float3 HolographicMicroscopyEffect2(float2 uv, float4 dn, float3 viewDir, float2 sz, float2 szD)
{
    float w1 = WavePattern(uv, 131, 13, 133, TotalTime);
    float w2 = WavePattern(uv, 133, 23, 136, TotalTime);
    float w3 = w1 * dn.w;
    
    float4 colorr = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(szD.x * w3 * 0.1 * 10 * (1 - dn.w), 0)).
    r;
    float4 colorg = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(0, szD.y * w3 * 0.001 * (1 - dn.w))).
    g * cosTime01(221) * 0.99 * 0.9;
    float4 colorb = diffuseMap.Sample(sampleTypeMirror,
        uv + float2(szD.x * w3 * (1 - dn.w), 0)).
    b;
    
    return float3(colorr.r * 0.2, colorg.g * 0.2, colorb.b * 0.2);

}

float3 HolographicMicroscopyEffect3(float2 uv, float4 dn, float3 viewDir, float2 sz, float2 szD)
{
    float4 colorr = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(sz.x * (1 - (dn.w)) * 2, 0)).r;
    float4 colorg = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(0, sz.y * (dn.w) * 4)).g;
    float4 colorb = diffuseMap.Sample(sampleTypeMirror,
        uv + float2(sz.x * (1 - (dn.w)) * -2, 0)).b;
    
    return 1 - FresnelSchlick2(float3(colorr.r, colorg.g, colorb.b), viewDir, dn.xyz, 1);

}

// A function that creates a white point light
PointLight CreatePointLight(float3 position, float3 color,
    float intensity, float exponent, float fresnelPower,
    float fresnelReflectance, float radius, float3 attenuation)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        0, // LightType (pointlight)
        position, // Position of the light
        float3(0, 0, 0), // Direction the light is pointing (not used for point lights)
        color, // LightColor (white)
        intensity, // Intensity
        false, // CastShadows
        exponent, // Exponent
        fresnelPower, // FresnelPower
        fresnelReflectance // FresnelReflectance
    );

    // Initialize the point light properties
    PointLight light;
    light.Base = base;
    light.Radius = radius; // Radius of the light influence
    light.Attenuation = attenuation; // Attenuation coefficients (constant, linear, quadratic)

    // Return the point light
    return light;
}

// A function that creates a dark ambient light
AmbientLight CreateDarkAmbientLight()
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        3, // LightType (ambientlight)
        float3(0, 0, 0), // Position of the light (not used for ambient lights)
        float3(0, 0, 0), // Direction the light is pointing (not used for ambient lights)
        float3(0.2, 0.2, 0.2), // LightColor (dark gray)
        0.1, // Intensity
        false, // CastShadows (not used for ambient lights)
        0, // Exponent (not used for ambient lights)
        0, // FresnelPower (not used for ambient lights)
        0 // FresnelReflectance (not used for ambient lights)
    );

    // Initialize the ambient light properties
    AmbientLight light;
    light.Base = base;

    // Return the ambient light
    return light;
}


//Attenuation coefficients 1, 0.1, 0.01
SpotLight CreateSpotLight(float3 position, float3 direction, float3 color,
    float intensity, float exponent, float fresnelPower, float fresnelReflectance,
    float3 targetPosition, float coneAngle, float coneAngleCutoff, float3 attenuation)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        2, // LightType (spotlight)
        position, // Position of the light
        direction, // Direction the light is pointing
        color, // LightColor (green)
        intensity, // Intensity
        false, // CastShadows
        exponent, // Exponent
        fresnelPower, // FresnelPower
        fresnelReflectance // FresnelReflectance
    );

    // Initialize the spotlight properties
    SpotLight light;
    light.Base = base;
    light.TargetPosition = targetPosition; // Radius of the light influence
    light.ConeAngle = coneAngle; // Cone angle for spotlights
    light.CutOffAngle = coneAngleCutoff; // CutOff angle for spotlights
    light.Attenuation = attenuation; // Attenuation coefficients (constant, linear, quadratic)

    // Return the spotlight
    return light;
}



float3 Bloom(float2 uv, float intensity, float3 n)
{
    float3 sceneColor = diffuseMap.Sample(sampleTypeMirror, uv).rgb;
    
    return sceneColor * (FresnelSchlick2(sceneColor, float3(-0.1, -0.1, 1), n, 1));
}

inline float4 mir2D(Texture2D tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0);
}

GradientModulationConfig InitializeConfig(float2 oosz, float timeFactor, float2 uv0, float2 ooszd, float2 ooszrt, float3 viewPos, bool flipDepth, bool scale, float depthScale)
{
    config.scaleDepth = scale;
    config.flipDepth = flipDepth;
    config.depthScale = depthScale;
    
    int2 isz;
    depthMap.GetDimensions(isz.x, isz.y); // Get the dimensions of the depth map texture
    config.isz = isz;
    config.uv0 = config.uv = uv0;
  
    config.timeFactor = timeFactor;
    
    config.diffuse = config.diffuse0 = mir2D(diffuseMap, config.uv);
    config.oosz = oosz;
    config.ooszd = ooszd;
    config.ooszrt = ooszrt;
    config.viewPos0 = float3(viewPos.x, viewPos.y, viewPos.z);
    config.viewPos = config.viewPos0;
    config.sunPos = float3(f1, f2, SunZ);
    
    config.gradient = config.gradient0 = GetGradient(depthMap, oosz, config.uv, normalRadius, config.flipDepth, scale, config.depthScale);
    config.depthCurve = config.depthCurve0 = ComputeAdjustedDepthCurve(oosz, depthMap, config.uv0, config.flipDepth, scale, config.depthScale);
    
    config.depth = config.depth0 = GetDepth(depthMap, oosz, config.uv, normalRadius, config.gradient, config.depthCurve, flipDepth, scale, config.depthScale);
    
    
    config.pixelScaled = config.pixel0Scaled = float3(config.uv, config.depth);
    config.viewDir = normalize(config.viewPos - config.pixelScaled);
    
    if (scale)
    {
        config.invDepth = (1 - config.depth / config.depthScale) * config.depthScale;
    }
    else
    {
        config.invDepth = (1 - config.depth);
    }
    config.modulation = config.modulation0 = GetModulation(config.gradient, config.depthCurve);
    config.normal = config.normal0 = GetNormal(oosz, normalMap, config.uv0, normalRadius, config.modulation);
    vec3 centerScaled = vec3(float2(.5, .5), dep2D(oosz, depthMap, float2(.5, .5), flipDepth, config.depthScale, scale));
    
    config.centerDist0 = config.centerDist = distance(config.pixelScaled, centerScaled);
    
    config.viewDir = config.viewDir0 = normalize(config.viewPos - config.pixelScaled);
    config.pixelToSunSegment = config.pixel0ToSunSegment = config.sunPos - config.pixelScaled;
    config.pixelToSunDir = config.pixel0ToSunDir = normalize(config.pixelToSunSegment);

    config.sunHalfVec = normalize(config.pixelToSunDir + config.viewDir);
    config.HdotV = ClampEpsilon(dot(config.sunHalfVec, config.viewDir));
    config.VdotL = ClampEpsilon(dot(normalize(config.sunPos - config.viewPos), config.viewDir));
    config.NdotH = ClampEpsilon(dot(config.sunHalfVec, config.normal));
    config.NdotV = ClampEpsilon(dot(config.normal, config.viewDir));
    config.NdotL = ClampEpsilon(dot(config.pixelToSunDir, config.normal));

    config.reflectDir = normalize(reflect(config.sunHalfVec, config.normal));
    config.reflectFactor = ClampEpsilon11(dot(config.reflectDir, config.viewDir));

    
    config.depthCross = CrossLRUDf(config.oosz, depthMap, config.uv, normalRadius + ceil(normalRadius * .2), config.gradient, config.flipDepth, scale, config.depthScale);
    config.depthRange = variation(config.depthCross);
    
    return config;
}

float4 PSo(PS_INPUT input) : SV_TARGET
{
    float4 ret = float4(0, 0, 0, 1);
    
    float2 uv = input.TexCoord;
    ViewZ += cosTime01(timr) * .005; // reduced from 5

    RNG rng;
    rng = InitRNG(SeedFromPosition(input.Position.xyz));
    bool flipDepth = true;
    bool scaleDepth = true;
    psout ret;
    const vec2 oosz = depthOosz();
    const vec2 ooszd = diffuseOosz();
    const vec2 ooszrt = rtMapOosz();

    input.uv = RefractedHolographicBilinear(float4(input.uv, input.uv), float4(input.uv + .05, 1 - input.uv), input.uv, TotalTime * timr).xy; // reduced from .1 to .05

    config = InitializeConfig(oosz, TotalTime * timr, input.uv, ooszd, ooszrt, camPos0, flipDepth, scaleDepth, DepthScale);


    
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
        ret.rt1 = mir2D(rtMap1, config.uv0);
        ret.rt2 = mir2D(rtMap2, config.uv0);
        ret.rt3 = mir2D(rtMap3, config.uv0);
        ret.rt4 = mir2D(rtMap4, config.uv0);
        ret.rt5 = mir2D(rtMap5, config.uv0);
        ret.rt6 = mir2D(rtMap6, config.uv0);
        ret.rt7 = mir2D(rtMap7, config.uv0);
        ret.rt8 = mir2D(rtMap8, config.uv0);
    }
   
   // Time-based modulation factors
    float ct1 = cosTime01(timr) - .5;
    float ct4 = (cosTime01(timr) - .5);
  
    vec2 occlusionOffset =
        ct1 * config.modulation * (vec2(ParallaxScale, .001) * nearDepth() +
        vec2(ParallaxScaleOMD, .007) * farDepth()); // reduced from .0023 to .001 and .0142 to .007

    
// Occlusion calculation
    const int numOcclusionLayers = 8;
  
    vec2 depthUV = ParallaxOcclusion(oosz, depthMap, config.uv - .0025 * PassNum + .0025 * PassNum / 2, occlusionOffset, numOcclusionLayers, config.flipDepth, config.scaleDepth, config.depthScale).uv + .0025 * PassNum - .0025 * PassNum / 2; // reduced from .05 to .025

    UpdateConfig(config, depthUV, scaleDepth);

    float pn1 = PerlinNoise(config.uv, config.depth + TotalTime * timr * 0.2);
    float pn2 = PerlinNoise(config.uv * 1.003 + pn1 * .01, (config.depth) + TotalTime * timr * 0.2);
    float pn3 = PerlinNoise(config.uv * config.oosz * 2 + pn2 * .02, (config.depth) + TotalTime * timr * 0.2);
    float pn4 = PerlinNoise(config.uv, (config.depth) + TotalTime * timr);
   
//ParallaxScale
    FresnelPower -= pn1 * cosTime01(timr) * .01;
    FresnelReflectance += pn2 * cosTime01(timr) * .01;
 
        

   // config.depth += .01 * PerlinNoise(float3(config.uv, config.depth));
    MaterialProperties mat = CreateMaterial(MaterialIndex);

    
    
       // vec2 gUV4 = ParallaxOcclusion(oosz, gratingDepth4, config.uv0, occlusionOffset, numOcclusionLayers, flipDepth, scaleDepth, config.depthScale).uv;
    
       // MaterialProperties mat2 = CreateMaterial(f8);
      
      //  UpdateConfig(config, gUV4, scaleDepth);
        
    ret.rt1 = float4(saturate(ApplyChromaticAberration(config.oosz, mat, depthUV, (config.uv - depthUV), diffuseMap, normalMap, depthMap, gratingMap4, gratingNormal4, gratingDepth4, float2(4 * pn2, .002) * config.modulation, .85, flipDepth, scaleDepth, config.depthScale)), 1);
       
      
    float vari = variation(CrossLRUDf(config.oosz, depthMap, config.uv + (depthUV - config.uv) * pn1 * config.modulation * config.depth * .1, normalRadius, config.gradient, config.flipDepth, config.scaleDepth, config.depthScale)) / 4;
        
    float2 rbEye = float2(2, 3) * (config.depth * f4) * config.oosz;
    float4 rbDiffuse = mir2D(diffuseMap, config.uv + rbEye);
       
    float4 rb = float4(RedBlueDepthEffect(config.oosz, diffuseMap, config.uv, config.depth, rbEye, QFresnel(rbDiffuse), config.modulation, config.depth * .9 + .025).xyz,
    1);

        
    float4 vhb = VolumetricHolographicBilinear(ret.rt1, rb, slerp(input.uv, input.uv + ((depthUV - config.uv) * .01), ClampEpsilon(config.NdotV)), TotalTime * timr);

    float4 rhb = RefractedHolographicBilinear(rbDiffuse, rb, slerp(input.uv, input.uv + ((depthUV - config.uv) * -.01), ClampEpsilon(config.NdotV)),
    TotalTime * timr);
    config.uv = slerp(input.Position.xy, slerp(vhb, rhb, config.NdotV).xy, .1);

    
    float4 diffuse = float4((config.oosz, depthMap, config.uv, normalRadius / 4, config.modulation), 1);

    ret.rt1 = diffuse;
    
    
    return config.uv;
}


ComplexTensorRGB SelectMaterial(float idx)
{
    if (idx < 0.5) return Material_Air();
    if (idx < 1.5) return Material_Gold();
    if (idx < 2.5) return Material_Silver();
    if (idx < 3.5) return Material_Copper();
    if (idx < 4.5) return Material_Diamond();
    return Material_Air();
}

// ============================================================================
// PIXEL SHADER — THE REMARKABLE VERSION
// ============================================================================

psout PS(PS_INPUT input)
{
    psout o;

    return o;
}