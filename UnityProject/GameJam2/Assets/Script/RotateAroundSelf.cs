using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class RotateAroundSelf : MonoBehaviour
{
	public Vector3 Axis;
	public float Angle;

	void Update()
	{
		transform.RotateAround(transform.position, Axis, Angle * Time.deltaTime);
	}
}