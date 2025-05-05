extends Toggle
class_name Placeable

@export var CorrectItemID : Constants.PuzzleItem
@export var ValidItemID : Array[Constants.PuzzleItem]
@export var CurrItem : Grabbable
@export var CanRetrieveItem = true

@export var InteractionName = "Unnamed object"
@export var InteractionMessage = "You're touching something alright"

func _ready() -> void:
	if CurrItem != null:
		if CorrectItemID == CurrItem.ItemID:
			activate.call_deferred()

func interact():
	if Locked:
		return false

	if CurrItem == null:
		Inventory.show_inventory_interaction(InteractionName, InteractionMessage)

		var id = await Inventory.inventory_item_selected

		if id in ValidItemID:
			_on_item_applied(Inventory.remove_item(id))
			if id == CorrectItemID:
				activate()

		Inventory.hide_ui()
		
		return true
	elif CanRetrieveItem:
		Inventory.add_item(CurrItem)

		if CurrItem.ItemID == CorrectItemID:
			deactivate()
			
		CurrItem = null
		return true

func _on_item_applied(item):
	CurrItem = item
