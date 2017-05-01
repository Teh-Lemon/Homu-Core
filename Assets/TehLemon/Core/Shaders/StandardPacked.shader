// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TehLemon/StandardPacked"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Color("Color", Color) = (0,0,0,0)
		_Albedo("Albedo", 2D) = "white" {}
		_PackedMaps("PackedMaps", 2D) = "white" {}
		_MetallicOffset("Metallic Offset", Float) = 0
		_SmoothnessScale("Smoothness Scale", Range( 0 , 1)) = 1
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_AOScale("AO Scale", Range( 0 , 1)) = 1
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_EmissionScale("EmissionScale", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform fixed _NormalScale;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform fixed4 _Color;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _PackedMaps;
		uniform float4 _PackedMaps_ST;
		uniform fixed4 _EmissionColor;
		uniform fixed _EmissionScale;
		uniform fixed _MetallicOffset;
		uniform fixed _SmoothnessScale;
		uniform fixed _AOScale;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackScaleNormal( tex2D( _Normal,uv_Normal) ,_NormalScale );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = ( _Color * tex2D( _Albedo,uv_Albedo) ).xyz;
			float2 uv_PackedMaps = i.uv_texcoord * _PackedMaps_ST.xy + _PackedMaps_ST.zw;
			fixed4 tex2DNode11 = tex2D( _PackedMaps,uv_PackedMaps);
			o.Emission = ( ( tex2DNode11.b * _EmissionColor ) * _EmissionScale ).rgb;
			o.Metallic = ( _MetallicOffset + tex2DNode11.r );
			o.Smoothness = ( tex2DNode11.a * _SmoothnessScale );
			o.Occlusion = lerp( 1.0 , tex2DNode11.g , _AOScale );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-1614;219;1498;928;1699.623;103.2208;1.6;True;True
Node;AmplifyShaderEditor.SamplerNode;11;-1186.319,462.6529;Float;True;Property;_PackedMaps;PackedMaps;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;193;-861.5206,848.8808;Float;False;Property;_EmissionColor;Emission Color;10;0;1,1,1,1;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-658.76,-201.7431;Float;True;Property;_Albedo;Albedo;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;6;-964.5748,9.198174;Float;False;Property;_NormalScale;Normal Scale;6;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;186;-826.3888,1144.413;Float;False;Property;_SmoothnessScale;Smoothness Scale;4;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;180;-648.3032,915.1805;Float;False;Property;_EmissionScale;EmissionScale;11;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;184;-619.9264,420.0796;Float;False;Property;_MetallicOffset;Metallic Offset;3;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;181;-564.6259,561.9792;Float;False;Constant;_Float1;Float 1;9;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;183;-692.6257,661.1801;Float;False;Property;_AOScale;AO Scale;9;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;190;-1001.521,986.481;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.ColorNode;176;-574.5095,-368.2206;Float;False;Property;_Color;Color;0;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-635.9217,786.4803;Float;False;0;FLOAT;0.0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-410.3211,775.2792;Float;True;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.LerpOp;182;-407.8261,549.1796;Float;True;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;185;-418.3268,319.2795;Float;True;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-254.5092,-173.0206;Float;False;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-514.3218,1064.881;Float;True;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-674.1623,15.66886;Float;True;Property;_Normal;Normal;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;119.6998,201.8002;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;Standard;TehLemon/StandardPacked;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;FLOAT3;False;1;FLOAT3;FLOAT3;False;2;FLOAT3;FLOAT3;False;3;FLOAT;0,0,0;False;4;FLOAT;FLOAT3;False;5;FLOAT;FLOAT3;False;6;FLOAT3;FLOAT;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;FLOAT;False;10;OBJECT;FLOAT3;False;11;FLOAT3;FLOAT,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;FLOAT;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;FLOAT;False
WireConnection;190;0;11;4
WireConnection;194;0;11;3
WireConnection;194;1;193;0
WireConnection;195;0;194;0
WireConnection;195;1;180;0
WireConnection;182;0;181;0
WireConnection;182;1;11;2
WireConnection;182;2;183;0
WireConnection;185;0;184;0
WireConnection;185;1;11;1
WireConnection;177;0;176;0
WireConnection;177;1;1;0
WireConnection;189;0;190;0
WireConnection;189;1;186;0
WireConnection;5;5;6;0
WireConnection;0;0;177;0
WireConnection;0;1;5;0
WireConnection;0;2;195;0
WireConnection;0;3;185;0
WireConnection;0;4;189;0
WireConnection;0;5;182;0
ASEEND*/
//CHKSM=19298989FA1721654285331C4780A0ECB8D11A90