extends Interactive
class_name Grabbable

signal grabbed()
signal anim_complete()

@export var ItemID : Constants.PuzzleItem
@export var InventoryImage : Texture2D
@export var ItemName = "Unnamed Item"
@export var ItemDescription = "Probably Something"

func interact():
	if Locked:
		return false

	$CollisionShape3D.disabled = true
	Inventory.add_item(self)

	grabbed.emit()
	# TODO Play grab noise connected to grabbed
	return true

func play_grab_anim():
	var si = scale.x
	var d = .1

	while d > 0:
		d -= get_process_delta_time()
		d = max(0, d)
		var t = 1 - (d / .1)
		var s = si + .15 * t
		scale = Vector3(s, s, s)

		await get_tree().process_frame

	var se = scale.x
	d = .15
	while d > 0:
		d -= get_process_delta_time()
		d = max(0, d)
		var t = 1 - (d / .15)
		var s = se - 1 * t
		scale = Vector3(s, s, s)

		await get_tree().process_frame

	anim_complete.emit()