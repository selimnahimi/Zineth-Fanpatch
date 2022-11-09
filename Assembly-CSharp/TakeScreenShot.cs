using System;
using System.Collections;
using System.IO;
using UnityEngine;

// Token: 0x020000B4 RID: 180
public class TakeScreenShot : MonoBehaviour
{
	// Token: 0x060007AD RID: 1965 RVA: 0x00033360 File Offset: 0x00031560
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.F9))
		{
			base.StartCoroutine(this.ScreenshotEncode());
		}
		if (Input.GetKeyDown(KeyCode.F11))
		{
			this.TweetScreenshot();
		}
	}

	// Token: 0x060007AE RID: 1966 RVA: 0x00033394 File Offset: 0x00031594
	private void TweetScreenshot()
	{
		TwitterDemo.instance.DoPostScreenshot();
	}

	// Token: 0x060007AF RID: 1967 RVA: 0x000333A0 File Offset: 0x000315A0
	private IEnumerator ScreenshotEncode()
	{
		yield return new WaitForEndOfFrame();
		Texture2D texture = new Texture2D(Screen.width, Screen.height, TextureFormat.RGB24, false);
		texture.ReadPixels(new Rect(0f, 0f, (float)Screen.width, (float)Screen.height), 0, 0);
		texture.Apply();
		string filedir = string.Empty;
		if (Environment.UserName == "knipfj")
		{
			filedir = Environment.GetFolderPath(Environment.SpecialFolder.MyPictures) + "/Zineth/";
		}
		string timestr = DateTime.Now.ToString("M-d-yyyy_H-mm-ss");
		string filename = filedir + timestr.Replace(' ', '_').Replace(':', '-').Replace('/', '-') + ".png";
		string tfilename = filename;
		while (File.Exists(tfilename))
		{
			this.count++;
			tfilename = filename.Replace(".png", "_" + this.count + ".png");
		}
		yield return 0;
		byte[] bytes = texture.EncodeToPNG();
		File.WriteAllBytes(filename, bytes);
		this.count++;
		MonoBehaviour.print(filename);
		UnityEngine.Object.DestroyObject(texture);
		yield break;
	}

	// Token: 0x0400066E RID: 1646
	private int count;
}
