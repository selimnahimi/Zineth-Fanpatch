using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000072 RID: 114
public class PhoneMainMenu : PhoneScreen
{
	// Token: 0x1700009E RID: 158
	// (get) Token: 0x060004A6 RID: 1190 RVA: 0x0001C6D4 File Offset: 0x0001A8D4
	public PhoneElement[] elements
	{
		get
		{
			return base.GetComponentsInChildren<PhoneElement>();
		}
	}

	// Token: 0x060004A7 RID: 1191 RVA: 0x0001C6DC File Offset: 0x0001A8DC
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x060004A8 RID: 1192 RVA: 0x0001C6F0 File Offset: 0x0001A8F0
	protected virtual void HideBackground()
	{
		base.renderer.enabled = false;
	}

	// Token: 0x060004A9 RID: 1193 RVA: 0x0001C700 File Offset: 0x0001A900
	public override void Init()
	{
		this.SetupButtons();
	}

	// Token: 0x060004AA RID: 1194 RVA: 0x0001C708 File Offset: 0x0001A908
	public override void OnHomeLoad()
	{
		if (!this.special_home_load)
		{
			return;
		}
		bool flag = true;
		foreach (PhoneElement phoneElement in this.elements)
		{
			phoneElement.OnLoad();
			if (flag)
			{
				phoneElement.transform.position = base.transform.position + base.transform.right * 5f;
			}
			else
			{
				phoneElement.transform.position = base.transform.position + base.transform.right * -5f;
			}
			flag = !flag;
		}
	}

