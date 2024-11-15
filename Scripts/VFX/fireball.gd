extends Node2D


@export var Direction:Vector2
@export var creator:CharacterBody2D
var originalPosition
var explosion = preload("res://Boom_Effect1.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	originalPosition = $".".position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$".".position += Direction*180*delta
	if originalPosition.distance_to($".".position) >= 80:
		kaboom()
	pass
func kaboom() -> void:
	var kaboom = explosion.instantiate()
	get_parent().add_child(kaboom)
	kaboom.position = $".".position
	$".".queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name != creator.name):
		kaboom()
	pass # Replace with function body.
