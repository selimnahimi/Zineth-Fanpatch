using System;
using UnityEngine;

// Token: 0x02000087 RID: 135
public class PhoneViewController : MonoBehaviour
{
	// Token: 0x170000BE RID: 190
	// (get) Token: 0x060005AC RID: 1452 RVA: 0x0002464C File Offset: 0x0002284C
	public float deltatime
	{
		get
		{
			return PhoneController.deltatime;
		}
	}

	// Token: 0x060005AD RID: 1453 RVA: 0x00024654 File Offset: 0x00022854
	private void Start()
	{
		if (this.phonecontroller == null)
		{
			this.phonecontroller = (UnityEngine.Object.FindObjectOfType(typeof(PhoneController)) as PhoneController);
		}
		this.rendertex = new RenderTexture(480, 800, 0);
		this.phonecontroller.phonecam.targetTexture = this.rendertex;
		this.phoneviewscreen.renderer.material.mainTexture = this.rendertex;
		this.phoneviewscreen.renderer.material.mainTextureScale = Vector2.one;
		this.phoneviewscreen.renderer.material.mainTextureOffset = Vector2.zero;
		this.phonecontroller.phonecam.orthographicSize = 4f;
		Color color = this.phoneviewscreen.renderer.material.color;
		color.a = 0.9f;
		this.phoneviewscreen.renderer.material.color = color;
		this.phoneviewlight.transform.parent.renderer.material.color = Color.black;
		if (this.zinerenderer)
		{
			this.normal_zine_pos = this.zinerenderer.transform.position;
			this.hidden_zine_pos = this.normal_zine_pos + Vector3.down * 10f;
			this.normal_zine_scale = this.zinerenderer.transform.localScale;
		}
		this.HideZine();
	}

	// Token: 0x060005AE RID: 1454 RVA: 0x000247DC File Offset: 0x000229DC
	private void Update()
	{
		if (!PhoneController._use_fixed_update)
		{
			this.HandleControls();
			this.HandleTransition();
			this.HandleZine();
			this.HandleLight();
			this.HandleStick();
		}
	}

	// Token: 0x060005AF RID: 1455 RVA: 0x00024814 File Offset: 0x00022A14
	public bool ShowZine(Texture2D texture)
	{
		return this.ShowZine(texture, false);
	}

	// Token: 0x060005B0 RID: 1456 RVA: 0x00024820 File Offset: 0x00022A20
	public bool ShowZine(Texture2D texture, bool resize)
	{
		this.showing_zine = true;
		if (!this.zinerenderer)
		{
			return false;
		}
		this.zinerenderer.gameObject.active = true;
		this.zinerenderer.material.mainTexture = texture;
		this.zinerenderer.transform.position = this.hidden_zine_pos;
		if (resize)
		{
			this.has_resized = false;
		}
		else
		{
			this.has_resized = true;
			this.zinerenderer.transform.localScale = this.normal_zine_scale;
		}
		return true;
	}

	// Token: 0x060005B1 RID: 1457 RVA: 0x000248B0 File Offset: 0x00022AB0
	public bool HideZine()
	{
		this.showing_zine = false;
		return true;
	}

	// Token: 0x060005B2 RID: 1458 RVA: 0x000248BC File Offset: 0x00022ABC
	private void HandleZine()
	{
		if (!this.zinerenderer)
		{
			return;
		}
		if (!this.has_resized)
		{
			this.ResizeZine();
		}
		Vector3 vector = this.hidden_zine_pos;
		if (this.showing_zine)
		{
			vector = this.normal_zine_pos;
		}
		if (this.zinerenderer.transform.position != vector)
		{
			this.zinerenderer.transform.position = Vector3.Lerp(this.zinerenderer.transform.position, vector, this.deltatime * 10f);
		}
		if (Vector3.Distance(this.zinerenderer.transform.position, vector) < 0.01f)
		{
			this.zinerenderer.transform.position = vector;
			if (!this.showing_zine)
			{
				this.zinerenderer.gameObject.active = false;
			}
		}
	}

	// Token: 0x060005B3 RID: 1459 RVA: 0x000249A0 File Offset: 0x00022BA0
	private void ResizeZine()
	{
		if (this.has_resized)
		{
			return;
		}
		Vector3 localScale = this.zinerenderer.transform.localScale;
		Texture mainTexture = this.zinerenderer.material.mainTexture;
		if (mainTexture != null)
		{
			Vector2 vector = new Vector2((float)mainTexture.width, (float)mainTexture.height);
			Vector2 vector2 = new Vector2(localScale.x, localScale.z);
			float magnitude = vector2.magnitude;
			vector = vector.normalized * magnitude;
			this.zinerenderer.transform.localScale = new Vector3(vector.x, localScale.y, vector.y);
			this.has_resized = true;
		}
	}

	// Token: 0x060005B4 RID: 1460 RVA: 0x00024A58 File Offset: 0x00022C58
	private void Flicker()
	{
		Color color = this.phoneviewscreen.renderer.material.color;
		color.a = UnityEngine.Random.Range(0.86f, 0.92f);
		this.phoneviewscreen.renderer.material.color = color;
	}

	// Token: 0x060005B5 RID: 1461 RVA: 0x00024AA8 File Offset: 0x00022CA8
	private void HandleControls()
	{
		if (Input.GetButtonDown("CellOpen"))
		{
			this.ToggleOpen();
		}
		if (Input.GetButtonDown("CellHome"))
		{
			this.OnHomeButton();
		}
	}

	// Token: 0x060005B6 RID: 1462 RVA: 0x00024AE0 File Offset: 0x00022CE0
	public void OnHomeButton()
	{
		this.OnHomeButton(false);
	}

