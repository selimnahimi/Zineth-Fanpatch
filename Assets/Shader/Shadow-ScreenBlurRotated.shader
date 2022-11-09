//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Shadow-ScreenBlurRotated" {
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
"3.0-!!ARBvp1.0
# 8 ALU
PARAM c[9] = { { 0 },
		state.matrix.mvp,
		state.matrix.texture[0] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[0].y, R0, c[6];
DP4 result.texcoord[0].x, R0, c[5];
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
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
"vs_3_0
; 8 ALU
dcl_position o0
dcl_texcoord0 o1
def c8, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c8.x
mov r0.xy, v1
dp4 o1.y, r0, c5
dp4 o1.x, r0, c4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ScreenParams]
Vector 1 [_BlurOffsets0]
Vector 2 [_BlurOffsets1]
Vector 3 [_BlurOffsets2]
Vector 4 [_BlurOffsets3]
Vector 5 [_BlurOffsets4]
Vector 6 [_BlurOffsets5]
Vector 7 [_BlurOffsets6]
Vector 8 [_BlurOffsets7]
Vector 9 [unity_ShadowBlurParams]
SetTexture 0 [unity_RandomRotation16] 2D
SetTexture 1 [_MainTex] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 100 ALU, 10 TEX
PARAM c[11] = { program.local[0..9],
		{ 0.0039215689, 1, 0.0625, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3, fragment.texcoord[0], texture[1], 2D;
MAD R3.z, R3.w, c[10].x, R3;
MUL R0.xy, fragment.texcoord[0], c[0];
MUL R0.xy, R0, c[10].z;
TEX R0, R0, texture[0], 2D;
MAD R2, R0, c[10].w, -c[10].y;
MUL R0.zw, R2.xyxy, c[1].xyxy;
ADD R1.x, -R3.z, c[10].y;
RCP R1.x, R1.x;
MUL_SAT R3.w, R1.x, c[9].y;
ADD R0.z, R0, R0.w;
MUL R0.xy, R2.zwzw, c[1];
ADD R0.w, R0.x, R0.y;
MAD R0.xy, R3.w, R0.zwzw, fragment.texcoord[0];
TEX R1, R0, texture[1], 2D;
MAD R1.z, R1.w, c[10].x, R1;
MUL R0.zw, R2.xyxy, c[2].xyxy;
ADD R1.z, R3, -R1;
ADD R0.z, R0, R0.w;
MUL R0.xy, R2.zwzw, c[2];
ADD R0.w, R0.x, R0.y;
MAD R0.xy, R3.w, R0.zwzw, fragment.texcoord[0];
TEX R0, R0, texture[1], 2D;
MAD R0.z, R0.w, c[10].x, R0;
ABS R1.z, R1;
ADD_SAT R0.w, -R1.z, c[9].x;
ADD R1.z, R3, -R0;
MUL R0.zw, R0.w, R1.xyxy;
ABS R1.x, R1.z;
MAD R0.zw, R3.xyxy, c[9].x, R0;
ADD_SAT R1.x, -R1, c[9];
MAD R3.xy, R1.x, R0, R0.zwzw;
MUL R0.zw, R2.xyxy, c[3].xyxy;
MUL R1.xy, R2, c[4];
ADD R1.x, R1, R1.y;
ADD R0.z, R0, R0.w;
MUL R0.xy, R2.zwzw, c[3];
ADD R0.w, R0.x, R0.y;
MUL R0.xy, R2.zwzw, c[4];
ADD R1.y, R0.x, R0;
MAD R0.zw, R3.w, R0, fragment.texcoord[0].xyxy;
MAD R0.xy, R3.w, R1, fragment.texcoord[0];
TEX R1, R0.zwzw, texture[1], 2D;
TEX R0, R0, texture[1], 2D;
MAD R0.z, R0.w, c[10].x, R0;
MAD R1.z, R1.w, c[10].x, R1;
ADD R0.w, R3.z, -R1.z;
ADD R0.z, R3, -R0;
ABS R1.z, R0;
ABS R0.w, R0;
ADD_SAT R0.z, -R0.w, c[9].x;
MAD R0.zw, R0.z, R1.xyxy, R3.xyxy;
ADD_SAT R1.x, -R1.z, c[9];
MAD R3.xy, R1.x, R0, R0.zwzw;
MUL R0.zw, R2.xyxy, c[5].xyxy;
MUL R1.xy, R2, c[6];
ADD R1.x, R1, R1.y;
ADD R0.z, R0, R0.w;
MUL R0.xy, R2.zwzw, c[5];
ADD R0.w, R0.x, R0.y;
MUL R0.xy, R2.zwzw, c[6];
ADD R1.y, R0.x, R0;
MAD R0.zw, R3.w, R0, fragment.texcoord[0].xyxy;
MAD R0.xy, R3.w, R1, fragment.texcoord[0];
TEX R1, R0.zwzw, texture[1], 2D;
TEX R0, R0, texture[1], 2D;
MAD R0.z, R0.w, c[10].x, R0;
MAD R1.z, R1.w, c[10].x, R1;
ADD R0.w, R3.z, -R1.z;
ADD R0.z, R3, -R0;
ABS R1.z, R0;
ABS R0.w, R0;
ADD_SAT R0.z, -R0.w, c[9].x;
MAD R0.zw, R0.z, R1.xyxy, R3.xyxy;
ADD_SAT R1.x, -R1.z, c[9];
MAD R3.xy, R1.x, R0, R0.zwzw;
MUL R0.zw, R2.xyxy, c[7].xyxy;
ADD R0.z, R0, R0.w;
MUL R0.xy, R2.zwzw, c[7];
ADD R0.w, R0.x, R0.y;
MAD R0.xy, R3.w, R0.zwzw, fragment.texcoord[0];
MUL R0.zw, R2.xyxy, c[8].xyxy;
ADD R0.z, R0, R0.w;
MUL R1.xy, R2.zwzw, c[8];
ADD R0.w, R1.x, R1.y;
TEX R1, R0, texture[1], 2D;
MAD R0.zw, R3.w, R0, fragment.texcoord[0].xyxy;
TEX R0, R0.zwzw, texture[1], 2D;
MAD R0.z, R0.w, c[10].x, R0;
MAD R1.z, R1.w, c[10].x, R1;
ADD R0.w, R3.z, -R1.z;
ADD R0.z, R3, -R0;
ABS R0.w, R0;
ABS R0.z, R0;
ADD_SAT R0.w, -R0, c[9].x;
MAD R1.xy, R0.w, R1, R3;
ADD_SAT R0.z, -R0, c[9].x;
MAD R0.xy, R0.z, R0, R1;
RCP R0.y, R0.y;
MUL result.color, R0.x, R0.y;
END
# 100 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ScreenParams]
Vector 1 [_BlurOffsets0]
Vector 2 [_BlurOffsets1]
Vector 3 [_BlurOffsets2]
Vector 4 [_BlurOffsets3]
Vector 5 [_BlurOffsets4]
Vector 6 [_BlurOffsets5]
Vector 7 [_BlurOffsets6]
Vector 8 [_BlurOffsets7]
Vector 9 [unity_ShadowBlurParams]
SetTexture 0 [unity_RandomRotation16] 2D
SetTexture 1 [_MainTex] 2D
"ps_3_0
; 90 ALU, 10 TEX
dcl_2d s0
dcl_2d s1
def c10, 0.00392157, 1.00000000, 0.06250000, 0
def c11, 2.00000000, -1.00000000, 0, 0
dcl_texcoord0 v0.xy
texld r3, v0, s1
mad_pp r3.z, r3.w, c10.x, r3
mul r0.xy, v0, c0
mul r0.xy, r0, c10.z
texld r0, r0, s0
mad r2, r0, c11.x, c11.y
mul r0.zw, r2.xyxy, c1.xyxy
add_pp r1.x, -r3.z, c10.y
rcp r1.x, r1.x
mul_sat r3.w, r1.x, c9.y
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c1
add r0.w, r0.x, r0.y
mad r0.xy, r3.w, r0.zwzw, v0
texld r1, r0, s1
mul r0.zw, r2.xyxy, c2.xyxy
mad_pp r1.z, r1.w, c10.x, r1
add_pp r1.z, r3, -r1
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c2
add r0.w, r0.x, r0.y
mad r0.xy, r3.w, r0.zwzw, v0
texld r0, r0, s1
mad_pp r0.z, r0.w, c10.x, r0
abs_pp r1.z, r1
add_pp_sat r0.w, -r1.z, c9.x
add_pp r1.z, r3, -r0
mul_pp r0.zw, r0.w, r1.xyxy
abs_pp r1.x, r1.z
mad_pp r0.zw, r3.xyxy, c9.x, r0
add_pp_sat r1.x, -r1, c9
mad_pp r3.xy, r1.x, r0, r0.zwzw
mul r0.zw, r2.xyxy, c3.xyxy
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c3
add r0.w, r0.x, r0.y
mad r1.xy, r3.w, r0.zwzw, v0
texld r1, r1, s1
mul r0.zw, r2.xyxy, c4.xyxy
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c4
add r0.w, r0.x, r0.y
mad r0.xy, r3.w, r0.zwzw, v0
texld r0, r0, s1
mad_pp r0.z, r0.w, c10.x, r0
mad_pp r1.z, r1.w, c10.x, r1
add_pp r0.w, r3.z, -r1.z
add_pp r0.z, r3, -r0
abs_pp r1.z, r0
abs_pp r0.w, r0
add_pp_sat r0.z, -r0.w, c9.x
mad_pp r0.zw, r0.z, r1.xyxy, r3.xyxy
add_pp_sat r1.x, -r1.z, c9
mad_pp r3.xy, r1.x, r0, r0.zwzw
mul r0.zw, r2.xyxy, c5.xyxy
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c5
add r0.w, r0.x, r0.y
mad r1.xy, r3.w, r0.zwzw, v0
texld r1, r1, s1
mul r0.zw, r2.xyxy, c6.xyxy
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c6
add r0.w, r0.x, r0.y
mad r0.xy, r3.w, r0.zwzw, v0
texld r0, r0, s1
mad_pp r0.z, r0.w, c10.x, r0
mad_pp r1.z, r1.w, c10.x, r1
add_pp r0.w, r3.z, -r1.z
add_pp r0.z, r3, -r0
abs_pp r1.z, r0
abs_pp r0.w, r0
add_pp_sat r0.z, -r0.w, c9.x
mad_pp r0.zw, r0.z, r1.xyxy, r3.xyxy
add_pp_sat r1.x, -r1.z, c9
mad_pp r3.xy, r1.x, r0, r0.zwzw
mul r0.zw, r2.xyxy, c7.xyxy
add r0.z, r0, r0.w
mul r0.xy, r2.zwzw, c7
add r0.w, r0.x, r0.y
mad r0.xy, r3.w, r0.zwzw, v0
mul r0.zw, r2.xyxy, c8.xyxy
add r0.z, r0, r0.w
mul r1.xy, r2.zwzw, c8
add r0.w, r1.x, r1.y
texld r1, r0, s1
mad r2.xy, r3.w, r0.zwzw, v0
texld r0, r2, s1
mad_pp r0.z, r0.w, c10.x, r0
mad_pp r1.z, r1.w, c10.x, r1
add_pp r0.w, r3.z, -r1.z
add_pp r0.z, r3, -r0
abs_pp r0.w, r0
abs_pp r0.z, r0
add_pp_sat r0.w, -r0, c9.x
mad_pp r1.xy, r0.w, r1, r3
add_pp_sat r0.z, -r0, c9.x
mad_pp r0.xy, r0.z, r0, r1
rcp_pp r0.y, r0.y
mul_pp oC0, r0.x, r0.y
"
}
}
 }
}
Fallback Off
}