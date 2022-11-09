using System;
using UnityEngine;

// Token: 0x02000069 RID: 105
public class PhoneLabelNewBattle : PhoneLabel
{
	// Token: 0x06000459 RID: 1113 RVA: 0x0001A034 File Offset: 0x00018234
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

	// Token: 0x0600045A RID: 1114 RVA: 0x0001A094 File Offset: 0x00018294
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x0600045B RID: 1115 RVA: 0x0001A09C File Offset: 0x0001829C
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

	// Token: 0x0600045C RID: 1116 RVA: 0x0001A0F4 File Offset: 0x000182F4
	private void Update()
	{
		this.SetText();
	}

	// Token: 0x0600045D RID: 1117 RVA: 0x0001A0FC File Offset: 0x000182FC
	protected virtual string GetText()
	{
		if (PhoneMemory.trainer_challenge == null)
		{
			return string.Empty;
		}
		return "VS";
	}

	// Token: 0x0600045E RID: 1118 RVA: 0x0001A11C File Offset: 0x0001831C
	protected void SetText()
	{
		this.counter += Time.deltaTime;
		if (this.counter % 0.5f > 0.35f)
		{
			base.renderer.enabled = false;
			this.waschecked = false;
			return;
		}
		if (this.waschecked)
		{
			return;
		}
		this.waschecked = true;
		string text = this.GetText();
		if (text == string.Empty)
		{
			base.renderer.enabled = false;
		}
		else
		{
			base.renderer.enabled = true;
			if (this.old_text != text)
			{
				this.SetText(text);
			}
		}
		this.old_text = text;
	}

	// Token: 0x0400036B RID: 875
	private float counter;

	// Token: 0x0400036C RID: 876
	private bool waschecked;

	// Token: 0x0400036D RID: 877
	private string old_text = "ddd";
}
