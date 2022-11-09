using System;

// Token: 0x02000024 RID: 36
public class MissionObjectiveCactusBreaks : MissionObjective
{
	// Token: 0x0600010C RID: 268 RVA: 0x00009078 File Offset: 0x00007278
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x0600010D RID: 269 RVA: 0x00009080 File Offset: 0x00007280
	public override void OnBegin()
	{
		base.OnBegin();
		this.currentBreaks = 0;
	}

	// Token: 0x0600010E RID: 270 RVA: 0x00009090 File Offset: 0x00007290
	public override bool CheckCompleted()
	{
		this.currentBreaks += CactusBehavior.recentCactusBreaks;
		return base.CheckCompleted() && this.CheckBreaks();
	}

	// Token: 0x0600010F RID: 271 RVA: 0x000090C4 File Offset: 0x000072C4
	protected virtual bool CheckBreaks()
	{
		return this.currentBreaks >= this.requiredBreaks;
	}

	// Token: 0x06000110 RID: 272 RVA: 0x000090D8 File Offset: 0x000072D8
	public override string GetText()
	{
		return "Break Cacti: " + this.currentBreaks.ToString() + " / " + this.requiredBreaks.ToString();
	}

	// Token: 0x0400016B RID: 363
	public int requiredBreaks = 10;

	// Token: 0x0400016C RID: 364
	public int currentBreaks;
}
