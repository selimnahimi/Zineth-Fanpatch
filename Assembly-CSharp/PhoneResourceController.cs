using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000052 RID: 82
public class PhoneResourceController : MonoBehaviour
{
	// Token: 0x17000079 RID: 121
	// (get) Token: 0x06000382 RID: 898 RVA: 0x00015B90 File Offset: 0x00013D90
	public static Texture2D[] monsterimages
	{
		get
		{
			return PhoneResourceController.instance._monsterimages;
		}
	}

	// Token: 0x1700007A RID: 122
	// (get) Token: 0x06000383 RID: 899 RVA: 0x00015B9C File Offset: 0x00013D9C
	public static Texture2D[] levelbackgrounds
	{
		get
		{
			return PhoneResourceController.instance._levelbackgrounds;
		}
	}

	// Token: 0x1700007B RID: 123
	// (get) Token: 0x06000384 RID: 900 RVA: 0x00015BA8 File Offset: 0x00013DA8
	public static List<Texture2D> zine_images
	{
		get
		{
			return PhoneResourceController.instance._zine_images;
		}
	}

	// Token: 0x06000385 RID: 901 RVA: 0x00015BB4 File Offset: 0x00013DB4
	public static void Init()
	{
		PhoneResourceController.has_init = true;
		SpriteController.Init();
		PhoneResourceController.instance.SetupSprites();
		PhoneResourceController.instance.SetupMonsterTypes();
		PhoneResourceController.instance.SetupPhoneShooterLevels();
	}

	// Token: 0x06000386 RID: 902 RVA: 0x00015BEC File Offset: 0x00013DEC
	public static Texture2D RandomMonsterImage()
	{
		int num = UnityEngine.Random.Range(0, PhoneResourceController.monsterimages.Length);
		return PhoneResourceController.monsterimages[num];
	}

	// Token: 0x06000387 RID: 903 RVA: 0x00015C10 File Offset: 0x00013E10
	public static SpriteSet GetSpriteSet(string name)
	{
		return SpriteController.GetSpriteSet(name);
	}

	// Token: 0x06000388 RID: 904 RVA: 0x00015C18 File Offset: 0x00013E18
	public static SpriteSet RandomMonsterSpriteSet()
	{
		if (PhoneResourceController.instance == null)
		{
			PhoneResourceController.Init();
		}
		List<string> list = new List<string>(SpriteController.spritesets.Keys);
		int index = UnityEngine.Random.Range(0, list.Count);
		while (list[index] == "hawk")
		{
			index = UnityEngine.Random.Range(0, list.Count);
		}
		return SpriteController.GetSpriteSet(list[index]);
	}

	// Token: 0x1700007C RID: 124
	// (get) Token: 0x06000389 RID: 905 RVA: 0x00015C8C File Offset: 0x00013E8C
	// (set) Token: 0x0600038A RID: 906 RVA: 0x00015CC4 File Offset: 0x00013EC4
	public static PhoneResourceController instance
	{
		get
		{
			if (PhoneResourceController._instance == null)
			{
				PhoneResourceController._instance = (UnityEngine.Object.FindObjectOfType(typeof(PhoneResourceController)) as PhoneResourceController);
				PhoneResourceController.Init();
			}
			return PhoneResourceController._instance;
		}
		set
		{
			PhoneResourceController._instance = value;
		}
	}

	// Token: 0x0600038B RID: 907 RVA: 0x00015CCC File Offset: 0x00013ECC
	private void Awake()
	{
		if (PhoneResourceController.instance == null)
		{
			PhoneResourceController.Init();
		}
	}

	// Token: 0x0600038C RID: 908 RVA: 0x00015CE4 File Offset: 0x00013EE4
	private void Start()
	{
	}

	// Token: 0x0600038D RID: 909 RVA: 0x00015CE8 File Offset: 0x00013EE8
	private void SetupSprites()
	{
		this.SetupMonster("fly", 1f, new Vector2(5f, 7f));
		this.SetupMonster("devil", 3f, new Vector2(5f, 7f));
		this.SetupMonster("mouse", 5f, new Vector2(5f, 7f));
		this.SetupMonster("pink", 7f, new Vector2(5f, 7f));
		this.SetupMonster("slime", 9f, new Vector2(5f, 7f));
		this.SetupMonster("red", 1f, 11f);
		this.SetupMonster("jack", 1f, 13f);
		this.SetupMonster("white", 5f, 11f);
		this.SetupMonster("black", 5f, 13f);
		this.SetupMonster("hawk", 9f, 11f);
	}

