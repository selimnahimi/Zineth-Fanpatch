using System;
using UnityEngine;

// Token: 0x02000036 RID: 54
public class PhoneShooterMonster : PhoneElement
{
	// Token: 0x1700002A RID: 42
	// (get) Token: 0x060001C3 RID: 451 RVA: 0x0000C77C File Offset: 0x0000A97C
	protected float realspeed
	{
		get
		{
			return this.speed * (this.monster.speed / this.monster.scale.x);
		}
	}

	// Token: 0x1700002B RID: 43
	// (get) Token: 0x060001C4 RID: 452 RVA: 0x0000C7B0 File Offset: 0x0000A9B0
	public virtual float bullet_homing
	{
		get
		{
			return (Mathf.Sqrt(1f + this.glam * 1.5f) - 1f) * this.monster.bullet_homing;
		}
	}

	// Token: 0x1700002C RID: 44
	// (get) Token: 0x060001C5 RID: 453 RVA: 0x0000C7DC File Offset: 0x0000A9DC
	public virtual float bullet_speed
	{
		get
		{
			return this.monster.bullet_speed * 2f;
		}
	}

	// Token: 0x1700002D RID: 45
	// (get) Token: 0x060001C6 RID: 454 RVA: 0x0000C7F0 File Offset: 0x0000A9F0
	public virtual float maxhealth
	{
		get
		{
			return this.monster.defense * 4f * this.monster.scale.x;
		}
	}

	// Token: 0x1700002E RID: 46
	// (get) Token: 0x060001C7 RID: 455 RVA: 0x0000C824 File Offset: 0x0000AA24
	public float attack
	{
		get
		{
			return this.monster.attack;
		}
	}

	// Token: 0x1700002F RID: 47
	// (get) Token: 0x060001C8 RID: 456 RVA: 0x0000C834 File Offset: 0x0000AA34
	public float magic
	{
		get
		{
			return this.monster.magic;
		}
	}

	// Token: 0x17000030 RID: 48
	// (get) Token: 0x060001C9 RID: 457 RVA: 0x0000C844 File Offset: 0x0000AA44
	public float glam
	{
		get
		{
			return this.monster.glam;
		}
	}

	// Token: 0x060001CA RID: 458 RVA: 0x0000C854 File Offset: 0x0000AA54
	public override void OnLoad()
	{
	}

	// Token: 0x060001CB RID: 459 RVA: 0x0000C858 File Offset: 0x0000AA58
	private void Start()
	{
		this.bounds = base.transform.parent.collider.bounds;
	}

	// Token: 0x060001CC RID: 460 RVA: 0x0000C880 File Offset: 0x0000AA80
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x060001CD RID: 461 RVA: 0x0000C888 File Offset: 0x0000AA88
	public override void Init()
	{
		if (this.healthbar == null)
		{
			this.healthbar = base.GetComponentInChildren<PhoneShooterHealthbar>();
		}
		this.healthbar.monster = this;
		this.healthbar.renderer.material.color = this.color;
	}

	// Token: 0x060001CE RID: 462 RVA: 0x0000C8DC File Offset: 0x0000AADC
	public virtual void SetMonster(PhoneMonster monstero)
	{
		this.monster = monstero;
		this.health = this.maxhealth;
		this.SetSpriteSet(this.monster.spriteset);
		this.SetScaling(this.monster.scale);
		this.DoAnimation();
	}

	// Token: 0x060001CF RID: 463 RVA: 0x0000C924 File Offset: 0x0000AB24
	public virtual void SetScaling(Vector2 scale)
	{
		if (this.startscale == Vector3.zero)
		{
			this.startscale = base.transform.localScale;
		}
		Vector3 localScale = this.startscale;
		localScale.x *= scale.x;
		localScale.z *= scale.y;
		base.transform.localScale = localScale;
	}

	// Token: 0x060001D0 RID: 464 RVA: 0x0000C994 File Offset: 0x0000AB94
	public virtual void SetSpriteSet(SpriteSet spriteset)
	{
		this.sprite_player.SetSpriteSet(spriteset);
	}

	// Token: 0x060001D1 RID: 465 RVA: 0x0000C9A4 File Offset: 0x0000ABA4
	public virtual void SetImage(Texture2D image)
	{
		this.sprite_obj.renderer.material.mainTexture = image;
	}

	// Token: 0x060001D2 RID: 466 RVA: 0x0000C9BC File Offset: 0x0000ABBC
	public override void OnUpdate()
	{
		this.healthbar.OnUpdate();
		this.DoAnimation();
	}

	// Token: 0x060001D3 RID: 467 RVA: 0x0000C9D0 File Offset: 0x0000ABD0
	public virtual void DoAnimation()
	{
		this.sprite_player.UpdateMat(this.sprite_obj.renderer.material);
		this.DoColor();
	}

