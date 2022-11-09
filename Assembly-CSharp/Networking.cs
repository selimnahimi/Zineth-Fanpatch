using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

// Token: 0x020000AE RID: 174
public class Networking : MonoBehaviour
{
	// Token: 0x170000E2 RID: 226
	// (get) Token: 0x06000760 RID: 1888 RVA: 0x0002FF0C File Offset: 0x0002E10C
	public Transform player_tran
	{
		get
		{
			return PhoneInterface.player_trans;
		}
	}

	// Token: 0x170000E3 RID: 227
	// (get) Token: 0x06000761 RID: 1889 RVA: 0x0002FF14 File Offset: 0x0002E114
	public static AudioClip piz_clip
	{
		get
		{
			return Networking.instance._piz_clip;
		}
	}

	// Token: 0x170000E4 RID: 228
	// (get) Token: 0x06000762 RID: 1890 RVA: 0x0002FF20 File Offset: 0x0002E120
	public static NetPlayer my_net_player
	{
		get
		{
			if (Network.isClient)
			{
				return Networking.instance.client_net;
			}
			if (Network.isServer)
			{
				return Networking.instance.host_net;
			}
			return null;
		}
	}

	// Token: 0x170000E5 RID: 229
	// (get) Token: 0x06000763 RID: 1891 RVA: 0x0002FF50 File Offset: 0x0002E150
	public static Networking instance
	{
		get
		{
			if (Networking._instance == null)
			{
				Networking._instance = (UnityEngine.Object.FindObjectOfType(typeof(Networking)) as Networking);
			}
			return Networking._instance;
		}
	}

	// Token: 0x170000E6 RID: 230
	// (get) Token: 0x06000764 RID: 1892 RVA: 0x0002FF8C File Offset: 0x0002E18C
	public static NewCamera newCam
	{
		get
		{
			if (!Networking._newCam)
			{
				Networking._newCam = (UnityEngine.Object.FindObjectOfType(typeof(NewCamera)) as NewCamera);
			}
			return Networking._newCam;
		}
	}

	// Token: 0x06000765 RID: 1893 RVA: 0x0002FFBC File Offset: 0x0002E1BC
	private void Awake()
	{
		if (Networking.instance != this)
		{
			if (!string.IsNullOrEmpty(Networking.bundlefile))
			{
				Debug.Log("here...");
				if (Networking.my_net_player != null)
				{
					Networking.my_net_player.LoadBundleCommand(Networking.bundlefile);
				}
			}
			UnityEngine.Object.Destroy(base.gameObject);
		}
		else
		{
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		}
	}

	// Token: 0x06000766 RID: 1894 RVA: 0x0003002C File Offset: 0x0002E22C
	private void Start()
	{
		this.LoadLastServer();
		this.GetServerList();
		if (Networking.chat_icon_dic.Count == 0)
		{
			foreach (Texture2D texture2D in this.chat_icons)
			{
				Networking.chat_icon_dic.Add(texture2D.name, texture2D);
			}
		}
		string[] commandLineArgs = Environment.GetCommandLineArgs();
		if (commandLineArgs.Length > 1)
		{
			foreach (string text in commandLineArgs)
			{
				if (text == "-batchmode")
				{
					Networking.batchMode = true;
				}
				else if (text.StartsWith("pass="))
				{
					this.password = text.Replace("pass=", string.Empty);
				}
				else if (text.StartsWith("port="))
				{
					this.port = text.Replace("port=", string.Empty);
				}
				else if (text.StartsWith("limit="))
				{
					this.max_players = text.Replace("limit=", string.Empty);
				}
			}
		}
		base.StartCoroutine(this.TestConnection());
		if (Networking.batchMode)
		{
			if (Application.isEditor)
			{
				Debug.Log("batch mode...");
			}
			base.Invoke("StartServer", 0.5f);
			Debug.Log("starting server in .5s ...");
		}
		else if (this.auto)
		{
			base.InvokeRepeating("AutoServer", 1f + UnityEngine.Random.value, 5f);
		}
	}

	// Token: 0x06000767 RID: 1895 RVA: 0x000301C4 File Offset: 0x0002E3C4
	private void AutoServer()
	{
		if (Network.isClient || Network.isServer)
		{
			return;
		}
		this.serverdats = MasterServer.PollHostList();
		if (this.serverdats.Length > 0)
		{
			Network.Connect(this.serverdats[0], this.password);
		}
		else
		{
			this.StartServer();
		}
	}

	// Token: 0x06000768 RID: 1896 RVA: 0x00030220 File Offset: 0x0002E420
	private void LoadLastServer()
	{
		string @string = PlayerPrefs.GetString("prev_server_ip", string.Empty);
		if (!string.IsNullOrEmpty(@string))
		{
			this.ip_address = @string;
		}
		string string2 = PlayerPrefs.GetString("prev_server_port", string.Empty);
		if (!string.IsNullOrEmpty(string2))
		{
			this.port = string2;
		}
		string string3 = PlayerPrefs.GetString("prev_server_name", string.Empty);
		if (!string.IsNullOrEmpty(string3))
		{
			this.server_name = string3;
		}
	}

	// Token: 0x06000769 RID: 1897 RVA: 0x00030294 File Offset: 0x0002E494
	private void SaveCurrentServer()
	{
		PlayerPrefs.SetString("prev_server_ip", this.ip_address);
		PlayerPrefs.SetString("prev_server_port", this.port);
		PlayerPrefs.SetString("prev_server_name", this.server_name);
	}

