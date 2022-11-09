using System;
using System.Collections;
using System.Collections.Generic;
using Twitter;
using UnityEngine;

// Token: 0x020000AC RID: 172
public class NetPlayer : MonoBehaviour
{
	// Token: 0x170000DF RID: 223
	// (get) Token: 0x06000725 RID: 1829 RVA: 0x0002D9F4 File Offset: 0x0002BBF4
	// (set) Token: 0x06000726 RID: 1830 RVA: 0x0002DA44 File Offset: 0x0002BC44
	private Transform player_trans
	{
		get
		{
			if (this._player_trans == null)
			{
				if (base.networkView.isMine)
				{
					this._player_trans = PhoneInterface.player_trans;
				}
				else
				{
					this._player_trans = base.transform;
				}
			}
			return this._player_trans;
		}
		set
		{
			this._player_trans = value;
		}
	}

	// Token: 0x170000E0 RID: 224
	// (get) Token: 0x06000727 RID: 1831 RVA: 0x0002DA50 File Offset: 0x0002BC50
	// (set) Token: 0x06000728 RID: 1832 RVA: 0x0002DA58 File Offset: 0x0002BC58
	public Color trailColor
	{
		get
		{
			return this._trailColor;
		}
		set
		{
			Color color = value;
			color.a = this.trailColor.a;
			foreach (TrailRenderer trailRenderer in this.trails)
			{
				trailRenderer.renderer.material.color = color;
			}
			this._trailColor = color;
		}
	}

	// Token: 0x170000E1 RID: 225
	// (get) Token: 0x06000729 RID: 1833 RVA: 0x0002DAB4 File Offset: 0x0002BCB4
	// (set) Token: 0x0600072A RID: 1834 RVA: 0x0002DABC File Offset: 0x0002BCBC
	public Color robotColor
	{
		get
		{
			return this._robotColor;
		}
		set
		{
			Color color = value;
			color.a = this.robotColor.a;
			foreach (Renderer renderer in this.robotRends)
			{
				renderer.material.color = color;
			}
			this._robotColor = color;
		}
	}

