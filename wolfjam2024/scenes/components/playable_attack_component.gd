extends Node

@export var target: CharacterBody2D
@export var weapon: Node2D
@export var animated_sprite: AnimatedSprite2D

func attack() -> void:
  animated_sprite.stop()
  animated_sprite.play("melee")
  weapon.attack()
