#ifndef GAUSSIAN_FILTERS_G1
#define GAUSSIAN_FILTERS_G1

float SampleGaussianKernel3x3(float2 coords)
{
    return 1;
}

void GaussianFilter3x3_float(float2 UV, float2 ScreenSize, float FilterDistance, out float4 FilteredImage)
{
    [unroll(9)]
    for (int y = 1; y >= -1; y--)
    {
        for (int x = -1; x <= 1; x++)
        {
            //Load Texture 2D LOD Utiliza las coordenadas de pixel (0 - ancho / 0-alto) y no hace operaciones de LOD
            float2 pixelCoords = UV * ScreenSize + float2(x, y);
            FilteredImage += LOAD_TEXTURE2D_X_LOD(_BlitTexture, pixelCoords, 0) * SampleGaussianKernel3x3(float2(x, y));
        }
    }
}

#endif