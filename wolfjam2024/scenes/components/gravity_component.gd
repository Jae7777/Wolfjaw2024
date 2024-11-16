extends Node

@export var target: CharacterBody2D

func _physics_process(_delta: float) -> void:
  handle_gravity(_delta)

func handle_gravity(delta) -> void:
  if not target.is_on_floor():
    target.velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
