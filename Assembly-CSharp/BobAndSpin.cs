using System;
using UnityEngine;

// Token: 0x02000003 RID: 3
public class BobAndSpin : MonoBehaviour
{
	// Token: 0x06000006 RID: 6 RVA: 0x0000223C File Offset: 0x0000043C
	private void Update()
	{
		this.BS();
	}

	// Token: 0x06000007 RID: 7 RVA: 0x00002244 File Offset: 0x00000444
	private void BS()
	{
		base.transform.Rotate(0f, this.spinSpeed * Time.deltaTime, 0f);
		if (this.bobUp)
		{
			if (this.currentBob < this.maxBob)
			{
				this.currentBob += this.bobSpeed * Time.deltaTime;
				base.transform.position += new Vector3(0f, this.bobSpeed * Time.deltaTime, 0f);
			}
			else
			{
				this.bobUp = false;
			}
		}
		else if (this.currentBob > 0f)
		{
			this.currentBob -= this.bobSpeed * Time.deltaTime;
			base.transform.position -= new Vector3(0f, this.bobSpeed * Time.deltaTime, 0f);
		}
		else
		{
			this.bobUp = true;
		}
	}

	// Token: 0x04000002 RID: 2
	public float bobSpeed = 3f;

	// Token: 0x04000003 RID: 3
	public float maxBob = 2f;

	// Token: 0x04000004 RID: 4
	public float spinSpeed = 50f;

	// Token: 0x04000005 RID: 5
	private bool bobUp = true;

	// Token: 0x04000006 RID: 6
	private float currentBob;
}
