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

// Sigmoid Parameters
#define SIGMOID_NEAR .1
#define SIGMOID_NEAR4 float4(SIGMOID_NEAR,SIGMOID_NEAR,SIGMOID_NEAR,SIGMOID_NEAR)
#define SIGMOID_FAR .9
#define SIGMOID_FAR4 float4(SIGMOID_FAR,SIGMOID_FAR,SIGMOID_FAR,SIGMOID_FAR)


static float SPEC_INTENSITY = 0.6;
static float SPEC_POWER = 34.0;
static float4 PHASE_FACTOR = float4(0.7, 0.47, 0.47, 0.7);
static vec4 CHROMA_OFFSET = vec4(0.00312, 0.002, -0.007, 0.07);
static float DepthHolographicIntensity = 4;
static float RBHolographicIntensity = .5;
static vec3 pointLightPosition = vec3(2.5, 2.250, -5.0);
static vec3 spotLightPosition = vec3(12.0, 12.0, -5.0);
static vec3 spotLightDirection = vec3(-0.1, -0.10, -1.0);
static float OcclusionStrength = 0.02;

float3x3 CreateSkewMatrix(float3 tangent, float amount)
{
    float3 skewAxis = normalize(cross(tangent, float3(0, 1, 0))); // Assumes Y is up
    float3x3 skewMatrix = float3x3(1, 0, 0,
                                   0, 1, 0,
                                   0, 0, 1);

    skewMatrix[0][2] = skewAxis.x * amount; // Skew along the X-axis of the tangent space 
    skewMatrix[1][2] = skewAxis.y * amount; // Skew along the Y-axis of the tangent space
    skewMatrix[2][2] = skewAxis.z * amount; // Skew along the Z-axis of the tangent space

    return skewMatrix;
}

float3 skewNormalX(float3 normal, float amount)
{
    return -normalize(mul(normal, CreateSkewMatrix(normal, amount)));
}

// Inline linear interpolation
inline float lerp(float a, float b, float t)
{
    return a + t * (b - a);
}

// Inline fade function to smooth the transition between grid points
inline float3 fade(float3 t)
{
    return t * t * t * (t * (t * 6 - 15) + 10);
}

// Improved hash function with inline hint
inline uint hash(uint3 p)
{
    p = p * 1103515245U + 12345U;
    p = (p >> 16U) ^ p;
    p *= 1103515245U;
    p = (p >> 16U) ^ p;
    return p;
}



// Improved gradient function with a larger set of gradient vectors
inline float gradient(uint hash, float3 p)
{
    static const float3 gradients[16] =
    {
        float3(1, 1, 0), float3(-1, 1, 0), float3(1, -1, 0), float3(-1, -1, 0),
        float3(1, 0, 1), float3(-1, 0, 1), float3(1, 0, -1), float3(-1, 0, -1),
        float3(0, 1, 1), float3(0, -1, 1), float3(0, 1, -1), float3(0, -1, -1),
        float3(1, 1, 1), float3(-1, 1, 1), float3(1, -1, 1), float3(-1, -1, 1)
    };

    return dot(gradients[hash & 15U], p);
}

// Highly optimized Perlin noise function for sm_5_0
float PerlinNoise(float3 p)
{
    uint3 P = uint3(floor(p));
    float3 f = frac(p);
    float3 u = fade(f);

    uint h0 = hash(P);
    uint h1 = hash(P + uint3(1, 0, 0));
    uint h2 = hash(P + uint3(0, 1, 0));
    uint h3 = hash(P + uint3(1, 1, 0));
    uint h4 = hash(P + uint3(0, 0, 1));
    uint h5 = hash(P + uint3(1, 0, 1));
    uint h6 = hash(P + uint3(0, 1, 1));
    uint h7 = hash(P + uint3(1, 1, 1));

    float3 f1 = f - float3(1, 0, 0);
    float3 f2 = f - float3(0, 1, 0);
    float3 f3 = f - float3(1, 1, 0);
    float3 f4 = f - float3(0, 0, 1);
    float3 f5 = f - float3(1, 0, 1);
    float3 f6 = f - float3(0, 1, 1);
    float3 f7 = f - float3(1, 1, 1);

    float n000 = gradient(h0, f);
    float n100 = gradient(h1, f1);
    float n010 = gradient(h2, f2);
    float n110 = gradient(h3, f3);
    float n001 = gradient(h4, f4);
    float n101 = gradient(h5, f5);
    float n011 = gradient(h6, f6);
    float n111 = gradient(h7, f7);

    float nx00 = lerp(n000, n100, u.x);
    float nx10 = lerp(n010, n110, u.x);
    float nx01 = lerp(n001, n101, u.x);
    float nx11 = lerp(n011, n111, u.x);

    float nxy0 = lerp(nx00, nx10, u.y);
    float nxy1 = lerp(nx01, nx11, u.y);

    float nxyz = lerp(nxy0, nxy1, u.z);

    return nxyz * 3;
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
static vec3 camPos0 = vec3(.5, .5, ViewZ * DepthScale);



struct GDMFConfig
{
    float nearPoint;
    float farPoint;
    float transitionPoint;
    float polynomialDegree;
    float polynomialWeight;
    float skewFactor;
    float offsetFactor;
    float nearSlope;
    float farSlope;
    float transitionWidth;
};

// Helper function to create a GDMFConfig struct
GDMFConfig CreateGDMFConfig(float nearPoint, float farPoint, float transitionPoint, float polynomialDegree, float polynomialWeight, float skewFactor, float offsetFactor, float nearSlope, float farSlope, float transitionWidth)
{
    GDMFConfig config;
    config.nearPoint = nearPoint;
    config.farPoint = farPoint;
    config.transitionPoint = transitionPoint;
    config.polynomialDegree = polynomialDegree;
    config.polynomialWeight = polynomialWeight;
    config.skewFactor = skewFactor;
    config.offsetFactor = offsetFactor;
    config.nearSlope = nearSlope;
    config.farSlope = farSlope;
    config.transitionWidth = transitionWidth;
    return config;
}

float EvaluatePolynomial(float x, float degree, float weight)
{
    float result = 0.0f;
    for (int i = 0; i <= degree; ++i)
    {
        result += weight * pow(x, i) / pow(2.0f, i);
    }
    return result;
}
// Generalized Depth Mapping Function
float GDMF(float depth, GDMFConfig config)
{
    float normalizedDepth = (depth - config.nearPoint) / (config.farPoint - config.nearPoint);
    float polynomialTerm = EvaluatePolynomial(normalizedDepth, config.polynomialDegree, config.polynomialWeight);
    float skewedDepth = pow(normalizedDepth, config.skewFactor);
    float transitionFactor = smoothstep(0.0f, config.transitionWidth, (depth - config.transitionPoint) / (config.farPoint - config.transitionPoint));
    float linearTerm = lerp(normalizedDepth * config.nearSlope, normalizedDepth * config.farSlope, transitionFactor);
    float mappedDepth = lerp(linearTerm, polynomialTerm, transitionFactor);
    return config.nearPoint + (mappedDepth + config.offsetFactor) * (config.farPoint - config.nearPoint);
}



// Struct for Configurable Values in Gradient Modulation
struct GradientModulationConfig
{
    float timeFactor; // Range: 0.0 to infinity
    bool flipDepth;

    float4 depthCross;
    float depthRange;
    
    float depthScale;
    float2 uv0;
    float2 uv;
    
    ivec2 isz;
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
    float3 viewToPixelDir;
    float3 viewToPixel0Dir;
    float4 diffuse;
    float4 diffuse0;
    
    float centerDist0;
    float centerDist;
    
    vec3 reflectDir;
    float reflectFactor;
    
    
    float NdotV;
    float NdotL;
    float HdotV;
    float NdotH;
    
    vec2 gradient;
    vec2 modulation;
    float depth;
    float invDepth;
    vec3 normal;
    vec2 depthCurve;
    
    vec2 gradient0;
    vec2 modulation0;
    float depth0;
    vec3 normal0;
    vec2 depthCurve0;
    
};

static GradientModulationConfig config;



inline float lerp1D(float t, float a, float b)
{
    // Linear interpolation
    return a + t * (b - a);
}

inline vec2 lerp(vec2 a, vec2 b, float t)
{
    return a + t * (b - a);
}
inline vec3 lerp(vec3 a, vec3 b, float t)
{
    return a + t * (b - a);
}
inline vec4 lerp(vec4 a, vec4 b, float t)
{
    return a + t * (b - a);
}


inline float sum(float2 v)
{
    return v.x + v.y;
}
inline float sum(float3 v)
{
    return v.x + v.y + v.z;
}
inline float sum(float4 v)
{
    return v.x + v.y + v.z + v.w;
}
inline float variation(float4 dc2)
{
    return max(max(max(dc2.x, dc2.y), dc2.z), dc2.w) - min(min(min(dc2.x, dc2.y), dc2.z), dc2.w);
}
inline float variation(float3 dc2)
{
    return max(max(dc2.x, dc2.y), dc2.z) - min(min(dc2.x, dc2.y), dc2.z);
}

inline float4 variation(float4 dc2, float4 dc6)
{
    return float4(max(dc2.x, dc6.x) - min(dc2.x, dc6.x),
                max(dc2.y, dc6.y) - min(dc2.y, dc6.y),
                max(dc2.z, dc6.z) - min(dc2.z, dc6.z),
                max(dc2.w, dc6.w) - min(dc2.w, dc6.w));
}
inline float3 variation(float4 dc2, float3 dc6)
{
    return float3(max(dc2.x, dc6.x) - min(dc2.x, dc6.x),
                max(dc2.y, dc6.y) - min(dc2.y, dc6.y),
                max(dc2.z, dc6.z) - min(dc2.z, dc6.z));
}
float2 variation(float2 dc2, float2 dc6)
{
    return float2(max(dc2.x, dc6.x) - min(dc2.x, dc6.x),
                max(dc2.y, dc6.y) - min(dc2.y, dc6.y));
}
inline float variation(float dc2, float dc6)
{
    return max(dc2.x, dc6.x) - min(dc2.x, dc6.x);
}
inline float variation(float2 v)
{
    return max(v.x, v.y) - min(v.x, v.y);
}


inline float3 attenuationPoint()
{
    return float3(1.0, 0.2, 0.01);
}

inline float randomSpin(int rayIndex)
{
    float seed = float(rayIndex) * 98765.4321;
    float spin = frac(cos(seed) * 95123.4567);
    return spin;
}

inline float randomNoise1(float2 uv)
{
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}
inline float2 randomNoise2(float2 uv)
{
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return float2(randomSpin(int(uv.x * 1000)), randomSpin(int(uv.y * 1000)));
}

inline float randWorley(float2 uv)
{
    float d = 1.0;
    uv *= 5.0; // Adjust for bubble size
    [unroll]
    for (int x = -1; x <= 1; x++)
        [unroll]
        for (int y = -1; y <= 1; y++)
        {
            float2 lattice = floor(uv) + float2(x, y);
            float2 offset = randomNoise2(lattice);
            d = min(d, length(uv - lattice - offset));
        }
    return d;
}

inline float PerlinNoise(float2 f1, float f2)
{
    return PerlinNoise(float3(f1, f2));
}
// Worley Noise function for bubbly effect
float randWorleyNoise(vec2 uv, float bubbleSize)
{
    float d = 1.0;
    uv *= bubbleSize;
    
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            vec2 lattice = floor(uv) + float2(x, y);
            vec2 offset = vec2(PerlinNoise(vec3(lattice, 0)), PerlinNoise(vec3(lattice, 0)));
            d = min(d, length(uv - lattice - offset));
        }
    }
    return d;
}

float3 randStratifiedNoise(float3 position, float3 frequency, float3 amplitude)
{
    // Stratified noise combines multiple noise layers at different frequencies and amplitudes
    float noiseLayer1 = randWorleyNoise(config.modulation * position.xy + position.z, frequency.x) * amplitude.x;
    float noiseLayer2 = randWorleyNoise(config.modulation * position.xy + position.z, frequency.y) * amplitude.y;
    float noiseLayer3 = randWorleyNoise(config.modulation * position.xy + position.z, frequency.z) * amplitude.z;
    return (noiseLayer1 + noiseLayer2 + noiseLayer3) / 3.0;
}



float randLayeredNoise(vec3 position)
{
    // Combining multiple noise functions with different frequencies
    float noise1 = randWorleyNoise(position.xy, 0.5); // Lower frequency noise
    float noise2 = randWorleyNoise(position.xy, 1.5); // Higher frequency noise
    float noise3 = randWorleyNoise(position.xy, 3.0); // Even higher frequency noise

    // Combining the noise functions to create layered effect
    return clamp((noise1 + noise2 + noise3) / 3.0, epsilon, (1 - epsilon)); // Average to get layered noise
}

float randNoise(float2 uv)
{
    // Implement a basic noise function or use a GPU's built-in noise function
    // Placeholder for noise - replace with a specific noise function as needed
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

inline float3 attenuationSun()
{
    return float3(1, 1.0f / (SunZ + ViewZ), 1.0f / pow(SunZ + ViewZ, 2));
}
// Compute the attenuation factor based on the distance from the light source
inline float ComputeAttenuation(float3 lightPosition, float3 worldPosition, float x, float y, float z)
{
    float distance = length(lightPosition - worldPosition);
    return 1.0 / (x + y * distance + z * distance * distance);
}

// Compute the depth-scaled distance from the light source
inline float ComputeDepthScaledDistance(float3 lightPosition, float3 depthScaledWorldPosition)
{
    return length(lightPosition - depthScaledWorldPosition);
}

// Compute the attenuation factor with depth scaling
inline float ComputeAttenuation(float distance, float3 attenuation)
{
    return 1.0 / (attenuation.x + attenuation.y * distance + attenuation.z * distance * distance);
}

#define DepthScale3 vec3(1,1,DepthScale)
inline float4 slerp(float4 q1, float4 q2, float t)
{
    float cos_omega = dot(q1, q2);
    float4 q2_neg = -q2;
    if (cos_omega < 0.0)
    {
        q2 = q2_neg;
        cos_omega = -cos_omega;
    }

    float k0, k1;
    if (cos_omega > 0.9999)
    {
        k0 = 1.0 - t;
        k1 = t;
    }
    else
    {
        float sin_omega = sqrt(1.0 - cos_omega * cos_omega);
        float omega = atan2(sin_omega, cos_omega);
        float inv_sin_omega = 1.0 / sin_omega;
        k0 = sin((1.0 - t) * omega) * inv_sin_omega;
        k1 = sin(t * omega) * inv_sin_omega;
    }

    return k0 * q1 + k1 * q2;
}
inline float3 slerp(float3 q1, float3 q2, float t)
{
    float cos_omega = dot(q1, q2);
    float3 q2_neg = -q2;
    if (cos_omega < 0.0)
    {
        q2 = q2_neg;
        cos_omega = -cos_omega;
    }

    float k0, k1;
    if (cos_omega > 0.9999)
    {
        k0 = 1.0 - t;
        k1 = t;
    }
    else
    {
        float sin_omega = sqrt(1.0 - cos_omega * cos_omega);
        float omega = atan2(sin_omega, cos_omega);
        float inv_sin_omega = 1.0 / sin_omega;
        k0 = sin((1.0 - t) * omega) * inv_sin_omega;
        k1 = sin(t * omega) * inv_sin_omega;
    }

    return k0 * q1 + k1 * q2;
}

inline float2 slerp(float2 q1, float2 q2, float t)
{
    float cos_omega = dot(q1, q2);
    float2 q2_neg = -q2;
    if (cos_omega < 0.0)
    {
        q2 = q2_neg;
        cos_omega = -cos_omega;
    }

    float k0, k1;
    if (cos_omega > 0.9999)
    {
        k0 = 1.0 - t;
        k1 = t;
    }
    else
    {
        float sin_omega = sqrt(1.0 - cos_omega * cos_omega);
        float omega = atan2(sin_omega, cos_omega);
        float inv_sin_omega = 1.0 / sin_omega;
        k0 = sin((1.0 - t) * omega) * inv_sin_omega;
        k1 = sin(t * omega) * inv_sin_omega;
    }

    return k0 * q1 + k1 * q2;
}
inline float slerp(float q1, float q2, float t)
{
    float cos_omega = dot(q1, q2);
    float q2_neg = -q2;
    if (cos_omega < 0.0)
    {
        q2 = q2_neg;
        cos_omega = -cos_omega;
    }

    float k0, k1;
    if (cos_omega > 0.9999)
    {
        k0 = 1.0 - t;
        k1 = t;
    }
    else
    {
        float sin_omega = sqrt(1.0 - cos_omega * cos_omega);
        float omega = atan2(sin_omega, cos_omega);
        float inv_sin_omega = 1.0 / sin_omega;
        k0 = sin((1.0 - t) * omega) * inv_sin_omega;
        k1 = sin(t * omega) * inv_sin_omega;
    }

    return k0 * q1 + k1 * q2;
}

inline float lerp(float x, float x0, float x1, float y0, float y1)
{
    if (x1 == x0)
        return y0; // Prevent division by zero
    return y0 + (x - x0) * (y1 - y0) / (x1 - x0);
}

struct PS_INPUT
{
    float4 Position : SV_Position;
    float2 TexCoord : TEXCOORD0;
    float3 ViewDir : TEXCOORD1;
    float4 Color : COLOR0;
};

SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror2 : register(s1);
SamplerState sampleTypeMirror : register(s2);

inline float4 mir2D(Texture2D tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0);
}

inline float4 mir2D(Texture2D<float3> tex, float2 uv)
{
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0).rgb, 1);
}

inline float mir2D(Texture2D<float> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0).r;
}


struct VS_INPUT
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
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



static vec4 AuroraColors[6] =
{
    vec4(0.0, 0.4, 1.0, 1.0), // Blue
    vec4(0.0, 1.0, 0.0, 1.0), // Green
    vec4(0.0, 0.2, 0.8, 1.0), // Blue-Green
    vec4(1.0, 0.5, 0.0, 1.0), // Orange
    vec4(0.8, 0.0, 0.8, 1.0), // Purple
    vec4(1.0, 1.0, 1.0, 1.0) // White
};



inline vec3 pow3(vec3 v, float p)
{
    return vec3(pow(v.x, p), pow(v.y, p), pow(v.z, p));
}

inline vec4 pow4(vec4 v, float p)
{
    return vec4(pow(v.x, p), pow(v.y, p), pow(v.z, p), pow(v.w, p));
}

inline float avg4(vec4 v)
{
    return (v.x + v.y + v.z + v.w) * .25;
}

inline float avg3(vec3 v)
{
    return (v.x + v.y + v.z) * 0.3333;
}

inline float avg2(vec2 v)
{
    return (v.x + v.y) * 0.5;
}


inline float3 RGBtoHSL(float3 color)
{
    float maxComponent = max(color.r, max(color.g, color.b));
    float minComponent = min(color.r, min(color.g, color.b));
    float range = maxComponent - minComponent;

    float3 hsl;
    hsl.z = (maxComponent + minComponent) / 2.0; // Lightness

    if (range == 0.0)
    {
        hsl.x = 0.0; // Hue is undefined 
        hsl.y = 0.0; // Saturation
    }
    else
    {
        hsl.y = range / (1.0 - abs(2.0 * hsl.z - 1.0)); // Saturation

        float delta = range / (6.0 * maxComponent);

        if (color.r == maxComponent)
        {
            hsl.x = (color.g - color.b) * delta;
        }
        else if (color.g == maxComponent)
        {
            hsl.x = (2.0 + (color.b - color.r) * delta);
        }
        else
        {
            hsl.x = (4.0 + (color.r - color.g) * delta);
        }

        hsl.x = fmod(hsl.x, 1.0); // Wrap hue to [0,1] range
    }

    return hsl;
}

inline float3 HSLtoRGB(float3 hsl)
{
    float C = (1.0 - abs(2.0 * hsl.z - 1.0)) * hsl.y; // Chroma
    float x = C * (1.0 - abs(fmod(hsl.x * 6.0, 2.0) - 1.0));
    float m = hsl.z - C / 2.0; // Lightness offset

    float3 rgbPrime;

    if (hsl.x < 1.0 / 6.0)
    {
        rgbPrime = float3(C, x, 0);
    }
    else if (hsl.x < 2.0 / 6.0)
    {
        rgbPrime = float3(x, C, 0);
    }
    else if (hsl.x < 3.0 / 6.0)
    {
        rgbPrime = float3(0, C, x);
    }
    else if (hsl.x < 4.0 / 6.0)
    {
        rgbPrime = float3(0, x, C);
    }
    else if (hsl.x < 5.0 / 6.0)
    {
        rgbPrime = float3(x, 0, C);
    }
    else
    {
        rgbPrime = float3(C, 0, x);
    }

    return rgbPrime + m;
}




inline vec3 normal2D(Texture2D<float3> tex, vec2 uv)
{
    vec3 ret = tex.SampleLevel(sampleTypeMirror, uv, 0).xyz;
    
    return normalize(ret) * 2 - 1;
}

static float UVHolographicIntensity = 0.2; // Controls the intensity of holographic distortion
static float ChromaticAberrationStrength = 0.8; // Controls the strength of chromatic aberration

static float normalDetailIntensity = 1.0; // Configurable intensity for normal details
static float depthNormalImpact = 1.0; // Configurable impact of depth on normals





inline float4 combine(vec4 color1, vec4 color2, vec4 color3)
{
    float4 ret = float4(0, 0, 0, 0);
    vec4 totalCount = vec4(0, 0, 0, 0);

    // Combine colors for each component
    if (color1[0] > 0)
    {
        ret[0] += color1[0];
        totalCount[0]++;
    }
    if (color2[0] > 0)
    {
        ret[0] += color2[0];
        totalCount[0]++;
    }
    if (color3[0] > 0)
    {
        ret[0] += color3[0];
        totalCount[0]++;
    }

    if (color1[1] > 0)
    {
        ret[1] += color1[1];
        totalCount[1]++;
    }
    if (color2[1] > 0)
    {
        ret[1] += color2[1];
        totalCount[1]++;
    }
    if (color3[1] > 0)
    {
        ret[1] += color3[1];
        totalCount[1]++;
    }

    if (color1[2] > 0)
    {
        ret[2] += color1[2];
        totalCount[2]++;
    }
    if (color2[2] > 0)
    {
        ret[2] += color2[2];
        totalCount[2]++;
    }
    if (color3[2] > 0)
    {
        ret[2] += color3[2];
        totalCount[2]++;
    }
    
    if (color1[3] > 0)
    {
        ret[3] += color1[3];
        totalCount[3]++;
    }
    if (color2[3] > 0)
    {
        ret[3] += color2[3];
        totalCount[3]++;
    }
    if (color3[3] > 0)
    {
        ret[3] += color3[3];
        totalCount[3]++;
    }

    // Average the combined colors
    if (totalCount[0] > 0)
    {
        ret[0] /= totalCount[0];
    }
    if (totalCount[1] > 0)
    {
        ret[1] /= totalCount[1];
    }
    if (totalCount[2] > 0)
    {
        ret[2] /= totalCount[2];
    }
    if (totalCount[3] > 0)
    {
        ret[3] /= totalCount[3];
    }
    return ret;
}
inline float4 combine(vec4 a, vec4 b)
{
    return combine(a, b, vec4(0, 0, 0, 0));
}
inline float3 combine(vec3 a, vec3 b, vec3 c)
{
    return combine(float4(a, 0), float4(b, 0)).rgb;
}
inline float3 combine(vec3 a, vec3 b)
{
    return combine(a, b, vec3(0, 0, 0));
}

