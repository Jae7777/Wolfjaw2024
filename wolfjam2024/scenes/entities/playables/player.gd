extends CharacterBody2D

# movement
@export var base_speed := 20000
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	handle_move(delta)

	move_and_slide()
	print(is_on_floor())

func handle_move(delta: float) -> void:
	if Input.is_action_pressed('move_left'):
		movement_input.x = -1
	elif Input.is_action_pressed('move_right'):
		movement_input.x = 1
	else:
		movement_input.x = 0

	self.velocity.x = movement_input.x * base_speed * delta
	if not is_on_floor():
		self.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	else:
		self.velocity.y = 0