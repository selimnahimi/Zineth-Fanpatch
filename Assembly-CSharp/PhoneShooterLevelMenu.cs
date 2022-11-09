using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007D RID: 125
public class PhoneShooterLevelMenu : PhoneMainMenu
{
	// Token: 0x06000529 RID: 1321 RVA: 0x00020614 File Offset: 0x0001E814
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x0600052A RID: 1322 RVA: 0x00020628 File Offset: 0x0001E828
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x170000AC RID: 172
	// (get) Token: 0x0600052C RID: 1324 RVA: 0x00020638 File Offset: 0x0001E838
	// (set) Token: 0x0600052B RID: 1323 RVA: 0x00020630 File Offset: 0x0001E830
	public int levelind
	{
		get
		{
			return PhoneMemory.game_level;
		}
		set
		{
			PhoneMemory.game_level = value;
		}
	}

	// Token: 0x0600052D RID: 1325 RVA: 0x00020640 File Offset: 0x0001E840
	public override void UpdateScreen()
	{
		base.UpdateScreen();
		if (this.vslabel && this.current_level.trainer != null)
		{
			this.vslabel.text = "VS";
			this.vslabel.textmesh.characterSize = Mathf.Lerp(2.5f, 3.2f, (float)(Time.frameCount % 10) / 10f);
		}
		if (!PhoneMemory.trainer_challenge && this.levelind >= PhoneResourceController.phoneshooterlevels.Count)
		{
			this.levelind = 0;
		}
	}

