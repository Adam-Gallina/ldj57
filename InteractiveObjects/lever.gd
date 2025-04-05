extends Interactive

signal triggered(state)
signal activatated()
signal deactivated()

@export var ActiveAngle = -45
@export var InactiveAngle = 45
@export var Active = false
@export var Locked = false

@onready var _pivot = $Pivot


func interact():
    if Locked:
        return false
        
    Active = not Active
    triggered.emit(Active)
    if Active: activatated.emit()
    else: deactivated.emit()

    _pivot.rotation.x = deg_to_rad(ActiveAngle if Active else InactiveAngle)

    return true