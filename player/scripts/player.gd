class_name Player extends CharacterBody2D

var cardinal : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const speed : float = 100
var state : String = "ocioso"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	direction.y = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	direction.x = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	
	velocity = direction * speed
	
	pass

func _physics_process(delta):
	move_and_slide()

func DefineDirecao() -> bool:
	return true

func DefineEstado() -> bool:
	return true

func AtualizaAnimacao() -> void:
	animation_player.play("cima")
	pass

func DirecaoAnimacao() -> String:
	if cardinal == Vector2.DOWN: return "baixo"
	if cardinal == Vector2.UP: return "cima"
	else
