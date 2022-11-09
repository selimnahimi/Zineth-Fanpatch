using System;
using UnityEngine;

// Token: 0x020000C0 RID: 192
public class SplineAnimatorGravity : MonoBehaviour
{
	// Token: 0x0600080B RID: 2059 RVA: 0x0003607C File Offset: 0x0003427C
	private void FixedUpdate()
	{
		if (base.rigidbody == null || this.spline == null)
		{
			return;
		}
		Vector3 shortestConnection = this.spline.GetShortestConnection(base.rigidbody.position, this.iterations);
		base.rigidbody.AddForce(shortestConnection * (Mathf.Pow(shortestConnection.magnitude, -3f) * this.gravityConstant * base.rigidbody.mass));
	}

	// Token: 0x040006EA RID: 1770
	public Spline spline;

	// Token: 0x040006EB RID: 1771
	public float gravityConstant = 9.81f;

	// Token: 0x040006EC RID: 1772
	public int iterations = 5;
}
