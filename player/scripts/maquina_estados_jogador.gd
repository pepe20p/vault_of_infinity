class_name maquinaEstadosJogador extends Node

var estados : Array[Estado]
var estado_ant : Estado
var estado_atual: Estado


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	TrocaEstado(estado_atual.Process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	TrocaEstado(estado_atual.Physics(delta))
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	TrocaEstado(estado_atual.HandleInput(event))
	pass

func Inicializar(_player : Player) -> void:
	estados = []
	for c in get_children():
		if c is Estado:
			estados.append(c)
	if estados.size() > 0:
		estados[0].player = _player
		TrocaEstado(estados[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func TrocaEstado(novo_estado : Estado) -> void:
	if novo_estado == null || novo_estado == estado_atual: return
	
	if estado_atual:
		estado_atual.Exit()
		
	estado_ant = estado_atual
	estado_atual = novo_estado
	estado_atual.Enter()
