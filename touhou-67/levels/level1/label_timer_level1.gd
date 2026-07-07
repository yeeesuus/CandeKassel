extends Label

@export var mov: int = 45

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y -= mov * delta 
