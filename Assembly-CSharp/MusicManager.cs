using System;
using UnityEngine;

// Token: 0x020000B5 RID: 181
public class MusicManager : MonoBehaviour
{
	// Token: 0x170000E7 RID: 231
	// (get) Token: 0x060007B2 RID: 1970 RVA: 0x00033430 File Offset: 0x00031630
	private SpawnPointScript spScript
	{
		get
		{
			return PhoneInterface.spawn_point_script;
		}
	}

	// Token: 0x170000E8 RID: 232
	// (get) Token: 0x060007B3 RID: 1971 RVA: 0x00033438 File Offset: 0x00031638
	public static MusicManager instance
	{
		get
		{
			if (!MusicManager._instance)
			{
				MusicManager._instance = (UnityEngine.Object.FindObjectOfType(typeof(MusicManager)) as MusicManager);
			}
			return MusicManager._instance;
		}
	}

	// Token: 0x170000E9 RID: 233
	// (get) Token: 0x060007B5 RID: 1973 RVA: 0x000334B0 File Offset: 0x000316B0
	// (set) Token: 0x060007B4 RID: 1972 RVA: 0x00033468 File Offset: 0x00031668
	public static float base_vol
	{
		get
		{
			return MusicManager._base_vol;
		}
		set
		{
			MusicManager._base_vol = value;
			float num = 1f;
			if (PhoneMemory.initialized)
			{
				num = PhoneMemory.settings.music_volume;
			}
			MusicManager.audio.volume = MusicManager._base_vol * num * MusicManager.override_vol;
		}
	}

	// Token: 0x060007B6 RID: 1974 RVA: 0x000334B8 File Offset: 0x000316B8
	private void Awake()
	{
		if (Application.loadedLevelName != "test")
		{
			MusicManager.override_vol = 1f;
		}
		this.windAudio = GameObject.Find("WindSource").GetComponent<AudioSource>();
		MusicManager.audio = base.gameObject.GetComponent<AudioSource>();
		MusicManager.tracksLength = this.tracks.Length;
		this.originalPositions = new int[MusicManager.tracksLength];
		for (int i = 0; i < this.tracks.Length; i++)
		{
			this.originalPositions[i] = i;
		}
		this.RandomizeMusic();
		MusicManager.base_vol = MusicManager.base_vol;
		base.useGUILayout = false;
	}

	// Token: 0x060007B7 RID: 1975 RVA: 0x00033560 File Offset: 0x00031760
	private void FixedUpdate()
	{
		if (PhoneInterface.hawk && PhoneInterface.hawk.active && PhoneInterface.hawk.targetHeld)
		{
			float num = this.maxVolume;
			if (PhoneInterface.hawk.canControl)
			{
				num = PhoneInterface.hawk.spd;
			}
			else
			{
				num = 800f;
			}
			this.windAudio.volume = this.maxVolume * Mathf.Clamp(num / 800f, 0.1f, 0.25f);
		}
		else if (!this.spScript.isRespawning)
		{
			this.AirFade();
		}
		if (!this.hasStarted)
		{
			this.hasStarted = true;
			this.forward = true;
			MusicManager.base_vol = this.maxVolume;
			if (this.tracks.Length > 0)
			{
				MusicManager.audio.clip = this.tracks[this.currentTrack];
				MusicManager.audio.Play();
			}
		}
		if (MusicManager.audio.clip && MusicManager.audio.time >= MusicManager.audio.clip.length - 0.25f)
		{
			this.PlayNext();
		}
	}

	// Token: 0x060007B8 RID: 1976 RVA: 0x0003369C File Offset: 0x0003189C
	private void RandomizeMusic()
	{
		for (int i = 0; i < this.tracks.Length; i++)
		{
			AudioClip audioClip = this.tracks[i];
			AudioClip audioClip2 = this.tracksReversed[i];
			int num = this.originalPositions[i];
			int num2 = UnityEngine.Random.Range(i, this.tracks.Length);
			this.tracks[i] = this.tracks[num2];
			this.tracks[num2] = audioClip;
			this.tracksReversed[i] = this.tracksReversed[num2];
			this.tracksReversed[num2] = audioClip2;
			this.originalPositions[i] = this.originalPositions[num2];
			this.originalPositions[num2] = num;
		}
	}

	// Token: 0x060007B9 RID: 1977 RVA: 0x00033740 File Offset: 0x00031940
	public void PlayNext()
	{
		this.currentTrack++;
		this.PlayTrack(this.currentTrack);
	}

	// Token: 0x060007BA RID: 1978 RVA: 0x0003375C File Offset: 0x0003195C
	public void PlayPrevious()
	{
		this.currentTrack--;
		this.PlayTrack(this.currentTrack);
	}