	// Token: 0x0600076A RID: 1898 RVA: 0x000302D4 File Offset: 0x0002E4D4
	private IEnumerator TestConnection()
	{
		while (this.ConnectionTestLoop())
		{
			yield return null;
		}
		yield break;
	}

	// Token: 0x0600076B RID: 1899 RVA: 0x000302F0 File Offset: 0x0002E4F0
	private bool ConnectionTestLoop()
	{
		ConnectionTesterStatus connectionTesterStatus = this.connectTest;
		switch (connectionTesterStatus + 2)
		{
		case ConnectionTesterStatus.PrivateIPNoNATPunchthrough:
			this.connectTestMessage = "error...!";
			return false;
		case ConnectionTesterStatus.PrivateIPHasNATPunchThrough:
			this.connectTest = Network.TestConnection();
			this.connectTestMessage = "testing network...";
			return true;
		case ConnectionTesterStatus.PublicIPNoServerStarted:
			this.connectTestMessage = "directly connectable!";
			this.use_NAT = false;
			return false;
		case ConnectionTesterStatus.LimitedNATPunchthroughPortRestricted:
			this.connectTestMessage = "NAT testing...";
			this.connectTest = Network.TestConnectionNAT();
			return true;
		case ConnectionTesterStatus.LimitedNATPunchthroughSymmetric:
			this.connectTestMessage = "public ip, but no server!";
			return false;
		case ConnectionTesterStatus.NATpunchthroughFullCone:
			this.connectTestMessage = "limited NAT, port restricted!";
			this.use_NAT = true;
			return false;
		case ConnectionTesterStatus.NATpunchthroughAddressRestrictedCone:
			this.connectTestMessage = "limited NAT, don't run a server!";
			this.use_NAT = true;
			return false;
		case (ConnectionTesterStatus)9:
		case (ConnectionTesterStatus)10:
			this.connectTestMessage = "great NAT!";
			this.use_NAT = true;
			return false;
		}
		this.connectTestMessage = "? " + this.connectTest;
		return false;
	}

	// Token: 0x0600076C RID: 1900 RVA: 0x0003040C File Offset: 0x0002E60C
	private void OnGUI()
	{
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		this.showgui = GUILayout.Toggle(this.showgui, "gui (net test)", new GUILayoutOption[0]);
		if (!this.showgui)
		{
			return;
		}
		if (!Network.isClient && !Network.isServer)
		{
			this.drawsettings = GUILayout.Toggle(this.drawsettings, "NAT", new GUILayoutOption[0]);
		}
		GUILayout.EndHorizontal();
		if (Network.isServer)
		{
			this.ServerGUI();
		}
		else if (Network.isClient)
		{
			this.ClientGUI();
		}
		else
		{
			this.NoneGUI();
		}
	}

	// Token: 0x0600076D RID: 1901 RVA: 0x000304B4 File Offset: 0x0002E6B4
	private void OnConnectedToServer()
	{
		if (Application.isEditor)
		{
			Debug.Log("connected to server...");
		}
		Playtomic.Log.CustomMetric("has_joined_server", PlaytomicController.current_group, true);
		this.client_net = (Network.Instantiate(this.player_prefab, this.player_tran.position, this.player_tran.rotation, 0) as NetPlayer);
		this.client_net.name = "client obj";
	}

	// Token: 0x0600076E RID: 1902 RVA: 0x00030528 File Offset: 0x0002E728
	private void OnDisconnectedFromServer(NetworkDisconnection info)
	{
		Debug.Log("Disconnected from server: " + info);
		if (this.client_net)
		{
			UnityEngine.Object.Destroy(this.client_net.gameObject);
		}
		this.CleanUpNetObjs();
	}

	// Token: 0x0600076F RID: 1903 RVA: 0x00030568 File Offset: 0x0002E768
	private void OnPlayerDisconnected(NetworkPlayer player)
	{
		if (Application.isEditor)
		{
			Debug.Log("Player disconnected");
		}
		Network.RemoveRPCs(player);
		Network.DestroyPlayerObjects(player);
		if (Networking.netplayer_dic.ContainsKey(player))
		{
			Networking.netplayer_dic.Remove(player);
		}
	}

	// Token: 0x06000770 RID: 1904 RVA: 0x000305B4 File Offset: 0x0002E7B4
	public void Disconnect()
	{
		if (Network.isServer)
		{
			foreach (NetworkPlayer networkPlayer in Network.connections)
			{
				if (Application.isEditor)
				{
					Debug.Log("cleaning up after " + networkPlayer);
				}
				Network.RemoveRPCs(networkPlayer);
				Network.DestroyPlayerObjects(networkPlayer);
			}
			if (Application.isEditor)
			{
				Debug.Log("cleaing up after host :)");
			}
			Network.RemoveRPCs(Network.player);
			Network.DestroyPlayerObjects(Network.player);
			Network.Disconnect();
		}
		else if (Network.isClient)
		{
			Network.Disconnect();
		}
		this.CleanUpNetObjs();
	}

