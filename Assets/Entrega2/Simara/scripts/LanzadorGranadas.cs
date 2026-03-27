using UnityEngine;

public class LanzadorGranadas : MonoBehaviour
{
    public GameObject granadaMano;
    public GameObject granadaPrefab;
    public Transform puntoLanzamiento;
    public float fuerza = 10f;

    void Start()
    {
        GetComponent<Rigidbody>().linearVelocity = Vector3.forward * 10f;
    }
    public void LanzarGranada()
    {
        // Ocultar la granada en la mano
        granadaMano.SetActive(false);

        // Instanciar la granada lanzada
        GameObject granada = Instantiate(granadaPrefab, puntoLanzamiento.position, puntoLanzamiento.rotation);

        Rigidbody rb = granada.GetComponent<Rigidbody>();

        // Aplicar fuerza hacia adelante
        rb.linearVelocity = puntoLanzamiento.forward * fuerza;
    }
}
