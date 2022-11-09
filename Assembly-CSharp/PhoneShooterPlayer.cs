using System;
using UnityEngine;

// Token: 0x02000038 RID: 56
public class PhoneShooterPlayer : PhoneShooterMonster
{
	// Token: 0x17000033 RID: 51
	// (get) Token: 0x060001F8 RID: 504 RVA: 0x0000D3D0 File Offset: 0x0000B5D0
	public override float bullet_homing
	{
		get
		{
			return this.monster.bullet_homing + (Mathf.Sqrt(1f + base.glam) - 1f);
		}
	}

	// Token: 0x060001F9 RID: 505 RVA: 0x0000D3F8 File Offset: 0x0000B5F8
	private void Start()
	{
		this.bounds = base.transform.parent.collider.bounds;
	}

	// Token: 0x17000034 RID: 52
	// (get) Token: 0x060001FA RID: 506 RVA: 0x0000D420 File Offset: 0x0000B620
	public override float maxhealth
	{
		get
		{
			return 12f + this.monster.defense * 4f;
		}
	}

	// Token: 0x060001FB RID: 507 RVA: 0x0000D43C File Offset: 0x0000B63C
	public override void OnUpdate()
	{
		if (this.health <= 0f)
		{
			this.OnDeath();
			return;
		}
		this.DoMovement();
		this.PullExpTowards();
		this.DoAttacking();
		this.DoShooting();
		this.DoAnimation();
		this.healthbar.OnUpdate();
	}

