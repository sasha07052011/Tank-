class_name DroppedGenerator

extends StaticBody2D

@export var texture: Texture2D = null
@export var drop: Array[PackedScene]
@export var regular = false
@export var brackable = true
@export var period_in_frames = 60
@export var col = Vector2(1,1)
@export var type_chip = 0
@export var ranomise_pos = false
@export_range(1,4) var kill_anim_var = 1
var t = 0

func dropping(id):
	var d = drop[id].instantiate(PackedScene.GEN_EDIT_STATE_DISABLED)
	if(ranomise_pos):
		d.global_position = Vector2(global_position.x+randi_range(-100,100),global_position.y+randi_range(-100,100))
	else:
		d.global_position = global_position
	if(d is Chip):
		if(type_chip != -1):
			d.type = type_chip
	get_parent().add_child(d)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(texture!=null):
		$Sprite2D.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!GlobalValues.pause):
		t+=1
		if(regular):
			if(t>=period_in_frames):
				for j in range(0,drop.size()):
					for i in range(randi_range(col.x,col.y)):
						dropping(j)
				t = 0
	
func kill():
	if(brackable):
		$AnimatedSprite2D.play("kill"+str(kill_anim_var))
		$CollisionShape2D.queue_free()
		$Sprite2D.queue_free()


func _on_animated_sprite_2d_animation_looped() -> void:
	if($AnimatedSprite2D.animation != "default"):
		if(drop!=null):
			if(!(get_parent() is Window)):
				for j in range(0,drop.size()):
					for i in range(randi_range(col.x,col.y)):
						dropping(j)
		queue_free()
