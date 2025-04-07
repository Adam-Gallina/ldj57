extends Interactive
class_name Grabbable

signal grabbed()

@export var ItemID : Constants.PuzzleItem
@export var InventoryImage : Texture2D
@export var ItemName = "Unnamed Item"
@export var ItemDescription = "Probably Something"

func interact():
    if Locked:
        return false
    $CollisionShape3D.disabled = true
    grabbed.emit()
    return true