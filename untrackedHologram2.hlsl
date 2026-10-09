#define MAX_DEPTH -25
#define MAX_LIGHTS 20

#define NUM_QUADRANTS 4
#define NORMAL_SAMPLE_RADIUS 12
#define OCCLUSION_MIN_DIFFERENCE 0.0001

cbuffer ScreenSizeBuffer : register(b0)
{

    float FrameTime;
    float DepthScale;
    float SceneAlpha;
    float SceneAlphaMul;

    
    float4x4 colorMatrix;
    float ShaderAlpha;
    float DepthOffset;
    float HueColorMix;
    float TotalTime;
 
    float SubFrame;
    float TotalSubFrames;
    float OffsetX;
    float OffsetY;

    float4x4 rotMatrix;
	
	
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


float scaleRange(float x, float2 rangeAB)
{
    return (x - rangeAB.x) / (rangeAB.y - rangeAB.x);
}

float scaleRangeN1(float x, float2 ab)
{
    return ((x - ab.x) / (ab.y - ab.x)) * 2.0 - 1.0;
}

float GoldenRandom(float seed)
{
    float phi = 1.618033988749895;
    return frac(seed * phi);
}

float rnd(float time)
{
    float seed = dot(12.9898, 78.233) + time * 10.0;
    return frac(sin(seed) * 43758.5453);
}

float hash3(float3 position)
{
    position = frac(sin(position) * 43758.5453);
    return frac(position.x + position.y * 57.0 + 113.0 * position.z);
}

float hash21D(float2 position)
{
    position = frac(sin(position) * 1.618033988749895);
    return frac(position.x + position.y * 57.0 + 113.0);
}

float2 hash2(float2 p)
{
    return frac(sin(float2(
        dot(p, float2(127.1, 311.7)),
        dot(p, float2(269.5, 183.3)))) * 43758.5453);
}

float2 noise2(float2 p)
{
    return frac(hash2(p) * 1.618033988749895);
}

float noise3(float3 position)
{
    position = frac(sin(position) * 43758.5453);
    return frac(position.x + position.y * 57.0 + 113.0 * position.z);
}

float noiseI(int value)
{
    // Use a large prime number to create a pattern that does not repeat easily
    float prime = 139.0;

    // Convert the integer value to a floating-point value for mathematical operations
    float floatValue = float(value);

    // Use the sin function to create a pseudo-random pattern
    float noiseValue = sin(floatValue * prime);

    // Use the fractional part of the value, so the result is in the range [0, 1]
    return frac(noiseValue * prime);
}


struct Photon
{
    float3 Position;
    float3 Color;
    float3 Energy;
};

#define MAX_PHOTONS 1024

struct PhotonCollection
{
    Photon Photons[MAX_PHOTONS];
    
};

// Permutation table. This is just a randomly arranged array of all 8-bit numbers,
// duplicated to avoid wrapping the index at 255 for each lookup. This needs to be 
// exactly the same for all instances on all platforms, so it's easiest to just keep 
// it as static explicit data.
int perm[512] = { 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183, 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183 };

float fade(float t)
{
    return t * t * t * (t * (t * 6 - 15) + 10);
}

float lerp1D(float t, float a, float b)
{
    return a + t * (b - a);
}

float lerp1D2(float a, float t)
{
    return (1.0 - t) * a + t * a;
}

// Gradient hash function
float grad(int hash, float x, float y, float z)
{
    int h = hash & 15;
    float u = h < 8 ? x : y;
    float v = h < 4 ? y : (h == 12 || h == 14 ? x : z);
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}

float perlinNoise(float2 uv)
{
    float2 grid = floor(uv);
    float2 f = frac(uv);
    f = f * f * (3.0 - 2.0 * f);

    float2 g00 = hash2(grid);
    float2 g10 = hash2(grid + float2(1, 0));
    float2 g01 = hash2(grid + float2(0, 1));
    float2 g11 = hash2(grid + float2(1, 1));

    float n00 = dot(g00, f);
    float n10 = dot(g10, f - float2(1, 0));
    float n01 = dot(g01, f - float2(0, 1));
    float n11 = dot(g11, f - float2(1, 1));

    float nx0 = lerp(n00, n10, f.x);
    float nx1 = lerp(n01, n11, f.x);

    return lerp(nx0, nx1, f.y);
}

float perlin(float3 position)
{
    float3 p = floor(position);
    float3 f = frac(position);
    f = f * f * (3.0 - 2.0 * f); // cubic fade
    float f2 = frac(FrameTime);
    float n = p.x + p.y * 157.0 + 113.0 * p.z;
    float g1 = grad(perm[int(n) % 256], f.x + f2, f.y, f.z);
    float g2 = grad(perm[int(n + 157.0) % 256], f.x + f2, f.y - 1.0, f.z);
    float g3 = grad(perm[int(n + 113.0) % 256], f.x, f.y + f2, f.z - 1.0);
    float g4 = grad(perm[int(n + 270.0) % 256], f.x, f.y - 1.0, f.z - f2 - 1.0);

    return lerp1D2(f.z + FrameTime - f2, lerp1D(f.y + f2 + TotalTime, lerp1D(f.x, g1, g2), lerp1D(f.x, g3, g4)));
}

float3 noise3D(float3 position)
{
    return noise(noise2(TotalTime) * 5.342343 + 10.12334324);
}


//fractal brownian motion
float FBM(float3 position, int octaves, float persistence)
{
    float total = 0;
    float amplitude = 1;
    for (int i = 0; i < octaves; i++)
    {
        total += noise(position) * amplitude;
        position *= 2;
        amplitude *= persistence;
    }
    return total;
}
float fbm(float3 position, int octaves, float persistence, float lacunarity)
{
    float total = 0.0;
    float amplitude = 1.0;
    float frequency = 1.0;

    for (int i = 0; i < octaves; i++)
    {
        total += perlin(position * frequency) * amplitude;
        amplitude *= persistence;
        frequency *= lacunarity;
    }

    return total;
}

float2 Random2(float2 seed)
{
    return float2(noise(seed.x), noise(seed.y));
}

float3 Random3(float3 seed)
{
    return float3(Random2(seed.xy), noise(seed.z));
}


struct RainbowAberration
{
    float4 GetRainbowColor(float4 color)
    {
        float lum = dot(color.rgb, float3(0.3, 0.59, 0.11));
        
        float4 val = rainbowMap.Sample(sampleTypeLinear, float2(lum, 0.5));
        // Mix the original color with the rainbow color
        return lerp(color, val, 0.5);
    }
    
    float4 GetRotated(float2 uv, float angle)
    {
        float2 uvRotated = float2(
            uv.x * cos(angle) - uv.y * sin(angle),
            uv.x * sin(angle) + uv.y * cos(angle)
        );
        return rainbowMap.Sample(sampleTypeLinear, uvRotated);
    }
    
    float4 Pixelate(float2 uv, float pixelSize = 0.02)
    {
        float2 pixelUV = floor(uv / pixelSize) * pixelSize;
        return rainbowMap.Sample(sampleTypeLinear, pixelUV);
    }
    
    float4 Vignette(float2 uv)
    {
        float2 toCenter = uv - 0.5;
        float vignette = 1.0 - saturate(dot(toCenter, toCenter) * 4.0);
        float4 color = rainbowMap.Sample(sampleTypeLinear, uv);
        return float4(color.rgb * vignette, color.a);
    }
    
    void RadialBlur(float2 uv, float blurAmount)
    {
        float2 center = float2(0.5, 0.5); // Center of the blur
        float4 color = float4(0, 0, 0, 0);
        for (int i = 0; i < 8; i++) // Number of samples
        {
            float2 offsetUV = lerp(uv, center, blurAmount * i / 7.0);
            color += rainbowMap.Sample(sampleTypeLinear, offsetUV) / 8.0;
        }
    }
    
    float4 GetDistortion(float2 uv)
    {
        float2 noise = noise2(uv * 0.1).xy * 2.0 - 1.0;
        float2 distortedUV = uv + noise * 0.05; // Adjust the factor to control distortion
        return rainbowMap.Sample(sampleTypeLinear, distortedUV);
    }
    
    float4 GetAberration(float2 uv)
    {
        float2 p;
        depthMap.GetDimensions(p.x, p.y);
        float2 offsetR = uv + float2(2, 0); // Red channel offset
        float2 offsetG = uv + float2(0, 2);
        float4 colorR = rainbowMap.Sample(sampleTypeLinear, offsetR);
        float4 colorG = rainbowMap.Sample(sampleTypeLinear, offsetG);
        float4 colorB = rainbowMap.Sample(sampleTypeLinear, uv); // Blue channel

        return float4(colorR.r, colorG.g, colorB.b, 1.0);
    }
    
    float4 GetRainbow(float2 uv,
        float tilingFactor, float frequency, float amplitude, float angle)
    {
        float2 uvc = uv * tilingFactor;
        uvc.y += sin(uvc.x * frequency) * amplitude;
        uvc = float2(
            uvc.x * cos(angle) - uvc.y * sin(angle),
            uvc.x * sin(angle) + uvc.y * cos(angle)
        );
        return rainbowMap.Sample(sampleTypeLinear, uvc);
    }
    
    float4 Get(float4 color)
    {
        float luminance = dot(color.rgb, float3(0.3, 0.59, 0.11));
        float3 rainbowColor = rainbowMap.Sample(sampleTypeLinear, luminance).rgb;
        float3 finalColor = lerp(color.rgb, rainbowColor, 0.5);
        return float4(finalColor, color.a);
    }
    
    float4 GetTiled(float2 uv, float tilingFactor)
    {
        float2 uvTiled = uv * tilingFactor;
        return rainbowMap.Sample(sampleTypeLinear, uvTiled);
    }
    float4 GetSinusoidal(float2 uv)
    {
        float frequency = 10.0; // Adjust to change frequency
        float amplitude = 0.1; // Adjust to change amplitude
        float2 uvWave = uv;
        uvWave.y += sin(uvWave.x * frequency) * amplitude;
        return rainbowMap.Sample(sampleTypeLinear, uvWave);
    }
};

float4 GetDepthNormal1(float depth, float2 texCoord, float scale, float sampleRadius, float4 lrud)
{
    float w, h;
    depthMap.GetDimensions(w, h);

    // Sample the depths at the neighboring pixels
    float4 depths;
    depths.x = 1-depthMap.Sample(sampleTypeMirror, texCoord + float2(-sampleRadius, 0)).r; // Left
    depths.y = 1-depthMap.Sample(sampleTypeMirror, texCoord + float2(sampleRadius, 0)).r; // Right
    depths.z = 1-depthMap.Sample(sampleTypeMirror, texCoord + float2(0, -sampleRadius)).r; // Up
    depths.w = 1-depthMap.Sample(sampleTypeMirror, texCoord + float2(0, sampleRadius)).r; // Down

    // Compute the differences in depth across the x and y directions
    float ddx = depths.y - depths.x;
    float ddy = depths.w - depths.z;

    // Compute the normal vector
    float3 normal = normalize(float3(scale * ddx, scale * ddy, 1));

    // Return the normal with the original depth
    float4 ret = float4(normal, depth);
    return ret;
}

float4 GetDepthNormal(float2 texCoord, float scale, float sampleRadius)
{
    float width, height;
    depthMap.GetDimensions(width, height);

    // Define offsets for the 8 surrounding points in texture space
    float2 offsets[8] =
    {
        float2(-1, -1), float2(0, -1), float2(1, -1),
        float2(-1, 0), float2(1, 0),
        float2(-1, 1), float2(0, 1), float2(1, 1)
    };

    // Sample the 8 surrounding depths
    float depths[8];
    for (int i = 0; i < 8; ++i)
    {
        float2 offsetTexCoord = texCoord + offsets[i] * (sampleRadius / float2(width, height));
        depths[i] = 1 - depthMap.Load(int3(offsetTexCoord.x * width, offsetTexCoord.y * height, 0)).r;
    }

    // Calculate the central depth
    float centralDepth = 1 - depthMap.Load(int3(texCoord.x * width, texCoord.y * height, 0)).r;

    // Calculate gradients using central differences
    float gradientX = (depths[2] + 2 * depths[4] + depths[7]) - (depths[0] + 2 * depths[3] + depths[5]);
    float gradientY = (depths[5] + 2 * depths[6] + depths[7]) - (depths[0] + 2 * depths[1] + depths[2]);

    // Normalize the gradients
    gradientX /= 4 * sampleRadius;
    gradientY /= 4 * sampleRadius;

    // Compute the normal using the gradients
    float3 normal = normalize(float3(gradientX, gradientY, scale));
    
    normal = float3(normal.x, normal.y, normal.z).z*100;
    
    return float4(normal, centralDepth);
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

struct Light
{
    float3 SpecularColor;
    float3 Position;
    float3 LightColor;
    float Intensity;
    float Radius;
    float Range;
    float Exponent;
    float FresnelPower;
    float Shininess;
    float FresnelReflectance;
    
    float GetRefractionIncident(float3 viewDir, float3 pixelPos)
    {
        return dot(viewDir, normalize(Position - pixelPos));
    }
    float3 GetRefractionAmount(float3 viewDir, float3 pixelPos, float3 normal, float rfi)
    {
        return refract(-normal, normalize(pixelPos + viewDir), rfi);
    }
    
    float3 GetRefractionVector(Light light, float3 viewDir, float3 pixelPos, float3 normal)
    {
        // Get the refraction incident angle
        float rfi = light.GetRefractionIncident(viewDir, pixelPos);

        // Calculate and return the refraction vector
        return light.GetRefractionAmount(viewDir, pixelPos, normal, rfi);
    }
    
    float3 ComputeColorWithRefraction(float diffuseColor, float3 refractionVector)
    {
        return RotateHue(diffuseColor, sin(refractionVector.z));
    }

    
    float GetFresnelSchlick(float3 viewDir,
        float3 pixelPos, float3 normal)
    {
        float rfi = GetRefractionIncident(viewDir, pixelPos);
        return FresnelSchlick2(rfi, viewDir, normal, FresnelPower);
    }
    
    float FresnelSchlick(float rfi, float3 viewDir, float3 normal)
    {
        float f0 = (1 - rfi) / (1 + rfi);
        f0 = f0 * f0;
    
        float cosTheta = (dot(viewDir, normal), 0.0);

        return f0 + (1 - f0) * pow(1 - cosTheta, FresnelPower);
    }
};

struct LightAnimator
{
    float Time; // Animation time parameter
    float Speed; // Speed of the animation
    float FlickerFrequency; // Frequency of flickering effect
    float ScatteringIntensity; // Intensity of scattering effect
    
    // Simple random function based on fractional part of sine
    float rand(float seed)
    {
        return frac(sin(seed * 12.9898 + 78.233) * 43758.5453);
    }
    
    // Animate a single light source within its quadrant
    void AnimateLight(inout Light light)
    {
        // Determine the quadrant of the light source
        float signX = sign(light.Position.x);
        float signY = sign(light.Position.y);

        // Compute animation offsets using sine and cosine functions
        float offsetX = signX * (0.5 * sin(Time * Speed + light.Position.x));
        float offsetY = signY * (0.5 * sin(Time * Speed + light.Position.y));

        // Update light position within the quadrant
        light.Position.x = signX * 0.5 + offsetX;
        light.Position.y = signY * 0.5 + offsetY;

        // Keep position within screen bounds
        light.Position.x = clamp(light.Position.x, -0.5, 0.5);
        light.Position.y = clamp(light.Position.y, -0.5, 0.5);

        // Simulate light flickering effect
        float flicker = sin(Time * FlickerFrequency + light.Position.x);
        light.Intensity *= (1.0 + flicker * 0.1); // 10% intensity variation

        // Simulate light scattering effect
        float3 scatterDirection =
            float3(rand(Time + light.Position.x),
                   rand(Time + light.Position.y), 0);
        
        scatterDirection = normalize(scatterDirection);
        light.Position += scatterDirection * ScatteringIntensity * flicker;
    }

    // Animate an array of lights
    void AnimateLights(inout Light lights[MAX_LIGHTS])
    {
        for (int i = 0; i < MAX_LIGHTS; i++)
        {
            AnimateLight(lights[i]);
        }
    }

};


float4 GetDepthCrossLRUD(Texture2D tex, float2 texCoord, float sampleRadius)
{
    float w, h;
    tex.GetDimensions(w, h);
    float2 texelSize = float2(1 / w, 1 / h);
    
    float depthL = (1 - tex.Sample(sampleTypeMirror, texCoord - sampleRadius * float2(texelSize.x, 0)).r) * MAX_DEPTH;
    float depthR = (1 - tex.Sample(sampleTypeMirror, texCoord + sampleRadius * float2(texelSize.x, 0)).r) * MAX_DEPTH;
    float depthU = (1 - tex.Sample(sampleTypeMirror, texCoord - sampleRadius * float2(0, texelSize.y)).r) * MAX_DEPTH;
    float depthD = (1 - tex.Sample(sampleTypeMirror, texCoord + sampleRadius * float2(0, texelSize.y)).r) * MAX_DEPTH;
	
    
    return float4(
        depthL,
        depthR,
        depthU,
        depthD);
}

struct LightCast
{
    Light Source;
    float DiffuseComponent;
    float SpecularComponent;
    float RefractionIncidentAngle;
    float3 FresnelTerm;
    float3 Specular;
    float3 Diffuse;
    float3 LightAmount;
    float3 LightColor;
    float3 TotalLightCast;
    float3 RefractionAmount;
    float3 RotatedLight;
    float4 Scattering;
    
    
};


float FractalNoise(
    float3 position, int octaves,
    float frequency, float amplitude,
    float lacunarity, float persistence)
{
    float sum = 0.0;
    float weight = 1.0;
    for (int i = 0; i < octaves; ++i)
    {
        sum += noise3(position * frequency) * amplitude * weight;
        frequency *= lacunarity;
        weight *= persistence;
    }
    return sum;
}

float4 ScatterLight(float3 position,
    float3 lightDirection,
    float3 lightColor,
    float scatteringAmount)
{
    float noise = FractalNoise(position, 4, 0.5, 1.0, 2.0, 0.5);
    float scattering = scatteringAmount * noise;
    return float4(lightColor * scattering, 1);
}


float3 ScatterLight(float3 direction, float3 color, float scatterAmount, float spin)
{
    // Get random noise based on direction
    float noise = noiseI(int(direction.x * 7.04765358164 + direction.y * 1.618033988749895));

    // Calculate scatter direction with random noise and spin
    float3 scatterDirection = normalize(direction + noise * scatterAmount);
    scatterDirection = float3(scatterDirection.x * cos(spin) - scatterDirection.y * sin(spin),
                              scatterDirection.x * sin(spin) + scatterDirection.y * cos(spin),
                              scatterDirection.z);

    // Return scattered color
    return color * dot(scatterDirection, direction);
}


float WavePattern(float2 uv, float frequency, float amplitude, float speed, float offset)
{
    return sin(frequency * (uv.x + uv.y) + speed * TotalTime + offset) * amplitude;
}

float3 ScatterLightScreen(float2 uv, float scatterAmount, float3 color = float3(1, 0.8, 0.6))
{
    float3 position = float3(uv.x, uv.y, 0.0); // Position in texture space
    float3 lightDirection = normalize(float3(0.0, 0.0, 0.0)); // Direction of the light
    float3 lightColor = float3(1.0, 0.8, 0.6); // Color of the light
    float scatteringAmount = 0.2; // Amount of scattering

    return ScatterLight(position, lightDirection, lightColor, scatteringAmount);
}

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

float3 CookTorranceBRDF(float3 N, float3 V, float3 L, float3 F0, float roughness)
{
    // Half vector
    float3 H = normalize(V + L);
    
    // Fresnel term
    float3 F = FresnelSchlick(F0, H, N, V);
    
    // Geometric attenuation
    float alpha = roughness * roughness;
    float G = GeometrySmith(N, V, L, alpha);
    
    // Normal distribution function
    float NdotH = saturate(dot(N, H));
    float D = alpha / (3.14159265 * pow(NdotH * NdotH * (alpha - 1) + 1, 2.0));
    
    // Microfacet BRDF
    float3 nominator = D * G * F;
    float denominator = 4 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0) + 0.001; // Prevent division by zero
    
    return nominator / denominator;
}

float3 HolographicMicroscopyEffect(float4 normalDepth, float4 color, float2 texCoord, LightCast light)
{
    int w, h;
    depthMap.GetDimensions(w, h);
    float3 worldPos = float3(texCoord / (1 / float2(w, h)), normalDepth.w);
    float3 camDir = worldPos - camDir;
    float3 lightDir = worldPos - light.Source.Position;
    
    
    
    // Calculate Fresnel reflection
    float3 viewDir = float3(0.0, 0.0, abs(cos(TotalTime)) * 0.5 + 1); // Assuming view direction
    
    // Apply multiple wave patterns to simulate interference
    float wave1 = WavePattern(texCoord, 98, FrameTime * 9127, FrameTime * 1201.6020, FrameTime * 120.031 + cos(FrameTime * TotalTime * 0.03 + cos(TotalTime * 0.3)));
    float wave2 = WavePattern(texCoord, FrameTime * 468, 243, 0.23, 0.4221 + cos(TotalTime * 120.03 + cos(TotalTime * 0.3)));
    float wave3 = WavePattern(texCoord, normalDepth.w * 100 - FrameTime * 900, 23343, 23120.92, FrameTime * 120.08212 + cos(TotalTime * 0.6 + cos(TotalTime * 0.003)));
    float wave = wave1 + wave2 + wave3;
   
    // Apply distortion
    float2 distortedCoord = texCoord + float2(wave1 * 0.002, wave2 * FrameTime * 0.09807980902);
    float2 distortedCoord2 = texCoord + float2(wave1 * 0.232, wave2 * FrameTime * 1.09807980902);
    
    // Sample again with distorted coordinates
    float4 distortedColor = depthMap.Sample(sampleTypeLinear, distortedCoord).r;
    float4 depths = GetDepthCrossLRUD(depthMap, texCoord, 10);
    
    float3 fresnelEffect = FrameTime *
            FresnelSchlick2(float3(FrameTime * distortedColor.xyz),
                viewDir, normalDepth.xyz,
                light.Source.FresnelPower);
    // Combine color with Fresnel reflection and wave pattern
    float4 finalColor = float4(FrameTime * distortedColor.rgb * (FrameTime * 1.0 + fresnelEffect), 1);
    finalColor += float4(wave1, exp(wave2), FrameTime * wave3, FrameTime);

    // Apply color shifting
    float3 hsv = RGBtoHSV(finalColor.rgb);
    float3 rot = RotateAroundAxis(hsv, normalize(fresnelEffect), length(distortedColor) - length(color));
    rot = RotateAroundAxis(rot, normalize(light.Source.Position - worldPos), length(distortedColor) - length(color));
    rot = RotateAroundAxis(rot, normalize(viewDir), length(distortedColor.xyz * viewDir.xyz) - length(color));
    
    return HSVtoRGB(rot);
}


float3 HolographicMicroscopyEffect2(Texture2D tex, float2 texCoord, float4 depthNormal, float3 viewDir, LightCast lightCast)
{
    
    // Apply multiple wave patterns to simulate interference
    float wave1 = WavePattern(texCoord, TotalTime * 19, depthNormal.w, 0.6020, 0.031 + cos(TotalTime * 0.03 + cos(TotalTime * 0.3)));
    float wave2 = WavePattern(texCoord, TotalTime + 18, 43, texCoord.x, 0.04221 + cos(TotalTime * 0.03 + cos(TotalTime * 0.3)));
    float wave3 = WavePattern(texCoord, depthNormal.w, 43, 0.92, 0.08212 + cos(TotalTime * 0.6 + cos(TotalTime * 0.003)));
    float wave = wave1 + wave2 + wave3;
   
    // Apply distortion
    float2 distortedCoord = texCoord + float2(wave1 * 0.02, wave2 * 0.09807980902);
    
    // Sample again with distorted coordinates
    float4 distortedColor = depthMap.Sample(sampleTypeLinear, distortedCoord);
    float3 fresnelEffect = FresnelSchlick(float3(distortedColor.xyz), viewDir, depthNormal.xyz);
    // Combine color with Fresnel reflection and wave pattern
    float4 finalColor = float4(distortedColor.rgb * (1.0 + fresnelEffect), 1);
    finalColor += float4(wave1, wave2, wave3, 0.0);

    
    // Apply color shifting
    float3 hsv = RGBtoHSV(finalColor.rgb);
    float3 rot = RotateAroundAxis(hsv, normalize(fresnelEffect), TotalTime * 0.5);
    return HSVtoRGB(rot);
}



struct Aberration
{
    float2 AberrationOffset[3];
    //texelSize * scale * length(lightCast.RefractionAmount)
    float2 TexCoordRefraction;
    float3 ScatterColor;
    float3 ScatterVector;
    float3 ScatterDir;
    
    float4 FresnelLRUD[3];
    float4 FresnelDepthNormal[3];
    
    float3 FresnelEffect[3];
    float4 FresnelEffectColor[3];
    
    float3 FresnelSchlick[3];
    float3 FresnelNormal[3];
    
    
    float ScaleChromaticAberration(float depth, float minScale, float maxScale)
    {
        // Scale the depth value to be in the range [0, 1]
        float normalizedDepth = (depth / MAX_DEPTH);

        // Scale the chromatic aberration amount based on depth
        return lerp(minScale, maxScale, normalizedDepth);
    }


    
    void GetChromaticAberration(
            Texture2D tex, float2 uv,
            float4 DC,
            float4 depthNormal, float3 viewPos, float3 viewDir,
            LightCast lightCast, out Aberration ret)
    {
        float w, h;
        tex.GetDimensions(w, h);
        float2 texelSize = float2(1.0f / w, 1.0f / h);
    
        float scale = ScaleChromaticAberration(depthNormal.w, 0, MAX_DEPTH);
    
        ret.TexCoordRefraction = texelSize * scale * length(lightCast.RefractionAmount);
    
        float3 lightToViewer = (viewPos - lightCast.Source.Position);
        float3 lightToViewerDir = normalize(lightToViewer);
    
        ret.ScatterColor = diffuseMap.Sample(sampleTypeMirror, uv).xyz;
        ret.ScatterDir = normalize(ret.ScatterColor);
        ret.ScatterVector = ret.ScatterDir * length(lightCast.Scattering);
    
        float3 rotatedLight = RotateAroundAxis(ret.ScatterVector, lightToViewerDir,
            lightCast.RefractionIncidentAngle);
        float3 proj = ScatterLightScreen(uv, 3, lightCast.TotalLightCast);
    
        float2 redOffset = proj.r;
        float2 greenOffset = proj.g;
        float2 blueOffset = proj.b;
    
        ret.AberrationOffset[0] = uv + redOffset;
        ret.AberrationOffset[1] = uv + greenOffset;
        ret.AberrationOffset[2] = uv + blueOffset;
    
        ret.FresnelLRUD[0] = GetDepthCrossLRUD(tex, ret.AberrationOffset[0], length(texelSize));
        ret.FresnelLRUD[1] = GetDepthCrossLRUD(tex, ret.AberrationOffset[1], length(texelSize));
        ret.FresnelLRUD[2] = GetDepthCrossLRUD(tex, ret.AberrationOffset[2], length(texelSize));

        ret.FresnelDepthNormal[0] = GetDepthNormal1(depthNormal.w, ret.AberrationOffset[0], MAX_DEPTH, length(texelSize), ret.FresnelLRUD[0]);
        ret.FresnelDepthNormal[1] = GetDepthNormal1(depthNormal.w, ret.AberrationOffset[1], MAX_DEPTH, length(texelSize), ret.FresnelLRUD[1]);
        ret.FresnelDepthNormal[2] = GetDepthNormal1(depthNormal.w, ret.AberrationOffset[2], MAX_DEPTH, length(texelSize), ret.FresnelLRUD[2]);
    
        ret.FresnelEffectColor[0] = tex.Sample(sampleTypeMirror, ret.AberrationOffset[0]);
        ret.FresnelEffectColor[1] = tex.Sample(sampleTypeMirror, ret.AberrationOffset[1]);
        ret.FresnelEffectColor[2] = tex.Sample(sampleTypeMirror, ret.AberrationOffset[2]);
   /*
        ret.FresnelEffect[0] = HolographicMicroscopyEffect(ret.FresnelDepthNormal[0], ret.FresnelEffectColor[0], ret.AberrationOffset[0], lightCast);
        ret.FresnelEffect[1] = HolographicMicroscopyEffect(ret.FresnelDepthNormal[1], ret.FresnelEffectColor[1], ret.AberrationOffset[1], lightCast);
        ret.FresnelEffect[2] = HolographicMicroscopyEffect(ret.FresnelDepthNormal[2], ret.FresnelEffectColor[2], ret.AberrationOffset[2], lightCast);
                           
        ret.FresnelNormal[0] = HolographicMicroscopyEffect2(tex, ret.AberrationOffset[0], ret.FresnelDepthNormal[0], viewDir, lightCast);
        ret.FresnelNormal[1] = HolographicMicroscopyEffect2(tex, ret.AberrationOffset[1], ret.FresnelDepthNormal[1], viewDir, lightCast);
        ret.FresnelNormal[2] = HolographicMicroscopyEffect2(tex, ret.AberrationOffset[2], ret.FresnelDepthNormal[2], viewDir, lightCast);
        
*/
        
        ret.FresnelEffect[0] = float3(0, 0, 0);
        ret.FresnelEffect[1] = float3(0, 0, 0);
        ret.FresnelEffect[2] = float3(0, 0, 0);
        ret.FresnelNormal[0] = float3(0, 0, 0);
        ret.FresnelNormal[1] = float3(0, 0, 0);
        ret.FresnelNormal[2] = float3(0, 0, 0);
                   
        ret.FresnelSchlick[0] = FresnelSchlick2(ret.FresnelEffectColor[0].rgb, viewDir, ret.FresnelNormal[0], lightCast.Source.FresnelPower);
        ret.FresnelSchlick[1] = FresnelSchlick2(ret.FresnelEffectColor[1].rgb, viewDir, ret.FresnelNormal[1], lightCast.Source.FresnelPower);
        ret.FresnelSchlick[2] = FresnelSchlick2(ret.FresnelEffectColor[2].rgb, viewDir, ret.FresnelNormal[2], lightCast.Source.FresnelPower);
    
    }

};







float valueNoise(float2 uv)
{
    float2 grid = floor(uv);
    float2 v = frac(uv);
    float h0 = frac(grid.x + grid.y * 57.0) * 43.0;
    float h1 = frac(grid.x + 1.0 + grid.y * 57.0) * 43.0;
    float h2 = frac(grid.x + (grid.y + 1.0) * 57.0) * 43.0;
    float h3 = frac(grid.x + 1.0 + (grid.y + 1.0) * 57.0) * 43.0;
    float fx = smoothstep(0.0, 1.0, v.x);
    float fy = smoothstep(0.0, 1.0, v.y);
    return lerp(lerp(h0, h1, fx), lerp(h2, h3, fx), fy);
}

float3 ChromaticAberration(Texture2D tex, float2 uv, float amount)
{
    float3 colorR = tex.Sample(sampleTypeMirror, uv + float2(amount, 0)).rgb;
    float3 colorG = tex.Sample(sampleTypeMirror, uv).rgb;
    float3 colorB = tex.Sample(sampleTypeMirror, uv - float2(amount, 0)).rgb;
    return float3(colorR.r, colorG.g, colorB.b);
}



//float scatterAmount = 0.2;
//float spin = 0.5;
float4 ApplyChromaticAberration(float2 uv, float amount, float3 lightPos, float3 curPixel,
    float scatterAmount, float spin)
{
    float3 color = diffuseMap.Sample(sampleTypeLinear, uv).rgb;

    // Apply chromatic aberration
    color = ChromaticAberration(diffuseMap, uv, amount);

    // Apply advanced light scattering
    float3 lightDirection = normalize(lightPos - curPixel);
    
    color = ScatterLight(lightDirection, color, scatterAmount, spin);

    return float4(color, 1.0);
}


float3 Tonemap(float3 color)
{
    return color / (color + 1);
}

float4 GaussianBlur(Texture2D tex, float2 uv)
{
    // Define the kernel for the Gaussian blur
    const float kernel[3][3] =
    {
        { 0.0625, 0.125, 0.0625 },
        { 0.125, 0.25, 0.125 },
        { 0.0625, 0.125, 0.0625 }
    };

    // Calculate the texture size
    float2 texSize;
    tex.GetDimensions(texSize.x, texSize.y);

    // Convert the texture coordinate to an integer position
    int2 texelCoord = int2(uv * texSize);

    // Apply the Gaussian blur using the kernel
    float4 sum = float4(0, 0, 0, 0);
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            int2 offset = int2(x, y);
            sum += tex.Load(int3(texelCoord + offset, 0)) * kernel[y + 1][x + 1];
        }
    }
    return sum;
}

