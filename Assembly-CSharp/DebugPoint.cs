using System;
using UnityEngine;

// Token: 0x020000B7 RID: 183
public class DebugPoint : MonoBehaviour
{
	// Token: 0x060007D9 RID: 2009 RVA: 0x00034080 File Offset: 0x00032280
	private void OnDrawGizmos()
	{
		Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
		Gizmos.DrawCube(base.transform.position, new Vector3(1f, 1f, 1f));
	}

	// Token: 0x04000692 RID: 1682
	public Vector3 velocity;
}
