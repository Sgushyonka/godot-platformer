extends CharacterBody2D

@export var gravity = 18
@export var jump_velocity = 11
@export var speed = 120
@export var crouch_speed = 80
@export var sprint_speed = 180
@export var min_y = -530
@export var max_y = -2
var start_y = -2

func _physics_process(delta):
	# Add the gravity		
	velocity.y += gravity * delta
	
	if Input.is_action_pressed("ForwardD") or Input.is_action_pressed("ForwardArrow"):
		if Input.is_action_pressed("Crouch"):
			velocity.x = crouch_speed
		elif Input.is_action_pressed("Sprint"):
			velocity.x = sprint_speed
		else:
			velocity.x = speed
			
	elif Input.is_action_pressed("BackwardA") or Input.is_action_pressed("BackwardArrow"):
		if Input.is_action_pressed("Crouch"):
			velocity.x = -crouch_speed
		elif Input.is_action_pressed("Sprint"):
			velocity.x = -sprint_speed
		else:
			velocity.x = -speed
	else:
		velocity.x = 0
	
		# Handle Jump, idk why is_on_floor() is needed but code breaks without, it looks useless but leave it.
		# It must also be not is_on_floor()

	if Input.is_action_pressed("JumpW") and not is_on_floor() or Input.is_action_pressed("JumpArrow") and not is_on_floor():
		velocity.y -= jump_velocity
	
	if position.y >= -120:
		velocity.y += gravity * delta

	if velocity.length() > 0:
		if Input.is_action_pressed("ForwardArrow") or Input.is_action_pressed("ForwardD") and not Input.is_action_pressed("Crouch") and Input.is_action_pressed("Sprint"):
			velocity = velocity.normalized() * sprint_speed
			$movement.animation = "run"
			$movement.play()
		elif Input.is_action_pressed("ForwardArrow") or Input.is_action_pressed("ForwardD") and Input.is_action_pressed("Crouch"):
			velocity = velocity.normalized() * crouch_speed
			$movement.animation = "crouch"
			$movement.play()
		elif Input.is_action_pressed("JumpW") or Input.is_action_pressed("JumpArrow"):
			$movement.animation = "jump"
			$movement.play()
		elif Input.is_action_pressed("ForwardD") or Input.is_action_pressed("BackwardA") or Input.is_action_pressed("ForwardArrow") or Input.is_action_pressed("BackwardArrow"):
			velocity = velocity.normalized() * speed
			$movement.animation = "walk-good"
			$movement.play()
		else:
			$movement.stop()
	else: 
		# Reset to default animation
		$movement.animation = "walk-good"
		$movement.play()
		$movement.stop()
	
	if velocity.x < 0: 
		$movement.flip_h = true
	if velocity.x > 0:
		$movement.flip_h = false
		
	position += velocity * delta
	
	position.y = max(min_y, min(max_y, position.y))

	
