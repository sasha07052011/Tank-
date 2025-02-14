extends Node2D

#var buf = false
var f = false

@export_file var scene_exit = "res://levels/world2.tscn"
@export var max_score = 0
@export var player: CharacterBody2D
@export var bg: Sprite2D
@export var w = "TEST"
var old_chips_got = [0,0,0,0]

func m():
	return false

func _ready():
	GlobalValues.reload = false
	GlobalValues.finish = false
	bg.position.x = 0
	GlobalValues.score = 0
	GlobalValues.start_per = true
	GlobalValues.exit_per = false
	old_chips_got = GlobalValues.chips_got

func _process(delta):
	if(Input.is_key_pressed(KEY_Q)):
		get_tree().quit()
	if(Input.is_action_just_pressed("pause")):
		GlobalValues.pause = !GlobalValues.pause
	if(Input.is_action_just_pressed("fullscreen")):
		f = !f
		if(f):
			get_window().mode = Window.MODE_FULLSCREEN
		else:
			get_window().mode = Window.MODE_WINDOWED
	if(GlobalValues.start_per):
		if(bg.position.x<get_viewport_rect().size.x):
			bg.position.x+=40
		else:
			GlobalValues.start_per = false
	if(GlobalValues.finish):
		if(bg.position.x>0):
			bg.position.x-=40
		else:
			get_tree().change_scene_to_file(scene_exit)
	if(GlobalValues.exit_per):
		if(bg.position.x>0):
			bg.position.x-=40
		else:
			get_tree().change_scene_to_file("res://levels/worlds/menu.tscn")
	GlobalValues.world = w
	GlobalValues.max_score = max_score
	if(GlobalValues.reload):
		if(bg.position.x>0):
			bg.position.x-=40
		else:
			GlobalValues.chips_got = old_chips_got
			get_tree().reload_current_scene()
