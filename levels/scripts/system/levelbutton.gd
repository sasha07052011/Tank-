class_name LevelButton

extends Node2D

@export var locked = true
@export var num = 100
@export var level: PackedScene

func _ready() -> void:
	$Label.text = str(num)
	if(locked):
		$TextureButton.hide()
		$Label.hide()
		$Sprite2D.show()
	else:
		$Sprite2D.hide()
	GlobalValues.start_per = false


func _on_texture_button_button_down() -> void:
	GlobalValues.curent_level = level
	GlobalValues.start_per = true
