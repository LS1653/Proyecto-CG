using UnityEngine;

public class WaterController : MonoBehaviour
{
    public Material WaterMaterial;

    public float duration = 1f;

    public float speed = 2f;

    float timer;

    void Update()
    {
        timer += Time.deltaTime;

        float value = (Mathf.Sin(Time.time * speed) + 1f) / 2f;

        WaterMaterial.SetFloat("_Strenght", value);
    }
}