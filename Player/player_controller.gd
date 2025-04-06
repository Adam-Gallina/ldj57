extends CharacterBody3D

@export_category('Movement')
@export var MoveSpeed = 10
var _disable_movement = false

@export_category('Combat')
@export var AttackDamage = 1
@export var ThrowStrenth = 20

@export_category('Camera')
@export var CamSpeed = .125
@export var MinPitch = -90.
@export var MaxPitch = 90.
var pitch:
	set(val): $Camera3D.rotation.x = val
	get: return $Camera3D.rotation.x
var yaw:
	set(val): rotation.y = val
	get: return rotation.y
var _disable_cam = false
@export var CamMod = 1.


@onready var cam: Camera3D = $Camera3D
@onready var raycast: RayCast3D = $Camera3D/RayCast3D

func _ready() -> void:
	Inventory.inventory_item_selected.connect(_on_item_selected)


func _process(delta):
	_handle_input(delta)

	if not _disable_movement:
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
	if Input.is_action_just_pressed('Inventory'):
		_disable_cam = Inventory.toggle_ui()

	if _disable_cam: return
	
	if not raycast.is_colliding():
		Inventory.hide_reticle()
		if Input.is_action_just_pressed('Fire'):
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Inventory.show_reticle()

		if Input.is_action_just_pressed('Fire'):
			var hit = raycast.get_collider()
			
			if hit is Grabbable:
				if hit.interact():
					Inventory.add_item(hit)
			elif hit is Placeable:
				_disable_cam = true
				_disable_movement = true
				await hit.interact()
				_disable_cam = false
				_disable_movement = false
			elif hit is UIToggle:
				_disable_cam = true
				_disable_movement = true
				await hit.interact()
				_disable_cam = false
				_disable_movement = false
			elif hit is Interactive:
				hit.interact()


func set_camera(p: float, y: float):
	yaw = y
	if p < MinPitch: p = MinPitch
	elif p > MaxPitch: p = MaxPitch
	pitch = p

func _rotate_camera(dp: float, dy: float):
	yaw -= dy * CamSpeed * CamMod * PI / 180
	var p = pitch * 180 / PI - dp * CamSpeed * CamMod
	if p < MinPitch: p = MinPitch
	elif p > MaxPitch: p = MaxPitch
	pitch = p * PI / 180

func _input(event):
	if event is InputEventMouseMotion and not _disable_cam:
		_rotate_camera(event.relative.y, event.relative.x)



func _on_item_selected(item):
	if item == Constants.PuzzleItem.Null:
		_disable_cam = false
		_disable_movement = false