using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class C_MainMenu : MonoBehaviour
{
    //menu 
   public void StartGame() 
    {
        SceneManager.LoadScene(1);
    }

   public void StopGame()
    {
        Application.Quit();
        Debug.Log("quit");

    }
}
