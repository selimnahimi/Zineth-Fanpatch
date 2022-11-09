using System;
using UnityEngine;

// Token: 0x020000AB RID: 171
public class NetIcon : MonoBehaviour
{
	// Token: 0x0600071D RID: 1821 RVA: 0x0002D4F4 File Offset: 0x0002B6F4
	private void Update()
	{
		if (this.start_tex_size == Vector2.zero)
		{
			this.start_tex_size = this.tex_size;
		}
		this.life -= Time.deltaTime;
		if (this.life <= 1.1f)
		{
			this.Kill();
		}
		else if (this.life <= 2f)
		{
			this.tex_size = Vector2.Lerp(this.tex_size, this.tex_size.normalized * 4f, Time.deltaTime * (this.life * 4f));
		}
		this.UpdatePos();
	}

	// Token: 0x0600071E RID: 1822 RVA: 0x0002D5A0 File Offset: 0x0002B7A0
	private void UpdatePos()
	{
		Vector3 vector = Camera.main.WorldToScreenPoint(this.world_pos);
		this.guitex.enabled = true;
		if (vector.z < 0f)
		{
			vector.y = 0f;
		}
		vector.x -= this.tex_size.x / 2f;
		vector.y -= this.tex_size.y / 2f;
		vector.x = Mathf.Clamp(vector.x, 0f, (float)Screen.width - this.tex_size.x);
		vector.y = Mathf.Clamp(vector.y, 0f, (float)Screen.height - this.tex_size.y);
		this.guitex.pixelInset = new Rect(vector.x, vector.y, this.tex_size.x, this.tex_size.y);
	}

	// Token: 0x0600071F RID: 1823 RVA: 0x0002D6B0 File Offset: 0x0002B8B0
	public static NetIcon AddNetIcon(NetworkPlayer owner_player, Vector3 position, Texture2D tex, Vector2 size)
	{
		GameObject gameObject = new GameObject("neticon");
		gameObject.transform.position = position;
		GameObject gameObject2 = new GameObject("subobj");
		gameObject2.transform.position = Vector3.zero;
		gameObject2.transform.localScale = Vector3.zero;
		gameObject2.transform.parent = gameObject.transform;
		GUITexture guitexture = gameObject2.AddComponent<GUITexture>();
		guitexture.texture = tex;
		NetIcon netIcon = gameObject2.AddComponent<NetIcon>();
		netIcon.owner = owner_player;
		netIcon.world_pos = position;
		netIcon.guitex = guitexture;
		netIcon.tex = tex;
		netIcon.tex_size = size;
		if (tex.name == "pizza")
		{
			netIcon.can_collect = true;
			netIcon.life = 20f;
		}
		if (netIcon.owner == Network.player)
		{
			netIcon.can_collect = false;
		}
		if (netIcon.can_collect)
		{
			CollisionChecker collisionChecker = gameObject.AddComponent<CollisionChecker>();
			collisionChecker.TriggerEnterDelegate = new CollisionChecker.OnTriggerEnterDelegate(netIcon.OnTriggerEnter);
			SphereCollider sphereCollider = gameObject.AddComponent<SphereCollider>();
			sphereCollider.isTrigger = true;
			sphereCollider.radius = 8f;
			netIcon.collect_sound = Networking.piz_clip;
		}
		return netIcon;
	}

	// Token: 0x06000720 RID: 1824 RVA: 0x0002D7DC File Offset: 0x0002B9DC
	public void Kill()
	{
		if (base.transform.parent)
		{
			UnityEngine.Object.Destroy(base.transform.parent.gameObject);
		}
		else
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x06000721 RID: 1825 RVA: 0x0002D824 File Offset: 0x0002BA24
	private void OnCollect()
	{
		if (Application.isEditor)
		{
			MonoBehaviour.print("grabbing some piz");
		}
		if (this.collect_sound != null)
		{
			AudioSource.PlayClipAtPoint(this.collect_sound, Camera.main.transform.position);
		}
		if (Networking.my_net_player)
		{
			Networking.my_net_player.pizzaScore++;
			Networking.my_net_player.DoSetPizzaScore();
		}
		this.Kill();
	}

	// Token: 0x06000722 RID: 1826 RVA: 0x0002D8A4 File Offset: 0x0002BAA4
	private void OnTriggerEnter(Collider other)
	{
		if (this.can_collect && other.name == "Player")
		{
			this.OnCollect();
		}
	}

	// Token: 0x040005E8 RID: 1512
	public AudioClip collect_sound;

	// Token: 0x040005E9 RID: 1513
	public float life = 5f;

	// Token: 0x040005EA RID: 1514
	public Vector3 world_pos;

	// Token: 0x040005EB RID: 1515
	public GUITexture guitex;

	// Token: 0x040005EC RID: 1516
	public Texture2D tex;

	// Token: 0x040005ED RID: 1517
	public Vector2 tex_size = Vector2.one * 64f;

	// Token: 0x040005EE RID: 1518
	public Vector2 start_tex_size = Vector2.zero;

	// Token: 0x040005EF RID: 1519
	public bool can_collect;

	// Token: 0x040005F0 RID: 1520
	public NetworkPlayer owner;
}
