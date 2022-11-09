using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x020000CE RID: 206
[ExecuteInEditMode]
[AddComponentMenu("Terrain/Terrain Toolkit")]
public class TerrainToolkit : MonoBehaviour
{
	// Token: 0x06000874 RID: 2164 RVA: 0x00039DF8 File Offset: 0x00037FF8
	public void addPresets()
	{
		this.presetsInitialised = true;
		this.voronoiPresets = new ArrayList();
		this.fractalPresets = new ArrayList();
		this.perlinPresets = new ArrayList();
		this.thermalErosionPresets = new ArrayList();
		this.fastHydraulicErosionPresets = new ArrayList();
		this.fullHydraulicErosionPresets = new ArrayList();
		this.velocityHydraulicErosionPresets = new ArrayList();
		this.tidalErosionPresets = new ArrayList();
		this.windErosionPresets = new ArrayList();
		this.voronoiPresets.Add(new TerrainToolkit.voronoiPresetData("Scattered Peaks", TerrainToolkit.VoronoiType.Linear, 16, 8f, 0.5f, 1f));
		this.voronoiPresets.Add(new TerrainToolkit.voronoiPresetData("Rolling Hills", TerrainToolkit.VoronoiType.Sine, 8, 8f, 0f, 1f));
		this.voronoiPresets.Add(new TerrainToolkit.voronoiPresetData("Jagged Mountains", TerrainToolkit.VoronoiType.Linear, 32, 32f, 0.5f, 1f));
		this.fractalPresets.Add(new TerrainToolkit.fractalPresetData("Rolling Plains", 0.4f, 1f));
		this.fractalPresets.Add(new TerrainToolkit.fractalPresetData("Rough Mountains", 0.5f, 1f));
		this.fractalPresets.Add(new TerrainToolkit.fractalPresetData("Add Noise", 0.75f, 0.05f));
		this.perlinPresets.Add(new TerrainToolkit.perlinPresetData("Rough Plains", 2, 0.5f, 9, 1f));
		this.perlinPresets.Add(new TerrainToolkit.perlinPresetData("Rolling Hills", 5, 0.75f, 3, 1f));
		this.perlinPresets.Add(new TerrainToolkit.perlinPresetData("Rocky Mountains", 4, 1f, 8, 1f));
		this.perlinPresets.Add(new TerrainToolkit.perlinPresetData("Hellish Landscape", 11, 1f, 7, 1f));
		this.perlinPresets.Add(new TerrainToolkit.perlinPresetData("Add Noise", 10, 1f, 8, 0.2f));
		this.thermalErosionPresets.Add(new TerrainToolkit.thermalErosionPresetData("Gradual, Weak Erosion", 25, 7.5f, 0.5f));
		this.thermalErosionPresets.Add(new TerrainToolkit.thermalErosionPresetData("Fast, Harsh Erosion", 25, 2.5f, 0.1f));
		this.thermalErosionPresets.Add(new TerrainToolkit.thermalErosionPresetData("Thermal Erosion Brush", 25, 0.1f, 0f));
		this.fastHydraulicErosionPresets.Add(new TerrainToolkit.fastHydraulicErosionPresetData("Rainswept Earth", 25, 70f, 1f));
		this.fastHydraulicErosionPresets.Add(new TerrainToolkit.fastHydraulicErosionPresetData("Terraced Slopes", 25, 30f, 0.4f));
		this.fastHydraulicErosionPresets.Add(new TerrainToolkit.fastHydraulicErosionPresetData("Hydraulic Erosion Brush", 25, 85f, 1f));
		this.fullHydraulicErosionPresets.Add(new TerrainToolkit.fullHydraulicErosionPresetData("Low Rainfall, Hard Rock", 25, 0.01f, 0.5f, 0.01f, 0.1f));
		this.fullHydraulicErosionPresets.Add(new TerrainToolkit.fullHydraulicErosionPresetData("Low Rainfall, Soft Earth", 25, 0.01f, 0.5f, 0.06f, 0.15f));
		this.fullHydraulicErosionPresets.Add(new TerrainToolkit.fullHydraulicErosionPresetData("Heavy Rainfall, Hard Rock", 25, 0.02f, 0.5f, 0.01f, 0.1f));
		this.fullHydraulicErosionPresets.Add(new TerrainToolkit.fullHydraulicErosionPresetData("Heavy Rainfall, Soft Earth", 25, 0.02f, 0.5f, 0.06f, 0.15f));
		this.velocityHydraulicErosionPresets.Add(new TerrainToolkit.velocityHydraulicErosionPresetData("Low Rainfall, Hard Rock", 25, 0.01f, 0.5f, 0.01f, 0.1f, 1f, 1f, 0.05f, 0.12f));
		this.velocityHydraulicErosionPresets.Add(new TerrainToolkit.velocityHydraulicErosionPresetData("Low Rainfall, Soft Earth", 25, 0.01f, 0.5f, 0.06f, 0.15f, 1.2f, 2.8f, 0.05f, 0.12f));
		this.velocityHydraulicErosionPresets.Add(new TerrainToolkit.velocityHydraulicErosionPresetData("Heavy Rainfall, Hard Rock", 25, 0.02f, 0.5f, 0.01f, 0.1f, 1.1f, 2.2f, 0.05f, 0.12f));
		this.velocityHydraulicErosionPresets.Add(new TerrainToolkit.velocityHydraulicErosionPresetData("Heavy Rainfall, Soft Earth", 25, 0.02f, 0.5f, 0.06f, 0.15f, 1.2f, 2.4f, 0.05f, 0.12f));
		this.velocityHydraulicErosionPresets.Add(new TerrainToolkit.velocityHydraulicErosionPresetData("Carved Stone", 25, 0.01f, 0.5f, 0.01f, 0.1f, 2f, 1.25f, 0.05f, 0.35f));
		this.tidalErosionPresets.Add(new TerrainToolkit.tidalErosionPresetData("Low Tidal Range, Calm Waves", 25, 5f, 65f));
		this.tidalErosionPresets.Add(new TerrainToolkit.tidalErosionPresetData("Low Tidal Range, Strong Waves", 25, 5f, 35f));
		this.tidalErosionPresets.Add(new TerrainToolkit.tidalErosionPresetData("High Tidal Range, Calm Water", 25, 15f, 55f));
		this.tidalErosionPresets.Add(new TerrainToolkit.tidalErosionPresetData("High Tidal Range, Strong Waves", 25, 15f, 25f));
		this.windErosionPresets.Add(new TerrainToolkit.windErosionPresetData("Default (Northerly)", 25, 180f, 0.5f, 0.01f, 0.5f, 0.01f, 0.1f, 0.25f));
		this.windErosionPresets.Add(new TerrainToolkit.windErosionPresetData("Default (Southerly)", 25, 0f, 0.5f, 0.01f, 0.5f, 0.01f, 0.1f, 0.25f));
		this.windErosionPresets.Add(new TerrainToolkit.windErosionPresetData("Default (Easterly)", 25, 270f, 0.5f, 0.01f, 0.5f, 0.01f, 0.1f, 0.25f));
		this.windErosionPresets.Add(new TerrainToolkit.windErosionPresetData("Default (Westerly)", 25, 90f, 0.5f, 0.01f, 0.5f, 0.01f, 0.1f, 0.25f));
	}

	// Token: 0x06000875 RID: 2165 RVA: 0x0003A424 File Offset: 0x00038624
	public void setVoronoiPreset(TerrainToolkit.voronoiPresetData preset)
	{
		this.generatorTypeInt = 0;
		this.generatorType = TerrainToolkit.GeneratorType.Voronoi;
		this.voronoiTypeInt = (int)preset.voronoiType;
		this.voronoiType = preset.voronoiType;
		this.voronoiCells = preset.voronoiCells;
		this.voronoiFeatures = preset.voronoiFeatures;
		this.voronoiScale = preset.voronoiScale;
		this.voronoiBlend = preset.voronoiBlend;
	}

	// Token: 0x06000876 RID: 2166 RVA: 0x0003A488 File Offset: 0x00038688
	public void setFractalPreset(TerrainToolkit.fractalPresetData preset)
	{
		this.generatorTypeInt = 1;
		this.generatorType = TerrainToolkit.GeneratorType.DiamondSquare;
		this.diamondSquareDelta = preset.diamondSquareDelta;
		this.diamondSquareBlend = preset.diamondSquareBlend;
	}

	// Token: 0x06000877 RID: 2167 RVA: 0x0003A4BC File Offset: 0x000386BC
	public void setPerlinPreset(TerrainToolkit.perlinPresetData preset)
	{
		this.generatorTypeInt = 2;
		this.generatorType = TerrainToolkit.GeneratorType.Perlin;
		this.perlinFrequency = preset.perlinFrequency;
		this.perlinAmplitude = preset.perlinAmplitude;
		this.perlinOctaves = preset.perlinOctaves;
		this.perlinBlend = preset.perlinBlend;
	}

	// Token: 0x06000878 RID: 2168 RVA: 0x0003A508 File Offset: 0x00038708
	public void setThermalErosionPreset(TerrainToolkit.thermalErosionPresetData preset)
	{
		this.erosionTypeInt = 0;
		this.erosionType = TerrainToolkit.ErosionType.Thermal;
		this.thermalIterations = preset.thermalIterations;
		this.thermalMinSlope = preset.thermalMinSlope;
		this.thermalFalloff = preset.thermalFalloff;
	}

