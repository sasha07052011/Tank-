class_name BadMan

extends CharacterBody2D

var pl_pos = Vector2.ZERO
var my_name = "bad_man"
var time = 0
var dead = false
var player
@export var hit_time = 120

func init(pos):
	position = pos

func hit():
	var b = preload("res://levels/bullBM.tscn").instantiate()
	b.init(rotation-deg_to_rad(-90+randi_range(-10,10)))
	b.position = $pos.global_position
	get_parent().add_child(b)

func _ready():
	$AnimatedSprite2D.play("default")
	player = GlobalValues.player
	

func _process(delta):
	if(!GlobalValues.pause):
		if(!dead):
			time += 1
			rotation = (pl_pos.angle_to_point(position))-deg_to_rad(180)
			if(player != null):
				pl_pos = player.get_pos()
			move_and_collide(Vector2(8,0).rotated(rotation))
			if(time >= hit_time):
				hit()
				time = 0
	

func kill():
	$CollisionShape2D.queue_free()
	if(randi_range(0,1)==0):
		$AnimatedSprite2D.play("kill")
	else:
		$AnimatedSprite2D.play("kill2")
	rotation = 0
	dead = true
	$boom.play()



func _on_zvukvzryvadlyavideo_finished() -> void:
	if(dead):
		queue_free()
