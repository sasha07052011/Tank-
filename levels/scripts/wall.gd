extends StaticBody2D

var killer = 0

func kill():
	killer = 1
	$AnimatedSprite2D.play("kill")
	$CollisionShape2D.queue_free()

func _on_animated_sprite_2d_animation_finished():
	if(killer == 1):
		killer = 2
		$AnimatedSprite2D.play_backwards("dead")
