//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "RenderFX/Skybox" {
Properties {
 _Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _FrontTex ("Front (+Z)", 2D) = "white" {}
 _BackTex ("Back (-Z)", 2D) = "white" {}
 _LeftTex ("Left (+X)", 2D) = "white" {}
 _RightTex ("Right (-X)", 2D) = "white" {}
 _UpTex ("Up (+Y)", 2D) = "white" {}
 _DownTex ("down (-Y)", 2D) = "white" {}
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_FrontTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_FrontTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_BackTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_BackTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_LeftTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_LeftTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_RightTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_RightTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_UpTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_UpTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
add_pp r0.xyz, r0, c1
add_pp r0.xyz, r0, -c0
mul_pp r0.w, r0, c1
mov_pp oC0, r0
"
}
}
 }
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
Vector 0 [unity_ColorSpaceGrey]
Vector 1 [_Tint]
SetTexture 0 [_DownTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 4 ALU, 1 TEX
PARAM c[2] = { program.local[0..1] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
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
SetTexture 0 [_DownTex] 2D
"ps_2_0
; 4 ALU, 1 TEX
dcl_2d s0
dcl t0.xy
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
  SetTexture [_FrontTex] { combine texture +- primary, texture alpha * primary alpha }
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_BackTex] { combine texture +- primary, texture alpha * primary alpha }
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_LeftTex] { combine texture +- primary, texture alpha * primary alpha }
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_RightTex] { combine texture +- primary, texture alpha * primary alpha }
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_UpTex] { combine texture +- primary, texture alpha * primary alpha }
 }
 Pass {
  Tags { "QUEUE"="Background" "RenderType"="Background" }
  Color [_Tint]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  SetTexture [_DownTex] { combine texture +- primary, texture alpha * primary alpha }
 }
}
}