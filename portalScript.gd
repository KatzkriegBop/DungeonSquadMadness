extends Area2D

@export var nivel_4: String

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scenes/Levels/"+nivel_4+".tscn")
	pass # Replace with function body.
