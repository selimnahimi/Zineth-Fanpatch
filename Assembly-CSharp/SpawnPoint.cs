using System;
using UnityEngine;

// Token: 0x020000B8 RID: 184
public class SpawnPoint
{
	// Token: 0x060007DA RID: 2010 RVA: 0x000340D0 File Offset: 0x000322D0
	public SpawnPoint(int _currentState, Vector3 _spawnPos, Quaternion _spawnRot, Vector3 _velocity, string _animationState, string _animationName, float _animationTime, float _animationSpeed, Vector3 _cameraPosition, Quaternion _cameraRotation, int _gracePeriod, float _volume, float _airTime)
	{
		this.currentState = _currentState;
		this.spawnPos = _spawnPos;
		this.spawnRot = _spawnRot;
		this.velocity = _velocity;
		this.animationState = _animationState;
		this.animationName = _animationName;
		this.animationTime = _animationTime;
		this.animationSpeed = _animationSpeed;
		this.cameraPosition = _cameraPosition;
		this.cameraRotation = _cameraRotation;
		this.gracePeriod = _gracePeriod;
		this.volume = _volume;
		this.currentVelocity = 0f;
		this.passedTime = 0f;
		this.offSet = 0f;
		this.spline = null;
		this.forward = false;
		this.wallNormal = new Vector3(0f, 0f, 0f);
		this.airTime = _airTime;
		Transform transform = PhoneInterface.hawk.transform;
		this.hawkPos = transform.position;
		this.hawkRot = transform.rotation;
		this.timeFollowed = transform.GetComponent<HawkBehavior>().timeFollowed;
		this.swoopDistance = transform.GetComponent<HawkBehavior>().swoopDistance;
		this.startSwoopDistance = transform.GetComponent<HawkBehavior>().startSwoopDistance;
		this.inBounds = transform.GetComponent<HawkBehavior>().inBounds;
		this.targetEngaged = transform.GetComponent<HawkBehavior>().targetEngaged;
		this.hasSwoopedIn = transform.GetComponent<HawkBehavior>().hasSwoopedIn;
	}

	// Token: 0x04000693 RID: 1683
	public int currentState;

	// Token: 0x04000694 RID: 1684
	public Vector3 spawnPos;

	// Token: 0x04000695 RID: 1685
	public Quaternion spawnRot;

	// Token: 0x04000696 RID: 1686
	public Vector3 velocity;

	// Token: 0x04000697 RID: 1687
	public string animationState;

	// Token: 0x04000698 RID: 1688
	public string animationName;

	// Token: 0x04000699 RID: 1689
	public float animationTime;

	// Token: 0x0400069A RID: 1690
	public float animationSpeed;

	// Token: 0x0400069B RID: 1691
	public Vector3 cameraPosition;

	// Token: 0x0400069C RID: 1692
	public Quaternion cameraRotation;

	// Token: 0x0400069D RID: 1693
	public int gracePeriod;

	// Token: 0x0400069E RID: 1694
	public float volume;

	// Token: 0x0400069F RID: 1695
	public float currentVelocity;

	// Token: 0x040006A0 RID: 1696
	public float passedTime;

	// Token: 0x040006A1 RID: 1697
	public float offSet;

	// Token: 0x040006A2 RID: 1698
	public Spline spline;

	// Token: 0x040006A3 RID: 1699
	public bool forward;

	// Token: 0x040006A4 RID: 1700
	public Vector3 wallNormal;

	// Token: 0x040006A5 RID: 1701
	public float airTime;

	// Token: 0x040006A6 RID: 1702
	public Vector3 hawkPos;

	// Token: 0x040006A7 RID: 1703
	public Quaternion hawkRot;

	// Token: 0x040006A8 RID: 1704
	public float timeFollowed;

	// Token: 0x040006A9 RID: 1705
	public float swoopDistance;

	// Token: 0x040006AA RID: 1706
	public float startSwoopDistance;

	// Token: 0x040006AB RID: 1707
	public bool inBounds;

	// Token: 0x040006AC RID: 1708
	public bool targetEngaged;

	// Token: 0x040006AD RID: 1709
	public bool hasSwoopedIn;
}
