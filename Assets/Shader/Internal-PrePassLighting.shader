//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Internal-PrePassLighting" {
Properties {
 _LightTexture0 ("", any) = "" {}
 _LightTextureB0 ("", 2D) = "" {}
 _ShadowMapTexture ("", any) = "" {}
}
SubShader { 
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend DstColor Zero
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 57 ALU, 3 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R4.xyz, R1, R0.z;
MOV R4.w, c[11].x;
DP4 R1.z, R4, c[2];
DP4 R1.x, R4, c[0];
DP4 R1.y, R4, c[1];
ADD R2.xyz, R1, -c[7];
ADD R3.xyz, R1, -c[5];
DP3 R1.w, R2, R2;
RSQ R0.z, R1.w;
MUL R2.xyz, R0.z, R2;
TEX R0, R0, texture[0], 2D;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
MAD R3.xyz, -R2.w, R3, -R2;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R3.w, R0, R0;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
RSQ R3.w, R3.w;
MUL R0.xyz, R3.w, R0;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R3, R0;
DP3 R0.x, -R2, R0;
MUL R3.x, R1.w, c[7].w;
MUL R1.w, R0, c[11];
MAX R2.w, R2, c[11].z;
TEX R0.w, R3.x, texture[2], 2D;
POW R1.w, R2.w, R1.w;
MOV_SAT R2.w, R0;
MAX R0.x, R0, c[11].z;
MUL R1.w, R1, R2;
ADD R1.xyz, -R1, c[10];
DP3 R2.w, R1, R1;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RSQ R2.w, R2.w;
RCP R1.y, R2.w;
MUL R1.w, R1, R1.x;
ADD R1.x, -R4.z, R1.y;
MAD R0.y, R1.x, c[10].w, R4.z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[9].z, c[9].w;
ADD_SAT R0.y, -R0, c[11].x;
MUL R1.xyz, R0.x, c[8];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 57 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"ps_3_0
; 57 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c11.x
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r1.xyz, r2, -c5
dp3 r1.w, r1, r1
add r3.xyz, r2, -c7
dp3 r2.w, r3, r3
rsq r0.z, r2.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c11.y, c11.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c12.x
max_pp r0.x, r0, c11.w
pow_pp r1, r0.x, r0.y
mov_pp r0.z, r1.x
mul r0.x, r2.w, c7.w
texld r0.x, r0.x, s2
mov_sat r0.y, r0.x
mul r0.y, r0.z, r0
add r1.xyz, -r2, c10
dp3 r0.z, r1, r1
rsq r0.w, r0.z
mov_pp r1.xyz, c8
dp3_pp r0.z, c12.yzww, r1
rcp r1.x, r0.w
mul r0.w, r0.y, r0.z
add r0.z, -r3.w, r1.x
dp3_pp r0.y, -r3, r4
max_pp r0.y, r0, c11.w
mad r0.z, r0, c10.w, r3.w
mad r0.z, r0, c9, c9.w
add_sat r1.x, -r0.z, c11
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, c8
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"3.0-!!ARBfp1.0
# 48 ALU, 2 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R3.xyz, R1, R0.z;
MOV R3.w, c[11].x;
TEX R0, R0, texture[0], 2D;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
DP4 R1.z, R3, c[2];
DP4 R1.x, R3, c[0];
DP4 R1.y, R3, c[1];
ADD R2.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[10];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MAD R2.xyz, -R1.w, R2, -c[7];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R1.w, R2, R0;
DP3 R0.x, R0, -c[7];
MAX R1.w, R1, c[11].z;
MUL R0.w, R0, c[11];
DP3 R1.x, R1, R1;
POW R0.w, R1.w, R0.w;
RSQ R1.w, R1.x;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RCP R1.w, R1.w;
MUL R0.w, R0, R1.x;
ADD R1.y, -R3.z, R1.w;
MAD R1.x, R1.y, c[10].w, R3.z;
MAD R0.y, R1.x, c[9].z, c[9].w;
ADD_SAT R1.x, -R0.y, c[11];
MAX R0.x, R0, c[11].z;
MUL R0.xyz, R0.x, c[8];
MUL R0, R0, R1.x;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 48 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"ps_3_0
; 49 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyz, r1, r0.z
mov r3.w, c11.x
texld r0, r0, s0
mad_pp r0.xyz, r0, c11.y, c11.z
dp3_pp r2.w, r0, r0
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, r0
dp4 r1.z, r3, c2
dp4 r1.x, r3, c0
dp4 r1.y, r3, c1
add r2.xyz, r1, -c5
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r2.xyz, r1.w, r2
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
mul_pp r3.x, r0.w, c12
max_pp r0.w, r1, c11
pow_pp r2, r0.w, r3.x
add r1.xyz, -r1, c10
dp3 r0.w, r1, r1
mov_pp r1.w, r2.x
rsq r0.w, r0.w
mov_pp r1.xyz, c8
rcp r2.x, r0.w
dp3_pp r0.w, c12.yzww, r1
add r1.x, -r3.z, r2
mad r1.x, r1, c10.w, r3.z
mad r0.y, r1.x, c9.z, c9.w
add_sat r1.x, -r0.y, c11
max_pp r0.x, r0, c11.w
mul r0.w, r1, r0
mul r0.xyz, r0.x, c8
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 70 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[15].x;
DP4 R3.x, R2.xywz, c[0];
DP4 R3.y, R2.xywz, c[1];
DP4 R0.w, R2.xywz, c[2];
MOV R0.z, R0.w;
MOV R0.x, R3;
MOV R0.y, R3;
ADD R2.xyz, -R0, c[11];
ADD R4.xyz, R0, -c[9];
DP3 R4.w, R2, R2;
RSQ R1.z, R4.w;
MUL R2.xyz, R1.z, R2;
TEX R1, R1, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, R2;
MAD R1.xyz, R1, c[15].y, -c[15].x;
DP3 R3.w, R1, R1;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R4.x, R4, R1;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
DP4 R5.y, R3, c[7];
MAX R5.x, R4, c[15].z;
MUL R1.w, R1, c[15];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
MOV R4.z, R5.y;
TXP R0.w, R4.xyzz, texture[2], 2D;
SLT R3.x, R5.y, c[15].z;
MUL R3.x, R0.w, R3;
MUL R3.y, R4.w, c[11].w;
TEX R0.w, R3.y, texture[3], 2D;
MUL R0.w, R3.x, R0;
MOV_SAT R3.x, R0.w;
POW R1.w, R5.x, R1.w;
MUL R1.w, R1, R3.x;
ADD R0.xyz, -R0, c[14];
DP3 R3.x, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, R2, R1;
RSQ R3.x, R3.x;
RCP R0.y, R3.x;
ADD R0.y, -R2.w, R0;
MAD R0.y, R0, c[14].w, R2.w;
MAX R0.x, R0, c[15].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[13].z, c[13].w;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 70 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 69 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.x, r3.xywz, c0
dp4 r2.z, r3.xywz, c2
dp4 r2.y, r3.xywz, c1
mov r1.x, r2
mov r1.z, r2
mov r1.y, r2
add r4.xyz, r1, -c9
add r3.xyz, -r1, c11
dp3 r2.w, r4, r4
dp3 r1.w, r3, r3
rsq r0.z, r1.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r5.xyz, r0, c15.y, c15.z
rsq r2.w, r2.w
mad r0.xyz, -r2.w, r4, r3
dp3_pp r4.x, r5, r5
dp3 r2.w, r0, r0
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mov r2.w, c15.x
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
dp4 r4.w, r2, c7
max_pp r0.y, r0, c15.w
pow_pp r5, r0.y, r0.x
dp4 r0.z, r2, c6
dp4 r0.x, r2, c4
dp4 r0.y, r2, c5
mov r0.w, r4
texldp r0.w, r0, s2
mul r0.x, r1.w, c11.w
cmp r0.y, r4.w, c15.w, c15.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.w, r0.y, r0.x
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
mad r0.y, r0, c14.w, r3.w
mad r0.y, r0, c13.z, c13.w
mov_sat r1.w, r0
mov_pp r2.x, r5
mul r1.x, r2, r1.w
mul r1.w, r1.x, r0.x
dp3_pp r0.x, r3, r4
max_pp r0.x, r0, c15.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 68 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyw, R0.xyzz, R0.w;
MOV R4.z, c[15].x;
DP4 R3.x, R4.xywz, c[0];
DP4 R0.w, R4.xywz, c[2];
DP4 R1.w, R4.xywz, c[1];
MOV R0.z, R0.w;
MOV R0.y, R1.w;
MOV R0.x, R3;
ADD R1.xyz, R0, -c[11];
DP3 R3.y, R1, R1;
ADD R4.xyz, R0, -c[9];
RSQ R2.z, R3.y;
MUL R1.xyz, R2.z, R1;
TEX R2, R2, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, -R1;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R3.w, R2, R2;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R2.xyz, R3.w, R2;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R3.z, R4, R2;
MAX R5.x, R3.z, c[15].z;
MUL R5.y, R3, c[11].w;
MOV R3.y, R1.w;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
TEX R1.w, R5.y, texture[2], 2D;
MUL R2.w, R2, c[15];
ADD R0.xyz, -R0, c[14];
DP4 R4.z, R3, c[6];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
TEX R0.w, R4, texture[3], CUBE;
MUL R0.w, R1, R0;
POW R1.w, R5.x, R2.w;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.w, R0;
MAD R0.y, R0, c[14].w, R4.w;
MAX R0.x, R0, c[15].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[13].z, c[13].w;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 68 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 67 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r5.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
mov r2.z, r2.w
mov r2.x, r5
mov r2.y, r4.w
add r1.xyz, r2, -c9
dp3 r1.w, r1, r1
add r3.xyz, r2, -c11
dp3 r5.y, r3, r3
rsq r0.z, r5.y
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c15.y, c15.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
max_pp r0.y, r0, c15.w
pow_pp r1, r0.y, r0.x
mul r0.x, r5.y, c11.w
mov_pp r5.y, r4.w
mov_pp r5.w, c15.x
mov_pp r5.z, r2.w
mov_pp r1.y, r1.x
texld r0.x, r0.x, s2
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r0.w, r6, s3
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c14.w, r3.w
max_pp r0.x, r0, c15.w
mul r0.x, r0.w, r0
mad r0.y, r0, c13.z, c13.w
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 58 ALU, 3 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[15].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R1.z, R0;
MOV R1.x, R0;
MOV R1.y, R0;
ADD R3.xyz, R1, -c[9];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R3, -c[11];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R3;
MUL R2.xyz, R1.w, R2;
DP3 R0.w, R3, R2;
MAX R1.w, R0, c[15].z;
MOV R0.w, c[15].x;
DP4 R3.y, R0, c[5];
DP4 R3.x, R0, c[4];
MUL R0.x, R2.w, c[15].w;
POW R1.w, R1.w, R0.x;
ADD R0.xyz, -R1, c[14];
DP3 R1.y, R0, R0;
TEX R0.w, R3, texture[2], 2D;
MOV R0.xyz, c[16];
MOV_SAT R2.w, R0;
DP3 R0.x, R0, c[12];
MUL R1.x, R1.w, R2.w;
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, R2, -c[11];
MAD R0.y, R0, c[14].w, R3.w;
MAX R0.x, R0, c[15].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[13].z, c[13].w;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 58 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 60 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r3.x, r2.xywz, c0
dp4 r1.w, r2.xywz, c2
dp4 r4.x, r2.xywz, c1
texld r0, r0, s0
mov r1.z, r1.w
mov r1.x, r3
mov r1.y, r4.x
add r2.xyz, r1, -c9
dp3 r3.y, r2, r2
rsq r4.y, r3.y
mad_pp r3.yzw, r0.xxyz, c15.y, c15.z
mad r0.xyz, -r4.y, r2, -c11
dp3_pp r2.x, r3.yzww, r3.yzww
dp3 r2.y, r0, r0
rsq r4.y, r2.y
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r3.yzww
mul r0.xyz, r4.y, r0
dp3_pp r0.x, r0, r2
mul_pp r3.y, r0.w, c16.x
max_pp r3.z, r0.x, c15.w
pow_pp r0, r3.z, r3.y
mov_pp r3.y, r4.x
mov_pp r3.z, r1.w
mov_pp r3.w, c15.x
dp4 r4.x, r3, c4
dp4 r4.y, r3, c5
texld r0.w, r4, s2
mov_pp r3.x, r0
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_sat r1.w, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.x, r3, r1.w
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r2.w, r0
dp3_pp r0.x, r2, -c11
mad r0.y, r0, c14.w, r2.w
max_pp r0.x, r0, c15.w
mul r0.x, r0.w, r0
mad r0.y, r0, c13.z, c13.w
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 83 ALU, 5 TEX
PARAM c[22] = { program.local[0..19],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.zw, fragment.texcoord[0].xyxy, R0.x;
TEX R0.x, R1.zwzw, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[20].x;
DP4 R1.x, R5, c[0];
DP4 R1.y, R5, c[1];
DP4 R0.w, R5, c[2];
MOV R0.z, R0.w;
MOV R0.x, R1;
MOV R0.y, R1;
ADD R2.xyz, -R0, c[15];
ADD R4.xyz, R0, -c[13];
ADD R0.xyz, -R0, c[19];
DP3 R0.x, R0, R0;
DP3 R2.w, R2, R2;
RSQ R3.x, R2.w;
MUL R2.xyz, R3.x, R2;
TEX R3, R1.zwzw, texture[0], 2D;
DP3 R4.w, R4, R4;
RSQ R1.z, R4.w;
MAD R4.xyz, -R1.z, R4, R2;
MAD R3.xyz, R3, c[20].y, -c[20].x;
DP3 R1.w, R3, R3;
DP3 R1.z, R4, R4;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
RSQ R1.z, R1.z;
MUL R4.xyz, R1.z, R4;
DP3 R4.x, R4, R3;
MOV R1.z, R0.w;
MOV R1.w, c[20].x;
DP4 R0.w, R1, c[7];
MAX R4.w, R4.x, c[20].z;
DP4 R4.x, R1, c[4];
DP4 R0.y, R1, c[9];
DP4 R4.y, R1, c[5];
SLT R5.x, R0.w, c[20].z;
MOV R4.z, R0.w;
TXP R0.w, R4.xyzz, texture[2], 2D;
MUL R4.x, R0.w, R5;
MUL R0.w, R2, c[15];
DP4 R2.w, R1, c[11];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R4.x, R0;
RSQ R0.x, R0.x;
RCP R4.x, R0.x;
DP4 R0.x, R1, c[8];
MOV R0.z, R2.w;
TXP R0.x, R0.xyzz, texture[4], 2D;
DP4 R0.y, R1, c[10];
RCP R0.z, R2.w;
MAD R0.y, -R0, R0.z, R0.x;
ADD R4.x, -R5.z, R4;
MAD R1.x, R4, c[19].w, R5.z;
MOV R0.x, c[20];
MAD_SAT R0.z, R1.x, c[17], c[17].w;
CMP R0.x, R0.y, c[17], R0;
ADD_SAT R0.y, R0.x, R0.z;
MUL R1.y, R0.w, R0;
MUL R0.x, R3.w, c[20].w;
POW R0.w, R4.w, R0.x;
MOV R0.xyz, c[21];
DP3 R0.x, R0, c[16];
MOV_SAT R1.z, R1.y;
MUL R0.w, R0, R1.z;
MUL R0.w, R0, R0.x;
DP3 R0.y, R2, R3;
MAX R0.x, R0.y, c[20].z;
MAD R0.y, R1.x, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[20];
MUL R0.x, R1.y, R0;
MUL R0.xyz, R0.x, c[16];
MUL R0, R0, R1.x;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 83 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 84 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c21, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c20.x
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.y, c20.z
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.w
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c21.x
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c20.x
mov r1.z, r5.x
dp4 r4.z, r1, c10
dp4 r4.w, r1, c11
rsq r4.y, r0.x
dp4 r0.y, r1, c9
mov r0.z, r4
dp4 r0.x, r1, c8
mov r0.w, r4
texldp r0.x, r0, s4
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
rcp r0.y, r4.w
mad r0.x, -r4.z, r0.y, r0
dp4 r4.z, r1, c7
mov r0.y, c17.x
cmp r0.x, r0, c20, r0.y
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c20.w, c20.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c21.yzww, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
mul r0.w, r0, r0.x
dp3_pp r0.y, r2, r3
max_pp r0.x, r0.y, c20.w
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c20
mul r0.xyz, r0.x, c16
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 81 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c21, 0.00000000, 1.00000000, 0, 0
def c22, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c21.y
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.x, c20.y
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.z
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c20
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c21.y
mov r1.z, r5.x
rsq r4.y, r0.x
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
texldp r0.x, r0, s4
dp4 r4.z, r1, c7
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
mov r0.y, c17.x
add r0.y, c21, -r0
mad r0.x, r0, r0.y, c17
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c21.x, c21
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c22, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
mul r0.w, r0, r0.x
dp3_pp r0.y, r2, r3
max_pp r0.x, r0.y, c20.z
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c21.y
mul r0.xyz, r0.x, c16
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 53 ALU, 3 TEX
PARAM c[14] = { program.local[0..11],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R3.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R3, texture[1], 2D;
MAD R0.w, R0.x, c[6].x, c[6].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MOV R2.z, c[12].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
DP4 R1.z, R2.xywz, c[2];
DP4 R1.x, R2.xywz, c[0];
DP4 R1.y, R2.xywz, c[1];
ADD R0.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[11];
DP3 R1.x, R1, R1;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MAD R2.xyz, -R0.w, R0, -c[7];
TEX R0, R3, texture[0], 2D;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RSQ R1.y, R1.x;
RCP R1.y, R1.y;
ADD R1.z, -R2.w, R1.y;
MUL R1.y, R0.w, c[12].w;
MAD R0.w, R1.z, c[11], R2;
MUL R2.xyz, R1.w, R2;
MAD R0.xyz, R0, c[12].y, -c[12].x;
DP3 R1.w, R0, R0;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R1.x, R2, R0;
DP3 R0.x, R0, -c[7];
MAX R1.x, R1, c[12].z;
POW R1.w, R1.x, R1.y;
MAD R0.y, R0.w, c[10].z, c[10].w;
MAD_SAT R1.y, R0.w, c[9].z, c[9].w;
TEX R1.x, R3, texture[2], 2D;
ADD_SAT R2.x, R1, R1.y;
MOV R1.xyz, c[13];
MAX R0.x, R0, c[12].z;
DP3 R1.x, R1, c[8];
MUL R1.w, R1, R2.x;
MUL R1.w, R1, R1.x;
MUL R0.x, R2, R0;
ADD_SAT R0.y, -R0, c[12].x;
MUL R1.xyz, R0.x, c[8];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 53 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 53 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c13, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c6.x, c6.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r2.z, c12.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r1.z, r2.xywz, c2
dp4 r1.x, r2.xywz, c0
dp4 r1.y, r2.xywz, c1
add r2.xyz, r1, -c5
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
add r1.xyz, -r1, c11
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c12.y, c12.z
rsq r3.z, r1.w
dp3_pp r3.w, r0, r0
rsq_pp r1.w, r3.w
mul_pp r0.xyz, r1.w, r0
mul r2.xyz, r3.z, r2
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
rsq r1.x, r1.x
max_pp r2.x, r1.w, c12.w
mul_pp r0.w, r0, c13.x
rcp r2.y, r1.x
pow_pp r1, r2.x, r0.w
mov_pp r1.w, r1.x
add r0.w, -r2, r2.y
mad r0.w, r0, c11, r2
mad r0.y, r0.w, c10.z, c10.w
mad_sat r1.y, r0.w, c9.z, c9.w
texld r1.x, r3, s2
add_sat r2.x, r1, r1.y
mov_pp r1.xyz, c8
max_pp r0.x, r0, c12.w
dp3_pp r1.x, c13.yzww, r1
mul r1.w, r1, r2.x
mul r1.w, r1, r1.x
mul r0.x, r2, r0
add_sat r0.y, -r0, c12.x
mul r1.xyz, r0.x, c8
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 62 ALU, 4 TEX
PARAM c[18] = { program.local[0..15],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[16].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R4.z, R0;
MOV R4.x, R0;
MOV R4.y, R0;
ADD R1.xyz, R4, -c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R1, -c[11];
TEX R1, R2, texture[0], 2D;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
ADD R4.xyz, -R4, c[15];
DP3 R2.z, R4, R4;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
MUL R3.xyz, R0.w, R3;
MAD R1.xyz, R1, c[16].y, -c[16].x;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R3, R1;
ADD R2.z, -R3.w, R2;
MAX R3.y, R0.w, c[16].z;
MOV R0.w, c[16].x;
MAD R3.x, R2.z, c[15].w, R3.w;
DP4 R2.z, R0, c[4];
DP4 R2.w, R0, c[5];
TEX R0.x, R2, texture[2], 2D;
MAD_SAT R0.y, R3.x, c[13].z, c[13].w;
ADD_SAT R0.y, R0.x, R0;
MUL R0.x, R1.w, c[16].w;
TEX R0.w, R2.zwzw, texture[3], 2D;
MUL R1.w, R0.y, R0;
POW R0.w, R3.y, R0.x;
MOV R0.xyz, c[17];
DP3 R0.x, R0, c[12];
MOV_SAT R2.x, R1.w;
MUL R0.w, R0, R2.x;
DP3 R0.y, R1, -c[11];
MUL R0.w, R0, R0.x;
MAX R0.x, R0.y, c[16].z;
MAD R0.y, R3.x, c[14].z, c[14].w;
ADD_SAT R1.x, -R0.y, c[16];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[12];
MUL R0, R0, R1.x;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 62 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 62 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c16, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c17, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c10.x, c10.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
mov r2.z, c16.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r4.x, r2.xywz, c0
dp4 r3.z, r2.xywz, c2
dp4 r3.w, r2.xywz, c1
mov r1.z, r3
mov r1.x, r4
mov r1.y, r3.w
add r2.xyz, r1, -c9
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c11
dp3 r1.w, r2, r2
rsq r4.y, r1.w
mul r2.xyz, r4.y, r2
add r1.xyz, -r1, c15
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c16.y, c16.z
dp3_pp r4.z, r0, r0
rsq_pp r1.w, r4.z
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c11
rsq r1.x, r1.x
max_pp r2.x, r1.w, c16.w
rcp r2.y, r1.x
mul_pp r0.w, r0, c17.x
pow_pp r1, r2.x, r0.w
add r0.w, -r2, r2.y
mad r1.y, r0.w, c15.w, r2.w
mov_pp r4.y, r3.w
mov_pp r4.w, c16.x
mov_pp r4.z, r3
dp4 r2.x, r4, c4
dp4 r2.y, r4, c5
texld r0.w, r2, s3
texld r2.x, r3, s2
mad_sat r1.z, r1.y, c13, c13.w
add_sat r1.z, r2.x, r1
mul r1.z, r1, r0.w
mov_sat r0.w, r1.z
max_pp r0.x, r0, c16.w
mul r0.w, r1.x, r0
mov_pp r2.xyz, c12
dp3_pp r1.x, c17.yzww, r2
mul r0.w, r0, r1.x
mad r0.y, r1, c14.z, c14.w
add_sat r1.x, -r0.y, c16
mul r0.x, r1.z, r0
mul r0.xyz, r0.x, c12
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 65 ALU, 4 TEX
PARAM c[16] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.w, R1, R1;
RSQ R4.w, R4.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[13].x;
MUL R1.xyz, R4.w, R1;
DP4 R0.z, R5, c[2];
DP4 R0.x, R5, c[0];
DP4 R0.y, R5, c[1];
ADD R4.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R4, R4;
RSQ R2.w, R0.w;
MUL R2.xyz, R2.w, R4;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
DP3 R3.x, R3, R1;
MAX R4.w, R3.x, c[13].z;
TEX R3, R4, texture[3], CUBE;
RCP R2.w, R2.w;
MUL R0.w, R0, c[8];
MUL R1.w, R1, c[13];
MUL R2.w, R2, c[6];
DP4 R3.x, R3, c[15];
MAD R3.x, -R2.w, c[14], R3;
MOV R2.w, c[13].x;
CMP R2.w, R3.x, c[10].x, R2;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R2;
MOV_SAT R2.w, R0;
POW R1.w, R4.w, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[12];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[14].yzww;
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.z, R0;
MAD R0.y, R0, c[12].w, R5.z;
MAX R0.x, R0, c[13].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[11].z, c[11].w;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 65 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 64 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.97000003, 0, 0
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
texld r1, r1, s0
mad r0.w, r0.x, c7.x, c7.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r3.z, c13.x
mad_pp r5.xyz, r1, c13.y, c13.z
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r4.xyz, r2, -c5
dp3 r0.w, r4, r4
add r0.xyz, r2, -c8
dp3 r2.w, r0, r0
rsq r4.w, r2.w
mul r3.xyz, r4.w, r0
rsq r0.w, r0.w
mad r1.xyz, -r0.w, r4, -r3
dp3_pp r4.x, r5, r5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
mul r1.xyz, r0.w, r1
dp3_pp r0.w, r1, r4
max_pp r0.w, r0, c13
mul_pp r5.x, r1.w, c14
pow_pp r1, r0.w, r5.x
texld r0, r0, s3
dp4 r0.y, r0, c15
rcp r1.y, r4.w
mul r0.x, r1.y, c6.w
mad r0.y, -r0.x, c14, r0
mov r0.z, c10.x
mul r0.x, r2.w, c8.w
mov_pp r1.y, r1.x
cmp r0.y, r0, c13.x, r0.z
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c12.w, r3.w
max_pp r0.x, r0, c13.w
mul r0.x, r0.w, r0
mad r0.y, r0, c11.z, c11.w
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 76 ALU, 5 TEX
PARAM c[20] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
MAD R2.xyz, R2, c[17].y, -c[17].x;
DP3 R4.z, R2, R2;
RSQ R4.z, R4.z;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyw, R0.xyzz, R0.w;
MOV R5.z, c[17].x;
DP4 R4.x, R5.xywz, c[0];
DP4 R0.w, R5.xywz, c[2];
DP4 R3.w, R5.xywz, c[1];
MUL R2.xyz, R4.z, R2;
MOV R0.z, R0.w;
MOV R0.x, R4;
MOV R0.y, R3.w;
ADD R3.xyz, R0, -c[12];
ADD R5.xyz, R0, -c[9];
DP3 R1.w, R3, R3;
RSQ R6.x, R1.w;
DP3 R4.y, R5, R5;
MUL R1.w, R1, c[12];
MUL R1.xyz, R6.x, R3;
RSQ R4.y, R4.y;
MAD R5.xyz, -R4.y, R5, -R1;
DP3 R4.y, R5, R5;
RSQ R4.y, R4.y;
MUL R5.xyz, R4.y, R5;
DP3 R4.y, R5, R2;
MAX R6.y, R4, c[17].z;
MOV R4.y, R3.w;
TEX R3, R3, texture[3], CUBE;
MOV R4.z, R0.w;
MOV R4.w, c[17].x;
DP4 R3.y, R3, c[19];
DP4 R5.z, R4, c[6];
DP4 R5.x, R4, c[4];
DP4 R5.y, R4, c[5];
RCP R4.x, R6.x;
MUL R3.x, R4, c[10].w;
MAD R3.y, -R3.x, c[18].x, R3;
MOV R3.x, c[17];
TEX R1.w, R1.w, texture[2], 2D;
CMP R3.x, R3.y, c[14], R3;
MUL R3.x, R1.w, R3;
MUL R1.w, R2, c[17];
TEX R0.w, R5, texture[4], CUBE;
MUL R0.w, R3.x, R0;
MOV_SAT R2.w, R0;
POW R1.w, R6.y, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[16];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[18].yzww;
DP3 R0.x, R0, c[13];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.w, R0;
MAD R0.y, R0, c[16].w, R5.w;
MAX R0.x, R0, c[17].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[15].z, c[15].w;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 76 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 74 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.97000003, 0, 0
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
mad r0.w, r0.x, c11.x, c11.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
texld r1, r1, s0
mov r3.z, c17.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r5.x, r3.xywz, c0
dp4 r0.w, r3.xywz, c2
dp4 r6.x, r3.xywz, c1
mov r2.z, r0.w
mov r2.x, r5
mov r2.y, r6.x
add r0.xyz, r2, -c12
dp3 r2.w, r0, r0
add r4.xyz, r2, -c9
dp3 r5.y, r4, r4
rsq r6.y, r5.y
rsq r4.w, r2.w
mad_pp r5.yzw, r1.xxyz, c17.y, c17.z
mul r3.xyz, r4.w, r0
mad r1.xyz, -r6.y, r4, -r3
dp3_pp r4.x, r5.yzww, r5.yzww
dp3 r4.y, r1, r1
rsq r6.y, r4.y
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5.yzww
mul r1.xyz, r6.y, r1
dp3_pp r1.x, r1, r4
mov_pp r5.w, c17.x
mul_pp r5.y, r1.w, c18.x
max_pp r5.z, r1.x, c17.w
pow_pp r1, r5.z, r5.y
mov_pp r5.y, r6.x
mov_pp r5.z, r0.w
mov_pp r1.y, r1.x
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r5, r0, s3
rcp r0.x, r4.w
mul r0.x, r0, c10.w
dp4 r0.y, r5, c19
mad r0.y, -r0.x, c18, r0
mov r0.z, c14.x
mul r0.x, r2.w, c12.w
cmp r0.y, r0, c17.x, r0.z
texld r0.x, r0.x, s2
mul r0.x, r0, r0.y
texld r0.w, r6, s4
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c16
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mul r0.x, r0.w, r0
mad r0.y, r0, c15.z, c15.w
add_sat r0.y, -r0, c17.x
mul r1.xyz, r0.x, c13
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 93 ALU, 8 TEX
PARAM c[26] = { program.local[0..23],
		{ 1, 2, 0, 128 },
		{ 0.25, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R4.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R4, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MOV R1.w, c[24].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[24].x;
DP4 R0.y, R2.xywz, c[1];
DP4 R1.x, R2.xywz, c[0];
DP4 R2.z, R2.xywz, c[2];
MOV R1.y, R0;
MOV R1.z, R2;
DP4 R0.x, R1, c[11];
DP4 R4.z, R1, c[8];
DP4 R4.w, R1, c[9];
RCP R3.w, R0.x;
MAD R0.zw, R3.w, R4, c[23].xyxy;
TEX R0.x, R0.zwzw, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[22];
MOV R0.w, R0.x;
TEX R0.x, R2, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[21];
MOV R0.z, R0.x;
TEX R0.x, R2, texture[4], 2D;
MOV R2.y, R0;
MOV R2.x, R1;
ADD R3.xyz, -R2, c[19];
MOV R0.y, R0.x;
DP3 R0.x, R3, R3;
MAD R3.xy, R3.w, R4.zwzw, c[20];
RSQ R3.z, R0.x;
TEX R0.x, R3, texture[4], 2D;
DP4 R3.y, R1, c[10];
DP4 R4.w, R1, c[7];
RCP R3.x, R3.z;
MAD R0, -R3.y, R3.w, R0;
ADD R3.y, -R2.w, R3.x;
MAD R2.w, R3.y, c[19], R2;
MOV R3.x, c[24];
CMP R0, R0, c[17].x, R3.x;
DP4 R3.y, R1, c[5];
DP4 R0.x, R0, c[25].x;
MAD_SAT R3.x, R2.w, c[17].z, c[17].w;
ADD_SAT R4.z, R0.x, R3.x;
DP4 R3.x, R1, c[4];
ADD R0.xyz, -R2, c[15];
DP3 R3.w, R0, R0;
MUL R1.y, R3.w, c[15].w;
MOV R3.z, R4.w;
TXP R0.w, R3.xyzz, texture[2], 2D;
SLT R1.x, R4.w, c[24].z;
TEX R1.w, R1.y, texture[3], 2D;
MUL R0.w, R0, R1.x;
MUL R0.w, R0, R1;
MUL R1.w, R0, R4.z;
ADD R1.xyz, R2, -c[13];
RSQ R0.w, R3.w;
MUL R2.xyz, R0.w, R0;
TEX R0, R4, texture[0], 2D;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MAD R1.xyz, -R3.x, R1, R2;
MAD R0.xyz, R0, c[24].y, -c[24].x;
DP3 R3.y, R0, R0;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MUL R1.xyz, R3.x, R1;
RSQ R3.y, R3.y;
MUL R0.xyz, R3.y, R0;
DP3 R1.x, R1, R0;
DP3 R0.x, R2, R0;
MUL R1.y, R0.w, c[24].w;
MAX R0.w, R1.x, c[24].z;
POW R0.w, R0.w, R1.y;
MOV_SAT R3.x, R1.w;
MOV R1.xyz, c[25].yzww;
MAX R0.x, R0, c[24].z;
DP3 R1.x, R1, c[16];
MUL R0.w, R0, R3.x;
MUL R0.w, R0, R1.x;
MAD R0.y, R2.w, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[24];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[16];
MUL R0, R0, R1.x;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 93 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 88 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c25, 128.00000000, 0.25000000, 0, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r4.xy, v0, r0.x
texld r0.x, r4, s1
texld r4, r4, s0
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mad r0.x, r0, c14, c14.y
mov r1.z, c24.x
mul r2.xyz, v1, r0.y
rcp r0.x, r0.x
mul r1.xyw, r2.xyzz, r0.x
dp4 r0.z, r1.xywz, c2
dp4 r0.x, r1.xywz, c0
dp4 r0.y, r1.xywz, c1
mov r3.z, r0
mov r3.x, r0
mov r3.y, r0
add r1.xyz, -r3, c15
add r2.xyz, r3, -c13
dp3 r2.w, r1, r1
rsq r0.w, r2.w
mul r1.xyz, r0.w, r1
dp3 r0.w, r2, r2
add r3.xyz, -r3, c19
rsq r0.w, r0.w
mad r5.xyz, -r0.w, r2, r1
dp3 r2.x, r5, r5
mad_pp r4.xyz, r4, c24.y, c24.z
dp3_pp r0.w, r4, r4
dp3 r3.x, r3, r3
rsq r3.w, r2.x
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r4
mov r0.w, c24.x
mul r4.xyz, r3.w, r5
dp4 r3.w, r0, c11
dp3_pp r4.x, r4, r2
dp4 r6.w, r0, c9
dp4 r6.z, r0, c8
rcp r3.w, r3.w
mad r5.xy, r3.w, r6.zwzw, c23
mad r6.xy, r3.w, r6.zwzw, c21
max_pp r5.z, r4.x, c24.w
mul_pp r5.w, r4, c25.x
pow_pp r4, r5.z, r5.w
rsq r4.y, r3.x
texld r5.x, r5, s4
mov r5.w, r5.x
mad r5.xy, r3.w, r6.zwzw, c22
texld r5.x, r5, s4
texld r6.x, r6, s4
mov r5.y, r6.x
rcp r4.y, r4.y
add r4.y, -r1.w, r4
dp4 r3.x, r0, c10
mad r1.w, r4.y, c19, r1
mov r5.z, r5.x
mad r6.xy, r3.w, r6.zwzw, c20
texld r5.x, r6, s4
mov r4.z, c17.x
mad r3, -r3.x, r3.w, r5
cmp r3, r3, c24.x, r4.z
dp4_pp r3.y, r3, c25.y
dp4 r4.z, r0, c7
mad_sat r3.x, r1.w, c17.z, c17.w
add_sat r4.y, r3, r3.x
dp4 r3.x, r0, c4
dp4 r3.z, r0, c6
dp4 r3.y, r0, c5
mul r0.x, r2.w, c15.w
mov r3.w, r4.z
texldp r0.w, r3, s2
cmp r0.y, r4.z, c24.w, c24.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r3.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.y, c26, r0
dp3_pp r0.x, r1, r2
mov_sat r2.w, r3.x
mov_pp r0.w, r4.x
mul r0.w, r0, r2
mul r2.w, r0, r0.y
max_pp r0.y, r0.x, c24.w
mul r0.y, r3.x, r0
mad r0.x, r1.w, c18.z, c18.w
add_sat r0.x, -r0, c24
mul r2.xyz, r0.y, c16
mul_pp r0, r2, r0.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 89 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c25, 0.00000000, 1.00000000, 0.25000000, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r7.xy, v0, r0.x
texld r0.x, r7, s1
mad r0.w, r0.x, c14.x, c14.y
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mov r2.w, c25.y
mov r1.z, c25.y
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r1.xyw, r0.xyzz, r0.w
dp4 r0.w, r1.xywz, c2
dp4 r2.x, r1.xywz, c0
dp4 r3.y, r1.xywz, c1
mov r2.y, r3
mov r2.z, r0.w
dp4 r0.x, r2, c11
rcp r4.w, r0.x
dp4 r6.z, r2, c10
dp4 r6.y, r2, c9
dp4 r6.x, r2, c8
mad r0.xyz, r6, r4.w, c23
mov r3.z, r0.w
mov r3.x, r2
add r4.xyz, -r3, c15
texld r0.x, r0, s4
add r1.xyz, r3, -c13
dp3 r3.w, r4, r4
rsq r0.z, r3.w
dp3 r0.y, r1, r1
mul r4.xyz, r0.z, r4
rsq r0.y, r0.y
mad r5.xyz, -r0.y, r1, r4
mad r1.xyz, r6, r4.w, c21
mov_pp r0.w, r0.x
mad r0.xyz, r6, r4.w, c22
texld r0.x, r0, s4
texld r1.x, r1, s4
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, r6, r4.w, c20
mov r0.x, c17
add r4.w, c25.y, -r0.x
texld r0.x, r1, s4
mad r0, r0, r4.w, c17.x
dp4_pp r4.w, r0, c25.z
dp3 r1.x, r5, r5
add r0.xyz, -r3, c19
rsq r0.w, r1.x
mul r1.xyz, r0.w, r5
dp3 r3.x, r0, r0
texld r0, r7, s0
rsq r3.x, r3.x
rcp r3.y, r3.x
mad_pp r0.xyz, r0, c24.x, c24.y
add r3.z, -r1.w, r3.y
dp3_pp r3.x, r0, r0
rsq_pp r3.y, r3.x
mul_pp r0.xyz, r3.y, r0
dp3_pp r1.x, r1, r0
mad r3.x, r3.z, c19.w, r1.w
dp3_pp r0.x, r4, r0
mad_sat r1.w, r3.x, c17.z, c17
add_sat r3.y, r4.w, r1.w
dp4 r4.w, r2, c7
mul_pp r0.w, r0, c24
max_pp r3.z, r1.x, c24
pow_pp r1, r3.z, r0.w
cmp r1.y, r4.w, c25.x, c25
dp4 r5.z, r2, c6
dp4 r5.x, r2, c4
dp4 r5.y, r2, c5
mov r5.w, r4
texldp r0.w, r5, s2
mul r2.x, r3.w, c15.w
mul r0.w, r0, r1.y
texld r2.x, r2.x, s3
mul r0.w, r0, r2.x
mul r1.w, r0, r3.y
mov_pp r2.x, r1
mov_sat r0.w, r1
mov_pp r1.xyz, c16
max_pp r0.x, r0, c24.z
dp3_pp r1.x, c26, r1
mul r0.w, r2.x, r0
mul r0.w, r0, r1.x
mad r0.y, r3.x, c18.z, c18.w
add_sat r1.x, -r0.y, c25.y
mul r0.x, r1.w, r0
mul r0.xyz, r0.x, c16
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 76 ALU, 7 TEX
PARAM c[17] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyz, R0, R0.w;
MOV R4.w, c[13].x;
DP4 R0.z, R4, c[2];
DP4 R0.x, R4, c[0];
DP4 R0.y, R4, c[1];
ADD R5.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R5, R5;
RSQ R2.w, R0.w;
DP3 R3.w, R3, R3;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.x, R1, R1;
RSQ R4.x, R4.x;
ADD R6.xyz, R5, c[14].zyzw;
MUL R0.w, R0, c[8];
MUL R2.xyz, R2.w, R5;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
MUL R1.xyz, R4.x, R1;
DP3 R3.x, R3, R1;
RCP R3.y, R2.w;
TEX R6, R6, texture[3], CUBE;
MAX R2.w, R3.x, c[13].z;
MUL R4.x, R3.y, c[6].w;
ADD R3.xyz, R5, c[14].yzzw;
TEX R3, R3, texture[3], CUBE;
DP4 R3.w, R3, c[15];
DP4 R3.z, R6, c[15];
ADD R6.xyz, R5, c[14].zzyw;
ADD R5.xyz, R5, c[14].y;
TEX R6, R6, texture[3], CUBE;
TEX R5, R5, texture[3], CUBE;
MUL R1.w, R1, c[13];
POW R1.w, R2.w, R1.w;
ADD R0.xyz, -R0, c[12];
DP4 R3.y, R6, c[15];
DP4 R3.x, R5, c[15];
MOV R4.y, c[13].x;
MAD R3, -R4.x, c[14].x, R3;
CMP R3, R3, c[10].x, R4.y;
DP4 R3.x, R3, c[14].w;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R3.x;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.z, R0;
MAD R0.y, R0, c[12].w, R4.z;
MAX R0.x, R0, c[13].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[11].z, c[11].w;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 76 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 72 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r4.z, c13.x
mad r0.w, r1.x, c7.x, c7.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r4.xyw, r1.xyzz, r0.z
texld r0, r0, s0
dp4 r2.z, r4.xywz, c2
dp4 r2.x, r4.xywz, c0
dp4 r2.y, r4.xywz, c1
add r3.xyz, r2, -c8
add r1.xyz, r2, -c5
dp3 r3.w, r1, r1
dp3 r2.w, r3, r3
rsq r1.w, r2.w
mul r4.xyz, r1.w, r3
mad_pp r5.xyz, r0, c13.y, c13.z
rsq r3.w, r3.w
mad r0.xyz, -r3.w, r1, -r4
dp3_pp r1.y, r5, r5
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r5.xyz, r1.y, r5
dp3_pp r0.x, r0, r5
mul_pp r0.y, r0.w, c14.x
max_pp r0.x, r0, c13.w
pow_pp r6, r0.x, r0.y
rcp r0.x, r1.w
mul r5.w, r0.x, c6
add r0.xyz, r3, c14.yzzw
texld r0, r0, s3
add r1.xyz, r3, c14.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c15
dp4 r0.z, r1, c15
add r1.xyz, r3, c14.y
texld r1, r1, s3
dp4 r0.x, r1, c15
add r7.xyz, r3, c14.zzyw
texld r3, r7, s3
dp4 r0.y, r3, c15
mad r0, -r5.w, c14.w, r0
mov r1.x, c10
cmp r1, r0, c13.x, r1.x
mul r0.x, r2.w, c8.w
dp4_pp r0.y, r1, c16.x
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_pp r1.y, r6.x
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r4.w, r0
dp3_pp r0.x, -r4, r5
mad r0.y, r0, c12.w, r4.w
max_pp r0.x, r0, c13.w
mul r0.x, r0.w, r0
mad r0.y, r0, c11.z, c11.w
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp r0, r1, r0.y
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 87 ALU, 8 TEX
PARAM c[21] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MOV R3.z, c[17].x;
TEX R5, R1, texture[0], 2D;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
DP4 R6.w, R3.xywz, c[0];
DP4 R2.w, R3.xywz, c[2];
DP4 R7.x, R3.xywz, c[1];
MOV R2.z, R2.w;
MOV R2.x, R6.w;
MOV R2.y, R7.x;
ADD R6.xyz, R2, -c[12];
DP3 R7.y, R6, R6;
RSQ R0.w, R7.y;
ADD R0.xyz, R2, -c[9];
DP3 R1.z, R0, R0;
RSQ R1.w, R1.z;
MUL R3.xyz, R0.w, R6;
MAD R1.xyz, R5, c[17].y, -c[17].x;
MAD R0.xyz, -R1.w, R0, -R3;
DP3 R4.x, R1, R1;
DP3 R1.w, R0, R0;
RSQ R4.x, R4.x;
MUL R5.xyz, R4.x, R1;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R0.x, R0, R5;
ADD R1.xyz, R6, c[18].yzzw;
TEX R1, R1, texture[3], CUBE;
RCP R0.y, R0.w;
DP4 R4.w, R1, c[19];
ADD R1.xyz, R6, c[18].y;
TEX R1, R1, texture[3], CUBE;
DP4 R4.x, R1, c[19];
MAX R7.z, R0.x, c[17];
MUL R7.w, R0.y, c[10];
ADD R0.xyz, R6, c[18].zyzw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.z, R0, c[19];
ADD R0.xyz, R6, c[18].zzyw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.y, R0, c[19];
MOV R6.x, R7;
MOV R6.z, c[17].x;
MOV R6.y, R2.w;
MOV R1.x, c[17];
MAD R0, -R7.w, c[18].x, R4;
CMP R0, R0, c[14].x, R1.x;
DP4 R0.x, R0, c[18].w;
MUL R1.x, R7.y, c[12].w;
TEX R0.w, R1.x, texture[2], 2D;
MUL R1.x, R0.w, R0;
DP4 R0.z, R6.wxyz, c[6];
DP4 R0.x, R6.wxyz, c[4];
DP4 R0.y, R6.wxyz, c[5];
TEX R0.w, R0, texture[4], CUBE;
MUL R0.w, R1.x, R0;
MUL R0.x, R5.w, c[17].w;
POW R1.x, R7.z, R0.x;
MOV_SAT R1.y, R0.w;
MUL R1.x, R1, R1.y;
ADD R0.xyz, -R2, c[16];
DP3 R1.y, R0, R0;
MOV R0.xyz, c[20];
DP3 R0.x, R0, c[13];
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, -R3, R5;
MAD R0.y, R0, c[16].w, R3.w;
MAX R0.x, R0, c[17].z;
MUL R0.x, R0.w, R0;
MAD R0.y, R0, c[15].z, c[15].w;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL R0, R1, R0.y;
EX2 result.color.x, -R0.x;
EX2 result.color.y, -R0.y;
EX2 result.color.z, -R0.z;
EX2 result.color.w, -R0.w;
END
# 87 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 82 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c17.x
mad r0.w, r1.x, c11.x, c11.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r7.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
texld r0, r0, s0
mov r2.z, r2.w
mov r2.x, r7
mov r2.y, r4.w
add r5.xyz, r2, -c12
add r1.xyz, r2, -c9
dp3 r4.x, r1, r1
dp3 r7.y, r5, r5
rsq r1.w, r7.y
rsq r5.w, r4.x
mul r3.xyz, r1.w, r5
mad_pp r4.xyz, r0, c17.y, c17.z
mad r0.xyz, -r5.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c18.x
max_pp r0.x, r0, c17.w
rcp r0.z, r1.w
pow_pp r6, r0.x, r0.y
mul r6.y, r0.z, c10.w
add r0.xyz, r5, c18.yzzw
texld r0, r0, s3
add r1.xyz, r5, c18.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c19
dp4 r0.z, r1, c19
add r1.xyz, r5, c18.y
texld r1, r1, s3
dp4 r0.x, r1, c19
add r8.xyz, r5, c18.zzyw
texld r5, r8, s3
dp4 r0.y, r5, c19
mov_pp r7.w, c17.x
mov_pp r7.z, r2.w
mov r1.x, c14
mad r0, -r6.y, c18.w, r0
cmp r0, r0, c17.x, r1.x
dp4_pp r0.y, r0, c20.x
mul r0.x, r7.y, c12.w
mov_pp r7.y, r4.w
texld r0.x, r0.x, s2
dp4 r1.x, r7, c4
dp4 r1.y, r7, c5
dp4 r1.z, r7, c6
texld r0.w, r1, s4
mul r0.x, r0, r0.y
mul r1.x, r0, r0.w
mov_pp r1.y, r6.x
mov_sat r0.w, r1.x
add r0.xyz, -r2, c16
mul r0.w, r1.y, r0
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20.yzww, r0
mul r0.w, r0, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mad r0.y, r0, c15.z, c15.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c17
mul r0.xyz, r0.x, c13
mul_pp r0, r0, r1.x
exp_pp oC0.x, -r0.x
exp_pp oC0.y, -r0.y
exp_pp oC0.z, -r0.z
exp_pp oC0.w, -r0.w
"
}
}
 }
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 53 ALU, 3 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R4.xyz, R1, R0.z;
MOV R4.w, c[11].x;
DP4 R1.z, R4, c[2];
DP4 R1.x, R4, c[0];
DP4 R1.y, R4, c[1];
ADD R2.xyz, R1, -c[7];
ADD R3.xyz, R1, -c[5];
DP3 R1.w, R2, R2;
RSQ R0.z, R1.w;
MUL R2.xyz, R0.z, R2;
TEX R0, R0, texture[0], 2D;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
MAD R3.xyz, -R2.w, R3, -R2;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R3.w, R0, R0;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
RSQ R3.w, R3.w;
MUL R0.xyz, R3.w, R0;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R3, R0;
DP3 R0.x, -R2, R0;
MUL R3.x, R1.w, c[7].w;
MUL R1.w, R0, c[11];
MAX R2.w, R2, c[11].z;
TEX R0.w, R3.x, texture[2], 2D;
POW R1.w, R2.w, R1.w;
MOV_SAT R2.w, R0;
MAX R0.x, R0, c[11].z;
MUL R1.w, R1, R2;
ADD R1.xyz, -R1, c[10];
DP3 R2.w, R1, R1;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RSQ R2.w, R2.w;
RCP R1.y, R2.w;
MUL R1.w, R1, R1.x;
ADD R1.x, -R4.z, R1.y;
MAD R0.y, R1.x, c[10].w, R4.z;
MAD R0.y, R0, c[9].z, c[9].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[11].x;
MUL R1.xyz, R0.x, c[8];
MUL result.color, R1, R0.y;
END
# 53 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"ps_3_0
; 53 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c11.x
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r1.xyz, r2, -c5
dp3 r1.w, r1, r1
add r3.xyz, r2, -c7
dp3 r2.w, r3, r3
rsq r0.z, r2.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c11.y, c11.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c12.x
max_pp r0.x, r0, c11.w
pow_pp r1, r0.x, r0.y
mov_pp r0.z, r1.x
mul r0.x, r2.w, c7.w
texld r0.x, r0.x, s2
mov_sat r0.y, r0.x
mul r0.y, r0.z, r0
add r1.xyz, -r2, c10
dp3 r0.z, r1, r1
rsq r0.w, r0.z
mov_pp r1.xyz, c8
dp3_pp r0.z, c12.yzww, r1
rcp r1.x, r0.w
mul r0.w, r0.y, r0.z
add r0.z, -r3.w, r1.x
dp3_pp r0.y, -r3, r4
max_pp r0.y, r0, c11.w
mad r0.z, r0, c10.w, r3.w
mad r0.z, r0, c9, c9.w
add_sat r1.x, -r0.z, c11
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, c8
mul_pp oC0, r0, r1.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"3.0-!!ARBfp1.0
# 44 ALU, 2 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R3.xyz, R1, R0.z;
MOV R3.w, c[11].x;
TEX R0, R0, texture[0], 2D;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
DP4 R1.z, R3, c[2];
DP4 R1.x, R3, c[0];
DP4 R1.y, R3, c[1];
ADD R2.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[10];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MAD R2.xyz, -R1.w, R2, -c[7];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R1.w, R2, R0;
DP3 R0.x, R0, -c[7];
MAX R1.w, R1, c[11].z;
MUL R0.w, R0, c[11];
DP3 R1.x, R1, R1;
POW R0.w, R1.w, R0.w;
RSQ R1.w, R1.x;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RCP R1.w, R1.w;
MUL R0.w, R0, R1.x;
ADD R1.y, -R3.z, R1.w;
MAD R1.x, R1.y, c[10].w, R3.z;
MAD R0.y, R1.x, c[9].z, c[9].w;
ADD_SAT R1.x, -R0.y, c[11];
MAX R0.x, R0, c[11].z;
MUL R0.xyz, R0.x, c[8];
MUL result.color, R0, R1.x;
END
# 44 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"ps_3_0
; 45 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyz, r1, r0.z
mov r3.w, c11.x
texld r0, r0, s0
mad_pp r0.xyz, r0, c11.y, c11.z
dp3_pp r2.w, r0, r0
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, r0
dp4 r1.z, r3, c2
dp4 r1.x, r3, c0
dp4 r1.y, r3, c1
add r2.xyz, r1, -c5
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r2.xyz, r1.w, r2
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
mul_pp r3.x, r0.w, c12
max_pp r0.w, r1, c11
pow_pp r2, r0.w, r3.x
add r1.xyz, -r1, c10
dp3 r0.w, r1, r1
mov_pp r1.w, r2.x
rsq r0.w, r0.w
mov_pp r1.xyz, c8
rcp r2.x, r0.w
dp3_pp r0.w, c12.yzww, r1
add r1.x, -r3.z, r2
mad r1.x, r1, c10.w, r3.z
mad r0.y, r1.x, c9.z, c9.w
add_sat r1.x, -r0.y, c11
max_pp r0.x, r0, c11.w
mul r0.w, r1, r0
mul r0.xyz, r0.x, c8
mul_pp oC0, r0, r1.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 66 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[15].x;
DP4 R3.x, R2.xywz, c[0];
DP4 R3.y, R2.xywz, c[1];
DP4 R0.w, R2.xywz, c[2];
MOV R0.z, R0.w;
MOV R0.x, R3;
MOV R0.y, R3;
ADD R2.xyz, -R0, c[11];
ADD R4.xyz, R0, -c[9];
DP3 R4.w, R2, R2;
RSQ R1.z, R4.w;
MUL R2.xyz, R1.z, R2;
TEX R1, R1, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, R2;
MAD R1.xyz, R1, c[15].y, -c[15].x;
DP3 R3.w, R1, R1;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R4.x, R4, R1;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
DP4 R5.y, R3, c[7];
MAX R5.x, R4, c[15].z;
MUL R1.w, R1, c[15];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
MOV R4.z, R5.y;
TXP R0.w, R4.xyzz, texture[2], 2D;
SLT R3.x, R5.y, c[15].z;
MUL R3.x, R0.w, R3;
MUL R3.y, R4.w, c[11].w;
TEX R0.w, R3.y, texture[3], 2D;
MUL R0.w, R3.x, R0;
MOV_SAT R3.x, R0.w;
POW R1.w, R5.x, R1.w;
MUL R1.w, R1, R3.x;
ADD R0.xyz, -R0, c[14];
DP3 R3.x, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, R2, R1;
RSQ R3.x, R3.x;
RCP R0.y, R3.x;
ADD R0.y, -R2.w, R0;
MAD R0.y, R0, c[14].w, R2.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1, R0.y;
END
# 66 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 65 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.x, r3.xywz, c0
dp4 r2.z, r3.xywz, c2
dp4 r2.y, r3.xywz, c1
mov r1.x, r2
mov r1.z, r2
mov r1.y, r2
add r4.xyz, r1, -c9
add r3.xyz, -r1, c11
dp3 r2.w, r4, r4
dp3 r1.w, r3, r3
rsq r0.z, r1.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r5.xyz, r0, c15.y, c15.z
rsq r2.w, r2.w
mad r0.xyz, -r2.w, r4, r3
dp3_pp r4.x, r5, r5
dp3 r2.w, r0, r0
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mov r2.w, c15.x
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
dp4 r4.w, r2, c7
max_pp r0.y, r0, c15.w
pow_pp r5, r0.y, r0.x
dp4 r0.z, r2, c6
dp4 r0.x, r2, c4
dp4 r0.y, r2, c5
mov r0.w, r4
texldp r0.w, r0, s2
mul r0.x, r1.w, c11.w
cmp r0.y, r4.w, c15.w, c15.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.w, r0.y, r0.x
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
mad r0.y, r0, c14.w, r3.w
mad r0.y, r0, c13.z, c13.w
mov_sat r1.w, r0
mov_pp r2.x, r5
mul r1.x, r2, r1.w
mul r1.w, r1.x, r0.x
dp3_pp r0.x, r3, r4
max_pp r0.x, r0, c15.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 64 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyw, R0.xyzz, R0.w;
MOV R4.z, c[15].x;
DP4 R3.x, R4.xywz, c[0];
DP4 R0.w, R4.xywz, c[2];
DP4 R1.w, R4.xywz, c[1];
MOV R0.z, R0.w;
MOV R0.y, R1.w;
MOV R0.x, R3;
ADD R1.xyz, R0, -c[11];
DP3 R3.y, R1, R1;
ADD R4.xyz, R0, -c[9];
RSQ R2.z, R3.y;
MUL R1.xyz, R2.z, R1;
TEX R2, R2, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, -R1;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R3.w, R2, R2;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R2.xyz, R3.w, R2;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R3.z, R4, R2;
MAX R5.x, R3.z, c[15].z;
MUL R5.y, R3, c[11].w;
MOV R3.y, R1.w;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
TEX R1.w, R5.y, texture[2], 2D;
MUL R2.w, R2, c[15];
ADD R0.xyz, -R0, c[14];
DP4 R4.z, R3, c[6];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
TEX R0.w, R4, texture[3], CUBE;
MUL R0.w, R1, R0;
POW R1.w, R5.x, R2.w;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.w, R0;
MAD R0.y, R0, c[14].w, R4.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1, R0.y;
END
# 64 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 63 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r5.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
mov r2.z, r2.w
mov r2.x, r5
mov r2.y, r4.w
add r1.xyz, r2, -c9
dp3 r1.w, r1, r1
add r3.xyz, r2, -c11
dp3 r5.y, r3, r3
rsq r0.z, r5.y
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c15.y, c15.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
max_pp r0.y, r0, c15.w
pow_pp r1, r0.y, r0.x
mul r0.x, r5.y, c11.w
mov_pp r5.y, r4.w
mov_pp r5.w, c15.x
mov_pp r5.z, r2.w
mov_pp r1.y, r1.x
texld r0.x, r0.x, s2
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r0.w, r6, s3
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c14.w, r3.w
max_pp r0.x, r0, c15.w
mad r0.y, r0, c13.z, c13.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 54 ALU, 3 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[15].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R1.z, R0;
MOV R1.x, R0;
MOV R1.y, R0;
ADD R3.xyz, R1, -c[9];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R3, -c[11];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R3;
MUL R2.xyz, R1.w, R2;
DP3 R0.w, R3, R2;
MAX R1.w, R0, c[15].z;
MOV R0.w, c[15].x;
DP4 R3.y, R0, c[5];
DP4 R3.x, R0, c[4];
MUL R0.x, R2.w, c[15].w;
POW R1.w, R1.w, R0.x;
ADD R0.xyz, -R1, c[14];
DP3 R1.y, R0, R0;
TEX R0.w, R3, texture[2], 2D;
MOV R0.xyz, c[16];
MOV_SAT R2.w, R0;
DP3 R0.x, R0, c[12];
MUL R1.x, R1.w, R2.w;
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, R2, -c[11];
MAD R0.y, R0, c[14].w, R3.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1, R0.y;
END
# 54 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 56 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r3.x, r2.xywz, c0
dp4 r1.w, r2.xywz, c2
dp4 r4.x, r2.xywz, c1
texld r0, r0, s0
mov r1.z, r1.w
mov r1.x, r3
mov r1.y, r4.x
add r2.xyz, r1, -c9
dp3 r3.y, r2, r2
rsq r4.y, r3.y
mad_pp r3.yzw, r0.xxyz, c15.y, c15.z
mad r0.xyz, -r4.y, r2, -c11
dp3_pp r2.x, r3.yzww, r3.yzww
dp3 r2.y, r0, r0
rsq r4.y, r2.y
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r3.yzww
mul r0.xyz, r4.y, r0
dp3_pp r0.x, r0, r2
mul_pp r3.y, r0.w, c16.x
max_pp r3.z, r0.x, c15.w
pow_pp r0, r3.z, r3.y
mov_pp r3.y, r4.x
mov_pp r3.z, r1.w
mov_pp r3.w, c15.x
dp4 r4.x, r3, c4
dp4 r4.y, r3, c5
texld r0.w, r4, s2
mov_pp r3.x, r0
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_sat r1.w, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.x, r3, r1.w
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r2.w, r0
dp3_pp r0.x, r2, -c11
mad r0.y, r0, c14.w, r2.w
max_pp r0.x, r0, c15.w
mad r0.y, r0, c13.z, c13.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 79 ALU, 5 TEX
PARAM c[22] = { program.local[0..19],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.zw, fragment.texcoord[0].xyxy, R0.x;
TEX R0.x, R1.zwzw, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[20].x;
DP4 R1.x, R5, c[0];
DP4 R1.y, R5, c[1];
DP4 R0.w, R5, c[2];
MOV R0.z, R0.w;
MOV R0.x, R1;
MOV R0.y, R1;
ADD R2.xyz, -R0, c[15];
ADD R4.xyz, R0, -c[13];
ADD R0.xyz, -R0, c[19];
DP3 R0.x, R0, R0;
DP3 R2.w, R2, R2;
RSQ R3.x, R2.w;
MUL R2.xyz, R3.x, R2;
TEX R3, R1.zwzw, texture[0], 2D;
DP3 R4.w, R4, R4;
RSQ R1.z, R4.w;
MAD R4.xyz, -R1.z, R4, R2;
MAD R3.xyz, R3, c[20].y, -c[20].x;
DP3 R1.w, R3, R3;
DP3 R1.z, R4, R4;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
RSQ R1.z, R1.z;
MUL R4.xyz, R1.z, R4;
DP3 R4.x, R4, R3;
MOV R1.z, R0.w;
MOV R1.w, c[20].x;
DP4 R0.w, R1, c[7];
MAX R4.w, R4.x, c[20].z;
DP4 R4.x, R1, c[4];
DP4 R0.y, R1, c[9];
DP4 R4.y, R1, c[5];
SLT R5.x, R0.w, c[20].z;
MOV R4.z, R0.w;
TXP R0.w, R4.xyzz, texture[2], 2D;
MUL R4.x, R0.w, R5;
MUL R0.w, R2, c[15];
DP4 R2.w, R1, c[11];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R4.x, R0;
RSQ R0.x, R0.x;
RCP R4.x, R0.x;
DP4 R0.x, R1, c[8];
MOV R0.z, R2.w;
TXP R0.x, R0.xyzz, texture[4], 2D;
DP4 R0.y, R1, c[10];
RCP R0.z, R2.w;
MAD R0.y, -R0, R0.z, R0.x;
ADD R4.x, -R5.z, R4;
MAD R1.x, R4, c[19].w, R5.z;
MOV R0.x, c[20];
MAD_SAT R0.z, R1.x, c[17], c[17].w;
CMP R0.x, R0.y, c[17], R0;
ADD_SAT R0.y, R0.x, R0.z;
MUL R1.y, R0.w, R0;
MUL R0.x, R3.w, c[20].w;
POW R0.w, R4.w, R0.x;
MOV R0.xyz, c[21];
DP3 R0.x, R0, c[16];
MOV_SAT R1.z, R1.y;
MUL R0.w, R0, R1.z;
DP3 R0.y, R2, R3;
MUL R0.w, R0, R0.x;
MAX R0.x, R0.y, c[20].z;
MAD R0.y, R1.x, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[20];
MUL R0.x, R1.y, R0;
MUL R0.xyz, R0.x, c[16];
MUL result.color, R0, R1.x;
END
# 79 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 80 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c21, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c20.x
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.y, c20.z
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.w
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c21.x
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c20.x
mov r1.z, r5.x
dp4 r4.z, r1, c10
dp4 r4.w, r1, c11
rsq r4.y, r0.x
dp4 r0.y, r1, c9
mov r0.z, r4
dp4 r0.x, r1, c8
mov r0.w, r4
texldp r0.x, r0, s4
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
rcp r0.y, r4.w
mad r0.x, -r4.z, r0.y, r0
dp4 r4.z, r1, c7
mov r0.y, c17.x
cmp r0.x, r0, c20, r0.y
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c20.w, c20.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c21.yzww, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
dp3_pp r0.y, r2, r3
mul r0.w, r0, r0.x
max_pp r0.x, r0.y, c20.w
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c20
mul r0.xyz, r0.x, c16
mul_pp oC0, r0, r1.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 77 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c21, 0.00000000, 1.00000000, 0, 0
def c22, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c21.y
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.x, c20.y
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.z
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c20
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c21.y
mov r1.z, r5.x
rsq r4.y, r0.x
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
texldp r0.x, r0, s4
dp4 r4.z, r1, c7
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
mov r0.y, c17.x
add r0.y, c21, -r0
mad r0.x, r0, r0.y, c17
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c21.x, c21
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c22, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
dp3_pp r0.y, r2, r3
mul r0.w, r0, r0.x
max_pp r0.x, r0.y, c20.z
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c21.y
mul r0.xyz, r0.x, c16
mul_pp oC0, r0, r1.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 49 ALU, 3 TEX
PARAM c[14] = { program.local[0..11],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R3.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R3, texture[1], 2D;
MAD R0.w, R0.x, c[6].x, c[6].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MOV R2.z, c[12].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
DP4 R1.z, R2.xywz, c[2];
DP4 R1.x, R2.xywz, c[0];
DP4 R1.y, R2.xywz, c[1];
ADD R0.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[11];
DP3 R1.x, R1, R1;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MAD R2.xyz, -R0.w, R0, -c[7];
TEX R0, R3, texture[0], 2D;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RSQ R1.y, R1.x;
RCP R1.y, R1.y;
ADD R1.z, -R2.w, R1.y;
MUL R1.y, R0.w, c[12].w;
MUL R2.xyz, R1.w, R2;
MAD R0.xyz, R0, c[12].y, -c[12].x;
DP3 R1.w, R0, R0;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R1.x, R2, R0;
DP3 R0.x, R0, -c[7];
MAD R0.w, R1.z, c[11], R2;
MAX R1.x, R1, c[12].z;
POW R1.w, R1.x, R1.y;
MAD R0.y, R0.w, c[10].z, c[10].w;
MAD_SAT R1.y, R0.w, c[9].z, c[9].w;
TEX R1.x, R3, texture[2], 2D;
ADD_SAT R2.x, R1, R1.y;
MOV R1.xyz, c[13];
MAX R0.x, R0, c[12].z;
DP3 R1.x, R1, c[8];
MUL R1.w, R1, R2.x;
MUL R1.w, R1, R1.x;
MUL R0.x, R2, R0;
ADD_SAT R0.y, -R0, c[12].x;
MUL R1.xyz, R0.x, c[8];
MUL result.color, R1, R0.y;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 49 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c13, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c6.x, c6.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r2.z, c12.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r1.z, r2.xywz, c2
dp4 r1.x, r2.xywz, c0
dp4 r1.y, r2.xywz, c1
add r2.xyz, r1, -c5
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
add r1.xyz, -r1, c11
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c12.y, c12.z
rsq r3.z, r1.w
dp3_pp r3.w, r0, r0
rsq_pp r1.w, r3.w
mul r2.xyz, r3.z, r2
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
rsq r1.x, r1.x
max_pp r2.x, r1.w, c12.w
mul_pp r0.w, r0, c13.x
rcp r2.y, r1.x
pow_pp r1, r2.x, r0.w
mov_pp r1.w, r1.x
add r0.w, -r2, r2.y
mad r0.w, r0, c11, r2
mad r0.y, r0.w, c10.z, c10.w
mad_sat r1.y, r0.w, c9.z, c9.w
texld r1.x, r3, s2
add_sat r2.x, r1, r1.y
mov_pp r1.xyz, c8
max_pp r0.x, r0, c12.w
dp3_pp r1.x, c13.yzww, r1
mul r1.w, r1, r2.x
mul r1.w, r1, r1.x
mul r0.x, r2, r0
add_sat r0.y, -r0, c12.x
mul r1.xyz, r0.x, c8
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 58 ALU, 4 TEX
PARAM c[18] = { program.local[0..15],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[16].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R4.z, R0;
MOV R4.x, R0;
MOV R4.y, R0;
ADD R1.xyz, R4, -c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R1, -c[11];
TEX R1, R2, texture[0], 2D;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
ADD R4.xyz, -R4, c[15];
DP3 R2.z, R4, R4;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
MUL R3.xyz, R0.w, R3;
MAD R1.xyz, R1, c[16].y, -c[16].x;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R3, R1;
ADD R2.z, -R3.w, R2;
MAX R3.y, R0.w, c[16].z;
MOV R0.w, c[16].x;
MAD R3.x, R2.z, c[15].w, R3.w;
DP4 R2.z, R0, c[4];
DP4 R2.w, R0, c[5];
TEX R0.x, R2, texture[2], 2D;
MAD_SAT R0.y, R3.x, c[13].z, c[13].w;
ADD_SAT R0.y, R0.x, R0;
MUL R0.x, R1.w, c[16].w;
TEX R0.w, R2.zwzw, texture[3], 2D;
MUL R1.w, R0.y, R0;
POW R0.w, R3.y, R0.x;
MOV R0.xyz, c[17];
DP3 R0.x, R0, c[12];
MOV_SAT R2.x, R1.w;
MUL R0.w, R0, R2.x;
DP3 R0.y, R1, -c[11];
MUL R0.w, R0, R0.x;
MAX R0.x, R0.y, c[16].z;
MAD R0.y, R3.x, c[14].z, c[14].w;
ADD_SAT R1.x, -R0.y, c[16];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[12];
MUL result.color, R0, R1.x;
END
# 58 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 58 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c16, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c17, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c10.x, c10.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
mov r2.z, c16.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r4.x, r2.xywz, c0
dp4 r3.z, r2.xywz, c2
dp4 r3.w, r2.xywz, c1
mov r1.z, r3
mov r1.x, r4
mov r1.y, r3.w
add r2.xyz, r1, -c9
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c11
dp3 r1.w, r2, r2
rsq r4.y, r1.w
mul r2.xyz, r4.y, r2
add r1.xyz, -r1, c15
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c16.y, c16.z
dp3_pp r4.z, r0, r0
rsq_pp r1.w, r4.z
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c11
rsq r1.x, r1.x
max_pp r2.x, r1.w, c16.w
rcp r2.y, r1.x
mul_pp r0.w, r0, c17.x
pow_pp r1, r2.x, r0.w
add r0.w, -r2, r2.y
mad r1.y, r0.w, c15.w, r2.w
mov_pp r4.y, r3.w
mov_pp r4.w, c16.x
mov_pp r4.z, r3
dp4 r2.x, r4, c4
dp4 r2.y, r4, c5
texld r0.w, r2, s3
texld r2.x, r3, s2
mad_sat r1.z, r1.y, c13, c13.w
add_sat r1.z, r2.x, r1
mul r1.z, r1, r0.w
mov_sat r0.w, r1.z
max_pp r0.x, r0, c16.w
mul r0.w, r1.x, r0
mov_pp r2.xyz, c12
dp3_pp r1.x, c17.yzww, r2
mul r0.w, r0, r1.x
mad r0.y, r1, c14.z, c14.w
add_sat r1.x, -r0.y, c16
mul r0.x, r1.z, r0
mul r0.xyz, r0.x, c12
mul_pp oC0, r0, r1.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 61 ALU, 4 TEX
PARAM c[16] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.w, R1, R1;
RSQ R4.w, R4.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[13].x;
MUL R1.xyz, R4.w, R1;
DP4 R0.z, R5, c[2];
DP4 R0.x, R5, c[0];
DP4 R0.y, R5, c[1];
ADD R4.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R4, R4;
RSQ R2.w, R0.w;
MUL R2.xyz, R2.w, R4;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
DP3 R3.x, R3, R1;
MAX R4.w, R3.x, c[13].z;
TEX R3, R4, texture[3], CUBE;
RCP R2.w, R2.w;
MUL R0.w, R0, c[8];
MUL R1.w, R1, c[13];
MUL R2.w, R2, c[6];
DP4 R3.x, R3, c[15];
MAD R3.x, -R2.w, c[14], R3;
MOV R2.w, c[13].x;
CMP R2.w, R3.x, c[10].x, R2;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R2;
MOV_SAT R2.w, R0;
POW R1.w, R4.w, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[12];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[14].yzww;
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.z, R0;
MAD R0.y, R0, c[12].w, R5.z;
MAX R0.x, R0, c[13].z;
MAD R0.y, R0, c[11].z, c[11].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL result.color, R1, R0.y;
END
# 61 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 60 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.97000003, 0, 0
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
texld r1, r1, s0
mad r0.w, r0.x, c7.x, c7.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r3.z, c13.x
mad_pp r5.xyz, r1, c13.y, c13.z
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r4.xyz, r2, -c5
dp3 r0.w, r4, r4
add r0.xyz, r2, -c8
dp3 r2.w, r0, r0
rsq r4.w, r2.w
mul r3.xyz, r4.w, r0
rsq r0.w, r0.w
mad r1.xyz, -r0.w, r4, -r3
dp3_pp r4.x, r5, r5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
mul r1.xyz, r0.w, r1
dp3_pp r0.w, r1, r4
max_pp r0.w, r0, c13
mul_pp r5.x, r1.w, c14
pow_pp r1, r0.w, r5.x
texld r0, r0, s3
dp4 r0.y, r0, c15
rcp r1.y, r4.w
mul r0.x, r1.y, c6.w
mad r0.y, -r0.x, c14, r0
mov r0.z, c10.x
mul r0.x, r2.w, c8.w
mov_pp r1.y, r1.x
cmp r0.y, r0, c13.x, r0.z
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c12.w, r3.w
max_pp r0.x, r0, c13.w
mad r0.y, r0, c11.z, c11.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 72 ALU, 5 TEX
PARAM c[20] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
MAD R2.xyz, R2, c[17].y, -c[17].x;
DP3 R4.z, R2, R2;
RSQ R4.z, R4.z;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyw, R0.xyzz, R0.w;
MOV R5.z, c[17].x;
DP4 R4.x, R5.xywz, c[0];
DP4 R0.w, R5.xywz, c[2];
DP4 R3.w, R5.xywz, c[1];
MUL R2.xyz, R4.z, R2;
MOV R0.z, R0.w;
MOV R0.x, R4;
MOV R0.y, R3.w;
ADD R3.xyz, R0, -c[12];
ADD R5.xyz, R0, -c[9];
DP3 R1.w, R3, R3;
RSQ R6.x, R1.w;
DP3 R4.y, R5, R5;
MUL R1.w, R1, c[12];
MUL R1.xyz, R6.x, R3;
RSQ R4.y, R4.y;
MAD R5.xyz, -R4.y, R5, -R1;
DP3 R4.y, R5, R5;
RSQ R4.y, R4.y;
MUL R5.xyz, R4.y, R5;
DP3 R4.y, R5, R2;
MAX R6.y, R4, c[17].z;
MOV R4.y, R3.w;
TEX R3, R3, texture[3], CUBE;
MOV R4.z, R0.w;
MOV R4.w, c[17].x;
DP4 R3.y, R3, c[19];
DP4 R5.z, R4, c[6];
DP4 R5.x, R4, c[4];
DP4 R5.y, R4, c[5];
RCP R4.x, R6.x;
MUL R3.x, R4, c[10].w;
MAD R3.y, -R3.x, c[18].x, R3;
MOV R3.x, c[17];
TEX R1.w, R1.w, texture[2], 2D;
CMP R3.x, R3.y, c[14], R3;
MUL R3.x, R1.w, R3;
MUL R1.w, R2, c[17];
TEX R0.w, R5, texture[4], CUBE;
MUL R0.w, R3.x, R0;
MOV_SAT R2.w, R0;
POW R1.w, R6.y, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[16];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[18].yzww;
DP3 R0.x, R0, c[13];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.w, R0;
MAD R0.y, R0, c[16].w, R5.w;
MAX R0.x, R0, c[17].z;
MAD R0.y, R0, c[15].z, c[15].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL result.color, R1, R0.y;
END
# 72 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 70 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.97000003, 0, 0
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
mad r0.w, r0.x, c11.x, c11.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
texld r1, r1, s0
mov r3.z, c17.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r5.x, r3.xywz, c0
dp4 r0.w, r3.xywz, c2
dp4 r6.x, r3.xywz, c1
mov r2.z, r0.w
mov r2.x, r5
mov r2.y, r6.x
add r0.xyz, r2, -c12
dp3 r2.w, r0, r0
add r4.xyz, r2, -c9
dp3 r5.y, r4, r4
rsq r6.y, r5.y
rsq r4.w, r2.w
mad_pp r5.yzw, r1.xxyz, c17.y, c17.z
mul r3.xyz, r4.w, r0
mad r1.xyz, -r6.y, r4, -r3
dp3_pp r4.x, r5.yzww, r5.yzww
dp3 r4.y, r1, r1
rsq r6.y, r4.y
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5.yzww
mul r1.xyz, r6.y, r1
dp3_pp r1.x, r1, r4
mov_pp r5.w, c17.x
mul_pp r5.y, r1.w, c18.x
max_pp r5.z, r1.x, c17.w
pow_pp r1, r5.z, r5.y
mov_pp r5.y, r6.x
mov_pp r5.z, r0.w
mov_pp r1.y, r1.x
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r5, r0, s3
rcp r0.x, r4.w
mul r0.x, r0, c10.w
dp4 r0.y, r5, c19
mad r0.y, -r0.x, c18, r0
mov r0.z, c14.x
mul r0.x, r2.w, c12.w
cmp r0.y, r0, c17.x, r0.z
texld r0.x, r0.x, s2
mul r0.x, r0, r0.y
texld r0.w, r6, s4
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c16
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mad r0.y, r0, c15.z, c15.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c17.x
mul r1.xyz, r0.x, c13
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 89 ALU, 8 TEX
PARAM c[26] = { program.local[0..23],
		{ 1, 2, 0, 128 },
		{ 0.25, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R4.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R4, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MOV R1.w, c[24].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[24].x;
DP4 R0.y, R2.xywz, c[1];
DP4 R1.x, R2.xywz, c[0];
DP4 R2.z, R2.xywz, c[2];
MOV R1.y, R0;
MOV R1.z, R2;
DP4 R0.x, R1, c[11];
DP4 R4.z, R1, c[8];
DP4 R4.w, R1, c[9];
RCP R3.w, R0.x;
MAD R0.zw, R3.w, R4, c[23].xyxy;
TEX R0.x, R0.zwzw, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[22];
MOV R0.w, R0.x;
TEX R0.x, R2, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[21];
MOV R0.z, R0.x;
TEX R0.x, R2, texture[4], 2D;
MOV R2.y, R0;
MOV R2.x, R1;
ADD R3.xyz, -R2, c[19];
MOV R0.y, R0.x;
DP3 R0.x, R3, R3;
MAD R3.xy, R3.w, R4.zwzw, c[20];
RSQ R3.z, R0.x;
TEX R0.x, R3, texture[4], 2D;
DP4 R3.y, R1, c[10];
DP4 R4.w, R1, c[7];
RCP R3.x, R3.z;
MAD R0, -R3.y, R3.w, R0;
ADD R3.y, -R2.w, R3.x;
MAD R2.w, R3.y, c[19], R2;
MOV R3.x, c[24];
CMP R0, R0, c[17].x, R3.x;
DP4 R3.y, R1, c[5];
DP4 R0.x, R0, c[25].x;
MAD_SAT R3.x, R2.w, c[17].z, c[17].w;
ADD_SAT R4.z, R0.x, R3.x;
DP4 R3.x, R1, c[4];
ADD R0.xyz, -R2, c[15];
DP3 R3.w, R0, R0;
MUL R1.y, R3.w, c[15].w;
MOV R3.z, R4.w;
TXP R0.w, R3.xyzz, texture[2], 2D;
SLT R1.x, R4.w, c[24].z;
TEX R1.w, R1.y, texture[3], 2D;
MUL R0.w, R0, R1.x;
MUL R0.w, R0, R1;
MUL R1.w, R0, R4.z;
ADD R1.xyz, R2, -c[13];
RSQ R0.w, R3.w;
MUL R2.xyz, R0.w, R0;
TEX R0, R4, texture[0], 2D;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MAD R1.xyz, -R3.x, R1, R2;
MAD R0.xyz, R0, c[24].y, -c[24].x;
DP3 R3.y, R0, R0;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MUL R1.xyz, R3.x, R1;
RSQ R3.y, R3.y;
MUL R0.xyz, R3.y, R0;
DP3 R1.x, R1, R0;
DP3 R0.x, R2, R0;
MUL R1.y, R0.w, c[24].w;
MAX R0.w, R1.x, c[24].z;
POW R0.w, R0.w, R1.y;
MOV_SAT R3.x, R1.w;
MOV R1.xyz, c[25].yzww;
MAX R0.x, R0, c[24].z;
DP3 R1.x, R1, c[16];
MUL R0.w, R0, R3.x;
MUL R0.w, R0, R1.x;
MAD R0.y, R2.w, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[24];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[16];
MUL result.color, R0, R1.x;
END
# 89 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 84 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c25, 128.00000000, 0.25000000, 0, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r4.xy, v0, r0.x
texld r0.x, r4, s1
texld r4, r4, s0
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mad r0.x, r0, c14, c14.y
mov r1.z, c24.x
mul r2.xyz, v1, r0.y
rcp r0.x, r0.x
mul r1.xyw, r2.xyzz, r0.x
dp4 r0.z, r1.xywz, c2
dp4 r0.x, r1.xywz, c0
dp4 r0.y, r1.xywz, c1
mov r3.z, r0
mov r3.x, r0
mov r3.y, r0
add r1.xyz, -r3, c15
add r2.xyz, r3, -c13
dp3 r2.w, r1, r1
rsq r0.w, r2.w
mul r1.xyz, r0.w, r1
dp3 r0.w, r2, r2
add r3.xyz, -r3, c19
rsq r0.w, r0.w
mad r5.xyz, -r0.w, r2, r1
dp3 r2.x, r5, r5
mad_pp r4.xyz, r4, c24.y, c24.z
dp3_pp r0.w, r4, r4
dp3 r3.x, r3, r3
rsq r3.w, r2.x
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r4
mov r0.w, c24.x
mul r4.xyz, r3.w, r5
dp4 r3.w, r0, c11
dp3_pp r4.x, r4, r2
dp4 r6.w, r0, c9
dp4 r6.z, r0, c8
rcp r3.w, r3.w
mad r5.xy, r3.w, r6.zwzw, c23
mad r6.xy, r3.w, r6.zwzw, c21
max_pp r5.z, r4.x, c24.w
mul_pp r5.w, r4, c25.x
pow_pp r4, r5.z, r5.w
rsq r4.y, r3.x
texld r5.x, r5, s4
mov r5.w, r5.x
mad r5.xy, r3.w, r6.zwzw, c22
texld r5.x, r5, s4
texld r6.x, r6, s4
mov r5.y, r6.x
rcp r4.y, r4.y
add r4.y, -r1.w, r4
dp4 r3.x, r0, c10
mad r1.w, r4.y, c19, r1
mov r5.z, r5.x
mad r6.xy, r3.w, r6.zwzw, c20
texld r5.x, r6, s4
mov r4.z, c17.x
mad r3, -r3.x, r3.w, r5
cmp r3, r3, c24.x, r4.z
dp4_pp r3.y, r3, c25.y
dp4 r4.z, r0, c7
mad_sat r3.x, r1.w, c17.z, c17.w
add_sat r4.y, r3, r3.x
dp4 r3.x, r0, c4
dp4 r3.z, r0, c6
dp4 r3.y, r0, c5
mul r0.x, r2.w, c15.w
mov r3.w, r4.z
texldp r0.w, r3, s2
cmp r0.y, r4.z, c24.w, c24.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r3.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.y, c26, r0
dp3_pp r0.x, r1, r2
mov_sat r2.w, r3.x
mov_pp r0.w, r4.x
mul r0.w, r0, r2
mul r2.w, r0, r0.y
max_pp r0.y, r0.x, c24.w
mad r0.x, r1.w, c18.z, c18.w
mul r0.y, r3.x, r0
add_sat r0.x, -r0, c24
mul r2.xyz, r0.y, c16
mul_pp oC0, r2, r0.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 85 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c25, 0.00000000, 1.00000000, 0.25000000, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r7.xy, v0, r0.x
texld r0.x, r7, s1
mad r0.w, r0.x, c14.x, c14.y
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mov r2.w, c25.y
mov r1.z, c25.y
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r1.xyw, r0.xyzz, r0.w
dp4 r0.w, r1.xywz, c2
dp4 r2.x, r1.xywz, c0
dp4 r3.y, r1.xywz, c1
mov r2.y, r3
mov r2.z, r0.w
dp4 r0.x, r2, c11
rcp r4.w, r0.x
dp4 r6.z, r2, c10
dp4 r6.y, r2, c9
dp4 r6.x, r2, c8
mad r0.xyz, r6, r4.w, c23
mov r3.z, r0.w
mov r3.x, r2
add r4.xyz, -r3, c15
texld r0.x, r0, s4
add r1.xyz, r3, -c13
dp3 r3.w, r4, r4
rsq r0.z, r3.w
dp3 r0.y, r1, r1
mul r4.xyz, r0.z, r4
rsq r0.y, r0.y
mad r5.xyz, -r0.y, r1, r4
mad r1.xyz, r6, r4.w, c21
mov_pp r0.w, r0.x
mad r0.xyz, r6, r4.w, c22
texld r0.x, r0, s4
texld r1.x, r1, s4
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, r6, r4.w, c20
mov r0.x, c17
add r4.w, c25.y, -r0.x
texld r0.x, r1, s4
mad r0, r0, r4.w, c17.x
dp4_pp r4.w, r0, c25.z
dp3 r1.x, r5, r5
add r0.xyz, -r3, c19
rsq r0.w, r1.x
mul r1.xyz, r0.w, r5
dp3 r3.x, r0, r0
texld r0, r7, s0
rsq r3.x, r3.x
rcp r3.y, r3.x
mad_pp r0.xyz, r0, c24.x, c24.y
add r3.z, -r1.w, r3.y
dp3_pp r3.x, r0, r0
rsq_pp r3.y, r3.x
mul_pp r0.xyz, r3.y, r0
dp3_pp r1.x, r1, r0
mad r3.x, r3.z, c19.w, r1.w
dp3_pp r0.x, r4, r0
mad_sat r1.w, r3.x, c17.z, c17
add_sat r3.y, r4.w, r1.w
dp4 r4.w, r2, c7
mul_pp r0.w, r0, c24
max_pp r3.z, r1.x, c24
pow_pp r1, r3.z, r0.w
cmp r1.y, r4.w, c25.x, c25
dp4 r5.z, r2, c6
dp4 r5.x, r2, c4
dp4 r5.y, r2, c5
mov r5.w, r4
texldp r0.w, r5, s2
mul r2.x, r3.w, c15.w
mul r0.w, r0, r1.y
texld r2.x, r2.x, s3
mul r0.w, r0, r2.x
mul r1.w, r0, r3.y
mov_pp r2.x, r1
mov_sat r0.w, r1
mov_pp r1.xyz, c16
max_pp r0.x, r0, c24.z
dp3_pp r1.x, c26, r1
mul r0.w, r2.x, r0
mul r0.w, r0, r1.x
mad r0.y, r3.x, c18.z, c18.w
add_sat r1.x, -r0.y, c25.y
mul r0.x, r1.w, r0
mul r0.xyz, r0.x, c16
mul_pp oC0, r0, r1.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 72 ALU, 7 TEX
PARAM c[17] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyz, R0, R0.w;
MOV R4.w, c[13].x;
DP4 R0.z, R4, c[2];
DP4 R0.x, R4, c[0];
DP4 R0.y, R4, c[1];
ADD R5.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R5, R5;
RSQ R2.w, R0.w;
DP3 R3.w, R3, R3;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.x, R1, R1;
RSQ R4.x, R4.x;
ADD R6.xyz, R5, c[14].zyzw;
MUL R0.w, R0, c[8];
MUL R2.xyz, R2.w, R5;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
MUL R1.xyz, R4.x, R1;
DP3 R3.x, R3, R1;
RCP R3.y, R2.w;
TEX R6, R6, texture[3], CUBE;
MAX R2.w, R3.x, c[13].z;
MUL R4.x, R3.y, c[6].w;
ADD R3.xyz, R5, c[14].yzzw;
TEX R3, R3, texture[3], CUBE;
DP4 R3.w, R3, c[15];
DP4 R3.z, R6, c[15];
ADD R6.xyz, R5, c[14].zzyw;
ADD R5.xyz, R5, c[14].y;
TEX R6, R6, texture[3], CUBE;
TEX R5, R5, texture[3], CUBE;
MUL R1.w, R1, c[13];
POW R1.w, R2.w, R1.w;
ADD R0.xyz, -R0, c[12];
DP4 R3.y, R6, c[15];
DP4 R3.x, R5, c[15];
MOV R4.y, c[13].x;
MAD R3, -R4.x, c[14].x, R3;
CMP R3, R3, c[10].x, R4.y;
DP4 R3.x, R3, c[14].w;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R3.x;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.z, R0;
MAD R0.y, R0, c[12].w, R4.z;
MAX R0.x, R0, c[13].z;
MAD R0.y, R0, c[11].z, c[11].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL result.color, R1, R0.y;
END
# 72 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 68 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r4.z, c13.x
mad r0.w, r1.x, c7.x, c7.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r4.xyw, r1.xyzz, r0.z
texld r0, r0, s0
dp4 r2.z, r4.xywz, c2
dp4 r2.x, r4.xywz, c0
dp4 r2.y, r4.xywz, c1
add r3.xyz, r2, -c8
add r1.xyz, r2, -c5
dp3 r3.w, r1, r1
dp3 r2.w, r3, r3
rsq r1.w, r2.w
mul r4.xyz, r1.w, r3
mad_pp r5.xyz, r0, c13.y, c13.z
rsq r3.w, r3.w
mad r0.xyz, -r3.w, r1, -r4
dp3_pp r1.y, r5, r5
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r5.xyz, r1.y, r5
dp3_pp r0.x, r0, r5
mul_pp r0.y, r0.w, c14.x
max_pp r0.x, r0, c13.w
pow_pp r6, r0.x, r0.y
rcp r0.x, r1.w
mul r5.w, r0.x, c6
add r0.xyz, r3, c14.yzzw
texld r0, r0, s3
add r1.xyz, r3, c14.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c15
dp4 r0.z, r1, c15
add r1.xyz, r3, c14.y
texld r1, r1, s3
dp4 r0.x, r1, c15
add r7.xyz, r3, c14.zzyw
texld r3, r7, s3
dp4 r0.y, r3, c15
mad r0, -r5.w, c14.w, r0
mov r1.x, c10
cmp r1, r0, c13.x, r1.x
mul r0.x, r2.w, c8.w
dp4_pp r0.y, r1, c16.x
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_pp r1.y, r6.x
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r4.w, r0
dp3_pp r0.x, -r4, r5
mad r0.y, r0, c12.w, r4.w
max_pp r0.x, r0, c13.w
mad r0.y, r0, c11.z, c11.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp oC0, r1, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 83 ALU, 8 TEX
PARAM c[21] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MOV R3.z, c[17].x;
TEX R5, R1, texture[0], 2D;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
DP4 R6.w, R3.xywz, c[0];
DP4 R2.w, R3.xywz, c[2];
DP4 R7.x, R3.xywz, c[1];
MOV R2.z, R2.w;
MOV R2.x, R6.w;
MOV R2.y, R7.x;
ADD R6.xyz, R2, -c[12];
DP3 R7.y, R6, R6;
RSQ R0.w, R7.y;
ADD R0.xyz, R2, -c[9];
DP3 R1.z, R0, R0;
RSQ R1.w, R1.z;
MUL R3.xyz, R0.w, R6;
MAD R1.xyz, R5, c[17].y, -c[17].x;
MAD R0.xyz, -R1.w, R0, -R3;
DP3 R4.x, R1, R1;
DP3 R1.w, R0, R0;
RSQ R4.x, R4.x;
MUL R5.xyz, R4.x, R1;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R0.x, R0, R5;
ADD R1.xyz, R6, c[18].yzzw;
TEX R1, R1, texture[3], CUBE;
RCP R0.y, R0.w;
DP4 R4.w, R1, c[19];
ADD R1.xyz, R6, c[18].y;
TEX R1, R1, texture[3], CUBE;
DP4 R4.x, R1, c[19];
MAX R7.z, R0.x, c[17];
MUL R7.w, R0.y, c[10];
ADD R0.xyz, R6, c[18].zyzw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.z, R0, c[19];
ADD R0.xyz, R6, c[18].zzyw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.y, R0, c[19];
MOV R6.x, R7;
MOV R6.z, c[17].x;
MOV R6.y, R2.w;
MOV R1.x, c[17];
MAD R0, -R7.w, c[18].x, R4;
CMP R0, R0, c[14].x, R1.x;
DP4 R0.x, R0, c[18].w;
MUL R1.x, R7.y, c[12].w;
TEX R0.w, R1.x, texture[2], 2D;
MUL R1.x, R0.w, R0;
DP4 R0.z, R6.wxyz, c[6];
DP4 R0.x, R6.wxyz, c[4];
DP4 R0.y, R6.wxyz, c[5];
TEX R0.w, R0, texture[4], CUBE;
MUL R0.w, R1.x, R0;
MUL R0.x, R5.w, c[17].w;
POW R1.x, R7.z, R0.x;
MOV_SAT R1.y, R0.w;
MUL R1.x, R1, R1.y;
ADD R0.xyz, -R2, c[16];
DP3 R1.y, R0, R0;
MOV R0.xyz, c[20];
DP3 R0.x, R0, c[13];
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, -R3, R5;
MAD R0.y, R0, c[16].w, R3.w;
MAX R0.x, R0, c[17].z;
MAD R0.y, R0, c[15].z, c[15].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL result.color, R1, R0.y;
END
# 83 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 78 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c17.x
mad r0.w, r1.x, c11.x, c11.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r7.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
texld r0, r0, s0
mov r2.z, r2.w
mov r2.x, r7
mov r2.y, r4.w
add r5.xyz, r2, -c12
add r1.xyz, r2, -c9
dp3 r4.x, r1, r1
dp3 r7.y, r5, r5
rsq r1.w, r7.y
rsq r5.w, r4.x
mul r3.xyz, r1.w, r5
mad_pp r4.xyz, r0, c17.y, c17.z
mad r0.xyz, -r5.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c18.x
max_pp r0.x, r0, c17.w
rcp r0.z, r1.w
pow_pp r6, r0.x, r0.y
mul r6.y, r0.z, c10.w
add r0.xyz, r5, c18.yzzw
texld r0, r0, s3
add r1.xyz, r5, c18.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c19
dp4 r0.z, r1, c19
add r1.xyz, r5, c18.y
texld r1, r1, s3
dp4 r0.x, r1, c19
add r8.xyz, r5, c18.zzyw
texld r5, r8, s3
dp4 r0.y, r5, c19
mov_pp r7.w, c17.x
mov_pp r7.z, r2.w
mov r1.x, c14
mad r0, -r6.y, c18.w, r0
cmp r0, r0, c17.x, r1.x
dp4_pp r0.y, r0, c20.x
mul r0.x, r7.y, c12.w
mov_pp r7.y, r4.w
texld r0.x, r0.x, s2
dp4 r1.x, r7, c4
dp4 r1.y, r7, c5
dp4 r1.z, r7, c6
texld r0.w, r1, s4
mul r0.x, r0, r0.y
mul r1.x, r0, r0.w
mov_pp r1.y, r6.x
mov_sat r0.w, r1.x
add r0.xyz, -r2, c16
mul r0.w, r1.y, r0
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20.yzww, r0
mul r0.w, r0, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mad r0.y, r0, c15.z, c15.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c17
mul r0.xyz, r0.x, c13
mul_pp oC0, r0, r1.x
"
}
}
 }
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
"3.0-!!ARBvp1.0
# 17 ALU
PARAM c[10] = { { 0, 0.5, -1, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
ABS R0.z, vertex.normal;
DP4 R0.w, vertex.position, c[8];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP4 R2.z, vertex.position, c[3];
DP4 R2.x, vertex.position, c[1];
DP4 R2.y, vertex.position, c[2];
MAD R3.xyz, -R2, c[0].zzww, vertex.normal;
SLT R0.z, c[0].x, R0;
MUL R2.xyz, R2, c[0].zzww;
MAD result.texcoord[1].xyz, R0.z, R3, R2;
DP4 R0.z, vertex.position, c[7];
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
"vs_3_0
; 18 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
def c10, 0.50000000, -1.00000000, 1.00000000, 0.00000000
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c10.x
mul r1.y, r1, c8.x
dp4 r2.z, v0, c2
dp4 r2.x, v0, c0
dp4 r2.y, v0, c1
mad r3.xyz, -r2, c10.yyzw, v1
mul r2.xyz, r2, c10.yyzw
slt r1.w, c10, v1.z
slt r0.z, v1, c10.w
add r0.z, r0, r1.w
mad o2.xyz, r0.z, r3, r2
dp4 r0.z, v0, c6
mad o1.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o1.zw, r0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 53 ALU, 3 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R4.xyz, R1, R0.z;
MOV R4.w, c[11].x;
DP4 R1.z, R4, c[2];
DP4 R1.x, R4, c[0];
DP4 R1.y, R4, c[1];
ADD R2.xyz, R1, -c[7];
ADD R3.xyz, R1, -c[5];
DP3 R1.w, R2, R2;
RSQ R0.z, R1.w;
MUL R2.xyz, R0.z, R2;
TEX R0, R0, texture[0], 2D;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
MAD R3.xyz, -R2.w, R3, -R2;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R3.w, R0, R0;
DP3 R2.w, R3, R3;
RSQ R2.w, R2.w;
RSQ R3.w, R3.w;
MUL R0.xyz, R3.w, R0;
MUL R3.xyz, R2.w, R3;
DP3 R2.w, R3, R0;
DP3 R0.x, -R2, R0;
MUL R3.x, R1.w, c[7].w;
MUL R1.w, R0, c[11];
MAX R2.w, R2, c[11].z;
TEX R0.w, R3.x, texture[2], 2D;
POW R1.w, R2.w, R1.w;
MOV_SAT R2.w, R0;
MAX R0.x, R0, c[11].z;
MUL R1.w, R1, R2;
ADD R1.xyz, -R1, c[10];
DP3 R2.w, R1, R1;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RSQ R2.w, R2.w;
RCP R1.y, R2.w;
MUL R1.w, R1, R1.x;
ADD R1.x, -R4.z, R1.y;
MAD R0.y, R1.x, c[10].w, R4.z;
MAD R0.y, R0, c[9].z, c[9].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[11].x;
MUL R1.xyz, R0.x, c[8];
MUL result.color, R1.wxyz, R0.y;
END
# 53 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightPos]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
"ps_3_0
; 53 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c11.x
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r1.xyz, r2, -c5
dp3 r1.w, r1, r1
add r3.xyz, r2, -c7
dp3 r2.w, r3, r3
rsq r0.z, r2.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c11.y, c11.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c12.x
max_pp r0.x, r0, c11.w
pow_pp r1, r0.x, r0.y
mov_pp r0.z, r1.x
mul r0.x, r2.w, c7.w
texld r0.x, r0.x, s2
mov_sat r0.y, r0.x
mul r0.y, r0.z, r0
add r1.xyz, -r2, c10
dp3 r0.z, r1, r1
rsq r0.w, r0.z
mov_pp r1.xyz, c8
dp3_pp r0.z, c12.yzww, r1
rcp r1.x, r0.w
mul r0.w, r0.y, r0.z
add r0.z, -r3.w, r1.x
dp3_pp r0.y, -r3, r4
max_pp r0.y, r0, c11.w
mad r0.z, r0, c10.w, r3.w
mad r0.z, r0, c9, c9.w
add_sat r1.x, -r0.z, c11
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, c8
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"3.0-!!ARBfp1.0
# 44 ALU, 2 TEX
PARAM c[13] = { program.local[0..10],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R0.xy, fragment.texcoord[0], R0.x;
TEX R1.x, R0, texture[1], 2D;
RCP R0.z, fragment.texcoord[1].z;
MAD R0.w, R1.x, c[6].x, c[6].y;
MUL R0.z, R0, c[4];
MUL R1.xyz, fragment.texcoord[1], R0.z;
RCP R0.z, R0.w;
MUL R3.xyz, R1, R0.z;
MOV R3.w, c[11].x;
TEX R0, R0, texture[0], 2D;
MAD R0.xyz, R0, c[11].y, -c[11].x;
DP3 R2.w, R0, R0;
RSQ R2.w, R2.w;
MUL R0.xyz, R2.w, R0;
DP4 R1.z, R3, c[2];
DP4 R1.x, R3, c[0];
DP4 R1.y, R3, c[1];
ADD R2.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[10];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MAD R2.xyz, -R1.w, R2, -c[7];
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
MUL R2.xyz, R1.w, R2;
DP3 R1.w, R2, R0;
DP3 R0.x, R0, -c[7];
MAX R1.w, R1, c[11].z;
MUL R0.w, R0, c[11];
DP3 R1.x, R1, R1;
POW R0.w, R1.w, R0.w;
RSQ R1.w, R1.x;
MOV R1.xyz, c[12];
DP3 R1.x, R1, c[8];
RCP R1.w, R1.w;
MUL R0.w, R0, R1.x;
ADD R1.y, -R3.z, R1.w;
MAD R1.x, R1.y, c[10].w, R3.z;
MAD R0.y, R1.x, c[9].z, c[9].w;
ADD_SAT R1.x, -R0.y, c[11];
MAX R0.x, R0, c[11].z;
MUL R0.xyz, R0.x, c[8];
MUL result.color, R0.wxyz, R1.x;
END
# 44 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [unity_LightmapFade]
Vector 10 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
"ps_3_0
; 45 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c11, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c12, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mad r0.w, r1.x, c6.x, c6.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyz, r1, r0.z
mov r3.w, c11.x
texld r0, r0, s0
mad_pp r0.xyz, r0, c11.y, c11.z
dp3_pp r2.w, r0, r0
rsq_pp r2.w, r2.w
mul_pp r0.xyz, r2.w, r0
dp4 r1.z, r3, c2
dp4 r1.x, r3, c0
dp4 r1.y, r3, c1
add r2.xyz, r1, -c5
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
rsq r1.w, r1.w
mul r2.xyz, r1.w, r2
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
mul_pp r3.x, r0.w, c12
max_pp r0.w, r1, c11
pow_pp r2, r0.w, r3.x
add r1.xyz, -r1, c10
dp3 r0.w, r1, r1
mov_pp r1.w, r2.x
rsq r0.w, r0.w
mov_pp r1.xyz, c8
rcp r2.x, r0.w
dp3_pp r0.w, c12.yzww, r1
add r1.x, -r3.z, r2
mad r1.x, r1, c10.w, r3.z
mad r0.y, r1.x, c9.z, c9.w
add_sat r1.x, -r0.y, c11
max_pp r0.x, r0, c11.w
mul r0.w, r1, r0
mul r0.xyz, r0.x, c8
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
# 66 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[15].x;
DP4 R3.x, R2.xywz, c[0];
DP4 R3.y, R2.xywz, c[1];
DP4 R0.w, R2.xywz, c[2];
MOV R0.z, R0.w;
MOV R0.x, R3;
MOV R0.y, R3;
ADD R2.xyz, -R0, c[11];
ADD R4.xyz, R0, -c[9];
DP3 R4.w, R2, R2;
RSQ R1.z, R4.w;
MUL R2.xyz, R1.z, R2;
TEX R1, R1, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, R2;
MAD R1.xyz, R1, c[15].y, -c[15].x;
DP3 R3.w, R1, R1;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R1.xyz, R3.w, R1;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R4.x, R4, R1;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
DP4 R5.y, R3, c[7];
MAX R5.x, R4, c[15].z;
MUL R1.w, R1, c[15];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
MOV R4.z, R5.y;
TXP R0.w, R4.xyzz, texture[2], 2D;
SLT R3.x, R5.y, c[15].z;
MUL R3.x, R0.w, R3;
MUL R3.y, R4.w, c[11].w;
TEX R0.w, R3.y, texture[3], 2D;
MUL R0.w, R3.x, R0;
MOV_SAT R3.x, R0.w;
POW R1.w, R5.x, R1.w;
MUL R1.w, R1, R3.x;
ADD R0.xyz, -R0, c[14];
DP3 R3.x, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, R2, R1;
RSQ R3.x, R3.x;
RCP R0.y, R3.x;
ADD R0.y, -R2.w, R0;
MAD R0.y, R0, c[14].w, R2.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1.wxyz, R0.y;
END
# 66 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 65 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.x, r3.xywz, c0
dp4 r2.z, r3.xywz, c2
dp4 r2.y, r3.xywz, c1
mov r1.x, r2
mov r1.z, r2
mov r1.y, r2
add r4.xyz, r1, -c9
add r3.xyz, -r1, c11
dp3 r2.w, r4, r4
dp3 r1.w, r3, r3
rsq r0.z, r1.w
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r5.xyz, r0, c15.y, c15.z
rsq r2.w, r2.w
mad r0.xyz, -r2.w, r4, r3
dp3_pp r4.x, r5, r5
dp3 r2.w, r0, r0
rsq r2.w, r2.w
mul r0.xyz, r2.w, r0
mov r2.w, c15.x
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
dp4 r4.w, r2, c7
max_pp r0.y, r0, c15.w
pow_pp r5, r0.y, r0.x
dp4 r0.z, r2, c6
dp4 r0.x, r2, c4
dp4 r0.y, r2, c5
mov r0.w, r4
texldp r0.w, r0, s2
mul r0.x, r1.w, c11.w
cmp r0.y, r4.w, c15.w, c15.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.w, r0.y, r0.x
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
mad r0.y, r0, c14.w, r3.w
mad r0.y, r0, c13.z, c13.w
mov_sat r1.w, r0
mov_pp r2.x, r5
mul r1.x, r2, r1.w
mul r1.w, r1.x, r0.x
dp3_pp r0.x, r3, r4
max_pp r0.x, r0, c15.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 64 ALU, 4 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyw, R0.xyzz, R0.w;
MOV R4.z, c[15].x;
DP4 R3.x, R4.xywz, c[0];
DP4 R0.w, R4.xywz, c[2];
DP4 R1.w, R4.xywz, c[1];
MOV R0.z, R0.w;
MOV R0.y, R1.w;
MOV R0.x, R3;
ADD R1.xyz, R0, -c[11];
DP3 R3.y, R1, R1;
ADD R4.xyz, R0, -c[9];
RSQ R2.z, R3.y;
MUL R1.xyz, R2.z, R1;
TEX R2, R2, texture[0], 2D;
DP3 R3.z, R4, R4;
RSQ R3.z, R3.z;
MAD R4.xyz, -R3.z, R4, -R1;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R3.w, R2, R2;
DP3 R3.z, R4, R4;
RSQ R3.w, R3.w;
MUL R2.xyz, R3.w, R2;
RSQ R3.z, R3.z;
MUL R4.xyz, R3.z, R4;
DP3 R3.z, R4, R2;
MAX R5.x, R3.z, c[15].z;
MUL R5.y, R3, c[11].w;
MOV R3.y, R1.w;
MOV R3.z, R0.w;
MOV R3.w, c[15].x;
TEX R1.w, R5.y, texture[2], 2D;
MUL R2.w, R2, c[15];
ADD R0.xyz, -R0, c[14];
DP4 R4.z, R3, c[6];
DP4 R4.x, R3, c[4];
DP4 R4.y, R3, c[5];
TEX R0.w, R4, texture[3], CUBE;
MUL R0.w, R1, R0;
POW R1.w, R5.x, R2.w;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[12];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.w, R0;
MAD R0.y, R0, c[14].w, R4.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1.wxyz, R0.y;
END
# 64 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightPos]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 63 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r5.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
mov r2.z, r2.w
mov r2.x, r5
mov r2.y, r4.w
add r1.xyz, r2, -c9
dp3 r1.w, r1, r1
add r3.xyz, r2, -c11
dp3 r5.y, r3, r3
rsq r0.z, r5.y
mul r3.xyz, r0.z, r3
texld r0, r0, s0
mad_pp r4.xyz, r0, c15.y, c15.z
rsq r1.w, r1.w
mad r0.xyz, -r1.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.y, r0, r4
mul_pp r0.x, r0.w, c16
max_pp r0.y, r0, c15.w
pow_pp r1, r0.y, r0.x
mul r0.x, r5.y, c11.w
mov_pp r5.y, r4.w
mov_pp r5.w, c15.x
mov_pp r5.z, r2.w
mov_pp r1.y, r1.x
texld r0.x, r0.x, s2
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r0.w, r6, s3
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c14
dp3 r1.y, r0, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c14.w, r3.w
max_pp r0.x, r0, c15.w
mad r0.y, r0, c13.z, c13.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 54 ALU, 3 TEX
PARAM c[17] = { program.local[0..14],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
MAD R2.xyz, R2, c[15].y, -c[15].x;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[15].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R1.z, R0;
MOV R1.x, R0;
MOV R1.y, R0;
ADD R3.xyz, R1, -c[9];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R3, -c[11];
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
MUL R3.xyz, R0.w, R3;
MUL R2.xyz, R1.w, R2;
DP3 R0.w, R3, R2;
MAX R1.w, R0, c[15].z;
MOV R0.w, c[15].x;
DP4 R3.y, R0, c[5];
DP4 R3.x, R0, c[4];
MUL R0.x, R2.w, c[15].w;
POW R1.w, R1.w, R0.x;
ADD R0.xyz, -R1, c[14];
DP3 R1.y, R0, R0;
TEX R0.w, R3, texture[2], 2D;
MOV R0.xyz, c[16];
MOV_SAT R2.w, R0;
DP3 R0.x, R0, c[12];
MUL R1.x, R1.w, R2.w;
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, R2, -c[11];
MAD R0.y, R0, c[14].w, R3.w;
MAX R0.x, R0, c[15].z;
MAD R0.y, R0, c[13].z, c[13].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[15].x;
MUL R1.xyz, R0.x, c[12];
MUL result.color, R1.wxyz, R0.y;
END
# 54 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [unity_LightmapFade]
Vector 14 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 56 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c15, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c16, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c15.x
mad r0.w, r1.x, c10.x, c10.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r3.x, r2.xywz, c0
dp4 r1.w, r2.xywz, c2
dp4 r4.x, r2.xywz, c1
texld r0, r0, s0
mov r1.z, r1.w
mov r1.x, r3
mov r1.y, r4.x
add r2.xyz, r1, -c9
dp3 r3.y, r2, r2
rsq r4.y, r3.y
mad_pp r3.yzw, r0.xxyz, c15.y, c15.z
mad r0.xyz, -r4.y, r2, -c11
dp3_pp r2.x, r3.yzww, r3.yzww
dp3 r2.y, r0, r0
rsq r4.y, r2.y
rsq_pp r2.x, r2.x
mul_pp r2.xyz, r2.x, r3.yzww
mul r0.xyz, r4.y, r0
dp3_pp r0.x, r0, r2
mul_pp r3.y, r0.w, c16.x
max_pp r3.z, r0.x, c15.w
pow_pp r0, r3.z, r3.y
mov_pp r3.y, r4.x
mov_pp r3.z, r1.w
mov_pp r3.w, c15.x
dp4 r4.x, r3, c4
dp4 r4.y, r3, c5
texld r0.w, r4, s2
mov_pp r3.x, r0
add r0.xyz, -r1, c14
dp3 r1.y, r0, r0
mov_sat r1.w, r0
mov_pp r0.xyz, c12
dp3_pp r0.x, c16.yzww, r0
mul r1.x, r3, r1.w
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r2.w, r0
dp3_pp r0.x, r2, -c11
mad r0.y, r0, c14.w, r2.w
max_pp r0.x, r0, c15.w
mad r0.y, r0, c13.z, c13.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c15.x
mul r1.xyz, r0.x, c12
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 79 ALU, 5 TEX
PARAM c[22] = { program.local[0..19],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.zw, fragment.texcoord[0].xyxy, R0.x;
TEX R0.x, R1.zwzw, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[20].x;
DP4 R1.x, R5, c[0];
DP4 R1.y, R5, c[1];
DP4 R0.w, R5, c[2];
MOV R0.z, R0.w;
MOV R0.x, R1;
MOV R0.y, R1;
ADD R2.xyz, -R0, c[15];
ADD R4.xyz, R0, -c[13];
ADD R0.xyz, -R0, c[19];
DP3 R0.x, R0, R0;
DP3 R2.w, R2, R2;
RSQ R3.x, R2.w;
MUL R2.xyz, R3.x, R2;
TEX R3, R1.zwzw, texture[0], 2D;
DP3 R4.w, R4, R4;
RSQ R1.z, R4.w;
MAD R4.xyz, -R1.z, R4, R2;
MAD R3.xyz, R3, c[20].y, -c[20].x;
DP3 R1.w, R3, R3;
DP3 R1.z, R4, R4;
RSQ R1.w, R1.w;
MUL R3.xyz, R1.w, R3;
RSQ R1.z, R1.z;
MUL R4.xyz, R1.z, R4;
DP3 R4.x, R4, R3;
MOV R1.z, R0.w;
MOV R1.w, c[20].x;
DP4 R0.w, R1, c[7];
MAX R4.w, R4.x, c[20].z;
DP4 R4.x, R1, c[4];
DP4 R0.y, R1, c[9];
DP4 R4.y, R1, c[5];
SLT R5.x, R0.w, c[20].z;
MOV R4.z, R0.w;
TXP R0.w, R4.xyzz, texture[2], 2D;
MUL R4.x, R0.w, R5;
MUL R0.w, R2, c[15];
DP4 R2.w, R1, c[11];
TEX R0.w, R0.w, texture[3], 2D;
MUL R0.w, R4.x, R0;
RSQ R0.x, R0.x;
RCP R4.x, R0.x;
DP4 R0.x, R1, c[8];
MOV R0.z, R2.w;
TXP R0.x, R0.xyzz, texture[4], 2D;
DP4 R0.y, R1, c[10];
RCP R0.z, R2.w;
MAD R0.y, -R0, R0.z, R0.x;
ADD R4.x, -R5.z, R4;
MAD R1.x, R4, c[19].w, R5.z;
MOV R0.x, c[20];
MAD_SAT R0.z, R1.x, c[17], c[17].w;
CMP R0.x, R0.y, c[17], R0;
ADD_SAT R0.y, R0.x, R0.z;
MUL R1.y, R0.w, R0;
MUL R0.x, R3.w, c[20].w;
POW R0.w, R4.w, R0.x;
MOV R0.xyz, c[21];
DP3 R0.x, R0, c[16];
MOV_SAT R1.z, R1.y;
MUL R0.w, R0, R1.z;
DP3 R0.y, R2, R3;
MUL R0.w, R0, R0.x;
MAX R0.x, R0.y, c[20].z;
MAD R0.y, R1.x, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[20];
MUL R0.x, R1.y, R0;
MUL R0.xyz, R0.x, c[16];
MUL result.color, R0.wxyz, R1.x;
END
# 79 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 80 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c21, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c20.x
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.y, c20.z
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.w
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c21.x
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c20.x
mov r1.z, r5.x
dp4 r4.z, r1, c10
dp4 r4.w, r1, c11
rsq r4.y, r0.x
dp4 r0.y, r1, c9
mov r0.z, r4
dp4 r0.x, r1, c8
mov r0.w, r4
texldp r0.x, r0, s4
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
rcp r0.y, r4.w
mad r0.x, -r4.z, r0.y, r0
dp4 r4.z, r1, c7
mov r0.y, c17.x
cmp r0.x, r0, c20, r0.y
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c20.w, c20.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c21.yzww, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
dp3_pp r0.y, r2, r3
mul r0.w, r0, r0.x
max_pp r0.x, r0.y, c20.w
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c20
mul r0.xyz, r0.x, c16
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 77 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c20, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c21, 0.00000000, 1.00000000, 0, 0
def c22, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r2.z, c21.y
mad r0.w, r1.x, c14.x, c14.y
mul r0.z, r0, c12
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r2.xyw, r1.xyzz, r0.z
dp4 r1.x, r2.xywz, c0
dp4 r5.x, r2.xywz, c2
dp4 r5.y, r2.xywz, c1
mov r4.x, r1
mov r4.z, r5.x
mov r4.y, r5
add r3.xyz, r4, -c13
dp3 r1.y, r3, r3
add r2.xyz, -r4, c15
dp3 r3.w, r2, r2
rsq r0.z, r3.w
mul r2.xyz, r0.z, r2
texld r0, r0, s0
rsq r4.w, r1.y
mad_pp r1.yzw, r0.xxyz, c20.x, c20.y
mad r0.xyz, -r4.w, r3, r2
dp3_pp r3.x, r1.yzww, r1.yzww
dp3 r3.y, r0, r0
rsq r4.w, r3.y
rsq_pp r3.x, r3.x
mul_pp r3.xyz, r3.x, r1.yzww
mul r0.xyz, r4.w, r0
dp3_pp r0.x, r0, r3
max_pp r1.y, r0.x, c20.z
add r0.xyz, -r4, c19
mul_pp r0.w, r0, c20
pow_pp r4, r1.y, r0.w
mov r1.y, r5
dp3 r0.x, r0, r0
mov r1.w, c21.y
mov r1.z, r5.x
rsq r4.y, r0.x
dp4 r0.w, r1, c11
dp4 r0.z, r1, c10
dp4 r0.y, r1, c9
dp4 r0.x, r1, c8
texldp r0.x, r0, s4
dp4 r4.z, r1, c7
rcp r0.z, r4.y
add r0.z, -r2.w, r0
mad r2.w, r0.z, c19, r2
mov r0.y, c17.x
add r0.y, c21, -r0
mad r0.x, r0, r0.y, c17
mad_sat r0.y, r2.w, c17.z, c17.w
add_sat r4.y, r0.x, r0
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mov r0.w, r4.z
texldp r0.w, r0, s2
mul r0.x, r3.w, c15.w
cmp r0.y, r4.z, c21.x, c21
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r1.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.x, c22, r0
mov_sat r0.w, r1.x
mov_pp r1.y, r4.x
mul r0.w, r1.y, r0
dp3_pp r0.y, r2, r3
mul r0.w, r0, r0.x
max_pp r0.x, r0.y, c20.z
mad r0.y, r2.w, c18.z, c18.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c21.y
mul r0.xyz, r0.x, c16
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 49 ALU, 3 TEX
PARAM c[14] = { program.local[0..11],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
RCP R0.x, fragment.texcoord[0].w;
MUL R3.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R3, texture[1], 2D;
MAD R0.w, R0.x, c[6].x, c[6].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MOV R2.z, c[12].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
DP4 R1.z, R2.xywz, c[2];
DP4 R1.x, R2.xywz, c[0];
DP4 R1.y, R2.xywz, c[1];
ADD R0.xyz, R1, -c[5];
ADD R1.xyz, -R1, c[11];
DP3 R1.x, R1, R1;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MAD R2.xyz, -R0.w, R0, -c[7];
TEX R0, R3, texture[0], 2D;
DP3 R1.w, R2, R2;
RSQ R1.w, R1.w;
RSQ R1.y, R1.x;
RCP R1.y, R1.y;
ADD R1.z, -R2.w, R1.y;
MUL R1.y, R0.w, c[12].w;
MUL R2.xyz, R1.w, R2;
MAD R0.xyz, R0, c[12].y, -c[12].x;
DP3 R1.w, R0, R0;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R1.x, R2, R0;
DP3 R0.x, R0, -c[7];
MAD R0.w, R1.z, c[11], R2;
MAX R1.x, R1, c[12].z;
POW R1.w, R1.x, R1.y;
MAD R0.y, R0.w, c[10].z, c[10].w;
MAD_SAT R1.y, R0.w, c[9].z, c[9].w;
TEX R1.x, R3, texture[2], 2D;
ADD_SAT R2.x, R1, R1.y;
MOV R1.xyz, c[13];
MAX R0.x, R0, c[12].z;
DP3 R1.x, R1, c[8];
MUL R1.w, R1, R2.x;
MUL R1.w, R1, R1.x;
MUL R0.x, R2, R0;
ADD_SAT R0.y, -R0, c[12].x;
MUL R1.xyz, R0.x, c[8];
MUL result.color, R1.wxyz, R0.y;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_ZBufferParams]
Vector 7 [_LightDir]
Vector 8 [_LightColor]
Vector 9 [_LightShadowData]
Vector 10 [unity_LightmapFade]
Vector 11 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 49 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c12, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c13, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c6.x, c6.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r2.z, c12.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r1.z, r2.xywz, c2
dp4 r1.x, r2.xywz, c0
dp4 r1.y, r2.xywz, c1
add r2.xyz, r1, -c5
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c7
dp3 r1.w, r2, r2
add r1.xyz, -r1, c11
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c12.y, c12.z
rsq r3.z, r1.w
dp3_pp r3.w, r0, r0
rsq_pp r1.w, r3.w
mul r2.xyz, r3.z, r2
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c7
rsq r1.x, r1.x
max_pp r2.x, r1.w, c12.w
mul_pp r0.w, r0, c13.x
rcp r2.y, r1.x
pow_pp r1, r2.x, r0.w
mov_pp r1.w, r1.x
add r0.w, -r2, r2.y
mad r0.w, r0, c11, r2
mad r0.y, r0.w, c10.z, c10.w
mad_sat r1.y, r0.w, c9.z, c9.w
texld r1.x, r3, s2
add_sat r2.x, r1, r1.y
mov_pp r1.xyz, c8
max_pp r0.x, r0, c12.w
dp3_pp r1.x, c13.yzww, r1
mul r1.w, r1, r2.x
mul r1.w, r1, r1.x
mul r0.x, r2, r0
add_sat r0.y, -r0, c12.x
mul r1.xyz, r0.x, c8
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
# 58 ALU, 4 TEX
PARAM c[18] = { program.local[0..15],
		{ 1, 2, 0, 128 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
MAD R0.w, R0.x, c[10].x, c[10].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
MOV R3.z, c[16].x;
DP4 R0.z, R3.xywz, c[2];
DP4 R0.x, R3.xywz, c[0];
DP4 R0.y, R3.xywz, c[1];
MOV R4.z, R0;
MOV R4.x, R0;
MOV R4.y, R0;
ADD R1.xyz, R4, -c[9];
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MAD R3.xyz, -R0.w, R1, -c[11];
TEX R1, R2, texture[0], 2D;
DP3 R0.w, R3, R3;
RSQ R0.w, R0.w;
ADD R4.xyz, -R4, c[15];
DP3 R2.z, R4, R4;
RSQ R2.z, R2.z;
RCP R2.z, R2.z;
MUL R3.xyz, R0.w, R3;
MAD R1.xyz, R1, c[16].y, -c[16].x;
DP3 R0.w, R1, R1;
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, R1;
DP3 R0.w, R3, R1;
ADD R2.z, -R3.w, R2;
MAX R3.y, R0.w, c[16].z;
MOV R0.w, c[16].x;
MAD R3.x, R2.z, c[15].w, R3.w;
DP4 R2.z, R0, c[4];
DP4 R2.w, R0, c[5];
TEX R0.x, R2, texture[2], 2D;
MAD_SAT R0.y, R3.x, c[13].z, c[13].w;
ADD_SAT R0.y, R0.x, R0;
MUL R0.x, R1.w, c[16].w;
TEX R0.w, R2.zwzw, texture[3], 2D;
MUL R1.w, R0.y, R0;
POW R0.w, R3.y, R0.x;
MOV R0.xyz, c[17];
DP3 R0.x, R0, c[12];
MOV_SAT R2.x, R1.w;
MUL R0.w, R0, R2.x;
DP3 R0.y, R1, -c[11];
MUL R0.w, R0, R0.x;
MAX R0.x, R0.y, c[16].z;
MAD R0.y, R3.x, c[14].z, c[14].w;
ADD_SAT R1.x, -R0.y, c[16];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[12];
MUL result.color, R0.wxyz, R1.x;
END
# 58 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_ZBufferParams]
Vector 11 [_LightDir]
Vector 12 [_LightColor]
Vector 13 [_LightShadowData]
Vector 14 [unity_LightmapFade]
Vector 15 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 58 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c16, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c17, 128.00000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r3.xy, v0, r0.x
texld r0.x, r3, s1
mad r0.w, r0.x, c10.x, c10.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
mov r2.z, c16.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r2.xyw, r0.xyzz, r0.w
dp4 r4.x, r2.xywz, c0
dp4 r3.z, r2.xywz, c2
dp4 r3.w, r2.xywz, c1
mov r1.z, r3
mov r1.x, r4
mov r1.y, r3.w
add r2.xyz, r1, -c9
dp3 r0.x, r2, r2
rsq r1.w, r0.x
texld r0, r3, s0
mad r2.xyz, -r1.w, r2, -c11
dp3 r1.w, r2, r2
rsq r4.y, r1.w
mul r2.xyz, r4.y, r2
add r1.xyz, -r1, c15
dp3 r1.x, r1, r1
mad_pp r0.xyz, r0, c16.y, c16.z
dp3_pp r4.z, r0, r0
rsq_pp r1.w, r4.z
mul_pp r0.xyz, r1.w, r0
dp3_pp r1.w, r2, r0
dp3_pp r0.x, r0, -c11
rsq r1.x, r1.x
max_pp r2.x, r1.w, c16.w
rcp r2.y, r1.x
mul_pp r0.w, r0, c17.x
pow_pp r1, r2.x, r0.w
add r0.w, -r2, r2.y
mad r1.y, r0.w, c15.w, r2.w
mov_pp r4.y, r3.w
mov_pp r4.w, c16.x
mov_pp r4.z, r3
dp4 r2.x, r4, c4
dp4 r2.y, r4, c5
texld r0.w, r2, s3
texld r2.x, r3, s2
mad_sat r1.z, r1.y, c13, c13.w
add_sat r1.z, r2.x, r1
mul r1.z, r1, r0.w
mov_sat r0.w, r1.z
max_pp r0.x, r0, c16.w
mul r0.w, r1.x, r0
mov_pp r2.xyz, c12
dp3_pp r1.x, c17.yzww, r2
mul r0.w, r0, r1.x
mad r0.y, r1, c14.z, c14.w
add_sat r1.x, -r0.y, c16
mul r0.x, r1.z, r0
mul r0.xyz, r0.x, c12
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 61 ALU, 4 TEX
PARAM c[16] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.w, R1, R1;
RSQ R4.w, R4.w;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyz, R0, R0.w;
MOV R5.w, c[13].x;
MUL R1.xyz, R4.w, R1;
DP4 R0.z, R5, c[2];
DP4 R0.x, R5, c[0];
DP4 R0.y, R5, c[1];
ADD R4.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R4, R4;
RSQ R2.w, R0.w;
MUL R2.xyz, R2.w, R4;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
DP3 R3.x, R3, R1;
MAX R4.w, R3.x, c[13].z;
TEX R3, R4, texture[3], CUBE;
RCP R2.w, R2.w;
MUL R0.w, R0, c[8];
MUL R1.w, R1, c[13];
MUL R2.w, R2, c[6];
DP4 R3.x, R3, c[15];
MAD R3.x, -R2.w, c[14], R3;
MOV R2.w, c[13].x;
CMP R2.w, R3.x, c[10].x, R2;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R2;
MOV_SAT R2.w, R0;
POW R1.w, R4.w, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[12];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[14].yzww;
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.z, R0;
MAD R0.y, R0, c[12].w, R5.z;
MAX R0.x, R0, c[13].z;
MAD R0.y, R0, c[11].z, c[11].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL result.color, R1.wxyz, R0.y;
END
# 61 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 60 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.97000003, 0, 0
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
texld r1, r1, s0
mad r0.w, r0.x, c7.x, c7.y
rcp r0.y, v1.z
mul r0.y, r0, c4.z
mov r3.z, c13.x
mad_pp r5.xyz, r1, c13.y, c13.z
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r2.z, r3.xywz, c2
dp4 r2.x, r3.xywz, c0
dp4 r2.y, r3.xywz, c1
add r4.xyz, r2, -c5
dp3 r0.w, r4, r4
add r0.xyz, r2, -c8
dp3 r2.w, r0, r0
rsq r4.w, r2.w
mul r3.xyz, r4.w, r0
rsq r0.w, r0.w
mad r1.xyz, -r0.w, r4, -r3
dp3_pp r4.x, r5, r5
dp3 r0.w, r1, r1
rsq r0.w, r0.w
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5
mul r1.xyz, r0.w, r1
dp3_pp r0.w, r1, r4
max_pp r0.w, r0, c13
mul_pp r5.x, r1.w, c14
pow_pp r1, r0.w, r5.x
texld r0, r0, s3
dp4 r0.y, r0, c15
rcp r1.y, r4.w
mul r0.x, r1.y, c6.w
mad r0.y, -r0.x, c14, r0
mov r0.z, c10.x
mul r0.x, r2.w, c8.w
mov_pp r1.y, r1.x
cmp r0.y, r0, c13.x, r0.z
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c12.w, r3.w
max_pp r0.x, r0, c13.w
mad r0.y, r0, c11.z, c11.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 72 ALU, 5 TEX
PARAM c[20] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.2199707, 0.70703125, 0.070983887 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R2.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R2, texture[1], 2D;
TEX R2, R2, texture[0], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
MAD R2.xyz, R2, c[17].y, -c[17].x;
DP3 R4.z, R2, R2;
RSQ R4.z, R4.z;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R5.xyw, R0.xyzz, R0.w;
MOV R5.z, c[17].x;
DP4 R4.x, R5.xywz, c[0];
DP4 R0.w, R5.xywz, c[2];
DP4 R3.w, R5.xywz, c[1];
MUL R2.xyz, R4.z, R2;
MOV R0.z, R0.w;
MOV R0.x, R4;
MOV R0.y, R3.w;
ADD R3.xyz, R0, -c[12];
ADD R5.xyz, R0, -c[9];
DP3 R1.w, R3, R3;
RSQ R6.x, R1.w;
DP3 R4.y, R5, R5;
MUL R1.w, R1, c[12];
MUL R1.xyz, R6.x, R3;
RSQ R4.y, R4.y;
MAD R5.xyz, -R4.y, R5, -R1;
DP3 R4.y, R5, R5;
RSQ R4.y, R4.y;
MUL R5.xyz, R4.y, R5;
DP3 R4.y, R5, R2;
MAX R6.y, R4, c[17].z;
MOV R4.y, R3.w;
TEX R3, R3, texture[3], CUBE;
MOV R4.z, R0.w;
MOV R4.w, c[17].x;
DP4 R3.y, R3, c[19];
DP4 R5.z, R4, c[6];
DP4 R5.x, R4, c[4];
DP4 R5.y, R4, c[5];
RCP R4.x, R6.x;
MUL R3.x, R4, c[10].w;
MAD R3.y, -R3.x, c[18].x, R3;
MOV R3.x, c[17];
TEX R1.w, R1.w, texture[2], 2D;
CMP R3.x, R3.y, c[14], R3;
MUL R3.x, R1.w, R3;
MUL R1.w, R2, c[17];
TEX R0.w, R5, texture[4], CUBE;
MUL R0.w, R3.x, R0;
MOV_SAT R2.w, R0;
POW R1.w, R6.y, R1.w;
MUL R1.w, R1, R2;
ADD R0.xyz, -R0, c[16];
DP3 R2.w, R0, R0;
MOV R0.xyz, c[18].yzww;
DP3 R0.x, R0, c[13];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R1, R2;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R5.w, R0;
MAD R0.y, R0, c[16].w, R5.w;
MAX R0.x, R0, c[17].z;
MAD R0.y, R0, c[15].z, c[15].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL result.color, R1.wxyz, R0.y;
END
# 72 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 70 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.97000003, 0, 0
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r1.xy, v0, r0.x
texld r0.x, r1, s1
mad r0.w, r0.x, c11.x, c11.y
rcp r0.y, v1.z
mul r0.y, r0, c8.z
texld r1, r1, s0
mov r3.z, c17.x
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r3.xyw, r0.xyzz, r0.w
dp4 r5.x, r3.xywz, c0
dp4 r0.w, r3.xywz, c2
dp4 r6.x, r3.xywz, c1
mov r2.z, r0.w
mov r2.x, r5
mov r2.y, r6.x
add r0.xyz, r2, -c12
dp3 r2.w, r0, r0
add r4.xyz, r2, -c9
dp3 r5.y, r4, r4
rsq r6.y, r5.y
rsq r4.w, r2.w
mad_pp r5.yzw, r1.xxyz, c17.y, c17.z
mul r3.xyz, r4.w, r0
mad r1.xyz, -r6.y, r4, -r3
dp3_pp r4.x, r5.yzww, r5.yzww
dp3 r4.y, r1, r1
rsq r6.y, r4.y
rsq_pp r4.x, r4.x
mul_pp r4.xyz, r4.x, r5.yzww
mul r1.xyz, r6.y, r1
dp3_pp r1.x, r1, r4
mov_pp r5.w, c17.x
mul_pp r5.y, r1.w, c18.x
max_pp r5.z, r1.x, c17.w
pow_pp r1, r5.z, r5.y
mov_pp r5.y, r6.x
mov_pp r5.z, r0.w
mov_pp r1.y, r1.x
dp4 r6.z, r5, c6
dp4 r6.x, r5, c4
dp4 r6.y, r5, c5
texld r5, r0, s3
rcp r0.x, r4.w
mul r0.x, r0, c10.w
dp4 r0.y, r5, c19
mad r0.y, -r0.x, c18, r0
mov r0.z, c14.x
mul r0.x, r2.w, c12.w
cmp r0.y, r0, c17.x, r0.z
texld r0.x, r0.x, s2
mul r0.x, r0, r0.y
texld r0.w, r6, s4
mul r0.w, r0.x, r0
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c16
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mad r0.y, r0, c15.z, c15.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c17.x
mul r1.xyz, r0.x, c13
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
# 89 ALU, 8 TEX
PARAM c[26] = { program.local[0..23],
		{ 1, 2, 0, 128 },
		{ 0.25, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
RCP R0.x, fragment.texcoord[0].w;
MUL R4.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R4, texture[1], 2D;
MAD R0.w, R0.x, c[14].x, c[14].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[12].z;
MOV R1.w, c[24].x;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R2.xyw, R0.xyzz, R0.w;
MOV R2.z, c[24].x;
DP4 R0.y, R2.xywz, c[1];
DP4 R1.x, R2.xywz, c[0];
DP4 R2.z, R2.xywz, c[2];
MOV R1.y, R0;
MOV R1.z, R2;
DP4 R0.x, R1, c[11];
DP4 R4.z, R1, c[8];
DP4 R4.w, R1, c[9];
RCP R3.w, R0.x;
MAD R0.zw, R3.w, R4, c[23].xyxy;
TEX R0.x, R0.zwzw, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[22];
MOV R0.w, R0.x;
TEX R0.x, R2, texture[4], 2D;
MAD R2.xy, R3.w, R4.zwzw, c[21];
MOV R0.z, R0.x;
TEX R0.x, R2, texture[4], 2D;
MOV R2.y, R0;
MOV R2.x, R1;
ADD R3.xyz, -R2, c[19];
MOV R0.y, R0.x;
DP3 R0.x, R3, R3;
MAD R3.xy, R3.w, R4.zwzw, c[20];
RSQ R3.z, R0.x;
TEX R0.x, R3, texture[4], 2D;
DP4 R3.y, R1, c[10];
DP4 R4.w, R1, c[7];
RCP R3.x, R3.z;
MAD R0, -R3.y, R3.w, R0;
ADD R3.y, -R2.w, R3.x;
MAD R2.w, R3.y, c[19], R2;
MOV R3.x, c[24];
CMP R0, R0, c[17].x, R3.x;
DP4 R3.y, R1, c[5];
DP4 R0.x, R0, c[25].x;
MAD_SAT R3.x, R2.w, c[17].z, c[17].w;
ADD_SAT R4.z, R0.x, R3.x;
DP4 R3.x, R1, c[4];
ADD R0.xyz, -R2, c[15];
DP3 R3.w, R0, R0;
MUL R1.y, R3.w, c[15].w;
MOV R3.z, R4.w;
TXP R0.w, R3.xyzz, texture[2], 2D;
SLT R1.x, R4.w, c[24].z;
TEX R1.w, R1.y, texture[3], 2D;
MUL R0.w, R0, R1.x;
MUL R0.w, R0, R1;
MUL R1.w, R0, R4.z;
ADD R1.xyz, R2, -c[13];
RSQ R0.w, R3.w;
MUL R2.xyz, R0.w, R0;
TEX R0, R4, texture[0], 2D;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MAD R1.xyz, -R3.x, R1, R2;
MAD R0.xyz, R0, c[24].y, -c[24].x;
DP3 R3.y, R0, R0;
DP3 R3.x, R1, R1;
RSQ R3.x, R3.x;
MUL R1.xyz, R3.x, R1;
RSQ R3.y, R3.y;
MUL R0.xyz, R3.y, R0;
DP3 R1.x, R1, R0;
DP3 R0.x, R2, R0;
MUL R1.y, R0.w, c[24].w;
MAX R0.w, R1.x, c[24].z;
POW R0.w, R0.w, R1.y;
MOV_SAT R3.x, R1.w;
MOV R1.xyz, c[25].yzww;
MAX R0.x, R0, c[24].z;
DP3 R1.x, R1, c[16];
MUL R0.w, R0, R3.x;
MUL R0.w, R0, R1.x;
MAD R0.y, R2.w, c[18].z, c[18].w;
ADD_SAT R1.x, -R0.y, c[24];
MUL R0.x, R1.w, R0;
MUL R0.xyz, R0.x, c[16];
MUL result.color, R0.wxyz, R1.x;
END
# 89 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 84 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c25, 128.00000000, 0.25000000, 0, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r4.xy, v0, r0.x
texld r0.x, r4, s1
texld r4, r4, s0
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mad r0.x, r0, c14, c14.y
mov r1.z, c24.x
mul r2.xyz, v1, r0.y
rcp r0.x, r0.x
mul r1.xyw, r2.xyzz, r0.x
dp4 r0.z, r1.xywz, c2
dp4 r0.x, r1.xywz, c0
dp4 r0.y, r1.xywz, c1
mov r3.z, r0
mov r3.x, r0
mov r3.y, r0
add r1.xyz, -r3, c15
add r2.xyz, r3, -c13
dp3 r2.w, r1, r1
rsq r0.w, r2.w
mul r1.xyz, r0.w, r1
dp3 r0.w, r2, r2
add r3.xyz, -r3, c19
rsq r0.w, r0.w
mad r5.xyz, -r0.w, r2, r1
dp3 r2.x, r5, r5
mad_pp r4.xyz, r4, c24.y, c24.z
dp3_pp r0.w, r4, r4
dp3 r3.x, r3, r3
rsq r3.w, r2.x
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, r4
mov r0.w, c24.x
mul r4.xyz, r3.w, r5
dp4 r3.w, r0, c11
dp3_pp r4.x, r4, r2
dp4 r6.w, r0, c9
dp4 r6.z, r0, c8
rcp r3.w, r3.w
mad r5.xy, r3.w, r6.zwzw, c23
mad r6.xy, r3.w, r6.zwzw, c21
max_pp r5.z, r4.x, c24.w
mul_pp r5.w, r4, c25.x
pow_pp r4, r5.z, r5.w
rsq r4.y, r3.x
texld r5.x, r5, s4
mov r5.w, r5.x
mad r5.xy, r3.w, r6.zwzw, c22
texld r5.x, r5, s4
texld r6.x, r6, s4
mov r5.y, r6.x
rcp r4.y, r4.y
add r4.y, -r1.w, r4
dp4 r3.x, r0, c10
mad r1.w, r4.y, c19, r1
mov r5.z, r5.x
mad r6.xy, r3.w, r6.zwzw, c20
texld r5.x, r6, s4
mov r4.z, c17.x
mad r3, -r3.x, r3.w, r5
cmp r3, r3, c24.x, r4.z
dp4_pp r3.y, r3, c25.y
dp4 r4.z, r0, c7
mad_sat r3.x, r1.w, c17.z, c17.w
add_sat r4.y, r3, r3.x
dp4 r3.x, r0, c4
dp4 r3.z, r0, c6
dp4 r3.y, r0, c5
mul r0.x, r2.w, c15.w
mov r3.w, r4.z
texldp r0.w, r3, s2
cmp r0.y, r4.z, c24.w, c24.x
mul r0.y, r0.w, r0
texld r0.x, r0.x, s3
mul r0.x, r0.y, r0
mul r3.x, r0, r4.y
mov_pp r0.xyz, c16
dp3_pp r0.y, c26, r0
dp3_pp r0.x, r1, r2
mov_sat r2.w, r3.x
mov_pp r0.w, r4.x
mul r0.w, r0, r2
mul r2.w, r0, r0.y
max_pp r0.y, r0.x, c24.w
mad r0.x, r1.w, c18.z, c18.w
mul r0.y, r3.x, r0
add_sat r0.x, -r0, c24
mul r2.xyz, r0.y, c16
mul_pp oC0, r2.wxyz, r0.x
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Matrix 8 [unity_World2Shadow]
Vector 12 [_ProjectionParams]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_ZBufferParams]
Vector 15 [_LightPos]
Vector 16 [_LightColor]
Vector 17 [_LightShadowData]
Vector 18 [unity_LightmapFade]
Vector 19 [unity_ShadowFadeCenterAndType]
Vector 20 [_ShadowOffsets0]
Vector 21 [_ShadowOffsets1]
Vector 22 [_ShadowOffsets2]
Vector 23 [_ShadowOffsets3]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 85 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c24, 2.00000000, -1.00000000, 0.00000000, 128.00000000
def c25, 0.00000000, 1.00000000, 0.25000000, 0
def c26, 0.21997070, 0.70703125, 0.07098389, 0
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r7.xy, v0, r0.x
texld r0.x, r7, s1
mad r0.w, r0.x, c14.x, c14.y
rcp r0.y, v1.z
mul r0.y, r0, c12.z
mov r2.w, c25.y
mov r1.z, c25.y
mul r0.xyz, v1, r0.y
rcp r0.w, r0.w
mul r1.xyw, r0.xyzz, r0.w
dp4 r0.w, r1.xywz, c2
dp4 r2.x, r1.xywz, c0
dp4 r3.y, r1.xywz, c1
mov r2.y, r3
mov r2.z, r0.w
dp4 r0.x, r2, c11
rcp r4.w, r0.x
dp4 r6.z, r2, c10
dp4 r6.y, r2, c9
dp4 r6.x, r2, c8
mad r0.xyz, r6, r4.w, c23
mov r3.z, r0.w
mov r3.x, r2
add r4.xyz, -r3, c15
texld r0.x, r0, s4
add r1.xyz, r3, -c13
dp3 r3.w, r4, r4
rsq r0.z, r3.w
dp3 r0.y, r1, r1
mul r4.xyz, r0.z, r4
rsq r0.y, r0.y
mad r5.xyz, -r0.y, r1, r4
mad r1.xyz, r6, r4.w, c21
mov_pp r0.w, r0.x
mad r0.xyz, r6, r4.w, c22
texld r0.x, r0, s4
texld r1.x, r1, s4
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, r6, r4.w, c20
mov r0.x, c17
add r4.w, c25.y, -r0.x
texld r0.x, r1, s4
mad r0, r0, r4.w, c17.x
dp4_pp r4.w, r0, c25.z
dp3 r1.x, r5, r5
add r0.xyz, -r3, c19
rsq r0.w, r1.x
mul r1.xyz, r0.w, r5
dp3 r3.x, r0, r0
texld r0, r7, s0
rsq r3.x, r3.x
rcp r3.y, r3.x
mad_pp r0.xyz, r0, c24.x, c24.y
add r3.z, -r1.w, r3.y
dp3_pp r3.x, r0, r0
rsq_pp r3.y, r3.x
mul_pp r0.xyz, r3.y, r0
dp3_pp r1.x, r1, r0
mad r3.x, r3.z, c19.w, r1.w
dp3_pp r0.x, r4, r0
mad_sat r1.w, r3.x, c17.z, c17
add_sat r3.y, r4.w, r1.w
dp4 r4.w, r2, c7
mul_pp r0.w, r0, c24
max_pp r3.z, r1.x, c24
pow_pp r1, r3.z, r0.w
cmp r1.y, r4.w, c25.x, c25
dp4 r5.z, r2, c6
dp4 r5.x, r2, c4
dp4 r5.y, r2, c5
mov r5.w, r4
texldp r0.w, r5, s2
mul r2.x, r3.w, c15.w
mul r0.w, r0, r1.y
texld r2.x, r2.x, s3
mul r0.w, r0, r2.x
mul r1.w, r0, r3.y
mov_pp r2.x, r1
mov_sat r0.w, r1
mov_pp r1.xyz, c16
max_pp r0.x, r0, c24.z
dp3_pp r1.x, c26, r1
mul r0.w, r2.x, r0
mul r0.w, r0, r1.x
mad r0.y, r3.x, c18.z, c18.w
add_sat r1.x, -r0.y, c25.y
mul r0.x, r1.w, r0
mul r0.xyz, r0.x, c16
mul_pp oC0, r0.wxyz, r1.x
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"3.0-!!ARBfp1.0
# 72 ALU, 7 TEX
PARAM c[17] = { program.local[0..12],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
TEX R1, R1, texture[0], 2D;
MAD R0.w, R0.x, c[7].x, c[7].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[4].z;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R4.xyz, R0, R0.w;
MOV R4.w, c[13].x;
DP4 R0.z, R4, c[2];
DP4 R0.x, R4, c[0];
DP4 R0.y, R4, c[1];
ADD R5.xyz, R0, -c[8];
ADD R3.xyz, R0, -c[5];
DP3 R0.w, R5, R5;
RSQ R2.w, R0.w;
DP3 R3.w, R3, R3;
MAD R1.xyz, R1, c[13].y, -c[13].x;
DP3 R4.x, R1, R1;
RSQ R4.x, R4.x;
ADD R6.xyz, R5, c[14].zyzw;
MUL R0.w, R0, c[8];
MUL R2.xyz, R2.w, R5;
RSQ R3.w, R3.w;
MAD R3.xyz, -R3.w, R3, -R2;
DP3 R3.w, R3, R3;
RSQ R3.w, R3.w;
MUL R3.xyz, R3.w, R3;
MUL R1.xyz, R4.x, R1;
DP3 R3.x, R3, R1;
RCP R3.y, R2.w;
TEX R6, R6, texture[3], CUBE;
MAX R2.w, R3.x, c[13].z;
MUL R4.x, R3.y, c[6].w;
ADD R3.xyz, R5, c[14].yzzw;
TEX R3, R3, texture[3], CUBE;
DP4 R3.w, R3, c[15];
DP4 R3.z, R6, c[15];
ADD R6.xyz, R5, c[14].zzyw;
ADD R5.xyz, R5, c[14].y;
TEX R6, R6, texture[3], CUBE;
TEX R5, R5, texture[3], CUBE;
MUL R1.w, R1, c[13];
POW R1.w, R2.w, R1.w;
ADD R0.xyz, -R0, c[12];
DP4 R3.y, R6, c[15];
DP4 R3.x, R5, c[15];
MOV R4.y, c[13].x;
MAD R3, -R4.x, c[14].x, R3;
CMP R3, R3, c[10].x, R4.y;
DP4 R3.x, R3, c[14].w;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R0, R3.x;
MOV_SAT R2.w, R0;
MUL R1.w, R1, R2;
DP3 R2.w, R0, R0;
MOV R0.xyz, c[16];
DP3 R0.x, R0, c[9];
MUL R1.w, R1, R0.x;
DP3 R0.x, -R2, R1;
RSQ R2.w, R2.w;
RCP R0.y, R2.w;
ADD R0.y, -R4.z, R0;
MAD R0.y, R0, c[12].w, R4.z;
MAX R0.x, R0, c[13].z;
MAD R0.y, R0, c[11].z, c[11].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[13].x;
MUL R1.xyz, R0.x, c[9];
MUL result.color, R1.wxyz, R0.y;
END
# 72 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Vector 4 [_ProjectionParams]
Vector 5 [_WorldSpaceCameraPos]
Vector 6 [_LightPositionRange]
Vector 7 [_ZBufferParams]
Vector 8 [_LightPos]
Vector 9 [_LightColor]
Vector 10 [_LightShadowData]
Vector 11 [unity_LightmapFade]
Vector 12 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
"ps_3_0
; 68 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c13, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c14, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c15, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c16, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r4.z, c13.x
mad r0.w, r1.x, c7.x, c7.y
mul r0.z, r0, c4
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r4.xyw, r1.xyzz, r0.z
texld r0, r0, s0
dp4 r2.z, r4.xywz, c2
dp4 r2.x, r4.xywz, c0
dp4 r2.y, r4.xywz, c1
add r3.xyz, r2, -c8
add r1.xyz, r2, -c5
dp3 r3.w, r1, r1
dp3 r2.w, r3, r3
rsq r1.w, r2.w
mul r4.xyz, r1.w, r3
mad_pp r5.xyz, r0, c13.y, c13.z
rsq r3.w, r3.w
mad r0.xyz, -r3.w, r1, -r4
dp3_pp r1.y, r5, r5
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r5.xyz, r1.y, r5
dp3_pp r0.x, r0, r5
mul_pp r0.y, r0.w, c14.x
max_pp r0.x, r0, c13.w
pow_pp r6, r0.x, r0.y
rcp r0.x, r1.w
mul r5.w, r0.x, c6
add r0.xyz, r3, c14.yzzw
texld r0, r0, s3
add r1.xyz, r3, c14.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c15
dp4 r0.z, r1, c15
add r1.xyz, r3, c14.y
texld r1, r1, s3
dp4 r0.x, r1, c15
add r7.xyz, r3, c14.zzyw
texld r3, r7, s3
dp4 r0.y, r3, c15
mad r0, -r5.w, c14.w, r0
mov r1.x, c10
cmp r1, r0, c13.x, r1.x
mul r0.x, r2.w, c8.w
dp4_pp r0.y, r1, c16.x
texld r0.x, r0.x, s2
mul r0.w, r0.x, r0.y
mov_pp r1.y, r6.x
mov_sat r1.x, r0.w
mul r1.x, r1.y, r1
add r0.xyz, -r2, c12
dp3 r1.y, r0, r0
mov_pp r0.xyz, c9
dp3_pp r0.x, c16.yzww, r0
mul r1.w, r1.x, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r4.w, r0
dp3_pp r0.x, -r4, r5
mad r0.y, r0, c12.w, r4.w
max_pp r0.x, r0, c13.w
mad r0.y, r0, c11.z, c11.w
mul r0.x, r0.w, r0
add_sat r0.y, -r0, c13.x
mul r1.xyz, r0.x, c9
mul_pp oC0, r1.wxyz, r0.y
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
# 83 ALU, 8 TEX
PARAM c[21] = { program.local[0..16],
		{ 1, 2, 0, 128 },
		{ 0.97000003, 0.0078125, -0.0078125, 0.25 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
RCP R0.x, fragment.texcoord[0].w;
MUL R1.xy, fragment.texcoord[0], R0.x;
TEX R0.x, R1, texture[1], 2D;
MAD R0.w, R0.x, c[11].x, c[11].y;
RCP R0.y, fragment.texcoord[1].z;
MUL R0.y, R0, c[8].z;
MOV R3.z, c[17].x;
TEX R5, R1, texture[0], 2D;
MUL R0.xyz, fragment.texcoord[1], R0.y;
RCP R0.w, R0.w;
MUL R3.xyw, R0.xyzz, R0.w;
DP4 R6.w, R3.xywz, c[0];
DP4 R2.w, R3.xywz, c[2];
DP4 R7.x, R3.xywz, c[1];
MOV R2.z, R2.w;
MOV R2.x, R6.w;
MOV R2.y, R7.x;
ADD R6.xyz, R2, -c[12];
DP3 R7.y, R6, R6;
RSQ R0.w, R7.y;
ADD R0.xyz, R2, -c[9];
DP3 R1.z, R0, R0;
RSQ R1.w, R1.z;
MUL R3.xyz, R0.w, R6;
MAD R1.xyz, R5, c[17].y, -c[17].x;
MAD R0.xyz, -R1.w, R0, -R3;
DP3 R4.x, R1, R1;
DP3 R1.w, R0, R0;
RSQ R4.x, R4.x;
MUL R5.xyz, R4.x, R1;
RSQ R1.w, R1.w;
MUL R0.xyz, R1.w, R0;
DP3 R0.x, R0, R5;
ADD R1.xyz, R6, c[18].yzzw;
TEX R1, R1, texture[3], CUBE;
RCP R0.y, R0.w;
DP4 R4.w, R1, c[19];
ADD R1.xyz, R6, c[18].y;
TEX R1, R1, texture[3], CUBE;
DP4 R4.x, R1, c[19];
MAX R7.z, R0.x, c[17];
MUL R7.w, R0.y, c[10];
ADD R0.xyz, R6, c[18].zyzw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.z, R0, c[19];
ADD R0.xyz, R6, c[18].zzyw;
TEX R0, R0, texture[3], CUBE;
DP4 R4.y, R0, c[19];
MOV R6.x, R7;
MOV R6.z, c[17].x;
MOV R6.y, R2.w;
MOV R1.x, c[17];
MAD R0, -R7.w, c[18].x, R4;
CMP R0, R0, c[14].x, R1.x;
DP4 R0.x, R0, c[18].w;
MUL R1.x, R7.y, c[12].w;
TEX R0.w, R1.x, texture[2], 2D;
MUL R1.x, R0.w, R0;
DP4 R0.z, R6.wxyz, c[6];
DP4 R0.x, R6.wxyz, c[4];
DP4 R0.y, R6.wxyz, c[5];
TEX R0.w, R0, texture[4], CUBE;
MUL R0.w, R1.x, R0;
MUL R0.x, R5.w, c[17].w;
POW R1.x, R7.z, R0.x;
MOV_SAT R1.y, R0.w;
MUL R1.x, R1, R1.y;
ADD R0.xyz, -R2, c[16];
DP3 R1.y, R0, R0;
MOV R0.xyz, c[20];
DP3 R0.x, R0, c[13];
MUL R1.w, R1.x, R0.x;
RSQ R1.y, R1.y;
RCP R0.y, R1.y;
ADD R0.y, -R3.w, R0;
DP3 R0.x, -R3, R5;
MAD R0.y, R0, c[16].w, R3.w;
MAX R0.x, R0, c[17].z;
MAD R0.y, R0, c[15].z, c[15].w;
MUL R0.x, R0.w, R0;
ADD_SAT R0.y, -R0, c[17].x;
MUL R1.xyz, R0.x, c[13];
MUL result.color, R1.wxyz, R0.y;
END
# 83 instructions, 8 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Matrix 0 [_CameraToWorld]
Matrix 4 [_LightMatrix0]
Vector 8 [_ProjectionParams]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_LightPositionRange]
Vector 11 [_ZBufferParams]
Vector 12 [_LightPos]
Vector 13 [_LightColor]
Vector 14 [_LightShadowData]
Vector 15 [unity_LightmapFade]
Vector 16 [unity_ShadowFadeCenterAndType]
SetTexture 0 [_CameraNormalsTexture] 2D
SetTexture 1 [_CameraDepthTexture] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_ShadowMapTexture] CUBE
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 78 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
dcl_cube s4
def c17, 1.00000000, 2.00000000, -1.00000000, 0.00000000
def c18, 128.00000000, 0.00781250, -0.00781250, 0.97000003
def c19, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c20, 0.25000000, 0.21997070, 0.70703125, 0.07098389
dcl_texcoord0 v0.xyzw
dcl_texcoord1 v1.xyz
rcp r0.x, v0.w
mul r0.xy, v0, r0.x
texld r1.x, r0, s1
rcp r0.z, v1.z
mov r3.z, c17.x
mad r0.w, r1.x, c11.x, c11.y
mul r0.z, r0, c8
mul r1.xyz, v1, r0.z
rcp r0.z, r0.w
mul r3.xyw, r1.xyzz, r0.z
dp4 r2.w, r3.xywz, c2
dp4 r7.x, r3.xywz, c0
dp4 r4.w, r3.xywz, c1
texld r0, r0, s0
mov r2.z, r2.w
mov r2.x, r7
mov r2.y, r4.w
add r5.xyz, r2, -c12
add r1.xyz, r2, -c9
dp3 r4.x, r1, r1
dp3 r7.y, r5, r5
rsq r1.w, r7.y
rsq r5.w, r4.x
mul r3.xyz, r1.w, r5
mad_pp r4.xyz, r0, c17.y, c17.z
mad r0.xyz, -r5.w, r1, -r3
dp3_pp r1.y, r4, r4
dp3 r1.x, r0, r0
rsq_pp r1.y, r1.y
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
mul_pp r4.xyz, r1.y, r4
dp3_pp r0.x, r0, r4
mul_pp r0.y, r0.w, c18.x
max_pp r0.x, r0, c17.w
rcp r0.z, r1.w
pow_pp r6, r0.x, r0.y
mul r6.y, r0.z, c10.w
add r0.xyz, r5, c18.yzzw
texld r0, r0, s3
add r1.xyz, r5, c18.zyzw
texld r1, r1, s3
dp4 r0.w, r0, c19
dp4 r0.z, r1, c19
add r1.xyz, r5, c18.y
texld r1, r1, s3
dp4 r0.x, r1, c19
add r8.xyz, r5, c18.zzyw
texld r5, r8, s3
dp4 r0.y, r5, c19
mov_pp r7.w, c17.x
mov_pp r7.z, r2.w
mov r1.x, c14
mad r0, -r6.y, c18.w, r0
cmp r0, r0, c17.x, r1.x
dp4_pp r0.y, r0, c20.x
mul r0.x, r7.y, c12.w
mov_pp r7.y, r4.w
texld r0.x, r0.x, s2
dp4 r1.x, r7, c4
dp4 r1.y, r7, c5
dp4 r1.z, r7, c6
texld r0.w, r1, s4
mul r0.x, r0, r0.y
mul r1.x, r0, r0.w
mov_pp r1.y, r6.x
mov_sat r0.w, r1.x
add r0.xyz, -r2, c16
mul r0.w, r1.y, r0
dp3 r1.y, r0, r0
mov_pp r0.xyz, c13
dp3_pp r0.x, c20.yzww, r0
mul r0.w, r0, r0.x
rsq r1.y, r1.y
rcp r0.y, r1.y
add r0.y, -r3.w, r0
dp3_pp r0.x, -r3, r4
mad r0.y, r0, c16.w, r3.w
max_pp r0.x, r0, c17.w
mad r0.y, r0, c15.z, c15.w
mul r0.x, r1, r0
add_sat r1.x, -r0.y, c17
mul r0.xyz, r0.x, c13
mul_pp oC0, r0.wxyz, r1.x
"
}
}
 }
}
Fallback Off
}