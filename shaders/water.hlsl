Texture2D shaderTexture : register(t0);
SamplerState samplerState : register(s0);

cbuffer PixelShaderSettings : register(b0) {
    float  Time;
    float  Scale;
    float2 Resolution;
    float4 Background;
};

#define PI 3.14159265359

// Hash for deterministic pseudo-random raindrop positions & timing
float2 Hash2D(float id) {
    return frac(sin(float2(id * 127.1, id * 311.7)) * 43758.5453);
}

// Computes wave normal displacement and caustic light refraction for an expanding ripple
float3 CalculateRipple(float2 uv, float2 dropCenter, float dropTime) {
    if (dropTime < 0.0 || dropTime > 3.2) return float3(0.0, 0.0, 0.0);

    float2 toCenter = uv - dropCenter;
    float dist = length(toCenter);
    float2 dir = (dist > 0.0001) ? (toCenter / dist) : float2(0.0, 0.0);

    // Wave ring speed & expansion
    float speed = 0.28;
    float waveRadius = dropTime * speed;
    float waveDist = dist - waveRadius;

    // Harmonic multi-ring pulse
    float ringThickness = 0.10;
    if (abs(waveDist) < ringThickness) {
        // Physical damping over time & radius
        float damp = exp(-dropTime * 1.35) / (1.0 + dist * 4.0);

        // Sinusoidal wave phase with secondary trailing harmonic
        float phase = (waveDist / ringThickness) * PI;
        float height = cos(phase) * damp;
        float slope = -sin(phase) * damp * (PI / ringThickness);

        // Vector normal displacement
        float2 normalOffset = dir * slope * 0.014;

        // Sunlight caustic specular glint on the wave crest
        float2 lightDir = normalize(float2(-0.7, -0.7));
        float spec = pow(max(0.0, dot(dir, -lightDir)), 8.0) * max(0.0, height) * 2.2;

        return float3(normalOffset, spec);
    }

    return float3(0.0, 0.0, 0.0);
}

float4 main(float4 pos : SV_POSITION, float2 tex : TEXCOORD) : SV_TARGET {
    float aspect = Resolution.x / Resolution.y;
    float2 uv = tex;
    float2 aspectUV = float2(uv.x * aspect, uv.y);

    float2 totalNormalOffset = float2(0.0, 0.0);
    float totalSpec = 0.0;

    // 3 staggered raindrops falling across the viewport
    [unroll]
    for (int i = 0; i < 3; i++) {
        float period = 3.6 + float(i) * 0.9;
        float cycle = (Time + float(i) * 2.1) / period;
        float dropId = floor(cycle) * 11.0 + float(i);
        float dropTime = frac(cycle) * period;

        float2 posSeed = Hash2D(dropId);
        float2 dropCenter = float2(posSeed.x * aspect, posSeed.y);

        float3 ripple = CalculateRipple(aspectUV, dropCenter, dropTime);
        totalNormalOffset += ripple.xy;
        totalSpec += ripple.z;
    }

    // 1. Refract text and transparent wallpaper directly through the ripple rings
    float2 refractedUV = uv + totalNormalOffset;
    float4 textCol = shaderTexture.Sample(samplerState, refractedUV);

    // 2. Cyan caustic flare + white crest highlights
    float3 glintColor = float3(0.1, 0.85, 1.0) * totalSpec * 0.55 + float3(1.0, 1.0, 1.0) * pow(totalSpec, 3.0) * 0.35;

    // 3. Composite output preserving background transparency
    float3 finalRgb = textCol.rgb + glintColor;
    float finalAlpha = max(textCol.a, totalSpec * 0.35);

    return float4(finalRgb, finalAlpha);
}











