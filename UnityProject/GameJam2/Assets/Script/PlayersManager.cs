﻿using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class PlayersManager : MonoBehaviour
{
	[Header("MainParameters")]
	public int PlayerNumber;
	public bool Leader;

	private string jumpKey;
	private string crouchKey;
	private string L1;
	private string R1;

	[Header("HUDRef")]
	public Image Slot1PowerUp;
	public Image Slot2PowerUp;
	public List<Sprite> PowerUpSprite;
	private int slot1Id;
	private int slot2Id;

	[Header("PowerUp")]
	public float PowerUpCD;
	private int currentPowerNumber;
	private float currentCD;

	[Header("Physics")]
	public bool isGrounded;
	public float JumpHeight;
	public float MoveSpeed;
	private float currentSpeed;
	private Rigidbody controller;
	public float gravityScale = 1.0f;

	private Transform lTransform;
	private GameObject lGameObject;

	void Start()
	{
		lGameObject = gameObject;
		lTransform = transform;

		//Inputs
		jumpKey = "joystick " + PlayerNumber + " button 0";
		crouchKey = "joystick " + PlayerNumber + " button 1";
		L1 = "joystick " + PlayerNumber + " button 4";
		R1 = "joystick " + PlayerNumber + " button 5";

		//Physics
		controller = GetComponent<Rigidbody>();
		//controller.useGravity = false;
	}

	void Update()
	{
		if ((Input.GetKeyDown(KeyCode.A) && PlayerNumber == 2) || (Input.GetKeyDown(KeyCode.Keypad1) && PlayerNumber == 1) || (Input.GetKeyDown(L1)))
		{
			Slot1PowerUp.sprite = null;
			switch (slot1Id)
			{
				case 1:
					{
						PowerUp1();
					}
					break;
				case 2:
					{
						PowerUp2();
					}
					break;
				case 3:
					{
						PowerUp3();
					}
					break;
			}
			slot1Id = 0;
		}
		if ((Input.GetKeyDown(KeyCode.E) && PlayerNumber == 2) || (Input.GetKeyDown(KeyCode.Keypad2) && PlayerNumber == 1) || (Input.GetKeyDown(R1)))
		{
			Slot2PowerUp.sprite = null;
			switch (slot2Id)
			{
				case 1:
					{
						PowerUp1();
					}
					break;
				case 2:
					{
						PowerUp2();
					}
					break;
				case 3:
					{
						PowerUp3();
					}
					break;
			}
			slot2Id = 0;
		}
	}

	void PowerUp1()
	{
		Debug.Log("DoPowerUp1");
	}

	void PowerUp2()
	{
		Debug.Log("DoPowerUp2");
	}

	void PowerUp3()
	{
		Debug.Log("DoPowerUp3");
	}

	void FixedUpdate()
	{
		Vector3 moveDirection = Vector3.zero;

		//Move-Left-Right
		float HorizontalAxis = Input.GetAxis("Horizontal" + PlayerNumber);
		Vector3 dir = new Vector3(HorizontalAxis, 0.0f, 0.0f);

		if (PlayerNumber == 1 ? Input.GetKey(KeyCode.LeftArrow) : Input.GetKey(KeyCode.Q))
			dir = new Vector3(-1f, 0.0f, 0.0f);

		if (PlayerNumber == 1 ? Input.GetKey(KeyCode.RightArrow) : Input.GetKey(KeyCode.D))
			dir = new Vector3(1f, 0.0f, 0.0f);

		moveDirection = dir;

		//Jump
		if ((Input.GetKeyDown(jumpKey) || PlayerNumber == 1 ? Input.GetKey(KeyCode.UpArrow) : Input.GetKey(KeyCode.Z)) && isGrounded)
		{
			isGrounded = false;
			if (PlayerNumber == 1)
				controller.AddForce(Vector3.up * JumpHeight, ForceMode.Impulse);
			else
				controller.AddForce(Vector3.down * JumpHeight, ForceMode.Impulse);
		}

		if (PlayerNumber == 2 && !isGrounded)
		{
			/*Vector3 gravity =  gravityScale * Vector3.up;
			moveDirection += gravity;*/
			controller.AddForce(-Physics.gravity, ForceMode.Acceleration);
		}
		//controller.AddForce(gravity, ForceMode.Acceleration);
		//if (!(controller.velocity.x > MoveSpeed || controller.velocity.x < -MoveSpeed))
		controller.MovePosition(lTransform.position + (moveDirection * MoveSpeed * Time.deltaTime));

	}

	void OnTriggerEnter(Collider col)
	{
		if (col.gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			isGrounded = true;
		}
		if (col.gameObject.layer == LayerMask.NameToLayer("DeadWall"))
		{
			if (PlayerNumber == 1)
				GameManager.GameState = GameState.EvilWin;
			else
				GameManager.GameState = GameState.AngelWin;
		}

		if (col.gameObject.layer == LayerMask.NameToLayer("Win"))
		{
			if (PlayerNumber == 1)
				GameManager.GameState = GameState.AngelWin;
			else
				GameManager.GameState = GameState.EvilWin;
		}

		if (col.CompareTag("PowerUp1"))
		{
			ShowPowerUpInUI(PowerUpSprite[0], col, 1);
			col.enabled = false;
		}

		if (col.CompareTag("PowerUp2"))
		{
			ShowPowerUpInUI(PowerUpSprite[1], col, 2);
			col.enabled = false;
		}

		if (col.CompareTag("PowerUp3") && !Leader)
		{
			ShowPowerUpInUI(PowerUpSprite[2], col, 3);
			col.enabled = false;
		}
	}

	void ShowPowerUpInUI(Sprite PowerUpToShow, Collider GoToDestroy, int PowerUpId)
	{
		GameObject go = GoToDestroy.gameObject;
		if (Slot1PowerUp.sprite == null)
		{
			Slot1PowerUp.sprite = PowerUpToShow;
			slot1Id = PowerUpId;
			Destroy(go);
			return;
		}
		else if (Slot2PowerUp.sprite == null)
		{
			Slot2PowerUp.sprite = PowerUpToShow;
			slot2Id = PowerUpId;
			Destroy(go);
			return;
		}
	}
}