extends Toggle

@export var RotationTarget : Node3D 
@export var ActiveAngle : Vector3 = Vector3(-45, 0, 0)
@export var InactiveAngle : Vector3 = Vector3(45, 0, 0)
var _base_ang : Vector3

@onready var _active_angle = Vector3(deg_to_rad(ActiveAngle.x), deg_to_rad(ActiveAngle.y), deg_to_rad(ActiveAngle.z))
@onready var _inactive_angle = Vector3(deg_to_rad(InactiveAngle.x), deg_to_rad(InactiveAngle.y), deg_to_rad(InactiveAngle.z))

func _ready() -> void:
    _base_ang = RotationTarget.rotation

func update_visuals():
    RotationTarget.rotation = _base_ang + (_active_angle if Active else _inactive_angle)
