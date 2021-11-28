extends Control

# Items
export var item = {
	"Default": ["res://visual/Coins and Beams/Pink.PNG", "Default red laser.\nDamage: 10\nROF: 2/s", 25, false],
	"Green Laser": ["res://visual/Coins and Beams/Green.PNG", "Green laser. Fast but less damage.\nDamage: 5\nROF: 5/s", 50, false],
	"Power": ["res://visual/Coins and Beams/Blue.PNG", "Very powerful.\nDamage: 50\nROF: 1/s", 250, false],
}

# Weapons' stats
var weapon = {
	"Default": {"name": "Default","damage": 10,"cd": 0.5,"text": "res://visual/Coins and Beams/Pink.PNG"},
	"Green Laser": {"name": "Green Laser","damage": 5,"cd": 0.2,"text": "res://visual/Coins and Beams/Green.PNG"},
	"Power" : {"name": "Power", "damage": 50, "cd": 1, "text": "res://visual/Coins and Beams/Blue.PNG"}
}

var item_name = []
var selected

# Adding items
func _ready():
	for i in global.save_data["bought_weapons"]:
		item[i][3] = true
	for i in item:
		$Items.add_item(i)
		item_name.append(i)

# Updating coins display
func _process(_delta):
	$coins.text = "Coins : " + str(global.save_data["coins"])

# When an item is selected
func _on_Items_item_selected(index):
	selected = item_name[index]
	if item[selected][0] != null:
		$Panel/img.texture = load(item[selected][0])
	else:
		$Panel/img.texture = null
	$Panel/name.text = selected
	$Panel/desc.text = item[selected][1]
	if item[selected][3]:
		$Panel/price.text = "Bought"
		$Panel/button_1.visible = false
		$Panel/button_2.visible = true
	else:
		$Panel/price.text = str(item[selected][2])
		$Panel/button_1.visible = true
		$Panel/button_2.visible = false
	

# Buying items
func _on_button_1_pressed():
	if global.save_data["coins"] >= item[selected][2]:
		global.save_data["coins"] -= item[selected][2]
		global.save_data["bought_weapons"].append(selected)
		$Panel/price.text = "Bought"
		$Panel/button_1.visible = false
		$Panel/button_2.visible = true

# Equipping items
func _on_button_2_pressed():
	global.weapon = weapon[selected]