float4 DepthOfField(Texture2D colorTex, Texture2D depthTex, float2 uv, float focusDistance, float blurRadius)
{
    float depth = depthTex.Sample(sampleTypeMirror, uv).r;
    float blurAmount = saturate(abs(depth - focusDistance) / blurRadius);
    
    float4 color = colorTex.Sample(sampleTypeMirror, uv);
    float4 blurredColor = GaussianBlur(colorTex, uv); // Using the GaussianBlur function from earlier

    return lerp(color, blurredColor, blurAmount);
}

float4 Bloom(float2 uv, Texture2D sceneTex, Texture2D bloomTex, float intensity)
{
    float4 sceneColor = sceneTex.Sample(sampleTypeMirror, uv);
    float4 bloomColor = bloomTex.Sample(sampleTypeMirror, uv);
    return sceneColor + bloomColor * intensity;
}







float CalculateDepthDensity(float2 texCoord, float _depthScale, float sampleWidth, float threshold, float curveExponent, float4 depthCross, float4 depthNormal)
{
    // Sample the depth at the current pixel
    float centerDepth = depthNormal.w;
	
    float difference = abs(depthCross.x - centerDepth) +
                       abs(depthCross.y - centerDepth) +
                       abs(depthCross.z - centerDepth) +
                       abs(depthCross.w - centerDepth);
    
    float density = difference * _depthScale;
    
    if (density > threshold)
    {
        return pow(density, curveExponent);
    }
    return 0;
};




