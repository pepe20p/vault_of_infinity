class_name Estado_Andar extends Estado

@export var velocidade_movimento : float = 100.0
@onready var idle: Estado = $"../Idle"
@onready var dash: Estado = $"../Dash"
@onready var atacar: Estado_Atacar = $"../Atacar"

var pode_dash: bool = true

func Enter() -> void:
	player.AtualizaAnimacao("andar")
	pass

func Exit() -> void:
	player.animation_player.stop()
	pass

func Process(_delta: float) -> Estado:
	if player.direction == Vector2.ZERO:
		return idle
	andar()
	
	if player.DirecaoPersonagem():
		player.AtualizaAnimacao("andar")
	
	return null
	
func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	if _event.is_action_pressed("dash") && pode_dash:
		pode_dash = false
		$Timer_dash_cooldown.start()
		return dash
	if _event.is_action_pressed("atacar"):
		return atacar
	return null

func _on_timer_dash_cooldown_timeout() -> void:
	pode_dash = true
	
func andar() -> void:
	player.velocity = player.direction * velocidade_movimento
