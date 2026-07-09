extends Node2D

func _ready() -> void:
	AudioManager.reproducir_musica(AudioManager.EstadoMusica.JUEGO)
	
# Función para reiniciar nivel (Tecla "R")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("retry"):
		get_tree().reload_current_scene()
