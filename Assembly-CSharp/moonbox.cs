using System;
using UnityEngine;

// Token: 0x0200002C RID: 44
public class moonbox : MonoBehaviour
{
	// Token: 0x06000130 RID: 304 RVA: 0x000096CC File Offset: 0x000078CC
	private void Start()
	{
	}

	// Token: 0x06000131 RID: 305 RVA: 0x000096D0 File Offset: 0x000078D0
	private void OnCollisionEnter(Collision obj)
	{
		if (obj.gameObject.name == "Player" && this.once)
		{
			this.once = false;
			MailController.SendMail(this.mail);
		}
	}

	// Token: 0x04000182 RID: 386
	public PhoneMail mail;

	// Token: 0x04000183 RID: 387
	private bool once = true;
}
