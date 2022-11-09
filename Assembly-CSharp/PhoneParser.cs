using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000051 RID: 81
public class PhoneParser : MonoBehaviour
{
	// Token: 0x06000352 RID: 850 RVA: 0x00014E54 File Offset: 0x00013054
	public void Init(PhoneController control)
	{
		this.controller = control;
		this.SetupCommandMethods();
	}

	// Token: 0x06000353 RID: 851 RVA: 0x00014E64 File Offset: 0x00013064
	public bool ParseNode(List<string> lines)
	{
		foreach (string item in lines)
		{
			this.commandlist.Add(item);
		}
		this.DoNextCommand();
		return true;
	}

	// Token: 0x06000354 RID: 852 RVA: 0x00014ED4 File Offset: 0x000130D4
	public void DoNextCommand()
	{
		while (this.commandlist.Count > 0)
		{
			string command = this.commandlist[0];
			this.commandlist.RemoveAt(0);
			this._DoStringCommand(command);
		}
	}

	// Token: 0x06000355 RID: 853 RVA: 0x00014F18 File Offset: 0x00013118
	public bool DoStringCommand(string command)
	{
		string[] array = command.Split(new char[]
		{
			'|'
		});
		foreach (string item in array)
		{
			this.commandlist.Add(item);
		}
		this.DoNextCommand();
		return true;
	}

	// Token: 0x06000356 RID: 854 RVA: 0x00014F64 File Offset: 0x00013164
	private void SetupCommandMethods()
	{
		this.commandMethods.Add("back", new PhoneParser.CommandDelegate(this.BackCommand));
		this.commandMethods.Add("load_screen", new PhoneParser.CommandDelegate(this.LoadScreenCommand));
		this.commandMethods.Add("set_bgcolor", new PhoneParser.CommandDelegate(this.SetColorCommand));
		this.commandMethods.Add("mission_focus", new PhoneParser.CommandDelegate(this.SetMissionFocus));
		this.commandMethods.Add("mission_activate", new PhoneParser.CommandDelegate(this.ActivateMission));
		this.commandMethods.Add("mission_activate_insert", new PhoneParser.CommandDelegate(this.ActivateInsertMission));
		this.commandMethods.Add("set_mute", new PhoneParser.CommandDelegate(this.SetMuteCommand));
		this.commandMethods.Add("mail_send", new PhoneParser.CommandDelegate(this.SendMail));
		this.commandMethods.Add("mail_send_quiet", new PhoneParser.CommandDelegate(this.SendMailQuiet));
		this.commandMethods.Add("capsule_points_add", new PhoneParser.CommandDelegate(this.AddCapsulePoints));
		this.commandMethods.Add("player_freeze", new PhoneParser.CommandDelegate(this.FreezePlayer));
		this.commandMethods.Add("player_unfreeze", new PhoneParser.CommandDelegate(this.UnfreezePlayer));
		this.commandMethods.Add("twitter_post", new PhoneParser.CommandDelegate(this.PostTweet));
		this.commandMethods.Add("twitter_get_mentions", new PhoneParser.CommandDelegate(this.GetTwitterMentions));
		this.commandMethods.Add("menu_unlock", new PhoneParser.CommandDelegate(this.UnlockMenu));
		this.commandMethods.Add("menu_lock", new PhoneParser.CommandDelegate(this.LockMenu));
		this.commandMethods.Add("monster_save_all", new PhoneParser.CommandDelegate(this.SaveMonsters));
		this.commandMethods.Add("save_monsters", new PhoneParser.CommandDelegate(this.SaveMonsters));
		this.commandMethods.Add("monster_reset_all", new PhoneParser.CommandDelegate(this.ResetMonsters));
		this.commandMethods.Add("reset_monsters", new PhoneParser.CommandDelegate(this.ResetMonsters));
		this.commandMethods.Add("enable_hawk_control", new PhoneParser.CommandDelegate(this.EnableHawkControl));
		this.commandMethods.Add("unlock_zine", new PhoneParser.CommandDelegate(this.UnlockZine));
		this.commandMethods.Add("print_zine", new PhoneParser.CommandDelegate(this.PrintZine));
		this.commandMethods.Add("open_phone", new PhoneParser.CommandDelegate(this.OpenPhone));
		this.commandMethods.Add("close_phone", new PhoneParser.CommandDelegate(this.ClosePhone));
		this.commandMethods.Add("open_mail", new PhoneParser.CommandDelegate(this.OpenMail));
		this.commandMethods.Add("twitter_login", new PhoneParser.CommandDelegate(this.LoginToTwitterCustom));
		this.commandMethods.Add("twitter_login_default", new PhoneParser.CommandDelegate(this.LoginToTwitterDefault));
		this.commandMethods.Add("twitter_logout", new PhoneParser.CommandDelegate(this.LoginToTwitterDefault));
		this.commandMethods.Add("twitter_register", new PhoneParser.CommandDelegate(this.RegisterTwitter));
		this.commandMethods.Add("summon_hawk", new PhoneParser.CommandDelegate(this.SummonHawk));
		this.commandMethods.Add("hawk_whistle", new PhoneParser.CommandDelegate(this.SummonHawk));
		this.commandMethods.Add("reset_prefs", new PhoneParser.CommandDelegate(this.ResetPlayerPrefs));
		this.commandMethods.Add("delete_prefs", new PhoneParser.CommandDelegate(this.ResetPlayerPrefs));
		this.commandMethods.Add("tut_slide", new PhoneParser.CommandDelegate(this.SetSlides));
		this.commandMethods.Add("load_scene", new PhoneParser.CommandDelegate(this.LoadScene));
		this.commandMethods.Add("open_url", new PhoneParser.CommandDelegate(this.OpenURL));
		this.commandMethods.Add("unlock_cam", new PhoneParser.CommandDelegate(this.UnlockCamera));
	}

