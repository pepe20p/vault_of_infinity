class_name Estado_Dash extends Estado

@onready var andar: Estado = $"../Andar"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var animation_dash: AnimationPlayer = $"../../SpriteJogador/SpriteDash/AnimationDash"
@export var audio_dash : AudioStream
@export var dash_speed : float = 1400
var dash : bool = false

func Enter() -> void:
	player.DirecaoDash()
	$Timer_dash_duracao.start()
	animation_dash.play("dash")
	audio.stream = audio_dash
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	dash = true 
	pass

func Exit() -> void:
	#animation_dash.stop()
	pass

func Process(_delta: float) -> Estado:
	if !dash : return andar
	player.velocity = player.direction * dash_speed
	return null
	
	
func Physics(_delta: float) -> Estado:
	return null

func HandleInput(_event: InputEvent) -> Estado:
	return null
	
func _on_timer_dash_duracao_timeout() -> void:
	dash = false
