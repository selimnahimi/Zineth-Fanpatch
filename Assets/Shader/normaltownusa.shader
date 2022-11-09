//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "NormalTownUSA" {
Properties {
 _Color ("_Color", Color) = (0.38288,0.655935,0.932836,0.576471)
 _Amount ("_Amount", Range(-1,1)) = 0.179
 _TurboSize ("_TurboSize", Vector) = (1,0,0,0)
}
SubShader { 
 Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
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
"!!ARBvp1.0
# 45 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R0.zw, R1, c[6];
DP3 R4.x, R1, c[5];
DP3 R4.z, R1, c[7];
MOV R4.y, R0.z;
MUL R1, R4.xyzz, R4.yzzx;
MOV R4.w, c[0].x;
MUL R0.x, R0.z, R0.z;
MAD R0.x, R4, R4, -R0;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[18];
DP4 R2.y, R4, c[17];
DP4 R2.x, R4, c[16];
ADD R1.xyz, R2, R3;
MUL R0.xyz, R0.x, c[22];
ADD result.texcoord[2].xyz, R1, R0;
MOV R1.xyz, c[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[15];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MOV result.texcoord[0].z, R4;
MOV result.texcoord[0].y, R0.w;
MOV result.texcoord[0].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 45 instructions, 5 R-regs
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
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
"vs_2_0
; 48 ALU
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r0.xyz, v2, c12.w
dp3 r2.zw, r0, c5
dp3 r5.x, r0, c4
dp3 r5.z, r0, c6
mov r5.y, r2.z
mul r0, r5.xyzz, r5.yzzx
mov r5.w, c22.x
mul r1.w, r2.z, r2.z
dp4 r3.z, r0, c20
dp4 r3.y, r0, c19
dp4 r3.x, r0, c18
mad r1.w, r5.x, r5.x, -r1
mov r0.w, c22.x
mul r0.xyz, r1.w, c21
dp4 r1.z, r5, c17
dp4 r1.y, r5, c16
dp4 r1.x, r5, c15
add r1.xyz, r1, r3
add oT2.xyz, r1, r0
mov r0.xyz, c13
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r1, c9
mov r0, c8
dp4 r4.y, c14, r1
dp4 r4.x, c14, r0
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mov oT0.z, r5
mov oT0.y, r2.w
mov oT0.x, r5
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
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [unity_Scale]
Vector 15 [unity_LightmapST]
"!!ARBvp1.0
# 9 ALU
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[13].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 12 [unity_Scale]
Vector 13 [unity_LightmapST]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v3
mul r0.xyz, v2, c12.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
mad oT1.xy, v3, c13, c13.zwzw
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
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 22 ALU
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
DP3 result.texcoord[2].y, R0, R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 result.texcoord[2].z, vertex.normal, R0;
DP3 result.texcoord[2].x, R0, vertex.attrib[14];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 22 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_LightmapST]
"vs_2_0
; 23 ALU
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c13
mov r0.w, c15.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c12.w, -v0
dp3 oT2.y, r0, r1
mul r1.xyz, v2, c12.w
dp3 oT2.z, v2, r0
dp3 oT2.x, r0, v1
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mad oT1.xy, v3, c14, c14.zwzw
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
"!!ARBvp1.0
# 50 ALU
PARAM c[24] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R0.zw, R1, c[6];
DP3 R4.x, R1, c[5];
DP3 R4.z, R1, c[7];
MOV R4.y, R0.z;
MUL R1, R4.xyzz, R4.yzzx;
MOV R4.w, c[0].x;
MUL R0.x, R0.z, R0.z;
MAD R0.x, R4, R4, -R0;
DP4 R3.z, R1, c[22];
DP4 R3.y, R1, c[21];
DP4 R3.x, R1, c[20];
MOV R1.w, c[0].x;
DP4 R2.z, R4, c[19];
DP4 R2.y, R4, c[18];
DP4 R2.x, R4, c[17];
ADD R1.xyz, R2, R3;
MUL R0.xyz, R0.x, c[23];
ADD result.texcoord[2].xyz, R1, R0;
MOV R1.xyz, c[15];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[14].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R1, c[16];
MUL R0.xyz, R0, vertex.attrib[14].w;
DP4 R3.z, R1, c[11];
DP4 R3.y, R1, c[10];
DP4 R3.x, R1, c[9];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R3, R0;
DP3 result.texcoord[3].y, R0, R2;
MUL R0.xyz, R1.xyww, c[0].y;
MUL R0.y, R0, c[13].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MOV result.texcoord[0].z, R4;
MOV result.texcoord[0].y, R0.w;
MOV result.texcoord[0].x, R4;
END
# 50 instructions, 5 R-regs
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
"vs_2_0
; 53 ALU
def c24, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r0.xyz, v2, c14.w
dp3 r2.zw, r0, c5
dp3 r5.x, r0, c4
dp3 r5.z, r0, c6
mov r5.y, r2.z
mul r0, r5.xyzz, r5.yzzx
mov r5.w, c24.x
mul r1.w, r2.z, r2.z
dp4 r3.z, r0, c22
dp4 r3.y, r0, c21
dp4 r3.x, r0, c20
mad r1.w, r5.x, r5.x, -r1
mov r0.w, c24.x
mul r0.xyz, r1.w, c23
dp4 r1.z, r5, c19
dp4 r1.y, r5, c18
dp4 r1.x, r5, c17
add r1.xyz, r1, r3
add oT2.xyz, r1, r0
mov r0.xyz, c15
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c8
dp4 r4.x, c16, r0
mov r1, c9
dp4 r4.y, c16, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c24.y
mul r1.y, r1, c12.x
dp3 oT1.y, r4, r2
dp3 oT3.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT3.z, v2, r3
dp3 oT3.x, v1, r3
mad oT4.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT0.z, r5
mov oT0.y, r2.w
mov oT0.x, r5
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 14 ALU
PARAM c[17] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[14].w;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MAD result.texcoord[1].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 14 instructions, 2 R-regs
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
Vector 14 [unity_Scale]
Vector 15 [unity_LightmapST]
"vs_2_0
; 14 ALU
def c16, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c16.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mul r1.xyz, v2, c14.w
mov oPos, r0
mov oT2.zw, r0
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mad oT1.xy, v3, c15, c15.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 17 [unity_LightmapST]
"!!ARBvp1.0
# 27 ALU
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[14].w, -vertex.position;
DP3 result.texcoord[2].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[3].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, R2, vertex.attrib[14];
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MAD result.texcoord[1].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 27 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"vs_2_0
; 28 ALU
def c17, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c15
mov r1.w, c17.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
dp3 oT2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c17.y
mul r1.y, r1, c12.x
mad oT3.xy, r1.z, c13.zwzw, r1
mul r1.xyz, v2, c14.w
dp3 oT2.z, v2, r2
dp3 oT2.x, r2, v1
mov oPos, r0
mov oT3.zw, r0
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mad oT1.xy, v3, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
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
"!!ARBvp1.0
# 76 ALU
PARAM c[31] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..30] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R4.xyz, vertex.normal, c[13].w;
DP3 R4.w, R4, c[5];
DP3 R3.zw, R4, c[6];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
MUL R2, R3.z, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MAD R2, R4.w, R0, R2;
MUL R1, R1, R1;
MAD R0, R0, R0, R1;
DP4 R3.x, vertex.position, c[7];
ADD R1, -R3.x, c[18];
DP3 R3.xy, R4, c[7];
MAD R0, R1, R1, R0;
MAD R1, R3.x, R1, R2;
MUL R2, R0, c[19];
MOV R4.x, R3.z;
MOV R4.y, R3.x;
MOV R4.z, c[0].x;
RSQ R0.x, R0.x;
RSQ R0.y, R0.y;
RSQ R0.w, R0.w;
RSQ R0.z, R0.z;
MUL R0, R1, R0;
ADD R1, R2, c[0].x;
DP4 R2.z, R4.wxyz, c[26];
DP4 R2.y, R4.wxyz, c[25];
DP4 R2.x, R4.wxyz, c[24];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.wxyy, R4.xyyw;
MUL R1.w, R3.z, R3.z;
DP4 R4.z, R0, c[29];
DP4 R4.y, R0, c[28];
DP4 R4.x, R0, c[27];
MAD R1.w, R4, R4, -R1;
MUL R0.xyz, R1.w, c[30];
ADD R2.xyz, R2, R4;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R4.z, R0, c[11];
DP4 R4.y, R0, c[10];
DP4 R4.x, R0, c[9];
DP3 result.texcoord[1].y, R4, R1;
DP3 result.texcoord[3].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R4;
DP3 result.texcoord[1].x, R4, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
MOV result.texcoord[0].z, R3.y;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R4.w;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 76 instructions, 5 R-regs
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
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
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
"vs_2_0
; 79 ALU
def c30, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r4.xyz, v2, c12.w
dp3 r4.w, r4, c4
dp3 r3.zw, r4, c5
dp4 r0.x, v0, c5
add r1, -r0.x, c16
mul r2, r3.z, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c15
mad r2, r4.w, r0, r2
mul r1, r1, r1
mad r0, r0, r0, r1
dp4 r3.x, v0, c6
add r1, -r3.x, c17
dp3 r3.xy, r4, c6
mad r0, r1, r1, r0
mad r1, r3.x, r1, r2
mul r2, r0, c18
mov r4.x, r3.z
mov r4.y, r3.x
mov r4.z, c30.x
rsq r0.x, r0.x
rsq r0.y, r0.y
rsq r0.w, r0.w
rsq r0.z, r0.z
mul r0, r1, r0
add r1, r2, c30.x
dp4 r2.z, r4.wxyz, c25
dp4 r2.y, r4.wxyz, c24
dp4 r2.x, r4.wxyz, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c30.y
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r4.wxyy, r4.xyyw
mul r1.w, r3.z, r3.z
dp4 r4.z, r0, c28
dp4 r4.y, r0, c27
dp4 r4.x, r0, c26
mad r1.w, r4, r4, -r1
add r2.xyz, r2, r4
mul r0.xyz, r1.w, c29
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c30.x
mov r0.xyz, c13
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r4.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r5.z, c14, r0
mov r0, c9
mov r1, c8
dp4 r5.y, c14, r0
dp4 r5.x, c14, r1
dp3 oT1.y, r5, r2
dp3 oT3.y, r2, r4
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
dp3 oT3.z, v2, r4
dp3 oT3.x, v1, r4
mov oT0.z, r3.y
mov oT0.y, r3.w
mov oT0.x, r4.w
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
"!!ARBvp1.0
# 81 ALU
PARAM c[32] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..31] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R4.xyz, vertex.normal, c[14].w;
DP3 R4.w, R4, c[5];
DP3 R3.zw, R4, c[6];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[18];
MUL R2, R3.z, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[17];
MAD R2, R4.w, R0, R2;
MUL R1, R1, R1;
MAD R0, R0, R0, R1;
DP4 R3.x, vertex.position, c[7];
ADD R1, -R3.x, c[19];
DP3 R3.xy, R4, c[7];
MAD R0, R1, R1, R0;
MAD R1, R3.x, R1, R2;
MUL R2, R0, c[20];
MOV R4.x, R3.z;
MOV R4.y, R3.x;
MOV R4.z, c[0].x;
RSQ R0.x, R0.x;
RSQ R0.y, R0.y;
RSQ R0.w, R0.w;
RSQ R0.z, R0.z;
MUL R0, R1, R0;
ADD R1, R2, c[0].x;
DP4 R2.z, R4.wxyz, c[27];
DP4 R2.y, R4.wxyz, c[26];
DP4 R2.x, R4.wxyz, c[25];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[22];
MAD R1.xyz, R0.x, c[21], R1;
MAD R0.xyz, R0.z, c[23], R1;
MAD R1.xyz, R0.w, c[24], R0;
MUL R0, R4.wxyy, R4.xyyw;
MUL R1.w, R3.z, R3.z;
DP4 R4.z, R0, c[30];
DP4 R4.y, R0, c[29];
DP4 R4.x, R0, c[28];
MAD R1.w, R4, R4, -R1;
MUL R0.xyz, R1.w, c[31];
ADD R2.xyz, R2, R4;
ADD R0.xyz, R2, R0;
ADD result.texcoord[2].xyz, R0, R1;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[14].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[16];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R4.z, R0, c[11];
DP4 R4.y, R0, c[10];
DP4 R4.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R4, R1;
DP3 result.texcoord[3].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[1].z, vertex.normal, R4;
DP3 result.texcoord[1].x, R4, vertex.attrib[14];
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, vertex.attrib[14], R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[0].z, R3.y;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R4.w;
END
# 81 instructions, 5 R-regs
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
"vs_2_0
; 84 ALU
def c32, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mul r4.xyz, v2, c14.w
dp3 r4.w, r4, c4
dp3 r3.zw, r4, c5
dp4 r0.x, v0, c5
add r1, -r0.x, c18
mul r2, r3.z, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c17
mad r2, r4.w, r0, r2
mul r1, r1, r1
mad r0, r0, r0, r1
dp4 r3.x, v0, c6
add r1, -r3.x, c19
dp3 r3.xy, r4, c6
mad r0, r1, r1, r0
mad r1, r3.x, r1, r2
mul r2, r0, c20
mov r4.x, r3.z
mov r4.y, r3.x
mov r4.z, c32.x
rsq r0.x, r0.x
rsq r0.y, r0.y
rsq r0.w, r0.w
rsq r0.z, r0.z
mul r0, r1, r0
add r1, r2, c32.x
dp4 r2.z, r4.wxyz, c27
dp4 r2.y, r4.wxyz, c26
dp4 r2.x, r4.wxyz, c25
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c22
mad r1.xyz, r0.x, c21, r1
mad r0.xyz, r0.z, c23, r1
mad r1.xyz, r0.w, c24, r0
mul r0, r4.wxyy, r4.xyyw
mul r1.w, r3.z, r3.z
dp4 r4.z, r0, c30
dp4 r4.y, r0, c29
dp4 r4.x, r0, c28
mad r1.w, r4, r4, -r1
add r2.xyz, r2, r4
mul r0.xyz, r1.w, c31
add r0.xyz, r2, r0
add oT2.xyz, r0, r1
mov r0.w, c32.x
mov r0.xyz, c15
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r4.xyz, r1, c14.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r5.z, c16, r0
mov r0, c9
dp4 r5.y, c16, r0
mov r1, c8
dp4 r5.x, c16, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c32.z
mul r1.y, r1, c12.x
dp3 oT1.y, r5, r2
dp3 oT3.y, r2, r4
dp3 oT1.z, v2, r5
dp3 oT1.x, r5, v1
dp3 oT3.z, v2, r4
dp3 oT3.x, v1, r4
mad oT4.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT0.z, r3.y
mov oT0.y, r3.w
mov oT0.x, r4.w
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 0 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
ADD R0.xyz, fragment.texcoord[0], c[3];
MUL R1.xyz, R0, c[2].x;
ADD R1.xyz, R1, c[1];
MAX R0.x, fragment.texcoord[1].z, c[4];
MUL R0.xyz, R0.x, c[0];
MUL R2.xyz, R1, fragment.texcoord[2];
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[4].y, R2;
MOV result.color.w, c[4].z;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
"ps_2_0
; 10 ALU
def c4, 0.00000000, 2.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
add r0.xyz, t0, c3
mul r1.xyz, r0, c2.x
max_pp r0.x, t1.z, c4
add r1.xyz, r1, c1
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r0, r1
mul_pp r1.xyz, r1, t2
mov_pp r0.w, c4.z
mad_pp r0.xyz, r0, c4.y, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[1], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R1.xyz, R1, c[1].x;
ADD R1.xyz, R1, c[0];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[3].y;
MOV result.color.w, c[3].x;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [unity_Lightmap] 2D
"ps_2_0
; 8 ALU, 1 TEX
dcl_2d s0
def c3, 8.00000000, 1.00000000, 0, 0
dcl t0.xyz
dcl t1.xy
texld r0, t1, s0
mul_pp r0.xyz, r0.w, r0
add r1.xyz, t0, c2
mul r1.xyz, r1, c1.x
add r1.xyz, r1, c0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c3.x
mov_pp r0.w, c3.y
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [unity_Lightmap] 2D
SetTexture 1 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 8, 0.57735026, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R2.xyz, R1.w, R1;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R1.xyz, R1, c[1].x;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R2, c[3].y;
DP3 R0.w, R2, c[3].x;
ADD R1.xyz, R1, c[0];
MUL R0.xyz, R0, R0.w;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[3].x;
MOV result.color.w, c[3].z;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [unity_Lightmap] 2D
SetTexture 1 [unity_LightmapInd] 2D
"ps_2_0
; 12 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c3, 0.57735026, 8.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1.xy
texld r1, t1, s0
texld r0, t1, s1
mul_pp r2.xyz, r0.w, r0
add r0.xyz, t0, c2
mul_pp r2.xyz, r2, c3.x
mul r0.xyz, r0, c1.x
mul_pp r1.xyz, r1.w, r1
dp3_pp r2.x, r2, c3.y
add r0.xyz, r0, c0
mul_pp r1.xyz, r1, r2.x
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c3.y
mov_pp r0.w, c3.z
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[4], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[0], c[3];
MAX R0.x, fragment.texcoord[1].z, c[4];
MUL R1.xyz, R1, c[2].x;
MUL R0.xyz, R0.x, c[0];
ADD R1.xyz, R1, c[1];
MUL R0.xyz, R2.x, R0;
MUL R2.xyz, R1, fragment.texcoord[2];
MUL R0.xyz, R0, R1;
MAD result.color.xyz, R0, c[4].y, R2;
MOV result.color.w, c[4].z;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 11 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 2.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dcl t4
texldp r2, t4, s0
add r0.xyz, t0, c3
max_pp r1.x, t1.z, c4
mul r0.xyz, r0, c2.x
add r0.xyz, r0, c1
mul_pp r1.xyz, r1.x, c0
mul_pp r1.xyz, r2.x, r1
mul_pp r1.xyz, r1, r0
mul_pp r0.xyz, r0, t2
mov_pp r0.w, c4.z
mad_pp r0.xyz, r1, c4.y, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 2 TEX
PARAM c[4] = { program.local[0..2],
		{ 1, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R1.x, fragment.texcoord[2], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
MUL R2.xyz, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL R2.xyz, R2, c[3].z;
MUL R0.xyz, R0, c[3].y;
MIN R1.yzw, R0.xxyz, R2.xxyz;
MUL R0.xyz, R0, R1.x;
ADD R2.xyz, fragment.texcoord[0], c[2];
MAX R0.xyz, R1.yzww, R0;
MUL R2.xyz, R2, c[1].x;
ADD R1.xyz, R2, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].x;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 13 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c3, 8.00000000, 2.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1.xy
dcl t2
texldp r3, t2, s0
texld r1, t1, s1
mul_pp r0.xyz, r1, r3.x
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r0, c3.y
mul_pp r1.xyz, r1, c3.x
min_pp r2.xyz, r1, r0
add r0.xyz, t0, c2
mul_pp r1.xyz, r1, r3.x
mul r0.xyz, r0, c1.x
max_pp r1.xyz, r2, r1
add r0.xyz, r0, c0
mul_pp r0.xyz, r0, r1
mov_pp r0.w, c3.z
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 8, 0.57735026, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[1], texture[1], 2D;
TXP R2.x, fragment.texcoord[3], texture[0], 2D;
MUL R1.xyz, R1.w, R1;
MUL R2.yzw, R1.xxyz, c[3].y;
MUL R1.xyz, R0, R2.x;
MUL R0.xyz, R0.w, R0;
DP3 R1.w, R2.yzww, c[3].x;
MUL R2.yzw, R0.xxyz, R1.w;
MUL R0.xyz, R1, c[3].w;
MUL R2.yzw, R2, c[3].x;
MIN R0.xyz, R2.yzww, R0;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R2.xyz, R2.yzww, R2.x;
MUL R1.xyz, R1, c[1].x;
MAX R0.xyz, R0, R2;
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].z;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.57735026, 8.00000000, 2.00000000, 1.00000000
dcl t0.xyz
dcl t1.xy
dcl t3
texldp r1, t3, s0
texld r0, t1, s1
texld r2, t1, s2
mul_pp r2.xyz, r2.w, r2
mul_pp r3.xyz, r2, c3.x
mul_pp r2.xyz, r0, r1.x
mul_pp r0.xyz, r0.w, r0
dp3_pp r3.x, r3, c3.y
mul_pp r3.xyz, r0, r3.x
mul_pp r0.xyz, r2, c3.z
mul_pp r3.xyz, r3, c3.y
min_pp r0.xyz, r3, r0
mul_pp r3.xyz, r3, r1.x
add r2.xyz, t0, c2
mul r1.xyz, r2, c1.x
max_pp r0.xyz, r0, r3
add r1.xyz, r1, c0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c3
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
"!!ARBvp1.0
# 36 ALU
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
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
"vs_2_0
; 39 ALU
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
mov r1, c8
dp4 r4.x, c18, r1
mul r1.xyz, v2, c16.w
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
"!!ARBvp1.0
# 28 ALU
PARAM c[16] = { { 1 },
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[13].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[15];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
MUL R0.xyz, vertex.normal, c[13].w;
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 28 instructions, 4 R-regs
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
"vs_2_0
; 31 ALU
def c15, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c15.x
mov r0.xyz, c13
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c12.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
dp4 r4.y, c14, r0
mul r0.xyz, v2, c12.w
mov r1, c8
dp4 r4.x, c14, r1
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
"!!ARBvp1.0
# 37 ALU
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, vertex.normal, c[17].w;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 37 instructions, 4 R-regs
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
"vs_2_0
; 40 ALU
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
mov r1, c8
dp4 r4.x, c18, r1
mul r1.xyz, v2, c16.w
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp4 r0.w, v0, c7
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.w, r0, c15
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
"!!ARBvp1.0
# 36 ALU
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 36 instructions, 4 R-regs
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
"vs_2_0
; 39 ALU
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
mov r1, c8
dp4 r4.x, c18, r1
mul r1.xyz, v2, c16.w
dp4 r4.y, c18, r0
mad r0.xyz, r4, c16.w, -v0
dp3 oT1.y, r0, r2
dp3 oT1.z, v2, r0
dp3 oT1.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT2.y, r2, r3
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.z, r0, c14
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
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
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
"!!ARBvp1.0
# 34 ALU
PARAM c[20] = { { 1 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
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
"vs_2_0
; 37 ALU
def c19, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
mov r0.w, c19.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mul r1.xyz, v2, c16.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 oT1.y, r4, r2
dp3 oT2.y, r2, r3
dp3 oT1.z, v2, r4
dp3 oT1.x, r4, v1
dp3 oT2.z, v2, r3
dp3 oT2.x, v1, r3
dp4 oT3.y, r0, c13
dp4 oT3.x, r0, c12
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
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
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, c[4].x;
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R1.x, R0, fragment.texcoord[1].z;
ADD R0.xyz, fragment.texcoord[0], c[3];
MAX R1.w, R1.x, c[4].x;
MUL R1.xyz, R0, c[2].x;
MUL R0.xyz, R1.w, c[0];
ADD R1.xyz, R1, c[1];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].y;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 15 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t3.xyz
dp3 r0.x, t3, t3
mov r0.xy, r0.x
add r1.xyz, t0, c3
mul r1.xyz, r1, c2.x
add r1.xyz, r1, c1
mov_pp r0.w, c4.x
texld r2, r0, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r0.z, r0.x, t1
max_pp r0.x, r0.z, c4
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r2.x, r0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.y
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 0 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
ADD R0.xyz, fragment.texcoord[0], c[3];
MUL R1.xyz, R0, c[2].x;
MAX R0.x, fragment.texcoord[1].z, c[4];
ADD R1.xyz, R1, c[1];
MUL R0.xyz, R0.x, c[0];
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].y;
MOV result.color.w, c[4].x;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
"ps_2_0
; 9 ALU
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
add r0.xyz, t0, c3
mul r1.xyz, r0, c2.x
max_pp r0.x, t1.z, c4
add r1.xyz, r1, c1
mul_pp r0.xyz, r0.x, c0
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c4.y
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 20 ALU, 2 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RCP R0.x, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R0.x, c[4].y;
MOV result.color.w, c[4].x;
TEX R0.w, R0, texture[0], 2D;
TEX R1.w, R0.z, texture[1], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
MUL R1.x, R1, fragment.texcoord[1].z;
ADD R0.xyz, fragment.texcoord[0], c[3];
MAX R2.x, R1, c[4];
MUL R0.xyz, R0, c[2].x;
ADD R1.xyz, R0, c[1];
MUL R0.xyz, R2.x, c[0];
SLT R2.x, c[4], fragment.texcoord[3].z;
MUL R0.w, R2.x, R0;
MUL R0.w, R0, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].z;
END
# 20 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"ps_2_0
; 20 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c4, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0.xyz
dcl t1.xyz
dcl t3
rcp r1.x, t3.w
mad r2.xy, t3, r1.x, c4.x
dp3 r0.x, t3, t3
mov r1.xy, r0.x
texld r0, r2, s0
texld r2, r1, s1
cmp r0.x, -t3.z, c4.y, c4.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r2
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r0.z, r1.x, t1
max_pp r1.x, r0.z, c4.y
add r2.xyz, t0, c3
mul r2.xyz, r2, c2.x
mul_pp r1.xyz, r1.x, c0
add r2.xyz, r2, c1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c4.w
mov_pp r0.w, c4.y
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 2 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[3], texture[1], CUBE;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, c[4].x;
TEX R1.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
ADD R0.xyz, fragment.texcoord[0], c[3];
MUL R1.x, R1, fragment.texcoord[1].z;
MUL R0.xyz, R0, c[2].x;
MAX R1.x, R1, c[4];
ADD R0.xyz, R0, c[1];
MUL R1.xyz, R1.x, c[0];
MUL R0.w, R1, R0;
MUL R1.xyz, R0.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[4].y;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"ps_2_0
; 16 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t3.xyz
dp3 r0.x, t3, t3
mov r0.xy, r0.x
texld r2, r0, s0
texld r0, t3, s1
dp3_pp r0.x, t1, t1
rsq_pp r1.x, r0.x
mul_pp r0.z, r1.x, t1
mul r0.x, r2, r0.w
max_pp r1.x, r0.z, c4
add r2.xyz, t0, c3
mul r2.xyz, r2, c2.x
mul_pp r1.xyz, r1.x, c0
add r2.xyz, r2, c1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, r2
mul_pp r0.xyz, r0, c4.y
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[3], texture[0], 2D;
ADD R0.xyz, fragment.texcoord[0], c[3];
MUL R1.xyz, R0, c[2].x;
MAX R1.w, fragment.texcoord[1].z, c[4].x;
MUL R0.xyz, R1.w, c[0];
ADD R1.xyz, R1, c[1];
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[4].y;
MOV result.color.w, c[4].x;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Float 2 [_Amount]
Vector 3 [_TurboSize]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 10 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t3.xy
texld r0, t3, s0
add r0.xyz, t0, c3
max_pp r1.x, t1.z, c4
mul r0.xyz, r0, c2.x
mul_pp r1.xyz, r1.x, c0
mul_pp r1.xyz, r0.w, r1
add r0.xyz, r0, c1
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c4.y
mov_pp r0.w, c4.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"!!ARBvp1.0
# 24 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
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
MUL R1.xyz, vertex.normal, c[9].w;
DP3 R0.x, vertex.attrib[14], c[7];
DP3 R0.z, vertex.normal, c[7];
MUL result.texcoord[3].xyz, R0, c[9].w;
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_2_0
; 25 ALU
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
mul r1.xyz, v2, c8.w
dp3 r0.x, v1, c6
dp3 r0.z, v2, c6
mul oT3.xyz, r0, c8.w
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
MOV R0.z, fragment.texcoord[3];
MOV R0.x, fragment.texcoord[1].z;
MOV R0.y, fragment.texcoord[2].z;
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
dcl t1.xyz
dcl t2.xyz
dcl t3.xyz
mov_pp r0.z, t3
mov_pp r0.x, t1.z
mov_pp r0.y, t2.z
mad_pp r0.xyz, r0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Geometry" "IGNOREPROJECTOR"="False" "RenderType"="Opaque" }
  ZWrite Off
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
"!!ARBvp1.0
# 30 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R0.zw, R1, c[6];
DP3 R4.x, R1, c[5];
DP3 R4.z, R1, c[7];
MOV R4.y, R0.z;
MUL R1, R4.xyzz, R4.yzzx;
MOV R4.w, c[0].y;
MUL R0.x, R0.z, R0.z;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP4 R2.z, R4, c[13];
DP4 R2.y, R4, c[12];
DP4 R2.x, R4, c[11];
MAD R0.x, R4, R4, -R0;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[17];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MOV result.texcoord[0].z, R4;
MOV result.texcoord[0].y, R0.w;
MOV result.texcoord[0].x, R4;
END
# 30 instructions, 5 R-regs
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
"vs_2_0
; 30 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c10.w
dp3 r0.zw, r1, c5
dp3 r4.x, r1, c4
dp3 r4.z, r1, c6
mov r4.y, r0.z
mul r1, r4.xyzz, r4.yzzx
mov r4.w, c18.y
mul r0.x, r0.z, r0.z
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r2.z, r4, c13
dp4 r2.y, r4, c12
dp4 r2.x, r4, c11
mad r0.x, r4, r4, -r0
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c17
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mov oT0.z, r4
mov oT0.y, r0.w
mov oT0.x, r4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"!!ARBvp1.0
# 23 ALU
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[14].w;
MOV result.texcoord[1].zw, R0;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[16];
MUL result.texcoord[3].xyz, R0, c[16].w;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[16].w;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[0].z, R1, c[11];
DP3 result.texcoord[0].y, R1, c[10];
DP3 result.texcoord[0].x, R1, c[9];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
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
Vector 14 [unity_Scale]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"vs_2_0
; 23 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mov oPos, r0
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mul r1.xyz, v1, c14.w
mov oT1.zw, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c16
mul oT3.xyz, r0, c16.w
mov r0.x, c16.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp3 oT0.z, r1, c10
dp3 oT0.y, r1, c9
dp3 oT0.x, r1, c8
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 27 ALU
PARAM c[17] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[15];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R1.xyz, R2, c[14].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[13].x;
DP3 result.texcoord[3].y, R1, R3;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MUL R1.xyz, vertex.normal, c[14].w;
ADD result.texcoord[1].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"vs_2_0
; 28 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c15
mov r1.w, c17.y
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r1.xyz, r2, c14.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c17.x
mul r2.y, r2, c12.x
dp3 oT3.y, r1, r3
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mul r1.xyz, v2, c14.w
mad oT1.xy, r2.z, c13.zwzw, r2
mov oPos, r0
mov oT1.zw, r0
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mad oT2.xy, v3, c16, c16.zwzw
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
"!!ARBvp1.0
# 30 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R0.zw, R1, c[6];
DP3 R4.x, R1, c[5];
DP3 R4.z, R1, c[7];
MOV R4.y, R0.z;
MUL R1, R4.xyzz, R4.yzzx;
MOV R4.w, c[0].y;
MUL R0.x, R0.z, R0.z;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
DP4 R2.z, R4, c[13];
DP4 R2.y, R4, c[12];
DP4 R2.x, R4, c[11];
MAD R0.x, R4, R4, -R0;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[17];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[2].xyz, R3, R2;
ADD result.texcoord[1].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[1].zw, R1;
MOV result.texcoord[0].z, R4;
MOV result.texcoord[0].y, R0.w;
MOV result.texcoord[0].x, R4;
END
# 30 instructions, 5 R-regs
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
"vs_2_0
; 30 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c10.w
dp3 r0.zw, r1, c5
dp3 r4.x, r1, c4
dp3 r4.z, r1, c6
mov r4.y, r0.z
mul r1, r4.xyzz, r4.yzzx
mov r4.w, c18.y
mul r0.x, r0.z, r0.z
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
dp4 r2.z, r4, c13
dp4 r2.y, r4, c12
dp4 r2.x, r4, c11
mad r0.x, r4, r4, -r0
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c17
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c8.x
add oT2.xyz, r3, r2
mad oT1.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT1.zw, r1
mov oT0.z, r4
mov oT0.y, r0.w
mov oT0.x, r4
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_Object2World]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"!!ARBvp1.0
# 23 ALU
PARAM c[17] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..16] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MOV result.position, R0;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[1].xy, R1, R1.z;
MUL R1.xyz, vertex.normal, c[14].w;
MOV result.texcoord[1].zw, R0;
DP4 R0.z, vertex.position, c[11];
DP4 R0.x, vertex.position, c[9];
DP4 R0.y, vertex.position, c[10];
ADD R0.xyz, R0, -c[16];
MUL result.texcoord[3].xyz, R0, c[16].w;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[16].w;
DP4 R0.x, vertex.position, c[3];
DP3 result.texcoord[0].z, R1, c[11];
DP3 result.texcoord[0].y, R1, c[10];
DP3 result.texcoord[0].x, R1, c[9];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[3].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
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
Vector 14 [unity_Scale]
Vector 15 [unity_LightmapST]
Vector 16 [unity_ShadowFadeCenterAndType]
"vs_2_0
; 23 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c17.x
mov oPos, r0
mul r1.y, r1, c12.x
mad oT1.xy, r1.z, c13.zwzw, r1
mul r1.xyz, v1, c14.w
mov oT1.zw, r0
dp4 r0.z, v0, c10
dp4 r0.x, v0, c8
dp4 r0.y, v0, c9
add r0.xyz, r0, -c16
mul oT3.xyz, r0, c16.w
mov r0.x, c16.w
add r0.y, c17, -r0.x
dp4 r0.x, v0, c2
dp3 oT0.z, r1, c10
dp3 oT0.y, r1, c9
dp3 oT0.x, r1, c8
mad oT2.xy, v2, c15, c15.zwzw
mul oT3.w, -r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
"!!ARBvp1.0
# 27 ALU
PARAM c[17] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R3.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[15];
MOV R1.w, c[0].y;
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R1.xyz, R2, c[14].w, -vertex.position;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].x;
MUL R2.y, R2, c[13].x;
DP3 result.texcoord[3].y, R1, R3;
DP3 result.texcoord[3].z, vertex.normal, R1;
DP3 result.texcoord[3].x, R1, vertex.attrib[14];
MUL R1.xyz, vertex.normal, c[14].w;
ADD result.texcoord[1].xy, R2, R2.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"vs_2_0
; 28 ALU
def c17, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord1 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r1.xyz, c15
mov r1.w, c17.y
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r1.xyz, r2, c14.w, -v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c17.x
mul r2.y, r2, c12.x
dp3 oT3.y, r1, r3
dp3 oT3.z, v2, r1
dp3 oT3.x, r1, v1
mul r1.xyz, v2, c14.w
mad oT1.xy, r2.z, c13.zwzw, r2
mov oPos, r0
mov oT1.zw, r0
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mad oT2.xy, v3, c16, c16.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TXP R0.xyz, fragment.texcoord[1], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R1.xyz, R1, c[1].x;
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[2];
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].x;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
"ps_2_0
; 10 ALU, 1 TEX
dcl_2d s0
def c3, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xyz
texldp r0, t1, s0
add r1.xyz, t0, c2
mul r1.xyz, r1, c1.x
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
add_pp r0.xyz, -r0, t2
add r1.xyz, r1, c0
mov_pp r0.w, c3.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 3 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TXP R2.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, c[4].y;
MAD R3.xyz, R1, c[4].y, -R0;
ADD R1.xyz, fragment.texcoord[0], c[2];
MAD_SAT R0.w, R0, c[3].z, c[3];
MUL R1.xyz, R1, c[1].x;
MAD R0.xyz, R0.w, R3, R0;
LG2 R2.x, R2.x;
LG2 R2.y, R2.y;
LG2 R2.z, R2.z;
ADD R0.xyz, -R2, R0;
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[4].x;
END
# 21 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 19 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 8.00000000, 1.00000000, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xy
dcl t3
texldp r1, t1, s0
texld r2, t2, s1
texld r0, t2, s2
mul_pp r3.xyz, r2.w, r2
mul_pp r2.xyz, r0.w, r0
mul_pp r2.xyz, r2, c4.x
dp4 r0.x, t3, t3
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c4.x, -r2
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r0.xyz, r0.x, r3, r2
add r2.xyz, t0, c2
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
add_pp r0.xyz, -r1, r0
mul r2.xyz, r2, c1.x
add r1.xyz, r2, c0
mov_pp r0.w, c4.y
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 17 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 8, 0.57735026, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[2], texture[1], 2D;
TEX R1, fragment.texcoord[2], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[3].y;
MUL R0.xyz, R0.w, R0;
DP3 R0.w, R1, c[3].x;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R1.xyz, R1, c[1].x;
MUL R0.xyz, R0, R0.w;
LG2 R2.x, R2.x;
LG2 R2.z, R2.z;
LG2 R2.y, R2.y;
MAD R0.xyz, R0, c[3].x, -R2;
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].z;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 15 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.57735026, 8.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1
dcl t2.xy
texldp r0, t1, s0
texld r1, t2, s1
texld r2, t2, s2
mul_pp r2.xyz, r2.w, r2
mul_pp r2.xyz, r2, c3.x
dp3_pp r2.x, r2, c3.y
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, r2.x
add r2.xyz, t0, c2
log_pp r0.x, r0.x
log_pp r0.y, r0.y
log_pp r0.z, r0.z
mad_pp r0.xyz, r1, c3.y, -r0
mul r2.xyz, r2, c1.x
add r1.xyz, r2, c0
mov_pp r0.w, c3.z
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 1 TEX
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TXP R0.xyz, fragment.texcoord[1], texture[0], 2D;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R1.xyz, R1, c[1].x;
ADD R0.xyz, R0, fragment.texcoord[2];
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
"ps_2_0
; 7 ALU, 1 TEX
dcl_2d s0
def c3, 1.00000000, 0, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xyz
texldp r0, t1, s0
add r1.xyz, t0, c2
mul r1.xyz, r1, c1.x
add_pp r0.xyz, r0, t2
add r1.xyz, r1, c0
mov_pp r0.w, c3.x
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 3 TEX
PARAM c[5] = { program.local[0..3],
		{ 1, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TEX R1, fragment.texcoord[2], texture[1], 2D;
TXP R2.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0, c[4].y;
MAD R3.xyz, R1, c[4].y, -R0;
ADD R1.xyz, fragment.texcoord[0], c[2];
MAD_SAT R0.w, R0, c[3].z, c[3];
MAD R0.xyz, R0.w, R3, R0;
MUL R1.xyz, R1, c[1].x;
ADD R0.xyz, R2, R0;
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[4].x;
END
# 18 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
Vector 3 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 16 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c4, 8.00000000, 1.00000000, 0, 0
dcl t0.xyz
dcl t1
dcl t2.xy
dcl t3
texldp r1, t1, s0
texld r0, t2, s1
texld r3, t2, s2
mul_pp r2.xyz, r0.w, r0
dp4 r0.x, t3, t3
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c4.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_sat r0.x, r0, c3.z, c3.w
mad_pp r2.xyz, r2, c4.x, -r3
mad_pp r2.xyz, r0.x, r2, r3
add r0.xyz, t0, c2
mul r0.xyz, r0, c1.x
add_pp r1.xyz, r1, r2
add r0.xyz, r0, c0
mov_pp r0.w, c4.y
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 8, 0.57735026, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[2], texture[1], 2D;
TEX R1, fragment.texcoord[2], texture[2], 2D;
TXP R2.xyz, fragment.texcoord[1], texture[0], 2D;
MUL R1.xyz, R1.w, R1;
MUL R1.xyz, R1, c[3].y;
MUL R0.xyz, R0.w, R0;
DP3 R0.w, R1, c[3].x;
ADD R1.xyz, fragment.texcoord[0], c[2];
MUL R0.xyz, R0, R0.w;
MUL R1.xyz, R1, c[1].x;
MAD R0.xyz, R0, c[3].x, R2;
ADD R1.xyz, R1, c[0];
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[3].z;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Float 1 [_Amount]
Vector 2 [_TurboSize]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 12 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 0.57735026, 8.00000000, 1.00000000, 0
dcl t0.xyz
dcl t1
dcl t2.xy
texldp r0, t1, s0
texld r2, t2, s2
texld r1, t2, s1
mul_pp r2.xyz, r2.w, r2
mul_pp r2.xyz, r2, c3.x
mul_pp r1.xyz, r1.w, r1
dp3_pp r2.x, r2, c3.y
mul_pp r2.xyz, r1, r2.x
add r1.xyz, t0, c2
mul r1.xyz, r1, c1.x
mad_pp r0.xyz, r2, c3.y, r0
add r1.xyz, r1, c0
mov_pp r0.w, c3.z
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}