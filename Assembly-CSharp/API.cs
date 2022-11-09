using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using HTTP;
using UnityEngine;

namespace Twitter
{
	// Token: 0x02000094 RID: 148
	public class API
	{
		// Token: 0x06000625 RID: 1573 RVA: 0x000276B8 File Offset: 0x000258B8
		public static IEnumerator GetRequestToken(string consumerKey, string consumerSecret, RequestTokenCallback callback)
		{
			WWW web = API.WWWRequestToken(consumerKey, consumerSecret);
			yield return web;
			if (!string.IsNullOrEmpty(web.error))
			{
				Debug.Log(string.Format("GetRequestToken - failed. error : {0}", web.error));
				callback(false, null);
			}
			else
			{
				RequestTokenResponse response = new RequestTokenResponse
				{
					Token = Regex.Match(web.text, "oauth_token=([^&]+)").Groups[1].Value,
					TokenSecret = Regex.Match(web.text, "oauth_token_secret=([^&]+)").Groups[1].Value
				};
				if (!string.IsNullOrEmpty(response.Token) && !string.IsNullOrEmpty(response.TokenSecret))
				{
					callback(true, response);
				}
				else
				{
					Debug.Log(string.Format("GetRequestToken - failed. response : {0}", web.text));
					callback(false, null);
				}
			}
			yield break;
		}

		// Token: 0x06000626 RID: 1574 RVA: 0x000276F8 File Offset: 0x000258F8
		public static void OpenAuthorizationPage(string requestToken)
		{
			Application.OpenURL(string.Format(API.AuthorizationURL, requestToken));
		}

		// Token: 0x06000627 RID: 1575 RVA: 0x0002770C File Offset: 0x0002590C
		public static IEnumerator GetAccessToken(string consumerKey, string consumerSecret, string requestToken, string pin, AccessTokenCallback callback)
		{
			WWW web = API.WWWAccessToken(consumerKey, consumerSecret, requestToken, pin);
			yield return web;
			if (!string.IsNullOrEmpty(web.error))
			{
				Debug.Log(string.Format("GetAccessToken - failed. error : {0}", web.error));
				callback(false, null);
			}
			else
			{
				AccessTokenResponse response = new AccessTokenResponse
				{
					Token = Regex.Match(web.text, "oauth_token=([^&]+)").Groups[1].Value,
					TokenSecret = Regex.Match(web.text, "oauth_token_secret=([^&]+)").Groups[1].Value,
					UserId = Regex.Match(web.text, "user_id=([^&]+)").Groups[1].Value,
					ScreenName = Regex.Match(web.text, "screen_name=([^&]+)").Groups[1].Value
				};
				if (!string.IsNullOrEmpty(response.Token) && !string.IsNullOrEmpty(response.TokenSecret) && !string.IsNullOrEmpty(response.UserId) && !string.IsNullOrEmpty(response.ScreenName))
				{
					callback(true, response);
				}
				else
				{
					Debug.Log(string.Format("GetAccessToken - failed. response : {0}", web.text));
					callback(false, null);
				}
			}
			yield break;
		}

		// Token: 0x06000628 RID: 1576 RVA: 0x00027768 File Offset: 0x00025968
		private static WWW WWWRequestToken(string consumerKey, string consumerSecret)
		{
			byte[] postData = new byte[]
			{
				0
			};
			Hashtable hashtable = new Hashtable();
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			API.AddDefaultOAuthParams(dictionary, consumerKey, consumerSecret);
			dictionary.Add("oauth_callback", "oob");
			hashtable["Authorization"] = API.GetFinalOAuthHeader("POST", API.RequestTokenURL, dictionary);
			return new WWW(API.RequestTokenURL, postData, hashtable);
		}

