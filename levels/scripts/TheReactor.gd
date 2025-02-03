extends Node2D

@export var hp = 20
@export var isbreak = false
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(isbreak):
		hp = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(isbreak):
		$AnimatedSprite2D.play("break")
		$rad_adder.ison = true
		$rad_adder2.ison = true
		$rad_adder3.ison = true
	else:
		$rad_adder.ison = false
		$rad_adder2.ison = false
		$rad_adder3.ison = false
	
	if(hp < 1):
		if(time < 100):
			$CPUParticles2D.emitting = true
		else:
			$CPUParticles2D.emitting = false
			isbreak = true
		time += 1
		


func _on_static_body_2d_kill_s():
	hp -= 1
	if(hp < 0):
		if(!$AudioStreamPlayer2D.playing):
			if(time < 100):
				$AudioStreamPlayer2D.play(0.2)
