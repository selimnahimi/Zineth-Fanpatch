using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using UnityEngine;
using XInputDotNetPure;

// Token: 0x020000A5 RID: 165
public class XInput : MonoBehaviour
{
	public static Discord.Discord discord;
	private string oldState = "";

	static string myLog = "";
	private string output;
	private string stack;

	void OnEnable()
	{
		Debug.Log("making spaghetti request pasta");
        var request = (HttpWebRequest)WebRequest.Create("https://example.com/");
        var response = (HttpWebResponse)request.GetResponse();
        var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
        Debug.Log("Made HttpWebRequest, tasty pasta. Response:");
        Debug.Log(responseString);

        Application.RegisterLogCallback(Log);
		XInput.discord = new Discord.Discord(1040045061456539759, (UInt64)Discord.CreateFlags.Default);
	}

	public void Log(string logString, string stackTrace, LogType type)
	{
		output = logString;
		stack = stackTrace;
		myLog = output + "\n" + myLog;
		if (myLog.Length > 5000)
		{
			myLog = myLog.Substring(0, 4000);
		}
	}
	
	private void OnGUI()
    {
		if (Input.GetButton("Debug")) //Do not display in editor ( or you can use the UNITY_EDITOR macro to also disable the rest)
		{
			myLog = GUI.TextArea(new Rect(10, 10, Screen.width - 10, Screen.height - 10), myLog);
		}
	}

	void UpdateDiscord()
	{
		string state;
		MissionObject focusMission = MissionController.focus_mission;

		if (focusMission != null)
		{
			state = "On Mission: " + focusMission.title;
		} else
        {
			state = "Skating";
        }

		if (state != oldState)
		{
			var activityManager = discord.GetActivityManager();
			var activity = new Discord.Activity
			{
				State = state,
				Details = "Campaign",
				Timestamps =
				{
					Start = 0,
				},
				Assets =
				{
					LargeImage = "zineth",
					LargeText = "Zineth",
					SmallImage = "foo smallImageKey",
					SmallText = "foo smallImageText",
				},
				Instance = true,
			};

			activityManager.UpdateActivity(activity, result =>
			{
				Debug.Log("Update Activity " + result + "..." + state);
			});

			oldState = state;
		}

		discord.RunCallbacks();
	}

	// Token: 0x060006DC RID: 1756 RVA: 0x0002C660 File Offset: 0x0002A860
	public static float GetTriggerR()
	{
		return XInput.state.Triggers.Right;
	}

	// Token: 0x060006DD RID: 1757 RVA: 0x0002C680 File Offset: 0x0002A880
	public static float GetTriggerL()
	{
		return XInput.state.Triggers.Left;
	}

	// Token: 0x060006DE RID: 1758 RVA: 0x0002C6A0 File Offset: 0x0002A8A0
	public static void SetVibration(Vector2 vib)
	{
		XInput.SetVibration(vib.x, vib.y);
	}

	// Token: 0x060006DF RID: 1759 RVA: 0x0002C6B8 File Offset: 0x0002A8B8
	public static void SetVibration(float left, float right)
	{
		if (!XInput.playerIndexSet)
		{
			return;
		}
		if (XInput.allow_vibrate)
		{
			GamePad.SetVibration(XInput.playerIndex, left, right);
		}
		else
		{
			GamePad.SetVibration(XInput.playerIndex, 0f, 0f);
		}
	}

	// Token: 0x060006E0 RID: 1760 RVA: 0x0002C700 File Offset: 0x0002A900
	public static void AddPhoneVibrateForce(float left, float right, float time)
	{
		VibrateForce vibrateForce = new VibrateForce(left, right, time);
		vibrateForce.is_phone = true;
		XInput.vibrationlist.Add(vibrateForce);
	}

	// Token: 0x060006E1 RID: 1761 RVA: 0x0002C728 File Offset: 0x0002A928
	public static void AddVibrateForce(float left, float right, float time, bool decay)
	{
		XInput.vibrationlist.Add(new VibrateForce(left, right, time, decay));
	}

	// Token: 0x060006E2 RID: 1762 RVA: 0x0002C740 File Offset: 0x0002A940
	public static void AddVibrateForce(float left, float right, float time)
	{
		XInput.vibrationlist.Add(new VibrateForce(left, right, time));
	}

	// Token: 0x060006E3 RID: 1763 RVA: 0x0002C754 File Offset: 0x0002A954
	public static Vector2 GetVibrateForce()
	{
		return XInput.curvib;
	}

	// Token: 0x060006E4 RID: 1764 RVA: 0x0002C75C File Offset: 0x0002A95C
	public static Vector2 GetPhoneVibrateForce()
	{
		return XInput.phonevib;
	}

	// Token: 0x060006E5 RID: 1765 RVA: 0x0002C764 File Offset: 0x0002A964
	private void Update()
	{
		UpdateDiscord();

		if (Application.isWebPlayer)
		{
			return;
		}
		if (!XInput.prevState.IsConnected || !XInput.playerIndexSet)
		{
			bool flag = false;
			foreach (string a in Input.GetJoystickNames())
			{
				if (a == "Controller (XBOX 360 For Windows)" || a == "Controller (Xbox 360 Wireless Receiver for Windows)")
				{
					flag = true;
				}
			}
			if (flag)
			{
				this.FindPlayerIndex();
			}
		}
		XInput.allow_vibrate = this._allow_vibrate;
		if (XInput.playerIndexSet)
		{
			XInput.state = GamePad.GetState(XInput.playerIndex);
		}
		this.HandleVibrate();
		XInput.prevState = XInput.state;
	}

