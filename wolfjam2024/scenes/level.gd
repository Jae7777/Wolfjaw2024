extends Node2D

@onready var timer = $Daytime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    AudioManager.stop()
    AudioManager3.play()
    timer.start(30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass



func _on_daytime_timeout() -> void:
    get_tree().change_scene_to_file("res://Textbox/campfire.tscn")
