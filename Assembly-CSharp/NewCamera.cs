using System;
using UnityEngine;

// Token: 0x0200009B RID: 155
public class NewCamera : MonoBehaviour
{
	// Token: 0x170000DA RID: 218
	// (get) Token: 0x060006A7 RID: 1703 RVA: 0x0002AA90 File Offset: 0x00028C90
	public Transform curTarget
	{
		get
		{
			if (this.tempTarget != null)
			{
				return this.tempTarget;
			}
			return this.target;
		}
	}

	// Token: 0x060006A8 RID: 1704 RVA: 0x0002AAB0 File Offset: 0x00028CB0
	private void Awake()
	{
		this.grindScript = GameObject.Find("GrindPoint").GetComponent<SplineGrinding>();
		this.mainCamera = GameObject.Find("Main Camera");
		this.moveScript = GameObject.Find("Player").GetComponent<move>();
		float[] array = new float[32];
		array[11] = 500f;
		this.mainCamera.camera.layerCullDistances = array;
		this.tempRotation = (UnityEngine.Object.Instantiate(this.target) as Transform);
		this.tempBaseRotation = (UnityEngine.Object.Instantiate(this.target) as Transform);
		this.mockCamera = (UnityEngine.Object.Instantiate(this.target) as Transform);
		this.SnapCamera();
		this.mockCamera.position = base.transform.position;
		this.mockCamera.rotation = base.transform.rotation;
	}

	// Token: 0x060006A9 RID: 1705 RVA: 0x0002AB90 File Offset: 0x00028D90
	private void LateUpdate()
	{
		if (this.snapped && !this.pauseCamera)
		{
			if (this.numUpdates > 0)
			{
				this.numUpdates--;
			}
			else
			{
				this.numUpdates = this.maxUpdates;
				this.snapped = false;
				this.hasHit = false;
				base.transform.position = this.curTarget.TransformPoint(0f, this.height, -this.distance);
				base.transform.rotation = Quaternion.LookRotation(this.curTarget.position - base.transform.position, this.curTarget.up);
				this.mockCamera.position = base.transform.position;
				this.mockCamera.rotation = base.transform.rotation;
			}
		}
	}

	// Token: 0x060006AA RID: 1706 RVA: 0x0002AC78 File Offset: 0x00028E78
	private void FixedUpdate()
	{
		float fixedDeltaTime = Time.fixedDeltaTime;
		if (!this.tempTarget)
		{
			if (!this.snapped && !this.pauseCamera && !this.hawkMode)
			{
				this.NormalMode(fixedDeltaTime);
				this.CheckMaxDistance();
			}
			else if (this.hawkMode)
			{
				this.HawkMode(fixedDeltaTime);
			}
		}
	}

	// Token: 0x060006AB RID: 1707 RVA: 0x0002ACE8 File Offset: 0x00028EE8
	public void CheckMaxDistance()
	{
		if (Vector3.Distance(base.transform.position, this.curTarget.position) > this.maxDist)
		{
			base.transform.position = this.curTarget.TransformPoint(0f, this.height, -this.distance);
			if (this.mockCamera)
			{
				this.mockCamera.position = base.transform.position;
			}
		}
	}

	// Token: 0x060006AC RID: 1708 RVA: 0x0002AD6C File Offset: 0x00028F6C
	private void HawkMode(float deltaTime)
	{
		this.NormalMode(deltaTime);
	}

