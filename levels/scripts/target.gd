class_name Target

extends Node2D

var kill = false
@export var l = true

func _ready():
	if(!l): $PointLight2D.hide()

func _on_area_2d_body_entered(body):
	if(body is PlayerBull):
		$AnimatedSprite2D.play("kill")
		body.Kill()
		kill = true


func _on_animated_sprite_2d_animation_finished():
	if(kill):
		GlobalValues.score += 1
		$PointLight2D.queue_free()
		$Area2D.queue_free()
