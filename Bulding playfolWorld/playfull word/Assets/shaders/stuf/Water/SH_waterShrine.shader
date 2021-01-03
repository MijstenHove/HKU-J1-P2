// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_shore("shore", Color) = (0.01241543,0.5507364,0.8773585,0)
		_smooth("smooth", Float) = 0
		_textureintensity("texture intensity", Float) = 0
		_transparent("transparent", Float) = 0.13
		_Depth("Depth", Range( 0 , 10)) = 1
		_metal("metal", Float) = 0
		_direction("direction", Vector) = (0,-0.02,0,0)
		_Vector0("Vector 0", Vector) = (0,-0.02,0,0)
		_Speed("Speed", Float) = 0.04
		_whater("whater", Color) = (0.3052363,0.3009078,0.4339623,0)
		_Texture0("Texture 0", 2D) = "white" {}
		_stipeintensty("stipe intensty", Float) = 2.57
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
		uniform float _textureintensity;
		uniform sampler2D _Texture0;
		uniform float2 _direction;
		uniform float _Speed;
		uniform float2 _Vector0;
		uniform float _stipeintensty;
		uniform float _metal;
		uniform float _smooth;
		uniform float _transparent;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth38 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float4 lerpResult12 = lerp( _shore , _whater , ( ( abs( ( eyeDepth38 - ase_screenPos.w ) ) * (0.0 + (_Depth - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) ) + 0.0 ));
			float2 _Vector1 = float2(3,5.08);
			float temp_output_15_0 = ( _Time.y * _Speed );
			float2 temp_cast_0 = (temp_output_15_0).xx;
			float2 panner34 = ( 1.0 * _Time.y * _direction + temp_cast_0);
			float2 uv_TexCoord20 = i.uv_texcoord * ( _Vector1 + -1.82 ) + panner34;
			float2 temp_cast_1 = (temp_output_15_0).xx;
			float2 panner66 = ( 1.0 * _Time.y * _Vector0 + temp_cast_1);
			float2 uv_TexCoord67 = i.uv_texcoord * _Vector1 + panner66;
			float4 temp_output_82_0 = ( ( tex2D( _Texture0, uv_TexCoord20 ) * 1.77 ) - ( tex2D( _Texture0, uv_TexCoord67 ) * _stipeintensty ) );
			float4 clampResult91 = clamp( ( _textureintensity * temp_output_82_0 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 lerpResult89 = lerp( _whater , _shore , clampResult91);
			o.Albedo = ( lerpResult12 + lerpResult89 ).rgb;
			o.Metallic = _metal;
			float4 clampResult31 = clamp( ( 1.0 - ( temp_output_82_0 * _smooth ) ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
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
-1280;-447;1280;963;1695.501;305.7599;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;19;-3134.14,-393.5069;Float;True;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;0.04;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;18;-3180.011,-651.5649;Float;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;92;-2336.732,-76.9326;Float;False;Constant;_Vector1;Vector 1;12;0;Create;True;0;0;False;0;3,5.08;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;68;-2602.613,135.7446;Float;True;Property;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;0,-0.02;0.1,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;95;-2272.621,-286.7178;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;False;0;-1.82;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;33;-2749.795,-193.1454;Float;True;Property;_direction;direction;6;0;Create;True;0;0;False;0;0,-0.02;-0.06,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2868.55,-524.7329;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;66;-2279.438,118.5664;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-2121.621,-198.7178;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;36;-1994.072,-1323.722;Float;False;1417.5;576.0623;depht;7;43;42;41;40;39;38;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PannerNode;34;-2443.457,-212.7849;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;62;-2130.474,-413.8643;Float;True;Property;_Texture0;Texture 0;10;0;Create;True;0;0;False;0;None;4e504f0c362b51a42a6d4937ab367b5e;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;67;-2053.812,120.4314;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;37;-1944.073,-1147.472;Float;True;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-1997.422,-177.4763;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;86;-1350.62,57.06926;Float;False;Property;_stipeintensty;stipe intensty;11;0;Create;True;0;0;False;0;2.57;2.57;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;65;-1609.346,161.4398;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;f53512d44b91e954dae7bf028209df1a;None;True;0;True;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;80;-1390.958,-54.8089;Float;False;Constant;_Float1;Float 1;13;0;Create;True;0;0;False;0;1.77;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;22;-1706.656,-178.3891;Float;True;Property;_Water;Water;3;0;Create;True;0;0;False;0;f53512d44b91e954dae7bf028209df1a;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;38;-1709.44,-1273.722;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-1044.62,162.0693;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1548.937,-901.0044;Float;False;Property;_Depth;Depth;4;0;Create;True;0;0;False;0;1;3.11;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1150.958,-133.8089;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;-1467.557,-1270.539;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;82;-807.9871,42.60894;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;42;-1216.243,-951.6585;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-867.2731,-513.226;Float;False;Property;_textureintensity;texture intensity;2;0;Create;True;0;0;False;0;0;1.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;41;-1238.148,-1248.718;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-606.5809,-480.2967;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-219.3858,-267.4925;Float;False;Property;_smooth;smooth;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-994.5553,-1185.149;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2.46;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;0.1671181,-244.0615;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-589.543,-1551.084;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-235.9257,-993.7239;Float;False;Property;_whater;whater;9;0;Create;True;0;0;False;0;0.3052363,0.3009078,0.4339623,0;0.2808116,0.5859885,0.6415094,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-426.3971,-746.4351;Float;False;Property;_shore;shore;0;0;Create;True;0;0;False;0;0.01241543,0.5507364,0.8773585,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;91;-264.201,-473.1899;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;12;143.2181,-953.3087;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;32;232.2563,-261.9424;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;89;29.50057,-552.8001;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;711.5054,-28.10464;Float;True;Property;_transparent;transparent;3;0;Create;True;0;0;False;0;0.13;0.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;31;475.1587,-82.66222;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;236.7139,20.01834;Float;False;Property;_metal;metal;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;433.4396,-563.7628;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;926.9664,-307.7256;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;18;0
WireConnection;15;1;19;0
WireConnection;66;0;15;0
WireConnection;66;2;68;0
WireConnection;93;0;92;0
WireConnection;93;1;95;0
WireConnection;34;0;15;0
WireConnection;34;2;33;0
WireConnection;67;0;92;0
WireConnection;67;1;66;0
WireConnection;20;0;93;0
WireConnection;20;1;34;0
WireConnection;65;0;62;0
WireConnection;65;1;67;0
WireConnection;22;0;62;0
WireConnection;22;1;20;0
WireConnection;38;0;37;0
WireConnection;87;0;65;0
WireConnection;87;1;86;0
WireConnection;79;0;22;0
WireConnection;79;1;80;0
WireConnection;40;0;38;0
WireConnection;40;1;37;4
WireConnection;82;0;79;0
WireConnection;82;1;87;0
WireConnection;42;0;39;0
WireConnection;41;0;40;0
WireConnection;58;0;59;0
WireConnection;58;1;82;0
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;30;0;82;0
WireConnection;30;1;7;0
WireConnection;45;0;43;0
WireConnection;91;0;58;0
WireConnection;12;0;2;0
WireConnection;12;1;13;0
WireConnection;12;2;45;0
WireConnection;32;0;30;0
WireConnection;89;0;13;0
WireConnection;89;1;2;0
WireConnection;89;2;91;0
WireConnection;31;0;32;0
WireConnection;57;0;12;0
WireConnection;57;1;89;0
WireConnection;0;0;57;0
WireConnection;0;3;6;0
WireConnection;0;4;31;0
WireConnection;0;9;8;0
ASEEND*/
//CHKSM=1FF7932A9D34187DDF77A7F03BCB3DB8B3EAF59E