extends CharacterBody2D


@export var speed = 500
@export var acceleration = 5000
@export var jump_speed = -400
@export var bullet_scene: PackedScene

var is_dead: bool = false

var ctad_saltos = 1
var _was_on_floor: bool = false
var vida: int = 1
var second_jump: bool = true
@onready var jump_timer: Timer = $JumpTimer
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var pivot: Node2D = $pivot
@onready var bullet_spawn_marker: Marker2D = $pivot/spawn
@onready var shoot_sound: AudioStreamPlayer = $ShootSound
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var jugador: CharacterBody2D = $jugadol

func _ready() -> void:
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	var move_input = Input.get_axis("izquierda", "derecha")
	velocity.x = move_toward(velocity.x, move_input * speed, acceleration * delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not is_on_floor() and _was_on_floor:
		coyote_timer.start()
		
	# Handle jump.
	if Input.is_action_just_pressed("salto") and (is_on_floor() or not coyote_timer.is_stopped()) and jump_timer.is_stopped():
		playback.start("jump")
		jump_timer.start()
		jump_sound.play()
		coyote_timer.stop()
		second_jump = true
	elif second_jump and Input.is_action_just_pressed("salto") and jump_timer.is_stopped():
		playback.start("jump")
		jump_timer.start()
		jump_sound.play()
		second_jump = false
		
	if Input.is_action_just_released("salto"):
		jump_timer.stop()
		
	if not jump_timer.is_stopped():
		velocity.y = jump_speed

	if is_on_floor():
		second_jump = true 
		if abs(velocity.x) > 10 or move_input:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
	
	if move_input:
		pivot.scale.x = sign(move_input)
	
	if Input.is_action_just_pressed("disparar"):
		shoot_sound.play()
		playback.travel("shooting")
		fire()
	
	_was_on_floor = is_on_floor()
	move_and_slide()

func take_damage(value: int) -> void:
	vida -= value
	if vida <= 0:
		is_dead = true
		playback.travel("death")
		death_sound.play()
		await get_tree().create_timer(0.8).timeout
		queue_free()
	
func fire() -> void:
	if not bullet_scene:
		Debug.log("no hay bala")
	var bullet_inst = bullet_scene.instantiate()
	get_parent().add_child(bullet_inst)
	bullet_inst.global_position = global_position
	
	if pivot.scale.x < 0:
		bullet_inst.rotation = PI
	else:
		bullet_inst.rotation = 0
	
