using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class RestPosY : MonoBehaviour
{
	void Start()
	{
		transform.localPosition = new Vector3(transform.localPosition.x,0.0f,0.0f);
	}

}