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
#define noise Noise
#define NUM_LAYERS 6
#define tex2D mir2D

#define SIGMOID_SCALE 8.0
#define MAX_SWAY_INTENSITY 0.5 // Define a maximum sway intensity

static const float epsilon = 1e-6;
static const float DC_MIN_STEEP = 0.5;
static const float DC_MAX_STEEP = .8;
// Gradient Processing
float GRAD_THRESHOLD_MIN = 0.05f; // Minimum threshold for gradient
float GRAD_DYNAMIC = 0.1f; // Dynamic adjustment to the gradient threshold
float GRAD_COMPRESSION = 0.5f; // Compression factor for gradient magnitude
float GRAD_SMOOTHING = 2.0f; // Smoothing factor for gradient magnitude
float2 GRAD_RANGE = float2(0.3f, 0.7f); // Range adjustment for gradient

// Sigmoid Parameters
float2 SIGMOID_STEEP = float2(1.0f, 1.0f); // Base steepness for the sigmoid function
float3 DEPTH_SIGMOID_PARAMS = float3(1.0f, 0.40f, 1.0f); // a, b, c parameters for the sigmoid



static float3 DEPTH_CURVE = float3(.04, .4, .14);

static float DEPTH_CURVE_MIDPOINT = .5;


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
static int ENABLED_EFFECTS = 0xFFFFFF;
static float TRIP_BLUR_FACTOR = 0.8;

static vec3 camPos0 = vec3(0.5, .5, 5);

static float swayFactor = 0.91;

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


static int perm[512] = { 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183, 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183 };



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
    float Mix2;
    float Mix3;
};

float lerp(float x, float x0, float x1, float y0, float y1)
{
    if (x1 == x0)
        return y0; // Prevent division by zero
    return y0 + (x - x0) * (y1 - y0) / (x1 - x0);
}

float RGBToWavelength(float3 rgb)
{
    float r = rgb.r;
    float g = rgb.g;
    float b = rgb.b;
    // Normalize the RGB values
    float maxComponent = max(r, max(g, b));
    if (maxComponent == 0)
        return 0; // Black, undefined wavelength

    r /= maxComponent;
    g /= maxComponent;
    b /= maxComponent;

    if (r >= g && r >= b)
    { // Red to yellow (620nm to 580nm)
        return lerp(g, 0.0f, 1.0f, 620.0f, 580.0f);
    }
    else if (g > r && g >= b)
    { // Yellow to green (580nm to 520nm)
        return lerp(r, 1.0f, 0.0f, 580.0f, 520.0f);
    }
    else if (g >= b)
    { // Green to cyan (520nm to 490nm)
        return lerp(b, 0.0f, 1.0f, 520.0f, 490.0f);
    }
    else if (b > g && b > r)
    { // Cyan to blue (490nm to 450nm)
        return lerp(g, 1.0f, 0.0f, 490.0f, 450.0f);
    }
    else if (b > r)
    { // Blue to magenta (450nm to 430nm)
        return lerp(r, 0.0f, 1.0f, 450.0f, 430.0f);
    }
    else
    { // Magenta to red (430nm to 620nm)
        return lerp(b, 1.0f, 0.0f, 430.0f, 620.0f);
    }
}

int RGBToWavelengthIndex(float3 rgb)
{
    float wl = RGBToWavelength(rgb);
    return clamp(((wl - fmod(wl, 5)) - 380) / 5, 0, 1);
}


#define MAX_SAMPLES 72
#define DELTA_LAMBDA 5
#define SPECTRUM_START 380
#define SPECTRUM_END 780



int WavelengthToIndex(float wave)
{
    return clamp((saturate(wave - SPECTRUM_START)) / DELTA_LAMBDA, 0, 71);
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

float4 mir2D(Texture2D tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0);
}

float4 mir2D(Texture2D<float3> tex, float2 uv)
{
    return float4(tex.SampleLevel(sampleTypeMirror, uv, 0).rgb, 1);
}

float mir2D(Texture2D<float> tex, float2 uv)
{
    return tex.SampleLevel(sampleTypeMirror, uv, 0).r;
}


struct VS_INPUT
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
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
Texture2D<float3> noise1 : register(t16);
Texture2D<float3> noise2 : register(t17);
Texture2D<float3> noise3 : register(t18);
Texture2D<float3> noise4 : register(t19);

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



vec3 pow3(vec3 v, float p)
{
    return vec3(pow(v.x, p), pow(v.y, p), pow(v.z, p));
}

vec4 pow4(vec4 v, float p)
{
    return vec4(pow(v.x, p), pow(v.y, p), pow(v.z, p), pow(v.w, p));
}

float avg4(vec4 v)
{
    return (v.x + v.y + v.z + v.w) * .25;
}

float avg3(vec3 v)
{
    return (v.x + v.y + v.z) * 0.3333;
}

float avg2(vec2 v)
{
    return (v.x + v.y) * 0.5;
}



//#define frac(x) fract(x)




float Fade(float t)
{
    // Fade function as defined by Ken Perlin
    // 6t^5 - 15t^4 + 10t^3
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

float grad(int hash, float x, float y, float z)
{
    int h = hash & 15;
    float u = h < 8 ? x : y;
    float v = h < 4 ? y : (h == 12 || h == 14 ? x : z);
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}
float grad(int hash, float3 g)
{
    int h = hash & 15;
    float u = h < 8 ? g.x : g.y;
    float v = h < 4 ? g.y : (h == 12 || h == 14 ? g.x : g.z);
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}



float lerp1D(float t, float a, float b)
{
    // Linear interpolation
    return a + t * (b - a);
}

float lerp(float a, float b, float t)
{
    return a + t * (b - a);
}
vec2 lerp(vec2 a, vec2 b, float t)
{
    return a + t * (b - a);
}
vec3 lerp(vec3 a, vec3 b, float t)
{
    return a + t * (b - a);
}
vec4 lerp(vec4 a, vec4 b, float t)
{
    return a + t * (b - a);
}

float PerlinNoise(float3 pos)
{
    float x = pos.x;
    float y = pos.y;
    float z = pos.z;

    int X = int(floor(x)) & 255;
    int Y = int(floor(y)) & 255;
    int Z = int(floor(z)) & 255;

    x -= floor(x);
    y -= floor(y);
    z -= floor(z);

    float u = Fade(x);
    float v = Fade(y);
    float w = Fade(z);

    int A = (perm[X] + Y) % 255;
    int AA = (perm[A] + Z) % 255;
    int AB = (perm[A + 1] + Z) % 255;
    int B = (perm[X + 1] + Y) % 255;
    int BA = (perm[B] + Z) % 255;
    int BB = (perm[B + 1] + Z) % 255;

    float res = lerp1D(w, lerp1D(v, lerp1D(u, grad(perm[AA], x, y, z),
        grad(perm[BA], x - 1.0, y, z)),
        lerp1D(u, grad(perm[AB], x, y - 1.0, z),
            grad(perm[BB], x - 1.0, y - 1.0, z))),
        lerp1D(v, lerp1D(u, grad(perm[AA + 1], x, y, z - 1.0),
            grad(perm[BA + 1], x - 1.0, y, z - 1.0)),
            lerp1D(u, float(grad(perm[AB + 1], x, y - 1.0, z - 1.0)),
                grad(perm[BB + 1], x - 1.0, y - 1.0, z - 1.0))));
    return (res + 1.0) / 2.0; // Normalize to [0,1]
}



float sum(float2 v)
{
    return v.x + v.y;
}
float sum(float3 v)
{
    return v.x + v.y + v.z;
}
float sum(float4 v)
{
    return v.x + v.y + v.z + v.w;
}
float variation(float4 dc2)
{
    return max(max(max(dc2.x, dc2.y), dc2.z), dc2.w) - min(min(min(dc2.x, dc2.y), dc2.z), dc2.w);
}
float variation(float3 dc2)
{
    return max(max(dc2.x, dc2.y), dc2.z) - min(min(dc2.x, dc2.y), dc2.z);
}

float4 variation(float4 dc2, float4 dc6)
{
    return float4(max(dc2.x, dc6.x) - min(dc2.x, dc6.x),
                max(dc2.y, dc6.y) - min(dc2.y, dc6.y),
                max(dc2.z, dc6.z) - min(dc2.z, dc6.z),
                max(dc2.w, dc6.w) - min(dc2.w, dc6.w));
}
float3 variation(float4 dc2, float3 dc6)
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
float variation(float dc2, float dc6)
{
    return max(dc2.x, dc6.x) - min(dc2.x, dc6.x);
}
float variation(float2 v)
{
    return max(v.x, v.y) - min(v.x, v.y);
}

// Worley Noise function for bubbly effect
float WorleyNoise(vec2 uv, float bubbleSize)
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
float LayeredNoise(vec3 position)
{
    // Combining multiple noise functions with different frequencies
    float noise1 = WorleyNoise(position.xy, 0.5); // Lower frequency noise
    float noise2 = WorleyNoise(position.xy, 1.5); // Higher frequency noise
    float noise3 = WorleyNoise(position.xy, 3.0); // Even higher frequency noise

    // Combining the noise functions to create layered effect
    return clamp((noise1 + noise2 + noise3) / 3.0, epsilon, (1 - epsilon)); // Average to get layered noise
}

float Noise(float2 uv)
{
    // Implement a basic noise function or use a GPU's built-in noise function
    // Placeholder for noise - replace with a specific noise function as needed
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}

vec3 normal2D(Texture2D tex, vec2 uv)
{
    return (normalize(tex.SampleLevel(sampleTypeMirror, uv, 0).xyz)) * 2 - 1;
}
vec3 normal2D(Texture2D<float3> tex, vec2 uv)
{
    vec3 ret = tex.SampleLevel(sampleTypeMirror, uv, 0).xyz;
    /*
    vec3 depth = vec3(
        depthMap.SampleLevel(sampleTypeMirror, Noise(uv) * 4 * 0.001, 0).r,
        depthMap.SampleLevel(sampleTypeMirror, uv, 0).r,
        depthMap.SampleLevel(sampleTypeMirror, -Noise(uv) * 4 * 0.001, 0).r);
    
    vec3 var = vec3(
            PerlinNoise(float3(uv, depth.x)),
            PerlinNoise(float3(uv, depth.y)),
            PerlinNoise(float3(uv, depth.z)))*2-1;
    */
    return normalize(ret) * 2 - 1;
}

static float UVHolographicIntensity = 0.2; // Controls the intensity of holographic distortion
static float ChromaticAberrationStrength = 0.8; // Controls the strength of chromatic aberration

static float normalDetailIntensity = 1.0; // Configurable intensity for normal details
static float depthNormalImpact = 1.0; // Configurable impact of depth on normals


struct GradientInfoEx
{
    float2 uv;
    float2 radius;
    float depth;
    vec2 gradient;
    vec2 modulation;
    vec3 normal;
};



float4 combine(vec4 color1, vec4 color2, vec4 color3)
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
float4 combine(vec4 a, vec4 b)
{
    return combine(a, b, vec4(0, 0, 0, 0));
}
float3 combine(vec3 a, vec3 b, vec3 c)
{
    return combine(float4(a, 0), float4(b, 0)).rgb;
}
float3 combine(vec3 a, vec3 b)
{
    return combine(a, b, vec3(0, 0, 0));
}

float3 combine(float3 colors[3])
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

float3 combine(float3 colors[2])
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


float2 combine(float2 a, float2 b)
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



int LightType_PointLight = 0;
int LightType_DirectionalLight = 1;
int LightType_SpotLight = 2;
int LightType_AmbientLight = 3;
int LightType_AreaLight = 4;
int LightType_EnvironmentLight = 5;

struct BaseLight
{
    bool Enabled;
    int LightType;
    vec3 Position;
    vec3 Direction;
    vec3 LightColor;
    float Intensity;
    bool CastShadows;
    float Exponent;
    vec4 FresnelPower;
    vec4 FresnelReflectance;
    float SpecularIntensity;
    float SpecularPower;
    float4 PhaseFactor; // For holography
    float FresnelMix;
};



struct SpotLight
{
    BaseLight Base;
    vec3 TargetPosition;
    float ConeAngle;
    float CutOffAngle;
    vec3 Attenuation;
};

struct PointLight
{
    BaseLight Base;
    float Radius;
    vec3 Attenuation;

};

struct DirectionalLight
{
    BaseLight Base;

};


struct AdvancedLight
{
    float3 Position;
    float3 Direction;
    float Intensity;
    float Roughness;
    float Metallic;
    float3 F0; // Reflectivity at normal incidence
    bool IsDirectional;
    
    
    float ggxFlicker, ggxFlickerSize, ggxFlickerSpeed;
    float metallicFlicker, metallicFlickerSize, metallicFlickerSpeed;
    float smithFlicker, smithFlickerSize, smithFlickerSpeed;
};

// Struct for Configurable Values in Gradient Modulation
struct GradientModulationConfig
{
    float timeFactor; // Range: 0.0 to infinity

    
    float2 uv0;
    float2 uv;
    
    ivec2 isz;
    float2 oosz;
    float2 ooszd;
    float2 ooszrt;
    float3 sunPos;
    float3 sunDir;
    
    float3 viewPos;
    float3 viewDir;
    float4 diffuse;
    float4 diffuse0;
    
    vec3 reflectDir0;
    vec3 reflectDir;
    float reflectFactor;
    
    float diffuseFactor0;
    float diffuseFactor;
    
    DirectionalLight dirLight;
    AdvancedLight light;
    GradientInfoEx grad;
};

static GradientModulationConfig config;


    // Fresnel-Schlick Reflectivity
float3 FresnelSchlickBaseReflectivity(float3 intensity, float3 metallic)
{
    float3 F0 = float3(lerp(0.04, intensity.x, metallic.x),
                       lerp(0.04, intensity.y, metallic.y),
                       lerp(0.04, intensity.z, metallic.z));
    return F0;
}



float fresnelSigmoidBlend(vec3 normal, vec3 viewDir, float curvature, float reflectance)
{
    // Fresnel term (Schlick's approximation)
    float F0 = 0.04; // Base reflectivity, adjust as needed
    float fresnel = F0 + (1.0 - F0) * pow(1.0 - clamp(dot(normal, -viewDir), 0, 1), FresnelPower);

    // Adjust Fresnel based on curvature and reflectance
    fresnel *= reflectance * smoothstep(0.0, 1.0, curvature);

    // Sigmoid function for local smoothing
    float sigmoidValue = 1.0 / (1.0 + exp(-curvature)); // Adjust the sigmoid function as needed

    // Blend Fresnel and sigmoid
    float blend = lerp(sigmoidValue, fresnel, reflectance);

    return clamp(blend, 0.0, 1.0);
}

// Function to enhance depth based on Fresnel, sigmoid, and lighting
vec4 enhanceDepth(vec2 uv, vec3 normal, vec3 viewDir, vec3 lightDir, vec3 lightColor, float curvature, float contrastFactor, float saturationFactor, float reflectances, bool flipDepth)
{
    // Calculate Fresnel effect
    float fresnel = fresnelSigmoidBlend(normal, viewDir, curvature, reflectances); // As defined earlier

    // Lighting calculations
    vec3 enhancedNormal = normal2D(normalMap, uv).rgb; // Convert normal map to [-1, 1] range
    float diff = max(dot(enhancedNormal, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;

    // Specular highlight
    vec3 reflectDir = -reflect(-lightDir, enhancedNormal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), SpecularIntensity); // Specular exponent
    vec3 specular = spec * lightColor * SpecularPower;

    // Ambient Occlusion
    //float ao = mir2D( MAP_AMIBENT, uv).r;
    //vec3 ambient = LIGHTING_AMBIENT_INTENSITY * lightColor * ao;

    // Combine lighting components with Fresnel effect
    vec3 baseColor = mir2D(diffuseMap, uv).rgb;
    vec3 color = combine(baseColor, baseColor * (diffuse + vec3(.04, .04, .04)) + specular, fresnel);

    // Adjust texture contrast
    color = color * contrastFactor + (1.0 - contrastFactor) * 0.5;

    // Adjust color saturation based on curvature
    float saturation = 1.0 + curvature * saturationFactor;
    float avg = (color.r + color.g + color.b) / 3.0;
    color = lerp(vec3(avg, avg, avg), color, saturation);

    return vec4(color, 1.0); // Assuming the texture has no alpha component
}

    // Constructor to initialize the light properties
AdvancedLight CreateAdvancedLight(float3 pos, float3 dir, float intensity, float roughness, float metallic, bool isDirectional, float2 modulation, float depth)
{
    AdvancedLight ret;
    ret.ggxFlicker = .50;
    ret.ggxFlickerSize = 0.2;
    ret.ggxFlickerSpeed = 2;
    
    ret.smithFlicker = .25;
    ret.smithFlickerSize = 200;
    ret.smithFlickerSpeed = 12;
    
    ret.metallicFlicker = .15;
    ret.metallicFlickerSize = 4;
    ret.metallicFlickerSpeed = .2;
    
    vec2 gradDepTime = modulation * depth * config.timeFactor;

    ret.Position = pos;
    ret.Direction = normalize(dir);
    ret.Intensity = intensity;
    ret.Roughness = roughness;
    ret.Metallic = metallic;
    ret.F0 = FresnelSchlickBaseReflectivity(ret.Intensity, ret.Metallic);
    ret.IsDirectional = isDirectional;
    
    return ret;
}

float dep2D(Texture2D<float> tex, float2 uv, bool flipDepth)
{
    float d = tex.SampleLevel(sampleTypeMirror, uv, 0).r;
    if (flipDepth)
    {
        d = 1 - d;
    }
    return d;
}
float dep2D(Texture2D<float> tex, float2 uv)
{
    return dep2D(tex, uv, false);
}
float dep2D(float2 uv, bool flipDepth)
{
    return dep2D(depthMap, uv, flipDepth);
}
float dep2D(float2 uv)
{
    return dep2D(uv, false);
}
float3 depCRD(float2 oosz, float2 uv)
{
    return float3(
    dep2D(uv),
    dep2D(uv + float2(oosz.x, 0)),
    dep2D(uv + float2(0, oosz.y)));
}

float3 dep2D3(float2 uv)
{
    return dep2D(uv);
}


// A pixel shader function that performs 2-D Gaussian filtering on images
float4 imgaussfiltPS(float2 oosz, float2 uv, float sigma, float filterSize)
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
    return output;
}
// A pixel shader function that performs 2-D Gaussian filtering on images
float4 imgaussfiltPS(float2 oosz, Texture2D<float> tex, float2 uv, float sigma, float filterSize)
{


    // Calculate the filter radius
    int radius = max(1, (filterSize - 1) / 2);

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



float3 imgaussfiltPS(float2 oosz, Texture2D<float3> tex, float2 uv, float sigma, float filterSize, float2 scalar)
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
            float4 neighbor = mir2D(tex, uv + float2(i, j) * oosz * scalar);

            // Update the output color
            output += weight * neighbor.rgb;
        }
    }

    // Normalize the output color
    output /= norm;

    // Return the output color
    return normalize(output * 2 - 1);
}


  // Define the standard deviation and the filter size
  //  float sigma = 2.0;
 //   int filterSize = 9;
float4 imgaussfiltPS(float2 oosz, Texture2D tex, float2 texCoord, float sigma, float filterSize) : COLOR0
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
float4 imgaussfiltPS(float2 oosz, vec4 input, float2 uv, Texture2D tex, float sigma, float filterSize)
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

float4 XCrossLRUDAvg_RGB2(vec2 oosz, Texture2D tex, vec2 uv)
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

float4 XCrossLRUDAvg_RGB2(vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient)
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

void XCrossLRUD_RGB2(vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient,
    out vec4 l, out vec4 r, out vec4 u, out vec4 dr,
    out vec4 xl, out vec4 xr, out vec4 xu, out vec4 xdr)
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

void XLRUD_RGB2(vec2 oosz, Texture2D tex, vec2 uv, vec2 radius, float2 depthGradient,
    out vec4 l, out vec4 r, out vec4 u, out vec4 dr)
{
    l = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
    r = mir2D(tex, uv + oosz * vec2(1.0, 1.0) * radius * depthGradient);
    u = mir2D(tex, uv + oosz * vec2(1.0, -1.0) * radius * depthGradient);
    dr = mir2D(tex, uv + oosz * vec2(-1.0, -1.0) * radius * depthGradient);
}

void CrossLRUD_RGB2(Texture2D tex, vec2 oosz, vec2 uv, vec2 radius, float2 depthGradient,
    out vec4 l, out vec4 r, out vec4 u, out vec4 dr)
{
    l = mir2D(tex, uv + oosz * vec2(-1.0, 0.0) * radius * depthGradient);
    r = mir2D(tex, uv + oosz * vec2(1.0, 0.0) * radius * depthGradient);
    u = mir2D(tex, uv + oosz * vec2(0.0, -1.0) * radius * depthGradient);
    dr = mir2D(tex, uv + oosz * vec2(0.0, 1.0) * radius * depthGradient);
}

vec4 XLRUDf(vec2 oosz, Texture2D<float> tex, vec2 uv, float range, float2 depthGradient)
{
    return
    vec4(
        dep2D(tex, uv + oosz * float2(-range, -range) * depthGradient),
        dep2D(tex, uv + oosz * float2(range, -range) * depthGradient),
        dep2D(tex, uv + oosz * float2(-range, range) * depthGradient),
        dep2D(tex, uv + oosz * float2(range, range) * depthGradient)
    );
}
vec4 XLRUDf(vec2 oosz, Texture2D tex, vec2 uv, float range, float2 depthGradient)
{
    return
    vec4(
        mir2D(tex, uv + oosz * float2(-range, -range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(range, -range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(-range, range) * depthGradient).r,
        mir2D(tex, uv + oosz * float2(range, range) * depthGradient).r
    );
}


float XLRUDfAvg(float2 oosz, Texture2D tex, float2 uv, float range, float2 depthGradient)
{
    vec4 v = XLRUDf(oosz, tex, uv, range, depthGradient);
    return lerp(mir2D(tex, uv).r, (v.x + v.y + v.z + v.w) / 4.0f, .25);
}



vec4 CrossLRUDf(vec2 oosz, Texture2D tex, vec2 uv, float range, float2 depthGradient)
{
    return
    vec4(
        mir2D(tex, uv + oosz * vec2(-range, 0) * depthGradient).r,
        mir2D(tex, uv + oosz * vec2(range, 0) * depthGradient).r,
        mir2D(tex, uv + oosz * vec2(0, -range) * depthGradient).r,
        mir2D(tex, uv + oosz * vec2(0, range) * depthGradient).r
    );
}

vec4 CrossLRUDf(vec2 oosz, Texture2D tex, vec2 uv, float range)
{
    return
    vec4(
        mir2D(tex, uv + oosz * vec2(-range, 0)).r,
        mir2D(tex, uv + oosz * vec2(range, 0)).r,
        mir2D(tex, uv + oosz * vec2(0, -range)).r,
        mir2D(tex, uv + oosz * vec2(0, range)).r
    );
}

float CrossLRUDfAvg(vec2 oosz, Texture2D tex, vec2 uv, float range, float2 depthGradient)
{
    vec4 v = CrossLRUDf(oosz, tex, uv, range, depthGradient);
    return lerp(mir2D(tex, uv).r, (v.x + v.y + v.z + v.w) / 4.0, .25);
}

float XCrossLRUDfAvg(float2 oosz, Texture2D tex, vec2 uv, float range, float2 depthGradient)
{
    return lerp(XLRUDfAvg(oosz, tex, uv, range + 1.0, depthGradient), CrossLRUDfAvg(oosz, tex, uv, range, depthGradient), 0.75);
}
//depth based



float2 normalMapOosz()
{
    float2 sz;
    normalMap.GetDimensions(sz.x, sz.y);
    return 1.0 / sz;
}

float2 rtMapOosz()
{
    ivec2 iszrt;
    rtMap1.GetDimensions(iszrt.x, iszrt.y);
    return 1.0 / vec2(iszrt);
}

float2 depthOosz()
{
    ivec2 isz;
    depthMap.GetDimensions(isz.x, isz.y);
    return 1.0 / vec2(isz);
}

float2 diffuseOosz()
{
    ivec2 iszd;
    diffuseMap.GetDimensions(iszd.x, iszd.y);
    return 1.0 / vec2(iszd);
}

float3 SelectSigmoidSteepness3D(float3 averageGradientMagnitude, float2 steepnessMinMax)
{
    // Clamp and normalize the gradient magnitude
    float3 normalizedMagnitude = saturate(averageGradientMagnitude);

    // Lerp between minimum and maximum steepness based on normalized gradient magnitude
    return vec3(lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.x),
        lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.y),
    lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.z));
}
float2 SelectSigmoidSteepness2D(float2 averageGradientMagnitude, float2 steepnessMinMax)
{
    // Clamp and normalize the gradient magnitude
    float2 normalizedMagnitude = saturate(averageGradientMagnitude);

    // Lerp between minimum and maximum steepness based on normalized gradient magnitude
    return vec2(lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.x),
        lerp(steepnessMinMax.x, steepnessMinMax.y, normalizedMagnitude.y));
}


float SelectSigmoidSteepness(float averageGradientMagnitude, float2 steepnessMinMax)
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

float AdjustSteepness(float steepness, float gradientMagnitude, float threshold, float maxAdjustment)
{
    // Reduce steepness if the gradient magnitude is above a certain threshold
    if (gradientMagnitude > threshold)
    {
        float adjustmentFactor = 1.0f - min((gradientMagnitude - threshold) / maxAdjustment, 1.0f);
        return steepness * adjustmentFactor;
    }
    return steepness;
}
float cosTime01(float timeMul)
{
    return (1.0 + cos(TotalTime * timr * timeMul)) * 0.5;
}
float sinTime01(float timeMul)
{
    return (1.0 + sin(TotalTime * timr * timeMul)) * 0.5;
}



float sigmoid(float x, float steepness, float offset, float scale)
{
    return scale / (1.0f + exp(-steepness * (x - offset)));
}
float2 sigmoid(float2 x, float2 steepness, float2 offset, float2 scale)
{
    return scale / (1.0f + exp(-steepness * (x - offset)));
}
float3 sigmoid(float3 x, float3 steepness, float3 offset, float3 scale)
{
    return scale / (1.0f + exp(-steepness * (x - offset)));
}
float sigmoid(float x, float steepness, float offset)
{
    return 1.0f / (1.0f + exp(-steepness * (x - offset)));
}
float2 GetModulation(float2 depthGradient, float2 depthCurve)
{
    float gradientMagnitude = length(depthGradient);
    // Simplified gradient magnitude adjustment for clarity
    gradientMagnitude = pow(gradientMagnitude, GRAD_COMPRESSION);
    
    // Assuming a sigmoid function and parameters are defined appropriately
    float sigmoidValueX = sigmoid(gradientMagnitude, depthCurve.x, GRAD_THRESHOLD_MIN);
    float sigmoidValueY = sigmoid(gradientMagnitude, depthCurve.y, GRAD_THRESHOLD_MIN + GRAD_DYNAMIC);
    
    return float2(sigmoidValueX, sigmoidValueY);
}



