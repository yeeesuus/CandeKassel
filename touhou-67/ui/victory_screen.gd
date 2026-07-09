extends Control

#@onready var start_again: Button = %StartAgain
#@onready var credits: Button = %Credits
#@onready var main_menu: Button = %"Main_Menu"
var aparecer = false
@onready var menu: Button = %menu
@onready var salida: Button = %salida
@onready var next_level: Button = %next_level

func _ready() -> void:	
	AudioManager.reproducir_musica(AudioManager.EstadoMusica.JUEGO)
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	CoinLabelManager.player_won.connect(_on_player_won)
	salida.pressed.connect(_on_salida_pressed)
	menu.pressed.connect(_on_menu_pressed)
	next_level.pressed.connect(_on_next_level_pressed)
	#start_again.pressed.connect(_on_start_again_pressed)
	#credits.pressed.connect(_on_credits_pressed)
	#main_menu.pressed.connect(_on_main_menu_pressed)

func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("menu"):
		get_tree().paused = false
		LevelManager.main_menu()
	if event.is_action_pressed("retry"):
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_player_won() -> void:
	await get_tree().create_timer(0.25).timeout
	show()
	get_tree().paused = true
	
#func _on_timer_countdown_finished() -> void:
#	get_tree().paused = false
#	LevelManager.next_level()

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("menu"):
#		get_tree().paused = false
#		LevelManager.main_menu()
	
func _on_next_level_pressed() -> void:
	get_tree().paused = false
	LevelManager.next_level()
	
func _on_salida_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	LevelManager.main_menu()
	
