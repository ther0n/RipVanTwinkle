extends Node

var state: Dictionary
var in_menu: bool = false
onready var playerScene: PackedScene = preload("res://Scenes/Player.tscn")
var player: Node2D
var positions: Dictionary

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