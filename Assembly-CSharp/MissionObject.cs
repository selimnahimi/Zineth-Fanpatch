using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000020 RID: 32
public class MissionObject : MonoBehaviour
{
	// Token: 0x060000E2 RID: 226 RVA: 0x00008428 File Offset: 0x00006628
	public MissionInfo GetMissionInfo()
	{
		return new MissionInfo(this.title, this.id, this.status, this.description, this.introText, this.outroText);
	}

	// Token: 0x060000E3 RID: 227 RVA: 0x00008454 File Offset: 0x00006654
	public List<MissionObjective> GetCurrentObjectives()
	{
		List<MissionObjective> list = new List<MissionObjective>();
		for (int i = 0; i < this.objectives.Count; i++)
		{
			if (!this.objectives[i].completed && !this.objectives[i].skipAsCurrent)
			{
				list.Add(this.objectives[i]);
				if (this.objectives[i].block_next)
				{
					return list;
				}
			}
		}
		return list;
	}

	// Token: 0x060000E4 RID: 228 RVA: 0x000084E0 File Offset: 0x000066E0
	private void Awake()
	{
		if (this.objectives.Count == 0)
		{
			MissionObjective[] componentsInChildren = base.GetComponentsInChildren<MissionObjective>();
			foreach (MissionObjective item in componentsInChildren)
			{
				this.objectives.Add(item);
			}
		}
		this.LoadMyInfo();
		if (MissionController.all_missions.Count > 0)
		{
			MissionController.AddMission(this);
		}
	}

	// Token: 0x060000E5 RID: 229 RVA: 0x00008548 File Offset: 0x00006748
	public string GetSaveName()
	{
		return string.Format("mission_{0}", this.id);
	}

	// Token: 0x060000E6 RID: 230 RVA: 0x0000855C File Offset: 0x0000675C
	public int GetSaveValue()
	{
		return this.status;
	}

	// Token: 0x060000E7 RID: 231 RVA: 0x00008564 File Offset: 0x00006764
	public void SaveMyInfo()
	{
		PlayerPrefs.SetInt(this.GetSaveName(), this.GetSaveValue());
		PlayerPrefs.Save();
	}

	// Token: 0x060000E8 RID: 232 RVA: 0x0000857C File Offset: 0x0000677C
	public void LoadMyInfo()
	{
		int @int = PlayerPrefs.GetInt(this.GetSaveName(), -1);
		if (@int != -1 && @int >= 0 && @int <= 2)
		{
			this.status = @int;
		}
		else
		{
			this.status = 0;
		}
	}

	// Token: 0x060000E9 RID: 233 RVA: 0x000085C0 File Offset: 0x000067C0
	private void Update()
	{
		if (this.status == 1)
		{
			string guitext = MissionController.guitext;
			this.CheckObjectives();
			if (MissionController.focus_mission != this)
			{
				MissionController.guitext = guitext;
			}
		}
	}

	// Token: 0x060000EA RID: 234 RVA: 0x000085FC File Offset: 0x000067FC
	public void StartMission()
	{
		foreach (MissionObjective missionObjective in this.objectives)
		{
			missionObjective.completed = false;
			missionObjective.gameObject.SetActiveRecursively(false);
		}
	}

	// Token: 0x060000EB RID: 235 RVA: 0x00008670 File Offset: 0x00006870
	public void FailMission()
	{
		if (this.play_sound)
		{
			if (this.failed_sound)
			{
				PhoneAudioController.PlayAudioClip(this.failed_sound, SoundType.other);
			}
			else if (MissionController.mission_fail_sound)
			{
				PhoneAudioController.PlayAudioClip(MissionController.mission_fail_sound, SoundType.other);
			}
		}
		this.DoFailedGUI();
		this.RestartMission();
	}

	// Token: 0x060000EC RID: 236 RVA: 0x000086D4 File Offset: 0x000068D4
	public void RestartMission()
	{
		this.StartMission();
	}

	// Token: 0x060000ED RID: 237 RVA: 0x000086DC File Offset: 0x000068DC
	private void CheckObjectives()
	{
		if (this.show_gui)
		{
			MissionController.guitext = this.gui_message + "\n";
		}
		else
		{
			MissionController.guitext = string.Empty;
		}
		bool flag = true;
		for (int i = 0; i < this.objectives.Count; i++)
		{
			MissionObjective missionObjective = this.objectives[i];
			if (!missionObjective.completed)
			{
				if (!missionObjective.gameObject.active)
				{
					missionObjective.OnBegin();
				}
				if (missionObjective.CheckCompleted())
				{
					if (i == 0 && this.set_focus_after_first)
					{
						MissionController.SetFocus(this.id);
					}
					missionObjective.completed = true;
					missionObjective.OnCompleted();
				}
				else
				{
					flag = false;
					if (missionObjective.failed)
					{
						this.RestartMission();
						return;
					}
					if (missionObjective.block_next)
					{
						return;
					}
				}
			}
		}
		if (flag)
		{
			if (Application.isEditor)
			{
				MonoBehaviour.print("all completed");
			}
			this.SetComplete();
		}
	}

