using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_AnimationCam : MonoBehaviour
{
	public float speed;

	bool playAni = false;
	Vector3 StartPos;
	Vector3 StartRotation;

	public Vector3 endpos;
	public Vector3 endRotation;

	void Start()
	{
		endpos = new Vector3(-9.0f, 13.0f, -23.0f);
		endRotation = new Vector3(24.0f, 29.0f, 0.0f);
		StartPos = gameObject.transform.position;
		StartRotation = gameObject.transform.eulerAngles;
		//eulerAngles is de rotation van de transform 
	}
	private void Update()
	{
		if (Input.GetKeyDown("d"))
		{
			StartPos = gameObject.transform.position;
			//StartRotation = gameObject.transform.eulerAngles;
			playAni = true;

		}
		if (playAni == true)
		{
			if (speed < 1)
			{
				speed = speed + Time.deltaTime;
			}
			else
			{
				playAni = false;
			}

		}
		gameObject.transform.position = Vector3.Lerp(StartPos, endpos, speed);

	}

}