		// Token: 0x06000629 RID: 1577 RVA: 0x000277CC File Offset: 0x000259CC
		private static WWW WWWAccessToken(string consumerKey, string consumerSecret, string requestToken, string pin)
		{
			byte[] postData = new byte[]
			{
				0
			};
			Hashtable hashtable = new Hashtable();
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			API.AddDefaultOAuthParams(dictionary, consumerKey, consumerSecret);
			dictionary.Add("oauth_token", requestToken);
			dictionary.Add("oauth_verifier", pin);
			hashtable["Authorization"] = API.GetFinalOAuthHeader("POST", API.AccessTokenURL, dictionary);
			return new WWW(API.AccessTokenURL, postData, hashtable);
		}

		// Token: 0x0600062A RID: 1578 RVA: 0x00027838 File Offset: 0x00025A38
		private static string GetHeaderWithAccessToken(string httpRequestType, string apiURL, string consumerKey, string consumerSecret, AccessTokenResponse response, Dictionary<string, string> parameters)
		{
			API.AddDefaultOAuthParams(parameters, consumerKey, consumerSecret);
			parameters.Add("oauth_token", response.Token);
			parameters.Add("oauth_token_secret", response.TokenSecret);
			return API.GetFinalOAuthHeader(httpRequestType, apiURL, parameters);
		}

		// Token: 0x0600062B RID: 1579 RVA: 0x00027880 File Offset: 0x00025A80
		public static IEnumerator PostTweet(string text, string consumerKey, string consumerSecret, AccessTokenResponse response, PostTweetCallback callback)
		{
			string pos_lat = string.Empty;
			string pos_long = string.Empty;
			if (text.StartsWith("pos:"))
			{
				int startind = text.IndexOf(":") + 1;
				int endind = text.IndexOf(";");
				string ttext = text.Substring(startind, endind - startind);
				text = text.Substring(endind + 1);
				pos_lat = ttext.Split(new char[]
				{
					'/'
				})[0];
				pos_long = ttext.Split(new char[]
				{
					'/'
				})[1];
			}
			string replyto = string.Empty;
			if (text.StartsWith("replyto:"))
			{
				int startind2 = text.IndexOf(":") + 1;
				int endind2 = text.IndexOf(";");
				replyto = text.Substring(startind2, endind2 - startind2);
				text = text.Substring(endind2 + 1);
			}
			if (text.Length > 140)
			{
				Debug.LogWarning("tweet too long... cutting it off");
				text = text.Substring(0, 140);
			}
			if (string.IsNullOrEmpty(text) || text.Length > 140)
			{
				Debug.Log(string.Format("PostTweet - text[{0}] is empty or too long.", text));
				callback(false, string.Empty);
			}
			else
			{
				Dictionary<string, string> parameters = new Dictionary<string, string>();
				string url = string.Format(API.PostTweetURL, API.UrlEncode(text));
				parameters.Add("status", text);
				parameters.Add("include_entities", "true");
				if (replyto != string.Empty)
				{
					string turl = url + "&in_reply_to_status_id={0}";
					url = string.Format(turl, API.UrlEncode(replyto));
					parameters.Add("in_reply_to_status_id", replyto);
				}
				if (pos_lat != string.Empty && pos_long != string.Empty)
				{
					string turl2 = url + "&lat={0}&long={1}&display_coordinates=true";
					url = string.Format(turl2, API.UrlEncode(pos_lat), API.UrlEncode(pos_long));
					parameters.Add("display_coordinates", "true");
					parameters.Add("lat", pos_lat);
					parameters.Add("long", pos_long);
				}
				else if (TwitterDemo.has_coord_pos)
				{
					string turl3 = url + "&lat={0}&long={1}&display_coordinates=true";
					url = string.Format(turl3, API.UrlEncode(TwitterDemo.pos_lat), API.UrlEncode(TwitterDemo.pos_long));
					parameters.Add("display_coordinates", "true");
					parameters.Add("lat", TwitterDemo.pos_lat);
					parameters.Add("long", TwitterDemo.pos_long);
				}
				byte[] dummmy = new byte[]
				{
					0
				};
				Hashtable headers = new Hashtable();
				headers["Authorization"] = API.GetHeaderWithAccessToken("POST", url, consumerKey, consumerSecret, response, parameters);
				WWW web = new WWW(url, dummmy, headers);
				yield return web;
				if (!string.IsNullOrEmpty(web.error))
				{
					Debug.Log(string.Format("PostTweet - failed. {0}", web.error));
					callback(false, string.Empty);
				}
				else
				{
					string error = Regex.Match(web.text, "<error>([^&]+)</error>").Groups[1].Value;
					if (!string.IsNullOrEmpty(error))
					{
						Debug.Log(string.Format("PostTweet - failed. {0}", error));
						callback(false, web.text);
					}
					else
					{
						callback(true, web.text);
					}
				}
			}
			yield break;
		}

