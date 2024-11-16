extends MarginContainer

@onready var start_button = $HBoxContainer/VBoxContainer/MenuOptions/Start
@onready var options_button = $HBoxContainer/VBoxContainer/MenuOptions/Options
@onready var quit_button = $HBoxContainer/VBoxContainer/MenuOptions/Quit

func _ready():
    pass

func _on_start_pressed() -> void:
    _set_buttons_visibility(false)
    TransitionScreen.transition()
    await TransitionScreen.on_transition_finished
    get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_options_pressed() -> void:
    _set_buttons_visibility(false)
    get_tree().change_scene_to_file("res://scenes/menus/options.tscn")

func _on_quit_pressed() -> void:
    _set_buttons_visibility(false)
    get_tree().quit()

func _set_buttons_visibility(v: bool):
    start_button.visible = v
    options_button.visible = v
    quit_button.visible = v
