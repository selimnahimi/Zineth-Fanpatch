using System;

// Token: 0x02000025 RID: 37
public class MissionObjectiveCheckStat : MissionObjective
{
	// Token: 0x06000112 RID: 274 RVA: 0x00009128 File Offset: 0x00007328
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x06000113 RID: 275 RVA: 0x00009130 File Offset: 0x00007330
	public override bool CheckCompleted()
	{
		return base.CheckCompleted() && this.CheckStat();
	}

	// Token: 0x06000114 RID: 276 RVA: 0x00009148 File Offset: 0x00007348
	protected virtual bool CheckStat()
	{
		this.currentStat = PhoneInterface.GetStat(this.statName);
		if (this.comparison == MissionObjectiveCheckStat.Comparison.greaterOrEqual)
		{
			return this.currentStat >= this.requiredStat;
		}
		if (this.comparison == MissionObjectiveCheckStat.Comparison.greater)
		{
			return this.currentStat > this.requiredStat;
		}
		if (this.comparison == MissionObjectiveCheckStat.Comparison.less)
		{
			return this.currentStat < this.requiredStat;
		}
		if (this.comparison == MissionObjectiveCheckStat.Comparison.lessOrEqual)
		{
			return this.currentStat <= this.requiredStat;
		}
		return this.comparison == MissionObjectiveCheckStat.Comparison.equal && this.currentStat == this.requiredStat;
	}

	// Token: 0x06000115 RID: 277 RVA: 0x000091F4 File Offset: 0x000073F4
	public override string ParseGUIString(string guistring)
	{
		guistring = guistring.Replace("{statName}", this.statName);
		guistring = guistring.Replace("{currentStat}", this.currentStat.ToString());
		guistring = guistring.Replace("{requiredStat}", this.requiredStat.ToString());
		return base.ParseGUIString(guistring);
	}

	// Token: 0x0400016D RID: 365
	public string statName = string.Empty;

	// Token: 0x0400016E RID: 366
	private float currentStat;

	// Token: 0x0400016F RID: 367
	public float requiredStat;

	// Token: 0x04000170 RID: 368
	public MissionObjectiveCheckStat.Comparison comparison = MissionObjectiveCheckStat.Comparison.greater;

	// Token: 0x02000026 RID: 38
	[Serializable]
	public enum Comparison
	{
		// Token: 0x04000172 RID: 370
		less,
		// Token: 0x04000173 RID: 371
		lessOrEqual,
		// Token: 0x04000174 RID: 372
		equal,
		// Token: 0x04000175 RID: 373
		greaterOrEqual,
		// Token: 0x04000176 RID: 374
		greater
	}
}
