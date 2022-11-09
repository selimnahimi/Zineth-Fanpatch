using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007B RID: 123
public class PhonePlayerListMenu : PhoneTwitterMenu
{
	// Token: 0x06000512 RID: 1298 RVA: 0x0001FF34 File Offset: 0x0001E134
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

	// Token: 0x06000513 RID: 1299 RVA: 0x0001FFAC File Offset: 0x0001E1AC
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

	// Token: 0x06000514 RID: 1300 RVA: 0x00020168 File Offset: 0x0001E368
	public override bool RefreshTwitter()
	{
		return true;
	}

	// Token: 0x06000515 RID: 1301 RVA: 0x0002016C File Offset: 0x0001E36C
	protected override bool CheckUpdates()
	{
		if (Networking.instance && Networking.netplayer_dic.Count != this.numPlayers && this.mode == PhoneMailMenu.mailmode.inbox)
		{
			this.numPlayers = Networking.netplayer_dic.Count;
			this.SetupMail();
			return true;
		}
		return false;
	}

	// Token: 0x06000516 RID: 1302 RVA: 0x000201C4 File Offset: 0x0001E3C4
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

	// Token: 0x170000A9 RID: 169
	// (get) Token: 0x06000517 RID: 1303 RVA: 0x00020214 File Offset: 0x0001E414
	protected override List<PhoneMail> mail_list
	{
		get
		{
			return this.player_list;
		}
	}

	// Token: 0x06000518 RID: 1304 RVA: 0x0002021C File Offset: 0x0001E41C
	public static PhoneMail NetPlayerToMail(NetPlayer player)
	{
		return new PhoneMail
		{
			subject = player.userName
		};
	}

	// Token: 0x06000519 RID: 1305 RVA: 0x0002023C File Offset: 0x0001E43C
	public override void OpenMail(int index)
	{
		this.mailindex = index;
		this.OpenMail(this.mail_list[index]);
	}

	// Token: 0x0600051A RID: 1306 RVA: 0x00020258 File Offset: 0x0001E458
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

	// Token: 0x170000AA RID: 170
	// (get) Token: 0x0600051B RID: 1307 RVA: 0x00020310 File Offset: 0x0001E510
	public override List<PhoneButton> center_buttons
	{
		get
		{
			return this.mailbuttons;
		}
	}

	// Token: 0x040003FE RID: 1022
	public int numPlayers;

	// Token: 0x040003FF RID: 1023
	public List<PhoneMail> player_list;
}
