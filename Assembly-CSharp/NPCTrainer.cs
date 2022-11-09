using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002E RID: 46
public class NPCTrainer : NPCBehavior
{
	// Token: 0x06000144 RID: 324 RVA: 0x00009CE4 File Offset: 0x00007EE4
	public virtual void InitMonster()
	{
		if (this.monsterTypeName != string.Empty && PhoneResourceController.instance.monsterTypeDic.ContainsKey(this.monsterTypeName))
		{
			MonsterType monsterType = PhoneResourceController.GetMonsterType(this.monsterTypeName);
			this.monster = new PhoneMonster(monsterType, this.level);
		}
		else
		{
			this.monster = new PhoneMonster(this.level);
		}
		if (this.monster_first_name != string.Empty)
		{
			this.monster.name.firstname = this.monster_first_name;
		}
		if (this.monster_last_name != string.Empty)
		{
			this.monster.name.lastname = this.monster_last_name;
		}
		if (!this.auto_gen_traits)
		{
			this.monster.scale = this.scale;
			this.monster.speed = this.speed;
			this.monster.bullet_speed = this.bullet_speed;
			this.monster.bullet_cooldown = this.bullet_cooldown;
			this.monster.bullet_homing = this.bullet_homing;
			if (this.bloodtype != string.Empty)
			{
				this.monster.traits.bloodtype.typename = this.bloodtype;
			}
		}
		if (!this.auto_gen_stats)
		{
			this.monster.attackStat.current = this.attack;
			this.monster.defenseStat.current = this.defense;
			this.monster.magicStat.current = this.magic;
			this.monster.glamStat.current = this.glam;
		}
		this.levelobj = new PhoneShooterLevel(this);
	}

	// Token: 0x1700001D RID: 29
	// (get) Token: 0x06000145 RID: 325 RVA: 0x00009EAC File Offset: 0x000080AC
	public static Transform player_trans
	{
		get
		{
			return PhoneInterface.player_trans;
		}
	}

	// Token: 0x06000146 RID: 326 RVA: 0x00009EB4 File Offset: 0x000080B4
	private void Awake()
	{
		if (this.include_in_lists && !NPCTrainer.all_list.Contains(this))
		{
			NPCTrainer.all_list.Add(this);
		}
	}

	// Token: 0x06000147 RID: 327 RVA: 0x00009EE8 File Offset: 0x000080E8
	private void Start()
	{
		base.Init();
		this.InitMonster();
		this.challengeTimer = 1f + UnityEngine.Random.value;
		this.LoadMyInfo();
	}

	// Token: 0x1700001E RID: 30
	// (get) Token: 0x06000148 RID: 328 RVA: 0x00009F18 File Offset: 0x00008118
	// (set) Token: 0x06000149 RID: 329 RVA: 0x00009F34 File Offset: 0x00008134
	public bool can_challenge
	{
		get
		{
			return this._can_challege && !this.defeated;
		}
		set
		{
			this._can_challege = value;
		}
	}

	// Token: 0x0600014A RID: 330 RVA: 0x00009F40 File Offset: 0x00008140
	public virtual void ChallengeUpdate()
	{
		if (this.CheckBattling())
		{
			this.SetBubbleTexture(this.battling_icon);
			this.icon_bubble.renderer.material.SetVector("_BounceSpeed", new Vector4(0f, 0f, 1.5f, 0f));
		}
		else if (this.CheckChallenging())
		{
			this.icon_bubble.renderer.material.SetVector("_BounceSpeed", new Vector4(0f, 0f, 3f, 0f));
			this.Challenge();
		}
		else
		{
			this.icon_bubble.renderer.material.SetVector("_BounceSpeed", new Vector4(0f, 0f, 1f, 0f));
			this.UnChallenge();
		}
	}

	// Token: 0x0600014B RID: 331 RVA: 0x0000A020 File Offset: 0x00008220
	public virtual bool CheckBattling()
	{
		return PhoneMemory.IsBattlingTrainer(this);
	}

	// Token: 0x0600014C RID: 332 RVA: 0x0000A028 File Offset: 0x00008228
	public virtual bool CheckChallenging()
	{
		return this.can_challenge && (NPCTrainer.player_trans && Vector3.Distance(base.transform.position, NPCTrainer.player_trans.position) <= this.max_distance);
	}

	// Token: 0x0600014D RID: 333 RVA: 0x0000A07C File Offset: 0x0000827C
	public virtual void Challenge()
	{
		if (PhoneMemory.MonsterChallenge(this) && this.auto_battle)
		{
			PhoneInterface.SendPhoneCommand("open_phone GameScreen");
		}
		if (PhoneMemory.trainer_challenge == this)
		{
			this.SetBubbleTexture(this.near_icon);
		}
	}

	// Token: 0x0600014E RID: 334 RVA: 0x0000A0BC File Offset: 0x000082BC
	public virtual void UnChallenge()
	{
		if (PhoneMemory.WithdrawChallenge(this))
		{
			this.SetBubbleTexture(this.waiting_icon);
		}
	}

	// Token: 0x0600014F RID: 335 RVA: 0x0000A0D8 File Offset: 0x000082D8
	private void Update()
	{
		if (this.can_challenge)
		{
			if (this.challengeTimer <= 0f)
			{
				this.ChallengeUpdate();
				this.challengeTimer += 0.25f;
			}
			this.challengeTimer -= Time.deltaTime;
		}
		else
		{
			base.HideBubble();
		}
		if (this.reinitmonster)
		{
			this.InitMonster();
			this.reinitmonster = false;
		}
	}

