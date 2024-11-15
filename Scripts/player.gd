extends CharacterBody2D


@export var Health: float:
	set(new_value):
		if new_value <= 0:
			Health = 0
			print("Game Over")
			$".".queue_free()
		else:
			Health = new_value

@export var Role: String
@onready var attackhitbox = $HitboxComponent/FlippableShape
@onready var sprites = $AnimatedSprite2D
var AttackMoment = false


const SPEED = 300.0
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	
	var bodies = $HitboxComponent.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("Enemies") and AttackMoment:
			body.Health -= 10
			body.attacked = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if direction == -1:
			$AnimatedSprite2D.flipped = true
		else:
			$AnimatedSprite2D.flipped = false
		velocity.x = direction * SPEED * 1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event.is_action_pressed("Basic_Attack"):
		AttackMoment = true
		sprites.play("attack")
		attackhitbox.debug_color = Color("RED")
		$Timer.start(.01)



func _on_timer_timeout() -> void:
	attackhitbox.debug_color = Color("BLUE")
	AttackMoment = false
	
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished() -> void:
	sprites.play("default")
	pass # Replace with function body.
