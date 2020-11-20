using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Shoot : MonoBehaviour
{
    public float damage = 1;
    public float renge = 1;
    public Camera fpscam;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
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
            Debug.Log(hit.transform.name);
            if (target != null) 
            {
                target.TakeDamage(damage);
            
            }
        }
    }
}
