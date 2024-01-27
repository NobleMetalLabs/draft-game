class_name CardBehaviorNodeInstance
extends Resource

var node_logic : CardBehaviorNode
var inputs : Array[CardBehaviorNodeInstance]
var outputs : Array[CardBehaviorNodeInstance]

func process(api : CardBehaviorAPI, input : Array) -> Array:
	return node_logic.process(api, input)