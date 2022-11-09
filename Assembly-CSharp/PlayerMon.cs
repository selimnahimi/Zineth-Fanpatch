using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200000A RID: 10
public class PlayerMon : MonoBehaviour
{
	// Token: 0x0600002C RID: 44 RVA: 0x00002B08 File Offset: 0x00000D08
	private void Start()
	{
		this._player = GameObject.Find("Player").transform;
		this.player = this._player.GetComponent<move>();
		this.pyramid = GameObject.Find("Pyramid").transform.GetComponent<PyramidScript>();
		this._pyramid = GameObject.Find("TextHolder").transform;
	}

	// Token: 0x0600002D RID: 45 RVA: 0x00002B6C File Offset: 0x00000D6C
	private void Update()
	{
		PlayerMon.xbox = (Input.GetJoystickNames().Length > 0);
		this.rewindControl = Input.GetButton("Rewind");
		this.vertControl = (Input.GetAxis("Vertical") >= 0f);
		if (this.rewind)
		{
			if (this.timeSinceFuckUp > 5f && !this.rewindCheck && this.rewindQueued)
			{
				this.rewindCheck = false;
				this.rewindQueued = false;
				this.TurnOff();
				if (this.previous != null)
				{
					this.turnOn(this.previous);
				}
				else
				{
					PhoneInterface.view_controller.SetOpen(false);
				}
			}
			this.timeSinceFuckUp += Time.deltaTime;
		}
		if (this.rewindCheck && Input.GetButton("Skate"))
		{
			this.rewindCheck = false;
			this.rewindQueued = false;
			this.TurnOff();
			if (this.previous != null)
			{
				this.turnOn(this.previous);
			}
			else
			{
				PhoneInterface.view_controller.SetOpen(false);
			}
		}
		if (Physics.Raycast(this._player.position + this._player.up / 4f, -this._player.up, out this.floor, 0.6f))
		{
			if (this.floor.transform.name == "ramps")
			{
				this.jumpReminder = true;
			}
			else
			{
				this.jumpReminder = false;
			}
		}
		if (this.jumpReminder && !this.player.freezeControls)
		{
			if (this.player.grounded)
			{
				this.jumped = false;
			}
			else if (!this.player.grounded && Input.GetButton("Jump"))
			{
				this.jumped = true;
			}
			if (this.player.grounded || this.jumped)
			{
				this.timeInAir = 0f;
			}
			else
			{
				this.timeInAir += Time.deltaTime;
				if ((double)this.timeInAir > 0.3)
				{
					this.Change("99");
					this.jumped = true;
					this.jumpUP = true;
					this.jumpUPCounter = 0f;
				}
			}
		}
		if (this.jumpUP)
		{
			this.jumpUPCounter += Time.deltaTime;
			if (this.jumpUPCounter >= 5f && Input.GetButton("Rewind"))
			{
				this.TurnOff();
				if (this.previous != null)
				{
					this.turnOn(this.previous);
				}
				else
				{
					PhoneInterface.view_controller.SetOpen(false);
				}
				this.jumpUP = false;
				this.jumpUPCounter = 0f;
			}
		}
		if (Input.GetButtonDown("Skate"))
		{
			this.skates++;
		}
		if (Input.GetButton("Skate"))
		{
			this.lengthHeld += Time.deltaTime;
			if (this.lengthHeld > 3f && !this.messageUp)
			{
				this.TurnOff();
				this.turnOn(this._pyramid.Find("15"));
				PhoneInterface.view_controller.SetOpen(true);
				PhoneController.instance.OnNewMessage(1);
				this.messageUp = true;
				this.skates = 0;
			}
		}
		else
		{
			this.lengthHeld = 0f;
			if (this.messageUp && this.skates > 2)
			{
				this.TurnOff();
				if (this.previous != null)
				{
					this.turnOn(this.previous);
				}
				this.skates = 0;
				if (this.previous != null)
				{
					PhoneInterface.view_controller.SetOpen(true);
					PhoneController.instance.OnNewMessage(1);
				}
				else
				{
					PhoneInterface.view_controller.SetOpen(false);
				}
				this.messageUp = false;
			}
		}
		if (this.wallCheck)
		{
			if (!this.triggered && !this.player.grounded && !this.player.wallRiding && !this.player.freezeControls)
			{
				bool flag = false;
				if (Physics.Raycast(this._player.position, this._player.right, out this.tempWallRay, 2f))
				{
					flag = true;
					this.wallRay = this.tempWallRay;
				}
				else if (Physics.Raycast(this._player.position, -this._player.right, out this.tempWallRay, 2f))
				{
					flag = true;
					this.wallRay = this.tempWallRay;
				}
				if (flag)
				{
					if (!Input.GetButton("Jump"))
					{
						this.Change("96");
						this.triggered = true;
					}
					else if (this._player.rigidbody.velocity.y < -2f)
					{
						this.Change("95");
						this.triggered = true;
					}
					else if (this._player.rigidbody.velocity.z + this._player.rigidbody.velocity.x < 30f)
					{
					}
				}
			}
			if (this.player.grounded)
			{
				this.triggered = false;
			}
		}
		if (this.triggered && this.player.wallRiding)
		{
			this.triggered = false;
			this.TurnOff();
			if (this.previous != null)
			{
				this.turnOn(this.previous);
			}
			if (this.previous != null)
			{
				PhoneInterface.view_controller.SetOpen(true);
				PhoneController.instance.OnNewMessage(1);
			}
			else
			{
				PhoneInterface.view_controller.SetOpen(false);
			}
		}
	}

