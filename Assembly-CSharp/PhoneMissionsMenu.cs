using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000076 RID: 118
public class PhoneMissionsMenu : PhoneMailMenu
{
	// Token: 0x060004CE RID: 1230 RVA: 0x0001E1F4 File Offset: 0x0001C3F4
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x060004CF RID: 1231 RVA: 0x0001E208 File Offset: 0x0001C408
	protected override bool CheckUpdates()
	{
		if (MissionController.refresh)
		{
			if (Application.isEditor)
			{
				MonoBehaviour.print("refreshing");
			}
			if (this.mode == PhoneMailMenu.mailmode.inbox)
			{
				this.SetupMail();
			}
			MissionController.refresh = false;
			return true;
		}
		return false;
	}

	// Token: 0x170000A2 RID: 162
	// (get) Token: 0x060004D0 RID: 1232 RVA: 0x0001E250 File Offset: 0x0001C450
	protected override List<PhoneMail> mail_list
	{
		get
		{
			return MissionController.ActiveMissionsAsMail();
		}
	}

	// Token: 0x060004D1 RID: 1233 RVA: 0x0001E258 File Offset: 0x0001C458
	protected override void SetupMail()
	{
		this.HideFocusMarker();
		base.SetupMail();
		this.mail_title_label.text = string.Concat(new string[]
		{
			"<Missions ",
			MissionController.completed_missions.Count.ToString(),
			"/",
			MissionController.all_missions.Count.ToString(),
			">"
		});
		base.StartCoroutine("SetupFocusMarker");
	}

	// Token: 0x060004D2 RID: 1234 RVA: 0x0001E2D8 File Offset: 0x0001C4D8
	private IEnumerator SetupFocusMarker()
	{
		yield return !this.setting_up_mail;
		while (this.setting_up_mail)
		{
			yield return null;
		}
		if (MissionController.focus_mission)
		{
			foreach (PhoneButton button in this.mailbuttons)
			{
				if (MissionController.focus_mission && "m_" + MissionController.focus_mission.id == button.id_info)
				{
					this.SetFocusMarker(button);
				}
			}
		}
		yield break;
	}

	// Token: 0x060004D3 RID: 1235 RVA: 0x0001E2F4 File Offset: 0x0001C4F4
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message.StartsWith("mission_focus"))
		{
			return this.SetFocus(this.current_mail);
		}
		if (message.StartsWith("accept"))
		{
			return true;
		}
		if (message.StartsWith("openmessage"))
		{
			return this.SetFocus(button);
		}
		return base.ButtonMessage(button, message);
	}

	// Token: 0x060004D4 RID: 1236 RVA: 0x0001E350 File Offset: 0x0001C550
	protected virtual bool SetFocus(PhoneButton button)
	{
		bool refresh = MissionController.refresh;
		bool result;
		if (MissionController.focus_mission && "m_" + MissionController.focus_mission.id == button.id_info)
		{
			this.focus_marker.renderer.enabled = false;
			MissionController.Unfocus();
			result = true;
		}
		else
		{
			this.SetFocusMarker(button);
			result = this.SetFocus(MailController.FindMail(button.id_info));
		}
		MissionController.refresh = refresh;
		return result;
	}

	// Token: 0x060004D5 RID: 1237 RVA: 0x0001E3D8 File Offset: 0x0001C5D8
	protected virtual bool SetFocus(PhoneMail mail)
	{
		if (mail == null)
		{
			return false;
		}
		string focus = mail.id.Substring(2);
		MissionController.SetFocus(focus);
		return true;
	}

	// Token: 0x060004D6 RID: 1238 RVA: 0x0001E404 File Offset: 0x0001C604
	private void SetFocusMarker(PhoneButton button)
	{
		if (!this.focus_marker)
		{
			return;
		}
		this.focus_marker.renderer.enabled = true;
		this.focus_marker.renderer.material.color = this.button_prefab.back_normal_color;
		if (button.animateOnLoad)
		{
			MonoBehaviour.print("button animated");
			Vector3 vector = button.wantedpos + Vector3.right * 2.4f - Vector3.forward * 0.4f;
			this.focus_marker.wantedpos = vector;
		}
		else
		{
			Vector3 vector = button.GetCenter();
			vector.x = button.GetBounds().max.x + 0.25f;
			this.focus_marker.transform.position = vector;
			this.focus_marker.wantedpos = this.focus_marker.transform.localPosition;
		}
	}

	// Token: 0x060004D7 RID: 1239 RVA: 0x0001E500 File Offset: 0x0001C700
	private void HideFocusMarker()
	{
		if (this.focus_marker)
		{
			this.focus_marker.renderer.enabled = false;
		}
	}

	// Token: 0x040003CD RID: 973
	public PhoneElement focus_marker;
}
