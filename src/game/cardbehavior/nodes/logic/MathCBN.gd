class_name MathCBN
extends CardBehaviorNode

func _init(_api : CardBehavoirAPI) -> void:
	super(_api,
		[
			CardBehaviorArgument.int("num1"), 
			CardBehaviorArgument.int("num2"),
			CardBehaviorArgument.string_name("operation"),
		], 
		[
			CardBehaviorArgument.int("result")
		]
	)

# func process(inputs : Array) -> Array:
	#return []