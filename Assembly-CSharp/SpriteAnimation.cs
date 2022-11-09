using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000057 RID: 87
public class SpriteAnimation
{
	// Token: 0x060003B6 RID: 950 RVA: 0x00016920 File Offset: 0x00014B20
	public SpriteAnimation()
	{
	}

	// Token: 0x060003B7 RID: 951 RVA: 0x00016940 File Offset: 0x00014B40
	public SpriteAnimation(Rect[] rects)
	{
		foreach (Rect rectangle in rects)
		{
			this.frames.Add(new SpriteFrame(rectangle));
		}
	}

	// Token: 0x060003B8 RID: 952 RVA: 0x000169A0 File Offset: 0x00014BA0
	public void AddFrame(Rect rect)
	{
		this.frames.Add(new SpriteFrame(rect));
	}

	// Token: 0x060003B9 RID: 953 RVA: 0x000169B4 File Offset: 0x00014BB4
	public void AddFrame(SpriteFrame frame)
	{
		this.frames.Add(frame);
	}

	// Token: 0x060003BA RID: 954 RVA: 0x000169C4 File Offset: 0x00014BC4
	public SpriteFrame GetFrame(int ind)
	{
		return this.frames[ind % this.frames.Count];
	}

	// Token: 0x040002F6 RID: 758
	public List<SpriteFrame> frames = new List<SpriteFrame>();

	// Token: 0x040002F7 RID: 759
	public float animationSpeed = 6f;
}
