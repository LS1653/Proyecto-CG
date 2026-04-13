//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

void MainLight_float(float3 PositionWS, out float3 Direction, out float3 Color, out float ShadowAttenuation)
{
    #if defined(SHADERGRAPH_PREVIEW)
    Direction = normalize(float3(1,1,-1));
    Color = 1.0f;
    ShadowAttenuation =  1.0f; 
    #else 
    float4 shadowCoord = TransformWorldToShadowCoord(PositionWS);
    Light mainLight = GetMainLight(shadowCoord);
    Direction = mainLight.direction;
    Color = mainLight.color;
    ShadowAttenuation = mainLight.shadowAttenuation;
    #endif 
}

void AdditionalLightSimple_float (float3 PositionWS, float3 ViewDirectionWS,  float3 NormalWS, out float3 Lit)
{  
    #ifdef SHADERGRAPH_PREVIEW
    Lit = 0;
    #else
    uint addtionalLightCount = GetAdditionalLightsCount();

    //TODO: Forward+

    LIGHT_LOOP_BEGIN(addtionalLightCount)
    Light currentLight = GetAdditionalLight(lightIndex, PositionWS);

    //Diffuse

    float lambert = dot(currentLight.direction, NormalWS);
    lambert = max (0, lambert * 0.5f + 0.5f); // Half Lambert
    float3 diffuse = lambert * currentLight.color * currentLight.shadowAttenuation * currentLight.distanceAttenuation;

    //Specular


    float3 h = normalize(ViewDirectionWS * currentLight.direction)
    float blingPhong = dot(h,normalize);
    blingPhong = max(0, blingPhong);
    blingPhong = pow(blingPhong, 60.0f);
    float3 specular = blingPhong * currentLight.color * currentLight.shadowAttenuation * currentLight.distanceAttenuation;

    Lit += specular + diffuse;

    LIGHT_LOOP_END

    #endif

}
