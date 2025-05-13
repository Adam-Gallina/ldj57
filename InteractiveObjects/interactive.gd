extends Node3D
class_name Interactive

@export var Locked = false
@export var Reticle : Constants.ReticleType = Constants.ReticleType.Hand

func interact():
    return false


func lock():
    Locked = true

func unlock():
    Locked = false

func item_hint_toggled(state:bool):
    if get_node('Alert'):
        $Alert.visible = state