using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine;

//[ExecuteInEditMode]
[AddComponentMenu("Image Effects/Color Adjustments/Brightness")]
public class BrighntessValue : MonoBehaviour 
{
    public Shader shader;

    private Material mat;

    public MenuManager menuManager;

    void Start () 
    {
		if(!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

        if(!shader || !shader.isSupported)
        {
            enabled = false;
        }  
    }

    Material material
    {
        get
        {
            if(mat == null)
            {
                mat = new Material(shader);
                mat.hideFlags = HideFlags.HideAndDontSave;
            }
            
            return mat;
        }
    }

    private void OnDisable()
    {
        if(mat)
        {
            DestroyImmediate(mat);
        }
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        material.SetFloat("_Brightness", menuManager.brightnessValueSlider.value);
        material.SetFloat("_Gamma", 1f / menuManager.gammaValueSlider.value);
        Graphics.Blit(source, destination, mat);
    }
}