	// Token: 0x060004AB RID: 1195 RVA: 0x0001C7B8 File Offset: 0x0001A9B8
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		if (this.exit_animating)
		{
			this.cancel_exit_animate = true;
		}
		this.centerpos = base.transform.position + Vector3.forward * 0.15f;
		if (this.unlocked_menus_only && PhoneMemory.menus_updated)
		{
			PhoneMemory.menus_updated = false;
			this.ClearAutoButtons();
			this.AutoCreateButtons();
		}
		if (this.resetselection)
		{
			this.menuind = 0;
		}
		foreach (PhoneElement phoneElement in this.elements)
		{
			phoneElement.OnLoad();
		}
		if (this.stick_trans && this.stick_trans.renderer)
		{
			this.stick_trans.renderer.material.color = PhoneMemory.settings.selectedTextColor;
		}
		this.UpdateMenuItems();
	}

	// Token: 0x060004AC RID: 1196 RVA: 0x0001C8B0 File Offset: 0x0001AAB0
	public override void OnExit()
	{
		if (this.do_exit_effect && base.gameObject.active)
		{
			if (!this.exit_animating)
			{
				this.exit_animating = true;
				base.StartCoroutine(this.Co_OnExit());
			}
		}
		else
		{
			base.OnExit();
		}
	}

	// Token: 0x060004AD RID: 1197 RVA: 0x0001C904 File Offset: 0x0001AB04
	protected virtual IEnumerator Co_OnExit()
	{
		Vector3 pos = base.transform.position;
		Quaternion rot = base.transform.localRotation;
		Vector3 dir = this.exit_dir;
		if (this.use_other_exit_dir && this.controller.curscreen && this.controller.curscreen != this && this.controller.curscreen.do_exit_effect)
		{
			dir = this.controller.curscreen.exit_dir;
			dir.x *= -1f;
			dir.z *= -1f;
		}
		float timer = 0.5f;
		while (timer > 0f)
		{
			if (this.cancel_exit_animate)
			{
				base.transform.position = pos;
				break;
			}
			timer -= Time.deltaTime;
			base.transform.position = Vector3.Lerp(base.transform.position, pos + dir, Time.deltaTime * 5f);
			yield return null;
		}
		this.exit_animating = false;
		if (this.cancel_exit_animate)
		{
			this.cancel_exit_animate = false;
		}
		else
		{
			base.OnExit();
		}
		yield break;
	}

	// Token: 0x1700009F RID: 159
	// (get) Token: 0x060004AE RID: 1198 RVA: 0x0001C920 File Offset: 0x0001AB20
	private float start_angle
	{
		get
		{
			return this.start_rads * 3.1415927f;
		}
	}

	// Token: 0x170000A0 RID: 160
	// (get) Token: 0x060004AF RID: 1199 RVA: 0x0001C930 File Offset: 0x0001AB30
	private float add_angle
	{
		get
		{
			return this.add_rads * 3.1415927f;
		}
	}

	// Token: 0x060004B0 RID: 1200 RVA: 0x0001C940 File Offset: 0x0001AB40
	protected virtual void AutoCreateButtons_Radial()
	{
		this.centerpos = base.transform.position + Vector3.forward * 0.15f;
		float num = this.start_angle;
		int num2 = 0;
		Vector3 position = this.centerpos + Vector3.right * this.hradius * Mathf.Cos(num) + Vector3.forward * this.vradius * Mathf.Sin(num);
		foreach (string text in this.menu_items)
		{
			if (this.unlocked_menus_only && !PhoneMemory.unlocked_menus.Contains(text))
			{
				num += this.add_angle;
				position = this.centerpos + Vector3.right * this.hradius * Mathf.Cos(num) + Vector3.forward * this.vradius * Mathf.Sin(num);
				num2++;
			}
			else
			{
				PhoneButton phoneButton;
				if (this.button_prefab && this.use_icons)
				{
					phoneButton = (UnityEngine.Object.Instantiate(this.button_prefab) as PhoneButton);
				}
				else
				{
					phoneButton = (UnityEngine.Object.Instantiate(PhoneTextController.buttonprefab) as PhoneButton);
				}
				PhoneScreen screen = this.controller.getScreen(text);
				if (screen)
				{
					screen.exit_dir = new Vector3(8f * Mathf.Cos(num), screen.exit_dir.y, 8f * Mathf.Sin(num));
				}
				if (phoneButton.button_icon && this.use_icons)
				{
					phoneButton.pop_open = true;
					if (screen && screen.icon_texture)
					{
						phoneButton.button_icon.renderer.material.mainTexture = screen.icon_texture;
					}
				}
				phoneButton.transform.position = position;
				phoneButton.transform.parent = base.transform;
				phoneButton.textmesh.text = text;
				phoneButton.button_name = text;
				phoneButton.command = "load_screen " + text;
				phoneButton.screen = this;
				phoneButton.textmesh.alignment = TextAlignment.Center;
				phoneButton.textmesh.anchor = TextAnchor.MiddleCenter;
				phoneButton.animateOnLoad = true;
				this.buttons.Add(phoneButton);
				this.auto_buttons.Add(phoneButton);
				phoneButton.Init();
				phoneButton.transform.position = base.transform.position;
				if (screen)
				{
					phoneButton = screen.Button_To(phoneButton);
				}
				num += this.add_angle;
				position = this.centerpos + Vector3.right * this.hradius * Mathf.Cos(num) + Vector3.forward * this.vradius * Mathf.Sin(num);
				num2++;
			}
		}
	}

	// Token: 0x060004B1 RID: 1201 RVA: 0x0001CC5C File Offset: 0x0001AE5C
	protected virtual void AutoCreateButtons_Vertical()
	{
		Vector3 vector = base.transform.position + base.transform.forward * 3.2f + base.transform.up + base.transform.right * 2.2f;
		foreach (string text in this.menu_items)
		{
			PhoneButton phoneButton = UnityEngine.Object.Instantiate(PhoneTextController.buttonprefab) as PhoneButton;
			phoneButton.transform.position = vector;
			phoneButton.transform.parent = base.transform;
			phoneButton.textmesh.text = text;
			phoneButton.button_name = text;
			phoneButton.command = "load_screen " + text;
			phoneButton.screen = this;
			phoneButton.textmesh.alignment = TextAlignment.Right;
			phoneButton.textmesh.anchor = TextAnchor.MiddleRight;
			phoneButton.animateOnLoad = true;
			this.buttons.Add(phoneButton);
			this.auto_buttons.Add(phoneButton);
			vector += base.transform.forward * -1f;
			phoneButton.Init();
		}
	}

	// Token: 0x060004B2 RID: 1202 RVA: 0x0001CD98 File Offset: 0x0001AF98
	protected virtual void AutoCreateButtons()
	{
		if (this.radial_menu)
		{
			this.AutoCreateButtons_Radial();
		}
		else
		{
			this.AutoCreateButtons_Vertical();
		}
	}

	// Token: 0x060004B3 RID: 1203 RVA: 0x0001CDB8 File Offset: 0x0001AFB8
	protected void ClearAutoButtons()
	{
		foreach (PhoneButton phoneButton in this.auto_buttons)
		{
			this.buttons.Remove(phoneButton);
			UnityEngine.Object.Destroy(phoneButton.gameObject);
		}
		this.auto_buttons.Clear();
	}

	// Token: 0x060004B4 RID: 1204 RVA: 0x0001CE3C File Offset: 0x0001B03C
	protected virtual void SetupButtons()
	{
		foreach (PhoneButton item in base.gameObject.GetComponentsInChildren<PhoneButton>())
		{
			if (!this.buttons.Contains(item))
			{
				this.buttons.Add(item);
			}
		}
		if (this.autocreatebuttons)
		{
			this.AutoCreateButtons();
		}
		if (this.sort_buttonlist && this.buttons != null)
		{
			this.buttons.Sort((PhoneButton b1, PhoneButton b2) => b2.transform.position.z.CompareTo(b1.transform.position.z));
		}
		if (!this.radial_menu && this.auto_button_directions)
		{
			for (int j = 0; j < this.buttons.Count - 1; j++)
			{
				if (!this.buttons[j].down_button)
				{
					this.buttons[j].down_button = this.buttons[j + 1];
				}
				if (!this.buttons[j].down_button.up_button)
				{
					this.buttons[j].down_button.up_button = this.buttons[j];
				}
			}
		}
		this.UpdateMenuItems();
	}

	// Token: 0x060004B5 RID: 1205 RVA: 0x0001CF90 File Offset: 0x0001B190
	public override void UpdateScreen()
	{
		this.UpdateElements();
		int num = this.menuind;
		this.MenuControls();
		if (num != this.menuind)
		{
			this.UpdateMenuItems();
		}
	}

	// Token: 0x060004B6 RID: 1206 RVA: 0x0001CFC4 File Offset: 0x0001B1C4
	protected void UpdateElements()
	{
		foreach (PhoneElement phoneElement in base.GetComponentsInChildren<PhoneElement>())
		{
			phoneElement.OnUpdate();
		}
	}

	// Token: 0x060004B7 RID: 1207 RVA: 0x0001CFF8 File Offset: 0x0001B1F8
	protected virtual void DoMouseControls()
	{
		if (this.stick_trans && this.stick_trans.renderer)
		{
			this.stick_trans.renderer.enabled = false;
		}
		this.menuind = -1;
		Vector3 touchPoint = PhoneInput.GetTouchPoint();
		float num = float.NegativeInfinity;
		if (touchPoint != Vector3.zero * -1f)
		{
			Vector3 point = PhoneInput.TransformPoint(touchPoint);
			for (int i = 0; i < this.current_buttons.Count; i++)
			{
				if (this.current_buttons[i].selectable)
				{
					point.y = this.current_buttons[i].GetBounds().center.y;
					if (point.y > num && this.current_buttons[i].gameObject.active && this.current_buttons[i].ContainsPoint(point))
					{
						this.menuind = i;
						num = point.y;
					}
				}
			}
			Playtomic.Log.CustomMetric("tUsedMouseControls", "tPhone", true);
		}
		if (this.menuind >= 0 && PhoneInput.IsPressedDown())
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x060004B8 RID: 1208 RVA: 0x0001D160 File Offset: 0x0001B360
	protected virtual void DoStickControls()
	{
		if (this.radial_menu)
		{
			this.StickControls_Radial();
		}
		else
		{
			this.StickControls_Vertical();
		}
		Playtomic.Log.CustomMetric("tUsedStickControls", "tPhone", true);
	}

	// Token: 0x060004B9 RID: 1209 RVA: 0x0001D1A0 File Offset: 0x0001B3A0
	protected virtual void StickControls_Radial()
	{
		Vector2 controlDir = PhoneInput.GetControlDir();
		if (this.stick_trans && this.stick_trans.renderer)
		{
			this.stick_trans.renderer.enabled = true;
			this.stick_trans.transform.position = this.centerpos + new Vector3(controlDir.x, 1f, controlDir.y);
		}
		if (controlDir.magnitude > 0.6f)
		{
			float num = 30f;
			int num2 = -1;
			Vector3 vector = new Vector3(controlDir.x, 0f, controlDir.y) * 0.75f;
			for (int i = 0; i < this.buttons.Count; i++)
			{
				Vector3 vector2 = this.buttons[i].transform.position - base.transform.position;
				vector2.y = 0f;
				float num3 = Vector3.Angle(vector.normalized, vector2.normalized);
				if (num3 < num)
				{
					num = num3;
					num2 = i;
				}
			}
			if (num2 != -1)
			{
				this.menuind = num2;
			}
		}
		if (PhoneInput.IsPressedDown() && this.buttons.Count > this.menuind && this.menuind >= 0)
		{
			this.buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x170000A1 RID: 161
	// (get) Token: 0x060004BA RID: 1210 RVA: 0x0001D320 File Offset: 0x0001B520
	public virtual List<PhoneButton> current_buttons
	{
		get
		{
			return this.buttons;
		}
	}

	// Token: 0x060004BB RID: 1211 RVA: 0x0001D328 File Offset: 0x0001B528
	public virtual bool SwitchToButton(PhoneButton button)
	{
		if (button == null)
		{
			return false;
		}
		this.menuind = this.current_buttons.IndexOf(button);
		this.UpdateButtonSelected();
		return true;
	}

	// Token: 0x060004BC RID: 1212 RVA: 0x0001D35C File Offset: 0x0001B55C
	protected virtual void StickControls_ButtonDir()
	{
		this.menuind = Mathf.Clamp(this.menuind, 0, this.current_buttons.Count - 1);
		PhoneButton phoneButton = this.current_buttons[this.menuind];
		bool flag = false;
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (controlDirPressed.y >= 0.5f)
		{
			flag = this.SwitchToButton(phoneButton.up_button);
		}
		else if (controlDirPressed.y <= -0.5f)
		{
			flag = this.SwitchToButton(phoneButton.down_button);
		}
		if (!flag)
		{
			if (controlDirPressed.x >= 0.5f)
			{
				flag = this.SwitchToButton(phoneButton.right_button);
			}
			else if (controlDirPressed.x <= -0.5f)
			{
				flag = this.SwitchToButton(phoneButton.left_button);
			}
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x060004BD RID: 1213 RVA: 0x0001D460 File Offset: 0x0001B660
	protected virtual void StickControls_Vertical()
	{
		if (this.use_button_dir_control)
		{
			this.StickControls_ButtonDir();
			return;
		}
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
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
				this.menuind = Mathf.Max(0, this.current_buttons.Count - 1);
			}
			if (this.menuind >= this.current_buttons.Count)
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
			if (this.menuind >= this.current_buttons.Count)
			{
				this.menuind = Mathf.Max(0, this.current_buttons.Count - 1);
			}
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x060004BE RID: 1214 RVA: 0x0001D590 File Offset: 0x0001B790
	protected virtual void MenuControls()
	{
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			this.DoMouseControls();
		}
		else
		{
			this.DoStickControls();
		}
	}

	// Token: 0x060004BF RID: 1215 RVA: 0x0001D5B0 File Offset: 0x0001B7B0
	protected virtual void UpdateButtonSelected()
	{
		for (int i = 0; i < this.current_buttons.Count; i++)
		{
			this.current_buttons[i].selected = (i == this.menuind);
			if (i == this.menuind)
			{
				this.current_buttons[i].OnSelected();
				this.SetMenuLines(this.current_buttons[i]);
			}
		}
	}

	// Token: 0x060004C0 RID: 1216 RVA: 0x0001D624 File Offset: 0x0001B824
	protected virtual void SetMenuLines(PhoneButton button)
	{
		foreach (PhoneMenuLine phoneMenuLine in this.controller.menulines)
		{
			phoneMenuLine.start = button;
		}
		this.controller.menulines[0].end = button.up_button;
		this.controller.menulines[1].end = button.down_button;
		this.controller.menulines[2].end = button.left_button;
		this.controller.menulines[3].end = button.right_button;
	}

	// Token: 0x060004C1 RID: 1217 RVA: 0x0001D6BC File Offset: 0x0001B8BC
	protected void UpdateMenuItems()
	{
		this.UpdateButtonSelected();
		if (this.label)
		{
			if (this.menuind >= 0 && this.menuind < this.current_buttons.Count && this.use_icons)
			{
				this.label.text = this.current_buttons[this.menuind].button_name;
			}
			else
			{
				this.label.text = string.Empty;
			}
		}
	}

	// Token: 0x060004C2 RID: 1218 RVA: 0x0001D744 File Offset: 0x0001B944
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message.StartsWith("trailcolor_"))
		{
			PhoneButtonSlider phoneButtonSlider = button as PhoneButtonSlider;
			Color trailColor = PhoneInterface.trailColor;
			if (message.EndsWith("r"))
			{
				trailColor.r = phoneButtonSlider.val;
			}
			else if (message.EndsWith("g"))
			{
				trailColor.g = phoneButtonSlider.val;
			}
			else if (message.EndsWith("b"))
			{
				trailColor.b = phoneButtonSlider.val;
			}
			PhoneInterface.trailColor = trailColor;
			return true;
		}
		if (message.StartsWith("robotcolor_"))
		{
			PhoneButtonSlider phoneButtonSlider2 = button as PhoneButtonSlider;
			Color robotColor = PhoneInterface.robotColor;
			if (message.EndsWith("r"))
			{
				robotColor.r = phoneButtonSlider2.val;
			}
			else if (message.EndsWith("g"))
			{
				robotColor.g = phoneButtonSlider2.val;
			}
			else if (message.EndsWith("b"))
			{
				robotColor.b = phoneButtonSlider2.val;
			}
			PhoneInterface.robotColor = robotColor;
			return true;
		}
		if (message.StartsWith("bgcolor_"))
		{
			if (message.StartsWith("bgcolor_r"))
			{
				PhoneButtonSlider phoneButtonSlider3 = button as PhoneButtonSlider;
				Color back = PhoneMemory.settings.pallete.back;
				back.r = phoneButtonSlider3.val;
				PhoneMemory.settings.pallete.back = back;
				PhoneController.instance.SetBackColor(back);
				return true;
			}
			if (message.StartsWith("bgcolor_g"))
			{
				PhoneButtonSlider phoneButtonSlider4 = button as PhoneButtonSlider;
				Color back2 = PhoneMemory.settings.pallete.back;
				back2.g = phoneButtonSlider4.val;
				PhoneMemory.settings.pallete.back = back2;
				PhoneController.instance.SetBackColor(back2);
				return true;
			}
			if (message.StartsWith("bgcolor_b"))
			{
				PhoneButtonSlider phoneButtonSlider5 = button as PhoneButtonSlider;
				Color back3 = PhoneMemory.settings.pallete.back;
				back3.b = phoneButtonSlider5.val;
				PhoneMemory.settings.pallete.back = back3;
				PhoneController.instance.SetBackColor(back3);
				return true;
			}
		}
		else if (message.StartsWith("volume_"))
		{
			if (message.StartsWith("volume_menu"))
			{
				PhoneButtonSlider phoneButtonSlider6 = button as PhoneButtonSlider;
				PhoneMemory.settings.menu_volume = phoneButtonSlider6.val;
				Playtomic.Log.CustomMetric("tChangedMenuVolume", "tPhone", true);
				return true;
			}
			if (message.StartsWith("volume_game"))
			{
				PhoneButtonSlider phoneButtonSlider7 = button as PhoneButtonSlider;
				PhoneMemory.settings.game_volume = phoneButtonSlider7.val;
				Playtomic.Log.CustomMetric("tChangedGameVolume", "tPhone", true);
				return true;
			}
			if (message.StartsWith("volume_music"))
			{
				PhoneButtonSlider phoneButtonSlider8 = button as PhoneButtonSlider;
				PhoneMemory.settings.music_volume = phoneButtonSlider8.val;
				Playtomic.Log.CustomMetric("tChangedMusicVolume", "tPhone", true);
				return true;
			}
			if (message.StartsWith("volume_ring"))
			{
				PhoneButtonSlider phoneButtonSlider9 = button as PhoneButtonSlider;
				PhoneMemory.settings.ring_volume = phoneButtonSlider9.val;
				Playtomic.Log.CustomMetric("tChangedRingVolume", "tPhone", true);
				return true;
			}
			if (message.StartsWith("volume_master"))
			{
				PhoneButtonSlider phoneButtonSlider10 = button as PhoneButtonSlider;
				PhoneMemory.settings.master_volume = phoneButtonSlider10.val;
				Playtomic.Log.CustomMetric("tChangedMasterVolume", "tPhone", true);
				return true;
			}
			if (message.StartsWith("volume_vibrate"))
			{
				PhoneButtonSlider phoneButtonSlider11 = button as PhoneButtonSlider;
				PhoneMemory.settings.vibrate_amount = phoneButtonSlider11.val;
				Playtomic.Log.CustomMetric("tChangedVibrateVolume", "tPhone", true);
				return true;
			}
		}
		else if (message.StartsWith("debug_"))
		{
			if (message.StartsWith("debug_mission_dlc"))
			{
				MissionLoadControl.instance.dogui = !MissionLoadControl.instance.dogui;
				button.text = button.text.Replace("(on)", string.Empty).Replace("(off)", string.Empty);
				button.text += ((!MissionLoadControl.instance.dogui) ? "(off)" : "(on)");
			}
			else if (message.StartsWith("debug_mouse_cam"))
			{
				NewCamera.use_mouse_look = !NewCamera.use_mouse_look;
				button.text = button.text.Replace("(on)", string.Empty).Replace("(off)", string.Empty);
				button.text += ((!NewCamera.use_mouse_look) ? "(off)" : "(on)");
			}
			else if (message.StartsWith("debug_mmo"))
			{
				Networking.instance.enabled = !Networking.instance.enabled;
				button.text = button.text.Replace("(on)", string.Empty).Replace("(off)", string.Empty);
				button.text += ((!Networking.instance.enabled) ? "(off)" : "(on)");
			}
			else if (message.StartsWith("debug_wall_control"))
			{
				PhoneInterface.player_move.V1 = !PhoneInterface.player_move.V1;
				button.text = button.text.Replace("(on)", string.Empty).Replace("(off)", string.Empty);
				button.text += ((!PhoneInterface.player_move.V1) ? "(off)" : "(on)");
			}
		}
		else if (message.StartsWith("invert_phone_stick"))
		{
			PhoneInput.invert_stick = !PhoneInput.invert_stick;
			button.text = button.text.Replace("(on)", string.Empty).Replace("(off)", string.Empty);
			button.text += ((!PhoneInput.invert_stick) ? "(off)" : "(on)");
		}
		else
		{
			if (!message.StartsWith("post_"))
			{
				return base.ButtonMessage(button, message);
			}
			if (message == "post_text_tweet")
			{
				if (!TwitterDemo.instance._canTweet)
				{
					return false;
				}
				if (button.id_info == string.Empty)
				{
					this.controller.LoadScreen("Twitter");
					PhoneTwitterMenu.instance.PostTweet();
				}
				else
				{
					this.controller.LoadScreen("Twitter");
					PhoneTwitterMenu.instance.PostTweet(button.id_info);
				}
			}
			else if (message == "post_image_tweet")
			{
				if (!TwitterDemo.instance._canTweet)
				{
					return false;
				}
				TwitterDemo.instance.DoPostScreenshot();
				base.Invoke("LoadTwitterScreen", 0.25f);
			}
			else if (message == "post_monster_info_tweet")
			{
				if (!TwitterDemo.instance._canTweet)
				{
					return false;
				}
				PhoneResourceController.SaveMonsterInfoCard(PhoneMemory.main_monster, new PhoneResourceController.TextureReturn(TwitterDemo.instance.DoPostImage));
				this.controller.LoadScreen("Twitter");
			}
		}
		return true;
	}

	// Token: 0x060004C3 RID: 1219 RVA: 0x0001DECC File Offset: 0x0001C0CC
	private void LoadTwitterScreen()
	{
		this.controller.LoadScreen("Twitter");
	}

	// Token: 0x040003A7 RID: 935
	public int menuind;

	// Token: 0x040003A8 RID: 936
	public PhoneButton button_prefab;

	// Token: 0x040003A9 RID: 937
	public PhoneLabel label;

	// Token: 0x040003AA RID: 938
	public bool use_icons = true;

	// Token: 0x040003AB RID: 939
	public bool autocreatebuttons = true;

	// Token: 0x040003AC RID: 940
	public bool unlocked_menus_only;

	// Token: 0x040003AD RID: 941
	public bool resetselection = true;

	// Token: 0x040003AE RID: 942
	public string[] menu_items;

	// Token: 0x040003AF RID: 943
	public List<PhoneButton> buttons = new List<PhoneButton>();

	// Token: 0x040003B0 RID: 944
	public bool hide_background = true;

	// Token: 0x040003B1 RID: 945
	public bool special_home_load;

	// Token: 0x040003B2 RID: 946
	protected bool exit_animating;

	// Token: 0x040003B3 RID: 947
	protected bool cancel_exit_animate;

	// Token: 0x040003B4 RID: 948
	public bool sort_buttonlist = true;

	// Token: 0x040003B5 RID: 949
	private Vector3 centerpos = Vector3.zero;

	// Token: 0x040003B6 RID: 950
	public List<PhoneButton> auto_buttons = new List<PhoneButton>();

	// Token: 0x040003B7 RID: 951
	public float start_rads = 0.25f;

	// Token: 0x040003B8 RID: 952
	public float hradius = 1.5f;

	// Token: 0x040003B9 RID: 953
	public float vradius = 2f;

	// Token: 0x040003BA RID: 954
	public float add_rads = 0.25f;

	// Token: 0x040003BB RID: 955
	public bool auto_button_directions = true;

	// Token: 0x040003BC RID: 956
	public bool radial_menu;

	// Token: 0x040003BD RID: 957
	public Transform stick_trans;

	// Token: 0x040003BE RID: 958
	public bool controls_wrap;

	// Token: 0x040003BF RID: 959
	public bool use_button_dir_control;
}
