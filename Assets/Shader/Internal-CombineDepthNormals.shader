//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-CombineDepthNormals" {
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
Vector 5 [_CameraNormalsTexture_ST]
"!!ARBvp1.0
# 5 ALU
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
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
Vector 4 [_CameraNormalsTexture_ST]
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord0 v1
mad oT0.xy, v1, c4, c4.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_WorldToCamera]
Vector 4 [_ZBufferParams]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_CameraNormalsTexture] 2D
"!!ARBfp1.0
# 20 ALU, 2 TEX
PARAM c[8] = { program.local[0..4],
		{ 0.99998462, 1, 255, 0.0039215689 },
		{ 2, 0.28126231, 0, 0.5 },
		{ 0.5, 1 } };
TEMP R0;
TEMP R1;
TEX R1.xyz, fragment.texcoord[0], texture[1], 2D;
TEX R0.x, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1, c[6].x;
ADD R1.xyz, R1, -c[5].y;
DP3 R0.w, R1, c[1];
DP3 R0.z, R1, c[0];
DP3 R0.y, R1, c[2];
MAD R1.x, R0, c[4], c[4].y;
ADD R0.x, -R0.y, c[5].y;
RCP R1.y, R0.x;
RCP R1.x, R1.x;
MUL R0.xy, R1.x, c[5].yzzw;
MUL R1.zw, R0, R1.y;
FRC R0.zw, R0.xyxy;
MAD R0.xy, R1.zwzw, c[6].y, c[6].w;
MOV R1.w, R0;
MAD R1.z, -R0.w, c[5].w, R0;
MOV R0.zw, R1;
ADD R1.x, R1, -c[5];
CMP result.color, R1.x, R0, c[7].xxyy;
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_WorldToCamera]
Vector 4 [_ZBufferParams]
SetTexture 0 [_CameraDepthTexture] 2D
SetTexture 1 [_CameraNormalsTexture] 2D
"ps_2_0
; 22 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c5, -0.99998462, 1.00000000, 255.00000000, 0.00392157
def c6, 2.00000000, -1.00000000, 0.28126231, 0.50000000
def c7, 0.50000000, 1.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
texld r1, t0, s1
mad r2.xyz, r1, c6.x, c6.y
dp3 r1.x, r2, c2
mad r0.x, r0, c4, c4.y
rcp r0.x, r0.x
mul r3.xy, r0.x, c5.yzxw
add r1.x, -r1, c5.y
dp3 r4.y, r2, c1
dp3 r4.x, r2, c0
frc r3.xy, r3
mov r2.y, r3
mad r2.x, -r3.y, c5.w, r3
rcp r1.x, r1.x
mul r1.xy, r4, r1.x
mov r0.w, r2.y
mov r0.z, r2.x
mov r1.zw, r0
mad r1.xy, r1, c6.z, c6.w
add r0.x, r0, c5
mov r2.xy, c7.x
mov r2.zw, c7.y
cmp r0, r0.x, r2, r1
mov_pp oC0, r0
"
}
}
 }
}
Fallback Off
}