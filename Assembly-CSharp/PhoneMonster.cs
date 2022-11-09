using System;
using UnityEngine;

// Token: 0x02000040 RID: 64
public class PhoneMonster
{
	// Token: 0x06000238 RID: 568 RVA: 0x0000FF14 File Offset: 0x0000E114
	public PhoneMonster()
	{
		this.GenerateStats();
	}

	// Token: 0x06000239 RID: 569 RVA: 0x0000FF7C File Offset: 0x0000E17C
	public PhoneMonster(float lev)
	{
		this.level = lev;
		this.GenerateStats();
	}

	// Token: 0x0600023A RID: 570 RVA: 0x0000FFEC File Offset: 0x0000E1EC
	public PhoneMonster(MonsterType montype)
	{
		this.monsterType = montype;
		this.GenerateStats();
	}

	// Token: 0x0600023B RID: 571 RVA: 0x0001005C File Offset: 0x0000E25C
	public PhoneMonster(MonsterType montype, float lev)
	{
		this.level = lev;
		this.monsterType = montype;
		this.GenerateStats();
	}

	// Token: 0x17000038 RID: 56
	// (get) Token: 0x0600023C RID: 572 RVA: 0x000100D4 File Offset: 0x0000E2D4
	// (set) Token: 0x0600023D RID: 573 RVA: 0x000100EC File Offset: 0x0000E2EC
	public Vector2 scale
	{
		get
		{
			return this.monsterType.scaleMod * this._scale;
		}
		set
		{
			this._scale = value;
		}
	}

	// Token: 0x17000039 RID: 57
	// (get) Token: 0x0600023E RID: 574 RVA: 0x000100F8 File Offset: 0x0000E2F8
	// (set) Token: 0x0600023F RID: 575 RVA: 0x0001010C File Offset: 0x0000E30C
	public float speed
	{
		get
		{
			return this.monsterType.speedMod * this._speed;
		}
		set
		{
			this._speed = value;
		}
	}

	// Token: 0x1700003A RID: 58
	// (get) Token: 0x06000240 RID: 576 RVA: 0x00010118 File Offset: 0x0000E318
	public SpriteSet spriteset
	{
		get
		{
			return this.monsterType.spriteSet;
		}
	}

	// Token: 0x1700003B RID: 59
	// (get) Token: 0x06000241 RID: 577 RVA: 0x00010128 File Offset: 0x0000E328
	public bool flying_animate
	{
		get
		{
			return this.monsterType.flyingAnimate;
		}
	}

	// Token: 0x1700003C RID: 60
	// (get) Token: 0x06000242 RID: 578 RVA: 0x00010138 File Offset: 0x0000E338
	public MonsterTraits.Name name
	{
		get
		{
			return this.traits.name;
		}
	}

	// Token: 0x1700003D RID: 61
	// (get) Token: 0x06000243 RID: 579 RVA: 0x00010148 File Offset: 0x0000E348
	public MonsterTraits.BloodType bloodtype
	{
		get
		{
			return this.traits.bloodtype;
		}
	}

	// Token: 0x1700003E RID: 62
	// (get) Token: 0x06000244 RID: 580 RVA: 0x00010158 File Offset: 0x0000E358
	// (set) Token: 0x06000245 RID: 581 RVA: 0x00010164 File Offset: 0x0000E364
	public MonsterStat attackStat
	{
		get
		{
			return this.stats[0];
		}
		set
		{
			this.stats[0] = value;
		}
	}

	// Token: 0x1700003F RID: 63
	// (get) Token: 0x06000246 RID: 582 RVA: 0x00010170 File Offset: 0x0000E370
	// (set) Token: 0x06000247 RID: 583 RVA: 0x0001017C File Offset: 0x0000E37C
	public MonsterStat defenseStat
	{
		get
		{
			return this.stats[1];
		}
		set
		{
			this.stats[1] = value;
		}
	}

	// Token: 0x17000040 RID: 64
	// (get) Token: 0x06000248 RID: 584 RVA: 0x00010188 File Offset: 0x0000E388
	// (set) Token: 0x06000249 RID: 585 RVA: 0x00010194 File Offset: 0x0000E394
	public MonsterStat magicStat
	{
		get
		{
			return this.stats[2];
		}
		set
		{
			this.stats[2] = value;
		}
	}