	// Token: 0x060006AD RID: 1709 RVA: 0x0002AD78 File Offset: 0x00028F78
	public void NormalMode(float deltaTime)
	{
		Quaternion quaternion = new Quaternion(0f, 0f, 0f, 1f);
		Vector3 vector = new Vector3(0f, 0f, 0f);
		if (this.moveScript.isGrinding)
		{
			if (this.grindScript.spline.GetComponent<RailCamera>())
			{
				quaternion = Quaternion.Euler(0f, this.grindScript.spline.GetComponent<RailCamera>().rotationOffset, 0f);
				vector = new Vector3(this.grindScript.spline.GetComponent<RailCamera>().positionOffset, 0f, 0f);
				if (!this.grindScript.forward)
				{
					quaternion = Quaternion.Inverse(quaternion);
					vector *= -1f;
				}
				this.mainCamera.transform.localPosition = Vector3.Slerp(this.mainCamera.transform.localPosition, vector, deltaTime * this.rotationDamping);
			}
		}
		else
		{
			this.mainCamera.transform.localPosition = Vector3.Slerp(this.mainCamera.transform.localPosition, vector, deltaTime * this.rotationDamping);
		}
		Quaternion rhs = Quaternion.Euler(Input.GetAxis("RVertical") * -this.vRotOff, Input.GetAxis("RHorizontal") * this.hRotOff, 0f);
		if (PhoneController.powerstate == PhoneController.PowerState.open)
		{
			rhs = new Quaternion(0f, 0f, 0f, 1f);
			this.camClickPos = -Vector3.one;
		}
		else if (NewCamera.use_mouse_look)
		{
			if (Input.GetButton("CellClick"))
			{
				if (this.camClickPos == -Vector3.one)
				{
					this.camClickPos = Input.mousePosition;
				}
				else
				{
					Vector3 vector2 = (Input.mousePosition - this.camClickPos) / 60f;
					vector2 = Vector3.ClampMagnitude(vector2, 1f);
					rhs = Quaternion.Euler(vector2.y * -this.vRotOff, vector2.x * this.hRotOff, 0f);
				}
			}
			else
			{
				this.camClickPos = -Vector3.one;
			}
		}
		this.tempRotation.position = this.curTarget.position;
		this.tempRotation.rotation = this.curTarget.rotation;
		this.tempBaseRotation.position = this.curTarget.position;
		this.tempBaseRotation.rotation = this.curTarget.rotation * quaternion;
		Quaternion lhs = Quaternion.LookRotation(this.tempRotation.position - base.transform.position, this.tempRotation.up);
		Quaternion to = Quaternion.LookRotation(this.tempBaseRotation.position - base.transform.position, this.tempBaseRotation.up);
		this.mockCamera.rotation = Quaternion.Slerp(this.mockCamera.rotation, to, deltaTime * this.rotationDamping);
		base.transform.rotation = Quaternion.Slerp(base.transform.rotation, lhs * rhs * quaternion, deltaTime * this.rotationDamping);
		Vector3 vector3 = this.curTarget.TransformPoint(0f, this.height, -this.distance);
		Vector3 vector4 = this.curTarget.TransformPoint(0f, this.height, -(this.distance * 3f));
		Vector3 vector5;
		Vector3 newCheck;
		if (!this.hasHit)
		{
			vector5 = Vector3.Lerp(base.transform.position, vector3, deltaTime * this.damping);
			newCheck = Vector3.Lerp(base.transform.position, vector4, deltaTime * this.damping);
		}
		else
		{
			vector5 = vector3;
			newCheck = vector4;
		}
		vector5 = this.collisionCheck(vector5, newCheck, deltaTime);
		if (vector5 == vector3)
		{
			vector5 = Vector3.Lerp(base.transform.position, vector3, deltaTime * this.damping);
		}
		base.transform.position = vector5;
		this.mockCamera.position = vector5;
		this.lastWantedPosition = vector3;
	}

