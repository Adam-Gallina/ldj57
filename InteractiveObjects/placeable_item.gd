extends Placeable

@export var ItemPivot : Node3D

func _on_item_applied(item):
	super(item)

	ItemPivot.add_child(item)
	item.rotation = Vector3.ZERO
	item.position = Vector3.ZERO
