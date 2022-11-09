using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007A RID: 122
public class PhoneOverlayMenu : PhoneScreen
{
	// Token: 0x06000508 RID: 1288 RVA: 0x0001FA38 File Offset: 0x0001DC38
	private void Start()
	{
		if (this.clocklabel == null)
		{
			this.clocklabel = base.transform.Find("ClockLabel").GetComponent<PhoneLabel>();
		}
		if (this.fpslabel == null)
		{
			this.fpslabel = base.transform.Find("FPSLabel").GetComponent<PhoneLabel>();
		}
		if (this.moneylabel == null)
		{
			this.moneylabel = base.transform.Find("MoneyLabel").GetComponent<PhoneLabel>();
		}
	}

	// Token: 0x06000509 RID: 1289 RVA: 0x0001FACC File Offset: 0x0001DCCC
	public override void Init()
	{
		this.SetupButtons();
		this.timeleft = this.updateInterval;
	}

	// Token: 0x0600050A RID: 1290 RVA: 0x0001FAE0 File Offset: 0x0001DCE0
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		foreach (PhoneElement phoneElement in this.elements)
		{
			phoneElement.OnLoad();
		}
		this.menuind = 0;
		this.UpdateMenuItems();
	}

	// Token: 0x0600050B RID: 1291 RVA: 0x0001FB60 File Offset: 0x0001DD60
	private void SetupButtons()
	{
		foreach (PhoneElement phoneElement in base.gameObject.GetComponentsInChildren<PhoneElement>())
		{
			this.elements.Add(phoneElement);
			phoneElement.Init();
		}
		foreach (PhoneButton item in base.gameObject.GetComponentsInChildren<PhoneButton>())
		{
			this.buttons.Add(item);
		}
		this.UpdateMenuItems();
	}

	// Token: 0x0600050C RID: 1292 RVA: 0x0001FBE4 File Offset: 0x0001DDE4
	public override void UpdateScreen()
	{
		foreach (PhoneElement phoneElement in this.elements)
		{
			phoneElement.OnUpdate();
		}
		this.clocklabel.text = DateTime.Now.ToString("H:mm");
		this.UpdateFramerate();
		this.UpdateMoney();
	}

	// Token: 0x0600050D RID: 1293 RVA: 0x0001FC74 File Offset: 0x0001DE74
	private void UpdateFramerate()
	{
		this.timeleft -= base.deltatime;
		this.accum += Time.timeScale / base.deltatime;
		this.frames++;
		if (this.timeleft <= 0f)
		{
			float num = this.accum / (float)this.frames;
			string text = string.Format("{0:F0}", num);
			this.fpslabel.text = text;
			this.timeleft = this.updateInterval;
			this.accum = 0f;
			this.frames = 0;
		}
	}

	// Token: 0x0600050E RID: 1294 RVA: 0x0001FD18 File Offset: 0x0001DF18
	private void UpdateMoney()
	{
		if (this.last_money != PhoneMemory.capsule_points)
		{
			this.last_money = PhoneMemory.capsule_points;
			if (this.moneylabel)
			{
				this.moneylabel.text = string.Format("${0:F0}", this.last_money);
			}
		}
	}

	// Token: 0x0600050F RID: 1295 RVA: 0x0001FD70 File Offset: 0x0001DF70
	public void MenuControls()
	{
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			this.menuind = -1;
			Vector3 touchPoint = PhoneInput.GetTouchPoint();
			if (touchPoint != Vector3.zero * -1f)
			{
				Vector3 point = PhoneInput.TransformPoint(touchPoint);
				for (int i = 0; i < this.buttons.Count; i++)
				{
					point.y = this.buttons[i].transform.position.y;
					if (this.buttons[i].ContainsPoint(point))
					{
						this.menuind = i;
					}
				}
			}
			if (this.menuind >= 0 && PhoneInput.IsPressedDown())
			{
				this.buttons[this.menuind].OnPressed();
			}
		}
		else if (this.isactive)
		{
			if (Input.GetKeyDown(KeyCode.UpArrow))
			{
				this.menuind--;
			}
			if (Input.GetKeyDown(KeyCode.DownArrow))
			{
				this.menuind++;
			}
			if (this.menuind < 0)
			{
				this.menuind = this.buttons.Count - 1;
			}
			if (this.menuind >= this.buttons.Count)
			{
				this.menuind = 0;
			}
			if (Input.GetKeyDown(KeyCode.Z))
			{
				this.buttons[this.menuind].OnPressed();
			}
		}
	}

	// Token: 0x06000510 RID: 1296 RVA: 0x0001FEE8 File Offset: 0x0001E0E8
	private void UpdateMenuItems()
	{
		for (int i = 0; i < this.buttons.Count; i++)
		{
			this.buttons[i].selected = (i == this.menuind);
		}
	}

	// Token: 0x040003F2 RID: 1010
	private int menuind;

	// Token: 0x040003F3 RID: 1011
	public List<PhoneButton> buttons = new List<PhoneButton>();

	// Token: 0x040003F4 RID: 1012
	public List<PhoneElement> elements = new List<PhoneElement>();

	// Token: 0x040003F5 RID: 1013
	private bool isactive;

	// Token: 0x040003F6 RID: 1014
	public PhoneLabel clocklabel;

	// Token: 0x040003F7 RID: 1015
	public PhoneLabel fpslabel;

	// Token: 0x040003F8 RID: 1016
	public PhoneLabel moneylabel;

	// Token: 0x040003F9 RID: 1017
	private float updateInterval = 0.5f;

	// Token: 0x040003FA RID: 1018
	private float accum;

	// Token: 0x040003FB RID: 1019
	private int frames;

	// Token: 0x040003FC RID: 1020
	private float timeleft;

	// Token: 0x040003FD RID: 1021
	private float last_money = float.NegativeInfinity;
}
