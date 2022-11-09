using System;
using UnityEngine;

// Token: 0x020000A6 RID: 166
internal class VibrateForce
{
	// Token: 0x060006F3 RID: 1779 RVA: 0x0002C9FC File Offset: 0x0002ABFC
	public VibrateForce(float force, float time)
	{
		this.lpower = force;
		this.rpower = force;
		this.life = time;
		this.startlife = this.life;
	}

	// Token: 0x060006F4 RID: 1780 RVA: 0x0002CA64 File Offset: 0x0002AC64
	public VibrateForce(float force, float time, bool decaying)
	{
		this.lpower = force;
		this.rpower = force;
		this.life = time;
		this.startlife = this.life;
		this.decay = decaying;
	}

	// Token: 0x060006F5 RID: 1781 RVA: 0x0002CAD4 File Offset: 0x0002ACD4
	public VibrateForce(float left, float right, float time)
	{
		this.lpower = left;
		this.rpower = right;
		this.life = time;
		this.startlife = this.life;
	}

	// Token: 0x060006F6 RID: 1782 RVA: 0x0002CB3C File Offset: 0x0002AD3C
	public VibrateForce(float left, float right, float time, bool decaying)
	{
		this.lpower = left;
		this.rpower = right;
		this.life = time;
		this.startlife = this.life;
		this.decay = decaying;
	}

	// Token: 0x060006F7 RID: 1783 RVA: 0x0002CBAC File Offset: 0x0002ADAC
	public virtual Vector2 OnUpdate()
	{
		if (this.life <= 0f)
		{
			return Vector2.zero;
		}
		float x = this.lpower;
		float y = this.rpower;
		if (this.decay)
		{
			x = Mathf.Lerp(0f, this.lpower, this.life / this.startlife);
			y = Mathf.Lerp(0f, this.rpower, this.life / this.startlife);
		}
		this.life -= Time.deltaTime;
		return new Vector2(x, y);
	}

	// Token: 0x040005CB RID: 1483
	public float life = 0.1f;

	// Token: 0x040005CC RID: 1484
	protected float startlife = 0.1f;

	// Token: 0x040005CD RID: 1485
	public float lpower = 0.1f;

	// Token: 0x040005CE RID: 1486
	public float rpower = 0.1f;

	// Token: 0x040005CF RID: 1487
	public bool decay = true;

	// Token: 0x040005D0 RID: 1488
	public bool is_phone;
}
