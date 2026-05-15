extends Node2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	print("hola")
	if body is CharacterBody2D:
		LevelManager.next_level()
	
