extends Node2D

func _ready():
	PlayerState.add_player()
	PlayerState.player.set_position(Vector2(0, 64))
