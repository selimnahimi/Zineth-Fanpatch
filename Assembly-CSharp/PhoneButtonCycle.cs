using System;

// Token: 0x0200005F RID: 95
public class PhoneButtonCycle : PhoneButton
{
	// Token: 0x060003FA RID: 1018 RVA: 0x00017F2C File Offset: 0x0001612C
	private void Awake()
	{
		this.Init();
		if (this.colors.Length == 0)
		{
			this.colors[0] = "white";
		}
	}

	// Token: 0x060003FB RID: 1019 RVA: 0x00017F5C File Offset: 0x0001615C
	public override void OnPressed()
	{
		string command = this.command + " " + this.colors[this.ind];
		this.controller.DoCommand(command);
	}

	// Token: 0x04000332 RID: 818
	public string[] colors;

	// Token: 0x04000333 RID: 819
	private int ind;
}
