using System;
using UnityEngine;

// Token: 0x02000083 RID: 131
public class PhoneTwitterAccountMenu : PhoneMainMenu
{
	// Token: 0x0600057A RID: 1402 RVA: 0x000227A8 File Offset: 0x000209A8
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
	}

	// Token: 0x0600057B RID: 1403 RVA: 0x000227BC File Offset: 0x000209BC
	public override void UpdateScreen()
	{
		this.DoProfileStuff();
		base.UpdateScreen();
	}

	// Token: 0x0600057C RID: 1404 RVA: 0x000227CC File Offset: 0x000209CC
	public void DoProfileStuff()
	{
		string currentScreenName = TwitterDemo.instance.GetCurrentScreenName();
		if (this.accountButton)
		{
			if (this.accountButton.username_label.text != "@" + currentScreenName)
			{
				this.accountButton.username_label.text = "@" + currentScreenName;
			}
			string text = this.twitterUrl + TwitterDemo.instance.GetCurrentUserId();
			if (this.oldImageUrl != text)
			{
				this.accountButton.GetImage(text);
				this.oldImageUrl = text;
			}
		}
		if (this.signInButton && this.signOutButton && this.registerButton)
		{
			string customScreenName = TwitterDemo.instance.GetCustomScreenName();
			if (customScreenName != string.Empty && this.signInButton.text != "Sign in as\n@" + customScreenName)
			{
				this.signInButton.text = "Sign in as\n@" + customScreenName;
				this.signInButton.command = "twitter_login";
				this.signInButton.OnUnSelected();
				this.signOutButton.up_button = this.signInButton;
				if (!this.buttons.Contains(this.signInButton))
				{
					this.buttons.Add(this.signInButton);
				}
			}
			else if (customScreenName == string.Empty)
			{
				this.signInButton.text = "You Need to\nRegister First...";
				this.signInButton.command = string.Empty;
				this.signInButton.background_box.renderer.material.color = Color.gray;
				this.signOutButton.up_button = null;
				if (this.buttons.Contains(this.signInButton))
				{
					this.buttons.Remove(this.signInButton);
				}
			}
		}
	}

	// Token: 0x0400043F RID: 1087
	public PhoneTweetButton accountButton;

	// Token: 0x04000440 RID: 1088
	public PhoneButton signInButton;

	// Token: 0x04000441 RID: 1089
	public PhoneButton signOutButton;

	// Token: 0x04000442 RID: 1090
	public PhoneButton registerButton;

	// Token: 0x04000443 RID: 1091
	private string oldImageUrl = string.Empty;

	// Token: 0x04000444 RID: 1092
	private string twitterUrl = "http://api.twitter.com/1/users/profile_image/";
}
