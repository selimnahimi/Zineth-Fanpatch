using System;
using UnityEngine;

// Token: 0x02000030 RID: 48
public class PhoneShooterAttack : PhoneShooterBullet
{
	// Token: 0x0600015F RID: 351 RVA: 0x0000A3A0 File Offset: 0x000085A0
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000160 RID: 352 RVA: 0x0000A3A8 File Offset: 0x000085A8
	public override void OnUpdate()
	{
		this.lifetime -= PhoneElement.deltatime;
		if (this.lifetime <= 0f)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		base.transform.position += this.velocity * PhoneElement.deltatime;
		this.spriteplayer.UpdateMat(base.renderer.material);
	}

	// Token: 0x06000161 RID: 353 RVA: 0x0000A420 File Offset: 0x00008620
	private void OnTriggerEnter(Collider other)
	{
		PhoneShooterBullet component = other.gameObject.GetComponent<PhoneShooterBullet>();
		if (component && component.owner != this.owner)
		{
			component.owner.monster.attackStat.Grow(component.damage / 20f);
			UnityEngine.Object.Destroy(component.gameObject);
		}
	}

	// Token: 0x06000162 RID: 354 RVA: 0x0000A488 File Offset: 0x00008688
	private void OnTriggerStay(Collider other)
	{
		if (other.name.StartsWith("food_"))
		{
			PhoneShooterPickup component = other.gameObject.GetComponent<PhoneShooterPickup>();
			if (component && this.knockback != 0f)
			{
				float d = this.knockback / (0.5f + component.givehealth / 3f);
				component.transform.position += this.velocity.normalized * d * PhoneElement.deltatime;
				component.allow_magnet = false;
			}
		}
	}

	// Token: 0x040001B9 RID: 441
	public SpritePlayer spriteplayer = new SpritePlayer();
}
