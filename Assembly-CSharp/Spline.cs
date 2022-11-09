using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000C3 RID: 195
public class Spline : MonoBehaviour
{
	// Token: 0x170000F0 RID: 240
	// (get) Token: 0x06000824 RID: 2084 RVA: 0x000373FC File Offset: 0x000355FC
	public SplineNode[] SplineNodes
	{
		get
		{
			return this.splineNodes;
		}
	}

	// Token: 0x170000F1 RID: 241
	public SplineNode this[int idx]
	{
		get
		{
			return this.splineNodes[idx];
		}
		set
		{
			if (value != null)
			{
				this.splineNodes[idx] = value;
			}
		}
	}

	// Token: 0x170000F2 RID: 242
	// (get) Token: 0x06000827 RID: 2087 RVA: 0x00037424 File Offset: 0x00035624
	public float Length
	{
		get
		{
			return this.splineLength;
		}
	}

	// Token: 0x170000F3 RID: 243
	// (get) Token: 0x06000828 RID: 2088 RVA: 0x0003742C File Offset: 0x0003562C
	public bool AutoClose
	{
		get
		{
			return this.autoClose && this.interpolationMode != Spline.InterpolationMode.Bezier;
		}
	}

	// Token: 0x170000F4 RID: 244
	// (get) Token: 0x06000829 RID: 2089 RVA: 0x00037448 File Offset: 0x00035648
	public int SegmentCount
	{
		get
		{
			if (this.interpolationMode == Spline.InterpolationMode.Bezier)
			{
				return (this.splineNodes.Length - 1) / 3;
			}
			if (this.AutoClose)
			{
				return this.splineNodes.Length;
			}
			return this.splineNodes.Length - 1;
		}
	}

	// Token: 0x170000F5 RID: 245
	// (get) Token: 0x0600082A RID: 2090 RVA: 0x00037484 File Offset: 0x00035684
	public int ControlSegmentCount
	{
		get
		{
			if (this.AutoClose)
			{
				return this.splineNodes.Length;
			}
			return this.splineNodes.Length - 1;
		}
	}

	// Token: 0x170000F6 RID: 246
	// (get) Token: 0x0600082B RID: 2091 RVA: 0x000374A4 File Offset: 0x000356A4
	public Transform[] SplineNodeTransforms
	{
		get
		{
			if (this.nodeMode != Spline.ControlNodeMode.UseArray)
			{
				List<Transform> list = new List<Transform>();
				foreach (SplineControlNode splineControlNode in base.GetComponentsInChildren<SplineControlNode>())
				{
					list.Add(splineControlNode.GetTransform);
				}
				list.Remove(base.transform);
				list.Sort((Transform a, Transform b) => a.name.CompareTo(b.name));
				return list.ToArray();
			}
			return this.splineNodesTransform;
		}
	}

	// Token: 0x170000F7 RID: 247
	// (get) Token: 0x0600082C RID: 2092 RVA: 0x0003752C File Offset: 0x0003572C
	public SplineSegment[] SplineSegments
	{
		get
		{
			SplineSegment[] array = new SplineSegment[this.SegmentCount];
			if (this.interpolationMode != Spline.InterpolationMode.Bezier)
			{
				for (int i = 0; i < array.Length; i++)
				{
					array[i] = new SplineSegment(this, this.splineNodes[i], this.splineNodes[i].NextNode0);
				}
			}
			else
			{
				for (int j = 0; j < array.Length; j++)
				{
					array[j] = new SplineSegment(this, this.splineNodes[j * 3], this.splineNodes[j * 3].NextNode0);
				}
			}
			return array;
		}
	}

	// Token: 0x170000F8 RID: 248
	// (get) Token: 0x0600082D RID: 2093 RVA: 0x000375C0 File Offset: 0x000357C0
	private bool IsBezier
	{
		get
		{
			return this.interpolationMode == Spline.InterpolationMode.Bezier;
		}
	}

	// Token: 0x170000F9 RID: 249
	// (get) Token: 0x0600082E RID: 2094 RVA: 0x000375CC File Offset: 0x000357CC
	private int Step
	{
		get
		{
			if (this.interpolationMode == Spline.InterpolationMode.Bezier)
			{
				return 3;
			}
			return 1;
		}
	}

	// Token: 0x0600082F RID: 2095 RVA: 0x000375E0 File Offset: 0x000357E0
	private void OnEnable()
	{
		this.UpdateSplineNodes();
	}

	// Token: 0x06000830 RID: 2096 RVA: 0x000375E8 File Offset: 0x000357E8
	private void LateUpdate()
	{
		switch (this.updateMode)
		{
		case Spline.UpdateMode.EveryFrame:
			this.UpdateSplineNodes();
			break;
		case Spline.UpdateMode.EveryXFrames:
			if (this.deltaFrames <= 0)
			{
				this.deltaFrames = 1;
			}
			if (Time.frameCount % this.deltaFrames == 0)
			{
				this.UpdateSplineNodes();
			}
			break;
		case Spline.UpdateMode.EveryXSeconds:
			this.passedTime += Time.deltaTime;
			if (this.passedTime >= this.deltaSeconds)
			{
				this.UpdateSplineNodes();
				this.passedTime = 0f;
			}
			break;
		}
	}

