using System;
using UnityEngine;

// Token: 0x020000BD RID: 189
public class SplineAnimator : MonoBehaviour
{
	// Token: 0x06000801 RID: 2049 RVA: 0x00035CF0 File Offset: 0x00033EF0
	private void FixedUpdate()
	{
		this.passedTime += Time.deltaTime * this.speed;
		base.transform.position = this.spline.GetPositionOnSpline(this.WrapValue(this.passedTime + this.offSet, 0f, 1f, this.wrapMode));
		base.transform.rotation = this.spline.GetOrientationOnSpline(this.WrapValue(this.passedTime + this.offSet, 0f, 1f, this.wrapMode));
	}

	// Token: 0x06000802 RID: 2050 RVA: 0x00035D88 File Offset: 0x00033F88
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

	// Token: 0x040006D8 RID: 1752
	public Spline spline;

	// Token: 0x040006D9 RID: 1753
	public float speed = 1f;

	// Token: 0x040006DA RID: 1754
	public float offSet;

	// Token: 0x040006DB RID: 1755
	public WrapMode wrapMode = WrapMode.Once;

	// Token: 0x040006DC RID: 1756
	public float passedTime;
}
