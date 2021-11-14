extends Node

# Current scene
var current_scene = null

# Global coins
var coins = 0

# Init
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# Function to change scene. Use arg "quit" to quit game instead
func goto_scene(path):
	if path == "quit":
		get_tree().quit()
		return
	
	call_deferred("_deferred_goto_scene", path)

# Deferred go to scene to ensure no bug happens
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
