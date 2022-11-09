using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000080 RID: 128
public class PhoneTutorialScreen : PhoneMainMenu
{
	// Token: 0x06000558 RID: 1368 RVA: 0x00021B40 File Offset: 0x0001FD40
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x06000559 RID: 1369 RVA: 0x00021B54 File Offset: 0x0001FD54
	public override void OnLoad()
	{
		base.OnLoad();
		this.uncompleted_buttons.Clear();
		foreach (PhoneButton phoneButton in this.required_buttons)
		{
			phoneButton.selected = false;
			this.uncompleted_buttons.Add(phoneButton);
		}
		this.my_last_control_dir = Vector2.zero;
		this._stick_moved = 0f;
		this._stick_has_reset = false;
		this._stick_clicked = false;
		this.menuind = -1;
	}

	// Token: 0x0600055A RID: 1370 RVA: 0x00021C04 File Offset: 0x0001FE04
	public override void UpdateScreen()
	{
		base.UpdateScreen();
		if (this.CheckComplete())
		{
			PhoneController.instance.LoadScreen(this.next_screen);
		}
	}

	// Token: 0x0600055B RID: 1371 RVA: 0x00021C34 File Offset: 0x0001FE34
	protected virtual void CheckCompletedOnSelects()
	{
		if (this.require_stick_reset && !this._stick_has_reset)
		{
			return;
		}
		PhoneButton[] array = this.uncompleted_buttons.ToArray();
		foreach (PhoneButton phoneButton in array)
		{
			if (phoneButton.selected && phoneButton.gameObject.active)
			{
				phoneButton.DoPressedParticles();
				this.CompleteButton(phoneButton);
			}
		}
	}

	// Token: 0x0600055C RID: 1372 RVA: 0x00021CA8 File Offset: 0x0001FEA8
	protected virtual void CheckStickComplete()
	{
		Vector2 controlDir = PhoneInput.GetControlDir();
		if (controlDir.magnitude < 0.6f)
		{
			this._stick_has_reset = true;
		}
		this._stick_moved += (controlDir - this.my_last_control_dir).magnitude * base.deltatime;
		this.my_last_control_dir = controlDir;
		if (PhoneInput.IsPressedDown())
		{
			this._stick_clicked = true;
		}
	}

	// Token: 0x170000B3 RID: 179
	// (get) Token: 0x0600055D RID: 1373 RVA: 0x00021D14 File Offset: 0x0001FF14
	private bool _stick_complete
	{
		get
		{
			return this._stick_moved >= this.require_stick_move;
		}
	}

	// Token: 0x170000B4 RID: 180
	// (get) Token: 0x0600055E RID: 1374 RVA: 0x00021D28 File Offset: 0x0001FF28
	private bool _buttons_complete
	{
		get
		{
			return this.uncompleted_buttons.Count <= 0;
		}
	}

	// Token: 0x170000B5 RID: 181
	// (get) Token: 0x0600055F RID: 1375 RVA: 0x00021D3C File Offset: 0x0001FF3C
	private bool _click_complete
	{
		get
		{
			return !this.require_stick_click || this._stick_clicked;
		}
	}

	// Token: 0x06000560 RID: 1376 RVA: 0x00021D54 File Offset: 0x0001FF54
	public virtual bool CheckComplete()
	{
		if (this.complete_on_select)
		{
			this.CheckCompletedOnSelects();
		}
		this.CheckStickComplete();
		return this._buttons_complete && this._stick_complete && this._click_complete;
	}

	// Token: 0x06000561 RID: 1377 RVA: 0x00021D98 File Offset: 0x0001FF98
	protected virtual void CompleteButton(PhoneButton button)
	{
		if (this.uncompleted_buttons.Contains(button))
		{
			PhoneAudioController.PlayAudioClip("click", SoundType.menu);
			this.uncompleted_buttons.Remove(button);
			if (this.change_text_on_select)
			{
				button.text = string.Empty;
			}
			else
			{
				button.gameObject.SetActiveRecursively(false);
			}
		}
	}

	// Token: 0x06000562 RID: 1378 RVA: 0x00021DF8 File Offset: 0x0001FFF8
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message.StartsWith("complete"))
		{
			this.CompleteButton(button);
			return true;
		}
		return message.StartsWith("skip") || base.ButtonMessage(button, message);
	}

	// Token: 0x0400041E RID: 1054
	public string next_screen;

	// Token: 0x0400041F RID: 1055
	public List<PhoneButton> required_buttons = new List<PhoneButton>();

	// Token: 0x04000420 RID: 1056
	private List<PhoneButton> uncompleted_buttons = new List<PhoneButton>();

	// Token: 0x04000421 RID: 1057
	public bool require_stick_reset = true;

	// Token: 0x04000422 RID: 1058
	private bool _stick_has_reset;

	// Token: 0x04000423 RID: 1059
	public bool complete_on_select;

	// Token: 0x04000424 RID: 1060
	public float require_stick_move;

	// Token: 0x04000425 RID: 1061
	private float _stick_moved;

	// Token: 0x04000426 RID: 1062
	public bool require_stick_click;

	// Token: 0x04000427 RID: 1063
	private bool _stick_clicked;

	// Token: 0x04000428 RID: 1064
	public bool require_mouse_click;

	// Token: 0x04000429 RID: 1065
	private bool _mouse_clicked;

	// Token: 0x0400042A RID: 1066
	private Vector2 my_last_control_dir = Vector2.zero;

	// Token: 0x0400042B RID: 1067
	public bool change_text_on_select;
}