float3 CalcNormals(float2 texCoord, float2 texelSize, float3 curPixel,
    float3 viewDir, float3 normal, float4 dc, float4 dn, float reflectMix, float yiqMix)
{
    float density = CalculateDepthDensity(texCoord, MAX_DEPTH, 240, 0, 112, dc, dn);;
	
    float3 F0 = float3(density, density, density);

    float3 fresnel2 = FresnelSchlick(FresnelSchlick(F0, viewDir, normal), viewDir, normal);
    float3 dX2 = float3(1.0, 0.0, ddx(fresnel2.x));
    float3 dY2 = float3(0.0, 1.0, ddy(fresnel2.y));
	
	// Compute the cross product to get the normal
    float3 fresNormal = normalize(cross(normalize(dX2), normalize(dY2)));
    fresNormal = float3(fresNormal.x, fresNormal.y, -abs(fresNormal.z));
	
    float3 distortedReflectionDir = reflect(FresnelSchlick(fresNormal,
        -reflect(viewDir, normal), normal), viewDir).xyz;
	
    float3 v = diffuseMap.Sample(sampleTypeLinear,
        texCoord + reflect(viewDir, distortedReflectionDir).xy * texelSize).xyz;
	
    float3 yiq = RGBToYIQ(curPixel);
    float3 rgb = YIQtoRGB(RotateAroundAxis(yiq, distortedReflectionDir, TotalTime * 0.5));
    return
		lerp(
			lerp(
				float4(curPixel, 1),
				float4(v.rgb, 1),
				saturate(reflectMix)),
			float4(rgb, 1.0f), saturate(yiqMix)).xyz;
}