	// Token: 0x06000357 RID: 855 RVA: 0x0001539C File Offset: 0x0001359C
	public bool _DoStringCommand(string command)
	{
		command.Trim();
		if (command.StartsWith("//") || command == string.Empty)
		{
			return true;
		}
		string[] array = command.Split(new char[]
		{
			' '
		});
		if (array.Length <= 0)
		{
			Debug.LogWarning("empty command");
			return false;
		}
		if (this.commandMethods.ContainsKey(array[0]))
		{
			return this.commandMethods[array[0]](array);
		}
		Debug.LogWarning("Command not valid: " + array[0]);
		return false;
	}

	// Token: 0x06000358 RID: 856 RVA: 0x00015434 File Offset: 0x00013634
	public bool BackCommand(string[] args)
	{
		return this.controller.LoadPrevious();
	}

	// Token: 0x06000359 RID: 857 RVA: 0x00015444 File Offset: 0x00013644
	public bool LoadScreenCommand(string[] args)
	{
		if (args.Length >= 2)
		{
			return this.controller.LoadScreen(this.ArgsToString(args, 1));
		}
		Debug.LogWarning("Command " + args[0] + "needs a node name.");
		return false;
	}

	// Token: 0x0600035A RID: 858 RVA: 0x00015488 File Offset: 0x00013688
	public bool SetColorCommand(string[] args)
	{
		if (args.Length >= 2)
		{
			this.controller.SetBackColor(PhoneTextController.GetColor(this.ArgsToString(args, 1)));
			return true;
		}
		Debug.LogWarning("Command 'color' needs a color name.");
		return false;
	}

	// Token: 0x0600035B RID: 859 RVA: 0x000154C4 File Offset: 0x000136C4
	public bool SetMuteCommand(string[] args)
	{
		if (args.Length >= 2)
		{
			if (args[1] == "0" || args[1] == "off" || args[1] == "false")
			{
				PhoneMemory.settings.muted = false;
			}
			else
			{
				PhoneMemory.settings.muted = true;
			}
		}
		else
		{
			PhoneMemory.settings.muted = !PhoneMemory.settings.muted;
		}
		return true;
	}

	// Token: 0x0600035C RID: 860 RVA: 0x00015548 File Offset: 0x00013748
	public bool ActivateInsertMission(string[] args)
	{
		if (args.Length >= 2)
		{
			return MissionController.SetActive(this.ArgsToString(args, 1), true);
		}
		Debug.LogWarning("Command 'mission_activate' needs a mission id.");
		return false;
	}

