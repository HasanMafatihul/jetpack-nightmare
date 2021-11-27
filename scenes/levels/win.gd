extends Control

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false
	global.goto_scene("res://scenes/screens/win.tscn")
