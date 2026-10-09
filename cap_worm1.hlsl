
#define CONFIG_EFFECT_MIN_1 0.5
#define CONFIG_EFFECT_MAX_1 1.2
#define CONFIG_EFFECT_1 0.75
#define CONFIG_EFFECT_1_Name "Scale"

#define CONFIG_EFFECT_MIN_2 0.1
#define CONFIG_EFFECT_MAX_2 5
#define CONFIG_EFFECT_2 1
#define CONFIG_EFFECT_2_Name "Count"

#define MAX_GLITTER4 128
#define MAX_GLITTER (MAX_GLITTER4/4)

#define SCATTER_NUM_STEPS 3
#define ILLUMINATE_NUM_RAYS 7
#define ILLUMINATE_RAY_LENGTH 25
#define MAX_SPIN 0.5

#define MAX_DEPTH 25

#define SCREEN_REGIONS_X 2
#define SCREEN_REGIONS_Y 2

#define MAX_LIGHTS 4

#define NORMAL_SAMPLE_RADIUS 12
#define OCCLUSION_MIN_DIFFERENCE 0.008
#define PI 3.14159265358979


cbuffer ScreenSizeBuffer : register(b0)
{
    float2 LOOK_AT;
    float2 LOOK_AT_DELTA;
    
    float FrameTime;
    float TotalTime;
    float DepthScale;
    float FresnelPower;
    
    float FresnelReflectance;
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
    float3 TexCoord2 : TEXCOORD1;
    float4 Color : COLOR0;
};
SamplerState sampleTypeLinear : register(s0);
SamplerState sampleTypeMirror : register(s1);

Texture2D diffuseMap : register(t0);
Texture2D depthMap : register(t1);
Texture2D skylineMap : register(t2);
Texture2D rainbowMap2 : register(t3);
//Texture2D ActiveRenderTarget : register(t4);
Texture2D rtMap1 : register(t4);
Texture2D rtMap2 : register(t5);
Texture2D rtMap3 : register(t6);
Texture2D rtMap4 : register(t7);
Texture2D rtMap5 : register(t8);
//Texture2D depthStencilMap : register(t5);




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

float4x4 CreateViewMatrix(float3 position, float3 target, float3 up)
{
    float3 zAxis = normalize(target - position);
    float3 xAxis = normalize(cross(up, zAxis));
    float3 yAxis = cross(zAxis, xAxis);

    float4x4 viewMatrix =
    {
        xAxis.x, yAxis.x, zAxis.x, 0.0,
        xAxis.y, yAxis.y, zAxis.y, 0.0,
        xAxis.z, yAxis.z, zAxis.z, 0.0,
        -dot(xAxis, position), -dot(yAxis, position), -dot(zAxis, position), 1.0
    };

    return viewMatrix;
}

float4x4 CreateProjectionMatrix(float nearZ, float farZ)
{
    float2 viewSize = float2(1.0, 1.0); // x: 0-1, y: 0-1

    float4x4 projectionMatrix =
    {
        2.0 / viewSize.x, 0.0, 0.0, 0.0,
        0.0, 2.0 / viewSize.y, 0.0, 0.0,
        0.0, 0.0, 1.0 / (farZ - nearZ), 0.0,
        0.0, 0.0, -nearZ / (farZ - nearZ), 1.0
    };

    return projectionMatrix;
}


float4x4
ProjectionMatrix(const float near_plane, // Distance to near clipping 
                                         // plane
                 const float far_plane, // Distance to far clipping 
                                         // plane
                 const float fov_horiz, // Horizontal field of view 
                                         // angle, in radians
                 const float fov_vert)   // Vertical field of view 
                                         // angle, in radians
{
    float h, w, Q;

    w = (float) 1 / tan(fov_horiz * 0.5); // 1/tan(x) == cot(x)
    h = (float) 1 / tan(fov_vert * 0.5); // 1/tan(x) == cot(x)
    Q = far_plane / (far_plane - near_plane);

    float4x4 ret;
   
    ret[0, 0] = w;
    ret[1, 1] = h;
    ret[2, 2] = Q;
    ret[3, 2] = -Q * near_plane;
    ret[2, 3] = 1;
    return ret;
}

float3 ConvertToViewSpace(float3 worldCoord, float3 viewMin, float3 viewMax)
{
    float3 viewSpace = (worldCoord - viewMin) / (viewMax - viewMin);
    return viewSpace;
}

float3 ConvertFromViewSpace(float3 viewCoord, float3 viewMin, float3 viewMax)
{
    float3 worldCoord = viewCoord * (viewMax - viewMin) + viewMin;
    return worldCoord;
}
bool PointIntersectsDepthMap(float3 viewPoint)
{
    float depth = depthMap.Sample(sampleTypeMirror, viewPoint.xy).r;
    return viewPoint.z <= depth;
}

bool ConeIntersectsSphere(float3 coneTip, float3 coneDir, float coneAngle, float3 sphereCenter, float sphereRadius)
{
    float3 v = sphereCenter - coneTip;
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return h <= sphereRadius;
}


float ConeDistanceToSphere(float3 coneTip, float3 coneDir, float coneAngle, float3 sphereCenter, float sphereRadius)
{
    float3 v = sphereCenter - coneTip;
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return max(0.0, h - sphereRadius);
}


bool ConeIntersectsPlane(float3 coneTip, float3 coneDir, float coneAngle, float3 planeNormal, float planeDistance)
{
    // Difficult to define without more context (e.g., finite cone height). Requires specific use-case definition.
    return false;
}

bool PointInsideCone(float3 p, float3 coneTip, float3 coneDir, float coneAngle)
{
    float3 v = p - coneTip;
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return h <= 0.0;
}

float3 ProjectPointInsideCone(float3 p, float3 coneTip, float3 coneDir, float coneAngle)
{
    float3 v = p - coneTip;
    float d = dot(v, coneDir);
    float h = length(v) * sin(acos(d / length(v)) - coneAngle);
    return p - h * normalize(coneDir);
}

bool RayIntersectCone(float3 rayOrigin, float3 rayDir, float3 coneTip, float3 coneDir, float coneAngle, out float t)
{
    float cos2 = cos(coneAngle) * cos(coneAngle);
    float3 d = rayOrigin - coneTip;
    float dDotC = dot(d, coneDir);
    float rDotC = dot(rayDir, coneDir);
    float a = rDotC * rDotC - cos2;
    float b = 2.0 * (rDotC * dDotC - dot(rayDir, d) * cos2);
    float c = dDotC * dDotC - dot(d, d) * cos2;

    float discriminant = b * b - 4.0 * a * c;

    if (discriminant < 0.0)
        return false;

    float sqrtDiscriminant = sqrt(discriminant);
    float t0 = (-b - sqrtDiscriminant) / (2.0 * a);
    float t1 = (-b + sqrtDiscriminant) / (2.0 * a);
    t = min(t0, t1);
    return true;
}


// Returns a matrix that transforms a point from world space to screen space
// Requires a projection matrix that transforms a point from view space to clip space
// Requires a viewport vector that defines the screen bounds in pixels
float4x4 WorldToScreenMatrix(float4x4 projectionMatrix, float4 viewport)
{
    // The world to screen matrix is the product of the projection matrix and a viewport matrix
    // The viewport matrix scales and translates the clip space coordinates to screen space coordinates
    float4x4 viewportMatrix = float4x4(
        viewport.z / 2.0, 0.0, 0.0, 0.0,
        0.0, -viewport.w / 2.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        viewport.x + viewport.z / 2.0, viewport.y + viewport.w / 2.0, 0.0, 1.0
    );
    return mul(projectionMatrix, viewportMatrix);
}
/*
// Returns a matrix that transforms a point from view space to world space
// Requires a view matrix that transforms a point from world space to view space
float4x4 ViewToWorldMatrix(float4x4 viewMatrix)
{
    // The inverse of the view matrix is the view to world matrix
    return invert(viewMatrix);
}
// Returns a matrix that transforms a point from screen space to world space
// Requires a projection matrix that transforms a point from view space to clip space
// Requires a viewport vector that defines the screen bounds in pixels
float4x4 ScreenToWorldMatrix(float4x4 projectionMatrix, float4 viewport)
{
    
    // The inverse of the world to screen matrix is the screen to world matrix
    return invert(WorldToScreenMatrix(projectionMatrix, viewport));
}

// Returns a matrix that transforms a point from world space to texture space
// Requires a texture matrix that defines the texture coordinates for each vertex of a mesh
float4x4 WorldToTextureMatrix(float4x4 textureMatrix)
{
    // The world to texture matrix is the same as the texture matrix
    return textureMatrix;
}


// Returns a matrix that transforms a point from texture space to world space
// Requires a texture matrix that defines the texture coordinates for each vertex of a mesh
float4x4 TextureToWorldMatrix(float4x4 textureMatrix)
{
    
    // The inverse of the texture matrix is the texture to world matrix
    return invert(textureMatrix);
}

void CalculateFrustumPoints(
    out float3 frustumPoints[8],
    float4x4 invViewProjectionMatrix)
{
    float4 ndcCorners[8] =
    {
        float4(-1.0, -1.0, 0.0, 1.0),
        float4(1.0, -1.0, 0.0, 1.0),
        float4(1.0, 1.0, 0.0, 1.0),
        float4(-1.0, 1.0, 0.0, 1.0),
        float4(-1.0, -1.0, 1.0, 1.0),
        float4(1.0, -1.0, 1.0, 1.0),
        float4(1.0, 1.0, 1.0, 1.0),
        float4(-1.0, 1.0, 1.0, 1.0)
    };

    for (int i = 0; i < 8; i++)
    {
        float4 worldPoint = mul(ndcCorners[i], invViewProjectionMatrix);
        frustumPoints[i] = worldPoint.xyz / worldPoint.w;
    }
}


void ExtractFrustumPlanes(
    out float4 frustumPlanes[6], 
    float4x4 viewProjectionMatrix)
{
    // Left plane
    frustumPlanes[0] = viewProjectionMatrix[3] + viewProjectionMatrix[0];
    // Right plane
    frustumPlanes[1] = viewProjectionMatrix[3] - viewProjectionMatrix[0];
    // Bottom plane
    frustumPlanes[2] = viewProjectionMatrix[3] + viewProjectionMatrix[1];
    // Top plane
    frustumPlanes[3] = viewProjectionMatrix[3] - viewProjectionMatrix[1];
    // Near plane
    frustumPlanes[4] = viewProjectionMatrix[3] + viewProjectionMatrix[2];
    // Far plane
    frustumPlanes[5] = viewProjectionMatrix[3] - viewProjectionMatrix[2];

    // Normalize the planes
    for (int i = 0; i < 6; i++)
    {
        frustumPlanes[i] /= length(frustumPlanes[i].xyz);
    }
}
*/

