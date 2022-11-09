using System;
using UnityEngine;

// Token: 0x0200003B RID: 59
public class MonsterTester : MonoBehaviour
{
	// Token: 0x0600021A RID: 538 RVA: 0x0000E1C8 File Offset: 0x0000C3C8
	private void Awake()
	{
		base.useGUILayout = false;
	}

	// Token: 0x0600021B RID: 539 RVA: 0x0000E1D4 File Offset: 0x0000C3D4
	private void Start()
	{
		this.monster = PhoneMemory.monsters[0];
	}

	// Token: 0x0600021C RID: 540 RVA: 0x0000E1E8 File Offset: 0x0000C3E8
	private void Gen(int lev)
	{
		this.level = lev;
		this.Gen();
	}

	// Token: 0x0600021D RID: 541 RVA: 0x0000E1F8 File Offset: 0x0000C3F8
	private void Gen()
	{
		if (this.monster == null || true)
		{
			this.monster = new PhoneMonster((float)this.level);
		}
		else
		{
			this.monster.level = (float)this.level;
			this.monster.GenerateStats();
		}
	}

	// Token: 0x17000036 RID: 54
	// (get) Token: 0x0600021E RID: 542 RVA: 0x0000E24C File Offset: 0x0000C44C
	// (set) Token: 0x0600021F RID: 543 RVA: 0x0000E254 File Offset: 0x0000C454
	public bool showgui
	{
		get
		{
			return base.useGUILayout;
		}
		set
		{
			base.useGUILayout = value;
		}
	}

	// Token: 0x06000220 RID: 544 RVA: 0x0000E260 File Offset: 0x0000C460
	private void OnGUI()
	{
		if (Input.GetKeyDown(KeyCode.M))
		{
			Debug.Log(MonsterTraits.Opinions.NewGetPossibleOpinion());
		}
		if (Input.GetKeyDown(KeyCode.N))
		{
			TweetComposer.MakeTweet();
		}
		if (!this.showgui)
		{
			return;
		}
		GUILayout.BeginHorizontal(string.Empty, new GUILayoutOption[0]);
		for (int i = 0; i < PhoneMemory.monsters.Count; i++)
		{
			if (PhoneMemory.monsters[i] == this.monster)
			{
				GUILayout.Box("Slot " + i, new GUILayoutOption[0]);
			}
			else if (GUILayout.Button("Slot " + i, new GUILayoutOption[0]))
			{
				this.monster = PhoneMemory.monsters[i];
			}
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(string.Empty, new GUILayoutOption[0]);
		if (GUILayout.Button("Save", new GUILayoutOption[0]))
		{
			this.monster.SaveMonster(PhoneMemory.monsters.IndexOf(this.monster));
			MonoBehaviour.print("saved?");
		}
		if (GUILayout.Button("Load", new GUILayoutOption[0]))
		{
			this.monster = PhoneMonster.LoadMonster(PhoneMemory.monsters.IndexOf(this.monster));
			MonoBehaviour.print("loaded?");
		}
		for (int j = 1; j < 6; j++)
		{
			if (GUILayout.Button("Level " + j, new GUILayoutOption[0]))
			{
				this.Gen(j);
			}
		}
		GUILayout.EndHorizontal();
		this.DrawStats(this.monster);
	}

	// Token: 0x06000221 RID: 545 RVA: 0x0000E414 File Offset: 0x0000C614
	private void DrawStats(PhoneMonster mon)
	{
		GUILayout.Label(mon.name, new GUILayoutOption[0]);
		GUILayout.Label(mon.monsterType, new GUILayoutOption[0]);
		string[] array = new string[]
		{
			"Attack",
			"Defense",
			"Magic",
			"Glam"
		};
		float mult = 4f;
		Rect rect = new Rect(60f, 120f, 0f, 40f);
		for (int i = 0; i < 4; i++)
		{
			GUI.Label(new Rect(10f, rect.y + 10f, rect.x - 10f, rect.height), array[i]);
			this.DrawStat(mon.stats[i], rect, mult);
			rect.y += rect.height;
		}
	}

	// Token: 0x06000222 RID: 546 RVA: 0x0000E500 File Offset: 0x0000C700
	private void DrawStat(MonsterStat stat, Rect rect, float mult)
	{
		rect.width = stat.current * mult;
		if (GUI.Button(rect, " "))
		{
			stat.Grow(1f);
		}
		rect.x = rect.xMax;
		rect.width = stat.potential * mult;
		GUI.Box(rect, " ");
		rect.x = rect.xMax;
		rect.width = stat.locked * mult;
		if (GUI.Button(rect, " "))
		{
			stat.Unlock(1f);
		}
		rect.x = rect.xMax + 8f;
		rect.width = 400f;
		GUI.Label(rect, string.Concat(new string[]
		{
			stat.current.ToString(),
			" / ",
			stat.potential.ToString(),
			" / ",
			stat.locked.ToString()
		}));
	}

	// Token: 0x0400020F RID: 527
	public int level = 1;

	// Token: 0x04000210 RID: 528
	public PhoneMonster monster;
}
