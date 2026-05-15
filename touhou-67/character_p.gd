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

var is_taking_power_up: bool = false
var _was_on_floor: bool = false
var vida: int = 1

func _ready() -> void:
	pass
	
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
	
	if Input.is_action_just_pressed("fire"):
		fire()
		
	if move_input:
		Pivote.scale.x = sign(move_input)
	
func  take_damage(value: int) -> void:
	Debug.log("%s received %d damage" % [name, value])

# Función de disparo
func fire() -> void:
	if not bullet_scene:
		Debug.log("no hay bala")
	var bullet_inst = bullet_scene.instantiate()
	get_parent().add_child(bullet_inst)
	bullet_inst.global_position = bullet_spawn_marker.global_position

# Función para obtener el power up
func collect_power_up() -> void:
	is_taking_power_up = true
	Debug.log("COLLECT_POWER_UP")
	#COSITAS DE LAS ANIMACIONES
	#playback.travel("take_coin") #COMIENZA LA ANIMACIÓN
	#take_coin_stream_player.play() #PARA EL SONIDO
	#CoinLabelManager.add_coin() #ESTE ES PARA PONER UN CONTADOR DE MONEDAS
	await get_tree().create_timer(0.2).timeout #TIMER PARA Q NO SE BUGGEE LA ANIMACIÓN
	is_taking_power_up = false
	
