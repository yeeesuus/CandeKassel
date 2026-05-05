extends CharacterBody2D

@export var speed = 500
@export var acceleration = 4000
@export var jump_speed = 550
@export var bullet_scene: PackedScene

@onready var bullet_spawn_marker: Marker2D = $BulletSpawnMarker

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * speed, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		fire()
	
func  take_damage(value: int) -> void:
	Debug.log("%s received %d damage" % [name, value])

func fire() -> void:
	if not bullet_scene:
		Debug.log("no hay bala")
	var bullet_inst = bullet_scene.instantiate()
	get_parent().add_child(bullet_inst)
	bullet_inst.global_position = bullet_spawn_marker.global_position
