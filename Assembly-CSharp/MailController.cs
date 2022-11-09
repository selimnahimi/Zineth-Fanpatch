using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000044 RID: 68
public class MailController : MonoBehaviour
{
	// Token: 0x17000047 RID: 71
	// (get) Token: 0x06000268 RID: 616 RVA: 0x00010B28 File Offset: 0x0000ED28
	public static List<PhoneMail> active_mail
	{
		get
		{
			return PhoneMemory.messages;
		}
	}

	// Token: 0x17000048 RID: 72
	// (get) Token: 0x06000269 RID: 617 RVA: 0x00010B30 File Offset: 0x0000ED30
	public static List<PhoneMail> deleted_mail
	{
		get
		{
			return PhoneMemory.deleted_messages;
		}
	}

	// Token: 0x0600026A RID: 618 RVA: 0x00010B38 File Offset: 0x0000ED38
	private void Awake()
	{
	}

	// Token: 0x17000049 RID: 73
	// (get) Token: 0x0600026B RID: 619 RVA: 0x00010B3C File Offset: 0x0000ED3C
	public static MailController instance
	{
		get
		{
			if (!MailController._instance)
			{
				MailController._instance = (UnityEngine.Object.FindObjectOfType(typeof(MailController)) as MailController);
			}
			return MailController._instance;
		}
	}

	// Token: 0x0600026C RID: 620 RVA: 0x00010B6C File Offset: 0x0000ED6C
	public static PhoneMail FindMail(string mailid)
	{
		if (mailid.StartsWith("tw_"))
		{
			return MailController.FindTweet(mailid);
		}
		if (!MailController.all_mail.ContainsKey(mailid))
		{
			return null;
		}
		return MailController.all_mail[mailid];
	}

	// Token: 0x0600026D RID: 621 RVA: 0x00010BB0 File Offset: 0x0000EDB0
	public static PhoneMail FindTweet(string mailid)
	{
		if (!MailController.all_tweets.ContainsKey(mailid))
		{
			return null;
		}
		return MailController.all_tweets[mailid];
	}

	// Token: 0x0600026E RID: 622 RVA: 0x00010BD0 File Offset: 0x0000EDD0
	public static void AddMail(PhoneMail mailobj)
	{
		if (mailobj.id.StartsWith("tw_") && !MailController.all_tweets.ContainsKey(mailobj.id))
		{
			MailController.all_tweets.Add(mailobj.id, mailobj);
		}
		if (!MailController.all_mail.ContainsKey(mailobj.id))
		{
			MailController.all_mail.Add(mailobj.id, mailobj);
		}
	}

	// Token: 0x0600026F RID: 623 RVA: 0x00010C40 File Offset: 0x0000EE40
	public static bool SendMailQuiet(string mailid)
	{
		return MailController.SendMailQuiet(MailController.FindMail(mailid));
	}

	// Token: 0x06000270 RID: 624 RVA: 0x00010C50 File Offset: 0x0000EE50
	public static bool SendMailQuiet(PhoneMail mailobj)
	{
		if (mailobj == null)
		{
			return false;
		}
		if (!MailController.all_mail.ContainsKey(mailobj.id))
		{
			MailController.AddMail(mailobj);
		}
		PhoneMemory.SendMailQuiet(mailobj);
		return true;
	}

	// Token: 0x06000271 RID: 625 RVA: 0x00010C88 File Offset: 0x0000EE88
	public static bool SendMail(string mailid)
	{
		return MailController.SendMail(MailController.FindMail(mailid));
	}

	// Token: 0x06000272 RID: 626 RVA: 0x00010C98 File Offset: 0x0000EE98
	public static bool SendMail(PhoneMail mailobj)
	{
		if (mailobj == null)
		{
			return false;
		}
		if (!MailController.all_mail.ContainsKey(mailobj.id))
		{
			MailController.AddMail(mailobj);
		}
		PhoneMemory.SendMail(mailobj);
		return true;
	}

	// Token: 0x06000273 RID: 627 RVA: 0x00010CD0 File Offset: 0x0000EED0
	public static bool DeleteMail(string mailid)
	{
		return MailController.DeleteMail(MailController.FindMail(mailid));
	}

	// Token: 0x06000274 RID: 628 RVA: 0x00010CE0 File Offset: 0x0000EEE0
	public static bool DeleteMail(PhoneMail mailobj)
	{
		if (mailobj == null)
		{
			return false;
		}
		if (!MailController.all_mail.ContainsKey(mailobj.id))
		{
			MailController.AddMail(mailobj);
		}
		PhoneMemory.DeleteMail(mailobj);
		return true;
	}

	// Token: 0x0400023D RID: 573
	public static bool refresh = false;

	// Token: 0x0400023E RID: 574
	public static Dictionary<string, PhoneMail> all_mail = new Dictionary<string, PhoneMail>();

	// Token: 0x0400023F RID: 575
	public static Dictionary<string, PhoneMail> all_tweets = new Dictionary<string, PhoneMail>();

	// Token: 0x04000240 RID: 576
	private static MailController _instance;
}
