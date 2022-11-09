//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Camera-DepthTexture" {
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
"!!ARBvp1.0
# 4 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 4 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
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
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
"!!ARBvp1.0
# 5 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
; 7 ALU
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
mad oT0.xy, v1, c4, c4.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, c[1].w;
SLT R0.x, R0, c[0];
MOV result.color, c[2].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
Vector 1 [_Color]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 8 ALU, 2 TEX
dcl_2d s0
def c2, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mov_pp r0.x, c0
mad_pp r0.x, r0.w, c1.w, -r0
cmp r0.x, r0, c2, c2.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
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
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_Time]
Vector 10 [_Scale]
Vector 11 [_SquashPlaneNormal]
Float 12 [_SquashAmount]
Vector 13 [_Wind]
"!!ARBvp1.0
# 36 ALU
PARAM c[16] = { { 1, 2, -0.5, 3 },
		state.matrix.mvp,
		program.local[5..13],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R0.x, c[0];
DP3 R0.x, R0.x, c[8];
ADD R0.x, vertex.color, R0;
ADD R0.z, vertex.color.y, R0.x;
MUL R2.xyz, vertex.position, c[10];
MOV R0.y, R0.x;
DP3 R0.x, R2, R0.z;
ADD R0.xy, R0, c[9].y;
MUL R0, R0.xxyy, c[14];
FRC R0, R0;
MAD R0, R0, c[0].y, c[0].z;
FRC R0, R0;
MAD R0, R0, c[0].y, -c[0].x;
ABS R0, R0;
MAD R1, -R0, c[0].y, c[0].w;
MUL R0, R0, R0;
MUL R0, R0, R1;
ADD R3.xy, R0.xzzw, R0.ywzw;
MUL R0.xyz, R3.y, c[13];
MUL R1.xyz, vertex.texcoord[1].y, R0;
MUL R0.w, vertex.color.y, c[15].y;
MUL R0.xz, R0.w, vertex.normal;
MUL R0.y, vertex.texcoord[1], c[15].x;
MAD R0.xyz, R3.xyxw, R0, R1;
MAD R0.xyz, R0, c[13].w, R2;
MAD R1.xyz, vertex.texcoord[1].x, c[13], R0;
DP3 R0.x, R1, c[11];
ADD R0.x, R0, c[11].w;
MUL R0.xyz, R0.x, c[11];
ADD R1.xyz, -R0, R1;
MOV R0.w, c[0].x;
MAD R0.xyz, R0, c[12].x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 36 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_Time]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
Vector 12 [_Wind]
"vs_2_0
; 42 ALU
def c13, 1.00000000, 2.00000000, -0.50000000, -1.00000000
def c14, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c15, 2.00000000, 3.00000000, 0.30000001, 0.10000000
dcl_position0 v0
dcl_normal0 v2
dcl_texcoord1 v4
dcl_color0 v5
mov r0.xyz, c7
dp3 r0.x, c13.x, r0
add r0.x, v5, r0
mov r0.y, r0.x
mul r2.xyz, v0, c9
add r0.x, v5.y, r0
dp3 r0.x, r2, r0.x
add r0.xy, r0, c8.y
mul r0, r0.xxyy, c14
frc r0, r0
mad r0, r0, c13.y, c13.z
frc r0, r0
mad r0, r0, c13.y, c13.w
abs r0, r0
mad r1, -r0, c15.x, c15.y
mul r0, r0, r0
mul r0, r0, r1
add r3.xy, r0.xzzw, r0.ywzw
mul r0.xyz, r3.y, c12
mul r1.xyz, v4.y, r0
mul r0.w, v5.y, c15
mov r1.w, c13.x
mul r0.xz, r0.w, v2
mul r0.y, v4, c15.z
mad r0.xyz, r3.xyxw, r0, r1
mad r0.xyz, r0, c12.w, r2
mad r1.xyz, v4.x, c12, r0
dp3 r0.x, r1, c10
add r0.x, r0, c10.w
mul r0.xyz, r0.x, c10
add r1.xyz, -r0, r1
mad r1.xyz, r0, c11.x, r1
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
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
Matrix 9 [_Object2World]
Vector 13 [_Time]
Vector 14 [_Scale]
Vector 15 [_SquashPlaneNormal]
Float 16 [_SquashAmount]
Vector 17 [_Wind]
"!!ARBvp1.0
# 50 ALU
PARAM c[20] = { { 0, 1, 2, -0.5 },
		state.matrix.mvp,
		state.matrix.modelview[0].invtrans,
		program.local[9..17],
		{ 1.975, 0.79299998, 0.375, 0.193 },
		{ 3, 0.30000001, 0.1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0, vertex.normal.y, c[6];
MAD R1, vertex.normal.x, c[5], R0;
ADD R0.xyz, R1, c[0].x;
ABS R2.x, vertex.attrib[14].w;
ADD R2.w, -R2.x, c[0].y;
MAD R0.xyz, R0, R2.w, vertex.position;
MAD R1, vertex.normal.z, c[7], R1;
ADD R3, R1, c[0].x;
DP4 R3.y, R3, R3;
MOV R0.w, c[0].y;
DP3 R0.w, R0.w, c[12];
MUL R2.xyz, R0, c[14];
ADD R0.w, vertex.color.x, R0;
ADD R0.x, vertex.color.y, R0.w;
MOV R0.y, R0.w;
DP3 R0.x, R2, R0.x;
ADD R0.xy, R0, c[13].y;
MUL R0, R0.xxyy, c[18];
FRC R0, R0;
MAD R0, R0, c[0].z, c[0].w;
FRC R0, R0;
MAD R0, R0, c[0].z, -c[0].y;
ABS R0, R0;
MUL R1, -R0, c[0].z;
ADD R1, R1, c[19].x;
MUL R0, R0, R0;
MUL R0, R0, R1;
RSQ R3.y, R3.y;
MAD R1.xy, R3.y, R3.xzzw, -vertex.normal.xzzw;
ADD R3.xy, R0.xzzw, R0.ywzw;
MAD R0.xy, R2.w, R1, vertex.normal.xzzw;
MUL R0.xy, vertex.color.y, R0;
MUL R0.xz, R0.xyyw, c[19].z;
MUL R1.xyz, R3.y, c[17];
MOV R0.w, c[0].y;
MUL R1.xyz, vertex.texcoord[1].y, R1;
MUL R0.y, vertex.texcoord[1], c[19];
MAD R0.xyz, R3.xyxw, R0, R1;
MAD R0.xyz, R0, c[17].w, R2;
MAD R1.xyz, vertex.texcoord[1].x, c[17], R0;
DP3 R0.x, R1, c[15];
ADD R0.x, R0, c[15].w;
MUL R0.xyz, R0.x, c[15];
ADD R1.xyz, -R0, R1;
MAD R0.xyz, R0, c[16].x, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 50 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_invtrans_modelview0]
Matrix 8 [_Object2World]
Vector 12 [_Time]
Vector 13 [_Scale]
Vector 14 [_SquashPlaneNormal]
Float 15 [_SquashAmount]
Vector 16 [_Wind]
"vs_2_0
; 55 ALU
def c17, 0.00000000, 1.00000000, 2.00000000, -0.50000000
def c18, 1.97500002, 0.79299998, 0.37500000, 0.19300000
def c19, 2.00000000, -1.00000000, 3.00000000, 0.30000001
def c20, 0.10000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
dcl_color0 v5
mul r0, v2.y, c5
mad r1, v2.x, c4, r0
add r0.xyz, r1, c17.x
abs r0.w, v1
add r3.w, -r0, c17.y
mad r0.xyz, r0, r3.w, v0
mov r2.xyz, c11
dp3 r0.w, c17.y, r2
mad r1, v2.z, c6, r1
add r2, r1, c17.x
dp4 r2.y, r2, r2
mul r3.xyz, r0, c13
add r0.w, v5.x, r0
add r0.x, v5.y, r0.w
mov r0.y, r0.w
dp3 r0.x, r3, r0.x
add r0.xy, r0, c12.y
mul r0, r0.xxyy, c18
frc r0, r0
mad r0, r0, c17.z, c17.w
frc r0, r0
mad r0, r0, c19.x, c19.y
abs r0, r0
mul r1, r0, r0
mad r0, -r0, c19.x, c19.z
mul r0, r1, r0
rsq r2.y, r2.y
mad r1.xy, r2.y, r2.xzzw, -v2.xzzw
add r2.xy, r0.xzzw, r0.ywzw
mad r0.xy, r3.w, r1, v2.xzzw
mul r0.xy, v5.y, r0
mul r0.xz, r0.xyyw, c20.x
mul r1.xyz, r2.y, c16
mov r0.w, c17.y
mul r1.xyz, v4.y, r1
mul r0.y, v4, c19.w
mad r0.xyz, r2.xyxw, r0, r1
mad r0.xyz, r0, c16.w, r3
mad r1.xyz, v4.x, c16, r0
dp3 r0.x, r1, c14
add r0.x, r0, c14.w
mul r0.xyz, r0.x, c14
add r1.xyz, -r0, r1
mad r0.xyz, r0, c15.x, r1
dp4 r1.w, r0, c3
dp4 r1.z, r0, c2
dp4 r1.x, r0, c0
dp4 r1.y, r0, c1
mov oPos, r1
mov oT1.xy, r1.zwzw
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
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
Matrix 5 [_TerrainEngineBendTree]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
"!!ARBvp1.0
# 17 ALU
PARAM c[12] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[9];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[10];
ADD R0.w, R0, c[10];
MUL R1.xyz, R0.w, c[10];
ADD R0.xyz, -R1, R0;
MOV R0.w, c[0].y;
MAD R0.xyz, R1, c[11].x, R0;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_TerrainEngineBendTree]
Vector 8 [_Scale]
Vector 9 [_SquashPlaneNormal]
Float 10 [_SquashAmount]
"vs_2_0
; 19 ALU
def c11, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
mul r1.xyz, v0, c8
mov r1.w, c11.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c9
add r0.x, r0, c9.w
mul r0.xyz, r0.x, c9
add r1.xyz, -r0, r1
mad r1.xyz, r0, c10.x, r1
mov r1.w, c11.y
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT0.xy, r0.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
# 1 ALU, 0 TEX
PARAM c[1] = { { 0 } };
MOV result.color, c[0].x;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 4 ALU
dcl t0.xy
rcp r0.x, t0.y
mul r0.x, t0, r0
mov_pp r0, r0.x
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
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 5 [_TerrainEngineBendTree]
Vector 9 [_Scale]
Vector 10 [_SquashPlaneNormal]
Float 11 [_SquashAmount]
"!!ARBvp1.0
# 18 ALU
PARAM c[12] = { { 0, 1 },
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.position, c[9];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, vertex.color.w, R0, R1;
DP3 R0.w, R0, c[10];
ADD R0.w, R0, c[10];
MUL R1.xyz, R0.w, c[10];
ADD R0.xyz, -R1, R0;
MOV R0.w, c[0].y;
MAD R0.xyz, R1, c[11].x, R0;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_TerrainEngineBendTree]
Vector 8 [_Scale]
Vector 9 [_SquashPlaneNormal]
Float 10 [_SquashAmount]
"vs_2_0
; 20 ALU
def c11, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mul r1.xyz, v0, c8
mov r1.w, c11.x
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
add r0.xyz, r0, -r1
mad r1.xyz, v1.w, r0, r1
dp3 r0.x, r1, c9
add r0.x, r0, c9.w
mul r0.xyz, r0.x, c9
add r1.xyz, -r0, r1
mad r1.xyz, r0, c10.x, r1
mov r1.w, c11.y
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
mov oT0.xy, v2
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
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
Vector 5 [_TreeBillboardCameraRight]
Vector 6 [_TreeBillboardCameraUp]
Vector 7 [_TreeBillboardCameraFront]
Vector 8 [_TreeBillboardCameraPos]
Vector 9 [_TreeBillboardDistances]
"!!ARBvp1.0
# 19 ALU
PARAM c[10] = { { 0 },
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
TEMP R1;
ADD R0.xyz, vertex.position, -c[8];
DP3 R0.x, R0, R0;
SLT R0.x, c[9], R0;
MAD R0.z, R0.x, -vertex.texcoord[0].y, vertex.texcoord[0].y;
MAD R0.xy, -vertex.texcoord[1], R0.x, vertex.texcoord[1];
ADD R0.z, -R0.y, R0;
MAD R1.xyz, R0.x, c[5], vertex.position;
MAD R0.y, R0.z, c[8].w, R0;
MOV R0.w, vertex.position;
MAD R1.xyz, R0.y, c[6], R1;
ABS R0.x, R0;
MUL R0.xyz, R0.x, c[7];
MAD R0.xyz, R0, c[6].w, R1;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
SLT result.texcoord[0].y, c[0].x, vertex.texcoord[0];
MOV result.texcoord[0].x, vertex.texcoord[0];
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_TreeBillboardCameraRight]
Vector 5 [_TreeBillboardCameraUp]
Vector 6 [_TreeBillboardCameraFront]
Vector 7 [_TreeBillboardCameraPos]
Vector 8 [_TreeBillboardDistances]
"vs_2_0
; 23 ALU
def c9, 0.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
add r0.xyz, v0, -c7
dp3 r0.x, r0, r0
slt r0.x, c8, r0
max r0.x, -r0, r0
slt r0.x, c9, r0
add r0.z, -r0.x, c9.y
mul r0.xy, r0.z, v2
mad r0.z, r0, v1.y, -r0.y
mad r1.xyz, r0.x, c4, v0
mad r0.y, r0.z, c7.w, r0
mov r1.w, v0
mad r1.xyz, r0.y, c5, r1
abs r0.x, r0
mul r0.xyz, r0.x, c6
mad r1.xyz, r0, c5.w, r1
dp4 r0.w, r1, c3
dp4 r0.z, r1, c2
dp4 r0.x, r1, c0
dp4 r0.y, r1, c1
mov oPos, r0
mov oT1.xy, r0.zwzw
slt oT0.y, c9.x, v1
mov oT0.x, v1
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 4 ALU, 1 TEX
PARAM c[1] = { { 0, 0.0010004044 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
SLT R0.x, R0.w, c[0].y;
MOV result.color, c[0].x;
KIL -R0.x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c0, -0.00100040, 0.00000000, 1.00000000, 0
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
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
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Vector 5 [_WavingTint]
Vector 6 [_WaveAndDistance]
Vector 7 [_CameraPosition]
Vector 8 [_CameraRight]
Vector 9 [_CameraUp]
"!!ARBvp1.0
# 48 ALU
PARAM c[17] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.mvp,
		program.local[5..9],
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
ADD R0.xyz, vertex.position, -c[7];
DP3 R0.x, R0, R0;
SLT R0.x, c[6].w, R0;
MAD R0.xy, -vertex.attrib[14], R0.x, vertex.attrib[14];
MAD R1.xyz, R0.x, c[8], vertex.position;
MAD R3.xyz, R0.y, c[9], R1;
MUL R0.x, R3.z, c[6].y;
MUL R1.xyz, R0.x, c[11];
MUL R0.x, R3, c[6].y;
MAD R1, R0.x, c[10], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[6].x, R1;
FRC R0, R0;
MUL R0, R0, c[11].w;
ADD R0, R0, -c[12].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[12].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[12].z, R0;
MAD R0, R1, c[12].y, R0;
MUL R0, R0, R0;
MUL R0, R0, R0;
MUL R1, R0, vertex.attrib[14].y;
DP4 R2.x, R1, c[14];
DP4 R2.y, R1, c[13];
MAD R1.xz, -R2.xyyw, c[6].z, R3;
MOV R1.y, R3;
MOV R1.w, vertex.position;
ADD R2.xyz, R1, -c[7];
DP3 R2.x, R2, R2;
DP4 result.position.w, R1, c[4];
DP4 result.position.z, R1, c[3];
DP4 result.position.y, R1, c[2];
DP4 result.position.x, R1, c[1];
ADD R2.x, -R2, c[6].w;
MUL R1.y, R2.x, c[7].w;
MUL R1.w, R1.y, c[0].y;
DP4 R0.x, R0, c[15].xxyz;
MOV R1.x, c[15].w;
ADD R1.xyz, -R1.x, c[5];
MAD R0.xyz, R0.x, R1, c[15].w;
MIN R0.w, R1, c[16].x;
MUL R0.xyz, R0, vertex.color;
MAX result.color.w, R0, c[16].y;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 48 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_WavingTint]
Vector 5 [_WaveAndDistance]
Vector 6 [_CameraPosition]
Vector 7 [_CameraRight]
Vector 8 [_CameraUp]
"vs_2_0
; 54 ALU
def c9, 0.00000000, 1.00000000, 6.40884876, -3.14159274
def c10, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c11, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c12, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c13, 0.00833330, -0.00019841, -0.50000000, 0.50000000
def c14, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c15, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c16, 0.47193992, 0.18877596, 0.09438798, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_texcoord0 v3
dcl_color0 v5
add r0.xyz, v0, -c6
dp3 r0.x, r0, r0
slt r0.x, c5.w, r0
max r0.x, -r0, r0
slt r0.x, c9, r0
add r0.x, -r0, c9.y
mul r0.xy, r0.x, v1
mad r1.xyz, r0.x, c7, v0
mad r3.xyz, r0.y, c8, r1
mul r0.x, r3.z, c5.y
mul r1.xyz, r0.x, c10
mul r0.x, r3, c5.y
mad r0, r0.x, c11, r1.xyyz
mov r1.x, c5
mad r0, c12, r1.x, r0
frc r0, r0
mad r0, r0, c9.z, c9.w
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c10.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c13.x, r0
mad r0, r1, c13.y, r0
mul r0, r0, r0
mul r0, r0, r0
mul r1, r0, v1.y
dp4 r2.y, r1, c14
dp4 r2.x, r1, c15
mad r1.xz, -r2.xyyw, c5.z, r3
mov r1.y, r3
add r2.xyz, r1, -c6
mov r1.w, v0
dp3 r3.x, r2, r2
dp4 r2.w, r1, c3
dp4 r2.z, r1, c2
dp4 r2.x, r1, c0
dp4 r2.y, r1, c1
add r1.x, -r3, c5.w
mul r1.w, r1.x, c6
mov r1.xyz, c4
dp4 r0.x, r0, c16.xxyz
mul r1.w, r1, c12.y
add r1.xyz, c13.z, r1
mad r0.xyz, r0.x, r1, c13.w
min r0.w, r1, c9.y
mul r0.xyz, r0, v5
mov oPos, r2
mov oT1.xy, r2.zwzw
max oD0.w, r0, c9.x
mul oD0.xyz, r0, c12.y
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
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
Bind "texcoord" TexCoord0
Vector 5 [_WavingTint]
Vector 6 [_WaveAndDistance]
Vector 7 [_CameraPosition]
"!!ARBvp1.0
# 42 ALU
PARAM c[15] = { { 1.2, 2, 1.6, 4.8000002 },
		state.matrix.mvp,
		program.local[5..7],
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
MUL R0.x, vertex.position.z, c[6].y;
MUL R1.xyz, R0.x, c[9];
MUL R0.x, vertex.position, c[6].y;
MAD R1, R0.x, c[8], R1.xyyz;
MOV R0, c[0];
MAD R0, R0, c[6].x, R1;
FRC R0, R0;
MUL R0, R0, c[9].w;
ADD R0, R0, -c[10].x;
MUL R1, R0, R0;
MUL R2, R1, R0;
MAD R0, R2, c[10].w, R0;
MUL R2, R2, R1;
MUL R1, R2, R1;
MAD R0, R2, c[10].z, R0;
MAD R0, R1, c[10].y, R0;
MUL R0, R0, R0;
MUL R1, R0, R0;
MUL R2.x, vertex.color.w, c[6].z;
MUL R0, R1, R2.x;
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[12];
MAD R0.xz, -R2.xyyw, c[6].z, vertex.position;
MOV R0.yw, vertex.position;
ADD R2.xyz, R0, -c[7];
DP3 R2.x, R2, R2;
DP4 result.position.w, R0, c[4];
DP4 result.position.z, R0, c[3];
DP4 result.position.y, R0, c[2];
DP4 result.position.x, R0, c[1];
ADD R2.x, -R2, c[6].w;
MUL R0.y, R2.x, c[7].w;
MUL R0.w, R0.y, c[0].y;
MOV R0.x, c[13].w;
MIN R0.w, R0, c[14].x;
ADD R0.xyz, -R0.x, c[5];
DP4 R1.x, R1, c[13].xxyz;
MAD R0.xyz, R1.x, R0, c[13].w;
MUL R0.xyz, vertex.color, R0;
MAX result.color.w, R0, c[14].y;
MUL result.color.xyz, R0, c[0].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 42 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_WavingTint]
Vector 5 [_WaveAndDistance]
Vector 6 [_CameraPosition]
"vs_2_0
; 45 ALU
def c7, 0.00600000, 0.02000000, 0.05000000, -0.16161616
def c8, 0.01200000, 0.02000000, 0.06000000, 0.02400000
def c9, 1.20000005, 2.00000000, 1.60000002, 4.80000019
def c10, 6.40884876, -3.14159274, 0.00833330, -0.00019841
def c11, 0.00600000, 0.02000000, -0.02000000, 0.10000000
def c12, 0.02400000, 0.04000000, -0.12000000, 0.09600000
def c13, 0.47193992, 0.18877596, 0.09438798, -0.50000000
def c14, 0.50000000, 1.00000000, 0.00000000, 0
dcl_position0 v0
dcl_texcoord0 v3
dcl_color0 v5
mul r0.x, v0.z, c5.y
mul r1.xyz, r0.x, c7
mul r0.x, v0, c5.y
mad r1, r0.x, c8, r1.xyyz
mov r0.x, c5
mad r0, c9, r0.x, r1
frc r0, r0
mad r0, r0, c10.x, c10.y
mul r1, r0, r0
mul r2, r1, r0
mad r0, r2, c7.w, r0
mul r2, r2, r1
mul r1, r2, r1
mad r0, r2, c10.z, r0
mad r0, r1, c10.w, r0
mul r0, r0, r0
mov r2.yw, v0
mul r1, r0, r0
mul r2.x, v5.w, c5.z
mul r0, r1, r2.x
dp4 r2.z, r0, c11
dp4 r2.x, r0, c12
mad r2.xz, -r2, c5.z, v0
add r0.xyz, r2, -c6
dp3 r3.x, r0, r0
dp4 r0.w, r2, c3
dp4 r0.z, r2, c2
dp4 r0.x, r2, c0
dp4 r0.y, r2, c1
mov oPos, r0
add r0.x, -r3, c5.w
mov oT1.xy, r0.zwzw
mul r0.w, r0.x, c6
mov r0.xyz, c4
mul r0.w, r0, c9.y
min r0.w, r0, c14.y
add r0.xyz, c13.w, r0
dp4 r1.x, r1, c13.xxyz
mad r0.xyz, r1.x, r0, c14.x
mul r0.xyz, v5, r0
max oD0.w, r0, c14.z
mul oD0.xyz, r0, c9.y
mov oT0.xy, v3
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
# 5 ALU, 1 TEX
PARAM c[2] = { program.local[0],
		{ 0 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, R0.w, fragment.color.primary.w;
SLT R0.x, R0, c[0];
MOV result.color, c[1].x;
KIL -R0.x;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Cutoff]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 7 ALU, 2 TEX
dcl_2d s0
def c1, 0.00000000, 1.00000000, 0, 0
dcl v0.xyzw
dcl t0.xy
dcl t1.xy
texld r0, t0, s0
mad_pp r0.x, r0.w, v0.w, -c0
cmp r0.x, r0, c1, c1.y
mov_pp r0, -r0.x
texkill r0.xyzw
rcp r0.x, t1.y
mul r0.x, t1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}