bool SphereInViewFrustum(float3 viewCenter, float radius, float4 frustumPlanes[6])
{
    for (int i = 0; i < 6; i++)
    {
        if (dot(frustumPlanes[i], float4(viewCenter, 1.0)) < -radius)
            return false;
    }
    return true;
}

/*
Usage Notes
viewMin and viewMax should be defined as
//float3(0.0, 0.0, 0.0) and float3(1.0, 1.0, 100.0)
//for your specific view space.
The frustumPlanes array must contain the 6 planes that define the view frustum. They should be in the form of float4(a, b, c, d) representing the plane equation ax + by + cz + d = 0.
The depth map function assumes that the depth is stored in the red channel of a texture. Adjust this according to your specific implementation.
*/
bool PointInsideViewFrustum(float3 viewPoint, float4 frustumPlanes[6])
{
    for (int i = 0; i < 6; i++)
    {
        if (dot(frustumPlanes[i], float4(viewPoint, 1.0)) < 0.0)
            return false;
    }
    return true;
}

float3 Barycentric(float3 p, float3 v0, float3 v1, float3 v2)
{
    float3 v0v2 = v2 - v0;
    float3 v0v1 = v1 - v0;
    float3 v0p = p - v0;
    float d00 = dot(v0v2, v0v2);
    float d01 = dot(v0v2, v0v1);
    float d11 = dot(v0v1, v0v1);
    float d20 = dot(v0p, v0v2);
    float d21 = dot(v0p, v0v1);
    float invDenom = 1.0 / (d00 * d11 - d01 * d01);
    float v = (d11 * d20 - d01 * d21) * invDenom;
    float w = (d00 * d21 - d01 * d20) * invDenom;
    float u = 1.0 - v - w;
    return float3(u, v, w);
}



float DistanceFromPointToLineSegment
(
    float3 p, float3 lineStart, float3 lineEnd)
{
    float3 lineDirection = normalize(lineEnd - lineStart);
    float t = dot(p
    - lineStart, lineDirection);
    t = clamp(t, 0.0, length(lineEnd - lineStart));
    float3 projection = lineStart + lineDirection * t;
    return length(projection - p);
}

bool RayIntersectLineSegment(float3 rayOrigin, float3 rayDir, float3 lineStart, float3 lineEnd, out float t)
{
    float3 lineDir = normalize(lineEnd - lineStart);
    float3 h = cross(rayDir, lineDir);
    float a = dot(lineStart - rayOrigin, h);

    if (abs(a) < 1e-6)
        return false;

    float f = 1.0 / a;
    float3 s = rayOrigin - lineStart;
    float u = f * dot(s, h);

    if (u < 0.0 || u > 1.0)
        return false;

    float3 q = cross(s, rayDir);
    float v = f * dot(lineEnd - lineStart, q);

    if (v < 0.0 || u + v > 1.0)
        return false;

    t = f * dot(lineDir, q);
    return true;
}

bool SphereIntersectLineSegment(float3 sphereCenter, float sphereRadius, float3 lineStart, float3 lineEnd, out float t0, out float t1)
{
    float3 lineDir = lineEnd - lineStart;
    float3 m = lineStart - sphereCenter;
    float a = dot(lineDir, lineDir);
    float b = 2.0 * dot(lineDir, m);
    float c = dot(m, m) - sphereRadius * sphereRadius;
    float discriminant = b * b - 4.0 * a * c;

    if (discriminant < 0.0)
        return false;

    float sqrtDiscriminant = sqrt(discriminant);
    t0 = (-b - sqrtDiscriminant) / (2.0 * a);
    t1 = (-b + sqrtDiscriminant) / (2.0 * a);
    return true;
}

bool RayIntersectSphere(float3 rayOrigin, float3 rayDir, float3 sphereCenter, float sphereRadius, out float t0, out float t1)
{
    float3 m = rayOrigin - sphereCenter;
    float b = dot(m, rayDir);
    float c = dot(m, m) - sphereRadius * sphereRadius;
    float discriminant = b * b - c;

    if (discriminant < 0.0)
        return false;

    float sqrtDiscriminant = sqrt(discriminant);
    t0 = -b - sqrtDiscriminant;
    t1 = -b + sqrtDiscriminant;
    return true;
}


bool RayIntersectPlane(float3 rayOrigin, float3 rayDir, float3 planeNormal, float planeDistance, out float t)
{
    float d = dot(rayDir, planeNormal);

    if (abs(d) < 1e-6)
        return false;

    t = (planeDistance - dot(rayOrigin, planeNormal)) / d;
    return true;
}


bool RayIntersectTriangle(float3 rayOrigin, float3 rayDir, float3 v0, float3 v1, float3 v2, out float t)
{
    float3 e1 = v1 - v0;
    float3 e2 = v2 - v0;
    float3 h = cross(rayDir, e2);
    float a = dot(e1, h);

    if (a > -1e-6 && a < 1e-6)
        return false;

    float f = 1.0 / a;
    float3 s = rayOrigin - v0;
    float u = f * dot(s, h);

    if (u < 0.0 || u > 1.0)
        return false;

    float3 q = cross(s, e1);
    float v = f * dot(rayDir, q);

    if (v < 0.0 || u + v > 1.0)
        return false;

    t = f * dot(e2, q);
    return true;
}

bool TriangleIntersectsSphere(float3 v0, float3 v1, float3 v2, float3 sphereCenter, float sphereRadius)
{
    // Check if any vertex is inside the sphere
    if (length(v0 - sphereCenter) <= sphereRadius ||
        length(v1 - sphereCenter) <= sphereRadius ||
        length(v2 - sphereCenter) <= sphereRadius)
        return true;

    // Check if any edge intersects the sphere
    float t0, t1;
    if (SphereIntersectLineSegment(sphereCenter, sphereRadius, v0, v1, t0, t1) ||
        SphereIntersectLineSegment(sphereCenter, sphereRadius, v1, v2, t0, t1) ||
        SphereIntersectLineSegment(sphereCenter, sphereRadius, v2, v0, t0, t1))
        return true;

    // Check if the sphere center is inside the triangle
    float3 normal = cross(v1 - v0, v2 - v0);
    float3 projection = sphereCenter - dot(sphereCenter - v0, normal) * normal;
    float3 barycentric = Barycentric(projection, v0, v1, v2);
    if (barycentric.x >= 0.0 && barycentric.y >= 0.0 && barycentric.z >= 0.0)
        return true;

    return false;
}


float TriangleDistanceToSphere(float3 v0, float3 v1, float3 v2, float3 sphereCenter, float sphereRadius)
{
    float d0 = DistanceFromPointToLineSegment(sphereCenter, v0, v1);
    float d1 = DistanceFromPointToLineSegment(sphereCenter, v1, v2);
    float d2 = DistanceFromPointToLineSegment(sphereCenter, v2, v0);
    return max(0.0, min(d0, min(d1, d2)) - sphereRadius);
}


bool TriangleIntersectsPlane(float3 v0, float3 v1, float3 v2, float3 planeNormal, float planeDistance)
{
    float d0 = dot(planeNormal, v0) - planeDistance;
    float d1 = dot(planeNormal, v1) - planeDistance;
    float d2 = dot(planeNormal, v2) - planeDistance;
    return (d0 * d1 <= 0.0) || (d1 * d2 <= 0.0) || (d0 * d2 <= 0.0);
}

bool PointInsideSphere(float3 p, float3 sphereCenter, float sphereRadius)
{
    return length(p - sphereCenter) <= sphereRadius;
}

float PointDistanceToSphere(float3 p, float3 sphereCenter, float sphereRadius)
{
    return max(0.0, length(p - sphereCenter) - sphereRadius);
}

bool PointInsideEllipse(float3 p, float3 ellipseCenter, float3 ellipseRadii)
{
    return length((p - ellipseCenter) / ellipseRadii) <= 1.0;
}

bool PointInsideTriangle(float3 p, float3 v0, float3 v1, float3 v2)
{
    float3 barycentricCoords = Barycentric(p, v0, v1, v2);
    return barycentricCoords.x >= 0.0 && barycentricCoords.y >= 0.0 && barycentricCoords.z >= 0.0;
}

bool PointInsideCapsule(float3 p, float3 capsuleStart, float3 capsuleEnd, float capsuleRadius)
{
    return DistanceFromPointToLineSegment(p, capsuleStart, capsuleEnd) <= capsuleRadius;
}

float PointDistanceToPlane(float3 p, float3 planeNormal, float planeDistance)
{
    return abs(dot(planeNormal, p) - planeDistance);
}

bool PointOnPlane(float3 p, float3 planeNormal, float planeDistance)
{
    return abs(dot(planeNormal, p) - planeDistance) < 1e-6;
}

float3 ProjectPointOntoLineSegment(float3 p, float3 lineStart, float3 lineEnd)
{
    float3 lineDir = lineEnd - lineStart;
    float t = dot(p - lineStart, lineDir) / dot(lineDir, lineDir);
    t = clamp(t, 0.0, 1.0);
    return lineStart + t * lineDir;
}

float3 ProjectPointOntoPlane(float3 p, float3 planeNormal, float planeDistance)
{
    float d = dot(planeNormal, p) - planeDistance;
    return p - d * planeNormal;
}

float3 ProjectPointOntoSphere(float3 p, float3 sphereCenter, float sphereRadius)
{
    return sphereCenter + sphereRadius * normalize(p - sphereCenter);
}

float3 ProjectPointOntoEllipse(float3 p, float3 ellipseCenter, float3 ellipseRadii)
{
    return ellipseCenter + ellipseRadii * normalize((p - ellipseCenter) / ellipseRadii);
}

float3 ProjectPointOntoCapsule(float3 p, float3 capsuleStart, float3 capsuleEnd, float capsuleRadius)
{
    float3 projection = ProjectPointOntoLineSegment(p, capsuleStart, capsuleEnd);
    return projection + capsuleRadius * normalize(p - projection);
}

float3 ProjectPointOntoTriangle(float3 p, float3 v0, float3 v1, float3 v2)
{
    float3 normal = cross(v1 - v0, v2 - v0);
    float planeDistance = dot(normal, v0);
    return ProjectPointOntoPlane(p, normal, planeDistance);
}


bool RayIntersectEllipse(float3 rayOrigin, float3 rayDir, float3 ellipseCenter, float3 ellipseRadii, out float t)
{
    float3 d = (rayOrigin - ellipseCenter) / ellipseRadii;
    float3 f = rayDir / ellipseRadii;
    float a = dot(f, f);
    float b = 2.0 * dot(f, d);
    float c = dot(d, d) - 1.0;
    float discriminant = b * b - 4.0 * a * c;

    if (discriminant < 0.0)
        return false;

    float sqrtDiscriminant = sqrt(discriminant);
    float t0 = (-b - sqrtDiscriminant) / (2.0 * a);
    float t1 = (-b + sqrtDiscriminant) / (2.0 * a);
    t = min(t0, t1);
    return true;
}



