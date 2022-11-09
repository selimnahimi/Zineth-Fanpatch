using System;
using UnityEngine;

// Token: 0x02000006 RID: 6
public class Critter : MonoBehaviour
{
	// Token: 0x0600001A RID: 26 RVA: 0x000027DC File Offset: 0x000009DC
	private void Start()
	{
		if (!this.l_wing)
		{
			this.l_wing = base.transform.FindChild("LWingJoint").transform;
		}
		if (!this.r_wing)
		{
			this.r_wing = base.transform.FindChild("RWingJoint").transform;
		}
		base.Invoke("Flap", 0.1f);
	}

	// Token: 0x0600001B RID: 27 RVA: 0x00002850 File Offset: 0x00000A50
	private void Update()
	{
		base.transform.Rotate(Vector3.up, this.current_turn * Time.deltaTime);
		this.l_wing.localRotation = Quaternion.Lerp(this.l_wing.localRotation, Quaternion.identity, Time.deltaTime * 5f);
		this.r_wing.localRotation = Quaternion.Lerp(this.r_wing.localRotation, Quaternion.identity, Time.deltaTime * 5f);
	}

	// Token: 0x0600001C RID: 28 RVA: 0x000028D0 File Offset: 0x00000AD0
	public void Flap()
	{
		this.current_turn = UnityEngine.Random.Range(-this.turn_amount, this.turn_amount);
		Vector3 force = Vector3.up * this.flap_upforce + Vector3.forward * this.flap_forwardforce;
		base.rigidbody.AddRelativeForce(force);
		Vector3 localEulerAngles = this.l_wing.localEulerAngles;
		localEulerAngles.z = 30f;
		this.l_wing.localEulerAngles = localEulerAngles;
		localEulerAngles = this.r_wing.localEulerAngles;
		localEulerAngles.z = -30f;
		this.r_wing.localEulerAngles = localEulerAngles;
		base.Invoke("Flap", this.flap_time);
	}

	// Token: 0x04000016 RID: 22
	public Transform l_wing;

	// Token: 0x04000017 RID: 23
	public Transform r_wing;

	// Token: 0x04000018 RID: 24
	public float flap_upforce = 1.5f;

	// Token: 0x04000019 RID: 25
	public float flap_forwardforce = 2f;

	// Token: 0x0400001A RID: 26
	public float turn_amount = 360f;

	// Token: 0x0400001B RID: 27
	private float current_turn;

	// Token: 0x0400001C RID: 28
	public float flap_time = 0.25f;
}
