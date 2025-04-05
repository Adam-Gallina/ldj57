extends Interactive
class_name Grabbable

@export var ItemID : Constants.PuzzleItem
@export var InventoryImage : Texture2D

func interact():
    $CollisionShape3D.disabled = true
    return true