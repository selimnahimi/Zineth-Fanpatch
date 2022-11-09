using System;
using System.Collections;
using System.Collections.Generic;
using Twitter;
using UnityEngine;

// Token: 0x02000096 RID: 150
public class TwitterDemo : MonoBehaviour
{
	// Token: 0x170000CF RID: 207
	// (get) Token: 0x0600064F RID: 1615 RVA: 0x00028A3C File Offset: 0x00026C3C
	public static TwitterDemo instance
	{
		get
		{
			if (TwitterDemo._instance == null)
			{
				TwitterDemo._instance = (UnityEngine.Object.FindObjectOfType(typeof(TwitterDemo)) as TwitterDemo);
			}
			return TwitterDemo._instance;
		}
	}

	// Token: 0x06000650 RID: 1616 RVA: 0x00028A78 File Offset: 0x00026C78
	public static bool PostTweet(string tweet)
	{
		TwitterDemo.instance.DoPostTweet(tweet);
		return true;
	}

	// Token: 0x06000651 RID: 1617 RVA: 0x00028A88 File Offset: 0x00026C88
	public static bool PostTweet(string tweet, PostTweetCallback callback)
	{
		TwitterDemo.instance.DoPostTweet(tweet, callback);
		return true;
	}

	// Token: 0x06000652 RID: 1618 RVA: 0x00028A98 File Offset: 0x00026C98
	public static bool GetMentions()
	{
		TwitterDemo.instance.DoGetMentions();
		return true;
	}

	// Token: 0x06000653 RID: 1619 RVA: 0x00028AA8 File Offset: 0x00026CA8
	public static bool GetTimeLine()
	{
		TwitterDemo.instance.DoGetTimeLine();
		return true;
	}

	// Token: 0x06000654 RID: 1620 RVA: 0x00028AB8 File Offset: 0x00026CB8
	public static bool LogIn()
	{
		if (TwitterDemo.instance.LoadTwitterUserInfo(true))
		{
			return true;
		}
		TwitterDemo.RegisterUser();
		return false;
	}

	// Token: 0x06000655 RID: 1621 RVA: 0x00028AD4 File Offset: 0x00026CD4
	public static bool LogOut()
	{
		TwitterDemo.instance.LoadTwitterUserInfo(false);
		return true;
	}

	// Token: 0x06000656 RID: 1622 RVA: 0x00028AE4 File Offset: 0x00026CE4
	public static bool GetAccess(string pin)
	{
		TwitterDemo.instance.GetAccessToken(pin);
		return true;
	}

	// Token: 0x06000657 RID: 1623 RVA: 0x00028AF4 File Offset: 0x00026CF4
	public static bool RegisterUser()
	{
		TwitterDemo.instance.GetRequestToken();
		return true;
	}

	// Token: 0x170000D0 RID: 208
	// (get) Token: 0x06000658 RID: 1624 RVA: 0x00028B04 File Offset: 0x00026D04
	// (set) Token: 0x06000659 RID: 1625 RVA: 0x00028B10 File Offset: 0x00026D10
	public static bool has_coord_pos
	{
		get
		{
			return TwitterDemo.instance._has_coord_pos;
		}
		set
		{
			TwitterDemo.instance._has_coord_pos = value;
		}
	}

	// Token: 0x170000D1 RID: 209
	// (get) Token: 0x0600065A RID: 1626 RVA: 0x00028B20 File Offset: 0x00026D20
	// (set) Token: 0x0600065B RID: 1627 RVA: 0x00028B2C File Offset: 0x00026D2C
	public static string pos_lat
	{
		get
		{
			return TwitterDemo.instance._pos_lat;
		}
		set
		{
			TwitterDemo.instance._pos_lat = value;
		}
	}

	// Token: 0x170000D2 RID: 210
	// (get) Token: 0x0600065C RID: 1628 RVA: 0x00028B3C File Offset: 0x00026D3C
	// (set) Token: 0x0600065D RID: 1629 RVA: 0x00028B48 File Offset: 0x00026D48
	public static string pos_long
	{
		get
		{
			return TwitterDemo.instance._pos_long;
		}
		set
		{
			TwitterDemo.instance._pos_long = value;
		}
	}

	// Token: 0x0600065E RID: 1630 RVA: 0x00028B58 File Offset: 0x00026D58
	private void Awake()
	{
		base.useGUILayout = false;
	}

	// Token: 0x0600065F RID: 1631 RVA: 0x00028B64 File Offset: 0x00026D64
	private void Start()
	{
		if (Application.isWebPlayer)
		{
			return;
		}
		TwitterDemo.registercallback = new TwitterDemo.RegisterCallBack(this.OnRegister);
		this.start_time = DateTime.Now;
		if (!string.IsNullOrEmpty(PlayerPrefs.GetString("TwitterUserID", string.Empty)))
		{
			this.LoadTwitterUserInfo(false);
		}
		else
		{
			this.LoadTwitterUserInfo(true);
		}
	}

