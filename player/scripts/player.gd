class_name Player extends CharacterBody2D

var cardinal : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const speed : float = 500
const dash_speed : float = 1700


var state : String = "idle"
var dash : bool = false
var pode_dash: bool = true

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	direction.y = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	direction.x = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	
	if Input.get_action_strength("dash") and pode_dash:
		dash = true
		$Timer_dash_duracao.start()
		$Timer_dash_cooldown.start()
	
	if dash:
		velocity = direction.normalized() * dash_speed
		pode_dash = false
	else:
		velocity = direction.normalized() * speed
		
	if DefineEstado() || DefineDirecao(): 
		AtualizaAnimacao()
	pass

func _physics_process(delta):
	move_and_slide()

func DefineDirecao() -> bool:
	var nova_dir : Vector2 = cardinal
	if direction == Vector2.ZERO:
		return false
	if direction.x == 0:
		nova_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	if direction.y == 0:
		nova_dir = Vector2.LEFT if direction.x < 0  else Vector2.RIGHT
	if nova_dir == cardinal:
		return false
	cardinal = nova_dir
	sprite.scale.x = -1 if cardinal == Vector2.LEFT else 1
	return true

func DefineEstado() -> bool:
	var novo_estado : String = "idle" if direction == Vector2.ZERO else "andar"
	if novo_estado == state:
		return false
	state = novo_estado
	return true

func AtualizaAnimacao() -> void:
	#print(DirecaoAnimacao())
	animation_player.play(state)
	pass

func _on_timer_dash_duracao_timeout() -> void:
	dash = false

func _on_timer_dash_cooldown_timeout() -> void:
	pode_dash = true
