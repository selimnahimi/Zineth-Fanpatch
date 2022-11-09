using System;
using UnityEngine;

// Token: 0x020000A1 RID: 161
public class ActivateTrigger : MonoBehaviour
{
	// Token: 0x060006CC RID: 1740 RVA: 0x0002C044 File Offset: 0x0002A244
	private void DoActivateTrigger()
	{
		this.triggerCount--;
		if (this.triggerCount == 0 || this.repeatTrigger)
		{
			UnityEngine.Object @object = (!(this.target != null)) ? base.gameObject : this.target;
			Behaviour behaviour = @object as Behaviour;
			GameObject gameObject = @object as GameObject;
			if (behaviour != null)
			{
				gameObject = behaviour.gameObject;
			}
			switch (this.action)
			{
			case ActivateTrigger.Mode.Trigger:
				gameObject.BroadcastMessage("DoActivateTrigger");
				break;
			case ActivateTrigger.Mode.Replace:
				if (this.source != null)
				{
					UnityEngine.Object.Instantiate(this.source, gameObject.transform.position, gameObject.transform.rotation);
					UnityEngine.Object.DestroyObject(gameObject);
				}
				break;
			case ActivateTrigger.Mode.Activate:
				gameObject.active = true;
				break;
			case ActivateTrigger.Mode.Enable:
				if (behaviour != null)
				{
					behaviour.enabled = true;
				}
				break;
			case ActivateTrigger.Mode.Animate:
				gameObject.animation.Play();
				break;
			case ActivateTrigger.Mode.Deactivate:
				gameObject.active = false;
				break;
			}
		}
	}

	// Token: 0x060006CD RID: 1741 RVA: 0x0002C174 File Offset: 0x0002A374
	private void OnTriggerEnter(Collider other)
	{
		this.DoActivateTrigger();
	}

	// Token: 0x0400059F RID: 1439
	public ActivateTrigger.Mode action = ActivateTrigger.Mode.Activate;

	// Token: 0x040005A0 RID: 1440
	public UnityEngine.Object target;

	// Token: 0x040005A1 RID: 1441
	public GameObject source;

	// Token: 0x040005A2 RID: 1442
	public int triggerCount = 1;

	// Token: 0x040005A3 RID: 1443
	public bool repeatTrigger;

	// Token: 0x020000A2 RID: 162
	public enum Mode
	{
		// Token: 0x040005A5 RID: 1445
		Trigger,
		// Token: 0x040005A6 RID: 1446
		Replace,
		// Token: 0x040005A7 RID: 1447
		Activate,
		// Token: 0x040005A8 RID: 1448
		Enable,
		// Token: 0x040005A9 RID: 1449
		Animate,
		// Token: 0x040005AA RID: 1450
		Deactivate
	}
}
