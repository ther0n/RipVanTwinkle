extends Control

onready var popup : PopupDialog = $"CanvasLayer/PopupDialog"
onready var titleLabel : RichTextLabel = $"CanvasLayer/PopupDialog/MarginContainer/VBoxContainer/Title"
onready var textLabel : RichTextLabel = $"CanvasLayer/PopupDialog/MarginContainer/VBoxContainer/Text"
var characters : int
var chars_visible : int = 0
var title: String
var text: String

func _ready() -> void:
	titleLabel.set_text(title)
	textLabel.set_text(text)
	popup.popup_centered_ratio()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if chars_visible < characters:
		chars_visible += 1
		textLabel.set_visible_characters(chars_visible)

func _on_PopupDialog_about_to_show() -> void:
	characters = textLabel.get_text().length()
	PlayerState.in_menu = true

func _on_PopupDialog_popup_hide() -> void:
	PlayerState.in_menu = false
	queue_free()
	
func _on_Button_pressed() -> void:
	_on_PopupDialog_popup_hide()
