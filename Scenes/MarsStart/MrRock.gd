extends Node2D

func action() -> void:
	if !PlayerState.state.has("timesTalkedToMrRock"):
		PlayerState.state["timesTalkedToMrRock"] = 0
	if PlayerState.state["timesTalkedToMrRock"] == 0:
		Utils.showDialog("Mr. Rock","Hello. My name is Mr. Rock")
	elif PlayerState.state["timesTalkedToMrRock"] >= 25:
		Utils.showDialog("Mr. Rock","I'm a rock for a reason. I'm introverted, leave me alone.")
	elif PlayerState.state["timesTalkedToMrRock"] >= 10:
		Utils.showDialog("Mr. Rock","You're getting REALLY annoying...")
	elif PlayerState.state["timesTalkedToMrRock"] == 5:
		Utils.showDialog("Mr. Rock","You're getting annoying...")
	else:
		Utils.showDialog("Mr. Rock","Not many people talk to rocks.")
	PlayerState.state["timesTalkedToMrRock"] += 1