float LightFalloff(float distance, float radius, float exponent)
{
    float falloff = pow(1.0 - clamp(distance / radius, 0.0, 1.0), exponent);
    return falloff;
}


float NonLinearAnimation(float time, float exponent)
{
    return pow(time, exponent);
}

float4 AdjustContrast(float4 color, float exponent)
{
    return float4(pow(color.rgb, float3(exponent, exponent, exponent)), color.a);
}


float GetSubSurfaceScattering(float thickness, float concentration)
{
    float _SSSConcentration = concentration;
    float _SSSScale = pow(_SSSConcentration, thickness);
    return exp(-thickness * _SSSConcentration) * _SSSScale;
}



float Fresnel(float3 normal, float3 viewDir, float power)
{
    return pow(1.0 - dot(normal, viewDir), power);
}


#define SCATTER_NUM_STEPS 3
#define ILLUMINATE_NUM_RAYS 7
#define ILLUMINATE_RAY_LENGTH 25
#define MAX_SPIN 3.14159265/2

float GetRandomSpin(int rayIndex)
{
    // Seed the random function with ray index
    float seed = (float) rayIndex * 98765.4321;

    // Generate random value
    float spin = frac(cos(seed) * 95123.4567);

    // Scale and bias to range [-MAX_SPIN, MAX_SPIN]
    return spin * 2.0 * MAX_SPIN - MAX_SPIN;
}

