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



