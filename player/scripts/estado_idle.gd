class_name Estado_Idle extends Estado

@onready var andar: Estado = $"../Andar"
@onready var atacar: Estado_Atacar = $"../Atacar"

func Enter() -> void:
	player.AtualizaAnimacao("idle")
	pass

func Exit() -> void:
	player.animation_player.stop()
	pass

func Process(_delta: float) -> Estado:
	if player.direction != Vector2.ZERO:
		return andar
	player.velocity = Vector2.ZERO
	return null
	
func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	if _event.is_action_pressed("atacar"):
		return atacar
	return null
