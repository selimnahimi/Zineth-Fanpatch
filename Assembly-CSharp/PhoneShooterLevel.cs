using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000053 RID: 83
public class PhoneShooterLevel
{
	// Token: 0x06000399 RID: 921 RVA: 0x0001640C File Offset: 0x0001460C
	public PhoneShooterLevel(NPCTrainer npctrainer)
	{
		this.trainer = npctrainer;
		this.name = npctrainer.monster.name;
		this.difficulty = (int)npctrainer.level;
		if (npctrainer.level_bg != null)
		{
			this.texture = this.trainer.level_bg;
		}
		else
		{
			this.texture = PhoneResourceController.levelbackgrounds[0];
		}
	}

	// Token: 0x0600039A RID: 922 RVA: 0x00016494 File Offset: 0x00014694
	public PhoneShooterLevel(string lvl_name, int lvl_difficulty, int lvl_texture)
	{
		this.name = lvl_name;
		this.difficulty = lvl_difficulty;
		if (PhoneResourceController.levelbackgrounds.Length > lvl_texture)
		{
			this.texture = PhoneResourceController.levelbackgrounds[lvl_texture];
		}
	}

	// Token: 0x0600039B RID: 923 RVA: 0x000164E8 File Offset: 0x000146E8
	public PhoneShooterLevel(string lvl_name, int lvl_difficulty, Texture2D lvl_texture)
	{
		this.name = lvl_name;
		this.difficulty = lvl_difficulty;
		this.texture = lvl_texture;
	}

	// Token: 0x0600039C RID: 924 RVA: 0x0001651C File Offset: 0x0001471C
	public MonsterType RandomMonsterType()
	{
		if (this.monsterTypes.Count == 0)
		{
			return PhoneResourceController.RandomMonsterType();
		}
		return this.monsterTypes[UnityEngine.Random.Range(0, this.monsterTypes.Count)];
	}

	// Token: 0x040002E7 RID: 743
	public string name = "Name";

	// Token: 0x040002E8 RID: 744
	public int difficulty;

	// Token: 0x040002E9 RID: 745
	public Texture2D texture;

	// Token: 0x040002EA RID: 746
	public NPCTrainer trainer;

	// Token: 0x040002EB RID: 747
	public List<MonsterType> monsterTypes = new List<MonsterType>();
}
