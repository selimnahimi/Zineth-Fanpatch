using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000048 RID: 72
public class PhoneController : MonoBehaviour
{
	// Token: 0x1700004D RID: 77
	// (get) Token: 0x06000290 RID: 656 RVA: 0x000115A0 File Offset: 0x0000F7A0
	public static float deltatime
	{
		get
		{
			if (PhoneController._use_fixed_update)
			{
				return Time.fixedDeltaTime;
			}
			return Time.deltaTime;
		}
	}

	// Token: 0x1700004E RID: 78
	// (get) Token: 0x06000291 RID: 657 RVA: 0x000115B8 File Offset: 0x0000F7B8
	public static PhoneController instance
	{
		get
		{
			if (PhoneController._instance == null)
			{
				PhoneController._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneController)) as PhoneController);
			}
			return PhoneController._instance;
		}
	}

	// Token: 0x06000292 RID: 658 RVA: 0x000115F4 File Offset: 0x0000F7F4
	public static bool DoPhoneCommand(string command)
	{
		return PhoneController.instance.DoCommand(command);
	}

	// Token: 0x06000293 RID: 659 RVA: 0x00011604 File Offset: 0x0000F804
	private void Start()
	{
		PhoneController.trans = base.transform;
		PhoneTextController.buttonprefab = this.buttonprefab;
		if (this.parser == null)
		{
			this.parser = base.gameObject.AddComponent<PhoneParser>();
		}
		this.parser.Init(this);
		if (this.phoneback == null)
		{
			this.phoneback = GameObject.Find("PhoneBack").transform;
		}
		if (this.phonecam == null)
		{
			this.phonecam = GameObject.Find("PhoneCamera").camera;
		}
		if (this.phoneviewcam == null)
		{
			this.phoneviewcam = GameObject.Find("PhoneViewCamera").camera;
		}
		if (PhoneController.particlesys == null)
		{
			PhoneController.particlesys = this.particleSystemPrefab;
		}
		if (this.phoneviewcontroller == null)
		{
			this.phoneviewcontroller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneViewController)) as PhoneViewController);
		}
		if (this.demo == null)
		{
			this.demo = (UnityEngine.Object.FindObjectOfType(typeof(TwitterDemo)) as TwitterDemo);
		}
		PhoneInput.phonecontroller = this;
		PhoneInput.phonescenecamera = this.phonecam;
		PhoneInput.phonescreencamera = this.phoneviewcam;
		this.phonecam.gameObject.active = false;
		if (GameObject.Find("PhoneScreen"))
		{
			PhoneInput.phonescreencollider = GameObject.Find("PhoneScreen").collider;
		}
		this.BootUp();
		if (this.open_at_start)
		{
			base.Invoke("OpenUp", 0.1f);
		}
	}

	// Token: 0x06000294 RID: 660 RVA: 0x000117B0 File Offset: 0x0000F9B0
	private void OpenUp()
	{
		PhoneInterface.view_controller.SetOpen(true, true);
	}

	// Token: 0x06000295 RID: 661 RVA: 0x000117C0 File Offset: 0x0000F9C0
	private void BootUp()
	{
		PhoneController.presspos = PhoneController.trans.position;
		this.SetBackColor();
		this.SetupScreenDict();
		this.InitScreens();
		if (this.load_tut)
		{
			this.LoadScreenQuiet("Tutorial");
		}
		else
		{
			this.LoadScreenQuiet(this.startscreen);
		}
		PhoneController.powerstate = PhoneController.PowerState.closed;
	}

	// Token: 0x06000296 RID: 662 RVA: 0x00011820 File Offset: 0x0000FA20
	private void SetupScreenDict()
	{
		this.screendict.Clear();
		foreach (PhoneScreen phoneScreen in base.transform.GetComponentsInChildren<PhoneScreen>())
		{
			this.screendict.Add(phoneScreen.screenname, phoneScreen);
		}
	}

	// Token: 0x06000297 RID: 663 RVA: 0x00011870 File Offset: 0x0000FA70
	private void InitScreens()
	{
		foreach (PhoneScreen phoneScreen in this.screendict.Values)
		{
			if (phoneScreen.controller == null)
			{
				phoneScreen.controller = this;
			}
			phoneScreen.Init();
			if (phoneScreen.bgscreen)
			{
				this.bgscreens.Add(phoneScreen);
			}
			else
			{
				phoneScreen.gameObject.SetActiveRecursively(false);
			}
		}
	}

	// Token: 0x06000298 RID: 664 RVA: 0x0001191C File Offset: 0x0000FB1C
	private void Update()
	{
		Input.GetButtonDown("InvertPhoneStick");
		if (!PhoneController._use_fixed_update)
		{
			switch (PhoneController.powerstate)
			{
			case PhoneController.PowerState.closed:
				this.Update_Closed();
				break;
			case PhoneController.PowerState.open:
				this.Update_Open();
				break;
			case PhoneController.PowerState.off:
				this.Update_Off();
				break;
			}
		}
	}

	// Token: 0x06000299 RID: 665 RVA: 0x0001197C File Offset: 0x0000FB7C
	private void Update_Open()
	{
		this.HandleRinging();
		PhoneInput.DetectControlType();
		this.UpdateScreen();
		this.UpdateBgScreens();
	}

	// Token: 0x0600029A RID: 666 RVA: 0x00011998 File Offset: 0x0000FB98
	private void Update_Closed()
	{
		this.HandleRinging();
	}

	// Token: 0x0600029B RID: 667 RVA: 0x000119A0 File Offset: 0x0000FBA0
	private void Update_Off()
	{
	}

	// Token: 0x0600029C RID: 668 RVA: 0x000119A4 File Offset: 0x0000FBA4
	public bool DoCommand(string command)
	{
		return this.parser.DoStringCommand(command);
	}

	// Token: 0x0600029D RID: 669 RVA: 0x000119B4 File Offset: 0x0000FBB4
	private void UpdateScreen()
	{
		if (this.curscreen)
		{
			this.curscreen.UpdateScreen();
		}
	}

	// Token: 0x0600029E RID: 670 RVA: 0x000119D4 File Offset: 0x0000FBD4
	private void UpdateBgScreens()
	{
		foreach (PhoneScreen phoneScreen in this.bgscreens)
		{
			phoneScreen.UpdateScreen();
		}
	}

	// Token: 0x0600029F RID: 671 RVA: 0x00011A3C File Offset: 0x0000FC3C
	public PhoneScreen getScreen(string screen)
	{
		if (this.screendict.ContainsKey(screen))
		{
			return this.screendict[screen];
		}
		return null;
	}

	// Token: 0x060002A0 RID: 672 RVA: 0x00011A60 File Offset: 0x0000FC60
	public bool LoadScreenQuiet(string screenname)
	{
		PhoneScreen screen = this.getScreen(screenname);
		if (screen != null)
		{
			this.LoadScreenQuiet(screen);
			return true;
		}
		Debug.LogWarning("tried to load nonexisting screen: " + screenname);
		return false;
	}

	// Token: 0x060002A1 RID: 673 RVA: 0x00011A9C File Offset: 0x0000FC9C
	public bool LoadScreen(string screenname)
	{
		PhoneScreen screen = this.getScreen(screenname);
		if (screen != null)
		{
			this.LoadScreen(screen);
			return true;
		}
		Debug.LogWarning("tried to load nonexisting screen: " + screenname);
		return false;
	}

	// Token: 0x060002A2 RID: 674 RVA: 0x00011AD8 File Offset: 0x0000FCD8
	public void LoadScreen(PhoneScreen screen)
	{
		if (this.curscreen != null && this.curscreen.screenname == this.startscreen && screen.clip)
		{
			PhoneAudioController.PlayAudioClip(screen.clip, SoundType.menu);
		}
		this.LoadScreenQuiet(screen);
	}

	// Token: 0x060002A3 RID: 675 RVA: 0x00011B38 File Offset: 0x0000FD38
	public void LoadScreenQuiet(PhoneScreen screen)
	{
		PhoneScreen phoneScreen = this.curscreen;
		this.curscreen = screen;
		if (phoneScreen != null)
		{
			this.returnname = phoneScreen.screenname;
			phoneScreen.OnExit();
		}
		screen.transform.position = PhoneController.trans.position;
		if (screen.clearparticles)
		{
			foreach (ParticleSystem particleSystem in base.GetComponentsInChildren<ParticleSystem>())
			{
				particleSystem.Stop();
			}
		}
		screen.OnLoad();
		Playtomic.Log.CustomMetric("tReachedScreen " + screen.screenname, "tPhone", true);
	}

	// Token: 0x060002A4 RID: 676 RVA: 0x00011BDC File Offset: 0x0000FDDC
	public bool LoadPrevious()
	{
		return this.LoadScreen(this.returnname);
	}

	// Token: 0x060002A5 RID: 677 RVA: 0x00011BEC File Offset: 0x0000FDEC
	public void SetBackColor()
	{
		Color backgroundColor = PhoneMemory.settings.backgroundColor;
		if (Application.platform != RuntimePlatform.Android)
		{
			backgroundColor.a = 0.9f;
		}
		this.phoneback.renderer.material.color = backgroundColor;
	}

	// Token: 0x060002A6 RID: 678 RVA: 0x00011C34 File Offset: 0x0000FE34
	public void SetBackColor(Color color)
	{
		if (Application.platform != RuntimePlatform.Android)
		{
			color.a = 0.9f;
		}
		this.phoneback.renderer.material.color = color;
	}

	// Token: 0x060002A7 RID: 679 RVA: 0x00011C70 File Offset: 0x0000FE70
	public void OnScreenOpen()
	{
		this.OnScreenOpen(false);
	}

	// Token: 0x060002A8 RID: 680 RVA: 0x00011C7C File Offset: 0x0000FE7C
	public void OnScreenOpen(bool force)
	{
		if (!this.allow_open && !force)
		{
			return;
		}
		PhoneController.powerstate = PhoneController.PowerState.open;
		this.phonecam.gameObject.active = true;
		this.StopRinging();
		PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_open, SoundType.menu);
		if (this.curscreen)
		{
			this.curscreen.OnResume();
		}
		Playtomic.Log.CustomMetric("tPhoneOpened", "tPhone", true);
		if (PhoneInterface.player_move)
		{
			Animation animation = PhoneInterface.player_move.model.animation;
			if (animation["PhoneArm"] != null)
			{
				animation["PhoneArm"].speed = Mathf.Abs(animation["PhoneArm"].speed);
				animation["PhoneArm"].wrapMode = WrapMode.ClampForever;
				animation["PhoneArm"].weight = 0.5f;
				animation["PhoneArm"].enabled = true;
				animation.CrossFade("PhoneArm");
			}
		}
		this.phonecam.enabled = true;
		this.phonecam.gameObject.active = true;
	}

	// Token: 0x060002A9 RID: 681 RVA: 0x00011DB4 File Offset: 0x0000FFB4
	public void OnScreenClose()
	{
		this.OnScreenClose(false);
	}

	// Token: 0x060002AA RID: 682 RVA: 0x00011DC0 File Offset: 0x0000FFC0
	public void OnScreenClose(bool force)
	{
		if (!this.allow_close && !force)
		{
			return;
		}
		PhoneController.powerstate = PhoneController.PowerState.closed;
		PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_close, SoundType.menu);
		if (this.curscreen)
		{
			this.curscreen.OnPause();
		}
		Playtomic.Log.CustomMetric("tPhoneClosed", "tPhone", true);
		if (PhoneInterface.player_move)
		{
			Animation animation = PhoneInterface.player_move.model.animation;
			if (animation["PhoneArm"] != null)
			{
				animation["PhoneArm"].speed = -Mathf.Abs(animation["PhoneArm"].speed);
				animation["PhoneArm"].wrapMode = WrapMode.Once;
				animation["PhoneArm"].time = animation["PhoneArm"].length;
				animation.CrossFade("PhoneArm");
			}
		}
		this.phonecam.enabled = false;
	}

	// Token: 0x060002AB RID: 683 RVA: 0x00011ECC File Offset: 0x000100CC
	public void OnPowerOff()
	{
		this.phonecam.gameObject.active = false;
	}

	// Token: 0x060002AC RID: 684 RVA: 0x00011EE0 File Offset: 0x000100E0
	public void OnHomePressed()
	{
		this.OnHomePressed(false);
	}

	// Token: 0x060002AD RID: 685 RVA: 0x00011EEC File Offset: 0x000100EC
	public void OnHomePressed(bool force)
	{
		if (PhoneController.powerstate == PhoneController.PowerState.open)
		{
			if (!this.allow_home && !force)
			{
				return;
			}
			PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_back, SoundType.menu);
			PhoneController.presspos = PhoneController.trans.position + PhoneController.trans.forward * -4f;
			this.LoadScreenQuiet(this.startscreen);
			this.getScreen(this.startscreen).OnHomeLoad();
			Playtomic.Log.CustomMetric("tHomePressed", "tPhone", true);
		}
		else if (PhoneController.powerstate == PhoneController.PowerState.closed)
		{
			this.StopRinging();
		}
	}

	// Token: 0x060002AE RID: 686 RVA: 0x00011F98 File Offset: 0x00010198
	public static void EmitPartsMenu(Vector3 pos, int amount)
	{
		PhoneController.EmitParts(pos, amount, PhoneMemory.settings.particleColor);
	}

	// Token: 0x060002AF RID: 687 RVA: 0x00011FAC File Offset: 0x000101AC
	public static void EmitParts(Vector3 pos, int amount)
	{
		PhoneController.EmitParts(pos, amount, Color.black);
	}

	// Token: 0x060002B0 RID: 688 RVA: 0x00011FBC File Offset: 0x000101BC
	public static void EmitParts(Vector3 pos, int amount, Color color)
	{
		ParticleSystem particleSystem = PhoneController.MakeParts(pos);
		particleSystem.startColor = color;
		particleSystem.renderer.material.color = color;
		particleSystem.Emit(amount);
	}

	// Token: 0x060002B1 RID: 689 RVA: 0x00011FF0 File Offset: 0x000101F0
	private static ParticleSystem MakeParts(Vector3 pos)
	{
		for (int i = 0; i < PhoneController.part_array.Length; i++)
		{
			if (PhoneController.part_array[i] == null)
			{
				ParticleSystem component = (UnityEngine.Object.Instantiate(PhoneController.particlesys.gameObject) as GameObject).GetComponent<ParticleSystem>();
				component.transform.position = pos;
				component.transform.parent = PhoneController.trans;
				PhoneController.part_array[i] = component;
				return component;
			}
			if (!PhoneController.part_array[i].isPlaying)
			{
				PhoneController.part_array[i].transform.position = pos;
				return PhoneController.part_array[i];
			}
		}
		Debug.LogWarning("hey! you are trying to use more particle systems than the array has room for! wow...");
		return null;
	}

	// Token: 0x060002B2 RID: 690 RVA: 0x000120A0 File Offset: 0x000102A0
	public void OnNewMessage()
	{
		this.ringcount = 6;
		this.ringtimer = 0f;
	}

	// Token: 0x060002B3 RID: 691 RVA: 0x000120B4 File Offset: 0x000102B4
	public void OnNewMessage(int rings)
	{
		this.ringcount += rings;
		if (this.ringcount > 3)
		{
			this.ringcount = 3;
		}
		this.ringtimer = 0f;
	}

	// Token: 0x060002B4 RID: 692 RVA: 0x000120F0 File Offset: 0x000102F0
	public void StopRinging()
	{
		if (PhoneAudioController.gobj_ring)
		{
			UnityEngine.Object.Destroy(PhoneAudioController.gobj_ring.gameObject);
		}
		this.vibratecount = 0;
		this.ringcount = 0;
		this.phoneviewcam.transform.localPosition = Vector3.zero;
		this.phoneviewcontroller.SetLightBrightness(0f);
	}

	// Token: 0x060002B5 RID: 693 RVA: 0x00012150 File Offset: 0x00010350
	public void HandleRinging()
	{
		if (this.ringcount >= 0)
		{
			if (!PhoneAudioController.gobj_ring)
			{
				if (this.ringtimer <= 0f && this.ringcount > 0)
				{
					this.Ring();
				}
				this.ringtimer -= PhoneController.deltatime;
			}
			else
			{
				if (this.vibratecount > 0 && this.vibratetimer <= 0f)
				{
					this.Rumble();
				}
				this.vibratetimer -= PhoneController.deltatime;
			}
			if (this.phoneviewcam)
			{
				this.phoneviewcam.transform.localPosition = UnityEngine.Random.insideUnitSphere * XInput.GetPhoneVibrateForce().magnitude * 0.15f;
			}
			if (this.phoneviewcontroller)
			{
				this.phoneviewcontroller.SetLightBrightness(XInput.GetPhoneVibrateForce().magnitude * 5f);
			}
		}
	}

	// Token: 0x060002B6 RID: 694 RVA: 0x00012254 File Offset: 0x00010454
	private void Rumble()
	{
		XInput.AddPhoneVibrateForce(0.5f, 1f, 0.25f);
		this.vibratetimer = this.vibrateinterval;
	}

	// Token: 0x060002B7 RID: 695 RVA: 0x00012284 File Offset: 0x00010484
	private void Ring()
	{
		if (PhoneAudioController.StartRinging())
		{
			this.ringcount--;
		}
		this.ringtimer = this.ringinterval;
		this.vibratecount = 2;
		this.vibratetimer = 0f;
	}

	// Token: 0x1700004F RID: 79
	// (get) Token: 0x060002B8 RID: 696 RVA: 0x000122C8 File Offset: 0x000104C8
	public static GameObject buttonBackPrefab
	{
		get
		{
			return PhoneController.instance._buttonBackPrefab;
		}
	}

	// Token: 0x0400026A RID: 618
	public Transform phoneback;

	// Token: 0x0400026B RID: 619
	public Camera phonecam;

	// Token: 0x0400026C RID: 620
	public Camera phoneviewcam;

	// Token: 0x0400026D RID: 621
	public PhoneViewController phoneviewcontroller;

	// Token: 0x0400026E RID: 622
	public TwitterDemo demo;

	// Token: 0x0400026F RID: 623
	public Color backcolor = Color.gray;

	// Token: 0x04000270 RID: 624
	public string startscreen = "Main_Menu";

	// Token: 0x04000271 RID: 625
	public PhoneScreen curscreen;

	// Token: 0x04000272 RID: 626
	public PhoneButton buttonprefab;

	// Token: 0x04000273 RID: 627
	public PhoneMenuLine[] menulines;

	// Token: 0x04000274 RID: 628
	private static Transform trans;

	// Token: 0x04000275 RID: 629
	public static Vector3 presspos = Vector3.zero;

	// Token: 0x04000276 RID: 630
	public static PhoneController.PowerState powerstate = PhoneController.PowerState.off;

	// Token: 0x04000277 RID: 631
	public static ParticleSystem particlesys;

	// Token: 0x04000278 RID: 632
	public ParticleSystem particleSystemPrefab;

	// Token: 0x04000279 RID: 633
	public PhoneMemory phonememory;

	// Token: 0x0400027A RID: 634
	public string returnname;

	// Token: 0x0400027B RID: 635
	public bool allow_home = true;

	// Token: 0x0400027C RID: 636
	public bool allow_open = true;

	// Token: 0x0400027D RID: 637
	public bool allow_close = true;

	// Token: 0x0400027E RID: 638
	public bool open_at_start;

	// Token: 0x0400027F RID: 639
	public static bool _use_fixed_update = false;

	// Token: 0x04000280 RID: 640
	public Dictionary<string, PhoneScreen> screendict = new Dictionary<string, PhoneScreen>();

	// Token: 0x04000281 RID: 641
	public List<PhoneScreen> bgscreens = new List<PhoneScreen>();

	// Token: 0x04000282 RID: 642
	private static PhoneController _instance;

	// Token: 0x04000283 RID: 643
	private PhoneParser parser;

	// Token: 0x04000284 RID: 644
	public bool load_tut = true;

	// Token: 0x04000285 RID: 645
	private static ParticleSystem[] part_array = new ParticleSystem[10];

	// Token: 0x04000286 RID: 646
	private int ringcount;

	// Token: 0x04000287 RID: 647
	private float ringinterval = 1f;

	// Token: 0x04000288 RID: 648
	private float ringtimer;

	// Token: 0x04000289 RID: 649
	private int vibratecount;

	// Token: 0x0400028A RID: 650
	private float vibrateinterval = 0.5f;

	// Token: 0x0400028B RID: 651
	private float vibratetimer;

	// Token: 0x0400028C RID: 652
	public GameObject _buttonBackPrefab;

	// Token: 0x02000049 RID: 73
	public enum PowerState
	{
		// Token: 0x0400028E RID: 654
		closed,
		// Token: 0x0400028F RID: 655
		open,
		// Token: 0x04000290 RID: 656
		off
	}
}
