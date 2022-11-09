using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000031 RID: 49
public class PhoneShooterBullet : PhoneElement
{
	// Token: 0x06000164 RID: 356 RVA: 0x0000A560 File Offset: 0x00008760
	public override void OnLoad()
	{
	}

	// Token: 0x06000165 RID: 357 RVA: 0x0000A564 File Offset: 0x00008764
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000166 RID: 358 RVA: 0x0000A56C File Offset: 0x0000876C
	public override void OnUpdate()
	{
		this.lifetime -= PhoneElement.deltatime;
		if (this.lifetime <= 0f)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		if (this.target && this.homing != 0f)
		{
			this.DoHoming(this.target.position);
		}
		base.transform.position += this.velocity * PhoneElement.deltatime;
	}

	// Token: 0x06000167 RID: 359 RVA: 0x0000A600 File Offset: 0x00008800
	protected virtual void DoHoming(Vector3 pos)
	{
		Vector3 vector = pos - base.transform.position;
		vector.y = 0f;
		float magnitude = this.velocity.magnitude;
		this.velocity += Mathf.Sign(this.homing) * vector.normalized * (1f + Mathf.Sqrt(Mathf.Abs(this.homing)) - 1f) * PhoneElement.deltatime;
	}

	// Token: 0x06000168 RID: 360 RVA: 0x0000A68C File Offset: 0x0000888C
	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.name == "PhoneGameWall")
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x06000169 RID: 361 RVA: 0x0000A6C0 File Offset: 0x000088C0
	public virtual void OnHit(PhoneShooterMonster monster)
	{
		if (this.knockback != 0f)
		{
			float num = Mathf.Max(monster.monster.scale.x * monster.monster.scale.y, 1f);
			float d = this.knockback / num;
			monster.transform.position += this.velocity.normalized * d * PhoneElement.deltatime;
			monster.LimitPos();
		}
		if (this.ignorelist.Contains(monster))
		{
			return;
		}
		monster.ShowText(base.transform.position + Vector3.up * 4f, this.damage.ToString("0.0"), 0.25f, Color.red, true);
		monster.Damage(this);
		if (this.destroyonhit)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		else
		{
			this.ignorelist.Add(monster);
		}
	}

	// Token: 0x040001BA RID: 442
	public PhoneShooterMonster owner;

	// Token: 0x040001BB RID: 443
	public float damage = 1f;

	// Token: 0x040001BC RID: 444
	public float knockback;

	// Token: 0x040001BD RID: 445
	public float lifetime = 30f;

	// Token: 0x040001BE RID: 446
	public float homing;

	// Token: 0x040001BF RID: 447
	public Transform target;

	// Token: 0x040001C0 RID: 448
	public bool destroyonhit = true;

	// Token: 0x040001C1 RID: 449
	public List<PhoneShooterMonster> ignorelist = new List<PhoneShooterMonster>();
}
