extends Node2D

@export var target: Node2D
@export var health := 3
@export var healthbar: ProgressBar

func _ready() -> void:
  set_health_bar()
  
func take_damage(damage: int) -> void:
  health -= damage
  if health <= 0:
    target.queue_free()
  set_health_bar()
    
func set_health_bar() -> void:
  healthbar.value = health
