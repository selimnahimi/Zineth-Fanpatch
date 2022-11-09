using System;
using UnityEngine;

// Token: 0x02000012 RID: 18
public class tutTriggers : MonoBehaviour
{
	// Token: 0x06000056 RID: 86 RVA: 0x00004358 File Offset: 0x00002558
	private void Start()
	{
		base.renderer.enabled = false;
		this.pyramid = GameObject.Find("Pyramid").transform.GetComponent<PyramidScript>();
		this._pyramid = GameObject.Find("TextHolder").transform;
		this.playerMon = GameObject.Find("TutObject").GetComponent<PlayerMon>();
	}

	// Token: 0x06000057 RID: 87 RVA: 0x000043B8 File Offset: 0x000025B8
	private void Update()
	{
	}

	// Token: 0x06000058 RID: 88 RVA: 0x000043BC File Offset: 0x000025BC
	private void OnTriggerEnter(Collider collision)
	{
		this.xbox = Input.GetJoystickNames().Length;
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

	// Token: 0x06000059 RID: 89 RVA: 0x000045B4 File Offset: 0x000027B4
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

	// Token: 0x0600005A RID: 90 RVA: 0x000046B0 File Offset: 0x000028B0
	private void TurnOffHelper(Transform child)
	{
		foreach (object obj in child)
		{
			Transform child2 = (Transform)obj;
			this.TurnOffHelper(child2);
		}
		child.gameObject.active = false;
	}

	// Token: 0x0600005B RID: 91 RVA: 0x00004728 File Offset: 0x00002928
	private void TurnOff()
	{
		foreach (object obj in this._pyramid)
		{
			Transform child = (Transform)obj;
			this.TurnOffHelper(child);
		}
	}

	// Token: 0x0400007E RID: 126
	private PyramidScript pyramid;

	// Token: 0x0400007F RID: 127
	private Transform _pyramid;

	// Token: 0x04000080 RID: 128
	private PlayerMon playerMon;

	// Token: 0x04000081 RID: 129
	private global::Action[] zeroOne = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000082 RID: 130
	private global::Action[] zeroTwo = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000083 RID: 131
	private global::Action[] zeroSix = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000084 RID: 132
	private global::Action[] zeroThree = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000085 RID: 133
	private global::Action[] zeroFour = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000086 RID: 134
	private global::Action[] zeroEight = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000087 RID: 135
	private global::Action[] zeroNine = new global::Action[]
	{
		new global::Action(stateEnum.alert, 100f, 0f)
	};

	// Token: 0x04000088 RID: 136
	public int xbox;
}
