using System;

// Token: 0x020000CD RID: 205
public class SplineSegment
{
	// Token: 0x0600086A RID: 2154 RVA: 0x00039A3C File Offset: 0x00037C3C
	public SplineSegment(Spline pSpline, SplineNode sNode, SplineNode eNode)
	{
		if ((sNode.NextNode0 == eNode || sNode.NextNode2 == eNode) && pSpline != null)
		{
			this.parentSpline = pSpline;
			this.startNode = sNode;
			this.endNode = eNode;
		}
		else
		{
			this.parentSpline = null;
			this.startNode = null;
			this.endNode = null;
		}
	}

	// Token: 0x17000103 RID: 259
	// (get) Token: 0x0600086B RID: 2155 RVA: 0x00039AA4 File Offset: 0x00037CA4
	public Spline ParentSpline
	{
		get
		{
			return this.parentSpline;
		}
	}

	// Token: 0x17000104 RID: 260
	// (get) Token: 0x0600086C RID: 2156 RVA: 0x00039AAC File Offset: 0x00037CAC
	public SplineNode StartNode
	{
		get
		{
			return this.startNode;
		}
	}

	// Token: 0x17000105 RID: 261
	// (get) Token: 0x0600086D RID: 2157 RVA: 0x00039AB4 File Offset: 0x00037CB4
	public SplineNode EndNode
	{
		get
		{
			return this.endNode;
		}
	}

	// Token: 0x17000106 RID: 262
	// (get) Token: 0x0600086E RID: 2158 RVA: 0x00039ABC File Offset: 0x00037CBC
	public float Length
	{
		get
		{
			return this.startNode.length * this.parentSpline.Length;
		}
	}

	// Token: 0x17000107 RID: 263
	// (get) Token: 0x0600086F RID: 2159 RVA: 0x00039AD8 File Offset: 0x00037CD8
	public float NormalizedLength
	{
		get
		{
			return this.startNode.length;
		}
	}

	// Token: 0x06000870 RID: 2160 RVA: 0x00039AE8 File Offset: 0x00037CE8
	public float ConvertSegmentToSplineParamter(float param)
	{
		return this.startNode.posInSpline + param * this.startNode.length;
	}

	// Token: 0x06000871 RID: 2161 RVA: 0x00039B04 File Offset: 0x00037D04
	public float ConvertSplineToSegmentParamter(float param)
	{
		if (param < this.startNode.posInSpline)
		{
			return 0f;
		}
		if (param >= this.endNode.posInSpline)
		{
			return 1f;
		}
		return (param - this.startNode.posInSpline) / this.startNode.length;
	}

	// Token: 0x06000872 RID: 2162 RVA: 0x00039B58 File Offset: 0x00037D58
	public float ClampParameterToSegment(float param)
	{
		if (param < this.startNode.posInSpline)
		{
			return this.startNode.posInSpline;
		}
		if (param >= this.endNode.posInSpline)
		{
			return this.endNode.posInSpline;
		}
		return param;
	}

	// Token: 0x0400074F RID: 1871
	private readonly Spline parentSpline;

	// Token: 0x04000750 RID: 1872
	private readonly SplineNode startNode;

	// Token: 0x04000751 RID: 1873
	private readonly SplineNode endNode;
}
