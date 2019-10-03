// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/Ground"
{
	Properties
	{
		_T_Lave_Albedo("T_Lave_Albedo", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0,0,0,0)
		[HDR]_LavaEmissive("LavaEmissive", Color) = (0,0,0,0)
		_T_Paradise_Ground("T_Paradise_Ground", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _T_Lave_Albedo;
		uniform float2 _Tiling;
		uniform sampler2D _T_Paradise_Ground;
		uniform float4 _LavaEmissive;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord25 = i.uv_texcoord * _Tiling;
			float2 panner26 = ( 1.0 * _Time.y * float2( 0,0 ) + uv_TexCoord25);
			float2 UV28 = panner26;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float LerpMask13 = ( 1.0 - step( ase_vertex3Pos.y , 0.0 ) );
			float4 lerpResult5 = lerp( tex2D( _T_Lave_Albedo, UV28 ) , tex2D( _T_Paradise_Ground, UV28 ) , LerpMask13);
			o.Albedo = lerpResult5.rgb;
			o.Emission = ( float4( 0,0,0,0 ) * _LavaEmissive ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;496;1048;504;1497.442;-198.8584;1.313721;True;False
Node;AmplifyShaderEditor.Vector2Node;31;-2710.27,343.7801;Float;False;Property;_Tiling;Tiling;3;0;Create;True;0;0;False;0;0,0;20,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PosVertexDataNode;2;-2433.276,628.2429;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-2395.503,254.2474;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;7;-2222.146,619.3424;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;26;-2080.989,298.5055;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;9;-2097.147,608.3425;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-1843.574,358.1355;Float;False;UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1913.214,632.3105;Float;False;LerpMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-1164.874,-371.2656;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-1221.344,-211.7807;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;35;-320.6024,555.5452;Float;False;Property;_LavaEmissive;LavaEmissive;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;4,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-900.5613,-421.4714;Float;True;Property;_T_Lave_Albedo;T_Lave_Albedo;0;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;358a22d793cc595419e3d1a5d3b74114;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;37;-905.2794,-213.3086;Float;True;Property;_T_Paradise_Ground;T_Paradise_Ground;5;0;Create;True;0;0;False;0;aa87dc0fcbd29aa4094bb04dc5136b03;aa87dc0fcbd29aa4094bb04dc5136b03;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;14;-744.5658,60.19659;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;5;-486.141,-208.2097;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-19.57452,516.0439;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;43;-776.2778,150.0485;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1360.096,-18.66187;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;44;-591.4604,394.7361;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1147.65,254.8928;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-1055.361,379.684;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;37050f958641f4245a3e46f24185aa86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;34;-1289.096,426.3381;Float;False;28;UV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;16;-1127.272,-5.469924;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;358a22d793cc595419e3d1a5d3b74114;e0c6f78029264d64592684f9e108adb4;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1050.812,672.2687;Float;False;13;LerpMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;439.0625,224.8406;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/Ground;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;31;0
WireConnection;7;0;2;2
WireConnection;26;0;25;0
WireConnection;9;0;7;0
WireConnection;28;0;26;0
WireConnection;13;0;9;0
WireConnection;15;1;32;0
WireConnection;37;1;42;0
WireConnection;5;0;15;0
WireConnection;5;1;37;0
WireConnection;5;2;14;0
WireConnection;36;1;35;0
WireConnection;43;0;16;0
WireConnection;43;2;18;0
WireConnection;44;0;23;0
WireConnection;44;2;21;0
WireConnection;23;1;34;0
WireConnection;16;1;33;0
WireConnection;0;0;5;0
WireConnection;0;2;36;0
ASEEND*/
//CHKSM=8A35DC8C16061925D373BBBDB06BE779169122C4