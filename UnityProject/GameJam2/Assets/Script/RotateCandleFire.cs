using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class RotateCandleFire : MonoBehaviour
{
	private void Update()
	{
		transform.localRotation = Quaternion.Euler(90.0f, .0f, .0f);

	}
}