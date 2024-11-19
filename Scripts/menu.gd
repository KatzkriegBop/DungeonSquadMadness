class_name MainMenu
extends Control
@onready var margin_container: MarginContainer = $MarginContainer
@onready var options: OptionsMenu = $Options

func _ready() -> void:
	options.exit_options_menu.connect(_on_exit_options_menu)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/mapa 1.tscn")

func _on_options_pressed() -> void:
	margin_container.visible= false
	options.set_process(true)
	options.visible = true

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()
