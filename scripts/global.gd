extends Node

# Current scene
var current_scene = null

# Persistent data
var save_data = {
	"coins": 0,
	"high_score": 0,
	"bought_weapons": ["Default"]
}

# Player status
var status = {
	"hp": 100,
	"score": 0,
	"damage": 10,
	"cd": 5
}

# Player's weapon. Modifiable in hub
var weapon = {
	"name": "Default",
	"damage": 10,
	"cd": 0.5,
	"text": "res://visual/Coins and Beams/Pink.PNG"
}

# Init
func _ready():
	load_save()
	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# Function to change scene. Use arg "quit" to quit game instead
func goto_scene(path):
	if path == "quit":
		get_tree().quit()
		return
	
	# Saving game every scene change
	save_game()
	
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

# Saving game
func save_game():
	var save_game = File.new()
	save_game.open("user://overhealed.save", File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()

# Loading save directly to persistent data
func load_save():
	var save_game = File.new()
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	if not save_game.file_exists("user://overhealed.save"):
		return # Error! We don't have a save to load.
		
	save_game.open("user://overhealed.save", File.READ)
	save_data = parse_json(save_game.get_line())
	save_game.close()
