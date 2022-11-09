//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "RenderFX/Skybox Cubed" {
Properties {
 _Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _Tex ("Cubemap", CUBE) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
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
MOV result.texcoord[0].xyz, vertex.texcoord[0];
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
mov oT0.xyz, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_Tex] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], CUBE;
ADD R0.xyz, R0, c[1];
MUL result.color.w, R0, c[1];
ADD result.color.xyz, R0, -c[0];
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_Tex] CUBE
"ps_2_0
; 4 ALU, 1 TEX
dcl_cube s0
dcl t0.xyz
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Background" "RenderType"="Background" }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_Tex] { combine texture +- primary, texture alpha * primary alpha }
 }
}
Fallback Off
}