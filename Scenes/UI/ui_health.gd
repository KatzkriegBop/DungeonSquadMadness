extends Control

@export var player: CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player != null :
		$LifeValue.text = str(player.Health)
	else:
		$LifeValue.text = "0"
	pass
