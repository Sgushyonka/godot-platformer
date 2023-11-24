extends Area2D

var speed = 100
var sprint_speed = 180
var screen_size

func start(pos):
	position = pos

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta): 
	
	var velocity = Vector2.ZERO 
	
	if Input.is_action_pressed("Forward"):
		if Input.is_action_pressed("Sprint"):
			velocity.x = sprint_speed
		else:
			velocity.x = speed

	if Input.is_action_pressed("Backward"):
		if Input.is_action_pressed("Sprint"):
			velocity.x = -sprint_speed
		else:
			velocity.x = -speed
		
	if Input.is_action_pressed("Crouch"):
		scale.y = 0.87
	else:
		scale.y = 1.0

	if velocity.length() > 0:
		if not Input.is_action_pressed("Crouch") and Input.is_action_pressed("Sprint"):
			velocity = velocity.normalized() * sprint_speed
		else:
			velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x < 0: 
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	position += velocity * delta 
