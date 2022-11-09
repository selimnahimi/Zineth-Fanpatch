using System;
using UnityEngine;

// Token: 0x02000050 RID: 80
public class PhoneColorPallete
{
	// Token: 0x0600034E RID: 846 RVA: 0x00014D58 File Offset: 0x00012F58
	public PhoneColorPallete()
	{
	}

	// Token: 0x0600034F RID: 847 RVA: 0x00014D80 File Offset: 0x00012F80
	public PhoneColorPallete(Color _text, Color _selected, Color _selectable, Color _back)
	{
		this.text = _text;
		this.selected = _selected;
		this.selectable = _selectable;
		this.back = _back;
		this.particles = this.selected;
	}

	// Token: 0x06000350 RID: 848 RVA: 0x00014DDC File Offset: 0x00012FDC
	public PhoneColorPallete(Color _text, Color _selected, Color _selectable, Color _back, Color _particles)
	{
		this.text = _text;
		this.selected = _selected;
		this.selectable = _selectable;
		this.back = _back;
		this.particles = _particles;
	}

	// Token: 0x040002D1 RID: 721
	public Color back;

	// Token: 0x040002D2 RID: 722
	public Color text;

	// Token: 0x040002D3 RID: 723
	public Color selectable;

	// Token: 0x040002D4 RID: 724
	public Color selected;

	// Token: 0x040002D5 RID: 725
	public Color particles = new Color(0f, 0f, 0f, 0f);
}
