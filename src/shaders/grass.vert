
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
//Declared in Blades.h
layout(location = 0) in vec4 inV0;
layout(location = 1) in vec4 inV1;
layout(location = 2) in vec4 inV2;
layout(location = 3) in vec4 inUp;

layout(location = 0) out vec4 outV0;
layout(location = 1) out vec4 outV1;
layout(location = 2) out vec4 outV2;
layout(location = 3) out vec4 outUp;

out gl_PerVertex {
    vec4 gl_Position;
	//ERROR DEBUGG: pass emtpy arrays to avoid error
	//float gl_PointSize;
    //float gl_ClipDistance[];
    //float gl_CullDistance[];
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
	outV0 = model * inV0;
	outV1 = model * inV1;
	outV2 = model * inV2;
	outUp = model * inUp;
	// Use the V0 position as the output position
	gl_Position = outV0;
}
