//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Edge Detect X" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Treshold ("Treshold", Float) = 0.2
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_MainTex_TexelSize]
"!!ARBvp1.0
# 13 ALU
PARAM c[10] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0],
		program.local[9] };
TEMP R0;
TEMP R1;
MOV R1.zw, c[0].x;
MOV R1.xy, vertex.texcoord[0];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MOV R0.w, -c[9].y;
MOV R0.z, c[9].x;
MOV result.texcoord[0].xy, R0;
ADD result.texcoord[1].xy, R0, -c[9];
ADD result.texcoord[2].xy, R0, R0.zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
; 13 ALU
def c9, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.zw, c9.x
mov r1.xy, v1
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, -c8.y
mov r0.z, c8.x
mov oT0.xy, r0
add oT1.xy, r0, -c8
add oT2.xy, r0, r0.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Treshold]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 28 ALU, 3 TEX
PARAM c[3] = { program.local[0],
		{ 1, 0, 0.5, 0.44995117 },
		{ 2, 0.36791992, 0.39599609, 9.9999999e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
MAD R1.xyz, R0, c[2].x, -R1;
ADD R1.xyz, R1, -R2;
DP3 R1.x, R1, R1;
ADD R1.y, -R0.w, R1.w;
ADD R1.z, -R0.w, R2.w;
ABS R1.z, R1;
ABS R1.y, R1;
CMP R1.z, -R1, c[1].y, c[1].x;
CMP R1.y, -R1, c[1], c[1].x;
ADD_SAT R1.w, R1.y, R1.z;
SLT R1.z, c[1].w, R0.w;
SLT R1.y, R0.w, c[1].z;
MUL R1.y, R1, R1.z;
MUL R2.x, R1.y, R1.w;
SGE R1.z, c[2], R0.w;
SGE R1.y, R0.w, c[2];
MUL R1.y, R1, R1.z;
MOV R1.w, c[0].x;
CMP R1.y, -R1, c[2].w, R1.w;
SGE R1.x, R1, R1.y;
ABS R1.z, R2.x;
CMP R1.y, -R1.z, c[1], c[1].x;
MUL R1.x, R1.y, R1;
CMP result.color.xyz, -R1.x, c[1].y, R0;
MOV result.color.w, R0;
END
# 28 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Treshold]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 31 ALU, 3 TEX
dcl_2d s0
def c1, -0.50000000, 0.00000000, 1.00000000, 0.44995117
def c2, 2.00000000, -0.36791992, 0.39599609, 0.00000001
dcl t0.xy
dcl t1.xy
dcl t2.xy
texld r0, t2, s0
texld r1, t1, s0
texld r3, t0, s0
add_pp r2.x, -r3.w, r1.w
abs_pp r2.x, r2
add_pp r4.x, -r3.w, c2.z
add_pp r5.x, -r3.w, c1.w
mad_pp r1.xyz, r3, c2.x, -r1
add_pp r0.xyz, -r0, r1
add_pp r1.x, -r3.w, r0.w
abs_pp r1.x, r1
dp3_pp r0.x, r0, r0
cmp_pp r2.x, -r2, c1.z, c1.y
cmp_pp r1.x, -r1, c1.z, c1.y
add_pp_sat r1.x, r2, r1
add_pp r2.x, r3.w, c2.y
cmp_pp r4.x, r4, c1.z, c1.y
cmp_pp r2.x, r2, c1.z, c1.y
mul_pp r2.x, r2, r4
mov r0.w, c2
cmp r2.x, -r2, c0, r0.w
add_pp r4.x, r3.w, c1
add r0.x, r0, -r2
cmp_pp r5.x, r5, c1.y, c1.z
cmp_pp r4.x, r4, c1.y, c1.z
mul_pp r4.x, r4, r5
mul_pp r1.x, r4, r1
abs_pp r1.x, r1
cmp r0.x, r0, c1.z, c1.y
cmp_pp r1.x, -r1, c1.z, c1.y
mul_pp r0.x, r1, r0
mov_pp r0.w, r3
cmp_pp r0.xyz, -r0.x, r3, c1.y
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}