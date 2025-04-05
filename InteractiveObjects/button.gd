extends Interactive

signal pressed()

func interact():
    if Locked:
        return false

    pressed.emit()
    return true
