using System;
using UnityEngine;

// Token: 0x02000011 RID: 17
public class tutSpeed : MonoBehaviour
{
	// Token: 0x0600004F RID: 79 RVA: 0x00003F4C File Offset: 0x0000214C
	private void Start()
	{
		base.renderer.enabled = false;
		this.pyramid = GameObject.Find("Pyramid").transform.GetComponent<PyramidScript>();
		this._pyramid = GameObject.Find("TextHolder").transform;
	}

	// Token: 0x06000050 RID: 80 RVA: 0x00003F94 File Offset: 0x00002194
	private void Update()
	{
	}

	// Token: 0x06000051 RID: 81 RVA: 0x00003F98 File Offset: 0x00002198
	private void OnTriggerEnter(Collider collision)
	{
		Transform transform = GameObject.Find("Player").transform;
		float z = transform.InverseTransformDirection(transform.rigidbody.velocity).z;
		if (z < this.speed)
		{
			this.xbox = Input.GetJoystickNames().Length;
			this.TurnOff();
			this.turnOn(this._pyramid.Find(this.slide));
			PhoneInterface.view_controller.SetOpen(true);
			PhoneController.instance.OnNewMessage(1);
			this.pyramid.SwitchAction(this.zeroOne);
			this.nevermind.gameObject.active = true;
		}
		else
		{
			UnityEngine.Object.Destroy(this.nevermind.gameObject);
		}
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x06000052 RID: 82 RVA: 0x00004060 File Offset: 0x00002260
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

	// Token: 0x06000053 RID: 83 RVA: 0x0000415C File Offset: 0x0000235C
	private void TurnOffHelper(Transform child)
	{
		foreach (object obj in child)
		{
			Transform child2 = (Transform)obj;
			this.TurnOffHelper(child2);
		}
		child.gameObject.active = false;
	}

	// Token: 0x06000054 RID: 84 RVA: 0x000041D4 File Offset: 0x000023D4
	private void TurnOff()
	{
		foreach (object obj in this._pyramid)
		{
			Transform child = (Transform)obj;
			this.TurnOffHelper(child);
		}
	}

	// Token: 0x04000071 RID: 113
	private PyramidScript pyramid;

	// Token: 0x04000072 RID: 114
	private Transform _pyramid;

	// Token: 0x04000073 RID: 115
	private global::Action[] zeroOne = new global::Action[]
	{
		new global::Action(stateEnum.frown, 100f, 0f)
	};

	// Token: 0x04000074 RID: 116
	private global::Action[] zeroTwo = new global::Action[]
	{
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000075 RID: 117
	private global::Action[] zeroSix = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000076 RID: 118
	private global::Action[] zeroThree = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000077 RID: 119
	private global::Action[] zeroFour = new global::Action[]
	{
		new global::Action(stateEnum.alert, 1.2f, 0f),
		new global::Action(stateEnum.talk, 100f, 0f)
	};

	// Token: 0x04000078 RID: 120
	private global::Action[] zeroEight = new global::Action[]
	{
		new global::Action(stateEnum.excited, 100f, 0f)
	};

	// Token: 0x04000079 RID: 121
	private global::Action[] zeroNine = new global::Action[]
	{
		new global::Action(stateEnum.alert, 100f, 0f)
	};

	// Token: 0x0400007A RID: 122
	public int xbox;

	// Token: 0x0400007B RID: 123
	public string slide;

	// Token: 0x0400007C RID: 124
	public float speed;

	// Token: 0x0400007D RID: 125
	public Transform nevermind;
}
