using System;
using System.Collections;
using UnityEngine;

// Token: 0x02000010 RID: 16
public class PyramidScript : MonoBehaviour
{
	// Token: 0x06000049 RID: 73 RVA: 0x00003B6C File Offset: 0x00001D6C
	public void SwitchAction(global::Action[] newAction)
	{
		this.queuedAction = newAction;
		this.queuedIndex = 0;
		this.SwitchAnimation(this.queuedAction[this.queuedIndex].mood);
		this.timeRemaining = this.queuedAction[this.queuedIndex].length;
	}

	// Token: 0x0600004A RID: 74 RVA: 0x00003BB8 File Offset: 0x00001DB8
	public void SwitchAnimation(stateEnum newState)
	{
		this.state = newState;
		this.animationCounter = 0;
		if (this.state == stateEnum.alert)
		{
			this.counter = 0;
		}
		else if (this.state == stateEnum.blink)
		{
			this.counter = 1;
		}
		else if (this.state == stateEnum.excited)
		{
			this.counter = 2;
		}
		else if (this.state == stateEnum.frown)
		{
			this.counter = 3;
		}
		else if (this.state == stateEnum.happy)
		{
			this.counter = 4;
		}
		else if (this.state == stateEnum.love)
		{
			this.counter = 5;
		}
		else if (this.state == stateEnum.smile)
		{
			this.counter = 6;
		}
		else if (this.state == stateEnum.talk)
		{
			this.counter = 7;
		}
	}

	// Token: 0x0600004B RID: 75 RVA: 0x00003C90 File Offset: 0x00001E90
	public void Start()
	{
		this.anis = new Texture2D[8][];
		this.anis[0] = this.alertSlides;
		this.anis[1] = this.blinkSlides;
		this.anis[2] = this.excitedSlides;
		this.anis[3] = this.frownSlides;
		this.anis[4] = this.happySlides;
		this.anis[5] = this.lovesSlides;
		this.anis[6] = this.smileSlides;
		this.anis[7] = this.talkSlides;
		this.pos = new Vector3[8][];
		this.pos[0] = this.alertPos;
		this.pos[1] = this.blinkPos;
		this.pos[2] = this.excitedPos;
		this.pos[3] = this.frownPos;
		this.pos[4] = this.happyPos;
		this.pos[5] = this.lovesPos;
		this.pos[6] = this.smilePos;
		this.pos[7] = this.talkPos;
		base.StartCoroutine("Animate");
		global::Action[] array = new global::Action[]
		{
			new global::Action(stateEnum.alert, 2.3f, 0f),
			new global::Action(stateEnum.love, 4.3f, 0.4f)
		};
	}

	// Token: 0x0600004C RID: 76 RVA: 0x00003DD0 File Offset: 0x00001FD0
	public void Update()
	{
		this.offset += Time.deltaTime;
		this.eye.renderer.material.SetTextureOffset("_MainTex", new Vector2(this.offset, 0f));
	}

	// Token: 0x0600004D RID: 77 RVA: 0x00003E1C File Offset: 0x0000201C
	public IEnumerator Animate()
	{
		for (;;)
		{
			float pauseTime = 0f;
			if (this.queuedAction != null)
			{
				base.renderer.material.SetTexture("_MainTex", this.anis[this.counter][this.animationCounter]);
				this.eye.localPosition = this.pos[this.counter][this.animationCounter];
				this.animationCounter++;
				if (this.animationCounter >= this.anis[this.counter].Length)
				{
					pauseTime += this.queuedAction[this.queuedIndex].pause;
					this.animationCounter = 0;
				}
				this.timeRemaining -= this.animationSpeed;
				if (this.timeRemaining < 0f)
				{
					this.queuedIndex++;
					if (this.queuedIndex >= this.queuedAction.Length)
					{
						this.queuedIndex = 0;
					}
					this.SwitchAnimation(this.queuedAction[this.queuedIndex].mood);
					this.timeRemaining = this.queuedAction[this.queuedIndex].length;
				}
			}
			yield return new WaitForSeconds(this.animationSpeed + pauseTime);
		}
		yield break;
	}

	// Token: 0x04000056 RID: 86
	public stateEnum state;

	// Token: 0x04000057 RID: 87
	public int counter = 3;

	// Token: 0x04000058 RID: 88
	public float animationSpeed = 0.1f;

	// Token: 0x04000059 RID: 89
	private int animationCounter = 1;

	// Token: 0x0400005A RID: 90
	private global::Action[] queuedAction;

	// Token: 0x0400005B RID: 91
	private int queuedIndex;

	// Token: 0x0400005C RID: 92
	private float offset;

	// Token: 0x0400005D RID: 93
	private float timeRemaining;

	// Token: 0x0400005E RID: 94
	public Texture2D[] alertSlides = new Texture2D[0];

	// Token: 0x0400005F RID: 95
	public Texture2D[] blinkSlides = new Texture2D[0];

	// Token: 0x04000060 RID: 96
	public Texture2D[] excitedSlides = new Texture2D[0];

	// Token: 0x04000061 RID: 97
	public Texture2D[] frownSlides = new Texture2D[0];

	// Token: 0x04000062 RID: 98
	public Texture2D[] happySlides = new Texture2D[0];

	// Token: 0x04000063 RID: 99
	public Texture2D[] lovesSlides = new Texture2D[0];

	// Token: 0x04000064 RID: 100
	public Texture2D[] smileSlides = new Texture2D[0];

	// Token: 0x04000065 RID: 101
	public Texture2D[] talkSlides = new Texture2D[0];

	// Token: 0x04000066 RID: 102
	public Texture2D[][] anis;

	// Token: 0x04000067 RID: 103
	public Transform eye;

	// Token: 0x04000068 RID: 104
	public Vector3[] alertPos = new Vector3[0];

	// Token: 0x04000069 RID: 105
	public Vector3[] blinkPos = new Vector3[0];

	// Token: 0x0400006A RID: 106
	public Vector3[] excitedPos = new Vector3[0];

	// Token: 0x0400006B RID: 107
	public Vector3[] frownPos = new Vector3[0];

	// Token: 0x0400006C RID: 108
	public Vector3[] happyPos = new Vector3[0];

	// Token: 0x0400006D RID: 109
	public Vector3[] lovesPos = new Vector3[0];

	// Token: 0x0400006E RID: 110
	public Vector3[] smilePos = new Vector3[0];

	// Token: 0x0400006F RID: 111
	public Vector3[] talkPos = new Vector3[0];

	// Token: 0x04000070 RID: 112
	public Vector3[][] pos;
}
