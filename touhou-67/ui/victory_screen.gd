extends Control

#@onready var start_again: Button = %StartAgain
#@onready var credits: Button = %Credits
#@onready var main_menu: Button = %"Main_Menu"
var aparecer = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	CoinLabelManager.player_won.connect(_on_player_won)
	#start_again.pressed.connect(_on_start_again_pressed)
	#credits.pressed.connect(_on_credits_pressed)
	#main_menu.pressed.connect(_on_main_menu_pressed)

func _on_player_won() -> void:
	await get_tree().create_timer(0.25).timeout
	show()
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		get_tree().paused = false
		LevelManager.main_menu()
	
func _on_start_again_pressed() -> void:
	get_tree().paused = false
	CoinLabelManager.coins = 0
	get_tree().reload_current_scene()

func _on_credits_pressed() -> void:
	get_tree().paused = false
	LevelManager.credits()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().credits()
