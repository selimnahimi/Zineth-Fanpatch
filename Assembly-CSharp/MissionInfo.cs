using System;

// Token: 0x02000021 RID: 33
public class MissionInfo
{
	// Token: 0x060000F2 RID: 242 RVA: 0x00008A08 File Offset: 0x00006C08
	public MissionInfo(string titletext, string idtext, int statustext, string descriptiontext, string introtext, string outrotext)
	{
		this.title = titletext;
		this.id = idtext;
		this.status = statustext;
		this.description = descriptiontext;
		this.introText = introtext;
		this.outroText = outrotext;
	}

	// Token: 0x0400014A RID: 330
	public string title = "Default Title";

	// Token: 0x0400014B RID: 331
	public string id = "zzzzz";

	// Token: 0x0400014C RID: 332
	public int status;

	// Token: 0x0400014D RID: 333
	public string description = "This describes the mission. The player will love to read this description.";

	// Token: 0x0400014E RID: 334
	public string introText = "This is the text that you see when receiving a mission.";

	// Token: 0x0400014F RID: 335
	public string outroText = "This is the text that you see when completing a mission.";
}
