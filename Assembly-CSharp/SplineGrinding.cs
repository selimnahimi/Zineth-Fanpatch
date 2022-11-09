using System;
using UnityEngine;

// Token: 0x020000C1 RID: 193
public class SplineGrinding : MonoBehaviour
{
	// Token: 0x170000EE RID: 238
	// (get) Token: 0x0600080E RID: 2062 RVA: 0x000361E8 File Offset: 0x000343E8
	public static SplineGrinding instance
	{
		get
		{
			if (!SplineGrinding._instance)
			{
				SplineGrinding._instance = (UnityEngine.Object.FindObjectOfType(typeof(SplineGrinding)) as SplineGrinding);
			}
			return SplineGrinding._instance;
		}
	}

	// Token: 0x170000EF RID: 239
	// (get) Token: 0x0600080F RID: 2063 RVA: 0x00036218 File Offset: 0x00034418
	private move move_ref
	{
		get
		{
			return PhoneInterface.player_move;
		}
	}

	// Token: 0x06000810 RID: 2064 RVA: 0x00036220 File Offset: 0x00034420
	private void Awake()
	{
		this.RefreshRails();
		this.hawkBehavior = PhoneInterface.hawk;
		this.grindPoint = GameObject.Find("GrindPoint");
	}

	// Token: 0x06000811 RID: 2065 RVA: 0x00036244 File Offset: 0x00034444
	public void RefreshRails()
	{
		this.railObjects = GameObject.FindGameObjectsWithTag("Rail");
	}

	// Token: 0x06000812 RID: 2066 RVA: 0x00036258 File Offset: 0x00034458
	private void CreateBoundingBox(GameObject obj)
	{
		Vector3 position = obj.GetComponent<Spline>().SplineNodeTransforms[0].position;
		float num = position.x;
		float num2 = position.x;
		float num3 = position.y;
		float num4 = position.y;
		float num5 = position.z;
		float num6 = position.z;
		Transform[] splineNodeTransforms = obj.GetComponent<Spline>().SplineNodeTransforms;
		foreach (Transform transform in splineNodeTransforms)
		{
			Vector3 position2 = transform.position;
			if (position2.x < num)
			{
				num = position2.x;
			}
			else if (position2.x > num2)
			{
				num2 = position2.x;
			}
			if (position2.y < num3)
			{
				num3 = position2.y;
			}
			else if (position2.y > num4)
			{
				num4 = position2.y;
			}
			if (position2.z < num5)
			{
				num5 = position2.z;
			}
			else if (position2.z > num6)
			{
				num6 = position2.z;
			}
		}
		num -= this.grindDistance;
		num2 += this.grindDistance;
		num3 -= this.grindDistance;
		num4 += this.grindDistance;
		num5 -= this.grindDistance;
		num6 += this.grindDistance;
		Vector3 center = new Vector3(num + (num2 - num) / 2f, num3 + (num4 - num3) / 2f, num5 + (num6 - num5) / 2f);
		Vector3 size = new Vector3(num2 - num, num4 - num3, num6 - num5);
		Bounds bounds = new Bounds(center, size);
		BoundsHolder boundsHolder = obj.AddComponent<BoundsHolder>();
		boundsHolder.bounds = bounds;
		boundsHolder.pos = obj.transform.position;
	}

	// Token: 0x06000813 RID: 2067 RVA: 0x00036424 File Offset: 0x00034624
	private void FixedUpdate()
	{
		if (!this.paused && !this.hawkBehavior.targetHeld)
		{
			if (this.isGrinding)
			{
				this.grind();
				this.checkRailEnd();
				XInput.GrindingVibrate();
			}
			else if (this.grindTimer <= 0f && !this.move_ref.wallRiding)
			{
				if (this.currentGracePeriod <= 0)
				{
					this.checkGrind();
				}
				else
				{
					this.currentGracePeriod--;
				}
			}
			else
			{
				this.grindTimer -= 1f;
			}
		}
	}

