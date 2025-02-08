class_name Player extends CharacterBody2D

var cardinal : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
const dash_speed : float = 1400


var dash : bool = false
var pode_dash: bool = true

@onready var sprite: Sprite2D = $SpriteJogador
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_dash: Sprite2D = $SpriteJogador/SpriteDash
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var maquina_estados: maquinaEstadosJogador = $MaquinaEstados


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maquina_estados.Inicializar(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#direction.y = Input.get_action_strength("baixo") - Input.get_action_strength("cima")
	#direction.x = Input.get_action_strength("direita") - Input.get_action_strength("esquerda")
	direction = Vector2(
		Input.get_axis("esquerda","direita"),
		Input.get_axis("cima","baixo")
	).normalized()
	
	
	
	#if Input.get_action_strength("dash") and pode_dash:
		#dash = true
		#$Timer_dash_duracao.start()
		#$Timer_dash_cooldown.start()
	#
	#DirecaoDash()
	#if dash:
		#sprite_dash.visible = true
		#velocity = direction.normalized() * dash_speed
		#pode_dash = false
	#else:
		#sprite_dash.visible = false
	#pass

func _physics_process(delta):
	move_and_slide()


func AtualizaAnimacao(state) -> void:
	animation_player.play(state)
	pass
	
func DirecaoPersonagem() -> bool:
	if direction == Vector2.ZERO: return false
	if direction.x < 0:
		sprite.scale.x = -1
		collision_shape_2d.position.x = 7.5
	elif direction.x > 0:
		sprite.scale.x = 1
		collision_shape_2d.position.x = -7.5
	return true
		
func DirecaoDash() -> void:
	var ang = atan2(direction.y,direction.x)
	if abs(ang) > 1.571: ang = -ang + 3.14 
	sprite_dash.rotation = ang

func _on_timer_dash_duracao_timeout() -> void:
	dash = false

func _on_timer_dash_cooldown_timeout() -> void:
	pode_dash = true