	// Token: 0x060000EE RID: 238 RVA: 0x000087E0 File Offset: 0x000069E0
	private void SetComplete()
	{
		MissionController.SetComplete(this.id);
		this.OnComplete();
	}

	// Token: 0x060000EF RID: 239 RVA: 0x000087F4 File Offset: 0x000069F4
	protected virtual void OnComplete()
	{
		if (this.play_sound)
		{
			AudioClip mission_complete_sound;
			if (this.completed_sound)
			{
				mission_complete_sound = this.completed_sound;
			}
			else
			{
				mission_complete_sound = MissionController.mission_complete_sound;
			}
			if (mission_complete_sound != null)
			{
				PhoneAudioController.PlayAudioClip(mission_complete_sound, SoundType.other);
			}
		}
		if (Application.isEditor)
		{
			MonoBehaviour.print("mission completed: " + this.title);
		}
		this.DoCompletedGUI();
		foreach (MissionObjective missionObjective in this.objectives)
		{
			missionObjective.OnEnd();
		}
		if (this.send_mail)
		{
			MailController.SendMail(this.completed_mail);
		}
		if (this.command_string != string.Empty)
		{
			PhoneController.DoPhoneCommand(this.command_string);
		}
	}

	// Token: 0x060000F0 RID: 240 RVA: 0x000088F8 File Offset: 0x00006AF8
	protected virtual void DoCompletedGUI()
	{
		MissionGUIText missionGUIText = MissionGUIText.Create(this.title + " Complete!", new Vector3(0.024f, 0.2857143f, 0f), Vector3.one * 10f);
		missionGUIText.color = Color.green;
		missionGUIText.velocity = Vector3.up * 0.25f;
		missionGUIText.stopAfter = 0.15f;
		missionGUIText.lifeTime = 2f;
	}

	// Token: 0x060000F1 RID: 241 RVA: 0x00008974 File Offset: 0x00006B74
	protected virtual void DoFailedGUI()
	{
		MissionGUIText missionGUIText = MissionGUIText.Create(this.title + " Failed", new Vector3(0.024f, 0.6666667f, 0f), Vector3.one * 10f);
		missionGUIText.color = Color.red;
		missionGUIText.velocity = Vector3.down * 0.12f;
		missionGUIText.shake = Vector2.right * 3f;
		missionGUIText.stopAfter = 1f;
		missionGUIText.lifeTime = 2f;
	}

	// Token: 0x04000136 RID: 310
	public string title = "Default Title";

	// Token: 0x04000137 RID: 311
	public string id = "zzzzz";

	// Token: 0x04000138 RID: 312
	public bool auto_add = true;

	// Token: 0x04000139 RID: 313
	public bool auto_active;

	// Token: 0x0400013A RID: 314
	public int status;

	// Token: 0x0400013B RID: 315
	public string description = "This describes the mission. The player will love to read this description.";

	// Token: 0x0400013C RID: 316
	public string introText = "This is the text that you see when receiving a mission.";

	// Token: 0x0400013D RID: 317
	public string outroText = "This is the text that you see when completing a mission.";

	// Token: 0x0400013E RID: 318
	public bool is_new = true;

	// Token: 0x0400013F RID: 319
	public bool set_focus_after_first = true;

	// Token: 0x04000140 RID: 320
	public bool play_sound = true;

	// Token: 0x04000141 RID: 321
	public AudioClip completed_sound;

	// Token: 0x04000142 RID: 322
	public AudioClip start_sound;

	// Token: 0x04000143 RID: 323
	public AudioClip failed_sound;

	// Token: 0x04000144 RID: 324
	public string command_string = string.Empty;

	// Token: 0x04000145 RID: 325
	public string gui_message = string.Empty;

	// Token: 0x04000146 RID: 326
	public bool show_gui;

	// Token: 0x04000147 RID: 327
	public bool send_mail;

	// Token: 0x04000148 RID: 328
	public PhoneMail completed_mail;

	// Token: 0x04000149 RID: 329
	public List<MissionObjective> objectives = new List<MissionObjective>();
}
