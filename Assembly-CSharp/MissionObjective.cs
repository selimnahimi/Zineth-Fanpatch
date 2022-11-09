using System;
using UnityEngine;

// Token: 0x02000022 RID: 34
public class MissionObjective : MonoBehaviour
{
	// Token: 0x1700001C RID: 28
	// (get) Token: 0x060000F4 RID: 244 RVA: 0x00008AB4 File Offset: 0x00006CB4
	public Vector3 objectivePosition
	{
		get
		{
			return base.transform.position;
		}
	}

	// Token: 0x060000F5 RID: 245 RVA: 0x00008AC4 File Offset: 0x00006CC4
	private void Awake()
	{
		this.Setup();
	}

	// Token: 0x060000F6 RID: 246 RVA: 0x00008ACC File Offset: 0x00006CCC
	public virtual void Setup()
	{
		if (!MissionObjective.player)
		{
			MissionObjective.player = PhoneInterface.player_trans;
		}
		if (this.requireTrigger && !this.triggerCollider)
		{
			this.triggerCollider = base.GetComponentInChildren<Collider>();
		}
		if (this.triggerCollider)
		{
			CollisionChecker collisionChecker = this.triggerCollider.gameObject.AddComponent<CollisionChecker>();
			collisionChecker.TriggerEnterDelegate = new CollisionChecker.OnTriggerEnterDelegate(this.TriggerEnter);
			collisionChecker.TriggerExitDelegate = new CollisionChecker.OnTriggerExitDelegate(this.TriggerExit);
		}
		if (!MissionObjective._playerMove && MissionObjective.player)
		{
			MissionObjective._playerMove = MissionObjective.player.GetComponent<move>();
		}
	}

	// Token: 0x060000F7 RID: 247 RVA: 0x00008B90 File Offset: 0x00006D90
	public virtual bool CheckCompleted()
	{
		if (this.show_guitext)
		{
			this.DoGUIText();
		}
		return this.CheckTriggered() && this.CheckConditions() && this.CheckGrounded();
	}

	// Token: 0x060000F8 RID: 248 RVA: 0x00008BD0 File Offset: 0x00006DD0
	public virtual bool CheckConditions()
	{
		this.condition_progress = 0;
		foreach (MissionObjective missionObjective in this.completeCondition)
		{
			if (!missionObjective.completed)
			{
				return false;
			}
			this.condition_progress++;
		}
		return true;
	}

	// Token: 0x060000F9 RID: 249 RVA: 0x00008C20 File Offset: 0x00006E20
	public virtual bool CheckTriggered()
	{
		bool result = !this.requireTrigger || this.triggered;
		if (this._has_left)
		{
			this._has_left = false;
			this.triggered = false;
		}
		return result;
	}

	// Token: 0x060000FA RID: 250 RVA: 0x00008C5C File Offset: 0x00006E5C
	public virtual bool CheckGrounded()
	{
		if (this.requireGrounded)
		{
			return MissionObjective._playerMove.grounded;
		}
		return !this.requireNotGrounded || !MissionObjective._playerMove.grounded;
	}

	// Token: 0x060000FB RID: 251 RVA: 0x00008C9C File Offset: 0x00006E9C
	public virtual void OnBegin()
	{
		this.triggered = false;
		this.completed = false;
		this.failed = false;
		base.gameObject.SetActiveRecursively(true);
		if (this.clearRewindOnStart)
		{
			SpawnPointScript.instance.ClearSpawns();
		}
	}

	// Token: 0x060000FC RID: 252 RVA: 0x00008CE0 File Offset: 0x00006EE0
	public virtual void OnCompleted()
	{
		if (this.play_sound)
		{
			this.PlayCompletedSound();
		}
		if (this.throw_zine)
		{
			for (int i = 0; i < 8; i++)
			{
				this.ThrowZine();
			}
		}
		foreach (Transform transform in this.destroy_on_end)
		{
			transform.gameObject.SetActiveRecursively(false);
		}
		base.gameObject.active = false;
		if (this.clearRewindOnComplete)
		{
			SpawnPointScript.instance.ClearSpawns();
		}
	}

	// Token: 0x060000FD RID: 253 RVA: 0x00008D70 File Offset: 0x00006F70
	public virtual void OnEnd()
	{
		foreach (Transform transform in this.unparent_on_end)
		{
			if (transform)
			{
				transform.parent = null;
			}
		}
		foreach (Transform transform2 in this.destroy_on_end)
		{
			if (transform2)
			{
				UnityEngine.Object.Destroy(transform2.gameObject);
			}
		}
		base.gameObject.active = false;
	}

