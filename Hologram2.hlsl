// Content of Hologram2_010.hlsl
#define ViewportWidth 1024
#define ViewportHeight 970

#define OCCLUSION_MIN_DIFFERENCE 0.002
#define PI 3.14159265358979
#define MATH_E 2.71828

#define timr (AnimateSpeed)

cbuffer ConstantBuffer : register(b0)
{
    //Mouse position in UV coordinates. 0.5,0.5 is center screen
    float2 LOOK_AT;
    float2 LOOK_AT_DELTA;
    
    //Number of render passes
    int NumPasses;
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
    float NormalRadius;
    //Mix1,2,3 are reserved for future use
    float Mix1;
    float Mix2;
    float Mix3;
};



struct VS_INPUT
{
    float3 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
};

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


Texture2D diffuseMap : register(t0);
Texture2D depthMap : register(t1);
Texture2D skylineMap : register(t2);
Texture2D rainbowMap2 : register(t3);
//Texture2D normalMap : register(t4);
Texture2D normalMap : register(t4);
Texture2D normalMap2 : register(t5);
Texture2D rtMap1 : register(t6);
Texture2D rtMap2 : register(t7);
Texture2D rtMap3 : register(t8);
Texture2D rtMap4 : register(t9);
Texture2D rtMap5 : register(t10);
Texture2D rtMap6 : register(t11);
Texture2D rtMap7 : register(t12);
Texture2D rtMap8 : register(t13);
Texture2D rtMap9 : register(t14);
Texture2D rtMap10 : register(t15);
Texture2D rtMap11 : register(t16);
Texture2D rtMap12 : register(t17);
Texture2D rtMap13 : register(t18);
Texture2D rtMap14 : register(t19);
Texture2D rtMap15 : register(t20);
Texture2D rtMap16 : register(t21);
Texture2D computeMap : register(t23);
//Texture2D depthStencilMap : register(t5);


#define zoMin 0.00001
#define zoMax 0.99999

float4 clamp01(float4 uv)
{
    return clamp(uv, zoMin, zoMax);
}
float2 clamp01(float2 uv)
{
    return clamp(uv, zoMin, zoMax);
}
float clamp01(float v)
{
    return clamp(v, zoMin, zoMax);
}



float4 mir2D(Texture2D tex, float2 uv)
{
    return tex.Sample(sampleTypeMirror, uv);
}
float4 mir2D(Texture2D tex, int3 uv)
{
    int2 sz;
    tex.GetDimensions(sz.x, sz.y);
    uv.x = abs(uv.x%sz.x);
    uv.y = abs(uv.y%sz.y);
    return tex.Load(uv);
}
float4 mir2D11(Texture2D tex, float2 uv)
{
    return mir2D(tex, uv) * 2.0 - 1.0;
}
float mir2Df(Texture2D tex, float2 uv)
{
    return mir2D(tex, uv).r;
}
float mir2Df(Texture2D tex, int3 uv)
{
    return mir2D(tex, uv).r;
}
float mir2Df11(Texture2D tex, float2 uv)
{
    return mir2Df(tex, uv) * 2.0 - 1.0;
}


float4 point2D(Texture2D tex, float2 uv)
{
    return tex.Sample(sampleTypeLinear, uv);
}
float4 point2D11(Texture2D tex, float2 uv)
{
    return point2D(tex, uv) * 2.0 - 1.0;
}

float point2Df(Texture2D tex, float2 uv)
{
    return point2D(tex, uv).r;
}
float point2Df11(Texture2D tex, float2 uv)
{
    return point2Df(tex, uv) * 2.0 - 1.0;
}


float4 load2D(Texture2D tex, float2 uv)
{
    int3 tuv;
    tex.GetDimensions(tuv.x, tuv.y);
    tuv = int3(tuv.x, tuv.y, 0);
    
    return tex.Load(int3(int(uv.x * float(tuv.x)), int(uv.y * float(tuv.y)), 0));
}

float load2Df(Texture2D tex, float2 uv)
{
    return load2D(tex, uv).r;
}

float load2Df11(Texture2D tex, float2 uv)
{
    return load2Df(tex, uv) * 2.0 - 1.0;
}

float depth2Df(float2 uv)
{
    return mir2Df(depthMap, uv);
}
float depth2Df(int3 uv)
{
    return mir2Df(depthMap, uv);
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

    w = (float) 1.0 / tan(fov_horiz * 0.5); // 1/tan(x) == cot(x)
    h = (float) 1.0 / tan(fov_vert * 0.5); // 1/tan(x) == cot(x)
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
    float depth = depth2Df(viewPoint.xy);
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

float4 ProjectPointInsideCone(float4 p, float4 coneTip, float4 coneDir, float coneAngle)
{
    float4 v = p - coneTip;
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

    float discriminant = b * b - 4.0 * a * c;
    if (discriminant < 0.0)
    {
        return false;
    }
    else
    {
        discriminant = sqrt(discriminant);
        float t1 = (-b - discriminant) / (2.0 * a);
        float t2 = (-b + discriminant) / (2.0 * a);

        if (t1 >= 0.0 && t1 <= 1.0)
            return true;

        if (t2 >= 0.0 && t2 <= 1.0)
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
            sN = 0.0;
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

    if (f > 0.0 && d >= 0.0 && d <= f)
        return true;
    if (f < 0.0 && d <= 0.0 && d >= f)
        return true;

    a = q2 - p2;
    b = p1 - p2;
    c = q1 - p2;

    f = a.x * b.y - a.y * b.x;
    d = a.x * c.y - a.y * c.x;

    if (f > 0.0 && d >= 0.0 && d <= f)
        return true;
    if (f < 0.0 && d <= 0.0 && d >= f)
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
            sN = 0.0;
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
            sN = 0.0;
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
        z = d.Sample(sampleTypeMirror, q.xy).r; // depth value at the projected point
        
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
static int perm[512] = { 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183, 195, 170, 178, 161, 63, 211, 101, 90, 165, 60, 196, 32, 218, 31, 201, 22, 171, 216, 128, 130, 214, 98, 241, 159, 3, 210, 242, 116, 187, 132, 70, 57, 137, 199, 59, 2, 77, 9, 156, 34, 186, 235, 200, 182, 42, 153, 48, 175, 131, 225, 250, 114, 238, 65, 58, 135, 15, 76, 227, 209, 47, 19, 10, 215, 240, 234, 142, 133, 172, 4, 91, 13, 149, 0, 97, 188, 49, 25, 46, 37, 41, 120, 81, 54, 193, 126, 52, 191, 18, 169, 179, 162, 86, 73, 158, 20, 66, 166, 87, 239, 248, 155, 33, 229, 252, 106, 189, 100, 29, 103, 117, 185, 246, 145, 53, 6, 167, 190, 71, 95, 110, 80, 111, 35, 8, 74, 173, 26, 125, 140, 21, 222, 104, 226, 198, 160, 40, 219, 84, 236, 43, 108, 233, 113, 51, 237, 139, 174, 123, 152, 228, 83, 150, 62, 88, 207, 146, 197, 94, 11, 143, 14, 121, 50, 45, 12, 168, 147, 92, 203, 180, 154, 16, 68, 245, 1, 181, 55, 208, 134, 44, 61, 204, 255, 247, 164, 118, 7, 36, 177, 79, 89, 127, 144, 232, 217, 109, 148, 220, 28, 184, 122, 194, 129, 138, 105, 102, 249, 99, 107, 23, 202, 205, 17, 192, 112, 56, 124, 115, 75, 64, 39, 82, 96, 78, 93, 224, 244, 136, 230, 212, 176, 27, 72, 221, 151, 251, 5, 24, 254, 119, 69, 157, 253, 30, 163, 141, 206, 243, 213, 85, 38, 231, 67, 223, 183 };

// Perlin Noise Implementation
float Fade(float t)
{
    // Fade function as defined by Ken Perlin
    // 6t^5 - 15t^4 + 10t^3
    return t * t * t * (t * (t * 6 - 15) + 10);
}

float lerp1D(float t, float a, float b)
{
    // Linear interpolation
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
float grad(int hash, float3 g)
{
    int h = hash & 15;
    float u = h < 8 ? g.x : g.y;
    float v = h < 4 ? g.y : (h == 12 || h == 14 ? g.x : g.z);
    return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
}

float2 Random2(float2 p)
{
    return frac(sin(float2(dot(p, float2(127.1, 311.7)),
                          dot(p, float2(269.5, 183.3)))) * 43758.5453);
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

    int A = (perm[X] + Y) & 255;
    int AA = (perm[A] + Z) & 255;
    int AB = (perm[A + 1] + Z) & 255;
    int B = (perm[X + 1] + Y) & 255;
    int BA = (perm[B] + Z) & 255;
    int BB = (perm[B + 1] + Z) & 255;

    float res = lerp1D(w, lerp1D(v, lerp1D(u, grad(perm[AA], x, y, z),
                                   grad(perm[BA], x - 1, y, z)),
                           lerp1D(u, grad(perm[AB], x, y - 1, z),
                                grad(perm[BB], x - 1, y - 1, z))),
                     lerp1D(v, lerp1D(u, grad(perm[AA + 1], x, y, z - 1),
                                  grad(perm[BA + 1], x - 1, y, z - 1)),
                          lerp1D(u, grad(perm[AB + 1], x, y - 1, z - 1),
                               grad(perm[BB + 1], x - 1, y - 1, z - 1))));
    return (res + 1.0) / 2.0; // Normalize to [0,1]
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
    float2 sz = 1.0 / wh;
    
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
    float f2 = frac(TotalTime);
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

// Worley Noise function for bubbly effect
float WorleyNoise(float2 uv, float bubbleSize)
{
    float d = 1.0;
    uv *= bubbleSize;
    for (int x = -1; x <= 1; x++)
    {
        for (int y = -1; y <= 1; y++)
        {
            float2 lattice = floor(uv) + float2(x, y);
            float2 offset = perlin2_2(lattice);
            d = min(d, length(uv - lattice - offset));
        }
    }
    return d;
}

float noise3(float3 position)
{
    position = frac(sin(position) * 43758.5453);
    return frac(position.x + position.y * 57.0 + 113.0 * position.z);
}
float noise31(float3 position)
{
    return noise3(position);
}

float2 noise32(float3 position)
{
    return float2(noise3(position), noise3(position));
}
float2 noise22(float2 position)
{
    return float2(noise3(float3(position, 0)), noise3(float3(position, 1)));
}
float noise21(float2 position)
{
    return noise3(float3(position, 0));
}

float perlin3(float3 position)
{
    float3 p = floor(position);
    float3 f = frac(position);
    f = f * f * (3.0 - 2.0 * f); // cubic fade

    float n = p.x + p.y * 157.0 + 113.0 * p.z;

    float g1 = grad(perm[int(n) % 256], f - float3(0, 0, 0));
    float g2 = grad(perm[int(n + 1.0) % 256], f - float3(1, 0, 0));
    float g3 = grad(perm[int(n + 157.0) % 256], f - float3(0, 1, 0));
    float g4 = grad(perm[int(n + 158.0) % 256], f - float3(1, 1, 0));
    float g5 = grad(perm[int(n + 113.0) % 256], f - float3(0, 0, 1));
    float g6 = grad(perm[int(n + 114.0) % 256], f - float3(1, 0, 1));
    float g7 = grad(perm[int(n + 270.0) % 256], f - float3(0, 1, 1));
    float g8 = grad(perm[int(n + 271.0) % 256], f - float3(1, 1, 1));

    float x1 = lerp(g1, g2, f.x);
    float x2 = lerp(g3, g4, f.x);
    float y1 = lerp(x1, x2, f.y);
    float x3 = lerp(g5, g6, f.x);
    float x4 = lerp(g7, g8, f.x);
    float y2 = lerp(x3, x4, f.y);

    return lerp(y1, y2, f.z);
}


float perlin1(float f)
{
    return perlin3(float3(0, f, 0));
}

float3 perlin3_3(float3 position)
{
    float3 p = floor(TotalTime + position);
    float3 f = frac(TotalTime + position);
    f = f * f * (3.0 - 2.0 * f); // cubic fade
    float f2 = frac(length(position));
    float n = p.x + p.y * 157.0 + 2113.0 * p.z;
    float g1 = grad(perm[int(n) % 256], f.x + f2, f.y, f.z);
    float g2 = grad(perm[int(n + 157.0) % 256], f.x + f2, f.y - 1.0, f.z);
    float g3 = grad(perm[int(n + 113.0) % 256], f.x, f.y + f2, f.z - 1.0);
    float g4 = grad(perm[int(n + 270.0) % 256], f.x, f.y - 1.0, f.z - f2 - 1.0);
    
    return float3(noise3(g3), noise3(g1 + g4), noise3(g2));
}

float perlin3(float2 position)
{
    return perlin3(float3(position, 0));
}

float2 perlin3_2(float2 position)
{
    return float2(
        perlin3(float3(position, 0)),
        perlin3(float3(position, 0)));
}

float2 perlin3_2(float3 position)
{
    return float2(
        perlin3(position),
        perlin3(position));
}

float sinTime01(float timeMul)
{
    return ((1.0 + sin(TotalTime * timeMul)) / 2.0);
}
float cosTime01(float timeMul)
{
    return ((1.0 + cos(TotalTime * timeMul)) / 2.0);
}
float cosTime01cos01(float timeMul, float timeMul2)
{
    return ((1.0 + cos(TotalTime * timeMul * cosTime01(TotalTime * timeMul2))) / 2.0);
}



// Relaxed cone stepping function
//RayIntersectsDepthMap
void RelaxedConeStepping(float2 texCoord, float3 eyeVec, float3 lightVec, SamplerState heightMap, SamplerState mhdMap, float relaxFactor, float maxSteps, float epsilon, out bool hit, out float3 hitPos)
{
  // Initialize the ray origin and direction based on the light position and direction
    float3 rayOrigin = float3(texCoord, depth2Df(texCoord));
    float3 rayDirection = -lightVec;
  // Normalize the ray direction
    rayDirection /= rayDirection.z;
  // Initialize the hit flag and position
    hit = false;
    hitPos = float3(0, 0, 0);
  // Initialize the step counter and distance
    float step = 0.0;
    float t = 0.0;
  // Loop until a hit is found or the ray exits the quad
    while (step < maxSteps && t < 1.0)
    {
    // Increment the step counter
        step++;
    // Calculate the current ray position
        float3 rayPos = rayOrigin + t * rayDirection;
    // Sample the height map and the mhd map at the current ray position
        float height = depth2Df(rayPos.xy);
       //float mhd = texture(mhdMap, rayPos.xy).r;///////////////////////////////here
        float mhd = 0;
    // Compare the ray height with the height map height and the mhd value
        if (rayPos.z > height - mhd && rayPos.z < height + mhd)
        {
      // Perform a binary search to refine the intersection point
            float low = t - mhd * rayDirection.z;
            float high = t + mhd * rayDirection.z;
            for (int i = 0; i < 5; i++)
            { // You can adjust this loop count according to your needs
        // Calculate the mid point
                float mid = (low + high) / 2.0;
        // Sample the height map at the mid point
                float midHeight = depth2Df((rayOrigin + mid * rayDirection).xy);
        // Compare the mid point height with the ray height
                if (midHeight > (rayOrigin + mid * rayDirection).z)
                {
          // The mid point is above the ray, so move the high point down
                    high = mid;
                }
                else
                {
          // The mid point is below or on the ray, so move the low point up
                    low = mid;
                }
            }
      // Set the hit flag and position to true and low point
            hit = true;
            hitPos = rayOrigin + low * rayDirection;
      // Break out of the loop
            break;
        }
        else
        {
      // Calculate the cone radius based on the mhd value and the relaxation factor
            float coneRadius = relaxFactor * mhd;
      // Advance the distance by adding the cone radius to the ray height
            t += (rayPos.z + coneRadius) / rayDirection.z;
        }
    }
}



float4x4 GetScreenSpaceProjectionMatrix()
{
    return float4x4(1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, -1,
			0, 0, 0, 1);
}


float4x4 GetWorldToScreenSpaceMatrix()
{
    return float4x4(ViewportWidth, 0, 0, 0,
			0, ViewportHeight, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1);
}

float4x4 GetWorldToScreenSpaceMatrix2()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(projection, view);
}
float4x4 GetScreenToWorldSpaceMatrix()
{
    return float4x4(1 / ViewportWidth, 0, 0, 0,
			0, 1 / ViewportHeight, 0, 0,
			0, 0, 1, 0,
			0, 0, 0, 1);
}

float4x4 GetScreenToWorldSpaceMatrix2()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(mul(inverse(projection), inverse(view)), projection);
}

float4x4 GetWorldToLightSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(projection, view);
}

float4x4 GetLightSpaceToScreenSpaceMatrix()
{
    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return projection;
}

float4x4 GetWorldToShadowMapSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(projection, view);
}


float4x4 GetShadowMapToWorldSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(mul(inverse(projection), inverse(view)), projection);
}

float4x4 GetScreenToShadowMapSpaceMatrix()
{
    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return projection;
}

float4x4 GetShadowMapToScreenSpaceMatrix()
{
    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return projection;
}


float4x4 GetScreenToLightSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(mul(inverse(projection), inverse(view)), projection);
}

float4x4 GetLightSpaceToWorldSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(mul(inverse(projection), inverse(view)), projection);
}

float4x4 GetWorldToViewSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    return view;
}

float4x4 GetViewToWorldSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    return transpose(view);
}

float4x4 GetViewToScreenSpaceMatrix()
{
    float4x4 view = float4x4(1, 0, 0, 0,
			    0, 0, -1, 0,
			    0, 1, 0, 0,
			    0, 0, 0, 1);

    float4x4 projection = float4x4(1, 0, 0, 0,
				  0, 1, 0, 0,
				  0, 0, 0.001, -1,
				  0, 0, 1, 0);

    return mul(projection, view);
}

// Content of Hologram2_020.hlsl

float4 Fresnel(float4 cosTheta)
{
    return exp2((cosTheta * -5.55473 - 6.98316) * cosTheta);
}

float4 Schlick(float4 F0, float4 fresnel, float4 fresnelPower)
{
    return ((F0 * (1.0 - fresnel)) + fresnelPower * fresnel);
}

float4 FresnelSchlick2(float4 F0, float4 V, float4 N, float4 fresnelPower)
{
    //float cosTheta = dot(V, N);
    //return F0 + (1.0 - F0) * pow(abs(1.0 - cosTheta), fresnelPower.xyz);
    
    float4 cosTheta = dot(N, V);
    float4 fresnel = Fresnel(cosTheta);
    return Schlick(F0, fresnel, fresnelPower);

}

// Define a function to calculate the reflection direction given the incidence direction and the normal vector
float4 reflect(float4 i, float4 n)
{
    // Use the formula r = i - 2 * dot(i, n) * n
    return i - 2.0 * dot(i, n) * n;
}



// Define a function to calculate the reflection direction given the incidence direction and the normal vector
float3 reflect(float3 i, float3 n)
{
    // Use the formula r = i - 2 * dot(i, n) * n
    return i - 2.0 * dot(i, n) * n;
}

float4 FresnelSchlick(float4 refractiveIndex, float4 surroundingRefractiveIndex, float4 cosIncidenceAngle)
{
    float4 F0 = (refractiveIndex * refractiveIndex - surroundingRefractiveIndex * surroundingRefractiveIndex) / (refractiveIndex * refractiveIndex + surroundingRefractiveIndex * surroundingRefractiveIndex);
    return F0 + (1.0f - F0) * pow(1.0f - cosIncidenceAngle, 5.0f);
}



struct DichroismParams
{
    float thickness;
    float refractiveIndex;
};

