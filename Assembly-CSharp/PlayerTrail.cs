using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000098 RID: 152
public class PlayerTrail : MonoBehaviour
{
	// Token: 0x06000692 RID: 1682 RVA: 0x00029FA8 File Offset: 0x000281A8
	private void Awake()
	{
		this.currentTime = this.decayTime;
		foreach (Transform transform in this.trailHolderList)
		{
			GameObject gameObject = new GameObject("trailHolder");
			gameObject.transform.position = transform.position;
			this.holderObjectList.Add(gameObject);
			gameObject.layer = 2;
			gameObject.AddComponent<TrailRenderer>();
			gameObject.GetComponent<TrailRenderer>().material = this.trailMaterial;
			gameObject.GetComponent<TrailRenderer>().startWidth = this.startWidth;
			gameObject.GetComponent<TrailRenderer>().endWidth = this.endWidth;
			gameObject.GetComponent<TrailRenderer>().time = this.decayTime;
			gameObject.transform.parent = transform;
			this.trailList.Add(gameObject.GetComponent<TrailRenderer>());
			this.lastPointList.Add(transform.position);
		}
		this.color = this.color;
	}

	// Token: 0x170000D9 RID: 217
	// (get) Token: 0x06000693 RID: 1683 RVA: 0x0002A0C8 File Offset: 0x000282C8
	// (set) Token: 0x06000694 RID: 1684 RVA: 0x0002A10C File Offset: 0x0002830C
	public Color color
	{
		get
		{
			if (!PlayerTrail._set_color)
			{
				PlayerTrail._color = this.trailList[0].renderer.material.color;
				PlayerTrail._set_color = true;
			}
			return PlayerTrail._color;
		}
		set
		{
			value.a = this.color.a;
			PlayerTrail._color = value;
			foreach (TrailRenderer trailRenderer in this.trailList)
			{
				trailRenderer.renderer.material.color = this.color;
			}
		}
	}

	// Token: 0x06000695 RID: 1685 RVA: 0x0002A19C File Offset: 0x0002839C
	public void SetColor(Color col)
	{
		this.color = col;
	}

	// Token: 0x04000532 RID: 1330
	public float decayTime;

	// Token: 0x04000533 RID: 1331
	public Material trailMaterial;

	// Token: 0x04000534 RID: 1332
	public float startWidth;

	// Token: 0x04000535 RID: 1333
	public float endWidth;

	// Token: 0x04000536 RID: 1334
	public List<Transform> trailHolderList = new List<Transform>();

	// Token: 0x04000537 RID: 1335
	public List<GameObject> holderObjectList = new List<GameObject>();

	// Token: 0x04000538 RID: 1336
	public List<TrailRenderer> trailList = new List<TrailRenderer>();

	// Token: 0x04000539 RID: 1337
	public List<Vector3> lastPointList = new List<Vector3>();

	// Token: 0x0400053A RID: 1338
	private int trailLength = 1;

	// Token: 0x0400053B RID: 1339
	private float currentTime;

	// Token: 0x0400053C RID: 1340
	private static bool _set_color;

	// Token: 0x0400053D RID: 1341
	private static Color _color;
}
