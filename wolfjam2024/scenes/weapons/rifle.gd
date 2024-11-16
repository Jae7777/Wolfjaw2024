extends Node2D

@export var fire_timer: Timer

func _physics_process(_delta: float) -> void:
   pass

func attack() -> void:
  if fire_timer.time_left == 0:
    fire_timer.start()
    $SpawnProjectileComponent.spawn_projectile()
