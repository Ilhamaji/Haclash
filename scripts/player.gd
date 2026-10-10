extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if ((Input.is_action_just_pressed("ui_accept") or Input.is_key_pressed(KEY_W)) and is_on_floor()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 0

	if (Input.is_key_pressed(KEY_A)):
		direction -= 1.0
	if (Input.is_key_pressed(KEY_D)):
		direction += 1.0
	
	if direction:
		if direction != 0: 
			velocity.x = direction * SPEED
			animated_sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
