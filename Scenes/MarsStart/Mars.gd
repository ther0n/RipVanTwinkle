extends Node2D
var ready: bool = false
func _ready() -> void:
	PlayerState.add_player()
	var timer: Timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer) #to process
	timer.start(1) #to start

func _on_timer_timeout():
	ready = true

func _on_LeaveArea_body_entered(body):
	if ready:
		if !PlayerState.state.has("hasMusket"):
			PlayerState.state["hasMusket"] = false
		if PlayerState.state["hasMusket"] == false:
			Utils.showDialog("Info", "You should probably pick up a laser musket before venturing out on your own.")
		else:
			PlayerState.update_position("MarsStart", PlayerState.player.get_position() + Vector2(8,0))
			get_tree().change_scene(Utils.AbductionArea)

func _gunstore_entered(body) -> void:
	if body.has_method('get_input'):
		PlayerState.update_position("MarsStart", PlayerState.player.get_position() + Vector2(0,8))
		get_tree().change_scene(Utils.ElonsMuskets)