using System;
using UnityEngine;

// Token: 0x02000099 RID: 153
public class CactusBehavior : MonoBehaviour
{
	// Token: 0x06000698 RID: 1688 RVA: 0x0002A224 File Offset: 0x00028424
	private void Awake()
	{
		float num = UnityEngine.Random.Range(0f, 0.1f);
		base.transform.rotation = Quaternion.Euler(0f, (float)UnityEngine.Random.Range(0, 360), 0f);
		base.transform.localScale += new Vector3(num, num, num);
	}

	// Token: 0x06000699 RID: 1689 RVA: 0x0002A288 File Offset: 0x00028488
	private void FixedUpdate()
	{
		if (this.hasCollided)
		{
			this.IncreaseGravity();
			this.destroyTimer--;
			if (this.destroyTimer <= 0)
			{
				this.DestroySelf();
			}
		}
		else
		{
			if (this.offscreenTimer <= 0)
			{
				this.DestroySelf();
			}
			if (!base.transform.GetChild(0).renderer.isVisible)
			{
				this.offscreenTimer--;
			}
			else if (this.mirage)
			{
				base.transform.LookAt(Camera.main.transform.position);
				base.transform.Rotate(Vector3.up * -90f);
				float num = Vector3.Distance(base.transform.position, Camera.main.transform.position);
				float num2 = (num - 300f) / 1000f;
				if (num2 >= 0.5f)
				{
					num2 = 1f;
				}
				foreach (Renderer renderer in this.mirageRenderers)
				{
					float a = Mathf.Clamp01(num2 * UnityEngine.Random.Range(0.9f, 1.1f));
					Color color = renderer.material.color;
					color.a = a;
					renderer.material.color = color;
				}
				if (num2 <= 0f)
				{
					this.mirageTimer -= 1f;
					if (this.mirageTimer <= 0f)
					{
						UnityEngine.Object.Destroy(base.gameObject);
					}
				}
			}
		}
	}

	// Token: 0x0600069A RID: 1690 RVA: 0x0002A420 File Offset: 0x00028620
	private void OnTriggerEnter(Collider collider)
	{
		if (!this.hasCollided && collider.name == "Player")
		{
			CactusBehavior.cactusBreaks++;
			CactusBehavior.recentCactusBreaks++;
			this.hasCollided = true;
			this.ApplyForces(collider);
		}
	}

	// Token: 0x0600069B RID: 1691 RVA: 0x0002A474 File Offset: 0x00028674
	private void OnCollisionEnter(Collision collision)
	{
		if (!this.hasCollided && collision.collider.name == "Player")
		{
			this.hasCollided = true;
			this.ApplyForces(collision.collider);
		}
	}

	// Token: 0x0600069C RID: 1692 RVA: 0x0002A4BC File Offset: 0x000286BC
	private void ApplyForces(Collider collider)
	{
		if (this.breakSound)
		{
			AudioSource.PlayClipAtPoint(this.breakSound, Camera.main.transform.position);
		}
		if (this.mirage)
		{
			UnityEngine.Object.Destroy(base.gameObject);
			return;
		}
		XInput.AddVibrateForce(0.5f, 0.1f, 0.1f, false);
		foreach (object obj in base.transform)
		{
			Transform transform = (Transform)obj;
			float num = UnityEngine.Random.Range(this.minForce, this.maxForce);
			num /= 15f;
			transform.gameObject.AddComponent<Rigidbody>();
			transform.gameObject.AddComponent<CapsuleCollider>();
			Rigidbody component = transform.gameObject.GetComponent<Rigidbody>();
			component.drag = this.drag;
			component.angularDrag = this.angularDrag;
			component.mass = this.mass;
			component.velocity = collider.transform.rigidbody.velocity;
			component.AddForce(collider.transform.up * num);
			component.AddForce(collider.transform.right * UnityEngine.Random.Range(-this.maxForce, this.maxForce) / 15f);
			component.AddTorque((float)UnityEngine.Random.Range(0, 360), (float)UnityEngine.Random.Range(0, 360), (float)UnityEngine.Random.Range(0, 360) * this.torqueForce);
		}
	}

	// Token: 0x0600069D RID: 1693 RVA: 0x0002A670 File Offset: 0x00028870
	private void IncreaseGravity()
	{
		foreach (object obj in base.transform)
		{
			Transform transform = (Transform)obj;
			Rigidbody component = transform.gameObject.GetComponent<Rigidbody>();
			component.AddForce(Physics.gravity * 8f * component.mass);
		}
	}

	// Token: 0x0600069E RID: 1694 RVA: 0x0002A704 File Offset: 0x00028904
	private void DestroySelf()
	{
		UnityEngine.Object.Destroy(base.transform.gameObject);
		CactusPlacer.instance.currentNum--;
	}

	// Token: 0x0600069F RID: 1695 RVA: 0x0002A734 File Offset: 0x00028934
	private void LateUpdate()
	{
		CactusBehavior.recentCactusBreaks = 0;
	}

	// Token: 0x0400053E RID: 1342
	public static int cactusBreaks;

	// Token: 0x0400053F RID: 1343
	public static int recentCactusBreaks;

	// Token: 0x04000540 RID: 1344
	public float minForce = 10f;

	// Token: 0x04000541 RID: 1345
	public float maxForce = 20f;

	// Token: 0x04000542 RID: 1346
	public float torqueForce = 2f;

	// Token: 0x04000543 RID: 1347
	private bool hasCollided;

	// Token: 0x04000544 RID: 1348
	private int destroyTimer = 1000;

	// Token: 0x04000545 RID: 1349
	private int offscreenTimer = 800;

	// Token: 0x04000546 RID: 1350
	public AudioClip breakSound;

	// Token: 0x04000547 RID: 1351
	public bool mirage;

	// Token: 0x04000548 RID: 1352
	private float mirageTimer = 60f;

	// Token: 0x04000549 RID: 1353
	public Renderer[] mirageRenderers;

	// Token: 0x0400054A RID: 1354
	public float drag = 2f;

	// Token: 0x0400054B RID: 1355
	public float angularDrag = 2f;

	// Token: 0x0400054C RID: 1356
	public float mass = 0.001f;
}
