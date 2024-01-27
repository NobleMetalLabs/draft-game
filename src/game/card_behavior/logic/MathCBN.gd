class_name MathCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.variant("num1",
				[
					"int",
					"float",
				]
			), 
			CardBehaviorArgument.variant("num2",
				[
					"int",
					"float",
				]
			),
			CardBehaviorArgument.string_name_options("operation",
				[
					"add", 
					"subtract", 
					"multiply", 
					"divide", 
					"modulo",
					"power",
				]
			),
		], 
		[
			CardBehaviorArgument.variant("result",
				[
					"int",
					"float",
				]
			)
		]
	)

func process(_api : CardBehaviorAPI, inputs : Array) -> Array:
	var num1 : Variant = inputs[0]
	var num2 : Variant = inputs[1]
	var operation : StringName = inputs[2]
	match operation:
		"add":
			return [num1 + num2]
		"subtract":
			return [num1 - num2]
		"multiply":
			return [num1 * num2]
		"divide":
			return [num1 / num2]
		"modulo":
			if typeof(num1) == TYPE_FLOAT: return []
			if typeof(num2) == TYPE_FLOAT: return []
			return [num1 % num2]
		"power":
			if typeof(num1) == TYPE_FLOAT: return []
			if typeof(num2) == TYPE_FLOAT: return []
			return [num1 ^ num2]
	return []