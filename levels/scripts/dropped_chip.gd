class_name Chip

extends Area2D

@export_enum("Basic Chip","Control Chip","AI Chip","Processor") var type = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("type_"+str(type+1))



func _on_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		if(body is Player):
			GlobalValues.chips_got[type] += 1
			$sound.play()
			$AnimatedSprite2D.queue_free()
			$CollisionShape2D.queue_free()
			


func _on_sound_finished() -> void:
	queue_free()
