using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class PowerUpMove : MonoBehaviour
{
	[HideInInspector] public Vector3 Direction;
	[HideInInspector] public float DieAfter = 20.0f;

	void Start()
	{
		Destroy(gameObject,DieAfter);	
	}

	void Update()
	{
		transform.position += Direction * Time.deltaTime;;
	}
}