		// Token: 0x0600062C RID: 1580 RVA: 0x000278DC File Offset: 0x00025ADC
		public static IEnumerator GetSearchResults(string search, GetMentionsCallback callback)
		{
			Dictionary<string, string> parameters = new Dictionary<string, string>();
			string url = API.GetSearchResultsURL;
			url = url + "?q=" + API.UrlEncode(search);
			url += "&include_entities=true";
			Debug.Log(url);
			Request req = new Request("get", url);
			req.Send();
			while (!req.isDone)
			{
				yield return null;
			}
			yield return null;
			Response res = req.response;
			if (res == null)
			{
				Debug.LogWarning("Hey! The twitter response is null!");
				return 0;
			}
			if (res.status != 200)
			{
				Debug.Log(string.Concat(new object[]
				{
					"Twitter Search - failed - ",
					res.message,
					" - ",
					res.status
				}));
				callback(false, null);
			}
			else
			{
				callback(true, res.Text);
			}
			yield break;
		}

		// Token: 0x0600062D RID: 1581 RVA: 0x0002790C File Offset: 0x00025B0C
		public static IEnumerator GetSingleTweet(string tweet_id, GetMentionsCallback callback)
		{
			Dictionary<string, string> parameters = new Dictionary<string, string>();
			string url = API.GetSingleTweetURL;
			url = string.Format(url, API.UrlEncode(tweet_id));
			Debug.Log(url);
			Request req = new Request("get", url);
			req.Send();
			while (!req.isDone)
			{
				yield return null;
			}
			yield return null;
			Response res = req.response;
			if (res == null)
			{
				Debug.LogWarning("Hey! The twitter response is null!");
				return 0;
			}
			if (res.status != 200)
			{
				Debug.Log(string.Concat(new object[]
				{
					"Twitter Search - failed - ",
					res.message,
					" - ",
					res.status
				}));
				callback(false, null);
			}
			else
			{
				callback(true, res.Text);
			}
			yield break;
		}

		// Token: 0x0600062E RID: 1582 RVA: 0x0002793C File Offset: 0x00025B3C
		public static IEnumerator GetMentions(string consumerKey, string consumerSecret, AccessTokenResponse response, GetMentionsCallback callback)
		{
			return API.GenericGetTweets(API.GetMentionsURL, consumerKey, consumerSecret, response, callback);
		}

		// Token: 0x0600062F RID: 1583 RVA: 0x0002794C File Offset: 0x00025B4C
		public static IEnumerator GetTimeLine(string consumerKey, string consumerSecret, AccessTokenResponse response, GetMentionsCallback callback)
		{
			return API.GenericGetTweets(API.GetTimeLineURL, consumerKey, consumerSecret, response, callback);
		}

