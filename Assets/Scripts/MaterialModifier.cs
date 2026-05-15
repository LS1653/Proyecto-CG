using UnityEngine;

public abstract class MaterialModifier
{
    public string property;
    protected int propertyId;

    public virtual void Setup()
    {
        propertyId = Shader.PropertyToID(property);
    }

    public abstract void Modify(Material material, float time);
}
