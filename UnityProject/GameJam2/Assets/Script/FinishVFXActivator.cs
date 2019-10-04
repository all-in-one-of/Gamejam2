using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FinishVFXActivator : MonoBehaviour
{
	public GameObject VFXToActivate;
	private void OnTriggerEnter(Collider col)
	{
		if(col.gameObject.layer == LayerMask.NameToLayer("Players"))
		{
			VFXToActivate.SetActive(true);
		}
	}
}
