extends Toggle
class_name Placeable

@export var RequiredItemID : Constants.PuzzleItem
var _item
@export var CanRetrieveItem = true

func interact():
    if Locked:
        if CanRetrieveItem:
            Locked = false
            Inventory.add_item(_item)
            _item = null
            deactivate()
            return true

        return false

    Inventory.show_ui()

    var id = await Inventory.inventory_item_selected

    if id == RequiredItemID:
        activate()
        _item = Inventory.remove_item(id)

    Inventory.hide_ui()
    
    return true
