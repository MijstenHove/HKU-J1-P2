// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Leaf/Grass"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_GrassColor("GrassColor", Color) = (1,1,1,0)
		[Normal]_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Metellic("Metellic", Float) = 0
		_Smoothnes("Smoothnes", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_woldefreq("wolde freq", Range( 0 , 1)) = 0
		_bendAmound("bendAmound", Range( 0 , 1)) = 0.05553174
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Background+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred nolightmap  vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _woldefreq;
		uniform float _bendAmound;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float4 _GrassColor;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Metellic;
		uniform float _Smoothnes;
		uniform float _Cutoff = 0.5;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_149_0 = ( ( ase_vertex3Pos.y * cos( ( ( ( ase_worldPos.x + ase_worldPos.z ) * _woldefreq ) + _Time.y ) ) ) * _bendAmound );
			float4 appendResult152 = (float4(temp_output_149_0 , 0.0 , temp_output_149_0 , 0.0));
			float4 break155 = mul( appendResult152, unity_ObjectToWorld );
			float4 appendResult157 = (float4(break155.x , 0.0 , break155.z , 0.0));
			float3 rotatedValue159 = RotateAroundAxis( float3( 0,0,0 ), appendResult157.xyz, float3( 0,0,0 ), 0.0 );
			v.vertex.xyz += rotatedValue159;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			o.Normal = UnpackNormal( tex2D( _TextureSample0, uv_TextureSample0 ) );
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode45 = tex2D( _Texture0, uv_Texture0 );
			o.Albedo = ( _GrassColor * tex2DNode45 ).rgb;
			o.Metallic = _Metellic;
			o.Smoothness = _Smoothnes;
			o.Alpha = 1;
			clip( ( tex2DNode45 * 3.19 ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
-1209;-335;1051;764;445.3117;95.315;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;140;-4117.953,-585.4521;Float;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;143;-3829.394,-402.3747;Float;False;Property;_woldefreq;wolde freq;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;141;-3823.906,-668.319;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;142;-3437.347,-427.047;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;156;-3374.546,-166.7068;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;145;-3170.503,-415.706;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;147;-2687.355,-332.7959;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;146;-2835.864,-90.90343;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-2470.288,-145.7023;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-2403.385,245.279;Float;False;Property;_bendAmound;bendAmound;7;0;Create;True;0;0;False;0;0.05553174;0.04;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-2131.065,80.72025;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;152;-1865.409,80.52116;Float;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;154;-1793.181,360.6698;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-1462.32,139.3842;Float;True;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;155;-1140.211,206.5081;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;158;-889.5161,92.30195;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;105;-1064.486,-793.5446;Float;True;Property;_Texture0;Texture 0;5;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;45;-735.0948,-793.3984;Float;True;Property;_TX_GrassPlane_D;TX_GrassPlane_D;2;0;Create;True;0;0;False;0;None;2329ef0f365b6b04280f4b3ca251a221;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;-606.0236,-1075.389;Float;False;Property;_GrassColor;GrassColor;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;162;-439.1811,-451.2047;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;3.19;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;157;-828.5161,214.302;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-692.069,121.6604;Float;False;Property;_winddir;wind dir;8;0;Create;True;0;0;False;0;0;1.72;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;159;-560.7131,262.8434;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;-245.5502,-609.4268;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;52;-595.6498,-198.9108;Float;True;Property;_TextureSample0;Texture Sample 0;2;1;[Normal];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-242.5957,-63.78348;Float;False;Property;_Metellic;Metellic;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-241.5957,23.21663;Float;False;Property;_Smoothnes;Smoothnes;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-236.9346,-928.3459;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;241.6519,-49.58562;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Leaf/Grass;False;False;False;False;False;False;True;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Background;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;141;0;140;1
WireConnection;141;1;140;3
WireConnection;142;0;141;0
WireConnection;142;1;143;0
WireConnection;145;0;142;0
WireConnection;145;1;156;2
WireConnection;146;0;145;0
WireConnection;148;0;147;2
WireConnection;148;1;146;0
WireConnection;149;0;148;0
WireConnection;149;1;150;0
WireConnection;152;0;149;0
WireConnection;152;2;149;0
WireConnection;153;0;152;0
WireConnection;153;1;154;0
WireConnection;155;0;153;0
WireConnection;45;0;105;0
WireConnection;157;0;155;0
WireConnection;157;1;158;0
WireConnection;157;2;155;2
WireConnection;159;3;157;0
WireConnection;161;0;45;0
WireConnection;161;1;162;0
WireConnection;51;0;50;0
WireConnection;51;1;45;0
WireConnection;0;0;51;0
WireConnection;0;1;52;0
WireConnection;0;3;54;0
WireConnection;0;4;55;0
WireConnection;0;10;161;0
WireConnection;0;11;159;0
ASEEND*/
//CHKSM=AE2C9C990D8C6A73954222039DCF96F629A56004