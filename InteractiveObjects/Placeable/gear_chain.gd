extends ToggleGroup

@export var StartGear : Node3D
@export var EndGear : Node3D

@export var StartGearSpeed = 5.

func _process(delta):
	StartGear.rotation.z += StartGearSpeed * delta
	var dir = -1

	for t in TargetToggles:
		if not t.Active:
			break
		
		t.rotation.z += StartGearSpeed * delta * dir
		dir *= -1

	if Active:
		EndGear.rotation.z += StartGearSpeed * delta * dir