float3 GetRandomDirection(int rayIndex)
{
    // Seed the random function with ray index
    float seed = (float) rayIndex * 12345.6789;

    // Generate random values
    float x = frac(sin(seed) * 43758.5453);
    float y = frac(cos(seed) * 24634.1239);
    float z = frac(sin(seed * 0.1) * 65321.7890);

    // Scale and bias to range [-1, 1]
    return float3(x * 2.0 - 1.0, y * 2.0 - 1.0, z * 2.0 - 1.0);
}



float3 ScatterFunction(float3 direction, int rayIndex)
{
    // Get a random direction based on the ray index
    float3 randomDirection = GetRandomDirection(rayIndex);

    // Apply some noise to the random direction
    float noiseValue = noiseI(rayIndex);

    // Scale and bias the noise value
    noiseValue = noiseValue * 2.0 - 1.0;

    // Mix the original direction with the random direction based on noise
    float3 scatteredDirection = lerp(direction, randomDirection, noiseValue);

    return normalize(scatteredDirection);
}


float3 ScatterRay(float3 origin, float3 direction, float spinAmount, float rayLength)
{
    float3 scatteredLight = float3(0.0, 0.0, 0.0);
    float3 position = origin;
    float stepSize = rayLength / SCATTER_NUM_STEPS;

    for (int i = 0; i < SCATTER_NUM_STEPS; i++)
    {
        // Sample noise texture to introduce randomness
        float noiseValue = noiseI(i);

        // Apply spin to the direction
        float angle = spinAmount * i / SCATTER_NUM_STEPS;
        float3 rotatedDirection = float3(
            direction.x * cos(angle) - direction.y * sin(angle),
            direction.x * sin(angle) + direction.y * cos(angle),
            direction.z
        );

        // Accumulate scattered light along the ray
        scatteredLight += ScatterFunction(rotatedDirection, noiseValue); // You may define this function

        // Move along the ray
        position += rotatedDirection * stepSize;
    }

    return scatteredLight;
}

