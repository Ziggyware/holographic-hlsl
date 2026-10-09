

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
