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
	public bool Angel;
	public bool Obstacle;

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
			if (Obstacle)
			{
				Vector3 ee;
				ee = RandomPosition[i];
				ee.y = 0.0f;
				RandomPosition[i] = ee;
			}
			while (randomIndex == previousindex)
			{
				randomIndex = Random.Range(0, Prefabs.Length);
			}
			Vector3 OffsetPos = Vector3.zero;
			if (Angel)
				OffsetPos = Vector3.up * .25f;
			else if (!Angel)
				OffsetPos = Vector3.zero;
			GameObject temp = Instantiate(Prefabs[randomIndex], RandomPosition[i] + OffsetPos, Quaternion.identity);
			if (Obstacle && Prefabs[randomIndex] == Prefabs[1])
			{
				temp.transform.position = new Vector3(temp.transform.position.x, -.5f, 0.0f);
			}
			if (Angel && Prefabs[randomIndex] == Prefabs[1])
			{
				if (parent.gameObject.name == "AngelDown")
					temp.transform.rotation = Quaternion.Euler(0.0f, 90.0f, 0.0f);
				else
					temp.transform.rotation = Quaternion.Euler(0.0f, -90.0f, 0.0f);
			}
			else if (Prefabs[randomIndex] == Prefabs[0])
			{
				//Rotate de Maniere random 0/90/180
				int rng;
				rng = Random.Range(0, 3);
				switch (rng)
				{
					case 0:
						{
							temp.transform.localRotation = Quaternion.Euler(0.0f, 0.0f, 0.0f);
						}
						break;
					case 1:
						{
							temp.transform.localRotation = Quaternion.Euler(0.0f, -90.0f, 0.0f);
						}
						break;
					case 2:
						{
							temp.transform.localRotation = Quaternion.Euler(0.0f, 90.0f, 0.0f);
						}
						break;
				}
			}
			temp.transform.parent = parent;
			temp.transform.localScale = ScaleVector;
			previousindex = randomIndex;
		}
	}

}