	// Token: 0x060006E6 RID: 1766 RVA: 0x0002C81C File Offset: 0x0002AA1C
	private void FindPlayerIndex()
	{
		for (int i = 0; i < 1; i++)
		{
			PlayerIndex playerIndex = (PlayerIndex)i;
			if (GamePad.GetState(playerIndex).IsConnected)
			{
				XInput.playerIndex = playerIndex;
				XInput.playerIndexSet = true;
			}
		}
	}

	// Token: 0x060006E7 RID: 1767 RVA: 0x0002C85C File Offset: 0x0002AA5C
	public void LandVibrate()
	{
		XInput.vibrationlist.Add(new VibrateForce(this.landpower, this.landpower, 0.4f, true));
	}

	// Token: 0x060006E8 RID: 1768 RVA: 0x0002C880 File Offset: 0x0002AA80
	public void LandVibrateForce(float force)
	{
		XInput.vibrationlist.Add(new VibrateForce(force, 0f, 0.25f, true));
	}

	// Token: 0x060006E9 RID: 1769 RVA: 0x0002C8A0 File Offset: 0x0002AAA0
	public void WallRideL()
	{
		this.WallRideBoth();
	}

	// Token: 0x060006EA RID: 1770 RVA: 0x0002C8A8 File Offset: 0x0002AAA8
	public void WallRideR()
	{
		this.WallRideBoth();
	}

	// Token: 0x060006EB RID: 1771 RVA: 0x0002C8B0 File Offset: 0x0002AAB0
	public void WallRideBoth()
	{
		XInput.vibrationlist.Add(new VibrateForce(0.1f, this.wallridepower, Time.deltaTime, false));
	}

	// Token: 0x060006EC RID: 1772 RVA: 0x0002C8E0 File Offset: 0x0002AAE0
	public static void GrindingVibrate()
	{
		XInput.vibrationlist.Add(new VibrateForce(XInput.grindpower, XInput.grindpower, Time.deltaTime, false));
	}

	// Token: 0x060006ED RID: 1773 RVA: 0x0002C904 File Offset: 0x0002AB04
	public void Grinding()
	{
		XInput.GrindingVibrate();
	}

	// Token: 0x060006EE RID: 1774 RVA: 0x0002C90C File Offset: 0x0002AB0C
	public void Skate()
	{
	}

	// Token: 0x060006EF RID: 1775 RVA: 0x0002C910 File Offset: 0x0002AB10
	private void HandleVibrate()
	{
		XInput.curvib = Vector2.zero;
		XInput.phonevib = Vector2.zero;
		for (int i = 0; i < XInput.vibrationlist.Count; i++)
		{
			Vector2 vector = XInput.vibrationlist[i].OnUpdate();
			if (XInput.vibrationlist[i].is_phone)
			{
				XInput.phonevib += vector;
			}
			vector *= PhoneMemory.settings.vibrate_amount;
			XInput.curvib += vector;
			if (XInput.vibrationlist[i].life <= 0f)
			{
				XInput.vibrationlist.RemoveAt(i);
				i--;
			}
		}
		XInput.SetVibration(XInput.curvib);
	}

	// Token: 0x060006F0 RID: 1776 RVA: 0x0002C9D8 File Offset: 0x0002ABD8
	private void OnApplicationFocus(bool focus)
	{
		XInput.SetVibration(Vector2.zero);
	}

	// Token: 0x060006F1 RID: 1777 RVA: 0x0002C9E4 File Offset: 0x0002ABE4
	private void OnApplicationPause()
	{
		XInput.SetVibration(Vector2.zero);
	}

	// Token: 0x060006F2 RID: 1778 RVA: 0x0002C9F0 File Offset: 0x0002ABF0
	private void OnApplicationQuit()
	{
		XInput.SetVibration(Vector2.zero);
	}

	// Token: 0x040005BF RID: 1471
	private static bool playerIndexSet = false;

	// Token: 0x040005C0 RID: 1472
	private static PlayerIndex playerIndex;

	// Token: 0x040005C1 RID: 1473
	public static GamePadState state;

	// Token: 0x040005C2 RID: 1474
	private static GamePadState prevState;

	// Token: 0x040005C3 RID: 1475
	private static List<VibrateForce> vibrationlist = new List<VibrateForce>();

	// Token: 0x040005C4 RID: 1476
	public bool _allow_vibrate = true;

	// Token: 0x040005C5 RID: 1477
	public static bool allow_vibrate = true;

	// Token: 0x040005C6 RID: 1478
	private float wallridepower = 0.4f;

	// Token: 0x040005C7 RID: 1479
	private float landpower = 0.75f;

	// Token: 0x040005C8 RID: 1480
	private static float grindpower = 0.25f;

	// Token: 0x040005C9 RID: 1481
	private static Vector2 curvib;

	// Token: 0x040005CA RID: 1482
	private static Vector2 phonevib;
}
