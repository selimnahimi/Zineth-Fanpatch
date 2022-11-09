using System;
using UnityEngine;

// Token: 0x02000008 RID: 8
public class OpenDoor : MonoBehaviour
{
	// Token: 0x06000023 RID: 35 RVA: 0x000029C8 File Offset: 0x00000BC8
	private void Start()
	{
	}

	// Token: 0x06000024 RID: 36 RVA: 0x000029CC File Offset: 0x00000BCC
	private void Update()
	{
	}

	// Token: 0x06000025 RID: 37 RVA: 0x000029D0 File Offset: 0x00000BD0
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "Player")
		{
			this.door.animation.Play();
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x0400001E RID: 30
	public Transform door;
}
