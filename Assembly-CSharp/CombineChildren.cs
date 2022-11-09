using System;
using System.Collections;
using UnityEngine;

// Token: 0x020000B1 RID: 177
[AddComponentMenu("Mesh/Combine Children")]
public class CombineChildren : MonoBehaviour
{
	// Token: 0x060007A4 RID: 1956 RVA: 0x000327B0 File Offset: 0x000309B0
	private void Start()
	{
		Component[] componentsInChildren = base.GetComponentsInChildren(typeof(MeshFilter));
		Matrix4x4 worldToLocalMatrix = base.transform.worldToLocalMatrix;
		Hashtable hashtable = new Hashtable();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			MeshFilter meshFilter = (MeshFilter)componentsInChildren[i];
			Renderer renderer = componentsInChildren[i].renderer;
			MeshCombineUtility.MeshInstance meshInstance = default(MeshCombineUtility.MeshInstance);
			meshInstance.mesh = meshFilter.sharedMesh;
			if (renderer != null && renderer.enabled && meshInstance.mesh != null)
			{
				meshInstance.transform = worldToLocalMatrix * meshFilter.transform.localToWorldMatrix;
				Material[] sharedMaterials = renderer.sharedMaterials;
				for (int j = 0; j < sharedMaterials.Length; j++)
				{
					meshInstance.subMeshIndex = Math.Min(j, meshInstance.mesh.subMeshCount - 1);
					ArrayList arrayList = (ArrayList)hashtable[sharedMaterials[j]];
					if (arrayList != null)
					{
						arrayList.Add(meshInstance);
					}
					else
					{
						arrayList = new ArrayList();
						arrayList.Add(meshInstance);
						hashtable.Add(sharedMaterials[j], arrayList);
					}
				}
				renderer.enabled = false;
			}
		}
		foreach (object obj in hashtable)
		{
			DictionaryEntry dictionaryEntry = (DictionaryEntry)obj;
			ArrayList arrayList2 = (ArrayList)dictionaryEntry.Value;
			MeshCombineUtility.MeshInstance[] combines = (MeshCombineUtility.MeshInstance[])arrayList2.ToArray(typeof(MeshCombineUtility.MeshInstance));
			if (hashtable.Count == 1)
			{
				if (base.GetComponent(typeof(MeshFilter)) == null)
				{
					base.gameObject.AddComponent(typeof(MeshFilter));
				}
				if (!base.GetComponent("MeshRenderer"))
				{
					base.gameObject.AddComponent("MeshRenderer");
				}
				MeshFilter meshFilter2 = (MeshFilter)base.GetComponent(typeof(MeshFilter));
				meshFilter2.mesh = MeshCombineUtility.Combine(combines, this.generateTriangleStrips);
				base.renderer.material = (Material)dictionaryEntry.Key;
				base.renderer.enabled = true;
			}
			else
			{
				GameObject gameObject = new GameObject("Combined mesh");
				gameObject.transform.parent = base.transform;
				gameObject.transform.localScale = Vector3.one;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.AddComponent(typeof(MeshFilter));
				gameObject.AddComponent("MeshRenderer");
				gameObject.renderer.material = (Material)dictionaryEntry.Key;
				MeshFilter meshFilter3 = (MeshFilter)gameObject.GetComponent(typeof(MeshFilter));
				meshFilter3.mesh = MeshCombineUtility.Combine(combines, this.generateTriangleStrips);
			}
		}
		if (this.deleteCollidier)
		{
			foreach (object obj2 in base.transform)
			{
				Transform transform = (Transform)obj2;
				if (transform.name != "Combined mesh")
				{
					UnityEngine.Object.Destroy(transform.gameObject);
				}
			}
		}
		if (this.city)
		{
			foreach (object obj3 in base.transform)
			{
				Transform transform2 = (Transform)obj3;
				if (transform2.name == "Combined mesh")
				{
					transform2.gameObject.layer = LayerMask.NameToLayer("City");
				}
			}
		}
	}

	// Token: 0x04000668 RID: 1640
	public bool generateTriangleStrips = true;

	// Token: 0x04000669 RID: 1641
	public bool deleteCollidier;

	// Token: 0x0400066A RID: 1642
	public bool city;
}
