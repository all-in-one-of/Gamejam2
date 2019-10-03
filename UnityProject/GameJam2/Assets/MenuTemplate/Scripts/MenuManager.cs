using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class MenuManager : MonoBehaviour
{
	[Header("Audio")]
	public AudioMixer audioMixer;

	public Slider mainVolumeSlider;
	public Slider musicVolumeSlider;
	public Slider vfxVolumeSlider;

	[Header("Options")]
	public Button onButton;
	public Button offButton;

	[Header("Video")]
	public Slider brightnessValueSlider;
	public Slider gammaValueSlider;

	public Dropdown resolutionDropdown;

	private Resolution[] resolutions;

	private bool isAudioOn = true;

	void Start()
	{
		//SetDefaultResolution();

		//SetDefaultVideoSettings();

		SetDefaultAudioSettings();
	}

	#region Audio

	public void AudioOff()
	{
		audioMixer.SetFloat("MainVolume", -80);
		isAudioOn = false;
	}

	public void AudioOn()
	{
		audioMixer.SetFloat("MainVolume", 0);
		isAudioOn = true;
	}

	public void AudioManagement()
	{
		onButton.interactable = !onButton.interactable;
		offButton.interactable = !offButton.interactable;

		if (isAudioOn)
		{
			AudioOff();
		}
		else
		{
			AudioOn();
		}
	}

	public void SetMainVolumeLevel(float sliderValue)
	{
		audioMixer.SetFloat("MainVolume", Mathf.Log10(sliderValue) * 20);
	}

	public void SetMusicVolumeLevel(float sliderValue)
	{
		audioMixer.SetFloat("MusicVolume", Mathf.Log10(sliderValue) * 20);
	}

	public void SetVfxVolumeLevel(float sliderValue)
	{
		audioMixer.SetFloat("VfxVolume", Mathf.Log10(sliderValue) * 20);
	}
	public void SetDefaultAudioSettings()
	{
		mainVolumeSlider.value = mainVolumeSlider.maxValue;
		musicVolumeSlider.value = musicVolumeSlider.maxValue;
		// vfxVolumeSlider.value = vfxVolumeSlider.maxValue;

		audioMixer.SetFloat("MainVolume", mainVolumeSlider.value);
		audioMixer.SetFloat("MusicVolume", musicVolumeSlider.value);
		onButton.interactable = false;
	}

	#endregion

	#region Video

	public void SetFullscreen(bool isFullscreen)
	{
		Screen.fullScreen = isFullscreen;
	}

	public void SetResolution(int resolutionIndex)
	{
		Resolution resolution = resolutions[resolutionIndex];
		Screen.SetResolution(resolution.width, resolution.height, Screen.fullScreen);
	}

	public void SetDefaultVideoSettings()
	{
		brightnessValueSlider.value = brightnessValueSlider.maxValue / 2;
		gammaValueSlider.value = gammaValueSlider.maxValue / 2;
		QualitySettings.SetQualityLevel(5);
	}

	public void SetDefaultResolution()
	{
		resolutions = Screen.resolutions;

		resolutionDropdown.ClearOptions();

		List<string> options = new List<string>();

		int currentResolutionIndex = 0;
		for (int i = 0; i < resolutions.Length; i++)
		{
			string option = resolutions[i].width + " x " + resolutions[i].height;
			options.Add(option);

			if (resolutions[i].width == Screen.currentResolution.width && resolutions[i].height == Screen.currentResolution.height)
			{
				currentResolutionIndex = i;
			}
		}

		resolutionDropdown.AddOptions(options);
		resolutionDropdown.value = currentResolutionIndex;
		resolutionDropdown.RefreshShownValue();
	}

	#endregion

	#region Application
	public void ChangeScene(int sceneIndex)
	{
		StartCoroutine(LoadingScreen(sceneIndex));
	}

	IEnumerator LoadingScreen(int sceneIndex)
	{
		yield return new WaitForSeconds(1.0f);
		SceneManager.LoadScene(sceneIndex);
	}

	public void QuitApp()
	{
		Application.Quit();
	}

	#endregion
}