	// Token: 0x06000831 RID: 2097 RVA: 0x00037688 File Offset: 0x00035888
	public void UpdateSplineNodes()
	{
		this.SetupSplineNodes(this.SplineNodeTransforms);
	}

	// Token: 0x06000832 RID: 2098 RVA: 0x00037698 File Offset: 0x00035898
	public Vector3 GetPositionOnSpline(float param)
	{
		if (this.splineNodes == null)
		{
			return Vector3.zero;
		}
		int idxFirstPoint;
		float t;
		this.RecalculateParameter(param, out idxFirstPoint, out t);
		return this.GetPositionInternal(idxFirstPoint, t);
	}

	// Token: 0x06000833 RID: 2099 RVA: 0x000376CC File Offset: 0x000358CC
	public Vector3 GetTangentToSpline(float param)
	{
		if (this.splineNodes == null)
		{
			return Vector3.zero;
		}
		int idxFirstPoint;
		float t;
		this.RecalculateParameter(param, out idxFirstPoint, out t);
		return this.GetTangentInternal(idxFirstPoint, t);
	}

	// Token: 0x06000834 RID: 2100 RVA: 0x00037700 File Offset: 0x00035900
	public Quaternion GetOrientationOnSpline(float param)
	{
		if (this.splineNodes == null)
		{
			return Quaternion.identity;
		}
		Spline.RotationMode rotationMode = this.rotationMode;
		if (rotationMode == Spline.RotationMode.Node)
		{
			int idxFirstPoint;
			float t;
			this.RecalculateParameter(param, out idxFirstPoint, out t);
			return this.GetRotationInternal(idxFirstPoint, t);
		}
		if (rotationMode != Spline.RotationMode.Tangent)
		{
			return Quaternion.identity;
		}
		Vector3 tangentToSpline = this.GetTangentToSpline(param);
		if (tangentToSpline.x == 0f && (tangentToSpline.y == 0f & tangentToSpline.z == 0f))
		{
			return Quaternion.identity;
		}
		return Quaternion.LookRotation(tangentToSpline, this.tanUpVector);
	}

	// Token: 0x06000835 RID: 2101 RVA: 0x000377A0 File Offset: 0x000359A0
	public SplineSegment GetSplineSegment(float param)
	{
		if (this.interpolationMode == Spline.InterpolationMode.Bezier)
		{
			param = Mathf.Clamp(param, 0f, 1f);
			if (param == 1f)
			{
				return new SplineSegment(this, this.splineNodes[this.ControlSegmentCount - 1], this.splineNodes[this.ControlSegmentCount - 1].NextNode0);
			}
			for (int i = 0; i < this.ControlSegmentCount; i += 3)
			{
				if (param - this.splineNodes[i].posInSpline < this.splineNodes[i].length)
				{
					return new SplineSegment(this, this.splineNodes[i], this.splineNodes[i].NextNode2);
				}
			}
		}
		else
		{
			if (this.AutoClose)
			{
				param = Mathf.Repeat(param, 1f);
			}
			else
			{
				param = Mathf.Clamp(param, 0f, 1f);
			}
			if (param == 1f)
			{
				return new SplineSegment(this, this.splineNodes[this.ControlSegmentCount - 1], this.splineNodes[this.ControlSegmentCount - 1].NextNode0);
			}
			for (int j = 0; j < this.ControlSegmentCount; j++)
			{
				if (param - this.splineNodes[j].posInSpline < this.splineNodes[j].length)
				{
					return new SplineSegment(this, this.splineNodes[j], this.splineNodes[j].NextNode0);
				}
			}
		}
		return null;
	}

	// Token: 0x06000836 RID: 2102 RVA: 0x00037914 File Offset: 0x00035B14
	public float ConvertNormalizedParameterToDistance(float param)
	{
		return this.splineLength * param;
	}

	// Token: 0x06000837 RID: 2103 RVA: 0x00037920 File Offset: 0x00035B20
	public float ConvertDistanceToNormalizedParameter(float param)
	{
		if (this.splineLength <= 0f || param <= 0f)
		{
			return 0f;
		}
		if (param > this.splineLength)
		{
			return 1f;
		}
		return param / this.splineLength;
	}

