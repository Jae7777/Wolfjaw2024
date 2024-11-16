extends Node2D

@export var target: Node2D
@export var health: int = 3
@export var hurtbox: CollisionShape2D

signal died

func _ready() -> void:
    # Ensure the hurtbox's parent Area2D has the correct collision layer
    if hurtbox:
        var parent_area = hurtbox.get_parent()  # Get the parent (usually Area2D)
        if parent_area and parent_area is Area2D:
            # Enable collision layer 0 (layer index 1)
            parent_area.collision_layer |= 1 << 0  # Set bit 0 to 1
            
# Function to handle damage
func take_damage(amount: int = 1) -> void:
    health -= amount
    print("Enemy took damage! Remaining health:", health)
    if health <= 0:
        die()

# Function to handle death
func die() -> void:
    print("Enemy is dead!")
    emit_signal("died")  # Emit the 'died' signal for other scripts
    queue_free()