bool RayIntersectCapsule(float3 rayOrigin, float3 rayDir, float3 capsuleStart, float3 capsuleEnd, float capsuleRadius, out float t)
{
    float3 d = capsuleEnd - capsuleStart;
    float3 m = rayOrigin - capsuleStart;
    float t0, t1;
    if (SphereIntersectLineSegment(capsuleStart, capsuleRadius, rayOrigin, rayOrigin + rayDir, t0, t1) ||
        SphereIntersectLineSegment(capsuleEnd, capsuleRadius, rayOrigin, rayOrigin + rayDir, t0, t1))
    {
        t = min(t0, t1);
        return true;
    }
    return false;
}


// Returns true if a point p is inside an axis-aligned box defined by a center point c and a half-size vector h
bool PointInsideBox(float3 p, float3 c, float3 h)
{
    float3 d = abs(p - c); // vector from c to p
    return (d.x <= h.x) && (d.y <= h.y) && (d.z <= h.z); // point is inside box if d is less than or equal to h
}

// Returns true if a ray defined by an origin point o and a direction vector d intersects an axis-aligned box defined by a center point c and a half-size vector h
// If true, also returns the intersection point i and the distance t along the ray
bool RayIntersectBox(float3 o, float3 d, float3 c, float3 h, out float3 i, out float t)
{
    float3 tmin = (c - h - o) / d; // minimum distance along the ray for each axis
    float3 tmax = (c + h - o) / d; // maximum distance along the ray for each axis
    tmin = min(tmin, tmax); // swap if necessary
    tmax = max(tmin, tmax); // swap if necessary
    t = max(tmin.x, max(tmin.y, tmin.z)); // largest of the minimum distances
    float t1 = min(tmax.x, min(tmax.y, tmax.z)); // smallest of the maximum distances
    if (t > t1) // ray misses the box
    {
        i = float3(0.0, 0.0, 0.0); // no intersection point
        return false; // no intersection
    }
    else // ray hits the box
    {
        i = o + t * d; // intersection point on the ray
        return true; // intersection exists
    }
}

// Returns true if a point p is inside an ellipse defined by a center point c, a radius vector r, and an orientation matrix m
bool PointInsideEllipse(float3 p, float3 c, float3 r, float3x3 m)
{
    float3 d = mul(p - c, m); // vector from c to p rotated by m
    return (d.x * d.x / (r.x * r.x) + d.y * d.y / (r.y * r.y) + d.z * d.z / (r.z * r.z)) <= 1.0; // point is inside ellipse if normalized distance is less than or equal to 1.0 
}

// Returns true if a ray defined by an origin point o and a direction vector d intersects an ellipse defined by a center point c, a radius vector r, and an orientation matrix m
// If true, also returns the closest intersection point i and the distance t along the ray 
bool RayIntersectEllipse(float3 o, float3 d, float3 c, float3 r, float3x3 m, out float3 i, out float t)
{
    float3 oc = mul(o - c, m); // vector from c to o rotated by m
    float3 dd = mul(d / r, m); // direction vector scaled by inverse radius and rotated by m
    float a = dot(dd, dd); // quadratic coefficient
    float b = 2.0 * dot(oc, dd); // linear coefficient
    float cc = dot(oc, oc) - 1.0; // constant term
    float delta = b * b - 4.0 * a * cc; // discriminant of quadratic equation
    if (delta < 0.0) // no real roots
    {
        i = float3(0.0, 0.0, 0.0); // no intersection point
        t = 0.0; // no distance along the ray 
        return false; // no intersection 
    }
    else // one or two real roots 
    {
        delta = sqrt(delta); // square root of discriminant 
        t = (-b - delta) / (2.0 * a); // smaller root 
        if (t < 0.0) // smaller root is negative 
        {
            t = (-b + delta) / (2.0 * a); // larger root 
            if (t < 0.0) // larger root is also negative 
            {
                i = float3(0.0, 0.0, 0.0); // no intersection point 
                return false; // no intersection 
            }
        }
        i = o + t * d; // intersection point on the ray 
        return true; // intersection exists 
    }
}


bool SphereIntersectsSphere(float3 center1, float radius1, float3 center2, float radius2)
{
    return length(center1 - center2) <= (radius1 + radius2);
}


float SphereDistanceToSphere(float3 center1, float radius1, float3 center2, float radius2)
{
    return max(0.0, length(center1 - center2) - (radius1 + radius2));
}


bool SphereIntersectsPlane(float3 sphereCenter, float sphereRadius, float3 planeNormal, float planeDistance)
{
    return abs(dot(planeNormal, sphereCenter) - planeDistance) <= sphereRadius;
}

float SphereDistanceToPlane(float3 sphereCenter, float sphereRadius, float3 planeNormal, float planeDistance)
{
    return abs(dot(planeNormal, sphereCenter) - planeDistance) - sphereRadius;
}

bool LineSegmentIntersectsSphere(float3 lineStart, float3 lineEnd, float3 sphereCenter, float sphereRadius)
{
    float t0, t1;
    return SphereIntersectLineSegment(sphereCenter, sphereRadius, lineStart, lineEnd, t0, t1);
}
// Point-Line Segment Intersection
bool PointIntersectsLineSegment(float2 p, float2 p1, float2 q1)
{
    if (p.x <= max(p1.x, q1.x) && p.x >= min(p1.x, q1.x) &&
        p.y <= max(p1.y, q1.y) && p.y >= min(p1.y, q1.y))
        return true;
    return false;
}

// Circle-Line Segment Intersection
bool CircleIntersectsLineSegment(float2 center, float radius, float2 p1, float2 q1)
{
    float2 d = q1 - p1;
    float2 f = p1 - center;

    float a = dot(d, d);
    float b = 2.0 * dot(f, d);
    float c = dot(f, f) - radius * radius;

    float discriminant = b * b - 4 * a * c;
    if (discriminant < 0)
    {
        return false;
    }
    else
    {
        discriminant = sqrt(discriminant);
        float t1 = (-b - discriminant) / (2 * a);
        float t2 = (-b + discriminant) / (2 * a);

        if (t1 >= 0 && t1 <= 1)
            return true;

        if (t2 >= 0 && t2 <= 1)
            return true;

        return false;
    }
}

// Rectangle-Line Segment Intersection
bool RectangleIntersectsLineSegment(float2 topLeft, float2 bottomRight, float2 p1, float2 q1)
{
    // Clip line segment to fit rectangle bounds
    float tmin = 0.0;
    float tmax = 1.0;
    float2 delta = q1 - p1;

    for (int i = 0; i < 2; ++i)
    {
        float div = 1.0 / delta[i];
        float t1 = (topLeft[i] - p1[i]) * div;
        float t2 = (bottomRight[i] - p1[i]) * div;

        if (t1 > t2)
        {
            float temp = t1;
            t1 = t2;
            t2 = temp;
        }

        tmin = max(tmin, t1);
        tmax = min(tmax, t2);

        if (tmin > tmax)
            return false;
    }

    return true;
}

float DistanceFromLineSegmentToSphere(float3 lineStart, float3 lineEnd, float3 sphereCenter, float sphereRadius)
{
    float3 lineDir = normalize(lineEnd - lineStart);
    float t = dot(sphereCenter - lineStart, lineDir);
    t = clamp(t, 0.0, length(lineEnd - lineStart));
    float3 projection = lineStart + lineDir * t;
    return max(0.0, length(projection - sphereCenter) - sphereRadius);
}

bool LineSegmentIntersectsLineSegment3D(float3 p1, float3 q1, float3 p2, float3 q2)
{
    float3 u = q1 - p1;
    float3 v = q2 - p2;
    float3 w = p1 - p2;

    float a = dot(u, u);
    float b = dot(u, v);
    float c = dot(v, v);
    float d = dot(u, w);
    float e = dot(v, w);
    float D = a * c - b * b;

    float sc, sN, sD = D;
    float tc, tN, tD = D;

    if (D == 0.0f)
    {
        sN = 0.0f;
        sD = 1.0f;
        tN = e;
        tD = c;
    }
    else
    {
        sN = (b * e - c * d);
        tN = (a * e - b * d);
        if (sN < 0.0f)
        {
            sN = 0.0f;
            tN = e;
            tD = c;
        }
        else if (sN > sD)
        {
            sN = sD;
            tN = e + b;
            tD = c;
        }
    }

    if (tN < 0.0f)
    {
        tN = 0.0f;
        if (-d < 0.0f)
            sN = 0.0f;
        else if (-d > a)
            sN = sD;
        else
        {
            sN = -d;
            sD = a;
        }
    }
    else if (tN > tD)
    {
        tN = tD;
        if ((-d + b) < 0.0f)
            sN = 0;
        else if ((-d + b) > a)
            sN = sD;
        else
        {
            sN = (-d + b);
            sD = a;
        }
    }

    sc = (abs(sN) < 1e-7f ? 0.0f : sN / sD);
    tc = (abs(tN) < 1e-7f ? 0.0f : tN / tD);

    float3 dP = w + (sc * u) - (tc * v);

    return length(dP) < 1e-7f;
}

bool LineSegmentIntersectsLineSegment2D(float2 p1, float2 q1, float2 p2, float2 q2)
{
    float a1 = q1.y - p1.y;
    float b1 = p1.x - q1.x;
    float c1 = a1 * p1.x + b1 * p1.y;

    float a2 = q2.y - p2.y;
    float b2 = p2.x - q2.x;
    float c2 = a2 * p2.x + b2 * p2.y;

    float det = a1 * b2 - a2 * b1;

    if (det == 0.0f)
        return false; // Parallel lines

    float x = (b2 * c1 - b1 * c2) / det;
    float y = (a1 * c2 - a2 * c1) / det;

    if (x < min(p1.x, q1.x) || x > max(p1.x, q1.x) || x < min(p2.x, q2.x) || x > max(p2.x, q2.x))
        return false;
    if (y < min(p1.y, q1.y) || y > max(p1.y, q1.y) || y < min(p2.y, q2.y) || y > max(p2.y, q2.y))
        return false;

    return true;
}


bool LineSegmentIntersectsLineSegment(float2 p1, float2 q1, float2 p2, float2 q2)
{
    float2 a = q1 - p1;
    float2 b = p2 - p1;
    float2 c = q2 - p1;

    float f = a.x * b.y - a.y * b.x;
    float d = a.x * c.y - a.y * c.x;

    if (f > 0 && d >= 0 && d <= f)
        return true;
    if (f < 0 && d <= 0 && d >= f)
        return true;

    a = q2 - p2;
    b = p1 - p2;
    c = q1 - p2;

    f = a.x * b.y - a.y * b.x;
    d = a.x * c.y - a.y * c.x;

    if (f > 0 && d >= 0 && d <= f)
        return true;
    if (f < 0 && d <= 0 && d >= f)
        return true;

    return false;
}

