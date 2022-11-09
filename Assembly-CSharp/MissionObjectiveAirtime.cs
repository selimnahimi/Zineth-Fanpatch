using System;

// Token: 0x02000023 RID: 35
public class MissionObjectiveAirtime : MissionObjective
{
	// Token: 0x06000106 RID: 262 RVA: 0x00008FCC File Offset: 0x000071CC
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x06000107 RID: 263 RVA: 0x00008FD4 File Offset: 0x000071D4
	public override void Setup()
	{
		base.Setup();
	}

	// Token: 0x06000108 RID: 264 RVA: 0x00008FDC File Offset: 0x000071DC
	public override bool CheckCompleted()
	{
		return base.CheckCompleted() && this.GetAirTime() >= this.requiredAirtime;
	}

	// Token: 0x06000109 RID: 265 RVA: 0x00009000 File Offset: 0x00007200
	public override string GetText()
	{
		return string.Concat(new string[]
		{
			"Stay in the air!\n",
			this.GetAirTime().ToString("0.00"),
			"s / ",
			this.requiredAirtime.ToString("0.00"),
			"s"
		});
	}

	// Token: 0x0600010A RID: 266 RVA: 0x0000905C File Offset: 0x0000725C
	protected virtual float GetAirTime()
	{
		return MissionObjective._playerMove.airTime;
	}

	// Token: 0x0400016A RID: 362
	public float requiredAirtime = 3f;
}
