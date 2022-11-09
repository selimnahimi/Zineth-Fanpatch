using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200008A RID: 138
public class PhoneMapController : PhoneMainMenu
{
	// Token: 0x060005CE RID: 1486 RVA: 0x0002550C File Offset: 0x0002370C
	private void Start()
	{
		this.no_maths = new GameObject().transform;
		this.no_maths.transform.parent = base.transform;
		this.no_maths.name = "no_maths";
		if (this.hide_background)
		{
			this.HideBackground();
		}
		base.renderer.material.color = Color.black;
		if (this.stick_trans)
		{
			this.stick_trans.renderer.material.color = Color.black;
		}
		if (this.player_trans == null)
		{
			this.player_trans = PhoneInterface.player_trans;
		}
		if (this.player_trans != null)
		{
			this.offset = this.player_trans.position;
		}
		for (int i = 0; i < this.location_markers.Count; i++)
		{
			UnityEngine.Object.Destroy(this.location_markers[i].gameObject);
		}
		this.location_markers.Clear();
		this.location_trans = new Transform[0];
		this.SetupScaling();
		this.SetupSecrets();
		if (this.capsule_icon && this.capsule_sprite)
		{
			this.capsule_icon.renderer.material.mainTexture = this.capsule_sprite;
		}
		if (this.npc_icon && this.battle_sprite)
		{
			this.npc_icon.renderer.material.mainTexture = this.battle_sprite;
			this.npc_icon.renderer.material.color = Color.red;
		}
		if (this.secrets_icon && this.secret_sprite)
		{
			this.secrets_icon.renderer.material.mainTexture = this.secret_sprite;
		}
	}

	// Token: 0x060005CF RID: 1487 RVA: 0x00025700 File Offset: 0x00023900
	public override void OnLoad()
	{
		base.OnLoad();
		this.UpdateButtonSelected();
		this.buttons[0].OnSelected();
		Playtomic.Log.CustomMetric("tMapOpened", "tPhone", true);
	}

	// Token: 0x060005D0 RID: 1488 RVA: 0x00025740 File Offset: 0x00023940
	private void SetupLocations()
	{
	}

	// Token: 0x170000C1 RID: 193
	// (get) Token: 0x060005D1 RID: 1489 RVA: 0x00025744 File Offset: 0x00023944
	private int total_secrets
	{
		get
		{
			return SecretObject.all_list.Count;
		}
	}

	// Token: 0x170000C2 RID: 194
	// (get) Token: 0x060005D2 RID: 1490 RVA: 0x00025750 File Offset: 0x00023950
	public List<SecretObject> secret_list
	{
		get
		{
			return SecretObject.uncollected_list;
		}
	}

	// Token: 0x060005D3 RID: 1491 RVA: 0x00025758 File Offset: 0x00023958
	private void SetupSecrets()
	{
	}

	// Token: 0x060005D4 RID: 1492 RVA: 0x0002575C File Offset: 0x0002395C
	private void SetupCapsules()
	{
	}

	// Token: 0x060005D5 RID: 1493 RVA: 0x00025760 File Offset: 0x00023960
	private void SetupNPCs()
	{
	}

	// Token: 0x060005D6 RID: 1494 RVA: 0x00025764 File Offset: 0x00023964
	private void SetupScaling()
	{
		this.scaling = Mathf.Lerp(this.low_scale, this.hi_scale, this.zoom);
		this.UpdateBack();
	}

	// Token: 0x060005D7 RID: 1495 RVA: 0x0002578C File Offset: 0x0002398C
	public override void UpdateScreen()
	{
		this.ZoomControls();
		this.UpdateMarkers();
		this.UpdateLabels();
		base.UpdateScreen();
	}