bool LineSegmentIntersectsPlane(float3 lineStart, float3 lineEnd, float3 planeNormal, float planeDistance)
{
    float d0 = dot(lineStart, planeNormal) - planeDistance;
    float d1 = dot(lineEnd, planeNormal) - planeDistance;
    return d0 * d1 <= 0.0;
}

float DistanceFromLineSegmentToPlane(float3 lineStart, float3 lineEnd, float3 planeNormal, float planeDistance)
{
    float d0 = dot(lineStart, planeNormal) - planeDistance;
    float d1 = dot(lineEnd, planeNormal) - planeDistance;
    return min(abs(d0), abs(d1));
}


bool PlaneIntersectsPlane(float3 normal1, float distance1, float3 normal2, float distance2)
{
    return abs(dot(normal1, normal2)) < 1.0 - 1e-6;
}

float PlaneDistanceToPlane(float3 normal1, float distance1, float3 normal2, float distance2)
{
    return PlaneIntersectsPlane(normal1, distance1, normal2, distance2) ? 0.0 : abs(distance1 - distance2);
}

bool CapsuleIntersectsCapsule(float3 start1, float3 end1, float radius1, float3 start2, float3 end2, float radius2)
{
    float3 u = end1 - start1;
    float3 v = end2 - start2;
    float3 w = start1 - start2;
    float a = dot(u, u);
    float b = dot(u, v);
    float c = dot(v, v);
    float d = dot(u, w);
    float e = dot(v, w);
    float D = a * c - b * b;
    float sc, sN, sD = D;
    float tc, tN, tD = D;

    if (D < 1e-6)
    {
        sN = 0.0;
        sD = 1.0;
        tN = e;
        tD = c;
    }
    else
    {
        sN = (b * e - c * d);
        tN = (a * e - b * d);
        if (sN < 0.0)
        {
            sN = 0.0;
            tN = e;
            tD = c;
        }
        else if (sN > sD)
        {
            sN = sD;
            tN = e + b;
            tD = c;
        }
    }

    if (tN < 0.0)
    {
        tN = 0.0;
        if (-d < 0.0)
            sN = 0.0;
        else if (-d > a)
            sN = sD;
        else
        {
            sN = -d;
            sD = a;
        }
    }
    else if (tN > tD)
    {
        tN = tD;
        if ((-d + b) < 0.0)
            sN = 0;
        else if ((-d + b) > a)
            sN = sD;
        else
        {
            sN = (-d + b);
            sD = a;
        }
    }

    sc = (abs(sN) < 1e-6 ? 0.0 : sN / sD);
    tc = (abs(tN) < 1e-6 ? 0.0 : tN / tD);
    float3 dP = w + (sc * u) - (tc * v);

    return length(dP) <= (radius1 + radius2);
}

float DistanceFromLineSegmentToLineSegment(float3 p1, float3 q1, float3 p2, float3 q2)
{
    float3 u = q1 - p1;
    float3 v = q2 - p2;
    float3 w = p1 - p2;
    float a = dot(u, u);
    float b = dot(u, v);
    float c = dot(v, v);
    float d = dot(u, w);
    float e = dot(v, w);
    float D = a * c - b * b;

    float s, sN, sD = D;
    float t, tN, tD = D;

    if (D < 1e-6)
    {
        sN = 0.0;
        sD = 1.0;
        tN = e;
        tD = c;
    }
    else
    {
        sN = (b * e - c * d);
        tN = (a * e - b * d);
        if (sN < 0.0)
        {
            sN = 0.0;
            tN = e;
            tD = c;
        }
        else if (sN > sD)
        {
            sN = sD;
            tN = e + b;
            tD = c;
        }
    }

    if (tN < 0.0)
    {
        tN = 0.0;
        if (-d < 0.0)
            sN = 0.0;
        else if (-d > a)
            sN = sD;
        else
        {
            sN = -d;
            sD = a;
        }
    }
    else if (tN > tD)
    {
        tN = tD;
        if ((-d + b) < 0.0)
            sN = 0;
        else if ((-d + b) > a)
            sN = sD;
        else
        {
            sN = (-d + b);
            sD = a;
        }
    }

    s = (abs(sN) < 1e-6 ? 0.0 : sN / sD);
    t = (abs(tN) < 1e-6 ? 0.0 : tN / tD);
    float3 dP = w + (s * u) - (t * v);

    return length(dP);
}


float CapsuleDistanceToCapsule(float3 start1, float3 end1, float radius1, float3 start2, float3 end2, float radius2)
{
    // Reuse CapsuleIntersectsCapsule logic
    if (CapsuleIntersectsCapsule(start1, end1, radius1, start2, end2, radius2))
        return 0.0;

    // Compute distances between line segments and find minimum
    float minDistance = DistanceFromLineSegmentToLineSegment(start1, end1, start2, end2);
    minDistance = min(minDistance, DistanceFromPointToLineSegment(start1, start2, end2));
    minDistance = min(minDistance, DistanceFromPointToLineSegment(end1, start2, end2));
    minDistance = min(minDistance, DistanceFromPointToLineSegment(start2, start1, end1));
    minDistance = min(minDistance, DistanceFromPointToLineSegment(end2, start1, end1));

    return max(0.0, minDistance - (radius1 + radius2));
}


bool CapsuleIntersectsSphere(float3 start, float3 end, float radius, float3 sphereCenter, float sphereRadius)
{
    return DistanceFromLineSegmentToSphere(start, end, sphereCenter, sphereRadius) <= 0.0;
}

float CapsuleDistanceToSphere(float3 start, float3 end, float radius, float3 sphereCenter, float sphereRadius)
{
    return DistanceFromLineSegmentToSphere(start, end, sphereCenter, sphereRadius);
}


bool CapsuleIntersectsPlane(float3 start, float3 end, float radius, float3 planeNormal, float planeDistance)
{
    return SphereIntersectsPlane(start, radius, planeNormal, planeDistance) ||
           SphereIntersectsPlane(end, radius, planeNormal, planeDistance);
}

float CapsuleDistanceToPlane(float3 start, float3 end, float radius, float3 planeNormal, float planeDistance)
{
    return min(SphereDistanceToPlane(start, radius, planeNormal, planeDistance),
               SphereDistanceToPlane(end, radius, planeNormal, planeDistance));
}



bool EllipseIntersectsSphere(float3 ellipseCenter, float3 ellipseRadii, float3 sphereCenter, float sphereRadius)
{
    // Transform sphere center to ellipse space
    float3 p = (sphereCenter - ellipseCenter) / ellipseRadii;
    return length(p) <= (1.0 + sphereRadius / min(ellipseRadii.x, min(ellipseRadii.y, ellipseRadii.z)));
}


float EllipseDistanceToSphere(float3 ellipseCenter, float3 ellipseRadii, float3 sphereCenter, float sphereRadius)
{
    float3 p = (sphereCenter - ellipseCenter) / ellipseRadii;
    return max(0.0, length(p) - 1.0 - sphereRadius / min(ellipseRadii.x, min(ellipseRadii.y, ellipseRadii.z)));
}

bool EllipseIntersectsPlane(float3 ellipseCenter, float3 ellipseRadii, float3 planeNormal, float planeDistance)
{
    float d = dot(planeNormal, ellipseCenter) - planeDistance;
    float r = dot(ellipseRadii, abs(planeNormal));
    return abs(d) <= r;
}




// Returns true if a triangle defined by three points p1, p2, and p3 intersects another triangle defined by three points q1, q2, and q3
// If true, also returns the intersection point i and the distance t from the centroid of the first triangle
bool TriangleIntersectTriangle(float3 p1, float3 p2, float3 p3, float3 q1, float3 q2, float3 q3, out float3 i, out float t)
{
    // Use the Möller–Trumbore algorithm to test for intersection
    // https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm
    
    // Compute the edge vectors of the first triangle
    float3 e1 = p2 - p1; // edge from p1 to p2
    float3 e2 = p3 - p1; // edge from p1 to p3
    
    // Compute the normal vector of the second triangle
    float3 n = cross(q2 - q1, q3 - q1); // normal vector of the second triangle
    
    // Compute the determinant of a matrix involving the edge and normal vectors
    float det = dot(e1, cross(e2, n)); // determinant of the matrix
    
    // Check if the triangles are parallel or degenerate
    if (det == 0.0) // triangles are parallel or degenerate
    {
        i = float3(0.0, 0.0, 0.0); // no intersection point
        t = 0.0; // no distance from the centroid of the first triangle
        return false; // no intersection
    }
    
    // Compute the inverse of the determinant
    float invDet = 1.0 / det; // inverse of the determinant
    
    // Compute the vector from p1 to q1
    float3 pq = q1 - p1; // vector from p1 to q1
    
    // Compute the barycentric coordinates of the intersection point on the first triangle
    float u = dot(pq, cross(e2, n)) * invDet; // barycentric coordinate u
    float v = dot(e1, cross(pq, n)) * invDet; // barycentric coordinate v
    
    // Check if the intersection point is inside the first triangle
    if ((u < 0.0) || (v < 0.0) || (u + v > 1.0)) // intersection point is outside the first triangle
    {
        i = float3(0.0, 0.0, 0.0); // no intersection point
        t = 0.0; // no distance from the centroid of the first triangle
        return false; // no intersection
    }
    
    // Compute the distance along the normal vector of the second triangle
    t = dot(e2, cross(pq, e1)) * invDet; // distance along the normal vector
    
    // Check if the intersection point is inside the second triangle
    if ((t < 0.0) || (t > dot(n, n))) // intersection point is outside the second triangle
    {
        i = float3(0.0, 0.0, 0.0); // no intersection point
        t = 0.0; // no distance from the centroid of the first triangle
        return false; // no intersection
    }
    
    // Compute the intersection point on both triangles
    i = q1 + t * n / dot(n, n); // intersection point on both triangles
    
    // Compute the distance from the centroid of the first triangle
    t = distance(i, (p1 + p2 + p3) / 3.0); // distance from the centroid of the first triangle
    
    return true; // intersection exists 
}

