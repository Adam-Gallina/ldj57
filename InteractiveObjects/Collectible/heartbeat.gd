extends Node3D

signal heart_collected()
func emit_heart():
    heart_collected.emit()

@export var BeatDelay = 1
@export var BeatFrequency = 4

func _ready():
    heartbeat()

func heartbeat():
    while true:
        await get_tree().create_timer(BeatFrequency).timeout
        $AudioStreamPlayer3D.play()
        await get_tree().create_timer(BeatDelay).timeout
        $AudioStreamPlayer3D.play()

