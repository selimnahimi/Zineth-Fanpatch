using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

// Token: 0x020000B9 RID: 185
public class SpawnPointScript : MonoBehaviour
{
	// Token: 0x170000EB RID: 235
	// (get) Token: 0x060007DD RID: 2013 RVA: 0x000342C8 File Offset: 0x000324C8
	private move moveScript
	{
		get
		{
			return PhoneInterface.player_move;
		}
	}

	// Token: 0x170000EC RID: 236
	// (get) Token: 0x060007DE RID: 2014 RVA: 0x000342D0 File Offset: 0x000324D0
	public static SpawnPointScript instance
	{
		get
		{
			if (!SpawnPointScript._instance)
			{
				SpawnPointScript._instance = (UnityEngine.Object.FindObjectOfType(typeof(SpawnPointScript)) as SpawnPointScript);
			}
			return SpawnPointScript._instance;
		}
	}

	// Token: 0x060007DF RID: 2015 RVA: 0x00034300 File Offset: 0x00032500
	private void Awake()
	{
		if (SpawnPointScript.trailTime == 0f)
		{
			SpawnPointScript.trailTime = PhoneInterface.playerTrail.trailList[0].time;
		}
		base.StartCoroutine(this.DoAwake());
	}

	// Token: 0x170000ED RID: 237
	// (get) Token: 0x060007E0 RID: 2016 RVA: 0x00034344 File Offset: 0x00032544
	public static string filePath
	{
		get
		{
			return Path.Combine(Application.dataPath, Path.Combine("whatever", "Bundles"));
		}
	}

	// Token: 0x060007E1 RID: 2017 RVA: 0x00034360 File Offset: 0x00032560
	public static void GetBundles()
	{
		string filePath = SpawnPointScript.filePath;
		if (Directory.Exists(filePath))
		{
			SpawnPointScript.bundlenames = Directory.GetFiles(filePath);
		}
		else
		{
			Debug.Log("creating directory... " + filePath);
			Directory.CreateDirectory(filePath);
		}
	}

	// Token: 0x060007E2 RID: 2018 RVA: 0x000343A8 File Offset: 0x000325A8
	public static bool HasBundle(string nam)
	{
		SpawnPointScript.GetBundles();
		foreach (string path in SpawnPointScript.bundlenames)
		{
			if (Path.GetFileName(path) == nam)
			{
				return true;
			}
		}
		return false;
	}

	// Token: 0x060007E3 RID: 2019 RVA: 0x000343EC File Offset: 0x000325EC
	private IEnumerator DoAwake()
	{
		SpawnPointScript.GetBundles();
		if (this.loadPackage && SpawnPointScript.bundlenames.Length > 0)
		{
			yield return this.LoadBundleByInd(0);
		}
		else
		{
			this.SpawnPlayerAtStart();
			this.loaded = true;
		}
		yield break;
	}

	// Token: 0x060007E4 RID: 2020 RVA: 0x00034408 File Offset: 0x00032608
	private IEnumerator LoadBundleByInd(int ind)
	{
		if (ind < SpawnPointScript.bundlenames.Length)
		{
			yield return this.LoadBundle(SpawnPointScript.bundlenames[ind]);
		}
		Debug.LogWarning("bundle ind out of bounds!!!! " + ind);
		yield break;
	}

	// Token: 0x060007E5 RID: 2021 RVA: 0x00034434 File Offset: 0x00032634
	private IEnumerator LoadBundleBytes(string nam, byte[] data)
	{
		this.loaded = false;
		string path = Path.Combine(SpawnPointScript.filePath, nam);
		Debug.Log(path);
		File.WriteAllBytes(path, data);
		Debug.Log(data.Length);
		AssetBundleCreateRequest request = AssetBundle.CreateFromMemory(data);
		yield return request;
		AssetBundle bundle = request.assetBundle;
		if (bundle == null)
		{
			Debug.LogWarning("bundle is null...");
		}
		else
		{
			if (this.bundleObj)
			{
				UnityEngine.Object.Destroy(this.bundleObj.gameObject);
			}
			if (SpawnPointScript.curBundle)
			{
				SpawnPointScript.curBundle.Unload(true);
			}
			SpawnPointScript.curBundle = bundle;
			this.curBundleBytes = data;
			this.curBundleName = nam;
			this.bundleObj = (UnityEngine.Object.Instantiate(SpawnPointScript.curBundle.mainAsset) as GameObject);
		}
		this.loaded = true;
		yield return null;
		this.SpawnPlayerAtStart();
		yield break;
	}