inline float3 combine(float3 colors[3])
{
    float3 ret = float3(0, 0, 0);
    vec3 totalCount = vec3(0, 0, 0);

    // Combine colors for each component using direct indexing
    if (colors[0][0] > 0)
    {
        ret[0] += colors[0][0];
        totalCount[0]++;
    }
    if (colors[1][0] > 0)
    {
        ret[0] += colors[1][0];
        totalCount[0]++;
    }
    if (colors[2][0] > 0)
    {
        ret[0] += colors[2][0];
        totalCount[0]++;
    }

    if (colors[0][1] > 0)
    {
        ret[1] += colors[0][1];
        totalCount[1]++;
    }
    if (colors[1][1] > 0)
    {
        ret[1] += colors[1][1];
        totalCount[1]++;
    }
    if (colors[2][1] > 0)
    {
        ret[1] += colors[2][1];
        totalCount[1]++;
    }

    if (colors[0][2] > 0)
    {
        ret[2] += colors[0][2];
        totalCount[2]++;
    }
    if (colors[1][2] > 0)
    {
        ret[2] += colors[1][2];
        totalCount[2]++;
    }
    if (colors[2][2] > 0)
    {
        ret[2] += colors[2][2];
        totalCount[2]++;
    }

    // Average the combined colors using direct indexing
    if (totalCount[0] > 0)
    {
        ret[0] /= totalCount[0];
    }
    if (totalCount[1] > 0)
    {
        ret[1] /= totalCount[1];
    }
    if (totalCount[2] > 0)
    {
        ret[2] /= totalCount[2];
    }
    return ret;
}

inline float3 combine(float3 colors[2])
{
    float3 ret = float3(0, 0, 0);
    vec3 totalCount = vec3(0, 0, 0);

    // Combine colors for each component using direct indexing
    if (colors[0][0] > 0)
    {
        ret[0] += colors[0][0];
        totalCount[0]++;
    }
    if (colors[1][0] > 0)
    {
        ret[0] += colors[1][0];
        totalCount[0]++;
    }
  

    if (colors[0][1] > 0)
    {
        ret[1] += colors[0][1];
        totalCount[1]++;
    }
    if (colors[1][1] > 0)
    {
        ret[1] += colors[1][1];
        totalCount[1]++;
    }


    if (colors[0][2] > 0)
    {
        ret[2] += colors[0][2];
        totalCount[2]++;
    }
    if (colors[1][2] > 0)
    {
        ret[2] += colors[1][2];
        totalCount[2]++;
    }


    // Average the combined colors using direct indexing
    if (totalCount[0] > 0)
    {
        ret[0] /= totalCount[0];
    }
    if (totalCount[1] > 0)
    {
        ret[1] /= totalCount[1];
    }
    if (totalCount[2] > 0)
    {
        ret[2] /= totalCount[2];
    }
    
    ret = saturate(ret);
    
    return ret;
}


inline float2 combine(float2 a, float2 b)
{
    float2 ret = float2(0, 0);
    vec2 totalCount = vec2(0, 0);

    // Combine colors for each component using direct indexing
    if (a[0] > 0)
    {
        ret[0] += a[0];
        totalCount[0]++;
    }
    if (a[1] > 0)
    {
        ret[1] += a[1];
        totalCount[1]++;
    }
  

    if (b[0] > 0)
    {
        ret[0] += b[0];
        totalCount[0]++;
    }
    if (b[1] > 0)
    {
        ret[1] += b[1];
        totalCount[1]++;
    }

    // Average the combined colors using direct indexing
    if (totalCount[0] > 0)
    {
        ret[0] /= totalCount[0];
    }
    if (totalCount[1] > 0)
    {
        ret[1] /= totalCount[1];
    }
  
    return ret;
}

inline float dep2D(float2 oosz, Texture2D<float> tex, float2 uv, bool flipDepth, float depthScale, bool scale)
{
    float d = smoothstep(0, 1, saturate(tex.SampleLevel(sampleTypeMirror, uv, 0).r)); // Utilize hardware texture sampling
  
    // Branch optimized through control flow predication
    [flatten]
    if (flipDepth)
        d = 1 - d;
    
    // Constant folding and propagation
    return scale ? depthScale * d : d;
}


inline float dep2D(Texture2D<float> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0).r;
}


inline float2 GetGradientMid(float2 oosz, Texture2D<float> depthMap, float2 uv, bool flipDepth, bool scale)
{
    const float depthLeft = dep2D(oosz, depthMap, uv - float2(oosz.x, 0.0), flipDepth, DepthScale, scale);
    const float depthRight = dep2D(oosz, depthMap, uv + float2(oosz.x, 0.0), flipDepth, DepthScale, scale);
    const float depthUp = dep2D(oosz, depthMap, uv - float2(0.0, oosz.y), flipDepth, DepthScale, scale);
    const float depthDown = dep2D(oosz, depthMap, uv + float2(0.0, oosz.y), flipDepth, DepthScale, scale);

    const float dX = (depthRight - depthLeft) * 0.5;
    const float dY = (depthDown - depthUp) * 0.5;

    return float2(dX, dY);
}

struct AverageGradientMagnitude3
{
    float3 gradient;
    float3 totalMagnitude;
    float3 averageGradient;
};
inline AverageGradientMagnitude3 ComputeAverageGradientMagnitude3D(float2 oosz, Texture2D<float> depthMap, float3 uv, bool flipDepth, bool scale)
{
    AverageGradientMagnitude3 ret;
    
    const vec2 offsets2[4] =
    {
        { -1, -1 },
        { -1, 1 },
        { 1, 1 },
        { 1, -1 },
    };
    
    const vec2 offsets1[4] =
    {
        { 0, -1 },
        { -1, 0 },
        { 1, 0 },
        { 0, 1 }
    };

    float weight1 = 0.0f;
    float weight2 = 0.0f;
    for (int i = 0; i < 4; ++i)
    {
        float3 w = length(offsets1[i]);
        vec2 neighborUV = uv.xy + offsets1[i] * oosz;
        vec3 grad = vec3(GetGradientMid(oosz, depthMap, neighborUV, flipDepth, scale), uv.z);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w;
        ret.averageGradient += grad * w;
        weight1 += w.x + w.y;

        
        float3 w2 = length(offsets2[i]);
        neighborUV = uv.xy + offsets2[i] * oosz;
        grad = vec3(GetGradientMid(oosz, depthMap, neighborUV, flipDepth, scale), uv.z);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w2;
        ret.averageGradient += grad * w2;
        weight2 += w2.x + w2.y;
    }
    
    ret.totalMagnitude / weight1 / weight2;
    ret.averageGradient / weight1 / weight2;
    ret.gradient /= 8;
    
    return ret;
}

// Helper function to map a value from one range to another with scaling and offset
inline float remap(float value, float inMin, float inMax, float outMin, float outMax, float outOffset, float outScale)
{
    float remapped = outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
    return (remapped + outOffset) * outScale;
}
inline float4 remap(float4 value, float4 inMin, float4 inMax, float4 outMin, float4 outMax, float4 outOffset, float4 outScale)
{
    float remapped = outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin);
    return (remapped + outOffset) * outScale;
}
// Logistic function (centered around 0, range [-1, 1])
inline float logistic(float x, float steepness)
{
    return 2.0f / (1.0f + exp(-2.0f * steepness * x)) - 1.0f;
}
inline float4 logistic(float4 x, float4 steepness)
{
    return 2.0f / (1.0f + exp(-2.0f * steepness * x)) - 1.0f;
}
inline float3 logistic(float3 x, float3 steepness)
{
    return 2.0f / (1.0f + exp(-2.0f * steepness * x)) - 1.0f;
}
inline float2 logistic(float2 x, float2 steepness)
{
    return 2.0f / (1.0f + exp(-2.0f * steepness * x)) - 1.0f;
}

inline float sigmoid1(float x, float steepness, float nearValue, float farValue, float offset, float scale)
{
    float normalized = logistic(x, steepness);
    return remap(normalized, -1.0f, 1.0f, nearValue, farValue, offset, scale);
}

inline float4 sigmoid4(float4 x, float4 steepness, float4 nearValue, float4 farValue, float4 offset, float4 scale)
{
    float4 normalized = logistic(x, steepness);
    return remap(normalized, vec4(-1.0f, -1.0f, -1.0f, -1.0f), float4(1.0f, 1.0f, 1.0f, 1.0f), nearValue, farValue, offset, scale);
}

inline float sigmoid1(float x, float steepness, float offset, float scale)
{
    return sigmoid1(x, steepness, SIGMOID_NEAR, SIGMOID_FAR, offset, scale);
}
inline float2 sigmoid2(float2 x, float2 steepness, float2 offset, float2 scale)
{
    return float2(sigmoid1(x.x, steepness.x, SIGMOID_NEAR, SIGMOID_FAR, offset.x, scale.x),
        sigmoid1(x.y, steepness.y, SIGMOID_NEAR, SIGMOID_FAR, offset.y, scale.y));
}
inline float3 sigmoid3(float3 x, float3 steepness, float3 offset, float3 scale)
{
    return float3(sigmoid1(x.x, steepness.x, SIGMOID_NEAR, SIGMOID_FAR, offset.x, scale.x),
        sigmoid1(x.y, steepness.y, SIGMOID_NEAR, SIGMOID_FAR, offset.y, scale.y),
        sigmoid1(x.z, steepness.z, SIGMOID_NEAR, SIGMOID_FAR, offset.z, scale.z));
}
inline float4 sigmoid4(float4 x, float4 steepness, float4 offset, float4 scale)
{
    
    return sigmoid4(x, steepness, SIGMOID_NEAR4, SIGMOID_FAR4, offset, scale);
}



// Vectorized sigmoid function with intrinsic math
inline float sigmoid(float x, float steepness, float nearValue, float farValue, float offset, float scale)
{
    float normalized = logistic(x, steepness);
    return remap(normalized, -1.0f, 1.0f, nearValue, farValue, offset, scale);
}

inline float4 sigmoid(float4 x, float4 steepness, float4 nearValue, float4 farValue, float4 offset, float4 scale)
{
    float4 normalized = logistic(x, steepness);
    return remap(normalized, -1.0f, 1.0f, nearValue, farValue, offset, scale);
}

// Helper functions optimized through constant folding
inline float2 sigmoid(float2 x, float2 steepness)
{
    return float2(sigmoid(x.x, steepness.x, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.y, steepness.y, SIGMOID_NEAR, SIGMOID_FAR, 0, 1));
}

inline float3 sigmoid(float3 x, float3 steepness)
{
    return float3(sigmoid(x.x, steepness.x, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.y, steepness.y, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.z, steepness.z, SIGMOID_NEAR, SIGMOID_FAR, 0, 1));
}

inline float4 sigmoid(float4 x, float4 steepness)
{
    return float4(sigmoid(x.x, steepness.x, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.y, steepness.y, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.z, steepness.z, SIGMOID_NEAR, SIGMOID_FAR, 0, 1),
                  sigmoid(x.w, steepness.w, SIGMOID_NEAR, SIGMOID_FAR, 0, 1));
}

inline float sigmoid(float x, float steepness, float offset, float scale)
{
    return sigmoid(x, steepness, SIGMOID_NEAR, SIGMOID_FAR, offset, scale);
}

inline float3 SelectSigmoidSteepness3D(float3 averageGradientMagnitude, float2 steepnessMinMax)
{
    // Clamp and normalize the gradient magnitude
    float3 normalizedMagnitude = saturate(averageGradientMagnitude);

    // Lerp between minimum and maximum steepness based on normalized gradient magnitude
    return vec3(lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.x),
        lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.y),
    lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.z));
}
inline float2 SelectSigmoidSteepness2D(float2 averageGradientMagnitude, float2 steepnessMinMax)
{
    // Clamp and normalize the gradient magnitude
    float2 normalizedMagnitude = saturate(averageGradientMagnitude);

    // Lerp between minimum and maximum steepness based on normalized gradient magnitude
    return vec2(lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.x),
                lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.y));
}


inline float SelectSigmoidSteepness(float averageGradientMagnitude, float2 steepnessMinMax)
{
    // Clamp and normalize the gradient magnitude
    float normalizedMagnitude = saturate(averageGradientMagnitude);

    // Lerp between minimum and maximum steepness based on normalized gradient magnitude
    return lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude);
}

float3 AdjustSteepness3D(float3 steepness, float3 gradientMagnitude, float threshold, float maxAdjustment)
{
    // Reduce steepness if the gradient magnitude is above a certain threshold
    vec3 ret = steepness;
    
    if (gradientMagnitude.x > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude.x - threshold) / maxAdjustment, 1.0f);
        ret.x = steepness.x * adjustmentFactor;
    }
    if (gradientMagnitude.y > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude.y - threshold) / maxAdjustment, 1.0f);
        ret.y = steepness.y * adjustmentFactor;
    }
    if (gradientMagnitude.z > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude.z - threshold) / maxAdjustment, 1.0f);
        ret.z = steepness.z * adjustmentFactor;
    }
    return ret;
}
float2 AdjustSteepness2D(float2 steepness, float2 gradientMagnitude, float threshold, float maxAdjustment)
{
    // Reduce steepness if the gradient magnitude is above a certain threshold
    vec2 ret = steepness;
    
    if (gradientMagnitude.x > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude.x - threshold) / maxAdjustment, 1.0f);
        ret.x = steepness.x * adjustmentFactor;
    }
    if (gradientMagnitude.y > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude.y - threshold) / maxAdjustment, 1.0f);
        ret.y = steepness.y * adjustmentFactor;
    }
    return ret;
}

inline float AdjustSteepness(float steepness, float gradientMagnitude, float threshold, float maxAdjustment)
{
    // Reduce steepness if the gradient magnitude is above a certain threshold
    if (gradientMagnitude > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude - threshold) / maxAdjustment, 1.0f);
        return steepness * adjustmentFactor;
    }
    return steepness;
}
inline float cosTime01(float timeMul)
{
    return (1.0 + cos(TotalTime * timr * timeMul)) * 0.5;
}
inline float sinTime01(float timeMul)
{
    return (1.0 + sin(TotalTime * timr * timeMul)) * 0.5;
}


float3 ComputeAdjustedDepthCurve3(float2 oosz, Texture2D<float> depthMap, float3 uv, bool flipDepth, bool scale)
{
    float2 steepnessMinMax = float2(0.25, .8);
    const int range = 10;
    
    AverageGradientMagnitude3 averageGradientMagnitude = ComputeAverageGradientMagnitude3D(oosz, depthMap, uv, flipDepth, scale);
    float3 steepness = SelectSigmoidSteepness3D(averageGradientMagnitude.averageGradient, steepnessMinMax);
   
    

    vec3 gradient = sigmoid(averageGradientMagnitude.gradient, vec3(steepnessMinMax, 0));
    
    float3 adjustedSteepness3 = AdjustSteepness3D(steepness, gradient, steepnessMinMax.x, steepnessMinMax.y);
   
    return sigmoid(gradient, adjustedSteepness3);
}


struct AverageGradientMagnitude2
{
    float2 gradient;
    float2 totalMagnitude;
    float2 averageGradient;
};
AverageGradientMagnitude2 ComputeAverageGradientMagnitude2D(float2 oosz, Texture2D<float> depthMap, float2 uv, bool flipDepth, bool scale)
{
    AverageGradientMagnitude2 ret;
    
    const vec2 offsets2[4] =
    {
        { -1, -1 },
        { -1, 1 },
        { 1, 1 },
        { 1, -1 },
    };
    
    const vec2 offsets1[4] =
    {
        { 0, -1 },
        { -1, 0 },
        { 1, 0 },
        { 0, 1 }
    };

    float weight1 = 0.0f;
    float weight2 = 0.0f;
    for (int i = 0; i < 4; ++i)
    {
        float2 w = length(offsets1[i]);
        vec2 neighborUV = uv + offsets1[i] * oosz;
        vec2 grad = GetGradientMid(oosz, depthMap, neighborUV, flipDepth, scale);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w;
        ret.averageGradient += grad * w;
        weight1 += length(w);
        
        float w2 = length(offsets2[i]);
        neighborUV = uv + offsets2[i] * oosz;
        grad = GetGradientMid(oosz, depthMap, neighborUV, flipDepth, scale);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w2;
        ret.averageGradient += grad * w2;
        weight2 += length(w2);
    }
    
    ret.totalMagnitude / weight1 / weight2;
    ret.averageGradient / weight1 / weight2;
    ret.gradient /= 8;
    
    return ret;
}


float2 ComputeAdjustedDepthCurve2(float2 oosz, Texture2D<float> depthMap, float2 uv, bool flipDepth, bool scale)
{
    float2 steepnessMinMax = float2(.25, .8);
    const int range = 10;
    
    AverageGradientMagnitude2 averageGradientMagnitude = ComputeAverageGradientMagnitude2D(oosz, depthMap, uv, flipDepth, scale);
    float2 steepness = SelectSigmoidSteepness2D(
        averageGradientMagnitude.averageGradient, steepnessMinMax);
     
    vec2 gradient = averageGradientMagnitude.gradient;

    gradient = sigmoid(gradient, steepnessMinMax);
    
    float2 adjustedSteepness = AdjustSteepness2D(steepness, gradient, steepnessMinMax.x, steepnessMinMax.y);
    
    return vec2(sigmoid(gradient.x, adjustedSteepness.x, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness.y, 0, 1));
}


inline float ComputeAverageGradientMagnitude(float2 oosz, Texture2D<float> depthMap, float2 uv, float radius, bool flipDepth, bool scale, float sigma = 3.0f)
{
    float filterSize = normalRadius;
    int kernelRadius = max(1, (filterSize - 1) / 2);

    float totalMagnitude = 0.0f;
    float totalWeight = 0;
    int step = max(1, radius / 4);
[unroll(4)]
    for (int i = -kernelRadius; i <= kernelRadius; i += step)
    {
[unroll(4)]
        for (int j = -kernelRadius; j <= kernelRadius; j += step)
        {
[flatten]
            if (i == 0 || j == 0)
                continue;
            float dist = sqrt(i * i + j * j);
                //int weightIndex = min(kernelRadius, dist); // Clamp distance if needed
            
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            totalMagnitude += length(GetGradientMid(oosz, depthMap, uv + float2(i, j) * oosz, flipDepth, scale)) * weight;

            totalWeight += weight;
        }
    }

    return totalMagnitude / totalWeight;
}


float2 ComputeAdjustedDepthCurveO(float2 oosz, Texture2D<float> depthMap, float2 uv, float2 gradient, bool flipDepth, bool scale)
{
    float2 steepnessMinMax = float2(.25, .8);
    const int range = 10;
    
    float averageGradientMagnitude = ComputeAverageGradientMagnitude(oosz, depthMap, uv, normalRadius, flipDepth, scale);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);
   
    

    gradient = sigmoid(gradient, steepnessMinMax);
    
    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);
    
    return vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
}


// New function to compute Sobel gradient separately
inline float2 ComputeSobelGradient(float2 oosz, Texture2D<float> depthTex, float2 uv, float range, bool flipDepth, bool scale, float depthScale)
{
    const float2 offsetTL = range * float2(-oosz.x, -oosz.y);
    const float2 offsetTR = range * float2(oosz.x, -oosz.y);
    const float2 offsetBL = range * float2(-oosz.x, oosz.y);
    const float2 offsetBR = range * float2(oosz.x, oosz.y);
    const float2 offsetL = range * float2(-oosz.x, 0);
    const float2 offsetR = range * float2(oosz.x, 0);
    const float2 offsetT = range * float2(0, -oosz.y);
    const float2 offsetB = range * float2(0, oosz.y);

    const float depthTL = dep2D(oosz, depthTex, uv + offsetTL, flipDepth, depthScale, scale);
    const float depthTR = dep2D(oosz, depthTex, uv + offsetTR, flipDepth, depthScale, scale);
    const float depthBL = dep2D(oosz, depthTex, uv + offsetBL, flipDepth, depthScale, scale);
    const float depthBR = dep2D(oosz, depthTex, uv + offsetBR, flipDepth, depthScale, scale);
    const float depthL = dep2D(oosz, depthTex, uv + offsetL, flipDepth, depthScale, scale);
    const float depthR = dep2D(oosz, depthTex, uv + offsetR, flipDepth, depthScale, scale);
    const float depthT = dep2D(oosz, depthTex, uv + offsetT, flipDepth, depthScale, scale);
    const float depthB = dep2D(oosz, depthTex, uv + offsetB, flipDepth, depthScale, scale);

    float dX = (depthTR + 2.0f * depthR + depthBR) - (depthTL + 2.0f * depthL + depthBL);
    float dY = (depthBL + 2.0f * depthB + depthBR) - (depthTL + 2.0f * depthT + depthTR);

    return float2(dX, dY);
}


inline float2 GetModulation
    (
    float2 depthGradient, float2 depthCurve)
{
    const float2 sigmoidCurve = sigmoid(vec2(depthGradient.y, depthGradient.x), vec2(SIGMOID_NEAR, SIGMOID_FAR));
        
    return sigmoidCurve;
}


inline float2 ComputeAdjustedDepthCurve(float2 oosz, Texture2D<float> depthTex, float2 uv, bool flipDepth, bool scale, float depthScale)
{
    float2 steepnessMinMax = float2(SIGMOID_NEAR, SIGMOID_FAR);
   
    float averageGradientMagnitude = ComputeAverageGradientMagnitude(oosz, depthTex, uv, normalRadius, flipDepth, scale);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);
   
    float2 gradient = ComputeSobelGradient(oosz, depthTex, uv, normalRadius, flipDepth, scale, depthScale);
    gradient = sigmoid(gradient, steepnessMinMax);
    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);

    return float2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
}



