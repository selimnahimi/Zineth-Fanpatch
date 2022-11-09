using System;
using UnityEngine;

// Token: 0x02000009 RID: 9
public class PhoneCloseZoneScript : MonoBehaviour
{
	// Token: 0x06000027 RID: 39 RVA: 0x00002A18 File Offset: 0x00000C18
	private void Start()
	{
		base.renderer.enabled = false;
		this.temp = GameObject.Find("TutObject").GetComponent<PlayerMon>();
	}

	// Token: 0x06000028 RID: 40 RVA: 0x00002A48 File Offset: 0x00000C48
	private void Update()
	{
	}

	// Token: 0x06000029 RID: 41 RVA: 0x00002A4C File Offset: 0x00000C4C
	private void OnTriggerEnter()
	{
		PhoneInterface.view_controller.SetOpen(false);
		this.temp.canMaster = true;
		this.temp.TurnOff();
		this.temp.previous = null;
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x0400001F RID: 31
	private PlayerMon temp;
}
