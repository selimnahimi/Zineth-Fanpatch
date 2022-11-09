using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200001B RID: 27
public class MissionController : MonoBehaviour
{
	// Token: 0x17000007 RID: 7
	// (get) Token: 0x0600009C RID: 156 RVA: 0x0000737C File Offset: 0x0000557C
	public static Arrow arrowRef
	{
		get
		{
			if (MissionController.GetInstance()._arrowRef == null)
			{
				MissionController.GetInstance()._arrowRef = GameObject.Find("Arrow").GetComponent<Arrow>();
			}
			return MissionController.GetInstance()._arrowRef;
		}
	}

	// Token: 0x17000008 RID: 8
	// (get) Token: 0x0600009D RID: 157 RVA: 0x000073C4 File Offset: 0x000055C4
	public static AudioClip checkpoint_sound
	{
		get
		{
			return MissionController.GetInstance()._checkpoint_sound;
		}
	}

	// Token: 0x17000009 RID: 9
	// (get) Token: 0x0600009E RID: 158 RVA: 0x000073D0 File Offset: 0x000055D0
	public static AudioClip mission_complete_sound
	{
		get
		{
			return MissionController.GetInstance()._mission_complete_sound;
		}
	}

	// Token: 0x1700000A RID: 10
	// (get) Token: 0x0600009F RID: 159 RVA: 0x000073DC File Offset: 0x000055DC
	public static AudioClip mission_start_sound
	{
		get
		{
			return MissionController.GetInstance()._mission_start_sound;
		}
	}

	// Token: 0x1700000B RID: 11
	// (get) Token: 0x060000A0 RID: 160 RVA: 0x000073E8 File Offset: 0x000055E8
	public static AudioClip mission_fail_sound
	{
		get
		{
			return MissionController.GetInstance()._mission_fail_sound;
		}
	}

	// Token: 0x1700000C RID: 12
	// (get) Token: 0x060000A1 RID: 161 RVA: 0x000073F4 File Offset: 0x000055F4
	public static AudioClip get_capsule_sound
	{
		get
		{
			return MissionController.GetInstance()._get_capsule_sound;
		}
	}

	// Token: 0x1700000D RID: 13
	// (get) Token: 0x060000A2 RID: 162 RVA: 0x00007400 File Offset: 0x00005600
	public static ThrownZine thrown_zine_prefab
	{
		get
		{
			return MissionController.GetInstance()._thrown_zine_prefab;
		}
	}

	// Token: 0x060000A3 RID: 163 RVA: 0x0000740C File Offset: 0x0000560C
	public static List<PhoneMail> ActiveMissionsAsMail()
	{
		List<PhoneMail> list = new List<PhoneMail>();
		foreach (MissionObject mission in MissionController.active_missions)
		{
			PhoneMail phoneMail = MissionController.MissionToMail(mission);
			list.Add(phoneMail);
			MailController.AddMail(phoneMail);
		}
		return list;
	}

	// Token: 0x060000A4 RID: 164 RVA: 0x00007488 File Offset: 0x00005688
	public static PhoneMail MissionToMail(MissionObject mission)
	{
		return new PhoneMail
		{
			id = "m_" + mission.id,
			subject = mission.title,
			body = mission.description
		};
	}

	// Token: 0x060000A5 RID: 165 RVA: 0x000074CC File Offset: 0x000056CC
	private void Awake()
	{
		this.behindText.font = this.missionText.font;
		this.behindText.material = this.missionText.material;
		this.behindText.material.color = Color.black;
		MissionController.guitext = string.Empty;
		MissionGUIText.default_font = this.missionText.font;
		MissionGUIText.default_material = this.missionText.material;
	}

	// Token: 0x060000A6 RID: 166 RVA: 0x00007544 File Offset: 0x00005744
	private void Start()
	{
		MissionController.is_setup = false;
		this.ClearMissions();
		this.AddAttachedMissions();
		MissionController.is_setup = true;
	}