	// Token: 0x06000814 RID: 2068 RVA: 0x000364CC File Offset: 0x000346CC
	private void Update()
	{
		if (!this.paused && this.isGrinding)
		{
			if (this.currentBuffer > 0f)
			{
				this.currentBuffer -= 1f;
			}
			else if (this.currentBuffer <= 0f)
			{
				this.checkBail();
			}
		}
	}

	// Token: 0x06000815 RID: 2069 RVA: 0x0003652C File Offset: 0x0003472C
	private void checkGrind()
	{
		Vector3 position = this.playerRef.transform.position;
		foreach (GameObject gameObject in this.railObjects)
		{
			if (!(gameObject == null))
			{
				BoundsHolder component = gameObject.GetComponent<BoundsHolder>();
				if (component == null || component.pos != gameObject.transform.position)
				{
					this.CreateBoundingBox(gameObject);
					component = gameObject.GetComponent<BoundsHolder>();
				}
				if (component.bounds.Contains(position))
				{
					Spline component2 = gameObject.GetComponent<Spline>();
					float pos = this._GetClosestPoint(component2, position, this.itr);
					float num = Vector3.Distance(this._GetPositionOnSpline(component2, pos), position);
					if (num < this.grindDistance)
					{
						this.spline = component2;
						this.checkGrindDirection();
						this.move_ref.isGrinding = true;
						this.move_ref.freezeControls = true;
						this.playerRef.rigidbody.isKinematic = true;
						this.isGrinding = true;
						float pos2 = this._GetClosestPoint(this.spline, position, this.itr);
						this.offSet = pos2;
						base.transform.position = this._GetPositionOnSpline(this.spline, pos2);
						float z = this.playerRef.transform.InverseTransformDirection(this.playerRef.rigidbody.velocity).z;
						float num2 = -this.playerRef.transform.InverseTransformDirection(this.playerRef.rigidbody.velocity).y;
						float num3;
						if (z > num2)
						{
							num3 = z;
						}
						else
						{
							num3 = num2;
						}
						this.currentVelocity = num3 / 50f;
						this.movePlayerToGrindPoint();
					}
				}
			}
		}
	}

	// Token: 0x06000816 RID: 2070 RVA: 0x00036700 File Offset: 0x00034900
	private void checkGrindDirection()
	{
		float param = this._GetClosestPoint(this.spline, this.playerRef.transform.position, this.itr);
		Vector3 tangentToSpline = this.spline.GetTangentToSpline(param);
		Vector3 from = tangentToSpline * -1f;
		Vector3 vector = this.playerRef.transform.forward;
		Vector3 to = vector;
		if (Vector3.Angle(tangentToSpline, to) > Vector3.Angle(from, to))
		{
			this.forward = false;
		}
		else
		{
			this.forward = true;
		}
	}

	// Token: 0x06000817 RID: 2071 RVA: 0x00036788 File Offset: 0x00034988
	private void checkRailEnd()
	{
		float num = 1f / this.spline.Length;
		float num2 = 1f - num;
		float num3 = 0f + num;
		Vector3 a = this.playerRef.transform.forward;
		float num4 = this.currentVelocity * this.forwardBailSpeed;
		if (num4 < this.minBailBoost)
		{
			num4 = this.minBailBoost;
		}
		float num5 = this._GetClosestPoint(this.spline, base.transform.position, this.itr);
		if (this.forward)
		{
			if (num5 >= num2)
			{
				if (!this.checkSnap())
				{
					this.bail();
					this.playerRef.transform.position += a * (this.grindDistance + this.extraOff);
					this.playerRef.rigidbody.AddForce(a * num4);
					this.currentVelocity = 0f;
				}
			}
			else if (num5 <= num3 && this.currentVelocity <= this.minVelocity && !this.checkSnap())
			{
				this.bail();
				this.playerRef.transform.position -= a * (this.grindDistance + this.extraOff);
				this.playerRef.rigidbody.AddForce(-a * num4);
				this.currentVelocity = 0f;
			}
		}
		else if (num5 <= num3)
		{
			if (!this.checkSnap())
			{
				this.bail();
				this.playerRef.transform.position += a * (this.grindDistance + this.extraOff);
				this.playerRef.rigidbody.AddForce(a * num4);
				this.currentVelocity = 0f;
			}
		}
		else if (num5 >= num2 && this.currentVelocity <= this.minVelocity && !this.checkSnap())
		{
			this.bail();
			this.playerRef.transform.position -= a * (this.grindDistance + this.extraOff);
			this.playerRef.rigidbody.AddForce(-a * num4);
			this.currentVelocity = 0f;
		}
	}