	// Token: 0x060007BB RID: 1979 RVA: 0x00033778 File Offset: 0x00031978
	public void PlayTrack(int trackPos)
	{
		if (this.tracks.Length == 0)
		{
			return;
		}
		if (trackPos < 0)
		{
			trackPos = this.tracks.Length - 1;
		}
		else if (trackPos >= this.tracks.Length)
		{
			trackPos = 0;
		}
		this.currentTrack = trackPos;
		MusicManager.audio.clip = this.tracks[this.currentTrack];
		MusicManager.audio.time = 0f;
		MusicManager.audio.loop = false;
		MusicManager.audio.Play();
	}

	// Token: 0x060007BC RID: 1980 RVA: 0x00033800 File Offset: 0x00031A00
	public void PlaySpecificTrack(int trackNo)
	{
		if (this.tracks.Length == 0)
		{
			return;
		}
		if (trackNo < 0)
		{
			trackNo = this.tracks.Length - 1;
		}
		else if (trackNo >= this.tracks.Length)
		{
			trackNo = 0;
		}
		this.currentTrack = this.originalPositions[trackNo];
		MusicManager.audio.clip = this.tracks[this.currentTrack];
		MusicManager.audio.time = 0f;
		MusicManager.audio.loop = false;
		MusicManager.audio.Play();
	}

	// Token: 0x060007BD RID: 1981 RVA: 0x00033890 File Offset: 0x00031A90
	public void Pause()
	{
		this.isPaused = true;
		MusicManager.audio.Pause();
	}

	// Token: 0x060007BE RID: 1982 RVA: 0x000338A4 File Offset: 0x00031AA4
	public void PlayForward()
	{
		if (this.tracks.Length == 0)
		{
			return;
		}
		if (!this.forward)
		{
			this.isPaused = false;
			this.forward = true;
			float time = MusicManager.audio.time;
			MusicManager.audio.clip = this.tracks[this.currentTrack];
			MusicManager.audio.time = MusicManager.audio.clip.length - time;
			MusicManager.audio.pitch = this.normalPitch;
			MusicManager.audio.Play();
		}
		else if (this.isPaused)
		{
			this.isPaused = false;
			MusicManager.audio.Play();
		}
	}

	// Token: 0x060007BF RID: 1983 RVA: 0x00033950 File Offset: 0x00031B50
	public void PlayReversed()
	{
		if (this.tracks.Length == 0)
		{
			return;
		}
		if (this.forward)
		{
			this.isPaused = false;
			this.forward = false;
			float time = MusicManager.audio.time;
			MusicManager.audio.clip = this.tracksReversed[this.currentTrack];
			MusicManager.audio.time = MusicManager.audio.clip.length - time;
			MusicManager.audio.pitch = this.reversePitch;
			MusicManager.audio.Play();
		}
		else if (this.isPaused)
		{
			this.isPaused = false;
			MusicManager.audio.Play();
		}
	}

	// Token: 0x060007C0 RID: 1984 RVA: 0x000339FC File Offset: 0x00031BFC
	private void AirFade()
	{
		bool grounded = base.gameObject.GetComponent<move>().grounded;
		bool wallRiding = base.gameObject.GetComponent<move>().wallRiding;
		bool isGrinding = base.gameObject.GetComponent<move>().isGrinding;
		if (!grounded && !wallRiding && !isGrinding && !this.startedFadeBack)
		{
			this.upwardsAirMovementLength += Time.deltaTime;
			RaycastHit raycastHit;
			if (Physics.Raycast(base.transform.position, -Vector3.up, out raycastHit))
			{
				float distance = raycastHit.distance;
				if (distance >= this.fadeHeight)
				{
					if (this.upwardsAirMovementLength >= this.startFadeTime && MusicManager.base_vol > this.minVolume)
					{
						this.FadeOut();
					}
				}
				else if (MusicManager.base_vol < 1f)
				{
					this.startedFadeBack = true;
				}
			}
		}
		else
		{
			this.upwardsAirMovementLength = 0f;
			if (MusicManager.base_vol < 1f)
			{
				if (!grounded)
				{
					this.FadeIn();
				}
				else
				{
					MusicManager.base_vol = 1f;
					this.ControlWind();
				}
			}
			else
			{
				this.startedFadeBack = false;
			}
		}
	}

	// Token: 0x060007C1 RID: 1985 RVA: 0x00033B30 File Offset: 0x00031D30
	private void FadeOut()
	{
		MusicManager.base_vol -= this.fadeOutAmount;
		this.ControlWind();
	}

	// Token: 0x060007C2 RID: 1986 RVA: 0x00033B4C File Offset: 0x00031D4C
	private void FadeIn()
	{
		this.startedFadeBack = true;
		MusicManager.base_vol += this.fadeInAmount;
		this.ControlWind();
	}

	// Token: 0x060007C3 RID: 1987 RVA: 0x00033B6C File Offset: 0x00031D6C
	private void ControlWind()
	{
		if (!PhoneInterface.hawk || !PhoneInterface.hawk.active || !PhoneInterface.hawk.targetHeld)
		{
			this.windAudio.volume = this.maxVolume - MusicManager.base_vol;
		}
	}

