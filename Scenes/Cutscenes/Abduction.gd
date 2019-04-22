extends Control

func _ready():
	yield(Utils.loadDialog("res://Dialog/Abduction.txt"), "completed")
	PlayerState.next_scene()