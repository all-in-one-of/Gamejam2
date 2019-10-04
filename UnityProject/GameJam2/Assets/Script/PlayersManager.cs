﻿using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.UI;

public class PlayersManager : MonoBehaviour
{
	[Header("MainParameters")]
	public int PlayerNumber;
	public string PositionToSend;
	public bool Leader;
	public bool CanMove;
	public LayerMask WallLayer;
	private int WallLvalue;

	private string jumpKey;
	private string crouchKey;
	private string L1;
	private string R1;
	private string O;

	[Header("HUDRef")]
	public Image Slot1PowerUp;
	public Image Slot1PowerUpHorn;
	public Image Slot2PowerUp;
	public Image Slot2PowerUpHorn;
	public Image PUS1;
	public Image PUS2;
	public List<Sprite> PowerUpSprite;
	public Image PowerUp4UI;
	private int slot1Id;
	private int slot2Id;

	[Header("PowerUp")]
	private int currentPowerNumber;
	private float currentCD;
	public static float TimeBetweenFlip = 10f;
	private float currentTimeBetweenFlip;
	[Header("Physics")]
	public bool isGrounded;
	public float JumpHeight;
	public float MoveSpeed;
	private float currentSpeed;
	[HideInInspector] public Rigidbody controller;
	public float gravityScale = 1.0f;

	private Transform lTransform;
	private GameObject lGameObject;

	private Animator currentAnimator;
	public GameObject ChildAngel;
	public GameObject ChildEvil;

	public GameObject PowerUpTakeSoundAngel;
	public GameObject PowerUpTakeSoundEvil;
	public GameObject PowerUpUseSoundAngel;
	public GameObject PowerUpUseSoundEvil;

	void TakePowerSound()
	{
		if (ChildEvil.activeSelf)
			Instantiate(PowerUpTakeSoundEvil, transform.position, Quaternion.identity);
		else
			Instantiate(PowerUpTakeSoundAngel, transform.position, Quaternion.identity);
	}

	void UsePowerSound()
	{
		Debug.Log("Yo");
		if (ChildEvil.activeSelf)
			Instantiate(PowerUpUseSoundEvil, transform.position, Quaternion.identity);
		else
			Instantiate(PowerUpUseSoundAngel, transform.position, Quaternion.identity);
	}