	// Token: 0x06000838 RID: 2104 RVA: 0x00037960 File Offset: 0x00035B60
	private void RecalculateParameter(float param, out int normalizedIndex, out float normalizedParam)
	{
		param = Mathf.Clamp01(param);
		normalizedIndex = 0;
		normalizedParam = 0f;
		if (param == 0f)
		{
			return;
		}
		if (param == 1f)
		{
			if (this.interpolationMode == Spline.InterpolationMode.Bezier)
			{
				normalizedIndex = this.ControlSegmentCount - 3;
			}
			else
			{
				normalizedIndex = this.ControlSegmentCount - 1;
			}
			normalizedParam = 1f;
			return;
		}
		float num = 1f / (float)this.interpolationAccuracy;
		for (int i = this.subSegmentPosition.Length - 1; i >= 0; i--)
		{
			if (this.subSegmentPosition[i] < param)
			{
				int num2 = i - i % this.interpolationAccuracy;
				normalizedIndex = num2 * this.Step / this.interpolationAccuracy;
				normalizedParam = num * ((float)(i - num2) + (param - this.subSegmentPosition[i]) / this.subSegmentLength[i]);
				if (normalizedIndex >= this.ControlSegmentCount)
				{
					if (this.interpolationMode == Spline.InterpolationMode.Bezier)
					{
						normalizedIndex = this.ControlSegmentCount - 3;
					}
					else
					{
						normalizedIndex = this.ControlSegmentCount - 1;
					}
					normalizedParam = 1f;
				}
				return;
			}
		}
	}

	// Token: 0x06000839 RID: 2105 RVA: 0x00037A6C File Offset: 0x00035C6C
	private void SetupSplineNodes(Transform[] transformNodes)
	{
		this.splineNodes = null;
		if (transformNodes.Length <= 0)
		{
			return;
		}
		int num = transformNodes.Length;
		if (this.interpolationMode == Spline.InterpolationMode.Bezier)
		{
			if (transformNodes.Length < 7)
			{
				num -= transformNodes.Length % 4;
			}
			else
			{
				num -= (transformNodes.Length - 4) % 3;
			}
			if (num < 4)
			{
				return;
			}
		}
		else if (num < 2)
		{
			return;
		}
		SplineNode[] array = new SplineNode[num];
		for (int i = 0; i < num; i++)
		{
			if (transformNodes[i] == null)
			{
				return;
			}
			array[i] = new SplineNode(transformNodes[i]);
		}
		for (int j = 0; j < num; j++)
		{
			if (transformNodes[j] == null)
			{
				return;
			}
			int num2 = j - 1;
			int num3 = j + 1;
			int num4 = j + 2;
			int num5 = j + 3;
			if (this.AutoClose)
			{
				if (num2 < 0)
				{
					num2 = num - 1;
				}
				num3 %= num;
				num4 %= num;
				num5 %= num;
			}
			else
			{
				num2 = Mathf.Max(num2, 0);
				num3 = Mathf.Min(num3, num - 1);
				num4 = Mathf.Min(num4, num - 1);
				num5 = Mathf.Min(num5, num - 1);
			}
			array[j][0] = array[num2];
			array[j][1] = array[num3];
			array[j][2] = array[num4];
			array[j][3] = array[num5];
		}
		this.splineNodes = array;
		this.ReparametrizeCurve();
	}

	// Token: 0x0600083A RID: 2106 RVA: 0x00037BD8 File Offset: 0x00035DD8
	private void ReparametrizeCurve()
	{
		this.splineLength = 0f;
		this.subSegmentLength = new float[this.SegmentCount * this.interpolationAccuracy];
		this.subSegmentPosition = new float[this.SegmentCount * this.interpolationAccuracy];
		for (int i = 0; i < this.SegmentCount * this.interpolationAccuracy; i++)
		{
			this.subSegmentLength[i] = 0f;
			this.subSegmentPosition[i] = 0f;
		}
		if (this.splineNodes == null)
		{
			return;
		}
		for (int j = 0; j < this.SegmentCount; j++)
		{
			for (int k = 1; k <= this.interpolationAccuracy; k++)
			{
				int num = j * this.interpolationAccuracy + k - 1;
				float num2 = 1f / (float)this.interpolationAccuracy;
				this.subSegmentLength[num] = this.GetSegmentLengthInternal(j * this.Step, num2 * (float)(k - 1), num2 * (float)k, 0.2f * num2);
				this.splineLength += this.subSegmentLength[num];
			}
		}
		for (int l = 0; l < this.SegmentCount; l++)
		{
			for (int m = 1; m <= this.interpolationAccuracy; m++)
			{
				int num3 = l * this.interpolationAccuracy + m;
				this.subSegmentLength[num3 - 1] /= this.splineLength;
				if (num3 == this.subSegmentPosition.Length)
				{
					break;
				}
				this.subSegmentPosition[num3] = this.subSegmentPosition[num3 - 1] + this.subSegmentLength[num3 - 1];
			}
		}
		for (int n = 0; n < this.subSegmentLength.Length; n++)
		{
			this.splineNodes[(n - n % this.interpolationAccuracy) / this.interpolationAccuracy * this.Step].length += this.subSegmentLength[n];
		}
		for (int num4 = 0; num4 < this.splineNodes.Length - this.Step; num4 += this.Step)
		{
			this.splineNodes[num4 + this.Step].posInSpline = this.splineNodes[num4].posInSpline + this.splineNodes[num4].length;
		}
		if (this.IsBezier)
		{
			for (int num5 = 0; num5 < this.splineNodes.Length - this.Step; num5 += this.Step)
			{
				this.splineNodes[num5 + 1].posInSpline = this.splineNodes[num5].posInSpline;
				this.splineNodes[num5 + 2].posInSpline = this.splineNodes[num5].posInSpline;
			}
		}
		if (!this.AutoClose)
		{
			this.splineNodes[this.splineNodes.Length - 1].posInSpline = 1f;
		}
	}

