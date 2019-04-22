extends Node2D

func action():
	Utils.showDialog("Info", "There are a lot of valuable ores here!")
	yield(get_node("/root/Utils/Dialog/CanvasLayer/PopupDialog/MarginContainer/VBoxContainer/Button"), "pressed")
	$"../.."._on_rock_found()