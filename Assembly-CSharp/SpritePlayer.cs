using System;
using UnityEngine;

// Token: 0x02000055 RID: 85
public class SpritePlayer
{
	// Token: 0x1700007D RID: 125
	// (get) Token: 0x060003A4 RID: 932 RVA: 0x00016688 File Offset: 0x00014888
	public Texture2D cur_texture
	{
		get
		{
			return this.sprite_set.texture;
		}
	}

	// Token: 0x1700007E RID: 126
	// (get) Token: 0x060003A5 RID: 933 RVA: 0x00016698 File Offset: 0x00014898
	public SpriteAnimation cur_animation
	{
		get
		{
			return this.sprite_set.GetAnimation(this.animation_name);
		}
	}

	// Token: 0x1700007F RID: 127
	// (get) Token: 0x060003A6 RID: 934 RVA: 0x000166AC File Offset: 0x000148AC
	public SpriteFrame cur_frame
	{
		get
		{
			return this.cur_animation.GetFrame(this.cur_index);
		}
	}

	// Token: 0x17000080 RID: 128
	// (get) Token: 0x060003A7 RID: 935 RVA: 0x000166C0 File Offset: 0x000148C0
	public float cur_speed
	{
		get
		{
			return this.cur_animation.animationSpeed * this.play_speed;
		}
	}

	// Token: 0x060003A8 RID: 936 RVA: 0x000166D4 File Offset: 0x000148D4
	public void SetSpriteSet(string name)
	{
		this.SetSpriteSet(SpriteController.GetSpriteSet(name));
	}

	// Token: 0x060003A9 RID: 937 RVA: 0x000166E4 File Offset: 0x000148E4
	public void SetSpriteSet(SpriteSet spriteset)
	{
		this.sprite_set = spriteset;
		this.cur_index = -1;
	}

	// Token: 0x060003AA RID: 938 RVA: 0x000166F4 File Offset: 0x000148F4
	public void SetAnimation(string animname)
	{
		this.animation_name = animname;
	}

	// Token: 0x060003AB RID: 939 RVA: 0x00016700 File Offset: 0x00014900
	public void PlayAnimation(string animname, float speed)
	{
		this.SetAnimation(animname);
		this.Play(speed);
	}

	// Token: 0x060003AC RID: 940 RVA: 0x00016710 File Offset: 0x00014910
	public void PlayAnimation(string animname)
	{
		this.SetAnimation(animname);
		this.Play();
	}

	// Token: 0x060003AD RID: 941 RVA: 0x00016720 File Offset: 0x00014920
	public void Play(float speed)
	{
		this.play_speed = speed;
		this.cur_index = -1;
	}

	// Token: 0x060003AE RID: 942 RVA: 0x00016730 File Offset: 0x00014930
	public void Play()
	{
		this.play_speed = 1f;
		this.cur_index = -1;
	}

	// Token: 0x060003AF RID: 943 RVA: 0x00016744 File Offset: 0x00014944
	public void SetFrame(Material mat, int index)
	{
		mat.mainTexture = this.sprite_set.texture;
		this.SetMatFrame(mat, this.cur_animation.frames[index % this.cur_animation.frames.Count]);
		this.cur_index = index;
	}

	// Token: 0x060003B0 RID: 944 RVA: 0x00016794 File Offset: 0x00014994
	public bool UpdateMat(Material mat)
	{
		if (mat.mainTexture != this.sprite_set.texture)
		{
			mat.mainTexture = this.sprite_set.texture;
		}
		this.time += this.cur_speed * Time.deltaTime;
		if ((int)this.time != this.cur_index)
		{
			this.cur_index = (int)this.time;
			return this.SetMatFrame(mat, this.cur_frame);
		}
		return true;
	}

	// Token: 0x060003B1 RID: 945 RVA: 0x00016814 File Offset: 0x00014A14
	public bool SetMatFrame(Material mat, SpriteFrame frame)
	{
		Vector2 offset = default(Vector2);
		offset.x = frame.framerect.x / (float)this.cur_texture.width;
		offset.y = 1f - frame.framerect.yMax / (float)this.cur_texture.height;
		Vector2 scale = default(Vector2);
		scale.x = frame.framerect.width / (float)this.cur_texture.width;
		scale.y = frame.framerect.height / (float)this.cur_texture.height;
		mat.SetTextureOffset("_MainTex", offset);
		mat.SetTextureScale("_MainTex", scale);
		return true;
	}

	// Token: 0x040002EE RID: 750
	public SpriteSet sprite_set;

	// Token: 0x040002EF RID: 751
	public string animation_name = "walk";

	// Token: 0x040002F0 RID: 752
	public float time;

	// Token: 0x040002F1 RID: 753
	public int cur_index = -99;

	// Token: 0x040002F2 RID: 754
	public float play_speed;
}