// Returns true if a cylinder defined by a center point c1, a height vector h1, and a radius r1 intersects another cylinder defined by a center point c2, a height vector h2, and a radius r2 
// If true, also returns the closest intersection point i and the distance t from the center of the first cylinder 
bool CylinderIntersectCylinder(float3 c1, float3 h1, float r1, float3 c2, float3 h2,
float r2, out float3 i, out float t)
{
    // Use an algorithm based on separating axis theorem and line segment intersection test 
    // https://www.geometrictools.com/Documentation/MethodOfSeparatingAxes.pdf 
    // https://www.geometrictools.com/Documentation/DistanceLine3Line3.pdf 
    
    // Compute the unit direction vectors of the cylinders 
    float3 d1 = normalize(h1); // unit direction vector of the first cylinder 
    float3 d2 = normalize(h2); // unit direction vector of the second cylinder 
    
    // Compute the cross product of the direction vectors 
    float3 n = cross(d1, d2); // cross product of the direction vectors 
    
    // Check if the cylinders are parallel or nearly parallel 
    if (length(n) < 0.0001) // cylinders are parallel or nearly parallel 
    {
        // Use a simplified algorithm based on circle intersection test 
        // https://mathworld.wolfram.com/Circle-CircleIntersection.html 
        
        // Compute the vector from c1 to c2 and its projection onto d1 
        float3 c1c2 = c2 - c1; // vector from c1 to c2 
        float p = dot(c1c2, d1); // projection of c1c2 onto d1 
        
        // Compute the closest points on the axes of the cylinders 
        float3 p1 = c1 + p * d1; // closest point on the axis of the first cylinder 
        float3 p2 = c2 - p * d2; // closest point on the axis of the second cylinder 
        
        // Compute the distance between the closest points and the radii sum 
        float d = distance(p1, p2); // distance between the closest points 
        float r = r1 + r2; // sum of the radii 
        
        // Check if the circles defined by the closest points and the radii intersect 
        if (d > r) // circles do not intersect 
        {
            i = float3(0.0, 0.0, 0.0); // no intersection point 
            t = 0.0; // no distance from the center of the first cylinder 
            return false; // no intersection 
        }
        else // circles intersect 
        {
            // Compute the intersection point on the plane perpendicular to d1 
            i = (p1 + p2) / 2.0 + sqrt(r * r - d * d) * normalize(cross(c1c2, d1)); // intersection point on the plane 
            
            // Clamp the intersection point to the caps of the cylinders 
            i = clamp(i, min(c1, c1 + h1), max(c1, c1 + h1)); // clamp to the first cylinder 
            i = clamp(i, min(c2, c2 + h2), max(c2, c2 + h2)); // clamp to the second cylinder 
            
            // Compute the distance from the center of the first cylinder 
            t = distance(i, c1); // distance from the center of the first cylinder 
            
            return true; // intersection exists 
        }
    }
    else // cylinders are not parallel or nearly parallel
    {
        // Use a more general algorithm based on separating axis theorem and line segment intersection test 
        
        // Normalize the cross product of the direction vectors
        n = normalize(n); // unit normal vector of the plane containing the axes of the cylinders
        
        // Compute the vector from c1 to c2 and its projections onto n and d1
        float3 c1c2 = c2 - c1; // vector from c1 to c2
        float pn = dot(c1c2, n); // projection of c1c2 onto n
        float pd = dot(c1c2, d1); // projection of c1c2 onto d1
        
// Compute the closest points on the axes of the cylinders
        float3 p1 = c1 + pd * d1; // closest point on the axis of the first cylinder
        float3 p2 = c2 - pn * n; // closest point on the axis of the second cylinder
        
        // Compute the distance between the closest points and the radii sum
        float d = distance(p1, p2); // distance between the closest points
        float r = r1 + r2; // sum of the radii
        
        // Check if the circles defined by the closest points and the radii intersect
        if (d > r) // circles do not intersect
        {
            // Check if any axis separates the cylinders
            if ((abs(pn) > dot(abs(h1), abs(n)) + dot(abs(h2), abs(n))) || // n separates the cylinders
                (abs(pd) > dot(abs(h1), abs(d1)) + dot(abs(h2), abs(mul(d2, d1)))) || // d1 separates the cylinders
                (abs(dot(c1c2, d2)) > dot(abs(h1), abs(mul(d1, d2))) + dot(abs(h2), abs(d2)))) // d2 separates the cylinders
            {
                i = float3(0.0, 0.0, 0.0); // no intersection point
                t = 0.0; // no distance from the center of the first cylinder
                return false; // no intersection
            }
            else // no axis separates the cylinders
            {
                // Use a line segment intersection test to find the closest points on the caps of the cylinders
                // https://www.geometrictools.com/Documentation/DistanceLine3Line3.pdf
                
                // Compute some auxiliary vectors and scalars
                float3 c1p1 = p1 - c1; // vector from c1 to p1
                float3 c2p2 = p2 - c2; // vector from c2 to p2
                float a = dot(h1, h1); // squared length of h1
                float b = dot(h1, h2); // dot product of h1 and h2
                float c = dot(h2, h2); // squared length of h2
                float d = dot(h1, c1p1); // dot product of h1 and c1p1
                float e = dot(h2, c2p2); // dot product of h2 and c2p2
                
                // Compute the parameters of the closest points on the line segments defined by the caps of the cylinders
                float det = a * c - b * b; // determinant of a matrix involving a, b, and c
                float s = (b * e - c * d) / det; // parameter for the first line segment
                float t = (a * e - b * d) / det; // parameter for the second line segment
                
                // Clamp the parameters to [0, 1] range
                s = clamp(s, 0.0, 1.0); // clamp s to [0, 1] range
                t = clamp(t, 0.0, 1.0); // clamp t to [0, 1] range
                
                // Compute the closest points on the line segments
                i = (c1 + s * h1 + c2 + t * h2) / 2.0; // average of the closest points on the line segments
                
                // Compute the distance from the center of the first cylinder 
                t = distance(i, c1); // distance from the center of the first cylinder
                
                return true; // intersection exists 
            }
        }
        else // circles intersect 
        {
            // Compute the intersection point on both circles 
            i = (p1 + p2) / 2.0 + sqrt(r * r - d * d) * normalize(cross(c1c2, n)); // intersection point on both circles
            
            // Clamp the intersection point to the caps of the cylinders 
            i = clamp(i, min(c1, c1 + h1), max(c1, c1 + h1)); // clamp to the first cylinder 
            i = clamp(i, min(c2, c2 + h2), max(c2, c2 + h2)); // clamp to the second cylinder 
            
            // Compute the distance from the center of the first cylinder 
            t = distance(i, c1); // distance from the center of the first cylinder 
            
            return true; // intersection exists 
        }
    }
}

// Returns true if a point p in view space intersects a depth map d in texture space
// If true, also returns the depth value z of the intersection point
bool PointIntersectDepthMap(float3 p, Texture2D d, out float z, float4x4 projectionMatrix)
{
    // Project the point p from view space to texture space using a perspective projection matrix
    // https://docs.microsoft.com/en-us/windows/win32/direct3d9/projection-transform
    float4 q = mul(float4(p, 1.0), projectionMatrix); // projected point in homogeneous coordinates
    q.xyz /= q.w; // projected point in normalized device coordinates
    q.xyz = q.xyz * 0.5 + 0.5; // projected point in texture coordinates
    
    // Check if the projected point is within the texture bounds
    if ((q.x < 0.0) || (q.x > 1.0) || (q.y < 0.0) || (q.y > 1.0) || (q.z < 0.0) || (q.z > 1.0)) // projected point is outside the texture bounds
    {
        z = 0.0; // no depth value
        return false; // no intersection
    }
    else // projected point is within the texture bounds
    {
        // Sample the depth map at the projected point
        z = d.Sample(sampleTypeLinear, q.xy).r; // depth value at the projected point
        
        // Check if the projected point is behind or in front of the depth map
        if (q.z > z) // projected point is behind the depth map
        {
            return false; // no intersection
        }
        else // projected point is in front of or on the depth map
        {
            return true; // intersection exists
        }
    }
}

// Returns true if a view frustum defined by a projection matrix m intersects a sphere defined by a center point c and a radius r in view space
// If true, also returns the distance d from the center of the sphere to the nearest plane of the frustum
bool FrustumIntersectSphere(float4x4 m, float3 c, float r, out float d)
{
    // Extract the six planes of the frustum from the projection matrix
    // https://gamedev.stackexchange.com/questions/60313/how-do-you-extract-view-frustum-planes-from-a-view-projection-matrix/60314#60314
    float4 leftPlane = m[3] + m[0]; // left plane of the frustum
    float4 rightPlane = m[3] - m[0]; // right plane of the frustum
    float4 bottomPlane = m[3] + m[1]; // bottom plane of the frustum
    float4 topPlane = m[3] - m[1]; // top plane of the frustum
    float4 nearPlane = m[3] + m[2]; // near plane of the frustum
    float4 farPlane = m[3] - m[2]; // far plane of the frustum
    
    // Normalize the planes of the frustum 
    leftPlane /= length(leftPlane.xyz); // normalized left plane 
    rightPlane /= length(rightPlane.xyz); // normalized right plane 
    bottomPlane /= length(bottomPlane.xyz); // normalized bottom plane 
    topPlane /= length(topPlane.xyz); // normalized top plane 
    nearPlane /= length(nearPlane.xyz); // normalized near plane 
    farPlane /= length(farPlane.xyz); // normalized far plane 
    
    // Compute the signed distances from the center of the sphere to each plane of the frustum 
    float dl = dot(leftPlane, float4(c, 1.0)); // signed distance to left plane 
    float dr = dot(rightPlane, float4(c, 1.0)); // signed distance to right plane 
    float db = dot(bottomPlane, float4(c, 1.0)); // signed distance to bottom plane 
    float dt = dot(topPlane, float4(c, 1.0)); // signed distance to top plane 
    float dn = dot(nearPlane, float4(c, 1.0)); // signed distance to near plane 
    float df = dot(farPlane, float4(c, 1.0)); // signed distance to far plane 
    
    // Check if the sphere is outside any plane of the frustum 
    if ((dl < -r) || (dr < -r) || (db < -r) || (dt < -r) || (dn < -r) || (df < -r)) // sphere is outside the frustum 
    {
        d = 0.0; // no distance to the frustum 
        return false; // no intersection 
    }
    else // sphere is inside or intersecting the frustum 
    {
        // Find the minimum positive signed distance to the frustum 
        d = min(max(dl, 0.0), min(max(dr, 0.0), min(max(db, 0.0), min(max(dt, 0.0), min(max(dn, 0.0), max(df, 0.0)))))); // minimum positive signed distance to the frustum 
        
        return true; // intersection exists 
    }
}




























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

float2 hash2(float2 p)
{
    return frac(sin(float2(
        dot(p, float2(127.1, 311.7)),
        dot(p, float2(269.5, 183.3)))) * 43758.5453);
}


float scaleRange(float x, float2 rangeAB)
{
    return (x - rangeAB.x) / (rangeAB.y - rangeAB.x);
}

