extends CharacterBody2D

var direction: Vector2
var speed: float = 200.0

func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		direction.y = -1
	if Input.is_action_pressed("down"):
		direction.y = 1
	if Input.is_action_pressed("left"):
		direction.x = -1
	if Input.is_action_pressed("right"):
		direction.x = 1
	
	velocity = direction.normalized() * speed
	
	if direction != Vector2.ZERO:
		move_and_slide()
