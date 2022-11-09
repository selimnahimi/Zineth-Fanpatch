using System;
using UnityEngine;

// Token: 0x0200002D RID: 45
public class NPCBehavior : MonoBehaviour
{
	// Token: 0x06000134 RID: 308 RVA: 0x0000980C File Offset: 0x00007A0C
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000135 RID: 309 RVA: 0x00009814 File Offset: 0x00007A14
	public void Init()
	{
		this.originalPosition = base.transform.position;
		this.originalRotation = base.transform.rotation;
		if (this.npc_name == string.Empty)
		{
			if (base.name.StartsWith("NPC_Trainer_"))
			{
				this.npc_name = base.name.Replace("NPC_Trainer_", NPCBehavior.RandomNamePart() + " ");
			}
			else
			{
				this.npc_name = NPCBehavior.RandomName();
			}
		}
		if (this.sendMessageOnFall2)
		{
			if (this.newmail.body == string.Empty)
			{
				this.newmail = NPCBehavior.RandomFallMail(this.newmail);
			}
			if (this.newmail.id == string.Empty)
			{
				this.newmail.id = "npc_" + base.GetInstanceID();
			}
			if (this.newmail.sender == string.Empty)
			{
				this.newmail.sender = this.npc_name;
			}
			MailController.AddMail(this.newmail);
		}
		if (base.animation)
		{
			foreach (object obj in base.animation)
			{
				AnimationState animationState = (AnimationState)obj;
				animationState.speed = 0f;
			}
		}
	}

	// Token: 0x06000136 RID: 310 RVA: 0x000099C0 File Offset: 0x00007BC0
	public static PhoneMail RandomFallMail(PhoneMail mail)
	{
		string text = NPCBehavior.fallmail[UnityEngine.Random.Range(0, NPCBehavior.fallmail.Length)];
		text = text.Replace("{l}", ((char)(97 + UnityEngine.Random.Range(0, 26))).ToString());
		string[] array = text.Split(new char[]
		{
			'|'
		});
		mail.subject = array[0];
		mail.body = array[1];
		return mail;
	}

	// Token: 0x06000137 RID: 311 RVA: 0x00009A28 File Offset: 0x00007C28
	public static string RandomNamePart()
	{
		return MonsterTraits.Name.createFirstName();
	}

	// Token: 0x06000138 RID: 312 RVA: 0x00009A30 File Offset: 0x00007C30
	public static string RandomName()
	{
		return MonsterTraits.Name.createFullName();
	}

	// Token: 0x06000139 RID: 313 RVA: 0x00009A38 File Offset: 0x00007C38
	public void ShowBubble()
	{
		this.SetBubbleVisible(true);
	}

	// Token: 0x0600013A RID: 314 RVA: 0x00009A44 File Offset: 0x00007C44
	public void HideBubble()
	{
		this.SetBubbleVisible(false);
	}

	// Token: 0x0600013B RID: 315 RVA: 0x00009A50 File Offset: 0x00007C50
	public void SetBubbleVisible(bool isvis)
	{
		if (this.icon_bubble && this.icon_bubble.gameObject.active != isvis)
		{
			this.icon_bubble.gameObject.active = isvis;
		}
	}

	// Token: 0x0600013C RID: 316 RVA: 0x00009A94 File Offset: 0x00007C94
	public virtual void SetBubbleTexture(Texture2D tex)
	{
		if (this.icon_bubble)
		{
			this.icon_bubble.renderer.material.mainTexture = tex;
		}
	}

	// Token: 0x0600013D RID: 317 RVA: 0x00009AC8 File Offset: 0x00007CC8
	private void FixedUpdate()
	{
		float num = Mathf.Abs(base.transform.up.y);
		if (num <= this.rotationMin)
		{
			this.fallenOver = true;
		}
		if (this.fallenOver)
		{
			float num2 = Vector3.Distance(base.transform.position, GameObject.Find("Player").transform.position);
			if (num2 >= this.resetDistance)
			{
				this.Reset();
			}
			if (!this.messageSent)
			{
				this.SendFallMail(UnityEngine.Random.Range(0.5f, 4f));
			}
			if (!this.justFell)
			{
				this.JustFell();
			}
		}
	}

	// Token: 0x0600013E RID: 318 RVA: 0x00009B74 File Offset: 0x00007D74
	private void Reset()
	{
		base.transform.position = this.originalPosition;
		base.transform.rotation = this.originalRotation;
		this.fallenOver = false;
		this.justFell = false;
	}

	// Token: 0x0600013F RID: 319 RVA: 0x00009BB4 File Offset: 0x00007DB4
	private void JustFell()
	{
		this.justFell = true;
	}

	// Token: 0x06000140 RID: 320 RVA: 0x00009BC0 File Offset: 0x00007DC0
	protected void SendFallMail()
	{
		this.messageSent = true;
		if (this.sendMessageOnFall2)
		{
			MailController.SendMail(this.newmail);
		}
	}

	// Token: 0x06000141 RID: 321 RVA: 0x00009BE0 File Offset: 0x00007DE0
	private void SendFallMail(float time)
	{
		this.messageSent = true;
		base.Invoke("SendFallMail", time);
	}

	// Token: 0x04000184 RID: 388
	public string npc_name;

	// Token: 0x04000185 RID: 389
	public Transform icon_bubble;

	// Token: 0x04000186 RID: 390
	public bool sendMessageOnFall2 = true;

	// Token: 0x04000187 RID: 391
	public PhoneMail newmail;

	// Token: 0x04000188 RID: 392
	private float resetDistance = 500f;

	// Token: 0x04000189 RID: 393
	private float rotationMin = 0.5f;

	// Token: 0x0400018A RID: 394
	private bool fallenOver;

	// Token: 0x0400018B RID: 395
	private bool messageSent;

	// Token: 0x0400018C RID: 396
	private bool justFell;

	// Token: 0x0400018D RID: 397
	private Vector3 originalPosition = new Vector3(0f, 0f, 0f);

	// Token: 0x0400018E RID: 398
	private Quaternion originalRotation = new Quaternion(0f, 0f, 0f, 0f);

	// Token: 0x0400018F RID: 399
	private static readonly string[] fallmail = new string[]
	{
		"Hey!|You jerk! Watch where you're going!",
		"CHEATER!!|trying to mess up my game by knocking me over? might work if I wasn't SUPER PRO at this anyway SCREW YOU",
		"wtf???|Are you the one with that weird skating machine? Learn to steer it before you ride it around normal people!",
		"please be careful!|I think you knocked me down! could you maybe not do that? :(",
		"HEY JERKASS|NICE DRIVING, ALSO THAT WAS SARCASM",
		"whoa man|watch it man like slow down jeez",
		"excuse me??|If your gonna bump into me like that you could at least apologize???",
		"so cool!|hey u prolly don't remember me but you sort of ran me over with your mech? but its cool i never saw a machine like that before!! ^^",
		"RUDE|hitting people with your robot: rude!",
		"hit and run|I should report you for running into me! but who wants to deal with filing reports... you're getting lucky here!",
		"crazy machine|What the hell is that thing you're driving around and do you need a license to drive it? cause if you do YOU SHOULD HAVE YOURS REVOKED hint hint",
		"{l}*** YOU|I JUST GOT A NEW PHONE AND YOU WRECKED THE SCREEN WITH YOUR STUPID ROBOT i hope you CRASH >:(",
		"warning|no one told me a big mech was going to be rolling around and knocking people over  : /"
	};
}