float2 scaleRange2(float2 x, float2 rangeAB)
{
    return float2((x.x - rangeAB.x) / (rangeAB.y - rangeAB.x),
                  (x.y - rangeAB.x) / (rangeAB.y - rangeAB.x));
}
float3 scaleRange3(float3 x, float2 rangeAB)
{
    return float3((x.x - rangeAB.x) / (rangeAB.y - rangeAB.x),
                  (x.y - rangeAB.x) / (rangeAB.y - rangeAB.x),
                  (x.z - rangeAB.x) / (rangeAB.y - rangeAB.x));
}
float scaleRangeN1(float x, float2 ab)
{
    return ((x - ab.x) / (ab.y - ab.x)) * 2.0 - 1.0;
}


float perlin2(float2 uv)
{
    float w, h;
    depthMap.GetDimensions(w, h);
    float2 wh = float2(w, h);
    float2 sz = 1 / wh;
    
    uv.x += (((uv.x * 1.01321 * TotalTime) * 0.314159265));
    uv.y += (((uv.y * 1.01321 * TotalTime) * 0.314159265));
    
    
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

    return scaleRange(lerp(nx0, nx1, f.y), float2(0, 1));
}

float2 perlin2_2(float2 uv)
{
    float w, h;
    depthMap.GetDimensions(w, h);
    float2 wh = float2(w, h);
    float2 sz = 1 / wh;
    
    float3 p = floor(uv.y * h + uv.x + sz.y);
    float3 f = frac(uv.x * h + sz.y * uv.y);
    f = f * f * (3.0 - 2.0 * f); // cubic fade
    float f2 = frac(FrameTime);
    float n = p.x + p.y * 157.0 + 113.0 * p.z;
    float g1 = grad(perm[int(n) % 256], f.x + f2, f.y, f.z);
    float g2 = grad(perm[int(n + 157.0) % 256], f.x + f2, f.y - 1.0, f.z);
    float g3 = grad(perm[int(n + 113.0) % 256], f.x, f.y + f2, f.z - 1.0);
    float g4 = grad(perm[int(n + 270.0) % 256], f.x, f.y - 1.0, f.z - f2 - 1.0);
    float3 nx0 = float3(g4, g2, g1);
    float3 nx1 = float3(g1, g1, g3);
    float3 g00 = float3(g4, g2, g1);
    float3 g01 = float3(g1, g4, g3);
    
    float3 n10 = float3(g4 + g4.x + n - f.y + p.x + g1 + TotalTime, nx0.x + nx0.y + g2 - g4, g1 + g2 + g3 * n);
    
    return float2(
        scaleRange(
            lerp1D(1 / (uv.y + nx0.y - f.x - n10.x),
                w / (TotalTime * f.y + TotalTime + uv.x + uv.y * nx1.z),
                h / (n10.z + g01.x - f.x + f.y + nx1.x * f.y * TotalTime)), float2(0, 1)),
        scaleRange(
            lerp1D(1 / (g01.x + uv.y - nx0.x + n10.y - g01.x),
                w / (TotalTime * n10.y - g00.y + uv.x + uv.x + uv.y),
                h / (nx1.y + TotalTime + f.y * nx0.y * n10.z * TotalTime)), float2(0, 1)));
}
float perlin3(float3 position)
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

float noise3(float3 position)
{
    position = frac(sin(position) * 43758.5453);
    return frac(position.x + position.y * 57.0 + 113.0 * position.z);
}

float3 perlin3_3(float3 position)
{
    float3 p = floor(TotalTime + position);
    float3 f = frac(TotalTime + position);
    f = f * f * (3.0 - 2.0 * f); // cubic fade
    float f2 = frac(position);
    float n = p.x + p.y * 157.0 + 2113.0 * p.z;
    float g1 = grad(perm[int(n) % 256], f.x + f2, f.y, f.z);
    float g2 = grad(perm[int(n + 157.0) % 256], f.x + f2, f.y - 1.0, f.z);
    float g3 = grad(perm[int(n + 113.0) % 256], f.x, f.y + f2, f.z - 1.0);
    float g4 = grad(perm[int(n + 270.0) % 256], f.x, f.y - 1.0, f.z - f2 - 1.0);
    
    return float3(noise3(g3), noise3(g1 + g4), noise3(g2));

}




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

float3 FresnelSchlick(float3 F0, float3 V, float3 N, float fresnelPower)
{
    float cosTheta = dot(V, N);
    return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
}
float3 FresnelSchlick2(float3 F0, float3 V, float3 N, float fresnelPower)
{
    float cosTheta = dot(V, N);
    return F0 + (1.0 - F0) * pow((1.0 - cosTheta), fresnelPower);
}

float4 CalculateDepthDensity(
    float2 uv, float3 viewDir,
    float threshold, float curveExponent,
    float4 depthCross, float4 depthNormal)
{
    float depth = depthNormal.w;
    float4 variance = float4(
        (depthCross.x - depth),
        (depthCross.y - depth),
        (depthCross.z - depth),
        (depthCross.w - depth));
    
    return float4(
        variance.x > threshold ? pow(depth, curveExponent) : depth,
        variance.y > threshold ? pow(depth, curveExponent) : depth,
        variance.z > threshold ? pow(depth, curveExponent) : depth,
        variance.w > threshold ? pow(depth, curveExponent) : depth);
}

float CalculateOcclusionFactor(float d, float4 dc, float4 dc2, float4 dc6)
{
    float occlusionSum =
        (dc6.x < d - OCCLUSION_MIN_DIFFERENCE ? 1: 0) +
         (dc2.x < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc.x < d - OCCLUSION_MIN_DIFFERENCE ? 1: 0) +
         (dc6.y < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc2.y < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc.y < d - OCCLUSION_MIN_DIFFERENCE ? 1: 0) +
         (dc6.z < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc2.z < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc.z < d - OCCLUSION_MIN_DIFFERENCE ? 1: 0) +
         (dc6.w < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc2.w < d - OCCLUSION_MIN_DIFFERENCE ?1 : 0) +
         (dc.w < d - OCCLUSION_MIN_DIFFERENCE ? 1: 0);

    return (1 - ((occlusionSum) / 17));
}

float Falloff(float distance, float radius, float exponent)
{
    return pow(1.0 - clamp(distance / radius, 0.0, 1.0), exponent);
}


struct LightUtil
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



float3 FresnelSchlick(float3 F0, float3 H, float3 N, float3 V)
{
    float cosTheta = saturate(dot(V, H));
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, FresnelPower);
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

    



