extends Area2D

class_name HitboxComponent

@export var flipabble_sprite: FlippableSprite

func _ready() -> void:
	if flipabble_sprite:
		for child in get_children():
			flipabble_sprite.sprite_flipped.connect(child._on_sprite_flipped)
