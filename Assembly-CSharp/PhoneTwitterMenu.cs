using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000084 RID: 132
public class PhoneTwitterMenu : PhoneMailMenu
{
	// Token: 0x0600057E RID: 1406 RVA: 0x00022A0C File Offset: 0x00020C0C
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
		if (this.mail_back_button == null)
		{
			this.mail_back_button = base.transform.FindChild("MailBackButton").GetComponent<PhoneButton>();
		}
		if (this.mail_reply_button == null)
		{
			this.mail_reply_button = base.transform.FindChild("MailReplyButton").GetComponent<PhoneButton>();
		}
		if (this.message_holder == null)
		{
			this.message_holder = base.transform.FindChild("MessageHolder").transform;
		}
	}

	// Token: 0x0600057F RID: 1407 RVA: 0x00022AB0 File Offset: 0x00020CB0
	public override void OnExit()
	{
		if (this.mode == PhoneMailMenu.mailmode.single)
		{
			this.CloseMail();
		}
		base.OnExit();
	}

	// Token: 0x06000580 RID: 1408 RVA: 0x00022ACC File Offset: 0x00020CCC
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.LoadAnimationCancel();
		if (this.zone != PhoneMailMenu.MenuZone.Center && this.center_buttons.Count > 0)
		{
			this.zone = PhoneMailMenu.MenuZone.Center;
			this.menuind = this.center_menu_ind;
		}
		if (this.mode == PhoneMailMenu.mailmode.single)
		{
			this.CloseMail();
		}
		this.RefreshTwitter();
		if (this.CheckUpdates())
		{
			this.RefreshList();
		}
		if (this.new_tweets_button)
		{
			this.new_tweets_button.gameObject.SetActiveRecursively(false);
		}
		if (this.single_message_holder)
		{
			this.single_message_holder.gameObject.SetActiveRecursively(false);
		}
		foreach (PhoneButton phoneButton in this.left_buttons)
		{
			phoneButton.OnLoad();
		}
		foreach (PhoneButton phoneButton2 in this.center_buttons)
		{
			phoneButton2.OnLoad();
		}
		foreach (PhoneButton phoneButton3 in this.right_buttons)
		{
			phoneButton3.OnLoad();
		}
		foreach (PhoneElement phoneElement in this.load_elements)
		{
			phoneElement.OnLoad();
		}
		this.UpdateButtonSelected();
	}

	// Token: 0x06000581 RID: 1409 RVA: 0x00022CC4 File Offset: 0x00020EC4
	public virtual bool RefreshTwitter()
	{
		return TwitterDemo.GetTimeLine();
	}

	// Token: 0x06000582 RID: 1410 RVA: 0x00022CCC File Offset: 0x00020ECC
	protected override bool CheckUpdates()
	{
		if (this.demo.updated)
		{
			if (!this.new_tweets_button.gameObject.active)
			{
				this.new_tweets_button.gameObject.SetActiveRecursively(true);
			}
			string text = this.demo.newtweets.ToString() + " new Tweet";
			if (this.demo.newtweets > 1)
			{
				text += "s";
			}
			if (this.new_tweets_button.text != text)
			{
				this.new_tweets_button.text = text;
			}
			if (this.mailbuttons.Count > 0)
			{
				this.mailbuttons[0].up_button = this.new_tweets_button;
				this.new_tweets_button.down_button = this.mailbuttons[0];
			}
			if (this.center_buttons.Count > 1)
			{
				this.center_buttons[0].up_button = this.new_tweets_button;
				this.new_tweets_button.down_button = this.center_buttons[0];
				this.UpdateButtonSelected();
			}
			return true;
		}
		if (this.new_tweets_button.gameObject.active)
		{
			this.new_tweets_button.gameObject.SetActiveRecursively(false);
		}
		return false;
	}

	// Token: 0x06000583 RID: 1411 RVA: 0x00022E18 File Offset: 0x00021018
	protected virtual bool RefreshList()
	{
		this.demo.updated = false;
		this.demo.newtweets = 0;
		this.new_tweets_button.gameObject.SetActiveRecursively(false);
		this.menuind = 0;
		this.SetupMail();
		Vector3 localPosition = this.message_holder.transform.localPosition;
		localPosition.z = 0f;
		this.message_holder.transform.localPosition = localPosition;
		return true;
	}

	// Token: 0x170000B8 RID: 184
	// (get) Token: 0x06000584 RID: 1412 RVA: 0x00022E8C File Offset: 0x0002108C
	protected override List<PhoneMail> mail_list
	{
		get
		{
			return this.demo.twitter_messages;
		}
	}

	// Token: 0x170000B9 RID: 185
	// (get) Token: 0x06000585 RID: 1413 RVA: 0x00022E9C File Offset: 0x0002109C
	public override List<PhoneButton> current_buttons
	{
		get
		{
			if (this.mode == PhoneMailMenu.mailmode.single)
			{
				return this.message_buttons;
			}
			return base.current_buttons;
		}
	}

	// Token: 0x06000586 RID: 1414 RVA: 0x00022EB8 File Offset: 0x000210B8
	public override void OpenMail(int index)
	{
		this.mailindex = index;
		this.OpenMail(this.demo.twitter_messages[index]);
	}

	// Token: 0x06000587 RID: 1415 RVA: 0x00022ED8 File Offset: 0x000210D8
	protected override void OpenMail(PhoneMail mail)
	{
		if (this.zone == PhoneMailMenu.MenuZone.Center && this.mode == PhoneMailMenu.mailmode.inbox)
		{
			this.center_menu_ind = this.menuind;
		}
		this.oldmenuind = this.menuind;
		this.current_mail = mail;
		this.mode = PhoneMailMenu.mailmode.single;
		foreach (PhoneButton phoneButton in this.message_buttons)
		{
			phoneButton.OnUnSelected();
		}
		this.menuind = 0;
		if (!this.single_tweet_obj)
		{
			this.single_tweet_obj = (UnityEngine.Object.Instantiate(this.button_prefab) as PhoneTweetButton);
			this.single_tweet_obj.transform.parent = this.single_message_holder;
			this.single_tweet_obj.transform.position = this.single_message_holder.position + Vector3.forward * this.first_mail_forward_pos + Vector3.up * 3f;
			this.single_tweet_obj.selected = true;
		}
		if (this.single_tweet_scale == Vector3.zero)
		{
			this.single_tweet_scale = this.single_tweet_obj.transform.localScale;
			this.single_tweet_pos = this.single_tweet_obj.transform.localPosition;
		}
		this.single_message_holder.gameObject.SetActiveRecursively(true);
		this.single_tweet_obj.my_mail = mail;
		this.single_tweet_obj.Init();
		this.single_tweet_obj.OnLoad();
		if (this.media_plane)
		{
			if (this.single_tweet_obj.my_mail.media_urls.Count > 0)
			{
				this.media_plane.renderer.enabled = true;
				Texture2D mainTexture = this.single_tweet_obj.NewImage(this.single_tweet_obj.my_mail.media_urls[0]);
				this.media_plane.renderer.material.mainTexture = mainTexture;
			}
			else
			{
				this.media_plane.renderer.enabled = false;
			}
		}
		this.single_tweet_obj.animateOnLoad = true;
		this.single_tweet_obj.wantedpos = this.single_tweet_pos;
		this.single_tweet_obj.transform.position = PhoneController.presspos;
		Vector3 localPosition = this.single_tweet_obj.transform.localPosition;
		localPosition.x = this.single_tweet_pos.x;
		localPosition.y = this.single_tweet_pos.y;
		this.single_tweet_obj.transform.localPosition = Vector3.Lerp(localPosition, this.single_tweet_pos, 0.5f);
		this.single_tweet_obj.wantedscale = this.single_tweet_scale;
		this.single_tweet_obj.changeScale = true;
		this.single_tweet_obj.transform.localScale = new Vector3(0.00433f, 0.00158f, 0.5f);
		if (this.link_button)
		{
			if (mail.link_urls.Count > 0)
			{
				this.link_button.selectable = true;
				this.link_button.id_info = mail.link_urls[0];
				if (this.link_button.down_button)
				{
					this.link_button.down_button.up_button = this.link_button;
				}
			}
			else
			{
				this.link_button.selectable = false;
				this.link_button.gameObject.SetActiveRecursively(false);
				if (this.link_button.down_button)
				{
					this.link_button.down_button.up_button = null;
				}
			}
		}
		this.UpdateButtonSelected();
		mail.OnOpen();
	}

	// Token: 0x06000588 RID: 1416 RVA: 0x00023298 File Offset: 0x00021498
	protected override void CloseMail()
	{
		this.current_mail.OnClose();
		this.current_mail = null;
		this.mode = PhoneMailMenu.mailmode.inbox;
		this.zone = PhoneMailMenu.MenuZone.Center;
		this.single_tweet_obj.selected = false;
		this.single_message_holder.gameObject.SetActiveRecursively(false);
		this.menuind = this.center_menu_ind;
		this.UpdateButtonSelected();
	}

	// Token: 0x06000589 RID: 1417 RVA: 0x000232F8 File Offset: 0x000214F8
	protected override void StickControls_Vertical_Inbox()
	{
		Vector2 vector = PhoneInput.GetControlDirPressed();
		if (vector.y >= 0.5f)
		{
			this.scroll_counter = 1f;
		}
		else if (vector.y <= -0.5f)
		{
			this.scroll_counter = -1f;
		}
		else
		{
			vector = PhoneInput.GetControlDir();
			if (vector.y > 0f && this.scroll_counter >= 1f)
			{
				this.scroll_counter += vector.y * base.deltatime;
				if (this.scroll_counter - 1f >= this.scroll_cutoff)
				{
					this.scroll_counter -= this.scroll_cutoff;
					PhoneButton up_button = this.current_buttons[this.menuind].up_button;
					if (up_button)
					{
						this.menuind = this.current_buttons.IndexOf(up_button);
						this.UpdateButtonSelected();
					}
				}
			}
			else if (vector.y < 0f && this.scroll_counter <= -1f)
			{
				this.scroll_counter += vector.y * base.deltatime;
				if (this.scroll_counter + 1f <= -this.scroll_cutoff)
				{
					this.scroll_counter += this.scroll_cutoff;
					PhoneButton down_button = this.current_buttons[this.menuind].down_button;
					if (down_button)
					{
						this.menuind = this.current_buttons.IndexOf(down_button);
						this.UpdateButtonSelected();
					}
				}
			}
			else
			{
				this.scroll_counter = 0f;
			}
		}
		base.StickControls_Vertical_Inbox();
	}

	// Token: 0x0600058A RID: 1418 RVA: 0x000234B0 File Offset: 0x000216B0
	protected override void StickControls_Vertical_Message()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		this.menuind = Mathf.Clamp(this.menuind, 0, this.current_buttons.Count - 1);
		if (controlDirPressed.x >= 0.5f)
		{
			PhoneButton right_button = this.current_buttons[this.menuind].right_button;
			if (right_button && right_button.gameObject.active && right_button.selectable)
			{
				this.menuind = this.current_buttons.IndexOf(right_button);
			}
		}
		else if (controlDirPressed.x <= -0.5f)
		{
			PhoneButton left_button = this.current_buttons[this.menuind].left_button;
			if (left_button && left_button.gameObject.active && left_button.selectable)
			{
				this.menuind = this.current_buttons.IndexOf(left_button);
			}
		}
		if (controlDirPressed.y >= 0.5f)
		{
			PhoneButton up_button = this.current_buttons[this.menuind].up_button;
			if (up_button && up_button.gameObject.active && up_button.selectable)
			{
				this.menuind = this.current_buttons.IndexOf(up_button);
			}
		}
		else if (controlDirPressed.y <= -0.5f)
		{
			PhoneButton down_button = this.current_buttons[this.menuind].down_button;
			if (down_button && down_button.gameObject.active && down_button.selectable)
			{
				this.menuind = this.current_buttons.IndexOf(down_button);
			}
		}
		if (Input.GetKeyDown(KeyCode.Semicolon) && this.single_tweet_obj.my_mail.media_urls.Count > 0)
		{
			PhoneInterface.ShowZine(this.media_plane.renderer.material.mainTexture as Texture2D, true);
		}
		if (PhoneInput.IsPressedDown() && this.current_buttons.Count > this.menuind)
		{
			this.current_buttons[this.menuind].OnPressed();
		}
	}

	// Token: 0x0600058B RID: 1419 RVA: 0x000236F0 File Offset: 0x000218F0
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "close")
		{
			this.CloseMail();
		}
		else if (message == "reply")
		{
			if (TwitterDemo.instance._canTweet && this.current_mail != null && this.mode == PhoneMailMenu.mailmode.single)
			{
				bool result = this.ReplyToTweet(this.current_mail);
				this.CloseMail();
				return result;
			}
			return false;
		}
		else
		{
			if (message == "post_tweet")
			{
				return TwitterDemo.instance._canTweet && this.PostTweet();
			}
			if (message == "get_mentions")
			{
				return TwitterDemo.GetMentions();
			}
			if (message == "get_timeline")
			{
				return TwitterDemo.GetTimeLine();
			}
			if (message.StartsWith("openmessage"))
			{
				this.OpenMail(button.id_info);
			}
			else if (message.StartsWith("open_link"))
			{
				if (button.id_info.StartsWith("m_"))
				{
					string focus = button.id_info.Remove(0, 2);
					MissionController.SetFocus(focus);
				}
				else
				{
					Application.OpenURL(button.id_info);
					Playtomic.Log.CustomMetric("tOpenedTwitterLink", "tPhone", true);
				}
			}
			else if (!message.StartsWith("focus_mission"))
			{
				if (!(message == "refresh"))
				{
					return base.ButtonMessage(button, message);
				}
				this.RefreshList();
			}
		}
		return true;
	}

	// Token: 0x170000BA RID: 186
	// (get) Token: 0x0600058C RID: 1420 RVA: 0x00023878 File Offset: 0x00021A78
	public override List<PhoneButton> center_buttons
	{
		get
		{
			return new List<PhoneButton>(this.mailbuttons)
			{
				this.new_tweets_button
			};
		}
	}

	// Token: 0x0600058D RID: 1421 RVA: 0x000238A0 File Offset: 0x00021AA0
	protected override void SetupButtons()
	{
		base.SetupButtons();
		this.menuind = 0;
		this.oldmenuind = 0;
	}

	// Token: 0x0600058E RID: 1422 RVA: 0x000238B8 File Offset: 0x00021AB8
	protected virtual string MakeTweet()
	{
		return TweetComposer.MakeTweet();
	}

	// Token: 0x170000BB RID: 187
	// (get) Token: 0x0600058F RID: 1423 RVA: 0x000238CC File Offset: 0x00021ACC
	public static PhoneTwitterMenu instance
	{
		get
		{
			if (!PhoneTwitterMenu._instance)
			{
				PhoneTwitterMenu._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneTwitterMenu)) as PhoneTwitterMenu);
			}
			return PhoneTwitterMenu._instance;
		}
	}

	// Token: 0x06000590 RID: 1424 RVA: 0x000238FC File Offset: 0x00021AFC
	public virtual bool PostTweet()
	{
		return this.PostTweet(this.MakeTweet());
	}

	// Token: 0x06000591 RID: 1425 RVA: 0x0002390C File Offset: 0x00021B0C
	public virtual bool PostTweet(string tweet)
	{
		if (Application.loadedLevelName == "Loader 1")
		{
			tweet = "pos:" + PlaytomicController.TranslatePlayerPosToGPSString() + ";" + tweet;
		}
		Playtomic.Log.CustomMetric("tPostedTweet", "tPhone", true);
		return TwitterDemo.PostTweet(tweet);
	}

	// Token: 0x06000592 RID: 1426 RVA: 0x00023960 File Offset: 0x00021B60
	protected virtual bool ReplyToTweet(string mailid)
	{
		return this.ReplyToTweet(MailController.FindTweet(mailid));
	}

	// Token: 0x06000593 RID: 1427 RVA: 0x00023970 File Offset: 0x00021B70
	protected virtual bool ReplyToTweet(PhoneMail mail)
	{
		string text = mail.id;
		text = text.Replace("tw_", string.Empty);
		string text2 = this.MakeTweet();
		text2 = string.Concat(new string[]
		{
			"replyto:",
			text,
			";",
			mail.subject,
			" ",
			text2
		});
		return this.PostTweet(text2);
	}

	// Token: 0x04000445 RID: 1093
	public TwitterDemo demo;

	// Token: 0x04000446 RID: 1094
	public float mailsep = 0.05f;

	// Token: 0x04000447 RID: 1095
	public PhoneButton new_tweets_button;

	// Token: 0x04000448 RID: 1096
	public PhoneElement[] load_elements;

	// Token: 0x04000449 RID: 1097
	public List<PhoneButton> message_buttons = new List<PhoneButton>();

	// Token: 0x0400044A RID: 1098
	public PhoneTweetButton single_tweet_obj;

	// Token: 0x0400044B RID: 1099
	public Transform single_message_holder;

	// Token: 0x0400044C RID: 1100
	public Renderer media_plane;

	// Token: 0x0400044D RID: 1101
	public PhoneButton link_button;

	// Token: 0x0400044E RID: 1102
	private Vector3 single_tweet_scale = Vector3.zero;

	// Token: 0x0400044F RID: 1103
	private Vector3 single_tweet_pos = Vector3.zero;

	// Token: 0x04000450 RID: 1104
	public float scroll_cutoff = 0.25f;

	// Token: 0x04000451 RID: 1105
	public float scroll_counter;

	// Token: 0x04000452 RID: 1106
	private static PhoneTwitterMenu _instance;
}
