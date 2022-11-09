//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-GUITextureClip" {
Properties {
 _MainTex ("Texture", any) = "white" {}
}
SubShader { 
 Tags { "ForceSupported"="True" }
 Pass {
  Tags { "ForceSupported"="True" }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 9 [_GUIClipTextureMatrix]
Vector 13 [_MainTex_ST]
"!!ARBvp1.0
# 12 ALU
PARAM c[14] = { program.local[0],
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..13] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.color, vertex.color;
DP4 result.texcoord[1].y, R0, c[10];
DP4 result.texcoord[1].x, R0, c[9];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
DP4 result.position.w, vertex.position, c[8];
DP4 result.position.z, vertex.position, c[7];
DP4 result.position.y, vertex.position, c[6];
DP4 result.position.x, vertex.position, c[5];
END
# 12 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_GUIClipTextureMatrix]
Vector 12 [_MainTex_ST]
"vs_2_0
; 12 ALU
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oD0, v1
dp4 oT1.y, r0, c9
dp4 oT1.x, r0, c8
mad oT0.xy, v2, c12, c12.zwzw
dp4 oPos.w, v0, c7
dp4 oPos.z, v0, c6
dp4 oPos.y, v0, c5
dp4 oPos.x, v0, c4
"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_GUIClipTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 2 TEX
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.w, fragment.texcoord[1], texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MUL result.color.w, R0, R1;
MOV result.color.xyz, R0;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_GUIClipTexture] 2D
"ps_2_0
; 4 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
dcl v0
dcl t0.xy
dcl t1.xy
texld r0, t1, s1
texld r1, t0, s0
mul r1, r1, v0
mov_pp r0.xyz, r1
mul_pp r0.w, r1, r0
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 Tags { "ForceSupported"="True" }
 Pass {
  Tags { "ForceSupported"="True" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { combine primary * texture }
  SetTexture [_GUIClipTexture] { combine previous, previous alpha * texture alpha }
 }
}
SubShader { 
 Tags { "ForceSupported"="True" }
 Pass {
  Tags { "ForceSupported"="True" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask A
  SetTexture [_MainTex] { combine primary * texture }
 }
 Pass {
  Tags { "ForceSupported"="True" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend DstAlpha Zero
  ColorMask A
  SetTexture [_GUIClipTexture] { combine texture, texture alpha }
 }
 Pass {
  Tags { "ForceSupported"="True" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend DstAlpha OneMinusDstAlpha
  ColorMask RGB
  SetTexture [_MainTex] { combine primary * texture }
 }
}
}