inline float3 GetNormal
    (
    float2 oosz,
    Texture2D<float3> normalMap, float2 uv, float dist, float2 gradientModulation, float2 gradient, float2 depthCurve)
{
    
    // Use the sigmoid function to scale the gradient modulation factor
    float2 scaledGradMod = gradientModulation * dist * oosz;
    
    vec3 c = normal2D(normalMap, uv);
    vec3 l = normal2D(normalMap, uv + float2(-1, 0) * scaledGradMod);
    vec3 r = normal2D(normalMap, uv + float2(1, 0) * scaledGradMod);
    vec3 u = normal2D(normalMap, uv + float2(0, -1) * scaledGradMod);
    vec3 d = normal2D(normalMap, uv + float2(0, 1) * scaledGradMod);
    
    vec3 ret = normalize(lerp((l + r + u + d) / 4, c, .75));
    
    //if (dot(-config.viewToPixelDir, ret) < 0)
    {
    //    ret.z = 1-ret.z;
    }
    return ret;
}


// A pixel shader function that performs 2-D Gaussian filtering on images
float4 imgaussfiltPS
    (
    float2 oosz, float2 uv, float sigma, float filterSize)
{
   
    // Calculate the filter radius
    int radius = (filterSize - 1) / 2;

    // Initialize the output color
    float4 output = float4(0, 0, 0, 0);

    // Initialize the normalization factor
    float norm = 0;

    // Loop over the filter kernel
    for (int i = -radius; i <= radius; i++)
    {
        for (int j = -radius; j <= radius; j++)
        {
            // Calculate the distance from the center
            float dist = sqrt(i * i + j * j);

            // Calculate the Gaussian weight
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            // Update the normalization factor
            norm += weight;

            // Sample the neighboring pixel
            float4 neighbor = mir2D(rtMap1, uv + float2(i, j) * oosz);

            // Update the output color
            output += weight * neighbor;
        }
    }

    // Normalize the output color
    output /= norm;

    // Return the output color
    return float4(output.xyz, 1);
}
// A pixel shader function that performs 2-D Gaussian filtering on images
float imgaussfiltPS
    (
    float2 oosz,
    Texture2D<float> tex, float2 uv, float sigma, float filterSize)
{


    // Calculate the filter radius
    int radius = max(1, (filterSize - 1) / 2);

    // Initialize the output color
    float output = 0;

    // Initialize the normalization factor
    float norm = 0;

    // Loop over the filter kernel
    [unroll(10)]
    for (int i = -radius; i <= radius; i += max(1, radius / 4))
    {
        [unroll(10)]
        for (int j = -radius; j <= radius; j += max(1, radius / 4))
        {
            if (j == 0 || i == 0)
                continue;
            // Calculate the distance from the center
            float2 offset = float2(i, j);
            float dist = length(offset);

            // Calculate the Gaussian weight
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            // Update the normalization factor
            norm += weight;

            // Sample the neighboring pixel
            float neighbor = tex.SampleLevel(sampleTypeMirror, uv + offset * oosz, 0).r;

            // Update the output color
            output += weight * neighbor;
        }
    }

    // Normalize the output color
    output /= norm;

    // Return the output color
    return output;
}



float3 imgaussfiltPS
    (
    float2 oosz,
    Texture2D<float3> tex, float2 uv, float sigma, float filterSize, float2 scalar)
{
    // Calculate the filter radius
    int radius = (filterSize - 1) / 2;

    // Initialize the output color
    float3 output = float3(0, 0, 0);

    // Initialize the normalization factor
    float norm = 0;
    int step = max(1, radius / 4);
    // Loop over the filter kernel
    for (int i = -radius; i <= radius; i += step)
    {
        for (int j = -radius; j <= radius; j += step)
        {
            // Calculate the distance from the center
            float dist = sqrt(i * i + j * j);

            // Calculate the Gaussian weight
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            // Update the normalization factor
            norm += weight;

            // Sample the neighboring pixel
            float4 neighbor = float4((mir2D(tex, uv + float2(i, j) * oosz * scalar) * 2 - 1).xyz, 1);

            // Update the output color
            output += weight * neighbor.rgb;
        }
    }

    // Normalize the output color
    output /= norm;

    // Return the output color
    return float4(normalize(output.xyz), 1);
}




  // Define the standard deviation and the filter size
  //  float sigma = 2.0;
 //   int filterSize = 9;
float4 imgaussfiltPS
    (
    float2 oosz, Texture2D tex, float2 texCoord, float sigma, float filterSize)
{
   
    // Calculate the filter radius
    int radius = (filterSize - 1) / 2;

    // Initialize the output color
    float4 output = float4(0, 0, 0, 0);

    // Initialize the normalization factor
    float norm = 0;

    // Loop over the filter kernel
    for (int i = -radius; i <= radius; i++)
    {
        for (int j = -radius; j <= radius; j++)
        {
            // Calculate the distance from the center
            float dist = sqrt(i * i + j * j);

            // Calculate the Gaussian weight
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            // Update the normalization factor
            norm += weight;

            // Sample the neighboring pixel in HSV color space
            float4 neighbor = mir2D(tex, texCoord + float2(i, j) * oosz);
        
            // Update the output color
            output += weight * neighbor;
        }
    }

    // Normalize the output color
    output /= norm;

    // Return the output color
    return output;
}
float4 imgaussfiltPS
    (
    float2 oosz, vec4 input, float2 uv, Texture2D tex, float sigma, float filterSize)
{
    
    // Calculate the filter radius
    int radius = (filterSize - 1) / 2;

    // Initialize the output color
    float4 output = float4(0, 0, 0, 0);

    // Initialize the normalization factor
    float norm = 0;
    
    // Loop over the filter kernel
    for (int i = -radius; i <= radius; i++)
    {
        for (int j = -radius; j <= radius; j++)
        {
            // Calculate the distance from the center
            float dist = sqrt(i * i + j * j);

            // Calculate the Gaussian weight
            float weight = exp(-dist * dist / (2 * sigma * sigma));

            // Update the normalization factor
            norm += weight;

            // Sample the neighboring pixel in HSV color space
            float4 neighbor = combine(input, mir2D(diffuseMap, float2(i, j) * oosz));
            
            // Update the output color
            output += weight * neighbor;
        }
    }

    // Normalize the output color
    output /= norm;
    
    // Return the output color
    return output;
}

float4 XCrossLRUDAvg_RGB2
    (vec2 oosz, Texture2D tex, vec2 uv)
{
    float4 xl = mir2D(tex, uv + oosz * vec2(-1.0, -1.0));
    float4 xr = mir2D(tex, uv + oosz * vec2(1.0, 1.0));
    float4 xu = mir2D(tex, uv + oosz * vec2(1.0, -1.0));
    float4 xdr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0));
    float4 l = mir2D(tex, uv + oosz * vec2(-1.0, -1.0));
    float4 r = mir2D(tex, uv + oosz * vec2(1.0, 1.0));
    float4 u = mir2D(tex, uv + oosz * vec2(1.0, -1.0));
    float4 dr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0));
    
    return float4(lerp(xl.r + xr.r + xu.r + xdr.r / 4, l.r + r.r + u.r + dr.r / 4, .75),
                  lerp(xl.g + xr.g + xu.g + xdr.g / 4, l.g + r.g + u.g + dr.g / 4, .75),
                  lerp(xl.b + xr.b + xu.b + xdr.b / 4, l.b + r.b + u.b + dr.b / 4, .75),
                  lerp(xl.a + xr.a + xu.a + xdr.a / 4, l.a + r.a + u.a + dr.a / 4, .75));
}

float4 XCrossLRUDAvg_RGB2
    (vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient)
{
    float4 xl = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    float4 xr = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    float4 xu = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    float4 xdr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    float4 l = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    float4 r = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    float4 u = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    float4 dr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    
    return float4(lerp(xl.r + xr.r + xu.r + xdr.r / 4, l.r + r.r + u.r + dr.r / 4, .75),
                  lerp(xl.g + xr.g + xu.g + xdr.g / 4, l.g + r.g + u.g + dr.g / 4, .75),
                  lerp(xl.b + xr.b + xu.b + xdr.b / 4, l.b + r.b + u.b + dr.b / 4, .75),
                  lerp(xl.a + xr.a + xu.a + xdr.a / 4, l.a + r.a + u.a + dr.a / 4, .75));
}

void XCrossLRUD_RGB2
    (vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient, out vec4 l, out vec4 r, out vec4 u, out vec4 dr, out vec4 xl, out vec4 xr, out vec4 xu, out vec4 xdr)
{
    xl = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    xr = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    xu = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    xdr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    l = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    r = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    u = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    dr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
}

void XLRUD_RGB2
    (vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient, out vec4 l, out vec4 r, out vec4 u, out vec4 dr)
{
    l = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    r = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    u = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    dr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
}

void CrossLRUD_RGB2
    (
    Texture2D tex, vec2 oosz, vec2 uv, vec2 radius, float2 depthGradient, out vec4 l, out vec4 r, out vec4 u, out vec4 dr)
{
    l = mir2D(tex, uv + oosz * vec2(-1.0, 0.0) * radius * depthGradient);
    r = mir2D(tex, uv + oosz * vec2(1.0, 0.0) * radius * depthGradient);
    u = mir2D(tex, uv + oosz * vec2(0.0, -1.0) * radius * depthGradient);
    dr = mir2D(tex, uv + oosz * vec2(0.0, 1.0) * radius * depthGradient);
}

vec4 XLRUDf
    (vec2 oosz,
    Texture2D<float> tex, vec2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale)
{
    return vec4(
        dep2D(oosz, tex, uv + oosz * float2(-range, -range) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * float2(range, -range) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * float2(-range, range) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * float2(range, range) * depthGradient, flipDepth, depthScale, scale)
    );
}
vec4 XLRUDf
    (vec2 oosz, Texture2D tex, vec2 uv, float range, float2 depthGradient)
{
    return vec4(
        mir2D(tex, uv + oosz * float2(-range, -range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(range, -range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(-range, range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(range, range) * depthGradient).r
    );
}


float XLRUDfAvg
    (
    float2 oosz,
    Texture2D<float> tex, float2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale)
{
    vec4 v = XLRUDf(oosz, tex, uv, range, depthGradient, flipDepth, scale, depthScale);
    return saturate((v.x + v.y + v.z + v.w) / 4.0f);
}



vec4 CrossLRUDf
    (vec2 oosz,
    Texture2D<float> tex, vec2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale)
{
    return
    vec4(
        dep2D(oosz, tex, uv + oosz * vec2(-range, 0) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(range, 0) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(0, -range) * depthGradient, flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(0, range) * depthGradient, flipDepth, depthScale, scale)
    );
}

vec4 CrossLRUDf
    (vec2 oosz,
    Texture2D<float> tex, vec2 uv, float range, bool flipDepth, bool scale, float depthScale)
{
    return
    vec4(
        dep2D(oosz, tex, uv + oosz * vec2(-range, 0), flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(range, 0), flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(0, -range), flipDepth, depthScale, scale),
        dep2D(oosz, tex, uv + oosz * vec2(0, range), flipDepth, depthScale, scale)
    );
}

float CrossLRUDfAvg
    (vec2 oosz,
    Texture2D<float> tex, vec2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale)
{
    vec4 v = CrossLRUDf(oosz, tex, uv, range, depthGradient, flipDepth, scale, depthScale);
    return lerp(dep2D(oosz, tex, uv, flipDepth, depthScale, scale), (v.x + v.y + v.z + v.w) / 4.0, .2);
}

float XCrossLRUDfAvg
    (
    float2 oosz,
    Texture2D<float> tex, vec2 uv, float range, float2 depthGradient, bool flipDepth, bool scale, float depthScale)
{
    float ret = 0;
    float weightTotal = 0;
    for (int x = 0; x < 4; x++)
    {
        ret += lerp(XLRUDfAvg(oosz, tex, uv, range + 1.0, depthGradient, flipDepth, scale, depthScale), CrossLRUDfAvg(oosz, tex, uv, range, depthGradient, flipDepth, scale, depthScale), 0.8);
        weightTotal += range * 2 + 1;
        range -= 2;
        if (range < 2)
            break;
    }
    ret = (ret / (weightTotal) + dep2D(oosz, tex, uv, flipDepth, depthScale, scale));
    return ret;
}

float GetDepth
    (
    Texture2D<float> tex, float2 oosz, float2 uv, float radius, float2 gradient, float2 depthCurve, bool flipDepth, bool scale, float depthScale)
{
    float depth;

    if (radius <= 1)
    {
        depth = dep2D(oosz, tex, uv, flipDepth, depthScale, scale); // Direct sampling for small radius
    }
    else
    {
        const float2 sigmoidCurve = sigmoid(depthCurve, float2(0.5, 0.8));
        
        depth = XCrossLRUDfAvg(oosz, tex, uv, radius, sigmoidCurve * gradient, flipDepth, scale, depthScale);
    }

    return depth;
}

inline float nearDepth()
{
    return config.depth;
}

inline float farDepth()
{
    return config.invDepth;
}

float2 GetGradient(Texture2D<float> tex, float2 oosz, float2 uv, float range, bool flipDepth, bool scale, float depthScale)
{
    const float2 offsetTL = range * float2(-oosz.x, -oosz.y);
    const float2 offsetTR = range * float2(oosz.x, -oosz.y);
    const float2 offsetBL = range * float2(-oosz.x, oosz.y);
    const float2 offsetBR = range * float2(oosz.x, oosz.y);
    const float2 offsetL = range * float2(-oosz.x, 0);
    const float2 offsetR = range * float2(oosz.x, 0);
    const float2 offsetT = range * float2(0, -oosz.y);
    const float2 offsetB = range * float2(0, oosz.y);

    const float depthTL = dep2D(oosz, tex, uv + offsetTL, flipDepth, depthScale, scale);
    const float depthTR = dep2D(oosz, tex, uv + offsetTR, flipDepth, depthScale, scale);
    const float depthBL = dep2D(oosz, tex, uv + offsetBL, flipDepth, depthScale, scale);
    const float depthBR = dep2D(oosz, tex, uv + offsetBR, flipDepth, depthScale, scale);
    const float depthL = dep2D(oosz, tex, uv + offsetL, flipDepth, depthScale, scale);
    const float depthR = dep2D(oosz, tex, uv + offsetR, flipDepth, depthScale, scale);
    const float depthT = dep2D(oosz, tex, uv + offsetT, flipDepth, depthScale, scale);
    const float depthB = dep2D(oosz, tex, uv + offsetB, flipDepth, depthScale, scale);

    const float dX = (depthTR + 2.0f * depthR + depthBR) - (depthTL + 2.0f * depthL + depthBL);
    const float dY = (depthBL + 2.0f * depthB + depthBR) - (depthTL + 2.0f * depthT + depthTR);

    return float2(dX, dY);
}



    // Fresnel-Schlick Reflectivity
float3 FresnelSchlickBaseReflectivity
    (
    float3 base, float3 intensity, float3 metallic)
{
    return float3(lerp(base.x, intensity.x, metallic.x),
                  lerp(base.y, intensity.y, metallic.y),
                  lerp(base.z, intensity.z, metallic.z));
}


inline float2 normalMapOosz
    ()
{
    float2 sz;
    normalMap.GetDimensions(sz.x, sz.y);
    return 1.0 / sz;
}

inline float2 rtMapOosz
    ()
{
    ivec2 iszrt;
    rtMap1.GetDimensions(iszrt.x, iszrt.y);
    return 1.0 / vec2(iszrt);
}

inline float2 depthOosz
    ()
{
    ivec2 isz;
    depthMap.GetDimensions(isz.x, isz.y);
    return 1.0 / vec2(isz);
}

float2 diffuseOosz
    ()
{
    ivec2 iszd;
    diffuseMap.GetDimensions(iszd.x, iszd.y);
    return 1.0 / vec2(iszd);
}



vec2 GetGradientBetween(vec2 oosz, vec2 uv1, vec2 uv2, bool flipDepth, bool scale, float depthScale)
{
    vec2 dir = uv2 - uv1;
    float pixelDistance = length(dir / oosz); // Distance in pixels
    
    // Optimize sampling based on pixel distance
    const float minPixelDistance = 0.5;
    int sampleCount = max(1, min(10, int(ceil(pixelDistance / minPixelDistance))));

    vec2 gradientSum = vec2(0.0, 0.0);
    float totalDepthChange = 0.0;
    float prevDepth = dep2D(oosz, depthMap, uv1, flipDepth, depthScale, scale);

    for (int i = 1; i <= sampleCount; ++i)
    {
        float t = float(i) / float(sampleCount);
        vec2 sampleUV = lerp(uv1, uv2, t);
        float currentDepth = dep2D(oosz, depthMap, sampleUV, flipDepth, depthScale, scale);

        // Calculate depth change and accumulate
        float depthChange = currentDepth - prevDepth;
        totalDepthChange += depthChange;

        // Weighted gradient contribution
        gradientSum += depthChange * (dir / pixelDistance);

        prevDepth = currentDepth;
    }

    // Normalize the gradient by the total depth change
    if (totalDepthChange != 0.0)
    {
        gradientSum /= totalDepthChange;
    }

    return gradientSum;
}

float3 HueToRGB
    (
    float hue)
{
    float r = abs(hue * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(hue * 6.0 - 2.0);
    float b = 2.0 - abs(hue * 6.0 - 4.0);
    return saturate(float3(r, g, b));
}
float RGBtoHue
    (
    float3 rgb)
{
    float M = max(max(rgb.r, rgb.g), rgb.b);
    float m = min(min(rgb.r, rgb.g), rgb.b);
    float C = M - m; // Chroma

    float hue = 0.0; // Initialize hue

    if (C != 0)
    {
        if (M == rgb.r)
        {
            hue = fmod(((rgb.g - rgb.b) / C), 6.0);
        }
        else if (M == rgb.g)
        {
            hue = ((rgb.b - rgb.r) / C) + 2.0;
        }
        else
        {
            hue = ((rgb.r - rgb.g) / C) + 4.0;
        }
        hue *= 60.0;
        if (hue < 0.0)
            hue += 360.0;
    }

    return hue / 360.0; // Normalize to [0, 1]
}


float ApplyGammaCorrection
    (
    float colorComponent)
{
    if (colorComponent > 0.04045f)
    {
        return pow((colorComponent + 0.055f) / 1.055f, 2.4f);
    }
    else
    {
        return colorComponent / 12.92f;
    }
}


float3 CreateRainbowSpectrum(float2 uv, float3 viewDir)
{
    // Adjust the hue based on the viewing direction
    float hueShift = atan2(viewDir.y, viewDir.x) / (2.0 * PI);

    // Calculate the base hue from the UV coordinates
    float baseHue = uv.x + uv.y;

    // Combine the base hue with the directional hue shift
    float finalHue = frac(baseHue + hueShift);

    // Convert the final hue to an RGB color
    return HueToRGB(finalHue);
}




float4 HSVtoRGB
    (
    float4 hsv)
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
        return vec4(v, t, p, 1.0);
    if (i == 1)
        return vec4(q, v, p, 1.0);
    if (i == 2)
        return vec4(p, v, t, 1.0);
    if (i == 3)
        return vec4(p, q, v, 1.0);
    if (i == 4)
        return vec4(t, p, v, 1.0);

    return vec4(v, p, q, 1.0);
}

vec3 RGBtoHSV
    (vec3 rgb)
{
    float R = rgb.r;
    float G = rgb.g;
    float B = rgb.b;
    float maxC = max(R, max(G, B));
    float minC = min(R, min(G, B));
    float delta = maxC - minC;

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


inline vec4 rotateHue
    (vec4 colorRGB, float angle)
{
    vec4 hsv = vec4(RGBtoHSV(saturate(colorRGB.xyz)), 1); // Convert to HSV
    hsv.x += angle; // Rotate the hue
    hsv.x = fmod(hsv.x, 360.0f); // Wrap the hue if it goes out of bounds
    return saturate(HSVtoRGB(hsv));
}
inline vec3 rotateHue
    (vec3 colorRGB, float angle)
{
    vec4 hsv = vec4(RGBtoHSV(saturate(colorRGB)), 1); // Convert to HSV
    hsv.x += angle; // Rotate the hue
    hsv.x = fmod(hsv.x, 360.0f); // Wrap the hue if it goes out of bounds
    return saturate(HSVtoRGB(hsv).rgb);
}
inline float Luminance
    (
    float3 color)
{
    return dot(color, float3(0.2126, 0.7152, 0.0722)); // Standard luminance calculation from RGB
}


float3 lerpSigmoidLuminocity
    (
    float3 baseColor, float3 blendColor1, float3 blendColor2, float alpha, float beta)
{
    float baseLuminance = Luminance(baseColor);
    float blendLuminance1 = Luminance(blendColor1);
    float blendLuminance2 = Luminance(blendColor2);

    // Advanced sigmoid for non-linear mix ratio
    float mixRatio = sigmoid((blendLuminance1 - blendLuminance2) / (1.0 + abs(blendLuminance1 - blendLuminance2)), alpha, beta, 1);
    float3 mixedColor = lerp(blendColor1, blendColor2, mixRatio);

    // Adjust luminance non-linearly
    float mixedLuminance = Luminance(mixedColor);
    float luminanceAdjustment = sigmoid(baseLuminance / mixedLuminance, alpha, beta, 1);
    mixedColor *= luminanceAdjustment;

    return mixedColor;
}


float3 HueShift
    (
    float3 color, float hue)
{
    // Use a rotation matrix to shift the hue of the color
    const float3 k = float3(0.57735, 0.57735, 0.57735); // 1 / sqrt(3)
    float cosAngle = cos(hue);
    float sinAngle = sin(hue);
    return color * cosAngle + cross(k, color) * sinAngle + k * dot(k, color) * (1.0 - cosAngle);
}



float4 ColorCycleEffect
    (
    float4 color, float time)
{
    // Cycle through hues over time
    float hueShift = sin(time) * 0.5 + 0.5;
    return float4(HueShift(color.rgb, hueShift), color.a);
}

// Assume terrainHeight and slope are calculated elsewhere
float AdaptiveErosion
    (
    float terrainHeight, float slope, float time)
{
    float erosionFactor = sigmoid(slope, 0.5, 10.0, 1); // Smooth transition based on slope
    float erosion = randNoise(terrainHeight) * erosionFactor * sin(time); // Dynamic erosion over time
    return terrainHeight - erosion;
}
float3 ProceduralNebula
    (
    float3 position, float time)
{
    float density = PerlinNoise(position * 0.1) * sigmoid(length(position), 0.5, 5.0, 1);
    float3 color = lerp(float3(0.2, 0.3, 0.7), float3(1.0, 0.9, 0.6), density);
    return color * pow(sin(time), 2.0); // Dynamic intensity
}
float RefractionIndex
    (
    float interactionStrength)
{
    return 1.0 + sigmoid(interactionStrength, 0.5, 15.0, 1) * 0.3; // Adjust refraction index
}



struct DichroismParams
{
    float Thickness;
    float RefractiveIndex;
};

float3 FresnelSchlick(float3 F0, float cosTheta, float3 fresnelPower)
{
    F0 = ClampEpsilon11(F0);
    return F0 + (1.0 - F0) * pow(1.0 - ClampEpsilon11(cosTheta), fresnelPower);
}

float3 FresnelSchlick(float3 F0, float3 H, float3 N, float3 power)
{
    return FresnelSchlick(F0, dot(H, N), power);
}


float FresnelSchlick(float refractiveIndex, float surroundingRefractiveIndex, float cosIncidenceAngle, float power)
{
    float F0 = (refractiveIndex * refractiveIndex - surroundingRefractiveIndex * surroundingRefractiveIndex) / (refractiveIndex * refractiveIndex + surroundingRefractiveIndex * surroundingRefractiveIndex);
    return F0 + (1 - F0) * pow(1 - cosIncidenceAngle, power);
}

vec4 Fresnel(vec4 cosTheta)
{
    return exp2((cosTheta * -5.55473 - 6.98316) * cosTheta);
}
vec4 Schlick(vec4 cosTheta, float4 fresnelPower)
{
    return Fresnel(cosTheta) / (cosTheta * (1 - fresnelPower)) * fresnelPower;
}

vec4 Schlick2(vec4 F0, vec4 cosTheta, float4 fresnelPower)
{
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, fresnelPower);
}


vec3 ComputeFresnel(vec3 rayDirection, vec3 normal, vec3 refractiveIndex)
{
    float cosTheta = dot(-rayDirection, normal);
    float3 r0 = (1.0 - refractiveIndex) / (1.0 + refractiveIndex);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow(1.0 - cosTheta, FresnelPower);
}




vec3 FresnelReflectionFN(vec3 lightColor, float fresnel)
{
    return lightColor * fresnel;
}
vec4 FresnelGlow(vec4 value, vec4 fresnel, float brightnessFactor)
{
    // Adjust the brightness of the object based on the Fresnel value
    return value * (brightnessFactor * (1.0 - brightnessFactor) * fresnel);
}

vec4 PhaseFunction(vec4 normal, vec4 viewDir, vec4 phaseFactor)
{
    float cosTheta = dot(normal.xyz, -viewDir.xyz);
    return (1.0f / (4.0f * 3.14159f) * (1.0f + (phaseFactor * cosTheta * cosTheta)));
}

// F0 calculation based on metallic property
float3 metallicF0(float metallic)
{
    float3 F0 = float3(0.04, 0.04, 0.04); // Base reflectivity at normal incidence for non-metallic
    return lerp(F0, F0 * metallic, metallic); // Interpolated based on metallic property
}


float4 DichroicShader(float4 baseColor, DichroismParams params, float3 viewDir, float3 lightDir)
{
  // Calculate the wavelength of light.
    float wavelength = 550.0f * 10e-9f; // 550 nm in meters.

  // Calculate the refractive index of the surrounding medium.
    float surroundingRefractiveIndex = 1.33;

  // Calculate the phase shift of the light due to the thin film.
    float phaseShift = 2.0f * 3.14159265357 * params.Thickness * (sqrt(params.RefractiveIndex * params.RefractiveIndex - surroundingRefractiveIndex * surroundingRefractiveIndex) - surroundingRefractiveIndex);

  // Calculate the transmittance of the thin film.
    float transmittance = (1.0f + cos(phaseShift)) / 2.0f;

  // Calculate the reflected color of the thin film.
    float4 reflectedColor = baseColor * (1.0f - transmittance);

  // Calculate the transmitted color of the thin film.
    float4 transmittedColor = baseColor * transmittance;

  // Calculate the Fresnel coefficient of the thin film.
    float fresnel = FresnelSchlick(params.RefractiveIndex, surroundingRefractiveIndex, ClampEpsilon11(dot(-viewDir, lightDir)), FresnelPower);

    float fresnel2 = FresnelSchlick(1 - params.RefractiveIndex, surroundingRefractiveIndex, ClampEpsilon11(dot(viewDir, lightDir + -viewDir)), FresnelReflectance);

  // Calculate the final color of the surface.
    float4 f = lerp(reflectedColor, transmittedColor, lerp(fresnel, fresnel2, 1 - transmittance * dot(-viewDir, lightDir)));
   
    return float4(f.xyz, 1);
}


float3 diffractLight(float3 lightDir, float3 surfaceNormal, float wavelength)
{
    // Simplified diffraction calculation
    float diffractionAngle = dot(lightDir, surfaceNormal) * wavelength;
    return float3(sin(diffractionAngle), cos(diffractionAngle), sin(-diffractionAngle));
}


float3 diffractionMicrostructureNormal(float2 uv)
{
    return normalize(float3(sin(uv.x * 10.0) * 0.1, sin(uv.y * 10.0) * 0.1, 1.0));
}


// Function to simulate the microstructure normal
float3 diffractionMicrostructureNormalAdvanced(float2 uv)
{
    // Generate a complex microstructure normal
    return normalize(
        float3(randLayeredNoise(float3(uv, 1)),
               randLayeredNoise(float3(uv, 2)),
                1));
}

// Function to calculate diffraction based on microstructure
float3 diffractMicrostructure(float3 normal, float3 lightDir, float lambda)
{
    // Advanced diffraction pattern calculation
    
    // Calculate the angle between the incident light direction and the surface normal.
    float incidentAngle = (dot(normal, lightDir));
    
    // Calculate the wavevector of the incident light based on wavelength (lambda).
    float3 wavevector_incident = normalize(lightDir) * lambda;
    
    // Calculate the wavevector of the scattered light based on the microstructure and Bragg's law.
    float3 wavevector_scattered = wavevector_incident - normal;
    
    // Calculate the phase difference between the incident and scattered waves.
    float phaseDifference = dot(wavevector_scattered - wavevector_incident, normal);
    
    // Calculate the complex-valued diffraction pattern using the phase difference.
    float realPart = cos(phaseDifference);
    float imaginaryPart = sin(phaseDifference);
    
    return float3(realPart, imaginaryPart, 0.0);
}



float getLuminance(float4 color)
{
    return dot(color, float4(0.3, 0.59, 0.11, 1.0));
}

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
    return float3(mul(R, v.xyz).xyz);
}

float4 RotateAroundX(float4 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float4(v.x, c * v.y - s * v.z, s * v.y + c * v.z, v.w);
}
float3 RotateAroundX(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(v.x, c * v.y - s * v.z, s * v.y + c * v.z);
}
float2 RotateAroundX(float2 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float2(v.x, c * v.y - s);
}
float4 RotateAroundY(float4 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float4(c * v.x + s * v.z, v.y, -s * v.x + c * v.z, v.w);
}
float3 RotateAroundY(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(c * v.x + s * v.z, v.y, -s * v.x + c * v.z);
}
float2 RotateAroundY(float2 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float2(c * v.x + s, v.y);
}
float4 RotateAroundZ(float4 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float4(c * v.x - s * v.y, s * v.x + c * v.y, v.z, v.w);
}

float3 RotateAroundZ(float3 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float3(c * v.x - s * v.y, s * v.x + c * v.y, v.z);
}

float2 RotateAroundZ(float2 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float2(c * v.x - s * v.y, s * v.x + c * v.y);
}


float4 ColorCorrectionDynamic(float4 color)
{
    float gamma = 2.2;
    return pow(color, float4(1.0 / gamma, 1.0 / gamma, 1.0 / gamma, 1.0));
}


vec3 Perlin3(vec3 v)
{
    return PerlinNoise(mir2D(noiseMap1, v.xy + v.z).xyz);
}


float IntegrateNoise(float2 uv, float noiseIntensity)
{
    // Placeholder for noise function - replace with actual noise implementation
    float noisev = PerlinNoise(float3(uv * noiseIntensity, noiseIntensity));
    return noisev * noiseIntensity;
}

float3 IntegrateNoise3(float2 uv, float noiseIntensity)
{
    return Perlin3(vec3(uv * TotalTime * timr, length(uv) * TotalTime * timr));

}



struct DepthGradientLRUD
{
    vec2 grad;
    vec4 dcLRUD1;
};



struct DetailedDepthGradient
{
    vec2 gradient;
    vec2 modulation;
    vec4 dcLRUD1;
    vec3 normal;
};





struct DepthNormal
{
    float2 uv;
    float radius;
    float depth;
    float2 gradient;
    float2 depthCurve;
    float2 modulation;
    float3 normal;
    float3 color;
};

vec2 GetView(vec2 viewDir, vec2 uv)
{
    return 2.0 / (1.0 + exp(-(viewDir.xy) * length(uv - 0.5))) - 1.0;
}




float ColorToGray(float3 color)
{
    return 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
}

float4 RainbowOilFilm(float2 texCoord, float3 normal, float3 lightDir, float3 viewDir, float4 color)
{
    // The thickness of the oil film in nanometers
    float thickness = 200.0 + 100.0 * sin(texCoord.x * 10.0) * cos(texCoord.y * 10.0);
    
    // The refractive indices of the oil and air
    float n1 = 1.33; // oil
    float n2 = 1.00; // air
    
    // The angle of incidence between the normal and the light direction
    float theta = acos(dot(normal, lightDir));
    
    // The angle of refraction using Snell's law
    float phi = asin(n2 * sin(theta) / n1);
    
    // The reflectance of the oil film using Fresnel's equations
    float Rs = pow((n1 * cos(theta) - n2 * cos(phi)) / (n1 * cos(theta) + n2 * cos(phi)), 2.0);
    float Rp = pow((n1 * cos(phi) - n2 * cos(theta)) / (n1 * cos(phi) + n2 * cos(theta)), 2.0);
    float R = (Rs + Rp) / 2.0;
    
    // The phase difference between the reflected rays using the thin film interference formula
    float delta = 4.0 * 3.14159 * n1 * thickness * cos(phi) / 550.0; // 550 nm is the wavelength of green light
    
    // The interference color using the RGB color model
    float Ir = R + R * cos(delta - 4.0 * 3.14159 / 3.0); // red component
    float Ig = R + R * cos(delta); // green component
    float Ib = R + R * cos(delta + 4.0 * 3.14159 / 3.0); // blue component
    
    // The final color after adding the interference color to the original color
    float4 result;
    result.r = color.r + Ir;
    result.g = color.g + Ig;
    result.b = color.b + Ib;
    result.a = color.a;
    
    // Return the final color
    return result;
}



vec4 blur3(Texture2D tex, ivec2 iuv, ivec2 iofs, int idist, float strength, vec4 diffuseBlend, float2 gradientModulation)
{
    float2 sz;
    tex.GetDimensions(sz.x, sz.y);
    float2 oosz = 1 / sz;
    float2 fuv = float2(float(iuv.x), float(iuv.y)) * oosz;
    float2 fofs = float2(float(iofs.x), float(iofs.y)) * oosz;
    float dist = float(idist);
    // Sample the original texture
    vec4 color = mir2D(tex, fuv + fofs);
    
    vec4 blurColor[4];

    float lastDist = dist;
    for (int x = 0; x < 4; x++)
    {
        blurColor[x] = lerp(
            (mir2D(tex, (fuv + fofs) + float2(-dist, -dist) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(dist, dist) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(-dist, dist) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(dist, -dist) * oosz * gradientModulation)) / 4.0,
            (mir2D(tex, (fuv + fofs) + float2(-dist, 0) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(dist, 0) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(0, -dist) * oosz * gradientModulation) +
                mir2D(tex, (fuv + fofs) + float2(0, dist) * oosz * gradientModulation)) / 4.0, 0.75);
        dist = float(dist) * 0.75;
        if (int(dist) == int(lastDist))
        {
            for (int k = x + 1; k < 4; k++)
            {
                blurColor[k] = blurColor[x];
            }
            break;
        }
        else
        {
            lastDist = dist;
        }
    }
   
    
    float s0 = strength;
    return ClampEpsilon11(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], 0.35), 0.35), 0.35), s0)) * diffuseBlend;
}

