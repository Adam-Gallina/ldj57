extends Toggle
class_name UIToggle

signal combo_input(combo)

@export var Combination = "5555"
@export var ComboUI : CanvasLayer

@export var Scrollwheels : Array[ScrollwheelLabel]

func _ready() -> void:
    ComboUI.hide()

func interact():
    if Locked: return false

    ComboUI.show()
    Constants.GetPlayer().set_input(false, false)
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    await combo_input

    return true


func _on_submit():
    var val = ""
    for s in Scrollwheels:
        val += s.value()

    if val == Combination:
        activate()
        ComboUI.hide()
        Constants.GetPlayer().set_input(true, true)
        Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
        combo_input.emit(val)

func hide_ui():
    ComboUI.hide()
    Constants.GetPlayer().set_input(true, true)
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

    combo_input.emit("")