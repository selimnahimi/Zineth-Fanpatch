using System;
using UnityEngine;

// Token: 0x0200005E RID: 94
public class PhoneButtonBgColor : PhoneButton
{
	// Token: 0x060003F6 RID: 1014 RVA: 0x00017E60 File Offset: 0x00016060
	private void Awake()
	{
		if (this.textmesh == null)
		{
			this.textmesh = base.gameObject.GetComponent<TextMesh>();
		}
		if (this.controller == null)
		{
			this.controller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneController)) as PhoneController);
		}
		this.Init();
	}

	// Token: 0x060003F7 RID: 1015 RVA: 0x00017EC0 File Offset: 0x000160C0
	private void Start()
	{
		if (this.colors.Length == 0)
		{
			this.colors[0] = this.controller.backcolor;
		}
	}

	// Token: 0x060003F8 RID: 1016 RVA: 0x00017EEC File Offset: 0x000160EC
	public override void OnPressed()
	{
		this.ind++;
		if (this.ind >= this.colors.Length)
		{
			this.ind = 0;
		}
	}

	// Token: 0x04000330 RID: 816
	public Color[] colors;

	// Token: 0x04000331 RID: 817
	private int ind;
}
