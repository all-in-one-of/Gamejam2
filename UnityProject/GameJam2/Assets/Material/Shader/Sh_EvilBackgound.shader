// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GJ2/EvilBrackground"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0,0,0,0)
		[HDR]_SecondColor("SecondColor", Color) = (0,0,0,0)
		_T_Os_Normal("T_Os_Normal", 2D) = "bump" {}
		_T_Os_SME("T_Os_SME", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _T_Os_Normal;
		uniform float2 _Tiling;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _T_Os_SME;
		uniform float4 _SecondColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord2 = i.uv_texcoord * _Tiling;
			o.Normal = UnpackNormal( tex2D( _T_Os_Normal, uv_TexCoord2 ) );
			o.Albedo = tex2D( _TextureSample0, uv_TexCoord2 ).rgb;
			float4 tex2DNode7 = tex2D( _T_Os_SME, uv_TexCoord2 );
			o.Emission = ( tex2DNode7.b * _SecondColor ).rgb;
			o.Metallic = tex2DNode7.g;
			o.Smoothness = tex2DNode7.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;517;1069;523;912.5267;-459.5334;1.247727;True;False
Node;AmplifyShaderEditor.Vector2Node;3;-1090.131,108.2789;Float;False;Property;_Tiling;Tiling;1;0;Create;True;0;0;False;0;0,0;15,-1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-839.2304,77.37893;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-118.7836,405.0702;Float;True;Property;_T_Os_SME;T_Os_SME;4;0;Create;True;0;0;False;0;2542e9aecdc769f41a7c84dd00f7eebf;37050f958641f4245a3e46f24185aa86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-72.66649,659.9632;Float;False;Property;_SecondColor;SecondColor;2;1;[HDR];Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-472.6304,-3.521059;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;358a22d793cc595419e3d1a5d3b74114;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-136.9836,171.0702;Float;True;Property;_T_Os_Normal;T_Os_Normal;3;0;Create;True;0;0;False;0;220bd8adda3cae243a37d33348c992e6;e0c6f78029264d64592684f9e108adb4;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;262.4984,539.3965;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;594.4078,279.5835;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;GJ2/EvilBrackground;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;7;1;2;0
WireConnection;1;1;2;0
WireConnection;6;1;2;0
WireConnection;4;0;7;3
WireConnection;4;1;5;0
WireConnection;0;0;1;0
WireConnection;0;1;6;0
WireConnection;0;2;4;0
WireConnection;0;3;7;2
WireConnection;0;4;7;1
ASEEND*/
//CHKSM=3888CC95E1FBB7D4C16ECBC2C5599DDC74AF707B