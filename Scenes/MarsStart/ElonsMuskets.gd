extends Node2D

func _ready() -> void:
	PlayerState.add_player()
	if !PlayerState.state.has("hasMusket"):
		PlayerState.state["hasMusket"] = false
	if PlayerState.state["hasMusket"] == true:
		$Musket.set_visible(false)

func _exit_store(body) -> void:
	if body.get_name() == "Player":
		get_tree().change_scene(Utils.MarsStart)