using System;
using UnityEngine;

// Token: 0x02000034 RID: 52
public class PhoneShooterExp : PhoneElement
{
	// Token: 0x17000026 RID: 38
	// (get) Token: 0x060001B0 RID: 432 RVA: 0x0000C2C8 File Offset: 0x0000A4C8
	// (set) Token: 0x060001B1 RID: 433 RVA: 0x0000C2D8 File Offset: 0x0000A4D8
	public float attack_exp
	{
		get
		{
			return this.exp_vals[0];
		}
		set
		{
			this.exp_vals[0] = value;
		}
	}

	// Token: 0x17000027 RID: 39
	// (get) Token: 0x060001B2 RID: 434 RVA: 0x0000C2E8 File Offset: 0x0000A4E8
	// (set) Token: 0x060001B3 RID: 435 RVA: 0x0000C2F8 File Offset: 0x0000A4F8
	public float defense_exp
	{
		get
		{
			return this.exp_vals[1];
		}
		set
		{
			this.exp_vals[1] = value;
		}
	}

	// Token: 0x17000028 RID: 40
	// (get) Token: 0x060001B4 RID: 436 RVA: 0x0000C308 File Offset: 0x0000A508
	// (set) Token: 0x060001B5 RID: 437 RVA: 0x0000C318 File Offset: 0x0000A518
	public float magic_exp
	{
		get
		{
			return this.exp_vals[2];
		}
		set
		{
			this.exp_vals[2] = value;
		}
	}

	// Token: 0x17000029 RID: 41
	// (get) Token: 0x060001B6 RID: 438 RVA: 0x0000C328 File Offset: 0x0000A528
	// (set) Token: 0x060001B7 RID: 439 RVA: 0x0000C338 File Offset: 0x0000A538
	public float glam_exp
	{
		get
		{
			return this.exp_vals[3];
		}
		set
		{
			this.exp_vals[3] = value;
		}
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000C348 File Offset: 0x0000A548
	private void Start()
	{
		this.ChooseRandom();
	}

	// Token: 0x060001B9 RID: 441 RVA: 0x0000C350 File Offset: 0x0000A550
	public override void OnUpdate()
	{
		this.Display();
	}

	// Token: 0x060001BA RID: 442 RVA: 0x0000C358 File Offset: 0x0000A558
	public virtual void Resize()
	{
		Vector3 a = base.transform.localScale.normalized;
		a *= this.exp_vals.magnitude / 5f;
	}

	// Token: 0x060001BB RID: 443 RVA: 0x0000C394 File Offset: 0x0000A594
	public virtual void ChooseRandom()
	{
		this.exp_vals = Vector4.zero;
		int index = UnityEngine.Random.Range(0, 4);
		this.exp_vals[index] = UnityEngine.Random.Range(0.5f, 1f);
	}

	// Token: 0x060001BC RID: 444 RVA: 0x0000C3D0 File Offset: 0x0000A5D0
	public virtual void Randomize()
	{
		for (int i = 0; i < 4; i++)
		{
			this.exp_vals[i] = UnityEngine.Random.Range(0.25f, 0.75f);
		}
	}

	// Token: 0x060001BD RID: 445 RVA: 0x0000C40C File Offset: 0x0000A60C
	public virtual void OnUsed(PhoneShooterMonster monster)
	{
		string text = string.Empty;
		for (int i = 0; i < 4; i++)
		{
			text = text + "+" + this.exp_vals[i].ToString(".0") + "\n";
			monster.monster.stats[i].Grow(this.exp_vals[i]);
		}
		monster.ShowText(base.transform.position + Vector3.up * 4f, text, 0.25f, this.color, true);
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x060001BE RID: 446 RVA: 0x0000C4B8 File Offset: 0x0000A6B8
	public virtual void Display()
	{
		Vector4 normalized = this.exp_vals;
		normalized = this.exp_vals.normalized;
		this.color = new Color(normalized[0], normalized[1], normalized[2], 1f - UnityEngine.Random.Range(0f, normalized[3]));
		base.renderer.material.color = this.color;
	}

	// Token: 0x040001DE RID: 478
	public Vector4 exp_vals = Vector4.zero;

	// Token: 0x040001DF RID: 479
	public Color color;
}
