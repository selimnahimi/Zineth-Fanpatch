using System;
using UnityEngine;

// Token: 0x020000AF RID: 175
public class PlaytomicController : MonoBehaviour
{
	// Token: 0x0600078E RID: 1934 RVA: 0x00031F70 File Offset: 0x00030170
	private void Awake()
	{
		if (!this.is_enabled)
		{
			return;
		}
		if (Application.loadedLevelName != "Loader 1")
		{
			PlaytomicController.do_pos_logging = false;
		}
		if (!PlaytomicController.has_init)
		{
			Playtomic.Initialize(Convert.ToInt64(this.gameid), this.guid, this.apikey);
			PlaytomicController.has_init = true;
		}
		if (Application.loadedLevelName == "Loader 3")
		{
			this.MainMenuLoad();
		}
		else if (Application.loadedLevelName == "Loader 5")
		{
			this.TutorialLoad();
		}
		else if (Application.loadedLevelName == "Loader 1")
		{
			this.GameLoad();
		}
	}

	// Token: 0x0600078F RID: 1935 RVA: 0x00032028 File Offset: 0x00030228
	private void MainMenuLoad()
	{
		if (!PlaytomicController.has_viewed)
		{
			Playtomic.Log.View();
			PlaytomicController.has_viewed = true;
			Playtomic.Log.CustomMetric("version_" + PhoneInterface.version);
		}
	}

	// Token: 0x06000790 RID: 1936 RVA: 0x00032060 File Offset: 0x00030260
	private void TutorialLoad()
	{
		Playtomic.Log.Play();
		Playtomic.Log.CustomMetric("tHasLoadedTutorial", "loading", true);
		PlaytomicController.current_group = "Tutorial_Movement";
	}

	// Token: 0x06000791 RID: 1937 RVA: 0x00032098 File Offset: 0x00030298
	private void GameLoad()
	{
		Playtomic.Log.Play();
		Playtomic.Log.CustomMetric("tHasLoadedGame", "loading", true);
		PlaytomicController.current_group = "Game_Movement";
	}

	// Token: 0x06000792 RID: 1938 RVA: 0x000320D0 File Offset: 0x000302D0
	private void Start()
	{
		if (this.player_trans == null)
		{
			GameObject gameObject = GameObject.Find("Player");
			if (gameObject)
			{
				this.player_trans = gameObject.transform;
			}
		}
		if (Application.loadedLevelName == "Loader 1")
		{
			this.SetOffset();
		}
		if (this.player_trans && PlaytomicController.do_pos_logging)
		{
			base.InvokeRepeating("LogPlayerPosition", 2f, 3f);
		}
	}

	// Token: 0x06000793 RID: 1939 RVA: 0x0003215C File Offset: 0x0003035C
	private void SetOffset()
	{
		Terrain[] array = UnityEngine.Object.FindObjectsOfType(typeof(Terrain)) as Terrain[];
		PlaytomicController.bounds = new Bounds(array[0].transform.position, Vector3.zero);
		foreach (Terrain terrain in array)
		{
			PlaytomicController.bounds.Encapsulate(terrain.collider.bounds);
		}
		PlaytomicController.offset = PlaytomicController.bounds.center;
		PlaytomicController.offset.y = -600f;
		int num = 2;
		PlaytomicController.map_width = 480 * num;
		PlaytomicController.map_height = 800 * num;
		float num2 = PlaytomicController.bounds.size.z * 0.6666667f;
		PlaytomicController.scaling = Vector2.one * ((float)PlaytomicController.map_height / (num2 * 2f));
	}

	// Token: 0x06000794 RID: 1940 RVA: 0x00032240 File Offset: 0x00030440
	public static string TranslatePlayerPosToGPSString()
	{
		return PlaytomicController.TranslateGPSToString(PlaytomicController.TranslatePlayerPosToGPS());
	}

	// Token: 0x06000795 RID: 1941 RVA: 0x0003224C File Offset: 0x0003044C
	public static Vector3 TranslateGPSStringToPos(string str)
	{
		return PlaytomicController.TranslateGPSToPos(PlaytomicController.TranslateStringToGPS(str));
	}

	// Token: 0x06000796 RID: 1942 RVA: 0x0003225C File Offset: 0x0003045C
	public static Vector3 TranslateStringToGPS(string str)
	{
		string[] array = str.Split(new char[]
		{
			' '
		});
		Vector3 zero = Vector3.zero;
		string text = string.Empty;
		string text2 = array[0];
		string text3 = text2.Remove(text2.IndexOf(".") + 2);
		zero.x = float.Parse(text3);
		text3 = text2.Substring(text2.IndexOf(".") + 2);
		text = text + text3 + ".";
		text2 = array[1];
		text3 = text2.Remove(text2.IndexOf(".") + 2);
		zero.z = float.Parse(text3);
		text3 = text2.Substring(text2.IndexOf(".") + 2);
		text += text3;
		zero.y = float.Parse(text);
		return zero;
	}

	// Token: 0x06000797 RID: 1943 RVA: 0x00032324 File Offset: 0x00030524
	public static string TranslateGPSToString(Vector3 pos)
	{
		string text = pos.y.ToString("0.00");
		string text2 = pos.x.ToString("0.0");
		string text3 = pos.z.ToString("0.0");
		string[] array = text.Split(new char[]
		{
			'.'
		});
		text = array[0];
		while (text.Length < 3)
		{
			text = "0" + text;
		}
		while (text.Length > 0)
		{
			text2 += text.Substring(0, 1);
			text = text.Remove(0, 1);
		}
		text = array[1];
		while (text.Length < 3)
		{
			text = "0" + text;
		}
		while (text.Length > 0)
		{
			text3 += text.Substring(0, 1);
			text = text.Remove(0, 1);
		}
		if (text2.Contains("Infinity"))
		{
			text2 = "0";
		}
		if (text3.Contains("Infinity"))
		{
			text3 = "0";
		}
		if (Application.isEditor)
		{
			Debug.Log(text2 + " , " + text3);
		}
		return text2 + "/" + text3;
	}

