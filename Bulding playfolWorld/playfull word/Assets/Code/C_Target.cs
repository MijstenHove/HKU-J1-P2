using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Target : MonoBehaviour
{
    public Material ma;
    public float health = 10;


	private void Start()
	{
        ma.color = Color.white;
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
        ma.color = Color.blue;

    }


}
