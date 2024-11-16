extends Node2D

@export var fire_timer: Timer

@onready var GunParticle = $Sprite2D/ProjectileSpawnPoint/GunParticle

func _ready():
  GunParticle.emitting = false
  
func _physics_process(_delta: float) -> void:
   pass

func attack() -> void:
  if fire_timer.time_left == 0:
    fire_timer.start()
    GunParticle.emitting = true
    $SpawnProjectileComponent.spawn_projectile()
    await get_tree().create_timer(0.2).timeout  # Stop particles after 0.1 seconds
    GunParticle.emitting = false
