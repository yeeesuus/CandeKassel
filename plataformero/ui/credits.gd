extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pausa"):
		LevelManager.main_menu()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(meta)
