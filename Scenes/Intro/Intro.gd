extends Control

func _ready():
	yield(Utils.loadDialog("res://Dialog/Backstory.txt"), "completed")
	get_tree().change_scene("res://Scenes/MarsStart/Mars.tscn")