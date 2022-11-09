using System;
using System.Collections.Generic;
using System.Xml;
using UnityEngine;

namespace Twitter
{
	// Token: 0x02000095 RID: 149
	public class Parser
	{
		// Token: 0x06000645 RID: 1605 RVA: 0x0002802C File Offset: 0x0002622C
		public static string GetIconURL(string userID)
		{
			return Parser.iconUrl + userID;
		}

		// Token: 0x06000646 RID: 1606 RVA: 0x0002803C File Offset: 0x0002623C
		public static string ParseImgurResponse(string text)
		{
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(text);
			XmlNodeList elementsByTagName = xmlDocument.GetElementsByTagName("original");
			if (elementsByTagName.Count > 0)
			{
				return elementsByTagName[0].InnerText;
			}
			Debug.LogWarning("Could not parse the dang imgur response..." + text);
			return string.Empty;
		}

		// Token: 0x06000647 RID: 1607 RVA: 0x00028090 File Offset: 0x00026290
		public static List<PhoneMail> ParseAtomToMail(string atomtext)
		{
			List<PhoneMail> list = new List<PhoneMail>();
			atomtext = atomtext.Replace("georss:point>", "point>");
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(atomtext);
			XmlNodeList elementsByTagName = xmlDocument.GetElementsByTagName("entry");
			foreach (object obj in elementsByTagName)
			{
				XmlNode node = (XmlNode)obj;
				PhoneMail item = Parser.AtomTweetToMail(node);
				list.Add(item);
			}
			return list;
		}

		// Token: 0x06000648 RID: 1608 RVA: 0x0002813C File Offset: 0x0002633C
		public static PhoneMail AtomTweetToMail(XmlNode node)
		{
			PhoneMail phoneMail = new PhoneMail();
			string text = node["id"].InnerText;
			string[] array = text.Split(new char[]
			{
				':'
			});
			text = array[array.Length - 1];
			phoneMail.id = text;
			string innerText = node["title"].InnerText;
			phoneMail.body = innerText;
			string innerText2 = node["author"]["name"].InnerText;
			phoneMail.sender = innerText2;
			phoneMail.subject = string.Empty;
			if (node["twitter:geo"] != null && node["twitter:geo"]["point"] != null)
			{
				string innerText3 = node["twitter:geo"]["point"].InnerText;
				phoneMail.position = PlaytomicController.TranslateGPSStringToPos(innerText3);
				Debug.Log(phoneMail.position);
			}
			return phoneMail;
		}

		// Token: 0x06000649 RID: 1609 RVA: 0x0002822C File Offset: 0x0002642C
		public static List<PhoneMail> ParseToMail(string text)
		{
			List<PhoneMail> list = new List<PhoneMail>();
			XmlDocument xmlDocument = new XmlDocument();
			text = text.Replace("georss:point>", "point>");
			xmlDocument.LoadXml(text);
			XmlNodeList elementsByTagName = xmlDocument.GetElementsByTagName("status");
			foreach (object obj in elementsByTagName)
			{
				XmlNode node = (XmlNode)obj;
				PhoneMail item = Parser.TweetToMail(node);
				list.Add(item);
			}
			return list;
		}