	// Token: 0x0600052E RID: 1326 RVA: 0x000206E4 File Offset: 0x0001E8E4
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		if (this.exit_animating)
		{
			this.cancel_exit_animate = true;
		}
		if (PhoneMemory.trainer_challenge)
		{
			this.levelind = this.levels.Count - 1;
		}
		this.menuind = 0;
		this.UpdateLevelTexture();
		foreach (PhoneElement phoneElement in base.elements)
		{
			phoneElement.OnLoad();
		}
		this.DoArrows();
		base.UpdateMenuItems();
	}

	// Token: 0x170000AD RID: 173
	// (get) Token: 0x0600052F RID: 1327 RVA: 0x00020770 File Offset: 0x0001E970
	public PhoneShooterLevel current_level
	{
		get
		{
			return PhoneMemory.level_obj;
		}
	}

	// Token: 0x170000AE RID: 174
	// (get) Token: 0x06000530 RID: 1328 RVA: 0x00020778 File Offset: 0x0001E978
	public Texture2D current_texture
	{
		get
		{
			return this.current_level.texture;
		}
	}

	// Token: 0x06000531 RID: 1329 RVA: 0x00020788 File Offset: 0x0001E988
	public void UpdateLevelTexture()
	{
		if (this.texturelabel)
		{
			this.texturelabel.renderer.material.mainTexture = this.current_texture;
		}
		if (this.namelabel)
		{
			this.namelabel.text = this.current_level.name;
		}
		if (this.lvllabel)
		{
			this.lvllabel.text = "LVL " + this.current_level.difficulty.ToString();
		}
		if (this.vslabel)
		{
			if (this.current_level.trainer != null)
			{
				this.vslabel.text = "VS";
			}
			else
			{
				this.vslabel.text = string.Empty;
			}
		}
	}

	// Token: 0x170000AF RID: 175
	// (get) Token: 0x06000532 RID: 1330 RVA: 0x00020868 File Offset: 0x0001EA68
	public List<PhoneShooterLevel> levels
	{
		get
		{
			List<PhoneShooterLevel> list = new List<PhoneShooterLevel>(PhoneResourceController.phoneshooterlevels);
			if (PhoneMemory.trainer_challenge != null)
			{
				list.Add(PhoneMemory.trainer_challenge.levelobj);
			}
			return list;
		}
	}

	// Token: 0x06000533 RID: 1331 RVA: 0x000208A4 File Offset: 0x0001EAA4
	private void NextLevel()
	{
		this.levelind++;
		if (this.levelind >= this.levels.Count)
		{
			this.levelind = this.levels.Count - 1;
		}
		else
		{
			foreach (PhoneElement phoneElement in this.moving_elements)
			{
				if (phoneElement.animateOnLoad)
				{
					phoneElement.transform.position += Vector3.right * 1f;
				}
				if (phoneElement == this.texturelabel)
				{
					phoneElement.transform.position += Vector3.right * 1f;
				}
			}
		}
		this.UpdateLevelTexture();
		if (this.nextbut)
		{
			this.nextbut.transform.position -= base.transform.right * 0.15f;
		}
		this.DoArrows();
	}

	// Token: 0x06000534 RID: 1332 RVA: 0x000209F4 File Offset: 0x0001EBF4
	private void PreviousLevel()
	{
		this.levelind--;
		if (this.levelind < 0)
		{
			this.levelind = 0;
		}
		else
		{
			foreach (PhoneElement phoneElement in this.moving_elements)
			{
				if (phoneElement.animateOnLoad)
				{
					phoneElement.transform.position -= Vector3.right * 1f;
				}
				if (phoneElement == this.texturelabel)
				{
					phoneElement.transform.position -= Vector3.right * 1f;
				}
			}
		}
		this.UpdateLevelTexture();
		if (this.prevbut)
		{
			this.prevbut.transform.position += base.transform.right * 0.15f;
		}
		this.DoArrows();
	}

	// Token: 0x06000535 RID: 1333 RVA: 0x00020B2C File Offset: 0x0001ED2C
	private void DoArrows()
	{
		if (this.prevbut)
		{
			bool flag = this.levelind > 0;
			this.prevbut.renderer.enabled = flag;
			this.prevbut.selectable = flag;
			foreach (PhoneButton phoneButton in this.buttons)
			{
				if (flag)
				{
					phoneButton.left_button = this.prevbut;
				}
				else
				{
					phoneButton.left_button = null;
				}
			}
		}
		if (this.nextbut)
		{
			bool flag = this.levelind < this.levels.Count - 1;
			this.nextbut.renderer.enabled = flag;
			this.nextbut.selectable = flag;
			foreach (PhoneButton phoneButton2 in this.buttons)
			{
				if (flag)
				{
					phoneButton2.right_button = this.nextbut;
				}
				else
				{
					phoneButton2.right_button = null;
				}
			}
		}
		this.UpdateButtonSelected();
	}

	// Token: 0x06000536 RID: 1334 RVA: 0x00020C9C File Offset: 0x0001EE9C
	public override bool ButtonMessage(PhoneButton button, string command)
	{
		if (command == "next")
		{
			this.NextLevel();
		}
		else if (command == "previous")
		{
			this.PreviousLevel();
		}
		else
		{
			if (!(command == "accept"))
			{
				return base.ButtonMessage(button, command);
			}
			this.controller.LoadScreen(this.nextscreenname);
		}
		return true;
	}

	// Token: 0x06000537 RID: 1335 RVA: 0x00020D10 File Offset: 0x0001EF10
	protected override void DoStickControls()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (controlDirPressed.x >= 0.5f)
		{
			this.NextLevel();
		}
		else if (controlDirPressed.x <= -0.5f)
		{
			this.PreviousLevel();
		}
		if (controlDirPressed.y >= 0.5f)
		{
			this.menuind--;
		}
		if (controlDirPressed.y <= -0.5f)
		{
			this.menuind++;
		}
		if (this.controls_wrap)
		{
			if (this.menuind < 0)
			{
				this.menuind = Mathf.Max(0, this.buttons.Count - 1);
			}
			if (this.menuind >= this.buttons.Count)
			{
				this.menuind = 0;
			}
		}
		else
		{
			if (this.menuind < 0)
			{
				this.menuind = 0;
			}
			if (this.menuind >= this.buttons.Count)
			{
				this.menuind = this.buttons.Count - 1;
			}
		}
		while (this.buttons[this.menuind] == this.nextbut || this.buttons[this.menuind] == this.prevbut)
		{
			this.menuind++;
		}
		if (this.menuind >= this.buttons.Count)
		{
			if (this.controls_wrap)
			{
				this.menuind = 0;
			}
			else
			{
				this.menuind = this.buttons.Count - 1;
			}
		}
		if (PhoneInput.IsPressedDown() && this.buttons.Count > this.menuind)
		{
			this.buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x0400040A RID: 1034
	public PhoneLabel namelabel;

	// Token: 0x0400040B RID: 1035
	public PhoneLabel lvllabel;

	// Token: 0x0400040C RID: 1036
	public PhoneElement texturelabel;

	// Token: 0x0400040D RID: 1037
	public PhoneLabel vslabel;

	// Token: 0x0400040E RID: 1038
	public PhoneButton nextbut;

	// Token: 0x0400040F RID: 1039
	public PhoneButton prevbut;

	// Token: 0x04000410 RID: 1040
	public List<PhoneElement> moving_elements = new List<PhoneElement>();

	// Token: 0x04000411 RID: 1041
	public string nextscreenname;
}
