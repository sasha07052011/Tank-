class_name PlayerBull

extends CharacterBody2D

var rot = 0
var live_time = 0
var kill = false
@export var speed = -2000
var add_player_speed = 0
var my_name = "bull_p"

func init(r):
	rot = r
	rotate(r)
	add_player_speed = -GlobalValues.player.end_speed.length()
	

func _process(delta):
	if(!GlobalValues.pause):
		position += Vector2(0,speed*delta+add_player_speed).rotated(rot)
		live_time += 1
		if(live_time>600):
			queue_free()
	

func Kill():
	speed = 0
	$AnimatedSprite2D.play("kill")
	kill=true

func _on_area_2d_body_entered(body):
	if(body is TileMap or body is StaticBody2D or body is TileMapLayer):
		Kill()
	if(body is Player or body is BadMan or body is DroppedGenerator):
		body.kill()
		Kill()


func _on_animated_sprite_2d_animation_finished():
	if(kill):
		queue_free()