	// Token: 0x060005B7 RID: 1463 RVA: 0x00024AEC File Offset: 0x00022CEC
	public void OnHomeButton(bool force)
	{
		this.phonecontroller.OnHomePressed(force);
	}

	// Token: 0x060005B8 RID: 1464 RVA: 0x00024AFC File Offset: 0x00022CFC
	public void ToggleOpen()
	{
		this.SetOpen(!this.open);
	}

	// Token: 0x060005B9 RID: 1465 RVA: 0x00024B10 File Offset: 0x00022D10
	public void SetOpen(bool isopen)
	{
		this.SetOpen(isopen, false);
	}

	// Token: 0x060005BA RID: 1466 RVA: 0x00024B1C File Offset: 0x00022D1C
	public void SetOpen(bool isopen, bool force)
	{
		if (!this.phonecontroller.allow_open && !force)
		{
			return;
		}
		if (this.open == isopen)
		{
			return;
		}
		this.open = isopen;
		if (this.open)
		{
			this.phonecontroller.OnScreenOpen(force);
		}
		else
		{
			this.phonecontroller.OnScreenClose(force);
		}
	}

	// Token: 0x060005BB RID: 1467 RVA: 0x00024B7C File Offset: 0x00022D7C
	private void HandleTransition()
	{
		Vector3 vector;
		if (this.open)
		{
			float b = 0.025f;
			vector = Vector3.Lerp(this.phoneviewscreenanchor.transform.localScale, this.openscale, Mathf.Min(this.deltatime, b) * this.openspeed);
		}
		else
		{
			vector = Vector3.Lerp(this.phoneviewscreenanchor.transform.localScale, this.closescale, Mathf.Min(this.deltatime, 1f) * this.openspeed);
		}
		this.is_opening = (vector != this.phoneviewscreenanchor.localScale);
		if (this.is_opening)
		{
			this.phoneviewscreenanchor.localScale = vector;
		}
		if (this.phoneviewbordertop.position != this.phoneviewtopanchor.position)
		{
			this.phoneviewbordertop.position = this.phoneviewtopanchor.position;
		}
		if (this.phoneviewbordertop.rotation != this.phoneviewtopanchor.rotation)
		{
			this.phoneviewbordertop.rotation = this.phoneviewtopanchor.rotation;
		}
	}

	// Token: 0x060005BC RID: 1468 RVA: 0x00024C9C File Offset: 0x00022E9C
	public void HandleLight()
	{
		if (this.light_brightness <= 0f)
		{
			this.phoneviewlight.gameObject.active = false;
			this.phoneviewlight.light.intensity = 0f;
			this.phoneviewlight.transform.parent.renderer.material.color = Color.black;
		}
		else
		{
			this.phoneviewlight.gameObject.active = true;
			this.phoneviewlight.light.intensity = this.light_brightness;
			this.phoneviewlight.transform.parent.renderer.material.color = Color.Lerp(Color.black, this.phoneviewlight.color, this.light_brightness / 4f);
		}
	}

	// Token: 0x060005BD RID: 1469 RVA: 0x00024D70 File Offset: 0x00022F70
	public void SetLightBrightness(float amount)
	{
		this.light_brightness = amount;
	}

	// Token: 0x060005BE RID: 1470 RVA: 0x00024D7C File Offset: 0x00022F7C
	public void HandleStick()
	{
		if (this.phoneviewstick)
		{
			Vector2 controlDir = PhoneInput.GetControlDir();
			Vector3 localPosition = new Vector3(controlDir.x, 0f, controlDir.y) * 0.08f;
			if (PhoneInput.IsPressed())
			{
				localPosition.y = -0.045f;
				this.phoneviewstick.renderer.material.color = new Color(0.11764706f, 0f, 0.101960786f);
			}
			else
			{
				this.phoneviewstick.renderer.material.color = Color.black;
			}
			this.phoneviewstick.localPosition = localPosition;
		}
	}

	// Token: 0x0400045E RID: 1118
	public Transform phoneviewscreen;

	// Token: 0x0400045F RID: 1119
	public Transform phoneviewbordertop;

	// Token: 0x04000460 RID: 1120
	public Transform phoneviewborderbottom;

	// Token: 0x04000461 RID: 1121
	public Transform phoneviewscreenanchor;

	// Token: 0x04000462 RID: 1122
	public Transform phoneviewtopanchor;

	// Token: 0x04000463 RID: 1123
	public Transform phoneviewstick;

	// Token: 0x04000464 RID: 1124
	public Light phoneviewlight;

	// Token: 0x04000465 RID: 1125
	public Vector3 closescale;

	// Token: 0x04000466 RID: 1126
	public Vector3 openscale;

	// Token: 0x04000467 RID: 1127
	public Renderer zinerenderer;

	// Token: 0x04000468 RID: 1128
	public bool showing_zine;

	// Token: 0x04000469 RID: 1129
	public bool open;

	// Token: 0x0400046A RID: 1130
	public float openspeed = 5f;

	// Token: 0x0400046B RID: 1131
	public bool is_opening;

	// Token: 0x0400046C RID: 1132
	public RenderTexture rendertex;

	// Token: 0x0400046D RID: 1133
	public PhoneController phonecontroller;

	// Token: 0x0400046E RID: 1134
	private Vector3 normal_zine_pos;

	// Token: 0x0400046F RID: 1135
	private Vector3 hidden_zine_pos;

	// Token: 0x04000470 RID: 1136
	private Vector3 normal_zine_scale;

	// Token: 0x04000471 RID: 1137
	private bool has_resized = true;

	// Token: 0x04000472 RID: 1138
	private float light_brightness;
}
