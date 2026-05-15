#ifndef RADIAL_IMPACT
#define RADIAL_IMPACT

#define ITERATIONS 9.0

void RadialBlurAberration_float(float2 UV, float2 ScreenSize, float3 offset, out float4 Result)
{
    #ifndef SHADERGRAPH_PREVIEW
    Result = 0;
    float2 direction = UV * 2.0f - 1.0f;
    float r = 0;
    float g = 0;
    float b = 0;

    for(int i = 0; i < ITERATIONS; i++)
    {
        float2 pixelCoordsR = UV * ScreenSize - i * direction * offset.x;
        float2 pixelCoordsG = UV * ScreenSize - i * direction * offset.y;
        float2 pixelCoordsB = UV * ScreenSize - i * direction * offset.z;

        r += LOAD_TEXTURE2D_X_LOD(_BlitTexture, pixelCoordsR, 0).r * rcp(ITERATIONS);
        g += LOAD_TEXTURE2D_X_LOD(_BlitTexture, pixelCoordsG, 0).g * rcp(ITERATIONS);
        b += LOAD_TEXTURE2D_X_LOD(_BlitTexture, pixelCoordsB, 0).b * rcp(ITERATIONS);
    }
    Result = float4(r, g, b, 1);
    #else
    Result = float4(1,1,0,1); //Amarillo
    #endif
}

#endif