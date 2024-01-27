@icon("res://lib/cardbehavior/CardBehaviorGraph.png")
class_name CardBehaviorGraph
extends Resource

var description : String = ""
var nodes : Array[CardBehaviorNodeInstance] = []

func get_initial_cook_stack() -> Array[CardBehaviorNodeInstance]:
	var stack : Array[CardBehaviorNodeInstance] = []
	for node in nodes:
		if node.node_logic is CookCBN:
			stack.append(node)
	return stack
