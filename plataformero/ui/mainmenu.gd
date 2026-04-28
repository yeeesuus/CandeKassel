extends Control
@onready var inicio: Button = %inicio
@onready var creditos: Button = %creditos
@onready var salir: Button = %salir
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inicio.pressed.connect(_on_start_pressed)
	salir.pressed.connect(_on_quit_pressed)
	creditos.pressed.connect(_on_credits_pressed)

func _on_start_pressed() -> void:
	LevelManager.start()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_credits_pressed() -> void:
	LevelManager.credits()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