	// Token: 0x0600035D RID: 861 RVA: 0x00015570 File Offset: 0x00013770
	public bool ActivateMission(string[] args)
	{
		if (args.Length >= 2)
		{
			return MissionController.SetActive(this.ArgsToString(args, 1));
		}
		Debug.LogWarning("Command 'mission_activate' needs a mission id.");
		return false;
	}

	// Token: 0x0600035E RID: 862 RVA: 0x000155A0 File Offset: 0x000137A0
	public bool SetMissionFocus(string[] args)
	{
		if (args.Length >= 2)
		{
			MissionController.SetFocus(this.ArgsToString(args, 1));
			return true;
		}
		Debug.LogWarning("Command 'mission_focus' needs a node name.");
		return false;
	}

	// Token: 0x0600035F RID: 863 RVA: 0x000155C8 File Offset: 0x000137C8
	public bool SendMail(string[] args)
	{
		if (args.Length >= 2)
		{
			return MailController.SendMail(this.ArgsToString(args, 1));
		}
		Debug.LogWarning("Command " + args[0] + " needs a mail id.");
		return false;
	}

	// Token: 0x06000360 RID: 864 RVA: 0x000155FC File Offset: 0x000137FC
	public bool SendMailQuiet(string[] args)
	{
		if (args.Length >= 2)
		{
			return MailController.SendMailQuiet(this.ArgsToString(args, 1));
		}
		Debug.LogWarning("Command " + args[0] + " needs a mail id.");
		return false;
	}

