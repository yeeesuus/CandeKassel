extends CharacterBody2D
# Variables
@export var speed = 500
@export var acceleration = 4000
@export var jump_speed = 400
@export var bullet_scene: PackedScene
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_timer: Timer = $JumpTimer
@onready var bullet_spawn_marker: Marker2D = $BulletSpawnMarker
@onready var Pivote: Node2D = $Pivote

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var retry_screen: Control = $"../CanvasLayer2/RetryScreen"
@onready var spawner: Node2D = $spawner

var is_taking_power_up: bool = false
var _was_on_floor: bool = false
var vida: int = 1
var is_dead: bool = false
signal murio

#variables para power ups
var spawn_points: int = 1
var power_up_doble: bool = false
var doble_listo: bool = false

func _ready() -> void:
	var spawn_point = Node2D.new()
	var pos = spawner.position
	spawn_point.position = pos
	spawner.add_child(spawn_point)
	
func _process(delta: float) -> void:
	if power_up_doble and not doble_listo:
		for s in spawner.get_children():
			s.queue_free()
		var spawn_point1 = Node2D.new()
		var spawn_point2 = Node2D.new()
		var pos = spawner.position
		spawn_point1.position = pos
		spawn_point2.position = pos
		spawn_point1.position.x -= 10
		spawn_point2.position.x += 10
		spawner.add_child(spawn_point1)
		spawner.add_child(spawn_point2)
		doble_listo = true
	
func _physics_process(delta: float) -> void:
	if is_taking_power_up:
		return
	
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
	if not is_on_floor() and _was_on_floor:
		coyote_timer.start()
		
	if (is_on_floor() or not coyote_timer.is_stopped()) and Input.is_action_just_pressed("jump") and jump_timer.is_stopped():
		jump_timer.start()
		coyote_timer.stop()

	var move_input = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_released("jump"):
		jump_timer.stop()
		
	if not jump_timer.is_stopped():
		velocity.y = -jump_speed
		
	velocity.x = move_toward(velocity.x, move_input * speed, acceleration * delta)
	_was_on_floor = is_on_floor()
	move_and_slide()
	
	if Input.is_action_pressed("shift"):
		speed = 250
		if Input.is_action_pressed("move_left") or velocity.x < 0:
			playback.travel("run_left_focus")
		elif Input.is_action_pressed("move_right") or velocity.x > 0:
			playback.travel("run_right_focus")
		else:
			playback.travel("idle_focus")
	else:
		speed = 500
		if Input.is_action_pressed("move_left") or velocity.x < 0:
			playback.travel("run_left")
		elif Input.is_action_pressed("move_right") or velocity.x > 0:
			playback.travel("run_right")
		else:
			playback.travel("idle")
		
	if Input.is_action_just_released("shift"):
		speed=500
	
	if Input.is_action_just_pressed("fire"):
		fire()
	
	if is_dead:
		murio.emit()
		
	#if move_input:
	#	Pivote.scale.x = sign(move_input)
	
func take_damage(value: int) -> void:
	vida -= value
	#Debug.log("%s received %d damage" % [name, value])
	if vida <= 0:
		is_dead = true
		#Debug.log("CHANCHIWAWI MURIÓ")
		queue_free()

# Función de disparo
func fire() -> void:
	if not bullet_scene:
		Debug.log("no hay bala")
		
	for s in spawner.get_children():
		var bullet_inst = bullet_scene.instantiate()
		bullet_inst.add_to_group("balas")
		get_parent().add_child(bullet_inst)
		bullet_inst.global_position = s.global_position

# Función para obtener el power up
func collect_power_up() -> void:
	is_taking_power_up = true
	#Debug.log("COLLECT_POWER_UP")
	#COSITAS DE LAS ANIMACIONES
	#playback.travel("take_coin") #COMIENZA LA ANIMACIÓN
	#take_coin_stream_player.play() #PARA EL SONIDO
	#CoinLabelManager.add_coin() #ESTE ES PARA PONER UN CONTADOR DE MONEDAS
	#await get_tree().create_timer(0.2).timeout #TIMER PARA Q NO SE BUGGEE LA ANIMACIÓN
	is_taking_power_up = false
	
