extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reiniciar"):
		get_tree().reload_current_scene()
		
func show_screen() -> void:
	show()
	
func hidden_screen() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
