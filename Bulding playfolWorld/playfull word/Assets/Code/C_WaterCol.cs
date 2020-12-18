using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;



public class C_WaterCol : MonoBehaviour
{
    public Material ma;
 
    public GameObject Canvas;
    public Camera WalkCam;
    public GameObject Walkobject;
    public GameObject AnimationCam;
    public float AniTime;

    Renderer rend;
    // Start is called before the first frame update
    void Start()
    {
       // ma.color = Color.white;
        rend = GetComponent<Renderer>();
        WalkCam.enabled = true;
        AnimationCam.SetActive(false);
    }

    private void OnTriggerEnter (Collider other)
    {
       // print("dfg");
          //Debug.Log("1g");
          if (other.gameObject.tag == "Boll")
          {

          // ma.color = Color.red;
            WalkCam.enabled =false;
            StartCoroutine(Loading());
            //print("jaaaaah");

          }
    }

    IEnumerator Loading()
    {
        AnimationCam.SetActive(true);


        yield return new WaitForSeconds(AniTime);

        SceneManager.LoadScene(0);
        //Canvas.SetActive(true);

        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }




}
