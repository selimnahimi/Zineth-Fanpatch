using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000004 RID: 4
public class Capsule : MonoBehaviour
{
	// Token: 0x17000001 RID: 1
	// (get) Token: 0x0600000A RID: 10 RVA: 0x0000239C File Offset: 0x0000059C
	private AudioClip clip
	{
		get
		{
			return MissionController.get_capsule_sound;
		}
	}

	// Token: 0x17000002 RID: 2
	// (get) Token: 0x0600000B RID: 11 RVA: 0x000023A4 File Offset: 0x000005A4
	private static bool has_gotten
	{
		get
		{
			return Capsule.collected_list.Count > 0;
		}
	}

	// Token: 0x0600000C RID: 12 RVA: 0x000023B4 File Offset: 0x000005B4
	private void Awake()
	{
		this.currentValue = this.initialValue;
		if (this.capsule_index != -1)
		{
			if (!Capsule.all_list.Contains(this))
			{
				Capsule.all_list.Add(this);
			}
			else
			{
				Debug.Log("capsule duplicate..." + base.name);
			}
			this.LoadMyInfo();
		}
		else
		{
			this.canCollect = false;
		}
	}

	// Token: 0x0600000D RID: 13 RVA: 0x00002420 File Offset: 0x00000620
	public string GetSaveName()
	{
		return string.Format("capsule_{0}", this.capsule_index.ToString());
	}

	// Token: 0x0600000E RID: 14 RVA: 0x00002438 File Offset: 0x00000638
	public string GetSaveString()
	{
		return this.respawnTime.ToString();
	}

	// Token: 0x0600000F RID: 15 RVA: 0x00002448 File Offset: 0x00000648
	public void SaveMyInfo()
	{
		PlayerPrefs.SetString(this.GetSaveName(), this.GetSaveString());
	}

	// Token: 0x06000010 RID: 16 RVA: 0x0000245C File Offset: 0x0000065C
	public void LoadMyInfo()
	{
		string @string = PlayerPrefs.GetString(this.GetSaveName(), string.Empty);
		if (@string != string.Empty)
		{
			this.Disable();
		}
	}

	// Token: 0x06000011 RID: 17 RVA: 0x00002490 File Offset: 0x00000690
	private void CheckRespawn()
	{
		if (!this.canCollect)
		{
			this.CheckTimeElapsed();
		}
		else
		{
			base.CancelInvoke("CheckRespawn");
		}
	}

	// Token: 0x06000012 RID: 18 RVA: 0x000024B4 File Offset: 0x000006B4
	private void CheckTimeElapsed()
	{
		if (!this.canCollect && DateTime.Compare(DateTime.Now, this.respawnTime) == 1)
		{
			this.Enable();
		}
	}

	// Token: 0x06000013 RID: 19 RVA: 0x000024E0 File Offset: 0x000006E0
	public void Enable()
	{
		if (Capsule.collected_list.Contains(this))
		{
			Capsule.collected_list.Remove(this);
		}
		this.canCollect = true;
		if (this.capsuleRef.transform.GetComponent<MeshRenderer>())
		{
			this.capsuleRef.transform.GetComponent<MeshRenderer>().enabled = true;
		}
		if (this.capsuleRef.transform.GetComponent<CapsuleCollider>())
		{
			this.capsuleRef.transform.GetComponent<CapsuleCollider>().enabled = true;
		}
		base.collider.enabled = true;
	}

	// Token: 0x06000014 RID: 20 RVA: 0x0000257C File Offset: 0x0000077C
	public void Disable()
	{
		if (!Capsule.collected_list.Contains(this))
		{
			Capsule.collected_list.Add(this);
		}
		this.canCollect = false;
		if (this.capsuleRef.transform.GetComponent<MeshRenderer>())
		{
			this.capsuleRef.transform.GetComponent<MeshRenderer>().enabled = false;
		}
		if (this.capsuleRef.transform.GetComponent<CapsuleCollider>())
		{
			this.capsuleRef.transform.GetComponent<CapsuleCollider>().enabled = false;
		}
		base.collider.enabled = false;
	}

	// Token: 0x06000015 RID: 21 RVA: 0x00002618 File Offset: 0x00000818
	private void Collect()
	{
		if (!Capsule.has_gotten)
		{
			PhoneMemory.SendMail("tut_capsule");
			PhoneInterface.SendPhoneCommand("open_mail tut_capsule");
		}
		this.Disable();
		this.collectedTime = DateTime.Now;
		this.respawnTime = DateTime.Now;
		this.respawnTime = this.respawnTime.AddSeconds(this.respawnSeconds);
		this.respawnTime = this.respawnTime.AddMinutes(this.respawnMinutes);
		this.respawnTime = this.respawnTime.AddHours(this.respawnHours);
		this.respawnTime = this.respawnTime.AddDays(this.respawnDays);
		if (this.clip)
		{
			AudioSource.PlayClipAtPoint(this.clip, Vector3.zero);
		}
		PhoneInterface.AddCapsulePoints((float)this.currentValue);
		PlaytomicController.LogPosition("tGotCapsule", base.transform.position);
		Playtomic.Log.CustomMetric("tGotACapsule", PlaytomicController.current_group, true);
		Playtomic.Log.CustomMetric("Capsule_" + this.capsule_index.ToString(), PlaytomicController.current_group, true);
		this.SaveMyInfo();
	}

	// Token: 0x06000016 RID: 22 RVA: 0x00002740 File Offset: 0x00000940
	private void OnTriggerEnter(Collider collider)
	{
		if (this.canCollect && collider.name == "Player")
		{
			this.Collect();
		}
	}

	// Token: 0x04000007 RID: 7
	public static List<Capsule> all_list = new List<Capsule>();

	// Token: 0x04000008 RID: 8
	public static List<Capsule> collected_list = new List<Capsule>();

	// Token: 0x04000009 RID: 9
	public double respawnSeconds;

	// Token: 0x0400000A RID: 10
	public double respawnMinutes;

	// Token: 0x0400000B RID: 11
	public double respawnHours;

	// Token: 0x0400000C RID: 12
	public double respawnDays = 1.0;

	// Token: 0x0400000D RID: 13
	public int initialValue = 5;

	// Token: 0x0400000E RID: 14
	public int secondaryValue = 1;

	// Token: 0x0400000F RID: 15
	public int capsule_index = -1;

	// Token: 0x04000010 RID: 16
	public GameObject capsuleRef;

	// Token: 0x04000011 RID: 17
	private int currentValue;

	// Token: 0x04000012 RID: 18
	private DateTime collectedTime;

	// Token: 0x04000013 RID: 19
	private DateTime respawnTime;

	// Token: 0x04000014 RID: 20
	public bool canCollect = true;
}
