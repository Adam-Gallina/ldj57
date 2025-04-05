extends Interactive
class_name Grabbable

@export var ItemID : Constants.PuzzleItem
@export var InventoryImage : Texture2D
@export var ItemName = "Unnamed Item"
@export var ItemDescription = "Probably Something"

func interact():
    $CollisionShape3D.disabled = true
    return true