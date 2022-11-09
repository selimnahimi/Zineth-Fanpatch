//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/TextureCopy" {
Properties {
 _MainTex ("Main Texture", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Background-999" }
 Pass {
  Tags { "QUEUE"="Background-999" }
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
PARAM c[5] = { { 0 },
		state.matrix.texture[0] };
TEMP R0;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
MOV result.position, vertex.position;
DP4 result.texcoord[0].y, R0, c[2];
DP4 result.texcoord[0].x, R0, c[1];
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_texture0]
"vs_2_0
; 5 ALU
def c4, 0.00000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.zw, c4.x
mov r0.xy, v1
mov oPos, v0
dp4 oT0.y, r0, c1
dp4 oT0.x, r0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 1 ALU, 1 TEX
TEX result.color, fragment.texcoord[0], texture[0], 2D;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D
"ps_2_0
; 1 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
mov oC0, r0
"
}
}
 }
}
Fallback Off
}