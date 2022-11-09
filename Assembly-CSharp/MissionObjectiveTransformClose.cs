using System;
using UnityEngine;

// Token: 0x0200002A RID: 42
public class MissionObjectiveTransformClose : MissionObjective
{
	// Token: 0x06000129 RID: 297 RVA: 0x00009548 File Offset: 0x00007748
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x0600012A RID: 298 RVA: 0x00009550 File Offset: 0x00007750
	public override bool CheckCompleted()
	{
		return base.CheckCompleted() && Vector3.Distance(MissionObjective.player.transform.position, base.objectivePosition) < this.distance;
	}

	// Token: 0x0600012B RID: 299 RVA: 0x00009590 File Offset: 0x00007790
	public override void OnBegin()
	{
		base.OnBegin();
	}

	// Token: 0x0600012C RID: 300 RVA: 0x00009598 File Offset: 0x00007798
	public override void OnEnd()
	{
		base.OnEnd();
	}

	// Token: 0x0400017D RID: 381
	public float distance = 5f;
}
