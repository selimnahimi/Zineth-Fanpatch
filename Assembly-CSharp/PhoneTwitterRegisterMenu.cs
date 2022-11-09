using System;
using UnityEngine;

// Token: 0x02000085 RID: 133
public class PhoneTwitterRegisterMenu : PhoneMainMenu
{
	// Token: 0x06000595 RID: 1429 RVA: 0x000239E0 File Offset: 0x00021BE0
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x06000596 RID: 1430 RVA: 0x000239F4 File Offset: 0x00021BF4
	public override void OnLoad()
	{
		base.OnLoad();
		TwitterDemo.RegisterUser();
		if (this.status_text)
		{
			this.status_text.text = string.Empty;
		}
	}

	// Token: 0x06000597 RID: 1431 RVA: 0x00023A30 File Offset: 0x00021C30
	public override void UpdateScreen()
	{
		this.DoNumberKeyInput();
		base.UpdateScreen();
	}

	// Token: 0x06000598 RID: 1432 RVA: 0x00023A40 File Offset: 0x00021C40
	protected virtual bool AddToPin(string text)
	{
		if (this.status_text && this.status_text.text == "Need 7 digits!")
		{
			this.status_text.text = string.Empty;
		}
		if (this.pin_button.text.Length >= 7)
		{
			return false;
		}
		PhoneLabel phoneLabel = this.pin_button;
		phoneLabel.text += text.Substring(0, 1);
		return true;
	}

	// Token: 0x06000599 RID: 1433 RVA: 0x00023AC0 File Offset: 0x00021CC0
	protected virtual void DoNumberKeyInput()
	{
		if (Input.GetKeyDown(KeyCode.Alpha0))
		{
			this.AddToPin("0");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha1))
		{
			this.AddToPin("1");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha2))
		{
			this.AddToPin("2");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha3))
		{
			this.AddToPin("3");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha4))
		{
			this.AddToPin("4");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha5))
		{
			this.AddToPin("5");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha6))
		{
			this.AddToPin("6");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha7))
		{
			this.AddToPin("7");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha8))
		{
			this.AddToPin("8");
		}
		else if (Input.GetKeyDown(KeyCode.Alpha9))
		{
			this.AddToPin("9");
		}
	}

	// Token: 0x0600059A RID: 1434 RVA: 0x00023BEC File Offset: 0x00021DEC
	protected override void StickControls_Vertical()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (this.buttons.Count == 0)
		{
			return;
		}
		if (this.menuind >= this.buttons.Count)
		{
			this.menuind = 0;
		}
		if (this.menuind < 0)
		{
			this.menuind = 0;
		}
		PhoneButton phoneButton = this.current_buttons[this.menuind];
		if (controlDirPressed.y >= 0.5f && Mathf.Abs(controlDirPressed.x) < 0.3f)
		{
			if (phoneButton.up_button)
			{
				this.menuind = this.current_buttons.IndexOf(phoneButton.up_button);
			}
		}
		else if (controlDirPressed.y <= -0.5f && Mathf.Abs(controlDirPressed.x) < 0.3f)
		{
			if (phoneButton.down_button)
			{
				this.menuind = this.current_buttons.IndexOf(phoneButton.down_button);
			}
		}
		else if (controlDirPressed.x >= 0.5f && Mathf.Abs(controlDirPressed.y) < 0.3f)
		{
			if (phoneButton.right_button)
			{
				this.menuind = this.current_buttons.IndexOf(phoneButton.right_button);
			}
		}
		else if (controlDirPressed.x <= -0.5f && Mathf.Abs(controlDirPressed.y) < 0.3f && phoneButton.left_button)
		{
			this.menuind = this.current_buttons.IndexOf(phoneButton.left_button);
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x0600059B RID: 1435 RVA: 0x00023DD0 File Offset: 0x00021FD0
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "pin_add")
		{
			this.AddToPin(button.text);
		}
		else if (message == "pin_erase")
		{
			string text = this.pin_button.text;
			if (text.Length <= 0)
			{
				this.controller.LoadPrevious();
				return false;
			}
			this.pin_button.text = text.Substring(0, text.Length - 1);
		}
		else
		{
			if (!(message == "pin_submit"))
			{
				return base.ButtonMessage(button, message);
			}
			if (this.pin_button.text.Length < 7)
			{
				if (this.status_text)
				{
					this.status_text.text = "Need 7 digits!";
					this.status_text.textmesh.renderer.material.color = Color.red;
				}
				return false;
			}
			if (this.status_text)
			{
				this.status_text.text = "Submitting...";
				this.status_text.textmesh.renderer.material.color = Color.red;
			}
			TwitterDemo.registercallback = new TwitterDemo.RegisterCallBack(this.OnRegistered);
			TwitterDemo.GetAccess(this.pin_button.text);
		}
		return true;
	}

	// Token: 0x0600059C RID: 1436 RVA: 0x00023F2C File Offset: 0x0002212C
	public void OnRegistered(bool success, string username)
	{
		if (success)
		{
			if (this.status_text)
			{
				this.status_text.text = "Success!";
			}
			this.pin_button.text = string.Empty;
			this.controller.LoadScreen("AccountMenu");
			TwitterDemo.registercallback = new TwitterDemo.RegisterCallBack(TwitterDemo.instance.OnRegister);
		}
		else if (this.status_text)
		{
			this.status_text.text = "Failed!";
			this.status_text.color = Color.red;
		}
	}

	// Token: 0x04000453 RID: 1107
	public PhoneLabel pin_button;

	// Token: 0x04000454 RID: 1108
	public PhoneLabel status_text;
}
