class_name Estado_Idle extends Estado

@onready var andar: Estado = $"../Andar"

func Enter() -> void:
	player.AtualizaAnimacao("idle")
	pass

func Exit() -> void:
	pass

func Process(_delta: float) -> Estado:
	if player.direction != Vector2.ZERO:
		return andar
	player.velocity = Vector2.ZERO
	return null
	
func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	return null
