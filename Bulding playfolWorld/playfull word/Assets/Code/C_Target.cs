using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Target : MonoBehaviour
{
    public Material ma;
    public float health = 10;
    public GameObject boll;

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
            // play animatie
            Animation();
        
        }
    }

    void Animation() 
    {
        ;
        ma.color = Color.yellow;
        ma.SetColor("_EmissionColor", Color.yellow);

        boll.SetActive(true);
        print("heey");
    }


}
