using System;
using UnityEngine;

// Token: 0x0200009A RID: 154
public class CactusPlacer : MonoBehaviour
{
	// Token: 0x060006A2 RID: 1698 RVA: 0x0002A788 File Offset: 0x00028988
	private void Awake()
	{
		CactusPlacer.instance = this;
		this.playerRef = PhoneInterface.player_trans;
		CactusBehavior.cactusBreaks = 0;
		CactusBehavior.recentCactusBreaks = 0;
	}

	// Token: 0x060006A3 RID: 1699 RVA: 0x0002A7A8 File Offset: 0x000289A8
	private void FixedUpdate()
	{
		this.SpawnCactus();
	}

	// Token: 0x060006A4 RID: 1700 RVA: 0x0002A7B0 File Offset: 0x000289B0
	private void SpawnCactus()
	{
		int min = -2000;
		int max = 2000;
		int min2 = -800;
		int max2 = 800;
		int min3 = 1200;
		int max3 = 2500;
		int min4 = 150;
		int max4 = 1000;
		if (this.currentNum < CactusPlacer.staticNum)
		{
			Vector3 a;
			if (UnityEngine.Random.Range(0, 10) > 3)
			{
				a = this.playerRef.position + this.playerRef.forward * (float)UnityEngine.Random.Range(min3, max3) + this.playerRef.right * (float)UnityEngine.Random.Range(min, max);
			}
			else
			{
				a = this.playerRef.position + -this.playerRef.forward * (float)UnityEngine.Random.Range(min4, max4) + this.playerRef.right * (float)UnityEngine.Random.Range(min2, max2);
			}
			RaycastHit raycastHit;
			if (Physics.Linecast(a + Vector3.up * (float)this.height * 2f, a + Vector3.down * (float)this.height, out raycastHit) && raycastHit.collider.name == "Terrain")
			{
				Transform original = this.prefab;
				if (this.mirageCatPrefab && UnityEngine.Random.Range(0f, 100f) <= this.mirageChance * 100f)
				{
					original = this.mirageCatPrefab;
				}
				Transform transform = UnityEngine.Object.Instantiate(original, new Vector3(raycastHit.point.x, raycastHit.point.y - 1f, raycastHit.point.z), Quaternion.identity) as Transform;
				transform.parent = base.transform;
				this.currentNum++;
			}
		}
	}

	// Token: 0x0400054D RID: 1357
	public int num = 1000;

	// Token: 0x0400054E RID: 1358
	public int minWidth;

	// Token: 0x0400054F RID: 1359
	public int maxWidth = 10000;

	// Token: 0x04000550 RID: 1360
	public int minLength;

	// Token: 0x04000551 RID: 1361
	public int maxLength = 10000;

	// Token: 0x04000552 RID: 1362
	public Transform prefab;

	// Token: 0x04000553 RID: 1363
	private int height = 10000;

	// Token: 0x04000554 RID: 1364
	private static int staticNum = 40;

	// Token: 0x04000555 RID: 1365
	public int currentNum;

	// Token: 0x04000556 RID: 1366
	private Transform playerRef;

	// Token: 0x04000557 RID: 1367
	public static CactusPlacer instance;

	// Token: 0x04000558 RID: 1368
	public Transform mirageCatPrefab;

	// Token: 0x04000559 RID: 1369
	public float mirageChance = 0.01f;
}
