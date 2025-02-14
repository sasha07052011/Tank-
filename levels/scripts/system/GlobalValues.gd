extends Node2D

var pause = false
var world = "TEST"
var max_score = 0
var player = null
var score = 0
var finish = false
var hp = 0
var radiation = 0
var reload = false
var starthp = 50
var in_menu = false
var color = Color(1,0.3,0,1)
var start_per = true
var exit_per = false
var water_type = 1
var chips_got = [0,0,0,0]
var f = false
var load_effect: Per
var curent_level: PackedScene

func _process(delta: float) -> void:
	radiation = floor(radiation*10)/10
	if(Input.is_action_just_pressed("fullscreen")):
		f = !f
		if(f):
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
	if(Input.is_key_pressed(KEY_Q)):
		get_tree().quit()
