class_name CompareCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.bool("a"), 
			CardBehaviorArgument.bool("b"),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	return inputs[0] == inputs[1]