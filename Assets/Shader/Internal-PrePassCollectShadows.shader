//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-PrePassCollectShadows" {
Properties {
 _ShadowMapTexture ("", any) = "" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[1].xyz, vertex.normal;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_normal0 v2
mov oT1.xyz, v2
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_normal0 v2
mov oT1.xyz, v2
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 6 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[1].xyz, vertex.normal;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_normal0 v2
mov oT1.xyz, v2
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 6 ALU
dcl_position0 v0
dcl_texcoord0 v1
dcl_normal0 v2
mov oT1.xyz, v2
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
Keywords { "SHADOWS_NONATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [_LightSplitsNear]
Vector 22 [_LightSplitsFar]
Vector 23 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
# 39 ALU, 2 TEX
PARAM c[25] = { program.local[0..23],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.x, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0, c[20], c[20].y;
RCP R3.w, R0.x;
MUL R0.xyz, R3.w, fragment.texcoord[1];
SLT R2, R0.z, c[22];
SGE R1, R0.z, c[21];
MUL R1, R1, R2;
MOV R0.w, c[24].x;
DP4 R2.w, R0, c[3];
DP4 R2.z, R0, c[2];
DP4 R2.x, R0, c[0];
DP4 R2.y, R0, c[1];
DP4 R0.z, R2, c[10];
DP4 R0.x, R2, c[8];
DP4 R0.y, R2, c[9];
MUL R3.xyz, R1.y, R0;
DP4 R0.z, R2, c[6];
DP4 R0.y, R2, c[5];
DP4 R0.x, R2, c[4];
MAD R3.xyz, R1.x, R0, R3;
DP4 R1.x, R2, c[16];
DP4 R0.z, R2, c[14];
DP4 R0.y, R2, c[13];
DP4 R0.x, R2, c[12];
MAD R0.xyz, R1.z, R0, R3;
DP4 R1.z, R2, c[18];
DP4 R1.y, R2, c[17];
MAD R0.xyz, R1, R1.w, R0;
MOV result.color.y, c[24].x;
TEX R0.x, R0, texture[1], 2D;
ADD R1.x, R0, -R0.z;
ADD R0.y, -R3.w, c[24].x;
MUL R0.zw, R0.y, c[24].xyxy;
MOV R0.x, c[24];
FRC R0.zw, R0;
CMP result.color.x, R1, c[23], R0;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[24].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NONATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [_LightSplitsNear]
Vector 22 [_LightSplitsFar]
Vector 23 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 43 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c24, 1.00000000, 0.00000000, 255.00000000, 0.00392157
dcl t0.xy
dcl t1.xyz
texld r0, t0, s0
mad r0.x, r0, c20, c20.y
rcp r0.x, r0.x
mul r1.xyz, r0.x, t1
add r2, r1.z, -c21
add r3, r1.z, -c22
cmp r3, r3, c24.y, c24.x
cmp r2, r2, c24.x, c24.y
mul r2, r2, r3
mov r1.w, c24.x
dp4 r3.w, r1, c3
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
dp4 r1.z, r3, c10
dp4 r1.x, r3, c8
dp4 r1.y, r3, c9
mul r4.xyz, r2.y, r1
dp4 r1.z, r3, c6
dp4 r1.y, r3, c5
dp4 r1.x, r3, c4
mad r4.xyz, r2.x, r1, r4
add r0.x, -r0, c24
dp4 r1.z, r3, c14
dp4 r1.y, r3, c13
dp4 r1.x, r3, c12
mad r1.xyz, r2.z, r1, r4
dp4 r2.z, r3, c18
dp4 r2.y, r3, c17
dp4 r2.x, r3, c16
mad r2.xyz, r2, r2.w, r1
mov r0.y, c24.x
texld r1, r2, s1
add r1.x, r1, -r2.z
mov r2.y, c24.z
mov r2.x, c24
mul r2.xy, r0.x, r2
frc r2.xy, r2
mov r0.x, c23
cmp r0.x, r1, c24, r0
mov r1.y, r2
mad r1.x, -r2.y, c24.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov_pp oC0, r0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [_LightSplitsNear]
Vector 22 [_LightSplitsFar]
Vector 23 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 42 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c24, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xy
dcl t1.xyz
texld r0, t0, s0
mad r0.x, r0, c20, c20.y
rcp r0.x, r0.x
mul r1.xyz, r0.x, t1
add r2, r1.z, -c21
add r3, r1.z, -c22
cmp r3, r3, c24.x, c24.y
cmp r2, r2, c24.y, c24.x
mul r2, r2, r3
mov r1.w, c24.y
dp4 r3.w, r1, c3
dp4 r3.z, r1, c2
dp4 r3.x, r1, c0
dp4 r3.y, r1, c1
dp4 r1.z, r3, c10
dp4 r1.x, r3, c8
dp4 r1.y, r3, c9
mul r4.xyz, r2.y, r1
dp4 r1.z, r3, c6
dp4 r1.y, r3, c5
dp4 r1.x, r3, c4
mad r4.xyz, r2.x, r1, r4
dp4 r2.y, r3, c17
dp4 r2.x, r3, c16
dp4 r1.z, r3, c14
dp4 r1.y, r3, c13
dp4 r1.x, r3, c12
mad r1.xyz, r2.z, r1, r4
dp4 r2.z, r3, c18
mad r1.xyz, r2, r2.w, r1
add r2.x, -r0, c24.y
mov r1.w, c24.y
mov r0.x, c23
mul r2.xy, r2.x, c24.yzxw
frc r2.xy, r2
add r0.x, c24.y, -r0
mov r0.y, c24
texldp r1, r1, s1
mad r0.x, r1, r0, c23
mov r1.y, r2
mad r1.x, -r2.y, c24.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [unity_ShadowSplitSpheres0]
Vector 22 [unity_ShadowSplitSpheres1]
Vector 23 [unity_ShadowSplitSpheres2]
Vector 24 [unity_ShadowSplitSpheres3]
Vector 25 [unity_ShadowSplitSqRadii]
Vector 26 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"!!ARBfp1.0
# 46 ALU, 2 TEX
PARAM c[28] = { program.local[0..26],
		{ 1, 255, 0.0039215689 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.x, fragment.texcoord[0], texture[0], 2D;
MAD R0.x, R0, c[20], c[20].y;
RCP R3.w, R0.x;
MUL R1.xyz, R3.w, fragment.texcoord[1];
MOV R1.w, c[27].x;
DP4 R2.z, R1, c[2];
DP4 R2.x, R1, c[0];
DP4 R2.y, R1, c[1];
DP4 R2.w, R1, c[3];
ADD R0.xyz, R2, -c[21];
ADD R4.xyz, R2, -c[24];
DP3 R0.x, R0, R0;
ADD R3.xyz, R2, -c[22];
DP3 R0.y, R3, R3;
ADD R3.xyz, R2, -c[23];
DP3 R0.w, R4, R4;
DP3 R0.z, R3, R3;
SLT R0, R0, c[25];
ADD_SAT R4.xyz, R0.yzww, -R0;
DP4 R1.z, R2, c[10];
DP4 R1.x, R2, c[8];
DP4 R1.y, R2, c[9];
MUL R3.xyz, R4.x, R1;
DP4 R1.z, R2, c[6];
DP4 R1.y, R2, c[5];
DP4 R1.x, R2, c[4];
MAD R1.xyz, R0.x, R1, R3;
DP4 R0.z, R2, c[14];
DP4 R0.y, R2, c[13];
DP4 R0.x, R2, c[12];
MAD R0.xyz, R4.y, R0, R1;
DP4 R1.x, R2, c[16];
DP4 R1.z, R2, c[18];
DP4 R1.y, R2, c[17];
MAD R0.xyz, R1, R4.z, R0;
MOV result.color.y, c[27].x;
TEX R0.x, R0, texture[1], 2D;
ADD R1.x, R0, -R0.z;
ADD R0.y, -R3.w, c[27].x;
MUL R0.zw, R0.y, c[27].xyxy;
MOV R0.x, c[27];
FRC R0.zw, R0;
CMP result.color.x, R1, c[26], R0;
MOV R0.y, R0.w;
MAD R0.x, -R0.w, c[27].z, R0.z;
MOV result.color.zw, R0.xyxy;
END
# 46 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [unity_ShadowSplitSpheres0]
Vector 22 [unity_ShadowSplitSpheres1]
Vector 23 [unity_ShadowSplitSpheres2]
Vector 24 [unity_ShadowSplitSpheres3]
Vector 25 [unity_ShadowSplitSqRadii]
Vector 26 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 50 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c27, 1.00000000, 255.00000000, 0.00392157, 0.00000000
dcl t0.xy
dcl t1.xyz
texld r0, t0, s0
mad r0.x, r0, c20, c20.y
rcp r0.x, r0.x
mul r2.xyz, r0.x, t1
mov r2.w, c27.x
dp4 r3.z, r2, c2
dp4 r3.x, r2, c0
dp4 r3.y, r2, c1
dp4 r3.w, r2, c3
add r1.xyz, r3, -c21
add r5.xyz, r3, -c24
dp3 r1.x, r1, r1
add r4.xyz, r3, -c22
dp3 r1.y, r4, r4
add r4.xyz, r3, -c23
dp3 r1.z, r4, r4
dp3 r1.w, r5, r5
add r1, r1, -c25
cmp r1, r1, c27.w, c27.x
mov r4.x, r1.y
mov r4.y, r1.z
mov r4.z, r1.w
add_sat r5.xyz, r4, -r1
dp4 r2.z, r3, c10
dp4 r2.x, r3, c8
dp4 r2.y, r3, c9
mul r4.xyz, r5.x, r2
dp4 r2.z, r3, c6
dp4 r2.y, r3, c5
dp4 r2.x, r3, c4
mad r2.xyz, r1.x, r2, r4
dp4 r1.z, r3, c14
dp4 r1.y, r3, c13
dp4 r1.x, r3, c12
mad r1.xyz, r5.y, r1, r2
dp4 r2.z, r3, c18
dp4 r2.y, r3, c17
dp4 r2.x, r3, c16
mad r1.xyz, r2, r5.z, r1
mov r0.y, c27.x
texld r2, r1, s1
add r1.x, -r0, c27
add r0.x, r2, -r1.z
mul r2.xy, r1.x, c27
mov r1.x, c26
frc r2.xy, r2
cmp r0.x, r0, c27, r1
mov r1.y, r2
mad r1.x, -r2.y, c27.z, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov_pp oC0, r0
"
}
SubProgram "d3d9 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [unity_World2Shadow0]
Matrix 8 [unity_World2Shadow1]
Matrix 12 [unity_World2Shadow2]
Matrix 16 [unity_World2Shadow3]
Vector 20 [_ZBufferParams]
Vector 21 [unity_ShadowSplitSpheres0]
Vector 22 [unity_ShadowSplitSpheres1]
Vector 23 [unity_ShadowSplitSpheres2]
Vector 24 [unity_ShadowSplitSpheres3]
Vector 25 [unity_ShadowSplitSqRadii]
Vector 26 [_LightShadowData]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_ShadowMapTexture] 2D
"ps_2_0
; 51 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c27, 0.00000000, 1.00000000, 255.00000000, 0.00392157
dcl t0.xy
dcl t1.xyz
texld r0, t0, s0
mad r0.x, r0, c20, c20.y
rcp r0.x, r0.x
mul r2.xyz, r0.x, t1
mov r2.w, c27.y
dp4 r3.z, r2, c2
dp4 r3.x, r2, c0
dp4 r3.y, r2, c1
dp4 r3.w, r2, c3
add r1.xyz, r3, -c21
add r5.xyz, r3, -c24
dp3 r1.x, r1, r1
add r4.xyz, r3, -c22
dp3 r1.y, r4, r4
add r4.xyz, r3, -c23
dp3 r1.z, r4, r4
dp3 r1.w, r5, r5
add r1, r1, -c25
cmp r1, r1, c27.x, c27.y
mov r4.z, r1.w
mov r4.x, r1.y
mov r4.y, r1.z
add_sat r5.xyz, r4, -r1
dp4 r2.z, r3, c10
dp4 r2.x, r3, c8
dp4 r2.y, r3, c9
mul r4.xyz, r5.x, r2
dp4 r2.z, r3, c6
dp4 r2.y, r3, c5
dp4 r2.x, r3, c4
mad r2.xyz, r1.x, r2, r4
dp4 r1.z, r3, c14
dp4 r1.y, r3, c13
dp4 r1.x, r3, c12
mad r1.xyz, r5.y, r1, r2
dp4 r2.y, r3, c17
dp4 r2.x, r3, c16
dp4 r2.z, r3, c18
mad r1.xyz, r2, r5.z, r1
add r2.x, -r0, c27.y
mov r1.w, c27.y
mov r0.x, c26
mul r2.xy, r2.x, c27.yzxw
frc r2.xy, r2
add r0.x, c27.y, -r0
mov r0.y, c27
texldp r1, r1, s1
mad r0.x, r1, r0, c26
mov r1.y, r2
mad r1.x, -r2.y, c27.w, r2
mov r0.w, r1.y
mov r0.z, r1.x
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}