extends Node2D

@export var l = true

func _ready():
	if(!l): $PointLight2D.hide()

func _on_area_2d_body_entered(body):
	body.popus = true
	queue_free()
