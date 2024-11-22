extends CharacterBody2D

@export var Target: CharacterBody2D

@onready var attack_timer = $AttackTimer
@onready var reaction_timer = $ReactionTime  # Added for clarity
@onready var health_bar = $HealthBar2/BG/HP
@onready var health_text = $HealthBar2/HP_Label

@export var Health: float:
	set(new_value):
		if new_value <= 0:
			Health = 0
			print("ENEMY OOF'D")
			$".".queue_free()
		else:
			Health = new_value
			update_hpBar()

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const ATTACK_CD = 0.2
const ATTACK_DMG = 10
const REACTION_TIME = 0.2
const RANGE = 300

@export var attacked: bool:
	set(boolean):
		if boolean:
			$AttackedTimer.start(0.3)
		attacked = boolean
var onRange = false
var canAttack = true
var canReact = false  # Start as false so reaction time can start upon entering hitbox
var maxHealth: float

func update_hpBar():
	if maxHealth:
		health_bar.scale.x = (Health/maxHealth)
		health_text.text = str(Health)

func _ready() -> void:
	reaction_timer.start(0.3)
	maxHealth = Health
	update_hpBar()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Target == null:
		return
	var direction = $".".position.direction_to(Target.position)
	if direction.x >= 0:
		$AnimatedSprite2D.flipped = false
	else:
		$AnimatedSprite2D.flipped = true
	
	var distance = $".".position.distance_to(Target.position)
	# Check if target is within reach
	if distance >= 110:
		if !attacked:
			if distance >= RANGE:
				velocity.x = move_toward(velocity.x, 0, SPEED)
			else:
				velocity.x = direction.x * SPEED
		else:
			velocity.x = -1.25*direction.x * SPEED
	else:
		if attacked:
			velocity.x = -1.25*direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func Attack():
	var bodies_collided = $HitboxComponent.get_overlapping_bodies()
	for body in bodies_collided:
		if body == Target:
			if canAttack:
				Target.Health -= ATTACK_DMG
				$AudioStreamPlayer2D.play()
				

func _on_attack_timer_timeout() -> void:
	canAttack = true

func _on_reaction_time_timeout() -> void:
	if Target != null:
		if $HitboxComponent.overlaps_body(Target):
			if $AnimatedSprite2D.flipped:
					$AnimationPlayer.play("Attack_Left")
			else:
					$AnimationPlayer.play("Attack_Right")

func _on_attacked_timer_timeout() -> void:
	attacked = false
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play("RESET")
	pass # Replace with function body.