	// Token: 0x060000A7 RID: 167 RVA: 0x00007560 File Offset: 0x00005760
	private void ClearMissions()
	{
		MissionController.all_missions.Clear();
		MissionController.active_missions.Clear();
		MissionController.completed_missions.Clear();
	}

	// Token: 0x060000A8 RID: 168 RVA: 0x00007580 File Offset: 0x00005780
	private void AddAttachedMissions()
	{
		foreach (MissionObject missionObject in base.gameObject.GetComponentsInChildren<MissionObject>())
		{
			if (missionObject.auto_add)
			{
				MissionController.AddMission(missionObject);
			}
		}
	}

	// Token: 0x060000A9 RID: 169 RVA: 0x000075C4 File Offset: 0x000057C4
	public static MissionController GetInstance()
	{
		if (!MissionController._instance)
		{
			MissionController._instance = (UnityEngine.Object.FindObjectOfType(typeof(MissionController)) as MissionController);
		}
		return MissionController._instance;
	}

	// Token: 0x1700000E RID: 14
	// (get) Token: 0x060000AA RID: 170 RVA: 0x000075F4 File Offset: 0x000057F4
	public static List<MissionObjective> focus_objectives
	{
		get
		{
			if (!MissionController.focus_mission)
			{
				return new List<MissionObjective>();
			}
			List<MissionObjective> list = new List<MissionObjective>();
			foreach (MissionObjective missionObjective in MissionController.focus_mission.GetCurrentObjectives())
			{
				if (missionObjective.use_position)
				{
					list.Add(missionObjective);
				}
			}
			return list;
		}
	}

	// Token: 0x1700000F RID: 15
	// (get) Token: 0x060000AB RID: 171 RVA: 0x00007688 File Offset: 0x00005888
	public static List<Vector3> focus_positions
	{
		get
		{
			List<Vector3> list = new List<Vector3>();
			foreach (MissionObjective missionObjective in MissionController.focus_objectives)
			{
				if (missionObjective.use_position)
				{
					list.Add(missionObjective.objectivePosition);
				}
			}
			return list;
		}
	}

	// Token: 0x060000AC RID: 172 RVA: 0x00007704 File Offset: 0x00005904
	public static void SetFocus(string missionid)
	{
		MissionObject missionObject = MissionController.FindMission(missionid);
		if (missionObject == null)
		{
			Debug.LogWarning("Mission " + missionid + " does not exist...");
			return;
		}
		MissionController.SetFocus(missionObject);
	}

	// Token: 0x060000AD RID: 173 RVA: 0x00007740 File Offset: 0x00005940
	public static void SetFocus(MissionObject mission)
	{
		if (mission == null)
		{
			Debug.LogWarning("Mission does not exist...");
			return;
		}
		if (mission.status != 1)
		{
			Debug.LogWarning("Why are you trying to do this? This mission is not active but you are still trying to focus on it... are you kidding me? Is this a joke? " + mission.id);
			return;
		}
		MissionController.focus_mission = mission;
		MissionController.GetInstance().PointArrowAt(MissionController.focus_mission);
		MissionController.focus_mission.is_new = false;
		MissionController.refresh = true;
	}

	// Token: 0x060000AE RID: 174 RVA: 0x000077AC File Offset: 0x000059AC
	public static void Unfocus()
	{
		MissionController.focus_mission = null;
		MissionController.GetInstance().DeactivateArrow();
	}

	// Token: 0x060000AF RID: 175 RVA: 0x000077C0 File Offset: 0x000059C0
	public void PointArrowAt(MissionObject mission)
	{
		MissionController.arrowRef.CheckAndPoint();
	}

	// Token: 0x060000B0 RID: 176 RVA: 0x000077CC File Offset: 0x000059CC
	public void DeactivateArrow()
	{
		MissionController.guitext = string.Empty;
	}

	// Token: 0x060000B1 RID: 177 RVA: 0x000077D8 File Offset: 0x000059D8
	public static MissionObject FindMission(string missionid)
	{
		if (!MissionController.all_missions.ContainsKey(missionid))
		{
			Debug.LogWarning("HEY! Mission " + missionid + " does NOT exist!!!");
			return null;
		}
		return MissionController.all_missions[missionid];
	}

