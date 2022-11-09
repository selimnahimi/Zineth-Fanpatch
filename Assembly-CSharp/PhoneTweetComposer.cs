using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000082 RID: 130
public class PhoneTweetComposer : PhoneMainMenu
{
	// Token: 0x06000572 RID: 1394 RVA: 0x00022434 File Offset: 0x00020634
	private void Start()
	{
		if (this.hide_background)
		{
			this.HideBackground();
		}
		List<string> list = new List<string>();
		list.AddRange(this.words);
		list.AddRange(MonsterTraits.Name.possiblenames);
		list.AddRange(MonsterTraits.Opinions.possibleopinions);
		this.words = list.ToArray();
	}

	// Token: 0x06000573 RID: 1395 RVA: 0x00022488 File Offset: 0x00020688
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.message_text = string.Empty;
		this.tweet_text_label.text = string.Empty;
		foreach (PhoneButton phoneButton in this.auto_buttons)
		{
			UnityEngine.Object.Destroy(phoneButton.gameObject);
			this.buttons.Remove(phoneButton);
		}
		this.auto_buttons.Clear();
		base.OnLoad();
		for (int i = 0; i < 8; i++)
		{
			this.CreateWordButton();
		}
	}

	// Token: 0x06000574 RID: 1396 RVA: 0x00022550 File Offset: 0x00020750
	public string RandomWord()
	{
		return this.words[UnityEngine.Random.Range(0, this.words.Length)];
	}

	// Token: 0x06000575 RID: 1397 RVA: 0x00022568 File Offset: 0x00020768
	private void CreateWordButton()
	{
		PhoneButton phoneButton = UnityEngine.Object.Instantiate(this.button_prefab) as PhoneButton;
		phoneButton.transform.position = base.transform.position;
		phoneButton.transform.parent = base.transform;
		float num = base.renderer.bounds.size.x / 2f;
		float num2 = base.renderer.bounds.size.z / 3f;
		phoneButton.transform.position += Vector3.right * UnityEngine.Random.Range(-num, num);
		phoneButton.transform.position += Vector3.forward * UnityEngine.Random.Range(-num2 / 2f, num2);
		this.buttons.Add(phoneButton);
		this.auto_buttons.Add(phoneButton);
		phoneButton.screen = this;
		phoneButton.Init();
		if (phoneButton.animateOnLoad)
		{
			phoneButton.transform.position = PhoneController.presspos;
		}
		phoneButton.text = this.RandomWord();
	}

	// Token: 0x06000576 RID: 1398 RVA: 0x00022698 File Offset: 0x00020898
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message.StartsWith("addword"))
		{
			this.AddWord(button);
			return true;
		}
		if (message.StartsWith("reply"))
		{
			return this.PostTweet(this.message_text);
		}
		return base.ButtonMessage(button, message);
	}

	// Token: 0x06000577 RID: 1399 RVA: 0x000226E4 File Offset: 0x000208E4
	private void AddWord(PhoneButton button)
	{
		this.message_text = this.message_text + button.text + " ";
		if (this.tweet_text_label)
		{
			this.tweet_text_label.text = this.message_text;
		}
		this.buttons.Remove(button);
		this.auto_buttons.Remove(button);
		UnityEngine.Object.Destroy(button.gameObject);
		this.CreateWordButton();
	}

	// Token: 0x06000578 RID: 1400 RVA: 0x0002275C File Offset: 0x0002095C
	protected virtual bool PostTweet(string tweet)
	{
		this.controller.LoadScreen("Twitter");
		return TwitterDemo.PostTweet(tweet.TrimEnd(new char[]
		{
			' '
		}));
	}

	// Token: 0x0400043C RID: 1084
	public string message_text = string.Empty;

	// Token: 0x0400043D RID: 1085
	public string[] words = new string[]
	{
		"I",
		"love",
		"move",
		"play",
		"am",
		"are",
		"garbage",
		"Zineth",
		"scary",
		"tweets",
		"lumber",
		"the",
		"i",
		"to",
		"a",
		"and",
		"is",
		"in",
		"it",
		"you",
		"of",
		"for",
		"on",
		"my",
		"#",
		"@",
		"?",
		":)"
	};

	// Token: 0x0400043E RID: 1086
	public PhoneLabel tweet_text_label;
}
