using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200007E RID: 126
public class PhoneSlideshow : PhoneMainMenu
{
	// Token: 0x170000B0 RID: 176
	// (get) Token: 0x06000539 RID: 1337 RVA: 0x00020F0C File Offset: 0x0001F10C
	// (set) Token: 0x0600053A RID: 1338 RVA: 0x00020F14 File Offset: 0x0001F114
	public int slide_ind
	{
		get
		{
			return this._slide_ind;
		}
		set
		{
			this._slide_ind = value;
			if (this._slide_ind >= this.slides.Count)
			{
				if (this.wrap_slides)
				{
					this._slide_ind = 0;
				}
				else
				{
					this._slide_ind = this.slides.Count - 1;
				}
			}
			if (this._slide_ind < 0)
			{
				if (this.wrap_slides)
				{
					this._slide_ind = this.slides.Count - 1;
				}
				else
				{
					this._slide_ind = 0;
				}
			}
			if (this.next_button && (this.wrap_slides || this._slide_ind < this.slides.Count - 1))
			{
				this.controller.menulines[3].end = this.next_button;
				if (!this.next_button.selected)
				{
					this.next_button.textmesh.renderer.material.color = Color.black;
				}
				this.next_button.selectable = true;
			}
			else if (this.next_button)
			{
				this.controller.menulines[3].end = null;
				if (this.next_button.selected)
				{
					this.next_button.selected = false;
				}
				this.next_button.selectable = false;
				this.next_button.textmesh.renderer.material.color = Color.gray;
			}
			if (this.prev_button && (this.wrap_slides || this._slide_ind > 0))
			{
				this.controller.menulines[2].end = this.prev_button;
				if (!this.prev_button.selected)
				{
					this.prev_button.textmesh.renderer.material.color = Color.black;
				}
				this.prev_button.selectable = true;
			}
			else if (this.prev_button)
			{
				this.controller.menulines[2].end = null;
				if (this.prev_button.selected)
				{
					this.prev_button.selected = false;
				}
				this.prev_button.selectable = false;
				this.prev_button.textmesh.renderer.material.color = Color.gray;
			}
			this.SetTexture(this.slides[this.slide_ind]);
		}
	}

	// Token: 0x0600053B RID: 1339 RVA: 0x00021194 File Offset: 0x0001F394
	protected override void SetMenuLines(PhoneButton button)
	{
	}

	// Token: 0x0600053C RID: 1340 RVA: 0x00021198 File Offset: 0x0001F398
	private void SetupMenuLines()
	{
		this.controller.menulines[0].start = this.prev_button;
		this.controller.menulines[0].end = null;
		this.controller.menulines[1].start = this.prev_button;
		this.controller.menulines[1].end = null;
		this.controller.menulines[2].start = this.prev_button;
		this.controller.menulines[3].start = this.next_button;
	}

	// Token: 0x170000B1 RID: 177
	// (get) Token: 0x0600053D RID: 1341 RVA: 0x0002122C File Offset: 0x0001F42C
	private bool should_convert
	{
		get
		{
			return this.use_tutorial_slide_conversion && PhoneInput.controltype != PhoneInput.ControlType.Keyboard;
		}
	}

	// Token: 0x0600053E RID: 1342 RVA: 0x00021248 File Offset: 0x0001F448
	private void SetTexture(Texture2D texture)
	{
		if (this.should_convert)
		{
			texture = TutorialSlides.GetKeyboardSlide(texture);
		}
		this.slide_renderer.material.mainTexture = texture;
	}

	// Token: 0x0600053F RID: 1343 RVA: 0x0002127C File Offset: 0x0001F47C
	private void Update()
	{
		if (this.next_button)
		{
			if (!this.next_button.gameObject.active)
			{
				Debug.LogError("next button is not active!");
				this.next_button.gameObject.active = true;
			}
			if (!this.next_button.renderer.enabled)
			{
				Debug.LogError("next button renderer is not enabled!");
				this.next_button.renderer.enabled = true;
			}
		}
		else
		{
			Debug.LogError("no next button...");
		}
	}

	// Token: 0x06000540 RID: 1344 RVA: 0x00021308 File Offset: 0x0001F508
	private void Start()
	{
		if (!this.slide_renderer)
		{
			this.slide_renderer = base.renderer;
		}
		this.slide_ind = this.slide_ind;
		if (this.next_button)
		{
			this.button_scale = this.next_button.transform.localScale;
			this.next_button.text_selected = this.next_button.curSelectedTextColor;
			this.next_button.text_normal = Color.black;
			this.next_button.use_own_color = true;
		}
		if (this.prev_button)
		{
			this.prev_button.text_selected = this.prev_button.curSelectedTextColor;
			this.prev_button.text_normal = Color.black;
			this.prev_button.use_own_color = true;
		}
	}

