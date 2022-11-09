using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000081 RID: 129
public class PhoneTweetButton : PhoneButton
{
	// Token: 0x06000565 RID: 1381 RVA: 0x00021E80 File Offset: 0x00020080
	private void Awake()
	{
		this.Init();
		this.normal_scale = base.transform.localScale;
		this.wantedscale = this.normal_scale;
	}

	// Token: 0x170000B6 RID: 182
	// (get) Token: 0x06000566 RID: 1382 RVA: 0x00021EB0 File Offset: 0x000200B0
	// (set) Token: 0x06000567 RID: 1383 RVA: 0x00021EDC File Offset: 0x000200DC
	public Texture2D image_tex
	{
		get
		{
			if (!this.image_renderer)
			{
				return null;
			}
			return this.image_renderer.material.mainTexture as Texture2D;
		}
		set
		{
			if (this.image_renderer)
			{
				this.image_renderer.material.mainTexture = value;
			}
		}
	}

	// Token: 0x170000B7 RID: 183
	// (get) Token: 0x06000568 RID: 1384 RVA: 0x00021F00 File Offset: 0x00020100
	// (set) Token: 0x06000569 RID: 1385 RVA: 0x00021F30 File Offset: 0x00020130
	public PhoneMail my_mail
	{
		get
		{
			if (this._my_mail == null)
			{
				this._my_mail = MailController.FindMail(this.id_info);
			}
			return this._my_mail;
		}
		set
		{
			this._my_mail = value;
			if (this._my_mail != null)
			{
				this.id_info = this._my_mail.id;
			}
			else
			{
				Debug.LogWarning("null mail...");
			}
		}
	}

	// Token: 0x0600056A RID: 1386 RVA: 0x00021F70 File Offset: 0x00020170
	public override void OnLoad()
	{
		base.OnLoad();
		if (this.my_mail != null)
		{
			if (this.my_mail.image_url != string.Empty && this.image_tex)
			{
				this.GetImage(this.my_mail.image_url);
			}
			if (this.sender_label)
			{
				this.sender_label.text = this.my_mail.sender;
			}
			if (this.username_label)
			{
				this.username_label.text = this.my_mail.subject;
			}
			if (this.bodytext_label)
			{
				this.bodytext_label.text = this.my_mail.body;
			}
			if (this.new_label)
			{
				if (this.new_effect && this.my_mail.is_new)
				{
					this.new_label.renderer.enabled = true;
				}
				else
				{
					this.new_label.renderer.enabled = false;
				}
			}
			if (this.images_icon)
			{
				this.images_icon.enabled = (this.my_mail.media_urls.Count > 0);
			}
			if (this.links_icon)
			{
				this.links_icon.enabled = (this.my_mail.link_urls.Count > 0);
			}
		}
		if (this.resize && this.background_box)
		{
			this.background_box.renderer.bounds.Encapsulate(this.bodytext_label.textmesh.renderer.bounds);
		}
	}

	// Token: 0x0600056B RID: 1387 RVA: 0x00022134 File Offset: 0x00020334
	public override void OnUpdate()
	{
		if (this.new_effect && this.auto_update_new)
		{
			this.DoNewEffect();
		}
		base.OnUpdate();
	}

	// Token: 0x0600056C RID: 1388 RVA: 0x00022164 File Offset: 0x00020364
	public virtual void DoNewEffect()
	{
		if (this.new_label)
		{
			this.new_label.renderer.enabled = this.my_mail.is_new;
		}
	}

	// Token: 0x0600056D RID: 1389 RVA: 0x00022194 File Offset: 0x00020394
	public virtual void GetImage(string url)
	{
		if (this.image_tex)
		{
			this.image_tex = this.NewImage(url);
		}
	}

	// Token: 0x0600056E RID: 1390 RVA: 0x000221B4 File Offset: 0x000203B4
	public virtual Texture2D NewImage(string image_name)
	{
		if (PhoneTweetButton.image_dict.ContainsKey(image_name))
		{
			return PhoneTweetButton.image_dict[image_name];
		}
		Texture2D texture2D = new Texture2D(this.image_size, this.image_size);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		PhoneTweetButton.image_dict.Add(image_name, texture2D);
		PhoneTweetButton.finished_dl_dict.Add(texture2D, false);
		ImageDownloadHelper.DownLoadImage(image_name);
		return texture2D;
	}

	// Token: 0x0600056F RID: 1391 RVA: 0x00022220 File Offset: 0x00020420
	public override void OnSelected()
	{
		if (this.textmesh)
		{
			this.textscale = this.text_size + Mathf.Min(this.text_size * 0.2f, 0.1f);
		}
		if (this.background_box)
		{
			this.SetBackColor(this.back_selected_color);
		}
		this.SetBorderActive(this.always_use_background_border);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale * this.expand_size;
		}
	}

	// Token: 0x06000570 RID: 1392 RVA: 0x000222AC File Offset: 0x000204AC
	public override void OnUnSelected()
	{
		if (this.textmesh)
		{
			this.textscale = this.text_size;
		}
		if (this.background_box)
		{
			this.SetBackColor(this.back_normal_color);
		}
		this.SetBorderActive(this.always_use_background_border);
		if (this.expand_on_select)
		{
			this.wantedscale = this.normal_scale;
		}
	}

	// Token: 0x0400042C RID: 1068
	private PhoneElement render_element;

	// Token: 0x0400042D RID: 1069
	public PhoneLabel sender_label;

	// Token: 0x0400042E RID: 1070
	public PhoneLabel username_label;

	// Token: 0x0400042F RID: 1071
	public PhoneLabel bodytext_label;

	// Token: 0x04000430 RID: 1072
	public Renderer image_renderer;

	// Token: 0x04000431 RID: 1073
	public bool new_effect;

	// Token: 0x04000432 RID: 1074
	public PhoneLabel new_label;

	// Token: 0x04000433 RID: 1075
	public bool auto_update_new = true;

	// Token: 0x04000434 RID: 1076
	public Renderer images_icon;

	// Token: 0x04000435 RID: 1077
	public Renderer links_icon;

	// Token: 0x04000436 RID: 1078
	private PhoneMail _my_mail;

	// Token: 0x04000437 RID: 1079
	public bool resize;

	// Token: 0x04000438 RID: 1080
	public string url_str = string.Empty;

	// Token: 0x04000439 RID: 1081
	public static Dictionary<string, Texture2D> image_dict = new Dictionary<string, Texture2D>();

	// Token: 0x0400043A RID: 1082
	public static Dictionary<Texture, bool> finished_dl_dict = new Dictionary<Texture, bool>();

	// Token: 0x0400043B RID: 1083
	public int image_size = 48;
}
