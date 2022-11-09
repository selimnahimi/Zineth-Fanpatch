using System;
using UnityEngine;

// Token: 0x02000074 RID: 116
public class PhoneMenuLine : MonoBehaviour
{
	// Token: 0x060004C8 RID: 1224 RVA: 0x0001DF48 File Offset: 0x0001C148
	private void Awake()
	{
		base.renderer.enabled = false;
		if (!this.drawer)
		{
			this.drawer = base.transform.GetChild(0).transform;
		}
		if (base.name.EndsWith("U"))
		{
			this.dir = PhoneMenuLine.ButtonDirection.up;
		}
		if (base.name.EndsWith("D"))
		{
			this.dir = PhoneMenuLine.ButtonDirection.down;
		}
		if (base.name.EndsWith("L"))
		{
			this.dir = PhoneMenuLine.ButtonDirection.left;
		}
		if (base.name.EndsWith("R"))
		{
			this.dir = PhoneMenuLine.ButtonDirection.right;
		}
	}

	// Token: 0x060004C9 RID: 1225 RVA: 0x0001DFF8 File Offset: 0x0001C1F8
	private void Update()
	{
		if (PhoneInput.controltype != PhoneInput.ControlType.Keyboard && (!this.start || !this.start.force_mouse_menulines))
		{
			this.drawer.renderer.enabled = false;
		}
		else
		{
			this.DoPositions();
		}
	}

	// Token: 0x060004CA RID: 1226 RVA: 0x0001E04C File Offset: 0x0001C24C
	private void DoPositions()
	{
		if (this.start && this.end)
		{
			this.drawer.renderer.enabled = true;
			Vector3 pos = this.GetPos();
			if (base.transform.position != pos)
			{
				base.transform.position = pos;
			}
		}
		else
		{
			this.drawer.renderer.enabled = false;
		}
	}

	// Token: 0x060004CB RID: 1227 RVA: 0x0001E0CC File Offset: 0x0001C2CC
	private Vector3 GetPos()
	{
		Vector3 direction = this.GetDirection(this.dir);
		Bounds bounds = this.start.GetBounds();
		Vector3 a = Vector3.zero;
		for (int i = 0; i < 3; i++)
		{
			a[i] = direction[i] * bounds.size[i] / 2f;
		}
		a += direction * this.offset;
		a += bounds.center;
		return a + base.transform.up * 1f;
	}

	// Token: 0x060004CC RID: 1228 RVA: 0x0001E170 File Offset: 0x0001C370
	private Vector3 GetDirection(PhoneMenuLine.ButtonDirection direction)
	{
		if (direction == PhoneMenuLine.ButtonDirection.up)
		{
			return base.transform.parent.forward;
		}
		if (direction == PhoneMenuLine.ButtonDirection.down)
		{
			return -base.transform.parent.forward;
		}
		if (direction == PhoneMenuLine.ButtonDirection.left)
		{
			return -base.transform.parent.right;
		}
		if (direction == PhoneMenuLine.ButtonDirection.right)
		{
			return base.transform.parent.right;
		}
		return Vector3.zero;
	}

	// Token: 0x040003C2 RID: 962
	public LineRenderer liner;

	// Token: 0x040003C3 RID: 963
	public PhoneButton start;

	// Token: 0x040003C4 RID: 964
	public PhoneButton end;

	// Token: 0x040003C5 RID: 965
	private PhoneMenuLine.ButtonDirection dir;

	// Token: 0x040003C6 RID: 966
	public Transform drawer;

	// Token: 0x040003C7 RID: 967
	private float offset = 0.1f;

	// Token: 0x02000075 RID: 117
	private enum ButtonDirection
	{
		// Token: 0x040003C9 RID: 969
		up,
		// Token: 0x040003CA RID: 970
		down,
		// Token: 0x040003CB RID: 971
		left,
		// Token: 0x040003CC RID: 972
		right
	}
}
