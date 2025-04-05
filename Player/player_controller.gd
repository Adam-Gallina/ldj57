extends CharacterBody3D

@export_category('Movement')
@export var MoveSpeed = 10

@export_category('Combat')
@export var AttackSpeed = 0
@export var AttackDamage = 1
var _attack_cooldown = 0

@export_category('Camera')
@export var CamSpeed = .125
var curr_pan_mod = 1
@export var MinPitch = -90.
@export var MaxPitch = 90.
var pitch:
	set(val): $Camera3D.rotation.x = val
	get: return $Camera3D.rotation.x
var yaw:
	set(val): rotation.y = val
	get: return rotation.y


@onready var cam: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	if Input.is_action_just_pressed('menu_pause'):
		if Input.is_key_pressed(KEY_SHIFT):
			get_tree().quit.call_deferred()

		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE

	_handle_input(delta)

	velocity = _handle_movement(delta)
	move_and_slide()
	apply_floor_snap()


func _handle_movement(_delta):
	var x = Input.get_axis('Left', 'Right')
	var z = Input.get_axis('Forward', 'Back')

	var b : Basis = transform.basis
	var dir = (b.z * z + b.x * x).normalized() * MoveSpeed

	return dir

func _handle_input(_delta):
	if raycast.is_colliding():
		if Input.is_action_just_pressed('Fire'):
			var hit = raycast.get_collider()
			if hit is EnemyBase:
				hit.damage(AttackDamage)


func set_camera(p: float, y: float):
	yaw = y
	if p < MinPitch: p = MinPitch
	elif p > MaxPitch: p = MaxPitch
	pitch = p

func _rotate_camera(dp: float, dy: float):
	yaw -= dy * CamSpeed * curr_pan_mod * PI / 180
	var p = pitch * 180 / PI - dp * CamSpeed * curr_pan_mod
	if p < MinPitch: p = MinPitch
	elif p > MaxPitch: p = MaxPitch
	pitch = p * PI / 180

func _input(event):
	if event is InputEventMouseMotion:
		_rotate_camera(event.relative.y, event.relative.x)
