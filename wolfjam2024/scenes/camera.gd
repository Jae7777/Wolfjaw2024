extends Node2D

@export var target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:    
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if target:
        position.x += (target.global_position.x - position.x) * 0.1

func follow(new_target: CharacterBody2D) -> void:
    target = new_target
    var newPosition = target.global_position
    position.x = lerp(position.x, newPosition.x, 0.1)
