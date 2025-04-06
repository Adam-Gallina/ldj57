extends Toggle
class_name ToggleGroup

@export var TargetToggles : Array[Toggle]

func interact():
	for t in TargetToggles:
		if not t.Active:
			if Active:
				deactivate()
			return false

	if not Active:
		activate()
	return true


func activate():
	super()

	if LockOnActivate:
		for t in TargetToggles:
			t.lock()
