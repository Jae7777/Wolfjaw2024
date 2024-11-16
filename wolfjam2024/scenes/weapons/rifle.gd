extends Node2D


@onready var GunParticle = $Sprite2D/ProjectileSpawnPoint/GunParticle

func _ready():
  GunParticle.emitting = false
  
func _physics_process(_delta: float) -> void:
   pass

func attack() -> void:
  print("KID ATTACK")
  GunParticle.emitting = true
  $SpawnProjectileComponent.spawn_projectile()
  await get_tree().create_timer(0.2).timeout  # Stop particles after 0.1 seconds
  GunParticle.emitting = false
