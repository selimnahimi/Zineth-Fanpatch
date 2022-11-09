using System;
using UnityEngine;

// Token: 0x0200006A RID: 106
public class PhoneLabelNewMail : PhoneLabel
{
	// Token: 0x06000460 RID: 1120 RVA: 0x0001A1E4 File Offset: 0x000183E4
	public override void OnLoad()
	{
		base.OnLoad();
		if (this.overrideColor)
		{
			this.textmesh.renderer.material.color = this.color;
		}
		else
		{
			this.textmesh.renderer.material.color = PhoneMemory.settings.selectedTextColor;
		}
	}

	// Token: 0x06000461 RID: 1121 RVA: 0x0001A244 File Offset: 0x00018444
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000462 RID: 1122 RVA: 0x0001A24C File Offset: 0x0001844C
	private void Start()
	{
		if (this.overrideColor)
		{
			this.textmesh.renderer.material.color = this.color;
		}
		else
		{
			this.textmesh.renderer.material.color = PhoneMemory.settings.selectedTextColor;
		}
	}

	// Token: 0x06000463 RID: 1123 RVA: 0x0001A2A4 File Offset: 0x000184A4
	private void Update()
	{
		this.SetText();
	}

	// Token: 0x06000464 RID: 1124 RVA: 0x0001A2AC File Offset: 0x000184AC
	protected virtual int GetNumber()
	{
		return PhoneMemory.new_mail;
	}

	// Token: 0x06000465 RID: 1125 RVA: 0x0001A2B4 File Offset: 0x000184B4
	protected void SetText()
	{
		this.counter += Time.deltaTime;
		if (this.counter % 0.5f > 0.35f)
		{
			base.renderer.enabled = false;
			if (this.icon)
			{
				this.icon.renderer.enabled = false;
			}
			this.waschecked = false;
			return;
		}
		if (this.waschecked)
		{
			return;
		}
		this.waschecked = true;
		int number = this.GetNumber();
		if (number <= 0)
		{
			base.renderer.enabled = false;
			if (this.icon)
			{
				this.icon.renderer.enabled = false;
			}
		}
		else
		{
			base.renderer.enabled = true;
			if (this.icon)
			{
				this.icon.renderer.enabled = true;
			}
			if (this.old_num != number)
			{
				this.SetText(number.ToString());
			}
		}
		if (!this.show_text)
		{
			this.textmesh.renderer.enabled = false;
		}
		this.old_num = number;
	}

	// Token: 0x0400036E RID: 878
	private float counter;

	// Token: 0x0400036F RID: 879
	private bool waschecked;

	// Token: 0x04000370 RID: 880
	private int old_num = -1;

	// Token: 0x04000371 RID: 881
	public bool show_text = true;
}
