using System;
using UnityEngine;

// Token: 0x02000062 RID: 98
public class PhoneButtonSlider : PhoneButton
{
	// Token: 0x1700008E RID: 142
	// (get) Token: 0x06000408 RID: 1032 RVA: 0x00018214 File Offset: 0x00016414
	// (set) Token: 0x06000409 RID: 1033 RVA: 0x0001821C File Offset: 0x0001641C
	public virtual float slider_pos
	{
		get
		{
			return this._slider_pos;
		}
		set
		{
			this._slider_pos = Mathf.Clamp(value, 0f, 1f);
		}
	}

	// Token: 0x1700008F RID: 143
	// (get) Token: 0x0600040A RID: 1034 RVA: 0x00018234 File Offset: 0x00016434
	// (set) Token: 0x0600040B RID: 1035 RVA: 0x00018250 File Offset: 0x00016450
	public float val
	{
		get
		{
			return Mathf.Lerp(this.min_val, this.max_val, this.slider_pos);
		}
		set
		{
			this.slider_pos = Mathf.InverseLerp(this.min_val, this.max_val, value);
		}
	}

	// Token: 0x0600040C RID: 1036 RVA: 0x0001826C File Offset: 0x0001646C
	private void Awake()
	{
		this.Init();
	}

	// Token: 0x0600040D RID: 1037 RVA: 0x00018274 File Offset: 0x00016474
	public override void Init()
	{
		base.Init();
		this.left_button = this;
		this.right_button = this;
		this.UpdateSliderPos();
	}

	// Token: 0x0600040E RID: 1038 RVA: 0x00018290 File Offset: 0x00016490
	public override void OnLoad()
	{
		base.OnLoad();
		this.InitSliderPos();
		this.last_selected = false;
	}

	// Token: 0x0600040F RID: 1039 RVA: 0x000182A8 File Offset: 0x000164A8
	public override void OnUpdate()
	{
		if ((this.selected || this.last_selected) && (!this.animateOnLoad || base.transform.localPosition == this.wantedpos))
		{
			this.SlideControls();
		}
		this.last_selected = this.selected;
		base.OnUpdate();
	}

	// Token: 0x06000410 RID: 1040 RVA: 0x0001830C File Offset: 0x0001650C
	protected virtual void SlideControls()
	{
		Vector2 controlDir = PhoneInput.GetControlDir();
		if (Mathf.Abs(controlDir.x) > 0.15f && Mathf.Abs(controlDir.y) < 0.25f)
		{
			this.ShiftSlider((controlDir.x - 0.15f) * this.slide_scale * PhoneElement.deltatime);
		}
		if (PhoneInput.controltype == PhoneInput.ControlType.Mouse && PhoneInput.IsPressed())
		{
			Vector3 transformedTouchPoint = PhoneInput.GetTransformedTouchPoint();
			Bounds bounds = this.GetBounds();
			transformedTouchPoint.y = bounds.center.y;
			transformedTouchPoint.x = Mathf.Clamp(transformedTouchPoint.x, bounds.min.x, bounds.max.x);
			if (bounds.Contains(transformedTouchPoint))
			{
				this.SetSlider(transformedTouchPoint);
			}
		}
	}

	// Token: 0x06000411 RID: 1041 RVA: 0x000183EC File Offset: 0x000165EC
	private void InitSliderPos()
	{
		float sliderVar = this.screen.GetSliderVar(this.slide_command);
		this.val = sliderVar;
		this.UpdateSliderPos();
	}

	// Token: 0x06000412 RID: 1042 RVA: 0x00018418 File Offset: 0x00016618
	public override void ShiftSlider(float amount)
	{
		this.SetSlider(this.slider_pos + amount);
	}

	// Token: 0x06000413 RID: 1043 RVA: 0x00018428 File Offset: 0x00016628
	public virtual void SetSlider(Vector3 pos)
	{
		Bounds slideBounds = this.GetSlideBounds();
		float slider = Mathf.InverseLerp(slideBounds.min.x, slideBounds.max.x, pos.x);
		this.SetSlider(slider);
	}

	// Token: 0x06000414 RID: 1044 RVA: 0x00018470 File Offset: 0x00016670
	public virtual void SetSlider(float amount)
	{
		float slider_pos = this.slider_pos;
		this.slider_pos = amount;
		if (slider_pos != this.slider_pos)
		{
			this.DoSliderCommand();
			this.UpdateSliderPos();
		}
	}

	// Token: 0x06000415 RID: 1045 RVA: 0x000184A4 File Offset: 0x000166A4
	public void UpdateSliderPos()
	{
		if (this.button_icon)
		{
			Bounds bounds = this.GetBounds();
			Vector3 from = new Vector3(bounds.min.x, this.button_icon.position.y, bounds.center.z);
			Vector3 to = new Vector3(bounds.max.x, this.button_icon.position.y, bounds.center.z);
			Vector3 vector = Vector3.Lerp(from, to, this.slider_pos);
			if (this.button_icon.transform.position != vector)
			{
				this.button_icon.transform.position = vector;
			}
		}
	}

	// Token: 0x06000416 RID: 1046 RVA: 0x00018578 File Offset: 0x00016778
	public virtual bool DoSliderCommand()
	{
		string text = this.slide_command;
		text = string.Format(text, this.val);
		return this.RunCommand(text);
	}

	// Token: 0x06000417 RID: 1047 RVA: 0x000185A8 File Offset: 0x000167A8
	public virtual Bounds GetSlideBounds()
	{
		Bounds bounds = base.GetBounds();
		if (this.button_icon)
		{
			Vector3 min = bounds.min;
			Vector3 max = bounds.max;
			min.z = this.button_icon.renderer.bounds.min.z;
			max.z = this.button_icon.renderer.bounds.max.z;
			bounds.SetMinMax(min, max);
		}
		return bounds;
	}

	// Token: 0x06000418 RID: 1048 RVA: 0x00018638 File Offset: 0x00016838
	public override Bounds GetBounds()
	{
		return this.GetSlideBounds();
	}

	// Token: 0x04000335 RID: 821
	private float _slider_pos = 0.5f;

	// Token: 0x04000336 RID: 822
	public float min_val;

	// Token: 0x04000337 RID: 823
	public float max_val = 1f;

	// Token: 0x04000338 RID: 824
	public string slide_command = string.Empty;

	// Token: 0x04000339 RID: 825
	public float slide_scale = 0.5f;

	// Token: 0x0400033A RID: 826
	private bool last_selected;
}
