extends Node

@export var target: CharacterBody2D
@export var weapon: Area2D

func _ready():
    if weapon:
        weapon.attack()  # Call the attack function on the weapon
    else:
        print("Weapon is not assigned!")
