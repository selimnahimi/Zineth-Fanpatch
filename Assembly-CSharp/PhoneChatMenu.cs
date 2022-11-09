using System;
using UnityEngine;

// Token: 0x02000064 RID: 100
public class PhoneChatMenu : PhoneMainMenu
{
	// Token: 0x0600042D RID: 1069 RVA: 0x00019254 File Offset: 0x00017454
	public void SetText(string txt)
	{
		if (this.text_label.text != txt)
		{
			this.text_label.text = txt;
		}
	}

	// Token: 0x0600042E RID: 1070 RVA: 0x00019284 File Offset: 0x00017484
	public void AddEntry(string txt)
	{
		string text = this.text_label.text;
		if (text.Length > 0)
		{
			text += "\n";
		}
		text += txt;
		this.text_label.text = text;
		this.lastmessage = txt;
	}

	// Token: 0x0600042F RID: 1071 RVA: 0x000192D0 File Offset: 0x000174D0
	private void Awake()
	{
		this.Init();
		this.SetupChat();
	}

	// Token: 0x06000430 RID: 1072 RVA: 0x000192E0 File Offset: 0x000174E0
	public override void UpdateScreen()
	{
		base.UpdateScreen();
		this.UpdateChat();
	}

	// Token: 0x06000431 RID: 1073 RVA: 0x000192F0 File Offset: 0x000174F0
	private void SetupChat()
	{
		if (this.use_network_chat && Networking.chat_log != null)
		{
			this.SetText(string.Empty);
			for (int i = Mathf.Max(0, Networking.chat_log.Count - this.chat_limit); i < Networking.chat_log.Count; i++)
			{
				string txt = Networking.chat_log[i];
				this.AddEntry(txt);
			}
		}
	}

	// Token: 0x06000432 RID: 1074 RVA: 0x00019364 File Offset: 0x00017564
	private void UpdateChat()
	{
		if (this.use_network_chat && Networking.chat_log != null && Networking.chat_log.Count > 0 && this.lastmessage != Networking.chat_log[Networking.chat_log.Count - 1])
		{
			this.SetupChat();
		}
	}

	// Token: 0x06000433 RID: 1075 RVA: 0x000193C4 File Offset: 0x000175C4
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "post_chat")
		{
			if (button.id_info != string.Empty)
			{
				if (Networking.instance && Networking.my_net_player != null)
				{
					Networking.instance.SendChatMessage(button.id_info);
				}
				else
				{
					this.AddEntry(button.id_info);
				}
				if (this.text_input)
				{
					this.text_input.input_text = string.Empty;
				}
			}
			return true;
		}
		if (!message.StartsWith("dart"))
		{
			return base.ButtonMessage(button, message);
		}
		if (message == "dart_search")
		{
			DArtControl.SearchAndGrab(button.id_info);
			DArtControl.instance.indx = 0;
			return true;
		}
		if (message == "dart_next")
		{
			DArtControl.instance.indx = Mathf.Clamp(DArtControl.instance.indx, 0, DArtControl.url_list.Count - 1);
			DArtControl.instance.indx++;
			if (DArtControl.instance.indx >= DArtControl.url_list.Count)
			{
				DArtControl.instance.indx = 0;
			}
			DArtControl.instance.ShowDart();
		}
		else if (message == "dart_prev")
		{
			DArtControl.instance.indx = Mathf.Clamp(DArtControl.instance.indx, 0, DArtControl.url_list.Count - 1);
			DArtControl.instance.indx--;
			if (DArtControl.instance.indx < 0)
			{
				DArtControl.instance.indx = DArtControl.url_list.Count - 1;
			}
			DArtControl.instance.ShowDart();
		}
		return true;
	}

	// Token: 0x0400034F RID: 847
	public PhoneLabel text_label;

	// Token: 0x04000350 RID: 848
	public PhoneTextInput text_input;

	// Token: 0x04000351 RID: 849
	private string lastmessage = string.Empty;

	// Token: 0x04000352 RID: 850
	public bool use_network_chat = true;

	// Token: 0x04000353 RID: 851
	private int chat_limit = 14;
}
