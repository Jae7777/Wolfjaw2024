extends MarginContainer

@onready var start_button = $HBoxContainer/VBoxContainer/MenuOptions/Start
@onready var options_button = $HBoxContainer/VBoxContainer/MenuOptions/Options
@onready var quit_button = $HBoxContainer/VBoxContainer/MenuOptions/Quit

@onready var main_theme = $MainTheme

func _ready():
  main_theme.play()

func _on_start_pressed() -> void:
  main_theme.stop()
  _set_buttons_visibility(false)
  TransitionScreen.transition()
  await TransitionScreen.on_transition_finished
  get_tree().change_scene_to_file("res://textbox/walking.tscn")

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
