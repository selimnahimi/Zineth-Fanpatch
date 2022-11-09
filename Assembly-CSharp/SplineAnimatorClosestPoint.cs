using System;
using UnityEngine;

// Token: 0x020000BF RID: 191
public class SplineAnimatorClosestPoint : MonoBehaviour
{
	// Token: 0x06000807 RID: 2055 RVA: 0x00035F40 File Offset: 0x00034140
	private void Start()
	{
		this.thisTransform = base.transform;
	}

	// Token: 0x06000808 RID: 2056 RVA: 0x00035F50 File Offset: 0x00034150
	private void Update()
	{
		if (this.target == null || this.spline == null)
		{
			return;
		}
		float param = this.WrapValue(this.spline.GetClosestPoint(this.target.position, this.iterations, this.lastParam, this.diff) + this.offset, 0f, 1f, this.wMode);
		this.thisTransform.position = this.spline.GetPositionOnSpline(param);
		this.thisTransform.rotation = this.spline.GetOrientationOnSpline(param);
		this.lastParam = param;
	}

	// Token: 0x06000809 RID: 2057 RVA: 0x00035FFC File Offset: 0x000341FC
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

	// Token: 0x040006E2 RID: 1762
	public Spline spline;

	// Token: 0x040006E3 RID: 1763
	public WrapMode wMode = WrapMode.Once;

	// Token: 0x040006E4 RID: 1764
	public Transform target;

	// Token: 0x040006E5 RID: 1765
	public int iterations = 5;

	// Token: 0x040006E6 RID: 1766
	public float diff = 0.5f;

	// Token: 0x040006E7 RID: 1767
	public float offset;

	// Token: 0x040006E8 RID: 1768
	private Transform thisTransform;

	// Token: 0x040006E9 RID: 1769
	private float lastParam;
}
