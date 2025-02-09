class_name Estado_Atacar extends Estado

@onready var andar: Estado = $"../Andar"
@onready var idle: Estado_Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var atacando : bool = false

func Enter() -> void:
	player.AtualizaAnimacao("atacar")
	animation_player.animation_finished.connect(FimAtaque)
	atacando = true
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect(FimAtaque)
	pass

func Process(_delta: float) -> Estado:
	if player.direction == Vector2.ZERO:
		return idle
	return andar

func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	return null
	
func FimAtaque(_novaAnimacao : String) -> void:
	atacando = false
