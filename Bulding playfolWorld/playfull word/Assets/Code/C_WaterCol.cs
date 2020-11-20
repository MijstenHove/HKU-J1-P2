using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_WaterCol : MonoBehaviour
{
    public Material ma;
    Renderer rend;

    // Start is called before the first frame update
    void Start()
    {
        rend = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {

    }

    void OnCollisionEnter(Collision collision)
    {
        Debug.Log("1g");
        if (collision.gameObject.name == "CubeA")
        {

            ma.color = Color.cyan;
            Debug.Log("2g");

        }

        if (collision.gameObject.name == "CubeB")
        {

            ma.color = Color.white;
            Debug.Log("2g");

        }
    }
}
