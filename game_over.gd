extends CanvasLayer

func _on_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/mapa 1.tscn")
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
