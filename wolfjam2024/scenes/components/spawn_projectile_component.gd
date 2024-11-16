extends Node2D


@export var projectile: PackedScene
@export var projectile_spawn_point: Node2D

func spawn_projectile() -> void:
  var new_projectile = projectile.instance()
  new_projectile.global_position = projectile_spawn_point.global_position
  get_parent().add_child(new_projectile)