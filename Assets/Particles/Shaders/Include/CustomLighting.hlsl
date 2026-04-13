//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

//Preprocessor Directive ---> "#if" o "#ifdef"

void MainLight_float(float3 PositionWS, out float3 Direction, out float3 Color, out float ShadowAttenuation) //"_float" --> Sufijo de precisión
{
    #ifdef SHADERGRAPH_PREVIEW
    Direction = normalize(float3(1, 1, -1));
    Color = 1.0f;
    ShadowAttenuation = 1.0f;

    #else
    float4 shadowCoord = TransformWorldToShadowCoord(PositionWS);
    Light mainLight = GetMainLight(shadowCoord);

    Direction = mainLight.direction;
    Color = mainLight.color;
    ShadowAttenuation = mainLight.shadowAttenuation;
    #endif
}

void AdditionalLightsSimple_float(float3 PositionWS, float3 ViewDirectionWS, float3 NormalWS, out float3 Lit)
{
    #ifdef SHADERGRAPH_PREVIEW
    Lit = 0;
    #else
    uint additionalLightCount = GetAdditionalLightsCount();

    //TODO: Forward+

    LIGHT_LOOP_BEGIN(additionalLightCount)
    Light currentLight = GetAdditionalLight(lightIndex, PositionWS);
    
    //Diffuse
    float lambert = dot(currentLight.direction, NormalWS);
    lambert = max(0, lambert * 0.5f + 0.5f); //Half Lambert
    float3 diffuse = lambert * currentLight.color * currentLight.shadowAttenuation * currentLight.distanceAttenuation;

    //Specular
    float3 h = normalize(ViewDirectionWS + currentLight.direction);
    float blinnPhong = dot(h, NormalWS);
    blinnPhong = max(0, blinnPhog);
    blinnPhong = pow(blinnPhong, 60.0f); //Blinn Phong
    float3 specular = blinnPhong * currentLight.color * currentLight.shadowAttenuation * currentLight.distanceAttenuation;
    
    Lit += diffuse + specular;
    LIGHT_LOOP_END

    #endif
}