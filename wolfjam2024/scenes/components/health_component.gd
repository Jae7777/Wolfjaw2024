extends Node2D

@export var target: Node2D
@export var health := 3
@export var hurtbox : CollisionShape2D

func take_damage(damage: int) -> void:
  health -= damage
  if health <= 0:
    target.queue_free()