	// Token: 0x0600083B RID: 2107 RVA: 0x00037EC4 File Offset: 0x000360C4
	public float GetClosestPoint(Vector3 p, int iterations)
	{
		float num = float.PositiveInfinity;
		float num2 = 0f;
		iterations = Mathf.Clamp(iterations, 0, 5);
		for (float num3 = 0f; num3 <= 1f; num3 += 0.01f)
		{
			float sqrMagnitude = (this.GetPositionOnSpline(num3) - p).sqrMagnitude;
			if (num > sqrMagnitude)
			{
				num = sqrMagnitude;
				num2 = num3;
			}
		}
		for (int i = 0; i < iterations; i++)
		{
			float num4 = 0.01f * Mathf.Pow(10f, -(float)i);
			float num5 = num4 * 0.1f;
			for (float num6 = Mathf.Clamp01(num2 - num4); num6 <= Mathf.Clamp01(num2 + num4); num6 += num5)
			{
				float sqrMagnitude2 = (this.GetPositionOnSpline(num6) - p).sqrMagnitude;
				if (num > sqrMagnitude2)
				{
					num = sqrMagnitude2;
					num2 = num6;
				}
			}
		}
		return num2;
	}

	// Token: 0x0600083C RID: 2108 RVA: 0x00037FAC File Offset: 0x000361AC
	public float GetClosestPoint(Vector3 p, int iterations, float lastParam, float diff)
	{
		float num = float.PositiveInfinity;
		float num2 = 0f;
		iterations = Mathf.Clamp(iterations, 0, 5);
		for (float num3 = 0f; num3 <= 1f; num3 += 0.01f)
		{
			float magnitude = (this.GetPositionOnSpline(num3) - p).magnitude;
			if (num > magnitude && Mathf.Abs(num3 - lastParam) < diff)
			{
				num = magnitude;
				num2 = num3;
			}
		}
		for (int i = 0; i < iterations; i++)
		{
			float num4 = 0.01f / Mathf.Pow(10f, (float)i);
			float num5 = num4 * 0.1f;
			for (float num6 = Mathf.Clamp01(num2 - num4); num6 <= Mathf.Clamp01(num2 + num4); num6 += num5)
			{
				float magnitude2 = (this.GetPositionOnSpline(num6) - p).magnitude;
				if (num > magnitude2 && Mathf.Abs(num6 - lastParam) < diff)
				{
					num = magnitude2;
					num2 = num6;
				}
			}
		}
		return num2;
	}

	// Token: 0x0600083D RID: 2109 RVA: 0x000380B4 File Offset: 0x000362B4
	public Vector3 GetShortestConnection(Vector3 p, int iterations)
	{
		return this.GetPositionOnSpline(this.GetClosestPoint(p, iterations)) - p;
	}

	// Token: 0x0600083E RID: 2110 RVA: 0x000380CC File Offset: 0x000362CC
	private void OnDrawGizmos()
	{
		this.UpdateSplineNodes();
		if (this.splineNodes == null)
		{
			return;
		}
		this.DrawSplineGizmo(new Color(0.5f, 0.5f, 0.5f, 0.5f));
		Plane plane = default(Plane);
		Gizmos.color = new Color(1f, 1f, 1f, 0.5f);
		plane.SetNormalAndPosition(Camera.current.transform.forward, Camera.current.transform.position);
		foreach (SplineNode splineNode in this.splineNodes)
		{
			float num = 0f;
			if (Camera.current.orthographic)
			{
				num = Camera.current.orthographicSize * 2.5f;
			}
			else
			{
				plane.Raycast(new Ray(splineNode.Position, Camera.current.transform.forward), out num);
			}
			Gizmos.DrawSphere(splineNode.Position, num * 0.015f);
		}
	}