	// Token: 0x06000818 RID: 2072 RVA: 0x000369FC File Offset: 0x00034BFC
	private bool checkSnap()
	{
		Vector3 position = this.playerRef.transform.position;
		foreach (GameObject gameObject in this.railObjects)
		{
			if (gameObject != this.spline.gameObject)
			{
				float num;
				if (this.forward)
				{
					num = Vector3.Distance(gameObject.GetComponent<Spline>().transform.GetChild(0).position, this.spline.transform.GetChild(this.spline.transform.childCount - 1).position);
					float num2 = Vector3.Distance(gameObject.GetComponent<Spline>().transform.GetChild(gameObject.GetComponent<Spline>().transform.childCount - 1).position, this.spline.transform.GetChild(this.spline.transform.childCount - 1).position);
					if (num2 < num)
					{
						num = num2;
					}
				}
				else
				{
					num = Vector3.Distance(gameObject.GetComponent<Spline>().transform.GetChild(gameObject.GetComponent<Spline>().transform.childCount - 1).position, this.spline.transform.GetChild(0).position);
					float num2 = Vector3.Distance(gameObject.GetComponent<Spline>().transform.GetChild(0).position, this.spline.transform.GetChild(0).position);
					if (num2 < num)
					{
						num = num2;
					}
				}
				if (num < this.snapDistance)
				{
					this.passedTime = 0f;
					this.offSet = 0f;
					this.spline = gameObject.GetComponent<Spline>();
					this.checkGrindDirection();
					float pos = this._GetClosestPoint(this.spline, position, this.itr);
					this.offSet = pos;
					base.transform.position = this._GetPositionOnSpline(this.spline, pos);
					this.movePlayerToGrindPoint();
					return true;
				}
			}
		}
		return false;
	}

	// Token: 0x06000819 RID: 2073 RVA: 0x00036C00 File Offset: 0x00034E00
	private void checkBail()
	{
		Vector3 up = this.playerRef.transform.up;
		Vector3 a = this.playerRef.transform.forward;
		float num = this.currentVelocity * this.forwardBailSpeed;
		if (this.spline.gameObject.name == "Super")
		{
			num = this.currentVelocity * 2500f;
		}
		if (num < this.minBailBoost)
		{
			num = this.minBailBoost;
		}
		if (Input.GetButtonDown("Jump"))
		{
			this.bail();
			this.currentGracePeriod = SplineGrinding.maxGracePeriod;
			this.move_ref.justJumped = true;
			this.playerRef.transform.position += up * this.snapDistance * 1.1f;
			if ((double)this.railSlope > 0.15)
			{
				this.playerRef.rigidbody.velocity += up * (float)this.move_ref.jumpPower / this.railSlope / 5f;
			}
			else
			{
				this.playerRef.rigidbody.velocity += up * (float)this.move_ref.jumpPower;
			}
			this.move_ref.jumpPressed = true;
			this.playerRef.rigidbody.AddForce(a * num);
			this.currentVelocity = 0f;
		}
	}

	// Token: 0x0600081A RID: 2074 RVA: 0x00036D90 File Offset: 0x00034F90
	public void bail()
	{
		this.grindTimer = this.maxGrindTimer;
		this.move_ref.isGrinding = false;
		this.move_ref.freezeControls = false;
		this.playerRef.rigidbody.isKinematic = false;
		this.isGrinding = false;
		this.passedTime = 0f;
		this.offSet = 0f;
		base.transform.rotation *= Quaternion.Euler(new Vector3(-base.transform.rotation.eulerAngles.x, 0f, -base.transform.rotation.eulerAngles.z));
		this.playerRef.transform.parent = null;
	}

