extends Label

@export var mov: int = 90

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y -= mov * delta 
