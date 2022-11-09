using System;
using UnityEngine;

// Token: 0x02000016 RID: 22
public class BigHawkBehavior : MonoBehaviour
{
	// Token: 0x0600006D RID: 109 RVA: 0x000051D0 File Offset: 0x000033D0
	private void FixedUpdate()
	{
		if (this.active && !GameObject.Find("SpawnPoint").GetComponent<SpawnPointScript>().isRespawning)
		{
			if (!this.flyAway)
			{
				if (!this.targetHeld)
				{
					if (this.InBounds() && !this.targetEngaged)
					{
						if (!this.hasSwoopedIn)
						{
							this.SwoopIn();
						}
						else
						{
							this.FollowClosely();
						}
					}
					else if (!this.targetEngaged)
					{
						this.timeFollowed = 0f;
						this.FlyAway();
					}
					else
					{
						this.SwoopDown();
					}
				}
				else
				{
					this.CarryToNest();
					this.Struggle();
				}
			}
			else
			{
				this.FlyAway();
			}
		}
	}

	// Token: 0x0600006E RID: 110 RVA: 0x00005294 File Offset: 0x00003494
	private bool InBounds()
	{
		if (!this.inBounds && (double)this.inBound < 0.1)
		{
			this.inBound += Time.deltaTime;
			return true;
		}
		if (!this.inBounds && (double)this.inBound >= 0.1)
		{
			return false;
		}
		this.inBound = 0f;
		return true;
	}

