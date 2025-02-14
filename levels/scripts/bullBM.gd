extends CharacterBody2D

var rot = 0
var live_time = 0
var kill = false
var speed = -50
var my_name = "bull_bm"

func init(r):
	rot = r
	rotate(r)

func _process(delta):
	if(!GlobalValues.pause):
		position += Vector2(0,speed).rotated(rot)
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
	if(body is DroppedGenerator):
		if(body.mname!="R"):
			body.kill()
		Kill()
	if(body is Player):
		body.kill(my_name)
		Kill()


func _on_animated_sprite_2d_animation_finished():
	if(kill):
		queue_free()
