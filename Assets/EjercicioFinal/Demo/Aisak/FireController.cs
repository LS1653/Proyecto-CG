using UnityEngine;

public class FireController : MonoBehaviour
{
    public Material fireMaterial;

    public float duration = 1f;

    public float speed = 2f;

    float timer;

    void Update()
    {
        timer += Time.deltaTime;

        float value = (Mathf.Sin(Time.time * speed) + 1f) / 2f;

        fireMaterial.SetFloat("_Obturation", value);
    }
}