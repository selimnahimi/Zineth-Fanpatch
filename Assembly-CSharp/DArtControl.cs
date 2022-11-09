using System;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using Twitter;
using UnityEngine;

// Token: 0x020000A7 RID: 167
public class DArtControl : MonoBehaviour
{
	// Token: 0x170000DE RID: 222
	// (get) Token: 0x060006FA RID: 1786 RVA: 0x0002CC68 File Offset: 0x0002AE68
	public static DArtControl instance
	{
		get
		{
			if (!DArtControl._instance)
			{
				DArtControl._instance = (UnityEngine.Object.FindObjectOfType(typeof(DArtControl)) as DArtControl);
			}
			return DArtControl._instance;
		}
	}

	// Token: 0x060006FB RID: 1787 RVA: 0x0002CC98 File Offset: 0x0002AE98
	private void Update()
	{
		if (this.tdart)
		{
			DArtControl.GrabSomeDArt();
		}
		if (this.show)
		{
			this.ShowDart(this.indx);
		}
		this.tdart = false;
		this.show = false;
	}

	// Token: 0x060006FC RID: 1788 RVA: 0x0002CCD0 File Offset: 0x0002AED0
	public void ShowDart()
	{
		this.ShowDart(this.indx);
	}

	// Token: 0x060006FD RID: 1789 RVA: 0x0002CCE0 File Offset: 0x0002AEE0
	public void ShowDart(int index)
	{
		if (index >= 0 && DArtControl.url_list.Count > index)
		{
			Texture2D texture = ImageDownloadHelper.NewImage(DArtControl.url_list[index]);
			PhoneInterface.ShowZine(texture, true);
		}
	}

	// Token: 0x060006FE RID: 1790 RVA: 0x0002CD20 File Offset: 0x0002AF20
	public static void SearchAndGrab(string str)
	{
		string text = API.UrlEncode(str);
		text = string.Format(DArtControl.dart_search_url, text);
		DArtControl.GrabSomeDArt(text);
	}

	// Token: 0x060006FF RID: 1791 RVA: 0x0002CD48 File Offset: 0x0002AF48
	public static void GrabSomeDArt()
	{
		DArtControl.GrabSomeDArt(DArtControl.dart_url);
	}

	// Token: 0x06000700 RID: 1792 RVA: 0x0002CD54 File Offset: 0x0002AF54
	public static void GrabSomeDArt(string url)
	{
		DArtControl.instance.StartCoroutine(DArtControl.instance.GetDartXML(url));
	}

	// Token: 0x06000701 RID: 1793 RVA: 0x0002CD6C File Offset: 0x0002AF6C
	private IEnumerator GetDartXML(string url)
	{
		WWW web = new WWW(url);
		yield return web;
		this.Parse(web.text);
		this.ShowDart(0);
		yield break;
	}

	// Token: 0x06000702 RID: 1794 RVA: 0x0002CD98 File Offset: 0x0002AF98
	private void Parse(string text)
	{
		DArtControl.url_list.Clear();
		XmlDocument xmlDocument = new XmlDocument();
		xmlDocument.LoadXml(text);
		XmlNodeList elementsByTagName = xmlDocument.GetElementsByTagName("item");
		foreach (object obj in elementsByTagName)
		{
			XmlNode xmlNode = (XmlNode)obj;
			if (xmlNode["media:content"] != null)
			{
				DArtControl.url_list.Add(xmlNode["media:content"].Attributes["url"].InnerText);
			}
		}
	}

	// Token: 0x040005D1 RID: 1489
	private static DArtControl _instance;

	// Token: 0x040005D2 RID: 1490
	private static string dart_url = "http://backend.deviantart.com/rss.xml?q=favby%3Ablurpdrab";

	// Token: 0x040005D3 RID: 1491
	private static string dart_search_url = "http://backend.deviantart.com/rss.xml?q={0}";

	// Token: 0x040005D4 RID: 1492
	public bool tdart;

	// Token: 0x040005D5 RID: 1493
	public int indx;

	// Token: 0x040005D6 RID: 1494
	public bool show;

	// Token: 0x040005D7 RID: 1495
	public static List<string> url_list = new List<string>();
}
