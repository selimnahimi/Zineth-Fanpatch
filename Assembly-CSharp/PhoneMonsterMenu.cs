using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000077 RID: 119
public class PhoneMonsterMenu : PhoneMainMenu
{
	// Token: 0x060004D9 RID: 1241 RVA: 0x0001E544 File Offset: 0x0001C744
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x170000A3 RID: 163
	// (get) Token: 0x060004DB RID: 1243 RVA: 0x0001E560 File Offset: 0x0001C760
	// (set) Token: 0x060004DA RID: 1242 RVA: 0x0001E558 File Offset: 0x0001C758
	public int monsterind
	{
		get
		{
			return PhoneMemory.monster_ind;
		}
		set
		{
			PhoneMemory.monster_ind = value;
		}
	}

	// Token: 0x060004DC RID: 1244 RVA: 0x0001E568 File Offset: 0x0001C768
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		if (this.exit_animating)
		{
			this.cancel_exit_animate = true;
		}
		this.menuind = 0;
		this.UpdateStatsDisplayer();
		foreach (PhoneElement phoneElement in base.elements)
		{
			phoneElement.OnLoad();
		}
		base.UpdateMenuItems();
		this.UpdateButtonSelected();
		this.DoArrows();
	}

	// Token: 0x060004DD RID: 1245 RVA: 0x0001E5D8 File Offset: 0x0001C7D8
	public override void UpdateScreen()
	{
		base.UpdateScreen();
		this.statsdisplayer.OnUpdate();
		if (this.capsulepoints_label && PhoneMemory.capsule_points != this.last_points)
		{
			this.last_points = PhoneMemory.capsule_points;
			this.capsulepoints_label.text = "$" + this.last_points.ToString();
			this.capsulepoints_label.transform.position += Vector3.forward * -0.25f;
			foreach (PhoneMonsterStatbar phoneMonsterStatbar in this.statsdisplayer.bars)
			{
				phoneMonsterStatbar.DoPriceLabels();
			}
		}
	}

	// Token: 0x170000A4 RID: 164
	// (get) Token: 0x060004DE RID: 1246 RVA: 0x0001E698 File Offset: 0x0001C898
	// (set) Token: 0x060004DF RID: 1247 RVA: 0x0001E6AC File Offset: 0x0001C8AC
	public PhoneMonster current_monster
	{
		get
		{
			return PhoneMemory.monsters[this.monsterind];
		}
		set
		{
			PhoneMemory.monsters[this.monsterind] = value;
		}
	}

	// Token: 0x060004E0 RID: 1248 RVA: 0x0001E6C0 File Offset: 0x0001C8C0
	public void UpdateStatsDisplayer()
	{
		if (this.namelabel)
		{
			this.namelabel.textmesh.text = this.current_monster.name;
		}
		this.statsdisplayer.SetMonster(this.current_monster);
	}

	// Token: 0x060004E1 RID: 1249 RVA: 0x0001E710 File Offset: 0x0001C910
	private void NextMonster()
	{
		this.monsterind++;
		if (this.monsterind >= PhoneMemory.monsters.Count)
		{
			this.monsterind = PhoneMemory.monsters.Count - 1;
			return;
		}
		this.UpdateStatsDisplayer();
		this.statsdisplayer.MoveBarsRelative(Vector3.right * 4f);
		if (this.nextbut)
		{
			this.nextbut.transform.position -= base.transform.right * 0.15f;
		}
		if (this.moveElement)
		{
			this.moveElement.transform.position += base.transform.right * 2f;
		}
		this.DoArrows();
	}

	// Token: 0x060004E2 RID: 1250 RVA: 0x0001E7FC File Offset: 0x0001C9FC
	private void PreviousMonster()
	{
		this.monsterind--;
		if (this.monsterind < 0)
		{
			this.monsterind = 0;
			return;
		}
		this.UpdateStatsDisplayer();
		this.statsdisplayer.MoveBarsRelative(-Vector3.right * 4f);
		if (this.prevbut)
		{
			this.prevbut.transform.position += base.transform.right * 0.15f;
		}
		if (this.moveElement)
		{
			this.moveElement.transform.position -= base.transform.right * 2f;
		}
		this.DoArrows();
	}

	// Token: 0x060004E3 RID: 1251 RVA: 0x0001E8D8 File Offset: 0x0001CAD8
	private void DoArrows()
	{
		if (this.prevbut)
		{
			bool flag = this.monsterind > 0;
			this.prevbut.renderer.enabled = flag;
			this.prevbut.selectable = flag;
			foreach (PhoneButton phoneButton in this.buttons)
			{
				if (flag)
				{
					phoneButton.left_button = this.prevbut;
				}
				else
				{
					phoneButton.left_button = null;
				}
			}
		}
		if (this.nextbut)
		{
			bool flag = this.monsterind < PhoneMemory.monsters.Count - 1;
			this.nextbut.renderer.enabled = flag;
			this.nextbut.selectable = flag;
			foreach (PhoneButton phoneButton2 in this.buttons)
			{
				if (flag)
				{
					phoneButton2.right_button = this.nextbut;
				}
				else
				{
					phoneButton2.right_button = null;
				}
			}
		}
		this.UpdateButtonSelected();
	}

	// Token: 0x060004E4 RID: 1252 RVA: 0x0001EA44 File Offset: 0x0001CC44
	private void UnlockStat(PhoneButton button)
	{
		PhoneMonsterStatbar phoneMonsterStatbar = button as PhoneMonsterStatbar;
		float num = Mathf.Min(PhoneMemory.capsule_points, 1f);
		if (num <= 0f)
		{
			return;
		}
		if (phoneMonsterStatbar.stat.locked <= 0f)
		{
			return;
		}
		PhoneMemory.AddCapsulePoints(-num);
		if (PhoneMemory.capsule_points < 0f)
		{
			PhoneMemory.AddCapsulePoints(-PhoneMemory.capsule_points);
		}
		phoneMonsterStatbar.stat.Unlock(num * 2f);
		phoneMonsterStatbar.DoRealPressedParticles();
		this.UpdateStatsDisplayer();
		PhoneMemory.SaveMonster(this.current_monster);
		Playtomic.Log.CustomMetric("tUnlockedStat", "tPhone", true);
		Playtomic.Log.CustomMetric("tStatsUnlocked", "tPhone", false);
	}

	// Token: 0x060004E5 RID: 1253 RVA: 0x0001EB00 File Offset: 0x0001CD00
	public override bool ButtonMessage(PhoneButton button, string command)
	{
		if (command == "unlockstat")
		{
			this.UnlockStat(button);
		}
		else if (command == "next")
		{
			this.NextMonster();
		}
		else if (command == "previous")
		{
			this.PreviousMonster();
		}
		else
		{
			if (!(command == "accept"))
			{
				return base.ButtonMessage(button, command);
			}
			this.controller.LoadScreen(this.nextscreenname);
		}
		return true;
	}

	// Token: 0x060004E6 RID: 1254 RVA: 0x0001EB90 File Offset: 0x0001CD90
	protected override void StickControls_Vertical()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (controlDirPressed.x >= 0.5f)
		{
			this.NextMonster();
		}
		else if (controlDirPressed.x <= -0.5f)
		{
			this.PreviousMonster();
		}
		if (controlDirPressed.y >= 0.5f)
		{
			this.menuind--;
		}
		if (controlDirPressed.y <= -0.5f)
		{
			this.menuind++;
		}
		if (this.controls_wrap)
		{
			if (this.menuind < 0)
			{
				this.menuind = Mathf.Max(0, this.buttons.Count - 1);
			}
			if (this.menuind >= this.buttons.Count)
			{
				this.menuind = 0;
			}
		}
		else
		{
			if (this.menuind < 0)
			{
				this.menuind = 0;
			}
			if (this.menuind >= this.buttons.Count)
			{
				this.menuind = Mathf.Max(0, this.buttons.Count - 1);
			}
		}
		while (this.buttons[this.menuind] == this.nextbut || this.buttons[this.menuind] == this.prevbut)
		{
			this.menuind++;
		}
		if (this.menuind >= this.buttons.Count)
		{
			if (this.controls_wrap)
			{
				this.menuind = 0;
			}
			else
			{
				this.menuind = this.buttons.Count - 1;
			}
		}
		if (PhoneInput.IsPressedDown() && this.buttons.Count > this.menuind)
		{
			this.buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x060004E7 RID: 1255 RVA: 0x0001ED74 File Offset: 0x0001CF74
	public override PhoneButton Button_To(PhoneButton button)
	{
		if (!this.newmail_prefab)
		{
			return button;
		}
		PhoneLabel phoneLabel = UnityEngine.Object.Instantiate(this.newmail_prefab) as PhoneLabel;
		phoneLabel.transform.position = button.transform.position + new Vector3(0f, 0.25f, 0f);
		phoneLabel.transform.parent = button.button_icon.transform;
		phoneLabel.wantedpos = phoneLabel.transform.localPosition;
		phoneLabel.wantedrot = phoneLabel.transform.localRotation;
		return button;
	}

	// Token: 0x040003CE RID: 974
	public PhoneMonsterStatsDisplay statsdisplayer;

	// Token: 0x040003CF RID: 975
	public PhoneLabel namelabel;

	// Token: 0x040003D0 RID: 976
	public PhoneButton nextbut;

	// Token: 0x040003D1 RID: 977
	public PhoneButton prevbut;

	// Token: 0x040003D2 RID: 978
	public PhoneLabel capsulepoints_label;

	// Token: 0x040003D3 RID: 979
	public string nextscreenname;

	// Token: 0x040003D4 RID: 980
	public PhoneButton acceptbut;

	// Token: 0x040003D5 RID: 981
	private float last_points = -99f;

	// Token: 0x040003D6 RID: 982
	public List<PhoneButton> monsterbuttons = new List<PhoneButton>();

	// Token: 0x040003D7 RID: 983
	public PhoneElement moveElement;

	// Token: 0x040003D8 RID: 984
	public PhoneLabel newmail_prefab;
}
