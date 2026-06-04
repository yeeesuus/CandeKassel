#código pantalla de lose
extends Control

@onready var try_again: Button = %retry
@onready var main_menu: Button = %main
@onready var character_p: CharacterBody2D = $"../../CharacterP"
signal hola

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	CoinLabelManager.player_lost.connect(_on_player_lost)
	try_again.pressed.connect(_on_try_again_pressed)
	main_menu.pressed.connect(_on_main_menu_pressed)
	character_p.murio.connect(_on_player_lost)

func _on_player_lost() -> void:
	await get_tree().create_timer(1.5).timeout
	show()
	get_tree().paused = true

func _on_try_again_pressed() -> void:
	get_tree().paused = false
	CoinLabelManager.coins = 0
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	hola.emit()
	LevelManager.main_menu()
	
