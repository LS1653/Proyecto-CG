#ifndef GAUSSIAN_FILTERS_G1
#define GAUSSIAN_FILTERS_G1

float SampleGaussianKernel3x3(float2 coords)
{
    float index = (coords.x + 1) + ((-coords.y) + 1) * 3;
    float GaussianKernel3x3[9] =
    {
        0.06, 0.125, 0.06,
        0.125, 0.25, 0.125,
        0.06, 0.125, 0.06
    };
    return GaussianKernel3x3[clamp(index, 0, 8)];
}

void GaussianFilter3x3_float(float2 UV, float2 ScreenSize, float FilterDistance, out float4 FilteredImage)
{
    [unroll(9)]
    for (int y = 1; y >= -1; y--)
    {
        for (int x = -1; x <= 1; x++)
        {
            //Load Texture 2D LOD Utiliza las coordenadas de pixel (0 - ancho / 0-alto) y no hace operaciones de LOD
            float2 pixelCoords = UV * ScreenSize + float2(x, y) * FilterDistance;
            FilteredImage += LOAD_TEXTURE2D_X_LOD(_BlitTexture, pixelCoords, 0) * SampleGaussianKernel3x3(float2(x, y));
        }
    }
}

#endif