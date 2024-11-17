extends Node

@export var target: CharacterBody2D
@export var dodge_timer: Timer

@export var base_speed := 350
@export var run_speed := 500
@export var defend_speed := 2.0 * 60
@export var jump_velocity := -600
@export var roll_speed := 600
@export var animated_sprite: AnimatedSprite2D
@onready var walk = $Walk

var sprint_toggle := false
var face_direction: int = 1


func _physics_process(_delta: float) -> void:
  target.move_and_slide()

func jump() -> void:
  if jump_velocity != 0:
    target.velocity.y = jump_velocity

func move_left() -> void:
    if dodge_timer.time_left == 0:
        if !walk.playing:  # Start playing the sound only if it isn't already playing
            walk.play()
        if sprint_toggle:
            target.velocity.x = -run_speed
        else:
            animated_sprite.play("walk")
            target.velocity.x = -base_speed
        face_direction = -1
        animated_sprite.flip_h = true

func move_right() -> void:
    if dodge_timer.time_left == 0:
        if !walk.playing:  # Start playing the sound only if it isn't already playing
            walk.play()
        if sprint_toggle:
            target.velocity.x = run_speed
        else:
            animated_sprite.play("walk")
            target.velocity.x = base_speed
        face_direction = 1
        animated_sprite.flip_h = false

func reset_velocity() -> void:
  if dodge_timer.time_left == 0:
    if walk.playing:  # Stop the sound when movement stops
        walk.stop()
    target.velocity.x = 0
    animated_sprite.play("idle")

func roll() -> void:
  if dodge_timer.time_left == 0 and roll_speed != 0:
    target.velocity.x = roll_speed * 2 * face_direction
    dodge_timer.start()
    
func sprint() -> void:
  sprint_toggle = true

func unsprint() -> void:
  sprint_toggle = false
