shader_type canvas_item;

uniform sampler2D screen_tex: hint_screen_texture;
uniform sampler2D wave_noise;
uniform float mix_colors = 0.7;
uniform float speed_waves = 5.0;
uniform float speed_waves2 = 0.05;
//uniform float size_waves = 10.0;
uniform float forse_coof = 7.0;
uniform float scale_t_w = 10.0;
uniform float n = 10.0;
uniform vec4 color: source_color;
const bool gen_sin = false;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	float t = TIME*speed_waves;
	float t2 = TIME*speed_waves2;
	float move_x, move_y;
	vec2 uv;
	if(gen_sin != true){
	vec2 wn_uv;
	float hm;
	wn_uv.x = ((UV.x*1000.0)+t) - (1000.0 * floor(((UV.x*1000.0)+t)/1000.0));
	wn_uv.y = ((UV.y*1000.0)+t) - (1000.0 * floor(((UV.y*1000.0)+t)/1000.0));
	wn_uv = wn_uv/1000.0;
	vec2 noise = texture(wave_noise,wn_uv).xy;
	//float move_x = sin(t+SCREEN_UV.x*size_waves)/forse_coof;
	//float move_y = cos(t+SCREEN_UV.y*size_waves)/forse_coof;
	move_x = noise.x/forse_coof;
	move_y = noise.y/forse_coof;
	uv = SCREEN_UV+vec2(move_x,move_y);
	}else{
		move_x = sin(UV.x*n+t)/forse_coof;
		move_y = cos(UV.y*n+t)/forse_coof;
		uv = SCREEN_UV+vec2(move_x,move_y);
	}
	/*if(uv.x>1.0){
		uv.x = SCREEN_UV.x;
	}
	if(uv.y>1.0){
		uv.y = SCREEN_UV.y;
	}*/
	vec4 sc = texture(screen_tex,uv);
	vec2 w_t_uv = UV*scale_t_w+vec2(move_x*5.0,move_y*5.0)+t2;
	vec4 wave_texture = texture(TEXTURE,w_t_uv);
	COLOR = mix(sc,color,mix_colors);
	COLOR = COLOR+wave_texture/20.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
