using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000054 RID: 84
public static class SpriteController
{
	// Token: 0x0600039E RID: 926 RVA: 0x00016574 File Offset: 0x00014774
	public static void Init()
	{
	}

	// Token: 0x0600039F RID: 927 RVA: 0x00016578 File Offset: 0x00014778
	public static void AddSpriteSet(string name, SpriteSet sprset)
	{
		if (SpriteController.spritesets.ContainsKey(name))
		{
			SpriteController.spritesets[name] = sprset;
		}
		else
		{
			SpriteController.spritesets.Add(name, sprset);
		}
		sprset.setname = name;
	}

	// Token: 0x060003A0 RID: 928 RVA: 0x000165BC File Offset: 0x000147BC
	public static SpriteSet CreateSpriteSet(string name, Texture2D tex)
	{
		SpriteSet spriteSet = new SpriteSet(tex);
		SpriteController.AddSpriteSet(name, spriteSet);
		return spriteSet;
	}

	// Token: 0x060003A1 RID: 929 RVA: 0x000165D8 File Offset: 0x000147D8
	public static SpriteSet GetSpriteSet(string name)
	{
		return SpriteController.spritesets[name];
	}

	// Token: 0x060003A2 RID: 930 RVA: 0x000165E8 File Offset: 0x000147E8
	public static SpriteAnimation AutoGenAnimation(Vector2 size, Rect framerect)
	{
		SpriteAnimation spriteAnimation = new SpriteAnimation();
		for (float num = framerect.y; num < framerect.yMax; num += 1f)
		{
			for (float num2 = framerect.x; num2 < framerect.xMax; num2 += 1f)
			{
				spriteAnimation.AddFrame(new Rect(num2 * size.x, num * size.y, size.x, size.y));
			}
		}
		return spriteAnimation;
	}

	// Token: 0x040002EC RID: 748
	public static Dictionary<string, SpriteSet> spritesets = new Dictionary<string, SpriteSet>();

	// Token: 0x040002ED RID: 749
	public static Dictionary<string, SpriteFrame> frames = new Dictionary<string, SpriteFrame>();
}