	// Token: 0x060000B2 RID: 178 RVA: 0x00007818 File Offset: 0x00005A18
	public static void AddMission(MissionObject missionobj)
	{
		if (MissionController.all_missions.ContainsKey(missionobj.id))
		{
			return;
		}
		MissionController.all_missions.Add(missionobj.id, missionobj);
		if (missionobj.status == 1)
		{
			missionobj.status = 0;
			MissionController.SetActive(missionobj.id);
		}
		else if (missionobj.auto_active && missionobj.status != 2)
		{
			MissionController.SetActive(missionobj.id);
		}
		else
		{
			missionobj.gameObject.SetActiveRecursively(false);
			if (missionobj.status == 2)
			{
				MissionController.completed_missions.Add(missionobj);
			}
		}
	}

	// Token: 0x060000B3 RID: 179 RVA: 0x000078BC File Offset: 0x00005ABC
	public static MissionObject NewMission(string missionid)
	{
		GameObject gameObject = new GameObject("missionobj_" + missionid);
		return gameObject.AddComponent<MissionObject>();
	}

	// Token: 0x060000B4 RID: 180 RVA: 0x000078E4 File Offset: 0x00005AE4
	public static bool SetActive(string missionid)
	{
		return MissionController.SetActive(missionid, false);
	}

	// Token: 0x060000B5 RID: 181 RVA: 0x000078F0 File Offset: 0x00005AF0
	public static bool SetActive(string missionid, bool insert)
	{
		MissionObject missionObject = MissionController.FindMission(missionid);
		return !(missionObject == null) && MissionController.SetActive(missionObject, insert);
	}

	// Token: 0x060000B6 RID: 182 RVA: 0x0000791C File Offset: 0x00005B1C
	public static bool SetActive(MissionObject mobj)
	{
		return MissionController.SetActive(mobj, false);
	}

	// Token: 0x060000B7 RID: 183 RVA: 0x00007928 File Offset: 0x00005B28
	private static int MissionCompare(MissionObject m1, MissionObject m2)
	{
		return m1.name.CompareTo(m2.name);
	}

	// Token: 0x060000B8 RID: 184 RVA: 0x0000793C File Offset: 0x00005B3C
	public static bool SetActive(MissionObject mobj, bool insert)
	{
		if (mobj.status == 1 || MissionController.active_missions.Contains(mobj) || mobj.status == 2)
		{
			return false;
		}
		mobj.status = 1;
		mobj.gameObject.active = true;
		mobj.StartMission();
		if (insert)
		{
			MissionController.active_missions.Insert(0, mobj);
		}
		else
		{
			MissionController.active_missions.Add(mobj);
			if (MissionController.sort_by_name)
			{
				MissionController.active_missions.Sort(new Comparison<MissionObject>(MissionController.MissionCompare));
			}
		}
		MissionController.refresh = true;
		mobj.SaveMyInfo();
		Playtomic.Log.CustomMetric("tMissionActivated " + mobj.id, PlaytomicController.current_group, true);
		return true;
	}

	// Token: 0x060000B9 RID: 185 RVA: 0x000079FC File Offset: 0x00005BFC
	public static bool SetComplete(string missionid)
	{
		MissionObject missionObject = MissionController.FindMission(missionid);
		return !(missionObject == null) && MissionController.SetComplete(missionObject);
	}

