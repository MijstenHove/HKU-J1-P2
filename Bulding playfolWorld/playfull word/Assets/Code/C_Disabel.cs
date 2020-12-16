using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_Disabel : MonoBehaviour
{
    public GameObject player;


    void OnEnable() 
    {
        player.SetActive(false);
        Cursor.lockState = CursorLockMode.None;
    }
}
