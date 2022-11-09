//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Shadow-ScreenBlur" {
Properties {
 _MainTex ("Base", 2D) = "white" {}
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
"!!ARBvp1.0
# 5 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
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
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_BlurOffsets0]
Vector 1 [_BlurOffsets1]
Vector 2 [_BlurOffsets2]
Vector 3 [_BlurOffsets3]
Vector 4 [_BlurOffsets4]
Vector 5 [_BlurOffsets5]
Vector 6 [_BlurOffsets6]
Vector 7 [_BlurOffsets7]
Vector 8 [unity_ShadowBlurParams]
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 64 ALU, 9 TEX
PARAM c[10] = { program.local[0..8],
		{ 0.0039215689, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R8, fragment.texcoord[0], texture[0], 2D;
MAD R8.z, R8.w, c[9].x, R8;
ADD R0.x, -R8.z, c[9].y;
RCP R0.x, R0.x;
MUL_SAT R0.z, R0.x, c[8].y;
MAD R6.zw, R0.z, c[0].xyxy, fragment.texcoord[0].xyxy;
MAD R5.xy, R0.z, c[2], fragment.texcoord[0];
MAD R4.xy, R0.z, c[3], fragment.texcoord[0];
MAD R3.xy, R0.z, c[4], fragment.texcoord[0];
MAD R2.xy, R0.z, c[5], fragment.texcoord[0];
MAD R1.xy, R0.z, c[6], fragment.texcoord[0];
MAD R6.xy, R0.z, c[1], fragment.texcoord[0];
MAD R0.xy, R0.z, c[7], fragment.texcoord[0];
TEX R7, R6.zwzw, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
TEX R4, R4, texture[0], 2D;
TEX R5, R5, texture[0], 2D;
TEX R6, R6, texture[0], 2D;
TEX R1, R1, texture[0], 2D;
TEX R3, R3, texture[0], 2D;
MAD R4.z, R4.w, c[9].x, R4;
MAD R5.z, R5.w, c[9].x, R5;
ADD R4.w, R8.z, -R5.z;
ADD R4.z, R8, -R4;
MAD R2.z, R2.w, c[9].x, R2;
MAD R0.z, R0.w, c[9].x, R0;
MAD R7.z, R7.w, c[9].x, R7;
ADD R7.z, R8, -R7;
MAD R3.z, R3.w, c[9].x, R3;
ADD R2.w, R8.z, -R3.z;
ADD R2.z, R8, -R2;
ABS R2.w, R2;
ABS R2.z, R2;
MAD R1.z, R1.w, c[9].x, R1;
ADD R0.w, R8.z, -R1.z;
ADD R0.z, R8, -R0;
ABS R0.w, R0;
ABS R0.z, R0;
MAD R6.z, R6.w, c[9].x, R6;
ABS R7.z, R7;
ADD_SAT R6.w, -R7.z, c[8].x;
ADD R7.z, R8, -R6;
MUL R6.zw, R6.w, R7.xyxy;
ABS R7.x, R7.z;
ABS R4.w, R4;
ABS R5.z, R4;
MAD R6.zw, R8.xyxy, c[8].x, R6;
ADD_SAT R7.x, -R7, c[8];
MAD R6.xy, R7.x, R6, R6.zwzw;
ADD_SAT R4.z, -R4.w, c[8].x;
MAD R4.zw, R4.z, R5.xyxy, R6.xyxy;
ADD_SAT R5.x, -R5.z, c[8];
MAD R4.xy, R5.x, R4, R4.zwzw;
ADD_SAT R2.w, -R2, c[8].x;
MAD R3.xy, R2.w, R3, R4;
ADD_SAT R2.z, -R2, c[8].x;
MAD R2.xy, R2.z, R2, R3;
ADD_SAT R0.w, -R0, c[8].x;
MAD R1.xy, R0.w, R1, R2;
ADD_SAT R0.z, -R0, c[8].x;
MAD R0.xy, R0.z, R0, R1;
RCP R0.y, R0.y;
MUL result.color, R0.x, R0.y;
END
# 64 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_BlurOffsets0]
Vector 1 [_BlurOffsets1]
Vector 2 [_BlurOffsets2]
Vector 3 [_BlurOffsets3]
Vector 4 [_BlurOffsets4]
Vector 5 [_BlurOffsets5]
Vector 6 [_BlurOffsets6]
Vector 7 [_BlurOffsets7]
Vector 8 [unity_ShadowBlurParams]
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 57 ALU, 9 TEX
dcl_2d s0
def c9, 0.00392157, 1.00000000, 0, 0
dcl t0.xy
texld r2, t0, s0
mad r0.x, r2.w, c9, r2.z
add r1.x, -r0, c9.y
rcp r1.x, r1.x
mul_sat r1.x, r1, c8.y
mad r3.xy, r1.x, c1, t0
mad r4.xy, r1.x, c0, t0
mad r5.xy, r1.x, c2, t0
mad r6.xy, r1.x, c3, t0
mad r7.xy, r1.x, c4, t0
mad r8.xy, r1.x, c5, t0
mad r9.xy, r1.x, c7, t0
mad r1.xy, r1.x, c6, t0
texld r9, r9, s0
texld r1, r1, s0
texld r8, r8, s0
texld r7, r7, s0
texld r6, r6, s0
texld r5, r5, s0
texld r4, r4, s0
texld r3, r3, s0
mad r10.x, r4.w, c9, r4.z
add r10.x, r0, -r10
abs r10.x, r10
add_sat r10.x, -r10, c8
mul r4.xy, r10.x, r4
mad r11.x, r3.w, c9, r3.z
add r11.x, r0, -r11
mad r2.xy, r2, c8.x, r4
abs r10.x, r11
add_sat r4.x, -r10, c8
mad r2.xy, r4.x, r3, r2
mad r3.x, r5.w, c9, r5.z
add r3.x, r0, -r3
mad r4.x, r6.w, c9, r6.z
add r4.x, r0, -r4
abs r3.x, r3
add_sat r3.x, -r3, c8
abs r4.x, r4
mad r2.xy, r3.x, r5, r2
add_sat r3.x, -r4, c8
mad r4.x, r8.w, c9, r8.z
add r4.x, r0, -r4
mad r2.xy, r3.x, r6, r2
mad r3.x, r7.w, c9, r7.z
add r3.x, r0, -r3
abs r3.x, r3
add_sat r3.x, -r3, c8
abs r4.x, r4
mad r2.xy, r3.x, r7, r2
add_sat r3.x, -r4, c8
mad r2.xy, r3.x, r8, r2
mad r3.x, r1.w, c9, r1.z
add r3.x, r0, -r3
mad r4.x, r9.w, c9, r9.z
add r0.x, r0, -r4
abs r3.x, r3
abs r0.x, r0
add_sat r3.x, -r3, c8
add_sat r0.x, -r0, c8
mad r1.xy, r3.x, r1, r2
mad r1.xy, r0.x, r9, r1
rcp r0.x, r1.y
mul r0.x, r1, r0
mov_pp r0, r0.x
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}