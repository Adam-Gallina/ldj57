extends ToggleGroup

@export var StartGear : Node3D
@export var EndGear : Node3D

@export var StartGearSpeed = 5.

func _process(delta):
	# Not really the best way to do it, as the Lock behavior of gear chain won't match the Lock behavior of toggle groups
	if Locked: return

	StartGear.rotation.z += StartGearSpeed * delta
	var dir = -1

	for t in TargetToggles:
		if not t.Active:
			break
		
		t.rotation.z += StartGearSpeed * delta * dir
		dir *= -1

	if Active:
		EndGear.rotation.z += StartGearSpeed * delta * dir

func interact():
	if Locked: return

	super()

func unlock():
	super()
	interact()

func lock():
	if Active:
		deactivate()
	super()