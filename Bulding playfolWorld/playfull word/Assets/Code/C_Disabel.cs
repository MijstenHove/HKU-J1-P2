using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Disabel : MonoBehaviour
{
    public GameObject player;

    // zorgt er voor dat mijn ui het doet na de cutscene
    void Update()
    {
        if (Input.GetKey(KeyCode.Space))
            Cursor.lockState = CursorLockMode.None;
    }
    void OnEnable() 
    {
        player.SetActive(false);
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
    }
   
}
