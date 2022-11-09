//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Transparent/Cutout/VertexLit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Spec Color", Color) = (1,1,1,0)
 _Emission ("Emissive Color", Color) = (0,0,0,0)
 _Shininess ("Shininess", Range(0.1,1)) = 0.7
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
 _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  Lighting On
  AlphaToMask On
  SeparateSpecular On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
   Emission [_Emission]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  AlphaTest Greater [_Cutoff]
  ColorMask RGB
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLM" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord", TexCoord1
  }
  AlphaToMask On
  AlphaTest Greater [_Cutoff]
  ColorMask RGB
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] ConstantColor [_Color] combine texture * constant }
  SetTexture [_MainTex] { combine texture * previous double, texture alpha * primary alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLMRGBM" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord1", TexCoord1
   Bind "texcoord", TexCoord2
  }
  AlphaToMask On
  AlphaTest Greater [_Cutoff]
  ColorMask RGB
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] combine texture * texture alpha double }
  SetTexture [unity_Lightmap] { ConstantColor [_Color] combine previous * constant }
  SetTexture [_MainTex] { combine texture * previous quad, texture alpha * primary alpha }
 }
 Pass {
  Name "CASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [unity_LightShadowBias]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
# 10 ALU
PARAM c[7] = { program.local[0],
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
DP4 R0.x, vertex.position, c[4];
DP4 R0.y, vertex.position, c[3];
ADD R0.y, R0, c[5].x;
MAX R0.z, R0.y, -R0.x;
ADD R0.z, R0, -R0.y;
MAD result.position.z, R0, c[5].y, R0.y;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[6], c[6].zwzw;
MOV result.position.w, R0.x;
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [unity_LightShadowBias]
Vector 5 [_MainTex_ST]
"vs_2_0
; 11 ALU
def c6, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.x, v0, c2
add r0.x, r0, c4
max r0.y, r0.x, c6.x
add r0.y, r0, -r0.x
mad r0.z, r0.y, c4.y, r0.x
dp4 r0.w, v0, c3
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT0, r0
mad oT1.xy, v1, c5, c5.zwzw
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_LightPositionRange]
Vector 10 [_MainTex_ST]
"!!ARBvp1.0
# 9 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[0].xyz, R0, -c[9];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[10], c[10].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_LightPositionRange]
Vector 9 [_MainTex_ST]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add oT0.xyz, r0, -c8
mad oT1.xy, v1, c9, c9.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
MUL R0.x, R0.w, c[1].w;
SLT R0.x, R0, c[0];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 8 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xy
texld r0, t1, s0
mov_pp r0.x, c0
mad_pp r0.x, r0.w, c1.w, -r0
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t0.w
mul r0.x, t0.z, r0
mov r0, r0.x
mov oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[5] = { program.local[0..2],
		{ 1, 255, 65025, 1.6058138e+008 },
		{ 0.0039215689 } };
TEMP R0;
TEX R0.w, fragment.texcoord[1], texture[0], 2D;
MUL R0.x, R0.w, c[2].w;
SLT R0.x, R0, c[1];
KIL -R0.x;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[0].w;
MUL R0, R0.x, c[3];
FRC R0, R0;
MAD result.color, -R0.yzww, c[4].x, R0;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Float 1 [_Cutoff]
Vector 2 [_Color]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c3, 0.00000000, 1.00000000, 0.00392157, 0
def c4, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
dcl t0.xyz
dcl t1.xy
texld r0, t1, s0
mov_pp r0.x, c1
mad_pp r0.x, r0.w, c2.w, -r0
cmp r0.x, r0, c3, c3.y
mov_pp r0, -r0.x
texkill r0.xyzw
dp3 r0.x, t0, t0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c0.w
mul r0, r0.x, c4
frc r1, r0
mov r0.z, -r1.w
mov r0.xyw, -r1.yzxw
mad r0, r0, c3.z, r1
mov oC0, r0
"
}
}
 }
 Pass {
  Name "SHADOWCOLLECTOR"
  Tags { "LIGHTMODE"="SHADOWCOLLECTOR" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 9 [_Object2World]
Matrix 13 [unity_World2Shadow0]
Matrix 17 [unity_World2Shadow1]
Matrix 21 [unity_World2Shadow2]
Matrix 25 [unity_World2Shadow3]
Vector 29 [_MainTex_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[30] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..29] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[15];
DP4 result.texcoord[0].y, R1, c[14];
DP4 result.texcoord[0].x, R1, c[13];
DP4 result.texcoord[1].z, R1, c[19];
DP4 result.texcoord[1].y, R1, c[18];
DP4 result.texcoord[1].x, R1, c[17];
DP4 result.texcoord[2].z, R1, c[23];
DP4 result.texcoord[2].y, R1, c[22];
DP4 result.texcoord[2].x, R1, c[21];
DP4 result.texcoord[3].z, R1, c[27];
DP4 result.texcoord[3].y, R1, c[26];
DP4 result.texcoord[3].x, R1, c[25];
MOV result.texcoord[4], R0;
MAD result.texcoord[5].xy, vertex.texcoord[0], c[29], c[29].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 25 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [unity_World2Shadow0]
Matrix 16 [unity_World2Shadow1]
Matrix 20 [unity_World2Shadow2]
Matrix 24 [unity_World2Shadow3]
Vector 28 [_MainTex_ST]
"vs_2_0
; 25 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c2
dp4 r1.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c14
dp4 oT0.y, r1, c13
dp4 oT0.x, r1, c12
dp4 oT1.z, r1, c18
dp4 oT1.y, r1, c17
dp4 oT1.x, r1, c16
dp4 oT2.z, r1, c22
dp4 oT2.y, r1, c21
dp4 oT2.x, r1, c20
dp4 oT3.z, r1, c26
dp4 oT3.y, r1, c25
dp4 oT3.x, r1, c24
mov oT4, r0
mad oT5.xy, v1, c28, c28.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [unity_World2Shadow0]
Matrix 16 [unity_World2Shadow1]
Matrix 20 [unity_World2Shadow2]
Matrix 24 [unity_World2Shadow3]
Vector 28 [_MainTex_ST]
"vs_2_0
; 25 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c2
dp4 r1.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c14
dp4 oT0.y, r1, c13
dp4 oT0.x, r1, c12
dp4 oT1.z, r1, c18
dp4 oT1.y, r1, c17
dp4 oT1.x, r1, c16
dp4 oT2.z, r1, c22
dp4 oT2.y, r1, c21
dp4 oT2.x, r1, c20
dp4 oT3.z, r1, c26
dp4 oT3.y, r1, c25
dp4 oT3.x, r1, c24
mov oT4, r0
mad oT5.xy, v1, c28, c28.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 9 [_Object2World]
Matrix 13 [unity_World2Shadow0]
Matrix 17 [unity_World2Shadow1]
Matrix 21 [unity_World2Shadow2]
Matrix 25 [unity_World2Shadow3]
Vector 29 [_MainTex_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[30] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..29] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[3];
DP4 R1.w, vertex.position, c[12];
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
MOV R1.xyz, R0;
MOV R0.w, -R0;
DP4 result.texcoord[0].z, R1, c[15];
DP4 result.texcoord[0].y, R1, c[14];
DP4 result.texcoord[0].x, R1, c[13];
DP4 result.texcoord[1].z, R1, c[19];
DP4 result.texcoord[1].y, R1, c[18];
DP4 result.texcoord[1].x, R1, c[17];
DP4 result.texcoord[2].z, R1, c[23];
DP4 result.texcoord[2].y, R1, c[22];
DP4 result.texcoord[2].x, R1, c[21];
DP4 result.texcoord[3].z, R1, c[27];
DP4 result.texcoord[3].y, R1, c[26];
DP4 result.texcoord[3].x, R1, c[25];
MOV result.texcoord[4], R0;
MAD result.texcoord[5].xy, vertex.texcoord[0], c[29], c[29].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 25 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [unity_World2Shadow0]
Matrix 16 [unity_World2Shadow1]
Matrix 20 [unity_World2Shadow2]
Matrix 24 [unity_World2Shadow3]
Vector 28 [_MainTex_ST]
"vs_2_0
; 25 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c2
dp4 r1.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c14
dp4 oT0.y, r1, c13
dp4 oT0.x, r1, c12
dp4 oT1.z, r1, c18
dp4 oT1.y, r1, c17
dp4 oT1.x, r1, c16
dp4 oT2.z, r1, c22
dp4 oT2.y, r1, c21
dp4 oT2.x, r1, c20
dp4 oT3.z, r1, c26
dp4 oT3.y, r1, c25
dp4 oT3.x, r1, c24
mov oT4, r0
mad oT5.xy, v1, c28, c28.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [unity_World2Shadow0]
Matrix 16 [unity_World2Shadow1]
Matrix 20 [unity_World2Shadow2]
Matrix 24 [unity_World2Shadow3]
Vector 28 [_MainTex_ST]
"vs_2_0
; 25 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c2
dp4 r1.w, v0, c11
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
mov r1.xyz, r0
mov r0.w, -r0
dp4 oT0.z, r1, c14
dp4 oT0.y, r1, c13
dp4 oT0.x, r1, c12
dp4 oT1.z, r1, c18
dp4 oT1.y, r1, c17
dp4 oT1.x, r1, c16
dp4 oT2.z, r1, c22
dp4 oT2.y, r1, c21
dp4 oT2.x, r1, c20
dp4 oT3.z, r1, c26
dp4 oT3.y, r1, c25
dp4 oT3.x, r1, c24
mov oT4, r0
mad oT5.xy, v1, c28, c28.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [_LightSplitsNear]
Vector 3 [_LightSplitsFar]
Float 4 [_Cutoff]
Vector 5 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 2 TEX
PARAM c[7] = { program.local[0..5],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
MUL R0.w, R0, c[5];
SLT R0.w, R0, c[4].x;
SLT R2, fragment.texcoord[4].w, c[3];
SGE R1, fragment.texcoord[4].w, c[2];
MUL R1, R1, R2;
MUL R0.xyz, R1.y, fragment.texcoord[1];
MAD R0.xyz, R1.x, fragment.texcoord[0], R0;
MAD R0.xyz, R1.z, fragment.texcoord[2], R0;
MAD R0.xyz, fragment.texcoord[3], R1.w, R0;
MAD_SAT R1.y, fragment.texcoord[4].w, c[1].z, c[1].w;
MOV result.color.y, c[6].x;
TEX R0.x, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.z, R0.x, -R0;
MOV R0.x, c[6];
CMP R1.x, R0.z, c[1], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[6].x;
MUL R0.xy, R0.y, c[6];
FRC R0.zw, R0.xyxy;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[6].z, R0.z;
ADD_SAT result.color.x, R1, R1.y;
MOV result.color.zw, R0.xyxy;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [_LightSplitsNear]
Vector 3 [_LightSplitsFar]
Float 4 [_Cutoff]
Vector 5 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 28 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c6, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
texld r2, t5, s0
add r1, t4.w, -c3
add r0, t4.w, -c2
cmp r1, r1, c6.x, c6.y
cmp r0, r0, c6.y, c6.x
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r1.xyz, r0.z, t2, r1
mov_pp r0.x, c4
mad_pp r0.x, r2.w, c5.w, -r0
mad r2.xyz, t3, r0.w, r1
cmp r0.x, r0, c6, c6.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
mul r1.x, -t4.w, c0.w
mov r2.x, c1
add r0.x, r0, -r2.z
cmp r0.x, r0, c6.y, r2
add r1.x, r1, c6.y
mul r2.xy, r1.x, c6.yzxw
mad_sat r1.x, t4.w, c1.z, c1.w
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c6.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c6
mov_pp oC0, r0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [_LightSplitsNear]
Vector 3 [_LightSplitsFar]
Float 4 [_Cutoff]
Vector 5 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 29 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c6, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyzw
dcl t5.xy
texld r2, t5, s0
add r1, t4.w, -c3
add r0, t4.w, -c2
mul r2.x, -t4.w, c0.w
add r2.x, r2, c6.y
mul r2.xy, r2.x, c6.yzxw
cmp r1, r1, c6.x, c6.y
cmp r0, r0, c6.y, c6.x
mul r0, r0, r1
mul r1.xyz, r0.y, t1
mad r1.xyz, r0.x, t0, r1
mad r1.xyz, r0.z, t2, r1
mov_pp r0.x, c4
mad_pp r0.x, r2.w, c5.w, -r0
mad r1.xyz, t3, r0.w, r1
cmp r0.x, r0, c6, c6.y
mov_pp r0, -r0.x
mov r1.w, c6.y
frc r2.xy, r2
texkill r0.xyzw
texldp r1, r1, s1
mov r0.x, c1
add r0.x, c6.y, -r0
mad r0.x, r1, r0, c1
mad_sat r1.x, t4.w, c1.z, c1.w
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c6.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c6
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [unity_ShadowFadeCenterAndType]
Vector 3 [unity_ShadowSplitSpheres0]
Vector 4 [unity_ShadowSplitSpheres1]
Vector 5 [unity_ShadowSplitSpheres2]
Vector 6 [unity_ShadowSplitSpheres3]
Vector 7 [unity_ShadowSplitSqRadii]
Float 8 [_Cutoff]
Vector 9 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 36 ALU, 2 TEX
PARAM c[11] = { program.local[0..9],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[5], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[4], -c[3];
ADD R2.xyz, fragment.texcoord[4], -c[6];
MUL R0.w, R0, c[9];
SLT R0.w, R0, c[8].x;
DP3 R1.x, R1, R1;
ADD R0.xyz, fragment.texcoord[4], -c[4];
DP3 R1.y, R0, R0;
ADD R0.xyz, fragment.texcoord[4], -c[5];
DP3 R1.z, R0, R0;
DP3 R1.w, R2, R2;
SLT R2, R1, c[7];
ADD_SAT R0.xyz, R2.yzww, -R2;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MAD R1.xyz, R2.x, fragment.texcoord[0], R1;
MAD R1.xyz, R0.y, fragment.texcoord[2], R1;
MAD R0.xyz, fragment.texcoord[3], R0.z, R1;
ADD R1.xyz, -fragment.texcoord[4], c[2];
MOV result.color.y, c[10].x;
TEX R0.x, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.y, R0.x, -R0.z;
DP3 R0.z, R1, R1;
RSQ R0.z, R0.z;
MOV R0.x, c[10];
CMP R0.x, R0.y, c[1], R0;
MUL R0.y, -fragment.texcoord[4].w, c[0].w;
ADD R0.y, R0, c[10].x;
RCP R1.x, R0.z;
MUL R0.zw, R0.y, c[10].xyxy;
MAD_SAT R0.y, R1.x, c[1].z, c[1].w;
FRC R0.zw, R0;
ADD_SAT result.color.x, R0, R0.y;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[10].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 36 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [unity_ShadowFadeCenterAndType]
Vector 3 [unity_ShadowSplitSpheres0]
Vector 4 [unity_ShadowSplitSpheres1]
Vector 5 [unity_ShadowSplitSpheres2]
Vector 6 [unity_ShadowSplitSpheres3]
Vector 7 [unity_ShadowSplitSqRadii]
Float 8 [_Cutoff]
Vector 9 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 41 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c10, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
texld r1, t5, s0
add r0.xyz, t4, -c3
add r2.xyz, t4, -c6
dp3 r0.x, r0, r0
add r1.xyz, t4, -c4
dp3 r0.y, r1, r1
add r1.xyz, t4, -c5
dp3 r0.w, r2, r2
dp3 r0.z, r1, r1
add r0, r0, -c7
cmp r2, r0, c10.x, c10.y
mov r0.x, r2.y
mov r0.y, r2.z
mov r0.z, r2.w
add_sat r0.xyz, r0, -r2
mul r1.xyz, r0.x, t1
mad r1.xyz, r2.x, t0, r1
mad r1.xyz, r0.y, t2, r1
mov_pp r0.x, c8
mad_pp r0.x, r1.w, c9.w, -r0
mad r2.xyz, t3, r0.z, r1
cmp r0.x, r0, c10, c10.y
mov_pp r1, -r0.x
texld r0, r2, s1
texkill r1.xyzw
add r0.x, r0, -r2.z
mov r1.x, c1
add r2.xyz, -t4, c2
cmp r0.x, r0, c10.y, r1
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c10.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c1.z, c1.w
mul r2.xy, r2.x, c10.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c10.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c10
mov_pp oC0, r0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Vector 0 [_ProjectionParams]
Vector 1 [_LightShadowData]
Vector 2 [unity_ShadowFadeCenterAndType]
Vector 3 [unity_ShadowSplitSpheres0]
Vector 4 [unity_ShadowSplitSpheres1]
Vector 5 [unity_ShadowSplitSpheres2]
Vector 6 [unity_ShadowSplitSpheres3]
Vector 7 [unity_ShadowSplitSqRadii]
Float 8 [_Cutoff]
Vector 9 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 42 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
def c10, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
dcl t5.xy
texld r1, t5, s0
add r0.xyz, t4, -c3
add r2.xyz, t4, -c6
dp3 r0.x, r0, r0
add r1.xyz, t4, -c4
dp3 r0.y, r1, r1
add r1.xyz, t4, -c5
dp3 r0.z, r1, r1
dp3 r0.w, r2, r2
add r0, r0, -c7
cmp r0, r0, c10.x, c10.y
mov r1.x, r0.y
mov r1.z, r0.w
mov r1.y, r0.z
add_sat r1.xyz, r1, -r0
mul r2.xyz, r1.x, t1
mad r0.xyz, r0.x, t0, r2
mad r2.xyz, r1.y, t2, r0
mad r1.xyz, t3, r1.z, r2
mov_pp r0.x, c8
mad_pp r0.x, r1.w, c9.w, -r0
cmp r0.x, r0, c10, c10.y
mov_pp r0, -r0.x
mov r1.w, c10.y
add r2.xyz, -t4, c2
texkill r0.xyzw
texldp r1, r1, s1
mov r0.x, c1
add r0.x, c10.y, -r0
mad r0.x, r1, r0, c1
dp3 r1.x, r2, r2
mul r2.x, -t4.w, c0.w
rsq r1.x, r1.x
add r2.x, r2, c10.y
rcp r1.x, r1.x
mad_sat r1.x, r1, c1.z, c1.w
mul r2.xy, r2.x, c10.yzxw
frc r2.xy, r2
add_sat r0.x, r0, r1
mov r1.y, r2
mad r1.x, -r2.y, c10.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov r0.y, c10
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 LOD 100
 Tags { "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "LIGHTMODE"="Always" "IGNOREPROJECTOR"="True" "RenderType"="TransparentCutout" }
  Lighting On
  AlphaToMask On
  SeparateSpecular On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
   Emission [_Emission]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  AlphaTest Greater [_Cutoff]
  ColorMask RGB
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
 }
}
}