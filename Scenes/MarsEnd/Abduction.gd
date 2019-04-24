extends Node2D

var ready: bool = false

func _ready():
	if !PlayerState.positions.has("recoveredMusket"):
		PlayerState.state["recoveredMusket"] = false
	if !PlayerState.positions.has("MarsEnd") and PlayerState.positions.has("MarsStart"):
		PlayerState.update_position("MarsEnd", PlayerState.positions["MarsStart"])
	PlayerState.add_player()
	PlayerState.player.set_position(Vector2(368, 0))
	var timer: Timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.set_one_shot(true)
	timer.start(3) #to start

func _on_timer_timeout():
	if !PlayerState.state["recoveredMusket"]:
		yield(Utils.loadDialog("res://Dialog/MarsEnd1.txt"), "completed")
	ready = true

func _on_LeaveArea_body_entered(body):
	if ready and PlayerState.state["recoveredMusket"]:
		get_tree().change_scene(Utils.MarsEnd)
	if ready and !PlayerState.state["recoveredMusket"]:
		Utils.showDialog("Musket", "You should see if you can find the musket you dropped when you were abducted.")
