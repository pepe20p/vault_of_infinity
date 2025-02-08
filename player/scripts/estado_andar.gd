class_name Estado_Andar extends Estado

@export var velocidade_movimento : float = 100.0
@onready var idle: Estado = $"../Idle"

func Enter() -> void:
	player.AtualizaAnimacao("andar")
	pass

func Exit() -> void:
	pass

func Process(_delta: float) -> Estado:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * velocidade_movimento
	
	if player.DirecaoPersonagem():
		player.AtualizaAnimacao("andar")
	
	return null
	
func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	return null
