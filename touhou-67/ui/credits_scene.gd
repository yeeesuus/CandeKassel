extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		LevelManager.main_menu()

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