	// Token: 0x0600038E RID: 910 RVA: 0x00015DFC File Offset: 0x00013FFC
	private void SetupBullets(SpriteSet sprset)
	{
		sprset.AddAnimation("bullet", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(11f, 5f, 1f, 1f)));
	}

	// Token: 0x0600038F RID: 911 RVA: 0x00015E38 File Offset: 0x00014038
	private void SetupBullets(SpriteSet sprset, Vector2 pos)
	{
		sprset.AddAnimation("bullet", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(11f, 5f, 1f, 1f)));
	}

	// Token: 0x06000390 RID: 912 RVA: 0x00015E74 File Offset: 0x00014074
	private void SetupMonster(string name, float xoffset, float yoffset)
	{
		SpriteSet spriteSet = SpriteController.CreateSpriteSet(name, this._monstersheet);
		spriteSet.AddAnimation("attack", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(xoffset + 1f, yoffset + 1f, 1f, 1f)));
		spriteSet.AddAnimation("walk", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(xoffset, yoffset, 4f, 1f)));
		this.SetupBullets(spriteSet);
	}

	// Token: 0x06000391 RID: 913 RVA: 0x00015F04 File Offset: 0x00014104
	private void SetupMonster(string name, float yoffset, Vector2 bulletpos)
	{
		SpriteSet sprset = this.SetupMonster(name, yoffset);
		this.SetupBullets(sprset, bulletpos);
	}

	// Token: 0x06000392 RID: 914 RVA: 0x00015F24 File Offset: 0x00014124
	private SpriteSet SetupMonster(string name, float yoffset)
	{
		SpriteSet spriteSet = SpriteController.CreateSpriteSet(name, this._monstersheet);
		spriteSet.AddAnimation("attack", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(2f, yoffset + 1f, 1f, 1f)));
		spriteSet.AddAnimation("walk", SpriteController.AutoGenAnimation(new Vector2(16f, 16f), new Rect(1f, yoffset, 4f, 1f)));
		return spriteSet;
	}

	// Token: 0x06000393 RID: 915 RVA: 0x00015FB0 File Offset: 0x000141B0
	private void SetupPhoneShooterLevels()
	{
		PhoneResourceController.phoneshooterlevels.Clear();
		PhoneResourceController.phoneshooterlevels.Add(new PhoneShooterLevel("Grassy Farm", 1, 0));
		PhoneResourceController.phoneshooterlevels.Add(new PhoneShooterLevel("Damp Desert", 5, 1));
		PhoneResourceController.phoneshooterlevels.Add(new PhoneShooterLevel("Scrappy Seas", 10, 2));
		PhoneResourceController.phoneshooterlevels.Add(new PhoneShooterLevel("Cloud Sky", 15, 3));
		PhoneResourceController.phoneshooterlevels.Add(new PhoneShooterLevel("Space Galaxy", 20, 4));
	}

	// Token: 0x06000394 RID: 916 RVA: 0x00016038 File Offset: 0x00014238
	private void SetupMonsterTypes()
	{
		this.monsterTypes.Clear();
		MonsterType monsterType = new MonsterType("Bug", "fly", MonsterAI.Jitter);
		monsterType.statMods = new float[]
		{
			0.75f,
			0.8f,
			0.9f,
			1f
		};
		monsterType.speedMod = 1.5f;
		monsterType.scaleMod = 0.75f;
		monsterType.flyingAnimate = true;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Demon", "devil", MonsterAI.Mirror);
		monsterType.statMods = new float[]
		{
			1.25f,
			0.9f,
			1f,
			0.75f
		};
		monsterType.speedMod = 1f;
		monsterType.flyingAnimate = true;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Cat", "mouse", MonsterAI.Circle);
		monsterType.statMods = new float[]
		{
			1.25f,
			0.8f,
			0.8f,
			1.25f
		};
		monsterType.speedMod = 1.1f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Rabbit", "pink", MonsterAI.Run);
		monsterType.statMods = new float[]
		{
			0.75f,
			1.5f,
			0.75f,
			1.5f
		};
		monsterType.speedMod = 0.9f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Ghost", "slime", MonsterAI.CircleCW);
		monsterType.statMods = new float[]
		{
			0.4f,
			0.5f,
			2f,
			2f
		};
		monsterType.speedMod = 0.9f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Candle", "red", MonsterAI.Mirror);
		monsterType.statMods = new float[]
		{
			2f,
			0.5f,
			2f,
			0.5f
		};
		monsterType.speedMod = 1f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Pumk", "jack", MonsterAI.Horizontal);
		monsterType.statMods = new float[]
		{
			0.8f,
			1f,
			1.5f,
			1.5f
		};
		monsterType.speedMod = 0.75f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Pup", "white", MonsterAI.Goto);
		monsterType.statMods = new float[]
		{
			1.2f,
			1f,
			0.75f,
			0.75f
		};
		monsterType.speedMod = 1.25f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Ink", "black", MonsterAI.Vertical);
		monsterType.statMods = new float[]
		{
			0.8f,
			0.8f,
			2f,
			0.8f
		};
		monsterType.speedMod = 0.9f;
		this.monsterTypes.Add(monsterType);
		monsterType = new MonsterType("Hawk", "hawk", MonsterAI.Circle);
		monsterType.flyingAnimate = true;
		this.monsterTypes.Add(monsterType);
		foreach (MonsterType monsterType2 in this.monsterTypes)
		{
			this.monsterTypeDic.Add(monsterType2.typeName, monsterType2);
		}
	}

	// Token: 0x06000395 RID: 917 RVA: 0x00016328 File Offset: 0x00014528
	public static MonsterType GetMonsterType(string typename)
	{
		if (PhoneResourceController.instance.monsterTypeDic.ContainsKey(typename))
		{
			return PhoneResourceController.instance.monsterTypeDic[typename];
		}
		Debug.LogWarning("Oh No! The monster type " + typename + " is not in the monstertype dictionary... dang...");
		return PhoneResourceController.instance.monsterTypes[0];
	}

	// Token: 0x06000396 RID: 918 RVA: 0x00016380 File Offset: 0x00014580
	public static MonsterType RandomMonsterType()
	{
		int index = UnityEngine.Random.Range(0, PhoneResourceController.instance.monsterTypes.Count - 1);
		return PhoneResourceController.instance.monsterTypes[index];
	}

	// Token: 0x06000397 RID: 919 RVA: 0x000163B8 File Offset: 0x000145B8
	public static void SaveMonsterInfoCard(PhoneMonster monster, PhoneResourceController.TextureReturn texReturn)
	{
		PhoneResourceController.instance.StartCoroutine(PhoneResourceController.instance.MakeMonsterInfoTexture(monster, texReturn));
	}

	// Token: 0x06000398 RID: 920 RVA: 0x000163D4 File Offset: 0x000145D4
	public IEnumerator MakeMonsterInfoTexture(PhoneMonster monster, PhoneResourceController.TextureReturn texReturn)
	{
		int width = 240;
		int height = 135;
		if (this.backRend && this.infoBGs.Length > 0)
		{
			this.backRend.material.mainTexture = this.infoBGs[UnityEngine.Random.Range(0, this.infoBGs.Length)];
		}
		this.spriteCamera.enabled = true;
		this.infoBooth.gameObject.SetActiveRecursively(true);
		this.statDisplay.SetMonster(monster);
		string anim = "walk";
		if (UnityEngine.Random.value > 0.75f)
		{
			anim = "attack";
		}
		this.statDisplay.spriteplayer.SetAnimation(anim);
		this.statDisplay.OnUpdate();
		yield return null;
		Texture2D tex = new Texture2D(width, height, TextureFormat.RGB24, false);
		RenderTexture rt = new RenderTexture(width, height, 24);
		rt.filterMode = FilterMode.Point;
		this.spriteCamera.targetTexture = rt;
		yield return new WaitForEndOfFrame();
		this.spriteCamera.Render();
		RenderTexture.active = rt;
		tex.ReadPixels(new Rect(0f, 0f, (float)width, (float)height), 0, 0);
		this.spriteCamera.targetTexture = null;
		RenderTexture.active = null;
		UnityEngine.Object.Destroy(rt);
		yield return null;
		this.spriteCamera.enabled = false;
		this.infoBooth.gameObject.SetActiveRecursively(false);
		texReturn(tex);
		yield break;
	}

	// Token: 0x040002D9 RID: 729
	public Texture2D _monstersheet;

	// Token: 0x040002DA RID: 730
	public Texture2D[] _monsterimages;

	// Token: 0x040002DB RID: 731
	public Texture2D[] _levelbackgrounds;

	// Token: 0x040002DC RID: 732
	public static List<PhoneShooterLevel> phoneshooterlevels = new List<PhoneShooterLevel>();

	// Token: 0x040002DD RID: 733
	public List<Texture2D> _zine_images = new List<Texture2D>();

	// Token: 0x040002DE RID: 734
	private static bool has_init = false;

	// Token: 0x040002DF RID: 735
	private static PhoneResourceController _instance;

	// Token: 0x040002E0 RID: 736
	public List<MonsterType> monsterTypes = new List<MonsterType>();

	// Token: 0x040002E1 RID: 737
	public Dictionary<string, MonsterType> monsterTypeDic = new Dictionary<string, MonsterType>();

	// Token: 0x040002E2 RID: 738
	public Transform infoBooth;

	// Token: 0x040002E3 RID: 739
	public Camera spriteCamera;

	// Token: 0x040002E4 RID: 740
	public PhoneMonsterStatsDisplay statDisplay;

	// Token: 0x040002E5 RID: 741
	public Renderer backRend;

	// Token: 0x040002E6 RID: 742
	public Texture2D[] infoBGs = new Texture2D[0];

	// Token: 0x020000E6 RID: 230
	// (Invoke) Token: 0x060008C3 RID: 2243
	public delegate void TextureReturn(Texture2D tex);
}
