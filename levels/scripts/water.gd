extends Node2D

@export var water_color: Color = Color(0,144/255,82/255,1)
@export var waves_size = 10.0
@export var uv_move_texture: Texture = null
@export var mix_coof = 0.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(GlobalValues.water_type == 0):
		$WavesTextureSimple.show()
		$WavesTextureSimple.material.set_shader_parameter("color",water_color)
		$WavesTextureSimple.material.set_shader_parameter("scale_tex",waves_size)
		$WavesTextureSimple.material.set_shader_parameter("mix_coof",mix_coof)
		$WavesTextureMedium.hide()
	else:
		$WavesTextureMedium.show()
		$WavesTextureMedium.material.set_shader_parameter("color",water_color)
		$WavesTextureMedium.material.set_shader_parameter("scale_t_w",waves_size)
		$WavesTextureMedium.material.set_shader_parameter("mix_colors",mix_coof)
		if(uv_move_texture != null):
			$WavesTextureMedium.material.set_shader_parameter("wave_noise",uv_move_texture)
		$WavesTextureSimple.hide()
