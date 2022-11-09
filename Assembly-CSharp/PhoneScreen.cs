using System;
using UnityEngine;

// Token: 0x0200007C RID: 124
public class PhoneScreen : MonoBehaviour
{
	// Token: 0x170000AB RID: 171
	// (get) Token: 0x0600051D RID: 1309 RVA: 0x00020358 File Offset: 0x0001E558
	public float deltatime
	{
		get
		{
			return PhoneController.deltatime;
		}
	}

	// Token: 0x0600051E RID: 1310 RVA: 0x00020360 File Offset: 0x0001E560
	public virtual void Init()
	{
	}

	// Token: 0x0600051F RID: 1311 RVA: 0x00020364 File Offset: 0x0001E564
	public virtual void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
	}

	// Token: 0x06000520 RID: 1312 RVA: 0x00020374 File Offset: 0x0001E574
	public virtual void OnHomeLoad()
	{
	}

	// Token: 0x06000521 RID: 1313 RVA: 0x00020378 File Offset: 0x0001E578
	public virtual void OnExit()
	{
		base.gameObject.SetActiveRecursively(false);
	}

	// Token: 0x06000522 RID: 1314 RVA: 0x00020388 File Offset: 0x0001E588
	public virtual void OnPause()
	{
	}

	// Token: 0x06000523 RID: 1315 RVA: 0x0002038C File Offset: 0x0001E58C
	public virtual void OnResume()
	{
	}

	// Token: 0x06000524 RID: 1316 RVA: 0x00020390 File Offset: 0x0001E590
	public virtual void UpdateScreen()
	{
	}

	// Token: 0x06000525 RID: 1317 RVA: 0x00020394 File Offset: 0x0001E594
	public virtual bool ButtonMessage(PhoneButton button, string message)
	{
		MonoBehaviour.print("empty message receiver (" + message + ")");
		return false;
	}

	// Token: 0x06000526 RID: 1318 RVA: 0x000203AC File Offset: 0x0001E5AC
	public virtual PhoneButton Button_To(PhoneButton button)
	{
		return button;
	}

	// Token: 0x06000527 RID: 1319 RVA: 0x000203B0 File Offset: 0x0001E5B0
	public virtual float GetSliderVar(string message)
	{
		if (message.StartsWith("."))
		{
			message = message.Remove(0, 1);
		}
		if (message.StartsWith("trailcolor_"))
		{
			if (message.StartsWith("trailcolor_r"))
			{
				return PhoneInterface.trailColor.r;
			}
			if (message.StartsWith("trailcolor_g"))
			{
				return PhoneInterface.trailColor.g;
			}
			if (message.StartsWith("trailcolor_b"))
			{
				return PhoneInterface.trailColor.b;
			}
		}
		else if (message.StartsWith("robotcolor_"))
		{
			if (message.StartsWith("robotcolor_r"))
			{
				return PhoneInterface.robotColor.r;
			}
			if (message.StartsWith("robotcolor_g"))
			{
				return PhoneInterface.robotColor.g;
			}
			if (message.StartsWith("robotcolor_b"))
			{
				return PhoneInterface.robotColor.b;
			}
		}
		else if (message.StartsWith("bgcolor_"))
		{
			if (message.StartsWith("bgcolor_r"))
			{
				return PhoneMemory.settings.backgroundColor.r;
			}
			if (message.StartsWith("bgcolor_g"))
			{
				return PhoneMemory.settings.backgroundColor.g;
			}
			if (message.StartsWith("bgcolor_b"))
			{
				return PhoneMemory.settings.backgroundColor.b;
			}
		}
		else if (message.StartsWith("volume_"))
		{
			if (message.StartsWith("volume_menu"))
			{
				return PhoneMemory.settings.menu_volume;
			}
			if (message.StartsWith("volume_game"))
			{
				return PhoneMemory.settings.game_volume;
			}
			if (message.StartsWith("volume_music"))
			{
				return PhoneMemory.settings.music_volume;
			}
			if (message.StartsWith("volume_ring"))
			{
				return PhoneMemory.settings.ring_volume;
			}
			if (message.StartsWith("volume_master"))
			{
				return PhoneMemory.settings.master_volume;
			}
			if (message.StartsWith("volume_vibrate"))
			{
				return PhoneMemory.settings.vibrate_amount;
			}
		}
		Debug.LogWarning("Unknown slider command: " + message);
		return -1f;
	}

	// Token: 0x04000400 RID: 1024
	public PhoneController controller;

	// Token: 0x04000401 RID: 1025
	public string screenname = "Default";

	// Token: 0x04000402 RID: 1026
	public bool keepactive;

	// Token: 0x04000403 RID: 1027
	public bool bgscreen;

	// Token: 0x04000404 RID: 1028
	public bool clearparticles;

	// Token: 0x04000405 RID: 1029
	public Texture2D icon_texture;

	// Token: 0x04000406 RID: 1030
	public AudioClip clip;

	// Token: 0x04000407 RID: 1031
	public bool do_exit_effect = true;

	// Token: 0x04000408 RID: 1032
	public bool use_other_exit_dir;

	// Token: 0x04000409 RID: 1033
	public Vector3 exit_dir = new Vector3(5f, -3f, 0f);
}
