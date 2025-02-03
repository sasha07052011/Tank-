shader_type canvas_item;

uniform vec4 rp_color: source_color = vec4(1,1,1,1);
uniform vec4 new_color: source_color = vec4(1,0,0,1);

void vertex() {

}

void fragment() {
	vec4 tex = texture(TEXTURE,UV);
	if(tex == rp_color){
		COLOR = new_color;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
