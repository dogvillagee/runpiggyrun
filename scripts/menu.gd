extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_button_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
