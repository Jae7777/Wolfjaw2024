extends Node2D

@onready var timer = $Daytime

var rested= false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    AudioManager3.play()
    if(!rested):
        timer.start(30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass



func _on_daytime_timeout() -> void:
    TransitionScreen.transition()
    await TransitionScreen.on_transition_finished
    AudioManager3.stop()
    get_tree().change_scene_to_file("res://textbox/campfire.tscn")