	// Token: 0x060006AE RID: 1710 RVA: 0x0002B1BC File Offset: 0x000293BC
	private Vector3 collisionCheck(Vector3 newPos, Vector3 newCheck, float deltaTime)
	{
		Vector3 vector = newPos;
		RaycastHit raycastHit;
		if (!this.hasHit)
		{
			if (Physics.Linecast(base.transform.position, newCheck, out raycastHit))
			{
				this.hasHit = true;
				this.stuckPoint = raycastHit.point;
				this.stuckNormal = raycastHit.normal;
				vector = raycastHit.point + raycastHit.normal * this.adjustOffset;
				vector = Vector3.Lerp(base.transform.position, vector, deltaTime * this.damping);
			}
		}
		else if (Physics.Linecast(base.transform.position, newPos, out raycastHit))
		{
			if (Vector3.Distance(newPos, this.lastWantedPosition) >= this.ignoreDistance)
			{
				this.stuckPoint = raycastHit.point;
				this.stuckNormal = raycastHit.normal;
				vector = this.stuckPoint + this.stuckNormal * this.adjustOffset;
			}
			else
			{
				vector = this.stuckPoint + this.stuckNormal * this.adjustOffset;
			}
			vector = Vector3.Lerp(base.transform.position, vector, deltaTime * this.damping);
		}
		else
		{
			this.hasHit = false;
		}
		if (Physics.Linecast(this.curTarget.position, vector, out raycastHit))
		{
			this.stuckPoint = raycastHit.point;
			this.stuckNormal = raycastHit.normal;
			vector = Vector3.Lerp(base.transform.position, this.curTarget.position, deltaTime * this.damping);
		}
		if (Physics.Linecast(vector + Vector3.up * 3f, vector - Vector3.up * 0.5f, out raycastHit) && raycastHit.collider.tag == "Terrain")
		{
			this.stuckPoint = raycastHit.point;
			this.stuckNormal = raycastHit.normal;
			vector = raycastHit.point + raycastHit.normal * (3.5f - raycastHit.distance);
		}
		return vector;
	}

	// Token: 0x060006AF RID: 1711 RVA: 0x0002B3E4 File Offset: 0x000295E4
	public void SnapCamera()
	{
		this.snapped = true;
	}

	// Token: 0x0400055A RID: 1370
	public Transform target;

	// Token: 0x0400055B RID: 1371
	public Transform tempTarget;

	// Token: 0x0400055C RID: 1372
	public float distanceBehind = 1.73f;

	// Token: 0x0400055D RID: 1373
	public float distance = 13f;

	// Token: 0x0400055E RID: 1374
	public float height = 2.75f;

	// Token: 0x0400055F RID: 1375
	public float damping = 8f;

	// Token: 0x04000560 RID: 1376
	public float rotationDamping = 8f;

	// Token: 0x04000561 RID: 1377
	public float hitOffset = 1f;

	// Token: 0x04000562 RID: 1378
	public float adjustOffset = 2f;

	// Token: 0x04000563 RID: 1379
	public float ignoreDistance = 0.2f;

	// Token: 0x04000564 RID: 1380
	public float maxRotationSpeed = 0.01f;

	// Token: 0x04000565 RID: 1381
	private Vector3 stuckPoint;

	// Token: 0x04000566 RID: 1382
	private Vector3 stuckNormal;

	// Token: 0x04000567 RID: 1383
	private bool hasHit;

	// Token: 0x04000568 RID: 1384
	private Vector3 cameraPos;

	// Token: 0x04000569 RID: 1385
	private Vector3 lastWantedPosition = new Vector3(0f, 0f, 0f);

	// Token: 0x0400056A RID: 1386
	private bool snapped;

	// Token: 0x0400056B RID: 1387
	private int maxUpdates = 2;

	// Token: 0x0400056C RID: 1388
	private int numUpdates = 2;

	// Token: 0x0400056D RID: 1389
	private Vector3 snapPos;

	// Token: 0x0400056E RID: 1390
	private Quaternion snapRot;

	// Token: 0x0400056F RID: 1391
	private float hRotOff = 30f;

	// Token: 0x04000570 RID: 1392
	private float vRotOff = 30f;

	// Token: 0x04000571 RID: 1393
	private Vector3 baseMousePos;

	// Token: 0x04000572 RID: 1394
	private Transform tempRotation;

	// Token: 0x04000573 RID: 1395
	private Transform tempBaseRotation;

	// Token: 0x04000574 RID: 1396
	public Transform mockCamera;

	// Token: 0x04000575 RID: 1397
	public float maxDist = 50f;

	// Token: 0x04000576 RID: 1398
	public bool pauseCamera;

	// Token: 0x04000577 RID: 1399
	public bool hawkMode;

	// Token: 0x04000578 RID: 1400
	private move moveScript;

	// Token: 0x04000579 RID: 1401
	private SplineGrinding grindScript;

	// Token: 0x0400057A RID: 1402
	private GameObject mainCamera;

	// Token: 0x0400057B RID: 1403
	private Vector3 camClickPos = -Vector3.one;

	// Token: 0x0400057C RID: 1404
	public static bool use_mouse_look = true;
}
