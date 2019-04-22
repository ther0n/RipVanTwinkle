extends Node2D

func action():
	yield(Utils.loadDialog("res://Dialog/Alien.txt"), "completed")
	PlayerState.next_scene()
