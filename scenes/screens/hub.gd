extends Control

export var item = {
	"Pen": [null, "Just a pen", 100],
	"You": [null, "You(?)", 150],
	"Cheap": ["res://icon.png", "Cheap item", 50]
}

var item_name = []
var selected

# Adding items
func _ready():
	for i in item:
		$Items.add_item(i)
		item_name.append(i)

# Updating coins display
func _process(_delta):
	$coins.text = "Coins : " + str(global.save_data["coins"])

# When an item is selected
func _on_Items_item_selected(index):
	selected = item_name[index]
	if item[selected][0]:
		$Panel/img.texture = load(item[selected][0])
	else:
		$Panel/img.texture = null
	$Panel/name.text = selected
	$Panel/desc.text = item[selected][1]
	$Panel/price.text = str(item[selected][2])
	