vec4 blur3(vec2 oosz, Texture2D tex, vec2 uv, float dist, float strength, float2 gradientModulation)
{
    // Sample the original texture
    vec4 color = mir2D(tex, uv);
    vec4 blurColor[4];
    
    blurColor[0] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(-dist, -dist) * oosz * gradientModulation);
    blurColor[1] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(dist, dist) * oosz * gradientModulation);
    blurColor[2] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(-dist, dist) * oosz * gradientModulation);
    blurColor[3] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(dist, -dist) * oosz * gradientModulation);
        
    float s0 = strength;
    return ClampEpsilon11(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], 0.35), 0.35), 0.35), s0));
}

vec4 blur4(vec2 oosz, Texture2D tex, vec2 uv, float dist, float strength, float2 gradientModulation, float4 weightsLRUD)
{
    // Sample the original texture
    vec4 color = mir2D(tex, uv);
    vec4 blurColor[4];
    
    blurColor[0] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(-dist, -dist) * oosz * gradientModulation);
    blurColor[1] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(dist, dist) * oosz * gradientModulation);
    blurColor[2] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(-dist, dist) * oosz * gradientModulation);
    blurColor[3] = XCrossLRUDAvg_RGB2(oosz, tex, uv + float2(dist, -dist) * oosz * gradientModulation);
        
    float s0 = strength;
    return ClampEpsilon11(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], weightsLRUD.x), weightsLRUD.y), weightsLRUD.z), weightsLRUD.w));
}

float4 blur2(vec2 oosz, Texture2D tex, vec2 uv, vec2 ofs, float dist, float strength, float2 gradientModulation, float2 detailedGradient)
{
    return blur3(oosz, tex, uv, dist, strength, gradientModulation);

}






vec4 LiquidCrystalPattern2(vec3 position, vec3 direction)
{
    // This function should be replaced with an appropriate pattern generator
    // Placeholder: simple color pattern based on position
    return vec4(sin(position.x), cos(position.y), sin(position.z), 1.0);
}


struct PolarizationEffects
{
    float reflectanceS;
    float reflectanceP; // Reflectance due to polarization
    float transmittanceS;
    float transmittanceP; // Transmittance due to polarization
};

struct SellmeierCoefficient
{
    float B; // Sellmeier coefficient B
    float C; // Sellmeier coefficient C

};

SellmeierCoefficient CreateSellmeierCoefficient(float b, float c)
{
    SellmeierCoefficient ret;
    ret.B = b;
    ret.C = c;
    return ret;
}
struct MaterialProperties
{
    float refractiveIndex;
    float3 baseColor;
    float outsideRefractiveIndex;
    SellmeierCoefficient sellmeierCoefficients[3];
    float smoothness; // Controls specular highlight size and sharpness
    float metalness; // Metallic surfaces reflect differently
    float plasmaFrequency;
    float collisionFrequency;
};
float CalculateRefractiveIndexUsingSellmeier(MaterialProperties material, float wavelength)
{
    // Convert wavelength to micrometers from meters for the equation
    float lambda = wavelength;
    float lambdaSquared = lambda * lambda;
    
    // Calculate the refractive index using the Sellmeier equation
    // Note: This assumes Sellmeier coefficients (B1, B2, B3) and constants (C1, C2, C3) are defined in MaterialProperties
    float nSquared = 1.0 +
                     (material.sellmeierCoefficients[0].B * lambdaSquared) / (lambdaSquared - material.sellmeierCoefficients[0].C) +
                     (material.sellmeierCoefficients[1].B * lambdaSquared) / (lambdaSquared - material.sellmeierCoefficients[1].C) +
                     (material.sellmeierCoefficients[2].B * lambdaSquared) / (lambdaSquared - material.sellmeierCoefficients[2].C);

    // Return the square root of nSquared to get the refractive index
    return sqrt(nSquared);
}

// Calculates the geometric attenuation factor
float GGXGeometry(float NdotV, float alphaRoughness, float NdotL)
{
    float k = (alphaRoughness * alphaRoughness) / 2.0;
    float G1V = NdotV / (NdotV * (1.0 - k) + k);
    float G1L = NdotL / (NdotL * (1.0 - k) + k);
    return G1V * G1L;
}

// Calculates the microfacet distribution
float GGXDistribution(float NdotH, float alphaRoughness)
{
    float alphaRoughness2 = alphaRoughness * alphaRoughness;
    float NdotH2 = NdotH * NdotH;
    float denom = NdotH2 * (alphaRoughness2 - 1.0) + 1.0;
    return alphaRoughness2 / (PI * denom * denom);
}

float GeometrySmith(float3 N, float3 V, float3 L, float roughness)
{
    float NdotV = ClampEpsilon11(dot(N, -V));
    float NdotL = ClampEpsilon11(dot(N, L));
    float ggx1 = ClampEpsilon11(GGXGeometry(NdotV, roughness, NdotL));
    float ggx2 = ClampEpsilon11(GGXGeometry(NdotL, roughness, NdotL));

    return ClampEpsilon11(ggx1 * ggx2);
}


vec4 SpecularTerm(float3 normal, float3 viewDir, float3 lightDir, float4 specularPower, float4 specularIntensity)
{
    // Calculate the reflection vector
    float3 reflectDir = reflect(lightDir, normal);

    // Calculate the specular term
    return pow(ClampEpsilon11(dot(reflectDir, viewDir)), specularPower) * specularIntensity;
}
float ggxDistribution(float NdotH, float roughness)
{
    float alphaRoughness = roughness * roughness;
    float NdotH2 = NdotH * NdotH;
    float denom = NdotH2 * (alphaRoughness - 1.0) + 1.0;
    return alphaRoughness / (PI * denom * denom);
}

// GGX Geometry
float ggxGeometry(float NdotV, float NdotL, float roughness)
{
    float alphaRoughness = roughness * roughness;
    float k = alphaRoughness * 0.5;
    float G1V = NdotV / (NdotV * (1.0 - k) + k);
    float G1L = NdotL / (NdotL * (1.0 - k) + k);
    return G1V * G1L;
}

float SmithGGXCorrelated(float NdotL, float NdotV, float roughness2)
{
    float a2 = max(roughness2 * roughness2, epsilon); // Clamp to prevent division by zero
    float sqrtNdotV = sqrt(max(NdotV, epsilon)); // Clamp to prevent NaN
    float sqrtNdotL = sqrt(max(NdotL, epsilon)); // Clamp to prevent NaN
    float GGXV = NdotL * (sqrtNdotV * sqrtNdotV * (1.0 - a2) + a2);
    float GGXL = NdotV * (sqrtNdotL * sqrtNdotL * (1.0 - a2) + a2);
    return 0.5 / max(GGXV + GGXL, epsilon); // Clamp to prevent division by zero
}

float3 FresnelSchlickDiffuse(float NdotL, float3 F0)
{
    return (1.0 - F0) * (1.0 - pow(max(1.0 - NdotL, epsilon), FresnelPower));
}

float3 FresnelSchlickReflectance(float3 F0, float VdotH, float NdotL)
{
    return F0 + (1.0 - F0) * pow(max(1.0 - VdotH, epsilon), FresnelReflectance);
}


float3 FresnelReflection(float3 F0, float VdotH)
{
    return F0 + (1.0 - F0) * pow(max(1.0 - VdotH, epsilon), 5.0);
}


float2 ComplexIOR(float eta, float plasmaFrequency, float collisionFrequency, float wavelength)
{
    float3 K = eta.xxx;
    float3 G = max((plasmaFrequency * plasmaFrequency) / (collisionFrequency * (collisionFrequency + wavelength * wavelength)), epsilon);
    return float2(eta, sqrt(max(G.r + G.g + G.b, epsilon)));
}

// Fresnel Reflectance for Conductor Materials
float3 FresnelConductor(float3 eta, float3 k, float VdotH)
{
    float3 fresnelr = (eta * eta + k * k) / max(eta * eta + k * k + 2.0 * VdotH, epsilon);
    float3 fresnelit = 2.0 * eta / max(eta * eta + k * k + 2.0 * VdotH, epsilon);
    return (fresnelr * fresnelr + fresnelit * fresnelit) / 2.0;
}

float SigmoidFalloff(float dist, float sigmoid_range, float sigmoid_sharpness)
{
    float x = dist / sigmoid_range;
    return 1.0 / (1.0 + exp(sigmoid_sharpness * (x - 1.0)));
}


// Complex Index of Refraction (Sellmeier-based for dielectrics)
float2 ComplexIOR_Dielectric(MaterialProperties mat, float wavelength)
{
    float lambda2 = wavelength * wavelength;
    float eta2 = 1.0; // Initialize squared index of refraction

    for (int i = 0; i < 3; i++)
    {
        eta2 += mat.sellmeierCoefficients[i].B * lambda2 / (lambda2 - mat.sellmeierCoefficients[i].C);
    }

    float eta = sqrt(eta2);
    float k = 0.0; // No absorption for pure dielectrics
    return float2(eta, k);
}

// Complex Index of Refraction (Drude model for conductors)
float2 ComplexIOR_Conductor(MaterialProperties mat, float wavelength)
{
    float eta2 = 1.0 - mat.plasmaFrequency * mat.plasmaFrequency * wavelength * wavelength / (mat.collisionFrequency * mat.collisionFrequency + wavelength * wavelength);
    float k2 = mat.plasmaFrequency * mat.plasmaFrequency * wavelength / (mat.collisionFrequency * (mat.collisionFrequency + wavelength * wavelength));

    float eta = sqrt(0.5 * (eta2 + sqrt(eta2 * eta2 + k2 * k2)));
    float k = sqrt(0.5 * (-eta2 + sqrt(eta2 * eta2 + k2 * k2)));

    return float2(eta, k);
}

