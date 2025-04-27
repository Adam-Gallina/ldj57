extends CharacterBody3D

enum PatrolMode { Idle, Patrol, Chase, Sentry, Investigate, Return }

@onready var _model = $AnimatedVatling_WGear

#@export_group("Movement")
@export var path : Path3D
@onready var pf : PathFollow3D = $PathFollow3D
@onready var ai : NavigationAgent3D = $NavigationAgent3D

@export var PatrolSpeed = 3.
@export var ChaseSpeed = 4.

#@export_group("Detection")
@onready var ray : RayCast3D = $RayCast3D
@export var PlayerDetectionDist = 10.
@export var PlayerDetectionAngle = 45.
@export var PlayerChaseDetectionAngle = 75.
var _last_detected_pos = Vector3.ZERO
@export var InvestigationDuration = 3.
var _investigation_time = 0

@export var Mode = PatrolMode.Patrol
func set_mode(new_mode:PatrolMode):
	Mode = new_mode

func _ready():
	remove_child(pf)
	path.add_child(pf)

func _process(delta):
	if Mode == PatrolMode.Idle:
		return

	var p : Vector3 = Constants.GetPlayer().global_position
	ray.target_position = p - global_position

	if ray.is_colliding() and ray.get_collider().get_collision_layer_value(Constants.CollisionLayer.Player):
		if global_position.distance_to(p) <= PlayerDetectionDist:
			if _model.global_basis.z.angle_to(p - global_position) > deg_to_rad(180 - PlayerDetectionAngle):
				set_mode(PatrolMode.Chase)
				_last_detected_pos = p


	if Mode == PatrolMode.Chase:
		if ray.is_colliding() and ray.get_collider().get_collision_layer_value(Constants.CollisionLayer.Player):
			if _model.global_basis.z.angle_to(p - global_position) > deg_to_rad(180 - PlayerChaseDetectionAngle):
				_last_detected_pos = p

	elif Mode == PatrolMode.Investigate:
		_investigation_time += delta
		if _investigation_time >= InvestigationDuration:
			set_mode(PatrolMode.Return)


func _physics_process(delta):
	if Mode == PatrolMode.Idle:
		return

	if Mode == PatrolMode.Patrol:
		pf.progress += PatrolSpeed * delta

		global_position = pf.global_position
		_model.global_basis = pf.global_basis

	elif Mode == PatrolMode.Chase:
		if ai.target_position != _last_detected_pos:
			ai.target_position = _last_detected_pos

		var next_pos : Vector3 = ai.get_next_path_position()

		velocity = global_position.direction_to(next_pos) * ChaseSpeed
		_model.look_at(global_position + velocity)
		move_and_slide()

	elif Mode == PatrolMode.Investigate:
		_model.rotation.y += delta * deg_to_rad(30)

	elif Mode == PatrolMode.Return:
		var offset = path.curve.get_closest_offset(global_position - path.global_position)
		pf.progress = offset

		ai.target_position = pf.global_position
		var next_pos : Vector3 = ai.get_next_path_position()

		velocity = global_position.direction_to(next_pos) * ChaseSpeed
		_model.look_at(global_position + velocity)
		move_and_slide()


func _on_target_reached() -> void:
	if Mode == PatrolMode.Chase:
		set_mode(PatrolMode.Investigate)
		_investigation_time = 0
	if Mode == PatrolMode.Return:
		set_mode(PatrolMode.Patrol)
