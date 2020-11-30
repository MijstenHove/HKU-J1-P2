// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "   "
{
	Properties
	{
		_FoomColor("FoomColor", Color) = (0.1646493,0.9324281,0.9433962,0)
		_WaterNormal("Water Normal", 2D) = "white" {}
		_WaterColor("WaterColor ", Color) = (0.1646493,0.9324281,0.9433962,0)
		_WaterDephtColor("WaterDephtColor", Color) = (0.1646493,0.9324281,0.9433962,0)
		_Depth("Depth", Range( 0 , 10)) = 1
		_NormalDepth("Normal Depth", Float) = 0
		_wha("wha", Range( 1 , 3)) = 2.434099
		_Smoothess("Smoothess", Range( 0 , 1)) = 0.31
		_Metellic("Metellic", Range( 0 , 1)) = 0.27
		_NormalScale("Normal Scale", Range( 1 , 10)) = 7.8
		_Edgepouwer("Edgepouwer", Float) = 0.91
		_EdgeDistance("EdgeDistance", Float) = -0.08
		_Opacity("Opacity", Float) = 0.19
		_Foom("Foom", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _WaterNormal;
		uniform float _NormalDepth;
		uniform float _wha;
		uniform float _NormalScale;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _EdgeDistance;
		uniform sampler2D _Foom;
		uniform float _Edgepouwer;
		uniform float4 _WaterColor;
		uniform float4 _WaterDephtColor;
		uniform float _Depth;
		uniform float4 _FoomColor;
		uniform float _Metellic;
		uniform float _Smoothess;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_NormalScale).xx;
			float2 uv_TexCoord55 = i.uv_texcoord * temp_cast_0;
			float2 panner56 = ( 1.0 * _Time.y * float2( 0,0.02 ) + uv_TexCoord55);
			float2 panner58 = ( 1.0 * _Time.y * float2( 0,-0.02 ) + uv_TexCoord55);
			float2 _Vector2 = float2(-1,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth107 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float distanceDepth107 = abs( ( screenDepth107 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _EdgeDistance ) );
			float temp_output_151_0 = ( 1.0 - distanceDepth107 );
			float4 temp_cast_2 = (temp_output_151_0).xxxx;
			float2 uv_TexCoord149 = i.uv_texcoord * float2( 10,10 );
			float2 panner152 = ( 1.0 * _Time.y * float2( 0,-0.05 ) + uv_TexCoord149);
			float4 temp_output_157_0 = ( 1.0 - tex2D( _Foom, panner152 ) );
			float4 lerpResult150 = lerp( float4( 0,0,0,0 ) , temp_output_157_0 , temp_output_151_0);
			float4 lerpResult158 = lerp( temp_cast_2 , lerpResult150 , float4( 0.8207547,0.8207547,0.8207547,0 ));
			float4 edgeDetection112 = ( lerpResult158 * _Edgepouwer );
			float4 clampResult121 = clamp( edgeDetection112 , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			float3 lerpResult83 = lerp( BlendNormals( UnpackScaleNormal( tex2D( _WaterNormal, panner56 ), ( _NormalDepth - _wha ) ) , tex2D( _WaterNormal, panner58 ).rgb ) , UnpackScaleNormal( tex2D( _WaterNormal, _Vector2 ), _Vector2.x ) , clampResult121.rgb);
			float3 normal99 = lerpResult83;
			o.Normal = normal99;
			float eyeDepth5 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float fadedepth163 = ( abs( ( eyeDepth5 - ase_screenPos.w ) ) * (0.0 + (_Depth - 0.0) * (1.0 - 0.0) / (1.0 - 0.0)) );
			float clampResult170 = clamp( ( fadedepth163 * 1.5 ) , 0.0 , 1.0 );
			float4 lerpResult159 = lerp( _WaterColor , _WaterDephtColor , clampResult170);
			float4 clampResult120 = clamp( edgeDetection112 , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 lerpResult91 = lerp( lerpResult159 , _FoomColor , clampResult120);
			o.Albedo = lerpResult91.rgb;
			o.Metallic = _Metellic;
			o.Smoothness = _Smoothess;
			float clampResult125 = clamp( ( fadedepth163 + _Opacity ) , 0.0 , 1.0 );
			o.Alpha = clampResult125;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
696;241.6;480;270;7174.475;1383.135;4.216244;False;False
Node;AmplifyShaderEditor.CommentaryNode;167;-5072.171,1211.321;Float;False;2107.024;1092.311;foom;16;154;149;134;152;136;157;112;155;156;110;111;158;150;151;107;108;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;149;-5022.171,1991.466;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;10,10;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;154;-4774.318,2141.431;Float;False;Constant;_Vector3;Vector 3;10;0;Create;True;0;0;False;0;0,-0.05;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;108;-4541.042,1481.137;Float;False;Property;_EdgeDistance;EdgeDistance;11;0;Create;True;0;0;False;0;-0.08;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;134;-4860.675,1738.14;Float;True;Property;_Foom;Foom;13;0;Create;True;0;0;False;0;None;43f507a8aa6b9f84aacb5cbac57224f5;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.PannerNode;152;-4545.717,2002.129;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;166;-4969.25,421.132;Float;False;1417.5;576.0623;depht;8;4;5;6;10;13;9;8;163;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DepthFade;107;-4266.686,1455.836;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;4;-4919.25,597.3815;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;136;-4412.806,1759.69;Float;True;Property;_TextureSample1;Texture Sample 1;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;151;-4016.849,1405.335;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenDepthNode;5;-4684.616,471.132;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;157;-4081.401,1851.396;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-4524.114,843.8481;Float;False;Property;_Depth;Depth;4;0;Create;True;0;0;False;0;1;0.46;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;54;-5799.347,-680.6652;Float;False;3145.192;773.3357;Blend panning normals to fake noving ripples;18;83;60;80;59;81;78;61;56;77;57;62;55;58;113;121;105;106;99;;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;150;-3842.318,1467.404;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.7264151;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;-4442.734,474.3151;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;9;-4148.725,513.6355;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-5714.22,-456.2714;Float;True;Property;_NormalScale;Normal Scale;9;0;Create;True;0;0;False;0;7.8;7;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-4191.42,793.1943;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-3699.531,1555.326;Float;False;Property;_Edgepouwer;Edgepouwer;10;0;Create;True;0;0;False;0;0.91;3.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;158;-3665.705,1411.487;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0.8207547,0.8207547,0.8207547,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-4013.732,548.705;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;2.46;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-3496.356,1382.182;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;78;-5273.833,-632.0112;Float;False;Constant;_Vector1;Vector 1;5;0;Create;True;0;0;False;0;0,0.02;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-5383.184,-482.9493;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;77;-5338.979,-178.6637;Float;True;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0,-0.02;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;57;-4757.125,-355.8101;Float;False;Property;_NormalDepth;Normal Depth;5;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-4776.525,-463.6954;Float;False;Property;_wha;wha;6;0;Create;True;0;0;False;0;2.434099;2.05;1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;58;-4950.794,-156.0637;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;171;-1678.662,-1315.448;Float;False;1397.252;1085.826;Color;11;169;165;168;98;170;160;114;2;159;120;91;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;80;-4562.021,-517.9241;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;56;-4947.655,-585.939;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;-3776.549,487.6771;Float;False;fadedepth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;112;-3193.146,1417.095;Float;False;edgeDetection;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;59;-4434.441,-229.2588;Float;True;Property;_WaterNormal;Water Normal;1;0;Create;True;0;0;False;0;9a4a55d8d2e54394d97426434477cdcf;da0f84760f2f63e4c9cbaa19cf5c9e79;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;165;-1628.662,-932.6177;Float;False;163;fadedepth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;106;-3885.8,-615.541;Float;False;Constant;_Vector2;Vector 2;8;0;Create;True;0;0;False;0;-1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;169;-1610.609,-759.8356;Float;False;Constant;_Float0;Float 0;13;0;Create;True;0;0;False;0;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;-3605.734,-305.4814;Float;False;112;edgeDetection;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;60;-4411.604,-625.8439;Float;True;Property;_Normal2;Normal2;1;0;Create;True;0;0;False;0;None;da0f84760f2f63e4c9cbaa19cf5c9e79;True;0;True;bump;Auto;True;Instance;59;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-1450.793,-867.9747;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;121;-3330.455,-410.9456;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;105;-3691.146,-643.8379;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;da0f84760f2f63e4c9cbaa19cf5c9e79;True;0;True;bump;Auto;True;Instance;59;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;61;-4029.336,-431.781;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-780.2776,247.7316;Float;False;163;fadedepth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;98;-1576.919,-1174.917;Float;False;Property;_WaterColor;WaterColor ;2;0;Create;True;0;0;False;0;0.1646493,0.9324281,0.9433962,0;0.3843134,0.7517336,0.8588235,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;114;-1238.469,-406.3096;Float;False;112;edgeDetection;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;160;-1318.049,-1265.448;Float;False;Property;_WaterDephtColor;WaterDephtColor;3;0;Create;True;0;0;False;0;0.1646493,0.9324281,0.9433962,0;0.1490191,0.3568622,0.3294113,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;170;-1301.904,-869.1184;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-628.5099,352.2048;Float;False;Property;_Opacity;Opacity;12;0;Create;True;0;0;False;0;0.19;0.68;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;83;-3174.447,-502.826;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;159;-1011.165,-883.5093;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;120;-917.2421,-406.2311;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;99;-2885.29,-492.1631;Float;True;normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;2;-1031.711,-610.1929;Float;False;Property;_FoomColor;FoomColor;0;0;Create;True;0;0;False;0;0.1646493,0.9324281,0.9433962,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;123;-352.9099,252.1643;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;91;-546.4106,-483.0217;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-433.1754,65.03913;Float;False;Property;_Metellic;Metellic;8;0;Create;True;0;0;False;0;0.27;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;125;-209.3245,233.7071;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-432.8487,136.9056;Float;False;Property;_Smoothess;Smoothess;7;0;Create;True;0;0;False;0;0.31;0.71;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;155;-3701.009,1872.39;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;100;-324.6573,-1.089491;Float;False;99;normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-3907.934,2013.429;Float;False;Constant;_Float1;Float 1;10;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;   ;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;152;0;149;0
WireConnection;152;2;154;0
WireConnection;107;0;108;0
WireConnection;136;0;134;0
WireConnection;136;1;152;0
WireConnection;151;0;107;0
WireConnection;5;0;4;0
WireConnection;157;0;136;0
WireConnection;150;1;157;0
WireConnection;150;2;151;0
WireConnection;6;0;5;0
WireConnection;6;1;4;4
WireConnection;9;0;6;0
WireConnection;13;0;10;0
WireConnection;158;0;151;0
WireConnection;158;1;150;0
WireConnection;8;0;9;0
WireConnection;8;1;13;0
WireConnection;110;0;158;0
WireConnection;110;1;111;0
WireConnection;55;0;62;0
WireConnection;58;0;55;0
WireConnection;58;2;77;0
WireConnection;80;0;57;0
WireConnection;80;1;81;0
WireConnection;56;0;55;0
WireConnection;56;2;78;0
WireConnection;163;0;8;0
WireConnection;112;0;110;0
WireConnection;59;1;58;0
WireConnection;60;1;56;0
WireConnection;60;5;80;0
WireConnection;168;0;165;0
WireConnection;168;1;169;0
WireConnection;121;0;113;0
WireConnection;105;1;106;0
WireConnection;105;5;106;1
WireConnection;61;0;60;0
WireConnection;61;1;59;0
WireConnection;170;0;168;0
WireConnection;83;0;61;0
WireConnection;83;1;105;0
WireConnection;83;2;121;0
WireConnection;159;0;98;0
WireConnection;159;1;160;0
WireConnection;159;2;170;0
WireConnection;120;0;114;0
WireConnection;99;0;83;0
WireConnection;123;0;164;0
WireConnection;123;1;124;0
WireConnection;91;0;159;0
WireConnection;91;1;2;0
WireConnection;91;2;120;0
WireConnection;125;0;123;0
WireConnection;155;0;157;0
WireConnection;155;1;156;0
WireConnection;0;0;91;0
WireConnection;0;1;100;0
WireConnection;0;3;32;0
WireConnection;0;4;21;0
WireConnection;0;9;125;0
ASEEND*/
//CHKSM=1D78C948DD815B9ED35E3E80F41252A66D998313