	// Token: 0x060007E6 RID: 2022 RVA: 0x0003446C File Offset: 0x0003266C
	private IEnumerator LoadBundle(string nam)
	{
		this.loaded = false;
		string fpath = nam;
		bool local = true;
		if (!nam.StartsWith("http"))
		{
			fpath = "file://" + Path.Combine(SpawnPointScript.filePath, nam);
		}
		else
		{
			local = false;
		}
		this.web = new WWW(fpath);
		MonoBehaviour.print("grabbin " + this.web.url);
		yield return this.web;
		if (this.web.error != null)
		{
			Debug.LogWarning("error: " + this.web.error);
			this.ShowError("error: " + this.web.error + "\n" + nam);
		}
		else if (this.web.assetBundle == null)
		{
			this.ShowError("no bundle: " + nam);
		}
		else
		{
			if (this.bundleObj)
			{
				UnityEngine.Object.Destroy(this.bundleObj.gameObject);
			}
			if (SpawnPointScript.curBundle)
			{
				SpawnPointScript.curBundle.Unload(true);
			}
			SpawnPointScript.curBundle = this.web.assetBundle;
			this.curBundleBytes = this.web.bytes;
			this.curBundleName = nam;
			if (!local)
			{
				string path = Path.Combine(SpawnPointScript.filePath, nam.Substring(nam.LastIndexOf("/") + 1));
				Debug.Log(path);
				if (!File.Exists(path))
				{
					File.WriteAllBytes(path, this.curBundleBytes);
				}
			}
			this.bundleObj = (UnityEngine.Object.Instantiate(SpawnPointScript.curBundle.mainAsset) as GameObject);
			Debug.Log("instantiated... " + this.bundleObj);
		}
		yield return null;
		this.SpawnPlayerAtStart();
		this.loaded = true;
		yield break;
	}

	// Token: 0x060007E7 RID: 2023 RVA: 0x00034498 File Offset: 0x00032698
	private void ShowError(string err)
	{
		MissionGUIText missionGUIText = MissionGUIText.Create(err, new Vector3(0.024f, 0.5714286f, 0f), Vector3.one * 4f);
		missionGUIText.color = Color.red;
		missionGUIText.velocity = Vector3.up * -0.05f;
		missionGUIText.stopAfter = 0.5f;
		missionGUIText.lifeTime = 4f;
	}

