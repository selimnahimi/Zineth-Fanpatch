using System;

// Token: 0x02000028 RID: 40
public class MissionObjectiveSpeed : MissionObjective
{
	// Token: 0x0600011D RID: 285 RVA: 0x00009300 File Offset: 0x00007500
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x0600011E RID: 286 RVA: 0x00009308 File Offset: 0x00007508
	public override bool CheckCompleted()
	{
		return base.CheckCompleted() && this.CheckSpeed();
	}

	// Token: 0x0600011F RID: 287 RVA: 0x00009320 File Offset: 0x00007520
	protected virtual bool CheckSpeed()
	{
		if (this.lessThan)
		{
			return this.GetSpeed() <= this.requiredSpeed;
		}
		return this.GetSpeed() >= this.requiredSpeed;
	}

	// Token: 0x06000120 RID: 288 RVA: 0x0000935C File Offset: 0x0000755C
	protected virtual float GetSpeed()
	{
		return MissionObjective.player.InverseTransformDirection(MissionObjective.player.rigidbody.velocity).z;
	}

	// Token: 0x06000121 RID: 289 RVA: 0x0000938C File Offset: 0x0000758C
	public override string GetText()
	{
		if (!this.lessThan)
		{
			return "Reach the speed:\n" + this.GetSpeed().ToString("0") + " / " + this.requiredSpeed.ToString("0");
		}
		if (this.requiredSpeed > 1f || this.requiredSpeed < 0f)
		{
			return "Slow Down:\n" + this.GetSpeed().ToString("0") + " / " + this.requiredSpeed.ToString("0");
		}
		if (this.requireTrigger)
		{
			return "Stop in the Zone!";
		}
		return "Stop!";
	}

	// Token: 0x04000178 RID: 376
	public bool lessThan;

	// Token: 0x04000179 RID: 377
	public float requiredSpeed = 120f;
}
