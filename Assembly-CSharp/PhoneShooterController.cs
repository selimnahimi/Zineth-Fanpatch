using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000032 RID: 50
public class PhoneShooterController : PhoneScreen
{
	// Token: 0x1700001F RID: 31
	// (get) Token: 0x0600016B RID: 363 RVA: 0x0000A7F4 File Offset: 0x000089F4
	public PhoneShooterLevel current_level
	{
		get
		{
			return PhoneMemory.level_obj;
		}
	}

	// Token: 0x17000020 RID: 32
	// (get) Token: 0x0600016C RID: 364 RVA: 0x0000A7FC File Offset: 0x000089FC
	public int score
	{
		get
		{
			return this.wave * 100;
		}
	}

	// Token: 0x17000021 RID: 33
	// (get) Token: 0x0600016D RID: 365 RVA: 0x0000A808 File Offset: 0x00008A08
	// (set) Token: 0x0600016E RID: 366 RVA: 0x0000A810 File Offset: 0x00008A10
	public int wave
	{
		get
		{
			return this._wave;
		}
		set
		{
			this._wave = value;
			PhoneMemory.phoneGameScore = this.score;
		}
	}

	// Token: 0x0600016F RID: 367 RVA: 0x0000A824 File Offset: 0x00008A24
	public override void Init()
	{
		foreach (PhoneLabel phoneLabel in new PhoneLabel[]
		{
			this.attack_stat_label,
			this.defense_stat_label,
			this.magic_stat_label,
			this.glam_stat_label,
			this.wave_label,
			this.attack_tip_label
		})
		{
			if (phoneLabel)
			{
				this.stat_elements.Add(phoneLabel);
				if (phoneLabel.shadow_label)
				{
					this.stat_elements.Add(phoneLabel.shadow_label);
				}
			}
		}
	}