	// Token: 0x060007C4 RID: 1988 RVA: 0x00033BC4 File Offset: 0x00031DC4
	public static void PauseMusic()
	{
		MusicManager.instance.Pause();
	}

	// Token: 0x060007C5 RID: 1989 RVA: 0x00033BD0 File Offset: 0x00031DD0
	public static void PlayMusic()
	{
		MusicManager.instance.PlayForward();
	}

	// Token: 0x060007C6 RID: 1990 RVA: 0x00033BDC File Offset: 0x00031DDC
	public static void PlayMusicTrack(int ind)
	{
		MusicManager.instance.PlayTrack(ind);
	}

	// Token: 0x060007C7 RID: 1991 RVA: 0x00033BEC File Offset: 0x00031DEC
	public static void PlayNextTrack()
	{
		MusicManager.instance.PlayNext();
	}

	// Token: 0x060007C8 RID: 1992 RVA: 0x00033BF8 File Offset: 0x00031DF8
	public static void PlayPreviousTrack()
	{
		MusicManager.instance.PlayPrevious();
	}

	// Token: 0x060007C9 RID: 1993 RVA: 0x00033C04 File Offset: 0x00031E04
	public static void ShuffleTracks()
	{
		MusicManager.instance.RandomizeMusic();
	}

	// Token: 0x170000EA RID: 234
	// (get) Token: 0x060007CA RID: 1994 RVA: 0x00033C10 File Offset: 0x00031E10
	// (set) Token: 0x060007CB RID: 1995 RVA: 0x00033C30 File Offset: 0x00031E30
	public static bool show_debug_gui
	{
		get
		{
			return MusicManager.instance && MusicManager.instance.useGUILayout;
		}
		set
		{
			if (MusicManager.instance)
			{
				MusicManager.instance.useGUILayout = value;
			}
		}
	}

	// Token: 0x060007CC RID: 1996 RVA: 0x00033C4C File Offset: 0x00031E4C
	private void OnGUI()
	{
		if (!MusicManager.show_debug_gui)
		{
			return;
		}
		float num = GUILayout.HorizontalSlider(MusicManager.audio.time, 0f, MusicManager.audio.clip.length, new GUILayoutOption[]
		{
			GUILayout.Width(MusicManager.audio.clip.length)
		});
		if (Mathf.Abs(num - MusicManager.audio.time) > 2f)
		{
			MonoBehaviour.print("playing track at " + (int)num);
			MusicManager.audio.time = num;
		}
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		if (GUILayout.Button("|<", new GUILayoutOption[0]))
		{
			this.PlayPrevious();
		}
		if (GUILayout.Button(">|", new GUILayoutOption[0]))
		{
			this.PlayNext();
		}
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
		for (int i = 0; i < this.tracks.Length; i++)
		{
			GUILayout.BeginHorizontal(new GUILayoutOption[0]);
			string text = this.tracks[i].name;
			if (this.currentTrack == i)
			{
				text = "->" + text;
			}
			if (GUILayout.Button(text, new GUILayoutOption[0]))
			{
				this.PlayTrack(i);
			}
			GUILayout.FlexibleSpace();
			GUILayout.EndHorizontal();
		}
	}

	// Token: 0x0400066F RID: 1647
	public AudioClip[] tracks;

	// Token: 0x04000670 RID: 1648
	public AudioClip[] tracksReversed;

	// Token: 0x04000671 RID: 1649
	private static int tracksLength;

	// Token: 0x04000672 RID: 1650
	private int[] originalPositions;

	// Token: 0x04000673 RID: 1651
	public int currentTrack;

	// Token: 0x04000674 RID: 1652
	public float maxVolume = 1f;

	// Token: 0x04000675 RID: 1653
	public float reversePitch = 1.2f;

	// Token: 0x04000676 RID: 1654
	public float normalPitch = 1f;

	// Token: 0x04000677 RID: 1655
	private bool hasStarted;

	// Token: 0x04000678 RID: 1656
	private bool forward = true;

	// Token: 0x04000679 RID: 1657
	private bool isPaused;

	// Token: 0x0400067A RID: 1658
	private new static AudioSource audio;

	// Token: 0x0400067B RID: 1659
	private float upwardsAirMovementLength;

	// Token: 0x0400067C RID: 1660
	private float startFadeTime;

	// Token: 0x0400067D RID: 1661
	private float fadeOutAmount = 0.005f;

	// Token: 0x0400067E RID: 1662
	private float fadeInAmount = 0.01f;

	// Token: 0x0400067F RID: 1663
	private float fadeHeight = 300f;

	// Token: 0x04000680 RID: 1664
	private bool startedFadeBack;

	// Token: 0x04000681 RID: 1665
	private float minVolume = 0.3f;

	// Token: 0x04000682 RID: 1666
	private AudioSource windAudio;

	// Token: 0x04000683 RID: 1667
	private static MusicManager _instance;

	// Token: 0x04000684 RID: 1668
	public static float override_vol = 1f;

	// Token: 0x04000685 RID: 1669
	private static float _base_vol;
}
