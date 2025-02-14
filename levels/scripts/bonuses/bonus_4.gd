extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Player):
		for i in body.get_node("guns").get_children():
			if(i.gtype=="MUHA"):
				return
		var s = preload("res://levels/objects/guns/MUHA.tscn").instantiate()
		s.name = "gun"+str(body.getted_guns+1)
		s.hide()
		s.base_scene = body.get_parent()
		body.getted_guns+=1
		body.get_node("Camera2D/CanvasLayer/BonusOn3").show()
		body.get_node("guns").add_child(s)
	queue_free()
