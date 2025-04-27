extends Node

enum PuzzleItem { Null, GearS, GearM, GearL, HallKey, Crank, Crowbar, Statuette1, Statuette2, Statuette3, Statuette4, Statuette5 }

enum CollisionLayer { Player=1, Enemy=2, Environment=3, Interactive = 4}

enum ReticleType { Hand, Glass }

var _player : CharacterBody3D
func SetPlayer(p:CharacterBody3D):
    _player = p
func GetPlayer() -> CharacterBody3D: return _player