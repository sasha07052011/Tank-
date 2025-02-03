extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var chips = GlobalValues.chips_got
	if(chips[3]>0):
		$Processor.modulate = Color(1,1,1,1)
		$amount1.show()
		$amount1.text = str(chips[3])
	else:
		$Processor.modulate = Color(1,1,1,0.5)
		$amount1.hide()
	
	if(chips[0]>0):
		$"Basic Chip".modulate = Color(1,1,1,1)
		$amount3.show()
		$amount3.text = str(chips[0])
	else:
		$"Basic Chip".modulate = Color(1,1,1,0.5)
		$amount3.hide()
		
	if(chips[2]>0):
		$"AI Chip".modulate = Color(1,1,1,1)
		$amount2.show()
		$amount2.text = str(chips[2])
	else:
		$"AI Chip".modulate = Color(1,1,1,0.5)
		$amount2.hide()
	
	if(chips[1]>0):
		$"Control Chip".modulate = Color(1,1,1,1)
		$amount4.show()
		$amount4.text = str(chips[1])
	else:
		$"Control Chip".modulate = Color(1,1,1,0.5)
		$amount4.hide()
