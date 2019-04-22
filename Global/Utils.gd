extends Node

onready var dialogScene: PackedScene = preload("res://Scenes/UI/Dialog.tscn")

var MarsStart: String = "res://Scenes/MarsStart/Mars.tscn"
var ElonsMuskets: String = "res://Scenes/MarsStart/ElonsMuskets.tscn"
var AbductionArea: String = "res://Scenes/MarsStart/Abduction.tscn"
var AbductionCutscene: String = "res://Scenes/Cutscenes/Abduction.tscn"
var AlienShip: String = "res://Scenes/AlienShip/AlienShip.tscn"
var TicTacToe: String = "res://Scenes/TicTacToe/TicTacToe.tscn"
var TempEnd: String = "res://Scenes/Cutscenes/TempEnd.tscn"

func _ready() -> void:
	#OS.set_window_maximized(true)
	pass

func showDialog(title: String, text: String) -> NodePath:
	var dialog: Node = dialogScene.instance()
	dialog.title = title
	dialog.text = text
	add_child(dialog)
	return dialog.get_path()
	
func loadDialog(dialog_file_path: String) -> void:
	var dialog_path: String = get_tree().get_current_scene().get_name() + "/dialog"
	var dialog: PoolStringArray = []
	var dialog_file: File = File.new()
	dialog_file.open(dialog_file_path, File.READ)
	while not dialog_file.eof_reached():
		var line: String = dialog_file.get_line()
		dialog.append(line)
	dialog_file.close()
	var index = 1
	while index < dialog.size():
		var current_dialog = showDialog(dialog[0], dialog[index])
		yield(get_node(current_dialog).get_node("CanvasLayer/PopupDialog/MarginContainer/VBoxContainer/Button"), "pressed")
		index += 1
	
		