	// Token: 0x0600006F RID: 111 RVA: 0x00005304 File Offset: 0x00003504
	private void SwoopIn()
	{
		base.transform.Find("interiorHawk").gameObject.SetActiveRecursively(true);
		this.Fly();
		base.transform.position = this.playerRef.position + new Vector3(0f, this.startSwoopDistance, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.startSwoopDistance -= this.startSwoopInc;
		if (this.carryPoint.position.y - this.playerRef.position.y <= this.distanceAbove)
		{
			this.startSwoopDistance = this.maxStartSwoopDistance;
			this.hasSwoopedIn = true;
			this.Screech();
		}
	}

	// Token: 0x06000070 RID: 112 RVA: 0x000053F0 File Offset: 0x000035F0
	private void FollowClosely()
	{
		base.transform.position = this.playerRef.position + new Vector3(0f, this.distanceAbove, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.timeFollowed += Time.fixedDeltaTime;
		if (this.timeFollowed >= this.maxTimeFollowed)
		{
			this.Carry();
			this.swoopDistance = this.distanceAbove;
			this.timeFollowed = 0f;
			this.targetEngaged = true;
			this.hasSwoopedIn = false;
		}
	}

	// Token: 0x06000071 RID: 113 RVA: 0x000054A8 File Offset: 0x000036A8
	private void Disappear()
	{
		this.Fly();
		base.transform.position = new Vector3(0f, -10000f, 0f);
		this.targetEngaged = false;
		this.targetHeld = false;
		this.flyAway = false;
		this.facingNest = false;
		this.midStruggle = false;
		this.hasSwoopedIn = false;
		this.timeFollowed = 0f;
		this.swoopDistance = this.distanceAbove;
		this.startSwoopDistance = this.maxStartSwoopDistance;
		this.takeOffTime = this.maxTakeOffTime;
		this.offsetX = 0f;
		this.offsetY = 0f;
		this.offsetZ = 0f;
		this.active = false;
		base.transform.Find("interiorHawk").gameObject.SetActiveRecursively(false);
	}

	// Token: 0x06000072 RID: 114 RVA: 0x00005578 File Offset: 0x00003778
	private void SwoopDown()
	{
		base.transform.position = this.playerRef.position + new Vector3(0f, this.swoopDistance, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.swoopDistance -= this.swoopInc;
		if (this.swoopDistance <= 0f)
		{
			this.Fly();
			this.swoopDistance = this.distanceAbove;
			this.targetHeld = true;
			this.facingNest = false;
			this.playerRef.rotation = base.transform.rotation;
			this.playerRef.GetComponent<HawkBehavior>().isHeld = true;
			GameObject.Find("SpawnPoint").GetComponent<SpawnPointScript>().canRespawn = false;
		}
	}

	// Token: 0x06000073 RID: 115 RVA: 0x00005664 File Offset: 0x00003864
	private void CarryToNest()
	{
		if (this.takeOffTime > 0f)
		{
			this.takeOffTime -= Time.fixedDeltaTime;
			base.transform.rotation *= Quaternion.Euler(-50f * Time.fixedDeltaTime, 0f, 0f);
			base.transform.position += base.transform.forward * this.flightSpeed * Time.fixedDeltaTime;
			this.playerRef.position = this.carryPoint.position;
			this.playerRef.rotation = base.transform.rotation;
		}
		else
		{
			float num = this.flightSpeed;
			if (!this.facingNest)
			{
				this.carryPoint.transform.LookAt(this.dropLocation);
				Quaternion rotation = this.carryPoint.transform.rotation;
				if (Vector3.Distance(base.transform.position, this.dropLocation.position) < 10000f)
				{
					num *= Vector3.Distance(base.transform.position, this.dropLocation.position) / 10000f;
					num = Mathf.Clamp(num, 2000f, this.flightSpeed);
				}
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, rotation, this.rotateAngle * Time.fixedDeltaTime);
				base.transform.position += base.transform.forward * num * Time.fixedDeltaTime;
				this.playerRef.position = this.carryPoint.position;
				this.playerRef.rotation = base.transform.rotation;
				this.playerRef.position += new Vector3(this.offsetX, this.offsetY, this.offsetZ);
				if (Quaternion.Angle(base.transform.rotation, rotation) <= this.nestAngle)
				{
					base.transform.rotation = rotation;
					this.playerRef.rotation = base.transform.rotation;
					this.facingNest = true;
				}
				if (Vector3.Distance(base.transform.position, this.dropLocation.position) <= this.dropDistance)
				{
					this.Drop();
				}
			}
			else
			{
				Vector3 position = base.transform.position;
				if (Vector3.Distance(base.transform.position, this.dropLocation.position) < 10000f)
				{
					num *= Vector3.Distance(base.transform.position, this.dropLocation.position) / 10000f;
					num = Mathf.Clamp(num, 2000f, this.flightSpeed);
				}
				base.transform.position = Vector3.MoveTowards(base.transform.position, this.dropLocation.position, num * Time.fixedDeltaTime);
				this.flightVector = base.transform.position - position;
				this.playerRef.transform.position = this.carryPoint.position;
				this.playerRef.position += new Vector3(this.offsetX, this.offsetY, this.offsetZ);
				if (Vector3.Distance(base.transform.position, this.dropLocation.position) <= this.dropDistance)
				{
					this.Drop();
				}
			}
		}
	}

	// Token: 0x06000074 RID: 116 RVA: 0x00005A08 File Offset: 0x00003C08
	private void Struggle()
	{
		if (!this.midStruggle && !this.canControl)
		{
			if (Input.anyKeyDown)
			{
				this.midStruggle = true;
				this.offsetX = UnityEngine.Random.Range(-this.struggleAmount, this.struggleAmount);
				this.offsetY = UnityEngine.Random.Range(-this.struggleAmount, this.struggleAmount);
				this.offsetZ = UnityEngine.Random.Range(-this.struggleAmount, this.struggleAmount);
			}
		}
		else
		{
			this.midStruggle = false;
			this.offsetX = 0f;
			this.offsetY = 0f;
			this.offsetZ = 0f;
		}
	}

	// Token: 0x06000075 RID: 117 RVA: 0x00005AB4 File Offset: 0x00003CB4
	private void Drop()
	{
		MonoBehaviour.print("hey dogs");
		this.targetHeld = false;
		this.targetEngaged = false;
		this.facingNest = false;
		this.inBounds = false;
		this.flyAway = true;
		this.flyAwayCurrent = this.flyAwayMax;
		this.midStruggle = false;
		this.offsetX = 0f;
		this.offsetY = 0f;
		this.offsetZ = 0f;
		this.playerRef.GetComponent<HawkBehavior>().isHeld = false;
		this.Screech();
		MonoBehaviour.print("hey dogs");
	}

	// Token: 0x06000076 RID: 118 RVA: 0x00005B44 File Offset: 0x00003D44
	private void FlyAway()
	{
		if (this.flyAwayCurrent > 0f)
		{
			this.flyAwayCurrent -= Time.fixedDeltaTime;
			base.transform.position += this.flightVector;
		}
		else
		{
			this.flyAway = false;
			this.Disappear();
		}
	}

	// Token: 0x06000077 RID: 119 RVA: 0x00005BA4 File Offset: 0x00003DA4
	private void Screech()
	{
		AudioSource.PlayClipAtPoint(this.screech, new Vector3(5f, 1f, 2f));
	}

	// Token: 0x06000078 RID: 120 RVA: 0x00005BC8 File Offset: 0x00003DC8
	private void Fly()
	{
		this.carry.gameObject.active = false;
		this.fly.gameObject.active = true;
	}

	// Token: 0x06000079 RID: 121 RVA: 0x00005BF8 File Offset: 0x00003DF8
	private void Carry()
	{
		this.fly.gameObject.active = false;
		this.carry.gameObject.active = true;
	}

	// Token: 0x040000A0 RID: 160
	public Transform playerRef;

	// Token: 0x040000A1 RID: 161
	public Transform cameraRef;

	// Token: 0x040000A2 RID: 162
	public Transform dropLocation;

	// Token: 0x040000A3 RID: 163
	public Transform carryPoint;

	// Token: 0x040000A4 RID: 164
	public AudioClip screech;

	// Token: 0x040000A5 RID: 165
	public Transform fly;

	// Token: 0x040000A6 RID: 166
	public Transform carry;

	// Token: 0x040000A7 RID: 167
	public bool inBounds;

	// Token: 0x040000A8 RID: 168
	private float inBound;

	// Token: 0x040000A9 RID: 169
	public bool targetEngaged;

	// Token: 0x040000AA RID: 170
	public bool targetHeld;

	// Token: 0x040000AB RID: 171
	public bool flyAway;

	// Token: 0x040000AC RID: 172
	public bool facingNest;

	// Token: 0x040000AD RID: 173
	public bool midStruggle;

	// Token: 0x040000AE RID: 174
	public bool hasSwoopedIn;

	// Token: 0x040000AF RID: 175
	public bool canControl;

	// Token: 0x040000B0 RID: 176
	public new bool active;

	// Token: 0x040000B1 RID: 177
	public float timeFollowed;

	// Token: 0x040000B2 RID: 178
	public float maxTimeFollowed = 5f;

	// Token: 0x040000B3 RID: 179
	public float flightSpeed = 800f;

	// Token: 0x040000B4 RID: 180
	public float controlSpeed = 50f;

	// Token: 0x040000B5 RID: 181
	public float rotateAngle = 2f;

	// Token: 0x040000B6 RID: 182
	public float hawkDamping = 25f;

	// Token: 0x040000B7 RID: 183
	public float swoopDistance = 30f;

	// Token: 0x040000B8 RID: 184
	public float startSwoopDistance = 150f;

	// Token: 0x040000B9 RID: 185
	public float struggleAmount = 0.5f;

	// Token: 0x040000BA RID: 186
	public float offsetX;

	// Token: 0x040000BB RID: 187
	public float offsetY;

	// Token: 0x040000BC RID: 188
	public float offsetZ;

	// Token: 0x040000BD RID: 189
	private float takeOffTime = 1f;

	// Token: 0x040000BE RID: 190
	private float maxTakeOffTime = 1f;

	// Token: 0x040000BF RID: 191
	private float distanceAbove = 15f;

	// Token: 0x040000C0 RID: 192
	private float maxStartSwoopDistance = 150f;

	// Token: 0x040000C1 RID: 193
	private float swoopInc = 0.25f;

	// Token: 0x040000C2 RID: 194
	private float startSwoopInc = 1f;

	// Token: 0x040000C3 RID: 195
	private float dropDistance = 300f;

	// Token: 0x040000C4 RID: 196
	private float flyAwayMax = 3f;

	// Token: 0x040000C5 RID: 197
	private float flyAwayCurrent;

	// Token: 0x040000C6 RID: 198
	private float originalDamping;

	// Token: 0x040000C7 RID: 199
	private float nestAngle = 0.1f;

	// Token: 0x040000C8 RID: 200
	private Vector3 flightVector = new Vector3(0f, 0f, 0f);
}
