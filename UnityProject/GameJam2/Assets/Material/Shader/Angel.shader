// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Angel"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HDR]_MainColor("MainColor", Color) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_AppearValue("AppearValue", Range( 0 , 1)) = 0
		[HDR]_BorderColor("BorderColor", Color) = (0,0,0,0)
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

		uniform float4 _MainColor;
		uniform float4 _BorderColor;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _AppearValue;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float temp_output_8_0 = ( tex2D( _TextureSample0, uv_TextureSample0 ).g * (0.0 + (_AppearValue - 0.0) * (6.0 - 0.0) / (1.0 - 0.0)) );
			float smoothstepResult9 = smoothstep( 0.5 , 0.59 , temp_output_8_0);
			o.Emission = ( _MainColor + ( _BorderColor * ( 1.0 - smoothstepResult9 ) ) ).rgb;
			o.Alpha = 1;
			clip( temp_output_8_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;586;1105;454;1885.759;-283.451;1.755163;True;False
Node;AmplifyShaderEditor.RangedFloatNode;5;-1317.713,554.5374;Float;False;Property;_AppearValue;AppearValue;3;0;Create;True;0;0;False;0;0;0.3992889;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1159.585,297.4189;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;d2b548c5f43422b43a0aed2df7c009cf;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;7;-990.1129,563.6371;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-722.313,463.5372;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;9;-511.7128,545.4372;Float;True;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0.59;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;10;-489.6125,299.7371;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-563.7126,100.8372;Float;False;Property;_BorderColor;BorderColor;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;10.09424,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-527.8868,-54.60663;Float;False;Property;_MainColor;MainColor;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.06242514,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-312.8127,217.8371;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-173.713,133.3371;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;100.0443,89.5133;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/Angel;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;5;0
WireConnection;8;0;6;2
WireConnection;8;1;7;0
WireConnection;9;0;8;0
WireConnection;10;0;9;0
WireConnection;13;0;11;0
WireConnection;13;1;10;0
WireConnection;14;0;1;0
WireConnection;14;1;13;0
WireConnection;0;2;14;0
WireConnection;0;10;8;0
ASEEND*/
//CHKSM=07993FEFC9F870401409A0366AAD968E3C671092