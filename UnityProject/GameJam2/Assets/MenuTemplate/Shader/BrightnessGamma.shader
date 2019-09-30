Shader "Settings/BrightnessGamma" {

    Properties 
	{
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }
 
    SubShader 
	{
        Pass 
		{
            ZTest Always Cull Off ZWrite Off
             
           CGPROGRAM
           #pragma vertex vert_img
           #pragma fragment frag
           #include "UnityCG.cginc"
 
           uniform sampler2D _MainTex;
           uniform float _Brightness;
		   uniform float _Gamma;

           fixed4 frag (v2f_img i) : SV_Target {

		       float4 screen = tex2D(_MainTex, i.uv);
	           float4 color;	
			   
	           color.r = pow(screen.r, _Gamma);
	           color.g = pow(screen.g, _Gamma);
	           color.b = pow(screen.b, _Gamma);
	           color.a = screen.a;

               return color * _Brightness;
           }
           ENDCG
        }
    }
 
    Fallback off
}