	// Token: 0x060005D8 RID: 1496 RVA: 0x000257A8 File Offset: 0x000239A8
	private void UpdateLabels()
	{
		if (this.capsule_label)
		{
			string text = "Capsules: " + this.collected_capsules.ToString() + "/" + this.capsule_list.Count.ToString();
			this.capsule_label.text = text;
			if (this.capsule_icon)
			{
				this.capsule_icon.renderer.material.color = new Color(UnityEngine.Random.value, UnityEngine.Random.value, UnityEngine.Random.value, UnityEngine.Random.Range(0f, 0.8f));
			}
		}
		if (this.npc_label)
		{
			string text2 = "Trainers: " + this.defeated_trainers.ToString() + "/" + this.npc_list.Count.ToString();
			this.npc_label.text = text2;
			if (this.npc_icon)
			{
				this.npc_icon.renderer.material.color = new Color(1f, 0f, 0f, UnityEngine.Random.Range(0.25f, 1f));
			}
		}
		if (this.secrets_label)
		{
			string text3 = "Secrets: " + (this.total_secrets - this.secret_list.Count).ToString() + "/" + this.total_secrets.ToString();
			this.secrets_label.text = text3;
			this.secrets_icon.renderer.material.color = new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 0.8f));
		}
	}

	// Token: 0x060005D9 RID: 1497 RVA: 0x00025990 File Offset: 0x00023B90
	private void UpdateBack()
	{
		float d = 2400f;
		Vector2 a = new Vector2(base.renderer.bounds.size.x, base.renderer.bounds.size.z) / d;
		base.renderer.material.mainTextureScale = a / this.scaling;
		Vector2 mainTextureOffset = -base.renderer.material.mainTextureScale * 0.25f;
		base.renderer.material.mainTextureOffset = mainTextureOffset;
	}

	// Token: 0x060005DA RID: 1498 RVA: 0x00025A38 File Offset: 0x00023C38
	private void ZoomControls()
	{
		Vector2 controlDir = PhoneInput.GetControlDir();
		if (controlDir.magnitude < 0.2f)
		{
			controlDir.y = 0f;
		}
		controlDir.y += Input.GetAxis("Mouse ScrollWheel") * 25f;
		if (controlDir.y != 0f)
		{
			this.zoom = Mathf.Clamp(this.zoom + controlDir.y * base.deltatime * 0.5f, 0.01f, 1f);
			this.scaling = Mathf.Lerp(this.low_scale, this.hi_scale, this.zoom);
			float num = this.hi_scale - this.low_scale;
			this.scaling = this.low_scale + num * this.zoom * (this.zoom / this.scale_pow);
		}
		if (this.scale_label)
		{
			this.scale_label.text = (this.zoom * 100f).ToString("0") + "%";
		}
	}

	// Token: 0x060005DB RID: 1499 RVA: 0x00025B54 File Offset: 0x00023D54
	private void UpdateMissionMarkers()
	{
		if (MissionController.GetInstance() != null)
		{
			List<MissionObjective> focus_objectives = MissionController.focus_objectives;
			if (focus_objectives == null)
			{
				MonoBehaviour.print("null objectives");
			}
			for (int i = 0; i < focus_objectives.Count; i++)
			{
				if (this.objective_markers.Count <= i)
				{
					PhoneElement phoneElement = UnityEngine.Object.Instantiate(this.mission_marker) as PhoneElement;
					phoneElement.name = "mission_marker";
					phoneElement.renderer.material.color = Color.green;
					phoneElement.transform.parent = this.player_marker.transform.parent;
					if (this.mission_sprite)
					{
						phoneElement.renderer.material.mainTexture = this.mission_sprite;
					}
					this.objective_markers.Add(phoneElement);
				}
				if (i == 0)
				{
					this.objective_markers[i].renderer.material.color = Color.green;
				}
				else
				{
					this.objective_markers[i].renderer.material.color = Color.blue;
				}
				this.objective_markers[i].gameObject.active = true;
				this.MoveMarker(this.objective_markers[i], focus_objectives[i].objectivePosition, this.objective_markers[i].transform.forward);
				this.objective_markers[i].transform.position += Vector3.up * 0.75f;
			}
			for (int j = focus_objectives.Count; j < this.objective_markers.Count; j++)
			{
				this.objective_markers[j].gameObject.active = false;
			}
		}
	}

	// Token: 0x170000C3 RID: 195
	// (get) Token: 0x060005DC RID: 1500 RVA: 0x00025D2C File Offset: 0x00023F2C
	public List<Capsule> capsule_list
	{
		get
		{
			return Capsule.all_list;
		}
	}

	// Token: 0x170000C4 RID: 196
	// (get) Token: 0x060005DD RID: 1501 RVA: 0x00025D34 File Offset: 0x00023F34
	private int collected_capsules
	{
		get
		{
			return Capsule.collected_list.Count;
		}
	}

	// Token: 0x060005DE RID: 1502 RVA: 0x00025D40 File Offset: 0x00023F40
	private void UpdateCapsuleMarkers()
	{
		for (int i = 0; i < this.capsule_list.Count; i++)
		{
			Capsule capsule = this.capsule_list[i];
			if (capsule == null)
			{
				this.capsule_list.Remove(capsule);
				i--;
			}
			else
			{
				PhoneElement phoneElement;
				if (!this.marker_dic.ContainsKey(capsule.transform))
				{
					phoneElement = (UnityEngine.Object.Instantiate(this.mission_marker) as PhoneElement);
					phoneElement.name = "capsule_marker_" + capsule.capsule_index.ToString();
					phoneElement.renderer.material.color = Color.gray;
					phoneElement.transform.parent = this.player_marker.transform.parent;
					if (this.capsule_sprite)
					{
						phoneElement.renderer.material.mainTexture = this.capsule_sprite;
					}
					this.marker_dic.Add(capsule.transform, phoneElement);
					if (this.mission_marker_scale == Vector3.zero)
					{
						this.mission_marker_scale = phoneElement.transform.localScale;
					}
				}
				else
				{
					phoneElement = this.marker_dic[capsule.transform];
				}
				float num = Vector3.Distance(this.no_maths.position, capsule.transform.position);
				if (capsule.canCollect)
				{
					phoneElement.gameObject.active = true;
					this.MoveMarker(phoneElement, capsule.transform);
					if (num <= 0f)
					{
						num = 1E-05f;
					}
					float num2 = Mathf.Clamp(this.max_dist / num * this.dist_scale, 0f, 1f);
					if (num2 < 0.1f)
					{
						num2 = 0f;
					}
					Color color = new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, num2));
					phoneElement.renderer.material.color = color;
				}
				else
				{
					phoneElement.gameObject.active = false;
				}
			}
		}
	}

	// Token: 0x170000C5 RID: 197
	// (get) Token: 0x060005DF RID: 1503 RVA: 0x00025F68 File Offset: 0x00024168
	public List<NPCTrainer> npc_list
	{
		get
		{
			return NPCTrainer.all_list;
		}
	}

	// Token: 0x170000C6 RID: 198
	// (get) Token: 0x060005E0 RID: 1504 RVA: 0x00025F70 File Offset: 0x00024170
	private int defeated_trainers
	{
		get
		{
			return NPCTrainer.defeated_list.Count;
		}
	}

	// Token: 0x060005E1 RID: 1505 RVA: 0x00025F7C File Offset: 0x0002417C
	private void UpdateNPCMarkers()
	{
		for (int i = 0; i < this.npc_list.Count; i++)
		{
			NPCTrainer npctrainer = this.npc_list[i];
			if (npctrainer == null)
			{
				this.npc_list.Remove(npctrainer);
				i--;
			}
			else
			{
				PhoneElement phoneElement;
				if (!this.marker_dic.ContainsKey(npctrainer.transform))
				{
					phoneElement = (UnityEngine.Object.Instantiate(this.mission_marker) as PhoneElement);
					phoneElement.name = "npc_marker_" + npctrainer.npc_name;
					phoneElement.renderer.material.color = Color.gray;
					phoneElement.transform.parent = this.player_marker.transform.parent;
					if (this.battle_sprite)
					{
						phoneElement.renderer.material.mainTexture = this.battle_sprite;
					}
					this.marker_dic.Add(npctrainer.transform, phoneElement);
					if (this.mission_marker_scale == Vector3.zero)
					{
						this.mission_marker_scale = phoneElement.transform.localScale;
					}
				}
				else
				{
					phoneElement = this.marker_dic[npctrainer.transform];
				}
				float num = Vector3.Distance(this.no_maths.position, npctrainer.transform.position);
				if (npctrainer.can_challenge)
				{
					phoneElement.gameObject.active = true;
					this.MoveMarker(phoneElement, npctrainer.transform);
					if (num <= 0f)
					{
						num = 1E-05f;
					}
					float num2 = Mathf.Clamp(this.max_dist / num * this.dist_scale, 0f, 1f);
					if (num2 < 0.1f)
					{
						num2 = 0f;
					}
					Color color = new Color(1f, 0f, 0f, UnityEngine.Random.Range(num2 * num2, 1f));
					phoneElement.renderer.material.color = color;
				}
				else
				{
					phoneElement.gameObject.active = false;
				}
			}
		}
	}

	// Token: 0x060005E2 RID: 1506 RVA: 0x00026184 File Offset: 0x00024384
	private void UpdateSecretMarkers()
	{
		for (int i = 0; i < this.secret_list.Count; i++)
		{
			SecretObject secretObject = this.secret_list[i];
			if (secretObject == null)
			{
				this.secret_list.Remove(secretObject);
				i--;
			}
			else
			{
				Transform transform = secretObject.transform;
				PhoneElement phoneElement;
				if (!this.marker_dic.ContainsKey(transform))
				{
					phoneElement = (UnityEngine.Object.Instantiate(this.mission_marker) as PhoneElement);
					phoneElement.renderer.material.color = Color.gray;
					phoneElement.transform.parent = this.player_marker.transform.parent;
					if (this.secret_sprite)
					{
						phoneElement.renderer.material.mainTexture = this.secret_sprite;
					}
					this.marker_dic.Add(transform, phoneElement);
				}
				else
				{
					phoneElement = this.marker_dic[transform];
				}
				float num = Vector3.Distance(this.no_maths.position, transform.position);
				phoneElement.gameObject.active = true;
				this.MoveMarker(phoneElement, transform);
				if (num <= 0f)
				{
					num = 1E-05f;
				}
				float num2 = Mathf.Clamp(this.max_dist / num * this.dist_scale, 0f, 1f);
				num2 = Mathf.Sqrt(num2);
				if (num2 < 0.1f)
				{
					num2 = 0f;
				}
				Color color = new Color(UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, 1f), UnityEngine.Random.Range(0f, num2));
				phoneElement.renderer.material.color = color;
			}
		}
	}

	// Token: 0x060005E3 RID: 1507 RVA: 0x00026348 File Offset: 0x00024548
	private void UpdateMarkers()
	{
		Vector3 eulerAngles;
		if (this.player_trans)
		{
			this.no_maths.position = this.player_trans.position;
			eulerAngles = this.player_trans.eulerAngles;
		}
		else
		{
			this.no_maths.position = Camera.main.transform.position;
			eulerAngles = Camera.main.transform.eulerAngles;
		}
		eulerAngles.x = 0f;
		eulerAngles.z = 0f;
		this.no_maths.eulerAngles = eulerAngles;
		this.UpdateMissionMarkers();
		this.UpdateCapsuleMarkers();
		this.UpdateNPCMarkers();
		this.UpdateSecretMarkers();
		for (int i = 0; i < this.location_markers.Count; i++)
		{
			this.MoveMarker(this.location_markers[i], this.location_trans[i]);
		}
	}

	// Token: 0x060005E4 RID: 1508 RVA: 0x00026428 File Offset: 0x00024628
	private void MoveMarker(PhoneElement marker, Transform trans)
	{
		this.MoveMarker(marker, trans.position, trans.forward);
	}

	// Token: 0x060005E5 RID: 1509 RVA: 0x00026448 File Offset: 0x00024648
	private void MoveMarker(PhoneElement marker, Vector3 position, Vector3 forward)
	{
		if (this.player_trans)
		{
			this.offset = this.player_trans.transform.position;
		}
		else
		{
			this.offset = Camera.main.transform.position;
		}
		Vector3 vector = this.WorldToLocal(position);
		Vector2 vector2 = new Vector2(vector.x - base.transform.position.x, vector.z - base.transform.position.z);
		if (this.maxdist <= 0f)
		{
			Transform transform = base.transform.FindChild("RadarBack");
			this.maxdist = transform.renderer.bounds.size.x * 0.49f;
		}
		vector2 = Vector2.ClampMagnitude(vector2, this.maxdist);
		vector.x = base.transform.position.x + vector2.x;
		vector.z = base.transform.position.z + vector2.y;
		if (marker.transform.position != vector)
		{
			marker.transform.position = vector;
		}
		if (marker.GetType() == typeof(PhoneLabel))
		{
			return;
		}
	}

	// Token: 0x060005E6 RID: 1510 RVA: 0x000265B0 File Offset: 0x000247B0
	private Vector3 WorldToLocal(Vector3 worldpos)
	{
		worldpos = this.no_maths.InverseTransformPoint(worldpos);
		Vector3 a = worldpos * this.scaling;
		a.y = 1f;
		return a + base.transform.position;
	}

	// Token: 0x060005E7 RID: 1511 RVA: 0x000265F8 File Offset: 0x000247F8
	private IEnumerator TakePic()
	{
		Camera mapcam = base.gameObject.AddComponent<Camera>();
		Terrain[] terrains = UnityEngine.Object.FindObjectsOfType(typeof(Terrain)) as Terrain[];
		Bounds bounds = new Bounds(terrains[0].transform.position, Vector3.zero);
		foreach (Terrain ter in terrains)
		{
			bounds.Encapsulate(ter.collider.bounds);
		}
		int scaling = 2;
		int mapwidth = 480 * scaling;
		int mapheight = 800 * scaling;
		Texture2D tex = new Texture2D(mapwidth, mapheight, TextureFormat.RGB24, false);
		Vector3 pos = bounds.center;
		pos.y = 64000f;
		mapcam.transform.position = pos;
		base.camera.transform.eulerAngles = new Vector3(90f, 0f, 0f);
		mapcam.far = 68000f;
		bool ortho = true;
		if (ortho)
		{
			mapcam.isOrthoGraphic = true;
			mapcam.orthographicSize = bounds.size.z * 0.6666667f;
		}
		else
		{
			mapcam.transform.position += Vector3.up * 4800f;
		}
		RenderTexture rt = new RenderTexture(mapwidth, mapheight, 24);
		base.camera.targetTexture = rt;
		yield return new WaitForEndOfFrame();
		base.camera.Render();
		RenderTexture.active = rt;
		tex.ReadPixels(new Rect(0f, 0f, (float)mapwidth, (float)mapheight), 0, 0);
		base.camera.targetTexture = null;
		RenderTexture.active = null;
		UnityEngine.Object.Destroy(rt);
		UnityEngine.Object.Destroy(mapcam);
		byte[] bytes = tex.EncodeToPNG();
		string filename = "test_map.png";
		Debug.Log(string.Format("Took screenshot to: {0}", filename));
		UnityEngine.Object.Destroy(tex);
		yield break;
	}

	// Token: 0x04000484 RID: 1156
	public PhoneElement player_marker;

	// Token: 0x04000485 RID: 1157
	private Transform player_trans;

	// Token: 0x04000486 RID: 1158
	public PhoneElement mission_marker;

	// Token: 0x04000487 RID: 1159
	public List<PhoneLabel> location_markers = new List<PhoneLabel>();

	// Token: 0x04000488 RID: 1160
	public Transform[] location_trans;

	// Token: 0x04000489 RID: 1161
	private Vector3[] location_pos;

	// Token: 0x0400048A RID: 1162
	public PhoneLabel scale_label;

	// Token: 0x0400048B RID: 1163
	public Texture2D mission_sprite;

	// Token: 0x0400048C RID: 1164
	public Texture2D capsule_sprite;

	// Token: 0x0400048D RID: 1165
	public Texture2D battle_sprite;

	// Token: 0x0400048E RID: 1166
	public Texture2D secret_sprite;

	// Token: 0x0400048F RID: 1167
	public PhoneLabel capsule_label;

	// Token: 0x04000490 RID: 1168
	public PhoneLabel npc_label;

	// Token: 0x04000491 RID: 1169
	public PhoneLabel secrets_label;

	// Token: 0x04000492 RID: 1170
	public PhoneElement capsule_icon;

	// Token: 0x04000493 RID: 1171
	public PhoneElement npc_icon;

	// Token: 0x04000494 RID: 1172
	public PhoneElement secrets_icon;

	// Token: 0x04000495 RID: 1173
	public float low_scale = 0.0001f;

	// Token: 0x04000496 RID: 1174
	public float hi_scale = 1f;

	// Token: 0x04000497 RID: 1175
	public float scale_pow = 0.01f;

	// Token: 0x04000498 RID: 1176
	public List<PhoneElement> objective_markers = new List<PhoneElement>();

	// Token: 0x04000499 RID: 1177
	public float max_dist = 2048f;

	// Token: 0x0400049A RID: 1178
	public float dist_scale = 0.25f;

	// Token: 0x0400049B RID: 1179
	public Dictionary<Transform, PhoneElement> marker_dic = new Dictionary<Transform, PhoneElement>();

	// Token: 0x0400049C RID: 1180
	private Vector3 mission_marker_scale = Vector3.zero;

	// Token: 0x0400049D RID: 1181
	private float maxdist;

	// Token: 0x0400049E RID: 1182
	public float scaling = 0.001f;

	// Token: 0x0400049F RID: 1183
	public Vector3 offset = new Vector3(8800f, 0f, 200f);

	// Token: 0x040004A0 RID: 1184
	public float zoom = 0.5f;

	// Token: 0x040004A1 RID: 1185
	private Transform no_maths;

	// Token: 0x040004A2 RID: 1186
	public bool dogui;

	// Token: 0x040004A3 RID: 1187
	public Material mapmaterial;
}
