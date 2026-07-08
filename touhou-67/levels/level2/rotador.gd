extends Node2D
var eleccion = [-1, 1].pick_random()
var vel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer2: Timer = Timer.new()
	add_child(timer2)
	timer2.wait_time = 2.0
	timer2.one_shot = true
	timer2.timeout.connect(_on_timer_off)
	timer2.start()

func _on_timer_off() -> void:
	vel = 200*eleccion
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += vel * delta
	
	#tamaño de la pantalla
	var screen_size = get_viewport_rect().size
	
	#rebote horizontal
	if position.x <= 280:
		position.x = 280
		vel *= -1
		
	elif position.x > screen_size.x - 280:
		position.x = screen_size.x - 280
		vel *= -1
