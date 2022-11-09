using System;
using UnityEngine;

// Token: 0x02000065 RID: 101
public class PhoneElement : MonoBehaviour
{
	// Token: 0x17000092 RID: 146
	// (get) Token: 0x06000435 RID: 1077 RVA: 0x000195B4 File Offset: 0x000177B4
	public new Transform transform
	{
		get
		{
			if (this._transform == null)
			{
				this._transform = base.GetComponent<Transform>();
			}
			return this._transform;
		}
	}

	// Token: 0x17000093 RID: 147
	// (get) Token: 0x06000436 RID: 1078 RVA: 0x000195DC File Offset: 0x000177DC
	public static bool _use_fixed_update
	{
		get
		{
			return PhoneController._use_fixed_update;
		}
	}

	// Token: 0x17000094 RID: 148
	// (get) Token: 0x06000437 RID: 1079 RVA: 0x000195E4 File Offset: 0x000177E4
	public static float deltatime
	{
		get
		{
			return PhoneController.deltatime;
		}
	}

	// Token: 0x06000438 RID: 1080 RVA: 0x000195EC File Offset: 0x000177EC
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x06000439 RID: 1081 RVA: 0x000195F4 File Offset: 0x000177F4
	public virtual void Init()
	{
		this.wantedpos = this.transform.localPosition;
		this.wantedrot = this.transform.localRotation;
		this.wantedscale = this.transform.localScale;
	}

	// Token: 0x0600043A RID: 1082 RVA: 0x00019634 File Offset: 0x00017834
	public virtual void OnLoad()
	{
		if (this.animateOnLoad)
		{
			this.PressPos();
		}
	}

	// Token: 0x0600043B RID: 1083 RVA: 0x00019648 File Offset: 0x00017848
	public virtual void PressPos()
	{
		this.transform.position = PhoneController.presspos + (this.transform.position - this.GetCenter());
	}

	// Token: 0x0600043C RID: 1084 RVA: 0x00019680 File Offset: 0x00017880
	public virtual void RandomPos()
	{
		Vector3 localPosition = this.transform.localPosition;
		float num = UnityEngine.Random.Range(1f, 2f);
		if (UnityEngine.Random.Range(-1f, 1f) > 0f)
		{
			num *= -1f;
		}
		localPosition.x += num;
		num = UnityEngine.Random.Range(1f, 2f);
		if (UnityEngine.Random.Range(-1f, 1f) > 0f)
		{
			num *= -1f;
		}
		localPosition.z += num;
		this.transform.localPosition = localPosition;
	}

	// Token: 0x0600043D RID: 1085 RVA: 0x00019728 File Offset: 0x00017928
	public virtual void OnUpdate()
	{
		if (this.animateOnLoad)
		{
			this.MovetoWanted();
		}
		if (this.changeScale)
		{
			this.ChangeScale();
		}
		this.transform.position += this.velocity * PhoneElement.deltatime;
	}

	// Token: 0x0600043E RID: 1086 RVA: 0x00019780 File Offset: 0x00017980
	public virtual void ChangeScale()
	{
		if (this.wantedscale != this.transform.localScale)
		{
			this.transform.localScale = Vector3.Lerp(this.transform.localScale, this.wantedscale, Time.deltaTime * this.animateRate * 2f);
		}
	}

	// Token: 0x0600043F RID: 1087 RVA: 0x000197DC File Offset: 0x000179DC
	public virtual void MovetoWanted()
	{
		if (this.transform.localPosition != this.wantedpos)
		{
			if (Vector3.Distance(this.transform.localPosition, this.wantedpos) < 0.001f)
			{
				this.transform.localPosition = this.wantedpos;
			}
			else
			{
				this.transform.localPosition = Vector3.Lerp(this.transform.localPosition, this.wantedpos, PhoneElement.deltatime * this.animateRate);
			}
		}
		if (this.transform.localRotation != this.wantedrot)
		{
			if (Quaternion.Angle(this.transform.localRotation, this.wantedrot) < 0.001f)
			{
				this.transform.localRotation = this.wantedrot;
			}
			else
			{
				this.transform.localRotation = Quaternion.Slerp(this.transform.localRotation, this.wantedrot, PhoneElement.deltatime * this.animateRate);
			}
		}
	}

	// Token: 0x06000440 RID: 1088 RVA: 0x000198E8 File Offset: 0x00017AE8
	public virtual Vector3 GetCenter()
	{
		TextMesh component = base.GetComponent<TextMesh>();
		if (component)
		{
			return component.renderer.bounds.center;
		}
		return this.transform.position;
	}

	// Token: 0x04000354 RID: 852
	public Vector3 wantedpos;

	// Token: 0x04000355 RID: 853
	public Quaternion wantedrot;

	// Token: 0x04000356 RID: 854
	public Vector3 wantedscale;

	// Token: 0x04000357 RID: 855
	public bool animateOnLoad;

	// Token: 0x04000358 RID: 856
	public Vector3 velocity = Vector3.zero;

	// Token: 0x04000359 RID: 857
	public float animateRate = 5f;

	// Token: 0x0400035A RID: 858
	public bool changeScale;

	// Token: 0x0400035B RID: 859
	private Transform _transform;
}
