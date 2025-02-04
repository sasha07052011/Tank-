class_name ActivatedObject
extends Node2D

@export var active = false

func activate():
	active = true
	
func deactivate():
	active = false