	// Token: 0x0600083F RID: 2111 RVA: 0x000381D8 File Offset: 0x000363D8
	private void OnDrawGizmosSelected()
	{
		this.UpdateSplineNodes();
		if (this.splineNodes == null)
		{
			return;
		}
		this.DrawSplineGizmo(new Color(1f, 0.5f, 0f, 1f));
		Plane plane = default(Plane);
		Gizmos.color = new Color(1f, 0.5f, 0f, 0.75f);
		plane.SetNormalAndPosition(Camera.current.transform.forward, Camera.current.transform.position);
		foreach (SplineNode splineNode in this.splineNodes)
		{
			float num = 0f;
			if (Camera.current.orthographic)
			{
				num = Camera.current.orthographicSize * 2.5f;
			}
			else
			{
				plane.Raycast(new Ray(splineNode.Position, Camera.current.transform.forward), out num);
			}
			Gizmos.DrawSphere(splineNode.Position, num * 0.0075f);
		}
	}

	// Token: 0x06000840 RID: 2112 RVA: 0x000382E4 File Offset: 0x000364E4
	private void DrawSplineGizmo(Color curveColor)
	{
		int num = 1;
		switch (this.interpolationMode)
		{
		case Spline.InterpolationMode.Bezier:
			Gizmos.color = new Color(curveColor.r, curveColor.g, curveColor.b, curveColor.a * 0.25f);
			for (int i = 0; i < this.ControlSegmentCount; i++)
			{
				Gizmos.DrawLine(this.splineNodes[i].Position, this.splineNodes[i].NextNode0.Position);
			}
			num = 3;
			break;
		case Spline.InterpolationMode.BSpline:
			Gizmos.color = new Color(curveColor.r, curveColor.g, curveColor.b, curveColor.a * 0.25f);
			for (int j = 0; j < this.ControlSegmentCount; j++)
			{
				Gizmos.DrawLine(this.splineNodes[j].Position, this.splineNodes[j].NextNode0.Position);
			}
			break;
		}
		Gizmos.color = curveColor;
		for (int k = 0; k < this.ControlSegmentCount; k += num)
		{
			Vector3 from = this.GetPositionInternal(k, 0f);
			for (float num2 = 0.05f; num2 < 1.05f; num2 += 0.05f)
			{
				Vector3 positionInternal = this.GetPositionInternal(k, num2);
				Gizmos.DrawLine(from, positionInternal);
				from = positionInternal;
			}
		}
	}

	// Token: 0x06000841 RID: 2113 RVA: 0x00038458 File Offset: 0x00036658
	private Vector3 GetPositionInternal(int idxFirstPoint, float t)
	{
		if (!this.splineNodes[idxFirstPoint].CheckReferences())
		{
			return Vector3.zero;
		}
		Vector3 position = this.splineNodes[idxFirstPoint].nodeTransform.position;
		Vector3 position2 = this.splineNodes[idxFirstPoint].NextNode0.nodeTransform.position;
		Spline.InterpolationMode interpolationMode = this.interpolationMode;
		if (interpolationMode == Spline.InterpolationMode.Hermite)
		{
			Vector3 vector;
			Vector3 vector2;
			this.GetCatMullTangentsInternal(this.splineNodes[idxFirstPoint], ref position, ref position2, out vector, out vector2);
			return this.InterpolatePosition(t, ref position, ref position2, ref vector, ref vector2);
		}
		if (interpolationMode != Spline.InterpolationMode.Bezier)
		{
			Vector3 position3 = this.splineNodes[idxFirstPoint].PrevNode0.nodeTransform.position;
			Vector3 position4 = this.splineNodes[idxFirstPoint].NextNode1.nodeTransform.position;
			return this.InterpolatePosition(t, ref position3, ref position, ref position2, ref position4);
		}
		Vector3 position5 = this.splineNodes[idxFirstPoint].NextNode1.nodeTransform.position;
		Vector3 position6 = this.splineNodes[idxFirstPoint].NextNode2.nodeTransform.position;
		return this.InterpolatePosition(t, ref position, ref position2, ref position5, ref position6);
	}

	// Token: 0x06000842 RID: 2114 RVA: 0x00038570 File Offset: 0x00036770
	private Vector3 GetTangentInternal(int idxFirstPoint, float t)
	{
		if (!this.splineNodes[idxFirstPoint].CheckReferences())
		{
			return Vector3.zero;
		}
		Vector3 position = this.splineNodes[idxFirstPoint].nodeTransform.position;
		Vector3 position2 = this.splineNodes[idxFirstPoint].NextNode0.nodeTransform.position;
		Spline.InterpolationMode interpolationMode = this.interpolationMode;
		if (interpolationMode == Spline.InterpolationMode.Hermite)
		{
			Vector3 vector;
			Vector3 vector2;
			this.GetCatMullTangentsInternal(this.splineNodes[idxFirstPoint], ref position, ref position2, out vector, out vector2);
			return this.InterpolateTangent(t, ref position, ref position2, ref vector, ref vector2);
		}
		if (interpolationMode != Spline.InterpolationMode.Bezier)
		{
			Vector3 position3 = this.splineNodes[idxFirstPoint].PrevNode0.nodeTransform.position;
			Vector3 position4 = this.splineNodes[idxFirstPoint].NextNode1.nodeTransform.position;
			return this.InterpolateTangent(t, ref position3, ref position, ref position2, ref position4);
		}
		Vector3 position5 = this.splineNodes[idxFirstPoint].NextNode1.nodeTransform.position;
		Vector3 position6 = this.splineNodes[idxFirstPoint].NextNode2.nodeTransform.position;
		return this.InterpolateTangent(t, ref position, ref position2, ref position5, ref position6);
	}

