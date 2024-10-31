#version 450
#extension GL_ARB_separate_shader_objects : enable
#define tessLevelOn 1
layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
// From the vertex shader
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

// To the tessellation evaluation shader
layout(location = 0) out vec4 outV0[];
layout(location = 1) out vec4 outV1[];
layout(location = 2) out vec4 outV2[];
layout(location = 3) out vec4 outUp[];

// Reference from homework page given link: https://ogldev.org/www/tutorial30/tutorial30.html
float getTessLevel(float distance) {
    if (distance < 5.0) {
        return 12.0;
    } else if (distance < 10.0) {
        return 8.0;
    } else {
        return 4.0;
    }
}

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    outV0[gl_InvocationID] = inV0[gl_InvocationID];
    outV1[gl_InvocationID] = inV1[gl_InvocationID];
    outV2[gl_InvocationID] = inV2[gl_InvocationID];
    outUp[gl_InvocationID] = inUp[gl_InvocationID];

    vec3 camPos = (inverse(camera.view)[3]).xyz;
    vec3 bladePos = inV0[gl_InvocationID].xyz;
    float distance = length(camPos - bladePos);
    float tessLevel = getTessLevel(distance);

#if tessLevelOn
	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = tessLevel;
    gl_TessLevelInner[1] = tessLevel;
    gl_TessLevelOuter[0] = tessLevel;
    gl_TessLevelOuter[1] = tessLevel;
    gl_TessLevelOuter[2] = tessLevel;
    gl_TessLevelOuter[3] = tessLevel;
#else
	gl_TessLevelInner[0] = 12.0;
	gl_TessLevelInner[1] = 12.0;
	gl_TessLevelOuter[0] = 12.0;
	gl_TessLevelOuter[1] = 12.0;
	gl_TessLevelOuter[2] = 12.0;
	gl_TessLevelOuter[3] = 12.0;
#endif

}