vec2 GetGradientBetween(vec2 oosz, vec2 uv1, vec2 uv2)
{
    vec2 dir = uv2 - uv1;
    float pixelDistance = length(dir / oosz); // Distance in pixels

    // Optimize sampling based on pixel distance
    const float minPixelDistance = 0.5;
    int sampleCount = max(1, min(10, int(ceil(pixelDistance / minPixelDistance))));

    vec2 gradientSum = vec2(0.0, 0.0);
    float totalDepthChange = 0.0;
    float prevDepth = dep2D(uv1);

    for (int i = 1; i <= sampleCount; ++i)
    {
        float t = float(i) / float(sampleCount);
        vec2 sampleUV = lerp(uv1, uv2, t);
        float currentDepth = dep2D(sampleUV);

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

float3 GetGradientMidDepth(float2 oosz, float2 uv)
{
    // Sample depths around the current pixel
    const float depthCenter = dep2D(uv);
    const float depthLeft = dep2D(uv - float2(oosz.x, 0.0));
    const float depthRight = dep2D(uv + float2(oosz.x, 0.0));
    const float depthUp = dep2D(uv - float2(0.0, oosz.y));
    const float depthDown = dep2D(uv + float2(0.0, oosz.y));
    const float dX = (depthRight - depthLeft) * 0.5;
    const float dY = (depthDown - depthUp) * 0.5;

    return float3(dX, dY, lerp((depthLeft + depthRight + depthUp + depthDown) / 4, depthCenter, 0.75));
}

float2 GetGradientMid(float2 oosz, float2 uv, bool flipDepth)
{
    // Sample depths around the current pixel
    
    const float depthLeft = dep2D(uv - float2(oosz.x, 0.0), flipDepth);
    const float depthRight = dep2D(uv + float2(oosz.x, 0.0), flipDepth);
    const float depthUp = dep2D(uv - float2(0.0, oosz.y), flipDepth);
    const float depthDown = dep2D(uv + float2(0.0, oosz.y), flipDepth);
    const float dX = (depthRight - depthLeft, flipDepth) * 0.5;
    const float dY = (depthDown - depthUp, flipDepth) * 0.5;

    return float2(dX, dY);
}


struct AverageGradientMagnitude2
{
    float2 gradient;
    float2 totalMagnitude;
    float2 averageGradient;
};
struct AverageGradientMagnitude3
{
    float3 gradient;
    float3 totalMagnitude;
    float3 averageGradient;
};
AverageGradientMagnitude3 ComputeAverageGradientMagnitude3D(float2 oosz, float3 uv, bool flipDepth)
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
        vec3 grad = vec3(GetGradientMid(oosz, neighborUV, flipDepth), uv.z);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w;
        ret.averageGradient += grad * w;
        weight1 += length(w);
        
        float3 w2 = length(offsets2[i]);
        neighborUV = uv.xy + offsets2[i] * oosz;
        grad = vec3(GetGradientMid(oosz, neighborUV, flipDepth), uv.z);
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
AverageGradientMagnitude2 ComputeAverageGradientMagnitude2D(float2 oosz, float2 uv, bool flipDepth)
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
        vec2 grad = GetGradientMid(oosz, neighborUV, flipDepth);
        ret.gradient += grad;
        ret.totalMagnitude += length(grad) * w;
        ret.averageGradient += grad * w;
        weight1 += length(w);
        
        float w2 = length(offsets2[i]);
        neighborUV = uv + offsets2[i] * oosz;
        grad = GetGradientMid(oosz, neighborUV, flipDepth);
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

float3 ComputeAdjustedDepthCurve3(float2 oosz, float3 uv, bool flipDepth)
{
    float2 steepnessMinMax = float2(0.5 + cosTime01(timr) * .3 - .15,
    0.8 + cosTime01(timr) * .4 - .3);
    const int range = 10;
    
    AverageGradientMagnitude3 averageGradientMagnitude = ComputeAverageGradientMagnitude3D(oosz, uv, flipDepth);
    float3 steepness = SelectSigmoidSteepness3D(averageGradientMagnitude.averageGradient, steepnessMinMax);
   
    

    vec3 gradient = sigmoid(averageGradientMagnitude.gradient, vec3(steepnessMinMax, 0), 0, 1);
    
    float3 adjustedSteepness3 = AdjustSteepness3D(steepness, gradient, steepnessMinMax.x, steepnessMinMax.y);
    /*
    vec2 sig = vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
    
    vec2 ret = (gradient + sig) * (gradient + ((1 - sig) * gradient));
    */
    return vec3(sigmoid(gradient.x, adjustedSteepness3.x, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness3.y, 0, 1),
                sigmoid(gradient.z, adjustedSteepness3.z, 0, 1));
}




float2 ComputeAdjustedDepthCurve2(float2 oosz, float2 uv, bool flipDepth)
{
    float2 steepnessMinMax = float2(0.5 + cosTime01(timr) * .3 - .15,
    0.8 + cosTime01(timr) * .4 - .3);
    const int range = 10;
    
    AverageGradientMagnitude2 averageGradientMagnitude = ComputeAverageGradientMagnitude2D(oosz, uv, flipDepth);
    float2 steepness = SelectSigmoidSteepness2D(
        averageGradientMagnitude.averageGradient, steepnessMinMax);
     
    vec2 gradient = averageGradientMagnitude.gradient;

    gradient = sigmoid(gradient, steepnessMinMax, 0, 1);
    
    float adjustedSteepness = AdjustSteepness2D(steepness, gradient, steepnessMinMax.x, steepnessMinMax.y);
    /*
    vec2 sig = vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
    
    vec2 ret = (gradient + sig) * (gradient + ((1 - sig) * gradient));
    */
    return vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
}

float ComputeAverageGradientMagnitude(float2 oosz, Texture2D<float> heightMap, float2 uv, bool flipDepth)
{
    vec2 offsets[8] =
    {
        { -1, -1 },
        { 0, -1 },
        { 1, -1 },
        { -1, 0 },
        { 1, 0 },
        { -1, 1 },
        { 0, 1 },
        { 1, 1 }
    };

    float totalMagnitude = 0.0f;
    float weight = 0.0f;
    for (int i = 0; i < 8; ++i)
    {
        float w = length(offsets[i]);
        vec2 neighborUV = uv + offsets[i] * oosz;
        vec2 grad = GetGradientMid(oosz, neighborUV, flipDepth);
        
        totalMagnitude += length(grad) * w;
        weight += w;
    }

    return totalMagnitude / weight;
}



float2 ComputeAdjustedDepthCurveO(float2 oosz, float2 uv, float2 gradient, bool flipDepth)
{
    float2 steepnessMinMax = float2(0.5 + cosTime01(timr) * .3 - .15,
    0.8 + cosTime01(timr) * .4 - .3);
    const int range = 10;
    
    float averageGradientMagnitude = ComputeAverageGradientMagnitude(oosz, depthMap, uv, flipDepth);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);
   
    

    gradient = sigmoid(gradient, steepnessMinMax, 0, 1);
    
    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);
    /*
    vec2 sig = vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
    
    vec2 ret = (gradient + sig) * (gradient + ((1 - sig) * gradient));
    */
    return vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
}
float2 ComputeAdjustedDepthCurve(float2 oosz, float2 uv, bool flipDepth)
{
    float2 steepnessMinMax = float2(0.5 + cosTime01(timr) * .3 - .15,
    0.8 + cosTime01(timr) * .4 - .3);
    const int range = 10;
    
    float averageGradientMagnitude = ComputeAverageGradientMagnitude(oosz, depthMap, uv, flipDepth);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);
   
    
    // Pre-calculate multiplied offsets to optimize Sobel operator calculations
    const vec2 offsetTL = range * vec2(-oosz.x, -oosz.y);
    const vec2 offsetTR = range * vec2(oosz.x, -oosz.y);
    const vec2 offsetBL = range * vec2(-oosz.x, oosz.y);
    const vec2 offsetBR = range * vec2(oosz.x, oosz.y);
    const vec2 offsetL = range * vec2(-oosz.x, 0);
    const vec2 offsetR = range * vec2(oosz.x, 0);
    const vec2 offsetT = range * vec2(0, -oosz.y);
    const vec2 offsetB = range * vec2(0, oosz.y);

    // Sobel operator for gradient calculation using pre-calculated offsets
    const float depthTL = dep2D(uv + offsetTL);
    const float depthTR = dep2D(uv + offsetTR);
    const float depthBL = dep2D(uv + offsetBL);
    const float depthBR = dep2D(uv + offsetBR);
    const float depthL = dep2D(uv + offsetL);
    const float depthR = dep2D(uv + offsetR);
    const float depthT = dep2D(uv + offsetT);
    const float depthB = dep2D(uv + offsetB);

    // Sobel operator for horizontal and vertical gradients
    float dX = (depthTR + 2.0f * depthR + depthBR) - (depthTL + 2.0f * depthL + depthBL);
    float dY = (depthBL + 2.0f * depthB + depthBR) - (depthTL + 2.0f * depthT + depthTR);
    
    vec2 gradient = vec2(dX, dY);

    gradient = sigmoid(gradient, steepnessMinMax, 0, 1);
    
    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);
    /*
    vec2 sig = vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
    
    vec2 ret = (gradient + sig) * (gradient + ((1 - sig) * gradient));
    */
    return vec2(sigmoid(gradient.x, adjustedSteepness, 0, 1),
                  sigmoid(gradient.y, adjustedSteepness, 0, 1));
}
vec2 GetGradient(vec2 oosz, vec2 uv, float range, bool flipDepth)
{
    // Pre-calculate multiplied offsets to optimize Sobel operator calculations
    return ComputeAdjustedDepthCurve(oosz, uv, flipDepth);
    
    const vec2 offsetTL = range * vec2(-oosz.x, -oosz.y);
    const vec2 offsetTR = range * vec2(oosz.x, -oosz.y);
    const vec2 offsetBL = range * vec2(-oosz.x, oosz.y);
    const vec2 offsetBR = range * vec2(oosz.x, oosz.y);
    const vec2 offsetL = range * vec2(-oosz.x, 0);
    const vec2 offsetR = range * vec2(oosz.x, 0);
    const vec2 offsetT = range * vec2(0, -oosz.y);
    const vec2 offsetB = range * vec2(0, oosz.y);

    
    const float depthTL = dep2D(uv + offsetTL);
    const float depthTR = dep2D(uv + offsetTR);
    const float depthBL = dep2D(uv + offsetBL);
    const float depthBR = dep2D(uv + offsetBR);
    const float depthL = dep2D(uv + offsetL);
    const float depthR = dep2D(uv + offsetR);
    const float depthT = dep2D(uv + offsetT);
    const float depthB = dep2D(uv + offsetB);

    
    // Sobel operator for horizontal and vertical gradients
    float dX = (depthTR + 2.0f * depthR + depthBR) - (depthTL + 2.0f * depthL + depthBL);
    float dY = (depthBL + 2.0f * depthB + depthBR) - (depthTL + 2.0f * depthT + depthTR);
    
    vec2 gradient = vec2(dX, dY);

    // Dynamic adjustments based on gradient information
   // float gradientMagnitude = length(gradient);
   // vec2 dynamicSteepness = gradientMagnitude; // Uniform steepness adjustment
  //  float dynamicDepthFactor = length(gradient); // Single factor for depth curve adjustment
  //  float dynamicSigmoidFactor = gradientMagnitude; // Single factor for sigmoid adjustment

    // Applying sigmoid function to gradients with dynamic values
   // vec2 ret = sigmoid(gradient, dynamicSteepness, vec2(gradientMagnitude, gradientMagnitude), vec2(1, 1));
    /*
    float averageGradientMagnitude = length(gradient);
     //ComputeAverageGradientMagnitude(oosz, depthMap, uv);
    float steepness = SelectSigmoidSteepness(averageGradientMagnitude, steepnessMinMax);
    
    float localGradientMagnitude = length(gradient);
    float adjustedSteepness = AdjustSteepness(steepness, localGradientMagnitude, steepnessMinMax.x, steepnessMinMax.y);*/
    
    //float2 steepnessMinMax = float2(0.5, 0.8);
    
    return gradient; //sigmoid(ComputeAdjustedDepthCurve(oosz, uv, gradient, flipDepth), steepnessMinMax, 0, 1);
    
                  //sigmoid(uv.y, adjustedSteepness, 0, 1)) / 2;

    //return (gradient + ComputeAdjustedDepthCurve(oosz, depthMap, uv, 0, 1)) / 2;
    //float2(log(1 + gradient.x), log(1 + gradient.y)); //sigmoid(gradient, KeyAlt ? LOOK_AT.x / 10 : 0.992, vec2(KeyControl ? LOOK_AT.x / 10 : .001, KeyControl ? LOOK_AT.y / 10 : .001), vec2(KeyShift ? LOOK_AT.x / 10 : .01, KeyShift ? LOOK_AT.y / 10 : .01));
}



static vec3 DirLightDirection = normalize(vec3(0.1, -0.1, -1));
static vec3 DirLightColor = vec3(9.3, .850, 9.7);
static float DirLightIntensity = 0.85;

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


float ApplyGammaCorrection(float colorComponent)
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


float3 RGBToXYZ(float3 c)
{
  // Normalize and apply gamma correction
    float r = c.r / 255.0;
    float g = c.g / 255.0;
    float b = c.b / 255.0;

    r = ApplyGammaCorrection(r);
    g = ApplyGammaCorrection(g);
    b = ApplyGammaCorrection(b);

  // Convert using observer= 2°, Illuminant= D65
    float x = r * 0.4124f + g * 0.3576f + b * 0.1805f;
    float y = r * 0.2126f + g * 0.7152f + b * 0.0722f;
    float z = r * 0.0193f + g * 0.1192f + b * 0.9505f;

    return float3(x, y, z);
}

// define the CIE standard observer functions
    // source: [CIE 1931 color space](https://gist.github.com/iUltimateLP/5129149bf82757b31542)
static const float x_bar[] = { 0.0001299, 0.0002321, 0.0004149, 0.0007416, 0.001368, 0.002236, 0.004243, 0.00765, 0.01431, 0.02319, 0.04351, 0.07763, 0.13438, 0.21477, 0.2839, 0.3285, 0.34828, 0.34806, 0.3362, 0.3187, 0.2908, 0.2511, 0.19536, 0.1421, 0.09564, 0.05795, 0.03201, 0.0147, 0.0049, 0.0024, 0.0093, 0.0291, 0.06327, 0.1096, 0.1655, 0.22575, 0.2904, 0.3597, 0.43345, 0.51205, 0.5945, 0.6784, 0.7621, 0.8425, 0.9163, 0.9786, 1.0263, 1.0567, 1.0622, 1.0456, 1.0026, 0.9384, 0.85445, 0.7514, 0.6424, 0.5419, 0.4479, 0.3608, 0.2835, 0.2187, 0.1649, 0.1212, 0.0874, 0.0636, 0.04677, 0.0329, 0.0227, 0.01584, 0.011359, 0.008111, 0.00579, 0.004109, 0.002899, 0.002049, 0.00144, 0.000999, 0.00069, 0.000476, 0.000332, 0.000235, 0.000166, 0.000117, 0.000083, 0.000059, 0.000042 };
static const float y_bar[] = { 0.000003917, 0.000006965, 0.00001239, 0.00002202, 0.000039, 0.000064, 0.00012, 0.000217, 0.000396, 0.00064, 0.00121, 0.00218, 0.004, 0.0073, 0.0116, 0.01684, 0.023, 0.0298, 0.038, 0.048, 0.06, 0.0739, 0.09098, 0.1126, 0.13902, 0.1693, 0.20802, 0.2586, 0.323, 0.4073, 0.503, 0.6082, 0.710, 0.7932, 0.862, 0.91485, 0.954, 0.9803, 0.99495, 1.0, 0.995, 0.9786, 0.952, 0.9154, 0.87, 0.8163, 0.757, 0.6949, 0.631, 0.5668, 0.503, 0.4412, 0.381, 0.321, 0.265, 0.217, 0.175, 0.1382, 0.107, 0.0816, 0.061, 0.04458, 0.032, 0.0232, 0.017, 0.01192, 0.00821, 0.005723, 0.004102, 0.002929, 0.002091, 0.001484, 0.001047, 0.00074, 0.00052, 0.000361, 0.000249, 0.000172, 0.00012, 0.000085, 0.00006, 0.000042 };
static const float z_bar[] = { 0.0006061, 0.001086, 0.001946, 0.003486, 0.006450001, 0.01054999, 0.02005001, 0.03621, 0.06785001, 0.1102, 0.2074, 0.3713, 0.6456, 1.0390501, 1.3856, 1.62296, 1.74706, 1.7826, 1.77211, 1.7441, 1.6692, 1.5281, 1.28764, 1.0419, 0.8129501, 0.6162, 0.46518, 0.3533, 0.272, 0.2123, 0.1582, 0.1117, 0.07824999, 0.05725001, 0.04216, 0.02984, 0.0203, 0.0134, 0.008749999, 0.005749999, 0.0039, 0.002749999, 0.0021, 0.0018, 0.001650001, 0.0014, 0.0011, 0.001, 0.0008, 0.0006, 0.00034, 0.00024, 0.00019, 0.0001, 0.00004999999, 0.00003, 0.00002, 0.00001, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 };

// This function converts an array of spectral intensity to RGB values
// intensity: the array of spectral intensity
// wavelength: the array of wavelengths
// returns: the RGB values as a float3
float3 spectral_to_rgb(float intensity[MAX_SAMPLES], int numItems, int startOffset)
{
   
    
    // define the CIE XYZ to sRGB conversion matrix
    // source: [sRGB](https://stats.stackexchange.com/questions/50873/converting-spectral-data-to-rgb-and-normalizing-appropriately)
    
    // This matrix converts xyz to linear sRGB using the D65 white point
// source: [Which matrix is correct to map XYZ to linear RGB for sRGB?](https://stackoverflow.com/questions/66360637/which-matrix-is-correct-to-map-xyz-to-linear-rgb-for-srgb)
    float3x3 xyz_to_sRGB_D65 = float3x3(3.2404542, -1.5371385, -0.4985314, -0.9692660, 1.8760108, 0.0415560, 0.0556434, -0.2040259, 1.0572252);

// This matrix converts xyz to linear Adobe RGB using the D65 white point
// source: [Adobe RGB (1998) color space](https://physics.stackexchange.com/questions/487763/how-are-the-matrices-for-the-rgb-to-from-cie-xyz-conversions-generated)
    float3x3 xyz_to_AdobeRGB_D65 = float3x3(2.0413690, -0.5649464, -0.3446944, -0.9692660, 1.8760108, 0.0415560, 0.0134474, -0.1183897, 1.0154096);

// This matrix converts xyz to linear Rec. 2020 using the D65 white point
// source: [Rec. 2020 - Wikipedia](https://scipython.com/blog/converting-a-spectrum-to-a-colour/)
    float3x3 xyz_to_Rec2020_D65 = float3x3(1.7166512, -0.3556708, -0.2533663, -0.6666844, 1.6164812, 0.0157685, 0.0176399, -0.0427706, 0.9421031);

// This matrix converts xyz to linear sRGB using the D50 white point
// source: [sRGB - Wikipedia](https://stackoverflow.com/questions/43494018/converting-xyz-color-to-rgb)
    float3x3 xyz_to_sRGB_D50 = float3x3(3.1338561, -1.6168667, -0.4906146, -0.9787684, 1.9161415, 0.0334540, 0.0719453, -0.2289914, 1.4052427);
    
    float3x3 XYZtoRGB = float3x3(3.2404542, -1.5371385, -0.4985314,
                                 -0.9692660, 1.8760108, 0.0415560,
                                 0.0556434, -0.2040259, 1.0572252);

    float3 XYZ = float3(0.0, 0.0, 0.0);

    // Loop over the spectral intensity array
    for (int i = startOffset; i < startOffset + min(numItems, 72); i++)
    {
        XYZ.x += intensity[i - startOffset] * x_bar[i];
        XYZ.y += intensity[i - startOffset] * y_bar[i];
        XYZ.z += intensity[i - startOffset] * z_bar[i];
    }

    // Convert XYZ to linear RGB
    float3 RGB = mul(XYZtoRGB, XYZ);

    // Gamma correction for sRGB
    RGB = pow(RGB, 1.0 / 2.2);

    // Ensure RGB values are within [0, 1]
    RGB = clamp(RGB, 0.0, 1.0);

    return RGB;
}

float3 spectral_to_rgb(float wavelength)
{
    const float3x3 XYZtoRGB = float3x3(3.2404542, -1.5371385, -0.4985314,
                                 -0.9692660, 1.8760108, 0.0415560,
                                 0.0556434, -0.2040259, 1.0572252);

    float3 XYZ = float3(0.0, 0.0, 0.0);

    // Loop over the spectral intensity array
    const int i = WavelengthToIndex(wavelength);
    
    XYZ.x = x_bar[i];
    XYZ.y = y_bar[i];
    XYZ.z = z_bar[i];
    

    // Convert XYZ to linear RGB
    float3 RGB = mul(XYZtoRGB, XYZ);

    // Gamma correction for sRGB
    RGB = pow(RGB, 1.0 / 2.2);

    // Ensure RGB values are within [0, 1]
    RGB = clamp(RGB, 0.0, 1.0);

    return RGB;
}


float3 WavelengthToRGB(float wavelength)
{
    return spectral_to_rgb(wavelength);
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


vec4 RGBtoHSV(vec4 rgb)
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

    return vec4(h, s, v, 1.0);
}




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


vec4 rotateHue(vec4 colorRGB, float angle)
{
    vec4 hsv = RGBtoHSV(colorRGB); // Convert to HSV
    hsv.x += angle; // Rotate the hue
    hsv.x = fmod(hsv.x, 360.0f); // Wrap the hue if it goes out of bounds
    return HSVtoRGB(hsv);
}

float Luminance(float3 color)
{
    return dot(color, float3(0.2126, 0.7152, 0.0722)); // Standard luminance calculation from RGB
}


float3 lerpSigmoidLuminocity(
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


float3 HueShift(float3 color, float hue)
{
    // Use a rotation matrix to shift the hue of the color
    const float3 k = float3(0.57735, 0.57735, 0.57735); // 1 / sqrt(3)
    float cosAngle = cos(hue);
    float sinAngle = sin(hue);
    return color * cosAngle + cross(k, color) * sinAngle + k * dot(k, color) * (1.0 - cosAngle);
}



float4 ColorCycleEffect(float4 color, float time)
{
    // Cycle through hues over time
    float hueShift = sin(time) * 0.5 + 0.5;
    return float4(HueShift(color.rgb, hueShift), color.a);
}

// Assume terrainHeight and slope are calculated elsewhere
float AdaptiveErosion(float terrainHeight, float slope, float time)
{
    float erosionFactor = sigmoid(slope, 0.5, 10.0, 1); // Smooth transition based on slope
    float erosion = noise(terrainHeight) * erosionFactor * sin(time); // Dynamic erosion over time
    return terrainHeight - erosion;
}
float3 ProceduralNebula(float3 position, float time)
{
    float density = PerlinNoise(position * 0.1) * sigmoid(length(position), 0.5, 5.0, 1);
    float3 color = lerp(float3(0.2, 0.3, 0.7), float3(1.0, 0.9, 0.6), density);
    return color * pow(sin(time), 2.0); // Dynamic intensity
}
float RefractionIndex(float interactionStrength)
{
    return 1.0 + sigmoid(interactionStrength, 0.5, 15.0, 1) * 0.3; // Adjust refraction index
}

float3 RefractLight(float3 viewDir, float3 normal, float interactionStrength)
{
    float eta = RefractionIndex(interactionStrength);
    return refract(viewDir, normal, eta);
}


// A function that applies a holographic color effect to a texture
float4 HolographicEffect(float4 color, float2 uv, float time)
{
    // Use a noise texture to create a random pattern
    float noisev = WorleyNoise(uv, 10.0).r;
    
    // Use a sine wave to create a rainbow gradient
    float hue = sin(uv.x * 6.28 + time) * 0.5 + 0.5;
    
    // Shift the hue of the color by the noise and gradient values
    float3 shiftedColor = HueShift(color.rgb, hue + noisev * 0.2);
    
    // Add some brightness and contrast to the color
    shiftedColor = saturate((shiftedColor - 0.5) * 1.5 + 0.5);
    
    // Return the final color with the original alpha
    return float4(shiftedColor, color.a);
}

float3 lerpDynamicRange(float3 color1, float3 color2)
{
    float luminance1 = Luminance(color1);
    float luminance2 = Luminance(color2);
    float mixFactor = luminance1 / (luminance1 + luminance2);
    return lerp(color1, color2, mixFactor);
}


float3 lerpFrequencyRange(float3 color1, float3 color2, float frequency)
{
    float mixFactor = sin(frequency * PI);
    return lerp(color1, color2, mixFactor);
}

float3 lerpGradientFlow(float3 color1, float3 color2, float2 direction)
{
    float mixFactor = dot(normalize(direction), float2(1.0, 0.0)); // Example: horizontal gradient
    return lerp(color1, color2, mixFactor);
}
float3 WaterSurface(float3 position, float time)
{
    // Simulate moving water surface using sine waves
    float wave = sin(position.x * 0.1 + time) * cos(position.z * 0.1 + time) * 0.5;
    return float3(position.x, wave, position.z);
}
float4 ProjectShadow(float4 position, float3 lightDir)
{
    // Project a dynamic shadow based on light direction
    float3 shadowDir = normalize(lightDir);
    float shadowLength = 1.0; // Can vary based on light intensity
    return float4(position.xyz + shadowDir * shadowLength, 1.0);
}



struct DichroismParams
{
    float Thickness;
    float RefractiveIndex;
};


float GetDepth(float2 oosz, float2 uv, float radius, float2 gradient, bool flipDepth)
{
    float f = dep2D(uv);
    
    return f;
}

float GetDepth(float2 oosz, float2 uv, float radius, float2 gradient, float2 depthCurve, bool flipDepth)
{
    float f = dep2D(uv);
    
    float2 steepnessMinMax = float2(0.5, 0.8);
    
    return f * length(sigmoid(depthCurve, steepnessMinMax, 0, 1));
}

float3 FresnelSchlick(float cosTheta, float3 F0)
{
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, FresnelPower);
}


