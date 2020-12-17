using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Shoot : MonoBehaviour
{
    public float damage = 1;
    public float renge = 1;
    public Camera fpscam;

    //zorgt er voor dat er een raycast geschoten word die damage geeft 
    // de damage is niet de beste maniet om dit te doen. fix dit waneer tijd over heb 
    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            Scoot();
        }

    }

    void Scoot() 
    {

        RaycastHit hit;
        if (Physics.Raycast(fpscam.transform.position, fpscam.transform.forward, out hit, renge))
        {
            C_Target target = hit.transform.GetComponent<C_Target>();
            
           // Debug.Log(hit.transform.name);
            if (target != null) 
            {
                target.TakeDamage(damage);
            
            }
        }
    }
}