	// Token: 0x060007E8 RID: 2024 RVA: 0x00034508 File Offset: 0x00032708
	public void SpawnPlayerAtStart()
	{
		if (this.splineGrinding == null)
		{
			this.splineGrinding = GameObject.Find("GrindPoint").GetComponent<SplineGrinding>();
		}
		if (this.playerAnimation == null)
		{
			this.playerAnimation = GameObject.Find("main_character").transform;
		}
		if (this.moveScript.isGrinding)
		{
			this.splineGrinding.bail();
		}
		if (PhoneInterface.hawk && PhoneInterface.hawk.targetHeld)
		{
			PhoneInterface.hawk.Drop();
		}
		if (this.isRespawning)
		{
			this.StopRewind();
		}
		Transform transform = base.transform;
		if (GameObject.Find("PlayerSpawn"))
		{
			transform = GameObject.Find("PlayerSpawn").transform;
		}
		if (Application.loadedLevelName == "test")
		{
			if (PhoneInterface.hawk)
			{
				PhoneInterface.hawk.dropLocation.transform.position = transform.transform.position + Vector3.up * 30f;
				PhoneInterface.hawk.dropLocation.transform.rotation = transform.transform.rotation;
				if (PhoneInterface.hawk.tempHawkRend)
				{
					UnityEngine.Object.Destroy(PhoneInterface.hawk.tempHawkRend.gameObject);
					PhoneInterface.hawk.fly.renderer.enabled = true;
					PhoneInterface.hawk.carry.renderer.enabled = true;
				}
				GameObject gameObject = GameObject.Find("HawkObject");
				if (gameObject)
				{
					GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
					PhoneInterface.hawk.tempHawkRend = gameObject2;
					gameObject2.transform.parent = PhoneInterface.hawk.transform;
					gameObject2.transform.localPosition = Vector3.zero;
					gameObject2.transform.localRotation = Quaternion.identity;
					Debug.Log("added hawk obj...");
					PhoneInterface.hawk.fly.renderer.enabled = false;
					PhoneInterface.hawk.carry.renderer.enabled = false;
				}
			}
			bool flag = false;
			MusicManager.override_vol = 1f;
			if (Application.loadedLevelName == "test" && GameObject.Find("MusicObject"))
			{
				flag = true;
			}
			if (MusicManager.instance)
			{
				if (flag)
				{
					MusicManager.instance.enabled = false;
					MusicManager.override_vol = 0f;
					MusicManager.instance.audio.Stop();
				}
				else
				{
					MusicManager.instance.enabled = true;
					MusicManager.override_vol = 1f;
					if (!MusicManager.instance.audio.isPlaying)
					{
						MusicManager.instance.audio.Play();
					}
				}
				MusicManager.base_vol = MusicManager.base_vol;
			}
			SplineGrinding.instance.RefreshRails();
		}
		Vector3 position = transform.position;
		Quaternion rotation = transform.rotation;
		string animationState = "Idle";
		string animationName = "Idle";
		float animationTime = 0f;
		float animationSpeed = 0f;
		int currentGracePeriod = this.splineGrinding.currentGracePeriod;
		float volume = this.player.GetComponent<AudioSource>().volume;
		float airTime = this.moveScript.airTime;
		if (this.player.rigidbody.isKinematic)
		{
			this.player.rigidbody.isKinematic = false;
			this.player.rigidbody.velocity = Vector3.zero;
			this.player.rigidbody.isKinematic = true;
		}
		else
		{
			this.player.rigidbody.velocity = Vector3.zero;
		}
		this.spawnList.Clear();
		NewCamera component = this.cameraTrans.GetComponent<NewCamera>();
		this.cameraTrans.rotation = rotation;
		this.cameraTrans.position = position - component.distanceBehind * 5f * this.cameraTrans.forward + component.height * Vector3.up * 1.4f;
		this.spawnList.Add(new SpawnPoint(0, position, rotation, new Vector3(0f, 0f, 0f), animationState, animationName, animationTime, animationSpeed, this.cameraTrans.position, this.cameraTrans.rotation, currentGracePeriod, volume, airTime));
		SpawnPointScript.spawnNum = Mathf.FloorToInt(this.player.GetComponent<PlayerTrail>().decayTime / Time.fixedDeltaTime);
		this.ReSpawn(0);
	}

	// Token: 0x060007E9 RID: 2025 RVA: 0x000349A4 File Offset: 0x00032BA4
	public void LoadAndSpawn(string nam, byte[] data)
	{
		base.StopCoroutine("LoadBundle");
		base.StopCoroutine("LoadBundleBytes");
		if (this.bundleObj)
		{
			UnityEngine.Object.Destroy(this.bundleObj.gameObject);
		}
		if (SpawnPointScript.curBundle)
		{
			SpawnPointScript.curBundle.Unload(true);
		}
		Debug.Log("loading bytes..." + data.Length);
		base.StartCoroutine(this.LoadBundleBytes(nam, data));
	}

	// Token: 0x060007EA RID: 2026 RVA: 0x00034A28 File Offset: 0x00032C28
	public void LoadAndSpawn(string bundlename)
	{
		base.StopCoroutine("LoadBundle");
		base.StopCoroutine("LoadBundleBytes");
		if (this.bundleObj)
		{
			UnityEngine.Object.Destroy(this.bundleObj.gameObject);
		}
		if (SpawnPointScript.curBundle)
		{
			SpawnPointScript.curBundle.Unload(true);
		}
		Debug.Log("starting to load bundle...");
		base.StartCoroutine(this.LoadBundle(bundlename));
	}

