using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class PowerUPSpawner : MonoBehaviour
{
	public GameObject[] PowerUpPrefabs;
	public float MinTime;
	public float MaxTime;

	[Header("PowerUP value")]
	public Vector3 Direction;
	public float DieAfter;
	private float currentTime;

	void Start()
	{
		currentTime = Random.Range(MinTime,MaxTime);
	}

	void Update()
	{
		currentTime -= Time.deltaTime;
		if (currentTime <= 0.0f)
		{
			SpawnPowerUp();
			currentTime =  Random.Range(MinTime,MaxTime);
		}

	}

	int previousindex = 0;
	void SpawnPowerUp()
	{
		int randomIndex = 0;
		while (randomIndex == previousindex)
		{
			randomIndex = Random.Range(0, PowerUpPrefabs.Length);
		}
		GameObject temp = Instantiate(PowerUpPrefabs[randomIndex],transform.position, Quaternion.identity);
		temp.transform.parent = transform.parent;
		PowerUpMove tempscript = temp.GetComponent<PowerUpMove>();
		tempscript.Direction = Direction;
		tempscript.DieAfter = DieAfter;
		previousindex = randomIndex;
	}
}