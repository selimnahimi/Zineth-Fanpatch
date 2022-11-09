using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000056 RID: 86
public class SpriteSet
{
	// Token: 0x060003B2 RID: 946 RVA: 0x000168CC File Offset: 0x00014ACC
	public SpriteSet(Texture2D tex)
	{
		this.texture = tex;
	}

	// Token: 0x060003B3 RID: 947 RVA: 0x000168E8 File Offset: 0x00014AE8
	public bool AddAnimation(string name, SpriteAnimation animation)
	{
		this.animations.Add(name, animation);
		return true;
	}

	// Token: 0x060003B4 RID: 948 RVA: 0x000168F8 File Offset: 0x00014AF8
	public bool AddAnimation(string name, Rect[] rects)
	{
		this.animations.Add(name, new SpriteAnimation(rects));
		return true;
	}

	// Token: 0x060003B5 RID: 949 RVA: 0x00016910 File Offset: 0x00014B10
	public SpriteAnimation GetAnimation(string name)
	{
		return this.animations[name];
	}

	// Token: 0x040002F3 RID: 755
	public string setname;

	// Token: 0x040002F4 RID: 756
	public Texture2D texture;

	// Token: 0x040002F5 RID: 757
	public Dictionary<string, SpriteAnimation> animations = new Dictionary<string, SpriteAnimation>();
}
