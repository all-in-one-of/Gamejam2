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

	void Update()
	{
		lTransform.position += Dir * Time.deltaTime;
	}
}