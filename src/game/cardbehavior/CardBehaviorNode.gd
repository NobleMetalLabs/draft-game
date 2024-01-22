class_name CardBehaviorNode
extends Resource

var inputs : Array[CardBehaviorArgument]
var outputs : Array[CardBehaviorArgument]

var api : CardBehavoirAPI

func _init(_api : CardBehavoirAPI, _inputs : Array[CardBehaviorArgument], _outputs : Array[CardBehaviorArgument]) -> void:
	api = _api
	inputs = _inputs
	outputs = _outputs

func process(_inputs : Array) -> Array:
	push_error("Error: Class extending CardBehaviorNode does not implement process()")
	return []