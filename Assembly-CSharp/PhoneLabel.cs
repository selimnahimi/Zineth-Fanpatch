using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000067 RID: 103
public class PhoneLabel : PhoneElement
{
	// Token: 0x17000095 RID: 149
	// (get) Token: 0x06000446 RID: 1094 RVA: 0x00019998 File Offset: 0x00017B98
	// (set) Token: 0x06000445 RID: 1093 RVA: 0x0001998C File Offset: 0x00017B8C
	public string text
	{
		get
		{
			return this._text;
		}
		set
		{
			this.SetText(value);
		}
	}

	// Token: 0x17000096 RID: 150
	// (get) Token: 0x06000448 RID: 1096 RVA: 0x000199B0 File Offset: 0x00017BB0
	// (set) Token: 0x06000447 RID: 1095 RVA: 0x000199A0 File Offset: 0x00017BA0
	private string _meshtext
	{
		get
		{
			return this.textmesh.text;
		}
		set
		{
			this.textmesh.text = value;
		}
	}

	// Token: 0x06000449 RID: 1097 RVA: 0x000199C0 File Offset: 0x00017BC0
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x0600044A RID: 1098 RVA: 0x000199C8 File Offset: 0x00017BC8
	public override void Init()
	{
		if (this.textmesh == null)
		{
			this.textmesh = base.GetComponent<TextMesh>();
		}
		this.wantedpos = base.transform.localPosition;
		this.wantedrot = base.transform.localRotation;
		if (!this.textmesh)
		{
			Debug.LogWarning("no textmesh: " + base.name);
		}
		if (this.text != string.Empty)
		{
			this.SetText(this.text);
		}
		else if (this._meshtext != string.Empty)
		{
			this.SetText(this._meshtext);
		}
	}

	// Token: 0x0600044B RID: 1099 RVA: 0x00019A80 File Offset: 0x00017C80
	public override void OnLoad()
	{
		base.OnLoad();
		if (this.overrideColor)
		{
			this.textmesh.renderer.material.color = this.color;
		}
		else
		{
			this.textmesh.renderer.material.color = PhoneMemory.settings.textColor;
		}
	}

	// Token: 0x0600044C RID: 1100 RVA: 0x00019AE0 File Offset: 0x00017CE0
	public void SetColor(Color col)
	{
		this.textmesh.renderer.material.color = col;
	}

	// Token: 0x0600044D RID: 1101 RVA: 0x00019AF8 File Offset: 0x00017CF8
	private void Update()
	{
		if (this.wrapdebug)
		{
			this.SetText(this.text);
		}
		this.wrapdebug = false;
	}

	// Token: 0x0600044E RID: 1102 RVA: 0x00019B18 File Offset: 0x00017D18
	private void Start()
	{
		if (this.overrideColor)
		{
			this.textmesh.renderer.material.color = this.color;
		}
		else
		{
			this.textmesh.renderer.material.color = PhoneMemory.settings.textColor;
		}
	}

	// Token: 0x0600044F RID: 1103 RVA: 0x00019B70 File Offset: 0x00017D70
	public void Hide()
	{
		base.gameObject.active = false;
		if (this.shadow_label)
		{
			this.shadow_label.Hide();
		}
		if (this.icon)
		{
			this.icon.gameObject.active = false;
		}
	}

	// Token: 0x06000450 RID: 1104 RVA: 0x00019BC8 File Offset: 0x00017DC8
	public virtual void SetText(string newtext)
	{
		this._text = newtext;
		if (this.wraptext)
		{
			this.WrapText();
		}
		else
		{
			this._meshtext = this._text;
		}
		if (this.shadow_label)
		{
			this.shadow_label.SetText(this._text);
		}
	}

	// Token: 0x06000451 RID: 1105 RVA: 0x00019C20 File Offset: 0x00017E20
	protected virtual void WrapText()
	{
		Transform parent = this.textmesh.transform.parent;
		if (parent != null)
		{
			this.textmesh.transform.parent = null;
		}
		this.InnerWrapText();
		if (parent != null)
		{
			this.textmesh.transform.parent = parent;
		}
	}

	// Token: 0x06000452 RID: 1106 RVA: 0x00019C80 File Offset: 0x00017E80
	protected virtual Vector2 GetTextSize(string text)
	{
		if (text == this._prevtext)
		{
			return this._prevsize;
		}
		this._prevtext = text;
		this._prevsize = PhoneTextController.GetTextMeshSize(text, this.textmesh);
		return this._prevsize;
	}

	// Token: 0x06000453 RID: 1107 RVA: 0x00019CBC File Offset: 0x00017EBC
	protected virtual void InnerWrapText()
	{
		bool flag = true;
		int num = 0;
		string[] collection = this._text.Split(new char[]
		{
			' '
		});
		List<string> list = new List<string>(collection);
		string empty = string.Empty;
		string text = string.Empty;
		int num2 = 0;
		while (list.Count > 0)
		{
			num++;
			if (num >= 1024)
			{
				Debug.Log(text);
				Debug.LogError("oh no there are a fuck load of loops");
				this._meshtext = text;
				return;
			}
			string text2 = text;
			if (!flag)
			{
				text += " ";
			}
			flag = false;
			text += list[0];
			if (this.GetTextSize(text).x > this.wrapwidth)
			{
				if (text2.Length > 0)
				{
					text = text2 + "\n" + list[0];
				}
				else
				{
					text = text2 + list[0];
				}
				if (this.GetTextSize(text).x > this.wrapwidth)
				{
					string text3 = list[0];
					string text4 = text2;
					if (text2.Length > 0)
					{
						text4 += "\n";
					}
					text = text4;
					int num3 = 0;
					while (this.GetTextSize(text).x <= this.wrapwidth && num3 < text3.Length)
					{
						text = text4 + text3.Substring(0, num3);
						num++;
						if (num >= 512)
						{
							Debug.LogError(string.Concat(new string[]
							{
								"wow just look at these loops\n",
								text2,
								", ",
								text3,
								", ",
								text3.Substring(0, num3)
							}));
							this._meshtext = text;
							return;
						}
						num3++;
					}
					num3 -= 2;
					if (num3 >= 0)
					{
						text = text4 + text3.Substring(0, num3);
					}
					num3 = Mathf.Clamp(num3, 0, text3.Length - 2);
					if (text3.Length >= 1)
					{
						list.Insert(1, text3.Remove(0, num3));
					}
				}
			}
			num2++;
			list.RemoveAt(0);
			if (this.cutz && this.GetTextSize(text).y > this.cutzheight)
			{
				text = text2 + "...";
				this._meshtext = text;
				return;
			}
		}
		this._meshtext = text;
	}

	// Token: 0x0400035C RID: 860
	public TextMesh textmesh;

	// Token: 0x0400035D RID: 861
	public PhoneLabel shadow_label;

	// Token: 0x0400035E RID: 862
	public bool overrideColor;

	// Token: 0x0400035F RID: 863
	public Color color;

	// Token: 0x04000360 RID: 864
	public bool wraptext;

	// Token: 0x04000361 RID: 865
	public float wrapwidth = 4f;

	// Token: 0x04000362 RID: 866
	public bool cutz;

	// Token: 0x04000363 RID: 867
	public float cutzheight = 4f;

	// Token: 0x04000364 RID: 868
	public Transform icon;

	// Token: 0x04000365 RID: 869
	private string _text = string.Empty;

	// Token: 0x04000366 RID: 870
	public bool wrapdebug;

	// Token: 0x04000367 RID: 871
	private string _prevtext = string.Empty;

	// Token: 0x04000368 RID: 872
	private Vector2 _prevsize = Vector2.zero;
}
