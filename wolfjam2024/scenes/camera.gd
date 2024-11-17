extends Node2D

@export var target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    if target:
        position += (target.global_position - position) * 0.1

func follow(new_target: CharacterBody2D) -> void:
    target = new_target
    var newPosition = target.global_position
    position = lerp(position, newPosition, 0.1)
