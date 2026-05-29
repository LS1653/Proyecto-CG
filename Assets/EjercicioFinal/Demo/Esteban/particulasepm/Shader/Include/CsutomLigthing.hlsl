//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

#ifndef CUSTOM_LIGHTING
#define CUSTOM_LIGHTING

void MainLight_float(float3 PositionWS, out float3 Direction, out float3 Color, out float ShadowAttenuation)//float -> 32 bits
{
    #if defined(SHADERGRAPH_PREVIEW)
    
    Direction = normalize(float3(1, 1, -1)); //Intrincecamente normalizado, pero se normaliza de nuevo para asegurarse de que es un vector unitario 
    Color = 1.0f;
    ShadowAttenuation = 1.0f; // No shadow attenuation in preview mode
    #else
    float4 shadowCoord = TransformWorldToShadowCoord(PositionWS);
    Light mainLight = GetMainLight(shadowCoord);
    Direction = mainLight.direction;
    Color = mainLight.color;
    ShadowAttenuation = mainLight.shadowAttenuation;
    #endif
}


void AdditionalLightsSimple_float(float2 UVSS, float3 PositionWS, float3 ViewDirectionWS, float3 NormalWS, out float3 Lit)
{
#ifdef SHADERGRAPH_PREVIEW
    Lit = 0;
#else
    Lit = 0;
    uint additionalLightCount = GetAdditionalLightsCount();
    
    //TODO: Forward+

    #ifdef USE_FORWARD_PLUS
    InputData inputData = (InputData)0;
    inputData.normalizedScreenSpaceUV = UVSS;
    inputData.positionWS = PositionWS;
    #endif
    float a = 0;

    LIGHT_LOOP_BEGIN(additionalLightCount);

    Light currentLight = GetAdditionalLight(lightIndex, PositionWS);

    //Diffuse
    float lambert = dot(currentLight.direction, NormalWS);
    lambert = max(0, lambert * 0.5f + 0.5f); //half lambert
    float3 diffuse = lambert
    * currentLight.color
    * currentLight.shadowAttenuation
    * currentLight.distanceAttenuation;

    //Specular
    float3 h = normalize(ViewDirectionWS + currentLight.direction);
    float blinnPhong = dot(h, NormalWS);
    blinnPhong = max(0, blinnPhong);
    blinnPhong = pow(blinnPhong, 60.0f);
    float3 specular = blinnPhong
    * currentLight.color
    * currentLight.shadowAttenuation
    * currentLight.distanceAttenuation;

    Lit += diffuse + specular;
    LIGHT_LOOP_END
    
#endif
}
#endif