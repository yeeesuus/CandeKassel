extends Node2D

@onready var character_p: CharacterBody2D = $CharacterP
@onready var camera_2d: Camera2D = $Camera2D
@onready var retry_screen: Control = $CanvasLayer2/RetryScreen
@onready var enemy: CharacterBody2D = $Enemy
var cam_velocity: float = 100
@onready var victory_screen: Control = $CanvasLayer3/VictoryScreen
@onready var pause_screen: Control = $CanvasLayer3/PauseMenu
@export var enemy_scene: PackedScene
@onready var muerte_enemigo: AudioStreamPlayer = $MuerteEnemigo

@onready var label_time: Label = $Label
@onready var timer_level: Timer = $timer_level
@onready var label_vida: Label = $Label_Vida

# Función para reiniciar nivel (Tecla "R")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		for bala in get_tree().get_nodes_in_group("balas"):
			bala.queue_free()
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("sgte_nivel"):
		LevelManager.next_level()
		
	if event.is_action_pressed("nivel_ant"):
		LevelManager.last_level()
		
func limpiar_balas() -> void:
	for bala in get_tree().get_nodes_in_group("balas"):
		bala.queue_free()

func _ready() -> void:
	AudioManager.reproducir_musica(AudioManager.EstadoMusica.JUEGO)
	timer_level.wait_time = 63.0
	timer_level.one_shot = true
	timer_level.start()
	
	#para spawn de enemigos
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_off)
	timer.start()
	retry_screen.reseteo.connect(limpiar_balas)
	victory_screen.hide()
	
	
func _on_timer_off() -> void:
	if enemy_scene:
		var nuevo_jefe = enemy_scene.instantiate()
		nuevo_jefe.name = "Boss"
		nuevo_jefe.murio_jefe.connect(_on_murio_jefe)
		nuevo_jefe.global_position = Vector2(726.0, 32.0)
		add_child(nuevo_jefe)
		#Debug.log("spawneó jefe")
		
func _on_murio_jefe() -> void:
	#Debug.log("ganate")
	#LevelManager.next_level(), para cuando esté listo
	await get_tree().create_timer(0.05).timeout
	muerte_enemigo.play()
	await get_tree().create_timer(0.60).timeout
	victory_screen.show()
	get_tree().paused = true
	
func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	label_vida.set_text("Vida: " + str(character_p.vida))
	label_time.set_text("Time Left: " + str(int(timer_level.get_time_left())))
	if timer_level.get_time_left() <= 0:
		character_p.murio.emit()
