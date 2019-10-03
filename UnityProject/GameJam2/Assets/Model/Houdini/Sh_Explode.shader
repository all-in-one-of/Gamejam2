// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Explode"
{
	Properties
	{
		_BlastRadius("Blast Radius", Range( 1 , 15)) = 0
		_BlastIntensity("BlastIntensity", Float) = 0
		_LocalUpVector("LocalUpVector", Vector) = (0,1,0,0)
		_Rotationrate("Rotation rate", Float) = 0
		_Chaos("Chaos", Float) = 0
		_Player1("Player1", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		uniform float3 _LocalUpVector;
		uniform float _Player1;
		uniform float3 P1;
		uniform float3 P2;
		uniform float _BlastRadius;
		uniform float _Chaos;
		uniform float _Rotationrate;
		uniform float _BlastIntensity;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 appendResult3 = (float4(( v.texcoord1.xy.x * -1.0 ) , v.texcoord1.xy.y , v.texcoord2.xy.x , 1.0));
			float4 RebuildedUVs41 = appendResult3;
			float4 transform11 = mul(unity_ObjectToWorld,RebuildedUVs41);
			float4 temp_output_16_0 = ( transform11 - float4( (( _Player1 == 1.0 ) ? P1 :  P2 ) , 0.0 ) );
			float4 normalizeResult24 = normalize( temp_output_16_0 );
			float4 appendResult27 = (float4((normalizeResult24).xyz , 0.0));
			float4 transform25 = mul(unity_WorldToObject,appendResult27);
			float4 ExplosionDirection46 = transform25;
			float3 normalizeResult34 = normalize( cross( _LocalUpVector , ExplosionDirection46.xyz ) );
			float Chaos67 = ( v.texcoord2.xy.y * _Chaos );
			float smoothstepResult19 = smoothstep( 0.0 , -5.0 , ( ( length( temp_output_16_0 ) - _BlastRadius ) - Chaos67 ));
			float ExplosionRadius50 = smoothstepResult19;
			float temp_output_37_0 = ( ExplosionRadius50 * _Rotationrate );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 rotatedValue31 = RotateAroundAxis( RebuildedUVs41.xyz, ( float4( ase_vertex3Pos , 0.0 ) - ( ( float4( ase_vertex3Pos , 0.0 ) - RebuildedUVs41 ) * ExplosionRadius50 ) ).xyz, normalizeResult34, temp_output_37_0 );
			float3 ProjectilesDirectionRotation58 = ( rotatedValue31 - ase_vertex3Pos );
			float4 ExplosionBlastIntensity48 = ( ExplosionRadius50 * ExplosionDirection46 * _BlastIntensity );
			v.vertex.xyz += ( float4( ProjectilesDirectionRotation58 , 0.0 ) + ExplosionBlastIntensity48 ).xyz;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 rotatedValue70 = RotateAroundAxis( float3( 0,0,0 ), ase_vertexNormal, normalizeResult34, temp_output_37_0 );
			float3 ProjectilesNormals74 = rotatedValue70;
			v.normal = ProjectilesNormals74;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = i.vertexColor.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16900
0;370;1100;670;3974.562;413.3002;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;44;-3315.24,235.4451;Float;False;1154.103;632.1405;Comment;11;41;3;2;23;4;5;6;1;66;65;67;RebuildedUVs(Pivot)+Chaos;0.8867924,0.5288417,0.2133321,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-3265.04,414.019;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;6;-3021.887,338.345;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2978.587,356.945;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-3265.24,535.2189;Float;False;2;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2825.263,580.4719;Float;False;Constant;_Float3;Float 3;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-2809.586,285.4452;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;3;-2619.619,385.4033;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-2430.216,380.0163;Float;False;RebuildedUVs;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;55;-3667.061,-464.6866;Float;False;2302.564;599.6224;Comment;18;80;10;50;46;19;68;21;20;69;18;13;17;16;77;11;42;81;82;ExplosionCenter+Direction+Radius;0.5817385,0.499822,0.9056604,1;0;0
Node;AmplifyShaderEditor.Vector3Node;80;-3644.018,-38.6151;Float;False;Global;P2;P2;0;0;Create;True;0;0;False;0;0,0,0;1.869969,-0.75,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;82;-3410.562,-227.3002;Float;False;Property;_Player1;Player1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-3602.061,-338.742;Float;False;41;RebuildedUVs;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;10;-3631.85,-214.3022;Float;False;Global;P1;P1;0;0;Create;True;0;0;False;0;0,0,0;0.4299688,0.75,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCCompareEqual;81;-3331.562,-131.3002;Float;False;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-3194.027,741.0391;Float;False;Property;_Chaos;Chaos;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;11;-3318.639,-391.5195;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;16;-3078.278,-220.3189;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;77;-2707.438,-178.2831;Float;False;948.6416;252;détermine la direction de l'explosion (vers où les projectiles vont voler);4;26;24;27;25;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-2942.641,698.2714;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;17;-2743.213,-414.6866;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2826.356,-281.029;Float;False;Property;_BlastRadius;Blast Radius;0;0;Create;True;0;0;False;0;0;4;1;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;24;-2664.672,-89.26131;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-2659.951,749.3842;Float;False;Chaos;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;-2493.594,-93.50082;Float;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-2483.127,-399.7292;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-2324.474,-324.3432;Float;False;67;Chaos;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2477.622,-287.4429;Float;False;Constant;_Float2;Float 2;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-2122.459,-400.0425;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2487.39,-198.1036;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;-5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;27;-2273.592,-90.50082;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SmoothstepOpNode;19;-1939.878,-289.2355;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;25;-1993.03,-135.5167;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;76;-1099.591,264.9739;Float;False;952.0032;474.6107;Projectiles se réduisent dans le temps;6;64;63;60;62;39;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;57;-1064.45,-246.3992;Float;False;1830.469;959.8749;Comment;17;58;40;56;31;34;37;43;36;33;51;47;32;70;71;72;73;74;ProjectilesDirection+Rotation;0.4656461,0.9056604,0.5805165,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;50;-1691.671,-283.5515;Float;False;ExplosionRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-1052.428,519.0958;Float;False;41;RebuildedUVs;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;39;-911.4966,314.9738;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-1694.515,-125.8544;Float;False;ExplosionDirection;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1002.688,-40.14281;Float;False;46;ExplosionDirection;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;62;-1033.559,624.4578;Float;False;50;ExplosionRadius;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;32;-911.3177,-196.3992;Float;False;Property;_LocalUpVector;LocalUpVector;2;0;Create;True;0;0;False;0;0,1,0;0,1,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;60;-692.2847,499.6495;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CrossProductOpNode;33;-667.106,-67.92664;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-748.8766,68.94686;Float;False;50;ExplosionRadius;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-702.994,142.3544;Float;False;Property;_Rotationrate;Rotation rate;3;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-483.1339,606.5845;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-487.725,191.7535;Float;False;41;RebuildedUVs;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalizeNode;34;-466.6876,-63.59354;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-440.4556,75.81327;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;54;-2111.093,307.6698;Float;False;930.1791;333.7672;Comment;5;48;28;53;29;52;BlastIntensity;0.9433962,0.2358491,0.2358491,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;64;-324.4253,508.3541;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;56;143.3885,320.6111;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-2016.113,526.4372;Float;False;Property;_BlastIntensity;BlastIntensity;1;0;Create;True;0;0;False;0;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;53;-2061.094,441.6868;Float;False;46;ExplosionDirection;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;31;-148.6644,127.133;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-2041.857,357.6698;Float;False;50;ExplosionRadius;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;40;219.4186,173.1334;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalVertexDataNode;71;-162.982,-79.39952;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;73;-254.2061,-117.3397;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1671.018,452.2341;Float;False;3;3;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WireNode;72;-277.7137,-181.5943;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-1487.916,464.3615;Float;False;ExplosionBlastIntensity;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;413.0533,171.6184;Float;False;ProjectilesDirectionRotation;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;70;60.86742,-173.7146;Float;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;1065.174,260.7965;Float;False;48;ExplosionBlastIntensity;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;426.2775,-115.4444;Float;False;ProjectilesNormals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;1034.254,186.9554;Float;False;58;ProjectilesDirectionRotation;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;1352.228,216.6743;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;9;1313.383,-105.8403;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;75;1095.927,365.2463;Float;False;74;ProjectilesNormals;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1573.239,-8.884166;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Explode;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;1;1
WireConnection;4;0;6;0
WireConnection;4;1;5;0
WireConnection;3;0;4;0
WireConnection;3;1;1;2
WireConnection;3;2;2;1
WireConnection;3;3;23;0
WireConnection;41;0;3;0
WireConnection;81;0;82;0
WireConnection;81;2;10;0
WireConnection;81;3;80;0
WireConnection;11;0;42;0
WireConnection;16;0;11;0
WireConnection;16;1;81;0
WireConnection;65;0;2;2
WireConnection;65;1;66;0
WireConnection;17;0;16;0
WireConnection;24;0;16;0
WireConnection;67;0;65;0
WireConnection;26;0;24;0
WireConnection;18;0;17;0
WireConnection;18;1;13;0
WireConnection;68;0;18;0
WireConnection;68;1;69;0
WireConnection;27;0;26;0
WireConnection;19;0;68;0
WireConnection;19;1;21;0
WireConnection;19;2;20;0
WireConnection;25;0;27;0
WireConnection;50;0;19;0
WireConnection;46;0;25;0
WireConnection;60;0;39;0
WireConnection;60;1;61;0
WireConnection;33;0;32;0
WireConnection;33;1;47;0
WireConnection;63;0;60;0
WireConnection;63;1;62;0
WireConnection;34;0;33;0
WireConnection;37;0;51;0
WireConnection;37;1;36;0
WireConnection;64;0;39;0
WireConnection;64;1;63;0
WireConnection;56;0;39;0
WireConnection;31;0;34;0
WireConnection;31;1;37;0
WireConnection;31;2;43;0
WireConnection;31;3;64;0
WireConnection;40;0;31;0
WireConnection;40;1;56;0
WireConnection;73;0;37;0
WireConnection;28;0;52;0
WireConnection;28;1;53;0
WireConnection;28;2;29;0
WireConnection;72;0;34;0
WireConnection;48;0;28;0
WireConnection;58;0;40;0
WireConnection;70;0;72;0
WireConnection;70;1;73;0
WireConnection;70;3;71;0
WireConnection;74;0;70;0
WireConnection;38;0;59;0
WireConnection;38;1;49;0
WireConnection;0;0;9;0
WireConnection;0;11;38;0
WireConnection;0;12;75;0
ASEEND*/
//CHKSM=7822F22342BAF77658C43031A3A8CC0E2B203464