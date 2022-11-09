using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200001D RID: 29
public class MissionLoadControl : MonoBehaviour
{
	// Token: 0x17000017 RID: 23
	// (get) Token: 0x060000D0 RID: 208 RVA: 0x00008084 File Offset: 0x00006284
	public static MissionLoadControl instance
	{
		get
		{
			if (!MissionLoadControl._instance)
			{
				MissionLoadControl._instance = (UnityEngine.Object.FindObjectOfType(typeof(MissionLoadControl)) as MissionLoadControl);
			}
			return MissionLoadControl._instance;
		}
	}

	// Token: 0x060000D1 RID: 209 RVA: 0x000080B4 File Offset: 0x000062B4
	private void Awake()
	{
		base.useGUILayout = false;
	}

	// Token: 0x060000D2 RID: 210 RVA: 0x000080C0 File Offset: 0x000062C0
	public virtual void LoadMission(string path)
	{
		base.StartCoroutine("Co_LoadMission", path);
	}

	// Token: 0x060000D3 RID: 211 RVA: 0x000080D0 File Offset: 0x000062D0
	public virtual IEnumerator Co_LoadMission(string path)
	{
		WWW web = new WWW(path);
		yield return web;
		if (web.assetBundle)
		{
			GameObject gob = UnityEngine.Object.Instantiate(web.assetBundle.mainAsset) as GameObject;
			MissionObject mobj = gob.GetComponent<MissionObject>();
			Playtomic.Log.CustomMetric("tDownloadedMission", PlaytomicController.current_group, true);
			MissionController.AddMission(mobj);
			MissionController.SetActive(mobj);
		}
		else
		{
			Debug.LogWarning("could not find asset bundle in " + path);
		}
		yield break;
	}

	// Token: 0x060000D4 RID: 212 RVA: 0x000080F4 File Offset: 0x000062F4
	private MissionDLC ParseMission(string name_text, string url_text)
	{
		GameObject gameObject = new GameObject();
		MissionDLC missionDLC = gameObject.AddComponent<MissionDLC>();
		missionDLC.Init(name_text, url_text);
		return missionDLC;
	}

	// Token: 0x17000018 RID: 24
	// (get) Token: 0x060000D5 RID: 213 RVA: 0x00008118 File Offset: 0x00006318
	// (set) Token: 0x060000D6 RID: 214 RVA: 0x00008120 File Offset: 0x00006320
	public bool dogui
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

	// Token: 0x060000D7 RID: 215 RVA: 0x0000812C File Offset: 0x0000632C
	private void SetupMissions()
	{
		foreach (DLCControl.DLCInfo dlcinfo in DLCControl.dlcInfoList)
		{
			MissionDLC missionDLC = this.ParseMission(dlcinfo.name, dlcinfo.file_url);
			missionDLC.auto_load = true;
			missionDLC.Download();
			this.mission_list.Add(missionDLC);
		}
	}

	// Token: 0x060000D8 RID: 216 RVA: 0x000081B8 File Offset: 0x000063B8
	private void OnGUI()
	{
		if (!this.dogui)
		{
			return;
		}
		if (this.mission_list.Count <= 0)
		{
			if (GUILayout.Button("Setup", new GUILayoutOption[0]))
			{
				this.SetupMissions();
			}
		}
		else
		{
			foreach (MissionDLC missionDLC in this.mission_list)
			{
				if (missionDLC.progress > 0f)
				{
					if (GUILayout.Button("Load " + missionDLC.dlc_name, new GUILayoutOption[0]))
					{
						missionDLC.LoadMission();
					}
				}
				else
				{
					GUILayout.Box(missionDLC.dlc_name + "-downloading...", new GUILayoutOption[0]);
				}
			}
		}
	}

	// Token: 0x04000125 RID: 293
	private static MissionLoadControl _instance;

	// Token: 0x04000126 RID: 294
	public string mission_name = "MissionTest1";

	// Token: 0x04000127 RID: 295
	private string file_ext = ".unity3d";

	// Token: 0x04000128 RID: 296
	public string local_path = "file://";

	// Token: 0x04000129 RID: 297
	public string web_path = "https://dl.dropbox.com/u/15013465/dlc_test/";

	// Token: 0x0400012A RID: 298
	public string web_list_path = "https://dl.dropbox.com/u/15013465/dlc_test/mission_list_{0}.txt";

	// Token: 0x0400012B RID: 299
	private List<MissionDLC> mission_list = new List<MissionDLC>();

	// Token: 0x0400012C RID: 300
	public bool online = true;
}
