extends Node3D
class_name Interactive

@export var Locked = false

func interact():
    return false


func lock():
    Locked = true

func unlock():
    Locked = false