	// Token: 0x06000843 RID: 2115 RVA: 0x00038688 File Offset: 0x00036888
	private Quaternion GetRotationInternal(int idxFirstPoint, float t)
	{
		if (!this.splineNodes[idxFirstPoint].CheckReferences())
		{
			return Quaternion.identity;
		}
		Quaternion rotation = this.splineNodes[idxFirstPoint].PrevNode0.nodeTransform.rotation;
		Quaternion rotation2 = this.splineNodes[idxFirstPoint].nodeTransform.rotation;
		Quaternion rotation3 = this.splineNodes[idxFirstPoint].NextNode0.nodeTransform.rotation;
		Quaternion rotation4 = this.splineNodes[idxFirstPoint].NextNode1.nodeTransform.rotation;
		Quaternion squadIntermediate = Spline.GetSquadIntermediate(rotation, rotation2, rotation3);
		Quaternion squadIntermediate2 = Spline.GetSquadIntermediate(rotation2, rotation3, rotation4);
		return Spline.GetQuatSquad(t, rotation2, rotation3, squadIntermediate, squadIntermediate2);
	}

	// Token: 0x06000844 RID: 2116 RVA: 0x00038728 File Offset: 0x00036928
	private Vector3 InterpolatePosition(float t, ref Vector3 P1, ref Vector3 P2, ref Vector3 P3, ref Vector3 P4)
	{
		float num = t * t;
		float num2 = num * t;
		float num3;
		float num4;
		float num5;
		float num6;
		switch (this.interpolationMode)
		{
		default:
			num3 = 2f * num2 - 3f * num + 0f * t + 1f;
			num4 = -2f * num2 + 3f * num + 0f * t;
			num5 = 1f * num2 - 2f * num + 1f * t;
			num6 = 1f * num2 - 1f * num + 0f * t;
			break;
		case Spline.InterpolationMode.Bezier:
			num3 = -1f * num2 + 3f * num - 3f * t + 1f;
			num4 = 3f * num2 - 6f * num + 3f * t;
			num5 = -3f * num2 + 3f * num + 0f * t;
			num6 = 1f * num2 - 0f * num + 0f * t;
			break;
		case Spline.InterpolationMode.BSpline:
			num3 = -0.16666667f * num2 + 0.5f * num - 0.5f * t + 0.16666667f;
			num4 = 0.5f * num2 - 1f * num + 0f * t + 0.6666667f;
			num5 = -0.5f * num2 + 0.5f * num + 0.5f * t + 0.16666667f;
			num6 = 0.16666667f * num2 + 0f * num + 0f * t;
			break;
		}
		return new Vector3(num3 * P1.x + num4 * P2.x + num5 * P3.x + num6 * P4.x, num3 * P1.y + num4 * P2.y + num5 * P3.y + num6 * P4.y, num3 * P1.z + num4 * P2.z + num5 * P3.z + num6 * P4.z);
	}

	// Token: 0x06000845 RID: 2117 RVA: 0x0003892C File Offset: 0x00036B2C
	private Vector3 InterpolateTangent(float t, ref Vector3 P1, ref Vector3 P2, ref Vector3 P3, ref Vector3 P4)
	{
		float num = t * t;
		float num2;
		float num3;
		float num4;
		float num5;
		switch (this.interpolationMode)
		{
		default:
			num2 = 6f * num - 6f * t;
			num3 = -6f * num + 6f * t;
			num4 = 3f * num - 4f * t + 1f;
			num5 = 3f * num - 2f * t;
			break;
		case Spline.InterpolationMode.Bezier:
			num2 = -3f * num + 6f * t - 3f;
			num3 = 9f * num - 12f * t + 3f;
			num4 = -9f * num + 6f * t;
			num5 = 3f * num - 0f * t;
			break;
		case Spline.InterpolationMode.BSpline:
			num2 = -0.5f * num + 1f * t - 0.5f;
			num3 = 1.5f * num - 2f * t;
			num4 = -1.5f * num + 1f * t + 0.5f;
			num5 = 0.5f * num + 0f * t;
			break;
		}
		return new Vector3(num2 * P1.x + num3 * P2.x + num4 * P3.x + num5 * P4.x, num2 * P1.y + num3 * P2.y + num4 * P3.y + num5 * P4.y, num2 * P1.z + num3 * P2.z + num4 * P3.z + num5 * P4.z);
	}

