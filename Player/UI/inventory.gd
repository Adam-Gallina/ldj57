extends Node

signal inventory_item_selected(item_id)

@onready var hand_reticle = $CursorLayer/Hand
@onready var glass_reticle = $CursorLayer/MagnifyingGlass

@onready var _inventory_canvas = $InventoryLayer

var items : Dictionary = {}
var imgs : Dictionary = {}
@export var InventoryImageScene : PackedScene
@onready var _inventory_ui = $InventoryLayer/Inventory
@onready var _inventory = $InventoryLayer/Inventory/TextureRect/HBoxContainer
@onready var _hovered_item_name = $InventoryLayer/Inventory/HoveredItemName
@onready var _hovered_item_desc = $InventoryLayer/Inventory/HoveredItemDescription

var notes : Dictionary = {}
@export var NoteButtonScene : PackedScene
@onready var _notes_ui = $InventoryLayer/Notes
@onready var _notes_parent = $InventoryLayer/Notes/TextureRect/VBoxContainer
@onready var _selected_note_name = $InventoryLayer/Notes/NoteName
@onready var _selected_note_desc = $InventoryLayer/Notes/NoteDescription

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide_ui()

	_hovered_item_name.text = ""
	_hovered_item_desc.text = ""

	_selected_note_name.text = ""
	_selected_note_desc.text = ""

func _process(_delta):
	if Input.is_action_just_pressed('menu_pause'):
		if Input.is_key_pressed(KEY_SHIFT):
			get_tree().quit.call_deferred()

		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE


func show_inventory():
	show_ui()
	_inventory_ui.show()
	_notes_ui.hide()

func show_notes():
	show_ui()
	_inventory_ui.hide()
	_notes_ui.show()

func show_ui():
	_inventory_canvas.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Constants.GetPlayer() != null:
		Constants.GetPlayer().set_input(false, false)

func hide_ui():
	_inventory_canvas.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Constants.GetPlayer() != null:
		Constants.GetPlayer().set_input(true, true)
	inventory_item_selected.emit(Constants.PuzzleItem.Null)

func toggle_ui():
	if _inventory_canvas.visible: hide_ui()
	else: show_ui()
	
	return _inventory_canvas.visible


func add_item(item):
	if not item is Grabbable: return

	items[item.ItemID] = item
	if item.get_parent() != null:
		item.get_parent().remove_child(item)

	var i = InventoryImageScene.instantiate()
	i.set_item(item)
	i.pressed.connect(func(): _on_inventory_item_selected(item.ItemID))
	i.mouse_entered.connect(func(): _on_inventory_item_hovered(item.ItemID))
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


func add_note(note):
	notes[note.NoteID] = note

	note.NoteNode.get_parent().remove_child(note.NoteNode)
	_notes_ui.add_child(note.NoteNode)
	note.NoteNode.hide()
	
	var i = NoteButtonScene.instantiate()
	i.text = note.NoteName
	i.pressed.connect(func(): _on_inventory_note_selected(note.NoteID))
	_notes_parent.add_child(i)

func contains_note(note_id):
	return notes.get(note_id)


func _on_inventory_item_selected(item_id):
	inventory_item_selected.emit(item_id)
	if item_id != Constants.PuzzleItem.Null:
		$InteractStreamPlayer.play()

func _on_inventory_item_hovered(item_id):
	if contains_item(item_id):
		_hovered_item_name.text = items[item_id].ItemName
		_hovered_item_desc.text = items[item_id].ItemDescription
	else:
		print('Tried to hover over invalid item')


func _on_inventory_note_selected(note_id):
	if contains_note(note_id):
		$InteractStreamPlayer.play()
		notes[note_id].NoteNode.show()
		_selected_note_name.text = notes[note_id].NoteName
		_selected_note_desc.text = notes[note_id].NoteDescription
	else:
		print('Tried to select invalid note')


func show_reticle(reticle:Constants.ReticleType):
	if reticle == Constants.ReticleType.Hand:
		hand_reticle.show()
		glass_reticle.hide()
	elif reticle == Constants.ReticleType.Glass:
		hand_reticle.hide()
		glass_reticle.show()

func hide_reticle():
	hand_reticle.hide()
	glass_reticle.hide()


func _on_inventory_button_pressed() -> void:
	show_inventory()

func _on_notes_button_pressed() -> void:
	show_notes()
