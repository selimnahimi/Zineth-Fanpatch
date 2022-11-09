//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "RadShader" {
Properties {
 _Color ("_Color", Color) = (0.199457,0.0298507,1,1)
 _number ("_number", Range(0,0.5)) = 0.361
 _size ("_size", Range(0.75,1)) = 0.968
 _speed ("_speed", Range(0,200)) = 5.5
 _normal_off ("_normal_off", Float) = 0
 _col_blend ("_col_blend", Range(0,1)) = 0.75
}
SubShader { 
 Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
 GrabPass {
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  Cull Off
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Float 24 [_normal_off]
"!!ARBvp1.0
# 53 ALU
PARAM c[25] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[19];
DP4 R2.y, R0, c[18];
DP4 R2.x, R0, c[17];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[22];
DP4 R3.y, R1, c[21];
DP4 R3.x, R1, c[20];
ADD R3.xyz, R2, R3;
MAD R2.x, R0, R0, -R0.y;
MUL R4.xyz, R2.x, c[23];
ADD result.texcoord[3].xyz, R3, R4;
MOV R3.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R3.zxyw, -R4;
MUL R4.xyz, R3, vertex.attrib[14].w;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R1, R0, c[24].x, vertex.position;
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R0.xyz, R2.xyww, c[0].y;
MUL R0.y, R0, c[13].x;
ADD result.texcoord[0].xy, R0, R0.z;
MOV R0, c[16];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
MOV R0.xyz, c[15];
MOV R0.w, c[0].x;
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[14].w, -R1;
DP3 result.texcoord[2].y, R3, R4;
DP3 result.texcoord[4].y, R4, R0;
MOV result.position, R2;
MOV result.texcoord[0].zw, R2;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, R3, vertex.attrib[14];
DP4 result.texcoord[1].z, R1, c[7];
DP4 result.texcoord[1].y, R1, c[6];
DP4 result.texcoord[1].x, R1, c[5];
END
# 53 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Float 24 [_normal_off]
"vs_2_0
; 56 ALU
def c25, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
mul r0.y, r2.w, r2.w
mad r1.x, r0, r0, -r0.y
add r2.xyz, r2, r3
mul r4.xyz, r1.x, c23
add oT3.xyz, r2, r4
mov r2.xyz, v1
mov r0.w, c25.y
mov r0.xyz, v2
mad r0, r0, c24.x, v0
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
mul r1.xyz, r3.xyww, c25.x
mul r1.y, r1, c12.x
mad oT0.xy, r1.z, c13.zwzw, r1
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r4.xyz, r2, v1.w
mov r2, c8
mov r1, c10
dp4 r5.z, c16, r1
mov r1, c9
dp4 r5.y, c16, r1
dp4 r5.x, c16, r2
mov r1.xyz, c15
mov r1.w, c25.y
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r1.xyz, r2, c14.w, -r0
dp3 oT2.y, r5, r4
dp3 oT4.y, r4, r1
mov oPos, r3
mov oT0.zw, r3
dp3 oT4.z, v2, r1
dp3 oT4.x, v1, r1
dp3 oT2.z, v2, r5
dp3 oT2.x, r5, v1
dp4 oT1.z, r0, c6
dp4 oT1.y, r0, c5
dp4 oT1.x, r0, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_ProjectionParams]
Float 15 [_normal_off]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 16 ALU
PARAM c[17] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
MAD R1, R0, c[15].x, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[0].y;
MUL R2.y, R2, c[13].x;
ADD result.texcoord[0].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
DP4 result.texcoord[1].z, R1, c[7];
DP4 result.texcoord[1].y, R1, c[6];
DP4 result.texcoord[1].x, R1, c[5];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 16 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
"vs_2_0
; 16 ALU
def c16, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
mov r0.xyz, v2
mov r0.w, c16.x
mad r1, r0, c14.x, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c16.y
mul r2.y, r2, c12.x
mad oT0.xy, r2.z, c13.zwzw, r2
mov oPos, r0
mov oT0.zw, r0
dp4 oT1.z, r1, c6
dp4 oT1.y, r1, c5
dp4 oT1.x, r1, c4
mad oT2.xy, v4, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Float 24 [_normal_off]
"!!ARBvp1.0
# 55 ALU
PARAM c[25] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[19];
DP4 R2.y, R0, c[18];
DP4 R2.x, R0, c[17];
DP4 R3.z, R1, c[22];
DP4 R3.y, R1, c[21];
DP4 R3.x, R1, c[20];
MUL R0.y, R2.w, R2.w;
MAD R1.w, R0.x, R0.x, -R0.y;
ADD R1.xyz, R2, R3;
MUL R4.xyz, R1.w, c[23];
ADD result.texcoord[3].xyz, R1, R4;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R3, R0, c[24].x, vertex.position;
MOV R0.w, c[0].x;
DP4 R2.w, R3, c[4];
DP4 R2.z, R3, c[3];
DP4 R2.x, R3, c[1];
DP4 R2.y, R3, c[2];
MUL R0.xyz, R2.xyww, c[0].y;
MUL R0.y, R0, c[13].x;
ADD R1.xy, R0, R0.z;
MOV R0.xyz, c[15];
MOV R1.zw, R2;
DP4 R5.z, R0, c[11];
DP4 R5.y, R0, c[10];
DP4 R5.x, R0, c[9];
MAD R5.xyz, R5, c[14].w, -R3;
MOV R4.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R4.yzxw;
MAD R4.xyz, vertex.normal.yzxw, R4.zxyw, -R0;
MOV R0, c[16];
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R6.z, R0, c[11];
DP4 R6.y, R0, c[10];
DP4 R6.x, R0, c[9];
MOV result.texcoord[0], R1;
DP3 result.texcoord[2].y, R6, R4;
DP3 result.texcoord[4].y, R4, R5;
MOV result.texcoord[5], R1;
MOV result.position, R2;
DP3 result.texcoord[4].z, vertex.normal, R5;
DP3 result.texcoord[4].x, vertex.attrib[14], R5;
DP3 result.texcoord[2].z, vertex.normal, R6;
DP3 result.texcoord[2].x, R6, vertex.attrib[14];
DP4 result.texcoord[1].z, R3, c[7];
DP4 result.texcoord[1].y, R3, c[6];
DP4 result.texcoord[1].x, R3, c[5];
END
# 55 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Float 24 [_normal_off]
"vs_2_0
; 58 ALU
def c25, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r1.xyz, v2, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c25.y
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
mul r0.y, r2.w, r2.w
mad r1.x, r0, r0, -r0.y
mul r4.xyz, r1.x, c23
add r3.xyz, r2, r3
add oT3.xyz, r3, r4
mov r3.w, c25.y
mov r3.xyz, c15
dp4 r4.z, r3, c10
dp4 r4.y, r3, c9
dp4 r4.x, r3, c8
mov r0.w, c25.y
mov r0.xyz, v2
mad r2, r0, c24.x, v0
mad r6.xyz, r4, c14.w, -r2
mov r3.xyz, v1
mul r4.xyz, v2.zxyw, r3.yzxw
mov r3.xyz, v1
mad r4.xyz, v2.yzxw, r3.zxyw, -r4
mul r5.xyz, r4, v1.w
mov r3, c10
dp4 r7.z, c16, r3
mov r3, c9
mov r4, c8
dp4 r1.w, r2, c3
dp4 r7.y, c16, r3
dp4 r7.x, c16, r4
dp4 r1.x, r2, c0
dp4 r1.y, r2, c1
mul r0.xyz, r1.xyww, c25.x
dp4 r1.z, r2, c2
mul r0.y, r0, c12.x
mad r0.xy, r0.z, c13.zwzw, r0
mov r0.zw, r1
mov oT0, r0
dp3 oT2.y, r7, r5
dp3 oT4.y, r5, r6
mov oT5, r0
mov oPos, r1
dp3 oT4.z, v2, r6
dp3 oT4.x, v1, r6
dp3 oT2.z, v2, r7
dp3 oT2.x, r7, v1
dp4 oT1.z, r2, c6
dp4 oT1.y, r2, c5
dp4 oT1.x, r2, c4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_ProjectionParams]
Float 15 [_normal_off]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 18 ALU
PARAM c[17] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R2, R0, c[15].x, vertex.position;
DP4 R1.w, R2, c[4];
DP4 R1.x, R2, c[1];
DP4 R1.y, R2, c[2];
MUL R0.xyz, R1.xyww, c[0].y;
DP4 R1.z, R2, c[3];
MUL R0.y, R0, c[13].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[0], R0;
MOV result.texcoord[3], R0;
MOV result.position, R1;
DP4 result.texcoord[1].z, R2, c[7];
DP4 result.texcoord[1].y, R2, c[6];
DP4 result.texcoord[1].x, R2, c[5];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 18 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
"vs_2_0
; 18 ALU
def c16, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
mov r0.w, c16.x
mov r0.xyz, v2
mad r2, r0, c14.x, v0
dp4 r1.w, r2, c3
dp4 r1.x, r2, c0
dp4 r1.y, r2, c1
mul r0.xyz, r1.xyww, c16.y
dp4 r1.z, r2, c2
mul r0.y, r0, c12.x
mad r0.xy, r0.z, c13.zwzw, r0
mov r0.zw, r1
mov oT0, r0
mov oT3, r0
mov oPos, r1
dp4 oT1.z, r2, c6
dp4 oT1.y, r2, c5
dp4 oT1.x, r2, c4
mad oT2.xy, v4, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Float 32 [_normal_off]
"!!ARBvp1.0
# 84 ALU
PARAM c[33] = { { 1, 0.5, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MUL R4.xyz, vertex.normal, c[14].w;
DP3 R6.x, R4, c[5];
MOV R6.w, c[0].x;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R1, R0, c[32].x, vertex.position;
DP4 R5.zw, R1, c[6];
ADD R2, -R5.z, c[18];
DP3 R5.z, R4, c[6];
DP3 R4.x, R4, c[7];
DP4 R4.w, R1, c[5];
MUL R3, R5.z, R2;
ADD R0, -R4.w, c[17];
MUL R2, R2, R2;
MOV R6.z, R4.x;
MOV R6.y, R5.z;
MAD R3, R6.x, R0, R3;
DP4 R5.xy, R1, c[7];
MAD R2, R0, R0, R2;
ADD R0, -R5.x, c[19];
MAD R2, R0, R0, R2;
MAD R0, R4.x, R0, R3;
MUL R3, R2, c[20];
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.w, R2.w;
RSQ R2.z, R2.z;
MUL R0, R0, R2;
ADD R2, R3, c[0].x;
DP4 R3.z, R6, c[27];
DP4 R3.y, R6, c[26];
DP4 R3.x, R6, c[25];
DP4 R3.w, R1, c[4];
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[22];
MAD R2.xyz, R0.x, c[21], R2;
MAD R0.xyz, R0.z, c[23], R2;
MAD R2.xyz, R0.w, c[24], R0;
MUL R0, R6.xyzz, R6.yzzx;
MUL R2.w, R5.z, R5.z;
DP4 R4.z, R0, c[30];
DP4 R4.y, R0, c[29];
DP4 R4.x, R0, c[28];
MAD R2.w, R6.x, R6.x, -R2;
ADD R3.xyz, R3, R4;
MUL R0.xyz, R2.w, c[31];
ADD R4.xyz, R3, R0;
ADD result.texcoord[3].xyz, R4, R2;
MOV R2.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R4;
DP4 R3.z, R1, c[3];
MUL R4.xyz, R2, vertex.attrib[14].w;
DP4 R3.x, R1, c[1];
DP4 R3.y, R1, c[2];
MUL R0.xyz, R3.xyww, c[0].y;
MUL R0.y, R0, c[13].x;
ADD result.texcoord[0].xy, R0, R0.z;
MOV R0, c[16];
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MOV R0.xyz, c[15];
MOV R0.w, c[0].x;
DP3 result.texcoord[2].y, R2, R4;
DP4 R6.z, R0, c[11];
DP4 R6.x, R0, c[9];
DP4 R6.y, R0, c[10];
MAD R0.xyz, R6, c[14].w, -R1;
DP3 result.texcoord[4].y, R4, R0;
MOV R4.x, R5.w;
MOV R4.y, R5;
MOV result.position, R3;
MOV result.texcoord[0].zw, R3;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
MOV result.texcoord[1].xyz, R4.wxyw;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, R2, vertex.attrib[14];
END
# 84 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Float 32 [_normal_off]
"vs_2_0
; 87 ALU
def c33, 1.00000000, 0.50000000, 0.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r4.xyz, v2, c14.w
dp3 r6.x, r4, c4
mov r6.w, c33.x
mov r0.w, c33.x
mov r0.xyz, v2
mad r1, r0, c32.x, v0
dp4 r5.zw, r1, c5
add r2, -r5.z, c18
dp3 r5.z, r4, c5
dp3 r4.x, r4, c6
dp4 r4.w, r1, c4
mul r3, r5.z, r2
add r0, -r4.w, c17
mul r2, r2, r2
mov r6.z, r4.x
mov r6.y, r5.z
mad r3, r6.x, r0, r3
dp4 r5.xy, r1, c6
mad r2, r0, r0, r2
add r0, -r5.x, c19
mad r2, r0, r0, r2
mad r0, r4.x, r0, r3
mul r3, r2, c20
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.w, r2.w
rsq r2.z, r2.z
mul r0, r0, r2
add r2, r3, c33.x
dp4 r3.z, r6, c27
dp4 r3.y, r6, c26
dp4 r3.x, r6, c25
dp4 r3.w, r1, c3
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c33.z
mul r0, r0, r2
mul r2.xyz, r0.y, c22
mad r2.xyz, r0.x, c21, r2
mad r0.xyz, r0.z, c23, r2
mad r2.xyz, r0.w, c24, r0
mul r0, r6.xyzz, r6.yzzx
mul r2.w, r5.z, r5.z
dp4 r4.z, r0, c30
dp4 r4.y, r0, c29
dp4 r4.x, r0, c28
mad r2.w, r6.x, r6.x, -r2
add r3.xyz, r3, r4
mul r0.xyz, r2.w, c31
add r4.xyz, r3, r0
add oT3.xyz, r4, r2
dp4 r3.z, r1, c2
mov r2.xyz, v1
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
mul r0.xyz, r3.xyww, c33.y
mul r0.y, r0, c12.x
mad oT0.xy, r0.z, c13.zwzw, r0
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r4.xyz, r2, v1.w
mov r2, c8
mov r0, c10
dp4 r6.z, c16, r0
mov r0, c9
dp4 r6.y, c16, r0
dp4 r6.x, c16, r2
mov r0.xyz, c15
mov r0.w, c33.x
dp3 oT2.y, r6, r4
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c14.w, -r1
dp3 oT4.y, r4, r0
mov r4.x, r5.w
mov r4.y, r5
mov oPos, r3
mov oT0.zw, r3
dp3 oT4.z, v2, r0
dp3 oT4.x, v1, r0
mov oT1.xyz, r4.wxyw
dp3 oT2.z, v2, r6
dp3 oT2.x, r6, v1
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Float 32 [_normal_off]
"!!ARBvp1.0
# 87 ALU
PARAM c[33] = { { 1, 0.5, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MUL R4.xyz, vertex.normal, c[14].w;
DP3 R6.x, R4, c[5];
MOV R6.w, c[0].x;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R1, R0, c[32].x, vertex.position;
DP4 R5.zw, R1, c[6];
DP4 R4.w, R1, c[5];
ADD R2, -R5.z, c[18];
DP3 R5.z, R4, c[6];
DP3 R4.x, R4, c[7];
MUL R3, R5.z, R2;
ADD R0, -R4.w, c[17];
MUL R2, R2, R2;
MOV R6.z, R4.x;
MOV R6.y, R5.z;
MAD R3, R6.x, R0, R3;
DP4 R5.xy, R1, c[7];
MAD R2, R0, R0, R2;
ADD R0, -R5.x, c[19];
MAD R2, R0, R0, R2;
MAD R0, R4.x, R0, R3;
MUL R3, R2, c[20];
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.w, R2.w;
RSQ R2.z, R2.z;
MUL R0, R0, R2;
ADD R2, R3, c[0].x;
DP4 R3.z, R6, c[27];
DP4 R3.y, R6, c[26];
DP4 R3.x, R6, c[25];
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[22];
MAD R2.xyz, R0.x, c[21], R2;
MAD R0.xyz, R0.z, c[23], R2;
MAD R2.xyz, R0.w, c[24], R0;
MUL R0, R6.xyzz, R6.yzzx;
MUL R2.w, R5.z, R5.z;
DP4 R4.z, R0, c[30];
DP4 R4.y, R0, c[29];
DP4 R4.x, R0, c[28];
MAD R2.w, R6.x, R6.x, -R2;
MUL R0.xyz, R2.w, c[31];
ADD R3.xyz, R3, R4;
ADD R4.xyz, R3, R0;
ADD result.texcoord[3].xyz, R4, R2;
DP4 R0.w, R1, c[4];
MOV R2.w, c[0].x;
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R3.xyz, R0.xyww, c[0].y;
DP4 R0.z, R1, c[3];
MOV R2.x, R3;
MUL R2.y, R3, c[13].x;
ADD R3.xy, R2, R3.z;
MOV R2.xyz, c[15];
MOV R3.zw, R0;
DP4 R6.z, R2, c[11];
DP4 R6.y, R2, c[10];
DP4 R6.x, R2, c[9];
MAD R1.xyz, R6, c[14].w, -R1;
MOV R4.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R4.yzxw;
MAD R4.xyz, vertex.normal.yzxw, R4.zxyw, -R2;
MOV R2, c[16];
MUL R4.xyz, R4, vertex.attrib[14].w;
DP4 R6.z, R2, c[11];
DP4 R6.y, R2, c[10];
DP4 R6.x, R2, c[9];
DP3 result.texcoord[2].y, R6, R4;
DP3 result.texcoord[4].y, R4, R1;
MOV R4.x, R5.w;
MOV R4.y, R5;
MOV result.texcoord[0], R3;
MOV result.texcoord[5], R3;
MOV result.position, R0;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
MOV result.texcoord[1].xyz, R4.wxyw;
DP3 result.texcoord[2].z, vertex.normal, R6;
DP3 result.texcoord[2].x, R6, vertex.attrib[14];
END
# 87 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Float 32 [_normal_off]
"vs_2_0
; 90 ALU
def c33, 1.00000000, 0.50000000, 0.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r4.xyz, v2, c14.w
dp3 r6.x, r4, c4
mov r6.w, c33.x
mov r0.w, c33.x
mov r0.xyz, v2
mad r1, r0, c32.x, v0
dp4 r5.zw, r1, c5
dp4 r4.w, r1, c4
add r2, -r5.z, c18
dp3 r5.z, r4, c5
dp3 r4.x, r4, c6
mul r3, r5.z, r2
add r0, -r4.w, c17
mul r2, r2, r2
mov r6.z, r4.x
mov r6.y, r5.z
mad r3, r6.x, r0, r3
dp4 r5.xy, r1, c6
mad r2, r0, r0, r2
add r0, -r5.x, c19
mad r2, r0, r0, r2
mad r0, r4.x, r0, r3
mul r3, r2, c20
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.w, r2.w
rsq r2.z, r2.z
mul r0, r0, r2
add r2, r3, c33.x
mov r3.w, c33.x
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c33.z
mul r0, r0, r2
mul r2.xyz, r0.y, c22
mad r2.xyz, r0.x, c21, r2
mad r0.xyz, r0.z, c23, r2
mad r2.xyz, r0.w, c24, r0
mul r0, r6.xyzz, r6.yzzx
mul r2.w, r5.z, r5.z
dp4 r4.z, r0, c30
dp4 r4.y, r0, c29
dp4 r4.x, r0, c28
mad r2.w, r6.x, r6.x, -r2
mul r0.xyz, r2.w, c31
dp4 r0.w, r1, c3
dp4 r3.z, r6, c27
dp4 r3.y, r6, c26
dp4 r3.x, r6, c25
add r3.xyz, r3, r4
add r4.xyz, r3, r0
add oT3.xyz, r4, r2
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r3.xyz, r0.xyww, c33.y
mov r2.x, r3
mul r2.y, r3, c12.x
mad r2.xy, r3.z, c13.zwzw, r2
mov r3.xyz, c15
mov r2.zw, r0
dp4 r4.z, r3, c10
dp4 r4.y, r3, c9
dp4 r4.x, r3, c8
mad r6.xyz, r4, c14.w, -r1
mov r3.xyz, v1
mov r1.xyz, v1
mul r3.xyz, v2.zxyw, r3.yzxw
mad r3.xyz, v2.yzxw, r1.zxyw, -r3
mul r4.xyz, r3, v1.w
mov r1, c10
dp4 r7.z, c16, r1
mov r1, c9
mov r3, c8
dp4 r7.y, c16, r1
dp4 r7.x, c16, r3
dp3 oT2.y, r7, r4
dp3 oT4.y, r4, r6
mov r4.x, r5.w
mov r4.y, r5
mov oT0, r2
mov oT5, r2
mov oPos, r0
dp3 oT4.z, v2, r6
dp3 oT4.x, v1, r6
mov oT1.xyz, r4.wxyw
dp3 oT2.z, v2, r7
dp3 oT2.x, r7, v1
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_normal_off]
"!!ARBvp1.0
# 37 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MOV R1, c[19];
MUL R2.xyz, R2, vertex.attrib[14].w;
MOV R0.w, c[0].x;
MOV R0.xyz, c[18];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R4.z, R1, c[11];
DP4 R4.x, R1, c[9];
DP4 R4.y, R1, c[10];
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R0, R0, c[20].x, vertex.position;
MAD R1.xyz, R4, c[17].w, -R0;
MAD R3.xyz, R3, c[17].w, -R0;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[2].y, R2, R3;
DP4 R1.w, R0, c[8];
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MOV R1.xyz, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[0].xyz, R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 37 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_normal_off]
"vs_2_0
; 40 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mov r0.w, c20.x
mov r0.xyz, v2
mad r1, r0, c19.x, v0
mad r4.xyz, r2, c16.w, -r1
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r2, c8
dp4 r5.x, c18, r2
mov r0, c10
dp4 r5.z, c18, r0
mov r0, c9
dp4 r5.y, c18, r0
mad r0.xyz, r5, c16.w, -r1
dp4 r0.w, r1, c7
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
dp3 oT1.y, r0, r3
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
mov r0.xyz, r2
dp3 oT2.y, r3, r4
dp3 oT2.z, v2, r4
dp3 oT2.x, v1, r4
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT0.xyz, r2
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Float 16 [_normal_off]
"!!ARBvp1.0
# 30 ALU
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MOV R1, c[15];
MOV R0.w, c[0].x;
MOV R0.xyz, c[14];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R4.z, R1, c[11];
DP4 R4.y, R1, c[10];
DP4 R4.x, R1, c[9];
MUL R2.xyz, R2, vertex.attrib[14].w;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R0, R0, c[16].x, vertex.position;
MAD R3.xyz, R3, c[13].w, -R0;
DP3 result.texcoord[1].y, R4, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP3 result.texcoord[1].z, vertex.normal, R4;
DP3 result.texcoord[1].x, R4, vertex.attrib[14];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
DP4 result.texcoord[0].z, R0, c[7];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
END
# 30 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Float 15 [_normal_off]
"vs_2_0
; 33 ALU
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c16.x
mov r0.xyz, c13
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mov r1.xyz, v1
mov r0.w, c16.x
mov r0.xyz, v2
mad r0, r0, c15.x, v0
mad r4.xyz, r2, c12.w, -r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r1, c10
dp4 r5.z, c14, r1
mov r1, c9
mov r2, c8
dp4 r5.y, c14, r1
dp4 r5.x, c14, r2
dp3 oT1.y, r5, r3
dp3 oT2.y, r3, r4
dp3 oT2.z, v2, r4
dp3 oT2.x, v1, r4
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp4 oT0.z, r0, c6
dp4 oT0.y, r0, c5
dp4 oT0.x, r0, c4
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_normal_off]
"!!ARBvp1.0
# 38 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MOV R1, c[19];
MUL R2.xyz, R2, vertex.attrib[14].w;
MOV R0.w, c[0].x;
MOV R0.xyz, c[18];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R4.z, R1, c[11];
DP4 R4.x, R1, c[9];
DP4 R4.y, R1, c[10];
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R0, R0, c[20].x, vertex.position;
MAD R1.xyz, R4, c[17].w, -R0;
MAD R3.xyz, R3, c[17].w, -R0;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[2].y, R2, R3;
DP4 R1.w, R0, c[8];
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MOV R1.xyz, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[3].w, R1, c[16];
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[0].xyz, R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 38 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_normal_off]
"vs_2_0
; 41 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mov r0.w, c20.x
mov r0.xyz, v2
mad r1, r0, c19.x, v0
mad r4.xyz, r2, c16.w, -r1
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r2, c8
dp4 r5.x, c18, r2
mov r0, c10
dp4 r5.z, c18, r0
mov r0, c9
dp4 r5.y, c18, r0
mad r0.xyz, r5, c16.w, -r1
dp4 r0.w, r1, c7
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
dp3 oT1.y, r0, r3
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
mov r0.xyz, r2
dp3 oT2.y, r3, r4
dp3 oT2.z, v2, r4
dp3 oT2.x, v1, r4
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT0.xyz, r2
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_normal_off]
"!!ARBvp1.0
# 37 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MOV R1, c[19];
MUL R2.xyz, R2, vertex.attrib[14].w;
MOV R0.w, c[0].x;
MOV R0.xyz, c[18];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R4.z, R1, c[11];
DP4 R4.x, R1, c[9];
DP4 R4.y, R1, c[10];
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R0, R0, c[20].x, vertex.position;
MAD R1.xyz, R4, c[17].w, -R0;
MAD R3.xyz, R3, c[17].w, -R0;
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[2].y, R2, R3;
DP4 R1.w, R0, c[8];
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MOV R1.xyz, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[3].z, R1, c[15];
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[0].xyz, R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 37 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_normal_off]
"vs_2_0
; 40 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mov r0.w, c20.x
mov r0.xyz, v2
mad r1, r0, c19.x, v0
mad r4.xyz, r2, c16.w, -r1
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r2, c8
dp4 r5.x, c18, r2
mov r0, c10
dp4 r5.z, c18, r0
mov r0, c9
dp4 r5.y, c18, r0
mad r0.xyz, r5, c16.w, -r1
dp4 r0.w, r1, c7
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
dp3 oT1.y, r0, r3
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
mov r0.xyz, r2
dp3 oT2.y, r3, r4
dp3 oT2.z, v2, r4
dp3 oT2.x, v1, r4
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
mov oT0.xyz, r2
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_normal_off]
"!!ARBvp1.0
# 35 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
MOV R1, c[19];
MUL R2.xyz, R2, vertex.attrib[14].w;
DP4 R4.z, R1, c[11];
DP4 R4.y, R1, c[10];
DP4 R4.x, R1, c[9];
MOV R0.w, c[0].x;
MOV R0.xyz, c[18];
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP3 result.texcoord[1].y, R4, R2;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R0, R0, c[20].x, vertex.position;
MAD R3.xyz, R3, c[17].w, -R0;
DP3 result.texcoord[2].y, R2, R3;
DP4 R2.z, R0, c[7];
DP4 R2.x, R0, c[5];
DP4 R2.y, R0, c[6];
MOV R1.xyz, R2;
DP4 R1.w, R0, c[8];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[0].xyz, R2;
DP3 result.texcoord[1].z, vertex.normal, R4;
DP3 result.texcoord[1].x, R4, vertex.attrib[14];
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 35 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_normal_off]
"vs_2_0
; 38 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c20.x
mov r0.xyz, c17
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mov r1.xyz, v1
mov r0.w, c20.x
mov r0.xyz, v2
mad r0, r0, c19.x, v0
mad r4.xyz, r2, c16.w, -r0
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r2, c8
dp4 r5.x, c18, r2
mov r1, c10
dp4 r5.z, c18, r1
mov r1, c9
dp4 r5.y, c18, r1
dp4 r2.z, r0, c6
dp4 r2.x, r0, c4
dp4 r2.y, r0, c5
mov r1.xyz, r2
dp4 r1.w, r0, c7
dp3 oT1.y, r5, r3
dp3 oT2.y, r3, r4
dp3 oT2.z, v2, r4
dp3 oT2.x, v1, r4
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov oT0.xyz, r2
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 0 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[7];
MOV result.color, c[9].x;
KIL -R0.x;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 13 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c8.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 0 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[7];
MOV result.color, c[9].x;
KIL -R0.x;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 13 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c8.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 0 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[7];
MOV result.color, c[9].x;
KIL -R0.x;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 13 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c8.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 0 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[7];
MOV result.color, c[9].x;
KIL -R0.x;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 13 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c8.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 0 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[7];
MOV result.color, c[9].x;
KIL -R0.x;
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 13 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0, 0
dcl t0.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c8.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Float 10 [_normal_off]
"!!ARBvp1.0
# 26 ALU
PARAM c[11] = { { 1 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[9].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[9].w;
DP3 R0.y, R1, c[7];
MOV R1.w, c[0].x;
MOV R1.xyz, vertex.normal;
MAD R1, R1, c[10].x, vertex.position;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP4 result.texcoord[0].z, R1, c[7];
DP4 result.texcoord[0].y, R1, c[6];
DP4 result.texcoord[0].x, R1, c[5];
END
# 26 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Float 9 [_normal_off]
"vs_2_0
; 27 ALU
def c10, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul oT1.xyz, r0, c8.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c8.w
dp3 r0.y, r1, c6
mov r1.w, c10.x
mov r1.xyz, v2
mad r1, r1, c9.x, v0
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp4 oT0.z, r1, c6
dp4 oT0.y, r1, c5
dp4 oT0.x, r1, c4
"
}
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 15 ALU, 0 TEX
PARAM c[9] = { program.local[0..7],
		{ 0, 0.5 } };
TEMP R0;
MUL R0.x, fragment.texcoord[0].y, c[1].z;
MAD R0.x, fragment.texcoord[0], c[0].z, R0;
MOV R0.y, c[7].x;
MAD R0.x, fragment.texcoord[0].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[5], R0.y;
FRC R0.x, R0;
SLT R0.x, R0, c[6];
MOV R0.z, fragment.texcoord[3];
MOV R0.y, fragment.texcoord[2].z;
MOV result.color.w, c[8].x;
KIL -R0.x;
MOV R0.x, fragment.texcoord[1].z;
MAD result.color.xyz, R0, c[8].y, c[8].y;
END
# 15 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_World2Object]
Vector 4 [_Time]
Float 5 [_number]
Float 6 [_size]
Float 7 [_speed]
"ps_2_0
; 17 ALU, 1 TEX
def c8, 0.00000000, 1.00000000, 0.50000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
mul r0.z, t0.y, c1
mad r0.z, t0.x, c0, r0
mov r0.x, c4
mad r0.z, t0, c2, r0
add r0.z, r0, c3
mul r0.x, c7, r0
mad r0.x, r0.z, c5, r0
frc r0.x, r0
add r0.x, r0, -c6
cmp r0.x, r0, c8, c8.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0.z, t3
mov_pp r0.x, t1.z
mov_pp r0.y, t2.z
mad_pp r0.xyz, r0, c8.z, c8.z
mov_pp r0.w, c8.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
  Cull Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Float 18 [_normal_off]
"!!ARBvp1.0
# 35 ALU
PARAM c[19] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[13];
DP4 R2.y, R0, c[12];
DP4 R2.x, R0, c[11];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
ADD R3.xyz, R2, R3;
MAD R2.x, R0, R0, -R0.y;
MUL R4.xyz, R2.x, c[17];
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
MAD R1, R0, c[18].x, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[0].y;
DP4 R0.z, R1, c[3];
MUL R2.y, R2, c[9].x;
ADD R2.xy, R2, R2.z;
MOV R2.zw, R0;
ADD result.texcoord[3].xyz, R3, R4;
MOV result.texcoord[0], R2;
MOV result.texcoord[2], R2;
MOV result.position, R0;
DP4 result.texcoord[1].z, R1, c[7];
DP4 result.texcoord[1].y, R1, c[6];
DP4 result.texcoord[1].x, R1, c[5];
END
# 35 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Float 18 [_normal_off]
"vs_2_0
; 35 ALU
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
mul r1.xyz, v2, c10.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c19.x
dp4 r2.z, r0, c13
dp4 r2.y, r0, c12
dp4 r2.x, r0, c11
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
add r3.xyz, r2, r3
mad r2.x, r0, r0, -r0.y
mul r4.xyz, r2.x, c17
mov r0.xyz, v2
mov r0.w, c19.x
mad r1, r0, c18.x, v0
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c19.y
dp4 r0.z, r1, c2
mul r2.y, r2, c8.x
mad r2.xy, r2.z, c9.zwzw, r2
mov r2.zw, r0
add oT3.xyz, r3, r4
mov oT0, r2
mov oT2, r2
mov oPos, r0
dp4 oT1.z, r1, c6
dp4 oT1.y, r1, c5
dp4 oT1.x, r1, c4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"!!ARBvp1.0
# 25 ALU
PARAM c[17] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R2, R0, c[14].x, vertex.position;
DP4 R1.w, R2, c[8];
DP4 R1.x, R2, c[5];
DP4 R1.y, R2, c[6];
MUL R0.xyz, R1.xyww, c[0].y;
DP4 R1.z, R2, c[7];
MUL R0.y, R0, c[13].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[0], R0;
MOV result.texcoord[2], R0;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
MOV result.texcoord[1].xyz, R0;
ADD R0.xyz, R0, -c[16];
MUL result.texcoord[4].xyz, R0, c[16].w;
MOV R0.w, c[0].x;
ADD R0.y, R0.w, -c[16].w;
DP4 R0.x, R2, c[3];
MOV result.position, R1;
MUL result.texcoord[4].w, -R0.x, R0.y;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"vs_2_0
; 25 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
mov r0.w, c17.y
mov r0.xyz, v2
mad r2, r0, c14.x, v0
dp4 r1.w, r2, c7
dp4 r1.x, r2, c4
dp4 r1.y, r2, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, r2, c6
mul r0.y, r0, c12.x
mad r0.xy, r0.z, c13.zwzw, r0
mov r0.zw, r1
mov oT0, r0
mov oT2, r0
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
mov oT1.xyz, r0
add r0.xyz, r0, -c16
mul oT4.xyz, r0, c16.w
mov r0.w, c16
add r0.y, c17, -r0.w
dp4 r0.x, r2, c2
mov oPos, r1
mul oT4.w, -r0.x, r0.y
mad oT3.xy, v4, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Float 18 [_normal_off]
"!!ARBvp1.0
# 35 ALU
PARAM c[19] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[13];
DP4 R2.y, R0, c[12];
DP4 R2.x, R0, c[11];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
ADD R3.xyz, R2, R3;
MAD R2.x, R0, R0, -R0.y;
MUL R4.xyz, R2.x, c[17];
MOV R0.xyz, vertex.normal;
MOV R0.w, c[0].x;
MAD R1, R0, c[18].x, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[0].y;
DP4 R0.z, R1, c[3];
MUL R2.y, R2, c[9].x;
ADD R2.xy, R2, R2.z;
MOV R2.zw, R0;
ADD result.texcoord[3].xyz, R3, R4;
MOV result.texcoord[0], R2;
MOV result.texcoord[2], R2;
MOV result.position, R0;
DP4 result.texcoord[1].z, R1, c[7];
DP4 result.texcoord[1].y, R1, c[6];
DP4 result.texcoord[1].x, R1, c[5];
END
# 35 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Float 18 [_normal_off]
"vs_2_0
; 35 ALU
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
mul r1.xyz, v2, c10.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c19.x
dp4 r2.z, r0, c13
dp4 r2.y, r0, c12
dp4 r2.x, r0, c11
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
add r3.xyz, r2, r3
mad r2.x, r0, r0, -r0.y
mul r4.xyz, r2.x, c17
mov r0.xyz, v2
mov r0.w, c19.x
mad r1, r0, c18.x, v0
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c19.y
dp4 r0.z, r1, c2
mul r2.y, r2, c8.x
mad r2.xy, r2.z, c9.zwzw, r2
mov r2.zw, r0
add oT3.xyz, r3, r4
mov oT0, r2
mov oT2, r2
mov oPos, r0
dp4 oT1.z, r1, c6
dp4 oT1.y, r1, c5
dp4 oT1.x, r1, c4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"!!ARBvp1.0
# 25 ALU
PARAM c[17] = { { 1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.w, c[0].x;
MOV R0.xyz, vertex.normal;
MAD R2, R0, c[14].x, vertex.position;
DP4 R1.w, R2, c[8];
DP4 R1.x, R2, c[5];
DP4 R1.y, R2, c[6];
MUL R0.xyz, R1.xyww, c[0].y;
DP4 R1.z, R2, c[7];
MUL R0.y, R0, c[13].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[0], R0;
MOV result.texcoord[2], R0;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
MOV result.texcoord[1].xyz, R0;
ADD R0.xyz, R0, -c[16];
MUL result.texcoord[4].xyz, R0, c[16].w;
MOV R0.w, c[0].x;
ADD R0.y, R0.w, -c[16].w;
DP4 R0.x, R2, c[3];
MOV result.position, R1;
MUL result.texcoord[4].w, -R0.x, R0.y;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Float 14 [_normal_off]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"vs_2_0
; 25 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
mov r0.w, c17.y
mov r0.xyz, v2
mad r2, r0, c14.x, v0
dp4 r1.w, r2, c7
dp4 r1.x, r2, c4
dp4 r1.y, r2, c5
mul r0.xyz, r1.xyww, c17.x
dp4 r1.z, r2, c6
mul r0.y, r0, c12.x
mad r0.xy, r0.z, c13.zwzw, r0
mov r0.zw, r1
mov oT0, r0
mov oT2, r0
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
mov oT1.xyz, r0
add r0.xyz, r0, -c16
mul oT4.xyz, r0, c16.w
mov r0.w, c16
add r0.y, c17, -r0.w
dp4 r0.x, r2, c2
mov oPos, r1
mul oT4.w, -r0.x, r0.y
mad oT3.xy, v4, c15, c15.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 1 TEX
PARAM c[10] = { program.local[0..9] };
TEMP R0;
MUL R0.x, fragment.texcoord[1].y, c[1].z;
MAD R0.x, fragment.texcoord[1], c[0].z, R0;
MOV R0.y, c[8].x;
MAD R0.x, fragment.texcoord[1].z, c[2].z, R0;
MUL R0.y, R0, c[4].x;
ADD R0.x, R0, c[3].z;
MAD R0.x, R0, c[6], R0.y;
FRC R0.y, R0.x;
SLT R0.z, R0.y, c[7].x;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
MOV R0.w, c[9].x;
MOV result.color.w, c[5];
KIL -R0.z;
TEX R0.xyz, R0, texture[0], 2D;
MAD result.color.xyz, R0.w, c[5], R0;
END
# 16 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Matrix 0 [_World2Object]
Vector 4 [_Time]
Vector 5 [_Color]
Float 6 [_number]
Float 7 [_size]
Float 8 [_speed]
Float 9 [_col_blend]
SetTexture 0 [_GrabTexture] 2D
"ps_2_0
; 17 ALU, 2 TEX
dcl_2d s0
def c10, 0.00000000, 1.00000000, 0, 0
dcl t0.xyzw
dcl t1.xyz
mul r0.z, t1.y, c1
mad r0.z, t1.x, c0, r0
mov r0.x, c4
mad r0.z, t1, c2, r0
add r0.z, r0, c3
mul r0.x, c8, r0
mad r0.x, r0.z, c6, r0
frc r0.x, r0
add r1.x, r0, -c7
rcp r0.x, t0.w
cmp r1.x, r1, c10, c10.y
mov_pp r1, -r1.x
mul r0.xy, t0, r0.x
texld r0, r0, s0
texkill r1.xyzw
mov r1.xyz, c5
mov_pp r0.w, c5
mad r0.xyz, c9.x, r1, r0
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}