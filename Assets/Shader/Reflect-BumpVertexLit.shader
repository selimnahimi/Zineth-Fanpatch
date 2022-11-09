//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Reflective/Bumped VertexLit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Spec Color", Color) = (1,1,1,1)
 _Shininess ("Shininess", Range(0.1,1)) = 0.7
 _ReflectColor ("Reflection Color", Color) = (1,1,1,0.5)
 _MainTex ("Base (RGB) RefStrength (A)", 2D) = "white" {}
 _Cube ("Reflection Cubemap", CUBE) = "" { TexGen CubeReflect }
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 LOD 250
 Tags { "RenderType"="Opaque" }
 UsePass "Reflective/Bumped Unlit/BASE"
 Pass {
  Tags { "LIGHTMODE"="Vertex" "RenderType"="Opaque" }
  Lighting On
  SeparateSpecular On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
   Emission [_Emission]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  SetTexture [_MainTex] { ConstantColor [_Color] combine texture * primary double, texture alpha * primary alpha }
 }
}
Fallback "Reflective/VertexLit"
}