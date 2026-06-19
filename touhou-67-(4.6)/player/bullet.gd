extends HitboxComponent

@export var speed = 600
@onready var timer: Timer = $Timer

func _ready() -> void:
	add_to_group("player_bullets") #agregado ahora
	timer.timeout.connect(func():queue_free())
	
func _physics_process(delta: float) -> void:
	var direction = -global_transform.y
	global_position += direction * speed * delta
