using System;
using System.Xml;
using UnityEngine;

// Token: 0x0200008F RID: 143
public class WeatherInfo
{
	// Token: 0x06000606 RID: 1542 RVA: 0x00026DF0 File Offset: 0x00024FF0
	private WeatherInfo()
	{
	}

	// Token: 0x06000607 RID: 1543 RVA: 0x00026DF8 File Offset: 0x00024FF8
	public WeatherInfo(XmlNode node)
	{
		this.condition = this.GetData(node, "condition");
		this.temp_f = this.GetData(node, "temp_f");
		this.humidity = this.GetData(node, "humidity");
		this.wind_conditions = this.GetData(node, "wind_condition");
	}

	// Token: 0x06000608 RID: 1544 RVA: 0x00026E54 File Offset: 0x00025054
	private string GetData(XmlNode node, string str)
	{
		Debug.Log(str);
		return node[str].GetAttribute("data");
	}

	// Token: 0x040004C2 RID: 1218
	public string day_name;

	// Token: 0x040004C3 RID: 1219
	public string condition;

	// Token: 0x040004C4 RID: 1220
	public string temp_f;

	// Token: 0x040004C5 RID: 1221
	public string humidity;

	// Token: 0x040004C6 RID: 1222
	public string icon_url;

	// Token: 0x040004C7 RID: 1223
	public string wind_conditions;

	// Token: 0x040004C8 RID: 1224
	public string low;

	// Token: 0x040004C9 RID: 1225
	public string high;
}
