extends Toggle
class_name Placeable

@export var CorrectItemID : Constants.PuzzleItem
@export var ValidItemID : Array[Constants.PuzzleItem]
var _item
@export var CanRetrieveItem = true

func interact():
	if Locked:
		return false

	if _item == null:
		Inventory.show_ui()

		var id = await Inventory.inventory_item_selected

		if id in ValidItemID:
			_on_item_applied(Inventory.remove_item(id))
			if id == CorrectItemID:
				activate()

		Inventory.hide_ui()
		
		return true
	elif CanRetrieveItem:
		Inventory.add_item(_item)

		if _item.ItemID == CorrectItemID:
			deactivate()
			
		_item = null
		return true

func _on_item_applied(item):
	_item = item
