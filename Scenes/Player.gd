extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (int) var speed: int = 50
var playerdir: String = 'down'
var velocity: Vector2 = Vector2()
onready var currentSceneName: String = get_tree().get_current_scene().get_name()

func _ready() -> void:
	position = PlayerState.get_position(currentSceneName)

func get_input() -> void:
	if !PlayerState.in_menu:
		velocity = Vector2()
		if Input.is_action_pressed('player_up'):
			playerdir = 'up'
			velocity.y -= 1
		if Input.is_action_pressed('player_down'):
			playerdir = 'down'
			velocity.y += 1
		if Input.is_action_pressed('player_right'):
			playerdir = 'right'
			velocity.x += 1
		if Input.is_action_pressed('player_left'):
			playerdir = 'left'
			velocity.x -= 1
		if Input.is_action_just_released('action'):
			if $Ray.is_colliding():
				var object = $Ray.get_collider().get_parent()
				if object.has_method('action'):
					object.action()
		velocity = velocity.normalized() * speed
	else: velocity = Vector2()
	
func _physics_process(delta) -> void:
	get_input()
	set_anim()
	move_and_slide(velocity)
	if velocity != Vector2(0,0):
		$Ray.set_cast_to((velocity/speed)*10)
	
func set_anim() -> void:
	var animation = 'idle'
	if velocity != Vector2(0,0):
		animation = 'walk'
	var newanim = str(animation,playerdir)
	$Animation.play(newanim)