	// Token: 0x060007EB RID: 2027 RVA: 0x00034AA0 File Offset: 0x00032CA0
	private void Update()
	{
		if (this.loaded && this.canRespawn)
		{
			if (this.isRespawning)
			{
				this.CheckStopRewind();
			}
			else if (Input.GetButtonDown("Rewind"))
			{
				GameObject.Find("Main Camera").GetComponent<MotionBlur>().enabled = true;
				GameObject.Find("Camera Holder").GetComponent<SoundManager>().StopSound();
				this.player.GetComponent<MusicManager>().Pause();
				this.ReparentSpawns();
				this.lastRewindTime = this.rewindGap;
				this.isRespawning = true;
				GameObject.Find("Holder").GetComponent<PlayerGraphic>().isRespawning = true;
				this.player.GetComponent<move>().freezeControls = true;
				this.player.GetComponent<Rigidbody>().isKinematic = true;
				this.cameraTrans.GetComponent<NewCamera>().pauseCamera = true;
				this.splineGrinding.paused = true;
				this.splineGrinding.grindTimer = this.splineGrinding.maxGrindTimer;
				this.DropPoint(true);
				this.splineGrinding.bail();
				this.currentLoc = this.spawnList.Count - 1;
				this.TempMovePlayer(this.currentLoc);
			}
		}
	}

	// Token: 0x060007EC RID: 2028 RVA: 0x00034BD8 File Offset: 0x00032DD8
	private void FixedUpdate()
	{
		float fixedDeltaTime = Time.fixedDeltaTime;
		float time = Time.time;
		if (!this.loaded)
		{
			return;
		}
		this.resetTime -= fixedDeltaTime;
		if (this.resetTime <= 0f)
		{
			this.totalInput = string.Empty;
		}
		if (this.canRespawn)
		{
			if (!this.isRespawning)
			{
				SpawnPointScript.spawnGap -= time - this.lastTime;
				this.lastTime = time;
				if (!this.moveScript.isGrinding && this.player.rigidbody.velocity.magnitude < 1f && Input.GetAxis("Horizontal") == 0f && Input.GetAxis("Vertical") == 0f)
				{
					this.stopRecordingTimer += Time.fixedDeltaTime;
				}
				else
				{
					this.stopRecordingTimer = 0f;
				}
				if (SpawnPointScript.spawnGap <= 0f && this.stopRecordingTimer < 0.25f)
				{
					this.DropPoint(false);
					SpawnPointScript.spawnGap = this.currentGap;
				}
			}
			if (this.isRespawning)
			{
				this.stopRecordingTimer = 0f;
				this.timePassed += fixedDeltaTime;
				this.GetRewindInput();
			}
		}
		else
		{
			this.stopRecordingTimer = 0f;
		}
	}

	// Token: 0x060007ED RID: 2029 RVA: 0x00034D40 File Offset: 0x00032F40
	private void ReparentSpawns()
	{
		PlayerTrail component = this.player.GetComponent<PlayerTrail>();
		for (int i = 0; i < component.trailList.Count; i++)
		{
			GameObject gameObject = new GameObject("spawnHolder");
			gameObject.layer = 2;
			TrailRenderer trailRenderer = gameObject.AddComponent<TrailRenderer>();
			trailRenderer.material = component.trailMaterial;
			trailRenderer.startWidth = component.startWidth;
			trailRenderer.endWidth = component.endWidth;
			trailRenderer.time = SpawnPointScript.trailTime;
			trailRenderer.material.color = component.color;
			this.oldSpawns.Add(component.holderObjectList[i]);
			this.oldSpawnDecays.Add(component.decayTime);
			component.holderObjectList[i].transform.parent = null;
			gameObject.transform.position = component.trailHolderList[i].position;
			gameObject.transform.parent = component.trailHolderList[i];
			component.trailList[i] = gameObject.GetComponent<TrailRenderer>();
			component.trailList[i].time = 0f;
			component.holderObjectList[i] = gameObject;
			component.lastPointList[i] = gameObject.transform.position;
			this.timePassed = 0f;
		}
		for (int j = 0; j < this.oldSpawns.Count; j++)
		{
			if (this.oldSpawns[j] == null)
			{
				UnityEngine.Object.Destroy(this.oldSpawns[j]);
				this.oldSpawns.RemoveAt(j);
				this.oldSpawnDecays.RemoveAt(j);
				j--;
			}
			else
			{
				this.oldSpawnDecays[j] = this.oldSpawns[j].GetComponent<TrailRenderer>().time;
				this.oldSpawns[j].GetComponent<TrailRenderer>().time = 999999f;
			}
		}
	}

