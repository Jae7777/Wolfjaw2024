extends CharacterBody2D

# movement
@export var base_speed := 20000
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60


func _physics_process(_delta: float) -> void:
	move_and_slide()
