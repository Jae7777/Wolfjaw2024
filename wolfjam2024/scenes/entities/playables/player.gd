extends CharacterBody2D

# movement
@export var base_speed := 400
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

func follow(target: CharacterBody2D) -> void:
	position.x += (target.global_position.x - position.x) * 0.1

func jump() -> void:
	velocity.y = -600

func move_left() -> void:
	velocity.x = -base_speed

func move_right() -> void:
	velocity.x = base_speed

func reset_velocity() -> void:
	velocity.x = 0