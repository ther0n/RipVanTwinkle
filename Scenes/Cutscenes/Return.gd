extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(Utils.loadDialog("res://Dialog/Return.txt"), "completed")
	$Animation.play("Flyby")

func _on_Animation_animation_finished(anim_name):
	PlayerState.next_scene()