	// Token: 0x06000361 RID: 865 RVA: 0x00015630 File Offset: 0x00013830
	public bool AddCapsulePoints(string[] args)
	{
		if (args.Length < 2)
		{
			Debug.LogWarning("Command " + args[0] + " needs an amount.");
			return false;
		}
		float amount;
		if (float.TryParse(args[1], out amount))
		{
			PhoneInterface.AddCapsulePoints(amount);
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a float value.");
		return false;
	}

	// Token: 0x06000362 RID: 866 RVA: 0x00015690 File Offset: 0x00013890
	public bool PlayAudioClip(string[] args)
	{
		if (args.Length >= 2)
		{
			return PhoneAudioController.PlayAudioClip(this.ArgsToString(args, 1)) != null;
		}
		Debug.LogWarning("Command " + args[0] + " needs a sound name.");
		return false;
	}

	// Token: 0x06000363 RID: 867 RVA: 0x000156D4 File Offset: 0x000138D4
	public bool FreezePlayer(string[] args)
	{
		Transform transform = GameObject.Find("Player").transform;
		transform.GetComponent<move>().freezeControls = true;
		transform.rigidbody.velocity = Vector3.zero;
		return true;
	}

	// Token: 0x06000364 RID: 868 RVA: 0x00015710 File Offset: 0x00013910
	public bool UnfreezePlayer(string[] args)
	{
		GameObject.Find("Player").GetComponent<move>().freezeControls = false;
		return true;
	}

	// Token: 0x06000365 RID: 869 RVA: 0x00015728 File Offset: 0x00013928
	public bool PostTweet(string[] args)
	{
		Debug.LogError("Doing the post tweet thing...");
		return false;
	}

	// Token: 0x06000366 RID: 870 RVA: 0x00015738 File Offset: 0x00013938
	public bool GetTwitterMentions(string[] args)
	{
		TwitterDemo.GetMentions();
		return true;
	}

	// Token: 0x06000367 RID: 871 RVA: 0x00015744 File Offset: 0x00013944
	public bool UnlockMenu(string[] args)
	{
		if (args.Length > 1)
		{
			PhoneMemory.UnlockMenu(this.ArgsToString(args, 1));
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a screen id.");
		return false;
	}

	// Token: 0x06000368 RID: 872 RVA: 0x00015784 File Offset: 0x00013984
	public bool LockMenu(string[] args)
	{
		if (args.Length > 1)
		{
			PhoneMemory.LockMenu(this.ArgsToString(args, 1));
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a screen id.");
		return false;
	}

	// Token: 0x06000369 RID: 873 RVA: 0x000157C4 File Offset: 0x000139C4
	public bool SaveMonsters(string[] args)
	{
		return PhoneMemory.SaveMonsters();
	}

	// Token: 0x0600036A RID: 874 RVA: 0x000157CC File Offset: 0x000139CC
	public bool ResetMonsters(string[] args)
	{
		PhoneMemory.ResetMonsters();
		Playtomic.Log.CustomMetric("tResetMonsters", "tPhone", true);
		return true;
	}

	// Token: 0x0600036B RID: 875 RVA: 0x000157EC File Offset: 0x000139EC
	public bool EnableHawkControl(string[] args)
	{
		HawkBehavior hawkBehavior = UnityEngine.Object.FindObjectOfType(typeof(HawkBehavior)) as HawkBehavior;
		hawkBehavior.canControl = true;
		Playtomic.Log.CustomMetric("tGotHawkControl", PlaytomicController.current_group, true);
		return true;
	}

	// Token: 0x0600036C RID: 876 RVA: 0x0001582C File Offset: 0x00013A2C
	public bool UnlockZine(string[] args)
	{
		if (args.Length >= 2)
		{
			int index;
			if (!int.TryParse(args[1], out index))
			{
				return false;
			}
			PhoneMemory.UnlockZine(index);
		}
		Debug.LogWarning("Not enough args in " + args[0]);
		return false;
	}

	// Token: 0x0600036D RID: 877 RVA: 0x00015874 File Offset: 0x00013A74
	public bool PrintZine(string[] args)
	{
		Debug.LogWarning("Trying to print...");
		return true;
	}

	// Token: 0x0600036E RID: 878 RVA: 0x00015884 File Offset: 0x00013A84
	public bool OpenPhone(string[] args)
	{
		base.StartCoroutine("DoOpenPhone", args);
		return true;
	}

	// Token: 0x0600036F RID: 879 RVA: 0x00015894 File Offset: 0x00013A94
	public IEnumerator DoOpenPhone(string[] args)
	{
		if (args.Length > 1)
		{
			this.controller.LoadScreen(this.ArgsToString(args, 1));
		}
		yield return null;
		PhoneInterface.view_controller.SetOpen(true);
		yield break;
	}

	// Token: 0x06000370 RID: 880 RVA: 0x000158C0 File Offset: 0x00013AC0
	public bool ClosePhone(string[] args)
	{
		PhoneInterface.view_controller.SetOpen(false);
		return true;
	}

	// Token: 0x06000371 RID: 881 RVA: 0x000158D0 File Offset: 0x00013AD0
	public bool OpenMail(string[] args)
	{
		if (args.Length > 1)
		{
			base.StartCoroutine("DoOpenMail", args);
			return true;
		}
		Debug.LogWarning("Not enough args in " + args[0]);
		return false;
	}

	// Token: 0x06000372 RID: 882 RVA: 0x00015900 File Offset: 0x00013B00
	public IEnumerator DoOpenMail(string[] args)
	{
		if (PhoneController.powerstate == PhoneController.PowerState.closed)
		{
			this.OpenPhone(new string[]
			{
				string.Empty,
				"Mail"
			});
			yield return !PhoneInterface.view_controller.is_opening;
		}
		if (PhoneController.instance.curscreen.screenname != "Mail")
		{
			PhoneController.instance.LoadScreen("Mail");
		}
		PhoneController.instance.curscreen.SendMessage("OpenMail", this.ArgsToString(args, 1));
		yield break;
	}

	// Token: 0x06000373 RID: 883 RVA: 0x0001592C File Offset: 0x00013B2C
	public bool LoginToTwitterCustom(string[] args)
	{
		TwitterDemo.instance.LoadTwitterUserInfo(false);
		Playtomic.Log.CustomMetric("tLoggedIntoTwitter", "tPhone", true);
		return true;
	}

	// Token: 0x06000374 RID: 884 RVA: 0x0001595C File Offset: 0x00013B5C
	public bool LoginToTwitterDefault(string[] args)
	{
		TwitterDemo.instance.LoadTwitterUserInfo(true);
		Playtomic.Log.CustomMetric("tLoggedOutOfTwitter", "tPhone", true);
		return true;
	}

	// Token: 0x06000375 RID: 885 RVA: 0x0001598C File Offset: 0x00013B8C
	public bool RegisterTwitter(string[] args)
	{
		TwitterDemo.RegisterUser();
		Playtomic.Log.CustomMetric("tRegisteringTwitter", "tPhone", true);
		return true;
	}

	// Token: 0x06000376 RID: 886 RVA: 0x000159AC File Offset: 0x00013BAC
	public bool SummonHawk(string[] args)
	{
		return PhoneInterface.SummonHawk();
	}

	// Token: 0x06000377 RID: 887 RVA: 0x000159B4 File Offset: 0x00013BB4
	public bool ResetPlayerPrefs(string[] args)
	{
		PlayerPrefs.DeleteAll();
		return true;
	}

	// Token: 0x06000378 RID: 888 RVA: 0x000159BC File Offset: 0x00013BBC
	public bool SetSlides(string[] args)
	{
		if (args.Length > 1)
		{
			base.StartCoroutine(this.DoSetSlides(args));
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a Slideset name.");
		return false;
	}

	// Token: 0x06000379 RID: 889 RVA: 0x000159FC File Offset: 0x00013BFC
	public IEnumerator DoSetSlides(string[] args)
	{
		if (PhoneController.powerstate == PhoneController.PowerState.closed)
		{
			this.OpenPhone(new string[]
			{
				string.Empty,
				"Slideshow1"
			});
			yield return !PhoneInterface.view_controller.is_opening;
		}
		if (!this.controller.curscreen.name.Contains("Slideshow"))
		{
			if (this.controller.screendict.ContainsKey("Slideshow1"))
			{
				this.controller.LoadScreen("Slideshow1");
			}
			else
			{
				Debug.LogError("Tried to load a slideset but couldn't find the slideshow screen. Looked for \"Slideshow1\"");
			}
		}
		PhoneSlideshow slideshow = this.controller.curscreen as PhoneSlideshow;
		slideshow.LoadSlideSet(this.ArgsToString(args, 1));
		yield break;
	}

	// Token: 0x0600037A RID: 890 RVA: 0x00015A28 File Offset: 0x00013C28
	public bool LoadScene(string[] args)
	{
		if (args.Length > 1)
		{
			Application.LoadLevel(this.ArgsToString(args, 1));
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a scene name.");
		return false;
	}

	// Token: 0x0600037B RID: 891 RVA: 0x00015A68 File Offset: 0x00013C68
	public bool OpenURL(string[] args)
	{
		if (args.Length > 1)
		{
			Application.OpenURL(this.ArgsToString(args, 1));
			return true;
		}
		Debug.LogWarning("Command " + args[0] + " needs a url.");
		return false;
	}

	// Token: 0x0600037C RID: 892 RVA: 0x00015AA8 File Offset: 0x00013CA8
	public bool UnlockCamera(string[] args)
	{
		PhoneMemory.UnlockMenu("Cool Cam");
		return true;
	}

	// Token: 0x0600037D RID: 893 RVA: 0x00015AB8 File Offset: 0x00013CB8
	private string ArgsToString(string[] args, int startInd)
	{
		return this.ArgsToString(args, startInd, args.Length);
	}

	// Token: 0x0600037E RID: 894 RVA: 0x00015AC8 File Offset: 0x00013CC8
	private string ArgsToString(string[] args, int startInd, int endInd)
	{
		string text = string.Empty;
		for (int i = startInd; i < endInd; i++)
		{
			text = text + args[i] + " ";
		}
		return text.TrimEnd(new char[]
		{
			' '
		});
	}

	// Token: 0x0600037F RID: 895 RVA: 0x00015B10 File Offset: 0x00013D10
	private int FindArg(string[] args, string str)
	{
		for (int i = 0; i < args.Length; i++)
		{
			if (args[i] == str)
			{
				return i;
			}
		}
		return -1;
	}

	// Token: 0x040002D6 RID: 726
	private PhoneController controller;

	// Token: 0x040002D7 RID: 727
	public List<string> commandlist = new List<string>();

	// Token: 0x040002D8 RID: 728
	private Dictionary<string, PhoneParser.CommandDelegate> commandMethods = new Dictionary<string, PhoneParser.CommandDelegate>();

	// Token: 0x020000E5 RID: 229
	// (Invoke) Token: 0x060008BF RID: 2239
	private delegate bool CommandDelegate(string[] args);
}
