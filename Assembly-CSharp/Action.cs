using System;

// Token: 0x0200000E RID: 14
public class Action
{
	// Token: 0x06000047 RID: 71 RVA: 0x00003A60 File Offset: 0x00001C60
	public Action(stateEnum newMood, float newLength, float newPause)
	{
		this.mood = newMood;
		this.length = newLength;
		this.pause = newPause;
	}

	// Token: 0x0400004A RID: 74
	public stateEnum mood;

	// Token: 0x0400004B RID: 75
	public float length;

	// Token: 0x0400004C RID: 76
	public float pause;
}
