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
