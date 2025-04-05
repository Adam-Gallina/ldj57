extends Interactive
class_name Toggle

signal triggered(state)
signal activated()
signal deactivated()

@export var Active = false
@export var LockOnActivate = false


func interact():
    if Locked:
        return false

    toggle()

    return true


func toggle():
    if not Active:
        activate()
    else:
        deactivate()

func activate():
    Active = true

    update_visuals()
    activated.emit()
    triggered.emit(true)

    if LockOnActivate: lock()

func deactivate():
    Active = false

    update_visuals()
    deactivated.emit()
    triggered.emit(false)


func update_visuals():
    pass
