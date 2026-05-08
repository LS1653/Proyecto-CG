#ifndef GAUSSIAN_FILTER
#define GAUSSIAN_FILTER

// Gaussian filter for post-processing.
// Usage: call GaussianFilter_float(InputTexture, InputSampler, uv, ScreenSize, FilterDistance, out Color)

void GaussianFilter_float(Texture2D InputTexture, SamplerState InputSampler, float2 UV, float2 ScreenSize, float FilterDistance, out float4 FilteredImage)
{
    // 3x3 Gaussian kernel stored as row-major 1D array
    static const float Kernel[9] = {
        0.0625, 0.125,  0.0625,
        0.125,  0.25,   0.125,
        0.0625, 0.125,  0.0625
    };

    // Initialize accumulator
    FilteredImage = float4(0.0, 0.0, 0.0, 0.0);

    // Apply kernel
    [unroll]
    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 NeighborUV = UV + float2(x, y) * (FilterDistance / ScreenSize);
            NeighborUV = clamp(NeighborUV, 0.0, 1.0);

            float4 NeighborSample = InputTexture.Sample(InputSampler, NeighborUV);
            int k = (y + 1) * 3 + (x + 1);
            FilteredImage += NeighborSample * Kernel[k];
        }
    }
}

#endif // GAUSSIAN_FILTER