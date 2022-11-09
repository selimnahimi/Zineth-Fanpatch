using System;
using UnityEngine;

// Token: 0x02000015 RID: 21
public class DoSandParticles : MonoBehaviour
{
	// Token: 0x06000067 RID: 103 RVA: 0x00004E70 File Offset: 0x00003070
	private void Start()
	{
		this.lastpos = base.transform.position;
		if (!this.part_sys)
		{
			this.part_sys = base.gameObject.GetComponent<ParticleSystem>();
		}
	}

	// Token: 0x06000068 RID: 104 RVA: 0x00004EB0 File Offset: 0x000030B0
	private void FixedUpdate()
	{
		if (this.net_mode)
		{
			if (base.transform.position != this.lastpos)
			{
				this.DoUpdate(Time.fixedTime - this.lastTime);
				this.lastTime = Time.fixedTime;
			}
		}
		else
		{
			this.DoUpdate(Time.fixedDeltaTime);
		}
	}

	// Token: 0x06000069 RID: 105 RVA: 0x00004F10 File Offset: 0x00003110
	private void DoUpdate(float timelapse)
	{
		bool flag = false;
		bool flag2 = false;
		float num = (base.transform.position - this.lastpos).magnitude / timelapse;
		float f = (base.transform.position - this.lastpos).y / timelapse;
		if (this.part_sys.enableEmission)
		{
			if (num >= this.stop_cutoff || Mathf.Abs(f) >= this.downspeed_cutoff)
			{
				flag = true;
			}
		}
		else if (num >= this.start_cutoff || Mathf.Abs(f) >= this.downspeed_cutoff)
		{
			flag = true;
		}
		Vector3 origin = base.transform.parent.position + base.transform.parent.up * 10f;
		RaycastHit raycastHit;
		if (Physics.Raycast(origin, -base.transform.parent.up, out raycastHit, this.min_height + 10f) && (raycastHit.collider.name == "Terrain" || raycastHit.collider.tag == "Terrain"))
		{
			flag2 = true;
			base.transform.position = raycastHit.point;
		}
		if (flag && flag2)
		{
			this.EnableParticles();
		}
		else
		{
			this.DisableParticles();
		}
		this.lastpos = base.transform.position;
	}

	// Token: 0x0600006A RID: 106 RVA: 0x00005090 File Offset: 0x00003290
	private void EnableParticles()
	{
		if (!this.part_sys.enableEmission)
		{
			this.part_sys.enableEmission = true;
			this.part_sys.Play();
		}
	}

	// Token: 0x0600006B RID: 107 RVA: 0x000050BC File Offset: 0x000032BC
	private void DisableParticles()
	{
		if (this.part_sys.enableEmission)
		{
			this.part_sys.enableEmission = false;
			this.part_sys.Stop();
		}
	}

	// Token: 0x04000097 RID: 151
	private Vector3 lastpos;

	// Token: 0x04000098 RID: 152
	public bool net_mode;

	// Token: 0x04000099 RID: 153
	public ParticleSystem part_sys;

	// Token: 0x0400009A RID: 154
	public float start_cutoff = 20f;

	// Token: 0x0400009B RID: 155
	public float stop_cutoff = 15f;

	// Token: 0x0400009C RID: 156
	public float downspeed_cutoff = 15f;

	// Token: 0x0400009D RID: 157
	public float min_height = 10f;

	// Token: 0x0400009E RID: 158
	private bool last_grounded;

	// Token: 0x0400009F RID: 159
	private float lastTime;
}
