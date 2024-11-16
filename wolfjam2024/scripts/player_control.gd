extends Node

@export var target1: CharacterBody2D
@export var target2: CharacterBody2D
@export var camera: Camera2D

var curr_target: CharacterBody2D
var movement_input := Vector2.ZERO

func _ready() -> void:
  curr_target = target1

func _physics_process(delta: float) -> void:
  if curr_target:
    handle_move(delta)
    handle_switch()

func handle_switch() -> void:
  if Input.is_action_just_pressed('character_switch'):
    if curr_target == target1:
      curr_target = target2
      target1.velocity = Vector2.ZERO
    else:
      curr_target = target1
      target2.velocity = Vector2.ZERO
    camera.follow(curr_target)

func handle_move(delta: float) -> void:
  if Input.is_action_pressed('move_left'):
    movement_input.x = -1
  elif Input.is_action_pressed('move_right'):
    movement_input.x = 1
  else:
    movement_input.x = 0

  curr_target.velocity.x = movement_input.x * curr_target.base_speed * delta
  if Input.is_action_just_pressed('jump') and curr_target.is_on_floor():
    curr_target.velocity.y = -600