extends Node

var stones : Array[Node3D] = []

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

	if item.ItemName == 'Stone':
		stones.append(item)
		item.get_parent().remove_child(item)
	else:
		items[item.ItemName] = item
		item.get_parent().remove_child(item)

		var i = InventoryImageScene.instantiate()
		i.texture = item.InventoryImage
		_inventory.add_child(i)
		imgs[item.ItemName] = i

func contains_item(item_name):
	return items.find_key(item_name)

func remove_item(item_name):
	if contains_item(item_name):
		var item = items[item_name]
		items.erase(item_name)

		imgs[item_name].queue_free()
		imgs.erase(item_name)
		return item
	return null

func remove_stone():
	var s = stones.pop_front()
	get_parent().get_parent().add_child(s)
	return s


func hide_ui():
	_inventory_ui.hide()

func toggle_ui():
	_inventory_ui.visible = !_inventory_ui.visible
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if _inventory_ui.visible else Input.MOUSE_MODE_CAPTURED
	return _inventory_ui.visible