	// Token: 0x06000150 RID: 336 RVA: 0x0000A150 File Offset: 0x00008350
	public void OnDefeated()
	{
		if (!string.IsNullOrEmpty(this.win_command))
		{
			PhoneController.DoPhoneCommand(this.win_command);
		}
		PhoneMemory.AddCapsulePoints(3f);
		this.RemoveBadge();
		this.SaveMyInfo();
		Playtomic.Log.CustomMetric("trainer_defeated_" + this.GetSaveName());
	}

	// Token: 0x06000151 RID: 337 RVA: 0x0000A1AC File Offset: 0x000083AC
	public void GiveBadge()
	{
		this.can_challenge = true;
		this.defeated = false;
		base.ShowBubble();
		if (this.include_in_lists && NPCTrainer.defeated_list.Contains(this))
		{
			NPCTrainer.defeated_list.Remove(this);
		}
	}

	// Token: 0x06000152 RID: 338 RVA: 0x0000A1F4 File Offset: 0x000083F4
	public void RemoveBadge()
	{
		this.can_challenge = false;
		this.defeated = true;
		base.HideBubble();
		PhoneMemory.WithdrawChallenge(this);
		if (this.include_in_lists && !NPCTrainer.defeated_list.Contains(this))
		{
			NPCTrainer.defeated_list.Add(this);
		}
	}

	// Token: 0x06000153 RID: 339 RVA: 0x0000A244 File Offset: 0x00008444
	public string GetSaveName()
	{
		return string.Format("npc_{0}", base.name.Replace("NPC_Trainer_", string.Empty));
	}

	// Token: 0x06000154 RID: 340 RVA: 0x0000A268 File Offset: 0x00008468
	public string GetSaveString()
	{
		return this.monster.name;
	}

	// Token: 0x06000155 RID: 341 RVA: 0x0000A27C File Offset: 0x0000847C
	public void SaveMyInfo()
	{
		if (this.enable_saving)
		{
			PlayerPrefs.SetString(this.GetSaveName(), this.GetSaveString());
			PlayerPrefs.Save();
		}
	}

	// Token: 0x06000156 RID: 342 RVA: 0x0000A2A0 File Offset: 0x000084A0
	public void LoadMyInfo()
	{
		if (this.enable_saving)
		{
			string @string = PlayerPrefs.GetString(this.GetSaveName(), string.Empty);
			if (@string != string.Empty)
			{
				this.RemoveBadge();
			}
		}
	}

	// Token: 0x04000190 RID: 400
	public static List<NPCTrainer> all_list = new List<NPCTrainer>();

	// Token: 0x04000191 RID: 401
	public static List<NPCTrainer> defeated_list = new List<NPCTrainer>();

	// Token: 0x04000192 RID: 402
	public PhoneMonster monster;

	// Token: 0x04000193 RID: 403
	public bool auto_gen_traits = true;

	// Token: 0x04000194 RID: 404
	public string monster_first_name = string.Empty;

	// Token: 0x04000195 RID: 405
	public string monster_last_name = string.Empty;

	// Token: 0x04000196 RID: 406
	public float level = 1f;

	// Token: 0x04000197 RID: 407
	public float speed = 1f;

	// Token: 0x04000198 RID: 408
	public float bullet_speed = 1f;

	// Token: 0x04000199 RID: 409
	public float bullet_cooldown = 1f;

	// Token: 0x0400019A RID: 410
	public float bullet_homing;

	// Token: 0x0400019B RID: 411
	public string bloodtype = string.Empty;

	// Token: 0x0400019C RID: 412
	public string spriteset = string.Empty;

	// Token: 0x0400019D RID: 413
	public string monsterTypeName = string.Empty;

	// Token: 0x0400019E RID: 414
	public Vector2 scale = Vector2.one;

	// Token: 0x0400019F RID: 415
	public bool auto_gen_stats = true;

	// Token: 0x040001A0 RID: 416
	public float attack;

	// Token: 0x040001A1 RID: 417
	public float defense;

	// Token: 0x040001A2 RID: 418
	public float magic;

	// Token: 0x040001A3 RID: 419
	public float glam;

	// Token: 0x040001A4 RID: 420
	public Texture2D level_bg;

	// Token: 0x040001A5 RID: 421
	public string win_command = string.Empty;

	// Token: 0x040001A6 RID: 422
	public bool auto_battle = true;

	// Token: 0x040001A7 RID: 423
	public bool include_in_lists = true;

	// Token: 0x040001A8 RID: 424
	public bool enable_saving = true;

	// Token: 0x040001A9 RID: 425
	public PhoneShooterLevel levelobj;

	// Token: 0x040001AA RID: 426
	private bool _can_challege = true;

	// Token: 0x040001AB RID: 427
	public bool defeated;

	// Token: 0x040001AC RID: 428
	public float max_distance = 16f;

	// Token: 0x040001AD RID: 429
	public Texture2D waiting_icon;

	// Token: 0x040001AE RID: 430
	public Texture2D near_icon;

	// Token: 0x040001AF RID: 431
	public Texture2D battling_icon;

	// Token: 0x040001B0 RID: 432
	public bool reinitmonster = true;

	// Token: 0x040001B1 RID: 433
	private float challengeTimer = 1f;
}
