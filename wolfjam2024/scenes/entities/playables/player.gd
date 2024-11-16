extends CharacterBody2D

# movement
@export var base_speed := 6.0 * 60
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60

var movement_input := Vector2.ZERO

func _physics_process(delta: float) -> void:


	move_and_slide()

func handle_move(delta: float) -> void:
	movement_input = Input.get_vector('move_left', 'move_right', 'move_forward', 'move_backward').rotated(-camera.global_rotation.y).normalized()
	var velocity_2d = Vector2(self.velocity.x, self.velocity.z)
	if movement_input.length() > 0.0:
		var move_speed = _get_move_speed()
		velocity_2d = movement_input * move_speed * delta
		model.set_move_state("Running_B")
		var target_angle = -movement_input.angle() + PI/2
		model.rotation.y = rotate_toward(model.rotation.y, target_angle, 9.0 * delta)
	else:
		velocity_2d = velocity_2d.move_toward(Vector2.ZERO, base_speed * delta * 4.0)
		model.set_move_state("Idle")
	self.velocity.x = velocity_2d.x
	self.velocity.z = velocity_2d.y