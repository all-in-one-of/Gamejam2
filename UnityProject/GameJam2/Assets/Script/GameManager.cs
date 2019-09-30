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

	[Header("UI")]
	public GameObject PauseMenu;
	public GameObject HUD;
	public GameObject WinScreens;
	public GameObject AngelWin;
	public GameObject EvilWin;
	public float WinScreenRestTime;

	void Start()
	{

	}

	void Update()
	{
		Debug.Log(GameState);
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
					WinScreens.SetActive(true);
					AngelWin.SetActive(true);
					Time.timeScale = 0.0f;
					WinRestTime();
				}
				break;
			case GameState.EvilWin:
				{
					WinScreens.SetActive(true);
					EvilWin.SetActive(true);
					Time.timeScale = 0.0f;
					WinRestTime();
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

	void WinRestTime()
	{
		WinScreenRestTime -= Time.unscaledDeltaTime;
		if (WinScreenRestTime < 0.0f)
			ReturnMainMenu();
	}
}