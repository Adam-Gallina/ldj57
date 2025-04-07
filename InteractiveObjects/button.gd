extends Interactive

signal pressed()

@export var ShowMouseOnPress = false

func interact():
    if Locked:
        return false

    pressed.emit()
    if ShowMouseOnPress:
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    return true
