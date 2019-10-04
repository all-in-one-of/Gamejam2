using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class RotParent : MonoBehaviour
{
	void Start()
	{
		if (transform.parent.gameObject.name == "AngelUp")
		{
			transform.localRotation = Quaternion.Euler(0.0f,180.0f,0.0f);
		}	
		else
		{
			transform.localRotation = Quaternion.Euler(0.0f,0.0f,0.0f);
		}
	}

}