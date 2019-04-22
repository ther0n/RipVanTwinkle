extends Node

var state: Dictionary
var in_menu: bool = false
onready var playerScene: PackedScene = preload("res://Scenes/Player.tscn")
var player: Node2D
var positions: Dictionary = {}
var scenes: Array = []
var currentScene: int = -1

func _ready():
	# 0
	scenes.append("res://Scenes/Cutscenes/Intro.tscn")
	# 1
	scenes.append("res://Scenes/MarsStart/Mars.tscn")
	# 2
	scenes.append("res://Scenes/Cutscenes/Abduction.tscn")
	# 3
	scenes.append("res://Scenes/AlienShip/AlienShip.tscn")
	# 4
	scenes.append("res://Scenes/TicTacToe/TicTacToe.tscn")
	# 5
	scenes.append("res://Scenes/Cutscenes/Return.tscn")
	# 6
	scenes.append("res://Scenes/Cutscenes/TempEnd.tscn")


func add_player() -> void:
	player = playerScene.instance()
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() -1)
	current_scene.add_child(player)
	
func get_position(sceneName: String) -> Vector2:
	if positions.has(sceneName):
		return positions[sceneName]
	else:
		return Vector2(0,0)
		
func update_position(sceneName: String, position: Vector2) -> void:
	positions[sceneName] = position

func next_scene():
	currentScene += 1
	get_tree().change_scene(scenes[currentScene])