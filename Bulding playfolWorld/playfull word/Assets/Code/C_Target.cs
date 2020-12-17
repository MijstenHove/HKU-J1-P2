using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Target : MonoBehaviour
{
    public Material ma;
    public GameObject LightOn;
    public float health = 10;
    public GameObject boll;

    // kijkt of heath lager dan nul is zo ja speelt hij de animatie
	private void Start()
	{
        boll.SetActive(false);
        ma.color = Color.black;
        ma.SetColor("_EmissionColor", Color.black);
    }
	public void TakeDamage (float amoundDam)
    {
        health -= amoundDam;
        if (health <= 0f) 
        {
            Animation();
        }
    }

    void Animation() 
    {  
        ma.color = Color.yellow;
        ma.SetColor("_EmissionColor", Color.yellow);
        LightOn.SetActive(true);
        boll.SetActive(true);
    }


}
