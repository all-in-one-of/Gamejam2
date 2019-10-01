// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TechArt/CurveLasers"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HDR]_MainColor("MainColor", Color) = (0,0,0,0)
		_Max("Max", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_PannerSpeed("PannerSpeed", Vector) = (0,0,0,0)
		_DisplacmentIntensity("DisplacmentIntensity", Range( 0 , 10)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _TextureSample0;
		uniform float2 _PannerSpeed;
		uniform float _DisplacmentIntensity;
		uniform float4 _MainColor;
		uniform float _Max;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float2 panner13 = ( 1.0 * _Time.y * _PannerSpeed + v.texcoord.xy);
			v.vertex.xyz += ( ase_vertexNormal * tex2Dlod( _TextureSample0, float4( panner13, 0, 0.0) ).r * v.color.r * ( 1.0 - v.color.r ) * _DisplacmentIntensity );
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float smoothstepResult6 = smoothstep( 0.0 , (0.0 + (_Max - 0.0) * (2.0 - 0.0) / (1.0 - 0.0)) , i.vertexColor.r);
			o.Emission = ( _MainColor * smoothstepResult6 ).rgb;
			o.Alpha = 1;
			clip( smoothstepResult6 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16600
0;620;874;398;1004.19;372.4181;2.031341;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-382.4622,772.6461;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;16;-323.3841,923.7495;Float;False;Property;_PannerSpeed;PannerSpeed;4;0;Create;True;0;0;False;0;0,0;-0.5,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;7;-670.8204,518.0082;Float;False;Property;_Max;Max;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2;-408.3429,-31.30787;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;13;-91.61762,866.9435;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;9;-305.8204,528.0082;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;10;191.2748,559.1741;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;159.4635,723.9101;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;e28dc97a9541e3642a48c0e3886688c5;cd460ee4ac5c1e746b7a734cc7cc64dd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;20;195.8266,238.8292;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;302.1317,948.8243;Float;False;Property;_DisplacmentIntensity;DisplacmentIntensity;5;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-417.2151,180.572;Float;False;Property;_MainColor;MainColor;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,7.623036,21.36125,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;6;-74.55717,366.5792;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;28.73746,101.6889;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;543.5589,603.3297;Float;False;5;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;5;1121.761,207.0049;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;TechArt/CurveLasers;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;14;0
WireConnection;13;2;16;0
WireConnection;9;0;7;0
WireConnection;11;1;13;0
WireConnection;20;0;2;1
WireConnection;6;0;2;1
WireConnection;6;2;9;0
WireConnection;4;0;3;0
WireConnection;4;1;6;0
WireConnection;12;0;10;0
WireConnection;12;1;11;1
WireConnection;12;2;2;1
WireConnection;12;3;20;0
WireConnection;12;4;21;0
WireConnection;5;2;4;0
WireConnection;5;10;6;0
WireConnection;5;11;12;0
ASEEND*/
//CHKSM=B1EB5DA85F569A377C079194C9F6FE9F9D276FEC