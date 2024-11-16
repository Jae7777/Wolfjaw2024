extends Node

@export var target: CharacterBody2D
@export var weapon: Node2D

func attack() -> void:
	weapon.attack()
