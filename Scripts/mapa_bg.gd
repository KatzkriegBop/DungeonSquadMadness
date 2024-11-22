extends Node2D

@export var Musica:AudioStream
@export var volumen: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bg_music = AudioStreamPlayer.new()
	add_child(bg_music)
	bg_music.volume_db = volumen
	bg_music.stream = Musica
	bg_music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
