using System;
using UnityEngine;

// Token: 0x02000037 RID: 55
public class PhoneShooterPickup : PhoneElement
{
	// Token: 0x060001EB RID: 491 RVA: 0x0000D008 File Offset: 0x0000B208
	private void Awake()
	{
		if (this.sprites.Length > 0)
		{
			this.ChooseSprite();
		}
	}

	// Token: 0x060001EC RID: 492 RVA: 0x0000D020 File Offset: 0x0000B220
	private void Start()
	{
		if (!this._inited)
		{
			this.ChooseRandom();
			this.Resize();
		}
		this.Display();
	}

	// Token: 0x060001ED RID: 493 RVA: 0x0000D040 File Offset: 0x0000B240
	public override void OnUpdate()
	{
		if (this.magnet_timer > 0f)
		{
			this.magnet_timer -= PhoneElement.deltatime;
			if (this.magnet_timer <= 0f)
			{
				this.allow_magnet = true;
			}
		}
	}

	// Token: 0x060001EE RID: 494 RVA: 0x0000D07C File Offset: 0x0000B27C
	public virtual void Resize(float newamount)
	{
		this.givehealth = newamount;
		this.Resize();
	}

	// Token: 0x060001EF RID: 495 RVA: 0x0000D08C File Offset: 0x0000B28C
	public virtual void Resize(int low, int high)
	{
		this.givehealth = (float)UnityEngine.Random.Range(low, high);
		this.Resize();
	}

	// Token: 0x060001F0 RID: 496 RVA: 0x0000D0A4 File Offset: 0x0000B2A4
	public virtual void Resize()
	{
		this._inited = true;
		Vector3 normalized = base.transform.localScale.normalized;
		this.size = 2.5f + this.givehealth / 12f;
		base.transform.localScale = normalized * this.size;
	}

	// Token: 0x060001F1 RID: 497 RVA: 0x0000D0FC File Offset: 0x0000B2FC
	public virtual void ChooseSprite()
	{
		this.sprite_index = UnityEngine.Random.Range(0, this.sprites.Length);
		base.renderer.material.mainTexture = this.sprites[this.sprite_index];
		base.name = "food_" + this.sprites[this.sprite_index].name;
	}

	// Token: 0x060001F2 RID: 498 RVA: 0x0000D15C File Offset: 0x0000B35C
	public virtual void ChooseRandom()
	{
		this.givehealth = (float)UnityEngine.Random.Range(1, 4);
	}

	// Token: 0x060001F3 RID: 499 RVA: 0x0000D16C File Offset: 0x0000B36C
	public virtual void Randomize()
	{
		this.givehealth = UnityEngine.Random.Range(1f, 4f);
	}

	// Token: 0x060001F4 RID: 500 RVA: 0x0000D184 File Offset: 0x0000B384
	public virtual void OnUsed(PhoneShooterMonster monster)
	{
		float num = this.givehealth;
		if ("food_" + monster.monster.bloodtype == base.name)
		{
			num *= 1.5f;
			string stext = "Tasty!";
			monster.ShowText(base.transform.position + Vector3.up * 4f + Vector3.forward * 0.25f, stext, 0.5f, Color.yellow, true);
		}
		string stext2 = "+" + num.ToString("0.0");
		monster.ShowText(base.transform.position + Vector3.up * 4f, stext2, 0.25f, this.color, true);
		if (PhoneShooterPickup.weight_gain_enabled)
		{
			Vector2 scale = monster.monster.scale;
			scale.x += num / (scale.x * scale.x) / 500f;
			monster.monster.scale = scale;
			monster.SetScaling(monster.monster.scale);
		}
		monster.Heal(num);
		PhoneAudioController.PlayAudioClip("health_up", SoundType.game);
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x060001F5 RID: 501 RVA: 0x0000D2D8 File Offset: 0x0000B4D8
	public virtual void Display()
	{
	}

	// Token: 0x060001F6 RID: 502 RVA: 0x0000D2DC File Offset: 0x0000B4DC
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == base.name)
		{
			Vector3 position = (base.transform.position + other.transform.position) / 2f;
			PhoneShooterPickup component = other.gameObject.GetComponent<PhoneShooterPickup>();
			if (this.givehealth >= component.givehealth)
			{
				this.givehealth += component.givehealth * 1.1f;
				this.Resize();
				UnityEngine.Object.Destroy(component.gameObject);
				base.transform.position = position;
			}
			else
			{
				component.givehealth += this.givehealth * 1.1f;
				component.Resize();
				component.transform.position = position;
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}
	}

	// Token: 0x040001F7 RID: 503
	public Color color = Color.green;

	// Token: 0x040001F8 RID: 504
	public float givehealth = 2f;

	// Token: 0x040001F9 RID: 505
	public float size = 1f;

	// Token: 0x040001FA RID: 506
	public bool _inited;

	// Token: 0x040001FB RID: 507
	public Texture2D[] sprites;

	// Token: 0x040001FC RID: 508
	public int sprite_index;

	// Token: 0x040001FD RID: 509
	public bool allow_magnet;

	// Token: 0x040001FE RID: 510
	private float magnet_timer = 1f;

	// Token: 0x040001FF RID: 511
	private static bool weight_gain_enabled;
}
