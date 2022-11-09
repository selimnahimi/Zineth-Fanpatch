using System;
using UnityEngine;

// Token: 0x0200005D RID: 93
public class PhoneButton : PhoneElement
{
	// Token: 0x17000086 RID: 134
	// (get) Token: 0x060003DA RID: 986 RVA: 0x00017184 File Offset: 0x00015384
	// (set) Token: 0x060003DB RID: 987 RVA: 0x00017194 File Offset: 0x00015394
	public virtual string button_name
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

	// Token: 0x17000087 RID: 135
	// (get) Token: 0x060003DC RID: 988 RVA: 0x000171A4 File Offset: 0x000153A4
	// (set) Token: 0x060003DD RID: 989 RVA: 0x000171B4 File Offset: 0x000153B4
	public virtual string text
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

	// Token: 0x17000088 RID: 136
	// (get) Token: 0x060003DE RID: 990 RVA: 0x000171C4 File Offset: 0x000153C4
	// (set) Token: 0x060003DF RID: 991 RVA: 0x000171CC File Offset: 0x000153CC
	public virtual bool selected
	{
		get
		{
			return this._selected;
		}
		set
		{
			if (value && !this._selected)
			{
				this.OnSelected();
			}
			else if (!value && this._selected)
			{
				this.OnUnSelected();
			}
			this._selected = value;
		}
	}

	// Token: 0x060003E0 RID: 992 RVA: 0x00017214 File Offset: 0x00015414
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x060003E1 RID: 993 RVA: 0x0001721C File Offset: 0x0001541C
	public override void OnLoad()
	{
		base.OnLoad();
		if (this.pop_open && this.button_icon)
		{
			this.button_icon.localScale = Vector3.zero;
		}
		this.textmesh.renderer.material.color = PhoneMemory.settings.selectableTextColor;
		if (this.use_own_color)
		{
			this.textmesh.renderer.material.color = this.text_normal;
		}
		this.SetBorderActive(this.always_use_background_border);
	}

	// Token: 0x060003E2 RID: 994 RVA: 0x000172AC File Offset: 0x000154AC
	public override void OnUpdate()
	{
		base.OnUpdate();
		if (this.specialscale != Vector3.zero && this.button_icon && this.button_icon.transform.localScale != this.specialscale)
		{
			this.button_icon.transform.localScale = Vector3.Lerp(this.button_icon.transform.localScale, this.specialscale, PhoneElement.deltatime * 12f);
		}
		if (this.textscale >= 0f && this.textmesh && this.textmesh.characterSize != this.textscale)
		{
			this.textmesh.characterSize = Mathf.Lerp(this.textmesh.characterSize, this.textscale, PhoneElement.deltatime * 12f);
		}
		if (this.background_border && this.use_background_border_box && this.background_border_newscale != this.background_border.localScale)
		{
			this.background_border.localScale = Vector3.Lerp(this.background_border.localScale, this.background_border_newscale, Time.deltaTime * 20f);
		}
	}

