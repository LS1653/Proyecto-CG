using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class VFXDemoUI : MonoBehaviour
{
    [System.Serializable]
    public class VFXEntry
    {
        public string vfxName;
        public PlayableDirector director;
        public GameObject rootObject;
    }

    [Header("VFX List")]
    public List<VFXEntry> vfxList = new List<VFXEntry>();

    [Header("UI")]
    public TMP_Dropdown dropdown;

    private PlayableDirector currentDirector;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        PopulateDropdown();

        if (vfxList.Count > 0)
        {
            SelectVFX(0);
        }

        dropdown.onValueChanged.AddListener(SelectVFX);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void PopulateDropdown()
    {
        dropdown.ClearOptions();

        List<string> options = new List<string>();

        foreach (var vfx in vfxList)
        {
            options.Add(vfx.vfxName);
        }

        dropdown.AddOptions(options);
    }

    public void SelectVFX(int index)
    {
        // Detener el efecto anterior
        if (currentDirector != null)
        {
            currentDirector.Stop();

            foreach (var vfx in vfxList)
            {
                if (vfx.director == currentDirector)
                {
                    vfx.rootObject.SetActive(false);
                    break;
                }
            }
        }

        var selectedVFX = vfxList[index];
        selectedVFX.rootObject.SetActive(true);
        currentDirector = selectedVFX.director;

        // Reiniciar tiempo
        currentDirector.time = 0;
        currentDirector.Evaluate();
    }

    public void PlayCurrent()
    {
        if (currentDirector != null)
        {
            currentDirector.Play();
        }
    }

    public void PauseCurrent()
    {
        if (currentDirector != null)
        {
            currentDirector.Pause();
        }
    }

    public void StopCurrent()
    {
        if (currentDirector != null)
        {
            currentDirector.Stop();
            currentDirector.time = 0;
            currentDirector.Evaluate();
        }
    }
}
