using System;
using UnityEngine;

// Token: 0x020000CA RID: 202
[RequireComponent(typeof(MeshFilter))]
[ExecuteInEditMode]
public class SplineMesh : MonoBehaviour
{
	// Token: 0x170000FB RID: 251
	// (get) Token: 0x06000853 RID: 2131 RVA: 0x000391C0 File Offset: 0x000373C0
	public Mesh BentMesh
	{
		get
		{
			return this.bentMesh;
		}
	}

	// Token: 0x06000854 RID: 2132 RVA: 0x000391C8 File Offset: 0x000373C8
	private void Start()
	{
		if (this.spline == null)
		{
			return;
		}
		this.spline.UpdateSplineNodes();
		this.UpdateMesh();
	}

	// Token: 0x06000855 RID: 2133 RVA: 0x000391F0 File Offset: 0x000373F0
	private void OnEnable()
	{
		if (this.spline == null)
		{
			return;
		}
		this.spline.UpdateSplineNodes();
		this.UpdateMesh();
	}

	// Token: 0x06000856 RID: 2134 RVA: 0x00039218 File Offset: 0x00037418
	private void LateUpdate()
	{
		switch (this.uMode)
		{
		case Spline.UpdateMode.EveryFrame:
			this.UpdateMesh();
			break;
		case Spline.UpdateMode.EveryXFrames:
			if (this.deltaFrames <= 0)
			{
				this.deltaFrames = 1;
			}
			if (Time.frameCount % this.deltaFrames == 0)
			{
				this.UpdateMesh();
			}
			break;
		case Spline.UpdateMode.EveryXSeconds:
			this.passedTime += Time.deltaTime;
			if (this.passedTime >= this.deltaSeconds)
			{
				this.UpdateMesh();
				this.passedTime = 0f;
			}
			break;
		}
	}

	// Token: 0x06000857 RID: 2135 RVA: 0x000392B8 File Offset: 0x000374B8
	public void UpdateMesh()
	{
		this.Setup();
		if (this.BentMesh)
		{
			this.BentMesh.Clear();
		}
		if (this.baseMesh == null || this.spline == null || this.segmentCount <= 0)
		{
			return;
		}
		Vector3[] vertices = this.baseMesh.vertices;
		Vector3[] normals = this.baseMesh.normals;
		Vector4[] tangents = this.baseMesh.tangents;
		Vector2[] uv = this.baseMesh.uv;
		int[] triangles = this.baseMesh.triangles;
		Vector3[] array = new Vector3[vertices.Length * this.segmentCount];
		Vector3[] array2 = new Vector3[normals.Length * this.segmentCount];
		Vector4[] array3 = new Vector4[tangents.Length * this.segmentCount];
		Vector2[] array4 = new Vector2[uv.Length * this.segmentCount];
		int[] array5 = new int[triangles.Length * this.segmentCount];
		if (this.splineSegment >= 0 && this.splineSegment < this.spline.SegmentCount)
		{
			SplineSegment splineSegment = this.spline.SplineSegments[this.splineSegment];
			int num = 0;
			for (int i = 0; i < this.segmentCount; i++)
			{
				float num2 = (float)i / (float)this.segmentCount;
				float num3 = (float)(i + 1) / (float)this.segmentCount;
				if (num3 == 1f)
				{
					num3 -= 1E-05f;
				}
				num2 = splineSegment.ConvertSegmentToSplineParamter(num2);
				num3 = splineSegment.ConvertSegmentToSplineParamter(num3);
				this.CalculateBentMeshSub(ref num, num2, num3, vertices, normals, tangents, uv, array, array2, array3, array4);
				for (int j = 0; j < triangles.Length; j++)
				{
					array5[j + i * triangles.Length] = triangles[j] + vertices.Length * i;
				}
			}
			this.BentMesh.vertices = array;
			this.BentMesh.uv = array4;
			if (normals.Length > 0)
			{
				this.BentMesh.normals = array2;
			}
			if (tangents.Length > 0)
			{
				this.BentMesh.tangents = array3;
			}
			this.BentMesh.triangles = array5;
		}
		else
		{
			int num4 = 0;
			for (int k = 0; k < this.segmentCount; k++)
			{
				float param = (float)k / (float)this.segmentCount;
				float num5 = (float)(k + 1) / (float)this.segmentCount;
				if (num5 == 1f)
				{
					num5 -= 1E-05f;
				}
				this.CalculateBentMeshSub(ref num4, param, num5, vertices, normals, tangents, uv, array, array2, array3, array4);
				for (int l = 0; l < triangles.Length; l++)
				{
					array5[l + k * triangles.Length] = triangles[l] + vertices.Length * k;
				}
			}
			this.BentMesh.vertices = array;
			this.BentMesh.uv = array4;
			if (normals.Length > 0)
			{
				this.BentMesh.normals = array2;
			}
			if (tangents.Length > 0)
			{
				this.BentMesh.tangents = array3;
			}
			this.BentMesh.triangles = array5;
		}
	}

