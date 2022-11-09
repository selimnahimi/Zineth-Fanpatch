using System;
using UnityEngine;

// Token: 0x02000033 RID: 51
public class PhoneShooterEnemy : PhoneShooterMonster
{
	// Token: 0x06000194 RID: 404 RVA: 0x0000BB60 File Offset: 0x00009D60
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x17000024 RID: 36
	// (get) Token: 0x06000195 RID: 405 RVA: 0x0000BB68 File Offset: 0x00009D68
	private PhoneShooterMonster playerobj
	{
		get
		{
			return this.controller.player_object;
		}
	}

	// Token: 0x06000196 RID: 406 RVA: 0x0000BB78 File Offset: 0x00009D78
	private void Start()
	{
		this.bounds = base.transform.parent.collider.bounds;
	}

	// Token: 0x06000197 RID: 407 RVA: 0x0000BBA0 File Offset: 0x00009DA0
	public override void OnUpdate()
	{
		this.DoAI();
		this.DoAnimation();
		this.healthbar.OnUpdate();
	}

	// Token: 0x06000198 RID: 408 RVA: 0x0000BBBC File Offset: 0x00009DBC
	protected virtual void DoAI()
	{
		if (this.playerobj)
		{
			this.target_trans = this.playerobj.transform;
		}
		this.DoMove();
		this.DoShoot();
	}

	// Token: 0x17000025 RID: 37
	// (get) Token: 0x06000199 RID: 409 RVA: 0x0000BBF8 File Offset: 0x00009DF8
	public MonsterAI aiType
	{
		get
		{
			return this.monster.monsterType.monsterAI;
		}
	}

	// Token: 0x0600019A RID: 410 RVA: 0x0000BC0C File Offset: 0x00009E0C
	protected virtual void DoMove()
	{
		this.sprite_player.animation_name = "walk";
		if (this.monster.flying_animate)
		{
			this.sprite_player.play_speed = 0.2f;
		}
		else
		{
			this.sprite_player.play_speed = 0f;
		}
		if (this.aiType == MonsterAI.Goto)
		{
			this.MoveToPlayer();
		}
		else if (this.aiType == MonsterAI.Run)
		{
			this.MoveAwayFromPlayer();
		}
		else if (this.aiType == MonsterAI.Circle)
		{
			this.MoveCircle();
		}
		else if (this.aiType == MonsterAI.CircleCW)
		{
			this.MoveCircleCW();
		}
		else if (this.aiType == MonsterAI.Horizontal)
		{
			this.MoveHorizontal();
		}
		else if (this.aiType == MonsterAI.Vertical)
		{
			this.MoveVertical();
		}
		else if (this.aiType == MonsterAI.Mirror)
		{
			this.MoveMirror();
		}
		else if (this.aiType == MonsterAI.Jitter)
		{
			this.MoveJitter();
		}
		this.LimitPos();
	}

	// Token: 0x0600019B RID: 411 RVA: 0x0000BD18 File Offset: 0x00009F18
	public override void OnDeath()
	{
		this.controller.wave++;
		base.OnDeath();
	}

	// Token: 0x0600019C RID: 412 RVA: 0x0000BD34 File Offset: 0x00009F34
	protected virtual void MoveToPlayer()
	{
		if (this.playerobj)
		{
			this.MoveTowardsPoint(this.playerobj.transform.position);
		}
	}

	// Token: 0x0600019D RID: 413 RVA: 0x0000BD68 File Offset: 0x00009F68
	protected virtual void MoveAwayFromPlayer()
	{
		if (this.playerobj)
		{
			Vector3 position = this.playerobj.transform.position;
			if (Vector3.Distance(position, base.transform.position) <= 2f)
			{
				this.MoveFromPoint(position);
			}
		}
	}

	// Token: 0x0600019E RID: 414 RVA: 0x0000BDB8 File Offset: 0x00009FB8
	protected virtual void MoveHorizontal()
	{
		if (this.playerobj)
		{
			Vector3 position = this.playerobj.transform.position;
			position.z = base.transform.position.z;
			this.MoveTowardsPoint(position);
		}
	}

	// Token: 0x0600019F RID: 415 RVA: 0x0000BE08 File Offset: 0x0000A008
	protected virtual void MoveVertical()
	{
		if (this.playerobj)
		{
			Vector3 position = this.playerobj.transform.position;
			position.x = base.transform.position.x;
			this.MoveTowardsPoint(position);
		}
	}

	// Token: 0x060001A0 RID: 416 RVA: 0x0000BE58 File Offset: 0x0000A058
	protected virtual void MoveMirror()
	{
		if (this.playerobj)
		{
			Vector3 position = this.playerobj.transform.localPosition * -1f;
			Vector3 vector = this.playerobj.transform.parent.TransformPoint(position);
			vector.y = base.transform.position.y;
			Debug.DrawLine(base.transform.position, vector);
			this.MoveTowardsPoint(vector);
		}
	}

	// Token: 0x060001A1 RID: 417 RVA: 0x0000BEDC File Offset: 0x0000A0DC
	protected virtual void MoveCircle()
	{
		this.MoveCircle(this.circleSpeed);
	}

