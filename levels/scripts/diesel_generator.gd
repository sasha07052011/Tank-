class_name DieselGenerator
extends StaticBody2D

@export var obj: Array[ActivatedObject]
@export var basic_chips_col = 1
@export var control_chips_col = 1
@export var AI_chips_col = 1
@export var processor_col = 1
var rep = false

func  _ready() -> void:
	$tip.hide()
	
func _process(delta: float) -> void:
	if(!rep):
		$"tip/1".text = str(basic_chips_col)
		$"tip/2".text = str(control_chips_col)
		$"tip/3".text = str(AI_chips_col)
		$"tip/4".text = str(processor_col)

func _on_touch_screen_button_pressed() -> void:
	if(!rep):
		if(GlobalValues.chips_got[0]>=basic_chips_col):
			if(GlobalValues.chips_got[1]>=control_chips_col):
				if(GlobalValues.chips_got[2]>=AI_chips_col):
					if(GlobalValues.chips_got[3]>=processor_col):
						GlobalValues.chips_got[0]-=basic_chips_col
						GlobalValues.chips_got[1]-=control_chips_col
						GlobalValues.chips_got[2]-=AI_chips_col
						GlobalValues.chips_got[3]-=processor_col
						for i in obj:
							i.activate()
						rep = true
						$Sprite2D.play("repair")
						$ok.play()
						$tip.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(!rep):
		if(body is Player):
			$tip.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is Player):
		$tip.hide()
