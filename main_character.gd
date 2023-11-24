extends Area2D

@export var speed = 100
var screen_size

const GRAVITY = 500
const JUMP_STRENGTH = -200
var on_ground = true
var original_y 

func start(pos):
	position = pos

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	original_y = position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO 
	velocity.y += GRAVITY * delta 
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	var can_jump = true
	
	if Input.is_action_pressed("Forward"):
		velocity.x += 1
	if Input.is_action_pressed("Backward"):
		velocity.x -= 1
	if Input.is_action_pressed("Jump") and can_jump == true:
		can_jump = false
		velocity.y = JUMP_STRENGTH
		can_jump = true
	while Input.is_action_pressed("Crouch"):
		scale.y = 0.4
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop
		
	if velocity.x < 0: 
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
