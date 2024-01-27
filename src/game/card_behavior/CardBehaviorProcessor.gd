class_name CardBehaviorProcessor
extends Object

var api : CardBehaviorAPI

func _init(_cards : Array[CardInstance]) -> void:
	api = CardBehaviorAPI.new()
	for card in _cards:
		_process_card(card)

func _process_card(card : CardInstance) -> void:
	var card_behavior : CardBehaviorGraph = card.metadata.behavior
	cook_stack = card_behavior.get_initial_cook_stack()
	for node in cook_stack:
		_process_node(node)

var cook_stack : Array[CardBehaviorNodeInstance] = []

func _process_node(node : CardBehaviorNodeInstance) -> Array:
	var inputs : Array = []
	for input_node in node.inputs:
		var input_outputs : Array = _process_node(input_node)
		var input_output_index : int = input_node.outputs.find(node)
		inputs.append(input_outputs[input_output_index])
	return node.process(api, inputs)

func append_to_cook_stack(node : CardBehaviorNodeInstance) -> void:
	cook_stack.append(node)