//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Noise Shader RGB" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _GrainTex ("Base (RGB)", 2D) = "gray" {}
 _ScratchTex ("Base (RGB)", 2D) = "gray" {}
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
Vector 9 [_GrainOffsetScale]
Vector 10 [_ScratchOffsetScale]
"!!ARBvp1.0
# 10 ALU
PARAM c[11] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0],
		program.local[9..10] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[9].zwzw, c[9];
MAD result.texcoord[2].xy, vertex.texcoord[0], c[10].zwzw, c[10];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 10 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
Vector 8 [_GrainOffsetScale]
Vector 9 [_ScratchOffsetScale]
"vs_2_0
; 10 ALU
def c10, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c10.x
mov r0.xy, v1
dp4 oT0.y, r0, c5
dp4 oT0.x, r0, c4
mad oT1.xy, v1, c8.zwzw, c8
mad oT2.xy, v1, c9.zwzw, c9
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Intensity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_GrainTex] 2D
SetTexture 2 [_ScratchTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, fragment.texcoord[1], texture[1], 2D;
TEX R2.xyz, fragment.texcoord[2], texture[2], 2D;
MAD R1.xyz, R1, c[1].x, -c[1].y;
MAD R0.xyz, R1, c[0].x, R0;
MAD R1.xyz, R2, c[1].x, -c[1].y;
MAD result.color.xyz, R1, c[0].y, R0;
MOV result.color.w, R0;
END
# 8 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Intensity]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_GrainTex] 2D
SetTexture 2 [_ScratchTex] 2D
"ps_2_0
; 6 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c1, 2.00000000, -1.00000000, 0, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
texld r0, t2, s2
texld r1, t1, s1
texld r2, t0, s0
mad r1.xyz, r1, c1.x, c1.y
mad_pp r1.xyz, r1, c0.x, r2
mad r0.xyz, r0, c1.x, c1.y
mov_pp r0.w, r2
mad_pp r0.xyz, r0, c0.y, r1
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}