using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200000B RID: 11
public class WallRideRoom : MonoBehaviour
{
	// Token: 0x17000003 RID: 3
	// (get) Token: 0x06000035 RID: 53 RVA: 0x0000369C File Offset: 0x0000189C
	private bool xbox
	{
		get
		{
			return PlayerMon.xbox;
		}
	}

	// Token: 0x06000036 RID: 54 RVA: 0x000036A4 File Offset: 0x000018A4
	private void Start()
	{
		this.player = GameObject.Find("Player").GetComponent<move>();
		this.player.canWallRide = false;
		this.barScale = this.bar.localScale.x;
		this.bar.localScale = new Vector3(0f, this.bar.localScale.y, this.bar.localScale.z);
		this._pyramid = GameObject.Find("TextHolder").transform;
		base.renderer.enabled = false;
	}

	// Token: 0x06000037 RID: 55 RVA: 0x00003748 File Offset: 0x00001948
	private void Update()
	{
	}

	// Token: 0x06000038 RID: 56 RVA: 0x0000374C File Offset: 0x0000194C
	private void OnTriggerEnter(Collider other)
	{
		this.player.Stop();
		this.player.canWallRide = true;
		this.TurnOff();
		this.turnOn(this._pyramid.Find("09").transform);
		PhoneInterface.view_controller.SetOpen(true);
		PhoneController.instance.OnNewMessage(1);
		base.StartCoroutine("Wait");
	}

	// Token: 0x06000039 RID: 57 RVA: 0x000037B4 File Offset: 0x000019B4
	private IEnumerator Wait()
	{
		while (this.bar.localScale.x < this.barScale)
		{
			this.bar.localScale = new Vector3(this.bar.localScale.x + 0.1f, this.bar.localScale.y, this.bar.localScale.z);
			yield return new WaitForSeconds(0.05f);
		}
		this.TurnOff();
		this.turnOn(this._pyramid.Find("10").transform);
		PhoneInterface.view_controller.SetOpen(true);
		PhoneController.instance.OnNewMessage(1);
		UnityEngine.Object.Destroy(base.gameObject);
		yield break;
	}

	// Token: 0x0600003A RID: 58 RVA: 0x000037D0 File Offset: 0x000019D0
	private void turnOn(Transform child)
	{
		foreach (object obj in child)
		{
			Transform transform = (Transform)obj;
			if (transform.name == "PC" && !this.xbox)
			{
				this.turnOn(transform);
			}
			else if (transform.name == "Xbox" && !this.xbox)
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

	// Token: 0x0600003B RID: 59 RVA: 0x000038C8 File Offset: 0x00001AC8
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
		}
	}

	// Token: 0x0600003C RID: 60 RVA: 0x00003950 File Offset: 0x00001B50
	private void TurnOff()
	{
		foreach (object obj in this._pyramid)
		{
			Transform child = (Transform)obj;
			this.TurnOffHelper(child);
		}
	}

	// Token: 0x04000044 RID: 68
	private move player;

	// Token: 0x04000045 RID: 69
	public Transform bar;

	// Token: 0x04000046 RID: 70
	private float barScale;

	// Token: 0x04000047 RID: 71
	private Transform _pyramid;
}
