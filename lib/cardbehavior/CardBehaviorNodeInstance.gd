class_name CardBehaviorNodeInstance
extends Resource

var node_logic : CardBehaviorNode
var inputs : Array[CardBehaviorNodeInstance]
var outputs : Array[CardBehaviorNodeInstance]

var cached_output : Array

func fetch() -> Array:
	return cached_output

func process(input : Array) -> Array:
	cached_output = node_logic.process(input)
	return cached_output