	// Token: 0x06000879 RID: 2169 RVA: 0x0003A548 File Offset: 0x00038748
	public void setFastHydraulicErosionPreset(TerrainToolkit.fastHydraulicErosionPresetData preset)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 0;
		this.hydraulicType = TerrainToolkit.HydraulicType.Fast;
		this.hydraulicIterations = preset.hydraulicIterations;
		this.hydraulicMaxSlope = preset.hydraulicMaxSlope;
		this.hydraulicFalloff = preset.hydraulicFalloff;
	}

	// Token: 0x0600087A RID: 2170 RVA: 0x0003A598 File Offset: 0x00038798
	public void setFullHydraulicErosionPreset(TerrainToolkit.fullHydraulicErosionPresetData preset)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 1;
		this.hydraulicType = TerrainToolkit.HydraulicType.Full;
		this.hydraulicIterations = preset.hydraulicIterations;
		this.hydraulicRainfall = preset.hydraulicRainfall;
		this.hydraulicEvaporation = preset.hydraulicEvaporation;
		this.hydraulicSedimentSolubility = preset.hydraulicSedimentSolubility;
		this.hydraulicSedimentSaturation = preset.hydraulicSedimentSaturation;
	}

	// Token: 0x0600087B RID: 2171 RVA: 0x0003A600 File Offset: 0x00038800
	public void setVelocityHydraulicErosionPreset(TerrainToolkit.velocityHydraulicErosionPresetData preset)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 2;
		this.hydraulicType = TerrainToolkit.HydraulicType.Velocity;
		this.hydraulicIterations = preset.hydraulicIterations;
		this.hydraulicVelocityRainfall = preset.hydraulicVelocityRainfall;
		this.hydraulicVelocityEvaporation = preset.hydraulicVelocityEvaporation;
		this.hydraulicVelocitySedimentSolubility = preset.hydraulicVelocitySedimentSolubility;
		this.hydraulicVelocitySedimentSaturation = preset.hydraulicVelocitySedimentSaturation;
		this.hydraulicVelocity = preset.hydraulicVelocity;
		this.hydraulicMomentum = preset.hydraulicMomentum;
		this.hydraulicEntropy = preset.hydraulicEntropy;
		this.hydraulicDowncutting = preset.hydraulicDowncutting;
	}

	// Token: 0x0600087C RID: 2172 RVA: 0x0003A698 File Offset: 0x00038898
	public void setTidalErosionPreset(TerrainToolkit.tidalErosionPresetData preset)
	{
		this.erosionTypeInt = 2;
		this.erosionType = TerrainToolkit.ErosionType.Tidal;
		this.tidalIterations = preset.tidalIterations;
		this.tidalRangeAmount = preset.tidalRangeAmount;
		this.tidalCliffLimit = preset.tidalCliffLimit;
	}

	// Token: 0x0600087D RID: 2173 RVA: 0x0003A6D8 File Offset: 0x000388D8
	public void setWindErosionPreset(TerrainToolkit.windErosionPresetData preset)
	{
		this.erosionTypeInt = 3;
		this.erosionType = TerrainToolkit.ErosionType.Wind;
		this.windIterations = preset.windIterations;
		this.windDirection = preset.windDirection;
		this.windForce = preset.windForce;
		this.windLift = preset.windLift;
		this.windGravity = preset.windGravity;
		this.windCapacity = preset.windCapacity;
		this.windEntropy = preset.windEntropy;
		this.windSmoothing = preset.windSmoothing;
	}

	// Token: 0x0600087E RID: 2174 RVA: 0x0003A754 File Offset: 0x00038954
	public void Update()
	{
		if (this.isBrushOn && (this.toolModeInt != 1 || this.erosionTypeInt > 2 || (this.erosionTypeInt == 1 && this.hydraulicTypeInt > 0)))
		{
			this.isBrushOn = false;
		}
	}

	// Token: 0x0600087F RID: 2175 RVA: 0x0003A7A4 File Offset: 0x000389A4
	public void OnDrawGizmos()
	{
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		if (terrain == null)
		{
			return;
		}
		if (this.isBrushOn && !this.isBrushHidden)
		{
			if (this.isBrushPainting)
			{
				Gizmos.color = Color.red;
			}
			else
			{
				Gizmos.color = Color.white;
			}
			float num = this.brushSize / 4f;
			Gizmos.DrawLine(this.brushPosition + new Vector3(-num, 0f, 0f), this.brushPosition + new Vector3(num, 0f, 0f));
			Gizmos.DrawLine(this.brushPosition + new Vector3(0f, -num, 0f), this.brushPosition + new Vector3(0f, num, 0f));
			Gizmos.DrawLine(this.brushPosition + new Vector3(0f, 0f, -num), this.brushPosition + new Vector3(0f, 0f, num));
			Gizmos.DrawWireCube(this.brushPosition, new Vector3(this.brushSize, 0f, this.brushSize));
			Gizmos.DrawWireSphere(this.brushPosition, this.brushSize / 2f);
		}
		TerrainData terrainData = terrain.terrainData;
		Vector3 size = terrainData.size;
		if (this.toolModeInt == 1 && this.erosionTypeInt == 2)
		{
			Gizmos.color = Color.blue;
			Gizmos.DrawWireCube(new Vector3(base.transform.position.x + size.x / 2f, this.tidalSeaLevel, base.transform.position.z + size.z / 2f), new Vector3(size.x, 0f, size.z));
			Gizmos.color = Color.white;
			Gizmos.DrawWireCube(new Vector3(base.transform.position.x + size.x / 2f, this.tidalSeaLevel, base.transform.position.z + size.z / 2f), new Vector3(size.x, this.tidalRangeAmount * 2f, size.z));
		}
		if (this.toolModeInt == 1 && this.erosionTypeInt == 3)
		{
			Gizmos.color = Color.blue;
			Quaternion rotation = Quaternion.Euler(0f, this.windDirection, 0f);
			Vector3 a = rotation * Vector3.forward;
			Vector3 vector = new Vector3(base.transform.position.x + size.x / 2f, base.transform.position.y + size.y, base.transform.position.z + size.z / 2f);
			Vector3 vector2 = vector + a * (size.x / 4f);
			Vector3 a2 = vector + a * (size.x / 6f);
			Gizmos.DrawLine(vector, vector2);
			Gizmos.DrawLine(vector2, a2 + new Vector3(0f, size.x / 16f, 0f));
			Gizmos.DrawLine(vector2, a2 - new Vector3(0f, size.x / 16f, 0f));
		}
	}

	// Token: 0x06000880 RID: 2176 RVA: 0x0003AB68 File Offset: 0x00038D68
	public void paint()
	{
		this.convertIntVarsToEnums();
		this.erodeTerrainWithBrush();
	}

	// Token: 0x06000881 RID: 2177 RVA: 0x0003AB78 File Offset: 0x00038D78
	private void erodeTerrainWithBrush()
	{
		this.erosionMode = TerrainToolkit.ErosionMode.Brush;
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		if (terrain == null)
		{
			return;
		}
		try
		{
			TerrainData terrainData = terrain.terrainData;
			int heightmapWidth = terrainData.heightmapWidth;
			int heightmapHeight = terrainData.heightmapHeight;
			Vector3 size = terrainData.size;
			int num = (int)Mathf.Floor((float)heightmapWidth / size.x * this.brushSize);
			int num2 = (int)Mathf.Floor((float)heightmapHeight / size.z * this.brushSize);
			Vector3 vector = base.transform.InverseTransformPoint(this.brushPosition);
			int num3 = (int)Mathf.Round(vector.x / size.x * (float)heightmapWidth - (float)(num / 2));
			int num4 = (int)Mathf.Round(vector.z / size.z * (float)heightmapHeight - (float)(num2 / 2));
			if (num3 < 0)
			{
				num += num3;
				num3 = 0;
			}
			if (num4 < 0)
			{
				num2 += num4;
				num4 = 0;
			}
			if (num3 + num > heightmapWidth)
			{
				num = heightmapWidth - num3;
			}
			if (num4 + num2 > heightmapHeight)
			{
				num2 = heightmapHeight - num4;
			}
			float[,] heights = terrainData.GetHeights(num3, num4, num, num2);
			num = heights.GetLength(1);
			num2 = heights.GetLength(0);
			float[,] array = (float[,])heights.Clone();
			TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
			array = this.fastErosion(array, new Vector2((float)num, (float)num2), 1, erosionProgressDelegate);
			float num5 = (float)num / 2f;
			for (int i = 0; i < num; i++)
			{
				for (int j = 0; j < num2; j++)
				{
					float num6 = heights[j, i];
					float num7 = array[j, i];
					float num8 = Vector2.Distance(new Vector2((float)j, (float)i), new Vector2(num5, num5));
					float num9 = 1f - (num8 - (num5 - num5 * this.brushSoftness)) / (num5 * this.brushSoftness);
					if (num9 < 0f)
					{
						num9 = 0f;
					}
					else if (num9 > 1f)
					{
						num9 = 1f;
					}
					num9 *= this.brushOpacity;
					float num10 = num7 * num9 + num6 * (1f - num9);
					heights[j, i] = num10;
				}
			}
			terrainData.SetHeights(num3, num4, heights);
		}
		catch (Exception arg)
		{
			Debug.LogError("A brush error occurred: " + arg);
		}
	}

	// Token: 0x06000882 RID: 2178 RVA: 0x0003AE18 File Offset: 0x00039018
	public void erodeAllTerrain(TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate)
	{
		this.erosionMode = TerrainToolkit.ErosionMode.Filter;
		this.convertIntVarsToEnums();
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		if (terrain == null)
		{
			return;
		}
		try
		{
			TerrainData terrainData = terrain.terrainData;
			int heightmapWidth = terrainData.heightmapWidth;
			int heightmapHeight = terrainData.heightmapHeight;
			float[,] array = terrainData.GetHeights(0, 0, heightmapWidth, heightmapHeight);
			switch (this.erosionType)
			{
			case TerrainToolkit.ErosionType.Thermal:
			{
				int iterations = this.thermalIterations;
				array = this.fastErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
				break;
			}
			case TerrainToolkit.ErosionType.Hydraulic:
			{
				int iterations = this.hydraulicIterations;
				switch (this.hydraulicType)
				{
				case TerrainToolkit.HydraulicType.Fast:
					array = this.fastErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
					break;
				case TerrainToolkit.HydraulicType.Full:
					array = this.fullHydraulicErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
					break;
				case TerrainToolkit.HydraulicType.Velocity:
					array = this.velocityHydraulicErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
					break;
				}
				break;
			}
			case TerrainToolkit.ErosionType.Tidal:
			{
				Vector3 size = terrainData.size;
				if (this.tidalSeaLevel >= base.transform.position.y && this.tidalSeaLevel <= base.transform.position.y + size.y)
				{
					int iterations = this.tidalIterations;
					array = this.fastErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
				}
				else
				{
					Debug.LogError("Sea level does not intersect terrain object. Erosion operation failed.");
				}
				break;
			}
			case TerrainToolkit.ErosionType.Wind:
			{
				int iterations = this.windIterations;
				array = this.windErosion(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), iterations, erosionProgressDelegate);
				break;
			}
			default:
				return;
			}
			terrainData.SetHeights(0, 0, array);
		}
		catch (Exception arg)
		{
			Debug.LogError("An error occurred: " + arg);
		}
	}

	// Token: 0x06000883 RID: 2179 RVA: 0x0003B028 File Offset: 0x00039228
	private float[,] fastErosion(float[,] heightMap, Vector2 arraySize, int iterations, TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate)
	{
		int num = (int)arraySize.y;
		int num2 = (int)arraySize.x;
		float[,] array = new float[num, num2];
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		TerrainData terrainData = terrain.terrainData;
		Vector3 size = terrainData.size;
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 0f;
		float num6 = 0f;
		float num7 = 0f;
		float num8 = 0f;
		float num9 = 0f;
		float num10 = 0f;
		float num11 = 0f;
		switch (this.erosionType)
		{
		case TerrainToolkit.ErosionType.Thermal:
		{
			num3 = size.x / (float)num * Mathf.Tan(this.thermalMinSlope * 0.017453292f) / size.y;
			if (num3 > 1f)
			{
				num3 = 1f;
			}
			if (this.thermalFalloff == 1f)
			{
				this.thermalFalloff = 0.999f;
			}
			float num12 = this.thermalMinSlope + (90f - this.thermalMinSlope) * this.thermalFalloff;
			num4 = size.x / (float)num * Mathf.Tan(num12 * 0.017453292f) / size.y;
			if (num4 > 1f)
			{
				num4 = 1f;
			}
			break;
		}
		case TerrainToolkit.ErosionType.Hydraulic:
		{
			num6 = size.x / (float)num * Mathf.Tan(this.hydraulicMaxSlope * 0.017453292f) / size.y;
			if (this.hydraulicFalloff == 0f)
			{
				this.hydraulicFalloff = 0.001f;
			}
			float num13 = this.hydraulicMaxSlope * (1f - this.hydraulicFalloff);
			num5 = size.x / (float)num * Mathf.Tan(num13 * 0.017453292f) / size.y;
			break;
		}
		case TerrainToolkit.ErosionType.Tidal:
			num7 = (this.tidalSeaLevel - base.transform.position.y) / (base.transform.position.y + size.y);
			num8 = (this.tidalSeaLevel - base.transform.position.y - this.tidalRangeAmount) / (base.transform.position.y + size.y);
			num9 = (this.tidalSeaLevel - base.transform.position.y + this.tidalRangeAmount) / (base.transform.position.y + size.y);
			num10 = num9 - num7;
			num11 = size.x / (float)num * Mathf.Tan(this.tidalCliffLimit * 0.017453292f) / size.y;
			break;
		default:
			return heightMap;
		}
		for (int i = 0; i < iterations; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				int num14;
				int num15;
				int num16;
				if (j == 0)
				{
					num14 = 2;
					num15 = 0;
					num16 = 0;
				}
				else if (j == num2 - 1)
				{
					num14 = 2;
					num15 = -1;
					num16 = 1;
				}
				else
				{
					num14 = 3;
					num15 = -1;
					num16 = 1;
				}
				for (int k = 0; k < num; k++)
				{
					int num17;
					int num18;
					int num19;
					if (k == 0)
					{
						num17 = 2;
						num18 = 0;
						num19 = 0;
					}
					else if (k == num - 1)
					{
						num17 = 2;
						num18 = -1;
						num19 = 1;
					}
					else
					{
						num17 = 3;
						num18 = -1;
						num19 = 1;
					}
					float num20 = 1f;
					float num21 = 0f;
					float num22 = 0f;
					float num23 = heightMap[k + num19 + num18, j + num16 + num15];
					float num24 = num23;
					int num25 = 0;
					for (int l = 0; l < num14; l++)
					{
						for (int m = 0; m < num17; m++)
						{
							if ((m != num19 || l != num16) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num19 || l == num16))))
							{
								float num26 = heightMap[k + m + num18, j + l + num15];
								num24 += num26;
								float num27 = num23 - num26;
								if (num27 > 0f)
								{
									num22 += num27;
									if (num27 < num20)
									{
										num20 = num27;
									}
									if (num27 > num21)
									{
										num21 = num27;
									}
								}
								num25++;
							}
						}
					}
					float num28 = num22 / (float)num25;
					bool flag = false;
					switch (this.erosionType)
					{
					case TerrainToolkit.ErosionType.Thermal:
						if (num28 >= num3)
						{
							flag = true;
						}
						break;
					case TerrainToolkit.ErosionType.Hydraulic:
						if (num28 > 0f && num28 <= num6)
						{
							flag = true;
						}
						break;
					case TerrainToolkit.ErosionType.Tidal:
						if (num28 > 0f && num28 <= num11 && num23 < num9 && num23 > num8)
						{
							flag = true;
						}
						break;
					default:
						return heightMap;
					}
					if (flag)
					{
						if (this.erosionType == TerrainToolkit.ErosionType.Tidal)
						{
							float num29 = num24 / (float)(num25 + 1);
							float num30 = Mathf.Abs(num7 - num23);
							float num31 = num30 / num10;
							float num32 = num23 * num31 + num29 * (1f - num31);
							float num33 = Mathf.Pow(num30, 3f);
							heightMap[k + num19 + num18, j + num16 + num15] = num7 * num33 + num32 * (1f - num33);
						}
						else
						{
							float num31;
							if (this.erosionType == TerrainToolkit.ErosionType.Thermal)
							{
								if (num28 > num4)
								{
									num31 = 1f;
								}
								else
								{
									float num34 = num4 - num3;
									num31 = (num28 - num3) / num34;
								}
							}
							else if (num28 < num5)
							{
								num31 = 1f;
							}
							else
							{
								float num34 = num6 - num5;
								num31 = 1f - (num28 - num5) / num34;
							}
							float num35 = num20 / 2f * num31;
							float num36 = heightMap[k + num19 + num18, j + num16 + num15];
							if (this.erosionMode == TerrainToolkit.ErosionMode.Filter || (this.erosionMode == TerrainToolkit.ErosionMode.Brush && this.useDifferenceMaps))
							{
								float num37 = array[k + num19 + num18, j + num16 + num15];
								float num38 = num37 - num35;
								array[k + num19 + num18, j + num16 + num15] = num38;
							}
							else
							{
								float num39 = num36 - num35;
								if (num39 < 0f)
								{
									num39 = 0f;
								}
								heightMap[k + num19 + num18, j + num16 + num15] = num39;
							}
							for (int l = 0; l < num14; l++)
							{
								for (int m = 0; m < num17; m++)
								{
									if ((m != num19 || l != num16) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num19 || l == num16))))
									{
										float num40 = heightMap[k + m + num18, j + l + num15];
										float num27 = num36 - num40;
										if (num27 > 0f)
										{
											float num41 = num35 * (num27 / num22);
											if (this.erosionMode == TerrainToolkit.ErosionMode.Filter || (this.erosionMode == TerrainToolkit.ErosionMode.Brush && this.useDifferenceMaps))
											{
												float num42 = array[k + m + num18, j + l + num15];
												float num43 = num42 + num41;
												array[k + m + num18, j + l + num15] = num43;
											}
											else
											{
												num40 += num41;
												if (num40 < 0f)
												{
													num40 = 0f;
												}
												heightMap[k + m + num18, j + l + num15] = num40;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			if ((this.erosionMode == TerrainToolkit.ErosionMode.Filter || (this.erosionMode == TerrainToolkit.ErosionMode.Brush && this.useDifferenceMaps)) && this.erosionType != TerrainToolkit.ErosionType.Tidal)
			{
				for (int j = 0; j < num2; j++)
				{
					for (int k = 0; k < num; k++)
					{
						float num44 = heightMap[k, j] + array[k, j];
						if (num44 > 1f)
						{
							num44 = 1f;
						}
						else if (num44 < 0f)
						{
							num44 = 0f;
						}
						heightMap[k, j] = num44;
						array[k, j] = 0f;
					}
				}
			}
			if (this.erosionMode == TerrainToolkit.ErosionMode.Filter)
			{
				string titleString = string.Empty;
				string displayString = string.Empty;
				switch (this.erosionType)
				{
				case TerrainToolkit.ErosionType.Thermal:
					titleString = "Applying Thermal Erosion";
					displayString = "Applying thermal erosion.";
					break;
				case TerrainToolkit.ErosionType.Hydraulic:
					titleString = "Applying Hydraulic Erosion";
					displayString = "Applying hydraulic erosion.";
					break;
				case TerrainToolkit.ErosionType.Tidal:
					titleString = "Applying Tidal Erosion";
					displayString = "Applying tidal erosion.";
					break;
				default:
					return heightMap;
				}
				float percentComplete = (float)i / (float)iterations;
				erosionProgressDelegate(titleString, displayString, i, iterations, percentComplete);
			}
		}
		return heightMap;
	}

	// Token: 0x06000884 RID: 2180 RVA: 0x0003B920 File Offset: 0x00039B20
	private float[,] velocityHydraulicErosion(float[,] heightMap, Vector2 arraySize, int iterations, TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float[,] array = new float[num, num2];
		float[,] array2 = new float[num, num2];
		float[,] array3 = new float[num, num2];
		float[,] array4 = new float[num, num2];
		float[,] array5 = new float[num, num2];
		float[,] array6 = new float[num, num2];
		float[,] array7 = new float[num, num2];
		float[,] array8 = new float[num, num2];
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				array3[j, i] = 0f;
				array4[j, i] = 0f;
				array5[j, i] = 0f;
				array6[j, i] = 0f;
				array7[j, i] = 0f;
				array8[j, i] = 0f;
			}
		}
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				float num3 = heightMap[j, i];
				array[j, i] = num3;
			}
		}
		for (int i = 0; i < num2; i++)
		{
			int num4;
			int num5;
			int num6;
			if (i == 0)
			{
				num4 = 2;
				num5 = 0;
				num6 = 0;
			}
			else if (i == num2 - 1)
			{
				num4 = 2;
				num5 = -1;
				num6 = 1;
			}
			else
			{
				num4 = 3;
				num5 = -1;
				num6 = 1;
			}
			for (int j = 0; j < num; j++)
			{
				int num7;
				int num8;
				int num9;
				if (j == 0)
				{
					num7 = 2;
					num8 = 0;
					num9 = 0;
				}
				else if (j == num - 1)
				{
					num7 = 2;
					num8 = -1;
					num9 = 1;
				}
				else
				{
					num7 = 3;
					num8 = -1;
					num9 = 1;
				}
				float num10 = 0f;
				float num11 = heightMap[j + num9 + num8, i + num6 + num5];
				int num12 = 0;
				for (int k = 0; k < num4; k++)
				{
					for (int l = 0; l < num7; l++)
					{
						if ((l != num9 || k != num6) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (l == num9 || k == num6))))
						{
							float num13 = heightMap[j + l + num8, i + k + num5];
							float num14 = Mathf.Abs(num11 - num13);
							num10 += num14;
							num12++;
						}
					}
				}
				float num15 = num10 / (float)num12;
				array2[j + num9 + num8, i + num6 + num5] = num15;
			}
		}
		for (int m = 0; m < iterations; m++)
		{
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num16 = array3[j, i] + array[j, i] * this.hydraulicVelocityRainfall;
					if (num16 > 1f)
					{
						num16 = 1f;
					}
					array3[j, i] = num16;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num17 = array7[j, i];
					float num18 = array3[j, i] * this.hydraulicVelocitySedimentSaturation;
					if (num17 < num18)
					{
						float num19 = array3[j, i] * array5[j, i] * this.hydraulicVelocitySedimentSolubility;
						if (num17 + num19 > num18)
						{
							num19 = num18 - num17;
						}
						float num11 = heightMap[j, i];
						if (num19 > num11)
						{
							num19 = num11;
						}
						array7[j, i] = num17 + num19;
						heightMap[j, i] = num11 - num19;
					}
				}
			}
			for (int i = 0; i < num2; i++)
			{
				int num4;
				int num5;
				int num6;
				if (i == 0)
				{
					num4 = 2;
					num5 = 0;
					num6 = 0;
				}
				else if (i == num2 - 1)
				{
					num4 = 2;
					num5 = -1;
					num6 = 1;
				}
				else
				{
					num4 = 3;
					num5 = -1;
					num6 = 1;
				}
				for (int j = 0; j < num; j++)
				{
					int num7;
					int num8;
					int num9;
					if (j == 0)
					{
						num7 = 2;
						num8 = 0;
						num9 = 0;
					}
					else if (j == num - 1)
					{
						num7 = 2;
						num8 = -1;
						num9 = 1;
					}
					else
					{
						num7 = 3;
						num8 = -1;
						num9 = 1;
					}
					float num10 = 0f;
					float num11 = heightMap[j, i];
					float num20 = num11;
					float num21 = array3[j, i];
					int num12 = 0;
					for (int k = 0; k < num4; k++)
					{
						for (int l = 0; l < num7; l++)
						{
							if ((l != num9 || k != num6) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (l == num9 || k == num6))))
							{
								float num13 = heightMap[j + l + num8, i + k + num5];
								float num22 = array3[j + l + num8, i + k + num5];
								float num14 = num11 + num21 - (num13 + num22);
								if (num14 > 0f)
								{
									num10 += num14;
									num20 += num11 + num21;
									num12++;
								}
							}
						}
					}
					float num23 = array5[j, i];
					float num24 = array2[j, i];
					float num25 = array7[j, i];
					float num26 = num23 + this.hydraulicVelocity * num24;
					float num27 = num20 / (float)(num12 + 1);
					float num28 = num11 + num21 - num27;
					float num29 = Mathf.Min(num21, num28 * (1f + num23));
					float num30 = array4[j, i];
					float num31 = num30 - num29;
					array4[j, i] = num31;
					float num32 = num26 * (num29 / num21);
					float num33 = num25 * (num29 / num21);
					for (int k = 0; k < num4; k++)
					{
						for (int l = 0; l < num7; l++)
						{
							if ((l != num9 || k != num6) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (l == num9 || k == num6))))
							{
								float num13 = heightMap[j + l + num8, i + k + num5];
								float num22 = array3[j + l + num8, i + k + num5];
								float num14 = num11 + num21 - (num13 + num22);
								if (num14 > 0f)
								{
									float num34 = array4[j + l + num8, i + k + num5];
									float num35 = num29 * (num14 / num10);
									float num36 = num34 + num35;
									array4[j + l + num8, i + k + num5] = num36;
									float num37 = array6[j + l + num8, i + k + num5];
									float num38 = num32 * this.hydraulicMomentum * (num14 / num10);
									float num39 = num37 + num38;
									array6[j + l + num8, i + k + num5] = num39;
									float num40 = array8[j + l + num8, i + k + num5];
									float num41 = num33 * this.hydraulicMomentum * (num14 / num10);
									float num42 = num40 + num41;
									array8[j + l + num8, i + k + num5] = num42;
								}
							}
						}
					}
					float num43 = array6[j, i];
					array6[j, i] = num43 - num32;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num44 = array5[j, i] + array6[j, i];
					num44 *= 1f - this.hydraulicEntropy;
					if (num44 > 1f)
					{
						num44 = 1f;
					}
					else if (num44 < 0f)
					{
						num44 = 0f;
					}
					array5[j, i] = num44;
					array6[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num45 = array3[j, i] + array4[j, i];
					float num46 = num45 * this.hydraulicVelocityEvaporation;
					num45 -= num46;
					if (num45 > 1f)
					{
						num45 = 1f;
					}
					else if (num45 < 0f)
					{
						num45 = 0f;
					}
					array3[j, i] = num45;
					array4[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num47 = array7[j, i] + array8[j, i];
					if (num47 > 1f)
					{
						num47 = 1f;
					}
					else if (num47 < 0f)
					{
						num47 = 0f;
					}
					array7[j, i] = num47;
					array8[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num18 = array3[j, i] * this.hydraulicVelocitySedimentSaturation;
					float num47 = array7[j, i];
					if (num47 > num18)
					{
						float num48 = num47 - num18;
						array7[j, i] = num18;
						float num49 = heightMap[j, i];
						heightMap[j, i] = num49 + num48;
					}
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num44 = array3[j, i];
					float num49 = heightMap[j, i];
					float num50 = 1f - Mathf.Abs(0.5f - num49) * 2f;
					float num51 = this.hydraulicDowncutting * num44 * num50;
					num49 -= num51;
					heightMap[j, i] = num49;
				}
			}
			float percentComplete = (float)m / (float)iterations;
			erosionProgressDelegate("Applying Hydraulic Erosion", "Applying hydraulic erosion.", m, iterations, percentComplete);
		}
		return heightMap;
	}

	// Token: 0x06000885 RID: 2181 RVA: 0x0003C3BC File Offset: 0x0003A5BC
	private float[,] fullHydraulicErosion(float[,] heightMap, Vector2 arraySize, int iterations, TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float[,] array = new float[num, num2];
		float[,] array2 = new float[num, num2];
		float[,] array3 = new float[num, num2];
		float[,] array4 = new float[num, num2];
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				array[j, i] = 0f;
				array2[j, i] = 0f;
				array3[j, i] = 0f;
				array4[j, i] = 0f;
			}
		}
		for (int k = 0; k < iterations; k++)
		{
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num3 = array[j, i] + this.hydraulicRainfall;
					if (num3 > 1f)
					{
						num3 = 1f;
					}
					array[j, i] = num3;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num4 = array3[j, i];
					float num5 = array[j, i] * this.hydraulicSedimentSaturation;
					if (num4 < num5)
					{
						float num6 = array[j, i] * this.hydraulicSedimentSolubility;
						if (num4 + num6 > num5)
						{
							num6 = num5 - num4;
						}
						float num7 = heightMap[j, i];
						if (num6 > num7)
						{
							num6 = num7;
						}
						array3[j, i] = num4 + num6;
						heightMap[j, i] = num7 - num6;
					}
				}
			}
			for (int i = 0; i < num2; i++)
			{
				int num8;
				int num9;
				int num10;
				if (i == 0)
				{
					num8 = 2;
					num9 = 0;
					num10 = 0;
				}
				else if (i == num2 - 1)
				{
					num8 = 2;
					num9 = -1;
					num10 = 1;
				}
				else
				{
					num8 = 3;
					num9 = -1;
					num10 = 1;
				}
				for (int j = 0; j < num; j++)
				{
					int num11;
					int num12;
					int num13;
					if (j == 0)
					{
						num11 = 2;
						num12 = 0;
						num13 = 0;
					}
					else if (j == num - 1)
					{
						num11 = 2;
						num12 = -1;
						num13 = 1;
					}
					else
					{
						num11 = 3;
						num12 = -1;
						num13 = 1;
					}
					float num14 = 0f;
					float num15 = 0f;
					float num7 = heightMap[j + num13 + num12, i + num10 + num9];
					float num16 = array[j + num13 + num12, i + num10 + num9];
					float num17 = num7;
					int num18 = 0;
					for (int l = 0; l < num8; l++)
					{
						for (int m = 0; m < num11; m++)
						{
							if ((m != num13 || l != num10) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num13 || l == num10))))
							{
								float num19 = heightMap[j + m + num12, i + l + num9];
								float num20 = array[j + m + num12, i + l + num9];
								float num21 = num7 + num16 - (num19 + num20);
								if (num21 > 0f)
								{
									num14 += num21;
									num17 += num19 + num20;
									num18++;
									if (num21 > num15)
									{
									}
								}
							}
						}
					}
					float num22 = num17 / (float)(num18 + 1);
					float b = num7 + num16 - num22;
					float num23 = Mathf.Min(num16, b);
					float num24 = array2[j + num13 + num12, i + num10 + num9];
					float num25 = num24 - num23;
					array2[j + num13 + num12, i + num10 + num9] = num25;
					float num26 = array3[j + num13 + num12, i + num10 + num9];
					float num27 = num26 * (num23 / num16);
					float num28 = array4[j + num13 + num12, i + num10 + num9];
					float num29 = num28 - num27;
					array4[j + num13 + num12, i + num10 + num9] = num29;
					for (int l = 0; l < num8; l++)
					{
						for (int m = 0; m < num11; m++)
						{
							if ((m != num13 || l != num10) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num13 || l == num10))))
							{
								float num19 = heightMap[j + m + num12, i + l + num9];
								float num20 = array[j + m + num12, i + l + num9];
								float num21 = num7 + num16 - (num19 + num20);
								if (num21 > 0f)
								{
									float num30 = array2[j + m + num12, i + l + num9];
									float num31 = num23 * (num21 / num14);
									float num32 = num30 + num31;
									array2[j + m + num12, i + l + num9] = num32;
									float num33 = array4[j + m + num12, i + l + num9];
									float num34 = num27 * (num21 / num14);
									float num35 = num33 + num34;
									array4[j + m + num12, i + l + num9] = num35;
								}
							}
						}
					}
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num36 = array[j, i] + array2[j, i];
					float num37 = num36 * this.hydraulicEvaporation;
					num36 -= num37;
					if (num36 < 0f)
					{
						num36 = 0f;
					}
					array[j, i] = num36;
					array2[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num38 = array3[j, i] + array4[j, i];
					if (num38 > 1f)
					{
						num38 = 1f;
					}
					else if (num38 < 0f)
					{
						num38 = 0f;
					}
					array3[j, i] = num38;
					array4[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num5 = array[j, i] * this.hydraulicSedimentSaturation;
					float num38 = array3[j, i];
					if (num38 > num5)
					{
						float num39 = num38 - num5;
						array3[j, i] = num5;
						float num40 = heightMap[j, i];
						heightMap[j, i] = num40 + num39;
					}
				}
			}
			float percentComplete = (float)k / (float)iterations;
			erosionProgressDelegate("Applying Hydraulic Erosion", "Applying hydraulic erosion.", k, iterations, percentComplete);
		}
		return heightMap;
	}

	// Token: 0x06000886 RID: 2182 RVA: 0x0003CADC File Offset: 0x0003ACDC
	private float[,] windErosion(float[,] heightMap, Vector2 arraySize, int iterations, TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate)
	{
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		TerrainData terrainData = terrain.terrainData;
		Quaternion rotation = Quaternion.Euler(0f, this.windDirection + 180f, 0f);
		Vector3 to = rotation * Vector3.forward;
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float[,] array = new float[num, num2];
		float[,] array2 = new float[num, num2];
		float[,] array3 = new float[num, num2];
		float[,] array4 = new float[num, num2];
		float[,] array5 = new float[num, num2];
		float[,] array6 = new float[num, num2];
		float[,] array7 = new float[num, num2];
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				array[j, i] = 0f;
				array2[j, i] = 0f;
				array3[j, i] = 0f;
				array4[j, i] = 0f;
				array5[j, i] = 0f;
				array6[j, i] = 0f;
				array7[j, i] = 0f;
			}
		}
		for (int k = 0; k < iterations; k++)
		{
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num3 = array3[j, i];
					float num4 = heightMap[j, i];
					float num5 = array5[j, i];
					float num6 = num5 * this.windGravity;
					array5[j, i] = num5 - num6;
					heightMap[j, i] = num4 + num6;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num7 = heightMap[j, i];
					Vector3 interpolatedNormal = terrainData.GetInterpolatedNormal((float)j / (float)num, (float)i / (float)num2);
					float num8 = (Vector3.Angle(interpolatedNormal, to) - 90f) / 90f;
					if (num8 < 0f)
					{
						num8 = 0f;
					}
					array[j, i] = num8 * num7;
					float num9 = 1f - Mathf.Abs(Vector3.Angle(interpolatedNormal, to) - 90f) / 90f;
					array2[j, i] = num9 * num7;
					float num10 = num9 * num7 * this.windForce;
					float num11 = array3[j, i];
					float num12 = num11 + num10;
					array3[j, i] = num12;
					float num13 = array5[j, i];
					float num14 = this.windLift * num12;
					if (num13 + num14 > this.windCapacity)
					{
						num14 = this.windCapacity - num13;
					}
					array5[j, i] = num13 + num14;
					heightMap[j, i] = num7 - num14;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				int num15;
				int num16;
				int num17;
				if (i == 0)
				{
					num15 = 2;
					num16 = 0;
					num17 = 0;
				}
				else if (i == num2 - 1)
				{
					num15 = 2;
					num16 = -1;
					num17 = 1;
				}
				else
				{
					num15 = 3;
					num16 = -1;
					num17 = 1;
				}
				for (int j = 0; j < num; j++)
				{
					int num18;
					int num19;
					int num20;
					if (j == 0)
					{
						num18 = 2;
						num19 = 0;
						num20 = 0;
					}
					else if (j == num - 1)
					{
						num18 = 2;
						num19 = -1;
						num20 = 1;
					}
					else
					{
						num18 = 3;
						num19 = -1;
						num20 = 1;
					}
					float num21 = array2[j, i];
					float num22 = array[j, i];
					float num13 = array5[j, i];
					for (int l = 0; l < num15; l++)
					{
						for (int m = 0; m < num18; m++)
						{
							if ((m != num20 || l != num17) && (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num20 || l == num17))))
							{
								Vector3 from = new Vector3((float)(m + num19), 0f, (float)(-1 * (l + num16)));
								float num23 = (90f - Vector3.Angle(from, to)) / 90f;
								if (num23 < 0f)
								{
									num23 = 0f;
								}
								float num24 = array4[j + m + num19, i + l + num16];
								float num25 = num23 * (num21 - num22) * 0.1f;
								if (num25 < 0f)
								{
									num25 = 0f;
								}
								float num26 = num24 + num25;
								array4[j + m + num19, i + l + num16] = num26;
								float num27 = array4[j, i];
								float num28 = num27 - num25;
								array4[j, i] = num28;
								float num29 = array6[j + m + num19, i + l + num16];
								float num30 = num13 * num25;
								float num31 = num29 + num30;
								array6[j + m + num19, i + l + num16] = num31;
								float num32 = array6[j, i];
								float num33 = num32 - num30;
								array6[j, i] = num33;
							}
						}
					}
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num34 = array5[j, i] + array6[j, i];
					if (num34 > 1f)
					{
						num34 = 1f;
					}
					else if (num34 < 0f)
					{
						num34 = 0f;
					}
					array5[j, i] = num34;
					array6[j, i] = 0f;
				}
			}
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num3 = array3[j, i] + array4[j, i];
					num3 *= 1f - this.windEntropy;
					if (num3 > 1f)
					{
						num3 = 1f;
					}
					else if (num3 < 0f)
					{
						num3 = 0f;
					}
					array3[j, i] = num3;
					array4[j, i] = 0f;
				}
			}
			this.smoothIterations = 1;
			this.smoothBlend = 0.25f;
			float[,] array8 = (float[,])heightMap.Clone();
			TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
			array8 = this.smooth(array8, arraySize, generatorProgressDelegate);
			for (int i = 0; i < num2; i++)
			{
				for (int j = 0; j < num; j++)
				{
					float num35 = heightMap[j, i];
					float num36 = array8[j, i];
					float num37 = array[j, i] * this.windSmoothing;
					float num38 = num36 * num37 + num35 * (1f - num37);
					heightMap[j, i] = num38;
				}
			}
			float percentComplete = (float)k / (float)iterations;
			erosionProgressDelegate("Applying Wind Erosion", "Applying wind erosion.", k, iterations, percentComplete);
		}
		return heightMap;
	}

	// Token: 0x06000887 RID: 2183 RVA: 0x0003D24C File Offset: 0x0003B44C
	public void textureTerrain(TerrainToolkit.TextureProgressDelegate textureProgressDelegate)
	{
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		if (terrain == null)
		{
			return;
		}
		TerrainData terrainData = terrain.terrainData;
		this.splatPrototypes = terrainData.splatPrototypes;
		int num = this.splatPrototypes.Length;
		if (num < 2)
		{
			Debug.LogError("Error: You must assign at least 2 textures.");
			return;
		}
		textureProgressDelegate("Procedural Terrain Texture", "Generating height and slope maps. Please wait.", 0.1f);
		int num2 = terrainData.heightmapWidth - 1;
		int num3 = terrainData.heightmapHeight - 1;
		float[,] array = new float[num2, num3];
		float[,] array2 = new float[num2, num3];
		terrainData.alphamapResolution = num2;
		float[,,] alphamaps = terrainData.GetAlphamaps(0, 0, num2, num2);
		Vector3 size = terrainData.size;
		float num4 = size.x / (float)num2 * Mathf.Tan(this.slopeBlendMinAngle * 0.017453292f) / size.y;
		float num5 = size.x / (float)num2 * Mathf.Tan(this.slopeBlendMaxAngle * 0.017453292f) / size.y;
		try
		{
			float num6 = 0f;
			float[,] heights = terrainData.GetHeights(0, 0, num2, num3);
			for (int i = 0; i < num3; i++)
			{
				int num7;
				int num8;
				int num9;
				if (i == 0)
				{
					num7 = 2;
					num8 = 0;
					num9 = 0;
				}
				else if (i == num3 - 1)
				{
					num7 = 2;
					num8 = -1;
					num9 = 1;
				}
				else
				{
					num7 = 3;
					num8 = -1;
					num9 = 1;
				}
				for (int j = 0; j < num2; j++)
				{
					int num10;
					int num11;
					int num12;
					if (j == 0)
					{
						num10 = 2;
						num11 = 0;
						num12 = 0;
					}
					else if (j == num2 - 1)
					{
						num10 = 2;
						num11 = -1;
						num12 = 1;
					}
					else
					{
						num10 = 3;
						num11 = -1;
						num12 = 1;
					}
					float num13 = heights[j + num12 + num11, i + num9 + num8];
					if (num13 > num6)
					{
						num6 = num13;
					}
					array[j, i] = num13;
					float num14 = 0f;
					float num15 = (float)(num10 * num7 - 1);
					for (int k = 0; k < num7; k++)
					{
						for (int l = 0; l < num10; l++)
						{
							if (l != num12 || k != num9)
							{
								float num16 = Mathf.Abs(num13 - heights[j + l + num11, i + k + num8]);
								num14 += num16;
							}
						}
					}
					float num17 = num14 / num15;
					array2[j, i] = num17;
				}
			}
			for (int m = 0; m < num3; m++)
			{
				for (int n = 0; n < num2; n++)
				{
					float num18 = array2[n, m];
					if (num18 < num4)
					{
						num18 = 0f;
					}
					else if (num18 < num5)
					{
						num18 = (num18 - num4) / (num5 - num4);
					}
					else if (num18 > num5)
					{
						num18 = 1f;
					}
					array2[n, m] = num18;
					alphamaps[n, m, 0] = num18;
				}
			}
			for (int num19 = 1; num19 < num; num19++)
			{
				for (int m = 0; m < num3; m++)
				{
					for (int n = 0; n < num2; n++)
					{
						float num20 = 0f;
						float num21 = 0f;
						float num22 = 1f;
						float num23 = 1f;
						float num24 = 0f;
						if (num19 > 1)
						{
							num20 = this.heightBlendPoints[num19 * 2 - 4];
							num21 = this.heightBlendPoints[num19 * 2 - 3];
						}
						if (num19 < num - 1)
						{
							num22 = this.heightBlendPoints[num19 * 2 - 2];
							num23 = this.heightBlendPoints[num19 * 2 - 1];
						}
						float num25 = array[n, m];
						if (num25 >= num21 && num25 <= num22)
						{
							num24 = 1f;
						}
						else if (num25 >= num20 && num25 < num21)
						{
							num24 = (num25 - num20) / (num21 - num20);
						}
						else if (num25 > num22 && num25 <= num23)
						{
							num24 = 1f - (num25 - num22) / (num23 - num22);
						}
						float num26 = array2[n, m];
						num24 -= num26;
						if (num24 < 0f)
						{
							num24 = 0f;
						}
						alphamaps[n, m, num19] = num24;
					}
				}
			}
			textureProgressDelegate("Procedural Terrain Texture", "Generating splat map. Please wait.", 0.9f);
			terrainData.SetAlphamaps(0, 0, alphamaps);
		}
		catch (Exception arg)
		{
			Debug.LogError("An error occurred: " + arg);
		}
	}

	// Token: 0x06000888 RID: 2184 RVA: 0x0003D72C File Offset: 0x0003B92C
	public void addSplatPrototype(Texture2D tex, int index)
	{
		SplatPrototype[] array = new SplatPrototype[index + 1];
		for (int i = 0; i <= index; i++)
		{
			array[i] = new SplatPrototype();
			if (i == index)
			{
				array[i].texture = tex;
				array[i].tileSize = new Vector2(15f, 15f);
			}
			else
			{
				array[i].texture = this.splatPrototypes[i].texture;
				array[i].tileSize = this.splatPrototypes[i].tileSize;
			}
		}
		this.splatPrototypes = array;
		if (index + 1 > 2)
		{
			this.addBlendPoints();
		}
	}

	// Token: 0x06000889 RID: 2185 RVA: 0x0003D7C8 File Offset: 0x0003B9C8
	public void deleteSplatPrototype(Texture2D tex, int index)
	{
		int num = this.splatPrototypes.Length;
		SplatPrototype[] array = new SplatPrototype[num - 1];
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			if (i != index)
			{
				array[num2] = new SplatPrototype();
				array[num2].texture = this.splatPrototypes[i].texture;
				array[num2].tileSize = this.splatPrototypes[i].tileSize;
				num2++;
			}
		}
		this.splatPrototypes = array;
		if (num - 1 > 1)
		{
			this.deleteBlendPoints();
		}
	}

	// Token: 0x0600088A RID: 2186 RVA: 0x0003D850 File Offset: 0x0003BA50
	public void deleteAllSplatPrototypes()
	{
		SplatPrototype[] array = new SplatPrototype[0];
		this.splatPrototypes = array;
	}

	// Token: 0x0600088B RID: 2187 RVA: 0x0003D86C File Offset: 0x0003BA6C
	public void addBlendPoints()
	{
		float num = 0f;
		if (this.heightBlendPoints.Count > 0)
		{
			num = this.heightBlendPoints[this.heightBlendPoints.Count - 1];
		}
		float item = num + (1f - num) * 0.33f;
		this.heightBlendPoints.Add(item);
		item = num + (1f - num) * 0.66f;
		this.heightBlendPoints.Add(item);
	}

	// Token: 0x0600088C RID: 2188 RVA: 0x0003D8E4 File Offset: 0x0003BAE4
	public void deleteBlendPoints()
	{
		if (this.heightBlendPoints.Count > 0)
		{
			this.heightBlendPoints.RemoveAt(this.heightBlendPoints.Count - 1);
		}
		if (this.heightBlendPoints.Count > 0)
		{
			this.heightBlendPoints.RemoveAt(this.heightBlendPoints.Count - 1);
		}
	}

	// Token: 0x0600088D RID: 2189 RVA: 0x0003D944 File Offset: 0x0003BB44
	public void deleteAllBlendPoints()
	{
		this.heightBlendPoints = new List<float>();
	}

	// Token: 0x0600088E RID: 2190 RVA: 0x0003D954 File Offset: 0x0003BB54
	public void generateTerrain(TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		this.convertIntVarsToEnums();
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		if (terrain == null)
		{
			return;
		}
		TerrainData terrainData = terrain.terrainData;
		int heightmapWidth = terrainData.heightmapWidth;
		int heightmapHeight = terrainData.heightmapHeight;
		float[,] heights = terrainData.GetHeights(0, 0, heightmapWidth, heightmapHeight);
		float[,] array = (float[,])heights.Clone();
		switch (this.generatorType)
		{
		case TerrainToolkit.GeneratorType.Voronoi:
			array = this.generateVoronoi(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), generatorProgressDelegate);
			break;
		case TerrainToolkit.GeneratorType.DiamondSquare:
			array = this.generateDiamondSquare(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), generatorProgressDelegate);
			break;
		case TerrainToolkit.GeneratorType.Perlin:
			array = this.generatePerlin(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), generatorProgressDelegate);
			break;
		case TerrainToolkit.GeneratorType.Smooth:
			array = this.smooth(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), generatorProgressDelegate);
			break;
		case TerrainToolkit.GeneratorType.Normalise:
			array = this.normalise(array, new Vector2((float)heightmapWidth, (float)heightmapHeight), generatorProgressDelegate);
			break;
		default:
			return;
		}
		for (int i = 0; i < heightmapHeight; i++)
		{
			for (int j = 0; j < heightmapWidth; j++)
			{
				float num = heights[j, i];
				float num2 = array[j, i];
				float num3 = 0f;
				switch (this.generatorType)
				{
				case TerrainToolkit.GeneratorType.Voronoi:
					num3 = num2 * this.voronoiBlend + num * (1f - this.voronoiBlend);
					break;
				case TerrainToolkit.GeneratorType.DiamondSquare:
					num3 = num2 * this.diamondSquareBlend + num * (1f - this.diamondSquareBlend);
					break;
				case TerrainToolkit.GeneratorType.Perlin:
					num3 = num2 * this.perlinBlend + num * (1f - this.perlinBlend);
					break;
				case TerrainToolkit.GeneratorType.Smooth:
					num3 = num2 * this.smoothBlend + num * (1f - this.smoothBlend);
					break;
				case TerrainToolkit.GeneratorType.Normalise:
					num3 = num2 * this.normaliseBlend + num * (1f - this.normaliseBlend);
					break;
				}
				heights[j, i] = num3;
			}
		}
		terrainData.SetHeights(0, 0, heights);
	}

	// Token: 0x0600088F RID: 2191 RVA: 0x0003DB8C File Offset: 0x0003BD8C
	private float[,] generateVoronoi(float[,] heightMap, Vector2 arraySize, TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		ArrayList arrayList = new ArrayList();
		for (int i = 0; i < this.voronoiCells; i++)
		{
			TerrainToolkit.Peak peak = default(TerrainToolkit.Peak);
			int num3 = (int)Mathf.Floor(UnityEngine.Random.value * (float)num);
			int num4 = (int)Mathf.Floor(UnityEngine.Random.value * (float)num2);
			float peakHeight = UnityEngine.Random.value;
			if (UnityEngine.Random.value > this.voronoiFeatures)
			{
				peakHeight = 0f;
			}
			peak.peakPoint = new Vector2((float)num3, (float)num4);
			peak.peakHeight = peakHeight;
			arrayList.Add(peak);
		}
		float num5 = 0f;
		for (int j = 0; j < num2; j++)
		{
			for (int k = 0; k < num; k++)
			{
				ArrayList arrayList2 = new ArrayList();
				for (int i = 0; i < this.voronoiCells; i++)
				{
					Vector2 peakPoint = ((TerrainToolkit.Peak)arrayList[i]).peakPoint;
					float dist = Vector2.Distance(peakPoint, new Vector2((float)k, (float)j));
					arrayList2.Add(new TerrainToolkit.PeakDistance
					{
						id = i,
						dist = dist
					});
				}
				arrayList2.Sort();
				TerrainToolkit.PeakDistance peakDistance = (TerrainToolkit.PeakDistance)arrayList2[0];
				TerrainToolkit.PeakDistance peakDistance2 = (TerrainToolkit.PeakDistance)arrayList2[1];
				int id = peakDistance.id;
				float dist2 = peakDistance.dist;
				float dist3 = peakDistance2.dist;
				float num6 = Mathf.Abs(dist2 - dist3) / ((float)(num + num2) / Mathf.Sqrt((float)this.voronoiCells));
				float num7 = ((TerrainToolkit.Peak)arrayList[id]).peakHeight;
				float num8 = num7 - Mathf.Abs(dist2 / dist3) * num7;
				switch (this.voronoiType)
				{
				case TerrainToolkit.VoronoiType.Sine:
				{
					float f = num8 * 3.1415927f - 1.5707964f;
					num8 = 0.5f + Mathf.Sin(f) / 2f;
					break;
				}
				case TerrainToolkit.VoronoiType.Tangent:
				{
					float f = num8 * 3.1415927f / 2f;
					num8 = 0.5f + Mathf.Tan(f) / 2f;
					break;
				}
				}
				num8 = num8 * num6 * this.voronoiScale + num8 * (1f - this.voronoiScale);
				if (num8 < 0f)
				{
					num8 = 0f;
				}
				else if (num8 > 1f)
				{
					num8 = 1f;
				}
				heightMap[k, j] = num8;
				if (num8 > num5)
				{
					num5 = num8;
				}
			}
			float num9 = (float)(j * num2);
			float num10 = (float)(num * num2);
			float percentComplete = num9 / num10;
			generatorProgressDelegate("Voronoi Generator", "Generating height map. Please wait.", percentComplete);
		}
		for (int j = 0; j < num2; j++)
		{
			for (int k = 0; k < num; k++)
			{
				float num11 = heightMap[k, j] * (1f / num5);
				heightMap[k, j] = num11;
			}
		}
		return heightMap;
	}

	// Token: 0x06000890 RID: 2192 RVA: 0x0003DEB0 File Offset: 0x0003C0B0
	private float[,] generateDiamondSquare(float[,] heightMap, Vector2 arraySize, TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float num3 = 1f;
		int i = num - 1;
		heightMap[0, 0] = 0.5f;
		heightMap[num - 1, 0] = 0.5f;
		heightMap[0, num2 - 1] = 0.5f;
		heightMap[num - 1, num2 - 1] = 0.5f;
		generatorProgressDelegate("Fractal Generator", "Generating height map. Please wait.", 0f);
		while (i > 1)
		{
			for (int j = 0; j < num - 1; j += i)
			{
				for (int k = 0; k < num2 - 1; k += i)
				{
					int tx = j + (i >> 1);
					int ty = k + (i >> 1);
					Vector2[] points = new Vector2[]
					{
						new Vector2((float)j, (float)k),
						new Vector2((float)(j + i), (float)k),
						new Vector2((float)j, (float)(k + i)),
						new Vector2((float)(j + i), (float)(k + i))
					};
					this.dsCalculateHeight(heightMap, arraySize, tx, ty, points, num3);
				}
			}
			for (int l = 0; l < num - 1; l += i)
			{
				for (int m = 0; m < num2 - 1; m += i)
				{
					int num4 = i >> 1;
					int num5 = l + num4;
					int num6 = m;
					int num7 = l;
					int num8 = m + num4;
					Vector2[] points2 = new Vector2[]
					{
						new Vector2((float)(num5 - num4), (float)num6),
						new Vector2((float)num5, (float)(num6 - num4)),
						new Vector2((float)(num5 + num4), (float)num6),
						new Vector2((float)num5, (float)(num6 + num4))
					};
					Vector2[] points3 = new Vector2[]
					{
						new Vector2((float)(num7 - num4), (float)num8),
						new Vector2((float)num7, (float)(num8 - num4)),
						new Vector2((float)(num7 + num4), (float)num8),
						new Vector2((float)num7, (float)(num8 + num4))
					};
					this.dsCalculateHeight(heightMap, arraySize, num5, num6, points2, num3);
					this.dsCalculateHeight(heightMap, arraySize, num7, num8, points3, num3);
				}
			}
			num3 *= this.diamondSquareDelta;
			i >>= 1;
		}
		generatorProgressDelegate("Fractal Generator", "Generating height map. Please wait.", 1f);
		return heightMap;
	}

	// Token: 0x06000891 RID: 2193 RVA: 0x0003E16C File Offset: 0x0003C36C
	private void dsCalculateHeight(float[,] heightMap, Vector2 arraySize, int Tx, int Ty, Vector2[] points, float heightRange)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float num3 = 0f;
		for (int i = 0; i < 4; i++)
		{
			if (points[i].x < 0f)
			{
				int num4 = i;
				points[num4].x = points[num4].x + (float)(num - 1);
			}
			else if (points[i].x > (float)num)
			{
				int num5 = i;
				points[num5].x = points[num5].x - (float)(num - 1);
			}
			else if (points[i].y < 0f)
			{
				int num6 = i;
				points[num6].y = points[num6].y + (float)(num2 - 1);
			}
			else if (points[i].y > (float)num2)
			{
				int num7 = i;
				points[num7].y = points[num7].y - (float)(num2 - 1);
			}
			num3 += heightMap[(int)points[i].x, (int)points[i].y] / 4f;
		}
		num3 += UnityEngine.Random.value * heightRange - heightRange / 2f;
		if (num3 < 0f)
		{
			num3 = 0f;
		}
		else if (num3 > 1f)
		{
			num3 = 1f;
		}
		heightMap[Tx, Ty] = num3;
		if (Tx == 0)
		{
			heightMap[num - 1, Ty] = num3;
		}
		else if (Tx == num - 1)
		{
			heightMap[0, Ty] = num3;
		}
		else if (Ty == 0)
		{
			heightMap[Tx, num2 - 1] = num3;
		}
		else if (Ty == num2 - 1)
		{
			heightMap[Tx, 0] = num3;
		}
	}

	// Token: 0x06000892 RID: 2194 RVA: 0x0003E334 File Offset: 0x0003C534
	private float[,] generatePerlin(float[,] heightMap, Vector2 arraySize, TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				heightMap[j, i] = 0f;
			}
		}
		TerrainToolkit.PerlinNoise2D[] array = new TerrainToolkit.PerlinNoise2D[this.perlinOctaves];
		int num3 = this.perlinFrequency;
		float num4 = 1f;
		for (int k = 0; k < this.perlinOctaves; k++)
		{
			array[k] = new TerrainToolkit.PerlinNoise2D(num3, num4);
			num3 *= 2;
			num4 /= 2f;
		}
		for (int k = 0; k < this.perlinOctaves; k++)
		{
			double num5 = (double)((float)num / (float)array[k].Frequency);
			double num6 = (double)((float)num2 / (float)array[k].Frequency);
			for (int l = 0; l < num; l++)
			{
				for (int m = 0; m < num2; m++)
				{
					int num7 = (int)((double)l / num5);
					int xb = num7 + 1;
					int num8 = (int)((double)m / num6);
					int yb = num8 + 1;
					double interpolatedPoint = array[k].getInterpolatedPoint(num7, xb, num8, yb, (double)l / num5 - (double)num7, (double)m / num6 - (double)num8);
					heightMap[l, m] += (float)(interpolatedPoint * (double)array[k].Amplitude);
				}
			}
			float percentComplete = (float)((k + 1) / this.perlinOctaves);
			generatorProgressDelegate("Perlin Generator", "Generating height map. Please wait.", percentComplete);
		}
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate2 = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		float num9 = this.normaliseMin;
		float num10 = this.normaliseMax;
		float num11 = this.normaliseBlend;
		this.normaliseMin = 0f;
		this.normaliseMax = 1f;
		this.normaliseBlend = 1f;
		heightMap = this.normalise(heightMap, arraySize, generatorProgressDelegate2);
		this.normaliseMin = num9;
		this.normaliseMax = num10;
		this.normaliseBlend = num11;
		for (int n = 0; n < num; n++)
		{
			for (int num12 = 0; num12 < num2; num12++)
			{
				heightMap[n, num12] *= this.perlinAmplitude;
			}
		}
		for (int k = 0; k < this.perlinOctaves; k++)
		{
			array[k] = null;
		}
		return heightMap;
	}

	// Token: 0x06000893 RID: 2195 RVA: 0x0003E59C File Offset: 0x0003C79C
	private float[,] smooth(float[,] heightMap, Vector2 arraySize, TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		for (int i = 0; i < this.smoothIterations; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				int num3;
				int num4;
				int num5;
				if (j == 0)
				{
					num3 = 2;
					num4 = 0;
					num5 = 0;
				}
				else if (j == num2 - 1)
				{
					num3 = 2;
					num4 = -1;
					num5 = 1;
				}
				else
				{
					num3 = 3;
					num4 = -1;
					num5 = 1;
				}
				for (int k = 0; k < num; k++)
				{
					int num6;
					int num7;
					int num8;
					if (k == 0)
					{
						num6 = 2;
						num7 = 0;
						num8 = 0;
					}
					else if (k == num - 1)
					{
						num6 = 2;
						num7 = -1;
						num8 = 1;
					}
					else
					{
						num6 = 3;
						num7 = -1;
						num8 = 1;
					}
					float num9 = 0f;
					int num10 = 0;
					for (int l = 0; l < num3; l++)
					{
						for (int m = 0; m < num6; m++)
						{
							if (this.neighbourhood == TerrainToolkit.Neighbourhood.Moore || (this.neighbourhood == TerrainToolkit.Neighbourhood.VonNeumann && (m == num8 || l == num5)))
							{
								float num11 = heightMap[k + m + num7, j + l + num4];
								num9 += num11;
								num10++;
							}
						}
					}
					float num12 = num9 / (float)num10;
					heightMap[k + num8 + num7, j + num5 + num4] = num12;
				}
			}
			float percentComplete = (float)((i + 1) / this.smoothIterations);
			generatorProgressDelegate("Smoothing Filter", "Smoothing height map. Please wait.", percentComplete);
		}
		return heightMap;
	}

	// Token: 0x06000894 RID: 2196 RVA: 0x0003E730 File Offset: 0x0003C930
	private float[,] normalise(float[,] heightMap, Vector2 arraySize, TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate)
	{
		int num = (int)arraySize.x;
		int num2 = (int)arraySize.y;
		float num3 = 0f;
		float num4 = 1f;
		generatorProgressDelegate("Normalise Filter", "Normalising height map. Please wait.", 0f);
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				float num5 = heightMap[j, i];
				if (num5 < num4)
				{
					num4 = num5;
				}
				else if (num5 > num3)
				{
					num3 = num5;
				}
			}
		}
		generatorProgressDelegate("Normalise Filter", "Normalising height map. Please wait.", 0.5f);
		float num6 = num3 - num4;
		float num7 = this.normaliseMax - this.normaliseMin;
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				float num8 = (heightMap[j, i] - num4) / num6 * num7;
				heightMap[j, i] = this.normaliseMin + num8;
			}
		}
		generatorProgressDelegate("Normalise Filter", "Normalising height map. Please wait.", 1f);
		return heightMap;
	}

	// Token: 0x06000895 RID: 2197 RVA: 0x0003E848 File Offset: 0x0003CA48
	public void FastThermalErosion(int iterations, float minSlope, float blendAmount)
	{
		this.erosionTypeInt = 0;
		this.erosionType = TerrainToolkit.ErosionType.Thermal;
		this.thermalIterations = iterations;
		this.thermalMinSlope = minSlope;
		this.thermalFalloff = blendAmount;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x06000896 RID: 2198 RVA: 0x0003E894 File Offset: 0x0003CA94
	public void FastHydraulicErosion(int iterations, float maxSlope, float blendAmount)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 0;
		this.hydraulicType = TerrainToolkit.HydraulicType.Fast;
		this.hydraulicIterations = iterations;
		this.hydraulicMaxSlope = maxSlope;
		this.hydraulicFalloff = blendAmount;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x06000897 RID: 2199 RVA: 0x0003E8F0 File Offset: 0x0003CAF0
	public void FullHydraulicErosion(int iterations, float rainfall, float evaporation, float solubility, float saturation)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 1;
		this.hydraulicType = TerrainToolkit.HydraulicType.Full;
		this.hydraulicIterations = iterations;
		this.hydraulicRainfall = rainfall;
		this.hydraulicEvaporation = evaporation;
		this.hydraulicSedimentSolubility = solubility;
		this.hydraulicSedimentSaturation = saturation;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x06000898 RID: 2200 RVA: 0x0003E95C File Offset: 0x0003CB5C
	public void VelocityHydraulicErosion(int iterations, float rainfall, float evaporation, float solubility, float saturation, float velocity, float momentum, float entropy, float downcutting)
	{
		this.erosionTypeInt = 1;
		this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
		this.hydraulicTypeInt = 2;
		this.hydraulicType = TerrainToolkit.HydraulicType.Velocity;
		this.hydraulicIterations = iterations;
		this.hydraulicVelocityRainfall = rainfall;
		this.hydraulicVelocityEvaporation = evaporation;
		this.hydraulicVelocitySedimentSolubility = solubility;
		this.hydraulicVelocitySedimentSaturation = saturation;
		this.hydraulicVelocity = velocity;
		this.hydraulicMomentum = momentum;
		this.hydraulicEntropy = entropy;
		this.hydraulicDowncutting = downcutting;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x06000899 RID: 2201 RVA: 0x0003E9E8 File Offset: 0x0003CBE8
	public void TidalErosion(int iterations, float seaLevel, float tidalRange, float cliffLimit)
	{
		this.erosionTypeInt = 2;
		this.erosionType = TerrainToolkit.ErosionType.Tidal;
		this.tidalIterations = iterations;
		this.tidalSeaLevel = seaLevel;
		this.tidalRangeAmount = tidalRange;
		this.tidalCliffLimit = cliffLimit;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x0600089A RID: 2202 RVA: 0x0003EA3C File Offset: 0x0003CC3C
	public void WindErosion(int iterations, float direction, float force, float lift, float gravity, float capacity, float entropy, float smoothing)
	{
		this.erosionTypeInt = 3;
		this.erosionType = TerrainToolkit.ErosionType.Wind;
		this.windIterations = iterations;
		this.windDirection = direction;
		this.windForce = force;
		this.windLift = lift;
		this.windGravity = gravity;
		this.windCapacity = capacity;
		this.windEntropy = entropy;
		this.windSmoothing = smoothing;
		this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		TerrainToolkit.ErosionProgressDelegate erosionProgressDelegate = new TerrainToolkit.ErosionProgressDelegate(this.dummyErosionProgress);
		this.erodeAllTerrain(erosionProgressDelegate);
	}

	// Token: 0x0600089B RID: 2203 RVA: 0x0003EAB0 File Offset: 0x0003CCB0
	public void TextureTerrain(float[] slopeStops, float[] heightStops, Texture2D[] textures)
	{
		if (slopeStops.Length != 2)
		{
			Debug.LogError("Error: slopeStops must have 2 values");
			return;
		}
		if (heightStops.Length > 8)
		{
			Debug.LogError("Error: heightStops must have no more than 8 values");
			return;
		}
		if (heightStops.Length % 2 != 0)
		{
			Debug.LogError("Error: heightStops must have an even number of values");
			return;
		}
		int num = textures.Length;
		int num2 = heightStops.Length / 2 + 2;
		if (num != num2)
		{
			Debug.LogError("Error: heightStops contains an incorrect number of values");
			return;
		}
		foreach (float num3 in slopeStops)
		{
			if (num3 < 0f || num3 > 90f)
			{
				Debug.LogError("Error: The value of all slopeStops must be in the range 0.0 to 90.0");
				return;
			}
		}
		foreach (float num4 in heightStops)
		{
			if (num4 < 0f || num4 > 1f)
			{
				Debug.LogError("Error: The value of all heightStops must be in the range 0.0 to 1.0");
				return;
			}
		}
		Terrain terrain = (Terrain)base.GetComponent(typeof(Terrain));
		TerrainData terrainData = terrain.terrainData;
		this.splatPrototypes = terrainData.splatPrototypes;
		this.deleteAllSplatPrototypes();
		int num5 = 0;
		foreach (Texture2D tex in textures)
		{
			this.addSplatPrototype(tex, num5);
			num5++;
		}
		this.slopeBlendMinAngle = slopeStops[0];
		this.slopeBlendMaxAngle = slopeStops[1];
		num5 = 0;
		foreach (float value in heightStops)
		{
			this.heightBlendPoints[num5] = value;
			num5++;
		}
		terrainData.splatPrototypes = this.splatPrototypes;
		TerrainToolkit.TextureProgressDelegate textureProgressDelegate = new TerrainToolkit.TextureProgressDelegate(this.dummyTextureProgress);
		this.textureTerrain(textureProgressDelegate);
	}

	// Token: 0x0600089C RID: 2204 RVA: 0x0003EC7C File Offset: 0x0003CE7C
	public void VoronoiGenerator(TerrainToolkit.FeatureType featureType, int cells, float features, float scale, float blend)
	{
		this.generatorTypeInt = 0;
		this.generatorType = TerrainToolkit.GeneratorType.Voronoi;
		switch (featureType)
		{
		case TerrainToolkit.FeatureType.Mountains:
			this.voronoiTypeInt = 0;
			this.voronoiType = TerrainToolkit.VoronoiType.Linear;
			break;
		case TerrainToolkit.FeatureType.Hills:
			this.voronoiTypeInt = 1;
			this.voronoiType = TerrainToolkit.VoronoiType.Sine;
			break;
		case TerrainToolkit.FeatureType.Plateaus:
			this.voronoiTypeInt = 2;
			this.voronoiType = TerrainToolkit.VoronoiType.Tangent;
			break;
		}
		this.voronoiCells = cells;
		this.voronoiFeatures = features;
		this.voronoiScale = scale;
		this.voronoiBlend = blend;
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		this.generateTerrain(generatorProgressDelegate);
	}

	// Token: 0x0600089D RID: 2205 RVA: 0x0003ED1C File Offset: 0x0003CF1C
	public void FractalGenerator(float fractalDelta, float blend)
	{
		this.generatorTypeInt = 1;
		this.generatorType = TerrainToolkit.GeneratorType.DiamondSquare;
		this.diamondSquareDelta = fractalDelta;
		this.diamondSquareBlend = blend;
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		this.generateTerrain(generatorProgressDelegate);
	}

	// Token: 0x0600089E RID: 2206 RVA: 0x0003ED5C File Offset: 0x0003CF5C
	public void PerlinGenerator(int frequency, float amplitude, int octaves, float blend)
	{
		this.generatorTypeInt = 2;
		this.generatorType = TerrainToolkit.GeneratorType.Perlin;
		this.perlinFrequency = frequency;
		this.perlinAmplitude = amplitude;
		this.perlinOctaves = octaves;
		this.perlinBlend = blend;
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		this.generateTerrain(generatorProgressDelegate);
	}

	// Token: 0x0600089F RID: 2207 RVA: 0x0003EDA8 File Offset: 0x0003CFA8
	public void SmoothTerrain(int iterations, float blend)
	{
		this.generatorTypeInt = 3;
		this.generatorType = TerrainToolkit.GeneratorType.Smooth;
		this.smoothIterations = iterations;
		this.smoothBlend = blend;
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		this.generateTerrain(generatorProgressDelegate);
	}

	// Token: 0x060008A0 RID: 2208 RVA: 0x0003EDE8 File Offset: 0x0003CFE8
	public void NormaliseTerrain(float minHeight, float maxHeight, float blend)
	{
		this.generatorTypeInt = 4;
		this.generatorType = TerrainToolkit.GeneratorType.Normalise;
		this.normaliseMin = minHeight;
		this.normaliseMax = maxHeight;
		this.normaliseBlend = blend;
		TerrainToolkit.GeneratorProgressDelegate generatorProgressDelegate = new TerrainToolkit.GeneratorProgressDelegate(this.dummyGeneratorProgress);
		this.generateTerrain(generatorProgressDelegate);
	}

	// Token: 0x060008A1 RID: 2209 RVA: 0x0003EE2C File Offset: 0x0003D02C
	public void NormalizeTerrain(float minHeight, float maxHeight, float blend)
	{
		this.NormaliseTerrain(minHeight, maxHeight, blend);
	}

	// Token: 0x060008A2 RID: 2210 RVA: 0x0003EE38 File Offset: 0x0003D038
	private void convertIntVarsToEnums()
	{
		switch (this.erosionTypeInt)
		{
		case 0:
			this.erosionType = TerrainToolkit.ErosionType.Thermal;
			break;
		case 1:
			this.erosionType = TerrainToolkit.ErosionType.Hydraulic;
			break;
		case 2:
			this.erosionType = TerrainToolkit.ErosionType.Tidal;
			break;
		case 3:
			this.erosionType = TerrainToolkit.ErosionType.Wind;
			break;
		case 4:
			this.erosionType = TerrainToolkit.ErosionType.Glacial;
			break;
		}
		switch (this.hydraulicTypeInt)
		{
		case 0:
			this.hydraulicType = TerrainToolkit.HydraulicType.Fast;
			break;
		case 1:
			this.hydraulicType = TerrainToolkit.HydraulicType.Full;
			break;
		case 2:
			this.hydraulicType = TerrainToolkit.HydraulicType.Velocity;
			break;
		}
		switch (this.generatorTypeInt)
		{
		case 0:
			this.generatorType = TerrainToolkit.GeneratorType.Voronoi;
			break;
		case 1:
			this.generatorType = TerrainToolkit.GeneratorType.DiamondSquare;
			break;
		case 2:
			this.generatorType = TerrainToolkit.GeneratorType.Perlin;
			break;
		case 3:
			this.generatorType = TerrainToolkit.GeneratorType.Smooth;
			break;
		case 4:
			this.generatorType = TerrainToolkit.GeneratorType.Normalise;
			break;
		}
		switch (this.voronoiTypeInt)
		{
		case 0:
			this.voronoiType = TerrainToolkit.VoronoiType.Linear;
			break;
		case 1:
			this.voronoiType = TerrainToolkit.VoronoiType.Sine;
			break;
		case 2:
			this.voronoiType = TerrainToolkit.VoronoiType.Tangent;
			break;
		}
		int num = this.neighbourhoodInt;
		if (num != 0)
		{
			if (num == 1)
			{
				this.neighbourhood = TerrainToolkit.Neighbourhood.VonNeumann;
			}
		}
		else
		{
			this.neighbourhood = TerrainToolkit.Neighbourhood.Moore;
		}
	}

	// Token: 0x060008A3 RID: 2211 RVA: 0x0003EFC0 File Offset: 0x0003D1C0
	public void dummyErosionProgress(string titleString, string displayString, int iteration, int nIterations, float percentComplete)
	{
	}

	// Token: 0x060008A4 RID: 2212 RVA: 0x0003EFC4 File Offset: 0x0003D1C4
	public void dummyTextureProgress(string titleString, string displayString, float percentComplete)
	{
	}

	// Token: 0x060008A5 RID: 2213 RVA: 0x0003EFC8 File Offset: 0x0003D1C8
	public void dummyGeneratorProgress(string titleString, string displayString, float percentComplete)
	{
	}

	// Token: 0x04000752 RID: 1874
	public GUISkin guiSkin;

	// Token: 0x04000753 RID: 1875
	public Texture2D createIcon;

	// Token: 0x04000754 RID: 1876
	public Texture2D erodeIcon;

	// Token: 0x04000755 RID: 1877
	public Texture2D textureIcon;

	// Token: 0x04000756 RID: 1878
	public Texture2D mooreIcon;

	// Token: 0x04000757 RID: 1879
	public Texture2D vonNeumannIcon;

	// Token: 0x04000758 RID: 1880
	public Texture2D mountainsIcon;

	// Token: 0x04000759 RID: 1881
	public Texture2D hillsIcon;

	// Token: 0x0400075A RID: 1882
	public Texture2D plateausIcon;

	// Token: 0x0400075B RID: 1883
	public Texture2D defaultTexture;

	// Token: 0x0400075C RID: 1884
	public int toolModeInt;

	// Token: 0x0400075D RID: 1885
	private TerrainToolkit.ErosionMode erosionMode;

	// Token: 0x0400075E RID: 1886
	private TerrainToolkit.ErosionType erosionType;

	// Token: 0x0400075F RID: 1887
	public int erosionTypeInt;

	// Token: 0x04000760 RID: 1888
	private TerrainToolkit.GeneratorType generatorType;

	// Token: 0x04000761 RID: 1889
	public int generatorTypeInt;

	// Token: 0x04000762 RID: 1890
	public bool isBrushOn;

	// Token: 0x04000763 RID: 1891
	public bool isBrushHidden;

	// Token: 0x04000764 RID: 1892
	public bool isBrushPainting;

	// Token: 0x04000765 RID: 1893
	public Vector3 brushPosition;

	// Token: 0x04000766 RID: 1894
	public float brushSize = 50f;

	// Token: 0x04000767 RID: 1895
	public float brushOpacity = 1f;

	// Token: 0x04000768 RID: 1896
	public float brushSoftness = 0.5f;

	// Token: 0x04000769 RID: 1897
	public int neighbourhoodInt;

	// Token: 0x0400076A RID: 1898
	private TerrainToolkit.Neighbourhood neighbourhood;

	// Token: 0x0400076B RID: 1899
	public bool useDifferenceMaps = true;

	// Token: 0x0400076C RID: 1900
	public int thermalIterations = 25;

	// Token: 0x0400076D RID: 1901
	public float thermalMinSlope = 1f;

	// Token: 0x0400076E RID: 1902
	public float thermalFalloff = 0.5f;

	// Token: 0x0400076F RID: 1903
	public int hydraulicTypeInt;

	// Token: 0x04000770 RID: 1904
	public TerrainToolkit.HydraulicType hydraulicType;

	// Token: 0x04000771 RID: 1905
	public int hydraulicIterations = 25;

	// Token: 0x04000772 RID: 1906
	public float hydraulicMaxSlope = 60f;

	// Token: 0x04000773 RID: 1907
	public float hydraulicFalloff = 0.5f;

	// Token: 0x04000774 RID: 1908
	public float hydraulicRainfall = 0.01f;

	// Token: 0x04000775 RID: 1909
	public float hydraulicEvaporation = 0.5f;

	// Token: 0x04000776 RID: 1910
	public float hydraulicSedimentSolubility = 0.01f;

	// Token: 0x04000777 RID: 1911
	public float hydraulicSedimentSaturation = 0.1f;

	// Token: 0x04000778 RID: 1912
	public float hydraulicVelocityRainfall = 0.01f;

	// Token: 0x04000779 RID: 1913
	public float hydraulicVelocityEvaporation = 0.5f;

	// Token: 0x0400077A RID: 1914
	public float hydraulicVelocitySedimentSolubility = 0.01f;

	// Token: 0x0400077B RID: 1915
	public float hydraulicVelocitySedimentSaturation = 0.1f;

	// Token: 0x0400077C RID: 1916
	public float hydraulicVelocity = 20f;

	// Token: 0x0400077D RID: 1917
	public float hydraulicMomentum = 1f;

	// Token: 0x0400077E RID: 1918
	public float hydraulicEntropy;

	// Token: 0x0400077F RID: 1919
	public float hydraulicDowncutting = 0.1f;

	// Token: 0x04000780 RID: 1920
	public int tidalIterations = 25;

	// Token: 0x04000781 RID: 1921
	public float tidalSeaLevel = 50f;

	// Token: 0x04000782 RID: 1922
	public float tidalRangeAmount = 5f;

	// Token: 0x04000783 RID: 1923
	public float tidalCliffLimit = 60f;

	// Token: 0x04000784 RID: 1924
	public int windIterations = 25;

	// Token: 0x04000785 RID: 1925
	public float windDirection;

	// Token: 0x04000786 RID: 1926
	public float windForce = 0.5f;

	// Token: 0x04000787 RID: 1927
	public float windLift = 0.01f;

	// Token: 0x04000788 RID: 1928
	public float windGravity = 0.5f;

	// Token: 0x04000789 RID: 1929
	public float windCapacity = 0.01f;

	// Token: 0x0400078A RID: 1930
	public float windEntropy = 0.1f;

	// Token: 0x0400078B RID: 1931
	public float windSmoothing = 0.25f;

	// Token: 0x0400078C RID: 1932
	public SplatPrototype[] splatPrototypes;

	// Token: 0x0400078D RID: 1933
	public Texture2D tempTexture;

	// Token: 0x0400078E RID: 1934
	public float slopeBlendMinAngle = 60f;

	// Token: 0x0400078F RID: 1935
	public float slopeBlendMaxAngle = 75f;

	// Token: 0x04000790 RID: 1936
	public List<float> heightBlendPoints;

	// Token: 0x04000791 RID: 1937
	public string[] gradientStyles;

	// Token: 0x04000792 RID: 1938
	public int voronoiTypeInt;

	// Token: 0x04000793 RID: 1939
	public TerrainToolkit.VoronoiType voronoiType;

	// Token: 0x04000794 RID: 1940
	public int voronoiCells = 16;

	// Token: 0x04000795 RID: 1941
	public float voronoiFeatures = 1f;

	// Token: 0x04000796 RID: 1942
	public float voronoiScale = 1f;

	// Token: 0x04000797 RID: 1943
	public float voronoiBlend = 1f;

	// Token: 0x04000798 RID: 1944
	public float diamondSquareDelta = 0.5f;

	// Token: 0x04000799 RID: 1945
	public float diamondSquareBlend = 1f;

	// Token: 0x0400079A RID: 1946
	public int perlinFrequency = 4;

	// Token: 0x0400079B RID: 1947
	public float perlinAmplitude = 1f;

	// Token: 0x0400079C RID: 1948
	public int perlinOctaves = 8;

	// Token: 0x0400079D RID: 1949
	public float perlinBlend = 1f;

	// Token: 0x0400079E RID: 1950
	public float smoothBlend = 1f;

	// Token: 0x0400079F RID: 1951
	public int smoothIterations;

	// Token: 0x040007A0 RID: 1952
	public float normaliseMin;

	// Token: 0x040007A1 RID: 1953
	public float normaliseMax = 1f;

	// Token: 0x040007A2 RID: 1954
	public float normaliseBlend = 1f;

	// Token: 0x040007A3 RID: 1955
	[NonSerialized]
	public bool presetsInitialised;

	// Token: 0x040007A4 RID: 1956
	[NonSerialized]
	public int voronoiPresetId;

	// Token: 0x040007A5 RID: 1957
	[NonSerialized]
	public int fractalPresetId;

	// Token: 0x040007A6 RID: 1958
	[NonSerialized]
	public int perlinPresetId;

	// Token: 0x040007A7 RID: 1959
	[NonSerialized]
	public int thermalErosionPresetId;

	// Token: 0x040007A8 RID: 1960
	[NonSerialized]
	public int fastHydraulicErosionPresetId;

	// Token: 0x040007A9 RID: 1961
	[NonSerialized]
	public int fullHydraulicErosionPresetId;

	// Token: 0x040007AA RID: 1962
	[NonSerialized]
	public int velocityHydraulicErosionPresetId;

	// Token: 0x040007AB RID: 1963
	[NonSerialized]
	public int tidalErosionPresetId;

	// Token: 0x040007AC RID: 1964
	[NonSerialized]
	public int windErosionPresetId;

	// Token: 0x040007AD RID: 1965
	public ArrayList voronoiPresets = new ArrayList();

	// Token: 0x040007AE RID: 1966
	public ArrayList fractalPresets = new ArrayList();

	// Token: 0x040007AF RID: 1967
	public ArrayList perlinPresets = new ArrayList();

	// Token: 0x040007B0 RID: 1968
	public ArrayList thermalErosionPresets = new ArrayList();

	// Token: 0x040007B1 RID: 1969
	public ArrayList fastHydraulicErosionPresets = new ArrayList();

	// Token: 0x040007B2 RID: 1970
	public ArrayList fullHydraulicErosionPresets = new ArrayList();

	// Token: 0x040007B3 RID: 1971
	public ArrayList velocityHydraulicErosionPresets = new ArrayList();

	// Token: 0x040007B4 RID: 1972
	public ArrayList tidalErosionPresets = new ArrayList();

	// Token: 0x040007B5 RID: 1973
	public ArrayList windErosionPresets = new ArrayList();

	// Token: 0x020000CF RID: 207
	public class PeakDistance : IComparable
	{
		// Token: 0x060008A7 RID: 2215 RVA: 0x0003EFD4 File Offset: 0x0003D1D4
		public int CompareTo(object obj)
		{
			TerrainToolkit.PeakDistance peakDistance = (TerrainToolkit.PeakDistance)obj;
			int num = this.dist.CompareTo(peakDistance.dist);
			if (num == 0)
			{
				num = this.dist.CompareTo(peakDistance.dist);
			}
			return num;
		}

		// Token: 0x040007B6 RID: 1974
		public int id;

		// Token: 0x040007B7 RID: 1975
		public float dist;
	}

	// Token: 0x020000D0 RID: 208
	public struct Peak
	{
		// Token: 0x040007B8 RID: 1976
		public Vector2 peakPoint;

		// Token: 0x040007B9 RID: 1977
		public float peakHeight;
	}

	// Token: 0x020000D1 RID: 209
	public class voronoiPresetData
	{
		// Token: 0x060008A8 RID: 2216 RVA: 0x0003F014 File Offset: 0x0003D214
		public voronoiPresetData(string pn, TerrainToolkit.VoronoiType vt, int c, float vf, float vs, float vb)
		{
			this.presetName = pn;
			this.voronoiType = vt;
			this.voronoiCells = c;
			this.voronoiFeatures = vf;
			this.voronoiScale = vs;
			this.voronoiBlend = vb;
		}

		// Token: 0x040007BA RID: 1978
		public string presetName;

		// Token: 0x040007BB RID: 1979
		public TerrainToolkit.VoronoiType voronoiType;

		// Token: 0x040007BC RID: 1980
		public int voronoiCells;

		// Token: 0x040007BD RID: 1981
		public float voronoiFeatures;

		// Token: 0x040007BE RID: 1982
		public float voronoiScale;

		// Token: 0x040007BF RID: 1983
		public float voronoiBlend;
	}

	// Token: 0x020000D2 RID: 210
	public class fractalPresetData
	{
		// Token: 0x060008A9 RID: 2217 RVA: 0x0003F04C File Offset: 0x0003D24C
		public fractalPresetData(string pn, float dsd, float dsb)
		{
			this.presetName = pn;
			this.diamondSquareDelta = dsd;
			this.diamondSquareBlend = dsb;
		}

		// Token: 0x040007C0 RID: 1984
		public string presetName;

		// Token: 0x040007C1 RID: 1985
		public float diamondSquareDelta;

		// Token: 0x040007C2 RID: 1986
		public float diamondSquareBlend;
	}

	// Token: 0x020000D3 RID: 211
	public class perlinPresetData
	{
		// Token: 0x060008AA RID: 2218 RVA: 0x0003F06C File Offset: 0x0003D26C
		public perlinPresetData(string pn, int pf, float pa, int po, float pb)
		{
			this.presetName = pn;
			this.perlinFrequency = pf;
			this.perlinAmplitude = pa;
			this.perlinOctaves = po;
			this.perlinBlend = pb;
		}

		// Token: 0x040007C3 RID: 1987
		public string presetName;

		// Token: 0x040007C4 RID: 1988
		public int perlinFrequency;

		// Token: 0x040007C5 RID: 1989
		public float perlinAmplitude;

		// Token: 0x040007C6 RID: 1990
		public int perlinOctaves;

		// Token: 0x040007C7 RID: 1991
		public float perlinBlend;
	}

	// Token: 0x020000D4 RID: 212
	public class thermalErosionPresetData
	{
		// Token: 0x060008AB RID: 2219 RVA: 0x0003F09C File Offset: 0x0003D29C
		public thermalErosionPresetData(string pn, int ti, float tms, float tba)
		{
			this.presetName = pn;
			this.thermalIterations = ti;
			this.thermalMinSlope = tms;
			this.thermalFalloff = tba;
		}

		// Token: 0x040007C8 RID: 1992
		public string presetName;

		// Token: 0x040007C9 RID: 1993
		public int thermalIterations;

		// Token: 0x040007CA RID: 1994
		public float thermalMinSlope;

		// Token: 0x040007CB RID: 1995
		public float thermalFalloff;
	}

	// Token: 0x020000D5 RID: 213
	public class fastHydraulicErosionPresetData
	{
		// Token: 0x060008AC RID: 2220 RVA: 0x0003F0C4 File Offset: 0x0003D2C4
		public fastHydraulicErosionPresetData(string pn, int hi, float hms, float hba)
		{
			this.presetName = pn;
			this.hydraulicIterations = hi;
			this.hydraulicMaxSlope = hms;
			this.hydraulicFalloff = hba;
		}

		// Token: 0x040007CC RID: 1996
		public string presetName;

		// Token: 0x040007CD RID: 1997
		public int hydraulicIterations;

		// Token: 0x040007CE RID: 1998
		public float hydraulicMaxSlope;

		// Token: 0x040007CF RID: 1999
		public float hydraulicFalloff;
	}

	// Token: 0x020000D6 RID: 214
	public class fullHydraulicErosionPresetData
	{
		// Token: 0x060008AD RID: 2221 RVA: 0x0003F0EC File Offset: 0x0003D2EC
		public fullHydraulicErosionPresetData(string pn, int hi, float hr, float he, float hso, float hsa)
		{
			this.presetName = pn;
			this.hydraulicIterations = hi;
			this.hydraulicRainfall = hr;
			this.hydraulicEvaporation = he;
			this.hydraulicSedimentSolubility = hso;
			this.hydraulicSedimentSaturation = hsa;
		}

		// Token: 0x040007D0 RID: 2000
		public string presetName;

		// Token: 0x040007D1 RID: 2001
		public int hydraulicIterations;

		// Token: 0x040007D2 RID: 2002
		public float hydraulicRainfall;

		// Token: 0x040007D3 RID: 2003
		public float hydraulicEvaporation;

		// Token: 0x040007D4 RID: 2004
		public float hydraulicSedimentSolubility;

		// Token: 0x040007D5 RID: 2005
		public float hydraulicSedimentSaturation;
	}

	// Token: 0x020000D7 RID: 215
	public class velocityHydraulicErosionPresetData
	{
		// Token: 0x060008AE RID: 2222 RVA: 0x0003F124 File Offset: 0x0003D324
		public velocityHydraulicErosionPresetData(string pn, int hi, float hvr, float hve, float hso, float hsa, float hv, float hm, float he, float hd)
		{
			this.presetName = pn;
			this.hydraulicIterations = hi;
			this.hydraulicVelocityRainfall = hvr;
			this.hydraulicVelocityEvaporation = hve;
			this.hydraulicVelocitySedimentSolubility = hso;
			this.hydraulicVelocitySedimentSaturation = hsa;
			this.hydraulicVelocity = hv;
			this.hydraulicMomentum = hm;
			this.hydraulicEntropy = he;
			this.hydraulicDowncutting = hd;
		}

		// Token: 0x040007D6 RID: 2006
		public string presetName;

		// Token: 0x040007D7 RID: 2007
		public int hydraulicIterations;

		// Token: 0x040007D8 RID: 2008
		public float hydraulicVelocityRainfall;

		// Token: 0x040007D9 RID: 2009
		public float hydraulicVelocityEvaporation;

		// Token: 0x040007DA RID: 2010
		public float hydraulicVelocitySedimentSolubility;

		// Token: 0x040007DB RID: 2011
		public float hydraulicVelocitySedimentSaturation;

		// Token: 0x040007DC RID: 2012
		public float hydraulicVelocity;

		// Token: 0x040007DD RID: 2013
		public float hydraulicMomentum;

		// Token: 0x040007DE RID: 2014
		public float hydraulicEntropy;

		// Token: 0x040007DF RID: 2015
		public float hydraulicDowncutting;
	}

	// Token: 0x020000D8 RID: 216
	public class tidalErosionPresetData
	{
		// Token: 0x060008AF RID: 2223 RVA: 0x0003F184 File Offset: 0x0003D384
		public tidalErosionPresetData(string pn, int ti, float tra, float tcl)
		{
			this.presetName = pn;
			this.tidalIterations = ti;
			this.tidalRangeAmount = tra;
			this.tidalCliffLimit = tcl;
		}

		// Token: 0x040007E0 RID: 2016
		public string presetName;

		// Token: 0x040007E1 RID: 2017
		public int tidalIterations;

		// Token: 0x040007E2 RID: 2018
		public float tidalRangeAmount;

		// Token: 0x040007E3 RID: 2019
		public float tidalCliffLimit;
	}

	// Token: 0x020000D9 RID: 217
	public class windErosionPresetData
	{
		// Token: 0x060008B0 RID: 2224 RVA: 0x0003F1AC File Offset: 0x0003D3AC
		public windErosionPresetData(string pn, int wi, float wd, float wf, float wl, float wg, float wc, float we, float ws)
		{
			this.presetName = pn;
			this.windIterations = wi;
			this.windDirection = wd;
			this.windForce = wf;
			this.windLift = wl;
			this.windGravity = wg;
			this.windCapacity = wc;
			this.windEntropy = we;
			this.windSmoothing = ws;
		}

		// Token: 0x040007E4 RID: 2020
		public string presetName;

		// Token: 0x040007E5 RID: 2021
		public int windIterations;

		// Token: 0x040007E6 RID: 2022
		public float windDirection;

		// Token: 0x040007E7 RID: 2023
		public float windForce;

		// Token: 0x040007E8 RID: 2024
		public float windLift;

		// Token: 0x040007E9 RID: 2025
		public float windGravity;

		// Token: 0x040007EA RID: 2026
		public float windCapacity;

		// Token: 0x040007EB RID: 2027
		public float windEntropy;

		// Token: 0x040007EC RID: 2028
		public float windSmoothing;
	}

	// Token: 0x020000DA RID: 218
	public enum ToolMode
	{
		// Token: 0x040007EE RID: 2030
		Create,
		// Token: 0x040007EF RID: 2031
		Erode,
		// Token: 0x040007F0 RID: 2032
		Texture
	}

	// Token: 0x020000DB RID: 219
	public enum ErosionMode
	{
		// Token: 0x040007F2 RID: 2034
		Filter,
		// Token: 0x040007F3 RID: 2035
		Brush
	}

	// Token: 0x020000DC RID: 220
	public enum ErosionType
	{
		// Token: 0x040007F5 RID: 2037
		Thermal,
		// Token: 0x040007F6 RID: 2038
		Hydraulic,
		// Token: 0x040007F7 RID: 2039
		Tidal,
		// Token: 0x040007F8 RID: 2040
		Wind,
		// Token: 0x040007F9 RID: 2041
		Glacial
	}

	// Token: 0x020000DD RID: 221
	public enum HydraulicType
	{
		// Token: 0x040007FB RID: 2043
		Fast,
		// Token: 0x040007FC RID: 2044
		Full,
		// Token: 0x040007FD RID: 2045
		Velocity
	}

	// Token: 0x020000DE RID: 222
	public enum Neighbourhood
	{
		// Token: 0x040007FF RID: 2047
		Moore,
		// Token: 0x04000800 RID: 2048
		VonNeumann
	}

	// Token: 0x020000DF RID: 223
	public enum GeneratorType
	{
		// Token: 0x04000802 RID: 2050
		Voronoi,
		// Token: 0x04000803 RID: 2051
		DiamondSquare,
		// Token: 0x04000804 RID: 2052
		Perlin,
		// Token: 0x04000805 RID: 2053
		Smooth,
		// Token: 0x04000806 RID: 2054
		Normalise
	}

	// Token: 0x020000E0 RID: 224
	public enum VoronoiType
	{
		// Token: 0x04000808 RID: 2056
		Linear,
		// Token: 0x04000809 RID: 2057
		Sine,
		// Token: 0x0400080A RID: 2058
		Tangent
	}

	// Token: 0x020000E1 RID: 225
	public enum FeatureType
	{
		// Token: 0x0400080C RID: 2060
		Mountains,
		// Token: 0x0400080D RID: 2061
		Hills,
		// Token: 0x0400080E RID: 2062
		Plateaus
	}

	// Token: 0x020000E2 RID: 226
	public class PerlinNoise2D
	{
		// Token: 0x060008B1 RID: 2225 RVA: 0x0003F204 File Offset: 0x0003D404
		public PerlinNoise2D(int freq, float _amp)
		{
			System.Random random = new System.Random(Environment.TickCount);
			this.noiseValues = new double[freq, freq];
			this.amplitude = _amp;
			this.frequency = freq;
			for (int i = 0; i < freq; i++)
			{
				for (int j = 0; j < freq; j++)
				{
					this.noiseValues[i, j] = random.NextDouble();
				}
			}
		}

		// Token: 0x060008B2 RID: 2226 RVA: 0x0003F288 File Offset: 0x0003D488
		public double getInterpolatedPoint(int _xa, int _xb, int _ya, int _yb, double Px, double Py)
		{
			double pa = this.interpolate(this.noiseValues[_xa % this.Frequency, _ya % this.frequency], this.noiseValues[_xb % this.Frequency, _ya % this.frequency], Px);
			double pb = this.interpolate(this.noiseValues[_xa % this.Frequency, _yb % this.frequency], this.noiseValues[_xb % this.Frequency, _yb % this.frequency], Px);
			return this.interpolate(pa, pb, Py);
		}

		// Token: 0x060008B3 RID: 2227 RVA: 0x0003F320 File Offset: 0x0003D520
		private double interpolate(double Pa, double Pb, double Px)
		{
			double num = Px * 3.1415927410125732;
			double num2 = (double)(1f - Mathf.Cos((float)num)) * 0.5;
			return Pa * (1.0 - num2) + Pb * num2;
		}

		// Token: 0x17000108 RID: 264
		// (get) Token: 0x060008B4 RID: 2228 RVA: 0x0003F364 File Offset: 0x0003D564
		public float Amplitude
		{
			get
			{
				return this.amplitude;
			}
		}

		// Token: 0x17000109 RID: 265
		// (get) Token: 0x060008B5 RID: 2229 RVA: 0x0003F36C File Offset: 0x0003D56C
		public int Frequency
		{
			get
			{
				return this.frequency;
			}
		}

		// Token: 0x0400080F RID: 2063
		private double[,] noiseValues;

		// Token: 0x04000810 RID: 2064
		private float amplitude = 1f;

		// Token: 0x04000811 RID: 2065
		private int frequency = 1;
	}

	// Token: 0x020000E8 RID: 232
	// (Invoke) Token: 0x060008CB RID: 2251
	public delegate void ErosionProgressDelegate(string titleString, string displayString, int iteration, int nIterations, float percentComplete);

	// Token: 0x020000E9 RID: 233
	// (Invoke) Token: 0x060008CF RID: 2255
	public delegate void TextureProgressDelegate(string titleString, string displayString, float percentComplete);

	// Token: 0x020000EA RID: 234
	// (Invoke) Token: 0x060008D3 RID: 2259
	public delegate void GeneratorProgressDelegate(string titleString, string displayString, float percentComplete);
}
