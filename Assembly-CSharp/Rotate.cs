using System;
using UnityEngine;

// Token: 0x02000005 RID: 5
public class Rotate : MonoBehaviour
{
	// Token: 0x06000018 RID: 24 RVA: 0x0000277C File Offset: 0x0000097C
	private void Update()
	{
		base.transform.Rotate(this.rotationAmount * Time.deltaTime);
	}

	// Token: 0x04000015 RID: 21
	public Vector3 rotationAmount;
}