float3 Illuminate(float3 pixelPosition, float3 lightPosition, float3 generalDirection)
{
    float3 result = float3(0.0, 0.0, 0.0);

    for (int i = 0; i < ILLUMINATE_NUM_RAYS; i++)
    {
        float3 randomDirection = GetRandomDirection(i); // You may define this function
        float3 rayDirection = normalize(generalDirection + randomDirection);
        float spinAmount = GetRandomSpin(i); // You may define this function

        result += ScatterRay(pixelPosition, rayDirection, spinAmount, ILLUMINATE_RAY_LENGTH);
    }

    return result / ILLUMINATE_NUM_RAYS; // Average the result
}


struct Camera
{
    float3 Position;
    float3 Direction;
};

struct Scene
{
    PS_INPUT Input;
    Camera View;
    Light Lights[MAX_LIGHTS];
    
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



struct SceneManager
{
    void CreateLights(const float2 screenSize, out Light lights[MAX_LIGHTS])
    {
        // Common properties
        const float shininess = 0.2;
        const float3 white = float3(1, 1, 1);
        const float radius = 1211.0;
        const float range = 13000.0;
        const float exponent = 0.75100;
        const float fresnelPower = 5;
        const float depth = 1000;
        const float fresnelReflectance = 0.3;
        
        // Quadrant positions
        const float2 positions[NUM_QUADRANTS] =
        {
            float2(-0.5, 0.5),
            float2(0.5, 0.5),
            float2(-0.5, -0.5),
            float2(0.5, -0.5),
        };

        const float2 groupKernel[] =
        {
            float2(0, 0),
            float2(-.25, .25),
            float2(.25, .25),
            float2(.25, -.25),
            float2(-.25, -.25),
        };
        
        // Create lights for each quadrant
        for (int i = 0; i < 4; i++)
        {
            const float2 qMid = screenSize * .5;
            for (int j = 0; j < MAX_LIGHTS / 4; j++)
            {
                lights[j + i * (MAX_LIGHTS / 4)].SpecularColor = white;
                lights[j + i * (MAX_LIGHTS / 4)].Position = float3(qMid + qMid * positions[i] + qMid * groupKernel[j], depth);
                lights[j + i * (MAX_LIGHTS / 4)].Intensity = white;
                lights[j + i * (MAX_LIGHTS / 4)].LightColor = white;
                lights[j + i * (MAX_LIGHTS / 4)].Radius = radius;
                lights[j + i * (MAX_LIGHTS / 4)].Range = range;
                lights[j + i * (MAX_LIGHTS / 4)].Exponent = exponent;
                lights[j + i * (MAX_LIGHTS / 4)].FresnelPower = fresnelPower;
                lights[j + i * (MAX_LIGHTS / 4)].Shininess = shininess;
                lights[j + i * (MAX_LIGHTS / 4)].FresnelReflectance = fresnelReflectance;
                
            }
        }
    }
    