	// Token: 0x0600002E RID: 46 RVA: 0x00003180 File Offset: 0x00001380
	private void FixedUpdate()
	{
		float num = this._player.InverseTransformDirection(this._player.rigidbody.velocity).z - this.player.overSpeed;
		bool flag = (double)num < (double)this.lastSpeed - (double)this.lastSpeed * 0.4;
		if (flag && this.vertControl && this._player.rotation.eulerAngles.x > -2f && this.lastSpeed > 40f && !this.player.isGrinding && !this.ignore && !this.rewindQueued && !this.rewindControl && this.rewind)
		{
			this.rewindQueued = true;
			this.Change("11");
			this.pyramid.SwitchAction(this.zeroOne);
			this.timeSinceFuckUp = 0f;
		}
		else if (this.player.freezeControls && !this.player.isGrinding && !this.rewindCheck)
		{
			if (this.correctRewinds < 5)
			{
				this.correctRewinds++;
				this.rewindCheck = true;
				this.Change("07");
				this.pyramid.SwitchAction(this.zeroTwo);
				this.rewindCheck = true;
			}
			else
			{
				this.rewindCheck = false;
				this.rewindQueued = false;
				this.TurnOff();
				if (this.previous != null)
				{
					this.turnOn(this.previous);
				}
				else
				{
					PhoneInterface.view_controller.SetOpen(false);
				}
			}
		}
		this.lastSpeed = this.tempLastSpeed;
		this.tempLastSpeed = num;
	}

	// Token: 0x0600002F RID: 47 RVA: 0x0000335C File Offset: 0x0000155C
	private IEnumerator CloseMe()
	{
		MonoBehaviour.print("yo");
		yield return new WaitForSeconds(5f);
		this.TurnOff();
		MonoBehaviour.print("gahy");
		if (this.previous != null)
		{
			this.turnOn(this.previous);
		}
		else
		{
			PhoneInterface.view_controller.SetOpen(false);
		}
		yield break;
	}

	// Token: 0x06000030 RID: 48 RVA: 0x00003378 File Offset: 0x00001578
	private void Change(string thing)
	{
		this.TurnOff();
		this.turnOn(this._pyramid.Find(thing));
		PhoneInterface.view_controller.SetOpen(true);
		PhoneController.instance.OnNewMessage(1);
	}

