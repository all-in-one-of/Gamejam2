using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.SceneManagement;

public enum GameState
{
	Initialisation,
	InGame,
	InPause,
	AngelWin,
	EvilWin
}
public class GameManager : MonoBehaviour
{
	static private GameManager current;
	static public GameManager Current
	{
		get { return current; }
	}

	public static GameState GameState = GameState.Initialisation;
	public bool EvilUP;

	public GameObject WorldPivot;
	private Animator worldPivotAnimator;

	public GameObject P1;
	public GameObject P2;
	private PlayersManager P1Script;
	private PlayersManager P2Script;
	public GameObject P1Angel;
	public GameObject P1Evil;
	public GameObject P2Angel;
	public GameObject P2Evil;
	public List<GameObject> SlowEffects;

	private List<Material> WallP1Mats;
	private List<Material> WallP2Mats;
	private float TimerBeforeRemovingWalls;

	[Header("WinFinish")]
	public GameObject FinishAngel;

	[Header("UI")]
	public GameObject PauseMenu;
	public GameObject HUD;
	public GameObject WinScreens;
	public GameObject AngelWin;
	public GameObject EvilWin;
	public float WinScreenRestTime;

	void Start()
	{
		current = this;

		P1Script = P1.GetComponent<PlayersManager>();
		P2Script = P2.GetComponent<PlayersManager>();

		worldPivotAnimator = WorldPivot.GetComponent<Animator>();
	}

	void Update()
	{
		switch (GameState)
		{
			case GameState.Initialisation:
				{
					WinScreens.SetActive(false);
					AngelWin.SetActive(false);
					EvilWin.SetActive(false);
					PauseMenu.SetActive(false);
					HUD.SetActive(true);
					GameState = GameState.InGame;
				}
				break;
			case GameState.InGame:
				{

					if (P1.transform.position.x > P2.transform.position.x)
					{
						P1Script.Leader = true;
						P2Script.Leader = false;
					}
					else
					{
						P1Script.Leader = false;
						P2Script.Leader = true;
					}

					if (Input.GetKeyDown(KeyCode.Escape) || Input.GetKeyDown(KeyCode.JoystickButton7))
						GameState = GameState.InPause;
				}
				break;
			case GameState.InPause:
				{
					Time.timeScale = 0.0f;
					HUD.SetActive(false);
					PauseMenu.SetActive(true);
				}
				break;
			case GameState.AngelWin:
				{
					StartCoroutine(AngelWinCoroutine());

				}
				break;
			case GameState.EvilWin:
				{
					WinScreens.SetActive(true);
					EvilWin.SetActive(true);
					Time.timeScale = 0.0f;
				}
				break;
		}
	}

	public void ResumeGame()
	{
		GameState = GameState.InGame;
		Time.timeScale = 1.0f;
		HUD.SetActive(true);
		PauseMenu.SetActive(false);
	}

	public void ReturnMainMenu()
	{
		SceneManager.LoadScene(0);
	}

	IEnumerator AngelWinCoroutine()
	{
		Time.timeScale = 0.0f;
		FinishAngel.SetActive(true);
		yield return new WaitForSecondsRealtime(2.0f);
		WinScreens.SetActive(true);
		AngelWin.SetActive(true);
		yield return new WaitForSecondsRealtime(WinScreenRestTime);
		ReturnMainMenu();

	}

	public void WallPlacingActivate(int PlayerNum)
	{
		if (PlayerNum == 1)
		{
			if (EvilUP)
			{
				GameObject wall = ObjectPooler.Instance.GrabFromPool("WallForPN1", P1.transform.position + new Vector3(5.0f,1.0f, 0.0f), Quaternion.identity);
				WallsManager wallscript = wall.GetComponent<WallsManager>();
				wallscript.playernum = 2;
			}
			else
			{
				GameObject wall = ObjectPooler.Instance.GrabFromPool("WallForPN2", P2.transform.position + new Vector3(5.0f, -1.0f, 0.0f), Quaternion.identity);
				WallsManager wallscript = wall.GetComponent<WallsManager>();
				wallscript.playernum = 1;
			}

		}
		else
		{
			if (EvilUP)
			{
				GameObject wall = ObjectPooler.Instance.GrabFromPool("WallForPN1", P2.transform.position + new Vector3(5.0f, -1.0f, 0.0f), Quaternion.identity);
				WallsManager wallscript = wall.GetComponent<WallsManager>();
				wallscript.playernum = 1;
			}
			else
			{
				GameObject wall = ObjectPooler.Instance.GrabFromPool("WallForPN2", P1.transform.position + new Vector3(5.0f, 1.0f, 0.0f), Quaternion.identity);
				WallsManager wallscript = wall.GetComponent<WallsManager>();
				wallscript.playernum = 2;
			}
		}
	}