float Fresnel1(float3 viewDir, float3 normal, float fresnelPower)
{
    float cosTheta = dot(normal, viewDir);
    return fresnelPower + (1 - fresnelPower) * pow(1 - cosTheta, 5);
}
float4 CrossLRUDi(Texture2D tex, int3 uv, int range)
{
    return
        float4(tex.Load(uv, int2(-range, 0)).r,
                tex.Load(uv, int2(range, 0)).r,
                tex.Load(uv, int2(0, -range)).r,
                tex.Load(uv, int2(0, range)).r
            );
}
float4 CrossLRUDf(Texture2D tex, float2 uv, float range)
{
    float w, h;
    tex.GetDimensions(w, h);
    float2 sz = float2(1 / w, 1 / h);
    return
        float4(tex.Sample(sampleTypeMirror, uv + sz * float2(-range, 0)).r,
               tex.Sample(sampleTypeMirror, uv + sz * float2(range, 0)).r,
               tex.Sample(sampleTypeMirror, uv + sz * float2(0, -range)).r,
               tex.Sample(sampleTypeMirror, uv + sz * float2(0, range)).r
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
    
    l = tex.Sample(sampleTypeMirror, uv + szD * float2(-2, 0)).r;
    r = tex.Sample(sampleTypeMirror, uv + szD * float2(2, 0)).g;
    u = tex.Sample(sampleTypeMirror, uv + szD * float2(0, -2)).b;
    d = tex.Sample(sampleTypeMirror, uv + szD * float2(0, 2));
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
    return spin;
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
    
    float4 PointLightDiffuse(float3 normal, float3 viewDir, float3 position, float occlusionFactor, float scatteringCoefficient)
    {
        float3 toLight = Base.Position - position;
        float3 lightDir = normalize(-toLight);
        float distanceToLight = length(toLight);
        float attenuationFactor = 1 / (Attenuation.x + Attenuation.y * distanceToLight + Attenuation.z * distanceToLight * distanceToLight);

        // Subsurface scattering effect
        float penetrationDepthFactor = 10.3; // Adjust this value to control the penetration depth
        float subsurfaceScatteringEffect = exp(-distanceToLight / penetrationDepthFactor);

        // Basic diffuse calculation
        float diffFactor = max(0, dot(normal, lightDir));

        // Fresnel calculation
        float R0 = pow((Base.FresnelPower - 1) / (Base.FresnelPower + 1), 2);
        float3 fresnelWithDiffuse = FresnelSchlick2(diffFactor.xxx,
            normalize(reflect(normalize(toLight), normal)), normal, R0);
        
        // Combine diffuse, Fresnel, and subsurface scattering
        float3 lightContribution = (fresnelWithDiffuse +
            subsurfaceScatteringEffect * scatteringCoefficient *
            float3(noise(R0), noise(TotalTime), diffFactor) *
            Base.LightColor * Base.Intensity * attenuationFactor * (1 - occlusionFactor));
        
        // Additional Fresnel for final combination
        float3 fresnel = FresnelSchlick2(position, viewDir, normal, Base.FresnelPower);
        float3 p2 = fresnel * lightContribution;
        fresnel = FresnelSchlick2(p2, viewDir, normal, Base.FresnelPower);

        return float4(Base.LightColor * Base.Intensity, 1);
    }
};


struct DirectionalLight
{
    BaseLight Base;

    float4 DirectionalLight(float4 diffuse, float3 pix, float3 pixW, float3 normal, float3 viewDir)
    {
        if (!Base.Enabled)
            return float4(0, 0, 0, 0);

        float3 lightDir = normalize(-Base.Direction);
        float3 reflectDir = -reflect(Base.Direction, viewDir);
        float3 fresnelWithReflect = FresnelSchlick2(diffuse.rgb, reflectDir, lightDir, Base.FresnelReflectance);
        float diffFactor = max(0, dot(normal, Base.Direction));
        float fresnelPowerWithZ = (pixW.z) * Base.FresnelPower;
        float3 fresnel = FresnelSchlick2((1 - pixW.z), viewDir, normal, fresnelPowerWithZ);
        float3 diffuseLight = diffFactor * Base.LightColor * (1 - fresnel) * Base.Intensity;

        return float4(diffuseLight, 1);
    }
};


struct SpotLight
{
    BaseLight Base;
    float3 TargetPosition; // Radius of the light influence
    float ConeAngle; // Cone angle for spotlights
    float CutOffAngle; // CutOff angle for spotlights
    float3 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
   

    float4 SpotLightDiffuse(float3 normal, float3 position, float3 viewDir, float3 lightDir, float3 toLight, float fresnel)
    {
        // Check if the point is inside the cone
        if (!PointInsideCone(position, Base.Position, normalize(Base.Direction), ConeAngle))
            return float4(0.0f, 0.0f, 0.0f, 0.0f);

        // Project the point inside the cone
        float3 projectedPosition = ProjectPointInsideCone(position, Base.Position, normalize(Base.Direction), ConeAngle);

        // Calculate the diffuse factor
        float diffFactor = max(0, dot(normal, normalize(projectedPosition - position)));

        // Distance to the light
        float distance = length(Base.Position - position);

        // Attenuation factors
        float attenuation =
            1 / (Attenuation.x +
                 Attenuation.y * distance +
                 Attenuation.z * distance * distance);

        // Spotlight effect
        float spotEffect = max(dot(normalize(normal), -normalize(Base.Direction)), 0);

        float spotFactor = (spotEffect > CutOffAngle) ?
            pow(spotEffect, Base.Exponent) :
            0.1;

        // Cone attenuation
        float coneDistance = ConeDistanceToSphere(Base.Position, Base.Direction, ConeAngle, position, 0);
        float coneAttenuation = 1 - coneDistance;

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
        float4 diffuse = SpotLightDiffuse(normal, position, viewDir, lightDir, toLight, Base.FresnelPower);
        float3 reflectDir = normalize(reflect(normalize(toLight), normal));
        float3 F0 = Base.LightColor * Base.FresnelReflectance;
        float3 fresnel2 = FresnelSchlick2(F0, viewDir, reflectDir, Base.FresnelPower);
        float diffFactor2 = max(0, dot(reflectDir, viewDir));
        float3 reflection = fresnel2 * Base.Intensity * diffFactor2;

        return float4(diffuse.rgb + reflection.rgb, 1);
    }
};

SpotLight InitializeSpotLight(BaseLight base, float3 targetPosition, float coneAngle, float cutOffAngle, float3 attenuation)
{
    SpotLight light;
    light.Base = base;
    light.TargetPosition = targetPosition;
    light.ConeAngle = coneAngle;
    light.CutOffAngle = cutOffAngle;
    light.Attenuation = attenuation;
    return light;
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
float3 HolographicMicroscopyEffect2(float2 uv, float2 ddS, float3 viewDir, float2 sz, float2 szD)
{
    float w1 = WavePattern(uv, 2, 1, 3, TotalTime);
    float w2 = WavePattern2(uv, 1, 2, 1, TotalTime);
    float w3 = WavePattern2(uv, 3, 53 / TotalTime, 1, 0.1 * TotalTime);
    float w4 = WavePattern2(uv, 5, 51 / TotalTime, 1, 0.1 * TotalTime);
    
    return rainbowMap2.Sample(sampleTypeMirror, float2(w4, w3)).xyz;

}

float3 HolographicMicroscopyEffect3(float2 uv, float4 dn, float3 viewDir, float2 sz, float2 szD)
{
    float4 colorr = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(sz.x * (1 - (dn.w)) * 2, 0)).r;
    float4 colorg = diffuseMap.Sample(sampleTypeMirror,
        uv - float2(0, sz.y * (dn.w) * 4)).g;
    float4 colorb = diffuseMap.Sample(sampleTypeMirror,
        uv + float2(sz.x * (1 - (dn.w)) * -2, 0)).b;
    
    return 1 - FresnelSchlick2(float3(colorr.r, colorg.g, colorb.b), viewDir, dn.xyz, FresnelPower);

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


// Simulate a reflection effect
float3 ReflectEffect(float3 position, float3 normal, float3 incomingDir)
{
    return reflect(incomingDir, normal);
}

// Simulate a refraction effect
float3 RefractEffect(float3 position, float3 normal, float3 incomingDir, float eta)
{
    return refract(incomingDir, normal, eta);
}

// Simulate a distortion effect using sine waves
float3 SineWaveDistortion(float3 position, float frequency, float amplitude)
{
    return position + amplitude * sin(frequency * position);
}

// Simulate a twist effect
float3 TwistEffect(float3 position, float angle)
{
    float twistFactor = position.y * angle;
    float cosAngle = cos(twistFactor);
    float sinAngle = sin(twistFactor);
    return float3(
        cosAngle * position.x - sinAngle * position.z,
        position.y,
        sinAngle * position.x + cosAngle * position.z
    );
}

#define TRIPPY_EFFECTS(pos, normal, dir) \
pos = ReflectEffect(pos, normal, dir); \
pos = RefractEffect(pos, normal, dir, reflect(normal,dir)); \
pos = SineWaveDistortion(pos, pos.y, pos.x); \
pos = TwistEffect(pos, pos.x);


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


float3 Bloom(float2 uv, float intensity, float3 n)
{
    float3 sceneColor = diffuseMap.Sample(sampleTypeMirror, uv).rgb;
    
    return sceneColor * (FresnelSchlick2(sceneColor, float3(-0.1, -0.1, 1), n, FresnelPower));
}

#define red  float4(1, 0, 0, 1)
#define green  float4(0, 1, 0, 1)
#define blue  float4(0, 0, 1, 1)
#define yellow  float4(1, 1, 0, 1) 
#define magenta  float4(1, 0, 1, 1)
#define cyan  float4(0, 1, 1, 1)   
#define white  float4(1, 1, 1, 1)  
#define black  float4(0, 0, 0, 1)  
#define pink  float4(1, 0.5, 0.5, 1) 
#define orange  float4(1, 0.5, 0, 1) 
#define purple  float4(0.5, 0, 0.5, 1) 
#define brown  float4(0.5, 0.25, 0, 1) 
#define gray  float4(0.5, 0.5, 0.5, 1) 


// Define a helper function to generate a pseudo-random number between 0 and 1 based on an input seed
float Random(float seed)
{
    return frac(sin(seed) * 43758.5453);
}

// Define a helper function to generate a pseudo-random number between min and max based on an input seed
float RandomRange(float seed, float min, float max)
{
    return lerp(min, max, Random(seed));
}

// Define a helper function to generate a glitch noise value based on an input seed and time parameter
float GlitchNoise(float seed, float time, float Frequency, float Intensity)
{
    return RandomRange(seed + time * Frequency, -Intensity, Intensity);
}

// Define the pixel shader function
float4 Glitch(float2 uv, float4 color, float4 otherColor)
{
    float color2 = depthMap.Sample(sampleTypeLinear, uv).r;

    // Generate a glitch noise value based on the input texture coordinate and time parameter
    float noise = GlitchNoise(color2 * 10, TotalTime * 0.0000001, 3, 2) * 3;
    float noiseY = GlitchNoise(color2, TotalTime * 0.0000001, 2, 3) * 4;
    // Apply the noise to the texture coordinate in x direction
    float2 shiftedTextCoord = uv + float2(noise, noiseY);

    // Sample the second image for the shifted texture coordinate
    float shiftedColor2 = depthMap.Sample(sampleTypeMirror, shiftedTextCoord).r;

    return lerp(color2, shiftedColor2, abs(noise + noiseY));
}
float SineWave(float x, float amplitude, float frequency)
{
    return amplitude * sin(x * frequency);
}
float4 Ripple(float3 lookAtW, float2 uv, float4 color1, float time, float amplitude, float frequency)
{
    float4 color2 = rainbowMap2.Sample(sampleTypeMirror, uv);

    // Calculate the ripple distortion based on the distance from the center and the time parameter
    float2 center = lookAtW;
    float distance2 = distance(uv, center);
    float distortion = SineWave(distance2 - time, amplitude, frequency);

    // Apply the distortion to the texture coordinate
    float2 distortedTextCoord = uv + distortion;

    // Sample the second image for the distorted texture coordinate
    float4 distortedColor2 = rainbowMap2.Sample(sampleTypeMirror, distortedTextCoord);

    // Blend the two colors based on the distortion amount
    float4 color = lerp(color1, distortedColor2, distortion);
    return color;
}


SpotLight CreateRandomSpotLight(float2 uv, float depth)
{
    float3 position = float3(-2,5,-5);
    float3 direction = normalize(float3(1, -2, 1));
    float3 color = float3(0.2, 0.2, 0.2); // White color
    float intensity = 1.0f; // Example intensity
    float exponent = 0.4f; // Example exponent
    float fresnelPower = 1.0f; // Example Fresnel power
    float fresnelReflectance = 0.5f; // Example Fresnel reflectance
    float3 targetPosition = float3(uv, depth); // Example target position
    float coneAngle = 0.5f; // Example cone angle
    float coneAngleCutoff = FresnelReflectance; // Example cut-off angle
    float3 attenuation = float3(1, 0.2, 0.0162); // Example attenuation coefficients

    return CreateSpotLight(
        position,
        direction,
        color,
        intensity,
        exponent,
        fresnelPower,
        fresnelReflectance,
        targetPosition,
        coneAngle,
        coneAngleCutoff,
        attenuation
    );
}


void InitializeSpotLights(float2 uv, float depth, out SpotLight spotLights[4])
{
    for (int i = 0; i < 4; ++i)
    {
        spotLights[i] = CreateRandomSpotLight(uv, depth);
    }
}

float4 CalcLighting(float3 pix, float4 diffuse, float3 lookAtW, float3 viewPos, float dS, float3 viewDir, float3 N, float occlusionFactor, float3 pixW, float2 uv, float d, float4 dc)
{
   // SpotLight spotLights[4];
   // InitializeSpotLights(pix.xy, d, spotLights);
    
    // Directional Light Creation
    DirectionalLight dirLight = 
    CreateDirectionalLight(normalize(normalize(float3(lookAtW.xy, 0.8))), 
    float3(0.54, 0.54, 0.54), 0.298, FresnelPower, FresnelReflectance);

    // Point Light Creation
    PointLight pointLight = 
    CreatePointLight(float3(lookAtW.xy, 0), 
    float3(0.52f, 0.542,0.52), 1/DepthScale*10, 0.0242, FresnelPower, 
    FresnelReflectance, 1, float3(1, 0.2, 0.0162));

    // Diffuse Lighting
    float4 diffLight = (
    (dirLight.DirectionalLight(diffuse, pix, pixW, N.xyz, viewDir)))
    +
        (pointLight.PointLightDiffuse(N.xyz, viewDir, float3(LOOK_AT, 0), occlusionFactor, 1));
    
    
    float3 fres = FresnelSchlick2(diffLight.xyz, viewDir, N, FresnelPower);
    float3 fres2 = 1-FresnelSchlick2(fres.xyz, -reflect(-N, normalize(-lookAtW)), N, FresnelReflectance);
    
    return saturate(float4((diffuse.xyz *  diffLight.xyz*(1 - fres2)) -
        (((1- occlusionFactor) * 0.135229855)), 1));
}



float PerlinNoise(float2 uv)
{
    return perlin2(uv.x+uv.y*256);
}

float4 ColorGradient(float ratio)
{
    float4 warmEnd = float4(1, 0.5, 0, 1);
    float4 coldEnd = float4(0, 0.5, 1, 1);
    return lerp(coldEnd, warmEnd, ratio);
}

float4 Render360(float2 uv)
{
    float MouseX = LOOK_AT.x;
    float MouseY = LOOK_AT.y;
    // Convert the mouse coordinates to spherical coordinates
    float theta = MouseX * 2 * PI; // Horizontal angle
    float phi = MouseY * PI; // Vertical angle

// Convert the spherical coordinates to texture coordinates
    float u = theta / (2 * PI); // Horizontal texture coordinate
    float v = 1 - phi / PI; // Vertical texture coordinate

// Sample the texture using the texture coordinates
    float4 color = skylineMap.Sample(sampleTypeLinear, uv + float2(u, v));

// Return the color
    return color;

}


float4 ToneMapping(float4 color, float brightnessAdjustment, float minLuminance, float maxLuminance)
{
    float lumi = dot(color.xyz, float3(0.2126f, 0.7152f, 0.0722f));
    lumi = (lumi - minLuminance) / (maxLuminance - minLuminance) * brightnessAdjustment;
    return float4(lerp(color.rgb, lumi.xxx, float3(0.2126f, 0.7152f, 0.0722f)), color.a);
}

float3 mix(float3 x, float3 y, float a)
{
    return x * (1.0 - a) + y * a;
}
float4 ColorAdjustCreative(float4 color, float brightness, float contrast, float saturation)
{
    // Luminance and Brightness
    float luminance = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    color.rgb = lerp(float3(luminance, luminance, luminance), color.rgb, exp2(brightness));
    
    // Creative Contrast using sine wave
    float phase = 0.5f + 0.5f * sin(contrast);
    color.rgb = mix(color.rgb, color.rgb * phase, contrast);
    
    // Saturation based on distance to gray
    float3 cgray = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    color.rgb = lerp(cgray.xxx, color.rgb, pow(saturation, 2.2f));

    return color;
}
float4 ColorAdjust(float4 color, float brightness : c0, float contrast : c1, float saturation : c2)
{
    
       // Calculate the luminance of the color
    float luminance = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    
    // Adjust brightness while considering color
    color.rgb = lerp(float3(luminance, luminance, luminance), color.rgb, exp2(brightness));
    

    // Apply contrast.
    color.rgb = ((color.rgb - 0.5f) * max(contrast, 0)) + 0.5f;

    // Calculate the gray scale.
    float3 floatgray = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));

    // Interpolate between the gray scale and original color for saturation.
    color.rgb = lerp(floatgray, color.rgb, saturation);

    // Return final color.
    return color;
}
float4 ColorAdjustAdvanced(
    float4 color,
    float brightness,
    float contrast,
    float saturation,
    float gamma,
    float vibrance,
    float sepia)
{
    // Standard Adjustments
    float luminance = dot(color.rgb, float3(0.2126, 0.7152, 0.0722));
    color.rgb = saturate(lerp(float3(luminance, luminance, luminance), color.rgb, exp2(brightness)));
    color.rgb = (color.rgb - 0.5f) * (contrast + 1.0f) + 0.5f;
    float3 grayg = saturate(dot(color.rgb, float3(0.2126, 0.7152, 0.0722)));
    color.rgb = saturate(lerp(grayg, color.rgb, saturation));
    
    // Advanced Adjustments
    // 1. Gamma Correction
    color.rgb = saturate(pow(color.rgb, (1.0 / gamma)));
    // 4. Sepia
    color.rgb = saturate(mix(color.rgb, dot(color.rgb, float3(0.393, 0.769, 0.189)), sepia));
    return color;
}
struct psout
{
    float4 p1 : SV_Target0;
    float4 p2 : SV_Target1;
    
};


