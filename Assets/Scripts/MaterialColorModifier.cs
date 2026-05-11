using UnityEngine;

[System.Serializable]
public class MaterialColorModifier : MaterialModifier
{
    [SerializeField] private Gradient gradient;

    public override void Modify(Material material, float time)
    {
        material.SetColor(propertyId, gradient.Evaluate(time));
    }
}
