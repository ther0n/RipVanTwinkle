extends Node2D
var ready: bool = false
func _ready() -> void:
	PlayerState.state["marsEnd"] = false
	PlayerState.add_player()
	var timer: Timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.set_one_shot(true)
	timer.start(3) #to start

func _on_timer_timeout():
	if !PlayerState.state["marsEnd"]:
		Utils.loadDialog("res://Dialog/MarsEnd2.txt")
		PlayerState.state["marsEnd"] = true
	ready = true

func _on_LeaveArea_body_entered(body):
	if body.has_method('get_input'):
		PlayerState.update_position("MarsEnd", PlayerState.player.get_position() + Vector2(8,0))
		get_tree().change_scene(Utils.AbductionAreaEnd)

func _gunstore_entered(body) -> void:
	if body.has_method('get_input'):
		PlayerState.update_position("MarsEnd", PlayerState.player.get_position() + Vector2(0,8))
		get_tree().change_scene(Utils.ElonsMusketsEnd)