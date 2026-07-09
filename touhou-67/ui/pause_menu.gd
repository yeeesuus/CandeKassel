extends Control

@onready var reintentar: Button = %reintentar
@onready var resumir: Button = %resumir
@onready var menu: Button = %menu
@onready var salida: Button = %salida
var pausado = false

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	reintentar.pressed.connect(_on_reintentar_pressed)
	resumir.pressed.connect(_on_resumir_pressed)
	menu.pressed.connect(_on_menu_pressed)
	salida.pressed.connect(_on_salida_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		#AudioManager.reproducir_musica(AudioManager.EstadoMusica.NINGUNO)
		var game_over = get_tree().current_scene.find_child("RetryScreen")
		var final = get_tree().current_scene.find_child("FinalScreen")
		if game_over and game_over.visible:
			return
		elif final and final.visible:
			return
		else:
			pausado = not get_tree().paused
			get_tree().paused = not get_tree().paused
			visible = get_tree().paused

	if event.is_action_pressed("retry"):
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_reintentar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	
	LevelManager.main_menu()

func _on_resumir_pressed() -> void:
	get_tree().paused = false
	hide()
	#AudioManager.reproducir_musica(AudioManager.EstadoMusica.JUEGO)

func _on_salida_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
