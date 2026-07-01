extends Camera2D
var y_fija: float
@onready var character_p: CharacterBody2D = $"../CharacterP"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	y_fija = global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if character_p:
		global_position = Vector2(character_p.global_position.x, y_fija)
