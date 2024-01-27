class_name OperationCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.bool("num1"), 
			CardBehaviorArgument.bool("num2"),
			CardBehaviorArgument.string_name_options("operation",
				[
					"not",
					"and",
					"or",
					"xor",
				]
			),
		], 
		[
			CardBehaviorArgument.bool("result")
		]
	)

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	match inputs[2]:
		"not":
			return [not inputs[0]]
		"and":
			return [inputs[0] and inputs[1]]
		"or":
			return [inputs[0] or inputs[1]]
		"xor":
			return [inputs[0] == inputs[1]]
	return []
