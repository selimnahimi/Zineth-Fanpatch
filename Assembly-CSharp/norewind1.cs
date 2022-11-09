using System;
using UnityEngine;

// Token: 0x0200000D RID: 13
public class norewind1 : MonoBehaviour
{
	// Token: 0x06000043 RID: 67 RVA: 0x00003A18 File Offset: 0x00001C18
	private void Start()
	{
		this.player = GameObject.Find("TutObject").GetComponent<PlayerMon>();
		base.renderer.enabled = false;
	}

	// Token: 0x06000044 RID: 68 RVA: 0x00003A3C File Offset: 0x00001C3C
	private void Update()
	{
	}

	// Token: 0x06000045 RID: 69 RVA: 0x00003A40 File Offset: 0x00001C40
	private void OnTriggerEnter(Collider collider)
	{
		this.player.wallCheck = true;
	}

	// Token: 0x06000046 RID: 70 RVA: 0x00003A50 File Offset: 0x00001C50
	private void OnTriggerExit(Collider collider)
	{
		this.player.wallCheck = false;
	}

	// Token: 0x04000049 RID: 73
	private PlayerMon player;
}
