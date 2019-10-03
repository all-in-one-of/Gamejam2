using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class SpawnDeco : MonoBehaviour
{
	public GameObject[] Prefabs;
	public float MaxSpawnPoint;
	public float MinSpawnPoint;
	public Transform parent;
	public Vector3 ScaleVector;

	public bool InverseRotationForCandle;

	public int NumberSpawn;

	int previousindex = 0;
	int randomIndex = 0;
	public List<Vector3> RandomPosition;
	void Start()
	{
		Vector3 lastposition = transform.position;
		for (int i = 0; i < NumberSpawn; i++)
		{
			Vector3 temp = new Vector3(lastposition.x + Random.Range(MinSpawnPoint, MaxSpawnPoint), lastposition.y, lastposition.z);
			RandomPosition.Add(temp);
			lastposition = temp;
		}

		for (int i = 0; i < RandomPosition.Count; i++)
		{
			while (randomIndex == previousindex)
			{
				randomIndex = Random.Range(0, Prefabs.Length);
			}
			GameObject temp = Instantiate(Prefabs[randomIndex], RandomPosition[i], Quaternion.identity);
			temp.transform.parent = parent;
			temp.transform.localScale = ScaleVector;
			previousindex = randomIndex;
		}
	}

}