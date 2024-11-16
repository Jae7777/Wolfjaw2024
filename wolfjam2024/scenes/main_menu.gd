extends MarginContainer

func _ready():
	pass
	

func _on_start_pressed() -> void:
	get_tree().change_scene("res://scenes/level.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene("res://scenes/menus/options.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
