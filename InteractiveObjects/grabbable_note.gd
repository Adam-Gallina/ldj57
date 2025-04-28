extends Interactive

signal opened()

@export var NoteID : Constants.NoteItem
@export var NoteName = "Unnamed Note"
@export var NoteDescription = "Yet another boring bit of lore"

@export var NoteNode : Control

func interact():
	if Locked:
		return false

	Inventory.add_note(self)
	Inventory.show_notes()
	Inventory._on_inventory_note_selected(NoteID)

	opened.emit()
	# TODO Play grab noise connected to opened
	return true