	// Token: 0x0600072B RID: 1835 RVA: 0x0002DB14 File Offset: 0x0002BD14
	private void Awake()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		this._robotColor.a = PhoneInterface.robotColor.a;
		if (base.networkView.isMine)
		{
			if (this.player_trans == null)
			{
				this.player_trans = PhoneInterface.player_trans;
			}
			this.camTarget = null;
		}
		else
		{
			if (this.player_trans == null)
			{
				this.player_trans = base.transform;
			}
			if (this.camTarget == null)
			{
				this.camTarget = base.transform.FindChild("Cam Target");
			}
		}
		this.SetupAnimations();
		this.SetupScreenStates();
	}

	// Token: 0x0600072C RID: 1836 RVA: 0x0002DBCC File Offset: 0x0002BDCC
	private void Start()
	{
		base.networkView.observed = this;
	}

	// Token: 0x0600072D RID: 1837 RVA: 0x0002DBDC File Offset: 0x0002BDDC
	private void OnNetworkInstantiate(NetworkMessageInfo info)
	{
		if (base.networkView.isMine)
		{
			this.player_trans = PhoneInterface.player_trans;
			base.networkView.observed = this;
			this.myAnimation.enabled = false;
			this.myAnimation.gameObject.SetActiveRecursively(false);
			this.myAnimation.gameObject.active = true;
			this.hawk_obj.SetActiveRecursively(false);
			this.myAnimation = Networking.instance.player_anim;
			string currentScreenName = TwitterDemo.instance.GetCurrentScreenName();
			this.fakeName = MonsterTraits.Name.createFullName();
			if (currentScreenName == "gamsfest")
			{
				currentScreenName = this.fakeName;
			}
			string currentUserId = TwitterDemo.instance.GetCurrentUserId();
			this.networkPlayer = Network.player;
			int[] array = this.ColToInt(PhoneInterface.trailColor);
			int[] array2 = this.ColToInt(PhoneInterface.robotColor);
			base.networkView.RPC("SetInfoColor", RPCMode.All, new object[]
			{
				this.networkPlayer,
				currentScreenName,
				currentUserId,
				array[0],
				array[1],
				array[2],
				array2[0],
				array2[1],
				array2[2]
			});
			base.InvokeRepeating("CheckInfo", 5f + UnityEngine.Random.value, 5f);
		}
		else
		{
			base.networkView.observed = this;
			this.player_trans = base.transform;
		}
	}

	// Token: 0x0600072E RID: 1838 RVA: 0x0002DD60 File Offset: 0x0002BF60
	private int[] ColToInt(Color col)
	{
		int[] array = new int[3];
		for (int i = 0; i < 3; i++)
		{
			array[i] = Mathf.FloorToInt(col[i] * 255f);
		}
		return array;
	}

	// Token: 0x0600072F RID: 1839 RVA: 0x0002DDA0 File Offset: 0x0002BFA0
	private void CheckInfo()
	{
		if (base.networkView.owner == Network.player && (Network.isClient || Network.isServer))
		{
			string currentScreenName = TwitterDemo.instance.GetCurrentScreenName();
			if (currentScreenName == "gamsfest")
			{
				currentScreenName = this.fakeName;
			}
			if (this.userName != currentScreenName || this._trailColor != PhoneInterface.trailColor || this._robotColor != PhoneInterface.robotColor)
			{
				string text = currentScreenName;
				string currentUserId = TwitterDemo.instance.GetCurrentUserId();
				this.networkPlayer = Network.player;
				int[] array = this.ColToInt(PhoneInterface.trailColor);
				int[] array2 = this.ColToInt(PhoneInterface.robotColor);
				base.networkView.RPC("SetInfoColor", RPCMode.All, new object[]
				{
					this.networkPlayer,
					text,
					currentUserId,
					array[0],
					array[1],
					array[2],
					array2[0],
					array2[1],
					array2[2]
				});
			}
		}
	}

	// Token: 0x06000730 RID: 1840 RVA: 0x0002DEDC File Offset: 0x0002C0DC
	private static bool CheckNaN(Vector3 vec)
	{
		for (int i = 0; i < 3; i++)
		{
			if (float.IsNaN(vec[i]))
			{
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000731 RID: 1841 RVA: 0x0002DF10 File Offset: 0x0002C110
	private static bool CheckNaN(Quaternion rot)
	{
		for (int i = 0; i < 4; i++)
		{
			if (float.IsNaN(rot[i]))
			{
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000732 RID: 1842 RVA: 0x0002DF44 File Offset: 0x0002C144
	private void Update()
	{
		if (base.networkView.isMine || !this.updatePosition || this.states[10] == null || Networking.batchMode)
		{
			return;
		}
		this.simulatePhysics = false;
		this.ping = Mathf.Lerp(this.ping, (float)(Network.time - this.states[0].t), Time.deltaTime * 2f);
		double num = Network.time - this.netInterp;
		if (this.states[0].t > num)
		{
			for (int i = 0; i < this.stateCount; i++)
			{
				if (this.states[i] != null && (this.states[i].t <= num || i == this.stateCount - 1))
				{
					NetPlayer.State state = this.states[Mathf.Max(i - 1, 0)];
					NetPlayer.State state2 = this.states[i];
					double num2 = state.t - state2.t;
					float num3 = 0f;
					if (num2 > 9.999999747378752E-05)
					{
						num3 = (float)((num - state2.t) / num2);
					}
					if ((num3 <= 0f || num3 > 1f) && Application.isEditor)
					{
						Debug.LogWarning("t not clamped... " + num3);
					}
					Vector3 vector = Vector3.Lerp(state2.p, state.p, num3);
					Quaternion quaternion = Quaternion.Slerp(state2.r, state.r, num3);
					if (NetPlayer.CheckNaN(vector))
					{
						Debug.LogWarning("pos is NaN!");
						vector = this.player_trans.position;
					}
					if (NetPlayer.CheckNaN(quaternion))
					{
						Debug.LogWarning("rot is NaN!");
						quaternion = this.player_trans.rotation;
					}
					this.player_trans.position = vector;
					this.player_trans.rotation = quaternion;
					this.velocity = (state.p - this.states[i + 1].p) / (float)(state.t - this.states[i + 1].t);
					if (num3 <= 0.5f)
					{
						this.isHawking = state2.h;
						this.CheckAnimation(state2.a);
					}
					else
					{
						this.isHawking = state.h;
						this.CheckAnimation(state.a);
					}
					this.CheckScreenState(state.s);
					if (Application.isEditor && this.doPrinting)
					{
						Debug.Log(string.Concat(new object[]
						{
							"i=",
							i,
							", t=",
							num3,
							", l=",
							num2
						}));
					}
					this.isResponding = true;
					this.netStatus = string.Empty;
					break;
				}
			}
		}
		else
		{
			float num4 = (float)(num - this.states[0].t);
			if (num4 < 1f && this.states[0] != null && this.states[1] != null)
			{
				for (int j = 1; j < this.stateCount; j++)
				{
					if (this.states[j] != null && this.states[j].t < this.states[0].t)
					{
						break;
					}
				}
				float num5 = (float)(this.states[0].t - this.states[1].t);
				Vector3 vector2 = this.states[0].p - this.states[1].p;
				if (num5 <= 0f || num5 > 1f)
				{
					num5 = Mathf.Clamp(num5, 0.001f, 1f);
					vector2 = Vector3.zero;
				}
				else
				{
					vector2 /= num5;
				}
				Vector3 vector3 = this.states[0].p + vector2 * num4;
				if (NetPlayer.CheckNaN(vector3))
				{
					Debug.LogWarning("pos is NaN!");
					vector3 = this.player_trans.position;
				}
				this.player_trans.position = vector3;
				Quaternion rotation = this.states[0].r;
				if (NetPlayer.CheckNaN(rotation))
				{
					Debug.LogWarning("rot is NaN!");
					rotation = this.player_trans.rotation;
				}
				this.player_trans.rotation = rotation;
				this.isHawking = this.states[0].h;
				this.CheckAnimation(this.states[0].a);
				this.CheckScreenState(this.states[0].s);
				this.isResponding = true;
				if (num4 < 0.5f)
				{
					this.netStatus = " .";
				}
				else
				{
					this.netStatus = " ..";
				}
			}
			else
			{
				this.netStatus = " ...";
				this.isResponding = false;
			}
		}
		if (this.isHawking != this.hawk_obj.renderer.enabled)
		{
			this.hawk_obj.renderer.enabled = this.isHawking;
		}
		if (Networking.newCam && Networking.newCam.tempTarget == this.camTarget)
		{
			Networking.newCam.NormalMode(Time.deltaTime);
		}
	}

	// Token: 0x06000733 RID: 1843 RVA: 0x0002E4B4 File Offset: 0x0002C6B4
	private void OnSerializeNetworkView(BitStream stream, NetworkMessageInfo info)
	{
		if (base.networkView.isMine)
		{
			this.p = this.player_trans.position;
			this.r = this.player_trans.rotation;
			this.m = 0;
			this.h = (PhoneInterface.hawk && PhoneInterface.hawk.active && PhoneInterface.hawk.targetHeld);
			this.a = this.GetAnimationChar();
			this.s = this.GetScreenStateChar();
			this.cur_screenstate = this.GetScreenState(this.s);
			stream.Serialize(ref this.p);
			stream.Serialize(ref this.r);
			stream.Serialize(ref this.m);
			stream.Serialize(ref this.h);
			stream.Serialize(ref this.a);
			stream.Serialize(ref this.s);
		}
		else if (stream.isWriting)
		{
			if (this.stateCount == 0)
			{
				return;
			}
			this.p = this.lastState.p;
			this.r = this.lastState.r;
			this.m = (int)((Network.time - this.lastState.t) * 1000.0);
			this.h = this.lastState.h;
			this.a = this.lastState.a;
			this.s = this.lastState.s;
			stream.Serialize(ref this.p);
			stream.Serialize(ref this.r);
			stream.Serialize(ref this.m);
			stream.Serialize(ref this.h);
			stream.Serialize(ref this.a);
			stream.Serialize(ref this.s);
		}
		else
		{
			stream.Serialize(ref this.p);
			stream.Serialize(ref this.r);
			stream.Serialize(ref this.m);
			stream.Serialize(ref this.h);
			stream.Serialize(ref this.a);
			stream.Serialize(ref this.s);
			this.lastState = new NetPlayer.State(this.p, this.r, info.timestamp - (((double)this.m <= 0.0) ? 0.0 : ((double)this.m / 1000.0)), this.h, this.a, this.s);
			if (this.stateCount == 0)
			{
				this.states[0] = this.lastState;
			}
			else if (this.lastState.t > this.states[0].t)
			{
				if (Application.isEditor && this.doPrinting)
				{
					MonoBehaviour.print(string.Concat(new object[]
					{
						"cool time ",
						this.lastState.t,
						" ",
						this.states[0].t
					}));
				}
				for (int i = this.states.Length - 1; i > 0; i--)
				{
					this.states[i] = this.states[i - 1];
				}
				this.states[0] = this.lastState;
			}
			else
			{
				if (Application.isEditor && this.doPrinting)
				{
					MonoBehaviour.print("wow skippin " + this.lastState.t.ToString() + " " + this.states[0].t.ToString());
				}
				int j;
				for (j = 1; j < this.stateCount; j++)
				{
					if (this.states[j] != null && this.lastState.t >= this.states[j].t)
					{
						break;
					}
				}
				if (j < this.stateCount)
				{
					for (int k = this.states.Length - 1; k > j; k--)
					{
						this.states[k] = this.states[k - 1];
					}
					this.states[j] = this.lastState;
					if (Application.isEditor && this.doPrinting)
					{
						MonoBehaviour.print("inserting at " + j.ToString());
					}
				}
			}
			this.stateCount = Mathf.Min(this.stateCount + 1, this.states.Length);
		}
	}

	// Token: 0x06000734 RID: 1844 RVA: 0x0002E924 File Offset: 0x0002CB24
	private void OnDisconnectedFromServer(NetworkDisconnection info)
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x06000735 RID: 1845 RVA: 0x0002E934 File Offset: 0x0002CB34
	private void OnDisable()
	{
		Networking.RemoveNetPlayer(this.networkPlayer);
	}

	// Token: 0x06000736 RID: 1846 RVA: 0x0002E944 File Offset: 0x0002CB44
	private void SetupAnimations()
	{
		if (NetPlayer.anim_clip_list == null)
		{
			NetPlayer.anim_clip_list = new string[this.myAnimation.GetClipCount()];
			int num = 0;
			foreach (object obj in this.myAnimation)
			{
				AnimationState animationState = (AnimationState)obj;
				NetPlayer.anim_clip_list[num] = animationState.clip.name;
				NetPlayer.anim_clip_dic.Add(animationState.clip.name, (char)num);
				if (NetPlayer.anim_speed_dic.ContainsKey(animationState.name))
				{
					animationState.speed = NetPlayer.anim_speed_dic[animationState.name];
				}
				else
				{
					animationState.speed = 1f;
				}
				num++;
			}
		}
		this._lastchar = this.GetAnimationChar();
		if (this.myAnimation["PhoneArm"] != null)
		{
			AnimationState animationState2 = this.myAnimation["PhoneArm"];
			animationState2.AddMixingTransform(this.myAnimation.transform.Find("Joints_GRP/root/hips_upper/chest/R_h_shoulder"));
			animationState2.layer = 2;
			animationState2.blendMode = AnimationBlendMode.Blend;
			animationState2.wrapMode = WrapMode.Once;
			animationState2.enabled = true;
			animationState2.weight = 1f;
			animationState2.speed = 3f;
		}
	}

	// Token: 0x06000737 RID: 1847 RVA: 0x0002EAC0 File Offset: 0x0002CCC0
	private char GetAnimationChar()
	{
		string key = PhoneInterface.player_move.animName;
		if (base.networkView.owner == Network.player && SpawnPointScript.instance.isRespawning)
		{
			key = SpawnPointScript.instance.GetCurrentSpawnPoint().animationName;
		}
		if (NetPlayer.anim_clip_dic.ContainsKey(key))
		{
			return NetPlayer.anim_clip_dic[key];
		}
		return this._lastchar;
	}

	// Token: 0x06000738 RID: 1848 RVA: 0x0002EB34 File Offset: 0x0002CD34
	private string GetAnimationClip(char indchar)
	{
		return NetPlayer.anim_clip_list[(int)indchar];
	}

	// Token: 0x06000739 RID: 1849 RVA: 0x0002EB40 File Offset: 0x0002CD40
	private void CheckAnimation(char anim_char)
	{
		string animationClip = this.GetAnimationClip(anim_char);
		if (this._lastchar != anim_char)
		{
			this.myAnimation.CrossFade(animationClip);
			this.myAnimation[animationClip].time = 0f;
			this.myAnimation[animationClip].speed = PhoneInterface.player_move.model.animation[animationClip].speed;
		}
		if (animationClip == "Skate")
		{
			float z = this.player_trans.InverseTransformDirection(this.velocity).z;
			if (z > 1f)
			{
				this.myAnimation[animationClip].speed = Mathf.Clamp(z / 5f, 3f, 5f);
			}
			else
			{
				this.myAnimation[animationClip].speed = 0f;
			}
		}
		this._lastchar = anim_char;
	}

	// Token: 0x0600073A RID: 1850 RVA: 0x0002EC2C File Offset: 0x0002CE2C
	private void SetupScreenStates()
	{
		if (NetPlayer.screen_state_dic == null)
		{
			NetPlayer.screen_state_dic = new Dictionary<string, char>();
		}
		if (NetPlayer.screen_state_dic.Count == 0)
		{
			for (int i = 0; i < NetPlayer.screen_state_list.Length; i++)
			{
				NetPlayer.screen_state_dic.Add(NetPlayer.screen_state_list[i], (char)i);
			}
		}
	}

	// Token: 0x0600073B RID: 1851 RVA: 0x0002EC88 File Offset: 0x0002CE88
	private void ScreenOpen()
	{
		if (this.myAnimation["PhoneArm"] != null)
		{
			this.myAnimation["PhoneArm"].speed = Mathf.Abs(this.myAnimation["PhoneArm"].speed);
			this.myAnimation["PhoneArm"].wrapMode = WrapMode.ClampForever;
			this.myAnimation["PhoneArm"].weight = 0.5f;
			this.myAnimation["PhoneArm"].enabled = true;
			this.myAnimation.CrossFade("PhoneArm");
		}
		if (Application.isEditor)
		{
			Debug.Log("opening...");
		}
	}

	// Token: 0x0600073C RID: 1852 RVA: 0x0002ED4C File Offset: 0x0002CF4C
	private void ScreenClose()
	{
		if (this.myAnimation["PhoneArm"] != null)
		{
			this.myAnimation["PhoneArm"].speed = -Mathf.Abs(this.myAnimation["PhoneArm"].speed);
			this.myAnimation["PhoneArm"].wrapMode = WrapMode.Once;
			this.myAnimation["PhoneArm"].time = this.myAnimation["PhoneArm"].length;
			this.myAnimation.CrossFade("PhoneArm");
		}
		if (Application.isEditor)
		{
			Debug.Log("closing...");
		}
	}

	// Token: 0x0600073D RID: 1853 RVA: 0x0002EE08 File Offset: 0x0002D008
	private void CheckScreenState(char c)
	{
		string screenState = this.GetScreenState(c);
		if (screenState != this.cur_screenstate)
		{
			if (screenState == "closed")
			{
				this.ScreenClose();
			}
			else if (this.cur_screenstate == "closed")
			{
				this.ScreenOpen();
			}
			this.cur_screenstate = screenState;
			if (this.cur_screenstate == "na" || this.cur_screenstate == "closed")
			{
				this.screen_icon = null;
			}
			else if (PhoneController.instance.screendict.ContainsKey(this.cur_screenstate))
			{
				PhoneScreen phoneScreen = PhoneController.instance.screendict[this.cur_screenstate];
				if (phoneScreen.icon_texture != null)
				{
					this.screen_icon = phoneScreen.icon_texture;
				}
				else
				{
					this.screen_icon = null;
				}
			}
			if (Application.isEditor)
			{
				Debug.Log("switch screen... " + this.cur_screenstate);
			}
		}
	}

	// Token: 0x0600073E RID: 1854 RVA: 0x0002EF1C File Offset: 0x0002D11C
	private char GetScreenStateChar()
	{
		string key = string.Empty;
		if (PhoneController.instance)
		{
			key = "closed";
			if (PhoneController.powerstate == PhoneController.PowerState.open && PhoneController.instance.curscreen)
			{
				key = PhoneController.instance.curscreen.screenname;
			}
		}
		if (NetPlayer.screen_state_dic.ContainsKey(key))
		{
			return NetPlayer.screen_state_dic[key];
		}
		return NetPlayer.screen_state_dic["na"];
	}

	// Token: 0x0600073F RID: 1855 RVA: 0x0002EFA0 File Offset: 0x0002D1A0
	private string GetScreenState(char s)
	{
		if ((int)s < NetPlayer.screen_state_list.Length)
		{
			return NetPlayer.screen_state_list[(int)s];
		}
		return "na";
	}

	// Token: 0x06000740 RID: 1856 RVA: 0x0002EFCC File Offset: 0x0002D1CC
	private void OnGUI()
	{
		if (Networking.batchMode)
		{
			return;
		}
		if (!base.networkView.isMine && this.iconTex != null)
		{
			Texture2D image = this.iconTex;
			if (this.screen_icon != null)
			{
				bool flag = Time.time % 1f < 0.5f;
			}
			float num = 48f;
			Vector3 vector = this.WorldToScreen(this.player_trans.position + this.player_trans.up * 3f);
			Rect rect = new Rect(vector.x, vector.y, (float)((int)num), (float)((int)num));
			if (vector.z > 0f)
			{
				rect.x -= rect.width / 2f;
				rect.y -= rect.height;
				rect.y -= 8f;
				rect = this.ClampToScreen(rect);
				GUI.DrawTexture(rect, image);
			}
		}
	}

	// Token: 0x06000741 RID: 1857 RVA: 0x0002F0E4 File Offset: 0x0002D2E4
	private Vector3 WorldToScreen(Vector3 worldpos)
	{
		Vector3 result = Camera.main.WorldToViewportPoint(worldpos);
		result.y = Mathf.Clamp01(result.y);
		result.x *= (float)Screen.width;
		result.y = (1f - result.y) * (float)Screen.height;
		return result;
	}

	// Token: 0x06000742 RID: 1858 RVA: 0x0002F140 File Offset: 0x0002D340
	private Rect WorldToScreen(Vector3 worldpos, int width, int height)
	{
		Vector3 vector = this.WorldToScreen(worldpos);
		Rect result = new Rect(vector.x, vector.y, (float)width, (float)height);
		if (vector.z < 0f)
		{
			result.width *= -1f;
		}
		return result;
	}

	// Token: 0x06000743 RID: 1859 RVA: 0x0002F194 File Offset: 0x0002D394
	private Rect ClampToScreen(Rect rect)
	{
		rect.x = Mathf.Clamp(rect.x, 0f, (float)Screen.width - rect.width);
		rect.y = Mathf.Clamp(rect.y, 0f, (float)Screen.height - rect.height);
		return rect;
	}

	// Token: 0x06000744 RID: 1860 RVA: 0x0002F1F0 File Offset: 0x0002D3F0
	public void DoAddIcon(string tex)
	{
		Vector3 vector = this.player_trans.position + Vector3.up * 3f;
		base.networkView.RPC("AddIcon", RPCMode.All, new object[]
		{
			this.networkPlayer,
			vector,
			tex
		});
	}

	// Token: 0x06000745 RID: 1861 RVA: 0x0002F250 File Offset: 0x0002D450
	[RPC]
	public void AddIcon(NetworkPlayer player, Vector3 position, string tex)
	{
		if (Networking.batchMode)
		{
			return;
		}
		Texture2D tex2 = Networking.chat_icon_dic[tex];
		NetIcon.AddNetIcon(player, position, tex2, Vector2.one * 64f);
	}

	// Token: 0x06000746 RID: 1862 RVA: 0x0002F28C File Offset: 0x0002D48C
	[RPC]
	public void SetInfoColor(NetworkPlayer player, string twitname, string twitid, int r, int g, int b, int r2, int g2, int b2)
	{
		this.SetTrailColor(r, g, b);
		this.SetRobotColor(r2, g2, b2);
		this.networkPlayer = player;
		this.userName = twitname;
		this.twitterId = twitid;
		if (!string.IsNullOrEmpty(this.twitterId))
		{
			string iconURL = Parser.GetIconURL(this.twitterId);
			this.iconTex = ImageDownloadHelper.NewImage(iconURL);
		}
		if (!Networking.netplayer_dic.ContainsKey(this.networkPlayer))
		{
			Networking.AddNetPlayer(this.networkPlayer, this);
		}
	}

	// Token: 0x06000747 RID: 1863 RVA: 0x0002F310 File Offset: 0x0002D510
	public void SetTrailColor(int r, int g, int b)
	{
		Color color = new Color((float)r / 255f, (float)g / 255f, (float)b / 255f);
		if (base.networkView.owner == Network.player)
		{
			this._trailColor = color;
		}
		else if (this.trailColor != color)
		{
			this.trailColor = color;
		}
	}

	// Token: 0x06000748 RID: 1864 RVA: 0x0002F37C File Offset: 0x0002D57C
	public void SetRobotColor(int r, int g, int b)
	{
		Color color = new Color((float)r / 255f, (float)g / 255f, (float)b / 255f);
		if (base.networkView.owner == Network.player)
		{
			this._robotColor = color;
		}
		else if (this.robotColor != color)
		{
			this.robotColor = color;
		}
	}

	// Token: 0x06000749 RID: 1865 RVA: 0x0002F3E8 File Offset: 0x0002D5E8
	public void DoChatMessage(string text)
	{
		text = string.Format("@{0}: {1}", this.userName, text);
		this.DoChatMessageRaw(text);
	}

	// Token: 0x0600074A RID: 1866 RVA: 0x0002F404 File Offset: 0x0002D604
	public void DoChatMessageRaw(string text)
	{
		base.networkView.RPC("ChatMessage", RPCMode.All, new object[]
		{
			text
		});
	}

	// Token: 0x0600074B RID: 1867 RVA: 0x0002F42C File Offset: 0x0002D62C
	[RPC]
	public void ChatMessage(string text)
	{
		Networking.AddChatMessage(text);
	}

	// Token: 0x0600074C RID: 1868 RVA: 0x0002F434 File Offset: 0x0002D634
	public void DoSetMood(int moodind)
	{
		base.networkView.RPC("SetMood", RPCMode.Others, new object[]
		{
			moodind
		});
	}

	// Token: 0x0600074D RID: 1869 RVA: 0x0002F464 File Offset: 0x0002D664
	[RPC]
	public void SetMood(int moodind)
	{
		this.mood = (float)moodind;
	}

	// Token: 0x0600074E RID: 1870 RVA: 0x0002F470 File Offset: 0x0002D670
	public void DoCallHawk()
	{
		base.networkView.RPC("CallHawk", RPCMode.All, new object[0]);
	}

	// Token: 0x0600074F RID: 1871 RVA: 0x0002F48C File Offset: 0x0002D68C
	[RPC]
	public void CallHawk()
	{
		if (PhoneInterface.hawk)
		{
			PhoneInterface.SummonHawk();
		}
	}

	// Token: 0x06000750 RID: 1872 RVA: 0x0002F4A4 File Offset: 0x0002D6A4
	public void DoSetPizzaScore(int score)
	{
		this.pizzaScore = score;
		this.DoSetPizzaScore();
	}

	// Token: 0x06000751 RID: 1873 RVA: 0x0002F4B4 File Offset: 0x0002D6B4
	public void DoSetPizzaScore()
	{
		base.networkView.RPC("SetPizzaScore", RPCMode.Others, new object[]
		{
			this.pizzaScore
		});
	}

	// Token: 0x06000752 RID: 1874 RVA: 0x0002F4E8 File Offset: 0x0002D6E8
	[RPC]
	public void SetPizzaScore(int score)
	{
		this.pizzaScore = score;
	}

	// Token: 0x06000753 RID: 1875 RVA: 0x0002F4F4 File Offset: 0x0002D6F4
	public void DoMakeTrainer()
	{
		PhoneMonster main_monster = PhoneMemory.main_monster;
		base.networkView.RPC("MakeTrainer", RPCMode.All, new object[]
		{
			this.player_trans.position,
			this.player_trans.rotation,
			main_monster.monsterType.typeName,
			main_monster.bloodtype.typename,
			main_monster.attack,
			main_monster.defense,
			main_monster.magic,
			main_monster.glam,
			main_monster.scale.x,
			main_monster.scale.y,
			main_monster.speed,
			main_monster.bullet_speed,
			main_monster.bullet_cooldown,
			main_monster.bullet_homing
		});
	}

	// Token: 0x06000754 RID: 1876 RVA: 0x0002F604 File Offset: 0x0002D804
	[RPC]
	public void MakeTrainer(Vector3 pos, Quaternion rot, string type, string blood, float attack, float defense, float magic, float glam, float scale_x, float scale_y, float speed, float bullet_speed, float bullet_cooldown, float bullet_homing)
	{
		if (this.trainer == null)
		{
			this.trainer = (UnityEngine.Object.Instantiate(Networking.instance.trainer_prefab, pos, rot) as NPCTrainer);
		}
		else
		{
			this.trainer.transform.position = pos;
			this.trainer.transform.rotation = rot;
		}
		this.trainer.npc_name = this.userName;
		this.trainer.monster_first_name = this.userName;
		this.trainer.monster_last_name = string.Empty;
		this.trainer.rigidbody.freezeRotation = true;
		this.trainer.monsterTypeName = type;
		this.trainer.bloodtype = blood;
		this.trainer.attack = attack;
		this.trainer.defense = defense;
		this.trainer.magic = magic;
		this.trainer.glam = glam;
		this.trainer.scale = new Vector2(scale_x, scale_y);
		this.trainer.speed = speed;
		this.trainer.bullet_speed = bullet_speed;
		this.trainer.bullet_cooldown = bullet_cooldown;
		this.trainer.bullet_homing = bullet_homing;
		this.trainer.auto_gen_stats = false;
		this.trainer.InitMonster();
		this.trainer.waiting_icon = this.iconTex;
		this.trainer.battling_icon = this.iconTex;
		this.trainer.near_icon = this.iconTex;
		this.trainer.SetBubbleTexture(this.iconTex);
		this.trainer.can_challenge = true;
		this.trainer.GiveBadge();
	}

	// Token: 0x06000755 RID: 1877 RVA: 0x0002F7B0 File Offset: 0x0002D9B0
	private void OnPlayerConnected(NetworkPlayer player)
	{
		int[] array = this.ColToInt(this.trailColor);
		int[] array2 = this.ColToInt(this.robotColor);
		base.networkView.RPC("SetInfoColor", player, new object[]
		{
			this.networkPlayer,
			this.userName,
			this.twitterId,
			array[0],
			array[1],
			array[2],
			array2[0],
			array2[1],
			array2[2]
		});
		base.networkView.RPC("SetPizzaScore", player, new object[]
		{
			this.pizzaScore
		});
		base.networkView.RPC("SetMood", player, new object[]
		{
			Mathf.RoundToInt(this.mood)
		});
		if (this.trainer)
		{
			base.networkView.RPC("MakeTrainer", player, new object[]
			{
				this.trainer.transform.position,
				this.trainer.transform.rotation,
				this.trainer.monsterTypeName,
				this.trainer.bloodtype,
				this.trainer.attack,
				this.trainer.defense,
				this.trainer.magic,
				this.trainer.magic,
				this.trainer.scale.x,
				this.trainer.scale.y,
				this.trainer.speed,
				this.trainer.bullet_speed,
				this.trainer.bullet_cooldown,
				this.trainer.bullet_cooldown
			});
		}
		if (base.networkView.isMine)
		{
			if (!string.IsNullOrEmpty(Networking.bundlefile) && Application.loadedLevelName == "test")
			{
				base.networkView.RPC("LoadBundleCommand", player, new object[]
				{
					Networking.bundlefile
				});
			}
			else
			{
				base.networkView.RPC("LoadSceneCommand", player, new object[]
				{
					Application.loadedLevelName
				});
			}
		}
	}

	// Token: 0x06000756 RID: 1878 RVA: 0x0002FA58 File Offset: 0x0002DC58
	public void DoSceneCommand(string nam)
	{
		if (base.networkView.isMine && Network.isServer)
		{
			base.networkView.RPC("LoadSceneCommand", RPCMode.All, new object[]
			{
				nam
			});
		}
	}

	// Token: 0x06000757 RID: 1879 RVA: 0x0002FA9C File Offset: 0x0002DC9C
	[RPC]
	public void LoadSceneCommand(string nam)
	{
		if (Application.loadedLevelName != nam)
		{
			Application.LoadLevel(nam);
		}
	}

	// Token: 0x06000758 RID: 1880 RVA: 0x0002FAB4 File Offset: 0x0002DCB4
	public void DoLoadBundle(string nam)
	{
		if (base.networkView.isMine && Network.isServer)
		{
			base.networkView.RPC("LoadBundleCommand", RPCMode.All, new object[]
			{
				nam
			});
		}
	}

	// Token: 0x06000759 RID: 1881 RVA: 0x0002FAF8 File Offset: 0x0002DCF8
	[RPC]
	public void LoadBundleCommand(string nam)
	{
		Networking.bundlefile = nam;
		if (Application.loadedLevelName != "test")
		{
			Application.LoadLevel("test");
		}
		if (Network.isClient && !nam.StartsWith("http") && !SpawnPointScript.HasBundle(nam))
		{
			Debug.Log("i need to get this bundle... " + nam);
			base.networkView.RPC("RequestBundleBytes", RPCMode.Others, new object[]
			{
				Network.player,
				nam
			});
		}
		else
		{
			SpawnPointScript.instance.LoadAndSpawn(nam);
		}
	}

	// Token: 0x0600075A RID: 1882 RVA: 0x0002FB98 File Offset: 0x0002DD98
	[RPC]
	public void SendBundleBytes(string nam, byte[] data)
	{
		Debug.Log(string.Concat(new object[]
		{
			"i am getting some bundle bytes... ",
			nam,
			", ",
			data.Length
		}));
		if (nam != Networking.bundlefile)
		{
			Debug.LogWarning(string.Concat(new string[]
			{
				"i was expecting ",
				Networking.bundlefile,
				" but got ",
				nam,
				"..."
			}));
		}
		else
		{
			SpawnPointScript.instance.LoadAndSpawn(nam, data);
		}
	}

	// Token: 0x0600075B RID: 1883 RVA: 0x0002FC2C File Offset: 0x0002DE2C
	[RPC]
	public void RequestBundleBytes(NetworkPlayer player, string nam)
	{
		if (!Network.isServer)
		{
			return;
		}
		Debug.Log("I am going to send some bundle bytes...");
		base.StartCoroutine(this.Co_RequestBundleBytes(player, nam));
	}

	// Token: 0x0600075C RID: 1884 RVA: 0x0002FC60 File Offset: 0x0002DE60
	private IEnumerator Co_RequestBundleBytes(NetworkPlayer player, string nam)
	{
		while (!SpawnPointScript.instance.loaded)
		{
			yield return null;
		}
		if (nam != Networking.bundlefile)
		{
			Debug.LogWarning(string.Concat(new string[]
			{
				"the client wants ",
				nam,
				" but my current bundle is ",
				Networking.bundlefile,
				"... sending mine anyway"
			}));
		}
		Debug.Log("i am sending some bundle bytes..." + SpawnPointScript.instance.curBundleBytes.Length);
		base.networkView.RPC("SendBundleBytes", player, new object[]
		{
			Networking.bundlefile,
			SpawnPointScript.instance.curBundleBytes
		});
		yield break;
	}

	// Token: 0x040005F1 RID: 1521
	private Transform _player_trans;

	// Token: 0x040005F2 RID: 1522
	public TrailRenderer[] trails;

	// Token: 0x040005F3 RID: 1523
	public Color altColor = Color.blue;

	// Token: 0x040005F4 RID: 1524
	public string userName = string.Empty;

	// Token: 0x040005F5 RID: 1525
	public string fakeName = string.Empty;

	// Token: 0x040005F6 RID: 1526
	public string twitterId = string.Empty;

	// Token: 0x040005F7 RID: 1527
	public float ping = -1f;

	// Token: 0x040005F8 RID: 1528
	public string netStatus = string.Empty;

	// Token: 0x040005F9 RID: 1529
	public float mood = 4f;

	// Token: 0x040005FA RID: 1530
	public Animation myAnimation;

	// Token: 0x040005FB RID: 1531
	public Texture2D iconTex;

	// Token: 0x040005FC RID: 1532
	public NetworkPlayer networkPlayer;

	// Token: 0x040005FD RID: 1533
	public Transform camTarget;

	// Token: 0x040005FE RID: 1534
	public bool isHawking;

	// Token: 0x040005FF RID: 1535
	public GameObject hawk_obj;

	// Token: 0x04000600 RID: 1536
	public int pizzaScore;

	// Token: 0x04000601 RID: 1537
	private Color _trailColor = Color.white;

	// Token: 0x04000602 RID: 1538
	public Renderer[] robotRends;

	// Token: 0x04000603 RID: 1539
	private Color _robotColor = Color.white;

	// Token: 0x04000604 RID: 1540
	private int stateCount;

	// Token: 0x04000605 RID: 1541
	private NetPlayer.State[] states = new NetPlayer.State[25];

	// Token: 0x04000606 RID: 1542
	private int m;

	// Token: 0x04000607 RID: 1543
	private Vector3 p;

	// Token: 0x04000608 RID: 1544
	private Quaternion r;

	// Token: 0x04000609 RID: 1545
	private bool h;

	// Token: 0x0400060A RID: 1546
	private char a;

	// Token: 0x0400060B RID: 1547
	private char s;

	// Token: 0x0400060C RID: 1548
	private Vector3 velocity = Vector3.zero;

	// Token: 0x0400060D RID: 1549
	public bool updatePosition = true;

	// Token: 0x0400060E RID: 1550
	public double netInterp = 0.15000000596046448;

	// Token: 0x0400060F RID: 1551
	public bool isResponding;

	// Token: 0x04000610 RID: 1552
	private bool simulatePhysics;

	// Token: 0x04000611 RID: 1553
	private NetPlayer.State lastState;

	// Token: 0x04000612 RID: 1554
	public bool doPrinting;

	// Token: 0x04000613 RID: 1555
	public static Dictionary<string, char> anim_clip_dic = new Dictionary<string, char>();

	// Token: 0x04000614 RID: 1556
	private static Dictionary<string, float> anim_speed_dic = new Dictionary<string, float>();

	// Token: 0x04000615 RID: 1557
	private static string[] anim_clip_list;

	// Token: 0x04000616 RID: 1558
	private char _lastchar;

	// Token: 0x04000617 RID: 1559
	private static Dictionary<string, char> screen_state_dic;

	// Token: 0x04000618 RID: 1560
	private static string[] screen_state_list = new string[]
	{
		"closed",
		"na",
		"Twitter",
		"Cool Cam",
		"GameScreen",
		"Mail",
		"Settings",
		"Radar"
	};

	// Token: 0x04000619 RID: 1561
	public string cur_screenstate = "closed";

	// Token: 0x0400061A RID: 1562
	public Texture2D screen_icon;

	// Token: 0x0400061B RID: 1563
	private NPCTrainer trainer;

	// Token: 0x020000AD RID: 173
	protected class State
	{
		// Token: 0x0600075D RID: 1885 RVA: 0x0002FC98 File Offset: 0x0002DE98
		public State(Vector3 pp, Quaternion rr, double tt, bool hh, char aa, char ss)
		{
			this.p = pp;
			this.r = rr;
			this.t = tt;
			this.h = hh;
			this.a = aa;
			this.s = ss;
		}

		// Token: 0x0400061C RID: 1564
		public Vector3 p;

		// Token: 0x0400061D RID: 1565
		public Quaternion r;

		// Token: 0x0400061E RID: 1566
		public double t;

		// Token: 0x0400061F RID: 1567
		public bool h;

		// Token: 0x04000620 RID: 1568
		public char a;

		// Token: 0x04000621 RID: 1569
		public char s;
	}
}
