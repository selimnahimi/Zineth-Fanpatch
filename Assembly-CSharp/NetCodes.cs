using System;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using UnityEngine;

// Token: 0x0200008E RID: 142
public class NetCodes : MonoBehaviour
{
	// Token: 0x060005F8 RID: 1528 RVA: 0x00026A6C File Offset: 0x00024C6C
	private void Awake()
	{
		this.ip_str = Network.player.ipAddress;
		this.show_gui = false;
	}

	// Token: 0x170000C8 RID: 200
	// (get) Token: 0x060005F9 RID: 1529 RVA: 0x00026A94 File Offset: 0x00024C94
	// (set) Token: 0x060005FA RID: 1530 RVA: 0x00026A9C File Offset: 0x00024C9C
	public bool show_gui
	{
		get
		{
			return base.useGUILayout;
		}
		set
		{
			base.useGUILayout = value;
		}
	}

	// Token: 0x060005FB RID: 1531 RVA: 0x00026AA8 File Offset: 0x00024CA8
	public static void AddWord(string a, string b)
	{
		if (!NetCodes.word_dic.ContainsKey(a))
		{
			NetCodes.word_dic.Add(a, new List<string>());
		}
		NetCodes.word_dic[a].Add(b);
	}

	// Token: 0x060005FC RID: 1532 RVA: 0x00026AE8 File Offset: 0x00024CE8
	public static void AddPhrase(string text)
	{
		text = text.Trim();
		if (text.Length <= 5)
		{
			return;
		}
		text = string.Format("{0} {1} {2}", NetCodes.startSymbol, text, NetCodes.endSymbol);
		string[] array = text.Split(new char[]
		{
			' '
		});
		if (array.Length == 0)
		{
			return;
		}
		for (int i = 0; i < array.Length - 1; i++)
		{
			NetCodes.AddWord(array[i], array[i + 1]);
		}
	}

	// Token: 0x060005FD RID: 1533 RVA: 0x00026B60 File Offset: 0x00024D60
	public static void AddString(string text)
	{
		text = text.Replace(",", " , ");
		string[] array = text.Split(new char[]
		{
			'.',
			'?',
			'!',
			'\n'
		});
		foreach (string text2 in array)
		{
			NetCodes.AddPhrase(text2);
		}
	}

	// Token: 0x060005FE RID: 1534 RVA: 0x00026BB8 File Offset: 0x00024DB8
	public static string GetNext(string a)
	{
		List<string> list = NetCodes.word_dic[a];
		return list[UnityEngine.Random.Range(0, list.Count)];
	}

	// Token: 0x060005FF RID: 1535 RVA: 0x00026BE4 File Offset: 0x00024DE4
	public static string GetFirst()
	{
		return NetCodes.GetNext(NetCodes.startSymbol);
	}

	// Token: 0x06000600 RID: 1536 RVA: 0x00026BF0 File Offset: 0x00024DF0
	public static string GenerateString()
	{
		string text = string.Empty;
		string text2 = NetCodes.GetFirst();
		while (text2 != NetCodes.endSymbol)
		{
			text = text + text2 + " ";
			text2 = NetCodes.GetNext(text2);
		}
		return text.Trim();
	}

	// Token: 0x06000601 RID: 1537 RVA: 0x00026C38 File Offset: 0x00024E38
	public static IEnumerator AddWebText(string url)
	{
		WWW web = new WWW(url);
		yield return web;
		string txt = web.text;
		NetCodes.AddString(txt);
		yield break;
	}

