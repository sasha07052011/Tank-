class_name Finish

extends ActivatedObject

func _on_touch_screen_button_pressed():
	if(active):
		if(!GlobalValues.pause):
			if(GlobalValues.score >= GlobalValues.max_score):
				GlobalValues.finish = true
				GlobalValues.load_effect.exit()
