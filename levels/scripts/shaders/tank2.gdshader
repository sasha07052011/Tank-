shader_type canvas_item;

uniform vec4 first_color: source_color = vec4(1,1,1,1);
global uniform vec4 color: source_color = vec4(0.9,0,0,1);
uniform vec4 second_color: source_color = vec4(0,1,0,1);
uniform vec4 tird_color: source_color = vec4(0,0,0,1);
uniform float shadow_coof = 0.4;
uniform bool randbow = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex = texture(TEXTURE,UV);
	vec4 col = color;
	if(randbow){
		col = abs(vec4(sin(TIME),sin(TIME*radians(90.0)),sin(TIME*radians(180.0)),1));
	}
	if(tex == first_color){
		COLOR=col;
	}else if(tex == second_color){
		COLOR=col+vec4(shadow_coof);
	}else if(tex == tird_color){
		COLOR=col-vec4(vec3(shadow_coof),0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