	// Token: 0x060001D4 RID: 468 RVA: 0x0000CA00 File Offset: 0x0000AC00
	public virtual void DoColor()
	{
		if (this.sprite_color.a < 1f)
		{
			Color sprite_color = this.sprite_color;
			sprite_color.a = Mathf.Lerp(1f, 0f, Mathf.Min(this.damage_timer, 1f));
			this.sprite_color = sprite_color;
		}
		this.damage_timer = Mathf.Max(0f, this.damage_timer - Time.deltaTime * 15f);
	}

	// Token: 0x17000031 RID: 49
	// (get) Token: 0x060001D5 RID: 469 RVA: 0x0000CA7C File Offset: 0x0000AC7C
	// (set) Token: 0x060001D6 RID: 470 RVA: 0x0000CA94 File Offset: 0x0000AC94
	public Color sprite_color
	{
		get
		{
			return this.sprite_obj.renderer.material.color;
		}
		set
		{
			this.sprite_obj.renderer.material.color = value;
		}
	}

	// Token: 0x060001D7 RID: 471 RVA: 0x0000CAAC File Offset: 0x0000ACAC
	public virtual void LimitPos()
	{
		this.LimitPos(this.bounds);
	}

	// Token: 0x060001D8 RID: 472 RVA: 0x0000CABC File Offset: 0x0000ACBC
	public virtual void LimitPos(Bounds boundslimit)
	{
		base.transform.position = this.LimitPos(base.transform.position, boundslimit);
	}

	// Token: 0x060001D9 RID: 473 RVA: 0x0000CAE8 File Offset: 0x0000ACE8
	public virtual Vector3 LimitPos(Vector3 pos, Bounds boundslimit)
	{
		for (int i = 0; i < 3; i += 2)
		{
			pos[i] = Mathf.Max(boundslimit.min[i], Mathf.Min(pos[i], boundslimit.max[i]));
		}
		return pos;
	}

	// Token: 0x060001DA RID: 474 RVA: 0x0000CB44 File Offset: 0x0000AD44
	public virtual void Heal(float amount)
	{
		this.health = Mathf.Min(this.health + amount, this.maxhealth);
	}

	// Token: 0x060001DB RID: 475 RVA: 0x0000CB60 File Offset: 0x0000AD60
	public virtual PhoneShooterBullet Shoot(Vector3 direction)
	{
		return this.Shoot(direction, this.magic / 2f);
	}

	// Token: 0x060001DC RID: 476 RVA: 0x0000CB78 File Offset: 0x0000AD78
	public virtual PhoneShooterBullet Shoot(Vector3 direction, float damage)
	{
		PhoneShooterBullet phoneShooterBullet = UnityEngine.Object.Instantiate(this.bulletprefab, base.transform.position, Quaternion.identity) as PhoneShooterBullet;
		phoneShooterBullet.owner = this;
		phoneShooterBullet.velocity = direction * this.bullet_speed;
		phoneShooterBullet.damage = damage;
		phoneShooterBullet.homing = this.bullet_homing;
		phoneShooterBullet.renderer.material.color = this.color;
		phoneShooterBullet.transform.parent = base.transform.parent;
		if (this.target_trans)
		{
			phoneShooterBullet.target = this.target_trans;
		}
		return phoneShooterBullet;
	}

	// Token: 0x060001DD RID: 477 RVA: 0x0000CC1C File Offset: 0x0000AE1C
	public virtual void ResetShootTimer()
	{
		this.shoot_timer = (this.shoot_cooldown - 0.95f * this.shoot_cooldown * (this.magic / 750f)) / this.monster.bullet_cooldown;
	}

	// Token: 0x060001DE RID: 478 RVA: 0x0000CC5C File Offset: 0x0000AE5C
	public virtual void Damage(PhoneShooterBullet bullet)
	{
		float damage = bullet.damage;
		this.health -= damage;
		this.sprite_color = new Color(1f, 1f, 1f, 0f);
		this.damage_timer = 2f;
		if (this.health <= 0f)
		{
			this.OnDeath(bullet);
		}
		else
		{
			this.monster.defenseStat.Grow(damage / 160f);
		}
		PhoneAudioController.PlayAudioClip("hit", SoundType.game);
	}

	// Token: 0x060001DF RID: 479 RVA: 0x0000CCE8 File Offset: 0x0000AEE8
	public virtual PhoneLabel ShowText(Vector3 vec, string stext, float time, Color tcolor, bool outline)
	{
		PhoneLabel phoneLabel = UnityEngine.Object.Instantiate(PhoneShooterController.slabel_prefab) as PhoneLabel;
		phoneLabel.transform.position = vec;
		phoneLabel.transform.parent = base.transform.parent;
		phoneLabel.textmesh.text = stext;
		phoneLabel.textmesh.characterSize = 1f;
		phoneLabel.overrideColor = true;
		phoneLabel.color = tcolor;
		phoneLabel.velocity = Vector3.forward;
		UnityEngine.Object.Destroy(phoneLabel.gameObject, time);
		if (outline)
		{
			Vector3 vec2 = vec + new Vector3(0.02f, -0.02f, -0.02f);
			this.ShowText(vec2, stext, time, Color.black, false);
		}
		return phoneLabel;
	}

