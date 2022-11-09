using System;
using UnityEngine;

// Token: 0x0200004A RID: 74
public class PhoneEffects : MonoBehaviour
{
	// Token: 0x17000050 RID: 80
	// (get) Token: 0x060002BA RID: 698 RVA: 0x000122DC File Offset: 0x000104DC
	private static PhoneEffects instance
	{
		get
		{
			if (PhoneEffects._instance == null)
			{
				PhoneEffects._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneEffects)) as PhoneEffects);
			}
			return PhoneEffects._instance;
		}
	}

	// Token: 0x060002BB RID: 699 RVA: 0x00012318 File Offset: 0x00010518
	public static void AddCamShake(float amount)
	{
		PhoneEffects.instance.AddShake(amount);
	}

	// Token: 0x060002BC RID: 700 RVA: 0x00012328 File Offset: 0x00010528
	private void Awake()
	{
		this.camlocalpos = this.phonecam.transform.localPosition;
	}

	// Token: 0x060002BD RID: 701 RVA: 0x00012340 File Offset: 0x00010540
	private void Start()
	{
	}

	// Token: 0x060002BE RID: 702 RVA: 0x00012344 File Offset: 0x00010544
	private void FixedUpdate()
	{
		this.DoShaking();
	}

	// Token: 0x060002BF RID: 703 RVA: 0x0001234C File Offset: 0x0001054C
	public void AddShake(float amount)
	{
		this.shakeamount += amount;
	}

	// Token: 0x060002C0 RID: 704 RVA: 0x0001235C File Offset: 0x0001055C
	public void DoShaking()
	{
		if (this.shakeamount <= 0f)
		{
			return;
		}
		float num = this.shakeamount * 0.2f;
		Vector3 b = new Vector3(UnityEngine.Random.Range(-num, num), 0f, UnityEngine.Random.Range(-num, num));
		this.phonecam.transform.localPosition = this.camlocalpos + b;
		this.shakeamount = Mathf.Lerp(this.shakeamount, 0f, Time.fixedDeltaTime * 3f);
		if (this.shakeamount <= 0f)
		{
			this.phonecam.transform.localPosition = this.camlocalpos;
		}
	}

	// Token: 0x04000291 RID: 657
	private static PhoneEffects _instance;

	// Token: 0x04000292 RID: 658
	public Camera phonecam;

	// Token: 0x04000293 RID: 659
	public Vector3 camlocalpos;

	// Token: 0x04000294 RID: 660
	private float shakeamount;
}
