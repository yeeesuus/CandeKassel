extends CharacterBody2D
# Variables
@export var bullet_scene: PackedScene
@export var vel := Vector2(200, -45) #velocidad
@export var vida := 100 # Vida del enemigo
@onready var bullet_spawn_marker1: Marker2D = $BulletMarker
@onready var bullet_spawn_marker2: Marker2D = $BulletMarker2
@onready var bullet_spawn_marker3: Marker2D = $BulletMarker3
@onready var bullet_spawn_marker4: Marker2D = $BulletMarker4
@onready var bullet_spawn_marker5: Marker2D = $BulletMarker5
@onready var timer: Timer = $Timer
@onready var rotador: Node2D = $Rotador
@onready var hitbox: HurtboxComponent = $HurtboxComponent
@onready var timerbala: Timer = $timerbala
@onready var barravida: ProgressBar = $Vida
@onready var sprite: Sprite2D = $Sprite2D

var fase_actual: int = 1

var rapidez_giro: int = 200
var spawn_points: int = 7
var radio: int = 90
var muerto: bool = false

signal murio_jefe

func _ready() -> void:
	var paso = 2*PI/spawn_points
	for i in range(spawn_points):
		var spawn_point = Node2D.new()
		var pos = Vector2(radio, 0).rotated(paso*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotador.add_child(spawn_point)
		
	timer.start()
	cambiar_fase(1)
	
	
func _process(delta: float) -> void:
	barravida.value=vida
	#var nueva_rot = rotador.rotation_degrees + rapidez_giro*delta
	rotador.rotate(rapidez_giro*delta)
	#movimiento del enemigo
	position += vel * delta
	
	#tamaño de la pantalla
	var screen_size = get_viewport_rect().size
	var mitad_sprite = sprite.texture.get_width()*sprite.scale.x/2
	
	#rebote horizontal
	if position.x <= mitad_sprite:
		position.x = mitad_sprite
		vel.x *= -1
		
	elif position.x > screen_size.x - mitad_sprite:
		position.x = screen_size.x - mitad_sprite
		vel.x *= -1
	
func _on_timer_timeout() -> void:
	for s in rotador.get_children():
		var bullet_inst = bullet_scene.instantiate()
		bullet_inst.add_to_group("balas")
		get_tree().current_scene.add_child(bullet_inst)
		bullet_inst.position = s.global_position
		bullet_inst.rotation = s.global_rotation
		timerbala.start()
		await timerbala.timeout
	
func take_damage(value: int) -> void:
	#Debug.log("%s received %d damage" % [name, value])
	vida -= value
	#Debug.log("%s vida enemigo:" % [vida])
	if vida <= 0:
		muerto = true
		#Debug.log("%s murisio" % name)
		murio_jefe.emit()
		queue_free()
	elif vida <= 30 and fase_actual < 3:
		cambiar_fase(3)
	elif vida <= 90 and fase_actual < 2:
		cambiar_fase(2)

func cambiar_fase(nueva_fase: int) -> void:
	fase_actual = nueva_fase
	#Debug.log("fase actual: %d!" % fase_actual)
	
	if fase_actual == 1:
		rapidez_giro = 100
		timer.wait_time = 1.8
	elif fase_actual == 2:
		rapidez_giro = 250
		timer.wait_time = 1.2
		vel.x *= 1.5
	elif fase_actual == 3:
		rapidez_giro = -400
		timer.wait_time = 0.6
