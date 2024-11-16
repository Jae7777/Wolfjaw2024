extends CharacterBody2D

# movement
@export var base_speed := 6.0 * 60
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:
	handle_move(delta)

	move_and_slide()
	print("Player position: ", self.position)

func handle_move(delta: float) -> void:
	if Input.is_action_pressed('move_left'):
		movement_input.x = -1
	elif Input.is_action_pressed('move_right'):
		movement_input.x = 1
	else:
		movement_input.x = 0

	self.velocity = movement_input * base_speed * delta