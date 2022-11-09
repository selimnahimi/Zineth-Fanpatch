//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Bouncebounce" {
Properties {
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _Alpha ("_Alpha", Float) = 117
 _CutOut ("_CutOut", Range(0,1)) = 0.231
 _Bounce ("_Bounce", Vector) = (0,0,2,0)
 _BounceSpeed ("_BounceSpeed", Vector) = (0,0,1,0)
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="TransparentCutout" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_Time]
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
Vector 24 [_Bounce]
Vector 25 [_BounceSpeed]
Vector 26 [_MainTex_ST]
"!!ARBvp1.0
# 106 ALU
PARAM c[31] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..26],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[25];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[27];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[27];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[28].xyxw;
MAD R3.xyz, R3, R2, c[28].zwzw;
MAD R3.xyz, R3, R2, c[29].xyxw;
MAD R3.xyz, R3, R2, c[29].zwzw;
ADD R1.xyz, R1, c[28].xyxw;
MAD R1.xyz, R1, R0, c[28].zwzw;
MAD R1.xyz, R1, R0, c[29].xyxw;
MAD R1.xyz, R1, R0, c[29].zwzw;
MAD R0.xyz, R1, R0, c[27].wzww;
MAD R3.xyz, R3, R2, c[27].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[30].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[27].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[30].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[27].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[27];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[27];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[28].xyxw;
MAD R3.xyz, R3, R0, c[28].zwzw;
MAD R3.xyz, R3, R0, c[29].xyxw;
MAD R3.xyz, R3, R0, c[29].zwzw;
ADD R1.xyz, R1, c[28].xyxw;
MAD R1.xyz, R1, R2, c[28].zwzw;
MAD R1.xyz, R1, R2, c[29].xyxw;
MAD R3.xyz, R3, R0, c[27].wzww;
MAD R1.xyz, R1, R2, c[29].zwzw;
SGE R4.yz, R1.w, c[30].xxyw;
SLT R4.x, R1.w, c[0].y;
DP3 R0.y, R4, c[27].wzww;
MOV R0.xz, R4;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[27].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[30].xxyw;
MOV R0.w, c[27].z;
MOV R2.xz, R1;
DP3 R2.y, R1, c[27].wzww;
DP3 R5.z, R0, -R2;
MAD R2, R5, c[24], vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0.xyz, c[15];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[14].w, -R2;
MOV R0.w, c[27].z;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP4 result.position.w, R2, c[4];
DP4 result.position.z, R2, c[3];
DP4 result.position.y, R2, c[2];
DP4 result.position.x, R2, c[1];
MUL R2.xyz, R1, vertex.attrib[14].w;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 result.texcoord[3].y, R2, R0;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R3.z, R0, c[19];
DP4 R3.y, R0, c[18];
DP4 R3.x, R0, c[17];
MUL R0.y, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.y;
DP4 R4.z, R1, c[22];
DP4 R4.y, R1, c[21];
DP4 R4.x, R1, c[20];
ADD R1.xyz, R3, R4;
MUL R3.xyz, R0.x, c[23];
MOV R0, c[16];
ADD result.texcoord[2].xyz, R1, R3;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
END
# 106 instructions, 6 R-regs
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
Vector 12 [_Time]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_Bounce]
Vector 24 [_BounceSpeed]
Vector 25 [_MainTex_ST]
"vs_2_0
; 104 ALU
def c26, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c27, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c28, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c13.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
mov r0.y, r2.w
dp3 r0.z, r1, c6
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c26.z
dp4 r2.z, r0, c18
dp4 r2.y, r0, c17
dp4 r2.x, r0, c16
dp4 r3.z, r1, c21
dp4 r3.x, r1, c19
dp4 r3.y, r1, c20
mul r0.z, r2.w, r2.w
add r1.xyz, r2, r3
mad r1.w, r0.x, r0.x, -r0.z
mul r2.xyz, r1.w, c22
mov r0.y, c12.w
mul r0, c24, r0.y
mad r0.x, r0, c28, c28.y
frc r0.x, r0
mad r0.y, r0, c28.x, c28
add oT2.xyz, r1, r2
mad r0.x, r0, c28.z, c28.w
sincos r2.xy, r0.x, c27.xyzw, c26.xyzw
frc r0.y, r0
mad r0.x, r0.y, c28.z, c28.w
sincos r1.xy, r0.x, c27.xyzw, c26.xyzw
mov r1.x, r2.y
mad r0.y, r0.w, c28.x, c28
mad r0.x, r0.z, c28, c28.y
frc r0.y, r0
mad r0.y, r0, c28.z, c28.w
sincos r2.xy, r0.y, c27.xyzw, c26.xyzw
frc r0.x, r0
mad r1.z, r0.x, c28, c28.w
sincos r0.xy, r1.z, c27.xyzw, c26.xyzw
mov r1.w, r2.y
mov r1.z, r0.y
mad r0, r1, c23, v0
mov r1.w, c26.z
mov r1.xyz, c14
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
mad r4.xyz, r2, c13.w, -r0
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r1, c10
dp4 r5.z, c15, r1
mov r1, c9
mov r2, c8
dp4 r5.y, c15, r1
dp4 r5.x, c15, r2
dp3 oT1.y, r5, r3
dp3 oT3.z, v2, r4
dp3 oT3.y, r3, r4
dp3 oT3.x, v1, r4
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
mad oT0.xy, v3, c25, c25.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_Time]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
"!!ARBvp1.0
# 69 ALU
PARAM c[23] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..18],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[16];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[19];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[19];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[20].xyxw;
MAD R3.xyz, R3, R2, c[20].zwzw;
MAD R3.xyz, R3, R2, c[21].xyxw;
MAD R3.xyz, R3, R2, c[21].zwzw;
ADD R1.xyz, R1, c[20].xyxw;
MAD R1.xyz, R1, R0, c[20].zwzw;
MAD R1.xyz, R1, R0, c[21].xyxw;
MAD R1.xyz, R1, R0, c[21].zwzw;
MAD R0.xyz, R1, R0, c[19].wzww;
MAD R3.xyz, R3, R2, c[19].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[22].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[19].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[22].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[19].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[19];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[19];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[20].xyxw;
MAD R3.xyz, R3, R0, c[20].zwzw;
MAD R3.xyz, R3, R0, c[21].xyxw;
MAD R3.xyz, R3, R0, c[21].zwzw;
ADD R1.xyz, R1, c[20].xyxw;
MAD R1.xyz, R1, R2, c[20].zwzw;
MAD R1.xyz, R1, R2, c[21].xyxw;
MAD R1.xyz, R1, R2, c[21].zwzw;
MAD R3.xyz, R3, R0, c[19].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[22].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[19].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[19].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[22].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[19].wzww;
DP3 R5.z, R0, -R2;
MAD R0, R5, c[15], vertex.position;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 69 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"vs_2_0
; 64 ALU
def c17, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c18, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c19, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c14, r0.x
mad r0.x, r2, c19, c19.y
mad r0.y, r2, c19.x, c19
frc r0.x, r0
mad r0.x, r0, c19.z, c19.w
sincos r1.xy, r0.x, c18.xyzw, c17.xyzw
frc r0.y, r0
mad r1.x, r0.y, c19.z, c19.w
sincos r0.xy, r1.x, c18.xyzw, c17.xyzw
mov r0.x, r1.y
mad r0.w, r2, c19.x, c19.y
mad r0.z, r2, c19.x, c19.y
frc r0.w, r0
mad r0.w, r0, c19.z, c19
sincos r2.xy, r0.w, c18.xyzw, c17.xyzw
frc r0.z, r0
mad r0.z, r0, c19, c19.w
sincos r1.xy, r0.z, c18.xyzw, c17.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r0, r0, c13, v0
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT0.xy, v3, c16, c16.zwzw
mad oT1.xy, v4, c15, c15.zwzw
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
Vector 13 [_Time]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 17 [_Bounce]
Vector 18 [_BounceSpeed]
Vector 19 [unity_LightmapST]
Vector 20 [_MainTex_ST]
"!!ARBvp1.0
# 82 ALU
PARAM c[25] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..20],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[18];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[21];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[21];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[22].xyxw;
MAD R3.xyz, R3, R2, c[22].zwzw;
MAD R3.xyz, R3, R2, c[23].xyxw;
MAD R3.xyz, R3, R2, c[23].zwzw;
ADD R1.xyz, R1, c[22].xyxw;
MAD R1.xyz, R1, R0, c[22].zwzw;
MAD R1.xyz, R1, R0, c[23].xyxw;
MAD R1.xyz, R1, R0, c[23].zwzw;
MAD R0.xyz, R1, R0, c[21].wzww;
MAD R3.xyz, R3, R2, c[21].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[24].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[21].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[24].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[21].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[21];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[21];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[22].xyxw;
MAD R3.xyz, R3, R0, c[22].zwzw;
MAD R3.xyz, R3, R0, c[23].xyxw;
MAD R3.xyz, R3, R0, c[23].zwzw;
ADD R1.xyz, R1, c[22].xyxw;
MAD R1.xyz, R1, R2, c[22].zwzw;
MAD R1.xyz, R1, R2, c[23].xyxw;
MAD R3.xyz, R3, R0, c[21].wzww;
MAD R1.xyz, R1, R2, c[23].zwzw;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[24].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[21].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[21].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[24].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[21].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[17], vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[15];
MOV R0.w, c[21].z;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[14].w, -R1;
MUL R1.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[19], c[19].zwzw;
END
# 82 instructions, 6 R-regs
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
Vector 12 [_Time]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c19, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c20, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c21, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c16, r0.x
mad r0.y, r2, c21.x, c21
mad r0.x, r2, c21, c21.y
frc r0.x, r0
mad r1.x, r0, c21.z, c21.w
frc r1.y, r0
sincos r0.xy, r1.x, c20.xyzw, c19.xyzw
mad r0.x, r1.y, c21.z, c21.w
sincos r1.xy, r0.x, c20.xyzw, c19.xyzw
mov r1.x, r0.y
mad r0.x, r2.z, c21, c21.y
mad r0.y, r2.w, c21.x, c21
frc r0.x, r0
mad r0.x, r0, c21.z, c21.w
sincos r2.xy, r0.x, c20.xyzw, c19.xyzw
frc r0.y, r0
mad r1.z, r0.y, c21, c21.w
sincos r0.xy, r1.z, c20.xyzw, c19.xyzw
mov r1.w, r0.y
mov r1.z, r2.y
mad r1, r1, c15, v0
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mov r0.xyz, c14
mov r0.w, c19.z
dp4 r3.z, r0, c10
dp4 r3.y, r0, c9
dp4 r3.x, r0, c8
mad r0.xyz, r3, c13.w, -r1
mul r2.xyz, r2, v1.w
dp3 oT2.z, v2, r0
dp3 oT2.y, r0, r2
dp3 oT2.x, r0, v1
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
mad oT0.xy, v3, c18, c18.zwzw
mad oT1.xy, v4, c17, c17.zwzw
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
Vector 13 [_Time]
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
Vector 25 [_Bounce]
Vector 26 [_BounceSpeed]
Vector 27 [_MainTex_ST]
"!!ARBvp1.0
# 111 ALU
PARAM c[32] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..27],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[26];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[28];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[28];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[29].xyxw;
MAD R3.xyz, R3, R2, c[29].zwzw;
MAD R3.xyz, R3, R2, c[30].xyxw;
MAD R3.xyz, R3, R2, c[30].zwzw;
ADD R1.xyz, R1, c[29].xyxw;
MAD R1.xyz, R1, R0, c[29].zwzw;
MAD R1.xyz, R1, R0, c[30].xyxw;
MAD R1.xyz, R1, R0, c[30].zwzw;
MAD R0.xyz, R1, R0, c[28].wzww;
MAD R3.xyz, R3, R2, c[28].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[31].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[28].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[31].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[28].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[28];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[28];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[29].xyxw;
MAD R3.xyz, R3, R0, c[29].zwzw;
MAD R3.xyz, R3, R0, c[30].xyxw;
MAD R3.xyz, R3, R0, c[30].zwzw;
ADD R1.xyz, R1, c[29].xyxw;
MAD R1.xyz, R1, R2, c[29].zwzw;
MAD R1.xyz, R1, R2, c[30].xyxw;
MAD R1.xyz, R1, R2, c[30].zwzw;
MAD R3.xyz, R3, R0, c[28].wzww;
SGE R4.yz, R1.w, c[31].xxyw;
SLT R4.x, R1.w, c[0].y;
DP3 R0.y, R4, c[28].wzww;
MOV R0.xz, R4;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[28].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[31].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[28].wzww;
DP3 R5.z, R0, -R2;
MAD R2, R5, c[25], vertex.position;
DP4 R0.w, R2, c[4];
DP4 R0.z, R2, c[3];
DP4 R0.x, R2, c[1];
DP4 R0.y, R2, c[2];
MUL R1.xyz, R0.xyww, c[28].y;
MUL R1.y, R1, c[14].x;
ADD result.texcoord[4].xy, R1, R1.z;
MOV R1.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R3;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV R0.w, c[28].z;
MOV R0.xyz, c[16];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[15].w, -R2;
MUL R2.xyz, R1, vertex.attrib[14].w;
MUL R1.xyz, vertex.normal, c[15].w;
MOV R0.w, c[28].z;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].y, R2, R0;
DP3 result.texcoord[3].x, vertex.attrib[14], R0;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R3.z, R0, c[20];
DP4 R3.y, R0, c[19];
DP4 R3.x, R0, c[18];
MUL R0.y, R2.w, R2.w;
MAD R0.x, R0, R0, -R0.y;
DP4 R4.z, R1, c[23];
DP4 R4.y, R1, c[22];
DP4 R4.x, R1, c[21];
ADD R1.xyz, R3, R4;
MUL R3.xyz, R0.x, c[24];
MOV R0, c[17];
ADD result.texcoord[2].xyz, R1, R3;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[27], c[27].zwzw;
END
# 111 instructions, 6 R-regs
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
Vector 12 [_Time]
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
Vector 25 [_Bounce]
Vector 26 [_BounceSpeed]
Vector 27 [_MainTex_ST]
"vs_2_0
; 109 ALU
def c28, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c29, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c30, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c12.w
mul r2, c26, r0.x
mad r0.x, r2, c30, c30.y
mad r0.y, r2, c30.x, c30
frc r0.x, r0
mad r0.x, r0, c30.z, c30.w
sincos r1.xy, r0.x, c29.xyzw, c28.xyzw
frc r0.y, r0
mad r1.x, r0.y, c30.z, c30.w
sincos r0.xy, r1.x, c29.xyzw, c28.xyzw
mov r0.x, r1.y
mad r0.w, r2, c30.x, c30.y
mad r0.z, r2, c30.x, c30.y
frc r0.w, r0
mad r0.w, r0, c30.z, c30
sincos r2.xy, r0.w, c29.xyzw, c28.xyzw
frc r0.z, r0
mad r0.z, r0, c30, c30.w
sincos r1.xy, r0.z, c29.xyzw, c28.xyzw
mov r0.z, r1.y
mov r0.w, r2.y
mad r2, r0, c25, v0
dp4 r3.w, r2, c3
dp4 r3.z, r2, c2
dp4 r3.x, r2, c0
dp4 r3.y, r2, c1
mul r0.xyz, r3.xyww, c28.w
mul r1.xyz, v2, c15.w
mul r0.y, r0, c13.x
mad oT4.xy, r0.z, c14.zwzw, r0
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mov r0.w, c28.z
mul r1, r0.xyzz, r0.yzzx
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
dp4 r4.x, r0, c18
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c23
dp4 r0.y, r1, c22
dp4 r0.x, r1, c21
mul r1.xyz, r0.w, c24
add r0.xyz, r4, r0
add oT2.xyz, r0, r1
mov r0.w, c28.z
mov r0.xyz, c16
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mov r0.xyz, v1
mov oPos, r3
mov oT4.zw, r3
mad r3.xyz, r1, c15.w, -r2
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r0, c9
mov r1, c8
dp4 r4.y, c17, r0
dp4 r4.x, c17, r1
dp3 oT1.y, r4, r2
dp3 oT3.z, v2, r3
dp3 oT3.y, r2, r3
dp3 oT3.x, v1, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
mad oT0.xy, v3, c27, c27.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 16 [_Bounce]
Vector 17 [_BounceSpeed]
Vector 18 [unity_LightmapST]
Vector 19 [_MainTex_ST]
"!!ARBvp1.0
# 74 ALU
PARAM c[24] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..19],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[17];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[20];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[20];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R2, c[21].zwzw;
MAD R3.xyz, R3, R2, c[22].xyxw;
MAD R3.xyz, R3, R2, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R0, c[21].zwzw;
MAD R1.xyz, R1, R0, c[22].xyxw;
MAD R1.xyz, R1, R0, c[22].zwzw;
MAD R0.xyz, R1, R0, c[20].wzww;
MAD R3.xyz, R3, R2, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[20].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[20];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[20];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R0, c[21].zwzw;
MAD R3.xyz, R3, R0, c[22].xyxw;
MAD R3.xyz, R3, R0, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R2, c[21].zwzw;
MAD R1.xyz, R1, R2, c[22].xyxw;
MAD R1.xyz, R1, R2, c[22].zwzw;
MAD R3.xyz, R3, R0, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[20].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[20].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[16], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[20].y;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[2].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[18], c[18].zwzw;
END
# 74 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
"vs_2_0
; 69 ALU
def c19, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c20, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c21, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c16, r0.x
mad r0.x, r2, c21, c21.y
mad r0.y, r2, c21.x, c21
frc r0.x, r0
mad r0.x, r0, c21.z, c21.w
sincos r1.xy, r0.x, c20.xyzw, c19.xyzw
frc r0.y, r0
mad r1.x, r0.y, c21.z, c21.w
sincos r0.xy, r1.x, c20.xyzw, c19.xyzw
mov r0.x, r1.y
mad r0.w, r2, c21.x, c21.y
mad r0.z, r2, c21.x, c21.y
frc r0.w, r0
mad r0.w, r0, c21.z, c21
sincos r2.xy, r0.w, c20.xyzw, c19.xyzw
frc r0.z, r0
mad r0.z, r0, c21, c21.w
sincos r1.xy, r0.z, c20.xyzw, c19.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c15, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c19.w
mul r2.y, r2, c13.x
mad oT2.xy, r2.z, c14.zwzw, r2
mov oPos, r0
mov oT2.zw, r0
mad oT0.xy, v3, c18, c18.zwzw
mad oT1.xy, v4, c17, c17.zwzw
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
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 18 [_Bounce]
Vector 19 [_BounceSpeed]
Vector 20 [unity_LightmapST]
Vector 21 [_MainTex_ST]
"!!ARBvp1.0
# 87 ALU
PARAM c[26] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..21],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[19];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[22];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[22];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R2, c[23].zwzw;
MAD R3.xyz, R3, R2, c[24].xyxw;
MAD R3.xyz, R3, R2, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R0, c[23].zwzw;
MAD R1.xyz, R1, R0, c[24].xyxw;
MAD R1.xyz, R1, R0, c[24].zwzw;
MAD R0.xyz, R1, R0, c[22].wzww;
MAD R3.xyz, R3, R2, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[22].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[22];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[22];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R0, c[23].zwzw;
MAD R3.xyz, R3, R0, c[24].xyxw;
MAD R3.xyz, R3, R0, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R2, c[23].zwzw;
MAD R1.xyz, R1, R2, c[24].xyxw;
MAD R1.xyz, R1, R2, c[24].zwzw;
MAD R3.xyz, R3, R0, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[22].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[22].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[18], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[22].y;
MUL R2.y, R2, c[14].x;
ADD result.texcoord[3].xy, R2, R2.z;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MOV R0.xyz, c[16];
MOV R0.w, c[22].z;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[15].w, -R1;
MUL R1.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R0, R1;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[20], c[20].zwzw;
END
# 87 instructions, 6 R-regs
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
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [unity_Scale]
Vector 16 [_WorldSpaceCameraPos]
Vector 17 [_Bounce]
Vector 18 [_BounceSpeed]
Vector 19 [unity_LightmapST]
Vector 20 [_MainTex_ST]
"vs_2_0
; 83 ALU
def c21, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c22, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c23, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c18, r0.x
mad r0.x, r2, c23, c23.y
mad r0.y, r2, c23.x, c23
frc r0.x, r0
mad r0.x, r0, c23.z, c23.w
sincos r1.xy, r0.x, c22.xyzw, c21.xyzw
frc r0.y, r0
mad r1.x, r0.y, c23.z, c23.w
sincos r0.xy, r1.x, c22.xyzw, c21.xyzw
mov r0.x, r1.y
mad r0.w, r2, c23.x, c23.y
mad r0.z, r2, c23.x, c23.y
frc r0.w, r0
mad r0.w, r0, c23.z, c23
sincos r2.xy, r0.w, c22.xyzw, c21.xyzw
frc r0.z, r0
mad r0.z, r0, c23, c23.w
sincos r1.xy, r0.z, c22.xyzw, c21.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c17, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c21.w
mul r2.y, r2, c13.x
mad oT3.xy, r2.z, c14.zwzw, r2
mov r2.xyz, v1
mov oPos, r0
mov oT3.zw, r0
mov r0.w, c21.z
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mov r0.xyz, c16
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
mad r0.xyz, r3, c15.w, -r1
mul r1.xyz, r2, v1.w
dp3 oT2.z, v2, r0
dp3 oT2.y, r0, r1
dp3 oT2.x, r0, v1
mad oT0.xy, v3, c20, c20.zwzw
mad oT1.xy, v4, c19, c19.zwzw
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
Vector 13 [_Time]
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
Vector 32 [_Bounce]
Vector 33 [_BounceSpeed]
Vector 34 [_MainTex_ST]
"!!ARBvp1.0
# 137 ALU
PARAM c[39] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..34],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MUL R6.xyz, vertex.normal, c[14].w;
MOV R0, c[33];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[35];
MUL R2.xyz, R1, R1;
DP3 R6.w, R6, c[6];
ADD R0.xyz, -R1.w, c[35];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
MUL R3.xyz, R2, c[0].zwzw;
ADD R1.xyz, R1, c[36].xyxw;
MAD R1.xyz, R1, R0, c[36].zwzw;
MAD R1.xyz, R1, R0, c[37].xyxw;
MAD R1.xyz, R1, R0, c[37].zwzw;
ADD R3.xyz, R3, c[36].xyxw;
MAD R3.xyz, R3, R2, c[36].zwzw;
MAD R3.xyz, R3, R2, c[37].xyxw;
MAD R3.xyz, R3, R2, c[37].zwzw;
MAD R1.xyz, R1, R0, c[35].wzww;
DP3 R7.x, R6, c[5];
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[38].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[35].wzww;
DP3 R5.x, R1, -R0;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[38].xxyw;
MOV R0.xz, R1;
MOV R7.y, R6.w;
MAD R2.xyz, R3, R2, c[35].wzww;
DP3 R0.y, R1, c[35].wzww;
DP3 R5.y, R2, -R0;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R0.xyz, -R1.w, c[35];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R1.xyz, -R0.w, c[35];
MUL R1.xyz, R1, R1;
MUL R2.xyz, R1, c[0].zwzw;
ADD R3.xyz, R3, c[36].xyxw;
MAD R3.xyz, R3, R0, c[36].zwzw;
MAD R3.xyz, R3, R0, c[37].xyxw;
MAD R3.xyz, R3, R0, c[37].zwzw;
ADD R2.xyz, R2, c[36].xyxw;
MAD R2.xyz, R2, R1, c[36].zwzw;
MAD R2.xyz, R2, R1, c[37].xyxw;
MAD R2.xyz, R2, R1, c[37].zwzw;
MAD R2.xyz, R2, R1, c[35].wzww;
MAD R3.xyz, R3, R0, c[35].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[38].xxyw;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[38].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[35].wzww;
DP3 R5.w, R3, -R0;
MOV R0.xz, R1;
DP3 R0.y, R1, c[35].wzww;
DP3 R5.z, R2, -R0;
MAD R1, R5, c[32], vertex.position;
DP4 R0.x, R1, c[6];
ADD R3, -R0.x, c[18];
MUL R0, R3, R3;
DP4 R2.x, R1, c[5];
ADD R2, -R2.x, c[17];
MUL R3, R6.w, R3;
MAD R4, R2, R2, R0;
MAD R2, R7.x, R2, R3;
DP4 R5.x, R1, c[7];
ADD R0, -R5.x, c[19];
MAD R4, R0, R0, R4;
DP3 R3.x, R6, c[7];
MAD R0, R3.x, R0, R2;
MUL R5, R4, c[20];
MOV R7.z, R3.x;
MOV R7.w, c[35].z;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[35].z;
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[35].x;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[22];
MAD R2.xyz, R0.x, c[21], R2;
MAD R0.xyz, R0.z, c[23], R2;
MAD R2.xyz, R0.w, c[24], R0;
MUL R0, R7.xyzz, R7.yzzx;
MUL R2.w, R6, R6;
DP4 R4.z, R0, c[30];
DP4 R4.y, R0, c[29];
DP4 R4.x, R0, c[28];
MAD R2.w, R7.x, R7.x, -R2;
MOV R0.w, c[35].z;
DP4 R3.z, R7, c[27];
DP4 R3.y, R7, c[26];
DP4 R3.x, R7, c[25];
ADD R3.xyz, R3, R4;
MUL R0.xyz, R2.w, c[31];
ADD R0.xyz, R3, R0;
ADD result.texcoord[2].xyz, R0, R2;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[15];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MOV R0, c[16];
MUL R2.xyz, R2, vertex.attrib[14].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
MAD R1.xyz, R3, c[14].w, -R1;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].y, R2, R1;
DP3 result.texcoord[3].x, vertex.attrib[14], R1;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[34], c[34].zwzw;
END
# 137 instructions, 8 R-regs
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
Vector 12 [_Time]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
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
Vector 31 [_Bounce]
Vector 32 [_BounceSpeed]
Vector 33 [_MainTex_ST]
"vs_2_0
; 135 ALU
def c34, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c35, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c36, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c37, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r6.xyz, v2, c13.w
dp3 r6.w, r6, c5
mov r0.x, c12.w
mul r2, c32, r0.x
mad r0.x, r2, c36, c36.y
mad r0.y, r2, c36.x, c36
frc r0.x, r0
mad r0.x, r0, c36.z, c36.w
dp3 r7.x, r6, c4
sincos r1.xy, r0.x, c35.xyzw, c34.xyzw
frc r0.y, r0
mad r1.x, r0.y, c36.z, c36.w
sincos r0.xy, r1.x, c35.xyzw, c34.xyzw
mov r0.x, r1.y
mad r0.w, r2, c36.x, c36.y
mad r0.z, r2, c36.x, c36.y
frc r0.w, r0
mad r0.w, r0, c36.z, c36
sincos r2.xy, r0.w, c35.xyzw, c34.xyzw
frc r0.z, r0
mad r0.z, r0, c36, c36.w
sincos r1.xy, r0.z, c35.xyzw, c34.xyzw
mov r7.y, r6.w
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c31, v0
dp4 r0.x, r1, c5
add r3, -r0.x, c17
mul r0, r3, r3
dp4 r2.x, r1, c4
add r2, -r2.x, c16
mul r3, r6.w, r3
mad r4, r2, r2, r0
mad r2, r7.x, r2, r3
dp3 r3.x, r6, c6
dp4 r5.x, r1, c6
add r0, -r5.x, c18
mad r4, r0, r0, r4
mad r0, r3.x, r0, r2
mul r5, r4, c19
mov r7.z, r3.x
mov r7.w, c34.z
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c34.z
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c37.x
mul r0, r0, r2
mul r2.xyz, r0.y, c21
mad r2.xyz, r0.x, c20, r2
mad r0.xyz, r0.z, c22, r2
mad r2.xyz, r0.w, c23, r0
mul r0, r7.xyzz, r7.yzzx
mul r2.w, r6, r6
dp4 r4.z, r0, c29
dp4 r4.y, r0, c28
dp4 r4.x, r0, c27
mad r2.w, r7.x, r7.x, -r2
mul r0.xyz, r2.w, c30
mov r2.w, c34.z
dp4 r3.z, r7, c26
dp4 r3.y, r7, c25
dp4 r3.x, r7, c24
add r3.xyz, r3, r4
add r0.xyz, r3, r0
add oT2.xyz, r0, r2
mov r2.xyz, c14
dp4 r0.z, r2, c10
dp4 r0.y, r2, c9
dp4 r0.x, r2, c8
mad r4.xyz, r0, c13.w, -r1
mov r2.xyz, v1
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r0, c10
dp4 r5.z, c15, r0
mov r0, c9
mov r2, c8
dp4 r5.y, c15, r0
dp4 r5.x, c15, r2
dp3 oT1.y, r5, r3
dp3 oT3.z, v2, r4
dp3 oT3.y, r3, r4
dp3 oT3.x, v1, r4
dp4 oPos.w, r1, c3
dp4 oPos.z, r1, c2
dp4 oPos.y, r1, c1
dp4 oPos.x, r1, c0
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
mad oT0.xy, v3, c33, c33.zwzw
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
Vector 13 [_Time]
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
Vector 33 [_Bounce]
Vector 34 [_BounceSpeed]
Vector 35 [_MainTex_ST]
"!!ARBvp1.0
# 143 ALU
PARAM c[40] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..35],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
MUL R6.xyz, vertex.normal, c[15].w;
DP3 R6.w, R6, c[6];
MOV R0, c[34];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R0.w, c[36];
MUL R2.xyz, R1, R1;
ADD R0.xyz, -R1.w, c[36];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
MUL R3.xyz, R2, c[0].zwzw;
ADD R1.xyz, R1, c[37].xyxw;
MAD R1.xyz, R1, R0, c[37].zwzw;
MAD R1.xyz, R1, R0, c[38].xyxw;
MAD R1.xyz, R1, R0, c[38].zwzw;
ADD R3.xyz, R3, c[37].xyxw;
MAD R3.xyz, R3, R2, c[37].zwzw;
MAD R3.xyz, R3, R2, c[38].xyxw;
MAD R3.xyz, R3, R2, c[38].zwzw;
DP3 R7.x, R6, c[5];
MAD R1.xyz, R1, R0, c[36].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[39].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[36].wzww;
DP3 R5.x, R1, -R0;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[39].xxyw;
MOV R0.xz, R1;
MOV R7.y, R6.w;
MAD R2.xyz, R3, R2, c[36].wzww;
DP3 R0.y, R1, c[36].wzww;
DP3 R5.y, R2, -R0;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R0.xyz, -R1.w, c[36];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R1.xyz, -R0.w, c[36];
MUL R1.xyz, R1, R1;
MUL R2.xyz, R1, c[0].zwzw;
ADD R3.xyz, R3, c[37].xyxw;
MAD R3.xyz, R3, R0, c[37].zwzw;
MAD R3.xyz, R3, R0, c[38].xyxw;
MAD R3.xyz, R3, R0, c[38].zwzw;
ADD R2.xyz, R2, c[37].xyxw;
MAD R2.xyz, R2, R1, c[37].zwzw;
MAD R2.xyz, R2, R1, c[38].xyxw;
MAD R2.xyz, R2, R1, c[38].zwzw;
MAD R2.xyz, R2, R1, c[36].wzww;
MAD R3.xyz, R3, R0, c[36].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[39].xxyw;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[39].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[36].wzww;
DP3 R5.w, R3, -R0;
MOV R0.xz, R1;
DP3 R0.y, R1, c[36].wzww;
DP3 R5.z, R2, -R0;
MAD R1, R5, c[33], vertex.position;
DP4 R0.x, R1, c[6];
ADD R3, -R0.x, c[19];
MUL R0, R3, R3;
DP4 R2.x, R1, c[5];
ADD R2, -R2.x, c[18];
MUL R3, R6.w, R3;
MAD R4, R2, R2, R0;
MAD R2, R7.x, R2, R3;
DP3 R3.w, R6, c[7];
DP4 R5.x, R1, c[7];
ADD R0, -R5.x, c[20];
MAD R4, R0, R0, R4;
MAD R0, R3.w, R0, R2;
MUL R5, R4, c[21];
MOV R7.z, R3.w;
RSQ R2.x, R4.x;
RSQ R2.y, R4.y;
RSQ R2.z, R4.z;
RSQ R2.w, R4.w;
MUL R0, R0, R2;
ADD R2, R5, c[36].z;
MOV R7.w, c[36].z;
RCP R2.x, R2.x;
RCP R2.y, R2.y;
RCP R2.w, R2.w;
RCP R2.z, R2.z;
MAX R0, R0, c[36].x;
MUL R0, R0, R2;
MUL R2.xyz, R0.y, c[23];
MAD R2.xyz, R0.x, c[22], R2;
MAD R0.xyz, R0.z, c[24], R2;
MAD R3.xyz, R0.w, c[25], R0;
MUL R0, R7.xyzz, R7.yzzx;
MUL R2.z, R6.w, R6.w;
DP4 R2.w, R1, c[4];
DP4 R2.x, R1, c[1];
DP4 R2.y, R1, c[2];
MUL R4.xyz, R2.xyww, c[36].y;
DP4 R6.z, R0, c[31];
DP4 R6.y, R0, c[30];
DP4 R6.x, R0, c[29];
MAD R2.z, R7.x, R7.x, -R2;
MUL R0.xyz, R2.z, c[32];
DP4 R2.z, R1, c[3];
MOV R0.w, c[36].z;
DP4 R5.z, R7, c[28];
DP4 R5.y, R7, c[27];
DP4 R5.x, R7, c[26];
ADD R5.xyz, R5, R6;
ADD R0.xyz, R5, R0;
ADD result.texcoord[2].xyz, R0, R3;
MUL R0.y, R4, c[14].x;
MOV R0.x, R4;
ADD result.texcoord[4].xy, R0, R4.z;
MOV R0.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R0.yzxw;
MOV result.position, R2;
MOV result.texcoord[4].zw, R2;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R3;
MOV R0.xyz, c[16];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R1.xyz, R3, c[15].w, -R1;
MUL R2.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].y, R2, R1;
MOV R0, c[17];
DP3 result.texcoord[3].x, vertex.attrib[14], R1;
DP4 R1.z, R0, c[11];
DP4 R1.x, R0, c[9];
DP4 R1.y, R0, c[10];
DP3 result.texcoord[1].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R1;
DP3 result.texcoord[1].x, R1, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[35], c[35].zwzw;
END
# 143 instructions, 8 R-regs
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
Vector 12 [_Time]
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
Vector 33 [_Bounce]
Vector 34 [_BounceSpeed]
Vector 35 [_MainTex_ST]
"vs_2_0
; 141 ALU
def c36, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c37, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c38, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c39, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r6.xyz, v2, c15.w
dp3 r6.w, r6, c5
mov r0.x, c12.w
mul r2, c34, r0.x
mad r0.x, r2, c38, c38.y
mad r0.y, r2, c38.x, c38
frc r0.x, r0
mad r0.x, r0, c38.z, c38.w
dp3 r7.x, r6, c4
sincos r1.xy, r0.x, c37.xyzw, c36.xyzw
frc r0.y, r0
mad r1.x, r0.y, c38.z, c38.w
sincos r0.xy, r1.x, c37.xyzw, c36.xyzw
mov r0.x, r1.y
mad r0.w, r2, c38.x, c38.y
mad r0.z, r2, c38.x, c38.y
frc r0.w, r0
mad r0.w, r0, c38.z, c38
sincos r2.xy, r0.w, c37.xyzw, c36.xyzw
frc r0.z, r0
mad r0.z, r0, c38, c38.w
sincos r1.xy, r0.z, c37.xyzw, c36.xyzw
mov r7.y, r6.w
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c33, v0
dp4 r0.x, r1, c5
add r3, -r0.x, c19
dp4 r2.x, r1, c4
mul r0, r3, r3
add r2, -r2.x, c18
dp4 r5.x, r1, c6
mad r4, r2, r2, r0
mul r3, r6.w, r3
mad r2, r7.x, r2, r3
dp3 r3.w, r6, c6
add r0, -r5.x, c20
mad r4, r0, r0, r4
mad r0, r3.w, r0, r2
mul r5, r4, c21
mov r7.z, r3.w
rsq r2.x, r4.x
rsq r2.y, r4.y
rsq r2.z, r4.z
rsq r2.w, r4.w
mul r0, r0, r2
add r2, r5, c36.z
mov r7.w, c36.z
rcp r2.x, r2.x
rcp r2.y, r2.y
rcp r2.w, r2.w
rcp r2.z, r2.z
max r0, r0, c39.x
mul r0, r0, r2
mul r2.xyz, r0.y, c23
mad r2.xyz, r0.x, c22, r2
mad r0.xyz, r0.z, c24, r2
mad r4.xyz, r0.w, c25, r0
mul r0, r7.xyzz, r7.yzzx
mul r2.z, r6.w, r6.w
dp4 r2.w, r1, c3
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
mul r3.xyz, r2.xyww, c36.w
dp4 r6.z, r0, c31
dp4 r6.y, r0, c30
dp4 r6.x, r0, c29
mad r2.z, r7.x, r7.x, -r2
mul r0.xyz, r2.z, c32
dp4 r2.z, r1, c2
mov oPos, r2
mov oT4.zw, r2
mov r2.xyz, c16
mov r2.w, c36.z
dp4 r5.z, r7, c28
dp4 r5.y, r7, c27
dp4 r5.x, r7, c26
add r5.xyz, r5, r6
add r0.xyz, r5, r0
add oT2.xyz, r0, r4
mov r0.x, r3
mul r0.y, r3, c13.x
mad oT4.xy, r3.z, c14.zwzw, r0
dp4 r0.z, r2, c10
dp4 r0.y, r2, c9
dp4 r0.x, r2, c8
mad r3.xyz, r0, c15.w, -r1
mov r2.xyz, v1
mul r1.xyz, v2.zxyw, r2.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c17, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c17, r1
dp4 r4.x, c17, r0
dp3 oT1.y, r4, r2
dp3 oT3.z, v2, r3
dp3 oT3.y, r2, r3
dp3 oT3.x, v1, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
mad oT0.xy, v3, c35, c35.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="TransparentCutout" }
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_Time]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_Bounce]
Vector 22 [_BounceSpeed]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 96 ALU
PARAM c[28] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..23],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[22];
MUL R5, R0, c[17].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[24];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[24];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R2, c[25].zwzw;
MAD R3.xyz, R3, R2, c[26].xyxw;
MAD R3.xyz, R3, R2, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R0, c[25].zwzw;
MAD R1.xyz, R1, R0, c[26].xyxw;
MAD R1.xyz, R1, R0, c[26].zwzw;
MAD R0.xyz, R1, R0, c[24].wzww;
MAD R3.xyz, R3, R2, c[24].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[27].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[24].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[24];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[24];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R0, c[25].zwzw;
MAD R3.xyz, R3, R0, c[26].xyxw;
MAD R3.xyz, R3, R0, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R2, c[25].zwzw;
MAD R1.xyz, R1, R2, c[26].xyxw;
MAD R1.xyz, R1, R2, c[26].zwzw;
MAD R3.xyz, R3, R0, c[24].wzww;
SGE R4.yz, R1.w, c[27].xxyw;
SLT R4.x, R1.w, c[0].y;
DP3 R0.y, R4, c[24].wzww;
MOV R0.xz, R4;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[24].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[21], vertex.position;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R3.xyz, R3, vertex.attrib[14].w;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV R0, c[20];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[18].w, -R1;
MOV R0.xyz, c[19];
MOV R0.w, c[24].z;
DP4 R4.z, R0, c[11];
DP4 R4.x, R0, c[9];
DP4 R4.y, R0, c[10];
MAD R0.xyz, R4, c[18].w, -R1;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].y, R2, R3;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[2].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 96 instructions, 6 R-regs
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
Vector 16 [_Time]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_Bounce]
Vector 21 [_BounceSpeed]
Vector 22 [_MainTex_ST]
"vs_2_0
; 94 ALU
def c23, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c24, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c25, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c16.w
mul r2, c21, r0.x
mad r0.x, r2, c25, c25.y
mad r0.y, r2, c25.x, c25
frc r0.x, r0
mad r0.x, r0, c25.z, c25.w
sincos r1.xy, r0.x, c24.xyzw, c23.xyzw
frc r0.y, r0
mad r1.x, r0.y, c25.z, c25.w
sincos r0.xy, r1.x, c24.xyzw, c23.xyzw
mov r0.x, r1.y
mad r0.w, r2, c25.x, c25.y
mad r0.z, r2, c25.x, c25.y
frc r0.w, r0
mad r0.w, r0, c25.z, c25
sincos r2.xy, r0.w, c24.xyzw, c23.xyzw
mov r0.w, r2.y
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r3.xyz, v2.yzxw, r2.zxyw, -r3
mov r2, c8
dp4 r4.x, c19, r2
frc r0.z, r0
mad r0.z, r0, c25, c25.w
sincos r1.xy, r0.z, c24.xyzw, c23.xyzw
mov r0.z, r1.y
mad r0, r0, c20, v0
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r2.xyz, c18
mov r2.w, c23.z
mul r3.xyz, r3, v1.w
dp4 oT3.z, r1, c14
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov r1, c10
dp4 r4.z, c19, r1
mov r1, c9
dp4 r4.y, c19, r1
mad r1.xyz, r4, c17.w, -r0
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
mad r2.xyz, r4, c17.w, -r0
dp3 oT1.z, v2, r1
dp3 oT1.y, r1, r3
dp3 oT1.x, r1, v1
dp3 oT2.z, v2, r2
dp3 oT2.y, r3, r2
dp3 oT2.x, v1, r2
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT0.xy, v3, c22, c22.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_Time]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [_MainTex_ST]
"!!ARBvp1.0
# 88 ALU
PARAM c[20] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..15],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[14];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[16];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[16];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[17].xyxw;
MAD R3.xyz, R3, R2, c[17].zwzw;
MAD R3.xyz, R3, R2, c[18].xyxw;
MAD R3.xyz, R3, R2, c[18].zwzw;
ADD R1.xyz, R1, c[17].xyxw;
MAD R1.xyz, R1, R0, c[17].zwzw;
MAD R1.xyz, R1, R0, c[18].xyxw;
MAD R1.xyz, R1, R0, c[18].zwzw;
MAD R0.xyz, R1, R0, c[16].wzww;
MAD R3.xyz, R3, R2, c[16].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[19].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[16].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[19].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[16].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[16];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[16];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[17].xyxw;
MAD R3.xyz, R3, R0, c[17].zwzw;
MAD R3.xyz, R3, R0, c[18].xyxw;
MAD R3.xyz, R3, R0, c[18].zwzw;
ADD R1.xyz, R1, c[17].xyxw;
MAD R1.xyz, R1, R2, c[17].zwzw;
MAD R1.xyz, R1, R2, c[18].xyxw;
MAD R3.xyz, R3, R0, c[16].wzww;
MAD R1.xyz, R1, R2, c[18].zwzw;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[19].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[16].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[16].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[19].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[16].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[13], vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[11];
MOV R0.w, c[16].z;
MUL R2.xyz, R2, vertex.attrib[14].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP4 R3.z, R0, c[7];
DP4 R3.x, R0, c[5];
DP4 R3.y, R0, c[6];
MAD R0.xyz, R3, c[10].w, -R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R2, R0;
MOV R1, c[12];
DP3 result.texcoord[2].x, vertex.attrib[14], R0;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
END
# 88 instructions, 6 R-regs
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
Vector 8 [_Time]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [_Bounce]
Vector 13 [_BounceSpeed]
Vector 14 [_MainTex_ST]
"vs_2_0
; 86 ALU
def c15, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c16, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c17, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c8.w
mul r2, c13, r0.x
mad r0.x, r2, c17, c17.y
mad r0.y, r2, c17.x, c17
frc r0.x, r0
mad r0.x, r0, c17.z, c17.w
sincos r1.xy, r0.x, c16.xyzw, c15.xyzw
frc r0.y, r0
mad r1.x, r0.y, c17.z, c17.w
sincos r0.xy, r1.x, c16.xyzw, c15.xyzw
mov r0.x, r1.y
mad r0.w, r2, c17.x, c17.y
mad r0.z, r2, c17.x, c17.y
frc r0.w, r0
mad r0.w, r0, c17.z, c17
sincos r2.xy, r0.w, c16.xyzw, c15.xyzw
frc r0.z, r0
mad r0.z, r0, c17, c17.w
sincos r1.xy, r0.z, c16.xyzw, c15.xyzw
mov r0.z, r1.y
mov r0.w, r2.y
mad r0, r0, c12, v0
mov r1.w, c15.z
mov r1.xyz, c10
dp4 r2.z, r1, c6
dp4 r2.y, r1, c5
dp4 r2.x, r1, c4
mad r4.xyz, r2, c9.w, -r0
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r1, c6
dp4 r5.z, c11, r1
mov r1, c5
mov r2, c4
dp4 r5.y, c11, r1
dp4 r5.x, c11, r2
dp3 oT1.y, r5, r3
dp3 oT2.z, v2, r4
dp3 oT2.y, r3, r4
dp3 oT2.x, v1, r4
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
mad oT0.xy, v3, c14, c14.zwzw
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
Vector 17 [_Time]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_Bounce]
Vector 22 [_BounceSpeed]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 97 ALU
PARAM c[28] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..23],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[22];
MUL R5, R0, c[17].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[24];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[24];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R2, c[25].zwzw;
MAD R3.xyz, R3, R2, c[26].xyxw;
MAD R3.xyz, R3, R2, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R0, c[25].zwzw;
MAD R1.xyz, R1, R0, c[26].xyxw;
MAD R1.xyz, R1, R0, c[26].zwzw;
MAD R0.xyz, R1, R0, c[24].wzww;
MAD R3.xyz, R3, R2, c[24].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[27].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[24].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[24];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[24];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R0, c[25].zwzw;
MAD R3.xyz, R3, R0, c[26].xyxw;
MAD R3.xyz, R3, R0, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R2, c[25].zwzw;
MAD R1.xyz, R1, R2, c[26].xyxw;
MAD R1.xyz, R1, R2, c[26].zwzw;
MAD R3.xyz, R3, R0, c[24].wzww;
SGE R4.yz, R1.w, c[27].xxyw;
SLT R4.x, R1.w, c[0].y;
DP3 R0.y, R4, c[24].wzww;
MOV R0.xz, R4;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[24].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[21], vertex.position;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R3.xyz, R3, vertex.attrib[14].w;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV R0, c[20];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[18].w, -R1;
MOV R0.xyz, c[19];
MOV R0.w, c[24].z;
DP4 R4.z, R0, c[11];
DP4 R4.x, R0, c[9];
DP4 R4.y, R0, c[10];
MAD R0.xyz, R4, c[18].w, -R1;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].y, R2, R3;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[2].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 97 instructions, 6 R-regs
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
Vector 16 [_Time]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_Bounce]
Vector 21 [_BounceSpeed]
Vector 22 [_MainTex_ST]
"vs_2_0
; 95 ALU
def c23, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c24, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c25, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c16.w
mul r2, c21, r0.x
mad r0.x, r2, c25, c25.y
mad r0.y, r2, c25.x, c25
frc r0.x, r0
mad r0.x, r0, c25.z, c25.w
sincos r1.xy, r0.x, c24.xyzw, c23.xyzw
frc r0.y, r0
mad r1.x, r0.y, c25.z, c25.w
sincos r0.xy, r1.x, c24.xyzw, c23.xyzw
mov r0.x, r1.y
mad r0.w, r2, c25.x, c25.y
mad r0.z, r2, c25.x, c25.y
frc r0.w, r0
mad r0.w, r0, c25.z, c25
sincos r2.xy, r0.w, c24.xyzw, c23.xyzw
mov r0.w, r2.y
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r3.xyz, v2.yzxw, r2.zxyw, -r3
mov r2, c8
dp4 r4.x, c19, r2
frc r0.z, r0
mad r0.z, r0, c25, c25.w
sincos r1.xy, r0.z, c24.xyzw, c23.xyzw
mov r0.z, r1.y
mad r0, r0, c20, v0
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r2.xyz, c18
mov r2.w, c23.z
mul r3.xyz, r3, v1.w
dp4 oT3.w, r1, c15
dp4 oT3.z, r1, c14
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov r1, c10
dp4 r4.z, c19, r1
mov r1, c9
dp4 r4.y, c19, r1
mad r1.xyz, r4, c17.w, -r0
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
mad r2.xyz, r4, c17.w, -r0
dp3 oT1.z, v2, r1
dp3 oT1.y, r1, r3
dp3 oT1.x, r1, v1
dp3 oT2.z, v2, r2
dp3 oT2.y, r3, r2
dp3 oT2.x, v1, r2
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT0.xy, v3, c22, c22.zwzw
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
Vector 17 [_Time]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_Bounce]
Vector 22 [_BounceSpeed]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 96 ALU
PARAM c[28] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..23],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[22];
MUL R5, R0, c[17].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[24];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[24];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R2, c[25].zwzw;
MAD R3.xyz, R3, R2, c[26].xyxw;
MAD R3.xyz, R3, R2, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R0, c[25].zwzw;
MAD R1.xyz, R1, R0, c[26].xyxw;
MAD R1.xyz, R1, R0, c[26].zwzw;
MAD R0.xyz, R1, R0, c[24].wzww;
MAD R3.xyz, R3, R2, c[24].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[27].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[24].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[24];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[24];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R0, c[25].zwzw;
MAD R3.xyz, R3, R0, c[26].xyxw;
MAD R3.xyz, R3, R0, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R2, c[25].zwzw;
MAD R1.xyz, R1, R2, c[26].xyxw;
MAD R1.xyz, R1, R2, c[26].zwzw;
MAD R3.xyz, R3, R0, c[24].wzww;
SGE R4.yz, R1.w, c[27].xxyw;
SLT R4.x, R1.w, c[0].y;
DP3 R0.y, R4, c[24].wzww;
MOV R0.xz, R4;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[24].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[21], vertex.position;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R3.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R3.xyz, R3, vertex.attrib[14].w;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV R0, c[20];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R2.xyz, R2, c[18].w, -R1;
MOV R0.xyz, c[19];
MOV R0.w, c[24].z;
DP4 R4.z, R0, c[11];
DP4 R4.x, R0, c[9];
DP4 R4.y, R0, c[10];
MAD R0.xyz, R4, c[18].w, -R1;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].y, R2, R3;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R3, R0;
DP3 result.texcoord[2].x, vertex.attrib[14], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 96 instructions, 6 R-regs
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
Vector 16 [_Time]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_Bounce]
Vector 21 [_BounceSpeed]
Vector 22 [_MainTex_ST]
"vs_2_0
; 94 ALU
def c23, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c24, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c25, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c16.w
mul r2, c21, r0.x
mad r0.x, r2, c25, c25.y
mad r0.y, r2, c25.x, c25
frc r0.x, r0
mad r0.x, r0, c25.z, c25.w
sincos r1.xy, r0.x, c24.xyzw, c23.xyzw
frc r0.y, r0
mad r1.x, r0.y, c25.z, c25.w
sincos r0.xy, r1.x, c24.xyzw, c23.xyzw
mov r0.x, r1.y
mad r0.w, r2, c25.x, c25.y
mad r0.z, r2, c25.x, c25.y
frc r0.w, r0
mad r0.w, r0, c25.z, c25
sincos r2.xy, r0.w, c24.xyzw, c23.xyzw
mov r0.w, r2.y
mov r2.xyz, v1
mul r3.xyz, v2.zxyw, r2.yzxw
mov r2.xyz, v1
mad r3.xyz, v2.yzxw, r2.zxyw, -r3
mov r2, c8
dp4 r4.x, c19, r2
frc r0.z, r0
mad r0.z, r0, c25, c25.w
sincos r1.xy, r0.z, c24.xyzw, c23.xyzw
mov r0.z, r1.y
mad r0, r0, c20, v0
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
mov r2.xyz, c18
mov r2.w, c23.z
mul r3.xyz, r3, v1.w
dp4 oT3.z, r1, c14
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov r1, c10
dp4 r4.z, c19, r1
mov r1, c9
dp4 r4.y, c19, r1
mad r1.xyz, r4, c17.w, -r0
dp4 r4.z, r2, c10
dp4 r4.x, r2, c8
dp4 r4.y, r2, c9
mad r2.xyz, r4, c17.w, -r0
dp3 oT1.z, v2, r1
dp3 oT1.y, r1, r3
dp3 oT1.x, r1, v1
dp3 oT2.z, v2, r2
dp3 oT2.y, r3, r2
dp3 oT2.x, v1, r2
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mad oT0.xy, v3, c22, c22.zwzw
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
Vector 17 [_Time]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_Bounce]
Vector 22 [_BounceSpeed]
Vector 23 [_MainTex_ST]
"!!ARBvp1.0
# 94 ALU
PARAM c[28] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..23],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[22];
MUL R5, R0, c[17].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[24];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[24];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R2, c[25].zwzw;
MAD R3.xyz, R3, R2, c[26].xyxw;
MAD R3.xyz, R3, R2, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R0, c[25].zwzw;
MAD R1.xyz, R1, R0, c[26].xyxw;
MAD R1.xyz, R1, R0, c[26].zwzw;
MAD R0.xyz, R1, R0, c[24].wzww;
MAD R3.xyz, R3, R2, c[24].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[27].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[24].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[24];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[24];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[25].xyxw;
MAD R3.xyz, R3, R0, c[25].zwzw;
MAD R3.xyz, R3, R0, c[26].xyxw;
MAD R3.xyz, R3, R0, c[26].zwzw;
ADD R1.xyz, R1, c[25].xyxw;
MAD R1.xyz, R1, R2, c[25].zwzw;
MAD R1.xyz, R1, R2, c[26].xyxw;
MAD R3.xyz, R3, R0, c[24].wzww;
MAD R1.xyz, R1, R2, c[26].zwzw;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[27].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[24].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[24].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[27].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[24].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[21], vertex.position;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[19];
MOV R0.w, c[24].z;
MUL R2.xyz, R2, vertex.attrib[14].w;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[18].w, -R1;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].y, R2, R0;
MOV R1, c[20];
DP3 result.texcoord[2].x, vertex.attrib[14], R0;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
END
# 94 instructions, 6 R-regs
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
Vector 16 [_Time]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_Bounce]
Vector 21 [_BounceSpeed]
Vector 22 [_MainTex_ST]
"vs_2_0
; 92 ALU
def c23, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c24, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c25, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c16.w
mul r2, c21, r0.x
mad r0.x, r2, c25, c25.y
mad r0.y, r2, c25.x, c25
frc r0.x, r0
mad r0.x, r0, c25.z, c25.w
sincos r1.xy, r0.x, c24.xyzw, c23.xyzw
frc r0.y, r0
mad r1.x, r0.y, c25.z, c25.w
sincos r0.xy, r1.x, c24.xyzw, c23.xyzw
mov r0.x, r1.y
mad r0.w, r2, c25.x, c25.y
mad r0.z, r2, c25.x, c25.y
frc r0.w, r0
mad r0.w, r0, c25.z, c25
sincos r2.xy, r0.w, c24.xyzw, c23.xyzw
frc r0.z, r0
mad r0.z, r0, c25, c25.w
sincos r1.xy, r0.z, c24.xyzw, c23.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r0, r0, c20, v0
dp4 r1.w, r0, c7
dp4 r1.z, r0, c6
dp4 r1.x, r0, c4
dp4 r1.y, r0, c5
dp4 oT3.y, r1, c13
dp4 oT3.x, r1, c12
mov r1.w, c23.z
mov r1.xyz, c18
dp4 r2.z, r1, c10
dp4 r2.y, r1, c9
dp4 r2.x, r1, c8
mad r4.xyz, r2, c17.w, -r0
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r2.xyz, v2.yzxw, r1.zxyw, -r2
mul r3.xyz, r2, v1.w
mov r1, c10
dp4 r5.z, c19, r1
mov r1, c9
mov r2, c8
dp4 r5.y, c19, r1
dp4 r5.x, c19, r2
dp3 oT1.y, r5, r3
dp3 oT2.z, v2, r4
dp3 oT2.y, r3, r4
dp3 oT2.x, v1, r4
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
mad oT0.xy, v3, c22, c22.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 5 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0, c1.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [unity_Scale]
Vector 11 [_Bounce]
Vector 12 [_BounceSpeed]
Vector 13 [_MainTex_ST]
"!!ARBvp1.0
# 84 ALU
PARAM c[18] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..13],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[12];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[14];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[14];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[15].xyxw;
MAD R3.xyz, R3, R2, c[15].zwzw;
MAD R3.xyz, R3, R2, c[16].xyxw;
MAD R3.xyz, R3, R2, c[16].zwzw;
ADD R1.xyz, R1, c[15].xyxw;
MAD R1.xyz, R1, R0, c[15].zwzw;
MAD R1.xyz, R1, R0, c[16].xyxw;
MAD R1.xyz, R1, R0, c[16].zwzw;
MAD R0.xyz, R1, R0, c[14].wzww;
MAD R3.xyz, R3, R2, c[14].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[17].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[14].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[17].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[14].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[14];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[14];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[15].xyxw;
MAD R3.xyz, R3, R0, c[15].zwzw;
MAD R3.xyz, R3, R0, c[16].xyxw;
MAD R3.xyz, R3, R0, c[16].zwzw;
ADD R1.xyz, R1, c[15].xyxw;
MAD R1.xyz, R1, R2, c[15].zwzw;
MAD R1.xyz, R1, R2, c[16].xyxw;
MAD R1.xyz, R1, R2, c[16].zwzw;
MAD R3.xyz, R3, R0, c[14].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[17].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[14].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[14].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[17].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[14].wzww;
DP3 R5.z, R0, -R2;
MAD R0, R5, c[11], vertex.position;
MOV R1.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP3 R0.y, R1, c[5];
DP3 R0.x, vertex.attrib[14], c[5];
DP3 R0.z, vertex.normal, c[5];
MUL result.texcoord[1].xyz, R0, c[10].w;
DP3 R0.y, R1, c[6];
DP3 R0.x, vertex.attrib[14], c[6];
DP3 R0.z, vertex.normal, c[6];
MUL result.texcoord[2].xyz, R0, c[10].w;
DP3 R0.y, R1, c[7];
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[10].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
END
# 84 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [unity_Scale]
Vector 10 [_Bounce]
Vector 11 [_BounceSpeed]
Vector 12 [_MainTex_ST]
"vs_2_0
; 80 ALU
def c13, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c14, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c15, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c8.w
mul r2, c11, r0.x
mad r0.x, r2, c15, c15.y
mad r0.y, r2, c15.x, c15
frc r0.x, r0
mad r0.x, r0, c15.z, c15.w
sincos r1.xy, r0.x, c14.xyzw, c13.xyzw
frc r0.y, r0
mad r1.x, r0.y, c15.z, c15.w
sincos r0.xy, r1.x, c14.xyzw, c13.xyzw
mov r0.x, r1.y
mad r0.w, r2, c15.x, c15.y
mad r0.z, r2, c15.x, c15.y
frc r0.w, r0
mad r0.w, r0, c15.z, c15
sincos r2.xy, r0.w, c14.xyzw, c13.xyzw
frc r0.z, r0
mad r0.z, r0, c15, c15.w
sincos r1.xy, r0.z, c14.xyzw, c13.xyzw
mov r0.z, r1.y
mov r0.w, r2.y
mad r0, r0, c10, v0
mov r1.xyz, v1
mul r2.xyz, v2.zxyw, r1.yzxw
mov r1.xyz, v1
mad r1.xyz, v2.yzxw, r1.zxyw, -r2
dp4 oPos.w, r0, c3
dp4 oPos.z, r0, c2
dp4 oPos.y, r0, c1
dp4 oPos.x, r0, c0
mul r1.xyz, r1, v1.w
dp3 r0.y, r1, c4
dp3 r0.x, v1, c4
dp3 r0.z, v2, c4
mul oT1.xyz, r0, c9.w
dp3 r0.y, r1, c5
dp3 r0.x, v1, c5
dp3 r0.z, v2, c5
mul oT2.xyz, r0, c9.w
dp3 r0.y, r1, c6
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c9.w
mad oT0.xy, v3, c12, c12.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0, 0.5 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV R0.z, fragment.texcoord[3];
MOV R0.y, fragment.texcoord[2].z;
MOV result.color.w, c[1].x;
KIL -R0.x;
MOV R0.x, fragment.texcoord[1].z;
MAD result.color.xyz, R0, c[1].y, c[1].y;
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 9 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0.50000000, 0
dcl t0.xy
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
texld r0, t0, s0
add r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mov_pp r0.z, t3
mov_pp r0.x, t1.z
mov_pp r0.y, t2.z
mad_pp r0.xyz, r0, c1.z, c1.z
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Transparent" "IGNOREPROJECTOR"="False" "RenderType"="TransparentCutout" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Vector 19 [_Bounce]
Vector 20 [_BounceSpeed]
Vector 21 [_MainTex_ST]
"!!ARBvp1.0
# 91 ALU
PARAM c[26] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..21],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[20];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[22];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[22];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R2, c[23].zwzw;
MAD R3.xyz, R3, R2, c[24].xyxw;
MAD R3.xyz, R3, R2, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R0, c[23].zwzw;
MAD R1.xyz, R1, R0, c[24].xyxw;
MAD R1.xyz, R1, R0, c[24].zwzw;
MAD R0.xyz, R1, R0, c[22].wzww;
MAD R3.xyz, R3, R2, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[22].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[22];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[22];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R0, c[23].zwzw;
MAD R3.xyz, R3, R0, c[24].xyxw;
MAD R3.xyz, R3, R0, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R2, c[23].zwzw;
MAD R1.xyz, R1, R2, c[24].xyxw;
MAD R1.xyz, R1, R2, c[24].zwzw;
MAD R3.xyz, R3, R0, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[22].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[22].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[19], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[22].y;
MUL R1.xyz, vertex.normal, c[11].w;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 R2.w, R1, c[6];
MUL R2.y, R2, c[10].x;
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[22].z;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R0, c[14];
DP4 R2.y, R0, c[13];
DP4 R2.x, R0, c[12];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[17];
DP4 R0.y, R1, c[16];
DP4 R0.x, R1, c[15];
MUL R1.xyz, R0.w, c[18];
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 91 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
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
Vector 19 [_Bounce]
Vector 20 [_BounceSpeed]
Vector 21 [_MainTex_ST]
"vs_2_0
; 86 ALU
def c22, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c23, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c24, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c8.w
mul r2, c20, r0.x
mad r0.x, r2, c24, c24.y
mad r0.y, r2, c24.x, c24
frc r0.x, r0
mad r0.x, r0, c24.z, c24.w
sincos r1.xy, r0.x, c23.xyzw, c22.xyzw
frc r0.y, r0
mad r1.x, r0.y, c24.z, c24.w
sincos r0.xy, r1.x, c23.xyzw, c22.xyzw
mov r0.x, r1.y
mad r0.w, r2, c24.x, c24.y
mad r0.z, r2, c24.x, c24.y
frc r0.w, r0
mad r0.w, r0, c24.z, c24
sincos r2.xy, r0.w, c23.xyzw, c22.xyzw
frc r0.z, r0
mad r0.z, r0, c24, c24.w
sincos r1.xy, r0.z, c23.xyzw, c22.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c19, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c22.w
mul r1.xyz, v2, c11.w
mov oPos, r0
mov oT1.zw, r0
dp3 r2.w, r1, c5
mul r2.y, r2, c9.x
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.z
mad oT1.xy, r2.z, c10.zwzw, r2
dp4 r2.z, r0, c14
dp4 r2.y, r0, c13
dp4 r2.x, r0, c12
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c17
dp4 r0.y, r1, c16
dp4 r0.x, r1, c15
mul r1.xyz, r0.w, c18
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [unity_ShadowFadeCenterAndType]
Vector 19 [_MainTex_ST]
"!!ARBvp1.0
# 83 ALU
PARAM c[24] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[16];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[20];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[20];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R2, c[21].zwzw;
MAD R3.xyz, R3, R2, c[22].xyxw;
MAD R3.xyz, R3, R2, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R0, c[21].zwzw;
MAD R1.xyz, R1, R0, c[22].xyxw;
MAD R1.xyz, R1, R0, c[22].zwzw;
MAD R0.xyz, R1, R0, c[20].wzww;
MAD R3.xyz, R3, R2, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[20].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[20];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[20];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R0, c[21].zwzw;
MAD R3.xyz, R3, R0, c[22].xyxw;
MAD R3.xyz, R3, R0, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R2, c[21].zwzw;
MAD R1.xyz, R1, R2, c[22].xyxw;
MAD R1.xyz, R1, R2, c[22].zwzw;
MAD R3.xyz, R3, R0, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[20].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[20].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[15], vertex.position;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R2.xyz, R0.xyww, c[20].y;
MOV result.position, R0;
MUL R2.y, R2, c[14].x;
MOV result.texcoord[1].zw, R0;
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R0.z, R1, c[11];
ADD R2.xyz, R0, -c[18];
MOV R0.x, c[20].z;
ADD R0.y, R0.x, -c[18].w;
DP4 R0.x, R1, c[3];
MUL result.texcoord[3].xyz, R2, c[18].w;
MUL result.texcoord[3].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 83 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [unity_ShadowFadeCenterAndType]
Vector 19 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c21, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c22, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c16, r0.x
mad r0.x, r2, c22, c22.y
mad r0.y, r2, c22.x, c22
frc r0.x, r0
mad r0.x, r0, c22.z, c22.w
sincos r1.xy, r0.x, c21.xyzw, c20.xyzw
frc r0.y, r0
mad r1.x, r0.y, c22.z, c22.w
sincos r0.xy, r1.x, c21.xyzw, c20.xyzw
mov r0.x, r1.y
mad r0.w, r2, c22.x, c22.y
mad r0.z, r2, c22.x, c22.y
frc r0.w, r0
mad r0.w, r0, c22.z, c22
sincos r2.xy, r0.w, c21.xyzw, c20.xyzw
frc r0.z, r0
mad r0.z, r0, c22, c22.w
sincos r1.xy, r0.z, c21.xyzw, c20.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c15, v0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r2.xyz, r0.xyww, c20.w
mov oPos, r0
mov oT1.zw, r0
mul r2.y, r2, c13.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, r0, -c18
mul oT3.xyz, r0, c18.w
mov r0.w, c18
add r0.y, c20.z, -r0.w
dp4 r0.x, r1, c2
mad oT1.xy, r2.z, c14.zwzw, r2
mul oT3.w, -r0.x, r0.y
mad oT0.xy, v3, c19, c19.zwzw
mad oT2.xy, v4, c17, c17.zwzw
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
Vector 9 [_Time]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 87 ALU
PARAM c[21] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..16],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[14];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[17];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[17];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[18].xyxw;
MAD R3.xyz, R3, R2, c[18].zwzw;
MAD R3.xyz, R3, R2, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
ADD R1.xyz, R1, c[18].xyxw;
MAD R1.xyz, R1, R0, c[18].zwzw;
MAD R1.xyz, R1, R0, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R0.xyz, R1, R0, c[17].wzww;
MAD R3.xyz, R3, R2, c[17].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[20].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[17].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[20].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[17].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[17];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[17];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[18].xyxw;
MAD R3.xyz, R3, R0, c[18].zwzw;
MAD R3.xyz, R3, R0, c[19].xyxw;
MAD R3.xyz, R3, R0, c[19].zwzw;
ADD R1.xyz, R1, c[18].xyxw;
MAD R1.xyz, R1, R2, c[18].zwzw;
MAD R1.xyz, R1, R2, c[19].xyxw;
MAD R1.xyz, R1, R2, c[19].zwzw;
MAD R3.xyz, R3, R0, c[17].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[20].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[17].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[17].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[20].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[17].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[13], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[17].y;
MUL R2.y, R2, c[10].x;
ADD result.texcoord[1].xy, R2, R2.z;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MOV R0.xyz, c[12];
MOV R0.w, c[17].z;
DP4 R3.z, R0, c[7];
DP4 R3.x, R0, c[5];
DP4 R3.y, R0, c[6];
MAD R0.xyz, R3, c[11].w, -R1;
MUL R1.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 87 instructions, 6 R-regs
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
Vector 8 [_Time]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"vs_2_0
; 83 ALU
def c17, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c18, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c19, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c8.w
mul r2, c14, r0.x
mad r0.x, r2, c19, c19.y
mad r0.y, r2, c19.x, c19
frc r0.x, r0
mad r0.x, r0, c19.z, c19.w
sincos r1.xy, r0.x, c18.xyzw, c17.xyzw
frc r0.y, r0
mad r1.x, r0.y, c19.z, c19.w
sincos r0.xy, r1.x, c18.xyzw, c17.xyzw
mov r0.x, r1.y
mad r0.w, r2, c19.x, c19.y
mad r0.z, r2, c19.x, c19.y
frc r0.w, r0
mad r0.w, r0, c19.z, c19
sincos r2.xy, r0.w, c18.xyzw, c17.xyzw
frc r0.z, r0
mad r0.z, r0, c19, c19.w
sincos r1.xy, r0.z, c18.xyzw, c17.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c13, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c17.w
mul r2.y, r2, c9.x
mad oT1.xy, r2.z, c10.zwzw, r2
mov r2.xyz, v1
mov oPos, r0
mov oT1.zw, r0
mov r0.w, c17.z
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mov r0.xyz, c12
dp4 r3.z, r0, c6
dp4 r3.x, r0, c4
dp4 r3.y, r0, c5
mad r0.xyz, r3, c11.w, -r1
mul r1.xyz, r2, v1.w
dp3 oT3.z, v2, r0
dp3 oT3.y, r0, r1
dp3 oT3.x, r0, v1
mad oT0.xy, v3, c16, c16.zwzw
mad oT2.xy, v4, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [unity_SHAr]
Vector 13 [unity_SHAg]
Vector 14 [unity_SHAb]
Vector 15 [unity_SHBr]
Vector 16 [unity_SHBg]
Vector 17 [unity_SHBb]
Vector 18 [unity_SHC]
Vector 19 [_Bounce]
Vector 20 [_BounceSpeed]
Vector 21 [_MainTex_ST]
"!!ARBvp1.0
# 91 ALU
PARAM c[26] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..21],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[20];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[22];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[22];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R2, c[23].zwzw;
MAD R3.xyz, R3, R2, c[24].xyxw;
MAD R3.xyz, R3, R2, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R0, c[23].zwzw;
MAD R1.xyz, R1, R0, c[24].xyxw;
MAD R1.xyz, R1, R0, c[24].zwzw;
MAD R0.xyz, R1, R0, c[22].wzww;
MAD R3.xyz, R3, R2, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[22].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[22];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[22];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[23].xyxw;
MAD R3.xyz, R3, R0, c[23].zwzw;
MAD R3.xyz, R3, R0, c[24].xyxw;
MAD R3.xyz, R3, R0, c[24].zwzw;
ADD R1.xyz, R1, c[23].xyxw;
MAD R1.xyz, R1, R2, c[23].zwzw;
MAD R1.xyz, R1, R2, c[24].xyxw;
MAD R1.xyz, R1, R2, c[24].zwzw;
MAD R3.xyz, R3, R0, c[22].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[25].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[22].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[22].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[25].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[22].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[19], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[22].y;
MUL R1.xyz, vertex.normal, c[11].w;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 R2.w, R1, c[6];
MUL R2.y, R2, c[10].x;
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[22].z;
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R2.z, R0, c[14];
DP4 R2.y, R0, c[13];
DP4 R2.x, R0, c[12];
MUL R0.w, R2, R2;
MAD R0.w, R0.x, R0.x, -R0;
DP4 R0.z, R1, c[17];
DP4 R0.y, R1, c[16];
DP4 R0.x, R1, c[15];
MUL R1.xyz, R0.w, c[18];
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 91 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
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
Vector 19 [_Bounce]
Vector 20 [_BounceSpeed]
Vector 21 [_MainTex_ST]
"vs_2_0
; 86 ALU
def c22, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c23, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c24, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.x, c8.w
mul r2, c20, r0.x
mad r0.x, r2, c24, c24.y
mad r0.y, r2, c24.x, c24
frc r0.x, r0
mad r0.x, r0, c24.z, c24.w
sincos r1.xy, r0.x, c23.xyzw, c22.xyzw
frc r0.y, r0
mad r1.x, r0.y, c24.z, c24.w
sincos r0.xy, r1.x, c23.xyzw, c22.xyzw
mov r0.x, r1.y
mad r0.w, r2, c24.x, c24.y
mad r0.z, r2, c24.x, c24.y
frc r0.w, r0
mad r0.w, r0, c24.z, c24
sincos r2.xy, r0.w, c23.xyzw, c22.xyzw
frc r0.z, r0
mad r0.z, r0, c24, c24.w
sincos r1.xy, r0.z, c23.xyzw, c22.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c19, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c22.w
mul r1.xyz, v2, c11.w
mov oPos, r0
mov oT1.zw, r0
dp3 r2.w, r1, c5
mul r2.y, r2, c9.x
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.z
mad oT1.xy, r2.z, c10.zwzw, r2
dp4 r2.z, r0, c14
dp4 r2.y, r0, c13
dp4 r2.x, r0, c12
mul r0.w, r2, r2
mad r0.w, r0.x, r0.x, -r0
dp4 r0.z, r1, c17
dp4 r0.y, r1, c16
dp4 r0.x, r1, c15
mul r1.xyz, r0.w, c18
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mad oT0.xy, v3, c21, c21.zwzw
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_Time]
Vector 14 [_ProjectionParams]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [unity_ShadowFadeCenterAndType]
Vector 19 [_MainTex_ST]
"!!ARBvp1.0
# 83 ALU
PARAM c[24] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[16];
MUL R5, R0, c[13].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[20];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[20];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R2, c[21].zwzw;
MAD R3.xyz, R3, R2, c[22].xyxw;
MAD R3.xyz, R3, R2, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R0, c[21].zwzw;
MAD R1.xyz, R1, R0, c[22].xyxw;
MAD R1.xyz, R1, R0, c[22].zwzw;
MAD R0.xyz, R1, R0, c[20].wzww;
MAD R3.xyz, R3, R2, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[20].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[20];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[20];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[21].xyxw;
MAD R3.xyz, R3, R0, c[21].zwzw;
MAD R3.xyz, R3, R0, c[22].xyxw;
MAD R3.xyz, R3, R0, c[22].zwzw;
ADD R1.xyz, R1, c[21].xyxw;
MAD R1.xyz, R1, R2, c[21].zwzw;
MAD R1.xyz, R1, R2, c[22].xyxw;
MAD R1.xyz, R1, R2, c[22].zwzw;
MAD R3.xyz, R3, R0, c[20].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[23].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[20].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[20].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[23].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[20].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[15], vertex.position;
DP4 R0.w, R1, c[8];
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MUL R2.xyz, R0.xyww, c[20].y;
MOV result.position, R0;
MUL R2.y, R2, c[14].x;
MOV result.texcoord[1].zw, R0;
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
ADD result.texcoord[1].xy, R2, R2.z;
DP4 R0.z, R1, c[11];
ADD R2.xyz, R0, -c[18];
MOV R0.x, c[20].z;
ADD R0.y, R0.x, -c[18].w;
DP4 R0.x, R1, c[3];
MUL result.texcoord[3].xyz, R2, c[18].w;
MUL result.texcoord[3].w, -R0.x, R0.y;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[19], c[19].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 83 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_Object2World]
Vector 12 [_Time]
Vector 13 [_ProjectionParams]
Vector 14 [_ScreenParams]
Vector 15 [_Bounce]
Vector 16 [_BounceSpeed]
Vector 17 [unity_LightmapST]
Vector 18 [unity_ShadowFadeCenterAndType]
Vector 19 [_MainTex_ST]
"vs_2_0
; 78 ALU
def c20, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c21, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c22, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c12.w
mul r2, c16, r0.x
mad r0.x, r2, c22, c22.y
mad r0.y, r2, c22.x, c22
frc r0.x, r0
mad r0.x, r0, c22.z, c22.w
sincos r1.xy, r0.x, c21.xyzw, c20.xyzw
frc r0.y, r0
mad r1.x, r0.y, c22.z, c22.w
sincos r0.xy, r1.x, c21.xyzw, c20.xyzw
mov r0.x, r1.y
mad r0.w, r2, c22.x, c22.y
mad r0.z, r2, c22.x, c22.y
frc r0.w, r0
mad r0.w, r0, c22.z, c22
sincos r2.xy, r0.w, c21.xyzw, c20.xyzw
frc r0.z, r0
mad r0.z, r0, c22, c22.w
sincos r1.xy, r0.z, c21.xyzw, c20.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c15, v0
dp4 r0.w, r1, c7
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mul r2.xyz, r0.xyww, c20.w
mov oPos, r0
mov oT1.zw, r0
mul r2.y, r2, c13.x
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
add r0.xyz, r0, -c18
mul oT3.xyz, r0, c18.w
mov r0.w, c18
add r0.y, c20.z, -r0.w
dp4 r0.x, r1, c2
mad oT1.xy, r2.z, c14.zwzw, r2
mul oT3.w, -r0.x, r0.y
mad oT0.xy, v3, c19, c19.zwzw
mad oT2.xy, v4, c17, c17.zwzw
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
Vector 9 [_Time]
Vector 10 [_ProjectionParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"!!ARBvp1.0
# 87 ALU
PARAM c[21] = { { 0.15915491, 0.25, 24.980801, -24.980801 },
		state.matrix.mvp,
		program.local[5..16],
		{ 0, 0.5, 1, -1 },
		{ -60.145809, 60.145809, 85.453789, -85.453789 },
		{ -64.939346, 64.939346, 19.73921, -19.73921 },
		{ -9, 0.75 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MOV R0, c[14];
MUL R5, R0, c[9].w;
MAD R0.x, R5, c[0], -c[0].y;
FRC R1.w, R0.x;
MAD R0.y, R5, c[0].x, -c[0];
FRC R0.w, R0.y;
ADD R1.xyz, -R1.w, c[17];
MUL R2.xyz, R1, R1;
MUL R3.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R0.w, c[17];
MUL R0.xyz, R0, R0;
MUL R1.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[18].xyxw;
MAD R3.xyz, R3, R2, c[18].zwzw;
MAD R3.xyz, R3, R2, c[19].xyxw;
MAD R3.xyz, R3, R2, c[19].zwzw;
ADD R1.xyz, R1, c[18].xyxw;
MAD R1.xyz, R1, R0, c[18].zwzw;
MAD R1.xyz, R1, R0, c[19].xyxw;
MAD R1.xyz, R1, R0, c[19].zwzw;
MAD R0.xyz, R1, R0, c[17].wzww;
MAD R3.xyz, R3, R2, c[17].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[20].xxyw;
MOV R2.xz, R4;
DP3 R2.y, R4, c[17].wzww;
DP3 R5.x, R3, -R2;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[20].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[17].wzww;
DP3 R5.y, R0, -R2;
MAD R0.y, R5.w, c[0].x, -c[0];
FRC R1.w, R0.y;
MAD R0.x, R5.z, c[0], -c[0].y;
FRC R0.w, R0.x;
ADD R1.xyz, -R0.w, c[17];
MUL R2.xyz, R1, R1;
MUL R1.xyz, R2, c[0].zwzw;
ADD R0.xyz, -R1.w, c[17];
MUL R0.xyz, R0, R0;
MUL R3.xyz, R0, c[0].zwzw;
ADD R3.xyz, R3, c[18].xyxw;
MAD R3.xyz, R3, R0, c[18].zwzw;
MAD R3.xyz, R3, R0, c[19].xyxw;
MAD R3.xyz, R3, R0, c[19].zwzw;
ADD R1.xyz, R1, c[18].xyxw;
MAD R1.xyz, R1, R2, c[18].zwzw;
MAD R1.xyz, R1, R2, c[19].xyxw;
MAD R1.xyz, R1, R2, c[19].zwzw;
MAD R3.xyz, R3, R0, c[17].wzww;
SLT R4.x, R1.w, c[0].y;
SGE R4.yz, R1.w, c[20].xxyw;
MOV R0.xz, R4;
DP3 R0.y, R4, c[17].wzww;
DP3 R5.w, R3, -R0;
MAD R0.xyz, R1, R2, c[17].wzww;
SLT R1.x, R0.w, c[0].y;
SGE R1.yz, R0.w, c[20].xxyw;
MOV R2.xz, R1;
DP3 R2.y, R1, c[17].wzww;
DP3 R5.z, R0, -R2;
MAD R1, R5, c[13], vertex.position;
DP4 R0.w, R1, c[4];
DP4 R0.z, R1, c[3];
DP4 R0.x, R1, c[1];
DP4 R0.y, R1, c[2];
MUL R2.xyz, R0.xyww, c[17].y;
MUL R2.y, R2, c[10].x;
ADD result.texcoord[1].xy, R2, R2.z;
MOV R2.xyz, vertex.attrib[14];
MUL R3.xyz, vertex.normal.zxyw, R2.yzxw;
MAD R2.xyz, vertex.normal.yzxw, R2.zxyw, -R3;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MOV R0.xyz, c[12];
MOV R0.w, c[17].z;
DP4 R3.z, R0, c[7];
DP4 R3.x, R0, c[5];
DP4 R3.y, R0, c[6];
MAD R0.xyz, R3, c[11].w, -R1;
MUL R1.xyz, R2, vertex.attrib[14].w;
DP3 result.texcoord[3].z, vertex.normal, R0;
DP3 result.texcoord[3].y, R0, R1;
DP3 result.texcoord[3].x, R0, vertex.attrib[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
END
# 87 instructions, 6 R-regs
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
Vector 8 [_Time]
Vector 9 [_ProjectionParams]
Vector 10 [_ScreenParams]
Vector 11 [unity_Scale]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_Bounce]
Vector 14 [_BounceSpeed]
Vector 15 [unity_LightmapST]
Vector 16 [_MainTex_ST]
"vs_2_0
; 83 ALU
def c17, -0.02083333, -0.12500000, 1.00000000, 0.50000000
def c18, -0.00000155, -0.00002170, 0.00260417, 0.00026042
def c19, 0.15915491, 0.50000000, 6.28318501, -3.14159298
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.x, c8.w
mul r2, c14, r0.x
mad r0.x, r2, c19, c19.y
mad r0.y, r2, c19.x, c19
frc r0.x, r0
mad r0.x, r0, c19.z, c19.w
sincos r1.xy, r0.x, c18.xyzw, c17.xyzw
frc r0.y, r0
mad r1.x, r0.y, c19.z, c19.w
sincos r0.xy, r1.x, c18.xyzw, c17.xyzw
mov r0.x, r1.y
mad r0.w, r2, c19.x, c19.y
mad r0.z, r2, c19.x, c19.y
frc r0.w, r0
mad r0.w, r0, c19.z, c19
sincos r2.xy, r0.w, c18.xyzw, c17.xyzw
frc r0.z, r0
mad r0.z, r0, c19, c19.w
sincos r1.xy, r0.z, c18.xyzw, c17.xyzw
mov r0.w, r2.y
mov r0.z, r1.y
mad r1, r0, c13, v0
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mul r2.xyz, r0.xyww, c17.w
mul r2.y, r2, c9.x
mad oT1.xy, r2.z, c10.zwzw, r2
mov r2.xyz, v1
mov oPos, r0
mov oT1.zw, r0
mov r0.w, c17.z
mov r0.xyz, v1
mul r2.xyz, v2.zxyw, r2.yzxw
mad r2.xyz, v2.yzxw, r0.zxyw, -r2
mov r0.xyz, c12
dp4 r3.z, r0, c6
dp4 r3.x, r0, c4
dp4 r3.y, r0, c5
mad r0.xyz, r3, c11.w, -r1
mul r1.xyz, r2, v1.w
dp3 oT3.z, v2, r0
dp3 oT3.y, r0, r1
dp3 oT3.x, r0, v1
mad oT0.xy, v3, c16, c16.zwzw
mad oT2.xy, v4, c15, c15.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0.0039215689 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
SLT R0.w, R0, c[1].x;
MOV result.color.xyz, R0;
KIL -R0.w;
MOV R0.w, c[0].x;
MUL result.color.w, R0, c[2].x;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Float 0 [_Alpha]
Float 1 [_CutOut]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
def c2, 0.00392157, 0.00000000, 1.00000000, 0
dcl t0.xy
texld r0, t0, s0
add r1.x, r0.w, -c1
cmp r1.x, r1, c2.y, c2.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov r1.x, c2
mul r0.w, c0.x, r1.x
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}