	// Token: 0x060007EE RID: 2030 RVA: 0x00034F48 File Offset: 0x00033148
	private void ReactivateSpawns()
	{
		for (int i = 0; i < this.player.GetComponent<PlayerTrail>().trailList.Count; i++)
		{
			int count = this.player.GetComponent<PlayerTrail>().trailList.Count;
			int index = i + this.oldSpawns.Count - count;
			this.oldSpawns[index].GetComponent<TrailRenderer>().time = this.timePassed + this.oldSpawnDecays[index];
			this.oldSpawns[index].GetComponent<TrailRenderer>().autodestruct = true;
			this.player.GetComponent<PlayerTrail>().trailList[i].time = this.oldSpawnDecays[index];
		}
		for (int i = 0; i < this.oldSpawns.Count; i++)
		{
			if (this.oldSpawns[i] == null)
			{
				UnityEngine.Object.Destroy(this.oldSpawns[i]);
				this.oldSpawns.RemoveAt(i);
				this.oldSpawnDecays.RemoveAt(i);
				i--;
			}
			else
			{
				this.oldSpawns[i].GetComponent<TrailRenderer>().time = this.timePassed + this.oldSpawnDecays[i];
			}
		}
	}

	// Token: 0x060007EF RID: 2031 RVA: 0x00035098 File Offset: 0x00033298
	public Vector3 GetWallNormal()
	{
		return this.spawnList[this.currentLoc].wallNormal;
	}

	// Token: 0x060007F0 RID: 2032 RVA: 0x000350B0 File Offset: 0x000332B0
	private void CheckStopRewind()
	{
		if (Input.GetButtonDown("Skate"))
		{
			this.StopRewind();
		}
	}

	// Token: 0x060007F1 RID: 2033 RVA: 0x000350C8 File Offset: 0x000332C8
	public void StopRewind()
	{
		this.player.GetComponent<MusicManager>().PlayForward();
		this.ReactivateSpawns();
		this.isRespawning = false;
		GameObject.Find("Holder").GetComponent<PlayerGraphic>().isRespawning = false;
		this.cameraTrans.GetComponent<NewCamera>().pauseCamera = false;
		this.splineGrinding.paused = false;
		this.cameraTrans.GetComponent<NewCamera>().mockCamera.position = this.cameraTrans.position;
		this.cameraTrans.GetComponent<NewCamera>().mockCamera.rotation = this.cameraTrans.rotation;
		this.lastTime = Time.time;
		this.ReSpawn(this.currentLoc);
		if (this.spawnList.Count > 0)
		{
			this.spawnList.Remove(this.spawnList[this.spawnList.Count - 1]);
		}
		this.lastRewindTime = this.rewindGap;
		GameObject.Find("Main Camera").GetComponent<MotionBlur>().enabled = false;
		PlaytomicController.LogPosition("tRewindResume", this.player.position);
	}

	// Token: 0x060007F2 RID: 2034 RVA: 0x000351E8 File Offset: 0x000333E8
	private void GetRewindInput()
	{
		this.lastRewindTime -= Time.deltaTime;
		if (this.lastRewindTime <= 0f)
		{
			if (Input.GetButton("Rewind"))
			{
				this.currentLoc--;
				if (this.currentLoc < 0)
				{
					this.currentLoc = 0;
					GameObject.Find("Camera Holder").GetComponent<SoundManager>().PauseRewind();
					this.player.GetComponent<MusicManager>().Pause();
				}
				else
				{
					GameObject.Find("Camera Holder").GetComponent<SoundManager>().PlayRewind();
					this.player.GetComponent<MusicManager>().PlayReversed();
				}
				this.TempMovePlayer(this.currentLoc);
				this.lastRewindTime = this.rewindGap;
			}
			else if (Input.GetButton("UnRewind"))
			{
				this.currentLoc++;
				if (this.currentLoc >= this.spawnList.Count)
				{
					this.currentLoc = this.spawnList.Count - 1;
					GameObject.Find("Camera Holder").GetComponent<SoundManager>().PauseRewind();
					this.player.GetComponent<MusicManager>().Pause();
				}
				else
				{
					GameObject.Find("Camera Holder").GetComponent<SoundManager>().PlayRewind();
					this.player.GetComponent<MusicManager>().PlayForward();
				}
				this.TempMovePlayer(this.currentLoc);
				this.lastRewindTime = this.rewindGap;
			}
			else
			{
				GameObject.Find("Camera Holder").GetComponent<SoundManager>().PauseRewind();
				this.player.GetComponent<MusicManager>().Pause();
			}
		}
	}