	// Token: 0x060000FE RID: 254 RVA: 0x00008DF8 File Offset: 0x00006FF8
	public virtual string GetText()
	{
		return this.ParseGUIString(this.objectiveName);
	}

	// Token: 0x060000FF RID: 255 RVA: 0x00008E08 File Offset: 0x00007008
	public virtual string ParseGUIString(string guistring)
	{
		guistring = guistring.Replace("{cond_progress}", this.condition_progress.ToString());
		guistring = guistring.Replace("{cond_progress+}", (this.condition_progress + 1).ToString());
		guistring = guistring.Replace("{cond_total}", this.completeCondition.Length.ToString());
		return guistring;
	}

	// Token: 0x06000100 RID: 256 RVA: 0x00008E68 File Offset: 0x00007068
	public virtual void DoGUIText()
	{
		MissionController.guitext = MissionController.guitext + this.GetText() + "\n";
	}

	// Token: 0x06000101 RID: 257 RVA: 0x00008E84 File Offset: 0x00007084
	public virtual void ThrowZine()
	{
		ThrownZine thrown_zine_prefab;
		if (this.zine_prefab)
		{
			thrown_zine_prefab = this.zine_prefab;
		}
		else
		{
			thrown_zine_prefab = MissionController.thrown_zine_prefab;
		}
		Vector3 position = MissionObjective.player.position + MissionObjective.player.up * 0.8f + MissionObjective.player.forward * 1f;
		ThrownZine thrownZine = UnityEngine.Object.Instantiate(thrown_zine_prefab, position, MissionObjective.player.rotation) as ThrownZine;
		thrownZine.Init(MissionObjective.player.rigidbody.velocity);
	}

	// Token: 0x06000102 RID: 258 RVA: 0x00008F1C File Offset: 0x0000711C
	public virtual void PlayCompletedSound()
	{
		AudioClip checkpoint_sound;
		if (this.sound_clip)
		{
			checkpoint_sound = this.sound_clip;
		}
		else
		{
			checkpoint_sound = MissionController.checkpoint_sound;
		}
		if (checkpoint_sound == null)
		{
			return;
		}
		AudioSource.PlayClipAtPoint(checkpoint_sound, Camera.main.transform.position);
	}

	// Token: 0x06000103 RID: 259 RVA: 0x00008F70 File Offset: 0x00007170
	protected virtual void TriggerEnter(Collider other)
	{
		if (other.gameObject.name == "Player")
		{
			this.triggered = true;
		}
	}

	// Token: 0x06000104 RID: 260 RVA: 0x00008F94 File Offset: 0x00007194
	protected virtual void TriggerExit(Collider other)
	{
		if (other.gameObject.name == "Player")
		{
			this._has_left = true;
		}
	}

	// Token: 0x04000150 RID: 336
	public bool completed;

	// Token: 0x04000151 RID: 337
	public bool failed;

	// Token: 0x04000152 RID: 338
	public float timeLimit = -1f;

	// Token: 0x04000153 RID: 339
	public bool use_position = true;

	// Token: 0x04000154 RID: 340
	public bool block_next = true;

	// Token: 0x04000155 RID: 341
	public bool play_sound = true;

	// Token: 0x04000156 RID: 342
	private AudioClip sound_clip;

	// Token: 0x04000157 RID: 343
	public bool throw_zine;

	// Token: 0x04000158 RID: 344
	public ThrownZine zine_prefab;

	// Token: 0x04000159 RID: 345
	public string objectiveName;

	// Token: 0x0400015A RID: 346
	public static Transform player;

	// Token: 0x0400015B RID: 347
	public bool requireTrigger;

	// Token: 0x0400015C RID: 348
	public bool triggered;

	// Token: 0x0400015D RID: 349
	public Collider triggerCollider;

	// Token: 0x0400015E RID: 350
	public bool requireGrounded;

	// Token: 0x0400015F RID: 351
	public bool requireNotGrounded;

	// Token: 0x04000160 RID: 352
	public bool clearRewindOnStart;

	// Token: 0x04000161 RID: 353
	public bool clearRewindOnComplete;

	// Token: 0x04000162 RID: 354
	public bool show_guitext;

	// Token: 0x04000163 RID: 355
	public bool skipAsCurrent;

	// Token: 0x04000164 RID: 356
	public MissionObjective[] completeCondition;

	// Token: 0x04000165 RID: 357
	public static move _playerMove;

	// Token: 0x04000166 RID: 358
	private int condition_progress;

	// Token: 0x04000167 RID: 359
	public Transform[] unparent_on_end;

	// Token: 0x04000168 RID: 360
	public Transform[] destroy_on_end;

	// Token: 0x04000169 RID: 361
	private bool _has_left;
}