	// Token: 0x06000771 RID: 1905 RVA: 0x00030664 File Offset: 0x0002E864
	private void CleanUpNetObjs()
	{
		Networking.netplayer_dic.Clear();
		this.gui_expanded_list.Clear();
		Networking.chat_log.Clear();
		if (Networking.newCam && Networking.newCam.tempTarget != null)
		{
			Networking.newCam.tempTarget = null;
		}
	}

	// Token: 0x06000772 RID: 1906 RVA: 0x000306C0 File Offset: 0x0002E8C0
	private string MakeServerComment()
	{
		return this.MakeServerComment(Application.loadedLevelName, Networking.bundlefile);
	}

	// Token: 0x06000773 RID: 1907 RVA: 0x000306D4 File Offset: 0x0002E8D4
	private string MakeServerComment(string scenename, string bundnam)
	{
		string text = PhoneInterface.version;
		if (scenename == "Loader 1")
		{
			text = "Normal";
		}
		else if (scenename == "Loader 5")
		{
			text = "Tutorial";
		}
		else if (scenename == "test")
		{
			text = "Custom";
			if (!string.IsNullOrEmpty(Networking.bundlefile))
			{
				string text2 = bundnam;
				if (text2.StartsWith("http://") || text2.StartsWith("https://"))
				{
					text2 = text2.Substring(text2.LastIndexOf("/") + 1);
				}
				text = text2;
			}
		}
		if (Networking.my_net_player != null && Networking.my_net_player.userName != null)
		{
			text = string.Format("{0} ({1})", text, Networking.my_net_player.userName);
		}
		else
		{
			text = string.Format("{0} ({1})", text, TwitterDemo.instance.GetCurrentScreenName());
		}
		return text;
	}

	// Token: 0x06000774 RID: 1908 RVA: 0x000307CC File Offset: 0x0002E9CC
	private void StartServer()
	{
		string comment = this.MakeServerComment();
		Playtomic.Log.CustomMetric("has_started_server", PlaytomicController.current_group, true);
		Network.incomingPassword = this.password;
		int listenPort;
		if (!int.TryParse(this.port, out listenPort))
		{
			Debug.LogWarning("could not parse port '" + this.port + "' as int");
			listenPort = 7777;
			this.port = listenPort.ToString();
		}
		int num;
		if (!int.TryParse(this.max_players, out num))
		{
			Debug.LogWarning("could not parse max players '" + this.max_players + "' as int");
			num = 8;
			this.max_players = num.ToString();
		}
		if (!Networking.batchMode)
		{
			num--;
		}
		if (num < 0)
		{
			num = 0;
			this.max_players = 1.ToString();
		}
		Network.InitializeServer(num, listenPort, this.use_NAT);
		MasterServer.RegisterHost(Networking.mastergameid, this.server_name, comment);
		if (this.host_net == null && !Networking.batchMode)
		{
			this.host_net = (Network.Instantiate(this.player_prefab, this.player_tran.position, this.player_tran.rotation, 0) as NetPlayer);
			this.host_net.name = "host obj";
		}
	}

	// Token: 0x06000775 RID: 1909 RVA: 0x00030918 File Offset: 0x0002EB18
	private void GetServerList()
	{
		MasterServer.RequestHostList(Networking.mastergameid);
	}

	// Token: 0x06000776 RID: 1910 RVA: 0x00030924 File Offset: 0x0002EB24
	private void Update()
	{
		this.serverdats = MasterServer.PollHostList();
		if (Networking.new_message_timer > 0f)
		{
			Networking.new_message_timer -= Time.deltaTime;
		}
		if (!Networking.batchMode && (Network.isClient || Network.isServer))
		{
			int num = -1;
			Vector2 vector = new Vector2(Input.GetAxisRaw("EffectSwitch"), Input.GetAxisRaw("SpawnDebug"));
			if (vector.magnitude == 0f)
			{
				this.dpad_ready = true;
			}
			else if (this.dpad_ready)
			{
				if (vector.x > 0f)
				{
					if (vector.y > 0f)
					{
						num = 1;
					}
					else if (vector.y < 0f)
					{
						num = 7;
					}
					else
					{
						num = 0;
					}
				}
				else if (vector.x < 0f)
				{
					if (vector.y > 0f)
					{
						num = 3;
					}
					else if (vector.y < 0f)
					{
						num = 5;
					}
					else
					{
						num = 4;
					}
				}
				else if (vector.y > 0f)
				{
					num = 2;
				}
				else
				{
					num = 6;
				}
			}
			if (num != -1)
			{
				Networking.my_net_player.DoAddIcon(this.chat_icons[num].name);
				this.dpad_ready = false;
			}
		}
	}

