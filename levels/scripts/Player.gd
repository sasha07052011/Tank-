class_name Player

extends CharacterBody2D

@export var light_energy = 1
@export var speed = 700
@export var popus = false
@export var rad_st = 80
@export var menu = false
@export var speed_bonus = 1
var mobile = false
var last_r = 0
var last_m = Vector2.ZERO
var fire = false
var light = true
var con = false
var my_name = "player"
var end_speed = Vector2.ZERO
var time = 0
var forse = 1
var old_pos = Vector2.ZERO
var block_move = false

func kill(bad):
	if(bad == "bull_bm"):
		if(GlobalValues.hp > -1):
			GlobalValues.hp -= 1
			$CPUParticles2D.emitting = true
	if(GlobalValues.hp < 0):
		if(!block_move):
			$TankCorpus.hide()
			$AnimatedSprite2D.play("kill")
			block_move = true
			$boom.play()
		return
	if(bad == "rad"):
		if(GlobalValues.radiation > rad_st):
			if(GlobalValues.hp > -1):
				GlobalValues.hp -= 1
				$CPUParticles2D.emitting = true
	$Camera2D/CanvasLayer/health/HP.text = str(GlobalValues.hp)
	$Camera2D/CanvasLayer/health/RAD.text = str(GlobalValues.radiation)+"%"

func get_pos() -> Vector2:
	return position

func hit():
	var b = preload("res://levels/bull.tscn").instantiate()
	b.init(rotation)
	b.position = $pos.global_position
	get_parent().add_child(b)

func _ready():
	GlobalValues.player = $"."
	$AnimatedSprite2D.play_backwards("default")
	$PointLight2D.energy = light_energy
	$Camera2D/CanvasLayer/pause.hide()
	$Camera2D/CanvasLayer/DebugConsole.con_print(OS.get_name(),"Система")
	if(OS.get_name() == "Android"):
		mobile = true
		forse = 0
	GlobalValues.hp = GlobalValues.starthp
	GlobalValues.radiation = 0
	$Camera2D/CanvasLayer/finish.hide()
	GlobalValues.in_menu = menu
	GlobalValues.chips_got = [0,0,0,0]

func _process(delta):
	old_pos = global_position
	RenderingServer.global_shader_parameter_set("color", GlobalValues.color)
	if(!GlobalValues.pause):
		time += 1
		if(time > 30):
			time = 0
			kill("rad")
			if($CPUParticles2D.emitting):
				if(GlobalValues.radiation < rad_st):
					$CPUParticles2D.emitting = false
			if(GlobalValues.radiation>=1):
				GlobalValues.radiation -= 1
		end_speed = Vector2.ZERO
		$Camera2D/CanvasLayer/pause.hide()
		if(!mobile):
			forse = 1 * speed_bonus * delta
			look_at(get_global_mouse_position())
			rotation_degrees+=90
			if(Input.is_action_pressed("up")):
				end_speed = Vector2(0,-speed*forse).rotated(rotation)
			if(Input.is_key_pressed(KEY_C)):
				pass
			if(Input.is_action_just_pressed("light")):
				light=!light
			if(popus):
				if(Input.is_action_pressed("hit")):
					hit()
			else:
				if(Input.is_action_just_pressed("hit")):
					hit()
	else:
		$Camera2D/CanvasLayer/pause.show()
	$Camera2D/CanvasLayer/Label.text = "Счёт: "+str(GlobalValues.score)+"/"+str(GlobalValues.max_score)
	$Camera2D/CanvasLayer/world.text = "Уровень: "+str(GlobalValues.world)
	if(mobile):
		end_speed = last_m*speed*forse*speed_bonus*delta
	if(popus):
		if(fire):
			hit()
	if(!mobile):
		$Camera2D/CanvasLayer/mobile.hide()
	if(light): $PointLight2D.show()
	else: $PointLight2D.hide()
	if(!block_move): 
		if(!GlobalValues.pause): move_and_collide(end_speed)
	else:
		rotation = 0
	if(popus):
		$Camera2D/CanvasLayer/BonusOn.show()
	else:
		$Camera2D/CanvasLayer/BonusOn.hide()
		
	if(speed_bonus>=1.1):
		$Camera2D/CanvasLayer/BonusOn2.show()
	else:
		$Camera2D/CanvasLayer/BonusOn2.hide()
	if(GlobalValues.in_menu):
		GlobalValues.hp = 9999999
		
	if(GlobalValues.score>=GlobalValues.max_score):
		if(!GlobalValues.in_menu):
			$Camera2D/CanvasLayer/finish.show()
	
	
func _on_pauseb_button_down():
	GlobalValues.pause = !GlobalValues.pause


func _on_fire_pressed():
	if(!GlobalValues.pause):
		if(mobile):
			if(popus):
				fire = true
			else:
				hit()


func _on_virtual_joystick_analogic_chage(move, dist):
	if(!GlobalValues.pause):
		last_m = move
		if(move.x != 0 && move.y != 0):
			last_r = move.angle()
			rotation = move.angle()
			rotation_degrees+=90
			forse = dist
			#print(forse)



func _on_virtual_joystick_analogic_released():
	rotation = last_r
	rotation_degrees+=90


func _on_fire_released():
	if(!GlobalValues.pause):
		if(mobile):
			fire = false



func _on_touch_screen_button_pressed():
	$Camera2D/CanvasLayer/DebugConsole.sh = !$Camera2D/CanvasLayer/DebugConsole.sh
	


func _on_menub_pressed():
	GlobalValues.exit_per = true
	#get_tree().change_scene_to_file("res://levels/worlds/menu.tscn")


func _on_animated_sprite_2d_animation_finished() -> void:
	GlobalValues.reload = true