	// Token: 0x06000602 RID: 1538 RVA: 0x00026C5C File Offset: 0x00024E5C
	private void OnGUI()
	{
		if (!this.show_gui)
		{
			return;
		}
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		if (NetCodes.word_dic.Count > 0 && GUILayout.Button("generate", new GUILayoutOption[0]))
		{
			this.genstr = NetCodes.GenerateString();
		}
		if (this.genstr != string.Empty)
		{
			GUILayout.Box(this.genstr, new GUILayoutOption[0]);
		}
		GUILayout.EndHorizontal();
		if (GUILayout.Button("Get Location", new GUILayoutOption[0]))
		{
			base.StartCoroutine("GetLocation", this.ip_str);
		}
		if (this.maptexture)
		{
			GUILayout.Box(this.maptexture, new GUILayoutOption[0]);
		}
		if (this.weather_info != null)
		{
			string text = "The Weather in your area is: " + this.weather_info.condition;
			text = text + "\n" + this.weather_info.temp_f + "F";
			text = text + "\n" + this.weather_info.humidity;
			text = text + "\n" + this.weather_info.wind_conditions;
			GUILayout.Box(text, new GUILayoutOption[0]);
		}
	}

	// Token: 0x06000603 RID: 1539 RVA: 0x00026D9C File Offset: 0x00024F9C
	private IEnumerator GetLocation(string ip)
	{
		string url = "http://api.ipinfodb.com/v3/ip-city/?key=7999984451273a720a4f8904a9b64991e4156211e893d394072602cd7f7c6657";
		WWW locweb = new WWW(url);
		yield return locweb;
		string[] items = locweb.text.Split(new char[]
		{
			';'
		});
		this.has_got_loc = true;
		this.country = items[4];
		this.state = items[5];
		this.city = items[6];
		this.zip = items[7];
		this.latitude = items[8];
		this.longitude = items[9];
		base.StartCoroutine("GetGoogleMap");
		yield break;
	}

	// Token: 0x06000604 RID: 1540 RVA: 0x00026DB8 File Offset: 0x00024FB8
	private IEnumerator GetGoogleMap()
	{
		string url = string.Concat(new string[]
		{
			"http://maps.googleapis.com/maps/api/staticmap?center=",
			this.latitude,
			",",
			this.longitude,
			"&zoom=11&size=200x200&sensor=false"
		});
		WWW mapweb = new WWW(url);
		yield return mapweb;
		this.maptexture = mapweb.texture;
		base.StartCoroutine("GetWeather");
		yield break;
	}

	// Token: 0x06000605 RID: 1541 RVA: 0x00026DD4 File Offset: 0x00024FD4
	private IEnumerator GetWeather()
	{
		string url = "http://www.google.com/ig/api?weather=" + this.zip;
		WWW wethweb = new WWW(url);
		yield return wethweb;
		string text = wethweb.text;
		XmlDocument doc = new XmlDocument();
		doc.LoadXml(text);
		XmlNodeList nodelist = doc.GetElementsByTagName("current_conditions");
		XmlNode node = nodelist[0];
		this.weather_info = new WeatherInfo(node);
		yield break;
	}

	// Token: 0x040004B3 RID: 1203
	private string ip_str;

	// Token: 0x040004B4 RID: 1204
	public static Dictionary<string, List<string>> word_dic = new Dictionary<string, List<string>>();

	// Token: 0x040004B5 RID: 1205
	private static readonly string startSymbol = "*^s*";

	// Token: 0x040004B6 RID: 1206
	private static readonly string endSymbol = "*^e";

	// Token: 0x040004B7 RID: 1207
	private string genstr = string.Empty;

	// Token: 0x040004B8 RID: 1208
	private string genurl = string.Empty;

	// Token: 0x040004B9 RID: 1209
	public bool has_got_loc;

	// Token: 0x040004BA RID: 1210
	public string country;

	// Token: 0x040004BB RID: 1211
	public string state;

	// Token: 0x040004BC RID: 1212
	public string city;

	// Token: 0x040004BD RID: 1213
	public string zip;

	// Token: 0x040004BE RID: 1214
	public string latitude;

	// Token: 0x040004BF RID: 1215
	public string longitude;

	// Token: 0x040004C0 RID: 1216
	public WeatherInfo weather_info;

	// Token: 0x040004C1 RID: 1217
	private Texture2D maptexture;
}
