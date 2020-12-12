using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_WaterCol : MonoBehaviour
{
    public Material ma;
    Renderer rend;

    public GameObject WalkCam;
    public GameObject AnimationCam;
    // Start is called before the first frame update
    void Start()
    {
        ma.color = Color.white;
        rend = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {

    }

    private void OnTriggerExit(Collider other)
    {
        print("dfg");
          Debug.Log("1g");
          if (other.gameObject.tag == "Boll")
          {

           ma.color = Color.red;
            WalkCam.SetActive(false);
            AnimationCam.SetActive(true);
            print("jaaaaah");

          }
    }




}
