extends Node

signal inventory_item_selected(item_id)

var items : Dictionary = {}
var imgs : Dictionary = {}
@export var InventoryImageScene : PackedScene
@onready var _inventory = $PlayerUILayer/Inventory/HBoxContainer
@onready var _inventory_ui = $PlayerUILayer/Inventory

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide_ui()

func _process(_delta):
	if Input.is_action_just_pressed('menu_pause'):
		if Input.is_key_pressed(KEY_SHIFT):
			get_tree().quit.call_deferred()

		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE


func add_item(item):
	if not item is Grabbable: return

	items[item.ItemID] = item
	item.get_parent().remove_child(item)

	var i = InventoryImageScene.instantiate()
	i.set_item(item)
	i.pressed.connect(func(): _on_inventory_item_selected(item.ItemID))
	_inventory.add_child(i)
	imgs[item.ItemID] = i

func contains_item(item_id):
	return items.get(item_id)

func remove_item(item_id):
	if contains_item(item_id):
		var item = items[item_id]
		items.erase(item_id)

		imgs[item_id].queue_free()
		imgs.erase(item_id)
		return item

	return null


func show_ui():
	_inventory_ui.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hide_ui():
	_inventory_ui.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	inventory_item_selected.emit(Constants.PuzzleItem.Null)

func toggle_ui():
	if _inventory_ui.visible: hide_ui()
	else: show_ui()
	
	return _inventory_ui.visible


func _on_inventory_item_selected(item_id):
	inventory_item_selected.emit(item_id)
