extends Control

func _ready():
	yield(Utils.loadDialog("res://Dialog/Backstory.txt"), "completed")
	PlayerState.next_scene()