	// Token: 0x170000D3 RID: 211
	// (get) Token: 0x06000660 RID: 1632 RVA: 0x00028BC8 File Offset: 0x00026DC8
	// (set) Token: 0x06000661 RID: 1633 RVA: 0x00028BD0 File Offset: 0x00026DD0
	public bool draw_gui
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

	// Token: 0x06000662 RID: 1634 RVA: 0x00028BDC File Offset: 0x00026DDC
	private void OnGUI()
	{
		if (!this.draw_gui)
		{
			return;
		}
		Rect position = new Rect((float)Screen.width * this.USER_LOG_IN_X, (float)Screen.height * this.USER_LOG_IN_Y, (float)Screen.width * this.USER_LOG_IN_WIDTH, (float)Screen.height * this.USER_LOG_IN_HEIGHT);
		if (string.IsNullOrEmpty(this.CONSUMER_KEY) || string.IsNullOrEmpty(this.CONSUMER_SECRET))
		{
			string text = "You need to register your game or application first.\n Click this button, register and fill CONSUMER_KEY and CONSUMER_SECRET of Demo game object.";
			if (GUI.Button(position, text))
			{
				Application.OpenURL("http://dev.twitter.com/apps/new");
			}
		}
		else
		{
			string text2 = string.Empty;
			if (!string.IsNullOrEmpty(this.m_AccessTokenResponse.ScreenName))
			{
				text2 = this.m_AccessTokenResponse.ScreenName + "\nClick to register with a different Twitter account";
			}
			else
			{
				text2 = "You need to register your game or application first.";
			}
			if (GUI.Button(position, text2))
			{
				base.StartCoroutine(API.GetRequestToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, new RequestTokenCallback(this.OnRequestTokenCallback)));
			}
		}
		position.x = (float)Screen.width * this.PIN_INPUT_X;
		position.y = (float)Screen.height * this.PIN_INPUT_Y;
		position.width = (float)Screen.width * this.PIN_INPUT_WIDTH;
		position.height = (float)Screen.height * this.PIN_INPUT_HEIGHT;
		this.m_PIN = GUI.TextField(position, this.m_PIN);
		position.x = (float)Screen.width * this.PIN_ENTER_X;
		position.y = (float)Screen.height * this.PIN_ENTER_Y;
		position.width = (float)Screen.width * this.PIN_ENTER_WIDTH;
		position.height = (float)Screen.height * this.PIN_ENTER_HEIGHT;
		if (GUI.Button(position, "Enter PIN"))
		{
			base.StartCoroutine(API.GetAccessToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, this.m_RequestTokenResponse.Token, this.m_PIN, new AccessTokenCallback(this.OnAccessTokenCallback)));
		}
		position.x = (float)Screen.width * this.TWEET_INPUT_X;
		position.y = (float)Screen.height * this.TWEET_INPUT_Y;
		position.width = (float)Screen.width * this.TWEET_INPUT_WIDTH;
		position.height = (float)Screen.height * this.TWEET_INPUT_HEIGHT;
		this.m_Tweet = GUI.TextField(position, this.m_Tweet);
		position.x = (float)Screen.width * this.POST_TWEET_X;
		position.y = (float)Screen.height * this.POST_TWEET_Y;
		position.width = (float)Screen.width * this.POST_TWEET_WIDTH;
		position.height = (float)Screen.height * this.POST_TWEET_HEIGHT;
		if (GUI.Button(position, "Post Tweet"))
		{
			this.DoPostTweet(this.m_Tweet);
		}
		position.y += this.POST_TWEET_HEIGHT * (float)Screen.height;
		if (GUI.Button(position, "Get Mentions"))
		{
			this.DoGetMentions();
		}
		GUILayout.BeginHorizontal("Box", new GUILayoutOption[0]);
		this.searchstring = GUILayout.TextField(this.searchstring, new GUILayoutOption[]
		{
			GUILayout.MinWidth(120f)
		});
		if (GUILayout.Button("Search!", new GUILayoutOption[0]))
		{
			this.DoGetSearchResults(this.searchstring);
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal("Box", new GUILayoutOption[0]);
		this.tweetstring = GUILayout.TextField(this.tweetstring, new GUILayoutOption[]
		{
			GUILayout.MinWidth(120f)
		});
		if (GUILayout.Button("Tweet", new GUILayoutOption[0]))
		{
			this.DoPostTweet(this.tweetstring);
		}
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		if (GUILayout.Button("sign out", new GUILayoutOption[0]))
		{
			TwitterDemo.LogIn();
		}
		if (GUILayout.Button("post a neat pic", new GUILayoutOption[0]))
		{
			base.StartCoroutine(API.UploadImage(new GetMentionsCallback(this.OnPostImage)));
		}
		GUILayout.FlexibleSpace();
		GUILayout.EndHorizontal();
	}

	// Token: 0x06000663 RID: 1635 RVA: 0x00028FF0 File Offset: 0x000271F0
	public void GetRequestToken()
	{
		base.StartCoroutine(API.GetRequestToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, new RequestTokenCallback(this.OnRequestTokenCallback)));
	}

	// Token: 0x06000664 RID: 1636 RVA: 0x00029024 File Offset: 0x00027224
	public void GetAccessToken()
	{
		this.GetAccessToken(this.m_PIN);
	}

	// Token: 0x06000665 RID: 1637 RVA: 0x00029034 File Offset: 0x00027234
	public void GetAccessToken(string pin)
	{
		base.StartCoroutine(API.GetAccessToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, this.m_RequestTokenResponse.Token, pin, new AccessTokenCallback(this.OnAccessTokenCallback)));
	}

	// Token: 0x06000666 RID: 1638 RVA: 0x00029074 File Offset: 0x00027274
	public void GetAccessToken(TwitterDemo.TwitterUser user)
	{
		base.StartCoroutine(API.GetAccessToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, user.m_RequestTokenResponse.Token, user.pin, new AccessTokenCallback(this.OnAccessTokenCallback)));
	}

	// Token: 0x06000667 RID: 1639 RVA: 0x000290B8 File Offset: 0x000272B8
	public void GetAccessToken(string pin, TwitterDemo.TwitterUser user)
	{
		base.StartCoroutine(API.GetAccessToken(this.CONSUMER_KEY, this.CONSUMER_SECRET, user.m_RequestTokenResponse.Token, pin, new AccessTokenCallback(this.OnAccessTokenCallback)));
	}

	// Token: 0x06000668 RID: 1640 RVA: 0x000290F8 File Offset: 0x000272F8
	public void DoPostScreenshot()
	{
		if (!this._canTweet)
		{
			Debug.LogWarning("tried to tweet but not allowed...");
			return;
		}
		base.StartCoroutine(API.UploadImage(new TweetContext(), new TweetContextCallback(this.OnPostImage)));
	}

	// Token: 0x06000669 RID: 1641 RVA: 0x00029130 File Offset: 0x00027330
	public void DoPostImage(TweetContext tweet)
	{
		if (!this._canTweet)
		{
			Debug.LogWarning("tried to tweet but not allowed...");
			return;
		}
		base.StartCoroutine(API.UploadImage(tweet, new TweetContextCallback(this.OnPostImage)));
	}

	// Token: 0x0600066A RID: 1642 RVA: 0x00029164 File Offset: 0x00027364
	public void DoPostImage(Texture2D tex)
	{
		if (!this._canTweet)
		{
			Debug.LogWarning("tried to tweet but not allowed...");
			return;
		}
		base.StartCoroutine(API.UploadImage(tex, new GetMentionsCallback(this.OnPostImage)));
	}

	// Token: 0x0600066B RID: 1643 RVA: 0x00029198 File Offset: 0x00027398
	public void DoPostTweet(string tweet, TwitterDemo.TwitterUser user)
	{
		if (!this._canTweet)
		{
			Debug.LogWarning("tried to tweet but not allowed...");
			return;
		}
		tweet = this.AddHashTag(tweet);
		base.StartCoroutine(API.PostTweet(tweet, this.CONSUMER_KEY, this.CONSUMER_SECRET, user.m_AccessTokenResponse, new PostTweetCallback(this.OnPostTweet)));
	}

	// Token: 0x0600066C RID: 1644 RVA: 0x000291F0 File Offset: 0x000273F0
	public void DoPostTweet(string tweet)
	{
		if (!this._canTweet)
		{
			Debug.LogWarning("tried to tweet but not allowed...");
			return;
		}
		tweet = this.AddHashTag(tweet);
		if (Application.isEditor)
		{
			Debug.Log(tweet);
		}
		base.StartCoroutine(API.PostTweet(tweet, this.CONSUMER_KEY, this.CONSUMER_SECRET, this.m_AccessTokenResponse, new PostTweetCallback(this.OnPostTweet)));
	}

	// Token: 0x0600066D RID: 1645 RVA: 0x00029258 File Offset: 0x00027458
	public void DoPostTweet(string tweet, PostTweetCallback callback)
	{
		base.StartCoroutine(API.PostTweet(tweet, this.CONSUMER_KEY, this.CONSUMER_SECRET, this.m_AccessTokenResponse, callback));
	}

	// Token: 0x0600066E RID: 1646 RVA: 0x00029288 File Offset: 0x00027488
	public void DoGetMentions()
	{
		this.DoGetMentions(this.m_AccessTokenResponse);
	}

	// Token: 0x0600066F RID: 1647 RVA: 0x00029298 File Offset: 0x00027498
	public void DoGetMentions(TwitterDemo.TwitterUser user)
	{
		this.DoGetMentions(user.m_AccessTokenResponse);
	}

	// Token: 0x06000670 RID: 1648 RVA: 0x000292A8 File Offset: 0x000274A8
	public void DoGetMentions(AccessTokenResponse accessTokenResponse)
	{
		base.StartCoroutine(API.GetMentions(this.CONSUMER_KEY, this.CONSUMER_SECRET, accessTokenResponse, new GetMentionsCallback(this.OnGetMentions)));
		base.CancelInvoke("DoGetMentions");
	}

	// Token: 0x170000D4 RID: 212
	// (get) Token: 0x06000671 RID: 1649 RVA: 0x000292E8 File Offset: 0x000274E8
	public bool is_allowed
	{
		get
		{
			return PhoneMemory.settings.allow_twitter && !Application.isWebPlayer;
		}
	}

	// Token: 0x170000D5 RID: 213
	// (get) Token: 0x06000672 RID: 1650 RVA: 0x00029304 File Offset: 0x00027504
	public bool should_get_timeline
	{
		get
		{
			return PhoneMemory.IsMenuUnlocked("Twitter");
		}
	}

	// Token: 0x06000673 RID: 1651 RVA: 0x00029310 File Offset: 0x00027510
	public void DoGetSingleTweet(string tweet_id)
	{
		base.StartCoroutine(API.GetSingleTweet(tweet_id, new GetMentionsCallback(this.OnGetSingleTweet)));
	}

	// Token: 0x06000674 RID: 1652 RVA: 0x0002932C File Offset: 0x0002752C
	public void DoGetSearchResults(string search)
	{
		base.StartCoroutine(API.GetSearchResults(search, new GetMentionsCallback(this.OnGetSearchResults)));
	}

	// Token: 0x06000675 RID: 1653 RVA: 0x00029348 File Offset: 0x00027548
	public void DoGetTimeLine()
	{
		this.DoGetTimeLine(this.m_AccessTokenResponse);
	}

	// Token: 0x06000676 RID: 1654 RVA: 0x00029358 File Offset: 0x00027558
	public void DoGetTimeLine(TwitterDemo.TwitterUser user)
	{
		this.DoGetTimeLine(user.m_AccessTokenResponse);
	}

	// Token: 0x06000677 RID: 1655 RVA: 0x00029368 File Offset: 0x00027568
	public void DoGetTimeLine(AccessTokenResponse accessTokenResponse)
	{
		if (this.is_allowed)
		{
			if (this.should_get_timeline || !this._hasgottimeline)
			{
				base.StartCoroutine(API.GetTimeLine(this.CONSUMER_KEY, this.CONSUMER_SECRET, accessTokenResponse, new GetMentionsCallback(this.OnGetTimeLine)));
			}
			if (this.get_mentions_with_timeline)
			{
				this.DoGetMentions();
			}
		}
		base.CancelInvoke("DoGetTimeLine");
		base.Invoke("DoGetTimeLine", this.timeline_refresh_countdown);
	}

	// Token: 0x06000678 RID: 1656 RVA: 0x000293E8 File Offset: 0x000275E8
	public string GetCurrentUserId()
	{
		return this.m_AccessTokenResponse.UserId;
	}

	// Token: 0x06000679 RID: 1657 RVA: 0x000293F8 File Offset: 0x000275F8
	public string GetCurrentScreenName()
	{
		return this.m_AccessTokenResponse.ScreenName;
	}

	// Token: 0x0600067A RID: 1658 RVA: 0x00029408 File Offset: 0x00027608
	public string GetCustomScreenName()
	{
		if (this._customScreenName == null)
		{
			this._customScreenName = PlayerPrefs.GetString("PLAYER_PREFS_TWITTER_USER_ID", string.Empty);
		}
		return this._customScreenName;
	}

	// Token: 0x170000D6 RID: 214
	// (get) Token: 0x0600067B RID: 1659 RVA: 0x0002943C File Offset: 0x0002763C
	public bool _isCustom
	{
		get
		{
			return this.GetCurrentScreenName() != "gamsfest";
		}
	}

	// Token: 0x170000D7 RID: 215
	// (get) Token: 0x0600067C RID: 1660 RVA: 0x00029450 File Offset: 0x00027650
	public bool _canTweet
	{
		get
		{
			return !TwitterDemo.requireCustom || this._isCustom || Application.isEditor;
		}
	}

	// Token: 0x0600067D RID: 1661 RVA: 0x00029470 File Offset: 0x00027670
	public bool LoadTwitterUserInfo()
	{
		return this.LoadTwitterUserInfo(this.use_hardcoded_account);
	}

	// Token: 0x0600067E RID: 1662 RVA: 0x00029480 File Offset: 0x00027680
	public bool LoadTwitterUserInfo(bool hardcoded)
	{
		this.m_AccessTokenResponse = new AccessTokenResponse();
		if (hardcoded)
		{
			this.m_AccessTokenResponse.UserId = "538760177";
			this.m_AccessTokenResponse.ScreenName = "gamsfest";
			this.m_AccessTokenResponse.Token = "538760177-KvksxG9svWIzEfjtQJANhfQchOUK1iGV1NI8KkCp";
			this.m_AccessTokenResponse.TokenSecret = "K6n5IVguaBVF2Ik9yqw2qkNWNGXmfgGfwnzTnq3Uzg";
		}
		else
		{
			this.m_AccessTokenResponse.UserId = PlayerPrefs.GetString("TwitterUserID");
			this.m_AccessTokenResponse.ScreenName = PlayerPrefs.GetString("TwitterUserScreenName");
			this.m_AccessTokenResponse.Token = PlayerPrefs.GetString("TwitterUserToken");
			this.m_AccessTokenResponse.TokenSecret = PlayerPrefs.GetString("TwitterUserTokenSecret");
			this._customScreenName = this.m_AccessTokenResponse.ScreenName;
		}
		if (!string.IsNullOrEmpty(this.m_AccessTokenResponse.Token) && !string.IsNullOrEmpty(this.m_AccessTokenResponse.ScreenName) && !string.IsNullOrEmpty(this.m_AccessTokenResponse.Token) && !string.IsNullOrEmpty(this.m_AccessTokenResponse.TokenSecret))
		{
			string str = "LoadTwitterUserInfo - succeeded";
			str = str + "\n    UserId : " + this.m_AccessTokenResponse.UserId;
			str = str + "\n    ScreenName : " + this.m_AccessTokenResponse.ScreenName;
			this.twitter_messages.Clear();
			this.newtweets = 0;
			this.updated = true;
			TwitterDemo.newest_id = 0UL;
			this.DoGetTimeLine();
			return true;
		}
		return false;
	}

	// Token: 0x0600067F RID: 1663 RVA: 0x000295FC File Offset: 0x000277FC
	private void OnRequestTokenCallback(bool success, RequestTokenResponse response)
	{
		if (success)
		{
			string message = "OnRequestTokenCallback - succeeded";
			if (Application.isEditor)
			{
				MonoBehaviour.print(message);
			}
			this.m_RequestTokenResponse = response;
			API.OpenAuthorizationPage(response.Token);
			this._isConnected = true;
		}
		else
		{
			MonoBehaviour.print("OnRequestTokenCallback - failed.");
			this._isConnected = false;
		}
	}

	// Token: 0x06000680 RID: 1664 RVA: 0x00029654 File Offset: 0x00027854
	public void OnRegister(bool success, string username)
	{
	}

	// Token: 0x06000681 RID: 1665 RVA: 0x00029658 File Offset: 0x00027858
	private void OnAccessTokenCallback(bool success, AccessTokenResponse response)
	{
		if (success)
		{
			string text = "OnAccessTokenCallback - succeeded";
			text = text + "\n    UserId : " + response.UserId;
			text = text + "\n    ScreenName : " + response.ScreenName;
			if (Application.isEditor)
			{
				MonoBehaviour.print(text);
			}
			this.m_AccessTokenResponse = response;
			PlayerPrefs.SetString("TwitterUserID", response.UserId);
			PlayerPrefs.SetString("TwitterUserScreenName", response.ScreenName);
			PlayerPrefs.SetString("TwitterUserToken", response.Token);
			PlayerPrefs.SetString("TwitterUserTokenSecret", response.TokenSecret);
			TwitterDemo.registercallback(true, response.ScreenName);
			this._isConnected = true;
			this.LoadTwitterUserInfo(false);
		}
		else
		{
			MonoBehaviour.print("OnAccessTokenCallback - failed.");
			TwitterDemo.registercallback(false, "FAILED TO REGISTER");
		}
	}

	// Token: 0x06000682 RID: 1666 RVA: 0x0002972C File Offset: 0x0002792C
	private void OnPostTweet(bool success, string text)
	{
		if (success)
		{
			this.OnGetTimeLine(success, text);
			this._isConnected = true;
		}
		else
		{
			MonoBehaviour.print("OnPostTweet - " + ((!success) ? "failed." : "succeeded."));
		}
	}

	// Token: 0x06000683 RID: 1667 RVA: 0x00029778 File Offset: 0x00027978
	private void OnGetMentions(bool success, string text)
	{
		MonoBehaviour.print("OnGetMentions - " + ((!success) ? "failed." : "succeeded."));
		if (success)
		{
			this._isConnected = true;
			List<PhoneMail> list = Parser.ParseToMail(text);
			foreach (PhoneMail phoneMail in list)
			{
				if (MailController.FindMail(phoneMail.id) == null && (phoneMail.body.StartsWith("@gamsfest ") || true))
				{
					string text2 = phoneMail.id.Replace("tw_", string.Empty);
					if (MailController.FindMail(text2) == null)
					{
						phoneMail.id = text2;
						string text3 = phoneMail.body.Replace("@gamsfest", string.Empty);
						text3 = text3.TrimStart(new char[]
						{
							' '
						});
						if (phoneMail.subject == "@gamsfest" || phoneMail.subject == "@The_Joke_Master")
						{
							if (phoneMail.time.CompareTo(this.start_time) > 0)
							{
								PhoneController.DoPhoneCommand(text3);
							}
							MailController.AddMail(phoneMail);
						}
						else
						{
							if (Application.isEditor)
							{
								MonoBehaviour.print(phoneMail.subject);
							}
							phoneMail.body = text3;
							MailController.AddMail(phoneMail);
							MailController.SendMail(phoneMail);
						}
					}
				}
			}
		}
	}

	// Token: 0x06000684 RID: 1668 RVA: 0x00029908 File Offset: 0x00027B08
	private void OnGetTimeLine(bool success, string text)
	{
		this._hasgottimeline = true;
		bool flag = this.updated;
		if (!success)
		{
			MonoBehaviour.print("OnGetTimeLine - " + ((!success) ? "failed." : "succeeded."));
		}
		if (success)
		{
			this._isConnected = true;
			List<PhoneMail> list = Parser.ParseToMail(text);
			list.Reverse();
			foreach (PhoneMail phoneMail in list)
			{
				if (!this.twitter_messages.Contains(phoneMail))
				{
					if (phoneMail.body.StartsWith("@gamsfest"))
					{
					}
					flag = true;
					this.newtweets++;
					this.twitter_messages.Insert(0, phoneMail);
					if (phoneMail.id_number > TwitterDemo.newest_id)
					{
						TwitterDemo.newest_id = phoneMail.id_number;
					}
				}
			}
		}
		this.updated = flag;
	}

	// Token: 0x06000685 RID: 1669 RVA: 0x00029A1C File Offset: 0x00027C1C
	private void OnGetSearchResults(bool success, string text)
	{
		if (!success)
		{
			MonoBehaviour.print("OnGetSearchResults - " + ((!success) ? "failed." : "succeeded."));
		}
		if (success)
		{
			Debug.Log(text);
			List<PhoneMail> list = Parser.ParseAtomToMail(text);
			list.Reverse();
			foreach (PhoneMail phoneMail in list)
			{
				MonoBehaviour.print(string.Concat(new object[]
				{
					phoneMail.sender,
					" - ",
					phoneMail.body,
					phoneMail.position
				}));
				if (phoneMail.position != Vector3.zero)
				{
					Debug.Log("looking up " + phoneMail.id);
					phoneMail.id.Replace("tw_", string.Empty);
					if (MailController.FindMail("tw_" + phoneMail.id) == null)
					{
						this.DoGetSingleTweet(phoneMail.id);
					}
					else if (MailController.FindMail("mail_tw_" + phoneMail.id) == null)
					{
						phoneMail.id = "mail_tw_" + phoneMail.id;
						MailController.AddMail(phoneMail);
						this.MakeMailObj(phoneMail);
					}
				}
			}
		}
	}

	// Token: 0x06000686 RID: 1670 RVA: 0x00029B9C File Offset: 0x00027D9C
	private void MakeMailObj(string id)
	{
		this.MakeMailObj(MailController.FindMail(id));
	}

	// Token: 0x06000687 RID: 1671 RVA: 0x00029BAC File Offset: 0x00027DAC
	private void MakeMailObj(PhoneMail mail)
	{
		Vector3 vector = mail.position + Vector3.up * 5f;
		Debug.Log("position: " + vector);
		GameObject gameObject = UnityEngine.Object.Instantiate(this.mail_obj, vector, Quaternion.identity) as GameObject;
		gameObject.GetComponent<DoCommandTrigger>().command_string = "mail_send " + mail.id;
	}

	// Token: 0x06000688 RID: 1672 RVA: 0x00029C1C File Offset: 0x00027E1C
	private void OnGetSingleTweet(bool success, string text)
	{
		this._isConnected = success;
		if (!success)
		{
			MonoBehaviour.print("OnGetSingleTweet - " + ((!success) ? "failed." : "succeeded."));
		}
		if (success)
		{
			Debug.Log(text);
			List<PhoneMail> list = Parser.ParseToMail(text);
			foreach (PhoneMail phoneMail in list)
			{
				if (phoneMail.position != Vector3.zero && MailController.FindMail("mail_" + phoneMail.id) == null)
				{
					phoneMail.id = "mail_" + phoneMail.id;
					MailController.AddMail(phoneMail);
					this.MakeMailObj(phoneMail);
				}
			}
		}
	}

	// Token: 0x06000689 RID: 1673 RVA: 0x00029D0C File Offset: 0x00027F0C
	private void OnPostImage(bool success, string text)
	{
		this._isConnected = success;
		if (!success)
		{
			Debug.LogWarning("OnPostImage-failed: " + text);
		}
		else
		{
			string text2 = Parser.ParseImgurResponse(text);
			if (text2 != string.Empty)
			{
				string text3 = text2;
				text3 = this.AddHashTag(text3);
				if (Application.loadedLevelName == "Loader 1")
				{
					text3 = "pos:" + PlaytomicController.TranslatePlayerPosToGPSString() + ";" + text3;
				}
				this.DoPostTweet(text3);
			}
		}
	}

	// Token: 0x0600068A RID: 1674 RVA: 0x00029D90 File Offset: 0x00027F90
	private void OnPostImage(bool success, string text, TweetContext tweet)
	{
		this._isConnected = success;
		if (!success)
		{
			Debug.LogWarning("OnPostImage-failed: " + text);
		}
		else
		{
			string text2 = Parser.ParseImgurResponse(text);
			if (text2 != string.Empty)
			{
				TweetContext tweetContext = tweet;
				tweetContext.text += text2;
				tweet.text = this.AddHashTag(tweet.text);
				this.AddMentions(ref tweet);
				if (Application.loadedLevelName == "Loader 1")
				{
					tweet.text = "pos:" + PlaytomicController.TranslatePlayerPosToGPSString() + ";" + tweet.text;
				}
				this.DoPostTweet(tweet.text);
			}
		}
	}

	// Token: 0x0600068B RID: 1675 RVA: 0x00029E44 File Offset: 0x00028044
	private string AddHashTag(string tweet)
	{
		if (!this.use_hash_tag)
		{
			return tweet;
		}
		if (tweet.Contains(TwitterDemo.hash_tag))
		{
			return tweet;
		}
		return string.Format("{0} {1}", tweet, TwitterDemo.hash_tag);
	}

	// Token: 0x0600068C RID: 1676 RVA: 0x00029E84 File Offset: 0x00028084
	private void AddMentions(ref TweetContext tweet)
	{
		foreach (string text in tweet.mentions)
		{
			string text2 = text;
			if (!text2.StartsWith("@"))
			{
				text2 = "@" + text2;
			}
			if (tweet.text.Length > 0)
			{
				TweetContext tweetContext = tweet;
				tweetContext.text = tweetContext.text + " " + text2;
			}
		}
	}

	// Token: 0x170000D8 RID: 216
	// (get) Token: 0x0600068D RID: 1677 RVA: 0x00029F2C File Offset: 0x0002812C
	private bool use_hash_tag
	{
		get
		{
			return this._use_hash_tag && !string.IsNullOrEmpty(TwitterDemo.hash_tag);
		}
	}

	// Token: 0x0600068E RID: 1678 RVA: 0x00029F4C File Offset: 0x0002814C
	private IEnumerator GetLocation(string ip)
	{
		string url = "http://api.ipinfodb.com/v3/ip-city/?key=7999984451273a720a4f8904a9b64991e4156211e893d394072602cd7f7c6657";
		WWW locweb = new WWW(url);
		yield return locweb;
		if (locweb.error == null)
		{
			string[] items = locweb.text.Split(new char[]
			{
				';'
			});
			string latitude = items[8];
			string longitude = items[9];
			TwitterDemo.has_coord_pos = true;
			TwitterDemo.pos_lat = latitude;
			TwitterDemo.pos_long = longitude;
		}
		else
		{
			Debug.LogWarning("could not get location: " + locweb.error);
		}
		yield break;
	}

	// Token: 0x040004F2 RID: 1266
	private const string PLAYER_PREFS_TWITTER_USER_ID = "TwitterUserID";

	// Token: 0x040004F3 RID: 1267
	private const string PLAYER_PREFS_TWITTER_USER_SCREEN_NAME = "TwitterUserScreenName";

	// Token: 0x040004F4 RID: 1268
	private const string PLAYER_PREFS_TWITTER_USER_TOKEN = "TwitterUserToken";

	// Token: 0x040004F5 RID: 1269
	private const string PLAYER_PREFS_TWITTER_USER_TOKEN_SECRET = "TwitterUserTokenSecret";

	// Token: 0x040004F6 RID: 1270
	private const string def_PLAYER_PREFS_TWITTER_USER_ID = "538760177";

	// Token: 0x040004F7 RID: 1271
	private const string def_PLAYER_PREFS_TWITTER_USER_SCREEN_NAME = "gamsfest";

	// Token: 0x040004F8 RID: 1272
	private const string def_PLAYER_PREFS_TWITTER_USER_TOKEN = "538760177-KvksxG9svWIzEfjtQJANhfQchOUK1iGV1NI8KkCp";

	// Token: 0x040004F9 RID: 1273
	private const string def_PLAYER_PREFS_TWITTER_USER_TOKEN_SECRET = "K6n5IVguaBVF2Ik9yqw2qkNWNGXmfgGfwnzTnq3Uzg";

	// Token: 0x040004FA RID: 1274
	private const string def_m_PIN = "1146604";

	// Token: 0x040004FB RID: 1275
	private static TwitterDemo _instance;

	// Token: 0x040004FC RID: 1276
	public float USER_LOG_IN_X;

	// Token: 0x040004FD RID: 1277
	public float USER_LOG_IN_Y;

	// Token: 0x040004FE RID: 1278
	public float USER_LOG_IN_WIDTH;

	// Token: 0x040004FF RID: 1279
	public float USER_LOG_IN_HEIGHT;

	// Token: 0x04000500 RID: 1280
	public float PIN_INPUT_X;

	// Token: 0x04000501 RID: 1281
	public float PIN_INPUT_Y;

	// Token: 0x04000502 RID: 1282
	public float PIN_INPUT_WIDTH;

	// Token: 0x04000503 RID: 1283
	public float PIN_INPUT_HEIGHT;

	// Token: 0x04000504 RID: 1284
	public float PIN_ENTER_X;

	// Token: 0x04000505 RID: 1285
	public float PIN_ENTER_Y;

	// Token: 0x04000506 RID: 1286
	public float PIN_ENTER_WIDTH;

	// Token: 0x04000507 RID: 1287
	public float PIN_ENTER_HEIGHT;

	// Token: 0x04000508 RID: 1288
	public float TWEET_INPUT_X;

	// Token: 0x04000509 RID: 1289
	public float TWEET_INPUT_Y;

	// Token: 0x0400050A RID: 1290
	public float TWEET_INPUT_WIDTH;

	// Token: 0x0400050B RID: 1291
	public float TWEET_INPUT_HEIGHT;

	// Token: 0x0400050C RID: 1292
	public float POST_TWEET_X;

	// Token: 0x0400050D RID: 1293
	public float POST_TWEET_Y;

	// Token: 0x0400050E RID: 1294
	public float POST_TWEET_WIDTH;

	// Token: 0x0400050F RID: 1295
	public float POST_TWEET_HEIGHT;

	// Token: 0x04000510 RID: 1296
	public string CONSUMER_KEY = "1CwngTBK8ruSsXscdc42ZQ";

	// Token: 0x04000511 RID: 1297
	public string CONSUMER_SECRET = "TjMbFSxBhojxE6QAhhlwasIG5C527eOdhDmnurmHxhI";

	// Token: 0x04000512 RID: 1298
	public TwitterDemo.TwitterUser defaultUser;

	// Token: 0x04000513 RID: 1299
	public TwitterDemo.TwitterUser playerUser;

	// Token: 0x04000514 RID: 1300
	private RequestTokenResponse m_RequestTokenResponse;

	// Token: 0x04000515 RID: 1301
	private AccessTokenResponse m_AccessTokenResponse;

	// Token: 0x04000516 RID: 1302
	private string m_PIN = "Please enter your PIN here.";

	// Token: 0x04000517 RID: 1303
	private string m_Tweet = "Please enter your tweet here.";

	// Token: 0x04000518 RID: 1304
	public bool _has_coord_pos;

	// Token: 0x04000519 RID: 1305
	public string _pos_lat = string.Empty;

	// Token: 0x0400051A RID: 1306
	public string _pos_long = string.Empty;

	// Token: 0x0400051B RID: 1307
	private DateTime start_time;

	// Token: 0x0400051C RID: 1308
	public Texture2D imgtex;

	// Token: 0x0400051D RID: 1309
	private string searchstring = "source:zineth_game #wow";

	// Token: 0x0400051E RID: 1310
	private string tweetstring = string.Empty;

	// Token: 0x0400051F RID: 1311
	public bool get_mentions_with_timeline = true;

	// Token: 0x04000520 RID: 1312
	private bool _hasgottimeline;

	// Token: 0x04000521 RID: 1313
	public float timeline_refresh_countdown = 30f;

	// Token: 0x04000522 RID: 1314
	private string _customScreenName;

	// Token: 0x04000523 RID: 1315
	public bool _isConnected;

	// Token: 0x04000524 RID: 1316
	public static bool requireCustom = true;

	// Token: 0x04000525 RID: 1317
	public bool use_hardcoded_account = true;

	// Token: 0x04000526 RID: 1318
	public static TwitterDemo.RegisterCallBack registercallback;

	// Token: 0x04000527 RID: 1319
	public static ulong newest_id;

	// Token: 0x04000528 RID: 1320
	public bool updated;

	// Token: 0x04000529 RID: 1321
	public int newtweets;

	// Token: 0x0400052A RID: 1322
	public List<PhoneMail> twitter_messages = new List<PhoneMail>();

	// Token: 0x0400052B RID: 1323
	public GameObject mail_obj;

	// Token: 0x0400052C RID: 1324
	private bool _use_hash_tag = true;

	// Token: 0x0400052D RID: 1325
	public static string hash_tag = "#ILoveCatco";

	// Token: 0x02000097 RID: 151
	public class TwitterUser
	{
		// Token: 0x0400052E RID: 1326
		public string profile_name;

		// Token: 0x0400052F RID: 1327
		public string pin;

		// Token: 0x04000530 RID: 1328
		public RequestTokenResponse m_RequestTokenResponse;

		// Token: 0x04000531 RID: 1329
		public AccessTokenResponse m_AccessTokenResponse;
	}

	// Token: 0x020000E7 RID: 231
	// (Invoke) Token: 0x060008C7 RID: 2247
	public delegate void RegisterCallBack(bool success, string username);
}
