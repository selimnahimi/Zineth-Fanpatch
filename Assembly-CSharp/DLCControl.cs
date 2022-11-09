using System;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using Twitter;
using UnityEngine;

// Token: 0x0200009C RID: 156
public class DLCControl : MonoBehaviour
{
	// Token: 0x060006B2 RID: 1714 RVA: 0x0002B43C File Offset: 0x0002963C
	private void Awake()
	{
		if (DLCControl.instance != null)
		{
			UnityEngine.Object.Destroy(this);
		}
		else
		{
			DLCControl.instance = this;
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			this.DownloadInfo();
		}
	}

	// Token: 0x060006B3 RID: 1715 RVA: 0x0002B47C File Offset: 0x0002967C
	public static int CompareVersions(string a, string b)
	{
		float num = DLCControl.VersionToFloat(a);
		float num2 = DLCControl.VersionToFloat(b);
		if (num > num2)
		{
			return -1;
		}
		if (num == num2)
		{
			return 0;
		}
		return 1;
	}

	// Token: 0x060006B4 RID: 1716 RVA: 0x0002B4AC File Offset: 0x000296AC
	public static float VersionToFloat(string version)
	{
		if (version.StartsWith("v"))
		{
			version = version.Remove(0, 1);
		}
		version = version.Replace("_", ".");
		float result;
		if (float.TryParse(version, out result))
		{
			return result;
		}
		Debug.LogWarning("could not parse the version " + version);
		return -2f;
	}

	// Token: 0x060006B5 RID: 1717 RVA: 0x0002B50C File Offset: 0x0002970C
	public void DownloadInfo()
	{
		base.StartCoroutine(this.DownloadInfo(DLCControl.infoUrl));
	}

	// Token: 0x060006B6 RID: 1718 RVA: 0x0002B520 File Offset: 0x00029720
	public IEnumerator DownloadInfo(string url)
	{
		WWW web = new WWW(url);
		yield return web;
		if (web.error == null)
		{
			string text = web.text;
			this.ParseInfo(text);
		}
		else
		{
			this.connection_trouble++;
			Debug.LogWarning(web.error + "\n" + url);
			if (this.connection_trouble < 3)
			{
				base.Invoke("DownloadInfo", 1f);
			}
			else if (this.connection_trouble < 6)
			{
				base.Invoke("DownloadInfo", 6f);
			}
		}
		yield break;
	}

	// Token: 0x170000DB RID: 219
	// (get) Token: 0x060006B7 RID: 1719 RVA: 0x0002B54C File Offset: 0x0002974C
	public string current_version
	{
		get
		{
			if (this.statusInfo != null)
			{
				return this.statusInfo.current_version;
			}
			return string.Empty;
		}
	}

	// Token: 0x170000DC RID: 220
	// (get) Token: 0x060006B8 RID: 1720 RVA: 0x0002B56C File Offset: 0x0002976C
	public string local_version
	{
		get
		{
			return PhoneInterface.version;
		}
	}

	// Token: 0x170000DD RID: 221
	// (get) Token: 0x060006B9 RID: 1721 RVA: 0x0002B574 File Offset: 0x00029774
	public int is_current
	{
		get
		{
			if (this._compared == -2)
			{
				this._compared = DLCControl.CompareVersions(this.current_version, this.local_version);
			}
			return this._compared;
		}
	}

	// Token: 0x060006BA RID: 1722 RVA: 0x0002B5AC File Offset: 0x000297AC
	public void ParseInfo(string text)
	{
		XmlDocument xmlDocument = new XmlDocument();
		xmlDocument.LoadXml(text);
		XmlNode firstChild = xmlDocument.FirstChild;
		DLCControl.dirUrl = DLCControl.URLDecode(firstChild["dir_url"]);
		this.statusInfo = new DLCControl.StatusInfo(firstChild["status"]);
		XmlNode xmlNode = firstChild["versions"];
		XmlNode xmlNode2 = xmlNode[this.local_version];
		if (xmlNode2 != null)
		{
			this.localInfo = new DLCControl.VersionInfo(xmlNode2);
			foreach (DLCControl.DLCInfo item in this.localInfo.dlc)
			{
				DLCControl.dlcInfoList.Add(item);
			}
		}
		else
		{
			Debug.LogWarning("could not find node for version: " + this.local_version);
		}
		if (this.is_current < 0)
		{
			XmlNode xmlNode3 = xmlNode[this.current_version];
			if (xmlNode3 != null)
			{
				this.currentInfo = new DLCControl.VersionInfo(xmlNode3);
			}
			else
			{
				Debug.Log("could not find node for current version: " + this.current_version);
			}
		}
	}

	// Token: 0x060006BB RID: 1723 RVA: 0x0002B6EC File Offset: 0x000298EC
	public void DoGUI()
	{
		if (!DLCControl.showGUI)
		{
			DLCControl.showGUI = false;
			base.useGUILayout = false;
			return;
		}
		if (this.debug_gui)
		{
			this.DebugGUI();
		}
		else
		{
			this.NormalGUI();
		}
	}

