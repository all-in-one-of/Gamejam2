// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Angel"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Normal("Normal", 2D) = "white" {}
		_SME("SME", 2D) = "white" {}
		[HDR]_Emissive("Emissive", Color) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TilingSpeed("Tiling&Speed", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Emissive;
		uniform sampler2D _SME;
		uniform float4 _SME_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TilingSpeed;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = tex2D( _Normal, uv_Normal ).rgb;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = tex2D( _Albedo, uv_Albedo ).rgb;
			o.Emission = ( _Emissive * i.vertexColor.r ).rgb;
			float2 uv_SME = i.uv_texcoord * _SME_ST.xy + _SME_ST.zw;
			float4 tex2DNode17 = tex2D( _SME, uv_SME );
			o.Metallic = tex2DNode17.g;
			o.Smoothness = tex2DNode17.r;
			o.Alpha = 1;
			float2 appendResult29 = (float2(_TilingSpeed.z , _TilingSpeed.w));
			float2 appendResult28 = (float2(_TilingSpeed.x , _TilingSpeed.y));
			float2 uv_TexCoord26 = i.uv_texcoord * appendResult28;
			float2 panner25 = ( 1.0 * _Time.y * appendResult29 + uv_TexCoord26);
			float smoothstepResult33 = smoothstep( 0.0 , 0.64 , ( i.vertexColor.r * tex2D( _TextureSample0, panner25 ).g ));
			clip( ( ( 1.0 - i.vertexColor.r ) + ( i.vertexColor.r * smoothstepResult33 ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;573;1073;427;899.3247;-924.8812;1;True;False
Node;AmplifyShaderEditor.Vector4Node;27;-2175.854,1348.931;Float;False;Property;_TilingSpeed;Tiling&Speed;6;0;Create;True;0;0;False;0;0,0,0,0;10,10,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1958.228,1320.063;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1907.153,1459.965;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-1785.016,1242.339;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;25;-1462.558,1300.922;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;22;-1014.628,954.3404;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-1204.637,1237.832;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-854.4827,1186.995;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;33;-499.1082,1182.549;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.64;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-258.6454,964.5013;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-399.3731,828.211;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-1043.545,753.1995;Float;False;Property;_Emissive;Emissive;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-588.132,-3.573107;Float;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;None;d86997efbfdd94348ac9eea706e7ac3e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-586.4171,432.0472;Float;True;Property;_SME;SME;3;0;Create;True;0;0;False;0;None;94e95fd1c1aa88d468bb9fed1ff5fb88;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;73.08643,838.2813;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-603.5673,203.9468;Float;True;Property;_Normal;Normal;2;0;Create;True;0;0;False;0;None;32158c9154b5cae468e873943ac3788d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-670.7309,760.0259;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;293.8325,333.7847;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/Angel;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;27;1
WireConnection;28;1;27;2
WireConnection;29;0;27;3
WireConnection;29;1;27;4
WireConnection;26;0;28;0
WireConnection;25;0;26;0
WireConnection;25;2;29;0
WireConnection;23;1;25;0
WireConnection;24;0;22;1
WireConnection;24;1;23;2
WireConnection;33;0;24;0
WireConnection;31;0;22;1
WireConnection;31;1;33;0
WireConnection;30;0;22;1
WireConnection;32;0;30;0
WireConnection;32;1;31;0
WireConnection;18;0;19;0
WireConnection;18;1;22;1
WireConnection;0;0;15;0
WireConnection;0;1;16;0
WireConnection;0;2;18;0
WireConnection;0;3;17;2
WireConnection;0;4;17;1
WireConnection;0;10;32;0
ASEEND*/
//CHKSM=CCC3569A06E9E8047C911AC0C81F017C1438BCBD