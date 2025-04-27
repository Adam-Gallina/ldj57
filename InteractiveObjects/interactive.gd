extends Node3D
class_name Interactive

@export var Locked = false
@export var Reticle : Constants.ReticleType

func interact():
    return false


func lock():
    Locked = true

func unlock():
    Locked = false

#func _process(delta: float) -> void:
 #   if get_node('Alert') and get_node('Alert').visible:
  #      
   #     get_node('Alert').rotation.y = 0

func item_hint_toggled(state:bool):
    if get_node('Alert'):
        $Alert.visible = state