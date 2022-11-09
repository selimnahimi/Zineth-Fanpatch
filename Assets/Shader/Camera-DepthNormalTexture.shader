//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Camera-DepthNormalTexture" {
Properties {
 _MainTex ("", 2D) = "white" {}
 _Cutoff ("", Float) = 0.5
 _Color ("", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Vector 13 [_ProjectionParams]
"!!ARBvp1.0
# 10 ALU
PARAM c[14] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13] };
TEMP R0;
DP4 R0.x, vertex.position, c[3];
MUL R0.x, R0, c[13].w;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[0].w, -R0.x;
DP3 result.texcoord[0].z, vertex.normal, c[11];
DP3 result.texcoord[0].y, vertex.normal, c[10];
DP3 result.texcoord[0].x, vertex.normal, c[9];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Vector 12 [_ProjectionParams]
"vs_2_0
; 10 ALU
dcl_position0 v0
dcl_normal0 v1
dp4 r0.x, v0, c2
mul r0.x, r0, c12.w
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT0.w, -r0.x
dp3 oT0.z, v1, c10
dp3 oT0.y, v1, c9
dp3 oT0.x, v1, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 10 ALU, 0 TEX
PARAM c[2] = { { 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
ADD R0.x, fragment.texcoord[0].z, c[0].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[0].w, c[0].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[0].xyxy, R0.z;
MUL R0.zw, R0, c[0].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[1], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[1].y;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 11 ALU
def c0, 1.00000000, 255.00000000, 0.00392157, 0
def c1, 0.28126231, 0.50000000, 0, 0
dcl t0
mul r0.xy, t0.w, c0
frc r0.xy, r0
mad r1.x, -r0.y, c0.z, r0
mov r1.y, r0
add r0.x, t0.z, c0
rcp r0.x, r0.x
mul r0.xy, t0, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c1.x, c1.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TransparentCutout" }
 Pass {
  Tags { "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_ProjectionParams]
Vector 14 [_MainTex_ST]
"!!ARBvp1.0
# 11 ALU
PARAM c[15] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..14] };
TEMP R0;
DP4 R0.x, vertex.position, c[3];
MUL R0.x, R0, c[13].w;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[14], c[14].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
MOV result.texcoord[1].w, -R0.x;
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 11 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Vector 12 [_ProjectionParams]
Vector 13 [_MainTex_ST]
"vs_2_0
; 11 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dp4 r0.x, v0, c2
mul r0.x, r0, c12.w
mad oT0.xy, v2, c13, c13.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
mov oT1.w, -r0.x
dp3 oT1.z, v1, c10
dp3 oT1.y, v1, c9
dp3 oT1.x, v1, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 14 ALU, 1 TEX
PARAM c[4] = { program.local[0..1],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, c[1].w;
SLT R0.x, R0, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[2].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[2].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[2].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[3], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[3].y;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 15 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c3, 0.28126231, 0.50000000, 0, 0
dcl t0.xy
dcl t1
texld r0, t0, s0
mov_pp r0.x, c0
mad_pp r0.x, r0.w, c1.w, -r0
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c2.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c2.w, r0
mov r1.y, r0
add r0.x, t1.z, c2.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c3.x, c3.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeBark" }
 Pass {
  Tags { "RenderType"="TreeBark" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 13 [_Object2World]
Vector 17 [_Time]
Vector 18 [_ProjectionParams]
Vector 19 [_Scale]
Vector 20 [_SquashPlaneNormal]
Float 21 [_SquashAmount]
Vector 22 [_Wind]
"!!ARBvp1.0
# 46 ALU
PARAM c[25] = { { 1, 2, -0.5, 3 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
DP3 R0.x, R0.x, c[16];
ADD R0.x, vertex.color, R0;
ADD R0.z, vertex.color.y, R0.x;
MUL R2.xyz, vertex.position, c[19];
MOV R0.y, R0.x;
DP3 R0.x, R2, R0.z;
ADD R0.xy, R0, c[17].y;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R0, R0;
MAD R1, -R0, c[0].y, c[0].w;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R3.xy, R0.xzzw, R0.ywzw;
MUL R0.xyz, R3.y, c[22];
MUL R1.xyz, vertex.texcoord[1].y, R0;
MUL R0.w, vertex.color.y, c[24].y;
MUL R0.xz, R0.w, vertex.normal;
MUL R0.y, vertex.texcoord[1], c[24].x;
MAD R0.xyz, R3.xyxw, R0, R1;
MAD R0.xyz, R0, c[22].w, R2;
MAD R1.xyz, vertex.texcoord[1].x, c[22], R0;
DP3 R0.x, R1, c[20];
ADD R0.x, R0, c[20].w;
MUL R0.xyz, R0.x, c[20];
ADD R1.xyz, -R0, R1;
MAD R0.xyz, R0, c[21].x, R1;
MOV R0.w, c[0].x;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
DP4 R0.x, R0, c[3];
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R0.y, R1.x;
MUL R1.xyz, R0.y, vertex.normal;
MUL R0.x, R0, c[18].w;
MOV result.texcoord[1].w, -R0.x;
DP3 result.texcoord[1].z, R1, c[11];
DP3 result.texcoord[1].y, R1, c[10];
DP3 result.texcoord[1].x, R1, c[9];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 46 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Matrix 12 [_Object2World]
Vector 16 [_Time]
Vector 17 [_ProjectionParams]
Vector 18 [_Scale]
Vector 19 [_SquashPlaneNormal]
Float 20 [_SquashAmount]
Vector 21 [_Wind]
"vs_2_0
; 50 ALU
def c22, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, 3.00000000, 0.30000001, 0.10000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c15
dp3 r0.x, c22.x, r0
add r0.x, v5, r0
mov r0.y, r0.x
mul r2.xyz, v0, c18
add r0.x, v5.y, r0
dp3 r0.x, r2, r0.x
add r0.xy, r0, c16.y
mul r0, r0.xxyy, c23
frc r0, r0
mad r0, r0, c22.y, c22.z
frc r0, r0
mad r0, r0, c22.y, c22.w
abs r0, r0
mad r1, -r0, c24.x, c24.y
mul r0, r0, r0
mul r0, r0, r1
add r3.xy, r0.xzzw, r0.ywzw
mul r0.xyz, r3.y, c21
mul r1.xyz, v4.y, r0
mul r0.w, v5.y, c24
mul r0.xz, r0.w, v2
mul r0.y, v4, c24.z
mad r0.xyz, r3.xyxw, r0, r1
mad r0.xyz, r0, c21.w, r2
mad r1.xyz, v4.x, c21, r0
dp3 r0.x, r1, c19
add r0.x, r0, c19.w
mul r0.xyz, r0.x, c19
add r1.xyz, -r0, r1
mad r0.xyz, r0, c20.x, r1
mov r0.w, c22.x
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
dp4 r0.x, r0, c2
dp3 r1.x, v2, v2
rsq r0.y, r1.x
mul r1.xyz, r0.y, v2
mul r0.x, r0, c17.w
mov oT1.w, -r0.x
dp3 oT1.z, r1, c10
dp3 oT1.y, r1, c9
dp3 oT1.x, r1, c8
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 10 ALU, 0 TEX
PARAM c[2] = { { 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
ADD R0.x, fragment.texcoord[1].z, c[0].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[0].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[0].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[1], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[1].y;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 11 ALU
def c0, 1.00000000, 255.00000000, 0.00392157, 0
def c1, 0.28126231, 0.50000000, 0, 0
dcl t1
mul r0.xy, t1.w, c0
frc r0.xy, r0
mad r1.x, -r0.y, c0.z, r0
mov r1.y, r0
add r0.x, t1.z, c0
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c1.x, c1.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeLeaf" }
 Pass {
  Tags { "RenderType"="TreeLeaf" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 13 [_Object2World]
Vector 17 [_Time]
Vector 18 [_ProjectionParams]
Vector 19 [_Scale]
Vector 20 [_SquashPlaneNormal]
Float 21 [_SquashAmount]
Vector 22 [_Wind]
"!!ARBvp1.0
# 59 ALU
PARAM c[25] = { { 0, 1, 2, -0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..22],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 3, 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0, vertex.normal.y, c[10];
MAD R1, vertex.normal.x, c[9], R0;
ADD R0.xyz, R1, c[0].x;
ABS R2.x, vertex.attrib[14].w;
ADD R3.w, -R2.x, c[0].y;
MAD R0.xyz, R0, R3.w, vertex.position;
MAD R1, vertex.normal.z, c[11], R1;
ADD R2, R1, c[0].x;
DP4 R2.w, R2, R2;
MOV R0.w, c[0].y;
DP3 R0.w, R0.w, c[16];
MUL R3.xyz, R0, c[19];
ADD R0.w, vertex.color.x, R0;
ADD R0.x, vertex.color.y, R0.w;
MOV R0.y, R0.w;
DP3 R0.x, R3, R0.x;
ADD R0.xy, R0, c[17].y;
MUL R0, R0.xxyy, c[23];
FRC R0, R0;
MAD R0, R0, c[0].z, c[0].w;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].y;
ABS R0, R0;
MUL R1, -R0, c[0].z;
ADD R1, R1, c[24].x;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R4.xy, R0.xzzw, R0.ywzw;
RSQ R2.w, R2.w;
MAD R1.xyz, R2.w, R2, -vertex.normal;
MAD R1.xyz, R3.w, R1, vertex.normal;
MUL R0.xyz, R4.y, c[22];
MUL R2.xyz, vertex.texcoord[1].y, R0;
MUL R4.zw, vertex.color.y, R1.xyxz;
MOV R0.w, c[0].y;
DP3 R1.w, R1, R1;
MUL R0.xz, R4.zyww, c[24].z;
MUL R0.y, vertex.texcoord[1], c[24];
MAD R0.xyz, R4.xyxw, R0, R2;
MAD R0.xyz, R0, c[22].w, R3;
MAD R2.xyz, vertex.texcoord[1].x, c[22], R0;
DP3 R0.x, R2, c[20];
ADD R0.x, R0, c[20].w;
MUL R0.xyz, R0.x, c[20];
ADD R2.xyz, -R0, R2;
MAD R0.xyz, R0, c[21].x, R2;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
DP4 R0.x, R0, c[3];
RSQ R0.y, R1.w;
MUL R1.xyz, R0.y, R1;
MUL R0.x, R0, c[18].w;
MOV result.texcoord[1].w, -R0.x;
DP3 result.texcoord[1].z, R1, c[11];
DP3 result.texcoord[1].y, R1, c[10];
DP3 result.texcoord[1].x, R1, c[9];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 59 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Matrix 12 [_Object2World]
Vector 16 [_Time]
Vector 17 [_ProjectionParams]
Vector 18 [_Scale]
Vector 19 [_SquashPlaneNormal]
Float 20 [_SquashAmount]
Vector 21 [_Wind]
"vs_2_0
; 62 ALU
def c22, 0.00000000, 1.00000000, 2.00000000, -0.50000000
def c23, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c24, 2.00000000, -1.00000000, 3.00000000, 0.30000001
def c25, 0.10000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r0, v2.y, c9
mad r1, v2.x, c8, r0
add r0.xyz, r1, c22.x
abs r0.w, v1
add r3.w, -r0, c22.y
mad r0.xyz, r0, r3.w, v0
mov r2.xyz, c15
dp3 r0.w, c22.y, r2
mad r1, v2.z, c10, r1
add r2, r1, c22.x
dp4 r2.w, r2, r2
mul r3.xyz, r0, c18
add r0.w, v5.x, r0
add r0.x, v5.y, r0.w
mov r0.y, r0.w
dp3 r0.x, r3, r0.x
add r0.xy, r0, c16.y
mul r0, r0.xxyy, c23
frc r0, r0
mad r0, r0, c22.z, c22.w
frc r0, r0
mad r0, r0, c24.x, c24.y
abs r0, r0
mul r1, r0, r0
mad r0, -r0, c24.x, c24.z
mul r0, r1, r0
add r4.xy, r0.xzzw, r0.ywzw
rsq r2.w, r2.w
mad r1.xyz, r2.w, r2, -v2
mad r1.xyz, r3.w, r1, v2
mul r0.xyz, r4.y, c21
mul r2.xyz, v4.y, r0
mul r4.zw, v5.y, r1.xyxz
mov r0.w, c22.y
dp3 r1.w, r1, r1
mul r0.xz, r4.zyww, c25.x
mul r0.y, v4, c24.w
mad r0.xyz, r4.xyxw, r0, r2
mad r0.xyz, r0, c21.w, r3
mad r2.xyz, v4.x, c21, r0
dp3 r0.x, r2, c19
add r0.x, r0, c19.w
mul r0.xyz, r0.x, c19
add r2.xyz, -r0, r2
mad r0.xyz, r0, c20.x, r2
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
dp4 r0.x, r0, c2
rsq r0.y, r1.w
mul r1.xyz, r0.y, r1
mul r0.x, r0, c17.w
mov oT1.w, -r0.x
dp3 oT1.z, r1, c10
dp3 oT1.y, r1, c9
dp3 oT1.x, r1, c8
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 13 ALU, 1 TEX
PARAM c[3] = { program.local[0],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[1].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[1].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[1].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[2], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[2].y;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c2, 0.28126231, 0.50000000, 0, 0
dcl t0.xy
dcl t1
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c1.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c1.w, r0
mov r1.y, r0
add r0.x, t1.z, c1.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c2.x, c2.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeOpaque" }
 Pass {
  Tags { "RenderType"="TreeOpaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 13 [_TerrainEngineBendTree]
Vector 17 [_ProjectionParams]
Vector 18 [_Scale]
Vector 19 [_SquashPlaneNormal]
Float 20 [_SquashAmount]
"!!ARBvp1.0
# 23 ALU
PARAM c[21] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[15];
DP4 R0.x, R1, c[13];
DP4 R0.y, R1, c[14];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[19];
ADD R0.w, R0, c[19];
MUL R1.xyz, R0.w, c[19];
ADD R0.xyz, -R1, R0;
MAD R0.xyz, R1, c[20].x, R0;
MOV R0.w, c[0].y;
DP4 R1.x, R0, c[3];
MUL R1.x, R1, c[17].w;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MOV result.texcoord[0].w, -R1.x;
DP3 result.texcoord[0].z, vertex.normal, c[11];
DP3 result.texcoord[0].y, vertex.normal, c[10];
DP3 result.texcoord[0].x, vertex.normal, c[9];
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Matrix 12 [_TerrainEngineBendTree]
Vector 16 [_ProjectionParams]
Vector 17 [_Scale]
Vector 18 [_SquashPlaneNormal]
Float 19 [_SquashAmount]
"vs_2_0
; 23 ALU
def c20, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
mul r1.xyz, v0, c17
mov r1.w, c20.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, r0, -r1
mad r0.xyz, v2.w, r0, r1
dp3 r0.w, r0, c18
add r0.w, r0, c18
mul r1.xyz, r0.w, c18
add r0.xyz, -r1, r0
mad r0.xyz, r1, c19.x, r0
mov r0.w, c20.y
dp4 r1.x, r0, c2
mul r1.x, r1, c16.w
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
mov oT0.w, -r1.x
dp3 oT0.z, v1, c10
dp3 oT0.y, v1, c9
dp3 oT0.x, v1, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 10 ALU, 0 TEX
PARAM c[2] = { { 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
ADD R0.x, fragment.texcoord[0].z, c[0].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[0].w, c[0].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[0].xyxy, R0.z;
MUL R0.zw, R0, c[0].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[1], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[1].y;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 11 ALU
def c0, 1.00000000, 255.00000000, 0.00392157, 0
def c1, 0.28126231, 0.50000000, 0, 0
dcl t0
mul r0.xy, t0.w, c0
frc r0.xy, r0
mad r1.x, -r0.y, c0.z, r0
mov r1.y, r0
add r0.x, t0.z, c0
rcp r0.x, r0.x
mul r0.xy, t0, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c1.x, c1.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeTransparentCutout" }
 Pass {
  Tags { "RenderType"="TreeTransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 13 [_TerrainEngineBendTree]
Vector 17 [_ProjectionParams]
Vector 18 [_Scale]
Vector 19 [_SquashPlaneNormal]
Float 20 [_SquashAmount]
"!!ARBvp1.0
# 24 ALU
PARAM c[21] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[15];
DP4 R0.x, R1, c[13];
DP4 R0.y, R1, c[14];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[19];
ADD R0.w, R0, c[19];
MUL R1.xyz, R0.w, c[19];
ADD R0.xyz, -R1, R0;
MAD R0.xyz, R1, c[20].x, R0;
MOV R0.w, c[0].y;
DP4 R1.x, R0, c[3];
MUL R1.x, R1, c[17].w;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MOV result.texcoord[1].w, -R1.x;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Matrix 12 [_TerrainEngineBendTree]
Vector 16 [_ProjectionParams]
Vector 17 [_Scale]
Vector 18 [_SquashPlaneNormal]
Float 19 [_SquashAmount]
"vs_2_0
; 24 ALU
def c20, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
dcl_texcoord0 v3
mul r1.xyz, v0, c17
mov r1.w, c20.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, r0, -r1
mad r0.xyz, v2.w, r0, r1
dp3 r0.w, r0, c18
add r0.w, r0, c18
mul r1.xyz, r0.w, c18
add r0.xyz, -r1, r0
mad r0.xyz, r1, c19.x, r0
mov r0.w, c20.y
dp4 r1.x, r0, c2
mul r1.x, r1, c16.w
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
mov oT1.w, -r1.x
mov oT0.xy, v3
dp3 oT1.z, v1, c10
dp3 oT1.y, v1, c9
dp3 oT1.x, v1, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 13 ALU, 1 TEX
PARAM c[3] = { program.local[0],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[1].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[1].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[1].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[2], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[2].y;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c2, 0.28126231, 0.50000000, 0, 0
dcl t0.xy
dcl t1
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c1.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c1.w, r0
mov r1.y, r0
add r0.x, t1.z, c1.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c2.x, c2.y
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Tags { "RenderType"="TreeTransparentCutout" }
  Cull Front
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 13 [_TerrainEngineBendTree]
Vector 17 [_ProjectionParams]
Vector 18 [_Scale]
Vector 19 [_SquashPlaneNormal]
Float 20 [_SquashAmount]
"!!ARBvp1.0
# 24 ALU
PARAM c[21] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..20] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[15];
DP4 R0.x, R1, c[13];
DP4 R0.y, R1, c[14];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[19];
ADD R0.w, R0, c[19];
MUL R1.xyz, R0.w, c[19];
ADD R0.xyz, -R1, R0;
MAD R0.xyz, R1, c[20].x, R0;
MOV R0.w, c[0].y;
DP4 R1.x, R0, c[3];
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MUL R0.w, R1.x, c[17];
DP3 R0.z, vertex.normal, c[11];
DP3 R0.x, vertex.normal, c[9];
DP3 R0.y, vertex.normal, c[10];
MOV result.texcoord[1], -R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 24 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Matrix 12 [_TerrainEngineBendTree]
Vector 16 [_ProjectionParams]
Vector 17 [_Scale]
Vector 18 [_SquashPlaneNormal]
Float 19 [_SquashAmount]
"vs_2_0
; 24 ALU
def c20, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_color0 v2
dcl_texcoord0 v3
mul r1.xyz, v0, c17
mov r1.w, c20.x
dp4 r0.z, r1, c14
dp4 r0.x, r1, c12
dp4 r0.y, r1, c13
add r0.xyz, r0, -r1
mad r0.xyz, v2.w, r0, r1
dp3 r0.w, r0, c18
add r0.w, r0, c18
mul r1.xyz, r0.w, c18
add r0.xyz, -r1, r0
mad r0.xyz, r1, c19.x, r0
mov r0.w, c20.y
dp4 r1.x, r0, c2
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
mul r0.w, r1.x, c16
dp3 r0.z, v1, c10
dp3 r0.x, v1, c8
dp3 r0.y, v1, c9
mov oT1, -r0
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 13 ALU, 1 TEX
PARAM c[3] = { program.local[0],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[1].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[1].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[1].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[2], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[2].y;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c2, 0.28126231, 0.50000000, 0, 0
dcl t0.xy
dcl t1
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c1.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c1.w, r0
mov r1.y, r0
add r0.x, t1.z, c1.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c2.x, c2.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="TreeBillboard" }
 Pass {
  Tags { "RenderType"="TreeBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [_TreeBillboardCameraRight]
Vector 11 [_TreeBillboardCameraUp]
Vector 12 [_TreeBillboardCameraFront]
Vector 13 [_TreeBillboardCameraPos]
Vector 14 [_TreeBillboardDistances]
"!!ARBvp1.0
# 23 ALU
PARAM c[15] = { { 0, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..14] };
TEMP R0;
TEMP R1;
ADD R0.xyz, vertex.position, -c[13];
DP3 R0.x, R0, R0;
SLT R0.x, c[14], R0;
MAD R0.z, R0.x, -vertex.texcoord[0].y, vertex.texcoord[0].y;
MAD R0.xy, -vertex.texcoord[1], R0.x, vertex.texcoord[1];
ADD R0.z, -R0.y, R0;
MAD R1.xyz, R0.x, c[10], vertex.position;
MAD R0.y, R0.z, c[13].w, R0;
MOV R0.w, vertex.position;
MAD R1.xyz, R0.y, c[11], R1;
ABS R0.x, R0;
MUL R0.xyz, R0.x, c[12];
MAD R0.xyz, R0, c[11].w, R1;
DP4 R1.x, R0, c[3];
MUL R1.x, R1, c[9].w;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
MOV result.texcoord[1].w, -R1.x;
MOV result.texcoord[1].xyz, c[0].xxyw;
SLT result.texcoord[0].y, c[0].x, vertex.texcoord[0];
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_TreeBillboardCameraRight]
Vector 10 [_TreeBillboardCameraUp]
Vector 11 [_TreeBillboardCameraFront]
Vector 12 [_TreeBillboardCameraPos]
Vector 13 [_TreeBillboardDistances]
"vs_2_0
; 25 ALU
def c14, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
add r0.xyz, v0, -c12
dp3 r0.x, r0, r0
slt r0.x, c13, r0
max r0.x, -r0, r0
slt r0.x, c14, r0
add r0.z, -r0.x, c14.y
mul r0.xy, r0.z, v2
mad r0.z, r0, v1.y, -r0.y
mad r1.xyz, r0.x, c9, v0
mad r0.y, r0.z, c12.w, r0
mov r0.w, v0
mad r1.xyz, r0.y, c10, r1
abs r0.x, r0
mul r0.xyz, r0.x, c11
mad r0.xyz, r0, c10.w, r1
dp4 r1.x, r0, c2
mul r1.x, r1, c8.w
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
mov oT1.w, -r1.x
mov oT1.xyz, c14.xxyw
slt oT0.y, c14.x, v1
mov oT0.x, v1
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 13 ALU, 1 TEX
PARAM c[2] = { { 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5, 0.0010004044 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[1].z;
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[0].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[0].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[0].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[1], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[1].y;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 16 ALU, 2 TEX
dcl_2d s0
def c0, -0.00100040, 0.00000000, 1.00000000, 255.00000000
def c1, 0.00392157, 0.28126231, 0.50000000, 0
dcl t0.xy
dcl t1
texld r0, t0, s0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r0, -r0.x
texkill r0.xyzw
mov r0.y, c0.w
mov r0.x, c0.z
mul r0.xy, t1.w, r0
frc r0.xy, r0
mad r1.x, -r0.y, c1, r0
mov r1.y, r0
add r0.x, t1.z, c0.z
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c1.y, c1.z
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="GrassBillboard" }
 Pass {
  Tags { "RenderType"="GrassBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Vector 13 [_ProjectionParams]
Vector 14 [_WavingTint]
Vector 15 [_WaveAndDistance]
Vector 16 [_CameraPosition]
Vector 17 [_CameraRight]
Vector 18 [_CameraUp]
"!!ARBvp1.0
# 54 ALU
PARAM c[26] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..18],
		{ 0.012, 0.02, 0.059999999, 0.024 },
		{ 0.0060000001, 0.02, 0.050000001, 6.4088488 },
		{ 3.1415927, -0.00019840999, 0.0083333002, -0.16161616 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 },
		{ 0.47193992, 0.18877596, 0.094387978, 0.5 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ADD R0.xyz, vertex.position, -c[16];
DP3 R0.x, R0, R0;
SLT R0.x, c[15].w, R0;
MAD R0.xy, -vertex.attrib[14], R0.x, vertex.attrib[14];
MAD R1.xyz, R0.x, c[17], vertex.position;
MAD R3.xyz, R0.y, c[18], R1;
MUL R0.x, R3.z, c[15].y;
MUL R1.xyz, R0.x, c[20];
MUL R0.x, R3, c[15].y;
MAD R1, R0.x, c[19], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[15].x, R1;
FRC R0, R0;
MUL R0, R0, c[20].w;
ADD R0, R0, -c[21].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[21].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[21].z, R0;
MAD R0, R1, c[21].y, R0;
MUL R0, R0, R0;
MUL R0, R0, R0;
MUL R1, R0, vertex.attrib[14].y;
DP4 R2.y, R1, c[22];
DP4 R2.x, R1, c[23];
MAD R1.xz, -R2.xyyw, c[15].z, R3;
MOV R1.y, R3;
MOV R1.w, vertex.position;
ADD R2.xyz, R1, -c[16];
DP3 R2.x, R2, R2;
ADD R2.x, -R2, c[15].w;
MUL R2.x, R2, c[16].w;
MUL R2.x, R2, c[0].y;
MIN R2.x, R2, c[25];
MAX result.color.w, R2.x, c[25].y;
DP4 result.position.w, R1, c[8];
DP4 result.position.z, R1, c[7];
DP4 result.position.y, R1, c[6];
DP4 result.position.x, R1, c[5];
DP4 R1.w, R1, c[3];
DP4 R0.x, R0, c[24].xxyz;
MOV R2.x, c[24].w;
ADD R1.xyz, -R2.x, c[14];
MAD R0.xyz, R0.x, R1, c[24].w;
MUL R0.w, R1, c[13];
MUL R0.xyz, R0, vertex.color;
MOV result.texcoord[1].w, -R0;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 54 instructions, 4 R-regs
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
Matrix 8 [glstate_matrix_invtrans_modelview0]
Vector 12 [_ProjectionParams]
Vector 13 [_WavingTint]
Vector 14 [_WaveAndDistance]
Vector 15 [_CameraPosition]
Vector 16 [_CameraRight]
Vector 17 [_CameraUp]
"vs_2_0
; 58 ALU
def c18, 0.00000000, 1.00000000, 6.40884876, -3.14159274
def c19, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c20, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c21, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c22, 0.00833330, -0.00019841, -0.50000000, 0.50000000
def c23, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c24, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c25, 0.47193992, 0.18877596, 0.09438798, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
add r0.xyz, v0, -c15
dp3 r0.x, r0, r0
slt r0.x, c14.w, r0
max r0.x, -r0, r0
slt r0.x, c18, r0
add r0.x, -r0, c18.y
mul r0.xy, r0.x, v1
mad r1.xyz, r0.x, c16, v0
mad r3.xyz, r0.y, c17, r1
mul r0.x, r3.z, c14.y
mul r1.xyz, r0.x, c19
mul r0.x, r3, c14.y
mad r0, r0.x, c20, r1.xyyz
mov r1.x, c14
mad r0, c21, r1.x, r0
frc r0, r0
mad r0, r0, c18.z, c18.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c19.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c22.x, r0
mad r0, r1, c22.y, r0
mul r0, r0, r0
mul r0, r0, r0
mul r1, r0, v1.y
dp4 r2.y, r1, c23
dp4 r2.x, r1, c24
mad r1.xz, -r2.xyyw, c14.z, r3
mov r1.y, r3
mov r1.w, v0
add r2.xyz, r1, -c15
dp3 r2.x, r2, r2
add r2.x, -r2, c14.w
mul r2.x, r2, c15.w
mul r2.x, r2, c21.y
min r2.x, r2, c18.y
max oD0.w, r2.x, c18.x
dp4 oPos.w, r1, c7
dp4 oPos.z, r1, c6
dp4 oPos.y, r1, c5
dp4 oPos.x, r1, c4
dp4 r1.w, r1, c2
dp4 r0.x, r0, c25.xxyz
mov r2.xyz, c13
add r1.xyz, c22.z, r2
mad r0.xyz, r0.x, r1, c22.w
mul r0.w, r1, c12
mul r0.xyz, r0, v5
mov oT1.w, -r0
mul oD0.xyz, r0, c21.y
mov oT0.xy, v3
dp3 oT1.z, v2, c10
dp3 oT1.y, v2, c9
dp3 oT1.x, v2, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 14 ALU, 1 TEX
PARAM c[3] = { program.local[0],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[1].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[1].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[1].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[2], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[2].y;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c2, 0.28126231, 0.50000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c1.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c1.w, r0
mov r1.y, r0
add r0.x, t1.z, c1.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c2.x, c2.y
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Grass" }
 Pass {
  Tags { "RenderType"="Grass" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [_ProjectionParams]
Vector 14 [_WavingTint]
Vector 15 [_WaveAndDistance]
Vector 16 [_CameraPosition]
"!!ARBvp1.0
# 48 ALU
PARAM c[24] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[13..16],
		{ 0.012, 0.02, 0.059999999, 0.024 },
		{ 0.0060000001, 0.02, 0.050000001, 6.4088488 },
		{ 3.1415927, -0.00019840999, 0.0083333002, -0.16161616 },
		{ 0.0060000001, 0.02, -0.02, 0.1 },
		{ 0.024, 0.039999999, -0.12, 0.096000001 },
		{ 0.47193992, 0.18877596, 0.094387978, 0.5 },
		{ 1, 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
MUL R0.x, vertex.position.z, c[15].y;
MUL R1.xyz, R0.x, c[18];
MUL R0.x, vertex.position, c[15].y;
MAD R1, R0.x, c[17], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[15].x, R1;
FRC R0, R0;
MUL R0, R0, c[18].w;
ADD R0, R0, -c[19].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[19].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[19].z, R0;
MAD R0, R1, c[19].y, R0;
MUL R0, R0, R0;
MUL R1, R0, R0;
MUL R2.x, vertex.color.w, c[15].z;
MUL R0, R1, R2.x;
DP4 R2.y, R0, c[20];
DP4 R2.x, R0, c[21];
MAD R0.xz, -R2.xyyw, c[15].z, vertex.position;
MOV R0.yw, vertex.position;
ADD R2.xyz, R0, -c[16];
DP3 R2.x, R2, R2;
ADD R2.x, -R2, c[15].w;
MUL R2.x, R2, c[16].w;
MUL R2.x, R2, c[0].y;
MIN R2.x, R2, c[23];
MAX result.color.w, R2.x, c[23].y;
DP4 result.position.w, R0, c[8];
DP4 result.position.z, R0, c[7];
DP4 result.position.y, R0, c[6];
DP4 result.position.x, R0, c[5];
DP4 R0.w, R0, c[3];
MOV R2.x, c[22].w;
MUL R0.w, R0, c[13];
ADD R0.xyz, -R2.x, c[14];
DP4 R1.x, R1, c[22].xxyz;
MAD R0.xyz, R1.x, R0, c[22].w;
MUL R0.xyz, vertex.color, R0;
MOV result.texcoord[1].w, -R0;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP3 result.texcoord[1].z, vertex.normal, c[11];
DP3 result.texcoord[1].y, vertex.normal, c[10];
DP3 result.texcoord[1].x, vertex.normal, c[9];
END
# 48 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [glstate_matrix_invtrans_modelview0]
Vector 12 [_ProjectionParams]
Vector 13 [_WavingTint]
Vector 14 [_WaveAndDistance]
Vector 15 [_CameraPosition]
"vs_2_0
; 49 ALU
def c16, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c17, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c18, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c19, 6.40884876, -3.14159274, 0.00833330, -0.00019841
def c20, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c21, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c22, 0.47193992, 0.18877596, 0.09438798, -0.50000000
def c23, 0.50000000, 1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord0 v3
dcl_color0 v5
mul r0.x, v0.z, c14.y
mul r1.xyz, r0.x, c16
mul r0.x, v0, c14.y
mad r1, r0.x, c17, r1.xyyz
mov r0.x, c14
mad r0, c18, r0.x, r1
frc r0, r0
mad r0, r0, c19.x, c19.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c16.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c19.z, r0
mad r0, r1, c19.w, r0
mul r0, r0, r0
mul r1, r0, r0
mul r2.x, v5.w, c14.z
mul r0, r1, r2.x
dp4 r2.y, r0, c20
dp4 r2.x, r0, c21
mad r0.xz, -r2.xyyw, c14.z, v0
mov r0.yw, v0
add r2.xyz, r0, -c15
dp3 r2.x, r2, r2
add r2.x, -r2, c14.w
mul r2.x, r2, c15.w
mul r2.x, r2, c18.y
min r2.x, r2, c23.y
max oD0.w, r2.x, c23.z
dp4 oPos.w, r0, c7
dp4 oPos.z, r0, c6
dp4 oPos.y, r0, c5
dp4 oPos.x, r0, c4
dp4 r0.w, r0, c2
mov r2.xyz, c13
mul r0.w, r0, c12
add r0.xyz, c22.w, r2
dp4 r1.x, r1, c22.xxyz
mad r0.xyz, r1.x, r0, c23.x
mul r0.xyz, v5, r0
mov oT1.w, -r0
mul oD0.xyz, r0, c18.y
mov oT0.xy, v3
dp3 oT1.z, v2, c10
dp3 oT1.y, v2, c9
dp3 oT1.x, v2, c8
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 14 ALU, 1 TEX
PARAM c[3] = { program.local[0],
		{ 0.28126231, 0, 1, 255 },
		{ 0.0039215689, 0.5 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
KIL -R0.x;
ADD R0.x, fragment.texcoord[1].z, c[1].z;
RCP R0.z, R0.x;
MUL R0.xy, fragment.texcoord[1].w, c[1].zwzw;
FRC R0.xy, R0;
MUL R0.zw, fragment.texcoord[1].xyxy, R0.z;
MUL R0.zw, R0, c[1].x;
MOV R1.y, R0;
MAD R1.x, -R0.y, c[2], R0;
MOV result.color.zw, R1.xyxy;
ADD result.color.xy, R0.zwzw, c[2].y;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 14 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 255.00000000, 0.00392157
def c2, 0.28126231, 0.50000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
mul r0.xy, t1.w, c1.yzxw
frc r0.xy, r0
mad r1.x, -r0.y, c1.w, r0
mov r1.y, r0
add r0.x, t1.z, c1.y
rcp r0.x, r0.x
mul r0.xy, t1, r0.x
mov r0.z, r1.x
mov r0.w, r1.y
mad r0.xy, r0, c2.x, c2.y
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}