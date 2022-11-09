using System;
using UnityEngine;

// Token: 0x02000046 RID: 70
public class PhoneAudioController : MonoBehaviour
{
	// Token: 0x1700004A RID: 74
	// (get) Token: 0x0600027F RID: 639 RVA: 0x000110D8 File Offset: 0x0000F2D8
	public static AudioListener listener
	{
		get
		{
			if (!PhoneAudioController._listener)
			{
				PhoneAudioController._listener = (UnityEngine.Object.FindObjectOfType(typeof(AudioListener)) as AudioListener);
			}
			return PhoneAudioController._listener;
		}
	}

	// Token: 0x1700004B RID: 75
	// (get) Token: 0x06000280 RID: 640 RVA: 0x00011108 File Offset: 0x0000F308
	public static PhoneAudioController instance
	{
		get
		{
			return PhoneAudioController.audcon;
		}
	}

	// Token: 0x1700004C RID: 76
	// (get) Token: 0x06000281 RID: 641 RVA: 0x00011110 File Offset: 0x0000F310
	public static PhoneAudioController audcon
	{
		get
		{
			if (!PhoneAudioController._instance)
			{
				PhoneAudioController._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneAudioController)) as PhoneAudioController);
			}
			return PhoneAudioController._instance;
		}
	}

	// Token: 0x06000282 RID: 642 RVA: 0x00011140 File Offset: 0x0000F340
	private void Start()
	{
	}

	// Token: 0x06000283 RID: 643 RVA: 0x00011144 File Offset: 0x0000F344
	public static float GetTypeVolume(SoundType type)
	{
		return PhoneAudioController.SubGetTypeVolume(type);
	}

	// Token: 0x06000284 RID: 644 RVA: 0x0001114C File Offset: 0x0000F34C
	private static float SubGetTypeVolume(SoundType type)
	{
		if (type == SoundType.menu)
		{
			return PhoneMemory.settings.menu_volume;
		}
		if (type == SoundType.ring)
		{
			return PhoneMemory.settings.ring_volume;
		}
		if (type == SoundType.game)
		{
			return PhoneMemory.settings.game_volume;
		}
		if (type == SoundType.music)
		{
			return PhoneMemory.settings.music_volume;
		}
		if (type == SoundType.other)
		{
			return 1f;
		}
		Debug.LogWarning("Unknown soundtype: " + type);
		return 0f;
	}

	// Token: 0x06000285 RID: 645 RVA: 0x000111C8 File Offset: 0x0000F3C8
	public static AudioClip LoadClip(string name)
	{
		return PhoneAudioController.audcon.LoadClipLocal(name);
	}

	// Token: 0x06000286 RID: 646 RVA: 0x000111D8 File Offset: 0x0000F3D8
	public AudioClip LoadClipLocal(string name)
	{
		if (name == "attack")
		{
			if (this.clip_game_attack)
			{
				return this.clip_game_attack;
			}
		}
		else if (name == "die" || name == "lose")
		{
			if (this.clip_game_lose)
			{
				return this.clip_game_lose;
			}
		}
		else if (name == "win")
		{
			if (this.clip_game_win)
			{
				return this.clip_game_win;
			}
		}
		else if (name == "hit")
		{
			if (this.clip_game_hit)
			{
				return this.clip_game_hit;
			}
		}
		else if (name == "enemy_die")
		{
			if (this.clip_game_enemy_die)
			{
				return this.clip_game_enemy_die;
			}
		}
		else if (name == "health_up")
		{
			if (this.clip_game_health_up)
			{
				return this.clip_game_health_up;
			}
		}
		else if (name == "click" || name == "accept")
		{
			if (this.clip_accept)
			{
				return this.clip_accept;
			}
		}
		else if (name == "back")
		{
			if (this.clip_back)
			{
				return this.clip_back;
			}
		}
		else if (name == "open")
		{
			if (this.clip_open)
			{
				return this.clip_open;
			}
		}
		else if (name == "new_app" && this.clip_new_app)
		{
			return this.clip_new_app;
		}
		return Resources.Load("Phone/" + name) as AudioClip;
	}

	// Token: 0x06000287 RID: 647 RVA: 0x000113D0 File Offset: 0x0000F5D0
	public static AudioSource PlayAudioClip(string name)
	{
		return PhoneAudioController.PlayAudioClip(PhoneAudioController.LoadClip(name));
	}

	// Token: 0x06000288 RID: 648 RVA: 0x000113E0 File Offset: 0x0000F5E0
	public static AudioSource PlayAudioClip(AudioClip clip)
	{
		return PhoneAudioController.PlayAudioClip(clip, SoundType.other);
	}

	// Token: 0x06000289 RID: 649 RVA: 0x000113EC File Offset: 0x0000F5EC
	public static AudioSource PlayAudioClip(string name, SoundType type)
	{
		return PhoneAudioController.PlayAudioClip(PhoneAudioController.LoadClip(name), type);
	}

	// Token: 0x0600028A RID: 650 RVA: 0x000113FC File Offset: 0x0000F5FC
	public static AudioSource PlayAudioClip(AudioClip clip, SoundType type)
	{
		float typeVolume = PhoneAudioController.GetTypeVolume(type);
		return PhoneAudioController.PlayAudioClip(clip, typeVolume);
	}

	// Token: 0x0600028B RID: 651 RVA: 0x00011418 File Offset: 0x0000F618
	public static AudioSource PlayAudioClip(AudioClip clip, float volume)
	{
		return PhoneAudioController.PlayAudioClip(clip, Vector3.zero, volume);
	}

	// Token: 0x0600028C RID: 652 RVA: 0x00011428 File Offset: 0x0000F628
	public static AudioSource PlayAudioClip(AudioClip clip, Vector3 position, float volume)
	{
		if (clip == null)
		{
			Debug.LogWarning("audio clip is null...");
			return null;
		}
		GameObject gameObject = new GameObject("Audio-" + clip.name);
		gameObject.transform.parent = PhoneAudioController.listener.transform;
		gameObject.transform.localPosition = position;
		AudioSource audioSource = gameObject.AddComponent<AudioSource>();
		audioSource.clip = clip;
		audioSource.volume = volume;
		audioSource.Play();
		UnityEngine.Object.Destroy(gameObject, clip.length);
		return audioSource;
	}

	// Token: 0x0600028D RID: 653 RVA: 0x000114AC File Offset: 0x0000F6AC
	public static bool StartRinging()
	{
		if (PhoneAudioController.gobj_ring == null)
		{
			PhoneAudioController.gobj_ring = PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_ring_short, SoundType.ring);
			return true;
		}
		if (!PhoneAudioController.gobj_ring.isPlaying)
		{
			PhoneAudioController.gobj_ring.Play();
			return true;
		}
		return false;
	}

	// Token: 0x04000253 RID: 595
	private static AudioListener _listener;

	// Token: 0x04000254 RID: 596
	public AudioClip clip_accept;

	// Token: 0x04000255 RID: 597
	public AudioClip clip_back;

	// Token: 0x04000256 RID: 598
	public AudioClip clip_open;

	// Token: 0x04000257 RID: 599
	public AudioClip clip_close;

	// Token: 0x04000258 RID: 600
	public AudioClip clip_ring_short;

	// Token: 0x04000259 RID: 601
	public AudioClip clip_ring_long;

	// Token: 0x0400025A RID: 602
	public AudioClip clip_bad;

	// Token: 0x0400025B RID: 603
	public static AudioSource gobj_ring;

	// Token: 0x0400025C RID: 604
	public AudioClip clip_game_win;

	// Token: 0x0400025D RID: 605
	public AudioClip clip_game_lose;

	// Token: 0x0400025E RID: 606
	public AudioClip clip_game_attack;

	// Token: 0x0400025F RID: 607
	public AudioClip clip_game_hit;

	// Token: 0x04000260 RID: 608
	public AudioClip clip_game_enemy_die;

	// Token: 0x04000261 RID: 609
	public AudioClip clip_game_health_up;

	// Token: 0x04000262 RID: 610
	public AudioClip clip_new_app;

	// Token: 0x04000263 RID: 611
	private static PhoneAudioController _instance;
}
