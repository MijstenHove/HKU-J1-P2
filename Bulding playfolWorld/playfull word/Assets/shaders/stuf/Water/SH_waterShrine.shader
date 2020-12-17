// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_shore("shore", Color) = (0.01241543,0.5507364,0.8773585,0)
		_smooth("smooth", Float) = 0
		_Water("Water", 2D) = "white" {}
		_transparent("transparent", Float) = 0.13
		_Depth("Depth", Range( 0 , 10)) = 1
		_metal("metal", Float) = 0
		_direction("direction", Vector) = (0,-0.02,0,0)
		_Speed("Speed", Float) = 0.04
		_whater("whater", Color) = (0.3052363,0.3009078,0.4339623,0)
		_FoomSize("FoomSize", Int) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform float4 _shore;
		uniform float4 _whater;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Depth;
		uniform sampler2D _Water;
		uniform int _FoomSize;
		uniform float2 _direction;
		uniform float _Speed;
		uniform float _smooth;
		uniform float _metal;
		uniform float _transparent;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth38 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float4 lerpResult12 = lerp( _shore , _whater , ( ( abs( ( eyeDepth38 - ase_screenPos.w ) ) * (0.0 + (_Depth - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) ) + 0.0 ));
			float2 temp_cast_0 = _FoomSize;
			float2 temp_cast_1 = (( _Time.y * _Speed )).xx;
			float2 panner34 = ( 1.0 * _Time.y * _direction + temp_cast_1);
			float2 uv_TexCoord20 = i.uv_texcoord * temp_cast_0 + panner34;
			float4 temp_output_30_0 = ( tex2D( _Water, uv_TexCoord20 ) * _smooth );
			o.Albedo = ( lerpResult12 + temp_output_30_0 ).rgb;
			o.Metallic = _metal;
			float4 clampResult31 = clamp( ( 1.0 - temp_output_30_0 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			o.Smoothness = clampResult31.r;
			o.Alpha = _transparent;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred 

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
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 screenPos : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
0;0;1536;803;2317.755;1823.041;2.948319;True;True
Node;AmplifyShaderEditor.CommentaryNode;36;-1994.072,-1323.722;Float;False;1417.5;576.0623;depht;7;43;42;41;40;39;38;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;37;-1944.073,-1147.472;Float;True;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;18;-2342.421,-376.5251;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2296.55,-118.4671;Float;True;Property;_Speed;Speed;7;0;Create;True;0;0;False;0;0.04;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;38;-1709.44,-1273.722;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2030.959,-249.6931;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;33;-1994.052,39.65492;Float;True;Property;_direction;direction;6;0;Create;True;0;0;False;0;0,-0.02;0.06,-0.32;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;39;-1548.937,-901.0044;Float;False;Property;_Depth;Depth;4;0;Create;True;0;0;False;0;1;5.047059;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;-1467.557,-1270.539;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;34;-1605.866,62.25489;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;17;-1761.611,-452.83;Float;False;Property;_FoomSize;FoomSize;9;0;Create;True;0;0;False;0;2;5;0;1;INT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1281.59,-180.321;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;42;-1216.243,-951.6585;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;41;-1238.148,-1248.718;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-994.5553,-1185.149;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2.46;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-122.9681,-155.8509;Float;False;Property;_smooth;smooth;1;0;Create;True;0;0;False;0;0;1.07;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-953.4163,-96.43614;Float;True;Property;_Water;Water;2;0;Create;True;0;0;False;0;f53512d44b91e954dae7bf028209df1a;9fbef4b79ca3b784ba023cb1331520d5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-589.543,-1551.084;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;59.37098,-254.2108;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2;-159.2052,-1066.101;Float;False;Property;_shore;shore;0;0;Create;True;0;0;False;0;0.01241543,0.5507364,0.8773585,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-398.4257,-811.7239;Float;False;Property;_whater;whater;8;0;Create;True;0;0;False;0;0.3052363,0.3009078,0.4339623,0;0.2808116,0.5859885,0.6415094,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;12;19.59784,-641.9702;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;32;304.2772,-257.5324;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;236.7139,20.01834;Float;False;Property;_metal;metal;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;31;365.4097,-91.65804;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;374.987,-552.629;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;711.5054,-28.10464;Float;True;Property;_transparent;transparent;3;0;Create;True;0;0;False;0;0.13;0.28;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;926.9664,-307.7256;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;37;0
WireConnection;15;0;18;0
WireConnection;15;1;19;0
WireConnection;40;0;38;0
WireConnection;40;1;37;4
WireConnection;34;0;15;0
WireConnection;34;2;33;0
WireConnection;20;0;17;0
WireConnection;20;1;34;0
WireConnection;42;0;39;0
WireConnection;41;0;40;0
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;22;1;20;0
WireConnection;45;0;43;0
WireConnection;30;0;22;0
WireConnection;30;1;7;0
WireConnection;12;0;2;0
WireConnection;12;1;13;0
WireConnection;12;2;45;0
WireConnection;32;0;30;0
WireConnection;31;0;32;0
WireConnection;57;0;12;0
WireConnection;57;1;30;0
WireConnection;0;0;57;0
WireConnection;0;3;6;0
WireConnection;0;4;31;0
WireConnection;0;9;8;0
ASEEND*/
//CHKSM=09B26C460D61C8C9901D9D2D4BD374DC8CF75C14