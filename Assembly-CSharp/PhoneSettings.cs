using System;
using UnityEngine;

// Token: 0x0200004F RID: 79
public class PhoneSettings
{
	// Token: 0x1700006D RID: 109
	// (get) Token: 0x0600033B RID: 827 RVA: 0x00014A6C File Offset: 0x00012C6C
	public Color backgroundColor
	{
		get
		{
			return this.pallete.back;
		}
	}

	// Token: 0x1700006E RID: 110
	// (get) Token: 0x0600033C RID: 828 RVA: 0x00014A7C File Offset: 0x00012C7C
	public Color textColor
	{
		get
		{
			return this.pallete.text;
		}
	}

	// Token: 0x1700006F RID: 111
	// (get) Token: 0x0600033D RID: 829 RVA: 0x00014A8C File Offset: 0x00012C8C
	public Color selectedTextColor
	{
		get
		{
			return this.pallete.selected;
		}
	}

	// Token: 0x17000070 RID: 112
	// (get) Token: 0x0600033E RID: 830 RVA: 0x00014A9C File Offset: 0x00012C9C
	public Color selectableTextColor
	{
		get
		{
			return this.pallete.selectable;
		}
	}

	// Token: 0x17000071 RID: 113
	// (get) Token: 0x0600033F RID: 831 RVA: 0x00014AAC File Offset: 0x00012CAC
	public Color particleColor
	{
		get
		{
			if (this.pallete.particles == new Color(0f, 0f, 0f, 0f))
			{
				return this.pallete.selected;
			}
			return this.pallete.particles;
		}
	}

	// Token: 0x17000072 RID: 114
	// (get) Token: 0x06000340 RID: 832 RVA: 0x00014B00 File Offset: 0x00012D00
	// (set) Token: 0x06000341 RID: 833 RVA: 0x00014B34 File Offset: 0x00012D34
	public bool allow_twitter
	{
		get
		{
			if (this._allow_twitter == -1)
			{
				this._allow_twitter = PlayerPrefs.GetInt("allow_twitter", 1);
			}
			return this._allow_twitter > 0;
		}
		set
		{
			if (value)
			{
				this._allow_twitter = 1;
			}
			else
			{
				this._allow_twitter = 0;
			}
			PlayerPrefs.SetInt("allow_twitter", this._allow_twitter);
		}
	}

	// Token: 0x17000073 RID: 115
	// (get) Token: 0x06000342 RID: 834 RVA: 0x00014B60 File Offset: 0x00012D60
	// (set) Token: 0x06000343 RID: 835 RVA: 0x00014BA4 File Offset: 0x00012DA4
	public float master_volume
	{
		get
		{
			if (this._master_volume == -1f)
			{
				this._master_volume = PlayerPrefs.GetFloat("volume_master", 0.75f);
				AudioListener.volume = this._master_volume;
			}
			return this._master_volume;
		}
		set
		{
			this._master_volume = value;
			PlayerPrefs.SetFloat("volume_master", this._master_volume);
			AudioListener.volume = this._master_volume;
		}
	}

	// Token: 0x17000074 RID: 116
	// (get) Token: 0x06000344 RID: 836 RVA: 0x00014BD4 File Offset: 0x00012DD4
	// (set) Token: 0x06000345 RID: 837 RVA: 0x00014C04 File Offset: 0x00012E04
	public float menu_volume
	{
		get
		{
			if (this._menu_volume == -1f)
			{
				this._menu_volume = PlayerPrefs.GetFloat("volume_menu", 1f);
			}
			return this._menu_volume;
		}
		set
		{
			this._menu_volume = value;
			PlayerPrefs.SetFloat("volume_menu", this._menu_volume);
		}
	}

	// Token: 0x17000075 RID: 117
	// (get) Token: 0x06000346 RID: 838 RVA: 0x00014C20 File Offset: 0x00012E20
	// (set) Token: 0x06000347 RID: 839 RVA: 0x00014C50 File Offset: 0x00012E50
	public float ring_volume
	{
		get
		{
			if (this._ring_volume == -1f)
			{
				this._ring_volume = PlayerPrefs.GetFloat("volume_ring", 1f);
			}
			return this._ring_volume;
		}
		set
		{
			this._ring_volume = value;
			PlayerPrefs.SetFloat("volume_ring", this._ring_volume);
		}
	}

	// Token: 0x17000076 RID: 118
	// (get) Token: 0x06000348 RID: 840 RVA: 0x00014C6C File Offset: 0x00012E6C
	// (set) Token: 0x06000349 RID: 841 RVA: 0x00014C9C File Offset: 0x00012E9C
	public float game_volume
	{
		get
		{
			if (this._game_volume == -1f)
			{
				this._game_volume = PlayerPrefs.GetFloat("volume_game", 1f);
			}
			return this._game_volume;
		}
		set
		{
			this._game_volume = value;
			PlayerPrefs.SetFloat("volume_game", this._game_volume);
		}
	}

	// Token: 0x17000077 RID: 119
	// (get) Token: 0x0600034A RID: 842 RVA: 0x00014CB8 File Offset: 0x00012EB8
	// (set) Token: 0x0600034B RID: 843 RVA: 0x00014CE8 File Offset: 0x00012EE8
	public float music_volume
	{
		get
		{
			if (this._music_volume == -1f)
			{
				this._music_volume = PlayerPrefs.GetFloat("volume_music", 0.5f);
			}
			return this._music_volume;
		}
		set
		{
			this._music_volume = value;
			PlayerPrefs.SetFloat("volume_music", this._music_volume);
			MusicManager.base_vol = MusicManager.base_vol;
		}
	}

	// Token: 0x17000078 RID: 120
	// (get) Token: 0x0600034C RID: 844 RVA: 0x00014D0C File Offset: 0x00012F0C
	// (set) Token: 0x0600034D RID: 845 RVA: 0x00014D3C File Offset: 0x00012F3C
	public float vibrate_amount
	{
		get
		{
			if (this._vibrate_amount == -1f)
			{
				this._vibrate_amount = PlayerPrefs.GetFloat("volume_vibrate", 0.75f);
			}
			return this._vibrate_amount;
		}
		set
		{
			this._vibrate_amount = value;
			PlayerPrefs.SetFloat("volume_vibrate", this._vibrate_amount);
		}
	}

	// Token: 0x040002C8 RID: 712
	public PhoneColorPallete pallete;

	// Token: 0x040002C9 RID: 713
	private int _allow_twitter = -1;

	// Token: 0x040002CA RID: 714
	public bool muted;

	// Token: 0x040002CB RID: 715
	private float _master_volume = -1f;

	// Token: 0x040002CC RID: 716
	public float _menu_volume = -1f;

	// Token: 0x040002CD RID: 717
	public float _ring_volume = -1f;

	// Token: 0x040002CE RID: 718
	public float _game_volume = -1f;

	// Token: 0x040002CF RID: 719
	public float _music_volume = -1f;

	// Token: 0x040002D0 RID: 720
	public float _vibrate_amount = -1f;
}
