extends Node2D

var f
var bg
var u = false
var next_stage = "res://levels/worlds/world1.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalValues.pause = false
	$background/Player/Camera2D/CanvasLayer.hide()
	$background/Player/Camera2D.enabled = false
	GlobalValues.exit_per = false
	GlobalValues.start_per = true
	var fl = FileAccess.open("user://color.json",FileAccess.READ)
	if(fl!=null):
		var text = JSON.parse_string(fl.get_as_text())
		GlobalValues.color.r = text["r"]
		GlobalValues.color.g = text["g"]
		GlobalValues.color.b = text["b"]
		GlobalValues.color.a = text["a"]
		GlobalValues.water_type = text["water_type"]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("fullscreen")):
		f = !f
		if(f):
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
	#print(OS.get_name())


func _on_start_pressed():
	GlobalValues.exit_per = true
	next_stage = "res://levels/worlds/select_level.tscn"
	GlobalValues.chips_got = [0,0,0,0]
	$LoadLevel.exit()


func _on_exit_pressed():
	get_tree().quit()




func _on_sprite_2d_pressed():
	get_tree().change_scene_to_file("res://levels/worlds/Test2.tscn")
	GlobalValues.chips_got = [0,0,0,0]


func _on_texture_button_pressed():
	$background/Player/Camera2D/CanvasLayer.show()
	$background/Player/Camera2D/CanvasLayer/DebugConsole.hide()
	$background/Player/Camera2D/CanvasLayer/health.hide()
	$background/Player/Camera2D/CanvasLayer/world.hide()
	$background/Player/Camera2D/CanvasLayer/Label.hide()
	$background/Player/Camera2D/CanvasLayer/pause.hide()
	$background/Player/Camera2D/CanvasLayer/menub.hide()
	$background/Player/Camera2D/CanvasLayer/pauseb.hide()
	$background/Player/Camera2D/CanvasLayer/TouchScreenButton.hide()


func _on_texture_button_button_down() -> void:
	next_stage = "res://levels/worlds/settings.tscn"
	$LoadLevel.exit()
	GlobalValues.exit_per = true



func _on_load_level_ex() -> void:
	if(GlobalValues.exit_per):
		get_tree().change_scene_to_file(next_stage)