		// Token: 0x06000630 RID: 1584 RVA: 0x0002795C File Offset: 0x00025B5C
		public static IEnumerator GenericGetTweets(string url, string consumerKey, string consumerSecret, AccessTokenResponse response, GetMentionsCallback callback)
		{
			Dictionary<string, string> parameters = new Dictionary<string, string>();
			if (url.Contains("?"))
			{
				url += "&";
			}
			else
			{
				url += "?";
			}
			url += "include_entities=true";
			parameters.Add("include_entities", "true");
			if (TwitterDemo.newest_id > 0UL && !url.StartsWith(API.GetMentionsURL))
			{
				string id_str = API.UrlEncode(TwitterDemo.newest_id.ToString("F0"));
				url = url + "&since_id=" + id_str;
				parameters.Add("since_id", id_str);
			}
			Request req = new Request("get", url);
			req.AddHeader("Authorization", API.GetHeaderWithAccessToken("GET", url, consumerKey, consumerSecret, response, parameters));
			req.Send();
			while (!req.isDone)
			{
				yield return null;
			}
			yield return null;
			Response res = req.response;
			if (res == null)
			{
				Debug.LogWarning("Hey! The twitter response is null!");
				return 0;
			}
			if (res.status != 200)
			{
				Debug.Log(string.Concat(new object[]
				{
					"GetMentions - failed - ",
					res.message,
					" - ",
					res.status
				}));
				callback(false, null);
			}
			else
			{
				callback(true, res.Text);
			}
			yield break;
		}

		// Token: 0x06000631 RID: 1585 RVA: 0x000279B8 File Offset: 0x00025BB8
		public static IEnumerator UploadImage(GetMentionsCallback callback)
		{
			yield return new WaitForEndOfFrame();
			int width = Screen.width;
			int height = Screen.height;
			Texture2D tex = new Texture2D(width, height, TextureFormat.RGB24, false);
			tex.ReadPixels(new Rect(0f, 0f, (float)width, (float)height), 0, 0);
			tex.Apply();
			byte[] bytes = tex.EncodeToPNG();
			yield return null;
			UnityEngine.Object.Destroy(tex);
			WWWForm form = new WWWForm();
			form.AddField("key", API.imgur_key);
			form.AddBinaryData("image", bytes, "test.png");
			WWW web = new WWW(API.imgur_url, form);
			yield return web;
			if (web.error != null)
			{
				callback(false, web.error);
			}
			else
			{
				callback(true, web.text);
			}
			yield break;
		}

		// Token: 0x06000632 RID: 1586 RVA: 0x000279DC File Offset: 0x00025BDC
		public static IEnumerator UploadImage(Texture2D tex, GetMentionsCallback callback)
		{
			byte[] bytes = tex.EncodeToPNG();
			yield return null;
			UnityEngine.Object.Destroy(tex);
			WWWForm form = new WWWForm();
			form.AddField("key", API.imgur_key);
			form.AddBinaryData("image", bytes, "test.png");
			WWW web = new WWW(API.imgur_url, form);
			yield return web;
			if (web.error != null)
			{
				callback(false, web.error);
			}
			else
			{
				callback(true, web.text);
			}
			yield break;
		}

		// Token: 0x06000633 RID: 1587 RVA: 0x00027A0C File Offset: 0x00025C0C
		public static IEnumerator UploadImage(TweetContext tweet, TweetContextCallback callback)
		{
			if (tweet.texture == null)
			{
				int width = Screen.width;
				int height = Screen.height;
				yield return new WaitForEndOfFrame();
				tweet.texture = new Texture2D(width, height, TextureFormat.RGB24, false);
				tweet.texture.ReadPixels(new Rect(0f, 0f, (float)width, (float)height), 0, 0);
				tweet.texture.Apply();
				List<NetPlayer> players = PhoneCamControl.GetPlayersInView(Camera.main);
				foreach (NetPlayer player in players)
				{
					string nam = player.userName;
					if (nam.Contains(" "))
					{
						nam = "gamsfest";
					}
					if (!tweet.mentions.Contains(nam))
					{
						tweet.mentions.Add(nam);
					}
				}
				yield return null;
			}
			byte[] bytes = tweet.texture.EncodeToPNG();
			yield return null;
			UnityEngine.Object.Destroy(tweet.texture);
			WWWForm form = new WWWForm();
			form.AddField("key", API.imgur_key);
			form.AddBinaryData("image", bytes, "test.png");
			WWW web = new WWW(API.imgur_url, form);
			yield return web;
			if (web.error != null)
			{
				callback(false, web.error, tweet);
			}
			else
			{
				callback(true, web.text, tweet);
			}
			yield break;
		}

