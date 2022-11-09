using System;
using UnityEngine;

// Token: 0x020000A8 RID: 168
public class DoCommandTrigger : MonoBehaviour
{
	// Token: 0x06000704 RID: 1796 RVA: 0x0002CE78 File Offset: 0x0002B078
	private void Start()
	{
	}

	// Token: 0x06000705 RID: 1797 RVA: 0x0002CE7C File Offset: 0x0002B07C
	private void Update()
	{
	}

	// Token: 0x06000706 RID: 1798 RVA: 0x0002CE80 File Offset: 0x0002B080
	public virtual void Activate()
	{
		if (Application.isEditor)
		{
			MonoBehaviour.print("activated trigger " + base.gameObject.name);
		}
		if (!string.IsNullOrEmpty(this.command_string))
		{
			PhoneController.DoPhoneCommand(this.command_string);
		}
		if (base.gameObject.GetComponent<SecretObject>())
		{
			SecretObject component = base.gameObject.GetComponent<SecretObject>();
			component.Found();
		}
		if (this.destroy_on_activate)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	// Token: 0x06000707 RID: 1799 RVA: 0x0002CF0C File Offset: 0x0002B10C
	private void OnCollisionEnter(Collision collision)
	{
		if (collision.gameObject.name == "Player")
		{
			this.Activate();
		}
	}

	// Token: 0x06000708 RID: 1800 RVA: 0x0002CF3C File Offset: 0x0002B13C
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "Player")
		{
			this.Activate();
		}
	}

	// Token: 0x040005D8 RID: 1496
	public string command_string = string.Empty;

	// Token: 0x040005D9 RID: 1497
	public bool destroy_on_activate = true;
}
