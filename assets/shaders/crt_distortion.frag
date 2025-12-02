#version 320 es
precision highp float;

uniform sampler2D uTexture;
uniform vec2 uSize;

out vec4 fragColor;

// Flutter helper to get pixel coords:
vec2 getUV() {
    // Flutter gives coordinates in pixels through this intrinsic
    vec2 frag = vec2(gl_FragCoord.x, gl_FragCoord.y);
    return frag / uSize;
}

void main() {
    vec2 uv = getUV();

    // shift to center
    vec2 centered = uv - 0.5;

    // barrel distortion strength
    float k = 0.25; // adjust 0.1–0.4

    float r = dot(centered, centered); // radius^2

    // distorted coordinates
    vec2 distorted = uv + centered * r * k;

    // black borders if outside
    if (distorted.x < 0.0 || distorted.x > 1.0 ||
        distorted.y < 0.0 || distorted.y > 1.0) {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }

    fragColor = texture(uTexture, distorted);
}