	// Token: 0x060003E3 RID: 995 RVA: 0x00017400 File Offset: 0x00015600
	public override void Init()
	{
		if (!this.textmesh)
		{
			this.textmesh = base.gameObject.GetComponent<TextMesh>();
		}
		if (!this.controller)
		{
			this.controller = PhoneController.instance;
		}
		this.wantedpos = base.transform.localPosition;
		this.wantedrot = base.transform.localRotation;
		if (this.screen == null && base.transform.parent)
		{
			PhoneScreen component = base.transform.parent.GetComponent<PhoneScreen>();
			if (component)
			{
				this.screen = component;
			}
		}
		if (this.button_icon)
		{
			this.icon_scale = this.button_icon.localScale;
			this.specialscale = this.icon_scale;
		}
		if (this.textmesh)
		{
			this.text_size = this.textmesh.characterSize;
			this.textscale = this.text_size;
			if (this.textscale == 0f)
			{
				MonoBehaviour.print(base.name + " (0 textscale)");
			}
		}
		if (this.back_normal_color == new Color(0f, 0f, 0f, 0f))
		{
			if (this.background_box)
			{
				this.back_normal_color = this.background_box.renderer.material.color;
			}
			else
			{
				this.back_normal_color = Color.gray;
			}
		}
		if (this.back_selected_color == new Color(0f, 0f, 0f, 0f))
		{
			this.back_selected_color = Color.Lerp(this.back_normal_color, Color.white, 0.6f);
		}
		if (this.use_background_border_box && this.background_border == null && this.background_box != null)
		{
			this.background_box_normal_offset = this.background_box.transform.localPosition;
			if (PhoneController.buttonBackPrefab)
			{
				this.background_border = (UnityEngine.Object.Instantiate(PhoneController.buttonBackPrefab) as GameObject).transform;
			}
			else
			{
				Debug.LogWarning("PhoneController.buttonBackPrefab not set, reverting to bad ol' cube primitive...");
				this.background_border = GameObject.CreatePrimitive(PrimitiveType.Cube).transform;
				UnityEngine.Object.Destroy(this.background_border.collider);
				this.background_border.gameObject.layer = this.background_box.gameObject.layer;
			}
			this.background_border.transform.parent = this.background_box;
			this.background_border.rotation = this.background_box.rotation;
			this.background_border.position = this.background_box.position + new Vector3(0.05f, -0.1f, -0.05f);
			this.background_border.localScale = Vector3.one;
			this.background_border.parent = null;
			Vector3 localScale = this.background_border.localScale;
			this.background_border.localScale = localScale;
			this.background_border.parent = this.background_box;
			this.background_border_activescale = this.background_border.localScale;
			this.background_border.renderer.material = this.background_box.renderer.material;
			this.background_border.renderer.material.color = new Color(0f, 0f, 0f, 0.5f);
			this.background_border.gameObject.active = false;
		}
		this.SetBackColor(this.back_normal_color);
		this.SetBorderActive(this.always_use_background_border && base.gameObject.active);
		this.normal_scale = base.transform.localScale;
		this.wantedscale = this.normal_scale;
	}

	// Token: 0x060003E4 RID: 996 RVA: 0x000177F0 File Offset: 0x000159F0
	private void CheckHover()
	{
		Vector3 touchPoint = PhoneInput.GetTouchPoint();
		if (touchPoint != Vector3.zero * -1f)
		{
			Vector3 point = PhoneInput.TransformPoint(touchPoint);
			point.y = base.transform.position.y;
			if (this.ContainsPoint(point))
			{
				this.OnSelected();
			}
		}
	}

	// Token: 0x060003E5 RID: 997 RVA: 0x00017850 File Offset: 0x00015A50
	public virtual bool ContainsPoint(Vector3 point)
	{
		return this.GetBounds().Contains(point);
	}

	// Token: 0x060003E6 RID: 998 RVA: 0x00017874 File Offset: 0x00015A74
	public virtual Bounds GetBounds()
	{
		if (this.background_box)
		{
			return this.background_box.renderer.bounds;
		}
		if (this.button_icon)
		{
			return this.button_icon.renderer.bounds;
		}
		if (this.textmesh)
		{
			return this.textmesh.renderer.bounds;
		}
		if (base.collider)
		{
			return base.collider.bounds;
		}
		return base.renderer.bounds;
	}

	// Token: 0x060003E7 RID: 999 RVA: 0x0001790C File Offset: 0x00015B0C
	protected virtual void SetBackColor(Color col)
	{
		if (this.background_box)
		{
			this.background_box.renderer.material.color = col;
		}
	}

	// Token: 0x060003E8 RID: 1000 RVA: 0x00017940 File Offset: 0x00015B40
	protected virtual void SetBorderActive(bool val)
	{
		if (this.background_border)
		{
			this.background_border.gameObject.active = (val && base.gameObject.active);
			if (val)
			{
				this.background_border_newscale = this.background_border_activescale;
			}
			else
			{
				this.background_border_newscale = Vector3.one * 0.6f;
			}
		}
	}

	// Token: 0x17000089 RID: 137
	// (get) Token: 0x060003E9 RID: 1001 RVA: 0x000179B0 File Offset: 0x00015BB0
	public Color curNormalTextColor
	{
		get
		{
			if (this.use_own_color)
			{
				return this.text_normal;
			}
			return PhoneMemory.settings.selectableTextColor;
		}
	}