	// Token: 0x060001FC RID: 508 RVA: 0x0000D48C File Offset: 0x0000B68C
	private void DoMovement()
	{
		Vector3 vector = Vector3.zero;
		base.rigidbody.drag = 30f;
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			if (PhoneInput.GetTouchPoint() != Vector3.one * -1f)
			{
				Vector3 vector2 = PhoneInput.GetTransformedTouchPoint();
				vector2.y = base.transform.position.y;
				vector2 = (vector2 - base.transform.position) * base.realspeed;
				if (vector2.magnitude > base.realspeed)
				{
					vector2 = vector2.normalized * base.realspeed;
				}
				base.transform.position += vector2 * PhoneElement.deltatime;
				vector = vector2;
				this.curdir = vector2;
			}
		}
		else
		{
			Vector2 a = PhoneInput.GetControlDir();
			if (a.magnitude > 0.1f)
			{
				if (a.magnitude > 1f)
				{
					a.Normalize();
				}
				a *= base.realspeed;
				this.curdir = new Vector3(a.x, 0f, a.y);
				vector = this.curdir;
				base.transform.position += this.curdir * PhoneElement.deltatime;
			}
		}
		if (this.attack_timer > 0f)
		{
			this.sprite_player.animation_name = "attack";
			this.sprite_player.play_speed = 1f;
		}
		else
		{
			if (this.sprite_player.animation_name != "walk")
			{
				this.sprite_player.PlayAnimation("walk");
			}
			if (this.monster.flying_animate)
			{
				this.sprite_player.play_speed = 1f + vector.magnitude * 0.25f;
			}
			else
			{
				this.sprite_player.play_speed = vector.magnitude;
			}
			if (vector.magnitude == 0f && !this.monster.flying_animate)
			{
				this.sprite_player.time = 0f;
			}
		}
		this.LimitPos();
	}

	// Token: 0x060001FD RID: 509 RVA: 0x0000D6CC File Offset: 0x0000B8CC
	private void DoAttacking()
	{
		this.attack_timer = Mathf.Max(0f, this.attack_timer - PhoneElement.deltatime);
		if (this.attack_timer <= 0f && PhoneInput.IsPressedDown())
		{
			Vector2 dir = new Vector2(this.curdir.x, this.curdir.z);
			this.Attack(dir);
			this.attack_timer = 0.5f;
		}
	}

	// Token: 0x060001FE RID: 510 RVA: 0x0000D740 File Offset: 0x0000B940
	private void Attack(Vector2 dir)
	{
		float num = Mathf.Atan2(dir.y, dir.x) * 57.29578f;
		if (num < 0f)
		{
			num += 360f;
		}
		int num2 = Mathf.RoundToInt(num / 45f);
		if (num2 >= 8)
		{
			num2 = 0;
		}
		PhoneShooterAttack phoneShooterAttack = UnityEngine.Object.Instantiate(this.attackprefab) as PhoneShooterAttack;
		phoneShooterAttack.transform.position = base.transform.position + new Vector3(dir.normalized.x, 0f, dir.normalized.y) * 0.5f;
		Vector3 localScale = phoneShooterAttack.transform.localScale;
		localScale.x *= this.monster.scale.x;
		localScale.z *= this.monster.scale.y;
		phoneShooterAttack.transform.localScale = localScale;
		phoneShooterAttack.owner = this;
		phoneShooterAttack.velocity = new Vector3(dir.normalized.x, 0f, dir.normalized.y) * 2f;
		phoneShooterAttack.damage = base.attack * 1f;
		phoneShooterAttack.renderer.material.color = Color.white;
		phoneShooterAttack.transform.parent = base.transform.parent;
		phoneShooterAttack.spriteplayer.SetSpriteSet(this.monster.spriteset);
		phoneShooterAttack.spriteplayer.PlayAnimation("bullet", 0f);
		phoneShooterAttack.spriteplayer.SetFrame(phoneShooterAttack.renderer.material, num2);
		this.sprite_player.PlayAnimation("attack");
		PhoneAudioController.PlayAudioClip("attack", SoundType.game);
	}

	// Token: 0x060001FF RID: 511 RVA: 0x0000D928 File Offset: 0x0000BB28
	private void DoShooting()
	{
		this.shoot_timer = Mathf.Max(0f, this.shoot_timer - PhoneElement.deltatime);
		this.ShootAtNearest();
	}

	// Token: 0x06000200 RID: 512 RVA: 0x0000D958 File Offset: 0x0000BB58
	private void ShootAtNearest()
	{
		if ((this.autoshoot || PhoneInput.IsPressed()) && this.shoot_timer <= 0f && this.attack_timer <= 0f)
		{
			PhoneShooterEnemy phoneShooterEnemy = null;
			float num = float.PositiveInfinity;
			PhoneShooterEnemy[] componentsInChildren = base.transform.parent.gameObject.GetComponentsInChildren<PhoneShooterEnemy>();
			foreach (PhoneShooterEnemy phoneShooterEnemy2 in componentsInChildren)
			{
				float num2 = Vector3.Distance(base.transform.position, phoneShooterEnemy2.transform.position);
				if (num2 < num)
				{
					num = num2;
					phoneShooterEnemy = phoneShooterEnemy2;
				}
			}
			if (phoneShooterEnemy != null)
			{
				this.target_trans = phoneShooterEnemy.transform;
				Vector3 normalized = (phoneShooterEnemy.transform.position - base.transform.position).normalized;
				this.Shoot(normalized);
				this.ResetShootTimer();
			}
			else
			{
				this.target_trans = null;
			}
		}
	}

	// Token: 0x06000201 RID: 513 RVA: 0x0000DA60 File Offset: 0x0000BC60
	private void ShootAtMoveDir()
	{
		if ((this.autoshoot || PhoneInput.IsPressed()) && this.shoot_timer <= 0f)
		{
			Vector3 normalized = this.curdir.normalized;
			this.Shoot(normalized);
			this.shoot_timer = this.shoot_cooldown / this.monster.bullet_cooldown;
		}
	}

	// Token: 0x06000202 RID: 514 RVA: 0x0000DAC0 File Offset: 0x0000BCC0
	private float GetPullDistance()
	{
		return 0.5f + this.monster.glam / 5f;
	}

	// Token: 0x17000035 RID: 53
	// (get) Token: 0x06000203 RID: 515 RVA: 0x0000DADC File Offset: 0x0000BCDC
	private float pullspeed
	{
		get
		{
			return 2f + this.monster.glam / 5f;
		}
	}

	// Token: 0x06000204 RID: 516 RVA: 0x0000DAF8 File Offset: 0x0000BCF8
	private void PullExpTowards()
	{
		Debug.DrawLine(base.transform.position, base.transform.position + Vector3.right * this.GetPullDistance(), Color.red);
		PhoneShooterPickup[] componentsInChildren = base.transform.parent.gameObject.GetComponentsInChildren<PhoneShooterPickup>();
		foreach (PhoneShooterPickup phoneShooterPickup in componentsInChildren)
		{
			Vector3 position = phoneShooterPickup.transform.position;
			position.y = base.transform.position.y;
			float num = Vector3.Distance(base.transform.position, position);
			if (num < 0.2f)
			{
				this.Collide_Pickup(phoneShooterPickup);
			}
			if (num < this.GetPullDistance() && phoneShooterPickup.allow_magnet)
			{
				float num2 = this.pullspeed * (1f - num / this.GetPullDistance());
				this.monster.glamStat.Grow(num2 / 200f * PhoneElement.deltatime);
				num2 /= phoneShooterPickup.givehealth / 1f;
				Vector3 vector = (base.transform.position - phoneShooterPickup.transform.position).normalized;
				vector *= num2 * PhoneElement.deltatime;
				phoneShooterPickup.transform.position += vector;
			}
		}
	}

	// Token: 0x06000205 RID: 517 RVA: 0x0000DC68 File Offset: 0x0000BE68
	public override void OnDeath()
	{
		PhoneController.EmitParts(base.transform.position, (int)(this.maxhealth * 0.75f));
		base.OnDeath();
	}

	// Token: 0x06000206 RID: 518 RVA: 0x0000DC98 File Offset: 0x0000BE98
	private void OnTriggerEnter(Collider other)
	{
		this.HandleCollision(other);
	}

	// Token: 0x06000207 RID: 519 RVA: 0x0000DCA4 File Offset: 0x0000BEA4
	public override void Collide_Enemy(PhoneShooterEnemy enemy)
	{
		enemy.health -= base.attack;
		this.health -= enemy.attack;
		PhoneController.EmitParts(enemy.transform.position, 10);
	}

	// Token: 0x06000208 RID: 520 RVA: 0x0000DCEC File Offset: 0x0000BEEC
	public override void Collide_Pickup(PhoneShooterPickup pickup)
	{
		pickup.OnUsed(this);
	}

	// Token: 0x04000200 RID: 512
	public Vector3 curdir = Vector3.forward;

	// Token: 0x04000201 RID: 513
	public PhoneShooterAttack attackprefab;

	// Token: 0x04000202 RID: 514
	public bool autoshoot = true;
}
