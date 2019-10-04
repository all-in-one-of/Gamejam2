using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class CameraController : MonoBehaviour
{
	public Vector3 Dir;

	public static bool CameraCanMove = true;

	private Transform lTransform;
	void Start()
	{
		lTransform = transform;
	}

	private void FixedUpdate()
	{
		if(CameraCanMove)
			lTransform.position += Dir * Time.deltaTime;
	}
}