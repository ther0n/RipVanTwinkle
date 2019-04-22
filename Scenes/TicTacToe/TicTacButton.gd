extends TextureButton

const otex = preload("res://Assets/OGlow.png")
const xtex = preload("res://Assets/XGlow.png")
const hover = preload("res://Assets/Hover.png")

var value = 0
export(int) var row = -1
export(int) var col = -1

signal custom_pressed(button)

func _ready():
	reset()

func setX( val=1 ):
	value = val;
	texture_normal = xtex
	texture_hover = xtex

func setO( val=10 ):
	value = val
	texture_normal = otex
	texture_hover = otex

func reset():
	value = 0
	texture_normal = null
	texture_hover = hover

func _on_TicTacButton_pressed():
	print("button pressed")
	emit_signal( "custom_pressed", self )
