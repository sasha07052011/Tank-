extends Node2D

@export var l = true

func _ready():
	if(!l): $PointLight2D.hide()

func _on_area_2d_body_entered(body):
	body.speed_bonus += 0.5
	queue_free()