	// Token: 0x06000777 RID: 1911 RVA: 0x00030A90 File Offset: 0x0002EC90
	private void NoneGUI()
	{
		this.DrawSettings();
		this.DrawBundleList();
		this.DrawSceneList();
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		GUILayout.Label("Name", new GUILayoutOption[0]);
		this.server_name = GUILayout.TextField(this.server_name, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		GUILayout.Label("ip", new GUILayoutOption[0]);
		this.ip_address = GUILayout.TextField(this.ip_address, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		GUILayout.Label("port", new GUILayoutOption[0]);
		this.port = GUILayout.TextField(this.port, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		GUILayout.Label("max players", new GUILayoutOption[0]);
		this.max_players = GUILayout.TextField(this.max_players, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		GUILayout.Label("password", new GUILayoutOption[0]);
		this.password = GUILayout.TextField(this.password, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		if (GUILayout.Button("Join server...", new GUILayoutOption[0]))
		{
			int remotePort;
			if (!int.TryParse(this.port, out remotePort))
			{
				Debug.LogWarning("could not parse port '" + this.port + "' as int");
				remotePort = 7777;
				this.port = remotePort.ToString();
			}
			this.SaveCurrentServer();
			Network.Connect(this.ip_address, remotePort, this.password);
		}
		if (GUILayout.Button("Start server...", new GUILayoutOption[0]))
		{
			this.StartServer();
		}
		GUILayout.EndHorizontal();
		if (GUILayout.Button("refresh server list", new GUILayoutOption[0]))
		{
			this.GetServerList();
		}
		this.DrawServerList();
		GUILayout.EndVertical();
	}

	// Token: 0x06000778 RID: 1912 RVA: 0x00030C98 File Offset: 0x0002EE98
	private void DrawServerList()
	{
		foreach (HostData hostData in this.serverdats)
		{
			GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
			GUILayout.BeginHorizontal(new GUILayoutOption[0]);
			GUILayout.Label(string.Format("{0} ({1}/{2})", hostData.gameName, hostData.connectedPlayers, hostData.playerLimit), new GUILayoutOption[0]);
			GUILayout.Space(5f);
			GUILayout.Space(5f);
			GUILayout.FlexibleSpace();
			if (GUILayout.Button("Connect", new GUILayoutOption[0]))
			{
				Network.Connect(hostData, this.password);
			}
			GUILayout.EndHorizontal();
			GUILayout.BeginHorizontal(new GUILayoutOption[0]);
			GUILayout.Label(hostData.comment, new GUILayoutOption[0]);
			if (hostData.useNat)
			{
				Color color = GUI.color;
				GUI.color = Color.yellow;
				GUILayout.Label("NAT", new GUILayoutOption[0]);
				GUI.color = color;
			}
			if (hostData.passwordProtected)
			{
				Color color2 = GUI.color;
				if (string.IsNullOrEmpty(this.password))
				{
					GUI.color = Color.red;
				}
				GUILayout.Label("Password", new GUILayoutOption[0]);
				GUI.color = color2;
			}
			GUILayout.EndHorizontal();
			GUILayout.EndVertical();
		}
	}

	// Token: 0x06000779 RID: 1913 RVA: 0x00030DF0 File Offset: 0x0002EFF0
	private void ServerGUI()
	{
		this.DrawBundleList();
		this.DrawSceneList();
		GUILayout.Box(string.Format("{0} ({1})", this.server_name, Network.player.ipAddress), new GUILayoutOption[0]);
		this.DrawChatGUI();
		this.DrawPlayerList();
		if (GUILayout.Button("Disconnect", new GUILayoutOption[0]))
		{
			this.Disconnect();
		}
	}

	// Token: 0x0600077A RID: 1914 RVA: 0x00030E58 File Offset: 0x0002F058
	private void ClientGUI()
	{
		this.DrawChatGUI();
		this.DrawPlayerList();
		if (GUILayout.Button("Disconnect", new GUILayoutOption[0]))
		{
			this.Disconnect();
		}
	}

	// Token: 0x0600077B RID: 1915 RVA: 0x00030E84 File Offset: 0x0002F084
	private void DrawPlayerList()
	{
		string text = "Pals";
		if (this.show_player_list)
		{
			text += " ";
		}
		if (Network.isServer)
		{
			text += string.Format("[{0}/{1}]", (Network.connections.Length + 1).ToString(), (Network.maxConnections + 1).ToString());
		}
		else
		{
			text += string.Format("[{0}]", Networking.netplayer_dic.Count.ToString());
		}
		Rect screenRect = this.player_list_rect;
		if (!this.show_player_list)
		{
			screenRect.width = this.small_chat_rect.width;
			screenRect.height = this.small_chat_rect.height;
			screenRect = GUILayout.Window(3, screenRect, new GUI.WindowFunction(this.DrawPlayerListWindow), text, new GUILayoutOption[]
			{
				GUILayout.ExpandWidth(false)
			});
			this.player_list_rect.x = screenRect.x;
			this.player_list_rect.y = screenRect.y;
			if (this.player_list_rect.width != 32f)
			{
				this.player_list_rect.width = 32f;
				this.player_list_rect.height = 32f;
			}
		}
		else
		{
			this.player_list_rect = GUILayout.Window(3, this.player_list_rect, new GUI.WindowFunction(this.DrawPlayerListWindow), text, new GUILayoutOption[]
			{
				GUILayout.ExpandWidth(true),
				GUILayout.ExpandHeight(true)
			});
		}
	}

	// Token: 0x0600077C RID: 1916 RVA: 0x00031004 File Offset: 0x0002F204
	private void DrawPlayerListWindow(int id)
	{
		this.show_player_list = GUILayout.Toggle(this.show_player_list, "show", new GUILayoutOption[0]);
		if (this.show_player_list)
		{
			if (Networking.newCam && Networking.newCam.tempTarget != null && GUILayout.Button("Stop looking", new GUILayoutOption[0]))
			{
				Networking.newCam.tempTarget = null;
			}
			foreach (NetworkPlayer key in Networking.netplayer_dic.Keys)
			{
				this.DrawPlayer(Networking.netplayer_dic[key]);
			}
		}
		GUI.DragWindow();
	}

	// Token: 0x0600077D RID: 1917 RVA: 0x000310E8 File Offset: 0x0002F2E8
	public Texture2D GetMoodIcon(float index)
	{
		return this.GetMoodIcon(Mathf.RoundToInt(index));
	}

	// Token: 0x0600077E RID: 1918 RVA: 0x000310F8 File Offset: 0x0002F2F8
	public Texture2D GetMoodIcon(int index)
	{
		index = Mathf.Clamp(index, 0, this.moodIcons.Length - 1);
		return this.moodIcons[index];
	}

	// Token: 0x0600077F RID: 1919 RVA: 0x00031118 File Offset: 0x0002F318
	private void DrawPlayer(NetPlayer player)
	{
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		string text = player.userName;
		text += player.netStatus;
		int num = Mathf.RoundToInt(player.ping * 1000f);
		if (num <= 0)
		{
			num = -1;
		}
		GUIContent content = new GUIContent(text, player.iconTex);
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		bool flag = GUILayout.Button(content, new GUILayoutOption[]
		{
			GUILayout.Height(48f)
		});
		GUILayout.FlexibleSpace();
		GUILayout.Label(player.pizzaScore.ToString(), new GUILayoutOption[0]);
		if (Network.player == player.networkPlayer)
		{
			GUILayout.EndHorizontal();
			GUILayout.BeginHorizontal(new GUILayoutOption[0]);
			float num2 = GUILayout.HorizontalSlider(player.mood, 0f, (float)(this.moodIcons.Length - 1), new GUILayoutOption[]
			{
				GUILayout.Width(64f)
			});
			if (num2 != player.mood && Mathf.RoundToInt(num2) != Mathf.RoundToInt(player.mood))
			{
				player.DoSetMood(Mathf.RoundToInt(num2));
			}
			player.mood = num2;
			GUIContent content2 = new GUIContent("mood", this.GetMoodIcon(player.mood));
			GUILayout.Label(content2, new GUILayoutOption[0]);
		}
		else
		{
			GUILayout.Label(this.GetMoodIcon(player.mood), new GUILayoutOption[0]);
		}
		GUILayout.EndHorizontal();
		if (this.gui_expanded_list.Contains(player))
		{
			if (flag)
			{
				this.gui_expanded_list.Remove(player);
			}
			GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
			if (Network.player != player.networkPlayer && Networking.newCam && player.camTarget)
			{
				bool flag2 = Networking.newCam.tempTarget == player.camTarget;
				bool flag3 = GUILayout.Toggle(flag2, "look", new GUILayoutOption[0]);
				if (!flag2 && flag3)
				{
					Networking.newCam.tempTarget = player.camTarget;
					this.iswatching = true;
				}
				else if (flag2 && !flag3)
				{
					Networking.newCam.tempTarget = null;
					this.iswatching = false;
				}
			}
			if (Network.player == player.networkPlayer && GUILayout.Button("Respawn...", new GUILayoutOption[0]))
			{
				SpawnPointScript.instance.SpawnPlayerAtStart();
			}
			if (num != -1)
			{
				GUILayout.Label("ping: " + num.ToString(), new GUILayoutOption[0]);
			}
			if (!string.IsNullOrEmpty(player.twitterId) && GUILayout.Button("Twitter Page", new GUILayoutOption[0]))
			{
				Application.OpenURL(string.Format("https://twitter.com/account/redirect_by_id?id={0}", player.twitterId));
			}
			if (Networking.IsDev() && player.networkPlayer != Network.player && GUILayout.Button("Warp->>>", new GUILayoutOption[0]))
			{
				if (PhoneInterface.hawk && PhoneInterface.hawk.targetHeld)
				{
					PhoneInterface.hawk.Drop();
				}
				PhoneInterface.player_trans.transform.position = player.transform.position;
				PhoneInterface.player_trans.transform.rotation = player.transform.rotation;
			}
			if (player.networkView != null && Network.isServer && Network.player != player.networkPlayer && GUILayout.Button("Kick", new GUILayoutOption[0]))
			{
				Network.CloseConnection(player.networkPlayer, true);
			}
			if (!Networking.batchMode && player.networkPlayer == Network.player)
			{
				if (Networking.IsDev())
				{
					if (PhoneInterface.hawk && !PhoneInterface.hawk.canControl && GUILayout.Button("bird powers", new GUILayoutOption[0]))
					{
						PhoneInterface.hawk.canControl = true;
					}
					if (!PhoneInterface.player_move.canDebugBoost && GUILayout.Button("\"it's boost time\"", new GUILayoutOption[0]))
					{
						PhoneInterface.player_move.canDebugBoost = true;
					}
				}
				if (Networking.IsDev() && GUILayout.Button("ghost trainer", new GUILayoutOption[0]))
				{
					player.DoMakeTrainer();
				}
			}
			GUILayout.EndVertical();
		}
		else if (flag)
		{
			this.gui_expanded_list.Add(player);
		}
		GUILayout.EndVertical();
	}

	// Token: 0x06000780 RID: 1920 RVA: 0x000315BC File Offset: 0x0002F7BC
	private void DrawChatGUI()
	{
		if (this.draw_chat_log)
		{
			this.chat_log_rect.width = this.normal_chat_rect.width;
			this.chat_log_rect.height = this.normal_chat_rect.height;
		}
		else
		{
			this.chat_log_rect.width = this.small_chat_rect.width;
			this.chat_log_rect.height = this.small_chat_rect.height;
		}
		Color backgroundColor = GUI.backgroundColor;
		if (Networking.new_message_timer > 0f)
		{
			GUI.backgroundColor = Color.Lerp(backgroundColor, Color.yellow, Networking.new_message_timer);
		}
		this.chat_log_rect = GUI.Window(0, this.chat_log_rect, new GUI.WindowFunction(this.DrawChatLogWindow), "Talk");
		GUI.backgroundColor = backgroundColor;
		if (this.show_icon_list)
		{
			this.icon_list_rect.width = this.normal_icon_rect.width;
			this.icon_list_rect.height = this.normal_icon_rect.height;
		}
		else
		{
			this.icon_list_rect.width = this.small_chat_rect.width;
			this.icon_list_rect.height = this.small_chat_rect.height;
		}
		this.icon_list_rect = GUI.Window(1, this.icon_list_rect, new GUI.WindowFunction(this.DrawChatIconList), "Emote");
	}

	// Token: 0x06000781 RID: 1921 RVA: 0x00031710 File Offset: 0x0002F910
	private void DrawChatIconList(int id)
	{
		this.show_icon_list = GUI.Toggle(this.toggrect, this.show_icon_list, string.Empty);
		if (!this.show_icon_list)
		{
			GUI.DragWindow();
			return;
		}
		float num = 32f;
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		foreach (string text in Networking.chat_icon_dic.Keys)
		{
			if (GUILayout.Button(Networking.chat_icon_dic[text], new GUILayoutOption[]
			{
				GUILayout.Height(num),
				GUILayout.Width(num)
			}) && Networking.my_net_player)
			{
				Networking.my_net_player.DoAddIcon(text);
			}
		}
		if (!Networking.batchMode && Networking.IsDev())
		{
			GUILayout.BeginVertical(new GUILayoutOption[0]);
			if (this.critter_prefab && GUILayout.Button("C", new GUILayoutOption[0]))
			{
				Network.Instantiate(this.critter_prefab, this.player_tran.position + this.player_tran.up, this.player_tran.rotation, 1);
				this.SendChatMessageRaw(string.Format("A Critter was unleashed by {0}!", Networking.my_net_player.userName));
			}
			if (Application.loadedLevelName != "Loader 5" && GUILayout.Button("H", new GUILayoutOption[0]))
			{
				Networking.my_net_player.DoCallHawk();
				this.SendChatMessageRaw(string.Format("{0} summoned some hawks!", Networking.my_net_player.userName));
			}
			GUILayout.EndVertical();
		}
		GUILayout.EndHorizontal();
		GUI.DragWindow();
	}

	// Token: 0x06000782 RID: 1922 RVA: 0x000318E8 File Offset: 0x0002FAE8
	private void DrawChatLogWindow(int id)
	{
		this.draw_chat_log = GUI.Toggle(this.toggrect, this.draw_chat_log, string.Empty);
		if (!this.draw_chat_log)
		{
			GUI.DragWindow();
			return;
		}
		GUI.SetNextControlName("chatlog");
		Networking.chat_scroll = GUILayout.BeginScrollView(Networking.chat_scroll, new GUILayoutOption[0]);
		foreach (string text in Networking.chat_log)
		{
			GUILayout.BeginHorizontal(new GUILayoutOption[0]);
			GUILayout.Label(text, new GUILayoutOption[0]);
			GUILayout.FlexibleSpace();
			GUILayout.EndHorizontal();
		}
		GUILayout.EndScrollView();
		if (Event.current.type == EventType.KeyDown && Event.current.character == '\n' && !string.IsNullOrEmpty(this.chat_input))
		{
			if (Networking.my_net_player)
			{
				Networking.my_net_player.DoChatMessage(this.chat_input);
			}
			this.chat_input = string.Empty;
		}
		this.chat_input = GUILayout.TextField(this.chat_input, new GUILayoutOption[0]);
		GUI.DragWindow();
	}

	// Token: 0x06000783 RID: 1923 RVA: 0x00031A30 File Offset: 0x0002FC30
	private void DrawBundleList()
	{
		if (Application.loadedLevelName != "test")
		{
			return;
		}
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		bool flag = this.drawbundles;
		this.drawbundles = GUILayout.Toggle(this.drawbundles, "bundles", new GUILayoutOption[0]);
		if (!flag && this.drawbundles)
		{
			SpawnPointScript.GetBundles();
		}
		if (!this.drawbundles)
		{
			GUILayout.EndVertical();
			return;
		}
		if (SpawnPointScript.bundlenames != null)
		{
			foreach (string path in SpawnPointScript.bundlenames)
			{
				string fileName = Path.GetFileName(path);
				if (GUILayout.Button(fileName, new GUILayoutOption[0]))
				{
					if (Networking.my_net_player)
					{
						Networking.my_net_player.DoLoadBundle(fileName);
					}
					else
					{
						SpawnPointScript.instance.LoadAndSpawn(fileName);
						Networking.bundlefile = fileName;
					}
					if (Network.isServer)
					{
						MasterServer.UnregisterHost();
						MasterServer.RegisterHost(Networking.mastergameid, this.server_name, this.MakeServerComment(Application.loadedLevelName, fileName));
					}
				}
			}
		}
		GUILayout.BeginHorizontal(new GUILayoutOption[0]);
		if (GUILayout.Button("URL", new GUILayoutOption[0]))
		{
			if (!this.bundleURL.StartsWith("http"))
			{
				this.bundleURL = "http://" + this.bundleURL;
			}
			if (this.bundleURL != "http://")
			{
				Networking.bundlefile = this.bundleURL;
				if (Networking.my_net_player)
				{
					Networking.my_net_player.DoLoadBundle(this.bundleURL);
				}
				else
				{
					SpawnPointScript.instance.LoadAndSpawn(this.bundleURL);
				}
				if (Network.isServer)
				{
					MasterServer.UnregisterHost();
					MasterServer.RegisterHost(Networking.mastergameid, this.server_name, this.MakeServerComment(Application.loadedLevelName, this.bundleURL));
				}
			}
		}
		this.bundleURL = GUILayout.TextField(this.bundleURL, new GUILayoutOption[0]);
		GUILayout.EndHorizontal();
		GUILayout.EndVertical();
	}

	// Token: 0x06000784 RID: 1924 RVA: 0x00031C44 File Offset: 0x0002FE44
	private void DrawSceneList()
	{
		if (Application.loadedLevelName == "test")
		{
			return;
		}
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		this.drawscenes = GUILayout.Toggle(this.drawscenes, "scenes", new GUILayoutOption[0]);
		if (!this.drawscenes)
		{
			GUILayout.EndVertical();
			return;
		}
		string loadedLevelName = Application.loadedLevelName;
		foreach (string text in this.scenelist)
		{
			if (text != loadedLevelName && GUILayout.Button(text, new GUILayoutOption[0]))
			{
				if (Network.isServer)
				{
					MasterServer.UnregisterHost();
					MasterServer.RegisterHost(Networking.mastergameid, this.server_name, this.MakeServerComment(text, Networking.bundlefile));
				}
				if (Networking.my_net_player)
				{
					Networking.my_net_player.DoSceneCommand(text);
				}
				else
				{
					Application.LoadLevel(text);
				}
			}
		}
		GUILayout.EndVertical();
	}

	// Token: 0x06000785 RID: 1925 RVA: 0x00031D40 File Offset: 0x0002FF40
	private void DrawSettings()
	{
		if (!this.drawsettings)
		{
			return;
		}
		GUILayout.BeginVertical("Box", new GUILayoutOption[0]);
		if (!string.IsNullOrEmpty(this.connectTestMessage))
		{
			GUILayout.Label(this.connectTestMessage, new GUILayoutOption[0]);
		}
		this.use_NAT = GUILayout.Toggle(this.use_NAT, "Use NAT? (don't touch!)", new GUILayoutOption[0]);
		GUILayout.EndVertical();
	}

	// Token: 0x06000786 RID: 1926 RVA: 0x00031DB0 File Offset: 0x0002FFB0
	public static void AddChatMessage(string message)
	{
		Networking.new_message_timer = 1f;
		Networking.chat_log.Add(message);
		if (Networking.chat_log.Count > Networking.max_chat_log_size)
		{
			Networking.chat_log.RemoveAt(0);
		}
		Networking.chat_scroll.y = float.PositiveInfinity;
	}

	// Token: 0x06000787 RID: 1927 RVA: 0x00031E00 File Offset: 0x00030000
	public void SendChatMessageRaw(string message)
	{
		if (Networking.my_net_player)
		{
			Networking.my_net_player.DoChatMessageRaw(message);
		}
	}

	// Token: 0x06000788 RID: 1928 RVA: 0x00031E1C File Offset: 0x0003001C
	public void SendChatMessage(string message)
	{
		if (Networking.my_net_player)
		{
			Networking.my_net_player.DoChatMessage(message);
		}
	}

	// Token: 0x06000789 RID: 1929 RVA: 0x00031E38 File Offset: 0x00030038
	public static void AddNetPlayer(NetworkPlayer networkplayer, NetPlayer netplayer)
	{
		if (!Networking.netplayer_dic.ContainsKey(networkplayer))
		{
			Networking.netplayer_dic.Add(networkplayer, netplayer);
		}
		else
		{
			Networking.netplayer_dic[networkplayer] = netplayer;
		}
	}

	// Token: 0x0600078A RID: 1930 RVA: 0x00031E68 File Offset: 0x00030068
	public static void RemoveNetPlayer(NetworkPlayer networkplayer)
	{
		if (Networking.netplayer_dic.ContainsKey(networkplayer))
		{
			Networking.netplayer_dic.Remove(networkplayer);
		}
	}

	// Token: 0x0600078B RID: 1931 RVA: 0x00031E88 File Offset: 0x00030088
	public static bool IsDev()
	{
		if (!TwitterDemo.instance._isConnected || !TwitterDemo.instance._isCustom)
		{
			return false;
		}
		string currentUserId = TwitterDemo.instance.GetCurrentUserId();
		return currentUserId == "280379781" || currentUserId == "293352325" || currentUserId == "751234076" || currentUserId == "293795267" || currentUserId == "272431331" || currentUserId == "177965708";
	}

	// Token: 0x04000622 RID: 1570
	public string ip_address = "localhost";

	// Token: 0x04000623 RID: 1571
	public string port = "7777";

	// Token: 0x04000624 RID: 1572
	private string server_name = "24/7 Freeze Tag";

	// Token: 0x04000625 RID: 1573
	public string password = string.Empty;

	// Token: 0x04000626 RID: 1574
	public string max_players = "12";

	// Token: 0x04000627 RID: 1575
	private bool use_NAT = true;

	// Token: 0x04000628 RID: 1576
	private static readonly string mastergameid = "xNewJSROnlineXDDXXxX";

	// Token: 0x04000629 RID: 1577
	public Animation player_anim;

	// Token: 0x0400062A RID: 1578
	public Transform other_tran;

	// Token: 0x0400062B RID: 1579
	public AudioClip _piz_clip;

	// Token: 0x0400062C RID: 1580
	public NetPlayer host_net;

	// Token: 0x0400062D RID: 1581
	public NetPlayer client_net;

	// Token: 0x0400062E RID: 1582
	private static Networking _instance;

	// Token: 0x0400062F RID: 1583
	public NetPlayer player_prefab;

	// Token: 0x04000630 RID: 1584
	public NPCTrainer trainer_prefab;

	// Token: 0x04000631 RID: 1585
	public static Dictionary<NetworkPlayer, NetPlayer> netplayer_dic = new Dictionary<NetworkPlayer, NetPlayer>();

	// Token: 0x04000632 RID: 1586
	private Transform camTarget;

	// Token: 0x04000633 RID: 1587
	private static NewCamera _newCam;

	// Token: 0x04000634 RID: 1588
	public static bool batchMode = false;

	// Token: 0x04000635 RID: 1589
	public bool auto;

	// Token: 0x04000636 RID: 1590
	private string connectTestMessage = string.Empty;

	// Token: 0x04000637 RID: 1591
	private ConnectionTesterStatus connectTest = ConnectionTesterStatus.Undetermined;

	// Token: 0x04000638 RID: 1592
	private bool showgui = true;

	// Token: 0x04000639 RID: 1593
	private bool dpad_ready = true;

	// Token: 0x0400063A RID: 1594
	private HostData[] serverdats = new HostData[0];

	// Token: 0x0400063B RID: 1595
	private bool iswatching;

	// Token: 0x0400063C RID: 1596
	private bool show_player_list = true;

	// Token: 0x0400063D RID: 1597
	private Rect player_list_rect = new Rect(4f, 80f, 32f, 32f);

	// Token: 0x0400063E RID: 1598
	private Vector2 player_list_scroll = Vector2.zero;

	// Token: 0x0400063F RID: 1599
	public Texture2D[] moodIcons = new Texture2D[0];

	// Token: 0x04000640 RID: 1600
	private List<NetPlayer> gui_expanded_list = new List<NetPlayer>();

	// Token: 0x04000641 RID: 1601
	public static Dictionary<string, Texture2D> chat_icon_dic = new Dictionary<string, Texture2D>();

	// Token: 0x04000642 RID: 1602
	public Texture2D[] chat_icons = new Texture2D[0];

	// Token: 0x04000643 RID: 1603
	private Rect toggrect = new Rect(2f, 0f, 16f, 16f);

	// Token: 0x04000644 RID: 1604
	private Rect normal_chat_rect = new Rect(0f, 300f, 360f, 240f);

	// Token: 0x04000645 RID: 1605
	private Rect small_chat_rect = new Rect(0f, 300f, 80f, 48f);

	// Token: 0x04000646 RID: 1606
	private Rect chat_log_rect = new Rect(200f, 80f, 360f, 240f);

	// Token: 0x04000647 RID: 1607
	public GameObject critter_prefab;

	// Token: 0x04000648 RID: 1608
	private bool show_icon_list = true;

	// Token: 0x04000649 RID: 1609
	private Rect icon_list_rect = new Rect(200f, 8f, 360f, 48f);

	// Token: 0x0400064A RID: 1610
	private Rect normal_icon_rect = new Rect(0f, 220f, 404f, 60f);

	// Token: 0x0400064B RID: 1611
	private static float new_message_timer = 0f;

	// Token: 0x0400064C RID: 1612
	private bool draw_chat_log = true;

	// Token: 0x0400064D RID: 1613
	private float maxwidth = 360f;

	// Token: 0x0400064E RID: 1614
	private string chat_input = string.Empty;

	// Token: 0x0400064F RID: 1615
	private static Vector2 chat_scroll = Vector2.zero;

	// Token: 0x04000650 RID: 1616
	private bool drawbundles;

	// Token: 0x04000651 RID: 1617
	private string bundleURL = string.Empty;

	// Token: 0x04000652 RID: 1618
	private bool drawscenes;

	// Token: 0x04000653 RID: 1619
	public static string bundlefile = string.Empty;

	// Token: 0x04000654 RID: 1620
	private string[] scenelist = new string[]
	{
		"test"
	};

	// Token: 0x04000655 RID: 1621
	private bool drawsettings;

	// Token: 0x04000656 RID: 1622
	private List<string> mute_list = new List<string>();

	// Token: 0x04000657 RID: 1623
	private static int max_chat_log_size = 48;

	// Token: 0x04000658 RID: 1624
	public static List<string> chat_log = new List<string>();
}
