using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class WallsManager : MonoBehaviour
{
	public bool OpenWall;

	private GameObject normalWall;
	private GameObject powerUpWall;
	public Material material;

	public float ActiveTime = 5.0f;
	private float activeTime;

	private Transform ltransform;
	private GameObject lGameObject;

	void Awake()
	{
		ltransform = transform;
		lGameObject = gameObject;

		normalWall = ltransform.GetChild(0).gameObject;
		powerUpWall = ltransform.GetChild(1).gameObject;
		material = powerUpWall.GetComponent<MeshRenderer>().material;

		activeTime = ActiveTime;
	}

	void Update()
	{
		if (OpenWall)
		{
			normalWall.SetActive(false);
			powerUpWall.SetActive(true);
			material.SetFloat("_BlastingRadius", 4);
			activeTime -= Time.deltaTime;
			if (activeTime <= 0.0f)
			{
				OpenWall = false;
				activeTime = ActiveTime;
			}

		}
	}

	void OnEnable()
	{
		StartCoroutine(DisableTime());
	}

	void OnDisable()
	{
		normalWall.SetActive(true);
		powerUpWall.SetActive(false);
		material.SetFloat("_BlastingRadius", 1);
	}

	IEnumerator DisableTime()
	{
		yield return new WaitForSeconds(5.0f);
		lGameObject.SetActive(false);
	}
}