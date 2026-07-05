extends Node2D

@onready var character_p: CharacterBody2D = $CharacterP
@onready var camera_2d: Camera2D = $Camera2D
@onready var retry_screen: Control = $CanvasLayer2/RetryScreen
@onready var enemy: CharacterBody2D = $Enemy
var cam_velocity: float = 50
@onready var victory_screen: Control = $CanvasLayer3/VictoryScreen
@onready var pause_screen: Control = $CanvasLayer3/PauseMenu
@export var enemy_scene: PackedScene


# Función para reiniciar nivel (Tecla "R")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		for bala in get_tree().get_nodes_in_group("balas"):
			bala.queue_free()
		get_tree().reload_current_scene()

func limpiar_balas() -> void:
	for bala in get_tree().get_nodes_in_group("balas"):
		bala.queue_free()

func _ready() -> void:
	#para spawn de enemigos
	#var timer: Timer = Timer.new()
	#add_child(timer)
	#timer.wait_time = 2.0
	#timer.one_shot = true
	#timer.timeout.connect(_on_timer_off)
	#timer.start()
	retry_screen.reseteo.connect(limpiar_balas)
	victory_screen.hide()
	
	
func _on_timer_off() -> void:
	if enemy_scene:
		var nuevo_enemigo = enemy_scene.instantiate()
		nuevo_enemigo.name = "NPC"
		# nuevo_jefe.murio_jefe.connect(_on_murio_jefe)
		nuevo_enemigo.global_position = Vector2(0, 0)
		add_child(nuevo_enemigo)
		#Debug.log("spawneó jefe")
		
#func _on_murio_jefe() -> void:
#	#Debug.log("ganate")
#	victory_screen.show()
#	get_tree().paused = true
	
func _physics_process(delta: float) -> void:
	pass
	
func _process(delta: float) -> void:
	pass
