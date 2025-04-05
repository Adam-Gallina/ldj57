extends Toggle
class_name Placeable

@export var RequiredItemID : Constants.PuzzleItem

func interact():
    if Locked:
        return false

    Inventory.show_ui()

    var id = await Inventory.inventory_item_selected

    if id == RequiredItemID:
        activate()
        Inventory.remove_item(id)

    Inventory.hide_ui()
    
    return true
