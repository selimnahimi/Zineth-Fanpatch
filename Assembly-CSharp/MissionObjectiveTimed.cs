using System;
using UnityEngine;

// Token: 0x02000029 RID: 41
public class MissionObjectiveTimed : MissionObjective
{
	// Token: 0x06000123 RID: 291 RVA: 0x00009468 File Offset: 0x00007668
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x06000124 RID: 292 RVA: 0x00009470 File Offset: 0x00007670
	public override void OnBegin()
	{
		base.OnBegin();
		this.currentTime = this.startTime;
	}

	// Token: 0x06000125 RID: 293 RVA: 0x00009484 File Offset: 0x00007684
	private void FixedUpdate()
	{
		this.currentTime -= Time.fixedDeltaTime;
		if (this.currentTime <= 0f && this.fail_on_end)
		{
			this.failed = true;
			base.SendMessageUpwards("FailMission");
		}
	}

	// Token: 0x06000126 RID: 294 RVA: 0x000094D0 File Offset: 0x000076D0
	public override bool CheckCompleted()
	{
		if (!this.fail_on_end)
		{
			return base.CheckCompleted() && this.currentTime <= 0f;
		}
		return base.CheckCompleted();
	}

	// Token: 0x06000127 RID: 295 RVA: 0x00009510 File Offset: 0x00007710
	public override string GetText()
	{
		return "Time Left: " + this.currentTime.ToString("0.00") + "s";
	}

	// Token: 0x0400017A RID: 378
	public float startTime = 10f;

	// Token: 0x0400017B RID: 379
	private float currentTime = -1f;

	// Token: 0x0400017C RID: 380
	public bool fail_on_end = true;
}
