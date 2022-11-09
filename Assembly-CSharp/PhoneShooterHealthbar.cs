using System;
using UnityEngine;

// Token: 0x02000035 RID: 53
public class PhoneShooterHealthbar : MonoBehaviour
{
	// Token: 0x060001C0 RID: 448 RVA: 0x0000C540 File Offset: 0x0000A740
	private void Start()
	{
		if (this.backbar)
		{
			this.backbar.renderer.material.color = Color.white;
			this.backscale = this.backbar.localScale;
		}
		this.backscale = base.transform.localScale;
	}

	// Token: 0x060001C1 RID: 449 RVA: 0x0000C59C File Offset: 0x0000A79C
	public void OnUpdate()
	{
		if (this.old_health == float.NegativeInfinity)
		{
			this.old_health = this.monster.health;
		}
		else if (this.old_health != this.monster.health)
		{
			if (this.back_timer <= 0f)
			{
				this.backscale.x = base.transform.localScale.x;
			}
			this.back_timer = 2f;
			this.old_health = this.monster.health;
		}
		Vector3 localScale = base.transform.localScale;
		localScale.x = Mathf.Max(0f, this.monster.health / this.monster.maxhealth);
		if (base.transform.localScale != localScale)
		{
			base.transform.localScale = localScale;
		}
		if (this.backbar)
		{
			Vector3 localScale2 = this.backbar.localScale;
			localScale2.x = localScale.x;
			localScale2.z *= 0.5f;
			if (localScale2 != this.backbar.localScale)
			{
				this.backbar.localScale = Vector3.Lerp(localScale2, this.backscale, Mathf.Min(this.back_timer, 1f));
			}
		}
		this.back_timer = Mathf.Max(this.back_timer - Time.deltaTime * 5f, 0f);
	}

	// Token: 0x040001E0 RID: 480
	public PhoneShooterMonster monster;

	// Token: 0x040001E1 RID: 481
	private Vector3 backscale;

	// Token: 0x040001E2 RID: 482
	public Transform backbar;

	// Token: 0x040001E3 RID: 483
	private float old_health = float.NegativeInfinity;

	// Token: 0x040001E4 RID: 484
	private float back_timer;
}