	// Token: 0x17000041 RID: 65
	// (get) Token: 0x0600024A RID: 586 RVA: 0x000101A0 File Offset: 0x0000E3A0
	// (set) Token: 0x0600024B RID: 587 RVA: 0x000101AC File Offset: 0x0000E3AC
	public MonsterStat glamStat
	{
		get
		{
			return this.stats[3];
		}
		set
		{
			this.stats[3] = value;
		}
	}

	// Token: 0x17000042 RID: 66
	// (get) Token: 0x0600024C RID: 588 RVA: 0x000101B8 File Offset: 0x0000E3B8
	public float attack
	{
		get
		{
			return this.attackStat.current;
		}
	}

	// Token: 0x17000043 RID: 67
	// (get) Token: 0x0600024D RID: 589 RVA: 0x000101C8 File Offset: 0x0000E3C8
	public float defense
	{
		get
		{
			return this.defenseStat.current;
		}
	}

	// Token: 0x17000044 RID: 68
	// (get) Token: 0x0600024E RID: 590 RVA: 0x000101D8 File Offset: 0x0000E3D8
	public float magic
	{
		get
		{
			return this.magicStat.current;
		}
	}

	// Token: 0x17000045 RID: 69
	// (get) Token: 0x0600024F RID: 591 RVA: 0x000101E8 File Offset: 0x0000E3E8
	public float glam
	{
		get
		{
			return this.glamStat.current;
		}
	}

	// Token: 0x06000250 RID: 592 RVA: 0x000101F8 File Offset: 0x0000E3F8
	public void GenerateType()
	{
		this.monsterType = PhoneResourceController.RandomMonsterType();
	}

	// Token: 0x06000251 RID: 593 RVA: 0x00010208 File Offset: 0x0000E408
	public void GenerateTraits()
	{
		this.traits = new MonsterTraits();
	}

	// Token: 0x06000252 RID: 594 RVA: 0x00010218 File Offset: 0x0000E418
	public void GenerateImage()
	{
	}

	// Token: 0x06000253 RID: 595 RVA: 0x0001021C File Offset: 0x0000E41C
	public void GenerateStats()
	{
		if (this.monsterType == null)
		{
			this.GenerateType();
		}
		for (int i = 0; i < 4; i++)
		{
			float num = this.monsterType.statMods[i];
			MonsterStat monsterStat = new MonsterStat();
			this.stats[i] = monsterStat;
			monsterStat.statMod = num;
			monsterStat.max = 25f + Mathf.Pow(this.level, 1.5f) * UnityEngine.Random.Range(9f, 11f) * num;
			monsterStat.current = monsterStat.remaining * UnityEngine.Random.Range(0.05f, 0.16f);
			monsterStat.potential = monsterStat.remaining * UnityEngine.Random.Range(0.25f, 0.45f);
			monsterStat.max = Mathf.Clamp(monsterStat.max * UnityEngine.Random.Range(1.5f, 1.6f), 35f, 100f);
			monsterStat.locked = monsterStat.remaining;
		}
		this.GenerateTraits();
	}

	// Token: 0x06000254 RID: 596 RVA: 0x00010314 File Offset: 0x0000E514
	public void GenerateScale()
	{
		float num = 0.1f;
		this.scale = Vector2.right * (1f + UnityEngine.Random.Range(-num, num)) + Vector2.up * (1f + UnityEngine.Random.Range(-num, num));
	}

	// Token: 0x06000255 RID: 597 RVA: 0x00010364 File Offset: 0x0000E564
	public static string GetSavePrefix(int index)
	{
		return string.Format("monster{0}_", index.ToString());
	}

	// Token: 0x06000256 RID: 598 RVA: 0x00010378 File Offset: 0x0000E578
	public static bool SaveDataExists(int index)
	{
		return PlayerPrefs.HasKey(string.Format("{0}namef", PhoneMonster.GetSavePrefix(index)));
	}

