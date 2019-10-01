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

	public static GameState GameState = GameState.Initialisation;

	public GameObject P1;
	public GameObject P2;
	private PlayersManager P1Script;
	private PlayersManager P2Script;

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
		P1Script = P1.GetComponent<PlayersManager>();
		P2Script = P2.GetComponent<PlayersManager>();
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
}