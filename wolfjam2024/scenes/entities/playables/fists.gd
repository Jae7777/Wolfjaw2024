extends Area2D

@export var damage: int = 1
@export var attack_cooldown: float = 1.0
var can_attack: bool = true 

func _ready() -> void:
    # Ensure the signal is connected
    connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(area: Area2D) -> void:
    # Check if the area belongs to the "hurtbox" group
    if area.is_in_group("hurtbox"):
        # Attempt to call the `take_damage` function on the area
        if area.has_method("take_damage"):
            area.take_damage(damage)
        else:
            print("Target does not have a 'take_damage' method!")

# Function to trigger the attack
func attack():
    if can_attack:
        print("Attack function triggered!")
        
        # Trigger attack logic by enabling collision detection
        $CollisionShape2D.disabled = false  # Enable collision detection for attack

        # Emit the attack signal
        emit_signal("attack_triggered")

        # Start cooldown to prevent spamming attacks
        can_attack = false
        
        # Use await with create_timer in Godot 4.0
        await get_tree().create_timer(attack_cooldown).timeout
        
        can_attack = true
        
        # Disable the collision again after the attack
        $CollisionShape2D.disabled = true
    else:
        print("Attack on cooldown.")
