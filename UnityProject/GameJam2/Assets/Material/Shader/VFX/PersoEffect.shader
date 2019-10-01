// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TV/Perso/Effect"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.08
		[HDR]_CloseColor("CloseColor", Color) = (0,0,0,0)
		_TillingSpeed("Tilling&Speed", Vector) = (0,0,0,0)
		_HelixTexture("HelixTexture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _CloseColor;
		uniform sampler2D _HelixTexture;
		uniform float4 _TillingSpeed;
		uniform float _Cutoff = 0.08;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _CloseColor.rgb;
			float smoothstepResult13 = smoothstep( 0.0 , 0.5 , i.uv_texcoord.y);
			float smoothstepResult17 = smoothstep( 1.15 , 0.0 , i.uv_texcoord.y);
			o.Alpha = ( smoothstepResult13 * smoothstepResult17 );
			float2 appendResult16 = (float2(_TillingSpeed.z , _TillingSpeed.w));
			float2 appendResult15 = (float2(_TillingSpeed.x , _TillingSpeed.y));
			float2 panner5 = ( 1.0 * _Time.y * appendResult16 + ( appendResult15 * i.uv_texcoord ));
			clip( tex2D( _HelixTexture, panner5 ).g - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16600
0;564;946;454;1467.621;-166.6773;1.3;True;False
Node;AmplifyShaderEditor.Vector4Node;14;-1372.742,12.06015;Float;False;Property;_TillingSpeed;Tilling&Speed;2;0;Create;True;0;0;False;0;0,0,0,0;1,5,0,2;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1139.142,-95.13984;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2;-1123.509,38.70459;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-867.0155,-44.74417;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;16;-1129.542,186.4601;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;13;-516.8346,-283.8585;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;19;-934.5574,429.9338;Float;True;Property;_HelixTexture;HelixTexture;3;0;Create;True;0;0;False;0;None;f30d40d777989e74d8c4f9f4ee60995d;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SmoothstepOpNode;17;-519.5703,-64.09075;Float;True;3;0;FLOAT;0;False;1;FLOAT;1.15;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;5;-791.9656,215.3016;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;4;-548.1573,242.1084;Float;True;Property;_01;01;0;0;Create;True;0;0;False;0;41dd5b7948071d743b304abcbbef2cc2;f30d40d777989e74d8c4f9f4ee60995d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-233.6641,-82.18748;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;-497.7213,-473.9015;Float;False;Property;_CloseColor;CloseColor;1;1;[HDR];Create;True;0;0;False;0;0,0,0,0;63.25359,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;133.0544,-187.5821;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;TV/Perso/Effect;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.08;True;False;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;14;1
WireConnection;15;1;14;2
WireConnection;7;0;15;0
WireConnection;7;1;2;0
WireConnection;16;0;14;3
WireConnection;16;1;14;4
WireConnection;13;0;2;2
WireConnection;17;0;2;2
WireConnection;5;0;7;0
WireConnection;5;2;16;0
WireConnection;4;0;19;0
WireConnection;4;1;5;0
WireConnection;18;0;13;0
WireConnection;18;1;17;0
WireConnection;0;2;10;0
WireConnection;0;9;18;0
WireConnection;0;10;4;2
ASEEND*/
//CHKSM=01BA2247A81E730AF5411DBCF2F07096F36891B9