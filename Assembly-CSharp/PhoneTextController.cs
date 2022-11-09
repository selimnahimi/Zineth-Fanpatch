using System;
using UnityEngine;

// Token: 0x02000059 RID: 89
public static class PhoneTextController
{
	// Token: 0x060003BD RID: 957 RVA: 0x000169FC File Offset: 0x00014BFC
	public static Font GetFont(string fontName)
	{
		if (fontName == "none")
		{
			return null;
		}
		string text = "fonts/" + fontName;
		MonoBehaviour.print("loading font from " + text);
		return Resources.Load(text) as Font;
	}

	// Token: 0x060003BE RID: 958 RVA: 0x00016A44 File Offset: 0x00014C44
	public static bool LoadFont(string fontName, TextMesh mesh)
	{
		Font font = PhoneTextController.GetFont(fontName);
		mesh.renderer.material.mainTexture = font.material.mainTexture;
		mesh.font = font;
		return true;
	}

	// Token: 0x060003BF RID: 959 RVA: 0x00016A7C File Offset: 0x00014C7C
	public static Color GetColor(string colorName)
	{
		switch (colorName)
		{
		case "red":
			return Color.red;
		case "blue":
			return Color.blue;
		case "green":
			return Color.green;
		case "white":
			return Color.white;
		case "black":
			return Color.black;
		case "yellow":
			return Color.yellow;
		}
		MonoBehaviour.print("unknown color: <" + colorName + ">");
		return Color.white;
	}

	// Token: 0x060003C0 RID: 960 RVA: 0x00016B88 File Offset: 0x00014D88
	public static bool LoadColor(string colorName, TextMesh mesh)
	{
		Color color = PhoneTextController.GetColor(colorName);
		mesh.renderer.material.color = color;
		return true;
	}

	// Token: 0x060003C1 RID: 961 RVA: 0x00016BB0 File Offset: 0x00014DB0
	public static string WrapText(string text, int charwidth)
	{
		string text2 = string.Empty;
		string[] array = text.Split(new char[]
		{
			' '
		});
		string text3 = string.Empty;
		string text4 = string.Empty;
		string text5 = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			text5 = array[i].Trim();
			string str = text4;
			if (i == 0)
			{
				text4 = array[0];
				text2 = text3 + text4;
			}
			if (i > 0)
			{
				text4 = text4 + " " + text5;
				text2 = text3 + text4;
			}
			if (text4.Length > charwidth)
			{
				text3 = text3 + str + "\n";
				text2 = text3;
				text4 = text5;
			}
			else
			{
				text5 = string.Empty;
			}
		}
		if (text5 != string.Empty)
		{
			text2 += text5;
		}
		return text2;
	}

	// Token: 0x060003C2 RID: 962 RVA: 0x00016C88 File Offset: 0x00014E88
	public static Vector2 GetTextMeshSize(string text, Font font, int fontSize, FontStyle fontStyle, TextAnchor alignment)
	{
		if (PhoneTextController.guistyle == null)
		{
			PhoneTextController.guistyle = new GUIStyle();
		}
		PhoneTextController.guistyle.font = font;
		PhoneTextController.guistyle.fontSize = fontSize;
		PhoneTextController.guistyle.fontStyle = fontStyle;
		PhoneTextController.guistyle.alignment = alignment;
		return PhoneTextController.guistyle.CalcSize(new GUIContent(text)) / 10f;
	}

	// Token: 0x060003C3 RID: 963 RVA: 0x00016CF0 File Offset: 0x00014EF0
	public static Vector2 GetTextMeshSize(string text, TextMesh mesh)
	{
		Vector2 textMeshSize = PhoneTextController.GetTextMeshSize(text, mesh.font, mesh.fontSize, mesh.fontStyle, mesh.anchor);
		textMeshSize.x *= mesh.transform.localScale.x * mesh.characterSize;
		if (textMeshSize.x == 0f)
		{
			textMeshSize.y = 0f;
		}
		else
		{
			textMeshSize.y *= mesh.transform.localScale.y * mesh.characterSize;
		}
		return textMeshSize;
	}

	// Token: 0x040002F9 RID: 761
	public static string filePath = "dialog/";

	// Token: 0x040002FA RID: 762
	public static PhoneButton buttonprefab;

	// Token: 0x040002FB RID: 763
	private static GUIStyle guistyle;
}
