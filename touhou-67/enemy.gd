extends CharacterBody2D
# Variables
@export var bullet_scene: PackedScene
@onready var bullet_spawn_marker1: Marker2D = $BulletMarker
@onready var bullet_spawn_marker2: Marker2D = $BulletMarker2
@onready var bullet_spawn_marker3: Marker2D = $BulletMarker3
@onready var bullet_spawn_marker4: Marker2D = $BulletMarker4
@onready var bullet_spawn_marker5: Marker2D = $BulletMarker5
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()
	
func _on_timer_timeout() -> void:
	# Acción disparar
	fire()
	
func take_damage(value: int) -> void:
	Debug.log("%s received %d damage" % [name, value])

# Función de disparo del enemigo
func fire() -> void:
	if not bullet_scene:
		Debug.log("no hay bala")
		return
	
	var markers = [bullet_spawn_marker1, bullet_spawn_marker2, bullet_spawn_marker3, bullet_spawn_marker4, bullet_spawn_marker5]
	
	for marker in markers:
		if marker:
			var bullet_inst = bullet_scene.instantiate()
			get_parent().add_child(bullet_inst)
			bullet_inst.global_position = marker.global_position
			bullet_inst.global_rotation = randf_range(0,360)
