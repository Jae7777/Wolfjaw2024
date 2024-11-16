extends Node2D

func _physics_process(_delta: float) -> void:
   pass

func attack() -> void:
  print("KID ATTACK")
  $SpawnProjectileComponent.spawn_projectile()
