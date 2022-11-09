using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000002 RID: 2
public class Arrow : MonoBehaviour
{
	// Token: 0x06000002 RID: 2 RVA: 0x000020F4 File Offset: 0x000002F4
	public MissionObjective GetTarget()
	{
		if (MissionController.focus_mission)
		{
			List<MissionObjective> currentObjectives = MissionController.focus_mission.GetCurrentObjectives();
			for (int i = 0; i < currentObjectives.Count; i++)
			{
				if (currentObjectives[i].use_position)
				{
					return currentObjectives[i];
				}
			}
			return null;
		}
		return null;
	}

	// Token: 0x06000003 RID: 3 RVA: 0x00002154 File Offset: 0x00000354
	private void Update()
	{
		this.CheckAndPoint();
	}

	// Token: 0x06000004 RID: 4 RVA: 0x0000215C File Offset: 0x0000035C
	public void CheckAndPoint()
	{
		this.pointObjective = this.GetTarget();
		if (!this.pointObjective || this.pointObjective.completed)
		{
			MissionController.GetInstance().arrowActive = false;
			base.gameObject.SetActiveRecursively(false);
			base.Invoke("CheckAndPoint", 0.5f);
		}
		else
		{
			if (!base.gameObject.active)
			{
				base.gameObject.SetActiveRecursively(true);
			}
			base.transform.LookAt(this.pointObjective.objectivePosition);
			base.CancelInvoke("CheckAndPoint");
		}
	}

	// Token: 0x04000001 RID: 1
	public MissionObjective pointObjective;
}
