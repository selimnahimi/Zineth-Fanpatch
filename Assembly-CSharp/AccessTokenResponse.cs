using System;

namespace Twitter
{
	// Token: 0x02000092 RID: 146
	public class AccessTokenResponse
	{
		// Token: 0x170000CB RID: 203
		// (get) Token: 0x0600061A RID: 1562 RVA: 0x00027548 File Offset: 0x00025748
		// (set) Token: 0x0600061B RID: 1563 RVA: 0x00027550 File Offset: 0x00025750
		public string Token { get; set; }

		// Token: 0x170000CC RID: 204
		// (get) Token: 0x0600061C RID: 1564 RVA: 0x0002755C File Offset: 0x0002575C
		// (set) Token: 0x0600061D RID: 1565 RVA: 0x00027564 File Offset: 0x00025764
		public string TokenSecret { get; set; }

		// Token: 0x170000CD RID: 205
		// (get) Token: 0x0600061E RID: 1566 RVA: 0x00027570 File Offset: 0x00025770
		// (set) Token: 0x0600061F RID: 1567 RVA: 0x00027578 File Offset: 0x00025778
		public string UserId { get; set; }

		// Token: 0x170000CE RID: 206
		// (get) Token: 0x06000620 RID: 1568 RVA: 0x00027584 File Offset: 0x00025784
		// (set) Token: 0x06000621 RID: 1569 RVA: 0x0002758C File Offset: 0x0002578C
		public string ScreenName { get; set; }
	}
}