	// Token: 0x060006BC RID: 1724 RVA: 0x0002B730 File Offset: 0x00029930
	public void NormalGUI()
	{
		GUILayout.Label(PhoneInterface.version, new GUILayoutOption[0]);
		if (this.statusInfo != null)
		{
			if (this.is_current < 0)
			{
				GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
				if (this.gui_show_status)
				{
					GUILayout.Label("New Version Available!", new GUILayoutOption[0]);
				}
				else if (GUILayout.Button("New Version Available!", new GUILayoutOption[0]))
				{
					this.gui_show_status = true;
				}
				if (this.gui_show_status)
				{
					this.DrawInfo(this.currentInfo);
				}
				GUILayout.EndVertical();
			}
			else if (this.is_current > 0)
			{
				GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
				GUILayout.Label("Living in the future!", new GUILayoutOption[0]);
				GUILayout.EndVertical();
			}
		}
		else if (this.connection_trouble >= 3)
		{
			GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
			if (this.connection_trouble < 6)
			{
				GUILayout.Label("Having trouble connecting to update info...", new GUILayoutOption[0]);
			}
			else
			{
				GUILayout.Label("Couldn't connect to update info!", new GUILayoutOption[0]);
				if (GUILayout.Button("Open Zineth Website", new GUILayoutOption[0]))
				{
					Application.OpenURL(DLCControl.websiteUrl);
				}
			}
			GUILayout.EndVertical();
		}
	}

	// Token: 0x060006BD RID: 1725 RVA: 0x0002B888 File Offset: 0x00029A88
	public void DebugGUI()
	{
		if (this.statusInfo == null)
		{
			if (GUILayout.Button("Download Info", new GUILayoutOption[0]))
			{
				this.DownloadInfo();
			}
		}
		else
		{
			GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
			this.gui_show_status = GUILayout.Toggle(this.gui_show_status, "Status:", new GUILayoutOption[0]);
			if (this.gui_show_status)
			{
				GUILayout.Label("Newest version: " + this.statusInfo.current_version, new GUILayoutOption[0]);
				GUILayout.Label("News: " + this.statusInfo.message, new GUILayoutOption[0]);
				if (GUILayout.Button(this.statusInfo.url, new GUILayoutOption[0]))
				{
					Application.OpenURL(this.statusInfo.url);
				}
			}
			GUILayout.EndVertical();
			if (this.is_current < 0)
			{
				GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
				this.gui_show_current = GUILayout.Toggle(this.gui_show_current, "New Version!", new GUILayoutOption[0]);
				if (this.gui_show_current)
				{
					this.DrawInfo(this.currentInfo);
				}
				GUILayout.EndVertical();
			}
			if (this.localInfo != null)
			{
			}
		}
	}

	// Token: 0x060006BE RID: 1726 RVA: 0x0002B9D0 File Offset: 0x00029BD0
	public void DrawInfo(DLCControl.VersionInfo info)
	{
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		string text = "Version: ";
		string text2 = info.version;
		if (text2.StartsWith("v"))
		{
			text2 = text2.Remove(0, 1);
		}
		text += text2;
		text = text + " (" + info.date + ")";
		GUILayout.Label(text, new GUILayoutOption[0]);
		if (!string.IsNullOrEmpty(info.info))
		{
			GUILayout.Label(info.info, new GUILayoutOption[0]);
		}
		string url = this.statusInfo.url;
		if (!string.IsNullOrEmpty(info.url))
		{
			url = info.url;
		}
		if (GUILayout.Button("Open Website", new GUILayoutOption[0]))
		{
			Application.OpenURL(url);
			Playtomic.Log.CustomMetric("opened_update_site", PlaytomicController.current_phone_group);
		}
		if (info.changes.Count > 0)
		{
			GUILayout.Label("Changes:", new GUILayoutOption[0]);
			foreach (string str in info.changes)
			{
				GUILayout.Label("-" + str, new GUILayoutOption[0]);
			}
		}
		if (info.dlc.Count > 0 && this.debug_gui)
		{
			GUILayout.Label("DLC:", new GUILayoutOption[0]);
			foreach (DLCControl.DLCInfo dlcinfo in info.dlc)
			{
				GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
				dlcinfo.gui_expand = GUILayout.Toggle(dlcinfo.gui_expand, dlcinfo.name, new GUILayoutOption[0]);
				if (dlcinfo.gui_expand)
				{
					GUILayout.Label(dlcinfo.file_url, new GUILayoutOption[0]);
				}
				GUILayout.EndVertical();
			}
		}
		GUILayout.EndVertical();
	}

	// Token: 0x060006BF RID: 1727 RVA: 0x0002BC1C File Offset: 0x00029E1C
	private static string URLDecode(XmlNode node)
	{
		if (node == null)
		{
			return string.Empty;
		}
		return DLCControl.URLDecode(node.InnerText);
	}

