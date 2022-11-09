using System;
using UnityEngine;

// Token: 0x02000079 RID: 121
public class PhoneMonsterStatsDisplay : MonoBehaviour
{
	// Token: 0x170000A8 RID: 168
	// (get) Token: 0x060004FF RID: 1279 RVA: 0x0001F624 File Offset: 0x0001D824
	public PhoneMonsterStatbar[] bars
	{
		get
		{
			return new PhoneMonsterStatbar[]
			{
				this.attackbar,
				this.defensebar,
				this.magicbar,
				this.glambar
			};
		}
	}

	// Token: 0x06000500 RID: 1280 RVA: 0x0001F65C File Offset: 0x0001D85C
	private void Start()
	{
	}

	// Token: 0x06000501 RID: 1281 RVA: 0x0001F660 File Offset: 0x0001D860
	public void OnUpdate()
	{
		if (this.spritedisplay)
		{
			this.spriteplayer.UpdateMat(this.spritedisplay.renderer.material);
		}
	}

	// Token: 0x06000502 RID: 1282 RVA: 0x0001F69C File Offset: 0x0001D89C
	public void MoveBarsRelative(Vector3 pos)
	{
		foreach (PhoneMonsterStatbar phoneMonsterStatbar in this.bars)
		{
			if (phoneMonsterStatbar.animateOnLoad)
			{
				phoneMonsterStatbar.transform.position += pos;
			}
		}
		if (this.spritedisplay && this.spritedisplay.animateOnLoad)
		{
			this.spritedisplay.transform.position += pos;
		}
	}

	// Token: 0x06000503 RID: 1283 RVA: 0x0001F728 File Offset: 0x0001D928
	public void SetMonster(PhoneMonster monster)
	{
		this.curmonster = monster;
		if (this.namelabel)
		{
			this.namelabel.text = monster.name;
		}
		else if (this.namegui)
		{
			this.namegui.text = monster.name;
		}
		if (this.levellabel)
		{
			this.levellabel.text = "Tier " + monster.level.ToString();
		}
		else if (this.levelgui)
		{
			this.levelgui.text = "Tier " + monster.level.ToString();
		}
		if (this.bloodlabel)
		{
			this.bloodlabel.text = "Blood: " + monster.bloodtype;
		}
		else if (this.bloodgui)
		{
			this.bloodgui.text = "Blood: " + monster.bloodtype;
		}
		if (this.spritedisplay)
		{
			if (this.sprite_normalscale == Vector3.zero)
			{
				this.sprite_normalscale = this.spritedisplay.transform.localScale;
			}
			Vector3 vector = this.sprite_normalscale;
			vector.x *= monster.scale.x;
			vector.z *= monster.scale.y;
			if (this.spritedisplay.transform.localScale != vector)
			{
				this.spritedisplay.transform.localScale = vector;
			}
			this.spriteplayer.SetSpriteSet(monster.spriteset);
			this.spriteplayer.Play();
		}
		this.SetScales(this.scalefactor);
		this.UpdateStats();
	}

	// Token: 0x06000504 RID: 1284 RVA: 0x0001F92C File Offset: 0x0001DB2C
	public void UpdateStats()
	{
		this.attackbar.stat = this.curmonster.attackStat;
		this.defensebar.stat = this.curmonster.defenseStat;
		this.magicbar.stat = this.curmonster.magicStat;
		this.glambar.stat = this.curmonster.glamStat;
	}

	// Token: 0x06000505 RID: 1285 RVA: 0x0001F994 File Offset: 0x0001DB94
	public void SetScales()
	{
		this.SetScales(this.scalefactor);
	}

	// Token: 0x06000506 RID: 1286 RVA: 0x0001F9A4 File Offset: 0x0001DBA4
	public void SetScales(float amount)
	{
		this.attackbar.scalefactor = this.scalefactor;
		this.defensebar.scalefactor = this.scalefactor;
		this.magicbar.scalefactor = this.scalefactor;
		this.glambar.scalefactor = this.scalefactor;
	}

	// Token: 0x040003E3 RID: 995
	public PhoneMonsterStatbar attackbar;

	// Token: 0x040003E4 RID: 996
	public PhoneMonsterStatbar defensebar;

	// Token: 0x040003E5 RID: 997
	public PhoneMonsterStatbar magicbar;

	// Token: 0x040003E6 RID: 998
	public PhoneMonsterStatbar glambar;

	// Token: 0x040003E7 RID: 999
	public PhoneLabel namelabel;

	// Token: 0x040003E8 RID: 1000
	public PhoneLabel levellabel;

	// Token: 0x040003E9 RID: 1001
	public PhoneLabel bloodlabel;

	// Token: 0x040003EA RID: 1002
	public PhoneElement spritedisplay;

	// Token: 0x040003EB RID: 1003
	public GUIText namegui;

	// Token: 0x040003EC RID: 1004
	public GUIText levelgui;

	// Token: 0x040003ED RID: 1005
	public GUIText bloodgui;

	// Token: 0x040003EE RID: 1006
	private PhoneMonster curmonster;

	// Token: 0x040003EF RID: 1007
	public SpritePlayer spriteplayer = new SpritePlayer();

	// Token: 0x040003F0 RID: 1008
	public float scalefactor = 0.5f;

	// Token: 0x040003F1 RID: 1009
	private Vector3 sprite_normalscale = Vector3.zero;
}