	// Token: 0x06000858 RID: 2136 RVA: 0x000395D4 File Offset: 0x000377D4
	private void Setup()
	{
		if (this.spline == null)
		{
			return;
		}
		if (this.bentMesh == null)
		{
			this.bentMesh = new Mesh();
			this.bentMesh.name = "BentMesh";
			this.bentMesh.hideFlags = HideFlags.HideAndDontSave;
		}
		MeshFilter component = base.GetComponent<MeshFilter>();
		if (component.sharedMesh != this.BentMesh)
		{
			component.sharedMesh = this.BentMesh;
		}
		MeshCollider component2 = base.GetComponent<MeshCollider>();
		if (component2 != null)
		{
			component2.sharedMesh = null;
			component2.sharedMesh = this.BentMesh;
		}
	}

	// Token: 0x06000859 RID: 2137 RVA: 0x0003967C File Offset: 0x0003787C
	private void CalculateBentMeshSub(ref int vIndex, float param0, float param1, Vector3[] verticesBase, Vector3[] normalsBase, Vector4[] tangentsBase, Vector2[] uvBase, Vector3[] verticesNew, Vector3[] normalsNew, Vector4[] tangentsNew, Vector2[] uvNew)
	{
		Vector3 from = this.spline.transform.InverseTransformPoint(this.spline.GetPositionOnSpline(param0));
		Vector3 to = this.spline.transform.InverseTransformPoint(this.spline.GetPositionOnSpline(param1));
		Quaternion from2 = this.spline.GetOrientationOnSpline(param0) * Quaternion.Inverse(this.spline.transform.localRotation);
		Quaternion to2 = this.spline.GetOrientationOnSpline(param1) * Quaternion.Inverse(this.spline.transform.localRotation);
		for (int i = 0; i < verticesBase.Length; i++)
		{
			Vector3 vector = verticesBase[i];
			Vector3 v = uvBase[i];
			Vector3 vector2;
			if (normalsBase.Length > 0)
			{
				vector2 = normalsBase[i];
			}
			else
			{
				vector2 = Vector3.zero;
			}
			Vector3 vector3;
			if (tangentsBase.Length > 0)
			{
				vector3 = tangentsBase[i];
			}
			else
			{
				vector3 = Vector3.zero;
			}
			float t = vector.z + 0.5f;
			vector.z = 0f;
			vector.Scale(new Vector3(this.xyScale[0], this.xyScale[1], 1f));
			vector = Quaternion.Lerp(from2, to2, t) * vector;
			vector += Vector3.Lerp(from, to, t);
			vector2 = Quaternion.Lerp(from2, to2, t) * vector2;
			vector3 = Quaternion.Lerp(from2, to2, t) * vector3;
			SplineMesh.UVMode uvmode = this.uvMode;
			if (uvmode != SplineMesh.UVMode.Normal)
			{
				if (uvmode == SplineMesh.UVMode.Swap)
				{
					v.x = Mathf.Lerp(param0, param1, t);
				}
			}
			else
			{
				v.y = Mathf.Lerp(param0, param1, t);
			}
			verticesNew[vIndex] = vector;
			uvNew[vIndex] = Vector2.Scale(v, this.uvScale);
			if (normalsBase.Length > 0)
			{
				normalsNew[vIndex] = vector2;
			}
			if (tangentsBase.Length > 0)
			{
				tangentsNew[vIndex] = vector3;
			}
			vIndex++;
		}
	}

	// Token: 0x0400073B RID: 1851
	public Spline spline;

	// Token: 0x0400073C RID: 1852
	public Spline.UpdateMode uMode;

	// Token: 0x0400073D RID: 1853
	public float deltaSeconds = 0.1f;

	// Token: 0x0400073E RID: 1854
	public int deltaFrames = 2;

	// Token: 0x0400073F RID: 1855
	public Mesh baseMesh;

	// Token: 0x04000740 RID: 1856
	public int segmentCount = 100;

	// Token: 0x04000741 RID: 1857
	public Vector2 xyScale = Vector2.one;

	// Token: 0x04000742 RID: 1858
	public Vector2 uvScale = Vector2.one;

	// Token: 0x04000743 RID: 1859
	public SplineMesh.UVMode uvMode;

	// Token: 0x04000744 RID: 1860
	public int splineSegment = -1;

	// Token: 0x04000745 RID: 1861
	private Mesh bentMesh;

	// Token: 0x04000746 RID: 1862
	private float passedTime;

	// Token: 0x020000CB RID: 203
	public enum UVMode
	{
		// Token: 0x04000748 RID: 1864
		Normal,
		// Token: 0x04000749 RID: 1865
		Swap,
		// Token: 0x0400074A RID: 1866
		DontInterpolate
	}
}
