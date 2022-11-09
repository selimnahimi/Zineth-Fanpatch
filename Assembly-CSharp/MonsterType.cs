using System;

// Token: 0x02000043 RID: 67
public class MonsterType
{
	// Token: 0x0600025F RID: 607 RVA: 0x000108E4 File Offset: 0x0000EAE4
	public MonsterType(string typename, SpriteSet spriteset)
	{
		this.typeName = typename;
		this.spriteSet = spriteset;
	}

	// Token: 0x06000260 RID: 608 RVA: 0x00010934 File Offset: 0x0000EB34
	public MonsterType(string typename, SpriteSet spriteset, MonsterAI monsterai)
	{
		this.typeName = typename;
		this.spriteSet = spriteset;
		this.monsterAI = monsterai;
	}

	// Token: 0x06000261 RID: 609 RVA: 0x0001098C File Offset: 0x0000EB8C
	public MonsterType(string typename, string spriteset)
	{
		this.typeName = typename;
		this.spriteSet = PhoneResourceController.GetSpriteSet(spriteset);
	}

	// Token: 0x06000262 RID: 610 RVA: 0x000109E0 File Offset: 0x0000EBE0
	public MonsterType(string typename, string spriteset, MonsterAI monsterai)
	{
		this.typeName = typename;
		this.spriteSet = PhoneResourceController.GetSpriteSet(spriteset);
		this.monsterAI = monsterai;
	}

	// Token: 0x06000263 RID: 611 RVA: 0x00010A3C File Offset: 0x0000EC3C
	public MonsterType(string typename, string spriteset, float speed)
	{
		this.typeName = typename;
		this.spriteSet = PhoneResourceController.GetSpriteSet(spriteset);
		this.speedMod = speed;
	}

	// Token: 0x06000264 RID: 612 RVA: 0x00010A98 File Offset: 0x0000EC98
	public MonsterType(string typename, string spriteset, MonsterAI monsterai, float speed)
	{
		this.typeName = typename;
		this.spriteSet = PhoneResourceController.GetSpriteSet(spriteset);
		this.monsterAI = monsterai;
		this.speedMod = speed;
	}

	// Token: 0x06000265 RID: 613 RVA: 0x00010AFC File Offset: 0x0000ECFC
	public static implicit operator string(MonsterType monstertype)
	{
		return monstertype.typeName;
	}

	// Token: 0x04000236 RID: 566
	public string typeName;

	// Token: 0x04000237 RID: 567
	public SpriteSet spriteSet;

	// Token: 0x04000238 RID: 568
	public MonsterAI monsterAI;

	// Token: 0x04000239 RID: 569
	public float[] statMods = new float[]
	{
		1f,
		1f,
		1f,
		1f
	};

	// Token: 0x0400023A RID: 570
	public float speedMod = 1f;

	// Token: 0x0400023B RID: 571
	public float scaleMod = 1f;

	// Token: 0x0400023C RID: 572
	public bool flyingAnimate;
}
