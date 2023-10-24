extends Control

@onready var display_text: Label = get_node("BackGround/Display/Label")

var numero_1: String
var numero_2: String
var operador: String = ""
var index_numero_atual: int = 0

func _ready() -> void:
	display_text.text = "0"
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(quando_o_botao_for_precionado.bind(button.name))


func quando_o_botao_for_precionado(nome_do_botao: String) -> void:
	
	match nome_do_botao:
		"Sum":
			change_operator("+")
			
		"Mul":
			change_operator("*")
		
		"Div":
			change_operator("/")
			
		"Sub":
			change_operator("-")
			
		"=":
			var valor1: int = int(numero_1)
			var valor2: int = int(numero_2)
			var result: int = 0
			match operador:
				
				"+":
					result = valor1 + valor2
				
				"-":
					result = valor1 - valor2
				
				"/":
					@warning_ignore("integer_division")
					result = valor1 / valor2
					
				"*":
					result = valor1 * valor2
				
			display_text.text = str(result)
			reset()
		
		"Reset":
			reset(true)
			
		_:
			if index_numero_atual == 0:
				numero_1 += nome_do_botao
				if operador == "":
					display_text.text = numero_1
					
				
			if index_numero_atual == 1:
				numero_2 += nome_do_botao
				display_text.text = numero_1 + " " + operador + " " + numero_2


func change_operator(sig: String) -> void:
	if numero_1 == "" or operador != "":
		return
	operador = sig
	index_numero_atual = 1
	display_text.text = numero_1 + " " + operador


func reset(is_reseting: bool = false) -> void:
	numero_1 = ""
	numero_2 = ""
	operador = ""
	index_numero_atual = 0
	
	if is_reseting:
		display_text.text = "0"
