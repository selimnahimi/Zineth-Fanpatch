using System;
using UnityEngine;

// Token: 0x02000013 RID: 19
public class tutTriggers1 : MonoBehaviour
{
	// Token: 0x0600005D RID: 93 RVA: 0x000048AC File Offset: 0x00002AAC
	private void Start()
	{
		base.renderer.enabled = false;
		this.pyramid = GameObject.Find("Pyramid").transform.GetComponent<PyramidScript>();
		this._pyramid = GameObject.Find("TextHolder").transform;
		this.playerMon = GameObject.Find("TutObject").GetComponent<PlayerMon>();
		this.player = GameObject.Find("Player").GetComponent<move>();
	}

	// Token: 0x0600005E RID: 94 RVA: 0x00004920 File Offset: 0x00002B20
	private void Update()
	{
	}

	// Token: 0x0600005F RID: 95 RVA: 0x00004924 File Offset: 0x00002B24
	private void OnTriggerStay(Collider collision)
	{
		this.xbox = Input.GetJoystickNames().Length;
		if (this.player.wallRiding)
		{
			this.TurnOff();
			this.turnOn(this._pyramid.Find(base.transform.name));
			PhoneInterface.view_controller.SetOpen(true);
			PhoneController.instance.OnNewMessage(1);
			if (base.transform.name == "01")
			{
				this.pyramid.SwitchAction(this.zeroOne);
			}
			else if (base.transform.name == "02")
			{
				this.pyramid.SwitchAction(this.zeroTwo);
			}
			else if (base.transform.name == "03")
			{
				this.pyramid.SwitchAction(this.zeroThree);
			}
			else if (base.transform.name == "04")
			{
				this.pyramid.SwitchAction(this.zeroFour);
			}
			else if (base.transform.name == "06")
			{
				this.pyramid.SwitchAction(this.zeroSix);
			}
			else if (base.transform.name == "18")
			{
				this.pyramid.SwitchAction(this.zeroNine);
			}
			else if (base.transform.name == "05")
			{
				this.playerMon.rewind = true;
			}
			else if (base.transform.name == "97")
			{
				this.pyramid.SwitchAction(this.zeroEight);
			}
			else if (base.transform.name == "08")
			{
				this.pyramid.SwitchAction(this.zeroEight);
				this.playerMon.rewind = true;
			}
			else
			{
				this.pyramid.SwitchAction(this.zeroOne);
			}
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x06000060 RID: 96 RVA: 0x00004B5C File Offset: 0x00002D5C
	private void turnOn(Transform child)
	{
		foreach (object obj in child)
		{
			Transform transform = (Transform)obj;
			if (transform.name == "PC" && this.xbox == 0)
			{
				this.turnOn(transform);
			}
			else if (transform.name == "Xbox" && this.xbox > 0)
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

	// Token: 0x06000061 RID: 97 RVA: 0x00004C58 File Offset: 0x00002E58
	private void TurnOffHelper(Transform child)
	{
		foreach (object obj in child)
		{
			Transform child2 = (Transform)obj;
			this.TurnOffHelper(child2);
		}
		child.gameObject.active = false;
	}

	// Token: 0x06000062 RID: 98 RVA: 0x00004CD0 File Offset: 0x00002ED0
	private void TurnOff()
	{
		foreach (object obj in this._pyramid)
		{
			Transform child = (Transform)obj;
			this.TurnOffHelper(child);
		}
	}

	// Token: 0x04000089 RID: 137
	private PyramidScript pyramid;

	// Token: 0x0400008A RID: 138
	private Transform _pyramid;

	// Token: 0x0400008B RID: 139
	private PlayerMon playerMon;

	// Token: 0x0400008C RID: 140
	private move player;

	// Token: 0x0400008D RID: 141
	private global::Action[] zeroOne = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x0400008E RID: 142
	private global::Action[] zeroTwo = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x0400008F RID: 143
	private global::Action[] zeroSix = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000090 RID: 144
	private global::Action[] zeroThree = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000091 RID: 145
	private global::Action[] zeroFour = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000092 RID: 146
	private global::Action[] zeroEight = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000093 RID: 147
	private global::Action[] zeroNine = new global::Action[]
	{
		new global::Action(stateEnum.alert, 100f, 0f)
	};

	// Token: 0x04000094 RID: 148
	public int xbox;
}
