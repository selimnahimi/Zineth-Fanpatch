using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200005A RID: 90
public class TutorialSlides : MonoBehaviour
{
	// Token: 0x17000081 RID: 129
	// (get) Token: 0x060003C6 RID: 966 RVA: 0x00016DE0 File Offset: 0x00014FE0
	public static TutorialSlides instance
	{
		get
		{
			if (!TutorialSlides._instance)
			{
				TutorialSlides._instance = (UnityEngine.Object.FindObjectOfType(typeof(TutorialSlides)) as TutorialSlides);
			}
			return TutorialSlides._instance;
		}
	}

	// Token: 0x060003C7 RID: 967 RVA: 0x00016E10 File Offset: 0x00015010
	public static Texture2D GetKeyboardSlide(Texture2D slide)
	{
		if (TutorialSlides.slide_dictionary.ContainsKey(slide))
		{
			return TutorialSlides.slide_dictionary[slide];
		}
		return slide;
	}

	// Token: 0x060003C8 RID: 968 RVA: 0x00016E30 File Offset: 0x00015030
	private void Awake()
	{
		TutorialSlides.slide_dictionary.Clear();
		TutorialSlides.slideset_dictionary.Clear();
		int num = 0;
		while (num < this.controller_textures.Length && num < this.keyboard_textures.Length)
		{
			this.AddSlide(this.controller_textures[num], this.keyboard_textures[num]);
			num++;
		}
		foreach (TutorialSlides.Slideset slideset in TutorialSlides.slide_sets)
		{
			this.AddSlideSet(slideset.set_name, slideset);
		}
	}

	// Token: 0x060003C9 RID: 969 RVA: 0x00016EEC File Offset: 0x000150EC
	public void AddSlide(Texture2D tex1, Texture2D tex2)
	{
		if (!TutorialSlides.slide_dictionary.ContainsKey(tex1))
		{
			TutorialSlides.slide_dictionary.Add(tex1, tex2);
		}
	}

	// Token: 0x060003CA RID: 970 RVA: 0x00016F0C File Offset: 0x0001510C
	public void AddSlideSet(string setname, TutorialSlides.Slideset sset)
	{
		if (!TutorialSlides.slideset_dictionary.ContainsKey(setname))
		{
			TutorialSlides.slideset_dictionary.Add(setname, sset);
		}
	}

	// Token: 0x17000082 RID: 130
	// (get) Token: 0x060003CB RID: 971 RVA: 0x00016F2C File Offset: 0x0001512C
	public static List<TutorialSlides.Slideset> slide_sets
	{
		get
		{
			return TutorialSlides.instance._slide_sets;
		}
	}

	// Token: 0x17000083 RID: 131
	// (get) Token: 0x060003CC RID: 972 RVA: 0x00016F38 File Offset: 0x00015138
	public static Dictionary<string, TutorialSlides.Slideset> slideset_dictionary
	{
		get
		{
			return TutorialSlides.instance._slideset_dictionary;
		}
	}

	// Token: 0x040002FD RID: 765
	public Texture2D[] controller_textures = new Texture2D[0];

	// Token: 0x040002FE RID: 766
	public Texture2D[] keyboard_textures = new Texture2D[0];

	// Token: 0x040002FF RID: 767
	public static Dictionary<Texture2D, Texture2D> slide_dictionary = new Dictionary<Texture2D, Texture2D>();

	// Token: 0x04000300 RID: 768
	protected static TutorialSlides _instance;

	// Token: 0x04000301 RID: 769
	public List<TutorialSlides.Slideset> _slide_sets = new List<TutorialSlides.Slideset>();

	// Token: 0x04000302 RID: 770
	public Dictionary<string, TutorialSlides.Slideset> _slideset_dictionary = new Dictionary<string, TutorialSlides.Slideset>();

	// Token: 0x0200005B RID: 91
	[Serializable]
	public class Slideset
	{
		// Token: 0x04000303 RID: 771
		public string set_name;

		// Token: 0x04000304 RID: 772
		public List<Texture2D> slides = new List<Texture2D>();
	}
}
