extends MarginContainer

func _ready():
  pass	

func _on_return_to_main_menu_pressed() -> void:
  get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
  
