//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Edge Detect YY" {
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
# 18 ALU, 3 TEX
PARAM c[3] = { program.local[0],
		{ 2, 0.11297607, 0.11602783, 9.9999999e-009 },
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[2], texture[0], 2D;
MAD R1.xyz, R0, c[1].x, -R1;
ADD R1.xyz, R1, -R2;
DP3 R1.x, R1, R1;
SLT R2.x, c[1].z, R0.w;
SLT R1.w, R0, c[1].y;
ADD_SAT R1.w, R1, R2.x;
MOV R2.y, c[0].x;
CMP R1.w, -R1, c[1], R2.y;
ADD R1.x, R1, -R1.w;
CMP R1.xyz, R1.x, R0, c[2].x;
SGE R2.x, R0.w, c[1].z;
SGE R1.w, c[1].y, R0;
ADD_SAT R1.w, R1, R2.x;
CMP result.color.xyz, -R1.w, R0, R1;
MOV result.color.w, R0;
END
# 18 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Treshold]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 20 ALU, 3 TEX
dcl_2d s0
def c1, 2.00000000, 0.11602783, 0.00000000, 1.00000000
def c2, -0.11297607, 0.00000001, 0.11297607, -0.11602783
dcl t0.xy
dcl t1.xy
dcl t2.xy
texld r0, t2, s0
texld r2, t0, s0
texld r1, t1, s0
mad_pp r1.xyz, r2, c1.x, -r1
add_pp r3.xyz, r1, -r0
add_pp r0.x, r2.w, c2
add_pp r1.x, -r2.w, c1.y
cmp_pp r1.x, r1, c1.z, c1.w
cmp_pp r0.x, r0, c1.z, c1.w
add_pp_sat r0.x, r0, r1
mov r0.y, c2
cmp r0.x, -r0, c0, r0.y
dp3_pp r1.x, r3, r3
add r0.x, r1, -r0
cmp_pp r3.xyz, r0.x, c1.z, r2
add_pp r1.x, r2.w, c2.w
add_pp r0.x, -r2.w, c2.z
cmp_pp r1.x, r1, c1.w, c1.z
cmp_pp r0.x, r0, c1.w, c1.z
add_pp_sat r0.x, r0, r1
mov_pp r0.w, r2
cmp_pp r0.xyz, -r0.x, r3, r2
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}