extends Node2D

var command
var code
var ok = false
var sh = false
var com_ok = false
var func_mas = {"/exit 0":"exit","/clear 0":"cls","/tp 2":"tp","/fps 0":"fps","/hp 1":"hp"}
# Called when the node enters the scene tree for the first time.

func fps():
	con_print(str(Engine.get_frames_per_second()),"Система")

func exit():
	get_tree().quit()
	
func cls():
	$TextEdit.clear()

func hp(arg1):
	print(arg1)
	GlobalValues.hp = int(arg1)
	if(GlobalValues.player != null):
		GlobalValues.player.kill("com")
	
func tp(arg1,arg2):
	var n1 = int(arg1)
	var n2 = int(arg2)
	if(GlobalValues.player != null):
		GlobalValues.player.position = Vector2(n1,n2)
	con_print("Player телепортирован в "+arg1+", "+arg2,"Система")

func _ready():
	show()
	$LineEdit.focus_mode = LineEdit.FOCUS_CLICK


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	com_ok = false
	if(Input.is_action_just_pressed("console")):
		sh = !sh
	if(ok):
		code = command.split(" ")
		for i in func_mas.keys():
			var k = i.split(" ")
			if(code[0] == k[0]):
				com_ok = true
				if(code.size()==1+int(k[1])):
					code.remove_at(0)
					if(int(k[1])==0):
						call(func_mas[i])
						break
					else:
						callv(func_mas[i],code)
						break
				elif(code.size()<=1+int(k[1])):
					con_print("ОШИБКА!!!! Нехватает аргументов!!!","Система")
					break
				else:
					con_print("ОШИБКА!!!! Слишком много аргументов!!!","Система")
					break
		
		if(!com_ok):
			con_print(command,"Player")
		ok = false
		$LineEdit.text = ""
		$LineEdit.release_focus()
	if(sh):
		show()
	else:
		hide()


func _on_line_edit_text_submitted(new_text):
	command = new_text
	ok = true
	
func con_print(text: String, op: String):
	$TextEdit.text += op + ": "+text+"\n"
	
func reg_func(name: String, fun: String):
	func_mas = func_mas + {name: fun}