// ----------------------------------------------
// Main Lighting Calculation
// ----------------------------------------------
float3 FresnelSchlick(float cosTheta, float3 F0)
{
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, FresnelPower);
}
float3 CalculateLighting(float3 normal, float3 lightPos, float3 pixelPos, float shininess, float3 ambientColor, float3 diffuseColor, float3 specularColor, float3 lightColor, float lightIntensity, float screenGamma, MaterialProperties mat)
{
    normal = normalize(normal);
    float3 lightDir = normalize(lightPos - pixelPos);
    float3 viewDir = normalize(config.viewPos - pixelPos);

    float distance = length(lightPos - pixelPos);
    float attenuation = 1.0 / (distance * distance); // Inverse square falloff
    
    float3 halfVec = normalize(lightDir + viewDir);
    float NdotL = max(dot(normal, lightDir), 0.0);
    float NdotV = max(dot(normal, viewDir), 0.0);
    float NdotH = max(dot(normal, halfVec), 0.0);
    float VdotH = max(dot(viewDir, halfVec), 0.0);

    // Specular Distribution
    float roughness2 = mat.smoothness * mat.smoothness;
    
    float denom = NdotH * NdotH * (roughness2 - 1.0) + 1.0;
    float D = roughness2 / (PI * denom*denom);

    float k = roughness2 / 2.0;
    float G = SmithGGXCorrelated(NdotL, NdotV, roughness2);

    // -------
    // Fresnel 
    // -------

    float3 F0; // Reflectance at normal incidence 
    float2 eta_k; // Complex index of refraction

    if (mat.metalness > 0.0)
    {
        // Conductor (metal)
        eta_k = ComplexIOR_Conductor(mat, 550.0); // Wavelength for visible light
        F0 = FresnelConductor(eta_k.x, eta_k.y, VdotH);
    }
    else
    {
        // Dielectric 
        float cosThetaI = dot(viewDir, halfVec);
        float sinThetaI2 = 1.0 - cosThetaI * cosThetaI;

        // Check for TIR 
        if (sinThetaI2 > (mat.outsideRefractiveIndex / mat.refractiveIndex) * (mat.outsideRefractiveIndex / mat.refractiveIndex))
        {
            F0 = float3(1.0, 1.0, 1.0); // Total internal reflection
        }
        else
        {
            eta_k = ComplexIOR_Dielectric(mat, 550.0); // Wavelength for visible light
            F0 = FresnelSchlick(cosThetaI, ((eta_k.x - mat.outsideRefractiveIndex) / (eta_k.x + mat.outsideRefractiveIndex)) * ((eta_k.x - mat.outsideRefractiveIndex) / (eta_k.x + mat.outsideRefractiveIndex)));
        }
    }

    // -------
    // Combine into final color
    
   
   // float F = FresnelSchlickReflectance(F0, VdotH, NdotL);
  
   // float3 diffuseC = mat.baseColor * ClampEpsilon(FresnelSchlickDiffuse(NdotL, F0));
   
    float3 diffuse = diffuseColor * (1.0 - F0) * mat.baseColor / PI;
    float3 specular = (F0 * D * G) / (SpecularPower * NdotL * NdotV) * SpecularIntensity;

    float3 color = (diffuse + specular) * attenuation * lightIntensity * lightColor;

    // Apply gamma correction
    return pow(color, 1.0 / screenGamma);
}


float4 CalculateMaterialLighting(float3 diffuse, float3 pixelPos, float3 normal, float3 viewToPixelDir, MaterialProperties mat, float3 attenuation, float aberrationStrength)
{
    float3 lightPos = config.sunPos;
    normal = normalize(normal);
    float3 lightDir = normalize(lightPos - pixelPos);
    float3 viewDir = normalize(config.viewPos - pixelPos);

    float distance = length(lightPos - pixelPos);
    distance *= distance; // Square distance for attenuation

    float3 halfVec = normalize(lightDir + viewDir);
    float NdotL = max(dot(normal, lightDir), 0.0);
    float NdotV = max(dot(normal, viewDir), 0.0);
    float NdotH = max(dot(normal, halfVec), 0.0);
    float VdotH = max(dot(viewDir, halfVec), 0.0);

    float4 lighting = float4(CalculateLighting(normal, config.sunPos, pixelPos, 16, float3(.2, .2, .2), diffuse, mat.baseColor, vec3(1, 1, 1), 40, 2.2, mat), 1);
    
    return lighting;
}


MaterialProperties CreateAluminumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.9137, 0.9137, 0.9217);
    ret.refractiveIndex = 1.44;
    ret.smoothness = 0.8;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.57e16;
    ret.collisionFrequency = 1.08e14;
    return ret;
}

MaterialProperties CreateBerylliumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.09, 0.1 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.8, 0.8, 0.8);
    ret.refractiveIndex = 1.077;
    ret.smoothness = 0.7;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.86e16;
    ret.collisionFrequency = 2.41e14;
    return ret;
}

MaterialProperties CreateChromiumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.5451, 0.5451, 0.5451);
    ret.refractiveIndex = 3.1;
    ret.smoothness = 0.6;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.37e16;
    ret.collisionFrequency = 5.98e13;
    return ret;
}

MaterialProperties CreateLeadMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.3373, 0.3216, 0.3216);
    ret.refractiveIndex = 2.0;
    ret.smoothness = 0.4;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.37e16;
    ret.collisionFrequency = 5.47e13;
    return ret;
}

MaterialProperties CreateMagnesiumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.8, 0.8, 0.9137);
    ret.refractiveIndex = 1.74;
    ret.smoothness = 0.7;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.76e16;
    ret.collisionFrequency = 1.66e14;
    return ret;
}

MaterialProperties CreateMolybdenumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.6588, 0.6588, 0.6588);
    ret.refractiveIndex = 3.9;
    ret.smoothness = 0.6;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.64e16;
    ret.collisionFrequency = 1.86e14;
    return ret;
}

MaterialProperties CreateNickelMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.6588, 0.6196, 0.6196);
    ret.refractiveIndex = 2.2;
    ret.smoothness = 0.5;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.55e16;
    ret.collisionFrequency = 4.05e14;
    return ret;
}

MaterialProperties CreatePalladiumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.7373, 0.7216, 0.6745);
    ret.refractiveIndex = 2.5;
    ret.smoothness = 0.7;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.46e16;
    ret.collisionFrequency = 6.81e13;
    return ret;
}

MaterialProperties CreatePlatinumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.7373, 0.7373, 0.7647);
    ret.refractiveIndex = 2.3;
    ret.smoothness = 0.8;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.37e16;
    ret.collisionFrequency = 6.16e13;
    return ret;
}

MaterialProperties CreateTantalumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.3294, 0.3294, 0.3294);
    ret.refractiveIndex = 2.2;
    ret.smoothness = 0.5;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.59e16;
    ret.collisionFrequency = 1.92e14;
    return ret;
}

MaterialProperties CreateTitaniumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.5451, 0.5451, 0.5451);
    ret.refractiveIndex = 2.5;
    ret.smoothness = 0.6;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.76e16;
    ret.collisionFrequency = 5.59e14;
    return ret;
}

MaterialProperties CreateTungstenMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.3294, 0.3294, 0.3294);
    ret.refractiveIndex = 3.4;
    ret.smoothness = 0.4;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.56e16;
    ret.collisionFrequency = 1.19e14;
    return ret;
}

MaterialProperties CreateVanadiumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.6588, 0.6588, 0.6588);
    ret.refractiveIndex = 3.2;
    ret.smoothness = 0.6;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.71e16;
    ret.collisionFrequency = 5.05e14;
    return ret;
}

MaterialProperties CreateZirconiumMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.6588, 0.6588, 0.6588);
    ret.refractiveIndex = 2.2;
    ret.smoothness = 0.6;
    ret.metalness = 1.0;
    ret.plasmaFrequency = 1.64e16;
    ret.collisionFrequency = 4.95e14;
    return ret;
}

MaterialProperties CreateOpalMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 2.73, 0.0699 };
    SellmeierCoefficient c2 = { 0.2, 0.0631 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 0.7, 0.2);
    ret.refractiveIndex = 1.45;
    ret.smoothness = 0.1;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateMylarMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.0, 0.0 };
    SellmeierCoefficient c2 = { 0.0, 0.0 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.64;
    ret.smoothness = 0.8;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreatePrismMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 1.03, 0.00585 };
    SellmeierCoefficient c2 = { 0.23, 0.0203 };
    SellmeierCoefficient c3 = { 1.01, 100.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.51;
    ret.smoothness = 0.9;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateCrownGlassMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 1.62, 0.0537 };
    SellmeierCoefficient c2 = { 0.31, 0.2058 };
    SellmeierCoefficient c3 = { 1.03, 103.6 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.52;
    ret.smoothness = 0.8;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateSapphireMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 3.04, 0.0647 };
    SellmeierCoefficient c2 = { 0.68, 0.1264 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(.10, 0.9, 0.8);
    ret.refractiveIndex = 1.77;
    ret.smoothness = 0.9;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateDiamondMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 4.68, 0.0766 };
    SellmeierCoefficient c2 = { 0.64, 0.1032 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 2.42;
    ret.smoothness = 0.999;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateRubyMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 1.76, 0.0048 };
    SellmeierCoefficient c2 = { 0.27683, 0.0032 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(0.8, 0.05, 0.05);
    ret.refractiveIndex = 1.77;
    ret.smoothness = 0.5;
    ret.metalness = 0.2;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateBK7GlassMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 1.03, 0.00585 };
    SellmeierCoefficient c2 = { 0.23, 0.0203 };
    SellmeierCoefficient c3 = { 1.01, 100.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.52;
    ret.smoothness = 0.8;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}

MaterialProperties CreateFusedSilicaMaterial()
{
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    SellmeierCoefficient c1 = { 0.69, 0.0068 };
    SellmeierCoefficient c2 = { 0.07, 0.0116 };
    SellmeierCoefficient c3 = { 0.0, 0.0 };
    
    ret.sellmeierCoefficients[0] = c1;
    ret.sellmeierCoefficients[1] = c2;
    ret.sellmeierCoefficients[2] = c3;
    ret.baseColor = float3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.46;
    ret.smoothness = 0.9;
    ret.metalness = 0.0;
    ret.plasmaFrequency = 0.0;
    ret.collisionFrequency = 0.0;
    return ret;
}


MaterialProperties CreateMaterial(int index)
{
    MaterialProperties ret;
    
    switch (abs(index) % 23)
    {
        case 0:
            ret = CreateBK7GlassMaterial();
            break;
        case 1:
            ret = CreateCrownGlassMaterial();
            break;
        case 2:
            ret = CreatePrismMaterial();
            break;
        case 3:
            ret = CreateFusedSilicaMaterial();
            break;
        case 4:
            ret = CreateAluminumMaterial();
            break;
        case 5:
            ret = CreateBerylliumMaterial();
            break;
        case 6:
            ret = CreateChromiumMaterial();
            break;
        case 7:
            ret = CreateLeadMaterial();
            break;
        case 8:
            ret = CreateMagnesiumMaterial();
            break;
        case 9:
            ret = CreateMolybdenumMaterial();
            break;
        case 10:
            ret = CreateMylarMaterial();
            break;
        case 11:
            ret = CreateNickelMaterial();
            break;
        case 12:
            ret = CreatePalladiumMaterial();
            break;
        case 13:
            ret = CreatePlatinumMaterial();
            break;
        case 14:
            ret = CreateTantalumMaterial();
            break;
        case 15:
            ret = CreateTitaniumMaterial();
            break;
        case 16:
            ret = CreateTungstenMaterial();
            break;
        case 17:
            ret = CreateVanadiumMaterial();
            break;
        case 18:
            ret = CreateZirconiumMaterial();
            break;
        case 19:
            ret = CreateDiamondMaterial();
            break;
        case 20:
            ret = CreateOpalMaterial();
            break;
        case 21:
            ret = CreateRubyMaterial();
            break;
        case 22:
            ret = CreateSapphireMaterial();
            break;
    }
    return ret;
}


float3 RefractRay(float3 rayDirection, float3 normal, float refractiveIndex)
{
    // Ensure vectors are normalized
    rayDirection = normalize(rayDirection);
    normal = normalize(normal);

    float cosI = ClampEpsilon11(dot(-rayDirection, normal));

    // Handle edge cases for incident angles
    if (abs(cosI - 1.0) < epsilon || abs(cosI + 1.0) < epsilon)
        return reflect(rayDirection, normal); // Grazing incidence or facing directly

    float sinT2 = refractiveIndex * refractiveIndex * (1.0 - cosI * cosI);
    if (sinT2 > 1.0) // Total internal reflection
        return reflect(rayDirection, normal);

    float cosT = sqrt(max(0.0, 1.0 - sinT2));
    return refractiveIndex * rayDirection + (refractiveIndex * cosI - cosT) * normal;
}



float3 RefractRayByAngle(float3 incidentRay, float3 normal, float refractedAngle)
{
    float3 refractedRay;
    float cosIncidentAngle = ClampEpsilon11(dot(-incidentRay, normal));
    float sinRefractedAngle = sin(refractedAngle);

    if (cosIncidentAngle < 0)
    {
        // Handle total internal reflection if necessary
        cosIncidentAngle = -cosIncidentAngle;
        normal = -normal;
    }

    float sinIncidentAngle = sqrt(1.0 - cosIncidentAngle * cosIncidentAngle);
    if (sinIncidentAngle / sinRefractedAngle > 1.0)
    {
        // Total internal reflection
        refractedRay = reflect(incidentRay, normal);
    }
    else
    {
        float cosRefractedAngle = sqrt(1.0 - sinRefractedAngle * sinRefractedAngle);
        refractedRay = sinRefractedAngle * -normalize(cross(normal, cross(-normal, incidentRay))) - cosRefractedAngle * normal;
    }

    return refractedRay;
}



float CalculateIncidentAngle(float3 incidentRay, float3 normal)
{
    return ClampEpsilon11(dot(-normalize(incidentRay), normalize(normal)));
}


float CalculateRefractedAngle(float3 incidentRay, float3 normal, float refractiveIndex1, float refractiveIndex2)
{
    // Validate refractive indices
    if (refractiveIndex1 <= 0.0 || refractiveIndex2 <= 0.0)
        return 0.0; // Invalid indices return zero angle

    // Normalize inputs
    normal = normalize(normal);
    incidentRay = normalize(incidentRay);

    // Calculate cosine of the incident angle using the dot product
    float cosIncidentAngle = dot(-incidentRay, normal);

    // Edge cases for incident angle
    if (abs(cosIncidentAngle) < epsilon)
        return 0.0; // Grazing incidence
    if (abs(cosIncidentAngle - 1.0) < epsilon)
        return PI / 2; // Perpendicular incidence

    // Calculate sine of incident and refracted angles
    float sinIncidentAngle = sqrt(max(0.0, 1.0 - cosIncidentAngle * cosIncidentAngle));
    float sinRefractedAngle = (refractiveIndex1 / refractiveIndex2) * sinIncidentAngle;

    // Check for total internal reflection
    if (sinRefractedAngle > 1.0)
        return PI / 2; // Angle of 90 degrees for total internal reflection

    float cosRefractedAngle = sqrt(max(0.0, 1.0 - sinRefractedAngle * sinRefractedAngle));
    return acos(clamp(cosRefractedAngle, -1.0, 1.0));
}



// Linear interpolation function
float LinearInterpolate(float x, float x0, float y0, float x1, float y1)
{
    return y0 + (x - x0) * (y1 - y0) / (x1 - x0);
}


float3 RefractRay(float3 incidentRay, float3 normal, float n1, float n2)
{
    float cosI = dot(-normalize(incidentRay), normalize(normal));
    float sinT2 = (n1 / n2) * (n1 / n2) * (1.0 - cosI * cosI);
    if (sinT2 > 1.0)
        return reflect(incidentRay, normal); // Total internal reflection condition
    float cosT = sqrt(1.0 - sinT2);
    return normalize((n1 / n2) * incidentRay + (n1 / n2 * cosI - cosT) * normal);
}



// Example function to calculate spectral intensity (simplified)
float CalculateIntensity(MaterialProperties mat, float wavelength, float sourceIntensity)
{
    float refractiveIndex = CalculateRefractiveIndexUsingSellmeier(mat, wavelength);
    float transmission = 0.99; // Assume 90% transmission for simplification

    // Incorporate dispersion effects (simplified)
    float dispersionEffect = ClampEpsilon11(refractiveIndex - 1.0); // Simplified dispersion effect

    return ClampEpsilon11(sourceIntensity * transmission - dispersionEffect);
}

// Calculate chromatic dispersion and Fresnel reflectance
vec3 calculateChromaticDispersionFresnel(vec3 normal, vec3 viewDir, vec3 IOR, vec3 lightColor)
{
    // Calculate cosTheta using the dot product between the normal and view direction
    float cosTheta = ClampEpsilon11(dot(normal, -viewDir));

    // Assuming IOR is the refractive index for RGB components, calculate Fresnel reflectance for each
    vec3 F0 = ((IOR - 1.0) / (IOR + 1.0)) * ((IOR - 1.0) / (IOR + 1.0));
    vec3 fresnelReflectance = FresnelSchlick(F0, cosTheta, float3(FresnelPower, FresnelPower, FresnelPower));

    // Apply the Fresnel effect to the light color
    vec3 resultColor = lightColor * fresnelReflectance;

    return resultColor;
}


float Falloff(float distance, float radius, float exponent)
{
    return pow(1.0 - ClampEpsilon11(distance / radius), exponent);
}



vec3 DiffuseLighting(vec3 normal, vec3 lightDir, vec3 lightColor, float fresnel, float lightIntensity)
{
    float diffFactor = saturate(ClampEpsilon11(dot(normal, -lightDir)));
    return (1.0 - fresnel) * diffFactor * lightColor * lightIntensity;
}

vec4 CombineLighting(vec4 diffuse, vec4 reflection)
{
    return diffuse + reflection;
}


float scaleRange(float value, float minRange, float maxRange)
{
    return minRange + (value * (maxRange - minRange));
}



float ConeDistanceToSphere(vec3 coneTip, vec3 coneDir, float coneAngle, vec3 sphereCenter, float sphereRadius)
{
    vec3 v = sphereCenter - coneTip;
    float d = ClampEpsilon11(dot(normalize(v), normalize(coneDir)));
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return max(0.0, h - sphereRadius);
}


bool PointInsideCone(vec3 p, vec3 coneTip, vec3 coneDir, float coneAngle)
{
    vec3 v = p - coneTip;
    float d = dot(normalize(v), normalize(coneDir));
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return h <= 0.0;
}

vec3 palette(float t)
{
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b * cos(6.28318 * (c * t + d));
}


vec3 ProjectPointInsideCone(vec3 p, vec3 coneTip, vec3 coneDir, float coneAngle)
{
    vec3 v = p - coneTip;
    float d = dot(normalize(v), normalize(coneDir));
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return p - h * normalize(coneDir);
}


vec4 chromaticAberration0(Texture2D<float3> tex, vec2 uv, vec3 normal, vec2 strength, vec4 chromaOffset)
{
    vec3 colorR = normal2D(tex, uv + strength * vec2(chromaOffset.x, chromaOffset.y));
    vec3 colorG = normal2D(tex, uv);
    vec3 colorB = normal2D(tex, uv - strength * vec2(chromaOffset.z, chromaOffset.w));
    return vec4(colorR.r, colorG.g, colorB.b, 1.0);
}

vec4 chromaticAberration0(Texture2D tex, vec2 uv, vec3 normal, vec2 strength, vec4 chromaOffset)
{
    return slerp(mir2D(tex, uv), vec4(
        imgaussfiltPS(config.oosz, uv + strength * vec2(chromaOffset.x, chromaOffset.y), 3, config.depthRange).r,
        mir2D(tex, uv).g,
        imgaussfiltPS(config.oosz, uv - strength * vec2(chromaOffset.z, chromaOffset.w), 3, config.depthRange).b, 1), .5);
    
    
}

vec4 ChromaticAberration1(vec4 fresnel, float phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + offsets.xyz) * (phase + offsets.xyz), 1.0);

    return ClampEpsilon11(chroma);
}
vec4 ChromaticAberration2(vec4 fresnel, vec2 phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + offsets.xyz) * vec3(phase.xy + offsets.xy, offsets.z), 1.0);

    return ClampEpsilon11(chroma);
}
vec4 ChromaticAberration3(vec4 fresnel, vec2 phase, vec2 chromaOffset)
{
    vec2 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + vec3(offsets.xy, 1.0)) * vec3(phase.xy + offsets.xy, 1.0), 1.0);

    return ClampEpsilon11(chroma);
}

vec4 ChromaticAberration4(vec4 fresnel, vec4 phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset; // RGB channel offsets
    vec4 chroma = (fresnel + offsets) * (phase + offsets);

    return ClampEpsilon11(chroma);
}


vec3 FresnelGlow(vec4 objectColor, vec4 fresnelColor, vec4 halfVec, vec4 viewDir)
{
    // Calculate Fresnel reflection coefficient (R)
    vec3 R = FresnelSchlick(combine(objectColor, fresnelColor).xyz, halfVec.xyz, viewDir.xyz, float3(FresnelPower, FresnelPower, FresnelPower)); // Use the Fresnel equation or approximation

    // Modulate the object color with the Fresnel color
    vec3 glowColor = combine(objectColor, fresnelColor).rgb * R;

    return glowColor;
}


vec2 correctUV(vec3 dir)
{
    return vec2(
        atan2(dir.x - 0.5, dir.z) / (2.0 * 3.14159) + 0.5,
        acos(dir.y - 0.5));
}

void UpdateConfig(inout GradientModulationConfig config, float2 uv, bool scale)
{
    config.uv = uv;
    config.diffuse = mir2D(diffuseMap, config.uv);
    
    // Compute gradient and modulation
    config.gradient = GetGradient(depthMap, config.oosz, config.uv, normalRadius, config.flipDepth, scale, config.depthScale);
   
    // Compute depth-related values
    config.depthCurve = ComputeAdjustedDepthCurve(config.oosz, depthMap, config.uv, config.flipDepth, scale, config.depthScale);
    config.modulation = GetModulation(config.gradient, config.depthCurve);
    
    config.depth = GetDepth(depthMap, config.oosz, config.uv, normalRadius, config.gradient, config.depthCurve, config.flipDepth, scale, config.depthScale);
    
    if (scale)
    {
        config.invDepth = (1 - config.depth / config.depthScale) * config.depthScale;
    }
    else
    {
        config.invDepth = (1 - config.depth);
    }
    
    vec3 centerScaled = vec3(vec2(.5, .5), dep2D(config.oosz, depthMap, vec2(.5, .5), config.flipDepth, config.depthScale, scale));

    config.pixelScaled = vec3(config.uv, config.depth);
    
    // Compute view-related vectors
    config.viewToPixelDir = normalize(config.pixelScaled - config.viewPos);
    config.centerDist = distance(config.pixelScaled, centerScaled);


    // Compute normal and light-related vectors
    config.normal = GetNormal(config.oosz, normalMap, config.uv, normalRadius, config.modulation, config.gradient, config.depthCurve);

    config.pixelToSunSegment = config.sunPos - config.pixelScaled;
    config.pixelToSunDir = normalize(config.pixelToSunSegment);
    
    config.sunHalfVec = normalize(reflect(-config.pixelToSunDir, config.normal) + config.viewToPixelDir);
    config.HdotV = ClampEpsilon11(dot(-config.sunHalfVec, -config.viewToPixelDir));
    config.NdotH = ClampEpsilon11(dot(-config.sunHalfVec, config.normal));
    config.NdotV = ClampEpsilon11(dot(config.normal, -config.viewToPixelDir));
    config.NdotL = ClampEpsilon11(dot(config.pixelToSunDir, config.normal));

    // Compute initial reflection vector and factor
    config.reflectDir = normalize(reflect(config.sunHalfVec, config.normal));
    config.reflectFactor = ClampEpsilon11(dot(config.reflectDir, -config.viewToPixelDir));
    
    config.depthCross = CrossLRUDf(config.oosz, depthMap, config.uv, normalRadius + ceil(normalRadius * .2), config.gradient, config.flipDepth, scale, config.depthScale);
    
    config.depthRange = variation(config.depthCross);
}



