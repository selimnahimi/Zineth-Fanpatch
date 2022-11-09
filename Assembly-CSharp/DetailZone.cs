using System;
using UnityEngine;

// Token: 0x020000A0 RID: 160
public class DetailZone : MonoBehaviour
{
	// Token: 0x060006C5 RID: 1733 RVA: 0x0002BED8 File Offset: 0x0002A0D8
	private void Start()
	{
		if (this.on_collider)
		{
			CollisionChecker collisionChecker = this.on_collider.GetComponent<CollisionChecker>();
			if (collisionChecker == null)
			{
				collisionChecker = this.on_collider.gameObject.AddComponent<CollisionChecker>();
			}
			collisionChecker.TriggerEnterDelegate = new CollisionChecker.OnTriggerEnterDelegate(this.OnTrigger);
		}
		if (this.off_collider)
		{
			CollisionChecker collisionChecker2 = this.off_collider.GetComponent<CollisionChecker>();
			if (collisionChecker2 == null)
			{
				collisionChecker2 = this.off_collider.gameObject.AddComponent<CollisionChecker>();
			}
			collisionChecker2.TriggerExitDelegate = new CollisionChecker.OnTriggerExitDelegate(this.OffTrigger);
		}
		this.SetState(this.starting_state);
	}

	// Token: 0x060006C6 RID: 1734 RVA: 0x0002BF88 File Offset: 0x0002A188
	public void TurnOn()
	{
		this.SetState(true);
	}

	// Token: 0x060006C7 RID: 1735 RVA: 0x0002BF94 File Offset: 0x0002A194
	public void TurnOff()
	{
		this.SetState(false);
	}

	// Token: 0x060006C8 RID: 1736 RVA: 0x0002BFA0 File Offset: 0x0002A1A0
	public void SetState(bool state)
	{
		foreach (GameObject gameObject in this.objects)
		{
			gameObject.SetActiveRecursively(state);
		}
	}

	// Token: 0x060006C9 RID: 1737 RVA: 0x0002BFD4 File Offset: 0x0002A1D4
	public void OnTrigger(Collider other)
	{
		if (other.name == "Player")
		{
			this.SetState(this.active_inside);
		}
	}

	// Token: 0x060006CA RID: 1738 RVA: 0x0002BFF8 File Offset: 0x0002A1F8
	public void OffTrigger(Collider other)
	{
		if (other.name == "Player")
		{
			this.SetState(!this.active_inside);
		}
	}

	// Token: 0x0400059A RID: 1434
	public GameObject[] objects = new GameObject[0];

	// Token: 0x0400059B RID: 1435
	public bool active_inside = true;

	// Token: 0x0400059C RID: 1436
	public bool starting_state;

	// Token: 0x0400059D RID: 1437
	public Collider on_collider;

	// Token: 0x0400059E RID: 1438
	public Collider off_collider;
}
