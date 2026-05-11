using UnityEngine;

[System.Serializable]

public class MaterialFloatModifier : MaterialModifier
{
    [SerializeField] private AnimationCurve curve;

    public override void Modify(Material material, float time)
    {
        material.SetFloat(propertyId, curve.Evaluate(time));
    }
}
