extends CharacterBody2D
# Variables
@export var bullet_scene: PackedScene
@export var vel := Vector2(200, -45) #velocidad
@export var vida := 3 # Vida del enemigo
@onready var bullet_spawn_marker1: Marker2D = $BulletMarker
@onready var bullet_spawn_marker2: Marker2D = $BulletMarker2
@onready var bullet_spawn_marker3: Marker2D = $BulletMarker3
@onready var bullet_spawn_marker4: Marker2D = $BulletMarker4
@onready var bullet_spawn_marker5: Marker2D = $BulletMarker5
@onready var timer: Timer = $Timer
@onready var rotador: Node2D = $Rotador
@onready var hitbox: HurtboxComponent = $HurtboxComponent
@onready var timerbala: Timer = $timerbala


var rapidez_giro: int = 100
var spawn_points: int = 6
var radio: int = 100

func _ready() -> void:
	var paso = 2*PI/spawn_points
	for i in range(spawn_points):
		var spawn_point = Node2D.new()
		var pos = Vector2(radio, 0).rotated(paso*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotador.add_child(spawn_point)
		
	timer.start()
	
	
func _process(delta: float) -> void:
	#var nueva_rot = rotador.rotation_degrees + rapidez_giro*delta
	rotador.rotate(rapidez_giro*delta)
	#movimiento del enemigo
	position += vel * delta
	
	#tamaño de la pantalla
	var screen_size = get_viewport_rect().size
	
	#rebote horizontal
	if position.x <= 0:
		position.x = 0
		vel.x *= -1
		
	elif position.x >= screen_size.x:
		position.x = screen_size.x
		vel.x *= -1
	
func _on_timer_timeout() -> void:
	for s in rotador.get_children():
		var bullet_inst = bullet_scene.instantiate()
		bullet_inst.add_to_group("balas")
		get_tree().root.add_child(bullet_inst)
		bullet_inst.position = s.global_position
		bullet_inst.rotation = s.global_rotation
		timerbala.start()
		await timerbala.timeout
	
func take_damage(value: int) -> void:
	Debug.log("%s received %d damage" % [name, value])
	vida -= value
	if vida <= 0:
		Debug.log("%s murisio" % name)
		queue_free()