		// Token: 0x06000634 RID: 1588 RVA: 0x00027A3C File Offset: 0x00025C3C
		private static void AddDefaultOAuthParams(Dictionary<string, string> parameters, string consumerKey, string consumerSecret)
		{
			parameters.Add("oauth_version", "1.0");
			parameters.Add("oauth_nonce", API.GenerateNonce());
			parameters.Add("oauth_timestamp", API.GenerateTimeStamp());
			parameters.Add("oauth_signature_method", "HMAC-SHA1");
			parameters.Add("oauth_consumer_key", consumerKey);
			parameters.Add("oauth_consumer_secret", consumerSecret);
		}

		// Token: 0x06000635 RID: 1589 RVA: 0x00027AA4 File Offset: 0x00025CA4
		private static string GetFinalOAuthHeader(string HTTPRequestType, string URL, Dictionary<string, string> parameters)
		{
			string value = API.GenerateSignature(HTTPRequestType, URL, parameters);
			parameters.Add("oauth_signature", value);
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendFormat("OAuth realm=\"{0}\"", "Twitter API");
			IOrderedEnumerable<KeyValuePair<string, string>> orderedEnumerable = from p in parameters
			where API.OAuthParametersToIncludeInHeader.Contains(p.Key)
			orderby p.Key, API.UrlEncode(p.Value)
			select p;
			foreach (KeyValuePair<string, string> keyValuePair in orderedEnumerable)
			{
				stringBuilder.AppendFormat(",{0}=\"{1}\"", API.UrlEncode(keyValuePair.Key), API.UrlEncode(keyValuePair.Value));
			}
			stringBuilder.AppendFormat(",oauth_signature=\"{0}\"", API.UrlEncode(parameters["oauth_signature"]));
			return stringBuilder.ToString();
		}

		// Token: 0x06000636 RID: 1590 RVA: 0x00027BDC File Offset: 0x00025DDC
		private static string GenerateSignature(string httpMethod, string url, Dictionary<string, string> parameters)
		{
			IEnumerable<KeyValuePair<string, string>> parameters2 = from p in parameters
			where !API.SecretParameters.Contains(p.Key)
			select p;
			string s = string.Format(CultureInfo.InvariantCulture, "{0}&{1}&{2}", new object[]
			{
				httpMethod,
				API.UrlEncode(API.NormalizeUrl(new Uri(url))),
				API.UrlEncode(parameters2)
			});
			string s2 = string.Format(CultureInfo.InvariantCulture, "{0}&{1}", new object[]
			{
				API.UrlEncode(parameters["oauth_consumer_secret"]),
				(!parameters.ContainsKey("oauth_token_secret")) ? string.Empty : API.UrlEncode(parameters["oauth_token_secret"])
			});
			HMACSHA1 hmacsha = new HMACSHA1(Encoding.ASCII.GetBytes(s2));
			byte[] inArray = hmacsha.ComputeHash(Encoding.ASCII.GetBytes(s));
			return Convert.ToBase64String(inArray);
		}

		// Token: 0x06000637 RID: 1591 RVA: 0x00027CC4 File Offset: 0x00025EC4
		private static string GenerateTimeStamp()
		{
			return Convert.ToInt64((DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0)).TotalSeconds, CultureInfo.CurrentCulture).ToString(CultureInfo.CurrentCulture);
		}

		// Token: 0x06000638 RID: 1592 RVA: 0x00027D10 File Offset: 0x00025F10
		private static string GenerateNonce()
		{
			return new System.Random().Next(123400, int.MaxValue).ToString("X", CultureInfo.InvariantCulture);
		}

