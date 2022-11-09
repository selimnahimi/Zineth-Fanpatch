//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Reflective/VertexLit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Spec Color", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.7
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
 _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { TexGen CubeReflect }
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_MainTex_ST]
"!!ARBvp1.0
# 16 ALU
PARAM c[12] = { { 2 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R2.xyz, vertex.normal, c[9].w;
DP3 R0.z, R2, c[7];
DP3 R0.y, R2, c[6];
DP3 R0.x, R2, c[5];
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
ADD R1.xyz, -R1, c[10];
DP3 R0.w, R0, -R1;
MUL R0.xyz, R0, R0.w;
MAD result.texcoord[1].xyz, -R0, c[0].x, -R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_MainTex_ST]
"vs_2_0
; 16 ALU
def c11, 2.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r2.xyz, v1, c8.w
dp3 r0.z, r2, c6
dp3 r0.y, r2, c5
dp3 r0.x, r2, c4
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add r1.xyz, -r1, c9
dp3 r0.w, r0, -r1
mul r0.xyz, r0, r0.w
mad oT1.xyz, -r0, c11.x, -r1
mad oT0.xy, v2, c10, c10.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 2 TEX
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEX R1.w, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
MUL R0, R0, R1.w;
MUL result.color, R0, c[0];
END
# 4 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 3 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
dcl t0.xy
dcl t1.xyz
texld r1, t0, s0
texld r0, t1, s1
mul_pp r0, r0, r1.w
mul_pp r0, r0, c0
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "RenderType"="Opaque" }
  Lighting On
  SeparateSpecular On
  Material {
   Diffuse [_Color]
   Emission [_PPLAmbient]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "fp" {
SubProgram "opengl " {
Vector 0 [_SpecColor]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0.2199707, 0.70703125, 0.070983887, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R0.w, fragment.color.secondary;
MAD R0.xyz, R0, fragment.color.primary, R1;
DP3 R1.w, fragment.color.secondary, c[1];
MAD R1.x, R1.w, c[0].w, fragment.color.primary.w;
MUL result.color.xyz, R0, c[1].w;
MUL result.color.w, R0, R1.x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_SpecColor]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 1 TEX
dcl_2d s0
def c1, 0.21997070, 0.70703125, 0.07098389, 2.00000000
dcl t0.xy
dcl v0
dcl v1.xyz
texld r1, t0, s0
mul_pp r2.xyz, r1.w, v1
dp3_pp r0.x, v1, c1
mad_pp r1.xyz, r1, v0, r2
mad_pp r0.x, r0, c0.w, v0.w
mul_pp r1.xyz, r1, c1.w
mul_pp r1.w, r1, r0.x
mov_pp oC0, r1
"
}
}
  SetTexture [_MainTex] { combine texture, texture alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLM" "RenderType"="Opaque" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord", TexCoord1
  }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] ConstantColor [_Color] combine texture * constant }
  SetTexture [_MainTex] { combine texture * previous double, texture alpha * primary alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLMRGBM" "RenderType"="Opaque" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord1", TexCoord1
   Bind "texcoord", TexCoord2
  }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] combine texture * texture alpha double }
  SetTexture [unity_Lightmap] { ConstantColor [_Color] combine previous * constant }
  SetTexture [_MainTex] { combine texture * previous quad, texture alpha * primary alpha }
 }
}
SubShader { 
 LOD 150
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Vertex" "RenderType"="Opaque" }
  Lighting On
  SeparateSpecular On
  Material {
   Ambient (1,1,1,1)
   Diffuse [_Color]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
  SetTexture [_Cube] { combine texture * previous alpha + previous, previous alpha }
 }
}
Fallback "VertexLit"
}