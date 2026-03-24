using UnityEngine;

[ExecuteInEditMode]

public class VertexAnimationArea : MonoBehaviour
{
    [SerializeField] private Material targetMaterial;
    [SerializeField] private float radius;


    // Update is called once per frame
    void Update()
    {
        Vector3 pos = transform.position;
        Vector4 sphere = new Vector4(pos.x, pos.y, pos.z, radius);
        targetMaterial?.SetVector("_SphereDescriptor", sphere);
    }
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, radius);
    }
}