GradientModulationConfig InitializeConfig(float2 oosz, float timeFactor, float2 uv0, float2 ooszd, float2 ooszrt, float3 viewPos, bool flipDepth, bool scale, float depthScale)
{
    
    config.flipDepth = flipDepth;
    config.depthScale = depthScale;
    ivec2 isz;
    depthMap.GetDimensions(isz.x, isz.y); // Get the dimensions of the depth map texture
    config.isz = isz;
    config.uv0 = config.uv = uv0;
    
    config.timeFactor = timeFactor;
    
    config.diffuse = config.diffuse0 = mir2D(diffuseMap, config.uv);
    config.oosz = oosz;
    config.ooszd = ooszd;
    config.ooszrt = ooszrt;
    config.viewPos0 = vec3(viewPos.x, viewPos.y, viewPos.z);
    config.viewPos = config.viewPos0;
    config.sunPos = float3(.5, .5, SunZ * DepthScale);
    
    config.viewDir = normalize(vec3(config.uv, 0) - config.viewPos);
    


    config.gradient = config.gradient0 = GetGradient(depthMap, oosz, config.uv0, normalRadius, config.flipDepth, scale, config.depthScale);
    config.depthCurve = config.depthCurve0 = ComputeAdjustedDepthCurve(oosz, depthMap, config.uv0, config.flipDepth, scale, config.depthScale);
    
    config.depth = config.depth0 = GetDepth(depthMap, oosz, config.uv0, normalRadius, config.gradient, config.depthCurve, flipDepth, scale, config.depthScale);
    
    
    if (scale)
    {
        config.invDepth = (1 - config.depth / config.depthScale) * config.depthScale;
    }
    else
    {
        config.invDepth = (1 - config.depth);
    }
    config.modulation = config.modulation0 = GetModulation(config.gradient, config.depthCurve);
    config.normal = config.normal0 = GetNormal(oosz, normalMap, config.uv0, normalRadius, config.modulation, config.gradient, config.depthCurve);
    vec3 centerScaled = vec3(vec2(.5, .5), dep2D(oosz, depthMap, vec2(.5, .5), flipDepth, config.depthScale, scale));
    
    config.pixelScaled = config.pixel0Scaled = vec3(config.uv, config.depth);
    config.centerDist0 = config.centerDist = distance(config.pixelScaled, centerScaled);
    
    config.viewToPixelDir = config.viewToPixel0Dir = normalize(config.pixelScaled - config.viewPos);
    config.pixelToSunSegment = config.pixel0ToSunSegment = config.sunPos - config.pixelScaled;
    config.pixelToSunDir = config.pixel0ToSunDir = normalize(config.pixelToSunSegment);

    config.sunHalfVec = normalize(reflect(-config.pixelToSunDir, -config.normal) + -config.viewToPixelDir);
    config.HdotV = ClampEpsilon11(dot(-config.sunHalfVec, -config.viewToPixelDir));
    config.NdotH = ClampEpsilon11(dot(-config.sunHalfVec, config.normal));
    config.NdotV = ClampEpsilon11(dot(config.normal, -config.viewToPixelDir));
    config.NdotL = ClampEpsilon11(dot(config.pixelToSunDir, config.normal));

    config.reflectDir = normalize(reflect(config.sunHalfVec, config.normal));
    config.reflectFactor = ClampEpsilon11(dot(config.reflectDir, -config.viewToPixelDir));

    
    config.depthCross = CrossLRUDf(config.oosz, depthMap, config.uv, normalRadius + ceil(normalRadius * .2), config.gradient, config.flipDepth, scale, config.depthScale);
    config.depthRange = variation(config.depthCross);
    
    return config;
}




float4 CalculateOcclusionFactor(vec2 uv, vec2 sz, float d, float normalOcclusionFactor, float2 gradientModulation, GradientModulationConfig config, bool flipDepth, float depthScale, bool scale)
{
    vec2 oosz = 1 / sz;
    float sd = (d);
    float4 ret = 0;
    float tot = 0;
    float dist = 1;
    float diffRange = (sd - OCCLUSION_MIN_DIFFERENCE);
    [unroll]
    for (int dx = -2; dx <= 2; ++dx)
    {
        [unroll]
        for (int dy = -2; dy <= 2; ++dy)
        {
            if (dx == 0 || dy == 0)
                continue;
            
            float weight = 1 / (1 + length(float2(dx, dy)));
            float2 offset = float2(dx, dy) * (dist / 2) * weight;
            
            float td = dep2D(oosz, depthMap, uv + offset * oosz * gradientModulation, flipDepth, depthScale, scale);
            if (td < diffRange)
            {
                ret += weight * (sd - td);
                tot += weight;
            }
        }
    }
    return tot == 0 ? 0 : ClampEpsilon11(ret / tot);
}
// HLSL syntax for a Gaussian Bloom effect


// Helper function to calculate Gaussian weight
float Gaussian(float x, float sigma)
{
    return exp(-0.5 * (x * x) / (sigma * sigma)) / (sigma * sqrt(2.0 * 3.14159265));
}

// Gaussian bloom implementation
float4 GaussianBloom(float2 oosz, Texture2D tex, float2 uv, float dist, float threshold, float4 minColor, float3 power, float sigma)
{
    const int radius = 3; // Gaussian blur radius
   
    // Sample the original texture
    float4 color = mir2D(tex, uv);

    // Initialize variables for Gaussian blur
    float4 blurColor = float4(0.0, 0.0, 0.0, 0.0);
    float totalWeight = 0.0;

    // Apply Gaussian blur in a 3x3 kernel around the pixel
    [unroll]
    for (int dx = -radius; dx <= radius; ++dx)
    {
        [unroll]
        for (int dy = -radius; dy <= radius; ++dy)
        {
            if (dx == 0 || dy == 0)
                continue;
            float2 offset = float2(dx, dy) * dist * oosz;
            float weight = Gaussian(length(offset), sigma);
            blurColor += weight * mir2D(tex, uv + offset);
            totalWeight += weight;
        }
    }
    blurColor /= totalWeight;

    // Dynamic blending based on brightness and threshold
    float brightness = max(max(color.r, color.g), color.b);
    if (brightness >= threshold)
    {
        float blendedColorR = lerp(color.x, max(minColor.x, saturate(blurColor.x + float4(brightness, brightness, brightness, 0.0))), power.x);
        float blendedColorG = lerp(color.y, max(minColor.y, saturate(blurColor.y + float4(brightness, brightness, brightness, 0.0))), power.y);
        float blendedColorB = lerp(color.z, max(minColor.z, saturate(blurColor.z + float4(brightness, brightness, brightness, 0.0))), power.z);
        
        return float4(saturate(float3(blendedColorR, blendedColorG, blendedColorB)), 1); // Ensure the result is clamped between 0 and 1
    }

    return saturate(color); // Return the original color if below the threshold
}



// bloom2 function
float4 bloom2(float2 oosz, Texture2D tex, float2 uv, float dist, float threshold, float2 gradientModulation, float2 detailedGradient)
{
  // Sample the original texture
    float4 color = mir2D(tex, uv);

  // Blur the color
    float4 blurColor = mir2D(tex, uv + float2(-dist, -dist) * 0.5f * oosz * gradientModulation)
    + mir2D(tex, uv + float2(dist, dist) * 0.5f * oosz * gradientModulation)
    + mir2D(tex, uv + float2(-dist, dist) * 0.5f * oosz * gradientModulation)
    + mir2D(tex, uv + float2(dist, -dist) * 0.5f * oosz * gradientModulation)
    + mir2D(tex, uv + float2(-dist, 0.0f) * oosz * gradientModulation)
    + mir2D(tex, uv + float2(dist, 0.0f) * oosz * gradientModulation)
    + mir2D(tex, uv + float2(0.0f, -dist) * oosz * gradientModulation)
    + mir2D(tex, uv + float2(0.0f, dist) * oosz * gradientModulation);

  // Average the blur samples
    blurColor *= 0.25f + 0.15f;

  // Blend with original color if exceeds threshold
    if (max(max(color.r, color.g), color.b) > threshold)
    {
        color += blurColor;
    }

    return ClampEpsilon11(color);
}



vec4 RedBlueDepthEffect(vec2 oosz, Texture2D tex, vec2 uv, float depth, vec2 eyeOffset, vec4 diffuseColor, float2 modulation, float2 gradient)
{
    // Calculate left and right eye UV coordinates
    vec2 ofsL = float2(eyeOffset.x, 0);
    vec2 ofsR = float2(eyeOffset.y, 0);
    
    vec2 leftUV = uv + ofsL;
    vec2 rightUV = uv - ofsR;

    // Sample the scene from the perspective of each eye
    vec3 leftEyeColor = float4(mir2D(tex, leftUV).xyz, diffuseColor.w);
    vec3 rightEyeColor = float4(mir2D(tex, rightUV).xyz, diffuseColor.w);
    
    return vec4(saturate(vec3(leftEyeColor.x, diffuseColor.y, rightEyeColor.b)), diffuseColor.w);
}

vec2 holographicDistortion(vec2 uv, float intensity, float2 scale, float scaledDepth, GradientModulationConfig config, float2 modulation)
{
    float2 distortion = float2(sin(uv.y * scaledDepth * scale.y * modulation.y),
	                           cos(uv.x * scaledDepth * scale.x * modulation.x)) * intensity;
    return distortion;
}

// Function for dynamic color manipulation
vec4 dynamicColor(vec4 color, float depth, float time)
{
    // Creating a vibrant, shifting color effect based on depth
    float colorShift = sin(time + depth * 1.0);
    return color * vec4(1.0 + colorShift, 1.0, 1.0 - colorShift, 1.0);
}

float3 VibrantColorPalette(float t, float timeFactor)
{
    // Create a vibrant and colorful palette using sine waves
    float r = sin(t * 2.0 + timeFactor / (1 + timr) * 1.0) * 0.5 + 0.5;
    float g = sin(t * 3.0 + timeFactor / (1 + timr) * 2.0) * 0.5 + 0.5;
    float b = sin(t * 4.0 + timeFactor / (1 + timr) * 3.0) * 0.5 + 0.5;
    
    // Combine the colors and return
    return float3(r, g, b);
}


float4 ColorAutoContrast(float4 color)
{
    float3 minColor = float3(0.0, 0.0, 0.0);
    float3 maxColor = float3(1.0, 1.0, 1.0);
    float3 correctedColor = (color.rgb - minColor) / (maxColor - minColor);
    return float4(correctedColor, color.a);
}
float4 ColorInputLevels(float4 color, float3 minInput, float3 maxInput, float3 minOutput, float3 maxOutput)
{
    float3 correctedColor = (color.rgb - minInput) / (maxInput - minInput);
    correctedColor = correctedColor * (maxOutput - minOutput) + minOutput;
    return float4(correctedColor, color.a);
}
float4 ColorGammaCorrection(float4 color, float gamma)
{
    float3 correctedColor = pow(color.rgb, float3(1.0 / gamma, 1.0 / gamma, 1.0 / gamma));
    return float4(correctedColor, color.a);
}

float4 ColorBalance(float4 color, float3 balance)
{
    float3 correctedColor = color.rgb + balance;
    float luminance = ClampEpsilon11(dot(color.rgb, float3(0.2126, 0.7152, 0.0722)));
    float3 luminanceVec = float3(luminance, luminance, luminance);
    correctedColor.r = lerp(luminanceVec.r, correctedColor.r, balance.r);
    correctedColor.g = lerp(luminanceVec.g, correctedColor.g, balance.g);
    correctedColor.b = lerp(luminanceVec.b, correctedColor.b, balance.b);
    return float4(correctedColor, color.a);
}

float4 ColorSaturation(float4 color, float saturation)
{
    float luminance = ClampEpsilon11(dot(color.rgb, float3(0.2126, 0.7152, 0.0722)));
    float3 grey = float3(luminance, luminance, luminance);
    float3 correctedColor = lerp(grey, color.rgb, saturation);
    return float4(correctedColor, color.a);
}

float4 ColorWhiteBalance(float4 color, float temperature, float tint)
{
    // Convert temperature and tint to scale factors
    float3 tempColor = float3(temperature, temperature, 1.0 - temperature);
    float3 tintColor = float3(1.0 - tint, tint, 1.0 - tint);

    float3 correctedColor = color.rgb * tempColor * tintColor;
    return float4(correctedColor, color.a);
}


struct GlassMarchResult
{
    float3 color;
    float3 dispersionColor[3];
    float3 diffuseS;
    float3 diffuseP;
    float3 normal;
    float depth;
    float traveledDistance;
    float2 uv;
};

struct ParallaxResult
{
    float2 uv;
};
struct ParallaxLayerResult
{
    float2 uv;
    int isValid;
    int isCompleted;
};
void InitializeParallaxLayerResult(inout ParallaxLayerResult ret)
{
    ret.uv = vec2(0, 0);
    ret.isCompleted = 0;
    ret.isValid = 0;
}




float3 SubsurfaceScattering(float2 oosz, float2 uv, Texture2D sceneMap, Texture2D<float> depthMap, bool flipDepth, float depthScale, bool scale)
{
    float depth = dep2D(oosz, depthMap, uv, flipDepth, depthScale, scale);
    float3 baseColor = mir2D(sceneMap, uv).rgb;
    float3 blurColor = float3(0, 0, 0);
    for (int x = -2; x <= 2; x++)
    {
        for (int y = -2; y <= 2; y++)
        {
            float2 offsetUV = uv + float2(x, y) * 2 * oosz;
            float sampleDepth = dep2D(oosz, depthMap, offsetUV, flipDepth, depthScale, scale);
            float falloff = max(0.0, 1.0 - (depth - sampleDepth) * 10.0);
            blurColor += falloff * mir2D(sceneMap, offsetUV).rgb;
        }
    }
    blurColor /= 25.0;
    return lerp(baseColor, blurColor, 0.3); // Mix the base color with the blurred color
}


float3 ChromaticDispersion(float3 rayDir, float3 prismNormal, float eta)
{
    float3 refractedRay = refract(rayDir, prismNormal, eta);
    return float3(refractedRay.x, refractedRay.y, rayDir.z); // Separate R, G, B channels
}

float3 RayleighScattering(float3 rayDir, float3 pixelToSunDir, float atmosphereDensity)
{
    return atmosphereDensity * pow(dot(rayDir, pixelToSunDir), 2.0);
}

float HeatHaze(float2 oosz, Texture2D<float> tex, float2 uv, float time)
{
    float2 distortion = sin(uv.y * 30.0 + time * 5.0) * 5 * oosz;
    float2 distortedUV = uv + distortion;
    return mir2D(tex, distortedUV);
}

float3 HeatHaze(float2 oosz, Texture2D tex, float2 uv, float time)
{
    float2 distortion = sin(uv.y * 30.0 + time * 5.0) * 5 * oosz;
    float2 distortedUV = uv + distortion;
    return mir2D(tex, distortedUV).rgb;
}

float RadicalInverse(uint x)
{
    // Reverse the bits of x
    x = (x << 16) | (x >> 16);
    x = ((x & 0x00ff00ff) << 8) | ((x & 0xff00ff00) >> 8);
    x = ((x & 0x0f0f0f0f) << 4) | ((x & 0xf0f0f0f0) >> 4);
    x = ((x & 0x33333333) << 2) | ((x & 0xcccccccc) >> 2);
    x = ((x & 0x55555555) << 1) | ((x & 0xaaaaaaaa) >> 1);
    // Divide by 2^32
    return float(x) * 2.3283064365386963e-10;
}

// Returns the Hammersley point set of size n
float2 Hammersley(uint i, uint n)
{
    return float2(float(i) / float(n), RadicalInverse(i));
}
    
float3 BokehDOF(float2 oosz, float2 uv, Texture2D<float> depthTex, Texture2D sceneTex, float focusDepth, float bokehRadius, float2 gradientModulation, bool flipDepth, float depthScale, bool scale)
{
    float depth = dep2D(oosz, depthTex, uv, flipDepth, depthScale, scale);
    float circleOfConfusion = abs(depth - focusDepth) * bokehRadius;
    float3 color = float3(0, 0, 0);
    int samples = 8; // Customize as needed
    for (int i = 0; i < samples; i++)
    {
        float2 sampleUV = uv + Hammersley(i, samples) * circleOfConfusion;
        color += mir2D(sceneTex, sampleUV).rgb;
    }
    return color / samples;
}

float3 SubsurfaceScattering(float3 position, float3 lightDir, float scatterStrength)
{
    float3 scatterColor = float3(0.8, 0.7, 0.6); // Customize as needed
    float s = ClampEpsilon11(dot(normalize(position), lightDir));
    float scatter = exp(-scatterStrength * (1.0 - s));
    return lerp(float3(1, 1, 1), scatterColor, scatter);
}




float MicrofacetSpecular(float3 lightDir, float3 viewDir, float3 normal, float roughness)
{
    float3 halfDir = normalize(lightDir + -viewDir);
    float D = roughness / (PI * pow(dot(normal, halfDir), 2) * pow(roughness + (1 - roughness) * pow(ClampEpsilon11(dot(normal, halfDir)), 2), 2));
    float G = min(1.0, min(2 * ClampEpsilon11(dot(normal, halfDir)) * ClampEpsilon11(dot(normal, -viewDir)) / ClampEpsilon11(dot(viewDir, halfDir)), 2 * ClampEpsilon11(dot(normal, halfDir)) * ClampEpsilon11(dot(normal, lightDir)) / ClampEpsilon11(dot(viewDir, halfDir))));
    return D * G / ClampEpsilon11(4 * ClampEpsilon11(dot(normal, lightDir)) * ClampEpsilon11(dot(normal, -viewDir)));
}



float SSAO(float2 oosz, Texture2D<float> depthTex, float2 uv, float radius, float AO_DEPTH_THRESHOLD, bool flipDepth, float depthScale, bool scale)
{
    float depthCenter = dep2D(oosz, depthTex, uv, flipDepth, depthScale, scale);
    float ao = 0.0;

    for (int x = -radius; x <= radius; x++)
    {
        for (int y = -radius; y <= radius; y++)
        {
            float2 offset = float2(x, y) * oosz;
            float sampleDepth = dep2D(oosz, depthTex, uv + offset, flipDepth, depthScale, scale);
            ao += (sampleDepth >= depthCenter + AO_DEPTH_THRESHOLD) ? 1 : 0;
        }
    }
    return 1.0 - (ao / ((2 * radius + 1) * (2 * radius + 1)));
}

float3 EdgeDetectionGlow(Texture2D tex, float2 uv, float edgeIntensity)
{
    // Sobel filter kernel definitions
    float3x3 sobelX = float3x3(-1, 0, 1, -2, 0, 2, -1, 0, 1);
    float3x3 sobelY = float3x3(-1, -2, -1, 0, 0, 0, 1, 2, 1);

    float3 edgeColor = float3(0.0, 0.0, 0.0);
    float3 normalColor = mir2D(tex, uv).rgb;
    float edgeDetectionThreshold = 0.1; // Threshold for edge detection

    // Sobel edge detection
    float gx = 0.0;
    float gy = 0.0;
    [unroll]
    for (int x = -1; x <= 1; x++)
    {
        [unroll]
        for (int y = -1; y <= 1; y++)
        {
            float3 sampleColor = mir2D(tex, uv + float2(x, y) * 0.002).rgb; // 0.002 is a sample offset value
            gx += dot(sampleColor, sobelX[x + 1][y + 1]);
            gy += dot(sampleColor, sobelY[x + 1][y + 1]);
        }
    }

    float edgeMagnitude = sqrt(gx * gx + gy * gy);
    bool isEdge = edgeMagnitude > edgeDetectionThreshold;

    // Apply glowing effect on edges
    if (isEdge)
    {
        // Glowing effect - this could be a neon or spectral color shift
        float glowStrength = sin(edgeMagnitude * edgeIntensity) * 0.5 + 0.5;
        edgeColor = lerp(normalColor, float3(0.0, 0.8, 1.0), glowStrength); // Example: Glowing cyan color
    }

    return isEdge ? edgeColor : normalColor;
}


float3 HolographicRainbowColor(float3 viewDir, float3 particleNormal)
{
    float hueShift = atan2(viewDir.y, viewDir.x) / (2.0 * PI);
    float hue = frac(ClampEpsilon11(dot(-viewDir, particleNormal)) + hueShift);
    
    return HueToRGB(hue); // Convert hue to RGB using a suitable function
}



// Advanced Iridescent Shift with Fresnel and Noise
float3 IridescentShift(float2 oosz, float2 uv, float3 normal, float3 viewDir, float thickness, float shiftStrength, bool flipDepth, float depthScale, bool scale)
{
    // Fresnel term for angle-based reflectance
    float fresnel = pow(abs(1.0 - ClampEpsilon11(dot(normal, -viewDir))), thickness);
    
    // Shift value modulated by noise for irregular surface simulation
    float noisev = randNoise(uv) * .25 * dep2D(oosz, depthMap, uv, flipDepth, depthScale, scale) * (1 - length(mir2D(diffuseMap, uv).rgb / 3));
    float shift = fresnel * (1.0 + noisev) * shiftStrength;
    
    // Color calculation with phase shift for iridescence
    float3 colorShift = float3(0.05, .033, 0.07) * shift; // Adjust the base shift values as needed
  
    return mir2D(diffuseMap, uv) + float4(colorShift * .25, .25);
}

// Function 2: Dichroic Reflection
float3 DichroicReflection(float3 normal, float3 viewDir, float reflectivity)
{
    float angle = ClampEpsilon11(dot(normal, -viewDir));
    float reflectance = reflectivity * pow(1.0 - angle, 2.0);
    float3 color = lerp(float3(1.0, 0.0, 0.0), float3(0.0, 0.0, 1.0), reflectance);
    return color;
}

// Function 3: Rayleigh Scattering Simulation
float3 RayleighScattering2(float3 lightDir, float3 viewDir, float atmosphereThickness)
{
    float scatter = pow(abs(ClampEpsilon11(dot(lightDir, viewDir)) + 1.0), atmosphereThickness);
    float3 color = scatter * float3(0.5, 0.7, 1.0); // Blueish tint, typical for Rayleigh scattering
    return color;
}


// Gaussian blur helper function for depth smoothing
float GaussianBlur(float2 uv, Texture2D<float> depthMap, float2 oosz, int radius, bool flipDepth, bool scale)
{
    float sigma = float(radius) / 3.0;
    float weightSum = 0.0;
    float blurredDepth = 0.0;

    for (int x = -radius; x <= radius; ++x)
    {
        for (int y = -radius; y <= radius; ++y)
        {
            float2 sampleUV = uv + float2(x, y) * oosz;
            float weight = exp(-0.5 * (x * x + y * y) / (sigma * sigma));
            blurredDepth += weight * dep2D(oosz, depthMap, sampleUV, flipDepth, DepthScale, scale).r;
            weightSum += weight;
        }
    }

    return blurredDepth / weightSum;
}


