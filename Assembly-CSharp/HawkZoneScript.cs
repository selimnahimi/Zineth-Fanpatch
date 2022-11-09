using System;
using UnityEngine;

// Token: 0x02000019 RID: 25
public class HawkZoneScript : MonoBehaviour
{
	// Token: 0x06000092 RID: 146 RVA: 0x00007254 File Offset: 0x00005454
	private void Awake()
	{
		this.hawkScript = GameObject.Find("Hawk").GetComponent<HawkBehavior>();
	}

	// Token: 0x06000093 RID: 147 RVA: 0x0000726C File Offset: 0x0000546C
	private void OnTriggerStay(Collider other)
	{
		if (other.name == "Player")
		{
			this.hawkScript.active = true;
			this.hawkScript.inBounds = true;
		}
	}

	// Token: 0x06000094 RID: 148 RVA: 0x0000729C File Offset: 0x0000549C
	private void OnTriggerExit(Collider other)
	{
		if (other.name == "Player")
		{
			this.hawkScript.inBounds = false;
		}
	}

	// Token: 0x040000FF RID: 255
	private HawkBehavior hawkScript;
}
