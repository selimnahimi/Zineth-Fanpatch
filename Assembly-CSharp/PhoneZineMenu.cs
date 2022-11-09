using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000086 RID: 134
public class PhoneZineMenu : PhoneMainMenu
{
	// Token: 0x0600059E RID: 1438 RVA: 0x00023FD4 File Offset: 0x000221D4
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x0600059F RID: 1439 RVA: 0x00023FE8 File Offset: 0x000221E8
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.menuind = 0;
		this.UpdateLevelTexture();
		foreach (PhoneElement phoneElement in base.elements)
		{
			phoneElement.OnLoad();
		}
		base.UpdateMenuItems();
	}

	// Token: 0x170000BC RID: 188
	// (get) Token: 0x060005A0 RID: 1440 RVA: 0x0002403C File Offset: 0x0002223C
	public Texture2D current_texture
	{
		get
		{
			if (this.zine_ind >= this.zine_images.Count)
			{
				Debug.LogWarning(string.Concat(new object[]
				{
					"nonnonono: your ind:",
					this.zine_ind,
					" list size:",
					this.zine_images.Count
				}));
			}
			return this.zine_images[this.zine_ind];
		}
	}

	// Token: 0x060005A1 RID: 1441 RVA: 0x000240B4 File Offset: 0x000222B4
	public void UpdateLevelTexture()
	{
		if (this.texturelabel)
		{
			this.texturelabel.renderer.material.mainTexture = this.current_texture;
		}
	}

	// Token: 0x170000BD RID: 189
	// (get) Token: 0x060005A2 RID: 1442 RVA: 0x000240EC File Offset: 0x000222EC
	public List<Texture2D> zine_images
	{
		get
		{
			return PhoneMemory.unlocked_zines;
		}
	}

	// Token: 0x060005A3 RID: 1443 RVA: 0x000240F4 File Offset: 0x000222F4
	private void NextLevel()
	{
		this.zine_ind++;
		if (this.zine_ind >= this.zine_images.Count)
		{
			this.zine_ind = 0;
		}
		this.UpdateLevelTexture();
		if (PhoneInterface.IsZineVisible())
		{
			this.SetZineVisible();
		}
		if (this.nextbut)
		{
			this.nextbut.transform.position -= base.transform.right * 0.15f;
		}
	}

	// Token: 0x060005A4 RID: 1444 RVA: 0x00024184 File Offset: 0x00022384
	private void PreviousLevel()
	{
		this.zine_ind--;
		if (this.zine_ind < 0)
		{
			this.zine_ind = this.zine_images.Count - 1;
		}
		this.UpdateLevelTexture();
		if (PhoneInterface.IsZineVisible())
		{
			this.SetZineVisible();
		}
		if (this.prevbut)
		{
			this.prevbut.transform.position += base.transform.right * 0.15f;
		}
	}

	// Token: 0x060005A5 RID: 1445 RVA: 0x00024218 File Offset: 0x00022418
	public override bool ButtonMessage(PhoneButton button, string command)
	{
		if (command == "next")
		{
			this.NextLevel();
		}
		else if (command == "previous")
		{
			this.PreviousLevel();
		}
		else if (command == "toggle")
		{
			if (PhoneInterface.IsZineVisible())
			{
				this.showhidebutton.text = "Show";
				return this.HideZine();
			}
			this.showhidebutton.text = "Hide";
			return this.SetZineVisible();
		}
		else
		{
			if (command == "show")
			{
				Playtomic.Log.CustomMetric("tShowedZine", "tPhone", true);
				return this.SetZineVisible();
			}
			if (command == "hide")
			{
				Playtomic.Log.CustomMetric("tHidZine", "tPhone", true);
				return this.HideZine();
			}
			if (!(command == "accept"))
			{
				return base.ButtonMessage(button, command);
			}
		}
		return true;
	}

	// Token: 0x060005A6 RID: 1446 RVA: 0x0002431C File Offset: 0x0002251C
	public bool SetZineVisible()
	{
		return this.SetZineVisible(this.zine_ind);
	}

	// Token: 0x060005A7 RID: 1447 RVA: 0x0002432C File Offset: 0x0002252C
	public bool SetZineVisible(int index)
	{
		return this.SetZineVisible(this.zine_images[index]);
	}

	// Token: 0x060005A8 RID: 1448 RVA: 0x00024340 File Offset: 0x00022540
	public bool SetZineVisible(Texture2D tex)
	{
		this.last_zine_tex = tex;
		return PhoneInterface.ShowZine(tex);
	}

	// Token: 0x060005A9 RID: 1449 RVA: 0x00024350 File Offset: 0x00022550
	public bool HideZine()
	{
		return PhoneInterface.HideZine();
	}

	// Token: 0x060005AA RID: 1450 RVA: 0x00024358 File Offset: 0x00022558
	protected override void MenuControls()
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
		else
		{
			Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
			if (controlDirPressed.x >= 0.5f)
			{
				this.NextLevel();
			}
			else if (controlDirPressed.x <= -0.5f)
			{
				this.PreviousLevel();
			}
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
					this.menuind = Mathf.Max(0, this.buttons.Count - 1);
				}
				if (this.menuind >= this.buttons.Count)
				{
					this.menuind = 0;
				}
				while (this.buttons[this.menuind] == this.nextbut || this.buttons[this.menuind] == this.prevbut)
				{
					this.menuind++;
				}
				if (this.menuind >= this.buttons.Count)
				{
					this.menuind = 0;
				}
			}
			else
			{
				this.menuind = Mathf.Clamp(this.menuind, 0, this.buttons.Count - 1);
				while (this.buttons[this.menuind] == this.nextbut || this.buttons[this.menuind] == this.prevbut)
				{
					this.menuind++;
				}
				if (this.menuind >= this.buttons.Count)
				{
					this.menuind = 0;
				}
			}
			if (PhoneInput.IsPressedDown() && this.buttons.Count > this.menuind)
			{
				this.buttons[this.menuind].OnPressed();
			}
		}
	}

	// Token: 0x04000455 RID: 1109
	public PhoneLabel namelabel;

	// Token: 0x04000456 RID: 1110
	public PhoneLabel lvllabel;

	// Token: 0x04000457 RID: 1111
	public PhoneElement texturelabel;

	// Token: 0x04000458 RID: 1112
	public PhoneButton nextbut;

	// Token: 0x04000459 RID: 1113
	public PhoneButton prevbut;

	// Token: 0x0400045A RID: 1114
	public PhoneButton showhidebutton;

	// Token: 0x0400045B RID: 1115
	public int zine_ind;

	// Token: 0x0400045C RID: 1116
	public string nextscreenname;

	// Token: 0x0400045D RID: 1117
	public Texture2D last_zine_tex;
}
