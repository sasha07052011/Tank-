extends Node2D

var sh = false


func _on_area_2d_body_entered(body):
	if(!(body is TileMap)):
		if(body is CharacterBody2D):
			if(body.my_name == "player"):
				sh = true
	

func _on_area_2d_body_exited(body):
	sh = false

func _process(delta):
	if(!GlobalValues.pause):
		if(sh):
			#$Label.show()
			pass
		else:
			#$Label.hide()
			pass
	


func _on_touch_screen_button_pressed():
	if(!GlobalValues.pause):
		if(GlobalValues.score >= GlobalValues.max_score):
		#if(sh):
				GlobalValues.finish = true