float4 DichroicShader(float4 baseColor, DichroismParams params, float3 viewDir, float3 lightDir)
{
  // Calculate the wavelength of light.
    float wavelength = 550.0f * 10e-9f; // 550 nm in meters.

  // Calculate the refractive index of the surrounding medium.
    float surroundingRefractiveIndex = 1.0f; // Air.

  // Calculate the phase shift of the light due to the thin film.
    float phaseShift = 2.0f * 3.14159265357 * params.thickness * (sqrt(params.refractiveIndex * params.refractiveIndex - surroundingRefractiveIndex * surroundingRefractiveIndex) - surroundingRefractiveIndex);

  // Calculate the transmittance of the thin film.
    float transmittance = (1.0f + cos(phaseShift)) / 2.0f;

  // Calculate the reflected color of the thin film.
    float4 reflectedColor = baseColor * (1.0f - transmittance);

  // Calculate the transmitted color of the thin film.
    float4 transmittedColor = baseColor * transmittance;

  // Calculate the Fresnel coefficient of the thin film.
    float4 fresnel = FresnelSchlick(params.refractiveIndex, surroundingRefractiveIndex, acos(dot(viewDir, lightDir)));

  // Calculate the final color of the surface.
    float4 finalColor = lerp(reflectedColor, transmittedColor, transmittance * fresnel);

    return finalColor;
}


float3 Dichroism(float3 incidentLight, float3 normal, float dichroicRatio)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 dichroicColor = lerp(float3(1, 0, 0), float3(0, 0, 1), dichroicRatio);
    return reflectedLight * dichroicColor;
}

float3 Iridescence(float3 incidentLight, float3 normal, float iridescenceFactor)
{
    float incidenceAngle = dot(incidentLight, normal);
    float iridescence = incidenceAngle * iridescenceFactor;
    float3 iridescentColor = float3(iridescence, iridescence, iridescence);
    return iridescentColor;
}

float3 Roughness(float3 incidentLight, float3 normal, float roughnessValue)
{
    float3 halfVector = normalize(incidentLight + float3(0, 1, 0)); // Assuming a fixed view direction
    float spec = pow(max(0, dot(normal, halfVector)), roughnessValue * 128);
    return float3(spec, spec, spec);
}

float3 Metalness(float3 incidentLight, float3 normal, float metalnessValue)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 metalColor = lerp(float3(0.5, 0.5, 0.5), float3(1, 1, 1), metalnessValue);
    return reflectedLight * metalColor;
}

float3 Coating1(float3 incidentLight, float3 normal, float coating1Value)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 coatingColor = lerp(float3(0.2, 0.2, 0.2), float3(1, 1, 1), coating1Value);
    return reflectedLight * coatingColor;
}

float3 Coating2(float3 incidentLight, float3 normal, float coating2Value)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 coatingColor = lerp(float3(0.2, 0.8, 0.2), float3(1, 1, 1), coating2Value);
    return reflectedLight * coatingColor;
}

float3 Dichroism2(float3 incidentLight, float3 normal, float4 dichroicRatio)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 dichroicColor = lerp(float3(1, 0, 0), float3(0, 0, 1), dichroicRatio.xyz);
    return reflectedLight * dichroicColor;
}

float3 Iridescence2(float3 incidentLight, float3 normal, float4 iridescenceFactor)
{
    float incidenceAngle = dot(incidentLight, normal);
    float3 iridescence = incidenceAngle * iridescenceFactor.xyz;
    float3 iridescentColor = iridescence;
    return iridescentColor;
}

float3 Roughness2(float3 incidentLight, float3 normal, float4 roughnessValue)
{
    float3 halfVector = normalize(incidentLight + float3(0, 1, 0)); // Assuming a fixed view direction
    float3 spec = pow(max(0, dot(normal, halfVector)), roughnessValue.xyz * 128);
    return spec.xyz;
}

float3 Metalness2(float3 incidentLight, float3 normal, float4 metalnessValue)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 metalColor = lerp(float3(0.5, 0.5, 0.5), float3(1, 1, 1), metalnessValue.xyz);
    return reflectedLight * metalColor;
}

float3 Coating12(float3 incidentLight, float3 normal, float4 coating1Value)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 coatingColor = lerp(float3(0.2, 0.2, 0.2), float3(1, 1, 1), coating1Value.xyz);
    return reflectedLight * coatingColor;
}

float3 Coating22(float3 incidentLight, float3 normal, float4 coating2Value)
{
    float3 reflectedLight = reflect(incidentLight, normal);
    float3 coatingColor = lerp(float3(0.2, 0.8, 0.2), float3(1, 1, 1), coating2Value.xyz);
    return reflectedLight * coatingColor;
}
float3 MixSurfaceEffects(
    float3 incidentLight,
    float3 normal,
    float4 dichroicRatio,
    float4 iridescenceFactor,
    float4 roughnessValue,
    float4 metalnessValue,
    float4 coating1Value,
    float4 coating2Value
)
{
    
    // Call each surface effect function
    float3 dichroicColor = Dichroism2(incidentLight, normal, dichroicRatio);
    float3 iridescentColor = Iridescence2(incidentLight, normal, iridescenceFactor);
    float3 roughnessColor = Roughness2(incidentLight, normal, roughnessValue);
    float3 metalnessColor = Metalness2(incidentLight, normal, metalnessValue);
    float3 coating1Color = Coating12(incidentLight, normal, coating1Value);
    float3 coating2Color = Coating22(incidentLight, normal, coating2Value);
    
    // Define blend factors for each surface effect
    // These blend factors are arbitrary and you may want to replace them with your own logic
    static float blendFactors[6] = { 0.2, 0.2, 0.2, 0.2, 0.1, 0.1 };
    
    // Blend the colors together based on the blend factors
    float3 resultColor = float3(0, 0, 0);
    resultColor += dichroicColor * blendFactors[0];
    resultColor += iridescentColor * blendFactors[1];
    resultColor += roughnessColor * blendFactors[2];
    resultColor += metalnessColor * blendFactors[3];
    resultColor += coating1Color * blendFactors[4];
    resultColor += coating2Color * blendFactors[5];
    
    return resultColor;
}

float4 AdjustSaturation(float4 color, float saturation)
{
    // Apply saturation adjustment using luminance-preserving method
    float luminance = dot(color, float4(0.3, 0.59, 0.11, 1.0));
    color = saturate(lerp(luminance, color, saturation));

    return color;
}


float4 ApplyGamma(float4 color, float gamma)
{
    // Apply gamma correction separately to R, G, and B channels
    color = pow(abs(color), float4(1.0 / gamma, 1.0 / gamma, 1.0 / gamma, 1.0));

    return color;
}

float4 ApplySurfaceEffects(float4 diffuse, float3 viewDir, float3 normal, float2 uv, float fresnelPower)
{
    float4 fres = Fresnel(diffuse);
    
    diffuse =
    (saturate(Schlick(diffuse, fres, fresnelPower) *
        float4(MixSurfaceEffects(
            normalize(-viewDir),
            normalize(normal),
            Schlick(diffuse, fres, -fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, -fresnelPower),
            Schlick(diffuse, fres, -fresnelPower)),
        1
    )) +
    saturate(Schlick(diffuse, fres, fresnelPower) *
        float4(MixSurfaceEffects(
            normalize(-viewDir),
            normalize(normal),
            Schlick(diffuse, fres, -fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, fresnelPower),
            Schlick(diffuse, fres, -fresnelPower),
            Schlick(diffuse, fres, -fresnelPower)),
        1
    ))) * .5;
    return diffuse;

}

float4 XLRUDf(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        float4(mir2D(tex, uv + oosz * float2(-range, -range)).r,
               mir2D(tex, uv + oosz * float2(range, -range)).r,
               mir2D(tex, uv + oosz * float2(-range, range)).r,
               mir2D(tex, uv + oosz * float2(range, range)).r
            );
}


float XLRUDfAvgN(float2 oosz, Texture2D tex, float2 uv, float range, int color)
{
    return
        (mir2D(tex, uv)[color] + (
            mir2D(tex, uv + oosz * float2(-range, -range))[color] +
            mir2D(tex, uv + oosz * float2(range, -range))[color] +
            mir2D(tex, uv + oosz * float2(-range, range))[color] +
            mir2D(tex, uv + oosz * float2(range, range))[color]
        ) / 4.0) / 2.0;
}

float XLRUDfAvg(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        (mir2D(tex, uv).r + (
        mir2D(tex, uv + oosz * float2(-range, -range)).r +
               mir2D(tex, uv + oosz * float2(range, -range)).r +
               mir2D(tex, uv + oosz * float2(-range, range)).r +
               mir2D(tex, uv + oosz * float2(range, range)).r
            ) / 4.0) / 2.0;
}


float2 XLRUDfAvg2(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        float2((mir2D(tex, uv).r + (
        mir2D(tex, uv + oosz * float2(-range, range)).r +
               mir2D(tex, uv + oosz * float2(range, range)).r
            ) / 2.0) / 2.0,
        (mir2D(tex, uv).r + (
               mir2D(tex, uv + oosz * float2(-range, -range)).r +
               mir2D(tex, uv + oosz * float2(range, -range)).r
            ) / 2.0) / 2.0);
}


void XLRUD4f(float2 oosz, Texture2D tex, float2 uv, int range, out float4 UL, out float4 UR, out float4 LL, out float4 LR)
{
    UL = mir2D(tex, uv + oosz * float2(-range, -range));
    UR = mir2D(tex, uv + oosz * float2(range, -range));
    LL = mir2D(tex, uv + oosz * float2(-range, range));
    LR = mir2D(tex, uv + oosz * float2(range, range));
    
}


float4 XLRUDi(Texture2D tex, int3 uv, int range)
{
    return
        float4(tex.Load(uv + int3(-range, -range, 0)).r,
               tex.Load(uv + int3(range, -range, 0)).r,
               tex.Load(uv + int3(-range, range, 0)).r,
               tex.Load(uv + int3(range, range, 0)).r
            );
}

void XLRUD4i(Texture2D tex, int3 uv, int range, out float4 UL, out float4 UR, out float4 LL, out float4 LR)
{
    UL = tex.Load(uv + int3(-range, -range, 0));
    UR = tex.Load(uv + int3(range, -range, 0));
    LL = tex.Load(uv + int3(-range, range, 0));
    LR = tex.Load(uv + int3(range, range, 0));
}

void CrossLRUD_RGB(Texture2D tex, int3 iuv, int range,
    out float4 l, out float4 r, out float4 u, out float4 d)
{
    l = tex.Load(iuv, int2(-range, 0));
    r = tex.Load(iuv, int2(range, 0));
    u = tex.Load(iuv, int2(0, -range));
    d = tex.Load(iuv, int2(0, range));
}