	// Token: 0x1700008A RID: 138
	// (get) Token: 0x060003EA RID: 1002 RVA: 0x000179D0 File Offset: 0x00015BD0
	public Color curSelectedTextColor
	{
		get
		{
			if (this.use_own_color)
			{
				return this.text_selected;
			}
			return PhoneMemory.settings.selectedTextColor;
		}
	}

	// Token: 0x060003EB RID: 1003 RVA: 0x000179F0 File Offset: 0x00015BF0
	public virtual void OnSelected()
	{
		if (this.textmesh)
		{
			this.textmesh.renderer.material.color = this.curSelectedTextColor;
			this.textscale = this.text_size + Mathf.Min(this.text_size * 0.2f, 0.1f);
		}
		if (this.button_icon)
		{
			this.specialscale = this.icon_scale * 1.2f;
			this.button_icon.renderer.material.color = Color.gray;
		}
		if (this.background_box && this.background_box_selected_offset.magnitude != 0f)
		{
			this.background_box.localPosition = this.background_box_normal_offset + this.background_box_selected_offset;
		}
		this.SetBackColor(this.back_selected_color);
		this.SetBorderActive(true);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale * this.expand_size;
		}
	}

	// Token: 0x060003EC RID: 1004 RVA: 0x00017B04 File Offset: 0x00015D04
	public virtual void OnUnSelected()
	{
		if (this.textmesh)
		{
			this.textmesh.renderer.material.color = this.curNormalTextColor;
			this.textscale = this.text_size;
		}
		if (this.button_icon)
		{
			this.specialscale = this.icon_scale;
			this.button_icon.renderer.material.color = Color.white;
		}
		if (this.background_box && this.background_box_selected_offset.magnitude != 0f)
		{
			this.background_box.localPosition = this.background_box_normal_offset;
		}
		this.SetBackColor(this.back_normal_color);
		this.SetBorderActive(this.always_use_background_border);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale;
		}
	}

	// Token: 0x060003ED RID: 1005 RVA: 0x00017BE4 File Offset: 0x00015DE4
	public override Vector3 GetCenter()
	{
		return this.GetBounds().center;
	}

	// Token: 0x060003EE RID: 1006 RVA: 0x00017C00 File Offset: 0x00015E00
	public virtual Vector3 GetPressPos()
	{
		return this.GetCenter();
	}

	// Token: 0x060003EF RID: 1007 RVA: 0x00017C08 File Offset: 0x00015E08
	public virtual void DoPressedParticles()
	{
		PhoneController.EmitPartsMenu(this.GetPressPos() + Vector3.up * 0.1f, 30);
	}

	// Token: 0x060003F0 RID: 1008 RVA: 0x00017C2C File Offset: 0x00015E2C
	public virtual bool RelayPress(PhoneButton button)
	{
		if (button != this.relaybutton)
		{
			this.OnPressed();
			return true;
		}
		return false;
	}

	// Token: 0x060003F1 RID: 1009 RVA: 0x00017C48 File Offset: 0x00015E48
	public virtual void OnPressed()
	{
		if (this.claim_point)
		{
			PhoneController.presspos = this.GetPressPos();
		}
		if (this.pressed_particles)
		{
			this.DoPressedParticles();
		}
		if (this.play_sound)
		{
			PhoneAudioController.PlayAudioClip(PhoneAudioController.audcon.clip_accept, SoundType.menu);
		}
		if (this.expand_on_select)
		{
			base.transform.localScale = this.normal_scale;
		}
		if (this.relaybutton != null)
		{
			this.relaybutton.RelayPress(this);
		}
		else
		{
			this.RunCommand(this.command);
		}
	}

	// Token: 0x060003F2 RID: 1010 RVA: 0x00017CE4 File Offset: 0x00015EE4
	public virtual bool RunCommand(string stringcommand)
	{
		if (!stringcommand.StartsWith(PhoneButton.messagesignal))
		{
			return this.controller.DoCommand(stringcommand);
		}
		if (this.screen != null)
		{
			return this.screen.ButtonMessage(this, stringcommand.Remove(0, PhoneButton.messagesignal.Length));
		}
		Debug.LogWarning(string.Concat(new string[]
		{
			"no screen for button:",
			base.name,
			" (",
			this.button_name,
			"), command: ",
			stringcommand
		}));
		return false;
	}

	// Token: 0x060003F3 RID: 1011 RVA: 0x00017D7C File Offset: 0x00015F7C
	public virtual void ShiftSlider(float amount)
	{
	}

	// Token: 0x060003F4 RID: 1012 RVA: 0x00017D80 File Offset: 0x00015F80
	private void OnDrawGizmosSelected()
	{
		Gizmos.color = Color.magenta;
		if (this.down_button)
		{
			Gizmos.DrawLine(base.transform.position, this.down_button.transform.position);
		}
		if (this.up_button)
		{
			Gizmos.DrawLine(base.transform.position, this.up_button.transform.position);
		}
		if (this.left_button)
		{
			Gizmos.DrawLine(base.transform.position, this.left_button.transform.position);
		}
		if (this.right_button)
		{
			Gizmos.DrawLine(base.transform.position, this.right_button.transform.position);
		}
	}

	// Token: 0x04000308 RID: 776
	public Transform button_icon;

	// Token: 0x04000309 RID: 777
	private Vector3 icon_scale;

	// Token: 0x0400030A RID: 778
	protected float text_size;

	// Token: 0x0400030B RID: 779
	public bool pop_open;

	// Token: 0x0400030C RID: 780
	public bool selectable = true;

	// Token: 0x0400030D RID: 781
	public string id_info = string.Empty;

	// Token: 0x0400030E RID: 782
	public Transform background_box;

	// Token: 0x0400030F RID: 783
	public bool use_background_border_box;

	// Token: 0x04000310 RID: 784
	public bool always_use_background_border;

	// Token: 0x04000311 RID: 785
	private Transform background_border;

	// Token: 0x04000312 RID: 786
	private Vector3 background_border_newscale;

	// Token: 0x04000313 RID: 787
	private Vector3 background_border_activescale;

	// Token: 0x04000314 RID: 788
	public Vector3 background_box_selected_offset = Vector3.zero;

	// Token: 0x04000315 RID: 789
	private Vector3 background_box_normal_offset;

	// Token: 0x04000316 RID: 790
	public PhoneScreen screen;

	// Token: 0x04000317 RID: 791
	public string command = string.Empty;

	// Token: 0x04000318 RID: 792
	public PhoneButton relaybutton;

	// Token: 0x04000319 RID: 793
	public TextMesh textmesh;

	// Token: 0x0400031A RID: 794
	public PhoneController controller;

	// Token: 0x0400031B RID: 795
	private bool _selected;

	// Token: 0x0400031C RID: 796
	public bool claim_point = true;

	// Token: 0x0400031D RID: 797
	public bool pressed_particles = true;

	// Token: 0x0400031E RID: 798
	public bool play_sound = true;

	// Token: 0x0400031F RID: 799
	public Color back_normal_color = Color.gray;

	// Token: 0x04000320 RID: 800
	public Color back_selected_color = Color.white;

	// Token: 0x04000321 RID: 801
	public bool use_own_color;

	// Token: 0x04000322 RID: 802
	public Color text_normal = Color.white;

	// Token: 0x04000323 RID: 803
	public Color text_selected = Color.black;

	// Token: 0x04000324 RID: 804
	public bool horizontal_slider;

	// Token: 0x04000325 RID: 805
	public PhoneButton up_button;

	// Token: 0x04000326 RID: 806
	public PhoneButton down_button;

	// Token: 0x04000327 RID: 807
	public PhoneButton left_button;

	// Token: 0x04000328 RID: 808
	public PhoneButton right_button;

	// Token: 0x04000329 RID: 809
	public bool force_mouse_menulines;

	// Token: 0x0400032A RID: 810
	protected Vector3 normal_scale;

	// Token: 0x0400032B RID: 811
	public bool expand_on_select;

	// Token: 0x0400032C RID: 812
	public float expand_size = 1.1f;

	// Token: 0x0400032D RID: 813
	private Vector3 specialscale = Vector3.zero;

	// Token: 0x0400032E RID: 814
	protected float textscale = -1f;

	// Token: 0x0400032F RID: 815
	private static readonly string messagesignal = ".";
}
