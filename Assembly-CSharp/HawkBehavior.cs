using System;
using UnityEngine;

// Token: 0x02000017 RID: 23
public class HawkBehavior : MonoBehaviour
{
	// Token: 0x17000004 RID: 4
	// (get) Token: 0x0600007B RID: 123 RVA: 0x00005D34 File Offset: 0x00003F34
	public Transform playerRef
	{
		get
		{
			return PhoneInterface.player_trans;
		}
	}

	// Token: 0x0600007C RID: 124 RVA: 0x00005D3C File Offset: 0x00003F3C
	private void Awake()
	{
		this.spawnPoint = (UnityEngine.Object.FindObjectOfType(typeof(SpawnPointScript)) as SpawnPointScript);
		if (!this.myTrainer)
		{
			this.myTrainer = base.GetComponentInChildren<NPCTrainer>();
		}
	}

	// Token: 0x0600007D RID: 125 RVA: 0x00005D80 File Offset: 0x00003F80
	private void Start()
	{
		if (this.myTrainer != null && this.myTrainer.defeated)
		{
			this.canControl = true;
		}
		else
		{
			base.Invoke("CheckNPC", 1f);
		}
	}

	// Token: 0x0600007E RID: 126 RVA: 0x00005DC0 File Offset: 0x00003FC0
	private void CheckNPC()
	{
		if (this.myTrainer != null && this.myTrainer.defeated)
		{
			this.canControl = true;
		}
	}

