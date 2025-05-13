extends Interactive
class_name ToggleOutput

@export var Outputs : Array[Toggle] = []

var _curr_output = 0

func interact():
    if Locked: return

    Outputs[_curr_output].deactivate()
    _curr_output += 1
    if _curr_output >= Outputs.size():
        _curr_output = 0
    Outputs[_curr_output].activate()
