using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000045 RID: 69
[Serializable]
public class PhoneMail
{
	// Token: 0x06000275 RID: 629 RVA: 0x00010D10 File Offset: 0x0000EF10
	public PhoneMail()
	{
	}

	// Token: 0x06000276 RID: 630 RVA: 0x00010DA0 File Offset: 0x0000EFA0
	public PhoneMail(string id_text)
	{
		this.id = id_text;
	}

	// Token: 0x06000277 RID: 631 RVA: 0x00010E34 File Offset: 0x0000F034
	public PhoneMail(string id_text, string body_text)
	{
		this.id = id_text;
		this.body = body_text;
	}

	// Token: 0x06000278 RID: 632 RVA: 0x00010ED0 File Offset: 0x0000F0D0
	public PhoneMail(string id_text, string subject_text, string body_text, string sender_text)
	{
		this.id = id_text;
		this.subject = subject_text;
		this.body = body_text;
		this.sender = sender_text;
	}

	// Token: 0x06000279 RID: 633 RVA: 0x00010F7C File Offset: 0x0000F17C
	public PhoneMail(string id_text, string subject_text, string body_text, string sender_text, bool replyable)
	{
		this.id = id_text;
		this.subject = subject_text;
		this.body = body_text;
		this.sender = sender_text;
		this.can_reply = replyable;
	}

	// Token: 0x0600027A RID: 634 RVA: 0x00011030 File Offset: 0x0000F230
	public virtual bool OnOpen()
	{
		if (this.is_new)
		{
			this.is_new = false;
			PhoneMemory.SaveMail();
			if (this.open_command != string.Empty)
			{
				return PhoneController.DoPhoneCommand(this.open_command);
			}
		}
		return true;
	}

	// Token: 0x0600027B RID: 635 RVA: 0x0001106C File Offset: 0x0000F26C
	public virtual bool OnClose()
	{
		return !(this.close_command != string.Empty) || PhoneController.DoPhoneCommand(this.close_command);
	}

	// Token: 0x0600027C RID: 636 RVA: 0x0001109C File Offset: 0x0000F29C
	public virtual bool OnAccept()
	{
		return !(this.accept_command != string.Empty) || PhoneController.DoPhoneCommand(this.accept_command);
	}

	// Token: 0x0600027D RID: 637 RVA: 0x000110CC File Offset: 0x0000F2CC
	public virtual bool OnReject()
	{
		return true;
	}

	// Token: 0x04000241 RID: 577
	public string id;

	// Token: 0x04000242 RID: 578
	public string sender;

	// Token: 0x04000243 RID: 579
	public string subject;

	// Token: 0x04000244 RID: 580
	public string body;

	// Token: 0x04000245 RID: 581
	[HideInInspector]
	public ulong id_number;

	// Token: 0x04000246 RID: 582
	public string image_url = string.Empty;

	// Token: 0x04000247 RID: 583
	public string accept_command = string.Empty;

	// Token: 0x04000248 RID: 584
	public string open_command = string.Empty;

	// Token: 0x04000249 RID: 585
	public string close_command = string.Empty;

	// Token: 0x0400024A RID: 586
	public bool can_delete = true;

	// Token: 0x0400024B RID: 587
	public bool can_reply;

	// Token: 0x0400024C RID: 588
	public string accept_button_text = "Reply";

	// Token: 0x0400024D RID: 589
	public bool delete_on_reply = true;

	// Token: 0x0400024E RID: 590
	public bool is_new = true;

	// Token: 0x0400024F RID: 591
	public Vector3 position = Vector3.zero;

	// Token: 0x04000250 RID: 592
	public DateTime time = new DateTime(0L);

	// Token: 0x04000251 RID: 593
	public List<string> media_urls = new List<string>();

	// Token: 0x04000252 RID: 594
	public List<string> link_urls = new List<string>();
}
