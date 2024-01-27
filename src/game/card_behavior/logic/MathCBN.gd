class_name MathCBN
extends CardBehaviorNode

func _init() -> void:
	super(
		[
			CardBehaviorArgument.int("num1"), 
			CardBehaviorArgument.int("num2"),
			CardBehaviorArgument.string_name("operation"),
		], 
		[
			CardBehaviorArgument.int("result")
		]
	)

# func process(api : CardBehaviorAPI, inputs : Array) -> Array:
	#return []