	// Token: 0x060000BA RID: 186 RVA: 0x00007A24 File Offset: 0x00005C24
	public static bool SetComplete(MissionObject mobj)
	{
		mobj.status = 2;
		mobj.gameObject.SetActiveRecursively(false);
		MissionController.completed_missions.Add(mobj);
		MissionController.active_missions.Remove(mobj);
		MissionController.GetInstance().DeactivateArrow();
		if (mobj == MissionController.focus_mission)
		{
			MissionController.focus_mission = null;
		}
		MissionController.refresh = true;
		Playtomic.Log.CustomMetric("tMissionCompleted " + mobj.id, PlaytomicController.current_group, true);
		mobj.SaveMyInfo();
		if (MissionController.active_missions.Count > 0)
		{
			if (MissionController.auto_next_mission && MissionController.focus_mission == null)
			{
				MissionController.SetFocus(MissionController.active_missions[0]);
			}
			else
			{
				Debug.Log(MissionController.focus_mission);
				Debug.Log(MissionController.auto_next_mission);
			}
		}
		if (MissionController.is_setup)
		{
			MissionController.GetInstance().CheckUnlockCamera();
		}
		return true;
	}

	// Token: 0x17000010 RID: 16
	// (get) Token: 0x060000BB RID: 187 RVA: 0x00007B18 File Offset: 0x00005D18
	private bool unlocked_cam
	{
		get
		{
			return PlayerPrefs.GetInt("cool_cam", 0) == 1;
		}
	}

	// Token: 0x060000BC RID: 188 RVA: 0x00007B28 File Offset: 0x00005D28
	public bool CheckUnlockCamera()
	{
		if (!this.unlocked_cam)
		{
			foreach (MissionObject item in this.unlock_camera_missions)
			{
				if (!MissionController.completed_missions.Contains(item))
				{
					return false;
				}
			}
		}
		if (Application.isEditor)
		{
			Debug.Log("completed all cam missions...");
		}
		PhoneInterface.UnlockCamera();
		return true;
	}

	// Token: 0x17000011 RID: 17
	// (get) Token: 0x060000BD RID: 189 RVA: 0x00007B8C File Offset: 0x00005D8C
	// (set) Token: 0x060000BE RID: 190 RVA: 0x00007BA0 File Offset: 0x00005DA0
	public static string guitext
	{
		get
		{
			return MissionController.GetInstance().missionText.text;
		}
		set
		{
			MissionController.GetInstance().missionText.text = value;
			MissionController.GetInstance().behindText.text = value;
		}
	}

	// Token: 0x04000102 RID: 258
	public Arrow _arrowRef;

	// Token: 0x04000103 RID: 259
	public bool arrowActive;

	// Token: 0x04000104 RID: 260
	public GUIText missionText;

	// Token: 0x04000105 RID: 261
	public GUIText behindText;

	// Token: 0x04000106 RID: 262
	public AudioClip _checkpoint_sound;

	// Token: 0x04000107 RID: 263
	public AudioClip _mission_complete_sound;

	// Token: 0x04000108 RID: 264
	public AudioClip _mission_start_sound;

	// Token: 0x04000109 RID: 265
	public AudioClip _mission_fail_sound;

	// Token: 0x0400010A RID: 266
	public AudioClip _get_capsule_sound;

	// Token: 0x0400010B RID: 267
	public ThrownZine _thrown_zine_prefab;

	// Token: 0x0400010C RID: 268
	public static bool refresh = false;

	// Token: 0x0400010D RID: 269
	public static Dictionary<string, MissionObject> all_missions = new Dictionary<string, MissionObject>();

	// Token: 0x0400010E RID: 270
	public static List<MissionObject> active_missions = new List<MissionObject>();

	// Token: 0x0400010F RID: 271
	public static List<MissionObject> completed_missions = new List<MissionObject>();

	// Token: 0x04000110 RID: 272
	private static bool is_setup = false;

	// Token: 0x04000111 RID: 273
	private string old_guitext = string.Empty;

	// Token: 0x04000112 RID: 274
	private float gui_shake;

	// Token: 0x04000113 RID: 275
	private static MissionController _instance;

	// Token: 0x04000114 RID: 276
	public static MissionObject focus_mission;

	// Token: 0x04000115 RID: 277
	private static bool sort_by_name = true;

	// Token: 0x04000116 RID: 278
	private static bool auto_next_mission = true;

	// Token: 0x04000117 RID: 279
	public MissionObject[] unlock_camera_missions = new MissionObject[0];

	// Token: 0x04000118 RID: 280
	public MissionGUIText missionGUIPrefab;
}
