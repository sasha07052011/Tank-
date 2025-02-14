class_name Per
extends Node2D

@export var time = 0.0
@export var full_cof = 0.2
@export var iter_frames_cof = 0.01
@export var add_speed = 0.01
@export var size = 60
signal st
signal ex
var type = false
var timer

func _timeout():
	if(!type):
		time+=add_speed
	else:
		time-=add_speed

func _init() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = iter_frames_cof
	timer.connect("timeout", _timeout)
	
func _ready() -> void:
	GlobalValues.load_effect = self

func start():
	time=0
	type=false
	
func exit():
	time=1
	type=true



func _process(delta: float) -> void:
	#if(!type):
		#time+=iter_frames_cof
	#else:
		#time-=iter_frames_cof
	time = clamp(time,0,1)
	if(time==1 and !type):
		st.emit()
	elif(time<=0 and type):
		ex.emit()
	queue_redraw()

func _draw() -> void:
	var size_x = get_viewport_rect().size.x
	var size_y = get_viewport_rect().size.y
	for i in range(size_x/size):
		for j in range(size_y/size):
			var sin_par = ((i*size/size_x)*2.0)+(1-time*3.0)
			if(sin_par>1):
				sin_par = 1
			if(sin_par<0):
				sin_par = 0
			var size_cof = sin(sin_par)
			if(size_cof>1-full_cof):
				size_cof = 1
			var add_pos = Vector2(size/2-size/2*size_cof,size/2-size/2*size_cof)
			var pos = Vector2.ZERO
			if(!type):
				pos = Vector2(i*size,j*size)
			else:
				pos = Vector2(size_x-(i+1)*size,size_y-(j+1)*size)
			draw_rect(Rect2(pos+add_pos,Vector2(size,size)*(size_cof)),Color(0,0,0,size_cof))
