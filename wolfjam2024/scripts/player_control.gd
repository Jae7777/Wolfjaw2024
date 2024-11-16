extends Node

@export var target1: CharacterBody2D
@export var target2: CharacterBody2D

var curr_target: CharacterBody2D
var movement_input := Vector2.ZERO

func _ready() -> void:
  curr_target = target1


func _physics_process(delta: float) -> void:
  if curr_target:
    handle_move(delta)

func handle_move(delta: float) -> void:
  if Input.is_action_pressed('move_left'):
    movement_input.x = -1
  elif Input.is_action_pressed('move_right'):
    movement_input.x = 1
  else:
    movement_input.x = 0

  curr_target.velocity.x = movement_input.x * curr_target.base_speed * delta
  if Input.is_action_just_pressed('jump') and curr_target.is_on_floor():
    print('jump')
    curr_target.velocity.y = -600
  elif not curr_target.is_on_floor():
    curr_target.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
  else:
    curr_target.velocity.y = 0