	// Token: 0x060007F3 RID: 2035 RVA: 0x00035388 File Offset: 0x00033588
	private void TempMovePlayer(int pos)
	{
		this.moveScript.freezeControls = true;
		this.moveScript.wallRiding = false;
		this.player.GetComponent<Rigidbody>().isKinematic = true;
		this.moveScript.airTime = this.spawnList[pos].airTime;
		if (this.spawnList[pos].currentState == 0)
		{
			this.moveScript.isGrinding = false;
			this.splineGrinding.isGrinding = false;
		}
		else if (this.spawnList[pos].currentState == 1)
		{
			this.moveScript.isGrinding = true;
			this.splineGrinding.isGrinding = true;
		}
		else if (this.spawnList[pos].currentState == 2)
		{
			this.moveScript.isGrinding = false;
			this.splineGrinding.isGrinding = false;
		}
		this.cameraTrans.position = this.spawnList[pos].cameraPosition;
		this.cameraTrans.rotation = this.spawnList[pos].cameraRotation;
		this.player.position = this.spawnList[pos].spawnPos;
		this.player.rotation = this.spawnList[pos].spawnRot;
		if (this.spawnList[pos].currentState != 2)
		{
		}
		this.splineGrinding.currentGracePeriod = this.spawnList[pos].gracePeriod;
		this.player.GetComponent<AudioSource>().volume = this.spawnList[pos].volume;
		this.playerAnimation.animation.Play(this.spawnList[pos].animationName);
		AnimationState animationState = this.playerAnimation.animation[this.spawnList[pos].animationName];
		animationState.time = this.spawnList[pos].animationTime;
		this.lastSpeed = animationState.speed;
		animationState.speed = 0f;
		HawkBehavior hawk = PhoneInterface.hawk;
		hawk.transform.position = this.spawnList[pos].hawkPos;
		hawk.transform.rotation = this.spawnList[pos].hawkRot;
		hawk.timeFollowed = this.spawnList[pos].timeFollowed;
		hawk.swoopDistance = this.spawnList[pos].swoopDistance;
		hawk.startSwoopDistance = this.spawnList[pos].startSwoopDistance;
		hawk.inBounds = this.spawnList[pos].inBounds;
		hawk.targetEngaged = this.spawnList[pos].targetEngaged;
		hawk.hasSwoopedIn = this.spawnList[pos].hasSwoopedIn;
	}

	// Token: 0x060007F4 RID: 2036 RVA: 0x00035670 File Offset: 0x00033870
	public SpawnPoint GetCurrentSpawnPoint()
	{
		return this.spawnList[this.currentLoc];
	}

	// Token: 0x060007F5 RID: 2037 RVA: 0x00035684 File Offset: 0x00033884
	public Vector3 GetCurrentVelocity()
	{
		return this.spawnList[this.currentLoc].velocity;
	}

	// Token: 0x060007F6 RID: 2038 RVA: 0x0003569C File Offset: 0x0003389C
	public float GetRailVelocity()
	{
		return this.spawnList[this.currentLoc].currentVelocity;
	}

