//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "NeatShader" {
Properties {
 _alph ("_alph", Float) = 1
 _ran ("_ran", Range(0,0.5)) = 0.33
 _tex1 ("_tex1", 2D) = "black" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="Transparent" }
 GrabPass {
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="Transparent" }
  Cull Off
  Blend SrcColor SrcColor
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Float 25 [_ran]
Vector 26 [_tex1_ST]
"!!ARBvp1.0
# 53 ALU
PARAM c[27] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R1.xyz, vertex.normal, c[15].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[20];
DP4 R2.y, R0, c[19];
DP4 R2.x, R0, c[18];
MUL R0.z, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.z;
ABS R0.y, c[13].z;
ADD R0.y, R0, -c[0].x;
DP4 R3.z, R1, c[23];
DP4 R3.y, R1, c[22];
DP4 R3.x, R1, c[21];
MUL R0.y, R0, c[25].x;
MUL R1, R0.y, vertex.attrib[14];
ADD R1, R1, vertex.position;
ADD R2.xyz, R2, R3;
MUL R4.xyz, R0.x, c[24];
ADD result.texcoord[3].xyz, R2, R4;
MOV R2.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R4;
MUL R4.xyz, vertex.attrib[14].w, R2;
DP4 R3.w, R1, c[4];
DP4 R3.z, R1, c[3];
DP4 R3.x, R1, c[1];
DP4 R3.y, R1, c[2];
MUL R0.xyz, R3.xyww, c[0].x;
MUL R0.y, R0, c[14].x;
ADD result.texcoord[1].xy, R0, R0.z;
MOV R0, c[17];
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MOV R0.xyz, c[16];
MOV R0.w, c[0].y;
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[15].w, -R1;
DP3 result.texcoord[2].y, R2, R4;
DP3 result.texcoord[4].y, R4, R0;
MOV result.position, R3;
MOV result.texcoord[1].zw, R3;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 53 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Float 25 [_ran]
Vector 26 [_tex1_ST]
"vs_2_0
; 56 ALU
def c27, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c15.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.z
dp4 r2.z, r0, c20
dp4 r2.y, r0, c19
dp4 r2.x, r0, c18
mul r0.z, r2.w, r2.w
mad r2.w, r0.x, r0.x, -r0.z
abs r0.y, c12.z
add r0.y, r0, c27.x
dp4 r3.z, r1, c23
dp4 r3.y, r1, c22
dp4 r3.x, r1, c21
mul r0.y, r0, c25.x
mul r1, r0.y, v1
add r0, r1, v0
add r2.xyz, r2, r3
mul r4.xyz, r2.w, c24
add oT3.xyz, r2, r4
mov r2.xyz, v1
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
mul r1.xyz, r3.xyww, c27.y
mul r1.y, r1, c13.x
mad oT1.xy, r1.z, c14.zwzw, r1
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r2, c8
mov r1, c10
dp4 r5.z, c17, r1
mov r1, c9
dp4 r5.y, c17, r1
dp4 r5.x, c17, r2
mov r1.xyz, c16
mov r1.w, c27.z
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r1.xyz, r2, c15.w, -r0
dp3 oT2.y, r5, r4
dp3 oT4.y, r4, r1
mov oPos, r3
mov oT1.zw, r3
dp3 oT4.z, v2, r1
dp3 oT4.x, v1, r1
dp3 oT2.z, v2, r5
dp3 oT2.x, v1, r5
mad oT0.xy, v3, c26, c26.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Float 16 [_ran]
Vector 17 [unity_LightmapST]
Vector 18 [_tex1_ST]
"!!ARBvp1.0
# 16 ALU
PARAM c[19] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[16];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[1].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 16 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [_tex1_ST]
"vs_2_0
; 16 ALU
def c18, -0.50000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c18
mul r0.x, r0, c15
mul r0, r0.x, v1
add r1, r0, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c18.y
mul r2.y, r2, c13.x
mad oT1.xy, r2.z, c14.zwzw, r2
mov oPos, r0
mov oT1.zw, r0
mad oT0.xy, v3, c17, c17.zwzw
mad oT2.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Float 18 [_ran]
Vector 19 [unity_LightmapST]
Vector 20 [_tex1_ST]
"!!ARBvp1.0
# 29 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[18];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0.xyz, c[16];
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
MOV R0.w, c[0].y;
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[0].x;
MUL R4.y, R4, c[14].x;
ADD result.texcoord[1].xy, R4, R4.z;
DP4 R4.z, R0, c[11];
DP4 R4.x, R0, c[9];
DP4 R4.y, R0, c[10];
MAD R0.xyz, R4, c[15].w, -R1;
MUL R3.xyz, vertex.attrib[14].w, R3;
DP3 result.texcoord[3].y, R0, R3;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[19], c[19].zwzw;
END
# 29 instructions, 5 R-regs
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
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Float 17 [_ran]
Vector 18 [unity_LightmapST]
Vector 19 [_tex1_ST]
"vs_2_0
; 30 ALU
def c20, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c20
mul r0.x, r0, c17
mul r0, r0.x, v1
add r1, r0, v0
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
mov r0.w, c20.z
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mul r3.xyz, r2.xyww, c20.y
mul r3.y, r3, c13.x
mov r0.xyz, v1
mad oT1.xy, r3.z, c14.zwzw, r3
mul r3.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r3.xyz, v2.yzxw, r0.zxyw, -r3
mov r0.xyz, c16
dp4 r4.z, r0, c10
dp4 r4.x, r0, c8
dp4 r4.y, r0, c9
mad r0.xyz, r4, c15.w, -r1
mul r3.xyz, v1.w, r3
dp3 oT3.y, r0, r3
mov oPos, r2
mov oT1.zw, r2
dp3 oT3.z, v2, r0
dp3 oT3.x, v1, r0
mad oT0.xy, v3, c19, c19.zwzw
mad oT2.xy, v4, c18, c18.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Float 25 [_ran]
Vector 26 [_tex1_ST]
"!!ARBvp1.0
# 55 ALU
PARAM c[27] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..26] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R1.xyz, vertex.normal, c[15].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
MOV R0.y, R2.w;
DP3 R0.z, R1, c[7];
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[20];
DP4 R2.y, R0, c[19];
DP4 R2.x, R0, c[18];
MUL R0.z, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.z;
ABS R0.y, c[13].z;
ADD R0.y, R0, -c[0].x;
DP4 R3.z, R1, c[23];
DP4 R3.y, R1, c[22];
DP4 R3.x, R1, c[21];
ADD R1.xyz, R2, R3;
MUL R4.xyz, R0.x, c[24];
ADD result.texcoord[3].xyz, R1, R4;
MUL R0.y, R0, c[25].x;
MUL R2, R0.y, vertex.attrib[14];
ADD R3, R2, vertex.position;
DP4 R2.w, R3, c[4];
DP4 R2.z, R3, c[3];
MOV R0.w, c[0].y;
DP4 R2.x, R3, c[1];
DP4 R2.y, R3, c[2];
MUL R0.xyz, R2.xyww, c[0].x;
MUL R0.y, R0, c[14].x;
ADD R1.xy, R0, R0.z;
MOV R0.xyz, c[16];
MOV R1.zw, R2;
DP4 R5.z, R0, c[11];
DP4 R5.y, R0, c[10];
DP4 R5.x, R0, c[9];
MAD R3.xyz, R5, c[15].w, -R3;
MOV R4.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R4.yzxw;
MAD R4.xyz, vertex.normal.yzxw, R4.zxyw, -R0;
MOV R0, c[17];
MUL R4.xyz, vertex.attrib[14].w, R4;
DP4 R5.z, R0, c[11];
DP4 R5.y, R0, c[10];
DP4 R5.x, R0, c[9];
MOV result.texcoord[1], R1;
DP3 result.texcoord[2].y, R5, R4;
DP3 result.texcoord[4].y, R4, R3;
MOV result.texcoord[5], R1;
MOV result.position, R2;
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
DP3 result.texcoord[2].z, vertex.normal, R5;
DP3 result.texcoord[2].x, vertex.attrib[14], R5;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 55 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Float 25 [_ran]
Vector 26 [_tex1_ST]
"vs_2_0
; 58 ALU
def c27, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c15.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c27.z
dp4 r2.z, r0, c20
dp4 r2.y, r0, c19
dp4 r2.x, r0, c18
mul r0.z, r2.w, r2.w
mad r0.x, r0, r0, -r0.z
abs r0.y, c12.z
add r0.y, r0, c27.x
mul r4.xyz, r0.x, c24
mov r2.w, c27.z
dp4 r3.z, r1, c23
dp4 r3.y, r1, c22
dp4 r3.x, r1, c21
add r2.xyz, r2, r3
add oT3.xyz, r2, r4
mov r2.xyz, c16
mul r0.y, r0, c25.x
mul r1, r0.y, v1
add r3, r1, v0
dp4 r0.w, r3, c3
dp4 r0.x, r3, c0
dp4 r0.y, r3, c1
dp4 r0.z, r3, c2
mul r1.xyz, r0.xyww, c27.y
mul r1.y, r1, c13.x
mad r1.xy, r1.z, c14.zwzw, r1
mov r1.zw, r0
dp4 r4.z, r2, c10
dp4 r4.y, r2, c9
dp4 r4.x, r2, c8
mad r5.xyz, r4, c15.w, -r3
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r3.xyz, v2.yzxw, r2.zxyw, -r3
mul r4.xyz, v1.w, r3
mov r2, c10
dp4 r6.z, c17, r2
mov r2, c9
mov r3, c8
dp4 r6.y, c17, r2
dp4 r6.x, c17, r3
mov oT1, r1
dp3 oT2.y, r6, r4
dp3 oT4.y, r4, r5
mov oT5, r1
mov oPos, r0
dp3 oT4.z, v2, r5
dp3 oT4.x, v1, r5
dp3 oT2.z, v2, r6
dp3 oT2.x, v1, r6
mad oT0.xy, v3, c26, c26.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Float 16 [_ran]
Vector 17 [unity_LightmapST]
Vector 18 [_tex1_ST]
"!!ARBvp1.0
# 18 ALU
PARAM c[19] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[16];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
DP4 R0.z, R1, c[3];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[14].x;
ADD R1.xy, R2, R2.z;
MOV R1.zw, R0;
MOV result.texcoord[1], R1;
MOV result.texcoord[3], R1;
MOV result.position, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 18 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [_tex1_ST]
"vs_2_0
; 18 ALU
def c18, -0.50000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c18
mul r0.x, r0, c15
mul r0, r0.x, v1
add r1, r0, v0
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
dp4 r0.z, r1, c2
mul r2.xyz, r0.xyww, c18.y
mul r2.y, r2, c13.x
mad r1.xy, r2.z, c14.zwzw, r2
mov r1.zw, r0
mov oT1, r1
mov oT3, r1
mov oPos, r0
mad oT0.xy, v3, c17, c17.zwzw
mad oT2.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Float 18 [_ran]
Vector 19 [unity_LightmapST]
Vector 20 [_tex1_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[18];
MUL R0, R0.x, vertex.attrib[14];
ADD R3, R0, vertex.position;
DP4 R2.w, R3, c[4];
DP4 R2.z, R3, c[3];
MOV R0.w, c[0].y;
DP4 R2.x, R3, c[1];
DP4 R2.y, R3, c[2];
MUL R0.xyz, R2.xyww, c[0].x;
MUL R0.y, R0, c[14].x;
ADD R1.xy, R0, R0.z;
MOV R1.zw, R2;
MOV R0.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R4;
MUL R4.xyz, vertex.attrib[14].w, R0;
MOV R0.xyz, c[16];
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[15].w, -R3;
MOV result.texcoord[1], R1;
DP3 result.texcoord[3].y, R0, R4;
MOV result.texcoord[4], R1;
MOV result.position, R2;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[19], c[19].zwzw;
END
# 31 instructions, 6 R-regs
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
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Float 17 [_ran]
Vector 18 [unity_LightmapST]
Vector 19 [_tex1_ST]
"vs_2_0
; 32 ALU
def c20, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c20
mul r0.x, r0, c17
mul r0, r0.x, v1
add r3, r0, v0
dp4 r2.w, r3, c3
dp4 r2.z, r3, c2
mov r0.w, c20.z
dp4 r2.x, r3, c0
dp4 r2.y, r3, c1
mul r0.xyz, r2.xyww, c20.y
mul r0.y, r0, c13.x
mad r1.xy, r0.z, c14.zwzw, r0
mov r1.zw, r2
mov r0.xyz, v1
mul r4.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r4
mul r4.xyz, v1.w, r0
mov r0.xyz, c16
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r0.xyz, r5, c15.w, -r3
mov oT1, r1
dp3 oT3.y, r0, r4
mov oT4, r1
mov oPos, r2
dp3 oT3.z, v2, r0
dp3 oT3.x, v1, r0
mad oT0.xy, v3, c19, c19.zwzw
mad oT2.xy, v4, c18, c18.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_4LightPosX0]
Vector 19 [unity_4LightPosY0]
Vector 20 [unity_4LightPosZ0]
Vector 21 [unity_4LightAtten0]
Vector 22 [unity_LightColor0]
Vector 23 [unity_LightColor1]
Vector 24 [unity_LightColor2]
Vector 25 [unity_LightColor3]
Vector 26 [unity_SHAr]
Vector 27 [unity_SHAg]
Vector 28 [unity_SHAb]
Vector 29 [unity_SHBr]
Vector 30 [unity_SHBg]
Vector 31 [unity_SHBb]
Vector 32 [unity_SHC]
Float 33 [_ran]
Vector 34 [_tex1_ST]
"!!ARBvp1.0
# 84 ALU
PARAM c[35] = { { 0.5, 1, 0 },
		state.matrix.mvp,
		program.local[5..34] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R4.xyz, vertex.normal, c[15].w;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[33];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
DP4 R0.y, R1, c[6];
DP3 R5.x, R4, c[5];
DP3 R4.w, R4, c[6];
DP3 R4.x, R4, c[7];
ADD R2, -R0.y, c[19];
MUL R3, R4.w, R2;
DP4 R0.x, R1, c[5];
ADD R0, -R0.x, c[18];
MUL R2, R2, R2;
MOV R5.z, R4.x;
MAD R3, R5.x, R0, R3;
MOV R5.w, c[0].y;
DP4 R5.y, R1, c[7];
MAD R2, R0, R0, R2;
ADD R0, -R5.y, c[20];
MAD R2, R0, R0, R2;
MAD R0, R4.x, R0, R3;
MUL R3, R2, c[21];
MOV R5.y, R4.w;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.w, R2.w;
RSQ R2.z, R2.z;
MUL R0, R0, R2;
ADD R2, R3, c[0].y;
DP4 R3.z, R5, c[28];
DP4 R3.y, R5, c[27];
DP4 R3.x, R5, c[26];
DP4 R3.w, R1, c[4];
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[23];
MAD R2.xyz, R0.x, c[22], R2;
MAD R0.xyz, R0.z, c[24], R2;
MUL R2, R5.xyzz, R5.yzzx;
MAD R0.xyz, R0.w, c[25], R0;
MUL R0.w, R4, R4;
DP4 R4.z, R2, c[31];
DP4 R4.y, R2, c[30];
DP4 R4.x, R2, c[29];
MAD R0.w, R5.x, R5.x, -R0;
ADD R3.xyz, R3, R4;
MUL R2.xyz, R0.w, c[32];
ADD R4.xyz, R3, R2;
ADD result.texcoord[3].xyz, R4, R0;
MOV R0.xyz, vertex.attrib[14];
DP4 R3.z, R1, c[3];
MUL R4.xyz, vertex.normal.zxyw, R0.yzxw;
DP4 R3.x, R1, c[1];
DP4 R3.y, R1, c[2];
MUL R2.xyz, R3.xyww, c[0].x;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[1].xy, R2, R2.z;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R4;
MOV R0, c[17];
MUL R4.xyz, vertex.attrib[14].w, R2;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MOV R0.xyz, c[16];
MOV R0.w, c[0].y;
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[15].w, -R1;
DP3 result.texcoord[2].y, R2, R4;
DP3 result.texcoord[4].y, R4, R0;
MOV result.position, R3;
MOV result.texcoord[1].zw, R3;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 84 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_4LightPosX0]
Vector 19 [unity_4LightPosY0]
Vector 20 [unity_4LightPosZ0]
Vector 21 [unity_4LightAtten0]
Vector 22 [unity_LightColor0]
Vector 23 [unity_LightColor1]
Vector 24 [unity_LightColor2]
Vector 25 [unity_LightColor3]
Vector 26 [unity_SHAr]
Vector 27 [unity_SHAg]
Vector 28 [unity_SHAb]
Vector 29 [unity_SHBr]
Vector 30 [unity_SHBg]
Vector 31 [unity_SHBb]
Vector 32 [unity_SHC]
Float 33 [_ran]
Vector 34 [_tex1_ST]
"vs_2_0
; 87 ALU
def c35, -0.50000000, 0.50000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r4.xyz, v2, c15.w
abs r0.x, c12.z
add r0.x, r0, c35
mul r0.x, r0, c33
mul r0, r0.x, v1
add r1, r0, v0
dp4 r0.y, r1, c5
dp3 r5.x, r4, c4
dp3 r4.w, r4, c5
dp3 r4.x, r4, c6
add r2, -r0.y, c19
mul r3, r4.w, r2
dp4 r0.x, r1, c4
add r0, -r0.x, c18
mul r2, r2, r2
mov r5.z, r4.x
mad r3, r5.x, r0, r3
mov r5.w, c35.z
dp4 r5.y, r1, c6
mad r2, r0, r0, r2
add r0, -r5.y, c20
mad r2, r0, r0, r2
mad r0, r4.x, r0, r3
mul r3, r2, c21
mov r5.y, r4.w
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.w, r2.w
rsq r2.z, r2.z
mul r0, r0, r2
add r2, r3, c35.z
dp4 r3.z, r5, c28
dp4 r3.y, r5, c27
dp4 r3.x, r5, c26
dp4 r3.w, r1, c3
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c35.w
mul r0, r0, r2
mul r2.xyz, r0.y, c23
mad r2.xyz, r0.x, c22, r2
mad r0.xyz, r0.z, c24, r2
mul r2, r5.xyzz, r5.yzzx
mad r0.xyz, r0.w, c25, r0
mul r0.w, r4, r4
dp4 r4.z, r2, c31
dp4 r4.y, r2, c30
dp4 r4.x, r2, c29
mad r0.w, r5.x, r5.x, -r0
add r3.xyz, r3, r4
mul r2.xyz, r0.w, c32
add r4.xyz, r3, r2
add oT3.xyz, r4, r0
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
mul r2.xyz, r3.xyww, c35.y
mul r2.y, r2, c13.x
mov r0.xyz, v1
mad oT1.xy, r2.z, c14.zwzw, r2
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r2, c8
mov r0, c10
dp4 r5.z, c17, r0
mov r0, c9
dp4 r5.y, c17, r0
dp4 r5.x, c17, r2
mov r0.xyz, c16
mov r0.w, c35.z
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c15.w, -r1
dp3 oT2.y, r5, r4
dp3 oT4.y, r4, r0
mov oPos, r3
mov oT1.zw, r3
dp3 oT4.z, v2, r0
dp3 oT4.x, v1, r0
dp3 oT2.z, v2, r5
dp3 oT2.x, v1, r5
mad oT0.xy, v3, c34, c34.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_4LightPosX0]
Vector 19 [unity_4LightPosY0]
Vector 20 [unity_4LightPosZ0]
Vector 21 [unity_4LightAtten0]
Vector 22 [unity_LightColor0]
Vector 23 [unity_LightColor1]
Vector 24 [unity_LightColor2]
Vector 25 [unity_LightColor3]
Vector 26 [unity_SHAr]
Vector 27 [unity_SHAg]
Vector 28 [unity_SHAb]
Vector 29 [unity_SHBr]
Vector 30 [unity_SHBg]
Vector 31 [unity_SHBb]
Vector 32 [unity_SHC]
Float 33 [_ran]
Vector 34 [_tex1_ST]
"!!ARBvp1.0
# 87 ALU
PARAM c[35] = { { 0.5, 1, 0 },
		state.matrix.mvp,
		program.local[5..34] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R4.xyz, vertex.normal, c[15].w;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[33];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
DP4 R0.y, R1, c[6];
DP3 R5.x, R4, c[5];
DP3 R4.w, R4, c[6];
DP3 R4.x, R4, c[7];
ADD R2, -R0.y, c[19];
DP4 R0.x, R1, c[5];
MUL R3, R4.w, R2;
ADD R0, -R0.x, c[18];
MUL R2, R2, R2;
MOV R5.z, R4.x;
MAD R3, R5.x, R0, R3;
DP4 R5.y, R1, c[7];
MAD R2, R0, R0, R2;
ADD R0, -R5.y, c[20];
MAD R2, R0, R0, R2;
MAD R0, R4.x, R0, R3;
MUL R3, R2, c[21];
MOV R5.y, R4.w;
MOV R5.w, c[0].y;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.w, R2.w;
RSQ R2.z, R2.z;
MUL R0, R0, R2;
ADD R2, R3, c[0].y;
DP4 R3.z, R5, c[28];
DP4 R3.y, R5, c[27];
DP4 R3.x, R5, c[26];
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[0].z;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[23];
MAD R2.xyz, R0.x, c[22], R2;
MAD R0.xyz, R0.z, c[24], R2;
MAD R2.xyz, R0.w, c[25], R0;
MUL R0, R5.xyzz, R5.yzzx;
MUL R2.w, R4, R4;
DP4 R4.z, R0, c[31];
DP4 R4.y, R0, c[30];
DP4 R4.x, R0, c[29];
MAD R2.w, R5.x, R5.x, -R2;
MUL R0.xyz, R2.w, c[32];
ADD R3.xyz, R3, R4;
ADD R4.xyz, R3, R0;
ADD result.texcoord[3].xyz, R4, R2;
DP4 R0.w, R1, c[4];
MOV R2.w, c[0].y;
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R3.xyz, R0.xyww, c[0].x;
DP4 R0.z, R1, c[3];
MOV R2.x, R3;
MUL R2.y, R3, c[14].x;
ADD R3.xy, R2, R3.z;
MOV R2.xyz, c[16];
MOV R3.zw, R0;
DP4 R5.z, R2, c[11];
DP4 R5.y, R2, c[10];
DP4 R5.x, R2, c[9];
MAD R1.xyz, R5, c[15].w, -R1;
MOV R4.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R4.yzxw;
MAD R4.xyz, vertex.normal.yzxw, R4.zxyw, -R2;
MOV R2, c[17];
MUL R4.xyz, vertex.attrib[14].w, R4;
DP4 R5.z, R2, c[11];
DP4 R5.y, R2, c[10];
DP4 R5.x, R2, c[9];
MOV result.texcoord[1], R3;
DP3 result.texcoord[2].y, R5, R4;
DP3 result.texcoord[4].y, R4, R1;
MOV result.texcoord[5], R3;
MOV result.position, R0;
DP3 result.texcoord[4].z, vertex.normal, R1;
DP3 result.texcoord[4].x, vertex.attrib[14], R1;
DP3 result.texcoord[2].z, vertex.normal, R5;
DP3 result.texcoord[2].x, vertex.attrib[14], R5;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 87 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_WorldSpaceLightPos0]
Vector 18 [unity_4LightPosX0]
Vector 19 [unity_4LightPosY0]
Vector 20 [unity_4LightPosZ0]
Vector 21 [unity_4LightAtten0]
Vector 22 [unity_LightColor0]
Vector 23 [unity_LightColor1]
Vector 24 [unity_LightColor2]
Vector 25 [unity_LightColor3]
Vector 26 [unity_SHAr]
Vector 27 [unity_SHAg]
Vector 28 [unity_SHAb]
Vector 29 [unity_SHBr]
Vector 30 [unity_SHBg]
Vector 31 [unity_SHBb]
Vector 32 [unity_SHC]
Float 33 [_ran]
Vector 34 [_tex1_ST]
"vs_2_0
; 90 ALU
def c35, -0.50000000, 0.50000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r4.xyz, v2, c15.w
abs r0.x, c12.z
add r0.x, r0, c35
mul r0.x, r0, c33
mul r0, r0.x, v1
add r1, r0, v0
dp4 r0.y, r1, c5
dp3 r5.x, r4, c4
dp3 r4.w, r4, c5
dp3 r4.x, r4, c6
add r2, -r0.y, c19
dp4 r0.x, r1, c4
mul r3, r4.w, r2
add r0, -r0.x, c18
mul r2, r2, r2
mov r5.z, r4.x
mad r3, r5.x, r0, r3
dp4 r5.y, r1, c6
mad r2, r0, r0, r2
add r0, -r5.y, c20
mad r2, r0, r0, r2
mad r0, r4.x, r0, r3
mul r3, r2, c21
mov r5.y, r4.w
mov r5.w, c35.z
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.w, r2.w
rsq r2.z, r2.z
mul r0, r0, r2
add r2, r3, c35.z
mov r3.w, c35.z
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c35.w
mul r0, r0, r2
mul r2.xyz, r0.y, c23
mad r2.xyz, r0.x, c22, r2
mad r0.xyz, r0.z, c24, r2
mad r2.xyz, r0.w, c25, r0
mul r0, r5.xyzz, r5.yzzx
mul r2.w, r4, r4
dp4 r4.z, r0, c31
dp4 r4.y, r0, c30
dp4 r4.x, r0, c29
mad r2.w, r5.x, r5.x, -r2
mul r0.xyz, r2.w, c32
dp4 r0.w, r1, c3
dp4 r3.z, r5, c28
dp4 r3.y, r5, c27
dp4 r3.x, r5, c26
add r3.xyz, r3, r4
add r4.xyz, r3, r0
add oT3.xyz, r4, r2
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r3.xyz, r0.xyww, c35.y
mov r2.x, r3
mul r2.y, r3, c13.x
mad r2.xy, r3.z, c14.zwzw, r2
mov r3.xyz, c16
mov r2.zw, r0
dp4 r4.z, r3, c10
dp4 r4.y, r3, c9
dp4 r4.x, r3, c8
mad r5.xyz, r4, c15.w, -r1
mov r3.xyz, v1
mov r1.xyz, v1
mul r3.xyz, v2.zxyw, r3.yzxw
mad r3.xyz, v2.yzxw, r1.zxyw, -r3
mul r4.xyz, v1.w, r3
mov r1, c10
dp4 r6.z, c17, r1
mov r1, c9
mov r3, c8
dp4 r6.y, c17, r1
dp4 r6.x, c17, r3
mov oT1, r2
dp3 oT2.y, r6, r4
dp3 oT4.y, r4, r5
mov oT5, r2
mov oPos, r0
dp3 oT4.z, v2, r5
dp3 oT4.x, v1, r5
dp3 oT2.z, v2, r6
dp3 oT2.x, v1, r6
mad oT0.xy, v3, c34, c34.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MUL R0.xy, fragment.texcoord[1], R0.x;
MAX R0.w, fragment.texcoord[2].z, c[2].y;
MOV result.color.w, c[1].x;
TEX R1.xyz, R0, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R0, c[2].x;
MUL R0.xyz, R0.w, c[0];
MUL R2.xyz, R1, fragment.texcoord[3];
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[2].z, R2;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_alph]
Vector 2 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c3, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t3.xyz
add r0.x, -t1.y, c3
cmp r1.y, c2, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r0, r0, s1
texld r1, t0, s0
add r1.xyz, r1, r0
max_pp r0.x, t2.z, c3.z
mul r1.xyz, r1, c3.y
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r0, r1
mul_pp r1.xyz, r1, t3
mov_pp r0.w, c1.x
mad_pp r0.xyz, r0, c3.w, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
MOV result.color.w, c[0].x;
TEX R2.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R1.xyz, R1, R2;
MUL R1.xyz, R1, c[1].x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[1].y;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 12 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 1.00000000, 0.50000000, 8.00000000, 0
dcl t0.xy
dcl t1.xyzw
dcl t2.xy
texld r2, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r1.xy, r1, r0.x
texld r0, t2, s2
texld r1, r1, s1
mul_pp r0.xyz, r0.w, r0
add r1.xyz, r2, r1
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.z
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 4 TEX
PARAM c[2] = { program.local[0],
		{ 8, 0.5, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R3.xy, fragment.texcoord[1], R0.x;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[1].z;
DP3 R1.x, R1, c[1].x;
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R3.xyz, R3, texture[1], 2D;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R2, c[1].y;
MUL R0.xyz, R0, R1.x;
MUL R0.xyz, R0, R2;
MUL result.color.xyz, R0, c[1].x;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [unity_Lightmap] 2D
SetTexture 3 [unity_LightmapInd] 2D
"ps_2_0
; 16 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, 1.00000000, 0.50000000, 0.57735026, 8.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xy
texld r2, t2, s2
texld r3, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r0, r0, s1
texld r1, t2, s3
add r0.xyz, r3, r0
mul_pp r1.xyz, r1.w, r1
mul r3.xyz, r0, c2.y
mul_pp r0.xyz, r1, c2.z
dp3_pp r0.x, r0, c2.w
mul_pp r1.xyz, r2.w, r2
mul_pp r0.xyz, r1, r0.x
mul_pp r0.xyz, r0, r3
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[5], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
MAX R0.w, fragment.texcoord[2].z, c[2].y;
MOV result.color.w, c[1].x;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
ADD R1.xyz, R0, R1;
MUL R0.xyz, R0.w, c[0];
MUL R1.xyz, R1, c[2].x;
MUL R0.xyz, R2.x, R0;
MUL R2.xyz, R1, fragment.texcoord[3];
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[2].z, R2;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Float 1 [_alph]
Vector 2 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_2_0
; 15 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t3.xyz
dcl t5
texldp r2, t5, s2
add r0.x, -t1.y, c3
cmp r1.y, c2, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r0, r0, s1
texld r1, t0, s0
add r1.xyz, r1, r0
max_pp r0.x, t2.z, c3.z
mul_pp r0.xyz, r0.x, c0
mul r1.xyz, r1, c3.y
mul_pp r0.xyz, r2.x, r0
mul_pp r0.xyz, r0, r1
mul_pp r1.xyz, r1, t3
mov_pp r0.w, c1.x
mad_pp r0.xyz, r0, c3.w, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 4 TEX
PARAM c[2] = { program.local[0],
		{ 0.5, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R3.x, fragment.texcoord[3], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[2], texture[3], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R3.yzw, R0.xxyz, R3.x;
MUL R0.xyz, R0.w, R0;
ADD R1.xyz, R2, R1;
MUL R0.xyz, R0, c[1].y;
MUL R3.yzw, R3, c[1].z;
MIN R3.yzw, R0.xxyz, R3;
MUL R0.xyz, R0, R3.x;
MAX R0.xyz, R3.yzww, R0;
MUL R1.xyz, R1, c[1].x;
MUL result.color.xyz, R1, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 17 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, 1.00000000, 0.50000000, 8.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xy
dcl t3
texldp r3, t3, s2
texld r2, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r1.xy, r1, r0.x
texld r0, t2, s3
texld r1, r1, s1
add r1.xyz, r2, r1
mul_pp r2.xyz, r0.w, r0
mul_pp r0.xyz, r0, r3.x
mul_pp r2.xyz, r2, c2.z
mul_pp r0.xyz, r0, c2.w
mul_pp r3.xyz, r2, r3.x
min_pp r0.xyz, r2, r0
max_pp r0.xyz, r0, r3
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 22 ALU, 5 TEX
PARAM c[2] = { program.local[0],
		{ 8, 0.5, 0.57735026, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[2], texture[3], 2D;
TXP R4.x, fragment.texcoord[4], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R2.xy, fragment.texcoord[1], R0.x;
MUL R4.yzw, R1.xxyz, R4.x;
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, R2, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[1].z;
DP3 R0.w, R0, c[1].x;
MUL R0.xyz, R1.w, R1;
MUL R0.xyz, R0, R0.w;
MUL R0.xyz, R0, c[1].x;
MUL R1.xyz, R4.yzww, c[1].w;
MIN R1.xyz, R0, R1;
MUL R0.xyz, R0, R4.x;
MAX R1.xyz, R1, R0;
ADD R2.xyz, R3, R2;
MUL R0.xyz, R2, c[1].y;
MUL result.color.xyz, R0, R1;
END
# 22 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 21 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 1.00000000, 0.50000000, 0.57735026, 8.00000000
def c3, 2.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyzw
dcl t2.xy
dcl t4
texldp r2, t4, s2
texld r4, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r3, r0, s1
texld r1, t2, s3
texld r0, t2, s4
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2.z
mul_pp r5.xyz, r1, r2.x
mul_pp r1.xyz, r1.w, r1
dp3_pp r0.x, r0, c2.w
mul_pp r0.xyz, r1, r0.x
mul_pp r0.xyz, r0, c2.w
mul_pp r1.xyz, r5, c3.x
min_pp r1.xyz, r0, r1
mul_pp r0.xyz, r0, r2.x
max_pp r0.xyz, r1, r0
add r2.xyz, r4, r3
mul r1.xyz, r2, c2.y
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="Transparent" }
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
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_CosTime]
Vector 18 [_ProjectionParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[17].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[22];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0, c[21];
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[0].x;
MUL R4.y, R4, c[18].x;
ADD result.texcoord[1].xy, R4, R4.z;
MUL R4.xyz, vertex.attrib[14].w, R3;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R3.xyz, R3, c[19].w, -R1;
MOV R0.w, c[0].y;
MOV R0.xyz, c[20];
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[19].w, -R1;
DP3 result.texcoord[3].y, R4, R0;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP3 result.texcoord[2].y, R3, R4;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 43 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_CosTime]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"vs_2_0
; 46 ALU
def c24, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
abs r0.x, c16.z
add r0.x, r0, c24
mul r0.x, r0, c22
mul r0, r0.x, v1
add r1, r0, v0
dp4 r3.w, r1, c3
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
mul r2.xyz, r3.xyww, c24.y
mul r2.y, r2, c17.x
mov r0.xyz, v1
mad oT1.xy, r2.z, c18.zwzw, r2
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r0, c10
dp4 r5.z, c21, r0
mov r0, c9
dp4 r5.y, c21, r0
mov r2, c8
dp4 r5.x, c21, r2
mad r2.xyz, r5, c19.w, -r1
mov r0.w, c24.z
mov r0.xyz, c20
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r0.xyz, r5, c19.w, -r1
dp3 oT3.y, r4, r0
dp3 oT3.z, v2, r0
dp3 oT3.x, v1, r0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 oT2.y, r2, r4
mov oPos, r3
mov oT1.zw, r3
dp3 oT2.z, v2, r2
dp3 oT2.x, v1, r2
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.xy, v3, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_CosTime]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Float 14 [_ran]
Vector 15 [_tex1_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[9].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[14];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0, c[13];
DP4 R3.w, R1, c[4];
DP4 R3.z, R1, c[3];
DP4 R3.x, R1, c[1];
DP4 R3.y, R1, c[2];
MUL R4.xyz, R3.xyww, c[0].x;
MUL R4.y, R4, c[10].x;
ADD result.texcoord[1].xy, R4, R4.z;
MUL R4.xyz, vertex.attrib[14].w, R2;
DP4 R2.z, R0, c[7];
DP4 R2.y, R0, c[6];
DP4 R2.x, R0, c[5];
MOV R0.xyz, c[12];
MOV R0.w, c[0].y;
DP4 R5.z, R0, c[7];
DP4 R5.x, R0, c[5];
DP4 R5.y, R0, c[6];
MAD R0.xyz, R5, c[11].w, -R1;
DP3 result.texcoord[2].y, R2, R4;
DP3 result.texcoord[3].y, R4, R0;
MOV result.position, R3;
MOV result.texcoord[1].zw, R3;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
END
# 35 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_CosTime]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Float 14 [_ran]
Vector 15 [_tex1_ST]
"vs_2_0
; 38 ALU
def c16, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
abs r0.x, c8.z
add r0.x, r0, c16
mul r0.x, r0, c14
mul r0, r0.x, v1
add r0, r0, v0
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
mul r2.xyz, r3.xyww, c16.y
mul r2.y, r2, c9.x
mov r1.xyz, v1
mad oT1.xy, r2.z, c10.zwzw, r2
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r2, c4
mov r1, c6
dp4 r5.z, c13, r1
mov r1, c5
dp4 r5.y, c13, r1
dp4 r5.x, c13, r2
mov r1.xyz, c12
mov r1.w, c16.z
dp4 r2.z, r1, c6
dp4 r2.x, r1, c4
dp4 r2.y, r1, c5
mad r1.xyz, r2, c11.w, -r0
dp3 oT2.y, r5, r4
dp3 oT3.y, r4, r1
mov oPos, r3
mov oT1.zw, r3
dp3 oT3.z, v2, r1
dp3 oT3.x, v1, r1
dp3 oT2.z, v2, r5
dp3 oT2.x, v1, r5
mad oT0.xy, v3, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_CosTime]
Vector 18 [_ProjectionParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"!!ARBvp1.0
# 44 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[17].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[22];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0, c[21];
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[0].x;
MUL R4.y, R4, c[18].x;
ADD result.texcoord[1].xy, R4, R4.z;
MUL R4.xyz, vertex.attrib[14].w, R3;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R3.xyz, R3, c[19].w, -R1;
MOV R0.w, c[0].y;
MOV R0.xyz, c[20];
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[19].w, -R1;
DP4 R0.w, R1, c[8];
DP3 result.texcoord[3].y, R4, R0;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP3 result.texcoord[2].y, R3, R4;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 44 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_CosTime]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"vs_2_0
; 47 ALU
def c24, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
abs r0.x, c16.z
add r0.x, r0, c24
mul r0.x, r0, c22
mul r0, r0.x, v1
add r1, r0, v0
dp4 r3.w, r1, c3
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
mul r2.xyz, r3.xyww, c24.y
mul r2.y, r2, c17.x
mov r0.xyz, v1
mad oT1.xy, r2.z, c18.zwzw, r2
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r0, c10
dp4 r5.z, c21, r0
mov r0, c9
dp4 r5.y, c21, r0
mov r2, c8
dp4 r5.x, c21, r2
mad r2.xyz, r5, c19.w, -r1
mov r0.w, c24.z
mov r0.xyz, c20
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r0.xyz, r5, c19.w, -r1
dp4 r0.w, r1, c7
dp3 oT3.y, r4, r0
dp3 oT3.z, v2, r0
dp3 oT3.x, v1, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 oT2.y, r2, r4
mov oPos, r3
mov oT1.zw, r3
dp3 oT2.z, v2, r2
dp3 oT2.x, v1, r2
dp4 oT4.w, r0, c15
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.xy, v3, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_CosTime]
Vector 18 [_ProjectionParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"!!ARBvp1.0
# 43 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[17].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[22];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0, c[21];
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[0].x;
MUL R4.y, R4, c[18].x;
ADD result.texcoord[1].xy, R4, R4.z;
MUL R4.xyz, vertex.attrib[14].w, R3;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R3.xyz, R3, c[19].w, -R1;
MOV R0.w, c[0].y;
MOV R0.xyz, c[20];
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[19].w, -R1;
DP3 result.texcoord[3].y, R4, R0;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP3 result.texcoord[2].y, R3, R4;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 43 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_CosTime]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"vs_2_0
; 46 ALU
def c24, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
abs r0.x, c16.z
add r0.x, r0, c24
mul r0.x, r0, c22
mul r0, r0.x, v1
add r1, r0, v0
dp4 r3.w, r1, c3
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
mul r2.xyz, r3.xyww, c24.y
mul r2.y, r2, c17.x
mov r0.xyz, v1
mad oT1.xy, r2.z, c18.zwzw, r2
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r0, c10
dp4 r5.z, c21, r0
mov r0, c9
dp4 r5.y, c21, r0
mov r2, c8
dp4 r5.x, c21, r2
mad r2.xyz, r5, c19.w, -r1
mov r0.w, c24.z
mov r0.xyz, c20
dp4 r5.z, r0, c10
dp4 r5.x, r0, c8
dp4 r5.y, r0, c9
mad r0.xyz, r5, c19.w, -r1
dp3 oT3.y, r4, r0
dp3 oT3.z, v2, r0
dp3 oT3.x, v1, r0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
dp3 oT2.y, r2, r4
mov oPos, r3
mov oT1.zw, r3
dp3 oT2.z, v2, r2
dp3 oT2.x, v1, r2
dp4 oT4.z, r0, c14
dp4 oT4.y, r0, c13
dp4 oT4.x, r0, c12
mad oT0.xy, v3, c23, c23.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_CosTime]
Vector 18 [_ProjectionParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"!!ARBvp1.0
# 41 ALU
PARAM c[24] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
ABS R0.x, c[17].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[22];
MUL R0, R0.x, vertex.attrib[14];
ADD R1, R0, vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0, c[21];
DP4 R2.w, R1, c[4];
DP4 R2.z, R1, c[3];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[0].x;
MUL R4.y, R4, c[18].x;
ADD result.texcoord[1].xy, R4, R4.z;
MUL R4.xyz, vertex.attrib[14].w, R3;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
MOV R0.w, c[0].y;
MOV R0.xyz, c[20];
DP4 R5.z, R0, c[11];
DP4 R5.x, R0, c[9];
DP4 R5.y, R0, c[10];
MAD R0.xyz, R5, c[19].w, -R1;
DP3 result.texcoord[3].y, R4, R0;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP3 result.texcoord[2].y, R3, R4;
MOV result.position, R2;
MOV result.texcoord[1].zw, R2;
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 41 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_CosTime]
Vector 17 [_ProjectionParams]
Vector 18 [_ScreenParams]
Vector 19 [unity_Scale]
Vector 20 [_WorldSpaceCameraPos]
Vector 21 [_WorldSpaceLightPos0]
Float 22 [_ran]
Vector 23 [_tex1_ST]
"vs_2_0
; 44 ALU
def c24, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
abs r0.x, c16.z
add r0.x, r0, c24
mul r0.x, r0, c22
mul r0, r0.x, v1
add r0, r0, v0
dp4 r3.w, r0, c3
dp4 r3.z, r0, c2
dp4 r3.x, r0, c0
dp4 r3.y, r0, c1
mul r2.xyz, r3.xyww, c24.y
mul r2.y, r2, c17.x
mov r1.xyz, v1
mad oT1.xy, r2.z, c18.zwzw, r2
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r4.xyz, v1.w, r2
mov r2, c8
mov r1, c10
dp4 r5.z, c21, r1
mov r1, c9
dp4 r5.y, c21, r1
dp4 r5.x, c21, r2
mov r1.w, c24.z
mov r1.xyz, c20
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r1.xyz, r2, c19.w, -r0
dp3 oT3.y, r4, r1
dp3 oT3.z, v2, r1
dp3 oT3.x, v1, r1
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
dp3 oT2.y, r5, r4
mov oPos, r3
mov oT1.zw, r3
dp4 oT4.y, r1, c13
dp4 oT4.x, r1, c12
dp3 oT2.z, v2, r5
dp3 oT2.x, v1, r5
mad oT0.xy, v3, c23, c23.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R1.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R1.w, R1.w;
MUL R1.w, R1, fragment.texcoord[2].z;
MAX R1.w, R1, c[2].y;
MOV result.color.w, c[2].y;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0.w, R0.w, texture[2], 2D;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R1.w, c[0];
MUL R0.xyz, R0, c[2].x;
MUL R1.xyz, R0.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 19 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t4.xyz
add r0.x, -t1.y, c2
cmp r2.y, c1, t1, r0.x
dp3 r1.x, t4, t4
mov r1.xy, r1.x
mov r2.x, t1
rcp r0.x, t1.w
mul r0.xy, r2, r0.x
mov_pp r0.w, c2.z
texld r3, r1, s2
texld r1, r0, s1
texld r2, t0, s0
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.z, r0.x, t2
max_pp r0.x, r0.z, c2.z
add r1.xyz, r2, r1
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r3.x, r0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.w
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MUL R0.xy, fragment.texcoord[1], R0.x;
MAX R0.w, fragment.texcoord[2].z, c[2].y;
MOV result.color.w, c[2].y;
TEX R1.xyz, R0, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
MUL R0.xyz, R0, c[2].x;
MUL R1.xyz, R0.w, c[0];
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r0, r0, s1
texld r1, t0, s0
add r1.xyz, r1, r0
max_pp r0.x, t2.z, c2.z
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c2.z
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 23 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.y, fragment.texcoord[4].w;
MAD R2.xy, fragment.texcoord[4], R0.y, c[2].x;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MOV result.color.w, c[2].y;
TEX R0.w, R2, texture[2], 2D;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, R1.w, texture[3], 2D;
ADD R0.xyz, R0, R1;
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.x, R2.x;
MUL R2.x, R2, fragment.texcoord[2].z;
MAX R1.x, R2, c[2].y;
SLT R2.x, c[2].y, fragment.texcoord[4].z;
MUL R0.w, R2.x, R0;
MUL R0.xyz, R0, c[2].x;
MUL R1.xyz, R1.x, c[0];
MUL R0.w, R0, R1;
MUL R1.xyz, R0.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 23 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_2_0
; 24 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t4
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
dp3 r2.x, t4, t4
mov r2.xy, r2.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
rcp r1.x, t4.w
mad r1.xy, t4, r1.x, c2.y
texld r3, r1, s2
texld r0, r0, s1
texld r2, r2, s3
texld r1, t0, s0
add r1.xyz, r1, r0
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.z, r0.x, t2
max_pp r3.x, r0.z, c2.z
cmp r0.x, -t4.z, c2.z, c2
mul r1.xyz, r1, c2.y
mul_pp r0.x, r0, r3.w
mul_pp r3.xyz, r3.x, c0
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r3
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c2.z
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1.w, fragment.texcoord[4], texture[3], CUBE;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R2.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R2.x, R2.x;
MUL R2.x, R2, fragment.texcoord[2].z;
MOV result.color.w, c[2].y;
TEX R0.w, R0.w, texture[2], 2D;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
MAX R1.x, R2, c[2].y;
MUL R0.xyz, R0, c[2].x;
MUL R1.xyz, R1.x, c[0];
MUL R0.w, R0, R1;
MUL R1.xyz, R0.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_2_0
; 20 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c2, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t4.xyz
add r1.x, -t1.y, c2
cmp r2.y, c1, t1, r1.x
dp3 r0.x, t4, t4
mov r2.x, t1
rcp r1.x, t1.w
mul r1.xy, r2, r1.x
mov r2.xy, r0.x
texld r3, r2, s2
texld r0, t4, s3
texld r2, t0, s0
texld r1, r1, s1
dp3_pp r0.x, t2, t2
rsq_pp r0.x, r0.x
mul_pp r0.z, r0.x, t2
max_pp r0.x, r0.z, c2.z
add r1.xyz, r2, r1
mul_pp r2.xyz, r0.x, c0
mul r0.x, r3, r0.w
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c2.z
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[4], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R1.xy, fragment.texcoord[1], R0.x;
MAX R1.w, fragment.texcoord[2].z, c[2].y;
MOV result.color.w, c[2].y;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
MUL R1.xyz, R1.w, c[0];
MUL R0.xyz, R0, c[2].x;
MUL R1.xyz, R0.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 1.00000000, 0.50000000, 0.00000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2.xyz
dcl t4.xy
texld r2, t4, s2
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
texld r0, r0, s1
texld r1, t0, s0
add r1.xyz, r1, r0
max_pp r0.x, t2.z, c2.z
mul_pp r0.xyz, r0.x, c0
mul r1.xyz, r1, c2.y
mul_pp r0.xyz, r2.w, r0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c2.z
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="Transparent" }
  Cull Off
  Fog { Mode Off }
  Blend SrcColor SrcColor
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [_CosTime]
Vector 10 [unity_Scale]
Float 11 [_ran]
"!!ARBvp1.0
# 25 ALU
PARAM c[12] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, vertex.attrib[14].w, R0;
ABS R0.w, c[9].z;
ADD R0.w, R0, -c[0].x;
DP3 R1.y, R0, c[5];
DP3 R1.x, vertex.attrib[14], c[5];
DP3 R1.z, vertex.normal, c[5];
MUL result.texcoord[0].xyz, R1, c[10].w;
DP3 R1.y, R0, c[6];
DP3 R0.y, R0, c[7];
DP3 R1.x, vertex.attrib[14], c[6];
DP3 R1.z, vertex.normal, c[6];
MUL R0.w, R0, c[11].x;
MUL result.texcoord[1].xyz, R1, c[10].w;
MUL R1, R0.w, vertex.attrib[14];
ADD R1, R1, vertex.position;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[2].xyz, R0, c[10].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
END
# 25 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_CosTime]
Vector 9 [unity_Scale]
Float 10 [_ran]
"vs_2_0
; 26 ALU
def c11, -0.50000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, v1.w, r0
abs r0.w, c8.z
add r0.w, r0, c11.x
dp3 r1.y, r0, c4
dp3 r1.x, v1, c4
dp3 r1.z, v2, c4
mul oT0.xyz, r1, c9.w
dp3 r1.y, r0, c5
dp3 r0.y, r0, c6
dp3 r1.x, v1, c5
dp3 r1.z, v2, c5
mul r0.w, r0, c10.x
mul oT1.xyz, r1, c9.w
mul r1, r0.w, v1
add r1, r1, v0
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT2.xyz, r0, c9.w
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 0 TEX
PARAM c[1] = { { 0, 0.5 } };
TEMP R0;
MOV R0.z, fragment.texcoord[2];
MOV R0.x, fragment.texcoord[0].z;
MOV R0.y, fragment.texcoord[1].z;
MAD result.color.xyz, R0, c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 6 ALU
def c0, 0.50000000, 0.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
mov_pp r0.z, t2
mov_pp r0.x, t0.z
mov_pp r0.y, t1.z
mad_pp r0.xyz, r0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcColor SrcColor
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [_CosTime]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Float 19 [_ran]
Vector 20 [_tex1_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[11].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[14];
DP4 R2.y, R0, c[13];
DP4 R2.x, R0, c[12];
MUL R0.z, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.z;
ABS R0.y, c[9].z;
ADD R0.y, R0, -c[0].x;
DP4 R3.z, R1, c[17];
DP4 R3.y, R1, c[16];
DP4 R3.x, R1, c[15];
MUL R0.y, R0, c[19].x;
MUL R1, R0.y, vertex.attrib[14];
ADD R1, R1, vertex.position;
MUL R4.xyz, R0.x, c[18];
ADD R3.xyz, R2, R3;
DP4 R0.w, R1, c[4];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
DP4 R0.z, R1, c[3];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
ADD R1.xy, R2, R2.z;
MOV R1.zw, R0;
ADD result.texcoord[3].xyz, R3, R4;
MOV result.texcoord[1], R1;
MOV result.texcoord[2], R1;
MOV result.position, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 35 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_CosTime]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Float 19 [_ran]
Vector 20 [_tex1_ST]
"vs_2_0
; 35 ALU
def c21, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c11.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c21.z
dp4 r2.z, r0, c14
dp4 r2.y, r0, c13
dp4 r2.x, r0, c12
mul r0.z, r2.w, r2.w
mad r0.x, r0, r0, -r0.z
abs r0.y, c8.z
add r0.y, r0, c21.x
dp4 r3.z, r1, c17
dp4 r3.y, r1, c16
dp4 r3.x, r1, c15
mul r0.y, r0, c19.x
mul r1, r0.y, v1
add r1, r1, v0
mul r4.xyz, r0.x, c18
add r3.xyz, r2, r3
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
dp4 r0.z, r1, c2
mul r2.xyz, r0.xyww, c21.y
mul r2.y, r2, c9.x
mad r1.xy, r2.z, c10.zwzw, r2
mov r1.zw, r0
add oT3.xyz, r3, r4
mov oT1, r1
mov oT2, r1
mov oPos, r0
mad oT0.xy, v3, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [unity_ShadowFadeCenterAndType]
Vector 18 [_tex1_ST]
"!!ARBvp1.0
# 27 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18] };
TEMP R0;
TEMP R1;
TEMP R2;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[15];
MUL R0, R0.x, vertex.attrib[14];
ADD R2, R0, vertex.position;
DP4 R1.w, R2, c[8];
DP4 R1.x, R2, c[5];
DP4 R1.y, R2, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
DP4 R1.z, R2, c[7];
MUL R0.y, R0, c[14].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[1], R0;
MOV result.texcoord[2], R0;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, R0, -c[17];
MUL result.texcoord[4].xyz, R0, c[17].w;
MOV R0.w, c[0].y;
ADD R0.y, R0.w, -c[17].w;
DP4 R0.x, R2, c[3];
MOV result.position, R1;
MUL result.texcoord[4].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [unity_ShadowFadeCenterAndType]
Vector 18 [_tex1_ST]
"vs_2_0
; 27 ALU
def c19, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c19
mul r0.x, r0, c15
mul r0, r0.x, v1
add r2, r0, v0
dp4 r1.w, r2, c7
dp4 r1.x, r2, c4
dp4 r1.y, r2, c5
mul r0.xyz, r1.xyww, c19.y
dp4 r1.z, r2, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov oT1, r0
mov oT2, r0
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
add r0.xyz, r0, -c17
mul oT4.xyz, r0, c17.w
mov r0.w, c17
add r0.y, c19.z, -r0.w
dp4 r0.x, r2, c2
mov oPos, r1
mul oT4.w, -r0.x, r0.y
mad oT0.xy, v3, c18, c18.zwzw
mad oT3.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_CosTime]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Float 13 [_ran]
Vector 14 [unity_LightmapST]
Vector 15 [_tex1_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R3.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R3.zxyw, -R4;
ABS R0.x, c[9].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[13];
MUL R0, R0.x, vertex.attrib[14];
ADD R2, R0, vertex.position;
DP4 R1.w, R2, c[4];
DP4 R1.x, R2, c[1];
DP4 R1.y, R2, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
DP4 R1.z, R2, c[3];
MUL R0.y, R0, c[10].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[1], R0;
MOV result.texcoord[2], R0;
MOV R0.xyz, c[12];
MOV R0.w, c[0].y;
MUL R3.xyz, vertex.attrib[14].w, R3;
DP4 R4.z, R0, c[7];
DP4 R4.x, R0, c[5];
DP4 R4.y, R0, c[6];
MAD R0.xyz, R4, c[11].w, -R2;
DP3 result.texcoord[4].y, R0, R3;
MOV result.position, R1;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
END
# 31 instructions, 5 R-regs
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
Matrix 4 [_World2Object]
Vector 8 [_CosTime]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Float 13 [_ran]
Vector 14 [unity_LightmapST]
Vector 15 [_tex1_ST]
"vs_2_0
; 32 ALU
def c16, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r3.xyz, v1
mul r4.xyz, v2.zxyw, r3.yzxw
abs r0.x, c8.z
add r0.x, r0, c16
mul r0.x, r0, c13
mul r0, r0.x, v1
add r2, r0, v0
mov r3.xyz, v1
mad r3.xyz, v2.yzxw, r3.zxyw, -r4
dp4 r1.w, r2, c3
dp4 r1.x, r2, c0
dp4 r1.y, r2, c1
mul r0.xyz, r1.xyww, c16.y
dp4 r1.z, r2, c2
mul r0.y, r0, c9.x
mad r0.xy, r0.z, c10.zwzw, r0
mov r0.zw, r1
mov oT1, r0
mov oT2, r0
mov r0.xyz, c12
mov r0.w, c16.z
mul r3.xyz, v1.w, r3
dp4 r4.z, r0, c6
dp4 r4.x, r0, c4
dp4 r4.y, r0, c5
mad r0.xyz, r4, c11.w, -r2
dp3 oT4.y, r0, r3
mov oPos, r1
dp3 oT4.z, v2, r0
dp3 oT4.x, v1, r0
mad oT0.xy, v3, c15, c15.zwzw
mad oT3.xy, v4, c14, c14.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [_CosTime]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Float 19 [_ran]
Vector 20 [_tex1_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[21] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[11].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[14];
DP4 R2.y, R0, c[13];
DP4 R2.x, R0, c[12];
MUL R0.z, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.z;
ABS R0.y, c[9].z;
ADD R0.y, R0, -c[0].x;
DP4 R3.z, R1, c[17];
DP4 R3.y, R1, c[16];
DP4 R3.x, R1, c[15];
MUL R0.y, R0, c[19].x;
MUL R1, R0.y, vertex.attrib[14];
ADD R1, R1, vertex.position;
MUL R4.xyz, R0.x, c[18];
ADD R3.xyz, R2, R3;
DP4 R0.w, R1, c[4];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
DP4 R0.z, R1, c[3];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[10].x;
ADD R1.xy, R2, R2.z;
MOV R1.zw, R0;
ADD result.texcoord[3].xyz, R3, R4;
MOV result.texcoord[1], R1;
MOV result.texcoord[2], R1;
MOV result.position, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 35 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_CosTime]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Float 19 [_ran]
Vector 20 [_tex1_ST]
"vs_2_0
; 35 ALU
def c21, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c11.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c21.z
dp4 r2.z, r0, c14
dp4 r2.y, r0, c13
dp4 r2.x, r0, c12
mul r0.z, r2.w, r2.w
mad r0.x, r0, r0, -r0.z
abs r0.y, c8.z
add r0.y, r0, c21.x
dp4 r3.z, r1, c17
dp4 r3.y, r1, c16
dp4 r3.x, r1, c15
mul r0.y, r0, c19.x
mul r1, r0.y, v1
add r1, r1, v0
mul r4.xyz, r0.x, c18
add r3.xyz, r2, r3
dp4 r0.w, r1, c3
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
dp4 r0.z, r1, c2
mul r2.xyz, r0.xyww, c21.y
mul r2.y, r2, c9.x
mad r1.xy, r2.z, c10.zwzw, r2
mov r1.zw, r0
add oT3.xyz, r3, r4
mov oT1, r1
mov oT2, r1
mov oPos, r0
mad oT0.xy, v3, c20, c20.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_Object2World]
Vector 13 [_CosTime]
Vector 14 [_ProjectionParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [unity_ShadowFadeCenterAndType]
Vector 18 [_tex1_ST]
"!!ARBvp1.0
# 27 ALU
PARAM c[19] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..18] };
TEMP R0;
TEMP R1;
TEMP R2;
ABS R0.x, c[13].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[15];
MUL R0, R0.x, vertex.attrib[14];
ADD R2, R0, vertex.position;
DP4 R1.w, R2, c[8];
DP4 R1.x, R2, c[5];
DP4 R1.y, R2, c[6];
MUL R0.xyz, R1.xyww, c[0].x;
DP4 R1.z, R2, c[7];
MUL R0.y, R0, c[14].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[1], R0;
MOV result.texcoord[2], R0;
DP4 R0.z, R2, c[11];
DP4 R0.x, R2, c[9];
DP4 R0.y, R2, c[10];
ADD R0.xyz, R0, -c[17];
MUL result.texcoord[4].xyz, R0, c[17].w;
MOV R0.w, c[0].y;
ADD R0.y, R0.w, -c[17].w;
DP4 R0.x, R2, c[3];
MOV result.position, R1;
MUL result.texcoord[4].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_CosTime]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Float 15 [_ran]
Vector 16 [unity_LightmapST]
Vector 17 [unity_ShadowFadeCenterAndType]
Vector 18 [_tex1_ST]
"vs_2_0
; 27 ALU
def c19, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_texcoord1 v4
abs r0.x, c12.z
add r0.x, r0, c19
mul r0.x, r0, c15
mul r0, r0.x, v1
add r2, r0, v0
dp4 r1.w, r2, c7
dp4 r1.x, r2, c4
dp4 r1.y, r2, c5
mul r0.xyz, r1.xyww, c19.y
dp4 r1.z, r2, c6
mul r0.y, r0, c13.x
mad r0.xy, r0.z, c14.zwzw, r0
mov r0.zw, r1
mov oT1, r0
mov oT2, r0
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
add r0.xyz, r0, -c17
mul oT4.xyz, r0, c17.w
mov r0.w, c17
add r0.y, c19.z, -r0.w
dp4 r0.x, r2, c2
mov oPos, r1
mul oT4.w, -r0.x, r0.y
mad oT0.xy, v3, c18, c18.zwzw
mad oT3.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_CosTime]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Float 13 [_ran]
Vector 14 [unity_LightmapST]
Vector 15 [_tex1_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R3.xyz, vertex.attrib[14];
MUL R4.xyz, vertex.normal.zxyw, R3.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R3.zxyw, -R4;
ABS R0.x, c[9].z;
ADD R0.x, R0, -c[0];
MUL R0.x, R0, c[13];
MUL R0, R0.x, vertex.attrib[14];
ADD R2, R0, vertex.position;
DP4 R1.w, R2, c[4];
DP4 R1.x, R2, c[1];
DP4 R1.y, R2, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
DP4 R1.z, R2, c[3];
MUL R0.y, R0, c[10].x;
ADD R0.xy, R0, R0.z;
MOV R0.zw, R1;
MOV result.texcoord[1], R0;
MOV result.texcoord[2], R0;
MOV R0.xyz, c[12];
MOV R0.w, c[0].y;
MUL R3.xyz, vertex.attrib[14].w, R3;
DP4 R4.z, R0, c[7];
DP4 R4.x, R0, c[5];
DP4 R4.y, R0, c[6];
MAD R0.xyz, R4, c[11].w, -R2;
DP3 result.texcoord[4].y, R0, R3;
MOV result.position, R1;
DP3 result.texcoord[4].z, vertex.normal, R0;
DP3 result.texcoord[4].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
END
# 31 instructions, 5 R-regs
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
Matrix 4 [_World2Object]
Vector 8 [_CosTime]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Float 13 [_ran]
Vector 14 [unity_LightmapST]
Vector 15 [_tex1_ST]
"vs_2_0
; 32 ALU
def c16, -0.50000000, 0.50000000, 1.00000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r3.xyz, v1
mul r4.xyz, v2.zxyw, r3.yzxw
abs r0.x, c8.z
add r0.x, r0, c16
mul r0.x, r0, c13
mul r0, r0.x, v1
add r2, r0, v0
mov r3.xyz, v1
mad r3.xyz, v2.yzxw, r3.zxyw, -r4
dp4 r1.w, r2, c3
dp4 r1.x, r2, c0
dp4 r1.y, r2, c1
mul r0.xyz, r1.xyww, c16.y
dp4 r1.z, r2, c2
mul r0.y, r0, c9.x
mad r0.xy, r0.z, c10.zwzw, r0
mov r0.zw, r1
mov oT1, r0
mov oT2, r0
mov r0.xyz, c12
mov r0.w, c16.z
mul r3.xyz, v1.w, r3
dp4 r4.z, r0, c6
dp4 r4.x, r0, c4
dp4 r4.y, r0, c5
mad r0.xyz, r4, c11.w, -r2
dp3 oT4.y, r0, r3
mov oPos, r1
dp3 oT4.z, v2, r0
dp3 oT4.x, v1, r0
mad oT0.xy, v3, c15, c15.zwzw
mad oT3.xy, v4, c14, c14.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.xyz, fragment.texcoord[2], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R0.xy, fragment.texcoord[1], R0.x;
MOV result.color.w, c[0].x;
TEX R1.xyz, R0, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
LG2 R1.x, R2.x;
LG2 R1.z, R2.z;
LG2 R1.y, R2.y;
ADD R1.xyz, -R1, fragment.texcoord[3];
MUL R0.xyz, R0, c[1].x;
MUL result.color.xyz, R0, R1;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
"ps_2_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xyz
texld r2, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r1.xy, r1, r0.x
texldp r0, t2, s2
texld r1, r1, s1
add r1.xyz, r2, r1
mul r1.xyz, r1, c2.y
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t3
mov_pp r0.w, c0.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
Vector 1 [unity_LightmapFade]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 24 ALU, 5 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R3.xy, fragment.texcoord[1], R0.x;
MUL R1.xyz, R1.w, R1;
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[3], texture[4], 2D;
TEX R3.xyz, R3, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[2].y;
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[2].y, -R0;
MAD_SAT R0.w, R0, c[1].z, c[1];
MAD R0.xyz, R0.w, R1, R0;
ADD R1.xyz, R2, R3;
LG2 R2.x, R4.x;
LG2 R2.y, R4.y;
LG2 R2.z, R4.z;
ADD R2.xyz, -R2, R0;
MUL R0.xyz, R1, c[2].x;
MUL result.color.xyz, R0, R2;
END
# 24 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 23 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 1.00000000, 0.50000000, 8.00000000, 0
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xy
dcl t4
texldp r4, t2, s2
texld r3, t0, s0
add r0.x, -t1.y, c3
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r2.xy, r1, r0.x
texld r0, t3, s4
texld r1, t3, s3
texld r2, r2, s1
add r2.xyz, r3, r2
mul_pp r3.xyz, r0.w, r0
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mul_pp r3.xyz, r3, c3.z
mul_pp r1.xyz, r1.w, r1
mad_pp r1.xyz, r1, c3.z, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r1, r3
log_pp r1.x, r4.x
log_pp r1.y, r4.y
log_pp r1.z, r4.z
add_pp r0.xyz, -r1, r0
mul r1.xyz, r2, c3.y
mov_pp r0.w, c0.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 20 ALU, 5 TEX
PARAM c[2] = { program.local[0],
		{ 8, 0.5, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[3], texture[4], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R3.xy, fragment.texcoord[1], R0.x;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[1].z;
DP3 R1.x, R1, c[1].x;
LG2 R1.z, R4.z;
LG2 R1.y, R4.y;
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[3], texture[3], 2D;
TEX R3.xyz, R3, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1.x;
LG2 R1.x, R4.x;
MAD R1.xyz, R0, c[1].x, -R1;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R2, c[1].y;
MUL result.color.xyz, R0, R1;
END
# 20 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 19 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 1.00000000, 0.50000000, 0.57735026, 8.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xy
texldp r3, t2, s2
texld r4, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r2.xy, r1, r0.x
texld r1, t3, s3
texld r0, t3, s4
texld r2, r2, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2.z
mul_pp r1.xyz, r1.w, r1
dp3_pp r0.x, r0, c2.w
mul_pp r0.xyz, r1, r0.x
log_pp r1.x, r3.x
log_pp r1.z, r3.z
log_pp r1.y, r3.y
mad_pp r0.xyz, r0, c2.w, -r1
add r2.xyz, r4, r2
mul r1.xyz, r2, c2.y
mov_pp r0.w, c0.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.xyz, fragment.texcoord[2], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R0.xy, fragment.texcoord[1], R0.x;
MOV result.color.w, c[0].x;
TEX R1.xyz, R0, texture[1], 2D;
TEX R0.xyz, fragment.texcoord[0], texture[0], 2D;
ADD R0.xyz, R0, R1;
ADD R1.xyz, R2, fragment.texcoord[3];
MUL R0.xyz, R0, c[1].x;
MUL result.color.xyz, R0, R1;
END
# 10 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
"ps_2_0
; 11 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xyz
texld r2, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r1.xy, r1, r0.x
texldp r0, t2, s2
texld r1, r1, s1
add r1.xyz, r2, r1
mul r1.xyz, r1, c2.y
add_pp r0.xyz, r0, t3
mov_pp r0.w, c0.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
Vector 1 [unity_LightmapFade]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 5 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[3], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R3.xy, fragment.texcoord[1], R0.x;
MUL R1.xyz, R1.w, R1;
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[3], texture[4], 2D;
TEX R3.xyz, R3, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[2].y;
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[2].y, -R0;
MAD_SAT R0.w, R0, c[1].z, c[1];
MAD R0.xyz, R0.w, R1, R0;
ADD R1.xyz, R2, R3;
ADD R2.xyz, R4, R0;
MUL R0.xyz, R1, c[2].x;
MUL result.color.xyz, R0, R2;
END
# 21 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 20 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c3, 1.00000000, 0.50000000, 8.00000000, 0
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xy
dcl t4
texldp r4, t2, s2
texld r2, t3, s3
texld r3, t0, s0
add r0.x, -t1.y, c3
cmp r1.y, c1, t1, r0.x
mov r1.x, t1
rcp r0.x, t1.w
mul r0.xy, r1, r0.x
mul_pp r2.xyz, r2.w, r2
texld r0, r0, s1
texld r1, t3, s4
add r0.xyz, r3, r0
mul r3.xyz, r0, c3.y
dp4 r0.x, t4, t4
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, c3.z
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r2.xyz, r2, c3.z, -r1
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r2, r1
add_pp r0.xyz, r4, r0
mov_pp r0.w, c0.x
mul_pp r0.xyz, r3, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 5 TEX
PARAM c[2] = { program.local[0],
		{ 8, 0.5, 0.57735026 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[3], texture[4], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
RCP R0.x, fragment.texcoord[1].w;
MUL R3.xy, fragment.texcoord[1], R0.x;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[1].z;
DP3 R1.x, R1, c[1].x;
MOV result.color.w, c[0].x;
TEX R0, fragment.texcoord[3], texture[3], 2D;
TEX R3.xyz, R3, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1.x;
MAD R1.xyz, R0, c[1].x, R4;
ADD R2.xyz, R2, R3;
MUL R0.xyz, R2, c[1].y;
MUL result.color.xyz, R0, R1;
END
# 17 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_alph]
Vector 1 [_tex1_TexelSize]
SetTexture 0 [_tex1] 2D
SetTexture 1 [_GrabTexture] 2D
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 16 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 1.00000000, 0.50000000, 0.57735026, 8.00000000
dcl t0.xy
dcl t1.xyzw
dcl t2
dcl t3.xy
texldp r4, t2, s2
texld r3, t0, s0
add r0.x, -t1.y, c2
cmp r1.y, c1, t1, r0.x
rcp r0.x, t1.w
mov r1.x, t1
mul r2.xy, r1, r0.x
texld r1, t3, s3
texld r0, t3, s4
texld r2, r2, s1
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c2.z
add r2.xyz, r3, r2
mul r2.xyz, r2, c2.y
dp3_pp r0.x, r0, c2.w
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0.x
mad_pp r0.xyz, r0, c2.w, r4
mov_pp r0.w, c0.x
mul_pp r0.xyz, r2, r0
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}