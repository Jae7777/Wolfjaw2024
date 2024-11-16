extends Node

@export var target: CharacterBody2D
@export var dodge_timer: Timer

@export var base_speed := 350
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60

var face_direction: int = 1

func _physics_process(_delta: float) -> void:
	target.move_and_slide()

func jump() -> void:
	target.velocity.y = -600

func move_left() -> void:
	if dodge_timer.time_left == 0:
		target.velocity.x = -base_speed
		face_direction = -1

func move_right() -> void:
	if dodge_timer.time_left == 0:
		target.velocity.x = base_speed
		face_direction = 1

func reset_velocity() -> void:
	if dodge_timer.time_left == 0:
		target.velocity.x = 0