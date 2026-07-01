extends CharacterBody2D
# Variables
@export var bullet_scene: PackedScene
@export var vel := Vector2(200, -45) #velocidad
@export var vida := 50 # Vida del enemigo
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
var spawn_points: int = 6
var radio: int = 90
var muerto: bool = false

signal murio_jefe

func _ready() -> void:
	timer.start()
	
func _process(delta: float) -> void:
	barravida.value=vida
	#var nueva_rot = rotador.rotation_degrees + rapidez_giro*delta
	
func take_damage(value: int) -> void:
	#Debug.log("%s received %d damage" % [name, value])
	vida -= value
	#Debug.log("%s vida enemigo:" % [vida])
	if vida <= 0:
		muerto = true
		#Debug.log("%s murisio" % name)
		murio_jefe.emit()
		queue_free()
