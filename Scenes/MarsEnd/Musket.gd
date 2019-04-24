extends Sprite

func _ready():
	if PlayerState.state.has("recoveredMusket"):
		if PlayerState.state["recoveredMusket"]:
			self.set_visible(false)

func action():
	if !PlayerState.state["recoveredMusket"]:
		PlayerState.state["recoveredMusket"] = true
		self.set_visible(false)
		Utils.showDialog("Found it", "You found your musket! It's extremely rusty though. Mars has no water as far as you know, so how is that possible?")
