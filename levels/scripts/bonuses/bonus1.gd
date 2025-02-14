extends Node2D

@export var l = true

func _ready():
	if(!l): $PointLight2D.hide()

func _on_area_2d_body_entered(body):
	if(body is Player):
		for i in body.get_node("guns").get_children():
			if(i.gtype=="AK"):
				return
		var s = preload("res://levels/objects/guns/AK.tscn").instantiate()
		s.name = "gun"+str(body.getted_guns+1)
		s.hide()
		s.base_scene = body.get_parent()
		body.getted_guns+=1
		body.get_node("Camera2D/CanvasLayer/BonusOn").show()
		body.get_node("guns").add_child(s)
	queue_free()
