# spawn_projectile_component.gd
extends Node2D

@export var projectile: PackedScene
@export var projectile_spawn_point: Node2D
@export var damage: int = 1
@export var projectile_speed: int = 10
@export var sprite: Sprite2D

func _physics_process(_delta: float) -> void:
    # Get the mouse position and make the sprite look at it
    var mouse_position = get_global_mouse_position()
    sprite.look_at(mouse_position)

func spawn_projectile() -> void:
    # Instantiate a new projectile
    var new_projectile = projectile.instantiate()
    
    # Set initial position
    new_projectile.global_position = projectile_spawn_point.global_position
    
    # Calculate direction to mouse
    var direction = (get_global_mouse_position() - projectile_spawn_point.global_position).normalized()
    
    # Initialize the projectile with necessary data
    if new_projectile.has_method("with_data"):
        new_projectile.with_data(
            projectile_spawn_point.global_position,
            direction,
            damage,
            projectile_speed
        )
    
    # Add the new projectile to the parent node's "Projectiles" node
    get_parent().get_node("Projectiles").add_child(new_projectile)
