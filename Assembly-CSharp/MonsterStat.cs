using System;
using UnityEngine;

// Token: 0x02000041 RID: 65
public class MonsterStat
{
	// Token: 0x0600025A RID: 602 RVA: 0x0001075C File Offset: 0x0000E95C
	public void Grow(float amount)
	{
		amount = 10f / this.current * amount;
		amount *= 1.5f;
		amount *= this.statMod;
		float num = Mathf.Min(this.potential, amount);
		if (num < amount)
		{
			this.extra += amount - num;
		}
		this.potential -= num;
		this.current += num;
	}

	// Token: 0x0600025B RID: 603 RVA: 0x000107CC File Offset: 0x0000E9CC
	public void Unlock(float amount)
	{
		float num = Mathf.Min(this.locked, amount);
		this.locked -= num;
		this.potential += num;
	}

	// Token: 0x17000046 RID: 70
	// (get) Token: 0x0600025C RID: 604 RVA: 0x00010804 File Offset: 0x0000EA04
	public float remaining
	{
		get
		{
			return this.max - this.current - this.potential - this.locked;
		}
	}

	// Token: 0x0600025D RID: 605 RVA: 0x00010824 File Offset: 0x0000EA24
	public string ToSaveString()
	{
		return string.Concat(new string[]
		{
			this.current.ToString(),
			";",
			this.potential.ToString(),
			";",
			this.locked.ToString()
		});
	}

	// Token: 0x0600025E RID: 606 RVA: 0x00010878 File Offset: 0x0000EA78
	public static MonsterStat LoadFromString(string str)
	{
		MonsterStat monsterStat = new MonsterStat();
		string[] array = str.Split(new char[]
		{
			';'
		});
		monsterStat.current = float.Parse(array[0]);
		monsterStat.potential = float.Parse(array[1]);
		monsterStat.locked = float.Parse(array[2]);
		monsterStat.max = monsterStat.current + monsterStat.potential + monsterStat.locked;
		return monsterStat;
	}

	// Token: 0x04000227 RID: 551
	public float current;

	// Token: 0x04000228 RID: 552
	public float potential;

	// Token: 0x04000229 RID: 553
	public float locked;

	// Token: 0x0400022A RID: 554
	public float max;

	// Token: 0x0400022B RID: 555
	public float extra;

	// Token: 0x0400022C RID: 556
	public float statMod;
}
