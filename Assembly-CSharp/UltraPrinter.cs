using System;
using System.IO;
using UnityEngine;

// Token: 0x0200008D RID: 141
public class UltraPrinter : MonoBehaviour
{
	// Token: 0x170000C7 RID: 199
	// (get) Token: 0x060005F3 RID: 1523 RVA: 0x00026988 File Offset: 0x00024B88
	public static UltraPrinter instance
	{
		get
		{
			if (!UltraPrinter._instance)
			{
				UltraPrinter._instance = (UnityEngine.Object.FindObjectOfType(typeof(UltraPrinter)) as UltraPrinter);
			}
			return UltraPrinter._instance;
		}
	}

	// Token: 0x060005F4 RID: 1524 RVA: 0x000269B8 File Offset: 0x00024BB8
	public static bool Print(int index)
	{
		return UltraPrinter.Print(PhoneResourceController.zine_images[index].name);
	}

	// Token: 0x060005F5 RID: 1525 RVA: 0x000269D0 File Offset: 0x00024BD0
	public static bool Print(string filename)
	{
		if (!UltraPrinter.enable_print)
		{
			return true;
		}
		if (!filename.EndsWith(".png"))
		{
			filename += ".png";
		}
		string sourceFileName = UltraPrinter.orig_file_dir + filename;
		string text = UltraPrinter.file_dir + filename;
		File.Delete(text);
		File.Copy(sourceFileName, text);
		return true;
	}

	// Token: 0x040004AF RID: 1199
	private static UltraPrinter _instance;

	// Token: 0x040004B0 RID: 1200
	public static string file_dir = "Assets/Resources/printing/print_prison/";

	// Token: 0x040004B1 RID: 1201
	public static string orig_file_dir = "Assets/Resources/printing/";

	// Token: 0x040004B2 RID: 1202
	public static bool enable_print = true;
}
