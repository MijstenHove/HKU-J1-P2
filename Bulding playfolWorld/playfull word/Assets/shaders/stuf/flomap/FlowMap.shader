// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "flo map"
{
	Properties
	{
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_speed("speed", Float) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture0;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform float _speed;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color67 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 clampResult38 = clamp( tex2D( _TextureSample1, uv_TextureSample1 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float4 temp_output_42_0 = ( clampResult38 * ( 0.5 * -1.0 ) );
			float temp_output_48_0 = ( _Time.y * _speed );
			float temp_output_49_0 = frac( ( temp_output_48_0 + 0.5 ) );
			float4 lerpResult65 = lerp( tex2D( _Texture0, ( ( temp_output_42_0 * temp_output_49_0 ) + float4( i.uv_texcoord, 0.0 , 0.0 ) ).rg ) , tex2D( _Texture0, ( ( temp_output_42_0 * frac( temp_output_48_0 ) ) + float4( i.uv_texcoord, 0.0 , 0.0 ) ).rg ) , abs( ( ( temp_output_49_0 - 0.5 ) / 0.5 ) ));
			o.Albedo = ( color67 * lerpResult65 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
0;0;1536;803;5175.803;1580.212;5.147143;True;True
Node;AmplifyShaderEditor.RangedFloatNode;47;-3482.428,157.8262;Float;False;Property;_speed;speed;2;0;Create;True;0;0;False;0;0.5;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;46;-3493.329,58.26055;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-3482.408,-279.2275;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-3449.372,448.6074;Float;False;Constant;_Float4;Float 4;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-3258.095,-509.029;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;None;cbd90853b210bfb4e9ff62a7d01728e4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-2898.886,106.1411;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3488.675,-134.9613;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-3073.318,-231.8477;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;38;-2782.262,-508.4667;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-2589.527,322.9912;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;49;-2065.139,288.1226;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1768.167,609.2529;Float;True;Constant;_Float5;Float 5;4;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;52;-2428.999,52.11676;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-2478.374,-258.5258;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-2013.32,-11.98461;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-2016.966,-270.5569;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;59;-1730.973,-139.2389;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;55;-1612.875,278.0251;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;70;-1346.837,-455.9994;Float;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;False;0;None;1d8eb2631c59f4b4e9e2fa9d20193a6d;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-1378.886,34.64978;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-1389.71,-232.2758;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;56;-1216.217,359.9524;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;63;-964.9443,-200.9933;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;None;1d8eb2631c59f4b4e9e2fa9d20193a6d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;-986.903,63.3004;Float;True;Property;_TextureSample2;Texture Sample 2;5;0;Create;True;0;0;False;0;None;1d8eb2631c59f4b4e9e2fa9d20193a6d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;71;-824.0577,317.0724;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;67;-491.5881,-277.8551;Float;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;65;-535.5295,-7.973112;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.490566;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-232.8586,-4.812923;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;flo map;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;43;0;45;0
WireConnection;43;1;44;0
WireConnection;38;0;37;0
WireConnection;50;0;48;0
WireConnection;50;1;51;0
WireConnection;49;0;50;0
WireConnection;52;0;48;0
WireConnection;42;0;38;0
WireConnection;42;1;43;0
WireConnection;58;0;42;0
WireConnection;58;1;49;0
WireConnection;57;0;42;0
WireConnection;57;1;52;0
WireConnection;55;0;49;0
WireConnection;55;1;54;0
WireConnection;62;0;58;0
WireConnection;62;1;59;0
WireConnection;60;0;57;0
WireConnection;60;1;59;0
WireConnection;56;0;55;0
WireConnection;56;1;54;0
WireConnection;63;0;70;0
WireConnection;63;1;60;0
WireConnection;64;0;70;0
WireConnection;64;1;62;0
WireConnection;71;0;56;0
WireConnection;65;0;64;0
WireConnection;65;1;63;0
WireConnection;65;2;71;0
WireConnection;66;0;67;0
WireConnection;66;1;65;0
WireConnection;0;0;66;0
ASEEND*/
//CHKSM=E4D376A1D494C965865346C893BA0ED0BAC3774A