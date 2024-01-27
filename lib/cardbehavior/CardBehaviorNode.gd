class_name CardBehaviorNode
extends Resource

var input_args : Array[CardBehaviorArgument]
var output_args : Array[CardBehaviorArgument]

func _init(_inputs : Array[CardBehaviorArgument], _outputs : Array[CardBehaviorArgument]) -> void:
	input_args = _inputs
	output_args = _outputs

func process(_api : CardBehaviorAPI, _inputs : Array) -> Array:
	push_error("Error: Class extending CardBehaviorNode does not implement process()")
	return []