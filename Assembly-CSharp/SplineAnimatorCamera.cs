using System;
using UnityEngine;

// Token: 0x020000BE RID: 190
public class SplineAnimatorCamera : MonoBehaviour
{
	// Token: 0x06000804 RID: 2052 RVA: 0x00035E08 File Offset: 0x00034008
	private void Update()
	{
		this.passedTime += Time.deltaTime * this.speed;
		base.transform.position = this.spline.GetPositionOnSpline(this.WrapValue(this.passedTime, 0f, 1f, this.wrapMode)) + Vector3.up;
		base.transform.rotation = Quaternion.LookRotation(this.spline.GetPositionOnSpline(this.WrapValue(this.passedTime + this.targetOffSet, 0f, 1f, this.wrapMode)) - base.transform.position);
	}

	// Token: 0x06000805 RID: 2053 RVA: 0x00035EB8 File Offset: 0x000340B8
	private float WrapValue(float v, float start, float end, WrapMode wMode)
	{
		switch (wMode)
		{
		case WrapMode.Default:
		case WrapMode.Loop:
			return Mathf.Repeat(v, end - start) + start;
		case WrapMode.Once:
		case WrapMode.ClampForever:
			return Mathf.Clamp(v, start, end);
		case WrapMode.PingPong:
			return Mathf.PingPong(v, end - start) + start;
		}
		return v;
	}

	// Token: 0x040006DD RID: 1757
	public Spline spline;

	// Token: 0x040006DE RID: 1758
	public float speed = 1f;

	// Token: 0x040006DF RID: 1759
	public float targetOffSet;

	// Token: 0x040006E0 RID: 1760
	public WrapMode wrapMode = WrapMode.Once;

	// Token: 0x040006E1 RID: 1761
	public float passedTime;
}
