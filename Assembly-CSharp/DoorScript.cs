using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200002F RID: 47
public class DoorScript : MonoBehaviour
{
	// Token: 0x06000158 RID: 344 RVA: 0x0000A2E8 File Offset: 0x000084E8
	private void Start()
	{
		this.player = GameObject.Find("Player").transform;
	}

	// Token: 0x06000159 RID: 345 RVA: 0x0000A300 File Offset: 0x00008500
	private void Update()
	{
	}

	// Token: 0x0600015A RID: 346 RVA: 0x0000A304 File Offset: 0x00008504
	private void Open2()
	{
		MonoBehaviour.print("sup");
		base.StartCoroutine("Open");
	}

	// Token: 0x0600015B RID: 347 RVA: 0x0000A31C File Offset: 0x0000851C
	private void OnTriggerEnter(Collider other)
	{
		if (this.wallJump)
		{
			base.StartCoroutine("WallJump");
		}
		else
		{
			base.StartCoroutine("Open");
		}
	}

	// Token: 0x0600015C RID: 348 RVA: 0x0000A354 File Offset: 0x00008554
	private IEnumerator Open()
	{
		while (this.doorIncrement < 25)
		{
			this.leftDoor.position += this.leftDoor.right / 4f;
			this.rightDoor.position += this.leftDoor.right / -4f;
			this.doorIncrement++;
			yield return null;
		}
		while (this.doorIncrement > 21)
		{
			this.leftDoor.position -= this.leftDoor.right / 4f;
			this.rightDoor.position -= this.leftDoor.right / -4f;
			this.doorIncrement--;
			yield return null;
		}
		while (this.doorIncrement < 25)
		{
			this.leftDoor.position += this.leftDoor.right / 4f;
			this.rightDoor.position += this.leftDoor.right / -4f;
			this.doorIncrement++;
			yield return null;
		}
		yield break;
	}

	// Token: 0x0600015D RID: 349 RVA: 0x0000A370 File Offset: 0x00008570
	private IEnumerator WallJump()
	{
		while (this.timesJumped < 6)
		{
			bool temp = this.player.GetComponent<move>().wallRiding;
			if (temp != this.wallJumped)
			{
				this.wallJumped = temp;
				this.timesJumped++;
			}
			yield return null;
		}
		base.StartCoroutine("Open");
		yield break;
	}

	// Token: 0x040001B2 RID: 434
	public Transform leftDoor;

	// Token: 0x040001B3 RID: 435
	public Transform rightDoor;

	// Token: 0x040001B4 RID: 436
	private int doorIncrement;

	// Token: 0x040001B5 RID: 437
	private Transform player;

	// Token: 0x040001B6 RID: 438
	public bool wallJump;

	// Token: 0x040001B7 RID: 439
	private int timesJumped;

	// Token: 0x040001B8 RID: 440
	private bool wallJumped;
}