void XLRUD_RGB2(Texture2D tex, float2 uv, float2 szD, float dep, float dst,
    out float4 l, out float4 r, out float4 u, out float4 dr)
{
    l = mir2D(tex, uv + float2(-1, -1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    r = mir2D(tex, uv + float2(-1, 1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    u = mir2D(tex, uv + float2(1, 1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    dr = mir2D(tex, uv + float2(1, -1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
}

void CrossLRUD_RGB2(Texture2D tex, float2 uv, float2 szD, float dep, float dst,
    out float4 l, out float4 r, out float4 u, out float4 dr)
{
    l = mir2D(tex, uv + float2(-1, 0) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    r = mir2D(tex, uv + float2(1, 0) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    u = mir2D(tex, uv + float2(0, -1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
    dr = mir2D(tex, uv + float2(0, 1) * szD * dst * (1 - dep) * length(uv - float2(0.5, 0.5)));
}


float4 GetDepthCrossLRUD(int3 iuv, int sampleRadius)
{
    return float4(
        depth2Df(iuv + int3(-sampleRadius, 0, 0)),
        depth2Df(iuv + int3(sampleRadius, 0, 0)),
        depth2Df(iuv + int3(0, -sampleRadius, 0)),
        depth2Df(iuv + int3(0, sampleRadius, 0)));
}


float4 CrossLRUDi(Texture2D tex, int3 uv, int range)
{
    return
        float4(load2Df(tex, uv + int3(-range, 0, 0)),
               load2Df(tex, uv + int3(range, 0, 0)),
               load2Df(tex, uv + int3(0, -range, 0)),
               load2Df(tex, uv + int3(0, range, 0))
            );
}

void CrossLRUD4i(Texture2D tex, int3 uv, int range, out float4 L, out float4 R, out float4 U, out float4 D)
{
    L = tex.Load(uv + int3(-range, 0, 0));
    R = tex.Load(uv + int3(range, 0, 0));
    U = tex.Load(uv + int3(0, -range, 0));
    D = tex.Load(uv + int3(0, range, 0));
}


float4 CrossLRUDf(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        float4(mir2Df(tex, uv + oosz * float2(-range, 0)),
               mir2Df(tex, uv + oosz * float2(range, 0)),
               mir2Df(tex, uv + oosz * float2(0, -range)),
               mir2Df(tex, uv + oosz * float2(0, range))
            );
}
float CrossLRUDfAvgN(float2 oosz, Texture2D tex, float2 uv, float range, int color)
{
    return
        (mir2D(tex, uv)[color] +
            (mir2D(tex, uv + oosz * float2(-range, 0))[color] +
            mir2D(tex, uv + oosz * float2(range, 0))[color] +
            mir2D(tex, uv + oosz * float2(0, -range))[color] +
            mir2D(tex, uv + oosz * float2(0, range))[color]
        ) / 4.0) / 2.0;
}
float CrossLRUDfAvg(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        (mir2Df(tex, uv) +
            (mir2Df(tex, uv + oosz * float2(-range, 0)) +
               mir2Df(tex, uv + oosz * float2(range, 0)) +
               mir2Df(tex, uv + oosz * float2(0, -range)) +
               mir2Df(tex, uv + oosz * float2(0, range))
            ) / 4.0) / 2.0;
}

float2 CrossLRUDfAvg2(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return
        float2((mir2Df(tex, uv) +
            (mir2Df(tex, uv + oosz * float2(-range, 0)) +
               mir2Df(tex, uv + oosz * float2(range, 0))
            ) / 2.0) / 2.0,
            (mir2Df(tex, uv) +
            (mir2Df(tex, uv + oosz * float2(0, -range)) +
               mir2Df(tex, uv + oosz * float2(0, range))
            ) / 2.0) / 2.0);
}


void CrossLRUD4f(float2 oosz, Texture2D tex, float2 uv, int range, out float4 L, out float4 R, out float4 U, out float4 D)
{
    L = mir2D(tex, uv + oosz * float2(-range, 0));
    R = mir2D(tex, uv + oosz * float2(range, 0));
    U = mir2D(tex, uv + oosz * float2(0, -range));
    D = mir2D(tex, uv + oosz * float2(0, range));
}

float XCrossLRUDfAvgN(float2 oosz, Texture2D tex, float2 uv, float range, int color)
{
    return (XLRUDfAvgN(oosz, tex, uv, range + 1, color) + CrossLRUDfAvgN(oosz, tex, uv, range, color)) / 2.0;
}


float XCrossLRUDfAvg(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return (XLRUDfAvg(oosz, tex, uv, range + 1) + CrossLRUDfAvg(oosz, tex, uv, range)) / 2;
}

float2 XCrossLRUDfAvg2(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return (XLRUDfAvg2(oosz, tex, uv, range + 1) + CrossLRUDfAvg2(oosz, tex, uv, range)) / 2;
}


float3 XCrossLRUDfAvg3(float2 oosz, Texture2D tex, float2 uv, float range)
{
    return float3(
        XLRUDfAvgN(oosz, tex, uv, range + 1, 0),
        XLRUDfAvgN(oosz, tex, uv, range + 1, 1),
        XLRUDfAvgN(oosz, tex, uv, range + 1, 2));
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
                miud * (-23000.21 + (sin(frac(TotalTime) * -30.3) * -1)) + mc * -
32 - micr)
        );
    }
};


float4 CalculateDepthNormalV6(float4 depthCross, float depth)
{
    float c = depth;
    float l = depthCross.x;
    float r = depthCross.y;
    float u = depthCross.z;
    float d = depthCross.w;

    float4 tangentX = float4(1, 0, r - l, 1);
    float4 tangentY = float4(0, 1, u - d, 1);

    float4 normal = float4(cross(tangentX.xyz, tangentY.xyz), 1);
    
    return float4(normalize(normal).xyz, 1);

}

float4 CalculateNormal(int3 iuv, int3 offset, float radius, float depthScale)
{
    float c = depth2Df(iuv + offset) * depthScale;
    float l = depth2Df(iuv + offset + int3(-1 * radius, 0, 0)) * depthScale;
    float r = depth2Df(iuv + offset + int3(1 * radius, 0, 0)) * depthScale;
    float u = depth2Df(iuv + offset + int3(0, -1 * radius, 0)) * depthScale;
    float d = depth2Df(iuv + offset + int3(0, 1 * radius, 0)) * depthScale;
    

    float l2 = depth2Df(iuv + offset + int3(-1 * radius * 2, 0, 0)) * depthScale;
    float r2 = depth2Df(iuv + offset + int3(1 * radius * 2, 0, 0)) * depthScale;
    float u2 = depth2Df(iuv + offset + int3(0, -1 * radius * 2, 0)) * depthScale;
    float d2 = depth2Df(iuv + offset + int3(0, 1 * radius * 2, 0)) * depthScale;
    
    float l3 = depth2Df(iuv + offset + int3(-1 * radius * 4, 0, 0)) * depthScale;
    float r3 = depth2Df(iuv + offset + int3(1 * radius * 4, 0, 0)) * depthScale;
    float u3 = depth2Df(iuv + offset + int3(0, -1 * radius * 4, 0)) * depthScale;
    float d3 = depth2Df(iuv + offset + int3(0, 1 * radius * 4, 0)) * depthScale;
    
    
    float4 tangentX = float4(1, 0, r - l, 1);
    float4 tangentY = float4(0, 1, u - d, 1);
    float4 tangentX2 = float4(1, 0, r2 - l2, 1);
    float4 tangentY2 = float4(0, 1, u2 - d2, 1);
    float4 tangentX3 = float4(1, 0, r3 - l3, 1);
    float4 tangentY3 = float4(0, 1, u3 - d3, 1);
    

    float4 normal = float4(cross(tangentX.xyz, tangentY.xyz), 1);
    float4 normal2 = float4(cross(tangentX2.xyz, tangentY2.xyz), 1);
    float4 normal3 = float4(cross(tangentX3.xyz, tangentY3.xyz), 1);
    
    float dep = ((l + r + u + d) / 4 + c) / 2;
    
    return float4(normalize(lerp(lerp(normalize(normal), normalize(normal2), 0.3), normalize(normal3), 0.4)).xyz, 1);
}
float4 GetScreenSpaceNormal(float2 oosz, float2 uv, float radius)
{
    // depth values of neighboring pixels
    float depthLeft = depth2Df(uv + float2(-oosz.x, 0) * radius);
    float depthRight = depth2Df(uv + float2(oosz.x, 0) * radius);
    float depthUp = depth2Df(uv + float2(0, -oosz.y) * radius);
    float depthDown = depth2Df(uv + float2(0, oosz.y) * radius);

    // Calculate depth gradient in screen-space
    float ddx = (depthRight - depthLeft) * 0.5;
    float ddy = (depthUp - depthDown) * 0.5;

    // Create a tangent-space normal vector
    float3 normal;
    normal.xy = ((float2(min(0.8, max(-0.8, ddx)), min(0.8, max(-0.8, ddy)))));
    
    normal.z = 1;
    normal = normalize(normal); // Normalize to ensure it's a unit vector

    return float4(normal, 1);
}

float4 CalculateNormalF(float oosz, float2 uv, float radius)
{
    // Sample depth values from the depth map at specified offsets
    float l = depth2Df(uv + float2(-radius, 0.0) * oosz);
    float r = depth2Df(uv + float2(radius, 0.0) * oosz);
    float u = depth2Df(uv + float2(0.0, -radius) * oosz);
    float d = depth2Df(uv + float2(0.0, radius) * oosz);

    // Compute the tangent vectors
    // Adjust the tangent vector calculations to handle the depth value range [0, 1] where 1 is near and 0 is far
    float4 tangentX = float4(0, 1, l - r, 1);
    float4 tangentY = float4(1, 0, u - d, 1);

    // Compute the normal vector by taking the cross product of the tangent vectors
    // The z component of the cross product will give the correct sign for the normal
    float3 normal = cross(tangentX.xyz, tangentY.xyz);
    
    normal.z = abs(normal.z) + 1;
    // Normalize the normal vector
    return float4(normalize(normal), 1);
}

float4 CalculateNormalMap(int3 iuv, int3 offset, float radius, float depthScale)
{
    float2 isz;
    depthMap.GetDimensions(isz.x, isz.y);
    
    float2 isz2;
    normalMap.GetDimensions(isz2.x, isz2.y);
    
    float2 diff = isz / isz2;
    int3 fuv = int3(diff * float2(iuv.x, iuv.y), 0);
    
    float dc = depth2Df(fuv + offset) * depthScale;
    float dl = depth2Df(fuv + offset + int3(-1 * radius, 0, 0)) * depthScale;
    float dr = depth2Df(fuv + offset + int3(1 * radius, 0, 0)) * depthScale;
    float du = depth2Df(fuv + offset + int3(0, -1 * radius, 0)) * depthScale;
    float dd = depth2Df(fuv + offset + int3(0, 1 * radius, 0)) * depthScale;
    
    float4 l = depth2Df(fuv + offset + int3(-1 * radius, 0, 0)) * depthScale;
    float4 r = depth2Df(fuv + offset + int3(1 * radius, 0, 0)) * depthScale;
    float4 u = depth2Df(fuv + offset + int3(0, -1 * radius, 0)) * depthScale;
    float4 d = depth2Df(fuv + offset + int3(0, 1 * radius, 0)) * depthScale;
    
    float4 tangentX = normalize(float4(1, 0, ddx(dl - dr), 1));
    float4 tangentY = normalize(float4(0, 1, ddy(du - dd), 1));
    
    float4 normal = float4(normalize(cross(tangentY.xyz, tangentX.xyz)), 1);
    
    return float4(normalize(normal.xyz), 1);
}




float4 HSVtoRGB(float4 hsv)
{
    float h = hsv.x;
    float s = hsv.y;
    float v = hsv.z;

    if (s == 0.0f)
        return float4(v, v, v, 1);

    h /= 60.0f;
    int i = floor(h);
    float f = h - float(i);
    float p = v * (1.0f - s);
    float q = v * (1.0f - s * f);
    float t = v * (1.0f - s * (1.0f - f));

    if (i == 0)
        return float4(v, t, p, 1);
    if (i == 1)
        return float4(q, v, p, 1);
    if (i == 2)
        return float4(p, v, t, 1);
    if (i == 3)
        return float4(p, q, v, 1);
    if (i == 4)
        return float4(t, p, v, 1);

    return float4(v, p, q, 1);
}

float4 RGBToYIQ(float4 rgb)
{
    float4x3 yiqMatrix = float4x3(
        0.299, 0.587, 0.114, 1,
        0.596, -0.274, -0.322, 1,
        0.211, -0.523, 0.312, 1
    );
    return mul(yiqMatrix, rgb.xyz);
}
float4 YIQtoRGB(float4 yiq)
{
    float4x3 rgbMatrix = float4x3(
        1.0, 0.956, 0.62, 11,
        1.0, -0.272, -0.647, 1,
        1.0, -1.106, 1.703, 1
    );
    return mul(rgbMatrix, yiq.xyz);
}

// Function to convert RGB to HSV
float4 RGBtoHSV(float4 rgb)
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

    return float4(h, s, v, 1);
}
float4 RotateYIQ(float4 yiq, float angle)
{
    // Perform some YIQ manipulation - for example, rotate the color in YIQ space
    float c = cos(angle);
    float s = sin(angle);
    yiq.yz = float2(c * yiq.y - s * yiq.z, s * yiq.y + c * yiq.z);
    return yiq;
}

float4 RotateYIQRGB(float4 rgb, float angle)
{
    float4 yiq = RGBToYIQ(rgb); // Convert to YIQ
    yiq = RotateYIQ(yiq, angle); // Rotate the hue
    return YIQtoRGB(yiq);
}

float4 RotateHue(float4 colorRGB, float angle)
{
    float4 hsv = RGBtoHSV(colorRGB); // Convert to HSV
    hsv.x += angle; // Rotate the hue
    hsv.x = fmod(hsv.x, 360.0f); // Wrap the hue if it goes out of bounds
    return HSVtoRGB(hsv);
}


float4 FresnelSchlickN0(float4 f0, float4 H, float4 V)
{
    return f0 + (1.0f - f0) * pow(abs(1.0f - dot(H, V)), 5.0f);
}

float4 WaveBasedColorGlow(float2 uv, float4 baseColor, float4 fresnel, float time, float freq)
{
    float wave = cosTime01(0.5) * 0.3 + 0.4 + 0.2;
    float4 waveColor = float4(wave, wave, wave, 1.0); // Replace with desired RGB ratios

    return min(baseColor *
    float4(0.8, 0.4, 0.22, 0.7), float4(cosTime01(0.15) * 0.95, 0.2 - cosTime01(1) * 0.1, 0.4 - cosTime01(0.3) * 0.12, 0.4 - cosTime01(3) * 0.5))
    -
    (0.01 * lerp(baseColor, baseColor * fresnel * baseColor * (1.0 - fresnel) *
    (0.45 - distance(uv, float2(0.5, 0.5))) < 0.25 ? lerp(baseColor, waveColor, pow(abs(fresnel.y), 1.0)) : lerp(baseColor, waveColor, pow(abs(fresnel.y), 3.0))
    * fresnel * baseColor * baseColor * (1.0 - fresnel) * fresnel * waveColor * (1.0 - fresnel) * waveColor, 0.012)) * 0.0001;
}

float4 FresnelGlow(float4 objectColor, float4 fresnelColor, float4 normal, float4 viewDir)
{
    // Calculate Fresnel reflection coefficient (R)
    float4 R = FresnelSchlickN0(fresnelColor, normal, viewDir); // Use the Fresnel equation or approximation
    
    // Modulate the object color with the Fresnel color
    float4 glowColor = objectColor * fresnelColor * R;
    
    return glowColor;
}

float4 FresnelGlowR14(float R, float4 objectColor, float4 fresnelColor)
{
    float4 glowColor = objectColor * fresnelColor * R;
    
    return glowColor;
}

float4 GlowInTheDarkGreen(float4 baseColor, float4 fresnel, float intensity)
{
    float4 glowGreen = float4(0, 1, 0, 1);
    return lerp(baseColor, glowGreen, pow(abs(fresnel.y), intensity));
}
float4 HolographicEffect
    (
    float4 baseColor, float4 fresnel, float intensity)
{
    float4 color1 = lerp(baseColor, float4(0, 1, 0, 1), fresnel.x * intensity);
    float4 color2 = lerp(baseColor, float4(0, 0, 1, 1), fresnel.y * intensity);
    float4 color3 = lerp(baseColor, float4(1, 0, 0, 1), fresnel.z * intensity);
    
    return color1 * color2 * color3;
}


float4 FresnelGlow(float4 value, float4 fresnel, float brightnessFactor)
{
    // Adjust the brightness of the object based on the Fresnel value
    return value * (1.0 + fresnel * brightnessFactor);
}


float4 FresnelSchlick4(float4 F0, float4 cosTheta, float4 fresnelPower)
{
    //return F0 + (1.0 - F0) * pow(abs(1.0 - cosTheta), fresnelPower);
    
    float4 fresnel = Fresnel(cosTheta);
    return Schlick(F0, fresnel, fresnelPower);
    
    // Optimized variant (presented by Epic at SIGGRAPH '13)
	// https://cdn2.unrealengine.com/Resources/files/2013SiggraphPresentationsNotes-26915738.pdf
    //const fresnel= dotVH.mul(-5.55473).sub(6.98316).mul(dotVH).exp2();

    //return f0.mul(fresnel.oneMinus()).add(f90.mul(fresnel));
    
}
float4 CalculateDepthDensity(
    float2 uv, float4 viewDir,
    float threshold, float curveExponent,
    float4 depthCross, float depth)
{
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

float2 GenerateSampleOffset(float2 uv, float2 sz, int i, int numSamples)
{
    // Generate a random angle
    float angle = noise3(float3(uv, uv.x + uv.y + i + numSamples));

    // Convert polar coordinates to Cartesian
    float x = cos(angle + sz.x);
    
    float y = sin(angle);

    // Apply a sample radius (adjust based on your needs)
    float radius = 0.003; // Example radius

    return float2(x, y) * radius;
}

float ComputeExponentialShadowNoDiv(float2 uv, float2 ofs, float2 sz, float depth, int numSamples, float C)
{
    float shadow = 0.0;
    for (int i = 0; i < numSamples; ++i)
    {
        float2 sampleOffset = GenerateSampleOffset(uv + ofs, sz, i, numSamples);
        float sampleDepth = depth2Df(uv + ofs + sampleOffset);
        float visibility = exp(C * max(0, depth - sampleDepth));
        shadow += visibility;
    }
    shadow /= numSamples;
    return (1 - shadow);
}
float CalculateOcclusionFactor(float2 uv, float2 ofs, float2 sz,
    float d, int normalOcclusionFactor, int numSamples, float C)
{
    float occlusionSum =
        0
    + ((d > depth2Df(uv + ofs + float2(1.0, 0) * (1.0 / sz)) - OCCLUSION_MIN_DIFFERENCE) ? 1 : 0)
    + ((d > depth2Df(uv + ofs + float2(-1.0, 0) * (1.0 / sz)) - OCCLUSION_MIN_DIFFERENCE) ? 1 : 0)
    + ((d > depth2Df(uv + ofs + float2(0, 1.0) * (1.0 / sz)) - OCCLUSION_MIN_DIFFERENCE) ? 1 : 0)
    + ((d > depth2Df(uv + ofs + float2(0, -1.0) * (1.0 / sz)) - OCCLUSION_MIN_DIFFERENCE) ? 1 : 0);
    
    float occ = ComputeExponentialShadowNoDiv(uv, ofs, sz, d, numSamples, C);
    
    return //occlusionSum / 17;
    //occ / numSamples;
    saturate(occ + occlusionSum) / (4 + numSamples);
}

float CalculateOcclusionFactorDC(float2 oosz, float2 uv, float2 ofs, float2 sz,
    float d, int normalOcclusionFactor, int numSamples, float C, float4 dc1, float4 dx1, float4 dc2, float4 dx2, float4 dc3, float4 dx3)
{
    
    dc3 = CrossLRUDf(oosz, depthMap, uv, 4);
    dx3 = XLRUDf(oosz, depthMap, uv, 3);
    dc2 = CrossLRUDf(oosz, depthMap, uv, 3);
    dx2 = XLRUDf(oosz, depthMap, uv, 2);
    dc1 = CrossLRUDf(oosz, depthMap, uv, 2);
    dx1 = XLRUDf(oosz, depthMap, uv, 1);
    
    const float md = d - OCCLUSION_MIN_DIFFERENCE;
    float occlusionSum =
        0
    + (dc3.x < md ? 0.25 : 0)
    + (dc3.y < md ? 0.25 : 0)
    + (dc3.z < md ? 0.25 : 0)
    + (dc3.w < md ? 0.25 : 0)
    + (dx3.x < md ? 0.15 : 0)
    + (dx3.y < md ? 0.15 : 0)
    + (dx3.z < md ? 0.15 : 0)
    + (dx3.w < md ? 0.15 : 0)
    + (dc2.x < md ? 0.35 : 0)
    + (dc2.y < md ? 0.35 : 0)
    + (dc2.z < md ? 0.35 : 0)
    + (dc2.w < md ? 0.35 : 0)
    + (dx2.x < md ? 0.25 : 0)
    + (dx2.y < md ? 0.25 : 0)
    + (dx2.z < md ? 0.25 : 0)
    + (dx2.w < md ? 0.25 : 0)
    + (dc1.x < md ? 0.55 : 0)
    + (dc1.y < md ? 0.55 : 0)
    + (dc1.z < md ? 0.55 : 0)
    + (dc1.w < md ? 0.55 : 0)
    + (dx1.x < md ? 0.45 : 0)
    + (dx1.y < md ? 0.45 : 0)
    + (dx1.z < md ? 0.45 : 0)
    + (dx1.w < md ? 0.45 : 0)
    + (d < md ? 1 : 0);
    
    float occ = ComputeExponentialShadowNoDiv(uv, ofs, sz, d, numSamples, C);
    
    return //occlusionSum / 17;
    //occ / numSamples;
    saturate(occ + occlusionSum) / (20 + numSamples);
}


float Falloff(float distance, float radius, float exponent)
{
    return pow(1.0 - clamp(distance / radius, 0.0, 1.0), exponent);
}



float4 FresnelSchlick(float4 F0, float4 H, float4 N, float4 V)
{
    float cosTheta = saturate(dot(V, H));
    return F0 + (1.0 - F0) * pow(1.0 - cosTheta, FresnelPower);
}

float GeometrySchlickGGX(float NdotV, float k)
{
    return NdotV / (NdotV * (1.0 - k) + k);
}

float GeometrySmith(float4 N, float4 V, float4 L, float alpha)
{
    float k = alpha * alpha * 0.5;
    float NdotV = saturate(dot(N, V));
    float NdotL = saturate(dot(N, L));
    return GeometrySchlickGGX(NdotV, k) * GeometrySchlickGGX(NdotL, k);
}


struct Camera
{
    float4 Position;
    float4 Direction;
    float4 PixelDir;
};





float Fresnel1(float4 viewDir, float4 normal, float fresnelPower)
{
    float cosTheta = dot(normal, viewDir);
    return fresnelPower + (1 - fresnelPower) * pow(1 - cosTheta, 5);
}



struct CrossStatistic
{
    float MinXY;
    float MinYZ;
    float MinZW;
    float RangeMin;
             
    float MaxXY;
    float MaxYZ;
    float MaxZW;
    float RangeMax;
    
    float Range;
    
    float Min3;
    float Min4;
    
    float Max3;
    float Max4;
};

CrossStatistic CreateCrossStatistic(float4 dc)
{
    CrossStatistic cs;
    float minXY = min(dc.x, dc.y);
    float minYZ = min(dc.y, dc.z);
    float minZW = min(dc.z, dc.w);
    float rangeMin = min(minXY, min(minYZ, minZW));
    
    float maxXY = max(dc.x, dc.y);
    float maxYZ = max(dc.y, dc.z);
    float maxZW = max(dc.z, dc.w);
    float rangeMax = max(maxXY, max(maxYZ, maxZW));
    
    cs.MinXY = minXY;
    cs.MinYZ = minYZ;
    cs.MinZW = minZW;
    cs.RangeMin = rangeMin;
    cs.MaxXY = maxXY;
    cs.MaxYZ = maxYZ;
    cs.MaxZW = maxZW;
    cs.RangeMax = rangeMax;
    cs.Range = rangeMax - rangeMin;
    
    cs.Min3 = min(dc.z, min(dc.x, dc.y));
    cs.Min4 = min(dc.w, min(dc.z, min(dc.x, dc.y)));
    
    cs.Max3 = max(dc.z, max(dc.x, dc.y));
    cs.Max4 = max(dc.w, max(dc.z, max(dc.x, dc.y)));
    
    
    return cs;
}

static const int LightType_PointLight = 0;
static const int LightType_DirectionalLight = 1;
static const int LightType_SpotLight = 2;
static const int LightType_AmbientLight = 3;
static const int LightType_AreaLight = 4;
static const int LightType_EnvironmentLight = 5;

float4 FresnelReflection(float4 lightColor, float fresnel)
{
    return float4(lightColor * fresnel);
}



float4 DiffuseLighting(float4 normal, float4 lightDir, float4 lightColor, float fresnel,
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
    float4 Position; // Position of the light
    float4 Direction; // Direction the light is pointing
    float4 LightColor; // Color of the light
    float Intensity; // Light intensity
    bool CastShadows; // Whether the light casts shadows
    float Exponent; // Exponent for falloff
    float4 FresnelPower; // Fresnel power
    float4 FresnelReflectance; // Fresnel reflectance
    float SpecularIntensity;
    float SpecularPower;
    float PhaseFactor; // For holography
    float FresnelMix;
};

// Complex Fresnel Equation for better edge coloring
float4 FresnelComplex(float4 diffuse, float4 normal, float4 viewDir, float4 fresnelPower, float4 fresnelReflectance)
{
    float cosTheta = dot(normal, -viewDir);
    float4 F0 = fresnelReflectance + (1 - fresnelReflectance) * pow(1 - cosTheta, 5);
    float4 fresnel = F0 + (1 - F0) * pow(1 - cosTheta, fresnelPower);
    return fresnel;
}

// Phase function for holography to simulate light interference
float PhaseFunction(float4 normal, float4 viewDir, float phaseFactor)
{
    float cosTheta = clamp01(max(0, dot(normalize(normal.xyz), -normalize(viewDir.xyz))));
    return clamp01(1.0f / (4.0f * 3.14159f) * (1.0f + clamp01(phaseFactor * cosTheta * cosTheta)));
}
// Chromatic aberration for Fresnel and holography
float4 ChromaticAberration(float4 fresnel, float phase)
{
    float4 offsets = float4(0.01, -0.005, 0.005, 0); // RGB channel offsets
    float4 chroma = float4((fresnel.xyz + offsets.xyz) * (phase * offsets.xyz), 1);
    
    return clamp01(chroma);
}


struct PointLight
{
    BaseLight Base;
    float Radius; // Radius of the light influence
    float4 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
    
    // Corrected PointLightDiffuse function
    float4 PointLightDiffuse(float d, float4 normal, float4 viewDir, float4 position, float occlusionFactor, float scatteringCoefficient, float phase)
    {
        float3 toLight = position.xyz - Base.Position.xyz;
        
        float3 lightDir = normalize(-toLight);
        float distanceToLight = distance(position.xyz, Base.Position.xyz);
        
        float attenuationFactor = 1.0 / (Attenuation.x + Attenuation.y * distanceToLight + Attenuation.z * distanceToLight * distanceToLight);

    // Subsurface scattering effect
        float penetrationDepthFactor = 0.3;
        float subsurfaceScatteringEffect = exp(-distanceToLight / penetrationDepthFactor);
        
        float4 reflectDir = float4(normalize(reflect(normalize(-lightDir.xyz), normalize(-normal.xyz))), 1);
        
        float specFactor = pow(max(0, dot(normalize(viewDir.xyz), normalize(-reflectDir.xyz))), Base.SpecularPower);
        
        
        
    // Basic diffuse calculation
        float diffFactor = max(0, dot(normalize(normal.xyz), normalize(viewDir.xyz)));
        
            // Fresnel calculation
        float dt = max(0, dot(normalize(normal.xyz), normalize(viewDir.xyz)));
        float4 fresnel = (Base.LightColor * Fresnel(float4(dt, dt, dt, 1) - .25 * Base.LightColor));
        
        float4 f1 = Schlick(Base.LightColor,
            fresnel, Base.FresnelPower);
        float4 f2 = Schlick(Base.LightColor,
            fresnel, Base.FresnelReflectance);
        
    // Combine diffuse, Fresnel, and subsurface scattering
        float4 l1 = (Base.LightColor *
            Base.Intensity * attenuationFactor) *
            Falloff(distanceToLight, Radius, Base.Exponent);
        
        float4 l2 = (Base.LightColor *
            Base.SpecularIntensity * attenuationFactor) * Falloff(distanceToLight, Radius, Base.Exponent);
        
        float4 chroma = ChromaticAberration(fresnel, phase);
        float4 phaseVal = FresnelGlow(PhaseFunction(float4(normalize(normal.xyz), 1),
                        float4(normalize(-viewDir.xyz), 1), phase), chroma, float4(normalize(normal.xyz), 1), float4(normalize(-viewDir.xyz), 1));
        float4 ambient = 0.003 * Base.LightColor * Base.Intensity;
        
        float4 r1 = clamp01(
            float4(diffFactor * 
                ((l1.xyz + ambient.xyz) + f1.xyz * (chroma.xyz / ((1 - d) * phaseVal.xyz))), 
            1));
        float4 r2 = clamp01(float4(specFactor * ((l2.xyz + ambient.xyz) + (f2.xyz * chroma.xyz + 2 * d * f2.xyz * phaseVal.xyz)), 1));
        
        float4 ret = float4(
            pow(
                clamp01(lerp(r1, r1 * f1, Base.FresnelMix)) +
                clamp01(lerp(r2, r2 * f2, Base.FresnelMix)),
            1.0 / 2.2).xyz, 1) - occlusionFactor * 0.1;
        
        
        
        return ret;
    }

};

struct DirectionalLight
{
    BaseLight Base;
    

    float4 DirectionalLightDiffuse(float4 position, float4 diffuse, float4 normal, float4 viewDir, float4 fresnel, float phase, float occlusionFactor)
    {
        
        if (!Base.Enabled)
            return float4(0, 0, 0, 0);
        
        float4 lightDir = float4(normalize(Base.Direction.xyz), 1);
        
        float diffFactor = clamp01(max(0, dot(normalize(normal.xyz), normalize(viewDir.xyz))));
        
        
        float4 reflectDir = float4(normalize(reflect(normalize(-lightDir.xyz), normalize(-normal.xyz))), 1);
        
        float specFactor = pow(max(0, dot(normalize(viewDir.xyz), normalize(-reflectDir.xyz))), Base.SpecularPower);
        
        
        float4 ambient = 0.05 * Base.LightColor * Base.Intensity;
        float4 l1 = Base.LightColor * Base.Intensity;
        float4 l2 = Base.LightColor * Base.SpecularIntensity;
       
        float4 chroma = ChromaticAberration(fresnel, phase);
        float4 phaseVal = PhaseFunction(normal, viewDir, phase);
        
        float3 r1 = diffFactor * ((l1.xyz + ambient.xyz) + (chroma.xyz + phaseVal.xyz));
        float3 r2 = specFactor * ((l2.xyz + ambient.xyz) + (chroma.xyz + phaseVal.xyz));
       
        float4 ret = clamp01(float4(
            pow(
                abs(lerp(r1, fresnel.xyz * r1, Base.FresnelMix) +
                lerp(r2, fresnel.xyz * r2, Base.FresnelMix))
            , 1.0 / 2.2), 1) - occlusionFactor * 0.01);
        
        
        return ret;
    }
};


struct SpotLight
{
    BaseLight Base;
    float4 TargetPosition; // Radius of the light influence
    float ConeAngle; // Cone angle for spotlights
    float CutOffAngle; // CutOff angle for spotlights
    float4 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
   
    // Corrected SpotLightDiffuse function
    float4 SpotLightDiffuse(float4 normal, float4 position,
        float4 viewDir, float4 lightDir, float4 toLight, float4 fresnel,
        float phase, float occlusionFactor)
    {
        viewDir = (normalize(viewDir.xyz), 1);
        
        if (!PointInsideCone(position, Base.Position, normalize(Base.Direction), ConeAngle))
            return float4(0.0f, 0.0f, 0.0f, 1.0f);

        float4 projectedPosition =
            ProjectPointInsideCone(position, Base.Position, normalize(Base.Direction), ConeAngle);
        
        
        float diffFactor = max(0, dot(normalize(normal.xyz), -normalize(lightDir.xyz)));
        
        float distance = sqrt(length(Base.Position - position));
        
        float attenuation = 1.0 / (Attenuation.x + Attenuation.y * distance + Attenuation.z * distance * distance);
        
        float spotEffect = max(dot(normalize(normal), normalize(-lightDir)), 0);
        
        float coneDistance = ConeDistanceToSphere(Base.Position, Base.Direction, ConeAngle, position, 0);
        
        float coneAttenuation = 1.0 - coneDistance;
        
        float spotFactor = (spotEffect > CutOffAngle) ?
            pow(spotEffect, Base.Exponent) :
            0.03;
                
        float4 chroma = ChromaticAberration(fresnel, phase);
        float4 phaseVal = PhaseFunction(normal, viewDir, phase);
        
        
        float4 reflectDir = normalize(reflect(normalize(-lightDir), normal));
        
        float specFactor = pow(max(0, dot(normalize(-viewDir.xyz), normalize(-reflectDir.xyz))), Base.SpecularPower);
      
        float4 l1 =
                (Base.LightColor *
                spotFactor *
                coneAttenuation *
                Base.Intensity);
        
        float4 l2 =
                (Base.LightColor *
                spotFactor *
                specFactor *
                coneAttenuation *
                Base.SpecularIntensity);
        
        float4 v1 = l1;
        float4 v2 = l2;
        
        
        float4 ret = pow(abs(diffFactor * (v1 + chroma + phaseVal) *
                specFactor * (v2 + chroma + phaseVal)), 1.0 / 2.2);
        
        ret = lerp(ret, ret * fresnel, Base.FresnelMix);
        
        
        return ret;
    }

// Corrected SpotLight function
    float4 SpotLight(float4 normal, float4 position, float4 viewDir,
            float phaseFactor, float occlusionFactor)
    {
        float4 toLight = Base.Position - position;
        float4 lightDir = normalize(toLight);
        float4 diffuse = SpotLightDiffuse(normal, position, viewDir, lightDir, toLight, Base.FresnelPower,
            phaseFactor,
            occlusionFactor);
        float4 reflectDir = normalize(reflect(-lightDir, normal));
        float4 F0 = FresnelSchlick2(Base.LightColor, viewDir, reflectDir, Base.FresnelPower);
        float diffFactor2 = max(0, dot(reflectDir, viewDir));

        float4 ret = diffuse * Base.Intensity * diffFactor2;
        ret = lerp(ret, ret * F0, Base.FresnelMix);
        return ret;
    }
};

SpotLight InitializeSpotLight(BaseLight base, float4 targetPosition, float coneAngle, float cutOffAngle, float4 attenuation)
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
    float4 Attenuation; // Attenuation coefficients (constant, linear, quadratic)
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
    float4 position,
    float4 direction,
    float4 lightColor,
    float intensity,
    bool castShadows,
    float exponent,
    float4 fresnelPower,
    float4 fresnelReflectance,
    float specularIntensity,
    float specularPower,
    float phaseFactor,
    float fresnelMix)
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
    
    light.SpecularIntensity = specularIntensity;
    light.SpecularPower = specularPower;
    light.PhaseFactor = phaseFactor;
    light.FresnelMix = fresnelMix;
    return light;
}

PointLight InitializePointLight(BaseLight base, float radius, float4 attenuation)
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

AreaLight InitializeAreaLight(BaseLight base, float2 areaSize, float4 attenuation)
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


DirectionalLight CreateDirectionalLight(float4 direction, float4 color, float intensity, float4 fresnelPower, float4 fresnelReflectance, float specularIntensity, float specularPower, float phaseFactor, float fresnelMix)
{
    BaseLight base = InitializeBaseLight(true, 1, float4(5, 5, 5, 1), direction, color, intensity, true, 0.2, fresnelPower, fresnelReflectance, specularIntensity, specularPower, phaseFactor, fresnelMix);
    DirectionalLight light;
    light.Base = base;
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
// A function that creates a white point light
PointLight CreatePointLight(float4 position, float4 color,
    float intensity, float exponent, float4 fresnelPower,
    float4 fresnelReflectance, float radius, float4 attenuation, float specularIntensity, float specularPower, float phaseFactor, float fresnelMix)
{
    // Initialize the base light properties
    BaseLight base = InitializeBaseLight(
        true, // Enabled
        0, // LightType (pointlight)
        position, // Position of the light
        float4(0, 0, 0, 0), // Direction the light is pointing (not used for point lights)
        color, // LightColor (white)
        intensity, // Intensity
        false, // CastShadows
        exponent, // Exponent
        fresnelPower, // FresnelPower
        fresnelReflectance, // FresnelReflectance
        specularIntensity,
        specularPower,
        phaseFactor,
        fresnelMix
    );

    // Initialize the point light properties
    PointLight light;
    light.Base = base;
    light.Radius = radius; // Radius of the light influence
    light.Attenuation = attenuation; // Attenuation coefficients (constant, linear, quadratic)

    // Return the point light
    return light;
}


SpotLight CreateSpotLight(float4 position, float4 direction, float4 color,
    float intensity, float exponent, float4 fresnelPower, float4 fresnelReflectance,
    float4 targetPosition, float coneAngle, float coneAngleCutoff, float4 attenuation, float specularIntensity, float specularPower,
    float phaseFactor, float fresnelMix)
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
        fresnelReflectance, // FresnelReflectance
        specularIntensity,
        specularPower,
        phaseFactor,
        fresnelMix
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
float4 ReflectEffect(float4 position, float4 normal, float4 incomingDir)
{
    return reflect(incomingDir, normal);
}

// Simulate a refraction effect
float4 RefractEffect(float4 position, float4 normal, float4 incomingDir, float eta)
{
    return refract(incomingDir, normal, eta);
}

// Simulate a distortion effect using sine waves
float4 SineWaveDistortion(float4 position, float frequency, float amplitude)
{
    return position + amplitude * sin(frequency * position);
}

// Simulate a twist effect
float4 TwistEffect(float4 position, float angle)
{
    float twistFactor = position.y * angle;
    float cosAngle = cos(twistFactor);
    float sinAngle = sin(twistFactor);
    return float4(
        cosAngle * position.x - sinAngle * position.z,
        position.y,
        sinAngle * position.x + cosAngle * position.z, 1
    
    );
}

#define TRIPPY_EFFECTS(pos, normal, dir) \
pos = ReflectEffect(pos, normal, dir); \
pos = RefractEffect(pos, normal, dir, 0.9); \
pos = SineWaveDistortion(pos, 10.0, 0.1); \
pos = TwistEffect(pos, 1.0);


float4 CookTorranceBRDF(float4 N, float4 V, float4 L, float4 F0, float roughness)
{
    // Half vector
    float4 H = normalize(V + L);
    
    // Fresnel term
    float4 F = FresnelSchlick(F0, H, N, V);
    
    // Geometric attenuation
    float alpha = roughness * roughness;
    float G = GeometrySmith(N, V, L, alpha);
    
    // Normal distribution function
    float NdotH = saturate(dot(N, H));
    float D = alpha / (PI * pow(NdotH * NdotH * (alpha - 1) + 1, 2.0));
    
    // Microfacet BRDF
    float4 nominator = D * G * F;
    float denominator = 4 * max(dot(N, V), 0.0) * max(dot(N, L), 0.0) + 0.001; // Prevent division by zero
    
    return nominator / denominator;
}


float4 Bloom(float2 uv, float intensity, float4 n)
{
    float4 sceneColor = diffuseMap.Sample(sampleTypeMirror, uv);
    
    return sceneColor * (FresnelSchlick2(sceneColor, float4(-0.1, -0.1, 1, 1), n, FresnelPower));
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
    float color2 = depth2Df(uv);

    // Generate a glitch noise value based on the input texture coordinate and time parameter
    float noise = GlitchNoise(color2 * 10, TotalTime * 0.0000001, 3, 2) * 3;
    float noiseY = GlitchNoise(color2, TotalTime * 0.0000001, 2, 3) * 4;
    // Apply the noise to the texture coordinate in x direction
    float2 shiftedTextCoord = uv + float2(noise, noiseY);

    // Sample the second image for the shifted texture coordinate
    float shiftedColor2 = depth2Df(shiftedTextCoord);

    return lerp(color2, shiftedColor2, abs(noise + noiseY));
}
float SineWave(float x, float amplitude, float frequency)
{
    return amplitude * sin(x * frequency);
}
float4 Ripple(float4 lookAtW, float2 uv, float4 color1, float time, float amplitude, float frequency)
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
    float4 position = float4(-2, 5, -5, 1);
    float4 direction = normalize(float4(1, -2, 1, 1));
    float4 color = float4(0.2, 0.2, 0.2, 1); // White color
    float intensity = 1.0f; // Example intensity
    float exponent = 0.4f; // Example exponent
    float4 fresnelPower = float4(1.0f, 1, 1, 1); // Example Fresnel power
    float4 fresnelReflectance = float4(0.5f, 0.5, 0.5, 1); // Example Fresnel reflectance
    float4 targetPosition = float4(uv, depth, 1); // Example target position
    float coneAngle = 0.5f; // Example cone angle
    float coneAngleCutoff = fresnelReflectance; // Example cut-off angle
    float4 attenuation = float4(1, 0.2, 0.0162, 1); // Example attenuation coefficients
    float specularIntensity = 0.8;
    float specularPower = 1;
    float phaseFactor = 1;
    float fresnelMix = 0;
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
        attenuation,
        specularIntensity,
        specularPower,
        phaseFactor,
        fresnelMix
    );
}


void InitializeSpotLights(float2 uv, float depth, out SpotLight spotLights[4])
{
    for (int i = 0; i < 4; ++i)
    {
        spotLights[i] = CreateRandomSpotLight(uv, depth);
    }
}

// Content of Hologram2_070.hlsl


float CalculateSampleWeight(float depth, float sampleDepth, float3 normal, float3 sampleNormal)
{
    // Calculate depth difference (normalize based on your depth range)
    float depthDifference = abs(depth - sampleDepth) ; // Example normalization factor

    // Calculate normal similarity
    float normalSimilarity = dot(normal, sampleNormal);

    // Calculate occlusion (shadowing)
    float occlusion = step(0.02, depthDifference); // 0.01 is a threshold for occlusion

    // Calculate weight based on depth, normal, and occlusion
    float weight = max(0, 1.0 - depthDifference) * max(0, normalSimilarity) * (1 - occlusion);

    return weight;
}



// Pseudocode for Screen Space Global Illumination (SSGI)
float4 ComputeSSGI(float2 uv, float2 sz, float depth, float4 normal, float4 albedo,
    int numSamples)
{
    float4 accumulatedColor = float4(0, 0, 0,1);
    float accumulatedWeight = 0;

    // Sample around the pixel
    for (int i = 0; i < numSamples; ++i)
    {
        // Generate a sample position around the current pixel
        float2 sampleOffset = GenerateSampleOffset(uv, sz, i, numSamples);
        float2 sampleUV = uv + sampleOffset;

        // Fetch depth and normal at the sample position
        float sampleDepth = depth2Df(sampleUV);
        float3 sampleNormal = float3(0, 0, 1); //CalculateNormal(sampleUV, sz, 12);
        
        // Calculate the weight of the sample based on depth and normal similarity
        float weight = CalculateSampleWeight(depth, sampleDepth, normal.xyz, sampleNormal);

        // Fetch the color at the sample position
        float4 sampleColor = mir2D(diffuseMap, sampleUV);
        /*float3 color = CalcLighting(float3(sampleUV, sampleDepth), float4(sampleColor, 1), float3(0, 0,-1), float3(0, 0, 5), depthScale(), float3(0, 0, 1), sampleNormal, 0, float3(sampleUV, sampleDepth * depthScale()), sampleUV, sampleDepth, float4(sampleNormal, sampleDepth));*/
        // Accumulate color and weight
        accumulatedColor += weight * sampleColor;
        accumulatedWeight += weight;
    }
    
    // Average out the color
    float4 finalColor = accumulatedColor / accumulatedWeight;

    // Combine with albedo
    finalColor = albedo * finalColor;

    return finalColor;
}


float4 Render360(float2 uv)
{
    float MouseX = LOOK_AT.x;
    float MouseY = LOOK_AT.y;
    // Convert the mouse coordinates to spherical coordinates
    float theta = MouseX * 2.0 * PI; // Horizontal angle
    float phi = MouseY * PI; // Vertical angle

// Convert the spherical coordinates to texture coordinates
    float u = theta / (2.0 * PI); // Horizontal texture coordinate
    float v = 1 - phi / PI; // Vertical texture coordinate

// Sample the texture using the texture coordinates
    float4 color = mir2D(skylineMap, uv + float2(u, v));

// Return the color
    return color;

}

// Content of Hologram2_090.hlsl
Texture2D<float3> curTex : register(t5);

float TimeStep = 0.01;
float BuoyancyFactor = 0.5;
float VorticityFactor = 0.1;
float DiffusionRate = 0.1;
float CoriolisFactor = 0.1;






// Shader parameters
float4 baseColor = float4(0.8, 0.2, 0.2, 1.0); // Base color (red)
float4 emissionColor = float4(1.0, 0.8, 0.2, 1.0); // Emission color (orange)
float modulationStrength = 0.3; // Strength of modulation


float4 FresnelEffect4(float4 fresnel, float4 value)
{
    return ((value + fresnel) * (value * (1.0 - fresnel))) *
        ((value * fresnel) * (value + (1.0 - fresnel))) *
        (((value + value) * fresnel) + (value * (1.0 - fresnel))) *
        (((value + value) * fresnel) * (value * (1.0 - fresnel)));
}

float4 FresnelEffect3(float4 fresnel, float4 value)
{
    return (value + value * fresnel) * (value * (1.0 - fresnel));
}

float2 FresnelEffect2(float2 fresnel, float2 value)
{
    return (value + value * fresnel) * (value * (1.0 - fresnel));
}
float FresnelEffect(float fresnel, float value)
{
    return (value + value * fresnel) * (value * (1.0 - fresnel));
}

// Function to calculate velocity gradient
float2 CalcDivergence(Texture2D tex, float2 uv)
{
    float2 left = mir2D(tex, uv + float2(-TimeStep, 0)).gb;
    float2 right = mir2D(tex, uv + float2(TimeStep, 0)).gb;
    float2 above = mir2D(tex, uv + float2(0, -TimeStep)).gb;
    float2 below = mir2D(tex, uv + float2(0, TimeStep)).gb;
    
    //float2 gradient = (right - left) + (below - above);
    float divergence = dot(right - left, float2(1.0, 0.0)) + dot(below - above, float2(0.0, 1.0));
    
    return divergence;
}

float4 CalcVorticity(Texture2D tex, float2 uv)
{
    float2 left = mir2D(tex, uv + float2(-TimeStep, 0)).gb;
    float2 right = mir2D(tex, uv + float2(TimeStep, 0)).gb;
    float2 above = mir2D(tex, uv + float2(0, -TimeStep)).gb;
    float2 below = mir2D(tex, uv + float2(0, TimeStep)).gb;
    
    float2 gradient = (right - left) + (below - above);
    float4 vorticity = float4(gradient.y, -gradient.x, 0.0, 1.0);
    
    return vorticity;
}

float4 CalcPressure(Texture2D tex, float2 uv)
{
    float4 left = mir2D(tex, uv + float2(-TimeStep, 0));
    float4 right = mir2D(tex, uv + float2(TimeStep, 0));
    float4 above = mir2D(tex, uv + float2(0, -TimeStep));
    float4 below = mir2D(tex, uv + float2(0, TimeStep));
    
    float4 pressure = (right + left + above + below) / 4.0;
    
    return pressure;
}




// Function to calculate the gradient of the pressure field
float2 calcPressureGradient(Texture2D tex, float2 uv)
{
    float4 left = mir2D(tex, uv + float2(-TimeStep, 0));
    float4 right = mir2D(tex, uv + float2(TimeStep, 0));
    float4 above = mir2D(tex, uv + float2(0, -TimeStep));
    float4 below = mir2D(tex, uv + float2(0, TimeStep));

    float2 gradient = float2(right.r - left.r, below.r - above.r);
    return gradient;
}




float4 bloom2(Texture2D tex, float2 uv, float2 ofs, float dist, float threshold, float minColor, float power)
{
    // Sample the original texture
    float4 color = mir2D(tex, uv + ofs);
    
    // Average the color
    
    float4 finalColor = color;
    
    if (length(color) >= threshold)
    {
        float2 tuv;
        tex.GetDimensions(tuv.x, tuv.y);
        tuv = 1.0 / tuv;

        float4 blurColor =
            lerp(
                lerp((mir2D(tex, uv + ofs + float2(-dist, -dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(dist, dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(-dist, dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(dist, -dist) * .5 * tuv)) / 4.0,
                    lerp(mir2D(tex, uv + ofs + float2(-dist, 0) * tuv),
                        mir2D(tex, uv + ofs + float2(dist, 0) * tuv),
                    0.5),
                0.5),
                lerp(mir2D(tex, uv + ofs + float2(0, -dist) * tuv),
                    mir2D(tex, uv + ofs + float2(0, dist) * tuv),
                0.5),
            0.5);

        finalColor = power * (finalColor + minColor + blurColor);
    }

    return (finalColor);
}


float4 depthBlur(float d, Texture2D depthTex, int3 iuv, int3 iofs3, Texture2D tex, int3 iuvD, int3 iofs3D, int dist, float minDepth, float maxDepth, float strength, float4 diffuse)
{
    float blurDepthColorStrength = 1;
    float blurDepthStrength = 0.1;
    float blurDepthThreshold = 0.5;
    
    float f = minDepth;
    minDepth = min(minDepth, maxDepth);
    maxDepth = max(f, maxDepth);
    
    float s0 = saturate(strength);
    float cnt = 0.0;
    float4 blurColor = float4(0, 0, 0, 0);
     
    float4 xl, xr, xu, xd;
    XLRUD4i(tex, iuv + iofs3, dist, xl, xr, xu, xd);
        
    float4 cl, cr, cu, cd;
    CrossLRUD4i(tex, iuv + iofs3, dist, cl, cr, cu, cd);
        
    float4 xdep = XLRUDi(depthTex, iuvD + iofs3D, dist);
        
    float4 cdep = CrossLRUDi(tex, iuvD + iofs3D, dist);
    
    cnt = (d >= minDepth && d <= maxDepth);
    blurColor = cnt > 0.0 ? diffuse.w > 0.0 ? lerp(diffuse, tex.Load(iuvD + iofs3D), s0) : tex.Load(iuvD + iofs3D) : diffuse.w > 0.0 ? diffuse : tex.Load(iuvD + iofs3D);
    float bdep = cnt > 0.0 ? d : 0.0;
    
    if (cdep.x >= minDepth && cdep.x <= maxDepth)
    {
        blurColor += cdep.x >= bdep - blurDepthThreshold ? lerp(diffuse, cl, 0.5) : lerp(lerp(diffuse, cl, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = cdep.x >= bdep - blurDepthThreshold ? lerp(bdep, cdep.x, blurDepthStrength) : 0;

    }
    if (cdep.y >= minDepth && cdep.y <= maxDepth)
    {
        blurColor += cdep.y >= bdep - blurDepthThreshold ? lerp(diffuse, cr, 0.5) : lerp(lerp(diffuse, cr, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = cdep.y >= bdep - blurDepthThreshold ? lerp(bdep, cdep.y, blurDepthStrength) : 0;
    }
    if (cdep.z >= minDepth && cdep.z <= maxDepth)
    {
        blurColor += cdep.z >= bdep - blurDepthThreshold ? lerp(diffuse, cu, 0.5) : lerp(lerp(diffuse, cu, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = cdep.z >= bdep - blurDepthThreshold ? lerp(bdep, cdep.z, blurDepthStrength) : 0;
    }
    if (cdep.w >= minDepth && cdep.w <= maxDepth)
    {
        blurColor += cdep.w >= bdep - blurDepthThreshold ? lerp(diffuse, cd, 0.5) : lerp(lerp(diffuse, cd, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = cdep.w >= bdep - blurDepthThreshold ? lerp(bdep, cdep.w, blurDepthStrength) : 0;
    }
        
    if (xdep.x >= minDepth && xdep.x <= maxDepth)
    {
        blurColor += xdep.x >= bdep - blurDepthThreshold ? lerp(diffuse, xl, 0.5) : lerp(lerp(diffuse, xl, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = xdep.x >= bdep - blurDepthThreshold ? lerp(bdep, xdep.x, blurDepthStrength) : 0;
    }
    if (xdep.y >= minDepth && xdep.y <= maxDepth)
    {
        blurColor += xdep.y >= bdep - blurDepthThreshold ? lerp(diffuse, xr, 0.5) : lerp(lerp(diffuse, xr, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = xdep.y >= bdep - blurDepthThreshold ? lerp(bdep, xdep.y, blurDepthStrength) : 0;
    }
    if (xdep.z >= minDepth && xdep.z <= maxDepth)
    {
        blurColor += xdep.z >= bdep - blurDepthThreshold ? lerp(diffuse, xu, 0.5) : lerp(lerp(diffuse, xu, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = xdep.z >= bdep - blurDepthThreshold ? lerp(bdep, xdep.z, blurDepthStrength) : 0;
    }
    if (xdep.w >= minDepth && xdep.w <= maxDepth)
    {
        blurColor += xdep.w >= bdep - blurDepthThreshold ? lerp(diffuse, xd, 0.5) : lerp(lerp(diffuse, xd, 0.5), lerp(diffuse, blurColor, 0.5), blurDepthColorStrength);
        cnt += xdep.w >= bdep - blurDepthThreshold ? 1.0 : 0.5;
        bdep = xdep.w >= bdep - blurDepthThreshold ? lerp(bdep, xdep.w, blurDepthStrength) : 0;
    }
    
    if (cnt > 0)
    {
        blurColor = blurColor / cnt;
        
        return lerp(diffuse, blurColor, s0);
    }
    else
    {
        blurColor = diffuse;
        
        return blurColor;
    }
}

float4 depthBlur(float d, Texture2D depthTex, int3 iuv, int3 iofs3, Texture2D tex, int3 iuvD, int3 iofs3D, int dist, float minDepth, float maxDepth, float strength)
{
    return depthBlur(d, depthTex, iuv, iofs3, tex, iuvD, iofs3D, dist, minDepth, maxDepth, strength, float4(0, 0, 0, 0));

}

float4 blur3(Texture2D tex, int3 iuv, int3 iofs3, int dist, float strength, float4 diffuseBlend)
{
    int3 tuv;
    tex.GetDimensions(tuv.x, tuv.y);
    tuv = int3(tuv.x, tuv.y, 0);

    // Sample the original texture
    float4 color = tex.Load((iuv + iofs3));
    
    float4 blurColor =
            lerp((tex.Load((iuv + iofs3) + int3(-dist, -dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(-dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, -dist, 0))) / 6.0,
                (tex.Load((iuv + iofs3) + int3(-dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, -dist, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, dist, 0))) / 4.0,
            0.75);
    
    dist *= 0.8;
    
    float4 blurColor2 =
            lerp((tex.Load((iuv + iofs3) + int3(-dist, -dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(-dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, -dist, 0))) / 6.0,
                (tex.Load((iuv + iofs3) + int3(-dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, -dist, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, dist, 0))) / 4.0,
            0.75);
    
    dist *= 0.8;
    
    float4 blurColor3 =
            lerp((tex.Load((iuv + iofs3) + int3(-dist, -dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(-dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, -dist, 0))) / 6.0,
                (tex.Load((iuv + iofs3) + int3(-dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, -dist, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, dist, 0))) / 4.0,
            0.75);
    
    
    dist *= 0.8;
    
    float4 blurColor4 =
            lerp((tex.Load((iuv + iofs3) + int3(-dist, -dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(-dist, dist, 0)) +
                tex.Load((iuv + iofs3) + int3(dist, -dist, 0))) / 6.0,
                (tex.Load((iuv + iofs3) + int3(-dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(dist, 0, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, -dist, 0)) +
                    tex.Load((iuv + iofs3) + int3(0, dist, 0))) / 4.0,
            0.75);
    
    float s0 = strength;
    return saturate(lerp(color, lerp(blurColor4, lerp(blurColor3, lerp(blurColor2, blurColor, 0.5), 0.5), 0.5), s0));
}

float4 blur3(Texture2D tex, float2 uv, float2 ofs, float dist, float strength, float4 diffuseBlend)
{
    float2 tuv;
    tex.GetDimensions(tuv.x, tuv.y);
    

    return saturate
    (blur3(tex, int3(int(uv.x * tuv.x), int(uv.y * tuv.y), 0), int3(int(ofs.x * tuv.x), int(ofs.y * tuv.y), 0), int(dist), strength, diffuseBlend));
}

float4 blur2(Texture2D tex, float2 uv, float2 ofs, float dist, float strength)
{
    return blur3(tex, uv, ofs, dist, strength, float4(0, 0, 0, 0));

}


float4 bloom3(Texture2D tex, float2 uv, float2 ofs, float dist, float threshold, float4 minColor, float4 power)
{
    // Sample the original texture
    float4 color = mir2D(tex, uv + ofs);
    
    // Average the color
    
    float4 finalColor = color;
    
    if ((color.x < 0.001 && color.y < 0.001 && color.z < 0.001) || (color.x >= threshold || color.y >= threshold || color.z >= threshold))
    {
        float2 tuv;
        tex.GetDimensions(tuv.x, tuv.y);
        tuv = 1.0 / tuv;

        float4 blurColor =
        
            lerp(
                lerp((mir2D(tex, uv + ofs + float2(-dist, -dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(dist, dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(-dist, dist) * .5 * tuv) +
                    mir2D(tex, uv + ofs + float2(dist, -dist) * .5 * tuv)) / 4.0,
                    lerp(mir2D(tex, uv + ofs + float2(-dist, 0) * tuv),
                        mir2D(tex, uv + ofs + float2(dist, 0) * tuv),
                    0.5),
                0.5),
                lerp(mir2D(tex, uv + ofs + float2(0, -dist) * tuv),
                    mir2D(tex, uv + ofs + float2(0, dist) * tuv),
                0.5),
            0.5);

        finalColor = power * (finalColor + minColor + blurColor);
    }

    return saturate(finalColor);
}
float4 bloomI2(Texture2D tex, float2 uv, float2 ofs, float dist, float threshold, float power)
{
    float2 tuv;
    tex.GetDimensions(tuv.x, tuv.y);
    tuv = 1 / tuv;
    // Sample the original texture
    float4 color = mir2D(tex, uv + ofs);
    float4 blurColor =
            mir2D(tex, uv + ofs + float2(-dist, -dist) * .5 * tuv) * 0.25 +
            mir2D(tex, uv + ofs + float2(dist, dist) * .5 * tuv) * 0.25 +
            mir2D(tex, uv + ofs + float2(-dist, dist) * .5 * tuv) * 0.25 +
            mir2D(tex, uv + ofs + float2(dist, -dist) * .5 * tuv) * 0.25 +
            mir2D(tex, uv + ofs + float2(-dist, 0) * tuv) * 0.5 +
            mir2D(tex, uv + ofs + float2(dist, 0) * tuv) * 0.5 +
            mir2D(tex, uv + ofs + float2(0, -dist) * tuv) * 0.5 +
            mir2D(tex, uv + ofs + float2(0, dist) * tuv) * 0.5;

// Average the color
    blurColor *= 1.0 / 3.0;
    
    float4 finalColor = color;
    
    if (length(color) < threshold)
    {
        finalColor = (blurColor * power);
    }

    return saturate(finalColor);
}
// Constants (can be defined externally)
#define NUM_LAYERS 8
static float4 AuroraColors[NUM_LAYERS] =
{
    float4(0.0, 0.4, 1.0, 1.0), // Blue
    float4(0.0, 1.0, 0.0, 1.0), // Green
    float4(0.0, 0.2, 0.8, 1.0), // Blue-Green
    float4(1.0, 0.5, 0.0, 1.0), // Orange
    float4(0.8, 0.0, 0.8, 1.0), // Purple
    float4(0.8, 0.5, 1.0, 1.0), // Bright-Purpls?
    float4(1.0, 0.2, 0.2, 1.0),
    float4(1.0, 1.0, 1.0, 1.0) // White
};
#define AURORA_SPEED 0.005
#define AURORA_INTENSITY 0.002
#define AURORA_FREQUENCY 0.03
#define AURORA_SHIFT 3.4 // Shift between aurora layers
#define AURORA_SCALE_MIN .02 // Minimum scale factor for aurora layers
#define AURORA_SCALE_MAX .040 // Maximum scale factor for aurora layers
#define GLITTER_INTENSITY .01 // Intensity of glittering


float4 CalculateSpecularReflection(float4 viewDir, float4 normal, float4 tangent, float4 specularColor, float roughness, float f0)
{
    float cosTheta = dot(viewDir, tangent);
    float4 R = FresnelSchlick4(specularColor, cosTheta, f0);
    float4 specularReflection = specularColor * (R * (roughness + 1.0) * (roughness + 1.0)) / (4.0 * roughness * roughness * (1.0 + R * (roughness - 1.0) * (roughness - 1.0)));
    
    return specularReflection;
}

// Shader function to compute the visually enhanced aurora effect with glitter
float4 ComputeAurora(float2 texCoord, float d)
{
    float4 auroraColor = float4(0.0, 0.0, 0.0, 1.0);
    
    // Create dynamic wave patterns for aurora
    float waveOffset = sin(timr * TotalTime * AURORA_SPEED) * 0.5 + 0.5;

    for (int i = 0; i < NUM_LAYERS; i++)
    {
        // Add a shift to create a visually pleasing separation between layers
        float shiftedTexCoordX = texCoord.x - i * AURORA_SHIFT;

        // Calculate the aurora's position on the screen
        float auroraPosition = shiftedTexCoordX * 2.0 - waveOffset;

        // Apply a smooth step function to create more defined layers
        float smoothStepFactor = smoothstep(0.4, 0.6, abs(auroraPosition));

        // Scale the aurora effect with layer-specific scale factors (randomized)
        float scale = lerp(AURORA_SCALE_MIN, AURORA_SCALE_MAX, frac(sin(dot(texCoord, float2(2.9898, 7.233))) * 4758.5453));
        float scaledAuroraEffect = sin(auroraPosition * AURORA_FREQUENCY) * AURORA_INTENSITY * scale * smoothStepFactor;

        // Combine the aurora layers with different colors
        auroraColor.rgb += AuroraColors[i] * scaledAuroraEffect;
    }
    
    // Add glittering stars
    float glitter = (sin(pow(abs(((timr * TotalTime + 0.1) * ((timr * TotalTime + (1.0 - 0.1))))), 0.5) * AURORA_SPEED * 2.0) * 1.5 + 0.25) * .5;
    auroraColor.rgb += 0.2 * float4(glitter / 2.0, glitter, glitter / 3.0, 1.0);
    
    return auroraColor;

}

float2 correctUV(float4 dir)
{
    return float2(
            atan2(dir.x - 0.5, dir.z) / (2.0f * 3.14159f) + 0.5f,
            acos(dir.y - 0.5));
}
float4 CalcLighting(float fresnelMix, float4 scalar, float4 fresnel, float4 f0, float4 r0, float4 pix, float4 diffuse, float4 viewDir, float4 N, float occlusionFactor, float4 pixW, float2 uv, float d, float2 ofs, float specularIntensity, float specularPower, float phaseFactor, float4 dirLightDir, float4 pointLightPos, float4 spotLightPos, float4 spotLightDir, float pointLightIntensity, float pointLightExponent, float pointLightRadius)
{
    float4 d0 = diffuse;
    
    
    DirectionalLight dirLight = CreateDirectionalLight(dirLightDir, diffuse, .068923, f0, r0, specularIntensity, specularPower, phaseFactor, fresnelMix);
    
    
    spotLightPos = float4(spotLightPos.xyz, 1.0);
    spotLightDir = float4(normalize(spotLightDir.xyz), 1.0);
    
    SpotLight spotLight = CreateSpotLight(spotLightPos, spotLightDir, diffuse,
    .7, 1.4f, f0, r0, spotLightPos + spotLightDir * length(spotLightPos) * 2.0, 2.9935f, 0.99, float4(1, .01, 0.0162, 1.0), specularIntensity, specularPower, phaseFactor, fresnelMix);

    PointLight pointLight = CreatePointLight(
    pointLightPos, diffuse,
    pointLightIntensity, pointLightExponent, f0, r0, pointLightRadius, float4(2, 0.10, .001, 1.0), specularIntensity, specularPower, phaseFactor, fresnelMix);
    
    // Calculate diffuse lighting for each light type
    float scatteringCoefficient = 0.3;
    float4 diffPoint = clamp01(pointLight.PointLightDiffuse(d, N, viewDir, pix, occlusionFactor, scatteringCoefficient, phaseFactor));
    
    float4 diffLight = clamp01(dirLight.DirectionalLightDiffuse(pix, diffuse, N, viewDir, fresnel, phaseFactor, occlusionFactor));
    
    float4 diffSpot = clamp01(spotLight.SpotLightDiffuse(N, pix, viewDir, float4(normalize(spotLightDir.xyz), 1.0), float4((spotLightPos - pix).xyz, 1.0), fresnel, phaseFactor, occlusionFactor));
    
    // Combine
    float4 finalColor =
        (diffLight + diffPoint) / 2
        - occlusionFactor * 0.015;
    
    float rim = clamp01(pow(1.0 - clamp01(max(0, dot(normalize(-viewDir.xyz), normalize(N.xyz)))), 4.0));
    float3 rimColor = diffuse * rim;
 
    float backscatter = clamp01(pow(1.0 - clamp01(max(0.0, dot(normalize(-viewDir.xyz), normalize(N.xyz)))), 3.0));
    float3 sssColor = diffuse * backscatter;

    float4 ret = clamp01(finalColor);
    ret = lerp(ret, ret + clamp01(float4(rimColor, 1) + clamp01(float4(sssColor, 1))), fresnelMix);
    return ret * fresnel;
}




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
float4 RotateAroundX(float4 v, float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float4(v.x, c * v.y - s * v.z, s * v.y + c * v.z, v.w);
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

bool RayIntersectSphere(float4 rayOrigin, float4 rayDir, float4 sphereCenter, float sphereRadius, out float t0, out float t1)
{
    float4 m = rayOrigin - sphereCenter;
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





float4 AdjustTemperature(float4 color, float temperature, float tint)
{
    // Apply temperature adjustment
    color.rgb += float4(temperature - 0.5, 0.0, -(temperature - 0.5), 1.0);

    // Apply tint adjustment
    color.rgb += float4(tint - 0.5, -(tint - 0.5), 0.0, 1.0);

    return color;
}

float4 AdjustExposure(float4 color, float exposure)
{
    // Apply exposure adjustment
    color *= pow(2.0, exposure);

    return color;
}

float4 AdjustBrightnessAndContrast(float4 color, float brightness, float contrast)
{
    // Apply brightness and contrast adjustments
    color = (color - 0.5) * contrast + 0.5 + brightness;

    return color;
}

float4 AdjustHue(float4 color, float hue)
{
    // Apply hue adjustment
    color = (color + hue);

    return color;
}



// Define some constants
#define NUM_SLICES 3.0 // number of slices in texture array
#define THRESHOLD 0.5 // threshold for color change
#define DECAY 0.9 // decay factor for pressure
#define K 0.1 // constant factor for torque
#define RADIUS 0.1 // radius of rotation
#define AREA 2.0 // size of area to search for densest point


//rtMap1 = output
//rtMap2 = pressure x,y,z
//rtMap3 = momentum x,y,z


float4 CalculateInterference(float4 viewDir,
    float4 normal, float modulationFrequency,
    float modulationStrength, float angularIntensity)
{
    // Calculate modulation factor
    float modulationFactor = modulationStrength * sin(modulationFrequency * length(viewDir));

    // Calculate interference pattern
    float4 interference = modulationFactor * cos(angularIntensity * dot(-viewDir, normal)) * normal;
    return interference;
}


// FluidSim.hlsl

SamplerState PointSampler : register(s0);

float2 Laplacian(float2 uv, Texture2D tex)
{
    static float2 offsets[4] =
    {
        float2(-1.0, 0.0),
        float2(1.0, 0.0),
        float2(0.0, -1.0),
        float2(0.0, 1.0)
    };
    float2 laplacian = float2(0, 0);
    for (int i = 0; i < 4; ++i)
    {
        laplacian += tex.Sample(PointSampler, uv + offsets[i]).xy;
    }
    laplacian -= 4.0 * tex.Sample(PointSampler, uv).xy;
    return laplacian;
}

float4 updateWater(float4 position, float2 uv, Texture2D velocityRT, Texture2D densityRT, Texture2D pressureRT)
{
    float2 velocity = velocityRT.Sample(PointSampler, uv).xy;
    float density = densityRT.Sample(PointSampler, uv).x;
    float pressure = pressureRT.Sample(PointSampler, uv).x;

    // Advection
    float2 advectedUV = uv - 0.1 * velocity;
    float2 advectedVelocity = velocityRT.Sample(PointSampler, advectedUV).xy;

    // Pressure gradient & Jacobi iteration
    float2 gradient = Laplacian(uv, pressureRT);
    float newPressure = pressure + 0.1 * Laplacian(uv, densityRT);

    // Update velocity
    velocity = advectedVelocity - 0.1 * gradient;

    // Buoyancy
    velocity.y += 0.01 * density;

    // Update density
    density = densityRT.Sample(PointSampler, advectedUV).x;

    return float4(velocity, density, newPressure);
}


struct uvUpdateResult
{
    psout retv;
    float2 sz;
    float2 oosz;
    

    float3 pix3;
    float3 pix3W;
    
    float2 uv0;
    float2 uv1;
    float2 uv;
    float normalRadius0;
    float normalRadius1;
    float normalRadius;
    float4 viewDir0;
    float2 depthGradient0;
    float2 depthGradient1;
    float2 depthGradient;
    float omd0;
    float omd1;
    float omd;
    float d0;
    float d1;
    float d;
    float specI;
    float specP;
    float4 viewPos0;
    float4 viewTarget0;
    float2 omd0Grad;
    float2 omd1Grad;
    float2 omdGrad;
    float2 SwayScale;
    float2 SwayAmount;
    float2 SwayScale2;
    float2 SwayAmount2;
    float centerDist;
    float omCenterDist;
    float omD0PlusCenterDist;
    float omD1PlusCenterDist;
    float omDPlusCenterDist;
    float ct0;
    float ct1;
    float ct;
    float4 normal0;
    float4 normal1;
    float4 normal;
    float4 normalc0;
    float4 normalc1;
    float4 normalc;
    float4 normalx0;
    float4 normalx1;
    float4 normalx;
    
    float4 lookAt;
    float4 lookAtW0;
    float4 lookAtW1;
    float4 lookAtW;
    float4 lookAtUV0;
    float4 lookAtUV1;
    float4 lookAtUV;
    
    float4 dcRange1;
    float4 dcRange2;
    float4 dcRange3;
    float4 dc1;
    float4 dcx1;
    float4 dc2;
    float4 dcx2;
    float4 dc3;
    float4 dcx3;
    float dc1Avg;
    float dc2Avg;
    float dc3Avg;
    float dcx1Avg;
    float dcx2Avg;
    float dcx3Avg;
    float dc1AvgF;
    float dc2AvgF;
    float dc3AvgF;
    
    float2 uvD0;
    float2 uvD1;
    float2 uvD;
    
    float fresnelPower;
    float fresnelReflectance;
    float4 diffuse;
    float4 diffuse0;
    float depthScale;
};


float3 ComputeColorAtRefraction(uvUpdateResult ret, float3 refractionDir, float3 normal)
{
    // Compute a fake refraction vector. This is a simplification and won't
    // give accurate refraction, but can create an interesting visual effect.
    float3 fakeRefraction = refractionDir * normal * 0.01; // The 0.05 value controls the strength of the refraction.
    
    // Project the fake refraction vector into screen space.
    float2 screenPos = float2(
        fakeRefraction.x / fakeRefraction.z,
        fakeRefraction.y / fakeRefraction.z
    );
    
    // Scale and bias to convert from [-1,1] to [0,1] range.
    screenPos = screenPos * 0.5 + 0.5;
    float2 suvd = ret.uv0 + screenPos * float2(0.0011, 0.002);
    
    float2 suvd2 = ret.uv0 + screenPos * float2(0.0021, 0.003);
    
    float4 fres2 = Fresnel(mir2D(diffuseMap, ret.uv));
    

    float4 schlick = Schlick(fres2, 0.5 + ret.omd * 0.25,
        ret.fresnelPower);
    
    float4 schlick2 = Schlick(fres2, clamp01(dot(ret.normal, ret.viewDir0)),
        ret.fresnelPower);
    
    float3 rgb1 = schlick * mir2D(diffuseMap, lerp(ret.uv, suvd, 0.995)).rgb * schlick;
    float3 rgb0 = mir2D(diffuseMap, lerp(ret.uv, suvd2, 0.9995)).rgb * schlick2;
    
    return (rgb0 * rgb1);
}

float3 ComputeHolographicDispersion(uvUpdateResult ret, float3 viewDir, float3 normal, float dispersionFactor)
{
    // Control the strength of the dispersion effect
    float3 refractedColors;

    // Red channel
    float3 refractionDir = refract(viewDir, normal, 1.0 - dispersionFactor);
   
    refractedColors.r = ComputeColorAtRefraction(ret, refractionDir, normal); // Assume this function samples color from environment

    // Green channel (no dispersion)
    refractionDir = refract(viewDir, normal, cos(dot(-viewDir, normal)));
    refractedColors.g = ComputeColorAtRefraction(ret, refractionDir, normal); // Assume this function samples color from environment

    // Blue channel
    refractionDir = refract(viewDir, normal, cos(dispersionFactor));
    refractedColors.b = ComputeColorAtRefraction(ret, refractionDir, normal); // Assume this function samples color from environment
    
    return refractedColors;
}


float3 HolographicSBDRF(uvUpdateResult ret, float3 lightDir, float3 viewDir, float3 normal, float3 baseColor, float metallic, float roughness, float dispersionFactor)
{
    float3 halfDir = normalize(-lightDir + -viewDir);
    float NdotL = max(dot(normal, -lightDir), 0.0);
    float NdotV = max(dot(normal, -viewDir), 0.0);
    float NdotH = max(dot(normal, halfDir), 0.0);
    float VdotH = max(dot(-viewDir, halfDir), 0.0);
    
    float3 F0 = float4(lerp(
        baseColor, baseColor, metallic).xyz, 0.3);
   
    float3 F = F0 + (1.0 - F0) * pow(1.0 - VdotH, 5.0);
    
    
    float alpha = clamp(roughness * roughness, 0.2, 0.8);
    float D = exp((NdotH * NdotH - 1.0) / (alpha * alpha * NdotH * NdotH)) / (3.14159265 * alpha * alpha * NdotH * NdotH * NdotH * NdotH);
    float G = min(1.0, min((2.0 * NdotH * NdotV) / VdotH, (2.0 * NdotH * NdotL) / VdotH));
    
    float specular = (D * G * F) / (4.0 * NdotL * NdotV + .1);
    
    float3 holographicDispersion = 300 * ComputeHolographicDispersion(ret, viewDir, normal, dispersionFactor); // Custom function to compute holographic dispersion
    return F0 * dispersionFactor * (holographicDispersion + specular);
}


float4 getNormal(uvUpdateResult ret)
{
    float4 retv = mir2D(normalMap, ret.uv);
    
    if (PassNum < 1)
    {
        retv = mir2D(normalMap, ret.uv);
    
        ret.retv.rt6 = float4(normalize(XCrossLRUDfAvg3(ret.oosz, normalMap, ret.uv, ret.normalRadius)), 1);

    }
    else
    {
        float f = ret.normalRadius;
        float cnt = 0.0f;
       
        retv = float4((retv.xyz + XCrossLRUDfAvg3(ret.oosz, rtMap6, ret.uv, f)) / 2.0, 1);
        cnt++;
        f -= 5;
        
        retv += float4((retv.xyz + XCrossLRUDfAvg3(ret.oosz, normalMap, ret.uv, f)) / 2.0, 1);
        cnt++;
        f -= 5;
        retv /= cnt;
    }
    
    retv = float4(normalize(retv.xyz), 1.0);
    
    return retv;
}

uvUpdateResult updateUV(uvUpdateResult ret, float passNum, float maxPass, float lerpPct)
{
    
    float passPct = (passNum + 1.0) / maxPass;
    float2 uvD = passNum == 0.0 ? float2(0.0, 0.0) : abs(ret.uv - ret.uv0);
    
    ret.d1 = XCrossLRUDfAvg(ret.oosz, depthMap, ret.uv, 2.0 * ret.depthScale);
    
    ret.depthGradient1 = float2(ddx_fine(ret.d1), ddy_fine(ret.d1));
    
    ret.d = ret.d1;
    
    ret.depthGradient = ret.depthGradient1;
    
    
    ret.omd1 = (1.0 - ret.d1);
    ret.omd = ret.omd1;
    
    
    ret.ct1 = (sinTime01(timr / 17) + ret.omd);
    ret.ct = lerp(ret.ct0, ret.ct1, 0.5 * (cosTime01(timr / 14) + clamp01(ret.d + 0.25)));
    
    ret.omd1Grad = (1.0 - ret.depthGradient1 * 100);
    ret.omdGrad = ret.omd1Grad;
    
    
    ret.normal = getNormal(ret);
    
    
    uvD = (ret.uv - ret.uv0);
    ret.centerDist = clamp01(distance(float3(ret.uv, ret.d), float3(0.5, 0.5, clamp01(mir2D(depthMap, 0.5).r))));
    ret.omCenterDist = (1.0 - ret.centerDist);

    ret.specI = clamp(SpecularIntensity, 0.07001, 99.0);
    ret.specP = clamp(SpecularPower, 1.0, 99.0);
       
    
    float2 ss1 = 
        (ret.d)
        * ret.ct * float2(.0135, .016) * ret.depthScale + (ret.depthGradient);
    
    float2 ss0 = (ret.omd)
    * ret.ct * float2(-.00153, .019) * ret.depthScale - (ret.depthGradient);
   
    
    ret.SwayScale = (((ss1) + (ss0)) * ret.depthScale * float2(0.02, 0.05) * ret.omd *
    ((PassNum + 1) / 4) * 0.4) * .5
    - (((ss1) + (ss0)) * ret.depthScale * float2(0.01, 0.025) *
    ((PassNum + 1) / 4) * 0.4);
    
    
    ret.SwayAmount = ret.uv + ret.SwayScale * ret.depthScale;
    
    float refractionIndex = clamp(round(10.0 * ret.depthGradient * clamp01(ret.d + 0.25)), 0.0, 4.0); // some value or texture lookup
    
    float3 uvViewDir = normalize((ret.lookAtUV.xy - ret.uv, clamp01(ret.d + 0.25))); // assuming Look_At is in screen space
    float2 refractedUV = clamp01(refractionIndex * cross(float3(normalize(uvViewDir.xy), 0), float3(normalize(ret.depthGradient), 0)).xy);
    
    float2 fuv01 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.omd + refractedUV;
    
    float2 fuv11 = ret.uv + ret.depthGradient + ret.SwayAmount * ret.d - refractedUV;
   
    float2 fuv02 = ret.uv + ret.depthGradient - ret.SwayAmount * ret.omd * ret.depthGradient;
   
    float2 fuv12 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.d * ret.depthGradient;
  
    float2 uv0111 = lerp(fuv01, fuv12, 0.25 + 0.5 * clamp01(ret.omd + 0.25));
    float2 uv0212 = lerp(fuv11, fuv02, 0.25 + 0.5 * clamp01(ret.d + 0.25));
    
    ret.uv1 = lerp(uv0111, uv0212, (ret.omd + ret.d) * .5);
    //ret.uv1 = clamp01(lerp(ret.uv0, ret.uv1, lerpPct));
    ret.uv = ret.uv1;
    
    
    ret.d = mir2D(depthMap, ret.uv);
    
    ret.pix3 = float3(ret.uv, ret.d);
    ret.pix3W = float3(ret.uv, clamp01(ret.d + 0.25) * ret.depthScale);
    uvD = abs(ret.uv1 - ret.uv0);
    
    ret.dc1 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius));
    ret.dcx1 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * .5));
    ret.dc2 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * .50));
    ret.dcx2 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * .25));
    ret.dc3 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * .25));
    ret.dcx3 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * .125));
    ret.dc1Avg = (ret.dc1.x + ret.dc1.y + ret.dc1.z + ret.dc1.w) / 4.0;
    ret.dc2Avg = (ret.dc2.x + ret.dc2.y + ret.dc2.z + ret.dc2.w) / 4.0;
    ret.dc3Avg = (ret.dc3.x + ret.dc3.y + ret.dc3.z + ret.dc3.w) / 4.0;
    ret.dcx1Avg = (ret.dcx1.x + ret.dcx1.y + ret.dcx1.z + ret.dcx1.w) / 4.0;
    ret.dcx2Avg = (ret.dcx2.x + ret.dcx2.y + ret.dcx2.z + ret.dcx2.w) / 4.0;
    ret.dcx3Avg = (ret.dcx3.x + ret.dcx3.y + ret.dcx3.z + ret.dcx3.w) / 4.0;
    ret.dc1AvgF = lerp(ret.dc1Avg, ret.dcx1Avg, lerpPct);
    ret.dc2AvgF = lerp(ret.dc2Avg, ret.dcx2Avg, lerpPct);
    ret.dc3AvgF = lerp(ret.dc3Avg, ret.dcx3Avg, lerpPct);
    
    
    ret.dcRange1 = float4(
        max(ret.dc1.x, ret.dcx1.x) - min(ret.dc1.x, ret.dcx1.x),
        max(ret.dc1.y, ret.dcx1.y) - min(ret.dc1.y, ret.dcx1.y),
        max(ret.dc1.z, ret.dcx1.z) - min(ret.dc1.z, ret.dcx1.z),
        max(ret.dc1.w, ret.dcx1.w) - min(ret.dc1.w, ret.dcx1.w));
    
    ret.dcRange2 = float4(
        max(ret.dc2.x, ret.dcx2.x) - min(ret.dc2.x, ret.dcx2.x),
        max(ret.dc2.y, ret.dcx2.y) - min(ret.dc2.y, ret.dcx2.y),
        max(ret.dc2.z, ret.dcx2.z) - min(ret.dc2.z, ret.dcx2.z),
        max(ret.dc2.w, ret.dcx2.w) - min(ret.dc2.w, ret.dcx2.w));
    
    ret.dcRange3 = float4(
        max(ret.dc3.x, ret.dcx3.x) - min(ret.dc3.x, ret.dcx3.x),
        max(ret.dc3.y, ret.dcx3.y) - min(ret.dc3.y, ret.dcx3.y),
        max(ret.dc3.z, ret.dcx3.z) - min(ret.dc3.z, ret.dcx3.z),
        max(ret.dc3.w, ret.dcx3.w) - min(ret.dc3.w, ret.dcx3.w));
    
    ret.d1 = lerp(lerp(ret.dc1AvgF, ret.dc2AvgF, lerpPct), ret.dc3AvgF, lerpPct);
    ret.depthGradient1 = float2(ddx_fine(ret.d1), ddy_fine(ret.d1));
    ret.d = ret.d1;
    
    
    
    ret.depthGradient = ret.depthGradient1;
    
    ret.omd1 = (1.0 - ret.d1);
    ret.omd = lerp(ret.omd0, ret.omd1, lerpPct);
    
    ret.ct1 = (sinTime01(timr / 27) + ret.omd);
    ret.ct = lerp(ret.ct0, ret.ct1, 0.5 * (cosTime01(timr / 14) + clamp01(ret.d + 0.25)));
    
    ret.omd1Grad = (1.0 - ret.depthGradient1);
    ret.omdGrad = ret.omd1Grad;
    
    ret.omD1PlusCenterDist = ((ret.centerDist + ret.omd1) / 2.0);
    ret.omDPlusCenterDist = lerp(ret.omD0PlusCenterDist, ret.omD1PlusCenterDist, lerpPct);
    
    
    
    ss1 = (ret.d)
        * ret.ct * float2(.0135, .016) + (ret.depthGradient / ret.depthScale);
    
    ss0 = (ret.omd * ret.omCenterDist)
    * ret.ct * float2(-.00153, .019) - (ret.depthGradient / ret.depthScale);
    
    ret.SwayScale = (ss1) + (ss0);
    
    
    ret.SwayAmount = (RotateAroundZ((ret.uv - 1), cosTime01(timr / 12) * 0.35 + 1).xy + ret.uv + 0.5) * ret.SwayScale;
    
    refractionIndex = clamp(round(10.0 * ret.depthGradient * clamp01(ret.d + 0.25)), 0.0, 4.0); // some value or texture lookup
    
    uvViewDir = normalize((ret.lookAtUV.xy - ret.uv, clamp01(ret.d + 0.25))); // assuming Look_At is in screen space
    refractedUV = clamp01(refractionIndex * cross(float3(normalize(uvViewDir.xy), 0), float3(normalize(ret.depthGradient), 0)).xy);
   
    fuv01 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.omd + refractedUV;
    
    fuv11 = ret.uv + ret.depthGradient + ret.SwayAmount * ret.d - refractedUV;
   
    fuv02 = ret.uv + ret.depthGradient - ret.SwayAmount * ret.omd * ret.depthGradient;
   
    fuv12 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.d * ret.depthGradient;
  
    uv0111 = lerp(fuv01, fuv12, 0.25 + 0.5 * clamp01(ret.omd + 0.25));
    uv0212 = lerp(fuv11, fuv02, 0.25 + 0.5 * clamp01(ret.d + 0.25));
    
    ret.uv1 = lerp(uv0111, uv0212, (ret.omd + ret.d) * .5);
    //ret.uv1 = clamp01(lerp(ret.uv0, ret.uv1, lerpPct));
    ret.uv = ret.uv1;
    
    ret.d = mir2D(depthMap, ret.uv);
    
    ret.pix3 = float3(ret.uv, ret.d);
    ret.pix3W = float3(ret.uv, clamp01(ret.d + 0.25) * ret.depthScale);
    uvD = abs(ret.uv1 - ret.uv0);
    
    ret.dc1 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius));
    ret.dcx1 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * 1.5));
    ret.dc2 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * 2.));
    ret.dcx2 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * 2.5));
    ret.dc3 = (CrossLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * 3.0));
    ret.dcx3 = (XLRUDf(ret.oosz, depthMap, ret.uv, ret.normalRadius * 3.5));
    ret.dc1Avg = (ret.dc1.x + ret.dc1.y + ret.dc1.z + ret.dc1.w) / 4.0;
    ret.dc2Avg = (ret.dc2.x + ret.dc2.y + ret.dc2.z + ret.dc2.w) / 4.0;
    ret.dc3Avg = (ret.dc3.x + ret.dc3.y + ret.dc3.z + ret.dc3.w) / 4.0;
    ret.dcx1Avg = (ret.dcx1.x + ret.dcx1.y + ret.dcx1.z + ret.dcx1.w) / 4.0;
    ret.dcx2Avg = (ret.dcx2.x + ret.dcx2.y + ret.dcx2.z + ret.dcx2.w) / 4.0;
    ret.dcx3Avg = (ret.dcx3.x + ret.dcx3.y + ret.dcx3.z + ret.dcx3.w) / 4.0;
    ret.dc1AvgF = lerp(ret.dc1Avg, ret.dcx1Avg, lerpPct);
    ret.dc2AvgF = lerp(ret.dc2Avg, ret.dcx2Avg, lerpPct);
    ret.dc3AvgF = lerp(ret.dc3Avg, ret.dcx3Avg, lerpPct);
    
    
    ret.dcRange1 = float4(
        max(ret.dc1.x, ret.dcx1.x) - min(ret.dc1.x, ret.dcx1.x),
        max(ret.dc1.y, ret.dcx1.y) - min(ret.dc1.y, ret.dcx1.y),
        max(ret.dc1.z, ret.dcx1.z) - min(ret.dc1.z, ret.dcx1.z),
        max(ret.dc1.w, ret.dcx1.w) - min(ret.dc1.w, ret.dcx1.w));
    
    ret.dcRange2 = float4(
        max(ret.dc2.x, ret.dcx2.x) - min(ret.dc2.x, ret.dcx2.x),
        max(ret.dc2.y, ret.dcx2.y) - min(ret.dc2.y, ret.dcx2.y),
        max(ret.dc2.z, ret.dcx2.z) - min(ret.dc2.z, ret.dcx2.z),
        max(ret.dc2.w, ret.dcx2.w) - min(ret.dc2.w, ret.dcx2.w));
    
    ret.dcRange3 = float4(
        max(ret.dc3.x, ret.dcx3.x) - min(ret.dc3.x, ret.dcx3.x),
        max(ret.dc3.y, ret.dcx3.y) - min(ret.dc3.y, ret.dcx3.y),
        max(ret.dc3.z, ret.dcx3.z) - min(ret.dc3.z, ret.dcx3.z),
        max(ret.dc3.w, ret.dcx3.w) - min(ret.dc3.w, ret.dcx3.w));
    
    ret.d1 = lerp(lerp(ret.dc1AvgF, ret.dc2AvgF, lerpPct), ret.dc3AvgF, lerpPct);
    ret.depthGradient1 = float2(ddx_fine(ret.d1), ddy_fine(ret.d1));
    ret.d = ret.d1;
    ret.pix3 = float3(ret.uv, ret.d);
    ret.pix3W = float3(ret.uv, ret.d * ret.depthScale);
    ret.depthGradient = ret.depthGradient1;
    
    
    ret.omd0 = (1.0 - ret.d0);
    ret.omd1 = (1.0 - ret.d1);
    ret.omd = lerp(ret.omd0, ret.omd1, lerpPct);
    
    
    ret.ct0 = cosTime01(timr / 15) + ret.d;
    ret.ct1 = (sinTime01(timr / 17) + ret.omd);
    ret.ct = lerp(ret.ct0, ret.ct1, 0.5 * (cosTime01(timr / 14) + ret.d));
    
    ret.omd1Grad = (1.0 - ret.depthGradient1);
    ret.omdGrad = ret.omd1Grad;
    
    
    ret.omD0PlusCenterDist = ((ret.centerDist + ret.omd0) / 2.0);
    ret.omD1PlusCenterDist = ((ret.centerDist + ret.omd1) / 2.0);
    ret.omDPlusCenterDist = lerp(ret.omD0PlusCenterDist, ret.omD1PlusCenterDist, lerpPct);
    
    
    
    ss1 = (ret.d) * 10
        * ret.ct * float2(-.00135, .0016) - (ret.depthGradient / ret.depthScale);
    
    ss0 = (ret.omd * ret.omCenterDist) * 10
    * ret.ct * float2(-.00153, .019) - (ret.depthGradient / ret.depthScale);
    
    ret.SwayScale = (ss1) * (ss0);
    
    ret.SwayAmount = (RotateAroundZ((ret.uv - 1), 2 * cosTime01(timr / 10)).xy + 1) * ret.SwayScale * .5;
    
    refractionIndex = clamp(round(4.0 * ret.depthGradient * clamp01(ret.d + 0.25)), 0.0, 4.0); // some value or texture lookup
    
    uvViewDir = normalize((ret.lookAtUV.xy - ret.uv, clamp01(ret.d + 0.25))); // assuming Look_At is in screen space
    refractedUV = clamp01(refractionIndex * cross(float3(normalize(uvViewDir.xy), 0), float3(normalize(ret.depthGradient), 0)).xy);
    
    fuv01 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.omd + refractedUV;
    
    fuv11 = ret.uv + ret.depthGradient + ret.SwayAmount * ret.d - refractedUV;
   
    fuv02 = ret.uv + ret.depthGradient - ret.SwayAmount * ret.omd * ret.depthGradient;
   
    fuv12 = ret.uv - ret.depthGradient - ret.SwayAmount * ret.d * ret.depthGradient;
  
    uv0111 = lerp(fuv01, fuv12, PerlinNoise(float3(ret.uv, TotalTime * clamp01(ret.omd))));
    uv0212 = lerp(fuv11, fuv02, PerlinNoise(float3(ret.uv, TotalTime * clamp01(ret.d))));
    
    ret.uv1 = lerp(uv0111, uv0212, (ret.omd + ret.d) * .5);
    //ret.uv1 = clamp01(lerp(ret.uv0, ret.uv1, lerpPct));
    ret.uv = ret.uv1;
    
    
    /*
    ret.normal = .25 * CalculateDepthNormalV6(ret.dc3, ret.d);
    ret.normal += .25 * CalculateDepthNormalV6(ret.dc2, ret.d);
    ret.normal += .25 * CalculateDepthNormalV6(ret.dc1, ret.d);
    ret.normal += .1 * CalculateDepthNormalV6(ret.dcx3, ret.d);
    ret.normal += .1 * CalculateDepthNormalV6(ret.dcx2, ret.d);
    ret.normal += .1 * CalculateDepthNormalV6(ret.dcx1, ret.d);
    */
    
    ret.normal = getNormal(ret);
    
    return ret;
}


float getDepth(float2 oosz, float2 uv, float normalRadius)
{
    return XCrossLRUDfAvg(oosz, depthMap, uv, normalRadius);
}


float getDepthFromResult(uvUpdateResult ret)
{
    return mir2D(depthMap, ret.uv).r;
}

float Sigmoid(float x)
{
    const float sigmoidScale = 6.0; // Adjust this to control the steepness of the sigmoid curve
    return 1.0 / (1.0 + exp(-sigmoidScale * x));
}

// Updated function to calculate gradient modulation
float GradientModulation(float2 depthGradient)
{
    const float maxGradientMagnitude = depthGradient < 0.5 ? depthGradient*depthGradient : depthGradient; // Define the maximum expected gradient magnitude

    // Normalize the gradient magnitude
    float normalizedMagnitude = min(length(depthGradient) / maxGradientMagnitude, 1.0);

    // Apply sigmoid function to smoothly transition the modulation factor
    return Sigmoid(normalizedMagnitude);
}


float2 ComputeDetailedDepthGradient(float2 uv, int radius, int radiusStep)
{
    float2 sz;
    depthMap.GetDimensions(sz.x, sz.y);
    float2 oosz = 1.0 / sz;
    
    float2 gradientSum = float2(0.0, 0.0);
   
    for (int i = -radius; i <= radius; i += radiusStep)
    {
        for (int j = -radius; j <= radius; j += radiusStep)
        {
            float2 sampleUV = uv + float2(i, j) * radiusStep * 5 * oosz;
            float d = mir2D(depthMap, sampleUV);
            
            float depthLeft = mir2D(depthMap, sampleUV + float2(-1, 0) * oosz * 5 * d).r;
            float depthRight = mir2D(depthMap, sampleUV + float2(1, 0) * oosz * 5 * d).r;
            float depthTop = mir2D(depthMap, sampleUV + float2(0, -1) * oosz * 5 * d).r;
            float depthBottom = mir2D(depthMap, sampleUV + float2(0, 1) * oosz * 5 * d).r;

            float dx = (depthRight - depthLeft) * 0.5;
            float dy = (depthBottom - depthTop) * 0.5;

            gradientSum += float2(dx, dy);
        }
    }

    return gradientSum / ((radius * 2 + 1.0) * (radius * 2 + 1.0));
}

float2 CalculateSway(float depth, float2 uv, float2 depthGradient, float2 swayIntensity = 0.005)
{
    // Parameters for sway
    const float depthSwayScale = log((2 - depth) * (MATH_E / 2)); // '2 - depth' replaces 'depth + 1'

    // Sway calculation
    float2 swayFactor = sin(TotalTime) * swayIntensity;
    float depthWeight = 1.0 - (depth * depthSwayScale);

    // Apply gradient modulation
    float gradientModulation = GradientModulation(depthGradient);

    // Calculate UV sway with gradient modulation
    float2 uvSway = uv + swayFactor * depthWeight * gradientModulation;

    return uvSway;
}


float2 SophisticatedDepthEffect(float depthScale, float depth, float2 uv, float2 detailedGradient)
{
    const float scaledDepthScale = 0.07 * depthScale;
    const float gradientIntensity = LOOK_AT.x * FresnelMix;

    // Adjust depth factor for closer objects
    float depthFactor = depth < 0.2 ? pow(depth, 2) * scaledDepthScale : exp(-depth * scaledDepthScale);
    float2 gradientEffect = detailedGradient * gradientIntensity;

    return depthFactor * gradientEffect;
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
float RandomNoiseAvg(float2 uv)
{
    
    float d = mir2D(depthMap, uv);
    
    float centerDist = clamp01((length(uv - 0.5))) / 4;
    
    
    // Example: Simple noise function based on UV coordinates
    // Use a more sophisticated noise function if necessary
    return
    (DepthCurveAdjustment(1 - d, 0.9f, 0.045f, 0.01f) * (RandomNoise(uv) +
        (RandomNoise(uv + float2(0.001, 0)) +
        RandomNoise(uv + float2(-0.001, 0)) +
        RandomNoise(uv + float2(0, -0.001)) +
        RandomNoise(uv + float2(0, 0.001))) / 4.0) / 2.0);
    
}


float BaseNoiseFunction(float2 uv)
{
    // Implement your base noise algorithm here (e.g., Perlin/Simplex noise)
    return RandomNoiseAvg(uv);
}

float DepthNoiseAdaptation(float depth)
{
    // Logic to adapt noise based on depth
    // Example: less noise in farther objects
    return 1.0 - saturate(depth); // Adjust this formula as needed
}

float LightingNoiseAdaptation(float lightingIntensity)
{
    // Logic to adapt noise based on lighting intensity
    // Example: less noise in brighter areas
    return 1.0 - saturate(lightingIntensity); // Adjust this formula as needed
}

float RoughnessNoiseAdaptation(float surfaceRoughness)
{
    // Logic to adapt noise based on surface roughness
    // Example: more noise on rougher surfaces
    return surfaceRoughness; // Adjust this formula as needed
}

float AdaptiveNoise(float2 uv, float depth, float lightingIntensity, float surfaceRoughness)
{
    // Base noise function - can be Perlin, Simplex, or any other noise algorithm
    float baseNoise = BaseNoiseFunction(uv);

    // Depth-based noise adaptation
    float depthNoiseFactor = DepthNoiseAdaptation(depth);

    // Lighting-based noise adaptation
    float lightingNoiseFactor = LightingNoiseAdaptation(lightingIntensity);

    // Surface roughness adaptation
    float roughnessNoiseFactor = RoughnessNoiseAdaptation(surfaceRoughness);

    // Combine all factors
    float combinedNoise = baseNoise * depthNoiseFactor * lightingNoiseFactor * roughnessNoiseFactor;

    return combinedNoise;
}

float2 AdaptiveDepthEffect(float depthScale, float depth, float2 uv, float2 detailedGradient, float lightingIntensity)
{
    float DepthAdaptivity = depth;
    float DepthMidpoint = 0.7;
    float GradientScale = 0.910;
    
    // Adaptive depth scaling
    float adaptiveScale = 1.0 / (1.0 + exp(DepthAdaptivity * (DepthMidpoint - depth)));

    // Enhanced gradient calculation
    float gradientFactor = GradientModulation(detailedGradient) * GradientScale;
    float2 gradientEffect = detailedGradient * gradientFactor;

    // Depth curve adjustment
    float depthCurveFactor = DepthCurveAdjustment(depth, 0.012f, 0.015f, 0.01f);

    // Noise based on depth
    float noiseFactor = ((1 - depth) * AdaptiveNoise(uv, depthCurveFactor, lightingIntensity, 0.2) * gradientFactor) / 50.0;

    // Combine effects for final depth effect
    float2 depthEffect = adaptiveScale * (gradientEffect+ depthCurveFactor + noiseFactor);

    return depthEffect;
}

// Other supporting functions like CalculateContextFactor, DepthCurveAdjustment, RandomNoise, etc., should be defined accordingly


float2 ApplyDiffraction(float2 uv, float2 depthGradient)
{
    const float diffractionIntensity = 0.01; // Adjust this value based on desired intensity

    // Compute the direction and magnitude of the gradient
    float gradientMagnitude = length(depthGradient);
    float2 gradientDirection = normalize(depthGradient);

    // Apply diffraction effect
    // Bend light outward down the slope of steep gradients
    float2 diffractionUV = uv + diffractionIntensity * gradientMagnitude * gradientDirection;

    return diffractionUV;
}


float2 CalcUV(float2 oosz, float2 uv, float normalRadius, float depthScale, float2 swayScale, float lightingIntensity)
{
    // Get depth and detailed gradient
    float depth = XCrossLRUDfAvg(oosz, depthMap, uv, normalRadius);
    
    float2 detailedGradient = ComputeDetailedDepthGradient(uv, max(12,normalRadius), max(4, normalRadius/4));
    
    // Apply sophisticated depth effect
    float2 uvOffset = AdaptiveDepthEffect(depthScale, depth, uv, detailedGradient, lightingIntensity);
    
    // Apply sway to UV coordinates
    float2 swayedUV = CalculateSway(depth, ApplyDiffraction(uv + uvOffset, detailedGradient), detailedGradient, 
        depth * depthScale * swayScale);

    // Apply diffraction-based UV adjustment
    float2 diffractionAdjustedUV = ApplyDiffraction(swayedUV, -detailedGradient*depthScale);


    return diffractionAdjustedUV;
}
float4 RedBlueDepthEffect(float2 oosz, Texture2D tex, float2 uv, float depth, float eyeOffset)
{
    // Calculate left and right eye UV coordinates
    float2 leftUV = uv - (eyeOffset * oosz) * DepthScale;
    float2 rightUV = uv + (eyeOffset * oosz) * DepthScale;

    // Sample the scene from the perspective of each eye
    float4 leftEyeColor = mir2D(tex, leftUV).rrrr; // Assuming a function that samples your scene
    float4 rightEyeColor = mir2D(tex, rightUV).bbbb;

    // Apply red tint to the left eye and blue tint to the right eye
    float4 redTinted = leftEyeColor * float4(1, 0, 0, 1);
    float4 blueTinted = rightEyeColor * float4(0, 0, 1, 1);

    // Combine the two tinted images
    return saturate(redTinted + blueTinted);
}


struct PassData
{
    float4 color;
    float depth;
    float3 normal;
};

float2 AdjustUVForDepth(float2 uv, float depth, float depthScale, float2 swayDistance)
{
    // Scale the depth
    float scaledDepth = (1 - depth) * depthScale;

    // Calculate sway based on scaled depth
    float2 sway = scaledDepth * swayDistance;

    // Adjust UV
    return uv + sway * depth;
}

PassData SamplePassData(float2 oosz, int passIndex, float2 uv, float normalRadius, float depth, float depthScale, float2 swayDistance)
{
    
    PassData data;
    
    data.depth = XCrossLRUDfAvg(oosz, depthMap, uv, max(24, normalRadius * (1 - depth)));
    float2 adjUV = AdjustUVForDepth(uv, depth, depthScale, swayDistance);
        
    data.color = mir2D(rtMap8, adjUV);
    data.normal = normalize(XCrossLRUDfAvg(oosz, rtMap7, adjUV,max(24, normalRadius * (1 - depth)) * 2 - 1)); // If normals are used
   
    return data;
}

// Complex depth weighting function
float CalculateDepthWeight(float depth, float depthWeightFactor, float normalInfluence)
{
    // Non-linear depth weighting - experiment with different formulas
    return pow(depthWeightFactor / (depth + depthWeightFactor), normalInfluence);
}

// Sophisticated color blending function
float4 AdvancedColorBlend(float4 currentColor, float4 newColor, float depthWeight, float3 normal, float3 viewDir)
{
    // Implement advanced blending techniques
    // Placeholder: Depth and normal influenced blend
    float blendFactor = smoothstep(0.5, 1.0, depthWeight * dot(normalize(normal), viewDir));
    return lerp(currentColor, newColor, blendFactor);
}


// Color correction function
float4 ApplyColorCorrection(float4 color, float gammaCorrectionFactor)
{
    // Implement dynamic color correction
    return pow(color, float4(1.0 / gammaCorrectionFactor, 1.0 / gammaCorrectionFactor, 1.0 / gammaCorrectionFactor, 1.0));
}

// Main function to combine passes
float4 CombinePasses(float2 oosz, float2 uv, float depth, float3 viewDir, float depthWeightFactor, float normalInfluence, float gammaCorrectionFactor, float normalRadius, float depthScale, float2 swayDistance)
{
    float4 finalColor = float4(0, 0, 0, 0);
    float totalWeight = 0;
    
    PassData data = SamplePassData(oosz, PassNum, uv, normalRadius, depth, depthScale, swayDistance);
        
    float weight = CalculateDepthWeight(depth, depthWeightFactor, normalInfluence);
    //finalColor = data.color;
    finalColor = AdvancedColorBlend(finalColor, data.color, weight, data.normal, viewDir);
        
    finalColor = finalColor * ApplySurfaceEffects(finalColor, viewDir, data.normal.xyz, uv, 1);
    totalWeight *= XCrossLRUDfAvg(oosz, depthMap, uv, 2);
    
   
    // Normalize the final color by total weight
    finalColor *= totalWeight;
    
    
    finalColor = ApplyColorCorrection(finalColor, gammaCorrectionFactor);

    return finalColor;
}
// HLSL Shader Code for Light Transport Through Impure Glass

float3 GetNormal(float2 uv)
{
    return normalize(mir2D(normalMap, uv).rgb * 2 - 1);
}

// Noise function for glass impurities
float2 GlassNoise(float3 position)
{
    // Advanced noise function (Perlin/Simplex noise can be replaced with a more complex noise model)
    return Random2(position.xy).xy; // Example multiplier for noise scale
}
float LayeredNoise(float3 position)
{
    // Combining multiple noise functions with different frequencies
    float noise1 = WorleyNoise(position, 0.5); // Lower frequency noise
    float noise2 = WorleyNoise(position, 1.5); // Higher frequency noise
    float noise3 = WorleyNoise(position, 3.0); // Even higher frequency noise

    // Combining the noise functions to create layered effect
    return (noise1 + noise2 + noise3) / 3.0; // Average to get layered noise
}

// Function to simulate iceberg-like glass noise
float3 IcebergGlassNoise(float d, float3 position)
{
    float layeredNoise = LayeredNoise(position);
    
    // Define color layers (e.g., shades of blue and white)
    float3 baseColor = float3(0.3, 0.5, 0.7); // Deep blue
    float3 midColor = float3(0.5, 0.7, 0.9); // Lighter blue
    float3 topColor = float3(0.63, 0.6, 8.0); // Near white

    // Interpolate between colors based on noise value
    float3 color;
    if (layeredNoise < d)
        color = lerp(baseColor, midColor, layeredNoise / 0.33);
    else if (layeredNoise < PerlinNoise(position)*2)
        color = AdvancedColorBlend(float4(midColor, 1), float4(topColor, 1), (layeredNoise - 0.33) / 0.33, float3(0, 0, 1), float3(0, 0, -1)).xyz;
    else
        color = lerp(topColor, baseColor, (layeredNoise - 0.66) / 0.34);

    return color;
}

float3 DiffractionCalculation(float3 rayDirection, float2 uv, float3 impurity)
{
    float3 normal = GetNormal(uv); // Using GetNormal function for consistency
    float diffractionAngle = asin(length(impurity) * 0.02); // Scalar angle
    float3 diffractionAxis = normalize(cross(rayDirection, normal));
    float4 rotationQuaternion = float4(diffractionAxis * sin(diffractionAngle / 2.0), cos(diffractionAngle / 2.0));
    float3 diffractionDirection = mul(rotationQuaternion, rayDirection);
    return normalize(diffractionDirection);
}

float3 ColorDispersionCalculation(float3 LightSource, float3 rayDirection, float3 impurity)
{
    float dispersionFactor = saturate(length(impurity) * 0.1); // Normalized factor
    float3 colorShift = lerp(float3(1.0, 0.95, 0.9), float3(0.9, 1.0, 1.05), dispersionFactor);
    return colorShift * dot(rayDirection, LightSource);
}

float3 ComputeFresnel(float3 rayDirection, float3 normal, float3 refractiveIndex)
{
    float cosTheta = dot(-rayDirection, normal);
    float3 r0 = (1.0 - refractiveIndex) / (1.0 + refractiveIndex);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow(1.0 - cosTheta, 5.0);
}

float3 RefractRay(float3 rayDirection, float3 normal, float refractiveIndex)
{
    float cosTheta = dot(-rayDirection, normal);
    float sinTheta2 = refractiveIndex * refractiveIndex * (1.0 - cosTheta * cosTheta);
    if (sinTheta2 > 1.0)
        return float3(0, 0, 0); // Total internal reflection
    float cosTheta2 = sqrt(1.0 - sinTheta2);
    return refractiveIndex * rayDirection + (refractiveIndex * cosTheta - cosTheta2) * normal;
}


float3 RayMarchGlass(float d, float2 oosz, float3 rayOrigin, float3 rayDirection, float2 uv, float RefractiveIndex, float3 GlassColor)
{
    float depth = (1 - getDepth(oosz, uv, 20));
    float3 accumulatedColor = float3(0, 0, 0);
    float3 pos = float3(uv, 0);
    float3 normal = GetNormal(uv); // Simplified normal, replace with actual surface normal calculation
    float increment = 0.002;
    rayDirection = normalize(rayDirection);
    for (float traveledDistance = 0; traveledDistance < increment * 2; traveledDistance += increment)
    {
        float3 velocity = rayDirection * increment;
        float3 impurity = (IcebergGlassNoise(d, pos + velocity)) + float3(GlassNoise(pos + velocity), 0);
       
        float3 fresnel = ComputeFresnel(rayDirection, normal, RefractiveIndex * impurity);
        float3 refracted = RefractRay(rayDirection, normal, depth * RefractiveIndex);
        
        float3 dir2 = DiffractionCalculation(rayDirection, pos.xy, impurity);
        
        refracted = (refracted + dir2 * .05 * getDepth(oosz, pos.xy, 20)) - rayDirection * .025 * (1 - getDepth(oosz, pos.xy, 15).r);
        // Absorption and transmission
        accumulatedColor +=
            float4(mir2D(diffuseMap, pos.xy).rgb * increment * .5 + impurity * (1.0 - fresnel) * GlassColor, 1);
        
        rayDirection = refracted;
        
        pos += velocity;
        
    }
    
    return accumulatedColor / traveledDistance;
}
float ComputeFresnel2(float3 rayDirection, float3 normal, float refractiveIndex)
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
float3 RefractRay2(float3 rayDirection, float3 normal, float refractiveIndex)
{
    float cosI = dot(-rayDirection, normal);
    float sinT2 = refractiveIndex * refractiveIndex * (1.0 - cosI * cosI);
    if (sinT2 > 1.0)
        return float3(0.0, 0.0, 0.0); // Total internal reflection
    float cosT = sqrt(1.0 - sinT2);
    return refractiveIndex * rayDirection + (refractiveIndex * cosI - cosT) * normal;
}


float4 LiquidCrystalPattern2(float3 position, float3 direction)
{
    // This function should be replaced with an appropriate pattern generator
    // Placeholder: simple color pattern based on position
    return float4(sin(position.x), cos(position.y), sin(position.z), 1.0);
}
float4 RayMarchTest(float d, float2 oosz, float2 uv, float normalRadius, float3 lightSource)
{
    float3 rayDirection = normalize(lightSource - float3(uv.xy, 0));
    int icolor = 5.0 * (length(mir2D(diffuseMap, uv)));
    float3 color = RayMarchGlass(d, oosz, lightSource, rayDirection, uv, 1.5,
        float3(.209, .2298, .26293) * AuroraColors[icolor].xyz);
    return float4(color, 1.0);
}
float4 LiquidCrystalPattern(float d, float2 oosz, float3 position, float3 direction)
{
    const float3 NoiseScale = mir2D(depthMap, position.xy);
    float ColorIntensity = mir2D(depthMap, position.xy) * .5;
    
    // Modulate position with noise for organic variability
    float noiseValue = PerlinNoise(position * NoiseScale);
  
    // Trigonometric functions for color patterns
    float r = abs(sin(position.x * noiseValue + direction.x));
    float g = abs(cos(position.y * noiseValue + direction.y));
    float b = abs(sin(position.z * noiseValue + direction.z));

    // Create a vibrant, shifting color pattern
    float3 color = float3(r, g, b) * ColorIntensity;

    return float4(color, 1) * RayMarchTest(d, oosz, position.xy, 4, direction) *
    (ColorIntensity) + .4 * mir2D(diffuseMap, position.xy);
}



float4 RayMarch2(float d, float2 oosz, float3 rayOrigin, float3 rayDirection)
{
    float3 currentPos = rayOrigin;
    float4 accumulatedColor = float4(0.0, 0.0, 0.0, 0.0);
    
    float totalDistance = 0.0;
    const float RefractiveIndex = 1.5;
    const float StepSize = 0.01;
    
    for (int i = 0; i < 2; i++)
    {
        if (totalDistance > .1)
            break; // Exit if the ray has traveled enough

        // Placeholder for the normal of the liquid crystal surface
        // Replace with actual normal calculation based on your scene
        float3 normal = GetNormal(currentPos.xy);
        const float RefractiveIndex = 1.5 + length(mir2D(diffuseMap, rayDirection.xy)) * .02;
        float fresnelEffect = ComputeFresnel2(rayDirection, normal, RefractiveIndex);
        rayDirection = RefractRay2(rayDirection, normal, RefractiveIndex / (1.0 + fresnelEffect));

        currentPos += rayDirection * StepSize;
        totalDistance += StepSize;

        // Simulate the liquid crystal pattern and light interaction
        float4 patternColor = LiquidCrystalPattern(d, oosz, currentPos, rayDirection);
        accumulatedColor += patternColor * (1.0 - fresnelEffect) * (5 / (i + 1)) * StepSize;
    }

    return accumulatedColor * 20;
}

float4 LiquidCrystal2(float d, float2 oosz, float2 uv)
{
    float3 rayOrigin = float3(uv, 1); // Starting point of the ray
    float3 rayDirection = -normalize(mir2D(normalMap, uv) * 2 - 1); // Direction of the ray

    return RayMarch2(d, oosz, rayOrigin, rayDirection);
}
// Ray Marching Function
float3 RayMarch(float2 oosz, float3 LightSource, float3 rayOrigin, float3 rayDirection, float2 uv, float normalRadius)
{
    float3 accumulatedColor = float3(0, 0, 0);
    float traveledDistance = 0.0;
    float maxDistance = 2;
    float stepSize = .03;
    float depth = getDepth(oosz, uv, normalRadius);
    
    while (traveledDistance < maxDistance)
    {
        float3 currentPosition = rayOrigin + rayDirection * stepSize;
        float impurity = GlassNoise(currentPosition);
       
        rayDirection = normalize(DiffractionCalculation(rayDirection, currentPosition.xy, impurity));
        
        float3 dispersedColor = ColorDispersionCalculation(LightSource, rayDirection, impurity);
        accumulatedColor += dispersedColor * stepSize; // Accumulate color with respect to step size
        traveledDistance += stepSize;
        
        rayOrigin = currentPosition;
        
        accumulatedColor += RayMarchGlass(depth, oosz, rayOrigin, rayDirection, uv, 1.5,
            float3(.2, .2, .3) * depth);
    }
    return (accumulatedColor / traveledDistance); // Normalizing the accumulated color
}


// Pixel Shader Entry Point

// Function to interpolate between two colors with a twist
float4 InterpolateWithTwist(float4 color1, float4 color2, float factor, float twistFactor)
{
    float angle = twistFactor * factor * 3.14159 * 2.0; // Twist angle
    float2 rotatedUV = float2(cos(angle), sin(angle)); // Rotate UV coordinates
    return lerp(color1, color2, dot(rotatedUV, float2(0.5, 0.5)));
}

// Function to calculate twist factor based on position and normal
float CalculateTwistFactor(float3 position, float3 normal)
{
    // Use the dot product of position and normal to get a varying factor
    return dot(normalize(position), normalize(normal));
}
// Fresnel equation for reflectance

// Snell's Law for refraction


// Function to simulate the liquid crystal pattern


float4 LiquidCrystal(float2 uv)
{
    float4 accumulatedColor = float4(0, 0, 0, 0);
    float2 texCoord;
    float MaxSamples = 4;
    
    [unroll]
    for (int i = 0; i < MaxSamples; i++)
    {
        // Sample the texture with shifted UV coordinates
        texCoord = uv + float2(cos(float(i)), sin(float(i))) * 0.005; // Creating a circular sampling pattern
        float4 sampledColor = mir2D(diffuseMap, texCoord);

        // Calculate twist factor
        float twistFactor = CalculateTwistFactor(float3(uv, 0), float3(0, 0, 1));

        // Interpolate colors with a twist
        accumulatedColor += InterpolateWithTwist(accumulatedColor, sampledColor, float(i) / MaxSamples, twistFactor);
    }

    return accumulatedColor / (MaxSamples * MaxSamples) / 30;
}

psout PS(PS_INPUT input)
{
    psout retv;
    retv.rt1 = mir2D(rtMap1, input.TexCoord);
    retv.rt2 = mir2D(rtMap2, input.TexCoord);
    retv.rt3 = mir2D(rtMap3, input.TexCoord);
    retv.rt4 = mir2D(rtMap4, input.TexCoord);
    retv.rt5 = mir2D(rtMap5, input.TexCoord);
    retv.rt6 = mir2D(rtMap6, input.TexCoord);
    retv.rt7 = mir2D(rtMap7, input.TexCoord);
    
    int maxPass = NumPasses;
    
    uvUpdateResult ret;
    float fd1 = mir2D(depthMap, input.TexCoord).r;
   // retv.rt7 = float4(fd1, fd1, fd1, 1);
    ret.retv = retv;
  //  ret.retv.rt7 = retv.rt7;
    
    float2 uv = input.TexCoord;
    float d = mir2D(depthMap, uv).r;

    float dW = (d);
    float fresnelMix = FresnelMix;
    float normalRadius = 50.0;
    
    ret.normalRadius = NormalRadius - fmod(NormalRadius, 2);
    float2 sz;
    depthMap.GetDimensions(sz.x, sz.y);
    ret.sz = sz;
    ret.oosz = 1.0 / ret.sz;
    
    ret.uv0 = input.TexCoord;
    ret.uv1 = ret.uv0;
    ret.uv = ret.uv0;
    ret.diffuse0 = mir2D(diffuseMap, ret.uv);
    ret.diffuse = mir2D(diffuseMap, ret.uv);
    ret.normalRadius0 = ret.normalRadius;
    ret.normalRadius1 = ret.normalRadius;
    ret.normal0 = float4(0.0, 0.0, -1.0, 1.0);
    ret.normal1 = ret.normal0;
    ret.normal = ret.normal1;
    ret.depthGradient0 = 0.0;
    ret.depthGradient1 = 0.0;
    ret.depthGradient = 0.0;
    
    ret.d0 = dW;
    ret.d1 = dW;
    ret.d = dW;
    
    ret.omd0 = 1 - ret.d0;
    ret.omd1 = 1 - ret.d1;
    ret.omd = 1 - ret.d;
    
    ret.specI = 0.0;
    ret.specP = 0.0;
   
    ret.viewPos0 = (0.5, 0.5, 100, 1.0);
    ret.viewTarget0 = float4(0.5, 0.5, 0, 1.0);
    ret.viewDir0 = float4(0, 0, -1, 1);
    
    ret.omd0Grad = 0.0;
    ret.omd1Grad = 0.0;
    ret.omdGrad = 0.0;
    ret.SwayScale = (1.0, 1.0);
    ret.centerDist = distance(ret.uv, 0.5);
    ret.omCenterDist = 0.0;
    ret.omD0PlusCenterDist = 0.0;
    ret.omD1PlusCenterDist = 0.0;
    ret.omDPlusCenterDist = 0.0;
    
    ret.dcRange1 = 0.0;
    ret.dcRange2 = 0.0;
    ret.dcRange3 = 0.0;
    ret.dc1 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dcx1 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dc2 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dcx2 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dc3 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dcx3 = float4(0.0, 0.0, 0.0, 0.0);
    ret.dc1Avg = 0.0;
    ret.dc2Avg = 0.0;
    ret.dc3Avg = 0.0;
    ret.dcx1Avg = 0.0;
    ret.dcx2Avg = 0.0;
    ret.dcx3Avg = 0.0;
    ret.dc1AvgF = 0.0;
    ret.dc2AvgF = 0.0;
    ret.dc3AvgF = 0.0;
    ret.uvD0 = float2(0.0, 0.0);
    ret.uvD1 = ret.uvD0;
    ret.uvD = ret.uvD1;
    ret.pix3 = float3(uv, d);
    ret.pix3W = float3(uv, dW);
    
    float lerpPct = 0.95;
    ret.d1 = mir2D(depthMap, ret.uv).r;
    ret.d0 = ret.d1;
    ret.d = ret.d0;
    ret.SwayAmount = 0;
    ret.SwayAmount2 = 0;
    ret.SwayScale = 0;
    ret.SwayScale2 = 0;
    ret.ct0 = cosTime01(timr / 15);
    ret.ct1 = (sinTime01(timr / 17));
    ret.ct = lerp(ret.ct0, ret.ct1, (cosTime01(timr / 14)));
    
    ret.fresnelPower = FresnelPower - ret.ct0 * .4;
    ret.fresnelReflectance = FresnelReflectance + ret.ct1 * 3;
    
    ret.depthScale = DepthScale;
    
    ret.uv1 = ret.uv;
    
    
    ret.d0 = ret.d;
    ret.omd0 = ret.omd;
    ret.omd0Grad = ret.omdGrad;
    ret.uvD0 = ret.uvD;
    
    
    ret.uvD0 = float2(0, 0);
    ret.uvD1 = ret.uvD0;
    ret.uvD = ret.uvD1;
    
    
    ret.d0 = XCrossLRUDfAvg(ret.oosz, depthMap, ret.uv, 2);
   
    ret.depthGradient0 = float2(ddx_fine(ret.d0), ddy_fine(ret.d0));
    
    
    ret.omd0 = (1.0 - ret.d);
    ret.ct0 = cosTime01(timr / 15) + ret.d;
    ret.omd0Grad = (1.0 - ret.depthGradient0 * 100);
    
    
    ret.omD0PlusCenterDist = ((ret.centerDist + ret.omd0) / 2.0);
    
    [unroll]
   // for (int x = 0; x < 5; x++)
    {
        
        ret.d1 = ret.d;
        ret.omd1 = ret.omd;
        ret.omd1Grad = ret.omdGrad;
        ret.uvD1 = ret.uvD;
        ret.uv1 = ret.uv;
    
        
        ret = updateUV(ret, PassNum, maxPass, lerpPct);
           
        if (PassNum == 0)
        {
            retv.rt2 = float4(ret.uv.x, ret.uv.y, ret.d, 1) * .5 + 1;
        }
        
        
        ret.pix3 = float3(ret.uv, ret.d);
        ret.pix3W = float3(ret.uv, ret.d * ret.depthScale);
        ret.uvD = abs(ret.uv0 - ret.uv);

    }
    ret.diffuse0 = mir2D(diffuseMap, ret.uv);
    
    float2 swayScale = float2(0.0062, 0.0061);
    ret.uv = CalcUV(ret.oosz, ret.uv0, ret.normalRadius, ret.depthScale / 2.0, 
        swayScale, length(ret.diffuse0 / 4.0));
    ret.diffuse = mir2D(diffuseMap, ret.uv);
    
    ret.uv = CalcUV(ret.oosz, ret.uv, ret.normalRadius, ret.depthScale,
        swayScale / 4.0f, length(ret.diffuse / 4.0));
    ret.diffuse = mir2D(diffuseMap, ret.uv);
    
    float4 spotLightPos = float4(0.0, 10.0, -100.0, 1.0);
    float4 spotLightTarget = float4(0, 0, 0, 1);
    float4 spotLightDir = normalize(spotLightTarget - spotLightPos);
    
    float4 pointLightIconColor = float4(1, 1, 1, 1);
    float4 pointLightPos = float4(0, 0, -ret.depthScale * 1.2, 1);
    
    float pointLightIntensity = 1;
    float pointLightExponent = 1;
    float pointLightRadius = 2;
    
    
    float phaseFactor = PassNum * 1000 * ret.ct1;
    
    
    
    
    float4 f0 = 0;
    float4 r0 = 0;
    
    //spotLightPos.x += cos(TotalTime * 2 * 3.14159) * ret.ct*3;
    //spotLightPos.y += sin(TotalTime * 3 * 3.14159)*ret.ct*3;
    /**/
    float occ = CalculateOcclusionFactorDC(ret.oosz, ret.uv, float2(0, 0), ret.sz, ret.omd, 123, 6, 0.001,
        ret.dc3, ret.dcx3, ret.dc2, ret.dcx2, ret.dc1, ret.dcx1);
    
    if (PassNum < 1)
    {
        retv.rt1 = ret.diffuse;
    }
    float4 fres0 = Fresnel(retv.rt1);
    
    float4 schlick1 = Schlick(ret.diffuse, max(0, dot(-ret.viewDir0, ret.normal)),
        fres0 * ret.fresnelPower);
    
    
    retv.rt2 = ((CalcLighting(fresnelMix, 1, schlick1, f0, r0, float4(ret.uv.x, ret.uv.y, depth2Df(lerp(ret.uv0, ret.uv, 0.95)), 1.0),
    mir2D(diffuseMap, ret.uv), ret.viewDir0, ret.normal, 0, float4(ret.uv.x, ret.uv.y, depth2Df(lerp(ret.uv0, ret.uv, 0.95)), 1.0), lerp(ret.uv0, ret.uv, 0.95), depth2Df(lerp(ret.uv0, ret.uv, 0.95)), 0.0, ret.specI, ret.specP, phaseFactor, ret.viewPos0,
      float4(pointLightPos.xy, pointLightPos.z, 1),
      float4(spotLightPos.xy, spotLightPos.z, 1),
      float4(normalize(spotLightDir.xyz), 1.0),
      pointLightIntensity, pointLightExponent, pointLightRadius)));
    
    
    float range = ret.d / (ret.dc1AvgF - ret.dc3AvgF);
    
    
    
    if (PassNum == 0)
    {
        
        int icolor = int(ret.d * 8);
      
        retv.rt1 = 
            AuroraColors[icolor] * LiquidCrystal(ret.uv)
        
         + (retv.rt2 * schlick1) + float4(RedBlueDepthEffect(ret.oosz, diffuseMap, ret.uv, ret.d, ret.d).xyz, 0.25);
          
    
    }
    else if (PassNum == 1)
    {
        retv.rt1 += 
          
                LiquidCrystal(DiffractionCalculation(normalize(ret.pix3 - ret.viewPos0.xyz), ret.uv, 0.01 * sqrt(ret.diffuse.xyz - ret.diffuse0.xyz)).xy);
    
    }
    else if (PassNum >= 2)
    {
    
        retv.rt1 = ret.d*
            CombinePasses(ret.oosz, ret.uv, 
        ret.d, ret.viewDir0.xyz, 
        0.25, 0.25, 0.25, ret.normalRadius, 
        ret.depthScale, float2(0.001, 0.001));

    }
    if (LButton && RButton)
    {
        if (KeyShift)
        {
            retv.rt1 = ret.diffuse0 * 0.5;
        }
        if (KeyAlt)
        {
            retv.rt1 =  retv.rt2;
        }
       
    }
    else if (RButton)
    {
        if (KeyControl)
        {
            retv.rt1 = float4(mir2D(rtMap5,
                    RotateAroundZ(float4((ret.uv - 0.5) * (LOOK_AT.x * 10 - 0.5), ret.d, retv.rt1.w), LOOK_AT.y * 2 * 3.14159) + 0.5
                ).xyz, retv.rt1.w);

        }
    }
    
    return retv;
}




