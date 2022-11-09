using System;

// Token: 0x0200006B RID: 107
public class PhoneLabelNewTweets : PhoneLabelNewMail
{
	// Token: 0x06000467 RID: 1127 RVA: 0x0001A3E4 File Offset: 0x000185E4
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000468 RID: 1128 RVA: 0x0001A3EC File Offset: 0x000185EC
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

	// Token: 0x06000469 RID: 1129 RVA: 0x0001A444 File Offset: 0x00018644
	private void Update()
	{
		base.SetText();
	}

	// Token: 0x0600046A RID: 1130 RVA: 0x0001A44C File Offset: 0x0001864C
	protected override int GetNumber()
	{
		if (!PhoneMemory.IsMenuUnlocked("Twitter"))
		{
			return 0;
		}
		return TwitterDemo.instance.newtweets;
	}
}
