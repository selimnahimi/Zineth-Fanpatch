using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004E RID: 78
public class PhoneMemory : MonoBehaviour
{
	// Token: 0x1700005C RID: 92
	// (get) Token: 0x060002FA RID: 762 RVA: 0x00013254 File Offset: 0x00011454
	private static PhoneMemory main
	{
		get
		{
			if (PhoneMemory._instance == null)
			{
				PhoneMemory._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneMemory)) as PhoneMemory);
			}
			if (PhoneMemory._instance && !PhoneMemory.initialized)
			{
				PhoneMemory._instance.Initialize();
			}
			return PhoneMemory._instance;
		}
	}

	// Token: 0x1700005D RID: 93
	// (get) Token: 0x060002FB RID: 763 RVA: 0x000132B4 File Offset: 0x000114B4
	public static PhoneSettings settings
	{
		get
		{
			return PhoneMemory._settings;
		}
	}

	// Token: 0x1700005E RID: 94
	// (get) Token: 0x060002FC RID: 764 RVA: 0x000132BC File Offset: 0x000114BC
	public static bool isingame
	{
		get
		{
			return PhoneController.instance.curscreen.screenname == "GameScreen";
		}
	}

	// Token: 0x1700005F RID: 95
	// (get) Token: 0x060002FD RID: 765 RVA: 0x000132D8 File Offset: 0x000114D8
	public static bool isbattling
	{
		get
		{
			if (PhoneMemory.isingame)
			{
				PhoneShooterController phoneShooterController = PhoneController.instance.curscreen as PhoneShooterController;
				return phoneShooterController.battle_mode;
			}
			return false;
		}
	}

	// Token: 0x060002FE RID: 766 RVA: 0x00013308 File Offset: 0x00011508
	public static bool IsBattlingTrainer(NPCTrainer trainer)
	{
		return PhoneMemory.isbattling && PhoneMemory.trainer_challenge == trainer;
	}

	// Token: 0x060002FF RID: 767 RVA: 0x00013324 File Offset: 0x00011524
	public static bool MonsterChallenge(NPCTrainer trainer)
	{
		if (PhoneMemory.trainer_challenge == null)
		{
			PhoneMemory.trainer_challenge = trainer;
			PhoneMemory.game_level = PhoneResourceController.phoneshooterlevels.Count;
			return true;
		}
		return false;
	}

	// Token: 0x06000300 RID: 768 RVA: 0x0001335C File Offset: 0x0001155C
	public static bool WithdrawChallenge(NPCTrainer trainer)
	{
		if (trainer == PhoneMemory.trainer_challenge)
		{
			PhoneMemory.trainer_challenge = null;
			return true;
		}
		return false;
	}

	// Token: 0x17000060 RID: 96
	// (get) Token: 0x06000301 RID: 769 RVA: 0x00013378 File Offset: 0x00011578
	public static List<PhoneMonster> monsters
	{
		get
		{
			return PhoneMemory.main._monsters;
		}
	}

	// Token: 0x06000302 RID: 770 RVA: 0x00013384 File Offset: 0x00011584
	public static bool SaveMonsters()
	{
		bool flag = true;
		for (int i = 0; i < PhoneMemory.monsters.Count; i++)
		{
			flag = (flag && PhoneMemory.SaveMonster(i));
		}
		return flag;
	}

	// Token: 0x06000303 RID: 771 RVA: 0x000133C0 File Offset: 0x000115C0
	public static bool SaveMonster(PhoneMonster monster)
	{
		return PhoneMemory.SaveMonster(PhoneMemory.monsters.IndexOf(monster));
	}

	// Token: 0x06000304 RID: 772 RVA: 0x000133D4 File Offset: 0x000115D4
	public static bool SaveMonster(int index)
	{
		return PhoneMemory.monsters[index].SaveMonster(index);
	}

	// Token: 0x17000061 RID: 97
	// (get) Token: 0x06000305 RID: 773 RVA: 0x000133E8 File Offset: 0x000115E8
	// (set) Token: 0x06000306 RID: 774 RVA: 0x000133F4 File Offset: 0x000115F4
	public static int monster_ind
	{
		get
		{
			return PhoneMemory.main._monster_ind;
		}
		set
		{
			PhoneMemory.main._monster_ind = value;
		}
	}

	// Token: 0x17000062 RID: 98
	// (get) Token: 0x06000307 RID: 775 RVA: 0x00013404 File Offset: 0x00011604
	// (set) Token: 0x06000308 RID: 776 RVA: 0x00013418 File Offset: 0x00011618
	public static PhoneMonster main_monster
	{
		get
		{
			return PhoneMemory.monsters[PhoneMemory.monster_ind];
		}
		set
		{
			PhoneMemory.monster_ind = PhoneMemory.monsters.IndexOf(value);
		}
	}

	// Token: 0x17000063 RID: 99
	// (get) Token: 0x06000309 RID: 777 RVA: 0x0001342C File Offset: 0x0001162C
	public static PhoneShooterLevel level_obj
	{
		get
		{
			if (PhoneMemory.game_level >= PhoneResourceController.phoneshooterlevels.Count)
			{
				if (PhoneMemory.trainer_challenge)
				{
					return PhoneMemory.trainer_challenge.levelobj;
				}
				PhoneMemory.game_level = 0;
			}
			return PhoneResourceController.phoneshooterlevels[PhoneMemory.game_level];
		}
	}

	// Token: 0x17000064 RID: 100
	// (get) Token: 0x0600030A RID: 778 RVA: 0x0001347C File Offset: 0x0001167C
	// (set) Token: 0x0600030B RID: 779 RVA: 0x00013488 File Offset: 0x00011688
	public static int game_level
	{
		get
		{
			return PhoneMemory.main._game_level;
		}
		set
		{
			PhoneMemory.main._game_level = value;
		}
	}

	// Token: 0x0600030C RID: 780 RVA: 0x00013498 File Offset: 0x00011698
	public static bool IsMenuUnlocked(string menuname)
	{
		return PhoneMemory.unlocked_menus.Contains(menuname);
	}

	// Token: 0x0600030D RID: 781 RVA: 0x000134A8 File Offset: 0x000116A8
	public static void LockMenu(PhoneScreen screen)
	{
		PhoneMemory.LockMenu(screen.screenname);
	}

	// Token: 0x0600030E RID: 782 RVA: 0x000134B8 File Offset: 0x000116B8
	public static void LockMenu(string menu)
	{
		if (PhoneMemory.unlocked_menus.Contains(menu))
		{
			PhoneMemory.menus_updated = true;
			PhoneMemory.unlocked_menus.Remove(menu);
		}
	}

	// Token: 0x0600030F RID: 783 RVA: 0x000134E8 File Offset: 0x000116E8
	public static void UnlockMenu(PhoneScreen screen)
	{
		PhoneMemory.UnlockMenu(screen.screenname);
	}

	// Token: 0x06000310 RID: 784 RVA: 0x000134F8 File Offset: 0x000116F8
	public static void UnlockMenu(string menu)
	{
		if (!PhoneMemory.unlocked_menus.Contains(menu))
		{
			PhoneMemory.UnlockMenuQuiet(menu);
			PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_new_app, SoundType.menu);
		}
	}

	// Token: 0x06000311 RID: 785 RVA: 0x00013524 File Offset: 0x00011724
	public static void UnlockMenuQuiet(string menu)
	{
		if (!PhoneMemory.unlocked_menus.Contains(menu))
		{
			PhoneMemory.menus_updated = true;
			PhoneMemory.unlocked_menus.Add(menu);
		}
	}

	// Token: 0x17000065 RID: 101
	// (get) Token: 0x06000312 RID: 786 RVA: 0x00013548 File Offset: 0x00011748
	public static List<string> unlocked_menus
	{
		get
		{
			return PhoneMemory.main._unlocked_menus;
		}
	}

	// Token: 0x06000313 RID: 787 RVA: 0x00013554 File Offset: 0x00011754
	private static int CompareZines(Texture2D a, Texture2D b)
	{
		return string.Compare(a.name, b.name);
	}

	// Token: 0x06000314 RID: 788 RVA: 0x00013568 File Offset: 0x00011768
	public static void UnlockZine(int index)
	{
		if (index >= PhoneResourceController.zine_images.Count)
		{
			Debug.LogWarning("zine index is too big!");
			return;
		}
		PhoneMemory.UnlockZine(PhoneResourceController.zine_images[index]);
	}

	// Token: 0x17000066 RID: 102
	// (get) Token: 0x06000315 RID: 789 RVA: 0x000135A0 File Offset: 0x000117A0
	private static PhoneZineMenu zine_menu
	{
		get
		{
			if (PhoneMemory._zine_menu == null)
			{
				PhoneMemory._zine_menu = (UnityEngine.Object.FindObjectOfType(typeof(PhoneZineMenu)) as PhoneZineMenu);
			}
			return PhoneMemory._zine_menu;
		}
	}

	// Token: 0x06000316 RID: 790 RVA: 0x000135DC File Offset: 0x000117DC
	public static void UnlockZine(Texture2D tex)
	{
		if (!PhoneMemory.unlocked_zines.Contains(tex))
		{
			PhoneMemory.unlocked_zines.Add(tex);
			PhoneMemory.unlocked_zines.Sort(new Comparison<Texture2D>(PhoneMemory.CompareZines));
			PhoneMemory.zine_menu.zine_ind = PhoneMemory.unlocked_zines.IndexOf(tex);
		}
	}

	// Token: 0x06000317 RID: 791 RVA: 0x00013630 File Offset: 0x00011830
	public static void OnZineUnlock(int index)
	{
	}

	// Token: 0x17000067 RID: 103
	// (get) Token: 0x06000318 RID: 792 RVA: 0x00013634 File Offset: 0x00011834
	// (set) Token: 0x06000319 RID: 793 RVA: 0x00013640 File Offset: 0x00011840
	public static List<Texture2D> unlocked_zines
	{
		get
		{
			return PhoneMemory.main._unlocked_zines;
		}
		set
		{
			PhoneMemory.main._unlocked_zines = value;
		}
	}

	// Token: 0x17000068 RID: 104
	// (get) Token: 0x0600031A RID: 794 RVA: 0x00013650 File Offset: 0x00011850
	public static int new_mail
	{
		get
		{
			int num = 0;
			foreach (PhoneMail phoneMail in PhoneMemory.messages)
			{
				if (phoneMail.is_new)
				{
					num++;
				}
			}
			return num;
		}
	}

	// Token: 0x17000069 RID: 105
	// (get) Token: 0x0600031B RID: 795 RVA: 0x000136C0 File Offset: 0x000118C0
	public static List<PhoneMail> messages
	{
		get
		{
			return PhoneMemory.main._messages;
		}
	}

	// Token: 0x1700006A RID: 106
	// (get) Token: 0x0600031C RID: 796 RVA: 0x000136CC File Offset: 0x000118CC
	public static List<PhoneMail> deleted_messages
	{
		get
		{
			return PhoneMemory.main._deleted_messages;
		}
	}

	// Token: 0x0600031D RID: 797 RVA: 0x000136D8 File Offset: 0x000118D8
	public static void SendMail(string id)
	{
		PhoneMail phoneMail = MailController.FindMail(id);
		if (phoneMail == null)
		{
			Debug.LogWarning("Mail id does not exist: " + id);
		}
		else
		{
			PhoneMemory.SendMail(phoneMail);
		}
	}

	// Token: 0x0600031E RID: 798 RVA: 0x00013710 File Offset: 0x00011910
	public static void SendMail(PhoneMail mail)
	{
		PhoneController.instance.OnNewMessage(1);
		PhoneMemory.SendMailQuiet(mail);
	}

	// Token: 0x0600031F RID: 799 RVA: 0x00013724 File Offset: 0x00011924
	public static void SendMailQuiet(string id)
	{
		PhoneMail phoneMail = MailController.FindMail(id);
		if (phoneMail == null)
		{
			Debug.LogWarning("Mail id does not exist: " + id);
		}
		else
		{
			PhoneMemory.SendMailQuiet(phoneMail);
		}
	}

	// Token: 0x06000320 RID: 800 RVA: 0x0001375C File Offset: 0x0001195C
	public static void SendMailQuiet(PhoneMail mail)
	{
		if (mail.time.Ticks == 0L)
		{
			mail.time = DateTime.Now;
		}
		if (!PhoneMemory.messages.Contains(mail))
		{
			PhoneMemory.messages.Insert(0, mail);
			PhoneMemory.mail_updated = true;
			if (!PhoneMemory._setting_up)
			{
				PhoneMemory.SaveMail();
			}
		}
	}

	// Token: 0x06000321 RID: 801 RVA: 0x000137B8 File Offset: 0x000119B8
	public static PhoneMail GetMail(string id)
	{
		PhoneMail phoneMail = MailController.FindMail(id);
		if (PhoneMemory.messages.Contains(phoneMail))
		{
			return phoneMail;
		}
		return null;
	}

	// Token: 0x06000322 RID: 802 RVA: 0x000137E0 File Offset: 0x000119E0
	public static PhoneMail GetMail(int ind)
	{
		return PhoneMemory.messages[ind];
	}

	// Token: 0x06000323 RID: 803 RVA: 0x000137F0 File Offset: 0x000119F0
	public static bool DeleteMail(PhoneMail mailobj)
	{
		PhoneMemory.deleted_messages.Add(mailobj);
		PhoneMemory.messages.Remove(mailobj);
		PhoneMemory.mail_updated = true;
		return true;
	}

	// Token: 0x06000324 RID: 804 RVA: 0x00013810 File Offset: 0x00011A10
	public static bool DeleteMail(int ind)
	{
		PhoneMemory.deleted_messages.Add(PhoneMemory.messages[ind]);
		PhoneMemory.messages.RemoveAt(ind);
		PhoneMemory.mail_updated = true;
		return true;
	}

	// Token: 0x06000325 RID: 805 RVA: 0x00013844 File Offset: 0x00011A44
	public static void AddCapsulePoints(float amount)
	{
		PhoneMemory.capsule_points += amount;
	}

	// Token: 0x1700006B RID: 107
	// (get) Token: 0x06000326 RID: 806 RVA: 0x00013854 File Offset: 0x00011A54
	// (set) Token: 0x06000327 RID: 807 RVA: 0x00013860 File Offset: 0x00011A60
	public static float capsule_points
	{
		get
		{
			return PhoneMemory.main._capsule_points;
		}
		set
		{
			PhoneMemory.main._capsule_points = value;
		}
	}

	// Token: 0x1700006C RID: 108
	// (get) Token: 0x06000328 RID: 808 RVA: 0x00013870 File Offset: 0x00011A70
	// (set) Token: 0x06000329 RID: 809 RVA: 0x000138A0 File Offset: 0x00011AA0
	public float _capsule_points
	{
		get
		{
			if (this.__capsule_points == float.NegativeInfinity)
			{
				this.__capsule_points = PlayerPrefs.GetFloat("cash", 0f);
			}
			return this.__capsule_points;
		}
		set
		{
			this.__capsule_points = value;
			if (this.__capsule_points != float.NegativeInfinity)
			{
				PlayerPrefs.SetFloat("cash", value);
			}
		}
	}

	// Token: 0x0600032A RID: 810 RVA: 0x000138D0 File Offset: 0x00011AD0
	public static void ResetCapsulePoints()
	{
		PhoneMemory.capsule_points = float.NegativeInfinity;
	}

	// Token: 0x0600032B RID: 811 RVA: 0x000138DC File Offset: 0x00011ADC
	private void Awake()
	{
		if (!PhoneMemory.initialized)
		{
			this.Initialize();
		}
		if (Application.loadedLevelName == "Loader 1" || Application.loadedLevelName == "test")
		{
			this.BeginGame();
		}
		foreach (PhoneMail mailobj in this.mail_auto_list)
		{
			MailController.AddMail(mailobj);
		}
	}

	// Token: 0x0600032C RID: 812 RVA: 0x0001394C File Offset: 0x00011B4C
	public void Initialize()
	{
		PhoneMemory.initialized = true;
		PhoneMemory._settings = new PhoneSettings();
		float master_volume = PhoneMemory.settings.master_volume;
		this.SetupMail();
		this.SetupColors();
		this.SetupScreens();
	}

	// Token: 0x0600032D RID: 813 RVA: 0x00013988 File Offset: 0x00011B88
	private void BeginGame()
	{
		PlayerPrefs.SetString("version", PhoneInterface.version);
		PlayerPrefs.SetInt("times_file_played", PlayerPrefs.GetInt("times_file_played", 0) + 1);
		this.SetupMonsters();
		this.SetupZines();
		MailController.active_mail.Clear();
		if (!string.IsNullOrEmpty(PlayerPrefs.GetString("mail_string", string.Empty)))
		{
			PhoneMemory.LoadMail();
		}
		else
		{
			foreach (PhoneMail phoneMail in MailController.all_mail.Values)
			{
				phoneMail.is_new = true;
			}
			MailController.FindMail("jobOffer").is_new = false;
			MailController.FindMail("bank").is_new = false;
			MailController.SendMail("bank");
			MailController.SendMail("jobOffer");
			MailController.SendMail("intro_1");
		}
		foreach (PhoneMail phoneMail2 in PhoneMemory.extra_mail_add)
		{
			MailController.SendMail(phoneMail2.id);
		}
		if (PlayerPrefs.GetInt("cool_cam", 0) == 1)
		{
			PhoneMemory.UnlockMenuQuiet("Cool Cam");
		}
	}

	// Token: 0x0600032E RID: 814 RVA: 0x00013B08 File Offset: 0x00011D08
	public static void LoadMail()
	{
		string @string = PlayerPrefs.GetString("mail_string", string.Empty);
		string[] array = @string.Split(new char[]
		{
			'|'
		});
		PhoneMemory._setting_up = true;
		for (int i = array.Length - 1; i >= 0; i--)
		{
			string text = array[i];
			bool is_new = false;
			if (text.StartsWith("!"))
			{
				is_new = true;
				text = text.TrimStart(new char[]
				{
					'!'
				});
			}
			PhoneMail phoneMail = MailController.FindMail(text);
			if (phoneMail != null)
			{
				phoneMail.is_new = is_new;
				PhoneMemory.SendMailQuiet(phoneMail);
			}
		}
		PhoneMemory._setting_up = false;
	}

	// Token: 0x0600032F RID: 815 RVA: 0x00013BA4 File Offset: 0x00011DA4
	public static void SaveMail()
	{
		string text = string.Empty;
		foreach (PhoneMail phoneMail in PhoneMemory.messages)
		{
			if (!phoneMail.id.StartsWith("npc_"))
			{
				string text2 = string.Format("{0}|", phoneMail.id);
				if (phoneMail.is_new)
				{
					text2 = string.Format("!{0}", text2);
				}
				text += text2;
			}
		}
		text = text.TrimEnd(new char[]
		{
			'|'
		});
		PlayerPrefs.SetString("mail_string", text);
	}

	// Token: 0x06000330 RID: 816 RVA: 0x00013C70 File Offset: 0x00011E70
	private void SetupMonsters()
	{
		for (int i = 0; i < PhoneMemory.max_num_monsters; i++)
		{
			this.InitMonster(i);
		}
	}

	// Token: 0x06000331 RID: 817 RVA: 0x00013C9C File Offset: 0x00011E9C
	private void InitMonster(int index)
	{
		PhoneMonster phoneMonster;
		if (!string.IsNullOrEmpty(PlayerPrefs.GetString("monster" + index + "_namef", string.Empty)))
		{
			phoneMonster = PhoneMonster.LoadMonster(index);
		}
		else
		{
			phoneMonster = new PhoneMonster(1f);
			phoneMonster.SaveMonster(index);
		}
		while (PhoneMemory.monsters.Count <= index)
		{
			PhoneMemory.monsters.Add(null);
		}
		PhoneMemory.monsters[index] = phoneMonster;
	}

	// Token: 0x06000332 RID: 818 RVA: 0x00013D20 File Offset: 0x00011F20
	public static void ResetMonsters()
	{
		while (PhoneMemory.monsters.Count < PhoneMemory.max_num_monsters)
		{
			PhoneMemory.monsters.Add(null);
		}
		for (int i = 0; i < PhoneMemory.max_num_monsters; i++)
		{
			PhoneMonster phoneMonster = new PhoneMonster(1f);
			if (i >= PhoneMemory.monsters.Count)
			{
				PhoneMemory.monsters.Add(phoneMonster);
			}
			else
			{
				PhoneMemory.monsters[i] = phoneMonster;
			}
		}
		PhoneMemory.SaveMonsters();
	}

	// Token: 0x06000333 RID: 819 RVA: 0x00013DA4 File Offset: 0x00011FA4
	private void DebugResetMonsters()
	{
		for (int i = 1; i < 6; i++)
		{
			this._monsters.Add(new PhoneMonster((float)i));
		}
	}

	// Token: 0x06000334 RID: 820 RVA: 0x00013DD8 File Offset: 0x00011FD8
	private void SetupZines()
	{
		if (PhoneMemory.unlocked_zines.Count <= 0)
		{
			PhoneMemory.unlocked_zines = new List<Texture2D>();
			if (PhoneResourceController.zine_images.Count > 0)
			{
				PhoneMemory.UnlockZine(0);
			}
			if (PhoneResourceController.zine_images.Count > 1)
			{
				PhoneMemory.UnlockZine(1);
			}
		}
	}

	// Token: 0x06000335 RID: 821 RVA: 0x00013E2C File Offset: 0x0001202C
	private void SetupScreens()
	{
		if (PhoneMemory.unlocked_menus.Count == 0)
		{
			PhoneMemory.unlocked_menus.Add("Mail");
		}
	}

	// Token: 0x06000336 RID: 822 RVA: 0x00013E4C File Offset: 0x0001204C
	private void SetupMail()
	{
		foreach (PhoneMail mailobj in this.mail_auto_list)
		{
			MailController.AddMail(mailobj);
		}
		MailController.AddMail(new PhoneMail
		{
			id = "bank",
			subject = "Loan Approved",
			sender = "BigBank",
			body = "Dear sir,                 We are writing to let you know that your loan of $180,000,000,000 desert dollars has been approved.  Please remember to send all monthly payments in on time, and thank you for choosing BigBank for all your big banking needs.",
			is_new = false
		});
		MailController.AddMail(new PhoneMail
		{
			id = "jobOffer",
			subject = "Re: Help Wanted",
			sender = "Zine Boss",
			body = "The job's yours!  You can start tomorrow at 9AM sharp.  The pay's based on  how well the zine sells.  That robot suit of yours should make the job much easier.                  Welcome aboard!",
			is_new = false
		});
		MailController.AddMail(new PhoneMail
		{
			id = "intro_1",
			subject = "Where are you?",
			sender = "Zine Boss",
			body = "What's going on? You need to get over here now!",
			is_new = true
		});
		MailController.AddMail(new PhoneMail
		{
			id = "intro_2",
			subject = "Lost?",
			sender = "Zine Boss",
			body = "Did you get lost? I sent you my position. Please just get here.",
			open_command = "mission_activate Intro_1|mission_focus Intro_1",
			accept_command = "load_screen Map"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "CactusMissionMail",
			subject = "Spikey Job",
			sender = "Zine Boss",
			body = "I've got a new job for you. We need to make some cactus paper for the next batch of zines, but I'm really scared of needles. Break open 10 cacti and bring me back the chunks.",
			open_command = "mission_activate CactusBreak"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "LostPages",
			subject = "Missed you",
			sender = "Zine Boss",
			body = "Had to jet out.  I accidentally dropped a few pages meant for the new zine.  The wind had its way with them, but they should all be nearby.  Grab them for me please!",
			open_command = "mission_activate LostPages|mission_focus LostPages"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "DeliverZines",
			subject = "Delivery",
			sender = "Zine Boss",
			body = "You finished picking up those zine pages yet?  I need you to go towards the city and hand them out to anyone and everyone.",
			open_command = "mission_activate DeliverZines|mission_focus DeliverZines"
		});
		PhoneMail phoneMail = new PhoneMail();
		phoneMail.id = "intro_twitter";
		phoneMail.subject = "Free Twitter App";
		phoneMail.sender = "Catco";
		phoneMail.body = "We are excited to offer you our new Twitter application! Click on the download link to install it.";
		phoneMail.can_reply = true;
		phoneMail.accept_command = "menu_unlock Twitter";
		phoneMail.accept_button_text = "Download";
		MailController.AddMail(new PhoneMail
		{
			id = "tut_capsule",
			subject = "Capsule Quest!",
			sender = "Catco",
			body = "Thank you for entering Capsule Quest! Find capsules to gain capsule points! Redeem them to upgrade your Catco monsters. Your game is waiting!"
		});
		MailController.AddMail(new PhoneMail("test_test", "Mail Test", "This text is designed to mimic an actual message. It contains little content.", "Tester"));
		MailController.AddMail(new PhoneMail("test_noodles", "RE:NOODLES", "Alert! New Flavors of NOODLESOOP have been spotted in the area. Please keep your eyes open!", "Noodle Club"));
		MailController.AddMail(new PhoneMail("test_meeting", "Hi", "Hey, how are you doing? Please meet me in Pizza Town tomorrow at 2:00PM.", "Pep"));
		MailController.AddMail(new PhoneMail
		{
			id = "test_job",
			subject = "Job for you!",
			sender = "Job Dude",
			body = "I have a job for you. I want you to go to a few checkpoints. Do you think you can handle it?",
			can_reply = true,
			accept_command = "load_screen Missions|mission_activate Test"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "test_points",
			subject = "Free Points",
			sender = "Gamedave",
			body = "Here are some free points to make the testing process easier.",
			can_reply = true,
			accept_command = "capsule_points_add 999"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "test_trap",
			subject = "Free Cash",
			sender = "Secret",
			body = "Don't spend it all in one place!",
			can_reply = true,
			accept_command = "capsule_points_add 999|mail_send test_arrest"
		});
		MailController.AddMail(new PhoneMail
		{
			id = "test_arrest",
			subject = "Busted!",
			sender = "Cops",
			body = "You are under arrest for accepting stolen cash! Nice try, buddy.",
			can_reply = true,
			accept_command = "load_screen PhoneJail",
			close_command = "load_screen PhoneJail"
		});
		DateTime now = DateTime.Now;
		if (now.Month == 10 && now.Day == 31)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_halloween";
			phoneMail.subject = "Warning...";
			phoneMail.body = "This message is FILLED with Occult/Supernatural content... it's too late! You are already haunted...";
			phoneMail.sender = "???";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		if (now.Month == 1 && now.Day == 1)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_s_newyears";
			phoneMail.subject = "Happy New Years";
			phoneMail.body = "It's a great day for everyone";
			phoneMail.sender = "Mr Time";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		if (now.Month == 7 && now.Day == 4)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_s_independence";
			phoneMail.subject = "Are you alone?";
			phoneMail.body = "It's a good day to be independent... haha (joke)";
			phoneMail.sender = "???";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		if (now.Month == 12 && now.Day == 25)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_s_xmas";
			phoneMail.subject = "Cool.. wow";
			phoneMail.body = "I hope you're happy...";
			phoneMail.sender = "-Signed: XXX";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		if (now.Month == 2 && now.Day == 2)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_s_groundhog";
			phoneMail.subject = "Fatal warning...";
			phoneMail.body = "This is a very dangerous day. Please stay indoors at all times.";
			phoneMail.sender = "PSA";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		if (now.Month == 4 && now.Day == 1)
		{
			phoneMail = new PhoneMail();
			phoneMail.id = "npc_s_fools";
			phoneMail.subject = "The joke's on you...";
			phoneMail.body = "That's It";
			phoneMail.sender = "The Joke Master";
			PhoneMemory.extra_mail_add.Add(phoneMail);
		}
		foreach (PhoneMail mailobj2 in PhoneMemory.extra_mail_add)
		{
			MailController.AddMail(mailobj2);
		}
	}

	// Token: 0x06000337 RID: 823 RVA: 0x000144D8 File Offset: 0x000126D8
	private void SetupColors()
	{
		PhoneColorPallete phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.text = this.QCol(10, 18, 10);
		phoneColorPallete.selectable = this.QCol(240, 200, 240);
		phoneColorPallete.selected = this.QCol(255, 255, 255);
		phoneColorPallete.back = this.QCol(154, 245, 184);
		this.colorthemes.Add("old", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.text = this.QCol(252, 235, 182);
		phoneColorPallete.selectable = this.QCol(240, 120, 24);
		phoneColorPallete.selected = this.QCol(240, 168, 48);
		phoneColorPallete.back = this.QCol(94, 65, 47);
		this.colorthemes.Add("papua", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.text = this.QCol(48, 98, 48);
		phoneColorPallete.selectable = this.QCol(139, 172, 15);
		phoneColorPallete.selected = this.QCol(155, 188, 15);
		phoneColorPallete.back = this.QCol(15, 56, 15);
		this.colorthemes.Add("gameboy", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.text = this.QCol(60, 50, 81);
		phoneColorPallete.selectable = this.QCol(168, 212, 111);
		phoneColorPallete.selected = this.QCol(53, 150, 104);
		phoneColorPallete.back = this.QCol(255, 237, 144);
		this.colorthemes.Add("moment", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(244, 252, 232);
		phoneColorPallete.text = this.QCol(195, 255, 104);
		phoneColorPallete.selectable = this.QCol(78, 150, 137);
		phoneColorPallete.selected = this.QCol(126, 208, 214);
		this.colorthemes.Add("frogs", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(233, 233, 233);
		phoneColorPallete.text = this.QCol(66, 66, 66);
		phoneColorPallete.selectable = this.QCol(188, 188, 188);
		phoneColorPallete.selected = this.QCol(255, 153, 0);
		this.colorthemes.Add("gamebookers", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(152, 127, 105);
		phoneColorPallete.text = this.QCol(253, 241, 204);
		phoneColorPallete.selectable = this.QCol(227, 173, 64);
		phoneColorPallete.selected = this.QCol(252, 208, 54);
		phoneColorPallete.particles = phoneColorPallete.selected;
		this.colorthemes.Add("honey", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(0, 0, 0);
		phoneColorPallete.text = this.QCol(255, 255, 255);
		phoneColorPallete.selectable = this.QCol(231, 80, 80);
		phoneColorPallete.selected = this.QCol(255, 20, 20);
		phoneColorPallete.particles = phoneColorPallete.selected;
		this.colorthemes.Add("black", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(255, 255, 255);
		phoneColorPallete.text = this.QCol(0, 0, 0);
		phoneColorPallete.selectable = this.QCol(42, 42, 84);
		phoneColorPallete.selected = this.QCol(50, 50, 140);
		phoneColorPallete.particles = phoneColorPallete.selected;
		this.colorthemes.Add("white", phoneColorPallete);
		phoneColorPallete = new PhoneColorPallete();
		phoneColorPallete.back = this.QCol(53, 49, 48);
		phoneColorPallete.text = this.QCol(203, 207, 180);
		phoneColorPallete.selectable = this.QCol(171, 106, 110);
		phoneColorPallete.selected = this.QCol(247, 52, 91);
		phoneColorPallete.particles = phoneColorPallete.selected;
		this.colorthemes.Add("killer", phoneColorPallete);
		PhoneMemory.settings.pallete = this.colorthemes["white"];
	}

	// Token: 0x06000338 RID: 824 RVA: 0x000149A0 File Offset: 0x00012BA0
	private Color QCol(int r1, int g1, int b1)
	{
		return new Color((float)r1 / 255f, (float)g1 / 255f, (float)b1 / 255f);
	}

	// Token: 0x06000339 RID: 825 RVA: 0x000149C0 File Offset: 0x00012BC0
	private PhoneColorPallete QuickColorAdder(string name, int r1, int g1, int b1, int r2, int g2, int b2, int r3, int g3, int b3)
	{
		PhoneColorPallete phoneColorPallete = new PhoneColorPallete(this.QCol(r1, g1, b1), this.QCol(r2, g2, b2), this.QCol(r2, g2, b2), this.QCol(r3, g3, b3));
		this.colorthemes.Add(name, phoneColorPallete);
		return phoneColorPallete;
	}

	// Token: 0x040002B3 RID: 691
	private static PhoneMemory _instance;

	// Token: 0x040002B4 RID: 692
	public static int phoneGameScore = 0;

	// Token: 0x040002B5 RID: 693
	public static NPCTrainer trainer_challenge;

	// Token: 0x040002B6 RID: 694
	public static bool menus_updated = false;

	// Token: 0x040002B7 RID: 695
	public List<string> _unlocked_menus = new List<string>();

	// Token: 0x040002B8 RID: 696
	private static PhoneZineMenu _zine_menu;

	// Token: 0x040002B9 RID: 697
	public List<Texture2D> _unlocked_zines;

	// Token: 0x040002BA RID: 698
	public static bool mail_updated;

	// Token: 0x040002BB RID: 699
	public static PhoneSettings _settings;

	// Token: 0x040002BC RID: 700
	public List<PhoneMonster> _monsters = new List<PhoneMonster>();

	// Token: 0x040002BD RID: 701
	public int _monster_ind;

	// Token: 0x040002BE RID: 702
	public int _game_level;

	// Token: 0x040002BF RID: 703
	public List<PhoneMail> _messages = new List<PhoneMail>();

	// Token: 0x040002C0 RID: 704
	public List<PhoneMail> _deleted_messages = new List<PhoneMail>();

	// Token: 0x040002C1 RID: 705
	private float __capsule_points = float.NegativeInfinity;

	// Token: 0x040002C2 RID: 706
	public static bool initialized = false;

	// Token: 0x040002C3 RID: 707
	private static List<PhoneMail> extra_mail_add = new List<PhoneMail>();

	// Token: 0x040002C4 RID: 708
	private static bool _setting_up = false;

	// Token: 0x040002C5 RID: 709
	public static int max_num_monsters = 2;

	// Token: 0x040002C6 RID: 710
	public PhoneMail[] mail_auto_list = new PhoneMail[0];

	// Token: 0x040002C7 RID: 711
	public Dictionary<string, PhoneColorPallete> colorthemes = new Dictionary<string, PhoneColorPallete>();
}