	// Token: 0x06000846 RID: 2118 RVA: 0x00038AC4 File Offset: 0x00036CC4
	private void GetCatMullTangentsInternal(SplineNode firstNode, ref Vector3 P1, ref Vector3 P2, out Vector3 T1, out Vector3 T2)
	{
		Spline.TangentMode tangentMode = this.tangentMode;
		if (tangentMode == Spline.TangentMode.UseTangents)
		{
			T1 = firstNode.PrevNode0.nodeTransform.position;
			T2 = firstNode.NextNode1.nodeTransform.position;
			T1.x = (P2.x - T1.x) * this.tension;
			T1.y = (P2.y - T1.y) * this.tension;
			T1.z = (P2.z - T1.z) * this.tension;
			T2.x = (T2.x - P1.x) * this.tension;
			T2.y = (T2.y - P1.y) * this.tension;
			T2.z = (T2.z - P1.z) * this.tension;
			return;
		}
		if (tangentMode != Spline.TangentMode.UseNodeForwardVector)
		{
			T1 = firstNode.PrevNode0.nodeTransform.position;
			T2 = firstNode.NextNode1.nodeTransform.position;
			T1.x = P2.x - T1.x;
			T1.y = P2.y - T1.y;
			T1.z = P2.z - T1.z;
			T2.x -= P1.x;
			T2.y -= P1.y;
			T2.z -= P1.z;
			T1.Normalize();
			T2.Normalize();
			T1.x *= this.tension;
			T1.y *= this.tension;
			T1.z *= this.tension;
			T2.x *= this.tension;
			T2.y *= this.tension;
			T2.z *= this.tension;
			return;
		}
		T1 = firstNode.nodeTransform.forward * this.tension;
		T2 = firstNode.NextNode0.nodeTransform.forward * this.tension;
	}

	// Token: 0x06000847 RID: 2119 RVA: 0x00038D34 File Offset: 0x00036F34
	private float GetSegmentLengthInternal(int idxFirstPoint)
	{
		return this.GetSegmentLengthInternal(idxFirstPoint, 0f, 1f, 0.2f);
	}

	// Token: 0x06000848 RID: 2120 RVA: 0x00038D4C File Offset: 0x00036F4C
	private float GetSegmentLengthInternal(int idxFirstPoint, float startValue, float endValue, float step)
	{
		float num = 0f;
		Vector3 a = this.GetPositionInternal(idxFirstPoint, startValue);
		float num2 = endValue + step * 0.5f;
		for (float num3 = startValue + step; num3 < num2; num3 += step)
		{
			Vector3 positionInternal = this.GetPositionInternal(idxFirstPoint, num3);
			num += Vector3.Distance(a, positionInternal);
			a = positionInternal;
		}
		return num;
	}

	// Token: 0x06000849 RID: 2121 RVA: 0x00038DA4 File Offset: 0x00036FA4
	private static Quaternion GetQuatSquad(float t, Quaternion q0, Quaternion q1, Quaternion a0, Quaternion a1)
	{
		float t2 = 2f * t * (1f - t);
		Quaternion p = Spline.QuatSlerp(q0, q1, t);
		Quaternion q2 = Spline.QuatSlerp(a0, a1, t);
		return Spline.QuatSlerp(p, q2, t2);
	}

	// Token: 0x0600084A RID: 2122 RVA: 0x00038DDC File Offset: 0x00036FDC
	private static Quaternion GetSquadIntermediate(Quaternion q0, Quaternion q1, Quaternion q2)
	{
		Quaternion quatConjugate = Spline.GetQuatConjugate(q1);
		Quaternion quatLog = Spline.GetQuatLog(quatConjugate * q0);
		Quaternion quatLog2 = Spline.GetQuatLog(quatConjugate * q2);
		Quaternion q3 = new Quaternion(-0.25f * (quatLog.x + quatLog2.x), -0.25f * (quatLog.y + quatLog2.y), -0.25f * (quatLog.z + quatLog2.z), -0.25f * (quatLog.w + quatLog2.w));
		return q1 * Spline.GetQuatExp(q3);
	}

	// Token: 0x0600084B RID: 2123 RVA: 0x00038E74 File Offset: 0x00037074
	private static Quaternion QuatSlerp(Quaternion p, Quaternion q, float t)
	{
		float num = Quaternion.Dot(p, q);
		Quaternion result;
		if ((double)(1f + num) > 1E-05)
		{
			float num4;
			float num5;
			if ((double)(1f - num) > 1E-05)
			{
				float num2 = Mathf.Acos(num);
				float num3 = 1f / Mathf.Sin(num2);
				num4 = Mathf.Sin((1f - t) * num2) * num3;
				num5 = Mathf.Sin(t * num2) * num3;
			}
			else
			{
				num4 = 1f - t;
				num5 = t;
			}
			result.x = num4 * p.x + num5 * q.x;
			result.y = num4 * p.y + num5 * q.y;
			result.z = num4 * p.z + num5 * q.z;
			result.w = num4 * p.w + num5 * q.w;
		}
		else
		{
			float num6 = Mathf.Sin((1f - t) * 3.1415927f * 0.5f);
			float num7 = Mathf.Sin(t * 3.1415927f * 0.5f);
			result.x = num6 * p.x - num7 * p.y;
			result.y = num6 * p.y + num7 * p.x;
			result.z = num6 * p.z - num7 * p.w;
			result.w = p.z;
		}
		return result;
	}

