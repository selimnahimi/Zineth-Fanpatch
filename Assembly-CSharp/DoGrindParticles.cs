using System;
using UnityEngine;

// Token: 0x02000014 RID: 20
public class DoGrindParticles : MonoBehaviour
{
	// Token: 0x06000064 RID: 100 RVA: 0x00004D48 File Offset: 0x00002F48
	private void Start()
	{
		if (this.grind_ref == null)
		{
			this.grind_ref = (UnityEngine.Object.FindObjectOfType(typeof(SplineGrinding)) as SplineGrinding);
		}
		if (this.grind_part_l == null)
		{
			this.grind_part_l = base.particleSystem;
		}
	}

	// Token: 0x06000065 RID: 101 RVA: 0x00004DA0 File Offset: 0x00002FA0
	private void Update()
	{
		if (this.grind_ref.isGrinding)
		{
			if (this.grind_part_l && !this.grind_part_l.enableEmission)
			{
				this.grind_part_l.enableEmission = true;
				this.grind_part_l.Play();
			}
		}
		else if (this.grind_part_l && this.grind_part_l.enableEmission)
		{
			this.grind_part_l.enableEmission = false;
			this.grind_part_l.Stop();
		}
	}

	// Token: 0x04000095 RID: 149
	public SplineGrinding grind_ref;

	// Token: 0x04000096 RID: 150
	public ParticleSystem grind_part_l;
}