    void Create(out Scene scene,
        PS_INPUT input)
    {
        scene.Input = input;
        scene.View.Position = float3(0, 0, 1000);
        scene.View.Direction = float3(0, 0, -1);
        float w, h;
        depthMap.GetDimensions(w, h);
        float2 dim = float2(w, h);
        CreateLights(dim, scene.Lights);
        
        scene.ScreenSize = float2(w, h);
        scene.TexelSize = float2(1 / w, 1 / h);
        scene.UV = input.TexCoord;
        scene.Depth = (1 - depthMap.Sample(sampleTypeMirror, input.TexCoord).r) * MAX_DEPTH;
        
        scene.DepthLRUD = GetDepthCrossLRUD(depthMap,
                    scene.UV, NORMAL_SAMPLE_RADIUS);
     
        scene.DN = GetDepthNormal(scene.UV, MAX_DEPTH, NORMAL_SAMPLE_RADIUS);
        
        scene.Normal = float3(scene.DN.xyz);
        scene.PixelPos = float3(scene.UV * scene.ScreenSize, scene.Depth);
        
        scene.DiffuseColor = diffuseMap.Sample(
            sampleTypeLinear, input.TexCoord);
        
        float4 occ = abs(min(scene.Depth - scene.DepthLRUD, 0));
        int c = 0;
        [unroll]
        for (int i = 0; i < 4; ++i)
        {
            c += (occ[i] < OCCLUSION_MIN_DIFFERENCE) ? 1 : 0;
        }
        scene.OcclusionAmount = abs(0.25f * float(c));
        scene.OcclusionsLRUD = occ * float(c);
        scene.Thickness = 0.2390f;
        //min(1, (1 - scene.OcclusionAmount) + 0.1);
        scene.Concentration = 0.990f;
        scene.AmbientColor = 0.15;

    }
    
