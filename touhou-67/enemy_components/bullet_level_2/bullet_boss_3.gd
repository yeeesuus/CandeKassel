extends HitboxComponent

@onready var timer: Timer = $Timer
@export var speed = 600
var delta_acc = 0
var fase = 0
var velocidad_actual = speed
var des_acc = 900

func _ready() -> void:
	timer.timeout.connect(func():queue_free())
	
func _physics_process(delta: float) -> void:
	#es acá donde se cambia el patrón
	velocidad_actual -= des_acc*delta
	#delta_acc += delta*5
	var direction =- global_transform.y
	global_position += direction * speed * delta
	global_position+=direction * velocidad_actual * delta
