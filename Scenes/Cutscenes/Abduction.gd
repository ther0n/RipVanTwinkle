extends Control

func _ready():
	yield(Utils.loadDialog("res://Dialog/Abduction.txt"), "completed")
	get_tree().change_scene(Utils.TicTacToe)