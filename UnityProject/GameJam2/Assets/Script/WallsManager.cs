using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class WallsManager : MonoBehaviour
{
	public static bool P1PowerUpActive;
	public static bool P2PowerUpActive;
	public int playernum;

	private GameObject normalWall;
	private GameObject powerUpWall;
	private Material material;

	private Transform ltransform;
	private GameObject lGameObject;

	void Awake()
	{
		ltransform = transform;
		lGameObject = gameObject;

		normalWall = ltransform.GetChild(0).gameObject;
		powerUpWall = ltransform.GetChild(1).gameObject;
		material = powerUpWall.GetComponent<MeshRenderer>().material;
	}

	void Update()
	{
		if ((P1PowerUpActive && playernum == 1) || (P2PowerUpActive && playernum == 2))
		{
			normalWall.SetActive(false);
			powerUpWall.SetActive(true);
			material.SetFloat("_BlastingRadius", 4);
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