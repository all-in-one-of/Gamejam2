// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Rainbow"
{
	Properties
	{
		_Rainbow("Rainbow", 2D) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 0
		_AppearValue("AppearValue", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _Rainbow;
		uniform float4 _Rainbow_ST;
		uniform float _Opacity;
		uniform float _AppearValue;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Rainbow = i.uv_texcoord * _Rainbow_ST.xy + _Rainbow_ST.zw;
			o.Emission = tex2D( _Rainbow, uv_Rainbow ).rgb;
			float smoothstepResult13 = smoothstep( 0.0 , (0.0 + (_AppearValue - 0.0) * (55.0 - 0.0) / (1.0 - 0.0)) , i.vertexColor.r);
			o.Alpha = ( _Opacity * i.vertexColor.a * smoothstepResult13 );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;601;1167;439;1941.125;80.8651;2.117419;True;False
Node;AmplifyShaderEditor.RangedFloatNode;17;-1149.176,373.7031;Float;False;Property;_AppearValue;AppearValue;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;4;-1015.21,156.752;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;16;-831.9938,331.5896;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;55;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-619.6793,57.61821;Float;False;Property;_Opacity;Opacity;1;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;13;-614.2635,302.529;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-594.2477,-174.0845;Float;True;Property;_Rainbow;Rainbow;0;0;Create;True;0;0;False;0;None;d21865c2b68440744a50d1fed53d0b52;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-349.9996,158.0914;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;157.352,10.56807;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;GJ2/Rainbow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;17;0
WireConnection;13;0;4;1
WireConnection;13;2;16;0
WireConnection;5;0;3;0
WireConnection;5;1;4;4
WireConnection;5;2;13;0
WireConnection;2;2;1;0
WireConnection;2;9;5;0
ASEEND*/
//CHKSM=A036B36184188D457BC2928CDC6ED5B826C1BEF3