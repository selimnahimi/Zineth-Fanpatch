using System;
using UnityEngine;

// Token: 0x02000061 RID: 97
public class PhoneButtonMusicDebug : PhoneButton
{
	// Token: 0x1700008D RID: 141
	// (get) Token: 0x06000403 RID: 1027 RVA: 0x000180EC File Offset: 0x000162EC
	private bool is_on
	{
		get
		{
			return MusicManager.show_debug_gui;
		}
	}

	// Token: 0x06000404 RID: 1028 RVA: 0x000180F4 File Offset: 0x000162F4
	private void Awake()
	{
		if (this.textmesh == null)
		{
			this.textmesh = base.gameObject.GetComponent<TextMesh>();
		}
		if (this.controller == null)
		{
			this.controller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneController)) as PhoneController);
		}
		if (this.is_on)
		{
			this.textmesh.text = "Music Debug(on)";
		}
		else
		{
			this.textmesh.text = "Music Debug(off)";
		}
		this.Init();
	}

	// Token: 0x06000405 RID: 1029 RVA: 0x00018184 File Offset: 0x00016384
	private void Start()
	{
	}

	// Token: 0x06000406 RID: 1030 RVA: 0x00018188 File Offset: 0x00016388
	public override void OnPressed()
	{
		MusicManager.show_debug_gui = !this.is_on;
		if (this.is_on)
		{
			this.textmesh.text = "Music Debug(on)";
		}
		else
		{
			this.textmesh.text = "Music Debug(off)";
		}
	}
}
