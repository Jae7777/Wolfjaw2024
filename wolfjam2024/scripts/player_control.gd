extends Node

@export var target1: CharacterBody2D
@export var target2: CharacterBody2D
@export var camera: Camera2D

var curr_target: CharacterBody2D
var movement_input := Vector2.ZERO

func _ready() -> void:
  curr_target = target1
  target2.set_follow(target1)
  update_render_order()

func _physics_process(_delta: float) -> void:
  if curr_target:
    handle_move()
    handle_switch()

func handle_switch() -> void:
  if Input.is_action_just_pressed('character_switch'):
    if curr_target == target1:
      curr_target = target2
      target1.reset_velocity()
      target2.unfollow()
      target1.set_follow(target2)
    else:
      curr_target = target1
      target2.reset_velocity()
      target1.unfollow()
      target2.set_follow(target1)
    camera.follow(curr_target)
    update_render_order()

func handle_move() -> void:
  if Input.is_action_pressed('move_left'):
    curr_target.move_left()
  elif Input.is_action_pressed('move_right'):
    curr_target.move_right()
  else:
    curr_target.reset_velocity()

  if Input.is_action_just_pressed('jump') and curr_target.is_on_floor():
    curr_target.jump()

  if Input.is_action_just_pressed('dodge'):
    curr_target.dodge()

func update_render_order() -> void:
  # Ensure the current target is rendered above the other character
  if curr_target == target1:
    target1.z_index = 1
    target2.z_index = 0
  else:
    target1.z_index = 0
    target2.z_index = 1
