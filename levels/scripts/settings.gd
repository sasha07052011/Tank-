extends Node2D

var f = false
@export var bg: Sprite2D = null
var sw_pressed = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalValues.exit_per = false
	GlobalValues.start_per = true
	bg.position.x = 0
	$ColorPicker.color = GlobalValues.color
	if(GlobalValues.water_type == 0):
		$simple_water.button_pressed = true
	else:
		$simple_water.button_pressed = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalValues.color = $ColorPicker.color
	RenderingServer.global_shader_parameter_set("color", GlobalValues.color)
	if(GlobalValues.start_per):
		if(bg.position.x<get_viewport_rect().size.x):
			bg.position.x+=40
		else:
			GlobalValues.start_per = false
	if(GlobalValues.exit_per):
		if(bg.position.x>0):
			bg.position.x-=40
		else:
			get_tree().change_scene_to_file("res://levels/worlds/menu.tscn")
	if($simple_water.button_pressed):
		GlobalValues.water_type = 0
	else:
		GlobalValues.water_type = 1


func _on_menub_pressed() -> void:
	GlobalValues.exit_per = true
	var file = FileAccess.open("user://color.json",FileAccess.WRITE)
	var c = GlobalValues.color
	var t = 0
	if($simple_water.button_pressed):
		t = 0
	else:
		t = 1
	var str = "{\n\"r\":"+str(c.r)+",\n\"g\":"+str(c.g)+",\n\"b\":"+str(c.b)+",\n\"a\":"+str(c.a)+",\n\"water_type\":"+str(t)+"\n}"
	file.store_string(str)
