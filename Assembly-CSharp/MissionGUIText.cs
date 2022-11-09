using System;
using UnityEngine;

// Token: 0x0200001C RID: 28
public class MissionGUIText : MonoBehaviour
{
	// Token: 0x17000012 RID: 18
	// (get) Token: 0x060000C0 RID: 192 RVA: 0x00007C48 File Offset: 0x00005E48
	// (set) Token: 0x060000C1 RID: 193 RVA: 0x00007C58 File Offset: 0x00005E58
	public string text
	{
		get
		{
			return base.guiText.text;
		}
		set
		{
			base.guiText.text = value;
			if (this.shadow_text)
			{
				this.shadow_text.text = value;
			}
		}
	}

	// Token: 0x17000013 RID: 19
	// (get) Token: 0x060000C2 RID: 194 RVA: 0x00007C90 File Offset: 0x00005E90
	// (set) Token: 0x060000C3 RID: 195 RVA: 0x00007CA0 File Offset: 0x00005EA0
	public Material material
	{
		get
		{
			return base.guiText.material;
		}
		set
		{
			base.guiText.material = value;
		}
	}

	// Token: 0x17000014 RID: 20
	// (get) Token: 0x060000C4 RID: 196 RVA: 0x00007CB0 File Offset: 0x00005EB0
	// (set) Token: 0x060000C5 RID: 197 RVA: 0x00007CC4 File Offset: 0x00005EC4
	public Color color
	{
		get
		{
			return base.guiText.material.color;
		}
		set
		{
			base.guiText.material.color = value;
		}
	}

	// Token: 0x17000015 RID: 21
	// (get) Token: 0x060000C6 RID: 198 RVA: 0x00007CD8 File Offset: 0x00005ED8
	// (set) Token: 0x060000C7 RID: 199 RVA: 0x00007CE8 File Offset: 0x00005EE8
	public Vector2 pixelOffset
	{
		get
		{
			return base.guiText.pixelOffset;
		}
		set
		{
			base.guiText.pixelOffset = value;
			if (this.shadow_text)
			{
				this.shadow_text.pixelOffset = value + this.shadow_offset;
			}
		}
	}

	// Token: 0x17000016 RID: 22
	// (get) Token: 0x060000C8 RID: 200 RVA: 0x00007D28 File Offset: 0x00005F28
	// (set) Token: 0x060000C9 RID: 201 RVA: 0x00007D38 File Offset: 0x00005F38
	public Font font
	{
		get
		{
			return base.guiText.font;
		}
		set
		{
			base.guiText.font = value;
			if (this.shadow_text)
			{
				this.shadow_text.font = value;
			}
		}
	}

	// Token: 0x060000CA RID: 202 RVA: 0x00007D70 File Offset: 0x00005F70
	private void Awake()
	{
		if (!base.guiText)
		{
			base.gameObject.AddComponent<GUIText>();
		}
		if (this.shadow)
		{
			this.AddShadow();
		}
		this.color = this.startColor;
	}

	// Token: 0x060000CB RID: 203 RVA: 0x00007DB8 File Offset: 0x00005FB8
	private GUIText AddShadow()
	{
		if (this.shadow_text == null)
		{
			GameObject gameObject = new GameObject("MissionGUI_Shadow");
			this.shadow_text = gameObject.AddComponent<GUIText>();
			this.shadow_text.transform.parent = base.transform;
			this.shadow_text.transform.localScale = Vector3.zero;
			this.shadow_text.transform.localPosition = Vector3.zero;
			this.shadow_text.transform.localRotation = Quaternion.identity;
		}
		this.shadow_text.text = this.text;
		this.shadow_text.font = this.font;
		this.shadow_text.material = this.material;
		this.shadow_text.material.color = Color.black;
		this.shadow_text.pixelOffset = this.pixelOffset + this.shadow_offset;
		this.shadow_text.anchor = base.guiText.anchor;
		this.shadow_text.alignment = base.guiText.alignment;
		return this.shadow_text;
	}

	// Token: 0x060000CC RID: 204 RVA: 0x00007ED8 File Offset: 0x000060D8
	private void Update()
	{
		if (this.shake.magnitude > 0f)
		{
			base.guiText.pixelOffset = new Vector2(UnityEngine.Random.Range(-this.shake.x, this.shake.x), UnityEngine.Random.Range(-this.shake.y, this.shake.y));
		}
		if (this.velocity.magnitude > 0f && this.stopAfter > 0f)
		{
			base.transform.position += this.velocity * Time.deltaTime;
		}
		this.stopAfter -= Time.deltaTime;
		if (this.decay)
		{
			this.lifeTime -= Time.deltaTime;
			if (this.lifeTime <= 0f)
			{
				this.Kill();
			}
		}
	}

	// Token: 0x060000CD RID: 205 RVA: 0x00007FD4 File Offset: 0x000061D4
	public void Kill()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	// Token: 0x060000CE RID: 206 RVA: 0x00007FE4 File Offset: 0x000061E4
	public static MissionGUIText Create(string text, Vector3 position, Vector3 scale)
	{
		MissionGUIText missionGUIText = UnityEngine.Object.Instantiate(MissionController.GetInstance().missionGUIPrefab) as MissionGUIText;
		missionGUIText.transform.position = position;
		missionGUIText.transform.localScale = scale;
		missionGUIText.text = text;
		return missionGUIText;
	}

	// Token: 0x04000119 RID: 281
	public bool shadow = true;

	// Token: 0x0400011A RID: 282
	public GUIText shadow_text;

	// Token: 0x0400011B RID: 283
	public Vector2 shadow_offset = new Vector2(2f, -2f);

	// Token: 0x0400011C RID: 284
	public Vector2 shake = Vector2.zero;

	// Token: 0x0400011D RID: 285
	public Vector3 velocity = Vector3.zero;

	// Token: 0x0400011E RID: 286
	public float stopAfter = 1f;

	// Token: 0x0400011F RID: 287
	public bool decay = true;

	// Token: 0x04000120 RID: 288
	public float lifeTime = 1f;

	// Token: 0x04000121 RID: 289
	public Color startColor = Color.black;

	// Token: 0x04000122 RID: 290
	public Color endColor = Color.black;

	// Token: 0x04000123 RID: 291
	public static Font default_font;

	// Token: 0x04000124 RID: 292
	public static Material default_material;
}
