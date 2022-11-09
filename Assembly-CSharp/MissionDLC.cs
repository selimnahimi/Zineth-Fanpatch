using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200001E RID: 30
public class MissionDLC : MonoBehaviour
{
	// Token: 0x17000019 RID: 25
	// (get) Token: 0x060000DA RID: 218 RVA: 0x000082B4 File Offset: 0x000064B4
	public string id
	{
		get
		{
			if (this.mission_obj)
			{
				return this.mission_obj.id;
			}
			return "?";
		}
	}

	// Token: 0x1700001A RID: 26
	// (get) Token: 0x060000DB RID: 219 RVA: 0x000082D8 File Offset: 0x000064D8
	public float progress
	{
		get
		{
			if (this.web == null)
			{
				return 0f;
			}
			return this.web.progress;
		}
	}

	// Token: 0x1700001B RID: 27
	// (get) Token: 0x060000DC RID: 220 RVA: 0x000082F8 File Offset: 0x000064F8
	public string progress_string
	{
		get
		{
			if (this.web == null && this.progress <= 0f)
			{
				return "Not Started";
			}
			return (this.progress * 100f).ToString() + "%";
		}
	}

	// Token: 0x060000DD RID: 221 RVA: 0x00008344 File Offset: 0x00006544
	public void Init(string name_str, string url_str)
	{
		this.dlc_name = name_str;
		this.url = url_str;
	}

	// Token: 0x060000DE RID: 222 RVA: 0x00008354 File Offset: 0x00006554
	public void LoadMission()
	{
		if (this.mission_obj)
		{
			MissionController.AddMission(this.mission_obj);
		}
	}

	// Token: 0x060000DF RID: 223 RVA: 0x00008374 File Offset: 0x00006574
	public void Download()
	{
		base.StartCoroutine("Co_Download");
	}

	// Token: 0x060000E0 RID: 224 RVA: 0x00008384 File Offset: 0x00006584
	private IEnumerator Co_Download()
	{
		string path = this.url;
		this.web = new WWW(path);
		yield return this.web;
		if (this.web.error != null)
		{
			Debug.LogWarning("Error: could not download mission " + this.web.error + " " + this.web.url);
		}
		else if (this.web.assetBundle)
		{
			Debug.Log("Found Asset Bundle! " + this.web.assetBundle.name);
			GameObject gob = UnityEngine.Object.Instantiate(this.web.assetBundle.mainAsset) as GameObject;
			MissionObject mobj = gob.GetComponent<MissionObject>();
			Debug.Log("right here!");
			if (this.mission_obj)
			{
				this.mission_obj = mobj;
				Playtomic.Log.CustomMetric("tDownloadedMission", PlaytomicController.current_group, true);
				if (this.auto_load)
				{
					this.LoadMission();
				}
			}
		}
		else
		{
			Debug.LogWarning("could not find asset bundle in " + path);
		}
		yield break;
	}

	// Token: 0x0400012D RID: 301
	public string dlc_name;

	// Token: 0x0400012E RID: 302
	public string url;

	// Token: 0x0400012F RID: 303
	public bool auto_load;

	// Token: 0x04000130 RID: 304
	public WWW web;

	// Token: 0x04000131 RID: 305
	public MissionObject mission_obj;
}
