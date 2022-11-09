using System;
using System.Collections;
using UnityEngine;

// Token: 0x02000007 RID: 7
public class EndLevel : MonoBehaviour
{
	// Token: 0x0600001E RID: 30 RVA: 0x00002988 File Offset: 0x00000B88
	private void Start()
	{
	}

	// Token: 0x0600001F RID: 31 RVA: 0x0000298C File Offset: 0x00000B8C
	private void Update()
	{
	}

	// Token: 0x06000020 RID: 32 RVA: 0x00002990 File Offset: 0x00000B90
	private IEnumerator Go()
	{
		yield return new WaitForSeconds(2f);
		Application.LoadLevel("Loader 1");
		yield break;
	}

	// Token: 0x06000021 RID: 33 RVA: 0x000029A4 File Offset: 0x00000BA4
	private IEnumerator OnTriggerEnter(Collider other)
	{
		GameObject.Find("Camera Holder").GetComponent<NewCamera>().pauseCamera = true;
		GameObject.Find("Player").GetComponent<move>().freezeControls = true;
		this.door.animation.Play();
		yield return base.StartCoroutine("Go");
		yield break;
	}

	// Token: 0x0400001D RID: 29
	public Transform door;
}