    float3 DiffuseFresnel(float3 normal, float3 lightDir, float3 viewDir, float3 FresnelReflectance)
    {
        float3 reflectDir = reflect(-lightDir, normal);
        float fresnel = FresnelSchlick(FresnelReflectance, viewDir, normal);
        return max(dot(normal, lightDir), 0.0) * (1.0 - fresnel);
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
    
    float4 Illuminate(Scene scene, out LightCast CastedLight[MAX_LIGHTS])
    {
        for (int x = 0; x < MAX_LIGHTS; x++)
        {
            Light light = scene.Lights[x];
        
            float3 viewDir = scene.View.Direction;
            float3 lightToPixelDir = normalize(light.Position - scene.PixelPos);
            float3 reflectDir = normalize(reflect(-lightToPixelDir, scene.Normal));
            float diffuseComponent = max(dot(scene.Normal, lightToPixelDir), 0);

            float specularComponent =
                pow(max((dot(viewDir, reflectDir)), 0.0), light.Shininess);

            float3 diffuseFresnel = DiffuseFresnel(scene.Normal, lightToPixelDir, viewDir, light.FresnelReflectance);
            float3 fresnelTerm = fresnelSchlick(scene.View.Direction,
                scene.PixelPos, scene.Normal, light.FresnelPower);
            
            float falloff = LightFalloff(distance(scene.PixelPos, light.Position)
                - light.Range, light.Radius, light.Exponent);

            float3 specularLight = specularComponent * light.SpecularColor * fresnelTerm * falloff;
            float3 diffuseLight = diffuseComponent * light.LightColor * (1 - fresnelTerm) * falloff;

            float refractionIncidentAngle = dot(viewDir, normalize(scene.PixelPos - light.Position));
            float3 refractionAmount =
            refract(-scene.Normal, normalize(scene.PixelPos + viewDir), refractionIncidentAngle);
        
            // Subsurface Scattering
            float scatterScale = pow(scene.Concentration, scene.Thickness);
            float scatterComponent = exp(-scene.Thickness * scene.Concentration) * scatterScale;
            float3 scattering = scatterComponent * light.LightColor * (1 - fresnelTerm);

            // Total Lighting
            float3 totalLightCast = diffuseLight + specularLight + scattering;
        
            float3 refractedLightCast = totalLightCast * length(refractionAmount) * (1 - fresnelTerm);
        
            float3 rotatedLight =
                RotateAroundAxis(refractedLightCast,
                    normalize(scene.PixelPos - scene.View.Position),
                    diffuseComponent);

            
            /////////////
            ///DEBUG TESTS
            // Test Diffuse Component
            if (diffuseComponent < 0 || diffuseComponent > 1)
            {
                return float4(1, 0, 0, 1);
            } // Red

        // Test Specular Component
            if (specularComponent < 0 || specularComponent > 1)
            {
                return float4(0, 1, 0, 1);
            } // Green

        // Test Fresnel Term
            if (any(fresnelTerm < 0) || any(fresnelTerm > 1))
            {
                return float4(0,0,1,1);
            } // Blue

        // Test Falloff
            if (falloff < 0 || falloff > 1)
            {
                return float4(1, 1, 0, 1);
            } // Yellow

        // Test Refraction Incident Angle (if applicable)
            if (refractionIncidentAngle < -1 || refractionIncidentAngle > 1)
            {
                return float4(1, 0, 1, 1);
            } // Magenta

        // Test Scatter Component
            if (scatterComponent < 0 || scatterComponent > 1)
            {
                return float4(0, 1, 1, 1);
            } // Cyan
            
        // Test Light Color
            if (any(light.LightColor < 0) || any(light.LightColor > 1))
            {
                return float4(0.5, 0, 0, 1);
            } // Dark Red

        // Test Specular Color
            if (any(light.SpecularColor < 0) || any(light.SpecularColor > 1))
            {
                return float4(0, 0.5, 0, 1);
            } // Dark Green

        // Test Light Position
            if (any(isnan(light.Position)) || any(isinf(light.Position)))
            {
                return float4(0, 0, 0.5, 1);
            } // Dark Blue

        // Test Scene Normal
            if (length(scene.Normal) != 1)
            {
                return float4(1, 0.5, 0, 1);
            } // Orange

        // Test View Direction
            if (length(scene.View.Direction) != 1)
            {
                return float4(0.5, 0, 0.5, 1);
            } // Purple

        // Test Scattering
            if (any(scene.DiffuseColor * float4(scattering, 0.8) < 0) || any(scene.DiffuseColor * float4(scattering, 0.8) > 1))
            {
                return float4(0.5, 0.5, 0, 1);
            } // Olive

        // Test Total Light Cast
            if (any(totalLightCast < 0) || any(totalLightCast > 1))
            {
                return float4(0, 0.5, 0.5, 1);
            } // Teal

            
            // Storing the calculated values
            CastedLight[x].Source = light;
            CastedLight[x].LightColor = scene.DiffuseColor;
            CastedLight[x].DiffuseComponent = diffuseComponent;
            CastedLight[x].SpecularComponent = specularComponent;
            CastedLight[x].RefractionIncidentAngle = refractionIncidentAngle;
            CastedLight[x].RefractionAmount = refractionAmount;
            CastedLight[x].FresnelTerm = fresnelTerm;
            CastedLight[x].Specular = specularLight;
            CastedLight[x].Diffuse = diffuseLight;
            CastedLight[x].Scattering = scene.DiffuseColor * float4(scattering, 0.8);
            CastedLight[x].TotalLightCast = totalLightCast;
            CastedLight[x].RotatedLight = rotatedLight;
            CastedLight[x].LightAmount = totalLightCast + refractedLightCast;
        }
        return float4(0, 0, 0, 0);

    }
};



float4 PS(PS_INPUT input) : SV_TARGET
{
    SceneManager sm;
    Scene scene;
    sm.Create(scene, input);
    
    
    float3 ambientColor = float3(0.15, 0.15, 0.15);
    float3 specularColor = float3(0.85, 0.85, 0.85);
    
    float density0 = CalculateDepthDensity(input.TexCoord, MAX_DEPTH, NORMAL_SAMPLE_RADIUS, 1, 10.0f, scene.DepthLRUD, scene.DN);
    float density1 = CalculateDepthDensity(input.TexCoord, MAX_DEPTH, NORMAL_SAMPLE_RADIUS, 3, 100.0f, scene.DepthLRUD, scene.DN);
    float density3 = CalculateDepthDensity(input.TexCoord, MAX_DEPTH, NORMAL_SAMPLE_RADIUS, 6, 300.0f, scene.DepthLRUD, scene.DN);
    float density4 = CalculateDepthDensity(input.TexCoord, MAX_DEPTH, NORMAL_SAMPLE_RADIUS, 13, 3000.0f, scene.DepthLRUD, scene.DN);
    float4 density = float4(density0, density1, density3, (density0 + density1 + density3) * 0.3);
    
    float3 fresnelDensity0 = FresnelSchlick(float3(density.xyz * density.w), scene.View.Direction, scene.DN.xyz, 5);
    
    
    
    LightCast castedLight[MAX_LIGHTS];
    
    float4 err = sm.Illuminate(scene, castedLight);
    if (any(err))
    {
        return err;
    }
 
        Aberration abb[MAX_LIGHTS];
    
    float3 ret = float3(0, 0, 0);
    for (int x = 0; x < MAX_LIGHTS - 1; x++)
    {
        /*
        abb[x].GetChromaticAberration(depthMap,
            input.TexCoord, scene.DepthLRUD, scene.DN,
            scene.View.Position, scene.View.Direction, 
            castedLight[x],
            abb[x]);
        {*/
        ret = castedLight[x].DiffuseComponent;
        
              /*  rainbowMap2.Sample(sampleTypeMirror, 
                    float2(0.2 * 
                        cos(abb[x].AberrationOffset[0].x), 
                        -cos(abb[x].AberrationOffset[0].y)) * SceneAlphaMul).rgb;
        }*/
        //castedLight[x].TotalLightCast;
    }
    //RainbowAberration r;
    
    return float4(ret, 1);
}