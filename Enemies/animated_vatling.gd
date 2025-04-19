extends Node3D

@export var GearsActive = true
@export var TopGearSpeed = 4.
@export var BotGearSpeed = 3.

@onready var _top_gear : Node3D = $Buns2/Torso2/GearBlocker2/Gear32
@onready var _bot_gear : Node3D = $Buns2/Torso2/GearMount2/MediumGear

func _process(delta):
	if GearsActive:
		_top_gear.rotation.y += TopGearSpeed * delta
		_bot_gear.rotation.y -= BotGearSpeed * delta


func _activate_gears():
	GearsActive = true

func _deactivate_gears():
	GearsActive = false
