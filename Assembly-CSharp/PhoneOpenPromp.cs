using System;
using UnityEngine;

// Token: 0x0200008B RID: 139
public class PhoneOpenPromp : MonoBehaviour
{
	// Token: 0x060005E9 RID: 1513 RVA: 0x00026628 File Offset: 0x00024828
	private void Start()
	{
		this.guitext = base.GetComponent<GUIText>();
		if (this.guitext)
		{
			this.guitext.material.color = this.color;
		}
		this.textmesh = base.GetComponent<TextMesh>();
		if (this.textmesh)
		{
			this.textmesh.renderer.material.color = this.color;
		}
	}

	// Token: 0x060005EA RID: 1514 RVA: 0x000266A0 File Offset: 0x000248A0
	private void Update()
	{
		if (this.animate_color && this.textmesh)
		{
			this.textmesh.renderer.material.color = Color.Lerp(Color.white, Color.red, Mathf.PingPong(Time.time * 3f, 0.5f));
		}
		if (PhoneController.powerstate == PhoneController.PowerState.open)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x040004A4 RID: 1188
	private GUIText guitext;

	// Token: 0x040004A5 RID: 1189
	private TextMesh textmesh;

	// Token: 0x040004A6 RID: 1190
	public Color color = Color.black;

	// Token: 0x040004A7 RID: 1191
	public bool animate_color;
}
