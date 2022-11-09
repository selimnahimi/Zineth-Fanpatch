using System;
using UnityEngine;

// Token: 0x0200000C RID: 12
public class norewind : MonoBehaviour
{
	// Token: 0x0600003E RID: 62 RVA: 0x000039C8 File Offset: 0x00001BC8
	private void Start()
	{
		this.player = GameObject.Find("TutObject").GetComponent<PlayerMon>();
		base.renderer.enabled = false;
	}

	// Token: 0x0600003F RID: 63 RVA: 0x000039EC File Offset: 0x00001BEC
	private void Update()
	{
	}

	// Token: 0x06000040 RID: 64 RVA: 0x000039F0 File Offset: 0x00001BF0
	private void OnTriggerEnter(Collider collider)
	{
		this.player.ignore = true;
	}

	// Token: 0x06000041 RID: 65 RVA: 0x00003A00 File Offset: 0x00001C00
	private void OnTriggerExit(Collider collider)
	{
		this.player.ignore = false;
	}

	// Token: 0x04000048 RID: 72
	private PlayerMon player;
}
