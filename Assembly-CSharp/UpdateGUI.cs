using System;
using UnityEngine;

// Token: 0x020000B0 RID: 176
public class UpdateGUI : MonoBehaviour
{
	// Token: 0x060007A1 RID: 1953 RVA: 0x00032764 File Offset: 0x00030964
	private void OnLevelWasLoaded(int level)
	{
		if (Application.loadedLevelName != "Loader 3")
		{
			base.enabled = false;
		}
	}

	// Token: 0x060007A2 RID: 1954 RVA: 0x00032784 File Offset: 0x00030984
	private void OnGUI()
	{
		if (DLCControl.instance != null)
		{
			DLCControl.instance.DoGUI();
		}
	}
}