	// Token: 0x060007F7 RID: 2039 RVA: 0x000356B4 File Offset: 0x000338B4
	private void ReSpawn(int pos)
	{
		this.TempMovePlayer(pos);
		this.moveScript.airTime = this.spawnList[pos].airTime;
		if (this.spawnList[pos].currentState == 0)
		{
			this.moveScript.freezeControls = false;
			this.player.GetComponent<Rigidbody>().isKinematic = false;
			this.player.GetComponent<Rigidbody>().velocity = this.spawnList[pos].velocity;
			this.splineGrinding.bail();
		}
		else if (this.spawnList[pos].currentState == 1)
		{
			this.splineGrinding.spline = this.spawnList[pos].spline;
			this.splineGrinding.currentVelocity = this.spawnList[pos].currentVelocity;
			this.splineGrinding.passedTime = this.spawnList[pos].passedTime;
			this.splineGrinding.offSet = this.spawnList[pos].offSet;
			this.splineGrinding.movePlayerToGrindPoint();
			this.splineGrinding.forward = this.spawnList[pos].forward;
		}
		else if (this.spawnList[pos].currentState == 2)
		{
			this.moveScript.wallRiding = true;
			this.moveScript.freezeControls = false;
			this.player.GetComponent<Rigidbody>().isKinematic = false;
			this.player.GetComponent<Rigidbody>().velocity = this.spawnList[pos].velocity;
			this.moveScript.wallNormal = this.spawnList[pos].wallNormal;
			this.splineGrinding.bail();
		}
		this.playerAnimation.animation[this.spawnList[pos].animationName].speed = this.spawnList[pos].animationSpeed;
		this.moveScript.lastAnim = this.spawnList[pos].animationState;
		for (int i = pos + 1; i < this.spawnList.Count; i++)
		{
			this.spawnList.RemoveAt(i);
			i--;
		}
		if (pos == 0)
		{
			this.spawnList.RemoveAt(0);
		}
	}

	// Token: 0x060007F8 RID: 2040 RVA: 0x00035918 File Offset: 0x00033B18
	private void DropPoint(bool alwaysAdd = false)
	{
		Vector3 position = this.player.position;
		Quaternion rotation = this.player.rotation;
		Vector3 velocity = this.player.GetComponent<Rigidbody>().velocity;
		string animationState = string.Empty;
		string animationName = string.Empty;
		float animationTime = 0f;
		float animationSpeed = 0f;
		float airTime = this.moveScript.airTime;
		bool flag = false;
		AnimationState animationState2 = this.playerAnimation.animation[this.moveScript.animName];
		if (animationState2)
		{
			flag = true;
			animationState = this.moveScript.lastAnim;
			animationTime = animationState2.time;
			animationName = animationState2.name;
			animationSpeed = animationState2.speed;
		}
		if (flag)
		{
			int num = 0;
			if (this.moveScript.isGrinding)
			{
				num = 1;
			}
			else if (this.moveScript.wallRiding)
			{
				num = 2;
			}
			int currentGracePeriod = this.splineGrinding.currentGracePeriod;
			float volume = this.player.GetComponent<AudioSource>().volume;
			SpawnPoint spawnPoint = new SpawnPoint(num, position, rotation, velocity, animationState, animationName, animationTime, animationSpeed, this.cameraTrans.position, this.cameraTrans.GetComponent<NewCamera>().mockCamera.rotation, currentGracePeriod, volume, airTime);
			if (num == 1)
			{
				spawnPoint.currentVelocity = this.splineGrinding.currentVelocity;
				spawnPoint.passedTime = this.splineGrinding.passedTime;
				spawnPoint.offSet = this.splineGrinding.offSet;
				spawnPoint.spline = this.splineGrinding.spline;
				spawnPoint.forward = this.splineGrinding.forward;
			}
			else if (num == 2)
			{
				spawnPoint.wallNormal = this.moveScript.wallNormal;
			}
			if (this.spawnList.Count >= SpawnPointScript.spawnNum && !alwaysAdd)
			{
				this.spawnList.Remove(this.spawnList[0]);
			}
			this.spawnList.Add(spawnPoint);
		}
		else
		{
			Debug.LogWarning("couldnt find animation: " + this.moveScript.animName);
		}
	}

	// Token: 0x060007F9 RID: 2041 RVA: 0x00035B3C File Offset: 0x00033D3C
	public void ClearSpawns()
	{
		this.spawnList = new List<SpawnPoint>();
		this.currentLoc = 0;
	}

	// Token: 0x060007FA RID: 2042 RVA: 0x00035B50 File Offset: 0x00033D50
	private void OnDrawGizmos()
	{
		Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
		Gizmos.DrawCube(base.transform.position, new Vector3(1f, 1f, 1f));
	}

	// Token: 0x060007FB RID: 2043 RVA: 0x00035BA0 File Offset: 0x00033DA0
	private void GetDebugInput()
	{
		this.totalInput += this.inputString;
		this.resetTime = this.maxResetTime;
	}

