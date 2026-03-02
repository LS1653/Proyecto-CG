using UnityEngine;
[ExecuteInEditMode]
public class VertexAnimationArena : MonoBehaviour
{
    [SerializeField] private float radius;
    [SerializeField] private Material targetMaterial;
    private void Update()
    {
       Vector3 pos = transform.position;
       Vector4 sphere = new Vector4(pos.x, pos.y, pos.z, radius);
       targetMaterial?.SetVector(name: "_SphereDescriptor", sphere);
    }

    void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, radius);
    }
}
