extends CharacterBody3D
class_name EnemyBase

@export var MoveSpeed = 4
var _moving = true

@export var MaxHealth = 3
@onready var _health = MaxHealth

@export var AttackDist = 2
@export var AttackDamage = 1
@export var AttackSpeed = 2.
var _next_attack : float = 0

@onready var _agent : NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	_agent.max_speed = MoveSpeed
	_agent.velocity_computed.connect(_on_velocity_calculated)


func _process(delta: float) -> void:
	_next_attack -= delta

	var p = get_parent().get_node('Player')
	if global_position.distance_to(p.global_position) <= AttackDist:
		_attack(p)
		_moving = false
	else:
		_moving = true


func _physics_process(_delta):
	if not _moving: return

	_agent.target_position = get_parent().get_node('Player').global_position
	_agent.get_next_path_position()

	var next_pos : Vector3 = _agent.get_next_path_position()
	var next_v : Vector3 = global_position.direction_to(next_pos) * MoveSpeed
	if _agent.avoidance_enabled:
		_agent.set_velocity(next_v)
	else:
		_on_velocity_calculated(next_v)

func _on_velocity_calculated(safe_v : Vector3):	
	if not _moving: return

	velocity = safe_v
	move_and_slide()


func _attack(target):
	if _next_attack <= 0:
		_next_attack = AttackSpeed

func damage(amount):
	_health -= amount

	if _health <= 0:
		queue_free()