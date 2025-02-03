extends StaticBody2D

var bm_num = 0
var killer = 0

@export var minBM = 0
@export var maxBM = 10

func kill():
	$AnimatedSprite2D.play("kill")
	killer = 1
	


func _on_animated_sprite_2d_animation_finished():
	if(killer == 1):
		bm_num = randi_range(minBM,maxBM)
		for j in range(bm_num):
			var bm = preload("res://levels/objects/BadMan.tscn").instantiate()
			bm.init(position+Vector2(randf_range(-100,100),randf_range(-100,100)))
			get_parent().add_child(bm)
		queue_free()
