extends Area2D

@export var health_component: Node2D  # Reference to the HealthComponent

func _ready() -> void:
    # Ensure the health component is set up and connect the 'died' signal
    if health_component:
        health_component.connect("died", Callable(self, "_on_enemy_died"))

# Detect collision with hurtboxes
func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("hurtbox") and health_component:
        health_component.take_damage(1)

# Handle enemy death
func _on_enemy_died() -> void:
    print("Enemy removed from game.")
    queue_free()
