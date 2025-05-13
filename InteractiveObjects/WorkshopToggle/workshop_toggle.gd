extends ToggleOutput

@export var RotationTarget : Node3D

func interact():
    RotationTarget.rotation.y += PI/2
    super()
