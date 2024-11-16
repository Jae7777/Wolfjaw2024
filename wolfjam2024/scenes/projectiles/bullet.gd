# bullet.gd
extends Area2D

var spawn_position: Vector2
var direction: Vector2
var damage: int
var speed: int

func _ready() -> void:
    position = spawn_position
    # Optionally rotate the bullet sprite to face the direction of movement
    rotation = direction.angle()

func with_data(spawn_position_: Vector2, direction_: Vector2, damage_: int, speed_: int) -> Area2D:
    spawn_position = spawn_position_
    direction = direction_
    damage = damage_
    speed = speed_
    return self

func _physics_process(delta: float) -> void:
    # Move in the direction at constant speed
    position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()
