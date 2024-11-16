extends Node

@export var movement_component: Node
@export var target: CharacterBody2D

var follow_target: CharacterBody2D

func _physics_process(_delta: float) -> void:
  follow()

func unfollow() -> void:
  follow_target = null

func set_follow(new_target: CharacterBody2D) -> void:
  follow_target = new_target

func follow() -> void:
  if follow_target:
	if follow_target.global_position.x > target.global_position.x + 200:
	  movement_component.move_right()
	elif follow_target.global_position.x < target.global_position.x - 200:
	  movement_component.move_left()
	else:
	  movement_component.reset_velocity()