	// Token: 0x0600081B RID: 2075 RVA: 0x00036E60 File Offset: 0x00035060
	private void grind()
	{
		float num = this._GetClosestPoint(this.spline, this.playerRef.transform.position, this.itr);
		float num2 = this.lookahead / this.spline.Length;
		Vector3 vector = this._GetPositionOnSpline(this.spline, num);
		if (num + num2 >= 1f)
		{
			num = 1f - num2;
			num -= 0.001f;
		}
		else if (num - num2 <= 0f)
		{
			num = num2 + 0.001f;
		}
		Vector3 vector2 = this._GetPositionOnSpline(this.spline, num + num2);
		if (!this.forward)
		{
			vector2 = this._GetPositionOnSpline(this.spline, num - num2);
		}
		Vector3 vector3 = new Vector3(1f, vector2.y - vector.y, 1f);
		this.railSlope = vector2.y - vector.y;
		this.currentVelocity += this.constantIncrease;
		if (this.spline.gameObject.name == "Super")
		{
			this.currentVelocity += this.constantIncrease * 5.7f;
		}
		if (this.currentVelocity >= this.maxVelocity)
		{
			this.currentVelocity = this.maxVelocity;
		}
		else if (this.currentVelocity <= this.minVelocity)
		{
			this.currentVelocity = this.minVelocity;
		}
		float num3 = Time.deltaTime * this.currentVelocity;
		if (this.forward)
		{
			this.passedTime += num3;
		}
		else
		{
			this.passedTime -= num3;
		}
		float num4 = this.passedTime;
		num4 /= this.spline.Length;
		num4 *= this.speedOffset;
		num4 += this.offSet;
		base.transform.position = this._GetPositionOnSpline(this.spline, this.WrapValue(num4, 1E-05f, 0.99999f, this.wrapMode));
		if (this.forward)
		{
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, this.spline.GetOrientationOnSpline(this.WrapValue(num4, 1E-05f, 0.99999f, this.wrapMode)), Time.time * (float)this.slerp);
		}
		else
		{
			base.transform.rotation = Quaternion.Slerp(base.transform.rotation, this.spline.GetOrientationOnSpline(this.WrapValue(num4, 1E-05f, 0.99999f, this.wrapMode)) * Quaternion.Euler(0f, 180f, 0f), Time.time * (float)this.slerp);
		}
	}

	// Token: 0x0600081C RID: 2076 RVA: 0x0003712C File Offset: 0x0003532C
	public void movePlayerToGrindPoint()
	{
		this.currentBuffer = this.jumpBuffer;
		this.playerRef.transform.parent = this.grindPoint.transform;
		this.playerRef.transform.localPosition = new Vector3(0f, this.grindY, 0f);
		this.playerRef.transform.rotation = new Quaternion(0f, 0f, 0f, 0f);
		if (this.forward)
		{
			base.transform.rotation = this.spline.GetOrientationOnSpline(this._GetClosestPoint(this.spline, this.playerRef.transform.position, this.itr));
		}
		else
		{
			base.transform.rotation = this.spline.GetOrientationOnSpline(this._GetClosestPoint(this.spline, this.playerRef.transform.position, this.itr)) * Quaternion.Euler(0f, 180f, 0f);
		}
	}

	// Token: 0x0600081D RID: 2077 RVA: 0x00037248 File Offset: 0x00035448
	private float WrapValue(float v, float start, float end, WrapMode wMode)
	{
		switch (wMode)
		{
		case WrapMode.Default:
		case WrapMode.Loop:
			return Mathf.Repeat(v, end - start) + start;
		case WrapMode.Once:
		case WrapMode.ClampForever:
			return Mathf.Clamp(v, start, end);
		case WrapMode.PingPong:
			return Mathf.PingPong(v, end - start) + start;
		}
		return v;
	}

	// Token: 0x0600081E RID: 2078 RVA: 0x000372AC File Offset: 0x000354AC
	private Vector3 _GetPositionOnSpline(Spline target, float pos)
	{
		if (pos <= 0f)
		{
			pos = 1E-05f;
		}
		else if (pos >= 1f)
		{
			pos = 0.99999f;
		}
		return target.GetPositionOnSpline(pos);
	}

	// Token: 0x0600081F RID: 2079 RVA: 0x000372EC File Offset: 0x000354EC
	private float _GetClosestPoint(Spline target, Vector3 pos, int itr)
	{
		float num = target.GetClosestPoint(pos, itr);
		if (num <= 0f)
		{
			num = 1E-05f;
		}
		else if (num >= 1f)
		{
			num = 0.99999f;
		}
		return num;
	}

	// Token: 0x040006ED RID: 1773
	private static SplineGrinding _instance;

	// Token: 0x040006EE RID: 1774
	public Spline spline;

	// Token: 0x040006EF RID: 1775
	public Transform playerRef;

	// Token: 0x040006F0 RID: 1776
	public float offSet;

	// Token: 0x040006F1 RID: 1777
	public WrapMode wrapMode = WrapMode.Once;

	// Token: 0x040006F2 RID: 1778
	public float passedTime;

	// Token: 0x040006F3 RID: 1779
	private float lookahead = 1f;

	// Token: 0x040006F4 RID: 1780
	public float maxVelocity = 1.85f;

	// Token: 0x040006F5 RID: 1781
	public float currentVelocity;

	// Token: 0x040006F6 RID: 1782
	private float minVelocity = -0.85f;

	// Token: 0x040006F7 RID: 1783
	private float gravity = 0.0005f;

	// Token: 0x040006F8 RID: 1784
	private float gravityVelocity;

	// Token: 0x040006F9 RID: 1785
	private float maxGravityVelocity = 0.055f;

	// Token: 0x040006FA RID: 1786
	public bool isGrinding;

	// Token: 0x040006FB RID: 1787
	public float grindDistance = 4f;

	// Token: 0x040006FC RID: 1788
	public float snapDistance = 1f;

	// Token: 0x040006FD RID: 1789
	public float constantIncrease = 0.001f;

	// Token: 0x040006FE RID: 1790
	private float grindY;

	// Token: 0x040006FF RID: 1791
	private float speedOffset = 50f;

	// Token: 0x04000700 RID: 1792
	private int itr = 4;

	// Token: 0x04000701 RID: 1793
	private int slerp = 2;

	// Token: 0x04000702 RID: 1794
	public bool forward = true;

	// Token: 0x04000703 RID: 1795
	private float railSlope = 1f;

	// Token: 0x04000704 RID: 1796
	public float grindTimer;

	// Token: 0x04000705 RID: 1797
	public float maxGrindTimer = 10f;

	// Token: 0x04000706 RID: 1798
	public float forwardBailSpeed = 3000f;

	// Token: 0x04000707 RID: 1799
	public float jumpBuffer = 5f;

	// Token: 0x04000708 RID: 1800
	private float currentBuffer;

	// Token: 0x04000709 RID: 1801
	private float minBailBoost = 1000f;

	// Token: 0x0400070A RID: 1802
	private float extraOff = 0.5f;

	// Token: 0x0400070B RID: 1803
	public bool paused;

	// Token: 0x0400070C RID: 1804
	private static int maxGracePeriod = 2;

	// Token: 0x0400070D RID: 1805
	public int currentGracePeriod = SplineGrinding.maxGracePeriod;

	// Token: 0x0400070E RID: 1806
	private GameObject[] railObjects;

	// Token: 0x0400070F RID: 1807
	private HawkBehavior hawkBehavior;

	// Token: 0x04000710 RID: 1808
	private GameObject grindPoint;
}
