extends Control

@onready var credits_text: RichTextLabel = $CreditsText

func _ready() -> void:
	AudioManager.reproducir_musica(AudioManager.EstadoMusica.MENU)
	credits_text.get_v_scroll_bar().modulate.a = 0.0
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		LevelManager.main_menu()
