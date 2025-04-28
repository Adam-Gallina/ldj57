extends Toggle

@export var RotationTarget : Node3D 
@export var ActiveAngle : Vector3 = Vector3(-45, 0, 0)
@export var InactiveAngle : Vector3 = Vector3(45, 0, 0)
var _base_ang : Vector3

@export var MovementTarget : Node3D
@export var ActiveOffset : Vector3 = Vector3(2, 0, 0)
@export var InactiveOffset : Vector3 = Vector3(0, 0, 0)
var _base_pos : Vector3

var _active_angle
var _inactive_angle

func _ready() -> void:
	if RotationTarget != null:
		_base_ang = RotationTarget.rotation
	if MovementTarget != null:
		_base_pos = MovementTarget.position

	_active_angle = Vector3(deg_to_rad(ActiveAngle.x), deg_to_rad(ActiveAngle.y), deg_to_rad(ActiveAngle.z))
	_inactive_angle = Vector3(deg_to_rad(InactiveAngle.x), deg_to_rad(InactiveAngle.y), deg_to_rad(InactiveAngle.z))


func update_visuals():
	if RotationTarget != null:
		RotationTarget.rotation = _base_ang + (_active_angle if Active else _inactive_angle)
	if MovementTarget != null:
		MovementTarget.position = _base_pos + (ActiveOffset if Active else InactiveOffset)
