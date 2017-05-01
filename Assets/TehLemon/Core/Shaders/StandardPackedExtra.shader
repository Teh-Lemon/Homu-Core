// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TehLemon/StandardPackedExtra"
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
		_HeightMap("HeightMap", 2D) = "white" {}
		_HeightScale("HeightScale", Range( 0 , 0.1)) = 0.02
		_AOScale("AO Scale", Range( 0 , 1)) = 1
		_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_EmissionScale("EmissionScale", Float) = 0
		_DetailAlbedox2("Detail Albedo x2", 2D) = "white" {}
		_SecondaryNormalMap("Secondary Normal Map", 2D) = "bump" {}
		_SecondaryNormalScale("Secondary Normal Scale", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 texcoord_0;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform fixed _NormalScale;
		uniform sampler2D _Normal;
		uniform sampler2D _HeightMap;
		uniform float4 _HeightMap_ST;
		uniform fixed _HeightScale;
		uniform fixed _SecondaryNormalScale;
		uniform sampler2D _SecondaryNormalMap;
		uniform sampler2D _DetailAlbedox2;
		uniform float4 _DetailAlbedox2_ST;
		uniform fixed4 _Color;
		uniform sampler2D _Albedo;
		uniform sampler2D _PackedMaps;
		uniform fixed4 _EmissionColor;
		uniform fixed _EmissionScale;
		uniform fixed _MetallicOffset;
		uniform fixed _SmoothnessScale;
		uniform fixed _AOScale;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			fixed2 temp_cast_0 = (1.0).xx;
			o.texcoord_0.xy = v.texcoord.xy * temp_cast_0 + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_HeightMap = i.uv_texcoord * _HeightMap_ST.xy + _HeightMap_ST.zw;
			float2 Offset138 = ( ( tex2D( _HeightMap,uv_HeightMap).r - 1.0 ) * i.viewDir.xy * _HeightScale ) + i.texcoord_0;
			float2 Offset = Offset138;
			o.Normal = BlendNormals( UnpackScaleNormal( tex2D( _Normal,Offset) ,_NormalScale ) , UnpackScaleNormal( tex2D( _SecondaryNormalMap,Offset) ,_SecondaryNormalScale ) );
			float2 uv_DetailAlbedox2 = i.uv_texcoord * _DetailAlbedox2_ST.xy + _DetailAlbedox2_ST.zw;
			o.Albedo = ( ( 2.0 * tex2D( _DetailAlbedox2,uv_DetailAlbedox2) ) + ( _Color * tex2D( _Albedo,Offset) ) ).xyz;
			fixed4 tex2DNode11 = tex2D( _PackedMaps,Offset);
			o.Emission = ( ( tex2DNode11.b * _EmissionColor ) * _EmissionScale ).rgb;
			o.Metallic = ( _MetallicOffset + tex2DNode11.r );
			o.Smoothness = ( tex2DNode11.a * _SmoothnessScale );
			o.Occlusion = lerp( 1.0 , tex2DNode11.g , _AOScale );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
-1614;219;1498;928;1610.532;-206.1313;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;129;-2325.352,107.3103;Float;False;Constant;_Tiling;Tiling;5;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;130;-2139.256,94.91127;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;131;-1896.548,47.71107;Float;False;0;FLOAT2;0,0;False;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;174;-1836.15,314.1104;Float;False;Property;_HeightScale;HeightScale;8;0;0.02;0;0.1;FLOAT
Node;AmplifyShaderEditor.WireNode;136;-1592.25,46.71119;Float;False;0;FLOAT2;0,0;False;FLOAT2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;175;-1704.95,445.3104;Float;False;Tangent;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;137;-1868.651,74.81045;Float;True;Property;_HeightMap;HeightMap;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ParallaxMappingNode;138;-1480.651,111.1106;Float;False;Normal;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;FLOAT;False;3;FLOAT3;0,0;False;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;173;-1206.951,107.9104;Float;False;Offset;1;False;0;FLOAT2;0,0;False;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;11;-1186.319,462.6529;Float;True;Property;_PackedMaps;PackedMaps;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;193;-861.5206,848.8808;Float;False;Property;_EmissionColor;Emission Color;10;0;1,1,1,1;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;196;-274.3224,-485.5206;Float;True;Property;_DetailAlbedox2;Detail Albedo x2;12;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;6;-964.5748,9.198174;Float;False;Property;_NormalScale;Normal Scale;6;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.ColorNode;176;-574.5095,-368.2206;Float;False;Property;_Color;Color;0;0;0,0,0,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;199;-128.4221,-589.6206;Float;False;Constant;_Float0;Float 0;15;0;2;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;127;-968.5637,239.1037;Float;False;Property;_SecondaryNormalScale;Secondary Normal Scale;14;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-658.76,-201.7431;Float;True;Property;_Albedo;Albedo;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;184;-619.9264,420.0796;Float;False;Property;_MetallicOffset;Metallic Offset;3;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;186;-826.3888,1144.413;Float;False;Property;_SmoothnessScale;Smoothness Scale;4;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;180;-648.3032,915.1805;Float;False;Property;_EmissionScale;EmissionScale;11;0;0;0;0;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;183;-692.6257,661.1801;Float;False;Property;_AOScale;AO Scale;9;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;181;-564.6259,561.9792;Float;False;Constant;_Float1;Float 1;9;0;1;0;0;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;-254.5092,-173.0206;Float;False;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;198;68.07777,-536.7203;Float;False;0;FLOAT;0,0,0,0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-635.9217,786.4803;Float;False;0;FLOAT;0.0;False;1;COLOR;0.0;False;COLOR
Node;AmplifyShaderEditor.WireNode;190;-1001.521,986.481;Float;False;0;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SamplerNode;126;-676.4999,214.8497;Float;True;Property;_SecondaryNormalMap;Secondary Normal Map;13;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;5;-674.1623,15.66886;Float;True;Property;_Normal;Normal;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BlendNormalsNode;128;-322.1008,177.9577;Float;False;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-423.1212,853.6796;Float;False;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;185;-447.1268,432.8797;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;197;71.27786,-131.9204;Float;False;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;FLOAT4
Node;AmplifyShaderEditor.LerpOp;182;-436.6262,582.7794;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-514.3218,1064.881;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;119.6998,201.8002;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;Standard;TehLemon/StandardPackedExtra;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;FLOAT3;False;1;FLOAT3;FLOAT3;False;2;FLOAT3;FLOAT3;False;3;FLOAT;0,0,0;False;4;FLOAT;FLOAT3;False;5;FLOAT;FLOAT3;False;6;FLOAT3;FLOAT;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;FLOAT;False;10;OBJECT;FLOAT3;False;11;FLOAT3;FLOAT,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;FLOAT;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;FLOAT;False
WireConnection;130;0;129;0
WireConnection;131;0;130;0
WireConnection;136;0;131;0
WireConnection;138;0;136;0
WireConnection;138;1;137;1
WireConnection;138;2;174;0
WireConnection;138;3;175;0
WireConnection;173;0;138;0
WireConnection;11;1;173;0
WireConnection;1;1;173;0
WireConnection;177;0;176;0
WireConnection;177;1;1;0
WireConnection;198;0;199;0
WireConnection;198;1;196;0
WireConnection;194;0;11;3
WireConnection;194;1;193;0
WireConnection;190;0;11;4
WireConnection;126;1;173;0
WireConnection;126;5;127;0
WireConnection;5;1;173;0
WireConnection;5;5;6;0
WireConnection;128;0;5;0
WireConnection;128;1;126;0
WireConnection;195;0;194;0
WireConnection;195;1;180;0
WireConnection;185;0;184;0
WireConnection;185;1;11;1
WireConnection;197;0;198;0
WireConnection;197;1;177;0
WireConnection;182;0;181;0
WireConnection;182;1;11;2
WireConnection;182;2;183;0
WireConnection;189;0;190;0
WireConnection;189;1;186;0
WireConnection;0;0;197;0
WireConnection;0;1;128;0
WireConnection;0;2;195;0
WireConnection;0;3;185;0
WireConnection;0;4;189;0
WireConnection;0;5;182;0
ASEEND*/
//CHKSM=A58F92844076C77A1B77B9A19C6706DF5915E39B