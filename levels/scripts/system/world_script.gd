extends Node2D

var f = false

@export_file var scene_exit = "res://levels/worlds/menu.tscn"
@export var max_score = 0
@export var w = "TEST"
var ll

func _ready():
	GlobalValues.reload = false
	GlobalValues.finish = false
	GlobalValues.score = 0
	GlobalValues.start_per = true
	GlobalValues.exit_per = false
	ll = $CanvasLayer/LoadLevel

func _process(delta):
	GlobalValues.world = w
	GlobalValues.max_score = max_score


func _on_load_level_ex() -> void:
	if(GlobalValues.exit_per):
		get_tree().change_scene_to_file("res://levels/worlds/menu.tscn")
	elif(GlobalValues.finish):
		get_tree().change_scene_to_file(scene_exit)
	elif(GlobalValues.reload):
		get_tree().reload_current_scene()
		print("POPIS")
