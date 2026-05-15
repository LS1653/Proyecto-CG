#ifndef RRADIAL_IMPACT
#define RRADIAL_IMPACT

#define ITERARIONS 16.0

void radialBlurAberration_float(float2 uv, float2 screensize, float3 offset, out float4 result )
{
    #ifndef SHADERGRAPH_PREVIEW
        result = 0;
        float2 direction = uv * 2.0f - 1.0f;

        float r = 0;
        float g = 0;
        float b = 0;

        for (int i = 0; i < ITERARIONS; i++)
        {
            float2 screenCoordR = uv * screensize - i * direction * offset.x;
            float2 screenCoordG = uv * screensize - i * direction * offset.y;
            float2 screenCoordB = uv * screensize - i * direction * offset.z;
            r += LOAD_TEXTURE2D_X_LOD(_BlitTexture, screenCoordR , 0).r * rcp(ITERARIONS);    
            g += LOAD_TEXTURE2D_X_LOD(_BlitTexture, screenCoordG , 0).b * rcp(ITERARIONS);    
            b += LOAD_TEXTURE2D_X_LOD(_BlitTexture, screenCoordB , 0).g * rcp(ITERARIONS);    

        }
        result = float4(r, g, b, 1);
    #else 
        result = float4(1,1,0,1);    


    #endif


}

#endif