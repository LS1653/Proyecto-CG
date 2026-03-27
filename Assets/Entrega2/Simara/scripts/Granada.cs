using UnityEngine;

public class Granada : MonoBehaviour
{
    public int rebotesMaximos = 2;
    private int rebotesActuales = 0;

    public GameObject efectoExplosion;

    private void OnCollisionEnter(Collision collision)
    {
        if (rebotesActuales < rebotesMaximos)
        {
            rebotesActuales++;
        }
        else
        {
            Explotar();
        }
    }

    void Explotar()
    {
        Instantiate(efectoExplosion, transform.position, Quaternion.identity);
        Destroy(gameObject);
    }
}
