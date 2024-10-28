#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inNormal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    float gradient = inPosition.y;
    vec3 bottomColor = vec3(0.1, 0.6, 0.1);
    vec3 topColor = vec3(0.4, 0.9, 0.4);
    //vec3 color = mix(bottomColor, topColor, clamp(gradient, 0.0, 1.0));   
    //outColor = vec4(color, 1.0);

    //lighting
    vec3 lightDir = normalize(vec3(1.0, 1.0, 0.0));
    float intensity = max(dot(inNormal, lightDir), 0.0);
    vec3 baseColor = vec3(0.4, 0.9, 0.4);
    vec3 color = intensity * baseColor;
    outColor = vec4(color, 1.0);
    //outColor = vec4(1.0);
}
