extends MarginContainer

func _ready():
	pass	

func _on_return_to_main_menu_pressed() -> void:
	get_tree().change_scene("res://scenes/MainMenu.tscn")