	// Token: 0x17000032 RID: 50
	// (get) Token: 0x060001E0 RID: 480 RVA: 0x0000CD9C File Offset: 0x0000AF9C
	public float exp_value
	{
		get
		{
			return this.maxhealth;
		}
	}

	// Token: 0x060001E1 RID: 481 RVA: 0x0000CDA4 File Offset: 0x0000AFA4
	public virtual void OnDeath(PhoneShooterBullet bullet)
	{
		if (bullet.GetType() == typeof(PhoneShooterAttack))
		{
			bullet.owner.monster.attackStat.Grow(this.exp_value / 400f);
		}
		else
		{
			bullet.owner.monster.magicStat.Grow(this.exp_value / 500f);
		}
		this.OnDeath();
	}

	// Token: 0x060001E2 RID: 482 RVA: 0x0000CE14 File Offset: 0x0000B014
	public virtual void OnDeath()
	{
		PhoneController.EmitParts(base.transform.position, (int)(2f + Mathf.Ceil(this.monster.level / 4f)));
		PhoneEffects.AddCamShake(this.monster.level / 20f);
		PhoneAudioController.PlayAudioClip("enemy_die", SoundType.game);
		if (this.deathdrop_prefab && !this.controller.battle_mode)
		{
			PhoneShooterPickup phoneShooterPickup = UnityEngine.Object.Instantiate(this.deathdrop_prefab) as PhoneShooterPickup;
			phoneShooterPickup.transform.position = base.transform.position + Vector3.down * 0.5f;
			phoneShooterPickup.transform.parent = base.transform.parent;
			phoneShooterPickup.Resize(1, (int)Mathf.Max(Mathf.Pow(this.monster.level, 1.25f), 3f));
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x060001E3 RID: 483 RVA: 0x0000CF14 File Offset: 0x0000B114
	private void OnTriggerEnter(Collider other)
	{
		this.HandleCollision(other);
	}

	// Token: 0x060001E4 RID: 484 RVA: 0x0000CF20 File Offset: 0x0000B120
	private void OnTriggerStay(Collider other)
	{
		PhoneShooterBullet component = other.gameObject.GetComponent<PhoneShooterBullet>();
		if (component != null)
		{
			this.Collide_Bullet(component);
			return;
		}
	}

	// Token: 0x060001E5 RID: 485 RVA: 0x0000CF50 File Offset: 0x0000B150
	public virtual void HandleCollision(Collider other)
	{
		PhoneShooterPickup component = other.gameObject.GetComponent<PhoneShooterPickup>();
		if (component != null)
		{
			this.Collide_Pickup(component);
			return;
		}
		PhoneShooterEnemy component2 = other.gameObject.GetComponent<PhoneShooterEnemy>();
		if (component2 != null)
		{
			this.Collide_Enemy(component2);
		}
	}

	// Token: 0x060001E6 RID: 486 RVA: 0x0000CF9C File Offset: 0x0000B19C
	public virtual void Collide_Bullet(PhoneShooterBullet obullet)
	{
		if (obullet.owner.isplayer != this.isplayer)
		{
			obullet.OnHit(this);
		}
	}

	// Token: 0x060001E7 RID: 487 RVA: 0x0000CFBC File Offset: 0x0000B1BC
	public virtual void Collide_Pickup(PhoneShooterPickup pickup)
	{
	}

	// Token: 0x060001E8 RID: 488 RVA: 0x0000CFC0 File Offset: 0x0000B1C0
	public virtual void Collide_Enemy(PhoneShooterEnemy enemy)
	{
	}

	// Token: 0x040001E5 RID: 485
	public PhoneShooterController controller;

	// Token: 0x040001E6 RID: 486
	public SpritePlayer sprite_player = new SpritePlayer();

	// Token: 0x040001E7 RID: 487
	public bool isplayer;

	// Token: 0x040001E8 RID: 488
	public float health = 2f;

	// Token: 0x040001E9 RID: 489
	public float speed = 2f;

	// Token: 0x040001EA RID: 490
	public float shoot_cooldown = 0.33333334f;

	// Token: 0x040001EB RID: 491
	protected float shoot_timer;

	// Token: 0x040001EC RID: 492
	public float attack_timer;

	// Token: 0x040001ED RID: 493
	public Transform sprite_obj;

	// Token: 0x040001EE RID: 494
	public PhoneShooterPickup deathdrop_prefab;

	// Token: 0x040001EF RID: 495
	public PhoneShooterHealthbar healthbar;

	// Token: 0x040001F0 RID: 496
	public Color color = Color.red;

	// Token: 0x040001F1 RID: 497
	public PhoneShooterBullet bulletprefab;

	// Token: 0x040001F2 RID: 498
	public PhoneMonster monster;

	// Token: 0x040001F3 RID: 499
	public Bounds bounds;

	// Token: 0x040001F4 RID: 500
	private Vector3 startscale = Vector3.zero;

	// Token: 0x040001F5 RID: 501
	private float damage_timer;

	// Token: 0x040001F6 RID: 502
	public Transform target_trans;
}
