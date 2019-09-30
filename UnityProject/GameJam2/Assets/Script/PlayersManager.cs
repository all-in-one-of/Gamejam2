using System.Collections;
using System.Collections.Generic;

using UnityEngine;

public class PlayersManager : MonoBehaviour
{
	[Header("MainParameters")]
	public int PlayerNumber;

	private string jumpKey;
	private string crouchKey;

	[Header("PowerUp")]
	public float PowerUpCD;

	[Header("Physics")]
	public bool isGrounded;
	public float JumpHeight;
	public float MoveSpeed;
	private float currentSpeed;
	private Rigidbody controller;
	public float gravityScale = 1.0f;
	public float globalGravity = -9.81f;

	private Transform lTransform;
	private GameObject lGameObject;
	void Start()
	{
		lGameObject = gameObject;
		lTransform = transform;

		//Inputs
		jumpKey = "joystick " + PlayerNumber + " button 0";
		crouchKey = "joystick " + PlayerNumber + " button 1";

		//Physics
		controller = GetComponent<Rigidbody>();
		controller.useGravity = false;
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

		Vector3 gravity = globalGravity * gravityScale * Vector3.up;
		controller.AddForce(gravity, ForceMode.Acceleration);
		if (!(controller.velocity.x > MoveSpeed || controller.velocity.x < -MoveSpeed))
			controller.AddForce(moveDirection * MoveSpeed, ForceMode.Acceleration);

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

	}
}