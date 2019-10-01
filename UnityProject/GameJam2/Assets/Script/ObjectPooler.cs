using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class ObjectPooler : MonoBehaviour
{
	[System.Serializable]
	public class Pool
	{
		public string Tag;
		public GameObject Prefab;
		public int Size;
	}

	public static ObjectPooler Instance;
	private void Awake()
	{
		Instance = this;
	}

	public List<Pool> Pools;
	public Dictionary<string, Queue<GameObject>> PoolDictionary;

	void Start()
	{
		PoolDictionary = new Dictionary<string, Queue<GameObject>>();

		foreach (Pool pool in Pools)
		{
			Queue<GameObject> objectPool = new Queue<GameObject>();

			for (int i = 0; i < pool.Size; i++)
			{
				GameObject actor = Instantiate(pool.Prefab);
				actor.SetActive(false);
				objectPool.Enqueue(actor);
			}

			PoolDictionary.Add(pool.Tag, objectPool);
		}
	}

	public GameObject GrabFromPool(string tag, Vector3 position, Quaternion rotation)
	{
		if(!PoolDictionary.ContainsKey(tag))
			return null;
		
		GameObject actorToSpawn = PoolDictionary[tag].Dequeue();
		actorToSpawn.SetActive(false);
		actorToSpawn.transform.position = position;
		actorToSpawn.transform.rotation = rotation;
		actorToSpawn.SetActive(true);
		PoolDictionary[tag].Enqueue(actorToSpawn);
		return actorToSpawn;
	}
}