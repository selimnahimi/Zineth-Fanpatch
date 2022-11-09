using System;
using UnityEngine;

// Token: 0x020000A4 RID: 164
public class Quitter : MonoBehaviour
{
	// Token: 0x060006D6 RID: 1750 RVA: 0x0002C398 File Offset: 0x0002A598
	private void Start()
	{
		if (Quitter.quitter != null)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		Quitter.quitter = this;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		this._guiText = base.guiText;
		this.textRect = this._guiText.GetScreenRect();
		this._guiText.enabled = false;
		this._guiText.material.color = this.color;
	}

	// Token: 0x060006D7 RID: 1751 RVA: 0x0002C410 File Offset: 0x0002A610
	private void Update()
	{
		Application.loadedLevelName == "Loader 3";
		if (Input.GetKey(this.quitKey))
		{
			this._guiText.enabled = true;
			this.guiTimer = this.showGuiTime;
			this.holdTime += Time.deltaTime;
			if (this.holdTime >= this.requiredHoldTime)
			{
				this.Quit();
			}
			this.progress = this.holdTime / this.requiredHoldTime;
		}
		else
		{
			this._guiText.enabled = (this.guiTimer > 0f);
			this.guiTimer -= Time.deltaTime;
			this.holdTime = 0f;
			if (this._guiText.enabled)
			{
				this.progress = Mathf.Lerp(this.progress, 0f, Time.deltaTime / this.showGuiTime * 2f);
			}
			else
			{
				this.progress = 0f;
			}
			this.holdTime = this.progress * this.requiredHoldTime;
		}
	}

	// Token: 0x060006D8 RID: 1752 RVA: 0x0002C528 File Offset: 0x0002A728
	private void OnGUI()
	{
		if (this.debug)
		{
			this.progress = 1f;
		}
		if ((this._guiText.enabled && this.drawBar && this.progress > 0f) || this.debug)
		{
			Rect position = new Rect(this.textRect.x + this.barPosition.x, (float)Screen.height - this.textRect.y + this.barPosition.y, this.textRect.width * this.progress, this.barSize.y);
			Color color = GUI.color;
			GUI.color = this.color;
			GUI.DrawTexture(position, this.barTexture);
			GUI.color = color;
		}
	}

	// Token: 0x060006D9 RID: 1753 RVA: 0x0002C600 File Offset: 0x0002A800
	private void Quit()
	{
		Application.Quit();
	}

	// Token: 0x040005B0 RID: 1456
	private static Quitter quitter;

	// Token: 0x040005B1 RID: 1457
	private GUIText _guiText;

	// Token: 0x040005B2 RID: 1458
	public Color color = Color.red;

	// Token: 0x040005B3 RID: 1459
	public float requiredHoldTime = 1f;

	// Token: 0x040005B4 RID: 1460
	private float holdTime;

	// Token: 0x040005B5 RID: 1461
	public float showGuiTime = 1f;

	// Token: 0x040005B6 RID: 1462
	private float guiTimer;

	// Token: 0x040005B7 RID: 1463
	private KeyCode quitKey = KeyCode.Escape;

	// Token: 0x040005B8 RID: 1464
	public bool drawBar = true;

	// Token: 0x040005B9 RID: 1465
	public Vector2 barPosition;

	// Token: 0x040005BA RID: 1466
	public Vector2 barSize;

	// Token: 0x040005BB RID: 1467
	public Texture barTexture;

	// Token: 0x040005BC RID: 1468
	private Rect textRect;

	// Token: 0x040005BD RID: 1469
	private float progress;

	// Token: 0x040005BE RID: 1470
	public bool debug;
}
