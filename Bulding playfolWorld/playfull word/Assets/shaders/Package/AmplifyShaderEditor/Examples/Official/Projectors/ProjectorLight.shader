// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Projectors/ProjectLight"
{
	Properties
	{
		_LightTex("LightTex", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Range("Range", Range( 0 , 1)) = 0.96
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend DstColor One
		Cull Back
		ColorMask RGB
		ZWrite Off
		ZTest LEqual
		Offset -1 , -1
		
		
		
		Pass
		{
			Name "SubShader 0 Pass 0"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float4 _Color;
			uniform sampler2D _LightTex;
			float4x4 unity_Projector;
			uniform float _Range;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 vertexToFrag11 = mul( unity_Projector, v.vertex );
				o.ase_texcoord = vertexToFrag11;
				
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float AlphaColor39 = _Color.a;
				float4 appendResult25 = (float4((_Color).rgb , AlphaColor39));
				float4 vertexToFrag11 = i.ase_texcoord;
				float ifLocalVar53 = 0;
				if( tex2D( _LightTex, ( (vertexToFrag11).xy / (vertexToFrag11).w ) ).b >= _Range )
				ifLocalVar53 = (float)1;
				else
				ifLocalVar53 = (float)0;
				
				
				finalColor = ( appendResult25 * ( AlphaColor39 * ifLocalVar53 ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16301
7;1;1796;963;1317.694;504.5354;1;False;True
Node;AmplifyShaderEditor.UnityProjectorMatrixNode;8;-1822.794,-148.2469;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.PosVertexDataNode;10;-1822.794,-68.24707;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1614.79,-148.2469;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexToFragmentNode;11;-1470.79,-148.2469;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;21;-1230.79,-148.2469;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;22;-1230.79,-68.24707;Float;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;-990.7903,-148.2469;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;37;-488.6265,-689.0574;Float;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;1,1,1,1;0,0.9813695,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;59;-782.6938,184.4646;Float;False;Constant;_Int0;Int 0;4;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;18;-847.7563,-174.2006;Float;True;Property;_LightTex;LightTex;0;0;Create;True;0;0;False;0;None;6e3628286573576499dec4903d9b0474;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;60;-831.6938,54.4646;Float;False;Constant;_Int1;Int 1;4;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-827.3624,-418.4099;Float;True;Property;_Range;Range;3;0;Create;True;0;0;False;0;0.96;0.3352941;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-243.9383,-594.2794;Float;False;AlphaColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;56;-154.4604,-251.7613;Float;False;39;AlphaColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;36;-243.6268,-688.0574;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;53;-500.0869,-159.8969;Float;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;INT;0;False;3;INT;0;False;4;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;48.00206,-178.8346;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;24.6939,-642.0502;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;13;-1128.433,664.3754;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;33;-508.9343,630.7655;Float;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;32;-508.9343,550.7649;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;-49.00658,661.2527;Float;False;39;AlphaColor;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;15;-755.0453,584.3748;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-291.8502,555.348;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;34;-147.8508,451.4635;Float;True;Property;_FalloffTex;FalloffTex;1;0;Create;True;0;0;False;0;None;be2431a5664252140acf26f10642c377;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;219.8536,547.4998;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;377.6082,445.6803;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;255.2996,-397.8119;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-920.4335,584.3748;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.UnityProjectorClipMatrixNode;9;-1128.433,584.3748;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;38;713.8335,144.7187;Float;False;True;2;Float;ASEMaterialInspector;0;1;ASESampleShaders/Projectors/ProjectLight;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;SubShader 0 Pass 0;2;True;1;2;False;-1;1;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;False;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;False;-1;True;True;-1;False;-1;-1;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;12;0;8;0
WireConnection;12;1;10;0
WireConnection;11;0;12;0
WireConnection;21;0;11;0
WireConnection;22;0;11;0
WireConnection;20;0;21;0
WireConnection;20;1;22;0
WireConnection;18;1;20;0
WireConnection;39;0;37;4
WireConnection;36;0;37;0
WireConnection;53;0;18;3
WireConnection;53;1;43;0
WireConnection;53;2;59;0
WireConnection;53;3;59;0
WireConnection;53;4;60;0
WireConnection;24;0;56;0
WireConnection;24;1;53;0
WireConnection;25;0;36;0
WireConnection;25;3;39;0
WireConnection;33;0;15;0
WireConnection;32;0;15;0
WireConnection;15;0;14;0
WireConnection;31;0;32;0
WireConnection;31;1;33;0
WireConnection;34;1;31;0
WireConnection;41;0;34;4
WireConnection;41;1;40;0
WireConnection;35;1;41;0
WireConnection;57;0;25;0
WireConnection;57;1;24;0
WireConnection;14;0;9;0
WireConnection;14;1;13;0
WireConnection;38;0;57;0
ASEEND*/
//CHKSM=2D294FDCA14362A288D371016F698ECC2D819EE1