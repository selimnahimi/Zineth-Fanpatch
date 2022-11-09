using System;

// Token: 0x02000027 RID: 39
public class MissionObjectiveNoGround : MissionObjective
{
	// Token: 0x06000117 RID: 279 RVA: 0x00009260 File Offset: 0x00007460
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x06000118 RID: 280 RVA: 0x00009268 File Offset: 0x00007468
	public override void OnBegin()
	{
		base.OnBegin();
		this.lastAirTime = MissionObjective._playerMove.airTime;
	}

	// Token: 0x06000119 RID: 281 RVA: 0x00009280 File Offset: 0x00007480
	public override bool CheckCompleted()
	{
		if (this.GetAirTime() < this.lastAirTime && this.GetAirTime() >= 0f && this.GetAirTime() <= 0.1f)
		{
			this.failed = true;
		}
		this.lastAirTime = this.GetAirTime();
		return base.CheckCompleted();
	}

	// Token: 0x0600011A RID: 282 RVA: 0x000092D8 File Offset: 0x000074D8
	public override string GetText()
	{
		return "Don't Touch the Ground!";
	}

	// Token: 0x0600011B RID: 283 RVA: 0x000092E0 File Offset: 0x000074E0
	public virtual float GetAirTime()
	{
		return MissionObjective._playerMove.airTime;
	}

	// Token: 0x04000177 RID: 375
	private float lastAirTime = -1f;
}
