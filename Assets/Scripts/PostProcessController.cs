using UnityEngine;

[ExecuteInEditMode]
[RequireComponent (typeof(ParticleSystem))]

public class PostProcessController : MonoBehaviour
{
    [SerializeField] private Material mat;

    private ParticleSystem particles;

    [SerializeField] private MaterialFloatModifier[] floats;
    [SerializeField] private MaterialColorModifier[] colors;

    private void Awake()
    {
        particles = GetComponent<ParticleSystem>();

        foreach (MaterialFloatModifier modifier in floats)
        {
            modifier.Setup();
        }

        foreach (MaterialColorModifier modifier in colors)
        {
            modifier.Setup();
        }
    }

    void Update()
    {
        if (particles.isPlaying)
        {
            //Modificar el material

            foreach (MaterialFloatModifier modifier in floats)
            {
                modifier.Modify(mat, time:particles.time / particles.main.duration);
            }

            foreach (MaterialColorModifier modifier in colors)
            {
                modifier.Modify(mat, time: particles.time / particles.main.duration);
            }
        }
    }
}