float4 PS(PS_INPUT input) : SV_Target
{
    float w, h;
    float2 uv = input.TexCoord;
    depthMap.GetDimensions(w, h);
    float2 sz = float2(1 / w, 1 / h);
    int2 iuv = int2(uv.x * w, uv.y * h);
    int3 iuv3 = int3(iuv, 0);
    float d = depthMap.Load(iuv3).r;
    
    float2 uv1 =  input.TexCoord + 
        float2(cosTime01(-2.2) * 0.008 * (d) * 0.5 - 0.015 * (d) * 0.5,
               -cosTime01(2.2) * 0.008 * (1-d) * 0.5 - 0.015 * (1-d) * 0.5);
    

    float ds = DepthScale;

    // Additional calculations for diffuse map dimensions
    float w2, h2;
    diffuseMap.GetDimensions(w2, h2);
    float2 szD = float2(1 / w2, 1 / h2);
    int2 iuvD = int2(uv1.x * w2, uv1.y * h2);
    int3 iuv3D = int3(iuvD, 0);

    // View related calculations
    float3 viewPos = float3(0.25, 0.25, -15);
    float3 viewCenter = float3(0.25, 0.25, 0);
    float3 viewDir = input.TexCoord2;
    
    // Calculations related to depth and occlusion
    int2 iLA = int2(LOOK_AT.x * w, LOOK_AT.y * h);
    int3 iLA3 = int3(iLA, 0);
    float lad = depthMap.Load(iLA3).r;
    float4 lad3 = CrossLRUDi(depthMap, iLA3, 3);
    lad = (lad + lad3.x + lad3.y + lad3.z + lad3.w) / 6;
    float ladS = lad * ds;
    
    float dS = d * ds;
    uv = uv1 - (viewDir.xy * d/60 + (LOOK_AT - float2(0.25, 0.25))*d/60);
    iuv = int2(uv.x * w, uv.y * h);
    iuv3 = int3(iuv, 0);
    d = depthMap.Load(iuv3).r;
    dS = d * ds;
   
    iuvD = int2(uv.x * w2, uv.y * h2);
    iuv3D = int3(iuvD, 0);
    d = depthMap.Load(iuv3).r;
    dS = d * ds;
    iLA = int2(LOOK_AT.x * w, LOOK_AT.y * h);
    iLA3 = int3(iLA, 0);
    lad = depthMap.Load(iLA3).r;
    lad3 = CrossLRUDi(depthMap, iLA3, 3);
    lad = (lad + lad3.x + lad3.y + lad3.z + lad3.w) / 6;
    float4 dc = CrossLRUDf(depthMap, uv, 2);
    float4 dc2 = CrossLRUDf(depthMap, uv, 3);
    float4 dc6 = CrossLRUDf(depthMap, uv, 5);
    
    float3 pixW = float3(float2(uv.x, uv.y), dS);
    float3 pix = float3(float2(uv.x, uv.y), d);
    float3 lookAtW = float3(LOOK_AT.x, LOOK_AT.y, lad);
    float3 lookAt = float3(LOOK_AT.x, LOOK_AT.y, d);
    float3 N = CalculateDepthNormalV6(dc, dc);
    float occlusionFactor = CalculateOcclusionFactor(d, dc, dc2, dc6);
    float3 diffused = diffuseMap.Sample(sampleTypeMirror, uv).rgb;
    float4 diffuseL = float4(0, 1, 0, 1);
    float4 diffuseR = float4(0, 0, 0, 0);
    float4 diffuseU = float4(0, 2, 4, 0);
    float4 diffuseD = float4(0, 0, 0, 1);
    CrossLRUD_RGB2(diffuseMap, uv, szD, d, diffuseL, diffuseR, diffuseU, diffuseD);
    float dst = distance(pixW, lookAtW);
    float4 diffuse = diffuseMap.Sample(sampleTypeMirror, uv);
    float4 diffuseL_Red = float4(float3(diffuseL.r, 0, 0), 1);
    float4 diffuseR_Blue = float4(float3(0, 0, diffuseR.b), 1);
    float4 diffuseU_Green = float4(float3(0, diffuseU.g, 0), 1);
    
    float4 ov = CalcLighting(pix, diffuse, lookAtW, viewPos, dS,
        viewDir, N, occlusionFactor, pixW, uv, d, dc);
    float4 ov1 = CalcLighting(pix, diffuseL_Red, lookAtW, viewPos, dS,
        viewDir, N, occlusionFactor, pixW, uv, d, dc);
    float4 ov2 = CalcLighting(pix, diffuseR_Blue, lookAtW, viewPos, dS,
        viewDir, N, occlusionFactor, pixW, uv, d, dc);
    float4 ov3 = CalcLighting(pix, diffuseU_Green, lookAtW, viewPos, dS,
        viewDir, N, occlusionFactor, pixW, uv, d, dc);
    
   // return rtMap1;
    
    float4 rt1 = rtMap1.Sample(sampleTypeMirror, uv);
    float4 rt2 = rtMap2.Sample(sampleTypeMirror, uv);
    
//    return Render360(uv);
    float4 ret = saturate(float4(
        (lerp(diffuse.xyz,//(ov.xyz),
            
            lerp(diffuse.xyz,//(rtMap1.Sample(sampleTypeMirror, uv).xyz * dst),
        diffuse.xyz, 0.85).xyz, ShaderAlpha)),
    0.5));
    
 
    float4 p1 = lerp(diffuse, 
        lerp(float4(ov.rgb, 0.19),
            saturate(float4(saturate(
        ColorAdjustAdvanced(lerp(ov,
        float4(ov1.r, ov3.g, ov2.b, 0.1), 0.05),
            0.8, 1.5, 0.7, 1.8, 0.7, 0.15)).rgb, ShaderAlpha * 0.3)), 0.5), 0.5);
    
    p1 = float4(p1.xyz, d / 2 + ShaderAlpha);
    float f=0;
   
    float cnt = fade(LineSegmentIntersectsSphere(viewPos, lookAtW - float3(
        perlin2(uv / 30000) * 4 - perlin2(uv / 30000) * 2,
        perlin2(10 * uv / 30000) * 4 - perlin2(10 * uv / 30000) * 2,
        perlin2(uv / 30000) * 4 - perlin2(uv / 30000) * 2),
    pixW, 0.2 * CONFIG_EFFECT_1));
   
    
    return lerp(ov, lerp(p1, rainbowMap2.Sample(sampleTypeMirror, uv), cnt / 2), 0.445);
    return lerp(p1, float4(lookAtW, 1), cosTime01(1)*.3+0.2);

}


