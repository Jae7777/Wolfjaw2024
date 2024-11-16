extends Node

@export var target: CharacterBody2D
@export var dodge_timer: Timer

@export var base_speed := 350
@export var run_speed := 10.0 * 60
@export var defend_speed := 2.0 * 60
@export var jump_velocity := -600
@export var roll_speed := 600

var face_direction: int = 1

func _physics_process(_delta: float) -> void:
  target.move_and_slide()

func jump() -> void:
  if jump_velocity != 0:
    target.velocity.y = jump_velocity

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

func roll() -> void:
  if dodge_timer.time_left == 0 and roll_speed != 0:
    target.velocity.x = roll_speed * 2 * face_direction
    dodge_timer.start()
