extends Area2D

var velocidade_projetil : float = 700
var direction: Vector2

func _process(delta):
	if direction:
		Direcao()
		position += direction * velocidade_projetil * delta

func _physics_process(delta: float) -> void:
	position += direction * velocidade_projetil*delta

#func _on_screen_exited() -> void:
	#queue_free()

func Direcao() -> void:
	var ang = atan2(direction.y,direction.x)
	if abs(ang) > 1.571: ang = -ang + 3.14 
	rotation = ang


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Inimigo"):
		queue_free()
