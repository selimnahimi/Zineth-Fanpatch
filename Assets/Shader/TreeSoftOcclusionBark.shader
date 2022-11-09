//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Nature/Tree Soft Occlusion Bark" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,0)
 _MainTex ("Main Texture", 2D) = "white" {}
 _BaseLight ("Base Light", Range(0,1)) = 0.35
 _AO ("Amb. Occlusion", Range(0,10)) = 2.4
 _Scale ("Scale", Vector) = (1,1,1,1)
 _SquashAmount ("Squash", Float) = 1
}
SubShader { 
 Tags { "IGNOREPROJECTOR"="True" "RenderType"="TreeOpaque" }
 Pass {
  Tags { "IGNOREPROJECTOR"="True" "RenderType"="TreeOpaque" }
  Lighting On
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 9 [_TerrainEngineBendTree]
Matrix 13 [_CameraToWorld]
Vector 6 [unity_LightColor0]
Vector 7 [unity_LightColor1]
Vector 8 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_LightPosition0]
Vector 23 [unity_LightPosition1]
Vector 24 [unity_LightPosition2]
Vector 25 [unity_LightPosition3]
Vector 26 [unity_LightAtten0]
Vector 27 [unity_LightAtten1]
Vector 28 [unity_LightAtten2]
Vector 29 [unity_LightAtten3]
Vector 30 [_Scale]
Vector 31 [_SquashPlaneNormal]
Float 32 [_SquashAmount]
Float 33 [_AO]
Float 34 [_BaseLight]
Vector 35 [_Color]
"!!ARBvp1.0
# 91 ALU
PARAM c[36] = { { 0, 1 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..16],
		state.matrix.mvp,
		program.local[21..35] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.position, c[30];
MOV R0.w, c[0].x;
MOV R1.w, c[0].y;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
ADD R1.xyz, R1, -R0;
MAD R1.xyz, vertex.color.w, R1, R0;
DP3 R0.x, R1, c[31];
ADD R0.x, R0, c[31].w;
MUL R0.xyz, R0.x, c[31];
ADD R1.xyz, -R0, R1;
MAD R1.xyz, R0, c[32].x, R1;
DP4 R2.z, R1, c[4];
DP4 R2.x, R1, c[2];
DP4 R2.y, R1, c[3];
MAD R0.xyz, -R2, c[22].w, c[22];
MAD R3.xyz, -R2, c[24].w, c[24];
MOV R3.z, -R3;
DP3 R0.w, R3, R3;
RSQ R3.w, R0.w;
MOV R0.z, -R0;
DP3 R2.w, R0, R0;
MUL R4.xyz, R3.w, R3;
RSQ R4.w, R2.w;
MUL R3.xyz, R4.w, R0;
DP3 R0.z, R4, c[15];
DP3 R0.x, R4, c[13];
DP3 R0.y, R4, c[14];
DP3 R3.w, vertex.normal, R0;
DP3 R0.z, R3, c[15];
DP3 R0.y, R3, c[14];
DP3 R0.x, R3, c[13];
DP3 R0.x, vertex.normal, R0;
MAX R0.y, R0.x, c[0].x;
MUL R0.z, R2.w, c[26];
ADD R3.x, R0.z, c[0].y;
MUL R0.x, vertex.attrib[14].w, c[33];
ADD R2.w, R0.x, c[34].x;
MUL R4.x, R2.w, R0.y;
MAD R0.xyz, -R2, c[23].w, c[23];
MAD R2.xyz, -R2, c[25].w, c[25];
RCP R4.y, R3.x;
MOV R3.xy, R0;
MOV R3.z, -R0;
MUL R0.x, R4, R4.y;
DP3 R4.w, R3, R3;
RSQ R4.x, R4.w;
MUL R4.xyz, R4.x, R3;
MUL R0.xyz, R0.x, c[6];
ADD R3.xyz, R0, c[1];
DP3 R0.z, R4, c[15];
DP3 R0.y, R4, c[14];
DP3 R0.x, R4, c[13];
DP3 R0.x, vertex.normal, R0;
MUL R4.x, R4.w, c[27].z;
ADD R0.y, R4.x, c[0];
MAX R0.x, R0, c[0];
RCP R0.y, R0.y;
MUL R0.x, R2.w, R0;
MUL R0.x, R0, R0.y;
MAD R0.xyz, R0.x, c[7], R3;
MUL R0.w, R0, c[28].z;
ADD R3.y, R0.w, c[0];
MOV R2.z, -R2;
MAX R3.w, R3, c[0].x;
DP3 R0.w, R2, R2;
RCP R3.z, R3.y;
RSQ R3.y, R0.w;
MUL R2.xyz, R3.y, R2;
MUL R3.x, R2.w, R3.w;
MUL R3.x, R3, R3.z;
MAD R0.xyz, R3.x, c[8], R0;
DP3 R3.z, R2, c[15];
DP3 R3.y, R2, c[14];
DP3 R3.x, R2, c[13];
MUL R2.x, R0.w, c[29].z;
DP3 R0.w, vertex.normal, R3;
ADD R2.x, R2, c[0].y;
MAX R0.w, R0, c[0].x;
RCP R2.x, R2.x;
MUL R0.w, R0, R2;
MUL R0.w, R0, R2.x;
MAD R0.xyz, R0.w, c[21], R0;
MOV R0.w, c[0].y;
MUL result.color, R0, c[35];
DP4 result.position.w, R1, c[20];
DP4 result.position.z, R1, c[19];
DP4 result.position.y, R1, c[18];
DP4 result.position.x, R1, c[17];
MOV result.texcoord[0], vertex.texcoord[0];
END
# 91 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_TerrainEngineBendTree]
Matrix 12 [_CameraToWorld]
Vector 16 [glstate_lightmodel_ambient]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_LightColor2]
Vector 20 [unity_LightColor3]
Vector 21 [unity_LightPosition0]
Vector 22 [unity_LightPosition1]
Vector 23 [unity_LightPosition2]
Vector 24 [unity_LightPosition3]
Vector 25 [unity_LightAtten0]
Vector 26 [unity_LightAtten1]
Vector 27 [unity_LightAtten2]
Vector 28 [unity_LightAtten3]
Vector 29 [_Scale]
Vector 30 [_SquashPlaneNormal]
Float 31 [_SquashAmount]
Float 32 [_AO]
Float 33 [_BaseLight]
Vector 34 [_Color]
"vs_2_0
; 91 ALU
def c35, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_color0 v3
dcl_texcoord0 v4
mul r0.xyz, v0, c29
mov r0.w, c35.x
mov r1.w, c35.y
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
add r1.xyz, r1, -r0
mad r1.xyz, v3.w, r1, r0
dp3 r0.x, r1, c30
add r0.x, r0, c30.w
mul r0.xyz, r0.x, c30
add r1.xyz, -r0, r1
mad r1.xyz, r0, c31.x, r1
dp4 r2.z, r1, c2
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mad r0.xyz, -r2, c21.w, c21
mad r3.xyz, -r2, c23.w, c23
mov r3.z, -r3
dp3 r0.w, r3, r3
rsq r3.w, r0.w
mov r0.z, -r0
dp3 r2.w, r0, r0
mul r4.xyz, r3.w, r3
rsq r4.w, r2.w
mul r3.xyz, r4.w, r0
dp3 r0.z, r4, c14
dp3 r0.x, r4, c12
dp3 r0.y, r4, c13
dp3 r3.w, v2, r0
dp3 r0.z, r3, c14
dp3 r0.y, r3, c13
dp3 r0.x, r3, c12
dp3 r0.x, v2, r0
max r0.y, r0.x, c35.x
mul r0.z, r2.w, c25
add r3.x, r0.z, c35.y
mul r0.x, v1.w, c32
add r2.w, r0.x, c33.x
mul r4.x, r2.w, r0.y
mad r0.xyz, -r2, c22.w, c22
mad r2.xyz, -r2, c24.w, c24
rcp r4.y, r3.x
mov r3.xy, r0
mov r3.z, -r0
mul r0.x, r4, r4.y
dp3 r4.w, r3, r3
rsq r4.x, r4.w
mul r4.xyz, r4.x, r3
mul r0.xyz, r0.x, c17
add r3.xyz, r0, c16
dp3 r0.z, r4, c14
dp3 r0.y, r4, c13
dp3 r0.x, r4, c12
dp3 r0.x, v2, r0
mul r4.x, r4.w, c26.z
add r0.y, r4.x, c35
max r0.x, r0, c35
rcp r0.y, r0.y
mul r0.x, r2.w, r0
mul r0.x, r0, r0.y
mad r0.xyz, r0.x, c18, r3
mul r0.w, r0, c27.z
add r3.y, r0.w, c35
mov r2.z, -r2
max r3.w, r3, c35.x
dp3 r0.w, r2, r2
rcp r3.z, r3.y
rsq r3.y, r0.w
mul r2.xyz, r3.y, r2
mul r3.x, r2.w, r3.w
mul r3.x, r3, r3.z
mad r0.xyz, r3.x, c19, r0
dp3 r3.z, r2, c14
dp3 r3.y, r2, c13
dp3 r3.x, r2, c12
mul r2.x, r0.w, c28.z
dp3 r0.w, v2, r3
add r2.x, r2, c35.y
max r0.w, r0, c35.x
rcp r2.x, r2.x
mul r0.w, r0, r2
mul r0.w, r0, r2.x
mad r0.xyz, r0.w, c20, r0
mov r0.w, c35.y
mul oD0, r0, c34
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
mov oT0, v4
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[1] = { { 2 } };
TEMP R0;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[0].x;
MUL result.color.xyz, fragment.color.primary, R0;
MOV result.color.w, fragment.color.primary;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
def c0, 2.00000000, 0, 0, 0
dcl t0.xy
dcl v0
texld r0, t0, s0
mul r0.xyz, r0, c0.x
mov_pp r0.w, v0
mul_pp r0.xyz, v0, r0
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "SHADOWCASTER"
  Tags { "LIGHTMODE"="SHADOWCASTER" "IGNOREPROJECTOR"="True" "RenderType"="TreeOpaque" }
  Cull Off
  Fog { Mode Off }
  Offset 1, 1
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 5 [_TerrainEngineBendTree]
Vector 9 [unity_LightShadowBias]
Vector 10 [_Scale]
Vector 11 [_SquashPlaneNormal]
Float 12 [_SquashAmount]
"!!ARBvp1.0
# 22 ALU
PARAM c[13] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[10];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[11];
ADD R0.w, R0, c[11];
MUL R1.xyz, R0.w, c[11];
ADD R0.xyz, -R1, R0;
MAD R0.xyz, R1, c[12].x, R0;
MOV R0.w, c[0].y;
DP4 R1.x, R0, c[4];
DP4 R1.y, R0, c[3];
ADD R1.y, R1, c[9].x;
MAX R1.z, R1.y, -R1.x;
ADD R1.z, R1, -R1.y;
MAD result.position.z, R1, c[9].y, R1.y;
MOV result.position.w, R1.x;
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 22 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_TerrainEngineBendTree]
Vector 8 [unity_LightShadowBias]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
"vs_2_0
; 23 ALU
def c12, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
mul r1.xyz, v0, c9
mov r1.w, c12.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c10
add r0.x, r0, c10.w
mul r0.xyz, r0.x, c10
add r1.xyz, -r0, r1
mad r1.xyz, r0, c11.x, r1
mov r1.w, c12.y
dp4 r0.x, r1, c2
add r0.x, r0, c8
max r0.y, r0.x, c12.x
add r0.y, r0, -r0.x
mad r0.z, r0.y, c8.y, r0.x
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 5 [_Object2World]
Matrix 9 [_TerrainEngineBendTree]
Vector 13 [_LightPositionRange]
Vector 14 [_Scale]
Vector 15 [_SquashPlaneNormal]
Float 16 [_SquashAmount]
"!!ARBvp1.0
# 21 ALU
PARAM c[17] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
ADD R0.xyz, R0, -R1;
MAD R1.xyz, vertex.color.w, R0, R1;
DP3 R0.x, R1, c[15];
ADD R0.x, R0, c[15].w;
MUL R0.xyz, R0.x, c[15];
ADD R1.xyz, -R0, R1;
MAD R1.xyz, R0, c[16].x, R1;
MOV R1.w, c[0].y;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD result.texcoord[0].xyz, R0, -c[13];
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_TerrainEngineBendTree]
Vector 12 [_LightPositionRange]
Vector 13 [_Scale]
Vector 14 [_SquashPlaneNormal]
Float 15 [_SquashAmount]
"vs_2_0
; 21 ALU
def c16, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
mul r1.xyz, v0, c13
mov r1.w, c16.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c14
add r0.x, r0, c14.w
mul r0.xyz, r0.x, c14
add r1.xyz, -r0, r1
mad r1.xyz, r0, c15.x, r1
mov r1.w, c16.y
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add oT0.xyz, r0, -c12
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "SHADOWS_DEPTH" }
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_DEPTH" }
"ps_2_0
; 4 ALU
dcl t0.xyzw
rcp r0.x, t0.w
mul r0.x, t0.z, r0
mov r0, r0.x
mov oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 0 TEX
PARAM c[3] = { program.local[0],
		{ 1, 255, 65025, 1.6058138e+008 },
		{ 0.0039215689 } };
