extends CharacterBody2D

# movement
@export var base_speed := 500
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60

var follow_target: CharacterBody2D

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	follow()
	move_and_slide()

func handle_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

func unfollow() -> void:
	follow_target = null

func set_follow(target: CharacterBody2D) -> void:
	follow_target = target

func follow() -> void:
	if follow_target:
		if follow_target.global_position.x > global_position.x + 200:
			move_right()
		elif follow_target.global_position.x < global_position.x - 200:
			move_left()
		else:
			reset_velocity()

func jump() -> void:
	velocity.y = -600

func move_left() -> void:
	if $RollTimer.time_left == 0:
		velocity.x = -base_speed

func move_right() -> void:
	if $RollTimer.time_left == 0:
		velocity.x = base_speed

func reset_velocity() -> void:
	if $RollTimer.time_left == 0:
		velocity.x = 0

func roll() -> void:
	velocity.x = base_speed * 2
	$RollTimer.start()
