extends ActivatedObject

@export var locked = true
@export var speed = 15
@export_enum("Basic Chip","Control Chip","AI Chip","Processor") var key_type = 0
var colors = [Color(0,0,0.7),Color(0,1,0),Color(1,0,0),Color(0,0,0)]
var on = false
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CollisionShape2D2.disabled = false
	if(active):
		if(!locked):
			if(!on):
				if(time<30):
					time += speed*delta
				else:
					time = 30
			else:
				if(time>24):
					time -= speed*delta
				else:
					time = 24
					$CollisionShape2D2.disabled = true
			var sh = ConvexPolygonShape2D.new()
			sh.points = [Vector2(-2,-15 - time),Vector2(2,-15 - time),Vector2(2,15),Vector2(-2,15)]
			$CollisionShape2D2.shape = sh
			$AnimatedSprite2D.play("opened")
			$wall.position.y = 23-time
		#$CollisionShape2D2.position.y = 8-time
		else:
			time = 30
			$AnimatedSprite2D.play("locked")
	else:
		time = 30
		$AnimatedSprite2D.play("deactive")
	$wall.region_rect = Rect2(Vector2(30+(4*key_type),0),Vector2(4,time))


func kill():
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(active):
		if(body is Player):
			on = true
			if(GlobalValues.chips_got[key_type]>0):
				if(locked):
					GlobalValues.chips_got[key_type] -= 1
					locked = false
					$ok.play()
			



func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is Player):
		on = false
