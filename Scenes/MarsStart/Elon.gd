extends Node2D

func action() -> void:
	if !PlayerState.state.has("hasMusket"):
		PlayerState.state["hasMusket"] = false
	if PlayerState.state["hasMusket"] != true:
		Utils.showDialog("Elon","Here is your brand new laser musket! Thanks for choosing Elon's Muskets.")
		PlayerState.state["hasMusket"] = true
		$"../Musket".set_visible(false)
	else:
		Utils.showDialog("Elon","What you coming back here for?")