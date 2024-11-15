extends Node2D


@export var Direction:Vector2
@export var creator:CharacterBody2D
var explosion = preload("res://Boom_Effect2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	Direction.y += delta*3
	$".".position += Direction*300*delta
	


func kaboom() -> void:
	var kaboom = explosion.instantiate()
	get_parent().add_child(kaboom)
	kaboom.position = $".".position
	kaboom.find_child("Boom_SFX").pitch_scale = randf_range(1.5,1.9)
	$".".queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name != creator.name):
		kaboom()
	pass # Replace with function body.
