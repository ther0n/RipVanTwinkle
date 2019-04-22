extends Node2D

var ready: bool = false

func _ready():
	PlayerState.add_player()
	PlayerState.player.set_position(Vector2(368, 0))
	Utils.showDialog("Info", "Search the area for ores!")
	var timer: Timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(1) #to start

func _on_timer_timeout():
	ready = true

func _on_rock_found():
	$UFO.set_visible(true)
	$UFO/Animation.play("Abducting")
	var timer: Timer = Timer.new()
	timer.connect("timeout",self,"_on_abducted") 
	add_child(timer) #to process
	timer.start(3) #to start

func _on_abducted():
	get_tree().change_scene("res://Scenes/Abduction/Abduction.tscn")

func _on_LeaveArea_body_entered(body):
	if ready:
		get_tree().change_scene("res://Scenes/MarsStart/Mars.tscn")
