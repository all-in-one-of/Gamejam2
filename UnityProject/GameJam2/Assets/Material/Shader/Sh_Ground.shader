// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Ground"
{
	Properties
	{
		_EVILBASE("EVILBASE", 2D) = "white" {}
		_EVILNORMAL("EVILNORMAL", 2D) = "bump" {}
		_ANGELNORMAL("ANGELNORMAL", 2D) = "bump" {}
		_EVILSME("EVILSME", 2D) = "white" {}
		_ANGELSME("ANGELSME", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0,0,0,0)
		_ANGELBASE("ANGELBASE", 2D) = "white" {}
		_AngelNormalScale("AngelNormalScale", Float) = 0
		[HDR]_EmissiveColor("EmissiveColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _EVILNORMAL;
		uniform float2 _Tiling;
		uniform float _AngelNormalScale;
		uniform sampler2D _ANGELNORMAL;
		uniform sampler2D _EVILBASE;
		uniform sampler2D _ANGELBASE;
		uniform sampler2D _EVILSME;
		uniform sampler2D _ANGELSME;
		uniform float4 _EmissiveColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord25 = i.uv_texcoord * _Tiling;
			float2 panner26 = ( 1.0 * _Time.y * float2( 0,0 ) + uv_TexCoord25);
			float2 UV28 = panner26;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float LerpMask13 = ( 1.0 - step( ase_vertex3Pos.y , 0.0 ) );
			float3 lerpResult43 = lerp( UnpackNormal( tex2D( _EVILNORMAL, UV28 ) ) , UnpackScaleNormal( tex2D( _ANGELNORMAL, UV28 ), _AngelNormalScale ) , LerpMask13);
			o.Normal = lerpResult43;
			float4 lerpResult5 = lerp( tex2D( _EVILBASE, UV28 ) , tex2D( _ANGELBASE, UV28 ) , LerpMask13);
			o.Albedo = lerpResult5.rgb;
			float4 lerpResult44 = lerp( tex2D( _EVILSME, UV28 ) , tex2D( _ANGELSME, UV28 ) , LerpMask13);
			float4 break47 = lerpResult44;
			o.Emission = ( break47.b * _EmissiveColor ).rgb;
			o.Metallic = break47.g;
			o.Smoothness = break47;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;517;1069;523;453.446;-125.636;1;True;False
Node;AmplifyShaderEditor.Vector2Node;31;-2710.27,343.7801;Float;False;Property;_Tiling;Tiling;5;0;Create;True;0;0;False;0;0,0;20,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PosVertexDataNode;2;-2433.276,628.2429;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-2395.503,254.2474;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;26;-2080.989,298.5055;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;7;-2222.146,619.3424;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-1843.574,358.1355;Float;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;9;-2097.147,608.3425;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1913.214,632.3105;Float;False;LerpMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-1289.096,426.3381;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-1377.172,623.4636;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;45;-1142.437,576.8096;Float;True;Property;_ANGELSME;ANGELSME;4;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;4e118d26fd226644b9b7bfa1881b7cee;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1060.816,787.3194;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-1055.361,379.684;Float;True;Property;_EVILSME;EVILSME;3;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;37050f958641f4245a3e46f24185aa86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;48;-1535.22,109.1387;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1221.344,-211.7807;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-1505.742,237.7541;Float;False;Property;_AngelNormalScale;AngelNormalScale;7;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1504.373,-92.43974;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;44;-598.9637,539.8002;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1164.874,-371.2656;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;47;-350.2568,380.2646;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;49;-1302.396,122.3306;Float;True;Property;_ANGELNORMAL;ANGELNORMAL;2;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;5d6ac5d4c73cec44e9a98e2118dd2a96;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;14;-716.6942,14.29036;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1182.08,315.5545;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1271.549,-79.2478;Float;True;Property;_EVILNORMAL;EVILNORMAL;1;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;e0c6f78029264d64592684f9e108adb4;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-900.5613,-421.4714;Float;True;Property;_EVILBASE;EVILBASE;0;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;358a22d793cc595419e3d1a5d3b74114;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-905.2794,-213.3086;Float;True;Property;_ANGELBASE;ANGELBASE;6;0;Create;True;0;0;False;0;None;8cb668050ae62c34a98e834356acc265;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;-376.2153,614.3412;Float;False;Property;_EmissiveColor;EmissiveColor;8;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;43;-697.5814,138.5719;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-91.12396,557.8888;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;5;-486.141,-208.2097;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;439.0625,224.8406;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/Ground;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;31;0
WireConnection;26;0;25;0
WireConnection;7;0;2;2
WireConnection;28;0;26;0
WireConnection;9;0;7;0
WireConnection;13;0;9;0
WireConnection;45;1;46;0
WireConnection;23;1;34;0
WireConnection;44;0;23;0
WireConnection;44;1;45;0
WireConnection;44;2;21;0
WireConnection;47;0;44;0
WireConnection;49;1;48;0
WireConnection;49;5;50;0
WireConnection;16;1;33;0
WireConnection;15;1;32;0
WireConnection;37;1;42;0
WireConnection;43;0;16;0
WireConnection;43;1;49;0
WireConnection;43;2;18;0
WireConnection;51;0;47;2
WireConnection;51;1;52;0
WireConnection;5;0;15;0
WireConnection;5;1;37;0
WireConnection;5;2;14;0
WireConnection;0;0;5;0
WireConnection;0;1;43;0
WireConnection;0;2;51;0
WireConnection;0;3;47;1
WireConnection;0;4;47;0
ASEEND*/
//CHKSM=F18D7C16F4AF99F7DC09549666403A2DB38AD586