vec4 FresnelSchlickN0(vec4 f0, vec4 H, vec4 V)
{
    return f0 + (1.0f - f0) * pow(abs(1.0f - dot(H, V)), FresnelPower);
}

float3 FresnelSchlick2(float3 F0, float3 H, float3 N, float3 power)
{
    return F0 + (1.0 - F0) * pow(1.0 - dot(N, H), power);
}


float4 FresnelSchlick(float4 refractiveIndex, float4 surroundingRefractiveIndex, float4 cosIncidenceAngle)
{
    float4 F0 = (refractiveIndex * refractiveIndex - surroundingRefractiveIndex * surroundingRefractiveIndex) / (refractiveIndex * refractiveIndex + surroundingRefractiveIndex * surroundingRefractiveIndex);
    return F0 + (1.0f - F0) * pow(1.0f - cosIncidenceAngle, FresnelPower);
}

vec4 Fresnel(vec4 cosTheta, float4 fresnelPower)
{
    return exp2((cosTheta * -5.55473 - 6.98316) * cosTheta) / (cosTheta * (1 - fresnelPower)) * fresnelPower;
}

vec4 Fresnel(vec4 cosTheta)
{
    return exp2((cosTheta * -5.55473 - 6.98316) * cosTheta);
}

vec4 Schlick(vec4 F0, vec4 fresnel, vec4 fresnelPower)
{
    return ((F0 * (1.0 - fresnel)) + fresnelPower * fresnel);
}


vec3 ComputeFresnel(vec3 rayDirection, vec3 normal, vec3 refractiveIndex)
{
    float cosTheta = dot(-rayDirection, normal);
    float3 r0 = (1.0 - refractiveIndex) / (1.0 + refractiveIndex);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow(1.0 - cosTheta, FresnelPower);
}


float ComputeFresnel2(vec3 rayDirection, vec3 normal, float refractiveIndex)
{
    float cosI = dot(-rayDirection, normal);
    float sinT2 = refractiveIndex * refractiveIndex * (1.0 - cosI * cosI);
    if (sinT2 > 1.0)
        return 1.0; // Total internal reflection
    float cosT = sqrt(1.0 - sinT2);
    float rOrth = (refractiveIndex * cosI - cosT) / (refractiveIndex * cosI + cosT);
    float rPar = (cosI - refractiveIndex * cosT) / (cosI + refractiveIndex * cosT);
    return (rOrth * rOrth + rPar * rPar) / 2.0;
}



vec3 FresnelReflectionFN(vec3 lightColor, float fresnel)
{
    return lightColor * fresnel;
}
vec4 FresnelGlow(vec4 value, vec4 fresnel, float brightnessFactor)
{
    // Adjust the brightness of the object based on the Fresnel value
    return value * (1.0 + fresnel * brightnessFactor);
}

vec4 PhaseFunction(vec4 normal, vec4 viewDir, vec4 phaseFactor)
{
    float cosTheta = clamp011(max(0.0, dot(normalize(normal.xyz), -normalize(viewDir.xyz))));
    return clamp011(1.0f / (4.0f * 3.14159f) * (1.0f + clamp011(phaseFactor * cosTheta * cosTheta)));
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
    float4 fresnel = FresnelSchlick(params.RefractiveIndex, surroundingRefractiveIndex, acos(dot(viewDir, lightDir)));

    float4 fresnel2 = FresnelSchlick(params.RefractiveIndex, surroundingRefractiveIndex, acos(dot(viewDir, -lightDir)));

  // Calculate the final color of the surface.
    float finalColorR = lerp(reflectedColor.x, transmittedColor.x, lerp(fresnel.x, fresnel2.x, transmittance * acos(dot(viewDir, lightDir))));
    float finalColorG = lerp(reflectedColor.y, transmittedColor.y, lerp(fresnel.y, fresnel2.y, transmittance * acos(dot(viewDir, lightDir))));
    float finalColorB = lerp(reflectedColor.z, transmittedColor.z, lerp(fresnel.z, fresnel2.z, transmittance * acos(dot(viewDir, lightDir))));
    float finalColorA = lerp(reflectedColor.w, transmittedColor.w, lerp(fresnel.w, fresnel2.w, transmittance * acos(dot(viewDir, lightDir))));

    return float4(finalColorR, finalColorG, finalColorB, finalColorA);
}


float3 diffractLight(float3 lightDir, float3 surfaceNormal, float wavelength)
{
    // Simplified diffraction calculation
    float diffractionAngle = dot(lightDir, surfaceNormal) * wavelength;
    return float3(sin(diffractionAngle), cos(diffractionAngle), sin(-diffractionAngle));
}




float3 diffractPattern(float3 normal, float3 lightDir, float wavelength, float intensity)
{
    float3 diffractionColor = 0.0;
    float angle = dot(normal, lightDir);
    float pattern = sin(angle * wavelength) * intensity;
    diffractionColor.r = pattern * 0.5 + 0.5;
    diffractionColor.g = pattern * 0.3 + 0.7;
    diffractionColor.b = pattern * 0.1 + 0.9;
    return diffractionColor;
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
        float3(LayeredNoise(float3(uv, 1)),
               LayeredNoise(float3(uv, 2)),
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


float4 diffractionMicrostructureRender(float2 uv, float3 lightDir)
{
    float3 normal = diffractionMicrostructureNormal(uv);
    float3 color = diffractPattern(normal, lightDir, 0.5, 1.0);
    return float4(color, 1.0);
}

// Main rendering function
float4 diffractionMicrostructureRenderAdvanced(float2 uv, float3 lightDir, float lambda)
{
    float3 normal = diffractionMicrostructureNormalAdvanced(uv);
    float3 diffractionColor = diffractMicrostructure(normal, lightDir, lambda);
    // Combining diffraction with base color and other effects
    return float4(diffractionColor, 1.0);
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
    return vec3(PerlinNoise(v.x), PerlinNoise(v.y), PerlinNoise(v.z));
}


float IntegrateNoise(float2 uv, float noiseIntensity)
{
    // Placeholder for noise function - replace with actual noise implementation
    float noisev = PerlinNoise(float3(uv * noiseIntensity, noiseIntensity));
    return noisev * noiseIntensity;
}

float3 IntegrateNoise3(float2 uv, float noiseIntensity)
{
    return Perlin3(vec3(uv * TotalTime, length(uv) * TotalTime));

}



float3 GetNormal(float2 oosz, float2 uv, float dist, float2 gradientModulation, float2 gradient, float2 depthCurve)
{
    
    // Use the sigmoid function to scale the gradient modulation factor
    float2 scaledGradMod = gradientModulation * depthCurve;
    
    vec3 c = normal2D(normalMap, uv);
    vec3 l = normal2D(normalMap, uv + float2(-1, 0) * oosz * scaledGradMod);
    vec3 r = normal2D(normalMap, uv + float2(1, 0) * oosz * scaledGradMod);
    vec3 u = normal2D(normalMap, uv + float2(0, -1) * oosz * scaledGradMod);
    vec3 d = normal2D(normalMap, uv + float2(0, 1) * oosz * scaledGradMod);
    
    // Use the scaled gradient modulation factor to compute the normal vector
    vec3 perterbZ = vec3(0, 0, 1) * vec3(scaledGradMod, 1);
    vec3 n = lerp((l + r + u + d) / 3, c, .75);
    
    vec3 ret = normalize(n + n * vec3(scaledGradMod, 1) + n * perterbZ);
    
    return ret;
    
}

vec3 PerturbSurfaceNormal(float2 oosz, float2 uv, float depth, bool flipDepth)
{
    const float perturbScale = 0.1; // Control strength of normal bending
    float2 gradient = GetGradient(oosz, uv, normalRadius, flipDepth);
    // Sample nearby heights. Consider larger 'radius' for smoother surfaces
    float2 offsetX = float2(ddx(uv.x), 0.0);
    float2 offsetY = float2(0.0, ddy(uv.y));
    float h0 = GetDepth(oosz, uv, normalRadius, gradient, flipDepth);
    float h1 = GetDepth(oosz, uv + offsetX, normalRadius, GetGradient(oosz, uv + offsetX, normalRadius, flipDepth), flipDepth);
    float h2 = GetDepth(oosz, uv + offsetY, normalRadius, GetGradient(oosz, uv + offsetY, normalRadius, flipDepth), flipDepth);

    vec2 dx = perturbScale * offsetX * (h0 - h1);
    vec2 dy = perturbScale * offsetY * (h0 - h2);
    vec2 dc = ComputeAdjustedDepthCurve2(oosz, uv, flipDepth);
    vec3 surfaceNormal = GetNormal(oosz, uv, normalRadius, GetModulation(gradient, dc), gradient, dc);
    return normalize(surfaceNormal + cross(vec3(dy, 0), vec3(dx, 0)));
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




DepthNormal ComputeUltimateDepthGradientAndNormal
    (
    float2 oosz,
    Texture2D<float> depthMap, float2 uv, float radius,
    bool flipDepth)
{
    // Return the depth and the normalized surface normal
    DepthNormal result;
    result.uv = uv;
    result.radius = radius;
    result.gradient = GetGradient(oosz, uv, radius, flipDepth);
    result.depthCurve = ComputeAdjustedDepthCurve(oosz, uv, flipDepth);
    result.modulation = GetModulation(result.gradient, result.depthCurve);
    result.normal = GetNormal(oosz, uv, radius, result.modulation, result.gradient, result.depthCurve).xyz;
    result.depth = GetDepth(oosz, uv, radius, result.gradient, result.depthCurve, flipDepth);
    result.color = mir2D(diffuseMap, uv).xyz;
    return result;
}

struct GradientInfoEx2
{
    float2 uv;
    float2 radius;
    float depth;
    vec2 gradient;
    vec2 modulation;
    vec4 dcLRUD1;
    vec3 normal;
};




GradientInfoEx GetGradientInfoEx(float2 oosz, Texture2D<float> depthMap, float2 uv, float radius, bool flipDepth)
{
    GradientInfoEx ret;
    
    DepthNormal g = ComputeUltimateDepthGradientAndNormal(oosz, depthMap, uv, radius, flipDepth);
    
    
    ret.uv = g.uv;
    ret.radius = g.radius;
    
    ret.depth = g.depth;
    
    ret.gradient = g.gradient;
    ret.modulation = g.modulation;
    
    
    ret.normal = g.normal;
    
    return ret;
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
    return clamp(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], 0.35), 0.35), 0.35), s0), epsilon, (1 - epsilon)) * diffuseBlend;
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
    return clamp(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], 0.35), 0.35), 0.35), s0), epsilon, (1 - epsilon));
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
    return clamp(lerp(color, lerp(blurColor[3], lerp(blurColor[2], lerp(blurColor[1], blurColor[0], weightsLRUD.x), weightsLRUD.y), weightsLRUD.z), weightsLRUD.w), epsilon, (1 - epsilon));
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

};
float CalculateRefractiveIndexUsingSellmeier(MaterialProperties material, float wavelength)
{
    // Convert wavelength to micrometers from meters for the equation
    float lambda = wavelength / 1000;
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



MaterialProperties CreateMaterialFusedSilica()
{
    SellmeierCoefficient coef1_FusedSilica = { 0.6961663, 0.0684043 * 0.0684043 };
    SellmeierCoefficient coef2_FusedSilica = { 0.4079426, 0.1162414 * 0.1162414 };
    SellmeierCoefficient coef3_FusedSilica = { 0.8974794, 9.896161 * 9.896161 };

    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = vec3(1.0, 1.0, 1.0);
    ret.refractiveIndex = 1.458;
    ret.sellmeierCoefficients[0] = coef1_FusedSilica;
    ret.sellmeierCoefficients[1] = coef2_FusedSilica;
    ret.sellmeierCoefficients[2] = coef3_FusedSilica;
    ret.smoothness = .5;
    ret.metalness = 0;
    return ret;
}

MaterialProperties CreateMaterialBK7Glass()
{
    SellmeierCoefficient coef1_BK7 = { 1.03961212, 0.00600069867 };
    SellmeierCoefficient coef2_BK7 = { 0.231792344, 0.0200179144 };
    SellmeierCoefficient coef3_BK7 = { 1.01046945, 103.560653 };
    float3 baseColor_BK7 = { 1.0, 1.0, 1.0 }; // Assuming white, adjust as needed
    float refractiveIndex_BK7 = 1.5168; // Representative refractive index at a specific wavelength
    
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = baseColor_BK7;
    ret.refractiveIndex = refractiveIndex_BK7;
    ret.sellmeierCoefficients[0] = coef1_BK7;
    ret.sellmeierCoefficients[1] = coef2_BK7;
    ret.sellmeierCoefficients[2] = coef3_BK7;
    ret.smoothness = 1;
    ret.metalness = 0;
    return ret;
}


MaterialProperties CreateMaterialRuby()
{
    SellmeierCoefficient coef1_Ruby = { 1.76, 0.0691 * 0.0691 };
    SellmeierCoefficient coef2_Ruby = { 0.27683, 0.05625 * 0.05625 };
    SellmeierCoefficient coef3_Ruby = { 0.0, 0.0 }; // Assuming only two significant coefficients
    float3 baseColor_Ruby = { 0.8, 0.05, 0.05 }; // Deep red
    float refractiveIndex_Ruby = 1.77; // Representative refractive index at a specific wavelength
    
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = baseColor_Ruby;
    ret.refractiveIndex = refractiveIndex_Ruby;
    ret.sellmeierCoefficients[0] = coef1_Ruby;
    ret.sellmeierCoefficients[1] = coef2_Ruby;
    ret.sellmeierCoefficients[2] = coef3_Ruby;
    ret.smoothness = .5;
    ret.metalness = .2;
    return ret;
}


MaterialProperties CreateMaterialDiamond()
{
    SellmeierCoefficient coef1_Diamond = { 0.3306, 0.1750 * 0.1750 };
    SellmeierCoefficient coef2_Diamond = { 4.3356, 0.1060 * 0.1060 };
    SellmeierCoefficient coef3_Diamond = { 0.0, 0.0 }; // Diamond has only two significant coefficients
    float3 baseColor_Diamond = { 1.0, 1.0, 1.0 }; // Assuming clear/white
    float refractiveIndex_Diamond = 2.417; // Representative refractive index at a specific wavelength
    
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = baseColor_Diamond;
    ret.refractiveIndex = refractiveIndex_Diamond;
    ret.sellmeierCoefficients[0] = coef1_Diamond;
    ret.sellmeierCoefficients[1] = coef2_Diamond;
    ret.sellmeierCoefficients[2] = coef3_Diamond;
    ret.smoothness = .5;
    ret.metalness = .20;
    return ret;
}

MaterialProperties CreateMaterialSaphire()
{
    SellmeierCoefficient coef1_Sapphire = { 1.4313493, 0.0726631 * 0.0726631 };
    SellmeierCoefficient coef2_Sapphire = { 0.65054713, 0.1193242 * 0.1193242 };
    SellmeierCoefficient coef3_Sapphire = { 5.3414021, 18.028251 * 18.028251 };
    float3 baseColor_Sapphire = { 0.0, 0.5, 1.0 }; // Blue, adjust as needed
    float refractiveIndex_Sapphire = 1.768; // Representative refractive index at a specific wavelength
    
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = baseColor_Sapphire;
    ret.refractiveIndex = refractiveIndex_Sapphire;
    ret.sellmeierCoefficients[0] = coef1_Sapphire;
    ret.sellmeierCoefficients[1] = coef2_Sapphire;
    ret.sellmeierCoefficients[2] = coef3_Sapphire;
    ret.smoothness = 1;
    ret.metalness = .20;
    return ret;
}

MaterialProperties CreateMaterialCrownGlass()
{
    SellmeierCoefficient coef1_CrownGlass = { 1.5212052, 0.0047001 * 0.0047001 };
    SellmeierCoefficient coef2_CrownGlass = { 0.2092379, 0.0153619 * 0.0153619 };
    SellmeierCoefficient coef3_CrownGlass = { 0.8356891, 129.4049 * 129.4049 };
    float3 baseColor_CrownGlass = { 1.0, 1.0, 1.0 }; // Assuming white, adjust as needed
    float refractiveIndex_CrownGlass = 1.52; // Representative refractive index at a specific wavelength

    
    MaterialProperties ret;
    ret.outsideRefractiveIndex = 1;
    ret.baseColor = baseColor_CrownGlass;
    ret.refractiveIndex = refractiveIndex_CrownGlass;
    ret.sellmeierCoefficients[0] = coef1_CrownGlass;
    ret.sellmeierCoefficients[1] = coef2_CrownGlass;
    ret.sellmeierCoefficients[2] = coef3_CrownGlass;
    ret.smoothness = 1;
    ret.metalness = .2;
    return ret;
}

MaterialProperties CreatePrismMaterial()
{
    MaterialProperties prismMaterial;
    prismMaterial.outsideRefractiveIndex = 1;
    SellmeierCoefficient coef1_prism = { 0.6961663, 0.0684043 * 0.0684043 };
    SellmeierCoefficient coef2_prism = { 0.4079426, 0.1162414 * 0.1162414 };
    SellmeierCoefficient coef3_prism = { 0.8974794, 9.896161 * 9.896161 };
    
    prismMaterial.sellmeierCoefficients[0] = coef1_prism;
    prismMaterial.sellmeierCoefficients[1] = coef2_prism;
    prismMaterial.sellmeierCoefficients[2] = coef3_prism;
    prismMaterial.baseColor = float3(1.0, 1.0, 1.0); // Clear
    prismMaterial.refractiveIndex = 1.5; // Approximate value
    prismMaterial.smoothness = 1;
    prismMaterial.metalness = 0;
    return prismMaterial;
}

MaterialProperties CreateMylarMaterial()
{
    MaterialProperties mylarMaterial;
    mylarMaterial.outsideRefractiveIndex = 1;
    SellmeierCoefficient coef1_mylar = { 1.281, 0.05914 * 0.05914 };
    SellmeierCoefficient coef2_mylar = { 0.980, 0.1589 * 0.1589 };
    SellmeierCoefficient coef3_mylar = { 1.099, 0.9392 * 0.9392 };
    
    
    mylarMaterial.sellmeierCoefficients[0] = coef1_mylar;
    mylarMaterial.sellmeierCoefficients[1] = coef2_mylar;
    mylarMaterial.sellmeierCoefficients[2] = coef3_mylar;
    mylarMaterial.baseColor = float3(0.95, 0.95, 1.0); // Reflective with a hint of color
    mylarMaterial.refractiveIndex = 1.65; // Approximate value
    mylarMaterial.smoothness = .5;
    mylarMaterial.metalness = .8;
    
    return mylarMaterial;
}

MaterialProperties CreateOpalMaterial()
{
    MaterialProperties opalMaterial;
    opalMaterial.outsideRefractiveIndex = 1;
    SellmeierCoefficient coef1_opal = { 1.44, 0.0795 * 0.0795 };
    SellmeierCoefficient coef2_opal = { 0.55, 0.1216 * 0.1216 };
    SellmeierCoefficient coef3_opal = { 1.10, 0.5501 * 0.5501 };
    
    opalMaterial.sellmeierCoefficients[0] = coef1_opal;
    opalMaterial.sellmeierCoefficients[1] = coef2_opal;
    opalMaterial.sellmeierCoefficients[2] = coef3_opal;
    opalMaterial.baseColor = float3(1.0, 0.96, 0.8); // Pearly, milky appearance
    opalMaterial.refractiveIndex = 1.45; // Approximate value
    opalMaterial.smoothness = .8;
    opalMaterial.metalness = .8;
    return opalMaterial;
}

float3 RefractRay(float3 rayDirection, float3 normal, float refractiveIndex)
{
    // Ensure vectors are normalized
    rayDirection = normalize(rayDirection);
    normal = normalize(normal);

    float cosI = dot(-rayDirection, normal);

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
    float cosIncidentAngle = dot(-incidentRay, normal);
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
    // Assuming both incidentRay and normal are normalized
    float ret = acos(dot(incidentRay, normal));
    
    if (ret < 0)
    {
        ret = acos(dot(-incidentRay, -normal));

    }
    
    return ret;
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




vec4 ColorBlendAdvanced(vec4 currentColor, vec4 newColor, float depthWeight, vec3 normal, vec3 viewDir)
{
    // Implement advanced blending techniques
    // Placeholder: Depth and normal influenced blend
    float blendFactor = smoothstep(0.5, 1, depthWeight * dot(normalize(normal), viewDir));
    return lerp(currentColor, newColor, blendFactor);
}

PolarizationEffects CalculatePolarizationEffects(float incidentAngleRadians, float refractedAngleRadians, float refractiveIndex1, float refractiveIndex2)
{
    PolarizationEffects effects;

    // Check for edge cases to avoid numerical instability
    if (abs(incidentAngleRadians) < epsilon || abs(incidentAngleRadians - PI / 2) < epsilon || refractedAngleRadians < 0.0)
    {
        effects.reflectanceS = 1.0;
        effects.reflectanceP = 1.0;
        effects.transmittanceS = 0.0;
        effects.transmittanceP = 0.0;
        return effects;
    }

    // Calculate cosines of incident and refracted angles
    float cosIncident = cos(incidentAngleRadians);
    float cosRefracted = cos(refractedAngleRadians);

    // Calculate reflectance for s-polarized light
    float rsNumerator = refractiveIndex1 * cosIncident - refractiveIndex2 * cosRefracted;
    float rsDenominator = refractiveIndex1 * cosIncident + refractiveIndex2 * cosRefracted;
    if (abs(rsDenominator) < epsilon)
    {
        rsDenominator = epsilon;
    }
    float rs = rsNumerator / rsDenominator;
    effects.reflectanceS = rs * rs;

    // Calculate reflectance for p-polarized light
    float rpNumerator = refractiveIndex2 * cosIncident - refractiveIndex1 * cosRefracted;
    float rpDenominator = refractiveIndex2 * cosIncident + refractiveIndex1 * cosRefracted;
    if (abs(rpDenominator) < epsilon)
    {
        rpDenominator = epsilon;
    }
    float rp = rpNumerator / rpDenominator;
    effects.reflectanceP = rp * rp;

    // Calculate transmittance as 1 - reflectance
    effects.transmittanceS = 1 - effects.reflectanceS;
    effects.transmittanceP = 1 - effects.reflectanceP;

    return effects;
}

struct Polarization
{
    PolarizationEffects polarizationEffects[3];
    float3 averageTransmittance;
    
    float hasRefraction[3];
    float hasRefractionColor[3];
};

struct DisperseColor
{
    float incidentAngle;
    float3 incidentRay;
    float refractedAngle[3];
    float3 refractedRay[3];
    
    float3 color[3];
};

float3 MixColorsByRefractionAngle(float3 incidentRay, float3 normal, MaterialProperties material, float3 mixAngles)
{
    float3 colorResult = float3(0.0, 0.0, 0.0);
    float3 baseColors[3] = { float3(1, 0, 0), float3(0, 1, 0), float3(0, 0, 1) }; // Red, Green, Blue
    [unroll]
    for (int i = 0; i < 3; ++i)
    {
        float refractiveIndex = CalculateRefractiveIndexUsingSellmeier(material, mixAngles[i]);
        float refractedAngle = CalculateRefractedAngle(incidentRay, normal, refractiveIndex, 1.0);
        float3 refractedRay = RefractRay(incidentRay, normal, refractiveIndex);

        // The mix factor can be based on the angle, intensity, or other criteria
        float mixFactor = dot(refractedRay, normal) * material.baseColor * cos(refractedAngle);
        //cos(refractedAngle); // Define how mix factor is calculated
        colorResult += mixFactor * baseColors[i];
    }

    return colorResult;
}


float ComputeFresnelForTotalInternalReflection(float3 incidentRay, float3 normal, float refractiveIndex)
{
    float cosI = dot(-incidentRay, normal);
    float sinT2 = refractiveIndex * refractiveIndex * (1.0 - cosI * cosI);
    if (sinT2 > 1.0)
        return 1.0; // Total internal reflection

    float cosT = sqrt(max(0.0, 1.0 - sinT2));
    float rOrth = (refractiveIndex * cosI - cosT) / (refractiveIndex * cosI + cosT);
    float rPar = (cosI - refractiveIndex * cosT) / (cosI + refractiveIndex * cosT);
    return (rOrth * rOrth + rPar * rPar) / 2.0;
}


float CalculateFresnelReflectance(MaterialProperties material, float3 incidentRay, float3 normal, float wavelength)
{
    float n1 = 1.0; // Air refractive index
    float n2 = CalculateRefractiveIndexUsingSellmeier(material, wavelength);
    float cosThetaI = dot(-normalize(incidentRay), normalize(normal));
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = n1 / n2 * sinThetaI;
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);
    
    float Rs = pow((n1 * cosThetaI - n2 * cosThetaT) / (n1 * cosThetaI + n2 * cosThetaT), 2.0);
    float Rp = pow((n2 * cosThetaI - n1 * cosThetaT) / (n2 * cosThetaI + n1 * cosThetaT), 2.0);
    
    return (Rs + Rp) / 2.0; // Average reflectance for unpolarized light
}



float3 CalculateDispersedColorWithoutPolarization(float3 incidentRay, float3 normal, MaterialProperties material)
{
    float3 dispersedColor = float3(0.0, 0.0, 0.0);
    float wavelengths[3] = { 700e-9, 546.1e-9, 435.8e-9 }; // Red, Green, Blue wavelengths
    [unroll]
    for (int i = 0; i < 3; ++i)
    {
        float refractiveIndex = CalculateRefractiveIndexUsingSellmeier(material, wavelengths[i]);
        float refractedAngle = CalculateRefractedAngle(incidentRay, normal, 1.0, refractiveIndex);
        
        if (refractedAngle >= 0)
        {
            float3 refractedRay = RefractRay(incidentRay, normal, refractiveIndex);
            float intensityFactor = max(epsilon, dot(incidentRay, refractedRay));

            // Fresnel equation to calculate the reflectance at each wavelength
            float reflectance = ComputeFresnelForTotalInternalReflection(incidentRay, refractedRay, refractiveIndex);

            // Adjust color intensity based on Fresnel reflectance and material properties
            dispersedColor[i] = (1.0 - reflectance) * intensityFactor * material.baseColor[i] + material.baseColor[i] * .2;
        }
        else
        {
            // Handle total internal reflection by diminishing the color contribution
            dispersedColor[i] = material.baseColor[i] * 0.1;
        }
    }

    return dispersedColor;
}

// Calculate the Fresnel reflection coefficient based on Schlick's approximation.
// This function calculates the reflection ratio for an interface between two media
// given the incident view direction, surface normal, and the refractive indices of the two media.
float CalculateFresnelReflection(float3 incidentRay, float3 normal, float refractiveIndex, float outsideRefractiveIndex = 1.0)
{
    // Ensure the incident ray and normal are normalized
    incidentRay = normalize(incidentRay);
    normal = normalize(normal);

    // Calculate the cosine of the angle between the incident ray and the surface normal
    float cosThetaI = dot(-incidentRay, normal);
    // Clamp the result to avoid potential numerical issues
    cosThetaI = clamp(cosThetaI, -1.0, 1.0);

    // Calculate sines of the incident and transmitted angles using Snell's law
    float sinThetaI = sqrt(1.0 - cosThetaI * cosThetaI);
    float sinThetaT = (outsideRefractiveIndex / refractiveIndex) * sinThetaI;

    if (sinThetaT >= 1.0)
    {
        // Total internal reflection occurs if the transmitted angle's sine is >= 1
        return 1.0; // Reflect all the light
    }

    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);

    // Calculate the Fresnel reflectance using Schlick's approximation
    float R0 = pow((refractiveIndex - outsideRefractiveIndex) / (refractiveIndex + outsideRefractiveIndex), 2);
    float reflectionCoefficient = R0 + (1.0 - R0) * pow(1.0 - cosThetaI, FresnelPower);

    return reflectionCoefficient; // Return the Fresnel reflection coefficient
}
/// dIntensity_dx: Differential equation representing the rate of intensity change
// due to absorption in a medium. The rate is proportional to the current intensity.
// x: The position or depth into the medium (arbitrary units).
// I: The current intensity at position x.
float dIntensity_dx(float x, float I)
{
    // Simplified model with constant absorption coefficient
    float absorptionCoefficient = -0.009;
    return absorptionCoefficient * I;
}