TEMP R0;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
RCP R0.x, R0.x;
MUL R0.x, R0, c[0].w;
MUL R0, R0.x, c[1];
FRC R0, R0;
MAD result.color, -R0.yzww, c[2].x, R0;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
"ps_2_0
; 10 ALU
def c1, 1.00000000, 255.00000000, 65025.00000000, 160581376.00000000
def c2, 0.00392157, 0, 0, 0
dcl t0.xyz
dp3 r0.x, t0, t0
rsq r0.x, r0.x
rcp r0.x, r0.x
mul r0.x, r0, c0.w
mul r0, r0.x, c1
frc r1, r0
mov r0.z, -r1.w
mov r0.xyw, -r1.yzxw
mad r0, r0, c2.x, r1
mov oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "IGNOREPROJECTOR"="True" "RenderType"="TreeOpaque" }
 Pass {
  Tags { "IGNOREPROJECTOR"="True" "RenderType"="TreeOpaque" }
  Lighting On
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 9 [_TerrainEngineBendTree]
Matrix 13 [_CameraToWorld]
Vector 6 [unity_LightColor0]
Vector 7 [unity_LightColor1]
Vector 8 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_LightPosition0]
Vector 23 [unity_LightPosition1]
Vector 24 [unity_LightPosition2]
Vector 25 [unity_LightPosition3]
Vector 26 [unity_LightAtten0]
Vector 27 [unity_LightAtten1]
Vector 28 [unity_LightAtten2]
Vector 29 [unity_LightAtten3]
Vector 30 [_Scale]
Vector 31 [_SquashPlaneNormal]
Float 32 [_SquashAmount]
Float 33 [_AO]
Float 34 [_BaseLight]
Vector 35 [_Color]
"!!ARBvp1.0
# 91 ALU
PARAM c[36] = { { 0, 1 },
		state.lightmodel.ambient,
		state.matrix.modelview[0],
		program.local[6..16],
		state.matrix.mvp,
		program.local[21..35] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.position, c[30];
MOV R0.w, c[0].x;
MOV R1.w, c[0].y;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
ADD R1.xyz, R1, -R0;
MAD R1.xyz, vertex.color.w, R1, R0;
DP3 R0.x, R1, c[31];
ADD R0.x, R0, c[31].w;
MUL R0.xyz, R0.x, c[31];
ADD R1.xyz, -R0, R1;
MAD R1.xyz, R0, c[32].x, R1;
DP4 R2.z, R1, c[4];
DP4 R2.x, R1, c[2];
DP4 R2.y, R1, c[3];
MAD R0.xyz, -R2, c[22].w, c[22];
MAD R3.xyz, -R2, c[24].w, c[24];
MOV R3.z, -R3;
DP3 R0.w, R3, R3;
RSQ R3.w, R0.w;
MOV R0.z, -R0;
DP3 R2.w, R0, R0;
MUL R4.xyz, R3.w, R3;
RSQ R4.w, R2.w;
MUL R3.xyz, R4.w, R0;
DP3 R0.z, R4, c[15];
DP3 R0.x, R4, c[13];
DP3 R0.y, R4, c[14];
DP3 R3.w, vertex.normal, R0;
DP3 R0.z, R3, c[15];
DP3 R0.y, R3, c[14];
DP3 R0.x, R3, c[13];
DP3 R0.x, vertex.normal, R0;
MAX R0.y, R0.x, c[0].x;
MUL R0.z, R2.w, c[26];
ADD R3.x, R0.z, c[0].y;
MUL R0.x, vertex.attrib[14].w, c[33];
ADD R2.w, R0.x, c[34].x;
MUL R4.x, R2.w, R0.y;
MAD R0.xyz, -R2, c[23].w, c[23];
MAD R2.xyz, -R2, c[25].w, c[25];
RCP R4.y, R3.x;
MOV R3.xy, R0;
MOV R3.z, -R0;
MUL R0.x, R4, R4.y;
DP3 R4.w, R3, R3;
RSQ R4.x, R4.w;
MUL R4.xyz, R4.x, R3;
MUL R0.xyz, R0.x, c[6];
ADD R3.xyz, R0, c[1];
DP3 R0.z, R4, c[15];
DP3 R0.y, R4, c[14];
DP3 R0.x, R4, c[13];
DP3 R0.x, vertex.normal, R0;
MUL R4.x, R4.w, c[27].z;
ADD R0.y, R4.x, c[0];
MAX R0.x, R0, c[0];
RCP R0.y, R0.y;
MUL R0.x, R2.w, R0;
MUL R0.x, R0, R0.y;
MAD R0.xyz, R0.x, c[7], R3;
MUL R0.w, R0, c[28].z;
ADD R3.y, R0.w, c[0];
MOV R2.z, -R2;
MAX R3.w, R3, c[0].x;
DP3 R0.w, R2, R2;
RCP R3.z, R3.y;
RSQ R3.y, R0.w;
MUL R2.xyz, R3.y, R2;
MUL R3.x, R2.w, R3.w;
MUL R3.x, R3, R3.z;
MAD R0.xyz, R3.x, c[8], R0;
DP3 R3.z, R2, c[15];
DP3 R3.y, R2, c[14];
DP3 R3.x, R2, c[13];
MUL R2.x, R0.w, c[29].z;
DP3 R0.w, vertex.normal, R3;
ADD R2.x, R2, c[0].y;
MAX R0.w, R0, c[0].x;
RCP R2.x, R2.x;
MUL R0.w, R0, R2;
MUL R0.w, R0, R2.x;
MAD R0.xyz, R0.w, c[21], R0;
MOV R0.w, c[0].y;
MUL result.color, R0, c[35];
DP4 result.position.w, R1, c[20];
DP4 result.position.z, R1, c[19];
DP4 result.position.y, R1, c[18];
DP4 result.position.x, R1, c[17];
MOV result.texcoord[0], vertex.texcoord[0];
END
# 91 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_TerrainEngineBendTree]
Matrix 12 [_CameraToWorld]
Vector 16 [glstate_lightmodel_ambient]
Vector 17 [unity_LightColor0]
Vector 18 [unity_LightColor1]
Vector 19 [unity_LightColor2]
Vector 20 [unity_LightColor3]
Vector 21 [unity_LightPosition0]
Vector 22 [unity_LightPosition1]
Vector 23 [unity_LightPosition2]
Vector 24 [unity_LightPosition3]
Vector 25 [unity_LightAtten0]
Vector 26 [unity_LightAtten1]
Vector 27 [unity_LightAtten2]
Vector 28 [unity_LightAtten3]
Vector 29 [_Scale]
Vector 30 [_SquashPlaneNormal]
Float 31 [_SquashAmount]
Float 32 [_AO]
Float 33 [_BaseLight]
Vector 34 [_Color]
"vs_2_0
; 91 ALU
def c35, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_color0 v3
dcl_texcoord0 v4
mul r0.xyz, v0, c29
mov r0.w, c35.x
mov r1.w, c35.y
dp4 r1.z, r0, c10
dp4 r1.x, r0, c8
dp4 r1.y, r0, c9
add r1.xyz, r1, -r0
mad r1.xyz, v3.w, r1, r0
dp3 r0.x, r1, c30
add r0.x, r0, c30.w
mul r0.xyz, r0.x, c30
add r1.xyz, -r0, r1
mad r1.xyz, r0, c31.x, r1
dp4 r2.z, r1, c2
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mad r0.xyz, -r2, c21.w, c21
mad r3.xyz, -r2, c23.w, c23
mov r3.z, -r3
dp3 r0.w, r3, r3
rsq r3.w, r0.w
mov r0.z, -r0
dp3 r2.w, r0, r0
mul r4.xyz, r3.w, r3
rsq r4.w, r2.w
mul r3.xyz, r4.w, r0
dp3 r0.z, r4, c14
dp3 r0.x, r4, c12
dp3 r0.y, r4, c13
dp3 r3.w, v2, r0
dp3 r0.z, r3, c14
dp3 r0.y, r3, c13
dp3 r0.x, r3, c12
dp3 r0.x, v2, r0
max r0.y, r0.x, c35.x
mul r0.z, r2.w, c25
add r3.x, r0.z, c35.y
mul r0.x, v1.w, c32
add r2.w, r0.x, c33.x
mul r4.x, r2.w, r0.y
mad r0.xyz, -r2, c22.w, c22
mad r2.xyz, -r2, c24.w, c24
rcp r4.y, r3.x
mov r3.xy, r0
mov r3.z, -r0
mul r0.x, r4, r4.y
dp3 r4.w, r3, r3
rsq r4.x, r4.w
mul r4.xyz, r4.x, r3
mul r0.xyz, r0.x, c17
add r3.xyz, r0, c16
dp3 r0.z, r4, c14
dp3 r0.y, r4, c13
dp3 r0.x, r4, c12
dp3 r0.x, v2, r0
mul r4.x, r4.w, c26.z
add r0.y, r4.x, c35
max r0.x, r0, c35
rcp r0.y, r0.y
mul r0.x, r2.w, r0
mul r0.x, r0, r0.y
mad r0.xyz, r0.x, c18, r3
mul r0.w, r0, c27.z
add r3.y, r0.w, c35
mov r2.z, -r2
max r3.w, r3, c35.x
dp3 r0.w, r2, r2
rcp r3.z, r3.y
rsq r3.y, r0.w
mul r2.xyz, r3.y, r2
mul r3.x, r2.w, r3.w
mul r3.x, r3, r3.z
mad r0.xyz, r3.x, c19, r0
dp3 r3.z, r2, c14
dp3 r3.y, r2, c13
dp3 r3.x, r2, c12
mul r2.x, r0.w, c28.z
dp3 r0.w, v2, r3
add r2.x, r2, c35.y
max r0.w, r0, c35.x
rcp r2.x, r2.x
mul r0.w, r0, r2
mul r0.w, r0, r2.x
mad r0.xyz, r0.w, c20, r0
mov r0.w, c35.y
mul oD0, r0, c34
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
mov oT0, v4
"
}
}
  SetTexture [_MainTex] { combine primary * texture double, constant alpha }
 }
}
SubShader { 
 Tags { "IGNOREPROJECTOR"="True" "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "IGNOREPROJECTOR"="True" "RenderType"="Opaque" }
  Lighting On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
  }
  SetTexture [_MainTex] { combine primary * texture double, constant alpha }
 }
}
Dependency "BillboardShader" = "Hidden/Nature/Tree Soft Occlusion Bark Rendertex"
Fallback Off
}