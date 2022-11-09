using System;
using UnityEngine;

// Token: 0x02000018 RID: 24
public class HawkZoneOuterScript : MonoBehaviour
{
	// Token: 0x0600008E RID: 142 RVA: 0x000071B8 File Offset: 0x000053B8
	private void Awake()
	{
		this.bigHawkScript = GameObject.Find("HawkBig").GetComponent<BigHawkBehavior>();
	}

	// Token: 0x0600008F RID: 143 RVA: 0x000071D0 File Offset: 0x000053D0
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "Player")
		{
			move component = other.GetComponent<move>();
			if (component != null && component.freezeControls)
			{
				this.bigHawkScript.active = true;
				this.bigHawkScript.inBounds = true;
			}
		}
	}

	// Token: 0x06000090 RID: 144 RVA: 0x00007228 File Offset: 0x00005428
	private void OnTriggerExit(Collider other)
	{
		if (other.name == "Player")
		{
			this.bigHawkScript.inBounds = false;
		}
	}

	// Token: 0x040000FE RID: 254
	private BigHawkBehavior bigHawkScript;
}
