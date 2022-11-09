using System;
using UnityEngine;

// Token: 0x02000089 RID: 137
public class PhoneViewOpenButton : MonoBehaviour
{
	// Token: 0x060005C7 RID: 1479 RVA: 0x00025104 File Offset: 0x00023304
	private void Start()
	{
		if (this.phoneviewcontroller == null)
		{
			this.phoneviewcontroller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneViewController)) as PhoneViewController);
		}
		base.renderer.material.color = this.normalcolor;
		this.wantedColor = this.normalcolor;
		if (this.icon == null && base.transform.childCount > 0)
		{
			this.icon = base.transform.GetChild(0);
		}
		if (this.icon)
		{
			this.iconscale = this.icon.localScale;
		}
	}

	// Token: 0x060005C8 RID: 1480 RVA: 0x000251B4 File Offset: 0x000233B4
	private void Update()
	{
		if (Input.GetButtonDown("CellOpen"))
		{
			this.dOnMouseEnter();
		}
		if (Input.GetButtonUp("CellOpen"))
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
		if (this.icon)
		{
			Vector3 vector = Vector3.up * 180f;
			if (this.phoneviewcontroller.open)
			{
				vector = Vector3.zero;
			}
			if (this.icon.transform.localEulerAngles != vector)
			{
				this.icon.transform.localEulerAngles = Vector3.Slerp(this.icon.transform.localEulerAngles, vector, 1f);
			}
		}
		if (this.guitext)
		{
			if (!this.mouseon)
			{
				base.renderer.material.color = Color.Lerp(Color.white, Color.red, Mathf.PingPong(Time.time * 3f, 0.5f));
			}
			else
			{
				base.renderer.material.color = Color.red;
			}
			this.guitext.renderer.material.color = base.renderer.material.color;
			if (this.phoneviewcontroller.open)
			{
				UnityEngine.Object.Destroy(this.guitext.gameObject);
			}
		}
		else if (base.renderer.material.color != this.wantedColor)
		{
			base.renderer.material.color = this.wantedColor;
		}
	}

	// Token: 0x170000C0 RID: 192
	// (get) Token: 0x060005C9 RID: 1481 RVA: 0x000253C4 File Offset: 0x000235C4
	public bool can_use
	{
		get
		{
			if (PhoneController.powerstate == PhoneController.PowerState.open)
			{
				return PhoneController.instance.allow_close;
			}
			return PhoneController.instance.allow_open;
		}
	}

	// Token: 0x060005CA RID: 1482 RVA: 0x000253F4 File Offset: 0x000235F4
	private void dOnMouseDown()
	{
		if (this.can_use)
		{
			this.phoneviewcontroller.SetOpen(!this.phoneviewcontroller.open);
		}
	}

	// Token: 0x060005CB RID: 1483 RVA: 0x00025428 File Offset: 0x00023628
	private void dOnMouseEnter()
	{
		if (this.can_use)
		{
			this.wantedColor = this.hovercolor;
		}
		else
		{
			this.wantedColor = Color.red;
		}
	}

	// Token: 0x060005CC RID: 1484 RVA: 0x00025454 File Offset: 0x00023654
	private void dOnMouseExit()
	{
		this.wantedColor = this.normalcolor;
	}

	// Token: 0x0400047A RID: 1146
	public Camera cam;

	// Token: 0x0400047B RID: 1147
	public Color normalcolor = Color.gray;

	// Token: 0x0400047C RID: 1148
	public Color hovercolor = Color.white;

	// Token: 0x0400047D RID: 1149
	public PhoneViewController phoneviewcontroller;

	// Token: 0x0400047E RID: 1150
	private bool mouseon;

	// Token: 0x0400047F RID: 1151
	public Transform icon;

	// Token: 0x04000480 RID: 1152
	private Vector3 iconscale;

	// Token: 0x04000481 RID: 1153
	private bool guitext_set;

	// Token: 0x04000482 RID: 1154
	public TextMesh guitext;

	// Token: 0x04000483 RID: 1155
	public Color wantedColor = Color.gray;
}