	// Token: 0x06000170 RID: 368 RVA: 0x0000A8C0 File Offset: 0x00008AC0
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.battle_mode = (this.current_level.trainer != null);
		this.enemy_level = this.current_level.difficulty;
		this.StartGame();
		foreach (PhoneElement phoneElement in this.stat_elements)
		{
			PhoneLabel phoneLabel = (PhoneLabel)phoneElement;
			phoneLabel.text = string.Empty;
		}
		if (this.attack_tip_label && PlayerPrefs.HasKey("phone_shooter_tut"))
		{
			this.attack_tip_count = 3;
		}
		if (this.attack_tip_count < 3)
		{
			this.attack_tip_count = 0;
		}
		Playtomic.Log.CustomMetric("tPhoneGamePlays", "tPhone", false);
		if (this.battle_mode)
		{
			Playtomic.Log.CustomMetric("tBattleModeStarted", "tPhone", true);
			Playtomic.Log.CustomMetric("tBattleModePlays", "tPhone", false);
		}
	}

	// Token: 0x17000022 RID: 34
	// (get) Token: 0x06000171 RID: 369 RVA: 0x0000A9EC File Offset: 0x00008BEC
	private PhoneMonster battle_enemy_monster
	{
		get
		{
			if (PhoneMemory.trainer_challenge)
			{
				return PhoneMemory.trainer_challenge.monster;
			}
			return null;
		}
	}

	// Token: 0x06000172 RID: 370 RVA: 0x0000AA0C File Offset: 0x00008C0C
	public void StartGame()
	{
		this.SetBackground();
		this.player_object = this.SpawnPlayer();
		this.enemytimer = 2f;
		PhoneShooterController.slabel_prefab = this.label_prefab;
		this.paused = false;
		this.gameovertimer = 0f;
		this.wave = 0;
		if (this.battle_mode)
		{
			this.battle_start_timer = 2f;
			this.wave_label.text = string.Empty;
		}
	}

	// Token: 0x06000173 RID: 371 RVA: 0x0000AA80 File Offset: 0x00008C80
	public override void OnExit()
	{
		foreach (PhoneElement phoneElement in base.gameObject.GetComponentsInChildren<PhoneElement>())
		{
			if (!this.stat_elements.Contains(phoneElement))
			{
				UnityEngine.Object.Destroy(phoneElement.gameObject);
			}
		}
		PhoneMemory.SaveMonsters();
		this.wave = 0;
		base.OnExit();
	}

	// Token: 0x06000174 RID: 372 RVA: 0x0000AAE0 File Offset: 0x00008CE0
	public override void OnPause()
	{
		this.BeginPause();
	}

	// Token: 0x06000175 RID: 373 RVA: 0x0000AAE8 File Offset: 0x00008CE8
	private void BeginPause()
	{
		PhoneMemory.SaveMonsters();
		if (this.textlabel == null)
		{
			this.textlabel = (UnityEngine.Object.Instantiate(this.label_prefab) as PhoneLabel);
			this.textlabel.transform.position = base.transform.position + Vector3.up * 4f;
			this.textlabel.transform.parent = base.transform;
		}
		this.textlabel.textmesh.characterSize = 1f;
		this.textlabel.textmesh.alignment = TextAlignment.Center;
		this.textlabel.textmesh.anchor = TextAnchor.MiddleCenter;
		this.textlabel.text = "Touch to Resume";
		foreach (PhoneLabel phoneLabel in new PhoneLabel[]
		{
			this.attack_stat_label,
			this.defense_stat_label,
			this.magic_stat_label,
			this.glam_stat_label
		})
		{
			phoneLabel.gameObject.active = true;
			if (phoneLabel.shadow_label)
			{
				phoneLabel.shadow_label.gameObject.active = true;
			}
			phoneLabel.CancelInvoke("Hide");
		}
		this.paused = true;
	}

	// Token: 0x06000176 RID: 374 RVA: 0x0000AC30 File Offset: 0x00008E30
	private void EndPause()
	{
		if (this.textlabel)
		{
			UnityEngine.Object.Destroy(this.textlabel.gameObject);
		}
		foreach (PhoneLabel phoneLabel in new PhoneLabel[]
		{
			this.attack_stat_label,
			this.defense_stat_label,
			this.magic_stat_label,
			this.glam_stat_label
		})
		{
			phoneLabel.Invoke("Hide", 1f);
		}
		this.paused = false;
	}

	// Token: 0x06000177 RID: 375 RVA: 0x0000ACB8 File Offset: 0x00008EB8
	public virtual void SetBackground()
	{
		this.SetBackground(this.current_level);
	}

	// Token: 0x06000178 RID: 376 RVA: 0x0000ACC8 File Offset: 0x00008EC8
	public virtual void SetBackground(PhoneShooterLevel level)
	{
		this.SetBackground(level.texture);
	}

	// Token: 0x06000179 RID: 377 RVA: 0x0000ACD8 File Offset: 0x00008ED8
	public virtual void SetBackground(Texture2D texture)
	{
		if (this.background_trans)
		{
			this.background_trans.renderer.material.mainTexture = texture;
		}
	}

	// Token: 0x0600017A RID: 378 RVA: 0x0000AD0C File Offset: 0x00008F0C
	public bool CheckGameOver()
	{
		return this.player_object == null;
	}

	// Token: 0x0600017B RID: 379 RVA: 0x0000AD1C File Offset: 0x00008F1C
	public bool CheckWin()
	{
		return this.battle_mode && this.battle_enemy_object == null && this.wave > 0;
	}

	// Token: 0x0600017C RID: 380 RVA: 0x0000AD54 File Offset: 0x00008F54
	public override void UpdateScreen()
	{
		if (this.paused)
		{
			if (PhoneInput.IsPressedDown())
			{
				this.EndPause();
			}
		}
		else
		{
			if (this.attack_tip_label && this.player_object)
			{
				if (this.player_object.attack_timer > 0f && this.attack_tip_ready)
				{
					this.attack_tip_count++;
					this.attack_tip_ready = false;
				}
				else if (this.player_object.attack_timer <= 0f)
				{
					this.attack_tip_ready = true;
				}
				if (this.attack_tip_count >= 3)
				{
					PlayerPrefs.SetInt("phone_shooter_tut", 1);
					PlayerPrefs.Save();
					this.stat_elements.Remove(this.attack_tip_label);
					UnityEngine.Object.Destroy(this.attack_tip_label.gameObject);
				}
				else
				{
					this.attack_tip_label.text = string.Format("Click to Attack ({0}/3)", this.attack_tip_count.ToString());
				}
			}
			if (this.battle_mode && this.battle_start_timer > 0f && !this.attack_tip_label)
			{
				this.OnBattleIntro();
				foreach (PhoneElement phoneElement in this.stat_elements)
				{
					phoneElement.OnUpdate();
				}
			}
			else
			{
				this.GameUpdate();
				this.UpdateElements();
				this.CheckStats();
				if (this.wave_label && !this.attack_tip_label)
				{
					if (this.battle_mode)
					{
						this.wave_label.text = string.Empty;
					}
					else
					{
						this.wave_label.text = string.Format("{0:000000}", this.score);
					}
				}
				if (this.CheckWin())
				{
					this.OnGameWin();
				}
				else if (this.CheckGameOver())
				{
					this.OnGameOver();
				}
			}
		}
	}

	// Token: 0x0600017D RID: 381 RVA: 0x0000AF84 File Offset: 0x00009184
	public virtual void GameUpdate()
	{
		if (this.battle_mode)
		{
			this.BattleEnemyUpdate();
		}
		else
		{
			this.EnemyUpdate();
		}
	}

	// Token: 0x0600017E RID: 382 RVA: 0x0000AFA4 File Offset: 0x000091A4
	public virtual void EnemyUpdate()
	{
		this.SpawnEnemies();
	}

	// Token: 0x0600017F RID: 383 RVA: 0x0000AFAC File Offset: 0x000091AC
	public virtual void BattleEnemyUpdate()
	{
	}

	// Token: 0x06000180 RID: 384 RVA: 0x0000AFB0 File Offset: 0x000091B0
	private string StatString(float stat)
	{
		return stat.ToString("0.0");
	}

	// Token: 0x06000181 RID: 385 RVA: 0x0000AFC0 File Offset: 0x000091C0
	private void CheckStats()
	{
		this.DoShowStat(this.attack_stat_label, "Atk: ", this.playermonster.attackStat);
		this.DoShowStat(this.defense_stat_label, "Def: ", this.playermonster.defenseStat);
		this.DoShowStat(this.magic_stat_label, "Mag: ", this.playermonster.magicStat);
		this.DoShowStat(this.glam_stat_label, "Glm: ", this.playermonster.glamStat);
	}

	// Token: 0x06000182 RID: 386 RVA: 0x0000B040 File Offset: 0x00009240
	private void DoShowStat(PhoneLabel label, string txt, MonsterStat statobj)
	{
		string text = txt + this.StatString(statobj.current);
		if (statobj.potential <= 0f)
		{
			text += "(MAX)";
		}
		if (!label)
		{
			return;
		}
		if (label.text != text || statobj.extra >= 0.1f)
		{
			if (statobj.extra >= 0.1f)
			{
				statobj.extra -= 0.1f;
			}
			label.animateOnLoad = true;
			if (label.animateOnLoad)
			{
				label.transform.position += base.transform.forward * -0.25f;
			}
			label.gameObject.active = true;
			if (label.shadow_label)
			{
				label.shadow_label.gameObject.active = true;
			}
			label.text = text;
			label.CancelInvoke("Hide");
			label.Invoke("Hide", 1f);
		}
	}

	// Token: 0x06000183 RID: 387 RVA: 0x0000B15C File Offset: 0x0000935C
	private void DoShowStat(PhoneLabel label, string txt, float stat)
	{
		string text = txt + this.StatString(stat);
		if (!label)
		{
			return;
		}
		if (label.text != text)
		{
			label.animateOnLoad = true;
			if (label.animateOnLoad)
			{
				label.transform.position += base.transform.forward * -0.25f;
			}
			label.gameObject.active = true;
			if (label.shadow_label)
			{
				label.shadow_label.gameObject.active = true;
			}
			label.text = text;
			label.CancelInvoke("Hide");
			label.Invoke("Hide", 1f);
		}
	}

	// Token: 0x06000184 RID: 388 RVA: 0x0000B220 File Offset: 0x00009420
	public virtual void OnBattleIntro()
	{
		if (this.battle_enemy_object == null)
		{
			Vector3 vector = this.RandomSpawnPoint();
			while (Vector3.Distance(this.player_object.transform.position, vector) < 1f)
			{
				vector = this.RandomSpawnPoint();
			}
			this.battle_enemy_object = this.SpawnBoss(this.battle_enemy_monster, vector);
		}
		this.battle_start_timer -= base.deltatime;
		if (this.textlabel == null)
		{
			this.textlabel = (UnityEngine.Object.Instantiate(this.label_prefab) as PhoneLabel);
			this.textlabel.transform.position = base.transform.position + Vector3.up * 4f + Vector3.forward * 1f;
			this.textlabel.transform.parent = base.transform;
			this.textlabel.textmesh.alignment = TextAlignment.Center;
			this.textlabel.textmesh.anchor = TextAnchor.MiddleCenter;
			this.textlabel.textmesh.characterSize = 4f;
		}
		string text = Mathf.FloorToInt(this.battle_start_timer * 1.5f + 1f).ToString();
		if (this.textlabel.text != text)
		{
			this.textlabel.text = text;
		}
		if (this.battle_start_timer <= 0f && this.textlabel)
		{
			UnityEngine.Object.Destroy(this.textlabel.gameObject);
		}
	}

	// Token: 0x06000185 RID: 389 RVA: 0x0000B3C0 File Offset: 0x000095C0
	public virtual void OnGameWin()
	{
		if (this.gameovertimer <= 0f)
		{
			PhoneAudioController.PlayAudioClip("win", SoundType.game);
			if (this.battle_mode)
			{
				for (int i = 0; i < 4; i++)
				{
					PhoneMemory.main_monster.stats[i].Grow(this.current_level.trainer.monster.level / 40f);
				}
			}
			if (this.current_level.trainer)
			{
				this.current_level.trainer.OnDefeated();
			}
		}
		this.gameovertimer += base.deltatime;
		if (this.gameovertimer >= 0.25f)
		{
			if (this.textlabel == null)
			{
				this.textlabel = (UnityEngine.Object.Instantiate(this.label_prefab) as PhoneLabel);
				this.textlabel.transform.position = base.transform.position + Vector3.up * 4f;
				this.textlabel.transform.parent = base.transform;
			}
			this.textlabel.textmesh.characterSize = 2.5f;
			string text = this.textlabel.text;
			this.textlabel.text = "You";
			if (this.gameovertimer >= 1f)
			{
				this.textlabel.text = "You\n\nWin!";
			}
			if (text != this.textlabel.text)
			{
				PhoneEffects.AddCamShake(0.2f);
			}
			this.textlabel.textmesh.alignment = TextAlignment.Center;
			this.textlabel.textmesh.anchor = TextAnchor.MiddleCenter;
		}
		if (this.gameovertimer > 0.75f && PhoneInput.IsPressedDown())
		{
			UnityEngine.Object.Destroy(this.textlabel.gameObject);
			this.controller.LoadScreen("Game");
		}
	}

	// Token: 0x06000186 RID: 390 RVA: 0x0000B5B4 File Offset: 0x000097B4
	public virtual void OnGameOver()
	{
		if (this.gameovertimer <= 0f)
		{
			PhoneAudioController.PlayAudioClip("die", SoundType.game);
		}
		this.gameovertimer += base.deltatime;
		if (this.gameovertimer >= 0.25f)
		{
			if (this.textlabel == null)
			{
				this.textlabel = (UnityEngine.Object.Instantiate(this.label_prefab) as PhoneLabel);
				this.textlabel.transform.position = base.transform.position + Vector3.up * 4f;
				this.textlabel.transform.parent = base.transform;
			}
			this.textlabel.textmesh.characterSize = 2.5f;
			string text = this.textlabel.text;
			this.textlabel.text = "Game";
			if (this.gameovertimer >= 1f)
			{
				this.textlabel.text = "Game\n\nOver!";
			}
			if (text != this.textlabel.text)
			{
				PhoneEffects.AddCamShake(0.2f);
			}
			this.textlabel.textmesh.alignment = TextAlignment.Center;
			this.textlabel.textmesh.anchor = TextAnchor.MiddleCenter;
		}
		if (this.gameovertimer > 0.5f && PhoneInput.IsPressedDown())
		{
			UnityEngine.Object.Destroy(this.textlabel.gameObject);
			this.controller.LoadScreen("Game");
		}
	}

	// Token: 0x06000187 RID: 391 RVA: 0x0000B73C File Offset: 0x0000993C
	private void SpawnEnemies()
	{
		if (this.attack_tip_label)
		{
			return;
		}
		if (this.spawn_new)
		{
			this.SpawnEnemy();
		}
		this.spawn_new = false;
		this.enemytimer = Mathf.Max(0f, this.enemytimer - base.deltatime);
		if (this.enemytimer <= 0f)
		{
			int num = Mathf.Min(1 + (int)Mathf.Pow((float)this.wave, 0.25f), 10);
			int num2 = base.transform.GetComponentsInChildren(typeof(PhoneShooterEnemy)).Length;
			num2 += base.transform.GetComponentsInChildren(typeof(PhoneShooterSpawner)).Length;
			if (num2 < num)
			{
				this.SpawnEnemy();
				this.enemytimer = UnityEngine.Random.Range(0.15f, 2f);
			}
			else
			{
				this.enemytimer = UnityEngine.Random.Range(0.15f, 0.75f);
			}
		}
	}

	// Token: 0x06000188 RID: 392 RVA: 0x0000B82C File Offset: 0x00009A2C
	private void UpdateElements()
	{
		foreach (PhoneElement phoneElement in base.gameObject.GetComponentsInChildren<PhoneElement>())
		{
			phoneElement.OnUpdate();
			if (phoneElement.name.Contains("Enemy") || phoneElement.name.StartsWith("food_") || phoneElement.name.Contains("Bullet") || phoneElement.name.Contains("Player") || phoneElement.name.Contains("Attack"))
			{
				Vector3 localPosition = phoneElement.transform.localPosition;
				localPosition.y = 5f + (base.transform.position.z - phoneElement.renderer.bounds.min.z) / 100f;
				if (phoneElement.transform.localPosition != localPosition)
				{
					phoneElement.transform.localPosition = localPosition;
				}
			}
		}
	}

	// Token: 0x17000023 RID: 35
	// (get) Token: 0x06000189 RID: 393 RVA: 0x0000B940 File Offset: 0x00009B40
	private PhoneMonster playermonster
	{
		get
		{
			return PhoneMemory.main_monster;
		}
	}

	// Token: 0x0600018A RID: 394 RVA: 0x0000B948 File Offset: 0x00009B48
	private PhoneMonster GetMonster()
	{
		return this.GetMonster((float)this.enemy_level + (float)this.wave / 50f);
	}

	// Token: 0x0600018B RID: 395 RVA: 0x0000B968 File Offset: 0x00009B68
	private PhoneMonster GetMonster(float level)
	{
		return new PhoneMonster(this.current_level.RandomMonsterType(), level);
	}

	// Token: 0x0600018C RID: 396 RVA: 0x0000B97C File Offset: 0x00009B7C
	public Vector3 RandomSpawnPoint()
	{
		Vector3 result = default(Vector3);
		for (int i = 0; i < 3; i++)
		{
			result[i] = UnityEngine.Random.Range(base.collider.bounds.min[i], base.collider.bounds.max[i]);
		}
		result.y = base.transform.position.y + 1f;
		return result;
	}

	// Token: 0x0600018D RID: 397 RVA: 0x0000BA0C File Offset: 0x00009C0C
	private void SpawnEnemy()
	{
		this.SpawnEnemy(this.GetMonster(), this.RandomSpawnPoint());
	}

	// Token: 0x0600018E RID: 398 RVA: 0x0000BA20 File Offset: 0x00009C20
	private void SpawnEnemy(PhoneMonster monster, Vector3 pos)
	{
		Vector3 up = Vector3.up;
		PhoneShooterSpawner phoneShooterSpawner = UnityEngine.Object.Instantiate(this.spawner_prefab, pos - up, Quaternion.identity) as PhoneShooterSpawner;
		phoneShooterSpawner.transform.parent = base.transform;
		phoneShooterSpawner.monster = monster;
		phoneShooterSpawner.prefab = this.enemy_prefab;
		phoneShooterSpawner.offset = up;
		phoneShooterSpawner.controller = this;
	}

	// Token: 0x0600018F RID: 399 RVA: 0x0000BA84 File Offset: 0x00009C84
	private PhoneShooterPlayer SpawnPlayer()
	{
		return this.SpawnPlayer(base.transform.position + Vector3.up);
	}

	// Token: 0x06000190 RID: 400 RVA: 0x0000BAAC File Offset: 0x00009CAC
	private PhoneShooterPlayer SpawnPlayer(Vector3 pos)
	{
		return this.SpawnPlayer(this.playermonster, pos);
	}

	// Token: 0x06000191 RID: 401 RVA: 0x0000BABC File Offset: 0x00009CBC
	private PhoneShooterPlayer SpawnPlayer(PhoneMonster monster, Vector3 pos)
	{
		PhoneShooterPlayer phoneShooterPlayer = UnityEngine.Object.Instantiate(this.player_prefab, pos, Quaternion.identity) as PhoneShooterPlayer;
		phoneShooterPlayer.transform.parent = base.transform;
		phoneShooterPlayer.SetMonster(monster);
		return phoneShooterPlayer;
	}

	// Token: 0x06000192 RID: 402 RVA: 0x0000BAFC File Offset: 0x00009CFC
	private PhoneShooterEnemy SpawnBoss(PhoneMonster monster, Vector3 pos)
	{
		PhoneShooterEnemy phoneShooterEnemy = UnityEngine.Object.Instantiate(this.enemy_prefab, pos, Quaternion.identity) as PhoneShooterEnemy;
		phoneShooterEnemy.transform.parent = base.transform;
		phoneShooterEnemy.controller = this;
		phoneShooterEnemy.SetMonster(monster);
		return phoneShooterEnemy;
	}

	// Token: 0x040001C2 RID: 450
	public PhoneShooterSpawner spawner_prefab;

	// Token: 0x040001C3 RID: 451
	public PhoneShooterPlayer player_prefab;

	// Token: 0x040001C4 RID: 452
	public PhoneShooterMonster enemy_prefab;

	// Token: 0x040001C5 RID: 453
	public static PhoneLabel slabel_prefab;

	// Token: 0x040001C6 RID: 454
	public PhoneLabel label_prefab;

	// Token: 0x040001C7 RID: 455
	public PhoneLabel wave_label;

	// Token: 0x040001C8 RID: 456
	private int attack_tip_count;

	// Token: 0x040001C9 RID: 457
	private bool attack_tip_ready = true;

	// Token: 0x040001CA RID: 458
	public PhoneLabel attack_tip_label;

	// Token: 0x040001CB RID: 459
	private PhoneLabel textlabel;

	// Token: 0x040001CC RID: 460
	public Transform background_trans;

	// Token: 0x040001CD RID: 461
	public int enemy_level;

	// Token: 0x040001CE RID: 462
	private int _wave = 1;

	// Token: 0x040001CF RID: 463
	public bool paused;

	// Token: 0x040001D0 RID: 464
	public bool battle_mode;

	// Token: 0x040001D1 RID: 465
	private float battle_start_timer;

	// Token: 0x040001D2 RID: 466
	public List<PhoneElement> stat_elements = new List<PhoneElement>();

	// Token: 0x040001D3 RID: 467
	public PhoneShooterMonster player_object;

	// Token: 0x040001D4 RID: 468
	public PhoneShooterEnemy battle_enemy_object;

	// Token: 0x040001D5 RID: 469
	public PhoneLabel attack_stat_label;

	// Token: 0x040001D6 RID: 470
	public PhoneLabel defense_stat_label;

	// Token: 0x040001D7 RID: 471
	public PhoneLabel magic_stat_label;

	// Token: 0x040001D8 RID: 472
	public PhoneLabel glam_stat_label;

	// Token: 0x040001D9 RID: 473
	private float gameovertimer;

	// Token: 0x040001DA RID: 474
	public bool spawn_new;

	// Token: 0x040001DB RID: 475
	private float enemytimer;
}
