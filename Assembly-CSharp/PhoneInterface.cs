using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200004D RID: 77
public class PhoneInterface : MonoBehaviour
{
	// Token: 0x17000051 RID: 81
	// (get) Token: 0x060002D2 RID: 722 RVA: 0x00012988 File Offset: 0x00010B88
	public static PhoneViewController view_controller
	{
		get
		{
			if (PhoneInterface._view_controller == null)
			{
				PhoneInterface._view_controller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneViewController)) as PhoneViewController);
			}
			return PhoneInterface._view_controller;
		}
	}

	// Token: 0x17000052 RID: 82
	// (get) Token: 0x060002D3 RID: 723 RVA: 0x000129C4 File Offset: 0x00010BC4
	public static SpawnPointScript spawn_point_script
	{
		get
		{
			if (!PhoneInterface._spawn_point_script)
			{
				PhoneInterface._spawn_point_script = (UnityEngine.Object.FindObjectOfType(typeof(SpawnPointScript)) as SpawnPointScript);
			}
			return PhoneInterface._spawn_point_script;
		}
	}

	// Token: 0x17000053 RID: 83
	// (get) Token: 0x060002D4 RID: 724 RVA: 0x000129F4 File Offset: 0x00010BF4
	public static Transform player_trans
	{
		get
		{
			if (PhoneInterface.instance._player_trans == null)
			{
				GameObject gameObject = GameObject.Find("Player");
				if (!gameObject)
				{
					return null;
				}
				PhoneInterface.instance._player_trans = gameObject.transform;
			}
			return PhoneInterface.instance._player_trans;
		}
	}

	// Token: 0x17000054 RID: 84
	// (get) Token: 0x060002D5 RID: 725 RVA: 0x00012A48 File Offset: 0x00010C48
	public static move player_move
	{
		get
		{
			if (PhoneInterface._player_move == null)
			{
				PhoneInterface._player_move = (UnityEngine.Object.FindObjectOfType(typeof(move)) as move);
			}
			return PhoneInterface._player_move;
		}
	}

	// Token: 0x060002D6 RID: 726 RVA: 0x00012A84 File Offset: 0x00010C84
	private static void FindRobotMaterials()
	{
		List<Material> list = new List<Material>();
		GameObject gameObject = GameObject.Find("Holder");
		if (gameObject == null)
		{
			return;
		}
		Renderer[] componentsInChildren = gameObject.transform.FindChild("main_character").FindChild("geometry_GRP").gameObject.GetComponentsInChildren<Renderer>();
		foreach (Renderer renderer in componentsInChildren)
		{
			if (renderer.material.name.StartsWith("mechcolors"))
			{
				list.Add(renderer.material);
			}
		}
		PhoneInterface._robot_materials = new Material[list.Count];
		for (int j = 0; j < list.Count; j++)
		{
			PhoneInterface._robot_materials[j] = list[j];
		}
	}

	// Token: 0x17000055 RID: 85
	// (get) Token: 0x060002D7 RID: 727 RVA: 0x00012B58 File Offset: 0x00010D58
	private static Material[] robot_materials
	{
		get
		{
			if (PhoneInterface._robot_materials == null)
			{
				PhoneInterface.FindRobotMaterials();
			}
			return PhoneInterface._robot_materials;
		}
	}

	// Token: 0x17000056 RID: 86
	// (get) Token: 0x060002D8 RID: 728 RVA: 0x00012B70 File Offset: 0x00010D70
	public static Material robot_material
	{
		get
		{
			if (PhoneInterface._robot_material == null)
			{
				PhoneInterface._robot_material = GameObject.Find("l_robo_arm").renderer.sharedMaterial;
			}
			return PhoneInterface._robot_material;
		}
	}

	// Token: 0x17000057 RID: 87
	// (get) Token: 0x060002D9 RID: 729 RVA: 0x00012BAC File Offset: 0x00010DAC
	// (set) Token: 0x060002DA RID: 730 RVA: 0x00012BBC File Offset: 0x00010DBC
	public static Color robotColor
	{
		get
		{
			return PhoneInterface.robot_materials[0].color;
		}
		set
		{
			foreach (Material material in PhoneInterface.robot_materials)
			{
				material.color = value;
			}
		}
	}

	// Token: 0x17000058 RID: 88
	// (get) Token: 0x060002DB RID: 731 RVA: 0x00012BF0 File Offset: 0x00010DF0
	public static PhoneInterface instance
	{
		get
		{
			if (!PhoneInterface._instance)
			{
				PhoneInterface._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneInterface)) as PhoneInterface);
			}
			return PhoneInterface._instance;
		}
	}

	// Token: 0x17000059 RID: 89
	// (get) Token: 0x060002DC RID: 732 RVA: 0x00012C20 File Offset: 0x00010E20
	public static HawkBehavior hawk
	{
		get
		{
			if (!PhoneInterface._hawk)
			{
				PhoneInterface._hawk = GameObject.Find("Hawk").GetComponent<HawkBehavior>();
			}
			return PhoneInterface._hawk;
		}
	}

	// Token: 0x1700005A RID: 90
	// (get) Token: 0x060002DD RID: 733 RVA: 0x00012C58 File Offset: 0x00010E58
	public static PlayerTrail playerTrail
	{
		get
		{
			if (PhoneInterface._playerTrail == null)
			{
				PhoneInterface._playerTrail = PhoneInterface.player_trans.GetComponent<PlayerTrail>();
			}
			return PhoneInterface._playerTrail;
		}
	}

	// Token: 0x1700005B RID: 91
	// (get) Token: 0x060002DE RID: 734 RVA: 0x00012C8C File Offset: 0x00010E8C
	// (set) Token: 0x060002DF RID: 735 RVA: 0x00012C98 File Offset: 0x00010E98
	public static Color trailColor
	{
		get
		{
			return PhoneInterface.playerTrail.color;
		}
		set
		{
			PhoneInterface.playerTrail.color = value;
		}
	}

	// Token: 0x060002E0 RID: 736 RVA: 0x00012CA8 File Offset: 0x00010EA8
	public static void AddPhoneMail(PhoneMail mail)
	{
		PhoneMemory.SendMail(mail);
	}

	// Token: 0x060002E1 RID: 737 RVA: 0x00012CB0 File Offset: 0x00010EB0
	public static bool SendPhoneCommand(string command)
	{
		return PhoneController.DoPhoneCommand(command);
	}

	// Token: 0x060002E2 RID: 738 RVA: 0x00012CB8 File Offset: 0x00010EB8
	public static void AddCapsulePoints(float amount)
	{
		PhoneMemory.AddCapsulePoints(amount);
	}

	// Token: 0x060002E3 RID: 739 RVA: 0x00012CC0 File Offset: 0x00010EC0
	public static bool SummonHawk()
	{
		if (!PhoneInterface.hawk)
		{
			return false;
		}
		PhoneInterface.hawk.inBounds = true;
		PhoneInterface.hawk.active = true;
		PhoneInterface.hawk.timeFollowed = PhoneInterface.hawk.maxTimeFollowed - 0.1f;
		PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_ring_long);
		return true;
	}

	// Token: 0x060002E4 RID: 740 RVA: 0x00012D20 File Offset: 0x00010F20
	public static bool IsZineVisible()
	{
		return PhoneInterface.view_controller.showing_zine;
	}

	// Token: 0x060002E5 RID: 741 RVA: 0x00012D2C File Offset: 0x00010F2C
	public static bool HideZine()
	{
		return PhoneInterface.view_controller.HideZine();
	}

	// Token: 0x060002E6 RID: 742 RVA: 0x00012D38 File Offset: 0x00010F38
	public static bool ShowZine(int index)
	{
		return PhoneInterface.ShowZine(PhoneResourceController.zine_images[index]);
	}

	// Token: 0x060002E7 RID: 743 RVA: 0x00012D4C File Offset: 0x00010F4C
	public static bool ShowZine(Texture2D texture)
	{
		return PhoneInterface.view_controller.ShowZine(texture);
	}

	// Token: 0x060002E8 RID: 744 RVA: 0x00012D5C File Offset: 0x00010F5C
	public static bool ShowZine(Texture2D texture, bool resize)
	{
		return PhoneInterface.view_controller.ShowZine(texture, resize);
	}

	// Token: 0x060002E9 RID: 745 RVA: 0x00012D6C File Offset: 0x00010F6C
	public static List<MissionObject> GetActiveMissions()
	{
		return MissionController.active_missions;
	}

	// Token: 0x060002EA RID: 746 RVA: 0x00012D74 File Offset: 0x00010F74
	public static int GetPhoneScore()
	{
		return PhoneMemory.phoneGameScore;
	}

	// Token: 0x060002EB RID: 747 RVA: 0x00012D7C File Offset: 0x00010F7C
	public static float GetPlayerSpeed()
	{
		return PhoneInterface.player_trans.InverseTransformDirection(PhoneInterface.player_trans.rigidbody.velocity).z;
	}

	// Token: 0x060002EC RID: 748 RVA: 0x00012DAC File Offset: 0x00010FAC
	public static float GetStat(string stat)
	{
		if (stat == "phone_score")
		{
			return (float)PhoneInterface.GetPhoneScore();
		}
		if (stat == "player_speed")
		{
			return PhoneInterface.GetPlayerSpeed();
		}
		Debug.LogWarning("unknown stat: " + stat);
		return -1f;
	}

	// Token: 0x060002ED RID: 749 RVA: 0x00012DFC File Offset: 0x00010FFC
	public static void ClearAllData()
	{
		PlayerPrefs.DeleteAll();
	}

	// Token: 0x060002EE RID: 750 RVA: 0x00012E04 File Offset: 0x00011004
	public static void ClearGameData()
	{
		PhoneInterface.ClearGameData(false);
	}

	// Token: 0x060002EF RID: 751 RVA: 0x00012E0C File Offset: 0x0001100C
	public static void ClearGameData(bool keepMonsters)
	{
		PhoneInterface.int_dic.Clear();
		PhoneInterface.float_dic.Clear();
		PhoneInterface.string_dic.Clear();
		PhoneInterface.StoreInfo("version_number", PhoneInterface.version);
		PhoneInterface.StoreInfoInt("tried_tutorial");
		PhoneInterface.StoreInfo("allow_twitter", 1);
		PhoneInterface.StoreInfoString("TwitterUserID");
		PhoneInterface.StoreInfoString("TwitterUserScreenName");
		PhoneInterface.StoreInfoString("TwitterUserToken");
		PhoneInterface.StoreInfoString("TwitterUserTokenSecret");
		PhoneInterface.StoreInfo("volume_master", 0.75f);
		PhoneInterface.StoreInfo("volume_menu", 1f);
		PhoneInterface.StoreInfo("volume_ring", 1f);
		PhoneInterface.StoreInfo("volume_game", 1f);
		PhoneInterface.StoreInfo("volume_music", 0.5f);
		PhoneInterface.StoreInfo("volume_vibrate", 0.75f);
		List<PhoneMonster> list = new List<PhoneMonster>();
		if (keepMonsters)
		{
			for (int i = 0; i < 10; i++)
			{
				if (PhoneMonster.SaveDataExists(i))
				{
					list.Add(PhoneMonster.LoadMonster(i));
				}
			}
			PhoneInterface.StoreInfo("cash", 0f);
			PhoneInterface.StoreInfoInt("debug_boost");
			PhoneInterface.StoreInfoInt("cool_cam");
			PhoneInterface.StoreInfoInt("hover_time");
		}
		PhoneInterface.ClearAllData();
		foreach (string key in PhoneInterface.int_dic.Keys)
		{
			PlayerPrefs.SetInt(key, PhoneInterface.int_dic[key]);
		}
		foreach (string key2 in PhoneInterface.float_dic.Keys)
		{
			PlayerPrefs.SetFloat(key2, PhoneInterface.float_dic[key2]);
		}
		foreach (string key3 in PhoneInterface.string_dic.Keys)
		{
			PlayerPrefs.SetString(key3, PhoneInterface.string_dic[key3]);
		}
		if (keepMonsters)
		{
			for (int j = 0; j < list.Count; j++)
			{
				list[j].SaveMonster(j);
			}
		}
	}

	// Token: 0x060002F0 RID: 752 RVA: 0x000130B0 File Offset: 0x000112B0
	private static void StoreInfoInt(string pref_name)
	{
		if (PlayerPrefs.HasKey(pref_name))
		{
			PhoneInterface.int_dic.Add(pref_name, PlayerPrefs.GetInt(pref_name));
		}
	}

	// Token: 0x060002F1 RID: 753 RVA: 0x000130D0 File Offset: 0x000112D0
	private static void StoreInfo(string pref_name, int default_val)
	{
		PhoneInterface.int_dic.Add(pref_name, PlayerPrefs.GetInt(pref_name, default_val));
	}

	// Token: 0x060002F2 RID: 754 RVA: 0x000130E4 File Offset: 0x000112E4
	private static void StoreInfoFloat(string pref_name)
	{
		if (PlayerPrefs.HasKey(pref_name))
		{
			PhoneInterface.float_dic.Add(pref_name, PlayerPrefs.GetFloat(pref_name));
		}
	}

	// Token: 0x060002F3 RID: 755 RVA: 0x00013104 File Offset: 0x00011304
	private static void StoreInfo(string pref_name, float default_val)
	{
		PhoneInterface.float_dic.Add(pref_name, PlayerPrefs.GetFloat(pref_name, default_val));
	}

	// Token: 0x060002F4 RID: 756 RVA: 0x00013118 File Offset: 0x00011318
	private static void StoreInfoString(string pref_name)
	{
		if (PlayerPrefs.HasKey(pref_name))
		{
			PhoneInterface.string_dic.Add(pref_name, PlayerPrefs.GetString(pref_name));
		}
	}

	// Token: 0x060002F5 RID: 757 RVA: 0x00013138 File Offset: 0x00011338
	private static void StoreInfo(string pref_name, string default_val)
	{
		PhoneInterface.string_dic.Add(pref_name, PlayerPrefs.GetString(pref_name, default_val));
	}

	// Token: 0x060002F6 RID: 758 RVA: 0x0001314C File Offset: 0x0001134C
	private void Awake()
	{
		if (PhoneInterface._instance == null)
		{
			PhoneInterface._instance = this;
		}
		if (PhoneInterface.player_trans)
		{
			PhoneInterface.FindRobotMaterials();
		}
	}

	// Token: 0x060002F7 RID: 759 RVA: 0x00013184 File Offset: 0x00011384
	public static void UnlockCamera()
	{
		if (PlayerPrefs.GetInt("cool_cam", 0) != 1)
		{
			PlayerPrefs.SetInt("cool_cam", 1);
		}
		PhoneMemory.SendMail("cool_cam_mail");
	}

	// Token: 0x040002A6 RID: 678
	public static string version = "v0.0.1f";

	// Token: 0x040002A7 RID: 679
	private static PhoneViewController _view_controller;

	// Token: 0x040002A8 RID: 680
	private static SpawnPointScript _spawn_point_script;

	// Token: 0x040002A9 RID: 681
	public Transform _player_trans;

	// Token: 0x040002AA RID: 682
	private static move _player_move;

	// Token: 0x040002AB RID: 683
	private static Material[] _robot_materials;

	// Token: 0x040002AC RID: 684
	private static Material _robot_material;

	// Token: 0x040002AD RID: 685
	private static PhoneInterface _instance;

	// Token: 0x040002AE RID: 686
	private static HawkBehavior _hawk;

	// Token: 0x040002AF RID: 687
	private static PlayerTrail _playerTrail;

	// Token: 0x040002B0 RID: 688
	private static Dictionary<string, int> int_dic = new Dictionary<string, int>();

	// Token: 0x040002B1 RID: 689
	private static Dictionary<string, float> float_dic = new Dictionary<string, float>();

	// Token: 0x040002B2 RID: 690
	private static Dictionary<string, string> string_dic = new Dictionary<string, string>();
}