		// Token: 0x0600064A RID: 1610 RVA: 0x000282D8 File Offset: 0x000264D8
		public static PhoneMail TweetToMail(XmlNode node)
		{
			string innerText = node["created_at"].InnerText;
			if (node["retweeted_status"] != null)
			{
				node = node["retweeted_status"];
			}
			string innerText2 = node["id"].InnerText;
			PhoneMail phoneMail = MailController.FindMail("tw_" + innerText2);
			if (phoneMail != null)
			{
				return phoneMail;
			}
			phoneMail = new PhoneMail();
			phoneMail.id = "tw_" + innerText2;
			ulong id_number;
			if (ulong.TryParse(innerText2, out id_number))
			{
				phoneMail.id_number = id_number;
			}
			else
			{
				phoneMail.id_number = 0UL;
				Debug.LogWarning("could not parse the id: " + innerText2);
			}
			string innerText3 = node["text"].InnerText;
			phoneMail.body = Parser.UrlDecode(innerText3);
			phoneMail.body = phoneMail.body.Replace('\n', ' ');
			phoneMail.sender = node["user"]["name"].InnerText;
			phoneMail.image_url = node["user"]["profile_image_url"].InnerText;
			phoneMail.subject = "@" + node["user"]["screen_name"].InnerXml;
			phoneMail.time = Parser.TweetTimeToDateTime(innerText);
			if (node["entities"] != null)
			{
				XmlNode xmlNode = node["entities"];
				if (xmlNode["media"] != null)
				{
					XmlNode xmlNode2 = xmlNode["media"];
					if (xmlNode2.ChildNodes.Count > 0)
					{
						XmlNode xmlNode3 = xmlNode2.ChildNodes[0];
						if (xmlNode3["media_url"] != null)
						{
							string item = xmlNode3["media_url"].InnerText + ":small";
							phoneMail.media_urls.Add(item);
						}
					}
				}
				if (xmlNode["urls"] != null)
				{
					XmlNode xmlNode4 = xmlNode["urls"];
					foreach (object obj in xmlNode4.ChildNodes)
					{
						XmlNode xmlNode5 = (XmlNode)obj;
						if (xmlNode5["expanded_url"] != null)
						{
							string text = xmlNode5["display_url"].InnerText;
							if (text.Length > 25)
							{
								text = text.Remove(22) + "...";
							}
							phoneMail.body = phoneMail.body.Replace(xmlNode5["url"].InnerText, text);
							string innerText4 = xmlNode5["expanded_url"].InnerText;
							if (innerText4.EndsWith(".jpg") || innerText4.EndsWith(".png"))
							{
								phoneMail.media_urls.Add(innerText4);
							}
							else if (innerText4.StartsWith("http://instagram.com/p/") || innerText4.StartsWith("http://instagr.am/p/"))
							{
								phoneMail.media_urls.Add(innerText4 + "media");
							}
							else if (innerText4.StartsWith("http://yfrog.com/"))
							{
								phoneMail.media_urls.Add(innerText4 + ":iphone");
							}
							else if (innerText4.StartsWith("http://twitpic.com/"))
							{
								phoneMail.media_urls.Add(innerText4.Replace("http://twitpic.com/", "http://twitpic.com/show/iphone/"));
							}
							else
							{
								phoneMail.link_urls.Add(innerText4);
							}
						}
					}
				}
			}
			XmlElement xmlElement = node["geo"];
			MailController.AddMail(phoneMail);
			return phoneMail;
		}

		// Token: 0x0600064B RID: 1611 RVA: 0x000286BC File Offset: 0x000268BC
		public static DateTime TweetTimeToDateTime(string timestring)
		{
			string[] array = timestring.Split(new char[]
			{
				' '
			});
			string text = array[1];
			int month;
			switch (text)
			{
			case "Jan":
				month = 1;
				goto IL_185;
			case "Feb":
				month = 2;
				goto IL_185;
			case "Mar":
				month = 3;
				goto IL_185;
			case "Apr":
				month = 4;
				goto IL_185;
			case "May":
				month = 5;
				goto IL_185;
			case "Jun":
				month = 6;
				goto IL_185;
			case "Jul":
				month = 7;
				goto IL_185;
			case "Aug":
				month = 8;
				goto IL_185;
			case "Sep":
				month = 9;
				goto IL_185;
			case "Oct":
				month = 10;
				goto IL_185;
			case "Nov":
				month = 11;
				goto IL_185;
			case "Dec":
				month = 12;
				goto IL_185;
			}
			month = 1;
			IL_185:
			int day;
			if (!int.TryParse(array[2], out day))
			{
				Debug.LogWarning("Could not parse tweet day: " + array[2]);
				day = 1;
			}
			int year;
			if (!int.TryParse(array[5], out year))
			{
				Debug.LogWarning("Could not parse tweet year: " + array[5]);
				year = 2012;
			}
			string[] array2 = array[3].Split(new char[]
			{
				':'
			});
			int hour;
			int.TryParse(array2[0], out hour);
			int minute;
			int.TryParse(array2[1], out minute);
			int second;
			int.TryParse(array2[2], out second);
			int num2 = 5;
			DateTime result = new DateTime(year, month, day, hour, minute, second);
			result = result.AddHours((double)(-(double)num2));
			if (DateTime.Now.IsDaylightSavingTime())
			{
				result = result.AddHours(1.0);
			}
			return result;
		}

		// Token: 0x0600064C RID: 1612 RVA: 0x00028918 File Offset: 0x00026B18
		public static string UrlDecode(string value)
		{
			if (string.IsNullOrEmpty(value))
			{
				return string.Empty;
			}
			value = Uri.UnescapeDataString(value);
			value = value.Replace("&quot;", "\"").Replace("&lt;", "<").Replace("&gt;", ">").Replace("&amp;", "&").Replace("&apos;", "'");
			return value;
		}

		// Token: 0x040004F0 RID: 1264
		private static string iconUrl = "http://api.twitter.com/1/users/profile_image/";
	}
}
