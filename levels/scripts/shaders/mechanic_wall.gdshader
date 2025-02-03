shader_type canvas_item;

uniform float time = 0;
uniform float max_t = 16.0;

uniform vec4 rp_color: source_color = vec4(1,1,1,1);
uniform vec4 new_color: source_color = vec4(1,0,0,1);

void vertex() {
}

void fragment() {
	vec2 uv = UV + vec2(0,time/max_t);
	vec4 tex = texture(TEXTURE,uv);
	COLOR = tex;
	if(uv.y < 1.0){
		COLOR.a = 0.0;
	}
	if(tex == rp_color){
		COLOR = new_color;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
