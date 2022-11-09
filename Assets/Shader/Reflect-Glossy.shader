//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Reflective/Specular" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.01,1)) = 0.078125
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _Cube ("Reflection Cubemap", CUBE) = "_Skybox" { TexGen CubeReflect }
}
SubShader { 
 LOD 300
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[23] = { { 1, 2 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.w, R1, c[5];
MOV R0.x, R3.w;
MOV R0.y, R2.w;
MOV R0.z, c[0].x;
MUL R1, R0.wxyy, R0.xyyw;
DP4 R2.z, R0.wxyz, c[17];
DP4 R2.y, R0.wxyz, c[16];
DP4 R2.x, R0.wxyz, c[15];
DP4 R0.z, R1, c[20];
DP4 R0.x, R1, c[18];
DP4 R0.y, R1, c[19];
ADD R2.xyz, R2, R0;
MOV R1.w, c[0].x;
MOV R1.xyz, c[14];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R1.xyz, R0, c[13].w, -vertex.position;
MUL R0.y, R3.w, R3.w;
MAD R1.w, R0, R0, -R0.y;
DP3 R0.x, vertex.normal, -R1;
MUL R0.xyz, vertex.normal, R0.x;
MAD R0.xyz, -R0, c[0].y, -R1;
MUL R3.xyz, R1.w, c[21];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[3].xyz, R2, R3;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R0.w;
ADD result.texcoord[4].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Vector 21 [_MainTex_ST]
"vs_2_0
; 43 ALU
def c22, 1.00000000, 2.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.w, r1, c4
mov r0.x, r3.w
mov r0.y, r2.w
mov r0.z, c22.x
mul r1, r0.wxyy, r0.xyyw
dp4 r2.z, r0.wxyz, c16
dp4 r2.y, r0.wxyz, c15
dp4 r2.x, r0.wxyz, c14
dp4 r0.z, r1, c19
dp4 r0.x, r1, c17
dp4 r0.y, r1, c18
add r2.xyz, r2, r0
mov r1.w, c22.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c12.w, -v0
mul r0.y, r3.w, r3.w
mad r1.w, r0, r0, -r0.y
dp3 r0.x, v1, -r1
mul r0.xyz, v1, r0.x
mad r0.xyz, -r0, c22.y, -r1
mul r3.xyz, r1.w, c20
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add oT3.xyz, r2, r3
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r0.w
add oT4.xyz, -r0, c13
mad oT0.xy, v2, c21, c21.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 18 ALU
PARAM c[17] = { { 1, 2 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[13].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R1.xyz, vertex.normal, R0.w;
MAD R0.xyz, -R1, c[0].y, -R0;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 18 ALU
def c16, 1.00000000, 2.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, c13
mov r1.w, c16.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c12.w, -v0
dp3 r0.w, v1, -r0
mul r1.xyz, v1, r0.w
mad r0.xyz, -r1, c16.y, -r0
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
mad oT0.xy, v2, c15, c15.zwzw
mad oT2.xy, v3, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 25 ALU
PARAM c[17] = { { 1, 2 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R1.xyz, R0, c[13].w, -vertex.position;
DP3 R0.w, vertex.normal, -R1;
MUL R0.xyz, vertex.normal, R0.w;
MAD R0.xyz, -R0, c[0].y, -R1;
MUL R2.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP3 result.texcoord[3].y, R1, R2;
MOV result.texcoord[3].z, -R0.w;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 25 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
"vs_2_0
; 26 ALU
def c16, 1.00000000, 2.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mov r1.xyz, c13
mov r1.w, c16.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c12.w, -v0
dp3 r0.w, v2, -r0
mul r1.xyz, v2, r0.w
mad r1.xyz, -r1, c16.y, -r0
mul r2.xyz, r2, v1.w
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
dp3 oT3.y, r0, r2
mov oT3.z, -r0.w
dp3 oT3.x, r0, v1
mad oT0.xy, v3, c15, c15.zwzw
mad oT2.xy, v4, c14, c14.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 49 ALU
PARAM c[24] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[14].w;
DP3 R1.w, R0, c[6];
DP3 R0.w, R0, c[7];
DP3 R3.x, R0, c[5];
MOV R3.y, R1.w;
MOV R3.z, R0.w;
MUL R2, R3.xyzz, R3.yzzx;
MOV R3.w, c[0].x;
DP4 R0.z, R3, c[18];
DP4 R0.y, R3, c[17];
DP4 R0.x, R3, c[16];
DP4 R1.z, R2, c[21];
DP4 R1.x, R2, c[19];
DP4 R1.y, R2, c[20];
MOV R2.xyz, c[15];
ADD R1.xyz, R0, R1;
MOV R2.w, c[0].x;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R2.y, vertex.normal, -R0;
MUL R3.yzw, vertex.normal.xxyz, R2.y;
MAD R0.xyz, -R3.yzww, c[0].y, -R0;
MUL R2.x, R1.w, R1.w;
MAD R2.x, R3, R3, -R2;
MUL R2.xyz, R2.x, c[22];
ADD result.texcoord[3].xyz, R1, R2;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP4 R2.w, vertex.position, c[4];
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MUL R1.xyz, R2.xyww, c[0].z;
MOV R0.x, R1;
MUL R0.y, R1, c[13].x;
ADD result.texcoord[5].xy, R0, R1.z;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.position, R2;
MOV result.texcoord[5].zw, R2;
MOV result.texcoord[2].z, R0.w;
MOV result.texcoord[2].y, R1.w;
MOV result.texcoord[2].x, R3;
ADD result.texcoord[4].xyz, -R0, c[15];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"vs_2_0
; 49 ALU
def c24, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c14.w
dp3 r1.w, r0, c5
dp3 r0.w, r0, c6
dp3 r3.x, r0, c4
mov r3.y, r1.w
mov r3.z, r0.w
mul r2, r3.xyzz, r3.yzzx
mov r3.w, c24.x
dp4 r0.z, r3, c18
dp4 r0.y, r3, c17
dp4 r0.x, r3, c16
dp4 r1.z, r2, c21
dp4 r1.x, r2, c19
dp4 r1.y, r2, c20
mov r2.xyz, c15
add r1.xyz, r0, r1
mov r2.w, c24.x
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
mad r0.xyz, r0, c14.w, -v0
dp3 r2.y, v1, -r0
mul r3.yzw, v1.xxyz, r2.y
mad r0.xyz, -r3.yzww, c24.y, -r0
mul r2.x, r1.w, r1.w
mad r2.x, r3, r3, -r2
mul r2.xyz, r2.x, c22
add oT3.xyz, r1, r2
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
dp4 r2.w, v0, c3
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mul r1.xyz, r2.xyww, c24.z
mov r0.x, r1
mul r0.y, r1, c12.x
mad oT5.xy, r1.z, c13.zwzw, r0
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov oPos, r2
mov oT5.zw, r2
mov oT2.z, r0.w
mov oT2.y, r1.w
mov oT2.x, r3
add oT4.xyz, -r0, c15
mad oT0.xy, v2, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 23 ALU
PARAM c[18] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R1.xyz, vertex.normal, R0.w;
MAD R2.xyz, -R1, c[0].y, -R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[1].z, R2, c[7];
DP3 result.texcoord[1].y, R2, c[6];
DP3 result.texcoord[1].x, R2, c[5];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 23 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 23 ALU
def c18, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, c15
mov r1.w, c18.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c14.w, -v0
dp3 r0.w, v1, -r0
mul r1.xyz, v1, r0.w
mad r2.xyz, -r1, c18.y, -r0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.z
mul r1.y, r1, c12.x
dp3 oT1.z, r2, c6
dp3 oT1.y, r2, c5
dp3 oT1.x, r2, c4
mad oT3.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.xy, v2, c17, c17.zwzw
mad oT2.xy, v3, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[18] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R1.xyz, R0, c[14].w, -vertex.position;
DP3 R0.w, vertex.normal, -R1;
MUL R0.xyz, vertex.normal, R0.w;
MAD R0.xyz, -R0, c[0].y, -R1;
MUL R2.xyz, R2, vertex.attrib[14].w;
MOV result.texcoord[3].z, -R0.w;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP3 result.texcoord[3].y, R1, R2;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].z;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MOV R1.x, R2;
MUL R1.y, R2, c[13].x;
ADD result.texcoord[4].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 32 ALU
def c18, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mov r1.w, c18.x
mov r1.xyz, c15
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c14.w, -v0
dp3 r0.w, v2, -r0
mul r2.xyz, r2, v1.w
mul r1.xyz, v2, r0.w
mad r1.xyz, -r1, c18.y, -r0
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
dp3 oT3.y, r0, r2
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c18.z
dp3 oT3.x, r0, v1
mov r0.x, r2
mul r0.y, r2, c12.x
mov oT3.z, -r0.w
mad oT4.xy, r2.z, c13.zwzw, r0
mov oPos, r1
mov oT4.zw, r1
mad oT0.xy, v3, c17, c17.zwzw
mad oT2.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
"!!ARBvp1.0
# 72 ALU
PARAM c[31] = { { 1, 2, 0 },
		state.matrix.mvp,
		program.local[5..30] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[13].w;
DP3 R5.x, R3, c[5];
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[16];
DP3 R4.z, R3, c[6];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[15];
MUL R2, R2, R2;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
DP4 R4.xy, vertex.position, c[7];
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[17];
DP3 R4.x, R3, c[7];
MAD R2, R1, R1, R2;
MAD R0, R4.x, R1, R0;
MUL R1, R2, c[18];
ADD R1, R1, c[0].x;
MOV R5.z, R4.x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[25];
DP4 R2.y, R5, c[24];
DP4 R2.x, R5, c[23];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MUL R1, R5.xyzz, R5.yzzx;
MAD R0.xyz, R0.w, c[22], R0;
DP4 R3.z, R1, c[28];
DP4 R3.x, R1, c[26];
DP4 R3.y, R1, c[27];
ADD R3.xyz, R2, R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MUL R0.w, R4.z, R4.z;
MAD R1.w, R5.x, R5.x, -R0;
MAD R1.xyz, R2, c[13].w, -vertex.position;
DP3 R0.w, vertex.normal, -R1;
MUL R5.yzw, R1.w, c[29].xxyz;
ADD R3.xyz, R3, R5.yzww;
ADD result.texcoord[3].xyz, R3, R0;
MUL R2.xyz, vertex.normal, R0.w;
MAD R1.xyz, -R2, c[0].y, -R1;
MOV R3.x, R4.w;
MOV R3.y, R4;
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].z, R4.x;
MOV result.texcoord[2].y, R4.z;
MOV result.texcoord[2].x, R5;
ADD result.texcoord[4].xyz, -R3.wxyw, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[30], c[30].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 72 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Vector 29 [_MainTex_ST]
"vs_2_0
; 72 ALU
def c30, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c12.w
dp3 r5.x, r3, c4
dp4 r4.zw, v0, c5
add r2, -r4.z, c15
dp3 r4.z, r3, c5
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c14
mul r2, r2, r2
mov r5.y, r4.z
mov r5.w, c30.x
dp4 r4.xy, v0, c6
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c16
dp3 r4.x, r3, c6
mad r2, r1, r1, r2
mad r0, r4.x, r1, r0
mul r1, r2, c17
add r1, r1, c30.x
mov r5.z, r4.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c24
dp4 r2.y, r5, c23
dp4 r2.x, r5, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c30.z
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mul r1, r5.xyzz, r5.yzzx
mad r0.xyz, r0.w, c21, r0
dp4 r3.z, r1, c27
dp4 r3.x, r1, c25
dp4 r3.y, r1, c26
add r3.xyz, r2, r3
mov r1.w, c30.x
mov r1.xyz, c13
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
mul r0.w, r4.z, r4.z
mad r1.w, r5.x, r5.x, -r0
mad r1.xyz, r2, c12.w, -v0
dp3 r0.w, v1, -r1
mul r5.yzw, r1.w, c28.xxyz
add r3.xyz, r3, r5.yzww
add oT3.xyz, r3, r0
mul r2.xyz, v1, r0.w
mad r1.xyz, -r2, c30.y, -r1
mov r3.x, r4.w
mov r3.y, r4
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.z, r4.x
mov oT2.y, r4.z
mov oT2.x, r5
add oT4.xyz, -r3.wxyw, c13
mad oT0.xy, v2, c29, c29.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
"!!ARBvp1.0
# 78 ALU
PARAM c[32] = { { 1, 2, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[14].w;
DP3 R5.x, R3, c[5];
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[17];
DP3 R4.z, R3, c[6];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[16];
MUL R2, R2, R2;
MOV R5.y, R4.z;
MOV R5.w, c[0].x;
DP4 R4.xy, vertex.position, c[7];
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[18];
DP3 R4.x, R3, c[7];
MAD R2, R1, R1, R2;
MAD R0, R4.x, R1, R0;
MUL R1, R2, c[19];
ADD R1, R1, c[0].x;
MOV R5.z, R4.x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[26];
DP4 R2.y, R5, c[25];
DP4 R2.x, R5, c[24];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MUL R1, R5.xyzz, R5.yzzx;
MAD R0.xyz, R0.w, c[23], R0;
DP4 R3.z, R1, c[29];
DP4 R3.x, R1, c[27];
DP4 R3.y, R1, c[28];
ADD R3.xyz, R2, R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[15];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MUL R0.w, R4.z, R4.z;
MAD R1.w, R5.x, R5.x, -R0;
MAD R1.xyz, R2, c[14].w, -vertex.position;
DP3 R0.w, vertex.normal, -R1;
MUL R2.xyz, vertex.normal, R0.w;
MAD R1.xyz, -R2, c[0].y, -R1;
MUL R5.yzw, R1.w, c[30].xxyz;
ADD R3.xyz, R3, R5.yzww;
ADD result.texcoord[3].xyz, R3, R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].w;
DP3 result.texcoord[1].x, R1, c[5];
MOV R1.x, R2;
MUL R1.y, R2, c[13].x;
MOV R3.x, R4.w;
MOV R3.y, R4;
ADD result.texcoord[5].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[5].zw, R0;
MOV result.texcoord[2].z, R4.x;
MOV result.texcoord[2].y, R4.z;
MOV result.texcoord[2].x, R5;
ADD result.texcoord[4].xyz, -R3.wxyw, c[15];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
END
# 78 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c32, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c14.w
dp3 r5.x, r3, c4
dp4 r4.zw, v0, c5
add r2, -r4.z, c17
dp3 r4.z, r3, c5
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c16
mul r2, r2, r2
mov r5.y, r4.z
mov r5.w, c32.x
dp4 r4.xy, v0, c6
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c18
dp3 r4.x, r3, c6
mad r2, r1, r1, r2
mad r0, r4.x, r1, r0
mul r1, r2, c19
add r1, r1, c32.x
mov r5.z, r4.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c26
dp4 r2.y, r5, c25
dp4 r2.x, r5, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.z
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mul r1, r5.xyzz, r5.yzzx
mad r0.xyz, r0.w, c23, r0
dp4 r3.z, r1, c29
dp4 r3.x, r1, c27
dp4 r3.y, r1, c28
add r3.xyz, r2, r3
mov r1.w, c32.x
mov r1.xyz, c15
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
mul r0.w, r4.z, r4.z
mad r1.w, r5.x, r5.x, -r0
mad r1.xyz, r2, c14.w, -v0
dp3 r0.w, v1, -r1
mul r2.xyz, v1, r0.w
mad r1.xyz, -r2, c32.y, -r1
mul r5.yzw, r1.w, c30.xxyz
add r3.xyz, r3, r5.yzww
add oT3.xyz, r3, r0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c32.w
dp3 oT1.x, r1, c4
mov r1.x, r2
mul r1.y, r2, c12.x
mov r3.x, r4.w
mov r3.y, r4
mad oT5.xy, r2.z, c13.zwzw, r1
mov oPos, r0
mov oT5.zw, r0
mov oT2.z, r4.x
mov oT2.y, r4.z
mov oT2.x, r5
add oT4.xyz, -r3.wxyw, c15
mad oT0.xy, v2, c31, c31.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Vector 4 [_ReflectColor]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 29 ALU, 2 TEX
PARAM c[7] = { program.local[0..5],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
DP3 R3.x, fragment.texcoord[2], c[0];
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.x, R2.x;
MAD R2.xyz, R2.x, fragment.texcoord[4], c[0];
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R2.x, fragment.texcoord[2], R2;
MOV R2.w, c[6].y;
MUL R0, R0, R1.w;
MUL R2.y, R2.w, c[5].x;
MAX R2.x, R2, c[6];
POW R2.x, R2.x, R2.y;
MUL R3.w, R1, R2.x;
MOV R2, c[2];
MUL R1.xyz, R1, c[3];
MAX R4.x, R3, c[6];
MUL R3.xyz, R1, c[1];
MUL R3.xyz, R3, R4.x;
MUL R2.xyz, R2, c[1];
MAD R2.xyz, R2, R3.w, R3;
MUL R2.xyz, R2, c[6].z;
MAD R1.xyz, R1, fragment.texcoord[3], R2;
MAD result.color.xyz, R0, c[4], R1;
MUL R0.y, R0.w, c[4].w;
MUL R0.x, R2.w, c[1].w;
MAD result.color.w, R3, R0.x, R0.y;
END
# 29 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Vector 4 [_ReflectColor]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
"ps_2_0
; 32 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c6, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r2, t1, s1
texld r3, t0, s0
dp3_pp r0.x, t4, t4
rsq_pp r0.x, r0.x
mad_pp r1.xyz, r0.x, t4, c0
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r1.x, t2, r1
mov_pp r0.x, c5
mul_pp r0.x, c6.y, r0
max_pp r1.x, r1, c6
pow r4.w, r1.x, r0.x
mov r0.x, r4.w
mul_pp r3.xyz, r3, c3
dp3_pp r1.x, t2, c0
mul r0.x, r3.w, r0
mul_pp r4.xyz, r3, c1
max_pp r1.x, r1, c6
mul_pp r1.xyz, r4, r1.x
mov_pp r5.xyz, c1
mul_pp r4.xyz, c2, r5
mad r1.xyz, r4, r0.x, r1
mul r1.xyz, r1, c6.z
mul_pp r4, r2, r3.w
mad_pp r3.xyz, r3, t3, r1
mov_pp r0.w, c1
mul_pp r1.x, r4.w, c4.w
mul_pp r2.x, c2.w, r0.w
mad r0.w, r0.x, r2.x, r1.x
mad_pp r0.xyz, r4, c4, r3
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
MUL R0, R1.w, R0;
MUL R0, R0, c[1];
MUL R1.xyz, R1, c[0];
MUL R2.xyz, R2.w, R2;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R1, c[2].x, R0;
MOV result.color.w, R0;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 8 ALU, 3 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
def c2, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xy
texld r0, t2, s2
texld r1, t1, s1
texld r2, t0, s0
mul_pp r1, r2.w, r1
mul_pp r1, r1, c1
mul_pp r0.xyz, r0.w, r0
mul_pp r2.xyz, r2, c0
mul_pp r0.xyz, r0, r2
mov_pp r0.w, r1
mad_pp r0.xyz, r0, c2.x, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 4 TEX
PARAM c[7] = { program.local[0..3],
		{ 8, -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
TEX R2, fragment.texcoord[2], texture[2], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
MUL R2.xyz, R2.w, R2;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].x;
MUL R4.xyz, R3.y, c[6];
MAD R4.xyz, R3.x, c[5], R4;
MAD R3.xyz, R3.z, c[4].yzww, R4;
DP3 R3.w, R3, R3;
RSQ R4.x, R3.w;
MUL R0, R0, R1.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
MOV R2.w, c[5];
RSQ R3.w, R3.w;
MUL R3.xyz, R4.x, R3;
MAD R3.xyz, R3.w, fragment.texcoord[3], R3;
DP3 R3.x, R3, R3;
RSQ R3.x, R3.x;
MUL R3.x, R3, R3.z;
MAX R3.w, R3.x, c[5].y;
MUL R2.xyz, R2, c[4].x;
MUL R2.w, R2, c[3].x;
MUL R3.xyz, R2, c[0];
POW R2.w, R3.w, R2.w;
MUL R3.xyz, R1.w, R3;
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MAD result.color.xyz, R0, c[2], R1;
MUL result.color.w, R0, c[2];
END
# 32 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"ps_2_0
; 35 ALU, 4 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
def c4, 8.00000000, -0.40824831, 0.70710677, 0.57735026
def c5, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
texld r4, t1, s1
texld r3, t0, s0
texld r0, t2, s3
texld r2, t2, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c4.x
mov r0.x, c4.y
mov r0.z, c4.w
mov r0.y, c4.z
mul r0.xyz, r1.y, r0
mad r0.xyz, r1.x, c5, r0
mad r5.xyz, r1.z, c6, r0
dp3 r0.x, r5, r5
rsq r1.x, r0.x
dp3_pp r0.x, t3, t3
mul r1.xyz, r1.x, r5
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t3, r1
dp3_pp r0.x, r0, r0
rsq_pp r0.x, r0.x
mul_pp r0.z, r0.x, r0
mov_pp r1.x, c3
max_pp r0.x, r0.z, c5.y
mul_pp r1.x, c5.w, r1
pow r5.x, r0.x, r1.x
mul_pp r0.xyz, r2.w, r2
mul_pp r1.xyz, r0, c4.x
mul_pp r2.xyz, r1, c0
mul_pp r2.xyz, r3.w, r2
mov r0.x, r5.x
mul r0.xyz, r2, r0.x
mul_pp r2, r4, r3.w
mul_pp r3.xyz, r3, c1
mad_pp r0.xyz, r3, r1, r0
mul_pp r0.w, r2, c2
mad_pp r0.xyz, r2, c2, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Vector 4 [_ReflectColor]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 3 TEX
PARAM c[7] = { program.local[0..5],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
TXP R4.x, fragment.texcoord[5], texture[2], 2D;
DP3 R2.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.x, R2.x;
MAD R2.xyz, R2.x, fragment.texcoord[4], c[0];
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R2.x, fragment.texcoord[2], R2;
MOV R2.w, c[6].y;
MUL R0, R0, R1.w;
MUL R2.y, R2.w, c[5].x;
MAX R2.x, R2, c[6];
POW R3.x, R2.x, R2.y;
MUL R3.w, R1, R3.x;
MOV R2, c[2];
DP3 R3.x, fragment.texcoord[2], c[0];
MAX R4.y, R3.x, c[6].x;
MUL R1.xyz, R1, c[3];
MUL R3.xyz, R1, c[1];
MUL R3.xyz, R3, R4.y;
MUL R2.xyz, R2, c[1];
MUL R4.y, R4.x, c[6].z;
MAD R2.xyz, R2, R3.w, R3;
MUL R2.xyz, R2, R4.y;
MAD R1.xyz, R1, fragment.texcoord[3], R2;
MAD result.color.xyz, R0, c[4], R1;
MUL R0.x, R2.w, c[1].w;
MUL R0.y, R0.w, c[4].w;
MUL R0.x, R3.w, R0;
MAD result.color.w, R4.x, R0.x, R0.y;
END
# 32 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_Color]
Vector 4 [_ReflectColor]
Float 5 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
"ps_2_0
; 34 ALU, 3 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
def c6, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5
texld r3, t1, s1
texld r2, t0, s0
texldp r5, t5, s2
dp3_pp r0.x, t4, t4
rsq_pp r0.x, r0.x
mad_pp r1.xyz, r0.x, t4, c0
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r1.x, t2, r1
mov_pp r0.x, c5
mul_pp r0.x, c6.y, r0
max_pp r1.x, r1, c6
pow r4.w, r1.x, r0.x
mov r0.x, r4.w
mul_pp r4.xyz, r2, c3
dp3_pp r2.x, t2, c0
mul_pp r6.xyz, r4, c1
max_pp r2.x, r2, c6
mul r0.x, r2.w, r0
mul_pp r2.xyz, r6, r2.x
mov_pp r7.xyz, c1
mul_pp r6.xyz, c2, r7
mad r2.xyz, r6, r0.x, r2
mul_pp r1.x, r5, c6.z
mul r1.xyz, r2, r1.x
mul_pp r3, r3, r2.w
mad_pp r4.xyz, r4, t3, r1
mov_pp r0.w, c1
mul_pp r1.x, c2.w, r0.w
mul r0.x, r0, r1
mul_pp r2.x, r3.w, c4.w
mad r0.w, r5.x, r0.x, r2.x
mad_pp r0.xyz, r3, c4, r4
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], CUBE;
TXP R2.x, fragment.texcoord[3], texture[2], 2D;
TEX R3, fragment.texcoord[2], texture[3], 2D;
MUL R2.yzw, R3.xxyz, R2.x;
MUL R3.xyz, R3.w, R3;
MUL R1, R0.w, R1;
MUL R1, R1, c[1];
MUL R3.xyz, R3, c[2].x;
MUL R2.yzw, R2, c[2].y;
MIN R2.yzw, R3.xxyz, R2;
MUL R3.xyz, R3, R2.x;
MAX R2.xyz, R2.yzww, R3;
MUL R0.xyz, R0, c[0];
MAD result.color.xyz, R0, R2, R1;
MOV result.color.w, R1;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 13 ALU, 4 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
def c2, 8.00000000, 2.00000000, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xy
dcl t3
texld r2, t0, s0
texld r1, t1, s1
texldp r3, t3, s2
texld r0, t2, s3
mul_pp r1, r2.w, r1
mul_pp r4.xyz, r0, r3.x
mul_pp r0.xyz, r0.w, r0
mul_pp r1, r1, c1
mul_pp r0.xyz, r0, c2.x
mul_pp r4.xyz, r4, c2.y
min_pp r4.xyz, r0, r4
mul_pp r0.xyz, r0, r3.x
max_pp r0.xyz, r4, r0
mul_pp r2.xyz, r2, c0
mov_pp r0.w, r1
mad_pp r0.xyz, r2, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 38 ALU, 5 TEX
PARAM c[8] = { program.local[0..3],
		{ 8, 2, 0, 128 },
		{ -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R3, fragment.texcoord[2], texture[4], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
TEX R2, fragment.texcoord[2], texture[3], 2D;
TXP R4.x, fragment.texcoord[4], texture[2], 2D;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].x;
MUL R5.xyz, R3.y, c[7];
MAD R5.xyz, R3.x, c[6], R5;
MAD R3.xyz, R3.z, c[5], R5;
DP3 R3.w, R3, R3;
RSQ R4.y, R3.w;
MUL R0, R0, R1.w;
DP3 R3.w, fragment.texcoord[3], fragment.texcoord[3];
MUL R3.xyz, R4.y, R3;
RSQ R3.w, R3.w;
MAD R3.xyz, R3.w, fragment.texcoord[3], R3;
DP3 R3.x, R3, R3;
RSQ R3.x, R3.x;
MUL R3.x, R3, R3.z;
MAX R3.w, R3.x, c[4].z;
MUL R3.xyz, R2.w, R2;
MUL R3.xyz, R3, c[4].x;
MUL R5.xyz, R3, c[0];
MUL R4.yzw, R1.w, R5.xxyz;
MUL R5.xyz, R2, R4.x;
MOV R2.w, c[4];
MUL R2.w, R2, c[3].x;
POW R2.w, R3.w, R2.w;
MUL R2.xyz, R4.yzww, R2.w;
MUL R4.xyz, R3, R4.x;
MUL R5.xyz, R5, c[4].y;
MIN R3.xyz, R3, R5;
MAX R3.xyz, R3, R4;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R3, R2;
MAD result.color.xyz, R0, c[2], R1;
MUL result.color.w, R0, c[2];
END
# 38 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 37 ALU, 5 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 8.00000000, 2.00000000, 0.00000000, 128.00000000
def c5, -0.40824831, 0.70710677, 0.57735026, 0
def c6, 0.81649655, 0.00000000, 0.57735026, 0
def c7, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xy
dcl t3.xyz
dcl t4
texld r3, t1, s1
texld r2, t0, s0
texldp r6, t4, s2
texld r0, t2, s4
texld r4, t2, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c4.x
mul r1.xyz, r0.y, c5
mad r1.xyz, r0.x, c6, r1
mad r5.xyz, r0.z, c7, r1
dp3 r0.x, r5, r5
rsq r1.x, r0.x
dp3_pp r0.x, t3, t3
mul_pp r3, r3, r2.w
mul r1.xyz, r1.x, r5
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t3, r1
dp3_pp r0.x, r0, r0
rsq_pp r1.x, r0.x
mul_pp r0.z, r1.x, r0
mov_pp r0.x, c3
max_pp r1.x, r0.z, c4.z
mul_pp r0.x, c4.w, r0
pow r5.x, r1.x, r0.x
mul_pp r0.xyz, r4.w, r4
mul_pp r1.xyz, r4, r6.x
mul_pp r4.xyz, r0, c4.x
mul_pp r0.xyz, r1, c4.y
min_pp r0.xyz, r4, r0
mul_pp r1.xyz, r4, r6.x
mul_pp r4.xyz, r4, c0
max_pp r1.xyz, r0, r1
mov r0.x, r5.x
mul_pp r4.xyz, r2.w, r4
mul r0.xyz, r4, r0.x
mul_pp r2.xyz, r2, c1
mad_pp r0.xyz, r2, r1, r0
mul_pp r0.w, r3, c2
mad_pp r0.xyz, r3, c2, r0
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 18 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 18 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [_MainTex_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP3 result.texcoord[1].x, R0, c[5];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MOV result.texcoord[2].xyz, c[11];
ADD result.texcoord[3].xyz, -R0, c[10];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [_MainTex_ST]
"vs_2_0
; 14 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c8.w
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp3 oT1.x, r0, c4
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mov oT2.xyz, c10
add oT3.xyz, -r0, c9
mad oT0.xy, v2, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 19 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 19 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.w, r0, c11
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 18 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
ADD result.texcoord[2].xyz, -R0, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 18 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
add oT2.xyz, -r0, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 17 ALU
PARAM c[17] = { program.local[0],
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
MOV result.texcoord[2].xyz, c[15];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [_MainTex_ST]
"vs_2_0
; 17 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
mov oT2.xyz, c14
add oT3.xyz, -r0, c13
mad oT0.xy, v2, c15, c15.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 4 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 29 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
DP3 R1.x, fragment.texcoord[4], fragment.texcoord[4];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.xyz, R0, c[2];
RSQ R2.x, R2.x;
MOV result.color.w, c[5].x;
TEX R1.w, R1.x, texture[2], 2D;
DP3 R1.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, fragment.texcoord[2];
MAD R2.xyz, R2.x, fragment.texcoord[3], R1;
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R2.x, fragment.texcoord[1], R2;
MOV R2.w, c[5].y;
MUL R2.y, R2.w, c[4].x;
MAX R2.x, R2, c[5];
POW R2.x, R2.x, R2.y;
MUL R0.w, R2.x, R0;
DP3 R2.x, fragment.texcoord[1], R1;
MUL R1.xyz, R0, c[0];
MAX R2.x, R2, c[5];
MOV R0.xyz, c[1];
MUL R1.xyz, R1, R2.x;
MUL R0.xyz, R0, c[0];
MUL R1.w, R1, c[5].z;
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, R1.w;
END
# 29 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 32 ALU, 2 TEX
dcl_2d s0
dcl_2d s2
def c4, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r2, t0, s0
dp3 r0.x, t4, t4
mov r0.xy, r0.x
mul_pp r2.xyz, r2, c2
mul_pp r2.xyz, r2, c0
mov_pp r0.w, c4.x
texld r5, r0, s2
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
dp3_pp r0.x, t3, t3
mul_pp r4.xyz, r1.x, t2
rsq_pp r0.x, r0.x
mad_pp r1.xyz, r0.x, t3, r4
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
mov_pp r0.x, c3
dp3_pp r1.x, t1, r1
mul_pp r0.x, c4.y, r0
max_pp r1.x, r1, c4
pow r3.w, r1.x, r0.x
mov r0.x, r3.w
dp3_pp r1.x, t1, r4
max_pp r1.x, r1, c4
mul_pp r3.xyz, r2, r1.x
mov_pp r2.xyz, c0
mul r0.x, r0, r2.w
mul_pp r2.xyz, c1, r2
mul_pp r1.x, r5, c4.z
mad r0.xyz, r2, r0.x, r3
mul r0.xyz, r0, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 4 [_Shininess]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 1 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
MOV R1.xyz, fragment.texcoord[2];
RSQ R1.w, R1.w;
MAD R2.xyz, R1.w, fragment.texcoord[3], R1;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
MOV R1.w, c[5].y;
DP3 R2.x, fragment.texcoord[1], R2;
MUL R2.y, R1.w, c[4].x;
MAX R1.w, R2.x, c[5].x;
POW R1.w, R1.w, R2.y;
MUL R0.w, R1, R0;
DP3 R1.w, fragment.texcoord[1], R1;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R0, c[0];
MAX R1.w, R1, c[5].x;
MOV R0.xyz, c[1];
MUL R1.xyz, R1, R1.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, c[5].z;
MOV result.color.w, c[5].x;
END
# 24 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 28 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
dp3_pp r0.x, t3, t3
mul_pp r2.xyz, r2, c2
rsq_pp r0.x, r0.x
mov_pp r1.xyz, t2
mad_pp r1.xyz, r0.x, t3, r1
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r1.x, t1, r1
mov_pp r0.x, c3
mul_pp r0.x, c4.y, r0
max_pp r1.x, r1, c4
pow r3.w, r1.x, r0.x
mov r0.x, r3.w
mov_pp r1.xyz, t2
dp3_pp r1.x, t1, r1
mul_pp r2.xyz, r2, c0
max_pp r1.x, r1, c4
mul_pp r1.xyz, r2, r1.x
mov_pp r3.xyz, c0
mul r0.x, r0, r2.w
mul_pp r2.xyz, c1, r3
mad r0.xyz, r2, r0.x, r1
mul r0.xyz, r0, c4.z
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 4 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 3 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 128, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[0], texture[0], 2D;
DP3 R0.z, fragment.texcoord[4], fragment.texcoord[4];
RCP R0.x, fragment.texcoord[4].w;
MAD R0.xy, fragment.texcoord[4], R0.x, c[5].z;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MOV result.color.w, c[5].x;
TEX R0.w, R0, texture[2], 2D;
TEX R1.w, R0.z, texture[3], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R1.xyz, R1.x, fragment.texcoord[3], R0;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MUL R1.xyz, R3.x, R1;
DP3 R1.x, fragment.texcoord[1], R1;
MOV R3.x, c[5].y;
MUL R1.y, R3.x, c[4].x;
MAX R1.x, R1, c[5];
POW R1.x, R1.x, R1.y;
MUL R2.w, R1.x, R2;
DP3 R1.x, fragment.texcoord[1], R0;
MUL R0.xyz, R2, c[2];
SLT R2.x, c[5], fragment.texcoord[4].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[5];
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[5];
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_2_0
; 37 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c4, 0.00000000, 128.00000000, 1.00000000, 0.50000000
def c5, 2.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4
texld r3, t0, s0
dp3 r1.x, t4, t4
mov r1.xy, r1.x
rcp r0.x, t4.w
mad r0.xy, t4, r0.x, c4.w
mul_pp r3.xyz, r3, c2
mul_pp r3.xyz, r3, c0
texld r0, r0, s2
texld r5, r1, s3
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
dp3_pp r0.x, t3, t3
mul_pp r4.xyz, r1.x, t2
rsq_pp r0.x, r0.x
mad_pp r2.xyz, r0.x, t3, r4
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r2.xyz, r1.x, r2
dp3_pp r2.x, t1, r2
cmp r0.x, -t4.z, c4, c4.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r5
mov_pp r1.x, c3
mul_pp r1.x, c4.y, r1
max_pp r2.x, r2, c4
pow r5.x, r2.x, r1.x
dp3_pp r2.x, t1, r4
mov r1.x, r5.x
max_pp r2.x, r2, c4
mul_pp r2.xyz, r3, r2.x
mov_pp r4.xyz, c0
mul_pp r0.x, r0, c5
mul r1.x, r1, r3.w
mul_pp r3.xyz, c1, r4
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 4 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 31 ALU, 3 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R2, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[4], texture[3], CUBE;
DP3 R0.x, fragment.texcoord[4], fragment.texcoord[4];
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.x, R1.x;
MOV result.color.w, c[5].x;
TEX R0.w, R0.x, texture[2], 2D;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[2];
MAD R1.xyz, R1.x, fragment.texcoord[3], R0;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MUL R1.xyz, R3.x, R1;
DP3 R1.x, fragment.texcoord[1], R1;
MOV R3.x, c[5].y;
MUL R0.w, R0, R1;
MUL R1.y, R3.x, c[4].x;
MAX R1.x, R1, c[5];
POW R1.x, R1.x, R1.y;
MUL R2.w, R1.x, R2;
DP3 R1.x, fragment.texcoord[1], R0;
MUL R0.xyz, R2, c[2];
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[5];
MUL R1.xyz, R0, R1.x;
MOV R0.xyz, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, c[5].z;
MAD R0.xyz, R0, R2.w, R1;
MUL result.color.xyz, R0, R0.w;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_2_0
; 33 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_cube s3
def c4, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r3, t0, s0
dp3 r0.x, t4, t4
mov r0.xy, r0.x
mul_pp r3.xyz, r3, c2
mul_pp r3.xyz, r3, c0
texld r4, r0, s2
texld r0, t4, s3
dp3_pp r0.x, t2, t2
rsq_pp r1.x, r0.x
dp3_pp r0.x, t3, t3
mul_pp r5.xyz, r1.x, t2
rsq_pp r0.x, r0.x
mad_pp r2.xyz, r0.x, t3, r5
dp3_pp r0.x, r2, r2
rsq_pp r1.x, r0.x
mul_pp r2.xyz, r1.x, r2
dp3_pp r2.x, t1, r2
mov_pp r1.x, c3
mul r0.x, r4, r0.w
mul_pp r1.x, c4.y, r1
max_pp r2.x, r2, c4
pow r4.w, r2.x, r1.x
mov r1.x, r4.w
dp3_pp r2.x, t1, r5
max_pp r2.x, r2, c4
mul_pp r2.xyz, r3, r2.x
mov_pp r4.xyz, c0
mul_pp r0.x, r0, c4.z
mul r1.x, r1, r3.w
mul_pp r3.xyz, c1, r4
mad r1.xyz, r3, r1.x, r2
mul r0.xyz, r1, r0.x
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 4 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 26 ALU, 2 TEX
PARAM c[6] = { program.local[0..4],
		{ 0, 128, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[4], texture[2], 2D;
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
MOV R1.xyz, fragment.texcoord[2];
RSQ R2.x, R2.x;
MAD R2.xyz, R2.x, fragment.texcoord[3], R1;
DP3 R2.w, R2, R2;
RSQ R2.w, R2.w;
MUL R2.xyz, R2.w, R2;
DP3 R2.x, fragment.texcoord[1], R2;
MOV R2.w, c[5].y;
MUL R0.xyz, R0, c[2];
MUL R2.y, R2.w, c[4].x;
MAX R2.x, R2, c[5];
POW R2.x, R2.x, R2.y;
MUL R0.w, R2.x, R0;
DP3 R2.x, fragment.texcoord[1], R1;
MUL R1.xyz, R0, c[0];
MAX R2.x, R2, c[5];
MOV R0.xyz, c[1];
MUL R1.xyz, R1, R2.x;
MUL R0.xyz, R0, c[0];
MUL R1.w, R1, c[5].z;
MAD R0.xyz, R0, R0.w, R1;
MUL result.color.xyz, R0, R1.w;
MOV result.color.w, c[5].x;
END
# 26 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 29 ALU, 2 TEX
dcl_2d s0
dcl_2d s2
def c4, 0.00000000, 128.00000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
dcl t4.xy
texld r0, t4, s2
texld r2, t0, s0
dp3_pp r0.x, t3, t3
mul_pp r2.xyz, r2, c2
rsq_pp r0.x, r0.x
mov_pp r1.xyz, t2
mad_pp r1.xyz, r0.x, t3, r1
dp3_pp r0.x, r1, r1
rsq_pp r0.x, r0.x
mul_pp r1.xyz, r0.x, r1
dp3_pp r1.x, t1, r1
mov_pp r0.x, c3
mul_pp r0.x, c4.y, r0
max_pp r1.x, r1, c4
pow r3.w, r1.x, r0.x
mov r0.x, r3.w
mul r0.x, r0, r2.w
mov_pp r1.xyz, t2
dp3_pp r1.x, t1, r1
max_pp r1.x, r1, c4
mul_pp r2.xyz, r2, c0
mul_pp r3.xyz, r2, r1.x
mul_pp r1.x, r0.w, c4.z
mov_pp r2.xyz, c0
mul_pp r2.xyz, c1, r2
mad r0.xyz, r2, r0.x, r3
mul r0.xyz, r0, r1.x
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"!!ARBvp1.0
# 8 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_2_0
; 8 ALU
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c8.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Shininess]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 2 ALU, 0 TEX
PARAM c[2] = { program.local[0],
		{ 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[1].x, c[1].x;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Shininess]
"ps_2_0
; 3 ALU
def c1, 0.50000000, 0, 0, 0
dcl t0.xyz
mad_pp r0.xyz, t0, c1.x, c1.x
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[24] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.z, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.x, R1, c[19];
DP4 R3.y, R1, c[20];
ADD R2.xyz, R2, R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
MAD R1.xyz, R3, c[14].w, -vertex.position;
MAD R0.w, R0.x, R0.x, -R0.z;
DP3 R0.y, vertex.normal, -R1;
MUL R0.xyz, vertex.normal, R0.y;
MAD R0.xyz, -R0, c[0].y, -R1;
MUL R3.xyz, R0.w, c[22];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
ADD result.texcoord[3].xyz, R2, R3;
MUL R2.xyz, R1.xyww, c[0].z;
DP3 result.texcoord[1].x, R0, c[5];
MOV R0.x, R2;
MUL R0.y, R2, c[13].x;
ADD result.texcoord[2].xy, R0, R2.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 41 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"vs_2_0
; 41 ALU
def c24, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.z, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.x, r1, c19
dp4 r3.y, r1, c20
add r2.xyz, r2, r3
mov r1.w, c24.x
mov r1.xyz, c15
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c14.w, -v0
mad r0.w, r0.x, r0.x, -r0.z
dp3 r0.y, v1, -r1
mul r0.xyz, v1, r0.y
mad r0.xyz, -r0, c24.y, -r1
mul r3.xyz, r0.w, c22
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
add oT3.xyz, r2, r3
mul r2.xyz, r1.xyww, c24.z
dp3 oT1.x, r0, c4
mov r0.x, r2
mul r0.y, r2, c12.x
mad oT2.xy, r2.z, c13.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.xy, v2, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [unity_LightmapST]
Vector 21 [unity_ShadowFadeCenterAndType]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 32 ALU
PARAM c[23] = { { 1, 2, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[19];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[15];
DP4 R0.x, R1, c[13];
DP4 R0.y, R1, c[14];
MAD R0.xyz, R0, c[18].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R1.xyz, vertex.normal, R0.w;
MAD R2.xyz, -R1, c[0].y, -R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[17].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[21].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[21];
DP3 result.texcoord[1].z, R2, c[11];
DP3 result.texcoord[1].y, R2, c[10];
DP3 result.texcoord[1].x, R2, c[9];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[21].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[20], c[20].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 32 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [unity_LightmapST]
Vector 21 [unity_ShadowFadeCenterAndType]
Vector 22 [_MainTex_ST]
"vs_2_0
; 32 ALU
def c23, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, c19
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
mad r0.xyz, r0, c18.w, -v0
dp3 r0.w, v1, -r0
mul r1.xyz, v1, r0.w
mad r2.xyz, -r1, c23.y, -r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c23.z
mul r1.y, r1, c16.x
mad oT2.xy, r1.z, c17.zwzw, r1
mov oPos, r0
mov r0.x, c21.w
add r0.y, c23.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c21
dp3 oT1.z, r2, c10
dp3 oT1.y, r2, c9
dp3 oT1.x, r2, c8
mov oT2.zw, r0
mul oT4.xyz, r1, c21.w
mad oT0.xy, v2, c22, c22.zwzw
mad oT3.xy, v3, c20, c20.zwzw
mul oT4.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 30 ALU
PARAM c[18] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[15];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R3.xyz, R2, vertex.attrib[14].w;
MUL R1.xyz, vertex.normal, R0.w;
MAD R1.xyz, -R1, c[0].y, -R0;
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
DP3 result.texcoord[4].y, R0, R3;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.texcoord[4].z, -R0.w;
DP3 result.texcoord[4].x, R0, vertex.attrib[14];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 31 ALU
def c18, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mov r1.w, c18.x
mov r1.xyz, c15
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c14.w, -v0
dp3 r0.w, v2, -r0
mul r3.xyz, r2, v1.w
mul r1.xyz, v2, r0.w
mad r1.xyz, -r1, c18.y, -r0
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c18.z
mul r2.y, r2, c12.x
dp3 oT4.y, r0, r3
mad oT2.xy, r2.z, c13.zwzw, r2
mov oT4.z, -r0.w
dp3 oT4.x, r0, v1
mov oPos, r1
mov oT2.zw, r1
mad oT0.xy, v3, c17, c17.zwzw
mad oT3.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[24] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.z, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.x, R1, c[19];
DP4 R3.y, R1, c[20];
ADD R2.xyz, R2, R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
MAD R1.xyz, R3, c[14].w, -vertex.position;
MAD R0.w, R0.x, R0.x, -R0.z;
DP3 R0.y, vertex.normal, -R1;
MUL R0.xyz, vertex.normal, R0.y;
MAD R0.xyz, -R0, c[0].y, -R1;
MUL R3.xyz, R0.w, c[22];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP3 result.texcoord[1].z, R0, c[7];
DP3 result.texcoord[1].y, R0, c[6];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
ADD result.texcoord[3].xyz, R2, R3;
MUL R2.xyz, R1.xyww, c[0].z;
DP3 result.texcoord[1].x, R0, c[5];
MOV R0.x, R2;
MUL R0.y, R2, c[13].x;
ADD result.texcoord[2].xy, R0, R2.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 41 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
"vs_2_0
; 41 ALU
def c24, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
mul r0.z, r2.w, r2.w
dp4 r3.z, r1, c21
dp4 r3.x, r1, c19
dp4 r3.y, r1, c20
add r2.xyz, r2, r3
mov r1.w, c24.x
mov r1.xyz, c15
dp4 r3.z, r1, c10
dp4 r3.x, r1, c8
dp4 r3.y, r1, c9
mad r1.xyz, r3, c14.w, -v0
mad r0.w, r0.x, r0.x, -r0.z
dp3 r0.y, v1, -r1
mul r0.xyz, v1, r0.y
mad r0.xyz, -r0, c24.y, -r1
mul r3.xyz, r0.w, c22
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp3 oT1.z, r0, c6
dp3 oT1.y, r0, c5
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
add oT3.xyz, r2, r3
mul r2.xyz, r1.xyww, c24.z
dp3 oT1.x, r0, c4
mov r0.x, r2
mul r0.y, r2, c12.x
mad oT2.xy, r2.z, c13.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.xy, v2, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Matrix 13 [_World2Object]
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [unity_LightmapST]
Vector 21 [unity_ShadowFadeCenterAndType]
Vector 22 [_MainTex_ST]
"!!ARBvp1.0
# 32 ALU
PARAM c[23] = { { 1, 2, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..22] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[19];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[15];
DP4 R0.x, R1, c[13];
DP4 R0.y, R1, c[14];
MAD R0.xyz, R0, c[18].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R1.xyz, vertex.normal, R0.w;
MAD R2.xyz, -R1, c[0].y, -R0;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[17].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0];
ADD R0.y, R0.x, -c[21].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[21];
DP3 result.texcoord[1].z, R2, c[11];
DP3 result.texcoord[1].y, R2, c[10];
DP3 result.texcoord[1].x, R2, c[9];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[21].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[22], c[22].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[20], c[20].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 32 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Matrix 12 [_World2Object]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [unity_LightmapST]
Vector 21 [unity_ShadowFadeCenterAndType]
Vector 22 [_MainTex_ST]
"vs_2_0
; 32 ALU
def c23, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dcl_texcoord1 v3
mov r1.xyz, c19
mov r1.w, c23.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
mad r0.xyz, r0, c18.w, -v0
dp3 r0.w, v1, -r0
mul r1.xyz, v1, r0.w
mad r2.xyz, -r1, c23.y, -r0
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c23.z
mul r1.y, r1, c16.x
mad oT2.xy, r1.z, c17.zwzw, r1
mov oPos, r0
mov r0.x, c21.w
add r0.y, c23.x, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c21
dp3 oT1.z, r2, c10
dp3 oT1.y, r2, c9
dp3 oT1.x, r2, c8
mov oT2.zw, r0
mul oT4.xyz, r1, c21.w
mad oT0.xy, v2, c22, c22.zwzw
mad oT3.xy, v3, c20, c20.zwzw
mul oT4.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"!!ARBvp1.0
# 30 ALU
PARAM c[18] = { { 1, 2, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[15];
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R0.w, vertex.normal, -R0;
MUL R3.xyz, R2, vertex.attrib[14].w;
MUL R1.xyz, vertex.normal, R0.w;
MAD R1.xyz, -R1, c[0].y, -R0;
DP3 result.texcoord[1].z, R1, c[7];
DP3 result.texcoord[1].y, R1, c[6];
DP3 result.texcoord[1].x, R1, c[5];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].z;
MUL R2.y, R2, c[13].x;
DP3 result.texcoord[4].y, R0, R3;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.texcoord[4].z, -R0.w;
DP3 result.texcoord[4].x, R0, vertex.attrib[14];
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
"vs_2_0
; 31 ALU
def c18, 1.00000000, 2.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r2.xyz, v2.yzxw, r2.zxyw, -r3
mov r1.w, c18.x
mov r1.xyz, c15
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r0.xyz, r0, c14.w, -v0
dp3 r0.w, v2, -r0
mul r3.xyz, r2, v1.w
mul r1.xyz, v2, r0.w
mad r1.xyz, -r1, c18.y, -r0
dp3 oT1.z, r1, c6
dp3 oT1.y, r1, c5
dp3 oT1.x, r1, c4
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c18.z
mul r2.y, r2, c12.x
dp3 oT4.y, r0, r3
mad oT2.xy, r2.z, c13.zwzw, r2
mov oT4.z, -r0.w
dp3 oT4.x, r0, v1
mov oPos, r1
mov oT2.zw, r1
mad oT0.xy, v3, c17, c17.zwzw
mad oT3.xy, v4, c16, c16.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 3 TEX
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R2, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
LG2 R2.w, R2.w;
MUL R2.w, R1, -R2;
MUL R0, R0, R1.w;
LG2 R2.x, R2.x;
LG2 R2.z, R2.z;
LG2 R2.y, R2.y;
ADD R2.xyz, -R2, fragment.texcoord[3];
MUL R3.xyz, R2, c[0];
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
"ps_2_0
; 15 ALU, 3 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xyz
texld r1, t1, s1
texldp r0, t2, s2
texld r2, t0, s0
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r3.xyz, -r0, t3
log_pp r0.x, r0.w
mul_pp r0.x, r2.w, -r0
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r4, r0.x
mul_pp r2.xyz, r2, c1
mul_pp r0.x, r0, c0.w
mul_pp r1, r1, r2.w
mad_pp r0.w, r1, c2, r0.x
mad_pp r2.xyz, r2, r3, r4
mad_pp r0.xyz, r1, c2, r2
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 28 ALU, 5 TEX
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TXP R2, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R4, fragment.texcoord[3], texture[3], 2D;
TEX R3, fragment.texcoord[3], texture[4], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
MUL R4.xyz, R4.w, R4;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].x;
DP4 R4.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R3.w, R4.w;
RCP R3.w, R3.w;
LG2 R2.w, R2.w;
MUL R2.w, R1, -R2;
MUL R0, R0, R1.w;
MAD R4.xyz, R4, c[4].x, -R3;
MAD_SAT R3.w, R3, c[3].z, c[3];
MAD R3.xyz, R3.w, R4, R3;
LG2 R2.x, R2.x;
LG2 R2.y, R2.y;
LG2 R2.z, R2.z;
ADD R2.xyz, -R2, R3;
MUL R3.xyz, R2, c[0];
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 28 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 24 ALU, 5 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xy
dcl t4
texld r1, t1, s1
texld r2, t0, s0
texldp r3, t2, s2
texld r0, t3, s3
texld r4, t3, s4
mul_pp r5.xyz, r0.w, r0
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c4.x
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r5.xyz, r5, c4.x, -r4
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r5, r4
mul_pp r1, r1, r2.w
log_pp r3.x, r3.x
log_pp r3.y, r3.y
log_pp r3.z, r3.z
add_pp r3.xyz, -r3, r0
log_pp r0.x, r3.w
mul_pp r0.x, r2.w, -r0
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r4, r0.x
mul_pp r0.x, r0, c0.w
mul_pp r2.xyz, r2, c1
mad_pp r0.w, r1, c2, r0.x
mad_pp r2.xyz, r2, r3, r4
mad_pp r0.xyz, r1, c2, r2
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 39 ALU, 5 TEX
PARAM c[7] = { program.local[0..3],
		{ 8, -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TXP R2, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R4, fragment.texcoord[3], texture[4], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
TEX R3, fragment.texcoord[3], texture[3], 2D;
MUL R4.xyz, R4.w, R4;
MUL R4.xyz, R4, c[4].x;
MUL R5.xyz, R4.y, c[6];
MAD R5.xyz, R4.x, c[5], R5;
MAD R4.xyz, R4.z, c[4].yzww, R5;
DP3 R4.w, R4, R4;
RSQ R5.x, R4.w;
DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R4.w, R4.w;
MUL R4.xyz, R5.x, R4;
MAD R4.xyz, R4.w, fragment.texcoord[4], R4;
DP3 R4.x, R4, R4;
RSQ R4.y, R4.x;
MUL R4.y, R4, R4.z;
MOV R4.x, c[5].w;
MUL R4.z, R4.x, c[3].x;
MAX R4.x, R4.y, c[5].y;
POW R4.w, R4.x, R4.z;
MUL R3.xyz, R3.w, R3;
MUL R4.xyz, R3, c[4].x;
MUL R0, R0, R1.w;
LG2 R2.x, R2.x;
LG2 R2.y, R2.y;
LG2 R2.z, R2.z;
LG2 R2.w, R2.w;
ADD R2, -R2, R4;
MUL R2.w, R1, R2;
MUL R3.xyz, R2, c[0];
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 39 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 41 ALU, 5 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 8.00000000, -0.40824831, 0.70710677, 0.57735026
def c5, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xy
dcl t4.xyz
texld r3, t1, s1
texld r2, t0, s0
texld r4, t3, s3
texld r0, t3, s4
texldp r5, t2, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c4.x
log_pp r0.w, r5.w
mul_pp r2.xyz, r2, c1
mov r0.x, c4.y
mov r0.z, c4.w
mov r0.y, c4.z
mul r0.xyz, r1.y, r0
mad r0.xyz, r1.x, c5, r0
mad r6.xyz, r1.z, c6, r0
dp3 r0.x, r6, r6
rsq r1.x, r0.x
dp3_pp r0.x, t4, t4
mul r1.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t4, r1
dp3_pp r0.x, r0, r0
rsq_pp r1.x, r0.x
mul_pp r0.z, r1.x, r0
max_pp r1.x, r0.z, c5.y
mov_pp r0.x, c3
mul_pp r0.x, c5.w, r0
pow r6.x, r1.x, r0.x
mul_pp r1.xyz, r4.w, r4
log_pp r0.x, r5.x
log_pp r0.y, r5.y
log_pp r0.z, r5.z
mov r1.w, r6.x
mul_pp r1.xyz, r1, c4.x
add_pp r1, -r0, r1
mul_pp r0.x, r2.w, r1.w
mul_pp r4.xyz, r1, c0
mul_pp r4.xyz, r4, r0.x
mad_pp r1.xyz, r2, r1, r4
mul_pp r0.x, r0, c0.w
mul_pp r2, r3, r2.w
mad_pp r0.w, r2, c2, r0.x
mad_pp r0.xyz, r2, c2, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[3] = { program.local[0..2] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TXP R2, fragment.texcoord[2], texture[2], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
ADD R2.xyz, R2, fragment.texcoord[3];
MUL R2.w, R1, R2;
MUL R3.xyz, R2, c[0];
MUL R0, R0, R1.w;
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 13 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
"ps_2_0
; 11 ALU, 3 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xyz
texld r1, t1, s1
texldp r0, t2, s2
texld r2, t0, s0
add_pp r3.xyz, r0, t3
mul_pp r0.x, r2.w, r0.w
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r4, r0.x
mul_pp r2.xyz, r2, c1
mul_pp r0.x, r0, c0.w
mul_pp r1, r1, r2.w
mad_pp r0.w, r1, c2, r0.x
mad_pp r2.xyz, r2, r3, r4
mad_pp r0.xyz, r1, c2, r2
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 5 TEX
PARAM c[5] = { program.local[0..3],
		{ 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TXP R2, fragment.texcoord[2], texture[2], 2D;
TEX R4, fragment.texcoord[3], texture[3], 2D;
TEX R3, fragment.texcoord[3], texture[4], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
MUL R4.xyz, R4.w, R4;
MUL R3.xyz, R3.w, R3;
MUL R3.xyz, R3, c[4].x;
DP4 R4.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R3.w, R4.w;
RCP R3.w, R3.w;
MUL R2.w, R1, R2;
MUL R0, R0, R1.w;
MAD R4.xyz, R4, c[4].x, -R3;
MAD_SAT R3.w, R3, c[3].z, c[3];
MAD R3.xyz, R3.w, R4, R3;
ADD R2.xyz, R2, R3;
MUL R3.xyz, R2, c[0];
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 24 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 20 ALU, 5 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 8.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xy
dcl t4
texld r1, t1, s1
texldp r3, t2, s2
texld r2, t0, s0
texld r0, t3, s3
texld r4, t3, s4
mul_pp r5.xyz, r0.w, r0
dp4 r0.x, t4, t4
mul_pp r4.xyz, r4.w, r4
mul_pp r4.xyz, r4, c4.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r5.xyz, r5, c4.x, -r4
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r5, r4
add_pp r3.xyz, r3, r0
mul_pp r0.x, r2.w, r3.w
mul_pp r4.xyz, r3, c0
mul_pp r4.xyz, r4, r0.x
mul_pp r2.xyz, r2, c1
mul_pp r0.x, r0, c0.w
mul_pp r1, r1, r2.w
mad_pp r0.w, r1, c2, r0.x
mad_pp r2.xyz, r2, r3, r4
mad_pp r0.xyz, r1, c2, r2
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 5 TEX
PARAM c[7] = { program.local[0..3],
		{ 8, -0.40824828, -0.70710677, 0.57735026 },
		{ 0.81649655, 0, 0.57735026, 128 },
		{ -0.40824831, 0.70710677, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1, fragment.texcoord[0], texture[0], 2D;
TEX R4, fragment.texcoord[3], texture[4], 2D;
TEX R3, fragment.texcoord[3], texture[3], 2D;
TEX R0, fragment.texcoord[1], texture[1], CUBE;
TXP R2, fragment.texcoord[2], texture[2], 2D;
MUL R4.xyz, R4.w, R4;
MUL R4.xyz, R4, c[4].x;
MUL R5.xyz, R4.y, c[6];
MAD R5.xyz, R4.x, c[5], R5;
MAD R4.xyz, R4.z, c[4].yzww, R5;
DP3 R4.w, R4, R4;
RSQ R5.x, R4.w;
MUL R3.xyz, R3.w, R3;
DP3 R4.w, fragment.texcoord[4], fragment.texcoord[4];
MUL R3.xyz, R3, c[4].x;
MUL R0, R0, R1.w;
MUL R4.xyz, R5.x, R4;
RSQ R4.w, R4.w;
MAD R4.xyz, R4.w, fragment.texcoord[4], R4;
DP3 R4.x, R4, R4;
RSQ R4.x, R4.x;
MUL R4.y, R4.x, R4.z;
MOV R4.x, c[5].w;
MAX R4.y, R4, c[5];
MUL R4.x, R4, c[3];
POW R3.w, R4.y, R4.x;
ADD R2, R2, R3;
MUL R2.w, R1, R2;
MUL R3.xyz, R2, c[0];
MUL R3.xyz, R3, R2.w;
MUL R1.xyz, R1, c[1];
MAD R1.xyz, R1, R2, R3;
MUL R2.x, R2.w, c[0].w;
MAD result.color.xyz, R0, c[2], R1;
MAD result.color.w, R0, c[2], R2.x;
END
# 35 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_SpecColor]
Vector 1 [_Color]
Vector 2 [_ReflectColor]
Float 3 [_Shininess]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_Cube] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 37 ALU, 5 TEX
dcl_2d s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c4, 8.00000000, -0.40824831, 0.70710677, 0.57735026
def c5, 0.81649655, 0.00000000, 0.57735026, 128.00000000
def c6, -0.40824828, -0.70710677, 0.57735026, 0
dcl t0.xy
dcl t1.xyz
dcl t2
dcl t3.xy
dcl t4.xyz
texld r3, t1, s1
texld r2, t0, s0
texldp r5, t2, s2
texld r0, t3, s4
texld r4, t3, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c4.x
mul_pp r2.xyz, r2, c1
mov r0.x, c4.y
mov r0.z, c4.w
mov r0.y, c4.z
mul r0.xyz, r1.y, r0
mad r0.xyz, r1.x, c5, r0
mad r6.xyz, r1.z, c6, r0
dp3 r0.x, r6, r6
rsq r1.x, r0.x
dp3_pp r0.x, t4, t4
mul r1.xyz, r1.x, r6
rsq_pp r0.x, r0.x
mad_pp r0.xyz, r0.x, t4, r1
dp3_pp r0.x, r0, r0
rsq_pp r1.x, r0.x
mul_pp r0.z, r1.x, r0
mov_pp r0.x, c3
max_pp r1.x, r0.z, c5.y
mul_pp r0.x, c5.w, r0
pow r6.x, r1.x, r0.x
mul_pp r0.xyz, r4.w, r4
mul_pp r0.xyz, r0, c4.x
mov r0.w, r6.x
add_pp r1, r5, r0
mul_pp r0.x, r2.w, r1.w
mul_pp r4.xyz, r1, c0
mul_pp r4.xyz, r4, r0.x
mad_pp r1.xyz, r2, r1, r4
mul_pp r0.x, r0, c0.w
mul_pp r2, r3, r2.w
mad_pp r0.w, r2, c2, r0.x
mad_pp r0.xyz, r2, c2, r1
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Reflective/VertexLit"
}