		// Token: 0x06000639 RID: 1593 RVA: 0x00027D44 File Offset: 0x00025F44
		private static string NormalizeUrl(Uri url)
		{
			string text = string.Format(CultureInfo.InvariantCulture, "{0}://{1}", new object[]
			{
				url.Scheme,
				url.Host
			});
			if ((!(url.Scheme == "http") || url.Port != 80) && (!(url.Scheme == "https") || url.Port != 443))
			{
				text = text + ":" + url.Port;
			}
			return text + url.AbsolutePath;
		}

		// Token: 0x0600063A RID: 1594 RVA: 0x00027DE8 File Offset: 0x00025FE8
		public static string UrlEncode(string value)
		{
			if (string.IsNullOrEmpty(value))
			{
				return string.Empty;
			}
			value = Uri.EscapeDataString(value);
			value = Regex.Replace(value, "(%[0-9a-f][0-9a-f])", (Match c) => c.Value.ToUpper());
			value = value.Replace("(", "%28").Replace(")", "%29").Replace("$", "%24").Replace("!", "%21").Replace("*", "%2A").Replace("'", "%27");
			value = value.Replace("%7E", "~");
			return value;
		}

		// Token: 0x0600063B RID: 1595 RVA: 0x00027EA8 File Offset: 0x000260A8
		private static string UrlEncode(IEnumerable<KeyValuePair<string, string>> parameters)
		{
			StringBuilder stringBuilder = new StringBuilder();
			IOrderedEnumerable<KeyValuePair<string, string>> orderedEnumerable = from p in parameters
			orderby p.Key, p.Value
			select p;
			foreach (KeyValuePair<string, string> keyValuePair in orderedEnumerable)
			{
				if (stringBuilder.Length > 0)
				{
					stringBuilder.Append("&");
				}
				stringBuilder.Append(string.Format(CultureInfo.InvariantCulture, "{0}={1}", new object[]
				{
					API.UrlEncode(keyValuePair.Key),
					API.UrlEncode(keyValuePair.Value)
				}));
			}
			return API.UrlEncode(stringBuilder.ToString());
		}

		// Token: 0x040004DD RID: 1245
		private static readonly string RequestTokenURL = "https://api.twitter.com/oauth/request_token?oauth_callback=oob";

		// Token: 0x040004DE RID: 1246
		private static readonly string AuthorizationURL = "http://api.twitter.com/oauth/authorize?oauth_token={0}";

		// Token: 0x040004DF RID: 1247
		private static readonly string AccessTokenURL = "https://api.twitter.com/oauth/access_token";

		// Token: 0x040004E0 RID: 1248
		private static readonly string PostTweetURL = "http://api.twitter.com/1/statuses/update.xml?status={0}&include_entities=true";

		// Token: 0x040004E1 RID: 1249
		private static readonly string GetSearchResultsURL = "http://search.twitter.com/search.atom";

		// Token: 0x040004E2 RID: 1250
		private static readonly string GetSingleTweetURL = "http://api.twitter.com/1/statuses/show.xml?id={0}&include_entities=true";

		// Token: 0x040004E3 RID: 1251
		private static readonly string GetMentionsURL = "http://api.twitter.com/1/statuses/mentions.xml";

		// Token: 0x040004E4 RID: 1252
		private static readonly string GetTimeLineURL = "http://api.twitter.com/1/statuses/home_timeline.xml";

		// Token: 0x040004E5 RID: 1253
		private static readonly string imgur_key = "7578d06f2ac1c6e904c4775db47b2984";

		// Token: 0x040004E6 RID: 1254
		private static readonly string imgur_url = "http://api.imgur.com/2/upload.xml";

		// Token: 0x040004E7 RID: 1255
		private static readonly string[] OAuthParametersToIncludeInHeader = new string[]
		{
			"oauth_version",
			"oauth_nonce",
			"oauth_timestamp",
			"oauth_signature_method",
			"oauth_consumer_key",
			"oauth_token",
			"oauth_verifier"
		};

		// Token: 0x040004E8 RID: 1256
		private static readonly string[] SecretParameters = new string[]
		{
			"oauth_consumer_secret",
			"oauth_token_secret",
			"oauth_signature"
		};
	}
}
