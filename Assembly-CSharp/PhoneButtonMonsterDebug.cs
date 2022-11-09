using System;
using UnityEngine;

// Token: 0x02000060 RID: 96
public class PhoneButtonMonsterDebug : PhoneButton
{
	// Token: 0x1700008B RID: 139
	// (get) Token: 0x060003FD RID: 1021 RVA: 0x00017F9C File Offset: 0x0001619C
	private MonsterTester tester
	{
		get
		{
			if (!this._tester)
			{
				this._tester = (UnityEngine.Object.FindObjectOfType(typeof(MonsterTester)) as MonsterTester);
			}
			return this._tester;
		}
	}

	// Token: 0x1700008C RID: 140
	// (get) Token: 0x060003FE RID: 1022 RVA: 0x00017FDC File Offset: 0x000161DC
	private bool is_on
	{
		get
		{
			return this.tester.enabled;
		}
	}

	// Token: 0x060003FF RID: 1023 RVA: 0x00017FEC File Offset: 0x000161EC
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
			this.textmesh.text = "Monster Debug(on)";
		}
		else
		{
			this.textmesh.text = "Monster Debug(off)";
		}
		this.Init();
	}

	// Token: 0x06000400 RID: 1024 RVA: 0x0001807C File Offset: 0x0001627C
	private void Start()
	{
	}

	// Token: 0x06000401 RID: 1025 RVA: 0x00018080 File Offset: 0x00016280
	public override void OnPressed()
	{
		this.tester.enabled = !this.is_on;
		if (this.is_on)
		{
			this.textmesh.text = "Monster Debug(on)";
		}
		else
		{
			this.textmesh.text = "Monster Debug(off)";
		}
		this.tester.showgui = this.is_on;
	}

	// Token: 0x04000334 RID: 820
	private MonsterTester _tester;
}
