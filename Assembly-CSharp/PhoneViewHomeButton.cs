using System;
using UnityEngine;

// Token: 0x02000088 RID: 136
public class PhoneViewHomeButton : MonoBehaviour
{
	// Token: 0x060005C0 RID: 1472 RVA: 0x00024E4C File Offset: 0x0002304C
	private void Start()
	{
		if (this.phoneviewcontroller == null)
		{
			this.phoneviewcontroller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneViewController)) as PhoneViewController);
		}
		base.renderer.material.color = this.normalcolor;
		if (this.icon == null && base.transform.GetChildCount() > 0)
		{
			this.icon = base.transform.GetChild(0);
		}
		if (this.icon)
		{
			this.iconscale = this.icon.localScale;
		}
	}

	// Token: 0x060005C1 RID: 1473 RVA: 0x00024EF0 File Offset: 0x000230F0
	private void Update()
	{
		if (Input.GetButtonDown("CellHome"))
		{
			if (this.icon)
			{
				this.icon.localScale = this.iconscale * 0.25f;
			}
			this.dOnMouseEnter();
		}
		if (Input.GetButtonUp("CellHome"))
		{
			this.dOnMouseExit();
		}
		Ray ray = this.cam.ScreenPointToRay(Input.mousePosition);
		RaycastHit raycastHit;
		if (base.collider.Raycast(ray, out raycastHit, 100f))
		{
			if (!this.mouseon)
			{
				this.dOnMouseEnter();
			}
			if (Input.GetButtonDown("CellClick"))
			{
				this.dOnMouseDown();
			}
			this.mouseon = true;
		}
		else
		{
			if (this.mouseon)
			{
				this.dOnMouseExit();
			}
			this.mouseon = false;
		}
		if (this.icon && this.icon.localScale != this.iconscale)
		{
			this.icon.localScale = Vector3.Slerp(this.icon.localScale, this.iconscale, Time.deltaTime * 10f);
		}
	}

	// Token: 0x170000BF RID: 191
	// (get) Token: 0x060005C2 RID: 1474 RVA: 0x0002501C File Offset: 0x0002321C
	public bool can_use
	{
		get
		{
			return PhoneController.instance.allow_home;
		}
	}

	// Token: 0x060005C3 RID: 1475 RVA: 0x00025028 File Offset: 0x00023228
	private void dOnMouseDown()
	{
		if (this.can_use)
		{
			if (this.icon)
			{
				this.icon.localScale = this.iconscale * 0.25f;
			}
			this.phoneviewcontroller.OnHomeButton();
		}
	}

	// Token: 0x060005C4 RID: 1476 RVA: 0x00025078 File Offset: 0x00023278
	private void dOnMouseEnter()
	{
		if (this.can_use)
		{
			base.renderer.material.color = this.hovercolor;
		}
		else
		{
			base.renderer.material.color = Color.red;
		}
	}

	// Token: 0x060005C5 RID: 1477 RVA: 0x000250C0 File Offset: 0x000232C0
	private void dOnMouseExit()
	{
		base.renderer.material.color = this.normalcolor;
	}

	// Token: 0x04000473 RID: 1139
	public Camera cam;

	// Token: 0x04000474 RID: 1140
	public Color normalcolor = Color.gray;

	// Token: 0x04000475 RID: 1141
	public Color hovercolor = Color.white;

	// Token: 0x04000476 RID: 1142
	public PhoneViewController phoneviewcontroller;

	// Token: 0x04000477 RID: 1143
	private bool mouseon;

	// Token: 0x04000478 RID: 1144
	private Transform icon;

	// Token: 0x04000479 RID: 1145
	private Vector3 iconscale;
}
