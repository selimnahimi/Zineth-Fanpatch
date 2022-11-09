using System;
using UnityEngine;

// Token: 0x0200008C RID: 140
public class TextureResizer : MonoBehaviour
{
	// Token: 0x060005EC RID: 1516 RVA: 0x00026738 File Offset: 0x00024938
	private void Start()
	{
		if (!this.rend)
		{
			this.rend = base.renderer;
		}
		this.trans = this.rend.transform;
		if (!this.parbutton)
		{
			this.parbutton = this.trans.parent.GetComponent<PhoneButton>();
		}
	}

	// Token: 0x060005ED RID: 1517 RVA: 0x00026798 File Offset: 0x00024998
	private void Update()
	{
		if (this.rend.enabled)
		{
			if (this.tex == null || this.rend.material.mainTexture != this.tex)
			{
				this.done = false;
			}
			if (!this.done)
			{
				this.Check();
			}
		}
		else
		{
			this.done = false;
		}
	}

	// Token: 0x060005EE RID: 1518 RVA: 0x0002680C File Offset: 0x00024A0C
	public void ResizeSoon()
	{
	}

	// Token: 0x060005EF RID: 1519 RVA: 0x00026810 File Offset: 0x00024A10
	public void Check()
	{
		this.tex = this.rend.material.mainTexture;
		if (this.rend.material.mainTexture != null && (!this.parbutton || this.parbutton.wantedscale == this.parbutton.transform.localScale) && PhoneTweetButton.finished_dl_dict.ContainsKey(this.tex) && PhoneTweetButton.finished_dl_dict[this.tex])
		{
			this.Resize();
		}
	}

	// Token: 0x060005F0 RID: 1520 RVA: 0x000268B4 File Offset: 0x00024AB4
	public void Resize()
	{
		if (this.rend.material.mainTexture != null)
		{
			float x = (float)this.tex.width;
			float y = (float)this.tex.height;
			Vector2 a = new Vector2(x, y);
			a = a.normalized;
			a *= this.scale;
			Transform parent = this.trans.parent;
			this.trans.parent = null;
			this.trans.localScale = new Vector3(a.x, 1f, a.y);
			this.trans.parent = parent;
			this.done = true;
		}
	}

	// Token: 0x040004A8 RID: 1192
	public Renderer rend;

	// Token: 0x040004A9 RID: 1193
	private Texture tex;

	// Token: 0x040004AA RID: 1194
	private Transform trans;

	// Token: 0x040004AB RID: 1195
	public float scale = 1f;

	// Token: 0x040004AC RID: 1196
	public Vector2 max_size = Vector2.one;

	// Token: 0x040004AD RID: 1197
	public bool done;

	// Token: 0x040004AE RID: 1198
	public PhoneButton parbutton;
}
