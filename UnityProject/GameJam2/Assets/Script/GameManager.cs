using System.Collections;
using System.Collections.Generic;

using Aura2API;

using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public enum GameState
{
	Initialisation,
	InGame,
	InPause,
	AngelWin,
	EvilWin,
	RetrunToMain
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
	public GameObject EvilLight;
	public GameObject EvilUpDeco;
	public GameObject EvilDownDeco;
	public GameObject AngelLight;
	public GameObject AngelUpDeco;
	public GameObject AngelDownDeco;

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

	[Header("UI")]
	public GameObject PauseMenu;
	public GameObject HUD;
	public GameObject WinScreens;
	public Sprite AngelWin;
	public Sprite EvilWin;
	public float WinScreenRestTime;

	public Sprite AngelRings;
	public Sprite EvilRings;
	public Sprite AngelWings;
	public Sprite EvilWings;

	public Image[] ReverseVisualU;
	public Image[] ReverseVisualD;

	public GameObject[] MainMusic;

	void Start()
	{
		current = this;

		P1Script = P1.GetComponent<PlayersManager>();
		P2Script = P2.GetComponent<PlayersManager>();

		worldPivotAnimator = WorldPivot.GetComponent<Animator>();

		Shader.SetGlobalFloat("AppearValue", 0);
		GameState = GameState.Initialisation;
	}

	void Update()
	{
		switch (GameState)
		{
			case GameState.Initialisation:
				{
					WinScreens.SetActive(false);
					PauseMenu.SetActive(false);
					HUD.SetActive(true);
					GameState = GameState.InGame;
					MainMusic[0].SetActive(true);
					MainMusic[1].SetActive(false);
					MainMusic[2].SetActive(false);
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
					MainMusic[0].SetActive(false);
					MainMusic[1].SetActive(true);
					MainMusic[2].SetActive(false);
					StartCoroutine(WinCoroutine(AngelWin));
				}
				break;
			case GameState.EvilWin:
				{
					MainMusic[0].SetActive(false);
					MainMusic[1].SetActive(false);
					MainMusic[2].SetActive(true);
					StartCoroutine(WinCoroutine(EvilWin));
				}
				break;
		}
	}

	IEnumerator WinCoroutine(Sprite SpriteToShow)
	{
		HUD.SetActive(false);
		Time.timeScale = 0.0f;
		yield return new WaitForSecondsRealtime(2.0f);
		WinScreens.SetActive(true);
		WinScreens.GetComponent<Image>().sprite = SpriteToShow;
		yield return new WaitForSecondsRealtime(WinScreenRestTime);
		ReturnMainMenu();

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
		PauseMenu.SetActive(false);
		GameState = GameState.RetrunToMain;
		StartCoroutine(RMMenu());
	}
	public IEnumerator RMMenu()
	{
		yield return new WaitForSecondsRealtime(2.0f);
		SceneManager.LoadScene(0);
	}

	public void WallPlacingActivate(int PlayerNum)
	{
		GameObject wall;
		if (P1Script.transform.GetChild(0).gameObject.activeSelf && P2Script.transform.GetChild(1).gameObject.activeSelf)
		{
			if (PlayerNum == 1)
			{
				wall = ObjectPooler.Instance.GrabFromPool("WallForEvil", new Vector3(P2.transform.position.x + 5.0f, 0.0f, 0.0f), Quaternion.Euler(180.0f, 0.0f, 0.0f));
			}
			else
			{
				wall = ObjectPooler.Instance.GrabFromPool("WallForAngel", new Vector3(P1.transform.position.x + 5.0f, 0.1f, 0.0f), Quaternion.identity);
			}
		}
		else
		{
			if (PlayerNum == 1)
			{
				wall = ObjectPooler.Instance.GrabFromPool("WallForEvil", new Vector3(P1.transform.position.x + 5.0f, 0.1f, 0.0f), Quaternion.identity);
			}
			else
			{
				wall = ObjectPooler.Instance.GrabFromPool("WallForAngel", new Vector3(P2.transform.position.x + 5.0f, 0.0f, 0.0f), Quaternion.Euler(180.0f, 0.0f, 0.0f));
			}
		}
	}

	public IEnumerator SlowPlayer(string PlayerNum)
	{
		if (PlayerNum == "P1")
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


		AngelDownDeco.SetActive(true);
		AngelUpDeco.SetActive(false);
		AngelLight.transform.localRotation = Quaternion.Euler(115.0f, 0.0f, 0.0f);
		EvilDownDeco.SetActive(false);
		EvilUpDeco.SetActive(true);
		EvilLight.transform.localRotation = Quaternion.Euler(-138.0f, 0.0f, 0.0f);

		//Inverse XPos
		float xPosP1 = P1.transform.position.x;
		P1.transform.position = new Vector3(P2.transform.position.x, P1.transform.position.y, 0.0f);
		P2.transform.position = new Vector3(xPosP1, P2.transform.position.y, 0.0f);
		//Stop Move
		P1Script.CanMove = false;
		P2Script.CanMove = false;
		CameraController.CameraCanMove = false;
		//Swap controll
		P1Script.PlayerNumber = 2;
		P2Script.PlayerNumber = 1;
		//Reverse world
		worldPivotAnimator.SetInteger("EvilUp", 1);
		worldPivotAnimator.SetInteger("EvilDown", 0);
		yield return new WaitForSeconds(1.0f);


		//Sprite Swap
		P1Script.Slot1PowerUp.sprite = EvilRings;
		P1Script.Slot2PowerUp.sprite = EvilRings;
		P1Script.Slot1PowerUpHorn.sprite = EvilWings;
		P1Script.Slot2PowerUpHorn.sprite = EvilWings;

		ReverseVisualU[0].sprite = EvilRings;
		ReverseVisualU[1].sprite = EvilWings;

		P2Script.Slot1PowerUpHorn.sprite = AngelWings;
		P2Script.Slot2PowerUpHorn.sprite = AngelWings;
		P2Script.Slot1PowerUp.sprite = AngelRings;
		P2Script.Slot2PowerUp.sprite = AngelRings;

		ReverseVisualD[0].sprite = AngelRings;
		ReverseVisualD[1].sprite = AngelWings;

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
		CameraController.CameraCanMove = true;
		yield return null;
		EvilUP = true;

	}

	public IEnumerator GoToEvilDown()
	{
		//Effect shield up
		float value = 0.0f;
		while (value <= 1.0f)
		{
			value += Mathf.Lerp(0.0f, 1.0f, 0.5f * Time.deltaTime);
			Shader.SetGlobalFloat("AppearValue", value);
			yield return null;
		}

		AngelDownDeco.SetActive(false);
		AngelUpDeco.SetActive(true);
		AngelLight.transform.localRotation = Quaternion.Euler(70.0f, 0.0f, 0.0f);
		EvilDownDeco.SetActive(true);
		EvilUpDeco.SetActive(false);
		EvilLight.transform.localRotation = Quaternion.Euler(-48.0f, 0.0f, 0.0f);

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
		CameraController.CameraCanMove = false;
		//Swap controll
		P1Script.PlayerNumber = 1;
		P2Script.PlayerNumber = 2;
		//Reverse world
		worldPivotAnimator.SetInteger("EvilDown", 1);
		worldPivotAnimator.SetInteger("EvilUp", 0);
		yield return new WaitForSeconds(1.0f);

		// Sprite Swap
		P2Script.Slot1PowerUp.sprite = EvilRings;
		P2Script.Slot2PowerUp.sprite = EvilRings;
		P2Script.Slot1PowerUpHorn.sprite = EvilWings;
		P2Script.Slot2PowerUpHorn.sprite = EvilWings;
		ReverseVisualD[0].sprite = EvilWings;
		ReverseVisualD[1].sprite = EvilWings;

		P1Script.Slot1PowerUpHorn.sprite = AngelWings;
		P1Script.Slot2PowerUpHorn.sprite = AngelWings;
		P1Script.Slot1PowerUp.sprite = AngelRings;
		P1Script.Slot2PowerUp.sprite = AngelRings;
		ReverseVisualU[0].sprite = AngelRings;
		ReverseVisualU[1].sprite = AngelWings;

		worldPivotAnimator.SetInteger("EvilDown", 0);

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
		CameraController.CameraCanMove = true;
		yield return null;
		EvilUP = false;
	}
}