class_name Player extends CharacterBody2D

var cardinal : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const speed : float = 500
const dash_speed : float = 1400


var state : String = "idle"
var dash : bool = false
var pode_dash: bool = true

@onready var sprite: Sprite2D = $SpriteJogador
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_dash: Sprite2D = $SpriteJogador/SpriteDash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	direction.y = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	direction.x = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	DirecaoPersonagem()
	if Input.get_action_strength("dash") and pode_dash:
		dash = true
		$Timer_dash_duracao.start()
		$Timer_dash_cooldown.start()
	
	DirecaoDash()
	if dash:
		sprite_dash.visible = true
		velocity = direction.normalized() * dash_speed
		pode_dash = false
	else:
		sprite_dash.visible = false
		velocity = direction.normalized() * speed
	if DefineEstado():
		AtualizaAnimacao()
	pass

func _physics_process(delta):
	move_and_slide()

func DefineEstado() -> bool:
	var novo_estado : String = "idle" if direction == Vector2.ZERO else "dash"
	if novo_estado == state:
		return false
	state = novo_estado
	return true

func AtualizaAnimacao() -> void:
	animation_player.play(state)
	pass
	
func DirecaoPersonagem() -> void:
	if direction.x < 0:
		sprite.scale.x = -1
	elif direction.x > 0:
		sprite.scale.x = 1
		
func DirecaoDash() -> void:
	var ang = atan2(direction.y,direction.x)
	if abs(ang) > 1.571: ang = -ang + 3.14 
	sprite_dash.rotation = ang

func _on_timer_dash_duracao_timeout() -> void:
	dash = false

func _on_timer_dash_cooldown_timeout() -> void:
	pode_dash = true
