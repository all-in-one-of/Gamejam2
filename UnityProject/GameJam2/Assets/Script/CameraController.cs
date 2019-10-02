using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class CameraController : MonoBehaviour
{
	public Vector3 Dir;

	private Transform lTransform;
	void Start()
	{
		lTransform = transform;
	}

	private void FixedUpdate()
	{
		lTransform.position += Dir * Time.deltaTime;
	}
}