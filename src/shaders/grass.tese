#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

layout(location = 0) out vec3 outPosition;
layout(location = 1) out vec3 outNormal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	// paper formula: 6.3 Blade Geometry

	vec3 v0 = vec3(inV0[0]).xyz;
	vec3 v1 = vec3(inV1[0]).xyz;
	vec3 v2 = vec3(inV2[0]).xyz;

	//width w of the blade
	float w = inV2[0].w;
	//bitangent t1 is given directly by the direction vector along the width of the blade
	vec3 t1 = normalize(vec3(cos(inV0[0].w), 0.0, sin(inV0[0].w)));

	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);

	vec3 c0 = c - w * t1;
	vec3 c1 = c + w * t1;
	vec3 t0 = normalize(b-a);
	vec3 n = normalize(cross(t0, t1));

	// t = u
	vec3 position = (1.0 - u) * c0 + u * c1;
	outPosition = position;
	outNormal = n;

	gl_Position = camera.proj * camera.view * vec4(position,1.0);
	gl_Position = gl_Position + vec4(0.0, 0.0, 0.0, 1.0);
}
