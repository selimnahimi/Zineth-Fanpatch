using System;
using System.Collections.Generic;
using UnityEngine;

namespace Twitter
{
	// Token: 0x02000093 RID: 147
	public class TweetContext
	{
		// Token: 0x040004D6 RID: 1238
		public string text;

		// Token: 0x040004D7 RID: 1239
		public Texture2D texture;

		// Token: 0x040004D8 RID: 1240
		public string textureURL = string.Empty;

		// Token: 0x040004D9 RID: 1241
		public string replyTo = string.Empty;

		// Token: 0x040004DA RID: 1242
		public List<string> mentions = new List<string>();

		// Token: 0x040004DB RID: 1243
		public string posLat = string.Empty;

		// Token: 0x040004DC RID: 1244
		public string posLong = string.Empty;
	}
}
