using System;
using System.Collections;
using UnityEngine;

// Token: 0x020000AA RID: 170
public class UnlockZineTrigger : MonoBehaviour
{
	// Token: 0x06000713 RID: 1811 RVA: 0x0002D1AC File Offset: 0x0002B3AC
	private void Awake()
	{
		if (this.secret == null)
		{
			this.secret = base.GetComponent<SecretObject>();
		}
		if (this.secret == null && this.auto_add_secret)
		{
			this.secret = base.gameObject.AddComponent<SecretObject>();
		}
		if (this.secret != null)
		{
			this.secret.send_activate_to.Add(base.gameObject);
		}
	}

	// Token: 0x06000714 RID: 1812 RVA: 0x0002D22C File Offset: 0x0002B42C
	public void SecretFound()
	{
		this.AddZine();
	}

	// Token: 0x06000715 RID: 1813 RVA: 0x0002D234 File Offset: 0x0002B434
	public void AddZine()
	{
		if (this.use_mat_texture && base.renderer.material.mainTexture != null)
		{
			PhoneMemory.UnlockZine(base.renderer.material.mainTexture as Texture2D);
		}
		else if (this.tex != null)
		{
			PhoneMemory.UnlockZine(this.tex);
		}
		else if (!string.IsNullOrEmpty(this.tex_url))
		{
			GameObject gameObject = new GameObject();
			UnlockZineTrigger unlockZineTrigger = gameObject.AddComponent<UnlockZineTrigger>();
			PhoneMemory.UnlockZine(unlockZineTrigger.NewImage(this.tex_url));
		}
		else
		{
			PhoneMemory.UnlockZine(this.ind);
		}
	}

	// Token: 0x06000716 RID: 1814 RVA: 0x0002D2E8 File Offset: 0x0002B4E8
	public virtual void Activate()
	{
		if (Application.isEditor)
		{
			MonoBehaviour.print("activated trigger " + base.gameObject.name);
		}
		this.AddZine();
		if (this.secret)
		{
			this.secret.Found();
		}
		this.DoGUI();
		if (this.destroy_on_activate)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x06000717 RID: 1815 RVA: 0x0002D358 File Offset: 0x0002B558
	private void DoGUI()
	{
		AudioSource.PlayClipAtPoint(MissionController.get_capsule_sound, Vector3.zero);
		MissionGUIText missionGUIText = MissionGUIText.Create("Found a new Zine!", new Vector3(0.024f, 0.2857143f, 0f), Vector3.one * 10f);
		missionGUIText.color = Color.blue;
		missionGUIText.velocity = Vector3.up * 0.15f;
		missionGUIText.stopAfter = 0.15f;
		missionGUIText.lifeTime = 2f;
	}

	// Token: 0x06000718 RID: 1816 RVA: 0x0002D3D8 File Offset: 0x0002B5D8
	private void OnCollisionEnter(Collision collision)
	{
		if (collision.gameObject.name == "Player")
		{
			this.Activate();
		}
	}

	// Token: 0x06000719 RID: 1817 RVA: 0x0002D408 File Offset: 0x0002B608
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "Player")
		{
			this.Activate();
		}
	}

	// Token: 0x0600071A RID: 1818 RVA: 0x0002D428 File Offset: 0x0002B628
	public Texture2D NewImage(string url)
	{
		if (PhoneTweetButton.image_dict.ContainsKey(url))
		{
			return PhoneTweetButton.image_dict[url];
		}
		int num = 128;
		Texture2D texture2D = new Texture2D(num, num);
		texture2D.filterMode = FilterMode.Point;
		texture2D.wrapMode = TextureWrapMode.Clamp;
		PhoneTweetButton.image_dict.Add(url, texture2D);
		PhoneTweetButton.finished_dl_dict.Add(texture2D, false);
		base.StartCoroutine("DownloadImage", url);
		return texture2D;
	}

	// Token: 0x0600071B RID: 1819 RVA: 0x0002D494 File Offset: 0x0002B694
	private IEnumerator DownloadImage(string url)
	{
		WWW web = new WWW(url);
		yield return web;
		if (web.error != null)
		{
			Debug.LogWarning(string.Concat(new string[]
			{
				"Error downloading image ",
				url,
				"(",
				web.error,
				")"
			}));
		}
		else
		{
			PhoneTweetButton.image_dict[url].Resize(web.texture.width, web.texture.height);
			Debug.Log("Resizing...");
			web.LoadImageIntoTexture(PhoneTweetButton.image_dict[url]);
			PhoneTweetButton.finished_dl_dict[PhoneTweetButton.image_dict[url]] = true;
		}
		UnityEngine.Object.Destroy(base.gameObject);
		yield break;
	}

	// Token: 0x040005E1 RID: 1505
	public bool use_mat_texture;

	// Token: 0x040005E2 RID: 1506
	public Texture2D tex;

	// Token: 0x040005E3 RID: 1507
	public string tex_url;

	// Token: 0x040005E4 RID: 1508
	public int ind;

	// Token: 0x040005E5 RID: 1509
	public bool destroy_on_activate = true;

	// Token: 0x040005E6 RID: 1510
	public bool auto_add_secret = true;

	// Token: 0x040005E7 RID: 1511
	public SecretObject secret;
}
