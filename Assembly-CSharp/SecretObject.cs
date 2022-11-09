using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000A9 RID: 169
public class SecretObject : MonoBehaviour
{
	// Token: 0x0600070B RID: 1803 RVA: 0x0002CFA0 File Offset: 0x0002B1A0
	private void Start()
	{
		if (string.IsNullOrEmpty(this.secret_name))
		{
			this.secret_name = base.gameObject.name;
		}
		if (!SecretObject.all_list.Contains(this))
		{
			SecretObject.all_list.Add(this);
		}
		this.LoadMyInfo();
	}

	// Token: 0x0600070C RID: 1804 RVA: 0x0002CFF0 File Offset: 0x0002B1F0
	public void Found()
	{
		this.OnFound();
		this.SaveMyInfo();
		PlaytomicController.LogPosition("secret_found", base.transform.position);
		Playtomic.Log.CustomMetric("SecretFound", PlaytomicController.current_group);
		Playtomic.Log.CustomMetric("Secret_" + this.secret_name, "Secrets");
	}

	// Token: 0x0600070D RID: 1805 RVA: 0x0002D054 File Offset: 0x0002B254
	private void OnFound()
	{
		if (!SecretObject.collected_list.Contains(this))
		{
			SecretObject.collected_list.Add(this);
		}
		if (SecretObject.uncollected_list.Contains(this))
		{
			SecretObject.uncollected_list.Remove(this);
		}
		foreach (GameObject gameObject in this.send_activate_to)
		{
			gameObject.SendMessage("SecretFound");
		}
	}

	// Token: 0x0600070E RID: 1806 RVA: 0x0002D0F8 File Offset: 0x0002B2F8
	public string GetSaveName()
	{
		return string.Format("secret_{0}", this.secret_name);
	}

	// Token: 0x0600070F RID: 1807 RVA: 0x0002D10C File Offset: 0x0002B30C
	public int GetSaveInt()
	{
		return this.secret_val;
	}

	// Token: 0x06000710 RID: 1808 RVA: 0x0002D114 File Offset: 0x0002B314
	public void SaveMyInfo()
	{
		if (!this.save_found)
		{
			return;
		}
		PlayerPrefs.SetInt(this.GetSaveName(), this.GetSaveInt());
		PlayerPrefs.Save();
	}

	// Token: 0x06000711 RID: 1809 RVA: 0x0002D144 File Offset: 0x0002B344
	public void LoadMyInfo()
	{
		int @int = PlayerPrefs.GetInt(this.GetSaveName(), -1);
		if (@int != -1)
		{
			this.secret_val = @int;
			this.OnFound();
		}
		else if (!SecretObject.uncollected_list.Contains(this))
		{
			SecretObject.uncollected_list.Add(this);
		}
	}

	// Token: 0x040005DA RID: 1498
	public static List<SecretObject> all_list = new List<SecretObject>();

	// Token: 0x040005DB RID: 1499
	public static List<SecretObject> collected_list = new List<SecretObject>();

	// Token: 0x040005DC RID: 1500
	public static List<SecretObject> uncollected_list = new List<SecretObject>();

	// Token: 0x040005DD RID: 1501
	public string secret_name;

	// Token: 0x040005DE RID: 1502
	public int secret_val = 1;

	// Token: 0x040005DF RID: 1503
	public bool save_found = true;

	// Token: 0x040005E0 RID: 1504
	public List<GameObject> send_activate_to = new List<GameObject>();
}