	public IEnumerator SlowPlayer(int PlayerNum)
	{
		if (PlayerNum == 1)
		{
			if (EvilUP)
				SlowEffects[3].SetActive(true);
			else
				SlowEffects[2].SetActive(true);
			float previousSpeed = P2Script.MoveSpeed;
			P2Script.MoveSpeed *= 0.5f;
			yield return new WaitForSeconds(4.0f);
			SlowEffects[2].SetActive(false);
			SlowEffects[3].SetActive(false);
			P2Script.MoveSpeed = previousSpeed;
		}
		else
		{
			if (EvilUP)
				SlowEffects[0].SetActive(true);
			else
				SlowEffects[1].SetActive(true);
			float previousSpeed = P1Script.MoveSpeed;
			P1Script.MoveSpeed *= 0.5f;
			yield return new WaitForSeconds(4.0f);
			SlowEffects[0].SetActive(false);
			SlowEffects[1].SetActive(false);
			P1Script.MoveSpeed = previousSpeed;
		}
	}

	public IEnumerator GoToEvilUp()
	{
		//Effect shield up
		float value = 0.0f;
		while (value <= 1.0f)
		{
			value += Mathf.Lerp(0.0f, 1.0f, 0.5f * Time.deltaTime);
			Shader.SetGlobalFloat("AppearValue", value);
			yield return null;
		}
		P1Angel.SetActive(false);
		P1Evil.SetActive(true);
		P2Angel.SetActive(true);
		P2Evil.SetActive(false);
		//Inverse XPos
		float xPosP1 = P1.transform.position.x;
		P1.transform.position = new Vector3(P2.transform.position.x, P1.transform.position.y, 0.0f);
		P2.transform.position = new Vector3(xPosP1, P2.transform.position.y, 0.0f);
		//Stop Move
		P1Script.CanMove = false;
		P2Script.CanMove = false;
		//Swap controll
		P1Script.PlayerNumber = 2;
		P2Script.PlayerNumber = 1;
		//Reverse world
		worldPivotAnimator.SetInteger("EvilUp", 1);
		worldPivotAnimator.SetInteger("EvilDown", 0);
		yield return new WaitForSeconds(1.0f);
		worldPivotAnimator.SetInteger("EvilUp", 0);
		//Effect shield Down
		value = 0.0f;
		while (value <= 1.0f)
		{
			value += Mathf.Lerp(0.0f, 1.0f, 0.5f * Time.deltaTime);
			Shader.SetGlobalFloat("AppearValue", 1.0f - value);
			yield return null;
		}
		//Enable Move
		P1Script.CanMove = true;
		P2Script.CanMove = true;
		yield return null;
		EvilUP = true;

		/*
		//LaunchAnim
		//	P1 angel->Evil + Dissolve + Effect
		//	P2 Evil-> Angel + Dissolve + Effect
		//Stop All player -> transform.position = transform.position
		//Rotate World 
		//Swap la position en X
		Inverse PlayerNum
			P1 -> 2
			P2 -> 1
		 */
	}

	public IEnumerator GoToEvilDown()
	{
		P1Angel.SetActive(true);
		P1Evil.SetActive(false);
		P2Angel.SetActive(false);
		P2Evil.SetActive(true);
		//Inverse XPos
		float xPosP1 = P1.transform.position.x;
		float xPosP2 = P2.transform.position.x;
		P1.transform.position = new Vector3(xPosP2, P1.transform.position.y, 0.0f);
		P2.transform.position = new Vector3(xPosP1, P2.transform.position.y, 0.0f);
		//Stop Move
		P1Script.CanMove = false;
		P2Script.CanMove = false;
		//Swap controll
		P1Script.PlayerNumber = 1;
		P2Script.PlayerNumber = 2;
		//Reverse world
		worldPivotAnimator.SetInteger("EvilDown", 1);
		worldPivotAnimator.SetInteger("EvilUp", 0);
		yield return new WaitForSeconds(1.0f);
		worldPivotAnimator.SetInteger("EvilDown", 0);
		//Enable Move
		P1Script.CanMove = true;
		P2Script.CanMove = true;
		yield return null;
		EvilUP = false;
		/*
		//LaunchAnim
		//	P1 Evil->Angel + Dissolve + Effect
		//	P2 Angel-> Evil + Dissolve + Effect
		//Stop All player -> transform.position = transform.position
		//Rotate World 
		//Swap la position en X
		//Inverse PlayerNum
		//	P1 -> 1
		//	P2 -> 2
		 */
	}
}