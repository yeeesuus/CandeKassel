extends CharacterBody2D
# Variables
@export var bullet_scene: PackedScene
@export var vel := Vector2(200, -90) #velocidad
@export var vida := 20 # Vida del enemigo
@onready var bullet_spawn_marker1: Marker2D = $BulletMarker
@onready var bullet_spawn_marker2: Marker2D = $BulletMarker2
@onready var bullet_spawn_marker3: Marker2D = $BulletMarker3
@onready var bullet_spawn_marker4: Marker2D = $BulletMarker4
@onready var bullet_spawn_marker5: Marker2D = $BulletMarker5
@onready var timer: Timer = $Timer
@onready var rotador: Node2D = $Rotador
@onready var barravida: ProgressBar = $Vida
@onready var sonido_disparo: AudioStreamPlayer = $Tohou
@onready var muerte_enemigo: AudioStreamPlayer = $MuerteEnemigo

var muerto: bool =  false
var rapidez_giro: int = 0
var spawn_points: int = 1
var radio: int = 0

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
	barravida.value = vida
	#var nueva_rot = rotador.rotation_degrees + rapidez_giro*delta
	rotador.rotate(rapidez_giro*delta)
	#movimiento del enemigo
	
func _on_timer_timeout() -> void:
	for s in rotador.get_children():
		sonido_disparo.play()
		var bullet_inst = bullet_scene.instantiate()
		bullet_inst.add_to_group("balas")
		get_tree().current_scene.add_child(bullet_inst)
		bullet_inst.position = s.global_position
		bullet_inst.rotation = s.global_rotation
	
func take_damage(value: int) -> void:
	#Debug.log("%s received %d damage" % [name, value])
	vida -= value
	#Debug.log("%s vida enemigo:" % [vida])
	if vida <= 0:
		var contador2 = get_tree().current_scene
		contador2.muertos+=1
		await get_tree().create_timer(0.05).timeout
		muerte_enemigo.play()
		await get_tree().create_timer(0.60).timeout
		muerto = true
		#Debug.log("%s murisio" % name)
		queue_free()
