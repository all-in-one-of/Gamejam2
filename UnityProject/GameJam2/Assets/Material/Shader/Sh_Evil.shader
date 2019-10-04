// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Evil"
{
	Properties
	{
		_T_Evil_Albedo("T_Evil_Albedo", 2D) = "white" {}
		_T_Evil_Normal("T_Evil_Normal", 2D) = "bump" {}
		_T_Evil_SME("T_Evil_SME", 2D) = "white" {}
		_EmissiveColor("EmissiveColor", Color) = (0,0,0,0)
		_EmissivePower("EmissivePower", Range( 3 , 5)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _T_Evil_Normal;
		uniform float4 _T_Evil_Normal_ST;
		uniform sampler2D _T_Evil_Albedo;
		uniform float4 _T_Evil_Albedo_ST;
		uniform sampler2D _T_Evil_SME;
		uniform float4 _T_Evil_SME_ST;
		uniform float4 _EmissiveColor;
		uniform float _EmissivePower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_T_Evil_Normal = i.uv_texcoord * _T_Evil_Normal_ST.xy + _T_Evil_Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _T_Evil_Normal, uv_T_Evil_Normal ) );
			float2 uv_T_Evil_Albedo = i.uv_texcoord * _T_Evil_Albedo_ST.xy + _T_Evil_Albedo_ST.zw;
			o.Albedo = tex2D( _T_Evil_Albedo, uv_T_Evil_Albedo ).rgb;
			float2 uv_T_Evil_SME = i.uv_texcoord * _T_Evil_SME_ST.xy + _T_Evil_SME_ST.zw;
			float4 tex2DNode4 = tex2D( _T_Evil_SME, uv_T_Evil_SME );
			o.Emission = ( ( 1.0 - step( tex2DNode4.b , 0.25 ) ) * _EmissiveColor * _EmissivePower ).rgb;
			o.Metallic = tex2DNode4.g;
			o.Smoothness = tex2DNode4.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;632;1178;368;1226.616;46.4346;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;4;-731.7375,208.8462;Float;True;Property;_T_Evil_SME;T_Evil_SME;3;0;Create;True;0;0;False;0;f9895bedfd00e7b48b66acd0a574df13;f9895bedfd00e7b48b66acd0a574df13;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;8;-412.0778,328.0139;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-212.0778,325.0139;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-650.8912,469.8773;Float;False;Property;_EmissiveColor;EmissiveColor;4;0;Create;True;0;0;False;0;0,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-383.5661,619.8154;Float;False;Property;_EmissivePower;EmissivePower;5;0;Create;True;0;0;False;0;0;3;3;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-423.2213,-195.9876;Float;True;Property;_T_Evil_Albedo;T_Evil_Albedo;1;0;Create;True;0;0;False;0;17d87a4d4da47dc42b3e29bc7ac5b568;17d87a4d4da47dc42b3e29bc7ac5b568;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-664.0143,8.686672;Float;True;Property;_T_Evil_Normal;T_Evil_Normal;2;0;Create;True;0;0;False;0;c2cf61c6cb223c74e8a27c1559694bc0;c2cf61c6cb223c74e8a27c1559694bc0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-95.69583,440.0252;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;127.4,13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/Evil;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;4;3
WireConnection;9;0;8;0
WireConnection;5;0;9;0
WireConnection;5;1;6;0
WireConnection;5;2;10;0
WireConnection;0;0;2;0
WireConnection;0;1;3;0
WireConnection;0;2;5;0
WireConnection;0;3;4;2
WireConnection;0;4;4;1
ASEEND*/
//CHKSM=822A1EDC753C3B8582D275247A8B272B56C59BDB