	// Token: 0x06000798 RID: 1944 RVA: 0x00032460 File Offset: 0x00030660
	public static Vector3 TranslatePlayerPosToGPS()
	{
		return PlaytomicController.TranslatePosToGPS(PhoneInterface.player_trans.position);
	}

	// Token: 0x06000799 RID: 1945 RVA: 0x00032474 File Offset: 0x00030674
	public static Vector3 TranslatePosToGPS(Vector3 position)
	{
		Vector3 vector = position - PlaytomicController.offset;
		Vector3 zero = Vector3.zero;
		float num = 180f / (PlaytomicController.bounds.size.x * 1.2f);
		float num2 = 360f / (PlaytomicController.bounds.size.z * 1.2f);
		float num3 = 0.1f;
		zero.x = vector.x * num;
		zero.y = vector.y * num3;
		zero.z = vector.z * num2;
		return zero;
	}

	// Token: 0x0600079A RID: 1946 RVA: 0x0003250C File Offset: 0x0003070C
	public static Vector3 TranslateGPSToPos(Vector3 gps)
	{
		float num = 180f / (PlaytomicController.bounds.size.x * 1.2f);
		float num2 = 360f / (PlaytomicController.bounds.size.z * 1.2f);
		float num3 = 0.1f;
		Vector3 zero = Vector3.zero;
		zero.x = gps.x / num;
		zero.y = gps.y / num3;
		zero.z = gps.z / num2;
		return zero + PlaytomicController.offset;
	}

	// Token: 0x0600079B RID: 1947 RVA: 0x000325A4 File Offset: 0x000307A4
	public static Vector2 TranslatePos(Vector3 position)
	{
		Vector3 vector = position - PlaytomicController.offset;
		vector.z *= -1f;
		vector.x *= PlaytomicController.scaling.x;
		vector.z *= PlaytomicController.scaling.y;
		vector.x += (float)(PlaytomicController.map_width / 2);
		vector.z += (float)(PlaytomicController.map_height / 2);
		return new Vector2(vector.x, vector.z);
	}

	// Token: 0x0600079C RID: 1948 RVA: 0x00032640 File Offset: 0x00030840
	public static void LogPosition(string name, Vector3 position)
	{
		if (PlaytomicController.do_pos_logging)
		{
			PlaytomicController.LogPosition(name, PlaytomicController.current_group, position);
		}
	}

	// Token: 0x0600079D RID: 1949 RVA: 0x00032658 File Offset: 0x00030858
	public static void LogPosition(string name, string groupname, Vector3 position)
	{
		Vector2 vector = PlaytomicController.TranslatePos(position);
		Playtomic.Log.Heatmap(name, groupname, (long)vector.x, (long)vector.y);
	}

	// Token: 0x0600079E RID: 1950 RVA: 0x00032688 File Offset: 0x00030888
	private void LogPlayerPosition()
	{
		if (!this.player_trans)
		{
			return;
		}
		Vector2 vector = PlaytomicController.TranslatePos(this.player_trans.position);
		float magnitude = this.player_trans.rigidbody.velocity.magnitude;
		if (magnitude > 1f)
		{
			Playtomic.Log.Heatmap("tMoving", PlaytomicController.current_group, (long)vector.x, (long)vector.y);
		}
		else
		{
			Playtomic.Log.Heatmap("tNot Moving", PlaytomicController.current_group, (long)vector.x, (long)vector.y);
		}
	}

	// Token: 0x0600079F RID: 1951 RVA: 0x00032728 File Offset: 0x00030928
	private void OnApplicationQuit()
	{
		if (this.player_trans)
		{
			PlaytomicController.LogPosition("tQuit", this.player_trans.position);
		}
		Playtomic.Log.ForceSend();
	}

	// Token: 0x04000659 RID: 1625
	private long gameid = 939496L;

	// Token: 0x0400065A RID: 1626
	private string guid = "62344ea476bb4220";

	// Token: 0x0400065B RID: 1627
	private string apikey = "84f0b740a4ca4d57870d733c145ab5";

	// Token: 0x0400065C RID: 1628
	private bool is_enabled = true;

	// Token: 0x0400065D RID: 1629
	protected static bool do_pos_logging = true;

	// Token: 0x0400065E RID: 1630
	private static bool has_viewed;

	// Token: 0x0400065F RID: 1631
	private static bool has_init;

	// Token: 0x04000660 RID: 1632
	public Transform player_trans;

	// Token: 0x04000661 RID: 1633
	public static Vector3 offset;

	// Token: 0x04000662 RID: 1634
	public static Vector2 scaling;

	// Token: 0x04000663 RID: 1635
	public static int map_width;

	// Token: 0x04000664 RID: 1636
	public static int map_height;

	// Token: 0x04000665 RID: 1637
	private static Bounds bounds;

	// Token: 0x04000666 RID: 1638
	public static string current_phone_group = "ReleasePhone";

	// Token: 0x04000667 RID: 1639
	public static string current_group = "ReleaseMovement";
}