	// Token: 0x0600007F RID: 127 RVA: 0x00005DF8 File Offset: 0x00003FF8
	private void FixedUpdate()
	{
		if (this.active)
		{
			if (!this.isHeld)
			{
				if (!this.spawnPoint.isRespawning)
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
			else
			{
				this.playerRef.position = this.carryPoint.position;
				this.playerRef.rotation = base.transform.rotation;
			}
		}
	}

	// Token: 0x06000080 RID: 128 RVA: 0x00005EEC File Offset: 0x000040EC
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

	// Token: 0x06000081 RID: 129 RVA: 0x00005F5C File Offset: 0x0000415C
	private void SwoopIn()
	{
		base.transform.Find("interiorHawk").gameObject.SetActiveRecursively(true);
		this.flyAwayCurrent = this.flyAwayMax;
		this.Fly();
		base.transform.position = this.playerRef.position + new Vector3(0f, this.startSwoopDistance, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.startSwoopDistance -= this.startSwoopInc;
		if (this.startSwoopDistance <= this.distanceAbove)
		{
			this.startSwoopDistance = this.maxStartSwoopDistance;
			this.hasSwoopedIn = true;
			this.Screech();
		}
		if (this.myTrainer)
		{
			this.myTrainer.gameObject.active = true;
		}
	}

	// Token: 0x06000082 RID: 130 RVA: 0x00006054 File Offset: 0x00004254
	private void FollowClosely()
	{
		base.transform.position = this.playerRef.position + new Vector3(0f, this.distanceAbove, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.timeFollowed += Time.fixedDeltaTime;
		if (this.timeFollowed >= this.maxTimeFollowed)
		{
			this.Carry();
			this.timeFollowed = 0f;
			this.targetEngaged = true;
			this.hasSwoopedIn = false;
			this.swoopDistance = this.distanceAbove;
		}
	}

	// Token: 0x06000083 RID: 131 RVA: 0x0000610C File Offset: 0x0000430C
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
		base.transform.Find("interiorHawk").gameObject.SetActiveRecursively(false);
		this.active = false;
	}

	// Token: 0x06000084 RID: 132 RVA: 0x000061DC File Offset: 0x000043DC
	private void SwoopDown()
	{
		this.myTrainer.can_challenge = true;
		base.transform.position = this.playerRef.position + new Vector3(0f, this.swoopDistance, 0f);
		base.transform.rotation = Quaternion.Euler(0f, this.playerRef.eulerAngles.y, 0f);
		this.swoopDistance -= this.swoopInc;
		if (this.carryPoint.position.y - this.playerRef.position.y <= 0f)
		{
			this.shadow.gameObject.active = false;
			this.Fly();
			this.swoopDistance = this.distanceAbove;
			this.targetHeld = true;
			this.facingNest = false;
			this.playerRef.rotation = base.transform.rotation;
			this.cameraRef.GetComponent<SoundManager>().StopSound();
			GameObject.Find("main_character").transform.animation.CrossFade("Idle");
			this.playerRef.GetComponent<move>().freezeControls = true;
			this.playerRef.GetComponent<Rigidbody>().isKinematic = true;
			this.originalDamping = this.cameraRef.GetComponent<NewCamera>().damping;
			this.cameraRef.GetComponent<NewCamera>().damping = this.hawkDamping;
			GameObject.Find("SpawnPoint").GetComponent<SpawnPointScript>().canRespawn = false;
			GameObject.Find("HawkBig").GetComponent<BigHawkBehavior>().enabled = true;
		}
	}

	// Token: 0x06000085 RID: 133 RVA: 0x00006384 File Offset: 0x00004584
	private void CarryToNest()
	{
		if (this.canControl)
		{
			this.ControlHawk();
		}
		else if (this.takeOffTime > 0f)
		{
			this.takeOffTime -= Time.fixedDeltaTime;
			base.transform.rotation *= Quaternion.Euler(-50f * Time.fixedDeltaTime, 0f, 0f);
			base.transform.position += base.transform.forward * this.flightSpeed * Time.fixedDeltaTime;
			this.playerRef.position = this.carryPoint.position;
			this.playerRef.rotation = base.transform.rotation;
		}
		else
		{
			if (!this.facingNest)
			{
				this.carryPoint.transform.LookAt(this.dropLocation);
				Quaternion rotation = this.carryPoint.transform.rotation;
				float num = this.rotateAngle;
				float num2 = Vector3.Distance(base.transform.position, this.dropLocation.position);
				if (num2 < this.dropDistance * 5f)
				{
					num *= 3f;
				}
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, rotation, num * Time.fixedDeltaTime);
				float num3 = this.flightSpeed;
				if (num2 <= this.dropDistance * 7f && num2 > 0f)
				{
					num3 *= Mathf.Pow(num2 / (this.dropDistance * 7f), 2f);
				}
				base.transform.position += base.transform.forward * num3 * Time.fixedDeltaTime;
				this.playerRef.position = this.carryPoint.position;
				this.playerRef.rotation = base.transform.rotation;
				this.playerRef.position += new Vector3(this.offsetX, this.offsetY, this.offsetZ);
				if (Quaternion.Angle(base.transform.rotation, rotation) <= this.nestAngle)
				{
					base.transform.rotation = rotation;
					this.playerRef.rotation = base.transform.rotation;
					this.facingNest = true;
				}
			}
			else
			{
				Vector3 position = base.transform.position;
				base.transform.position = Vector3.MoveTowards(base.transform.position, this.dropLocation.position, this.flightSpeed * Time.fixedDeltaTime);
				this.flightVector = base.transform.position - position;
				this.playerRef.transform.position = this.carryPoint.position;
				this.playerRef.position += new Vector3(this.offsetX, this.offsetY, this.offsetZ);
			}
			if (Vector3.Distance(base.transform.position, this.dropLocation.position) <= this.dropDistance)
			{
				base.transform.position = this.dropLocation.position;
				this.Drop();
			}
		}
	}

	// Token: 0x06000086 RID: 134 RVA: 0x000066E8 File Offset: 0x000048E8
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

	// Token: 0x06000087 RID: 135 RVA: 0x00006794 File Offset: 0x00004994
	private void ControlHawk()
	{
		if (this.takeOffTime > 0f)
		{
			this.spd = Mathf.Lerp(this.spd, this.flightSpeed, Time.fixedDeltaTime * 2f);
			this.takeOffTime -= Time.fixedDeltaTime;
			base.transform.rotation *= Quaternion.Euler(-50f * Time.fixedDeltaTime, 0f, 0f);
			base.transform.position += base.transform.forward * this.spd * Time.fixedDeltaTime;
			this.playerRef.position = this.carryPoint.position;
			this.playerRef.rotation = base.transform.rotation;
		}
		else
		{
			Vector3 position = base.transform.position;
			float num = Input.GetAxis("Horizontal");
			num = Mathf.Abs(Mathf.Pow(num, 3f)) * Mathf.Sign(num);
			float num2 = Input.GetAxis("Vertical");
			num2 = Mathf.Abs(Mathf.Pow(num2, 2f)) * Mathf.Sign(num2);
			if (num != 0f)
			{
				if (this.lastLeftRight != 0f && Mathf.Sign(num) != Mathf.Sign(this.lastLeftRight))
				{
					this.lastLeftRight = 0f;
				}
				if (num > this.lastLeftRight)
				{
					this.lastLeftRight += this.incValue;
					num = this.lastLeftRight;
				}
				else if (num < this.lastLeftRight)
				{
					this.lastLeftRight -= this.incValue;
					num = this.lastLeftRight;
				}
			}
			else
			{
				this.lastLeftRight = Mathf.Lerp(this.lastLeftRight, 0f, Time.fixedDeltaTime * 10f);
			}
			if (num2 != 0f)
			{
				if (this.lastUpDown != 0f && Mathf.Sign(num2) != Mathf.Sign(this.lastUpDown))
				{
					this.lastUpDown = 0f;
				}
				if (num2 > this.lastUpDown)
				{
					this.lastUpDown += this.incValue;
					num2 = this.lastUpDown;
				}
				else if (num2 < this.lastUpDown)
				{
					this.lastUpDown -= this.incValue;
					num2 = this.lastUpDown;
				}
			}
			else
			{
				this.lastUpDown = Mathf.Lerp(this.lastUpDown, 0f, Time.fixedDeltaTime * 10f);
			}
			float num3 = base.transform.rotation.eulerAngles.x;
			if (num3 > 180f)
			{
				num3 -= 360f;
			}
			num3 /= 180f;
			num3 = num3 * num3 * Mathf.Sign(num3);
			if (num3 > 0f)
			{
				num3 *= 1.5f;
			}
			this.spd = Mathf.Clamp(this.spd + num3 * 8f, 0f, 25000f);
			float num4;
			if (Application.platform == RuntimePlatform.OSXPlayer)
			{
				num4 = Input.GetAxis("Dive_OSX");
			}
			else
			{
				num4 = Mathf.Abs(Input.GetAxis("Dive_PC"));
			}
			if (num4 <= 0.001f)
			{
				num4 = Input.GetAxis("Dive");
			}
			if (num4 > 0f)
			{
				this.spd = Mathf.Max(Mathf.Lerp(300f, 150f, num4), this.spd * (1f - 0.08f * num4));
			}
			else if (this.spd < 300f)
			{
				this.spd = Mathf.Lerp(this.spd, 300f, 0.35f);
			}
			float num5 = Mathf.Clamp(600f / this.spd, 0.75f, 1f);
			num5 = 1f;
			float num6 = 0f;
			if (Input.GetButton("Rewind"))
			{
				num6 += 1f;
			}
			if (Input.GetButton("UnRewind"))
			{
				num6 -= 1f;
			}
			num6 *= 3f;
			num6 -= num;
			num6 = Mathf.Lerp(this.lastSpin, num6, Time.fixedDeltaTime * 30f);
			if (Mathf.Abs(num6) < 0.01f)
			{
				num6 = 0f;
			}
			this.lastSpin = num6;
			base.transform.rotation *= Quaternion.Euler(num2 * 1f * num5 * this.controlSpeed * Time.fixedDeltaTime, num * 0.9f * num5 * this.controlSpeed * Time.fixedDeltaTime, num6 * 1.1f * this.controlSpeed * Time.fixedDeltaTime);
			this.velocity = base.transform.forward * this.spd;
			Vector3 vector = base.transform.position + this.velocity * Time.fixedDeltaTime;
			RaycastHit raycastHit;
			if (Physics.Linecast(position, vector + base.transform.forward * 3f, out raycastHit) && raycastHit.collider.name != "Player")
			{
				base.transform.position = raycastHit.point - base.transform.forward * 10f;
				this.playerRef.position = this.carryPoint.position;
				this.Drop();
				return;
			}
			if (Input.GetButton("Jump") && Input.GetButton("Skate"))
			{
				this.Drop();
				this.playerRef.rigidbody.velocity = Vector3.ClampMagnitude(this.velocity / 3f, 1000f);
				return;
			}
			base.transform.position = vector;
			if (num == 0f && num2 == 0f && num6 == 0f)
			{
				base.transform.rotation = Quaternion.Slerp(base.transform.rotation, Quaternion.Euler(base.transform.rotation.eulerAngles.x, base.transform.rotation.eulerAngles.y, 0f), this.rotateAngle * Time.fixedDeltaTime);
			}
			if (base.transform.position.y > this.maxY)
			{
				Vector3 position2 = base.transform.position;
				position2.y = Mathf.Lerp(position2.y, this.maxY, Time.fixedDeltaTime * 1f);
				base.transform.position = position2;
				base.transform.rotation *= Quaternion.Euler(UnityEngine.Random.Range(-0.5f, 0.5f) * this.controlSpeed * Time.fixedDeltaTime, UnityEngine.Random.Range(-0.5f, 0.5f) * this.controlSpeed * Time.fixedDeltaTime, UnityEngine.Random.Range(-0.5f, 0.5f) * this.controlSpeed * Time.fixedDeltaTime);
			}
			this.playerRef.position = this.carryPoint.position;
			this.playerRef.rotation = Quaternion.Slerp(this.playerRef.rotation, base.transform.rotation, Time.fixedDeltaTime * 8f);
			this.flightVector = base.transform.position - position;
		}
	}

	// Token: 0x06000088 RID: 136 RVA: 0x00006F4C File Offset: 0x0000514C
	public void Drop()
	{
		this.targetHeld = false;
		this.targetEngaged = false;
		this.facingNest = false;
		this.inBounds = false;
		GameObject gameObject = GameObject.Find("WindSource");
		if (gameObject)
		{
			gameObject.audio.volume = 0f;
		}
		this.flyAway = true;
		this.flyAwayCurrent = this.flyAwayMax;
		this.playerRef.GetComponent<move>().freezeControls = false;
		this.playerRef.GetComponent<Rigidbody>().isKinematic = false;
		this.midStruggle = false;
		this.offsetX = 0f;
		this.offsetY = 0f;
		this.offsetZ = 0f;
		this.cameraRef.GetComponent<NewCamera>().damping = this.originalDamping;
		GameObject.Find("HawkBig").GetComponent<BigHawkBehavior>().enabled = false;
		this.spawnPoint.canRespawn = true;
		this.spawnPoint.ClearSpawns();
		this.Screech();
		if (this.myTrainer)
		{
			if (PhoneMemory.trainer_challenge == this.myTrainer)
			{
				if (PhoneMemory.IsBattlingTrainer(this.myTrainer))
				{
					PhoneController.instance.LoadScreenQuiet(PhoneController.instance.startscreen);
				}
				this.myTrainer.UnChallenge();
			}
			this.myTrainer.gameObject.active = false;
			this.myTrainer.can_challenge = false;
		}
	}

	// Token: 0x06000089 RID: 137 RVA: 0x000070B4 File Offset: 0x000052B4
	private void FlyAway()
	{
		if (this.flyAwayCurrent > 0f)
		{
			this.flyAwayCurrent -= Time.fixedDeltaTime;
			base.transform.position += this.flightVector.normalized * 10f * Time.fixedDeltaTime;
		}
		else
		{
			this.flyAway = false;
			this.Disappear();
		}
	}

	// Token: 0x0600008A RID: 138 RVA: 0x0000712C File Offset: 0x0000532C
	private void Screech()
	{
		AudioSource.PlayClipAtPoint(this.screech, new Vector3(5f, 1f, 2f));
	}

	// Token: 0x0600008B RID: 139 RVA: 0x00007150 File Offset: 0x00005350
	private void Fly()
	{
		this.carry.gameObject.active = false;
		this.fly.gameObject.active = true;
	}

	// Token: 0x0600008C RID: 140 RVA: 0x00007180 File Offset: 0x00005380
	private void Carry()
	{
		this.fly.gameObject.active = false;
		this.carry.gameObject.active = true;
	}

	// Token: 0x040000C9 RID: 201
	public Transform cameraRef;

	// Token: 0x040000CA RID: 202
	public Transform dropLocation;

	// Token: 0x040000CB RID: 203
	public Transform carryPoint;

	// Token: 0x040000CC RID: 204
	public AudioClip screech;

	// Token: 0x040000CD RID: 205
	public Transform fly;

	// Token: 0x040000CE RID: 206
	public Transform carry;

	// Token: 0x040000CF RID: 207
	public Projector shadow;

	// Token: 0x040000D0 RID: 208
	public bool inBounds;

	// Token: 0x040000D1 RID: 209
	private float inBound;

	// Token: 0x040000D2 RID: 210
	public bool targetEngaged;

	// Token: 0x040000D3 RID: 211
	public bool targetHeld;

	// Token: 0x040000D4 RID: 212
	public bool flyAway;

	// Token: 0x040000D5 RID: 213
	public bool facingNest;

	// Token: 0x040000D6 RID: 214
	public bool midStruggle;

	// Token: 0x040000D7 RID: 215
	public bool hasSwoopedIn;

	// Token: 0x040000D8 RID: 216
	public bool canControl;

	// Token: 0x040000D9 RID: 217
	public bool isHeld;

	// Token: 0x040000DA RID: 218
	public new bool active;

	// Token: 0x040000DB RID: 219
	public float timeFollowed;

	// Token: 0x040000DC RID: 220
	public float maxTimeFollowed = 5f;

	// Token: 0x040000DD RID: 221
	public float flightSpeed = 800f;

	// Token: 0x040000DE RID: 222
	public float controlSpeed = 50f;

	// Token: 0x040000DF RID: 223
	public float rotateAngle = 2f;

	// Token: 0x040000E0 RID: 224
	public float hawkDamping = 25f;

	// Token: 0x040000E1 RID: 225
	public float swoopDistance = 30f;

	// Token: 0x040000E2 RID: 226
	public float startSwoopDistance = 150f;

	// Token: 0x040000E3 RID: 227
	public float struggleAmount = 0.5f;

	// Token: 0x040000E4 RID: 228
	public float offsetX;

	// Token: 0x040000E5 RID: 229
	public float offsetY;

	// Token: 0x040000E6 RID: 230
	public float offsetZ;

	// Token: 0x040000E7 RID: 231
	private float takeOffTime = 1f;

	// Token: 0x040000E8 RID: 232
	private float maxTakeOffTime = 1f;

	// Token: 0x040000E9 RID: 233
	private float distanceAbove = 15f;

	// Token: 0x040000EA RID: 234
	private float maxStartSwoopDistance = 150f;

	// Token: 0x040000EB RID: 235
	private float swoopInc = 0.25f;

	// Token: 0x040000EC RID: 236
	private float startSwoopInc = 1f;

	// Token: 0x040000ED RID: 237
	private float dropDistance = 20f;

	// Token: 0x040000EE RID: 238
	private float flyAwayMax = 3f;

	// Token: 0x040000EF RID: 239
	private float flyAwayCurrent;

	// Token: 0x040000F0 RID: 240
	private float originalDamping;

	// Token: 0x040000F1 RID: 241
	private float nestAngle = 0.1f;

	// Token: 0x040000F2 RID: 242
	private float lastUpDown;

	// Token: 0x040000F3 RID: 243
	private float lastLeftRight;

	// Token: 0x040000F4 RID: 244
	private float lastSpin;

	// Token: 0x040000F5 RID: 245
	private float incValue = 0.2f;

	// Token: 0x040000F6 RID: 246
	private Vector3 flightVector = new Vector3(0f, 0f, 0f);

	// Token: 0x040000F7 RID: 247
	private SpawnPointScript spawnPoint;

	// Token: 0x040000F8 RID: 248
	private float maxY = 44000f;

	// Token: 0x040000F9 RID: 249
	public NPCTrainer myTrainer;

	// Token: 0x040000FA RID: 250
	public GameObject tempHawkRend;

	// Token: 0x040000FB RID: 251
	public float spd;

	// Token: 0x040000FC RID: 252
	public Vector3 velocity = Vector3.zero;

	// Token: 0x040000FD RID: 253
	public float saveSpd;
}
