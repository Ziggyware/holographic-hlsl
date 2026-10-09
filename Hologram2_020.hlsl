
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
