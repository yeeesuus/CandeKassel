extends CharacterBody2D


@export var speed = 500
@export var acceleration = 5000
@export var jump_speed = -400

var ctad_saltos = 1
@onready var jump_timer: Timer = $JumpTimer

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var move_input = Input.get_axis("izquierda", "derecha")
	velocity.x = move_toward(velocity.x, move_input * speed, acceleration * delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("salto") and ctad_saltos>0 and jump_timer.is_stopped():
		ctad_saltos-=1
		jump_timer.start()
		
		
	if Input.is_action_just_released("salto"):
		jump_timer.stop()
		
	if not jump_timer.is_stopped():
		velocity.y += jump_speed

	if is_on_floor():
		ctad_saltos = 1

	move_and_slide()