// CalculateIntensityRK4: Calculates the intensity of light at a distance `x` from
// the initial position `x0` using the RK4 method.
// x0: Initial position.
// I0: Initial intensity of light.
// h: Step size for the RK4 integration.
// steps: Number of steps to integrate over.
float CalculateIntensityRK4(float x0, float I0, float h, int steps)
{
    float x = x0;
    float I = I0;
    for (int i = 0; i < steps; ++i)
    {
        float k1 = h * dIntensity_dx(x, I);
        float k2 = h * dIntensity_dx(x + 0.5 * h, I + 0.5 * k1);
        float k3 = h * dIntensity_dx(x + 0.5 * h, I + 0.5 * k2);
        float k4 = h * dIntensity_dx(x + h, I + k3);
        
        // Update the intensity based on the weighted average of slopes.
        I += (k1 + 2 * k2 + 2 * k3 + k4) / 6.0;
        x += h; // Note: x update is unnecessary if it's not used after integration.
    }
    return I;
}


// Calculate spectral intensities for chromatic aberration effect
float3 CalculateSpectralIntensitiesForCA(MaterialProperties material, float incidentAngle, float3 incidentRay, float3 normal)
{
    float3 spectralIntensities = float3(0.0, 0.0, 0.0);
    float wavelengths[3] = { 700.0, 550.0, 400.0 }; // Sample wavelengths for R, G, B in nm
    
    for (int i = 0; i < 3; ++i)
    {
        float n = abs(CalculateRefractiveIndexUsingSellmeier(material, wavelengths[i]));
        // Assuming air to material transition with air's refractive index approximated to 1
        float theta_i = acos(dot(normalize(incidentRay), normalize(normal))); // Angle of incidence
        float sinTheta_t = sin(incidentAngle) / n; // Snell's law for sin(theta_t)
        float theta_t = asin(sinTheta_t); // Refraction angle

        // Simulate intensity variation due to chromatic aberration
        // This could be further refined with a physical model or empirical data
        float deltaTheta = abs(theta_t - theta_i); // Difference in angles as a simple measure of dispersion
        spectralIntensities[i] = clamp(1.0 - deltaTheta, 0, 1); // Simplified model: intensity decreases as angle difference increases
        
        spectralIntensities[i] += abs(CalculateIntensityRK4(wavelengths[i], theta_i, 1e-9, 2));

    }
    
    return spectralIntensities;
}


// Linear interpolation function
float LinearInterpolate(float x, float x0, float y0, float x1, float y1)
{
    return y0 + (x - x0) * (y1 - y0) / (x1 - x0);
}
// Define constants for array sizes
#define WAVELENGTH_DATA_SIZE 4

// Example data points for the CIE 1931 color matching functions, simplified for illustration.
// Note: Wavelengths in meters, but HLSL doesn't support scientific notation like 380e-9 directly.
const float wavelengthData[WAVELENGTH_DATA_SIZE] = { 380, 450, 550, 780 }; // In nanometers for simplicity
const float xData[WAVELENGTH_DATA_SIZE] = { 0.0014, 0.0072, 0.5908, 0.0601 };
const float yData[WAVELENGTH_DATA_SIZE] = { 0.0000, 0.0725, 0.9950, 0.0000 };
const float zData[WAVELENGTH_DATA_SIZE] = { 0.0065, 0.8370, 0.2000, 0.0002 };

// Generic function to get interpolated value from a data table
float GetInterpolatedValue(float wavelength, const float wavelengthData[WAVELENGTH_DATA_SIZE], const float valueData[WAVELENGTH_DATA_SIZE], int dataSize)
{
    for (int i = 0; i < dataSize - 1; ++i)
    {
        if (wavelength >= wavelengthData[i] && wavelength <= wavelengthData[i + 1])
        {
            return LinearInterpolate(wavelength, wavelengthData[i], valueData[i], wavelengthData[i + 1], valueData[i + 1]);
        }
    }
    return 1.0f; // Return zero if wavelength is outside the data range
}

// Functions to get x, y, z values for a given wavelength (nanometers)
float XMatchFunction(float wavelength)
{
    return GetInterpolatedValue(wavelength, wavelengthData, xData, WAVELENGTH_DATA_SIZE);
}

float YMatchFunction(float wavelength)
{
    return GetInterpolatedValue(wavelength, wavelengthData, yData, WAVELENGTH_DATA_SIZE);
}

float ZMatchFunction(float wavelength)
{
    return GetInterpolatedValue(wavelength, wavelengthData, zData, WAVELENGTH_DATA_SIZE);
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


float3 CalculateDispersedColor(float wavelength, float refractiveIndex)
{
    // Basic mapping of wavelength to RGB, simplified for demonstration
    float3 color = WavelengthToRGB(wavelength);

    // Simulate dispersion effect by adjusting color intensity based on refractive index
    // Higher refractive index -> more dispersion -> brighter colors at the spectrum's edges
    float dispersionFactor = (refractiveIndex - 1.0) * 0.2; // Simplified factor for visualization
    float3 edgeColors = float3(1.0, 0.0, 0.0) * (wavelength < 500e-9) +
                        float3(0.0, 0.0, 1.0) * (wavelength > 600e-9);
    
    // Blend original color with edge colors based on dispersion factor
    color = lerp(color, edgeColors, dispersionFactor);

    return saturate(color); // Ensure color components are within [0, 1]
}


// Example function to calculate spectral intensity (simplified)
float CalculateIntensity(MaterialProperties mat, float wavelength, float sourceIntensity)
{
    float refractiveIndex = CalculateRefractiveIndexUsingSellmeier(mat, wavelength);
    float transmission = 0.99; // Assume 90% transmission for simplification

    // Incorporate dispersion effects (simplified)
    float dispersionEffect = clamp(refractiveIndex - 1.0, 0, 1); // Simplified dispersion effect

    return clamp(sourceIntensity * transmission - dispersionEffect, 0.1, 1);
}
// Calculates the Fresnel effect using Schlick's approximation
vec3 fresnelSchlick(float cosTheta, vec3 F0)
{
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, FresnelPower);
}

// Calculate chromatic dispersion and Fresnel reflectance
vec3 calculateChromaticDispersionFresnel(vec3 normal, vec3 viewDir, vec3 IOR, vec3 lightColor)
{
    // Calculate cosTheta using the dot product between the normal and view direction
    float cosTheta = clamp(dot(normal, -viewDir), 0.0, 1.0);

    // Assuming IOR is the refractive index for RGB components, calculate Fresnel reflectance for each
    vec3 F0 = ((IOR - 1.0) / (IOR + 1.0)) * ((IOR - 1.0) / (IOR + 1.0));
    vec3 fresnelReflectance = fresnelSchlick(cosTheta, F0);

    // Apply the Fresnel effect to the light color
    vec3 resultColor = lightColor * fresnelReflectance;

    return resultColor;
}



float4 CalculateInterferenceColor(float3 viewDir, float3 normal, float filmThickness, float refractiveIndex)
{
    float3 resultColor = 0.0;
    float incidentAngle = dot(-viewDir, normal); // Assuming viewDir is pointing towards the surface
    float refractedAngle = asin(sin(incidentAngle) / refractiveIndex);

    // Loop over the visible spectrum
    for (float lambda = 380.0; lambda <= 780.0; lambda += 5.0)
    {
        float k = 2 * PI / lambda; // Wave number
        float phaseShift = PI; // Phase shift for reflection from a denser medium

        // Calculate path difference
        float pathDifference = 2.0 * refractiveIndex * filmThickness * cos(refractedAngle) + phaseShift;

        // Interference pattern
        float interference = 0.5 * (1.0 + cos(pathDifference * k));

        // Convert wavelength to RGB and accumulate
        float3 color = WavelengthToRGB(lambda);
        resultColor += color * interference;
    }

    // Normalize the result
    resultColor /= (780.0 - 380.0) / 5.0;

    return float4(resultColor, 1.0);
}




float3 ThinFilmInterference
    (
    float3 normal, float3 viewDirection,
float refractionIndexOil, float refractionIndexWater, float3 lightDirection, int numLayers)
{
    float3 color = float3(0, 0, 0);
    float thickness = 400.0; // Thickness of the oil film in nanometers
    float3 incidentLight = -lightDirection; // Light incident on the surface

    for (int i = 0; i < numLayers; ++i)
    {
        // Calculate reflection and refraction at each layer
        float cosTheta = dot(normal, incidentLight);
        float3 reflectance = FresnelSchlick(cosTheta, float3(0.4, 0.04, 0.4)); // Assume F0 for oil

        // Refract light through the layer
        float3 refractedLight = refract(incidentLight, normal, refractionIndexOil / refractionIndexWater);
        float cosPhi = dot(normal, refractedLight);

        // Calculate phase shift due to the path difference
        float phaseShift = 2.0 * 3.14159 * (thickness / 1000.0) * (refractionIndexOil - refractionIndexWater) * cosPhi;
        float3 interferenceColor = 0.5 * (1.0 + cos(phaseShift)) * reflectance; // Simple model for interference
        
        color += interferenceColor;
        thickness *= 0.5; // Reduce thickness for the next layer
    }

    return color / float(numLayers); // Average the color contribution from each layer
}


DisperseColor CalculateChromaticAberration(float3 incidentRay, float3 normal, float3 viewDirection, float3 position, MaterialProperties material, float3 diffuse)
{
    DisperseColor ret;
    ret.incidentRay = normalize(incidentRay);
    normal = normalize(normal);
    
    float3 dispersedRGB = float3(0.0, 0.0, 0.0);
    ret.color[0] = material.baseColor;
    ret.color[1] = material.baseColor;
    ret.color[2] = material.baseColor;
    ret.refractedAngle[0] = 0;
    ret.refractedAngle[1] = 0;
    ret.refractedAngle[2] = 0;
    ret.refractedRay[0] = vec3(0, 0, 0);
    ret.refractedRay[1] = vec3(0, 0, 0);
    ret.refractedRay[2] = vec3(0, 0, 0);
    ret.incidentAngle = CalculateIncidentAngle(incidentRay, normal);
    ret.incidentRay = incidentRay;
    float3 count = float3(0, 0, 0);
    
    float samples[MAX_SAMPLES];
    int sampleCount = 0;
    float diffuseWave = RGBToWavelength(diffuse);
    ret.color[0] = float3(0, 0, 0);
    sampleCount = MAX_SAMPLES;
    
    [unroll(MAX_SAMPLES)]
    for (float lambda = SPECTRUM_START; lambda <= SPECTRUM_END; lambda += DELTA_LAMBDA)
    {
        float refractiveIndex = CalculateRefractiveIndexUsingSellmeier(material, lambda); // Convert nm 
        float3 refractedRay = RefractRay(incidentRay, normal, refractiveIndex);
        float intensity = CalculateIntensity(material, lambda, dot(incidentRay, normal));
        float dispersionEffect = 1 - refractiveIndex;
        float3 reflection = clamp(CalculateFresnelReflection(incidentRay, normal, refractiveIndex, 1.0), 0, 1);
        float adjustedIntensity = intensity * dispersionEffect;
        
        float3 interferenceColor = CalculateInterferenceColor(viewDirection, normal, PerlinNoise(float3(config.uv, config.grad.depth)), refractiveIndex);

        
        float3 spectralIntensities = float3(0.0, 0.0, 0.0);
        // Assuming air to material transition with air's refractive index approximated to 1
        float theta_i = acos(dot(normalize(incidentRay), normalize(normal))); // Angle of incidence
        float sinTheta_t = sin(CalculateIncidentAngle(incidentRay, normal)) / refractiveIndex; // Snell's law for sin(theta_t)
        float theta_t = asin(sinTheta_t); // Refraction angle

        // Simulate intensity variation due to chromatic aberration
        // This could be further refined with a physical model or empirical data
        float deltaTheta = (theta_t - theta_i); // Difference in angles as a simple measure of dispersion
        
        samples[(lambda - SPECTRUM_START) / DELTA_LAMBDA] = clamp(deltaTheta, 0, 1) > 0 ? .1 : 0;
        
        samples[RGBToWavelengthIndex(interferenceColor)] = 1;
        
        samples[RGBToWavelengthIndex(lambda * adjustedIntensity)] = 1;
        
        samples[RGBToWavelengthIndex(calculateChromaticDispersionFresnel(normal, -config.viewDir, refractiveIndex, diffuse))] = 1;
        
        samples[RGBToWavelengthIndex(diffuseWave)] = 1;
        
        
        /*float3 reflection = material.baseColor * clamp(CalculateFresnelReflection(refractedRay, normal, refractiveIndex, 1.0), 0.1, 1);
        dispersedRGB += reflection;*/

        
        float3 d = dispersedRGB;
        dispersedRGB = (1.0 - deltaTheta); // Simplified model: intensity decreases as angle difference increases
        
        
        
        float3 wavelengthColor = WavelengthToRGB(lambda); // Convert wavelength to RGB
        
        // Calculate Fresnel effect based on the wavelength
        float cosTheta = dot(normalize(-config.viewDir), normalize(normal));
        float fresnelEffect = pow(1.0 - cosTheta, FresnelPower) * deltaTheta * (780.0f - lambda) / (780.0f - 380.0f);
        
        // Adjust color intensity based on the angle and dispersion
        float glowIntensity = cosTime01(timr) * fresnelEffect;
        // Add the calculated color to the result
        //ret.color[1] += wavelengthColor * glowIntensity;
            
        
        float refractIntensity = max(0.0, dot(normalize(refractedRay), -normal));
        //ret.color[1] += wavelengthColor * refractIntensity;
        
        
        
        float filmThickness = 180;
        float wavelength = lambda;
        
        float interference = sin(2.0 * PI * filmThickness / wavelength + dot(config.viewDir, position));
        //ret.color[1] += wavelengthColor * interference;
        
         //CalculateIntensityRK4((1-deltaTheta), theta_i, 5e-9, 10);
        
        count.r += dispersedRGB.r > 0.001 ? 1 : 0;
        count.g += dispersedRGB.g > 0.001 ? 1 : 0;
        count.b += dispersedRGB.b > 0.001 ? 1 : 0;
        
        dispersedRGB += d;
        
        
    }

    ret.incidentAngle = CalculateIncidentAngle(incidentRay, normal);
    ret.color[0] = dispersedRGB / count;
    ret.color[2] = vec3(1, 1, 1);
    
    
    ret.color[0] = clamp(spectral_to_rgb(samples, sampleCount, 0), 0, 1);
    
    return ret;
}



// Assume a CalculateColor function that maps wavelength to RGB color exists



struct PolarizedDispersion
{
    Polarization polarization;
    DisperseColor dispersion;
};


// A function that calculates the fresnel factor based on the incident angle and the refractive indices of the two media
float fresnel(float cosTheta, float n1, float n2)
{
    // Calculate the sine of the transmitted angle using Snell's law
    float sinThetaT = n1 / n2 * sqrt(1.0 - cosTheta * cosTheta);

    // Check for total internal reflection
    if (sinThetaT >= 1.0)
    {
        return 1.0; // no transmission, only reflection
    }

    // Calculate the cosine of the transmitted angle
    float cosThetaT = sqrt(1.0 - sinThetaT * sinThetaT);

    // Calculate the parallel and perpendicular reflection coefficients
    float rPar = (n2 * cosTheta - n1 * cosThetaT) / (n2 * cosTheta + n1 * cosThetaT);
    float rPer = (n1 * cosTheta - n2 * cosThetaT) / (n1 * cosTheta + n2 * cosThetaT);

    // Calculate the fresnel factor using the average of the squares of the reflection coefficients
    return 0.5 * (rPar * rPar + rPer * rPer);
}

// A function that simulates a simple lighting system using fresnel
void lightingSystem()
{
    // Define some parameters for the lighting system
    float n1 = 1.0; // refractive index of air
    float n2 = 1.5; // refractive index of glass
    float lightIntensity = 10.0; // intensity of the light source
    float lightDistance = 5.0; // distance of the light source from the glass surface
    float lightAngle = 45.0; // angle of the light source from the normal of the glass surface
    float glassThickness = 0.1; // thickness of the glass
    float glassTransmittance = 0.9; // fraction of light that passes through the glass

    // Calculate the cosine of the incident angle
    float cosThetaI = cos(radians(lightAngle));

    // Calculate the fresnel factor for the first interface (air-glass)
    float fresnel1 = fresnel(cosThetaI, n1, n2);

    // Calculate the fraction of light that is reflected and transmitted at the first interface
    float reflected1 = lightIntensity * fresnel1;
    float transmitted1 = lightIntensity * (1.0 - fresnel1);

    // Calculate the distance and angle of the transmitted light inside the glass
    float distanceT = lightDistance / cosThetaI - glassThickness / 2.0;
    float angleT = asin(n1 / n2 * sin(radians(lightAngle)));

    // Calculate the cosine of the transmitted angle
    float cosThetaT = cos(angleT);

    // Calculate the fresnel factor for the second interface (glass-air)
    float fresnel2 = fresnel(cosThetaT, n2, n1);

    // Calculate the fraction of light that is reflected and transmitted at the second interface
    float reflected2 = transmitted1 * fresnel2;
    float transmitted2 = transmitted1 * (1.0 - fresnel2) * glassTransmittance;
    /*
    // Print the results
    printf("Light intensity: %.2f\n", lightIntensity);
    printf("Light distance: %.2f\n", lightDistance);
    printf("Light angle: %.2f\n", lightAngle);
    printf("Fresnel factor at the first interface: %.2f\n", fresnel1);
    printf("Reflected light at the first interface: %.2f\n", reflected1);
    printf("Transmitted light at the first interface: %.2f\n", transmitted1);
    printf("Distance of the transmitted light inside the glass: %.2f\n", distanceT);
    printf("Angle of the transmitted light inside the glass: %.2f\n", angleT);
    printf("Fresnel factor at the second interface: %.2f\n", fresnel2);
    printf("Reflected light at the second interface: %.2f\n", reflected2);
    printf("Transmitted light at the second interface: %.2f\n", transmitted2);
    */
}

float Falloff(float distance, float radius, float exponent)
{
    return pow(1.0 - clamp(distance / radius, 0.0, 1.0), exponent);
}

PolarizedDispersion CalculatePolarizedDispersedColor(float3 incidentRay, float3 normal, MaterialProperties material, float airTransmittance)
{
    PolarizedDispersion ret;
    
    // Normalize incidentRay and normal for accurate dot products
    incidentRay = normalize(incidentRay);
    normal = normalize(normal);
    
    ret.dispersion.incidentRay = incidentRay;
    ret.polarization.hasRefraction[0] = 0;
    ret.polarization.hasRefraction[1] = 0;
    ret.polarization.hasRefraction[2] = 0;
    ret.dispersion.incidentAngle = CalculateIncidentAngle(incidentRay, normal);
    
    // Calculate the refractive index for different wavelengths (red, green, blue)
    float refractiveIndices[3] =
    {
        CalculateRefractiveIndexUsingSellmeier(material, 700e-9), // red
        CalculateRefractiveIndexUsingSellmeier(material, 546.1e-9), // green
        CalculateRefractiveIndexUsingSellmeier(material, 435.8e-9) // blue
    };

    // Initialize disperseColor
  
    for (int i = 0; i < 3; ++i)
    {
        ret.dispersion.color[i] = float3(0.0, 0.0, 0.0);
        ret.dispersion.refractedAngle[i] = CalculateRefractedAngle(incidentRay, normal, 1.0, refractiveIndices[i]);
        ret.dispersion.refractedRay[i] = vec3(0, 0, 0);
        
        if (ret.dispersion.refractedAngle[i] >= epsilon)
        {
            ret.dispersion.refractedRay[i] = RefractRayByAngle(incidentRay, normal, ret.dispersion.refractedAngle[i]);
            
            ret.polarization.hasRefraction[i] = length(ret.dispersion.refractedRay[i]) > 0;
            
            ret.polarization.polarizationEffects[i] = CalculatePolarizationEffects(
                ret.dispersion.incidentAngle, ret.dispersion.refractedAngle[i], airTransmittance, refractiveIndices[i]);
            
            float intensityFactor = abs(dot(incidentRay, ret.dispersion.refractedRay[i]));
            
            ret.polarization.averageTransmittance[i] = 0.5 * (ret.polarization.polarizationEffects[i].transmittanceS + ret.polarization.polarizationEffects[i].transmittanceP);
            
           // ret.dispersion.color[i] = intensityFactor * material.baseColor[i] * ret.polarization.averageTransmittance[i];
            
            ret.polarization.hasRefractionColor[i] = length(ret.dispersion.color[i]) > 0 ? 1 : 0;
        }
        
        
        
        
        float lightAngle = degrees(cos(dot(normal, DirLightDirection)));
        float lightIntensity = DirLightIntensity;
        float lightDistance = 15 + cosTime01(timr) * 1;
        float glassThickness = .1;
        
    // Calculate the cosine of the incident angle
        float cosThetaI = cos(radians(lightAngle));

    // Calculate the fresnel factor for the first interface (air-glass)
        float fresnel1 = fresnel(cosThetaI, 1.0, material.refractiveIndex);

    // Calculate the fraction of light that is reflected and transmitted at the first interface
        float reflected1 = lightIntensity * fresnel1;
        float transmitted1 = lightIntensity * (1.0 - fresnel1);

    // Calculate the distance and angle of the transmitted light inside the glass
        float distanceT = lightDistance / cosThetaI - glassThickness / 2.0;
        float angleT = asin(1.0 / material.refractiveIndex * sin(radians(lightAngle)));

    // Calculate the cosine of the transmitted angle
        float cosThetaT = cos(angleT);

    // Calculate the fresnel factor for the second interface (glass-air)
        float fresnel2 = fresnel(cosThetaT, material.refractiveIndex, 1.0);

    // Calculate the fraction of light that is reflected and transmitted at the second interface
        float reflected2 = transmitted1 * fresnel2;
        float transmitted2 = transmitted1 * fresnel2 * ret.polarization.averageTransmittance[i];
    
        ret.dispersion.color[i] += (mir2D(diffuseMap, reflect(incidentRay, normal).xy)
            * reflected2 * dot(-config.reflectDir, config.viewDir)).rgb;
        
        ret.dispersion.color[i] += (mir2D(diffuseMap, refract(incidentRay, normal, 1.0).xy)
            * reflected1 * dot(-config.reflectDir, config.viewDir)).rgb;
        
        ret.dispersion.color[i] += (transmitted2 * dot(-config.viewDir, config.grad.normal)
            * mir2D(diffuseMap, refract(incidentRay, normal, material.refractiveIndex).xy)).rgb;
            
        ret.dispersion.color[i] += (transmitted1 * dot(config.viewDir, config.grad.normal)
            * mir2D(diffuseMap, reflect(incidentRay, normal).xy)).rgb;
            
        
        
    }

    return ret;
}

// Implement the Cauchy equation for calculating the refractive index based on wavelength

float3 RenderChromaticDispersionEffect(float3 incidentRay, float3 normal, float3 viewDirection, float3 position, MaterialProperties material, float3 diffuse)
{
    // Calculate chromatic dispersion with aberration
    DisperseColor dispersion = CalculateChromaticAberration(incidentRay, normal, viewDirection, position, material, diffuse);
    
    return (dispersion.color[0]);
}


// Function to simulate iceberg-like glass noise
vec3 IcebergGlassNoise(float d, vec3 position)
{
    float layeredNoise = LayeredNoise(position);

    // Define color layers (e.g., shades of blue and white)
    vec3 baseColor = vec3(0.3, 0.5, 0.7); // Deep blue
    vec3 midColor = vec3(0.75, 0.9, 0.8); // Lighter blue
    vec3 topColor = vec3(0.63, 0.6, 8.0); // Near white

    // Interpolate between colors based on noise value
    vec3 color;
    if (layeredNoise < d)
        color = lerp(baseColor, midColor, layeredNoise / 0.33);
    else if (layeredNoise < PerlinNoise(position) * 2.0)
        color = ColorBlendAdvanced(vec4(midColor, 1.0), vec4(topColor, 1.0),
            (layeredNoise - 0.33) / 0.33, vec3(0.0, 0.0, 1.0), vec3(0.0, 0.0, -1.0)).xyz;
    else
        color = lerp(topColor, baseColor, (layeredNoise - 0.66) / 0.34);

    return color;
}

