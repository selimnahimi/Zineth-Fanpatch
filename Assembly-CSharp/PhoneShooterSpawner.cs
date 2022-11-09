using System;
using UnityEngine;

// Token: 0x02000039 RID: 57
public class PhoneShooterSpawner : PhoneElement
{
	// Token: 0x0600020A RID: 522 RVA: 0x0000DD38 File Offset: 0x0000BF38
	private void Start()
	{
		this.Reset();
		this.SetColor(this.color);
	}

	// Token: 0x0600020B RID: 523 RVA: 0x0000DD4C File Offset: 0x0000BF4C
	public void Reset()
	{
		this.timer = this.timerlength;
	}

	// Token: 0x0600020C RID: 524 RVA: 0x0000DD5C File Offset: 0x0000BF5C
	public void SetColor(Color col)
	{
		this.color = col;
		base.renderer.material.color = this.color;
	}

	// Token: 0x0600020D RID: 525 RVA: 0x0000DD7C File Offset: 0x0000BF7C
	public override void OnUpdate()
	{
		this.timer -= PhoneElement.deltatime;
		if (this.timer <= 0f)
		{
			this.Spawn();
			if (this.repeat)
			{
				this.Reset();
			}
			else
			{
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}
		this.Display();
	}

	// Token: 0x0600020E RID: 526 RVA: 0x0000DDDC File Offset: 0x0000BFDC
	public virtual PhoneShooterMonster Spawn()
	{
		PhoneShooterMonster phoneShooterMonster = UnityEngine.Object.Instantiate(this.prefab, base.transform.position + this.offset, Quaternion.identity) as PhoneShooterMonster;
		phoneShooterMonster.transform.parent = base.transform.parent;
		phoneShooterMonster.SetMonster(this.monster);
		phoneShooterMonster.controller = this.controller;
		PhoneController.EmitParts(base.transform.position, 6 + (int)this.monster.level);
		return phoneShooterMonster;
	}

	// Token: 0x0600020F RID: 527 RVA: 0x0000DE64 File Offset: 0x0000C064
	protected virtual void Display()
	{
		float num = this.timerlength - Mathf.Max(this.timer, 0.25f);
		if (this.timer < 0.25f)
		{
			num += this.timer * 2f;
		}
		num *= 1.5f;
		num = Mathf.Ceil(num * 8f) / 8f;
		base.transform.localScale = base.transform.localScale.normalized * num;
	}

	// Token: 0x04000203 RID: 515
	public PhoneShooterController controller;

	// Token: 0x04000204 RID: 516
	public PhoneShooterMonster prefab;

	// Token: 0x04000205 RID: 517
	public PhoneMonster monster;

	// Token: 0x04000206 RID: 518
	public float timerlength = 2f;

	// Token: 0x04000207 RID: 519
	private float timer = 2f;

	// Token: 0x04000208 RID: 520
	public bool repeat;

	// Token: 0x04000209 RID: 521
	public Color color = Color.black;

	// Token: 0x0400020A RID: 522
	public Vector3 offset = Vector3.zero;
}