	// Token: 0x06000257 RID: 599 RVA: 0x00010390 File Offset: 0x0000E590
	public bool SaveMonster(int index)
	{
		string savePrefix = PhoneMonster.GetSavePrefix(index);
		PlayerPrefs.SetString(savePrefix + "version", PhoneInterface.version);
		PlayerPrefs.SetString(savePrefix + "namef", this.traits.name.firstname);
		PlayerPrefs.SetString(savePrefix + "namel", this.traits.name.lastname);
		PlayerPrefs.SetString(savePrefix + "monster_type", this.monsterType.typeName);
		PlayerPrefs.SetFloat(savePrefix + "level", this.level);
		PlayerPrefs.SetString(savePrefix + "blood", this.traits.bloodtype);
		PlayerPrefs.SetString(savePrefix + "attack_stat", this.attackStat.ToSaveString());
		PlayerPrefs.SetString(savePrefix + "defense_stat", this.defenseStat.ToSaveString());
		PlayerPrefs.SetString(savePrefix + "magic_stat", this.magicStat.ToSaveString());
		PlayerPrefs.SetString(savePrefix + "glam_stat", this.glamStat.ToSaveString());
		PlayerPrefs.SetFloat(savePrefix + "scale_x", this._scale.x);
		PlayerPrefs.SetFloat(savePrefix + "scale_y", this._scale.y);
		PlayerPrefs.SetFloat(savePrefix + "speed", this._speed);
		PlayerPrefs.SetFloat(savePrefix + "bullet_speed", this.bullet_speed);
		PlayerPrefs.SetFloat(savePrefix + "bullet_cooldown", this.bullet_cooldown);
		PlayerPrefs.SetFloat(savePrefix + "bullet_homing", this.bullet_homing);
		return true;
	}

	// Token: 0x06000258 RID: 600 RVA: 0x00010548 File Offset: 0x0000E748
	public static PhoneMonster LoadMonster(int index)
	{
		string savePrefix = PhoneMonster.GetSavePrefix(index);
		PhoneMonster phoneMonster = new PhoneMonster();
		phoneMonster.traits.name.firstname = PlayerPrefs.GetString(savePrefix + "namef");
		phoneMonster.traits.name.lastname = PlayerPrefs.GetString(savePrefix + "namel");
		string @string = PlayerPrefs.GetString(savePrefix + "monster_type", string.Empty);
		if (@string == string.Empty)
		{
			phoneMonster.monsterType = PhoneResourceController.RandomMonsterType();
		}
		else
		{
			phoneMonster.monsterType = PhoneResourceController.GetMonsterType(@string);
		}
		phoneMonster.level = PlayerPrefs.GetFloat(savePrefix + "level");
		phoneMonster.bloodtype.typename = PlayerPrefs.GetString(savePrefix + "blood");
		phoneMonster.attackStat = MonsterStat.LoadFromString(PlayerPrefs.GetString(savePrefix + "attack_stat"));
		phoneMonster.defenseStat = MonsterStat.LoadFromString(PlayerPrefs.GetString(savePrefix + "defense_stat"));
		phoneMonster.magicStat = MonsterStat.LoadFromString(PlayerPrefs.GetString(savePrefix + "magic_stat"));
		phoneMonster.glamStat = MonsterStat.LoadFromString(PlayerPrefs.GetString(savePrefix + "glam_stat"));
		for (int i = 0; i < 4; i++)
		{
			phoneMonster.stats[i].statMod = phoneMonster.monsterType.statMods[i];
		}
		Vector2 scale = new Vector2(PlayerPrefs.GetFloat(savePrefix + "scale_x", 1f), PlayerPrefs.GetFloat(savePrefix + "scale_y", 1f));
		phoneMonster.scale = scale;
		phoneMonster.speed = PlayerPrefs.GetFloat(savePrefix + "speed", 1f);
		phoneMonster.bullet_speed = PlayerPrefs.GetFloat(savePrefix + "bullet_speed", 1f);
		phoneMonster.bullet_cooldown = PlayerPrefs.GetFloat(savePrefix + "bullet_cooldown", 1f);
		phoneMonster.bullet_homing = PlayerPrefs.GetFloat(savePrefix + "bullet_homing", 1f);
		return phoneMonster;
	}

	// Token: 0x0400021E RID: 542
	public float level = 1f;

	// Token: 0x0400021F RID: 543
	public Vector2 _scale = Vector2.one;

	// Token: 0x04000220 RID: 544
	public float _speed = 1f;

	// Token: 0x04000221 RID: 545
	public MonsterType monsterType;

	// Token: 0x04000222 RID: 546
	public float bullet_speed = 1f;

	// Token: 0x04000223 RID: 547
	public float bullet_cooldown = 1f;

	// Token: 0x04000224 RID: 548
	public float bullet_homing = 1f;

	// Token: 0x04000225 RID: 549
	public MonsterTraits traits;

	// Token: 0x04000226 RID: 550
	public MonsterStat[] stats = new MonsterStat[4];
}