// Noise function for glass impurities
vec3 GlassNoise(vec3 position, GradientModulationConfig config)
{
    // Advanced noise function (Perlin/Simplex noise can be replaced with a more complex noise model)
    return vec3(PerlinNoise(float3(position.xyx) * config.timeFactor),
                PerlinNoise(float3(position.yxy) * config.timeFactor),
                PerlinNoise(float3(position.zyz) * config.timeFactor)); // Example multiplier for noise scale
}



// Function 1: Advanced Stratified Noise Generation
float3 StratifiedNoise(float3 position, float3 frequency, float3 amplitude)
{
    // Stratified noise combines multiple noise layers at different frequencies and amplitudes
    float noiseLayer1 = WorleyNoise(config.grad.modulation * position.xy + position.z, frequency.x) * amplitude.x;
    float noiseLayer2 = WorleyNoise(config.grad.modulation * position.xy + position.z, frequency.y) * amplitude.y;
    float noiseLayer3 = WorleyNoise(config.grad.modulation * position.xy + position.z, frequency.z) * amplitude.z;
    return (noiseLayer1 + noiseLayer2 + noiseLayer3) / 3.0;
}






struct SceneContext
{
    float lightingIntensity; // Normalized value [0, 1], where 1 is the highest intensity
    float cameraViewAngle; // Angle in degrees between the camera's forward direction and a reference direction
};


float CalculateContextFactor(float depthScale, SceneContext sceneContext)
{
    // Example: Adjusting based on lighting intensity and camera angle
    float lightingFactor = sceneContext.lightingIntensity; // Assuming x component represents lighting intensity
    float cameraAngleFactor = sceneContext.cameraViewAngle; // Assuming y component represents camera angle

    // Combine factors (customize these calculations as per scene requirements)
    return (lightingFactor + cameraAngleFactor) * depthScale;
}





vec3 DiffuseLighting(vec3 normal, vec3 lightDir, vec3 lightColor, float fresnel, float lightIntensity)
{
    float diffFactor = clamp(max(0.0, dot(normal, -lightDir)), 0, 1);
    return (1.0 - fresnel) * diffFactor * lightColor * lightIntensity;
}

vec4 CombineLighting(vec4 diffuse, vec4 reflection)
{
    return diffuse + reflection;
}

float GetRandomSpin(int rayIndex)
{
    float seed = float(rayIndex) * 98765.4321;
    float spin = frac(cos(seed) * 95123.4567);
    return spin;
}

float RandomNoise(float2 uv)
{
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
}
float2 RandomNoise2(float2 uv)
{
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return float2(GetRandomSpin(int(uv.x * 1000)), GetRandomSpin(int(uv.y * 1000)));
}

float rand(float2 f)
{
    return RandomNoise(f);
}
float rand(float f)
{
    return rand(float2(f, f));
}

float2 rand2(float2 f)
{
    return RandomNoise2(f);
}
float2 rand2(float f)
{
    return RandomNoise2(float2(f, f));
}

float advancedNoise(vec2 uv, float time)
{
    return RandomNoise(uv * time); // Modified with time for dynamic effect
}

float GradientNoise(float3 position)
{
    float3 i = floor(position);
    float3 f = frac(position);
    f = f * f * (3.0 - 2.0 * f);
    float n = dot(i, float3(1.0, 57.0, 21.0));
    return lerp(lerp(lerp(dot(rand(n + 0.0), f - 0.0),
                           dot(rand(n + 1.0), f - 1.0), f.x),
                       lerp(dot(rand(n + 57.0), f - float3(0, 1, 0)),
                            dot(rand(n + 58.0), f - float3(1, 1, 0)), f.x), f.y),
                lerp(lerp(dot(rand(n + 21.0), f - float3(0, 0, 1)),
                          dot(rand(n + 22.0), f - float3(1, 0, 1)), f.x),
                     lerp(dot(rand(n + 78.0), f - float3(0, 1, 1)),
                          dot(rand(n + 79.0), f - float3(1, 1, 1)), f.x), f.y), f.z);
}


float scaleRange(float value, float minRange, float maxRange)
{
    return minRange + (value * (maxRange - minRange));
}



float ConeDistanceToSphere(vec3 coneTip, vec3 coneDir, float coneAngle, vec3 sphereCenter, float sphereRadius)
{
    vec3 v = sphereCenter - coneTip;
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return max(0.0, h - sphereRadius);
}


bool PointInsideCone(vec3 p, vec3 coneTip, vec3 coneDir, float coneAngle)
{
    vec3 v = p - coneTip;
    float d = dot(v, coneDir);
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
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return p - h * normalize(coneDir);
}





void InitializeBaseLight(
    bool enabled,
    int lightType,
    vec3 position,
    vec3 direction,
    vec3 lightColor,
    float intensity,
    bool castShadows,
    float exponent,
    vec4 fresnelPower,
    vec4 fresnelReflectance,
    float specularIntensity,
    float specularPower,
    float4 phaseFactor,
    float fresnelMix, inout BaseLight light)
{
 
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

    light.SpecularIntensity = specularIntensity;
    light.SpecularPower = specularPower;
    light.PhaseFactor = phaseFactor;
    light.FresnelMix = fresnelMix;

}




// Chromatic aberration function
vec4 chromaticAberration0(Texture2D tex, vec2 uv, vec2 strength, vec4 chromaOffset)
{
    vec4 colorR = mir2D(tex, uv + strength * vec2(chromaOffset.x, chromaOffset.y));
    vec4 colorG = mir2D(tex, uv);
    vec4 colorB = mir2D(tex, uv - strength * vec2(chromaOffset.z, chromaOffset.w));
    return vec4(colorR.r, colorG.g, colorB.b, 1.0);
}

vec4 ChromaticAberration1(vec4 fresnel, float phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + offsets.xyz) * (phase + offsets.xyz), 1.0);

    return clamp014(chroma);
}
vec4 ChromaticAberration2(vec4 fresnel, vec2 phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + offsets.xyz) * vec3(phase.xy + offsets.xy, offsets.z), 1.0);

    return clamp014(chroma);
}
vec4 ChromaticAberration3(vec4 fresnel, vec2 phase, vec2 chromaOffset)
{
    vec2 offsets = chromaOffset;
    vec4 chroma = vec4((fresnel.xyz + vec3(offsets.xy, 1.0)) * vec3(phase.xy + offsets.xy, 1.0), 1.0);

    return clamp014(chroma);
}

vec4 ChromaticAberration4(vec4 fresnel, vec4 phase, vec4 chromaOffset)
{
    vec4 offsets = chromaOffset; // RGB channel offsets
    vec4 chroma = (fresnel + offsets) * (phase + offsets);

    return clamp014(chroma);
}


vec4 FresnelGlow(vec4 objectColor, vec4 fresnelColor, vec4 normal, vec4 viewDir)
{
    // Calculate Fresnel reflection coefficient (R)
    vec4 R = FresnelSchlickN0(fresnelColor, normal, viewDir); // Use the Fresnel equation or approximation

    // Modulate the object color with the Fresnel color
    vec4 glowColor = objectColor * fresnelColor * R;

    return glowColor;
}



vec4 PointLightDiffuse(PointLight pl, float d, vec4 normal, float4 viewDir, vec4 position, float occlusionFactor, float scatteringCoefficient, float4 chromaOffset)
{
    vec2 uv = position.xy;
    float depth = d;

    vec4 lightColor = saturate(vec4(pl.Base.LightColor, 1.0));
    normal = normalize(normal);
    float3 toLight = position.xyz - pl.Base.Position.xyz;
    
    float3 lightDir = normalize(-toLight);
    float distanceToLight = distance(position.xyz, pl.Base.Position.xyz);
    
    float attenuationFactor = clamp(1.0 / (pl.Attenuation.x + pl.Attenuation.y * distanceToLight + pl.Attenuation.z * distanceToLight * distanceToLight), epsilon, (1 - epsilon));

     vec3 reflectDir = normalize(-reflect(-lightDir, normal.xyz));
    float diffFactor2 = clamp(max(0.0, dot(reflectDir, viewDir.xyz)), 0, 1);
    float specFactor = clamp(pow(diffFactor2, pl.Base.SpecularPower), 0, 1);
    
// Basic diffuse calculation
    float diffFactor = max(0.0, dot(normalize(normal.xyz), normalize(-viewDir.xyz)));
    
        // Fresnel calculation
    vec4 fresnel = Fresnel(diffFactor * lightColor, pl.Base.FresnelPower);
    
    float4 f1 = dot(-viewDir, normal) * Schlick(lightColor * dot(-viewDir, normal), fresnel * dot(-viewDir, normal), pl.Base.FresnelPower);


vec4 fresnel2 = diffFactor2 * (1 - Fresnel(diffFactor2 * normalize(lightColor), pl.Base.FresnelReflectance));

    float4 f2 = diffFactor2 * Schlick(diffFactor2 * lightColor, fresnel2, pl.Base.FresnelReflectance);

	// Combine diffuse, Fresnel, and subsurface scattering
    float4 l1 = (float4(saturate(lightColor - occlusionFactor * OcclusionStrength).xyz, 1) * pl.Base.Intensity * attenuationFactor) *
        Falloff(distanceToLight, pl.Radius, pl.Base.Exponent);
    
    float4 l2 = (float4(saturate(lightColor - occlusionFactor * OcclusionStrength).xyz, 1) * pl.Base.SpecularIntensity * attenuationFactor) *
        Falloff(distanceToLight, pl.Radius, pl.Base.Exponent);
  
    float4 chroma = ChromaticAberration4(fresnel, pl.Base.PhaseFactor, chromaOffset);
    float4 chroma2 = ChromaticAberration4(fresnel2, pl.Base.PhaseFactor, chromaOffset);
    float4 phaseVal = FresnelGlow(PhaseFunction(float4(normalize(normal.xyz), 1.0),
            float4(normalize(viewDir.xyz), 1), pl.Base.PhaseFactor), chroma, float4(normalize(normal.xyz), 1.0), float4(normalize(-viewDir.xyz), 1.0));
    float4 ambient = 0.003 * lightColor * pl.Base.Intensity;
    
    float4 r1 = saturate(clamp(
                float4(diffFactor *
                    ((l1.xyz + ambient.xyz) + f1.xyz * (chroma.xyz / ((1.0 - d) * phaseVal.xyz)) / 2), 1), 0, 1));
    float4 r2 = saturate(clamp(float4(specFactor * ((l2.xyz + ambient.xyz) + (f2.xyz * (chroma2.xyz / (1.0 - d) * phaseVal.xyz)) / 2), 1.0), 0, 1));
    
    float4 ret =
            saturate(lerp(r1, r2, 1 - dot(-viewDir, normal)));
    
    return ColorCorrectionDynamic(ret);
}
    
vec4 DirectionalLightDiffuse(vec2 uv, float depth, DirectionalLight dl, vec4 normal, vec4 viewDir, float occlusionFactor, float scatteringCoefficient, vec4 chromaOffset, float2 gradientModulation)
{
    vec4 lightColor = vec4(saturate(dl.Base.LightColor), 1.0);
    vec3 lightDir = normalize(-dl.Base.Direction);

    vec3 reflectDir = normalize(reflect(-lightDir, normal.xyz));
    float diffFactor2 = clamp(dot(reflectDir, viewDir.xyz), 0, 1);
    float specFactor = pow(clamp(diffFactor2, 0, 1), dl.Base.SpecularPower);

    // Basic diffuse calculation
    float diffFactor = clamp(dot(normal.xyz, -viewDir.xyz), 0, 1);

    // Fresnel calculations
    vec4 fresnel = Fresnel(lightColor, dl.Base.FresnelPower);
    vec4 fresnel2 = Fresnel(lightColor, dl.Base.FresnelReflectance);

    float4 f1 = diffFactor * Schlick(lightColor, fresnel, dl.Base.FresnelPower);
    float4 f2 = specFactor * (1 - Schlick(lightColor, fresnel2, dl.Base.FresnelReflectance));

    // Combine diffuse, Fresnel, and subsurface scattering
    float4 l1 = float4(clamp(lightColor * dl.Base.Intensity - occlusionFactor * OcclusionStrength, 0, 1).xyz, 1);
    float4 l2 = float4(clamp(lightColor * dl.Base.SpecularIntensity - occlusionFactor * OcclusionStrength, 0, 1).xyz, 1);

    // Chromatic aberration and phase function (if these affect your shading, integrate them properly)
    float4 chroma = ChromaticAberration4(fresnel, dl.Base.PhaseFactor, chromaOffset);
    float4 chroma2 = ChromaticAberration4(fresnel2, dl.Base.PhaseFactor, chromaOffset);
    float4 phaseVal = PhaseFunction(normal, viewDir, dl.Base.PhaseFactor);
    float4 phaseVal2 = PhaseFunction(float4(reflectDir, 1), viewDir, dl.Base.PhaseFactor);

    float4 ambient = (0.03 * lightColor * dl.Base.Intensity);

    // Final light result with potential Fresnel glow and other effects
    float4 r1 = diffFactor * (l1 * chroma + phaseVal) + ambient; // Integrate chroma, phaseVal or other effects if needed
    float4 r2 = diffFactor2 * (l2 * chroma2 + phaseVal2) + ambient; // Integrate chroma2, phaseVal2 or other effects if needed

    float4 ret = lerp(r1, r2, 1 - diffFactor); // Blend between diffuse and specular based on the angle

    return ColorCorrectionDynamic(ret); // Consider applying gamma correction if needed
}


    // Corrected SpotLightDiffuse function
vec4 SpotLightDiffuse(SpotLight sl, vec3 normal, vec3 position,
    vec3 viewDir, vec3 lightDir, vec3 toLight)
{
    if (!PointInsideCone(position, sl.Base.Position, normalize(sl.Base.Direction), sl.ConeAngle))
        return vec4(0.0, 0.0, 0.0, 0.0);

    vec3 projectedPosition =
        ProjectPointInsideCone(position, sl.Base.Position, normalize(sl.Base.Direction), sl.ConeAngle);
        
    float diffFactor2 = max(0.0, dot(normal, normalize(projectedPosition - position)));
    float distance = length(sl.Base.Position - position);
    float diffFactor = max(0, dot(-viewDir, normal));
    float attenuation = 1.0 / (sl.Attenuation.x + sl.Attenuation.y * distance + sl.Attenuation.z * distance * distance);
    float spotEffect = max(dot(normalize(normal), normalize(sl.Base.Direction)), 0.0);
    float spotFactor = (spotEffect > sl.CutOffAngle) ? pow(spotEffect, sl.Base.Exponent) : 0.08211;
    float coneDistance = ConeDistanceToSphere(sl.Base.Position, sl.Base.Direction, sl.ConeAngle, position, 0.0);
    float coneAttenuation = 1.0 - coneDistance;

        
    vec3 fresnel1 = diffFactor *
        FresnelSchlick2(diffFactor * sl.Base.LightColor.xyz, -viewDir, normal, sl.Base.FresnelPower.xyz);
    
    vec3 fresnel2 = diffFactor2 *
        (1 - FresnelSchlick2(diffFactor2 * sl.Base.LightColor.xyz,
        normalize(reflect(toLight, normal)), normal, sl.Base.FresnelReflectance.xyz));

    return
        saturate(ColorCorrectionDynamic(vec4(
        
        lerp(diffFactor * fresnel1 * saturate(sl.Base.LightColor),
        diffFactor2 * fresnel2 * saturate(sl.Base.LightColor),
        (1 - diffFactor)) * spotFactor * coneAttenuation * sl.Base.Intensity, 1.0)));
}

// Corrected SpotLight function
vec4 CalcSpotLight(SpotLight sl, vec3 normal, vec3 position, vec3 viewDir)
{
    vec3 toLight = sl.Base.Position - position;
    vec3 lightDir = normalize(toLight);
    vec4 diffuse = SpotLightDiffuse(sl, normal, position, viewDir, lightDir, toLight);
    vec3 reflectDir = normalize(reflect(-lightDir, normal));
    vec3 F0 = FresnelSchlick2(sl.Base.LightColor, viewDir, reflectDir, length(sl.Base.FresnelPower));
    float diffFactor2 = max(0.0, dot(reflectDir, viewDir));

    return vec4(diffuse.rgb * clamp(F0 * sl.Base.Intensity * diffFactor2, 0.0, 1.0), 1.0);
}



void CreateSpotLight(vec3 position, vec3 direction, vec3 color,
    float intensity, float exponent, vec4 fresnelPower, vec4 fresnelReflectance,
    vec3 targetPosition, float coneAngle, float coneAngleCutoff, vec3 attenuation, float specularIntensity, float specularPower,
    float4 phaseFactor, float fresnelMix, inout SpotLight light)
{
    // Initialize the base light properties
    BaseLight base;
    InitializeBaseLight(
    true, // Enabled
    2, // LightType (spotlight)
    position, // Position of the light
    direction, // Direction the light is pointing
    color, // LightColor (green)
    intensity, // Intensity
    false, // CastShadows
    exponent, // Exponent
    fresnelPower, // FresnelPower
    fresnelReflectance, // FresnelReflectance
    specularIntensity,
    specularPower,
    phaseFactor,
    fresnelMix, base
);

    // Initialize the spotlight properties
   
    light.Base = base;
    light.TargetPosition = targetPosition; // Radius of the light influence
    light.ConeAngle = coneAngle; // Cone angle for spotlights
    light.CutOffAngle = coneAngleCutoff; // CutOff angle for spotlights
    light.Attenuation = attenuation; // Attenuation coefficients (constant, linear, quadratic)

}


void CreatePointLight(vec3 position, vec3 color,
    float intensity, float exponent, vec4 fresnelPower,
    vec4 fresnelReflectance, float radius, vec3 attenuation, float specularIntensity, float specularPower,
    vec4 phaseFactor, float fresnelMix, inout PointLight light)
{
    // Initialize the base light properties
    BaseLight base;
    InitializeBaseLight(
    true, // Enabled
    0, // LightType (pointlight)
    position, // Position of the light
    vec3(0.0, 0.0, 0.0), // Direction the light is pointing (not used for point lights)
    color, // LightColor (white)
    intensity, // Intensity
    false, // CastShadows
    exponent, // Exponent
    fresnelPower, // FresnelPower
    fresnelReflectance, // FresnelReflectance
    specularIntensity,
    specularPower,
    phaseFactor,
    fresnelMix, base
);

    // Initialize the point light properties

    light.Base = base;
    light.Radius = radius; // Radius of the light influence
    light.Attenuation = attenuation; // Attenuation coefficients (constant, linear, quadratic)

}

void CreateDirectionalLight(vec3 direction,
    vec3 color, float intensity, vec4 fresnelPower, vec4 fresnelReflectance, float specularIntensity, float specularPower,
    vec4 phaseFactor, float fresnelMix, inout BaseLight base, inout DirectionalLight ret)
{
    // Initialize the base light properties
   
    InitializeBaseLight(
    true, // Enabled
    1, // LightType (directionallight)
    vec3(0.0, 0.0, 0.0), // Position of the light (not used for directional lights)
    direction, // Direction the light is pointing
    color, // LightColor (yellow)
    intensity, // Intensity
    true, // CastShadows
    1.0, // Exponent
    fresnelPower, // FresnelPower
    fresnelReflectance, // FresnelReflectance
    specularIntensity,
    specularPower,
    phaseFactor,
    fresnelMix
, base
);

    ret.Base = base;

}

vec2 correctUV(vec3 dir)
{
    return vec2(
        atan2(dir.x - 0.5, dir.z) / (2.0 * 3.14159) + 0.5,
        acos(dir.y - 0.5));
}

vec4 CalcLighting(vec3 pix, vec4 diffuse,
    vec3 viewPos, float dS,
    vec3 viewDir, vec3 N, float occlusionFactor,
    vec3 pixW, vec2 uv, float d, vec4 dc,
    vec4 fresnelPower, vec4 fresnelReflectance, float occlusionStrength,
    vec3 dirLightDirection, vec3 dirLightColor, float dirLightIntensity,
    float fresnelMix, float specularIntensity, float specularPower, float4 phaseFactor, vec4 chromaOffset,
    float scatteringCoefficient,
	float2 gradientModulation, GradientModulationConfig config)
{
    DirectionalLight dirLight;
    BaseLight light;
    light.Enabled = true;
    light.LightType = 1;
    light.Position = vec3(0.0, 0.0, 0.0);
    light.Direction = dirLightDirection;
    light.LightColor = diffuse.xyz;
    light.Intensity = 20;
    light.CastShadows = true;
    light.Exponent = 1;
    light.FresnelPower = fresnelPower;
    light.FresnelReflectance = fresnelReflectance;

    light.SpecularIntensity = specularIntensity;
    light.SpecularPower = specularPower;
    light.PhaseFactor = phaseFactor;
    light.FresnelMix = fresnelMix;
    dirLight.Base = (BaseLight) light;


    // Point Light Creations
    PointLight pointLight;
    CreatePointLight(
        vec3(0.0, 0.0, 3.0), diffuse.xyz,
        1.22, 0.242, fresnelPower, fresnelReflectance, 10.692, vec3(1.0, 0.2, 0.0162), specularIntensity, specularPower, phaseFactor, fresnelMix, pointLight);

    vec3 position = vec3(1.5, 1.8, 1.3);
    vec3 direction = normalize(vec3(-0.02, 0.01, 1.0));
    vec3 color = vec3(0.52, 0.2 * 0.52, 0.52); // White color
    float intensity = 0.2;
    float exponent = 0.74;
   
    float coneAngle = 1.65;
    float coneAngleCutoff = 0.8;
    vec3 attenuation = vec3(0.1, 0.2, 0.0162);

    SpotLight spotLight;
    CreateSpotLight(position, direction, color,
            intensity, exponent, fresnelPower, fresnelReflectance, viewPos + viewDir, coneAngle, coneAngleCutoff, attenuation, specularIntensity, specularPower, phaseFactor, fresnelMix,
    spotLight);


    vec4 diffLight = DirectionalLightDiffuse(uv, d, dirLight, vec4(N, 1.0), vec4(viewDir, 1.0), occlusionFactor, scatteringCoefficient, chromaOffset, gradientModulation);


    vec4 diffPoint = PointLightDiffuse(pointLight, d, vec4(N, 1.0), vec4(viewDir, 1), vec4(pix, 1.0), occlusionFactor, scatteringCoefficient,
                chromaOffset);
    vec4 diffSpot = CalcSpotLight(spotLight, N.xyz, pixW, viewDir);

    vec4 ret = saturate(ColorCorrectionDynamic(diffLight + diffPoint + diffSpot));
    ret /= 3;
    return saturate(float4(0.2, 0.2, 0.2, 1) * (d) * ret); // - occlusionFactor * occlusionStrength;
}


GradientModulationConfig InitializeConfig(float2 oosz,

    float timeFactor,
    float2 uv0, float2 uv,
     float2 ooszd, float2 ooszrt,
    
    float3 sunPos,
    float3 sunDir,

    float3 viewPos,
    
    float3 viewDir,
    float4 diffuse,
    float4 diffuse0,

    vec3 reflectDir0,
    vec3 reflectDir,
    float reflectFactor,
    float diffuseFactor0,
    float diffuseFactor,
    bool flipDepth
)
{

    GradientModulationConfig config;

    ivec2 isz;
    depthMap.GetDimensions(isz.x, isz.y);
    config.isz = isz;

    config.timeFactor = timeFactor;

    config.uv0 = uv0;
    config.uv = uv;
    
    config.oosz = oosz;
    config.ooszd = ooszd;
    config.ooszrt = ooszrt;
    
    config.sunPos = sunPos;
    config.sunDir = sunDir;
    config.viewPos = viewPos;
    
    config.viewDir = viewDir;

    config.diffuse = diffuse;
    config.diffuse0 = diffuse0;
    
    config.reflectDir0 = reflectDir0;
    config.reflectDir = reflectDir;
    config.reflectFactor = reflectFactor;
    config.diffuseFactor0 = diffuseFactor0;
    config.diffuseFactor = diffuseFactor;
    
   
    BaseLight light;
    light.Enabled = true;
    light.LightType = 1;
    light.Position = vec3(0.0, 0.0, 0.0);
    light.Direction = DirLightDirection;
    light.LightColor = diffuse.xyz;
    light.Intensity = 20;
    light.CastShadows = true;
    light.Exponent = 1;
    light.FresnelPower = FresnelPower;
    light.FresnelReflectance = FresnelReflectance;

    light.SpecularIntensity = SpecularIntensity;
    light.SpecularPower = SpecularPower;
    light.PhaseFactor = PHASE_FACTOR;
    light.FresnelMix = FresnelMix;
    
    config.dirLight.Base = (BaseLight) light;
    
    config.grad = GetGradientInfoEx(oosz, depthMap, uv, normalRadius, flipDepth);
    
    AdvancedLight advlight = CreateAdvancedLight(viewPos, DirLightDirection, DirLightIntensity, 0.51, 0.4, true, config.grad.modulation, config.grad.depth);
    
       
    config.light = advlight;
    
    return config;
}

float NoiseFunction(float2 depthGradient, float intensity)
{
    return PerlinNoise(vec3(depthGradient.xy, 1.0)) * intensity;

}



float LightingNoiseAdaptation(float lightingIntensity)
{
    // Logic to adapt noise based on lighting intensity
    // Example: less noise in brighter areas
    return 1.0 - clamp011(lightingIntensity); // Adjust this formula as needed
}



/*
float2 GetGradientHeight(Texture2D depthMap, float2 uv)
{
    float2 sz;
    depthMap.GetDimensions(sz.x, sz.y);
    float2 oosz = 1.0 / sz;
    
    config.grad.gradient = ComputeDetailedHeightGradient(depthMap, oosz, uv);
    return GradientModulationExotic(config.grad.gradient);
}
*/



float4 CalculateOcclusionFactor(vec2 uv, vec2 sz,
    float d, float normalOcclusionFactor, float2 gradientModulation, GradientModulationConfig config)
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
            
            float td = dep2D(uv + offset * oosz * gradientModulation);
            if (td < diffRange)
            {
                ret += weight * (sd - td);
                tot += weight;
            }
        }
    }
    return tot == 0 ? 0 : clamp(ret / tot, epsilon, (1 - epsilon));
}
// HLSL syntax for a Gaussian Bloom effect


// Helper function to calculate Gaussian weight
float Gaussian(float x, float sigma)
{
    return exp(-0.5 * (x * x) / (sigma * sigma)) / (sigma * sqrt(2.0 * 3.14159265));
}

