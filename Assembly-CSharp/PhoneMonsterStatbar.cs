using System;
using UnityEngine;

// Token: 0x02000078 RID: 120
public class PhoneMonsterStatbar : PhoneButton
{
	// Token: 0x060004E9 RID: 1257 RVA: 0x0001EE28 File Offset: 0x0001D028
	private void Start()
	{
		this.currentbar.GetChild(0).renderer.material.color = Color.blue;
		this.potentialbar.GetChild(0).renderer.material.color = Color.Lerp(Color.blue, Color.white, 0.75f);
		this.lockedRend = this.lockedbar.GetChild(0).renderer;
		this.lockedRend.material.color = Color.red;
		this.showLockedBar = false;
	}

	// Token: 0x060004EA RID: 1258 RVA: 0x0001EEB8 File Offset: 0x0001D0B8
	public override void OnLoad()
	{
		base.OnLoad();
		this.numberlabel.overrideColor = true;
		this.numberlabel.color = PhoneMemory.settings.selectableTextColor;
		this.numberlabel.textmesh.renderer.material.color = PhoneMemory.settings.selectableTextColor;
	}

	// Token: 0x170000A5 RID: 165
	// (get) Token: 0x060004EB RID: 1259 RVA: 0x0001EF10 File Offset: 0x0001D110
	// (set) Token: 0x060004EC RID: 1260 RVA: 0x0001EF18 File Offset: 0x0001D118
	public MonsterStat stat
	{
		get
		{
			return this._stat;
		}
		set
		{
			this._stat = value;
			this.UpdateStat();
		}
	}

	// Token: 0x060004ED RID: 1261 RVA: 0x0001EF28 File Offset: 0x0001D128
	public override void Init()
	{
		this.textmesh = this.numberlabel.textmesh;
		base.Init();
	}

	// Token: 0x060004EE RID: 1262 RVA: 0x0001EF44 File Offset: 0x0001D144
	public override bool ContainsPoint(Vector3 pos)
	{
		return base.ContainsPoint(pos);
	}

	// Token: 0x170000A6 RID: 166
	// (get) Token: 0x060004EF RID: 1263 RVA: 0x0001EF50 File Offset: 0x0001D150
	public float unlockAmount
	{
		get
		{
			return 2f;
		}
	}

	// Token: 0x170000A7 RID: 167
	// (get) Token: 0x060004F0 RID: 1264 RVA: 0x0001EF58 File Offset: 0x0001D158
	public float unlockPrice
	{
		get
		{
			return Mathf.Ceil((this.stat.current + this.stat.potential) / 10f);
		}
	}

	// Token: 0x060004F1 RID: 1265 RVA: 0x0001EF88 File Offset: 0x0001D188
	private void Update()
	{
		if (this.stat == null)
		{
			return;
		}
		if (this.lockedbar.gameObject.active)
		{
			string text = "{0}/{1}";
			float current = this.stat.current;
			float num = this.stat.current + this.stat.potential;
			if (this.showLockedBar)
			{
				this.lockedRend.enabled = (Mathf.Repeat(Time.time * 3f, 1f) >= 0.25f);
				num += Mathf.Min(this.unlockAmount, this.stat.locked);
				this.numberlabel.textmesh.renderer.material.color = Color.red;
			}
			else
			{
				this.lockedRend.enabled = false;
			}
			text = string.Format(text, current.ToString("0.0"), num.ToString("0.0"));
			if (this.numberlabel.text != text)
			{
				this.numberlabel.text = text;
			}
			if (this.numbergui)
			{
				this.numbergui.text = text;
			}
		}
	}

	// Token: 0x060004F2 RID: 1266 RVA: 0x0001F0BC File Offset: 0x0001D2BC
	private void UpdateStat()
	{
		if (this.stat == null)
		{
			this.ScaleBar(this.currentbar, 0f);
			this.ScaleBar(this.potentialbar, 0f);
			this.ScaleBar(this.lockedbar, 0f);
			this.PositionLabel(this.numberlabel);
			this.numberlabel.textmesh.text = "?/?";
		}
		else
		{
			this.ScaleBar(this.currentbar, this.stat.current);
			this.ScaleBar(this.potentialbar, this.stat.current + this.stat.potential);
			this.DoLockedBar();
			this.PositionLabel(this.numberlabel);
			this.DoPriceLabels();
			string text = this.stat.current.ToString("0.0") + "/" + (this.stat.current + this.stat.potential).ToString("0.0");
			if (this.stat.locked <= 0f || PhoneMemory.capsule_points > 0f)
			{
			}
			this.numberlabel.textmesh.text = text;
			if (this.numbergui)
			{
				this.numbergui.text = text;
			}
		}
	}

