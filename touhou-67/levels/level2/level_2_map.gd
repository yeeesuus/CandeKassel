extends Node2D

@onready var character_p: CharacterBody2D = $CharacterP
@onready var camera_2d: Camera2D = $Camera2D
@onready var retry_screen: Control = $CanvasLayer2/RetryScreen
@onready var enemy: CharacterBody2D = $Enemy
var cam_velocity: float = 100
@onready var victory_screen: Control = $CanvasLayer3/VictoryScreen
@onready var pause_screen: Control = $CanvasLayer3/PauseMenu
@export var enemy_scene: PackedScene
@onready var label_time: Label = $Label
@onready var timer_level: Timer = $timer_level
@onready var label_vida: Label = $Label_Vida
@onready var rotador: Node2D = $rotador
var muertos = 0

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
	character_p.vida = 2
	AudioManager.reproducir_musica(AudioManager.EstadoMusica.JUEGO)
	timer_level.wait_time = 50.0
	timer_level.one_shot = true
	timer_level.start()
	
	var paso = 2*PI/6
	for i in range(6):
		var spawn_point = Node2D.new()
		var pos = Vector2(100, 0).rotated(paso*i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotador.add_child(spawn_point)
	
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
		for s in rotador.get_children():
			if s.name.begins_with("@Node2D"):
				var nuevo_enemigo = enemy_scene.instantiate()
				nuevo_enemigo.murio.connect(_on_murio_enemigo)
				s.add_child(nuevo_enemigo)
		
func _on_murio_enemigo() -> void:
	muertos+=1
	if muertos == 6:
		victory_screen.show()
		get_tree().paused = true

#func _on_murio_jefe() -> void:
#	#Debug.log("ganate")
#	victory_screen.show()
#	get_tree().paused = true
	
func _physics_process(delta: float) -> void:
	pass
	
func _process(delta: float) -> void:
	rotador.rotate(delta)
	label_vida.set_text("Vida: " + str(character_p.vida))
	label_time.set_text("Time Left: " + str(int(timer_level.get_time_left())))
	if timer_level.get_time_left() <= 0:
		character_p.murio.emit()
		
