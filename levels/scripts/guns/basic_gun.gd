class_name Gun
extends Node2D

@export var bull: PackedScene
@export var shot_speed = 0.5
@export var base_scene: Node
@export var bum: AudioStreamPlayer2D
@export var bum_move = 3.3
@export var gtype = "Base"
@export var active = false
var on = false

func _ready() -> void:
	$Timer.start(0.5)

func _process(delta: float) -> void:
	$fire.hide()
	if(on):
		if(active):
			for i in $bull_points.get_children():
				var b = bull.instantiate()
				b.rotation = global_rotation+i.rotation
				b.position = i.global_position
				if(get_parent().get_parent() is Player):
					if(b is PlayerBull or b is PlayerBull2):
						b.add_player_speed = -GlobalValues.player.end_speed.length()
				if(base_scene!=null):
					base_scene.add_child(b)
				$fire.show()
				if(bum!=null):
					bum.play(bum_move)
			$Timer.start(shot_speed)
			on = false
	else:
		pass


func _on_timer_timeout() -> void:
	on=true
