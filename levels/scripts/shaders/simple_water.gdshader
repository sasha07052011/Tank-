shader_type canvas_item;

uniform vec4 color: source_color;
uniform float mix_coof = 0.7;
uniform float scale_tex = 10.0;
uniform float wave_speed = 0.005;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float t = TIME*wave_speed;
	vec4 tex = texture(TEXTURE,vec2(UV.x+t,UV.y+t)*scale_tex)/20.0;
	COLOR = color;
	COLOR = COLOR+tex;
	COLOR.a = mix_coof;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
