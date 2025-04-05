extends Toggle


@export var ActiveAngle = -45
@export var InactiveAngle = 45
@onready var _pivot = $Pivot

func update_visuals():
    _pivot.rotation.x = deg_to_rad(ActiveAngle if Active else InactiveAngle)