	// Token: 0x060001A2 RID: 418 RVA: 0x0000BEEC File Offset: 0x0000A0EC
	protected virtual void MoveCircleCW()
	{
		this.MoveCircleCW(this.circleSpeed);
	}

	// Token: 0x060001A3 RID: 419 RVA: 0x0000BEFC File Offset: 0x0000A0FC
	protected virtual void MoveCircleCW(float anglespeed)
	{
		this.MoveCircle(-anglespeed);
	}

	// Token: 0x060001A4 RID: 420 RVA: 0x0000BF08 File Offset: 0x0000A108
	protected virtual void MoveCircle(float anglespeed)
	{
		if (this.playerobj)
		{
			Vector3 position = this.playerobj.transform.position;
			Vector3 vector = base.transform.position - position;
			float num = vector.magnitude;
			num = Mathf.Max(num, 1f);
			float num2 = Mathf.Atan2(vector.z, vector.x);
			num2 -= anglespeed;
			vector.x = Mathf.Cos(num2) * num;
			vector.z = Mathf.Sin(num2) * num;
			vector.y = 0f;
			vector += position;
			this.MoveTowardsPoint(vector);
		}
	}

	// Token: 0x060001A5 RID: 421 RVA: 0x0000BFB0 File Offset: 0x0000A1B0
	protected virtual void MoveJitter()
	{
		this.MoveJitter(1f);
	}

	// Token: 0x060001A6 RID: 422 RVA: 0x0000BFC0 File Offset: 0x0000A1C0
	protected Vector3 RandomPosition()
	{
		Vector3 zero = Vector3.zero;
		for (int i = 0; i < 3; i++)
		{
			zero[i] = UnityEngine.Random.Range(this.bounds.min[i], this.bounds.max[i]);
		}
		return zero;
	}

	// Token: 0x060001A7 RID: 423 RVA: 0x0000C01C File Offset: 0x0000A21C
	protected virtual void MoveJitter(float amount)
	{
		if (Vector3.Distance(base.transform.position, this.storePos) <= 0.5f || UnityEngine.Random.value < 0.05f * (PhoneElement.deltatime / 0.016666668f))
		{
			this.storePos = Vector3.zero;
		}
		if (this.storePos == Vector3.zero)
		{
			this.storePos = this.RandomPosition();
			this.storePos.y = base.transform.position.y;
		}
		Vector3 vector = this.storePos - base.transform.position;
		Vector2 vector2 = new Vector2(vector.x, vector.z);
		vector2 = Vector2.ClampMagnitude(vector2, 1f + this.monster.level / 2f);
		vector2 += UnityEngine.Random.insideUnitCircle * amount;
		this.MoveByVec(vector2);
	}

	// Token: 0x060001A8 RID: 424 RVA: 0x0000C114 File Offset: 0x0000A314
	protected virtual void MoveTowardsPoint(Vector3 pos)
	{
		this.MoveByVec((pos - base.transform.position).normalized);
	}

	// Token: 0x060001A9 RID: 425 RVA: 0x0000C140 File Offset: 0x0000A340
	protected virtual void MoveFromPoint(Vector3 pos)
	{
		this.MoveByVec((base.transform.position - pos).normalized);
	}

	// Token: 0x060001AA RID: 426 RVA: 0x0000C16C File Offset: 0x0000A36C
	protected virtual void MoveByVec(Vector2 vec)
	{
		this.MoveByVec(new Vector3(vec.x, 0f, vec.y));
	}

	// Token: 0x060001AB RID: 427 RVA: 0x0000C18C File Offset: 0x0000A38C
	protected virtual void MoveByVec(Vector3 vec)
	{
		this.MoveByVecRaw(vec * base.realspeed);
	}

	// Token: 0x060001AC RID: 428 RVA: 0x0000C1A0 File Offset: 0x0000A3A0
	protected virtual void MoveByVecRaw(Vector3 vec)
	{
		base.transform.position += vec * PhoneElement.deltatime;
		if (this.monster.flying_animate)
		{
			this.sprite_player.play_speed = 0.5f + vec.magnitude * 0.5f;
		}
		else
		{
			this.sprite_player.play_speed = vec.magnitude;
		}
	}

	// Token: 0x060001AD RID: 429 RVA: 0x0000C214 File Offset: 0x0000A414
	protected virtual void DoShoot()
	{
		this.shoot_timer = Mathf.Max(0f, this.shoot_timer - PhoneElement.deltatime);
		if (this.shoot_timer <= 0f && this.ShootAtPlayer())
		{
			this.ResetShootTimer();
		}
	}

	// Token: 0x060001AE RID: 430 RVA: 0x0000C254 File Offset: 0x0000A454
	protected virtual bool ShootAtPlayer()
	{
		if (!this.playerobj)
		{
			return false;
		}
		Vector3 normalized = (this.playerobj.transform.position - base.transform.position).normalized;
		this.Shoot(normalized, base.magic / 2f);
		return true;
	}

	// Token: 0x040001DC RID: 476
	private float circleSpeed = 0.3926991f;

	// Token: 0x040001DD RID: 477
	protected Vector3 storePos = Vector3.zero;
}