// Gaussian bloom implementation
float4 GaussianBloom(float2 oosz, Texture2D tex, float2 uv, float dist, float threshold, float4 minColor, float power, float sigma)
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
            float2 offset = float2(dx, dy) * dist * oosz;
            float weight = Gaussian(length(offset), sigma);
            blurColor += weight * mir2D(tex, uv + offset);
            totalWeight += weight;
        }
    }
    blurColor /= totalWeight;

    // Dynamic blending based on brightness and threshold
    float brightness = max(max(color.r, color.g), color.b);
    if (brightness > threshold)
    {
        float4 blendedColor = lerp(color, max(minColor, blurColor + float4(brightness, brightness, brightness, 0.0)), power);
        return saturate(blendedColor); // Ensure the result is clamped between 0 and 1
    }

    return saturate(color); // Return the original color if below the threshold
}



// bloom2 function
float4 bloom2(float2 oosz, Texture2D tex, float2 uv, float dist, float threshold, float2 gradientModulation,
    float2 detailedGradient)
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

    return clamp014(color);
}



vec4 RedBlueDepthEffect(vec2 oosz, Texture2D tex, vec2 uv, float depth, vec2 eyeOffset, float4 pix,
    float2 modulation, float2 gradient)
{
    // Calculate left and right eye UV coordinates
    vec2 leftUV = uv - float2(eyeOffset.x * oosz.x, cosTime01(timr) * oosz.y);
    vec2 rightUV = uv + float2(cosTime01(timr) * oosz.x, eyeOffset.y * oosz.y);

    // Sample the scene from the perspective of each eye
    vec4 leftEyeColor = mir2D(tex, leftUV);
    vec4 rightEyeColor = mir2D(tex, rightUV);

    // Apply red tint to the left eye and blue tint to the right eye
    vec4 redTinted = leftEyeColor * vec4(1.0, 0.0, 0.0, 1.0);
    vec4 blueTinted = rightEyeColor * vec4(0.0, 0.0, 1.0, 1.0);

    // Combine the two tinted images
    return clamp014(combine(redTinted, pix, blueTinted));
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

// The enhanced trippy blur effect
vec4 trippyBlur(Texture2D tex, vec2 sz, vec2 uv, float time, float depth, vec3 normal, float2 gradientModulation)
{
    
    vec4 color = mir2D(tex, uv);

    // Apply dynamic color manipulation
    color = dynamicColor(color, depth, time * timr);

    // Applying a complex blur based on noise and depth
    
    vec4 blurredColor = blur3(tex, sz, uv, 5.0 + depth * 5.0, depth * length(color), color + 0.2, gradientModulation);

    return lerp(color, blurredColor, 0.5); // Blend original and blurred colors
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

// Function to apply color distortion
float3 ColorDistortion(float3 color, float2 uv, vec4 scalarColorUVScaleMin, float timeFactor)
{
    // Distort the colors based on UV coordinates and time
    float r = color.r + scalarColorUVScaleMin.x * sin(uv.y * scalarColorUVScaleMin.y + timeFactor / (1 + timr)) * scalarColorUVScaleMin.z + scalarColorUVScaleMin.w;
    float g = color.g + scalarColorUVScaleMin.x * sin(uv.x * scalarColorUVScaleMin.y + timeFactor / (1 + timr)) * scalarColorUVScaleMin.z + scalarColorUVScaleMin.w;
    float b = color.b + scalarColorUVScaleMin.x * cos(uv.y * scalarColorUVScaleMin.y + timeFactor / (1 + timr)) * scalarColorUVScaleMin.z + scalarColorUVScaleMin.w;
    
    // Combine the distorted colors and return
    return (float3(r, g, b));
}

// Pixel Shader
float4 distort(Texture2D tex, float2 uv, float timeFactor)
{
    float4 texColor = mir2D(tex, uv);
    
    // Generate vibrant colors
    float3 vibrantColors = VibrantColorPalette(abs(0.0005 * cos(timeFactor / (1 + timr))), timeFactor);
    
    // Blend texture color with vibrant colors
    float4 blendedColor = lerp(texColor, float4(vibrantColors, 1.0), 0.5);
    
    // Apply color distortion
    float3 distortedColor = ColorDistortion(blendedColor.rgb, uv,
        vec4(cosTime01(timeFactor / (1 + timr)) * .2,
            sinTime01(timeFactor / (1 + timr)) * 2,
            dep2D(uv), .05),
            timeFactor / (1 + timr));
    
    // Output the final color
    return float4(distortedColor, 1.0);
}


float BubblyWorleyNoise(float2 uv)
{
    float d = 1.0;
    uv *= 5.0; // Adjust for bubble size
    [unroll]
    for (int x = -1; x <= 1; x++)
        [unroll]
        for (int y = -1; y <= 1; y++)
        {
            float2 lattice = floor(uv) + float2(x, y);
            float2 offset = RandomNoise(lattice);
            d = min(d, length(uv - lattice - offset));
        }
    return d;
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
    float luminance = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    float3 luminanceVec = float3(luminance, luminance, luminance);
    correctedColor.r = lerp(luminanceVec.r, correctedColor.r, balance.r);
    correctedColor.g = lerp(luminanceVec.g, correctedColor.g, balance.g);
    correctedColor.b = lerp(luminanceVec.b, correctedColor.b, balance.b);
    return float4(correctedColor, color.a);
}

float4 ColorSaturation(float4 color, float saturation)
{
    float luminance = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
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

float4 ColorHighlightShadows(float4 color, float shadows, float highlights)
{
    float3 luminanceVec = float3(0.2126, 0.7152, 0.0722);
    float luminance = dot(color.rgb, luminanceVec);
    float3 correctedColor = color.rgb + (luminance < 0.5 ? shadows : highlights) * (luminanceVec - color.rgb);
    return float4(correctedColor, color.a);
}


float ComputeFresnel(float3 rayDir, float3 normal, float fefractiveIndex)
{
    float cosTheta = dot(-rayDir, normal);
    float r0 = (1.0 - fefractiveIndex) / (1.0 + fefractiveIndex);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow(1.0 - cosTheta, FresnelPower);
}


float4 ApplyDepthBasedDetail(float2 uv, Texture2D<float> depthMap, Texture2D detailMap, float2 detailScale, GradientModulationConfig config)
{
    float depth = dep2D(uv);
    // / ((1 - depth) * detailScale)
    float2 detailUV = (uv / detailScale) * pow(depth, 2);
    float4 detailColor = mir2D(detailMap, detailUV);
    return detailColor;
}

float EdgeDetectDepth(float oosz, float2 uv, Texture2D<float> depthMap, float edgeThreshold)
{
    float centerDepth = dep2D(uv);
    float depthLeft = dep2D(uv + float2(-oosz, 0));
    float depthRight = dep2D(uv + float2(oosz, 0));
    float depthDiff = abs(depthLeft - centerDepth) + abs(depthRight - centerDepth);
    return depthDiff > edgeThreshold ? 1.0 : 0.0;
}
float3 DepthEdgeDetection(float oosz, Texture2D<float> depthTex, float2 uv, float depthThreshold)
{
    float depthCenter = dep2D(depthTex, uv);
    float3 edgeColor = float3(1, 1, 1);
    float3 nonEdgeColor = float3(0, 0, 0);
    float depthDiff;

    // Check surrounding pixels in depth texture
    [unroll]
    for (int x = -1; x <= 1; x++)
    {
        [unroll]
        for (int y = -1; y <= 1; y++)
        {
            if (x != 0 || y != 0)
            { // Skip center pixel
                float2 offset = float2(x, y) * oosz;
                depthDiff = abs(dep2D(depthTex, uv + offset) - depthCenter);
                if (depthDiff > depthThreshold)
                {
                    return edgeColor;
                }
            }
        }
    }
    return nonEdgeColor;
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


GlassMarchResult GlassMarch(Texture2D<float> heightMap, float2 uv, float2 rayDir, float numLayers, MaterialProperties material, bool flipDepth)
{
    float totalDepth = 1 - dep2D(uv);
    float layerDepth = totalDepth / numLayers;
    float currentLayerDepth = totalDepth;

    GlassMarchResult ret;
    ret.color = float3(0, 0, 0);
    ret.normal = float3(0, 0, 0);
    ret.depth = totalDepth;
    ret.traveledDistance = 0;
    ret.dispersionColor[0] = float3(0, 0, 0);
    ret.dispersionColor[1] = float3(0, 0, 0);
    ret.dispersionColor[2] = float3(0, 0, 0);
    vec3 layerRay = (vec3(rayDir, -1));
  
    vec3 incidentRay = normalize(vec3(uv, -1));
    DepthNormal dn;
    
    float3 diffuseCountS = float3(0, 0, 0);
    float3 diffuseCountP = float3(0, 0, 0);
    float3 disperseCount = float3(0, 0, 0);
    
    ret.diffuseS = float3(0, 0, 0);
    ret.diffuseP = float3(0, 0, 0);
   
    int i = 0;
    [unroll(50)]
    for (i = 0; i < numLayers; ++i)
    {
        vec2 offset = (i > 0 ? vec2(0.0, 0.0) : vec2(-0.1, 0)) - vec2(-cosTime01(timr) * 0.01, 0);
        
        incidentRay = vec3(rayDir.xy + offset, -1);
        
        dn = ComputeUltimateDepthGradientAndNormal(config.oosz, heightMap, uv, 34, flipDepth);
    
        ret.normal = dn.normal;
        ret.depth = 1 - dn.depth;
        vec3 noiseVec = vec3(-(i / 5), -1, 2) * PerlinNoise(vec3(uv + rayDir, cosTime01(timr)));
        
        float v = CalculateIncidentAngle(normalize(incidentRay), normalize(ret.normal + noiseVec));
        if (v != -1)
        {
            PolarizedDispersion dc = CalculatePolarizedDispersedColor(normalize(incidentRay), normalize(ret.normal + noiseVec), material, material.refractiveIndex);
            if (dc.polarization.hasRefraction[0] == 1)
            {
                vec3 ray = vec3(0, 0, 0);
                int rayCount = 0;
                if (dc.polarization.hasRefractionColor[0] == 1)
                {
                    ret.dispersionColor[0] += dc.dispersion.color[0];
                    ray += dc.dispersion.refractedRay[0];
                    disperseCount[0]++;
                    rayCount++;
                    if (dc.polarization.polarizationEffects[0].transmittanceS > 0)
                    {
                        ret.diffuseS.r += dc.polarization.polarizationEffects[0].transmittanceS;
                        diffuseCountS[0]++;
                    }
                    if (dc.polarization.polarizationEffects[0].transmittanceP > 0)
                    {
                        ret.diffuseP.r += dc.polarization.polarizationEffects[0].transmittanceP;
                        diffuseCountP[0]++;
                    }
                }
                if (dc.polarization.hasRefractionColor[1] == 1)
                {
                    ray += dc.dispersion.refractedRay[1];
                    ret.dispersionColor[1] += dc.dispersion.color[1];
                    
                    disperseCount[1]++;
                    rayCount++;
                    if (dc.polarization.polarizationEffects[1].transmittanceS > 0)
                    {
                        ret.diffuseS += dc.polarization.polarizationEffects[1].transmittanceS;
                        diffuseCountS[1]++;
                    }
                    if (dc.polarization.polarizationEffects[1].transmittanceP > 0)
                    {
                        ret.diffuseP += dc.polarization.polarizationEffects[1].transmittanceP;
                        diffuseCountP[1]++;
                    }
                }
                if (dc.polarization.hasRefractionColor[2] == 1)
                {
                    ray += dc.dispersion.refractedRay[2];
                    ret.dispersionColor[2] += dc.dispersion.color[2];
                    disperseCount[2]++;
                    rayCount++;
                    if (dc.polarization.polarizationEffects[2].transmittanceS > 0)
                    {
                        ret.diffuseS += dc.polarization.polarizationEffects[2].transmittanceS;
                        diffuseCountS[2]++;
                    }
                    if (dc.polarization.polarizationEffects[2].transmittanceP > 0)
                    {
                        ret.diffuseS += dc.polarization.polarizationEffects[2].transmittanceP;
                        diffuseCountS[2]++;
                    }
                }
                if (rayCount > 0)
                {
                    incidentRay = normalize(ray / rayCount);
                }
       
            }
         
        }
        
        uv += lerp(rayDir, incidentRay.xy, .5);
        rayDir = lerp(rayDir, incidentRay.xy, .5);
        ret.traveledDistance += length(vec3(rayDir, -layerDepth));
        
        if (ret.depth < currentLayerDepth)
        {
            break;
        }
       
    }
    
    if (diffuseCountS[0] > 1)
    {
        ret.diffuseS[0] /= diffuseCountS[0];
    }
    if (diffuseCountS[1] > 1)
    {
        ret.diffuseS[1] /= diffuseCountS[1];
    }
    if (diffuseCountS[2] > 1)
    {
        ret.diffuseS[2] /= diffuseCountS[2];
    }
    if (diffuseCountP[0] > 1)
    {
        ret.diffuseP[0] /= diffuseCountP[0];
    }
    if (diffuseCountP[1] > 1)
    {
        ret.diffuseP[1] /= diffuseCountP[1];
    }
    if (diffuseCountP[2] > 1)
    {
        ret.diffuseP[2] /= diffuseCountP[2];
    }
    
    int totalDispersionCount = 0;
    vec3 totalDispersionColor = vec3(0, 0, 0);
    
    if (disperseCount[0] > 0)
    {
        ret.dispersionColor[0] /= disperseCount[0];
        totalDispersionCount++;
        totalDispersionColor += ret.dispersionColor[0];

    }
    if (disperseCount[1] > 0)
    {
        ret.dispersionColor[1] /= disperseCount[1];
        totalDispersionCount++;
        totalDispersionColor += ret.dispersionColor[1];
    }
    if (disperseCount[2] > 0)
    {
        ret.dispersionColor[2] /= disperseCount[2];
        totalDispersionCount++;
        totalDispersionColor += ret.dispersionColor[2];
    }
    
    if (totalDispersionCount > 1)
    {
        totalDispersionColor /= totalDispersionColor;
    }
    
    ret.color = totalDispersionColor;
    ret.uv = uv;
    return ret;
}

struct ParallaxResult
{
    float2 uv;
    float3 diffuse;
    float3 diffuseCount;
};
void InitializeParallaxResult(inout ParallaxResult ret)
{
    ret.uv = vec2(0, 0);
    ret.diffuse = float3(0, 0, 0);
    ret.diffuseCount = vec3(0, 0, 0);

}

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


float2 UpdateOffset(float2 uv, float2 offset)
{
    // Ensuring offset does not lead to invalid texture coordinates
    float2 updatedOffset = GetView(offset, uv) + offset;
    return clamp(updatedOffset, -1.0, 1.0);
}


struct ParallaxLayerRefineResult
{
    int isValid;
    float2 uvOffset;
    float depth;
};
void InitializeParallaxLayerRefineResult(inout ParallaxLayerRefineResult ret)
{
    ret.uvOffset = vec2(0, 0);
    ret.depth = 0;
    ret.isValid = 0;
}


vec2 SafeNormalize(vec2 v)
{
    float len = length(v);
    return len > 0.0 ? v / len : vec2(0.0, 0.0);
}
// Parallax Occlusion Layer Information
struct ParallaxLayer
{
    float2 uvStart;
    float2 uvEnd;
    float depth;
};



// Definitions
#define MAX_LAYERS 10




// Define the distance field texture
Texture2D<float> DistanceField;

// Define the detail map texture
Texture2D<float4> DetailMap;

// Define the sampler states
SamplerState LinearSampler;
SamplerState PointSampler;

// Define the input structure
struct VSInput
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

// Define the output structure
struct PSInput
{
    float4 Position : SV_POSITION;
    float2 TexCoord : TEXCOORD0;
    float3 ViewDir : TEXCOORD1;
};

// Define the constants
#define MAX_STEPS 32 // Maximum number of ray tracing steps
#define MIN_DEPTH 0.01 // Minimum depth for early ray termination
#define MAX_DEPTH 0.1 // Maximum depth for ray tracing
#define SIGMOID_A 10.0 // Sigmoid function parameter
#define SIGMOID_B 0.5 // Sigmoid function parameter
#define FRESNEL_F0 0.04 // Fresnel term parameter
#define DETAIL_SCALE 10.0 // Detail map scale factor

#define DistanceFieldWidth 1
#define DistanceFieldHeight 1

// Define the pixel shader
float4 parallaxPS(PSInput input) : SV_TARGET
{
    // Initialize the ray origin and direction
    float2 rayOrigin = input.TexCoord;
    float2 rayDir = input.ViewDir.xy / input.ViewDir.z;

    // Initialize the ray depth and step
    float rayDepth = 0.0;
    int rayStep = 0;

    // Initialize the ray hit and normal
    bool rayHit = false;
    float2 rayNormal = float2(0.0, 0.0);

    // Ray tracing loop
    while (rayStep < MAX_STEPS && rayDepth < MAX_DEPTH)
    {
        // Sample the distance field at the current ray position
        float distance = DistanceField.SampleLevel(PointSampler, rayOrigin, 0);

        // Apply the sigmoid function to smooth the distance field
        distance = 1.0 / (1.0 + exp(-SIGMOID_A * (distance - SIGMOID_B)));

        // Update the ray depth and position
        rayDepth += distance;
        rayOrigin += rayDir * distance;

        // Check the depth buffer to avoid artifacts
        float depthBuffer = dep2D(depthMap, rayOrigin);
        if (rayDepth > depthBuffer - MIN_DEPTH)
        {
            // Ray hit the surface
            rayHit = true;

            // Compute the surface normal by sampling the distance field gradient
            float2 dx = float2(1.0 / DistanceFieldWidth, 0.0);
            float2 dy = float2(0.0, 1.0 / DistanceFieldHeight);
            rayNormal = normalize(float2(
                DistanceField.SampleLevel(PointSampler, rayOrigin + dx, 0) - DistanceField.SampleLevel(PointSampler, rayOrigin - dx, 0),
                DistanceField.SampleLevel(PointSampler, rayOrigin + dy, 0) - DistanceField.SampleLevel(PointSampler, rayOrigin - dy, 0)
            ));

            // Break the loop
            break;
        }

        // Increment the ray step
        rayStep++;
    }

    // Initialize the output color
    float4 color = float4(0.0, 0.0, 0.0, 0.0);

    // If the ray hit the surface
    if (rayHit)
    {
        // Compute the view angle
        float viewAngle = dot(rayNormal, -rayDir);

        // Compute the fresnel term
        float fresnel = FRESNEL_F0 + (1.0 - FRESNEL_F0) * pow(1.0 - viewAngle, FresnelPower);

        // Modulate the parallax occlusion amount by the fresnel term
        rayDepth *= fresnel;

        // Sample the detail map at the ray hit position
        float4 detail = mir2D(diffuseMap, rayOrigin * DETAIL_SCALE);

        // Apply the detail map to the output color
        color = detail;

        // Blend the output color with the underlying geometry color
        float4 geometryColor = dep2D(rayOrigin);
        color = lerp(geometryColor, color, saturate(rayDepth / MAX_DEPTH));
    }

    // Return the output color
    return color;
}





float3 FresnelEffect
    (
    float3 normal, float3 viewDir,
    Texture2D<float> depthMap, float2 uv, float fresnelPower)
{
    float depth = dep2D(uv);
    float fresnel = pow(1.0 - dot(normal, viewDir), fresnelPower);
    return float3(fresnel, fresnel, fresnel) * depth;
}


float4 DepthDependentBlur
    (
    float2 uv,
    Texture2D<float> depthMap, Texture2D colorMap, float focusDepth, float blurAmount, float2 depthScalar)
{
    float depth = dep2D(uv);
    float2 blurUV = uv + (depth - focusDepth) / depthScalar * blurAmount;
    return mir2D(colorMap, blurUV);
}


float3 DepthBasedSpecular
    (
    float3 normal, float3 lightDir, float3 viewDir,
    Texture2D<float> depthMap, float2 uv, float shininess)
{
    float depth = dep2D(uv);
    float3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), shininess);
    return float3(spec, spec, spec) * depth;
}

vec4 FresnelEffect
    (vec4 diffuse, vec4 cosTheta, int effectIndex)
{
    vec4 ret = diffuse;
    
    switch (effectIndex)
    {
        case 0:
            ret = float4(clamp(saturate(ret).xyz, 0.3, 0.8), 1) + Fresnel(ret * cosTheta, -8);
            break;
       
        default:
            ret = float4(clamp(saturate(ret).xyz, 0.3, 0.8), 1) + Fresnel(ret * cosTheta, -1);
            break;
    }
    
    return ret;
}


// Function 3: Dynamic Fresnel Effect
float DynamicFresnel
    (
    float3 rayDirection, float3 normal, float indexRefraction, float fresnelBias, float fresnelScale, float fresnelPower)
{
    // Calculates a dynamic Fresnel effect based on view direction and surface normal
    float bias = fresnelBias;
    float scale = fresnelScale;
    float power = fresnelPower;
    float fresnel = bias + scale * pow(1 + dot(rayDirection, normal), power);
    return clamp(fresnel / (indexRefraction + fresnel), 0, 1);
}

// Function 4: Procedural Ripple Pattern
float3 RipplePattern
    (
    float2 uv, float time, float frequency, float amplitude)
{
    // Generates a procedural ripple pattern based on time
    float2 rippleCenter = 0.5;
    float distanceFromCenter = length(uv - rippleCenter);
    float ripple = sin(distanceFromCenter * frequency + time) * amplitude;
    return float3(ripple, ripple, ripple);
}


float AnisotropicSpecularTL
    (
    float3 lightDir, float3 viewDir, float3 tangent, float roughness, float anisotropy)
{
    float3 halfDir = normalize(lightDir + viewDir);
    float3x3 TBN = float3x3(tangent, cross(tangent, halfDir), halfDir);
    float3 dirInTBN = mul(TBN, lightDir);
    float aspect = sqrt(1 - anisotropy * 0.9);
    float2 alpha = float2(roughness / aspect, roughness * aspect);
    float2 p = dirInTBN.xy / (alpha * alpha);
    return exp(-dot(p, p)) / (4 * PI * dot(alpha, alpha) * sqrt(dot(lightDir, halfDir)));
}

float AnisotropicSpecularNL
    (
    float3 normal, float3 viewDir, float3 lightDir, float roughness, float anisotropy)
{
    // Computes the specular highlight for anisotropic materials
    float3 halfDir = normalize(lightDir + viewDir);
    float3x3 rotationMatrix = float3x3(
        cos(anisotropy), 0, sin(anisotropy),
        0, 1, 0,
        -sin(anisotropy), 0, cos(anisotropy)
    );
    float3 rotatedNormal = mul(rotationMatrix, normal);
    float specAngle = max(dot(rotatedNormal, halfDir), 0);
    return pow(specAngle, roughness);
}

float AnisotropicSpecular
    (
    float3 normal, float3 viewDir, float3 lightDir, float3 tangent, float roughness, float anisotropy)
{
    float3x3 rotationMatrix = float3x3(tangent, cross(normal, tangent), normal);
    float3x3 invRotationMatrix = transpose(rotationMatrix);
    float3 alignedViewDir = mul(invRotationMatrix, viewDir);
    float3 alignedLightDir = mul(invRotationMatrix, lightDir);

    float2 anisotropicRoughness = float2(roughness, roughness * (1.0 - anisotropy));
    float3 halfDir = normalize(alignedViewDir + alignedLightDir);
    float dotNH = saturate(dot(halfDir, float3(0, 0, 1)));
    float aspect = sqrt(1.0 - anisotropy * 0.9);
    float2 roughness2 = anisotropicRoughness * anisotropicRoughness;
    float NdotH = halfDir.z;
    float NdotV = alignedViewDir.z;
    float NdotL = alignedLightDir.z;
    float VdotH = saturate(dot(alignedViewDir, halfDir));
    float distribution = exp((NdotH * NdotH - 1.0) / (roughness2.x * NdotH * NdotH)) / (3.14159 * roughness2.x * NdotH * NdotH * NdotH * NdotH);
    distribution *= exp((dot(halfDir.xy / aspect, halfDir.xy / aspect) - 1.0) / (roughness2.y * dot(halfDir.xy, halfDir.xy))) / (3.14159 * roughness2.y * dot(halfDir.xy, halfDir.xy) * dot(halfDir.xy, halfDir.xy));
    float geometricAttenuation = min(1.0, min(2.0 * NdotH * NdotV / VdotH, 2.0 * NdotH * NdotL / VdotH));
    return distribution * geometricAttenuation / (4.0 * NdotV * NdotL);
}


float3 ComplexFresnel
    (
    float cosTheta, float3 eta, float3 k)
{
    float cosTheta2 = cosTheta * cosTheta;
    float sinTheta2 = 1.0 - cosTheta2;
    float3 eta2 = eta * eta;
    float3 k2 = k * k;

    float3 t0 = eta2 - k2 - sinTheta2;
    float3 a2plusb2 = sqrt(t0 * t0 + 4.0 * eta2 * k2);
    float3 t1 = a2plusb2 + cosTheta2;
    float3 a = sqrt(0.5 * (a2plusb2 + t0));
    float3 t2 = 2.0 * cosTheta * a;
    float3 Rs = (t1 - t2) / (t1 + t2);

    float3 t3 = cosTheta2 * a2plusb2 + sinTheta2 * sinTheta2;
    float3 t4 = t2 * sinTheta2;
    float3 Rp = Rs * (t3 - t4) / (t3 + t4);

    return 0.5 * (Rp + Rs);
}
float3 ScreenSpaceReflection
    (
    float3 position, float3 normal, float3 viewDir, Texture2D sceneTex, SamplerState sceneSampler)
{
    float3 reflectDir = reflect(-viewDir, normal);
    float2 screenPos = float2(dot(reflectDir, float3(1, 0, 0)), dot(reflectDir, float3(0, 1, 0))) / dot(reflectDir, float3(0, 0, 1)) * 0.5 + 0.5;
    return mir2D(sceneTex, screenPos).rgb;
}

float4 ScreenSpaceReflection
    (
    float2 uv, float3 viewDir, Texture2D sceneMap,
    Texture2D<float> depthMap)
{
    float depth = dep2D(uv);
    float3 reflection = viewDir - 2.0 * dot(viewDir, float3(0, 0, 1)) * float3(0, 0, 1);
    float2 reflectedUV = uv;
    float3 color = float3(0, 0, 0);
    for (int i = 0; i < 10; i++)
    {
        reflectedUV += reflection.xy * 0.01;
        float sampleDepth = dep2D(reflectedUV);
        if (sampleDepth < depth)
        {
            color = mir2D(sceneMap, reflectedUV).rgb;
            break;
        }
    }
    return float4(color, 1.0);
}


float3 SubsurfaceScattering
    (
    float2 oosz, float2 uv, Texture2D sceneMap,
    Texture2D<float> depthMap)
{
    float depth = dep2D(uv);
    float3 baseColor = mir2D(sceneMap, uv).rgb;
    float3 blurColor = float3(0, 0, 0);
    for (int x = -2; x <= 2; x++)
    {
        for (int y = -2; y <= 2; y++)
        {
            float2 offsetUV = uv + float2(x, y) * 2 * oosz;
            float sampleDepth = dep2D(offsetUV);
            float falloff = max(0.0, 1.0 - (depth - sampleDepth) * 10.0);
            blurColor += falloff * mir2D(sceneMap, offsetUV).rgb;
        }
    }
    blurColor /= 25.0;
    return lerp(baseColor, blurColor, 0.3); // Mix the base color with the blurred color
}



//const float RefractionIndexOil = 1.48; // Refractive index for oil
//const float RefractionIndexWater = 1.33; // Refractive index for water (base)
//const float3 LightDirection = normalize(float3(0.3, 0.7, -1.0)); // Directional light
//const int NumLayers = 5; // Number of thin film interference layers




//float IridescenceStrength = 0.5
//float3 OilColor = float3(0.8, 0.8, 0.9);
float3 ComputeIridescence
    (
    float3 normal, float3 viewDir, float iridescenceStrength, float3 oilColor)
{
    float angle = dot(normal, viewDir);
    float shift = (1.0 - angle) * iridescenceStrength;
    return lerp(oilColor, oilColor * (0.5 + 0.5 * cos(shift * 6.28318)), shift);
}


float3 ComplexFresnel
    (
    float3 incident, float3 normal, float eta)
{
    float cosi = saturate(dot(-incident, normal));
    float3 reflect1 = reflect(incident, normal);
    float3 refract1 = refract(incident, normal, eta);
    float reflectance = pow((1.0 - cosi), FresnelPower);
    return reflectance * reflect1 + (1 - reflectance) * refract1;
}
float4 DepthBasedColorCorrection
    (
    float2 uv,
    Texture2D<float> depthMap, Texture2D colorMap, float3 correctionFactor)
{
    float depth = dep2D(uv);
    float4 color = mir2D(colorMap, uv);
    return float4(color.rgb * (depth) * correctionFactor, color.a);
}

float4 DepthAwareTexturing
    (
    Texture2D diffuseMap,
    Texture2D<float> depthMap, float2 uv, float depthScale)
{
    float depth = dep2D(uv);
    float depthFactor = 1.0 / (depth);
    
    return mir2D(diffuseMap, uv); //*ApplyDepthBasedDetail(uv, depthMap, diffuseMap, DepthScale); // Modulate color based on depth
}



float3 ChromaticDispersion
    (
    float3 rayDir, float3 prismNormal, float eta)
{
    float3 refractedRay = refract(rayDir, prismNormal, eta);
    return float3(refractedRay.x, refractedRay.y, rayDir.z); // Separate R, G, B channels
}


float FractalBrownianMotion
    (
    float3 pos, int octaves, float lacunarity, float gain)
{
    float amplitude = 1.0, frequency = 1.0, sum = 0.0;
    for (int i = 0; i < octaves; i++)
    {
        sum += amplitude * PerlinNoise(pos * frequency);
        amplitude *= gain;
        frequency *= lacunarity;
    }
    return sum;
}

float3 RayleighScattering
    (
    float3 rayDir, float3 sunDir, float atmosphereDensity)
{
    return atmosphereDensity * pow(dot(rayDir, sunDir), 2.0);
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

float RadicalInverse
    (
    uint x)
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
float2 Hammersley
    (
    uint i, uint n)
{
    return float2(float(i) / float(n), RadicalInverse(i));
}
    
float3 BokehDOF
    (
    float2 uv,
    Texture2D<float> depthTex, Texture2D sceneTex, float focusDepth, float bokehRadius, float2 gradientModulation)
{
    float depth = dep2D(depthTex, uv);
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

float3 SubsurfaceScattering
    (
    float3 position, float3 lightDir, float scatterStrength)
{
    float3 scatterColor = float3(0.8, 0.7, 0.6); // Customize as needed
    float s = dot(normalize(position), lightDir);
    float scatter = exp(-scatterStrength * (1.0 - s));
    return lerp(float3(1, 1, 1), scatterColor, scatter);
}




float MicrofacetSpecular
    (
    float3 lightDir, float3 viewDir, float3 normal, float roughness)
{
    float3 halfDir = normalize(lightDir + viewDir);
    float D = roughness / (PI * pow(dot(normal, halfDir), 2) * pow(roughness + (1 - roughness) * pow(dot(normal, halfDir), 2), 2));
    float G = min(1.0, min(2 * dot(normal, halfDir) * dot(normal, viewDir) / dot(viewDir, halfDir), 2 * dot(normal, halfDir) * dot(normal, lightDir) / dot(viewDir, halfDir)));
    return D * G / max(4 * dot(normal, lightDir) * dot(normal, viewDir), 0.001);
}


float3 AdvancedFresnel
    (
    float3 viewDir, float3 normal, float3 lightDir, float bias, float scale, float power)
{
    float fresnel = pow(1.0 - max(dot(viewDir, normal), 0.0), power);
    fresnel = saturate(bias + scale * fresnel); // Ensuring the value stays within range
    float3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(reflectDir, viewDir), 0.0), power);
    return lerp(float3(bias, bias, bias), spec * fresnel, fresnel);
}


float AmbientOcclusion
    (
    float2 uv,
    Texture2D<float> depthMap, float occlusionRadius)
{
    float depth = dep2D(depthMap, uv);
    float occlusion = 0.0;
    [unroll]
    for (int x = -1; x <= 1; ++x)
    {
        [unroll]
        for (int y = -1; y <= 1; ++y)
        {
            float sampleDepth = dep2D(uv + float2(x, y) * occlusionRadius);
            occlusion += (sampleDepth > depth) ? 1.0 : 0.0;
        }
    }
    return 1.0 - (occlusion / 9.0);
}

float SSAO
    (
    float2 oosz,
    Texture2D<float> depthTex, float2 uv, float radius, float AO_DEPTH_THRESHOLD)
{
    float depthCenter = dep2D(depthTex, uv);
    float ao = 0.0;

    for (int x = -radius; x <= radius; x++)
    {
        for (int y = -radius; y <= radius; y++)
        {
            float2 offset = float2(x, y) * oosz;
            float sampleDepth = dep2D(depthTex, uv + offset);
            ao += (sampleDepth >= depthCenter + AO_DEPTH_THRESHOLD) ? 1 : 0;
        }
    }
    return 1.0 - (ao / ((2 * radius + 1) * (2 * radius + 1)));
}
/*
float3 RayMarchGlass(float3 rayOrigin, float3 rayDirection, float2 uv, float maxDistance, float stepSize, GradientModulationConfig config)
{
    float3 accumulatedColor = float3(0, 0, 0);
    float traveledDistance = 0.0;
    float depth = getDetailedDepth(depthMap, config.oosz, uv, config.grad.gradient);

    while (traveledDistance < maxDistance && traveledDistance < depth)
    {
        // Current position and glass properties
        float3 currentPosition = rayOrigin + rayDirection * traveledDistance;
        float impurity = GlassNoise(currentPosition, config);
        float3 normal = GetNormal(config.oosz, uv, normalRadius, config.grad.modulation);

        // Light interactions
        rayDirection = diffractRay(rayDirection, impurity, normal);
        float3 dispersedColor = ColorDispersionCalculation(rayDirection, impurity, 100 + 40 * PerlinNoise(float3(uv, depth * config.timeFactor * timr)));
        float fresnel = ComputeFresnel(rayDirection, normal, 1.5); // Assuming refractive index 1.5
        float3 refracted = RefractRay(rayDirection, normal, 1.5);

        // Accumulate color
        accumulatedColor += (dispersedColor * (1.0 - fresnel) + IcebergGlassNoise(depth, float3(uv, depth)) * fresnel) * stepSize;
        
        // Prepare for next iteration
        rayDirection = refracted;
        traveledDistance += stepSize;
    }

    return accumulatedColor / traveledDistance; // Normalizing the accumulated color
}*/



float DistributionGGX

    (

    float3 N, float3 H, float roughness)
{
    float a = roughness * roughness;
    float a2 = a * a;
    float NdotH = max(dot(N, H), 0.0);
    float NdotH2 = NdotH * NdotH;

    float nom = a2;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return nom / denom;
}
float GeometrySchlickGGX

    (

    float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r * r) / 8.0;

    float nom = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return nom / denom;
}

float GeometrySmith

    (

    float3 N, float3 V, float3 L, float roughness)
{
    float NdotV = max(dot(N, -V), 0.0);
    float NdotL = max(dot(N, L), 0.0);
    float ggx1 = GeometrySchlickGGX(NdotV, roughness);
    float ggx2 = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}



float3 CalculateLightTransport(float3 normal, float3 viewDir, AdvancedLight light)
{
    // Calculate halfway direction
    float3 halfwayDir = normalize(light.Direction + viewDir);

    // Calculate the Normal Distribution Function (NDF) using the GGX/Trowbridge-Reitz model
    float NDF = DistributionGGX(normal, halfwayDir, saturate(light.Roughness + light.ggxFlicker * PerlinNoise(float3(config.uv * light.ggxFlickerSize, light.ggxFlickerSpeed * config.grad.depth * config.timeFactor))));

    // Geometry function (Shadowing and Masking)
    float G = GeometrySmith(normal, viewDir, light.Direction, saturate(light.Roughness + light.smithFlicker * PerlinNoise(float3(config.uv * light.smithFlickerSize, light.smithFlickerSpeed * config.grad.depth * config.timeFactor))));

    // Fresnel-Schlick approximation
    float3 F = FresnelSchlick(max(dot(halfwayDir, -viewDir), 0.0), metallicF0(light.Metallic + light.metallicFlicker * PerlinNoise(float3(config.uv * light.metallicFlickerSize, light.metallicFlickerSpeed * config.grad.depth * config.timeFactor))));

    // Combine for the Cook-Torrance BRDF
    float3 numerator = NDF * G * F;
    float denominator = 4.0 * max(dot(normal, -viewDir), epsilon) * max(dot(normal, light.Direction), epsilon) + epsilon;
    float3 specular = numerator / denominator;

    // Assume Lambertian Diffuse Reflection
    float3 kD = (1.0 - max(F.x, max(F.y, F.z))) * (1.0 - light.Metallic + light.metallicFlicker * PerlinNoise(float3(config.uv * light.metallicFlickerSpeed, config.grad.depth * config.timeFactor)));
    float3 diffuse = kD / PI * max(dot(normal, light.Direction), 0.0) * light.Intensity;

    // Combine specular and diffuse components
    return (diffuse + specular) * light.Intensity;
}



// Advanced Light Transport Function
float3 AdvancedLightTransport(float2 uv, float3 position, float3 normal, float3 viewDir, AdvancedLight light)
{
    // Physically Based Rendering (PBR) calculations
    float3 halfwayDir = normalize(-light.Direction + viewDir);
    float NDF = DistributionGGX(normal, halfwayDir, light.Roughness); // GGX Distribution
    float G = GeometrySmith(normal, viewDir, light.Direction, light.Roughness); // Geometry term
    float3 F = FresnelSchlick(max(dot(-halfwayDir, -viewDir), 0.0), metallicF0(light.Metallic)); // Fresnel term

    // Calculate direct lighting
    float3 numerator = NDF * G * F;
    float denominator = max(dot(normal, -viewDir), 0.0) * max(dot(normal, light.Direction), 0.0) + 0.001; // Prevent division by zero
    float3 specular = numerator / denominator;

    // Calculate diffuse lighting
    float3 kS = F;
    float3 kD = (1.0 - kS) * (1.0 - light.Metallic);
    float3 irradiance = light.Intensity * max(dot(normal, -light.Direction), 0.0);
    float3 diffuse = irradiance * kD / PI;

    float AO = AmbientOcclusion(uv, depthMap, 4);

    // Combine for final color
    return (diffuse + specular) * AO;
}


float3 CalculateLighting(float2 uv, float3 position, float3 normal, float3 viewDir, float3 lightDir, float intensity, float roughness, float metallic, float2 modulation, float depth)
{
    AdvancedLight light;
    light = CreateAdvancedLight(position, lightDir, intensity, roughness, metallic, true, modulation, depth);
    
    
    AdvancedLight light2;
    light2 = CreateAdvancedLight(position, lightDir, intensity * RandomNoise(uv), roughness * RandomNoise(uv), metallic * RandomNoise(uv), true, modulation, depth);
    
    float3 ret = lerp(AdvancedLightTransport(uv, position, normal, viewDir, light),
        CalculateLightTransport(normal, viewDir, light2),
        .25);
    lerp(ret, 0, .5);
    return ret;
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
    float hue = frac(abs(dot(viewDir, particleNormal)) + hueShift);
    return HueToRGB(hue); // Convert hue to RGB using a suitable function
}

struct Particle
{
    float3 position;
    float3 velocity;
    float3 normal; // Normal vector for the particle
    float rotation;
    float rotationSpeed;
    float size;
};
Particle UpdateParticle(Particle p, float deltaTime)
{
    // Apply gravity-like force
    p.velocity.y -= 9.8 * deltaTime;
    p.position += p.velocity * deltaTime;

    // Update rotation
    p.rotation += p.rotationSpeed * deltaTime;

    return p;
}

float3 CalculateColor(Particle p, float3 viewDir)
{
    float3 rainbowColor = HolographicRainbowColor(viewDir, p.normal);
    float shimmer = noise(p.position); // Replace with actual noise function
    return lerp(rainbowColor, float3(1.0, 1.0, 1.0), shimmer);
}

float3 normalPerturb(vec3 normal, float amount)
{
    return normal + normal * amount * PerlinNoise(float3(config.uv, config.grad.depth));

}


// Advanced Iridescent Shift with Fresnel and Noise
float3 IridescentShift(float2 uv, float3 normal, float3 viewDir, float thickness, float shiftStrength)
{
    // Fresnel term for angle-based reflectance
    float fresnel = pow(1.0 - max(0, dot(normal, viewDir)), thickness);
    
    // Shift value modulated by noise for irregular surface simulation
    float noisev = Noise(uv) * .25 * dep2D(uv) * (1 - length(mir2D(diffuseMap, uv).rgb / 3));
    float shift = fresnel * (1.0 + noisev) * shiftStrength;
    
    // Color calculation with phase shift for iridescence
    float3 colorShift = float3(0.15, .033, 0.7) * shift; // Adjust the base shift values as needed
    float3 color = saturate(0.25 + 0.5 * cos(2 * PI * (colorShift + float3(cosTime01(timr * .2), .33, .5 + .5 * cosTime01(timr)))));
    
    return color;
}

// Function 2: Dichroic Reflection
float3 DichroicReflection(float3 normal, float3 viewDir, float reflectivity)
{
    float angle = dot(normal, viewDir);
    float reflectance = reflectivity * pow(1.0 - angle, 2.0);
    float3 color = lerp(float3(1.0, 0.0, 0.0), float3(0.0, 0.0, 1.0), reflectance);
    return color;
}

// Function 3: Rayleigh Scattering Simulation
float3 RayleighScattering2(float3 lightDir, float3 viewDir, float atmosphereThickness)
{
    float scatter = pow(dot(lightDir, viewDir) + 1.0, atmosphereThickness);
    float3 color = scatter * float3(0.5, 0.7, 1.0); // Blueish tint, typical for Rayleigh scattering
    return color;
}

#define MAX_PARALLAX_INFO 20



// Gaussian blur helper function for depth smoothing
float GaussianBlur(float2 uv, Texture2D<float> heightMap, float2 oosz, int radius)
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
            blurredDepth += weight * heightMap.SampleLevel(sampleTypeMirror, sampleUV, 0).r;
            weightSum += weight;
        }
    }

    return blurredDepth / weightSum;
}