	// Token: 0x06000031 RID: 49 RVA: 0x000033B4 File Offset: 0x000015B4
	private void turnOn(Transform child)
	{
		if (!child)
		{
			Debug.LogWarning("child is null... ");
			return;
		}
		foreach (object obj in child)
		{
			Transform transform = (Transform)obj;
			if (transform.name == "PC" && !PlayerMon.xbox)
			{
				this.turnOn(transform);
			}
			else if (transform.name == "Xbox" && PlayerMon.xbox)
			{
				this.turnOn(transform);
			}
			else if (transform.name != "PC" && transform.name != "Xbox")
			{
				this.turnOn(transform);
			}
		}
		child.gameObject.active = true;
	}

	// Token: 0x06000032 RID: 50 RVA: 0x000034C0 File Offset: 0x000016C0
	private void TurnOffHelper(Transform child)
	{
		foreach (object obj in child)
		{
			Transform child2 = (Transform)obj;
			this.TurnOffHelper(child2);
		}
		if (child.gameObject.active)
		{
			child.gameObject.active = false;
			if (child.parent.name != "08" && child.parent.name != "11" && child.parent.name != "07" && child.parent.name != "15" && child.parent.name != "99" && child.parent.name != "96" && child.parent.name != "95" && child.parent.name != "TextHolder")
			{
				this.previous = child.parent;
			}
		}
	}

	// Token: 0x06000033 RID: 51 RVA: 0x00003624 File Offset: 0x00001824
	public void TurnOff()
	{
		foreach (object obj in this._pyramid)
		{
			Transform child = (Transform)obj;
			this.TurnOffHelper(child);
		}
	}

	// Token: 0x04000020 RID: 32
	private Transform _player;

	// Token: 0x04000021 RID: 33
	private Transform _pyramid;

	// Token: 0x04000022 RID: 34
	private move player;

	// Token: 0x04000023 RID: 35
	private PyramidScript pyramid;

	// Token: 0x04000024 RID: 36
	private global::Action[] zeroOne = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000025 RID: 37
	private global::Action[] zeroTwo = new global::Action[]
	{
		new global::Action(stateEnum.love, 100f, 0f)
	};

	// Token: 0x04000026 RID: 38
	private float tempLastSpeed = 3f;

	// Token: 0x04000027 RID: 39
	private float lastSpeed;

	// Token: 0x04000028 RID: 40
	public bool ignore;

	// Token: 0x04000029 RID: 41
	public Transform previous;

	// Token: 0x0400002A RID: 42
	public static bool xbox;

	// Token: 0x0400002B RID: 43
	public bool rewind;

	// Token: 0x0400002C RID: 44
	public bool rewindZone;

	// Token: 0x0400002D RID: 45
	private bool rewindQueued;

	// Token: 0x0400002E RID: 46
	private bool rewindCheck;

	// Token: 0x0400002F RID: 47
	private float timeSinceFuckUp = 3f;

	// Token: 0x04000030 RID: 48
	private int correctRewinds;

	// Token: 0x04000031 RID: 49
	public bool canMaster;

	// Token: 0x04000032 RID: 50
	private float lengthHeld;

	// Token: 0x04000033 RID: 51
	private float doTheyGetIt;

	// Token: 0x04000034 RID: 52
	private bool probalbyUnderstandsSkating;

	// Token: 0x04000035 RID: 53
	private bool messageUp;

	// Token: 0x04000036 RID: 54
	private int skates;

	// Token: 0x04000037 RID: 55
	public bool notNowBernad;

	// Token: 0x04000038 RID: 56
	private bool rewindControl;

	// Token: 0x04000039 RID: 57
	private bool vertControl;

	// Token: 0x0400003A RID: 58
	public bool jumpReminder = true;

	// Token: 0x0400003B RID: 59
	private float timeInAir;

	// Token: 0x0400003C RID: 60
	private bool jumped;

	// Token: 0x0400003D RID: 61
	private RaycastHit floor;

	// Token: 0x0400003E RID: 62
	private bool jumpUP;

	// Token: 0x0400003F RID: 63
	private float jumpUPCounter;

	// Token: 0x04000040 RID: 64
	private RaycastHit tempWallRay;

	// Token: 0x04000041 RID: 65
	private RaycastHit wallRay;

	// Token: 0x04000042 RID: 66
	public bool wallCheck;

	// Token: 0x04000043 RID: 67
	private bool triggered;
}
