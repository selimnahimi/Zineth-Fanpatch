using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200006D RID: 109
public class PhoneMailMenu : PhoneMainMenu
{
	// Token: 0x0600047A RID: 1146 RVA: 0x0001A960 File Offset: 0x00018B60
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
		if (this.mail_text_label == null)
		{
			this.mail_text_label = base.transform.FindChild("MailTextLabel").GetComponent<PhoneLabel>();
		}
		if (this.mail_subject_label == null)
		{
			this.mail_subject_label = base.transform.FindChild("MailSubjectLabel").GetComponent<PhoneLabel>();
		}
		if (this.mail_sender_label == null)
		{
			this.mail_sender_label = base.transform.FindChild("MailSenderLabel").GetComponent<PhoneLabel>();
		}
		if (this.mail_title_label == null)
		{
			this.mail_title_label = base.transform.FindChild("MailTitleLabel").GetComponent<PhoneLabel>();
		}
		if (this.mail_back_button == null)
		{
			this.mail_back_button = base.transform.FindChild("MailBackButton").GetComponent<PhoneButton>();
		}
		if (this.mail_reply_button == null)
		{
			this.mail_reply_button = base.transform.FindChild("MailReplyButton").GetComponent<PhoneButton>();
		}
		if (this.message_holder == null)
		{
			this.message_holder = base.transform.FindChild("MessageHolder").transform;
		}
		if (this.message_holder)
		{
			this.message_holder_offset = this.message_holder.localPosition;
		}
	}

	// Token: 0x0600047B RID: 1147 RVA: 0x0001AAD4 File Offset: 0x00018CD4
	public override void Init()
	{
		if (this.button_prefab == null)
		{
			this.button_prefab = PhoneTextController.buttonprefab;
		}
		base.Init();
	}

	// Token: 0x0600047C RID: 1148 RVA: 0x0001AB04 File Offset: 0x00018D04
	public override void UpdateScreen()
	{
		this.CheckUpdates();
		if (this.zone != this.oldzone)
		{
			base.UpdateMenuItems();
		}
		this.oldzone = this.zone;
		base.UpdateScreen();
	}

	// Token: 0x0600047D RID: 1149 RVA: 0x0001AB44 File Offset: 0x00018D44
	protected virtual bool CheckUpdates()
	{
		if (PhoneMemory.mail_updated)
		{
			if (this.mode == PhoneMailMenu.mailmode.inbox)
			{
				this.SetupMail();
			}
			PhoneMemory.mail_updated = false;
			return true;
		}
		return false;
	}

	// Token: 0x0600047E RID: 1150 RVA: 0x0001AB78 File Offset: 0x00018D78
	protected virtual void LoadAnimationCancel()
	{
		if (this.exit_animating)
		{
			Debug.LogWarning("looks like it is exit animating...");
			this.cancel_exit_animate = true;
		}
	}

	// Token: 0x0600047F RID: 1151 RVA: 0x0001AB98 File Offset: 0x00018D98
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.LoadAnimationCancel();
		this.menuind = 0;
		this.mode = PhoneMailMenu.mailmode.inbox;
		if (this.mail_list.Count <= 0 && this.zone == PhoneMailMenu.MenuZone.Center)
		{
			this.zone = PhoneMailMenu.MenuZone.Left;
		}
		this.current_mail = null;
		if (this.resetselection)
		{
			this.mailindex = 0;
			this.oldmenuind = 0;
		}
		this.message_holder.localPosition = this.message_holder_offset;
		this.buttons.Remove(this.mail_reply_button);
		this.mail_reply_button.OnUnSelected();
		if (!this.CheckUpdates())
		{
			this.SetupMail();
		}
		foreach (PhoneElement phoneElement in base.elements)
		{
			phoneElement.OnLoad();
		}
		base.UpdateMenuItems();
		this.mail_text_label.text = string.Empty;
		this.mail_sender_label.text = string.Empty;
		this.mail_subject_label.text = string.Empty;
		this.HideReplyButton();
		this.lastmousepos = Vector3.one * -1f;
		if (this.menuind < this.current_buttons.Count)
		{
			this.current_buttons[this.menuind].OnSelected();
		}
	}

	// Token: 0x17000098 RID: 152
	// (get) Token: 0x06000480 RID: 1152 RVA: 0x0001ACEC File Offset: 0x00018EEC
	protected virtual List<PhoneMail> mail_list
	{
		get
		{
			return PhoneMemory.messages;
		}
	}

	// Token: 0x06000481 RID: 1153 RVA: 0x0001ACF4 File Offset: 0x00018EF4
	protected virtual void SetupMail()
	{
		if (!this.setting_up_mail)
		{
			this.setting_up_mail = true;
			base.StartCoroutine("Co_SetupMail");
		}
	}

	// Token: 0x06000482 RID: 1154 RVA: 0x0001AD1C File Offset: 0x00018F1C
	protected virtual IEnumerator Co_SetupMail()
	{
		this.mail_bounds = default(Bounds);
		this.mail_back_button.textmesh.text = this.inbox_exit_text;
		if (this.mail_title_label)
		{
			this.mail_title_label.textmesh.text = string.Empty;
		}
		this.ClearMailButtons();
		Vector3 pos = base.transform.forward * this.first_mail_forward_pos + base.transform.up + base.transform.right * this.mailxpos;
		int old_menuind = this.menuind;
		int mailind = 0;
		List<PhoneMail> temp_list = new List<PhoneMail>(this.mail_list);
		PhoneButton lastbutton = null;
		foreach (PhoneMail message in temp_list)
		{
			PhoneButton button = UnityEngine.Object.Instantiate(this.button_prefab) as PhoneButton;
			button.transform.parent = this.message_holder;
			button.transform.localPosition = pos;
			button.wantedpos = pos;
			string subjtext;
			if (message.is_new)
			{
				subjtext = "*" + message.subject;
			}
			else
			{
				subjtext = message.subject;
			}
			int maxlength = 20;
			if (subjtext.Length > maxlength)
			{
				subjtext = subjtext.TrimEnd(new char[]
				{
					' '
				}).Substring(0, maxlength - 3).TrimEnd(new char[]
				{
					' '
				}) + "...";
			}
			button.button_name = subjtext;
			button.screen = this;
			button.command = ".openmessage " + mailind.ToString();
			button.id_info = message.id;
			button.up_button = lastbutton;
			if (lastbutton)
			{
				lastbutton.down_button = button;
			}
			button.left_button = this.mail_back_button;
			if (this.right_buttons.Count > 0)
			{
				button.right_button = this.right_buttons[0];
			}
			lastbutton = button;
			button.textmesh.characterSize = 0.65f;
			button.textmesh.alignment = TextAlignment.Left;
			button.textmesh.anchor = TextAnchor.MiddleLeft;
			button.pressed_particles = false;
			button.animateRate = 7f;
			this.mailbuttons.Add(button);
			this.buttons.Add(button);
			button.id_info = message.id;
			button.Init();
			button.OnLoad();
			if (message != this.current_mail)
			{
				if (button.animateOnLoad)
				{
					button.transform.position = PhoneController.presspos;
					if (mailind % 2 == 0)
					{
						button.transform.position += base.transform.right * 3f;
					}
					else
					{
						button.transform.position -= base.transform.right * 3f;
					}
				}
			}
			if (this.space_by_bounds)
			{
				pos.z -= this.button_prefab.GetBounds().size.z;
			}
			pos += base.transform.forward * -this.maildistance;
			mailind++;
			yield return null;
		}
		if (this.sort_buttonlist)
		{
			this.buttons.Sort((PhoneButton b1, PhoneButton b2) => b2.wantedpos.z.CompareTo(b1.wantedpos.z));
		}
		this.menuind = old_menuind;
		if (this.menuind < 0)
		{
			this.menuind = 0;
		}
		if (this.buttons.Count > this.menuind)
		{
			this.mail_back_button.right_button = this.buttons[this.menuind];
		}
		this.setting_up_mail = false;
		this.UpdateButtonSelected();
		yield break;
	}

	// Token: 0x06000483 RID: 1155 RVA: 0x0001AD38 File Offset: 0x00018F38
	private void ClearMailButtons()
	{
		foreach (PhoneButton phoneButton in this.mailbuttons)
		{
			this.buttons.Remove(phoneButton);
			UnityEngine.Object.Destroy(phoneButton.gameObject);
		}
		this.mailbuttons.Clear();
	}

	// Token: 0x17000099 RID: 153
	// (get) Token: 0x06000484 RID: 1156 RVA: 0x0001ADBC File Offset: 0x00018FBC
	private int mailsize
	{
		get
		{
			return PhoneMemory.messages.Count;
		}
	}

	// Token: 0x06000485 RID: 1157 RVA: 0x0001ADC8 File Offset: 0x00018FC8
	public virtual void NextMail()
	{
		this.mailindex++;
		if (this.mailindex >= this.mailsize)
		{
			this.mailindex = 0;
		}
		this.OpenMail(this.mailindex);
		if (this.nextbut)
		{
			this.nextbut.transform.position -= base.transform.right * 0.15f;
		}
	}

	// Token: 0x06000486 RID: 1158 RVA: 0x0001AE48 File Offset: 0x00019048
	public virtual void PreviousMail()
	{
		this.mailindex--;
		if (this.mailindex < 0)
		{
			this.mailindex = this.mailsize - 1;
		}
		this.OpenMail(this.mailindex);
		if (this.prevbut)
		{
			this.prevbut.transform.position += base.transform.right * 0.15f;
		}
	}

	// Token: 0x06000487 RID: 1159 RVA: 0x0001AECC File Offset: 0x000190CC
	public virtual void OpenMail(string mail_id)
	{
		this.OpenMail(MailController.FindMail(mail_id));
	}

	// Token: 0x06000488 RID: 1160 RVA: 0x0001AEDC File Offset: 0x000190DC
	public virtual void OpenMail(int index)
	{
		this.oldmenuind = this.menuind;
		this.mailindex = index;
		this.OpenMail(PhoneMemory.GetMail(this.mailindex));
	}

	// Token: 0x06000489 RID: 1161 RVA: 0x0001AF10 File Offset: 0x00019110
	protected virtual void OpenMail(PhoneMail mail)
	{
		if (this.zone == PhoneMailMenu.MenuZone.Center && this.mode == PhoneMailMenu.mailmode.inbox)
		{
			this.center_menu_ind = this.menuind;
		}
		this.current_mail = mail;
		this.mode = PhoneMailMenu.mailmode.single;
		this.zone = PhoneMailMenu.MenuZone.Left;
		this.ClearMailButtons();
		if (this.setting_up_mail)
		{
			base.StopCoroutine("Co_SetupMail");
			this.setting_up_mail = false;
		}
		this.mail_subject_label.transform.position = this.spawnpos;
		this.mail_sender_label.transform.localPosition = this.mail_sender_label.wantedpos + base.transform.right * -2f;
		this.mail_text_label.transform.localPosition = this.mail_text_label.wantedpos + base.transform.right * 2f;
		if (this.mail_subject_label)
		{
			this.mail_subject_label.text = mail.subject;
		}
		if (this.mail_sender_label)
		{
			this.mail_sender_label.text = "From: " + mail.sender;
		}
		if (this.mail_text_label)
		{
			this.mail_text_label.text = mail.body;
		}
		this.mail_back_button.textmesh.text = "Close";
		this.mail_back_button.transform.position = this.spawnpos;
		this.mail_back_button.pressed_particles = false;
		if (mail.can_reply)
		{
			this.ShowReplyButton();
			this.mail_reply_button.textmesh.text = mail.accept_button_text;
		}
		else
		{
			this.HideReplyButton();
		}
		this.mail_reply_button.transform.position += base.transform.right * -0.2f;
		if (this.current_mail.can_reply)
		{
			this.buttons.Add(this.mail_reply_button);
			this.mail_back_button.right_button = this.mail_reply_button;
		}
		else
		{
			this.mail_back_button.right_button = null;
		}
		this.mail_title_label.text = string.Empty;
		this.menuind = 0;
		this.UpdateButtonSelected();
		mail.OnOpen();
	}

	// Token: 0x0600048A RID: 1162 RVA: 0x0001B168 File Offset: 0x00019368
	protected virtual void HideReplyButton()
	{
		this.mail_reply_button.renderer.enabled = false;
		if (this.mail_reply_button.background_box)
		{
			this.mail_reply_button.background_box.renderer.enabled = false;
		}
		this.mail_reply_button.OnUnSelected();
		this.mail_reply_button.textmesh.text = string.Empty;
	}

	// Token: 0x0600048B RID: 1163 RVA: 0x0001B1D4 File Offset: 0x000193D4
	protected virtual void ShowReplyButton()
	{
		this.mail_reply_button.renderer.enabled = true;
		if (this.mail_reply_button.background_box)
		{
			this.mail_reply_button.background_box.renderer.enabled = true;
		}
	}

	// Token: 0x0600048C RID: 1164 RVA: 0x0001B220 File Offset: 0x00019420
	protected virtual void CloseMail()
	{
		this.current_mail.OnClose();
		this.mode = PhoneMailMenu.mailmode.inbox;
		if (this.mail_text_label)
		{
			this.mail_text_label.text = string.Empty;
		}
		if (this.mail_sender_label)
		{
			this.mail_sender_label.text = string.Empty;
		}
		if (this.mail_subject_label)
		{
			this.mail_subject_label.text = string.Empty;
		}
		this.HideReplyButton();
		this.buttons.Remove(this.mail_reply_button);
		this.zone = PhoneMailMenu.MenuZone.Center;
		this.current_mail = null;
		this.menuind = this.center_menu_ind;
		if (base.gameObject.active)
		{
			this.SetupMail();
		}
		this.mail_back_button.textmesh.text = this.inbox_exit_text;
		this.mail_back_button.transform.localPosition = this.mail_back_button.wantedpos + Vector3.right * 2f;
		this.mail_back_button.pressed_particles = true;
		Playtomic.Log.CustomMetric("tMessageClosed", "tPhone", true);
	}

	// Token: 0x0600048D RID: 1165 RVA: 0x0001B350 File Offset: 0x00019550
	private bool ReplyToMail()
	{
		bool result = this.current_mail.OnAccept();
		if (this.current_mail.delete_on_reply)
		{
			PhoneMemory.DeleteMail(this.current_mail);
		}
		this.CloseMail();
		Playtomic.Log.CustomMetric("tRepliedToMail", "tPhone", true);
		return result;
	}

	// Token: 0x0600048E RID: 1166 RVA: 0x0001B3A4 File Offset: 0x000195A4
	public override bool ButtonMessage(PhoneButton button, string command)
	{
		if (command == "reply")
		{
			return this.ReplyToMail();
		}
		if (command == "next")
		{
			if (this.mode == PhoneMailMenu.mailmode.single)
			{
				this.NextMail();
			}
		}
		else if (command == "previous")
		{
			if (this.mode == PhoneMailMenu.mailmode.single)
			{
				this.PreviousMail();
			}
		}
		else if (command == "back")
		{
			if (this.mode == PhoneMailMenu.mailmode.inbox)
			{
				this.controller.LoadScreen("Main_Menu");
			}
			else if (this.mode == PhoneMailMenu.mailmode.single)
			{
				this.CloseMail();
			}
		}
		else
		{
			if (!command.StartsWith("openmessage"))
			{
				return base.ButtonMessage(button, command);
			}
			this.spawnpos = button.transform.position;
			int index = this.mailbuttons.IndexOf(button);
			this.OpenMail(index);
			Playtomic.Log.CustomMetric("tOpenedMessage", "tPhone", true);
		}
		return true;
	}

	// Token: 0x0600048F RID: 1167 RVA: 0x0001B4B8 File Offset: 0x000196B8
	public override PhoneButton Button_To(PhoneButton button)
	{
		if (!this.newmail_prefab)
		{
			return button;
		}
		PhoneLabel phoneLabel = UnityEngine.Object.Instantiate(this.newmail_prefab) as PhoneLabel;
		phoneLabel.transform.position = button.transform.position + new Vector3(0.2f, 0.25f, -0.25f);
		phoneLabel.transform.parent = button.button_icon.transform;
		phoneLabel.wantedpos = phoneLabel.transform.localPosition;
		phoneLabel.wantedrot = phoneLabel.transform.localRotation;
		return button;
	}

	// Token: 0x06000490 RID: 1168 RVA: 0x0001B550 File Offset: 0x00019750
	protected override void DoMouseControls()
	{
		base.DoMouseControls();
		this.DoMouseScrolling();
	}

	// Token: 0x06000491 RID: 1169 RVA: 0x0001B560 File Offset: 0x00019760
	protected virtual void DoMouseScrolling()
	{
		Vector3 transformedTouchPoint = PhoneInput.GetTransformedTouchPoint();
		bool flag = PhoneInput.IsPressed() && this.mode != PhoneMailMenu.mailmode.single;
		bool flag2 = PhoneInput.IsPressedDown() && this.mode != PhoneMailMenu.mailmode.single;
		if (flag2)
		{
			this.lastmousepos = transformedTouchPoint;
		}
		if (flag)
		{
			if (this.lastmousepos != Vector3.one * -1f)
			{
				float d = transformedTouchPoint.z - this.lastmousepos.z;
				this.message_holder.transform.position += Vector3.forward * d;
			}
			this.lastmousepos = transformedTouchPoint;
		}
		else
		{
			this.lastmousepos = Vector3.one * -1f;
		}
		float num = Input.GetAxis("Mouse ScrollWheel") * -5f;
		if (num != 0f && this.mode != PhoneMailMenu.mailmode.single)
		{
			this.message_holder.transform.position += Vector3.forward * num;
		}
		Bounds bounds = default(Bounds);
		Bounds bounds2 = base.renderer.bounds;
		bounds2.center -= Vector3.forward * 0.25f;
		bounds2.size -= Vector3.forward * 1f;
		if (this.center_buttons.Count > 0 && this.center_buttons[0].gameObject.active)
		{
			bounds.Encapsulate(this.center_buttons[0].GetBounds());
		}
		if (this.center_buttons.Count > 1 && this.center_buttons[this.center_buttons.Count - 1].gameObject.active)
		{
			bounds.Encapsulate(this.center_buttons[this.center_buttons.Count - 1].GetBounds());
		}
		if (this.center_buttons.Count > 2 && this.center_buttons[this.center_buttons.Count - 2].gameObject.active)
		{
			bounds.Encapsulate(this.center_buttons[this.center_buttons.Count - 2].GetBounds());
		}
		if (bounds.size.z > bounds2.size.z)
		{
			if (bounds.max.z < bounds2.max.z)
			{
				this.message_holder.transform.position += Vector3.forward * (bounds2.max.z - bounds.max.z);
			}
			if (bounds.min.z > bounds2.min.z && bounds.size.z > bounds2.size.z)
			{
				this.message_holder.transform.position += -Vector3.forward * (bounds.min.z - bounds2.min.z);
			}
		}
		else
		{
			if (bounds.max.z > bounds2.max.z)
			{
				this.message_holder.transform.position += Vector3.forward * (bounds2.max.z - bounds.max.z);
			}
			if (bounds.min.z < bounds2.min.z)
			{
				this.message_holder.transform.position += -Vector3.forward * (bounds.min.z - bounds2.min.z);
			}
		}
	}

	// Token: 0x06000492 RID: 1170 RVA: 0x0001B9E0 File Offset: 0x00019BE0
	protected virtual void StickControls_Vertical_Message()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (controlDirPressed.x >= 0.5f)
		{
			this.menuind++;
		}
		else if (controlDirPressed.x <= -0.5f)
		{
			this.menuind--;
		}
		if (this.menuind < 0)
		{
			this.menuind = 0;
		}
		if (this.menuind >= this.current_buttons.Count)
		{
			this.menuind = this.current_buttons.Count - 1;
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x1700009A RID: 154
	// (get) Token: 0x06000493 RID: 1171 RVA: 0x0001BAA8 File Offset: 0x00019CA8
	public virtual List<PhoneButton> center_buttons
	{
		get
		{
			return this.mailbuttons;
		}
	}

	// Token: 0x1700009B RID: 155
	// (get) Token: 0x06000494 RID: 1172 RVA: 0x0001BAB0 File Offset: 0x00019CB0
	public override List<PhoneButton> current_buttons
	{
		get
		{
			if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
			{
				return this.buttons;
			}
			if (this.mode == PhoneMailMenu.mailmode.single)
			{
				return this.buttons;
			}
			if (this.zone == PhoneMailMenu.MenuZone.Left)
			{
				return this.left_buttons;
			}
			if (this.zone == PhoneMailMenu.MenuZone.Center)
			{
				return this.center_buttons;
			}
			if (this.zone == PhoneMailMenu.MenuZone.Right)
			{
				return this.right_buttons;
			}
			return this.buttons;
		}
	}

	// Token: 0x06000495 RID: 1173 RVA: 0x0001BB20 File Offset: 0x00019D20
	protected virtual void StickControls_Vertical_Inbox()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (this.zone == PhoneMailMenu.MenuZone.Left)
		{
			if (controlDirPressed.x >= 0.5f && this.center_buttons.Count > 0)
			{
				int menuind = this.menuind;
				this.zone = PhoneMailMenu.MenuZone.Center;
				this.menuind = this.center_menu_ind;
				this.tempmenuind = menuind;
			}
			else if (controlDirPressed.y >= 0.5f)
			{
				if (this.SwitchToButton(this.current_buttons[this.menuind].up_button))
				{
					this.UpdateButtonSelected();
				}
			}
			else if (controlDirPressed.y <= -0.5f && this.SwitchToButton(this.current_buttons[this.menuind].down_button))
			{
				this.UpdateButtonSelected();
			}
		}
		else if (this.zone == PhoneMailMenu.MenuZone.Center)
		{
			if (controlDirPressed.x <= -0.5f && this.left_buttons.Count > 0)
			{
				int menuind2 = this.menuind;
				this.zone = PhoneMailMenu.MenuZone.Left;
				this.menuind = 0;
				this.tempmenuind = menuind2;
			}
			else if (controlDirPressed.x >= 0.5f && this.right_buttons.Count > 0)
			{
				int menuind3 = this.menuind;
				this.zone = PhoneMailMenu.MenuZone.Right;
				this.menuind = this.tempmenuind;
				this.tempmenuind = menuind3;
			}
		}
		else if (this.zone == PhoneMailMenu.MenuZone.Right && controlDirPressed.x <= -0.5f && this.center_buttons.Count > 0)
		{
			int menuind4 = this.menuind;
			this.zone = PhoneMailMenu.MenuZone.Center;
			this.menuind = this.tempmenuind;
			this.tempmenuind = menuind4;
			this.menuind = this.center_menu_ind;
		}
		this.menuind = Mathf.Clamp(this.menuind, 0, this.current_buttons.Count - 1);
		if (this.zone == PhoneMailMenu.MenuZone.Center)
		{
			this.center_menu_ind = this.menuind;
		}
		if (controlDirPressed.y >= 0.5f)
		{
			if (this.current_buttons[this.menuind].up_button)
			{
				this.menuind = this.current_buttons.IndexOf(this.current_buttons[this.menuind].up_button);
			}
		}
		else if (controlDirPressed.y <= -0.5f && this.current_buttons[this.menuind].down_button)
		{
			this.menuind = this.current_buttons.IndexOf(this.current_buttons[this.menuind].down_button);
		}
		this.menuind = Mathf.Clamp(this.menuind, 0, this.current_buttons.Count - 1);
		if (this.zone == PhoneMailMenu.MenuZone.Center && this.menuind >= 0)
		{
			Bounds bounds = base.renderer.bounds;
			Vector3 size = bounds.size;
			size.z *= 0.9f;
			bounds.size = size;
			Vector3 max = bounds.max;
			max.z -= 0.3f;
			bounds.max = max;
			PhoneButton phoneButton = this.current_buttons[this.menuind];
			Vector3 center = phoneButton.GetCenter();
			center.z = phoneButton.GetBounds().max.z;
			center.y = bounds.center.y;
			Vector3 point = center * 1f;
			point.z = phoneButton.GetBounds().min.z;
			bool flag = !phoneButton.animateOnLoad || phoneButton.transform.localPosition == phoneButton.wantedpos;
			if (!flag && Vector3.Distance(phoneButton.transform.localPosition, phoneButton.wantedpos) <= 0.01f)
			{
				flag = true;
				phoneButton.transform.localPosition = phoneButton.wantedpos;
			}
			if (flag)
			{
				if (!bounds.Contains(center) && center.z > base.transform.position.z)
				{
					this.message_holder.transform.localPosition += Vector3.forward * base.deltatime * -1f * Mathf.Abs(center.z - base.transform.position.z) / 5f;
				}
				else if (!bounds.Contains(point) && point.z < base.transform.position.z)
				{
					this.message_holder.transform.localPosition += Vector3.forward * base.deltatime * 1f * Mathf.Abs(point.z - base.transform.position.z) / 5f;
				}
			}
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind && this.menuind >= 0)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x06000496 RID: 1174 RVA: 0x0001C0CC File Offset: 0x0001A2CC
	protected override void StickControls_Vertical()
	{
		if (this.mode == PhoneMailMenu.mailmode.single)
		{
			this.StickControls_Vertical_Message();
		}
		else
		{
			this.StickControls_Vertical_Inbox();
		}
	}

	// Token: 0x06000497 RID: 1175 RVA: 0x0001C0EC File Offset: 0x0001A2EC
	protected override void UpdateButtonSelected()
	{
		for (int i = 0; i < this.buttons.Count; i++)
		{
			bool flag = false;
			if (this.menuind < this.current_buttons.Count && this.menuind >= 0 && this.current_buttons[this.menuind] == this.buttons[i])
			{
				flag = true;
			}
			this.buttons[i].selected = flag;
			if (flag)
			{
				this.buttons[i].OnSelected();
				this.SetMenuLines(this.buttons[i]);
			}
		}
	}

	// Token: 0x04000377 RID: 887
	public PhoneLabel mail_text_label;

	// Token: 0x04000378 RID: 888
	public PhoneLabel mail_subject_label;

	// Token: 0x04000379 RID: 889
	public PhoneLabel mail_sender_label;

	// Token: 0x0400037A RID: 890
	public PhoneLabel mail_title_label;

	// Token: 0x0400037B RID: 891
	public PhoneButton mail_back_button;

	// Token: 0x0400037C RID: 892
	public PhoneButton mail_reply_button;

	// Token: 0x0400037D RID: 893
	public PhoneButton nextbut;

	// Token: 0x0400037E RID: 894
	public PhoneButton prevbut;

	// Token: 0x0400037F RID: 895
	public Transform message_holder;

	// Token: 0x04000380 RID: 896
	private Vector3 message_holder_offset;

	// Token: 0x04000381 RID: 897
	private PhoneMailMenu.MenuZone oldzone;

	// Token: 0x04000382 RID: 898
	public List<PhoneButton> mailbuttons = new List<PhoneButton>();

	// Token: 0x04000383 RID: 899
	public float maildistance = 0.5f;

	// Token: 0x04000384 RID: 900
	public float mailxpos = -1.8f;

	// Token: 0x04000385 RID: 901
	public bool space_by_bounds;

	// Token: 0x04000386 RID: 902
	public bool setting_up_mail;

	// Token: 0x04000387 RID: 903
	protected Bounds mail_bounds = default(Bounds);

	// Token: 0x04000388 RID: 904
	public float first_mail_forward_pos = 3f;

	// Token: 0x04000389 RID: 905
	public string inbox_exit_text = "E\nx\ni\nt\n\nM\na\ni\nl";

	// Token: 0x0400038A RID: 906
	protected PhoneMailMenu.mailmode mode;

	// Token: 0x0400038B RID: 907
	public PhoneMail current_mail;

	// Token: 0x0400038C RID: 908
	protected int mailindex;

	// Token: 0x0400038D RID: 909
	protected int oldmenuind;

	// Token: 0x0400038E RID: 910
	protected int center_menu_ind;

	// Token: 0x0400038F RID: 911
	private Vector3 spawnpos;

	// Token: 0x04000390 RID: 912
	public PhoneLabel newmail_prefab;

	// Token: 0x04000391 RID: 913
	private Vector3 lastmousepos = Vector3.one * -1f;

	// Token: 0x04000392 RID: 914
	protected PhoneMailMenu.MenuZone zone = PhoneMailMenu.MenuZone.Center;

	// Token: 0x04000393 RID: 915
	public List<PhoneButton> left_buttons;

	// Token: 0x04000394 RID: 916
	public List<PhoneButton> right_buttons;

	// Token: 0x04000395 RID: 917
	private int tempmenuind;

	// Token: 0x0200006E RID: 110
	protected enum mailmode
	{
		// Token: 0x04000397 RID: 919
		inbox,
		// Token: 0x04000398 RID: 920
		single
	}

	// Token: 0x0200006F RID: 111
	protected class Zone
	{
		// Token: 0x06000499 RID: 1177 RVA: 0x0001C1BC File Offset: 0x0001A3BC
		public virtual void StickControls()
		{
			Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
			if (this.vertical)
			{
				if (controlDirPressed.y >= 0.5f)
				{
					this.menuind--;
				}
				if (controlDirPressed.y <= -0.5f)
				{
					this.menuind++;
				}
				this.DoWrapping();
			}
		}

		// Token: 0x0600049A RID: 1178 RVA: 0x0001C220 File Offset: 0x0001A420
		private void DoWrapping()
		{
			if (this.wrap)
			{
				if (this.menuind < 0)
				{
					this.menuind = this.buttons.Count - 1;
				}
				else if (this.menuind >= this.buttons.Count)
				{
					this.menuind = 0;
				}
			}
			else
			{
				this.menuind = Mathf.Clamp(this.menuind, 0, this.buttons.Count - 1);
			}
		}

		// Token: 0x04000399 RID: 921
		public List<PhoneButton> buttons = new List<PhoneButton>();

		// Token: 0x0400039A RID: 922
		public int menuind;

		// Token: 0x0400039B RID: 923
		public bool vertical = true;

		// Token: 0x0400039C RID: 924
		public bool horizontal;

		// Token: 0x0400039D RID: 925
		public bool wrap;

		// Token: 0x0400039E RID: 926
		public PhoneMailMenu.Zone left_zone;

		// Token: 0x0400039F RID: 927
		public PhoneMailMenu.Zone right_zone;

		// Token: 0x040003A0 RID: 928
		public PhoneMailMenu.Zone up_zone;

		// Token: 0x040003A1 RID: 929
		public PhoneMailMenu.Zone down_zone;
	}

	// Token: 0x02000070 RID: 112
	protected enum MenuZone
	{
		// Token: 0x040003A3 RID: 931
		Left,
		// Token: 0x040003A4 RID: 932
		Center,
		// Token: 0x040003A5 RID: 933
		Right,
		// Token: 0x040003A6 RID: 934
		Message
	}
}
