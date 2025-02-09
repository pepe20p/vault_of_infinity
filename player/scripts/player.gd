class_name Player extends CharacterBody2D

var cardinal : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var sprite: Sprite2D = $SpriteJogador
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_dash: Sprite2D = $SpriteJogador/SpriteDash
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var maquina_estados: maquinaEstadosJogador = $MaquinaEstados

@export var bullet_scene: PackedScene  # Cena da bala
@export var attack_rate: float = 1.0  # Tempo entre os disparos
var target: Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maquina_estados.Inicializar(self)
	$Arco/Area2D.body_entered.connect(_inimigo_entrou)
	$Arco/Area2D.body_exited.connect(_inimigo_saiu)
	$Arco/Cadencia_Ataque.timeout.connect(_on_cadencia_ataque_timeout)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("esquerda","direita"),
		Input.get_axis("cima","baixo")
	).normalized()

func _physics_process(delta):
	move_and_slide()


func AtualizaAnimacao(state) -> void:
	#animation_player.play(state)
	animation_player.queue(state)
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
	
func _inimigo_entrou(body)-> void:
	if body.is_in_group("Inimigo"):
		print("Inimigo entrou")
		target = body
		$Arco/Cadencia_Ataque.start()
		
func _inimigo_saiu(body)-> void:
	if body == target:
		target = null
		$Arco/Cadencia_Ataque.stop()
		
func pode_atirar() -> bool:
	if !target: return false
	var ray = $Arco/RayCast2D
	ray.target_position = target.global_position - global_position
	ray.force_raycast_update()
	if ray.is_colliding():
		var hit_object = ray.get_collider()
		return hit_object == target
	return false
	
func atira() -> void:
	var projetil = bullet_scene.instantiate()
	projetil.global_position = $Arco.global_position
	projetil.direction = (target.global_position - global_position).normalized()
	get_tree().current_scene.add_child(projetil)

func _on_cadencia_ataque_timeout() -> void:
	if target and pode_atirar():
		animation_player.play("atacar")
		#await animation_player.animation_finished
		atira()
		