	// Token: 0x060007FC RID: 2044 RVA: 0x00035BC8 File Offset: 0x00033DC8
	private void JumpToDebug(string _loc)
	{
		int num = int.Parse(_loc);
		if (num < this.debug_checkpoints.Length)
		{
			this.DebugRespawn(num);
		}
	}

	// Token: 0x060007FD RID: 2045 RVA: 0x00035BF4 File Offset: 0x00033DF4
	private void DebugRespawn(int loc)
	{
		if (this.isRespawning)
		{
			this.StopRewind();
		}
		this.moveScript.freezeControls = false;
		this.moveScript.wallRiding = false;
		this.moveScript.isGrinding = false;
		this.player.GetComponent<Rigidbody>().isKinematic = false;
		this.splineGrinding.isGrinding = false;
		this.player.position = this.debug_checkpoints[loc].transform.position;
		this.player.rotation = this.debug_checkpoints[loc].transform.rotation;
		this.player.GetComponent<Rigidbody>().velocity = this.debug_checkpoints[loc].velocity;
	}

	// Token: 0x040006AE RID: 1710
	public Transform player;

	// Token: 0x040006AF RID: 1711
	public Transform cameraTrans;

	// Token: 0x040006B0 RID: 1712
	private Transform playerAnimation;

	// Token: 0x040006B1 RID: 1713
	public static int spawnNum = 200;

	// Token: 0x040006B2 RID: 1714
	public static float spawnGap = 0f;

	// Token: 0x040006B3 RID: 1715
	public bool canRespawn = true;

	// Token: 0x040006B4 RID: 1716
	public DebugPoint[] debug_checkpoints;

	// Token: 0x040006B5 RID: 1717
	private float currentGap = SpawnPointScript.spawnGap;

	// Token: 0x040006B6 RID: 1718
	private List<SpawnPoint> spawnList = new List<SpawnPoint>();

	// Token: 0x040006B7 RID: 1719
	private List<GameObject> oldSpawns = new List<GameObject>();

	// Token: 0x040006B8 RID: 1720
	private List<float> oldSpawnDecays = new List<float>();

	// Token: 0x040006B9 RID: 1721
	private int currentLoc;

	// Token: 0x040006BA RID: 1722
	public bool isRespawning;

	// Token: 0x040006BB RID: 1723
	private float lastTime;

	// Token: 0x040006BC RID: 1724
	private float lastSpeed;

	// Token: 0x040006BD RID: 1725
	private float lastRewindTime;

	// Token: 0x040006BE RID: 1726
	private float rewindGap = SpawnPointScript.spawnGap;

	// Token: 0x040006BF RID: 1727
	private float timePassed;

	// Token: 0x040006C0 RID: 1728
	private SplineGrinding splineGrinding;

	// Token: 0x040006C1 RID: 1729
	private string inputString = string.Empty;

	// Token: 0x040006C2 RID: 1730
	private string totalInput = string.Empty;

	// Token: 0x040006C3 RID: 1731
	private float resetTime = 2f;

	// Token: 0x040006C4 RID: 1732
	private float maxResetTime = 2f;

	// Token: 0x040006C5 RID: 1733
	private static SpawnPointScript _instance;

	// Token: 0x040006C6 RID: 1734
	public static float trailTime = 0f;

	// Token: 0x040006C7 RID: 1735
	public bool loadPackage;

	// Token: 0x040006C8 RID: 1736
	public bool loaded;

	// Token: 0x040006C9 RID: 1737
	private WWW web;

	// Token: 0x040006CA RID: 1738
	public static string[] bundlenames = new string[0];

	// Token: 0x040006CB RID: 1739
	private GameObject bundleObj;

	// Token: 0x040006CC RID: 1740
	private static AssetBundle curBundle;

	// Token: 0x040006CD RID: 1741
	public byte[] curBundleBytes;

	// Token: 0x040006CE RID: 1742
	public string curBundleName;

	// Token: 0x040006CF RID: 1743
	private float stopRecordingTimer;

	// Token: 0x020000BA RID: 186
	private enum State
	{
		// Token: 0x040006D1 RID: 1745
		Normal,
		// Token: 0x040006D2 RID: 1746
		Grinding,
		// Token: 0x040006D3 RID: 1747
		WallRiding
	}
}
