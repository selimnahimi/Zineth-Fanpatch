//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Reflective/Bumped Unlit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB), RefStrength (A)", 2D) = "white" {}
 _Cube ("Reflection Cubemap", CUBE) = "" { TexGen CubeReflect }
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 LOD 250
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"!!ARBvp1.0
# 28 ALU
PARAM c[13] = { program.local[0],
		state.matrix.mvp,
		program.local[5..12] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R0.w, c[9];
MUL R3.xyz, R0.w, c[6];
MUL R2.xyz, R0.w, c[5];
MUL R4.xyz, R0.w, c[7];
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD R0.xyz, -R0, c[10];
DP3 result.texcoord[3].y, R2, R1;
DP3 result.texcoord[4].y, R1, R3;
DP3 result.texcoord[5].y, R1, R4;
MOV result.texcoord[2].xyz, -R0;
DP3 result.texcoord[3].z, vertex.normal, R2;
DP3 result.texcoord[3].x, R2, vertex.attrib[14];
DP3 result.texcoord[4].z, vertex.normal, R3;
DP3 result.texcoord[4].x, vertex.attrib[14], R3;
DP3 result.texcoord[5].z, vertex.normal, R4;
DP3 result.texcoord[5].x, vertex.attrib[14], R4;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 28 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_MainTex_ST]
Vector 11 [_BumpMap_ST]
"vs_2_0
; 31 ALU
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c5
mul r3.xyz, c8.w, r0
mov r0.xyz, c6
mul r4.xyz, c8.w, r0
mov r2.xyz, c4
mul r2.xyz, c8.w, r2
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add r0.xyz, -r0, c9
dp3 oT3.y, r2, r1
dp3 oT4.y, r1, r3
dp3 oT5.y, r1, r4
mov oT2.xyz, -r0
dp3 oT3.z, v2, r2
dp3 oT3.x, r2, v1
dp3 oT4.z, v2, r3
dp3 oT4.x, v1, r3
dp3 oT5.z, v2, r4
dp3 oT5.x, v1, r4
mad oT0.xy, v3, c10, c10.zwzw
mad oT1.xy, v3, c11, c11.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 1 [_ReflectColor]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_Cube] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 3 TEX
PARAM c[3] = { state.lightmodel.ambient,
		program.local[1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.z, R0.y, R0.y;
MAD R0.z, -R0.x, R0.x, -R0;
ADD R0.z, R0, c[2].y;
RSQ R0.z, R0.z;
RCP R0.z, R0.z;
DP3 R1.z, fragment.texcoord[5], R0;
DP3 R1.x, R0, fragment.texcoord[3];
DP3 R1.y, R0, fragment.texcoord[4];
DP3 R0.x, R1, fragment.texcoord[2];
MUL R0.xyz, R1, R0.x;
MAD R0.xyz, -R0, c[2].x, fragment.texcoord[2];
TEX R1, R0, texture[2], CUBE;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R1, R1, c[1];
MUL R2, R0, c[0];
MUL R0, R0.w, R1;
MUL R1.xyz, R2, c[2].x;
MOV R1.w, R2;
ADD result.color, R1, R0;
END
# 21 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [glstate_lightmodel_ambient]
Vector 1 [_ReflectColor]
SetTexture 0 [_BumpMap] 2D
SetTexture 1 [_MainTex] 2D
SetTexture 2 [_Cube] CUBE
"ps_2_0
; 20 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0
dcl t0.xy
dcl t1.xy
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
dcl t5.xyz
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul_pp r1.x, r0.y, r0.y
mad_pp r1.x, -r0, r0, -r1
add_pp r1.x, r1, c2.z
rsq_pp r1.x, r1.x
rcp_pp r0.z, r1.x
dp3 r1.z, t5, r0
dp3 r1.x, r0, t3
dp3 r1.y, r0, t4
dp3 r0.x, r1, t2
mul r0.xyz, r1, r0.x
mad r0.xyz, -r0, c2.x, t2
texld r1, r0, s2
texld r0, t0, s1
mul r1, r1, c1
mul r2, r0, c0
mul r0, r0.w, r1
mul_pp r1.xyz, r2, c2.x
mov_pp r1.w, r2
add_pp r0, r1, r0
mov_pp oC0, r0
"
}
}
 }
}
SubShader { 
 LOD 250
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "RenderType"="Opaque" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
  }
  SetTexture [_Cube] { ConstantColor [_ReflectColor] combine texture * constant }
 }
}
Fallback "VertexLit"
}