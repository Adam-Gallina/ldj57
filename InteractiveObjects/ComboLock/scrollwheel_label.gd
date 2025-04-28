extends VBoxContainer
class_name ScrollwheelLabel

signal value_changed(val)

@onready var inc_btn : Button = $IncrementButton
@onready var dec_btn : Button = $DecrementButton

@onready var label : Label = $Label

@export var Options = ["0", "1", '2', '3', '4', '5', '6', '7', '8', '9']
var _curr_option = 0

func _ready() -> void:
    inc_btn.pressed.connect(_increment)
    dec_btn.pressed.connect(_decrement)

    _curr_option = randi() % 10
    _increment()

func _increment():
    _curr_option += 1
    if _curr_option >= Options.size():
        _curr_option = 0

    label.text = Options[_curr_option]
    value_changed.emit(Options[_curr_option])

func _decrement():
    _curr_option -= 1
    if _curr_option < 0:
        _curr_option = Options.size() - 1

    label.text = Options[_curr_option]
    value_changed.emit(Options[_curr_option])

func value():
    return Options[_curr_option]