float3 GaussianBlur(float2 uv, Texture2D diffuseMap, Texture2D<float> depthMap, float2 oosz, int radius, bool flipDepth, float depthScale, bool scale)
{
    float sigma = float(sqrt(radius));
    float weightSum = 0.0;
    float3 blurredDepth = 0.0;

    for (int x = -radius; x <= radius; ++x)
    {
        for (int y = -radius; y <= radius; ++y)
        {
            float2 sampleUV = uv + float2(x, y) * oosz;
            float z = dep2D(oosz, depthMap, sampleUV, flipDepth, depthScale, scale);
            float weight = exp(-0.5 * (x * x + y * y + z * z) / (sigma * sigma));
            blurredDepth += weight * diffuseMap.SampleLevel(sampleTypeMirror, sampleUV, 0).xyz;
            weightSum += weight;
        }
    }

    return blurredDepth / weightSum;
}

// Updated ParallaxOcclusion method with Gaussian sampling
ParallaxResult ParallaxOcclusion(float2 oosz, Texture2D<float> depthMap, float2 uv, float2 offset, int numLayers, bool flipDepth, bool scaleDepth, float depthScale)
{
    ParallaxLayerResult ret;
    InitializeParallaxLayerResult(ret);

    ret.uv = uv;

    float rad = normalRadius;
    float2 grad0 = GetGradient(depthMap, oosz, uv, rad, flipDepth, scaleDepth, depthScale);
    float2 dc0 = ComputeAdjustedDepthCurve(oosz, depthMap, uv, flipDepth, scaleDepth, depthScale);
    float depth0 = GetDepth(depthMap, oosz, uv, normalRadius, grad0, dc0, flipDepth, scaleDepth, depthScale);
    float2 mod0 = GetModulation(grad0, grad0);
    float2 offset0 = float2(0, 0);
    float2 offset1 = offset0;
    float2 grad1 = grad0;
    float2 dc1 = dc0;
    float depth1 = depth0;
    float2 mod1 = mod0;

    // Loop unrolled for improved performance
    [unroll]
    for (int i0 = 1; i0 <= numLayers; ++i0)
    {
        offset1 = offset0 + offset / numLayers * mod1;
        if ((i0 % 3) == 2)
        {
            grad1 = GetGradient(depthMap, oosz, uv + offset1, rad, flipDepth, scaleDepth, depthScale);
            dc1 = ComputeAdjustedDepthCurve(oosz, depthMap, uv + offset1, flipDepth, scaleDepth, depthScale);
            depth1 = GetDepth(depthMap, oosz, uv + offset1, normalRadius, grad1, dc1, flipDepth, scaleDepth, depthScale);
            mod1 = GetModulation(grad1, grad1);
        }
    // Branch optimized through predication
        
        if (depth1 > nearDepth())
        {
            ret.uv = uv + offset1;
            depth0 = depth1;
            offset0 = offset1;
            grad0 = grad1;
            dc0 = dc1;
            mod0 = mod1;
        }
        else
        {
            float ofs = smoothstep(0, 1, 1 - length(grad1));
            depth0 = lerp(depth0, depth1, ofs);
            offset0 = lerp(offset0, offset1, ofs);
            grad0 = lerp(grad0, grad1, ofs);
            dc0 = lerp(dc0, dc1, ofs);
            mod0 = lerp(mod0, mod1, ofs);
            
            ret.uv = uv + offset0;
        }
    }

    ParallaxResult result;
    result.uv = ret.uv;
    return result;
}

float4 ChromaColor(float2 oosz, Texture2D<float> depthMap, Texture2D<float3> normalMap, float2 uv, bool flipDepth, float depthScale, bool scale)
{
    float4 ret = mir2D(diffuseMap, config.uv);
    
    vec2 grad30 = GetGradient(depthMap, oosz, uv, normalRadius, flipDepth, scale, config.depthScale);
    vec2 curve1 = ComputeAdjustedDepthCurve(oosz, depthMap, uv, flipDepth, scale, config.depthScale);
    
    float depth3 = GetDepth(depthMap, oosz, config.uv, normalRadius, grad30, curve1, flipDepth, scale, config.depthScale);
    
    vec2 mod30 = GetModulation(grad30, curve1);

    vec3 normal = GetNormal(oosz, normalMap, uv, normalRadius, mod30, grad30, curve1);
    float3 iridescentColor = IridescentShift(oosz, uv, normal, config.viewToPixelDir, depth3, PerlinNoise(float3(config.uv * depth3 * length(config.uv - .5), cos(depth3 * TotalTime * timr) * .2 + .8)), flipDepth, depthScale, scale);
    float3 rayleighColor = RayleighScattering2(config.pixelToSunDir, config.viewToPixelDir, 10.0);

    vec4 power4 = float4(PerlinNoise(float3(config.uv * .2 * depth3, depth3 + TotalTime * .1 * timr)), PerlinNoise(float3(config.uv * .1 * depth3, depth3 + TotalTime * .1 * timr + 12)), PerlinNoise(float3(config.uv * .5 * depth3, depth3 + TotalTime * .15 * timr)), 1) * FresnelPower;

        vec2 curveDepth = curve1 * depth3;
    
        vec4 schlick = saturate(float4(Schlick2(ret, Fresnel(vec4(curve1.x, curve1.y, config.diffuse.r, config.diffuse.g)), pow(abs(FresnelPower + vec4(curveDepth, curve1)), power4)).xyz, 1));
    
    ret = combine(schlick, float4(iridescentColor + rayleighColor, 1), float4(rayleighColor, 1));
    
    
    return ret;
}

// Function 2: Chromatic Aberration Simulation
float3 ChromaticAberration(float2 oosz, Texture2D tex, float3 color, float2 uv, float2 aberrationOffset)
{
    // Simulates chromatic aberration by slightly offsetting the color channels
    float2 redOffset = uv + float2(aberrationOffset.x, 0);
    float2 greenOffset = uv;
    float2 blueOffset = uv - float2(aberrationOffset.y, 0);
    float red = mir2D(tex, redOffset).r;
    float green = mir2D(tex, greenOffset).g;
    float blue = mir2D(tex, blueOffset).b;
    return saturate(float4(color * float3(red, green, blue), 1)).xyz;
}




float4 glowMorph(float2 oosz, Texture2D tex, float2 uv, bool flipDepth, float depthScale, bool scale)
{
    float centerDist = length(uv - .5);
    
     vec2 occlusionOffset = dep2D(oosz, depthMap, uv, flipDepth, depthScale, scale) * vec2(.0016, .0017) * depthScale;
     vec2 occlusionOffset2 = (1 - dep2D(oosz, depthMap, uv, flipDepth, depthScale, scale)) * vec2(.0017, .0037) * depthScale;
    
    ParallaxResult pr = ParallaxOcclusion(oosz, depthMap, uv, occlusionOffset, 5, flipDepth, scale, depthScale);
    ParallaxResult pr2 = ParallaxOcclusion(oosz, depthMap, uv, occlusionOffset2, 5, flipDepth, scale, depthScale);
    
    float4 ret = (float4(ChromaticAberration(oosz, tex, imgaussfiltPS(oosz, tex, pr.uv, 3, normalRadius).xyz, pr.uv, float2(0, 0)), 1));
    
    float4 ret2 = (float4(ChromaticAberration(oosz, tex, imgaussfiltPS(oosz, tex, pr2.uv, 3, normalRadius).xyz, pr2.uv, float2(0, 0)), 1));
 
    
    return saturate(float4(lerp(ret.x, ret2.x, .5), mir2D(tex, uv).y,
        lerp(ret.z, ret2.z, .5), 1));
}
    
float4 sobelEdgeDetectionPS(float2 oosz, Texture2D<float> tex, float2 uv)
{
    // Sobel operator kernels
    float3x3 sobelX = float3x3(-1, 0, 1,
                               -2, 0, 2,
                               -1, 0, 1);

    float3x3 sobelY = float3x3(-1, -2, -1,
                                0, 0, 0,
                                1, 2, 1);

    // Initialize the edge strengths in the x and y directions
    float edgeStrengthX = 0;
    float edgeStrengthY = 0;

    // Loop over the kernel
    for (int i = -1; i <= 1; i++)
    {
        for (int j = -1; j <= 1; j++)
        {
            // Sample the neighboring pixel
            float neighbor = tex.SampleLevel(sampleTypeLinear, uv + float2(i, j) * oosz, 0).r;

            // Update the edge strengths
            edgeStrengthX += neighbor * sobelX[i + 1][j + 1];
            edgeStrengthY += neighbor * sobelY[i + 1][j + 1];
        }
    }

    // Calculate the total edge strength
    float edgeStrength = sqrt(edgeStrengthX * edgeStrengthX + edgeStrengthY * edgeStrengthY);

    // Normalize the edge strength and create the output color
    float4 output = float4(edgeStrength, edgeStrength, edgeStrength, 1);

    return output;
}


float calculateFresnel(float surfaceDot, float indexOfRefraction)
{
    float cosi = clamp(surfaceDot, -1.0, 1.0); // Ensure valid range
    float etai = 1.0; // Typically air
    float etat = indexOfRefraction;

    if (cosi > 0.0)
    {
        float f = etai;
        etai = etat;
        etat = f;
    }

    // Snell's law to calculate sine of transmission angle
    float sint = etai / etat * sqrt(max(0.0f, 1.0f - cosi * cosi));

    // Total internal reflection
    if (sint >= 1.0)
    {
        return 1.0;
    }

    float cost = sqrt(max(0.0f, 1.0f - sint * sint));
    cosi = abs(cosi);

    float Rs = ((etat * cosi) - (etai * cost)) / ((etat * cosi) + (etai * cost));
    float Rp = ((etai * cosi) - (etat * cost)) / ((etai * cosi) + (etat * cost));

    return (Rs * Rs + Rp * Rp) / 2.0;
}


float3 ApplyChromaticAberration(float2 oosz, MaterialProperties mat, float2 uv, float2 uvOffset, Texture2D diffuseMap, Texture2D<float3> normalMap, Texture2D<float> depthMap, Texture2D gratingMap, Texture2D<float3> gratingNormal, Texture2D<float> gratingDepth, float2 colorShiftOffset, float aberrationStrength, bool flipDepth, bool scale, float depthScale)
{
       
    float2 gradient = GetGradient(depthMap, oosz, uv + uvOffset, normalRadius, flipDepth, scale, depthScale);
    float2 depthCurve = ComputeAdjustedDepthCurve(oosz, depthMap, uv + uvOffset * gradient, flipDepth, scale, depthScale);
    float depth = GetDepth(depthMap, oosz, uv + uvOffset * depthCurve, normalRadius, gradient, depthCurve, flipDepth, scale, depthScale);
    float2 modulation = GetModulation(gradient, depthCurve);
    float3 normal = GetNormal(oosz, normalMap, uv + uvOffset * modulation, normalRadius, modulation, gradient, depthCurve);
    float3 pixel = float3(uv + uvOffset * modulation, depth);
    vec3 viewToPixelDir = normalize(pixel - camPos0);
    float3 tangent = cross(normal, vec3(0, 1, 0));
    float3 skewedNormal = skewNormalX(normal, depth * length(uvOffset * depthCurve));
    
    
    float2 gradient2 = GetGradient(gratingDepth, oosz, uv + uvOffset, normalRadius, flipDepth, scale, depthScale);
    float2 depthCurve2 = ComputeAdjustedDepthCurve(oosz, gratingDepth, uv + uvOffset * gradient2, flipDepth, scale, depthScale);
    float depth2 = GetDepth(gratingDepth, oosz, uv + uvOffset * depthCurve2, normalRadius, gradient2, depthCurve2, flipDepth, scale, depthScale);
    float2 modulation2 = GetModulation(gradient2, depthCurve2);
    float3 normal2 = GetNormal(oosz, gratingNormal, uv + uvOffset * modulation2, normalRadius, modulation2, gradient2, depthCurve2);
    float3 pixel2 = float3(uv + uvOffset * modulation, depth);
    vec3 viewToPixelDir2 = normalize(pixel2 - camPos0);
   
    float3 skewedNormal2 = skewNormalX(normal2, -depth2 * length(uvOffset * depthCurve2));
    
    vec3 center = mir2D(diffuseMap, uv + uvOffset * ((modulation + modulation2) * .5));
    
    vec3 c = vec3(
        lerp(center.r, mir2D(diffuseMap, uv + (uvOffset + oosz * colorShiftOffset) * (1 - depthCurve)).r, aberrationStrength),
        center.g,
        lerp(center.b, mir2D(diffuseMap, uv - (uvOffset + oosz * colorShiftOffset) * (1 - depthCurve)).b, aberrationStrength));
    
    return CalculateMaterialLighting(c, float3(uv + uvOffset * modulation, depth), skewedNormal, viewToPixelDir, mat, attenuationSun(), aberrationStrength).xyz;
    
}

float4 BaseReflectivityFromIndexOfRefraction(float4 ior)
{
    return pow((ior - 1) / max(0.0001, (ior + 1)), 2);
}


float4 CalculateFresnel(float4 baseColor, float3 normal, float3 viewDir, float NdotV, float fresnelPower, float fresnelReflectance)
{
    float F0 = saturate(lerp(fresnelReflectance, saturate(baseColor), pow(1 - saturate(NdotV), fresnelPower)));
    return F0 + (1 - F0) * pow(1 - cos(dot(normal, -viewDir)), 5);
}


// Helper function to rotate a point around the origin
float2 RotatePoint(float2 v, float angle)
{
    float s, c;
    sincos(angle, s, c);
    return float2(v.x * c - v.y * s, v.x * s + v.y * c);
}

vec4 FinalColor(float3 viewDir, float4 normal, float4 lightDirection, float4 diffuseColor, float4 baseReflectivity, float4 fresnel, float4 fresnelPower, float4 fresnelReflectance, float4 specularColor, float4 specularPower, float4 specularIntensity, float roughness)
{
    vec4 specularTerm = float4(
        pow(
            ClampEpsilon11(dot(-reflect(-lightDirection.xyz, normal.xyz), -viewDir)), specularPower.xyz), 1);
    
    vec4 specularContribution = ClampEpsilon11(dot(-viewDir, config.normal)) * Schlick2(baseReflectivity, fresnel, vec4(fresnelPower));
    
    
    vec4 finalColor = saturate(diffuseColor * saturate(1.0 - fresnelReflectance) * saturate(1.0 - fresnel) +
                  specularColor * specularTerm * specularIntensity *
                  specularContribution);
    
    return finalColor;
}


float4 WeightedAdditiveBlend(float4 baseColor, float4 effectColor, float effectWeight)
{
    return baseColor + effectColor * effectWeight;
}
float4 AlphaBlendWithOpacity(float4 baseColor, float4 effectColor, float effectOpacity)
{
    return lerp(baseColor, effectColor, effectColor.a * effectOpacity);
}

float4 SoftLightBlend(float4 baseColor, float4 effectColor)
{
    float4 result;
    if (effectColor.r <= 0.5)
    {
        result.r = (2 * baseColor.r * effectColor.r) + (baseColor.r * baseColor.r * (1 - 2 * effectColor.r));
    }
    else
    {
        result.r = (2 * baseColor.r * (1 - effectColor.r)) + sqrt(baseColor.r) * (2 * effectColor.r - 1);
    }
    if (effectColor.g <= 0.5)
    {
        result.g = (2 * baseColor.g * effectColor.g) + (baseColor.g * baseColor.g * (1 - 2 * effectColor.g));
    }
    else
    {
        result.g = (2 * baseColor.g * (1 - effectColor.g)) + sqrt(baseColor.g) * (2 * effectColor.g - 1);
    }
    if (effectColor.b <= 0.5)
    {
        result.b = (2 * baseColor.b * effectColor.b) + (baseColor.b * baseColor.b * (1 - 2 * effectColor.b));
    }
    else
    {
        result.b = (2 * baseColor.b * (1 - effectColor.b)) + sqrt(baseColor.b) * (2 * effectColor.b - 1);
    }
   // Repeat for .g and .b channels
   // ... 

    result.a = baseColor.a; // Preserve base alpha
    return result;
}
float4 ScreenBlend(float4 baseColor, float4 effectColor)
{
    return 1.0 - (1.0 - baseColor) * (1.0 - effectColor);
}
float4 MultiplyBlend(float4 baseColor, float4 effectColor)
{
    return baseColor * effectColor;
}
float4 OverlayBlend(float4 baseColor, float4 effectColor)
{
    float4 result = baseColor;
    if (baseColor.r < 0.5)
    {
        result.r = 2 * baseColor.r * effectColor.r;
    }
    else
    {
        result.r = 1 - 2 * (1 - baseColor.r) * (1 - effectColor.r);
    }
    if (baseColor.b < 0.5)
    {
        result.b = 2 * baseColor.b * effectColor.b;
    }
    else
    {
        result.b = 1 - 2 * (1 - baseColor.b) * (1 - effectColor.b);
    }
    if (baseColor.b < 0.5)
    {
        result.b = 2 * baseColor.b * effectColor.b;
    }
    else
    {
        result.b = 1 - 2 * (1 - baseColor.b) * (1 - effectColor.b);
    }

    result.a = baseColor.a; // Preserve base alpha
    return result;
}

float4 ColorDodgeBlend(float4 baseColor, float4 effectColor)
{
    return ClampEpsilon11(baseColor / (1.0 - effectColor));
}

float4 HSLBrightnessDarken(float4 color, float darkenAmount)
{
    float3 hsl = RGBtoHSL(color.xyz);
    hsl.z = ClampEpsilon11(hsl.z - darkenAmount); // Reduce lightness
    return float4(HSLtoRGB(hsl), color.a); // Convert back to RGBA 
}

float2 RippleDistort(float2 grad, float2 uv, float time, float speed, float amplitude)
{
    float angle = atan2(grad.y, grad.x);
    float distanceFromCenter = length(uv - 0.5); // Assuming center is (0.5, 0.5)
    float rippleOffset = amplitude * cos(distanceFromCenter * 20.0 + time * speed);
    return float2(cos(angle + rippleOffset), sin(angle + rippleOffset)) * grad;
}

float3 ChromaticShift(float2 grad, float amount)
{
    float shiftR = grad.x * amount;
    float shiftG = 0.0; // Shift only red channel for a simple effect 
    float shiftB = -grad.y * amount;

    return float3(shiftR, shiftG, shiftB);
}

float HolographicGlitter(float2 uv, float2 grad, float density, float sparkleSize)
{
    float hashValue = frac(sin(dot(uv, float2(12.98, 78.73))) * 4353.54);
    float sparkleIntensity = smoothstep(density - sparkleSize, density + sparkleSize, hashValue);
    return grad.x * grad.y * sparkleIntensity; // Simple multiplication
}

struct GDMFConfig4D
{
    float4 nearPoint;
    float4 farPoint;
    float4 transitionPoint;
    float4 polynomialDegree;
    float4 polynomialWeight;
    float4 skewFactor;
    float4 offsetFactor;
    float4 nearSlope;
    float4 farSlope;
    float4 transitionWidth;
};

// Helper function to create a GDMFConfig4D struct
GDMFConfig4D CreateGDMFConfig4D(float4 nearPoint, float4 farPoint, float4 transitionPoint, float4 polynomialDegree, float4 polynomialWeight, float4 skewFactor, float4 offsetFactor, float4 nearSlope, float4 farSlope, float4 transitionWidth)
{
    GDMFConfig4D config;
    config.nearPoint = nearPoint;
    config.farPoint = farPoint;
    config.transitionPoint = transitionPoint;
    config.polynomialDegree = polynomialDegree;
    config.polynomialWeight = polynomialWeight;
    config.skewFactor = skewFactor;
    config.offsetFactor = offsetFactor;
    config.nearSlope = nearSlope;
    config.farSlope = farSlope;
    config.transitionWidth = transitionWidth;
    return config;
}

// 4D Generalized Depth Mapping Function
float4 GDMF4D(float4 input, GDMFConfig4D config)
{
    float4 normalizedInput;
    normalizedInput.x = (input.x - config.nearPoint.x) / (config.farPoint.x - config.nearPoint.x);
    normalizedInput.y = (input.y - config.nearPoint.y) / (config.farPoint.y - config.nearPoint.y);
    normalizedInput.z = (input.z - config.nearPoint.z) / (config.farPoint.z - config.nearPoint.z);
    normalizedInput.w = (input.w - config.nearPoint.w) / (config.farPoint.w - config.nearPoint.w);

    float4 polynomialTerm;
    polynomialTerm.x = EvaluatePolynomial(normalizedInput.x, config.polynomialDegree.x, config.polynomialWeight.x);
    polynomialTerm.y = EvaluatePolynomial(normalizedInput.y, config.polynomialDegree.y, config.polynomialWeight.y);
    polynomialTerm.z = EvaluatePolynomial(normalizedInput.z, config.polynomialDegree.z, config.polynomialWeight.z);
    polynomialTerm.w = EvaluatePolynomial(normalizedInput.w, config.polynomialDegree.w, config.polynomialWeight.w);

    float4 skewedInput;
    skewedInput.x = pow(normalizedInput.x, config.skewFactor.x);
    skewedInput.y = pow(normalizedInput.y, config.skewFactor.y);
    skewedInput.z = pow(normalizedInput.z, config.skewFactor.z);
    skewedInput.w = pow(normalizedInput.w, config.skewFactor.w);

    float4 transitionFactor;
    transitionFactor.x = smoothstep(0.0f, config.transitionWidth.x, (input.x - config.transitionPoint.x) / (config.farPoint.x - config.transitionPoint.x));
    transitionFactor.y = smoothstep(0.0f, config.transitionWidth.y, (input.y - config.transitionPoint.y) / (config.farPoint.y - config.transitionPoint.y));
    transitionFactor.z = smoothstep(0.0f, config.transitionWidth.z, (input.z - config.transitionPoint.z) / (config.farPoint.z - config.transitionPoint.z));
    transitionFactor.w = smoothstep(0.0f, config.transitionWidth.w, (input.w - config.transitionPoint.w) / (config.farPoint.w - config.transitionPoint.w));

    float4 linearTerm;
    linearTerm.x = slerp(normalizedInput.x * config.nearSlope.x, normalizedInput.x * config.farSlope.x, transitionFactor.x);
    linearTerm.y = slerp(normalizedInput.y * config.nearSlope.y, normalizedInput.y * config.farSlope.y, transitionFactor.y);
    linearTerm.z = slerp(normalizedInput.z * config.nearSlope.z, normalizedInput.z * config.farSlope.z, transitionFactor.z);
    linearTerm.w = slerp(normalizedInput.w * config.nearSlope.w, normalizedInput.w * config.farSlope.w, transitionFactor.w);

    float4 mappedInput;
    mappedInput.x = slerp(linearTerm.x, polynomialTerm.x, transitionFactor.x);
    mappedInput.y = slerp(linearTerm.y, polynomialTerm.y, transitionFactor.y);
    mappedInput.z = slerp(linearTerm.z, polynomialTerm.z, transitionFactor.z);
    mappedInput.w = slerp(linearTerm.w, polynomialTerm.w, transitionFactor.w);

    float4 outputValue;
    outputValue.x = config.nearPoint.x + (mappedInput.x + config.offsetFactor.x) * (config.farPoint.x - config.nearPoint.x);
    outputValue.y = config.nearPoint.y + (mappedInput.y + config.offsetFactor.y) * (config.farPoint.y - config.nearPoint.y);
    outputValue.z = config.nearPoint.z + (mappedInput.z + config.offsetFactor.z) * (config.farPoint.z - config.nearPoint.z);
    outputValue.w = config.nearPoint.w + (mappedInput.w + config.offsetFactor.w) * (config.farPoint.w - config.nearPoint.w);

    return outputValue;
}


