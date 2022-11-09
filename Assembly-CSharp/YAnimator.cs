using System;
using UnityEngine;

// Token: 0x020000C2 RID: 194
public class YAnimator : MonoBehaviour
{
	// Token: 0x06000821 RID: 2081 RVA: 0x00037334 File Offset: 0x00035534
	private void Start()
	{
		this.normalPosition = base.transform.position;
	}

	// Token: 0x06000822 RID: 2082 RVA: 0x00037348 File Offset: 0x00035548
	private void Update()
	{
		this.passedTime += Time.deltaTime * this.speed;
		base.transform.position = this.normalPosition + Vector3.up * this.yOffset * Mathf.Sin(this.passedTime);
	}

	// Token: 0x04000711 RID: 1809
	public float passedTime;

	// Token: 0x04000712 RID: 1810
	public float yOffset;

	// Token: 0x04000713 RID: 1811
	public float speed;

	// Token: 0x04000714 RID: 1812
	private Vector3 normalPosition;
}
