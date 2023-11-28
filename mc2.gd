extends CharacterBody2D

@export var gravity = 100
@export var jump_velocity = 400
@export var speed = 120
@export var crouch_speed = 80
@export var sprint_speed = 180

var start_y

func _ready():
	start_y = position.y 

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.x = 0
		velocity.y = 0 
		while position.y != start_y:
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
	
		# Handle Jump.
	if Input.is_action_just_pressed("JumpW") and is_on_floor() or Input.is_action_just_pressed("JumpArrow") and is_on_floor():
		velocity.y = -jump_velocity
		velocity.x = speed


	if velocity.length() > 0:
		if not Input.is_action_pressed("Crouch") and Input.is_action_pressed("Sprint"):
			velocity = velocity.normalized() * sprint_speed
			$movement.animation = "run"
			$movement.play()
		elif Input.is_action_pressed("Crouch"):
			velocity = velocity.normalized() * crouch_speed
			$movement.animation = "crouch"
			$movement.play()
		else:
			velocity = velocity.normalized() * speed
			$movement.animation = "walk-good"
			$movement.play()
	else: 
		# Reset to default animation
		$movement.animation = "walk-good"
		$movement.play()
		$movement.stop()
	
	if velocity.x < 0: 
		$movement.flip_h = true
	if velocity.x > 0:
		$movement.flip_h = false
		
		move_and_slide()
		
	position += velocity * delta

	