//////////////////////////////////////////////////////////////
// Revolutionary Photon Mapping Pixel Shader (HLSL Sm_5_0) //
//////////////////////////////////////////////////////////////

static const float WAVELENGTH_MIN = 380.0; // Violet (380nm)
static const float WAVELENGTH_MAX = 780.0; // Red (780nm)
static const int MAX_BOUNCES = 2;
static const int NUM_SAMPLES = 6;
static const int NUM_STRATA = 8;

//////////////////////////////////////////
// Structures                           //
//////////////////////////////////////////

struct RNG
{
    uint seed;
    uint state;
};


struct Material
{
    float g; // anisotropy factor
    float interferenceStrength;
    float3 referencePoint;
    float scatteringCoefficient;
    float3 normal;
    float refractiveIndex;
    float absorption;
    float reflection;
    float3 emission;
    float transmission;
};

struct Surface
{
    bool hit;
    Material material;
};

// Global constants and structures
static const float PLANCK_CONSTANT = 6.62607015e-34; // Planck constant (J⋅s)
static const float SPEED_OF_LIGHT = 299792458.0; // Speed of light (m/s)
static const float ELECTRON_CHARGE = 1.602176634e-19; // Electron charge (C)
static uint stratifiedSampleIndex;

struct PhotonState
{
    float3 position;
    float3 direction;
    float wavelength;
    float probability;
};

float RandFloat(inout RNG rng)
{
    rng.state ^= (rng.state << 13);
    rng.state ^= (rng.state >> 17);
    rng.state ^= (rng.state << 5);
    return float(rng.state) * (1.0 / 4294967296.0);
}


float HenyeyGreensteinPhaseFunction(float g, float cosTheta)
{
    float denom = 1.0 + g * g - 2.0 * g * cosTheta;
    return (1.0 / (4.0 * PI)) * ((1.0 - g * g) / (denom * sqrt(denom)));
}

float3 CalculateScattering(float3 position, float3 direction, float wavelength, Material material)
{
    float scatteringCoefficient = material.scatteringCoefficient;
    // Assume 'direction' is the normalized light direction
    // and 'material.normal' is the normalized surface normal
    float cosTheta = dot(direction, material.normal);
    float phaseFunction = HenyeyGreensteinPhaseFunction(material.g, cosTheta);

    // Calculate the scattering contribution
    float3 scattering = scatteringCoefficient * phaseFunction * direction; // Direction is used for scaling

    return scattering;
}


float2 Hammersley2D(uint index, uint numSamples)
{
    float phi = float(index) * 0.618033988749895; // Golden Ratio
    phi = frac(phi);
   
    float x = float(index) / float(numSamples);
    float y = phi;
   
    return float2(x, y);
}


//////////////////////////////////////////
// Quantum Electrodynamics Functions    //
//////////////////////////////////////////

float StratifiedSampling(float3 position, float3 direction, float wavelength, Material material)
{
    float probability = 1.0;
   
   // Implement stratified sampling based on material properties
    float2 sample = Hammersley2D(stratifiedSampleIndex, NUM_STRATA);
    float phi = 2.0 * PI * sample.x;
    float cosTheta = 1.0 - 2.0 * sample.y;
    float sinTheta = sqrt(1.0 - cosTheta * cosTheta);
    float3 tangent = normalize(cross(material.normal, float3(1.0, 0.0, 0.0)));
    float3 bitangent = normalize(cross(material.normal, tangent));
    direction = normalize(cos(phi) * tangent + sin(phi) * bitangent + cosTheta * material.normal);
    
    float cosThetaI = dot(direction, material.normal);
    probability = abs(cosThetaI) / PI;
   
    return probability;
}

float ImportanceSampling(float3 position, float3 direction, float wavelength, Material material)
{
    float probability = 1.0;
   
   // Implement importance sampling based on material properties
    float3 normal = material.normal;
    float cosThetaI = dot(direction, normal);
    probability = abs(cosThetaI) / PI;
   
    return probability;
}
struct Primitive
{
    float3 normal;
    float refractiveIndex;
    float absorption;
    float reflection;
    float3 emission;
    float3 position;
    float radius;
};

const static int numPrimitives = 3;
const static Primitive primitives[3] =
{
    // Added position and radius to each initializer
    { float3(0.0, .0, -1.0), 1.5, 0.1, 0.8, float3(0.0, 1.0, 1.0), float3(0.5, .5, 1.0), .50 }, // Glass sphere
    { float3(0.0, .0, -1.0), 1.0, 0.30, 0.2, float3(1.0, 1.0, 1.0), float3(0.250, 0.250, 0.0), .50 }, // Emissive plane
    { float3(0.0, 0.0, 1.0), 1.3, 0.5, 0.3, float3(0.50, 0.50, 0.0), float3(0.30, 0.30, .0), .20 } // Absorbing medium
};

bool IntersectRayPrimitive(float3 rayOrigin, float3 rayDirection, in Primitive primitive, inout float t)
{
    float3 oc = rayOrigin - primitive.position;
    float a = dot(rayDirection, rayDirection);
    float b = 2.0f * dot(oc, rayDirection);
    float c = dot(oc, oc) - primitive.radius * primitive.radius;
    float discriminant = b * b - 4.0f * a * c;

    if (discriminant < 0.0f)
    {
        return false; // No intersection
    }
    float sqrt_discriminant = sqrt(discriminant);
    float t0 = (-b - sqrt_discriminant) / (2.0f * a);
    float t1 = (-b + sqrt_discriminant) / (2.0f * a);

    if (t0 > t1)
    {
        float f = t0;
        t0 = t1;
        t1 = f;
    }
    if (t0 < 0.0f)
    {
        if (t1 < 0.0f)
            return false; // Both t values are negative, no intersection
        else
        {
            t = t1; // t1 is the smallest positive root
            return true;
        }
    }
    else
    {
        t = t0; // t0 is the smallest positive root
        return true;
    }
}




const static float3x3 MATRIX_SRGB_D65 =
{
    { 3.2404542, -1.5371385, -0.4985314 },
    { -0.9692660, 1.8760108, 0.0415560 },
    { 0.0556434, -0.2040259, 1.0572252 }
};


// Constants
#define LEN_MIN 380
#define LEN_MAX 780
#define LEN_STEP 5

// CIE XYZ color matching functions
const static float X[81] =
{
    0.000160, 0.000662, 0.002362, 0.007242, 0.019110, 0.043400, 0.084736, 0.140638, 0.204492, 0.264737,
                0.314679, 0.357719, 0.383734, 0.386726, 0.370702, 0.342957, 0.302273, 0.254085, 0.195618, 0.132349,
                0.080507, 0.041072, 0.016172, 0.005132, 0.003816, 0.015444, 0.037465, 0.071358, 0.117749, 0.172953,
                0.236491, 0.304213, 0.376772, 0.451584, 0.529826, 0.616053, 0.705224, 0.793832, 0.878655, 0.951162,
                1.014160, 1.074300, 1.118520, 1.134300, 1.123990, 1.089100, 1.030480, 0.950740, 0.856297, 0.754930,
                0.647467, 0.535110, 0.431567, 0.343690, 0.268329, 0.204300, 0.152568, 0.112210, 0.081261, 0.057930,
                0.040851, 0.028623, 0.019941, 0.013842, 0.009577, 0.006605, 0.004553, 0.003145, 0.002175, 0.001506,
                0.001045, 0.000727, 0.000508, 0.000356, 0.000251, 0.000178, 0.000126, 0.000090, 0.000065, 0.000046,
                0.000033
};
const static float Y[81] =
{
    0.000017, 0.000072, 0.000253, 0.000769, 0.002004, 0.004509, 0.008756, 0.014456, 0.021391, 0.029497,
                0.038676, 0.049602, 0.062077, 0.074704, 0.089456, 0.106256, 0.128201, 0.152761, 0.185190, 0.219940,
                0.253589, 0.297665, 0.339133, 0.395379, 0.460777, 0.531360, 0.606741, 0.685660, 0.761757, 0.823330,
                0.875211, 0.923810, 0.961988, 0.982200, 0.991761, 0.999110, 0.997340, 0.982380, 0.955552, 0.915175,
                0.868934, 0.825623, 0.777405, 0.720353, 0.658341, 0.593878, 0.527963, 0.461834, 0.398057, 0.339554,
                0.283493, 0.228254, 0.179828, 0.140211, 0.107633, 0.081187, 0.060281, 0.044096, 0.031800, 0.022602,
                0.015905, 0.011130, 0.007749, 0.005375, 0.003718, 0.002565, 0.001768, 0.001222, 0.000846, 0.000586,
                0.000407, 0.000284, 0.000199, 0.000140, 0.000098, 0.000070, 0.000050, 0.000036, 0.000025, 0.000018,
                0.000013
};
const static float Z[81] =
{
    0.000705, 0.002928, 0.010482, 0.032344, 0.086011, 0.197120, 0.389366, 0.656760, 0.972542, 1.282500,
                1.553480, 1.798500, 1.967280, 2.027300, 1.994800, 1.900700, 1.745370, 1.554900, 1.317560, 1.030200,
                0.772125, 0.570060, 0.415254, 0.302356, 0.218502, 0.159249, 0.112044, 0.082248, 0.060709, 0.043050,
                0.030451, 0.020584, 0.013676, 0.007918, 0.003988, 0.001091, 0.000000, 0.000000, 0.000000, 0.000000,
                0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
                0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
                0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
                0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000,
                0.000000
};

float Interpolate(const float values[81], int index, float offset)
{
    // Check if the index is within bounds for interpolation.
    if (index < 0)
        return 0; // or handle the error as appropriate.
    if (index > 80)
        return 1;
    
    // If offset is 0, return the value at the current index.
    if (offset == 0 || index == 80)
        return values[index];

    // Calculate the positions and values for interpolation.
    float x0 = index * LEN_STEP;
    float x1 = x0 + LEN_STEP;
    float y0 = values[index];
    float y1 = values[index + 1]; // Fixed to 'index + 1' to avoid going out of bounds.

    // Perform the interpolation using the HLSL intrinsic function 'lerp'.
    return lerp(y0, y1, offset / LEN_STEP);
}

float GammaCorrect_sRGB(float c)
{
    if (c <= 0.0031308)
        return 12.92 * c;

    float a = 0.055;
    return (1 + a) * pow(c, 1 / 2.2) - a;
}

float3 ConvertToRadiance(float len)
{
    if (len < LEN_MIN)
        return float3(0, 0, 0);
    if (len > LEN_MAX)
    {
        return float3(1, 1, 1);
    }
    len -= LEN_MIN;
    int index = int(floor(len / LEN_STEP));
    float offset = len - LEN_STEP * index;

    float x = Interpolate(X, index, offset);
    float y = Interpolate(Y, index, offset);
    float z = Interpolate(Z, index, offset);
    float3 rgb;
    
    rgb = mul(float3(x, y, z), MATRIX_SRGB_D65);
    rgb.r = saturate(GammaCorrect_sRGB(rgb.r));
    rgb.g = saturate(GammaCorrect_sRGB(rgb.g));
    rgb.b = saturate(GammaCorrect_sRGB(rgb.b));
    return rgb;
}


float ConvertToWavelength(float3 rgb)
{
    // First, convert RGB to HSV to get the hue
    float3 hsv = RGBtoHSV(rgb);
    float hue = hsv.x; // Hue is the first component

    // Map the hue to the wavelength
    float wavelength;
    if (hue >= 0 && hue < 60)
    {
        // Red to Yellow
        wavelength = lerp(620.0, 590.0, hue / 60.0);
    }
    else if (hue >= 60 && hue < 180)
    {
        // Yellow to Cyan
        wavelength = lerp(590.0, 495.0, (hue - 60) / 120.0);
    }
    else if (hue >= 180 && hue < 240)
    {
        // Cyan to Blue
        wavelength = lerp(495.0, 450.0, (hue - 180) / 60.0);
    }
    else if (hue >= 240 && hue < 300)
    {
        // Blue to Magenta
        wavelength = lerp(450.0, 380.0, (hue - 240) / 60.0);
    }
    else
    {
        // Magenta to Red
        wavelength = lerp(380.0, 620.0, (hue - 300) / 60.0);
    }

    return wavelength;
}


float3 CalculateRadianceContribution(float3 position, float3 direction, float wavelength, Material material)
{
    float3 radianceContribution = 0.0;

    // Example logic: Consider the material's reflectivity and transparency
    // This is just a placeholder logic, adjust according to your actual needs
    float reflectivity = max(0.0001, material.reflection);
    float transparency = max(0.0001, material.transmission);

    // Calculate the contribution based on the direction and material properties
    // For example, you might want to attenuate the contribution based on the angle of incidence
    float angleFactor = max(0.0001, dot(-direction, config.normal));
    radianceContribution = max(0.01, (reflectivity + transparency) * angleFactor);

    // Adjust the contribution based on the wavelength if necessary
    // This is a placeholder for any wavelength-dependent calculations you might have
    float wavelengthFactor = 1000.0; // Placeholder, adjust as needed
    radianceContribution *= wavelengthFactor;

    return radianceContribution;
}

float3 CalculateExitantRadiance(float3 position, float3 direction, float wavelength, Material material)
{
    float3 exitantRadiance = 0.0;

    // Account for emission, scattering, and interference effects
    exitantRadiance = material.emission * ConvertToRadiance(wavelength);

    float3 incidentRadiance = CalculateRadianceContribution(position, direction, wavelength, material);
    exitantRadiance += incidentRadiance * material.reflection + material.transmission;

    return exitantRadiance;
}



float3 CalculateInterference(float3 position, float3 direction, float wavelength, Material material)
{
    // Calculate the path difference between the current position and the reference point
    float3 pathDifference = position - material.referencePoint;

    // Calculate the phase difference based on the path difference, direction, and wavelength
    float phaseDifference = 2.0 * PI * dot(pathDifference, direction) / max(0.0001, wavelength);

    // Calculate the interference contribution
    // The cosine of the phase difference modulates the interference strength
    float3 interference = cos(phaseDifference) * material.interferenceStrength;

    return interference;
}

float3 GenerateRandomDirection(inout RNG rng)
{
    // Generate random angles
    float theta = 2.0 * PI * RandFloat(rng); // Azimuthal angle
    float phi = acos(1.0 - 2.0 * RandFloat(rng)); // Polar angle

    // Convert spherical coordinates to Cartesian coordinates
    float3 direction;
    direction.x = sin(phi) * cos(theta);
    direction.y = sin(phi) * sin(theta);
    direction.z = cos(phi);

    return direction;
}

float3 CalculateIncidentRadiance(inout RNG rng, float3 position, float3 direction, float wavelength, Material material)
{
    float3 incidentRadiance = 0.0;
    
    // Implement incident radiance calculation based on QED and material properties
    // Integrate over all incoming directions and wavelengths
    float pdf = 1.0 / (2.0 * PI);
    for (int i = 0; i < NUM_SAMPLES; i++)
    {
        float3 incomingDirection = normalize(Perlin3(vec3(config.uv, config.depth + config.timeFactor)));
        float3 incomingRadiance = CalculateRadianceContribution(position, -incomingDirection, wavelength, material);
        incidentRadiance += incomingRadiance * abs(dot(incomingDirection, material.normal)) * pdf;
    }
    incidentRadiance /= NUM_SAMPLES;

    // Account for emission, scattering, and interference effects
    float3 emission = material.emission;
    float3 scattering = CalculateScattering(position, direction, wavelength, material);
    float3 interference = CalculateInterference(position, direction, wavelength, material);

    // Combine the effects
    incidentRadiance += emission + scattering + interference;

    return incidentRadiance;
}


uint SeedFromPosition(float3 position)
{
    uint seed = 0;
    seed ^= uint(position.x * 1e6) + 0x9e3779b9;
    seed ^= uint(position.y * 1e6) + 0x9e3779b9;
    seed ^= uint(position.z * 1e6) + 0x9e3779b9;
    return seed;
}

float PowerImportanceSampling(float3 incidentRadiance, float3 exitantRadiance)
{
    float3 combinedRadiance = incidentRadiance + exitantRadiance;
    float maxRadiance = max(max(combinedRadiance.x, combinedRadiance.y), combinedRadiance.z);
    float probability = 0.0;
   
    if (maxRadiance > 0.0)
    {
        probability = pow(incidentRadiance / maxRadiance, 2.0) + pow(exitantRadiance / maxRadiance, 2.0);
    }
   
    return probability;
}

float VarianceReduction(inout RNG rng, float3 position, float3 direction, float wavelength, Material material)
{
    float probability = 1.0;
    probability *= max(0.1, ImportanceSampling(position, direction, wavelength, material));
    probability *= max(0.1, StratifiedSampling(position, direction, wavelength, material));
   
   // Apply other variance reduction techniques as needed
    float3 incidentRadiance = max(0.1, CalculateIncidentRadiance(rng, position, direction, wavelength, material));
    float3 exitantRadiance = max(0.1, CalculateExitantRadiance(position, direction, wavelength, material));
    probability *= max(0.1, PowerImportanceSampling(incidentRadiance, exitantRadiance));
   
    return probability;
}


RNG InitRNG(uint seed)
{
    RNG rng;
    rng.seed = seed;
    rng.state = seed;
    return rng;
}

float3 sceneBox = { 0.50f, 0.50f, 0.50f };


float3 GenerateRandomPosition(inout RNG rng)
{
    float3 position;
    position.x = RandFloat(rng);
    position.y = RandFloat(rng);
    position.z = RandFloat(rng);
    return position;
}

float GenerateRandomWavelength(inout RNG rng)
{
    float wavelength = lerp(WAVELENGTH_MIN, WAVELENGTH_MAX, PerlinNoise(config.uv, config.depth + config.timeFactor));
    return wavelength;
}

float3 CalculateQuantumPropagation(float3 position, float3 direction, float wavelength, float time)
{
    direction = normalize(direction);
    float wavevector = 2.0 * PI / max(0.0001, wavelength);
    float angularFrequency = SPEED_OF_LIGHT * wavevector;
    float3 newPosition = position + direction * SPEED_OF_LIGHT * time;
    float phase = dot(newPosition, wavevector) - angularFrequency * time;
    float3 waveFunction = cos(phase) * dot(direction, wavevector);
    return newPosition + waveFunction * max(0.0001, wavelength);
}


psout PS(PS_INPUT input)
{
    RNG rng;
    rng = InitRNG(SeedFromPosition(input.Position.xyz));
    bool flipDepth = true;
    bool scaleDepth = true;
    psout ret;
    const vec2 oosz = depthOosz();
    const vec2 ooszd = diffuseOosz();
    const vec2 ooszrt = rtMapOosz();
    
    
    config = InitializeConfig(oosz, TotalTime * timr, input.TexCoord, ooszd, ooszrt, camPos0, flipDepth, scaleDepth, DepthScale);
   
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
        ret.rt1 = vec4((mir2D(rtMap1, config.uv).rgb), 1);
        ret.rt2 = vec4((mir2D(rtMap2, config.uv).rgb), 1);
        ret.rt3 = vec4((mir2D(rtMap3, config.uv).rgb), 1);
        ret.rt4 = vec4((mir2D(rtMap4, config.uv).rgb), 1);
        ret.rt5 = vec4((mir2D(rtMap5, config.uv).rgb), 1);
        ret.rt6 = vec4((mir2D(rtMap6, config.uv).rgb), 1);
        ret.rt7 = vec4((mir2D(rtMap7, config.uv).rgb), 1);
        ret.rt8 = vec4((mir2D(rtMap8, config.uv).rgb), 1);
    }
   // Time-based modulation factors
    float ct1 = cosTime01(timr) * 0.8 - 0.4;
    float ct4 = (cosTime01(timr) - .5);
  
    float pn1 = PerlinNoise(config.uv, config.depth + TotalTime * 0.2);
    float pn2 = PerlinNoise(config.uv * 1.03, (config.depth) + TotalTime * 0.2);

    
  
   
    
    vec2 occlusionOffset =
    vec2(ct1 * ParallaxScale, .006 - .003) * farDepth() * config.modulation - vec2(ct1 * ParallaxScaleOMD, .005 - .002) * nearDepth() * config.modulation;
    
    
// Occlusion calculation
    const int numOcclusionLayers = 2;
  
    
    vec2 gUV4 = ParallaxOcclusion(oosz, gratingDepth4, config.uv0, occlusionOffset,
     numOcclusionLayers, flipDepth, scaleDepth, config.depthScale).uv;
    
    vec2 depthUV = ParallaxOcclusion(oosz, depthMap, config.uv0, occlusionOffset,
     numOcclusionLayers, flipDepth, scaleDepth, config.depthScale).uv;
    
    MaterialProperties mat = CreateMaterial(MaterialIndex + PassNum * 2);
       
    float2 diffuseUVOffset = (depthUV - config.uv0) / NumPasses * (PassNum + 1) * (1 - dep2D(depthMap, (depthUV - config.uv0) / NumPasses * (PassNum + 1)));

    ret.rt2 = float4(saturate(ApplyChromaticAberration(config.oosz, mat, depthUV, diffuseUVOffset, diffuseMap, normalMap, depthMap, gratingMap1, gratingNormal1, gratingDepth1, float2(4, .002), .85, flipDepth, scaleDepth, config.depthScale)), 1);
        
    MaterialProperties mat2 = CreateMaterial(f8 + PassNum * 2);
      
//   UpdateConfig(config, gUV4, scaleDepth);
    float2 gratingUVOffset = (gUV4 - config.uv0)/NumPasses*(PassNum+1)*(1-dep2D(gratingDepth4, (gUV4-config.uv0)/NumPasses*(PassNum+1)));

    ret.rt3 = float4(saturate(ApplyChromaticAberration(config.oosz, mat2, depthUV, gratingUVOffset, diffuseMap, normalMap, depthMap, gratingMap4, gratingNormal4, gratingDepth4, float2(2, .002)*4, .85, flipDepth, scaleDepth, config.depthScale)), 1);
     
    ret.rt1 = ret.rt3;


    return ret;
}