float CalculateShadowing(float2 oosz, float2 uv, vec3 perturbedNormal, bool flipDepth)
{
    const float shadowBias = 0.005; // Prevents self-intersection artifacts
    const float rayStep = 0.01; // Step size for marching
    const int numSteps = 20; // Adjust step count for quality/performance

    float depth = shadowBias;
    vec2 lightDir = normalize(vec2(0.5, 1.0)); // Sample directional light 

    for (int i = 0; i < numSteps; ++i)
    {
        float layerDepth = GetDepth(oosz, uv + depth * lightDir, 15, GetGradient(oosz, uv + depth * lightDir, 15, flipDepth), flipDepth);
        if (depth >= layerDepth)
            return 0.5; // Occluded 
        depth += rayStep;
    }

    return 1.0; // No occlusion found
}


ParallaxResult ParallaxOcclusion(float2 oosz, Texture2D<float> heightMap, float2 uv, float2 offset, int numLayers, bool flipDepth, bool flipCompare)
{
    ParallaxLayerResult ret;
    InitializeParallaxLayerResult(ret);
    ret.uv = uv;
  
    int rad = 30;
    vec2 grad0 = GetGradient(oosz, uv, rad, flipDepth);
    vec2 dc0 = ComputeAdjustedDepthCurve(oosz, uv, flipDepth);
    float depth0 = GetDepth(oosz, uv, rad, grad0, dc0, flipDepth);
    vec2 offset0 = offset * depth0;
    
    vec2 offset1 = offset * depth0;
    [unroll(10)]
    for (int i0 = 1; i0 <= numLayers; ++i0)
    {
        offset1 = offset0 + offset * (depth0);
        vec2 grad1 = GetGradient(oosz, ret.uv + offset1, rad, flipDepth);
        vec2 dc1 = ComputeAdjustedDepthCurve(oosz, uv + offset1, flipDepth);
        float depth1 = GetDepth(oosz, ret.uv + offset1, rad, dc1, dc1, flipDepth);
        
        if (depth1 < depth0)
        {
            
            ret.uv = ret.uv + lerp(offset0, offset1, .75);
            grad0 = lerp(grad0, grad1, .75);
            dc0 = lerp(dc0, dc1, .75);
            offset0 = lerp(offset0, offset1, .75);
            depth0 = lerp(depth0, depth1, .75);
        }
        else
        {
            ret.uv = ret.uv + lerp(offset0, offset1, .5);
            grad0 = lerp(grad0, grad1, .5);
            dc0 = lerp(dc0, dc1, .5);
            offset0 = lerp(offset0, offset1, .5);
            depth0 = lerp(depth0, depth1, .5);
        }
    }

    ParallaxResult result;
    result.diffuse = mir2D(diffuseMap, ret.uv).rgb; // Replace with actual texture sampling method
    result.uv = ret.uv;
    return result;
}

float4 ChromaColor(float2 oosz, float2 uv, bool flipDepth)
{
    float4 ret = vec4(config.uv, 0, 1);
    
    vec2 grad30 = GetGradient(oosz, uv, 30, flipDepth);
    vec2 curve1 = ComputeAdjustedDepthCurve(oosz, uv, flipDepth);
    
    float depth3 = GetDepth(oosz, config.uv, 20, curve1, curve1, flipDepth);
    
    vec2 mod30 = GetModulation(grad30, curve1);

    vec3 normal = GetNormal(oosz, uv, 40, mod30, grad30, curve1);
    float3 iridescentColor = IridescentShift(uv, normal, config.viewDir, 0.5, 2.0);
    float3 rayleighColor = RayleighScattering2(DirLightDirection, config.viewDir, 10.0);

    vec4 power4 = float4(1, 1, 1, 1) * FresnelPower;

        vec2 curveDepth = curve1 * depth3;
    
        vec4 schlick = pow(Fresnel(vec4(curve1.x, curve1.y, config.diffuse.r, config.diffuse.g), power4),
        log(1 + Schlick(ret, vec4(curveDepth, curve1), power4)));
    
    float2 mod = (-vec4(curveDepth, curve1)).xy +
        schlick.xy + mod30;
        
    float2 adjustedDepth2 = GetDepth(oosz, uv, 20, curve1, flipDepth) / (-schlick);
    float ad3 = dot(mod, adjustedDepth2);
        

    ret = schlick;
    
    
    return ret;
}

// A pixel shader function that creates a holographic transform matrix and applies it to an image
float4 hologramPS(float2 oosz, Texture2D tex, float2 uv, bool flipDepth, float2 occlusionOffset, float numOcclusionLayers)
{
    // Get the input image
    float4 input = mir2D(tex, uv);

    // Define the parameters of the holographic transform
    float z = 0.1; // Distance between the object and the film (in m)
    float lambda_min = 0.4e-6; // Minimum wavelength (in m)
    float lambda_max = 0.7e-6; // Maximum wavelength (in m)
    float lambda_step = 0.01e-6; // Wavelength step (in m)
    float k0 = 2 * PI / 0.5e-6; // Reference wave number (in 1/m)
    float n0 = 1.5; // Reference refractive index
    float2 n = n0 + 0.1 * sin(2 * PI * uv / n0); // Dispersion function of the holographic medium
    
    // Initialize the output color
    float4 output = vec4(mir2D(tex, uv).r, mir2D(tex, uv).g, mir2D(tex, uv).b, 1);
  
    ParallaxResult pr = ParallaxOcclusion(oosz, depthMap, uv, occlusionOffset, numOcclusionLayers, flipDepth, KeyAlt);
        
   
    // Loop over the wavelength range
    for (float lambda = lambda_min; lambda <= lambda_max; lambda += lambda_step)
    {
    
        // Calculate the current wave number
        float2 k = k0 * n / n0;
        float2 i = k * lambda;
        // Create the holographic transform matrix
        // Create the holographic transform matrix
        float2 H = exp(i * k * z) / (i * lambda * z) * exp(-i * PI / (lambda * z) * (uv.x * uv.x + uv.y * uv.y));
      
        output += mir2D(diffuseMap, uv);
    }

    // Return the output color
    return output;
}
float4 spectralGasPS(float2 oosz, Texture2D tex, float2 uv : TEXCOORD0) : COLOR0
{
    // Get the input image in HSV color space
    float4 input = mir2D(tex, uv);
    input = RGBtoHSV(input);

    // Define the standard deviation and the filter size
    float sigma = 2.0;
    int filterSize = 9;

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
            float4 neighbor = mir2D(tex, uv + float2(i, j) * oosz);
            neighbor = RGBtoHSV(neighbor);

            // Update the output color
            // Only apply the filter to the value channel, keep the hue and saturation unchanged
            output += weight * float4(neighbor.x, neighbor.y, input.z, neighbor.w);
        }
    }

    // Normalize the output color
    output /= norm;

    // Convert the output color back to RGB color space
    output = HSVtoRGB(output);

    // Return the output color
    return output;
}

// Function 2: Chromatic Aberration Simulation
float3 ChromaticAberration
    (float2 oosz,
    Texture2D tex, float3 color, float2 uv, float2 aberrationOffset)
{
    // Simulates chromatic aberration by slightly offsetting the color channels
    float2 redOffset = uv + float2(aberrationOffset.x, 0);
    float2 greenOffset = uv;
    float2 blueOffset = uv - float2(aberrationOffset.y, 0);
    float red = mir2D(tex, redOffset).r;
    float green = mir2D(tex, greenOffset).g;
    float blue = mir2D(tex, blueOffset).b;
    return (float4(color * float3(red, green, blue), 1)).xyz;
}




