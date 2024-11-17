extends Area2D

@onready var attack_timer = $AttackTimer
@export var damage: int = 2

func _on_area_entered(area: Area2D) -> void:
  if attack_timer.is_stopped():
    return
  if area.has_node("HealthComponent"):
    area.get_node("HealthComponent").take_damage(damage)

func attack() -> void:
  attack_timer.start() 
