using System;
using UnityEngine;

// Token: 0x020000A3 RID: 163
public class CameraFacingBillboard : MonoBehaviour
{
	// Token: 0x060006CF RID: 1743 RVA: 0x0002C18C File Offset: 0x0002A38C
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x060006D0 RID: 1744 RVA: 0x0002C194 File Offset: 0x0002A394
	private void Start()
	{
		if (this.autoInit && !this.amActive)
		{
			this.Init();
		}
	}

	// Token: 0x060006D1 RID: 1745 RVA: 0x0002C1B4 File Offset: 0x0002A3B4
	private void Init()
	{
		if (this.autoInit)
		{
			this.m_Camera = Camera.mainCamera;
			this.amActive = true;
		}
		if (this.myContainer == null)
		{
			this.myContainer = new GameObject();
			this.myContainer.name = "GRP_" + base.transform.gameObject.name;
			this.myContainer.transform.position = base.transform.position;
			this.myContainer.transform.parent = base.transform.parent;
		}
		base.transform.parent = this.myContainer.transform;
		Vector3 localEulerAngles = base.transform.localEulerAngles;
		localEulerAngles.y = 0f;
		base.transform.localEulerAngles = localEulerAngles;
	}

	// Token: 0x060006D2 RID: 1746 RVA: 0x0002C290 File Offset: 0x0002A490
	private void Update()
	{
		if (this.m_Camera == null)
		{
			this.m_Camera = Camera.mainCamera;
		}
		if (this.amActive)
		{
			this.myContainer.transform.LookAt(this.myContainer.transform.position + this.m_Camera.transform.rotation * Vector3.back, this.m_Camera.transform.rotation * Vector3.up);
		}
	}

	// Token: 0x060006D3 RID: 1747 RVA: 0x0002C320 File Offset: 0x0002A520
	private void OnDisable()
	{
		if (base.gameObject.active)
		{
			UnityEngine.Object.Destroy(this.myContainer);
		}
	}

	// Token: 0x040005AB RID: 1451
	public Camera m_Camera;

	// Token: 0x040005AC RID: 1452
	public bool amActive;

	// Token: 0x040005AD RID: 1453
	public bool autoInit = true;

	// Token: 0x040005AE RID: 1454
	public GameObject myContainer;

	// Token: 0x040005AF RID: 1455
	public Vector3 offset;
}