	// Token: 0x06000541 RID: 1345 RVA: 0x000213D8 File Offset: 0x0001F5D8
	public void LoadSlideSet(string setname)
	{
		if (TutorialSlides.slideset_dictionary.ContainsKey(setname))
		{
			this.LoadSlideSet(TutorialSlides.slideset_dictionary[setname]);
		}
		else
		{
			Debug.LogWarning("slideset " + setname + " does not exist...");
		}
	}

	// Token: 0x06000542 RID: 1346 RVA: 0x00021420 File Offset: 0x0001F620
	public void LoadSlideSet(TutorialSlides.Slideset slideset)
	{
		MonoBehaviour.print("loading slideset: " + slideset.set_name);
		this.slides = slideset.slides;
		this.slide_ind = 0;
	}

	// Token: 0x06000543 RID: 1347 RVA: 0x00021458 File Offset: 0x0001F658
	public override void OnLoad()
	{
		base.gameObject.SetActiveRecursively(true);
		if (this.start_set != string.Empty)
		{
			this.LoadSlideSet(this.start_set);
		}
		this.SetupMenuLines();
		this.slide_ind = this.slide_ind;
	}

	// Token: 0x06000544 RID: 1348 RVA: 0x000214A4 File Offset: 0x0001F6A4
	public virtual void NextSlide()
	{
		this.slide_ind++;
	}

	// Token: 0x06000545 RID: 1349 RVA: 0x000214B4 File Offset: 0x0001F6B4
	public virtual void PreviousSlide()
	{
		this.slide_ind--;
	}

	// Token: 0x06000546 RID: 1350 RVA: 0x000214C4 File Offset: 0x0001F6C4
	public override void UpdateScreen()
	{
		if (this.button_scale == Vector3.zero)
		{
			Debug.LogError("button_scale was 0, that was probably the problem. fixin it now...");
			this.button_scale = this.next_button.transform.localScale;
		}
		float magnitude = this.button_scale.magnitude;
		float num = magnitude * 0.9f + Mathf.PingPong(Time.time, magnitude * 0.2f);
		float magnitude2 = this.button_scale.magnitude;
		if (this.next_button)
		{
			float d = magnitude2;
			if (this.next_button.selectable)
			{
				d = num;
			}
			this.next_button.transform.localScale = this.button_scale.normalized * d;
		}
		if (this.prev_button)
		{
			float d2 = magnitude2;
			if (this.prev_button.selectable)
			{
				d2 = num;
			}
			this.prev_button.transform.localScale = this.button_scale.normalized * d2;
		}
		base.UpdateScreen();
	}

	// Token: 0x06000547 RID: 1351 RVA: 0x000215CC File Offset: 0x0001F7CC
	protected override void DoStickControls()
	{
		Vector2 controlDirPressed = PhoneInput.GetControlDirPressed();
		if (Mathf.Abs(controlDirPressed.y) < 0.3f)
		{
			if (controlDirPressed.x >= 0.5f)
			{
				this.NextSlide();
			}
			else if (controlDirPressed.x <= -0.5f)
			{
				this.PreviousSlide();
			}
		}
	}

	// Token: 0x06000548 RID: 1352 RVA: 0x00021628 File Offset: 0x0001F828
	public override bool ButtonMessage(PhoneButton button, string message)
	{
		if (message == "next")
		{
			this.NextSlide();
		}
		else
		{
			if (!(message == "back") && !(message == "prev") && !(message == "previous"))
			{
				return base.ButtonMessage(button, message);
			}
			this.PreviousSlide();
		}
		return true;
	}

	// Token: 0x04000412 RID: 1042
	public string start_set;

	// Token: 0x04000413 RID: 1043
	public List<Texture2D> slides;

	// Token: 0x04000414 RID: 1044
	public Renderer slide_renderer;

	// Token: 0x04000415 RID: 1045
	public bool use_tutorial_slide_conversion = true;

	// Token: 0x04000416 RID: 1046
	public PhoneButton prev_button;

	// Token: 0x04000417 RID: 1047
	public PhoneButton next_button;

	// Token: 0x04000418 RID: 1048
	protected int _slide_ind;

	// Token: 0x04000419 RID: 1049
	public bool wrap_slides;

	// Token: 0x0400041A RID: 1050
	private Vector3 button_scale = Vector3.zero;
}
