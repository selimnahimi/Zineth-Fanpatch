using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000071 RID: 113
public class PhoneMailMenuNEW : PhoneTwitterMenu
{
	// Token: 0x0600049C RID: 1180 RVA: 0x0001C2A8 File Offset: 0x0001A4A8
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
		if (this.mail_back_button == null)
		{
			this.mail_back_button = base.transform.FindChild("MailBackButton").GetComponent<PhoneButton>();
		}
		if (this.message_holder == null)
		{
			this.message_holder = base.transform.FindChild("MessageHolder").transform;
		}
	}

	// Token: 0x0600049D RID: 1181 RVA: 0x0001C320 File Offset: 0x0001A520
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.LoadAnimationCancel();
		if (this.zone != PhoneMailMenu.MenuZone.Center && this.center_buttons.Count > 0)
		{
			this.zone = PhoneMailMenu.MenuZone.Center;
		}
		if (this.mode == PhoneMailMenu.mailmode.single)
		{
			this.CloseMail();
		}
		this.RefreshTwitter();
		if (this.CheckUpdates())
		{
			this.RefreshList();
		}
		if (this.new_tweets_button)
		{
			this.new_tweets_button.gameObject.SetActiveRecursively(false);
		}
		if (this.single_message_holder)
		{
			this.single_message_holder.gameObject.SetActiveRecursively(false);
		}
		foreach (PhoneButton phoneButton in this.left_buttons)
		{
			phoneButton.OnLoad();
		}
		foreach (PhoneButton phoneButton2 in this.center_buttons)
		{
			phoneButton2.OnLoad();
		}
		foreach (PhoneButton phoneButton3 in this.right_buttons)
		{
			phoneButton3.OnLoad();
		}
		this.UpdateButtonSelected();
	}

	// Token: 0x0600049E RID: 1182 RVA: 0x0001C4DC File Offset: 0x0001A6DC
	public override bool RefreshTwitter()
	{
		return true;
	}

	// Token: 0x0600049F RID: 1183 RVA: 0x0001C4E0 File Offset: 0x0001A6E0
	protected override bool CheckUpdates()
	{
		if (PhoneMemory.mail_updated && this.mode == PhoneMailMenu.mailmode.inbox)
		{
			this.SetupMail();
			PhoneMemory.mail_updated = false;
			return true;
		}
		return false;
	}

	// Token: 0x060004A0 RID: 1184 RVA: 0x0001C514 File Offset: 0x0001A714
	protected new virtual bool RefreshList()
	{
		PhoneMemory.mail_updated = false;
		this.menuind = 0;
		this.SetupMail();
		Vector3 localPosition = this.message_holder.transform.localPosition;
		localPosition.z = 0f;
		this.message_holder.transform.localPosition = localPosition;
		return true;
	}

	// Token: 0x1700009C RID: 156
	// (get) Token: 0x060004A1 RID: 1185 RVA: 0x0001C564 File Offset: 0x0001A764
	protected override List<PhoneMail> mail_list
	{
		get
		{
			return PhoneMemory.messages;
		}
	}

	// Token: 0x060004A2 RID: 1186 RVA: 0x0001C56C File Offset: 0x0001A76C
	public override void OpenMail(int index)
	{
		this.mailindex = index;
		this.OpenMail(this.mail_list[index]);
	}

	// Token: 0x060004A3 RID: 1187 RVA: 0x0001C588 File Offset: 0x0001A788
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "close")
		{
			this.CloseMail();
		}
		else
		{
			if (message == "reply")
			{
				return false;
			}
			if (message == "post_tweet")
			{
				return false;
			}
			if (message == "get_mentions")
			{
				return false;
			}
			if (message == "get_timeline")
			{
				return false;
			}
			if (message.StartsWith("openmessage"))
			{
				this.OpenMail(button.id_info);
			}
			else
			{
				if (!(message == "refresh"))
				{
					return base.ButtonMessage(button, message);
				}
				this.RefreshList();
			}
		}
		return true;
	}

	// Token: 0x1700009D RID: 157
	// (get) Token: 0x060004A4 RID: 1188 RVA: 0x0001C640 File Offset: 0x0001A840
	public override List<PhoneButton> center_buttons
	{
		get
		{
			return this.mailbuttons;
		}
	}
}