float4 glowMorph(float2 oosz, Texture2D tex, float2 uv, float scale)
{
    float centerDist = length(uv - .5);
    
     vec2 occlusionOffset = cosTime01(timr) * vec2(.06, .097) * scale * dep2D(uv);
    
    ParallaxResult pr = ParallaxOcclusion(oosz, depthMap, uv, occlusionOffset, 5, false, false);
   
    float4 ret = saturate(float4(ChromaticAberration(oosz, tex,
        float4(saturate(imgaussfiltPS(oosz, tex, pr.uv, 2, 9).rgb), 1).xyz,
        pr.uv, oosz), 1));
 
    
    return ret;
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


float4 calculateFresnelEffect(MaterialProperties mat, float3 normal, float3 world, float4 diffuse, float fresnelPower, float fresnelReflectance, float brightness)
{
    // Calculate important vectors
    vec3 viewDir = normalize(config.viewDir);
    vec3 lightDir = normalize(-config.sunDir);
    vec3 N = normalize(normal);
    vec3 R = reflect(-lightDir, N);

    // Base color from chromatic dispersion
    vec4 baseColor = vec4(mat.baseColor, 1); // + float4(RenderChromaticDispersionEffect(-config.sunDir, N, viewDir, world, mat, diffuse.xyz), 1);

    // Compute Fresnel term using Schlick's approximation with physically informed factors
    float cosTheta = dot(-viewDir, N);
    float F0 = pow((1.0 - mat.refractiveIndex) / (1.0 + mat.refractiveIndex), 2.0); // Base F0 at normal incidence 
    float F = F0 + (1.0 - F0) * pow(1.0 - cosTheta, fresnelPower);

    // Specular reflection with more subtle falloff
    float cosThetaDiffuse = max(dot(N, lightDir), 0.0);
    float cosThetaSpecular = max(dot(viewDir, R), 0.0);
    float specular = pow(cosThetaSpecular, mat.smoothness) * SpecularIntensity;

    // Combine components - modulation instead of overwriting
    vec4 finalColor = (diffuse * baseColor) * (1.0 - F) // Modulate by refracted portion
                      + diffuse * cosThetaDiffuse * (1.0 - mat.metalness) // Diffuse component
                      + specular * mat.metalness * brightness * SpecularPower; // Metalness-based specular

    return Schlick(finalColor, diffuse, FresnelPower);
}


float4 calculateFresnelEffect(float4 sv1, vec3 normal, float brightness)
{
    
    // Assuming sv1 is the result of some chromatic dispersion effect rendering,
    // and diffuse is a texture sample or a base color.
    vec3 viewDir = normalize(config.viewDir); // Ensure view direction is normalized
    vec3 L = normalize(-config.sunDir); // Light direction, assuming sunlight
    vec3 N = normalize(normal); // Ensure normal direction is normalized


    // Compute the Fresnel term using Schlick's approximation
    float R0 = FresnelReflectance; // Base reflectance at normal incidence
    float cosTheta = dot(-viewDir, N); // Cosine of angle between view direction and normal
    float F = R0 + (1.0 - R0) * pow(1.0 - cosTheta, FresnelPower); // Schlick's approximation

    // Calculate the reflection vector
    vec3 R = reflect(-L, N); // Reflects L around N
    float cosThetaDiffuse = max(dot(N, L), 0.0); // Cosine of angle for diffuse lighting
    float cosThetaSpecular = max(dot(viewDir, R), 0.0); // Cosine of angle for specular reflection

    // Modulate the base color by the diffuse term and add the Fresnel term for specular reflection
    // Use a lower value for the fresnelPower parameter
    // Add the diffuse term instead of multiplying it
    vec4 finalColor = combine(sv1, cosThetaDiffuse, F * pow(cosThetaSpecular, 0.5) * brightness);

    return finalColor;

}
struct DiffractionParams
{
    
    float2 gratingUVScale; // Controls tiling and density of the pattern
    float distortionStrength; // Intensity of noise-based warping
    float spectralSpread; // Controls width of the color spectrum
    float fresnelInfluence; // How much viewing angle affects visibility
    float4 baseColor;
    float indexOfRefraction;
};

DiffractionParams CreateDiffractionParams(
    float2 gratingUVScale, float distortionStrength, float spectralSpread, float fresnelInfluence, float4 baseColor, float indexOfRefraction)
{
    DiffractionParams params;
    params.indexOfRefraction = indexOfRefraction;
    params.gratingUVScale = gratingUVScale;
    params.distortionStrength = distortionStrength;
    params.spectralSpread = spectralSpread;
    params.fresnelInfluence = fresnelInfluence;
    params.baseColor = baseColor;
    return params;
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


float4 AlluringDiffraction(float3 position, float3 normal, float3 lightDir, float3 viewDir, DiffractionParams params)
{
    // 1. Sample Grating Pattern
    float2 gratingUV = position.xy * params.gratingUVScale;
    float gratingIntensity = 1 - position.z;

// ... (Other parts of the function) ...

// 2. Stacked Grating and Warping
    float totalWarp = 0.0;


    // Sample depth map (Adjust texture name dynamically)
    float depth1 = dep2D(gratingDepth1, gratingUV);
    // Sample normal map and calculate offset direction
    float3 normal1 = normal2D(gratingNormal1, gratingUV).rgb;
    // Sample depth map (Adjust texture name dynamically)
    float depth2 = dep2D(gratingDepth2, gratingUV);
    // Sample normal map and calculate offset direction
    float3 normal2 = normal2D(gratingNormal2, gratingUV).rgb;
    // Sample depth map (Adjust texture name dynamically)
    float depth3 = dep2D(gratingDepth3, gratingUV);
    // Sample normal map and calculate offset direction
    float3 normal3 = normal2D(gratingNormal3, gratingUV).rgb;
    // Sample depth map (Adjust texture name dynamically)
    float depth4 = dep2D(gratingDepth4, gratingUV);
    // Sample normal map and calculate offset direction
    float3 normal4 = normal2D(gratingNormal4, gratingUV).rgb;
    
    
     // Physically-Based Warp Calculation
    float3 refractedLight = refract(-lightDir, normal1, 1.0 / params.indexOfRefraction);
    float3 surfaceTangent = normalize(cross(normal1, refractedLight));
    float warpStrength = depth1 * params.distortionStrength * params.distortionStrength;

        // Optionally modulate by grating intensity
    warpStrength *= gratingIntensity;

    float2 warpOffset = surfaceTangent.xy * warpStrength;
  
    
     // Physically-Based Warp Calculation
    refractedLight = refract(-lightDir, normal2, 1.0 / params.indexOfRefraction);
    surfaceTangent = normalize(cross(normal2, refractedLight));
    warpStrength = depth2 * params.distortionStrength * params.distortionStrength;

        // Optionally modulate by grating intensity
    warpStrength *= gratingIntensity;

    warpOffset += surfaceTangent.xy * warpStrength;
    
     // Physically-Based Warp Calculation
    refractedLight = refract(-lightDir, normal3, 1.0 / params.indexOfRefraction);
    surfaceTangent = normalize(cross(normal3, refractedLight));
    warpStrength = depth3 * params.distortionStrength * params.distortionStrength;

        // Optionally modulate by grating intensity
    warpStrength *= gratingIntensity;

    warpOffset = surfaceTangent.xy * warpStrength;
    
    
     // Physically-Based Warp Calculation
    refractedLight = refract(-lightDir, normal4, 1.0 / params.indexOfRefraction);
    surfaceTangent = normalize(cross(normal4, refractedLight));
    warpStrength = depth4 * params.distortionStrength * params.distortionStrength;

        // Optionally modulate by grating intensity
    warpStrength *= gratingIntensity;

    warpOffset = surfaceTangent.xy * warpStrength;
    
    gratingUV += warpOffset * params.gratingUVScale;

    totalWarp += (depth1 + depth2 + depth3 + depth4);


// 3. Calculate Color Shift (using totalWarp for spectral offset)
    float dispersionOffset = clamp(totalWarp * params.spectralSpread, 0, 1);
// ... (rest of the color shift code) ...
    float2 colorUV = float2(dispersionOffset, dispersionOffset);
    float4 dispersedColor = clamp(mir2D(gradient4, colorUV) + dispersionOffset, 0, 1);

    // 4. Fresnel-like Influence (Use a proper Fresnel equation)
    float surfaceDot = dot(normal, -viewDir);
    float fresnelFactor = calculateFresnel(surfaceDot + normal, params.indexOfRefraction); // Example using a custom Fresnel function 
    float holoVisibility = saturate(lerp(0.02, .80, fresnelFactor) * params.fresnelInfluence);

    // ... (Retrieve base texture color) ...

    // Consider multiplying base color instead of adding
    float4 finalColor = saturate(float4(lerp(0, params.baseColor + clamp(dispersedColor * holoVisibility, 0, 1), .5).rgb, 1));

    return finalColor;
}
// A function that uses fresnel schlick, material reflectance, and other parameters to affect the pixel color
float3 LightFresnelSchlick(float3 normal, float3 view, float3 light, float3 baseColor, float metallic, float roughness)
{
    // Compute the half vector
    float3 halfv = normalize(light + view);

    // Compute the fresnel reflectance at normal incidence
    float3 F0 = Fresnel(float4(lerp(0.04, baseColor, metallic), 1));

    // Compute the fresnel reflectance using Schlick's approximation
    float3 F = F0 + (1.0 - F0) * pow(1.0 - dot(halfv, view), FresnelReflectance);
    float3 F2 = F0 + (1 - F0) * pow(clamp(dot(normal, -view), 0, 1), FresnelPower);

    // Compute the specular BRDF using the GGX model
    float alpha = roughness * roughness;
    float NdotL = saturate(dot(normal, light));
    float NdotV = saturate(dot(normal, view));
    float NdotH = saturate(dot(normal, halfv));
    float VdotH = saturate(dot(view, halfv));
    float D = alpha * alpha / (PI * pow(NdotH * NdotH * (alpha * alpha - 1.0) + 1.0, 2.0));
    float G = min(1.0, min(2.0 * NdotH * NdotV / VdotH, 2.0 * NdotH * NdotL / VdotH));
    float3 specular = F * D * G / (SpecularPower * NdotL * NdotV + 0.001) * NdotL;

    // Compute the diffuse BRDF using the Lambertian model
    float3 diffuse = (1.0 - F) * baseColor / PI + (1 - F2) * baseColor / PI;

    // Return the pixel color as the sum of diffuse and specular components
    return (diffuse + specular);
}


float2 GetRandomOffset(int i)
{
    float angle = (i / 8.0) * 6.283; // 8 samples, evenly spaced angle
    return float2(cos(angle), sin(angle));
}

float4x4 inverse(float4x4 input)
{
#define minor(a,b,c)determinant(float3x3(input.a, input.b, input.c))
    //determinant(float3x3(input._22_23_23, input._32_33_34, input._42_43_44))
    
    float4x4 cofactors = float4x4(
		 minor(_22_23_24, _32_33_34, _42_43_44),
		-minor(_21_23_24, _31_33_34, _41_43_44),
		 minor(_21_22_24, _31_32_34, _41_42_44),
		-minor(_21_22_23, _31_32_33, _41_42_43),
		
		-minor(_12_13_14, _32_33_34, _42_43_44),
		 minor(_11_13_14, _31_33_34, _41_43_44),
		-minor(_11_12_14, _31_32_34, _41_42_44),
		 minor(_11_12_13, _31_32_33, _41_42_43),
		
		 minor(_12_13_14, _22_23_24, _42_43_44),
		-minor(_11_13_14, _21_23_24, _41_43_44),
		 minor(_11_12_14, _21_22_24, _41_42_44),
		-minor(_11_12_13, _21_22_23, _41_42_43),
		
		-minor(_12_13_14, _22_23_24, _32_33_34),
		 minor(_11_13_14, _21_23_24, _31_33_34),
		-minor(_11_12_14, _21_22_24, _31_32_34),
		 minor(_11_12_13, _21_22_23, _31_32_33)
	);
#undef minor
    return transpose(cofactors) / determinant(input);
}

float4x4 InvertMatrix(float4x4 m)
{
    float4x4 inv;
    float det;

    inv[0][0] = m[1][1] * m[2][2] * m[3][3] - m[1][1] * m[2][3] * m[3][2] - m[2][1] * m[1][2] * m[3][3] + m[2][1] * m[1][3] * m[3][2] + m[3][1] * m[1][2] * m[2][3] - m[3][1] * m[1][3] * m[2][2];
    inv[0][1] = -m[0][1] * m[2][2] * m[3][3] + m[0][1] * m[2][3] * m[3][2] + m[2][1] * m[0][2] * m[3][3] - m[2][1] * m[0][3] * m[3][2] - m[3][1] * m[0][2] * m[2][3] + m[3][1] * m[0][3] * m[2][2];
    inv[0][2] = m[0][1] * m[1][2] * m[3][3] - m[0][1] * m[1][3] * m[3][2] - m[1][1] * m[0][2] * m[3][3] + m[1][1] * m[0][3] * m[3][2] + m[3][1] * m[0][2] * m[1][3] - m[3][1] * m[0][3] * m[1][2];
    inv[0][3] = -m[0][1] * m[1][2] * m[2][3] + m[0][1] * m[1][3] * m[2][2] + m[1][1] * m[0][2] * m[2][3] - m[1][1] * m[0][3] * m[2][2] - m[2][1] * m[0][2] * m[1][3] + m[2][1] * m[0][3] * m[1][2];
    inv[1][0] = -m[1][0] * m[2][2] * m[3][3] + m[1][0] * m[2][3] * m[3][2] + m[2][0] * m[1][2] * m[3][3] - m[2][0] * m[1][3] * m[3][2] - m[3][0] * m[1][2] * m[2][3] + m[3][0] * m[1][3] * m[2][2];
    inv[1][1] = m[0][0] * m[2][2] * m[3][3] - m[0][0] * m[2][3] * m[3][2] - m[2][0] * m[0][2] * m[3][3] + m[2][0] * m[0][3] * m[3][2] + m[3][0] * m[0][2] * m[2][3] - m[3][0] * m[0][3] * m[2][2];
    inv[1][2] = -m[0][0] * m[1][2] * m[3][3] + m[0][0] * m[1][3] * m[3][2] + m[1][0] * m[0][2] * m[3][3] - m[1][0] * m[0][3] * m[3][2] - m[3][0] * m[0][2] * m[1][3] + m[3][0] * m[0][3] * m[1][2];
    inv[1][3] = m[0][0] * m[1][2] * m[2][3] - m[0][0] * m[1][3] * m[2][2] - m[1][0] * m[0][2] * m[2][3] + m[1][0] * m[0][3] * m[2][2] + m[2][0] * m[0][2] * m[1][3] - m[2][0] * m[0][3] * m[1][2];
    inv[2][0] = m[1][0] * m[2][1] * m[3][3] - m[1][0] * m[2][3] * m[3][1] - m[2][0] * m[1][1] * m[3][3] + m[2][0] * m[1][3] * m[3][1] + m[3][0] * m[1][1] * m[2][3] - m[3][0] * m[1][3] * m[2][1];
    inv[2][1] = -m[0][0] * m[2][1] * m[3][3] + m[0][0] * m[2][3] * m[3][1] + m[2][0] * m[0][1] * m[3][3] - m[2][0] * m[0][3] * m[3][1] - m[3][0] * m[0][1] * m[2][3] + m[3][0] * m[0][3] * m[2][1];
    inv[2][2] = m[0][0] * m[1][1] * m[3][3] - m[0][0] * m[1][3] * m[3][1] - m[1][0] * m[0][1] * m[3][3] + m[1][0] * m[0][3] * m[3][1] + m[3][0] * m[0][1] * m[1][3] - m[3][0] * m[0][3] * m[1][1];
    inv[2][3] = -m[0][0] * m[1][1] * m[2][3] + m[0][0] * m[1][3] * m[2][1] + m[1][0] * m[0][1] * m[2][3] - m[1][0] * m[0][3] * m[2][1] - m[2][0] * m[0][1] * m[1][3] + m[2][0] * m[0][3] * m[1][1];
    inv[3][0] = -m[1][0] * m[2][1] * m[3][2] + m[1][0] * m[2][2] * m[3][1] + m[2][0] * m[1][1] * m[3][2] - m[2][0] * m[1][2] * m[3][1] - m[3][0] * m[1][1] * m[2][2] + m[3][0] * m[1][2] * m[2][1];
    inv[3][1] = m[0][0] * m[2][1] * m[3][2] - m[0][0] * m[2][2] * m[3][1] - m[2][0] * m[0][1] * m[3][2] + m[2][0] * m[0][2] * m[3][1] + m[3][0] * m[0][1] * m[2][2] - m[3][0] * m[0][2] * m[2][1];
    inv[3][2] = -m[0][0] * m[1][1] * m[3][2] + m[0][0] * m[1][2] * m[3][1] + m[1][0] * m[0][1] * m[3][2] - m[1][0] * m[0][2] * m[3][1] - m[3][0] * m[0][1] * m[1][2] + m[3][0] * m[0][2] * m[1][1];
    inv[3][3] = m[0][0] * m[1][1] * m[2][2] - m[0][0] * m[1][2] * m[2][1] - m[1][0] * m[0][1] * m[2][2] + m[1][0] * m[0][2] * m[2][1] + m[2][0] * m[0][1] * m[1][2] - m[2][0] * m[0][2] * m[1][1];

    det = m[0][0] * inv[0][0] + m[0][1] * inv[0][1] + m[0][2] * inv[0][2] + m[0][3] * inv[0][3];
    if (det == 0.0f)
        return m; // Or handle the non-invertible case as needed

    inv /= det;
    return inv;
}

float4x4 CreateApproxProjectionMatrix()
{
    float zNear = 0.0; // Or your actual near plane if this setup isn't ortho-like
    float zFar = 1.0;
    float width = config.isz.x; // Replace with your viewport width
    float height = config.isz.y; // Replace with your viewport height

    float4x4 projMatrix;
projMatrix[0][1]=0;
projMatrix[0][2]=0;
projMatrix[0][3]=0;
projMatrix[1][0]=0;
projMatrix[1][2]=0;
projMatrix[1][3]=0;
projMatrix[2][0]=0;
projMatrix[2][1]=0;
projMatrix[2][3]=0;
projMatrix[3][0]=0;
projMatrix[3][1]=0;
projMatrix[3][3]=0;

    projMatrix[0][0] = 2.0 / width;
    projMatrix[1][1] = -2.0 / height; // Note Y-flip to match texture coords
    projMatrix[2][2] = 1.0 / (zFar - zNear);
    projMatrix[3][2] = zNear / (zNear - zFar);
    return projMatrix;
}
float3 ReconstructWorldPosition(float depth, float2 uv)
{
float nearClip  = 0;
float farClip = 1;
    float z = (2.0 * nearClip * farClip) / (farClip + nearClip - (depth * (farClip - nearClip)));

    float2 viewCoords = uv * 2.0 - 1.0; // UVs in [0, 1] range
    viewCoords.y = -viewCoords.y; // Y-axis flip if necessary

    float4 viewPos = float4(viewCoords * z, z, 1.0);
    float4 worldPos = mul(viewPos, inverse(CreateApproxProjectionMatrix())); // Use inverse projection
    return worldPos.xyz / worldPos.w;
}

float3 ReconstructViewDirection(float depth, float2 uv)
{
    float3 worldPos = ReconstructWorldPosition(depth, uv);
    return normalize(config.viewPos - worldPos); // Assumes 'cameraPosition' is accessible 
}

float4 SampleScattering(float3 samplePos, float3 surfaceNormal, float3 scatteringDir)
{
    float distancev = distance(samplePos, ReconstructWorldPosition(samplePos.z, samplePos.xy));
    float attenuation = exp(-distancev * distancev / 0.001); // Tweak falloff here!
    // ... Potentially include light color / dot(surfaceNormal, scatteringDir) etc.
    return rtMap1.SampleLevel(sampleTypeMirror, samplePos.xy, 0) * attenuation;
}

float4 PostProcessSubsurface(float2 uv : TEXCOORD0, float4 currentPixel : SV_Target0) : SV_Target0
{

    // ... (World position / View direction reconstruction - as before) ...

    float3 scatteringDir = normalize(refract(-config.viewDir, config.grad.normal, 1.33)); // Approx for water-like IOR
    float3 scatteringColor = float3(0, 0, 0);

    // Multi-Scatter Approximation
    const int numSamples = 8;
    const float sampleRadius = 0.05; // Control scatter 'blur'
    for (int i = 0; i < numSamples; i++)
    {
        float2 randomOffset = GetRandomOffset(i) * sampleRadius;
        float3 samplePos = ReconstructWorldPosition(depthMap.Sample(sampleTypeMirror, uv + randomOffset).r, uv + randomOffset);
        scatteringColor += SampleScattering(samplePos, normalMap.SampleLevel(sampleTypeMirror, uv, 0).xyz, scatteringDir);
    }

    scatteringColor /= numSamples;

    // Combine with surface color: Here, a simple additive for clarity 
    currentPixel.rgb += scatteringColor;
    return currentPixel;
}


psout PS(PS_INPUT input)
{
    psout ret;
    float2 uv0 = input.TexCoord;
    if (true)
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
        ret.rt1 = vec4(mir2D(rtMap1, uv0).rgb, 1);
        ret.rt2 = vec4(mir2D(rtMap2, uv0).rgb, 1);
        ret.rt3 = vec4(mir2D(rtMap3, uv0).rgb, 1);
        ret.rt4 = vec4(mir2D(rtMap4, uv0).rgb, 1);
        ret.rt5 = vec4(mir2D(rtMap5, uv0).rgb, 1);
        ret.rt6 = vec4(mir2D(rtMap6, uv0).rgb, 1);
        ret.rt7 = vec4(mir2D(rtMap7, uv0).rgb, 1);
        ret.rt8 = vec4(mir2D(rtMap8, uv0).rgb, 1);
    }
    
    
    vec3 sunPos0 = vec3(1, 5, 2); //vec3(cosTime01(timr) * .5 - .25, cosTime01(timr) * .5 + .5, cosTime01(timr) * .2 - .1);
    vec3 sunDir0 = normalize(vec3(uv0, dep2D(uv0)) - sunPos0);
    vec3 lightPos0 = 0 + vec3(0, 1, -5);
    vec3 lightDir0 = normalize(-lightPos0);
  
   // camDir = normalize(vec3(0, 0, -1).xyz);
   // camDir = normalize(lookAtW - camPos);
   //vec3 viewDir = vec3(LOOK_AT, LOOK_AT.x / LOOK_AT.y);
    vec3 viewDir = normalize(RotateAroundAxis(RotateAroundY(vec3(0, 0, 1), abs(cosTime01(timr) - .5) * .01), cross(vec3(0, 1, 0), RotateAroundY(vec3(0, 0, 1), abs(cosTime01(timr) - .5) * .01)), cosTime01(timr) * .01));

  //  config.grad.depth = adjustedDepth;
    const int numOcclusionLayers =20;
    

    

    vec4 fresnelPower = FresnelPower;
    vec4 fresnelReflectance = FresnelReflectance;
    const vec2 oosz = depthOosz();
    const vec2 ooszd = diffuseOosz();
    const vec2 ooszrt = rtMapOosz();
    
    bool flipDepth = true;
    config = InitializeConfig(
     oosz,
       TotalTime * timr
       , uv0, uv0,
       ooszd, ooszrt,
    sunPos0, sunDir0,
       camPos0, viewDir, mir2D(diffuseMap, uv0), mir2D(diffuseMap, uv0),
        vec3(0, 0, 1), vec3(0, 0, 1), 1.0, 1.0, 1.0, flipDepth
    );
    
    vec2 grad0 = GetGradient(oosz, config.uv0, 9, flipDepth);
    float2 dc0 = ComputeAdjustedDepthCurve(oosz, config.uv0, flipDepth);
    float depth0 = GetDepth(oosz, config.uv0, 9, float2(0, 0), flipDepth);
    float2 mod0 = GetModulation(grad0, dc0);
    float3 normal0 = vec4((normalize(imgaussfiltPS(oosz, normalMap, config.uv0, 2, 9, dc0)) * 2 - 1).rgb, 1);
    
    vec2 occlusionOffset = vec2(.001 * 4 * PerlinNoise(float3(config.uv0 * 10, depth0 + TotalTime*timr)) - 0.001 * 2 * PerlinNoise(float3(config.uv0 * 10, depth0 + TotalTime*timr)), -.001) * DepthScale * (depth0 > 0 ? 1 : 0) * (cosTime01(timr) * .5 - .25);
   
    ParallaxResult pr = ParallaxOcclusion(oosz, depthMap, config.uv, occlusionOffset, numOcclusionLayers, 0, 0);
    config.uv = pr.uv;
    
    
    vec2 dc = ComputeAdjustedDepthCurve(oosz, config.uv, flipDepth);
    config.grad.depth = GetDepth(oosz, config.uv, 9, dc, flipDepth);
    float depth = config.grad.depth;
    config.uv = pr.uv;
    
    vec2 gradv = GetGradient(oosz, config.uv, 8, flipDepth);
    config.diffuse = mir2D(diffuseMap, config.uv);
    float2 mod2 = GetModulation(gradv, dc);
    float centerDist = distance(float3(config.uv, depth),
                    float3(float2(0.5, 0.5), GetDepth(oosz, .5, 9, float2(0, 0), flipDepth)));
    
    float3 normal = normalize(imgaussfiltPS(oosz, normalMap, config.uv, 2, 3, dc)) * 2 - 1;
    config.reflectDir = -reflect(-sunDir0, normal);
    

    if (PassNum == 0)
    {
      
        ret.rt2 = saturate(calculateFresnelEffect(CreateMaterialCrownGlass(), normal, float3(config.uv, depth), config.diffuse * dot(normal, -config.viewDir), fresnelPower.
        x, fresnelReflectance.x, .1));
        ret.rt3 = saturate(calculateFresnelEffect(CreateMaterialDiamond(), normal, float3(config.uv, depth), config.diffuse * dot(normal, -config.viewDir), fresnelPower.
        x, fresnelReflectance.x, .1));


        float of = +4;
        ret.rt5 = saturate(calculateFresnelEffect(CreateMaterialBK7Glass(), normal, float3(config.uv, depth), config.diffuse * dot(normal, config.viewDir), fresnelReflectance.
        x + of, fresnelPower.x + of, .1));
        ret.rt6 = saturate(calculateFresnelEffect(CreateMaterialCrownGlass(), normal, float3(config.uv, depth), config.diffuse * dot(normal, config.viewDir), fresnelReflectance.
        x + of, fresnelPower.x + of, .1));

        ret.rt1 = lerp(ret.rt2, ret.rt3, PerlinNoise(float3(config.uv, depth + TotalTime*timr)));
  
        ret.rt1 = float4(AlluringDiffraction(float3(config.uv, depth), normal, -sunDir0, config.viewDir, CreateDiffractionParams(float2(1, 1), .2, 0.5, -.5 + clamp(dot(normal, -config.viewDir), 0, 1), clamp(ret.rt1, 0, 1), -.5 + clamp(dot(normal, -config.viewDir), 0, 1))).rgb, 1);

        ret.rt4 = lerp(ret.rt5, ret.rt6, PerlinNoise(float3(config.uv, depth + TotalTime * timr)));
  
        ret.rt1 = float4(AlluringDiffraction(float3(config.uv, depth), normal, -sunDir0, config.viewDir, CreateDiffractionParams(float2(1, 1), .2, 0.5, -.5 + clamp(dot(normal, -config.viewDir), 0, 1), clamp(config.diffuse * ret.rt4, 0, 1), -.5 + clamp(dot(normal, -config.viewDir), 0, 1))).rgb, 1);
  
//ret.rt1 = float4(0,0,0,1);

    }
    else
    {
        ret.rt1 = combine(mir2D(rtMap1, config.uv0), float4(glowMorph(oosz, rtMap1, config.uv0, cosTime01(timr) * .02 + .01).rgb, 1));

        ret.rt1 = lerp(ret.rt1, (mir2D(rtMap4, config.uv0) + float4(glowMorph(oosz, rtMap4, config.uv0, cosTime01(timr) * .02 + .01).rgb, 1)) * .9, PerlinNoise(vec3(config.uv, config.grad.depth + TotalTime * timr)));


        ret.rt1 = float4(AlluringDiffraction(float3(config.uv, depth), normal, -sunDir0, config.viewDir, CreateDiffractionParams(float2(1, 1), .2, 0.5, -.5 + clamp(dot(normal, -config.viewDir), 0, 1), clamp(config.diffuse * ret.rt1, 0, 1), -.5 + clamp(dot(normal, -config.viewDir), 0, 1))).rgb, 1);



        ret.rt1 = Schlick(ret.rt1, Fresnel(mir2D(diffuseMap, config.uv)), FresnelPower) +
        rotateHue(ret.rt1, fmod(TotalTime * 50, 360));
        
ret.rt1 = float4(saturate(PostProcessSubsurface(config.uv, ret.rt1).xyz),1);
        ret.rt1 = .1+saturate(float4(ret.rt1.xyz,1));


    }
    if (PassNum >= NumPasses - 1.5)
    {

        ret.rt1 = lerp(pow(config.diffuse, 2), ret.rt1,.5* dot(normal, -config.viewDir)*
        PerlinNoise(float3(config.uv, depth + TotalTime * timr)));

        ret.rt1 = saturate(float4(ret.rt1.xyz,1));
    }

    if (KeyShift && KeyControl && KeyAlt)
    {
        ret.rt1 = config.diffuse;
    }

    return ret;
}