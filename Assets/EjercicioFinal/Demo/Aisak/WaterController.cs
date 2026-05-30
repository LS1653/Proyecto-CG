using UnityEngine;

public class WaterController : MonoBehaviour
{
    public Material WaterMaterial;

    public float duration = 1f;

    public float speed = 2f;

    float timer;

   void Update()
{
    float value = (Mathf.Sin(Time.time * speed) + 1f) / 2f;

    Debug.Log(value);

    WaterMaterial.SetFloat("_Strength", value);
}
}