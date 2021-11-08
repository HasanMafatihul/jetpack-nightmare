extends Node

export var path:String
export var altkey:String

func _pressed():
	global.goto_scene(path)

func _input(event):
	if altkey:
		if event.is_action_pressed(altkey):
			global.goto_scene(path)
