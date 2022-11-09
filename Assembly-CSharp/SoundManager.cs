using System;
using UnityEngine;

// Token: 0x020000B6 RID: 182
public class SoundManager : MonoBehaviour
{
	// Token: 0x060007CE RID: 1998 RVA: 0x00033DB8 File Offset: 0x00031FB8
	private void Awake()
	{
		this.audio = base.gameObject.GetComponent<AudioSource>();
	}

	// Token: 0x060007CF RID: 1999 RVA: 0x00033DCC File Offset: 0x00031FCC
	public void PlayGrind()
	{
		if (!this.muted)
		{
			this.rewindPlaying = false;
			this.audio.clip = this.grind;
			this.audio.loop = true;
			this.audio.volume = this.maxVolume;
			this.audio.Play();
			this.currentSound = "grind";
		}
	}

	// Token: 0x060007D0 RID: 2000 RVA: 0x00033E30 File Offset: 0x00032030
	public void PlayJump()
	{
		if (!this.muted)
		{
			AudioSource.PlayClipAtPoint(this.jump, new Vector3(5f, 1f, 2f));
		}
	}

	// Token: 0x060007D1 RID: 2001 RVA: 0x00033E68 File Offset: 0x00032068
	public void PlayBoost()
	{
		if (!this.muted)
		{
			AudioSource.PlayClipAtPoint(this.boost, new Vector3(5f, 1f, 2f));
		}
	}

	// Token: 0x060007D2 RID: 2002 RVA: 0x00033EA0 File Offset: 0x000320A0
	public void PlaySkate()
	{
		if (!this.muted)
		{
			this.rewindPlaying = false;
			this.audio.clip = this.skate;
			this.audio.loop = true;
			this.audio.volume = this.maxVolume;
			this.audio.Play();
			this.currentSound = "skate";
		}
	}

	// Token: 0x060007D3 RID: 2003 RVA: 0x00033F04 File Offset: 0x00032104
	public void PlaySkateSand()
	{
		if (!this.muted)
		{
			this.rewindPlaying = false;
			this.audio.clip = this.skateSand;
			this.audio.loop = true;
			this.audio.volume = this.maxVolume - 0.5f;
			this.audio.Play();
			this.currentSound = "skateSand";
		}
	}

	// Token: 0x060007D4 RID: 2004 RVA: 0x00033F70 File Offset: 0x00032170
	public void PlayWallRide()
	{
		if (!this.muted)
		{
			this.rewindPlaying = false;
			this.audio.clip = this.wallRide;
			this.audio.loop = true;
			this.audio.volume = this.maxVolume;
			this.audio.Play();
			this.currentSound = "wallRide";
		}
	}

	// Token: 0x060007D5 RID: 2005 RVA: 0x00033FD4 File Offset: 0x000321D4
	public void PlayRewind()
	{
		if (!this.rewindPlaying)
		{
			this.rewindPlaying = true;
			this.audio.clip = this.rewind;
			this.audio.loop = true;
			this.audio.volume = this.maxVolume;
			this.audio.Play();
			this.currentSound = "rewind";
		}
	}

	// Token: 0x060007D6 RID: 2006 RVA: 0x00034038 File Offset: 0x00032238
	public void PauseRewind()
	{
		if (this.rewindPlaying)
		{
			this.rewindPlaying = false;
			this.audio.Pause();
		}
	}

	// Token: 0x060007D7 RID: 2007 RVA: 0x00034058 File Offset: 0x00032258
	public void StopSound()
	{
		this.audio.Stop();
		this.currentSound = "none";
		this.rewindPlaying = false;
	}

	// Token: 0x04000686 RID: 1670
	public AudioClip grind;

	// Token: 0x04000687 RID: 1671
	public AudioClip jump;

	// Token: 0x04000688 RID: 1672
	public AudioClip skate;

	// Token: 0x04000689 RID: 1673
	public AudioClip skateSand;

	// Token: 0x0400068A RID: 1674
	public AudioClip wallRide;

	// Token: 0x0400068B RID: 1675
	public AudioClip rewind;

	// Token: 0x0400068C RID: 1676
	public AudioClip boost;

	// Token: 0x0400068D RID: 1677
	public float maxVolume = 1f;

	// Token: 0x0400068E RID: 1678
	public string currentSound = "none";

	// Token: 0x0400068F RID: 1679
	public bool muted;

	// Token: 0x04000690 RID: 1680
	public bool rewindPlaying;

	// Token: 0x04000691 RID: 1681
	private new AudioSource audio;
}