	// Token: 0x060004F3 RID: 1267 RVA: 0x0001F214 File Offset: 0x0001D414
	public void DoPriceLabels()
	{
		if (this.pricelabel)
		{
			this.pricelabel.overrideColor = true;
			if (this.stat.locked > 0f)
			{
				this.pricelabel.text = "$" + this.unlockPrice.ToString("0");
			}
			else
			{
				this.pricelabel.text = string.Empty;
			}
			if (PhoneMemory.capsule_points >= this.unlockPrice)
			{
				this.pricelabel.color = Color.black;
			}
			else
			{
				this.pricelabel.color = Color.red;
			}
			this.pricelabel.OnLoad();
		}
	}

	// Token: 0x060004F4 RID: 1268 RVA: 0x0001F2D0 File Offset: 0x0001D4D0
	public void DoLockedBar()
	{
		if (this.selected)
		{
			float val = this.stat.current + this.stat.potential + Mathf.Min(this.stat.locked, this.unlockAmount);
			this.ScaleBar(this.lockedbar, val);
			this.showLockedBar = true;
		}
		else
		{
			this.showLockedBar = false;
		}
	}

	// Token: 0x060004F5 RID: 1269 RVA: 0x0001F338 File Offset: 0x0001D538
	public override void OnSelected()
	{
		base.OnSelected();
		this.DoLockedBar();
	}

	// Token: 0x060004F6 RID: 1270 RVA: 0x0001F348 File Offset: 0x0001D548
	public override void OnUnSelected()
	{
		base.OnUnSelected();
		this.showLockedBar = false;
	}

	// Token: 0x060004F7 RID: 1271 RVA: 0x0001F358 File Offset: 0x0001D558
	public override void DoPressedParticles()
	{
	}

	// Token: 0x060004F8 RID: 1272 RVA: 0x0001F35C File Offset: 0x0001D55C
	public virtual void DoRealPressedParticles()
	{
		PhoneController.EmitParts(this.GetPressPos(), 10, Color.red);
	}

	// Token: 0x060004F9 RID: 1273 RVA: 0x0001F370 File Offset: 0x0001D570
	public override Vector3 GetPressPos()
	{
		Vector3 max = this.potentialbar.GetChild(0).renderer.bounds.max;
		max.y += 0.1f;
		max.z = this.potentialbar.GetChild(0).renderer.bounds.center.z;
		return max;
	}

	// Token: 0x060004FA RID: 1274 RVA: 0x0001F3E0 File Offset: 0x0001D5E0
	public bool UnlockStat()
	{
		if (this.stat.locked <= 0f)
		{
			return false;
		}
		if (PhoneMemory.capsule_points < this.unlockPrice)
		{
			return false;
		}
		PhoneMemory.AddCapsulePoints(-this.unlockPrice);
		this.stat.Unlock(this.unlockAmount);
		this.DoRealPressedParticles();
		PhoneMemory.SaveMonsters();
		this.UpdateStat();
		Playtomic.Log.CustomMetric("tUnlockedStat", "tPhone", true);
		Playtomic.Log.CustomMetric("tStatsUnlocked", "tPhone", false);
		return true;
	}

	// Token: 0x060004FB RID: 1275 RVA: 0x0001F470 File Offset: 0x0001D670
	public override bool RunCommand(string stringcommand)
	{
		if (stringcommand == ".unlockstat")
		{
			return this.UnlockStat();
		}
		return base.RunCommand(stringcommand);
	}

	// Token: 0x060004FC RID: 1276 RVA: 0x0001F490 File Offset: 0x0001D690
	private void ScaleBar(Transform bar, float val)
	{
		Vector3 localScale = new Vector3(this.scalefactor * val, 1f, bar.transform.localScale.z);
		bar.localScale = localScale;
	}

	// Token: 0x060004FD RID: 1277 RVA: 0x0001F4CC File Offset: 0x0001D6CC
	private void PositionLabel(PhoneLabel label)
	{
		Vector3 vector = this.potentialbar.transform.position;
		vector.x = this.potentialbar.GetChild(0).renderer.bounds.max.x + 0.1f;
		vector += Vector3.up * 0.5f;
		float num = label.textmesh.renderer.bounds.max.x - label.transform.position.x;
		if (vector.x + num >= this.background_box.renderer.bounds.max.x - 0.15f)
		{
			vector.x = this.background_box.renderer.bounds.max.x - 0.05f - num;
		}
		if (label.animateOnLoad)
		{
			label.wantedpos = vector;
		}
		else
		{
			label.transform.position = vector;
		}
	}

	// Token: 0x040003D9 RID: 985
	public Transform currentbar;

	// Token: 0x040003DA RID: 986
	public Transform potentialbar;

	// Token: 0x040003DB RID: 987
	public Transform lockedbar;

	// Token: 0x040003DC RID: 988
	public PhoneLabel numberlabel;

	// Token: 0x040003DD RID: 989
	public PhoneLabel pricelabel;

	// Token: 0x040003DE RID: 990
	public GUIText numbergui;

	// Token: 0x040003DF RID: 991
	private MonsterStat _stat;

	// Token: 0x040003E0 RID: 992
	private bool showLockedBar = true;

	// Token: 0x040003E1 RID: 993
	private Renderer lockedRend;

	// Token: 0x040003E2 RID: 994
	public float scalefactor = 1f;
}
