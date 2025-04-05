extends Interactive
class_name Toggle

signal triggered(state)
signal activatated()
signal deactivated()

@export var Active = false
@export var Locked = false
@export var LockOnActivate = false


func interact():
    if Locked:
        return false

    toggle()

    return true


func toggle():
    Active = not Active
    if Active:
        activate()
    else:
        deactivate()

func activate():
    update_visuals()
    activatated.emit()
    triggered.emit(true)

    if LockOnActivate: Locked = true

func deactivate():
    update_visuals()
    deactivated.emit()
    triggered.emit(false)


func update_visuals():
    pass
