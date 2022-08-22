Shader "Unlit/inspectorShader"
{
    Properties
    {
         _MainTex ("Color (RGB) Alpha (A)", 2D) = "white"

        [Enum(UnityEngine.Rendering.BlendMode)]
        _SrcFactor("Src Factor", Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]
        _DstFactor("Dst Factor", Float) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]
        _Opp("Operation", Float) = 0
    }
    SubShader
    {
        Tags {  "Queue" = "Transparent"
                "RenderType" = "Transparent" 
                "IgnoreProjector" = "True"
                }
        LOD 100

        

        Blend [_SrcFactor] [_DstFactor]
        BlendOp [_Opp]

        //BlendOp ColorDodge


        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                //clip(textureColor.a - alphaCutoffValue);
                return col;
            }
            ENDCG
        }
    }
}
