using System;
using UnityEngine;

// Token: 0x0200001A RID: 26
public class CollisionChecker : MonoBehaviour
{
	// Token: 0x17000005 RID: 5
	// (set) Token: 0x06000096 RID: 150 RVA: 0x000072C8 File Offset: 0x000054C8
	public CollisionChecker.OnTriggerEnterDelegate TriggerEnterDelegate
	{
		set
		{
			this._triggerEnterDelegate = value;
		}
	}

	// Token: 0x06000097 RID: 151 RVA: 0x000072D4 File Offset: 0x000054D4
	private void OnTriggerEnter(Collider other)
	{
		if (this._triggerEnterDelegate != null)
		{
			this._triggerEnterDelegate(other);
		}
	}

	// Token: 0x17000006 RID: 6
	// (set) Token: 0x06000098 RID: 152 RVA: 0x000072F0 File Offset: 0x000054F0
	public CollisionChecker.OnTriggerExitDelegate TriggerExitDelegate
	{
		set
		{
			this._triggerExitDelegate = value;
		}
	}

	// Token: 0x06000099 RID: 153 RVA: 0x000072FC File Offset: 0x000054FC
	private void OnTriggerExit(Collider other)
	{
		if (this._triggerExitDelegate != null)
		{
			this._triggerExitDelegate(other);
		}
	}

	// Token: 0x04000100 RID: 256
	protected CollisionChecker.OnTriggerEnterDelegate _triggerEnterDelegate;

	// Token: 0x04000101 RID: 257
	protected CollisionChecker.OnTriggerExitDelegate _triggerExitDelegate;

	// Token: 0x020000E3 RID: 227
	// (Invoke) Token: 0x060008B7 RID: 2231
	public delegate void OnTriggerEnterDelegate(Collider collider);

	// Token: 0x020000E4 RID: 228
	// (Invoke) Token: 0x060008BB RID: 2235
	public delegate void OnTriggerExitDelegate(Collider collider);
}
