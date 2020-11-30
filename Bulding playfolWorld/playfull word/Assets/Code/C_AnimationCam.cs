using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class C_AnimationCam : MonoBehaviour
{
	public float speed;

	bool playAni = false;
	Vector3 StartPos;

	public Vector3 endpos;
	void Start()
	{
		endpos = new Vector3(16.0f, 4.0f, -19.0f);
		StartPos = gameObject.transform.position;
	}
	private void Update()
	{
		if (Input.GetKeyDown("d"))
		{
			StartPos = gameObject.transform.position;
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
