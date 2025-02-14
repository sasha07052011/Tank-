extends Node2D

var ll: Per
var per = false

func _ready() -> void:
	ll = $LoadLevel
	GlobalValues.exit_per = false
	move_child(ll,-1)
	var d = DirAccess.open("res://levels/worlds/laboratory/").get_files()
	var id = 1
	var y = 0
	var x = 0
	var inter = 30
	for i in d:
		var b: LevelButton = preload("res://levels/levelbutton.tscn").instantiate()
		var k = i
		if(k.split(".")[-1]=="remap"):
			var t = ""
			var j = 0
			for s in k:
				if(len(k)-j>6):
					t+=s
					#print(t)
					j+=1
			k = t
		b.level = load("res://levels/worlds/laboratory/"+k)
		b.num = id
		b.locked = false
		b.position = Vector2(x*120,y*120)
		$buttons.add_child(b)
		id+=1
		if(x<4):
			x+=1
		else:
			x=0
			y+=1

func _on_menub_pressed() -> void:
	ll.exit()
	GlobalValues.exit_per = true


func _on_load_level_ex() -> void:
	if(GlobalValues.exit_per):
		get_tree().change_scene_to_file("res://levels/worlds/menu.tscn")
	elif(GlobalValues.start_per):
		if(GlobalValues.curent_level!=null):
			get_tree().change_scene_to_packed(GlobalValues.curent_level)
		
func _process(delta: float) -> void:
	if(GlobalValues.start_per):
		if(!per):
			ll.exit()
			per=true
	print(GlobalValues.start_per)
