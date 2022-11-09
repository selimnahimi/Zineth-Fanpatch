using System;

// Token: 0x02000068 RID: 104
public class PhoneLabelCustomTwitter : PhoneLabel
{
	// Token: 0x06000455 RID: 1109 RVA: 0x00019F4C File Offset: 0x0001814C
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000456 RID: 1110 RVA: 0x00019F54 File Offset: 0x00018154
	private void Start()
	{
		if (this.overrideColor)
		{
			this.textmesh.renderer.material.color = this.color;
		}
		else
		{
			this.textmesh.renderer.material.color = PhoneMemory.settings.textColor;
		}
	}

	// Token: 0x06000457 RID: 1111 RVA: 0x00019FAC File Offset: 0x000181AC
	public override void OnLoad()
	{
		base.OnLoad();
		if (this.only_once && this._has_trigged)
		{
			base.renderer.enabled = false;
		}
		else if (TwitterDemo.instance._isCustom)
		{
			base.renderer.enabled = false;
			this._has_trigged = true;
		}
		else
		{
			this._has_trigged = false;
			base.renderer.enabled = true;
		}
	}

	// Token: 0x04000369 RID: 873
	public bool only_once;

	// Token: 0x0400036A RID: 874
	private bool _has_trigged;
}
