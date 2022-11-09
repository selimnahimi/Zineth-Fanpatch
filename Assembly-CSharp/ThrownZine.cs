using System;
using UnityEngine;

// Token: 0x0200002B RID: 43
public class ThrownZine : MonoBehaviour
{
	// Token: 0x0600012E RID: 302 RVA: 0x000095E0 File Offset: 0x000077E0
	public void Init(Vector3 pos)
	{
		base.transform.LookAt(Camera.main.transform);
		base.rigidbody.velocity = pos;
		UnityEngine.Object.Destroy(base.gameObject, this.kill_timer);
		Vector3 vector = Vector3.up;
		Vector2 insideUnitCircle = UnityEngine.Random.insideUnitCircle;
		vector.x += insideUnitCircle.x;
		vector.z += insideUnitCircle.y;
		vector = vector.normalized * 2f;
		base.transform.position += vector;
		base.rigidbody.velocity += vector * this.speed;
		base.rigidbody.AddRelativeTorque(UnityEngine.Random.onUnitSphere * this.rot_force, ForceMode.Force);
	}

	// Token: 0x0400017E RID: 382
	public float speed = 20f;

	// Token: 0x0400017F RID: 383
	public float min_dist = 10f;

	// Token: 0x04000180 RID: 384
	public float kill_timer = 5f;

	// Token: 0x04000181 RID: 385
	public float rot_force = 20f;
}
