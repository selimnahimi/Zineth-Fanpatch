using System;
using UnityEngine;

// Token: 0x020000CC RID: 204
public class SplineNode
{
	// Token: 0x0600085A RID: 2138 RVA: 0x000398E8 File Offset: 0x00037AE8
	public SplineNode(Transform controlPoint)
	{
		this.adjacentNodes = new SplineNode[4];
		this.nodeTransform = controlPoint;
	}

	// Token: 0x170000FC RID: 252
	public SplineNode this[int idx]
	{
		get
		{
			return this.adjacentNodes[idx];
		}
		set
		{
			if (value != null)
			{
				this.adjacentNodes[idx] = value;
			}
		}
	}

	// Token: 0x170000FD RID: 253
	// (get) Token: 0x0600085D RID: 2141 RVA: 0x00039924 File Offset: 0x00037B24
	// (set) Token: 0x0600085E RID: 2142 RVA: 0x00039930 File Offset: 0x00037B30
	public SplineNode PrevNode0
	{
		get
		{
			return this.adjacentNodes[0];
		}
		set
		{
			if (value != null)
			{
				this.adjacentNodes[0] = value;
			}
		}
	}

	// Token: 0x170000FE RID: 254
	// (get) Token: 0x0600085F RID: 2143 RVA: 0x00039944 File Offset: 0x00037B44
	// (set) Token: 0x06000860 RID: 2144 RVA: 0x00039950 File Offset: 0x00037B50
	public SplineNode NextNode0
	{
		get
		{
			return this.adjacentNodes[1];
		}
		set
		{
			if (value != null)
			{
				this.adjacentNodes[1] = value;
			}
		}
	}

	// Token: 0x170000FF RID: 255
	// (get) Token: 0x06000861 RID: 2145 RVA: 0x00039964 File Offset: 0x00037B64
	// (set) Token: 0x06000862 RID: 2146 RVA: 0x00039970 File Offset: 0x00037B70
	public SplineNode NextNode1
	{
		get
		{
			return this.adjacentNodes[2];
		}
		set
		{
			if (value != null)
			{
				this.adjacentNodes[2] = value;
			}
		}
	}

	// Token: 0x17000100 RID: 256
	// (get) Token: 0x06000863 RID: 2147 RVA: 0x00039984 File Offset: 0x00037B84
	// (set) Token: 0x06000864 RID: 2148 RVA: 0x00039990 File Offset: 0x00037B90
	public SplineNode NextNode2
	{
		get
		{
			return this.adjacentNodes[3];
		}
		set
		{
			if (value != null)
			{
				this.adjacentNodes[3] = value;
			}
		}
	}

	// Token: 0x17000101 RID: 257
	// (get) Token: 0x06000865 RID: 2149 RVA: 0x000399A4 File Offset: 0x00037BA4
	// (set) Token: 0x06000866 RID: 2150 RVA: 0x000399B4 File Offset: 0x00037BB4
	public Vector3 Position
	{
		get
		{
			return this.nodeTransform.position;
		}
		set
		{
			this.nodeTransform.position = value;
		}
	}

	// Token: 0x17000102 RID: 258
	// (get) Token: 0x06000867 RID: 2151 RVA: 0x000399C4 File Offset: 0x00037BC4
	// (set) Token: 0x06000868 RID: 2152 RVA: 0x000399D4 File Offset: 0x00037BD4
	public Quaternion Rotation
	{
		get
		{
			return this.nodeTransform.rotation;
		}
		set
		{
			this.nodeTransform.rotation = value;
		}
	}

	// Token: 0x06000869 RID: 2153 RVA: 0x000399E4 File Offset: 0x00037BE4
	public bool CheckReferences()
	{
		return this.nodeTransform != null && this.adjacentNodes[0] != null && this.adjacentNodes[1] != null && this.adjacentNodes[2] != null && this.adjacentNodes[3] != null;
	}

	// Token: 0x0400074B RID: 1867
	public Transform nodeTransform;

	// Token: 0x0400074C RID: 1868
	public float posInSpline;

	// Token: 0x0400074D RID: 1869
	public float length;

	// Token: 0x0400074E RID: 1870
	public SplineNode[] adjacentNodes;
}
