using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using Twitter;
using UnityEngine;

// Token: 0x02000063 RID: 99
public class PhoneCamControl : PhoneScreen
{
	// Token: 0x17000090 RID: 144
	// (get) Token: 0x0600041A RID: 1050 RVA: 0x00018698 File Offset: 0x00016898
	public static PhoneCamControl instance
	{
		get
		{
			if (!PhoneCamControl._instance)
			{
				PhoneCamControl._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneCamControl)) as PhoneCamControl);
			}
			return PhoneCamControl._instance;
		}
	}

	// Token: 0x0600041B RID: 1051 RVA: 0x000186C8 File Offset: 0x000168C8
	private void Awake()
	{
		if (!this.cam)
		{
			this.cam = GameObject.Find("SubCamera").camera;
		}
		this.oldcam = this.controller.phonecam;
		this.rendtex = new RenderTexture(480, 800, 1);
		this.rendmat.mainTexture = this.rendtex;
		this.cam.targetTexture = this.rendtex;
		if (this.gui_text == null)
		{
			this.gui_text = GameObject.Find("SubCameraGUI").guiText;
		}
		if (this.gui_texture == null)
		{
			this.gui_texture = GameObject.Find("SubCameraGUI").guiTexture;
		}
		foreach (string type in this.effectNames)
		{
			Component component = this.cam.GetComponent(type);
			if (component != null)
			{
				this.imageEffects.Add(component);
			}
		}
		foreach (Component component2 in this.imageEffects)
		{
			(component2 as MonoBehaviour).enabled = false;
		}
		this.SetTextureColor(Color.green);
		this.ResetMessage();
	}

	// Token: 0x0600041C RID: 1052 RVA: 0x00018848 File Offset: 0x00016A48
	public override void UpdateScreen()
	{
		if (!this.taking_pic)
		{
			this.DoEffects();
		}
		if (this.cam.backgroundColor != Camera.main.backgroundColor)
		{
			this.cam.backgroundColor = Camera.main.backgroundColor;
		}
		Vector3 euler = default(Vector3);
		bool flag;
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
		{
			Vector2 a = Vector2.zero;
			Vector3 touchPoint = PhoneInput.GetTouchPoint();
			if (touchPoint == Vector3.one * -1f)
			{
				this.hold_timer = 0f;
				a = Vector2.zero;
			}
			else if (!PhoneInput.IsPressed())
			{
				if (this.hold_timer == 0f)
				{
					this.hold_timer = 0.2f;
				}
			}
			else
			{
				this.hold_timer = 0f;
				a.x = touchPoint.x - 0.5f;
				a.y = touchPoint.y - 0.5f;
				a = Vector2.ClampMagnitude(a * 4f, 1f);
			}
			if (!this.taking_pic)
			{
				this.hold_timer -= Time.deltaTime;
			}
			if (this.hold_timer <= 0f)
			{
				this.input = a;
				this.hold_timer = 0f;
			}
			flag = false;
			if (PhoneInput.IsPressed() && touchPoint != Vector3.one * -1f)
			{
				if (PhoneInput.IsPressedDown() && (this.lastclick <= 0.42f || this.lastclick <= Time.deltaTime) && Vector3.Distance(this.lastpos, touchPoint) <= 0.1f)
				{
					flag = true;
				}
				this.lastclick = 0f;
			}
			else if (!PhoneInput.IsPressed() && this.lastpressed)
			{
				this.lastpos = touchPoint;
			}
			if (flag)
			{
				this.lastclick = 1f;
			}
			this.lastpressed = PhoneInput.IsPressed();
		}
		else
		{
			this.hold_timer = 0f;
			flag = true;
			this.input = PhoneInput.GetControlDir();
		}
		this.lastclick += Time.deltaTime;
		if (this.waitingforrelease)
		{
			if (this.input.magnitude <= 0.05f)
			{
				this.waitingforrelease = false;
			}
			else
			{
				this.input = Vector2.zero;
			}
		}
		euler.y = this.input.x * 45f;
		euler.x = this.input.y * -45f;
		if (!this.taking_pic)
		{
			this.cam.transform.localRotation = Quaternion.Slerp(this.cam.transform.localRotation, Quaternion.Euler(euler), Time.deltaTime * 10f);
		}
		flag = (flag && !this.taking_pic);
		if (flag && PhoneInput.IsPressedDown())
		{
			base.StartCoroutine("TakePic");
		}
	}

	// Token: 0x0600041D RID: 1053 RVA: 0x00018B5C File Offset: 0x00016D5C
	private void DoEffects()
	{
		int num = this.effectIndex;
		if (Input.GetAxisRaw("EffectSwitch") > 0.5f)
		{
			if (this.canswitch)
			{
				this.effectIndex++;
				this.canswitch = false;
			}
		}
		else
		{
			if (Input.GetAxisRaw("EffectSwitch") >= -0.5f)
			{
				this.canswitch = true;
				return;
			}
			if (this.canswitch)
			{
				this.effectIndex--;
				this.canswitch = false;
			}
		}
		if (this.effectIndex >= this.imageEffects.Count)
		{
			this.effectIndex = -1;
		}
		else if (this.effectIndex < -1)
		{
			this.effectIndex = this.imageEffects.Count - 1;
		}
		if (this.effectIndex != num)
		{
			this.SetEffectActive(num, false);
			this.SetEffectActive(this.effectIndex, true);
			this.ResetMessage();
		}
	}

	// Token: 0x0600041E RID: 1054 RVA: 0x00018C54 File Offset: 0x00016E54
	public void SetEffectActive(int index, bool isactive)
	{
		if (index >= 0)
		{
			(this.imageEffects[index] as MonoBehaviour).enabled = isactive;
		}
	}

	// Token: 0x0600041F RID: 1055 RVA: 0x00018C74 File Offset: 0x00016E74
	public void SetTextureColor(Color col)
	{
		float a = this.gui_texture.color.a;
		col.a = a;
		this.gui_texture.color = col;
	}

	// Token: 0x06000420 RID: 1056 RVA: 0x00018CAC File Offset: 0x00016EAC
	public void SetMessage(string message)
	{
		this.SetMessage(message, 3f);
	}

	// Token: 0x06000421 RID: 1057 RVA: 0x00018CBC File Offset: 0x00016EBC
	public void SetMessage(string message, float wait)
	{
		if (this.gui_text.text != message)
		{
			this.gui_text.text = message;
		}
		base.CancelInvoke("ResetMessage");
		base.Invoke("ResetMessage", wait);
	}

	// Token: 0x06000422 RID: 1058 RVA: 0x00018D04 File Offset: 0x00016F04
	public void SetMessage(string message, Color color, float wait)
	{
		this.gui_text.material.color = color;
		this.SetMessage(message, wait);
	}

	// Token: 0x06000423 RID: 1059 RVA: 0x00018D20 File Offset: 0x00016F20
	public void SetMessage(string message, Color color)
	{
		this.gui_text.material.color = color;
		this.SetMessage(message);
	}

	// Token: 0x17000091 RID: 145
	// (get) Token: 0x06000424 RID: 1060 RVA: 0x00018D3C File Offset: 0x00016F3C
	private string normal_message
	{
		get
		{
			if (PhoneInput.controltype == PhoneInput.ControlType.Mouse)
			{
				return "Drag & Click to snap a pic";
			}
			return "Click to take a pic";
		}
	}

	// Token: 0x06000425 RID: 1061 RVA: 0x00018D54 File Offset: 0x00016F54
	public void ResetMessage()
	{
		string arg = "none";
		if (this.effectIndex != -1)
		{
			arg = string.Format("{0}/{1}", (this.effectIndex + 1).ToString(), this.imageEffects.Count.ToString());
		}
		string arg2 = "[,]";
		if (PhoneInput.controltype == PhoneInput.ControlType.Keyboard)
		{
			arg2 = "DPad";
		}
		this.gui_text.text = string.Format("{1}\n{2} cycle effects-{0}", arg, this.normal_message, arg2);
		this.gui_text.material.color = Color.white;
	}

	// Token: 0x06000426 RID: 1062 RVA: 0x00018DEC File Offset: 0x00016FEC
	public override void OnPause()
	{
		this.cam.gameObject.active = false;
		this.cam.enabled = false;
	}

	// Token: 0x06000427 RID: 1063 RVA: 0x00018E0C File Offset: 0x0001700C
	public override void OnResume()
	{
		this.cam.gameObject.active = true;
		this.cam.enabled = true;
	}

	// Token: 0x06000428 RID: 1064 RVA: 0x00018E2C File Offset: 0x0001702C
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		this.cam.gameObject.active = true;
		this.cam.enabled = true;
		this.cam.gameObject.active = true;
		if (this.gui_text)
		{
			this.gui_text.enabled = true;
		}
		if (this.gui_texture)
		{
			this.gui_texture.enabled = true;
		}
		this.oldcam.enabled = false;
		this.oldcam.gameObject.active = false;
		this.oldmat = PhoneInterface.view_controller.phoneviewscreen.renderer.material;
		PhoneInterface.view_controller.phoneviewscreen.renderer.material = this.rendmat;
		PhoneInterface.view_controller.phoneviewscreen.renderer.material.mainTexture = this.rendtex;
		this.oldmat.mainTextureScale = Vector2.one;
		this.oldmat.mainTextureOffset = Vector2.zero;
		this.rendmat.mainTextureScale = Vector2.one;
		this.rendmat.mainTextureOffset = Vector2.zero;
		string[] array = new string[]
		{
			"Loading EdgeReject filter...",
			"Reskinning JSR...",
			"Pretending to be artsy...",
			"Searching your dreams...",
			"Disabling sandworms..."
		};
		string message = array[UnityEngine.Random.Range(0, array.Length)];
		this.SetMessage(message, Color.Lerp(Color.red, Color.yellow, 5f), 1f);
		this.hold_timer = 0f;
		this.waitingforrelease = true;
	}

	// Token: 0x06000429 RID: 1065 RVA: 0x00018FC8 File Offset: 0x000171C8
	public override void OnExit()
	{
		if (this.gui_text)
		{
			this.gui_text.enabled = false;
		}
		if (this.gui_texture)
		{
			this.gui_texture.enabled = false;
		}
		this.cam.enabled = false;
		this.cam.gameObject.active = false;
		this.oldcam.enabled = true;
		this.oldcam.gameObject.active = true;
		PhoneInterface.view_controller.phoneviewscreen.renderer.material = this.oldmat;
		base.OnExit();
	}

	// Token: 0x0600042A RID: 1066 RVA: 0x00019068 File Offset: 0x00017268
	private IEnumerator TakePic()
	{
		while (this.taking_pic)
		{
			yield return null;
		}
		this.taking_pic = true;
		this.cam.GetComponent<GUILayer>().enabled = false;
		if (this.snapSound)
		{
			AudioSource.PlayClipAtPoint(this.snapSound, Vector3.zero);
		}
		yield return new WaitForEndOfFrame();
		Texture2D ntex = new Texture2D(480, 800, TextureFormat.RGB24, false);
		RenderTexture.active = this.rendtex;
		ntex.ReadPixels(new Rect(0f, 0f, 480f, 800f), 0, 0);
		RenderTexture.active = null;
		if (TwitterDemo.instance._canTweet && TwitterDemo.instance._isConnected)
		{
			TweetContext tweet = new TweetContext
			{
				texture = ntex
			};
			List<NetPlayer> players = PhoneCamControl.GetPlayersInView(this.cam);
			foreach (NetPlayer player in players)
			{
				string nam = player.userName;
				if (nam.Contains(" "))
				{
					nam = "gamsfest";
				}
				if (!tweet.mentions.Contains(nam))
				{
					tweet.mentions.Add(nam);
				}
			}
			yield return null;
			TwitterDemo.instance.DoPostImage(tweet);
			this.SetMessage("Posting to twitter");
			if (Application.isEditor)
			{
				Debug.Log("Sending to twitter...");
			}
		}
		else
		{
			yield return null;
			byte[] bytes = ntex.EncodeToPNG();
			yield return null;
			string timestr = DateTime.Now.ToString("M-d-yyyy_H-mm-ss");
			string filename = timestr.Replace(' ', '_').Replace(':', '-').Replace('/', '-') + ".png";
			File.WriteAllBytes(filename, bytes);
			this.SetMessage(string.Format("Saved: {0}", filename));
			if (Application.isEditor)
			{
				Debug.Log(string.Format("Took screenshot to: {0}", filename));
			}
		}
		yield return null;
		UnityEngine.Object.Destroy(ntex);
		this.cam.enabled = false;
		yield return new WaitForSeconds(0.25f);
		this.cam.enabled = true;
		this.cam.GetComponent<GUILayer>().enabled = true;
		this.taking_pic = false;
		yield break;
	}

	// Token: 0x0600042B RID: 1067 RVA: 0x00019084 File Offset: 0x00017284
	public static List<NetPlayer> GetPlayersInView(Camera camr)
	{
		string text = string.Empty;
		List<NetPlayer> list = new List<NetPlayer>();
		foreach (NetPlayer netPlayer in Networking.netplayer_dic.Values)
		{
			if (!(netPlayer.networkPlayer == Network.player))
			{
				Vector3 vector = netPlayer.transform.position + netPlayer.transform.up * 2.5f;
				Vector3 vector2 = camr.WorldToViewportPoint(vector);
				if (vector2.x >= 0f && vector2.y >= 0f && vector2.x < 1f && vector2.y < 1f && vector2.z > 0f)
				{
					Vector3 direction = vector - camr.transform.position;
					RaycastHit raycastHit;
					if (!Physics.Raycast(camr.transform.position, direction, out raycastHit, vector2.z))
					{
						list.Add(netPlayer);
						string text2 = text;
						text = string.Concat(new object[]
						{
							text2,
							netPlayer.userName,
							" ",
							vector2.x,
							", ",
							vector2.y,
							"\n"
						});
					}
				}
			}
		}
		return list;
	}

	// Token: 0x0400033B RID: 827
	private static PhoneCamControl _instance;

	// Token: 0x0400033C RID: 828
	public Camera cam;

	// Token: 0x0400033D RID: 829
	public AudioClip snapSound;

	// Token: 0x0400033E RID: 830
	public string[] effectNames = new string[0];

	// Token: 0x0400033F RID: 831
	public List<Component> imageEffects = new List<Component>();

	// Token: 0x04000340 RID: 832
	public RenderTexture rendtex;

	// Token: 0x04000341 RID: 833
	public Material rendmat;

	// Token: 0x04000342 RID: 834
	private Material oldmat;

	// Token: 0x04000343 RID: 835
	public Camera oldcam;

	// Token: 0x04000344 RID: 836
	public GUITexture gui_texture;

	// Token: 0x04000345 RID: 837
	public GUIText gui_text;

	// Token: 0x04000346 RID: 838
	private Vector2 input = Vector2.zero;

	// Token: 0x04000347 RID: 839
	private float hold_timer;

	// Token: 0x04000348 RID: 840
	private float lastclick;

	// Token: 0x04000349 RID: 841
	private Vector2 lastpos = Vector2.zero;

	// Token: 0x0400034A RID: 842
	private bool lastpressed;

	// Token: 0x0400034B RID: 843
	private bool waitingforrelease = true;

	// Token: 0x0400034C RID: 844
	private bool canswitch = true;

	// Token: 0x0400034D RID: 845
	private int effectIndex = -1;

	// Token: 0x0400034E RID: 846
	private bool taking_pic;
}