	// Token: 0x0600084C RID: 2124 RVA: 0x00038FFC File Offset: 0x000371FC
	private static Quaternion GetQuatLog(Quaternion q)
	{
		Quaternion result = q;
		result.w = 0f;
		if (Mathf.Abs(q.w) < 1f)
		{
			float num = Mathf.Acos(q.w);
			float num2 = Mathf.Sin(num);
			if (Mathf.Abs(num2) > 0.0001f)
			{
				float num3 = num / num2;
				result.x = q.x * num3;
				result.y = q.y * num3;
				result.z = q.z * num3;
			}
		}
		return result;
	}

	// Token: 0x0600084D RID: 2125 RVA: 0x00039088 File Offset: 0x00037288
	private static Quaternion GetQuatExp(Quaternion q)
	{
		Quaternion result = q;
		float num = Mathf.Sqrt(q.x * q.x + q.y * q.y + q.z * q.z);
		float num2 = Mathf.Sin(num);
		result.w = Mathf.Cos(num);
		if (Mathf.Abs(num2) > 0.0001f)
		{
			float num3 = num2 / num;
			result.x = num3 * q.x;
			result.y = num3 * q.y;
			result.z = num3 * q.z;
		}
		return result;
	}

	// Token: 0x0600084E RID: 2126 RVA: 0x00039128 File Offset: 0x00037328
	private static Quaternion GetQuatConjugate(Quaternion q)
	{
		return new Quaternion(-q.x, -q.y, -q.z, q.w);
	}

	// Token: 0x04000715 RID: 1813
	public Spline.InterpolationMode interpolationMode;

	// Token: 0x04000716 RID: 1814
	public Spline.ControlNodeMode nodeMode;

	// Token: 0x04000717 RID: 1815
	public Spline.RotationMode rotationMode = Spline.RotationMode.Tangent;

	// Token: 0x04000718 RID: 1816
	public Spline.TangentMode tangentMode = Spline.TangentMode.UseTangents;

	// Token: 0x04000719 RID: 1817
	public Spline.UpdateMode updateMode = Spline.UpdateMode.EveryFrame;

	// Token: 0x0400071A RID: 1818
	public float deltaSeconds = 0.1f;

	// Token: 0x0400071B RID: 1819
	public int deltaFrames = 2;

	// Token: 0x0400071C RID: 1820
	public Vector3 tanUpVector = Vector3.up;

	// Token: 0x0400071D RID: 1821
	public float tension = 0.5f;

	// Token: 0x0400071E RID: 1822
	public bool autoClose;

	// Token: 0x0400071F RID: 1823
	public int interpolationAccuracy = 1;

	// Token: 0x04000720 RID: 1824
	public Transform[] splineNodesTransform;

	// Token: 0x04000721 RID: 1825
	public float[] subSegmentLength;

	// Token: 0x04000722 RID: 1826
	public float[] subSegmentPosition;

	// Token: 0x04000723 RID: 1827
	public float splineLength;

	// Token: 0x04000724 RID: 1828
	private float passedTime;

	// Token: 0x04000725 RID: 1829
	public SplineNode[] splineNodes;

	// Token: 0x020000C4 RID: 196
	public enum ControlNodeMode
	{
		// Token: 0x04000728 RID: 1832
		UseChildren,
		// Token: 0x04000729 RID: 1833
		UseArray
	}

	// Token: 0x020000C5 RID: 197
	public enum TangentMode
	{
		// Token: 0x0400072B RID: 1835
		UseNormalizedTangents,
		// Token: 0x0400072C RID: 1836
		UseTangents,
		// Token: 0x0400072D RID: 1837
		UseNodeForwardVector
	}

	// Token: 0x020000C6 RID: 198
	public enum RotationMode
	{
		// Token: 0x0400072F RID: 1839
		None,
		// Token: 0x04000730 RID: 1840
		Node,
		// Token: 0x04000731 RID: 1841
		Tangent
	}

	// Token: 0x020000C7 RID: 199
	public enum InterpolationMode
	{
		// Token: 0x04000733 RID: 1843
		Hermite,
		// Token: 0x04000734 RID: 1844
		Bezier,
		// Token: 0x04000735 RID: 1845
		BSpline
	}

	// Token: 0x020000C8 RID: 200
	public enum UpdateMode
	{
		// Token: 0x04000737 RID: 1847
		DontUpdate,
		// Token: 0x04000738 RID: 1848
		EveryFrame,
		// Token: 0x04000739 RID: 1849
		EveryXFrames,
		// Token: 0x0400073A RID: 1850
		EveryXSeconds
	}
}
