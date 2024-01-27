class_name CookCBN
extends CardBehaviorNode

var referenced_node : CardBehaviorNodeInstance

func _init() -> void:
	super(
		[
			CardBehaviorArgument.bool("cook"), 
		], 
		[]
	)

func process(api : CardBehaviorAPI, _inputs : Array) -> Array:
	var cook : bool = _inputs[0]
	if cook:
		api.get_behavior_processor().append_to_cook_stack(referenced_node) 
	return []