	// Token: 0x060006C0 RID: 1728 RVA: 0x0002BC38 File Offset: 0x00029E38
	private static string URLDecode(string url)
	{
		return Parser.UrlDecode(url).Replace("{dir}", DLCControl.dirUrl);
	}

	// Token: 0x0400057D RID: 1405
	public static DLCControl instance;

	// Token: 0x0400057E RID: 1406
	public static string websiteUrl = "http://www.arcanekids.com";

	// Token: 0x0400057F RID: 1407
	public static string infoUrl = "https://dl.dropbox.com/u/15013465/dlc_test/info.xml";

	// Token: 0x04000580 RID: 1408
	private int connection_trouble;

	// Token: 0x04000581 RID: 1409
	private DLCControl.StatusInfo statusInfo;

	// Token: 0x04000582 RID: 1410
	private int _compared = -2;

	// Token: 0x04000583 RID: 1411
	private DLCControl.VersionInfo localInfo;

	// Token: 0x04000584 RID: 1412
	private DLCControl.VersionInfo currentInfo;

	// Token: 0x04000585 RID: 1413
	private static string dirUrl;

	// Token: 0x04000586 RID: 1414
	public static List<DLCControl.DLCInfo> dlcInfoList = new List<DLCControl.DLCInfo>();

	// Token: 0x04000587 RID: 1415
	public static bool showGUI = true;

	// Token: 0x04000588 RID: 1416
	private bool gui_show_status = true;

	// Token: 0x04000589 RID: 1417
	private bool gui_show_current;

	// Token: 0x0400058A RID: 1418
	private bool gui_show_local;

	// Token: 0x0400058B RID: 1419
	private bool debug_gui;

	// Token: 0x0200009D RID: 157
	public class StatusInfo
	{
		// Token: 0x060006C1 RID: 1729 RVA: 0x0002BC50 File Offset: 0x00029E50
		public StatusInfo(XmlNode node)
		{
			this.current_version = DLCControl.URLDecode(node["current"]);
			this.url = DLCControl.URLDecode(node["url"]);
			this.message = DLCControl.URLDecode(node["message"]);
			if (node["hashtag"] != null)
			{
				this.hashtag = DLCControl.URLDecode(node["hashtag"]);
				TwitterDemo.hash_tag = this.hashtag;
			}
		}

		// Token: 0x0400058C RID: 1420
		public string current_version;

		// Token: 0x0400058D RID: 1421
		public string url;

		// Token: 0x0400058E RID: 1422
		public string message;

		// Token: 0x0400058F RID: 1423
		public string hashtag;
	}

	// Token: 0x0200009E RID: 158
	public class VersionInfo
	{
		// Token: 0x060006C2 RID: 1730 RVA: 0x0002BCD8 File Offset: 0x00029ED8
		public VersionInfo(XmlNode node)
		{
			this.version = node.Name;
			this.info = DLCControl.URLDecode(node["info"]);
			this.date = DLCControl.URLDecode(node["date"]);
			this.url = DLCControl.URLDecode(node["url"]);
			if (node["file_url"] != null)
			{
				this.file_url = DLCControl.URLDecode(node["file_url"]);
			}
			if (node["changes"] != null)
			{
				foreach (object obj in node["changes"])
				{
					XmlNode node2 = (XmlNode)obj;
					this.changes.Add(DLCControl.URLDecode(node2));
				}
			}
			if (node["dlc"] != null)
			{
				foreach (object obj2 in node["dlc"])
				{
					XmlNode node3 = (XmlNode)obj2;
					this.dlc.Add(new DLCControl.DLCInfo(node3));
				}
			}
		}

		// Token: 0x04000590 RID: 1424
		public string version;

		// Token: 0x04000591 RID: 1425
		public string info;

		// Token: 0x04000592 RID: 1426
		public string date;

		// Token: 0x04000593 RID: 1427
		public string url;

		// Token: 0x04000594 RID: 1428
		public string file_url;

		// Token: 0x04000595 RID: 1429
		public List<DLCControl.DLCInfo> dlc = new List<DLCControl.DLCInfo>();

		// Token: 0x04000596 RID: 1430
		public List<string> changes = new List<string>();
	}

	// Token: 0x0200009F RID: 159
	public class DLCInfo
	{
		// Token: 0x060006C3 RID: 1731 RVA: 0x0002BE7C File Offset: 0x0002A07C
		public DLCInfo(XmlNode node)
		{
			this.name = DLCControl.URLDecode(node["name"]);
			this.file_url = DLCControl.URLDecode(node["file_url"]);
		}

		// Token: 0x04000597 RID: 1431
		public string name;

		// Token: 0x04000598 RID: 1432
		public string file_url;

		// Token: 0x04000599 RID: 1433
		public bool gui_expand;
	}
}
