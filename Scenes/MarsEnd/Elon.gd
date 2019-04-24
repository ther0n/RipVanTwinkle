extends Node2D

func action() -> void:
	yield(Utils.loadDialog("res://Dialog/ElonEnd1.txt"), "completed")
	yield(Utils.loadDialog("res://Dialog/ElonEnd2.txt"), "completed")
	Utils.showDialog("The end", "This is the end of the game. You may continue exploring if you wish.")
