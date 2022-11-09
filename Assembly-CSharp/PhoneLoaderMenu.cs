using System;
using UnityEngine;

// Token: 0x0200006C RID: 108
public class PhoneLoaderMenu : PhoneMainMenu
{
	// Token: 0x0600046C RID: 1132 RVA: 0x0001A47C File Offset: 0x0001867C
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x0600046D RID: 1133 RVA: 0x0001A490 File Offset: 0x00018690
	public override void OnLoad()
	{
		base.OnLoad();
		bool flag = this.CheckForGameData();
		bool has_tried_tutorial = this.has_tried_tutorial;
		if (this.continueButton)
		{
			if (flag)
			{
				this.continueButton.selectable = true;
			}
			else
			{
				this.continueButton.selectable = false;
				this.continueButton.gameObject.SetActiveRecursively(false);
			}
		}
		if (this.newGamePlusButton)
		{
			if (flag)
			{
				this.newGamePlusButton.selectable = true;
			}
			else
			{
				this.newGamePlusButton.selectable = false;
				this.newGamePlusButton.gameObject.SetActiveRecursively(false);
			}
		}
		if (this.tutorialButton && this.force_tutorial)
		{
			if (this.has_tried_tutorial)
			{
				this.tutorialButton.selectable = true;
			}
			else
			{
				this.tutorialButton.selectable = false;
				this.tutorialButton.gameObject.SetActiveRecursively(false);
			}
		}
		foreach (PhoneButton phoneButton in this.buttons)
		{
			if (phoneButton.gameObject.active)
			{
				phoneButton.down_button = this.CheckDown(phoneButton.down_button);
				phoneButton.up_button = this.CheckUp(phoneButton.up_button);
			}
		}
		if (this.menuind < 0 && PhoneInput.controltype == PhoneInput.ControlType.Keyboard)
		{
			this.menuind = 0;
		}
		if (this.menuind >= 0 && !this.buttons[this.menuind].selectable)
		{
			while (!this.buttons[this.menuind].selectable && this.menuind < this.buttons.Count)
			{
				this.menuind++;
			}
			this.UpdateButtonSelected();
		}
	}

	// Token: 0x0600046E RID: 1134 RVA: 0x0001A6A4 File Offset: 0x000188A4
	private void CleanUp()
	{
		Capsule.all_list.Clear();
		Capsule.collected_list.Clear();
		SecretObject.all_list.Clear();
		SecretObject.collected_list.Clear();
		SecretObject.uncollected_list.Clear();
		NPCTrainer.all_list.Clear();
		NPCTrainer.defeated_list.Clear();
		PhoneMemory.unlocked_zines.Clear();
		PhoneMemory.ResetCapsulePoints();
	}

	// Token: 0x0600046F RID: 1135 RVA: 0x0001A708 File Offset: 0x00018908
	public PhoneButton CheckDown(PhoneButton button)
	{
		if (button == null)
		{
			return null;
		}
		if (button.gameObject.active)
		{
			return button;
		}
		return this.CheckDown(button.down_button);
	}

	// Token: 0x06000470 RID: 1136 RVA: 0x0001A744 File Offset: 0x00018944
	public PhoneButton CheckUp(PhoneButton button)
	{
		if (button == null)
		{
			return null;
		}
		if (button.gameObject.active)
		{
			return button;
		}
		return this.CheckUp(button.up_button);
	}

	// Token: 0x06000471 RID: 1137 RVA: 0x0001A780 File Offset: 0x00018980
	public void LoadTutorial()
	{
		this.CleanUp();
		this.has_tried_tutorial = true;
		Application.LoadLevel("loader 5");
	}

	// Token: 0x06000472 RID: 1138 RVA: 0x0001A79C File Offset: 0x0001899C
	public void NewGame()
	{
		if (this.force_tutorial && !this.has_tried_tutorial)
		{
			this.LoadTutorial();
		}
		else
		{
			PhoneInterface.ClearGameData();
			this.ContinueGame();
		}
	}

	// Token: 0x06000473 RID: 1139 RVA: 0x0001A7D8 File Offset: 0x000189D8
	public void NewGamePlus()
	{
		PhoneInterface.ClearGameData(true);
		this.ContinueGame();
	}

	// Token: 0x06000474 RID: 1140 RVA: 0x0001A7E8 File Offset: 0x000189E8
	public void ContinueGame()
	{
		if (this.force_tutorial && !this.has_tried_tutorial)
		{
			this.LoadTutorial();
		}
		else
		{
			this.CleanUp();
			Application.LoadLevel("loader 1");
		}
	}

	// Token: 0x06000475 RID: 1141 RVA: 0x0001A81C File Offset: 0x00018A1C
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "tutorial")
		{
			this.LoadTutorial();
		}
		else if (message == "newgame")
		{
			this.NewGame();
		}
		else if (message == "newgameplus")
		{
			this.NewGamePlus();
		}
		else
		{
			if (!(message == "continue"))
			{
				return base.ButtonMessage(button, message);
			}
			this.ContinueGame();
		}
		return true;
	}

	// Token: 0x06000476 RID: 1142 RVA: 0x0001A8A0 File Offset: 0x00018AA0
	private bool CheckForGameData()
	{
		return PlayerPrefs.HasKey("times_file_played");
	}

	// Token: 0x17000097 RID: 151
	// (get) Token: 0x06000477 RID: 1143 RVA: 0x0001A8AC File Offset: 0x00018AAC
	// (set) Token: 0x06000478 RID: 1144 RVA: 0x0001A8B8 File Offset: 0x00018AB8
	private bool has_tried_tutorial
	{
		get
		{
			return PlayerPrefs.HasKey("tried_tutorial");
		}
		set
		{
			if (value)
			{
				PlayerPrefs.SetInt("tried_tutorial", 1);
			}
			else
			{
				PlayerPrefs.DeleteKey("tried_tutorial");
			}
		}
	}

	// Token: 0x04000372 RID: 882
	private bool force_tutorial = true;

	// Token: 0x04000373 RID: 883
	public PhoneButton tutorialButton;

	// Token: 0x04000374 RID: 884
	public PhoneButton continueButton;

	// Token: 0x04000375 RID: 885
	public PhoneButton newGameButton;

	// Token: 0x04000376 RID: 886
	public PhoneButton newGamePlusButton;
}
