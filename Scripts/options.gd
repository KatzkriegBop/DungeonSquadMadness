class_name OptionsMenu
extends Control

@onready var back: Button = $TextureRect/VBoxContainer/Back

signal exit_options_menu

func _on_back_button_down() -> void:
	pass
	
func _ready():
	back.button_down.connect(_on_exit_pressed)
	set_process(false)

func _on_exit_pressed():
	exit_options_menu.emit()
	set_process(false)
