extends Area2D

@export var scale_r = 1.0
@export var rad_per = 20
@export var ison = true
var pl_in = false
var time = 0
var pl = null

func _process(delta):
	if(ison):
		if(!GlobalValues.pause):
			if(pl_in):
				time += 1
				if(time >= rad_per):
					time = 0
					if(GlobalValues.radiation < 100-scale_r):
						GlobalValues.radiation += scale_r
						pl.kill("rad")

func _on_body_entered(body):
	if(body is CharacterBody2D):
		if(!GlobalValues.pause):
			if(body.my_name == "player"):
				pl_in = true
				pl = body


func _on_body_exited(body):
	if(body is CharacterBody2D):
		if(!GlobalValues.pause):
			if(body.my_name == "player"):
				pl_in = false
