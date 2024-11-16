extends CharacterBody2D

# movement
@export var base_speed := 20000
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60


func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	move_and_slide()

func handle_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
