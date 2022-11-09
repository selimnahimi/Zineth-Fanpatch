using System;
using UnityEngine;

// Token: 0x0200007F RID: 127
public class PhoneTextInput : PhoneButton
{
	// Token: 0x170000B2 RID: 178
	// (get) Token: 0x0600054A RID: 1354 RVA: 0x000216A0 File Offset: 0x0001F8A0
	// (set) Token: 0x0600054B RID: 1355 RVA: 0x000216A8 File Offset: 0x0001F8A8
	public string input_text
	{
		get
		{
			return this.id_info;
		}
		set
		{
			this.id_info = value;
			this.text_label.text = ">" + value;
		}
	}

	// Token: 0x0600054C RID: 1356 RVA: 0x000216C8 File Offset: 0x0001F8C8
	private void Awake()
	{
		this.Init();
		this.text_label.overrideColor = true;
		this.text_label.color = Color.gray;
		this.text_label.SetText(">");
	}

	// Token: 0x0600054D RID: 1357 RVA: 0x00021708 File Offset: 0x0001F908
	public override void OnLoad()
	{
		this.text_label.SetColor(Color.gray);
		base.OnLoad();
		if (this.text_label.text == string.Empty)
		{
			this.text_label.SetText(">");
		}
	}

	// Token: 0x0600054E RID: 1358 RVA: 0x00021758 File Offset: 0x0001F958
	public override void OnUpdate()
	{
		if (this.has_focus)
		{
			this.HandleInput();
			if (this.enter_button)
			{
				this.enter_button.id_info = this.id_info;
			}
			string text = ">" + this.input_text + "_";
			if (text != this.text_label.text)
			{
				this.text_label.text = text;
			}
		}
		if (!this.selected && this.has_focus && (Input.GetButtonDown("CellClick") || Input.GetMouseButtonDown(0) || PhoneInput.controltype == PhoneInput.ControlType.Keyboard))
		{
			this.has_focus = false;
			this.text_label.SetColor(Color.gray);
			this.text_label.text = ">" + this.input_text;
		}
		base.OnUpdate();
	}

	// Token: 0x0600054F RID: 1359 RVA: 0x00021844 File Offset: 0x0001FA44
	public override void OnPressed()
	{
		this.has_focus = true;
		this.text_label.SetColor(Color.black);
		Input.ResetInputAxes();
	}

	// Token: 0x06000550 RID: 1360 RVA: 0x00021864 File Offset: 0x0001FA64
	public virtual void HandleInput()
	{
		foreach (char chr in Input.inputString)
		{
			this.InputChar(chr);
		}
	}

	// Token: 0x06000551 RID: 1361 RVA: 0x000218A0 File Offset: 0x0001FAA0
	public virtual void InputChar(char chr)
	{
		if (chr == "\b"[0])
		{
			if (this.input_text.Length > 0)
			{
				this.input_text = this.input_text.Remove(this.input_text.Length - 1);
			}
		}
		else if (chr == "\n"[0] || chr == "\r"[0])
		{
			if (this.enter_button)
			{
				this.enter_button.id_info = this.id_info;
				this.SubmitText();
			}
			else if (!string.IsNullOrEmpty(this.command))
			{
				this.SubmitText();
			}
		}
		else
		{
			this.input_text += chr;
		}
	}

	// Token: 0x06000552 RID: 1362 RVA: 0x00021974 File Offset: 0x0001FB74
	public virtual void SubmitText()
	{
		this.RunCommand(this.command);
		this.input_text = string.Empty;
	}

	// Token: 0x06000553 RID: 1363 RVA: 0x00021990 File Offset: 0x0001FB90
	public override void OnSelected()
	{
		if (this.textmesh)
		{
			this.textscale = this.text_size + Mathf.Min(this.text_size * 0.2f, 0.1f);
		}
		if (this.background_box)
		{
			this.SetBackColor(this.back_selected_color);
		}
		this.SetBorderActive(this.always_use_background_border);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale * this.expand_size;
		}
	}

	// Token: 0x06000554 RID: 1364 RVA: 0x00021A1C File Offset: 0x0001FC1C
	public override void OnUnSelected()
	{
		if (this.textmesh)
		{
			this.textscale = this.text_size;
		}
		if (this.background_box)
		{
			this.SetBackColor(this.back_normal_color);
		}
		this.SetBorderActive(this.always_use_background_border);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale;
		}
	}

	// Token: 0x06000555 RID: 1365 RVA: 0x00021A84 File Offset: 0x0001FC84
	public override bool RelayPress(PhoneButton button)
	{
		if (button == this.enter_button)
		{
			this.SubmitText();
			return true;
		}
		return base.RelayPress(button);
	}

	// Token: 0x06000556 RID: 1366 RVA: 0x00021AB4 File Offset: 0x0001FCB4
	private void OnGUI()
	{
		if (this.has_focus)
		{
			GUI.SetNextControlName("hahaok");
			GUI.TextField(new Rect(-10f, -10f, 1f, 1f), string.Empty);
			GUI.FocusControl("hahaok");
		}
	}

	// Token: 0x0400041B RID: 1051
	public PhoneLabel text_label;

	// Token: 0x0400041C RID: 1052
	public bool has_focus;

	// Token: 0x0400041D RID: 1053
	public PhoneButton enter_button;
}
