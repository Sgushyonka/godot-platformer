extends Area2D

var speed = 120
var crouch_speed = 80
var sprint_speed = 180

func _process(delta): 
	
	var velocity = Vector2.ZERO 
	
	if Input.is_action_pressed("ForwardD") or Input.is_action_pressed("Forward->"):
		if Input.is_action_pressed("Crouch"):
			velocity.x = crouch_speed
		elif Input.is_action_pressed("Sprint"):
			velocity.x = sprint_speed
		else:
			velocity.x = speed

	if Input.is_action_pressed("BackwardA") or Input.is_action_pressed("Backward<-"):
		if Input.is_action_pressed("Crouch"):
			velocity.x = -crouch_speed
		elif Input.is_action_pressed("Sprint"):
			velocity.x = -sprint_speed
		else:
			velocity.x = -speed


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

	position += velocity * delta 