	void Start()
	{

		lGameObject = gameObject;
		lTransform = transform;

		WallLvalue = WallLayer.value;

		//Inputs
		crouchKey = "joystick " + PlayerNumber + " button 1";

		//Physics
		controller = GetComponent<Rigidbody>();
		//controller.useGravity = false;

		currentTimeBetweenFlip = TimeBetweenFlip;

		PUS1.color = new Color(1.0f, 1.0f, 1.0f, 0f);
		PUS2.color = new Color(1.0f, 1.0f, 1.0f, 0f);

		if (ChildAngel.activeSelf)
			currentAnimator = ChildAngel.GetComponent<Animator>();
		else if (ChildEvil.activeSelf)
			currentAnimator = ChildEvil.GetComponent<Animator>();

	}
	bool CanJump;
	void Update()
	{
		AnimatorChange(0, 1, 0, 0, 0);
		/*if (CanMove)
		{
			//Movement
			Vector3 moveDirection = Vector3.zero;
			//Run
			if ((Input.GetKey(KeyCode.LeftArrow) && PlayerNumber == 1) || (Input.GetKey(KeyCode.Q) && PlayerNumber == 2))
			{
				if (isGrounded)
					AnimatorChange(1, 0, 0, 0, 0);
				moveDirection.x -= (MoveSpeed);
				lTransform.rotation = Quaternion.Euler(0.0f, 180.0f, 0.0f);
			}

			if ((Input.GetKey(KeyCode.RightArrow) && PlayerNumber == 1) || (Input.GetKey(KeyCode.D) && PlayerNumber == 2))
			{
				if (isGrounded)
					AnimatorChange(1, 0, 0, 0, 0);
				moveDirection.x += MoveSpeed;
				lTransform.rotation = Quaternion.Euler(0.0f, 0.0f, 0.0f);
			}

			 //Jump
			if ((Input.GetKeyDown(KeyCode.UpArrow) && isGrounded && PositionToSend == "P1"))
			{
				AnimatorChange(0, 0, 0, 0, 1);
				if (moveDirection.x != 0)
					controller.AddForce(0.0f, JumpHeight * 1.5f, 0.0f, ForceMode.Impulse);
				else
					controller.AddForce(0.0f, JumpHeight, 0.0f, ForceMode.Impulse);
				isGrounded = false;
			}

			if ((Input.GetKeyDown(KeyCode.Z) && isGrounded && PositionToSend == "P2"))
			{
				AnimatorChange(0, 0, 0, 0, 1);
				if (moveDirection.x != 0)
					controller.AddForce(0.0f, -JumpHeight * 1.5f, 0.0f, ForceMode.Impulse);
				else
					controller.AddForce(0.0f, -JumpHeight, 0.0f, ForceMode.Impulse);
				isGrounded = false;
			}

			if (PositionToSend == "P2")
			{
				controller.AddForce(-Physics.gravity, ForceMode.Acceleration);
			}
			if (PositionToSend == "P1")
			{
				controller.AddForce(Physics.gravity, ForceMode.Acceleration);
			}

			//controller.MovePosition(lTransform.position + moveDirection * Time.deltaTime);
			lTransform.position = Vector3.Lerp(lTransform.position, lTransform.position + moveDirection, Time.deltaTime);

		}*/

		if (moveDirection != Vector3.zero)
			AnimatorChange(1, 0, 0, 0, 0);
		else
			AnimatorChange(0, 1, 0, 0, 0);

		if (!isGrounded)
			AnimatorChange(0, 0, 0, 0, 1);

		currentTimeBetweenFlip -= Time.deltaTime;
		currentTimeBetweenFlip = Mathf.Max(currentTimeBetweenFlip, 0.0f);
		PowerUp4UI.fillAmount = 1 - currentTimeBetweenFlip / TimeBetweenFlip;
		if (Leader)
			PowerUp4UI.enabled = false;
		else
			PowerUp4UI.enabled = true;

		if (ChildAngel.activeSelf)
			currentAnimator = ChildAngel.GetComponent<Animator>();
		else if (ChildEvil.activeSelf)
			currentAnimator = ChildEvil.GetComponent<Animator>();

		if ((Input.GetKeyUp(KeyCode.J) && currentTimeBetweenFlip == 0.0f && !Leader))
		{
			currentTimeBetweenFlip = TimeBetweenFlip;
			PowerUp4();
		}

		Shader.SetGlobalVector(PositionToSend, lTransform.position);

		if ((Input.GetKeyDown(KeyCode.A) && PlayerNumber == 2) || (Input.GetKeyDown(KeyCode.L) && PlayerNumber == 1) || (Input.GetKeyDown("joystick " + PlayerNumber + " button 4")))
		{
			if (moveDirection != Vector3.zero)
				AnimatorChange(0, 0, 1, 0, 0);
			else
				AnimatorChange(0, 0, 0, 1, 0);
			PUS1.sprite = null;
			PUS1.color = new Color(1.0f, 1.0f, 1.0f, 0.0f);
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
				case 4:
					{
						PowerUp4();
					}
					break;
			}
			slot1Id = 0;
		}
		if ((Input.GetKeyDown(KeyCode.E) && PlayerNumber == 2) || (Input.GetKeyDown(KeyCode.M) && PlayerNumber == 1) || (Input.GetKeyDown("joystick " + PlayerNumber + " button 5")))
		{
			if (moveDirection != Vector3.zero)
				AnimatorChange(0, 0, 1, 0, 0);
			else
				AnimatorChange(0, 0, 0, 1, 0);
			PUS2.sprite = null;
			PUS2.color = new Color(1.0f, 1.0f, 1.0f, 0.0f);
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
				case 4:
					{
						PowerUp4();
					}
					break;
			}
			slot2Id = 0;
		}
	}

	//WallPlacing
	void PowerUp1()
	{
		UsePowerSound();
		GameManager.Current.WallPlacingActivate(PlayerNumber);
	}

	public List<GameObject> AllWall = new List<GameObject>();
	//WallThrough
	void PowerUp2()
	{
		UsePowerSound();
		RaycastHit[] hits;
		hits = Physics.RaycastAll(transform.position, transform.right, 20, WallLvalue);

		for (int i = 0; i < hits.Length; i++)
		{
			AllWall.Add(hits[i].transform.gameObject.transform.parent.gameObject);
		}

		for (int i = 0; i < AllWall.Count; i++)
		{
			WallsManager wallscript = AllWall[i].GetComponent<WallsManager>();
			wallscript.OpenWall = true;
			if (PositionToSend == "P1")
				wallscript.material.SetInt("_Player1", 1);
			else
				wallscript.material.SetInt("_Player1", 0);
		}
		StartCoroutine(ClearList());
	}
	IEnumerator ClearList()
	{
		yield return new WaitForSeconds(3.0f);
		AllWall.Clear();
	}

	//Slow 
	void PowerUp3()
	{
		UsePowerSound();
		StartCoroutine(GameManager.Current.SlowPlayer(PositionToSend));
	}

	//inverseWorld
	void PowerUp4()
	{
		UsePowerSound();
		if (GameManager.Current.EvilUP)
		{
			StartCoroutine(GameManager.Current.GoToEvilDown());
		}
		else
		{
			StartCoroutine(GameManager.Current.GoToEvilUp());
		}
	}

	Vector3 moveDirection = Vector3.zero;
	Vector3 dir;
	void FixedUpdate()
	{
		if (CanMove)
		{

			float HorizontalAxis = Input.GetAxis("Horizontal" + PlayerNumber);
			moveDirection = Vector3.zero;

			HorizontalAxis = Input.GetAxisRaw("Horizontal" + PlayerNumber);
			dir = Vector3.right * HorizontalAxis;

			//Move-Left-Right
			if (HorizontalAxis > 0.0f)
				transform.rotation = Quaternion.Euler(0.0f, 0.0f, 0.0f);
			else
			if (HorizontalAxis < 0.0f)
				transform.rotation = Quaternion.Euler(0.0f, 180.0f, 0.0f);

			if (PlayerNumber == 1 ? Input.GetKey(KeyCode.LeftArrow) : Input.GetKey(KeyCode.Q))
				dir = new Vector3(-1f, 0.0f, 0.0f);

			if (PlayerNumber == 1 ? Input.GetKey(KeyCode.RightArrow) : Input.GetKey(KeyCode.D))
				dir = new Vector3(1f, 0.0f, 0.0f);

			moveDirection = dir;

			if ((Input.GetKeyDown(KeyCode.UpArrow) && PlayerNumber == 1) || (Input.GetKeyDown(KeyCode.Z) && PlayerNumber == 2))
			{
				//CanJump = false;
				isGrounded = false;
				if (PositionToSend == "P1")
				{
					controller.AddForce(Vector3.up * JumpHeight, ForceMode.Impulse);
				}
				else
				{
					controller.AddForce(Vector3.down * JumpHeight, ForceMode.Impulse);
				}
				/*if (PlayerNumber == 1)
				{
					if (GameManager.Current.EvilUP)
						controller.AddForce(Vector3.down * JumpHeight, ForceMode.Impulse);
					else
						controller.AddForce(Vector3.up * JumpHeight, ForceMode.Impulse);
				}
				else
				{
					if (GameManager.Current.EvilUP)
						controller.AddForce(Vector3.up * JumpHeight, ForceMode.Impulse);
					else
						controller.AddForce(Vector3.down * JumpHeight, ForceMode.Impulse);
				}*/
			}

			//controller.AddForce(gravity, ForceMode.Acceleration);
			//if (!(controller.velocity.x > MoveSpeed || controller.velocity.x < -MoveSpeed))

			if (PositionToSend == "P2")
			{
				controller.AddForce(-Physics.gravity * 20, ForceMode.Acceleration);
			}
			if (PositionToSend == "P1")
			{
				controller.AddForce(Physics.gravity * 20, ForceMode.Acceleration);
			}

			controller.MovePosition(lTransform.position + (moveDirection * MoveSpeed * Time.deltaTime));

			/* if(HorizontalAxis != 0)
			{

			}
			else
			{
				controller.velocity = Vector3.zero;
			}*/

		}
	}

	void AnimatorChange(int Run, int Idle, int CanPowerUpRun, int CanPowerUpIdle, int CanJump)
	{
		currentAnimator.SetInteger("CanRun", Run);
		currentAnimator.SetInteger("CanIdle", Idle);
		currentAnimator.SetInteger("CanPowerUpRun", CanPowerUpRun);
		currentAnimator.SetInteger("CanPowerUpIdle", CanPowerUpIdle);
		currentAnimator.SetInteger("CanJump", CanJump);
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
			TakePowerSound();
			ShowPowerUpInUI(PowerUpSprite[0], col, 1);
		}

		if (col.CompareTag("PowerUp2"))
		{
			TakePowerSound();
			ShowPowerUpInUI(PowerUpSprite[1], col, 2);
		}

		if (col.CompareTag("PowerUp3") && !Leader)
		{
			TakePowerSound();
			ShowPowerUpInUI(PowerUpSprite[2], col, 3);
		}

		if (col.CompareTag("PowerUp4"))
		{
			TakePowerSound();
			ShowPowerUpInUI(PowerUpSprite[3], col, 4);
		}
	}

	void OnTriggerExit(Collider col)
	{
		if (col.gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			isGrounded = false;
		}
	}

	void ShowPowerUpInUI(Sprite PowerUpToShow, Collider GoToDestroy, int PowerUpId)
	{
		GameObject go = GoToDestroy.gameObject;
		if (PUS1.sprite == null)
		{
			GoToDestroy.enabled = false;
			PUS1.sprite = PowerUpToShow;
			slot1Id = PowerUpId;
			PUS1.color = new Color(1.0f, 1.0f, 1.0f, 1f);
			Destroy(go);
			return;
		}
		else if (PUS2.sprite == null)
		{
			GoToDestroy.enabled = false;
			PUS2.sprite = PowerUpToShow;
			slot2Id = PowerUpId;
			PUS2.color = new Color(1.0f, 1.0f, 1.0f, 1f);
			Destroy(go);
			return;
		}
	}
}