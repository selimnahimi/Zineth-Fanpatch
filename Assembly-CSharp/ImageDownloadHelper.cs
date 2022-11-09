using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200005C RID: 92
public class ImageDownloadHelper : MonoBehaviour
{
	// Token: 0x17000084 RID: 132
	// (get) Token: 0x060003D0 RID: 976 RVA: 0x00016F6C File Offset: 0x0001516C
	private static Dictionary<string, Texture2D> image_dict
	{
		get
		{
			return PhoneTweetButton.image_dict;
		}
	}

	// Token: 0x17000085 RID: 133
	// (get) Token: 0x060003D1 RID: 977 RVA: 0x00016F74 File Offset: 0x00015174
	private static Dictionary<Texture, bool> finished_dl_dict
	{
		get
		{
			return PhoneTweetButton.finished_dl_dict;
		}
	}

	// Token: 0x060003D2 RID: 978 RVA: 0x00016F7C File Offset: 0x0001517C
	public static ImageDownloadHelper DownLoadImage(string url)
	{
		ImageDownloadHelper imageDownloadHelper;
		if (ImageDownloadHelper.free_list.Count > 0)
		{
			imageDownloadHelper = ImageDownloadHelper.free_list[0];
		}
		else
		{
			imageDownloadHelper = new GameObject("image_downloader").AddComponent<ImageDownloadHelper>();
		}
		imageDownloadHelper.DownloadImage(url);
		return imageDownloadHelper;
	}

	// Token: 0x060003D3 RID: 979 RVA: 0x00016FC4 File Offset: 0x000151C4
	public static Texture2D NewImage(string image_name)
	{
		if (ImageDownloadHelper.image_dict.ContainsKey(image_name))
		{
			return ImageDownloadHelper.image_dict[image_name];
		}
		Texture2D texture2D = new Texture2D(64, 64);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		ImageDownloadHelper.image_dict.Add(image_name, texture2D);
		ImageDownloadHelper.finished_dl_dict.Add(texture2D, false);
		ImageDownloadHelper.DownLoadImage(image_name);
		return texture2D;
	}

	// Token: 0x060003D4 RID: 980 RVA: 0x00017028 File Offset: 0x00015228
	private void Awake()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		ImageDownloadHelper.free_list.Add(this);
	}

	// Token: 0x060003D5 RID: 981 RVA: 0x00017040 File Offset: 0x00015240
	public void DownloadImage(string url)
	{
		base.StartCoroutine(this.Co_DownloadImage(url));
	}

	// Token: 0x060003D6 RID: 982 RVA: 0x00017050 File Offset: 0x00015250
	public IEnumerator Co_DownloadImage(string url)
	{
		this.busy = true;
		this.my_url = url;
		if (ImageDownloadHelper.free_list.Contains(this))
		{
			ImageDownloadHelper.free_list.Remove(this);
		}
		WWW web = new WWW(url);
		yield return web;
		if (web.error != null)
		{
			Debug.LogWarning(string.Concat(new string[]
			{
				"Error downloading image ",
				url,
				"(",
				web.error,
				")"
			}));
			ImageDownloadHelper.image_dict.Remove(url);
		}
		else
		{
			ImageDownloadHelper.image_dict[url].Resize(web.texture.width, web.texture.height);
			web.LoadImageIntoTexture(ImageDownloadHelper.image_dict[url]);
			ImageDownloadHelper.finished_dl_dict[ImageDownloadHelper.image_dict[url]] = true;
		}
		ImageDownloadHelper.free_list.Add(this);
		this.busy = false;
		yield break;
	}

	// Token: 0x060003D7 RID: 983 RVA: 0x0001707C File Offset: 0x0001527C
	public static void DeleteImage(string url)
	{
		if (ImageDownloadHelper.image_dict.ContainsKey(url))
		{
			Texture2D texture2D = ImageDownloadHelper.image_dict[url];
			if (ImageDownloadHelper.finished_dl_dict.ContainsKey(texture2D))
			{
				ImageDownloadHelper.finished_dl_dict.Remove(texture2D);
				ImageDownloadHelper.image_dict.Remove(url);
				UnityEngine.Object.Destroy(texture2D);
			}
		}
	}

	// Token: 0x04000305 RID: 773
	public string my_url;

	// Token: 0x04000306 RID: 774
	private static List<ImageDownloadHelper> free_list = new List<ImageDownloadHelper>();

	// Token: 0x04000307 RID: 775
	public bool busy;
}
